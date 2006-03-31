Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWCaKGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWCaKGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 05:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWCaKFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 05:05:21 -0500
Received: from 213-140-6-124.ip.fastwebnet.it ([213.140.6.124]:14893 "EHLO
	linux") by vger.kernel.org with ESMTP id S932083AbWCaKEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 05:04:48 -0500
Message-Id: <20060331100423.564073000@towertech.it>
References: <20060331100423.175139000@towertech.it>
User-Agent: quilt/0.43-1
Date: Fri, 31 Mar 2006 12:04:25 +0200
From: Alessandro Zummo <a.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Cc: akpm@zip.com.au, akpm@osdl.org, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 02/10] RTC subsystem, DS1672 cleanup
Content-Disposition: inline; filename=rtc-subsys-ds1672-tidy.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - removed a duplicate error message
 - bumped driver version
 - removed some debugging messages in excess
 - refined the formatting
 - adjusted copyright notice


Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
Cc: Kumar Gala <galak@kernel.crashing.org>

---
 drivers/rtc/rtc-ds1672.c |   29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

--- linux-rtc.orig/drivers/rtc/rtc-ds1672.c	2006-03-29 02:16:01.000000000 +0200
+++ linux-rtc/drivers/rtc/rtc-ds1672.c	2006-03-29 02:29:43.000000000 +0200
@@ -1,6 +1,8 @@
 /*
  * An rtc/i2c driver for the Dallas DS1672
- * Copyright 2005 Alessandro Zummo
+ * Copyright 2005-06 Tower Technologies
+ *
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -11,7 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/rtc.h>
 
-#define DRV_VERSION "0.2"
+#define DRV_VERSION "0.3"
 
 /* Addresses to scan: none. This chip cannot be detected. */
 static unsigned short normal_i2c[] = { I2C_CLIENT_END };
@@ -23,9 +25,9 @@ I2C_CLIENT_INSMOD;
 
 #define DS1672_REG_CNT_BASE	0
 #define DS1672_REG_CONTROL	4
-#define DS1672_REG_CONTROL_EOSC	0x80
 #define DS1672_REG_TRICKLE	5
 
+#define DS1672_REG_CONTROL_EOSC	0x80
 
 /* Prototypes */
 static int ds1672_probe(struct i2c_adapter *adapter, int address, int kind);
@@ -54,8 +56,7 @@ static int ds1672_get_datetime(struct i2
 
 	dev_dbg(&client->dev,
 		"%s: raw read data - counters=%02x,%02x,%02x,%02x\n"
-		__FUNCTION__,
-		buf[0], buf[1], buf[2], buf[3]);
+		__FUNCTION__, buf[0], buf[1], buf[2], buf[3]);
 
 	time = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
 
@@ -63,8 +64,7 @@ static int ds1672_get_datetime(struct i2
 
 	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
-		__FUNCTION__,
-		tm->tm_sec, tm->tm_min, tm->tm_hour,
+		__FUNCTION__, tm->tm_sec, tm->tm_min, tm->tm_hour,
 		tm->tm_mday, tm->tm_mon, tm->tm_year, tm->tm_wday);
 
 	return 0;
@@ -144,7 +144,6 @@ static int ds1672_get_control(struct i2c
 static ssize_t show_control(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
-	char *state = "enabled";
 	u8 control;
 	int err;
 
@@ -152,12 +151,9 @@ static ssize_t show_control(struct devic
 	if (err)
 		return err;
 
-	if (control & DS1672_REG_CONTROL_EOSC)
-		state = "disabled";
-
-	return sprintf(buf, "%s\n", state);
+	return sprintf(buf, "%s\n", (control & DS1672_REG_CONTROL_EOSC)
+					? "disabled" : "enabled");
 }
-
 static DEVICE_ATTR(control, S_IRUGO, show_control, NULL);
 
 static struct rtc_class_ops ds1672_rtc_ops = {
@@ -168,7 +164,6 @@ static struct rtc_class_ops ds1672_rtc_o
 
 static int ds1672_attach(struct i2c_adapter *adapter)
 {
-	dev_dbg(&adapter->dev, "%s\n", __FUNCTION__);
 	return i2c_probe(adapter, &addr_data, ds1672_probe);
 }
 
@@ -177,8 +172,6 @@ static int ds1672_detach(struct i2c_clie
 	int err;
 	struct rtc_device *rtc = i2c_get_clientdata(client);
 
-	dev_dbg(&client->dev, "%s\n", __FUNCTION__);
-
  	if (rtc)
 		rtc_device_unregister(rtc);
 
@@ -245,10 +238,8 @@ static int ds1672_probe(struct i2c_adapt
 
 	/* read control register */
 	err = ds1672_get_control(client, &control);
-	if (err) {
-		dev_err(&client->dev, "%s: read error\n", __FUNCTION__);
+	if (err)
 		goto exit_detach;
-	}
 
 	if (control & DS1672_REG_CONTROL_EOSC)
 		dev_warn(&client->dev, "Oscillator not enabled. "

--
