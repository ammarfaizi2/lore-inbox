Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266976AbSLWU51>; Mon, 23 Dec 2002 15:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbSLWU51>; Mon, 23 Dec 2002 15:57:27 -0500
Received: from mx1.visp.co.nz ([210.55.24.20]:35597 "EHLO mail.visp.co.nz")
	by vger.kernel.org with ESMTP id <S266976AbSLWU5Y>;
	Mon, 23 Dec 2002 15:57:24 -0500
Subject: Re: [PATCH 2.5] [TRIVIAL] USB Joypad quirk
From: mdew <mdew@orcon.net.nz>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "torvalds@transmeta.com" <torvalds@transmeta.com>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20021223191232.GA31060@kroah.com>
References: <1040556042.9822.17.camel@nirvana> 
	<20021223191232.GA31060@kroah.com>
Content-Type: multipart/mixed; boundary="=-BE2TbFwctz65XpJIFW3Z"
X-Mailer: Ximian Evolution 1.0.8 
Date: 24 Dec 2002 10:04:30 +1300
Message-Id: <1040677522.28347.2.camel@nirvana>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BE2TbFwctz65XpJIFW3Z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2002-12-24 at 08:12, Greg KH wrote:
> On Mon, Dec 23, 2002 at 12:20:30AM +1300, mdew wrote:
> > Orginally from Vojtech Pavlik (16th June 2002 via email), to fix my
> > 'broken' USB joypad, Fully tested in both 2.4.x and 2.5.52 (and
> > 2.5.52-bk).
> 
> Applied to my 2.5 tree, thanks.
> 
> Can you also send a 2.4 version, as this one does not work for that
> tree?

sure

diff -Naur linux-2.4.19/drivers/usb/hid-core.c
mdew/drivers/usb/hid-core.c
--- linux-2.4.19/drivers/usb/hid-core.c 2002-08-03 12:39:44.000000000
+1200
+++ mdew/drivers/usb/hid-core.c 2002-12-24 09:53:52.000000000 +1300
@@ -1086,6 +1086,9 @@
 #define USB_DEVICE_ID_ATEN_2PORTKVM    0x2204
 #define USB_DEVICE_ID_ATEN_4PORTKVM    0x2205

+#define USB_VENDOR_ID_TOPMAX           0x0663
+#define USB_DEVICE_ID_TOPMAX_COBRAPAD  0x0103
+
 struct hid_blacklist {
        __u16 idVendor;
        __u16 idProduct;
@@ -1115,6 +1118,7 @@
        { USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET
},
        { USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM,
HID_QUIRK_NOGET },
        { USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM,
HID_QUIRK_NOGET },
+       { USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD,
HID_QUIRK_BADPAD },
        { 0, 0 }
 };

diff -Naur linux-2.4.19/drivers/usb/hid-input.c
mdew/drivers/usb/hid-input.c
--- linux-2.4.19/drivers/usb/hid-input.c        2001-11-12
07:09:37.000000000 +1300
+++ mdew/drivers/usb/hid-input.c        2002-12-24 09:53:52.000000000
+1300
@@ -280,6 +280,11 @@
                int a = field->logical_minimum;
                int b = field->logical_maximum;

+               if ((device->quirks & HID_QUIRK_BADPAD) && (usage->code
== ABS_X || usage->code == ABS_Y)) {
+                               a = field->logical_minimum = 0;
+                               b = field->logical_maximum = 255;
+                 }
+
                input->absmin[usage->code] = a;
                input->absmax[usage->code] = b;
                input->absfuzz[usage->code] = (b - a) >> 8;
diff -Naur linux-2.4.19/drivers/usb/hid.h mdew/drivers/usb/hid.h
--- linux-2.4.19/drivers/usb/hid.h      2002-08-03 12:39:44.000000000
+1200
+++ mdew/drivers/usb/hid.h      2002-12-24 09:53:47.000000000 +1300
@@ -186,6 +186,7 @@
 #define HID_QUIRK_NOTOUCH      0x02
 #define HID_QUIRK_IGNORE       0x04
 #define HID_QUIRK_NOGET                0x08
+#define HID_QUIRK_BADPAD       0x10

 /*
  * This is the global enviroment of the parser. This information is


--=-BE2TbFwctz65XpJIFW3Z
Content-Disposition: attachment; filename=hid_quirk_badpad-2.4.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=hid_quirk_badpad-2.4.diff; charset=ANSI_X3.4-1968

diff -Naur linux-2.4.19/drivers/usb/hid-core.c mdew/drivers/usb/hid-core.c
--- linux-2.4.19/drivers/usb/hid-core.c	2002-08-03 12:39:44.000000000 +1200
+++ mdew/drivers/usb/hid-core.c	2002-12-24 09:53:52.000000000 +1300
@@ -1086,6 +1086,9 @@
 #define USB_DEVICE_ID_ATEN_2PORTKVM	0x2204
 #define USB_DEVICE_ID_ATEN_4PORTKVM	0x2205
=20
+#define USB_VENDOR_ID_TOPMAX		0x0663
+#define USB_DEVICE_ID_TOPMAX_COBRAPAD	0x0103
+
 struct hid_blacklist {
 	__u16 idVendor;
 	__u16 idProduct;
@@ -1115,6 +1118,7 @@
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS124U, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD, HID_QUIRK_BADPAD }=
,
 	{ 0, 0 }
 };
=20
diff -Naur linux-2.4.19/drivers/usb/hid-input.c mdew/drivers/usb/hid-input.=
c
--- linux-2.4.19/drivers/usb/hid-input.c	2001-11-12 07:09:37.000000000 +130=
0
+++ mdew/drivers/usb/hid-input.c	2002-12-24 09:53:52.000000000 +1300
@@ -280,6 +280,11 @@
 		int a =3D field->logical_minimum;
 		int b =3D field->logical_maximum;
=20
+		if ((device->quirks & HID_QUIRK_BADPAD) && (usage->code =3D=3D ABS_X || =
usage->code =3D=3D ABS_Y)) {
+                       	a =3D field->logical_minimum =3D 0;
+                       	b =3D field->logical_maximum =3D 255;
+                 }     =20
+
 		input->absmin[usage->code] =3D a;
 		input->absmax[usage->code] =3D b;
 		input->absfuzz[usage->code] =3D (b - a) >> 8;
diff -Naur linux-2.4.19/drivers/usb/hid.h mdew/drivers/usb/hid.h
--- linux-2.4.19/drivers/usb/hid.h	2002-08-03 12:39:44.000000000 +1200
+++ mdew/drivers/usb/hid.h	2002-12-24 09:53:47.000000000 +1300
@@ -186,6 +186,7 @@
 #define HID_QUIRK_NOTOUCH	0x02
 #define HID_QUIRK_IGNORE	0x04
 #define HID_QUIRK_NOGET		0x08
+#define HID_QUIRK_BADPAD	0x10
=20
 /*
  * This is the global enviroment of the parser. This information is

--=-BE2TbFwctz65XpJIFW3Z--

