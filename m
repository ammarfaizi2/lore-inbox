Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161264AbWAIAro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161264AbWAIAro (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 19:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161258AbWAIArV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 19:47:21 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:61669 "EHLO
	linux") by vger.kernel.org with ESMTP id S1161259AbWAIAqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 19:46:38 -0500
Message-Id: <20060108231256.632236000@linux>
References: <20060108231235.153748000@linux>
Date: Mon, 09 Jan 2006 00:12:43 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] RTC subsystem, DS1672 driver
Content-Disposition: inline; filename=rtc-drv-ds1672.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Driver for the Dallas/Maxim DS1672 chip, found
on the Loft (http://www.giantshoulderinc.com) .


Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
--
 drivers/rtc/Kconfig      |   10 +
 drivers/rtc/Makefile     |    1 
 drivers/rtc/rtc-ds1672.c |  266 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 277 insertions(+)

--- linux-nslu2.orig/drivers/rtc/Kconfig	2006-01-08 18:44:16.000000000 +0100
+++ linux-nslu2/drivers/rtc/Kconfig	2006-01-08 18:44:16.000000000 +0100
@@ -65,6 +65,16 @@ config RTC_DRV_X1205
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-x1205.
 
+config RTC_DRV_DS1672
+	tristate "Dallas/Maxim DS1672"
+	depends on RTC_CLASS && I2C
+	help
+	  If you say yes here you get support for the
+	  Dallas/Maxim DS1672 timekeeping chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-ds1672.
+
 config RTC_DRV_TEST
 	tristate "Test driver/device"
 	depends on RTC_CLASS
--- linux-nslu2.orig/drivers/rtc/Makefile	2006-01-08 18:44:16.000000000 +0100
+++ linux-nslu2/drivers/rtc/Makefile	2006-01-08 18:44:16.000000000 +0100
@@ -11,4 +11,5 @@ obj-$(CONFIG_RTC_INTF_DEV)	+= rtc-dev.o
 
 obj-$(CONFIG_RTC_DRV_X1205)	+= rtc-x1205.o
 obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
+obj-$(CONFIG_RTC_DRV_DS1672)	+= rtc-ds1672.o
 
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-nslu2/drivers/rtc/rtc-ds1672.c	2006-01-08 18:44:16.000000000 +0100
@@ -0,0 +1,266 @@
+/*
+ * An rtc/i2c driver for the Dallas DS1672
+ * Copyright 2005 Alessandro Zummo
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/rtc.h>
+
+#define DRV_VERSION "0.1"
+
+/* Addresses to scan: none. This chip cannot be detected. */
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD;
+I2C_CLIENT_MODULE_PARM(hctosys,
+	"Set the system time from the hardware clock upon initialization");
+
+/* Registers */
+
+#define DS1672_REG_CNT_BASE	0
+#define DS1672_REG_CONTROL	4
+#define DS1672_REG_TRICKLE	5
+
+
+/* Prototypes */
+static int ds1672_probe(struct i2c_adapter *adapter, int address, int kind);
+
+/*
+ * In the routines that deal directly with the ds1672 hardware, we use
+ * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch
+ * Epoch is initialized as 2000. Time is set to UTC.
+ */
+static int ds1672_get_datetime(struct i2c_client *client, struct rtc_time *tm)
+{
+	unsigned long time;
+	unsigned char buf[4];
+
+	dev_dbg(&client->dev,
+		"%s: raw read data - counters=%02x,%02x,%02x,%02x\n"
+		__FUNCTION__,
+		buf[0], buf[1], buf[2], buf[3]);
+
+	time = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
+
+	rtc_time_to_tm(time, tm);
+
+	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
+		"mday=%d, mon=%d, year=%d, wday=%d\n",
+		__FUNCTION__,
+		tm->tm_sec, tm->tm_min, tm->tm_hour,
+		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
+
+	return 0;
+}
+
+static int ds1672_set_mmss(struct i2c_client *client, unsigned long secs)
+{
+	int xfer;
+	unsigned char buf[5];
+
+	buf[0] = DS1672_REG_CNT_BASE;
+	buf[1] = secs & 0x000000FF;
+	buf[2] = (secs & 0x0000FF00) >> 8;
+	buf[3] = (secs & 0x00FF0000) >> 16;
+	buf[4] = (secs & 0xFF000000) >> 24;
+
+	xfer = i2c_master_send(client, buf, 5);
+	if (xfer != 5) {
+		dev_err(&client->dev, "%s: send: %d\n", __FUNCTION__, xfer);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int ds1672_set_datetime(struct i2c_client *client, struct rtc_time *tm)
+{
+	unsigned long secs;
+
+	dev_dbg(&client->dev,
+		"%s: secs=%d, mins=%d, hours=%d, ",
+		"mday=%d, mon=%d, year=%d, wday=%d\n",
+		__FUNCTION__,
+		tm->tm_sec, tm->tm_min, tm->tm_hour,
+		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
+
+	rtc_tm_to_time(tm, &secs);
+
+	return ds1672_set_mmss(client, secs);
+}
+
+static int ds1672_hctosys(struct i2c_client *client)
+{
+	int err;
+	struct rtc_time tm;
+	struct timespec tv;
+
+	if ((err = ds1672_get_datetime(client, &tm)) != 0)
+		return err;
+
+	/* IMPORTANT: the RTC only stores whole seconds. It is arbitrary
+	 * whether it stores the most close value or the value with partial
+	 * seconds truncated. However, it is important that we use it to store
+	 * the truncated value. This is because otherwise it is necessary,
+	 * in an rtc sync function, to read both xtime.tv_sec and
+	 * xtime.tv_nsec. On some processors (i.e. ARM), an atomic read
+	 * of >32bits is not possible. So storing the most close value would
+	 * slow down the sync API. So here we have the truncated value and
+	 * the best guess is to add 0.5s.
+	 */
+
+	tv.tv_nsec = NSEC_PER_SEC >> 1;
+
+	rtc_tm_to_time(&tm, &tv.tv_sec);
+
+	do_settimeofday(&tv);
+
+	dev_info(&client->dev,
+		"setting the system clock to %d-%02d-%02d %02d:%02d:%02d\n",
+		tm.tm_year + 1900, tm.tm_mon + 1,
+		tm.tm_mday, tm.tm_hour, tm.tm_min,
+		tm.tm_sec);
+
+	return 0;
+}
+
+static int ds1672_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	return ds1672_get_datetime(to_i2c_client(dev), tm);
+}
+
+static int ds1672_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	return ds1672_set_datetime(to_i2c_client(dev), tm);
+}
+
+static int ds1672_rtc_set_mmss(struct device *dev, unsigned long secs)
+{
+	return ds1672_set_mmss(to_i2c_client(dev), secs);
+}
+
+static struct rtc_class_ops ds1672_rtc_ops = {
+	.read_time = ds1672_rtc_read_time,
+	.set_time = ds1672_rtc_set_time,
+	.set_mmss = ds1672_rtc_set_mmss,
+};
+
+static int ds1672_attach(struct i2c_adapter *adapter)
+{
+	dev_dbg(&adapter->dev, "%s\n", __FUNCTION__);
+
+	return i2c_probe(adapter, &addr_data, ds1672_probe);
+}
+
+static int ds1672_detach(struct i2c_client *client)
+{
+	int err;
+	struct rtc_device *rtc = i2c_get_clientdata(client);
+
+	dev_dbg(&client->dev, "%s\n", __FUNCTION__);
+
+ 	if (rtc)
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
+static struct i2c_driver ds1672_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "ds1672",
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter = &ds1672_attach,
+	.detach_client	= &ds1672_detach,
+};
+
+static int ds1672_probe(struct i2c_adapter *adapter, int address, int kind)
+{
+	int err = 0;
+	struct i2c_client *client;
+	struct rtc_device *rtc;
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
+	/* I2C client */
+	client->addr = address;
+	client->driver = &ds1672_driver;
+	client->adapter	= adapter;
+
+	strlcpy(client->name, ds1672_driver.name, I2C_NAME_SIZE);
+
+	/* Inform the i2c layer */
+	if ((err = i2c_attach_client(client)))
+		goto exit_kfree;
+
+	dev_info(&client->dev, "chip found, driver version " DRV_VERSION "\n");
+
+	rtc = rtc_device_register(ds1672_driver.name, &client->dev,
+				&ds1672_rtc_ops, THIS_MODULE);
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
+	/* If requested, set the system time */
+	if (hctosys) {
+		if ((err = ds1672_hctosys(client)) < 0)
+			dev_err(&client->dev,
+				"unable to set the system clock\n");
+	}
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
+static int __init ds1672_init(void)
+{
+	return i2c_add_driver(&ds1672_driver);
+}
+
+static void __exit ds1672_exit(void)
+{
+	i2c_del_driver(&ds1672_driver);
+}
+
+MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
+MODULE_DESCRIPTION("Dallas/Maxim DS1672 timekeeper driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
+module_init(ds1672_init);
+module_exit(ds1672_exit);

--
