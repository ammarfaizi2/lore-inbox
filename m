Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbUDNW3U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbUDNW3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:29:05 -0400
Received: from mail.kroah.org ([65.200.24.183]:38047 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261947AbUDNWYy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:24:54 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <10819814512937@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:12 -0700
Message-Id: <10819814522020@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.20, 2004/04/09 12:05:44-07:00, aurelien@aurel32.net

[PATCH] I2C: New chip driver: pcf8591

Please find below a patch against kernel 2.6.5-rc2-mm4 to add the pcf8591
driver (a 8-bit A/D and D/A converter). I have ported it from the 2.4
version, and it includes some fixes, improvements and simplifications.

It has been reviewed by Jean Delvare on IRC.

Please also note that the patch also fixes a missing space in
drivers/i2c/chips/Kconfig, introduced by the previous patch I sent you
concerning the pcf8574.


 drivers/i2c/chips/Kconfig   |   12 +
 drivers/i2c/chips/Makefile  |    1 
 drivers/i2c/chips/pcf8591.c |  321 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 333 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Wed Apr 14 15:13:16 2004
+++ b/drivers/i2c/chips/Kconfig	Wed Apr 14 15:13:16 2004
@@ -217,7 +217,17 @@
 	  If you say yes here you get support for Philips PCF8574 and 
 	  PCF8574A chips.
 
-	  This driver can also be built as a module. If so, the module
+	  This driver can also be built as a module.  If so, the module
 	  will be called pcf8574.
+
+config SENSORS_PCF8591
+	tristate "Philips PCF8591"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Philips PCF8591 chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called pcf8591.
 
 endmenu
diff -Nru a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile	Wed Apr 14 15:13:16 2004
+++ b/drivers/i2c/chips/Makefile	Wed Apr 14 15:13:16 2004
@@ -20,6 +20,7 @@
 obj-$(CONFIG_SENSORS_LM85)	+= lm85.o
 obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
+obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 
diff -Nru a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/chips/pcf8591.c	Wed Apr 14 15:13:17 2004
@@ -0,0 +1,321 @@
+/*
+    pcf8591.c - Part of lm_sensors, Linux kernel modules for hardware
+                monitoring
+    Copyright (C) 2001-2004 Aurelien Jarno <aurelien@aurel32.net>
+    Ported to Linux 2.6 by Aurelien Jarno <aurelien@aurel32.net> with 
+    the help of Jean Delvare <khali@linux-fr.org>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+static unsigned short normal_i2c_range[] = { 0x48, 0x4f, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+static unsigned int normal_isa_range[] = { I2C_CLIENT_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_1(pcf8591);
+
+static int input_mode;
+MODULE_PARM(input_mode, "i");
+MODULE_PARM_DESC(input_mode,
+	"Analog input mode:\n"
+	" 0 = four single ended inputs\n"
+	" 1 = three differential inputs\n"
+	" 2 = single ended and differential mixed\n"
+	" 3 = two differential inputs\n");
+
+/* The PCF8591 control byte
+      7    6    5    4    3    2    1    0  
+   |  0 |AOEF|   AIP   |  0 |AINC|  AICH   | */
+
+/* Analog Output Enable Flag (analog output active if 1) */
+#define PCF8591_CONTROL_AOEF		0x40
+					
+/* Analog Input Programming 
+   0x00 = four single ended inputs
+   0x10 = three differential inputs
+   0x20 = single ended and differential mixed
+   0x30 = two differential inputs */
+#define PCF8591_CONTROL_AIP_MASK	0x30
+
+/* Autoincrement Flag (switch on if 1) */
+#define PCF8591_CONTROL_AINC		0x04
+
+/* Channel selection
+   0x00 = channel 0 
+   0x01 = channel 1
+   0x02 = channel 2
+   0x03 = channel 3 */
+#define PCF8591_CONTROL_AICH_MASK	0x03
+
+/* Initial values */
+#define PCF8591_INIT_CONTROL	((input_mode << 4) | PCF8591_CONTROL_AOEF)
+#define PCF8591_INIT_AOUT	0	/* DAC out = 0 */
+
+/* Conversions */
+#define REG_TO_SIGNED(reg)	(((reg) & 0x80)?((reg) - 256):(reg))
+
+struct pcf8591_data {
+	struct semaphore update_lock;
+
+	u8 control;
+	u8 aout;
+};
+
+static int pcf8591_attach_adapter(struct i2c_adapter *adapter);
+static int pcf8591_detect(struct i2c_adapter *adapter, int address, int kind);
+static int pcf8591_detach_client(struct i2c_client *client);
+static void pcf8591_init_client(struct i2c_client *client);
+static int pcf8591_read_channel(struct device *dev, int channel);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver pcf8591_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "pcf8591",
+	.id		= I2C_DRIVERID_PCF8591,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= pcf8591_attach_adapter,
+	.detach_client	= pcf8591_detach_client,
+};
+
+static int pcf8591_id = 0;
+
+/* following are the sysfs callback functions */
+#define show_in_channel(channel)					\
+static ssize_t show_in##channel##_input(struct device *dev, char *buf)	\
+{									\
+	return sprintf(buf, "%d\n", pcf8591_read_channel(dev, channel));\
+}									\
+static DEVICE_ATTR(in##channel##_input, S_IRUGO,			\
+		   show_in##channel##_input, NULL);
+
+show_in_channel(0);
+show_in_channel(1);
+show_in_channel(2);
+show_in_channel(3);
+
+static ssize_t show_out0_ouput(struct device *dev, char *buf)
+{
+	struct pcf8591_data *data = i2c_get_clientdata(to_i2c_client(dev));
+	return sprintf(buf, "%d\n", data->aout * 10);
+}
+
+static ssize_t set_out0_output(struct device *dev, const char *buf, size_t count)
+{
+	unsigned int value;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+	if ((value = (simple_strtoul(buf, NULL, 10) + 5) / 10) <= 255);
+	{
+		data->aout = value;
+		i2c_smbus_write_byte_data(client, data->control, data->aout);
+	}
+	return count;
+}
+
+static DEVICE_ATTR(out0_output, S_IWUSR | S_IRUGO, 
+		   show_out0_ouput, set_out0_output);
+
+static ssize_t show_out0_enable(struct device *dev, char *buf)
+{
+	struct pcf8591_data *data = i2c_get_clientdata(to_i2c_client(dev));
+	return sprintf(buf, "%u\n", !(!(data->control & PCF8591_CONTROL_AOEF)));
+}
+
+static ssize_t set_out0_enable(struct device *dev, const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+	if (simple_strtoul(buf, NULL, 10))
+		data->control |= PCF8591_CONTROL_AOEF;
+	else
+		data->control &= ~PCF8591_CONTROL_AOEF;
+	i2c_smbus_write_byte(client, data->control);
+	return count;
+}
+
+static DEVICE_ATTR(out0_enable, S_IWUSR | S_IRUGO, 
+		   show_out0_enable, set_out0_enable);
+
+/*
+ * Real code
+ */
+static int pcf8591_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, pcf8591_detect);
+}
+
+/* This function is called by i2c_detect */
+int pcf8591_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *new_client;
+	struct pcf8591_data *data;
+	int err = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE
+				     | I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
+		goto exit;
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet. */
+	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
+				   sizeof(struct pcf8591_data),
+				   GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	memset(new_client, 0, sizeof(struct i2c_client) +
+			      sizeof(struct pcf8591_data));
+	
+	data = (struct pcf8591_data *) (new_client + 1);
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &pcf8591_driver;
+	new_client->flags = 0;
+
+	/* Now, we would do the remaining detection. But the PCF8591 is plainly
+	   impossible to detect! Stupid chip. */
+
+	/* Determine the chip type - only one kind supported! */
+	if (kind <= 0)
+		kind = pcf8591;
+
+	/* Fill in the remaining client fields and put it into the global 
+	   list */
+	strlcpy(new_client->name, "pcf8591", I2C_NAME_SIZE);
+
+	new_client->id = pcf8591_id++;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_kfree;
+
+	/* Initialize the PCF8591 chip */
+	pcf8591_init_client(new_client);
+
+	/* Register sysfs hooks */
+	device_create_file(&new_client->dev, &dev_attr_out0_enable);
+	device_create_file(&new_client->dev, &dev_attr_out0_output);
+	device_create_file(&new_client->dev, &dev_attr_in0_input);
+	device_create_file(&new_client->dev, &dev_attr_in1_input);
+
+	/* Register input2 if not in "two differential inputs" mode */
+	if (input_mode != 3 )
+		device_create_file(&new_client->dev, &dev_attr_in2_input);
+		
+	/* Register input3 only in "four single ended inputs" mode */
+	if (input_mode == 0)
+		device_create_file(&new_client->dev, &dev_attr_in3_input);
+	
+	return 0;
+	
+	/* OK, this is not exactly good programming practice, usually. But it is
+	   very code-efficient in this case. */
+
+      exit_kfree:
+	kfree(new_client);
+      exit:
+	return err;
+}
+
+static int pcf8591_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev,
+			"Client deregistration failed, client not detached.\n");
+		return err;
+	}
+
+	kfree(client);
+	return 0;
+}
+
+/* Called when we have found a new PCF8591. */
+static void pcf8591_init_client(struct i2c_client *client)
+{
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+	data->control = PCF8591_INIT_CONTROL;
+	data->aout = PCF8591_INIT_AOUT;
+
+	i2c_smbus_write_byte_data(client, data->control, data->aout);
+	
+	/* The first byte transmitted contains the conversion code of the 
+	   previous read cycle. FLUSH IT! */
+	i2c_smbus_read_byte(client);
+}
+
+static int pcf8591_read_channel(struct device *dev, int channel)
+{
+	u8 value;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pcf8591_data *data = i2c_get_clientdata(client);
+
+	down(&data->update_lock);
+
+	if ((data->control & PCF8591_CONTROL_AICH_MASK) != channel)
+	{
+		data->control = (data->control & ~PCF8591_CONTROL_AICH_MASK)
+			      | channel;
+		i2c_smbus_write_byte(client, data->control);
+	
+		/* The first byte transmitted contains the conversion code of 
+		   the previous read cycle. FLUSH IT! */
+		i2c_smbus_read_byte(client);
+	}
+	value = i2c_smbus_read_byte(client);
+
+	up(&data->update_lock);
+
+	if ((channel == 2 && input_mode == 2) ||
+	    (channel != 3 && (input_mode == 1 || input_mode == 3)))
+		return (10 * REG_TO_SIGNED(value));
+	else
+		return (10 * value);
+}
+
+static int __init pcf8591_init(void)
+{
+	if (input_mode < 0 || input_mode > 3) {
+		printk(KERN_WARNING "pcf8591: invalid input_mode (%d)\n",
+		       input_mode);
+		input_mode = 0;
+	}
+	return i2c_add_driver(&pcf8591_driver);
+}
+
+static void __exit pcf8591_exit(void)
+{
+	i2c_del_driver(&pcf8591_driver);
+}
+
+MODULE_AUTHOR("Aurelien Jarno <aurelien@aurel32.net>");
+MODULE_DESCRIPTION("PCF8591 driver");
+MODULE_LICENSE("GPL");
+
+module_init(pcf8591_init);
+module_exit(pcf8591_exit);

