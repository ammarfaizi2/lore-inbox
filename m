Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030399AbWBAFlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbWBAFlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWBAFlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:41:08 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:12986 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030399AbWBAFlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:41:05 -0500
Message-Id: <20060201050735.132988000.dtor_core@ameritech.net>
References: <20060201045514.178498000.dtor_core@ameritech.net>
Date: Tue, 31 Jan 2006 23:55:30 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: [GIT PATCH 16/18] a3d: convert to dynamic input_dev allocation
Content-Disposition: inline; filename=input-dynalloc-a3d.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: a3d - convert to dynamic input_dev allocation

Also set .owner in driver structure so we'll have a link between
module and driver in sysfs.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/a3d.c |   88 ++++++++++++++++++++++---------------------
 1 files changed, 46 insertions(+), 42 deletions(-)

Index: work/drivers/input/joystick/a3d.c
===================================================================
--- work.orig/drivers/input/joystick/a3d.c
+++ work/drivers/input/joystick/a3d.c
@@ -57,7 +57,7 @@ static char *a3d_names[] = { NULL, "FP-G
 struct a3d {
 	struct gameport *gameport;
 	struct gameport *adc;
-	struct input_dev dev;
+	struct input_dev *dev;
 	int axes[4];
 	int buttons;
 	int mode;
@@ -115,7 +115,7 @@ static int a3d_csum(char *data, int coun
 
 static void a3d_read(struct a3d *a3d, unsigned char *data)
 {
-	struct input_dev *dev = &a3d->dev;
+	struct input_dev *dev = a3d->dev;
 
 	switch (a3d->mode) {
 
@@ -265,14 +265,20 @@ static void a3d_close(struct input_dev *
 static int a3d_connect(struct gameport *gameport, struct gameport_driver *drv)
 {
 	struct a3d *a3d;
+	struct input_dev *input_dev;
 	struct gameport *adc;
 	unsigned char data[A3D_MAX_LENGTH];
 	int i;
 	int err;
 
-	if (!(a3d = kzalloc(sizeof(struct a3d), GFP_KERNEL)))
-		return -ENOMEM;
+	a3d = kzalloc(sizeof(struct a3d), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!a3d || !input_dev) {
+		err = -ENOMEM;
+		goto fail1;
+	}
 
+	a3d->dev = input_dev;
 	a3d->gameport = gameport;
 
 	gameport_set_drvdata(gameport, a3d);
@@ -302,42 +308,48 @@ static int a3d_connect(struct gameport *
 
 	sprintf(a3d->phys, "%s/input0", gameport->phys);
 
+	input_dev->name = a3d_names[a3d->mode];
+	input_dev->phys = a3d->phys;
+	input_dev->id.bustype = BUS_GAMEPORT;
+	input_dev->id.vendor = GAMEPORT_ID_VENDOR_MADCATZ;
+	input_dev->id.product = a3d->mode;
+	input_dev->id.version = 0x0100;
+	input_dev->cdev.dev = &gameport->dev;
+	input_dev->private = a3d;
+	input_dev->open = a3d_open;
+	input_dev->close = a3d_close;
+
 	if (a3d->mode == A3D_MODE_PXL) {
 
 		int axes[] = { ABS_X, ABS_Y, ABS_THROTTLE, ABS_RUDDER };
 
 		a3d->length = 33;
 
-		init_input_dev(&a3d->dev);
-
-		a3d->dev.evbit[0] |= BIT(EV_ABS) | BIT(EV_KEY) | BIT(EV_REL);
-		a3d->dev.relbit[0] |= BIT(REL_X) | BIT(REL_Y);
-		a3d->dev.absbit[0] |= BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_THROTTLE) | BIT(ABS_RUDDER)
-				   | BIT(ABS_HAT0X) | BIT(ABS_HAT0Y) | BIT(ABS_HAT1X) | BIT(ABS_HAT1Y);
-
-		a3d->dev.keybit[LONG(BTN_MOUSE)] |= BIT(BTN_RIGHT) | BIT(BTN_LEFT) | BIT(BTN_MIDDLE)
-						 | BIT(BTN_SIDE) | BIT(BTN_EXTRA);
-
-		a3d->dev.keybit[LONG(BTN_JOYSTICK)] |= BIT(BTN_TRIGGER) | BIT(BTN_THUMB) | BIT(BTN_TOP) | BIT(BTN_PINKIE);
+		input_dev->evbit[0] |= BIT(EV_ABS) | BIT(EV_KEY) | BIT(EV_REL);
+		input_dev->relbit[0] |= BIT(REL_X) | BIT(REL_Y);
+		input_dev->absbit[0] |= BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_THROTTLE) | BIT(ABS_RUDDER)
+					| BIT(ABS_HAT0X) | BIT(ABS_HAT0Y) | BIT(ABS_HAT1X) | BIT(ABS_HAT1Y);
+		input_dev->keybit[LONG(BTN_MOUSE)] |= BIT(BTN_RIGHT) | BIT(BTN_LEFT) | BIT(BTN_MIDDLE)
+							| BIT(BTN_SIDE) | BIT(BTN_EXTRA);
+		input_dev->keybit[LONG(BTN_JOYSTICK)] |= BIT(BTN_TRIGGER) | BIT(BTN_THUMB) | BIT(BTN_TOP)
+							| BIT(BTN_PINKIE);
 
 		a3d_read(a3d, data);
 
 		for (i = 0; i < 4; i++) {
 			if (i < 2)
-				input_set_abs_params(&a3d->dev, axes[i], 48, a3d->dev.abs[axes[i]] * 2 - 48, 0, 8);
+				input_set_abs_params(input_dev, axes[i], 48, input_dev->abs[axes[i]] * 2 - 48, 0, 8);
 			else
-				input_set_abs_params(&a3d->dev, axes[i], 2, 253, 0, 0);
-			input_set_abs_params(&a3d->dev, ABS_HAT0X + i, -1, 1, 0, 0);
+				input_set_abs_params(input_dev, axes[i], 2, 253, 0, 0);
+			input_set_abs_params(input_dev, ABS_HAT0X + i, -1, 1, 0, 0);
 		}
 
 	} else {
 		a3d->length = 29;
 
-		init_input_dev(&a3d->dev);
-
-		a3d->dev.evbit[0] |= BIT(EV_KEY) | BIT(EV_REL);
-		a3d->dev.relbit[0] |= BIT(REL_X) | BIT(REL_Y);
-		a3d->dev.keybit[LONG(BTN_MOUSE)] |= BIT(BTN_RIGHT) | BIT(BTN_LEFT) | BIT(BTN_MIDDLE);
+		input_dev->evbit[0] |= BIT(EV_KEY) | BIT(EV_REL);
+		input_dev->relbit[0] |= BIT(REL_X) | BIT(REL_Y);
+		input_dev->keybit[LONG(BTN_MOUSE)] |= BIT(BTN_RIGHT) | BIT(BTN_LEFT) | BIT(BTN_MIDDLE);
 
 		a3d_read(a3d, data);
 
@@ -358,24 +370,17 @@ static int a3d_connect(struct gameport *
 		}
 	}
 
-	a3d->dev.private = a3d;
-	a3d->dev.open = a3d_open;
-	a3d->dev.close = a3d_close;
-
-	a3d->dev.name = a3d_names[a3d->mode];
-	a3d->dev.phys = a3d->phys;
-	a3d->dev.id.bustype = BUS_GAMEPORT;
-	a3d->dev.id.vendor = GAMEPORT_ID_VENDOR_MADCATZ;
-	a3d->dev.id.product = a3d->mode;
-	a3d->dev.id.version = 0x0100;
-
-	input_register_device(&a3d->dev);
-	printk(KERN_INFO "input: %s on %s\n", a3d_names[a3d->mode], a3d->phys);
+	err = input_register_device(a3d->dev);
+	if (err)
+		goto fail3;
 
 	return 0;
 
-fail2:	gameport_close(gameport);
-fail1:  gameport_set_drvdata(gameport, NULL);
+ fail3:	if (a3d->adc)
+		gameport_unregister_port(a3d->adc);
+ fail2:	gameport_close(gameport);
+ fail1:	gameport_set_drvdata(gameport, NULL);
+	input_free_device(input_dev);
 	kfree(a3d);
 	return err;
 }
@@ -384,11 +389,9 @@ static void a3d_disconnect(struct gamepo
 {
 	struct a3d *a3d = gameport_get_drvdata(gameport);
 
-	input_unregister_device(&a3d->dev);
-	if (a3d->adc) {
+	input_unregister_device(a3d->dev);
+	if (a3d->adc)
 		gameport_unregister_port(a3d->adc);
-		a3d->adc = NULL;
-	}
 	gameport_close(gameport);
 	gameport_set_drvdata(gameport, NULL);
 	kfree(a3d);
@@ -397,6 +400,7 @@ static void a3d_disconnect(struct gamepo
 static struct gameport_driver a3d_drv = {
 	.driver		= {
 		.name	= "adc",
+		.owner	= THIS_MODULE,
 	},
 	.description	= DRIVER_DESC,
 	.connect	= a3d_connect,

