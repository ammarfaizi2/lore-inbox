Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWCFByz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWCFByz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 20:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWCFBxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 20:53:40 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:55679 "EHLO
	linux") by vger.kernel.org with ESMTP id S1751596AbWCFBxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 20:53:18 -0500
Message-Id: <20060306015011.779620000@towertech.it>
References: <20060306015008.858209000@towertech.it>
User-Agent: quilt/0.43-1
Date: Mon, 06 Mar 2006 02:50:23 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, akpm@digeo.com
Subject: [PATCH 15/16] RTC subsystem, EP93XX driver
Content-Disposition: inline; filename=rtc-drv-ep93xx.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a driver for the RTC embedded
in the Cirrus Logic EP93XX family of processors.

---
 drivers/rtc/Kconfig      |   11 +++
 drivers/rtc/Makefile     |    2 
 drivers/rtc/rtc-ep93xx.c |  163 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 1 deletion(-)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-rtc/drivers/rtc/rtc-ep93xx.c	2006-03-05 02:52:49.000000000 +0100
@@ -0,0 +1,163 @@
+/*
+ * A driver for the RTC embedded in the Cirrus Logic EP93XX processors
+ * Copyright (c) 2006 Tower Technologies
+ *
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/rtc.h>
+#include <linux/platform_device.h>
+#include <asm/hardware.h>
+
+#define EP93XX_RTC_REG(x)	(EP93XX_RTC_BASE + (x))
+#define EP93XX_RTC_DATA		EP93XX_RTC_REG(0x0000)
+#define EP93XX_RTC_LOAD		EP93XX_RTC_REG(0x000C)
+#define EP93XX_RTC_SWCOMP	EP93XX_RTC_REG(0x0108)
+
+#define DRV_VERSION "0.2"
+
+static int ep93xx_get_swcomp(struct device *dev, unsigned short *preload,
+				unsigned short *delete)
+{
+	unsigned short comp = __raw_readl(EP93XX_RTC_SWCOMP);
+
+	if (preload)
+		*preload = comp & 0xffff;
+
+	if (delete)
+		*delete = (comp >> 16) & 0x1f;
+
+	return 0;
+}
+
+static int ep93xx_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	unsigned long time = __raw_readl(EP93XX_RTC_DATA);
+
+	rtc_time_to_tm(time, tm);
+	return 0;
+}
+
+static int ep93xx_rtc_set_mmss(struct device *dev, unsigned long secs)
+{
+	__raw_writel(secs + 1, EP93XX_RTC_LOAD);
+	return 0;
+}
+
+static int ep93xx_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	int err;
+	unsigned long secs;
+
+	err = rtc_tm_to_time(tm, &secs);
+	if (err != 0)
+		return err;
+
+	return ep93xx_rtc_set_mmss(dev, secs);
+}
+
+static int ep93xx_rtc_proc(struct device *dev, struct seq_file *seq)
+{
+	unsigned short preload, delete;
+
+	ep93xx_get_swcomp(dev, &preload, &delete);
+
+	seq_printf(seq, "24hr\t\t: yes\n");
+	seq_printf(seq, "preload\t\t: %d\n", preload);
+	seq_printf(seq, "delete\t\t: %d\n", delete);
+
+	return 0;
+}
+
+static struct rtc_class_ops ep93xx_rtc_ops = {
+	.read_time	= ep93xx_rtc_read_time,
+	.set_time	= ep93xx_rtc_set_time,
+	.set_mmss	= ep93xx_rtc_set_mmss,
+	.proc		= ep93xx_rtc_proc,
+};
+
+static ssize_t ep93xx_sysfs_show_comp_preload(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	unsigned short preload;
+
+	ep93xx_get_swcomp(dev, &preload, NULL);
+
+	return sprintf(buf, "%d\n", preload);
+}
+static DEVICE_ATTR(comp_preload, S_IRUGO, ep93xx_sysfs_show_comp_preload, NULL);
+
+static ssize_t ep93xx_sysfs_show_comp_delete(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	unsigned short delete;
+
+	ep93xx_get_swcomp(dev, NULL, &delete);
+
+	return sprintf(buf, "%d\n", delete);
+}
+static DEVICE_ATTR(comp_delete, S_IRUGO, ep93xx_sysfs_show_comp_delete, NULL);
+
+
+static int __devinit ep93xx_rtc_probe(struct platform_device *dev)
+{
+	struct rtc_device *rtc = rtc_device_register("ep93xx",
+				&dev->dev, &ep93xx_rtc_ops, THIS_MODULE);
+
+	if (IS_ERR(rtc)) {
+		dev_err(&dev->dev, "unable to register\n");
+		return PTR_ERR(rtc);
+	}
+
+	platform_set_drvdata(dev, rtc);
+
+	device_create_file(&dev->dev, &dev_attr_comp_preload);
+	device_create_file(&dev->dev, &dev_attr_comp_delete);
+
+	return 0;
+}
+
+static int __devexit ep93xx_rtc_remove(struct platform_device *dev)
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
+static struct platform_driver ep93xx_rtc_platform_driver = {
+	.driver		= {
+		.name	= "ep93xx-rtc",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ep93xx_rtc_probe,
+	.remove		= __devexit_p(ep93xx_rtc_remove),
+};
+
+static int __init ep93xx_rtc_init(void)
+{
+	return platform_driver_register(&ep93xx_rtc_platform_driver);
+}
+
+static void __exit ep93xx_rtc_exit(void)
+{
+	platform_driver_unregister(&ep93xx_rtc_platform_driver);
+}
+
+MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
+MODULE_DESCRIPTION("EP93XX RTC driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
+module_init(ep93xx_rtc_init);
+module_exit(ep93xx_rtc_exit);
--- linux-rtc.orig/drivers/rtc/Makefile	2006-03-05 02:52:26.000000000 +0100
+++ linux-rtc/drivers/rtc/Makefile	2006-03-05 02:52:28.000000000 +0100
@@ -16,4 +16,4 @@ obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
 obj-$(CONFIG_RTC_DRV_DS1672)	+= rtc-ds1672.o
 obj-$(CONFIG_RTC_DRV_PCF8563)	+= rtc-pcf8563.o
 obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o
-
+obj-$(CONFIG_RTC_DRV_EP93XX)	+= rtc-ep93xx.o
--- linux-rtc.orig/drivers/rtc/Kconfig	2006-03-05 02:52:26.000000000 +0100
+++ linux-rtc/drivers/rtc/Kconfig	2006-03-05 02:52:28.000000000 +0100
@@ -117,6 +117,17 @@ config RTC_DRV_RS5C372
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-rs5c372.
 
+config RTC_DRV_EP93XX
+	tristate "Cirrus Logic EP93XX"
+	depends on RTC_CLASS && ARCH_EP93XX
+	help
+	  If you say yes here you get support for the
+	  RTC embedded in the Cirrus Logic EP93XX processors.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-ep93xx.
+
+
 config RTC_DRV_TEST
 	tristate "Test driver/device"
 	depends on RTC_CLASS

--
