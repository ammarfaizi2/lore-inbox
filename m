Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVCATXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVCATXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 14:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVCATXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 14:23:15 -0500
Received: from ptb-relay02.plus.net ([212.159.14.213]:46353 "EHLO
	ptb-relay02.plus.net") by vger.kernel.org with ESMTP
	id S262026AbVCATWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 14:22:06 -0500
Message-ID: <4224C0D4.2060303@katalix.com>
Date: Tue, 01 Mar 2005 19:21:56 +0000
From: James Chapman <jchapman@katalix.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH: 2.6.11-rc5] i2c chips: ds1337 RTC driver
References: <42235171.80500@katalix.com> <20050301075413.GC3791@kroah.com>
In-Reply-To: <20050301075413.GC3791@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------070001070003090003000500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070001070003090003000500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Revised ds1337 chip driver patch.

Signed-off-by: James Chapman <jchapman@katalix.com>

- change all driver log messages to use dev_dbg() or dev_err()
- remove debug module parameter

Greg KH wrote:

> On Mon, Feb 28, 2005 at 05:14:25PM +0000, James Chapman wrote:
> 
>>+/* Define to compile in pr_debug() trace */
>>+#undef DEBUG
> 
> 
> Not needed, we do this in the makefile now.
> 
> 
>>+	if (debug >= 1)
>>+		pr_debug("%s: client=%p, dt=%p\n", __FUNCTION__, client, dt);
> 
> 
> Please use the dev_dbg(), dev_err() and friend functions instead of
> pr_debug().  It provides a sane user interface that all of the other
> drivers use.
> 
> thanks,
> 
> greg k-h

--------------070001070003090003000500
Content-Type: text/plain;
 name="ds1337.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ds1337.patch"

diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	2005-02-27 20:42:22 +00:00
+++ b/drivers/i2c/chips/Kconfig	2005-02-27 20:42:22 +00:00
@@ -62,6 +62,17 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called asb100.
 
+config SENSORS_DS1337
+      	tristate "Dallas Semiconductor DS1337 Real Time Clock"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Dallas Semiconductor
+	  DS1337 real-time clock chips. 
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ds1337.
+
 config SENSORS_DS1621
       	tristate "Dallas Semiconductor DS1621 and DS1625"
 	depends on I2C && EXPERIMENTAL
diff -Nru a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile	2005-02-27 20:42:22 +00:00
+++ b/drivers/i2c/chips/Makefile	2005-02-27 20:42:22 +00:00
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
+++ b/drivers/i2c/chips/ds1337.c	2005-02-27 20:42:22 +00:00
@@ -0,0 +1,384 @@
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
+#define DS1337_NUM_REGS		16
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
+static int ds1337_command(struct i2c_client *client, unsigned int cmd, void *arg);
+
+/*
+ * Driver data (common to all clients)
+ */
+static struct i2c_driver ds1337_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "ds1337",
+	.id		= I2C_DRIVERID_DS1337,
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
+static int ds1337_id = 0;
+static LIST_HEAD(ds1337_clients);
+
+static inline int ds1337_read(struct i2c_client *client, u8 reg, u8 *value)
+{
+	s32 tmp = i2c_smbus_read_byte_data(client, reg);
+
+	if (tmp < 0)
+		return -EIO;
+
+	*value = (u8) (tmp & 0xff);
+
+	return 0;
+}
+
+/*
+ * Chip access functions
+ */
+static int ds1337_get_datetime(struct i2c_client *client, struct rtc_time *dt)
+{
+	int result;
+	u8 buf[7];
+	u8 val;
+	struct i2c_msg msg[2];
+	u8 offs = 0;
+
+	if (!dt || !client) {
+		dev_dbg(&client->adapter->dev, "%s: EINVAL: client=%p, dt=%p\n", 
+			__FUNCTION__, client, dt);
+
+		return -EINVAL;
+	}
+
+	memset(buf, 0, sizeof(buf));
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
+						    &msg[0],
+						    2);
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
+			"data! %d\n", client->id, result);
+		result = -EIO;
+	}
+
+	return result;
+}
+
+static int ds1337_set_datetime(struct i2c_client *client, struct rtc_time *dt)
+{
+	int result;
+	u8 buf[8];
+	u8 val;
+	struct i2c_msg msg[1];
+
+	if (!dt || !client) {
+		dev_dbg(&client->adapter->dev, "%s: EINVAL: client=%p, dt=%p\n", 
+			__FUNCTION__, client, dt);
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
+			"writing data! %d\n", client->id, result);
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
+/* Public API for access to specific device. Useful for low-level
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
+		if (data->id == id) {
+			return ds1337_command(&data->client, cmd, arg);
+		}
+	}
+
+	return -ENODEV;
+}
+
+static int ds1337_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
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
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto exit;
+
+	if (!(data = kmalloc(sizeof(struct ds1337_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	memset(data, 0, sizeof(struct ds1337_data));
+	INIT_LIST_HEAD(&data->list);
+
+	err = -ENODEV;
+
+	/* The common I2C client data is placed right before the
+	   DS1337-specific data. */
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
+	 */
+
+	/* Default to an DS1337 if forced */
+	if (kind == 0)
+		kind = ds1337;
+
+	if (kind < 0) {		/* detection and identification */
+
+		u8 buf[DS1337_NUM_REGS];
+		int reg;
+
+		/* Check that all DS1337 registers are present */
+		for (reg = 0; reg < DS1337_NUM_REGS; reg++)
+			if (ds1337_read(new_client, reg, &buf[reg]) < 0)
+				goto exit_free;
+
+		/* Check that control register bits 5-6 are zero */
+		if (buf[14] & ((1 << 5) | (1 << 6)))
+			goto exit_free;
+
+		/* Check that status register bits 2-6 are zero */
+		if (buf[15] & ((1 << 2) | (1 << 3) | (1 << 4) |
+			       (1 << 5) | (1 << 6)))
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
+	new_client->id = ds1337_id++;
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_free;
+
+	/* Initialize the DS1337 chip */
+	ds1337_init_client(new_client);
+
+	/* Add client to local list */
+	data->id = new_client->id;
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
+	u8 val;
+
+	/* Ensure that device is set in 24-hour mode */
+	val = i2c_smbus_read_byte_data(client, 2);
+	i2c_smbus_write_byte_data(client, 2, val | (1 << 6));
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

--------------070001070003090003000500--
