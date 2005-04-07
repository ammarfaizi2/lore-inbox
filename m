Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVDGPe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVDGPe5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 11:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVDGPeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 11:34:46 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:64679 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S262491AbVDGPdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 11:33:40 -0400
Date: Thu, 7 Apr 2005 16:28:04 +0200
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>
Subject: Re: [PATCH] i2c: new driver for ds1337 RTC
Message-ID: <20050407142804.GA11284@orphique>
References: <20050407111631.GA21190@orphique> <hOrXV5wl.1112879260.3338120.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hOrXV5wl.1112879260.3338120.khali@localhost>
User-Agent: Mutt/1.5.6+20040907i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jean,

On Thu, Apr 07, 2005 at 03:07:40PM +0200, Jean Delvare wrote:
> > I have objection ;-) Nothing in kernel seems to use that driver (...)
> 
> How would you know? It has a user-space interface
> (ds1337_driver.command), which anyone might be using.

I asked how is this driver supposed to interface with the rest of world.
pcf8583.c nor rtc8564.c are returing year as is, both needs epoch
to be added, so whoever is using this interface has to be aware of this
"feature". That's something what should be resolved. James?

> > (...) and driver wasn't reviewed well enough before including.
> 
> I did review this driver. Thanks for the compliment, I really appreciate.

I'm sorry, it wasn't mean to be personal. What was IMHO overlooked is in
changelog below.

[snip]
> > Hexadecimal constant are there to match datasheet, (...)
> 
> And anyone may argue that decimal values are easier to read, (...)

I'm always trying to follow manual and I agree not everyone does the
same. Change droped. (Note: This way you do not need to know reading,
comparing shapes is enough :))

> (...) or whatever, and send a revert patch next week? James did it
> that way, values are correct. I see no point in changing them.
[snip]
> I'm not sure if it qualifies as impolite, but I can tell you won't get
> anywhere with such an attitude. Trust me, I've been there before, and
> changed.

Okay, let's finally keep only technical aspects. I want to use James
driver instead of mine even if it means more work for me. If that won't
work out, I won't get anywhere and will use what works for me :)

Here is yet another patch this time fixes only.
CHANGELOG:
* use i2_tranfer function instead of adapter->algo->master_xfer, so
  we have proper bus locking.
* BCD2BIN and BIN2BCD are proper macros to use here, see linux/bcd.h
* Move NULL argument checking from get/set date functions to
  ds1337_command function, so it is only at one place. Note that other
  drivers do not this checking at all and I think it is pointess,
  because you have to know that you are passing struct rtc_time anyway.
* dev_dbg should probably print info about device driver we are
  debugging so client->dev looks as better choice than
  client->adapter->dev.

Best regards,
	ladis

===== drivers/i2c/chips/ds1337.c 1.1 vs edited =====
--- 1.1/drivers/i2c/chips/ds1337.c	2005-03-31 22:58:08 +02:00
+++ edited/drivers/i2c/chips/ds1337.c	2005-04-07 15:47:26 +02:00
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
@@ -95,60 +96,38 @@
  */
 static int ds1337_get_datetime(struct i2c_client *client, struct rtc_time *dt)
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
+	unsigned char buf[7] = { 0, }, addr[1] = { 0 };
+	struct i2c_msg msgs[2] = {
+		{ client->addr, 0,        1, addr },
+		{ client->addr, I2C_M_RD, 7, buf  }
+	};
+	int result = i2c_transfer(client->adapter, msgs, 2);
 
-	result = client->adapter->algo->master_xfer(client->adapter,
-						    &msg[0], 2);
-
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
+		dt->tm_sec  = BCD2BIN(buf[0]);
+		dt->tm_min  = BCD2BIN(buf[1]);
+		dt->tm_hour = BCD2BIN(buf[2] & 0x3f);
+		dt->tm_wday = BCD2BIN(buf[3]) - 1;
+		dt->tm_mday = BCD2BIN(buf[4]);
+		dt->tm_mon  = BCD2BIN(buf[5] & 0x7f) - 1;
+		dt->tm_year = BCD2BIN(buf[6]) + 1900;
 		if (buf[5] & 0x80)
 			dt->tm_year += 100;
 
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
+			dt->tm_sec, dt->tm_min, dt->tm_hour,
+			dt->tm_mday, dt->tm_mon, dt->tm_year, dt->tm_wday);
+		
+		result = 0;
 	}
 
 	return result;
@@ -156,53 +135,33 @@
 
 static int ds1337_set_datetime(struct i2c_client *client, struct rtc_time *dt)
 {
-	struct ds1337_data *data = i2c_get_clientdata(client);
+	unsigned char buf[8];
 	int result;
-	u8 buf[8];
-	u8 val;
-	struct i2c_msg msg[1];
 
-	if (!dt) {
-		dev_dbg(&client->adapter->dev, "%s: EINVAL: dt=NULL\n",
-			__FUNCTION__);
-
-		return -EINVAL;
-	}
-
-	dev_dbg(&client->adapter->dev, "%s: secs=%d, mins=%d, hours=%d, "
+	dev_dbg(&client->dev, "%s: secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n", __FUNCTION__,
 		dt->tm_sec, dt->tm_min, dt->tm_hour,
 		dt->tm_mday, dt->tm_mon, dt->tm_year, dt->tm_wday);
 
 	buf[0] = 0;		/* reg offset */
-	buf[1] = BIN_TO_BCD(dt->tm_sec);
-	buf[2] = BIN_TO_BCD(dt->tm_min);
-	buf[3] = BIN_TO_BCD(dt->tm_hour) | (1 << 6);
-	buf[4] = BIN_TO_BCD(dt->tm_wday) + 1;
-	buf[5] = BIN_TO_BCD(dt->tm_mday);
-	buf[6] = BIN_TO_BCD(dt->tm_mon);
+	buf[1] = BIN2BCD(dt->tm_sec);
+	buf[2] = BIN2BCD(dt->tm_min);
+	buf[3] = BIN2BCD(dt->tm_hour) | (1 << 6);
+	buf[4] = BIN2BCD(dt->tm_wday);
+	buf[5] = BIN2BCD(dt->tm_mday) + 1;
+	buf[6] = BIN2BCD(dt->tm_mon + 1);
 	if (dt->tm_year >= 2000) {
-		val = dt->tm_year - 2000;
 		buf[6] |= (1 << 7);
-	} else {
-		val = dt->tm_year - 1900;
-	}
-	buf[7] = BIN_TO_BCD(val);
+		buf[7] = BIN2BCD(dt->tm_year - 2000);
+	} else
+		buf[7] = BIN2BCD(dt->tm_year - 1900);
 
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
@@ -210,7 +169,14 @@
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
