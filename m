Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965206AbVJ1JwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965206AbVJ1JwT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 05:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbVJ1JwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 05:52:19 -0400
Received: from 186.70-86-75.reverse.theplanet.com ([70.86.75.186]:10380 "EHLO
	o-hand.com") by vger.kernel.org with ESMTP id S965206AbVJ1JwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 05:52:18 -0400
Subject: [RFC] The driver model, I2C and gpio provision on Sharp SL-C1000
	(Akita)
From: Richard Purdie <richard@openedhand.com>
To: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
       Greg KH <gregkh@suse.de>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 10:52:09 +0100
Message-Id: <1130493129.8414.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This code is the final link is getting akita working but I'm not sure
its the right approach. I'm posting this in the hope someone might see a
better way to achieve this driver's objectives. I'd like to get akita
support into mainline and this is the only barrier.

Background:

The Sharp SL-C1000 (Akita) has an 8 port Maxim 7310 IO Expander
connected via I2C. In this specific case, 5 outputs are used from a
variety of linux subsystems such as the backlight, IR port and sound. 

Driver Design Criteria:

* GPIOs need to be available fairly early in the boot procedure as we
can't guarantee when the subsystems will use them
* GPIOs can be changed from interrupt context
* GPIO providers need to be one of the last devices suspended/first
resumed

A Solution:

Firstly, I wrote an I2C driver for the MAX7310 which is included below.
This shouldn't be too controversial. It does export some functions and
I'm not sure what to do about a header file for them. Creating a
specific header file for them seems a little over the top. I realise I
need to sort out the I2C_DRIVERID properly. I'm also aware it has a lot
of different ids and no method to detect whether the chip is really
present (Akita uses 0x18 as the slave id).

I2C drivers appear relatively late in the boot procedure and changing
that isn't practical. I therefore ended up writing akita-ioexp which
acts as an interface between the rest of the kernel drivers and the
max7310 i2c driver.

When akita-ioexp loads, the i2c driver isn't likely to be present. I've
used the init levels to ensure it comes up after the i2c-core but that's
about all we can hope for. It therefore searches for the max7310 and if
not found, schedules a repeat of the search for later, repeating until
it finds the device (using a workqueue). The workqueue is also used to
get around gpio requests from interrupt context. 

I had to turn akita-ioexp into a platform device to get the suspend
signal which is used to flush the workqueue. With a platform device
available at machine init time, I can insert it as a parent of the corgi
device chain which means its one of the last devices to be suspended. I
couldn't do this with an i2c device as it won't be around at early init.
I do remember reading about the idea of being able to dynamically alter
the device parent chain which would help with this but I don't think
this exists (yet?).

In this case, we only have output gpios and the timing isn't critical.
We can therefore queue the output until the max7310 becomes available.
This wouldn't work for inputs or devices that would have an issue with
delayed output.

Alternatives:

I can see a case for ditching the generic max7310 driver and putting its
code directly into akita-ioexp. If I'd tried this the other way around,
I know what I would have been told :). Anyhow, this solves some issues
and creates others. The main one would be how to arrange for a very late
suspend call as the device wouldn't be available to set as a parent for
the corgi device tree at early boot. Obviously any such driver would
then be totally akita specific.

There is a fundamental problem with the lack of a proper gpio interface
in Linux. Every driver does something different with them (be it pxa
specific gpios, SCOOP gpios, those on a IO expander, those on a video
chip (w100fb springs to mind) to name just the Zaurus specific ones.

Is this patch going to be acceptable and/or is there anything we can do
to improve this driver and/or Linux in general to support these kind of
needs?

Richard

[The full Akita machine patch is available as
http://www.rpsys.net/openzaurus/patches/spitz_base_extras-r4.patch ]

Index: linux-2.6.13/arch/arm/mach-pxa/akita-ioexp.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13/arch/arm/mach-pxa/akita-ioexp.c	2005-10-27 21:41:13.000000000 +0100
@@ -0,0 +1,118 @@
+/*
+ * Support for the IO Expander on the Sharp SL-C1000 (Akita)
+ *
+ * Copyright 2005 Openedhand Ltd.
+ *
+ * Author: Richard Purdie <richard@openedhand.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/workqueue.h>
+#include <asm/arch/akita.h>
+
+/* These should be somewhere else */
+int max7310_config(struct device *dev, int iomode, int polarity);
+int max7310_set_ouputs(struct device *dev, int outputs);
+
+static void akita_ioexp_work(void *private_);
+
+static struct device *akita_ioexp_device;
+static unsigned char ioexp_output_value = AKITA_IOEXP_IO_OUT;
+DECLARE_WORK(akita_ioexp, akita_ioexp_work, NULL);
+
+void akita_set_ioexp(struct device *dev, unsigned char bit)
+{
+	ioexp_output_value |= bit;
+
+	if (akita_ioexp_device)
+		schedule_work(&akita_ioexp);
+	return;
+}
+
+void akita_reset_ioexp(struct device *dev, unsigned char bit)
+{
+	ioexp_output_value &= ~bit;
+
+	if (akita_ioexp_device)
+		schedule_work(&akita_ioexp);
+	return;
+}
+
+EXPORT_SYMBOL(akita_set_ioexp);
+EXPORT_SYMBOL(akita_reset_ioexp);
+
+static int is_akita_ioexp_device(struct device *dev, void *data)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	return (strncmp(client->name, "max7310", 7) == 0);
+}
+
+static void akita_ioexp_work(void *private_)
+{
+	if (!akita_ioexp_device) {
+		akita_ioexp_device = bus_find_device(&i2c_bus_type, NULL, NULL, is_akita_ioexp_device);
+
+		if (!akita_ioexp_device) {
+			/* if we can't find the device, wait and retry */
+			schedule_delayed_work(&akita_ioexp, msecs_to_jiffies(500));
+			return;
+		}
+		
+		max7310_config(akita_ioexp_device, AKITA_IOEXP_IO_DIR, 0);
+	}
+
+	max7310_set_ouputs(akita_ioexp_device, ioexp_output_value);
+}
+
+
+#ifdef CONFIG_PM
+static int akita_ioexp_suspend(struct device *dev, pm_message_t state, uint32_t level)
+{
+	if (level == SUSPEND_POWER_DOWN) {
+		flush_scheduled_work();
+	}
+	return 0;
+}	
+		
+static int akita_ioexp_resume(struct device *dev, uint32_t level)
+{
+	if (level == RESUME_POWER_ON) {
+		schedule_work(&akita_ioexp);
+	}
+	return 0;
+}
+#else
+#define akita_ioexp_suspend NULL
+#define akita_ioexp_resume NULL
+#endif
+
+
+static int __init akita_ioexp_probe(struct device *dev)
+{
+	schedule_work(&akita_ioexp);
+	return 0;
+}
+
+static struct device_driver akita_ioexp_driver = {
+	.name		= "akita-ioexp",
+	.bus		= &platform_bus_type,
+	.probe		= akita_ioexp_probe,
+	.suspend	= akita_ioexp_suspend,
+	.resume		= akita_ioexp_resume,
+};
+
+static int __devinit akita_ioexp_init(void)
+{
+	return driver_register(&akita_ioexp_driver);
+}
+
+module_init(akita_ioexp_init);
+


Index: linux-2.6.13/drivers/i2c/chips/max7310.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13/drivers/i2c/chips/max7310.c	2005-10-27 21:23:25.000000000 +0100
@@ -0,0 +1,201 @@
+/* 
+ * max7310.c  --  Maxim MAX7310 8 Port IO Expander
+ *
+ * Copyright 2005 Openedhand Ltd.
+ *
+ * Author: Richard Purdie <richard@openedhand.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define I2C_DRIVERID_MAX7310 0xdafe
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+
+/* MAX7310 Regiser Map */
+#define MAX7310_INPUT    0x00
+#define MAX7310_OUTPUT   0x01
+#define MAX7310_POLINV   0x02
+#define MAX7310_IODIR    0x03 /* 1 = Input, 0 = Output */
+#define MAX7310_TIMEOUT  0x04
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,  
+	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 
+	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 
+	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 
+	0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f, 
+	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 
+	0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
+	I2C_CLIENT_END 
+};
+
+/* I2C Magic */
+I2C_CLIENT_INSMOD;
+
+static int max7310_write(struct i2c_client *client, int address, int data);
+static int max7310_read(struct i2c_client *client, int address);
+static struct i2c_client max7310_template;
+
+/* 
+ * Public Interface
+ */
+int max7310_config(struct device *dev, int iomode, int polarity)
+{
+	int ret;
+	struct i2c_client *client = to_i2c_client(dev);
+
+	ret = max7310_write(client, MAX7310_POLINV, polarity); 
+	if (ret < 0)
+		return ret;
+	ret = max7310_write(client, MAX7310_IODIR, iomode); 
+	return ret;
+}
+
+int max7310_set_ouputs(struct device *dev, int outputs)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return max7310_write(client, MAX7310_OUTPUT, outputs); 
+}
+
+int max7310_read_inputs(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return max7310_read(client, MAX7310_INPUT); 
+}
+
+EXPORT_SYMBOL(max7310_config);
+EXPORT_SYMBOL(max7310_set_ouputs);
+EXPORT_SYMBOL(max7310_read_inputs);
+
+
+/* 
+ * Sysfs Functions 
+ */
+static ssize_t show_gpio(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "0x%02x\n", max7310_read_inputs(dev));
+}
+
+static ssize_t set_gpio(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	unsigned long val = simple_strtoul(buf, NULL, 16);
+
+	if (val > 0xff)
+		return -EINVAL;
+
+	max7310_set_ouputs(dev, val);
+
+	return count;
+}
+
+static DEVICE_ATTR(gpio, S_IWUSR | S_IRUGO, show_gpio, set_gpio);
+
+
+/*
+ * I2C Functions
+ */
+static int max7310_write(struct i2c_client *client, int address, int value)
+{
+	u8 data[2];
+
+	data[0] = address & 0xff;
+	data[1] = value & 0xff;
+
+	if (i2c_master_send(client, data, 2) == 2)
+		return 0;
+	return -1;
+}
+
+static int max7310_read(struct i2c_client *client, int address)
+{
+	u8 data[1];
+
+	data[0] = address & 0xff;
+
+	if (i2c_master_recv(client, data, 1) == 1) {
+		return data[0];
+	}
+	return -1;
+}
+
+static int max7310_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *new_client;
+	int err;
+
+	if (!(new_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL)))
+		return -ENOMEM;
+
+	max7310_template.adapter = adapter;
+	max7310_template.addr = address;
+	
+	memcpy(new_client, &max7310_template, sizeof(struct i2c_client));
+
+	if ((err = i2c_attach_client(new_client))) {
+		kfree(new_client);
+		return err;
+	}
+	
+	/* Register sysfs hooks */
+	device_create_file(&new_client->dev, &dev_attr_gpio);
+	return 0;
+}
+
+static int max7310_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_probe(adapter, &addr_data, max7310_detect);
+}
+
+static int max7310_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	device_remove_file(&client->dev, &dev_attr_gpio);
+
+	if ((err = i2c_detach_client(client)))
+		return err;
+
+	kfree(client);
+	return 0;
+}
+
+static struct i2c_driver max7310_i2c_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "max7310",
+	.id		= I2C_DRIVERID_MAX7310,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= max7310_attach_adapter,
+	.detach_client	= max7310_detach_client,
+};
+
+static struct i2c_client max7310_template = {
+	name:   "max7310",
+	flags:  I2C_CLIENT_ALLOW_USE,
+	driver: &max7310_i2c_driver,
+};
+
+static int __init max7310_init(void)
+{
+	return i2c_add_driver(&max7310_i2c_driver);
+}
+
+static void __exit max7310_exit(void)
+{
+	i2c_del_driver(&max7310_i2c_driver);
+}
+
+MODULE_AUTHOR("Richard Purdie <rpurdie@openedhand.com>");
+MODULE_DESCRIPTION("MAX7310 driver");
+MODULE_LICENSE("GPL");
+
+module_init(max7310_init);
+module_exit(max7310_exit);
Index: linux-2.6.13/drivers/i2c/chips/Kconfig
===================================================================
--- linux-2.6.13.orig/drivers/i2c/chips/Kconfig	2005-10-25 16:03:08.000000000 +0100
+++ linux-2.6.13/drivers/i2c/chips/Kconfig	2005-10-27 14:47:02.000000000 +0100
@@ -126,4 +126,17 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called max6875.
 
+config MAX7310
+	tristate "Maxim MAX7310 8 Port IO Exander"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Maxim MAX7310
+	  8 Port IO Exander. 
+
+	  This chip is found in certain devices such as the Sharp Zaurus
+	  SL-C1000 (Akita).
+	  
+	  This driver can also be built as a module.  If so, the module
+	  will be called max7310.
+
 endmenu
Index: linux-2.6.13/drivers/i2c/chips/Makefile
===================================================================
--- linux-2.6.13.orig/drivers/i2c/chips/Makefile	2005-08-29 00:41:01.000000000 +0100
+++ linux-2.6.13/drivers/i2c/chips/Makefile	2005-10-27 14:47:14.000000000 +0100
@@ -12,6 +12,7 @@
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_RTC8564)	+= rtc8564.o
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
+obj-$(CONFIG_MAX7310)		+= max7310.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)




