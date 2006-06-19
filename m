Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWFSLD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWFSLD7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 07:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWFSLD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 07:03:59 -0400
Received: from host-84-9-201-23.bulldogdsl.com ([84.9.201.23]:21608 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932376AbWFSLD6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 07:03:58 -0400
Date: Mon, 19 Jun 2006 12:03:45 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC] S3C24XX: RTC class driver for S3C24XX SoCs
Message-ID: <20060619110345.GA17648@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch adds the RTC class driver for the Samsung S3C24XX
class of SoCs. It is update from drivers/char/s3c2410-rtc.c (which
this patch does not remove). 

There are two issues that I would like to resolve before finally
submitting this patch:

1) The calling of rtc_update_irq(), should the count be initialised
   to 1 when the periodic interrupt is started

2) The original dirver is s3c2410-rtc, abut the new one is now named
   rtc-s3c24xx to fit in with the new drivers. This will mean tha the
   name of the module produced will change.

   Is it ok to keep the s3c2410-rtc name, or will the rename be
   preferred?

--- linux-2.6.17/drivers/rtc/Kconfig	2006-06-18 02:49:35.000000000 +0100
+++ linux-2.6.17-rc5-rtc1/drivers/rtc/Kconfig	2006-06-19 11:39:44.000000000 +0100
@@ -117,6 +117,18 @@ config RTC_DRV_RS5C372
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-rs5c372.
 
+config RTC_DRV_S3C24XX
+	tristate "Samsung S3C24XX SoC RTC"
+	depends on RTC_CLASS
+	help
+	  RTC (Realtime Clock) driver for the clock inbuilt into the
+	  Samsung S3C24XX series of SoCs. This can provide periodic
+	  interrupt rates from 1Hz to 64Hz for user programs, and
+	  wakeup from Alarm.
+	
+	  This driver can also be build as a module. If so, the module
+	  will be called rtc-s3c24xx.
+
 config RTC_DRV_M48T86
 	tristate "ST M48T86/Dallas DS12887"
 	depends on RTC_CLASS
--- linux-2.6.17/drivers/rtc/Makefile	2006-06-18 02:49:35.000000000 +0100
+++ linux-2.6.17-rc5-rtc1/drivers/rtc/Makefile	2006-06-01 14:24:04.000000000 +0100
@@ -16,6 +16,7 @@ obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
 obj-$(CONFIG_RTC_DRV_DS1672)	+= rtc-ds1672.o
 obj-$(CONFIG_RTC_DRV_PCF8563)	+= rtc-pcf8563.o
 obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o
+obj-$(CONFIG_RTC_DRV_S3C24XX)	+= rtc-s3c24xx.o
 obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t86.o
 obj-$(CONFIG_RTC_DRV_EP93XX)	+= rtc-ep93xx.o
 obj-$(CONFIG_RTC_DRV_SA1100)	+= rtc-sa1100.o
--- linux-2.6.17/drivers/rtc/rtc-s3c24xx.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc5-rtc1/drivers/rtc/rtc-s3c24xx.c	2006-06-19 11:30:34.000000000 +0100
@@ -0,0 +1,603 @@
+/* drivers/rtc/rtc-s3c24xx.c
+ *
+ * Copyright (c) 2004,2006 Simtec Electronics
+ *	Ben Dooks, <ben@simtec.co.uk>	
+ *	http://armlinux.simtec.co.uk/		      
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * S3C2410/S3C2440/S3C24XX Internal RTC Driver
+*/
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/string.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/rtc.h>
+#include <linux/bcd.h>
+#include <linux/clk.h>
+
+#include <asm/hardware.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/rtc.h>
+
+#include <asm/mach/time.h>
+
+#include <asm/arch/regs-rtc.h>
+
+#if 0
+/* need this for the RTC_AF definitions */
+#include <linux/mc146818rtc.h>
+#endif
+
+#undef S3C24XX_VA_RTC
+#define S3C24XX_VA_RTC s3c24xx_rtc_base
+
+static struct resource *s3c24xx_rtc_mem;
+
+static void __iomem *s3c24xx_rtc_base;
+static int s3c24xx_rtc_alarmno = NO_IRQ;
+static int s3c24xx_rtc_tickno  = NO_IRQ;
+static int s3c24xx_rtc_freq    = 1;
+
+static DEFINE_SPINLOCK(s3c24xx_rtc_pie_lock);
+
+/* IRQ Handlers */
+
+static irqreturn_t s3c24xx_rtc_alarmirq(int irq, void *id, struct pt_regs *r)
+{
+	struct rtc_device *rdev = id;
+
+	rtc_update_irq(&rdev->class_dev, 1, RTC_AF | RTC_IRQF);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t s3c24xx_rtc_tickirq(int irq, void *id, struct pt_regs *r)
+{
+	struct rtc_device *rdev = id;
+	static unsigned int count;
+
+	rtc_update_irq(&rdev->class_dev, count++, RTC_PF | RTC_IRQF);
+	return IRQ_HANDLED;
+}
+
+/* Update control registers */
+static void s3c24xx_rtc_setaie(int to)
+{
+	unsigned int tmp;
+
+	pr_debug("%s: aie=%d\n", __FUNCTION__, to);
+
+	tmp = readb(S3C2410_RTCALM) & ~S3C2410_RTCALM_ALMEN;
+
+	if (to)
+		tmp |= S3C2410_RTCALM_ALMEN;
+
+	writeb(tmp, S3C2410_RTCALM);
+}
+
+static void s3c24xx_rtc_setpie(int to)
+{
+	unsigned int tmp;
+
+	pr_debug("%s: pie=%d\n", __FUNCTION__, to);
+
+	spin_lock_irq(&s3c24xx_rtc_pie_lock);
+	tmp = readb(S3C2410_TICNT) & ~S3C2410_TICNT_ENABLE;
+
+	if (to)
+		tmp |= S3C2410_TICNT_ENABLE;
+
+	writeb(tmp, S3C2410_TICNT);
+	spin_unlock_irq(&s3c24xx_rtc_pie_lock);
+}
+
+static void s3c24xx_rtc_setfreq(int freq)
+{
+	unsigned int tmp;
+
+	spin_lock_irq(&s3c24xx_rtc_pie_lock);
+	tmp = readb(S3C2410_TICNT) & S3C2410_TICNT_ENABLE;
+
+	s3c24xx_rtc_freq = freq;
+
+	tmp |= (128 / freq)-1;
+
+	writeb(tmp, S3C2410_TICNT);
+	spin_unlock_irq(&s3c24xx_rtc_pie_lock);
+}
+
+/* Time read/write */
+
+static int s3c24xx_rtc_gettime(struct device *dev, struct rtc_time *rtc_tm)
+{
+	unsigned int have_retried = 0;
+
+ retry_get_time:
+	rtc_tm->tm_min  = readb(S3C2410_RTCMIN);
+	rtc_tm->tm_hour = readb(S3C2410_RTCHOUR);
+	rtc_tm->tm_mday = readb(S3C2410_RTCDATE);
+	rtc_tm->tm_mon  = readb(S3C2410_RTCMON);
+	rtc_tm->tm_year = readb(S3C2410_RTCYEAR);
+	rtc_tm->tm_sec  = readb(S3C2410_RTCSEC);
+
+	/* the only way to work out wether the system was mid-update
+	 * when we read it is to check the second counter, and if it
+	 * is zero, then we re-try the entire read
+	 */
+
+	if (rtc_tm->tm_sec == 0 && !have_retried) {
+		have_retried = 1;
+		goto retry_get_time;
+	}
+
+	pr_debug("read time %02x.%02x.%02x %02x/%02x/%02x\n",
+		 rtc_tm->tm_year, rtc_tm->tm_mon, rtc_tm->tm_mday,
+		 rtc_tm->tm_hour, rtc_tm->tm_min, rtc_tm->tm_sec);
+
+	BCD_TO_BIN(rtc_tm->tm_sec);
+	BCD_TO_BIN(rtc_tm->tm_min);
+	BCD_TO_BIN(rtc_tm->tm_hour);
+	BCD_TO_BIN(rtc_tm->tm_mday);
+	BCD_TO_BIN(rtc_tm->tm_mon);
+	BCD_TO_BIN(rtc_tm->tm_year);
+
+	rtc_tm->tm_year += 100;
+	rtc_tm->tm_mon -= 1;
+
+	return 0;
+}
+
+
+static int s3c24xx_rtc_settime(struct device *dev, struct rtc_time *tm)
+{
+	/* the rtc gets round the y2k problem by just not supporting it */
+
+	if (tm->tm_year < 100)
+		return -EINVAL;
+
+	writeb(BIN2BCD(tm->tm_sec),  S3C2410_RTCSEC);
+	writeb(BIN2BCD(tm->tm_min),  S3C2410_RTCMIN);
+	writeb(BIN2BCD(tm->tm_hour), S3C2410_RTCHOUR);
+	writeb(BIN2BCD(tm->tm_mday), S3C2410_RTCDATE);
+	writeb(BIN2BCD(tm->tm_mon + 1), S3C2410_RTCMON);
+	writeb(BIN2BCD(tm->tm_year - 100), S3C2410_RTCYEAR);
+
+	return 0;
+}
+
+static int s3c24xx_rtc_getalarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct rtc_time *alm_tm = &alrm->time;
+	unsigned int alm_en;
+
+	alm_tm->tm_sec  = readb(S3C2410_ALMSEC);
+	alm_tm->tm_min  = readb(S3C2410_ALMMIN);
+	alm_tm->tm_hour = readb(S3C2410_ALMHOUR);
+	alm_tm->tm_mon  = readb(S3C2410_ALMMON);
+	alm_tm->tm_mday = readb(S3C2410_ALMDATE);
+	alm_tm->tm_year = readb(S3C2410_ALMYEAR);
+
+	alm_en = readb(S3C2410_RTCALM);
+
+	pr_debug("read alarm %02x %02x.%02x.%02x %02x/%02x/%02x\n",
+		 alm_en,
+		 alm_tm->tm_year, alm_tm->tm_mon, alm_tm->tm_mday,
+		 alm_tm->tm_hour, alm_tm->tm_min, alm_tm->tm_sec);
+
+
+	/* decode the alarm enable field */
+
+	if (alm_en & S3C2410_RTCALM_SECEN) {
+		BCD_TO_BIN(alm_tm->tm_sec);
+	} else {
+		alm_tm->tm_sec = 0xff;
+	}
+
+	if (alm_en & S3C2410_RTCALM_MINEN) {
+		BCD_TO_BIN(alm_tm->tm_min);
+	} else {
+		alm_tm->tm_min = 0xff;
+	}
+
+	if (alm_en & S3C2410_RTCALM_HOUREN) {
+		BCD_TO_BIN(alm_tm->tm_hour);
+	} else {
+		alm_tm->tm_hour = 0xff;
+	}
+
+	if (alm_en & S3C2410_RTCALM_DAYEN) {
+		BCD_TO_BIN(alm_tm->tm_mday);
+	} else {
+		alm_tm->tm_mday = 0xff;
+	}
+
+	if (alm_en & S3C2410_RTCALM_MONEN) {
+		BCD_TO_BIN(alm_tm->tm_mon);
+		alm_tm->tm_mon -= 1;
+	} else {
+		alm_tm->tm_mon = 0xff;
+	}
+
+	if (alm_en & S3C2410_RTCALM_YEAREN) {
+		BCD_TO_BIN(alm_tm->tm_year);
+	} else {
+		alm_tm->tm_year = 0xffff;
+	}
+
+	/* todo - set alrm->enabled ? */
+	/* todo - set alrm->pending */
+
+	return 0;
+}
+
+static int s3c24xx_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct rtc_time *tm = &alrm->time;
+	unsigned int alrm_en;
+
+	pr_debug("s3c24xx_rtc_setalarm: %d, %02x/%02x/%02x %02x.%02x.%02x\n",
+		 alrm->enabled,
+		 tm->tm_mday & 0xff, tm->tm_mon & 0xff, tm->tm_year & 0xff,
+		 tm->tm_hour & 0xff, tm->tm_min & 0xff, tm->tm_sec);
+
+	if (alrm->enabled) {
+		alrm_en = readb(S3C2410_RTCALM) & S3C2410_RTCALM_ALMEN;
+		writeb(0x00, S3C2410_RTCALM);
+
+		if (tm->tm_sec < 60 && tm->tm_sec >= 0) {
+			alrm_en |= S3C2410_RTCALM_SECEN;
+			writeb(BIN2BCD(tm->tm_sec), S3C2410_ALMSEC);
+		}
+
+		if (tm->tm_min < 60 && tm->tm_min >= 0) {
+			alrm_en |= S3C2410_RTCALM_MINEN;
+			writeb(BIN2BCD(tm->tm_min), S3C2410_ALMMIN);
+		}
+
+		if (tm->tm_hour < 24 && tm->tm_hour >= 0) {
+			alrm_en |= S3C2410_RTCALM_HOUREN;
+			writeb(BIN2BCD(tm->tm_hour), S3C2410_ALMHOUR);
+		}
+
+		pr_debug("setting S3C2410_RTCALM to %08x\n", alrm_en);
+
+		writeb(alrm_en, S3C2410_RTCALM);
+		enable_irq_wake(s3c24xx_rtc_alarmno);
+	} else {
+		alrm_en = readb(S3C2410_RTCALM);
+		alrm_en &= ~S3C2410_RTCALM_ALMEN;
+		writeb(alrm_en, S3C2410_RTCALM);
+		disable_irq_wake(s3c24xx_rtc_alarmno);
+	}
+
+	return 0;
+}
+
+static int s3c24xx_rtc_ioctl(struct device *dev,
+			     unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case RTC_AIE_OFF:
+	case RTC_AIE_ON:
+		s3c24xx_rtc_setaie((cmd == RTC_AIE_ON) ? 1 : 0);
+		return 0;
+
+	case RTC_PIE_OFF:
+	case RTC_PIE_ON:
+		s3c24xx_rtc_setpie((cmd == RTC_PIE_ON) ? 1 : 0);
+		return 0;
+
+	case RTC_IRQP_READ:
+		return put_user(s3c24xx_rtc_freq, (unsigned long __user *)arg);
+
+	case RTC_IRQP_SET:
+		if (arg < 1 || arg > 64)
+			return -EINVAL;
+
+		if (!capable(CAP_SYS_RESOURCE))
+			return -EACCES;
+
+		/* check for power of 2 */
+
+		if ((arg & (arg-1)) != 0)
+			return -EINVAL;
+
+		pr_debug("s3c2410_rtc: setting frequency %ld\n", arg);
+
+		s3c24xx_rtc_setfreq(arg);
+		return 0;
+
+	case RTC_UIE_ON:
+	case RTC_UIE_OFF:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int s3c24xx_rtc_proc(struct device *dev, struct seq_file *seq)
+{
+	unsigned int rtcalm = readb(S3C2410_RTCALM);
+	unsigned int ticnt = readb (S3C2410_TICNT);
+
+	seq_printf(seq, "alarm_IRQ\t: %s\n",
+		   (rtcalm & S3C2410_RTCALM_ALMEN) ? "yes" : "no" );
+
+	seq_printf(seq, "periodic_IRQ\t: %s\n",
+		     (ticnt & S3C2410_TICNT_ENABLE) ? "yes" : "no" );
+
+	seq_printf(seq, "periodic_freq\t: %d\n", s3c24xx_rtc_freq);
+
+	return 0;
+}
+
+static int s3c24xx_rtc_open(struct device *dev)
+{
+	int ret;
+
+	ret = request_irq(s3c24xx_rtc_alarmno, s3c24xx_rtc_alarmirq,
+			  SA_INTERRUPT,  "s3c2410-rtc alarm", dev);
+
+	if (ret)
+		printk(KERN_ERR "IRQ%d already in use\n", s3c24xx_rtc_alarmno);
+
+	ret = request_irq(s3c24xx_rtc_tickno, s3c24xx_rtc_tickirq,
+			  SA_INTERRUPT,  "s3c2410-rtc tick", dev);
+
+	if (ret) {
+		printk(KERN_ERR "IRQ%d already in use\n", s3c24xx_rtc_tickno);
+		goto tick_err;
+	}
+
+	return ret;
+
+ tick_err:
+	free_irq(s3c24xx_rtc_alarmno, dev);
+	return ret;
+}
+
+static void s3c24xx_rtc_release(struct device *dev)
+{
+	/* do not clear AIE here, it may be needed for wake */
+
+	s3c24xx_rtc_setpie(0);
+	free_irq(s3c24xx_rtc_alarmno, dev);
+	free_irq(s3c24xx_rtc_tickno, dev);
+}
+
+static struct rtc_class_ops s3c24xx_rtcops = {
+	.open		= s3c24xx_rtc_open,
+	.release	= s3c24xx_rtc_release,
+	.ioctl		= s3c24xx_rtc_ioctl,
+	.read_time	= s3c24xx_rtc_gettime,
+	.set_time	= s3c24xx_rtc_settime,
+	.read_alarm	= s3c24xx_rtc_getalarm,
+	.set_alarm	= s3c24xx_rtc_setalarm,
+	.proc	        = s3c24xx_rtc_proc,
+};
+
+static void s3c24xx_rtc_enable(struct platform_device *pdev, int en)
+{
+	unsigned int tmp;
+
+	if (s3c24xx_rtc_base == NULL)
+		return;
+
+	if (!en) {
+		tmp = readb(S3C2410_RTCCON);
+		writeb(tmp & ~S3C2410_RTCCON_RTCEN, S3C2410_RTCCON);
+
+		tmp = readb(S3C2410_TICNT);
+		writeb(tmp & ~S3C2410_TICNT_ENABLE, S3C2410_TICNT);
+	} else {
+		/* re-enable the device, and check it is ok */
+
+		if ((readb(S3C2410_RTCCON) & S3C2410_RTCCON_RTCEN) == 0){
+			dev_info(&pdev->dev, "rtc disabled, re-enabling\n");
+
+			tmp = readb(S3C2410_RTCCON);
+			writeb(tmp | S3C2410_RTCCON_RTCEN , S3C2410_RTCCON);
+		}
+
+		if ((readb(S3C2410_RTCCON) & S3C2410_RTCCON_CNTSEL)){
+			dev_info(&pdev->dev, "removing S3C2410_RTCCON_CNTSEL\n");
+
+			tmp = readb(S3C2410_RTCCON);
+			writeb(tmp& ~S3C2410_RTCCON_CNTSEL , S3C2410_RTCCON);
+		}
+
+		if ((readb(S3C2410_RTCCON) & S3C2410_RTCCON_CLKRST)){
+			dev_info(&pdev->dev, "removing S3C2410_RTCCON_CLKRST\n");
+
+			tmp = readb(S3C2410_RTCCON);
+			writeb(tmp & ~S3C2410_RTCCON_CLKRST, S3C2410_RTCCON);
+		}
+	}
+}
+
+static int s3c24xx_rtc_remove(struct platform_device *dev)
+{
+	struct rtc_device *rtc = platform_get_drvdata(dev);
+
+	platform_set_drvdata(dev, NULL);
+	rtc_device_unregister(rtc);
+
+	s3c24xx_rtc_setpie(0);
+	s3c24xx_rtc_setaie(0);
+
+	iounmap(s3c24xx_rtc_base);
+	release_resource(s3c24xx_rtc_mem);
+	kfree(s3c24xx_rtc_mem);
+
+	return 0;
+}
+
+static int s3c24xx_rtc_probe(struct platform_device *pdev)
+{
+	struct rtc_device *rtc;
+	struct resource *res;
+	int ret;
+
+	pr_debug("%s: probe=%p\n", __FUNCTION__, pdev);
+
+	/* find the IRQs */
+
+	s3c24xx_rtc_tickno = platform_get_irq(pdev, 1);
+	if (s3c24xx_rtc_tickno < 0) {
+		dev_err(&pdev->dev, "no irq for rtc tick\n");
+		return -ENOENT;
+	}
+
+	s3c24xx_rtc_alarmno = platform_get_irq(pdev, 0);
+	if (s3c24xx_rtc_alarmno < 0) {
+		dev_err(&pdev->dev, "no irq for alarm\n");
+		return -ENOENT;
+	}
+
+	pr_debug("s3c2410_rtc: tick irq %d, alarm irq %d\n",
+		 s3c24xx_rtc_tickno, s3c24xx_rtc_alarmno);
+
+	/* get the memory region */
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "failed to get memory region resource\n");
+		return -ENOENT;
+	}
+
+	s3c24xx_rtc_mem = request_mem_region(res->start,
+					     res->end-res->start+1,
+					     pdev->name);
+
+	if (s3c24xx_rtc_mem == NULL) {
+		dev_err(&pdev->dev, "failed to reserve memory region\n");
+		ret = -ENOENT;
+		goto err_nores;
+	}
+
+	s3c24xx_rtc_base = ioremap(res->start, res->end - res->start + 1);
+	if (s3c24xx_rtc_base == NULL) {
+		dev_err(&pdev->dev, "failed ioremap()\n");
+		ret = -EINVAL;
+		goto err_nomap;
+	}
+
+	/* check to see if everything is setup correctly */
+
+	s3c24xx_rtc_enable(pdev, 1);
+
+ 	pr_debug("s3c2410_rtc: RTCCON=%02x\n", readb(S3C2410_RTCCON));
+
+	s3c24xx_rtc_setfreq(s3c24xx_rtc_freq);
+
+	/* register RTC and exit */
+
+	rtc = rtc_device_register("s3c24xx", &pdev->dev, &s3c24xx_rtcops,
+				  THIS_MODULE);
+
+	if (IS_ERR(rtc)) {
+		dev_err(&pdev->dev, "cannot attach rtc\n");
+		ret = PTR_ERR(rtc);
+		goto err_nortc;
+	}
+
+	platform_set_drvdata(pdev, rtc);
+	return 0;
+
+ err_nortc:
+	s3c24xx_rtc_enable(pdev, 0);
+	iounmap(s3c24xx_rtc_base);
+
+ err_nomap:
+	release_resource(s3c24xx_rtc_mem);
+
+ err_nores:
+	return ret;
+}
+
+#ifdef CONFIG_PM
+
+/* S3C2410 RTC Power management control */
+
+static struct timespec s3c24xx_rtc_delta;
+
+static int ticnt_save;
+
+static int s3c24xx_rtc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct rtc_time tm;
+	struct timespec time;
+
+	time.tv_nsec = 0;
+
+	/* save TICNT for anyone using periodic interrupts */
+
+	ticnt_save = readb(S3C2410_TICNT);
+
+	/* calculate time delta for suspend */
+
+	s3c24xx_rtc_gettime(&pdev->dev, &tm);
+	rtc_tm_to_time(&tm, &time.tv_sec);
+	save_time_delta(&s3c24xx_rtc_delta, &time);
+	s3c24xx_rtc_enable(pdev, 0);
+
+	return 0;
+}
+
+static int s3c24xx_rtc_resume(struct platform_device *pdev)
+{
+	struct rtc_time tm;
+	struct timespec time;
+
+	time.tv_nsec = 0;
+
+	s3c24xx_rtc_enable(pdev, 1);
+	s3c24xx_rtc_gettime(&pdev->dev, &tm);
+	rtc_tm_to_time(&tm, &time.tv_sec);
+	restore_time_delta(&s3c24xx_rtc_delta, &time);
+
+	writeb(ticnt_save, S3C2410_TICNT);
+	return 0;
+}
+#else
+#define s3c24xx_rtc_suspend NULL
+#define s3c24xx_rtc_resume  NULL
+#endif
+
+static struct platform_driver s3c2410_rtcdrv = {
+	.probe		= s3c24xx_rtc_probe,
+	.remove		= s3c24xx_rtc_remove,
+	.suspend	= s3c24xx_rtc_suspend,
+	.resume		= s3c24xx_rtc_resume,
+	.driver		= {
+		.name	= "s3c2410-rtc",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static char __initdata banner[] = "S3C24XX RTC, (c) 2004,2006 Simtec Electronics\n";
+
+static int __init s3c24xx_rtc_init(void)
+{
+	printk(banner);
+	return platform_driver_register(&s3c2410_rtcdrv);
+}
+
+static void __exit s3c24xx_rtc_exit(void)
+{
+	platform_driver_unregister(&s3c2410_rtcdrv);
+}
+
+module_init(s3c24xx_rtc_init);
+module_exit(s3c24xx_rtc_exit);
+
+MODULE_DESCRIPTION("S3C24XX RTC Driver");
+MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
+MODULE_LICENSE("GPL");
