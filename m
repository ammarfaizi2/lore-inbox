Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267167AbSLKOla>; Wed, 11 Dec 2002 09:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267165AbSLKOla>; Wed, 11 Dec 2002 09:41:30 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:4758 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S267167AbSLKOl0>; Wed, 11 Dec 2002 09:41:26 -0500
Date: Wed, 11 Dec 2002 15:49:06 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 2.5.51] sonypi driver update
Message-ID: <20021211154906.E22483@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This little patch changes the way button release events are reported
by the sonypi driver to the application: previously, separate 
release events were detected for each button. However, many buttons
(example: the jogdial, the capture button, the back button etc) share 
the same release event.

The attached patch propagates a single 'ANYBUTTON_RELEASED' event
to the userspace, leaving all state machine intelligence to the
application.

Kunihiko IMAI should be credited for his ideas and tests.

Linus, please apply.

Stelian.

===== include/linux/sonypi.h 1.7 vs edited =====
--- 1.7/include/linux/sonypi.h	Mon Dec  2 12:14:30 2002
+++ edited/include/linux/sonypi.h	Tue Dec  3 14:40:25 2002
@@ -43,9 +43,9 @@
 #define SONYPI_EVENT_JOGDIAL_DOWN_PRESSED	 3
 #define SONYPI_EVENT_JOGDIAL_UP_PRESSED		 4
 #define SONYPI_EVENT_JOGDIAL_PRESSED		 5
-#define SONYPI_EVENT_JOGDIAL_RELEASED		 6
+#define SONYPI_EVENT_JOGDIAL_RELEASED		 6	/* obsolete */
 #define SONYPI_EVENT_CAPTURE_PRESSED		 7
-#define SONYPI_EVENT_CAPTURE_RELEASED		 8
+#define SONYPI_EVENT_CAPTURE_RELEASED		 8	/* obsolete */
 #define SONYPI_EVENT_CAPTURE_PARTIALPRESSED	 9
 #define SONYPI_EVENT_CAPTURE_PARTIALRELEASED	10
 #define SONYPI_EVENT_FNKEY_ESC			11
@@ -93,7 +93,7 @@
 #define SONYPI_EVENT_MEYE_OPPOSITE		53
 #define SONYPI_EVENT_MEMORYSTICK_INSERT		54
 #define SONYPI_EVENT_MEMORYSTICK_EJECT		55
-
+#define SONYPI_EVENT_ANYBUTTON_RELEASED		56
 
 /* get/set brightness */
 #define SONYPI_IOCGBRT		_IOR('v', 0, __u8)
===== drivers/char/sonypi.h 1.13 vs edited =====
--- 1.13/drivers/char/sonypi.h	Mon Dec  2 12:16:40 2002
+++ edited/drivers/char/sonypi.h	Wed Dec 11 15:33:00 2002
@@ -37,7 +37,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	 1
-#define SONYPI_DRIVER_MINORVERSION	16
+#define SONYPI_DRIVER_MINORVERSION	17
 
 #define SONYPI_DEVICE_MODEL_TYPE1	1
 #define SONYPI_DEVICE_MODEL_TYPE2	2
@@ -171,6 +171,13 @@
 	u8	data;
 	u8	event;
 };
+
+/* The set of possible button release events */
+static struct sonypi_event sonypi_releaseev[] = {
+	{ 0x00, SONYPI_EVENT_ANYBUTTON_RELEASED },
+	{ 0, 0 }
+};
+
 /* The set of possible jogger events  */
 static struct sonypi_event sonypi_joggerev[] = {
 	{ 0x1f, SONYPI_EVENT_JOGDIAL_UP },
@@ -186,7 +193,6 @@
 	{ 0x5d, SONYPI_EVENT_JOGDIAL_VFAST_UP_PRESSED },
 	{ 0x43, SONYPI_EVENT_JOGDIAL_VFAST_DOWN_PRESSED },
 	{ 0x40, SONYPI_EVENT_JOGDIAL_PRESSED },
-	{ 0x00, SONYPI_EVENT_JOGDIAL_RELEASED },
 	{ 0, 0 }
 };
 
@@ -195,7 +201,6 @@
 	{ 0x05, SONYPI_EVENT_CAPTURE_PARTIALPRESSED },
 	{ 0x07, SONYPI_EVENT_CAPTURE_PRESSED },
 	{ 0x01, SONYPI_EVENT_CAPTURE_PARTIALRELEASED },
-	{ 0x00, SONYPI_EVENT_CAPTURE_RELEASED },
 	{ 0, 0 }
 };
 
@@ -293,6 +298,7 @@
 	unsigned long		mask;
 	struct sonypi_event *	events;
 } sonypi_eventtypes[] = {
+	{ SONYPI_DEVICE_MODEL_TYPE1, 0, 0xffffffff, sonypi_releaseev },
 	{ SONYPI_DEVICE_MODEL_TYPE1, 0x70, SONYPI_MEYE_MASK, sonypi_meyeev },
 	{ SONYPI_DEVICE_MODEL_TYPE1, 0x30, SONYPI_LID_MASK, sonypi_lidev },
 	{ SONYPI_DEVICE_MODEL_TYPE1, 0x60, SONYPI_CAPTURE_MASK, sonypi_captureev },
@@ -301,6 +307,7 @@
 	{ SONYPI_DEVICE_MODEL_TYPE1, 0x30, SONYPI_BLUETOOTH_MASK, sonypi_blueev },
 	{ SONYPI_DEVICE_MODEL_TYPE1, 0x40, SONYPI_PKEY_MASK, sonypi_pkeyev },
 
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0, 0xffffffff, sonypi_releaseev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x38, SONYPI_LID_MASK, sonypi_lidev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_JOGGER_MASK, sonypi_joggerev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_CAPTURE_MASK, sonypi_captureev },
===== drivers/char/sonypi.c 1.12 vs edited =====
--- 1.12/drivers/char/sonypi.c	Fri Nov 22 14:46:41 2002
+++ edited/drivers/char/sonypi.c	Wed Dec 11 12:34:17 2002
@@ -714,11 +714,11 @@
 	       SONYPI_DRIVER_MAJORVERSION,
 	       SONYPI_DRIVER_MINORVERSION);
 	printk(KERN_INFO "sonypi: detected %s model, "
-	       "verbose = %s, fnkeyinit = %s, camera = %s, "
+	       "verbose = %d, fnkeyinit = %s, camera = %s, "
 	       "compat = %s, mask = 0x%08lx\n",
 	       (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE1) ?
 			"type1" : "type2",
-	       verbose ? "on" : "off",
+	       verbose,
 	       fnkeyinit ? "on" : "off",
 	       camera ? "on" : "off",
 	       compat ? "on" : "off",
-- 
Stelian Pop <stelian@popies.net>
