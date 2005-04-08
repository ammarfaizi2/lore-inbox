Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262807AbVDHNKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbVDHNKk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 09:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbVDHNHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 09:07:53 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:16800 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S262812AbVDHNGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 09:06:43 -0400
Date: Fri, 8 Apr 2005 15:06:39 +0200
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] ds1337 3/4
Message-ID: <20050408130639.GC7054@orphique>
References: <20050407231848.GD27226@orphique> <u5mZNEX1.1112954918.3200720.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u5mZNEX1.1112954918.3200720.khali@localhost>
User-Agent: Mutt/1.5.6+20040907i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 12:08:38PM +0200, Jean Delvare wrote:
> Looks OK to me.

Ok, I have few more fixes for this driver and will send them later
when I find time to split them out into smaller chunks. Again, here is
patch with signed off line.


dev_{dbg,err} functions should print client's device name. data->id can
be dropped from message, because device is determined by bus it hangs on
(it has fixed address).

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

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
