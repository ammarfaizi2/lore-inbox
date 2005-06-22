Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbVFVGhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbVFVGhF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbVFVGeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:34:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:24476 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262795AbVFVFWE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:04 -0400
Cc: ladis@linux-mips.org
Subject: [PATCH] I2C: ds1337 3/4
In-Reply-To: <1119417462982@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:42 -0700
Message-Id: <11194174621986@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: ds1337 3/4

dev_{dbg,err} functions should print client's device name. data->id can
be dropped from message, because device is determined by bus it hangs on
(it has fixed address).

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit d01b79d0613ebb6810bb48baf6e53e9319701fea
tree 49f92093fae3b372011b1f2855cf581d9a1ad1e4
parent 6069ffde15472da9d041a58df490d388bb175d51
author Ladislav Michl <ladis@linux-mips.org> Fri, 08 Apr 2005 15:06:39 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:51 -0700

 drivers/i2c/chips/ds1337.c |   25 ++++++++-----------------
 1 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
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

