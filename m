Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161430AbWHJQXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161430AbWHJQXk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161432AbWHJQXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:23:40 -0400
Received: from tango.0pointer.de ([217.160.223.3]:16396 "EHLO
	tango.0pointer.de") by vger.kernel.org with ESMTP id S1161430AbWHJQXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:23:36 -0400
Date: Thu, 10 Aug 2006 18:23:29 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH,RFC]: acpi,backlight: MSI S270 - driver, second try
Message-ID: <20060810162329.GA11603@curacao>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: .phi.
X-Campaign-1: ()  ASCII Ribbon Campaign
X-Campaign-2: /  Against HTML Email & vCards - Against Microsoft Attachments
X-Disclaimer-1: Diese Nachricht wurde mit einer elektronischen 
X-Disclaimer-2: Datenverarbeitungsanlage erstellt und bedarf daher 
X-Disclaimer-3: keiner Unterschrift.
User-Agent: Leviathan/19.8.0 [zh] (Cray 3; I; Solaris 4.711; Console)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lennart Poettering <mzxreary@0pointer.de>

This is my second try of the MSI S270 laptop driver. On request of Len
Brown I changed the following things:

- Move driver from drivers/acpi/s270.c to drivers/misc/s270.c

- Remove /proc/acpi/s270 interface, replace it by a platform device
  /sys/devices/platform/s270pf/. This means: no procfs is touched
  anymore, all features are now accessible through /sys/.

This patch applies to 2.6.17 and requires the ACPI ec_transaction()
patch I posted earlier:

http://marc.theaimsgroup.com/?l=linux-acpi&m=115517193511970&w=2

Please comment and/or apply!

Lennart
Signed-off-by: Lennart Poettering <mzxreary@0pointer.de>

---
--- linux-source-2.6.17.orig/MAINTAINERS	2006-06-18 03:49:35.000000000 +0200
+++ linux-source-2.6.17/MAINTAINERS	2006-08-10 01:16:50.000000000 +0200
@@ -1882,6 +1882,13 @@ M:	rubini@ipvvis.unipv.it
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+MSI S270 LAPTOP SUPPORT
+P:	Lennart Poettering
+M:	mzxreary@0pointer.de
+L:	https://tango.0pointer.de/mailman/listinfo/s270-linux
+W:	http://0pointer.de/lennart/tchibo.html
+S:	Maintained
+
 MTRR AND SIMILAR SUPPORT [i386]
 P:	Richard Gooch
 M:	rgooch@atnf.csiro.au
--- linux-source-2.6.17.orig/drivers/misc/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-source-2.6.17/drivers/misc/Kconfig	2006-08-10 17:45:46.000000000 +0200
@@ -28,5 +28,19 @@ config IBM_ASM
 
 	  If unsure, say N.
 
+config MSI_S270
+        tristate "MSI S270 Laptop Extras"
+        depends on X86
+        depends on ACPI_EC
+        depends on BACKLIGHT_CLASS_DEVICE
+        ---help---
+          This is a driver for MSI S270 laptops. It adds
+          support for Bluetooth, WLAN and LCD brightness control.
+
+          More information about this driver is available at
+          <http://0pointer.de/lennart/tchibo.html>.
+
+          If you have an MSI S270 laptop, say Y or M here.
+
 endmenu
 
--- linux-source-2.6.17.orig/drivers/misc/Makefile	2006-06-18 03:49:35.000000000 +0200
+++ linux-source-2.6.17/drivers/misc/Makefile	2006-08-10 17:43:54.000000000 +0200
@@ -5,3 +5,4 @@ obj- := misc.o	# Dummy rule to force bui
 
 obj-$(CONFIG_IBM_ASM)	+= ibmasm/
 obj-$(CONFIG_HDPU_FEATURES)	+= hdpuftrs/
+obj-$(CONFIG_MSI_S270)     += s270.o
--- linux-source-2.6.17.orig/drivers/misc/s270.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-source-2.6.17/drivers/misc/s270.c	2006-08-10 18:05:22.000000000 +0200
@@ -0,0 +1,372 @@
+/*-*-linux-c-*-*/
+
+/* $Id: s270.c 109 2006-08-10 16:05:22Z lennart $ */
+
+/***
+  Copyright (C) 2006 Lennart Poettering <mzxreary (at) 0pointer (dot) de>
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+  General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+  02110-1301, USA.
+***/
+
+/*
+ * s270.c - MSI S270 laptop support. This laptop is sold under various
+ * brands, including "Cytron/TCM/Medion/Tchibo MD96100".
+ *
+ * This driver exports a few files in /sys/devices/platform/s270pf/:
+ *
+ *   lcd_level - Screen brightness: contains a single integer in the
+ *   range 0..8. (rw)
+ * 
+ *   auto_brightness - Enable automatic brightness control: contains
+ *   either 0 or 1. If set to 1 the hardware adjusts the screen
+ *   brightness automatically when the power cord is
+ *   plugged/unplugged. (rw)
+ *
+ *   wlan - WLAN subsystem enabled: contains either 0 or 1. (ro)
+ *
+ *   bluetooth - Bluetooth subsystem enabled: contains either 0 or 1
+ *   Please note that this file is constantly 0 if no Bluetooth
+ *   hardware is available. (ro)
+ *
+ * In addition to these platform device attributes the driver
+ * registers itself in the Linux backlight control subsystem and is
+ * available to userspace under /sys/class/backlight/s270bl/.
+ *
+ * This driver might work on other laptops produced by MSI. If you
+ * want to try it you can pass force=1 as argument to the module which
+ * will force it to load even when the DMI data doesn't identify the
+ * laptop as MSI S270. YMMV.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+#include <linux/backlight.h>
+#include <linux/platform_device.h>
+#include <linux/autoconf.h>
+
+#define S270_VERSION "0.2"
+
+#define MSI_LCD_LEVEL_MAX 9
+
+#define MSI_EC_COMMAND_WIRELESS 0x10
+#define MSI_EC_COMMAND_LCD_LEVEL 0x11
+
+static int force;
+module_param(force, bool, 0);
+MODULE_PARM_DESC(force, "Force driver load, ignore DMI data");
+
+static int auto_brightness;
+module_param(auto_brightness, int, 0);
+MODULE_PARM_DESC(auto_brightness, "Enable automatic brightness control (0: disabled; 1: enabled; 2: don't touch)");
+
+/*** Hardware access ***/
+
+static const uint8_t lcd_table[MSI_LCD_LEVEL_MAX] = {
+        0x00, 0x1f, 0x3e, 0x5d, 0x7c, 0x9b, 0xba, 0xd9, 0xf8
+};
+
+static int set_lcd_level(int level) {
+        u8 buf[2];
+        
+        if (level < 0 || level >= MSI_LCD_LEVEL_MAX)
+                return -EINVAL;
+        
+        buf[0] = 0x80;
+        buf[1] = lcd_table[level];
+        
+        return ec_transaction(MSI_EC_COMMAND_LCD_LEVEL, buf, sizeof(buf), NULL, 0);
+}
+
+static int get_lcd_level(void) {
+        u8 wdata = 0, rdata;
+        int i, result;
+        
+        if ((result = ec_transaction(MSI_EC_COMMAND_LCD_LEVEL, &wdata, 1, &rdata, 1)) < 0)
+                return result;
+        
+        for (i = 0; i < MSI_LCD_LEVEL_MAX; i++)
+                if (lcd_table[i] == rdata)
+                        return i;
+        
+        return -EIO;
+}
+
+static int get_auto_brightness(void) {
+        u8 wdata = 4, rdata;
+        int result;
+        
+        if ((result = ec_transaction(MSI_EC_COMMAND_LCD_LEVEL, &wdata, 1, &rdata, 1)) < 0)
+                return result;
+
+        return !!(rdata & 8);
+}
+
+static int set_auto_brightness(int enable) {
+        u8 wdata[2], rdata;
+        int result;
+        
+        wdata[0] = 4;
+            
+        if ((result = ec_transaction(MSI_EC_COMMAND_LCD_LEVEL, wdata, 1, &rdata, 1)) < 0)
+                return result;
+            
+        wdata[0] = 0x84;
+        wdata[1] = (rdata & 0xF7) | (enable ? 8 : 0);
+
+        return ec_transaction(MSI_EC_COMMAND_LCD_LEVEL, wdata, 2, NULL, 0);
+}
+
+static int get_wireless_state(int *wlan, int *bluetooth) {
+        u8 wdata = 0, rdata;
+        int result;
+
+        if ((result = ec_transaction(MSI_EC_COMMAND_WIRELESS, &wdata, 1, &rdata, 1)) < 0)
+                return -1;
+
+        if (wlan)
+                *wlan = !!(rdata & 8);
+
+        if (bluetooth)
+                *bluetooth = !!(rdata & 128);
+        
+        return 0;
+}
+
+/*** Backlight device stuff ***/
+
+static int bl_get_brightness(struct backlight_device *b) {
+        return get_lcd_level();
+}
+
+
+static int bl_update_status(struct backlight_device *b) {
+        return set_lcd_level(b->props->brightness);
+}
+
+static struct backlight_properties s270bl_props = {
+        .owner		= THIS_MODULE,
+	.get_brightness = bl_get_brightness,
+        .update_status  = bl_update_status,
+	.max_brightness = MSI_LCD_LEVEL_MAX,
+};
+
+static struct backlight_device *s270bl_device;
+
+/*** Platform device ***/
+
+static ssize_t show_wlan(
+        struct device *dev,
+        struct device_attribute *attr,
+        char *buf) {
+
+        int ret, enabled;
+
+        if ((ret = get_wireless_state(&enabled, NULL)) < 0)
+                return ret;
+
+        return sprintf(buf, "%i\n", enabled);
+}
+
+static ssize_t show_bluetooth(
+        struct device *dev,
+        struct device_attribute *attr,
+        char *buf) {
+
+        int ret, enabled;
+
+        if ((ret = get_wireless_state(NULL, &enabled)) < 0)
+                return ret;
+
+        return sprintf(buf, "%i\n", enabled);
+}
+
+static ssize_t show_lcd_level(
+        struct device *dev,
+        struct device_attribute *attr,
+        char *buf) {
+
+        int ret;
+
+        if ((ret = get_lcd_level()) < 0)
+                return ret;
+        
+        return sprintf(buf, "%i\n", ret);
+}
+
+static ssize_t store_lcd_level(
+        struct device *dev,
+        struct device_attribute *attr,
+        const char *buf, size_t count) {
+        
+        int level, ret;
+
+        if (sscanf(buf, "%i", &level) != 1 || (level < 0 || level > 8))
+                return -EINVAL;
+
+        if ((ret = set_lcd_level(level)) < 0)
+                return ret;
+        
+        return count;
+}
+
+static ssize_t show_auto_brightness(
+        struct device *dev,
+        struct device_attribute *attr,
+        char *buf) {
+
+        int ret;
+
+        if ((ret = get_auto_brightness()) < 0)
+                return ret;
+        
+        return sprintf(buf, "%i\n", ret);
+}
+
+static ssize_t store_auto_brightness(
+        struct device *dev,
+        struct device_attribute *attr,
+        const char *buf, size_t count) {
+        
+        int enable, ret;
+
+        if (sscanf(buf, "%i", &enable) != 1 || (enable != (enable & 1)))
+                return -EINVAL;
+
+        if ((ret = set_auto_brightness(enable)) < 0)
+                return ret;
+        
+        return count;
+}
+
+static DEVICE_ATTR(lcd_level, 0644, show_lcd_level, store_lcd_level);
+static DEVICE_ATTR(auto_brightness, 0644, show_auto_brightness, store_auto_brightness);
+static DEVICE_ATTR(bluetooth, 0444, show_bluetooth, NULL);
+static DEVICE_ATTR(wlan, 0444, show_wlan, NULL);
+
+static struct attribute *s270pf_attributes[] = {
+	&dev_attr_lcd_level.attr,
+	&dev_attr_auto_brightness.attr,
+	&dev_attr_bluetooth.attr,
+	&dev_attr_wlan.attr,
+	NULL
+};
+
+static struct attribute_group s270pf_attribute_group = {
+	.attrs = s270pf_attributes
+};
+
+static struct platform_driver s270pf_driver = {
+	.driver = {
+		.name = "s270pf",
+		.owner = THIS_MODULE,
+	}
+};
+
+static struct platform_device *s270pf_device;
+
+/*** Initialization ***/
+
+static struct dmi_system_id __initdata s270_dmi_table[] = { {
+        .ident = "MSI S270",
+        .matches = {
+                DMI_MATCH(DMI_SYS_VENDOR, "NOTEBOOK"),
+                DMI_MATCH(DMI_PRODUCT_NAME, "SAM2000"),
+        }
+}, { } };
+
+
+static int __init s270_init(void) {
+        int ret;
+
+        if (acpi_disabled)
+                return -ENODEV;
+
+        if (!force && !dmi_check_system(s270_dmi_table))
+                return -ENODEV;
+
+        if (auto_brightness < 0 || auto_brightness > 2)
+                return -EINVAL;
+
+        /* Register backlight stuff */
+        
+        s270bl_device = backlight_device_register("s270bl", NULL, &s270bl_props);
+        if (IS_ERR(s270bl_device))
+                return PTR_ERR(s270bl_device);
+
+        if ((ret = platform_driver_register(&s270pf_driver)))
+                goto fail_backlight;
+
+        /* Register platform stuff */
+        
+        s270pf_device = platform_device_register_simple("s270pf", -1, NULL, 0);
+	if (IS_ERR(s270pf_device)) {
+		ret = PTR_ERR(s270pf_device);
+		goto fail_platform_driver;
+	}
+
+        if ((ret = sysfs_create_group(&s270pf_device->dev.kobj, &s270pf_attribute_group)))
+                goto fail_platform_device;
+
+        /* Disable automatic brightness control by default because
+         * this module was probably loaded to do brightness control in
+         * software. */
+
+        if (auto_brightness != 2)
+                set_auto_brightness(auto_brightness);
+        
+        printk(KERN_INFO "s270: driver "S270_VERSION" successfully loaded.\n");
+        
+        return 0;
+
+fail_platform_device:
+        
+        platform_device_unregister(s270pf_device);
+
+fail_platform_driver:
+
+        platform_driver_unregister(&s270pf_driver);
+        
+fail_backlight:
+
+        backlight_device_unregister(s270bl_device);
+        
+        return ret;
+}
+
+static void __exit s270_cleanup(void) {
+
+        sysfs_remove_group(&s270pf_device->dev.kobj, &s270pf_attribute_group);
+        platform_device_unregister(s270pf_device);
+        platform_driver_unregister(&s270pf_driver);
+        backlight_device_unregister(s270bl_device);
+
+        /* Enable automatic brightness control again */
+        if (auto_brightness != 2)
+                set_auto_brightness(1);     
+
+        printk(KERN_INFO "s270: driver unloaded.\n");
+}
+
+module_init(s270_init);
+module_exit(s270_cleanup);
+
+MODULE_AUTHOR("Lennart Poettering");
+MODULE_DESCRIPTION("MSI S270 Laptop Support");
+MODULE_VERSION(S270_VERSION);
+MODULE_LICENSE("GPL");
