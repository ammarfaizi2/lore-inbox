Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWBOGOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWBOGOh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423000AbWBOGOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:14:15 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:59545 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1423001AbWBOGOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:14:07 -0500
Message-Id: <20060215061150.384514000.dtor_core@ameritech.net>
References: <20060215060140.243794000.dtor_core@ameritech.net>
Date: Wed, 15 Feb 2006 01:01:45 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PATCH 5/6] ads7846: assorted updates
Content-Disposition: inline; filename=ads7846.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Input: ads7846 - assorted updates

This updates the ads7846 touchscreen driver:
  - to allow faster clocking (this driver doesn't push sample rates);
  - bugfixes the conversion of spi_transfer to lists;
  - some dma-unsafe command buffers are fixed.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/ads7846.c |   68 +++++++++++++++++++++++-------------
 1 files changed, 44 insertions(+), 24 deletions(-)

Index: work/drivers/input/touchscreen/ads7846.c
===================================================================
--- work.orig/drivers/input/touchscreen/ads7846.c
+++ work/drivers/input/touchscreen/ads7846.c
@@ -48,10 +48,13 @@
 
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
@@ -68,6 +71,7 @@ struct ads7846 {
 	u16			vref_delay_usecs;
 	u16			x_plate_ohms;
 
+	u8			read_x, read_y, read_z1, read_z2;
 	struct ts_event		tc;
 
 	struct spi_transfer	xfer[8];
@@ -117,10 +121,10 @@ struct ads7846 {
 #define	READ_12BIT_DFR(x) (ADS_START | ADS_A2A1A0_d_ ## x \
 	| ADS_12_BIT | ADS_DFR)
 
-static const u8	read_y  = READ_12BIT_DFR(y)  | ADS_PD10_ADC_ON;
-static const u8	read_z1 = READ_12BIT_DFR(z1) | ADS_PD10_ADC_ON;
-static const u8	read_z2 = READ_12BIT_DFR(z2) | ADS_PD10_ADC_ON;
-static const u8	read_x  = READ_12BIT_DFR(x)  | ADS_PD10_PDOWN;	/* LAST */
+#define	READ_Y	(READ_12BIT_DFR(y)  | ADS_PD10_ADC_ON)
+#define	READ_Z1	(READ_12BIT_DFR(z1) | ADS_PD10_ADC_ON)
+#define	READ_Z2	(READ_12BIT_DFR(z2) | ADS_PD10_ADC_ON)
+#define	READ_X	(READ_12BIT_DFR(x)  | ADS_PD10_PDOWN)	/* LAST */
 
 /* single-ended samples need to first power up reference voltage;
  * we leave both ADC and VREF powered
@@ -128,8 +132,8 @@ static const u8	read_x  = READ_12BIT_DFR
 #define	READ_12BIT_SER(x) (ADS_START | ADS_A2A1A0_ ## x \
 	| ADS_12_BIT | ADS_SER)
 
-static const u8	ref_on = READ_12BIT_DFR(x) | ADS_PD10_ALL_ON;
-static const u8	ref_off = READ_12BIT_DFR(y) | ADS_PD10_PDOWN;
+#define	REF_ON	(READ_12BIT_DFR(x) | ADS_PD10_ALL_ON)
+#define	REF_OFF	(READ_12BIT_DFR(y) | ADS_PD10_PDOWN)
 
 /*--------------------------------------------------------------------------*/
 
@@ -138,7 +142,9 @@ static const u8	ref_off = READ_12BIT_DFR
  */
 
 struct ser_req {
+	u8			ref_on;
 	u8			command;
+	u8			ref_off;
 	u16			scratch;
 	__be16			sample;
 	struct spi_message	msg;
@@ -160,7 +166,8 @@ static int ads7846_read12_ser(struct dev
 	INIT_LIST_HEAD(&req->msg.transfers);
 
 	/* activate reference, so it has time to settle; */
-	req->xfer[0].tx_buf = &ref_on;
+	req->ref_on = REF_ON;
+	req->xfer[0].tx_buf = &req->ref_on;
 	req->xfer[0].len = 1;
 	req->xfer[1].rx_buf = &req->scratch;
 	req->xfer[1].len = 2;
@@ -182,7 +189,8 @@ static int ads7846_read12_ser(struct dev
 	/* REVISIT:  take a few more samples, and compare ... */
 
 	/* turn off reference */
-	req->xfer[4].tx_buf = &ref_off;
+	req->ref_off = REF_OFF;
+	req->xfer[4].tx_buf = &req->ref_off;
 	req->xfer[4].len = 1;
 	req->xfer[5].rx_buf = &req->scratch;
 	req->xfer[5].len = 2;
@@ -400,7 +408,6 @@ static int __devinit ads7846_probe(struc
 	struct input_dev		*input_dev;
 	struct ads7846_platform_data	*pdata = spi->dev.platform_data;
 	struct spi_transfer		*x;
-	int				i;
 	int				err;
 
 	if (!spi->irq) {
@@ -414,9 +421,9 @@ static int __devinit ads7846_probe(struc
 	}
 
 	/* don't exceed max specified sample rate */
-	if (spi->max_speed_hz > (125000 * 16)) {
+	if (spi->max_speed_hz > (125000 * SAMPLE_BITS)) {
 		dev_dbg(&spi->dev, "f(sample) %d KHz?\n",
-				(spi->max_speed_hz/16)/1000);
+				(spi->max_speed_hz/SAMPLE_BITS)/1000);
 		return -EINVAL;
 	}
 
@@ -469,45 +476,58 @@ static int __devinit ads7846_probe(struc
 	/* set up the transfers to read touchscreen state; this assumes we
 	 * use formula #2 for pressure, not #3.
 	 */
+	INIT_LIST_HEAD(&ts->msg.transfers);
 	x = ts->xfer;
 
 	/* y- still on; turn on only y+ (and ADC) */
-	x->tx_buf = &read_y;
+	ts->read_y = READ_Y;
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
+		ts->read_z1 = READ_Z1;
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
+		ts->read_z2 = READ_Z2;
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
+	ts->read_x = READ_X;
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
 

