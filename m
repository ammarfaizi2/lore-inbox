Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbWHCXxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbWHCXxP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWHCXxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:53:15 -0400
Received: from bm-2a.paradise.net.nz ([203.96.152.181]:11473 "EHLO
	linda-2.paradise.net.nz") by vger.kernel.org with ESMTP
	id S1751405AbWHCXxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:53:14 -0400
Date: Fri, 04 Aug 2006 11:53:04 +1200
From: Theuns Verwoerd <theuns@bluewatersys.com>
Subject: [PATCH 001/001] I2C: AD7414 I2C chip driver for Linux-2.6.17.7
To: r.marek@sh.cvut.cz
Cc: linux-kernel@vger.kernel.org
Message-id: <44D28C60.1000304@bluewatersys.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AD7414 Temperature Sensor I2C driver.  I2C chip driver for the Analog
Devices AD7414 device, exposes raw and decoded registers via sysfs.
Signed-off-by: Theuns Verwoerd <theuns.verwoerd@bluewatersys.com>
---
Tested on a custom EP9315-based board developed in-house. Fairly trivial
driver; really just exposes the raw registers and temperature reading
to userspace.
Patch is relative to stock Linux-2.6.17.7
[This is my first go at a kernel submission, so feel free to point out 
anything
that should be done differently]
---
diff -uprN -X linux-2.6.17.7-vanilla/Documentation/dontdiff 
linux-2.6.17.7-vanilla/drivers/i2c/chips/ad7414.c 
linux-2.6.17.7/drivers/i2c/chips/ad7414.c
--- linux-2.6.17.7-vanilla/drivers/i2c/chips/ad7414.c    1970-01-01 
12:00:00.000000000 +1200
+++ linux-2.6.17.7/drivers/i2c/chips/ad7414.c    2006-08-04 
10:28:37.000000000 +1200
@@ -0,0 +1,283 @@
+/*
+ * AD7414 I2C Chip Driver
+ *
+ * Copyright (C) 2006 Theuns Verwoerd, Bluewater Systems 
(theuns.verwoerd@bluewatersys.com)
+ *
+ *    This program is free software; you can redistribute it and/or modify
+ *    it under the terms of the GNU General Public License as published by
+ *    the Free Software Foundation, version 2 of the License.
+ *
+ * Simple I2C driver for Analog Devices AD7414 temperature sensor.
+ *        Based on: lm75.c
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 0x4a, I2C_CLIENT_END };
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(ad7414);
+
+/* AD7414 Registers */
+#define AD7414_REG_TEMP            0
+#define AD7414_REG_CONF            1
+#define AD7414_REG_TEMP_HIGH    2
+#define AD7414_REG_TEMP_LOW        3
+
+/* Each client has this additional data */
+struct ad7414_data {
+    struct i2c_client client;
+    struct class_device *class_dev;
+    struct mutex update_lock;
+    char valid;        /* !=0 if following fields are valid */
+    unsigned long last_updated;    /* In jiffies */
+    u16 temp_value;        /* Register values */
+    u16 temp_config;
+    u16 temp_high;
+    u16 temp_low;
+};
+
+static int ad7414_attach_adapter(struct i2c_adapter *adapter);
+static int ad7414_detect(struct i2c_adapter *adapter, int address,
+             int kind);
+static int ad7414_detach_client(struct i2c_client *client);
+static struct ad7414_data *ad7414_update_device(struct device *dev);
+static int ad7414_ADC_to_temp(int ADC);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver ad7414_driver = {
+    .driver = {
+           .name = "ad7414",
+           },
+    .id = I2C_DRIVERID_AD7414,
+    .attach_adapter = ad7414_attach_adapter,
+    .detach_client = ad7414_detach_client,
+};
+
+#define show_raw(value)    \
+static ssize_t show_raw_##value(struct device *dev, struct 
device_attribute *attr, char *buf)    \
+{                                \
+    struct ad7414_data *data = ad7414_update_device(dev);    \
+                                \
+    return sprintf(buf, "0x%x\n", data->value);        \
+}
+show_raw(temp_value);
+show_raw(temp_config);
+show_raw(temp_high);
+show_raw(temp_low);
+
+#define show(value)    \
+static ssize_t show_##value(struct device *dev, struct device_attribute 
*attr, char *buf)    \
+{                                \
+    struct ad7414_data *data = ad7414_update_device(dev);    \
+                                \
+    return sprintf(buf, "%dC\n", data->value);        \
+}
+show(temp_high);
+show(temp_low);
+
+static ssize_t show_temp_value(struct device *dev,
+                   struct device_attribute *attr, char *buf)
+{
+    struct ad7414_data *data = ad7414_update_device(dev);
+    return sprintf(buf, "%d.%02uC %s%s%s\n",
+               ad7414_ADC_to_temp(data->temp_value) / 100,
+               abs(ad7414_ADC_to_temp(data->temp_value)) % 100,
+               data->temp_value & 0x20 ? "ALERT " : "",
+               data->temp_value & 0x10 ? "THIGH " : "",
+               data->temp_value & 0x20 ? "TLOW " : "");
+}
+
+static ssize_t show_temp_config(struct device *dev,
+                struct device_attribute *attr, char *buf)
+{
+    struct ad7414_data *data = ad7414_update_device(dev);
+    return sprintf(buf, "0x%x %s%s%s%s%s%s%s\n", data->temp_config,
+               data->temp_config & 0x80 ? "POWEROFF " : "",
+               data->temp_config & 0x40 ? "NOFILTER " : "",
+               data->temp_config & 0x20 ? "NOALERT " : "",
+               data->temp_config & 0x10 ? "ALRTHIGH " : "ALRTLOW ",
+               data->temp_config & 0x08 ? "ALERTRST " : "",
+               data->temp_config & 0x04 ? "ONESHOT " : "",
+               data->temp_config & 0x03 ? "TESTMODE " : "");
+}
+
+#define set_raw(value, reg)    \
+static ssize_t set_raw_##value(struct device *dev, struct 
device_attribute *attr, const char *buf, size_t count)    \
+{                                \
+    struct i2c_client *client = to_i2c_client(dev);        \
+    struct ad7414_data *data = i2c_get_clientdata(client);    \
+    int value = simple_strtoul(buf, NULL, 0);        \
+                                \
+    mutex_lock(&data->update_lock);                \
+    data->value = value;                    \
+    i2c_smbus_write_byte_data(client, reg, value);        \
+    mutex_unlock(&data->update_lock);                    \
+    return count;                        \
+}
+set_raw(temp_config, AD7414_REG_CONF);
+set_raw(temp_high, AD7414_REG_TEMP_HIGH);
+set_raw(temp_low, AD7414_REG_TEMP_LOW);
+
+static DEVICE_ATTR(raw_config, S_IWUSR | S_IRUGO, show_raw_temp_config,
+           set_raw_temp_config);
+static DEVICE_ATTR(raw_high, S_IWUSR | S_IRUGO, show_raw_temp_high,
+           set_raw_temp_high);
+static DEVICE_ATTR(raw_low, S_IWUSR | S_IRUGO, show_raw_temp_low,
+           set_raw_temp_low);
+static DEVICE_ATTR(raw_value, S_IRUGO, show_raw_temp_value, NULL);
+
+static DEVICE_ATTR(temp_config, S_IRUGO, show_temp_config, NULL);
+static DEVICE_ATTR(temp_high, S_IRUGO, show_temp_high, NULL);
+static DEVICE_ATTR(temp_low, S_IRUGO, show_temp_low, NULL);
+static DEVICE_ATTR(temp_value, S_IRUGO, show_temp_value, NULL);
+
+static int ad7414_ADC_to_temp(int ADC)
+{
+    /* ADC temp is D15..D6, two's complement, but it's only 10 bits */
+    ADC = ADC >> 6;
+    if (ADC > 0x200) {
+        return (((ADC & 0x1ff) - 512) * 100 / 4);
+    } else {
+        return (ADC * 100 / 4);
+    }
+}
+
+static int ad7414_read_value(struct i2c_client *client, u8 reg)
+{
+    int value = ~0;
+    switch (reg) {
+    case AD7414_REG_TEMP:    /* 10-bit register, MSB first */
+        value = swab16(i2c_smbus_read_word_data(client, reg));
+        break;
+    default:        /* 8-bit register */
+        value = i2c_smbus_read_byte_data(client, reg);
+        break;
+    }
+    return value;
+}
+
+static int ad7414_attach_adapter(struct i2c_adapter *adapter)
+{
+    return i2c_probe(adapter, &addr_data, ad7414_detect);
+}
+
+/* This function is called by i2c_probe */
+static int ad7414_detect(struct i2c_adapter *adapter, int address,
+             int kind)
+{
+    struct i2c_client *new_client = NULL;
+    struct ad7414_data *data = NULL;
+    int err = 0;
+
+    if (!i2c_check_functionality
+        (adapter, I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA))
+        goto error;
+
+    data = kzalloc(sizeof(*data), GFP_KERNEL);
+    if (!data) {
+        err = -ENOMEM;
+        goto error;
+    }
+
+    new_client = &data->client;
+    i2c_set_clientdata(new_client, data);
+    new_client->addr = address;
+    new_client->adapter = adapter;
+    new_client->driver = &ad7414_driver;
+    new_client->flags = 0;
+
+    /* Fill in the remaining client fields */
+    strncpy(new_client->name, "ad7414", I2C_NAME_SIZE);
+    data->valid = 0;
+    mutex_init(&data->update_lock);
+
+    /* Tell the I2C layer a new client has arrived */
+    err = i2c_attach_client(new_client);
+    if (err)
+        goto error;
+
+    /* Register sysfs files */
+    device_create_file(&new_client->dev, &dev_attr_raw_config);
+    device_create_file(&new_client->dev, &dev_attr_raw_high);
+    device_create_file(&new_client->dev, &dev_attr_raw_low);
+    device_create_file(&new_client->dev, &dev_attr_raw_value);
+
+    device_create_file(&new_client->dev, &dev_attr_temp_config);
+    device_create_file(&new_client->dev, &dev_attr_temp_high);
+    device_create_file(&new_client->dev, &dev_attr_temp_low);
+    device_create_file(&new_client->dev, &dev_attr_temp_value);
+
+    return 0;
+
+      error:
+    kfree(data);
+    return err;
+}
+
+static int ad7414_detach_client(struct i2c_client *client)
+{
+    struct ad7414_data *data = i2c_get_clientdata(client);
+    int err;
+
+    err = i2c_detach_client(client);
+    if (err) {
+        dev_err(&client->dev,
+            "Client deregistration failed, client not detached.\n");
+        return err;
+    }
+    kfree(data);
+    return 0;
+}
+
+static struct ad7414_data *ad7414_update_device(struct device *dev)
+{
+    struct i2c_client *client = to_i2c_client(dev);
+    struct ad7414_data *data = i2c_get_clientdata(client);
+
+    mutex_lock(&data->update_lock);
+
+    if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+        || !data->valid) {
+        dev_dbg(&client->dev, "Starting ad7414 update\n");
+
+        data->temp_value =
+            ad7414_read_value(client, AD7414_REG_TEMP);
+        data->temp_config =
+            ad7414_read_value(client, AD7414_REG_CONF);
+        data->temp_high =
+            ad7414_read_value(client, AD7414_REG_TEMP_HIGH);
+        data->temp_low =
+            ad7414_read_value(client, AD7414_REG_TEMP_LOW);
+        data->last_updated = jiffies;
+        data->valid = 1;
+    }
+
+    mutex_unlock(&data->update_lock);
+
+    return data;
+}
+
+static int __init ad7414_init(void)
+{
+    return i2c_add_driver(&ad7414_driver);
+}
+
+static void __exit ad7414_exit(void)
+{
+    i2c_del_driver(&ad7414_driver);
+}
+
+
+MODULE_AUTHOR("Theuns Verwoerd <theuns.verwoerd@bluewatersys.com>");
+MODULE_DESCRIPTION("AD7414 I2C driver");
+MODULE_LICENSE("GPL");
+
+module_init(ad7414_init);
+module_exit(ad7414_exit);
diff -uprN -X linux-2.6.17.7-vanilla/Documentation/dontdiff 
linux-2.6.17.7-vanilla/drivers/i2c/chips/Kconfig 
linux-2.6.17.7/drivers/i2c/chips/Kconfig
--- linux-2.6.17.7-vanilla/drivers/i2c/chips/Kconfig    2006-07-25 
15:36:01.000000000 +1200
+++ linux-2.6.17.7/drivers/i2c/chips/Kconfig    2006-08-04 
10:21:13.000000000 +1200
@@ -25,6 +25,16 @@ config SENSORS_DS1374
       This driver can also be built as a module.  If so, the module
       will be called ds1374.
 
+config SENSORS_AD7414
+    tristate "Analog Devices AD7414-0 Temperature Sensor"
+    depends on I2C && EXPERIMENTAL
+    help
+      If you say yes here you get support for Analog Devices
+      AD7414-0 temperature sensor.
+
+      This driver can also be built as a module.  If so, the module
+      will be called ad7414.
+
 config SENSORS_EEPROM
     tristate "EEPROM reader"
     depends on I2C && EXPERIMENTAL
diff -uprN -X linux-2.6.17.7-vanilla/Documentation/dontdiff 
linux-2.6.17.7-vanilla/drivers/i2c/chips/Makefile 
linux-2.6.17.7/drivers/i2c/chips/Makefile
--- linux-2.6.17.7-vanilla/drivers/i2c/chips/Makefile    2006-07-25 
15:36:01.000000000 +1200
+++ linux-2.6.17.7/drivers/i2c/chips/Makefile    2006-08-04 
10:18:48.000000000 +1200
@@ -12,6 +12,7 @@ obj-$(CONFIG_SENSORS_PCF8574)    += pcf8574
 obj-$(CONFIG_SENSORS_PCF8591)    += pcf8591.o
 obj-$(CONFIG_ISP1301_OMAP)    += isp1301_omap.o
 obj-$(CONFIG_TPS65010)        += tps65010.o
+obj-$(CONFIG_SENSORS_AD7414)    += ad7414.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
 EXTRA_CFLAGS += -DDEBUG
diff -uprN -X linux-2.6.17.7-vanilla/Documentation/dontdiff 
linux-2.6.17.7-vanilla/include/linux/i2c-id.h 
linux-2.6.17.7/include/linux/i2c-id.h
--- linux-2.6.17.7-vanilla/include/linux/i2c-id.h    2006-07-25 
15:36:01.000000000 +1200
+++ linux-2.6.17.7/include/linux/i2c-id.h    2006-08-04 
10:10:39.000000000 +1200
@@ -112,6 +112,7 @@
 #define I2C_DRIVERID_X1205    82    /* Xicor/Intersil X1205 RTC    */
 #define I2C_DRIVERID_PCF8563    83    /* Philips PCF8563 RTC        */
 #define I2C_DRIVERID_RS5C372    84    /* Ricoh RS5C372 RTC        */
+#define I2C_DRIVERID_AD7414    85    /* AD7414 I2C Chip Driver */
 
 #define I2C_DRIVERID_I2CDEV    900
 #define I2C_DRIVERID_ARP        902    /* SMBus ARP Client              */

