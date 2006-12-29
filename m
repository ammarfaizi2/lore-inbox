Return-Path: <linux-kernel-owner+w=401wt.eu-S1753990AbWL2GW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbWL2GW4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 01:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754113AbWL2GW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 01:22:56 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:12543 "EHLO
	asav10.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753990AbWL2GWz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 01:22:55 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlwPAGNDlEVKhRO4UGdsb2JhbACHN4ZJAQEq
From: Dmitry Torokhov <dtor@insightbb.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.20-rc1 6/6] input: ads7846 directly senses PENUP state
Date: Fri, 29 Dec 2006 01:22:51 -0500
User-Agent: KMail/1.9.3
Cc: Imre Deak <imre.deak@solidboot.com>, linux-kernel@vger.kernel.org,
       nicolas.ferre@rfo.atmel.com, tony@atomide.com
References: <20061222192536.A206A1F0CDB@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <20061227141430.GB9009@mammoth.research.nokia.com> <200612281437.56888.david-b@pacbell.net>
In-Reply-To: <200612281437.56888.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612290122.52752.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 December 2006 17:37, David Brownell wrote:
> > > > I think these helpers just obfuscate the code, just call
> > > > input_report_*() and input_sync() drectly like you used to do.
> > > 
> > > Fair enough, I had a similar thought.  Imre, could you do that update?
> > 
> > Yes, the patch is against the OMAP tree.
> 
> Thanks ... still hoping that the OMAP tree will just be able
> to pull down the kernel.org version of this driver soon!!
> 
> OK, here's an updated patch 6/6 that merges Imre's update.
> 
> Dmitry, that makes six patches you should have ... I updated
> the hwmon patch (#3), and now this one (#6); #4 and #5 will
> thus apply with some offsets.
> 

David,

I appied all patches except for hwmon as it had some issues with CONFIG_HWMON
handling. Could you please take a look at the patch below and tell me if it
works for you?

-- 
Dmitry

From: David Brownell <dbrownell@users.sourceforge.net>

Input: ads7846 - be more compatible with the hwmon framework

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
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/Kconfig   |    9 -
 drivers/input/touchscreen/ads7846.c |  306 +++++++++++++++++++++++++-----------
 2 files changed, 224 insertions(+), 91 deletions(-)

Index: work/drivers/input/touchscreen/Kconfig
===================================================================
--- work.orig/drivers/input/touchscreen/Kconfig
+++ work/drivers/input/touchscreen/Kconfig
@@ -12,13 +12,18 @@ menuconfig INPUT_TOUCHSCREEN
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
 
+	  If HWMON is selected, and the driver is told the reference voltage
+	  on your board, you will also get hwmon interfaces for the voltage
+	  (and on ads7846, temperature) sensors of this chip.
+
 	  If unsure, say N (but it's safe to say "Y").
 
 	  To compile this driver as a module, choose M here: the
Index: work/drivers/input/touchscreen/ads7846.c
===================================================================
--- work.orig/drivers/input/touchscreen/ads7846.c
+++ work/drivers/input/touchscreen/ads7846.c
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
@@ -69,7 +70,7 @@ struct ts_event {
 	u16	x;
 	u16	y;
 	u16	z1, z2;
-	int    ignore;
+	int	ignore;
 };
 
 struct ads7846 {
@@ -77,7 +78,12 @@ struct ads7846 {
 	char			phys[32];
 
 	struct spi_device	*spi;
+
+#if defined(CONFIG_HWMON) || (defined(MODULE) && defined(CONFIG_HWMON_MODULE))
 	struct attribute_group	*attr_group;
+	struct class_device	*hwmon;
+#endif
+
 	u16			model;
 	u16			vref_delay_usecs;
 	u16			x_plate_ohms;
@@ -170,7 +176,12 @@ struct ads7846 {
 
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
@@ -198,50 +209,55 @@ static int ads7846_read12_ser(struct dev
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
-
-	/*
-	 * for external VREF, 0 usec (and assume it's always on);
-	 * for 1uF, use 800 usec;
-	 * no cap, 100 usec.
-	 */
-	req->xfer[1].delay_usecs = ts->vref_delay_usecs;
+	/* FIXME boards with ads7846 might use external vref instead ... */
+	use_internal = (ts->model == 7846);
+
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
-
-	/* group all the transfers together, so we can't interfere with
-	 * reading touchscreen state; disable penirq while sampling
-	 */
-	for (i = 0; i < 6; i++)
-		spi_message_add_tail(&req->xfer[i], &req->msg);
+	/* maybe off internal vREF */
+	if (use_internal) {
+		req->ref_off = REF_OFF;
+		req->xfer[4].tx_buf = &req->ref_off;
+		req->xfer[4].len = 1;
+		spi_message_add_tail(&req->xfer[4], &req->msg);
+
+		req->xfer[5].rx_buf = &req->scratch;
+		req->xfer[5].len = 2;
+		CS_CHANGE(req->xfer[5]);
+		spi_message_add_tail(&req->xfer[5], &req->msg);
+	}
 
 	ts->irq_disabled = 1;
 	disable_irq(spi->irq);
@@ -261,25 +277,173 @@ static int ads7846_read12_ser(struct dev
 	return status ? status : sample;
 }
 
-#define SHOW(name) static ssize_t \
+#if defined(CONFIG_HWMON) || (defined(MODULE) && defined(CONFIG_HWMON_MODULE))
+
+#define SHOW(name, var, adjust) static ssize_t \
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
+SHOW(temp0, temp0, null_adjust)		/* temp1_input */
+SHOW(temp1, temp1, null_adjust)		/* temp2_input */
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
+static int ads784x_hwmon_register(struct spi_device *spi, struct ads7846 *ts)
+{
+	struct class_device *hwmon;
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
+	if (err)
+		return err;
+
+	hwmon = hwmon_device_register(&spi->dev);
+	if (IS_ERR(hwmon)) {
+		sysfs_remove_group(&spi->dev.kobj, ts->attr_group);
+		return PTR_ERR(hwmon);
+	}
+
+	ts->hwmon = hwmon;
+	return 0;
+}
+
+static void ads784x_hwmon_unregister(struct spi_device *spi,
+				     struct ads7846 *ts)
+{
+	if (ts->hwmon) {
+		sysfs_remove_group(&spi->dev.kobj, ts->attr_group);
+		hwmon_device_unregister(ts->hwmon);
+	}
+}
+
+#else
+static inline int ads784x_hwmon_register(struct spi_device *spi,
+					 struct ads7846 *ts)
+{
+	return 0;
+}
+
+static inline void ads784x_hwmon_unregister(struct spi_device *spi,
+					    struct ads7846 *ts)
+{
+}
+#endif
 
 static int is_pen_down(struct device *dev)
 {
-	struct ads7846		*ts = dev_get_drvdata(dev);
+	struct ads7846	*ts = dev_get_drvdata(dev);
 
 	return ts->pendown;
 }
@@ -323,46 +487,14 @@ static ssize_t ads7846_disable_store(str
 
 static DEVICE_ATTR(disable, 0664, ads7846_disable_show, ads7846_disable_store);
 
-static struct attribute *ads7846_attributes[] = {
-	&dev_attr_temp0.attr,
-	&dev_attr_temp1.attr,
-	&dev_attr_vbatt.attr,
-	&dev_attr_vaux.attr,
+static struct attribute *ads784x_attributes[] = {
 	&dev_attr_pen_down.attr,
 	&dev_attr_disable.attr,
 	NULL,
 };
 
-static struct attribute_group ads7846_attr_group => > > I think these helpers just obfuscate the code, just call
> > > input_report_*() and input_sync() drectly like you used to do.
> > 
> > Fair enough, I had a similar thought.  Imre, could you do that update?
> 
> Yes, the patch is against the OMAP tree.

Thanks ... still hoping that the OMAP tree will just be able
to pull down the kernel.org version of this driver soon!!

OK, here's an updated patch 6/6 that merges Imre's update.

Dmitry, that makes six patches you should have ... I updated
the hwmon patch (#3), and now this one (#6); #4 and #5 will
thus apply with some offsets.
 {
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
-	&dev_attr_pen_down.attr,
-	&dev_attr_disable.attr,
-	NULL,
-};
-
-static struct attribute_group ads7845_attr_group = {
-	.attrs = ads7845_attributes,
+static struct attribute_group ads784x_attr_group = {
+	.attrs = ads784x_attributes,
 };
 
 /*--------------------------------------------------------------------------*/
@@ -886,28 +1018,21 @@ static int __devinit ads7846_probe(struc
 		goto err_cleanup_filter;
 	}
 
+	err = ads784x_hwmon_register(spi, ts);
+	if (err)
+		goto err_free_irq;
+
 	dev_info(&spi->dev, "touchscreen, irq %d\n", spi->irq);
 
-	/* take a first sample, leaving nPENIRQ active; avoid
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
@@ -916,7 +1041,9 @@ static int __devinit ads7846_probe(struc
 	return 0;
 
  err_remove_attr_group:
-	sysfs_remove_group(&spi->dev.kobj, ts->attr_group);
+	sysfs_remove_group(&spi->dev.kobj, &ads784x_attr_group);
+ err_remove_hwmon:
+	ads784x_hwmon_unregister(spi, ts);
  err_free_irq:
 	free_irq(spi->irq, ts);
  err_cleanup_filter:
@@ -932,11 +1059,12 @@ static int __devexit ads7846_remove(stru
 {
 	struct ads7846		*ts = dev_get_drvdata(&spi->dev);
 
+	ads784x_hwmon_unregister(spi, ts);
 	input_unregister_device(ts->input);
 
 	ads7846_suspend(spi, PMSG_SUSPEND);
 
-	sysfs_remove_group(&spi->dev.kobj, ts->attr_group);
+	sysfs_remove_group(&spi->dev.kobj, &ads784x_attr_group);
 
 	free_irq(ts->spi->irq, ts);
 	/* suspend left the IRQ disabled */
