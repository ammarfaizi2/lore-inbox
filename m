Return-Path: <linux-kernel-owner+w=401wt.eu-S1752671AbWLOPQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbWLOPQ5 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 10:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752719AbWLOPQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 10:16:57 -0500
Received: from mail.atmel.fr ([81.80.104.162]:34590 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbWLOPQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 10:16:56 -0500
X-Greylist: delayed 1815 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 10:16:55 EST
Message-ID: <4582B4F4.2050106@rfo.atmel.com>
Date: Fri, 15 Dec 2006 15:45:08 +0100
From: Nicolas FERRE <nicolas.ferre@rfo.atmel.com>
Organization: atmel
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: David Brownell <d-b@pacbell.net>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] input/spi: add ads7843 support to ads7846 touchscreen driver
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the ads7843 touchscreen controller to the ads7846
driver code.
The "pen down" information is managed quite differently as we
do not have a touch-pressure measurement on the ads7843.

Signed-off-by: Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
---

I add a ads7843_rx function to manage the end of a measurement cycle.
As for ads7846_rx, it does the real work and communicates with the
input subsystem.
The timer function is responsible of taking the pen up/pen down state
through the board specific get_pendown_state() callback.

As the SPI underlying code behaves quite differently from a controller
driver to another while not having a tx_buf filled, I have add a
zeroed buffer to give to the SPI layer while receiving data.

===================================================================
--- a/input/touchscreen/ads7846.c	(.../linux-2.6.19-at91/drivers)	(revision 634)
+++ b/input/touchscreen/ads7846.c	(.../linux-2.6.19-atmel-devel/drivers)	(revision 634)
@@ -4,6 +4,7 @@
  * Copyright (c) 2005 David Brownell
  * Copyright (c) 2006 Nokia Corporation
  * Various changes: Imre Deak <imre.deak@nokia.com>
+ * Ads7843 support: Atmel, Nicolas Ferre <nicolas.ferre@rfo.atmel.com>
  *
  * Using code from:
  *  - corgi_ts.c
@@ -38,7 +39,8 @@
 /*
  * This code has been heavily tested on a Nokia 770, and lightly
  * tested on other ads7846 devices (OSK/Mistral, Lubbock).
- * Support for ads7843 and ads7845 has only been stubbed in.
+ * Support for ads7843 tested on Atmel at91sam926x-EK.
+ * Support for ads7845 has only been stubbed in.
  *
  * IRQ handling needs a workaround because of a shortcoming in handling
  * edge triggered IRQs on some platforms like the OMAP1/2. These
@@ -82,6 +84,7 @@ struct ads7846 {
 	u16			pressure_max;
 
 	u8			read_x, read_y, read_z1, read_z2, pwrdown;
+	u16			zerro;		/* to send zerros while receiving */
 	u16			dummy;		/* for the pwrdown read */
 	struct ts_event		tc;
 
@@ -151,6 +154,10 @@ struct ads7846 {
 #define	READ_X	(READ_12BIT_DFR(x)  | ADS_PD10_ADC_ON)
 #define	PWRDOWN	(READ_12BIT_DFR(y)  | ADS_PD10_PDOWN)	/* LAST */
 
+/* alternate ads7843 commands */
+#define	ALT_READ_Y	(READ_12BIT_DFR(y)  | ADS_PD10_ALL_ON)
+#define	ALT_READ_X	(READ_12BIT_DFR(x)  | ADS_PD10_ALL_ON)
+
 /* single-ended samples need to first power up reference voltage;
  * we leave both ADC and VREF powered
  */
@@ -171,6 +178,7 @@ struct ser_req {
 	u8			command;
 	u8			ref_off;
 	u16			scratch;
+	u16			zerro;
 	__be16			sample;
 	struct spi_message	msg;
 	struct spi_transfer	xfer[6];
@@ -203,6 +211,7 @@ static int ads7846_read12_ser(struct dev
 	req->ref_on = REF_ON;
 	req->xfer[0].tx_buf = &req->ref_on;
 	req->xfer[0].len = 1;
+	req->xfer[1].tx_buf = &req->zerro;
 	req->xfer[1].rx_buf = &req->scratch;
 	req->xfer[1].len = 2;
 
@@ -217,6 +226,7 @@ static int ads7846_read12_ser(struct dev
 	req->command = (u8) command;
 	req->xfer[2].tx_buf = &req->command;
 	req->xfer[2].len = 1;
+	req->xfer[3].tx_buf = &req->zerro;
 	req->xfer[3].rx_buf = &req->sample;
 	req->xfer[3].len = 2;
 
@@ -226,6 +236,7 @@ static int ads7846_read12_ser(struct dev
 	req->ref_off = REF_OFF;
 	req->xfer[4].tx_buf = &req->ref_off;
 	req->xfer[4].len = 1;
+	req->xfer[3].tx_buf = &req->zerro;
 	req->xfer[5].rx_buf = &req->scratch;
 	req->xfer[5].len = 2;
 
@@ -410,6 +421,50 @@ static void ads7846_rx(void *ads)
 	spin_unlock_irqrestore(&ts->lock, flags);
 }
 
+static void ads7843_rx(void *ads)
+{
+	struct ads7846		*ts = ads;
+	struct input_dev	*input_dev = ts->input;
+	u16			x, y;
+	unsigned long		flags;
+
+	
+	/* adjust:  on-wire is a must-ignore bit, a BE12 value, then padding;
+	 * built from two 8 bit values written msb-first.
+	 */
+	x = (be16_to_cpu(ts->tc.x) >> 3) & 0x0fff;
+	y = (be16_to_cpu(ts->tc.y) >> 3) & 0x0fff;
+
+	/* range filtering */
+	if (x == MAX_12BIT)
+		x = 0;
+
+	if (ts->pendown) {
+		input_report_key(input_dev, BTN_TOUCH, 1);
+		input_report_abs(input_dev, ABS_PRESSURE, ts->pressure_max / 2);
+		input_report_abs(input_dev, ABS_X, x);
+		input_report_abs(input_dev, ABS_Y, y);
+	} else {
+		input_report_key(input_dev, BTN_TOUCH, 0);
+		input_report_abs(input_dev, ABS_PRESSURE, 0);
+	}
+
+	input_sync(input_dev);
+
+#ifdef	VERBOSE
+	pr_debug("%s: %d/%d%s\n", ts->spi->dev.bus_id,
+		x, y, ts->pendown ? "" : " UP");
+#endif
+
+	if (ts->pendown) {
+		spin_lock_irqsave(&ts->lock, flags);
+
+		mod_timer(&ts->timer, jiffies + TS_POLL_PERIOD);
+
+		spin_unlock_irqrestore(&ts->lock, flags);
+	}
+}
+
 static void ads7846_debounce(void *ads)
 {
 	struct ads7846		*ts = ads;
@@ -465,11 +520,25 @@ static void ads7846_timer(unsigned long 
 {
 	struct ads7846	*ts = (void *)handle;
 	int		status = 0;
+	int		alt_end_cycle = 0; /* ads7843 alternative cycle end */
+
+	if (ts->model == 7843) {
+		/* get sample */
+		ts->pendown = ts->get_pendown_state();
+		alt_end_cycle = ts->pending;
+	}
 
 	spin_lock_irq(&ts->lock);
 
-	if (unlikely(ts->msg_idx && !ts->pendown)) {
+	if (unlikely(!ts->pendown && (ts->msg_idx || alt_end_cycle))) {
 		/* measurement cycle ended */
+		if (ts->model == 7843) {
+			status = spi_async(ts->spi, ts->last_msg);
+			if (status)
+				dev_err(&ts->spi->dev,
+					"spi_async --> %d\n", status);
+		}
+
 		if (!device_suspended(&ts->spi->dev)) {
 			ts->irq_disabled = 0;
 			enable_irq(ts->spi->irq);
@@ -684,12 +753,17 @@ static int __devinit ads7846_probe(struc
 	spi_message_init(m);
 
 	/* y- still on; turn on only y+ (and ADC) */
-	ts->read_y = READ_Y;
+	if (ts->model == 7843) {
+		ts->read_y = ALT_READ_Y;
+	} else {
+		ts->read_y = READ_Y;
+	}
 	x->tx_buf = &ts->read_y;
 	x->len = 1;
 	spi_message_add_tail(x, m);
 
 	x++;
+	x->tx_buf = &ts->zerro;
 	x->rx_buf = &ts->tc.y;
 	x->len = 2;
 	spi_message_add_tail(x, m);
@@ -702,12 +776,17 @@ static int __devinit ads7846_probe(struc
 
 	/* turn y- off, x+ on, then leave in lowpower */
 	x++;
-	ts->read_x = READ_X;
+	if (ts->model == 7843) {
+		ts->read_x = ALT_READ_X;
+	} else {
+		ts->read_x = READ_X;
+	}
 	x->tx_buf = &ts->read_x;
 	x->len = 1;
 	spi_message_add_tail(x, m);
 
 	x++;
+	x->tx_buf = &ts->zerro;
 	x->rx_buf = &ts->tc.x;
 	x->len = 2;
 	spi_message_add_tail(x, m);
@@ -763,12 +842,17 @@ static int __devinit ads7846_probe(struc
 	spi_message_add_tail(x, m);
 
 	x++;
+	x->tx_buf = &ts->zerro;
 	x->rx_buf = &ts->dummy;
 	x->len = 2;
 	CS_CHANGE(*x);
 	spi_message_add_tail(x, m);
 
-	m->complete = ads7846_rx;
+	if (ts->model == 7843) {
+		m->complete = ads7843_rx;
+	} else {
+		m->complete = ads7846_rx;
+	}
 	m->context = ts;
 
 	ts->last_msg = m;
@@ -782,11 +866,16 @@ static int __devinit ads7846_probe(struc
 
 	dev_info(&spi->dev, "touchscreen, irq %d\n", spi->irq);
 
-	/* take a first sample, leaving nPENIRQ active; avoid
-	 * the touchscreen, in case it's not connected.
-	 */
-	(void) ads7846_read12_ser(&spi->dev,
-			  READ_12BIT_SER(vaux) | ADS_PD10_ALL_ON);
+	if (ts->model != 7843) {
+		/* take a first sample, leaving nPENIRQ active; avoid
+		 * the touchscreen, in case it's not connected.
+		 */
+		(void) ads7846_read12_ser(&spi->dev,
+				  READ_12BIT_SER(vaux) | ADS_PD10_ALL_ON);
+	} else {
+		(void) ads7846_read12_ser(&spi->dev,
+				  READ_12BIT_DFR(y) | ADS_PD10_ALL_ON);
+	}
 
 	/* ads7843/7845 don't have temperature sensors, and
 	 * use the other sensors a bit differently too
@@ -795,12 +884,14 @@ static int __devinit ads7846_probe(struc
 		device_create_file(&spi->dev, &dev_attr_temp0);
 		device_create_file(&spi->dev, &dev_attr_temp1);
 	}
-	if (ts->model != 7845)
+	if (ts->model != 7845 && ts->model != 7843)
 		device_create_file(&spi->dev, &dev_attr_vbatt);
-	device_create_file(&spi->dev, &dev_attr_vaux);
 
-	device_create_file(&spi->dev, &dev_attr_pen_down);
+	if (ts->model != 7843) {
+		device_create_file(&spi->dev, &dev_attr_vaux);
+	}
 
+	device_create_file(&spi->dev, &dev_attr_pen_down);
 	device_create_file(&spi->dev, &dev_attr_disable);
 
 	err = input_register_device(input_dev);
@@ -816,9 +907,12 @@ static int __devinit ads7846_probe(struc
 		device_remove_file(&spi->dev, &dev_attr_temp1);
 		device_remove_file(&spi->dev, &dev_attr_temp0);
 	}
-	if (ts->model != 7845)
+	if (ts->model != 7845 && ts->model != 7843)
 		device_remove_file(&spi->dev, &dev_attr_vbatt);
-	device_remove_file(&spi->dev, &dev_attr_vaux);
+
+	if (ts->model != 7843) {
+		device_remove_file(&spi->dev, &dev_attr_vaux);
+	}
 
 	free_irq(spi->irq, ts);
  err_free_mem:
@@ -841,9 +935,12 @@ static int __devexit ads7846_remove(stru
 		device_remove_file(&spi->dev, &dev_attr_temp1);
 		device_remove_file(&spi->dev, &dev_attr_temp0);
 	}
-	if (ts->model != 7845)
+	if (ts->model != 7845 && ts->model != 7843)
 		device_remove_file(&spi->dev, &dev_attr_vbatt);
-	device_remove_file(&spi->dev, &dev_attr_vaux);
+
+	if (ts->model != 7843) {
+		device_remove_file(&spi->dev, &dev_attr_vaux);
+	}
 
 	free_irq(ts->spi->irq, ts);
 	/* suspend left the IRQ disabled */


