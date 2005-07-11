Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262847AbVGKWJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262847AbVGKWJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbVGKWGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:06:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:221 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262892AbVGKWDy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:03:54 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Move hwmon drivers (1/3)
In-Reply-To: <11211193783332@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 11 Jul 2005 15:02:58 -0700
Message-Id: <11211193783106@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Move hwmon drivers (1/3)

Part 1: Configuration files and Makefiles.

From: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ad2f931dcb41bcfae38cc77d78b7821dfef83cf2
tree 344940f7ce52d94cf9bdd862409c63ebeb9bfa3a
parent 0e65f82814e9828d3ff54988de9e7c0b36794daa
author Jean Delvare <khali@linux-fr.org> Sat, 02 Jul 2005 18:15:49 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:14:31 -0700

 arch/arm/Kconfig           |    2 
 arch/h8300/Kconfig         |    2 
 arch/sparc64/Kconfig       |    2 
 drivers/Kconfig            |    2 
 drivers/Makefile           |    1 
 drivers/hwmon/Kconfig      |  420 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/Makefile     |   44 +++++
 drivers/i2c/chips/Kconfig  |  402 ------------------------------------------
 drivers/i2c/chips/Makefile |   38 ----
 9 files changed, 476 insertions(+), 437 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -744,6 +744,8 @@ source "drivers/char/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/hwmon/Kconfig"
+
 #source "drivers/l3/Kconfig"
 
 source "drivers/misc/Kconfig"
diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -179,6 +179,8 @@ source "drivers/serial/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/hwmon/Kconfig"
+
 source "drivers/usb/Kconfig"
 
 endmenu
diff --git a/arch/sparc64/Kconfig b/arch/sparc64/Kconfig
--- a/arch/sparc64/Kconfig
+++ b/arch/sparc64/Kconfig
@@ -647,6 +647,8 @@ source "drivers/input/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/hwmon/Kconfig"
+
 source "fs/Kconfig"
 
 source "drivers/media/Kconfig"
diff --git a/drivers/Kconfig b/drivers/Kconfig
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -44,6 +44,8 @@ source "drivers/i2c/Kconfig"
 
 source "drivers/w1/Kconfig"
 
+source "drivers/hwmon/Kconfig"
+
 source "drivers/misc/Kconfig"
 
 source "drivers/media/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_I2C)		+= i2c/
 obj-$(CONFIG_W1)		+= w1/
+obj-$(CONFIG_HWMON)		+= hwmon/
 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/
 obj-$(CONFIG_BT)		+= bluetooth/
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
new file mode 100644
--- /dev/null
+++ b/drivers/hwmon/Kconfig
@@ -0,0 +1,420 @@
+#
+# I2C Sensor chip drivers configuration
+#
+
+menu "Hardware Monitoring support"
+
+config HWMON
+	tristate "Hardware Monitoring support"
+	default y
+	help
+	  Hardware monitoring devices let you monitor the hardware health
+	  of a system. Most modern motherboards include such a device. It
+	  can include temperature sensors, voltage sensors, fan speed
+	  sensors and various additional features such as the ability to
+	  control the speed of the fans.
+
+config SENSORS_ADM1021
+	tristate "Analog Devices ADM1021 and compatibles"
+	depends on HWMON && I2C
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Analog Devices ADM1021
+	  and ADM1023 sensor chips and clones: Maxim MAX1617 and MAX1617A,
+	  Genesys Logic GL523SM, National Semiconductor LM84, TI THMC10,
+	  and the XEON processor built-in sensor.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called adm1021.
+
+config SENSORS_ADM1025
+	tristate "Analog Devices ADM1025 and compatibles"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Analog Devices ADM1025
+	  and Philips NE1619 sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called adm1025.
+
+config SENSORS_ADM1026
+	tristate "Analog Devices ADM1026 and compatibles"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Analog Devices ADM1026
+	  sensor chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called adm1026.
+
+config SENSORS_ADM1031
+	tristate "Analog Devices ADM1031 and compatibles"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Analog Devices ADM1031
+	  and ADM1030 sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called adm1031.
+
+config SENSORS_ADM9240
+	tristate "Analog Devices ADM9240 and compatibles"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Analog Devices ADM9240,
+	  Dallas DS1780, National Semiconductor LM81 sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called adm9240.
+
+config SENSORS_ASB100
+	tristate "Asus ASB100 Bach"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for the ASB100 Bach sensor
+	  chip found on some Asus mainboards.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called asb100.
+
+config SENSORS_ATXP1
+	tristate "Attansic ATXP1 VID controller"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
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
+config SENSORS_DS1621
+	tristate "Dallas Semiconductor DS1621 and DS1625"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Dallas Semiconductor
+	  DS1621 and DS1625 sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called ds1621.
+
+config SENSORS_FSCHER
+	tristate "FSC Hermes"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Fujitsu Siemens
+	  Computers Hermes sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called fscher.
+
+config SENSORS_FSCPOS
+	tristate "FSC Poseidon"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Fujitsu Siemens
+	  Computers Poseidon sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called fscpos.
+
+config SENSORS_GL518SM
+	tristate "Genesys Logic GL518SM"
+	depends on HWMON && I2C
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Genesys Logic GL518SM
+	  sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called gl518sm.
+
+config SENSORS_GL520SM
+	tristate "Genesys Logic GL520SM"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for Genesys Logic GL520SM
+	  sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called gl520sm.
+
+config SENSORS_IT87
+	tristate "ITE IT87xx and compatibles"
+	depends on HWMON && I2C
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for ITE IT87xx sensor chips
+	  and clones: SiS960.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called it87.
+
+config SENSORS_LM63
+	tristate "National Semiconductor LM63"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for the National Semiconductor
+	  LM63 remote diode digital temperature sensor with integrated fan
+	  control.  Such chips are found on the Tyan S4882 (Thunder K8QS Pro)
+	  motherboard, among others.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm63.
+
+config SENSORS_LM75
+	tristate "National Semiconductor LM75 and compatibles"
+	depends on HWMON && I2C
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for National Semiconductor LM75
+	  sensor chips and clones: Dallas Semiconductor DS75 and DS1775 (in
+	  9-bit precision mode), and TelCom (now Microchip) TCN75.
+
+	  The DS75 and DS1775 in 10- to 12-bit precision modes will require
+	  a force module parameter. The driver will not handle the extra
+	  precision anyhow.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm75.
+
+config SENSORS_LM77
+	tristate "National Semiconductor LM77"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for National Semiconductor LM77
+	  sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm77.
+
+config SENSORS_LM78
+	tristate "National Semiconductor LM78 and compatibles"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for National Semiconductor LM78,
+	  LM78-J and LM79.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm78.
+
+config SENSORS_LM80
+	tristate "National Semiconductor LM80"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for National Semiconductor
+	  LM80 sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm80.
+
+config SENSORS_LM83
+	tristate "National Semiconductor LM83"
+	depends on HWMON && I2C
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for National Semiconductor
+	  LM83 sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm83.
+
+config SENSORS_LM85
+	tristate "National Semiconductor LM85 and compatibles"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for National Semiconductor LM85
+	  sensor chips and clones: ADT7463, EMC6D100, EMC6D102 and ADM1027.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm85.
+
+config SENSORS_LM87
+	tristate "National Semiconductor LM87"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for National Semiconductor LM87
+	  sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm87.
+
+config SENSORS_LM90
+	tristate "National Semiconductor LM90 and compatibles"
+	depends on HWMON && I2C
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for National Semiconductor LM90,
+	  LM86, LM89 and LM99, Analog Devices ADM1032 and Maxim MAX6657 and
+	  MAX6658 sensor chips.
+
+	  The Analog Devices ADT7461 sensor chip is also supported, but only
+	  if found in ADM1032 compatibility mode.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm90.
+
+config SENSORS_LM92
+	tristate "National Semiconductor LM92 and compatibles"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for National Semiconductor LM92
+	  and Maxim MAX6635 sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm92.
+
+config SENSORS_MAX1619
+	tristate "Maxim MAX1619 sensor chip"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for MAX1619 sensor chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called max1619.
+
+config SENSORS_PC87360
+	tristate "National Semiconductor PC87360 family"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	select I2C_ISA
+	help
+	  If you say yes here you get access to the hardware monitoring
+	  functions of the National Semiconductor PC8736x Super-I/O chips.
+	  The PC87360, PC87363 and PC87364 only have fan monitoring and
+	  control.  The PC87365 and PC87366 additionally have voltage and
+	  temperature monitoring.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called pc87360.
+
+config SENSORS_SIS5595
+	tristate "Silicon Integrated Systems Corp. SiS5595"
+	depends on HWMON && I2C && PCI && EXPERIMENTAL
+	select I2C_SENSOR
+	select I2C_ISA
+	help
+	  If you say yes here you get support for the integrated sensors in
+	  SiS5595 South Bridges.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called sis5595.
+
+config SENSORS_SMSC47M1
+	tristate "SMSC LPC47M10x and compatibles"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	select I2C_ISA
+	help
+	  If you say yes here you get support for the integrated fan
+	  monitoring and control capabilities of the SMSC LPC47B27x,
+	  LPC47M10x, LPC47M13x, LPC47M14x, LPC47M15x and LPC47M192 chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called smsc47m1.
+
+config SENSORS_SMSC47B397
+	tristate "SMSC LPC47B397-NC"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	select I2C_ISA
+	help
+	  If you say yes here you get support for the SMSC LPC47B397-NC
+	  sensor chip.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called smsc47b397.
+
+config SENSORS_VIA686A
+	tristate "VIA686A"
+	depends on HWMON && I2C && PCI
+	select I2C_SENSOR
+	select I2C_ISA
+	help
+	  If you say yes here you get support for the integrated sensors in
+	  Via 686A/B South Bridges.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called via686a.
+
+config SENSORS_W83781D
+	tristate "Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
+	depends on HWMON && I2C
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for the Winbond W8378x series
+	  of sensor chips: the W83781D, W83782D, W83783S and W83627HF,
+	  and the similar Asus AS99127F.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called w83781d.
+
+config SENSORS_W83L785TS
+	tristate "Winbond W83L785TS-S"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	help
+	  If you say yes here you get support for the Winbond W83L785TS-S
+	  sensor chip, which is used on the Asus A7N8X, among other
+	  motherboards.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called w83l785ts.
+
+config SENSORS_W83627HF
+	tristate "Winbond W83627HF, W83627THF, W83637HF, W83697HF"
+	depends on HWMON && I2C && EXPERIMENTAL
+	select I2C_SENSOR
+	select I2C_ISA
+	help
+	  If you say yes here you get support for the Winbond W836X7 series
+	  of sensor chips: the W83627HF, W83627THF, W83637HF, and the W83697HF
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called w83627hf.
+
+config SENSORS_W83627EHF
+	tristate "Winbond W83627EHF"
+	depends on HWMON && I2C && EXPERIMENTAL
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
+config HWMON_DEBUG_CHIP
+	bool "Hardware Monitoring Chip debugging messages"
+	depends on HWMON
+	default n
+	help
+	  Say Y here if you want the I2C chip drivers to produce a bunch of
+	  debug messages to the system log.  Select this if you are having
+	  a problem with I2C support and want to see more of what is going
+	  on.
+
+endmenu
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
new file mode 100644
--- /dev/null
+++ b/drivers/hwmon/Makefile
@@ -0,0 +1,44 @@
+#
+# Makefile for sensor chip drivers.
+#
+
+# asb100, then w83781d go first, as they can override other drivers' addresses.
+obj-$(CONFIG_SENSORS_ASB100)	+= asb100.o
+obj-$(CONFIG_SENSORS_W83627HF)	+= w83627hf.o
+obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
+
+obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
+obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
+obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
+obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
+obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
+obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
+obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
+obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
+obj-$(CONFIG_SENSORS_FSCPOS)	+= fscpos.o
+obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
+obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
+obj-$(CONFIG_SENSORS_IT87)	+= it87.o
+obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
+obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
+obj-$(CONFIG_SENSORS_LM77)	+= lm77.o
+obj-$(CONFIG_SENSORS_LM78)	+= lm78.o
+obj-$(CONFIG_SENSORS_LM80)	+= lm80.o
+obj-$(CONFIG_SENSORS_LM83)	+= lm83.o
+obj-$(CONFIG_SENSORS_LM85)	+= lm85.o
+obj-$(CONFIG_SENSORS_LM87)	+= lm87.o
+obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
+obj-$(CONFIG_SENSORS_LM92)	+= lm92.o
+obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
+obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
+obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
+obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
+obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
+obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
+obj-$(CONFIG_SENSORS_W83627EHF)	+= w83627ehf.o
+obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
+
+ifeq ($(CONFIG_HWMON_DEBUG_CHIP),y)
+EXTRA_CFLAGS += -DDEBUG
+endif
+
diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -1,410 +1,12 @@
 #
-# I2C Sensor and "other" chip configuration
+# Miscellaneous I2C chip drivers configuration
 #
 
-menu "Hardware Sensors Chip support"
-	depends on I2C
-
 config I2C_SENSOR
 	tristate
 	default n
 
-config SENSORS_ADM1021
-	tristate "Analog Devices ADM1021 and compatibles"
-	depends on I2C
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for Analog Devices ADM1021 
-	  and ADM1023 sensor chips and clones: Maxim MAX1617 and MAX1617A,
-	  Genesys Logic GL523SM, National Semiconductor LM84, TI THMC10,
-	  and the XEON processor built-in sensor.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called adm1021.
-
-config SENSORS_ADM1025
-	tristate "Analog Devices ADM1025 and compatibles"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for Analog Devices ADM1025
-	  and Philips NE1619 sensor chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called adm1025.
-
-config SENSORS_ADM1026
-	tristate "Analog Devices ADM1026 and compatibles"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for Analog Devices ADM1026
-	  sensor chip.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called adm1026.
-
-config SENSORS_ADM1031
-	tristate "Analog Devices ADM1031 and compatibles"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for Analog Devices ADM1031 
-	  and ADM1030 sensor chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called adm1031.
-
-config SENSORS_ADM9240
-	tristate "Analog Devices ADM9240 and compatibles"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for Analog Devices ADM9240,
-	  Dallas DS1780, National Semiconductor LM81 sensor chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called adm9240.
-
-config SENSORS_ASB100
-	tristate "Asus ASB100 Bach"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for the ASB100 Bach sensor
-	  chip found on some Asus mainboards.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called asb100.
-
-config SENSORS_ATXP1
-	tristate "Attansic ATXP1 VID controller"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for the Attansic ATXP1 VID
-	  controller.
-
-	  If your board have such a chip, you are able to control your CPU
-	  core and other voltages.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called atxp1.
-
-config SENSORS_DS1621
-	tristate "Dallas Semiconductor DS1621 and DS1625"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for Dallas Semiconductor
-	  DS1621 and DS1625 sensor chips. 
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called ds1621.
-
-config SENSORS_FSCHER
-	tristate "FSC Hermes"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for Fujitsu Siemens
-	  Computers Hermes sensor chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called fscher.
-
-config SENSORS_FSCPOS
-	tristate "FSC Poseidon"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for Fujitsu Siemens
-	  Computers Poseidon sensor chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called fscpos.
-
-config SENSORS_GL518SM
-	tristate "Genesys Logic GL518SM"
-	depends on I2C
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for Genesys Logic GL518SM
-	  sensor chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called gl518sm.
-
-config SENSORS_GL520SM
-	tristate "Genesys Logic GL520SM"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for Genesys Logic GL520SM
-	  sensor chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called gl520sm.
-
-config SENSORS_IT87
-	tristate "ITE IT87xx and compatibles"
-	depends on I2C
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for ITE IT87xx sensor chips
-	  and clones: SiS960.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called it87.
-
-config SENSORS_LM63
-	tristate "National Semiconductor LM63"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for the National Semiconductor
-	  LM63 remote diode digital temperature sensor with integrated fan
-	  control.  Such chips are found on the Tyan S4882 (Thunder K8QS Pro)
-	  motherboard, among others.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called lm63.
-
-config SENSORS_LM75
-	tristate "National Semiconductor LM75 and compatibles"
-	depends on I2C
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for National Semiconductor LM75
-	  sensor chips and clones: Dallas Semiconductor DS75 and DS1775 (in
-	  9-bit precision mode), and TelCom (now Microchip) TCN75.
-
-	  The DS75 and DS1775 in 10- to 12-bit precision modes will require
-	  a force module parameter. The driver will not handle the extra
-	  precision anyhow.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called lm75.
-
-config SENSORS_LM77
-	tristate "National Semiconductor LM77"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for National Semiconductor LM77
-	  sensor chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called lm77.
-
-config SENSORS_LM78
-	tristate "National Semiconductor LM78 and compatibles"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for National Semiconductor LM78,
-	  LM78-J and LM79.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called lm78.
-
-config SENSORS_LM80
-	tristate "National Semiconductor LM80"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for National Semiconductor
-	  LM80 sensor chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called lm80.
-
-config SENSORS_LM83
-	tristate "National Semiconductor LM83"
-	depends on I2C
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for National Semiconductor
-	  LM83 sensor chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called lm83.
-
-config SENSORS_LM85
-	tristate "National Semiconductor LM85 and compatibles"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for National Semiconductor LM85
-	  sensor chips and clones: ADT7463, EMC6D100, EMC6D102 and ADM1027.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called lm85.
-
-config SENSORS_LM87
-	tristate "National Semiconductor LM87"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for National Semiconductor LM87
-	  sensor chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called lm87.
-
-config SENSORS_LM90
-	tristate "National Semiconductor LM90 and compatibles"
-	depends on I2C
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for National Semiconductor LM90,
-	  LM86, LM89 and LM99, Analog Devices ADM1032 and Maxim MAX6657 and
-	  MAX6658 sensor chips.
-
-	  The Analog Devices ADT7461 sensor chip is also supported, but only
-	  if found in ADM1032 compatibility mode.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called lm90.
-
-config SENSORS_LM92
-	tristate "National Semiconductor LM92 and compatibles"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for National Semiconductor LM92
-	  and Maxim MAX6635 sensor chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called lm92.
-
-config SENSORS_MAX1619
-	tristate "Maxim MAX1619 sensor chip"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for MAX1619 sensor chip.
-	  
-	  This driver can also be built as a module.  If so, the module
-	  will be called max1619.
-
-config SENSORS_PC87360
-	tristate "National Semiconductor PC87360 family"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	select I2C_ISA
-	help
-	  If you say yes here you get access to the hardware monitoring
-	  functions of the National Semiconductor PC8736x Super-I/O chips.
-	  The PC87360, PC87363 and PC87364 only have fan monitoring and
-	  control.  The PC87365 and PC87366 additionally have voltage and
-	  temperature monitoring.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called pc87360.
-
-config SENSORS_SMSC47B397
-	tristate "SMSC LPC47B397-NC"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	select I2C_ISA
-	help
-	  If you say yes here you get support for the SMSC LPC47B397-NC
-	  sensor chip.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called smsc47b397.
-
-config SENSORS_SIS5595
-	tristate "Silicon Integrated Systems Corp. SiS5595"
-	depends on I2C && PCI && EXPERIMENTAL
-	select I2C_SENSOR
-	select I2C_ISA
-	help
-	  If you say yes here you get support for the integrated sensors in
-	  SiS5595 South Bridges.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called sis5595.
-
-config SENSORS_SMSC47M1
-	tristate "SMSC LPC47M10x and compatibles"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	select I2C_ISA
-	help
-	  If you say yes here you get support for the integrated fan
-	  monitoring and control capabilities of the SMSC LPC47B27x,
-	  LPC47M10x, LPC47M13x, LPC47M14x, LPC47M15x and LPC47M192 chips.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called smsc47m1.
-
-config SENSORS_VIA686A
-	tristate "VIA686A"
-	depends on I2C && PCI
-	select I2C_SENSOR
-	select I2C_ISA
-	help
-	  If you say yes here you get support for the integrated sensors in
-	  Via 686A/B South Bridges.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called via686a.
-
-config SENSORS_W83781D
-	tristate "Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
-	depends on I2C
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for the Winbond W8378x series
-	  of sensor chips: the W83781D, W83782D, W83783S and W83627HF,
-	  and the similar Asus AS99127F.
-	  
-	  This driver can also be built as a module.  If so, the module
-	  will be called w83781d.
-
-config SENSORS_W83L785TS
-	tristate "Winbond W83L785TS-S"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	help
-	  If you say yes here you get support for the Winbond W83L785TS-S
-	  sensor chip, which is used on the Asus A7N8X, among other
-	  motherboards.
-	  
-	  This driver can also be built as a module.  If so, the module
-	  will be called w83l785ts.
-
-config SENSORS_W83627HF
-	tristate "Winbond W83627HF, W83627THF, W83637HF, W83697HF"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	select I2C_ISA
-	help
-	  If you say yes here you get support for the Winbond W836X7 series
-	  of sensor chips: the W83627HF, W83627THF, W83637HF, and the W83697HF
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called w83627hf.
-
-config SENSORS_W83627EHF
-	tristate "Winbond W83627EHF"
-	depends on I2C && EXPERIMENTAL
-	select I2C_SENSOR
-	select I2C_ISA
-	help
-	  If you say yes here you get preliminary support for the hardware
-	  monitoring functionality of the Winbond W83627EHF Super-I/O chip.
-	  Only fan and temperature inputs are supported at the moment, while
-	  the chip does much more than that.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called w83627ehf.
-
-endmenu
-
-menu "Other I2C Chip support"
+menu "Miscellaneous I2C Chip support"
 	depends on I2C
 
 config SENSORS_DS1337
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -1,52 +1,16 @@
 #
-# Makefile for sensor and "other" I2C chip drivers.
+# Makefile for miscellaneous I2C chip drivers.
 #
 
-# asb100, then w83781d go first, as they can override other drivers' addresses.
-obj-$(CONFIG_SENSORS_ASB100)	+= asb100.o
-obj-$(CONFIG_SENSORS_W83627HF)	+= w83627hf.o
-obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
-
-obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
-obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
-obj-$(CONFIG_SENSORS_ADM1026)	+= adm1026.o
-obj-$(CONFIG_SENSORS_ADM1031)	+= adm1031.o
-obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
-obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_DS1337)	+= ds1337.o
 obj-$(CONFIG_SENSORS_DS1374)	+= ds1374.o
-obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
 obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
-obj-$(CONFIG_SENSORS_FSCHER)	+= fscher.o
-obj-$(CONFIG_SENSORS_FSCPOS)	+= fscpos.o
-obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
-obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
-obj-$(CONFIG_SENSORS_IT87)	+= it87.o
-obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
-obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
-obj-$(CONFIG_SENSORS_LM77)	+= lm77.o
-obj-$(CONFIG_SENSORS_LM78)	+= lm78.o
-obj-$(CONFIG_SENSORS_LM80)	+= lm80.o
-obj-$(CONFIG_SENSORS_LM83)	+= lm83.o
-obj-$(CONFIG_SENSORS_LM85)	+= lm85.o
-obj-$(CONFIG_SENSORS_LM87)	+= lm87.o
-obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
-obj-$(CONFIG_SENSORS_LM92)	+= lm92.o
-obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
 obj-$(CONFIG_SENSORS_MAX6875)	+= max6875.o
 obj-$(CONFIG_SENSORS_M41T00)	+= m41t00.o
-obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PCA9539)	+= pca9539.o
 obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
 obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
 obj-$(CONFIG_SENSORS_RTC8564)	+= rtc8564.o
-obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
-obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
-obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
-obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
-obj-$(CONFIG_SENSORS_W83627EHF)	+= w83627ehf.o
-obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
-
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 

