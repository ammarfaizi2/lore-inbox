Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWBOGPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWBOGPA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422995AbWBOGOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:14:12 -0500
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:22688 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1422999AbWBOGOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:14:07 -0500
Message-Id: <20060215061150.319411000.dtor_core@ameritech.net>
References: <20060215060140.243794000.dtor_core@ameritech.net>
Date: Wed, 15 Feb 2006 01:01:44 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PATCH 4/6] ads7846: convert to to dynamic input_dev allocation
Content-Disposition: inline; filename=input-dynalloc-ads7846.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: ads7846 - convert to to dynamic input_dev allocation

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/ads7846.c |   81 +++++++++++++++++++++---------------
 1 files changed, 48 insertions(+), 33 deletions(-)

Index: work/drivers/input/touchscreen/ads7846.c
===================================================================
--- work.orig/drivers/input/touchscreen/ads7846.c
+++ work/drivers/input/touchscreen/ads7846.c
@@ -60,7 +60,7 @@ struct ts_event {
 };
 
 struct ads7846 {
-	struct input_dev	input;
+	struct input_dev	*input;
 	char			phys[32];
 
 	struct spi_device	*spi;
@@ -152,7 +152,7 @@ static int ads7846_read12_ser(struct dev
 	struct ser_req		*req = kzalloc(sizeof *req, SLAB_KERNEL);
 	int			status;
 	int			sample;
-	int 			i;
+	int			i;
 
 	if (!req)
 		return -ENOMEM;
@@ -236,11 +236,12 @@ SHOW(vbatt)
 
 static void ads7846_rx(void *ads)
 {
-	struct ads7846	*ts = ads;
-	unsigned	Rt;
-	unsigned	sync = 0;
-	u16		x, y, z1, z2;
-	unsigned long	flags;
+	struct ads7846		*ts = ads;
+	struct input_dev	*input_dev = ts->input;
+	unsigned		Rt;
+	unsigned		sync = 0;
+	u16			x, y, z1, z2;
+	unsigned long		flags;
 
 	/* adjust:  12 bit samples (left aligned), built from
 	 * two 8 bit values writen msb-first.
@@ -276,21 +277,21 @@ static void ads7846_rx(void *ads)
 	 * won't notice that, even if nPENIRQ never fires ...
 	 */
 	if (!ts->pendown && Rt != 0) {
-		input_report_key(&ts->input, BTN_TOUCH, 1);
+		input_report_key(input_dev, BTN_TOUCH, 1);
 		sync = 1;
 	} else if (ts->pendown && Rt == 0) {
-		input_report_key(&ts->input, BTN_TOUCH, 0);
+		input_report_key(input_dev, BTN_TOUCH, 0);
 		sync = 1;
 	}
 
 	if (Rt) {
-		input_report_abs(&ts->input, ABS_X, x);
-		input_report_abs(&ts->input, ABS_Y, y);
-		input_report_abs(&ts->input, ABS_PRESSURE, Rt);
+		input_report_abs(input_dev, ABS_X, x);
+		input_report_abs(input_dev, ABS_Y, y);
+		input_report_abs(input_dev, ABS_PRESSURE, Rt);
 		sync = 1;
 	}
 	if (sync)
-		input_sync(&ts->input);
+		input_sync(input_dev);
 
 #ifdef	VERBOSE
 	if (Rt || ts->pendown)
@@ -396,9 +397,11 @@ static int ads7846_resume(struct spi_dev
 static int __devinit ads7846_probe(struct spi_device *spi)
 {
 	struct ads7846			*ts;
+	struct input_dev		*input_dev;
 	struct ads7846_platform_data	*pdata = spi->dev.platform_data;
 	struct spi_transfer		*x;
 	int				i;
+	int				err;
 
 	if (!spi->irq) {
 		dev_dbg(&spi->dev, "no IRQ?\n");
@@ -423,13 +426,18 @@ static int __devinit ads7846_probe(struc
 	 * to discard the four garbage LSBs.
 	 */
 
-	if (!(ts = kzalloc(sizeof(struct ads7846), GFP_KERNEL)))
-		return -ENOMEM;
+	ts = kzalloc(sizeof(struct ads7846), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!ts || !input_dev) {
+		err = -ENOMEM;
+		goto err_free_mem;
+	}
 
 	dev_set_drvdata(&spi->dev, ts);
+	spi->dev.power.power_state = PMSG_ON;
 
 	ts->spi = spi;
-	spi->dev.power.power_state = PMSG_ON;
+	ts->input = input_dev;
 
 	init_timer(&ts->timer);
 	ts->timer.data = (unsigned long) ts;
@@ -439,28 +447,25 @@ static int __devinit ads7846_probe(struc
 	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
 	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
 
-	init_input_dev(&ts->input);
+	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", spi->dev.bus_id);
 
-	ts->input.dev = &spi->dev;
-	ts->input.name = "ADS784x Touchscreen";
-	snprintf(ts->phys, sizeof ts->phys, "%s/input0", spi->dev.bus_id);
-	ts->input.phys = ts->phys;
-
-	ts->input.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-	ts->input.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
-	input_set_abs_params(&ts->input, ABS_X,
+	input_dev->name = "ADS784x Touchscreen";
+	input_dev->phys = ts->phys;
+	input_dev->cdev.dev = &spi->dev;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	input_dev->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_set_abs_params(input_dev, ABS_X,
 			pdata->x_min ? : 0,
 			pdata->x_max ? : MAX_12BIT,
 			0, 0);
-	input_set_abs_params(&ts->input, ABS_Y,
+	input_set_abs_params(input_dev, ABS_Y,
 			pdata->y_min ? : 0,
 			pdata->y_max ? : MAX_12BIT,
 			0, 0);
-	input_set_abs_params(&ts->input, ABS_PRESSURE,
+	input_set_abs_params(input_dev, ABS_PRESSURE,
 			pdata->pressure_min, pdata->pressure_max, 0, 0);
 
-	input_register_device(&ts->input);
-
 	/* set up the transfers to read touchscreen state; this assumes we
 	 * use formula #2 for pressure, not #3.
 	 */
@@ -510,9 +515,8 @@ static int __devinit ads7846_probe(struc
 			SA_SAMPLE_RANDOM | SA_TRIGGER_FALLING,
 			spi->dev.bus_id, ts)) {
 		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
-		input_unregister_device(&ts->input);
-		kfree(ts);
-		return -EBUSY;
+		err = -EBUSY;
+		goto err_free_mem;
 	}
 
 	dev_info(&spi->dev, "touchscreen, irq %d\n", spi->irq);
@@ -534,7 +538,18 @@ static int __devinit ads7846_probe(struc
 		device_create_file(&spi->dev, &dev_attr_vbatt);
 	device_create_file(&spi->dev, &dev_attr_vaux);
 
+	err = input_register_device(input_dev);
+	if (err)
+		goto err_free_irq;
+
 	return 0;
+
+ err_free_irq:
+	free_irq(spi->irq, ts);
+ err_free_mem:
+	input_free_device(input_dev);
+	kfree(ts);
+	return err;
 }
 
 static int __devexit ads7846_remove(struct spi_device *spi)
@@ -554,7 +569,7 @@ static int __devexit ads7846_remove(stru
 		device_remove_file(&spi->dev, &dev_attr_vbatt);
 	device_remove_file(&spi->dev, &dev_attr_vaux);
 
-	input_unregister_device(&ts->input);
+	input_unregister_device(ts->input);
 	kfree(ts);
 
 	dev_dbg(&spi->dev, "unregistered touchscreen\n");

