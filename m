Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVGaTwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVGaTwO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 15:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVGaTwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 15:52:14 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:15379 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S261956AbVGaTwE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 15:52:04 -0400
Date: Sun, 31 Jul 2005 21:52:01 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH 2.6] (7/11) hwmon vs i2c, second round
Message-Id: <20050731215201.099ba239.khali@linux-fr.org>
In-Reply-To: <20050731205933.2e2a957f.khali@linux-fr.org>
References: <20050731205933.2e2a957f.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only part left in i2c-sensor is the VRM/VRD/VID handling code.
This is in no way related to i2c, so it doesn't belong there. Move
the code to hwmon, where it belongs.

Note that not all hardware monitoring drivers do VRM/VRD/VID
operations, so less drivers depend on hwmon-vid than there were
depending on i2c-sensor.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 Documentation/i2c/porting-clients |    4 +
 drivers/hwmon/Kconfig             |   50 +++++-----------
 drivers/hwmon/Makefile            |    1 
 drivers/hwmon/adm1025.c           |    4 -
 drivers/hwmon/adm1026.c           |    6 +-
 drivers/hwmon/adm9240.c           |    4 -
 drivers/hwmon/asb100.c            |    4 -
 drivers/hwmon/atxp1.c             |    4 -
 drivers/hwmon/gl520sm.c           |    4 -
 drivers/hwmon/hwmon-vid.c         |  103 ++++++++++++++++++++++++++++++++++
 drivers/hwmon/it87.c              |    6 +-
 drivers/hwmon/lm85.c              |    4 -
 drivers/hwmon/lm87.c              |    4 -
 drivers/hwmon/pc87360.c           |    2 
 drivers/hwmon/w83627hf.c          |    4 -
 drivers/hwmon/w83781d.c           |    4 -
 drivers/hwmon/w83792d.c           |    1 
 drivers/i2c/Makefile              |    4 -
 drivers/i2c/chips/Kconfig         |   10 ---
 drivers/i2c/i2c-sensor-vid.c      |  103 ----------------------------------
 include/linux/hwmon-vid.h         |  112 ++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-vid.h           |  111 -------------------------------------
 22 files changed, 260 insertions(+), 289 deletions(-)

--- linux-2.6.13-rc4.orig/Documentation/i2c/porting-clients	2005-07-31 16:59:10.000000000 +0200
+++ linux-2.6.13-rc4/Documentation/i2c/porting-clients	2005-07-31 20:55:51.000000000 +0200
@@ -23,7 +23,9 @@
   #include <linux/init.h>
   #include <linux/slab.h>
   #include <linux/i2c.h>
-  #include <linux/i2c-vid.h>	/* if you need VRM support */
+  #include <linux/hwmon.h>	/* for hardware monitoring drivers */
+  #include <linux/hwmon-sysfs.h>
+  #include <linux/hwmon-vid.h>	/* if you need VRM support */
   #include <asm/io.h>		/* if you have I/O operations */
   Please respect this inclusion order. Some extra headers may be
   required for a given driver (e.g. "lm75.h").
--- linux-2.6.13-rc4.orig/drivers/hwmon/Kconfig	2005-07-31 14:25:04.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/Kconfig	2005-07-31 20:55:51.000000000 +0200
@@ -19,10 +19,13 @@
 	  This support can also be built as a module.  If so, the module
 	  will be called hwmon.
 
+config HWMON_VID
+	tristate
+	default n
+
 config SENSORS_ADM1021
 	tristate "Analog Devices ADM1021 and compatibles"
 	depends on HWMON && I2C
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Analog Devices ADM1021
 	  and ADM1023 sensor chips and clones: Maxim MAX1617 and MAX1617A,
@@ -35,7 +38,7 @@
 config SENSORS_ADM1025
 	tristate "Analog Devices ADM1025 and compatibles"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
+	select HWMON_VID
 	help
 	  If you say yes here you get support for Analog Devices ADM1025
 	  and Philips NE1619 sensor chips.
@@ -46,7 +49,7 @@
 config SENSORS_ADM1026
 	tristate "Analog Devices ADM1026 and compatibles"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
+	select HWMON_VID
 	help
 	  If you say yes here you get support for Analog Devices ADM1026
 	  sensor chip.
@@ -57,7 +60,6 @@
 config SENSORS_ADM1031
 	tristate "Analog Devices ADM1031 and compatibles"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Analog Devices ADM1031
 	  and ADM1030 sensor chips.
@@ -68,7 +70,7 @@
 config SENSORS_ADM9240
 	tristate "Analog Devices ADM9240 and compatibles"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
+	select HWMON_VID
 	help
 	  If you say yes here you get support for Analog Devices ADM9240,
 	  Dallas DS1780, National Semiconductor LM81 sensor chips.
@@ -79,7 +81,7 @@
 config SENSORS_ASB100
 	tristate "Asus ASB100 Bach"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
+	select HWMON_VID
 	help
 	  If you say yes here you get support for the ASB100 Bach sensor
 	  chip found on some Asus mainboards.
@@ -90,7 +92,7 @@
 config SENSORS_ATXP1
 	tristate "Attansic ATXP1 VID controller"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
+	select HWMON_VID
 	help
 	  If you say yes here you get support for the Attansic ATXP1 VID
 	  controller.
@@ -104,7 +106,6 @@
 config SENSORS_DS1621
 	tristate "Dallas Semiconductor DS1621 and DS1625"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Dallas Semiconductor
 	  DS1621 and DS1625 sensor chips.
@@ -115,7 +116,6 @@
 config SENSORS_FSCHER
 	tristate "FSC Hermes"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Fujitsu Siemens
 	  Computers Hermes sensor chips.
@@ -126,7 +126,6 @@
 config SENSORS_FSCPOS
 	tristate "FSC Poseidon"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Fujitsu Siemens
 	  Computers Poseidon sensor chips.
@@ -137,7 +136,6 @@
 config SENSORS_GL518SM
 	tristate "Genesys Logic GL518SM"
 	depends on HWMON && I2C
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Genesys Logic GL518SM
 	  sensor chips.
@@ -148,7 +146,7 @@
 config SENSORS_GL520SM
 	tristate "Genesys Logic GL520SM"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
+	select HWMON_VID
 	help
 	  If you say yes here you get support for Genesys Logic GL520SM
 	  sensor chips.
@@ -159,8 +157,8 @@
 config SENSORS_IT87
 	tristate "ITE IT87xx and compatibles"
 	depends on HWMON && I2C
-	select I2C_SENSOR
 	select I2C_ISA
+	select HWMON_VID
 	help
 	  If you say yes here you get support for ITE IT87xx sensor chips
 	  and clones: SiS960.
@@ -171,7 +169,6 @@
 config SENSORS_LM63
 	tristate "National Semiconductor LM63"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for the National Semiconductor
 	  LM63 remote diode digital temperature sensor with integrated fan
@@ -184,7 +181,6 @@
 config SENSORS_LM75
 	tristate "National Semiconductor LM75 and compatibles"
 	depends on HWMON && I2C
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM75
 	  sensor chips and clones: Dallas Semiconductor DS75 and DS1775 (in
@@ -200,7 +196,6 @@
 config SENSORS_LM77
 	tristate "National Semiconductor LM77"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM77
 	  sensor chips.
@@ -211,7 +206,6 @@
 config SENSORS_LM78
 	tristate "National Semiconductor LM78 and compatibles"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	select I2C_ISA
 	help
 	  If you say yes here you get support for National Semiconductor LM78,
@@ -223,7 +217,6 @@
 config SENSORS_LM80
 	tristate "National Semiconductor LM80"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor
 	  LM80 sensor chips.
@@ -234,7 +227,6 @@
 config SENSORS_LM83
 	tristate "National Semiconductor LM83"
 	depends on HWMON && I2C
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor
 	  LM83 sensor chips.
@@ -245,7 +237,7 @@
 config SENSORS_LM85
 	tristate "National Semiconductor LM85 and compatibles"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
+	select HWMON_VID
 	help
 	  If you say yes here you get support for National Semiconductor LM85
 	  sensor chips and clones: ADT7463, EMC6D100, EMC6D102 and ADM1027.
@@ -256,7 +248,7 @@
 config SENSORS_LM87
 	tristate "National Semiconductor LM87"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
+	select HWMON_VID
 	help
 	  If you say yes here you get support for National Semiconductor LM87
 	  sensor chips.
@@ -267,7 +259,6 @@
 config SENSORS_LM90
 	tristate "National Semiconductor LM90 and compatibles"
 	depends on HWMON && I2C
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM90,
 	  LM86, LM89 and LM99, Analog Devices ADM1032 and Maxim MAX6657 and
@@ -282,7 +273,6 @@
 config SENSORS_LM92
 	tristate "National Semiconductor LM92 and compatibles"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for National Semiconductor LM92
 	  and Maxim MAX6635 sensor chips.
@@ -293,7 +283,6 @@
 config SENSORS_MAX1619
 	tristate "Maxim MAX1619 sensor chip"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for MAX1619 sensor chip.
 
@@ -303,8 +292,8 @@
 config SENSORS_PC87360
 	tristate "National Semiconductor PC87360 family"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	select I2C_ISA
+	select HWMON_VID
 	help
 	  If you say yes here you get access to the hardware monitoring
 	  functions of the National Semiconductor PC8736x Super-I/O chips.
@@ -318,7 +307,6 @@
 config SENSORS_SIS5595
 	tristate "Silicon Integrated Systems Corp. SiS5595"
 	depends on HWMON && I2C && PCI && EXPERIMENTAL
-	select I2C_SENSOR
 	select I2C_ISA
 	help
 	  If you say yes here you get support for the integrated sensors in
@@ -330,7 +318,6 @@
 config SENSORS_SMSC47M1
 	tristate "SMSC LPC47M10x and compatibles"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	select I2C_ISA
 	help
 	  If you say yes here you get support for the integrated fan
@@ -343,7 +330,6 @@
 config SENSORS_SMSC47B397
 	tristate "SMSC LPC47B397-NC"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	select I2C_ISA
 	help
 	  If you say yes here you get support for the SMSC LPC47B397-NC
@@ -355,7 +341,6 @@
 config SENSORS_VIA686A
 	tristate "VIA686A"
 	depends on HWMON && I2C && PCI
-	select I2C_SENSOR
 	select I2C_ISA
 	help
 	  If you say yes here you get support for the integrated sensors in
@@ -367,8 +352,8 @@
 config SENSORS_W83781D
 	tristate "Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
 	depends on HWMON && I2C
-	select I2C_SENSOR
 	select I2C_ISA
+	select HWMON_VID
 	help
 	  If you say yes here you get support for the Winbond W8378x series
 	  of sensor chips: the W83781D, W83782D, W83783S and W83627HF,
@@ -380,7 +365,6 @@
 config SENSORS_W83792D
 	tristate "Winbond W83792D"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for the Winbond W83792D chip.
 	  
@@ -390,7 +374,6 @@
 config SENSORS_W83L785TS
 	tristate "Winbond W83L785TS-S"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for the Winbond W83L785TS-S
 	  sensor chip, which is used on the Asus A7N8X, among other
@@ -402,8 +385,8 @@
 config SENSORS_W83627HF
 	tristate "Winbond W83627HF, W83627THF, W83637HF, W83697HF"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	select I2C_ISA
+	select HWMON_VID
 	help
 	  If you say yes here you get support for the Winbond W836X7 series
 	  of sensor chips: the W83627HF, W83627THF, W83637HF, and the W83697HF
@@ -414,7 +397,6 @@
 config SENSORS_W83627EHF
 	tristate "Winbond W83627EHF"
 	depends on HWMON && I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	select I2C_ISA
 	help
 	  If you say yes here you get preliminary support for the hardware
--- linux-2.6.13-rc4.orig/drivers/hwmon/Makefile	2005-07-31 14:25:04.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/Makefile	2005-07-31 20:55:51.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 obj-$(CONFIG_HWMON)		+= hwmon.o
+obj-$(CONFIG_HWMON_VID)		+= hwmon-vid.o
 
 # asb100, then w83781d go first, as they can override other drivers' addresses.
 obj-$(CONFIG_SENSORS_ASB100)	+= asb100.o
--- linux-2.6.13-rc4.orig/drivers/hwmon/adm1025.c	2005-07-31 16:59:10.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/adm1025.c	2005-07-31 20:55:51.000000000 +0200
@@ -50,8 +50,8 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 
 /*
@@ -473,7 +473,7 @@
 	struct adm1025_data *data = i2c_get_clientdata(client);
 	int i;
 
-	data->vrm = i2c_which_vrm();
+	data->vrm = vid_which_vrm();
 
 	/*
 	 * Set high limits
--- linux-2.6.13-rc4.orig/drivers/hwmon/adm1026.c	2005-07-31 16:59:10.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/adm1026.c	2005-07-31 20:55:51.000000000 +0200
@@ -28,9 +28,9 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-vid.h>
-#include <linux/hwmon-sysfs.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 
 /* Addresses to scan */
@@ -1552,7 +1552,7 @@
 		goto exitfree;
 
 	/* Set the VRM version */
-	data->vrm = i2c_which_vrm();
+	data->vrm = vid_which_vrm();
 
 	/* Initialize the ADM1026 chip */
 	adm1026_init_client(new_client);
--- linux-2.6.13-rc4.orig/drivers/hwmon/adm9240.c	2005-07-31 16:59:10.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/adm9240.c	2005-07-31 20:55:51.000000000 +0200
@@ -45,8 +45,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 
 /* Addresses to scan */
@@ -657,7 +657,7 @@
 	u8 conf = adm9240_read_value(client, ADM9240_REG_CONFIG);
 	u8 mode = adm9240_read_value(client, ADM9240_REG_TEMP_CONF) & 3;
 
-	data->vrm = i2c_which_vrm(); /* need this to report vid as mV */
+	data->vrm = vid_which_vrm(); /* need this to report vid as mV */
 
 	dev_info(&client->dev, "Using VRM: %d.%d\n", data->vrm / 10,
 			data->vrm % 10);
--- linux-2.6.13-rc4.orig/drivers/hwmon/asb100.c	2005-07-31 16:59:10.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/asb100.c	2005-07-31 20:55:51.000000000 +0200
@@ -39,8 +39,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
@@ -973,7 +973,7 @@
 
 	vid = asb100_read_value(client, ASB100_REG_VID_FANDIV) & 0x0f;
 	vid |= (asb100_read_value(client, ASB100_REG_CHIPID) & 0x01) << 4;
-	data->vrm = i2c_which_vrm();
+	data->vrm = vid_which_vrm();
 	vid = vid_from_reg(vid, data->vrm);
 
 	/* Start monitoring */
--- linux-2.6.13-rc4.orig/drivers/hwmon/atxp1.c	2005-07-31 16:59:10.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/atxp1.c	2005-07-31 20:55:51.000000000 +0200
@@ -23,8 +23,8 @@
 #include <linux/module.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 
 MODULE_LICENSE("GPL");
@@ -296,7 +296,7 @@
 	}
 
 	/* Get VRM */
-	data->vrm = i2c_which_vrm();
+	data->vrm = vid_which_vrm();
 
 	if ((data->vrm != 90) && (data->vrm != 91)) {
 		dev_err(&new_client->dev, "Not supporting VRM %d.%d\n",
--- linux-2.6.13-rc4.orig/drivers/hwmon/gl520sm.c	2005-07-31 16:59:10.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/gl520sm.c	2005-07-31 20:55:51.000000000 +0200
@@ -26,8 +26,8 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 
 /* Type of the extra sensor */
@@ -617,7 +617,7 @@
 	conf = oldconf = gl520_read_value(client, GL520_REG_CONF);
 
 	data->alarm_mask = 0xff;
-	data->vrm = i2c_which_vrm();
+	data->vrm = vid_which_vrm();
 
 	if (extra_sensor_type == 1)
 		conf &= ~0x10;
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13-rc4/drivers/hwmon/hwmon-vid.c	2005-07-31 20:55:51.000000000 +0200
@@ -0,0 +1,103 @@
+/*
+    hwmon-vid.c - VID/VRM/VRD voltage conversions
+
+    Copyright (c) 2004 Rudolf Marek <r.marek@sh.cvut.cz>
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
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/hwmon-vid.h>
+
+struct vrm_model {
+	u8 vendor;
+	u8 eff_family;
+	u8 eff_model;
+	int vrm_type;
+};
+
+#define ANY 0xFF
+
+#ifdef CONFIG_X86
+
+static struct vrm_model vrm_models[] = {
+	{X86_VENDOR_AMD, 0x6, ANY, 90},		/* Athlon Duron etc */
+	{X86_VENDOR_AMD, 0xF, ANY, 24},		/* Athlon 64, Opteron */
+	{X86_VENDOR_INTEL, 0x6, 0x9, 85},	/* 0.13um too */
+	{X86_VENDOR_INTEL, 0x6, 0xB, 85},	/* 0xB Tualatin */
+	{X86_VENDOR_INTEL, 0x6, ANY, 82},	/* any P6 */
+	{X86_VENDOR_INTEL, 0x7, ANY, 0},	/* Itanium */
+	{X86_VENDOR_INTEL, 0xF, 0x3, 100},	/* P4 Prescott */
+	{X86_VENDOR_INTEL, 0xF, ANY, 90},	/* P4 before Prescott */
+	{X86_VENDOR_INTEL, 0x10,ANY, 0},	/* Itanium 2 */
+	{X86_VENDOR_UNKNOWN, ANY, ANY, 0}	/* stop here */
+	};
+
+static int find_vrm(u8 eff_family, u8 eff_model, u8 vendor)
+{
+	int i = 0;
+
+	while (vrm_models[i].vendor!=X86_VENDOR_UNKNOWN) {
+		if (vrm_models[i].vendor==vendor)
+			if ((vrm_models[i].eff_family==eff_family)&& \
+			((vrm_models[i].eff_model==eff_model)|| \
+			(vrm_models[i].eff_model==ANY)))
+				return vrm_models[i].vrm_type;
+		i++;
+	}
+
+	return 0;
+}
+
+int vid_which_vrm(void)
+{
+	struct cpuinfo_x86 *c = cpu_data;
+	u32 eax;
+	u8 eff_family, eff_model;
+	int vrm_ret;
+
+	if (c->x86 < 6) return 0;	/* any CPU with familly lower than 6
+				 	dont have VID and/or CPUID */
+	eax = cpuid_eax(1);
+	eff_family = ((eax & 0x00000F00)>>8);
+	eff_model  = ((eax & 0x000000F0)>>4);
+	if (eff_family == 0xF) {	/* use extended model & family */
+		eff_family += ((eax & 0x00F00000)>>20);
+		eff_model += ((eax & 0x000F0000)>>16)<<4;
+	}
+	vrm_ret = find_vrm(eff_family,eff_model,c->x86_vendor);
+	if (vrm_ret == 0)
+		printk(KERN_INFO "hwmon-vid: Unknown VRM version of your"
+		" x86 CPU\n");
+	return vrm_ret;
+}
+
+/* and now for something completely different for Non-x86 world*/
+#else
+int vid_which_vrm(void)
+{
+	printk(KERN_INFO "hwmon-vid: Unknown VRM version of your CPU\n");
+	return 0;
+}
+#endif
+
+EXPORT_SYMBOL(vid_which_vrm);
+
+MODULE_AUTHOR("Rudolf Marek <r.marek@sh.cvut.cz>");
+
+MODULE_DESCRIPTION("hwmon-vid driver");
+MODULE_LICENSE("GPL");
--- linux-2.6.13-rc4.orig/drivers/hwmon/it87.c	2005-07-31 16:59:10.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/it87.c	2005-07-31 20:55:51.000000000 +0200
@@ -37,9 +37,9 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-isa.h>
-#include <linux/i2c-vid.h>
-#include <linux/hwmon-sysfs.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <asm/io.h>
 
@@ -919,7 +919,7 @@
 	}
 
 	if (data->type == it8712) {
-		data->vrm = i2c_which_vrm();
+		data->vrm = vid_which_vrm();
 		device_create_file_vrm(new_client);
 		device_create_file_vid(new_client);
 	}
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm85.c	2005-07-31 16:59:10.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm85.c	2005-07-31 20:55:51.000000000 +0200
@@ -28,8 +28,8 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 
 /* Addresses to scan */
@@ -1147,7 +1147,7 @@
 		goto ERROR1;
 
 	/* Set the VRM version */
-	data->vrm = i2c_which_vrm();
+	data->vrm = vid_which_vrm();
 
 	/* Initialize the LM85 chip */
 	lm85_init_client(new_client);
--- linux-2.6.13-rc4.orig/drivers/hwmon/lm87.c	2005-07-31 16:59:10.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/lm87.c	2005-07-31 20:55:51.000000000 +0200
@@ -57,8 +57,8 @@
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
-#include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 
 /*
@@ -694,7 +694,7 @@
 	u8 config;
 
 	data->channel = lm87_read_value(client, LM87_REG_CHANNEL_MODE);
-	data->vrm = i2c_which_vrm();
+	data->vrm = vid_which_vrm();
 
 	config = lm87_read_value(client, LM87_REG_CONFIG);
 	if (!(config & 0x01)) {
--- linux-2.6.13-rc4.orig/drivers/hwmon/pc87360.c	2005-07-31 14:25:04.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/pc87360.c	2005-07-31 20:55:51.000000000 +0200
@@ -39,8 +39,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-isa.h>
-#include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <asm/io.h>
 
--- linux-2.6.13-rc4.orig/drivers/hwmon/w83627hf.c	2005-07-31 16:59:10.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/w83627hf.c	2005-07-31 20:55:51.000000000 +0200
@@ -43,8 +43,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-isa.h>
-#include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <asm/io.h>
 #include "lm75.h"
@@ -1316,7 +1316,7 @@
 		data->vrm = (data->vrm_ovt & 0x01) ? 90 : 82;
 	} else {
 		/* Convert VID to voltage based on default VRM */
-		data->vrm = i2c_which_vrm();
+		data->vrm = vid_which_vrm();
 	}
 
 	tmp = w83627hf_read_value(client, W83781D_REG_SCFG1);
--- linux-2.6.13-rc4.orig/drivers/hwmon/w83781d.c	2005-07-31 16:59:10.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/w83781d.c	2005-07-31 20:55:51.000000000 +0200
@@ -39,8 +39,8 @@
 #include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-isa.h>
-#include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <asm/io.h>
 #include "lm75.h"
@@ -1478,7 +1478,7 @@
 		w83781d_write_value(client, W83781D_REG_BEEP_INTS2, 0);
 	}
 
-	data->vrm = i2c_which_vrm();
+	data->vrm = vid_which_vrm();
 
 	if ((type != w83781d) && (type != as99127f)) {
 		tmp = w83781d_read_value(client, W83781D_REG_SCFG1);
--- linux-2.6.13-rc4.orig/drivers/hwmon/w83792d.c	2005-07-31 16:59:10.000000000 +0200
+++ linux-2.6.13-rc4/drivers/hwmon/w83792d.c	2005-07-31 20:55:51.000000000 +0200
@@ -40,7 +40,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c-vid.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
--- linux-2.6.13-rc4.orig/drivers/i2c/Makefile	2005-07-31 16:10:11.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/Makefile	2005-07-31 20:55:51.000000000 +0200
@@ -4,12 +4,8 @@
 
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
-obj-$(CONFIG_I2C_SENSOR)	+= i2c-sensor.o
 obj-y				+= busses/ chips/ algos/
 
-i2c-sensor-objs := i2c-sensor-vid.o
-
-
 ifeq ($(CONFIG_I2C_DEBUG_CORE),y)
 EXTRA_CFLAGS += -DDEBUG
 endif
--- linux-2.6.13-rc4.orig/drivers/i2c/chips/Kconfig	2005-07-31 14:25:04.000000000 +0200
+++ linux-2.6.13-rc4/drivers/i2c/chips/Kconfig	2005-07-31 20:55:51.000000000 +0200
@@ -2,17 +2,12 @@
 # Miscellaneous I2C chip drivers configuration
 #
 
-config I2C_SENSOR
-	tristate
-	default n
-
 menu "Miscellaneous I2C Chip support"
 	depends on I2C
 
 config SENSORS_DS1337
 	tristate "Dallas Semiconductor DS1337 and DS1339 Real Time Clock"
 	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Dallas Semiconductor
 	  DS1337 and DS1339 real-time clock chips.
@@ -23,7 +18,6 @@
 config SENSORS_DS1374
 	tristate "Maxim/Dallas Semiconductor DS1374 Real Time Clock"
 	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Dallas Semiconductor
 	  DS1374 real-time clock chips.
@@ -34,7 +28,6 @@
 config SENSORS_EEPROM
 	tristate "EEPROM reader"
 	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get read-only access to the EEPROM data
 	  available on modern memory DIMMs and Sony Vaio laptops.  Such
@@ -46,7 +39,6 @@
 config SENSORS_PCF8574
 	tristate "Philips PCF8574 and PCF8574A"
 	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Philips PCF8574 and 
 	  PCF8574A chips.
@@ -67,7 +59,6 @@
 config SENSORS_PCF8591
 	tristate "Philips PCF8591"
 	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for Philips PCF8591 chips.
 
@@ -77,7 +68,6 @@
 config SENSORS_RTC8564
 	tristate "Epson 8564 RTC chip"
 	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
 	help
 	  If you say yes here you get support for the Epson 8564 RTC chip.
 
--- linux-2.6.13-rc4.orig/drivers/i2c/i2c-sensor-vid.c	2005-07-31 16:10:11.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,103 +0,0 @@
-/*
-    i2c-sensor-vid.c -  Part of lm_sensors, Linux kernel modules for hardware
-        		monitoring
-
-    Copyright (c) 2004 Rudolf Marek <r.marek@sh.cvut.cz>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-
-struct vrm_model {
-	u8 vendor;
-	u8 eff_family;
-	u8 eff_model;
-	int vrm_type;
-};
-
-#define ANY 0xFF
-
-#ifdef CONFIG_X86
-
-static struct vrm_model vrm_models[] = {
-	{X86_VENDOR_AMD, 0x6, ANY, 90},		/* Athlon Duron etc */
-	{X86_VENDOR_AMD, 0xF, ANY, 24},		/* Athlon 64, Opteron */
-	{X86_VENDOR_INTEL, 0x6, 0x9, 85},	/* 0.13um too */
-	{X86_VENDOR_INTEL, 0x6, 0xB, 85},	/* 0xB Tualatin */
-	{X86_VENDOR_INTEL, 0x6, ANY, 82},	/* any P6 */
-	{X86_VENDOR_INTEL, 0x7, ANY, 0},	/* Itanium */
-	{X86_VENDOR_INTEL, 0xF, 0x3, 100},	/* P4 Prescott */
-	{X86_VENDOR_INTEL, 0xF, ANY, 90},	/* P4 before Prescott */
-	{X86_VENDOR_INTEL, 0x10,ANY, 0},	/* Itanium 2 */
-	{X86_VENDOR_UNKNOWN, ANY, ANY, 0}	/* stop here */
-	};
-
-static int find_vrm(u8 eff_family, u8 eff_model, u8 vendor)
-{
-	int i = 0;
-
-	while (vrm_models[i].vendor!=X86_VENDOR_UNKNOWN) {
-		if (vrm_models[i].vendor==vendor)
-			if ((vrm_models[i].eff_family==eff_family)&& \
-			((vrm_models[i].eff_model==eff_model)|| \
-			(vrm_models[i].eff_model==ANY)))
-				return vrm_models[i].vrm_type;
-		i++;
-	}
-
-	return 0;
-}
-
-int i2c_which_vrm(void)
-{
-	struct cpuinfo_x86 *c = cpu_data;
-	u32 eax;
-	u8 eff_family, eff_model;
-	int vrm_ret;
-
-	if (c->x86 < 6) return 0;	/* any CPU with familly lower than 6
-				 	dont have VID and/or CPUID */
-	eax = cpuid_eax(1);
-	eff_family = ((eax & 0x00000F00)>>8);
-	eff_model  = ((eax & 0x000000F0)>>4);
-	if (eff_family == 0xF) {	/* use extended model & family */
-		eff_family += ((eax & 0x00F00000)>>20);
-		eff_model += ((eax & 0x000F0000)>>16)<<4;
-	}
-	vrm_ret = find_vrm(eff_family,eff_model,c->x86_vendor);
-	if (vrm_ret == 0)
-		printk(KERN_INFO "i2c-sensor.o: Unknown VRM version of your"
-		" x86 CPU\n");
-	return vrm_ret;
-}
-
-/* and now for something completely different for Non-x86 world*/
-#else
-int i2c_which_vrm(void)
-{
-	printk(KERN_INFO "i2c-sensor.o: Unknown VRM version of your CPU\n");
-	return 0;
-}
-#endif
-
-EXPORT_SYMBOL(i2c_which_vrm);
-
-MODULE_AUTHOR("Rudolf Marek <r.marek@sh.cvut.cz>");
-
-MODULE_DESCRIPTION("i2c-sensor driver");
-MODULE_LICENSE("GPL");
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.13-rc4/include/linux/hwmon-vid.h	2005-07-31 20:55:51.000000000 +0200
@@ -0,0 +1,112 @@
+/*
+    hwmon-vid.h - VID/VRM/VRD voltage conversions
+
+    Originally part of lm_sensors
+    Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
+    With assistance from Trent Piepho <xyzzy@speakeasy.org>
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
+    This file contains common code for decoding VID pins.
+    This file is #included in various chip drivers in this directory.
+    As the user is unlikely to load more than one driver which
+    includes this code we don't worry about the wasted space.
+    Reference: VRM x.y DC-DC Converter Design Guidelines,
+    available at http://developer.intel.com
+*/
+
+/*
+    AMD Opteron processors don't follow the Intel VRM spec.
+    I'm going to "make up" 2.4 as the VRM spec for the Opterons.
+    No good reason just a mnemonic for the 24x Opteron processor
+    series
+
+    Opteron VID encoding is:
+
+       00000  =  1.550 V
+       00001  =  1.525 V
+        . . . .
+       11110  =  0.800 V
+       11111  =  0.000 V (off)
+ */
+
+/*
+    Legal val values 0x00 - 0x1f; except for VRD 10.0, 0x00 - 0x3f.
+    vrm is the Intel VRM document version.
+    Note: vrm version is scaled by 10 and the return value is scaled by 1000
+    to avoid floating point in the kernel.
+*/
+
+int vid_which_vrm(void);
+
+#define DEFAULT_VRM	82
+
+static inline int vid_from_reg(int val, int vrm)
+{
+	int vid;
+
+	switch(vrm) {
+
+	case  0:
+		return 0;
+
+	case 100:               /* VRD 10.0 */
+		if((val & 0x1f) == 0x1f)
+			return 0;
+		if((val & 0x1f) <= 0x09 || val == 0x0a)
+			vid = 10875 - (val & 0x1f) * 250;
+		else
+			vid = 18625 - (val & 0x1f) * 250;
+		if(val & 0x20)
+			vid -= 125;
+		vid /= 10;      /* only return 3 dec. places for now */
+		return vid;
+
+	case 24:                /* Opteron processor */
+		return(val == 0x1f ? 0 : 1550 - val * 25);
+
+	case 91:		/* VRM 9.1 */
+	case 90:		/* VRM 9.0 */
+		return(val == 0x1f ? 0 :
+		                       1850 - val * 25);
+
+	case 85:		/* VRM 8.5 */
+		return((val & 0x10  ? 25 : 0) +
+		       ((val & 0x0f) > 0x04 ? 2050 : 1250) -
+		       ((val & 0x0f) * 50));
+
+	case 84:		/* VRM 8.4 */
+		val &= 0x0f;
+				/* fall through */
+	default:		/* VRM 8.2 */
+		return(val == 0x1f ? 0 :
+		       val & 0x10  ? 5100 - (val) * 100 :
+		                     2050 - (val) * 50);
+	}
+}
+
+static inline int vid_to_reg(int val, int vrm)
+{
+	switch (vrm) {
+	case 91:		/* VRM 9.1 */
+	case 90:		/* VRM 9.0 */
+		return ((val >= 1100) && (val <= 1850) ?
+			((18499 - val * 10) / 25 + 5) / 10 : -1);
+	default:
+		return -1;
+	}
+}
--- linux-2.6.13-rc4.orig/include/linux/i2c-vid.h	2005-07-31 14:25:04.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,111 +0,0 @@
-/*
-    i2c-vid.h - Part of lm_sensors, Linux kernel modules for hardware
-                monitoring
-    Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
-    With assistance from Trent Piepho <xyzzy@speakeasy.org>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
-
-/*
-    This file contains common code for decoding VID pins.
-    This file is #included in various chip drivers in this directory.
-    As the user is unlikely to load more than one driver which
-    includes this code we don't worry about the wasted space.
-    Reference: VRM x.y DC-DC Converter Design Guidelines,
-    available at http://developer.intel.com
-*/
-
-/*
-    AMD Opteron processors don't follow the Intel VRM spec.
-    I'm going to "make up" 2.4 as the VRM spec for the Opterons.
-    No good reason just a mnemonic for the 24x Opteron processor
-    series
-
-    Opteron VID encoding is:
-
-       00000  =  1.550 V
-       00001  =  1.525 V
-        . . . .
-       11110  =  0.800 V
-       11111  =  0.000 V (off)
- */
-
-/*
-    Legal val values 0x00 - 0x1f; except for VRD 10.0, 0x00 - 0x3f.
-    vrm is the Intel VRM document version.
-    Note: vrm version is scaled by 10 and the return value is scaled by 1000
-    to avoid floating point in the kernel.
-*/
-
-int i2c_which_vrm(void);
-
-#define DEFAULT_VRM	82
-
-static inline int vid_from_reg(int val, int vrm)
-{
-	int vid;
-
-	switch(vrm) {
-
-	case  0:
-		return 0;
-
-	case 100:               /* VRD 10.0 */
-		if((val & 0x1f) == 0x1f)
-			return 0;
-		if((val & 0x1f) <= 0x09 || val == 0x0a)
-			vid = 10875 - (val & 0x1f) * 250;
-		else
-			vid = 18625 - (val & 0x1f) * 250;
-		if(val & 0x20)
-			vid -= 125;
-		vid /= 10;      /* only return 3 dec. places for now */
-		return vid;
-
-	case 24:                /* Opteron processor */
-		return(val == 0x1f ? 0 : 1550 - val * 25);
-
-	case 91:		/* VRM 9.1 */
-	case 90:		/* VRM 9.0 */
-		return(val == 0x1f ? 0 :
-		                       1850 - val * 25);
-
-	case 85:		/* VRM 8.5 */
-		return((val & 0x10  ? 25 : 0) +
-		       ((val & 0x0f) > 0x04 ? 2050 : 1250) -
-		       ((val & 0x0f) * 50));
-
-	case 84:		/* VRM 8.4 */
-		val &= 0x0f;
-				/* fall through */
-	default:		/* VRM 8.2 */
-		return(val == 0x1f ? 0 :
-		       val & 0x10  ? 5100 - (val) * 100 :
-		                     2050 - (val) * 50);
-	}
-}
-
-static inline int vid_to_reg(int val, int vrm)
-{
-	switch (vrm) {
-	case 91:		/* VRM 9.1 */
-	case 90:		/* VRM 9.0 */
-		return ((val >= 1100) && (val <= 1850) ?
-			((18499 - val * 10) / 25 + 5) / 10 : -1);
-	default:
-		return -1;
-	}
-}


-- 
Jean Delvare
