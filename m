Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWANV1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWANV1E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 16:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWANV1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 16:27:04 -0500
Received: from mail.kroah.org ([69.55.234.183]:8596 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751301AbWANV1D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 16:27:03 -0500
Cc: david-b@pacbell.net
Subject: [PATCH] spi: ads7846 driver
In-Reply-To: <11371995921894@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 16:46:32 -0800
Message-Id: <11371995923994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] spi: ads7846 driver

This is a driver for the ADS7846 touchscreen sensor, derived from
the corgi_ts and omap_ts drivers.  Key differences from those two:

  - Uses the new SPI framework (minimalist version)
  - <linux/spi/ads7846.h> abstracts board-specific touchscreen info
  - Sysfs attributes for the temperature and voltage sensors
  - Uses fewer ARM-specific IRQ primitives

The temperature and voltage sensors show up in sysfs like this:

  $ pwd
  /sys/devices/platform/omap-uwire/spi2.0
  $ ls
  bus@          input:event0@ power/        temp1         vbatt
  driver@       modalias      temp0         vaux
  $ cat modalias
  ads7846
  $ cat temp0
  991
  $ cat temp1
  1177
  $

So far only basic testing has been done.  There's a fair amount of hardware
that uses this sensor, and which also runs Linux, which should eventually
be able to use this driver.

One portability note may be of special interest.  It turns out that not all
SPI controllers are happy issuing requests that do things like "write 8 bit
command, read 12 bit response".  Most of them seem happy to handle various
word sizes, so the issue isn't "12 bit response" but rather "different rx
and tx write sizes", despite that being a common MicroWire convention.  So
this version of the driver no longer reads 12 bit native-endian words; it
reads 16-bit big-endian responses, then byteswaps them and shifts the
results to discard the noise.

Signed-off-by: David Brownell <david-b@pacbell.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ffa458c1bd9b6f653008d450f337602f3d52a646
tree 0e42f7d36790dd7088586b32d9c5290d34b10831
parent 8ae12a0d85987dc138f8c944cb78a92bf466cea0
author David Brownell <david-b@pacbell.net> Sun, 08 Jan 2006 13:34:21 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 16:29:54 -0800

 drivers/input/touchscreen/Kconfig   |   13 +
 drivers/input/touchscreen/Makefile  |    1 
 drivers/input/touchscreen/ads7846.c |  621 +++++++++++++++++++++++++++++++++++
 include/linux/spi/ads7846.h         |   18 +
 4 files changed, 653 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 21d55ed..2c67402 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -11,6 +11,19 @@ menuconfig INPUT_TOUCHSCREEN
 
 if INPUT_TOUCHSCREEN
 
+config TOUCHSCREEN_ADS7846
+	tristate "ADS 7846 based touchscreens"
+	depends on SPI_MASTER
+	help
+	  Say Y here if you have a touchscreen interface using the
+	  ADS7846 controller, and your board-specific initialization
+	  code includes that in its table of SPI devices.
+
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ads7846.
+
 config TOUCHSCREEN_BITSY
 	tristate "Compaq iPAQ H3600 (Bitsy) touchscreen"
 	depends on SA1100_BITSY
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 6842869..5e5557c 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -4,6 +4,7 @@
 
 # Each configuration option enables a list of files.
 
+obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
 obj-$(CONFIG_TOUCHSCREEN_BITSY)	+= h3600_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_CORGI)	+= corgi_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)	+= gunze.o
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
new file mode 100644
index 0000000..24ff6c5
--- /dev/null
+++ b/drivers/input/touchscreen/ads7846.c
@@ -0,0 +1,621 @@
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
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
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
+ * accuracy of 0.3 degrees C; otherwise it's 2.0 degrees.)
+ *
+ * app note sbaa036 talks in more detail about accurate sampling...
+ * that ought to help in situations like LCDs inducing noise (which
+ * can also be helped by using synch signals) and more generally.
+ */
+
+#define	TS_POLL_PERIOD	msecs_to_jiffies(10)
+
+struct ts_event {
+	/* For portability, we can't read 12 bit values using SPI (which
+	 * would make the controller deliver them as native byteorder u16
+	 * with msbs zeroed).  Instead, we read them as two 8-byte values,
+	 * which need byteswapping then range adjustment.
+	 */
+	__be16 x;
+	__be16 y;
+	__be16 z1, z2;
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
+// FIXME remove "irq_disabled"
+	unsigned		irq_disabled:1;	/* P: lock */
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
+	__be16			sample;
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
+	/* REVISIT:  take a few more samples, and compare ... */
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
+	sample = be16_to_cpu(req->sample);
+	sample = sample >> 4;
+	kfree(req);
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
+	u16		x, y, z1, z2;
+	unsigned long	flags;
+
+	/* adjust:  12 bit samples (left aligned), built from
+	 * two 8 bit values writen msb-first.
+	 */
+	x = be16_to_cpu(ts->tc.x) >> 4;
+	y = be16_to_cpu(ts->tc.y) >> 4;
+	z1 = be16_to_cpu(ts->tc.z1) >> 4;
+	z2 = be16_to_cpu(ts->tc.z2) >> 4;
+
+	/* range filtering */
+	if (x == MAX_12BIT)
+		x = 0;
+
+	if (x && z1 && ts->spi->dev.power.power_state.event == PM_EVENT_ON) {
+		/* compute touch pressure resistance using equation #2 */
+		Rt = z2;
+		Rt -= z1;
+		Rt *= x;
+		Rt *= ts->x_plate_ohms;
+		Rt /= z1;
+		Rt = (Rt + 2047) >> 12;
+	} else
+		Rt = 0;
+
+	/* NOTE:  "pendown" is inferred from pressure; we don't rely on
+	 * being able to check nPENIRQ status, or "friendly" trigger modes
+	 * (both-edges is much better than just-falling or low-level).
+	 *
+	 * REVISIT:  some boards may require reading nPENIRQ; it's
+	 * needed on 7843.  and 7845 reads pressure differently...
+	 *
+	 * REVISIT:  the touchscreen might not be connected; this code
+	 * won't notice that, even if nPENIRQ never fires ...
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
+		input_report_abs(&ts->input, ABS_Y, y);
+		input_report_abs(&ts->input, ABS_PRESSURE, Rt);
+		sync = 1;
+	}
+	if (sync)
+		input_sync(&ts->input);
+
+#ifdef	VERBOSE
+	if (Rt || ts->pendown)
+		pr_debug("%s: %d/%d/%d%s\n", ts->spi->dev.bus_id,
+			x, y, Rt, Rt ? "" : " UP");
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
+/* non-empty "extra" is needed before 2.6.14-git5 or so */
+#define	EXTRA	//	, u32 level
+#define	EXTRA2	//	, 0
+
+static int
+ads7846_suspend(struct device *dev, pm_message_t message EXTRA)
+{
+	struct ads7846 *ts = dev_get_drvdata(dev);
+	unsigned long	flags;
+
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
+static int ads7846_resume(struct device *dev EXTRA)
+{
+	struct ads7846 *ts = dev_get_drvdata(dev);
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
+		return -EINVAL;
+	}
+
+	/* We'd set the wordsize to 12 bits ... except that some controllers
+	 * will then treat the 8 bit command words as 12 bits (and drop the
+	 * four MSBs of the 12 bit result).  Result: inputs must be shifted
+	 * to discard the four garbage LSBs.
+	 */
+
+	if (!(ts = kzalloc(sizeof(struct ads7846), GFP_KERNEL)))
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, ts);
+
+	ts->spi = spi;
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
+	ts->input.name = "ADS784x Touchscreen";
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
+	dev_info(dev, "touchscreen, irq %d\n", spi->irq);
+
+	/* take a first sample, leaving nPENIRQ active; avoid
+	 * the touchscreen, in case it's not connected.
+	 */
+	(void) ads7846_read12_ser(dev,
+			  READ_12BIT_SER(vaux) | ADS_PD10_ALL_ON);
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
+	ads7846_suspend(dev, PMSG_SUSPEND EXTRA2);
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
+	// also TI 1510 Innovator, bitbanging through FPGA
+	// also Nokia 770
+	// also Palm Tungsten T2
+#endif
+
+	// PXA:
+	// also Dell Axim X50
+	// also HP iPaq H191x/H192x/H415x/H435x
+	// also Intel Lubbock (alternate to UCB1400)
+	// also Sharp Zaurus C7xx, C8xx (corgi/sheperd/husky)
+
+	// also various AMD Au1x00 devel boards
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
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
new file mode 100644
index 0000000..84a2701
--- /dev/null
+++ b/include/linux/spi/ads7846.h
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

