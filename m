Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWHTUn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWHTUn7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 16:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWHTUn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 16:43:58 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:11468 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751381AbWHTUn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 16:43:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=XuZvgkBUl5sFjdG5xmeS9yxBiY9X7HEA7qHn2+rcoEE2GaiOgMPSEWMyDQZ9Z2Jwhd7vI91/QXp1NQd4hFOybCQOW0QrEtZm1JYsGvgoOWqzEbUmb1TvU03P3d0yZAl8s6dhrobW+FkWMlueKjn/AshqZBl7nBSSVii/ZjDssQA=
Message-ID: <44E8C9AE.3060307@gmail.com>
Date: Sun, 20 Aug 2006 22:44:30 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Frodo Looijaard <frodol@dds.nl>,
       Philip Edelbrock <phil@netroedge.com>,
       Mark Studebaker <mdsxyz123@yahoo.com>, lm-sensors@lm-sensors.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] hwmon:fix sparse warnings + error handling
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes 56 sparse "ignoring return value of 'device_create_file'" warnings. It also adds error handling.

w83627hf.c |   96 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------
1 file changed, 80 insertions(+), 16 deletions(-)

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)

Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/hwmon/w83627hf.c linux-work/drivers/hwmon/w83627hf.c
--- linux-work-clean/drivers/hwmon/w83627hf.c	2006-08-20 22:02:40.000000000 +0200
+++ linux-work/drivers/hwmon/w83627hf.c	2006-08-20 22:27:14.000000000 +0200
@@ -513,9 +513,21 @@ static DEVICE_ATTR(in0_max, S_IRUGO | S_

 #define device_create_file_in(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_in##offset##_input); \
-device_create_file(&client->dev, &dev_attr_in##offset##_min); \
-device_create_file(&client->dev, &dev_attr_in##offset##_max); \
+	err = device_create_file(&client->dev, &dev_attr_in##offset##_input); \
+	if (err) {\
+		hwmon_device_unregister(data->class_dev); \
+		return err; \
+	} \
+	err = device_create_file(&client->dev, &dev_attr_in##offset##_min); \
+	if (err) {\
+		hwmon_device_unregister(data->class_dev); \
+		return err; \
+	} \
+	err = device_create_file(&client->dev, &dev_attr_in##offset##_max); \
+	if (err) {\
+		hwmon_device_unregister(data->class_dev); \
+		return err; \
+	} \
 } while (0)

 #define show_fan_reg(reg) \
@@ -577,8 +589,16 @@ sysfs_fan_min_offset(3);

 #define device_create_file_fan(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
-device_create_file(&client->dev, &dev_attr_fan##offset##_min); \
+	err = device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
+	if (err) {\
+		hwmon_device_unregister(data->class_dev); \
+		return err; \
+	} \
+	err = device_create_file(&client->dev, &dev_attr_fan##offset##_min); \
+	if (err) {\
+		hwmon_device_unregister(data->class_dev); \
+		return err; \
+	} \
 } while (0)

 #define show_temp_reg(reg) \
@@ -657,9 +677,21 @@ sysfs_temp_offsets(3);

 #define device_create_file_temp(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_temp##offset##_input); \
-device_create_file(&client->dev, &dev_attr_temp##offset##_max); \
-device_create_file(&client->dev, &dev_attr_temp##offset##_max_hyst); \
+	err = device_create_file(&client->dev, &dev_attr_temp##offset##_input); \
+	if (err) {\
+		hwmon_device_unregister(data->class_dev); \
+		return err; \
+	} \
+	err = device_create_file(&client->dev, &dev_attr_temp##offset##_max); \
+	if (err) {\
+		hwmon_device_unregister(data->class_dev); \
+		return err; \
+	} \
+	err = device_create_file(&client->dev, &dev_attr_temp##offset##_max_hyst); \
+	if (err) {\
+		hwmon_device_unregister(data->class_dev); \
+		return err; \
+	} \
 } while (0)

 static ssize_t
@@ -670,7 +702,11 @@ show_vid_reg(struct device *dev, struct
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
 #define device_create_file_vid(client) \
-device_create_file(&client->dev, &dev_attr_cpu0_vid)
+err = device_create_file(&client->dev, &dev_attr_cpu0_vid); \
+if (err) { \
+	hwmon_device_unregister(data->class_dev); \
+	return err; \
+} \

 static ssize_t
 show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
@@ -692,7 +728,11 @@ store_vrm_reg(struct device *dev, struct
 }
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
 #define device_create_file_vrm(client) \
-device_create_file(&client->dev, &dev_attr_vrm)
+err = device_create_file(&client->dev, &dev_attr_vrm); \
+if (err) {\
+	hwmon_device_unregister(data->class_dev); \
+	return err; \
+} \

 static ssize_t
 show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
@@ -702,7 +742,11 @@ show_alarms_reg(struct device *dev, stru
 }
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
 #define device_create_file_alarms(client) \
-device_create_file(&client->dev, &dev_attr_alarms)
+err = device_create_file(&client->dev, &dev_attr_alarms); \
+if (err) {\
+	hwmon_device_unregister(data->class_dev); \
+	return err; \
+} \

 #define show_beep_reg(REG, reg) \
 static ssize_t show_beep_##reg (struct device *dev, struct device_attribute *attr, char *buf) \
@@ -767,8 +811,16 @@ sysfs_beep(MASK, mask);

 #define device_create_file_beep(client) \
 do { \
-device_create_file(&client->dev, &dev_attr_beep_enable); \
-device_create_file(&client->dev, &dev_attr_beep_mask); \
+	err = device_create_file(&client->dev, &dev_attr_beep_enable); \
+	if (err) {\
+		hwmon_device_unregister(data->class_dev); \
+		return err; \
+	} \
+	err = device_create_file(&client->dev, &dev_attr_beep_mask); \
+	if (err) {\
+		hwmon_device_unregister(data->class_dev); \
+		return err; \
+	} \
 } while (0)

 static ssize_t
@@ -838,7 +890,11 @@ sysfs_fan_div(3);

 #define device_create_file_fan_div(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
+	err = device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
+	if (err) {\
+		hwmon_device_unregister(data->class_dev); \
+		return err; \
+	} \
 } while (0)

 static ssize_t
@@ -897,7 +953,11 @@ sysfs_pwm(3);

 #define device_create_file_pwm(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_pwm##offset); \
+	err = device_create_file(&client->dev, &dev_attr_pwm##offset); \
+	if (err) {\
+		hwmon_device_unregister(data->class_dev); \
+		return err; \
+	} \
 } while (0)

 static ssize_t
@@ -973,7 +1033,11 @@ sysfs_sensor(3);

 #define device_create_file_sensor(client, offset) \
 do { \
-device_create_file(&client->dev, &dev_attr_temp##offset##_type); \
+	err = device_create_file(&client->dev, &dev_attr_temp##offset##_type); \
+	if (err) {\
+		hwmon_device_unregister(data->class_dev); \
+		return err; \
+	} \
 } while (0)




