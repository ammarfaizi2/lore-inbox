Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWGOTsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWGOTsd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 15:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWGOTsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 15:48:33 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:31330 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030228AbWGOTsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 15:48:32 -0400
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.18-rc1-git] rtc-acpi, with wakeup support
Date: Sat, 15 Jul 2006 12:40:51 -0700
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DTUuEYvYH5sLGrf"
Message-Id: <200607151240.51192.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_DTUuEYvYH5sLGrf
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The new RTC framework hasn't been very usable on most x86 desktop
PCs ... so here's a driver using the ACPI RTC and PNPACPI.  AFAICT
it could mostly replace drivers/char/rtc.c on ACPI systems.

One of the goals here was to expose this RTC as a normal wakeup
event source ... no /proc/acpi/alarm thing, just the same userspace
interfaces as on non-ACPI RTCs, and non-RTC devices.  That works
somewhat ... for the very first time, I've seen ACPI wakeup behave!

But ACPI doesn't always behave after hardware wakeup events, so

	echo disabled > /sys/class/rtc/rtc0/device/power/wakeup

may be appropriate on the systems where it doesn't yet work.

- Dave

p.s. A followup message will include a userspace program which
     makes it easier to try the RTC wakeup mechanism.




--Boundary-00=_DTUuEYvYH5sLGrf
Content-Type: text/x-diff;
  charset="us-ascii";
  name="rtc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rtc.patch"

This is the guts of a "new RTC framework" driver for the ACPI RTC, which is
AT-compatible except for new registers, more nvram, and system wakeup hooks.
Advantages of this vs. drivers/char/rtc.c include:

 - Driver binding uses PNPACPI; it now has "real driver model support".
   Non-ACPI platforms should be able to reuse the core code.

 - Given driver model support, now /sys/devices/.../power/wakeup and
   normal rtc ioctls will control RTC wakeups instead of that yucky
   /proc/acpi/alarm interface.  This is a fully platform-neutral API,
   easily supported on non-PC hardware.

 - This version supports wakeup events up to a year in the future (not
   just 24 hours) when ACPI reports RTC hardware which can do that.

The RTC bits seem to work OK (except for changing irq frequency, or using
the optional "century" register -- neither is implemented), although
some tools like "hwclock" expect /dev/rtc not /dev/rtc0.

ACPI wakeup is more problematic; after hardware wakeup, the software
re-activation sometimes wedges.  (That's not an RTC-specific problem.)
I've seen one system be usable after the timer wakeup from S3/STR, but
another wedged after timer wakeup from S4/swsusp.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/rtc/Kconfig
===================================================================
--- g26.orig/drivers/rtc/Kconfig	2006-07-15 10:18:56.000000000 -0700
+++ g26/drivers/rtc/Kconfig	2006-07-15 10:19:47.000000000 -0700
@@ -83,6 +83,21 @@ config RTC_INTF_DEV_UIE_EMUL
 comment "RTC drivers"
 	depends on RTC_CLASS
 
+config RTC_DRV_ACPI
+	tristate "ACPI real time clock"
+	depends on RTC_CLASS && PNPACPI
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
Index: g26/drivers/rtc/Makefile
===================================================================
--- g26.orig/drivers/rtc/Makefile	2006-07-15 10:18:56.000000000 -0700
+++ g26/drivers/rtc/Makefile	2006-07-15 10:19:47.000000000 -0700
@@ -11,6 +11,7 @@ obj-$(CONFIG_RTC_INTF_SYSFS)	+= rtc-sysf
 obj-$(CONFIG_RTC_INTF_PROC)	+= rtc-proc.o
 obj-$(CONFIG_RTC_INTF_DEV)	+= rtc-dev.o
 
+obj-$(CONFIG_RTC_DRV_ACPI)	+= rtc-acpi.o
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
 obj-$(CONFIG_RTC_DRV_ISL1208)	+= rtc-isl1208.o
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
Index: g26/drivers/rtc/rtc-acpi.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/drivers/rtc/rtc-acpi.c	2006-07-15 10:19:47.000000000 -0700
@@ -0,0 +1,515 @@
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
+ * The RTC exposed by ACPI uses a standard register API that's used
+ * directly by various other drivers and utilities.  This is why
+ * **ALL** calls to CMOS_READ and CMOS_WRITE are done with interrupts
+ * disabled, and holding a global spinlock ... to exclude those other
+ * drivers and utilities.
+ *
+ * This driver leverages the RTC framework for architecture-neutral
+ * programming interfaces, PNPACPI to integrate with the driver model,
+ * the /sys/.../power/wakeup device attribute provided by that driver
+ * model to manage ACPI's RTC wake event mechanism, and ACPI extensions
+ * for alarms that expire between a day and a year in the future.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/pnp.h>
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
+	struct pnp_dev		*pnp;
+};
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
+	unsigned char		rtc_control;
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
+	if (acpi_gbl_FADT->day_alrm) {
+		t->time.tm_mday = CMOS_READ(acpi_gbl_FADT->day_alrm);
+		if (!t->time.tm_mday || t->time.tm_mday > 0x31)
+			t->time.tm_mday = -1;
+	} else
+		t->time.tm_mday = -1;
+
+	if (acpi_gbl_FADT->mon_alrm) {
+		t->time.tm_mon = CMOS_READ(acpi_gbl_FADT->mon_alrm);
+		if (!t->time.tm_mon || t->time.tm_mon > 0x12)
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
+	t->enabled = device_may_wakeup(dev) && !!(rtc_control & RTC_AIE);
+
+	return 0;
+}
+
+static int cmos_set_alarm(struct device *dev, struct rtc_wkalrm *t)
+{
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
+	acpi_disable_event(ACPI_EVENT_RTC, 0);
+	acpi_clear_event(ACPI_EVENT_RTC);
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
+	if (acpi_gbl_FADT->day_alrm)
+		CMOS_WRITE(mday, acpi_gbl_FADT->day_alrm);
+	if (acpi_gbl_FADT->mon_alrm)
+		CMOS_WRITE(mon, acpi_gbl_FADT->mon_alrm);
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
+/* FOR DEBUG ... does the ACPI event mechanism behave?
+ * we'd prefer to call this with the lock held...
+ */
+acpi_enable_event(ACPI_EVENT_RTC, 0);
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
+static int
+cmos_rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	int		ret;
+	unsigned char	rtc_control;
+	unsigned long	flags;
+
+	if (cmd == RTC_IRQP_READ)	/* read periodic IRQ rate */
+		return put_user(cmos_read_freq(dev),
+				(unsigned long __user *)arg);
+
+	ret = 0;
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
+	default:
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+	if (ret == 0) {
+		CMOS_WRITE(rtc_control, RTC_CONTROL);
+		CMOS_READ(RTC_INTR_FLAGS);
+	}
+	spin_unlock_irqrestore(&rtc_lock, flags);
+
+	return ret;
+}
+
+#ifdef	CONFIG_RTC_INTF_PROC
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
+static struct cmos_rtc	acpi_rtc;
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
+static u32 cmos_acpi_handler(void *p)
+{
+	acpi_clear_event(ACPI_EVENT_RTC);
+	acpi_disable_event(ACPI_EVENT_RTC, 0);
+
+	/* REVISIT want to see acpi events working */
+
+pr_debug("%s\n", __FUNCTION__);
+
+	// rtc_update_irq(p, 1, RTC_IRQF | RTC_AF);
+
+	return ACPI_INTERRUPT_HANDLED;
+}
+
+static int __devinit
+cmos_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
+{
+	int		retval = 0;
+	int		rtc_irq;
+	unsigned char	rtc_control;
+
+	/* there can be only one ... */
+	if (acpi_rtc.pnp)
+		return -EBUSY;
+
+	dev_info(&pnp->dev, "%s RTC%s%s, 1 %s alarm\n",
+			({ char *s; switch (id->driver_data) {
+			case RTC_AT:	s = "AT compatible"; break;
+			case RTC_PIIX4:	s = "PIIX4"; break;
+			case RTC_DALLAS:s = "Dallas"; break;
+			default:	s = "*unknown*"; break;
+			} s; }),
+			acpi_gbl_FADT->rtcs4 ? " (S4wake)" : "",
+			acpi_gbl_FADT->century ? " (y3k)" : "",
+			acpi_gbl_FADT->mon_alrm
+				? "year"
+				: (acpi_gbl_FADT->day_alrm
+					? "month" : "day")
+			);
+
+	acpi_rtc.rtc = rtc_device_register(driver_name, &pnp->dev,
+				&cmos_rtc_ops, THIS_MODULE);
+	if (IS_ERR(acpi_rtc.rtc))
+		return PTR_ERR(acpi_rtc.rtc);
+
+	acpi_rtc.pnp = pnp;
+	pnp_set_drvdata(pnp, &acpi_rtc);
+
+	rtc_irq = pnp->res.irq_resource[0].start;
+	retval = request_irq(rtc_irq, cmos_interrupt, IRQF_DISABLED,
+				acpi_rtc.rtc->class_dev.class_id,
+				&acpi_rtc.rtc->class_dev);
+	if (retval < 0) {
+		printk(KERN_ERR "%s: IRQ %d already in use\n",
+				acpi_rtc.rtc->class_dev.class_id,
+				rtc_irq);
+		goto cleanup0;
+	}
+
+	pnp->res.port_resource[0].name = acpi_rtc.rtc->class_dev.class_id;
+	retval = request_resource(&ioport_resource,
+				&pnp->res.port_resource[0]);
+	if (retval < 0) {
+		printk(KERN_ERR "%s: i/o registers already in use\n",
+				acpi_rtc.rtc->class_dev.class_id);
+		goto cleanup1;
+	}
+
+	spin_lock_irq(&rtc_lock);
+
+	/* force periodic irq to CMOS reset default of 1024Hz */
+	CMOS_WRITE(RTC_REF_CLCK_32KHZ | 0x06, RTC_FREQ_SELECT);
+	acpi_rtc.rtc->irq_freq = 1024;
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
+	device_init_wakeup(&pnp->dev, 1);
+
+	acpi_install_fixed_event_handler(ACPI_EVENT_RTC,
+			cmos_acpi_handler, &acpi_rtc.rtc->class_dev);
+	acpi_disable_event(ACPI_EVENT_RTC, 0);
+
+	return 0;
+
+cleanup1:
+	free_irq(rtc_irq, &acpi_rtc.rtc->class_dev);
+cleanup0:
+	rtc_device_unregister(acpi_rtc.rtc);
+	return retval;
+}
+
+static void __devexit cmos_remove(struct pnp_dev *pnp)
+{
+	unsigned char	rtc_control;
+
+	rtc_control = CMOS_READ(RTC_CONTROL);
+	rtc_control &= ~(RTC_PIE|RTC_AIE|RTC_UIE);
+	CMOS_WRITE(rtc_control, RTC_CONTROL);
+	CMOS_READ(RTC_INTR_FLAGS);
+
+	acpi_disable_event(ACPI_EVENT_RTC, 0);
+	acpi_remove_fixed_event_handler(ACPI_EVENT_RTC, cmos_acpi_handler);
+	device_init_wakeup(&pnp->dev, 0);
+
+	release_resource(&pnp->res.port_resource[0]);
+	pnp->res.port_resource[0].name = NULL;
+
+	free_irq(pnp->res.irq_resource[0].start, &acpi_rtc.rtc->class_dev);
+
+	rtc_device_unregister(acpi_rtc.rtc);
+
+	acpi_rtc.pnp = NULL;
+	pnp_set_drvdata(pnp, NULL);
+}
+
+#ifdef	CONFIG_PM
+
+static int cmos_suspend(struct pnp_dev *pnp, pm_message_t mesg)
+{
+	/* force RTC_EN value during system sleep states */
+	if (device_may_wakeup(&pnp->dev))
+		acpi_enable_event(ACPI_EVENT_RTC, 0);
+	else
+		acpi_disable_event(ACPI_EVENT_RTC, 0);
+
+pr_debug("%s, EVENT_RTC %sabled\n", __FUNCTION__,
+	device_may_wakeup(&pnp->dev) ? "en" : "dis");
+
+	return 0;
+}
+
+static int cmos_resume(struct pnp_dev *pnp)
+{
+	/* REVISIT:  the mechanism to resync jiffies on resume
+	 * should be portable between platforms ...
+	 */
+
+pr_debug("%s\n", __FUNCTION__);
+
+	acpi_disable_event(ACPI_EVENT_RTC, 0);
+
+	return 0;
+}
+
+#else
+#define	cmos_suspend	NULL
+#define	cmos_resume	NULL
+#endif
+
+static struct pnp_device_id rtc_ids[] = {
+	{ .id = "PNP0b00", .driver_data = RTC_AT, },
+	{ .id = "PNP0b01", .driver_data = RTC_PIIX4, },
+	{ .id = "PNP0b02", .driver_data = RTC_DALLAS, },
+	{ },
+};
+MODULE_DEVICE_TABLE(pnp, rtc_ids);
+
+static struct pnp_driver cmos_driver = {
+	.name		= (char *) driver_name,
+	.id_table	= rtc_ids,
+	.probe		= cmos_probe,
+	.remove		= __devexit_p(cmos_remove),
+	.suspend	= cmos_suspend,
+	.resume		= cmos_resume,
+};
+
+/*----------------------------------------------------------------*/
+
+static int __init cmos_init(void)
+{
+	return pnp_register_driver(&cmos_driver);
+}
+module_init(cmos_init);
+
+static void __exit cmos_exit(void)
+{
+	pnp_unregister_driver(&cmos_driver);
+}
+module_exit(cmos_exit);
+
+MODULE_DESCRIPTION("RTC driver for ACPI");
+MODULE_LICENSE("GPL");
Index: g26/drivers/acpi/sleep/proc.c
===================================================================
--- g26.orig/drivers/acpi/sleep/proc.c	2006-07-15 10:15:29.000000000 -0700
+++ g26/drivers/acpi/sleep/proc.c	2006-07-15 10:19:47.000000000 -0700
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
--- g26.orig/drivers/acpi/utilities/utglobal.c	2006-07-15 10:15:29.000000000 -0700
+++ g26/drivers/acpi/utilities/utglobal.c	2006-07-15 10:19:47.000000000 -0700
@@ -840,5 +840,6 @@ void acpi_ut_init_globals(void)
 	return_VOID;
 }
 
+ACPI_EXPORT_SYMBOL(acpi_gbl_FADT)
 ACPI_EXPORT_SYMBOL(acpi_dbg_level)
 ACPI_EXPORT_SYMBOL(acpi_dbg_layer)

--Boundary-00=_DTUuEYvYH5sLGrf--
