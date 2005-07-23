Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVGWNWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVGWNWF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 09:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVGWNWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 09:22:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4749 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261340AbVGWNWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 09:22:03 -0400
Date: Sat, 23 Jul 2005 15:20:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       rmk@arm.linux.org.uk, vojtech@suse.cz
Subject: Re: [patch 2/2] Touchscreen support for sharp sl-5500
Message-ID: <20050723132017.GA1961@elf.ucw.cz>
References: <20050723002839.GA2077@elf.ucw.cz> <200507222251.31931.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507222251.31931.dtor_core@ameritech.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds support for touchscreen on Sharp Zaurus sl-5500. Please
apply,
							Pavel

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -36,6 +36,15 @@ config TOUCHSCREEN_CORGI
 	  To compile this driver as a module, choose M here: the
 	  module will be called ads7846_ts.
 
+config TOUCHSCREEN_COLLIE
+	tristate "Collie touchscreen (for Sharp SL-5500)"
+	depends on MCP_UCB1200
+	help
+	  Say Y here to enable the driver for the touchscreen on the 
+	  Sharp SL-5500 series of PDAs.
+
+	  If unsure, say N.
+
 config TOUCHSCREEN_GUNZE
 	tristate "Gunze AHL-51S touchscreen"
 	select SERIO
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -6,6 +6,7 @@
 
 obj-$(CONFIG_TOUCHSCREEN_BITSY)	+= h3600_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_CORGI)	+= corgi_ts.o
+obj-$(CONFIG_TOUCHSCREEN_COLLIE)+= collie_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)	+= gunze.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)	+= elo.o
 obj-$(CONFIG_TOUCHSCREEN_MTOUCH) += mtouch.o
diff --git a/drivers/input/touchscreen/collie_ts.c b/drivers/input/touchscreen/collie_ts.c
new file mode 100644
--- /dev/null
+++ b/drivers/input/touchscreen/collie_ts.c
@@ -0,0 +1,367 @@
+/*
+ *  linux/drivers/input/touchscreen/collie_ts.c
+ *
+ *  Copyright (C) 2001 Russell King, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * 21-Jan-2002 <jco@ict.es> :
+ *
+ * Added support for synchronous A/D mode. This mode is useful to
+ * avoid noise induced in the touchpanel by the LCD, provided that
+ * the UCB1x00 has a valid LCD sync signal routed to its ADCSYNC pin.
+ * It is important to note that the signal connected to the ADCSYNC
+ * pin should provide pulses even when the LCD is blanked, otherwise
+ * a pen touch needed to unblank the LCD will never be read.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/sched.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/input.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/kthread.h>
+
+#include <asm/dma.h>
+#include <asm/semaphore.h>
+
+#include <asm/arch-sa1100/ucb1x00.h>
+
+
+struct ucb1x00_ts {
+	struct input_dev	idev;
+	struct ucb1x00		*ucb;
+
+	struct semaphore	irq_wait;
+	struct task_struct	*rtask;
+	u16			x_res;
+	u16			y_res;
+
+	int			restart:1;
+	int			adcsync:1;
+};
+
+/*
+ * Switch to interrupt mode.
+ */
+static inline void ucb1x00_ts_mode_int(struct ucb1x00_ts *ts)
+{
+	int val = UCB_TS_CR_TSMX_POW | UCB_TS_CR_TSPX_POW |
+		  UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_GND |
+		  UCB_TS_CR_MODE_INT;
+	if (ts->ucb->id == UCB_ID_1400_BUGGY)
+		val &= ~(UCB_TS_CR_TSMX_POW | UCB_TS_CR_TSPX_POW);
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR, val);
+}
+
+/*
+ * Switch to pressure mode, and read pressure.  We don't need to wait
+ * here, since both plates are being driven.
+ */
+static inline unsigned int ucb1x00_ts_read_pressure(struct ucb1x00_ts *ts)
+{
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMX_POW | UCB_TS_CR_TSPX_POW |
+			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_GND |
+			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+
+	return ucb1x00_adc_read(ts->ucb, UCB_ADC_INP_TSPY, ts->adcsync);
+}
+
+/*
+ * Switch to X position mode and measure Y plate.  We switch the plate
+ * configuration in pressure mode, then switch to position mode.  This
+ * gives a faster response time.  Even so, we need to wait about 55us
+ * for things to stabilise.
+ */
+static inline unsigned int ucb1x00_ts_read_xpos(struct ucb1x00_ts *ts)
+{
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
+			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
+			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
+			UCB_TS_CR_MODE_POS | UCB_TS_CR_BIAS_ENA);
+
+	udelay(55);
+
+	return ucb1x00_adc_read(ts->ucb, UCB_ADC_INP_TSPY, ts->adcsync);
+}
+
+/*
+ * Switch to Y position mode and measure X plate.  We switch the plate
+ * configuration in pressure mode, then switch to position mode.  This
+ * gives a faster response time.  Even so, we need to wait about 55us
+ * for things to stabilise.
+ */
+static inline unsigned int ucb1x00_ts_read_ypos(struct ucb1x00_ts *ts)
+{
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
+			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
+			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
+			UCB_TS_CR_MODE_POS | UCB_TS_CR_BIAS_ENA);
+
+	udelay(55);
+
+	return ucb1x00_adc_read(ts->ucb, UCB_ADC_INP_TSPX, ts->adcsync);
+}
+
+/*
+ * Switch to X plate resistance mode.  Set MX to ground, PX to
+ * supply.  Measure current.
+ */
+static inline unsigned int ucb1x00_ts_read_xres(struct ucb1x00_ts *ts)
+{
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMX_GND | UCB_TS_CR_TSPX_POW |
+			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	return ucb1x00_adc_read(ts->ucb, 0, ts->adcsync);
+}
+
+/*
+ * Switch to Y plate resistance mode.  Set MY to ground, PY to
+ * supply.  Measure current.
+ */
+static inline unsigned int ucb1x00_ts_read_yres(struct ucb1x00_ts *ts)
+{
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR,
+			UCB_TS_CR_TSMY_GND | UCB_TS_CR_TSPY_POW |
+			UCB_TS_CR_MODE_PRES | UCB_TS_CR_BIAS_ENA);
+	return ucb1x00_adc_read(ts->ucb, 0, ts->adcsync);
+}
+
+/*
+ * This is a RT kernel thread that handles the ADC accesses
+ * (mainly so we can use semaphores in the UCB1200 core code
+ * to serialise accesses to the ADC).  The UCB1400 access
+ * functions are expected to be able to sleep as well.
+ */
+static int ucb1x00_thread(void *_ts)
+{
+	struct ucb1x00_ts *ts = _ts;
+	struct task_struct *tsk = current;
+	int valid;
+
+	ts->rtask = tsk;
+
+	/*
+	 * We run as a real-time thread.  However, thus far
+	 * this doesn't seem to be necessary.
+	 */
+	tsk->policy = SCHED_FIFO;
+	tsk->rt_priority = 1;
+
+	valid = 0;
+	for (;;) {
+		unsigned int x, y, p, val;
+
+		ts->restart = 0;
+
+		ucb1x00_adc_enable(ts->ucb);
+
+		x = ucb1x00_ts_read_xpos(ts);
+		y = ucb1x00_ts_read_ypos(ts);
+		p = ucb1x00_ts_read_pressure(ts);
+
+		/*
+		 * Switch back to interrupt mode.
+		 */
+		ucb1x00_ts_mode_int(ts);
+		ucb1x00_adc_disable(ts->ucb);
+
+		msleep(10);
+
+		ucb1x00_enable(ts->ucb);
+		val = ucb1x00_reg_read(ts->ucb, UCB_TS_CR);
+
+		if (val & (UCB_TS_CR_TSPX_LOW | UCB_TS_CR_TSMX_LOW)) {
+			ucb1x00_enable_irq(ts->ucb, UCB_IRQ_TSPX, UCB_FALLING);
+			ucb1x00_disable(ts->ucb);
+
+			/*
+			 * If we spat out a valid sample set last time,
+			 * spit out a "pen off" sample here.
+			 */
+			if (valid) {
+				input_report_abs(&ts->idev, ABS_PRESSURE, 0);
+				input_sync(&ts->idev);
+				valid = 0;
+			}
+
+			/*
+			 * Since ucb1x00_enable_irq() might sleep due
+			 * to the way the UCB1400 regs are accessed, we
+			 * can't use set_task_state() before that call,
+			 * and not changing state before enabling the
+			 * interrupt is racy.  A semaphore solves all
+			 * those issues quite nicely.
+			 */
+			down_interruptible(&ts->irq_wait);
+		} else {
+			ucb1x00_disable(ts->ucb);
+
+			/*
+			 * Filtering is policy.  Policy belongs in user
+			 * space.  We therefore leave it to user space
+			 * to do any filtering they please.
+			 */
+			if (!ts->restart) {
+				input_report_abs(&ts->idev, ABS_X, x);
+				input_report_abs(&ts->idev, ABS_Y, y);
+				input_report_abs(&ts->idev, ABS_PRESSURE, p);
+				input_sync(&ts->idev);
+				valid = 1;
+			}
+
+			msleep_interruptible(10);
+		}
+
+		if (kthread_should_stop())
+			break;
+	}
+
+	ts->rtask = NULL;
+	return 0;
+}
+
+/*
+ * We only detect touch screen _touches_ with this interrupt
+ * handler, and even then we just schedule our task.
+ */
+static void ucb1x00_ts_irq(int idx, void *id)
+{
+	struct ucb1x00_ts *ts = id;
+	ucb1x00_disable_irq(ts->ucb, UCB_IRQ_TSPX, UCB_FALLING);
+	up(&ts->irq_wait);
+}
+
+static int ucb1x00_ts_open(struct input_dev *idev)
+{
+	struct ucb1x00_ts *ts = (struct ucb1x00_ts *)idev;
+	int ret = 0;
+	struct task_struct *task;
+
+	BUG_ON(ts->rtask);
+
+	sema_init(&ts->irq_wait, 0);
+	ret = ucb1x00_hook_irq(ts->ucb, UCB_IRQ_TSPX, ucb1x00_ts_irq, ts);
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * If we do this at all, we should allow the user to
+	 * measure and read the X and Y resistance at any time.
+	 */
+	ucb1x00_adc_enable(ts->ucb);
+	ts->x_res = ucb1x00_ts_read_xres(ts);
+	ts->y_res = ucb1x00_ts_read_yres(ts);
+	ucb1x00_adc_disable(ts->ucb);
+
+	task = kthread_run(ucb1x00_thread, ts, "ktsd");
+	if (!IS_ERR(task)) {
+		ret = 0;
+	} else {
+		ucb1x00_free_irq(ts->ucb, UCB_IRQ_TSPX, ts);
+		ret = -EFAULT;
+	}
+
+ out:
+	return ret;
+}
+
+/*
+ * Release touchscreen resources.  Disable IRQs.
+ */
+static void ucb1x00_ts_close(struct input_dev *idev)
+{
+	struct ucb1x00_ts *ts = (struct ucb1x00_ts *)idev;
+
+	if (ts->rtask)
+		kthread_stop(ts->rtask);
+
+	ucb1x00_enable(ts->ucb);
+	ucb1x00_free_irq(ts->ucb, UCB_IRQ_TSPX, ts);
+	ucb1x00_reg_write(ts->ucb, UCB_TS_CR, 0);
+	ucb1x00_disable(ts->ucb);
+}
+
+/*
+ * Initialisation.
+ */
+static int ucb1x00_ts_add(struct class_device *dev)
+{
+	struct ucb1x00 *ucb = classdev_to_ucb1x00(dev);
+	struct ucb1x00_ts *ts;
+
+	ts = kmalloc(sizeof(struct ucb1x00_ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	memset(ts, 0, sizeof(struct ucb1x00_ts));
+
+	ts->ucb = ucb;
+	ts->adcsync = UCB_NOSYNC;
+
+	ts->idev.name       = "Touchscreen panel";
+	ts->idev.id.product = ts->ucb->id;
+	ts->idev.open       = ucb1x00_ts_open;
+	ts->idev.close      = ucb1x00_ts_close;
+
+	set_bit(EV_ABS, ts->idev.evbit);
+	set_bit(ABS_X, ts->idev.absbit);
+	set_bit(ABS_Y, ts->idev.absbit);
+	set_bit(ABS_PRESSURE, ts->idev.absbit);
+
+	input_register_device(&ts->idev);
+
+	ucb->ts_data = ts;
+
+	return 0;
+}
+
+static void ucb1x00_ts_remove(struct class_device *dev)
+{
+	struct ucb1x00 *ucb = classdev_to_ucb1x00(dev);
+	struct ucb1x00_ts *ts = ucb->ts_data;
+
+	input_unregister_device(&ts->idev);
+	kfree(ts);
+}
+
+static struct class_interface ucb1x00_ts_interface = {
+	.add		= ucb1x00_ts_add,
+	.remove		= ucb1x00_ts_remove,
+};
+
+static int __init ucb1x00_ts_init(void)
+{
+	return ucb1x00_register_interface(&ucb1x00_ts_interface);
+}
+
+static void __exit ucb1x00_ts_exit(void)
+{
+	ucb1x00_unregister_interface(&ucb1x00_ts_interface);
+}
+
+module_init(ucb1x00_ts_init);
+module_exit(ucb1x00_ts_exit);
+
+MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
+MODULE_DESCRIPTION("UCB1x00 touchscreen driver");
+MODULE_LICENSE("GPL");

-- 
teflon -- maybe it is a trademark, but it should not be.
