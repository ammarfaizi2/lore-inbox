Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263652AbVBCSVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263652AbVBCSVC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVBCR4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 12:56:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:59047 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263634AbVBCRlB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 12:41:01 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Do not show disabled pc87360 fans
In-Reply-To: <11074523382465@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Feb 2005 09:38:58 -0800
Message-Id: <11074523382272@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2046, 2005/02/03 00:30:49-08:00, khali@linux-fr.org

[PATCH] I2C: Do not show disabled pc87360 fans

The pc87360 driver create sysfs files even for disabled fans. Since data
won't ever be updated, it doesn't make much sense. The following patch
adds some tests to only create the interface files that are actually
needed.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/pc87360.c |   49 +++++++++++++++++++++++++++++++-------------
 1 files changed, 35 insertions(+), 14 deletions(-)


diff -Nru a/drivers/i2c/chips/pc87360.c b/drivers/i2c/chips/pc87360.c
--- a/drivers/i2c/chips/pc87360.c	2005-02-03 09:34:48 -08:00
+++ b/drivers/i2c/chips/pc87360.c	2005-02-03 09:34:48 -08:00
@@ -795,8 +795,10 @@
 
 	/* Fan clock dividers may be needed before any data is read */
 	for (i = 0; i < data->fannr; i++) {
-		data->fan_status[i] = pc87360_read_value(data, LD_FAN,
-				      NO_BANK, PC87360_REG_FAN_STATUS(i));
+		if (FAN_CONFIG_MONITOR(data->fan_conf, i))
+			data->fan_status[i] = pc87360_read_value(data,
+					      LD_FAN, NO_BANK,
+					      PC87360_REG_FAN_STATUS(i));
 	}
 
 	if (init > 0) {
@@ -898,14 +900,27 @@
 	}
 
 	if (data->fannr) {
-		device_create_file(&new_client->dev, &dev_attr_fan1_input);
-		device_create_file(&new_client->dev, &dev_attr_fan2_input);
-		device_create_file(&new_client->dev, &dev_attr_fan1_min);
-		device_create_file(&new_client->dev, &dev_attr_fan2_min);
-		device_create_file(&new_client->dev, &dev_attr_fan1_div);
-		device_create_file(&new_client->dev, &dev_attr_fan2_div);
-		device_create_file(&new_client->dev, &dev_attr_fan1_status);
-		device_create_file(&new_client->dev, &dev_attr_fan2_status);
+		if (FAN_CONFIG_MONITOR(data->fan_conf, 0)) {
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan1_input);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan1_min);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan1_div);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan1_status);
+		}
+
+		if (FAN_CONFIG_MONITOR(data->fan_conf, 1)) {
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan2_input);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan2_min);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan2_div);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan2_status);
+		}
 
 		if (FAN_CONFIG_CONTROL(data->fan_conf, 0))
 			device_create_file(&new_client->dev, &dev_attr_pwm1);
@@ -913,10 +928,16 @@
 			device_create_file(&new_client->dev, &dev_attr_pwm2);
 	}
 	if (data->fannr == 3) {
-		device_create_file(&new_client->dev, &dev_attr_fan3_input);
-		device_create_file(&new_client->dev, &dev_attr_fan3_min);
-		device_create_file(&new_client->dev, &dev_attr_fan3_div);
-		device_create_file(&new_client->dev, &dev_attr_fan3_status);
+		if (FAN_CONFIG_MONITOR(data->fan_conf, 2)) {
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan3_input);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan3_min);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan3_div);
+			device_create_file(&new_client->dev,
+					   &dev_attr_fan3_status);
+		}
 
 		if (FAN_CONFIG_CONTROL(data->fan_conf, 2))
 			device_create_file(&new_client->dev, &dev_attr_pwm3);

