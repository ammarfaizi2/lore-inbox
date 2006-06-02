Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWFBSXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWFBSXY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 14:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWFBSXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 14:23:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:4922 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751439AbWFBSXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 14:23:23 -0400
Date: Fri, 02 Jun 2006 14:16:30 -0400
From: Raphael Assenat <raph@raphnet.net>
Subject: [PATCH] Add v3020 RTC support
To: a.zummo@towertech.it
Cc: linux-kernel@vger.kernel.org
Message-id: <20060602181630.GQ661@aramis.lan.raphnet.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the v3020 RTC from EM Microelectronic. 

The v3020 RTC is designed to be connected on a bus using only one data bit. Since
any data bit may be used, it is necessary to specify this to the driver by
passing a struct v3020_platform_data pointer (see include/linux/rtc-v3020.h) 
to the driver.

Part of the following code comes from the kernel patchs produced by Compulab 
for their products. The original file (available here: 
http://raph.people.8d.com/misc/emv3020.c) was released under the terms 
of the GPL license.

Signed-off-by: Raphael Assenat <raph@raphnet.net>
---

--- linux-2.6.17-rc5-max6902/drivers/rtc/Kconfig	2006-06-02 11:25:15.000000000 -0400
+++ linux-2.6.17-rc5-8d/drivers/rtc/Kconfig	2006-06-01 14:27:42.000000000 -0400
@@ -182,4 +182,14 @@
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-max6902.
 
+config RTC_DRV_V3020
+	tristate "EM Microelectronic V3020"
+	depends on RTC_CLASS
+	help
+	  If you say yes here you will get support for the
+	  EM Microelectronic v3020 RTC chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-v3020.
+
 endmenu
--- linux-2.6.17-rc5-max6902/drivers/rtc/Makefile	2006-06-02 11:25:15.000000000 -0400
+++ linux-2.6.17-rc5-8d/drivers/rtc/Makefile	2006-06-01 14:05:14.000000000 -0400
@@ -21,3 +21,4 @@
 obj-$(CONFIG_RTC_DRV_SA1100)	+= rtc-sa1100.o
 obj-$(CONFIG_RTC_DRV_VR41XX)	+= rtc-vr41xx.o
 obj-$(CONFIG_RTC_DRV_MAX6902)	+= rtc-max6902.o
+obj-$(CONFIG_RTC_DRV_V3020)		+= rtc-v3020.o
--- linux-2.6.17-rc5-max6902/drivers/rtc/rtc-v3020.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.17-rc5-8d/drivers/rtc/rtc-v3020.c	2006-06-02 10:13:32.000000000 -0400
@@ -0,0 +1,266 @@
+/* drivers/rtc/rtc-v3020.c
+ *
+ * Copyright (C) 2006 8D Technologies inc.
+ * Copyright (C) 2004 Compulab Ltd.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Driver for the V3020 RTC
+ *
+ * Changelog:
+ *
+ *  10-May-2006: Raphael Assenat <raph@8d.com>
+ *				- Converted to platform driver
+ *				- Use the generic rtc class
+ *  
+ *  ??-???-2004: Someone at Compulab
+ *  			- Initial driver creation.
+ *
+ */
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rtc.h>
+#include <linux/types.h>
+#include <linux/bcd.h>
+#include <linux/rtc-v3020.h>
+
+#include <asm/io.h>
+
+#undef DEBUG
+
+struct v3020 {
+	void __iomem *ioaddress;
+	int leftshift;	
+	struct rtc_device *rtc;
+};
+
+static void v3020_set_reg(struct v3020 *chip, unsigned char address, unsigned char data)
+{
+	int i;
+	unsigned char tmp;
+
+	tmp = address;
+	for (i=0; i<4; i++) {
+		writel( (tmp & 1) << chip->leftshift , chip->ioaddress);
+		tmp >>= 1;
+	} 
+
+	/* Commands dont have data */
+	if (!V3020_IS_COMMAND(address))
+	{
+		for (i=0; i<8; i++) {
+			writel( (data & 1) << chip->leftshift, chip->ioaddress);
+			data >>= 1;
+		}
+	}
+}
+
+static unsigned char v3020_get_reg(struct v3020 *chip, unsigned char address)
+{
+	unsigned int data=0;
+	int i;
+
+	for (i=0; i<4; i++)	{
+		writel((address & 1) << chip->leftshift , chip->ioaddress);
+		address >>= 1;
+	}
+
+	for (i=0; i<8; i++) {
+		data >>= 1;
+		if (readl(chip->ioaddress) & (1 << chip->leftshift)) {			
+			data |= 0x80;
+		}
+	}
+	
+	return data;
+}
+
+static int v3020_read_time(struct device *dev, struct rtc_time *dt)
+{
+	struct v3020 *chip = dev_get_drvdata(dev);
+	int tmp;
+
+	/* Copy the current time to ram... */
+	v3020_set_reg(chip, V3020_CMD_CLOCK2RAM, 0);
+
+	/* ...and then read constant values. */
+	tmp = v3020_get_reg(chip, V3020_SECONDS);
+	dt->tm_sec	= BCD2BIN(tmp);
+	tmp = v3020_get_reg(chip, V3020_MINUTES);
+	dt->tm_min	= BCD2BIN(tmp);
+	tmp = v3020_get_reg(chip, V3020_HOURS);
+	dt->tm_hour	= BCD2BIN(tmp);
+	tmp = v3020_get_reg(chip, V3020_MONTH_DAY);
+	dt->tm_mday	= BCD2BIN(tmp);
+	tmp = v3020_get_reg(chip, V3020_MONTH);
+	dt->tm_mon	= BCD2BIN(tmp);
+	tmp = v3020_get_reg(chip, V3020_WEEK_DAY);
+	dt->tm_wday	= BCD2BIN(tmp);
+	tmp = v3020_get_reg(chip, V3020_YEAR);
+	dt->tm_year = BCD2BIN(tmp)+100;
+
+#ifdef DEBUG
+	printk("\n%s : Read RTC values\n",__FUNCTION__);
+	printk("tm_hour: %i\n",dt->tm_hour);
+	printk("tm_min : %i\n",dt->tm_min);
+	printk("tm_sec : %i\n",dt->tm_sec);
+	printk("tm_year: %i\n",dt->tm_year);
+	printk("tm_mon : %i\n",dt->tm_mon);
+	printk("tm_mday: %i\n",dt->tm_mday);
+	printk("tm_wday: %i\n",dt->tm_wday);
+#endif
+
+	return 0;
+}
+
+
+static int v3020_set_time(struct device *dev, struct rtc_time *dt)
+{
+	struct v3020 *chip = dev_get_drvdata(dev);
+	
+#ifdef DEBUG
+	printk("\n%s : Setting RTC values\n",__FUNCTION__);
+	printk("tm_sec : %i\n",dt->tm_sec);
+	printk("tm_min : %i\n",dt->tm_min);
+	printk("tm_hour: %i\n",dt->tm_hour);
+	printk("tm_mday: %i\n",dt->tm_mday);
+	printk("tm_wday: %i\n",dt->tm_wday);
+	printk("tm_year: %i\n",dt->tm_year);
+#endif
+
+	/* Write all the values to ram... */
+	v3020_set_reg(chip, V3020_SECONDS, 	BIN2BCD(dt->tm_sec));
+	v3020_set_reg(chip, V3020_MINUTES, 	BIN2BCD(dt->tm_min));
+	v3020_set_reg(chip, V3020_HOURS, 	BIN2BCD(dt->tm_hour));
+	v3020_set_reg(chip, V3020_MONTH_DAY,	BIN2BCD(dt->tm_mday));
+	v3020_set_reg(chip, V3020_MONTH, 	BIN2BCD(dt->tm_mon));
+	v3020_set_reg(chip, V3020_WEEK_DAY, 	BIN2BCD(dt->tm_wday));
+	v3020_set_reg(chip, V3020_YEAR, 	BIN2BCD(dt->tm_year % 100));
+	
+	/* ...and set the clock. */
+	v3020_set_reg(chip, V3020_CMD_RAM2CLOCK, 0);
+
+	/* Compulab used this delay here. I dont know why, 
+	 * the datasheet does not specify a delay. */
+	/*mdelay(5);*/
+
+	return 0;
+}
+
+static struct rtc_class_ops v3020_rtc_ops = {
+	.read_time	= v3020_read_time,
+	.set_time	= v3020_set_time,
+};
+
+static int rtc_probe(struct platform_device *pdev)
+{
+	struct v3020_platform_data *pdata = pdev->dev.platform_data;
+	struct v3020 *chip;
+	struct rtc_device *rtc;
+	int retval = -EBUSY;
+	int i;
+	int temp;
+
+	if (pdev->num_resources != 1)
+		return -EBUSY;
+	
+	if (pdev->resource[0].flags != IORESOURCE_MEM)
+		return -EBUSY;
+
+	if (pdev == NULL)
+		return -EBUSY;
+
+	chip = kzalloc(sizeof *chip, GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->leftshift = pdata->leftshift;
+	chip->ioaddress = ioremap(pdev->resource[0].start, 1);
+	if (chip->ioaddress == NULL) 
+		goto err_chip;
+
+	/* Make sure the v3020 expects a communication cycle
+	 * by reading 8 times */
+	for(i=0;i<8;i++) 
+		temp = readl(chip->ioaddress);
+	
+	/* Test chip by doing a write/read sequence 
+	 * to the chip ram */
+	v3020_set_reg(chip, V3020_SECONDS, 0x33);
+	if(v3020_get_reg(chip, V3020_SECONDS) != 0x33) {		
+		retval = -ENODEV;
+		goto err_io;
+	}
+
+	/* Make sure frequency measurment mode, test modes, and lock
+	 * are all disabled */
+	v3020_set_reg(chip, V3020_STATUS_0, 0x0);	
+
+	dev_info(&pdev->dev, "Chip available at physical address 0x%p,"
+		"data connected to D%d\n", 
+		(void*)pdev->resource[0].start,
+		chip->leftshift);
+
+	platform_set_drvdata(pdev, chip);
+	
+	rtc = rtc_device_register("v3020",
+				&pdev->dev, &v3020_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc)) {
+		retval = PTR_ERR(rtc);
+		goto err_io;
+	}
+	chip->rtc = rtc;
+
+	
+	return 0;
+
+err_io:
+	iounmap(chip->ioaddress);
+err_chip:
+	kfree(chip);
+	
+	return retval;
+}
+
+static int rtc_remove(struct platform_device *dev)
+{
+	struct v3020 *chip = platform_get_drvdata(dev);
+	struct rtc_device *rtc = chip->rtc;
+
+	if (rtc)
+		rtc_device_unregister(rtc);
+
+	iounmap(chip->ioaddress);
+	kfree(chip);
+
+	return 0;
+}
+
+static struct platform_driver rtc_device_driver = {
+	.probe	= rtc_probe,
+	.remove = rtc_remove,
+	.driver = {
+		.name	= "v3020",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static __init int v3020_init(void)
+{
+	return platform_driver_register(&rtc_device_driver);
+}
+
+static __exit void v3020_exit(void)
+{
+	platform_driver_unregister(&rtc_device_driver);
+}
+
+module_init(v3020_init);
+module_exit(v3020_exit);
+
+MODULE_DESCRIPTION("V3020 RTC");
+MODULE_AUTHOR("Raphael Assenat");
+MODULE_LICENSE("GPL");
--- linux-2.6.17-rc5/include/linux/rtc-v3020.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.17-rc5-8d/include/linux/rtc-v3020.h	2006-05-25 14:03:48.000000000 -0400
@@ -0,0 +1,35 @@
+/*
+ * v3020.h - Registers definition and platform data structure for the v3020 RTC.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006, 8D Technologies inc.
+ */
+#ifndef __LINUX_V3020_H
+#define __LINUX_V3020_H
+
+/* The v3020 has only one data pin but which one
+ * is used depends on the board. */
+struct v3020_platform_data {
+	int leftshift; /* (1<<(leftshift)) & readl() */
+};
+
+#define V3020_STATUS_0	0x00
+#define V3020_STATUS_1	0x01
+#define V3020_SECONDS	0x02
+#define V3020_MINUTES	0x03
+#define V3020_HOURS		0x04
+#define V3020_MONTH_DAY	0x05
+#define V3020_MONTH		0x06
+#define V3020_YEAR		0x07
+#define V3020_WEEK_DAY	0x08 
+#define V3020_WEEK		0x09
+
+#define V3020_IS_COMMAND(val) ((val)>=0x0E)
+
+#define V3020_CMD_RAM2CLOCK	0x0E
+#define V3020_CMD_CLOCK2RAM	0x0F
+
+#endif /* __LINUX_V3020_H */
