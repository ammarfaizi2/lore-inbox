Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVG2JtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVG2JtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVG2Jr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:47:28 -0400
Received: from tim.rpsys.net ([194.106.48.114]:61375 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262552AbVG2Jqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:46:51 -0400
Subject: [patch 2/8] Corgi Keyboard: Add some power management code
From: Richard Purdie <rpurdie@rpsys.net>
To: akpm@osdl.org
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 29 Jul 2005 10:46:36 +0100
Message-Id: <1122630396.7747.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some power management code to the corgi keyboard driver so that
only one power event gets reported within any reasonable time frame
and the driver doesn't enter an infinte loop due to key repeat.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.12/drivers/input/keyboard/corgikbd.c
===================================================================
--- linux-2.6.12.orig/drivers/input/keyboard/corgikbd.c	2005-07-28 16:35:37.000000000 +0100
+++ linux-2.6.12/drivers/input/keyboard/corgikbd.c	2005-07-28 16:42:04.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
+#include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <asm/irq.h>
@@ -78,6 +79,9 @@
 
 	struct timer_list timer;
 	struct timer_list htimer;
+
+	unsigned int suspended;
+	unsigned long suspend_jiffies;
 };
 
 static void handle_scancode(unsigned int pressed,unsigned int scancode, struct corgikbd *corgikbd_data)
@@ -85,8 +89,11 @@
 	if (pressed && !(corgikbd_data->state[scancode] & CORGIKBD_PRESSED)) {
 		corgikbd_data->state[scancode] |= CORGIKBD_PRESSED;
 		input_report_key(&corgikbd_data->input, corgikbd_data->keycode[scancode], 1);
-		if (corgikbd_data->keycode[scancode] == CORGI_KEY_OFF)
+		if ((corgikbd_data->keycode[scancode] == CORGI_KEY_OFF)
+				&& time_after(jiffies, corgikbd_data->suspend_jiffies + HZ)) {
 			input_event(&corgikbd_data->input, EV_PWR, CORGI_KEY_OFF, 1);
+			corgikbd_data->suspend_jiffies=jiffies;
+		}
 	} else if (!pressed && corgikbd_data->state[scancode] & CORGIKBD_PRESSED) {
 		corgikbd_data->state[scancode] &= ~CORGIKBD_PRESSED;
 		input_report_key(&corgikbd_data->input, corgikbd_data->keycode[scancode], 0);
@@ -153,6 +160,9 @@
 	unsigned long flags;
 	unsigned int num_pressed;
 
+	if (corgikbd_data->suspended)
+		return;
+
 	spin_lock_irqsave(&corgikbd_data->lock, flags);
 
 	if (regs)
@@ -255,6 +265,32 @@
 	mod_timer(&corgikbd_data->htimer, jiffies + HINGE_SCAN_INTERVAL);
 }
 
+#ifdef CONFIG_PM
+static int corgikbd_suspend(struct device *dev, pm_message_t state, uint32_t level)
+{
+	if (level == SUSPEND_POWER_DOWN) {
+		struct corgikbd *corgikbd = dev_get_drvdata(dev);
+		corgikbd->suspended = 1;
+	}
+	return 0;
+}
+
+static int corgikbd_resume(struct device *dev, uint32_t level)
+{
+	if (level == RESUME_POWER_ON) {
+		struct corgikbd *corgikbd = dev_get_drvdata(dev);
+
+		/* Upon resume, ignore the suspend key for a short while */
+		corgikbd->suspend_jiffies=jiffies;
+		corgikbd->suspended = 0;
+	}
+	return 0;
+}
+#else
+#define corgikbd_suspend	NULL
+#define corgikbd_resume		NULL
+#endif
+
 static int __init corgikbd_probe(struct device *dev)
 {
 	int i;
@@ -279,6 +315,8 @@
 	corgikbd->htimer.function = corgikbd_hinge_timer;
 	corgikbd->htimer.data = (unsigned long) corgikbd;
 
+	corgikbd->suspend_jiffies=jiffies;
+
 	init_input_dev(&corgikbd->input);
 	corgikbd->input.private = corgikbd;
 	corgikbd->input.name = "Corgi Keyboard";
@@ -343,6 +381,8 @@
 	.bus		= &platform_bus_type,
 	.probe		= corgikbd_probe,
 	.remove		= corgikbd_remove,
+	.suspend	= corgikbd_suspend,
+	.resume		= corgikbd_resume,
 };
 
 static int __devinit corgikbd_init(void)


