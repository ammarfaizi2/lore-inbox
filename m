Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWBPUbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWBPUbb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 15:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWBPUba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 15:31:30 -0500
Received: from amdext4.amd.com ([163.181.251.6]:12986 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S932353AbWBPUba (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 15:31:30 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Thu, 16 Feb 2006 10:59:30 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: lm-sensors@lm-sensors.org
cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: [HWMON] Add LM82 support
Message-ID: <20060216175930.GE20157@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 16 Feb 2006 17:53:16.0386 (UTC)
 FILETIME=[DD267420:01C63321]
X-WSS-ID: 6FEA642C0BO6422524-02-01
Content-Type: multipart/mixed;
 boundary=huq684BweRXVnRxX
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This patch adds support for the LM82 temperature sensor from National
Semiconductor.  The chip is very much like the LM83 with less temperature
sensors.  The really only goofy thing here, is that the registers for the
2nd temperature sensor on the LM82 are marked as the *3rd* sensor on the
LM83, so I play a little magic to keep things all nice and linear.

For all you Geode users, the LM82 is the temperature sensor of choice
on most of our platforms, so this should be valuable for you.

Regards,
Jordan
-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

--huq684BweRXVnRxX
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=hwmon-lm83.patch
Content-Transfer-Encoding: 7bit

[HWMON] Add LM82 support

Add LM82 thermal detector support (similar to the LM83, but less featureful).

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/hwmon/lm83.c |   63 +++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index 26dfa9e..aa8b74d 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -12,6 +12,11 @@
  * Since the datasheet omits to give the chip stepping code, I give it
  * here: 0x03 (at register 0xff).
  *
+ * <jordan.crouse@amd.com>: Added LM82 support
+ * http://www.national.com/pf/LM/LM82.html - basically a stripped down
+ * model of the LM83, with only two temperatures reported.  The stepping
+ * is 0x01 (at least according to the datasheet).
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
@@ -51,7 +56,7 @@ static unsigned short normal_i2c[] = { 0
  * Insmod parameters
  */
 
-I2C_CLIENT_INSMOD_1(lm83);
+I2C_CLIENT_INSMOD_2(lm83, lm82);
 
 /*
  * The LM83 registers
@@ -142,6 +147,7 @@ struct lm83_data {
 	struct semaphore update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
+	int type;  /* Remember the type of chip */
 
 	/* registers values */
 	s8 temp[9];	/* 0..3: input 1-4,
@@ -159,7 +165,14 @@ static ssize_t show_temp(struct device *
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct lm83_data *data = lm83_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[attr->index]));
+	int index = attr->index;
+
+	if (data->type == lm82) {
+		if (index == 1 || index == 5)
+			index++;
+	}
+
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[index]));
 }
 
 static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
@@ -172,6 +185,12 @@ static ssize_t set_temp(struct device *d
 	int nr = attr->index;
 
 	down(&data->update_lock);
+
+	if (data->type == lm82) {
+		if (nr == 1 || nr == 5)
+			nr++;
+	}
+
 	data->temp[nr] = TEMP_TO_REG(val);
 	i2c_smbus_write_byte_data(client, LM83_REG_W_HIGH[nr - 4],
 				  data->temp[nr]);
@@ -283,6 +302,9 @@ static int lm83_detect(struct i2c_adapte
 			if (chip_id == 0x03) {
 				kind = lm83;
 			}
+			else if (chip_id == 0x01) {
+				kind = lm82;
+			}
 		}
 
 		if (kind <= 0) { /* identification failed */
@@ -296,10 +318,15 @@ static int lm83_detect(struct i2c_adapte
 	if (kind == lm83) {
 		name = "lm83";
 	}
+	else if (kind = lm82) {
+		name = "lm82";
+	}
 
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
 	data->valid = 0;
+	data->type = kind;
+
 	init_MUTEX(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
@@ -322,28 +349,36 @@ static int lm83_detect(struct i2c_adapte
 			   &sensor_dev_attr_temp1_input.dev_attr);
 	device_create_file(&new_client->dev,
 			   &sensor_dev_attr_temp2_input.dev_attr);
-	device_create_file(&new_client->dev,
-			   &sensor_dev_attr_temp3_input.dev_attr);
-	device_create_file(&new_client->dev,
-			   &sensor_dev_attr_temp4_input.dev_attr);
+
 	device_create_file(&new_client->dev,
 			   &sensor_dev_attr_temp1_max.dev_attr);
 	device_create_file(&new_client->dev,
 			   &sensor_dev_attr_temp2_max.dev_attr);
-	device_create_file(&new_client->dev,
-			   &sensor_dev_attr_temp3_max.dev_attr);
-	device_create_file(&new_client->dev,
-			   &sensor_dev_attr_temp4_max.dev_attr);
+
 	device_create_file(&new_client->dev,
 			   &sensor_dev_attr_temp1_crit.dev_attr);
 	device_create_file(&new_client->dev,
 			   &sensor_dev_attr_temp2_crit.dev_attr);
-	device_create_file(&new_client->dev,
-			   &sensor_dev_attr_temp3_crit.dev_attr);
-	device_create_file(&new_client->dev,
-			   &sensor_dev_attr_temp4_crit.dev_attr);
+
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
+	if (kind == lm83) {
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_temp3_input.dev_attr);
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_temp4_input.dev_attr);
+
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_temp3_max.dev_attr);
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_temp4_max.dev_attr);
+
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_temp3_crit.dev_attr);
+		device_create_file(&new_client->dev,
+				   &sensor_dev_attr_temp4_crit.dev_attr);
+	}
+
 	return 0;
 
 exit_detach:

--huq684BweRXVnRxX--

