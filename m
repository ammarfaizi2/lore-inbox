Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVBZSMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVBZSMj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 13:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVBZSMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 13:12:39 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:41994 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261250AbVBZSLX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 13:11:23 -0500
Date: Sat, 26 Feb 2005 19:11:42 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Cc: David Hoffman <dhoffman_98@yahoo.com>
Subject: [RFT] Preliminary w83627ehf hardware monitoring driver
Message-Id: <20050226191142.6288b2ef.khali@linux-fr.org>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__26_Feb_2005_19_11_42_+0100_4TlJn3SB=vcmbkM0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sat__26_Feb_2005_19_11_42_+0100_4TlJn3SB=vcmbkM0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

I have been working on a w83627ehf hardware monitoring driver. The
W83627EHF is a Super-I/O chip made by Winbond. Like other chips of the
family (W83627HF, W83697HF, W83627THF...), it integrates hardware
monitoring functions. Of these, my preliminary driver only handles
temperature and fan inputs at the moment. I lack time and do not have
hardware to test it, so I will not improve it significantly in a near
future.

So that my work isn't lost, I am releasing it today in the form of a
patch against linux-2.6.11-rc5 (attached). You can also obtain it here
for now:
http://jdelvare.net1.nerim.net/sensors/linux-2.6.11-rc5-i2c-w83627ehf-beta1.diff

If it could get some testing, I would possibly get this is the main
kernel tree, so that at least what is implemented can be used, and
anyone interested in improving it would have a base to start from.

The W83627EHF doesn't seem to be found on many motherboards, but a quick
searched listed these ones:
* Asus P5AD2 Premium
* Asus P5GD1-VM
* Asus P5GD2 Premium
* Asus P5GDC-V Deluxe
* Asus P5P800
So if you have any of these motherboards (or any other with a W83627EHF
chip, for that matter), I would welcome any feedback about my driver.

Thanks,
-- 
Jean Delvare

--Multipart=_Sat__26_Feb_2005_19_11_42_+0100_4TlJn3SB=vcmbkM0
Content-Type: text/plain;
 name="linux-2.6.11-rc5-i2c-w83627ehf-beta1.diff"
Content-Disposition: attachment;
 filename="linux-2.6.11-rc5-i2c-w83627ehf-beta1.diff"
Content-Transfer-Encoding: 7bit

diff -ruN linux-2.6.11-rc5/drivers/i2c/chips.orig/Kconfig linux-2.6.11-rc5/drivers/i2c/chips/Kconfig
--- linux-2.6.11-rc5/drivers/i2c/chips.orig/Kconfig	2005-02-25 07:59:12.000000000 +0100
+++ linux-2.6.11-rc5/drivers/i2c/chips/Kconfig	2005-02-26 15:07:39.000000000 +0100
@@ -311,6 +311,20 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83627hf.
 
+config SENSORS_W83627EHF
+	tristate "Winbond W83627EHF"
+	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	select I2C_ISA
+	help
+	  If you say yes here you get preliminary support for the hardware
+	  monitoring functionality of the Winbond W83627EHF Super-I/O chip.
+	  Only fan and temperature inputs are supported at the moment, while
+	  the chip does much more than that.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called w83627ehf.
+
 endmenu
 
 menu "Other I2C Chip support"
diff -ruN linux-2.6.11-rc5/drivers/i2c/chips.orig/Makefile linux-2.6.11-rc5/drivers/i2c/chips/Makefile
--- linux-2.6.11-rc5/drivers/i2c/chips.orig/Makefile	2005-02-25 07:59:12.000000000 +0100
+++ linux-2.6.11-rc5/drivers/i2c/chips/Makefile	2005-02-26 15:04:11.000000000 +0100
@@ -33,6 +33,7 @@
 obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
+obj-$(CONFIG_SENSORS_W83627EHF)	+= w83627ehf.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 
diff -ruN linux-2.6.11-rc5/drivers/i2c/chips.orig/w83627ehf.c linux-2.6.11-rc5/drivers/i2c/chips/w83627ehf.c
--- linux-2.6.11-rc5/drivers/i2c/chips.orig/w83627ehf.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc5/drivers/i2c/chips/w83627ehf.c	2005-02-26 17:50:50.000000000 +0100
@@ -0,0 +1,793 @@
+/*
+    w83627ehf - Driver for the hardware monitoring functionality of
+                the Winbond W83627EHF Super-I/O chip
+    Copyright (C) 2005  Jean Delvare <khali@linux-fr.org>
+
+    Shamelessly ripped from the w83627hf driver
+    Copyright (C) 2003  Mark Studebaker
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
+
+    Supports the following chips:
+
+    Chip        #vin    #fan    #pwm    #temp   chip_id man_id
+    w83627ehf   -       5       -       3       0x88    0x5ca3
+
+    This is a preliminary version of the driver, only supporting the
+    fan and temperature inputs. The chip does much more than that.
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#include <asm/io.h>
+#include "lm75.h"
+
+/* Addresses to scan
+   The actual ISA address is read from Super-I/O configuration space */
+static unsigned short normal_i2c[] = { I2C_CLIENT_END };
+static unsigned int normal_isa[] = { 0, I2C_CLIENT_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_1(w83627ehf);
+
+/*
+ * Super-I/O constants and functions
+ */
+
+static int REG;		/* The register to read/write */
+static int VAL;		/* The value to read/write */
+
+#define W83627EHF_LD_HWM	0x0b
+
+#define SIO_REG_LDSEL		0x07	/* Logical device select */
+#define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
+#define SIO_REG_ENABLE		0x30	/* Logical device enable */
+#define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */
+
+#define SIO_W83627EHF_ID	0x8840
+#define SIO_ID_MASK		0xFFC0
+
+static inline void
+superio_outb(int reg, int val)
+{
+	outb(reg, REG);
+	outb(val, VAL);
+}
+
+static inline int
+superio_inb(int reg)
+{
+	outb(reg, REG);
+	return inb(VAL);
+}
+
+static inline void
+superio_select(int ld)
+{
+	outb(SIO_REG_LDSEL, REG);
+	outb(ld, VAL);
+}
+
+static inline void
+superio_enter(void)
+{
+	outb(0x87, REG);
+	outb(0x87, REG);
+}
+
+static inline void
+superio_exit(void)
+{
+	outb(0x02, REG);
+	outb(0x02, VAL);
+}
+
+/*
+ * ISA constants
+ */
+
+#define REGION_LENGTH		8
+#define ADDR_REG_OFFSET		5
+#define DATA_REG_OFFSET		6
+
+#define W83627EHF_REG_BANK		0x4E
+#define W83627EHF_REG_CONFIG		0x40
+#define W83627EHF_REG_CHIP_ID		0x49
+#define W83627EHF_REG_MAN_ID		0x4F
+
+static const u16 W83627EHF_REG_FAN[] = { 0x28, 0x29, 0x2a, 0x3f, 0x553 };
+static const u16 W83627EHF_REG_FAN_MIN[] = { 0x3b, 0x3c, 0x3d, 0x3e, 0x55c };
+
+#define W83627EHF_REG_TEMP1		0x27
+#define W83627EHF_REG_TEMP1_HYST	0x3a
+#define W83627EHF_REG_TEMP1_OVER	0x39
+static const u16 W83627EHF_REG_TEMP[] = { 0x150, 0x250 };
+static const u16 W83627EHF_REG_TEMP_HYST[] = { 0x153, 0x253 };
+static const u16 W83627EHF_REG_TEMP_OVER[] = { 0x155, 0x255 };
+static const u16 W83627EHF_REG_TEMP_CONFIG[] = { 0x152, 0x252 };
+
+/* Fan clock dividers are spread over the following five registers */
+#define W83627EHF_REG_FANDIV1		0x47
+#define W83627EHF_REG_FANDIV2		0x4B
+#define W83627EHF_REG_VBAT		0x5D
+#define W83627EHF_REG_DIODE		0x59
+#define W83627EHF_REG_SMI_OVT		0x4C
+
+/*
+ * Conversions
+ */
+
+static inline unsigned int
+fan_from_reg(u8 reg, unsigned int div)
+{
+	if (reg == 0 || reg == 255)
+		return 0;
+	return 1350000U / (reg * div);
+}
+
+static inline u8
+fan_to_reg(unsigned int rpm, unsigned int div)
+{
+	if (rpm == 0)
+		return 255U;
+	return 1350000U / (rpm * div);
+}
+
+static inline unsigned int
+div_from_reg(u8 reg)
+{
+	return 1 << reg;
+}
+
+static inline int
+temp1_from_reg(s8 reg)
+{
+	return reg * 1000;
+}
+
+static inline s8
+temp1_to_reg(int temp)
+{
+	if (temp <= -128000)
+		return -128;
+	if (temp >= 127000)
+		return 127;
+	if (temp < 0)
+		return (temp - 500) / 1000;
+	return (temp + 500) / 1000;
+}
+
+/*
+ * Data structures and manipulation thereof
+ */
+
+struct w83627ehf_data {
+	struct i2c_client client;
+	struct semaphore lock;
+
+	struct semaphore update_lock;
+	char valid;		/* !=0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+
+	/* Register values */
+	u8 fan[5];
+	u8 fan_min[5];
+	u8 fan_div[5];
+	s8 temp1;
+	s8 temp1_max;
+	s8 temp1_max_hyst;
+	s16 temp[2];
+	s16 temp_max[2];
+	s16 temp_max_hyst[2];
+};
+
+static inline int is_word_sized(u16 reg)
+{
+	return (((reg & 0xff00) == 0x100
+	      || (reg & 0xff00) == 0x200)
+	     && ((reg & 0x00ff) == 0x50
+	      || (reg & 0x00ff) == 0x53
+	      || (reg & 0x00ff) == 0x55));
+}
+
+static void w83627ehf_set_bank(struct i2c_client *client, u16 reg)
+{
+	if (reg & 0xff00) {
+		outb_p(W83627EHF_REG_BANK, client->addr + ADDR_REG_OFFSET);
+		outb_p(reg >> 8, client->addr + DATA_REG_OFFSET);
+	}
+}
+
+static void w83627ehf_reset_bank(struct i2c_client *client, u16 reg)
+{
+	w83627ehf_set_bank(client, reg & 0xff00);
+}
+
+static u16 w83627ehf_read_value(struct i2c_client *client, u16 reg)
+{
+	struct w83627ehf_data *data = i2c_get_clientdata(client);
+	int res, word_sized = is_word_sized(reg);
+
+	down(&data->lock);
+
+	w83627ehf_set_bank(client, reg);
+	outb_p(reg & 0xff, client->addr + ADDR_REG_OFFSET);
+	res = inb_p(client->addr + DATA_REG_OFFSET);
+	if (word_sized) {
+		outb_p((reg & 0xff) + 1,
+		       client->addr + ADDR_REG_OFFSET);
+		res = (res << 8) + inb_p(client->addr + DATA_REG_OFFSET);
+	}
+	w83627ehf_reset_bank(client, reg);
+
+	up(&data->lock);
+
+	return res;
+}
+
+static int w83627ehf_write_value(struct i2c_client *client, u16 reg, u16 value)
+{
+	struct w83627ehf_data *data = i2c_get_clientdata(client);
+	int word_sized = is_word_sized(reg);
+
+	down(&data->lock);
+
+	w83627ehf_set_bank(client, reg);
+	outb_p(reg & 0xff, client->addr + ADDR_REG_OFFSET);
+	if (word_sized) {
+		outb_p(value >> 8, client->addr + DATA_REG_OFFSET);
+		outb_p((reg & 0xff) + 1,
+		       client->addr + ADDR_REG_OFFSET);
+	}
+	outb_p(value & 0xff, client->addr + DATA_REG_OFFSET);
+	w83627ehf_reset_bank(client, reg);
+
+	up(&data->lock);
+	return 0;
+}
+
+static struct w83627ehf_data *w83627ehf_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83627ehf_data *data = i2c_get_clientdata(client);
+	int i;
+
+	down(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ)
+	 || !data->valid) {
+		/* Measured fan speeds and limits */
+		for (i = 0; i < 5; i++) {
+			data->fan[i] = w83627ehf_read_value(client,
+				       W83627EHF_REG_FAN[i]);
+			data->fan_min[i] = w83627ehf_read_value(client,
+					   W83627EHF_REG_FAN_MIN[i]);
+		}
+
+		/* Measured temperatures and limits */
+		data->temp1 = w83627ehf_read_value(client,
+			      W83627EHF_REG_TEMP1);
+		data->temp1_max = w83627ehf_read_value(client,
+				  W83627EHF_REG_TEMP1_OVER);
+		data->temp1_max_hyst = w83627ehf_read_value(client,
+				       W83627EHF_REG_TEMP1_HYST);
+		for (i = 0; i < 2; i++) {
+			data->temp[i] = w83627ehf_read_value(client,
+					W83627EHF_REG_TEMP[i]);
+			data->temp_max[i] = w83627ehf_read_value(client,
+					    W83627EHF_REG_TEMP_OVER[i]);
+			data->temp_max_hyst[i] = w83627ehf_read_value(client,
+						 W83627EHF_REG_TEMP_HYST[i]);
+		}
+
+		/* Fan clock dividers */
+		i = w83627ehf_read_value(client, W83627EHF_REG_FANDIV1);
+		data->fan_div[0] = (i >> 4) & 0x03;
+		data->fan_div[1] = (i >> 6) & 0x03;
+		i = w83627ehf_read_value(client, W83627EHF_REG_FANDIV2);
+		data->fan_div[2] = (i >> 6) & 0x03;
+		i = w83627ehf_read_value(client, W83627EHF_REG_VBAT);
+		data->fan_div[0] |= (i >> 3) & 0x04;
+		data->fan_div[1] |= (i >> 4) & 0x04;
+		data->fan_div[2] |= (i >> 5) & 0x04;
+		i = w83627ehf_read_value(client, W83627EHF_REG_DIODE);
+		data->fan_div[3] = i & 0x03;
+		data->fan_div[4] = ((i >> 2) & 0x03)
+				 | ((i >> 5) & 0x04);
+		i = w83627ehf_read_value(client, W83627EHF_REG_SMI_OVT);
+		data->fan_div[3] |= (i >> 5) & 0x04;
+
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	up(&data->update_lock);
+	return data;
+}
+
+/*
+ * Sysfs callback functions
+ */
+
+#define show_fan_reg(reg) \
+static ssize_t \
+show_##reg(struct device *dev, char *buf, int nr) \
+{ \
+	struct w83627ehf_data *data = w83627ehf_update_device(dev); \
+	return sprintf(buf, "%d\n", \
+		       fan_from_reg(data->reg[nr], \
+				    div_from_reg(data->fan_div[nr]))); \
+}
+show_fan_reg(fan);
+show_fan_reg(fan_min);
+
+static ssize_t
+show_fan_div(struct device *dev, char *buf, int nr)
+{
+	struct w83627ehf_data *data = w83627ehf_update_device(dev);
+	return sprintf(buf, "%u\n",
+		       div_from_reg(data->fan_div[nr]));
+}
+
+static ssize_t
+store_fan_min(struct device *dev, const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83627ehf_data *data = i2c_get_clientdata(client);
+	unsigned int val = simple_strtoul(buf, NULL, 10);
+
+	data->fan_min[nr] = fan_to_reg(val,
+			    div_from_reg(data->fan_div[nr]));
+	w83627ehf_write_value(client, W83627EHF_REG_FAN_MIN[nr],
+			      data->fan_min[nr]);
+
+	return count;
+}
+
+/* Note: we save and restore the fan minimum here, because its value is
+   determined in part by the fan divisor.  This follows the principle of
+   least suprise; the user doesn't expect the fan minimum to change just
+   because the divisor changed. */
+static ssize_t
+store_fan_div(struct device *dev, const char *buf, size_t count, int nr)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct w83627ehf_data *data = i2c_get_clientdata(client);
+	unsigned int min, val;
+	u8 reg;
+
+	val = simple_strtoul(buf, NULL, 10);
+
+	/* Save fan_min */
+	min = fan_from_reg(data->fan_min[nr],
+			   div_from_reg(data->fan_div[nr]));
+
+	switch (val) {
+	case 1: data->fan_div[nr] = 0; break;
+	case 2: data->fan_div[nr] = 1; break;
+	case 4: data->fan_div[nr] = 2; break;
+	case 8: data->fan_div[nr] = 3; break;
+	case 16: data->fan_div[nr] = 4; break;
+	case 32: data->fan_div[nr] = 5; break;
+	case 64: data->fan_div[nr] = 6; break;
+	case 128: data->fan_div[nr] = 7; break;
+	default:
+		dev_err(&client->dev, "Fan clock divider value %u not "
+			"supported", val);
+		dev_err(&client->dev, "Choose one of 1, 2, 4, 8, 16, 32, "
+			"64 or 128");
+		return -EINVAL;
+	}
+
+	switch (nr) {
+	case 0:
+		reg = (w83627ehf_read_value(client, W83627EHF_REG_FANDIV1) & 0xcf)
+		    | ((data->fan_div[0] & 0x03) << 4);
+		w83627ehf_write_value(client, W83627EHF_REG_FANDIV1, reg);
+		reg = (w83627ehf_read_value(client, W83627EHF_REG_VBAT) & 0xdf)
+		    | ((data->fan_div[0] & 0x04) << 3);
+		w83627ehf_write_value(client, W83627EHF_REG_VBAT, reg);
+		break;
+	case 1:
+		reg = (w83627ehf_read_value(client, W83627EHF_REG_FANDIV1) & 0x3f)
+		    | ((data->fan_div[1] & 0x03) << 6);
+		w83627ehf_write_value(client, W83627EHF_REG_FANDIV1, reg);
+		reg = (w83627ehf_read_value(client, W83627EHF_REG_VBAT) & 0xbf)
+		    | ((data->fan_div[1] & 0x04) << 4);
+		w83627ehf_write_value(client, W83627EHF_REG_VBAT, reg);
+		break;
+	case 2:
+		reg = (w83627ehf_read_value(client, W83627EHF_REG_FANDIV2) & 0x3f)
+		    | ((data->fan_div[2] & 0x03) << 6);
+		w83627ehf_write_value(client, W83627EHF_REG_FANDIV2, reg);
+		reg = (w83627ehf_read_value(client, W83627EHF_REG_VBAT) & 0x7f)
+		    | ((data->fan_div[2] & 0x04) << 5);
+		w83627ehf_write_value(client, W83627EHF_REG_VBAT, reg);
+		break;
+	case 3:
+		reg = (w83627ehf_read_value(client, W83627EHF_REG_DIODE) & 0xfc)
+		    | (data->fan_div[3] & 0x03);
+		w83627ehf_write_value(client, W83627EHF_REG_DIODE, reg);
+		reg = (w83627ehf_read_value(client, W83627EHF_REG_SMI_OVT) & 0x7f)
+		    | ((data->fan_div[3] & 0x04) << 5);
+		w83627ehf_write_value(client, W83627EHF_REG_SMI_OVT, reg);
+		break;
+	case 4:
+		reg = (w83627ehf_read_value(client, W83627EHF_REG_DIODE) & 0x73)
+		    | ((data->fan_div[4] & 0x03) << 3)
+		    | ((data->fan_div[4] & 0x04) << 5);
+		w83627ehf_write_value(client, W83627EHF_REG_DIODE, reg);
+		break;
+	}
+	/* Restore fan_min */
+	data->fan_min[nr] = fan_to_reg(min, div_from_reg(data->fan_div[nr]));
+	w83627ehf_write_value(client, W83627EHF_REG_FAN_MIN[nr],
+			     data->fan_min[nr]);
+
+	return count;
+}
+
+#define sysfs_fan_offset(offset) \
+static ssize_t \
+show_reg_fan_##offset(struct device *dev, char *buf) \
+{ \
+	return show_fan(dev, buf, offset-1); \
+} \
+static DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
+		   show_reg_fan_##offset, NULL);
+
+#define sysfs_fan_min_offset(offset) \
+static ssize_t \
+show_reg_fan##offset##_min(struct device *dev, char *buf) \
+{ \
+	return show_fan_min(dev, buf, offset-1); \
+} \
+static ssize_t \
+store_reg_fan##offset##_min(struct device *dev, const char *buf, \
+			    size_t count) \
+{ \
+	return store_fan_min(dev, buf, count, offset-1); \
+} \
+static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
+		   show_reg_fan##offset##_min, \
+		   store_reg_fan##offset##_min);
+
+#define sysfs_fan_div_offset(offset) \
+static ssize_t \
+show_reg_fan##offset##_div(struct device *dev, char *buf) \
+{ \
+	return show_fan_div(dev, buf, offset - 1); \
+} \
+static ssize_t \
+store_reg_fan##offset##_div(struct device *dev, \
+			    const char *buf, size_t count) \
+{ \
+	return store_fan_div(dev, buf, count, offset - 1); \
+} \
+static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
+		   show_reg_fan##offset##_div, \
+		   store_reg_fan##offset##_div);
+
+sysfs_fan_offset(1);
+sysfs_fan_min_offset(1);
+sysfs_fan_div_offset(1);
+sysfs_fan_offset(2);
+sysfs_fan_min_offset(2);
+sysfs_fan_div_offset(2);
+sysfs_fan_offset(3);
+sysfs_fan_min_offset(3);
+sysfs_fan_div_offset(3);
+sysfs_fan_offset(4);
+sysfs_fan_min_offset(4);
+sysfs_fan_div_offset(4);
+sysfs_fan_offset(5);
+sysfs_fan_min_offset(5);
+sysfs_fan_div_offset(5);
+
+#define show_temp1_reg(reg) \
+static ssize_t \
+show_##reg(struct device *dev, char *buf) \
+{ \
+	struct w83627ehf_data *data = w83627ehf_update_device(dev); \
+	return sprintf(buf, "%d\n", temp1_from_reg(data->reg)); \
+}
+show_temp1_reg(temp1);
+show_temp1_reg(temp1_max);
+show_temp1_reg(temp1_max_hyst);
+
+#define store_temp1_reg(REG, reg) \
+static ssize_t \
+store_temp1_##reg(struct device *dev, const char *buf, size_t count) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct w83627ehf_data *data = i2c_get_clientdata(client); \
+	u32 val = simple_strtoul(buf, NULL, 10); \
+	data->temp1_##reg = temp1_to_reg(val); \
+	w83627ehf_write_value(client, W83627EHF_REG_TEMP1_##REG, \
+			      data->temp1_##reg); \
+	return count; \
+}
+store_temp1_reg(OVER, max);
+store_temp1_reg(HYST, max_hyst);
+
+static DEVICE_ATTR(temp1_input, S_IRUGO, show_temp1, NULL);
+static DEVICE_ATTR(temp1_max, S_IRUGO| S_IWUSR,
+		   show_temp1_max, store_temp1_max);
+static DEVICE_ATTR(temp1_max_hyst, S_IRUGO| S_IWUSR,
+		   show_temp1_max_hyst, store_temp1_max_hyst);
+
+#define show_temp_reg(reg) \
+static ssize_t \
+show_##reg (struct device *dev, char *buf, int nr) \
+{ \
+	struct w83627ehf_data *data = w83627ehf_update_device(dev); \
+	return sprintf(buf, "%d\n", \
+		       LM75_TEMP_FROM_REG(data->reg[nr])); \
+}
+show_temp_reg(temp);
+show_temp_reg(temp_max);
+show_temp_reg(temp_max_hyst);
+
+#define store_temp_reg(REG, reg) \
+static ssize_t \
+store_##reg (struct device *dev, const char *buf, size_t count, int nr) \
+{ \
+	struct i2c_client *client = to_i2c_client(dev); \
+	struct w83627ehf_data *data = i2c_get_clientdata(client); \
+	u32 val = simple_strtoul(buf, NULL, 10); \
+	data->reg[nr] = LM75_TEMP_TO_REG(val); \
+	w83627ehf_write_value(client, W83627EHF_REG_TEMP_##REG[nr], \
+			      data->reg[nr]); \
+	return count; \
+}
+store_temp_reg(OVER, temp_max);
+store_temp_reg(HYST, temp_max_hyst);
+
+#define sysfs_temp_offset(offset) \
+static ssize_t \
+show_reg_temp##offset (struct device *dev, char *buf) \
+{ \
+	return show_temp(dev, buf, offset - 2); \
+} \
+static DEVICE_ATTR(temp##offset##_input, S_IRUGO, \
+		   show_reg_temp##offset, NULL);
+
+#define sysfs_temp_reg_offset(reg, offset) \
+static ssize_t \
+show_reg_temp##offset##_##reg(struct device *dev, char *buf) \
+{ \
+	return show_temp_##reg(dev, buf, offset - 2); \
+} \
+static ssize_t \
+store_reg_temp##offset##_##reg(struct device *dev, const char *buf, \
+			       size_t count) \
+{ \
+	return store_temp_##reg(dev, buf, count, offset - 2); \
+} \
+static DEVICE_ATTR(temp##offset##_##reg, S_IRUGO| S_IWUSR, \
+		   show_reg_temp##offset##_##reg, \
+		   store_reg_temp##offset##_##reg);
+
+sysfs_temp_offset(2);
+sysfs_temp_reg_offset(max, 2);
+sysfs_temp_reg_offset(max_hyst, 2);
+sysfs_temp_offset(3);
+sysfs_temp_reg_offset(max, 3);
+sysfs_temp_reg_offset(max_hyst, 3);
+
+/*
+ * Driver and client management
+ */
+
+static struct i2c_driver w83627ehf_driver;
+
+static void w83627ehf_init_client(struct i2c_client *client)
+{
+	int i;
+	u8 tmp;
+
+	/* Start monitoring is needed */
+	tmp = w83627ehf_read_value(client, W83627EHF_REG_CONFIG);
+	if (!(tmp & 0x01))
+		w83627ehf_write_value(client, W83627EHF_REG_CONFIG,
+				      tmp | 0x01);
+
+	/* Enable temp2 and temp3 if needed */
+	for (i = 0; i < 2; i++) {
+		tmp = w83627ehf_read_value(client,
+					   W83627EHF_REG_TEMP_CONFIG[i]);
+		if (tmp & 0x01)
+			w83627ehf_write_value(client,
+					      W83627EHF_REG_TEMP_CONFIG[i],
+					      tmp & 0xfe);
+	}
+}
+
+int w83627ehf_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *client;
+	struct w83627ehf_data *data;
+	int i, err = 0;
+
+	if (!i2c_is_isa_adapter(adapter))
+		return 0;
+
+	if (!request_region(address, REGION_LENGTH, w83627ehf_driver.name)) {
+		err = -EBUSY;
+		goto exit;
+	}
+
+	if (!(data = kmalloc(sizeof(struct w83627ehf_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit_release;
+	}
+	memset(data, 0, sizeof(struct w83627ehf_data));
+
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	init_MUTEX(&data->lock);
+	client->adapter = adapter;
+	client->driver = &w83627ehf_driver;
+	client->flags = 0;
+
+	strlcpy(client->name, "w83627ehf", I2C_NAME_SIZE);
+	data->valid = 0;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the i2c layer a new client has arrived */
+	if ((err = i2c_attach_client(client)))
+		goto exit_free;
+
+	/* Initialize the chip */
+	w83627ehf_init_client(client);
+
+	/* A few vars need to be filled upon startup */
+	for (i = 0; i < 5; i++)
+		data->fan_min[i] = w83627ehf_read_value(client,
+				   W83627EHF_REG_FAN_MIN[i]);
+
+	/* Register sysfs hooks */
+	device_create_file(&client->dev, &dev_attr_fan1_input);
+	device_create_file(&client->dev, &dev_attr_fan1_min);
+	device_create_file(&client->dev, &dev_attr_fan1_div);
+	device_create_file(&client->dev, &dev_attr_fan2_input);
+	device_create_file(&client->dev, &dev_attr_fan2_min);
+	device_create_file(&client->dev, &dev_attr_fan2_div);
+	device_create_file(&client->dev, &dev_attr_fan3_input);
+	device_create_file(&client->dev, &dev_attr_fan3_min);
+	device_create_file(&client->dev, &dev_attr_fan3_div);
+
+	/* It looks like fan4 and fan5 pins can be alternatively used
+	   as fan on/off switches */
+	i = w83627ehf_read_value(client, W83627EHF_REG_FANDIV1);
+	if (i & (1 << 2)) {
+		device_create_file(&client->dev, &dev_attr_fan4_input);
+		device_create_file(&client->dev, &dev_attr_fan4_min);
+		device_create_file(&client->dev, &dev_attr_fan4_div);
+	}
+	if (i & (1 << 0)) {
+		device_create_file(&client->dev, &dev_attr_fan5_input);
+		device_create_file(&client->dev, &dev_attr_fan5_min);
+		device_create_file(&client->dev, &dev_attr_fan5_div);
+	}
+
+	device_create_file(&client->dev, &dev_attr_temp1_input);
+	device_create_file(&client->dev, &dev_attr_temp1_max);
+	device_create_file(&client->dev, &dev_attr_temp1_max_hyst);
+	device_create_file(&client->dev, &dev_attr_temp2_input);
+	device_create_file(&client->dev, &dev_attr_temp2_max);
+	device_create_file(&client->dev, &dev_attr_temp2_max_hyst);
+	device_create_file(&client->dev, &dev_attr_temp3_input);
+	device_create_file(&client->dev, &dev_attr_temp3_max);
+	device_create_file(&client->dev, &dev_attr_temp3_max_hyst);
+
+	return 0;
+
+exit_free:
+	kfree(data);
+exit_release:
+	release_region(address, REGION_LENGTH);
+exit:
+	return err;
+}
+
+static int w83627ehf_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
+	return i2c_detect(adapter, &addr_data, w83627ehf_detect);
+}
+
+static int w83627ehf_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	if ((err = i2c_detach_client(client))) {
+		dev_err(&client->dev, "Client deregistration failed, "
+			"client not detached.\n");
+		return err;
+	}
+	release_region(client->addr, REGION_LENGTH);
+	kfree(i2c_get_clientdata(client));
+
+	return 0;
+}
+
+static struct i2c_driver w83627ehf_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "w83627ehf",
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= w83627ehf_attach_adapter,
+	.detach_client	= w83627ehf_detach_client,
+};
+
+static int __init w83627ehf_find(int sioaddr, int *address)
+{
+	u16 val;
+
+	REG = sioaddr;
+	VAL = sioaddr + 1;
+	superio_enter();
+
+	val = (superio_inb(SIO_REG_DEVID) << 8)
+	    | superio_inb(SIO_REG_DEVID + 1);
+	if ((val & SIO_ID_MASK) != SIO_W83627EHF_ID) {
+		superio_exit();
+		return -ENODEV;
+	}
+
+	superio_select(W83627EHF_LD_HWM);
+	val = (superio_inb(SIO_REG_ADDR) << 8)
+	    | superio_inb(SIO_REG_ADDR + 1);
+	*address = val & ~(REGION_LENGTH - 1);
+	if (*address == 0) {
+		superio_exit();
+		return -ENODEV;
+	}
+
+	/* Activate logical device if needed */
+	val = superio_inb(SIO_REG_ENABLE);
+	if (!(val & 0x01))
+		superio_outb(SIO_REG_ENABLE, val | 0x01);
+
+	superio_exit();
+	return 0;
+}
+
+static int __init sensors_w83627ehf_init(void)
+{
+	if (w83627ehf_find(0x2e, &normal_isa[0])
+	 && w83627ehf_find(0x4e, &normal_isa[0]))
+		return -ENODEV;
+
+	return i2c_add_driver(&w83627ehf_driver);
+}
+
+static void __exit sensors_w83627ehf_exit(void)
+{
+	i2c_del_driver(&w83627ehf_driver);
+}
+
+MODULE_AUTHOR("Jean Delvare <khali@linux-fr.org>");
+MODULE_DESCRIPTION("W83627EHF driver");
+MODULE_LICENSE("GPL");
+
+module_init(sensors_w83627ehf_init);
+module_exit(sensors_w83627ehf_exit);

--Multipart=_Sat__26_Feb_2005_19_11_42_+0100_4TlJn3SB=vcmbkM0--
