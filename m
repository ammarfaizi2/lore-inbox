Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWE3S5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWE3S5C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 14:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWE3S5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 14:57:01 -0400
Received: from mout.perfora.net ([217.160.230.41]:56059 "EHLO mout.perfora.net")
	by vger.kernel.org with ESMTP id S932389AbWE3S5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 14:57:00 -0400
Date: Tue, 30 May 2006 14:49:49 -0400
From: Raphael Assenat <raph@raphnet.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Add max6902 RTC support
Message-ID: <20060530184949.GF797@aramis.lan.raphnet.net>
References: <20060530150913.GE797@aramis.lan.raphnet.net> <20060530203241.4a4de734@inspiron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530203241.4a4de734@inspiron>
User-Agent: Mutt/1.5.10i
X-Provags-ID: perfora.net abuse@perfora.net login:76030ac055994e103dbcd370532942c0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second version of my patch to add
support for the MAX6902 SPI RTC chip. Renamed RTC_DEBUG
to MAX6902_DEBUG and use #undef instead of a comment, as
suggested by Alessandro Zummo.

Applies on 2.6.17-rc5. Tested on a pxa2xx cpu.

Signed-off-by: Raphael Assenat <raph@raphnet.net>
---

--- linux-2.6.17-rc5/drivers/rtc/Kconfig	2006-05-24 21:50:17.000000000 -0400
+++ linux-2.6.17-rc5-8d/drivers/rtc/Kconfig	2006-05-25 15:59:53.000000000 -0400
@@ -172,4 +172,14 @@
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-test.
 
+config RTC_DRV_MAX6902
+	tristate "Maxim 6902"
+	depends on RTC_CLASS && SPI 
+	help
+	  If you say yes here you will get support for the
+	  Maxim MAX6902 spi RTC chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-max6902.
+
 endmenu
--- linux-2.6.17-rc5/drivers/rtc/Makefile	2006-05-24 21:50:17.000000000 -0400
+++ linux-2.6.17-rc5-8d/drivers/rtc/Makefile	2006-05-25 15:58:38.000000000 -0400
@@ -20,3 +20,4 @@
 obj-$(CONFIG_RTC_DRV_EP93XX)	+= rtc-ep93xx.o
 obj-$(CONFIG_RTC_DRV_SA1100)	+= rtc-sa1100.o
 obj-$(CONFIG_RTC_DRV_VR41XX)	+= rtc-vr41xx.o
+obj-$(CONFIG_RTC_DRV_MAX6902)	+= rtc-max6902.o
--- linux-2.6.17-rc5/drivers/rtc/rtc-max6902.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.17-rc5-8d/drivers/rtc/rtc-max6902.c	2006-05-30 14:38:10.000000000 -0400
@@ -0,0 +1,289 @@
+/* drivers/char/max6902.c
+ *
+ * Copyright (C) 2006 8D Technologies inc.
+ * Copyright (C) 2004 Compulab Ltd.
+ * 
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Driver for MAX6902 spi RTC
+ * 
+ * Changelog:
+ * 
+ * 24-May-2006: Raphael Assenat <raph@8d.com>
+ *                - Major rework
+ *   				Converted to rtc_device and uses the SPI layer.
+ *
+ * ??-???-2005: Someone at Compulab
+ *                - Initial driver creation.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/version.h>
+ 
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/rtc.h>
+#include <linux/spi/spi.h>
+#include <linux/bcd.h>
+
+#include <asm/delay.h>
+
+#define MAX6902_REG_SECONDS		0x01
+#define MAX6902_REG_MINUTES		0x03
+#define MAX6902_REG_HOURS		0x05
+#define MAX6902_REG_DATE		0x07
+#define MAX6902_REG_MONTH		0x09
+#define MAX6902_REG_DAY			0x0B
+#define MAX6902_REG_YEAR		0x0D
+#define MAX6902_REG_CONTROL		0x0F
+#define MAX6902_REG_CENTURY		0x13
+
+
+#undef MAX6902_DEBUG
+
+struct max6902 {
+	struct rtc_device *rtc;
+	u8 buf[9]; /* Burst read cmd + 8 registers */
+	u8 tx_buf[2];
+	u8 rx_buf[2];
+};
+
+static void max6902_set_reg(struct device *dev, unsigned char address, 
+														unsigned char data)
+{
+	struct spi_device	*spi = to_spi_device(dev);
+	unsigned char buf[2];
+
+	/* MSB must be '0' to write */
+	buf[0] = address & 0x7f;
+	buf[1] = data;
+	
+	spi_write(spi, buf, 2);
+}
+
+static int max6902_get_reg(struct device *dev, unsigned char address, unsigned char *data)
+{
+	struct spi_device	*spi = to_spi_device(dev);
+	struct max6902 *chip = dev_get_drvdata(dev);
+	struct spi_message message;
+	struct spi_transfer xfer;
+	int status;
+
+	if (!data) return -EINVAL;
+
+	/* Build our spi message */
+	spi_message_init(&message);
+	memset(&xfer, 0, sizeof(xfer));	
+	xfer.len = 2;
+	/* Can tx_buf and rx_buf be equal? The doc in spi.h is not sure... */
+	xfer.tx_buf = chip->tx_buf;
+	xfer.rx_buf = chip->rx_buf;
+
+	/* Set MSB to indicate read */
+	chip->tx_buf[0] = address | 0x80;
+
+	spi_message_add_tail(&xfer, &message);
+	
+	/* do the i/o */
+	status = spi_sync(spi, &message);
+	if (status == 0) {
+		status = message.status;
+	}
+	else
+		return status;
+
+	*data = chip->rx_buf[1];
+	
+	return status;
+}
+ 
+static int max6902_get_datetime(struct device *dev, struct rtc_time *dt)
+{
+	unsigned char tmp;
+	int century;
+	int err;
+
+	struct spi_device	*spi = to_spi_device(dev);
+	struct max6902 *chip = dev_get_drvdata(dev);
+	struct spi_message message;
+	struct spi_transfer xfer;
+	int status;
+
+	err = max6902_get_reg(dev, MAX6902_REG_CENTURY, &tmp);
+	if (err)
+		return err;
+
+	/* build the message */
+	spi_message_init(&message);
+	memset(&xfer, 0, sizeof(xfer));
+	xfer.len = 1 + 7; /* Burst read command + 7 registers */
+	xfer.tx_buf = chip->buf;
+	xfer.rx_buf = chip->buf;
+	chip->buf[0] = 0xbf; // Burst read
+	spi_message_add_tail(&xfer, &message);
+	
+	/* do the i/o */
+	status = spi_sync(spi, &message);
+	if (status == 0) {
+		status = message.status;
+	}
+	else
+		return status;
+
+	/* The chip sends data in this order:
+	 * Seconds, Minutes, Hours, Date, Month, Day, Year */
+	dt->tm_sec	= BCD2BIN(chip->buf[1]);
+	dt->tm_min	= BCD2BIN(chip->buf[2]);
+	dt->tm_hour	= BCD2BIN(chip->buf[3]);
+	dt->tm_mday	= BCD2BIN(chip->buf[4]);
+	dt->tm_mon	= BCD2BIN(chip->buf[5] - 1);
+	dt->tm_wday	= BCD2BIN(chip->buf[6]);
+	dt->tm_year = BCD2BIN(chip->buf[7]);
+
+
+	century = BCD2BIN(tmp) * 100;
+
+	dt->tm_year += century;
+	dt->tm_year -= 1900;
+
+#ifdef MAX6902_DEBUG
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
+static int max6902_set_datetime(struct device *dev, struct rtc_time *dt)
+{
+	dt->tm_year = dt->tm_year+1900;
+
+#ifdef MAX6902_DEBUG
+	printk("\n%s : Setting RTC values\n",__FUNCTION__);
+	printk("tm_sec : %i\n",dt->tm_sec);
+	printk("tm_min : %i\n",dt->tm_min);
+	printk("tm_hour: %i\n",dt->tm_hour);
+	printk("tm_mday: %i\n",dt->tm_mday);
+	printk("tm_wday: %i\n",dt->tm_wday);
+	printk("tm_year: %i\n",dt->tm_year);
+#endif
+
+	// Remove write protection
+	max6902_set_reg(dev, 0xF, 0);
+
+	max6902_set_reg(dev, 0x01, BIN2BCD(dt->tm_sec));
+	max6902_set_reg(dev, 0x03, BIN2BCD(dt->tm_min));
+	max6902_set_reg(dev, 0x05, BIN2BCD(dt->tm_hour));
+
+	max6902_set_reg(dev, 0x07, BIN2BCD(dt->tm_mday));
+	max6902_set_reg(dev, 0x09, BIN2BCD(dt->tm_mon+1));
+	max6902_set_reg(dev, 0x0B, BIN2BCD(dt->tm_wday));
+	max6902_set_reg(dev, 0x0D, BIN2BCD(dt->tm_year%100));
+	max6902_set_reg(dev, 0x13, BIN2BCD(dt->tm_year/100));
+
+	/* Compulab used a delay here. However, the datasheet
+	 * does not mention a delay being required anywhere... */
+	/* delay(2000); */
+
+	// Write protect
+	max6902_set_reg(dev, 0xF, 0x80);
+
+	return 0;
+}
+
+static int max6902_read_time(struct device *dev, struct rtc_time *tm)
+{
+	return max6902_get_datetime(dev, tm);
+}
+
+static int max6902_set_time(struct device *dev, struct rtc_time *tm)
+{
+	return max6902_set_datetime(dev, tm);
+}
+
+static struct rtc_class_ops max6902_rtc_ops = {
+	.read_time	= max6902_read_time,
+	.set_time	= max6902_set_time,
+};
+
+static int __devinit max6902_probe(struct spi_device *spi)
+{
+	struct rtc_device *rtc;
+	unsigned char tmp;
+	struct max6902 *chip;
+	int res;
+
+	rtc = rtc_device_register("max6902",
+				&spi->dev, &max6902_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc)) {
+		return PTR_ERR(rtc);
+	}
+
+	spi->mode = SPI_MODE_3;
+	spi->bits_per_word = 8;
+	spi_setup(spi);
+
+	chip = kzalloc(sizeof *chip, GFP_KERNEL);
+	if (!chip) {
+		rtc_device_unregister(rtc);
+		return -ENOMEM;
+	}
+	chip->rtc = rtc;
+	dev_set_drvdata(&spi->dev, chip);	
+	
+	res = max6902_get_reg(&spi->dev, MAX6902_REG_SECONDS, &tmp);
+	if (res) {
+		rtc_device_unregister(rtc);
+		return res;
+	}
+	
+	return 0;
+}
+
+static int __devexit max6902_remove(struct spi_device *spi)
+{
+	struct max6902 *chip = platform_get_drvdata(spi);
+	struct rtc_device *rtc = chip->rtc;
+
+	if (rtc)
+		rtc_device_unregister(rtc);
+
+	return 0;
+}
+
+static struct spi_driver max6902_driver = {
+	.driver = {
+		.name 	= "max6902",
+		.bus	= &spi_bus_type,
+		.owner	= THIS_MODULE,
+	},
+	.probe 	= max6902_probe,
+	.remove = __devexit_p(max6902_remove),
+};
+
+static __init int max6902_init(void)
+{
+	printk("max6902 spi driver\n");
+	return spi_register_driver(&max6902_driver);
+}
+module_init(max6902_init);
+
+static __exit void max6902_exit(void)
+{
+	spi_unregister_driver(&max6902_driver);
+}
+module_exit(max6902_exit);
+
+MODULE_DESCRIPTION ("max6902 spi RTC driver");
+MODULE_AUTHOR ("Raphael Assenat");
+MODULE_LICENSE ("GPL");
