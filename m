Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263068AbVCDVHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbVCDVHE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263099AbVCDVEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:04:30 -0500
Received: from mail.kroah.org ([69.55.234.183]:9890 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263167AbVCDUyf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:35 -0500
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Allow it87 pwm reconfiguration
In-Reply-To: <11099685921394@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:36:33 -0800
Message-Id: <1109968592905@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2081, 2005/03/02 11:50:10-08:00, khali@linux-fr.org

[PATCH] I2C: Allow it87 pwm reconfiguration

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

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/it87.c |   71 +++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 59 insertions(+), 12 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2005-03-04 12:26:39 -08:00
+++ b/drivers/i2c/chips/it87.c	2005-03-04 12:26:39 -08:00
@@ -104,6 +104,9 @@
 /* Update battery voltage after every reading if true */
 static int update_vbat;
 
+/* Not all BIOSes properly configure the PWM registers */
+static int fix_pwm_polarity;
+
 /* Chip Type */
 
 static u16 chip_type;
@@ -224,6 +227,7 @@
 static int it87_write_value(struct i2c_client *client, u8 register,
 			u8 value);
 static struct it87_data *it87_update_device(struct device *dev);
+static int it87_check_pwm(struct i2c_client *client);
 static void it87_init_client(struct i2c_client *client, struct it87_data *data);
 
 
@@ -718,7 +722,6 @@
 	const char *name = "";
 	int is_isa = i2c_is_isa_adapter(adapter);
 	int enable_pwm_interface;
-	int tmp;
 
 	if (!is_isa && 
 	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
@@ -822,20 +825,12 @@
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
@@ -966,6 +961,56 @@
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
@@ -1126,6 +1171,8 @@
 MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
 module_param(update_vbat, bool, 0);
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
+module_param(fix_pwm_polarity, bool, 0);
+MODULE_PARM_DESC(fix_pwm_polarity, "Force PWM polarity to active high (DANGEROUS)");
 MODULE_LICENSE("GPL");
 
 module_init(sm_it87_init);

