Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268860AbRG0NXG>; Fri, 27 Jul 2001 09:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268859AbRG0NW5>; Fri, 27 Jul 2001 09:22:57 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:11014 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S268852AbRG0NWp>;
	Fri, 27 Jul 2001 09:22:45 -0400
Date: Fri, 27 Jul 2001 15:22:50 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.4.7-ac1] SonyPI driver updates.
Message-ID: <20010727152250.C6860@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This driver removes the while(1) loops from the sonypi driver
which could cause kernel hangups in case of faulty hardware,
or some obscure suspend/resume conditions.

Alan, please apply and submit it to Linus together with the
previous sonypi patches present in the -ac tree.

Thanks,

Stelian.


diff -uNr --exclude-from=dontdiff linux-2.4.6-ac5.orig/drivers/char/sonypi.c linux-2.4.6-ac5/drivers/char/sonypi.c
--- linux-2.4.6-ac5.orig/drivers/char/sonypi.c	Fri Jul 27 14:27:34 2001
+++ linux-2.4.6-ac5/drivers/char/sonypi.c	Thu Jul 26 12:14:18 2001
@@ -109,32 +109,23 @@
 }
 
 static void sonypi_ecrset(u16 addr, u16 value) {
-	int n = 100;
 
-	while (n-- && (inw_p(SONYPI_CST_IOPORT) & 3))
-		udelay(1);
+	wait_on_command(inw_p(SONYPI_CST_IOPORT) & 3);
 	outw_p(0x81, SONYPI_CST_IOPORT);
-	while (inw_p(SONYPI_CST_IOPORT) & 2)
-		udelay(1);
+	wait_on_command(inw_p(SONYPI_CST_IOPORT) & 2);
 	outw_p(addr, SONYPI_DATA_IOPORT);
-	while (inw_p(SONYPI_CST_IOPORT) & 2)
-		udelay(1);
+	wait_on_command(inw_p(SONYPI_CST_IOPORT) & 2);
 	outw_p(value, SONYPI_DATA_IOPORT);
-	while (inw_p(SONYPI_CST_IOPORT) & 2)
-		udelay(1);
+	wait_on_command(inw_p(SONYPI_CST_IOPORT) & 2);
 }
 
 static u16 sonypi_ecrget(u16 addr) {
-	int n = 100;
 
-	while (n-- && (inw_p(SONYPI_CST_IOPORT) & 3))
-		udelay(1);
+	wait_on_command(inw_p(SONYPI_CST_IOPORT) & 3);
 	outw_p(0x80, SONYPI_CST_IOPORT);
-	while (inw_p(SONYPI_CST_IOPORT) & 2)
-		udelay(1);
+	wait_on_command(inw_p(SONYPI_CST_IOPORT) & 2);
 	outw_p(addr, SONYPI_DATA_IOPORT);
-	while (inw_p(SONYPI_CST_IOPORT) & 2)
-		udelay(1);
+	wait_on_command(inw_p(SONYPI_CST_IOPORT) & 2);
 	return inw_p(SONYPI_DATA_IOPORT);
 }
 
@@ -190,8 +181,7 @@
 static u8 sonypi_call1(u8 dev) {
 	u8 v1, v2;
 
-	while (inb_p(sonypi_device.ioport2) & 2)
-		udelay(1);
+	wait_on_command(inb_p(sonypi_device.ioport2) & 2);
 	outb(dev, sonypi_device.ioport2);
 	v1 = inb_p(sonypi_device.ioport2);
 	v2 = inb_p(sonypi_device.ioport1);
@@ -201,14 +191,10 @@
 static u8 sonypi_call2(u8 dev, u8 fn) {
 	u8 v1;
 
-	while (inb_p(sonypi_device.ioport2) & 2)
-		udelay(1);
+	wait_on_command(inb_p(sonypi_device.ioport2) & 2);
 	outb(dev, sonypi_device.ioport2);
-
-	while (inb_p(sonypi_device.ioport2) & 2)
-		udelay(1);
+	wait_on_command(inb_p(sonypi_device.ioport2) & 2);
 	outb(fn, sonypi_device.ioport1);
-
 	v1 = inb_p(sonypi_device.ioport1);
 	return v1;
 }
@@ -216,18 +202,12 @@
 static u8 sonypi_call3(u8 dev, u8 fn, u8 v) {
 	u8 v1;
 
-	while (inb_p(sonypi_device.ioport2) & 2)
-		udelay(1);
+	wait_on_command(inb_p(sonypi_device.ioport2) & 2);
 	outb(dev, sonypi_device.ioport2);
-
-	while (inb_p(sonypi_device.ioport2) & 2)
-		udelay(1);
+	wait_on_command(inb_p(sonypi_device.ioport2) & 2);
 	outb(fn, sonypi_device.ioport1);
-
-	while (inb_p(sonypi_device.ioport2) & 2)
-		udelay(1);
+	wait_on_command(inb_p(sonypi_device.ioport2) & 2);
 	outb(v, sonypi_device.ioport1);
-
 	v1 = inb_p(sonypi_device.ioport1);
 	return v1;
 }
@@ -247,11 +227,8 @@
 
 /* Set brightness, hue etc */
 static void sonypi_set(u8 fn, u8 v) {
-	int n = 100;
 	
-	while (n--)
-		if (sonypi_call3(0x90, fn, v) == 0) 
-			break;
+	wait_on_command(sonypi_call3(0x90, fn, v));
 }
 
 /* Tests if the camera is ready */
diff -uNr --exclude-from=dontdiff linux-2.4.6-ac5.orig/drivers/char/sonypi.h linux-2.4.6-ac5/drivers/char/sonypi.h
--- linux-2.4.6-ac5.orig/drivers/char/sonypi.h	Fri Jul 27 14:27:34 2001
+++ linux-2.4.6-ac5/drivers/char/sonypi.h	Fri Jul 27 14:29:55 2001
@@ -35,7 +35,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	1
-#define SONYPI_DRIVER_MINORVERSION	3
+#define SONYPI_DRIVER_MINORVERSION	4
 
 #include <linux/types.h>
 #include <linux/pci.h>
@@ -222,6 +222,14 @@
 	int open_count;
 	int model;
 };
+
+#define wait_on_command(command) { \
+	unsigned int n = 10000; \
+	while (--n && (command)) \
+		udelay(1); \
+	if (!n) \
+		printk(KERN_WARNING "sonypi command failed at " __FILE__ " : " __FUNCTION__ "(line %d)\n", __LINE__); \
+}
 
 #endif /* __KERNEL__ */
 
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
