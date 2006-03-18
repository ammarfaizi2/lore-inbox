Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWCRRWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWCRRWQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 12:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWCRRWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 12:22:09 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:15349 "EHLO
	linux") by vger.kernel.org with ESMTP id S1750762AbWCRRV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 12:21:28 -0500
Message-Id: <20060318171950.226152000@towertech.it>
References: <20060318171946.821316000@towertech.it>
User-Agent: quilt/0.43-1
Date: Sat, 18 Mar 2006 18:20:04 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au
Subject: [PATCH 18/18] RTC subsystem, M48T86 driver
Content-Disposition: inline; filename=rtc-drv-m48t86.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a driver for the 
ST M48T86 / Dallas DS12887 RTC.

This is a platform driver. The platform device must
provide I/O routines to access the RTC.

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>

---
 drivers/rtc/Kconfig      |   10 ++
 drivers/rtc/Makefile     |    1 
 drivers/rtc/rtc-m48t86.c |  209 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/m48t86.h   |   16 +++
 4 files changed, 236 insertions(+)

--- linux-rtc.orig/drivers/rtc/Kconfig	2006-03-13 03:48:42.000000000 +0100
+++ linux-rtc/drivers/rtc/Kconfig	2006-03-13 03:48:42.000000000 +0100
@@ -117,6 +117,16 @@ config RTC_DRV_RS5C372
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-rs5c372.
 
+config RTC_DRV_M48T86
+	tristate "ST M48T86/Dallas DS12887"
+	depends on RTC_CLASS
+	help
+	  If you say Y here you will get support for the
+	  ST M48T86 and Dallas DS12887 RTC chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-m48t86.
+
 config RTC_DRV_EP93XX
 	tristate "Cirrus Logic EP93XX"
 	depends on RTC_CLASS && ARCH_EP93XX
--- linux-rtc.orig/drivers/rtc/Makefile	2006-03-13 03:48:42.000000000 +0100
+++ linux-rtc/drivers/rtc/Makefile	2006-03-13 03:48:42.000000000 +0100
@@ -16,5 +16,6 @@ obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
 obj-$(CONFIG_RTC_DRV_DS1672)	+= rtc-ds1672.o
 obj-$(CONFIG_RTC_DRV_PCF8563)	+= rtc-pcf8563.o
 obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o
+obj-$(CONFIG_RTC_DRV_M48T86)	+= rtc-m48t86.o
 obj-$(CONFIG_RTC_DRV_EP93XX)	+= rtc-ep93xx.o
 obj-$(CONFIG_RTC_DRV_SA1100)	+= rtc-sa1100.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-rtc/drivers/rtc/rtc-m48t86.c	2006-03-13 03:50:48.000000000 +0100
@@ -0,0 +1,209 @@
+/*
+ * ST M48T86 / Dallas DS12887 RTC driver
+ * Copyright (c) 2006 Tower Technologies
+ *
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This drivers only supports the clock running in BCD and 24H mode.
+ * If it will be ever adapted to binary and 12H mode, care must be taken
+ * to not introduce bugs.
+ */
+
+#include <linux/module.h>
+#include <linux/rtc.h>
+#include <linux/platform_device.h>
+#include <linux/m48t86.h>
+#include <linux/bcd.h>
+
+#define M48T86_REG_SEC		0x00
+#define M48T86_REG_SECALRM	0x01
+#define M48T86_REG_MIN		0x02
+#define M48T86_REG_MINALRM	0x03
+#define M48T86_REG_HOUR	0x04
+#define M48T86_REG_HOURALRM	0x05
+#define M48T86_REG_DOW		0x06 /* 1 = sunday */
+#define M48T86_REG_DOM		0x07
+#define M48T86_REG_MONTH	0x08 /* 1 - 12 */
+#define M48T86_REG_YEAR		0x09 /* 0 - 99 */
+#define M48T86_REG_A		0x0A
+#define M48T86_REG_B		0x0B
+#define M48T86_REG_C		0x0C
+#define M48T86_REG_D		0x0D
+
+#define M48T86_REG_B_H24	(1 << 1)
+#define M48T86_REG_B_DM		(1 << 2)
+#define M48T86_REG_B_SET	(1 << 7)
+#define M48T86_REG_D_VRT	(1 << 7)
+
+#define DRV_VERSION "0.1"
+
+
+static int m48t86_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned char reg;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct m48t86_ops *ops = pdev->dev.platform_data;
+
+	reg = ops->readb(M48T86_REG_B);
+
+	if (reg & M48T86_REG_B_DM) {
+		/* data (binary) mode */
+		tm->tm_sec	= ops->readb(M48T86_REG_SEC);
+		tm->tm_min	= ops->readb(M48T86_REG_MIN);
+		tm->tm_hour	= ops->readb(M48T86_REG_HOUR) & 0x3F;
+		tm->tm_mday	= ops->readb(M48T86_REG_DOM);
+		/* tm_mon is 0-11 */
+		tm->tm_mon	= ops->readb(M48T86_REG_MONTH) - 1;
+		tm->tm_year	= ops->readb(M48T86_REG_YEAR) + 100;
+		tm->tm_wday	= ops->readb(M48T86_REG_DOW);
+	} else {
+		/* bcd mode */
+		tm->tm_sec	= BCD2BIN(ops->readb(M48T86_REG_SEC));
+		tm->tm_min	= BCD2BIN(ops->readb(M48T86_REG_MIN));
+		tm->tm_hour	= BCD2BIN(ops->readb(M48T86_REG_HOUR) & 0x3F);
+		tm->tm_mday	= BCD2BIN(ops->readb(M48T86_REG_DOM));
+		/* tm_mon is 0-11 */
+		tm->tm_mon	= BCD2BIN(ops->readb(M48T86_REG_MONTH)) - 1;
+		tm->tm_year	= BCD2BIN(ops->readb(M48T86_REG_YEAR)) + 100;
+		tm->tm_wday	= BCD2BIN(ops->readb(M48T86_REG_DOW));
+	}
+
+	/* correct the hour if the clock is in 12h mode */
+	if (!(reg & M48T86_REG_B_H24))
+		if (ops->readb(M48T86_REG_HOUR) & 0x80)
+			tm->tm_hour += 12;
+
+	return 0;
+}
+
+static int m48t86_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned char reg;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct m48t86_ops *ops = pdev->dev.platform_data;
+
+	reg = ops->readb(M48T86_REG_B);
+
+	/* update flag and 24h mode */
+	reg |= M48T86_REG_B_SET | M48T86_REG_B_H24;
+	ops->writeb(reg, M48T86_REG_B);
+
+	if (reg & M48T86_REG_B_DM) {
+		/* data (binary) mode */
+		ops->writeb(tm->tm_sec, M48T86_REG_SEC);
+		ops->writeb(tm->tm_min, M48T86_REG_MIN);
+		ops->writeb(tm->tm_hour, M48T86_REG_HOUR);
+		ops->writeb(tm->tm_mday, M48T86_REG_DOM);
+		ops->writeb(tm->tm_mon + 1, M48T86_REG_MONTH);
+		ops->writeb(tm->tm_year % 100, M48T86_REG_YEAR);
+		ops->writeb(tm->tm_wday, M48T86_REG_DOW);
+	} else {
+		/* bcd mode */
+		ops->writeb(BIN2BCD(tm->tm_sec), M48T86_REG_SEC);
+		ops->writeb(BIN2BCD(tm->tm_min), M48T86_REG_MIN);
+		ops->writeb(BIN2BCD(tm->tm_hour), M48T86_REG_HOUR);
+		ops->writeb(BIN2BCD(tm->tm_mday), M48T86_REG_DOM);
+		ops->writeb(BIN2BCD(tm->tm_mon + 1), M48T86_REG_MONTH);
+		ops->writeb(BIN2BCD(tm->tm_year % 100), M48T86_REG_YEAR);
+		ops->writeb(BIN2BCD(tm->tm_wday), M48T86_REG_DOW);
+	}
+
+	/* update ended */
+	reg &= ~M48T86_REG_B_SET;
+	ops->writeb(reg, M48T86_REG_B);
+
+	return 0;
+}
+
+static int m48t86_rtc_proc(struct device *dev, struct seq_file *seq)
+{
+	unsigned char reg;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct m48t86_ops *ops = pdev->dev.platform_data;
+
+	reg = ops->readb(M48T86_REG_B);
+
+	seq_printf(seq, "24hr\t\t: %s\n",
+		 (reg & M48T86_REG_B_H24) ? "yes" : "no");
+
+	seq_printf(seq, "mode\t\t: %s\n",
+		 (reg & M48T86_REG_B_DM) ? "binary" : "bcd");
+
+	reg = ops->readb(M48T86_REG_D);
+
+	seq_printf(seq, "battery\t\t: %s\n",
+		 (reg & M48T86_REG_D_VRT) ? "ok" : "exhausted");
+
+	return 0;
+}
+
+static struct rtc_class_ops m48t86_rtc_ops = {
+	.read_time	= m48t86_rtc_read_time,
+	.set_time	= m48t86_rtc_set_time,
+	.proc		= m48t86_rtc_proc,
+};
+
+static int __devinit m48t86_rtc_probe(struct platform_device *dev)
+{
+	unsigned char reg;
+	struct m48t86_ops *ops = dev->dev.platform_data;
+	struct rtc_device *rtc = rtc_device_register("m48t86",
+				&dev->dev, &m48t86_rtc_ops, THIS_MODULE);
+
+	if (IS_ERR(rtc)) {
+		dev_err(&dev->dev, "unable to register\n");
+		return PTR_ERR(rtc);
+	}
+
+	platform_set_drvdata(dev, rtc);
+
+	/* read battery status */
+	reg = ops->readb(M48T86_REG_D);
+	dev_info(&dev->dev, "battery %s\n",
+		(reg & M48T86_REG_D_VRT) ? "ok" : "exhausted");
+
+	return 0;
+}
+
+static int __devexit m48t86_rtc_remove(struct platform_device *dev)
+{
+	struct rtc_device *rtc = platform_get_drvdata(dev);
+
+ 	if (rtc)
+		rtc_device_unregister(rtc);
+
+	platform_set_drvdata(dev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver m48t86_rtc_platform_driver = {
+	.driver		= {
+		.name	= "rtc-m48t86",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= m48t86_rtc_probe,
+	.remove		= __devexit_p(m48t86_rtc_remove),
+};
+
+static int __init m48t86_rtc_init(void)
+{
+	return platform_driver_register(&m48t86_rtc_platform_driver);
+}
+
+static void __exit m48t86_rtc_exit(void)
+{
+	platform_driver_unregister(&m48t86_rtc_platform_driver);
+}
+
+MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
+MODULE_DESCRIPTION("M48T86 RTC driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
+module_init(m48t86_rtc_init);
+module_exit(m48t86_rtc_exit);
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-rtc/include/linux/m48t86.h	2006-03-13 03:49:42.000000000 +0100
@@ -0,0 +1,16 @@
+/*
+ * ST M48T86 / Dallas DS12887 RTC driver
+ * Copyright (c) 2006 Tower Technologies
+ *
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+struct m48t86_ops
+{
+	void (*writeb)(unsigned char value, unsigned long addr);
+	unsigned char (*readb)(unsigned long addr);
+};

--
