Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTDXOtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 10:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbTDXOtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 10:49:46 -0400
Received: from iucha.net ([209.98.146.184]:15170 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S263610AbTDXOtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 10:49:06 -0400
Date: Thu, 24 Apr 2003 10:01:13 -0500
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, chrisg@0-in.com,
       sensors@stimpy.netroedge.com
Subject: it87 driver converted to sysfs
Message-ID: <20030424150113.GJ1069@iucha.net>
Mail-Followup-To: greg@kroah.com, linux-kernel@vger.kernel.org,
	chrisg@0-in.com, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQ77YLfPrO/qF/pM"
Content-Disposition: inline
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQ77YLfPrO/qF/pM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greg,

I have converted it87 i2c driver to use sysfs. Please review it and
submit it for inclusion.

Thank you,
florin

diff -Nru linux-2.5.68/drivers/i2c/chips/it87.c linux-2.5.68-it87/drivers/i=
2c/chips/it87.c
--- linux-2.5.68/drivers/i2c/chips/it87.c	1969-12-31 18:00:00.000000000 -06=
00
+++ linux-2.5.68-it87/drivers/i2c/chips/it87.c	2003-04-24 09:54:51.00000000=
0 -0500
@@ -0,0 +1,1002 @@
+/*
+    it87.c - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring.
+
+    Supports: IT8705F  Super I/O chip w/LPC interface
+              IT8712F  Super I/O chup w/LPC interface & SMbus
+              Sis950   A clone of the IT8705F
+
+    Copyright (c) 2001 Chris Gauthron <chrisg@0-in.com>=20
+    Largely inspired by lm78.c of the same package
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
+/*
+    djg@pdp8.net David Gesswein 7/18/01
+    Modified to fix bug with not all alarms enabled.
+    Added ability to read battery voltage and select temperature sensor
+    type at module load time.
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#include <asm/io.h>
+
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] =3D { SENSORS_I2C_END };
+static unsigned short normal_i2c_range[] =3D { 0x20, 0x2f, SENSORS_I2C_END=
 };
+static unsigned int normal_isa[] =3D { 0x0290, SENSORS_ISA_END };
+static unsigned int normal_isa_range[] =3D { SENSORS_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_4(it87, it8705, it8712, sis950);
+
+
+/* Update battery voltage after every reading if true */
+static int update_vbat =3D 0;
+
+
+/* Enable Temp1 as thermal resistor */
+/* Enable Temp2 as thermal diode */
+/* Enable Temp3 as thermal resistor */
+static int temp_type =3D 0x2a;
+
+/* Many IT87 constants specified below */
+
+/* Length of ISA address segment */
+#define IT87_EXTENT 8
+
+/* Where are the ISA address/data registers relative to the base address */
+#define IT87_ADDR_REG_OFFSET 5
+#define IT87_DATA_REG_OFFSET 6
+
+/*----- The IT87 registers -----*/
+
+#define IT87_REG_CONFIG        0x00
+
+#define IT87_REG_ALARM1        0x01
+#define IT87_REG_ALARM2        0x02
+#define IT87_REG_ALARM3        0x03
+
+#define IT87_REG_VID           0x0a
+#define IT87_REG_FAN_DIV       0x0b
+
+/* Monitors: 9 voltage (0 to 7, battery), 3 temp (1 to 3), 3 fan (1 to 3) =
*/
+
+#define IT87_REG_FAN(nr)       (0x0c + (nr))
+#define IT87_REG_FAN_MIN(nr)   (0x0f + (nr))
+#define IT87_REG_FAN_CTRL      0x13
+
+#define IT87_REG_VIN(nr)       (0x20 + (nr))
+#define IT87_REG_TEMP(nr)      (0x28 + (nr))
+
+#define IT87_REG_VIN_MAX(nr)   (0x30 + (nr) * 2)
+#define IT87_REG_VIN_MIN(nr)   (0x31 + (nr) * 2)
+#define IT87_REG_TEMP_HIGH(nr) (0x3e + (nr) * 2)
+#define IT87_REG_TEMP_LOW(nr)  (0x3f + (nr) * 2)
+
+#define IT87_REG_I2C_ADDR      0x48
+
+#define IT87_REG_VIN_ENABLE    0x50
+#define IT87_REG_TEMP_ENABLE   0x51
+
+#define IT87_REG_CHIPID        0x58
+
+static inline u8 IN_TO_REG(long val, int inNum)
+{
+	/* to avoid floating point, we multiply everything by 100.
+	 val is guaranteed to be positive, so we can achieve the effect of=20
+	 rounding by (...*10+5)/10.  Note that the *10 is hidden in the=20
+	 /250 (which should really be /2500).
+	 At the end, we need to /100 because we *100 everything and we need
+	 to /10 because of the rounding thing, so we /1000.   */
+	if (inNum <=3D 1)
+		return (u8)
+		    SENSORS_LIMIT(((val * 210240 - 13300) / 250 + 5) / 1000,=20
+				  0, 255);
+	else if (inNum =3D=3D 2)
+		return (u8)
+		    SENSORS_LIMIT(((val * 157370 - 13300) / 250 + 5) / 1000,=20
+				  0, 255);
+	else if (inNum =3D=3D 3)
+		return (u8)
+		    SENSORS_LIMIT(((val * 101080 - 13300) / 250 + 5) / 1000,=20
+				  0, 255);
+	else
+		return (u8) SENSORS_LIMIT(((val * 41714 - 13300) / 250 + 5)
+					  / 1000, 0, 255);
+}
+
+static inline long IN_FROM_REG(u8 val, int inNum)
+{
+	/* to avoid floating point, we multiply everything by 100.
+	 val is guaranteed to be positive, so we can achieve the effect of
+	 rounding by adding 0.5.  Or, to avoid fp math, we do (...*10+5)/10.
+	 We need to scale with *100 anyway, so no need to /100 at the end. */
+	if (inNum <=3D 1)
+		return (long) (((250000 * val + 13300) / 210240 * 10 + 5) /10);
+	else if (inNum =3D=3D 2)
+		return (long) (((250000 * val + 13300) / 157370 * 10 + 5) /10);
+	else if (inNum =3D=3D 3)
+		return (long) (((250000 * val + 13300) / 101080 * 10 + 5) /10);
+	else
+		return (long) (((250000 * val + 13300) / 41714 * 10 + 5) /10);
+}
+
+static inline u8 FAN_TO_REG(long rpm, int div)
+{
+	if (rpm =3D=3D 0)
+		return 255;
+	rpm =3D SENSORS_LIMIT(rpm, 1, 1000000);
+	return SENSORS_LIMIT((1350000 + rpm * div / 2) / (rpm * div), 1,
+			     254);
+}
+
+#define FAN_FROM_REG(val,div) ((val)=3D=3D0?-1:(val)=3D=3D255?0:1350000/((=
val)*(div)))
+
+#define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-5)/10):\
+                                                 ((val)+5)/10),0,255))
+#define TEMP_FROM_REG(val) (((val)>0x80?(val)-0x100:(val))*10)
+
+#define VID_FROM_REG(val) ((val)=3D=3D0x1f?0:(val)>=3D0x10?510-(val)*10:\
+                           205-(val)*5)
+#define ALARMS_FROM_REG(val) (val)
+
+#define DIV_TO_REG(val) ((val)=3D=3D8?3:(val)=3D=3D4?2:(val)=3D=3D1?0:1)
+#define DIV_FROM_REG(val) (1 << (val))
+
+/* Initial limits. Use the config file to set better limits. */
+#define IT87_INIT_IN_0 170
+#define IT87_INIT_IN_1 250
+#define IT87_INIT_IN_2 (330 / 2)
+#define IT87_INIT_IN_3 (((500)   * 100)/168)
+#define IT87_INIT_IN_4 (((1200)  * 10)/38)
+#define IT87_INIT_IN_5 (((1200)  * 10)/72)
+#define IT87_INIT_IN_6 (((500)   * 10)/56)
+#define IT87_INIT_IN_7 (((500)   * 100)/168)
+
+#define IT87_INIT_IN_PERCENTAGE 10
+
+#define IT87_INIT_IN_MIN_0 \
+        (IT87_INIT_IN_0 - IT87_INIT_IN_0 * IT87_INIT_IN_PERCENTAGE / 100)
+#define IT87_INIT_IN_MAX_0 \
+        (IT87_INIT_IN_0 + IT87_INIT_IN_0 * IT87_INIT_IN_PERCENTAGE / 100)
+#define IT87_INIT_IN_MIN_1 \
+        (IT87_INIT_IN_1 - IT87_INIT_IN_1 * IT87_INIT_IN_PERCENTAGE / 100)
+#define IT87_INIT_IN_MAX_1 \
+        (IT87_INIT_IN_1 + IT87_INIT_IN_1 * IT87_INIT_IN_PERCENTAGE / 100)
+#define IT87_INIT_IN_MIN_2 \
+        (IT87_INIT_IN_2 - IT87_INIT_IN_2 * IT87_INIT_IN_PERCENTAGE / 100)
+#define IT87_INIT_IN_MAX_2 \
+        (IT87_INIT_IN_2 + IT87_INIT_IN_2 * IT87_INIT_IN_PERCENTAGE / 100)
+#define IT87_INIT_IN_MIN_3 \
+        (IT87_INIT_IN_3 - IT87_INIT_IN_3 * IT87_INIT_IN_PERCENTAGE / 100)
+#define IT87_INIT_IN_MAX_3 \
+        (IT87_INIT_IN_3 + IT87_INIT_IN_3 * IT87_INIT_IN_PERCENTAGE / 100)
+#define IT87_INIT_IN_MIN_4 \
+        (IT87_INIT_IN_4 - IT87_INIT_IN_4 * IT87_INIT_IN_PERCENTAGE / 100)
+#define IT87_INIT_IN_MAX_4 \
+        (IT87_INIT_IN_4 + IT87_INIT_IN_4 * IT87_INIT_IN_PERCENTAGE / 100)
+#define IT87_INIT_IN_MIN_5 \
+        (IT87_INIT_IN_5 - IT87_INIT_IN_5 * IT87_INIT_IN_PERCENTAGE / 100)
+#define IT87_INIT_IN_MAX_5 \
+        (IT87_INIT_IN_5 + IT87_INIT_IN_5 * IT87_INIT_IN_PERCENTAGE / 100)
+#define IT87_INIT_IN_MIN_6 \
+        (IT87_INIT_IN_6 - IT87_INIT_IN_6 * IT87_INIT_IN_PERCENTAGE / 100)
+#define IT87_INIT_IN_MAX_6 \
+        (IT87_INIT_IN_6 + IT87_INIT_IN_6 * IT87_INIT_IN_PERCENTAGE / 100)
+#define IT87_INIT_IN_MIN_7 \
+        (IT87_INIT_IN_7 - IT87_INIT_IN_7 * IT87_INIT_IN_PERCENTAGE / 100)
+#define IT87_INIT_IN_MAX_7 \
+        (IT87_INIT_IN_7 + IT87_INIT_IN_7 * IT87_INIT_IN_PERCENTAGE / 100)
+
+#define IT87_INIT_FAN_MIN_1 3000
+#define IT87_INIT_FAN_MIN_2 3000
+#define IT87_INIT_FAN_MIN_3 3000
+
+#define IT87_INIT_TEMP_HIGH_1 600
+#define IT87_INIT_TEMP_LOW_1  200
+#define IT87_INIT_TEMP_HIGH_2 600
+#define IT87_INIT_TEMP_LOW_2  200
+#define IT87_INIT_TEMP_HIGH_3 600=20
+#define IT87_INIT_TEMP_LOW_3  200
+
+/* For each registered IT87, we need to keep some data in memory. That
+   data is pointed to by it87_list[NR]->data. The structure itself is
+   dynamically allocated, at the same time when a new it87 client is
+   allocated. */
+struct it87_data {
+	struct semaphore lock;
+	int sysctl_id;
+	enum chips type;
+
+	struct semaphore update_lock;
+	char valid;		/* !=3D0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+
+	u8 in[9];		/* Register value */
+	u8 in_max[9];		/* Register value */
+	u8 in_min[9];		/* Register value */
+	u8 fan[3];		/* Register value */
+	u8 fan_min[3];		/* Register value */
+	u8 temp[3];		/* Register value */
+	u8 temp_high[3];	/* Register value */
+	u8 temp_low[3];		/* Register value */
+	u8 fan_div[3];		/* Register encoding, shifted right */
+	u8 vid;			/* Register encoding, combined */
+	u32 alarms;		/* Register encoding, combined */
+};
+
+
+static int it87_attach_adapter(struct i2c_adapter *adapter);
+static int it87_detect(struct i2c_adapter *adapter, int address, int kind);
+static int it87_detach_client(struct i2c_client *client);
+
+static int it87_read_value(struct i2c_client *client, u8 register);
+static int it87_write_value(struct i2c_client *client, u8 register,
+			    u8 value);
+static void it87_update_client(struct i2c_client *client);
+static void it87_init_client(struct i2c_client *client);
+
+
+static struct i2c_driver it87_driver =3D {
+	.owner		=3D THIS_MODULE,
+	.name		=3D "IT87xx sensor driver",
+	.id		=3D I2C_DRIVERID_IT87,
+	.flags		=3D I2C_DF_NOTIFY,
+	.attach_adapter	=3D it87_attach_adapter,
+	.detach_client	=3D it87_detach_client,
+};
+
+static int it87_id =3D 0;
+
+/* The /proc/sys entries */
+
+/* -- SENSORS SYSCTL START -- */
+#define IT87_SYSCTL_IN0 1000    /* Volts * 100 */
+#define IT87_SYSCTL_IN1 1001
+#define IT87_SYSCTL_IN2 1002
+#define IT87_SYSCTL_IN3 1003
+#define IT87_SYSCTL_IN4 1004
+#define IT87_SYSCTL_IN5 1005
+#define IT87_SYSCTL_IN6 1006
+#define IT87_SYSCTL_IN7 1007
+#define IT87_SYSCTL_IN8 1008
+#define IT87_SYSCTL_FAN1 1101   /* Rotations/min */
+#define IT87_SYSCTL_FAN2 1102
+#define IT87_SYSCTL_FAN3 1103
+#define IT87_SYSCTL_TEMP1 1200  /* Degrees Celcius * 10 */
+#define IT87_SYSCTL_TEMP2 1201  /* Degrees Celcius * 10 */
+#define IT87_SYSCTL_TEMP3 1202  /* Degrees Celcius * 10 */
+#define IT87_SYSCTL_VID 1300    /* Volts * 100 */
+#define IT87_SYSCTL_FAN_DIV 2000        /* 1, 2, 4 or 8 */
+#define IT87_SYSCTL_ALARMS 2004    /* bitvector */
+
+#define IT87_ALARM_IN0 0x000100
+#define IT87_ALARM_IN1 0x000200
+#define IT87_ALARM_IN2 0x000400
+#define IT87_ALARM_IN3 0x000800
+#define IT87_ALARM_IN4 0x001000
+#define IT87_ALARM_IN5 0x002000
+#define IT87_ALARM_IN6 0x004000
+#define IT87_ALARM_IN7 0x008000
+#define IT87_ALARM_FAN1 0x0001
+#define IT87_ALARM_FAN2 0x0002
+#define IT87_ALARM_FAN3 0x0004
+#define IT87_ALARM_TEMP1 0x00010000
+#define IT87_ALARM_TEMP2 0x00020000
+#define IT87_ALARM_TEMP3 0x00040000
+
+/* -- SENSORS SYSCTL END -- */
+
+/* These files are created for each detected IT87. This is just a template;
+   though at first sight, you might think we could use a statically
+   allocated list, we need some way to get back to the parent - which
+   is done through one of the 'extra' fields which are initialized=20
+   when a new copy is allocated.=20
+static ctl_table it87_dir_table_template[] =3D {
+	{IT87_SYSCTL_IN0, "in0", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_in},
+	{IT87_SYSCTL_IN1, "in1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_in},
+	{IT87_SYSCTL_IN2, "in2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_in},
+	{IT87_SYSCTL_IN3, "in3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_in},
+	{IT87_SYSCTL_IN4, "in4", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_in},
+	{IT87_SYSCTL_IN5, "in5", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_in},
+	{IT87_SYSCTL_IN6, "in6", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_in},
+	{IT87_SYSCTL_IN7, "in7", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_in},
+	{IT87_SYSCTL_IN8, "in8", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_in},
+	{IT87_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_fan},
+	{IT87_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_fan},
+	{IT87_SYSCTL_FAN3, "fan3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_fan},
+	{IT87_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_temp},
+	{IT87_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_temp},
+	{IT87_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_temp},
+	{IT87_SYSCTL_VID, "vid", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_vid},
+	{IT87_SYSCTL_FAN_DIV, "fan_div", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_fan_div},
+	{IT87_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &it87_alarms},
+	{0}
+};
+
+*/
+
+static ssize_t show_in(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in[nr], nr)*10 );
+}
+
+static ssize_t show_in_min(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_min[nr], nr)*10 );
+}
+
+static ssize_t show_in_max(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf, "%ld\n", IN_FROM_REG(data->in_max[nr], nr)*10 );
+}
+
+static ssize_t set_in_min(struct device *dev, const char *buf,=20
+		size_t count, int nr) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	unsigned long val =3D simple_strtoul(buf, NULL, 10)/10;
+	data->in_min[nr] =3D IN_TO_REG(val,nr);
+	it87_write_value(client, IT87_REG_VIN_MIN(nr),=20
+			data->in_min[nr]);
+	return count;
+}
+static ssize_t set_in_max(struct device *dev, const char *buf,=20
+		size_t count, int nr) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	unsigned long val =3D simple_strtoul(buf, NULL, 10)/10;
+	data->in_max[nr] =3D IN_TO_REG(val,nr);
+	it87_write_value(client, IT87_REG_VIN_MAX(nr),=20
+			data->in_max[nr]);
+	return count;
+}
+#define show_in_offset(offset)					\
+static ssize_t 							\
+	show_in##offset (struct device *dev, char *buf)		\
+{								\
+	return show_in(dev, buf, 0x##offset);			\
+}								\
+static ssize_t 							\
+	show_in##offset##_min (struct device *dev, char *buf)	\
+{								\
+	return show_in_min(dev, buf, 0x##offset);		\
+}								\
+static ssize_t 							\
+	show_in##offset##_max (struct device *dev, char *buf)	\
+{								\
+	return show_in_max(dev, buf, 0x##offset);		\
+}								\
+static ssize_t set_in##offset##_min (struct device *dev, 	\
+		const char *buf, size_t count) 			\
+{								\
+	return set_in_min(dev, buf, count, 0x##offset);		\
+}								\
+static ssize_t set_in##offset##_max (struct device *dev,	\
+			const char *buf, size_t count)		\
+{								\
+	return set_in_max(dev, buf, count, 0x##offset);		\
+}								\
+static DEVICE_ATTR(in_input##offset, S_IRUGO, show_in##offset, NULL) 	\
+static DEVICE_ATTR(in_min##offset, S_IRUGO | S_IWUSR, 		\
+		show_in##offset##_min, set_in##offset##_min)	\
+static DEVICE_ATTR(in_max##offset, S_IRUGO | S_IWUSR, 		\
+		show_in##offset##_max, set_in##offset##_max)
+
+show_in_offset(0);
+show_in_offset(1);
+show_in_offset(2);
+show_in_offset(3);
+show_in_offset(4);
+
+/* 3 temperatures */
+static ssize_t show_temp(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr])*10 );
+}
+/* more like overshoot temperature */
+static ssize_t show_temp_max(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_high[nr])*10);
+}
+/* more like hysteresis temperature */
+static ssize_t show_temp_min(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_low[nr])*10);
+}
+static ssize_t set_temp_max(struct device *dev, const char *buf,=20
+		size_t count, int nr) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	int val =3D simple_strtol(buf, NULL, 10)/10;
+	data->temp_high[nr] =3D TEMP_TO_REG(val);
+	it87_write_value(client, IT87_REG_TEMP_HIGH(nr), data->temp_high[nr]);
+	return count;
+}
+static ssize_t set_temp_min(struct device *dev, const char *buf,=20
+		size_t count, int nr) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	int val =3D simple_strtol(buf, NULL, 10)/10;
+	data->temp_low[nr] =3D TEMP_TO_REG(val);
+	it87_write_value(client, IT87_REG_TEMP_LOW(nr), data->temp_low[nr]);
+	return count;
+}
+#define show_temp_offset(offset)					\
+static ssize_t show_temp_##offset (struct device *dev, char *buf)	\
+{									\
+	return show_temp(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t								\
+show_temp_##offset##_max (struct device *dev, char *buf)		\
+{									\
+	return show_temp_max(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t								\
+show_temp_##offset##_min (struct device *dev, char *buf)		\
+{									\
+	return show_temp_min(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t set_temp_##offset##_max (struct device *dev, 		\
+		const char *buf, size_t count) 				\
+{									\
+	return set_temp_max(dev, buf, count, 0x##offset - 1);		\
+}									\
+static ssize_t set_temp_##offset##_min (struct device *dev, 		\
+		const char *buf, size_t count) 				\
+{									\
+	return set_temp_min(dev, buf, count, 0x##offset - 1);		\
+}									\
+static DEVICE_ATTR(temp_input##offset, S_IRUGO, show_temp_##offset, NULL) \
+static DEVICE_ATTR(temp_max##offset, S_IRUGO | S_IWUSR, 		\
+		show_temp_##offset##_max, set_temp_##offset##_max) 	\
+static DEVICE_ATTR(temp_min##offset, S_IRUGO | S_IWUSR, 		\
+		show_temp_##offset##_min, set_temp_##offset##_min)=09
+
+show_temp_offset(1);
+show_temp_offset(2);
+show_temp_offset(3);
+
+/* 2 Fans */
+static ssize_t show_fan(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan[nr],=20
+				DIV_FROM_REG(data->fan_div[nr])) );
+}
+static ssize_t show_fan_min(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf,"%d\n",
+		FAN_FROM_REG(data->fan_min[nr], DIV_FROM_REG(data->fan_div[nr])) );
+}
+static ssize_t show_fan_div(struct device *dev, char *buf, int nr) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf,"%d\n", DIV_FROM_REG(data->fan_div[nr]) );
+}
+static ssize_t set_fan_min(struct device *dev, const char *buf,=20
+		size_t count, int nr) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	int val =3D simple_strtol(buf, NULL, 10);
+	data->fan_min[nr] =3D FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
+	it87_write_value(client, IT87_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	return count;
+}
+static ssize_t set_fan_div(struct device *dev, const char *buf,=20
+		size_t count, int nr) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	int val =3D simple_strtol(buf, NULL, 10);
+	int old =3D it87_read_value(client, IT87_REG_FAN_DIV);
+	data->fan_div[nr] =3D DIV_TO_REG(val);
+	old =3D (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
+	it87_write_value(client, IT87_REG_FAN_DIV, old);
+	return count;
+}
+
+#define show_fan_offset(offset)						\
+static ssize_t show_fan_##offset (struct device *dev, char *buf)	\
+{									\
+	return show_fan(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t show_fan_##offset##_min (struct device *dev, char *buf)	\
+{									\
+	return show_fan_min(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t show_fan_##offset##_div (struct device *dev, char *buf)	\
+{									\
+	return show_fan_div(dev, buf, 0x##offset - 1);			\
+}									\
+static ssize_t set_fan_##offset##_min (struct device *dev, 		\
+	const char *buf, size_t count) 					\
+{									\
+	return set_fan_min(dev, buf, count, 0x##offset - 1);		\
+}									\
+static ssize_t set_fan_##offset##_div (struct device *dev, 		\
+		const char *buf, size_t count) 				\
+{									\
+	return set_fan_div(dev, buf, count, 0x##offset - 1);		\
+}									\
+static DEVICE_ATTR(fan_input##offset, S_IRUGO, show_fan_##offset, NULL) \
+static DEVICE_ATTR(fan_min##offset, S_IRUGO | S_IWUSR, 			\
+		show_fan_##offset##_min, set_fan_##offset##_min) 	\
+static DEVICE_ATTR(fan_div##offset, S_IRUGO | S_IWUSR, 			\
+		show_fan_##offset##_div, set_fan_##offset##_div)
+
+show_fan_offset(1);
+show_fan_offset(2);
+
+/* Alarm */
+static ssize_t show_alarm(struct device *dev, char *buf) {
+	struct i2c_client *client =3D to_i2c_client(dev);
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	it87_update_client(client);
+	return sprintf(buf,"%d\n", ALARMS_FROM_REG(data->alarms));
+}
+static DEVICE_ATTR(alarm, S_IRUGO | S_IWUSR, show_alarm, NULL);
+
+/* This function is called when:
+     * it87_driver is inserted (when this module is loaded), for each
+       available adapter
+     * when a new adapter is inserted (and it87_driver is still present) */
+static int it87_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, it87_detect);
+}
+
+/* This function is called by i2c_detect */
+int it87_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	int i;
+	struct i2c_client *new_client;
+	struct it87_data *data;
+	int err =3D 0;
+	const char *name =3D "";
+	const char *client_name =3D "";
+	int is_isa =3D i2c_is_isa_adapter(adapter);
+
+	if (!is_isa
+	    && !i2c_check_functionality(adapter,
+					I2C_FUNC_SMBUS_BYTE_DATA)) goto
+		    ERROR0;
+
+	if (is_isa) {
+		if (check_region(address, IT87_EXTENT))
+			goto ERROR0;
+	}
+
+	/* Probe whether there is anything available on this address. Already
+	   done for SMBus clients */
+	if (kind < 0) {
+		if (is_isa) {
+
+#define REALLY_SLOW_IO
+			/* We need the timeouts for at least some IT87-like chips. But only
+			   if we read 'undefined' registers. */
+			i =3D inb_p(address + 1);
+			if (inb_p(address + 2) !=3D i)
+				goto ERROR0;
+			if (inb_p(address + 3) !=3D i)
+				goto ERROR0;
+			if (inb_p(address + 7) !=3D i)
+				goto ERROR0;
+#undef REALLY_SLOW_IO
+
+			/* Let's just hope nothing breaks here */
+			i =3D inb_p(address + 5) & 0x7f;
+			outb_p(~i & 0x7f, address + 5);
+			if ((inb_p(address + 5) & 0x7f) !=3D (~i & 0x7f)) {
+				outb_p(i, address + 5);
+				return 0;
+			}
+		}
+	}
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access it87_{read,write}_value. */
+
+	if (!(new_client =3D kmalloc((sizeof(struct i2c_client)) +
+				   sizeof(struct it87_data),
+				   GFP_KERNEL))) {
+		err =3D -ENOMEM;
+		goto ERROR0;
+	}
+
+	data =3D (struct it87_data *) (new_client + 1);
+	if (is_isa)
+		init_MUTEX(&data->lock);
+   i2c_set_clientdata(new_client, data);
+	new_client->addr =3D address;
+	new_client->adapter =3D adapter;
+	new_client->driver =3D &it87_driver;
+	new_client->flags =3D 0;
+
+	/* Now, we do the remaining detection. */
+
+	if (kind < 0) {
+		if (it87_read_value(new_client, IT87_REG_CONFIG) & 0x80)
+			goto ERROR1;
+		if (!is_isa
+		    && (it87_read_value(new_client, IT87_REG_I2C_ADDR) !=3D
+			address)) goto ERROR1;
+	}
+
+	/* Determine the chip type. */
+	if (kind <=3D 0) {
+		i =3D it87_read_value(new_client, IT87_REG_CHIPID);
+		if (i =3D=3D 0x90) {
+			kind =3D it87;
+		}
+		else {
+			if (kind =3D=3D 0)
+				printk
+				    ("it87.o: Ignoring 'force' parameter for unknown chip at "
+				     "adapter %d, address 0x%02x\n",
+				     i2c_adapter_id(adapter), address);
+			goto ERROR1;
+		}
+	}
+
+	if (kind =3D=3D it87) {
+		name =3D "it87";
+		client_name =3D "IT87 chip";
+	} /* else if (kind =3D=3D it8712) {
+		name =3D "it8712";
+		client_name =3D "IT87-J chip";
+	} */ else {
+      dev_dbg(&adapter->dev, "Internal error: unknown kind (%d)?!?",
+			kind);
+		goto ERROR1;
+	}
+
+	/* Reserve the ISA region */
+	if (is_isa)
+		request_region(address, IT87_EXTENT, name);
+
+	/* Fill in the remaining client fields and put it into the global list */
+   strncpy(new_client->dev.name, name, DEVICE_NAME_SIZE);
+
+	data->type =3D kind;
+
+	new_client->id =3D it87_id++;
+	data->valid =3D 0;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err =3D i2c_attach_client(new_client)))
+		goto ERROR3;
+
+   /* register sysfs hooks */
+	device_create_file(&new_client->dev, &dev_attr_in_input0);
+	device_create_file(&new_client->dev, &dev_attr_in_input1);
+	device_create_file(&new_client->dev, &dev_attr_in_input2);
+	device_create_file(&new_client->dev, &dev_attr_in_input3);
+	device_create_file(&new_client->dev, &dev_attr_in_input4);
+	device_create_file(&new_client->dev, &dev_attr_in_min0);
+	device_create_file(&new_client->dev, &dev_attr_in_min1);
+	device_create_file(&new_client->dev, &dev_attr_in_min2);
+	device_create_file(&new_client->dev, &dev_attr_in_min3);
+	device_create_file(&new_client->dev, &dev_attr_in_min4);
+	device_create_file(&new_client->dev, &dev_attr_in_max0);
+	device_create_file(&new_client->dev, &dev_attr_in_max1);
+	device_create_file(&new_client->dev, &dev_attr_in_max2);
+	device_create_file(&new_client->dev, &dev_attr_in_max3);
+	device_create_file(&new_client->dev, &dev_attr_in_max4);
+	device_create_file(&new_client->dev, &dev_attr_temp_input1);
+	device_create_file(&new_client->dev, &dev_attr_temp_input2);
+	device_create_file(&new_client->dev, &dev_attr_temp_input3);
+	device_create_file(&new_client->dev, &dev_attr_temp_max1);
+	device_create_file(&new_client->dev, &dev_attr_temp_max2);
+	device_create_file(&new_client->dev, &dev_attr_temp_max3);
+	device_create_file(&new_client->dev, &dev_attr_temp_min1);
+	device_create_file(&new_client->dev, &dev_attr_temp_min2);
+	device_create_file(&new_client->dev, &dev_attr_temp_min3);
+	device_create_file(&new_client->dev, &dev_attr_fan_input1);
+	device_create_file(&new_client->dev, &dev_attr_fan_input2);
+	device_create_file(&new_client->dev, &dev_attr_fan_min1);
+	device_create_file(&new_client->dev, &dev_attr_fan_min2);
+	device_create_file(&new_client->dev, &dev_attr_fan_div1);
+	device_create_file(&new_client->dev, &dev_attr_fan_div2);
+	device_create_file(&new_client->dev, &dev_attr_alarm);
+
+	/* Initialize the IT87 chip */
+	it87_init_client(new_client);
+	return 0;
+
+/* OK, this is not exactly good programming practice, usually. But it is
+   very code-efficient in this case. */
+
+      ERROR3:
+	if (is_isa)
+		release_region(address, IT87_EXTENT);
+      ERROR1:
+	kfree(new_client);
+      ERROR0:
+	return err;
+}
+
+static int it87_detach_client(struct i2c_client *client)
+{
+	int err;
+
+	if ((err =3D i2c_detach_client(client))) {
+      dev_err(&client->dev,
+   		"Client deregistration failed, client not detached.\n");
+		return err;
+	}
+
+	if(i2c_is_isa_client(client))
+		release_region(client->addr, IT87_EXTENT);
+	kfree(client);
+
+	return 0;
+}
+
+/* The SMBus locks itself, but ISA access must be locked explicitely!=20
+   We don't want to lock the whole ISA bus, so we lock each client
+   separately.
+   We ignore the IT87 BUSY flag at this moment - it could lead to deadlock=
s,
+   would slow down the IT87 access and should not be necessary.=20
+   There are some ugly typecasts here, but the good new is - they should
+   nowhere else be necessary! */
+static int it87_read_value(struct i2c_client *client, u8 reg)
+{
+   struct it87_data *data =3D i2c_get_clientdata(client);
+
+	int res;
+	if (i2c_is_isa_client(client)) {
+		down(&data->lock);
+		outb_p(reg, client->addr + IT87_ADDR_REG_OFFSET);
+		res =3D inb_p(client->addr + IT87_DATA_REG_OFFSET);
+		up(&data->lock);
+		return res;
+	} else
+		return i2c_smbus_read_byte_data(client, reg);
+}
+
+/* The SMBus locks itself, but ISA access muse be locked explicitely!=20
+   We don't want to lock the whole ISA bus, so we lock each client
+   separately.
+   We ignore the IT87 BUSY flag at this moment - it could lead to deadlock=
s,
+   would slow down the IT87 access and should not be necessary.=20
+   There are some ugly typecasts here, but the good new is - they should
+   nowhere else be necessary! */
+static int it87_write_value(struct i2c_client *client, u8 reg, u8 value)
+{
+   struct it87_data *data =3D i2c_get_clientdata(client);
+
+	if (i2c_is_isa_client(client)) {
+		down(&data->lock);
+		outb_p(reg, client->addr + IT87_ADDR_REG_OFFSET);
+		outb_p(value, client->addr + IT87_DATA_REG_OFFSET);
+		up(&data->lock);
+		return 0;
+	} else
+		return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+/* Called when we have found a new IT87. It should set limits, etc. */
+static void it87_init_client(struct i2c_client *client)
+{
+	/* Reset all except Watchdog values and last conversion values
+	   This sets fan-divs to 2, among others */
+	it87_write_value(client, IT87_REG_CONFIG, 0x80);
+	it87_write_value(client, IT87_REG_VIN_MIN(0),
+			 IN_TO_REG(IT87_INIT_IN_MIN_0, 0));
+	it87_write_value(client, IT87_REG_VIN_MAX(0),
+			 IN_TO_REG(IT87_INIT_IN_MAX_0, 0));
+	it87_write_value(client, IT87_REG_VIN_MIN(1),
+			 IN_TO_REG(IT87_INIT_IN_MIN_1, 1));
+	it87_write_value(client, IT87_REG_VIN_MAX(1),
+			 IN_TO_REG(IT87_INIT_IN_MAX_1, 1));
+	it87_write_value(client, IT87_REG_VIN_MIN(2),
+			 IN_TO_REG(IT87_INIT_IN_MIN_2, 2));
+	it87_write_value(client, IT87_REG_VIN_MAX(2),
+			 IN_TO_REG(IT87_INIT_IN_MAX_2, 2));
+	it87_write_value(client, IT87_REG_VIN_MIN(3),
+			 IN_TO_REG(IT87_INIT_IN_MIN_3, 3));
+	it87_write_value(client, IT87_REG_VIN_MAX(3),
+			 IN_TO_REG(IT87_INIT_IN_MAX_3, 3));
+	it87_write_value(client, IT87_REG_VIN_MIN(4),
+			 IN_TO_REG(IT87_INIT_IN_MIN_4, 4));
+	it87_write_value(client, IT87_REG_VIN_MAX(4),
+			 IN_TO_REG(IT87_INIT_IN_MAX_4, 4));
+	it87_write_value(client, IT87_REG_VIN_MIN(5),
+			 IN_TO_REG(IT87_INIT_IN_MIN_5, 5));
+	it87_write_value(client, IT87_REG_VIN_MAX(5),
+			 IN_TO_REG(IT87_INIT_IN_MAX_5, 5));
+	it87_write_value(client, IT87_REG_VIN_MIN(6),
+			 IN_TO_REG(IT87_INIT_IN_MIN_6, 6));
+	it87_write_value(client, IT87_REG_VIN_MAX(6),
+			 IN_TO_REG(IT87_INIT_IN_MAX_6, 6));
+	it87_write_value(client, IT87_REG_VIN_MIN(7),
+			 IN_TO_REG(IT87_INIT_IN_MIN_7, 7));
+	it87_write_value(client, IT87_REG_VIN_MAX(7),
+			 IN_TO_REG(IT87_INIT_IN_MAX_7, 7));
+        /* Note: Battery voltage does not have limit registers */
+	it87_write_value(client, IT87_REG_FAN_MIN(1),
+			 FAN_TO_REG(IT87_INIT_FAN_MIN_1, 2));
+	it87_write_value(client, IT87_REG_FAN_MIN(2),
+			 FAN_TO_REG(IT87_INIT_FAN_MIN_2, 2));
+	it87_write_value(client, IT87_REG_FAN_MIN(3),
+			 FAN_TO_REG(IT87_INIT_FAN_MIN_3, 2));
+	it87_write_value(client, IT87_REG_TEMP_HIGH(1),
+			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_1));
+	it87_write_value(client, IT87_REG_TEMP_LOW(1),
+			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_1));
+	it87_write_value(client, IT87_REG_TEMP_HIGH(2),
+			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_2));
+	it87_write_value(client, IT87_REG_TEMP_LOW(2),
+			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_2));
+	it87_write_value(client, IT87_REG_TEMP_HIGH(3),
+			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_3));
+	it87_write_value(client, IT87_REG_TEMP_LOW(3),
+			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_3));
+
+	/* Enable voltage monitors */
+	it87_write_value(client, IT87_REG_VIN_ENABLE, 0xff);
+
+	/* Enable Temp1-Temp3 */
+	it87_write_value(client, IT87_REG_TEMP_ENABLE,
+			(it87_read_value(client, IT87_REG_TEMP_ENABLE) & 0xc0)
+			| (temp_type & 0x3f));
+
+	/* Enable fans */
+	it87_write_value(client, IT87_REG_FAN_CTRL,
+			(it87_read_value(client, IT87_REG_FAN_CTRL) & 0x8f)
+			| 0x70);
+
+	/* Start monitoring */
+	it87_write_value(client, IT87_REG_CONFIG,
+			 (it87_read_value(client, IT87_REG_CONFIG) & 0xb7)
+			 | (update_vbat ? 0x41 : 0x01));
+}
+
+static void it87_update_client(struct i2c_client *client)
+{
+   struct it87_data *data =3D i2c_get_clientdata(client);
+	int i;
+
+	down(&data->update_lock);
+
+	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
+	    (jiffies < data->last_updated) || !data->valid) {
+
+		if (update_vbat) {
+                	/* Cleared after each update, so reenable.  Value
+		   	  returned by this read will be previous value */=09
+			it87_write_value(client, IT87_REG_CONFIG,
+			   it87_read_value(client, IT87_REG_CONFIG) | 0x40);
+		}
+		for (i =3D 0; i <=3D 7; i++) {
+			data->in[i] =3D
+			    it87_read_value(client, IT87_REG_VIN(i));
+			data->in_min[i] =3D
+			    it87_read_value(client, IT87_REG_VIN_MIN(i));
+			data->in_max[i] =3D
+			    it87_read_value(client, IT87_REG_VIN_MAX(i));
+		}
+		data->in[8] =3D
+		    it87_read_value(client, IT87_REG_VIN(8));
+		/* Temperature sensor doesn't have limit registers, set
+		   to min and max value */
+		data->in_min[8] =3D 0;
+		data->in_max[8] =3D 255;
+               =20
+		for (i =3D 1; i <=3D 3; i++) {
+			data->fan[i - 1] =3D
+			    it87_read_value(client, IT87_REG_FAN(i));
+			data->fan_min[i - 1] =3D
+			    it87_read_value(client, IT87_REG_FAN_MIN(i));
+		}
+		for (i =3D 1; i <=3D 3; i++) {
+			data->temp[i - 1] =3D
+			    it87_read_value(client, IT87_REG_TEMP(i));
+			data->temp_high[i - 1] =3D
+			    it87_read_value(client, IT87_REG_TEMP_HIGH(i));
+			data->temp_low[i - 1] =3D
+			    it87_read_value(client, IT87_REG_TEMP_LOW(i));
+		}
+
+		/* The 8705 does not have VID capability */
+		/*if (data->type =3D=3D it8712) {
+			data->vid =3D it87_read_value(client, IT87_REG_VID);
+			data->vid &=3D 0x1f;
+		}
+		else */ {
+			data->vid =3D 0x1f;
+		}
+
+		i =3D it87_read_value(client, IT87_REG_FAN_DIV);
+		data->fan_div[0] =3D i & 0x07;
+		data->fan_div[1] =3D (i >> 3) & 0x07;
+		data->fan_div[2] =3D 1;
+
+		data->alarms =3D
+			it87_read_value(client, IT87_REG_ALARM1) |
+			(it87_read_value(client, IT87_REG_ALARM2) << 8) |
+			(it87_read_value(client, IT87_REG_ALARM3) << 16);
+
+		data->last_updated =3D jiffies;
+		data->valid =3D 1;
+	}
+
+	up(&data->update_lock);
+}
+
+static int __init sm_it87_init(void)
+{
+	return i2c_add_driver(&it87_driver);
+}
+
+static void __exit sm_it87_exit(void)
+{
+	i2c_del_driver(&it87_driver);
+}
+
+
+MODULE_AUTHOR("Chris Gauthron <chrisg@0-in.com>");
+MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
+MODULE_PARM(update_vbat, "i");
+MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup valu=
e");
+MODULE_PARM(temp_type, "i");
+MODULE_PARM_DESC(temp_type, "Temperature sensor type, normally leave unset=
");
+MODULE_LICENSE("GPL");
+
+module_init(sm_it87_init);
+module_exit(sm_it87_exit);
diff -Nru linux-2.5.68/drivers/i2c/chips/Kconfig linux-2.5.68-it87/drivers/=
i2c/chips/Kconfig
--- linux-2.5.68/drivers/i2c/chips/Kconfig	2003-04-24 09:46:09.000000000 -0=
500
+++ linux-2.5.68-it87/drivers/i2c/chips/Kconfig	2003-04-24 09:57:32.0000000=
00 -0500
@@ -64,10 +64,20 @@
 	  in the lm_sensors package, which you can download at
 	  http://www.lm-sensors.nu
=20
+config SENSORS_IT87
+	tristate "  ITE IT87 and compatibles"
+	depends on I2C && EXPERIMENTAL
+	help
+	  The module will be called it87.
+
+	  You will also need the latest user-space utilties: you can find them
+	  in the lm_sensors package, which you can download at=20
+	  http://www.lm-sensors.nu
+
 config I2C_SENSOR
 	tristate
-	default y if SENSORS_ADM1021=3Dy || SENSORS_LM75=3Dy || SENSORS_VIA686A=
=3Dy || SENSORS_W83781D=3Dy
-	default m if SENSORS_ADM1021=3Dm || SENSORS_LM75=3Dm || SENSORS_VIA686A=
=3Dm || SENSORS_W83781D=3Dm
+	default y if SENSORS_ADM1021=3Dy || SENSORS_LM75=3Dy || SENSORS_VIA686A=
=3Dy || SENSORS_W83781D=3Dy || SENSORS_IT87=3Dy
+	default m if SENSORS_ADM1021=3Dm || SENSORS_LM75=3Dm || SENSORS_VIA686A=
=3Dm || SENSORS_W83781D=3Dm || SENSORS_IT87=3Dm
 	default n
=20
 endmenu
diff -Nru linux-2.5.68/drivers/i2c/chips/Makefile linux-2.5.68-it87/drivers=
/i2c/chips/Makefile
--- linux-2.5.68/drivers/i2c/chips/Makefile	2003-04-24 09:46:03.000000000 -=
0500
+++ linux-2.5.68-it87/drivers/i2c/chips/Makefile	2003-04-24 09:55:21.000000=
000 -0500
@@ -6,3 +6,4 @@
 obj-$(CONFIG_SENSORS_LM75)	+=3D lm75.o
 obj-$(CONFIG_SENSORS_VIA686A)	+=3D via686a.o
 obj-$(CONFIG_SENSORS_W83781D)	+=3D w83781d.o
+obj-$(CONFIG_SENSORS_IT87)	+=3D it87.o

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--LQ77YLfPrO/qF/pM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+p/w5NLPgdTuQ3+QRAuuxAJkBKiuvGrs89ROGQaIJ7p5jT11/4wCffdLk
aw3N4zD5jt+MByYzXfrwMTQ=
=L5eH
-----END PGP SIGNATURE-----

--LQ77YLfPrO/qF/pM--
