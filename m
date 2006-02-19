Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWBSXiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWBSXiA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWBSXfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:35:12 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:2242 "EHLO
	linux") by vger.kernel.org with ESMTP id S932430AbWBSXev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:34:51 -0500
Message-Id: <20060219232213.333667000@towertech.it>
References: <20060219232211.368740000@towertech.it>
User-Agent: quilt/0.43-1
Date: Mon, 20 Feb 2006 00:22:21 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] RTC subsystem, PCF8563 driver
Content-Disposition: inline; filename=rtc-drv-pcf8563.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An RTC class aware driver for the Philips
PCF8563 RTC and Epson RTC8564  chips.

This chip is used on the Iomega NAS100D.

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
--
 drivers/rtc/Kconfig       |   11 +
 drivers/rtc/Makefile      |    1 
 drivers/rtc/rtc-pcf8563.c |  355 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 367 insertions(+)

--- linux-rtc.orig/drivers/rtc/Kconfig	2006-02-15 04:14:03.000000000 +0100
+++ linux-rtc/drivers/rtc/Kconfig	2006-02-15 04:14:20.000000000 +0100
@@ -92,6 +92,17 @@ config RTC_DRV_DS1672
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-ds1672.
 
+config RTC_DRV_PCF8563
+	tristate "Philips PCF8563/Epson RTC8564"
+	depends on RTC_CLASS && I2C
+	help
+	  If you say yes here you get support for the
+	  Philips PCF8563 RTC chip. The Epson RTC8564
+	  should work as well.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-pcf8563.
+
 config RTC_DRV_TEST
 	tristate "Test driver/device"
 	depends on RTC_CLASS
--- linux-rtc.orig/drivers/rtc/Makefile	2006-02-15 04:14:03.000000000 +0100
+++ linux-rtc/drivers/rtc/Makefile	2006-02-15 04:14:20.000000000 +0100
@@ -13,4 +13,5 @@ obj-$(CONFIG_RTC_INTF_DEV)	+= rtc-dev.o
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
 obj-$(CONFIG_RTC_DRV_DS1672)	+= rtc-ds1672.o
+obj-$(CONFIG_RTC_DRV_PCF8563)	+= rtc-pcf8563.o
 
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-rtc/drivers/rtc/rtc-pcf8563.c	2006-02-15 04:14:30.000000000 +0100
@@ -0,0 +1,355 @@
+/*
+ * An I2C driver for the Philips PCF8563 RTC
+ * Copyright 2005-06 Tower Technologies
+ *
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ * Maintainers: http://www.nslu2-linux.org/
+ *
+ * based on the other drivers in this same directory.
+ *
+ * http://www.semiconductors.philips.com/acrobat/datasheets/PCF8563-04.pdf
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/i2c.h>
+#include <linux/bcd.h>
+#include <linux/rtc.h>
+
+#define DRV_VERSION "0.4.2"
+
+/* Addresses to scan: none
+ * This chip cannot be reliably autodetected. An empty eeprom
+ * located at 0x51 will pass the validation routine due to
+ * the way the registers are implemented.
+ */
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+
+/* Module parameters */
+I2C_CLIENT_INSMOD;
+
+#define PCF8563_REG_ST1		0x00 /* status */
+#define PCF8563_REG_ST2		0x01
+
+#define PCF8563_REG_SC		0x02 /* datetime */
+#define PCF8563_REG_MN		0x03
+#define PCF8563_REG_HR		0x04
+#define PCF8563_REG_DM		0x05
+#define PCF8563_REG_DW		0x06
+#define PCF8563_REG_MO		0x07
+#define PCF8563_REG_YR		0x08
+
+#define PCF8563_REG_AMN		0x09 /* alarm */
+#define PCF8563_REG_AHR		0x0A
+#define PCF8563_REG_ADM		0x0B
+#define PCF8563_REG_ADW		0x0C
+
+#define PCF8563_REG_CLKO	0x0D /* clock out */
+#define PCF8563_REG_TMRC	0x0E /* timer control */
+#define PCF8563_REG_TMR		0x0F /* timer */
+
+#define PCF8563_SC_LV		0x80 /* low voltage */
+#define PCF8563_MO_C		0x80 /* century */
+
+/* Prototypes */
+static int pcf8563_attach(struct i2c_adapter *adapter);
+static int pcf8563_detach(struct i2c_client *client);
+static int pcf8563_probe(struct i2c_adapter *adapter, int address, int kind);
+
+static struct i2c_driver pcf8563_driver = {
+	.driver		= {
+		.name	= "pcf8563",
+	},
+	.attach_adapter = &pcf8563_attach,
+	.detach_client	= &pcf8563_detach,
+};
+
+/*
+ * In the routines that deal directly with the pcf8563 hardware, we use
+ * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
+ */
+static int pcf8563_get_datetime(struct i2c_client *client, struct rtc_time *tm)
+{
+	unsigned char buf[13] = { PCF8563_REG_ST1 };
+
+	struct i2c_msg msgs[] = {
+		{ client->addr, 0, 1, buf },	/* setup read ptr */
+		{ client->addr, I2C_M_RD, 13, buf },	/* read status + date */
+	};
+
+	/* read registers */
+	if ((i2c_transfer(client->adapter, msgs, 2)) != 2) {
+		dev_err(&client->dev, "%s: read error\n", __FUNCTION__);
+		return -EIO;
+	}
+
+	if (buf[PCF8563_REG_SC] & PCF8563_SC_LV)
+		dev_info(&client->dev,
+			"low voltage detected, date/time is not reliable.\n");
+
+	dev_dbg(&client->dev,
+		"%s: raw data is st1=%02x, st2=%02x, sec=%02x, min=%02x, hr=%02x, "
+		"mday=%02x, wday=%02x, mon=%02x, year=%02x\n",
+		__FUNCTION__,
+		buf[0], buf[1], buf[2], buf[3],
+		buf[4], buf[5], buf[6], buf[7],
+		buf[8]);
+
+
+	tm->tm_sec = BCD2BIN(buf[PCF8563_REG_SC] & 0x7F);
+	tm->tm_min = BCD2BIN(buf[PCF8563_REG_MN] & 0x7F);
+	tm->tm_hour = BCD2BIN(buf[PCF8563_REG_HR] & 0x3F); /* rtc hr 0-23 */
+	tm->tm_mday = BCD2BIN(buf[PCF8563_REG_DM] & 0x3F);
+	tm->tm_wday = buf[PCF8563_REG_DW] & 0x07;
+	tm->tm_mon = BCD2BIN(buf[PCF8563_REG_MO] & 0x1F) - 1; /* rtc mn 1-12 */
+	tm->tm_year = BCD2BIN(buf[PCF8563_REG_YR])
+		+ (buf[PCF8563_REG_MO] & PCF8563_MO_C ? 100 : 0);
+
+	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
+		"mday=%d, mon=%d, year=%d, wday=%d\n",
+		__FUNCTION__,
+		tm->tm_sec, tm->tm_min, tm->tm_hour,
+		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
+
+	/* the clock can give out invalid datetime, but we cannot return
+	 * -EINVAL otherwise hwclock will refuse to set the time on bootup.
+	 */
+	if (rtc_valid_tm(tm) < 0)
+		dev_err(&client->dev, "retrieved date/time is not valid.\n");
+
+	return 0;
+}
+
+static int pcf8563_set_datetime(struct i2c_client *client, struct rtc_time *tm)
+{
+	int i, err;
+	unsigned char buf[9];
+
+	dev_dbg(&client->dev, "%s: secs=%d, mins=%d, hours=%d, "
+		"mday=%d, mon=%d, year=%d, wday=%d\n",
+		__FUNCTION__,
+		tm->tm_sec, tm->tm_min, tm->tm_hour,
+		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
+
+	/* hours, minutes and seconds */
+	buf[PCF8563_REG_SC] = BIN2BCD(tm->tm_sec);
+	buf[PCF8563_REG_MN] = BIN2BCD(tm->tm_min);
+	buf[PCF8563_REG_HR] = BIN2BCD(tm->tm_hour);
+
+	buf[PCF8563_REG_DM] = BIN2BCD(tm->tm_mday);
+
+	/* month, 1 - 12 */
+	buf[PCF8563_REG_MO] = BIN2BCD(tm->tm_mon + 1);
+
+	/* year and century */
+	buf[PCF8563_REG_YR] = BIN2BCD(tm->tm_year % 100);
+	if (tm->tm_year / 100)
+		buf[PCF8563_REG_MO] |= PCF8563_MO_C;
+
+	buf[PCF8563_REG_DW] = tm->tm_wday & 0x07;
+
+	/* write register's data */
+	for (i = 0; i < 7; i++) {
+		unsigned char data[2] = { PCF8563_REG_SC + i,
+						buf[PCF8563_REG_SC + i] };
+
+		err = i2c_master_send(client, data, sizeof(data));
+		if (err != sizeof(data)) {
+			dev_err(&client->dev,
+				"%s: err=%d addr=%02x, data=%02x\n",
+				__FUNCTION__, err, data[0], data[1]);
+			return -EIO;
+		}
+	};
+
+	return 0;
+}
+
+struct pcf8563_limit
+{
+	unsigned char reg;
+	unsigned char mask;
+	unsigned char min;
+	unsigned char max;
+};
+
+static int pcf8563_validate_client(struct i2c_client *client)
+{
+	int i;
+
+	static const struct pcf8563_limit pattern[] = {
+		/* register, mask, min, max */
+		{ PCF8563_REG_SC,	0x7F,	0,	59	},
+		{ PCF8563_REG_MN,	0x7F,	0,	59	},
+		{ PCF8563_REG_HR,	0x3F,	0,	23	},
+		{ PCF8563_REG_DM,	0x3F,	0,	31	},
+		{ PCF8563_REG_MO,	0x1F,	0,	12	},
+	};
+
+	/* check limits (only registers with bcd values) */
+	for (i = 0; i < ARRAY_SIZE(pattern); i++) {
+		int xfer;
+		unsigned char value;
+		unsigned char buf = pattern[i].reg;
+
+		struct i2c_msg msgs[] = {
+			{ client->addr, 0, 1, &buf },
+			{ client->addr, I2C_M_RD, 1, &buf },
+		};
+
+		xfer = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+
+		if (xfer != ARRAY_SIZE(msgs)) {
+			dev_err(&client->adapter->dev,
+				"%s: could not read register 0x%02X\n",
+				__FUNCTION__, pattern[i].reg);
+
+			return -EIO;
+		}
+
+		value = BCD2BIN(buf & pattern[i].mask);
+
+		if (value > pattern[i].max ||
+			value < pattern[i].min) {
+			dev_dbg(&client->adapter->dev,
+				"%s: pattern=%d, reg=%x, mask=0x%02x, min=%d, "
+				"max=%d, value=%d, raw=0x%02X\n",
+				__FUNCTION__, i, pattern[i].reg, pattern[i].mask,
+				pattern[i].min, pattern[i].max,
+				value, buf);
+
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+static int pcf8563_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	return pcf8563_get_datetime(to_i2c_client(dev), tm);
+}
+
+static int pcf8563_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	return pcf8563_set_datetime(to_i2c_client(dev), tm);
+}
+
+static int pcf8563_rtc_proc(struct device *dev, struct seq_file *seq)
+{
+	seq_printf(seq, "24hr\t\t: yes\n");
+	return 0;
+}
+
+static struct rtc_class_ops pcf8563_rtc_ops = {
+	.proc		= pcf8563_rtc_proc,
+	.read_time	= pcf8563_rtc_read_time,
+	.set_time	= pcf8563_rtc_set_time,
+};
+
+static int pcf8563_attach(struct i2c_adapter *adapter)
+{
+	return i2c_probe(adapter, &addr_data, pcf8563_probe);
+}
+
+static int pcf8563_probe(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *client;
+	struct rtc_device *rtc;
+
+	int err = 0;
+
+	dev_dbg(&adapter->dev, "%s\n", __FUNCTION__);
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
+		err = -ENODEV;
+		goto exit;
+	}
+
+	if (!(client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	client->addr = address;
+	client->driver = &pcf8563_driver;
+	client->adapter	= adapter;
+
+	strlcpy(client->name, pcf8563_driver.driver.name, I2C_NAME_SIZE);
+
+	/* Verify the chip is really an PCF8563 */
+	if (kind < 0) {
+		if (pcf8563_validate_client(client) < 0) {
+			err = -ENODEV;
+			goto exit_kfree;
+		}
+	}
+
+	/* Inform the i2c layer */
+	if ((err = i2c_attach_client(client)))
+		goto exit_kfree;
+
+	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");
+
+	rtc = rtc_device_register(pcf8563_driver.driver.name, &client->dev,
+				&pcf8563_rtc_ops, THIS_MODULE);
+
+	if (IS_ERR(rtc)) {
+		err = PTR_ERR(rtc);
+		dev_err(&client->dev,
+			"unable to register the class device\n");
+		goto exit_detach;
+	}
+
+	i2c_set_clientdata(client, rtc);
+
+	return 0;
+
+exit_detach:
+	i2c_detach_client(client);
+
+exit_kfree:
+	kfree(client);
+
+exit:
+	return err;
+}
+
+static int pcf8563_detach(struct i2c_client *client)
+{
+	int err;
+	struct rtc_device *rtc = i2c_get_clientdata(client);
+
+	dev_dbg(&client->dev, "%s\n", __FUNCTION__);
+
+	if (rtc)
+		rtc_device_unregister(rtc);
+
+	if ((err = i2c_detach_client(client)))
+		return err;
+
+	kfree(client);
+
+	return 0;
+}
+
+static int __init pcf8563_init(void)
+{
+	return i2c_add_driver(&pcf8563_driver);
+}
+
+static void __exit pcf8563_exit(void)
+{
+	i2c_del_driver(&pcf8563_driver);
+}
+
+MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
+MODULE_DESCRIPTION("Philips PCF8563/Epson RTC8564 RTC driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
+module_init(pcf8563_init);
+module_exit(pcf8563_exit);

--
