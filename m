Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWEWM2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWEWM2T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 08:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWEWM2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 08:28:18 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:6381 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1751187AbWEWM2S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 08:28:18 -0400
Subject: [PATCH] make ams work with latest kernels
From: Johannes Berg <johannes@sipsolutions.net>
To: Stelian Pop <stelian@popies.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 23 May 2006 13:32:23 +0200
Message-Id: <1148383943.25971.2.camel@johannes>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those who don't know: ams, written by Stelian Pop, is a driver for
the motion sensor present in some PowerBooks (the series the
PowerBook5,6 falls into, later ones have a slightly different one the
driver doesn't handle).

Even though we still don't seem to have a client that can actually use
this data (something to actually tell the hd to protect itself) I
updated the ams code to compile against the latest linux kernel
versions. I also fixed a buglet (the interrupt handler should return
IRQ_HANDLED even if the init flag isn't set yet since we own the
interrupts, they can't be shared).

Stelian and all, how about adding this driver to linux? hdaps seems to
be there even if it too doesn't serve a useful purpose at this time.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- ams-0.02.orig/ams.c	2006-05-22 15:24:51.545837212 +0200
+++ ams-0.02/ams.c	2006-05-22 15:36:10.175837212 +0200
@@ -97,7 +97,7 @@ struct ams {
 	int			irq1;		/* first irq line */
 	int			irq2;		/* second irq line */
 	struct work_struct	worker;		/* worker thread */
-	struct input_dev	idev;		/* input device */
+	struct input_dev	*idev;		/* input device */
 	char			iactive;	/* is the input device active ? */
 	int			xcalib;		/* calibrated null value for x */
 	int			ycalib;		/* calibrated null value for y */
@@ -110,9 +110,10 @@ static int ams_attach(struct i2c_adapter
 static int ams_detach(struct i2c_adapter *adapter);
 
 static struct i2c_driver ams_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "ams",
-	.flags		= I2C_DF_NOTIFY,
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "ams",
+	},
 	.attach_adapter	= ams_attach,
 	.detach_adapter	= ams_detach,
 };
@@ -210,10 +211,10 @@ static int ams_mouse_kthread(void *data)
 	while (!kthread_should_stop()) {
 		ams_sensors(&x, &y, &z);
 
-		input_report_abs(&ams.idev, ABS_X, x - ams.xcalib);
-		input_report_abs(&ams.idev, ABS_Y, y - ams.ycalib);
+		input_report_abs(ams.idev, ABS_X, x - ams.xcalib);
+		input_report_abs(ams.idev, ABS_Y, y - ams.ycalib);
 
-		input_sync(&ams.idev);
+		input_sync(ams.idev);
 
 		msleep(25);
 	}
@@ -231,22 +232,24 @@ static void ams_mouse_enable(void)
 	ams.xcalib = x;
 	ams.ycalib = y;
 
-	init_input_dev(&ams.idev);
-	ams.idev.name = "ams";
-	ams.idev.dev = &ams.client.dev;
-
-	input_set_abs_params(&ams.idev, ABS_X, -50, 50, 3, 0);
-	input_set_abs_params(&ams.idev, ABS_Y, -50, 50, 3, 0);
-
-	set_bit(EV_ABS, ams.idev.evbit);
-	set_bit(EV_KEY, ams.idev.evbit);
-	set_bit(BTN_TOUCH, ams.idev.keybit);
+	ams.idev = input_allocate_device();
+	if (!ams.idev)
+		return;
+	ams.idev->name = "Apple Motion Sensor";
+	ams.idev->dev = &ams.client.dev;
+
+	input_set_abs_params(ams.idev, ABS_X, -50, 50, 3, 0);
+	input_set_abs_params(ams.idev, ABS_Y, -50, 50, 3, 0);
+
+	set_bit(EV_ABS, ams.idev->evbit);
+	set_bit(EV_KEY, ams.idev->evbit);
+	set_bit(BTN_TOUCH, ams.idev->keybit);
 
 	ams.kthread = kthread_run(ams_mouse_kthread, NULL, "kams");
 	if (IS_ERR(ams.kthread))
 		return;
 
-	input_register_device(&ams.idev);
+	input_register_device(ams.idev);
 	ams.iactive = 1;
 }
 
@@ -257,7 +260,8 @@ static void ams_mouse_disable(void)
 
 	kthread_stop(ams.kthread);
 
-	input_unregister_device(&ams.idev);
+	if (ams.idev)
+		input_unregister_device(ams.idev);
 
 	ams.iactive = 0;
 }
@@ -300,7 +304,7 @@ static void ams_worker(void *data)
 static irqreturn_t ams_interrupt(int irq, void *devid, struct pt_regs *regs)
 {
 	if (!ams.init)
-		return IRQ_NONE;
+		return IRQ_HANDLED;
 	schedule_work(&ams.worker);
 	return IRQ_HANDLED;
 }
@@ -471,7 +475,7 @@ static int __init ams_init(void)
 
 	INIT_WORK(&ams.worker, ams_worker, NULL);
 
-	if ((ams.of_dev = of_platform_device_create(np, "ams")) == NULL) {
+	if ((ams.of_dev = of_platform_device_create(np, "ams", NULL)) == NULL) {
 		free_irq(ams.irq1, NULL);
 		free_irq(ams.irq2, NULL);
 		return -ENODEV;


