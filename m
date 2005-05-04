Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVEDHg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVEDHg6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVEDHeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:34:08 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:64440 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S262076AbVEDH3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:29:06 -0400
Date: Wed, 4 May 2005 08:13:54 +0200
To: Greg KH <greg@kroah.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>,
       James Chapman <jchapman@katalix.com>
Subject: [PATCH] ds1337 2/3
Message-ID: <20050504061354.GC1439@orphique>
References: <20050407231848.GD27226@orphique> <u5mZNEX1.1112954918.3200720.khali@localhost> <20050408130639.GC7054@orphique> <20050502204136.GE32713@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502204136.GE32713@kroah.com>
User-Agent: Mutt/1.5.9i
From: Ladislav Michl <ladis@linux-mips.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i2c_transfer returns number of sucessfully transfered messages. Change
error checking to accordingly. (ds1337_set_datetime never returned
sucess)

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: James Chapman <jchapman@katalix.com>

--- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-04-20 20:08:46.580603672 +0200
+++ linux-omap/drivers/i2c/chips/ds1337.c	2005-04-20 20:34:31.622721568 +0200
@@ -122,7 +122,7 @@
 		__FUNCTION__, result, buf[0], buf[1], buf[2], buf[3],
 		buf[4], buf[5], buf[6]);
 
-	if (result >= 0) {
+	if (result == 2) {
 		dt->tm_sec = BCD2BIN(buf[0]);
 		dt->tm_min = BCD2BIN(buf[1]);
 		val = buf[2] & 0x3f;
@@ -140,12 +140,12 @@
 			__FUNCTION__, dt->tm_sec, dt->tm_min,
 			dt->tm_hour, dt->tm_mday,
 			dt->tm_mon, dt->tm_year, dt->tm_wday);
-	} else {
-		dev_err(&client->dev, "error reading data! %d\n", result);
-		result = -EIO;
+
+		return 0;
 	}
 
-	return result;
+	dev_err(&client->dev, "error reading data! %d\n", result);
+	return -EIO;
 }
 
 static int ds1337_set_datetime(struct i2c_client *client, struct rtc_time *dt)
@@ -185,14 +185,11 @@
 	msg[0].buf = &buf[0];
 
 	result = i2c_transfer(client->adapter, msg, 1);
-	if (result < 0) {
-		dev_err(&client->dev, "error writing data! %d\n", result);
-		result = -EIO;
-	} else {
-		result = 0;
-	}
+	if (result == 1)
+		return 0;
 
-	return result;
+	dev_err(&client->dev, "error writing data! %d\n", result);
+	return -EIO;
 }
 
 static int ds1337_command(struct i2c_client *client, unsigned int cmd,
