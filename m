Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbVDGXUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVDGXUB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 19:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVDGXTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 19:19:38 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:10155 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S262612AbVDGXSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 19:18:53 -0400
Date: Fri, 8 Apr 2005 01:18:48 +0200
To: Greg KH <greg@kroah.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>
Subject: [PATCH] ds1337 3/4
Message-ID: <20050407231848.GD27226@orphique>
References: <20050407111631.GA21190@orphique> <hOrXV5wl.1112879260.3338120.khali@localhost> <20050407142804.GA11284@orphique> <20050407211839.GA5357@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407211839.GA5357@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dev_{dbg,err} functions should print client's device name. data->id can
be dropped from message, because device is determined by bus it hangs on
(it has fixed address).

--- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-04-08 00:36:15.072302800 +0200
+++ linux-omap/drivers/i2c/chips/ds1337.c	2005-04-08 00:44:44.130914128 +0200
@@ -95,7 +95,6 @@ static inline int ds1337_read(struct i2c
  */
 static int ds1337_get_datetime(struct i2c_client *client, struct rtc_time *dt)
 {
-	struct ds1337_data *data = i2c_get_clientdata(client);
 	int result;
 	u8 buf[7];
 	u8 val;
@@ -103,9 +102,7 @@ static int ds1337_get_datetime(struct i2
 	u8 offs = 0;
 
 	if (!dt) {
-		dev_dbg(&client->adapter->dev, "%s: EINVAL: dt=NULL\n",
-			__FUNCTION__);
-
+		dev_dbg(&client->dev, "%s: EINVAL: dt=NULL\n", __FUNCTION__);
 		return -EINVAL;
 	}
 
@@ -121,8 +118,7 @@ static int ds1337_get_datetime(struct i2
 
 	result = i2c_transfer(client->adapter, msg, 2);
 
-	dev_dbg(&client->adapter->dev,
-		"%s: [%d] %02x %02x %02x %02x %02x %02x %02x\n",
+	dev_dbg(&client->dev, "%s: [%d] %02x %02x %02x %02x %02x %02x %02x\n",
 		__FUNCTION__, result, buf[0], buf[1], buf[2], buf[3],
 		buf[4], buf[5], buf[6]);
 
@@ -139,14 +135,13 @@ static int ds1337_get_datetime(struct i2
 		if (buf[5] & 0x80)
 			dt->tm_year += 100;
 
-		dev_dbg(&client->adapter->dev, "%s: secs=%d, mins=%d, "
+		dev_dbg(&client->dev, "%s: secs=%d, mins=%d, "
 			"hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
 			__FUNCTION__, dt->tm_sec, dt->tm_min,
 			dt->tm_hour, dt->tm_mday,
 			dt->tm_mon, dt->tm_year, dt->tm_wday);
 	} else {
-		dev_err(&client->adapter->dev, "ds1337[%d]: error reading "
-			"data! %d\n", data->id, result);
+		dev_err(&client->dev, "error reading data! %d\n", result);
 		result = -EIO;
 	}
 
@@ -155,20 +150,17 @@ static int ds1337_get_datetime(struct i2
 
 static int ds1337_set_datetime(struct i2c_client *client, struct rtc_time *dt)
 {
-	struct ds1337_data *data = i2c_get_clientdata(client);
 	int result;
 	u8 buf[8];
 	u8 val;
 	struct i2c_msg msg[1];
 
 	if (!dt) {
-		dev_dbg(&client->adapter->dev, "%s: EINVAL: dt=NULL\n",
-			__FUNCTION__);
-
+		dev_dbg(&client->dev, "%s: EINVAL: dt=NULL\n", __FUNCTION__);
 		return -EINVAL;
 	}
 
-	dev_dbg(&client->adapter->dev, "%s: secs=%d, mins=%d, hours=%d, "
+	dev_dbg(&client->dev, "%s: secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n", __FUNCTION__,
 		dt->tm_sec, dt->tm_min, dt->tm_hour,
 		dt->tm_mday, dt->tm_mon, dt->tm_year, dt->tm_wday);
@@ -195,8 +187,7 @@ static int ds1337_set_datetime(struct i2
 
 	result = i2c_transfer(client->adapter, msg, 1);
 	if (result < 0) {
-		dev_err(&client->adapter->dev, "ds1337[%d]: error "
-			"writing data! %d\n", data->id, result);
+		dev_err(&client->dev, "error writing data! %d\n", result);
 		result = -EIO;
 	} else {
 		result = 0;
@@ -208,7 +199,7 @@ static int ds1337_set_datetime(struct i2
 static int ds1337_command(struct i2c_client *client, unsigned int cmd,
 			  void *arg)
 {
-	dev_dbg(&client->adapter->dev, "%s: cmd=%d\n", __FUNCTION__, cmd);
+	dev_dbg(&client->dev, "%s: cmd=%d\n", __FUNCTION__, cmd);
 
 	switch (cmd) {
 	case DS1337_GET_DATE:
