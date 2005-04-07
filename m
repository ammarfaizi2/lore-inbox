Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262425AbVDGL1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVDGL1f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 07:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVDGL1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 07:27:34 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:53411 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S262425AbVDGLXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 07:23:39 -0400
Date: Thu, 7 Apr 2005 13:16:31 +0200
To: Jean Delvare <khali@linux-fr.org>
Cc: greg@kroah.com, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>
Subject: Re: [PATCH] i2c: new driver for ds1337 RTC
Message-ID: <20050407111631.GA21190@orphique>
References: <20050407094506.GA19360@orphique> <8iOUo9nl.1112867945.5643950.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8iOUo9nl.1112867945.5643950.khali@localhost>
User-Agent: Mutt/1.5.6+20040907i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 11:59:05AM +0200, Jean Delvare wrote:
> Please slice this into separarte patches. Adding support for the DS1339
> is one thing, bug fixes are another. I can't review patches which do
> that many different things at once.

I have objection ;-) Nothing in kernel seems to use that driver and
driver wasn't reviewed well enough before including. Therefore I'm still
considering it as a new driver which can be easily reviewed as whole.

> As a side note, please avoid noise in your patch. Converting constants
> from decimal to hexadecimal or renaming variables makes my review job
> way harder, as it distracts me from the real point of your patch.

Hexadecimal constant are there to match datasheet, local variables
should be short and with new_client is was reaching 80 column limit,
that's coding style and that's why I made that change.

Please consider that I would suggest these changes to driver author
before his patch went in tree in case I would read all that mailing
lists around. I'm lazy, my bad... Driver's author should have probably
last word anyway.

> Once you realize that the time I need to review a patch increases in a
> quadratic way (if not worse) relatively to the length of the patch, I am
> sure you will see why it is important to send small patches doing just
> one thing without noise.

Ok, sending cleanup fixes only.  Support for ds1339 will be in separate
patch. Sorry I won't do more, because my time is also limited.

Here is patch which does cleanup/fixes only. It is still hard to review,
but that's living. I won't split it to smaller parts just because I had
to touch each single line in get/set date functions. Sorry if it sounds
impolite, but now I can't spend more time on it. Perhaps later, if
anyone don't buy it as is meanwhile... Please let me know when/if you will
accept support for DS1339.

Best regards,
	ladis

===== drivers/i2c/chips/ds1337.c 1.1 vs edited =====
--- 1.1/drivers/i2c/chips/ds1337.c	2005-03-31 22:58:08 +02:00
+++ edited/drivers/i2c/chips/ds1337.c	2005-04-07 13:02:18 +02:00
@@ -2,8 +2,9 @@
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
@@ -93,116 +95,74 @@
 /*
  * Chip access functions
  */
-static int ds1337_get_datetime(struct i2c_client *client, struct rtc_time *dt)
+static int ds1337_get_datetime(struct i2c_client *client, struct rtc_time *tm)
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
-
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
-
-	result = client->adapter->algo->master_xfer(client->adapter,
-						    &msg[0], 2);
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
 
-		return -EINVAL;
-	}
-
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
+	buf[7] = BIN2BCD(tm->tm_year);
 
-	msg[0].addr = client->addr;
-	msg[0].flags = 0;
-	msg[0].len = sizeof(buf);
-	msg[0].buf = &buf[0];
-
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
@@ -210,7 +170,7 @@
 static int ds1337_command(struct i2c_client *client, unsigned int cmd,
 			  void *arg)
 {
-	dev_dbg(&client->adapter->dev, "%s: cmd=%d\n", __FUNCTION__, cmd);
+	dev_dbg(&client->dev, "%s: cmd=%d\n", __FUNCTION__, cmd);
 
 	switch (cmd) {
 	case DS1337_GET_DATE:
@@ -254,10 +214,10 @@
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
@@ -273,12 +233,12 @@
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
@@ -303,47 +263,52 @@
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
 
 		kind = ds1337;
 	}
 
-	if (kind == ds1337)
+	switch (kind) {
+	case ds1337:
 		name = "ds1337";
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
