Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVF0Uup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVF0Uup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVF0Uuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:50:44 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:2319 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261773AbVF0Uj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:39:59 -0400
Date: Mon, 27 Jun 2005 22:40:03 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LM Sensors <lm-sensors@lm-sensors.org>,
       LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>
Subject: Moving hardware monitoring drivers to drivers/hwmon (1/3)
Message-Id: <20050627224003.4b1ce717.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We want to move all the hardware monitoring drivers from
drivers/i2c/chips to drivers/hwmon. Some of these drivers are for ISA,
PCI or Super-I/O chips, not I2C or SMBus chips, so there is no reason to
put them under drivers/i2c, other than historical. This is what we want
to change. All these drivers share a common sysfs interface standard, so
it makes sense to have them all in a common subdirectory - just not one
related to a specific bus.

This change is preliminary to the introduction of a hwmon driver class
and the separation of the non-i2c hardware monitoring drivers from the
i2c subsystem.

This first patch updates the Makefile and Kconfig files all around the
place to take the new drivers/hwmon directory into account. This means
moving a large part of drivers/i2c/chips/{Kconfig,Makefile} to
drivers/hwmon/{Kconfig,Makefile}, and updating
drivers/{Kconfig,Makefile} to reference
drivers/hwmon/{Kconfig,Makefile}.

Note that the arm, h8300 and sparc64 architectures needed to be handled
separately, as they include the drivers/i2c subdirectory explicitely.
They now include drivers/hwmon explicitely as well. The maintainers of
these architectures should speak up if they think there is no point in
doing so, in which case I'd drop that specific part of the patch. I have
no idea what h8300 is.

Note that this patch is meant for review, not inclusion. It will be
resent again at a later point, with any required fixes. It is also
temporarily available from:

http://jdelvare.net1.nerim.net/sensors/linux-2.6.12-git5-hwmon-move-all-drivers-1-cfg.diff.gz

Thanks.

 arch/arm/Kconfig           |    2 
 arch/h8300/Kconfig         |    2 
 arch/sparc64/Kconfig       |    2 
 drivers/Kconfig            |    2 
 drivers/Makefile           |    1 
 drivers/hwmon/Kconfig      |  419 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/Makefile     |   44 ++++
 drivers/i2c/chips/Kconfig  |  401 -------------------------------------------
 drivers/i2c/chips/Makefile |   38 ----
 9 files changed, 475 insertions(+), 436 deletions(-)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-git5/drivers/hwmon/Kconfig	2005-06-27 22:03:10.000000000 +0200
@@ -0,0 +1,419 @@
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
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-git5/drivers/hwmon/Makefile	2005-06-27 21:13:12.000000000 +0200
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
--- linux-2.6.12-git5.orig/drivers/i2c/chips/Kconfig	2005-06-26 20:13:52.000000000 +0200
+++ linux-2.6.12-git5/drivers/i2c/chips/Kconfig	2005-06-26 20:18:49.000000000 +0200
@@ -1,409 +1,12 @@
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
--- linux-2.6.12-git5.orig/drivers/i2c/chips/Makefile	2005-06-26 20:13:52.000000000 +0200
+++ linux-2.6.12-git5/drivers/i2c/chips/Makefile	2005-06-26 20:18:49.000000000 +0200
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
 
--- linux-2.6.12-git5.orig/drivers/Kconfig	2005-06-26 20:13:52.000000000 +0200
+++ linux-2.6.12-git5/drivers/Kconfig	2005-06-26 20:18:49.000000000 +0200
@@ -44,6 +44,8 @@
 
 source "drivers/w1/Kconfig"
 
+source "drivers/hwmon/Kconfig"
+
 source "drivers/misc/Kconfig"
 
 source "drivers/media/Kconfig"
--- linux-2.6.12-git5.orig/drivers/Makefile	2005-06-26 20:13:52.000000000 +0200
+++ linux-2.6.12-git5/drivers/Makefile	2005-06-27 21:12:13.000000000 +0200
@@ -52,6 +52,7 @@
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_I2C)		+= i2c/
 obj-$(CONFIG_W1)		+= w1/
+obj-$(CONFIG_HWMON)		+= hwmon/
 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/
 obj-$(CONFIG_BT)		+= bluetooth/
--- linux-2.6.12-git5.orig/arch/arm/Kconfig	2005-06-23 21:32:00.000000000 +0200
+++ linux-2.6.12-git5/arch/arm/Kconfig	2005-06-27 21:08:43.000000000 +0200
@@ -720,6 +720,8 @@
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/hwmon/Kconfig"
+
 #source "drivers/l3/Kconfig"
 
 source "drivers/misc/Kconfig"
--- linux-2.6.12-git5.orig/arch/h8300/Kconfig	2005-06-18 09:30:19.000000000 +0200
+++ linux-2.6.12-git5/arch/h8300/Kconfig	2005-06-27 21:08:32.000000000 +0200
@@ -179,6 +179,8 @@
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/hwmon/Kconfig"
+
 source "drivers/usb/Kconfig"
 
 endmenu
--- linux-2.6.12-git5.orig/arch/sparc64/Kconfig	2005-06-18 09:32:07.000000000 +0200
+++ linux-2.6.12-git5/arch/sparc64/Kconfig	2005-06-27 21:08:19.000000000 +0200
@@ -608,6 +608,8 @@
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/hwmon/Kconfig"
+
 source "fs/Kconfig"
 
 source "drivers/media/Kconfig"

-- 
Jean Delvare
