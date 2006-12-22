Return-Path: <linux-kernel-owner+w=401wt.eu-S1753016AbWLVWGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbWLVWGS (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 17:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWLVWGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 17:06:18 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:20713 "HELO
	smtp113.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753016AbWLVWGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 17:06:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=YIfF/xcPWAEaKGbCE0r/xqV8G+isyyFl8f1HJfRdCfuA3qd9tHGa2t1yjMCN9gUEqNDixv8iAnA10Wp+/W4YTRf3tw68LA3kc8qCS8GnRDToL7texZLMJ8LB0dLibCiOWG+rQbfOhe6XDJLOhVT5FB1lCTwF0Yr3RavYJjvuH3I=  ;
X-YMail-OSG: w8rCbV8VM1nf0sqz4SzOrtPl5eLYLWu2_CJ0VsxiflGbQv1ls3e.j926aZjAfq3PUWsr9yHahW77yMVm.yQMzQJy803wGKdrWC2ArwHRD7GknDXrpwsCTFr90f6sajeZwNElLOqfA_7DMZdksCUCjxBor6nfARvu7Q--
From: David Brownell <david-b@pacbell.net>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2.6.20-rc1 3/6] input: ads7846 more compatible with hwmon
Date: Fri, 22 Dec 2006 14:06:13 -0800
User-Agent: KMail/1.7.1
Cc: nicolas.ferre@rfo.atmel.com, linux-kernel@vger.kernel.org
References: <20061222192322.2BDCA1F0D22@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <d120d5000612221226q40ae235ex251c1bc0c55d42a6@mail.gmail.com>
In-Reply-To: <d120d5000612221226q40ae235ex251c1bc0c55d42a6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612221406.13684.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 December 2006 12:26 pm, Dmitry Torokhov wrote:
> On 12/22/06, David Brownell <david-b@pacbell.net> wrote:
> > Be more compatible with the hwmon framework:
> >
> >  - Hook up to hwmon
> >     * show sensor attrubites only if hwmon is present
> >     * otherwise be just a touchscreen
> >  - Report voltages per hwmon convention
> >     * measure in millivolts
> >     * voltages are named in[0-8]_input (ugh)
> >     * for 7846 chips, properly range-adjust vBATT/in1_input
> 
> There are too many #ifdefs. Please consider creating
> ads7846_[un]register_hwmon() and use them in
> ads7846_probe()/ads7846_remove().

Did that.


> Split hwmon related attributes into 
> a separate attribute group and move everything in #ifdef CONFIG_HWMON
> block.

Done.
 
> > + *
> > + * FIXME make external vREF_mV be a module option, and use that as needed...
> >  */
> > +static const unsigned vREF_mV = 2500;
> >
> 
> Why don't you make it mdule option right away?

Mostly because that was a least-work-to-sync-up kind of patch.  ;)

Did that too.  The updated patch is appended.  The other three patches still
work fine, but obviously the line numbers changed so you should ingore those
patch warnings (64 lines of offset).

Note that this fixes a glitch with HWMON=m, which now constrains this driver
to be a module too.

- Dave

============	CUT HERE
Be more compatible with the hwmon framework:

 - Hook up to hwmon
     * show sensor attributes only if hwmon is present
     * ... and the board's reference voltage is known
     * otherwise be just a touchscreen
 - Report voltages per hwmon convention
     * measure in millivolts
     * voltages are named in[0-8]_input (ugh)
     * for 7846 chips, properly range-adjust vBATT/in1_input

Battery measurements help during recharge monitoring.  On OSK/Mistral,
the measured voltage agreed with a multimeter to several decimal places.
 
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
UPDATED per feedback from Dmitry, and to fix a HWMON dependency glitch

 drivers/input/touchscreen/Kconfig   |    9 -
 drivers/input/touchscreen/ads7846.c |  299 +++++++++++++++++++++++++-----------
 2 files changed, 220 insertions(+), 88 deletions(-)

Index: osk/drivers/input/touchscreen/Kconfig
===================================================================
--- osk.orig/drivers/input/touchscreen/Kconfig	2006-12-22 11:08:09.000000000 -0800
+++ osk/drivers/input/touchscreen/Kconfig	2006-12-22 13:55:13.000000000 -0800
@@ -12,12 +12,17 @@ menuconfig INPUT_TOUCHSCREEN
 if INPUT_TOUCHSCREEN
 
 config TOUCHSCREEN_ADS7846
-	tristate "ADS 7846 based touchscreens"
+	tristate "ADS 7846/7843 based touchscreens"
 	depends on SPI_MASTER
+	depends on HWMON = n || HWMON
 	help
 	  Say Y here if you have a touchscreen interface using the
-	  ADS7846 controller, and your board-specific initialization
+	  ADS7846 or ADS7843 controller, and your board-specific setup
 	  code includes that in its table of SPI devices.
+	  
+	  If HWMON is selected, and the driver is told the reference voltage
+	  on your board, you will also get hwmon interfaces for the voltage
+	  (and on ads7846, temperature) sensors of this chip.
 
 	  If unsure, say N (but it's safe to say "Y").
 
Index: osk/drivers/input/touchscreen/ads7846.c
===================================================================
--- osk.orig/drivers/input/touchscreen/ads7846.c	2006-12-22 11:08:43.000000000 -0800
+++ osk/drivers/input/touchscreen/ads7846.c	2006-12-22 13:58:09.000000000 -0800
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
  */
+static unsigned vREF_mV;
+module_param(vREF_mV, uint, 0);
+MODULE_PARM_DESC(vREF_mV, "external vREF voltage, in milliVolts");
 
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
@@ -260,21 +272,168 @@ static int ads7846_read12_ser(struct dev
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
+ * ADS7846 could use the low-accuracy two-sample scheme, but can't do the high
+ * accuracy scheme without calibration data.  For now we won't try either;
+ * userspace sees raw sensor values, and must scale/calibrate appropriately.
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
+
+static struct attribute *ads7846_attributes[] = {
+	&dev_attr_temp0.attr,
+	&dev_attr_temp1.attr,
+	&dev_attr_in0_input.attr,
+	&dev_attr_in1_input.attr,
+	NULL,
+};
+
+static struct attribute_group ads7846_attr_group = {
+	.attrs = ads7846_attributes,
+};
+
+static struct attribute *ads7843_attributes[] = {
+	&dev_attr_in0_input.attr,
+	&dev_attr_in1_input.attr,
+	NULL,
+};
+
+static struct attribute_group ads7843_attr_group = {
+	.attrs = ads7843_attributes,
+};
+
+static struct attribute *ads7845_attributes[] = {
+	&dev_attr_in0_input.attr,
+	NULL,
+};
+
+static struct attribute_group ads7845_attr_group = {
+	.attrs = ads7845_attributes,
+};
+
+static inline int
+ads784x_hwmon_register(struct spi_device *spi, struct ads7846 *ts)
+{
+	int err;
+
+	/* hwmon sensors need a reference voltage */
+	switch (ts->model) {
+	case 7846:
+		if (!vREF_mV) {
+			dev_dbg(&spi->dev, "assuming 2.5V internal vREF\n");
+			vREF_mV = 2500;
+		}
+		break;
+	case 7845:
+	case 7843:
+		if (!vREF_mV) {
+			dev_warn(&spi->dev,
+				"external vREF for ADS%d not specified\n",
+				ts->model);
+			return 0;
+		}
+		break;
+	}
+
+	/* different chips have different sensor groups */
+	switch (ts->model) {
+	case 7846:
+		ts->attr_group = &ads7846_attr_group;
+		break;
+	case 7845:
+		ts->attr_group = &ads7845_attr_group;
+		break;
+	case 7843:
+		ts->attr_group = &ads7843_attr_group;
+		break;
+	default:
+		dev_dbg(&spi->dev, "ADS%d not recognized\n", ts->model);
+		return 0;
+	}
+
+	err = sysfs_create_group(&spi->dev.kobj, ts->attr_group);
+	if (err == 0) {
+		ts->hwmon = hwmon_device_register(&spi->dev);
+		if (IS_ERR(ts->hwmon)) {
+			err = PTR_ERR(ts->hwmon);
+			sysfs_remove_group(&spi->dev.kobj, ts->attr_group);
+			ts->hwmon = NULL;
+		}
+	}
+	if (err)
+		ts->attr_group = NULL;
+	return err;
+}
+
+static inline void
+ads784x_hwmon_unregister(struct spi_device *spi, struct ads7846 *ts)
+{
+	sysfs_remove_group(&spi->dev.kobj, ts->attr_group);
+	hwmon_device_unregister(ts->hwmon);
+}
+
+
+#else
+static inline int
+ads784x_hwmon_register(struct spi_device *spi, struct ads7846 *ts)
+{
+	return 0;
+}
+
+static inline void
+ads784x_hwmon_unregister(struct spi_device *spi, struct ads7846 *ts)
+{
+}
+#endif
 
 static int is_pen_down(struct device *dev)
 {
@@ -322,46 +481,14 @@ static ssize_t ads7846_disable_store(str
 
 static DEVICE_ATTR(disable, 0664, ads7846_disable_show, ads7846_disable_store);
 
-static struct attribute *ads7846_attributes[] = {
-	&dev_attr_temp0.attr,
-	&dev_attr_temp1.attr,
-	&dev_attr_vbatt.attr,
-	&dev_attr_vaux.attr,
-	&dev_attr_pen_down.attr,
-	&dev_attr_disable.attr,
-	NULL,
-};
-
-static struct attribute_group ads7846_attr_group = {
-	.attrs = ads7846_attributes,
-};
-
-/*
- * ads7843/7845 don't have temperature sensors, and
- * use the other sensors a bit differently too
- */
-
-static struct attribute *ads7843_attributes[] = {
-	&dev_attr_vbatt.attr,
-	&dev_attr_vaux.attr,
-	&dev_attr_pen_down.attr,
-	&dev_attr_disable.attr,
-	NULL,
-};
-
-static struct attribute_group ads7843_attr_group = {
-	.attrs = ads7843_attributes,
-};
-
-static struct attribute *ads7845_attributes[] = {
-	&dev_attr_vaux.attr,
+static struct attribute *ads784x_attributes[] = {
 	&dev_attr_pen_down.attr,
 	&dev_attr_disable.attr,
 	NULL,
 };
 
-static struct attribute_group ads7845_attr_group = {
-	.attrs = ads7845_attributes,
+static struct attribute_group ads784x_attr_group = {
+	.attrs = ads784x_attributes,
 };
 
 /*--------------------------------------------------------------------------*/
@@ -876,28 +1003,24 @@ static int __devinit ads7846_probe(struc
 		goto err_cleanup_filter;
 	}
 
-	dev_info(&spi->dev, "touchscreen, irq %d\n", spi->irq);
+	err = ads784x_hwmon_register(spi, ts);
+	if (err != 0) {
+		goto err_free_irq;
+	}
 
-	/* take a first sample, leaving nPENIRQ active; avoid
+	dev_info(&spi->dev, "touchscreen%s, irq %d\n",
+			ts->hwmon ? " + hwmon" : "",
+			spi->irq);
+
+	/* take a first sample, leaving nPENIRQ active and vREF off; avoid
 	 * the touchscreen, in case it's not connected.
 	 */
 	(void) ads7846_read12_ser(&spi->dev,
 			  READ_12BIT_SER(vaux) | ADS_PD10_ALL_ON);
 
-	switch (ts->model) {
-	case 7846:
-		ts->attr_group = &ads7846_attr_group;
-		break;
-	case 7845:
-		ts->attr_group = &ads7845_attr_group;
-		break;
-	default:
-		ts->attr_group = &ads7843_attr_group;
-		break;
-	}
-	err = sysfs_create_group(&spi->dev.kobj, ts->attr_group);
+	err = sysfs_create_group(&spi->dev.kobj, &ads784x_attr_group);
 	if (err)
-		goto err_free_irq;
+		goto err_remove_hwmon;
 
 	err = input_register_device(input_dev);
 	if (err)
@@ -906,7 +1029,10 @@ static int __devinit ads7846_probe(struc
 	return 0;
 
  err_remove_attr_group:
-	sysfs_remove_group(&spi->dev.kobj, ts->attr_group);
+	sysfs_remove_group(&spi->dev.kobj, &ads784x_attr_group);
+ err_remove_hwmon:
+	if (ts->hwmon)
+		ads784x_hwmon_unregister(spi, ts);
  err_free_irq:
 	free_irq(spi->irq, ts);
  err_cleanup_filter:
@@ -922,11 +1048,12 @@ static int __devexit ads7846_remove(stru
 {
 	struct ads7846		*ts = dev_get_drvdata(&spi->dev);
 
+	ads784x_hwmon_unregister(spi, ts);
 	input_unregister_device(ts->input);
 
 	ads7846_suspend(spi, PMSG_SUSPEND);
 
-	sysfs_remove_group(&spi->dev.kobj, ts->attr_group);
+	sysfs_remove_group(&spi->dev.kobj, &ads784x_attr_group);
 
 	free_irq(ts->spi->irq, ts);
 	/* suspend left the IRQ disabled */

