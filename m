Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264677AbSJ3OBb>; Wed, 30 Oct 2002 09:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264678AbSJ3OBb>; Wed, 30 Oct 2002 09:01:31 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:65504 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S264677AbSJ3OB2>; Wed, 30 Oct 2002 09:01:28 -0500
Date: Wed, 30 Oct 2002 15:07:46 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.5.20-rc1] sonypi driver update
Message-ID: <20021030140746.GC17103@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds some new events to the sonypi driver (Fn key 
pressed alone, jogdial turned fast or very fast) and cleanups
the code a little bit.

Thanks to Christian Gennerat for this contribution.

Stelian.

===== include/linux/sonypi.h 1.6 vs edited =====
--- 1.6/include/linux/sonypi.h	Tue Aug  6 19:24:33 2002
+++ edited/include/linux/sonypi.h	Wed Oct 30 11:44:30 2002
@@ -76,6 +76,15 @@
 #define SONYPI_EVENT_BLUETOOTH_ON		38
 #define SONYPI_EVENT_BLUETOOTH_OFF		39
 #define SONYPI_EVENT_HELP_PRESSED		40
+#define SONYPI_EVENT_FNKEY_ONLY			41
+#define SONYPI_EVENT_JOGDIAL_FAST_DOWN		42
+#define SONYPI_EVENT_JOGDIAL_FAST_UP		43
+#define SONYPI_EVENT_JOGDIAL_FAST_DOWN_PRESSED	44
+#define SONYPI_EVENT_JOGDIAL_FAST_UP_PRESSED	45
+#define SONYPI_EVENT_JOGDIAL_VFAST_DOWN		46
+#define SONYPI_EVENT_JOGDIAL_VFAST_UP		47
+#define SONYPI_EVENT_JOGDIAL_VFAST_DOWN_PRESSED	48
+#define SONYPI_EVENT_JOGDIAL_VFAST_UP_PRESSED	49
 
 /* get/set brightness */
 #define SONYPI_IOCGBRT		_IOR('v', 0, __u8)
===== drivers/char/sonypi.h 1.11 vs edited =====
--- 1.11/drivers/char/sonypi.h	Mon Aug 12 18:10:21 2002
+++ edited/drivers/char/sonypi.h	Wed Oct 30 14:46:23 2002
@@ -35,7 +35,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	 1
-#define SONYPI_DRIVER_MINORVERSION	13
+#define SONYPI_DRIVER_MINORVERSION	14
 
 #include <linux/types.h>
 #include <linux/pci.h>
@@ -54,6 +54,20 @@
 #define SONYPI_SHIB			0x9d
 #define SONYPI_TYPE2_REGION_SIZE	0x20
 
+/* battery / brightness addresses */
+#define SONYPI_BAT_FLAGS	0x81
+#define SONYPI_LCD_LIGHT	0x96
+#define SONYPI_BAT1_PCTRM	0xa0
+#define SONYPI_BAT1_LEFT	0xa2
+#define SONYPI_BAT1_MAXRT	0xa4
+#define SONYPI_BAT2_PCTRM	0xa8
+#define SONYPI_BAT2_LEFT	0xaa
+#define SONYPI_BAT2_MAXRT	0xac
+#define SONYPI_BAT1_MAXTK	0xb0
+#define SONYPI_BAT1_FULL	0xb2
+#define SONYPI_BAT2_MAXTK	0xb8
+#define SONYPI_BAT2_FULL	0xba
+
 /* ioports used for brightness and type2 events */
 #define SONYPI_DATA_IOPORT	0x62
 #define SONYPI_CST_IOPORT	0x66
@@ -156,6 +170,14 @@
 	{ 0x01, SONYPI_EVENT_JOGDIAL_DOWN },
 	{ 0x5f, SONYPI_EVENT_JOGDIAL_UP_PRESSED },
 	{ 0x41, SONYPI_EVENT_JOGDIAL_DOWN_PRESSED },
+	{ 0x1e, SONYPI_EVENT_JOGDIAL_FAST_UP },
+	{ 0x02, SONYPI_EVENT_JOGDIAL_FAST_DOWN },
+	{ 0x5e, SONYPI_EVENT_JOGDIAL_FAST_UP_PRESSED },
+	{ 0x42, SONYPI_EVENT_JOGDIAL_FAST_DOWN_PRESSED },
+	{ 0x1d, SONYPI_EVENT_JOGDIAL_VFAST_UP },
+	{ 0x03, SONYPI_EVENT_JOGDIAL_VFAST_DOWN },
+	{ 0x5d, SONYPI_EVENT_JOGDIAL_VFAST_UP_PRESSED },
+	{ 0x43, SONYPI_EVENT_JOGDIAL_VFAST_DOWN_PRESSED },
 	{ 0x40, SONYPI_EVENT_JOGDIAL_PRESSED },
 	{ 0x00, SONYPI_EVENT_JOGDIAL_RELEASED },
 	{ 0x00, 0x00 }
@@ -192,6 +214,7 @@
 	{ 0x33, SONYPI_EVENT_FNKEY_F },
 	{ 0x34, SONYPI_EVENT_FNKEY_S },
 	{ 0x35, SONYPI_EVENT_FNKEY_B },
+	{ 0x36, SONYPI_EVENT_FNKEY_ONLY },
 	{ 0x00, 0x00 }
 };
 
@@ -259,7 +282,7 @@
 	while (--n && (command)) \
 		udelay(1); \
 	if (!n && (verbose || !quiet)) \
-		printk(KERN_WARNING "sonypi command failed at " __FILE__ " : %s (line %d)\n", __FUNCTION__, __LINE__); \
+		printk(KERN_WARNING "sonypi command failed at %s : %s (line %d)\n", __FILE__, __FUNCTION__, __LINE__); \
 }
 
 #endif /* __KERNEL__ */
===== drivers/char/sonypi.c 1.10 vs edited =====
--- 1.10/drivers/char/sonypi.c	Mon Apr 29 12:39:37 2002
+++ edited/drivers/char/sonypi.c	Wed Oct 30 11:45:54 2002
@@ -1,4 +1,4 @@
-/* 
+/*
  * Sony Programmable I/O Control Device driver for VAIO
  *
  * Copyright (C) 2001 Stelian Pop <stelian.pop@fr.alcove.com>, Alcôve
@@ -542,7 +542,7 @@
 	down(&sonypi_device.lock);
 	switch (cmd) {
 	case SONYPI_IOCGBRT:
-		val8 = sonypi_ecrget(0x96);
+		val8 = sonypi_ecrget(SONYPI_LCD_LIGHT);
 		if (copy_to_user((u8 *)arg, &val8, sizeof(val8))) {
 			ret = -EFAULT;
 			goto out;
@@ -553,38 +553,38 @@
 			ret = -EFAULT;
 			goto out;
 		}
-		sonypi_ecrset(0x96, val8);
+		sonypi_ecrset(SONYPI_LCD_LIGHT, val8);
 		break;
 	case SONYPI_IOCGBAT1CAP:
-		val16 = sonypi_ecrget16(0xb2);
+		val16 = sonypi_ecrget16(SONYPI_BAT1_FULL);
 		if (copy_to_user((u16 *)arg, &val16, sizeof(val16))) {
 			ret = -EFAULT;
 			goto out;
 		}
 		break;
 	case SONYPI_IOCGBAT1REM:
-		val16 = sonypi_ecrget16(0xa2);
+		val16 = sonypi_ecrget16(SONYPI_BAT1_LEFT);
 		if (copy_to_user((u16 *)arg, &val16, sizeof(val16))) {
 			ret = -EFAULT;
 			goto out;
 		}
 		break;
 	case SONYPI_IOCGBAT2CAP:
-		val16 = sonypi_ecrget16(0xba);
+		val16 = sonypi_ecrget16(SONYPI_BAT2_FULL);
 		if (copy_to_user((u16 *)arg, &val16, sizeof(val16))) {
 			ret = -EFAULT;
 			goto out;
 		}
 		break;
 	case SONYPI_IOCGBAT2REM:
-		val16 = sonypi_ecrget16(0xaa);
+		val16 = sonypi_ecrget16(SONYPI_BAT2_LEFT);
 		if (copy_to_user((u16 *)arg, &val16, sizeof(val16))) {
 			ret = -EFAULT;
 			goto out;
 		}
 		break;
 	case SONYPI_IOCGBATFLAGS:
-		val8 = sonypi_ecrget(0x81) & 0x07;
+		val8 = sonypi_ecrget(SONYPI_BAT_FLAGS) & 0x07;
 		if (copy_to_user((u8 *)arg, &val8, sizeof(val8))) {
 			ret = -EFAULT;
 			goto out;
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
