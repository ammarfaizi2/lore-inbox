Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVAOP2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVAOP2g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 10:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbVAOP2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 10:28:36 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:23056 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262290AbVAOP2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 10:28:21 -0500
Date: Sat, 15 Jan 2005 16:30:45 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Simone Piunno <pioppo@ferrara.linux.it>, Greg KH <greg@kroah.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, "Jonas Munsin" <jmunsin@iki.fi>,
       djg@pdp8.net, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] I2C: Allow it87 pwm reconfiguration
Message-Id: <20050115163045.2e636632.khali@linux-fr.org>
In-Reply-To: <g7Idbr9m.1105713630.9207120.khali@localhost>
References: <20050113232904.GC2458@kroah.com>
	<g7Idbr9m.1105713630.9207120.khali@localhost>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting myself:

> As soon as you will have confirmed that everything worked as expected,
> Jonas and I will provide a patch adding a pwm polarity reconfiguration
> module parameter for you to test. This should give you access to the
> PWM features of your it87 chip again, but in a safe way for a change
> ;)

Here comes this patch. The new "fix_pwm_polarity" module parameter
allows one to force the it87 chip reconfiguration. This is only
supported in the case the original PWM configuration is suspected to be
bogus, and only if we think that reconfiguring the chip is safe.

I wish to thank Rudolf Marek and Jonas Munsin again for their testing
and review of my code.

Greg, please apply, thanks.

Simone, feel free to test this (on top of 2.6.11-rc1-mm1 for example).


Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-rc1/drivers/i2c/chips/it87.c.orig	2005-01-14 18:37:07.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/it87.c	2005-01-15 15:46:04.000000000 +0100
@@ -106,6 +106,9 @@
 /* Update battery voltage after every reading if true */
 static int update_vbat;
 
+/* Not all BIOSes properly configure the PWM registers */
+static int fix_pwm_polarity;
+
 /* Chip Type */
 
 static u16 chip_type;
@@ -226,6 +229,7 @@
 static int it87_write_value(struct i2c_client *client, u8 register,
 			u8 value);
 static struct it87_data *it87_update_device(struct device *dev);
+static int it87_check_pwm(struct i2c_client *client);
 static void it87_init_client(struct i2c_client *client, struct it87_data *data);
 
 
@@ -720,7 +724,6 @@
 	const char *name = "";
 	int is_isa = i2c_is_isa_adapter(adapter);
 	int enable_pwm_interface;
-	int tmp;
 
 	if (!is_isa && 
 	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
@@ -824,20 +827,12 @@
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR2;
 
+	/* Check PWM configuration */
+	enable_pwm_interface = it87_check_pwm(new_client);
+
 	/* Initialize the IT87 chip */
 	it87_init_client(new_client, data);
 
-	/* Some BIOSes fail to correctly configure the IT87 fans. All fans off
-	 * and polarity set to active low is sign that this is the case so we
-	 * disable pwm control to protect the user. */
-	enable_pwm_interface = 1;
-	tmp = it87_read_value(new_client, IT87_REG_FAN_CTL);
-	if ((tmp & 0x87) == 0) {
-		enable_pwm_interface = 0;
-		dev_info(&new_client->dev,
-			"detected broken BIOS defaults, disabling pwm interface");
-	}
-
 	/* Register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_in0_input);
 	device_create_file(&new_client->dev, &dev_attr_in1_input);
@@ -968,6 +963,56 @@
 		return i2c_smbus_write_byte_data(client, reg, value);
 }
 
+/* Return 1 if and only if the PWM interface is safe to use */
+static int it87_check_pwm(struct i2c_client *client)
+{
+	/* Some BIOSes fail to correctly configure the IT87 fans. All fans off
+	 * and polarity set to active low is sign that this is the case so we
+	 * disable pwm control to protect the user. */
+	int tmp = it87_read_value(client, IT87_REG_FAN_CTL);
+	if ((tmp & 0x87) == 0) {
+		if (fix_pwm_polarity) {
+			/* The user asks us to attempt a chip reconfiguration.
+			 * This means switching to active high polarity and
+			 * inverting all fan speed values. */
+			int i;
+			u8 pwm[3];
+
+			for (i = 0; i < 3; i++)
+				pwm[i] = it87_read_value(client,
+							 IT87_REG_PWM(i));
+
+			/* If any fan is in automatic pwm mode, the polarity
+			 * might be correct, as suspicious as it seems, so we
+			 * better don't change anything (but still disable the
+			 * PWM interface). */
+			if (!((pwm[0] | pwm[1] | pwm[2]) & 0x80)) {
+				dev_info(&client->dev, "Reconfiguring PWM to "
+					 "active high polarity\n");
+				it87_write_value(client, IT87_REG_FAN_CTL,
+						 tmp | 0x87);
+				for (i = 0; i < 3; i++)
+					it87_write_value(client,
+							 IT87_REG_PWM(i),
+							 0x7f & ~pwm[i]);
+				return 1;
+			}
+
+			dev_info(&client->dev, "PWM configuration is "
+				 "too broken to be fixed\n");
+		}
+
+		dev_info(&client->dev, "Detected broken BIOS "
+			 "defaults, disabling PWM interface\n");
+		return 0;
+	} else if (fix_pwm_polarity) {
+		dev_info(&client->dev, "PWM configuration looks "
+			 "sane, won't touch\n");
+	}
+
+	return 1;
+}
+
 /* Called when we have found a new IT87. */
 static void it87_init_client(struct i2c_client *client, struct it87_data *data)
 {
@@ -1128,6 +1173,8 @@
 MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
 module_param(update_vbat, bool, 0);
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
+module_param(fix_pwm_polarity, bool, 0);
+MODULE_PARM_DESC(fix_pwm_polarity, "Force PWM polarity to active high (DANGEROUS)");
 MODULE_LICENSE("GPL");
 
 module_init(sm_it87_init);

-- 
Jean Delvare
http://khali.linux-fr.org/
