Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVCaXcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVCaXcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 18:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVCaXaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 18:30:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:24032 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262062AbVCaXYE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 18:24:04 -0500
Cc: jchapman@katalix.com
Subject: [PATCH] i2c: new driver for ds1337 RTC
In-Reply-To: <11123113911463@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 31 Mar 2005 15:23:11 -0800
Message-Id: <11123113913563@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2331, 2005/03/31 14:08:02-08:00, jchapman@katalix.com

[PATCH] i2c: new driver for ds1337 RTC

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/Kconfig  |   11 +
 drivers/i2c/chips/Makefile |    1 
 drivers/i2c/chips/ds1337.c |  402 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 414 insertions(+)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	2005-03-31 15:18:15 -08:00
+++ b/drivers/i2c/chips/Kconfig	2005-03-31 15:18:15 -08:00
@@ -362,6 +362,17 @@
 menu "Other I2C Chip support"
 	depends on I2C
 
+config SENSORS_DS1337
+	tristate "Dallas Semiconductor DS1337 Real Time Clock"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Dallas Semiconductor
+	  DS1337 real-time clock chips. 
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ds1337.
+
 config SENSORS_EEPROM
 	tristate "EEPROM reader"
 	depends on I2C && EXPERIMENTAL
diff -Nru a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile	2005-03-31 15:18:15 -08:00
+++ b/drivers/i2c/chips/Makefile	2005-03-31 15:18:15 -08:00
@@ -11,6 +11,7 @@
 obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
 obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
 obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
+obj-$(CONFIG_SENSORS_DS1337)	+= ds1337.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
 obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
diff -Nru a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/i2c/chips/ds1337.c	2005-03-31 15:18:15 -08:00
@@ -0,0 +1,402 @@
+/*
+ *  linux/drivers/i2c/chips/ds1337.c
+ *
+ *  Copyright (C) 2005 James Chapman <jchapman@katalix.com>
+ *
+ *	based on linux/drivers/acron/char/pcf8583.c
+ *  Copyright (C) 2000 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Driver for Dallas Semiconductor DS1337 real time clock chip
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#include <linux/string.h>
+#include <linux/rtc.h>		/* get the user-level API */
+#include <linux/bcd.h>
+#include <linux/list.h>
+
+/* Device registers */
+#define DS1337_REG_HOUR		2
+#define DS1337_REG_DAY		3
+#define DS1337_REG_DATE		4
+#define DS1337_REG_MONTH	5
+#define DS1337_REG_CONTROL	14
+#define DS1337_REG_STATUS	15
+
+/* FIXME - how do we export these interface constants? */
+#define DS1337_GET_DATE		0
+#define DS1337_SET_DATE		1
+
+/*
+ * Functions declaration
+ */
+static unsigned short normal_i2c[] = { 0x68, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+
+SENSORS_INSMOD_1(ds1337);
+
+static int ds1337_attach_adapter(struct i2c_adapter *adapter);
+static int ds1337_detect(struct i2c_adapter *adapter, int address, int kind);
+static void ds1337_init_client(struct i2c_client *client);
+static int ds1337_detach_client(struct i2c_client *client);
+static int ds1337_command(struct i2c_client *client, unsigned int cmd,
+			  void *arg);
+
+/*
+ * Driver data (common to all clients)
+ */
+static struct i2c_driver ds1337_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "ds1337",
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= ds1337_attach_adapter,
+	.detach_client	= ds1337_detach_client,
+	.command	= ds1337_command,
+};
+
+/*
+ * Client data (each client gets its own)
+ */
+struct ds1337_data {
+	struct i2c_client client;
+	struct list_head list;
+	int id;
+};
+
+/*
+ * Internal variables
+ */
+static int ds1337_id;
+static LIST_HEAD(ds1337_clients);
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
+/*
+ * Chip access functions
+ */
+static int ds1337_get_datetime(struct i2c_client *client, struct rtc_time *dt)
+{
+	struct ds1337_data *data = i2c_get_clientdata(client);
+	int result;
+	u8 buf[7];
+	u8 val;
+	struct i2c_msg msg[2];
+	u8 offs = 0;
+
+	if (!dt) {
+		dev_dbg(&client->adapter->dev, "%s: EINVAL: dt=NULL\n",
+			__FUNCTION__);
+
+		return -EINVAL;
+	}
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
+	result = client->adapter->algo->master_xfer(client->adapter,
+						    &msg[0], 2);
+
+	dev_dbg(&client->adapter->dev,
+		"%s: [%d] %02x %02x %02x %02x %02x %02x %02x\n",
+		__FUNCTION__, result, buf[0], buf[1], buf[2], buf[3],
+		buf[4], buf[5], buf[6]);
+
+	if (result >= 0) {
+		dt->tm_sec = BCD_TO_BIN(buf[0]);
+		dt->tm_min = BCD_TO_BIN(buf[1]);
+		val = buf[2] & 0x3f;
+		dt->tm_hour = BCD_TO_BIN(val);
+		dt->tm_wday = BCD_TO_BIN(buf[3]) - 1;
+		dt->tm_mday = BCD_TO_BIN(buf[4]);
+		val = buf[5] & 0x7f;
+		dt->tm_mon = BCD_TO_BIN(val);
+		dt->tm_year = 1900 + BCD_TO_BIN(buf[6]);
+		if (buf[5] & 0x80)
+			dt->tm_year += 100;
+
+		dev_dbg(&client->adapter->dev, "%s: secs=%d, mins=%d, "
+			"hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
+			__FUNCTION__, dt->tm_sec, dt->tm_min,
+			dt->tm_hour, dt->tm_mday,
+			dt->tm_mon, dt->tm_year, dt->tm_wday);
+	} else {
+		dev_err(&client->adapter->dev, "ds1337[%d]: error reading "
+			"data! %d\n", data->id, result);
+		result = -EIO;
+	}
+
+	return result;
+}
+
+static int ds1337_set_datetime(struct i2c_client *client, struct rtc_time *dt)
+{
+	struct ds1337_data *data = i2c_get_clientdata(client);
+	int result;
+	u8 buf[8];
+	u8 val;
+	struct i2c_msg msg[1];
+
+	if (!dt) {
+		dev_dbg(&client->adapter->dev, "%s: EINVAL: dt=NULL\n",
+			__FUNCTION__);
+
+		return -EINVAL;
+	}
+
+	dev_dbg(&client->adapter->dev, "%s: secs=%d, mins=%d, hours=%d, "
+		"mday=%d, mon=%d, year=%d, wday=%d\n", __FUNCTION__,
+		dt->tm_sec, dt->tm_min, dt->tm_hour,
+		dt->tm_mday, dt->tm_mon, dt->tm_year, dt->tm_wday);
+
+	buf[0] = 0;		/* reg offset */
+	buf[1] = BIN_TO_BCD(dt->tm_sec);
+	buf[2] = BIN_TO_BCD(dt->tm_min);
+	buf[3] = BIN_TO_BCD(dt->tm_hour) | (1 << 6);
+	buf[4] = BIN_TO_BCD(dt->tm_wday) + 1;
+	buf[5] = BIN_TO_BCD(dt->tm_mday);
+	buf[6] = BIN_TO_BCD(dt->tm_mon);
+	if (dt->tm_year >= 2000) {
+		val = dt->tm_year - 2000;
+		buf[6] |= (1 << 7);
+	} else {
+		val = dt->tm_year - 1900;
+	}
+	buf[7] = BIN_TO_BCD(val);
+
+	msg[0].addr = client->addr;
+	msg[0].flags = 0;
+	msg[0].len = sizeof(buf);
+	msg[0].buf = &buf[0];
+
+	result = client->adapter->algo->master_xfer(client->adapter,
+						    &msg[0], 1);
+	if (result < 0) {
+		dev_err(&client->adapter->dev, "ds1337[%d]: error "
+			"writing data! %d\n", data->id, result);
+		result = -EIO;
+	} else {
+		result = 0;
+	}
+
+	return result;
+}
+
+static int ds1337_command(struct i2c_client *client, unsigned int cmd,
+			  void *arg)
+{
+	dev_dbg(&client->adapter->dev, "%s: cmd=%d\n", __FUNCTION__, cmd);
+
+	switch (cmd) {
+	case DS1337_GET_DATE:
+		return ds1337_get_datetime(client, arg);
+
+	case DS1337_SET_DATE:
+		return ds1337_set_datetime(client, arg);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Public API for access to specific device. Useful for low-level
+ * RTC access from kernel code.
+ */
+int ds1337_do_command(int id, int cmd, void *arg)
+{
+	struct list_head *walk;
+	struct list_head *tmp;
+	struct ds1337_data *data;
+
+	list_for_each_safe(walk, tmp, &ds1337_clients) {
+		data = list_entry(walk, struct ds1337_data, list);
+		if (data->id == id)
+			return ds1337_command(&data->client, cmd, arg);
+	}
+
+	return -ENODEV;
+}
+
+static int ds1337_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, ds1337_detect);
+}
+
+/*
+ * The following function does more than just detection. If detection
+ * succeeds, it also registers the new chip.
+ */
+static int ds1337_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *new_client;
+	struct ds1337_data *data;
+	int err = 0;
+	const char *name = "";
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_I2C))
+		goto exit;
+
+	if (!(data = kmalloc(sizeof(struct ds1337_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	memset(data, 0, sizeof(struct ds1337_data));
+	INIT_LIST_HEAD(&data->list);
+
+	/* The common I2C client data is placed right before the
+	 * DS1337-specific data. 
+	 */
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &ds1337_driver;
+	new_client->flags = 0;
+
+	/*
+	 * Now we do the remaining detection. A negative kind means that
+	 * the driver was loaded with no force parameter (default), so we
+	 * must both detect and identify the chip. A zero kind means that
+	 * the driver was loaded with the force parameter, the detection
+	 * step shall be skipped. A positive kind means that the driver
+	 * was loaded with the force parameter and a given kind of chip is
+	 * requested, so both the detection and the identification steps
+	 * are skipped.
+	 *
+	 * For detection, we read registers that are most likely to cause
+	 * detection failure, i.e. those that have more bits with fixed
+	 * or reserved values.
+	 */
+
+	/* Default to an DS1337 if forced */
+	if (kind == 0)
+		kind = ds1337;
+
+	if (kind < 0) {		/* detection and identification */
+		u8 data;
+
+		/* Check that status register bits 6-2 are zero */
+		if ((ds1337_read(new_client, DS1337_REG_STATUS, &data) < 0) ||
+		    (data & 0x7c))
+			goto exit_free;
+
+		/* Check for a valid day register value */
+		if ((ds1337_read(new_client, DS1337_REG_DAY, &data) < 0) ||
+		    (data == 0) || (data & 0xf8))
+			goto exit_free;
+
+		/* Check for a valid date register value */
+		if ((ds1337_read(new_client, DS1337_REG_DATE, &data) < 0) ||
+		    (data == 0) || (data & 0xc0) || ((data & 0x0f) > 9) ||
+		    (data >= 0x32))
+			goto exit_free;
+
+		/* Check for a valid month register value */
+		if ((ds1337_read(new_client, DS1337_REG_MONTH, &data) < 0) ||
+		    (data == 0) || (data & 0x60) || ((data & 0x0f) > 9) ||
+		    ((data >= 0x13) && (data <= 0x19)))
+			goto exit_free;
+
+		/* Check that control register bits 6-5 are zero */
+		if ((ds1337_read(new_client, DS1337_REG_CONTROL, &data) < 0) ||
+		    (data & 0x60))
+			goto exit_free;
+
+		kind = ds1337;
+	}
+
+	if (kind == ds1337)
+		name = "ds1337";
+
+	/* We can fill in the remaining client fields */
+	strlcpy(new_client->name, name, I2C_NAME_SIZE);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_free;
+
+	/* Initialize the DS1337 chip */
+	ds1337_init_client(new_client);
+
+	/* Add client to local list */
+	data->id = ds1337_id++;
+	list_add(&data->list, &ds1337_clients);
+
+	return 0;
+
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+static void ds1337_init_client(struct i2c_client *client)
+{
+	s32 val;
+
+	/* Ensure that device is set in 24-hour mode */
+	val = i2c_smbus_read_byte_data(client, DS1337_REG_HOUR);
+	if ((val >= 0) && (val & (1 << 6)) == 0)
+		i2c_smbus_write_byte_data(client, DS1337_REG_HOUR,
+					  val | (1 << 6));
+}
+
+static int ds1337_detach_client(struct i2c_client *client)
+{
+	int err;
+	struct ds1337_data *data = i2c_get_clientdata(client);
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev, "Client deregistration failed, "
+			"client not detached.\n");
+		return err;
+	}
+
+	list_del(&data->list);
+	kfree(data);
+	return 0;
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
+MODULE_AUTHOR("James Chapman <jchapman@katalix.com>");
+MODULE_DESCRIPTION("DS1337 RTC driver");
+MODULE_LICENSE("GPL");
+
+module_init(ds1337_init);
+module_exit(ds1337_exit);

