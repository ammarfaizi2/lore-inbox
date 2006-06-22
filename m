Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbWFVPSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWFVPSX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 11:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWFVPSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 11:18:23 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:28382 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751822AbWFVPSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 11:18:22 -0400
Date: Fri, 23 Jun 2006 00:19:27 +0900 (JST)
Message-Id: <20060623.001927.74750182.anemo@mba.ocn.ne.jp>
To: linux-kernel@vger.kernel.org
Cc: a.zummo@towertech.it, akpm@osdl.org
Subject: [PATCH] RTC: add rtc-ds1553 and rtc-ds1742 driver
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add RTC drivers for the Dallas DS1553 and DS1742 RTC chip.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 65d090d..45a1f22 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -86,6 +86,16 @@ config RTC_DRV_X1205
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-x1205.
 
+config RTC_DRV_DS1553
+	tristate "Dallas DS1553"
+	depends on RTC_CLASS
+	help
+	  If you say yes here you get support for the
+	  Dallas DS1553 timekeeping chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-ds1553.
+
 config RTC_DRV_DS1672
 	tristate "Dallas/Maxim DS1672"
 	depends on RTC_CLASS && I2C
@@ -96,6 +106,16 @@ config RTC_DRV_DS1672
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ds1672.
 
+config RTC_DRV_DS1742
+	tristate "Dallas DS1742"
+	depends on RTC_CLASS
+	help
+	  If you say yes here you get support for the
+	  Dallas DS1742 timekeeping chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-ds1742.
+
 config RTC_DRV_PCF8563
 	tristate "Philips PCF8563/Epson RTC8564"
 	depends on RTC_CLASS && I2C
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index a9ca0f1..28c04aa 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -13,7 +13,9 @@ obj-$(CONFIG_RTC_INTF_DEV)	+= rtc-dev.o
 
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
+obj-$(CONFIG_RTC_DRV_DS1553)	+= rtc-ds1553.o
 obj-$(CONFIG_RTC_DRV_DS1672)	+= rtc-ds1672.o
+obj-$(CONFIG_RTC_DRV_DS1742)	+= rtc-ds1742.o
 obj-$(CONFIG_RTC_DRV_PCF8563)	+= rtc-pcf8563.o
 obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o
 obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t86.o
diff --git a/drivers/rtc/rtc-ds1553.c b/drivers/rtc/rtc-ds1553.c
new file mode 100644
index 0000000..168ba11
--- /dev/null
+++ b/drivers/rtc/rtc-ds1553.c
@@ -0,0 +1,415 @@
+/*
+ * An rtc driver for the Dallas DS1553
+ *
+ * Copyright (C) 2006 Atsushi Nemoto <anemo@mba.ocn.ne.jp>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/bcd.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/interrupt.h>
+#include <linux/rtc.h>
+#include <linux/platform_device.h>
+
+#define DRV_VERSION "0.1"
+
+#define RTC_REG_SIZE		0x2000
+#define RTC_OFFSET		0x1ff0
+
+#define RTC_FLAGS		(RTC_OFFSET + 0)
+#define RTC_SECONDS_ALARM	(RTC_OFFSET + 2)
+#define RTC_MINUTES_ALARM	(RTC_OFFSET + 3)
+#define RTC_HOURS_ALARM		(RTC_OFFSET + 4)
+#define RTC_DATE_ALARM		(RTC_OFFSET + 5)
+#define RTC_INTERRUPTS		(RTC_OFFSET + 6)
+#define RTC_WATCHDOG		(RTC_OFFSET + 7)
+#define RTC_CONTROL		(RTC_OFFSET + 8)
+#define RTC_CENTURY		(RTC_OFFSET + 8)
+#define RTC_SECONDS		(RTC_OFFSET + 9)
+#define RTC_MINUTES		(RTC_OFFSET + 10)
+#define RTC_HOURS		(RTC_OFFSET + 11)
+#define RTC_DAY			(RTC_OFFSET + 12)
+#define RTC_DATE		(RTC_OFFSET + 13)
+#define RTC_MONTH		(RTC_OFFSET + 14)
+#define RTC_YEAR		(RTC_OFFSET + 15)
+
+#define RTC_CENTURY_MASK	0x3f
+#define RTC_SECONDS_MASK	0x7f
+#define RTC_DAY_MASK		0x07
+
+/* Bits in the Control/Century register */
+#define RTC_WRITE		0x80
+#define RTC_READ		0x40
+
+/* Bits in the Seconds register */
+#define RTC_STOP		0x80
+
+/* Bits in the Flags register */
+#define RTC_FLAGS_AF		0x40
+#define RTC_FLAGS_BLF		0x10
+
+/* Bits in the Interrupts register */
+#define RTC_INTS_AE		0x80
+
+struct rtc_plat_data {
+	struct rtc_device *rtc;
+	void __iomem *ioaddr;
+	unsigned long baseaddr;
+	unsigned long last_jiffies;
+	int irq;
+	unsigned int irqen;
+	int alrm_sec;
+	int alrm_min;
+	int alrm_hour;
+	int alrm_mday;
+};
+
+static int ds1553_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	void __iomem *ioaddr = pdata->ioaddr;
+	u8 century;
+
+	century = BIN2BCD((tm->tm_year + 1900) / 100);
+
+	writeb(RTC_WRITE, pdata->ioaddr + RTC_CONTROL);
+
+	writeb(BIN2BCD(tm->tm_year % 100), ioaddr + RTC_YEAR);
+	writeb(BIN2BCD(tm->tm_mon + 1), ioaddr + RTC_MONTH);
+	writeb(BIN2BCD(tm->tm_wday) & RTC_DAY_MASK, ioaddr + RTC_DAY);
+	writeb(BIN2BCD(tm->tm_mday), ioaddr + RTC_DATE);
+	writeb(BIN2BCD(tm->tm_hour), ioaddr + RTC_HOURS);
+	writeb(BIN2BCD(tm->tm_min), ioaddr + RTC_MINUTES);
+	writeb(BIN2BCD(tm->tm_sec) & RTC_SECONDS_MASK, ioaddr + RTC_SECONDS);
+
+	/* RTC_CENTURY and RTC_CONTROL share same register */
+	writeb(RTC_WRITE | (century & RTC_CENTURY_MASK), ioaddr + RTC_CENTURY);
+	writeb(century & RTC_CENTURY_MASK, ioaddr + RTC_CONTROL);
+	return 0;
+}
+
+static int ds1553_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	void __iomem *ioaddr = pdata->ioaddr;
+	unsigned int year, month, day, hour, minute, second, week;
+	unsigned int century;
+
+	/* give enough time to update RTC in case of continuous read */
+	if (pdata->last_jiffies == jiffies)
+		msleep(1);
+	pdata->last_jiffies = jiffies;
+	writeb(RTC_READ, ioaddr + RTC_CONTROL);
+	second = readb(ioaddr + RTC_SECONDS) & RTC_SECONDS_MASK;
+	minute = readb(ioaddr + RTC_MINUTES);
+	hour = readb(ioaddr + RTC_HOURS);
+	day = readb(ioaddr + RTC_DATE);
+	week = readb(ioaddr + RTC_DAY) & RTC_DAY_MASK;
+	month = readb(ioaddr + RTC_MONTH);
+	year = readb(ioaddr + RTC_YEAR);
+	century = readb(ioaddr + RTC_CENTURY) & RTC_CENTURY_MASK;
+	writeb(0, ioaddr + RTC_CONTROL);
+	tm->tm_sec = BCD2BIN(second);
+	tm->tm_min = BCD2BIN(minute);
+	tm->tm_hour = BCD2BIN(hour);
+	tm->tm_mday = BCD2BIN(day);
+	tm->tm_wday = BCD2BIN(week);
+	tm->tm_mon = BCD2BIN(month) - 1;
+	/* year is 1900 + tm->tm_year */
+	tm->tm_year = BCD2BIN(year) + BCD2BIN(century) * 100 - 1900;
+
+	if (rtc_valid_tm(tm) < 0) {
+		dev_err(dev, "retrieved date/time is not valid.\n");
+		rtc_time_to_tm(0, tm);
+	}
+	return 0;
+}
+
+static void ds1553_rtc_update_alarm(struct rtc_plat_data *pdata)
+{
+	void __iomem *ioaddr = pdata->ioaddr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdata->rtc->irq_lock, flags);
+	writeb(pdata->alrm_mday < 0 || (pdata->irqen & RTC_UF) ?
+	       0x80 : BIN2BCD(pdata->alrm_mday),
+	       ioaddr + RTC_DATE_ALARM);
+	writeb(pdata->alrm_hour < 0 || (pdata->irqen & RTC_UF) ?
+	       0x80 : BIN2BCD(pdata->alrm_hour),
+	       ioaddr + RTC_HOURS_ALARM);
+	writeb(pdata->alrm_min < 0 || (pdata->irqen & RTC_UF) ?
+	       0x80 : BIN2BCD(pdata->alrm_min),
+	       ioaddr + RTC_MINUTES_ALARM);
+	writeb(pdata->alrm_sec < 0 || (pdata->irqen & RTC_UF) ?
+	       0x80 : BIN2BCD(pdata->alrm_sec),
+	       ioaddr + RTC_SECONDS_ALARM);
+	writeb(pdata->irqen ? RTC_INTS_AE : 0, ioaddr + RTC_INTERRUPTS);
+	readb(ioaddr + RTC_FLAGS);	/* clear interrupts */
+	spin_unlock_irqrestore(&pdata->rtc->irq_lock, flags);
+}
+
+static int ds1553_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+
+	if (pdata->irq < 0)
+		return -EINVAL;
+	pdata->alrm_mday = alrm->time.tm_mday;
+	pdata->alrm_hour = alrm->time.tm_hour;
+	pdata->alrm_min = alrm->time.tm_min;
+	pdata->alrm_sec = alrm->time.tm_sec;
+	if (alrm->enabled)
+		pdata->irqen |= RTC_AF;
+	ds1553_rtc_update_alarm(pdata);
+	return 0;
+}
+
+static int ds1553_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+
+	if (pdata->irq < 0)
+		return -EINVAL;
+	alrm->time.tm_mday = pdata->alrm_mday < 0 ? 0 : pdata->alrm_mday;
+	alrm->time.tm_hour = pdata->alrm_hour < 0 ? 0 : pdata->alrm_hour;
+	alrm->time.tm_min = pdata->alrm_min < 0 ? 0 : pdata->alrm_min;
+	alrm->time.tm_sec = pdata->alrm_sec < 0 ? 0 : pdata->alrm_sec;
+	alrm->enabled = (pdata->irqen & RTC_AF) ? 1 : 0;
+	return 0;
+}
+
+static irqreturn_t ds1553_rtc_interrupt(int irq, void *dev_id,
+					struct pt_regs *regs)
+{
+	struct platform_device *pdev = dev_id;
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	void __iomem *ioaddr = pdata->ioaddr;
+	unsigned long events = RTC_IRQF;
+
+	/* read and clear interrupt */
+	if (!(readb(ioaddr + RTC_FLAGS) & RTC_FLAGS_AF))
+		return IRQ_NONE;
+	if (readb(ioaddr + RTC_SECONDS_ALARM) & 0x80)
+		events |= RTC_UF;
+	else
+		events |= RTC_AF;
+	rtc_update_irq(&pdata->rtc->class_dev, 1, events);
+	return IRQ_HANDLED;
+}
+
+static void ds1553_rtc_release(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+
+	if (pdata->irq >= 0) {
+		pdata->irqen = 0;
+		ds1553_rtc_update_alarm(pdata);
+	}
+}
+
+static int ds1553_rtc_ioctl(struct device *dev, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+
+	if (pdata->irq < 0)
+		return -ENOIOCTLCMD;
+	switch (cmd) {
+	case RTC_AIE_OFF:
+		pdata->irqen &= ~RTC_AF;
+		ds1553_rtc_update_alarm(pdata);
+		break;
+	case RTC_AIE_ON:
+		pdata->irqen |= RTC_AF;
+		ds1553_rtc_update_alarm(pdata);
+		break;
+	case RTC_UIE_OFF:
+		pdata->irqen &= ~RTC_UF;
+		ds1553_rtc_update_alarm(pdata);
+		break;
+	case RTC_UIE_ON:
+		pdata->irqen |= RTC_UF;
+		ds1553_rtc_update_alarm(pdata);
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+	return 0;
+}
+
+static struct rtc_class_ops ds1553_rtc_ops = {
+	.read_time	= ds1553_rtc_read_time,
+	.set_time	= ds1553_rtc_set_time,
+	.read_alarm	= ds1553_rtc_read_alarm,
+	.set_alarm	= ds1553_rtc_set_alarm,
+	.release	= ds1553_rtc_release,
+	.ioctl		= ds1553_rtc_ioctl,
+};
+
+static ssize_t ds1553_nvram_read(struct kobject *kobj, char *buf,
+				 loff_t pos, size_t size)
+{
+	struct platform_device *pdev =
+		to_platform_device(container_of(kobj, struct device, kobj));
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	void __iomem *ioaddr = pdata->ioaddr;
+	ssize_t count;
+
+	for (count = 0; size > 0 && pos < RTC_OFFSET; count++, size--) {
+		*buf++ = readb(ioaddr + pos++);
+	}
+	return count;
+}
+
+static ssize_t ds1553_nvram_write(struct kobject *kobj, char *buf,
+				  loff_t pos, size_t size)
+{
+	struct platform_device *pdev =
+		to_platform_device(container_of(kobj, struct device, kobj));
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	void __iomem *ioaddr = pdata->ioaddr;
+	ssize_t count;
+
+	for (count = 0; size > 0 && pos < RTC_OFFSET; count++, size--) {
+		writeb(*buf++, ioaddr + pos++);
+	}
+	return count;
+}
+
+static struct bin_attribute ds1553_nvram_attr = {
+	.attr = {
+		.name = "nvram",
+		.mode = S_IRUGO | S_IWUGO,
+		.owner = THIS_MODULE,
+	},
+	.size = RTC_OFFSET,
+	.read = ds1553_nvram_read,
+	.write = ds1553_nvram_write,
+};
+
+static int __init ds1553_rtc_probe(struct platform_device *pdev)
+{
+	struct rtc_device *rtc;
+	struct resource *res;
+	unsigned int cen, sec;
+	struct rtc_plat_data *pdata = NULL;
+	void __iomem *ioaddr = NULL;
+	int ret = 0;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+	pdata->irq = -1;
+	if (!request_mem_region(res->start, RTC_REG_SIZE, pdev->name)) {
+		ret = -EBUSY;
+		goto out;
+	}
+	pdata->baseaddr = res->start;
+	ioaddr = ioremap(pdata->baseaddr, RTC_REG_SIZE);
+	if (!ioaddr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	pdata->ioaddr = ioaddr;
+	pdata->irq = platform_get_irq(pdev, 0);
+
+	/* turn RTC on if it was not on */
+	sec = readb(ioaddr + RTC_SECONDS);
+	if (sec & RTC_STOP) {
+		sec &= RTC_SECONDS_MASK;
+		cen = readb(ioaddr + RTC_CENTURY) & RTC_CENTURY_MASK;
+		writeb(RTC_WRITE, ioaddr + RTC_CONTROL);
+		writeb(sec, ioaddr + RTC_SECONDS);
+		writeb(cen & RTC_CENTURY_MASK, ioaddr + RTC_CONTROL);
+	}
+	if (readb(ioaddr + RTC_FLAGS) & RTC_FLAGS_BLF)
+		dev_warn(&pdev->dev, "voltage-low detected.\n");
+
+	if (pdata->irq >= 0) {
+		writeb(0, ioaddr + RTC_INTERRUPTS);
+		if (request_irq(pdata->irq, ds1553_rtc_interrupt, SA_SHIRQ,
+				pdev->name, pdev) < 0) {
+			dev_warn(&pdev->dev, "interrupt not available.\n");
+			pdata->irq = -1;
+		}
+	}
+
+	rtc = rtc_device_register(pdev->name, &pdev->dev,
+				  &ds1553_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc)) {
+		ret = PTR_ERR(rtc);
+		goto out;
+	}
+	pdata->rtc = rtc;
+	pdata->last_jiffies = jiffies;
+	platform_set_drvdata(pdev, pdata);
+	sysfs_create_bin_file(&pdev->dev.kobj, &ds1553_nvram_attr);
+	return 0;
+ out:
+	if (pdata->irq >= 0)
+		free_irq(pdata->irq, pdev);
+	if (ioaddr)
+		iounmap(ioaddr);
+	if (pdata->baseaddr)
+		release_mem_region(pdata->baseaddr, RTC_REG_SIZE);
+	kfree(pdata);
+	return ret;
+}
+
+static int __devexit ds1553_rtc_remove(struct platform_device *pdev)
+{
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+
+	sysfs_remove_bin_file(&pdev->dev.kobj, &ds1553_nvram_attr);
+	rtc_device_unregister(pdata->rtc);
+	if (pdata->irq >= 0) {
+		writeb(0, pdata->ioaddr + RTC_INTERRUPTS);
+		free_irq(pdata->irq, pdev);
+	}
+	iounmap(pdata->ioaddr);
+	release_mem_region(pdata->baseaddr, RTC_REG_SIZE);
+	kfree(pdata);
+	return 0;
+}
+
+static struct platform_driver ds1553_rtc_driver = {
+	.probe		= ds1553_rtc_probe,
+	.remove		= __devexit_p(ds1553_rtc_remove),
+	.driver		= {
+		.name	= "ds1553",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static __init int ds1553_init(void)
+{
+	return platform_driver_register(&ds1553_rtc_driver);
+}
+
+static __exit void ds1553_exit(void)
+{
+	return platform_driver_unregister(&ds1553_rtc_driver);
+}
+
+module_init(ds1553_init);
+module_exit(ds1553_exit);
+
+MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
+MODULE_DESCRIPTION("Dallas DS1553 RTC driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/rtc/rtc-ds1742.c b/drivers/rtc/rtc-ds1742.c
new file mode 100644
index 0000000..41b03a0
--- /dev/null
+++ b/drivers/rtc/rtc-ds1742.c
@@ -0,0 +1,260 @@
+/*
+ * An rtc driver for the Dallas DS1742
+ *
+ * Copyright (C) 2006 Atsushi Nemoto <anemo@mba.ocn.ne.jp>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/bcd.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/rtc.h>
+#include <linux/platform_device.h>
+
+#define DRV_VERSION "0.1"
+
+#define RTC_REG_SIZE		0x800
+#define RTC_OFFSET		0x7f8
+
+#define RTC_CONTROL		(RTC_OFFSET + 0)
+#define RTC_CENTURY		(RTC_OFFSET + 0)
+#define RTC_SECONDS		(RTC_OFFSET + 1)
+#define RTC_MINUTES		(RTC_OFFSET + 2)
+#define RTC_HOURS		(RTC_OFFSET + 3)
+#define RTC_DAY			(RTC_OFFSET + 4)
+#define RTC_DATE		(RTC_OFFSET + 5)
+#define RTC_MONTH		(RTC_OFFSET + 6)
+#define RTC_YEAR		(RTC_OFFSET + 7)
+
+#define RTC_CENTURY_MASK	0x3f
+#define RTC_SECONDS_MASK	0x7f
+#define RTC_DAY_MASK		0x07
+
+/* Bits in the Control/Century register */
+#define RTC_WRITE		0x80
+#define RTC_READ		0x40
+
+/* Bits in the Seconds register */
+#define RTC_STOP		0x80
+
+/* Bits in the Day register */
+#define RTC_BATT_FLAG		0x80
+
+struct rtc_plat_data {
+	struct rtc_device *rtc;
+	void __iomem *ioaddr;
+	unsigned long baseaddr;
+	unsigned long last_jiffies;
+};
+
+static int ds1742_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	void __iomem *ioaddr = pdata->ioaddr;
+	u8 century;
+
+	century = BIN2BCD((tm->tm_year + 1900) / 100);
+
+	writeb(RTC_WRITE, ioaddr + RTC_CONTROL);
+
+	writeb(BIN2BCD(tm->tm_year % 100), ioaddr + RTC_YEAR);
+	writeb(BIN2BCD(tm->tm_mon + 1), ioaddr + RTC_MONTH);
+	writeb(BIN2BCD(tm->tm_wday) & RTC_DAY_MASK, ioaddr + RTC_DAY);
+	writeb(BIN2BCD(tm->tm_mday), ioaddr + RTC_DATE);
+	writeb(BIN2BCD(tm->tm_hour), ioaddr + RTC_HOURS);
+	writeb(BIN2BCD(tm->tm_min), ioaddr + RTC_MINUTES);
+	writeb(BIN2BCD(tm->tm_sec) & RTC_SECONDS_MASK, ioaddr + RTC_SECONDS);
+
+	/* RTC_CENTURY and RTC_CONTROL share same register */
+	writeb(RTC_WRITE | (century & RTC_CENTURY_MASK), ioaddr + RTC_CENTURY);
+	writeb(century & RTC_CENTURY_MASK, ioaddr + RTC_CONTROL);
+	return 0;
+}
+
+static int ds1742_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	void __iomem *ioaddr = pdata->ioaddr;
+	unsigned int year, month, day, hour, minute, second, week;
+	unsigned int century;
+
+	/* give enough time to update RTC in case of continuous read */
+	if (pdata->last_jiffies == jiffies)
+		msleep(1);
+	pdata->last_jiffies = jiffies;
+	writeb(RTC_READ, ioaddr + RTC_CONTROL);
+	second = readb(ioaddr + RTC_SECONDS) & RTC_SECONDS_MASK;
+	minute = readb(ioaddr + RTC_MINUTES);
+	hour = readb(ioaddr + RTC_HOURS);
+	day = readb(ioaddr + RTC_DATE);
+	week = readb(ioaddr + RTC_DAY) & RTC_DAY_MASK;
+	month = readb(ioaddr + RTC_MONTH);
+	year = readb(ioaddr + RTC_YEAR);
+	century = readb(ioaddr + RTC_CENTURY) & RTC_CENTURY_MASK;
+	writeb(0, ioaddr + RTC_CONTROL);
+	tm->tm_sec = BCD2BIN(second);
+	tm->tm_min = BCD2BIN(minute);
+	tm->tm_hour = BCD2BIN(hour);
+	tm->tm_mday = BCD2BIN(day);
+	tm->tm_wday = BCD2BIN(week);
+	tm->tm_mon = BCD2BIN(month) - 1;
+	/* year is 1900 + tm->tm_year */
+	tm->tm_year = BCD2BIN(year) + BCD2BIN(century) * 100 - 1900;
+
+	if (rtc_valid_tm(tm) < 0) {
+		dev_err(dev, "retrieved date/time is not valid.\n");
+		rtc_time_to_tm(0, tm);
+	}
+	return 0;
+}
+
+static struct rtc_class_ops ds1742_rtc_ops = {
+	.read_time	= ds1742_rtc_read_time,
+	.set_time	= ds1742_rtc_set_time,
+};
+
+static ssize_t ds1742_nvram_read(struct kobject *kobj, char *buf,
+				 loff_t pos, size_t size)
+{
+	struct platform_device *pdev =
+		to_platform_device(container_of(kobj, struct device, kobj));
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	void __iomem *ioaddr = pdata->ioaddr;
+	ssize_t count;
+
+	for (count = 0; size > 0 && pos < RTC_OFFSET; count++, size--) {
+		*buf++ = readb(ioaddr + pos++);
+	}
+	return count;
+}
+
+static ssize_t ds1742_nvram_write(struct kobject *kobj, char *buf,
+				  loff_t pos, size_t size)
+{
+	struct platform_device *pdev =
+		to_platform_device(container_of(kobj, struct device, kobj));
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+	void __iomem *ioaddr = pdata->ioaddr;
+	ssize_t count;
+
+	for (count = 0; size > 0 && pos < RTC_OFFSET; count++, size--) {
+		writeb(*buf++, ioaddr + pos++);
+	}
+	return count;
+}
+
+static struct bin_attribute ds1742_nvram_attr = {
+	.attr = {
+		.name = "nvram",
+		.mode = S_IRUGO | S_IWUGO,
+		.owner = THIS_MODULE,
+	},
+	.size = RTC_OFFSET,
+	.read = ds1742_nvram_read,
+	.write = ds1742_nvram_write,
+};
+
+static int __init ds1742_rtc_probe(struct platform_device *pdev)
+{
+	struct rtc_device *rtc;
+	struct resource *res;
+	unsigned int cen, sec;
+	struct rtc_plat_data *pdata = NULL;
+	void __iomem *ioaddr = NULL;
+	int ret = 0;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+	if (!request_mem_region(res->start, RTC_REG_SIZE, pdev->name)) {
+		ret = -EBUSY;
+		goto out;
+	}
+	pdata->baseaddr = res->start;
+	ioaddr = ioremap(pdata->baseaddr, RTC_REG_SIZE);
+	if (!ioaddr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	pdata->ioaddr = ioaddr;
+
+	/* turn RTC on if it was not on */
+	sec = readb(ioaddr + RTC_SECONDS);
+	if (sec & RTC_STOP) {
+		sec &= RTC_SECONDS_MASK;
+		cen = readb(ioaddr + RTC_CENTURY) & RTC_CENTURY_MASK;
+		writeb(RTC_WRITE, ioaddr + RTC_CONTROL);
+		writeb(sec, ioaddr + RTC_SECONDS);
+		writeb(cen & RTC_CENTURY_MASK, ioaddr + RTC_CONTROL);
+	}
+	if (readb(ioaddr + RTC_DAY) & RTC_BATT_FLAG)
+		dev_warn(&pdev->dev, "voltage-low detected.\n");
+
+	rtc = rtc_device_register(pdev->name, &pdev->dev,
+				  &ds1742_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc)) {
+		ret = PTR_ERR(rtc);
+		goto out;
+	}
+	pdata->rtc = rtc;
+	pdata->last_jiffies = jiffies;
+	platform_set_drvdata(pdev, pdata);
+	sysfs_create_bin_file(&pdev->dev.kobj, &ds1742_nvram_attr);
+	return 0;
+ out:
+	if (ioaddr)
+		iounmap(ioaddr);
+	if (pdata->baseaddr)
+		release_mem_region(pdata->baseaddr, RTC_REG_SIZE);
+	kfree(pdata);
+	return ret;
+}
+
+static int __devexit ds1742_rtc_remove(struct platform_device *pdev)
+{
+	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
+
+	sysfs_remove_bin_file(&pdev->dev.kobj, &ds1742_nvram_attr);
+	rtc_device_unregister(pdata->rtc);
+	iounmap(pdata->ioaddr);
+	release_mem_region(pdata->baseaddr, RTC_REG_SIZE);
+	kfree(pdata);
+	return 0;
+}
+
+static struct platform_driver ds1742_rtc_driver = {
+	.probe		= ds1742_rtc_probe,
+	.remove		= __devexit_p(ds1742_rtc_remove),
+	.driver		= {
+		.name	= "ds1742",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static __init int ds1742_init(void)
+{
+	return platform_driver_register(&ds1742_rtc_driver);
+}
+
+static __exit void ds1742_exit(void)
+{
+	return platform_driver_unregister(&ds1742_rtc_driver);
+}
+
+module_init(ds1742_init);
+module_exit(ds1742_exit);
+
+MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
+MODULE_DESCRIPTION("Dallas DS1742 RTC driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
