import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/components/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  static String id = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: kTagLogo,
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              // keyboard type for easy to enter email
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              style: TextStyle(
                color: Colors.grey[700],
              ),
              decoration: kTextFieldDecoration.copyWith(
                hintText: "Enter your email",
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              style: TextStyle(
                color: Colors.grey[700],
              ),
              decoration: kTextFieldDecoration.copyWith(
                hintText: "Enter your password",
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              text: "Log In",
              color: Colors.lightBlueAccent,
              onPressed: () async {
                try {
                  final loggedInUser = await _auth.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  if (loggedInUser.user != null) {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                } catch (e) {
                  print("failed to sign in: $e");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
