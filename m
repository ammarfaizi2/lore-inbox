Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315133AbSECSvb>; Fri, 3 May 2002 14:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSECSvb>; Fri, 3 May 2002 14:51:31 -0400
Received: from [203.94.94.100] ([203.94.94.100]:19460 "EHLO shalmirane.net")
	by vger.kernel.org with ESMTP id <S315133AbSECSva>;
	Fri, 3 May 2002 14:51:30 -0400
Date: Sat, 4 May 2002 00:52:02 -0600 (GMT+6)
From: "Ishan O. Jayawardena" <ioshadij@hotmail.com>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, davej@suse.de
Subject: Re: [PATCH] Improve _tty_make_name [2.5]
Message-ID: <Pine.LNX.4.21.0205040040320.1800-200000@shalmirane.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811840-1850306688-1020495122=:1800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811840-1850306688-1020495122=:1800
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,
	This is a version of my previous patch re-diffed against
2.5.12. Without this or an equivalent fix, users wouldn't be able to
differentiate between certain devices (the serial device - console.c - is
one). As it currently is, tty_name() will print "ttyS" regardless of the
real device, be it ttyS0, ttyS2, etc.; assuming no devfs.
	More sanity checks are possible, but would be superflous...

Best Regards,
Ishan Oshadi Jayawardena

-----------------------------------------
--- linux/drivers/char/tty_io.c.1	Sat May  4 00:27:04 2002
+++ linux/drivers/char/tty_io.c	Sat May  4 00:36:25 2002
@@ -189,10 +189,20 @@ _tty_make_name(struct tty_struct *tty, c
 
 	if (!tty) /* Hmm.  NULL pointer.  That's fun. */
 		strcpy(buf, "NULL tty");
-	else
-		sprintf(buf, name,
-			idx + tty->driver.name_base);
-		
+	else {
+		if (strchr(name, '%')) {
+			/*
+			 * Assuming printf() style 
+			 * format strings are present...
+			 */
+			sprintf(buf, name, 
+				idx + tty->driver.name_base);
+		} else { 	/* Old style... */
+			sprintf(buf, "%s%d", name, 
+				idx + tty->driver.name_base);
+		}
+	}
+
 	return buf;
 }
 
@@ -2305,14 +2315,22 @@ void __init tty_init(void)
 	
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
+#endif
 
 	vcs_init();
 	kbd_init();

---1463811840-1850306688-1020495122=:1800
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="2.5-tty_io.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0205040052020.1800@shalmirane.net>
Content-Description: 
Content-Disposition: attachment; filename="2.5-tty_io.diff"

LS0tIGxpbnV4L2RyaXZlcnMvY2hhci90dHlfaW8uYy4xCVNhdCBNYXkgIDQg
MDA6Mjc6MDQgMjAwMg0KKysrIGxpbnV4L2RyaXZlcnMvY2hhci90dHlfaW8u
YwlTYXQgTWF5ICA0IDAwOjM2OjI1IDIwMDINCkBAIC0xODksMTAgKzE4OSwy
MCBAQCBfdHR5X21ha2VfbmFtZShzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5LCBj
DQogDQogCWlmICghdHR5KSAvKiBIbW0uICBOVUxMIHBvaW50ZXIuICBUaGF0
J3MgZnVuLiAqLw0KIAkJc3RyY3B5KGJ1ZiwgIk5VTEwgdHR5Iik7DQotCWVs
c2UNCi0JCXNwcmludGYoYnVmLCBuYW1lLA0KLQkJCWlkeCArIHR0eS0+ZHJp
dmVyLm5hbWVfYmFzZSk7DQotCQkNCisJZWxzZSB7DQorCQlpZiAoc3RyY2hy
KG5hbWUsICclJykpIHsNCisJCQkvKg0KKwkJCSAqIEFzc3VtaW5nIHByaW50
ZigpIHN0eWxlIA0KKwkJCSAqIGZvcm1hdCBzdHJpbmdzIGFyZSBwcmVzZW50
Li4uDQorCQkJICovDQorCQkJc3ByaW50ZihidWYsIG5hbWUsIA0KKwkJCQlp
ZHggKyB0dHktPmRyaXZlci5uYW1lX2Jhc2UpOw0KKwkJfSBlbHNlIHsgCS8q
IE9sZCBzdHlsZS4uLiAqLw0KKwkJCXNwcmludGYoYnVmLCAiJXMlZCIsIG5h
bWUsIA0KKwkJCQlpZHggKyB0dHktPmRyaXZlci5uYW1lX2Jhc2UpOw0KKwkJ
fQ0KKwl9DQorDQogCXJldHVybiBidWY7DQogfQ0KIA0KQEAgLTIzMDUsMTQg
KzIzMTUsMjIgQEAgdm9pZCBfX2luaXQgdHR5X2luaXQodm9pZCkNCiAJDQog
I2lmZGVmIENPTkZJR19WVA0KIAlkZXZfY29uc29sZV9kcml2ZXIgPSBkZXZf
dHR5X2RyaXZlcjsNCisjaWZkZWYgQ09ORklHX0RFVkZTX0ZTDQogCWRldl9j
b25zb2xlX2RyaXZlci5kcml2ZXJfbmFtZSA9ICIvZGV2L3ZjLzAiOw0KKyNl
bHNlDQorCWRldl9jb25zb2xlX2RyaXZlci5kcml2ZXJfbmFtZSA9ICIvZGV2
L3R0eTAiOw0KKyNlbmRpZg0KIAlkZXZfY29uc29sZV9kcml2ZXIubmFtZSA9
IGRldl9jb25zb2xlX2RyaXZlci5kcml2ZXJfbmFtZSArIDU7DQogCWRldl9j
b25zb2xlX2RyaXZlci5tYWpvciA9IFRUWV9NQUpPUjsNCiAJZGV2X2NvbnNv
bGVfZHJpdmVyLnR5cGUgPSBUVFlfRFJJVkVSX1RZUEVfU1lTVEVNOw0KIAlk
ZXZfY29uc29sZV9kcml2ZXIuc3VidHlwZSA9IFNZU1RFTV9UWVBFX0NPTlNP
TEU7DQogDQogCWlmICh0dHlfcmVnaXN0ZXJfZHJpdmVyKCZkZXZfY29uc29s
ZV9kcml2ZXIpKQ0KKyNpZmRlZiBDT05GSUdfREVWRlNfRlMNCisJCXBhbmlj
KCJDb3VsZG4ndCByZWdpc3RlciAvZGV2L3ZjLzAgZHJpdmVyIik7DQorI2Vs
c2UNCiAJCXBhbmljKCJDb3VsZG4ndCByZWdpc3RlciAvZGV2L3R0eTAgZHJp
dmVyXG4iKTsNCisjZW5kaWYNCiANCiAJdmNzX2luaXQoKTsNCiAJa2JkX2lu
aXQoKTsNCg==
---1463811840-1850306688-1020495122=:1800--
