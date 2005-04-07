Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbVDGJpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVDGJpq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 05:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262405AbVDGJpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 05:45:46 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:50892 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S262406AbVDGJox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 05:44:53 -0400
Date: Thu, 7 Apr 2005 11:45:06 +0200
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com,
       jchapman@katalix.com
Subject: Re: [PATCH] i2c: new driver for ds1337 RTC
Message-ID: <20050407094506.GA19360@orphique>
References: <11123113911463@kroah.com> <11123113913563@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11123113913563@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2005 at 03:23:11PM -0800, Greg KH wrote:
> ChangeSet 1.2331, 2005/03/31 14:08:02-08:00, jchapman@katalix.com
> 
> [PATCH] i2c: new driver for ds1337 RTC

Hi,

I know it is bad time to send any patches, but lets try anyway :)

My embedded device is using DS1339 I2C RTC clock which differs from
DS1337 only in one register at address 10h which enables battery charge.
Originaly I was using my own driver, but decided to extend existing
one. Chip detection is done automaticaly, see ds1337_is_ds1339 function
and comment above. While playing with code, few things seemed strange to
me, so here is comment:

* driver is using adapter->algo->master_xfer function without checking
  it is present and without holding bus lock. That looks insane to me.
  fixed.

* BCD_TO_BIN is inteded to use this way: BCD_TO_BIN(val); Drive changed
  to use BCD2BIN.

* Changed dev_dbg to print "dev" of device this driver is for not
  adapter's dev.

* Changed get/set time to be compatible with other RTC drivers, ie.
  epoch is handled separately. That should be done in RTC interface
  part [*].

Driver is tested and works with DS1339, detection algoritm was tested
with extending address space to 18 bytes in DS1339. Please test on
DS1337 as well. Comments and suggestions welcome.

Now questions. It seems most I2C RTC drivers are based on Russell King's
drivers/acorn/char/pcf8583.c, but lacks RTC interface part [*] found in
drivers/acorn/char/i2c.c. How are they intended to be used? Is there any
generic interface to I2C RTC drivers? (Shall I write one? ;-))

Best regards,
	ladis

===== drivers/i2c/chips/ds1337.c 1.1 vs edited =====
--- 1.1/drivers/i2c/chips/ds1337.c	2005-03-31 22:58:08 +02:00
+++ edited/drivers/i2c/chips/ds1337.c	2005-04-07 11:28:06 +02:00
@@ -2,15 +2,16 @@
  *  linux/drivers/i2c/chips/ds1337.c
  *
  *  Copyright (C) 2005 James Chapman <jchapman@katalix.com>
+ *  Copyright (C) 2005 Ladislav Michl <ladis@linux-mips.org>
  *
- *	based on linux/drivers/acron/char/pcf8583.c
+ *	based on linux/drivers/acorn/char/pcf8583.c
  *  Copyright (C) 2000 Russell King
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * Driver for Dallas Semiconductor DS1337 real time clock chip
+ * Driver for Dallas Semiconductor DS1337 and DS1339 real time clock chip
  */
 
 #include <linux/config.h>
@@ -25,12 +26,13 @@
 #include <linux/list.h>
 
 /* Device registers */
-#define DS1337_REG_HOUR		2
-#define DS1337_REG_DAY		3
-#define DS1337_REG_DATE		4
-#define DS1337_REG_MONTH	5
-#define DS1337_REG_CONTROL	14
-#define DS1337_REG_STATUS	15
+#define DS1337_REG_HOUR		0x02
+#define DS1337_REG_DAY		0x03
+#define DS1337_REG_DATE		0x04
+#define DS1337_REG_MONTH	0x05
+#define DS1337_REG_CONTROL	0x0e
+#define DS1337_REG_STATUS	0x0f
+#define DS1339_REG_CHARGE	0x10
 
 /* FIXME - how do we export these interface constants? */
 #define DS1337_GET_DATE		0
@@ -42,7 +44,7 @@
 static unsigned short normal_i2c[] = { 0x68, I2C_CLIENT_END };
 static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
-SENSORS_INSMOD_1(ds1337);
+SENSORS_INSMOD_2(ds1337, ds1339);
 
 static int ds1337_attach_adapter(struct i2c_adapter *adapter);
 static int ds1337_detect(struct i2c_adapter *adapter, int address, int kind);
@@ -78,6 +80,8 @@
 static int ds1337_id;
 static LIST_HEAD(ds1337_clients);
 
+static int ds1339_charge = 0xaa;
+
 static inline int ds1337_read(struct i2c_client *client, u8 reg, u8 *value)
 {
 	s32 tmp = i2c_smbus_read_byte_data(client, reg);
@@ -90,119 +94,100 @@
 	return 0;
 }
 
-/*
- * Chip access functions
+/* 
+ * DS1339 has Trickle Charge register at address 10h. During a multibyte
+ * access, when the address pointer reaches the end of the register space,
+ * it wraps around to location 00h.
+ * We read 17 bytes from device and compare first and last one. If they are
+ * same it is most likely DS1337 chip.
  */
-static int ds1337_get_datetime(struct i2c_client *client, struct rtc_time *dt)
+static int ds1337_is_ds1339(struct i2c_client *client)
 {
-	struct ds1337_data *data = i2c_get_clientdata(client);
-	int result;
-	u8 buf[7];
-	u8 val;
-	struct i2c_msg msg[2];
-	u8 offs = 0;
-
-	if (!dt) {
-		dev_dbg(&client->adapter->dev, "%s: EINVAL: dt=NULL\n",
-			__FUNCTION__);
+	unsigned char buf[17] = { 0, }, addr[1] = { 0 };
+	struct i2c_msg msgs[2] = {
+		{ client->addr, 0,         1, addr },
+		{ client->addr, I2C_M_RD, 17, buf  }
+	};
+	int result = i2c_transfer(client->adapter, msgs, 2);
 
-		return -EINVAL;
-	}
-
-	msg[0].addr = client->addr;
-	msg[0].flags = 0;
-	msg[0].len = 1;
-	msg[0].buf = &offs;
-
-	msg[1].addr = client->addr;
-	msg[1].flags = I2C_M_RD;
-	msg[1].len = sizeof(buf);
-	msg[1].buf = &buf[0];
+	if (result < 0) {
+		dev_err(&client->dev, "error reading data! %d\n", result);
+		return 0;
+	} else
+		return (buf[0] == buf[16]) ? 0 : 1;
+}
 
-	result = client->adapter->algo->master_xfer(client->adapter,
-						    &msg[0], 2);
+/*
+ * Chip access functions
+ */
+static int ds1337_get_datetime(struct i2c_client *client, struct rtc_time *tm)
+{
+	unsigned char buf[7] = { 0, }, addr[1] = { 0 };
+	struct i2c_msg msgs[2] = {
+		{ client->addr, 0,        1, addr },
+		{ client->addr, I2C_M_RD, 7, buf  }
+	};
+	int result = i2c_transfer(client->adapter, msgs, 2);
 
-	dev_dbg(&client->adapter->dev,
+	dev_dbg(&client->dev,
 		"%s: [%d] %02x %02x %02x %02x %02x %02x %02x\n",
 		__FUNCTION__, result, buf[0], buf[1], buf[2], buf[3],
 		buf[4], buf[5], buf[6]);
 
-	if (result >= 0) {
-		dt->tm_sec = BCD_TO_BIN(buf[0]);
-		dt->tm_min = BCD_TO_BIN(buf[1]);
-		val = buf[2] & 0x3f;
-		dt->tm_hour = BCD_TO_BIN(val);
-		dt->tm_wday = BCD_TO_BIN(buf[3]) - 1;
-		dt->tm_mday = BCD_TO_BIN(buf[4]);
-		val = buf[5] & 0x7f;
-		dt->tm_mon = BCD_TO_BIN(val);
-		dt->tm_year = 1900 + BCD_TO_BIN(buf[6]);
+	if (result < 0) {
+		dev_err(&client->dev, "error reading data! %d\n", result);
+		result = -EIO;
+	} else {
+		tm->tm_sec  = BCD2BIN(buf[0]);
+		tm->tm_min  = BCD2BIN(buf[1]);
+		tm->tm_hour = BCD2BIN(buf[2] & 0x3f);
+		tm->tm_wday = BCD2BIN(buf[3]);
+		tm->tm_mday = BCD2BIN(buf[4]);
+		tm->tm_mon  = BCD2BIN(buf[5] & 0x7f) - 1;
+		tm->tm_year = BCD2BIN(buf[6]);
 		if (buf[5] & 0x80)
-			dt->tm_year += 100;
+			tm->tm_year += 100;
 
-		dev_dbg(&client->adapter->dev, "%s: secs=%d, mins=%d, "
-			"hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
-			__FUNCTION__, dt->tm_sec, dt->tm_min,
-			dt->tm_hour, dt->tm_mday,
-			dt->tm_mon, dt->tm_year, dt->tm_wday);
-	} else {
-		dev_err(&client->adapter->dev, "ds1337[%d]: error reading "
-			"data! %d\n", data->id, result);
-		result = -EIO;
+		dev_dbg(&client->dev, "%s: secs=%d, mins=%d, hours=%d, "
+			"mday=%d, mon=%d, year=%d, wday=%d\n", __FUNCTION__,
+			tm->tm_sec, tm->tm_min, tm->tm_hour,
+			tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
+		
+		result = 0;
 	}
 
 	return result;
 }
 
-static int ds1337_set_datetime(struct i2c_client *client, struct rtc_time *dt)
+static int ds1337_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 {
-	struct ds1337_data *data = i2c_get_clientdata(client);
+	unsigned char buf[8];
 	int result;
-	u8 buf[8];
-	u8 val;
-	struct i2c_msg msg[1];
-
-	if (!dt) {
-		dev_dbg(&client->adapter->dev, "%s: EINVAL: dt=NULL\n",
-			__FUNCTION__);
-
-		return -EINVAL;
-	}
 
-	dev_dbg(&client->adapter->dev, "%s: secs=%d, mins=%d, hours=%d, "
+	dev_dbg(&client->dev, "%s: secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n", __FUNCTION__,
-		dt->tm_sec, dt->tm_min, dt->tm_hour,
-		dt->tm_mday, dt->tm_mon, dt->tm_year, dt->tm_wday);
+		tm->tm_sec, tm->tm_min, tm->tm_hour,
+		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
 
 	buf[0] = 0;		/* reg offset */
-	buf[1] = BIN_TO_BCD(dt->tm_sec);
-	buf[2] = BIN_TO_BCD(dt->tm_min);
-	buf[3] = BIN_TO_BCD(dt->tm_hour) | (1 << 6);
-	buf[4] = BIN_TO_BCD(dt->tm_wday) + 1;
-	buf[5] = BIN_TO_BCD(dt->tm_mday);
-	buf[6] = BIN_TO_BCD(dt->tm_mon);
-	if (dt->tm_year >= 2000) {
-		val = dt->tm_year - 2000;
+	buf[1] = BIN2BCD(tm->tm_sec);
+	buf[2] = BIN2BCD(tm->tm_min);
+	buf[3] = BIN2BCD(tm->tm_hour) | (1 << 6);
+	buf[4] = BIN2BCD(tm->tm_wday);
+	buf[5] = BIN2BCD(tm->tm_mday);
+	buf[6] = BIN2BCD(tm->tm_mon + 1);
+	if (tm->tm_year >= 100) {
+		tm->tm_year -= 100;
 		buf[6] |= (1 << 7);
-	} else {
-		val = dt->tm_year - 1900;
 	}
-	buf[7] = BIN_TO_BCD(val);
-
-	msg[0].addr = client->addr;
-	msg[0].flags = 0;
-	msg[0].len = sizeof(buf);
-	msg[0].buf = &buf[0];
+	buf[7] = BIN2BCD(tm->tm_year);
 
-	result = client->adapter->algo->master_xfer(client->adapter,
-						    &msg[0], 1);
+	result = i2c_master_send(client, (char *)buf, sizeof(buf));
 	if (result < 0) {
-		dev_err(&client->adapter->dev, "ds1337[%d]: error "
-			"writing data! %d\n", data->id, result);
+		dev_err(&client->dev, "error writing data! %d\n", result);
 		result = -EIO;
-	} else {
+	} else
 		result = 0;
-	}
 
 	return result;
 }
@@ -210,7 +195,14 @@
 static int ds1337_command(struct i2c_client *client, unsigned int cmd,
 			  void *arg)
 {
-	dev_dbg(&client->adapter->dev, "%s: cmd=%d\n", __FUNCTION__, cmd);
+	dev_dbg(&client->dev, "%s: cmd=%d\n", __FUNCTION__, cmd);
+
+	if (!arg) {
+		dev_dbg(&client->dev, "%s: EINVAL: arg=NULL\n",
+			__FUNCTION__);
+
+		return -EINVAL;
+	}
 
 	switch (cmd) {
 	case DS1337_GET_DATE:
@@ -254,10 +246,10 @@
  */
 static int ds1337_detect(struct i2c_adapter *adapter, int address, int kind)
 {
-	struct i2c_client *new_client;
+	struct i2c_client *client;
 	struct ds1337_data *data;
+	char *name;
 	int err = 0;
-	const char *name = "";
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_I2C))
@@ -273,12 +265,12 @@
 	/* The common I2C client data is placed right before the
 	 * DS1337-specific data. 
 	 */
-	new_client = &data->client;
-	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
-	new_client->adapter = adapter;
-	new_client->driver = &ds1337_driver;
-	new_client->flags = 0;
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &ds1337_driver;
+	client->flags = 0;
 
 	/*
 	 * Now we do the remaining detection. A negative kind means that
@@ -303,51 +295,72 @@
 		u8 data;
 
 		/* Check that status register bits 6-2 are zero */
-		if ((ds1337_read(new_client, DS1337_REG_STATUS, &data) < 0) ||
+		if ((ds1337_read(client, DS1337_REG_STATUS, &data) < 0) ||
 		    (data & 0x7c))
 			goto exit_free;
 
 		/* Check for a valid day register value */
-		if ((ds1337_read(new_client, DS1337_REG_DAY, &data) < 0) ||
+		if ((ds1337_read(client, DS1337_REG_DAY, &data) < 0) ||
 		    (data == 0) || (data & 0xf8))
 			goto exit_free;
 
 		/* Check for a valid date register value */
-		if ((ds1337_read(new_client, DS1337_REG_DATE, &data) < 0) ||
+		if ((ds1337_read(client, DS1337_REG_DATE, &data) < 0) ||
 		    (data == 0) || (data & 0xc0) || ((data & 0x0f) > 9) ||
 		    (data >= 0x32))
 			goto exit_free;
 
 		/* Check for a valid month register value */
-		if ((ds1337_read(new_client, DS1337_REG_MONTH, &data) < 0) ||
+		if ((ds1337_read(client, DS1337_REG_MONTH, &data) < 0) ||
 		    (data == 0) || (data & 0x60) || ((data & 0x0f) > 9) ||
 		    ((data >= 0x13) && (data <= 0x19)))
 			goto exit_free;
 
 		/* Check that control register bits 6-5 are zero */
-		if ((ds1337_read(new_client, DS1337_REG_CONTROL, &data) < 0) ||
+		if ((ds1337_read(client, DS1337_REG_CONTROL, &data) < 0) ||
 		    (data & 0x60))
 			goto exit_free;
 
-		kind = ds1337;
+		/* Check whenever we have DS1339 */
+		if (ds1337_is_ds1339(client))
+			kind = ds1339;
+		else
+			kind = ds1337;
 	}
 
-	if (kind == ds1337)
+	switch (kind) {
+	case ds1337:
 		name = "ds1337";
+		break;
+	case ds1339:
+		name = "ds1339";
+		break;
+	default:
+		name = "";
+	}
 
 	/* We can fill in the remaining client fields */
-	strlcpy(new_client->name, name, I2C_NAME_SIZE);
+	strlcpy(client->name, name, I2C_NAME_SIZE);
 
 	/* Tell the I2C layer a new client has arrived */
-	if ((err = i2c_attach_client(new_client)))
+	if ((err = i2c_attach_client(client)))
 		goto exit_free;
 
 	/* Initialize the DS1337 chip */
-	ds1337_init_client(new_client);
+	ds1337_init_client(client);
 
 	/* Add client to local list */
 	data->id = ds1337_id++;
 	list_add(&data->list, &ds1337_clients);
+
+	/* Be nice to battery */
+	if (kind == ds1339 && ds1339_charge) {
+		char buf[] = { DS1339_REG_CHARGE, ds1339_charge };
+
+		if (i2c_master_send(client, buf, sizeof(buf)) != sizeof(buf))
+			dev_err(&client->dev,
+				"failed to enable trickle charge.\n");
+	}
 
 	return 0;
 
