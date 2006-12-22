Return-Path: <linux-kernel-owner+w=401wt.eu-S1752139AbWLVTXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbWLVTXZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbWLVTXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:23:25 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:48649 "HELO
	smtp112.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752139AbWLVTXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:23:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=zoKLBZhP/UCefbQln/mDILbJaJoossT44hcqpaRzeeKKKm1pBlSg9pNAgGlSvCdspaTK/6Ee4znnldxQLng/9bHgv/zHw3GEYqHNPCM3YLacXHhMBDRcTcTCSlpReUQWYrmDgbqbx0ldOi85pN0uov/B4dWFvV96FK6HGec6+Ds=  ;
X-YMail-OSG: h6AbRqMVM1mO12qyuMdRZVKLGCsdDn5aVromnygTnm6wTAj7BLmcRY5u9ykvxjV.UkG7tFhlpPDgi.RinLBrgCzTk3k57W9lAv8FwPV1cGhH0bFFzh3tc_uBody8kOquAXwtZmFwotZlB0Y-
Date: Fri, 22 Dec 2006 11:23:22 -0800
From: David Brownell <david-b@pacbell.net>
To: nicolas.ferre@rfo.atmel.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: [patch 2.6.20-rc1 3/6] input: ads7846 more compatible with hwmon
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061222192322.2BDCA1F0D22@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Be more compatible with the hwmon framework:

 - Hook up to hwmon
     * show sensor attrubites only if hwmon is present
     * otherwise be just a touchscreen
 - Report voltages per hwmon convention
     * measure in millivolts
     * voltages are named in[0-8]_input (ugh)
     * for 7846 chips, properly range-adjust vBATT/in1_input

Battery measurements help during recharge monitoring.  On OSK/Mistral,
the measured voltage agreed with a multimeter to several decimal places.
 
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: osk/drivers/input/touchscreen/Kconfig
===================================================================
--- osk.orig/drivers/input/touchscreen/Kconfig	2006-12-22 11:08:09.000000000 -0800
+++ osk/drivers/input/touchscreen/Kconfig	2006-12-22 11:08:44.000000000 -0800
@@ -12,12 +12,15 @@ menuconfig INPUT_TOUCHSCREEN
 if INPUT_TOUCHSCREEN
 
 config TOUCHSCREEN_ADS7846
-	tristate "ADS 7846 based touchscreens"
+	tristate "ADS 7846/7843 based touchscreens"
 	depends on SPI_MASTER
 	help
 	  Say Y here if you have a touchscreen interface using the
-	  ADS7846 controller, and your board-specific initialization
+	  ADS7846 or ADS7843 controller, and your board-specific setup
 	  code includes that in its table of SPI devices.
+	  
+	  If HWMON is selected, you will also get hwmon interfaces for
+	  the voltage (and for ads7846, temperature) sensors on this chip.
 
 	  If unsure, say N (but it's safe to say "Y").
 
Index: osk/drivers/input/touchscreen/ads7846.c
===================================================================
--- osk.orig/drivers/input/touchscreen/ads7846.c	2006-12-22 11:08:43.000000000 -0800
+++ osk/drivers/input/touchscreen/ads7846.c	2006-12-22 11:08:44.000000000 -0800
@@ -17,8 +17,9 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
-#include <linux/device.h>
+#include <linux/hwmon.h>
 #include <linux/init.h>
+#include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
@@ -77,6 +78,7 @@ struct ads7846 {
 
 	struct spi_device	*spi;
 	struct attribute_group	*attr_group;
+	struct class_device	*hwmon;
 	u16			model;
 	u16			vref_delay_usecs;
 	u16			x_plate_ohms;
@@ -169,7 +171,12 @@ struct ads7846 {
 
 /*
  * Non-touchscreen sensors only use single-ended conversions.
+ * The range is GND..vREF. The ads7843 and ads7835 must use external vREF;
+ * ads7846 lets that pin be unconnected, to use internal vREF.
+ *
+ * FIXME make external vREF_mV be a module option, and use that as needed...
  */
+static const unsigned vREF_mV = 2500;
 
 struct ser_req {
 	u8			ref_on;
@@ -197,50 +204,55 @@ static int ads7846_read12_ser(struct dev
 	struct ser_req		*req = kzalloc(sizeof *req, GFP_KERNEL);
 	int			status;
 	int			sample;
-	int			i;
+	int			use_internal;
 
 	if (!req)
 		return -ENOMEM;
 
 	spi_message_init(&req->msg);
 
-	/* activate reference, so it has time to settle; */
-	req->ref_on = REF_ON;
-	req->xfer[0].tx_buf = &req->ref_on;
-	req->xfer[0].len = 1;
-	req->xfer[1].rx_buf = &req->scratch;
-	req->xfer[1].len = 2;
+	/* FIXME boards with ads7846 might use external vref instead ... */
+	use_internal = (ts->model == 7846);
 
-	/*
-	 * for external VREF, 0 usec (and assume it's always on);
-	 * for 1uF, use 800 usec;
-	 * no cap, 100 usec.
-	 */
-	req->xfer[1].delay_usecs = ts->vref_delay_usecs;
+	/* maybe turn on internal vREF, and let it settle */
+	if (use_internal) {
+		req->ref_on = REF_ON;
+		req->xfer[0].tx_buf = &req->ref_on;
+		req->xfer[0].len = 1;
+		spi_message_add_tail(&req->xfer[0], &req->msg);
+
+		req->xfer[1].rx_buf = &req->scratch;
+		req->xfer[1].len = 2;
+
+		/* for 1uF, settle for 800 usec; no cap, 100 usec.  */
+		req->xfer[1].delay_usecs = ts->vref_delay_usecs;
+		spi_message_add_tail(&req->xfer[1], &req->msg);
+	}
 
 	/* take sample */
 	req->command = (u8) command;
 	req->xfer[2].tx_buf = &req->command;
 	req->xfer[2].len = 1;
+	spi_message_add_tail(&req->xfer[2], &req->msg);
+
 	req->xfer[3].rx_buf = &req->sample;
 	req->xfer[3].len = 2;
+	spi_message_add_tail(&req->xfer[3], &req->msg);
 
 	/* REVISIT:  take a few more samples, and compare ... */
 
-	/* turn off reference */
-	req->ref_off = REF_OFF;
-	req->xfer[4].tx_buf = &req->ref_off;
-	req->xfer[4].len = 1;
-	req->xfer[5].rx_buf = &req->scratch;
-	req->xfer[5].len = 2;
-
-	CS_CHANGE(req->xfer[5]);
+	/* maybe off internal vREF */
+	if (use_internal) {
+		req->ref_off = REF_OFF;
+		req->xfer[4].tx_buf = &req->ref_off;
+		req->xfer[4].len = 1;
+		spi_message_add_tail(&req->xfer[4], &req->msg);
 
-	/* group all the transfers together, so we can't interfere with
-	 * reading touchscreen state; disable penirq while sampling
-	 */
-	for (i = 0; i < 6; i++)
-		spi_message_add_tail(&req->xfer[i], &req->msg);
+		req->xfer[5].rx_buf = &req->scratch;
+		req->xfer[5].len = 2;
+		CS_CHANGE(req->xfer[5]);
+		spi_message_add_tail(&req->xfer[5], &req->msg);
+	}
 
 	ts->irq_disabled = 1;
 	disable_irq(spi->irq);
@@ -260,21 +272,63 @@ static int ads7846_read12_ser(struct dev
 	return status ? status : sample;
 }
 
-#define SHOW(name) static ssize_t \
+#ifdef	CONFIG_HWMON
+
+#define SHOW(name,var,adjust) static ssize_t \
 name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
 { \
+	struct ads7846 *ts = dev_get_drvdata(dev); \
 	ssize_t v = ads7846_read12_ser(dev, \
-			READ_12BIT_SER(name) | ADS_PD10_ALL_ON); \
+			READ_12BIT_SER(var) | ADS_PD10_ALL_ON); \
 	if (v < 0) \
 		return v; \
-	return sprintf(buf, "%u\n", (unsigned) v); \
+	return sprintf(buf, "%u\n", adjust(ts, v)); \
 } \
 static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);
 
-SHOW(temp0)
-SHOW(temp1)
-SHOW(vaux)
-SHOW(vbatt)
+
+/* Sysfs conventions report temperatures in millidegrees Celcius.
+ * We could use the low-accuracy two-sample scheme, but can't do the high
+ * accuracy scheme without calibration data.  For now we won't try either;
+ * userspace sees raw sensor values, and must scale appropriately.
+ */
+static inline unsigned null_adjust(struct ads7846 *ts, ssize_t v)
+{
+	return v;
+}
+
+SHOW(temp0, temp0, null_adjust)		// temp1_input
+SHOW(temp1, temp1, null_adjust)		// temp2_input
+
+
+/* sysfs conventions report voltages in millivolts.  We can convert voltages
+ * if we know vREF.  userspace may need to scale vAUX to match the board's
+ * external resistors; we assume that vBATT only uses the internal ones.
+ */
+static inline unsigned vaux_adjust(struct ads7846 *ts, ssize_t v)
+{
+	unsigned retval = v;
+
+	/* external resistors may scale vAUX into 0..vREF */
+	retval *= vREF_mV;
+	retval = retval >> 12;
+	return retval;
+}
+
+static inline unsigned vbatt_adjust(struct ads7846 *ts, ssize_t v)
+{
+	unsigned retval = vaux_adjust(ts, v);
+
+	/* ads7846 has a resistor ladder to scale this signal down */
+	if (ts->model == 7846)
+		retval *= 4;
+	return retval;
+}
+
+SHOW(in0_input, vaux, vaux_adjust)
+SHOW(in1_input, vbatt, vbatt_adjust)
+
+#endif
 
 static int is_pen_down(struct device *dev)
 {
@@ -323,10 +377,12 @@ static ssize_t ads7846_disable_store(str
 static DEVICE_ATTR(disable, 0664, ads7846_disable_show, ads7846_disable_store);
 
 static struct attribute *ads7846_attributes[] = {
+#ifdef	CONFIG_HWMON
 	&dev_attr_temp0.attr,
 	&dev_attr_temp1.attr,
-	&dev_attr_vbatt.attr,
-	&dev_attr_vaux.attr,
+	&dev_attr_in0_input.attr,
+	&dev_attr_in1_input.attr,
+#endif
 	&dev_attr_pen_down.attr,
 	&dev_attr_disable.attr,
 	NULL,
@@ -336,14 +392,16 @@ static struct attribute_group ads7846_at
 	.attrs = ads7846_attributes,
 };
 
+#ifdef	CONFIG_HWMON
+
 /*
  * ads7843/7845 don't have temperature sensors, and
  * use the other sensors a bit differently too
  */
 
 static struct attribute *ads7843_attributes[] = {
-	&dev_attr_vbatt.attr,
-	&dev_attr_vaux.attr,
+	&dev_attr_in0_input.attr,
+	&dev_attr_in1_input.attr,
 	&dev_attr_pen_down.attr,
 	&dev_attr_disable.attr,
 	NULL,
@@ -354,7 +412,7 @@ static struct attribute_group ads7843_at
 };
 
 static struct attribute *ads7845_attributes[] = {
-	&dev_attr_vaux.attr,
+	&dev_attr_in0_input.attr,
 	&dev_attr_pen_down.attr,
 	&dev_attr_disable.attr,
 	NULL,
@@ -364,6 +422,11 @@ static struct attribute_group ads7845_at
 	.attrs = ads7845_attributes,
 };
 
+#else
+#define ads7843_attr_group ads7846_attr_group
+#define ads7845_attr_group ads7846_attr_group
+#endif
+
 /*--------------------------------------------------------------------------*/
 
 /*
@@ -712,6 +775,14 @@ static int __devinit ads7846_probe(struc
 		err = -ENOMEM;
 		goto err_free_mem;
 	}
+#ifdef	CONFIG_HWMON
+	ts->hwmon = hwmon_device_register(&spi->dev);
+	if (IS_ERR(ts->hwmon)) {
+		err = PTR_ERR(ts->hwmon);
+		ts->hwmon = NULL;
+		goto err_free_mem;
+	}
+#endif
 
 	dev_set_drvdata(&spi->dev, ts);
 	spi->dev.power.power_state = PMSG_ON;
@@ -876,9 +947,11 @@ static int __devinit ads7846_probe(struc
 		goto err_cleanup_filter;
 	}
 
-	dev_info(&spi->dev, "touchscreen, irq %d\n", spi->irq);
+	dev_info(&spi->dev, "touchscreen%s, irq %d\n",
+			ts->hwmon ? " + hwmon" : "",
+			spi->irq);
 
-	/* take a first sample, leaving nPENIRQ active; avoid
+	/* take a first sample, leaving nPENIRQ active and vREF off; avoid
 	 * the touchscreen, in case it's not connected.
 	 */
 	(void) ads7846_read12_ser(&spi->dev,
@@ -913,6 +986,10 @@ static int __devinit ads7846_probe(struc
 	if (ts->filter_cleanup)
 		ts->filter_cleanup(ts->filter_data);
  err_free_mem:
+#ifdef	CONFIG_HWMON
+	if (ts->hwmon)
+		hwmon_device_unregister(ts->hwmon);
+#endif
 	input_free_device(input_dev);
 	kfree(ts);
 	return err;
@@ -922,6 +999,9 @@ static int __devexit ads7846_remove(stru
 {
 	struct ads7846		*ts = dev_get_drvdata(&spi->dev);
 
+#ifdef	CONFIG_HWMON
+	hwmon_device_unregister(ts->hwmon);
+#endif
 	input_unregister_device(ts->input);
 
 	ads7846_suspend(spi, PMSG_SUSPEND);
