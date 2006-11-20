Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966857AbWKTWQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966857AbWKTWQn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966462AbWKTWQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:16:16 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:23895 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966862AbWKTWPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:15:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=AYLYUlwvCPBdARKN+Eb50lsEYDbFUG+t3Vm8hV5rLp4qE0+XzxLn+lsEKou0hCKF92Txg3JvOLgiV1n0VDQPicWCEpE0yQ+zeaJ3EeZMHYjUAn8ClbdJMG9GTCSxDJyH1wxOzHMBepFh3UoesDzCbIoy5GvqfpgEsY8RN/Xpqkw=  ;
X-YMail-OSG: GIrx.S4VM1n9wMroJ7hsMLMj05b3j4ctkysgyAVgsGCWA8LsYU5PVFW1V6qOhW6eYys7e8W7U.NrCK1qooMjUo.Mi.IiSMSEx.0VVfbAymMykwuOQEqESA--
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: [patch 2.6.19-rc6 6/6] rtc-omap driver
Date: Mon, 20 Nov 2006 10:28:48 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tony Lindgren <tony@atomide.com>
References: <200611201014.41980.david-b@pacbell.net>
In-Reply-To: <200611201014.41980.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611201028.48701.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This creates a new RTC-framework driver for the RTC/calendar module found
in various OMAP1 chips.  (OMAP2 and OMAP3 use external RTCs, like those in
TI's multifunction PM companion chips.)  It's been in the Linux-OMAP tree
for several months now, and other trees before that, so it's quite stable.
The most notable issue is that the OMAP IRQ code doesn't yet support the
RTC IRQ as a wakeup event.  Once that's fixed, a patch will be needed.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/rtc/Kconfig
===================================================================
--- g26.orig/drivers/rtc/Kconfig	2006-11-20 10:10:47.000000000 -0800
+++ g26/drivers/rtc/Kconfig	2006-11-20 10:10:49.000000000 -0800
@@ -182,6 +182,14 @@ config RTC_DRV_DS1742
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ds1742.
 
+config RTC_DRV_OMAP
+	tristate "TI OMAP1"
+	depends on RTC_CLASS && ( \
+		ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 )
+	help
+	  Say "yes" here to support the real time clock on TI OMAP1 chips.
+	  This driver can also be built as a module called rtc-omap.
+
 config RTC_DRV_PCF8563
 	tristate "Philips PCF8563/Epson RTC8564"
 	depends on RTC_CLASS && I2C
Index: g26/arch/arm/mach-omap1/devices.c
===================================================================
--- g26.orig/arch/arm/mach-omap1/devices.c	2006-11-20 10:03:05.000000000 -0800
+++ g26/arch/arm/mach-omap1/devices.c	2006-11-20 10:10:49.000000000 -0800
@@ -55,7 +55,7 @@ static inline void omap_init_irda(void) 
 
 /*-------------------------------------------------------------------------*/
 
-#if	defined(CONFIG_OMAP_RTC) || defined(CONFIG_OMAP_RTC)
+#if defined(CONFIG_RTC_DRV_OMAP) || defined(CONFIG_RTC_DRV_OMAP_MODULE)
 
 #define	OMAP_RTC_BASE		0xfffb4800
 
Index: g26/drivers/rtc/Makefile
===================================================================
--- g26.orig/drivers/rtc/Makefile	2006-11-20 10:10:47.000000000 -0800
+++ g26/drivers/rtc/Makefile	2006-11-20 10:10:49.000000000 -0800
@@ -22,6 +22,7 @@ obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
 obj-$(CONFIG_RTC_DRV_DS1307)	+= rtc-ds1307.o
 obj-$(CONFIG_RTC_DRV_DS1672)	+= rtc-ds1672.o
 obj-$(CONFIG_RTC_DRV_DS1742)	+= rtc-ds1742.o
+obj-$(CONFIG_RTC_DRV_OMAP)	+= rtc-omap.o
 obj-$(CONFIG_RTC_DRV_PCF8563)	+= rtc-pcf8563.o
 obj-$(CONFIG_RTC_DRV_PCF8583)	+= rtc-pcf8583.o
 obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o
Index: g26/drivers/rtc/rtc-omap.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/drivers/rtc/rtc-omap.c	2006-11-20 10:10:49.000000000 -0800
@@ -0,0 +1,572 @@
+/*
+ * TI OMAP1 Real Time Clock interface for Linux
+ *
+ * Copyright (C) 2003 MontaVista Software, Inc.
+ * Author: George G. Davis <gdavis@mvista.com> or <source@mvista.com>
+ *
+ * Copyright (C) 2006 David Brownell (new RTC framework)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/rtc.h>
+#include <linux/bcd.h>
+#include <linux/platform_device.h>
+
+#include <asm/io.h>
+#include <asm/mach/time.h>
+
+
+/* The OMAP1 RTC is a year/month/day/hours/minutes/seconds BCD clock
+ * with century-range alarm matching, driven by the 32kHz clock.
+ *
+ * The main user-visible ways it differs from PC RTCs are by omitting
+ * "don't care" alarm fields and sub-second periodic IRQs, and having
+ * an autoadjust mechanism to calibrate to the true oscillator rate.
+ *
+ * Board-specific wiring options include using split power mode with
+ * RTC_OFF_NOFF used as the reset signal (so the RTC won't be reset),
+ * and wiring RTC_WAKE_INT (so the RTC alarm can wake the system from
+ * low power modes).  See the BOARD-SPECIFIC CUSTOMIZATION comment.
+ */
+
+#define OMAP_RTC_BASE			0xfffb4800
+
+/* RTC registers */
+#define OMAP_RTC_SECONDS_REG		0x00
+#define OMAP_RTC_MINUTES_REG		0x04
+#define OMAP_RTC_HOURS_REG		0x08
+#define OMAP_RTC_DAYS_REG		0x0C
+#define OMAP_RTC_MONTHS_REG		0x10
+#define OMAP_RTC_YEARS_REG		0x14
+#define OMAP_RTC_WEEKS_REG		0x18
+
+#define OMAP_RTC_ALARM_SECONDS_REG	0x20
+#define OMAP_RTC_ALARM_MINUTES_REG	0x24
+#define OMAP_RTC_ALARM_HOURS_REG	0x28
+#define OMAP_RTC_ALARM_DAYS_REG		0x2c
+#define OMAP_RTC_ALARM_MONTHS_REG	0x30
+#define OMAP_RTC_ALARM_YEARS_REG	0x34
+
+#define OMAP_RTC_CTRL_REG		0x40
+#define OMAP_RTC_STATUS_REG		0x44
+#define OMAP_RTC_INTERRUPTS_REG		0x48
+
+#define OMAP_RTC_COMP_LSB_REG		0x4c
+#define OMAP_RTC_COMP_MSB_REG		0x50
+#define OMAP_RTC_OSC_REG		0x54
+
+/* OMAP_RTC_CTRL_REG bit fields: */
+#define OMAP_RTC_CTRL_SPLIT		(1<<7)
+#define OMAP_RTC_CTRL_DISABLE		(1<<6)
+#define OMAP_RTC_CTRL_SET_32_COUNTER	(1<<5)
+#define OMAP_RTC_CTRL_TEST		(1<<4)
+#define OMAP_RTC_CTRL_MODE_12_24	(1<<3)
+#define OMAP_RTC_CTRL_AUTO_COMP		(1<<2)
+#define OMAP_RTC_CTRL_ROUND_30S		(1<<1)
+#define OMAP_RTC_CTRL_STOP		(1<<0)
+
+/* OMAP_RTC_STATUS_REG bit fields: */
+#define OMAP_RTC_STATUS_POWER_UP        (1<<7)
+#define OMAP_RTC_STATUS_ALARM           (1<<6)
+#define OMAP_RTC_STATUS_1D_EVENT        (1<<5)
+#define OMAP_RTC_STATUS_1H_EVENT        (1<<4)
+#define OMAP_RTC_STATUS_1M_EVENT        (1<<3)
+#define OMAP_RTC_STATUS_1S_EVENT        (1<<2)
+#define OMAP_RTC_STATUS_RUN             (1<<1)
+#define OMAP_RTC_STATUS_BUSY            (1<<0)
+
+/* OMAP_RTC_INTERRUPTS_REG bit fields: */
+#define OMAP_RTC_INTERRUPTS_IT_ALARM    (1<<3)
+#define OMAP_RTC_INTERRUPTS_IT_TIMER    (1<<2)
+
+
+#define rtc_read(addr)		omap_readb(OMAP_RTC_BASE + (addr))
+#define rtc_write(val, addr)	omap_writeb(val, OMAP_RTC_BASE + (addr))
+
+
+/* platform_bus isn't hotpluggable, so for static linkage it'd be safe
+ * to get rid of probe() and remove() code ... too bad the driver struct
+ * remembers probe(), that's about 25% of the runtime footprint!!
+ */
+#ifndef	MODULE
+#undef	__devexit
+#undef	__devexit_p
+#define	__devexit	__exit
+#define	__devexit_p	__exit_p
+#endif
+
+
+/* we rely on the rtc framework to handle locking (rtc->ops_lock),
+ * so the only other requirement is that register accesses which
+ * require BUSY to be clear are made with IRQs locally disabled
+ */
+static void rtc_wait_not_busy(void)
+{
+	int	count = 0;
+	u8	status;
+
+	/* BUSY may stay active for 1/32768 second (~30 usec) */
+	for (count = 0; count < 50; count++) {
+		status = rtc_read(OMAP_RTC_STATUS_REG);
+		if ((status & (u8)OMAP_RTC_STATUS_BUSY) == 0)
+			break;
+		udelay(1);
+	}
+	/* now we have ~15 usec to read/write various registers */
+}
+
+static irqreturn_t rtc_irq(int irq, void *class_dev)
+{
+	unsigned long		events = 0;
+	u8			irq_data;
+
+	irq_data = rtc_read(OMAP_RTC_STATUS_REG);
+
+	/* alarm irq? */
+	if (irq_data & OMAP_RTC_STATUS_ALARM) {
+		rtc_write(OMAP_RTC_STATUS_ALARM, OMAP_RTC_STATUS_REG);
+		events |= RTC_IRQF | RTC_AF;
+	}
+
+	/* 1/sec periodic/update irq? */
+	if (irq_data & OMAP_RTC_STATUS_1S_EVENT)
+		events |= RTC_IRQF | RTC_UF;
+
+	rtc_update_irq(class_dev, 1, events);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef	CONFIG_RTC_INTF_DEV
+
+static int
+omap_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	u8 reg;
+
+	switch (cmd) {
+	case RTC_AIE_OFF:
+	case RTC_AIE_ON:
+	case RTC_UIE_OFF:
+	case RTC_UIE_ON:
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	local_irq_disable();
+	rtc_wait_not_busy();
+	reg = rtc_read(OMAP_RTC_INTERRUPTS_REG);
+	switch (cmd) {
+	/* AIE = Alarm Interrupt Enable */
+	case RTC_AIE_OFF:
+		reg &= ~OMAP_RTC_INTERRUPTS_IT_ALARM;
+		break;
+	case RTC_AIE_ON:
+		reg |= OMAP_RTC_INTERRUPTS_IT_ALARM;
+		break;
+	/* UIE = Update Interrupt Enable (1/second) */
+	case RTC_UIE_OFF:
+		reg &= ~OMAP_RTC_INTERRUPTS_IT_TIMER;
+		break;
+	case RTC_UIE_ON:
+		reg |= OMAP_RTC_INTERRUPTS_IT_TIMER;
+		break;
+	}
+	rtc_wait_not_busy();
+	rtc_write(reg, OMAP_RTC_INTERRUPTS_REG);
+	local_irq_enable();
+
+	return 0;
+}
+
+#else
+#define	omap_rtc_ioctl	NULL
+#endif
+
+/* this hardware doesn't support "don't care" alarm fields */
+static int tm2bcd(struct rtc_time *tm)
+{
+	if (rtc_valid_tm(tm) != 0)
+		return -EINVAL;
+
+	tm->tm_sec = BIN2BCD(tm->tm_sec);
+	tm->tm_min = BIN2BCD(tm->tm_min);
+	tm->tm_hour = BIN2BCD(tm->tm_hour);
+	tm->tm_mday = BIN2BCD(tm->tm_mday);
+
+	tm->tm_mon = BIN2BCD(tm->tm_mon + 1);
+
+	/* epoch == 1900 */
+	if (tm->tm_year < 100 || tm->tm_year > 199)
+		return -EINVAL;
+	tm->tm_year = BIN2BCD(tm->tm_year - 100);
+
+	return 0;
+}
+
+static void bcd2tm(struct rtc_time *tm)
+{
+	tm->tm_sec = BCD2BIN(tm->tm_sec);
+	tm->tm_min = BCD2BIN(tm->tm_min);
+	tm->tm_hour = BCD2BIN(tm->tm_hour);
+	tm->tm_mday = BCD2BIN(tm->tm_mday);
+	tm->tm_mon = BCD2BIN(tm->tm_mon) - 1;
+	/* epoch == 1900 */
+	tm->tm_year = BCD2BIN(tm->tm_year) + 100;
+}
+
+
+static int omap_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	/* we don't report wday/yday/isdst ... */
+	local_irq_disable();
+	rtc_wait_not_busy();
+
+	tm->tm_sec = rtc_read(OMAP_RTC_SECONDS_REG);
+	tm->tm_min = rtc_read(OMAP_RTC_MINUTES_REG);
+	tm->tm_hour = rtc_read(OMAP_RTC_HOURS_REG);
+	tm->tm_mday = rtc_read(OMAP_RTC_DAYS_REG);
+	tm->tm_mon = rtc_read(OMAP_RTC_MONTHS_REG);
+	tm->tm_year = rtc_read(OMAP_RTC_YEARS_REG);
+
+	local_irq_enable();
+
+	bcd2tm(tm);
+	return 0;
+}
+
+static int omap_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	if (tm2bcd(tm) < 0)
+		return -EINVAL;
+	local_irq_disable();
+	rtc_wait_not_busy();
+
+	rtc_write(tm->tm_year, OMAP_RTC_YEARS_REG);
+	rtc_write(tm->tm_mon, OMAP_RTC_MONTHS_REG);
+	rtc_write(tm->tm_mday, OMAP_RTC_DAYS_REG);
+	rtc_write(tm->tm_hour, OMAP_RTC_HOURS_REG);
+	rtc_write(tm->tm_min, OMAP_RTC_MINUTES_REG);
+	rtc_write(tm->tm_sec, OMAP_RTC_SECONDS_REG);
+
+	local_irq_enable();
+
+	return 0;
+}
+
+static int omap_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
+{
+	local_irq_disable();
+	rtc_wait_not_busy();
+
+	alm->time.tm_sec = rtc_read(OMAP_RTC_ALARM_SECONDS_REG);
+	alm->time.tm_min = rtc_read(OMAP_RTC_ALARM_MINUTES_REG);
+	alm->time.tm_hour = rtc_read(OMAP_RTC_ALARM_HOURS_REG);
+	alm->time.tm_mday = rtc_read(OMAP_RTC_ALARM_DAYS_REG);
+	alm->time.tm_mon = rtc_read(OMAP_RTC_ALARM_MONTHS_REG);
+	alm->time.tm_year = rtc_read(OMAP_RTC_ALARM_YEARS_REG);
+
+	local_irq_enable();
+
+	bcd2tm(&alm->time);
+	alm->pending = !!(rtc_read(OMAP_RTC_INTERRUPTS_REG)
+			& OMAP_RTC_INTERRUPTS_IT_ALARM);
+	alm->enabled = alm->pending && device_may_wakeup(dev);
+
+	return 0;
+}
+
+static int omap_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
+{
+	u8 reg;
+
+	/* Much userspace code uses RTC_ALM_SET, thus "don't care" for
+	 * day/month/year specifies alarms up to 24 hours in the future.
+	 * So we need to handle that ... but let's ignore the "don't care"
+	 * values for hours/minutes/seconds.
+	 */
+	if (alm->time.tm_mday <= 0
+			&& alm->time.tm_mon < 0
+			&& alm->time.tm_year < 0) {
+		struct rtc_time tm;
+		unsigned long now, then;
+
+		omap_rtc_read_time(dev, &tm);
+		rtc_tm_to_time(&tm, &now);
+
+		alm->time.tm_mday = tm.tm_mday;
+		alm->time.tm_mon = tm.tm_mon;
+		alm->time.tm_year = tm.tm_year;
+		rtc_tm_to_time(&alm->time, &then);
+
+		/* sometimes the alarm wraps into tomorrow */
+		if (then < now) {
+			rtc_time_to_tm(now + 24 * 60 * 60, &tm);
+			alm->time.tm_mday = tm.tm_mday;
+			alm->time.tm_mon = tm.tm_mon;
+			alm->time.tm_year = tm.tm_year;
+		}
+	}
+
+	if (tm2bcd(&alm->time) < 0)
+		return -EINVAL;
+
+	local_irq_disable();
+	rtc_wait_not_busy();
+
+	rtc_write(alm->time.tm_year, OMAP_RTC_ALARM_YEARS_REG);
+	rtc_write(alm->time.tm_mon, OMAP_RTC_ALARM_MONTHS_REG);
+	rtc_write(alm->time.tm_mday, OMAP_RTC_ALARM_DAYS_REG);
+	rtc_write(alm->time.tm_hour, OMAP_RTC_ALARM_HOURS_REG);
+	rtc_write(alm->time.tm_min, OMAP_RTC_ALARM_MINUTES_REG);
+	rtc_write(alm->time.tm_sec, OMAP_RTC_ALARM_SECONDS_REG);
+
+	reg = rtc_read(OMAP_RTC_INTERRUPTS_REG);
+	if (alm->enabled)
+		reg |= OMAP_RTC_INTERRUPTS_IT_ALARM;
+	else
+		reg &= ~OMAP_RTC_INTERRUPTS_IT_ALARM;
+	rtc_write(reg, OMAP_RTC_INTERRUPTS_REG);
+
+	local_irq_enable();
+
+	return 0;
+}
+
+static struct rtc_class_ops omap_rtc_ops = {
+	.ioctl		= omap_rtc_ioctl,
+	.read_time	= omap_rtc_read_time,
+	.set_time	= omap_rtc_set_time,
+	.read_alarm	= omap_rtc_read_alarm,
+	.set_alarm	= omap_rtc_set_alarm,
+};
+
+static int omap_rtc_alarm;
+static int omap_rtc_timer;
+
+static int __devinit omap_rtc_probe(struct platform_device *pdev)
+{
+	struct resource		*res, *mem;
+	struct rtc_device	*rtc;
+	u8			reg, new_ctrl;
+
+	omap_rtc_timer = platform_get_irq(pdev, 0);
+	if (omap_rtc_timer <= 0) {
+		pr_debug("%s: no update irq?\n", pdev->name);
+		return -ENOENT;
+	}
+
+	omap_rtc_alarm = platform_get_irq(pdev, 1);
+	if (omap_rtc_alarm <= 0) {
+		pr_debug("%s: no alarm irq?\n", pdev->name);
+		return -ENOENT;
+	}
+
+	/* NOTE:  using static mapping for RTC registers */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res && res->start != OMAP_RTC_BASE) {
+		pr_debug("%s: RTC registers at %08x, expected %08x\n",
+			pdev->name, (unsigned) res->start, OMAP_RTC_BASE);
+		return -ENOENT;
+	}
+
+	if (res)
+		mem = request_mem_region(res->start,
+				res->end - res->start + 1,
+				pdev->name);
+	else
+		mem = NULL;
+	if (!mem) {
+		pr_debug("%s: RTC registers at %08x are not free\n",
+			pdev->name, OMAP_RTC_BASE);
+		return -EBUSY;
+	}
+
+	rtc = rtc_device_register(pdev->name, &pdev->dev,
+			&omap_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc)) {
+		pr_debug("%s: can't register RTC device, err %ld\n",
+			pdev->name, PTR_ERR(rtc));
+		goto fail;
+	}
+	platform_set_drvdata(pdev, rtc);
+	class_set_devdata(&rtc->class_dev, mem);
+
+	/* clear pending irqs, and set 1/second periodic,
+	 * which we'll use instead of update irqs
+	 */
+	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
+
+	/* clear old status */
+	reg = rtc_read(OMAP_RTC_STATUS_REG);
+	if (reg & (u8) OMAP_RTC_STATUS_POWER_UP) {
+		pr_info("%s: RTC power up reset detected\n",
+			pdev->name);
+		rtc_write(OMAP_RTC_STATUS_POWER_UP, OMAP_RTC_STATUS_REG);
+	}
+	if (reg & (u8) OMAP_RTC_STATUS_ALARM)
+		rtc_write(OMAP_RTC_STATUS_ALARM, OMAP_RTC_STATUS_REG);
+
+	/* handle periodic and alarm irqs */
+	if (request_irq(omap_rtc_timer, rtc_irq, SA_INTERRUPT,
+			rtc->class_dev.class_id, &rtc->class_dev)) {
+		pr_debug("%s: RTC timer interrupt IRQ%d already claimed\n",
+			pdev->name, omap_rtc_timer);
+		goto fail0;
+	}
+	if (request_irq(omap_rtc_alarm, rtc_irq, SA_INTERRUPT,
+			rtc->class_dev.class_id, &rtc->class_dev)) {
+		pr_debug("%s: RTC alarm interrupt IRQ%d already claimed\n",
+			pdev->name, omap_rtc_alarm);
+		goto fail1;
+	}
+
+	/* On boards with split power, RTC_ON_NOFF won't reset the RTC */
+	reg = rtc_read(OMAP_RTC_CTRL_REG);
+	if (reg & (u8) OMAP_RTC_CTRL_STOP)
+		pr_info("%s: already running\n", pdev->name);
+
+	/* force to 24 hour mode */
+	new_ctrl = reg & ~(OMAP_RTC_CTRL_SPLIT|OMAP_RTC_CTRL_AUTO_COMP);
+	new_ctrl |= OMAP_RTC_CTRL_STOP;
+
+	/* BOARD-SPECIFIC CUSTOMIZATION CAN GO HERE:
+	 *
+	 *  - Boards wired so that RTC_WAKE_INT does something, and muxed
+	 *    right (W13_1610_RTC_WAKE_INT is the default after chip reset),
+	 *    should initialize the device wakeup flag appropriately.
+	 *
+	 *  - Boards wired so RTC_ON_nOFF is used as the reset signal,
+	 *    rather than nPWRON_RESET, should forcibly enable split
+	 *    power mode.  (Some chip errata report that RTC_CTRL_SPLIT
+	 *    is write-only, and always reads as zero...)
+	 */
+	device_init_wakeup(&pdev->dev, 0);
+
+	if (new_ctrl & (u8) OMAP_RTC_CTRL_SPLIT)
+		pr_info("%s: split power mode\n", pdev->name);
+
+	if (reg != new_ctrl)
+		rtc_write(new_ctrl, OMAP_RTC_CTRL_REG);
+
+	return 0;
+
+fail1:
+	free_irq(omap_rtc_timer, NULL);
+fail0:
+	rtc_device_unregister(rtc);
+fail:
+	release_resource(mem);
+	return -EIO;
+}
+
+static int __devexit omap_rtc_remove(struct platform_device *pdev)
+{
+	struct rtc_device	*rtc = platform_get_drvdata(pdev);;
+
+	device_init_wakeup(&pdev->dev, 0);
+
+	/* leave rtc running, but disable irqs */
+	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
+
+	free_irq(omap_rtc_timer, rtc);
+	free_irq(omap_rtc_alarm, rtc);
+
+	release_resource(class_get_devdata(&rtc->class_dev));
+	rtc_device_unregister(rtc);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+
+static struct timespec rtc_delta;
+static u8 irqstat;
+
+static int omap_rtc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct rtc_time rtc_tm;
+	struct timespec time;
+
+	time.tv_nsec = 0;
+	omap_rtc_read_time(NULL, &rtc_tm);
+	rtc_tm_to_time(&rtc_tm, &time.tv_sec);
+
+	save_time_delta(&rtc_delta, &time);
+	irqstat = rtc_read(OMAP_RTC_INTERRUPTS_REG);
+
+	/* FIXME the RTC alarm is not currently acting as a wakeup event
+	 * source, and in fact this enable() call is just saving a flag
+	 * that's never used...
+	 */
+	if (device_may_wakeup(&pdev->dev))
+		enable_irq_wake(omap_rtc_alarm);
+	else
+		rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
+
+	return 0;
+}
+
+static int omap_rtc_resume(struct platform_device *pdev)
+{
+	struct rtc_time rtc_tm;
+	struct timespec time;
+
+	time.tv_nsec = 0;
+	omap_rtc_read_time(NULL, &rtc_tm);
+	rtc_tm_to_time(&rtc_tm, &time.tv_sec);
+
+	restore_time_delta(&rtc_delta, &time);
+	if (device_may_wakeup(&pdev->dev))
+		disable_irq_wake(omap_rtc_alarm);
+	else
+		rtc_write(irqstat, OMAP_RTC_INTERRUPTS_REG);
+	return 0;
+}
+
+#else
+#define omap_rtc_suspend NULL
+#define omap_rtc_resume  NULL
+#endif
+
+static void omap_rtc_shutdown(struct platform_device *pdev)
+{
+	rtc_write(0, OMAP_RTC_INTERRUPTS_REG);
+}
+
+MODULE_ALIAS("omap_rtc");
+static struct platform_driver omap_rtc_driver = {
+	.probe		= omap_rtc_probe,
+	.remove		= __devexit_p(omap_rtc_remove),
+	.suspend	= omap_rtc_suspend,
+	.resume		= omap_rtc_resume,
+	.shutdown	= omap_rtc_shutdown,
+	.driver		= {
+		.name	= "omap_rtc",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init rtc_init(void)
+{
+	return platform_driver_register(&omap_rtc_driver);
+}
+module_init(rtc_init);
+
+static void __exit rtc_exit(void)
+{
+	platform_driver_unregister(&omap_rtc_driver);
+}
+module_exit(rtc_exit);
+
+MODULE_AUTHOR("George G. Davis (and others)");
+MODULE_LICENSE("GPL");
