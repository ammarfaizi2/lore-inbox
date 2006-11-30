Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758482AbWK3HMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758482AbWK3HMJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 02:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758496AbWK3HMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 02:12:09 -0500
Received: from pasmtpa.tele.dk ([80.160.77.114]:35272 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1758482AbWK3HMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 02:12:07 -0500
From: Torsten Ertbjerg Rasmussen <tr@newtec.dk>
Reply-To: tr@newtec.dk
To: a.zummo@towertech.it
Subject: [PATCH] rtc: ds1743 support
Date: Thu, 30 Nov 2006 08:12:02 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200611300812.02261.tr@newtec.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

The real time clocks ds1742 and ds1743 differs only in the size of the nvram. 
This patch changes the existing ds1742 driver to support also ds1743. The 
main change is that the nvram size is determined from the resource attached 
to the device. 

This patch applies to and have been tested with 2.6.19-rc5 and 2.6.19-rc6.

The patch have benefitted from suggestions from Atsushi Nemeto, who is the 
author of the ds1742 driver. 

Please cc: me on any comments

Regards,
Signed-off-by: Torsten Rasmussen
---
diff -uprN -X linux-2.6.19-rc5-vanilla/Documentation/dontdiff 
linux-2.6.19-rc5-vanilla/drivers/rtc/Kconfig 
linux-2.6.19-rc5/drivers/rtc/Kconfig
--- linux-2.6.19-rc5-vanilla/drivers/rtc/Kconfig	2006-11-08 03:24:20.000000000 
+0100
+++ linux-2.6.19-rc5/drivers/rtc/Kconfig	2006-11-23 11:07:20.157388499 +0100
@@ -154,11 +154,11 @@ config RTC_DRV_DS1672
 	  will be called rtc-ds1672.
 
 config RTC_DRV_DS1742
-	tristate "Dallas DS1742"
+	tristate "Dallas DS1742/1743"
 	depends on RTC_CLASS
 	help
 	  If you say yes here you get support for the
-	  Dallas DS1742 timekeeping chip.
+	  Dallas DS1742/1743 timekeeping chip.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ds1742.
diff -uprN -X linux-2.6.19-rc5-vanilla/Documentation/dontdiff 
linux-2.6.19-rc5-vanilla/drivers/rtc/rtc-ds1742.c 
linux-2.6.19-rc5/drivers/rtc/rtc-ds1742.c
--- linux-2.6.19-rc5-vanilla/drivers/rtc/rtc-ds1742.c	2006-11-08 
03:24:20.000000000 +0100
+++ linux-2.6.19-rc5/drivers/rtc/rtc-ds1742.c	2006-11-23 11:04:19.977903832 
+0100
@@ -6,6 +6,10 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ * 
+ * Copyright (C) 2006 Torsten Ertbjerg Rasmussen <tr@newtec.dk>
+ *  - nvram size determined from resource
+ *  - this ds1742 driver now supports ds1743. 
  */
 
 #include <linux/bcd.h>
@@ -17,20 +21,19 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
-#define DRV_VERSION "0.2"
+#define DRV_VERSION "0.3"
 
-#define RTC_REG_SIZE		0x800
-#define RTC_OFFSET		0x7f8
+#define RTC_SIZE		8
 
-#define RTC_CONTROL		(RTC_OFFSET + 0)
-#define RTC_CENTURY		(RTC_OFFSET + 0)
-#define RTC_SECONDS		(RTC_OFFSET + 1)
-#define RTC_MINUTES		(RTC_OFFSET + 2)
-#define RTC_HOURS		(RTC_OFFSET + 3)
-#define RTC_DAY			(RTC_OFFSET + 4)
-#define RTC_DATE		(RTC_OFFSET + 5)
-#define RTC_MONTH		(RTC_OFFSET + 6)
-#define RTC_YEAR		(RTC_OFFSET + 7)
+#define RTC_CONTROL		0
+#define RTC_CENTURY		0
+#define RTC_SECONDS		1
+#define RTC_MINUTES		2
+#define RTC_HOURS		3
+#define RTC_DAY			4
+#define RTC_DATE		5
+#define RTC_MONTH		6
+#define RTC_YEAR		7
 
 #define RTC_CENTURY_MASK	0x3f
 #define RTC_SECONDS_MASK	0x7f
@@ -48,7 +51,10 @@
 
 struct rtc_plat_data {
 	struct rtc_device *rtc;
-	void __iomem *ioaddr;
+	void __iomem *ioaddr_nvram;  
+	void __iomem *ioaddr_rtc;
+	size_t size_nvram;
+	size_t size;
 	unsigned long baseaddr;
 	unsigned long last_jiffies;
 };
@@ -57,7 +63,7 @@ static int ds1742_rtc_set_time(struct de
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
-	void __iomem *ioaddr = pdata->ioaddr;
+	void __iomem *ioaddr = pdata->ioaddr_rtc;
 	u8 century;
 
 	century = BIN2BCD((tm->tm_year + 1900) / 100);
@@ -82,7 +88,7 @@ static int ds1742_rtc_read_time(struct d
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
-	void __iomem *ioaddr = pdata->ioaddr;
+	void __iomem *ioaddr = pdata->ioaddr_rtc;
 	unsigned int year, month, day, hour, minute, second, week;
 	unsigned int century;
 
@@ -127,10 +133,10 @@ static ssize_t ds1742_nvram_read(struct 
 	struct platform_device *pdev =
 		to_platform_device(container_of(kobj, struct device, kobj));
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
-	void __iomem *ioaddr = pdata->ioaddr;
+	void __iomem *ioaddr = pdata->ioaddr_nvram;
 	ssize_t count;
 
-	for (count = 0; size > 0 && pos < RTC_OFFSET; count++, size--)
+	for (count = 0; size > 0 && pos < pdata->size_nvram; count++, size--)
 		*buf++ = readb(ioaddr + pos++);
 	return count;
 }
@@ -141,10 +147,10 @@ static ssize_t ds1742_nvram_write(struct
 	struct platform_device *pdev =
 		to_platform_device(container_of(kobj, struct device, kobj));
 	struct rtc_plat_data *pdata = platform_get_drvdata(pdev);
-	void __iomem *ioaddr = pdata->ioaddr;
+	void __iomem *ioaddr = pdata->ioaddr_nvram;
 	ssize_t count;
 
-	for (count = 0; size > 0 && pos < RTC_OFFSET; count++, size--)
+	for (count = 0; size > 0 && pos < pdata->size_nvram; count++, size--)
 		writeb(*buf++, ioaddr + pos++);
 	return count;
 }
@@ -155,7 +161,6 @@ static struct bin_attribute ds1742_nvram
 		.mode = S_IRUGO | S_IWUGO,
 		.owner = THIS_MODULE,
 	},
-	.size = RTC_OFFSET,
 	.read = ds1742_nvram_read,
 	.write = ds1742_nvram_write,
 };
@@ -175,19 +180,23 @@ static int __init ds1742_rtc_probe(struc
 	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
-	if (!request_mem_region(res->start, RTC_REG_SIZE, pdev->name)) {
+	pdata->size = res->end - res->start + 1;
+	if (!request_mem_region(res->start, pdata->size, pdev->name)) {	
 		ret = -EBUSY;
 		goto out;
 	}
 	pdata->baseaddr = res->start;
-	ioaddr = ioremap(pdata->baseaddr, RTC_REG_SIZE);
+	ioaddr = ioremap(pdata->baseaddr, pdata->size);
 	if (!ioaddr) {
 		ret = -ENOMEM;
 		goto out;
 	}
-	pdata->ioaddr = ioaddr;
+	pdata->ioaddr_nvram = ioaddr;
+	pdata->size_nvram = pdata->size - RTC_SIZE;
+	pdata->ioaddr_rtc = ioaddr + pdata->size_nvram;
 
 	/* turn RTC on if it was not on */
+	ioaddr = pdata->ioaddr_rtc;
 	sec = readb(ioaddr + RTC_SECONDS);
 	if (sec & RTC_STOP) {
 		sec &= RTC_SECONDS_MASK;
@@ -208,6 +217,8 @@ static int __init ds1742_rtc_probe(struc
 	pdata->rtc = rtc;
 	pdata->last_jiffies = jiffies;
 	platform_set_drvdata(pdev, pdata);
+	ds1742_nvram_attr.size = max(ds1742_nvram_attr.size, 
+				     pdata->size_nvram);
 	ret = sysfs_create_bin_file(&pdev->dev.kobj, &ds1742_nvram_attr);
 	if (ret)
 		goto out;
@@ -215,10 +226,10 @@ static int __init ds1742_rtc_probe(struc
  out:
 	if (pdata->rtc)
 		rtc_device_unregister(pdata->rtc);
-	if (ioaddr)
-		iounmap(ioaddr);
+	if (pdata->ioaddr_nvram)
+		iounmap(pdata->ioaddr_nvram);
 	if (pdata->baseaddr)
-		release_mem_region(pdata->baseaddr, RTC_REG_SIZE);
+		release_mem_region(pdata->baseaddr, pdata->size);
 	kfree(pdata);
 	return ret;
 }
@@ -229,8 +240,8 @@ static int __devexit ds1742_rtc_remove(s
 
 	sysfs_remove_bin_file(&pdev->dev.kobj, &ds1742_nvram_attr);
 	rtc_device_unregister(pdata->rtc);
-	iounmap(pdata->ioaddr);
-	release_mem_region(pdata->baseaddr, RTC_REG_SIZE);
+	iounmap(pdata->ioaddr_nvram);
+	release_mem_region(pdata->baseaddr, pdata->size);
 	kfree(pdata);
 	return 0;
 }

