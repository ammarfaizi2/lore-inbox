Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVA3CJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVA3CJN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 21:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVA3CJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 21:09:13 -0500
Received: from smtp104.rog.mail.re2.yahoo.com ([206.190.36.82]:18809 "HELO
	smtp104.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261629AbVA3CJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 21:09:05 -0500
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6.11-rc2] I2C: lm80 driver improvement - again...
Date: Sat, 29 Jan 2005 21:08:55 -0500
User-Agent: KMail/1.7.2
Cc: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org,
       lm78@stimpy.netroedge.com
References: <20050127090358.GC1528@kroah.com> <20050127165646.97935.qmail@web88003.mail.re2.yahoo.com> <20050129232537.GA14798@kroah.com>
In-Reply-To: <20050129232537.GA14798@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4GE/BP6lRPY2c0Z"
Message-Id: <200501292108.56248.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_4GE/BP6lRPY2c0Z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Description: Cleanup some cluttered macros, add error checking for fan divisor value set.

Signed-off-by: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Shawn Starr <shawn.starr@rogers.com>


--Boundary-00=_4GE/BP6lRPY2c0Z
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lm80-fixup-3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lm80-fixup-3.diff"


Description: Cleanup some cluttered macros, add error checking for fan divisor value set.

Approved-by: Greg KH <greg@kroah.com>
Signed-off-by: Sytse Wielinga <s.b.wielinga@student.utwente.nl>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Shawn Starr <shawn.starr@rogers.com>

--- linux-2.6.11-rc2/drivers/i2c/chips/lm80.c	2005-01-26 02:04:38.000000000 -0500
+++ linux-2.6.11-rc2-fixes/drivers/i2c/chips/lm80.c	2005-01-26 12:31:26.000000000 -0500
@@ -99,10 +99,7 @@ static inline long TEMP_FROM_REG(u16 tem
 #define TEMP_LIMIT_TO_REG(val)		SENSORS_LIMIT((val)<0?\
 					((val)-500)/1000:((val)+500)/1000,0,255)
 
-#define ALARMS_FROM_REG(val)		(val)
-
 #define DIV_FROM_REG(val)		(1 << (val))
-#define DIV_TO_REG(val)			((val)==8?3:(val)==4?2:(val)==1?0:1)
 
 /*
  * Client data (each client gets its own)
@@ -269,7 +266,17 @@ static ssize_t set_fan_div(struct device
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
@@ -327,7 +334,7 @@ set_temp(os_hyst, temp_os_hyst, LM80_REG
 static ssize_t show_alarms(struct device *dev, char *buf)
 {
 	struct lm80_data *data = lm80_update_device(dev);
-	return sprintf(buf, "%d\n", ALARMS_FROM_REG(data->alarms));
+	return sprintf(buf, "%u\n", data->alarms);
 }
 
 static DEVICE_ATTR(in0_min, S_IWUSR | S_IRUGO, show_in_min0, set_in_min0);

--Boundary-00=_4GE/BP6lRPY2c0Z--
