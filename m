Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315292AbSEAEPr>; Wed, 1 May 2002 00:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315293AbSEAEPq>; Wed, 1 May 2002 00:15:46 -0400
Received: from [203.94.94.90] ([203.94.94.90]:1028 "EHLO shalmirane.net")
	by vger.kernel.org with ESMTP id <S315292AbSEAEPo>;
	Wed, 1 May 2002 00:15:44 -0400
Date: Wed, 1 May 2002 10:14:55 -0600 (GMT+6)
From: "Ishan O. Jayawardena" <ioshadij@hotmail.com>
To: linux-kernel@vger.kernel.org
cc: marcelo@conectiva.com.br, akpm@zip.com.au, rgooch@atnf.csiro.au
Subject: [PATCH] Improve _tty_make_name
Message-ID: <Pine.LNX.4.21.0205010955340.780-300000@shalmirane.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811840-754891130-1020269695=:780"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811840-754891130-1020269695=:780
Content-Type: TEXT/PLAIN; charset=US-ASCII


	_tty_make_name() isn't consistent wrt to devfs because the
non-devfs name of many drivers don't have printf() style format strings
embedded, while their respective devfs names do. Some time ago a thread
was born here under the topic "Serial Driver Name Question (kernels
2.4.x)", but apparently, nothing came out of it.
	This way, if a device name has format strings ambedded, then so be
it. If not, the behaviour of the 2.2.x tty_name() is assumed.
	The patch #2 attached remedies this, and some trivia.
	Patch #1 is a trivial fix for pty devices.
	Diffed against 2.4.19-pre7-ac2. Should apply to the mainline tree
without hassle.

	Please CC me: ioshadij@hotmail.com

Cheerio!

Ishan Oshadi Jayawardena

-------------------------------------------
Patch #2:
--- linux/drivers/char/tty_io.c.1	Sun Apr 28 11:28:07 2002
+++ linux/drivers/char/tty_io.c	Wed May  1 08:58:02 2002
@@ -195,9 +195,16 @@ _tty_make_name(struct tty_struct *tty, c
 
 	if (!tty) /* Hmm.  NULL pointer.  That's fun. */
 		strcpy(buf, "NULL tty");
-	else
-		sprintf(buf, name,
-			idx + tty->driver.name_base);
+	else {
+		if (strchr(name, '%'))
+			/*
+			 * Assuming printf() style 
+			 * format strings are present...
+			 */
+			sprintf(buf, name, idx + tty->driver.name_base);
+		else
+			sprintf(buf, "%s%d", name, idx + tty->driver.name_base);
+	}
 		
 	return buf;
 }
@@ -2320,15 +2327,22 @@ void __init tty_init(void)
 	
 #ifdef CONFIG_VT
 	dev_console_driver = dev_tty_driver;
+#ifdef CONFIG_DEVFS_FS
 	dev_console_driver.driver_name = "/dev/vc/0";
+#else
+	dev_console_driver.driver_name = "/dev/tty0";
+#endif
 	dev_console_driver.name = dev_console_driver.driver_name + 5;
 	dev_console_driver.major = TTY_MAJOR;
 	dev_console_driver.type = TTY_DRIVER_TYPE_SYSTEM;
 	dev_console_driver.subtype = SYSTEM_TYPE_CONSOLE;
 
 	if (tty_register_driver(&dev_console_driver))
+#ifdef CONFIG_DEVFS_FS
+		panic("Couldn't register /dev/vc/0 driver");
+#else
 		panic("Couldn't register /dev/tty0 driver\n");
-
+#endif
 	kbd_init();
 #endif
 

------------------

Patch #1:
--- linux/drivers/char/pty.c.1	Sun Apr 28 12:22:59 2002
+++ linux/drivers/char/pty.c	Wed May  1 08:54:55 2002
@@ -458,11 +458,7 @@ int __init pty_init(void)
 			init_waitqueue_head(&ptm_state[i][j].open_wait);
 		
 		pts_driver[i] = pty_slave_driver;
-#ifdef CONFIG_DEVFS_FS
 		pts_driver[i].name = "pts/%d";
-#else
-		pts_driver[i].name = "pts";
-#endif
 		pts_driver[i].proc_entry = 0;
 		pts_driver[i].major = UNIX98_PTY_SLAVE_MAJOR+i;
 		pts_driver[i].minor_start = 0;


---1463811840-754891130-1020269695=:780
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="pty.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0205011014550.780@shalmirane.net>
Content-Description: 
Content-Disposition: attachment; filename="pty.diff"

LS0tIGxpbnV4L2RyaXZlcnMvY2hhci9wdHkuYy4xCVN1biBBcHIgMjggMTI6
MjI6NTkgMjAwMg0KKysrIGxpbnV4L2RyaXZlcnMvY2hhci9wdHkuYwlXZWQg
TWF5ICAxIDA4OjU0OjU1IDIwMDINCkBAIC00NTgsMTEgKzQ1OCw3IEBAIGlu
dCBfX2luaXQgcHR5X2luaXQodm9pZCkNCiAJCQlpbml0X3dhaXRxdWV1ZV9o
ZWFkKCZwdG1fc3RhdGVbaV1bal0ub3Blbl93YWl0KTsNCiAJCQ0KIAkJcHRz
X2RyaXZlcltpXSA9IHB0eV9zbGF2ZV9kcml2ZXI7DQotI2lmZGVmIENPTkZJ
R19ERVZGU19GUw0KIAkJcHRzX2RyaXZlcltpXS5uYW1lID0gInB0cy8lZCI7
DQotI2Vsc2UNCi0JCXB0c19kcml2ZXJbaV0ubmFtZSA9ICJwdHMiOw0KLSNl
bmRpZg0KIAkJcHRzX2RyaXZlcltpXS5wcm9jX2VudHJ5ID0gMDsNCiAJCXB0
c19kcml2ZXJbaV0ubWFqb3IgPSBVTklYOThfUFRZX1NMQVZFX01BSk9SK2k7
DQogCQlwdHNfZHJpdmVyW2ldLm1pbm9yX3N0YXJ0ID0gMDsNCg==
---1463811840-754891130-1020269695=:780
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="tty_io.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0205011014551.780@shalmirane.net>
Content-Description: 
Content-Disposition: attachment; filename="tty_io.diff"

LS0tIGxpbnV4L2RyaXZlcnMvY2hhci90dHlfaW8uYy4xCVN1biBBcHIgMjgg
MTE6Mjg6MDcgMjAwMg0KKysrIGxpbnV4L2RyaXZlcnMvY2hhci90dHlfaW8u
YwlXZWQgTWF5ICAxIDA4OjU4OjAyIDIwMDINCkBAIC0xOTUsOSArMTk1LDE2
IEBAIF90dHlfbWFrZV9uYW1lKHN0cnVjdCB0dHlfc3RydWN0ICp0dHksIGMN
CiANCiAJaWYgKCF0dHkpIC8qIEhtbS4gIE5VTEwgcG9pbnRlci4gIFRoYXQn
cyBmdW4uICovDQogCQlzdHJjcHkoYnVmLCAiTlVMTCB0dHkiKTsNCi0JZWxz
ZQ0KLQkJc3ByaW50ZihidWYsIG5hbWUsDQotCQkJaWR4ICsgdHR5LT5kcml2
ZXIubmFtZV9iYXNlKTsNCisJZWxzZSB7DQorCQlpZiAoc3RyY2hyKG5hbWUs
ICclJykpDQorCQkJLyoNCisJCQkgKiBBc3N1bWluZyBwcmludGYoKSBzdHls
ZSANCisJCQkgKiBmb3JtYXQgc3RyaW5ncyBhcmUgcHJlc2VudC4uLg0KKwkJ
CSAqLw0KKwkJCXNwcmludGYoYnVmLCBuYW1lLCBpZHggKyB0dHktPmRyaXZl
ci5uYW1lX2Jhc2UpOw0KKwkJZWxzZQ0KKwkJCXNwcmludGYoYnVmLCAiJXMl
ZCIsIG5hbWUsIGlkeCArIHR0eS0+ZHJpdmVyLm5hbWVfYmFzZSk7DQorCX0N
CiAJCQ0KIAlyZXR1cm4gYnVmOw0KIH0NCkBAIC0yMzIwLDE1ICsyMzI3LDIy
IEBAIHZvaWQgX19pbml0IHR0eV9pbml0KHZvaWQpDQogCQ0KICNpZmRlZiBD
T05GSUdfVlQNCiAJZGV2X2NvbnNvbGVfZHJpdmVyID0gZGV2X3R0eV9kcml2
ZXI7DQorI2lmZGVmIENPTkZJR19ERVZGU19GUw0KIAlkZXZfY29uc29sZV9k
cml2ZXIuZHJpdmVyX25hbWUgPSAiL2Rldi92Yy8wIjsNCisjZWxzZQ0KKwlk
ZXZfY29uc29sZV9kcml2ZXIuZHJpdmVyX25hbWUgPSAiL2Rldi90dHkwIjsN
CisjZW5kaWYNCiAJZGV2X2NvbnNvbGVfZHJpdmVyLm5hbWUgPSBkZXZfY29u
c29sZV9kcml2ZXIuZHJpdmVyX25hbWUgKyA1Ow0KIAlkZXZfY29uc29sZV9k
cml2ZXIubWFqb3IgPSBUVFlfTUFKT1I7DQogCWRldl9jb25zb2xlX2RyaXZl
ci50eXBlID0gVFRZX0RSSVZFUl9UWVBFX1NZU1RFTTsNCiAJZGV2X2NvbnNv
bGVfZHJpdmVyLnN1YnR5cGUgPSBTWVNURU1fVFlQRV9DT05TT0xFOw0KIA0K
IAlpZiAodHR5X3JlZ2lzdGVyX2RyaXZlcigmZGV2X2NvbnNvbGVfZHJpdmVy
KSkNCisjaWZkZWYgQ09ORklHX0RFVkZTX0ZTDQorCQlwYW5pYygiQ291bGRu
J3QgcmVnaXN0ZXIgL2Rldi92Yy8wIGRyaXZlciIpOw0KKyNlbHNlDQogCQlw
YW5pYygiQ291bGRuJ3QgcmVnaXN0ZXIgL2Rldi90dHkwIGRyaXZlclxuIik7
DQotDQorI2VuZGlmDQogCWtiZF9pbml0KCk7DQogI2VuZGlmDQogDQo=
---1463811840-754891130-1020269695=:780--
