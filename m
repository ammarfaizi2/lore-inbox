Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbWEEPnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWEEPnb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 11:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWEEPna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 11:43:30 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:59846 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751613AbWEEPna
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 11:43:30 -0400
Date: Fri, 5 May 2006 16:43:22 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: James Chapman <jchapman@katalix.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] DS1337 RTC subsystem driver
Message-ID: <20060505154322.GA7078@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is DS1337 driver for RTC subsystem, tested on VoiceBlue board.
Patch doesn't remove old driver, let's wait for some feedback...
Please test it, so we do not miss next merge window :-)

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 65d090d..f148e83 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -86,6 +86,16 @@ config RTC_DRV_X1205
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-x1205.
 
+config RTC_DRV_DS1337
+	tristate "Dallas DS1337"
+	depends on RTC_CLASS && I2C
+	help
+	  If you say yes here you get support for Dallas Semiconductor
+	  DS1337 and DS1339 real-time clock chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-ds1337.
+
 config RTC_DRV_DS1672
 	tristate "Dallas/Maxim DS1672"
 	depends on RTC_CLASS && I2C
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index a9ca0f1..d5f8617 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_RTC_INTF_DEV)	+= rtc-dev.o
 
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
+obj-$(CONFIG_RTC_DRV_DS1337)	+= rtc-ds1337.o
 obj-$(CONFIG_RTC_DRV_DS1672)	+= rtc-ds1672.o
 obj-$(CONFIG_RTC_DRV_PCF8563)	+= rtc-pcf8563.o
 obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o

--- /dev/null	2006-05-05 14:05:32.506751776 +0200
+++ linux-omap-2.6.git/drivers/rtc/rtc-ds1337.c	2006-05-05 16:42:16.000000000 +0200
@@ -0,0 +1,306 @@
+/*
+ * Copyright (C) 2006 Ladislav Michl <ladis@linux-mips.org>
+ * Copyright (C) 2005 James Chapman <jchapman@katalix.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Driver for Dallas Semiconductor DS1337 and DS1339 real time clock chip
+ */
+
+#include <linux/bcd.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/rtc.h>
+
+/* Device registers */
+#define DS1337_REG_HOUR		0x02
+#define DS1337_REG_DAY		0x03
+#define DS1337_REG_DATE		0x04
+#define DS1337_REG_MONTH	0x05
+#define DS1337_REG_CONTROL	0x0e
+#define DS1337_REG_STATUS	0x0f
+
+static unsigned short normal_i2c[] = { 0x68, I2C_CLIENT_END };
+
+I2C_CLIENT_INSMOD_1(ds1337);
+
+static inline int ds1337_read(struct i2c_client *client, u8 reg, u8 *value)
+{
+	s32 tmp = i2c_smbus_read_byte_data(client, reg);
+
+	if (tmp < 0)
+		return -EIO;
+
+	*value = tmp;
+
+	return 0;
+}
+
+static int ds1337_probe(struct i2c_adapter *adapter, int address, int kind);
+
+/*
+ * In the routines that deal directly with the ds1337 hardware, we use
+ * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch
+ * Epoch is initialized as 2000. Time is set to UTC.
+ */
+static int ds1337_get_datetime(struct i2c_client *client, struct rtc_time *tm)
+{
+	int result;
+	u8 buf[7];
+	u8 val;
+	struct i2c_msg msg[2];
+	u8 offs = 0;
+
+	msg[0].addr = client->addr;
+	msg[0].flags = 0;
+	msg[0].len = 1;
+	msg[0].buf = &offs;
+
+	msg[1].addr = client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = sizeof(buf);
+	msg[1].buf = &buf[0];
+
+	result = i2c_transfer(client->adapter, msg, 2);
+	if (result == 2) {
+		tm->tm_sec = BCD2BIN(buf[0]);
+		tm->tm_min = BCD2BIN(buf[1]);
+		val = buf[2] & 0x3f;
+		tm->tm_hour = BCD2BIN(val);
+		tm->tm_wday = BCD2BIN(buf[3]) - 1;
+		tm->tm_mday = BCD2BIN(buf[4]);
+		val = buf[5] & 0x7f;
+		tm->tm_mon = BCD2BIN(val) - 1;
+		tm->tm_year = BCD2BIN(buf[6]);
+		if (buf[5] & 0x80)
+			tm->tm_year += 100;
+
+		dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
+				      "mday=%d, mon=%d, year=%d, wday=%d\n",
+				      __FUNCTION__, tm->tm_sec, tm->tm_min,
+				      tm->tm_hour, tm->tm_mday, tm->tm_mon,
+				      tm->tm_year, tm->tm_wday);
+
+		return 0;
+	}
+
+	dev_dbg(&client->dev, "error reading data! %d\n", result);
+
+	return -EIO;
+}
+
+static int ds1337_set_datetime(struct i2c_client *client, struct rtc_time *tm)
+{
+	int result;
+	u8 buf[8];
+	u8 val;
+	struct i2c_msg msg[1];
+
+	dev_dbg(&client->dev, "%s: secs=%d, mins=%d, hours=%d, "
+		"mday=%d, mon=%d, year=%d, wday=%d\n", __FUNCTION__,
+		tm->tm_sec, tm->tm_min, tm->tm_hour,
+		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
+
+	buf[0] = 0;		/* reg offset */
+	buf[1] = BIN2BCD(tm->tm_sec);
+	buf[2] = BIN2BCD(tm->tm_min);
+	buf[3] = BIN2BCD(tm->tm_hour);
+	buf[4] = BIN2BCD(tm->tm_wday + 1);
+	buf[5] = BIN2BCD(tm->tm_mday);
+	buf[6] = BIN2BCD(tm->tm_mon + 1);
+	val = tm->tm_year;
+	if (val >= 100) {
+		val -= 100;
+		buf[6] |= (1 << 7);
+	}
+	buf[7] = BIN2BCD(val);
+
+	msg[0].addr = client->addr;
+	msg[0].flags = 0;
+	msg[0].len = sizeof(buf);
+	msg[0].buf = &buf[0];
+
+	result = i2c_transfer(client->adapter, msg, 1);
+	if (result == 1)
+		return 0;
+
+	dev_dbg(&client->dev, "error writing data! %d\n", result);
+
+	return -EIO;
+}
+
+static int ds1337_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	return ds1337_get_datetime(to_i2c_client(dev), tm);
+}
+
+static int ds1337_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	return ds1337_set_datetime(to_i2c_client(dev), tm);
+}
+
+/* sysfs callback function */
+static ssize_t show_control(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	u8 control;
+	struct i2c_client *client = to_i2c_client(dev);
+	int err = ds1337_read(client, DS1337_REG_CONTROL, &control);
+	if (err)
+		return err;
+
+	return sprintf(buf, "%s\n", (control & 0x80) ? "disabled" : "enabled");
+}
+
+static DEVICE_ATTR(control, S_IRUGO, show_control, NULL);
+
+static struct rtc_class_ops ds1337_rtc_ops = {
+	.read_time	= ds1337_rtc_read_time,
+	.set_time	= ds1337_rtc_set_time,
+};
+
+static int ds1337_attach(struct i2c_adapter *adapter)
+{
+	return i2c_probe(adapter, &addr_data, ds1337_probe);
+}
+
+static int ds1337_detach(struct i2c_client *client)
+{
+	int err;
+	struct rtc_device *rtc = i2c_get_clientdata(client);
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
+static struct i2c_driver ds1337_driver = {
+	.driver		= {
+		.name	= "ds1337",
+	},
+	.attach_adapter = &ds1337_attach,
+	.detach_client	= &ds1337_detach,
+};
+
+static int ds1337_probe(struct i2c_adapter *adapter, int address, int kind)
+{
+	u8 val;
+	int err = 0;
+	struct i2c_client *client;
+	struct rtc_device *rtc;
+
+	dev_dbg(&adapter->dev, "%s\n", __FUNCTION__);
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_I2C)) {
+		err = -ENODEV;
+		goto exit;
+	}
+	if (!(client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	/* I2C client */
+	client->addr = address;
+	client->driver = &ds1337_driver;
+	client->adapter	= adapter;
+
+	/* Default to an DS1337 if forced */
+	if (kind == 0)
+		kind = ds1337;
+
+	if (kind < 0) {		/* detection and identification */
+		/* Check that status register bits 6-2 are zero */
+		if ((ds1337_read(client, DS1337_REG_STATUS, &val) < 0) ||
+		    (val & 0x7c))
+			goto exit_kfree;
+
+		/* Check for a valid day register value */
+		if ((ds1337_read(client, DS1337_REG_DAY, &val) < 0) ||
+		    (val == 0) || (val & 0xf8))
+			goto exit_kfree;
+
+		/* Check for a valid date register value */
+		if ((ds1337_read(client, DS1337_REG_DATE, &val) < 0) ||
+		    (val == 0) || (val & 0xc0) || ((val & 0x0f) > 9) ||
+		    (val >= 0x32))
+			goto exit_kfree;
+
+		/* Check for a valid month register value */
+		if ((ds1337_read(client, DS1337_REG_MONTH, &val) < 0) ||
+		    (val == 0) || (val & 0x60) || ((val & 0x0f) > 9) ||
+		    ((val >= 0x13) && (val <= 0x19)))
+			goto exit_kfree;
+
+		/* Check that control register bits 6-5 are zero */
+		if ((ds1337_read(client, DS1337_REG_CONTROL, &val) < 0) ||
+		    (val & 0x60))
+			goto exit_kfree;
+
+		kind = ds1337;
+	}
+
+	strlcpy(client->name, ds1337_driver.driver.name, I2C_NAME_SIZE);
+
+	/* Inform the i2c layer */
+	if ((err = i2c_attach_client(client)))
+		goto exit_kfree;
+
+	rtc = rtc_device_register(ds1337_driver.driver.name, &client->dev,
+				 &ds1337_rtc_ops, THIS_MODULE);
+
+	if (IS_ERR(rtc)) {
+		err = PTR_ERR(rtc);
+		goto exit_detach;
+	}
+
+	i2c_set_clientdata(client, rtc);
+
+	if (ds1337_read(client, DS1337_REG_CONTROL, &val) == 0)
+		i2c_smbus_write_byte_data(client, DS1337_REG_CONTROL,
+					  val & ~0x80);
+	i2c_smbus_write_byte_data(client, DS1337_REG_STATUS, 0);
+
+	if (ds1337_read(client, DS1337_REG_HOUR, &val) == 0 && (val & (1 << 6)))
+		i2c_smbus_write_byte_data(client, DS1337_REG_HOUR,
+					  val & 0x3f);
+
+	/* Register sysfs hooks */
+	device_create_file(&client->dev, &dev_attr_control);
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
+static int __init ds1337_init(void)
+{
+	return i2c_add_driver(&ds1337_driver);
+}
+
+static void __exit ds1337_exit(void)
+{
+	i2c_del_driver(&ds1337_driver);
+}
+
+MODULE_AUTHOR("Ladislav Michl <ladis@linux-mips.org>");
+MODULE_DESCRIPTION("Dallas DS1337 RTC driver");
+MODULE_LICENSE("GPL");
+
+module_init(ds1337_init);
+module_exit(ds1337_exit);
