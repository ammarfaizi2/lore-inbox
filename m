Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbTJZQpm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 11:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbTJZQpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 11:45:42 -0500
Received: from m77.net81-65-140.noos.fr ([81.65.140.77]:15273 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S263292AbTJZQpk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 11:45:40 -0500
Date: Sun, 26 Oct 2003 17:45:02 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.23-pre8] sonypi driver update
Message-ID: <20031026164502.GQ4013@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	marcelo.tosatti@cyclades.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a small update to the sonypi driver which:
	* corrects the events for the Zoom and Help buttons
	* uses the irqreturn_t constructs backported from 2.5.

This is not very intrusive and safe to be applied somewhat
late in the -pre cycle.

Marcelo, please apply.

Thanks.

Stelian.

===== drivers/char/sonypi.h 1.19 vs edited =====
--- 1.19/drivers/char/sonypi.h	Mon Sep  1 12:37:24 2003
+++ edited/drivers/char/sonypi.h	Sun Oct 26 15:31:16 2003
@@ -37,7 +37,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	 1
-#define SONYPI_DRIVER_MINORVERSION	20
+#define SONYPI_DRIVER_MINORVERSION	21
 
 #define SONYPI_DEVICE_MODEL_TYPE1	1
 #define SONYPI_DEVICE_MODEL_TYPE2	2
@@ -329,8 +329,8 @@
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_PKEY_MASK, sonypi_pkeyev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x11, SONYPI_BACK_MASK, sonypi_backev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_HELP_MASK, sonypi_helpev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_ZOOM_MASK, sonypi_zoomev },
-	{ SONYPI_DEVICE_MODEL_TYPE2, 0x08, SONYPI_THUMBPHRASE_MASK, sonypi_thumbphraseev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x21, SONYPI_ZOOM_MASK, sonypi_zoomev },
+	{ SONYPI_DEVICE_MODEL_TYPE2, 0x20, SONYPI_THUMBPHRASE_MASK, sonypi_thumbphraseev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x31, SONYPI_MEMORYSTICK_MASK, sonypi_memorystickev },
 	{ SONYPI_DEVICE_MODEL_TYPE2, 0x41, SONYPI_BATTERY_MASK, sonypi_batteryev },
 
===== drivers/char/sonypi.c 1.17 vs edited =====
--- 1.17/drivers/char/sonypi.c	Fri Aug  1 14:35:17 2003
+++ edited/drivers/char/sonypi.c	Wed Sep  3 09:58:01 2003
@@ -303,7 +303,7 @@
 }
 
 /* Interrupt handler: some event is available */
-void sonypi_irq(int irq, void *dev_id, struct pt_regs *regs) {
+static irqreturn_t sonypi_irq(int irq, void *dev_id, struct pt_regs *regs) {
 	u8 v1, v2, event = 0;
 	int i, j;
 
@@ -328,7 +328,10 @@
 	if (verbose)
 		printk(KERN_WARNING 
 		       "sonypi: unknown event port1=0x%02x,port2=0x%02x\n",v1,v2);
-	return;
+	/* We need to return IRQ_HANDLED here because there *are*
+	 * events belonging to the sonypi device we don't know about, 
+	 * but we still don't want those to pollute the logs... */
+	return IRQ_HANDLED;
 
 found:
 	if (verbose > 1)
@@ -351,6 +354,7 @@
 	}
 #endif /* SONYPI_USE_INPUT */
 	sonypi_pushq(event);
+	return IRQ_HANDLED;
 }
 
 /* External camera command (exported to the motion eye v4l driver) */
-- 
Stelian Pop <stelian@popies.net>
