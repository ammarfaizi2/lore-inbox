Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVAHILd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVAHILd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVAHIKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:10:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:24965 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261822AbVAHFsC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:02 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <110516277494@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:34 -0800
Message-Id: <11051627742463@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.50, 2005/01/06 15:05:25-08:00, khali@linux-fr.org

[PATCH] I2C: Update fscher pwm functionality

This is a small update to the fscher hardware monitoring chip driver.
More specifically it fixes two aspects of pwm:
1* Use the new sysfs names (e.g. pwm1 instead of fan1_pwm).
2* Better handling of out-of-range pwm values.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/fscher.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)


diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	2005-01-07 14:54:10 -08:00
+++ b/drivers/i2c/chips/fscher.c	2005-01-07 14:54:10 -08:00
@@ -198,7 +198,7 @@
 static DEVICE_ATTR(kind, S_IRUGO, show_##kind##0##sub, NULL);
 
 #define sysfs_fan(offset, reg_status, reg_min, reg_ripple, reg_act) \
-sysfs_rw_n(fan, _pwm   , offset, reg_min) \
+sysfs_rw_n(pwm,        , offset, reg_min) \
 sysfs_rw_n(fan, _status, offset, reg_status) \
 sysfs_rw_n(fan, _div   , offset, reg_ripple) \
 sysfs_ro_n(fan, _input , offset, reg_act)
@@ -247,7 +247,7 @@
 #define device_create_file_fan(client, offset) \
 do { \
 	device_create_file(&client->dev, &dev_attr_fan##offset##_status); \
-	device_create_file(&client->dev, &dev_attr_fan##offset##_pwm); \
+	device_create_file(&client->dev, &dev_attr_pwm##offset); \
 	device_create_file(&client->dev, &dev_attr_fan##offset##_div); \
 	device_create_file(&client->dev, &dev_attr_fan##offset##_input); \
 } while (0)
@@ -483,16 +483,17 @@
 	return sprintf(buf, "%u\n", data->fan_status[FAN_INDEX_FROM_NUM(nr)] & 0x04);
 }
 
-static ssize_t set_fan_pwm(struct i2c_client *client, struct fscher_data *data,
+static ssize_t set_pwm(struct i2c_client *client, struct fscher_data *data,
 		       const char *buf, size_t count, int nr, int reg)
 {
-	data->fan_min[FAN_INDEX_FROM_NUM(nr)] = simple_strtoul(buf, NULL, 10) & 0xff;
+	unsigned long v = simple_strtoul(buf, NULL, 10);
+	data->fan_min[FAN_INDEX_FROM_NUM(nr)] = v > 0xff ? 0xff : v;
 
 	fscher_write_value(client, reg, data->fan_min[FAN_INDEX_FROM_NUM(nr)]);
 	return count;
 }
 
-static ssize_t show_fan_pwm (struct fscher_data *data, char *buf, int nr)
+static ssize_t show_pwm(struct fscher_data *data, char *buf, int nr)
 {
 	return sprintf(buf, "%u\n", data->fan_min[FAN_INDEX_FROM_NUM(nr)]);
 }

