Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264672AbUEXU11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264672AbUEXU11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbUEXU11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:27:27 -0400
Received: from mail.appliedminds.com ([65.104.119.58]:43495 "EHLO
	appliedminds.com") by vger.kernel.org with ESMTP id S264672AbUEXUZG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:25:06 -0400
Message-ID: <40B259E6.5060305@appliedminds.com>
Date: Mon, 24 May 2004 13:24:06 -0700
From: James Lamanna <jamesl@appliedminds.com>
User-Agent: Mozilla Thunderbird 0.6+ (X11/20040421)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix locking warnings in Powermate driver
Content-Type: multipart/mixed;
 boundary="------------020801070001000308020409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020801070001000308020409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fixes this warning:

May 18 06:56:01 Knoppix kernel: Debug: sleeping function called from
invalid context at include/asm/semaphore.h:119
May 18 06:56:01 Knoppix kernel: in_atomic():1, irqs_disabled():0
May 18 06:56:01 Knoppix kernel: Call Trace:
May 18 06:56:01 Knoppix kernel:  [<c0117083>] __might_sleep+0xb2/0xd3
May 18 06:56:01 Knoppix kernel:  [<f88b92f4>]
powermate_config_complete+0x33/0x77 [powermate]
May 18 06:56:01 Knoppix kernel:  [<c02c6760>]
usb_hcd_giveback_urb+0x25/0x39
May 18 06:56:01 Knoppix kernel:  [<c02d7194>] uhci_finish_urb+0x54/0xa1
May 18 06:56:01 Knoppix kernel:  [<c02d7224>]
uhci_finish_completion+0x43/0x55
May 18 06:56:01 Knoppix kernel:  [<c02d737d>] uhci_irq+0xf8/0x179
May 18 06:56:01 Knoppix kernel:  [<c02c67aa>] usb_hcd_irq+0x36/0x67
May 18 06:56:01 Knoppix kernel:  [<c01060c6>] handle_IRQ_event+0x3a/0x64
May 18 06:56:01 Knoppix kernel:  [<c0106479>] do_IRQ+0xb8/0x192
May 18 06:56:01 Knoppix kernel:  [<c0104850>] common_interrupt+0x18/0x20

Attached patch uses spinlocks instead of a semaphore so that we can't
sleep when in_atomic().



-- 
James Lamanna

--------------020801070001000308020409
Content-Type: text/plain;
 name="powermate.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="powermate.diff"

--- linux-2.6.6/drivers/usb/input/powermate.c.old	2004-05-24 08:59:18.000000000 +0200
+++ linux-2.6.6/drivers/usb/input/powermate.c	2004-05-24 12:14:54.000000000 +0200
@@ -33,6 +33,7 @@
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/spinlock.h>
 #include <linux/usb.h>
 
 #define POWERMATE_VENDOR	0x077d	/* Griffin Technology, Inc. */
@@ -67,7 +68,7 @@
 	dma_addr_t configcr_dma;
 	struct usb_device *udev;
 	struct input_dev input;
-	struct semaphore lock;
+	spinlock_t lock;
 	int static_brightness;
 	int pulse_speed;
 	int pulse_table;
@@ -116,7 +117,7 @@
 		     __FUNCTION__, retval);
 }
 
-/* Decide if we need to issue a control message and do so. Must be called with pm->lock down */
+/* Decide if we need to issue a control message and do so. Must be called with pm->lock taken */
 static void powermate_sync_state(struct powermate_device *pm)
 {
 	if (pm->requires_update == 0) 
@@ -194,19 +195,22 @@
 static void powermate_config_complete(struct urb *urb, struct pt_regs *regs)
 {
 	struct powermate_device *pm = urb->context;
+	unsigned long flags;
 
 	if (urb->status)
 		printk(KERN_ERR "powermate: config urb returned %d\n", urb->status);
 	
-	down(&pm->lock);
+	spin_lock_irqsave(&pm->lock, flags);
 	powermate_sync_state(pm);
-	up(&pm->lock);
+	spin_unlock_irqrestore(&pm->lock, flags);
 }
 
 /* Set the LED up as described and begin the sync with the hardware if required */
 static void powermate_pulse_led(struct powermate_device *pm, int static_brightness, int pulse_speed, 
 				int pulse_table, int pulse_asleep, int pulse_awake)
 {
+	unsigned long flags;
+
 	if (pulse_speed < 0)
 		pulse_speed = 0;
 	if (pulse_table < 0)
@@ -219,7 +223,8 @@
 	pulse_asleep = !!pulse_asleep;
 	pulse_awake = !!pulse_awake;
 
-	down(&pm->lock);
+
+	spin_lock_irqsave(&pm->lock, flags);
 
 	/* mark state updates which are required */
 	if (static_brightness != pm->static_brightness){
@@ -242,7 +247,7 @@
 
 	powermate_sync_state(pm);
    
-	up(&pm->lock);
+	spin_unlock_irqrestore(&pm->lock, flags);
 }
 
 /* Callback from the Input layer when an event arrives from userspace to configure the LED */
@@ -344,7 +349,7 @@
 		return -ENOMEM;
 	}
 
-	init_MUTEX(&pm->lock);
+	pm->lock = SPIN_LOCK_UNLOCKED;
 	init_input_dev(&pm->input);
 
 	/* get a handle to the interrupt data pipe */
@@ -411,7 +416,6 @@
 
 	usb_set_intfdata(intf, NULL);
 	if (pm) {
-		down(&pm->lock);
 		pm->requires_update = 0;
 		usb_unlink_urb(pm->irq);
 		input_unregister_device(&pm->input);

--------------020801070001000308020409--
