Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262942AbVAQWDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbVAQWDa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVAQWCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:02:09 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:55732 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262912AbVAQVtV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 16:49:21 -0500
Cc: jmunsin@iki.fi
Subject: [PATCH] I2C: fix it87 sensor driver stops CPU fan
In-Reply-To: <1105998395257@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 13:46:36 -0800
Message-Id: <11059983961494@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2329.2.7, 2005/01/14 14:43:30-08:00, jmunsin@iki.fi

[PATCH] I2C: fix it87 sensor driver stops CPU fan

> 2* I would then add a check to the it87 driver, which completely disables
> the fan speed control interface if the initial configuration looks weird
> (all fans supposedly stopped and polarity set to "active low"). This
> should protect users of the driver who have a faulty BIOS.
>
> When a bogus configuration is detected, we would of course complain in
> the logs and invite the user to complain to his/her motherboard maker
> too.

Here is it87.c_2.6.10-jm4-detect_broken_bios_20050112.diff implementing
this. It goes on top of the previous patch.

- detects broken bioses, disables the pwm for them and prints a message
- fixes an unrelated minor bug in set_fan_div()

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Jonas Munsin <jmunsin@iki.fi>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/it87.c |   29 ++++++++++++++++++++++-------
 1 files changed, 22 insertions(+), 7 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2005-01-17 13:20:25 -08:00
+++ b/drivers/i2c/chips/it87.c	2005-01-17 13:20:25 -08:00
@@ -500,7 +500,7 @@
 		else
 			data->fan_div[nr] = 3;
 	}
-	val = old & 0x100;
+	val = old & 0x80;
 	val |= (data->fan_div[0] & 0x07);
 	val |= (data->fan_div[1] & 0x07) << 3;
 	if (data->fan_div[2] == 3)
@@ -703,6 +703,8 @@
 	int err = 0;
 	const char *name = "";
 	int is_isa = i2c_is_isa_adapter(adapter);
+	int enable_pwm_interface;
+	int tmp;
 
 	if (!is_isa && 
 	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
@@ -812,6 +814,17 @@
 	/* Initialize the IT87 chip */
 	it87_init_client(new_client, data);
 
+	/* Some BIOSes fail to correctly configure the IT87 fans. All fans off
+	 * and polarity set to active low is sign that this is the case so we
+	 * disable pwm control to protect the user. */
+	enable_pwm_interface = 1;
+	tmp = it87_read_value(new_client, IT87_REG_FAN_CTL);
+	if ((tmp & 0x87) == 0) {
+		enable_pwm_interface = 0;
+		dev_info(&new_client->dev,
+			"detected broken BIOS defaults, disabling pwm interface");
+	}
+
 	/* Register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
@@ -860,12 +873,14 @@
 	device_create_file(&new_client->dev, &dev_attr_fan2_div);
 	device_create_file(&new_client->dev, &dev_attr_fan3_div);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
-	device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
-	device_create_file(&new_client->dev, &dev_attr_pwm2_enable);
-	device_create_file(&new_client->dev, &dev_attr_pwm3_enable);
-	device_create_file(&new_client->dev, &dev_attr_pwm1);
-	device_create_file(&new_client->dev, &dev_attr_pwm2);
-	device_create_file(&new_client->dev, &dev_attr_pwm3);
+	if (enable_pwm_interface) {
+		device_create_file(&new_client->dev, &dev_attr_pwm1_enable);
+		device_create_file(&new_client->dev, &dev_attr_pwm2_enable);
+		device_create_file(&new_client->dev, &dev_attr_pwm3_enable);
+		device_create_file(&new_client->dev, &dev_attr_pwm1);
+		device_create_file(&new_client->dev, &dev_attr_pwm2);
+		device_create_file(&new_client->dev, &dev_attr_pwm3);
+	}
 
 	if (data->type == it8712) {
 		device_create_file_vrm(new_client);

