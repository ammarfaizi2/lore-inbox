Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbSLVLMj>; Sun, 22 Dec 2002 06:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbSLVLMj>; Sun, 22 Dec 2002 06:12:39 -0500
Received: from mx1.visp.co.nz ([210.55.24.20]:58894 "EHLO mail.visp.co.nz")
	by vger.kernel.org with ESMTP id <S265058AbSLVLMh>;
	Sun, 22 Dec 2002 06:12:37 -0500
Subject: [PATCH 2.5] [TRIVIAL] USB Joypad quirk
From: mdew <mdew@orcon.net.nz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: "torvalds@transmeta.com" <torvalds@transmeta.com>,
       Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>
Content-Type: multipart/mixed; boundary="=-jkKUwvSskuU8ZglcuCE6"
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Dec 2002 00:20:30 +1300
Message-Id: <1040556042.9822.17.camel@nirvana>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jkKUwvSskuU8ZglcuCE6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Orginally from Vojtech Pavlik (16th June 2002 via email), to fix my
'broken' USB joypad, Fully tested in both 2.4.x and 2.5.52 (and
2.5.52-bk).

-mdew



diff -Naur a/drivers/usb/input/hid-core.c
mdew/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	2002-11-28 11:36:04.000000000 +1300
+++ mdew/drivers/usb/input/hid-core.c	2002-12-22 23:37:51.000000000
+1300
@@ -1317,6 +1317,9 @@
 #define USB_DEVICE_ID_ATEN_2PORTKVM    0x2204
 #define USB_DEVICE_ID_ATEN_4PORTKVM    0x2205
 
+#define USB_VENDOR_ID_TOPMAX           0x0663
+#define USB_DEVICE_ID_TOPMAX_COBRAPAD  0x0103
+
 #define USB_VENDOR_ID_MGE              0x0463
 #define USB_DEVICE_ID_MGE_UPS          0xffff
 #define USB_DEVICE_ID_MGE_UPS1         0x0001
@@ -1355,6 +1358,7 @@
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_HIDDEV },
 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS1, HID_QUIRK_HIDDEV },
+	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD,
HID_QUIRK_BADPAD },
 	{ 0, 0 }
 };
 
diff -Naur a/drivers/usb/input/hid-input.c
mdew/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	2002-11-28 11:35:59.000000000 +1300
+++ mdew/drivers/usb/input/hid-input.c	2002-12-22 23:41:25.000000000
+1300
@@ -357,6 +357,11 @@
 		int a = field->logical_minimum;
 		int b = field->logical_maximum;
 
+		if ((device->quirks & HID_QUIRK_BADPAD) && (usage->code == ABS_X ||
usage->code == ABS_Y)) {
+			a = field->logical_minimum = 0;
+			b = field->logical_maximum = 255;
+		}
+		
 		input->absmin[usage->code] = a;
 		input->absmax[usage->code] = b;
 		input->absfuzz[usage->code] = (b - a) >> 8;
diff -Naur a/drivers/usb/input/hid.h mdew/drivers/usb/input/hid.h
--- a/drivers/usb/input/hid.h	2002-11-28 11:35:46.000000000 +1300
+++ mdew/drivers/usb/input/hid.h	2002-12-22 23:38:49.000000000 +1300
@@ -206,6 +206,7 @@
 #define HID_QUIRK_IGNORE	0x04
 #define HID_QUIRK_NOGET		0x08
 #define HID_QUIRK_HIDDEV	0x10
+#define HID_QUIRK_BADPAD        0x12
 
 /*
  * This is the global enviroment of the parser. This information is


--=-jkKUwvSskuU8ZglcuCE6
Content-Disposition: attachment; filename=hid_quirk_badpad-2.5.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=hid_quirk_badpad-2.5.diff; charset=ANSI_X3.4-1968

diff -Naur a/drivers/usb/input/hid-core.c mdew/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	2002-11-28 11:36:04.000000000 +1300
+++ mdew/drivers/usb/input/hid-core.c	2002-12-22 23:37:51.000000000 +1300
@@ -1317,6 +1317,9 @@
 #define USB_DEVICE_ID_ATEN_2PORTKVM    0x2204
 #define USB_DEVICE_ID_ATEN_4PORTKVM    0x2205
=20
+#define USB_VENDOR_ID_TOPMAX           0x0663
+#define USB_DEVICE_ID_TOPMAX_COBRAPAD  0x0103
+
 #define USB_VENDOR_ID_MGE              0x0463
 #define USB_DEVICE_ID_MGE_UPS          0xffff
 #define USB_DEVICE_ID_MGE_UPS1         0x0001
@@ -1355,6 +1358,7 @@
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_HIDDEV },
 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS1, HID_QUIRK_HIDDEV },
+	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD }=
,
 	{ 0, 0 }
 };
=20
diff -Naur a/drivers/usb/input/hid-input.c mdew/drivers/usb/input/hid-input=
.c
--- a/drivers/usb/input/hid-input.c	2002-11-28 11:35:59.000000000 +1300
+++ mdew/drivers/usb/input/hid-input.c	2002-12-22 23:41:25.000000000 +1300
@@ -357,6 +357,11 @@
 		int a =3D field->logical_minimum;
 		int b =3D field->logical_maximum;
=20
+		if ((device->quirks & HID_QUIRK_BADPAD) && (usage->code =3D=3D ABS_X || =
usage->code =3D=3D ABS_Y)) {
+			a =3D field->logical_minimum =3D 0;
+			b =3D field->logical_maximum =3D 255;
+		}
+	=09
 		input->absmin[usage->code] =3D a;
 		input->absmax[usage->code] =3D b;
 		input->absfuzz[usage->code] =3D (b - a) >> 8;
diff -Naur a/drivers/usb/input/hid.h mdew/drivers/usb/input/hid.h
--- a/drivers/usb/input/hid.h	2002-11-28 11:35:46.000000000 +1300
+++ mdew/drivers/usb/input/hid.h	2002-12-22 23:38:49.000000000 +1300
@@ -206,6 +206,7 @@
 #define HID_QUIRK_IGNORE	0x04
 #define HID_QUIRK_NOGET		0x08
 #define HID_QUIRK_HIDDEV	0x10
+#define HID_QUIRK_BADPAD        0x12
=20
 /*
  * This is the global enviroment of the parser. This information is

--=-jkKUwvSskuU8ZglcuCE6--

