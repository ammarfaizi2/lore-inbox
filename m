Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267302AbUHWTEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267302AbUHWTEV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUHWTBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:01:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:9156 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267295AbUHWSg7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:59 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860884122@kroah.com>
Date: Mon, 23 Aug 2004 11:34:48 -0700
Message-Id: <10932860883372@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.34, 2004/08/09 10:45:27-07:00, khali@linux-fr.org

[PATCH] I2C: update the lm83 driver

This is an update to the Linux 2.6 lm83 hardware monitoring driver.

* Follow the sysfs interface naming conventions.
* Fix the "force" module parameter.
* Fix limit settings checks.
* Driver is no longer tagged experimental.

These changes are the result of me finally succeeding in getting my LM83
evaluation board to work. If there are norms and standards about how
evaluation boards can be wired, I guess I did not respect any of them,
but it works ;)


Signed-off-by: Jean Delvare <khali at linux-fr dot org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/Kconfig |    2 +-
 drivers/i2c/chips/lm83.c  |   23 ++++++++++++++++++-----
 2 files changed, 19 insertions(+), 6 deletions(-)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	2004-08-23 11:03:23 -07:00
+++ b/drivers/i2c/chips/Kconfig	2004-08-23 11:03:23 -07:00
@@ -149,7 +149,7 @@
 
 config SENSORS_LM83
 	tristate "National Semiconductor LM83"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C
 	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor
diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	2004-08-23 11:03:23 -07:00
+++ b/drivers/i2c/chips/lm83.c	2004-08-23 11:03:23 -07:00
@@ -83,8 +83,10 @@
  * The LM83 uses signed 8-bit values.
  */
 
-#define TEMP_FROM_REG(val)	((val > 127 ? val-256 : val) * 1000)
-#define TEMP_TO_REG(val)	((val < 0 ? val+256 : val) / 1000)
+#define TEMP_FROM_REG(val)	(((val) > 127 ? (val)-0xFF : (val)) * 1000)
+#define TEMP_TO_REG(val)	((val) <= -50000 ? -50 + 0xFF : (val) >= 127000 ? 127 : \
+				 (val) > -500 ? ((val)+500) / 1000 : \
+				 ((val)-500) / 1000 + 0xFF)
 
 static const u8 LM83_REG_R_TEMP[] = {
 	LM83_REG_R_LOCAL_TEMP,
@@ -178,7 +180,7 @@
 { \
 	struct i2c_client *client = to_i2c_client(dev); \
 	struct lm83_data *data = i2c_get_clientdata(client); \
-	data->value = TEMP_TO_REG(simple_strtoul(buf, NULL, 10)); \
+	data->value = TEMP_TO_REG(simple_strtol(buf, NULL, 10)); \
 	i2c_smbus_write_byte_data(client, reg, data->value); \
 	return count; \
 }
@@ -206,8 +208,11 @@
     set_temp_high3);
 static DEVICE_ATTR(temp4_max, S_IWUSR | S_IRUGO, show_temp_high4,
     set_temp_high4);
-static DEVICE_ATTR(temp_crit, S_IWUSR | S_IRUGO, show_temp_crit,
+static DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp_crit, NULL);
+static DEVICE_ATTR(temp2_crit, S_IRUGO, show_temp_crit, NULL);
+static DEVICE_ATTR(temp3_crit, S_IWUSR | S_IRUGO, show_temp_crit,
     set_temp_crit);
+static DEVICE_ATTR(temp4_crit, S_IRUGO, show_temp_crit, NULL);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
 
 /*
@@ -259,6 +264,11 @@
 	 * means that the driver was loaded with the force parameter and a
 	 * given kind of chip is requested, so both the detection and the
 	 * identification steps are skipped. */
+
+	/* Default to an LM83 if forced */
+	if (kind == 0)
+		kind = lm83;
+
 	if (kind < 0) { /* detection */
 		if (((i2c_smbus_read_byte_data(new_client, LM83_REG_R_STATUS1)
 		    & 0xA8) != 0x00) ||
@@ -322,7 +332,10 @@
 	device_create_file(&new_client->dev, &dev_attr_temp2_max);
 	device_create_file(&new_client->dev, &dev_attr_temp3_max);
 	device_create_file(&new_client->dev, &dev_attr_temp4_max);
-	device_create_file(&new_client->dev, &dev_attr_temp_crit);
+	device_create_file(&new_client->dev, &dev_attr_temp1_crit);
+	device_create_file(&new_client->dev, &dev_attr_temp2_crit);
+	device_create_file(&new_client->dev, &dev_attr_temp3_crit);
+	device_create_file(&new_client->dev, &dev_attr_temp4_crit);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
 
 	return 0;

