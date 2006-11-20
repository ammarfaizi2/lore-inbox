Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966842AbWKTWRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966842AbWKTWRz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965862AbWKTWRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:17:32 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:44886 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966842AbWKTWPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:15:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=QNOlUXVGY2Bp5Mx2PifLoh4HlGTmsNjrhfGJmhNkztIf7txUhf5HFa03iS+irVD6du/+GKUB2pBQGAuAZx4U1gWXD7DsJxIu6hO998fkw/FItVZpLrYR0MFwhaiiGMJUvgTfwVbhLjtz4UQf0a50SWuQl2I64GrXQdkI0OFWSKk=  ;
X-YMail-OSG: 8iuz.IMVM1m1GxcuvNw.Im3uHNqBnV1UnZmtwMdcmQqEu3H5KSOqloeoGfM0N1nKwtMd0.F5lpLT6KYemOHMnVYtHyD9ykZfZWII8gjKC7jY7azdefTmmQ--
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: [patch 2.6.19-rc6 5/6] rtc-cmos driver
Date: Mon, 20 Nov 2006 10:27:16 -0800
User-Agent: KMail/1.7.1
Cc: "Brown, Len" <len.brown@intel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <200611201014.41980.david-b@pacbell.net>
In-Reply-To: <200611201014.41980.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611201027.17034.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a "new RTC framework" driver for the "CMOS" RTCs which are standard
on PCs and some other platforms.  That's an MC146818, or compatibles like
the ones in most south bridges, the M48T86 and DS12887, etc.  Advantages of
this vs. drivers/char/rtc.c (use one _or_ the other) include:

 - This leverages both the new RTC framework and the driver model;
   both PNPACPI and platform device modes are supported.

 - It supports ACPI extensions like longer alarms.

 - Likewise, system wakeup events use "real driver model support", with
   policy control via sysfs "wakeup" attributes and and using normal rtc
   ioctls to manage wakeup.
   
 - Obsoletes and removes the acpi-only /proc/acpi/alarm interface.

Disadvantages include no testing on non-x86 systems, or with HPET; and
issues associated with newness of this code and the relatively limited
use of the RTC framework (i.e. primarily on embedded Linuxes, not PCs). 

Significant changes since last version:  handles periodic irqs, given
the rtc core patch for RTC_IRQP_{GET,SET}; renamed as rtc-cmos; better
platform device support; cares less about ACPI; passes "rtctest".

Issues of note:

 - Some tools like "hwclock" expect /dev/rtc not /dev/rtc0; upcoming
   util-linux and busybox versions should resolve this.

 - ACPI wakeup doesn't always work ... this is not specific to RTC,
   but it's worth remembering.  (Or fixing, please!, if you can.)

 - The ALSA sound/core/rtctimer.c doesn't understand the new RTC API,
   or the fact that not every RTC can generate 1K/sec IRQs.

This version seems generally usable, though it may need tweaks yet.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/rtc/Kconfig
===================================================================
--- g26.orig/drivers/rtc/Kconfig	2006-11-20 10:03:06.000000000 -0800
+++ g26/drivers/rtc/Kconfig	2006-11-20 10:10:47.000000000 -0800
@@ -95,6 +95,25 @@ config RTC_INTF_DEV_UIE_EMUL
 comment "RTC drivers"
 	depends on RTC_CLASS
 
+config RTC_DRV_CMOS
+	tristate "CMOS real time clock"
+	depends on RTC_CLASS && (X86_PC || ACPI)
+	help
+	  Say "yes" here to get direct support for the real time clock
+	  found in every PC or ACPI-based system, and some others.
+	  Specifically the original MC146818, or compatibles like those
+	  in PC south bridges, the DS12887 or M48T86, and so on.
+
+	  This RTC can be used to wake most systems from suspend-to-RAM or
+	  standby sleep modes, and on some systems from suspend-to-disk.
+	  (Any PC predating the 1995 introduction of ATX power supplies
+	  probably can't be woken up by its RTC.)
+
+	  This obsoletes the old /proc/acpi/alarm interface.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-cmos.
+
 config RTC_DRV_X1205
 	tristate "Xicor/Intersil X1205"
 	depends on RTC_CLASS && I2C
Index: g26/drivers/rtc/Makefile
===================================================================
--- g26.orig/drivers/rtc/Makefile	2006-11-20 10:03:06.000000000 -0800
+++ g26/drivers/rtc/Makefile	2006-11-20 10:10:47.000000000 -0800
@@ -15,6 +15,7 @@ obj-$(CONFIG_RTC_INTF_SYSFS)	+= rtc-sysf
 obj-$(CONFIG_RTC_INTF_PROC)	+= rtc-proc.o
 obj-$(CONFIG_RTC_INTF_DEV)	+= rtc-dev.o
 
+obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc-cmos.o
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
 obj-$(CONFIG_RTC_DRV_ISL1208)	+= rtc-isl1208.o
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
Index: g26/drivers/rtc/rtc-cmos.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/drivers/rtc/rtc-cmos.c	2006-11-20 10:10:47.000000000 -0800
@@ -0,0 +1,738 @@
+/*
+ * RTC class driver for "CMOS RTC":  PCs, ACPI, etc
+ *
+ * Copyright (C) 1996 Paul Gortmaker (drivers/char/rtc.c)
+ * Copyright (C) 2006 David Brownell (convert to new framework)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/*
+ * The original "cmos clock" chip was an MC146818 chip, now obsolete.
+ * That defined the register interface now provided by all PCs, some
+ * non-PC systems, and incorporated into ACPI.  Modern PC chipsets
+ * integrate an MC146818 clone in their southbridge, and boards use
+ * that instead of discrete clones like the DS12887 or M48T86.  There
+ * are also clones that connect using the LPC bus.
+ *
+ * That register API is also used directly by various other drivers,
+ * (notably for integrated NVRAM), infrastructure (x86 has code to
+ * bypass the RTC framework, directly reading the RTC during boot
+ * and updating minutes/seconds for systems using NTP synch) and
+ * utilities (like userspace 'hwclock', if no /dev node exists).
+ *
+ * So **ALL** calls to CMOS_READ and CMOS_WRITE must be done with
+ * interrupts disabled, holding the global rtc_lock, to exclude those
+ * other drivers and utilities on correctly configured systems.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
+
+#include <acpi/acpi.h>
+#include <asm/rtc.h>
+
+
+struct cmos_rtc {
+	struct rtc_device	*rtc;
+	struct device		*dev;
+	int			irq;
+	struct resource		*iomem;
+	u8			acpi;
+
+	/* newer hardware extends the original register set */
+	u8			day_alrm;
+	u8			mon_alrm;
+	u8			century;
+};
+
+#ifdef	CONFIG_ACPI_SLEEP
+#define	use_acpi_wake(cmos)	((cmos)->acpi)
+#else
+#define	use_acpi_wake(cmos)	0
+#endif
+
+/* both platform and pnp busses use negative numbers for invalid irqs */
+#define is_valid_irq(n)		((n) >= 0)
+
+static const char driver_name[] = "rtc_cmos";
+
+/*----------------------------------------------------------------*/
+
+static int cmos_read_time(struct device *dev, struct rtc_time *t)
+{
+	/* REVISIT:  if the clock has a "century" register, use
+	 * that instead of the heuristic in get_rtc_time().
+	 * That'll make Y3K compatility (year > 2070) easy!
+	 */
+	get_rtc_time(t);
+	return 0;
+}
+
+static int cmos_set_time(struct device *dev, struct rtc_time *t)
+{
+	/* REVISIT:  set the "century" register if available
+	 *
+	 * NOTE: this ignores the issue whereby updating the seconds
+	 * takes effect exactly 500ms after we write the register.
+	 * (Also queueing and other delays before we get this far.)
+	 */
+	return set_rtc_time(t);
+}
+
+static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
+	unsigned char	rtc_control;
+
+	if (!is_valid_irq(cmos->irq))
+		return -EIO;
+
+	/* Basic alarms only support hour, minute, and seconds fields.
+	 * Some also support day and month, for alarms up to a year in
+	 * the future.
+	 */
+	t->time.tm_mday = -1;
+	t->time.tm_mon = -1;
+
+	spin_lock_irq(&rtc_lock);
+	t->time.tm_sec = CMOS_READ(RTC_SECONDS_ALARM);
+	t->time.tm_min = CMOS_READ(RTC_MINUTES_ALARM);
+	t->time.tm_hour = CMOS_READ(RTC_HOURS_ALARM);
+
+	if (cmos->day_alrm) {
+		t->time.tm_mday = CMOS_READ(cmos->day_alrm);
+		if (!t->time.tm_mday)
+			t->time.tm_mday = -1;
+
+		if (cmos->mon_alrm) {
+			t->time.tm_mon = CMOS_READ(cmos->mon_alrm);
+			if (!t->time.tm_mon)
+				t->time.tm_mon = -1;
+		}
+	}
+
+	rtc_control = CMOS_READ(RTC_CONTROL);
+	spin_unlock_irq(&rtc_lock);
+
+	/* REVISIT this assumes PC style usage:  always BCD */
+
+	if (((unsigned)t->time.tm_sec) < 0x60)
+		t->time.tm_sec = BCD2BIN(t->time.tm_sec);
+	else
+		t->time.tm_sec = -1;
+	if (((unsigned)t->time.tm_min) < 0x60)
+		t->time.tm_min = BCD2BIN(t->time.tm_min);
+	else
+		t->time.tm_min = -1;
+	if (((unsigned)t->time.tm_hour) < 0x24)
+		t->time.tm_hour = BCD2BIN(t->time.tm_hour);
+	else
+		t->time.tm_hour = -1;
+
+	if (cmos->day_alrm) {
+		if (((unsigned)t->time.tm_mday) <= 0x31)
+			t->time.tm_mday = BCD2BIN(t->time.tm_mday);
+		else
+			t->time.tm_mday = -1;
+		if (cmos->mon_alrm) {
+			if (((unsigned)t->time.tm_mon) <= 0x12)
+				t->time.tm_mon = BCD2BIN(t->time.tm_mon) - 1;
+			else
+				t->time.tm_mon = -1;
+		}
+	}
+	t->time.tm_year = -1;
+
+	t->enabled = !!(rtc_control & RTC_AIE);
+	t->pending = 0;
+
+	return 0;
+}
+
+static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
+	unsigned char	mon, mday, hrs, min, sec;
+	unsigned char	rtc_control, rtc_intr;
+
+	if (!is_valid_irq(cmos->irq))
+		return -EIO;
+
+	/* REVISIT this assumes PC style usage:  always BCD */
+
+	/* Writing 0xff means "don't care" or "match all".  */
+
+	mon = t->time.tm_mon;
+	mon = (mon < 12) ? BIN2BCD(mon) : 0xff;
+	mon++;
+
+	mday = t->time.tm_mday;
+	mday = (mday >= 1 && mday <= 31) ? BIN2BCD(mday) : 0xff;
+
+	hrs = t->time.tm_hour;
+	hrs = (hrs < 24) ? BIN2BCD(hrs) : 0xff;
+
+	min = t->time.tm_min;
+	min = (min < 60) ? BIN2BCD(min) : 0xff;
+
+	sec = t->time.tm_sec;
+	sec = (sec < 60) ? BIN2BCD(sec) : 0xff;
+
+	/* scrub old acpi state */
+	if (use_acpi_wake(cmos)) {
+		acpi_disable_event(ACPI_EVENT_RTC, 0);
+		acpi_clear_event(ACPI_EVENT_RTC);
+	}
+
+	spin_lock_irq(&rtc_lock);
+
+	/* next rtc irq must not be from previous alarm setting */
+	rtc_control = CMOS_READ(RTC_CONTROL);
+	rtc_control &= ~RTC_AIE;
+	CMOS_WRITE(rtc_control, RTC_CONTROL);
+	rtc_intr = CMOS_READ(RTC_INTR_FLAGS);
+	if (rtc_intr)
+		rtc_update_irq(&cmos->rtc->class_dev, 1, rtc_intr);
+
+	/* update alarm */
+	CMOS_WRITE(hrs, RTC_HOURS_ALARM);
+	CMOS_WRITE(min, RTC_MINUTES_ALARM);
+	CMOS_WRITE(sec, RTC_SECONDS_ALARM);
+
+	/* the system may support an "enhanced" alarm */
+	if (cmos->day_alrm) {
+		CMOS_WRITE(mday, cmos->day_alrm);
+		if (cmos->mon_alrm)
+			CMOS_WRITE(mon, cmos->mon_alrm);
+	}
+
+	if (t->enabled) {
+		rtc_control |= RTC_AIE;
+		CMOS_WRITE(rtc_control, RTC_CONTROL);
+		rtc_intr = CMOS_READ(RTC_INTR_FLAGS);
+		if (rtc_intr)
+			rtc_update_irq(&cmos->rtc->class_dev, 1, rtc_intr);
+	}
+
+	spin_unlock_irq(&rtc_lock);
+
+#ifdef	DEBUG
+/* REVISIT ... does this ACPI event mechanism behave?
+ * I've never observed it to work correctly, on any system...
+ * we'd prefer to call this with the lock held, avoiding a race.
+ */
+	if (use_acpi_wake(cmos)) {
+		acpi_enable_event(ACPI_EVENT_RTC, 0);
+	}
+#endif
+
+	return 0;
+}
+
+static int cmos_set_freq(struct device *dev, int freq)
+{
+	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
+	int		f;
+	unsigned long	flags;
+
+	if (!is_valid_irq(cmos->irq))
+		return -ENXIO;
+
+	/* 0 = no irqs; 1 = 2^15 Hz ... 15 = 2^0 Hz */
+	f = ffs(freq);
+	if (f != 0) {
+		if (f-- > 16 || freq != (1 << f))
+			return -EINVAL;
+		f = 16 - f;
+	}
+
+	spin_lock_irqsave(&rtc_lock, flags);
+	CMOS_WRITE(RTC_REF_CLCK_32KHZ | f, RTC_FREQ_SELECT);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+
+	return 0;
+}
+
+#if defined(CONFIG_RTC_INTF_DEV) || defined(CONFIG_RTC_INTF_DEV_MODULE)
+
+static int
+cmos_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
+	unsigned char	rtc_control, rtc_intr;
+	unsigned long	flags;
+
+	switch (cmd) {
+	case RTC_AIE_OFF:
+	case RTC_AIE_ON:
+	case RTC_UIE_OFF:
+	case RTC_UIE_ON:
+	case RTC_PIE_OFF:
+	case RTC_PIE_ON:
+		if (!is_valid_irq(cmos->irq))
+			return -EINVAL;
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	spin_lock_irqsave(&rtc_lock, flags);
+	rtc_control = CMOS_READ(RTC_CONTROL);
+	switch (cmd) {
+	case RTC_AIE_OFF:	/* alarm off */
+		rtc_control &= ~RTC_AIE;
+		break;
+	case RTC_AIE_ON:	/* alarm on */
+		rtc_control |= RTC_AIE;
+		break;
+	case RTC_UIE_OFF:	/* update off */
+		rtc_control &= ~RTC_UIE;
+		break;
+	case RTC_UIE_ON:	/* update on */
+		rtc_control |= RTC_UIE;
+		break;
+	case RTC_PIE_OFF:	/* periodic off */
+		rtc_control &= ~RTC_PIE;
+		break;
+	case RTC_PIE_ON:	/* periodic on */
+		rtc_control |= RTC_PIE;
+		break;
+	}
+	CMOS_WRITE(rtc_control, RTC_CONTROL);
+	rtc_intr = CMOS_READ(RTC_INTR_FLAGS);
+	if (rtc_intr)
+		rtc_update_irq(&cmos->rtc->class_dev, 1, rtc_intr);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	return 0;
+}
+
+#else
+#define	cmos_rtc_ioctl	NULL
+#endif
+
+#if defined(CONFIG_RTC_INTF_PROC) || defined(CONFIG_RTC_INTF_PROC_MODULE)
+
+static int cmos_procfs(struct device *dev, struct seq_file *seq)
+{
+	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
+	unsigned char	rtc_control, valid;
+
+	spin_lock_irq(&rtc_lock);
+	rtc_control = CMOS_READ(RTC_CONTROL);
+	valid = CMOS_READ(RTC_VALID);
+	spin_unlock_irq(&rtc_lock);
+
+	return seq_printf(seq,
+			"periodic_IRQ\t: %s\n"
+			"update_IRQ\t: %s\n"
+			// "square_wave\t: %s\n"
+			// "BCD\t\t: %s\n"
+			"DST_enable\t: %s\n"
+			"periodic_freq\t: %d\n"
+			"batt_status\t: %s\n",
+			(rtc_control & RTC_PIE) ? "yes" : "no",
+			(rtc_control & RTC_UIE) ? "yes" : "no",
+			// (rtc_control & RTC_SQWE) ? "yes" : "no",
+			// (rtc_control & RTC_DM_BINARY) ? "no" : "yes",
+			(rtc_control & RTC_DST_EN) ? "yes" : "no",
+			cmos->rtc->irq_freq,
+			(valid & RTC_VRT) ? "okay" : "dead");
+}
+
+#else
+#define	cmos_procfs	NULL
+#endif
+
+static const struct rtc_class_ops cmos_rtc_ops = {
+	.ioctl		= cmos_rtc_ioctl,
+	.read_time	= cmos_read_time,
+	.set_time	= cmos_set_time,
+	.read_alarm	= cmos_read_alarm,
+	.set_alarm	= cmos_set_alarm,
+	.proc		= cmos_procfs,
+	.irq_set_freq	= cmos_set_freq,
+};
+
+/*----------------------------------------------------------------*/
+
+static struct cmos_rtc	cmos_rtc;
+
+static irqreturn_t cmos_interrupt(int irq, void *p)
+{
+	u8		irqstat;
+
+	spin_lock(&rtc_lock);
+	irqstat = CMOS_READ(RTC_INTR_FLAGS);
+	spin_unlock(&rtc_lock);
+
+	if (irqstat) {
+		/* NOTE: irqstat may have e.g. RTC_PF set
+		 * even when RTC_PIE is clear...
+		 */
+		rtc_update_irq(p, 1, irqstat);
+		return IRQ_HANDLED;
+	} else
+		return IRQ_NONE;
+}
+
+#ifdef	CONFIG_PM
+
+static u32 cmos_acpi_handler(void *p)
+{
+	acpi_clear_event(ACPI_EVENT_RTC);
+	acpi_disable_event(ACPI_EVENT_RTC, 0);
+
+	/* REVISIT doesn't seem like acpi events work ... */
+
+printk("%s\n", __FUNCTION__);
+
+	// call this with irqs blocked:
+	// rtc_update_irq(p, 1, RTC_IRQF | RTC_AF);
+
+	return ACPI_INTERRUPT_HANDLED;
+}
+
+#endif
+
+#ifdef	CONFIG_PNPACPI
+#define	is_pnpacpi()	1
+#else
+#define	is_pnpacpi()	0
+#endif
+
+static int __devinit
+cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
+{
+	struct cmos_rtc_board_info	*info = dev->platform_data;
+	int				retval = 0;
+	unsigned char			rtc_control;
+	int				wake_std = 0;
+
+	/* there can be only one ... */
+	if (cmos_rtc.dev)
+		return -EBUSY;
+
+	if (!ports)
+		return -ENODEV;
+
+	cmos_rtc.irq = rtc_irq;
+	cmos_rtc.iomem = ports;
+
+	if (info) {
+		/* REVISIT this driver should not care about ACPI.
+		 * The ACPI alarms never seem to fire, anyway...
+		 */
+		cmos_rtc.acpi = 1;
+
+		cmos_rtc.day_alrm = info->rtc_day_alarm;
+		cmos_rtc.mon_alrm = info->rtc_mon_alarm;
+		cmos_rtc.century = info->rtc_century;
+		wake_std = info->wake_from_std;
+	}
+
+	cmos_rtc.rtc = rtc_device_register(driver_name, dev,
+				&cmos_rtc_ops, THIS_MODULE);
+	if (IS_ERR(cmos_rtc.rtc))
+		return PTR_ERR(cmos_rtc.rtc);
+
+	cmos_rtc.dev = dev;
+	dev_set_drvdata(dev, &cmos_rtc);
+
+	/* platform and pnp busses handle resources incompatibly.
+	 *
+	 * REVISIT for non-x86 systems we may need to handle io memory
+	 * resources: ioremap them, and request_mem_region().
+	 */
+	if (is_pnpacpi()) {
+		retval = request_resource(&ioport_resource, ports);
+		if (retval < 0) {
+			dev_dbg(dev, "i/o registers already in use\n");
+			goto cleanup0;
+		}
+	}
+	rename_region(ports, cmos_rtc.rtc->class_dev.class_id);
+
+	spin_lock_irq(&rtc_lock);
+
+	/* force periodic irq to CMOS reset default of 1024Hz;
+	 *
+	 * REVISIT it's been reported that at least one x86_64 ALI mobo
+	 * doesn't use 32KHz here ... for portability we might need to
+	 * do something about other clock frequencies.
+	 */
+	CMOS_WRITE(RTC_REF_CLCK_32KHZ | 0x06, RTC_FREQ_SELECT);
+	cmos_rtc.rtc->irq_freq = 1024;
+
+	/* disable irqs.
+	 *
+	 * NOTE after changing RTC_xIE bits we always read INTR_FLAGS;
+	 * allegedly some older rtcs need that to handle irqs properly
+	 */
+	rtc_control = CMOS_READ(RTC_CONTROL);
+	rtc_control &= ~(RTC_PIE | RTC_AIE | RTC_UIE);
+	CMOS_WRITE(rtc_control, RTC_CONTROL);
+	CMOS_READ(RTC_INTR_FLAGS);
+
+	spin_unlock_irq(&rtc_lock);
+
+	/* FIXME teach the alarm code how to handle binary mode;
+	 * <asm-generic/rtc.h> doesn't know 12-hour mode either.
+	 */
+	if (!(rtc_control & RTC_24H) || (rtc_control & (RTC_DM_BINARY))) {
+		dev_dbg(dev, "only 24-hr BCD mode supported\n");
+		retval = -ENXIO;
+		goto cleanup1;
+	}
+
+	if (is_valid_irq(rtc_irq))
+		retval = request_irq(rtc_irq, cmos_interrupt, IRQF_DISABLED,
+				cmos_rtc.rtc->class_dev.class_id,
+				&cmos_rtc.rtc->class_dev);
+	if (retval < 0) {
+		dev_dbg(dev, "IRQ %d is already in use\n", rtc_irq);
+		goto cleanup1;
+	}
+
+	pr_info("%s: %s, %s alarm%s%s\n",
+			cmos_rtc.rtc->class_dev.class_id,
+			dev->driver->name,
+			is_valid_irq(rtc_irq)
+				?  (cmos_rtc.mon_alrm
+					? "year"
+					: (cmos_rtc.day_alrm
+						? "month" : "day"))
+				: "no",
+			wake_std ? ", wake from STD" : "",
+			cmos_rtc.century ? ", y3k" : ""
+			);
+
+	if (use_acpi_wake(&cmos_rtc)) {
+		acpi_install_fixed_event_handler(ACPI_EVENT_RTC,
+				cmos_acpi_handler, &cmos_rtc.rtc->class_dev);
+		acpi_disable_event(ACPI_EVENT_RTC, 0);
+	}
+
+	return 0;
+
+cleanup1:
+	rename_region(ports, NULL);
+cleanup0:
+	rtc_device_unregister(cmos_rtc.rtc);
+	return retval;
+}
+
+static void cmos_do_shutdown(void)
+{
+	unsigned char	rtc_control;
+
+	spin_lock_irq(&rtc_lock);
+	rtc_control = CMOS_READ(RTC_CONTROL);
+	rtc_control &= ~(RTC_PIE|RTC_AIE|RTC_UIE);
+	CMOS_WRITE(rtc_control, RTC_CONTROL);
+	CMOS_READ(RTC_INTR_FLAGS);
+	spin_unlock_irq(&rtc_lock);
+}
+
+static void __devexit cmos_do_remove(struct device *dev)
+{
+	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
+
+	cmos_do_shutdown();
+
+	if (use_acpi_wake(cmos)) {
+		acpi_disable_event(ACPI_EVENT_RTC, 0);
+		acpi_remove_fixed_event_handler(ACPI_EVENT_RTC,
+				cmos_acpi_handler);
+	}
+
+	if (dev->bus != &platform_bus_type)
+		release_resource(cmos->iomem);
+	rename_region(cmos->iomem, NULL);
+
+	if (is_valid_irq(cmos->irq))
+		free_irq(cmos->irq, &cmos_rtc.rtc->class_dev);
+
+	rtc_device_unregister(cmos_rtc.rtc);
+
+	cmos_rtc.dev = NULL;
+	dev_set_drvdata(dev, NULL);
+}
+
+#ifdef	CONFIG_PM
+
+static int cmos_suspend(struct device *dev, pm_message_t mesg)
+{
+	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
+	int		do_wake = cmos->acpi && device_may_wakeup(dev);
+
+	/* force RTC_EN value during system sleep states */
+	if (use_acpi_wake(cmos)) {
+		if (do_wake)
+			acpi_enable_event(ACPI_EVENT_RTC, 0);
+		else
+			acpi_disable_event(ACPI_EVENT_RTC, 0);
+	}
+
+pr_debug("%s, EVENT_RTC %sabled\n", __FUNCTION__, do_wake ? "en" : "dis");
+
+	return 0;
+}
+
+static int cmos_resume(struct device *dev)
+{
+	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
+
+	/* REVISIT:  the mechanism to resync jiffies on resume
+	 * should be portable between platforms ...
+	 */
+
+pr_debug("%s\n", __FUNCTION__);
+
+	if (use_acpi_wake(cmos))
+		acpi_disable_event(ACPI_EVENT_RTC, 0);
+
+	return 0;
+}
+
+#else
+#define	cmos_suspend	NULL
+#define	cmos_resume	NULL
+#endif
+
+/*----------------------------------------------------------------*/
+
+/* On ACPI systems, the device node may be created as either a PNP
+ * device or a platform_device.  In either case the FADT data should
+ * have been transferred to us through platform_data.
+ */
+
+#ifdef	CONFIG_PNPACPI
+
+#include <linux/pnp.h>
+
+static int __devinit
+cmos_pnp_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
+{
+	/* REVISIT paranoia argues for a shutdown notifier, since PNP
+	 * drivers can't provide shutdown() methods to disable IRQs.
+	 * Or better yet, fix PNP to allow those methods...
+	 */
+	return cmos_do_probe(&pnp->dev,
+			&pnp->res.port_resource[0],
+			pnp->res.irq_resource[0].start);
+}
+
+static void __devexit cmos_pnp_remove(struct pnp_dev *pnp)
+{
+	cmos_do_remove(&pnp->dev);
+}
+
+#ifdef	CONFIG_PM
+
+static int cmos_pnp_suspend(struct pnp_dev *pnp, pm_message_t mesg)
+{
+	return cmos_suspend(&pnp->dev, mesg);
+}
+
+static int cmos_pnp_resume(struct pnp_dev *pnp)
+{
+	return cmos_resume(&pnp->dev);
+}
+
+#else
+#define	cmos_pnp_suspend	NULL
+#define	cmos_pnp_resume		NULL
+#endif
+
+
+static const struct pnp_device_id rtc_ids[] = {
+	{ .id = "PNP0b00", },
+	{ .id = "PNP0b01", },
+	{ .id = "PNP0b02", },
+	{ },
+};
+MODULE_DEVICE_TABLE(pnp, rtc_ids);
+
+static struct pnp_driver cmos_pnp_driver = {
+	.name		= (char *) driver_name,
+	.id_table	= rtc_ids,
+	.probe		= cmos_pnp_probe,
+	.remove		= __devexit_p(cmos_pnp_remove),
+	.suspend	= cmos_pnp_suspend,
+	.resume		= cmos_pnp_resume,
+};
+
+static int __init cmos_init(void)
+{
+	return pnp_register_driver(&cmos_pnp_driver);
+}
+module_init(cmos_init);
+
+static void __exit cmos_exit(void)
+{
+	pnp_unregister_driver(&cmos_pnp_driver);
+}
+module_exit(cmos_exit);
+
+#else	/* no PNPACPI */
+
+/*----------------------------------------------------------------*/
+
+/* Platform setup should have set up an RTC device, when PNPACPI is
+ * unavailable ... including non-PC and non-ACPI platforms.
+ */
+
+static int __devinit cmos_platform_probe(struct platform_device *pdev)
+{
+	return cmos_do_probe(&pdev->dev,
+			platform_get_resource(pdev, IORESOURCE_IO, 0),
+			platform_get_irq(pdev, 0));
+}
+
+static int __devexit cmos_platform_remove(struct platform_device *pdev)
+{
+	cmos_do_remove(&pdev->dev);
+	return 0;
+}
+
+static void cmos_platform_shutdown(struct platform_device *pdev)
+{
+	cmos_do_shutdown();
+}
+
+static struct platform_driver cmos_platform_driver = {
+	.probe		= cmos_platform_probe,
+	.remove		= __devexit_p(cmos_platform_remove),
+	.shutdown	= cmos_platform_shutdown,
+	.driver = {
+		.name		= (char *) driver_name,
+		.suspend	= cmos_suspend,
+		.resume		= cmos_resume,
+	}
+};
+
+static int __init cmos_init(void)
+{
+	return platform_driver_register(&cmos_platform_driver);
+}
+module_init(cmos_init);
+
+static void __exit cmos_exit(void)
+{
+	platform_driver_unregister(&cmos_platform_driver);
+}
+module_exit(cmos_exit);
+
+
+#endif	/* !PNPACPI */
+
+MODULE_DESCRIPTION("'CMOS' RTC driver:  PCs, ACPI, etc");
+MODULE_LICENSE("GPL");
Index: g26/drivers/acpi/sleep/proc.c
===================================================================
--- g26.orig/drivers/acpi/sleep/proc.c	2006-11-20 10:03:06.000000000 -0800
+++ g26/drivers/acpi/sleep/proc.c	2006-11-20 10:10:47.000000000 -0800
@@ -70,6 +70,14 @@ acpi_system_write_sleep(struct file *fil
 }
 #endif				/* CONFIG_ACPI_SLEEP_PROC_SLEEP */
 
+#if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE)
+/* use code that fits into standard Linux driver frameworks */
+#else
+#define	HAVE_ACPI_LEGACY_ALARM
+#endif
+
+#ifdef	HAVE_ACPI_LEGACY_ALARM
+
 static int acpi_system_alarm_seq_show(struct seq_file *seq, void *offset)
 {
 	u32 sec, min, hr;
@@ -339,6 +347,8 @@ acpi_system_write_alarm(struct file *fil
       end:
 	return_VALUE(result ? result : count);
 }
+#endif	/* HAVE_ACPI_LEGACY_ALARM */
+
 
 extern struct list_head acpi_wakeup_device_list;
 extern spinlock_t acpi_device_lock;
@@ -452,6 +462,7 @@ static const struct file_operations acpi
 };
 #endif				/* CONFIG_ACPI_SLEEP_PROC_SLEEP */
 
+#ifdef	HAVE_ACPI_LEGACY_ALARM
 static const struct file_operations acpi_system_alarm_fops = {
 	.open = acpi_system_alarm_open_fs,
 	.read = seq_read,
@@ -467,8 +478,9 @@ static u32 rtc_handler(void *context)
 
 	return ACPI_INTERRUPT_HANDLED;
 }
+#endif	/* HAVE_ACPI_LEGACY_ALARM */
 
-static int acpi_sleep_proc_init(void)
+static int __init acpi_sleep_proc_init(void)
 {
 	struct proc_dir_entry *entry = NULL;
 
@@ -484,6 +496,7 @@ static int acpi_sleep_proc_init(void)
 		entry->proc_fops = &acpi_system_sleep_fops;
 #endif
 
+#ifdef	HAVE_ACPI_LEGACY_ALARM
 	/* 'alarm' [R/W] */
 	entry =
 	    create_proc_entry("alarm", S_IFREG | S_IRUGO | S_IWUSR,
@@ -491,6 +504,9 @@ static int acpi_sleep_proc_init(void)
 	if (entry)
 		entry->proc_fops = &acpi_system_alarm_fops;
 
+	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, NULL);
+#endif	/* HAVE_ACPI_LEGACY_ALARM */
+
 	/* 'wakeup device' [R/W] */
 	entry =
 	    create_proc_entry("wakeup", S_IFREG | S_IRUGO | S_IWUSR,
@@ -498,7 +514,6 @@ static int acpi_sleep_proc_init(void)
 	if (entry)
 		entry->proc_fops = &acpi_system_wakeup_device_fops;
 
-	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, NULL);
 	return 0;
 }
 
