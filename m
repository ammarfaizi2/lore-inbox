Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285093AbSA2Waf>; Tue, 29 Jan 2002 17:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285226AbSA2Wa1>; Tue, 29 Jan 2002 17:30:27 -0500
Received: from rain.CC.Lehigh.EDU ([128.180.39.20]:32715 "EHLO
	rain.CC.Lehigh.EDU") by vger.kernel.org with ESMTP
	id <S285060AbSA2W3D>; Tue, 29 Jan 2002 17:29:03 -0500
Date: Tue, 29 Jan 2002 17:28:23 -0500
To: rubini@vision.unipv.it
Cc: linux-kernel@vger.kernel.org
Subject: Small kernel patch for Logitech iTouch
Message-ID: <20020129222823.GA8154@schala>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: Mike Paul <mbp2@Lehigh.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The current discussion about dealing with patch integration in Linux has
reminded me of this little patch I wrote a few months back for my Logitech
iTouch cordless keyboard.  It's mainly to put an end to the "unknown scanco=
de"
messages that would appear on the console every few minutes and corrupt my
display, but while I was at it I added keycodes for the special-function
buttons on the keyboard too.

Here's the patch, and it's a pretty straightforward one.  It should apply
cleanly to 2.4.17.

--- linux/drivers/char/pc_keyb.c	Fri Mar  2 21:38:37 2001
+++ linux-logitech/drivers/char/pc_keyb.c	Mon Oct  8 22:40:56 2001
@@ -223,22 +223,46 @@
 #define E0_MSLW	125
 #define E0_MSRW	126
 #define E0_MSTM	127
+/*
+ * Extra buttons on the Logitech Cordless iTouch
+ *
+ * Note that the Sleep button generates both a press and release event when
+ * pressed, and ignores subsequent presses until about 4 seconds after the=
 last
+ * time it was pressed.
+ */
+/* Power-management */
+#define E0_SLEEP  112
+/* Audio controls */
+#define E0_MUTE   113
+#define E0_VOLDN  114
+#define E0_VOLUP  115
+#define E0_PLAY   116
+#define E0_STOP   117
+#define E0_PREV   120
+#define E0_NEXT   121
+/* Internet keys */
+#define E0_EMAIL  122
+#define E0_SEARCH 123
+#define E0_RUN    124
+#define E0_HOMEPG 125
+/* Sent every few minutes for no apparent reason */
+#define E1_PING   126
=20
 static unsigned char e0_keys[128] =3D {
   0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x00-0x07 */
   0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x08-0x0f */
-  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x10-0x17 */
-  0, 0, 0, 0, E0_KPENTER, E0_RCTRL, 0, 0,	      /* 0x18-0x1f */
-  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x20-0x27 */
-  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x28-0x2f */
-  0, 0, 0, 0, 0, E0_KPSLASH, 0, E0_PRSCR,	      /* 0x30-0x37 */
+  E0_PREV, 0, 0, 0, 0, 0, 0, 0,			      /* 0x10-0x17 */
+  E0_MUTE, E0_NEXT, 0, 0, E0_KPENTER, E0_RCTRL, 0, 0, /* 0x18-0x1f */
+  0, 0, E0_PLAY, 0, E0_STOP, 0, 0, 0,		      /* 0x20-0x27 */
+  0, 0, 0, 0, 0, 0, E0_VOLDN, 0,		      /* 0x28-0x2f */
+  E0_VOLUP, 0, E0_HOMEPG, 0, 0, E0_KPSLASH, 0, E0_PRSCR, /* 0x30-0x37 */
   E0_RALT, 0, 0, 0, 0, E0_F13, E0_F14, E0_HELP,	      /* 0x38-0x3f */
   E0_DO, E0_F17, 0, 0, 0, 0, E0_BREAK, E0_HOME,	      /* 0x40-0x47 */
   E0_UP, E0_PGUP, 0, E0_LEFT, E0_OK, E0_RIGHT, E0_KPMINPLUS, E0_END,/* 0x4=
8-0x4f */
   E0_DOWN, E0_PGDN, E0_INS, E0_DEL, 0, 0, 0, 0,	      /* 0x50-0x57 */
-  0, 0, 0, E0_MSLW, E0_MSRW, E0_MSTM, 0, 0,	      /* 0x58-0x5f */
-  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x60-0x67 */
-  0, 0, 0, 0, 0, 0, 0, E0_MACRO,		      /* 0x68-0x6f */
+  0, 0, 0, E0_MSLW, E0_MSRW, E0_MSTM, 0, E0_SLEEP,    /* 0x58-0x5f */
+  0, 0, 0, 0, 0, E0_SEARCH, E0_RUN, 0,		      /* 0x60-0x67 */
+  0, 0, 0, 0, E0_EMAIL, 0, 0, E0_MACRO,		      /* 0x68-0x6f */
   0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x70-0x77 */
   0, 0, 0, 0, 0, 0, 0, 0			      /* 0x78-0x7f */
 };
@@ -311,6 +335,10 @@
 	  /*
 	   * usually it will be 0xe0, but a Pause key generates
 	   * e1 1d 45 e1 9d c5 when pressed, and nothing when released
+	   *
+	   * The Logitech Cordless iTouch generates e1 5c every few minutes for
+	   * no apparent reason.  It might have something to do with reporting
+	   * battery status, but I don't know.
 	   */
 	  if (prev_scancode !=3D 0xe0) {
 	      if (prev_scancode =3D=3D 0xe1 && scancode =3D=3D 0x1d) {
@@ -318,6 +346,9 @@
 		  return 0;
 	      } else if (prev_scancode =3D=3D 0x100 && scancode =3D=3D 0x45) {
 		  *keycode =3D E1_PAUSE;
+		  prev_scancode =3D 0;
+	      } else if (prev_scancode =3D=3D 0xe1 && scancode =3D=3D 0x5c) {
+		  *keycode =3D E1_PING;
 		  prev_scancode =3D 0;
 	      } else {
 #ifdef KBD_REPORT_UNKN

--=20

Mike Paul
mbp2@lehigh.edu
http://www.lehigh.edu/~mbp2/

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8VyIH3SZkqUhyWy4RAgZ0AJ9uS/Jd+Sm+Sdps7JBrOcHH9FtRqgCgjT0q
g7YCWjuTawKtJciy0Cx9IPc=
=FB9y
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
