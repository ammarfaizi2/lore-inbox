Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWAZQU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWAZQU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWAZQU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:20:59 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:40551 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964781AbWAZQU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:20:59 -0500
From: David Brownell <david-b@pacbell.net>
To: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: [spi-devel-general] [patch 2.6.14-rc6-git 2/6] SPI ads7846 protocol driver
Date: Thu, 26 Jan 2006 08:20:57 -0800
User-Agent: KMail/1.7.1
Cc: spi-devel-general@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20060107141311.21713.qmail@web32911.mail.mud.yahoo.com>
In-Reply-To: <20060107141311.21713.qmail@web32911.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qbP2D/l2Ahic1RP"
Message-Id: <200601260820.58036.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_qbP2D/l2Ahic1RP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


> > > Also use input_allocate_device() instead of init_input_dev().
> > Thanx.
> > 
> > Got patch?  :)
> 
> I will do it with latest -mm next week.

Well, here's an update against 2.6.16-rc1-git.  It builds and
initializes, but lower level issues prevent my re-testing it.

- Dave

--Boundary-00=_qbP2D/l2Ahic1RP
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ads7846.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ads7846.patch"

This updates the ads7846 touchscreen driver
  
  - to match changes to the input subsystem that kicked in since it
    was first written and debugged;
    
  - to allow faster clocking (this driver doesn't push sample rates);

  - bugfixes the conversion of spi_transfer to lists;

  - some dma-unsafe command buffers are fixed.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>


Index: o2/drivers/input/touchscreen/ads7846.c
===================================================================
--- o2.orig/drivers/input/touchscreen/ads7846.c	2006-01-24 11:39:52.000000000 -0800
+++ o2/drivers/input/touchscreen/ads7846.c	2006-01-24 20:35:54.000000000 -0800
@@ -51,10 +51,13 @@
 
 #define	TS_POLL_PERIOD	msecs_to_jiffies(10)
 
+/* this driver doesn't aim at the peak continuous sample rate */
+#define	SAMPLE_BITS	(8 /*cmd*/ + 16 /*sample*/ + 2 /* before, after */)
+
 struct ts_event {
 	/* For portability, we can't read 12 bit values using SPI (which
 	 * would make the controller deliver them as native byteorder u16
-	 * with msbs zeroed).  Instead, we read them as two 8-byte values,
+	 * with msbs zeroed).  Instead, we read them as two 8-bit values,
 	 * which need byteswapping then range adjustment.
 	 */
 	__be16 x;
@@ -63,7 +66,7 @@ struct ts_event {
 };
 
 struct ads7846 {
-	struct input_dev	input;
+	struct input_dev	*input;
 	char			phys[32];
 
 	struct spi_device	*spi;
@@ -71,6 +74,7 @@ struct ads7846 {
 	u16			vref_delay_usecs;
 	u16			x_plate_ohms;
 
+	u8			read_x, read_y, read_z1, read_z2;
 	struct ts_event		tc;
 
 	struct spi_transfer	xfer[8];
@@ -141,7 +145,9 @@ static const u8	ref_off = READ_12BIT_DFR
  */
 
 struct ser_req {
+	u8			ref_on;
 	u8			command;
+	u8			ref_off;
 	u16			scratch;
 	__be16			sample;
 	struct spi_message	msg;
@@ -163,7 +169,8 @@ static int ads7846_read12_ser(struct dev
 	INIT_LIST_HEAD(&req->msg.transfers);
 
 	/* activate reference, so it has time to settle; */
-	req->xfer[0].tx_buf = &ref_on;
+	req->ref_on = ref_on;
+	req->xfer[0].tx_buf = &req->ref_on;
 	req->xfer[0].len = 1;
 	req->xfer[1].rx_buf = &req->scratch;
 	req->xfer[1].len = 2;
@@ -185,7 +192,8 @@ static int ads7846_read12_ser(struct dev
 	/* REVISIT:  take a few more samples, and compare ... */
 
 	/* turn off reference */
-	req->xfer[4].tx_buf = &ref_off;
+	req->ref_off = ref_off;
+	req->xfer[4].tx_buf = &req->ref_off;
 	req->xfer[4].len = 1;
 	req->xfer[5].rx_buf = &req->scratch;
 	req->xfer[5].len = 2;
@@ -279,21 +287,21 @@ static void ads7846_rx(void *ads)
 	 * won't notice that, even if nPENIRQ never fires ...
 	 */
 	if (!ts->pendown && Rt != 0) {
-		input_report_key(&ts->input, BTN_TOUCH, 1);
+		input_report_key(ts->input, BTN_TOUCH, 1);
 		sync = 1;
 	} else if (ts->pendown && Rt == 0) {
-		input_report_key(&ts->input, BTN_TOUCH, 0);
+		input_report_key(ts->input, BTN_TOUCH, 0);
 		sync = 1;
 	}
 
 	if (Rt) {
-		input_report_abs(&ts->input, ABS_X, x);
-		input_report_abs(&ts->input, ABS_Y, y);
-		input_report_abs(&ts->input, ABS_PRESSURE, Rt);
+		input_report_abs(ts->input, ABS_X, x);
+		input_report_abs(ts->input, ABS_Y, y);
+		input_report_abs(ts->input, ABS_PRESSURE, Rt);
 		sync = 1;
 	}
 	if (sync)
-		input_sync(&ts->input);
+		input_sync(ts->input);
 
 #ifdef	VERBOSE
 	if (Rt || ts->pendown)
@@ -401,7 +409,7 @@ static int __devinit ads7846_probe(struc
 	struct ads7846			*ts;
 	struct ads7846_platform_data	*pdata = spi->dev.platform_data;
 	struct spi_transfer		*x;
-	int				i;
+	int				status;
 
 	if (!spi->irq) {
 		dev_dbg(&spi->dev, "no IRQ?\n");
@@ -414,9 +422,9 @@ static int __devinit ads7846_probe(struc
 	}
 
 	/* don't exceed max specified sample rate */
-	if (spi->max_speed_hz > (125000 * 16)) {
+	if (spi->max_speed_hz > (125000 * SAMPLE_BITS)) {
 		dev_dbg(&spi->dev, "f(sample) %d KHz?\n",
-				(spi->max_speed_hz/16)/1000);
+				(spi->max_speed_hz/SAMPLE_BITS)/1000);
 		return -EINVAL;
 	}
 
@@ -442,79 +450,100 @@ static int __devinit ads7846_probe(struc
 	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
 	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
 
-	init_input_dev(&ts->input);
-
-	ts->input.dev = &spi->dev;
-	ts->input.name = "ADS784x Touchscreen";
-	snprintf(ts->phys, sizeof ts->phys, "%s/input0", spi->dev.bus_id);
-	ts->input.phys = ts->phys;
-
-	ts->input.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
-	ts->input.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
-	input_set_abs_params(&ts->input, ABS_X,
+	ts->input = input_allocate_device();
+	if (ts->input == NULL) {
+		status = -ENOMEM;
+		goto fail;
+	}
+
+	init_input_dev(ts->input);
+
+	ts->input->dev = &spi->dev;
+	ts->input->name = "ADS784x Touchscreen";
+	snprintf(ts->phys, sizeof ts->phys, "%s/input", spi->dev.bus_id);
+	ts->input->phys = ts->phys;
+
+	ts->input->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	ts->input->keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_set_abs_params(ts->input, ABS_X,
 			pdata->x_min ? : 0,
 			pdata->x_max ? : MAX_12BIT,
 			0, 0);
-	input_set_abs_params(&ts->input, ABS_Y,
+	input_set_abs_params(ts->input, ABS_Y,
 			pdata->y_min ? : 0,
 			pdata->y_max ? : MAX_12BIT,
 			0, 0);
-	input_set_abs_params(&ts->input, ABS_PRESSURE,
+	input_set_abs_params(ts->input, ABS_PRESSURE,
 			pdata->pressure_min, pdata->pressure_max, 0, 0);
 
-	input_register_device(&ts->input);
+	status = input_register_device(ts->input);
+	if (status < 0)
+		goto fail;
 
 	/* set up the transfers to read touchscreen state; this assumes we
 	 * use formula #2 for pressure, not #3.
 	 */
+	INIT_LIST_HEAD(&ts->msg.transfers);
 	x = ts->xfer;
 
 	/* y- still on; turn on only y+ (and ADC) */
-	x->tx_buf = &read_y;
+	ts->read_y = read_y;
+	x->tx_buf = &ts->read_y;
 	x->len = 1;
+	spi_message_add_tail(x, &ts->msg);
+
 	x++;
 	x->rx_buf = &ts->tc.y;
 	x->len = 2;
-	x++;
+	spi_message_add_tail(x, &ts->msg);
 
 	/* turn y+ off, x- on; we'll use formula #2 */
 	if (ts->model == 7846) {
-		x->tx_buf = &read_z1;
+		x++;
+		ts->read_z1 = read_z1;
+		x->tx_buf = &ts->read_z1;
 		x->len = 1;
+		spi_message_add_tail(x, &ts->msg);
+
 		x++;
 		x->rx_buf = &ts->tc.z1;
 		x->len = 2;
-		x++;
+		spi_message_add_tail(x, &ts->msg);
 
-		x->tx_buf = &read_z2;
+		x++;
+		ts->read_z2 = read_z2;
+		x->tx_buf = &ts->read_z2;
 		x->len = 1;
+		spi_message_add_tail(x, &ts->msg);
+
 		x++;
 		x->rx_buf = &ts->tc.z2;
 		x->len = 2;
-		x++;
+		spi_message_add_tail(x, &ts->msg);
 	}
 
 	/* turn y- off, x+ on, then leave in lowpower */
-	x->tx_buf = &read_x;
+	x++;
+	ts->read_x = read_x;
+	x->tx_buf = &ts->read_x;
 	x->len = 1;
+	spi_message_add_tail(x, &ts->msg);
+
 	x++;
 	x->rx_buf = &ts->tc.x;
 	x->len = 2;
-	x++;
-
-	CS_CHANGE(x[-1]);
+	CS_CHANGE(*x);
+	spi_message_add_tail(x, &ts->msg);
 
-	for (i = 0; i < x - ts->xfer; i++)
-		spi_message_add_tail(&ts->xfer[i], &ts->msg);
 	ts->msg.complete = ads7846_rx;
 	ts->msg.context = ts;
 
 	if (request_irq(spi->irq, ads7846_irq, SA_SAMPLE_RANDOM,
-				spi->dev.bus_id, ts)) {
+				spi->dev.driver->name, ts)) {
 		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
-		input_unregister_device(&ts->input);
-		kfree(ts);
-		return -EBUSY;
+		input_unregister_device(ts->input);
+		status = -EBUSY;
+		goto fail;
 	}
 	set_irq_type(spi->irq, IRQT_FALLING);
 
@@ -538,6 +567,12 @@ static int __devinit ads7846_probe(struc
 	device_create_file(&spi->dev, &dev_attr_vaux);
 
 	return 0;
+fail:
+	if (ts && ts->input)
+		input_free_device(ts->input);
+	if (ts)
+		kfree(ts);
+	return status;
 }
 
 static int __devexit ads7846_remove(struct spi_device *spi)
@@ -557,7 +592,8 @@ static int __devexit ads7846_remove(stru
 		device_remove_file(&spi->dev, &dev_attr_vbatt);
 	device_remove_file(&spi->dev, &dev_attr_vaux);
 
-	input_unregister_device(&ts->input);
+	input_unregister_device(ts->input);
+	input_free_device(ts->input);
 	kfree(ts);
 
 	dev_dbg(&spi->dev, "unregistered touchscreen\n");

--Boundary-00=_qbP2D/l2Ahic1RP--
