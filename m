Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262913AbVFVHcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbVFVHcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbVFVH3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:29:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:57243 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262770AbVFVFVu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:21:50 -0400
Cc: BGardner@Wabtec.com
Subject: [PATCH] max6875: new i2c device driver
In-Reply-To: <11194174672691@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:48 -0700
Message-Id: <1119417468829@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] max6875: new i2c device driver

This patch adds support for the MAX6875/MAX6874 chips.

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit c3bc4caedd84ad03360cb9ec04b6c44ab314588b
tree 5ae34e8b136d2584be6d30f9203c7dba49f27663
parent 20ad93d4e5cf5f0616198b5919ee9f304119dd4b
author BGardner@Wabtec.com <BGardner@Wabtec.com> Fri, 03 Jun 2005 13:03:27 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:52:05 -0700

 Documentation/i2c/chips/max6875 |   54 ++++
 drivers/i2c/chips/Kconfig       |   12 +
 drivers/i2c/chips/Makefile      |    1 
 drivers/i2c/chips/max6875.c     |  473 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 540 insertions(+), 0 deletions(-)

diff --git a/Documentation/i2c/chips/max6875 b/Documentation/i2c/chips/max6875
new file mode 100644
--- /dev/null
+++ b/Documentation/i2c/chips/max6875
@@ -0,0 +1,54 @@
+Kernel driver max6875
+=====================
+
+Supported chips:
+  * Maxim max6874, max6875
+    Prefixes: 'max6875'
+    Addresses scanned: 0x50, 0x52
+    Datasheets:
+        http://pdfserv.maxim-ic.com/en/ds/MAX6874-MAX6875.pdf
+
+Author: Ben Gardner <bgardner@wabtec.com>
+
+
+Module Parameters
+-----------------
+
+* allow_write int
+  Set to non-zero to enable write permission:
+  *0: Read only
+   1: Read and write
+
+
+Description
+-----------
+
+The MAXIM max6875 is a EEPROM-programmable power-supply sequencer/supervisor.
+It provides timed outputs that can be used as a watchdog, if properly wired.
+It also provides 512 bytes of user EEPROM.
+
+At reset, the max6875 reads the configuration eeprom into its configuration
+registers.  The chip then begins to operate according to the values in the
+registers.
+
+See the datasheet for details on how to program the EEPROM.
+
+
+Sysfs entries
+-------------
+
+eeprom_user   - 512 bytes of user-defined EEPROM space. Only writable if
+                allow_write was set and register 0x43 is 0.
+
+eeprom_config - 70 bytes of config EEPROM. Note that changes will not get
+                loaded into register space until a power cycle or device reset.
+
+reg_config    - 70 bytes of register space. Any changes take affect immediately.
+
+
+General Remarks
+---------------
+
+A typical application will require that the EEPROMs be programmed once and
+never altered afterwards.
+
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -498,4 +498,16 @@ config SENSORS_M41T00
 	  This driver can also be built as a module.  If so, the module
 	  will be called m41t00.
 
+config SENSORS_MAX6875
+	tristate "MAXIM MAX6875 Power supply supervisor"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the MAX6875
+	  EEPROM-Programmable, Hex/Quad, Power-Suppy Sequencers/Supervisors.
+
+          This provides a interface to program the EEPROM and reset the chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called max6875.
+
 endmenu
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_SENSORS_LM87)	+= lm87.o
 obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
 obj-$(CONFIG_SENSORS_LM92)	+= lm92.o
 obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
+obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
 obj-$(CONFIG_SENSORS_M41T00)	+= m41t00.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
diff --git a/drivers/i2c/chips/max6875.c b/drivers/i2c/chips/max6875.c
new file mode 100644
--- /dev/null
+++ b/drivers/i2c/chips/max6875.c
@@ -0,0 +1,473 @@
+/*
+    max6875.c - driver for MAX6874/MAX6875
+
+    Copyright (C) 2005 Ben Gardner <bgardner@wabtec.com>
+
+    Based on i2c/chips/eeprom.c
+
+    The MAX6875 has two EEPROM sections: config and user.
+    At reset, the config EEPROM is read into the registers.
+
+    This driver make 3 binary files available in sysfs:
+      reg_config    - direct access to the registers
+      eeprom_config - acesses configuration eeprom space
+      eeprom_user   - free for application use
+
+    In our application, we put device serial & model numbers in user eeprom.
+
+    Notes:
+      1) The datasheet says that register 0x44 / EEPROM 0x8044 should NOT
+         be overwritten, so the driver explicitly prevents that.
+      2) It's a good idea to keep the config (0x45) locked in config EEPROM.
+         You can temporarily enable config writes by changing register 0x45.
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; version 2 of the License.
+*/
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = {0x50, 0x52, I2C_CLIENT_END};
+static unsigned int normal_isa[] = {I2C_CLIENT_ISA_END};
+
+/* Insmod parameters */
+SENSORS_INSMOD_1(max6875);
+
+/* this param will prevent 'accidental' writes to the eeprom */
+static int allow_write = 0;
+module_param(allow_write, int, 0);
+MODULE_PARM_DESC(allow_write,
+		 "Enable write access:\n"
+		 "*0: Read only\n"
+		 " 1: Read/Write access");
+
+/* The MAX6875 can only read/write 16 bytes at a time */
+#define SLICE_SIZE			16
+#define SLICE_BITS			4
+
+/* CONFIG EEPROM is at addresses 0x8000 - 0x8045, registers are at 0 - 0x45 */
+#define CONFIG_EEPROM_BASE		0x8000
+#define CONFIG_EEPROM_SIZE		0x0046
+#define CONFIG_EEPROM_SLICES		5
+
+/* USER EEPROM is at addresses 0x8100 - 0x82FF */
+#define USER_EEPROM_BASE		0x8100
+#define USER_EEPROM_SIZE		0x0200
+#define USER_EEPROM_SLICES		32
+
+/* MAX6875 commands */
+#define MAX6875_CMD_BLOCK_WRITE		0x83
+#define MAX6875_CMD_BLOCK_READ		0x84
+#define MAX6875_CMD_REBOOT		0x88
+
+enum max6875_area_type {
+	max6875_register_config=0,
+	max6875_eeprom_config,
+	max6875_eeprom_user,
+	max6857_max
+};
+
+struct eeprom_block {
+	enum max6875_area_type	type;
+	u8			slices;
+	u32			size;
+	u32			valid;
+	u32			base;
+	unsigned long		*updated;
+	u8			*data;
+};
+
+/* Each client has this additional data */
+struct max6875_data {
+	struct i2c_client	client;
+	struct semaphore	update_lock;
+	struct eeprom_block	blocks[max6857_max];
+	/* the above structs point into the arrays below */
+	u8 data[USER_EEPROM_SIZE + (CONFIG_EEPROM_SIZE*2)];
+	unsigned long last_updated[USER_EEPROM_SLICES + (CONFIG_EEPROM_SLICES*2)];
+};
+
+static int max6875_attach_adapter(struct i2c_adapter *adapter);
+static int max6875_detect(struct i2c_adapter *adapter, int address, int kind);
+static int max6875_detach_client(struct i2c_client *client);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver max6875_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "max6875",
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= max6875_attach_adapter,
+	.detach_client	= max6875_detach_client,
+};
+
+static int max6875_update_slice(struct i2c_client *client,
+				struct eeprom_block *blk,
+				int slice)
+{
+	struct max6875_data *data = i2c_get_clientdata(client);
+	int i, j, addr, count;
+	u8 rdbuf[SLICE_SIZE];
+	int retval = 0;
+
+	if (slice >= blk->slices)
+		return -1;
+
+	down(&data->update_lock);
+
+	if (!(blk->valid & (1 << slice)) ||
+	    (jiffies - blk->updated[slice] > 300 * HZ) ||
+	    (jiffies < blk->updated[slice])) {
+		dev_dbg(&client->dev, "Starting eeprom update, slice %u, base %u\n",
+			slice, blk->base);
+
+		addr = blk->base + (slice << SLICE_BITS);
+		count = blk->size - (slice << SLICE_BITS);
+		if (count > SLICE_SIZE) {
+			count = SLICE_SIZE;
+		}
+
+		/* Preset the read address */
+		if (addr < 0x100) {
+			/* select the register */
+			if (i2c_smbus_write_byte(client, addr & 0xFF)) {
+				dev_dbg(&client->dev, "max6875 register select has failed!\n");
+				retval = -1;
+				goto exit;
+			}
+		} else {
+			/* select the eeprom */
+			if (i2c_smbus_write_byte_data(client, addr >> 8, addr & 0xFF)) {
+				dev_dbg(&client->dev, "max6875 address set has failed!\n");
+				retval = -1;
+				goto exit;
+			}
+		}
+
+		if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+			if (i2c_smbus_read_i2c_block_data(client, MAX6875_CMD_BLOCK_READ,
+							  rdbuf) != SLICE_SIZE)
+			{
+				retval = -1;
+				goto exit;
+			}
+
+			memcpy(&blk->data[slice << SLICE_BITS], rdbuf, count);
+		} else {
+			for (i = 0; i < count; i++) {
+				j = i2c_smbus_read_byte(client);
+				if (j < 0)
+				{
+					retval = -1;
+					goto exit;
+				}
+				blk->data[(slice << SLICE_BITS) + i] = (u8) j;
+			}
+		}
+		blk->updated[slice] = jiffies;
+		blk->valid |= (1 << slice);
+	}
+	exit:
+	up(&data->update_lock);
+	return retval;
+}
+
+static ssize_t max6875_read(struct kobject *kobj, char *buf, loff_t off, size_t count,
+			    enum max6875_area_type area_type)
+{
+	struct i2c_client *client = to_i2c_client(container_of(kobj, struct device, kobj));
+	struct max6875_data *data = i2c_get_clientdata(client);
+	struct eeprom_block *blk;
+	int slice;
+
+	blk = &data->blocks[area_type];
+
+	if (off > blk->size)
+		return 0;
+	if (off + count > blk->size)
+		count = blk->size - off;
+
+	/* Only refresh slices which contain requested bytes */
+	for (slice = (off >> SLICE_BITS); slice <= ((off + count - 1) >> SLICE_BITS); slice++)
+		max6875_update_slice(client, blk, slice);
+
+	memcpy(buf, &blk->data[off], count);
+
+	return count;
+}
+
+static ssize_t max6875_user_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	return max6875_read(kobj, buf, off, count, max6875_eeprom_user);
+}
+
+static ssize_t max6875_config_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	return max6875_read(kobj, buf, off, count, max6875_eeprom_config);
+}
+
+static ssize_t max6875_cfgreg_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	return max6875_read(kobj, buf, off, count, max6875_register_config);
+}
+
+
+static ssize_t max6875_write(struct kobject *kobj, char *buf, loff_t off, size_t count,
+			     enum max6875_area_type area_type)
+{
+	struct i2c_client *client = to_i2c_client(container_of(kobj, struct device, kobj));
+	struct max6875_data *data = i2c_get_clientdata(client);
+	struct eeprom_block *blk;
+	int slice, addr, retval;
+	ssize_t sent = 0;
+
+	blk = &data->blocks[area_type];
+
+	if (off > blk->size)
+		return 0;
+	if ((off + count) > blk->size)
+		count = blk->size - off;
+
+	if (down_interruptible(&data->update_lock))
+		return -EAGAIN;
+
+	/* writing to a register is done with i2c_smbus_write_byte_data() */
+	if (blk->type == max6875_register_config) {
+		for (sent = 0; sent < count; sent++) {
+			addr = off + sent;
+			if (addr == 0x44)
+				continue;
+
+			retval = i2c_smbus_write_byte_data(client, addr, buf[sent]);
+		}
+	} else {
+		int cmd, val;
+
+		/* We are writing to EEPROM */
+		for (sent = 0; sent < count; sent++) {
+			addr = blk->base + off + sent;
+			cmd = addr >> 8;
+			val = (addr & 0xff) | (buf[sent] << 8);	// reversed
+
+			if (addr == 0x8044)
+				continue;
+
+			retval = i2c_smbus_write_word_data(client, cmd, val);
+
+			if (retval) {
+				goto error_exit;
+			}
+
+			/* A write takes up to 11 ms */
+			msleep(11);
+		}
+	}
+
+	/* Invalidate the scratch buffer */
+	for (slice = (off >> SLICE_BITS); slice <= ((off + count - 1) >> SLICE_BITS); slice++)
+		blk->valid &= ~(1 << slice);
+
+	error_exit:
+	up(&data->update_lock);
+
+	return sent;
+}
+
+static ssize_t max6875_user_write(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	return max6875_write(kobj, buf, off, count, max6875_eeprom_user);
+}
+
+static ssize_t max6875_config_write(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	return max6875_write(kobj, buf, off, count, max6875_eeprom_config);
+}
+
+static ssize_t max6875_cfgreg_write(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	return max6875_write(kobj, buf, off, count, max6875_register_config);
+}
+
+static struct bin_attribute user_eeprom_attr = {
+	.attr = {
+		.name = "eeprom_user",
+		.mode = S_IRUGO | S_IWUSR | S_IWGRP,
+		.owner = THIS_MODULE,
+	},
+	.size  = USER_EEPROM_SIZE,
+	.read  = max6875_user_read,
+	.write = max6875_user_write,
+};
+
+static struct bin_attribute config_eeprom_attr = {
+	.attr = {
+		.name = "eeprom_config",
+		.mode = S_IRUGO | S_IWUSR,
+		.owner = THIS_MODULE,
+	},
+	.size  = CONFIG_EEPROM_SIZE,
+	.read  = max6875_config_read,
+	.write = max6875_config_write,
+};
+
+static struct bin_attribute config_register_attr = {
+	.attr = {
+		.name = "reg_config",
+		.mode = S_IRUGO | S_IWUSR,
+		.owner = THIS_MODULE,
+	},
+	.size  = CONFIG_EEPROM_SIZE,
+	.read  = max6875_cfgreg_read,
+	.write = max6875_cfgreg_write,
+};
+
+static int max6875_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, max6875_detect);
+}
+
+/* This function is called by i2c_detect */
+static int max6875_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *new_client;
+	struct max6875_data *data;
+	int err = 0;
+
+	/* There are three ways we can read the EEPROM data:
+	   (1) I2C block reads (faster, but unsupported by most adapters)
+	   (2) Consecutive byte reads (100% overhead)
+	   (3) Regular byte data reads (200% overhead)
+	   The third method is not implemented by this driver because all
+	   known adapters support at least the second. */
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA |
+				     I2C_FUNC_SMBUS_BYTE |
+				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA))
+		goto exit;
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access eeprom_{read,write}_value. */
+	if (!(data = kmalloc(sizeof(struct max6875_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+	memset(data, 0, sizeof(struct max6875_data));
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &max6875_driver;
+	new_client->flags = 0;
+
+	/* Setup the user section */
+	data->blocks[max6875_eeprom_user].type    = max6875_eeprom_user;
+	data->blocks[max6875_eeprom_user].slices  = USER_EEPROM_SLICES;
+	data->blocks[max6875_eeprom_user].size    = USER_EEPROM_SIZE;
+	data->blocks[max6875_eeprom_user].base    = USER_EEPROM_BASE;
+	data->blocks[max6875_eeprom_user].data    = data->data;
+	data->blocks[max6875_eeprom_user].updated = data->last_updated;
+
+	/* Setup the config section */
+	data->blocks[max6875_eeprom_config].type    = max6875_eeprom_config;
+	data->blocks[max6875_eeprom_config].slices  = CONFIG_EEPROM_SLICES;
+	data->blocks[max6875_eeprom_config].size    = CONFIG_EEPROM_SIZE;
+	data->blocks[max6875_eeprom_config].base    = CONFIG_EEPROM_BASE;
+	data->blocks[max6875_eeprom_config].data    = &data->data[USER_EEPROM_SIZE];
+	data->blocks[max6875_eeprom_config].updated = &data->last_updated[USER_EEPROM_SLICES];
+
+	/* Setup the register section */
+	data->blocks[max6875_register_config].type    = max6875_register_config;
+	data->blocks[max6875_register_config].slices  = CONFIG_EEPROM_SLICES;
+	data->blocks[max6875_register_config].size    = CONFIG_EEPROM_SIZE;
+	data->blocks[max6875_register_config].base    = 0;
+	data->blocks[max6875_register_config].data    = &data->data[USER_EEPROM_SIZE+CONFIG_EEPROM_SIZE];
+	data->blocks[max6875_register_config].updated = &data->last_updated[USER_EEPROM_SLICES+CONFIG_EEPROM_SLICES];
+
+	/* Init the data */
+	memset(data->data, 0xff, sizeof(data->data));
+
+	/* Fill in the remaining client fields */
+	strlcpy(new_client->name, "max6875", I2C_NAME_SIZE);
+	init_MUTEX(&data->update_lock);
+
+	/* Verify that the chip is really what we think it is */
+	if ((max6875_update_slice(new_client, &data->blocks[max6875_eeprom_config], 4) < 0) ||
+	    (max6875_update_slice(new_client, &data->blocks[max6875_register_config], 4) < 0))
+		goto exit_kfree;
+
+	/* 0x41,0x42 must be zero and 0x40 must match in eeprom and registers */
+	if ((data->blocks[max6875_eeprom_config].data[0x41] != 0) ||
+	    (data->blocks[max6875_eeprom_config].data[0x42] != 0) ||
+	    (data->blocks[max6875_register_config].data[0x41] != 0) ||
+	    (data->blocks[max6875_register_config].data[0x42] != 0) ||
+	    (data->blocks[max6875_eeprom_config].data[0x40] !=
+	     data->blocks[max6875_register_config].data[0x40]))
+		goto exit_kfree;
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_kfree;
+
+	/* create the sysfs eeprom files with the correct permissions */
+	if (allow_write == 0) {
+		user_eeprom_attr.attr.mode &= ~S_IWUGO;
+		user_eeprom_attr.write = NULL;
+		config_eeprom_attr.attr.mode &= ~S_IWUGO;
+		config_eeprom_attr.write = NULL;
+		config_register_attr.attr.mode &= ~S_IWUGO;
+		config_register_attr.write = NULL;
+	}
+	sysfs_create_bin_file(&new_client->dev.kobj, &user_eeprom_attr);
+	sysfs_create_bin_file(&new_client->dev.kobj, &config_eeprom_attr);
+	sysfs_create_bin_file(&new_client->dev.kobj, &config_register_attr);
+
+	return 0;
+
+exit_kfree:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int max6875_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	err = i2c_detach_client(client);
+	if (err) {
+		dev_err(&client->dev, "Client deregistration failed, client not detached.\n");
+		return err;
+	}
+
+	kfree(i2c_get_clientdata(client));
+
+	return 0;
+}
+
+static int __init max6875_init(void)
+{
+	return i2c_add_driver(&max6875_driver);
+}
+
+static void __exit max6875_exit(void)
+{
+	i2c_del_driver(&max6875_driver);
+}
+
+
+MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
+MODULE_DESCRIPTION("MAX6875 driver");
+MODULE_LICENSE("GPL");
+
+module_init(max6875_init);
+module_exit(max6875_exit);

