Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264526AbRFJNTe>; Sun, 10 Jun 2001 09:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264527AbRFJNTY>; Sun, 10 Jun 2001 09:19:24 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:62478 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S264526AbRFJNTV>;
	Sun, 10 Jun 2001 09:19:21 -0400
Date: Sun, 10 Jun 2001 15:19:11 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 2.4.5-ac12] sonypi driver
Message-ID: <20010610151910.A13172@ontario.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes some small problems with the sonypi driver,
including the possibility to use the Fn keys on all Vaio laptops.

Patch attached.

Stelian.

diff -uNr --exclude-from=dontdiff linux-2.4.5-ac12.orig/Documentation/Configure.help linux-2.4.5-ac12/Documentation/Configure.help
--- linux-2.4.5-ac12.orig/Documentation/Configure.help	Sun Jun 10 13:41:47 2001
+++ linux-2.4.5-ac12/Documentation/Configure.help	Sun Jun 10 14:23:54 2001
@@ -15303,13 +15303,13 @@
   This driver enables access to the Sony Programmable I/O Control Device
   which can be found in many (all ?) Sony Vaio laptops.
 
-  If you have one of those laptops, read Documentation/sonypi.txt,
+  If you have one of those laptops, read <file:Documentation/sonypi.txt>,
   and say Y or M here.
 
   If you want to compile the driver as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
-  say M here and read Documentation/modules.txt. The module will be
-  called sonypi.o.
+  say M here and read <file:Documentation/modules.txt>. The module will
+  be called sonypi.o.
 
 Intel Random Number Generator support
 CONFIG_INTEL_RNG
diff -uNr --exclude-from=dontdiff linux-2.4.5-ac12.orig/Documentation/sonypi.txt linux-2.4.5-ac12/Documentation/sonypi.txt
--- linux-2.4.5-ac12.orig/Documentation/sonypi.txt	Sun Jun 10 13:41:47 2001
+++ linux-2.4.5-ac12/Documentation/sonypi.txt	Sun Jun 10 13:56:54 2001
@@ -36,10 +36,33 @@
 			default is -1 (automatic allocation, see /proc/misc
 			or kernel logs)
 
+	fnkeyinit:	on some Vaios (C1VE, C1VR etc), the Fn key events don't
+			get enabled unless you set this parameter to 1
+
 	verbose:	print unknown events from the sonypi device
 
+Module use:
+-----------
+
+In order to automatically load the sonypi module on use, you can put those
+lines in your /etc/modules.conf file:
+
+	alias char-major-10-250 sonypi
+	options sonypi minor=250 fnkeyinit=1
+
+This supposes the use of minor 250 for the sonypi device:
+
+	# mknod /dev/sonypi c 10 250
+
 Bugs:
 -----
 
-	- the Fn keys events seem to work on some Vaio models, but not on others
-	  (it doesn't work on C1VE, C1VR)...
+	- since all development was done by reverse engineering, there is
+	  _absolutely no guarantee_ that this driver will not crash your
+	  laptop. Permanently.
+
+	- newer Vaios (R505 series) have a different SPIC device, not yet
+	  recognized by this driver.
+
+	- should this driver also take care of setting Vaio brightness ?
+	  (it's a different set of ioports though).
diff -uNr --exclude-from=dontdiff linux-2.4.5-ac12.orig/drivers/char/sonypi.c linux-2.4.5-ac12/drivers/char/sonypi.c
--- linux-2.4.5-ac12.orig/drivers/char/sonypi.c	Sun Jun 10 13:41:54 2001
+++ linux-2.4.5-ac12/drivers/char/sonypi.c	Fri Jun  8 19:57:43 2001
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/poll.h>
+#include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
@@ -43,6 +44,7 @@
 static struct sonypi_device sonypi_device;
 static int minor = -1;
 static int verbose; /* = 0 */
+static int fnkeyinit; /* = 0 */
 
 /* Inits the queue */
 static inline void sonypi_initq(void) {
@@ -142,7 +144,7 @@
 	u8 v1, v2;
 
 	while (inb_p(sonypi_device.ioport2) & 2)
-		wait_ms(1);
+		udelay(1);
 	outb(dev, sonypi_device.ioport2);
 	v1 = inb_p(sonypi_device.ioport2);
 	v2 = inb_p(sonypi_device.ioport1);
@@ -153,11 +155,11 @@
 	u8 v1;
 
 	while (inb_p(sonypi_device.ioport2) & 2)
-		wait_ms(1);
+		udelay(1);
 	outb(dev, sonypi_device.ioport2);
 
 	while (inb_p(sonypi_device.ioport2) & 2)
-		wait_ms(1);
+		udelay(1);
 	outb(fn, sonypi_device.ioport1);
 
 	v1 = inb_p(sonypi_device.ioport1);
@@ -168,15 +170,15 @@
 	u8 v1;
 
 	while (inb_p(sonypi_device.ioport2) & 2)
-		wait_ms(1);
+		udelay(1);
 	outb(dev, sonypi_device.ioport2);
 
 	while (inb_p(sonypi_device.ioport2) & 2)
-		wait_ms(1);
+		udelay(1);
 	outb(fn, sonypi_device.ioport1);
 
 	while (inb_p(sonypi_device.ioport2) & 2)
-		wait_ms(1);
+		udelay(1);
 	outb(v, sonypi_device.ioport1);
 
 	v1 = inb_p(sonypi_device.ioport1);
@@ -232,14 +234,17 @@
 
 	for (j = 5; j > 0; j--) {
 
-		while (sonypi_call2(0x91, 0x1) != 0) 
-			wait_ms(1);
+		while (sonypi_call2(0x91, 0x1) != 0) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(1);
+		}
 		sonypi_call1(0x93);
 
 		for (i = 400; i > 0; i--) {
 			if (sonypi_camera_ready())
 				break;
-			wait_ms(1);
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(1);
 		}
 		if (i != 0)
 			break;
@@ -309,6 +314,7 @@
 	u8 ret = 0;
 
 	down(&sonypi_device.lock);
+
 	switch(command) {
 		case SONYPI_COMMAND_GETCAMERA:
 			ret = sonypi_camera_ready();
@@ -513,6 +519,9 @@
 		goto out3;
 	}
 
+	if (fnkeyinit)
+		outb(0xf0, 0xb2);
+
 	sonypi_srs();
 	sonypi_call1(0x82);
 	sonypi_call2(0x81, 0xff);
@@ -583,5 +592,7 @@
 MODULE_PARM_DESC(minor, "minor number of the misc device, default is -1 (automatic)");
 MODULE_PARM(verbose,"i");
 MODULE_PARM_DESC(verbose, "be verbose, default is 0 (no)");
+MODULE_PARM(fnkeyinit,"i");
+MODULE_PARM_DESC(fnkeyinit, "set this if your Fn keys do not generate any event");
 
 EXPORT_SYMBOL(sonypi_camera_command);
diff -uNr --exclude-from=dontdiff linux-2.4.5-ac12.orig/drivers/char/sonypi.h linux-2.4.5-ac12/drivers/char/sonypi.h
--- linux-2.4.5-ac12.orig/drivers/char/sonypi.h	Sun Jun 10 13:41:54 2001
+++ linux-2.4.5-ac12/drivers/char/sonypi.h	Sun Jun 10 14:19:42 2001
@@ -33,7 +33,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	1
-#define SONYPI_DRIVER_MINORVERSION	0
+#define SONYPI_DRIVER_MINORVERSION	1
 
 #include <linux/types.h>
 #include <linux/pci.h>
@@ -99,23 +99,11 @@
 #define SONYPI_CAMERA_REVISION 			8
 #define SONYPI_CAMERA_ROMVERSION 		9
 
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-
-static inline void wait_ms(unsigned int ms) {
-	if (!in_interrupt()) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1 + ms * HZ / 1000);
-	}
-	else
-		mdelay(ms);
-}
-
 /* key press event data (ioport2) */
 #define SONYPI_JOGGER_EV	0x10
 #define SONYPI_CAPTURE_EV	0x60
 #define SONYPI_FNKEY_EV		0x20
-#define SONYPI_BLUETOOTH_EV	0x55
+#define SONYPI_BLUETOOTH_EV	0x30
 
 struct sonypi_event {
 	u8	data;
@@ -169,8 +157,7 @@
 
 /* The set of possible bluetooth events */
 static struct sonypi_event sonypi_blueev[] = {
-	{ 0x38, SONYPI_EVENT_BLUETOOTH_PRESSED },
-	{ 0x39, SONYPI_EVENT_BLUETOOTH_RELEASED },
+	{ 0x55, SONYPI_EVENT_BLUETOOTH_PRESSED },
 	{ 0x00, 0x00 }
 };
 
diff -uNr --exclude-from=dontdiff linux-2.4.5-ac12.orig/include/linux/sonypi.h linux-2.4.5-ac12/include/linux/sonypi.h
--- linux-2.4.5-ac12.orig/include/linux/sonypi.h	Sun Jun 10 13:42:19 2001
+++ linux-2.4.5-ac12/include/linux/sonypi.h	Sun Jun 10 14:19:42 2001
@@ -63,7 +63,6 @@
 #define SONYPI_EVENT_FNKEY_S			29
 #define SONYPI_EVENT_FNKEY_B			30
 #define SONYPI_EVENT_BLUETOOTH_PRESSED		31
-#define SONYPI_EVENT_BLUETOOTH_RELEASED		32
 
 #ifdef __KERNEL__
 

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
