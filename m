Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSFJAld>; Sun, 9 Jun 2002 20:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSFJAld>; Sun, 9 Jun 2002 20:41:33 -0400
Received: from mail026.mail.bellsouth.net ([205.152.58.66]:53378 "EHLO
	imf26bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S315445AbSFJAlb>; Sun, 9 Jun 2002 20:41:31 -0400
Message-ID: <3D03F5B3.BD857572@bellsouth.net>
Date: Sun, 09 Jun 2002 20:41:23 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]-revised 2.5.21 lm_sensors support 1/5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adjusted subdir i2c/busses and i2c/chips from within
i2c/Makefile and not from drivers/Makefile.
--- linux/drivers/i2c/Config.in.orig	2002-05-20 09:58:09.000000000 -0400
+++ linux/drivers/i2c/Config.in	2002-05-20 10:00:17.000000000 -0400
@@ -45,5 +45,7 @@
    dep_tristate 'I2C device interface' CONFIG_I2C_CHARDEV $CONFIG_I2C
    dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C $CONFIG_SYSCTL
 
+  source drivers/i2c/busses/Config.in
+  source drivers/i2c/chips/Config.in
 fi
 endmenu
--- linux/drivers/i2c/Makefile.orig	2002-06-09 19:37:29.000000000 -0400
+++ linux/drivers/i2c/Makefile	2002-06-09 19:32:33.000000000 -0400
@@ -16,6 +16,8 @@
 obj-$(CONFIG_ITE_I2C_ALGO)	+= i2c-algo-ite.o
 obj-$(CONFIG_ITE_I2C_ADAP)	+= i2c-adap-ite.o
 obj-$(CONFIG_I2C_PROC)		+= i2c-proc.o
+obj-$(CONFIG_MAINBOARD)		+= busses/
+obj-$(CONFIG_SENSORS)		+= chips/
 
 # This is needed for automatic patch generation: sensors code starts here
 # This is needed for automatic patch generation: sensors code ends here
--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/Config.in	2002-05-20 10:00:58.000000000 -0400
@@ -0,0 +1,32 @@
+#
+# Sensor device configuration
+# All depend on CONFIG_I2C_PROC.
+# ISA-only devices depend on CONFIG_I2C_ISA also.
+#
+
+if [ "$CONFIG_I2C" = "m" -o "$CONFIG_I2C" = "y" ] ; then
+if [ "$CONFIG_I2C_PROC" = "m" -o "$CONFIG_I2C_PROC" = "y" ] ; then
+  mainmenu_option next_comment
+  comment 'Hardware sensors mainboard support'
+  
+  dep_mbool 'Hardware sensors mainboard support' CONFIG_MAINBOARD $CONFIG_I2C $CONFIG_I2C_PROC
+  
+  if [ "$CONFIG_MAINBOARD" = "y" ]; then
+    tristate '  Acer Labs ALI 1535' CONFIG_I2C_ALI1535 
+    tristate '  Acer Labs ALI 1533 and 1543C' CONFIG_I2C_ALI15X3 
+    tristate '  AMD 756/766' CONFIG_I2C_AMD756
+    dep_tristate '  Apple Hydra Mac I/O' CONFIG_I2C_HYDRA $CONFIG_I2C_ALGOBIT
+    tristate '  Intel 82801AA, 82801AB and 82801BA' CONFIG_I2C_I801
+    dep_tristate '  Intel i810AA, i810AB and i815' CONFIG_I2C_I810 $CONFIG_I2C_ALGOBIT
+    tristate '  Pseudo ISA adapter (for some hardware sensors)' CONFIG_I2C_ISA 
+    tristate '  Intel 82371AB PIIX4(E), ServerWorks OSB4/CSB5' CONFIG_I2C_PIIX4
+    tristate '  SiS 5595' CONFIG_I2C_SIS5595
+    dep_tristate '  DEC Tsunami I2C interface' CONFIG_I2C_TSUNAMI $CONFIG_I2C_ALGOBIT
+    dep_tristate '  VIA Technologies, Inc. VT82C586B' CONFIG_I2C_VIA $CONFIG_I2C_ALGOBIT
+    tristate '  VIA Technologies, Inc. VT596A/B' CONFIG_I2C_VIAPRO
+    dep_tristate '  Voodoo3 I2C interface' CONFIG_I2C_VOODOO3 $CONFIG_I2C_ALGOBIT
+  fi
+endmenu
+fi
+fi
+
--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/Makefile	2002-05-20 02:09:47.000000000 -0400
@@ -0,0 +1,27 @@
+#
+# Makefile for the kernel hardware sensors bus drivers.
+#
+
+MOD_LIST_NAME := SENSORS_BUS_MODULES
+
+export-objs	:= i2c-ali1535.o
+
+obj-$(CONFIG_I2C_ALI1535)	+= i2c-ali1535.o
+obj-$(CONFIG_I2C_ALI15X3)	+= i2c-ali15x3.o
+obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
+obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
+obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
+obj-$(CONFIG_I2C_I810)		+= i2c-i810.o
+obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
+obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
+obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
+obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
+ifeq ($(MACHINE),alpha)
+  obj-$(CONFIG_I2C_TSUNAMI)	+= i2c-tsunami.o
+endif
+obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
+obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
+obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
+
+
+include $(TOPDIR)/Rules.make
--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/chips/Config.in	2002-05-19 23:40:48.000000000 -0400
@@ -0,0 +1,46 @@
+#
+# Sensor device configuration
+# All depend on CONFIG_I2C_PROC.
+# ISA-only devices depend on CONFIG_I2C_ISA also.
+#
+
+if [ "$CONFIG_I2C" = "m" -o "$CONFIG_I2C" = "y" ] ; then
+if [ "$CONFIG_I2C_PROC" = "m" -o "$CONFIG_I2C_PROC" = "y" ] ; then
+  mainmenu_option next_comment
+  comment 'Hardware sensors chip support'
+  
+  dep_mbool 'Hardware sensors chip support' CONFIG_SENSORS $CONFIG_I2C $CONFIG_I2C_PROC
+  
+  if [ "$CONFIG_SENSORS" != "n" ]; then
+    dep_tristate '  Analog Devices ADM1021 and compatibles' CONFIG_SENSORS_ADM1021 $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  Analog Devices ADM1024' CONFIG_SENSORS_ADM1024 $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  Analog Devices ADM1025' CONFIG_SENSORS_ADM1025 $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  Analog Devices ADM9240 and compatibles' CONFIG_SENSORS_ADM9240 $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  Dallas DS1621 and DS1625' CONFIG_SENSORS_DS1621 $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  Fujitsu-Siemens Poseidon' CONFIG_SENSORS_FSCPOS $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  Fujitsu-Siemens Scylla' CONFIG_SENSORS_FSCSCY $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  Genesys Logic GL518SM' CONFIG_SENSORS_GL518SM $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  Genesys Logic GL520SM' CONFIG_SENSORS_GL520SM $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  HP Maxilife' CONFIG_SENSORS_MAXILIFE $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  ITE 8705/8712, SiS950' CONFIG_SENSORS_IT87 $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  Myson MTP008' CONFIG_SENSORS_MTP008 $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  National Semiconductors LM75 and compatibles' CONFIG_SENSORS_LM75 $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  National Semiconductors LM78' CONFIG_SENSORS_LM78 $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  National Semiconductors LM80' CONFIG_SENSORS_LM80 $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  National Semiconductors LM87' CONFIG_SENSORS_LM87 $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  Silicon Integrated Systems Corp. SiS5595' CONFIG_SENSORS_SIS5595 $CONFIG_I2C $CONFIG_I2C_PROC $CONFIG_I2C_ISA
+    dep_tristate '  Texas Instruments THMC50 and compatibles' CONFIG_SENSORS_THMC50 $CONFIG_I2C $CONFIG_I2C_PROC
+    dep_tristate '  VIA 686a Integrated Hardware Monitor' CONFIG_SENSORS_VIA686A $CONFIG_I2C $CONFIG_I2C_PROC $CONFIG_I2C_ISA
+    dep_tristate '  Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F' CONFIG_SENSORS_W83781D $CONFIG_I2C $CONFIG_I2C_PROC
+    bool 'Other I2C devices' CONFIG_SENSORS_OTHER 
+    if [ "$CONFIG_SENSORS_OTHER" = "y" ] ; then
+      dep_tristate '  Brooktree BT869 Video Modulator' CONFIG_SENSORS_BT869 $CONFIG_I2C $CONFIG_I2C_PROC
+      dep_tristate '  DDC Monitor EDID EEPROM' CONFIG_SENSORS_DDCMON $CONFIG_I2C $CONFIG_I2C_PROC
+      dep_tristate '  EEprom (DIMM) reader ' CONFIG_SENSORS_EEPROM $CONFIG_I2C $CONFIG_I2C_PROC
+      dep_tristate '  Matrix-Orbital LCD Displays' CONFIG_SENSORS_MATORB $CONFIG_I2C $CONFIG_I2C_PROC
+    fi
+  fi
+  endmenu
+fi
+fi
+
--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/chips/Makefile	2002-05-20 02:22:58.000000000 -0400
@@ -0,0 +1,37 @@
+#
+# Makefile for the kernel hardware sensors chip drivers.
+#
+
+MOD_LIST_NAME := SENSORS_CHIPS_MODULES
+
+obj-$(CONFIG_SENSORS)		+= sensors.o
+obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
+obj-$(CONFIG_SENSORS_ADM1024)	+= adm1024.o
+obj-$(CONFIG_SENSORS_ADM1025)	+= adm1025.o
+obj-$(CONFIG_SENSORS_ADM9240)	+= adm9240.o
+obj-$(CONFIG_SENSORS_BT869)	+= bt869.o
+obj-$(CONFIG_SENSORS_DDCMON)	+= ddcmon.o
+obj-$(CONFIG_SENSORS_DS1621)	+= ds1621.o
+obj-$(CONFIG_SENSORS_EEPROM)	+= eeprom.o
+obj-$(CONFIG_SENSORS_FSCPOS)	+= fscpos.o
+obj-$(CONFIG_SENSORS_FSCSCY)	+= fscscy.o
+obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
+obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
+obj-$(CONFIG_SENSORS_ICSPLL)	+= icspll.o
+obj-$(CONFIG_SENSORS_IT87)	+= it87.o
+obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
+obj-$(CONFIG_SENSORS_LM78)	+= lm78.o
+obj-$(CONFIG_SENSORS_LM80)	+= lm80.o
+obj-$(CONFIG_SENSORS_LM87)	+= lm87.o
+obj-$(CONFIG_SENSORS_LTC1710)	+= ltc1710.o
+obj-$(CONFIG_SENSORS_MATORB)	+= matorb.o
+obj-$(CONFIG_SENSORS_MAXILIFE)	+= maxilife.o
+obj-$(CONFIG_SENSORS_MTP008)	+= mtp008.o
+obj-$(CONFIG_SENSORS_PCF8574)	+= pcf8574.o
+obj-$(CONFIG_SENSORS_PCF8591)	+= pcf8591.o
+obj-$(CONFIG_SENSORS_SIS5595)	+= sis5595.o
+obj-$(CONFIG_SENSORS_THMC50)	+= thmc50.o
+obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
+obj-$(CONFIG_SENSORS_W83781D)	+= w83781d.o
+
+include $(TOPDIR)/Rules.make

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
