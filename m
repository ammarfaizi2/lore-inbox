Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWI2GyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWI2GyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 02:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbWI2GyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 02:54:17 -0400
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:4523 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030334AbWI2GyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 02:54:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=t6CYRGU2MjheCLzQI6cYQ/lqMct5fA4NuYq7qLe0nridS9h3vqlqP3PEXCgCDcocUc2MRKvEsruwoo8HXyOO3nnaD9RZ2tMf1dc8wfVxmSuPqzLGWb0+/mDeb7HFOrP3PNZ0QpR/Wm0EnBwFdnvS19z2taw4SB1IRxM4QpItVu0=  ;
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.18-git] rtc-acpi, with wakeup support
Date: Thu, 28 Sep 2006 23:54:10 -0700
User-Agent: KMail/1.7.1
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>
References: <200607151240.51192.david-b@pacbell.net>
In-Reply-To: <200607151240.51192.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609282354.10848.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ NOT FOR MERGING -- just a patch refresh ]

This is a "new RTC framework" driver for the ACPI RTC.  It's a standard
AT-compatible RTC, with ACPI extensions that are mostly invisible to the
core code:

  - new registers, for wakeup intervals longer than a day (up to a year)
    and a century register for Y2K/Y3K awareness;
  - more nvram (not that this driver cares);
  - system wakeup hooks, through ACPI (that is, southbridge hooks)

Advantages of this vs. drivers/char/rtc.c (use one _or_ the other) include:

 - Driver binding now has "real driver model support":
     * By preference, this uses PNPACPI;
     * If that's not configured, it creates a platform_device (but that
       should really live someplace else, maybe ACPI init code)

 - /sys/devices/.../power/wakeup and normal rtc ioctls manage RTC
   wakeups using platform-neutral API (also supported on some embedded
   Linuxes) not that yucky /proc/acpi/alarm interface.

Currently unsupported features:

 - changing periodic irq frequency (char/rtc.c allows that).
 - using the optional "century" register (no Linux code does, yet).

Issues of note:

 - Some tools like "hwclock" expect /dev/rtc not /dev/rtc0; patches
   are available for util-linux-2.13-pre7 and busybox.
 - ACPI wakeup doesn't always work:  after hardware wakeup, the software
   re-activation commonly wedges.  Some systems are very usable after
   timer wakeup from S3/STR or S4/swsusp, other are not.  (This issue
   is generic to ACPI, not specific to RTC.)  Workaround by disabling
   RTC wakeup via "echo disable > /sys/devices/.../wakeup".

Those issues are not caused by this code, just exposed by it.

A significant change from the previous version is that this one doesn't
require PNPACPI ... although the way it works without that is klugey,
the innards are now factored better.  Eventually arch/*/ platform code
on PCs should probably create the platform device.  ACPI would then be
able to just add the relevant extensions to platform_data, providing a
relatively clean solution to the enumeration problem, probably even one
that could work on non-ACPI hardware.


Index: g26/drivers/rtc/Kconfig
===================================================================
--- g26.orig/drivers/rtc/Kconfig	2006-09-28 10:58:54.000000000 -0700
+++ g26/drivers/rtc/Kconfig	2006-09-28 11:04:49.000000000 -0700
@@ -95,6 +95,21 @@ config RTC_INTF_DEV_UIE_EMUL
 comment "RTC drivers"
 	depends on RTC_CLASS
 
+config RTC_DRV_ACPI
+	tristate "ACPI real time clock"
+	depends on RTC_CLASS && ACPI
+	help
+	  Say "yes" here to get direct support for the real time clock
+	  found in every ACPI-based PC.
+
+	  This RTC can be used to wake the system from suspend-to-RAM or
+	  standby sleep modes, and on some systems from suspend-to-disk.
+
+	  This obsoletes the old /proc/acpi/alarm interface.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-acpi.
+
 config RTC_DRV_X1205
 	tristate "Xicor/Intersil X1205"
 	depends on RTC_CLASS && I2C
@@ -221,11 +236,14 @@ config RTC_DRV_S3C
 	  will be called rtc-s3c.
 
 config RTC_DRV_M48T86
-	tristate "ST M48T86/Dallas DS12887"
-	depends on RTC_CLASS
+	tristate "ST M48T86, Dallas DS12887 and compatible"
+	depends on RTC_CLASS && !X86_PC
 	help
-	  If you say Y here you will get support for the
-	  ST M48T86 and Dallas DS12887 RTC chips.
+	  If you say Y here you will get support for the ST M48T86, Dallas
+	  DS12887, and compatible RTC chips.  To software, these are all
+	  but identical to the "cmos clock" used in x86 PCs, although this
+	  driver does not obey the locking or ACPI integration rules
+	  used on that architecture.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-m48t86.
Index: g26/drivers/rtc/Makefile
===================================================================
--- g26.orig/drivers/rtc/Makefile	2006-09-28 10:58:54.000000000 -0700
+++ g26/drivers/rtc/Makefile	2006-09-28 11:04:49.000000000 -0700
@@ -15,6 +15,7 @@ obj-$(CONFIG_RTC_INTF_SYSFS)	+= rtc-sysf
 obj-$(CONFIG_RTC_INTF_PROC)	+= rtc-proc.o
 obj-$(CONFIG_RTC_INTF_DEV)	+= rtc-dev.o
 
+obj-$(CONFIG_RTC_DRV_ACPI)	+= rtc-acpi.o
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
 obj-$(CONFIG_RTC_DRV_ISL1208)	+= rtc-isl1208.o
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
Index: g26/drivers/rtc/rtc-acpi.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/drivers/rtc/rtc-acpi.c	2006-09-28 11:04:49.000000000 -0700
@@ -0,0 +1,725 @@
+/*
+ * RTC driver for ACPI
+ *
+ * Copyright (C) 1996 Paul Gortmaker (drivers/char/rtc.c)
+ * Copyright (C) 2006 David Brownell (convert to new frameworks)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+/*
+ * The original "cmos clock" chip was an MC146818 chip, now obsolete,
+ * which defined the register interface now provided by all PCs and
+ * incorporated into ACPI.  Modern PC chipsets integrate an MC146818
+ * clone in their southbridge, rather than using discrete chips like
+ * the DS12887 and M48T86.
+ *
+ * That register API is also used directly by various other drivers,
+ * (notably for integrated NVRAM) and utilities ... so **ALL** calls
+ * to CMOS_READ and CMOS_WRITE must be done with interrupts disabled,
+ * holding the global rtc_lock, to exclude those other drivers and
+ * utilities (though userspace may not cooperate).
+ *
+ * This driver leverages the RTC framework for architecture-neutral
+ * programming interfaces, PNPACPI (by preference) to integrate with
+ * the driver model, the driver model /sys/.../power/wakeup device
+ * attribute to manage ACPI's RTC wake event mechanism, and ACPI
+ * extensions for alarms expiring up to a year in the future.
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
+enum rtc_type {
+	RTC_UNKNOWN = 0,
+	RTC_AT,
+	RTC_PIIX4,
+	RTC_DALLAS,
+};
+
+struct cmos_rtc {
+	struct rtc_device	*rtc;
+	struct device		*dev;
+	int			irq;
+	struct resource		*iomem;
+	u8			acpi;
+	u8			day_alrm;
+	u8			mon_alrm;
+};
+
+#ifdef	CONFIG_ACPI_SLEEP
+#define	use_acpi_wake(cmos)	((cmos)->acpi)
+#else
+#define	use_acpi_wake(cmos)	0
+#endif
+
+static const char driver_name[] = "rtc-acpi";
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
+	/* REVISIT:  set the "century" register if available */
+	return set_rtc_time(t);
+}
+
+static int cmos_read_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
+	unsigned char	rtc_control;
+
+	/* Basic alarms only support hour, minute, and seconds fields.
+	 * Some also support day and month, for alarms up to a year in
+	 * the future.
+	 */
+	spin_lock_irq(&rtc_lock);
+	t->time.tm_sec = CMOS_READ(RTC_SECONDS_ALARM);
+	t->time.tm_min = CMOS_READ(RTC_MINUTES_ALARM);
+	t->time.tm_hour = CMOS_READ(RTC_HOURS_ALARM);
+
+	if (cmos->day_alrm) {
+		t->time.tm_mday = CMOS_READ(cmos->day_alrm);
+		if (!t->time.tm_mday || ((unsigned)t->time.tm_mday) > 0x31)
+			t->time.tm_mday = -1;
+	} else
+		t->time.tm_mday = -1;
+
+	if (cmos->mon_alrm) {
+		t->time.tm_mon = CMOS_READ(cmos->mon_alrm);
+		if (!t->time.tm_mon || ((unsigned)t->time.tm_mon) > 0x12)
+			t->time.tm_mon = -1;
+	} else
+		t->time.tm_mon = -1;
+
+	rtc_control = CMOS_READ(RTC_CONTROL);
+	spin_unlock_irq(&rtc_lock);
+
+	if (((unsigned)t->time.tm_sec) < 0x60)
+		BCD_TO_BIN(t->time.tm_sec);
+	else
+		t->time.tm_sec = -1;
+	if (((unsigned)t->time.tm_min) < 0x60)
+		BCD_TO_BIN(t->time.tm_min);
+	else
+		t->time.tm_min = -1;
+	if (((unsigned)t->time.tm_hour) < 0x24)
+		BCD_TO_BIN(t->time.tm_hour);
+	else
+		t->time.tm_hour = -1;
+
+	if (t->time.tm_mday != -1)
+		t->time.tm_mday = BCD2BIN(t->time.tm_mday);
+	if (t->time.tm_mon != -1)
+		t->time.tm_mon = BCD2BIN(t->time.tm_mon) - 1;
+	t->time.tm_year = -1;
+
+	t->pending = !!(rtc_control & RTC_AIE);
+	t->enabled = t->pending && device_may_wakeup(dev);
+
+	return 0;
+}
+
+static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
+	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
+	unsigned char	mon, mday, hrs, min, sec;
+	unsigned char	rtc_control;
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
+	CMOS_READ(RTC_INTR_FLAGS);
+
+	/* update alarm */
+	CMOS_WRITE(hrs, RTC_HOURS_ALARM);
+	CMOS_WRITE(min, RTC_MINUTES_ALARM);
+	CMOS_WRITE(sec, RTC_SECONDS_ALARM);
+
+	/* the system may support an "enhanced" alarm */
+	if (cmos->day_alrm)
+		CMOS_WRITE(mday, cmos->day_alrm);
+	if (cmos->mon_alrm)
+		CMOS_WRITE(mon, cmos->mon_alrm);
+
+	if (t->enabled) {
+		rtc_control |= RTC_AIE;
+		CMOS_WRITE(rtc_control, RTC_CONTROL);
+		CMOS_READ(RTC_INTR_FLAGS);
+	}
+
+	spin_unlock_irq(&rtc_lock);
+
+#ifdef	DEBUG
+/* FOR DEBUG ... does this ACPI event mechanism behave?
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
+static int cmos_read_freq(struct device *dev)
+{
+	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
+	int		freq;
+	unsigned long	flags;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+	freq = CMOS_READ(RTC_FREQ_SELECT);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+
+	/* only the oldest "cmos" RTCs used non-32K clock */
+	WARN_ON((freq & RTC_DIV_CTL) != RTC_REF_CLCK_32KHZ);
+
+	freq &= 0x0f;
+	if (freq)
+		freq = 1 << (16 - freq);
+
+	if (freq != cmos->rtc->irq_freq) {
+		pr_debug("%s: recorded irq_freq %d was wrong (not %d)\n",
+			cmos->rtc->class_dev.class_id,
+			cmos->rtc->irq_freq, freq);
+		cmos->rtc->irq_freq = freq;
+	}
+	return freq;
+}
+
+static int cmos_set_freq(struct device *dev, int freq)
+{
+	/* FIXME implement this ... and fix the rtc core to know
+	 * how to map RTC_IRQP_SET into irq_set_freq().  Maybe even
+	 * handle IRQP_READ using rtc->irq_freq.
+	 */
+	return -ENOIOCTLCMD;
+}
+
+#if defined(CONFIG_RTC_INTF_DEV) || defined(CONFIG_RTC_INTF_DEV_MODULE)
+
+static int
+cmos_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	unsigned char	rtc_control;
+	unsigned long	flags;
+
+	switch (cmd) {
+	case RTC_AIE_OFF:
+	case RTC_AIE_ON:
+	case RTC_UIE_OFF:
+	case RTC_UIE_ON:
+	case RTC_PIE_OFF:
+	case RTC_PIE_ON:
+		break;
+	case RTC_IRQP_READ:	/* read periodic IRQ rate */
+		return put_user(cmos_read_freq(dev),
+				(unsigned long __user *)arg);
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
+	CMOS_READ(RTC_INTR_FLAGS);
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
+	unsigned char	rtc_control, valid;
+
+	spin_lock_irq(&rtc_lock);
+	rtc_control = CMOS_READ(RTC_CONTROL);
+	valid = CMOS_READ(RTC_VALID);
+	spin_unlock_irq(&rtc_lock);
+
+	return seq_printf(seq,
+			"periodic_IRQ\t: %s\n"
+			"periodic_freq\t: %d\n"
+			"batt_status\t: %s\n",
+			(rtc_control & RTC_PIE) ? "yes" : "no",
+			cmos_read_freq(dev),
+			(valid & RTC_VRT) ? "okay" : "dead");
+}
+
+#else
+#define	cmos_procfs	NULL
+#endif
+
+static struct rtc_class_ops cmos_rtc_ops = {
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
+static irqreturn_t cmos_interrupt(int irq, void *p, struct pt_regs *r)
+{
+	u8		irqstat;
+
+	spin_lock (&rtc_lock);
+	irqstat = CMOS_READ(RTC_INTR_FLAGS);
+	spin_unlock (&rtc_lock);
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
+cmos_do_probe(struct device *dev, enum rtc_type type,
+		struct resource *ports, int rtc_irq)
+{
+	int		retval = 0;
+	unsigned char	rtc_control;
+	int		rtcs4 = 0;
+	int		century = 0;
+
+	/* there can be only one ... */
+	if (cmos_rtc.dev)
+		return -EBUSY;
+
+	if (!ports || rtc_irq < 0)
+		return -ENODEV;
+
+	cmos_rtc.irq = rtc_irq;
+	cmos_rtc.iomem = ports;
+
+	/* REVISIT evidently access to this acpi table is supposed to
+	 * be locked, but it's unclear why that'd be needed except
+	 * during _very_ early boot ...
+	 */
+	if (acpi_gbl_FADT) {
+		/* REVISIT there are many partial-acpi boot modes;
+		 * only set the acpi flag if this system is running
+		 * in one of the modes that supports it.
+		 */
+		cmos_rtc.acpi = 1;
+
+		cmos_rtc.mon_alrm = acpi_gbl_FADT->mon_alrm;
+		cmos_rtc.day_alrm = acpi_gbl_FADT->day_alrm;
+		rtcs4 = acpi_gbl_FADT->rtcs4;
+		century = acpi_gbl_FADT->century;
+	}
+
+	dev_info(dev, "%s RTC%s%s, 1 %s alarm\n",
+			({ char *s; switch (type) {
+			case RTC_AT:	s = "AT compatible"; break;
+			case RTC_PIIX4:	s = "PIIX4"; break;
+			case RTC_DALLAS:s = "Dallas"; break;
+			default:	s = "*unknown*"; break;
+			} s; }),
+			rtcs4 ? " (S4wake)" : "",
+			century ? " (y3k)" : "",
+			cmos_rtc.mon_alrm
+				? "year"
+				: (cmos_rtc.day_alrm ? "month" : "day")
+			);
+
+	cmos_rtc.rtc = rtc_device_register(driver_name, dev,
+				&cmos_rtc_ops, THIS_MODULE);
+	if (IS_ERR(cmos_rtc.rtc))
+		return PTR_ERR(cmos_rtc.rtc);
+
+	cmos_rtc.dev = dev;
+	dev_set_drvdata(dev, &cmos_rtc);
+
+	retval = request_irq(rtc_irq, cmos_interrupt, IRQF_DISABLED,
+				cmos_rtc.rtc->class_dev.class_id,
+				&cmos_rtc.rtc->class_dev);
+	if (retval < 0) {
+		printk(KERN_ERR "%s: IRQ %d already in use\n",
+				cmos_rtc.rtc->class_dev.class_id,
+				rtc_irq);
+		goto cleanup0;
+	}
+
+	/* platform and pnp busses handle resources incompatibly... */
+	if (is_pnpacpi()) {
+		retval = request_resource(&ioport_resource, ports);
+		if (retval < 0) {
+			printk(KERN_ERR "%s: i/o registers already in use\n",
+					cmos_rtc.rtc->class_dev.class_id);
+			goto cleanup1;
+		}
+	}
+	rename_region(ports, cmos_rtc.rtc->class_dev.class_id);
+
+	spin_lock_irq(&rtc_lock);
+
+	/* force periodic irq to CMOS reset default of 1024Hz */
+	CMOS_WRITE(RTC_REF_CLCK_32KHZ | 0x06, RTC_FREQ_SELECT);
+	cmos_rtc.rtc->irq_freq = 1024;
+
+	/* force to 24 hour time mode, bcd, disable irqs */
+	rtc_control = CMOS_READ(RTC_CONTROL);
+	rtc_control |= RTC_24H;
+	rtc_control &= ~(RTC_PIE|RTC_AIE|RTC_UIE|RTC_DM_BINARY);
+	CMOS_WRITE(rtc_control, RTC_CONTROL);
+	CMOS_READ(RTC_INTR_FLAGS);
+
+	spin_unlock_irq(&rtc_lock);
+
+	/* see acpi spec 4.7.2.4 ... it's always a wakeup source from
+	 * S1/S2/S3 and often S4 (when RTC_S4 is set in FADT).
+	 */
+	device_init_wakeup(dev, 1);
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
+	free_irq(rtc_irq, &cmos_rtc.rtc->class_dev);
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
+	device_init_wakeup(dev, 0);
+
+	if (dev->bus != &platform_bus_type)
+		release_resource(cmos->iomem);
+	rename_region(cmos->iomem, NULL);
+
+	free_irq(cmos->irq, &cmos_rtc.rtc->class_dev);
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
+/* we prefer that the device node be created by PNPACPI, but
+ * can cope without it by using a platform device (which should
+ * eventually have platform_data to hold extensions
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
+	 * drivers can't provide shutdown() methods to disable IRQs
+	 */
+	return cmos_do_probe(&pnp->dev, id->driver_data,
+		&pnp->res.port_resource[0],
+		pnp->res.irq_resource[0].start);
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
+	{ .id = "PNP0b00", .driver_data = RTC_AT, },
+	{ .id = "PNP0b01", .driver_data = RTC_PIIX4, },
+	{ .id = "PNP0b02", .driver_data = RTC_DALLAS, },
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
+static int __devinit cmos_platform_probe(struct platform_device *pdev)
+{
+	return cmos_do_probe(&pdev->dev, RTC_AT,
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
+/* FIXME platform device registration belongs in arch/.../ code,
+ * and should never need to be reversed ... and for this driver,
+ * such registration should not assume ACPI!!
+ */
+struct resource rtc_platform_resources[] = { {
+	.flags		= IORESOURCE_IO,
+	.start		= 0x70,
+	.end		= 0x71,
+}, {
+	.flags		= IORESOURCE_IRQ,
+	.start		= RTC_IRQ
+} };
+
+struct platform_device rtc_platform_dev = {
+	.name		= (char *) driver_name,
+	.id		= -1,
+	.resource	= rtc_platform_resources,
+	.num_resources	= ARRAY_SIZE(rtc_platform_resources),
+};
+
+static int __init cmos_init(void)
+{
+	(void) platform_device_register(&rtc_platform_dev);
+
+	return platform_driver_register(&cmos_platform_driver);
+}
+module_init(cmos_init);
+
+/*
+static void __exit cmos_exit(void)
+{
+	platform_driver_unregister(&cmos_platform_driver);
+
+	platform_device_unregister(&rtc_platform_dev);
+
+}
+module_exit(cmos_exit);
+*/
+
+
+#endif	/* !PNPACPI */
+
+MODULE_DESCRIPTION("RTC driver for ACPI");
+MODULE_LICENSE("GPL");
Index: g26/drivers/acpi/sleep/proc.c
===================================================================
--- g26.orig/drivers/acpi/sleep/proc.c	2006-09-27 16:06:10.000000000 -0700
+++ g26/drivers/acpi/sleep/proc.c	2006-09-28 11:04:49.000000000 -0700
@@ -70,6 +70,14 @@ acpi_system_write_sleep(struct file *fil
 }
 #endif				/* CONFIG_ACPI_SLEEP_PROC_SLEEP */
 
+#if defined(CONFIG_RTC_DRV_ACPI) || defined(CONFIG_RTC_DRV_ACPI_MODULE)
+/* use code that fits into standard Linux driver frameworks */
+#else
+#define	HAVE_PRIVATE_ALARM
+#endif
+
+#ifdef	HAVE_PRIVATE_ALARM
+
 static int acpi_system_alarm_seq_show(struct seq_file *seq, void *offset)
 {
 	u32 sec, min, hr;
@@ -339,6 +347,8 @@ acpi_system_write_alarm(struct file *fil
       end:
 	return_VALUE(result ? result : count);
 }
+#endif	/* HAVE_PRIVATE_ALARM */
+
 
 extern struct list_head acpi_wakeup_device_list;
 extern spinlock_t acpi_device_lock;
@@ -452,6 +462,7 @@ static const struct file_operations acpi
 };
 #endif				/* CONFIG_ACPI_SLEEP_PROC_SLEEP */
 
+#ifdef	HAVE_PRIVATE_ALARM
 static const struct file_operations acpi_system_alarm_fops = {
 	.open = acpi_system_alarm_open_fs,
 	.read = seq_read,
@@ -467,6 +478,7 @@ static u32 rtc_handler(void *context)
 
 	return ACPI_INTERRUPT_HANDLED;
 }
+#endif	/* HAVE_PRIVATE_ALARM */
 
 static int acpi_sleep_proc_init(void)
 {
@@ -484,6 +496,7 @@ static int acpi_sleep_proc_init(void)
 		entry->proc_fops = &acpi_system_sleep_fops;
 #endif
 
+#ifdef	HAVE_PRIVATE_ALARM
 	/* 'alarm' [R/W] */
 	entry =
 	    create_proc_entry("alarm", S_IFREG | S_IRUGO | S_IWUSR,
@@ -491,6 +504,9 @@ static int acpi_sleep_proc_init(void)
 	if (entry)
 		entry->proc_fops = &acpi_system_alarm_fops;
 
+	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, NULL);
+#endif	/* HAVE_PRIVATE_ALARM */
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
 
Index: g26/drivers/acpi/utilities/utglobal.c
===================================================================
--- g26.orig/drivers/acpi/utilities/utglobal.c	2006-09-27 16:06:10.000000000 -0700
+++ g26/drivers/acpi/utilities/utglobal.c	2006-09-28 11:04:49.000000000 -0700
@@ -840,5 +840,6 @@ void acpi_ut_init_globals(void)
 	return_VOID;
 }
 
+ACPI_EXPORT_SYMBOL(acpi_gbl_FADT)
 ACPI_EXPORT_SYMBOL(acpi_dbg_level)
 ACPI_EXPORT_SYMBOL(acpi_dbg_layer)
