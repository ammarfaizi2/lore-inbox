Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbVFVH1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbVFVH1s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbVFVHZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:25:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:58267 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262769AbVFVFVv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:51 -0400
Cc: bgardner@wabtec.com
Subject: [PATCH] I2C: add new pca9539 driver
In-Reply-To: <1119417467761@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:47 -0700
Message-Id: <11194174672691@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: add new pca9539 driver

This is an i2c driver for the Philips PCA9539 (16 bit I/O port).
It uses the new i2c-sysfs interfaces.
The patch includes documentation.
It depends on the patch that renames "i2c-sysfs.h" to "hwmon-sysfs.h"

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 69dd204b6b45987dbf9ce7058cd238d355865281
tree e033f9697109d4a411e5c6707b0e6991e00ede7f
parent 10c08f8100ee2c4d27b862635574cdf4ef439e67
author bgardner@wabtec.com <bgardner@wabtec.com> Tue, 07 Jun 2005 08:55:38 -0500
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:05 -0700

 Documentation/i2c/chips/pca9539 |   47 ++++++++++
 drivers/i2c/chips/Kconfig       |   10 ++
 drivers/i2c/chips/Makefile      |    1 
 drivers/i2c/chips/pca9539.c     |  192 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 250 insertions(+), 0 deletions(-)

diff --git a/Documentation/i2c/chips/pca9539 b/Documentation/i2c/chips/pca9539
new file mode 100644
--- /dev/null
+++ b/Documentation/i2c/chips/pca9539
@@ -0,0 +1,47 @@
+Kernel driver pca9539
+=====================
+
+Supported chips:
+  * Philips PCA9539
+    Prefix: 'pca9539'
+    Addresses scanned: 0x74 - 0x77
+    Datasheet:
+        http://www.semiconductors.philips.com/acrobat/datasheets/PCA9539_2.pdf
+
+Author: Ben Gardner <bgardner@wabtec.com>
+
+
+Description
+-----------
+
+The Philips PCA9539 is a 16 bit low power I/O device.
+All 16 lines can be individually configured as an input or output.
+The input sense can also be inverted.
+The 16 lines are split between two bytes.
+
+
+Sysfs entries
+-------------
+
+Each is a byte that maps to the 8 I/O bits.
+A '0' suffix is for bits 0-7, while '1' is for bits 8-15.
+
+input[01]     - read the current value
+output[01]    - sets the output value
+direction[01] - direction of each bit: 1=input, 0=output
+invert[01]    - toggle the input bit sense
+
+input reads the actual state of the line and is always available.
+The direction defaults to input for all channels.
+
+
+General Remarks
+---------------
+
+Note that each output, direction, and invert entry controls 8 lines.
+You should use the read, modify, write sequence.
+For example. to set output bit 0 of 1.
+  val=$(cat output0)
+  val=$(( $val | 1 ))
+  echo $val > output0
+
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -440,6 +440,16 @@ config SENSORS_PCF8574
 	  This driver can also be built as a module.  If so, the module
 	  will be called pcf8574.
 
+config SENSORS_PCA9539
+	tristate "Philips PCA9539 16-bit I/O port"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Philips PCA9539
+	  16-bit I/O port.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called pca9539.
+
 config SENSORS_PCF8591
 	tristate "Philips PCF8591"
 	depends on I2C && EXPERIMENTAL
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_SENSORS_MAX1619)	+= max1619
 obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
 obj-$(CONFIG_SENSORS_M41T00)	+= m41t00.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
+obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_RTC8564)	+= rtc8564.o
diff --git a/drivers/i2c/chips/pca9539.c b/drivers/i2c/chips/pca9539.c
new file mode 100644
--- /dev/null
+++ b/drivers/i2c/chips/pca9539.c
@@ -0,0 +1,192 @@
+/*
+    pca9539.c - 16-bit I/O port with interrupt and reset
+
+    Copyright (C) 2005 Ben Gardner <bgardner@wabtec.com>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; version 2 of the License.
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/i2c-sensor.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = {0x74, 0x75, 0x76, 0x77, I2C_CLIENT_END};
+static unsigned int normal_isa[] = {I2C_CLIENT_ISA_END};
+
+/* Insmod parameters */
+SENSORS_INSMOD_1(pca9539);
+
+enum pca9539_cmd
+{
+	PCA9539_INPUT_0		= 0,
+	PCA9539_INPUT_1		= 1,
+	PCA9539_OUTPUT_0	= 2,
+	PCA9539_OUTPUT_1	= 3,
+	PCA9539_INVERT_0	= 4,
+	PCA9539_INVERT_1	= 5,
+	PCA9539_DIRECTION_0	= 6,
+	PCA9539_DIRECTION_1	= 7,
+};
+
+static int pca9539_attach_adapter(struct i2c_adapter *adapter);
+static int pca9539_detect(struct i2c_adapter *adapter, int address, int kind);
+static int pca9539_detach_client(struct i2c_client *client);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver pca9539_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "pca9539",
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= pca9539_attach_adapter,
+	.detach_client	= pca9539_detach_client,
+};
+
+struct pca9539_data {
+	struct i2c_client client;
+};
+
+/* following are the sysfs callback functions */
+static ssize_t pca9539_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct sensor_device_attribute *psa = to_sensor_dev_attr(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+	return sprintf(buf, "%d\n", i2c_smbus_read_byte_data(client,
+							     psa->index));
+}
+
+static ssize_t pca9539_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	struct sensor_device_attribute *psa = to_sensor_dev_attr(attr);
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long val = simple_strtoul(buf, NULL, 0);
+	if (val > 0xff)
+		return -EINVAL;
+	i2c_smbus_write_byte_data(client, psa->index, val);
+	return count;
+}
+
+/* Define the device attributes */
+
+#define PCA9539_ENTRY_RO(name, cmd_idx) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO, pca9539_show, NULL, cmd_idx)
+
+#define PCA9539_ENTRY_RW(name, cmd_idx) \
+	static SENSOR_DEVICE_ATTR(name, S_IRUGO | S_IWUSR, pca9539_show, \
+				  pca9539_store, cmd_idx)
+
+PCA9539_ENTRY_RO(input0, PCA9539_INPUT_0);
+PCA9539_ENTRY_RO(input1, PCA9539_INPUT_1);
+PCA9539_ENTRY_RW(output0, PCA9539_OUTPUT_0);
+PCA9539_ENTRY_RW(output1, PCA9539_OUTPUT_1);
+PCA9539_ENTRY_RW(invert0, PCA9539_INVERT_0);
+PCA9539_ENTRY_RW(invert1, PCA9539_INVERT_1);
+PCA9539_ENTRY_RW(direction0, PCA9539_DIRECTION_0);
+PCA9539_ENTRY_RW(direction1, PCA9539_DIRECTION_1);
+
+static struct attribute *pca9539_attributes[] = {
+	&sensor_dev_attr_input0.dev_attr.attr,
+	&sensor_dev_attr_input1.dev_attr.attr,
+	&sensor_dev_attr_output0.dev_attr.attr,
+	&sensor_dev_attr_output1.dev_attr.attr,
+	&sensor_dev_attr_invert0.dev_attr.attr,
+	&sensor_dev_attr_invert1.dev_attr.attr,
+	&sensor_dev_attr_direction0.dev_attr.attr,
+	&sensor_dev_attr_direction1.dev_attr.attr,
+	NULL
+};
+
+static struct attribute_group pca9539_defattr_group = {
+	.attrs = pca9539_attributes,
+};
+
+static int pca9539_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, pca9539_detect);
+}
+
+/* This function is called by i2c_detect */
+static int pca9539_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *new_client;
+	struct pca9539_data *data;
+	int err = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto exit;
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet. */
+	if (!(data = kmalloc(sizeof(struct pca9539_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	memset(data, 0, sizeof(struct pca9539_data));
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &pca9539_driver;
+	new_client->flags = 0;
+
+	/* Detection: the pca9539 only has 8 registers (0-7).
+	   A read of 7 should succeed, but a read of 8 should fail. */
+	if ((i2c_smbus_read_byte_data(new_client, 7) < 0) ||
+	    (i2c_smbus_read_byte_data(new_client, 8) >= 0))
+		goto exit_kfree;
+
+	strlcpy(new_client->name, "pca9539", I2C_NAME_SIZE);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_kfree;
+
+	/* Register sysfs hooks (don't care about failure) */
+	sysfs_create_group(&new_client->dev.kobj, &pca9539_defattr_group);
+
+	return 0;
+
+exit_kfree:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int pca9539_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev, "Client deregistration failed.\n");
+		return err;
+	}
+
+	kfree(i2c_get_clientdata(client));
+	return 0;
+}
+
+static int __init pca9539_init(void)
+{
+	return i2c_add_driver(&pca9539_driver);
+}
+
+static void __exit pca9539_exit(void)
+{
+	i2c_del_driver(&pca9539_driver);
+}
+
+MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
+MODULE_DESCRIPTION("PCA9539 driver");
+MODULE_LICENSE("GPL");
+
+module_init(pca9539_init);
+module_exit(pca9539_exit);
+

