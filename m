Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbVJDSDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbVJDSDM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 14:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVJDSDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 14:03:12 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:4561 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S964889AbVJDSDB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 14:03:01 -0400
X-ORBL: [69.107.75.50]
Date: Tue, 04 Oct 2005 11:02:53 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH/RFC 2/2] SPI, ADS7846 driver
Cc: spi-devel-general@lists.sourceforge.net, basicmark@yahoo.com,
       stephen@streetfiresound.com, dpervushin@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051004180253.62904EE8D1@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a driver for the ADS7846 touchscreen chip, derived from the
corgi_ts and omap_ts drivers.  Key differences from those two:

  - Uses the new SPI framework (minimalist version)
  - <linux/spi/ads7846.h> abstracts board-specific touchscreen info
  - Sysfs attributes for the temperature and voltage sensors
  - Uses fewer ARM-specific IRQ primitives

So far only basic testing has been done.  There's a fair amount of
hardware that uses this sensor, and which also runs Linux, which
should eventually be able to use this driver.

---
Unfortunately there's some OMAP-specific GPIO init code (fixable),
and an ARM-specific IRQ call (may no longer be needed) so it's
not yet as clean and generic as it should be.

Minor bug:  this should call setup() after setting the wordsize
to 12 bits in probe(); not all controller drivers will pick that
change (from default 8 bits) up when they transfer().

The temperature and voltage sensors show up in sysfs like this,
suitable for 

  $ pwd
  /sys/devices/platform/omap-uwire/spi2.0-ads7846
  $ ls
  bus@          input:event0@ power/        temp1         vbatt
  driver@       modalias      temp0         vaux
  $ cat temp0
  991
  $ cat temp1
  1177
  $

If you try this with new controller drivers, one issue to watch
out for is reading 12 bit samples.  If they're read as 16 bits,
the values will likely have nonsense in the 4 lsbs.

 drivers/input/touchscreen/Kconfig   |   12 
 drivers/input/touchscreen/Makefile  |    1 
 drivers/input/touchscreen/ads7846.c |  602 ++++++++++++++++++++++++++++++++++++
 include/linux/spi/ads7846.h         |   18 +
 4 files changed, 633 insertions(+)

--- g26.orig/drivers/input/touchscreen/Makefile	2005-05-16 13:16:51.000000000 -0700
+++ g26/drivers/input/touchscreen/Makefile	2005-10-04 08:01:01.000000000 -0700
@@ -4,6 +4,7 @@
 
 # Each configuration option enables a list of files.
 
+obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
 obj-$(CONFIG_TOUCHSCREEN_BITSY)	+= h3600_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_CORGI)	+= corgi_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)	+= gunze.o
--- g26.orig/drivers/input/touchscreen/Kconfig	2005-09-21 14:58:00.000000000 -0700
+++ g26/drivers/input/touchscreen/Kconfig	2005-10-04 08:01:01.000000000 -0700
@@ -11,6 +11,18 @@ menuconfig INPUT_TOUCHSCREEN
 
 if INPUT_TOUCHSCREEN
 
+config TOUCHSCREEN_ADS7846
+	tristate "ADS 7846 based touchscreens"
+	depends on SPI_MASTER
+	help
+	  Say Y here if you have a touchscreen interface using the
+	  ADS7846 controller.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ads7846.
+
 config TOUCHSCREEN_BITSY
 	tristate "Compaq iPAQ H3600 (Bitsy) touchscreen"
 	depends on SA1100_BITSY
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/include/linux/spi/ads7846.h	2005-10-04 08:01:01.000000000 -0700
@@ -0,0 +1,18 @@
+/* linux/spi/ads7846.h */
+
+/* Touchscreen characteristics vary between boards and models.  The
+ * platform_data for the device's "struct device" holts this information.
+ *
+ * It's OK if the min/max values are zero.
+ */
+struct ads7846_platform_data {
+	u16	model;			/* 7843, 7845, 7846. */
+	u16	vref_delay_usecs;	/* 0 for external vref; etc */
+	u16	x_plate_ohms;
+	u16	y_plate_ohms;
+
+	u16	x_min, x_max;
+	u16	y_min, y_max;
+	u16	pressure_min, pressure_max;
+};
+
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/drivers/input/touchscreen/ads7846.c	2005-10-04 08:01:01.000000000 -0700
@@ -0,0 +1,602 @@
+/*
+ * ADS7846 based touchscreen and sensor driver
+ *
+ * Copyright (c) 2005 David Brownell
+ *
+ * Using code from:
+ *  - corgi_ts.c
+ *	Copyright (C) 2004-2005 Richard Purdie
+ *  - omap_ts.[hc], ads7846.h, ts_osk.c
+ *	Copyright (C) 2002 MontaVista Software
+ *	Copyright (C) 2004 Texas Instruments
+ *	Copyright (C) 2005 Dirk Behme
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/slab.h>
+#include <linux/spi.h>
+
+#include <linux/spi/ads7846.h>
+
+
+#ifdef	CONFIG_ARM
+#include <asm/mach-types.h>
+#ifdef	CONFIG_ARCH_OMAP
+#include <asm/arch/gpio.h>
+#endif
+
+#else
+#define	set_irq_type(irq,type)	do{}while(0)
+#endif
+
+
+/*
+ * This code has been lightly tested on an ads7846.
+ * Support for ads7843 and ads7845 has only been stubbed in.
+ *
+ * Not yet done:  investigate the values reported.  Are x/y/pressure
+ * event values sane enough for X11?  How accurate are the temperature
+ * and voltage readings?  (System-specific calibration should support
+ * accuracy of 0.3 degrees C; otherwise it's 1.6 degrees.)
+ *
+ * app note sbaa036 talks in more detail about accurate sampling...
+ */
+
+#define	TS_POLL_PERIOD	msecs_to_jiffies(10)
+
+struct ts_event {
+	/* we read 12 bit values using SPI, and expect the controller
+	 * driver to deliver them in native byteorder with msbs zeroed.
+	 */
+	u16 x;
+	u16 y;
+	u16 z1, z2;
+};
+
+struct ads7846 {
+	struct input_dev	input;
+	char			phys[32];
+
+	struct spi_device	*spi;
+	u16			model;
+	u16			vref_delay_usecs;
+	u16			x_plate_ohms;
+
+	struct ts_event		tc;
+
+	struct spi_transfer	xfer[8];
+	struct spi_message	msg;
+
+	spinlock_t		lock;
+	struct timer_list	timer;		/* P: lock */
+	unsigned		pendown:1;	/* P: lock */
+	unsigned		pending:1;	/* P: lock */
+	unsigned		irq_disabled:1;	/* P: lock */
+		// FIXME remove "irq_disabled"
+};
+
+/* leave chip selected when we're done, for quicker re-select? */
+#if	0
+#define	CS_CHANGE(xfer)	((xfer).cs_change = 1)
+#else
+#define	CS_CHANGE(xfer)	((xfer).cs_change = 0)
+#endif
+
+/*--------------------------------------------------------------------------*/
+
+/* The ADS7846 has touchscreen and other sensors.
+ * Earlier ads784x chips are somewhat compatible.
+ */
+#define	ADS_START		(1 << 7)
+#define	ADS_A2A1A0_d_y		(1 << 4)	/* differential */
+#define	ADS_A2A1A0_d_z1		(3 << 4)	/* differential */
+#define	ADS_A2A1A0_d_z2		(4 << 4)	/* differential */
+#define	ADS_A2A1A0_d_x		(5 << 4)	/* differential */
+#define	ADS_A2A1A0_temp0	(0 << 4)	/* non-differential */
+#define	ADS_A2A1A0_vbatt	(2 << 4)	/* non-differential */
+#define	ADS_A2A1A0_vaux		(6 << 4)	/* non-differential */
+#define	ADS_A2A1A0_temp1	(7 << 4)	/* non-differential */
+#define	ADS_8_BIT		(1 << 3)
+#define	ADS_12_BIT		(0 << 3)
+#define	ADS_SER			(1 << 2)	/* non-differential */
+#define	ADS_DFR			(0 << 2)	/* differential */
+#define	ADS_PD10_PDOWN		(0 << 0)	/* lowpower mode + penirq */
+#define	ADS_PD10_ADC_ON		(1 << 0)	/* ADC on */
+#define	ADS_PD10_REF_ON		(2 << 0)	/* vREF on + penirq */
+#define	ADS_PD10_ALL_ON		(3 << 0)	/* ADC + vREF on */
+
+#define	MAX_12BIT	((1<<12)-1)
+
+/* leave ADC powered up (disables penirq) between differential samples */
+#define	READ_12BIT_DFR(x) (ADS_START | ADS_A2A1A0_d_ ## x \
+	| ADS_12_BIT | ADS_DFR)
+
+static const u8	read_y  = READ_12BIT_DFR(y)  | ADS_PD10_ADC_ON;
+static const u8	read_z1 = READ_12BIT_DFR(z1) | ADS_PD10_ADC_ON;
+static const u8	read_z2 = READ_12BIT_DFR(z2) | ADS_PD10_ADC_ON;
+static const u8	read_x  = READ_12BIT_DFR(x)  | ADS_PD10_PDOWN;	/* LAST */
+
+/* single-ended samples need to first power up reference voltage;
+ * we leave both ADC and VREF powered
+ */
+#define	READ_12BIT_SER(x) (ADS_START | ADS_A2A1A0_ ## x \
+	| ADS_12_BIT | ADS_SER)
+
+static const u8	ref_on = READ_12BIT_DFR(x) | ADS_PD10_ALL_ON;
+static const u8	ref_off = READ_12BIT_DFR(y) | ADS_PD10_PDOWN;
+
+/*--------------------------------------------------------------------------*/
+
+/*
+ * Non-touchscreen sensors only use single-ended conversions.
+ */
+
+struct ser_req {
+	u8			command;
+	u16			scratch;
+	u16			sample;
+	struct spi_message	msg;
+	struct spi_transfer	xfer[6];
+};
+
+static int ads7846_read12_ser(struct device *dev, unsigned command)
+{
+	struct spi_device	*spi = to_spi_device(dev);
+	struct ads7846		*ts = dev_get_drvdata(dev);
+	struct ser_req		*req = kzalloc(sizeof *req, SLAB_KERNEL);
+	int			status;
+	int			sample;
+
+	if (!req)
+		return -ENOMEM;
+
+	/* activate reference, so it has time to settle; */
+	req->xfer[0].tx_buf = &ref_on;
+	req->xfer[0].len = 1;
+	req->xfer[1].rx_buf = &req->scratch;
+	req->xfer[1].len = 2;
+
+	/*
+	 * for external VREF, 0 usec (and assume it's always on);
+	 * for 1uF, use 800 usec;
+	 * no cap, 100 usec.
+	 */
+	req->xfer[1].delay_usecs = ts->vref_delay_usecs;
+
+	/* take sample */
+	req->command = (u8) command;
+	req->xfer[2].tx_buf = &req->command;
+	req->xfer[2].len = 1;
+	req->xfer[3].rx_buf = &req->sample;
+	req->xfer[3].len = 2;
+
+	/* revisit:  take a few more, and compare ... */
+
+	/* turn off reference */
+	req->xfer[4].tx_buf = &ref_off;
+	req->xfer[4].len = 1;
+	req->xfer[5].rx_buf = &req->scratch;
+	req->xfer[5].len = 2;
+
+	CS_CHANGE(req->xfer[5]);
+
+	/* group all the transfers together, so we can't interfere with
+	 * reading touchscreen state; disable penirq while sampling
+	 */
+	req->msg.transfers = req->xfer;
+	req->msg.n_transfer = 6;
+
+	disable_irq(spi->irq);
+	status = spi_sync(spi, &req->msg);
+	enable_irq(spi->irq);
+
+	if (req->msg.status)
+		status = req->msg.status;
+	sample = req->sample;
+	kfree(req);
+
+	pr_debug("%s: measure %02x, v=%d, s=%d\n",
+		dev->bus_id, command, sample, status);
+
+	return status ? status : sample;
+}
+
+#define SHOW(name) static ssize_t \
+name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
+{ \
+	ssize_t v = ads7846_read12_ser(dev, \
+			READ_12BIT_SER(name) | ADS_PD10_ALL_ON); \
+	if (v < 0) \
+		return v; \
+	return sprintf(buf, "%u\n", (unsigned) v); \
+} \
+static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);
+
+SHOW(temp0)
+SHOW(temp1)
+SHOW(vaux)
+SHOW(vbatt)
+
+/*--------------------------------------------------------------------------*/
+
+/*
+ * PENIRQ only kicks the timer.  The timer only reissues the SPI transfer,
+ * to retrieve touchscreen status.
+ *
+ * The SPI transfer completion callback does the real work.  It reports
+ * touchscreen events and reactivates the timer (or IRQ) as appropriate.
+ */
+
+static void ads7846_rx(void *ads)
+{
+	struct ads7846	*ts = ads;
+	unsigned	Rt;
+	unsigned	sync = 0;
+	u16		x, z1;
+	unsigned long	flags;
+
+	x = ts->tc.x;
+	z1 = ts->tc.z1;
+
+	/* range filtering */
+	if (x == MAX_12BIT)
+		x = 0;
+
+	if (x && z1 && ts->spi->dev.power.power_state.event == PM_EVENT_ON) {
+		/* compute touch pressure resistance using equation #2 */
+		Rt = ts->tc.z2;
+		Rt -= ts->tc.z1;
+		Rt *= x;
+		Rt *= ts->x_plate_ohms;
+		Rt /= z1;
+		Rt = (Rt + 2047) >> 12;
+	} else
+		Rt = 0;
+
+	/* NOTE:  "pendown" is inferred from pressure; we don't rely on
+	 * being able to check nPENIRQ status.
+	 *
+	 * REVISIT:  some boards may require reading nPENIRQ; it's
+	 * needed on 7843.  7845 reads pressure differently.
+	 */
+	if (!ts->pendown && Rt != 0) {
+		input_report_key(&ts->input, BTN_TOUCH, 1);
+		sync = 1;
+	} else if (ts->pendown && Rt == 0) {
+		input_report_key(&ts->input, BTN_TOUCH, 0);
+		sync = 1;
+	}
+
+	if (Rt) {
+		input_report_abs(&ts->input, ABS_X, x);
+		input_report_abs(&ts->input, ABS_Y, ts->tc.y);
+		input_report_abs(&ts->input, ABS_PRESSURE, Rt);
+		sync = 1;
+	}
+	if (sync)
+		input_sync(&ts->input);
+
+#ifdef	VERBOSE
+	if (Rt || ts->pendown)
+		pr_debug("%s: %d/%d/%d%s\n", ts->spi->dev.bus_id,
+			x, ts->tc.y, Rt, Rt ? "" : " UP");
+#endif
+
+	/* don't retrigger while we're suspended */
+	spin_lock_irqsave(&ts->lock, flags);
+
+	ts->pendown = (Rt != 0);
+	ts->pending = 0;
+
+	if (ts->spi->dev.power.power_state.event == PM_EVENT_ON) {
+		if (ts->pendown)
+			mod_timer(&ts->timer, jiffies + TS_POLL_PERIOD);
+		else if (ts->irq_disabled) {
+			ts->irq_disabled = 0;
+			enable_irq(ts->spi->irq);
+		}
+	}
+
+	spin_unlock_irqrestore(&ts->lock, flags);
+}
+
+static void ads7846_timer(unsigned long handle)
+{
+	struct ads7846	*ts = (void *)handle;
+	int		status = 0;
+	unsigned long	flags;
+
+	spin_lock_irqsave(&ts->lock, flags);
+	if (!ts->pending) {
+		ts->pending = 1;
+		if (!ts->irq_disabled) {
+			ts->irq_disabled = 1;
+			disable_irq(ts->spi->irq);
+		}
+		status = spi_async(ts->spi, &ts->msg);
+		if (status)
+			dev_err(&ts->spi->dev, "spi_async --> %d\n",
+					status);
+	}
+	spin_unlock_irqrestore(&ts->lock, flags);
+}
+
+static irqreturn_t ads7846_irq(int irq, void *handle, struct pt_regs *regs)
+{
+	ads7846_timer((unsigned long) handle);
+	return IRQ_HANDLED;
+}
+
+/*--------------------------------------------------------------------------*/
+
+static int
+ads7846_suspend(struct device *dev, pm_message_t message, uint32_t level)
+{
+	struct ads7846 *ts = dev_get_drvdata(dev);
+	unsigned long	flags;
+
+	if (level != SUSPEND_POWER_DOWN)
+		return 0;
+	spin_lock_irqsave(&ts->lock, flags);
+
+	ts->spi->dev.power.power_state = message;
+
+	/* are we waiting for IRQ, or polling? */
+	if (!ts->pendown) {
+		if (!ts->irq_disabled) {
+			ts->irq_disabled = 1;
+			disable_irq(ts->spi->irq);
+		}
+	} else {
+		/* polling; force a final SPI completion;
+		 * that will clean things up neatly
+		 */
+		if (!ts->pending)
+			mod_timer(&ts->timer, jiffies);
+
+		while (ts->pendown || ts->pending) {
+			spin_unlock_irqrestore(&ts->lock, flags);
+			udelay(10);
+			spin_lock_irqsave(&ts->lock, flags);
+		}
+	}
+
+	/* we know the chip's in lowpower mode since we always
+	 * leave it that way after every request
+	 */
+
+	spin_unlock_irqrestore(&ts->lock, flags);
+	return 0;
+}
+
+static int ads7846_resume(struct device *dev, uint32_t level)
+{
+	struct ads7846 *ts = dev_get_drvdata(dev);
+
+	if (level != RESUME_POWER_ON)
+		return 0;
+
+	ts->irq_disabled = 0;
+	enable_irq(ts->spi->irq);
+	dev->power.power_state = PMSG_ON;
+	return 0;
+}
+
+static int __init ads7846_probe(struct device *dev)
+{
+	struct spi_device		*spi = to_spi_device(dev);
+	struct ads7846			*ts;
+	struct ads7846_platform_data	*pdata = dev->platform_data;
+	struct spi_transfer		*x;
+
+	if (!spi->irq) {
+		dev_dbg(dev, "no IRQ?\n");
+		return -ENODEV;
+	}
+
+	if (!pdata) {
+		dev_dbg(dev, "no platform data?\n");
+		return -ENODEV;
+	}
+
+	/* don't exceed max specified sample rate */
+	if (spi->max_speed_hz > (125000 * 16)) {
+		dev_dbg(dev, "f(sample) %d KHz?\n",
+				(spi->max_speed_hz/16)/1000);
+		// return -EINVAL;
+	}
+
+	if (!(ts = kzalloc(sizeof(struct ads7846), GFP_KERNEL)))
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, ts);
+
+	ts->spi = spi;
+	spi->bits_per_word = 12;
+	spi->dev.power.power_state = PMSG_ON;
+
+	init_timer(&ts->timer);
+	ts->timer.data = (unsigned long) ts;
+	ts->timer.function = ads7846_timer;
+
+	ts->model = pdata->model ? : 7846;
+	ts->vref_delay_usecs = pdata->vref_delay_usecs ? : 100;
+	ts->x_plate_ohms = pdata->x_plate_ohms ? : 400;
+
+	init_input_dev(&ts->input);
+
+	ts->input.dev = dev;
+	ts->input.name = "ADS7846 Touchscreen";
+	snprintf(ts->phys, sizeof ts->phys, "%s/input0", dev->bus_id);
+	ts->input.phys = ts->phys;
+
+	ts->input.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+	ts->input.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
+	input_set_abs_params(&ts->input, ABS_X,
+			pdata->x_min ? : 0,
+			pdata->x_max ? : MAX_12BIT,
+			0, 0);
+	input_set_abs_params(&ts->input, ABS_Y,
+			pdata->y_min ? : 0,
+			pdata->y_max ? : MAX_12BIT,
+			0, 0);
+	input_set_abs_params(&ts->input, ABS_PRESSURE,
+			pdata->pressure_min, pdata->pressure_max, 0, 0);
+
+	input_register_device(&ts->input);
+
+	/* set up the transfers to read touchscreen state; this assumes we
+	 * use formula #2 for pressure, not #3.
+	 */
+	x = ts->xfer;
+
+	/* y- still on; turn on only y+ (and ADC) */
+	x->tx_buf = &read_y;
+	x->len = 1;
+	x++;
+	x->rx_buf = &ts->tc.y;
+	x->len = 2;
+	x++;
+
+	/* turn y+ off, x- on; we'll use formula #2 */
+	if (ts->model == 7846) {
+		x->tx_buf = &read_z1;
+		x->len = 1;
+		x++;
+		x->rx_buf = &ts->tc.z1;
+		x->len = 2;
+		x++;
+
+		x->tx_buf = &read_z2;
+		x->len = 1;
+		x++;
+		x->rx_buf = &ts->tc.z2;
+		x->len = 2;
+		x++;
+	}
+
+	/* turn y- off, x+ on, then leave in lowpower */
+	x->tx_buf = &read_x;
+	x->len = 1;
+	x++;
+	x->rx_buf = &ts->tc.x;
+	x->len = 2;
+	x++;
+
+	CS_CHANGE(x[-1]);
+
+	ts->msg.transfers = ts->xfer;
+	ts->msg.n_transfer = x - ts->xfer;
+	ts->msg.complete = ads7846_rx;
+	ts->msg.context = ts;
+
+	if (request_irq(spi->irq, ads7846_irq, SA_SAMPLE_RANDOM,
+				dev->bus_id, ts)) {
+		dev_dbg(dev, "irq %d busy?\n", spi->irq);
+		input_unregister_device(&ts->input);
+		kfree(ts);
+		return -EBUSY;
+	}
+	set_irq_type(spi->irq, IRQT_FALLING);
+
+	dev_info(dev, "touchscreen registered, irq %d\n", spi->irq);
+
+	/* take the first sample, leaving nPENIRQ active */
+	ads7846_timer((unsigned long) ts);
+
+	/* ads7843/7845 don't have temperature sensors, and
+	 * use the other sensors a bit differently too
+	 */
+	if (ts->model == 7846) {
+		device_create_file(dev, &dev_attr_temp0);
+		device_create_file(dev, &dev_attr_temp1);
+	}
+	if (ts->model != 7845)
+		device_create_file(dev, &dev_attr_vbatt);
+	device_create_file(dev, &dev_attr_vaux);
+
+	return 0;
+}
+
+static int __exit ads7846_remove(struct device *dev)
+{
+	struct ads7846		*ts = dev_get_drvdata(dev);
+
+	ads7846_suspend(dev, PMSG_SUSPEND, SUSPEND_POWER_DOWN);
+	free_irq(ts->spi->irq, ts);
+	if (ts->irq_disabled)
+		enable_irq(ts->spi->irq);
+
+	if (ts->model == 7846) {
+		device_remove_file(dev, &dev_attr_temp0);
+		device_remove_file(dev, &dev_attr_temp1);
+	}
+	if (ts->model != 7845)
+		device_remove_file(dev, &dev_attr_vbatt);
+	device_remove_file(dev, &dev_attr_vaux);
+
+	input_unregister_device(&ts->input);
+	kfree(ts);
+
+	dev_dbg(dev, "unregistered touchscreen\n");
+	return 0;
+}
+
+static struct device_driver ads7846_driver = {
+	.name		= "ads7846",
+	.bus		= &spi_bus_type,
+	.probe		= ads7846_probe,
+	.remove		= __exit_p(ads7846_remove),
+	.suspend	= ads7846_suspend,
+	.resume		= ads7846_resume,
+};
+
+static int __init ads7846_init(void)
+{
+	/* grr, board-specific init should stay out of drivers!! */
+
+#ifdef	CONFIG_ARCH_OMAP
+	if (machine_is_omap_osk()) {
+		/* GPIO4 = PENIRQ; GPIO6 = BUSY */
+		omap_request_gpio(4);
+		omap_set_gpio_direction(4, 1);
+		omap_request_gpio(6);
+		omap_set_gpio_direction(6, 1);
+	}
+	// also 1510 Innovator, bitbanging through FPGA
+	// also Nokia 770
+#endif
+
+	// PXA:
+	// also Zaurus C7xx, C8xx (corgi/sheperd/husky), using PXA SSP
+	// also iPaq H4000
+	// also Lubbock (alternate to USB1400)
+
+	// also various Au1x00 devel boards, using SSP
+
+	return driver_register(&ads7846_driver);
+}
+module_init(ads7846_init);
+
+static void __exit ads7846_exit(void)
+{
+	driver_unregister(&ads7846_driver);
+
+#ifdef	CONFIG_ARCH_OMAP
+	if (machine_is_omap_osk()) {
+		omap_free_gpio(4);
+		omap_free_gpio(6);
+	}
+#endif
+
+}
+module_exit(ads7846_exit);
+
+MODULE_DESCRIPTION("ADS7846 TouchScreen Driver");
+MODULE_LICENSE("GPL");
