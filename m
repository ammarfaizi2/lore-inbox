Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbVAPTKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbVAPTKS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 14:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVAPTKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 14:10:17 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:10761 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S262584AbVAPTIM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 14:08:12 -0500
Date: Sun, 16 Jan 2005 20:10:40 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH 2.6] I2C: Kill i2c_client.id (1/5)
Message-Id: <20050116201040.469bad2e.khali@linux-fr.org>
In-Reply-To: <20050116194653.17c96499.khali@linux-fr.org>
References: <20050116194653.17c96499.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(1/5) Stop using i2c_client.id in i2c/chips drivers (mostly hardware
      monitoring drivers).

Drivers affected:
* adm1021
* adm1025
* adm1026
* adm1031
* ds1621
* fscher
* gl518sm
* isp1301_omap
* lm75
* lm77
* lm80
* lm83
* lm85
* lm87
* lm90
* max1619
* pcf8574
* pcf8591
* rtc8564
* smsc47m1
* w83l785ts

The vast majority of these drivers simply defined the i2c_client id
struct member but never used it, so they are not affected at all by the
change. Exceptions are:

* lm85 and rtc8564, which would at least display the id in a debug
message when assigning it. Not really useful though, as the id was then
never used.

* adm1026, which used the assigned id in all driver messages. However,
since dev_* calls will append the bus number and client address to these
messages, the id information is redundant and can go away. Also, the
driver would allow some GPIO reprogramming on the first client only
(id=0) and removing the id doesn't allow that anymore. I would restore a
similar functionality if needed, but the ADM1026 chip is found on very
few motherboards and none of these has more than one ADM1026 chip AFAIK,
so it doesn't seem to be worth the effort.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/adm1021.c linux-2.6.11-rc1/drivers/i2c/chips/adm1021.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/adm1021.c	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/adm1021.c	2005-01-16 12:50:29.000000000 +0100
@@ -147,8 +147,6 @@
 	.detach_client	= adm1021_detach_client,
 };
 
-static int adm1021_id;
-
 #define show(value)	\
 static ssize_t show_##value(struct device *dev, char *buf)		\
 {									\
@@ -299,8 +297,6 @@
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
 	data->type = kind;
-
-	new_client->id = adm1021_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/adm1025.c linux-2.6.11-rc1/drivers/i2c/chips/adm1025.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/adm1025.c	2004-12-24 22:33:47.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/adm1025.c	2005-01-16 12:50:29.000000000 +0100
@@ -148,12 +148,6 @@
 };
 
 /*
- * Internal variables
- */
-
-static int adm1025_id;
-
-/*
  * Sysfs stuff
  */
 
@@ -397,7 +391,6 @@
 
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-	new_client->id = adm1025_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/adm1026.c linux-2.6.11-rc1/drivers/i2c/chips/adm1026.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/adm1026.c	2005-01-14 18:37:07.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/adm1026.c	2005-01-16 12:52:45.000000000 +0100
@@ -313,8 +313,6 @@
 	.detach_client  = adm1026_detach_client,
 };
 
-static int adm1026_id;
-
 int adm1026_attach_adapter(struct i2c_adapter *adapter)
 {
 	if (!(adapter->class & I2C_CLASS_HWMON)) {
@@ -363,49 +361,47 @@
 	int value, i;
 	struct adm1026_data *data = i2c_get_clientdata(client);
 
-        dev_dbg(&client->dev,"(%d): Initializing device\n", client->id);
+        dev_dbg(&client->dev, "Initializing device\n");
 	/* Read chip config */
 	data->config1 = adm1026_read_value(client, ADM1026_REG_CONFIG1);
 	data->config2 = adm1026_read_value(client, ADM1026_REG_CONFIG2);
 	data->config3 = adm1026_read_value(client, ADM1026_REG_CONFIG3);
 
 	/* Inform user of chip config */
-	dev_dbg(&client->dev, "(%d): ADM1026_REG_CONFIG1 is: 0x%02x\n",
-		client->id, data->config1);
+	dev_dbg(&client->dev, "ADM1026_REG_CONFIG1 is: 0x%02x\n",
+		data->config1);
 	if ((data->config1 & CFG1_MONITOR) == 0) {
-		dev_dbg(&client->dev, "(%d): Monitoring not currently "
-			"enabled.\n", client->id);
+		dev_dbg(&client->dev, "Monitoring not currently "
+			"enabled.\n");
 	}
 	if (data->config1 & CFG1_INT_ENABLE) {
-		dev_dbg(&client->dev, "(%d): SMBALERT interrupts are "
-			"enabled.\n", client->id);
+		dev_dbg(&client->dev, "SMBALERT interrupts are "
+			"enabled.\n");
 	}
 	if (data->config1 & CFG1_AIN8_9) {
-		dev_dbg(&client->dev, "(%d): in8 and in9 enabled. "
-			"temp3 disabled.\n", client->id);
+		dev_dbg(&client->dev, "in8 and in9 enabled. "
+			"temp3 disabled.\n");
 	} else {
-		dev_dbg(&client->dev, "(%d): temp3 enabled.  in8 and "
-			"in9 disabled.\n", client->id);
+		dev_dbg(&client->dev, "temp3 enabled.  in8 and "
+			"in9 disabled.\n");
 	}
 	if (data->config1 & CFG1_THERM_HOT) {
-		dev_dbg(&client->dev, "(%d): Automatic THERM, PWM, "
-			"and temp limits enabled.\n", client->id);
+		dev_dbg(&client->dev, "Automatic THERM, PWM, "
+			"and temp limits enabled.\n");
 	}
 
 	value = data->config3;
 	if (data->config3 & CFG3_GPIO16_ENABLE) {
-		dev_dbg(&client->dev, "(%d): GPIO16 enabled.  THERM"
-			"pin disabled.\n", client->id);
+		dev_dbg(&client->dev, "GPIO16 enabled.  THERM"
+			"pin disabled.\n");
 	} else {
-		dev_dbg(&client->dev, "(%d): THERM pin enabled.  "
-			"GPIO16 disabled.\n", client->id);
+		dev_dbg(&client->dev, "THERM pin enabled.  "
+			"GPIO16 disabled.\n");
 	}
 	if (data->config3 & CFG3_VREF_250) {
-		dev_dbg(&client->dev, "(%d): Vref is 2.50 Volts.\n",
-			client->id);
+		dev_dbg(&client->dev, "Vref is 2.50 Volts.\n");
 	} else {
-		dev_dbg(&client->dev, "(%d): Vref is 1.82 Volts.\n",
-			client->id);
+		dev_dbg(&client->dev, "Vref is 1.82 Volts.\n");
 	}
 	/* Read and pick apart the existing GPIO configuration */
 	value = 0;
@@ -423,12 +419,11 @@
 	adm1026_print_gpio(client);
 
 	/* If the user asks us to reprogram the GPIO config, then
-	 *   do it now.  But only if this is the first ADM1026.
+	 * do it now.
 	 */
-	if (client->id == 0
-	    && (gpio_input[0] != -1 || gpio_output[0] != -1
+	if (gpio_input[0] != -1 || gpio_output[0] != -1
 		|| gpio_inverted[0] != -1 || gpio_normal[0] != -1
-		|| gpio_fan[0] != -1)) {
+		|| gpio_fan[0] != -1) {
 		adm1026_fixup_gpio(client);
 	}
 
@@ -448,8 +443,7 @@
 	value = adm1026_read_value(client, ADM1026_REG_CONFIG1);
 	/* Set MONITOR, clear interrupt acknowledge and s/w reset */
 	value = (value | CFG1_MONITOR) & (~CFG1_INT_CLEAR & ~CFG1_RESET);
-	dev_dbg(&client->dev, "(%d): Setting CONFIG to: 0x%02x\n",
-		client->id, value);
+	dev_dbg(&client->dev, "Setting CONFIG to: 0x%02x\n", value);
 	data->config1 = value;
 	adm1026_write_value(client, ADM1026_REG_CONFIG1, value);
 
@@ -467,31 +461,30 @@
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int  i;
 
-	dev_dbg(&client->dev, "(%d): GPIO config is:", client->id);
+	dev_dbg(&client->dev, "GPIO config is:");
 	for (i = 0;i <= 7;++i) {
 		if (data->config2 & (1 << i)) {
-			dev_dbg(&client->dev, "\t(%d): %sGP%s%d\n", client->id,
+			dev_dbg(&client->dev, "\t%sGP%s%d\n",
 				data->gpio_config[i] & 0x02 ? "" : "!",
 				data->gpio_config[i] & 0x01 ? "OUT" : "IN",
 				i);
 		} else {
-			dev_dbg(&client->dev, "\t(%d): FAN%d\n",
-				client->id, i);
+			dev_dbg(&client->dev, "\tFAN%d\n", i);
 		}
 	}
 	for (i = 8;i <= 15;++i) {
-		dev_dbg(&client->dev, "\t(%d): %sGP%s%d\n", client->id,
+		dev_dbg(&client->dev, "\t%sGP%s%d\n",
 			data->gpio_config[i] & 0x02 ? "" : "!",
 			data->gpio_config[i] & 0x01 ? "OUT" : "IN",
 			i);
 	}
 	if (data->config3 & CFG3_GPIO16_ENABLE) {
-		dev_dbg(&client->dev, "\t(%d): %sGP%s16\n", client->id,
+		dev_dbg(&client->dev, "\t%sGP%s16\n",
 			data->gpio_config[16] & 0x02 ? "" : "!",
 			data->gpio_config[16] & 0x01 ? "OUT" : "IN");
 	} else {
 		/* GPIO16 is THERM  */
-		dev_dbg(&client->dev, "\t(%d): THERM\n", client->id);
+		dev_dbg(&client->dev, "\tTHERM\n");
 	}
 }
 
@@ -582,8 +575,7 @@
 	if (!data->valid
 	    || (jiffies - data->last_reading > ADM1026_DATA_INTERVAL)) {
 		/* Things that change quickly */
-		dev_dbg(&client->dev,"(%d): Reading sensor values\n", 
-			client->id);
+		dev_dbg(&client->dev,"Reading sensor values\n");
 		for (i = 0;i <= 16;++i) {
 			data->in[i] =
 			    adm1026_read_value(client, ADM1026_REG_IN[i]);
@@ -631,8 +623,7 @@
 	if (!data->valid || (jiffies - data->last_config > 
 		ADM1026_CONFIG_INTERVAL)) {
 		/* Things that don't change often */
-		dev_dbg(&client->dev, "(%d): Reading config values\n", 
-			client->id);
+		dev_dbg(&client->dev, "Reading config values\n");
 		for (i = 0;i <= 16;++i) {
 			data->in_min[i] = adm1026_read_value(client, 
 				ADM1026_REG_IN_MIN[i]);
@@ -712,8 +703,7 @@
 		data->last_config = jiffies;
 	};  /* last_config */
 
-	dev_dbg(&client->dev, "(%d): Setting VID from GPIO11-15.\n", 
-		client->id);
+	dev_dbg(&client->dev, "Setting VID from GPIO11-15.\n");
 	data->vid = (data->gpio >> 11) & 0x1f;
 	data->valid = 1;
 	up(&data->update_lock);
@@ -1608,16 +1598,10 @@
 	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
 
 	/* Fill in the remaining client fields */
-	new_client->id = adm1026_id++;
 	data->type = kind;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
-	dev_dbg(&new_client->dev, "(%d): Assigning ID %d to %s at %d,0x%02x\n",
-		new_client->id, new_client->id, new_client->name,
-		i2c_adapter_id(new_client->adapter),
-		new_client->addr);
-
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
 		goto exitfree;
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/adm1031.c linux-2.6.11-rc1/drivers/i2c/chips/adm1031.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/adm1031.c	2004-12-24 22:34:32.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/adm1031.c	2005-01-16 12:50:29.000000000 +0100
@@ -110,8 +110,6 @@
 	.detach_client = adm1031_detach_client,
 };
 
-static int adm1031_id;
-
 static inline u8 adm1031_read_value(struct i2c_client *client, u8 reg)
 {
 	return i2c_smbus_read_byte_data(client, reg);
@@ -781,8 +779,6 @@
 	data->chip_type = kind;
 
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-
-	new_client->id = adm1031_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/ds1621.c linux-2.6.11-rc1/drivers/i2c/chips/ds1621.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/ds1621.c	2004-12-24 22:35:40.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/ds1621.c	2005-01-16 12:50:29.000000000 +0100
@@ -95,8 +95,6 @@
 	.detach_client	= ds1621_detach_client,
 };
 
-static int ds1621_id;
-
 /* All registers are word-sized, except for the configuration register.
    DS1621 uses a high-byte first convention, which is exactly opposite to
    the usual practice. */
@@ -232,8 +230,6 @@
 
 	/* Fill in remaining client fields and put it into the global list */
 	strlcpy(new_client->name, "ds1621", I2C_NAME_SIZE);
-
-	new_client->id = ds1621_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/fscher.c linux-2.6.11-rc1/drivers/i2c/chips/fscher.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/fscher.c	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/fscher.c	2005-01-16 12:50:29.000000000 +0100
@@ -151,12 +151,6 @@
 };
 
 /*
- * Internal variables
- */
-
-static int fscher_id;
-
-/*
  * Sysfs stuff
  */
 
@@ -337,7 +331,6 @@
 	/* Fill in the remaining client fields and put it into the
 	 * global list */
 	strlcpy(new_client->name, "fscher", I2C_NAME_SIZE);
-	new_client->id = fscher_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/gl518sm.c linux-2.6.11-rc1/drivers/i2c/chips/gl518sm.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/gl518sm.c	2004-12-24 22:35:39.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/gl518sm.c	2005-01-16 12:50:29.000000000 +0100
@@ -159,12 +159,6 @@
 };
 
 /*
- * Internal variables
- */
-
-static int gl518_id;
-
-/*
  * Sysfs stuff
  */
 
@@ -396,7 +390,6 @@
 
 	/* Fill in the remaining client fields */
 	strlcpy(new_client->name, "gl518sm", I2C_NAME_SIZE);
-	new_client->id = gl518_id++;
 	data->type = kind;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/isp1301_omap.c linux-2.6.11-rc1/drivers/i2c/chips/isp1301_omap.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/isp1301_omap.c	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/isp1301_omap.c	2005-01-16 12:50:29.000000000 +0100
@@ -1503,7 +1503,6 @@
 	isp->client.addr = address;
 	i2c_set_clientdata(&isp->client, isp);
 	isp->client.adapter = bus;
-	isp->client.id = 1301;
 	isp->client.driver = &isp1301_driver;
 	strlcpy(isp->client.name, DRIVER_NAME, I2C_NAME_SIZE);
 	i2c = &isp->client;
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/lm75.c linux-2.6.11-rc1/drivers/i2c/chips/lm75.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/lm75.c	2004-12-24 22:33:48.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/lm75.c	2005-01-16 12:50:29.000000000 +0100
@@ -73,8 +73,6 @@
 	.detach_client	= lm75_detach_client,
 };
 
-static int lm75_id;
-
 #define show(value)	\
 static ssize_t show_##value(struct device *dev, char *buf)		\
 {									\
@@ -196,8 +194,6 @@
 
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-
-	new_client->id = lm75_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/lm77.c linux-2.6.11-rc1/drivers/i2c/chips/lm77.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/lm77.c	2004-12-24 22:36:00.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/lm77.c	2005-01-16 12:50:29.000000000 +0100
@@ -81,8 +81,6 @@
 	.detach_client	= lm77_detach_client,
 };
 
-static int lm77_id;
-
 /* straight from the datasheet */
 #define LM77_TEMP_MIN (-55000)
 #define LM77_TEMP_MAX 125000
@@ -295,8 +293,6 @@
 
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-
-	new_client->id = lm77_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/lm80.c linux-2.6.11-rc1/drivers/i2c/chips/lm80.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/lm80.c	2004-12-24 22:33:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/lm80.c	2005-01-16 12:50:29.000000000 +0100
@@ -141,12 +141,6 @@
 static int lm80_write_value(struct i2c_client *client, u8 reg, u8 value);
 
 /*
- * Internal variables
- */
-
-static int lm80_id;
-
-/*
  * Driver data (common to all clients)
  */
 
@@ -425,8 +419,6 @@
 
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-
-	new_client->id = lm80_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/lm83.c linux-2.6.11-rc1/drivers/i2c/chips/lm83.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/lm83.c	2004-12-24 22:34:32.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/lm83.c	2005-01-16 12:50:29.000000000 +0100
@@ -150,12 +150,6 @@
 };
 
 /*
- * Internal variables
- */
-
-static int lm83_id;
-
-/*
  * Sysfs stuff
  */
 
@@ -312,7 +306,6 @@
 
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-	new_client->id = lm83_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/lm85.c linux-2.6.11-rc1/drivers/i2c/chips/lm85.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/lm85.c	2005-01-14 18:37:07.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/lm85.c	2005-01-16 12:50:29.000000000 +0100
@@ -389,9 +389,6 @@
 	.detach_client  = lm85_detach_client,
 };
 
-/* Unique ID assigned to each LM85 detected */
-static int lm85_id;
-
 
 /* 4 Fans */
 static ssize_t show_fan(struct device *dev, char *buf, int nr)
@@ -1148,16 +1145,10 @@
 	strlcpy(new_client->name, type_name, I2C_NAME_SIZE);
 
 	/* Fill in the remaining client fields */
-	new_client->id = lm85_id++;
 	data->type = kind;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
-	dev_dbg(&adapter->dev, "Assigning ID %d to %s at %d,0x%02x\n",
-		new_client->id, new_client->name,
-		i2c_adapter_id(new_client->adapter),
-		new_client->addr);
-
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR1;
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/lm87.c linux-2.6.11-rc1/drivers/i2c/chips/lm87.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/lm87.c	2004-12-24 22:35:39.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/lm87.c	2005-01-16 12:50:29.000000000 +0100
@@ -203,12 +203,6 @@
 };
 
 /*
- * Internal variables
- */
-
-static int lm87_id;
-
-/*
  * Sysfs stuff
  */
 
@@ -569,7 +563,6 @@
 
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, "lm87", I2C_NAME_SIZE);
-	new_client->id = lm87_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/lm90.c linux-2.6.11-rc1/drivers/i2c/chips/lm90.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/lm90.c	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/lm90.c	2005-01-16 12:50:29.000000000 +0100
@@ -190,12 +190,6 @@
 };
 
 /*
- * Internal variables
- */
-
-static int lm90_id;
-
-/*
  * Sysfs stuff
  */
 
@@ -427,7 +421,6 @@
 
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-	new_client->id = lm90_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/max1619.c linux-2.6.11-rc1/drivers/i2c/chips/max1619.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/max1619.c	2004-12-24 22:35:25.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/max1619.c	2005-01-16 12:50:29.000000000 +0100
@@ -117,12 +117,6 @@
 };
 
 /*
- * Internal variables
- */
-
-static int max1619_id;
-
-/*
  * Sysfs stuff
  */
 
@@ -267,7 +261,6 @@
 
 	/* We can fill in the remaining client fields */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-	new_client->id = max1619_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/pcf8574.c linux-2.6.11-rc1/drivers/i2c/chips/pcf8574.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/pcf8574.c	2004-12-24 22:34:00.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/pcf8574.c	2005-01-16 12:50:29.000000000 +0100
@@ -77,8 +77,6 @@
 	.detach_client	= pcf8574_detach_client,
 };
 
-static int pcf8574_id;
-
 /* following are the sysfs callback functions */
 static ssize_t show_read(struct device *dev, char *buf)
 {
@@ -159,8 +157,6 @@
 
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, client_name, I2C_NAME_SIZE);
-
-	new_client->id = pcf8574_id++;
 	init_MUTEX(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/pcf8591.c linux-2.6.11-rc1/drivers/i2c/chips/pcf8591.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/pcf8591.c	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/pcf8591.c	2005-01-16 12:50:29.000000000 +0100
@@ -98,8 +98,6 @@
 	.detach_client	= pcf8591_detach_client,
 };
 
-static int pcf8591_id;
-
 /* following are the sysfs callback functions */
 #define show_in_channel(channel)					\
 static ssize_t show_in##channel##_input(struct device *dev, char *buf)	\
@@ -201,8 +199,6 @@
 	/* Fill in the remaining client fields and put it into the global 
 	   list */
 	strlcpy(new_client->name, "pcf8591", I2C_NAME_SIZE);
-
-	new_client->id = pcf8591_id++;
 	init_MUTEX(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/rtc8564.c linux-2.6.11-rc1/drivers/i2c/chips/rtc8564.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/rtc8564.c	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/rtc8564.c	2005-01-16 12:50:29.000000000 +0100
@@ -163,14 +163,12 @@
 
 	strlcpy(new_client->name, "RTC8564", I2C_NAME_SIZE);
 	i2c_set_clientdata(new_client, d);
-	new_client->id = rtc8564_driver.id;
 	new_client->flags = I2C_CLIENT_ALLOW_USE | I2C_DF_NOTIFY;
 	new_client->addr = addr;
 	new_client->adapter = adap;
 	new_client->driver = &rtc8564_driver;
 
 	_DBG(1, "client=%p", new_client);
-	_DBG(1, "client.id=%d", new_client->id);
 
 	/* init ctrl1 reg */
 	data[0] = 0;
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/smsc47m1.c linux-2.6.11-rc1/drivers/i2c/chips/smsc47m1.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/smsc47m1.c	2005-01-14 18:36:52.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/smsc47m1.c	2005-01-16 12:50:29.000000000 +0100
@@ -108,7 +108,6 @@
 struct smsc47m1_data {
 	struct i2c_client client;
 	struct semaphore lock;
-	int sysctl_id;
 
 	struct semaphore update_lock;
 	unsigned long last_updated;	/* In jiffies */
@@ -133,8 +132,6 @@
 		int init);
 
 
-static int smsc47m1_id;
-
 static struct i2c_driver smsc47m1_driver = {
 	.owner		= THIS_MODULE,
 	.name		= "smsc47m1",
@@ -420,8 +417,6 @@
 	new_client->flags = 0;
 
 	strlcpy(new_client->name, "smsc47m1", I2C_NAME_SIZE);
-
-	new_client->id = smsc47m1_id++;
 	init_MUTEX(&data->update_lock);
 
 	/* If no function is properly configured, there's no point in
diff -ruN linux-2.6.11-rc1.orig/drivers/i2c/chips/w83l785ts.c linux-2.6.11-rc1/drivers/i2c/chips/w83l785ts.c
--- linux-2.6.11-rc1.orig/drivers/i2c/chips/w83l785ts.c	2004-12-24 22:34:26.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/w83l785ts.c	2005-01-16 12:50:29.000000000 +0100
@@ -114,12 +114,6 @@
 };
 
 /*
- * Internal variables
- */
-
-static int w83l785ts_id = 0;
-
-/*
  * Sysfs stuff
  */
 
@@ -229,7 +223,6 @@
 
 	/* We can fill in the remaining client fields. */
 	strlcpy(new_client->name, "w83l785ts", I2C_NAME_SIZE);
-	new_client->id = w83l785ts_id++;
 	data->valid = 0;
 	init_MUTEX(&data->update_lock);
 


-- 
Jean Delvare
http://khali.linux-fr.org/
