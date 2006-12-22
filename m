Return-Path: <linux-kernel-owner+w=401wt.eu-S1752118AbWLVTVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbWLVTVE (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbWLVTVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:21:03 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:47313 "HELO
	smtp112.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752118AbWLVTVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:21:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=GOHF1P7b2p1Z1DlibAcBiuuQDZd672iU8qYc4UGVGKZJUkW5/YyEHLBXrkqZaf+N3kunt3gz/9gWfUEUcpItUjNUiWxXZ7X/IXXW9oEZ3K5zIi2jaTIjrkIMdl/zFtknOHRd2LGIBdjmeeDq3Eoizp88PlIOA10y12vyNZc7Owc=  ;
X-YMail-OSG: 3ysYRoMVM1nrvRGFfHESOz9L_dp.Q8Gs3RxoHjG4MD9tYA2i.ef31ZdGSudb2vIsTl6EZ1cJ_jQ.Kg6Da5owuHsdQGzADOonKnZ.C49CpR0PzKYEQOwcUQ--
Date: Fri, 22 Dec 2006 11:20:58 -0800
From: David Brownell <david-b@pacbell.net>
To: nicolas.ferre@rfo.atmel.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: [patch 2.6.20-rc1 1/6] input: ads7846 pluggable conditioning 
 filters
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061222192058.51D361F0D22@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: imre.deak@solidboot.com <imre.deak@solidboot.com>
Date: Mon Jul 3 21:36:53 2006 +0300

Input: ads7846: pluggable filtering logic

Some LCDs like the LS041Y3 require a customized filtering
logic for reliable readings, so make the filtering function
replacable through platform specific hooks.
    
Signed-off-by: Imre Deak <imre.deak@solidboot.com>
Signed-off-by: Juha Yrjola <juha.yrjola@solidboot.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: osk/include/linux/spi/ads7846.h
===================================================================
--- osk.orig/include/linux/spi/ads7846.h	2006-12-22 11:08:16.000000000 -0800
+++ osk/include/linux/spi/ads7846.h	2006-12-22 11:08:41.000000000 -0800
@@ -5,6 +5,12 @@
  *
  * It's OK if the min/max values are zero.
  */
+enum ads7846_filter {
+	ADS7846_FILTER_OK,
+	ADS7846_FILTER_REPEAT,
+	ADS7846_FILTER_IGNORE,
+};
+
 struct ads7846_platform_data {
 	u16	model;			/* 7843, 7845, 7846. */
 	u16	vref_delay_usecs;	/* 0 for external vref; etc */
@@ -21,5 +27,9 @@ struct ads7846_platform_data {
 	u16	debounce_rep;		/* additional consecutive good readings
 					 * required after the first two */
 	int	(*get_pendown_state)(void);
+	int	(*filter_init)	(struct ads7846_platform_data *pdata,
+				 void **filter_data);
+	int	(*filter)	(void *filter_data, int data_idx, int *val);
+	void	(*filter_cleanup)(void *filter_data);
 };
 
Index: osk/drivers/input/touchscreen/ads7846.c
===================================================================
--- osk.orig/drivers/input/touchscreen/ads7846.c	2006-12-22 11:08:16.000000000 -0800
+++ osk/drivers/input/touchscreen/ads7846.c	2006-12-22 11:08:41.000000000 -0800
@@ -63,11 +63,11 @@ struct ts_event {
 	/* For portability, we can't read 12 bit values using SPI (which
 	 * would make the controller deliver them as native byteorder u16
 	 * with msbs zeroed).  Instead, we read them as two 8-bit values,
-	 * which need byteswapping then range adjustment.
+	 * *** WHICH NEED BYTESWAPPING *** and range adjustment.
 	 */
-	__be16 x;
-	__be16 y;
-	__be16 z1, z2;
+	u16	x;
+	u16	y;
+	u16	z1, z2;
 	int    ignore;
 };
 
@@ -106,6 +106,9 @@ struct ads7846 {
 	unsigned		irq_disabled:1;	/* P: lock */
 	unsigned		disabled:1;
 
+	int			(*filter)(void *data, int data_idx, int *val);
+	void			*filter_data;
+	void			(*filter_cleanup)(void *data);
 	int			(*get_pendown_state)(void);
 };
 
@@ -379,13 +382,13 @@ static void ads7846_rx(void *ads)
 	u16			x, y, z1, z2;
 	unsigned long		flags;
 
-	/* adjust:  on-wire is a must-ignore bit, a BE12 value, then padding;
-	 * built from two 8 bit values written msb-first.
+	/* ads7846_rx_val() did in-place conversion (including byteswap) from
+	 * on-the-wire format as part of debouncing to get stable readings.
 	 */
-	x = (be16_to_cpu(ts->tc.x) >> 3) & 0x0fff;
-	y = (be16_to_cpu(ts->tc.y) >> 3) & 0x0fff;
-	z1 = (be16_to_cpu(ts->tc.z1) >> 3) & 0x0fff;
-	z2 = (be16_to_cpu(ts->tc.z2) >> 3) & 0x0fff;
+	x = ts->tc.x;
+	y = ts->tc.y;
+	z1 = ts->tc.z1;
+	z2 = ts->tc.z2;
 
 	/* range filtering */
 	if (x == MAX_12BIT)
@@ -453,50 +456,85 @@ static void ads7846_rx(void *ads)
 	spin_unlock_irqrestore(&ts->lock, flags);
 }
 
-static void ads7846_debounce(void *ads)
+static int ads7846_debounce(void *ads, int data_idx, int *val)
 {
 	struct ads7846		*ts = ads;
-	struct spi_message	*m;
-	struct spi_transfer	*t;
-	int			val;
-	int			status;
 
-	m = &ts->msg[ts->msg_idx];
-	t = list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
-	val = (be16_to_cpu(*(__be16 *)t->rx_buf) >> 3) & 0x0fff;
-	if (!ts->read_cnt || (abs(ts->last_read - val) > ts->debounce_tol)) {
+	if (!ts->read_cnt || (abs(ts->last_read - *val) > ts->debounce_tol)) {
+		/* Start over collecting consistent readings. */
+		ts->read_rep = 0;
 		/* Repeat it, if this was the first read or the read
 		 * wasn't consistent enough. */
 		if (ts->read_cnt < ts->debounce_max) {
-			ts->last_read = val;
+			ts->last_read = *val;
 			ts->read_cnt++;
+			return ADS7846_FILTER_REPEAT;
 		} else {
 			/* Maximum number of debouncing reached and still
 			 * not enough number of consistent readings. Abort
 			 * the whole sample, repeat it in the next sampling
 			 * period.
 			 */
-			ts->tc.ignore = 1;
 			ts->read_cnt = 0;
-			/* Last message will contain ads7846_rx() as the
-			 * completion function.
-			 */
-			m = ts->last_msg;
+			return ADS7846_FILTER_IGNORE;
 		}
-		/* Start over collecting consistent readings. */
-		ts->read_rep = 0;
 	} else {
 		if (++ts->read_rep > ts->debounce_rep) {
 			/* Got a good reading for this coordinate,
 			 * go for the next one. */
-			ts->tc.ignore = 0;
-			ts->msg_idx++;
 			ts->read_cnt = 0;
 			ts->read_rep = 0;
-			m++;
-		} else
+			return ADS7846_FILTER_OK;
+		} else {
 			/* Read more values that are consistent. */
 			ts->read_cnt++;
+			return ADS7846_FILTER_REPEAT;
+		}
+	}
+}
+
+static int ads7846_no_filter(void *ads, int data_idx, int *val)
+{
+	return ADS7846_FILTER_OK;
+}
+
+static void ads7846_rx_val(void *ads)
+{
+	struct ads7846 *ts = ads;
+	struct spi_message *m;
+	struct spi_transfer *t;
+	u16 *rx_val;
+	int val;
+	int action;
+	int status;
+
+	m = &ts->msg[ts->msg_idx];
+	t = list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
+	rx_val = t->rx_buf;
+
+	/* adjust:  on-wire is a must-ignore bit, a BE12 value, then padding;
+	 * built from two 8 bit values written msb-first.
+	 */
+	val = be16_to_cpu(*rx_val) >> 3;
+
+	action = ts->filter(ts->filter_data, ts->msg_idx, &val);
+	switch (action) {
+	case ADS7846_FILTER_REPEAT:
+		break;
+	case ADS7846_FILTER_IGNORE:
+		ts->tc.ignore = 1;
+		/* Last message will contain ads7846_rx() as the
+		 * completion function.
+		 */
+		m = ts->last_msg;
+		break;
+	case ADS7846_FILTER_OK:
+		*rx_val = val;
+		ts->tc.ignore = 0;
+		m = &ts->msg[++ts->msg_idx];
+		break;
+	default:
+		BUG();
 	}
 	status = spi_async(ts->spi, m);
 	if (status)
@@ -689,14 +727,25 @@ static int __devinit ads7846_probe(struc
 	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
 	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
 	ts->pressure_max = pdata->pressure_max ? : ~0;
-	if (pdata->debounce_max) {
+
+	if (pdata->filter != NULL) {
+		if (pdata->filter_init != NULL) {
+			err = pdata->filter_init(pdata, &ts->filter_data);
+			if (err < 0)
+				goto err_free_mem;
+		}
+		ts->filter = pdata->filter;
+		ts->filter_cleanup = pdata->filter_cleanup;
+	} else if (pdata->debounce_max) {
 		ts->debounce_max = pdata->debounce_max;
+		if (ts->debounce_max < 2)
+			ts->debounce_max = 2;
 		ts->debounce_tol = pdata->debounce_tol;
 		ts->debounce_rep = pdata->debounce_rep;
-		if (ts->debounce_rep > ts->debounce_max + 1)
-			ts->debounce_rep = ts->debounce_max - 1;
+		ts->filter = ads7846_debounce;
+		ts->filter_data = ts;
 	} else
-		ts->debounce_tol = ~0;
+		ts->filter = ads7846_no_filter;
 	ts->get_pendown_state = pdata->get_pendown_state;
 
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", spi->dev.bus_id);
@@ -737,7 +786,7 @@ static int __devinit ads7846_probe(struc
 	x->len = 2;
 	spi_message_add_tail(x, m);
 
-	m->complete = ads7846_debounce;
+	m->complete = ads7846_rx_val;
 	m->context = ts;
 
 	m++;
@@ -755,7 +804,7 @@ static int __devinit ads7846_probe(struc
 	x->len = 2;
 	spi_message_add_tail(x, m);
 
-	m->complete = ads7846_debounce;
+	m->complete = ads7846_rx_val;
 	m->context = ts;
 
 	/* turn y+ off, x- on; we'll use formula #2 */
@@ -774,7 +823,7 @@ static int __devinit ads7846_probe(struc
 		x->len = 2;
 		spi_message_add_tail(x, m);
 
-		m->complete = ads7846_debounce;
+		m->complete = ads7846_rx_val;
 		m->context = ts;
 
 		m++;
@@ -791,7 +840,7 @@ static int __devinit ads7846_probe(struc
 		x->len = 2;
 		spi_message_add_tail(x, m);
 
-		m->complete = ads7846_debounce;
+		m->complete = ads7846_rx_val;
 		m->context = ts;
 	}
 
@@ -820,7 +869,7 @@ static int __devinit ads7846_probe(struc
 			spi->dev.driver->name, ts)) {
 		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
 		err = -EBUSY;
-		goto err_free_mem;
+		goto err_cleanup_filter;
 	}
 
 	dev_info(&spi->dev, "touchscreen, irq %d\n", spi->irq);
@@ -856,6 +905,9 @@ static int __devinit ads7846_probe(struc
 	sysfs_remove_group(&spi->dev.kobj, ts->attr_group);
  err_free_irq:
 	free_irq(spi->irq, ts);
+ err_cleanup_filter:
+	if (ts->filter_cleanup)
+		ts->filter_cleanup(ts->filter_data);
  err_free_mem:
 	input_free_device(input_dev);
 	kfree(ts);
@@ -876,6 +928,9 @@ static int __devexit ads7846_remove(stru
 	/* suspend left the IRQ disabled */
 	enable_irq(ts->spi->irq);
 
+	if (ts->filter_cleanup != NULL)
+		ts->filter_cleanup(ts->filter_data);
+
 	kfree(ts);
 
 	dev_dbg(&spi->dev, "unregistered touchscreen\n");
