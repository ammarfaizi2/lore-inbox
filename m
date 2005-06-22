Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbVFVGrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVFVGrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbVFVGpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:45:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:21660 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262792AbVFVFWB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:01 -0400
Cc: ladis@linux-mips.org
Subject: [PATCH] I2C: ds1337: i2c_transfer() checking
In-Reply-To: <1119417462508@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:42 -0700
Message-Id: <11194174624039@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: ds1337: i2c_transfer() checking

i2c_transfer returns number of sucessfully transfered messages. Change
error checking to accordingly. (ds1337_set_datetime never returned
sucess)

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 00588243053bb40d0406c7843833f8fae81294ab
tree abf967a76d51f002a878ce6e6544c0b1c6cde62e
parent 0b46e334d77b2d3b8b3aa665c81c4afbe9f1f458
author Ladislav Michl <ladis@linux-mips.org> Wed, 04 May 2005 08:13:54 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:51 -0700

 drivers/i2c/chips/ds1337.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -122,7 +122,7 @@ static int ds1337_get_datetime(struct i2
 		__FUNCTION__, result, buf[0], buf[1], buf[2], buf[3],
 		buf[4], buf[5], buf[6]);
 
-	if (result >= 0) {
+	if (result == 2) {
 		dt->tm_sec = BCD2BIN(buf[0]);
 		dt->tm_min = BCD2BIN(buf[1]);
 		val = buf[2] & 0x3f;
@@ -140,12 +140,12 @@ static int ds1337_get_datetime(struct i2
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
@@ -185,14 +185,11 @@ static int ds1337_set_datetime(struct i2
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

