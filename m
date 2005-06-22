Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262798AbVFVGcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbVFVGcX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVFVGby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:31:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:28316 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262798AbVFVFWF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:05 -0400
Cc: se.witt@gmx.net
Subject: [PATCH] I2C: add new atxp1 driver
In-Reply-To: <11194174621742@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:42 -0700
Message-Id: <1119417462508@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: add new atxp1 driver

Adds support for the Attansic ATXP1 I2C device, found on some x86
plattforms to change CPU and other voltages.  Depends on the previous
i2c-vid.h patch.

Signed-off-by: Sebastian Witt <se.witt@gmx.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 9cb7d18433ea6db04b3999e8d0b8f52fba551c2d
tree 0feff7401b43c5b3b2def0ae64db8f6c385a596b
parent 3886246a257e828248ce1e72ced00408a3557f0d
author Sebastian Witt <se.witt@gmx.net> Wed, 13 Apr 2005 22:27:53 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:50 -0700

 drivers/i2c/chips/Kconfig  |   13 ++
 drivers/i2c/chips/Makefile |    1 
 drivers/i2c/chips/atxp1.c  |  361 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 375 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -62,6 +62,19 @@ config SENSORS_ASB100
 	  This driver can also be built as a module.  If so, the module
 	  will be called asb100.
 
+config SENSORS_ATXP1
+	tristate "Attansic ATXP1 VID controller"
+	depends on I2C && EXPERIMENTAL
+	help
+	  If you say yes here you get support for the Attansic ATXP1 VID
+	  controller.
+
+	  If your board have such a chip, you are able to control your CPU
+	  core and other voltages.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called atxp1.
+
 config SENSORS_DS1621
 	tristate "Dallas Semiconductor DS1621 and DS1625"
 	depends on I2C && EXPERIMENTAL
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021
 obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
 obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
 obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
+obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_DS1337)	+= ds1337.o
 obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
diff --git a/drivers/i2c/chips/atxp1.c b/drivers/i2c/chips/atxp1.c
new file mode 100644
--- /dev/null
+++ b/drivers/i2c/chips/atxp1.c
@@ -0,0 +1,361 @@
+/*
+    atxp1.c - kernel module for setting CPU VID and general purpose
+                     I/Os using the Attansic ATXP1 chip.
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
+
+*/
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#include <linux/i2c-vid.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("System voltages control via Attansic ATXP1");
+MODULE_VERSION("0.6.2");
+MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
+
+#define ATXP1_VID	0x00
+#define ATXP1_CVID	0x01
+#define ATXP1_GPIO1	0x06
+#define ATXP1_GPIO2	0x0a
+#define ATXP1_VIDENA	0x20
+#define ATXP1_VIDMASK	0x1f
+#define ATXP1_GPIO1MASK	0x0f
+
+static unsigned short normal_i2c[] = { 0x37, 0x4e, I2C_CLIENT_END };
+static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
+
+SENSORS_INSMOD_1(atxp1);
+
+static int atxp1_attach_adapter(struct i2c_adapter * adapter);
+static int atxp1_detach_client(struct i2c_client * client);
+static struct atxp1_data * atxp1_update_device(struct device *dev);
+static int atxp1_detect(struct i2c_adapter *adapter, int address, int kind);
+
+static struct i2c_driver atxp1_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "atxp1",
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter = atxp1_attach_adapter,
+	.detach_client	= atxp1_detach_client,
+};
+
+struct atxp1_data {
+	struct i2c_client client;
+	struct semaphore update_lock;
+	unsigned long last_updated;
+	u8 valid;
+	struct {
+		u8 vid;		/* VID output register */
+		u8 cpu_vid; /* VID input from CPU */
+		u8 gpio1;   /* General purpose I/O register 1 */
+		u8 gpio2;   /* General purpose I/O register 2 */
+	} reg;
+	u8 vrm;			/* Detected CPU VRM */
+};
+
+static struct atxp1_data * atxp1_update_device(struct device *dev)
+{
+	struct i2c_client *client;
+	struct atxp1_data *data;
+
+	client = to_i2c_client(dev);
+	data = i2c_get_clientdata(client);
+
+	down(&data->update_lock);
+
+	if ((jiffies - data->last_updated > HZ) ||
+	    (jiffies < data->last_updated) ||
+	    !data->valid) {
+
+		/* Update local register data */
+		data->reg.vid = i2c_smbus_read_byte_data(client, ATXP1_VID);
+		data->reg.cpu_vid = i2c_smbus_read_byte_data(client, ATXP1_CVID);
+		data->reg.gpio1 = i2c_smbus_read_byte_data(client, ATXP1_GPIO1);
+		data->reg.gpio2 = i2c_smbus_read_byte_data(client, ATXP1_GPIO2);
+
+		data->valid = 1;
+	}
+
+	up(&data->update_lock);
+
+	return(data);
+}
+
+/* sys file functions for cpu0_vid */
+ssize_t atxp1_showvcore(struct device *dev, char *buf)
+{
+	int size;
+	struct atxp1_data *data;
+
+	data = atxp1_update_device(dev);
+
+	size = sprintf(buf, "%d\n", vid_from_reg(data->reg.vid & ATXP1_VIDMASK, data->vrm));
+
+	return size;
+}
+
+ssize_t atxp1_storevcore(struct device *dev, const char* buf, size_t count)
+{
+	struct atxp1_data *data;
+	struct i2c_client *client;
+	char vid;
+	char cvid;
+	unsigned int vcore;
+
+	client = to_i2c_client(dev);
+	data = atxp1_update_device(dev);
+
+	vcore = simple_strtoul(buf, NULL, 10);
+	vcore /= 25;
+	vcore *= 25;
+
+	/* Calculate VID */
+	vid = vid_to_reg(vcore, data->vrm);
+
+	if (vid < 0) {
+		dev_err(dev, "VID calculation failed.\n");
+		return -1;
+	}
+
+	/* If output enabled, use control register value. Otherwise original CPU VID */
+	if (data->reg.vid & ATXP1_VIDENA)
+		cvid = data->reg.vid & ATXP1_VIDMASK;
+	else
+		cvid = data->reg.cpu_vid;
+
+	/* Nothing changed, aborting */
+	if (vid == cvid)
+		return count;
+
+	dev_info(dev, "Setting VCore to %d mV (0x%02x)\n", vcore, vid);
+
+	/* Write every 25 mV step to increase stability */
+	if (cvid > vid) {
+		for (; cvid >= vid; cvid--) {
+        		i2c_smbus_write_byte_data(client, ATXP1_VID, cvid | ATXP1_VIDENA);
+		}
+	}
+	else {
+		for (; cvid <= vid; cvid++) {
+        		i2c_smbus_write_byte_data(client, ATXP1_VID, cvid | ATXP1_VIDENA);
+		}
+	}
+
+	data->valid = 0;
+
+	return count;
+}
+
+/* CPU core reference voltage
+    unit: millivolt
+*/
+static DEVICE_ATTR(cpu0_vid, S_IRUGO | S_IWUSR, atxp1_showvcore, atxp1_storevcore);
+
+/* sys file functions for GPIO1 */
+ssize_t atxp1_showgpio1(struct device *dev, char *buf)
+{
+	int size;
+	struct atxp1_data *data;
+
+	data = atxp1_update_device(dev);
+
+	size = sprintf(buf, "0x%02x\n", data->reg.gpio1 & ATXP1_GPIO1MASK);
+
+	return size;
+}
+
+ssize_t atxp1_storegpio1(struct device *dev, const char* buf, size_t count)
+{
+	struct atxp1_data *data;
+	struct i2c_client *client;
+	unsigned int value;
+
+	client = to_i2c_client(dev);
+	data = atxp1_update_device(dev);
+
+	value = simple_strtoul(buf, NULL, 16);
+
+	value &= ATXP1_GPIO1MASK;
+
+	if (value != (data->reg.gpio1 & ATXP1_GPIO1MASK)) {
+		dev_info(dev, "Writing 0x%x to GPIO1.\n", value);
+
+		i2c_smbus_write_byte_data(client, ATXP1_GPIO1, value);
+
+		data->valid = 0;
+	}
+
+	return count;
+}
+
+/* GPIO1 data register
+    unit: Four bit as hex (e.g. 0x0f)
+*/
+static DEVICE_ATTR(gpio1, S_IRUGO | S_IWUSR, atxp1_showgpio1, atxp1_storegpio1);
+
+/* sys file functions for GPIO2 */
+ssize_t atxp1_showgpio2(struct device *dev, char *buf)
+{
+	int size;
+	struct atxp1_data *data;
+
+	data = atxp1_update_device(dev);
+
+	size = sprintf(buf, "0x%02x\n", data->reg.gpio2);
+
+	return size;
+}
+
+ssize_t atxp1_storegpio2(struct device *dev, const char* buf, size_t count)
+{
+	struct atxp1_data *data;
+	struct i2c_client *client;
+	unsigned int value;
+
+	client = to_i2c_client(dev);
+	data = atxp1_update_device(dev);
+
+	value = simple_strtoul(buf, NULL, 16) & 0xff;
+
+	if (value != data->reg.gpio2) {
+		dev_info(dev, "Writing 0x%x to GPIO1.\n", value);
+
+		i2c_smbus_write_byte_data(client, ATXP1_GPIO2, value);
+
+		data->valid = 0;
+	}
+
+	return count;
+}
+
+/* GPIO2 data register
+    unit: Eight bit as hex (e.g. 0xff)
+*/
+static DEVICE_ATTR(gpio2, S_IRUGO | S_IWUSR, atxp1_showgpio2, atxp1_storegpio2);
+
+
+static int atxp1_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, &atxp1_detect);
+};
+
+static int atxp1_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client * new_client;
+	struct atxp1_data * data;
+	int err = 0;
+	u8 temp;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto exit;
+
+	if (!(data = kmalloc(sizeof(struct atxp1_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	memset(data, 0, sizeof(struct atxp1_data));
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+
+	new_client->addr = address;
+	new_client->adapter = adapter;
+	new_client->driver = &atxp1_driver;
+	new_client->flags = 0;
+
+	/* Detect ATXP1, checking if vendor ID registers are all zero */
+	if (!((i2c_smbus_read_byte_data(new_client, 0x3e) == 0) &&
+	     (i2c_smbus_read_byte_data(new_client, 0x3f) == 0) &&
+	     (i2c_smbus_read_byte_data(new_client, 0xfe) == 0) &&
+	     (i2c_smbus_read_byte_data(new_client, 0xff) == 0) )) {
+
+		/* No vendor ID, now checking if registers 0x10,0x11 (non-existent)
+		 * showing the same as register 0x00 */
+		temp = i2c_smbus_read_byte_data(new_client, 0x00);
+
+		if (!((i2c_smbus_read_byte_data(new_client, 0x10) == temp) &&
+			 (i2c_smbus_read_byte_data(new_client, 0x11) == temp) ))
+			goto exit_free;
+	}
+
+	/* Get VRM */
+	data->vrm = i2c_which_vrm();
+
+	if ((data->vrm != 90) && (data->vrm != 91)) {
+		dev_err(&new_client->dev, "Not supporting VRM %d.%d\n",
+				data->vrm / 10, data->vrm % 10);
+		goto exit_free;
+	}
+
+	strncpy(new_client->name, "atxp1", I2C_NAME_SIZE);
+
+	data->valid = 0;
+
+	init_MUTEX(&data->update_lock);
+
+	err = i2c_attach_client(new_client);
+
+	if (err)
+	{
+		dev_err(&new_client->dev, "Attach client error.\n");
+		goto exit_free;
+	}
+
+	device_create_file(&new_client->dev, &dev_attr_gpio1);
+	device_create_file(&new_client->dev, &dev_attr_gpio2);
+	device_create_file(&new_client->dev, &dev_attr_cpu0_vid);
+
+	dev_info(&new_client->dev, "Using VRM: %d.%d\n",
+			 data->vrm / 10, data->vrm % 10);
+
+	return 0;
+
+exit_free:
+	kfree(data);
+exit:
+	return err;
+};
+
+static int atxp1_detach_client(struct i2c_client * client)
+{
+	int err;
+
+	err = i2c_detach_client(client);
+
+	if (err)
+		dev_err(&client->dev, "Failed to detach client.\n");
+	else
+		kfree(i2c_get_clientdata(client));
+
+	return err;
+};
+
+static int __init atxp1_init(void)
+{
+	return i2c_add_driver(&atxp1_driver);
+};
+
+static void __exit atxp1_exit(void)
+{
+	i2c_del_driver(&atxp1_driver);
+};
+
+module_init(atxp1_init);
+module_exit(atxp1_exit);

