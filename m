Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVAHIrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVAHIrE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVAHIqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:46:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:59269 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261891AbVAHFsa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:30 -0500
Subject: Re: [PATCH] I2C patches for 2.6.10
In-Reply-To: <11051627741097@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:39:34 -0800
Message-Id: <1105162774723@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.439.53, 2005/01/07 11:14:41-08:00, mhoffman@lightlink.com

[PATCH] I2C: add new sensors driver: SMSC LPC47B397-NC

This patch (3rd time's a charm) adds support for the SMSC LPC47B397-NC
sensor chip.  It was sponsored by In-Store Broadcasting Network.

Signed-off-by: Craig Kelly (In-Store Broadcasting Network)
Signed-off-by: Glenn Ball (Utilitek Systems, Inc.)
Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>


 Documentation/i2c/chips/smsc47b397.txt |  146 +++++++++++++
 drivers/i2c/chips/Kconfig              |   12 +
 drivers/i2c/chips/Makefile             |    1 
 drivers/i2c/chips/smsc47b397.c         |  353 +++++++++++++++++++++++++++++++++
 include/linux/i2c-id.h                 |    1 
 5 files changed, 513 insertions(+)


diff -Nru a/Documentation/i2c/chips/smsc47b397.txt b/Documentation/i2c/chips/smsc47b397.txt
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/Documentation/i2c/chips/smsc47b397.txt	2005-01-07 14:53:44 -08:00
@@ -0,0 +1,146 @@
+November 23, 2004
+
+The following specification describes the SMSC LPC47B397-NC sensor chip
+(for which there is no public datasheet available).  This document was
+provided by Craig Kelly (In-Store Broadcast Network) and edited/corrected
+by Mark M. Hoffman <mhoffman@lightlink.com>.
+
+* * * * *
+
+Methods for detecting the HP SIO and reading the thermal data on a dc7100.
+
+The thermal information on the dc7100 is contained in the SIO Hardware Monitor
+(HWM).  The information is accessed through an index/data pair.  The index/data
+pair is located at the HWM Base Address + 0 and the HWM Base Address + 1.  The
+HWM Base address can be obtained from Logical Device 8, registers 0x60 (MSB)
+and 0x61 (LSB).  Currently we are using 0x480 for the HWM Base Address and
+0x480 and 0x481 for the index/data pair.
+
+Reading temperature information.
+The temperature information is located in the following registers:
+Temp1		0x25	(Currently, this reflects the CPU temp on all systems).
+Temp2		0x26
+Temp3		0x27
+Temp4		0x80
+
+Programming Example
+The following is an example of how to read the HWM temperature registers:
+MOV	DX,480H
+MOV	AX,25H
+OUT	DX,AL
+MOV	DX,481H
+IN	AL,DX
+
+AL contains the data in hex, the temperature in Celsius is the decimal
+equivalent.
+
+Ex: If AL contains 0x2A, the temperature is 42 degrees C.
+
+Reading tach information.
+The fan speed information is located in the following registers:
+		LSB	MSB
+Tach1		0x28	0x29	(Currently, this reflects the CPU
+				fan speed on all systems).
+Tach2		0x2A	0x2B
+Tach3		0x2C	0x2D
+Tach4		0x2E	0x2F
+
+Important!!!
+Reading the tach LSB locks the tach MSB.
+The LSB Must be read first.
+
+How to convert the tach reading to RPM.
+The tach reading (TCount) is given by:  (Tach MSB * 256) + (Tach LSB)
+The SIO counts the number of 90kHz (11.111us) pulses per revolution.
+RPM = 60/(TCount * 11.111us)
+
+Example:
+Reg 0x28 = 0x9B
+Reg 0x29 = 0x08
+
+TCount = 0x89B = 2203
+
+RPM = 60 / (2203 * 11.11111 E-6) = 2451 RPM
+
+Obtaining the SIO version.
+
+CONFIGURATION SEQUENCE
+To program the configuration registers, the following sequence must be followed:
+1. Enter Configuration Mode
+2. Configure the Configuration Registers
+3. Exit Configuration Mode.
+
+Enter Configuration Mode
+To place the chip into the Configuration State The config key (0x55) is written
+to the CONFIG PORT (0x2E). 
+
+Configuration Mode
+In configuration mode, the INDEX PORT is located at the CONFIG PORT address and
+the DATA PORT is at INDEX PORT address + 1.
+
+The desired configuration registers are accessed in two steps: 
+a.	Write the index of the Logical Device Number Configuration Register
+	(i.e., 0x07) to the INDEX PORT and then write the number of the
+	desired logical device to the DATA PORT.
+
+b.	Write the address of the desired configuration register within the
+	logical device to the INDEX PORT and then write or read the config-
+	uration register through the DATA PORT.  
+
+Note: If accessing the Global Configuration Registers, step (a) is not required.
+
+Exit Configuration Mode
+To exit the Configuration State the write 0xAA to the CONFIG PORT (0x2E).
+The chip returns to the RUN State.  (This is important).
+
+Programming Example
+The following is an example of how to read the SIO Device ID located at 0x20
+
+; ENTER CONFIGURATION MODE   
+MOV	DX,02EH
+MOV	AX,055H
+OUT	DX,AL
+; GLOBAL CONFIGURATION  REGISTER 
+MOV	DX,02EH
+MOV	AL,20H
+OUT	DX,AL 
+; READ THE DATA
+MOV	DX,02FH
+IN	AL,DX
+; EXIT CONFIGURATION MODE     
+MOV	DX,02EH
+MOV	AX,0AAH
+OUT	DX,AL
+
+The registers of interest for identifying the SIO on the dc7100 are Device ID
+(0x20) and Device Rev  (0x21).
+
+The Device ID will read 0X6F
+The Device Rev currently reads 0x01
+
+Obtaining the HWM Base Address.
+The following is an example of how to read the HWM Base Address located in
+Logical Device 8.
+
+; ENTER CONFIGURATION MODE   
+MOV	DX,02EH
+MOV	AX,055H
+OUT	DX,AL
+; CONFIGURE REGISTER CRE0,   
+; LOGICAL DEVICE 8           
+MOV	DX,02EH
+MOV	AL,07H
+OUT	DX,AL ;Point to LD# Config Reg
+MOV	DX,02FH
+MOV	AL, 08H
+OUT	DX,AL;Point to Logical Device 8
+;
+MOV	DX,02EH 
+MOV	AL,60H
+OUT	DX,AL	; Point to HWM Base Addr MSB
+MOV	DX,02FH
+IN	AL,DX	; Get MSB of HWM Base Addr
+; EXIT CONFIGURATION MODE     
+MOV	DX,02EH
+MOV	AX,0AAH
+OUT	DX,AL
diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	2005-01-07 14:53:44 -08:00
+++ b/drivers/i2c/chips/Kconfig	2005-01-07 14:53:44 -08:00
@@ -239,6 +239,18 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called pc87360.
 
+config SENSORS_SMSC47B397
+	tristate "SMSC LPC47B397-NC"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	select I2C_ISA
+	help
+	  If you say yes here you get support for the SMSC LPC47B397-NC
+	  sensor chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called smsc47b397.
+
 config SENSORS_SMSC47M1
 	tristate "SMSC LPC47M10x and compatibles"
 	depends on I2C && EXPERIMENTAL
diff -Nru a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile	2005-01-07 14:53:44 -08:00
+++ b/drivers/i2c/chips/Makefile	2005-01-07 14:53:44 -08:00
@@ -30,6 +30,7 @@
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_RTC8564)	+= rtc8564.o
+obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
diff -Nru a/drivers/i2c/chips/smsc47b397.c b/drivers/i2c/chips/smsc47b397.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/i2c/chips/smsc47b397.c	2005-01-07 14:53:44 -08:00
@@ -0,0 +1,353 @@
+/*
+    smsc47b397.c - Part of lm_sensors, Linux kernel modules
+			for hardware monitoring
+
+    Supports the SMSC LPC47B397-NC Super-I/O chip.
+
+    Author/Maintainer: Mark M. Hoffman <mhoffman@lightlink.com>
+	Copyright (C) 2004 Utilitek Systems, Inc.
+
+    derived in part from smsc47m1.c:
+	Copyright (C) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
+	Copyright (C) 2004 Jean Delvare <khali@linux-fr.org>
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
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#include <linux/init.h>
+#include <asm/io.h>
+
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+/* Address is autodetected, there is no default value */
+static unsigned int normal_isa[] = { 0x0000, I2C_CLIENT_ISA_END };
+static struct i2c_force_data forces[] = {{NULL}};
+
+enum chips { any_chip, smsc47b397 };
+static struct i2c_address_data addr_data = {
+	.normal_i2c		= normal_i2c,
+	.normal_isa		= normal_isa,
+	.probe			= normal_i2c,		/* cheat */
+	.ignore			= normal_i2c,		/* cheat */
+	.forces			= forces,
+};
+
+/* Super-I/0 registers and commands */
+
+#define	REG	0x2e	/* The register to read/write */
+#define	VAL	0x2f	/* The value to read/write */
+
+static inline void superio_outb(int reg, int val)
+{
+	outb(reg, REG);
+	outb(val, VAL);
+}
+
+static inline int superio_inb(int reg)
+{
+	outb(reg, REG);
+	return inb(VAL);
+}
+
+/* select superio logical device */
+static inline void superio_select(int ld)
+{
+	superio_outb(0x07, ld);
+}
+
+static inline void superio_enter(void)
+{
+	outb(0x55, REG);
+}
+
+static inline void superio_exit(void)
+{
+	outb(0xAA, REG);
+}
+
+#define SUPERIO_REG_DEVID	0x20
+#define SUPERIO_REG_DEVREV	0x21
+#define SUPERIO_REG_BASE_MSB	0x60
+#define SUPERIO_REG_BASE_LSB	0x61
+#define SUPERIO_REG_LD8		0x08
+
+#define SMSC_EXTENT		0x02
+
+/* 0 <= nr <= 3 */
+static u8 smsc47b397_reg_temp[] = {0x25, 0x26, 0x27, 0x80};
+#define SMSC47B397_REG_TEMP(nr)	(smsc47b397_reg_temp[(nr)])
+
+/* 0 <= nr <= 3 */
+#define SMSC47B397_REG_FAN_LSB(nr) (0x28 + 2 * (nr))
+#define SMSC47B397_REG_FAN_MSB(nr) (0x29 + 2 * (nr))
+
+struct smsc47b397_data {
+	struct i2c_client client;
+	struct semaphore lock;
+
+	struct semaphore update_lock;
+	unsigned long last_updated; /* in jiffies */
+	int valid;
+
+	/* register values */
+	u16 fan[4];
+	u8 temp[4];
+};
+
+static int smsc47b397_read_value(struct i2c_client *client, u8 reg)
+{
+	struct smsc47b397_data *data = i2c_get_clientdata(client);
+	int res;
+
+	down(&data->lock);
+	outb(reg, client->addr);
+	res = inb_p(client->addr + 1);
+	up(&data->lock);
+	return res;
+}
+
+static struct smsc47b397_data *smsc47b397_update_device(struct device *dev)
+{
+ 	struct i2c_client *client = to_i2c_client(dev);
+	struct smsc47b397_data *data = i2c_get_clientdata(client);
+	int i;
+
+	down(&data->update_lock);
+
+	if (time_after(jiffies - data->last_updated, (unsigned long)HZ)
+		|| time_before(jiffies, data->last_updated) || !data->valid) {
+
+		dev_dbg(&client->dev, "starting device update...\n");
+
+		/* 4 temperature inputs, 4 fan inputs */
+		for (i = 0; i < 4; i++) {
+			data->temp[i] = smsc47b397_read_value(client,
+					SMSC47B397_REG_TEMP(i));
+
+			/* must read LSB first */
+			data->fan[i]  = smsc47b397_read_value(client,
+					SMSC47B397_REG_FAN_LSB(i));
+			data->fan[i] |= smsc47b397_read_value(client,
+					SMSC47B397_REG_FAN_MSB(i)) << 8;
+		}
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+
+		dev_dbg(&client->dev, "... device update complete\n");
+	}
+
+	up(&data->update_lock);
+
+	return data;
+}
+
+/* TEMP: 0.001C/bit (-128C to +127C)
+   REG: 1C/bit, two's complement */
+static int temp_from_reg(u8 reg)
+{
+	return (s8)reg * 1000;
+}
+
+/* 0 <= nr <= 3 */
+static ssize_t show_temp(struct device *dev, char *buf, int nr)
+{
+	struct smsc47b397_data *data = smsc47b397_update_device(dev);
+	return sprintf(buf, "%d\n", temp_from_reg(data->temp[nr]));
+}
+
+#define sysfs_temp(num) \
+static ssize_t show_temp##num(struct device *dev, char *buf) \
+{ \
+	return show_temp(dev, buf, num-1); \
+} \
+static DEVICE_ATTR(temp##num##_input, S_IRUGO, show_temp##num, NULL)
+
+sysfs_temp(1);
+sysfs_temp(2);
+sysfs_temp(3);
+sysfs_temp(4);
+
+#define device_create_file_temp(client, num) \
+	device_create_file(&client->dev, &dev_attr_temp##num##_input)
+
+/* FAN: 1 RPM/bit
+   REG: count of 90kHz pulses / revolution */
+static int fan_from_reg(u16 reg)
+{
+	return 90000 * 60 / reg;
+}
+
+/* 0 <= nr <= 3 */
+static ssize_t show_fan(struct device *dev, char *buf, int nr)
+{
+        struct smsc47b397_data *data = smsc47b397_update_device(dev);
+        return sprintf(buf, "%d\n", fan_from_reg(data->fan[nr]));
+}
+
+#define sysfs_fan(num) \
+static ssize_t show_fan##num(struct device *dev, char *buf) \
+{ \
+	return show_fan(dev, buf, num-1); \
+} \
+static DEVICE_ATTR(fan##num##_input, S_IRUGO, show_fan##num, NULL)
+
+sysfs_fan(1);
+sysfs_fan(2);
+sysfs_fan(3);
+sysfs_fan(4);
+
+#define device_create_file_fan(client, num) \
+	device_create_file(&client->dev, &dev_attr_fan##num##_input)
+
+static int smsc47b397_detect(struct i2c_adapter *adapter, int addr, int kind);
+
+static int smsc47b397_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
+	return i2c_detect(adapter, &addr_data, smsc47b397_detect);
+}
+
+static int smsc47b397_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev, "Client deregistration failed, "
+			"client not detached.\n");
+		return err;
+	}
+
+	release_region(client->addr, SMSC_EXTENT);
+	kfree(i2c_get_clientdata(client));
+
+	return 0;
+}
+
+static struct i2c_driver smsc47b397_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "smsc47b397",
+	.id		= I2C_DRIVERID_SMSC47B397,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= smsc47b397_attach_adapter,
+	.detach_client	= smsc47b397_detach_client,
+};
+
+static int smsc47b397_detect(struct i2c_adapter *adapter, int addr, int kind)
+{
+	struct i2c_client *new_client;
+	struct smsc47b397_data *data;
+	int err = 0;
+
+	if (!i2c_is_isa_adapter(adapter)) {
+		return 0;
+	}
+
+	if (!request_region(addr, SMSC_EXTENT, smsc47b397_driver.name)) {
+		dev_err(&adapter->dev, "Region 0x%x already in use!\n", addr);
+		return -EBUSY;
+	}
+
+	if (!(data = kmalloc(sizeof(struct smsc47b397_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto error_release;
+	}
+	memset(data, 0x00, sizeof(struct smsc47b397_data));
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = addr;
+	init_MUTEX(&data->lock);
+	new_client->adapter = adapter;
+	new_client->driver = &smsc47b397_driver;
+	new_client->flags = 0;
+
+	strlcpy(new_client->name, "smsc47b397", I2C_NAME_SIZE);
+
+	init_MUTEX(&data->update_lock);
+
+	if ((err = i2c_attach_client(new_client)))
+		goto error_free;
+
+	device_create_file_temp(new_client, 1);
+	device_create_file_temp(new_client, 2);
+	device_create_file_temp(new_client, 3);
+	device_create_file_temp(new_client, 4);
+
+	device_create_file_fan(new_client, 1);
+	device_create_file_fan(new_client, 2);
+	device_create_file_fan(new_client, 3);
+	device_create_file_fan(new_client, 4);
+
+	return 0;
+
+error_free:
+	kfree(new_client);
+error_release:
+	release_region(addr, SMSC_EXTENT);
+	return err;
+}
+
+static int __init smsc47b397_find(unsigned int *addr)
+{
+	u8 id, rev;
+
+	superio_enter();
+	id = superio_inb(SUPERIO_REG_DEVID);
+
+	if (id != 0x6f) {
+		superio_exit();
+		return -ENODEV;
+	}
+
+	rev = superio_inb(SUPERIO_REG_DEVREV);
+
+	superio_select(SUPERIO_REG_LD8);
+	*addr = (superio_inb(SUPERIO_REG_BASE_MSB) << 8)
+		 |  superio_inb(SUPERIO_REG_BASE_LSB);
+
+	printk(KERN_INFO "smsc47b397: found SMSC LPC47B397-NC "
+		"(base address 0x%04x, revision %u)\n", *addr, rev);
+
+	superio_exit();
+	return 0;
+}
+
+static int __init smsc47b397_init(void)
+{
+	int ret;
+
+	if ((ret = smsc47b397_find(normal_isa)))
+		return ret;
+
+	return i2c_add_driver(&smsc47b397_driver);
+}
+
+static void __exit smsc47b397_exit(void)
+{
+	i2c_del_driver(&smsc47b397_driver);
+}
+
+MODULE_AUTHOR("Mark M. Hoffman <mhoffman@lightlink.com>");
+MODULE_DESCRIPTION("SMSC LPC47B397 driver");
+MODULE_LICENSE("GPL");
+
+module_init(smsc47b397_init);
+module_exit(smsc47b397_exit);
diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
--- a/include/linux/i2c-id.h	2005-01-07 14:53:44 -08:00
+++ b/include/linux/i2c-id.h	2005-01-07 14:53:44 -08:00
@@ -167,6 +167,7 @@
 #define I2C_DRIVERID_ASB100 1043
 #define I2C_DRIVERID_FSCHER 1046
 #define I2C_DRIVERID_W83L785TS 1047
+#define I2C_DRIVERID_SMSC47B397 1050
 
 /*
  * ---- Adapter types ----------------------------------------------------

