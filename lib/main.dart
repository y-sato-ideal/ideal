import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR scaner And QR Maker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'QR scaner And QR Maker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String barcode = '';

  /// QRスキャン開始、結果取得
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan() as String;
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'ユーザーがカメラの許可を与えていません！';
        });
      } else {
        setState(() => this.barcode = '不明なエラー: $e');
      }
    } on FormatException{
      setState(() => this.barcode = '読み取りできませんでした');
    } catch (e) {
      setState(() => this.barcode = '読み取りできませんでした: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              color: Colors.blueAccent,
              child: Text('QR読み取り', style: TextStyle(color: Colors.white),),
              onPressed: scan,
            ),
            Text(barcode)
          ],
        ),
      ),
    );
  }
}