Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUHYOal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUHYOal (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265795AbUHYOal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:30:41 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:31943 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S266193AbUHYO3m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:29:42 -0400
Date: Wed, 25 Aug 2004 16:29:40 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] vsxx-aa: "DB9" plugs are called "DE9", really!
Message-ID: <20040825142940.GB18334@lug-owl.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gLcqQrOcczDba7nC"
Content-Disposition: inline
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gLcqQrOcczDba7nC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus!

Please apply this patch. It corrects the the wrong use of "DB9" to the
correct name, "DE9". Also, some comments/debugging output is fixed up.

Signed-Off-By: Jan-Benedict Glaw <jbglaw@lug-owl.de>

--- linux-2.6.9-rc1-bk1/drivers/input/mouse/vsxxxaa.c~	2004-08-25 16:07:11.=
000000000 +0200
+++ linux-2.6.9-rc1-bk1/drivers/input/mouse/vsxxxaa.c	2004-08-25 16:07:34.0=
00000000 +0200
@@ -1,11 +1,14 @@
 /*
- * DEC VSXXX-AA and VSXXX-GA mouse driver.
+ * Driver for	DEC VSXXX-AA mouse (hockey-puck mouse, ball or two rollers)
+ * 		DEC VSXXX-GA mouse (rectangular mouse, with ball)
+ * 		DEC VSXXX-AB tablet (digitizer with hair cross or stylus)
  *
  * Copyright (C) 2003-2004 by Jan-Benedict Glaw <jbglaw@lug-owl.de>
  *
- * The packet format was taken from a patch to GPM which is (C) 2001
+ * The packet format was initially taken from a patch to GPM which is (C) =
2001
  * by	Karsten Merker <merker@linuxtag.org>
  * and	Maciej W. Rozycki <macro@ds2.pg.gda.pl>
+ * Later on, I had access to the device's documentation (referenced below).
  */
=20
 /*
@@ -25,7 +28,7 @@
  */
=20
 /*
- * Building an adaptor to DB9 / DB25 RS232
+ * Building an adaptor to DE9 / DB25 RS232
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *
  * DISCLAIMER: Use this description AT YOUR OWN RISK! I'll not pay for
@@ -43,7 +46,7 @@
  *   \  2 1  /
  *    -------
  *=20
- *	DEC socket	DB9	DB25	Note
+ *	DEC socket	DE9	DB25	Note
  *	1 (GND)		5	7	-
  *	2 (RxD)		2	3	-
  *	3 (TxD)		3	2	-
@@ -83,7 +86,7 @@
 #include <linux/init.h>
=20
 MODULE_AUTHOR ("Jan-Benedict Glaw <jbglaw@lug-owl.de>");
-MODULE_DESCRIPTION ("Serial DEC VSXXX-AA/GA mouse / DEC tablet driver");
+MODULE_DESCRIPTION ("Driver for DEC VSXXX-AA and -GA mice and VSXXX-AB tab=
let");
 MODULE_LICENSE ("GPL");
=20
 #undef VSXXXAA_DEBUG
@@ -102,7 +105,7 @@
 #define VSXXXAA_PACKET_REL	0x80
 #define VSXXXAA_PACKET_ABS	0xc0
 #define VSXXXAA_PACKET_POR	0xa0
-#define MATCH_PACKET_TYPE(data, type)	(((data) & VSXXXAA_PACKET_MASK) =3D=
=3D type)
+#define MATCH_PACKET_TYPE(data, type)	(((data) & VSXXXAA_PACKET_MASK) =3D=
=3D (type))
=20
=20
=20
@@ -148,7 +151,7 @@
 {
 	switch (mouse->type) {
 		case 0x02:
-			sprintf (mouse->name, "DEC VSXXX-AA/GA mouse");
+			sprintf (mouse->name, "DEC VSXXX-AA/-GA mouse");
 			break;
=20
 		case 0x04:
@@ -156,7 +159,8 @@
 			break;
=20
 		default:
-			sprintf (mouse->name, "unknown DEC pointer device");
+			sprintf (mouse->name, "unknown DEC pointer device "
+					"(type =3D 0x%02x)", mouse->type);
 			break;
 	}
=20
@@ -334,13 +338,10 @@
 	 *
 	 * M: manufacturer location code
 	 * R: revision code
-	 * E: Error code. I'm not sure about these, but gpm's sources,
-	 *    which support this mouse, too, tell about them:
-	 *	E =3D [0x00 .. 0x1f]: no error, byte #3 is button state
-	 *	E =3D 0x3d: button error, byte #3 tells which one.
-	 *	E =3D <else>: other error
+	 * E: Error code. If it's in the range of 0x00..0x1f, only some
+	 *    minor problem occured. Errors >=3D 0x20 are considered bad
+	 *    and the device may not work properly...
 	 * D: <0010> =3D=3D mouse, <0100> =3D=3D tablet
-	 *
 	 */
=20
 	mouse->version =3D buf[0] & 0x0f;
@@ -361,28 +362,32 @@
 	vsxxxaa_detection_done (mouse);
=20
 	if (error <=3D 0x1f) {
-		/* No error. Report buttons */
+		/* No (serious) error. Report buttons */
 		input_regs (dev, regs);
 		input_report_key (dev, BTN_LEFT, left);
 		input_report_key (dev, BTN_MIDDLE, middle);
 		input_report_key (dev, BTN_RIGHT, right);
 		input_report_key (dev, BTN_TOUCH, 0);
 		input_sync (dev);
-	} else {
-		printk (KERN_ERR "Your %s on %s reports an undefined error, "
-				"please check it...\n", mouse->name,
-				mouse->phys);
+
+		if (error !=3D 0)
+			printk (KERN_INFO "Your %s on %s reports error=3D0x%02x\n",
+					mouse->name, mouse->phys, error);
+
 	}
=20
 	/*
 	 * If the mouse was hot-plugged, we need to force differential mode
 	 * now... However, give it a second to recover from it's reset.
 	 */
-	printk (KERN_NOTICE "%s on %s: Forceing standard packet format and "
-			"streaming mode\n", mouse->name, mouse->phys);
-	mouse->serio->write (mouse->serio, 'S');
+	printk (KERN_NOTICE "%s on %s: Forceing standard packet format, "
+			"incremental streaming mode and 72 samples/sec\n",
+			mouse->name, mouse->phys);
+	mouse->serio->write (mouse->serio, 'S');	/* Standard format */
+	mdelay (50);
+	mouse->serio->write (mouse->serio, 'R');	/* Incremental */
 	mdelay (50);
-	mouse->serio->write (mouse->serio, 'R');
+	mouse->serio->write (mouse->serio, 'L');	/* 72 samples/sec */
 }
=20
 static void
@@ -517,7 +522,7 @@
 	mouse->dev.private =3D mouse;
 	serio->private =3D mouse;
=20
-	sprintf (mouse->name, "DEC VSXXX-AA/GA mouse or VSXXX-AB digitizer");
+	sprintf (mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer");
 	sprintf (mouse->phys, "%s/input0", serio->phys);
 	mouse->dev.name =3D mouse->name;
 	mouse->dev.phys =3D mouse->phys;
--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--gLcqQrOcczDba7nC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBLKJUHb1edYOZ4bsRAqUwAKCNqRV6x/h2ezjTg754ryr65GTEgwCfWS4E
WPpyAusHnQHHvLqICD2o7Gw=
=dKVb
-----END PGP SIGNATURE-----

--gLcqQrOcczDba7nC--
