import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_notification/second_page.dart';

class ThirdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ThirdState();
  }
}

class _ThirdState extends State<ThirdPage> {
  final notifications = FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();

    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
    _showNotification(notifications, title: 'Tite', body: 'Body');
  }

  Future onSelectNotification(String payload) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondPage(payload: payload)),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Third Page"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text('Show notification on init'),
          ),
        ),
      );

  Future _showNotification(
    FlutterLocalNotificationsPlugin notifications, {
    @required String title,
    @required String body,
    int id = 0,
  }) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      'your channel description',
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await notifications.show(id, title, body, platformChannelSpecifics);
  }
}
