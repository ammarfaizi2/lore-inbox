Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263138AbVCDXSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbVCDXSQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263289AbVCDXNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:13:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:38562 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263185AbVCDUyz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:55 -0500
Cc: shawn.starr@rogers.com
Subject: [PATCH] I2C: lm80 driver improvement
In-Reply-To: <11099685953317@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:35 -0800
Message-Id: <11099685952869@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2095, 2005/03/02 12:10:18-08:00, shawn.starr@rogers.com

[PATCH] I2C: lm80 driver improvement

Description: Cleanup some cluttered macros, add error checking for fan divisor value set.

Signed-off-by: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Shawn Starr <shawn.starr@rogers.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/lm80.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)


diff -Nru a/drivers/i2c/chips/lm80.c b/drivers/i2c/chips/lm80.c
--- a/drivers/i2c/chips/lm80.c	2005-03-04 12:25:03 -08:00
+++ b/drivers/i2c/chips/lm80.c	2005-03-04 12:25:03 -08:00
@@ -99,10 +99,7 @@
 #define TEMP_LIMIT_TO_REG(val)		SENSORS_LIMIT((val)<0?\
 					((val)-500)/1000:((val)+500)/1000,0,255)
 
-#define ALARMS_FROM_REG(val)		(val)
-
 #define DIV_FROM_REG(val)		(1 << (val))
-#define DIV_TO_REG(val)			((val)==8?3:(val)==4?2:(val)==1?0:1)
 
 /*
  * Client data (each client gets its own)
@@ -263,7 +260,17 @@
 			   DIV_FROM_REG(data->fan_div[nr]));
 
 	val = simple_strtoul(buf, NULL, 10);
-	data->fan_div[nr] = DIV_TO_REG(val);
+
+	switch (val) {
+	case 1: data->fan_div[nr] = 0; break;
+	case 2: data->fan_div[nr] = 1; break;
+	case 4: data->fan_div[nr] = 2; break;
+	case 8: data->fan_div[nr] = 3; break;
+	default:
+		dev_err(&client->dev, "fan_div value %ld not "
+			"supported. Choose one of 1, 2, 4 or 8!\n", val);
+		return -EINVAL;
+	}
 
 	reg = (lm80_read_value(client, LM80_REG_FANDIV) & ~(3 << (2 * (nr + 1))))
 	    | (data->fan_div[nr] << (2 * (nr + 1)));
@@ -321,7 +328,7 @@
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
 	struct lm80_data *data = lm80_update_device(dev);
-	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->alarms));
+	return sprintf(buf, "%u\n", data->alarms);
 }
 
 static DEVICE_ATTR(in0_min, S_IWUSR | S_IRUGO, show_in_min0, set_in_min0);

