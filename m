Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263212AbTDCANH>; Wed, 2 Apr 2003 19:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263207AbTDCAH2>; Wed, 2 Apr 2003 19:07:28 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:10886 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263210AbTDCACN> convert rfc822-to-8bit; Wed, 2 Apr 2003 19:02:13 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1049328958105@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.66
In-Reply-To: <10493289583083@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 2 Apr 2003 16:15:58 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.977.29.10, 2003/04/02 12:01:21-08:00, greg@kroah.com

i2c: move i2c-proc to i2c-sensor and clean up all usages of it.


 drivers/i2c/i2c-proc.c      |  187 ----------------------
 include/linux/i2c-proc.h    |  373 --------------------------------------------
 drivers/i2c/Kconfig         |   11 -
 drivers/i2c/Makefile        |    2 
 drivers/i2c/chips/Kconfig   |   13 +
 drivers/i2c/chips/adm1021.c |    2 
 drivers/i2c/chips/lm75.c    |    2 
 drivers/i2c/chips/via686a.c |    2 
 drivers/i2c/i2c-sensor.c    |  182 +++++++++++++++++++++
 include/linux/i2c-sensor.h  |  373 ++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 568 insertions(+), 579 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Wed Apr  2 16:00:46 2003
+++ b/drivers/i2c/Kconfig	Wed Apr  2 16:00:46 2003
@@ -196,17 +196,6 @@
 	  <file:Documentation/modules.txt>.
 	  The module will be called i2c-dev.
 
-config I2C_PROC
-	tristate "I2C /proc interface (required for hardware sensors)"
-	depends on I2C && SYSCTL
-	help
-	  This provides support for i2c device entries in the /proc filesystem.
-	  The entries will be found in /proc/sys/dev/sensors.
-
-	  This code is also available as a module. If you want to compile
-	  it as a module, say M here and read <file:Documentation/modules.txt>.
-	  The module will be called i2c-proc.
-
 	source drivers/i2c/busses/Kconfig
 	source drivers/i2c/chips/Kconfig
 
diff -Nru a/drivers/i2c/Makefile b/drivers/i2c/Makefile
--- a/drivers/i2c/Makefile	Wed Apr  2 16:00:46 2003
+++ b/drivers/i2c/Makefile	Wed Apr  2 16:00:46 2003
@@ -14,5 +14,5 @@
 obj-$(CONFIG_ITE_I2C_ADAP)	+= i2c-adap-ite.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
-obj-$(CONFIG_I2C_PROC)		+= i2c-proc.o
+obj-$(CONFIG_I2C_SENSOR)	+= i2c-sensor.o
 obj-y				+= busses/ chips/
diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	Wed Apr  2 16:00:46 2003
+++ b/drivers/i2c/chips/Kconfig	Wed Apr  2 16:00:46 2003
@@ -1,13 +1,13 @@
 #
 # Sensor device configuration
-# All depend on EXPERIMENTAL, I2C and I2C_PROC.
+# All depend on EXPERIMENTAL and I2C
 #
 
 menu "I2C Hardware Sensors Chip support"
 
 config SENSORS_ADM1021
 	tristate "  Analog Devices ADM1021 and compatibles"
-	depends on I2C && I2C_PROC
+	depends on I2C && EXPERIMENTAL
 	help
 	  If you say yes here you get support for Analog Devices ADM1021 
 	  and ADM1023 sensor chips and clones: Maxim MAX1617 and MAX1617A,
@@ -24,7 +24,7 @@
 
 config SENSORS_LM75
 	tristate "  National Semiconductors LM75 and compatibles"
-	depends on I2C && I2C_PROC
+	depends on I2C && EXPERIMENTAL
 	help
 	  If you say yes here you get support for National Semiconductor LM75
 	  sensor chips and clones: Dallas Semi DS75 and DS1775, TelCon
@@ -39,7 +39,7 @@
 
 config SENSORS_VIA686A
 	tristate "  VIA686A"
-	depends on I2C && I2C_PROC
+	depends on I2C && EXPERIMENTAL
 	help
 	  support for via686a
 	  If you say yes here you get support for the integrated sensors in
@@ -49,5 +49,10 @@
 	  You will also need the latest user-space utilties: you can find them
 	  in the lm_sensors package, which you can download at
 	  http://www.lm-sensors.nu
+
+config I2C_SENSOR
+	tristate
+	depends on SENSORS_ADM1021 || SENSORS_LM75 || SENSORS_VIA686A
+	default m
 
 endmenu
diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Wed Apr  2 16:00:46 2003
+++ b/drivers/i2c/chips/adm1021.c	Wed Apr  2 16:00:46 2003
@@ -23,7 +23,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c-proc.h>
+#include <linux/i2c-sensor.h>
 
 
 /* Registers */
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Wed Apr  2 16:00:46 2003
+++ b/drivers/i2c/chips/lm75.c	Wed Apr  2 16:00:46 2003
@@ -24,7 +24,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
-#include <linux/i2c-proc.h>
+#include <linux/i2c-sensor.h>
 
 
 /* Addresses to scan */
diff -Nru a/drivers/i2c/chips/via686a.c b/drivers/i2c/chips/via686a.c
--- a/drivers/i2c/chips/via686a.c	Wed Apr  2 16:00:46 2003
+++ b/drivers/i2c/chips/via686a.c	Wed Apr  2 16:00:46 2003
@@ -36,7 +36,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
-#include <linux/i2c-proc.h>
+#include <linux/i2c-sensor.h>
 #include <linux/init.h>
 #include <asm/io.h>
 
diff -Nru a/drivers/i2c/i2c-proc.c b/drivers/i2c/i2c-proc.c
--- a/drivers/i2c/i2c-proc.c	Wed Apr  2 16:00:46 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,187 +0,0 @@
-/*
-    i2c-proc.c - Part of lm_sensors, Linux kernel modules for hardware
-                monitoring
-    Copyright (c) 1998 - 2001 Frodo Looijaard <frodol@dds.nl> and
-    Mark D. Studebaker <mdsxyz123@yahoo.com>
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
-    This driver puts entries in /proc/sys/dev/sensors for each I2C device
-*/
-
-/* #define DEBUG 1 */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/ctype.h>
-#include <linux/sysctl.h>
-#include <linux/proc_fs.h>
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/i2c.h>
-#include <linux/i2c-proc.h>
-#include <asm/uaccess.h>
-
-
-/* Very inefficient for ISA detects, and won't work for 10-bit addresses! */
-int i2c_detect(struct i2c_adapter *adapter,
-		   struct i2c_address_data *address_data,
-		   i2c_found_addr_proc * found_proc)
-{
-	int addr, i, found, j, err;
-	struct i2c_force_data *this_force;
-	int is_isa = i2c_is_isa_adapter(adapter);
-	int adapter_id =
-	    is_isa ? SENSORS_ISA_BUS : i2c_adapter_id(adapter);
-
-	/* Forget it if we can't probe using SMBUS_QUICK */
-	if ((!is_isa) &&
-	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK))
-		return -1;
-
-	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
-		/* XXX: WTF is going on here??? */
-		if ((is_isa && check_region(addr, 1)) ||
-		    (!is_isa && i2c_check_addr(adapter, addr)))
-			continue;
-
-		/* If it is in one of the force entries, we don't do any
-		   detection at all */
-		found = 0;
-		for (i = 0; !found && (this_force = address_data->forces + i, this_force->force); i++) {
-			for (j = 0; !found && (this_force->force[j] != SENSORS_I2C_END); j += 2) {
-				if ( ((adapter_id == this_force->force[j]) ||
-				      ((this_force->force[j] == SENSORS_ANY_I2C_BUS) && !is_isa)) &&
-				      (addr == this_force->force[j + 1]) ) {
-					dev_dbg(&adapter->dev, "found force parameter for adapter %d, addr %04x\n", adapter_id, addr);
-					if ((err = found_proc(adapter, addr, this_force->kind)))
-						return err;
-					found = 1;
-				}
-			}
-		}
-		if (found)
-			continue;
-
-		/* If this address is in one of the ignores, we can forget about it
-		   right now */
-		for (i = 0; !found && (address_data->ignore[i] != SENSORS_I2C_END); i += 2) {
-			if ( ((adapter_id == address_data->ignore[i]) ||
-			      ((address_data->ignore[i] == SENSORS_ANY_I2C_BUS) &&
-			       !is_isa)) &&
-			      (addr == address_data->ignore[i + 1])) {
-				dev_dbg(&adapter->dev, "found ignore parameter for adapter %d, addr %04x\n", adapter_id, addr);
-				found = 1;
-			}
-		}
-		for (i = 0; !found && (address_data->ignore_range[i] != SENSORS_I2C_END); i += 3) {
-			if ( ((adapter_id == address_data->ignore_range[i]) ||
-			      ((address_data-> ignore_range[i] == SENSORS_ANY_I2C_BUS) & 
-			       !is_isa)) &&
-			     (addr >= address_data->ignore_range[i + 1]) &&
-			     (addr <= address_data->ignore_range[i + 2])) {
-				dev_dbg(&adapter->dev,  "found ignore_range parameter for adapter %d, addr %04x\n", adapter_id, addr);
-				found = 1;
-			}
-		}
-		if (found)
-			continue;
-
-		/* Now, we will do a detection, but only if it is in the normal or 
-		   probe entries */
-		if (is_isa) {
-			for (i = 0; !found && (address_data->normal_isa[i] != SENSORS_ISA_END); i += 1) {
-				if (addr == address_data->normal_isa[i]) {
-					dev_dbg(&adapter->dev, "found normal isa entry for adapter %d, addr %04x\n", adapter_id, addr);
-					found = 1;
-				}
-			}
-			for (i = 0; !found && (address_data->normal_isa_range[i] != SENSORS_ISA_END); i += 3) {
-				if ((addr >= address_data->normal_isa_range[i]) &&
-				    (addr <= address_data->normal_isa_range[i + 1]) &&
-				    ((addr - address_data->normal_isa_range[i]) % address_data->normal_isa_range[i + 2] == 0)) {
-					dev_dbg(&adapter->dev, "found normal isa_range entry for adapter %d, addr %04x", adapter_id, addr);
-					found = 1;
-				}
-			}
-		} else {
-			for (i = 0; !found && (address_data->normal_i2c[i] != SENSORS_I2C_END); i += 1) {
-				if (addr == address_data->normal_i2c[i]) {
-					found = 1;
-					dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, addr %02x", adapter_id, addr);
-				}
-			}
-			for (i = 0; !found && (address_data->normal_i2c_range[i] != SENSORS_I2C_END); i += 2) {
-				if ((addr >= address_data->normal_i2c_range[i]) &&
-				    (addr <= address_data->normal_i2c_range[i + 1])) {
-					dev_dbg(&adapter->dev, "found normal i2c_range entry for adapter %d, addr %04x\n", adapter_id, addr);
-					found = 1;
-				}
-			}
-		}
-
-		for (i = 0;
-		     !found && (address_data->probe[i] != SENSORS_I2C_END);
-		     i += 2) {
-			if (((adapter_id == address_data->probe[i]) ||
-			     ((address_data->
-			       probe[i] == SENSORS_ANY_I2C_BUS) & !is_isa))
-			    && (addr == address_data->probe[i + 1])) {
-				dev_dbg(&adapter->dev, "found probe parameter for adapter %d, addr %04x\n", adapter_id, addr);
-				found = 1;
-			}
-		}
-		for (i = 0; !found && (address_data->probe_range[i] != SENSORS_I2C_END); i += 3) {
-			if ( ((adapter_id == address_data->probe_range[i]) ||
-			      ((address_data->probe_range[i] == SENSORS_ANY_I2C_BUS) & !is_isa)) &&
-			     (addr >= address_data->probe_range[i + 1]) &&
-			     (addr <= address_data->probe_range[i + 2])) {
-				found = 1;
-				dev_dbg(&adapter->dev, "found probe_range parameter for adapter %d, addr %04x\n", adapter_id, addr);
-			}
-		}
-		if (!found)
-			continue;
-
-		/* OK, so we really should examine this address. First check
-		   whether there is some client here at all! */
-		if (is_isa ||
-		    (i2c_smbus_xfer (adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) >= 0))
-			if ((err = found_proc(adapter, addr, -1)))
-				return err;
-	}
-	return 0;
-}
-
-static int __init i2c_proc_init(void)
-{
-	return 0;
-}
-
-static void __exit i2c_proc_exit(void)
-{
-}
-
-EXPORT_SYMBOL(i2c_detect);
-
-MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
-MODULE_DESCRIPTION("i2c-proc driver");
-MODULE_LICENSE("GPL");
-
-module_init(i2c_proc_init);
-module_exit(i2c_proc_exit);
diff -Nru a/drivers/i2c/i2c-sensor.c b/drivers/i2c/i2c-sensor.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/i2c-sensor.c	Wed Apr  2 16:00:46 2003
@@ -0,0 +1,182 @@
+/*
+    i2c-sensor.c - Part of lm_sensors, Linux kernel modules for hardware
+                monitoring
+    Copyright (c) 1998 - 2001 Frodo Looijaard <frodol@dds.nl> and
+    Mark D. Studebaker <mdsxyz123@yahoo.com>
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
+/* #define DEBUG 1 */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/ctype.h>
+#include <linux/sysctl.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/i2c.h>
+#include <linux/i2c-sensor.h>
+#include <asm/uaccess.h>
+
+
+/* Very inefficient for ISA detects, and won't work for 10-bit addresses! */
+int i2c_detect(struct i2c_adapter *adapter,
+		   struct i2c_address_data *address_data,
+		   i2c_found_addr_proc * found_proc)
+{
+	int addr, i, found, j, err;
+	struct i2c_force_data *this_force;
+	int is_isa = i2c_is_isa_adapter(adapter);
+	int adapter_id =
+	    is_isa ? SENSORS_ISA_BUS : i2c_adapter_id(adapter);
+
+	/* Forget it if we can't probe using SMBUS_QUICK */
+	if ((!is_isa) &&
+	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_QUICK))
+		return -1;
+
+	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
+		/* XXX: WTF is going on here??? */
+		if ((is_isa && check_region(addr, 1)) ||
+		    (!is_isa && i2c_check_addr(adapter, addr)))
+			continue;
+
+		/* If it is in one of the force entries, we don't do any
+		   detection at all */
+		found = 0;
+		for (i = 0; !found && (this_force = address_data->forces + i, this_force->force); i++) {
+			for (j = 0; !found && (this_force->force[j] != SENSORS_I2C_END); j += 2) {
+				if ( ((adapter_id == this_force->force[j]) ||
+				      ((this_force->force[j] == SENSORS_ANY_I2C_BUS) && !is_isa)) &&
+				      (addr == this_force->force[j + 1]) ) {
+					dev_dbg(&adapter->dev, "found force parameter for adapter %d, addr %04x\n", adapter_id, addr);
+					if ((err = found_proc(adapter, addr, this_force->kind)))
+						return err;
+					found = 1;
+				}
+			}
+		}
+		if (found)
+			continue;
+
+		/* If this address is in one of the ignores, we can forget about it
+		   right now */
+		for (i = 0; !found && (address_data->ignore[i] != SENSORS_I2C_END); i += 2) {
+			if ( ((adapter_id == address_data->ignore[i]) ||
+			      ((address_data->ignore[i] == SENSORS_ANY_I2C_BUS) &&
+			       !is_isa)) &&
+			      (addr == address_data->ignore[i + 1])) {
+				dev_dbg(&adapter->dev, "found ignore parameter for adapter %d, addr %04x\n", adapter_id, addr);
+				found = 1;
+			}
+		}
+		for (i = 0; !found && (address_data->ignore_range[i] != SENSORS_I2C_END); i += 3) {
+			if ( ((adapter_id == address_data->ignore_range[i]) ||
+			      ((address_data-> ignore_range[i] == SENSORS_ANY_I2C_BUS) & 
+			       !is_isa)) &&
+			     (addr >= address_data->ignore_range[i + 1]) &&
+			     (addr <= address_data->ignore_range[i + 2])) {
+				dev_dbg(&adapter->dev,  "found ignore_range parameter for adapter %d, addr %04x\n", adapter_id, addr);
+				found = 1;
+			}
+		}
+		if (found)
+			continue;
+
+		/* Now, we will do a detection, but only if it is in the normal or 
+		   probe entries */
+		if (is_isa) {
+			for (i = 0; !found && (address_data->normal_isa[i] != SENSORS_ISA_END); i += 1) {
+				if (addr == address_data->normal_isa[i]) {
+					dev_dbg(&adapter->dev, "found normal isa entry for adapter %d, addr %04x\n", adapter_id, addr);
+					found = 1;
+				}
+			}
+			for (i = 0; !found && (address_data->normal_isa_range[i] != SENSORS_ISA_END); i += 3) {
+				if ((addr >= address_data->normal_isa_range[i]) &&
+				    (addr <= address_data->normal_isa_range[i + 1]) &&
+				    ((addr - address_data->normal_isa_range[i]) % address_data->normal_isa_range[i + 2] == 0)) {
+					dev_dbg(&adapter->dev, "found normal isa_range entry for adapter %d, addr %04x", adapter_id, addr);
+					found = 1;
+				}
+			}
+		} else {
+			for (i = 0; !found && (address_data->normal_i2c[i] != SENSORS_I2C_END); i += 1) {
+				if (addr == address_data->normal_i2c[i]) {
+					found = 1;
+					dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, addr %02x", adapter_id, addr);
+				}
+			}
+			for (i = 0; !found && (address_data->normal_i2c_range[i] != SENSORS_I2C_END); i += 2) {
+				if ((addr >= address_data->normal_i2c_range[i]) &&
+				    (addr <= address_data->normal_i2c_range[i + 1])) {
+					dev_dbg(&adapter->dev, "found normal i2c_range entry for adapter %d, addr %04x\n", adapter_id, addr);
+					found = 1;
+				}
+			}
+		}
+
+		for (i = 0;
+		     !found && (address_data->probe[i] != SENSORS_I2C_END);
+		     i += 2) {
+			if (((adapter_id == address_data->probe[i]) ||
+			     ((address_data->
+			       probe[i] == SENSORS_ANY_I2C_BUS) & !is_isa))
+			    && (addr == address_data->probe[i + 1])) {
+				dev_dbg(&adapter->dev, "found probe parameter for adapter %d, addr %04x\n", adapter_id, addr);
+				found = 1;
+			}
+		}
+		for (i = 0; !found && (address_data->probe_range[i] != SENSORS_I2C_END); i += 3) {
+			if ( ((adapter_id == address_data->probe_range[i]) ||
+			      ((address_data->probe_range[i] == SENSORS_ANY_I2C_BUS) & !is_isa)) &&
+			     (addr >= address_data->probe_range[i + 1]) &&
+			     (addr <= address_data->probe_range[i + 2])) {
+				found = 1;
+				dev_dbg(&adapter->dev, "found probe_range parameter for adapter %d, addr %04x\n", adapter_id, addr);
+			}
+		}
+		if (!found)
+			continue;
+
+		/* OK, so we really should examine this address. First check
+		   whether there is some client here at all! */
+		if (is_isa ||
+		    (i2c_smbus_xfer (adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) >= 0))
+			if ((err = found_proc(adapter, addr, -1)))
+				return err;
+	}
+	return 0;
+}
+
+static int __init i2c_sensor_init(void)
+{
+	return 0;
+}
+
+static void __exit i2c_sensor_exit(void)
+{
+}
+
+EXPORT_SYMBOL(i2c_detect);
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
+MODULE_DESCRIPTION("i2c-sensor driver");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_sensor_init);
+module_exit(i2c_sensor_exit);
diff -Nru a/include/linux/i2c-proc.h b/include/linux/i2c-proc.h
--- a/include/linux/i2c-proc.h	Wed Apr  2 16:00:46 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,373 +0,0 @@
-/*
-    i2c-proc.h - Part of the i2c package
-    was originally sensors.h - Part of lm_sensors, Linux kernel modules
-                               for hardware monitoring
-    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
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
-#ifndef _LINUX_I2C_PROC_H
-#define _LINUX_I2C_PROC_H
-
-#include <linux/sysctl.h>
-
-/* The type of callback functions used in sensors_{proc,sysctl}_real */
-typedef void (*i2c_real_callback) (struct i2c_client * client,
-				       int operation, int ctl_name,
-				       int *nrels_mag, long *results);
-
-/* Values for the operation field in the above function type */
-#define SENSORS_PROC_REAL_INFO 1
-#define SENSORS_PROC_REAL_READ 2
-#define SENSORS_PROC_REAL_WRITE 3
-
-/* A structure containing detect information.
-   Force variables overrule all other variables; they force a detection on
-   that place. If a specific chip is given, the module blindly assumes this
-   chip type is present; if a general force (kind == 0) is given, the module
-   will still try to figure out what type of chip is present. This is useful
-   if for some reasons the detect for SMBus or ISA address space filled
-   fails.
-   probe: insmod parameter. Initialize this list with SENSORS_I2C_END values.
-     A list of pairs. The first value is a bus number (SENSORS_ISA_BUS for
-     the ISA bus, -1 for any I2C bus), the second is the address. 
-   kind: The kind of chip. 0 equals any chip.
-*/
-struct i2c_force_data {
-	unsigned short *force;
-	unsigned short kind;
-};
-
-/* A structure containing the detect information.
-   normal_i2c: filled in by the module writer. Terminated by SENSORS_I2C_END.
-     A list of I2C addresses which should normally be examined.
-   normal_i2c_range: filled in by the module writer. Terminated by 
-     SENSORS_I2C_END
-     A list of pairs of I2C addresses, each pair being an inclusive range of
-     addresses which should normally be examined.
-   normal_isa: filled in by the module writer. Terminated by SENSORS_ISA_END.
-     A list of ISA addresses which should normally be examined.
-   normal_isa_range: filled in by the module writer. Terminated by 
-     SENSORS_ISA_END
-     A list of triples. The first two elements are ISA addresses, being an
-     range of addresses which should normally be examined. The third is the
-     modulo parameter: only addresses which are 0 module this value relative
-     to the first address of the range are actually considered.
-   probe: insmod parameter. Initialize this list with SENSORS_I2C_END values.
-     A list of pairs. The first value is a bus number (SENSORS_ISA_BUS for
-     the ISA bus, -1 for any I2C bus), the second is the address. These
-     addresses are also probed, as if they were in the 'normal' list.
-   probe_range: insmod parameter. Initialize this list with SENSORS_I2C_END 
-     values.
-     A list of triples. The first value is a bus number (SENSORS_ISA_BUS for
-     the ISA bus, -1 for any I2C bus), the second and third are addresses. 
-     These form an inclusive range of addresses that are also probed, as
-     if they were in the 'normal' list.
-   ignore: insmod parameter. Initialize this list with SENSORS_I2C_END values.
-     A list of pairs. The first value is a bus number (SENSORS_ISA_BUS for
-     the ISA bus, -1 for any I2C bus), the second is the I2C address. These
-     addresses are never probed. This parameter overrules 'normal' and 
-     'probe', but not the 'force' lists.
-   ignore_range: insmod parameter. Initialize this list with SENSORS_I2C_END 
-      values.
-     A list of triples. The first value is a bus number (SENSORS_ISA_BUS for
-     the ISA bus, -1 for any I2C bus), the second and third are addresses. 
-     These form an inclusive range of I2C addresses that are never probed.
-     This parameter overrules 'normal' and 'probe', but not the 'force' lists.
-   force_data: insmod parameters. A list, ending with an element of which
-     the force field is NULL.
-*/
-struct i2c_address_data {
-	unsigned short *normal_i2c;
-	unsigned short *normal_i2c_range;
-	unsigned int *normal_isa;
-	unsigned int *normal_isa_range;
-	unsigned short *probe;
-	unsigned short *probe_range;
-	unsigned short *ignore;
-	unsigned short *ignore_range;
-	struct i2c_force_data *forces;
-};
-
-/* Internal numbers to terminate lists */
-#define SENSORS_I2C_END 0xfffe
-#define SENSORS_ISA_END 0xfffefffe
-
-/* The numbers to use to set an ISA or I2C bus address */
-#define SENSORS_ISA_BUS 9191
-#define SENSORS_ANY_I2C_BUS 0xffff
-
-/* The length of the option lists */
-#define SENSORS_MAX_OPTS 48
-
-/* Default fill of many variables */
-#define SENSORS_DEFAULTS {SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
-                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END}
-
-/* This is ugly. We need to evaluate SENSORS_MAX_OPTS before it is 
-   stringified */
-#define SENSORS_MODPARM_AUX1(x) "1-" #x "h"
-#define SENSORS_MODPARM_AUX(x) SENSORS_MODPARM_AUX1(x)
-#define SENSORS_MODPARM SENSORS_MODPARM_AUX(SENSORS_MAX_OPTS)
-
-/* SENSORS_MODULE_PARM creates a module parameter, and puts it in the
-   module header */
-#define SENSORS_MODULE_PARM(var,desc) \
-  static unsigned short var[SENSORS_MAX_OPTS] = SENSORS_DEFAULTS; \
-  MODULE_PARM(var,SENSORS_MODPARM); \
-  MODULE_PARM_DESC(var,desc)
-
-/* SENSORS_MODULE_PARM creates a 'force_*' module parameter, and puts it in
-   the module header */
-#define SENSORS_MODULE_PARM_FORCE(name) \
-  SENSORS_MODULE_PARM(force_ ## name, \
-                      "List of adapter,address pairs which are unquestionably" \
-                      " assumed to contain a `" # name "' chip")
-
-
-/* This defines several insmod variables, and the addr_data structure */
-#define SENSORS_INSMOD \
-  SENSORS_MODULE_PARM(probe, \
-                      "List of adapter,address pairs to scan additionally"); \
-  SENSORS_MODULE_PARM(probe_range, \
-                      "List of adapter,start-addr,end-addr triples to scan " \
-                      "additionally"); \
-  SENSORS_MODULE_PARM(ignore, \
-                      "List of adapter,address pairs not to scan"); \
-  SENSORS_MODULE_PARM(ignore_range, \
-                      "List of adapter,start-addr,end-addr triples not to " \
-                      "scan"); \
-  static struct i2c_address_data addr_data = \
-                                       {normal_i2c, normal_i2c_range, \
-                                        normal_isa, normal_isa_range, \
-                                        probe, probe_range, \
-                                        ignore, ignore_range, \
-                                        forces}
-
-/* The following functions create an enum with the chip names as elements. 
-   The first element of the enum is any_chip. These are the only macros
-   a module will want to use. */
-
-#define SENSORS_INSMOD_0 \
-  enum chips { any_chip }; \
-  SENSORS_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  static struct i2c_force_data forces[] = {{force,any_chip},{NULL}}; \
-  SENSORS_INSMOD
-
-#define SENSORS_INSMOD_1(chip1) \
-  enum chips { any_chip, chip1 }; \
-  SENSORS_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  SENSORS_MODULE_PARM_FORCE(chip1); \
-  static struct i2c_force_data forces[] = {{force,any_chip},\
-                                                 {force_ ## chip1,chip1}, \
-                                                 {NULL}}; \
-  SENSORS_INSMOD
-
-#define SENSORS_INSMOD_2(chip1,chip2) \
-  enum chips { any_chip, chip1, chip2 }; \
-  SENSORS_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  SENSORS_MODULE_PARM_FORCE(chip1); \
-  SENSORS_MODULE_PARM_FORCE(chip2); \
-  static struct i2c_force_data forces[] = {{force,any_chip}, \
-                                                 {force_ ## chip1,chip1}, \
-                                                 {force_ ## chip2,chip2}, \
-                                                 {NULL}}; \
-  SENSORS_INSMOD
-
-#define SENSORS_INSMOD_3(chip1,chip2,chip3) \
-  enum chips { any_chip, chip1, chip2, chip3 }; \
-  SENSORS_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  SENSORS_MODULE_PARM_FORCE(chip1); \
-  SENSORS_MODULE_PARM_FORCE(chip2); \
-  SENSORS_MODULE_PARM_FORCE(chip3); \
-  static struct i2c_force_data forces[] = {{force,any_chip}, \
-                                                 {force_ ## chip1,chip1}, \
-                                                 {force_ ## chip2,chip2}, \
-                                                 {force_ ## chip3,chip3}, \
-                                                 {NULL}}; \
-  SENSORS_INSMOD
-
-#define SENSORS_INSMOD_4(chip1,chip2,chip3,chip4) \
-  enum chips { any_chip, chip1, chip2, chip3, chip4 }; \
-  SENSORS_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  SENSORS_MODULE_PARM_FORCE(chip1); \
-  SENSORS_MODULE_PARM_FORCE(chip2); \
-  SENSORS_MODULE_PARM_FORCE(chip3); \
-  SENSORS_MODULE_PARM_FORCE(chip4); \
-  static struct i2c_force_data forces[] = {{force,any_chip}, \
-                                                 {force_ ## chip1,chip1}, \
-                                                 {force_ ## chip2,chip2}, \
-                                                 {force_ ## chip3,chip3}, \
-                                                 {force_ ## chip4,chip4}, \
-                                                 {NULL}}; \
-  SENSORS_INSMOD
-
-#define SENSORS_INSMOD_5(chip1,chip2,chip3,chip4,chip5) \
-  enum chips { any_chip, chip1, chip2, chip3, chip4, chip5 }; \
-  SENSORS_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  SENSORS_MODULE_PARM_FORCE(chip1); \
-  SENSORS_MODULE_PARM_FORCE(chip2); \
-  SENSORS_MODULE_PARM_FORCE(chip3); \
-  SENSORS_MODULE_PARM_FORCE(chip4); \
-  SENSORS_MODULE_PARM_FORCE(chip5); \
-  static struct i2c_force_data forces[] = {{force,any_chip}, \
-                                                 {force_ ## chip1,chip1}, \
-                                                 {force_ ## chip2,chip2}, \
-                                                 {force_ ## chip3,chip3}, \
-                                                 {force_ ## chip4,chip4}, \
-                                                 {force_ ## chip5,chip5}, \
-                                                 {NULL}}; \
-  SENSORS_INSMOD
-
-#define SENSORS_INSMOD_6(chip1,chip2,chip3,chip4,chip5,chip6) \
-  enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6 }; \
-  SENSORS_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  SENSORS_MODULE_PARM_FORCE(chip1); \
-  SENSORS_MODULE_PARM_FORCE(chip2); \
-  SENSORS_MODULE_PARM_FORCE(chip3); \
-  SENSORS_MODULE_PARM_FORCE(chip4); \
-  SENSORS_MODULE_PARM_FORCE(chip5); \
-  SENSORS_MODULE_PARM_FORCE(chip6); \
-  static struct i2c_force_data forces[] = {{force,any_chip}, \
-                                                 {force_ ## chip1,chip1}, \
-                                                 {force_ ## chip2,chip2}, \
-                                                 {force_ ## chip3,chip3}, \
-                                                 {force_ ## chip4,chip4}, \
-                                                 {force_ ## chip5,chip5}, \
-                                                 {force_ ## chip6,chip6}, \
-                                                 {NULL}}; \
-  SENSORS_INSMOD
-
-#define SENSORS_INSMOD_7(chip1,chip2,chip3,chip4,chip5,chip6,chip7) \
-  enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6, chip7 }; \
-  SENSORS_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  SENSORS_MODULE_PARM_FORCE(chip1); \
-  SENSORS_MODULE_PARM_FORCE(chip2); \
-  SENSORS_MODULE_PARM_FORCE(chip3); \
-  SENSORS_MODULE_PARM_FORCE(chip4); \
-  SENSORS_MODULE_PARM_FORCE(chip5); \
-  SENSORS_MODULE_PARM_FORCE(chip6); \
-  SENSORS_MODULE_PARM_FORCE(chip7); \
-  static struct i2c_force_data forces[] = {{force,any_chip}, \
-                                                 {force_ ## chip1,chip1}, \
-                                                 {force_ ## chip2,chip2}, \
-                                                 {force_ ## chip3,chip3}, \
-                                                 {force_ ## chip4,chip4}, \
-                                                 {force_ ## chip5,chip5}, \
-                                                 {force_ ## chip6,chip6}, \
-                                                 {force_ ## chip7,chip7}, \
-                                                 {NULL}}; \
-  SENSORS_INSMOD
-
-#define SENSORS_INSMOD_8(chip1,chip2,chip3,chip4,chip5,chip6,chip7,chip8) \
-  enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6, chip7, chip8 }; \
-  SENSORS_MODULE_PARM(force, \
-                      "List of adapter,address pairs to boldly assume " \
-                      "to be present"); \
-  SENSORS_MODULE_PARM_FORCE(chip1); \
-  SENSORS_MODULE_PARM_FORCE(chip2); \
-  SENSORS_MODULE_PARM_FORCE(chip3); \
-  SENSORS_MODULE_PARM_FORCE(chip4); \
-  SENSORS_MODULE_PARM_FORCE(chip5); \
-  SENSORS_MODULE_PARM_FORCE(chip6); \
-  SENSORS_MODULE_PARM_FORCE(chip7); \
-  SENSORS_MODULE_PARM_FORCE(chip8); \
-  static struct i2c_force_data forces[] = {{force,any_chip}, \
-                                                 {force_ ## chip1,chip1}, \
-                                                 {force_ ## chip2,chip2}, \
-                                                 {force_ ## chip3,chip3}, \
-                                                 {force_ ## chip4,chip4}, \
-                                                 {force_ ## chip5,chip5}, \
-                                                 {force_ ## chip6,chip6}, \
-                                                 {force_ ## chip7,chip7}, \
-                                                 {force_ ## chip8,chip8}, \
-                                                 {NULL}}; \
-  SENSORS_INSMOD
-
-typedef int i2c_found_addr_proc(struct i2c_adapter *adapter,
-				    int addr, int kind);
-
-/* Detect function. It iterates over all possible addresses itself. For
-   SMBus addresses, it will only call found_proc if some client is connected
-   to the SMBus (unless a 'force' matched); for ISA detections, this is not
-   done. */
-extern int i2c_detect(struct i2c_adapter *adapter,
-			  struct i2c_address_data *address_data,
-			  i2c_found_addr_proc * found_proc);
-
-
-/* This macro is used to scale user-input to sensible values in almost all
-   chip drivers. */
-static inline int SENSORS_LIMIT(long value, long low, long high)
-{
-	if (value < low)
-		return low;
-	else if (value > high)
-		return high;
-	else
-		return value;
-}
-
-
-/* The maximum length of the prefix */
-#define SENSORS_PREFIX_MAX 20
-
-/* Sysctl IDs */
-#ifdef DEV_HWMON
-#define DEV_SENSORS DEV_HWMON
-#else				/* ndef DEV_HWMOM */
-#define DEV_SENSORS 2		/* The id of the lm_sensors directory within the
-				   dev table */
-#endif				/* def DEV_HWMON */
-
-#define SENSORS_CHIPS 1
-struct i2c_chips_data {
-	int sysctl_id;
-	char name[SENSORS_PREFIX_MAX + 13];
-};
-
-#endif				/* def _LINUX_I2C_PROC_H */
-
diff -Nru a/include/linux/i2c-sensor.h b/include/linux/i2c-sensor.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/i2c-sensor.h	Wed Apr  2 16:00:46 2003
@@ -0,0 +1,373 @@
+/*
+    i2c-sensor.h - Part of the i2c package
+    was originally sensors.h - Part of lm_sensors, Linux kernel modules
+                               for hardware monitoring
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
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
+#ifndef _LINUX_I2C_SENSOR_H
+#define _LINUX_I2C_SENSOR_H
+
+#include <linux/sysctl.h>
+
+/* The type of callback functions used in sensors_{proc,sysctl}_real */
+typedef void (*i2c_real_callback) (struct i2c_client * client,
+				       int operation, int ctl_name,
+				       int *nrels_mag, long *results);
+
+/* Values for the operation field in the above function type */
+#define SENSORS_PROC_REAL_INFO 1
+#define SENSORS_PROC_REAL_READ 2
+#define SENSORS_PROC_REAL_WRITE 3
+
+/* A structure containing detect information.
+   Force variables overrule all other variables; they force a detection on
+   that place. If a specific chip is given, the module blindly assumes this
+   chip type is present; if a general force (kind == 0) is given, the module
+   will still try to figure out what type of chip is present. This is useful
+   if for some reasons the detect for SMBus or ISA address space filled
+   fails.
+   probe: insmod parameter. Initialize this list with SENSORS_I2C_END values.
+     A list of pairs. The first value is a bus number (SENSORS_ISA_BUS for
+     the ISA bus, -1 for any I2C bus), the second is the address. 
+   kind: The kind of chip. 0 equals any chip.
+*/
+struct i2c_force_data {
+	unsigned short *force;
+	unsigned short kind;
+};
+
+/* A structure containing the detect information.
+   normal_i2c: filled in by the module writer. Terminated by SENSORS_I2C_END.
+     A list of I2C addresses which should normally be examined.
+   normal_i2c_range: filled in by the module writer. Terminated by 
+     SENSORS_I2C_END
+     A list of pairs of I2C addresses, each pair being an inclusive range of
+     addresses which should normally be examined.
+   normal_isa: filled in by the module writer. Terminated by SENSORS_ISA_END.
+     A list of ISA addresses which should normally be examined.
+   normal_isa_range: filled in by the module writer. Terminated by 
+     SENSORS_ISA_END
+     A list of triples. The first two elements are ISA addresses, being an
+     range of addresses which should normally be examined. The third is the
+     modulo parameter: only addresses which are 0 module this value relative
+     to the first address of the range are actually considered.
+   probe: insmod parameter. Initialize this list with SENSORS_I2C_END values.
+     A list of pairs. The first value is a bus number (SENSORS_ISA_BUS for
+     the ISA bus, -1 for any I2C bus), the second is the address. These
+     addresses are also probed, as if they were in the 'normal' list.
+   probe_range: insmod parameter. Initialize this list with SENSORS_I2C_END 
+     values.
+     A list of triples. The first value is a bus number (SENSORS_ISA_BUS for
+     the ISA bus, -1 for any I2C bus), the second and third are addresses. 
+     These form an inclusive range of addresses that are also probed, as
+     if they were in the 'normal' list.
+   ignore: insmod parameter. Initialize this list with SENSORS_I2C_END values.
+     A list of pairs. The first value is a bus number (SENSORS_ISA_BUS for
+     the ISA bus, -1 for any I2C bus), the second is the I2C address. These
+     addresses are never probed. This parameter overrules 'normal' and 
+     'probe', but not the 'force' lists.
+   ignore_range: insmod parameter. Initialize this list with SENSORS_I2C_END 
+      values.
+     A list of triples. The first value is a bus number (SENSORS_ISA_BUS for
+     the ISA bus, -1 for any I2C bus), the second and third are addresses. 
+     These form an inclusive range of I2C addresses that are never probed.
+     This parameter overrules 'normal' and 'probe', but not the 'force' lists.
+   force_data: insmod parameters. A list, ending with an element of which
+     the force field is NULL.
+*/
+struct i2c_address_data {
+	unsigned short *normal_i2c;
+	unsigned short *normal_i2c_range;
+	unsigned int *normal_isa;
+	unsigned int *normal_isa_range;
+	unsigned short *probe;
+	unsigned short *probe_range;
+	unsigned short *ignore;
+	unsigned short *ignore_range;
+	struct i2c_force_data *forces;
+};
+
+/* Internal numbers to terminate lists */
+#define SENSORS_I2C_END 0xfffe
+#define SENSORS_ISA_END 0xfffefffe
+
+/* The numbers to use to set an ISA or I2C bus address */
+#define SENSORS_ISA_BUS 9191
+#define SENSORS_ANY_I2C_BUS 0xffff
+
+/* The length of the option lists */
+#define SENSORS_MAX_OPTS 48
+
+/* Default fill of many variables */
+#define SENSORS_DEFAULTS {SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END, \
+                          SENSORS_I2C_END, SENSORS_I2C_END, SENSORS_I2C_END}
+
+/* This is ugly. We need to evaluate SENSORS_MAX_OPTS before it is 
+   stringified */
+#define SENSORS_MODPARM_AUX1(x) "1-" #x "h"
+#define SENSORS_MODPARM_AUX(x) SENSORS_MODPARM_AUX1(x)
+#define SENSORS_MODPARM SENSORS_MODPARM_AUX(SENSORS_MAX_OPTS)
+
+/* SENSORS_MODULE_PARM creates a module parameter, and puts it in the
+   module header */
+#define SENSORS_MODULE_PARM(var,desc) \
+  static unsigned short var[SENSORS_MAX_OPTS] = SENSORS_DEFAULTS; \
+  MODULE_PARM(var,SENSORS_MODPARM); \
+  MODULE_PARM_DESC(var,desc)
+
+/* SENSORS_MODULE_PARM creates a 'force_*' module parameter, and puts it in
+   the module header */
+#define SENSORS_MODULE_PARM_FORCE(name) \
+  SENSORS_MODULE_PARM(force_ ## name, \
+                      "List of adapter,address pairs which are unquestionably" \
+                      " assumed to contain a `" # name "' chip")
+
+
+/* This defines several insmod variables, and the addr_data structure */
+#define SENSORS_INSMOD \
+  SENSORS_MODULE_PARM(probe, \
+                      "List of adapter,address pairs to scan additionally"); \
+  SENSORS_MODULE_PARM(probe_range, \
+                      "List of adapter,start-addr,end-addr triples to scan " \
+                      "additionally"); \
+  SENSORS_MODULE_PARM(ignore, \
+                      "List of adapter,address pairs not to scan"); \
+  SENSORS_MODULE_PARM(ignore_range, \
+                      "List of adapter,start-addr,end-addr triples not to " \
+                      "scan"); \
+  static struct i2c_address_data addr_data = \
+                                       {normal_i2c, normal_i2c_range, \
+                                        normal_isa, normal_isa_range, \
+                                        probe, probe_range, \
+                                        ignore, ignore_range, \
+                                        forces}
+
+/* The following functions create an enum with the chip names as elements. 
+   The first element of the enum is any_chip. These are the only macros
+   a module will want to use. */
+
+#define SENSORS_INSMOD_0 \
+  enum chips { any_chip }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  static struct i2c_force_data forces[] = {{force,any_chip},{NULL}}; \
+  SENSORS_INSMOD
+
+#define SENSORS_INSMOD_1(chip1) \
+  enum chips { any_chip, chip1 }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  SENSORS_MODULE_PARM_FORCE(chip1); \
+  static struct i2c_force_data forces[] = {{force,any_chip},\
+                                                 {force_ ## chip1,chip1}, \
+                                                 {NULL}}; \
+  SENSORS_INSMOD
+
+#define SENSORS_INSMOD_2(chip1,chip2) \
+  enum chips { any_chip, chip1, chip2 }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  SENSORS_MODULE_PARM_FORCE(chip1); \
+  SENSORS_MODULE_PARM_FORCE(chip2); \
+  static struct i2c_force_data forces[] = {{force,any_chip}, \
+                                                 {force_ ## chip1,chip1}, \
+                                                 {force_ ## chip2,chip2}, \
+                                                 {NULL}}; \
+  SENSORS_INSMOD
+
+#define SENSORS_INSMOD_3(chip1,chip2,chip3) \
+  enum chips { any_chip, chip1, chip2, chip3 }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  SENSORS_MODULE_PARM_FORCE(chip1); \
+  SENSORS_MODULE_PARM_FORCE(chip2); \
+  SENSORS_MODULE_PARM_FORCE(chip3); \
+  static struct i2c_force_data forces[] = {{force,any_chip}, \
+                                                 {force_ ## chip1,chip1}, \
+                                                 {force_ ## chip2,chip2}, \
+                                                 {force_ ## chip3,chip3}, \
+                                                 {NULL}}; \
+  SENSORS_INSMOD
+
+#define SENSORS_INSMOD_4(chip1,chip2,chip3,chip4) \
+  enum chips { any_chip, chip1, chip2, chip3, chip4 }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  SENSORS_MODULE_PARM_FORCE(chip1); \
+  SENSORS_MODULE_PARM_FORCE(chip2); \
+  SENSORS_MODULE_PARM_FORCE(chip3); \
+  SENSORS_MODULE_PARM_FORCE(chip4); \
+  static struct i2c_force_data forces[] = {{force,any_chip}, \
+                                                 {force_ ## chip1,chip1}, \
+                                                 {force_ ## chip2,chip2}, \
+                                                 {force_ ## chip3,chip3}, \
+                                                 {force_ ## chip4,chip4}, \
+                                                 {NULL}}; \
+  SENSORS_INSMOD
+
+#define SENSORS_INSMOD_5(chip1,chip2,chip3,chip4,chip5) \
+  enum chips { any_chip, chip1, chip2, chip3, chip4, chip5 }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  SENSORS_MODULE_PARM_FORCE(chip1); \
+  SENSORS_MODULE_PARM_FORCE(chip2); \
+  SENSORS_MODULE_PARM_FORCE(chip3); \
+  SENSORS_MODULE_PARM_FORCE(chip4); \
+  SENSORS_MODULE_PARM_FORCE(chip5); \
+  static struct i2c_force_data forces[] = {{force,any_chip}, \
+                                                 {force_ ## chip1,chip1}, \
+                                                 {force_ ## chip2,chip2}, \
+                                                 {force_ ## chip3,chip3}, \
+                                                 {force_ ## chip4,chip4}, \
+                                                 {force_ ## chip5,chip5}, \
+                                                 {NULL}}; \
+  SENSORS_INSMOD
+
+#define SENSORS_INSMOD_6(chip1,chip2,chip3,chip4,chip5,chip6) \
+  enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6 }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  SENSORS_MODULE_PARM_FORCE(chip1); \
+  SENSORS_MODULE_PARM_FORCE(chip2); \
+  SENSORS_MODULE_PARM_FORCE(chip3); \
+  SENSORS_MODULE_PARM_FORCE(chip4); \
+  SENSORS_MODULE_PARM_FORCE(chip5); \
+  SENSORS_MODULE_PARM_FORCE(chip6); \
+  static struct i2c_force_data forces[] = {{force,any_chip}, \
+                                                 {force_ ## chip1,chip1}, \
+                                                 {force_ ## chip2,chip2}, \
+                                                 {force_ ## chip3,chip3}, \
+                                                 {force_ ## chip4,chip4}, \
+                                                 {force_ ## chip5,chip5}, \
+                                                 {force_ ## chip6,chip6}, \
+                                                 {NULL}}; \
+  SENSORS_INSMOD
+
+#define SENSORS_INSMOD_7(chip1,chip2,chip3,chip4,chip5,chip6,chip7) \
+  enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6, chip7 }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  SENSORS_MODULE_PARM_FORCE(chip1); \
+  SENSORS_MODULE_PARM_FORCE(chip2); \
+  SENSORS_MODULE_PARM_FORCE(chip3); \
+  SENSORS_MODULE_PARM_FORCE(chip4); \
+  SENSORS_MODULE_PARM_FORCE(chip5); \
+  SENSORS_MODULE_PARM_FORCE(chip6); \
+  SENSORS_MODULE_PARM_FORCE(chip7); \
+  static struct i2c_force_data forces[] = {{force,any_chip}, \
+                                                 {force_ ## chip1,chip1}, \
+                                                 {force_ ## chip2,chip2}, \
+                                                 {force_ ## chip3,chip3}, \
+                                                 {force_ ## chip4,chip4}, \
+                                                 {force_ ## chip5,chip5}, \
+                                                 {force_ ## chip6,chip6}, \
+                                                 {force_ ## chip7,chip7}, \
+                                                 {NULL}}; \
+  SENSORS_INSMOD
+
+#define SENSORS_INSMOD_8(chip1,chip2,chip3,chip4,chip5,chip6,chip7,chip8) \
+  enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6, chip7, chip8 }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  SENSORS_MODULE_PARM_FORCE(chip1); \
+  SENSORS_MODULE_PARM_FORCE(chip2); \
+  SENSORS_MODULE_PARM_FORCE(chip3); \
+  SENSORS_MODULE_PARM_FORCE(chip4); \
+  SENSORS_MODULE_PARM_FORCE(chip5); \
+  SENSORS_MODULE_PARM_FORCE(chip6); \
+  SENSORS_MODULE_PARM_FORCE(chip7); \
+  SENSORS_MODULE_PARM_FORCE(chip8); \
+  static struct i2c_force_data forces[] = {{force,any_chip}, \
+                                                 {force_ ## chip1,chip1}, \
+                                                 {force_ ## chip2,chip2}, \
+                                                 {force_ ## chip3,chip3}, \
+                                                 {force_ ## chip4,chip4}, \
+                                                 {force_ ## chip5,chip5}, \
+                                                 {force_ ## chip6,chip6}, \
+                                                 {force_ ## chip7,chip7}, \
+                                                 {force_ ## chip8,chip8}, \
+                                                 {NULL}}; \
+  SENSORS_INSMOD
+
+typedef int i2c_found_addr_proc(struct i2c_adapter *adapter,
+				    int addr, int kind);
+
+/* Detect function. It iterates over all possible addresses itself. For
+   SMBus addresses, it will only call found_proc if some client is connected
+   to the SMBus (unless a 'force' matched); for ISA detections, this is not
+   done. */
+extern int i2c_detect(struct i2c_adapter *adapter,
+			  struct i2c_address_data *address_data,
+			  i2c_found_addr_proc * found_proc);
+
+
+/* This macro is used to scale user-input to sensible values in almost all
+   chip drivers. */
+static inline int SENSORS_LIMIT(long value, long low, long high)
+{
+	if (value < low)
+		return low;
+	else if (value > high)
+		return high;
+	else
+		return value;
+}
+
+
+/* The maximum length of the prefix */
+#define SENSORS_PREFIX_MAX 20
+
+/* Sysctl IDs */
+#ifdef DEV_HWMON
+#define DEV_SENSORS DEV_HWMON
+#else				/* ndef DEV_HWMOM */
+#define DEV_SENSORS 2		/* The id of the lm_sensors directory within the
+				   dev table */
+#endif				/* def DEV_HWMON */
+
+#define SENSORS_CHIPS 1
+struct i2c_chips_data {
+	int sysctl_id;
+	char name[SENSORS_PREFIX_MAX + 13];
+};
+
+#endif				/* def _LINUX_I2C_SENSOR_H */
+

