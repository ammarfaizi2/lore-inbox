Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVALWcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVALWcx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVALW3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:29:53 -0500
Received: from smtp-out-01.utu.fi ([130.232.202.171]:43674 "EHLO
	smtp-out-01.utu.fi") by vger.kernel.org with ESMTP id S261529AbVALW1c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:27:32 -0500
Date: Thu, 13 Jan 2005 00:27:35 +0200
From: Jonas Munsin <jmunsin@iki.fi>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
In-reply-to: <YN0o4rkI.1105435582.0805630.khali@localhost>
To: Greg KH <greg@kroah.com>, Jean Delvare <khali@linux-fr.org>
Cc: pioppo@ferrara.linux.it, sensors@Stimpy.netroedge.com,
       Jonas Munsin <jmunsin@iki.fi>, djg@pdp8.net,
       LKML <linux-kernel@vger.kernel.org>
Reply-to: Jonas Munsin <jmunsin@iki.fi>
Mail-followup-to: Jonas Munsin <jmunsin@iki.fi>, Greg KH <greg@kroah.com>,
 Jean Delvare <khali@linux-fr.org>, pioppo@ferrara.linux.it,
 sensors@Stimpy.netroedge.com, djg@pdp8.net, LKML <linux-kernel@vger.kernel.org>
Message-id: <20050112222735.GA13572@nemo.sby.abo.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040907i
References: <200501102341.44949.pioppo@ferrara.linux.it>
 <YN0o4rkI.1105435582.0805630.khali@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

--- linux-2.6.10/drivers/i2c/chips/it87.c	2005-01-12 23:58:51.000000000 +0200
+++ linux-2.6.10/drivers/i2c/chips/it87.c_2.6.10-jm4-detect_broken_bios_20050112	2005-01-12 23:58:34.000000000 +0200
@@ -500,7 +500,7 @@ static ssize_t set_fan_div(struct device
 		else
 			data->fan_div[nr] = 3;
 	}
-	val = old & 0x100;
+	val = old & 0x80;
 	val |= (data->fan_div[0] & 0x07);
 	val |= (data->fan_div[1] & 0x07) << 3;
 	if (data->fan_div[2] == 3)
@@ -703,6 +703,8 @@ int it87_detect(struct i2c_adapter *adap
 	int err = 0;
 	const char *name = "";
 	int is_isa = i2c_is_isa_adapter(adapter);
+	int enable_pwm_interface;
+	int tmp;
 
 	if (!is_isa && 
 	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
@@ -812,6 +814,17 @@ int it87_detect(struct i2c_adapter *adap
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
@@ -860,12 +873,14 @@ int it87_detect(struct i2c_adapter *adap
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
