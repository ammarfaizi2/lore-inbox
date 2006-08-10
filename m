Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030454AbWHJBFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbWHJBFZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWHJBFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:05:24 -0400
Received: from tango.0pointer.de ([217.160.223.3]:42762 "EHLO
	tango.0pointer.de") by vger.kernel.org with ESMTP id S932496AbWHJBFU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:05:20 -0400
Date: Thu, 10 Aug 2006 03:05:17 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: len.brown@intel.com
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] acpi,backlight: MSI S270 laptop support - driver
Message-ID: <20060810010517.GA20849@curacao>
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

The attached patch adds support for some special functions of MSI S270
laptops: LCD brightness control and Bluetooth/WLAN status.

This patch requires the ec_transaction() patch sent before.

The driver registers a few files in /proc/acpi/s270/. In addition it
registers itself in the backlight subsystem and is available to
userspace in /sys/class/backlight/s270/.

Based on 2.6.17

Please comment and/or apply!

Lennart

Signed-off-by: Lennart Poettering <mzxreary@0pointer.de>
---
--- linux-source-2.6.17/drivers/acpi/s270.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-source-2.6.17.lennart/drivers/acpi/s270.c	2006-08-10 00:58:25.000000000 +0200
@@ -0,0 +1,375 @@
+/*-*-linux-c-*-*/
+
+/* $Id: s270.c 107 2006-08-09 22:58:25Z lennart $ */
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
+ * This driver exports a few files in /proc/acpi/s270/:
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
+ * In addition to these /proc files the driver registers itself in the
+ * Linux backlight control subsystem and is available to userspace under
+ * /sys/class/backlight/s270/.
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
+#include <linux/proc_fs.h>
+#include <linux/autoconf.h>
+#include <asm/uaccess.h>
+
+#define MSI_LCD_LEVEL_MAX 9
+
+#define MSI_EC_COMMAND_WIRELESS 0x10
+#define MSI_EC_COMMAND_LCD_LEVEL 0x11
+
+#define PROCFS_S270_PREFIX "s270"
+#define PROCFS_S270_LCD_LEVEL "lcd_level"
+#define PROCFS_S270_AUTO_BRIGHTNESS "auto_brightness"
+#define PROCFS_S270_WLAN "wlan"
+#define PROCFS_S270_BLUETOOTH "bluetooth"
+
+static int force;
+module_param(force, int, 0);
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
+/*** procfs stuff ***/
+
+static struct proc_dir_entry *s270_procfs_dir;
+
+struct s270_procfs_item {
+        const char *name;
+        mode_t mode;
+        int (*read_func)(void);
+        int (*write_func)(int value);
+};
+
+static int procfs_wlan_read_func(void) {
+        int b, ret;
+
+        if ((ret = get_wireless_state(&b, NULL)) < 0)
+                return ret;
+
+        return b;
+}
+
+static int procfs_bluetooth_read_func(void) {
+        int b, ret;
+
+        if ((ret = get_wireless_state(NULL, &b)) < 0)
+                return ret;
+
+        return b;
+}
+
+static int dispatch_read(char *page, char **start, off_t off, int count, int *eof, void *data) {
+        const struct s270_procfs_item *item = data;
+        int value;
+
+        if (!item || !item->read_func)
+                return -EINVAL;
+
+        if ((value = item->read_func()) < 0)
+                return value;
+
+        if (off > 0) {
+                *eof = 1;
+                return 0;
+        }
+        
+        return sprintf(page, "%i\n", value);
+}
+
+static int dispatch_write(struct file *file, const char __user *userbuf, unsigned long count, void *data) {
+        const struct s270_procfs_item *item = data;
+        char *kernbuf;
+        int value, ret;
+        
+        if (!item || !item->write_func)
+                return -EINVAL;
+
+        if (!(kernbuf = kmalloc(count + 1, GFP_KERNEL)))
+                return -ENOMEM;
+
+        if (copy_from_user(kernbuf, userbuf, count)) {
+                kfree(kernbuf);
+                return -EFAULT;
+        }
+
+        kernbuf[count] = 0;
+
+        if (sscanf(kernbuf, "%i", &value) != 1) {
+                kfree(kernbuf);
+                return -EINVAL;
+        }
+
+        kfree(kernbuf);
+        
+        if ((ret = item->write_func(value)) < 0)
+                return ret;
+
+        return count;
+}
+
+static const struct s270_procfs_item s270_procfs_items[] = {
+        {
+                PROCFS_S270_LCD_LEVEL,
+                S_IFREG|S_IRUGO|S_IWUSR,
+                get_lcd_level,
+                set_lcd_level
+        }, {
+                PROCFS_S270_AUTO_BRIGHTNESS,
+                S_IFREG|S_IRUGO|S_IWUSR,
+                get_auto_brightness,
+                set_auto_brightness
+        }, {
+                PROCFS_S270_WLAN,
+                S_IFREG|S_IRUGO,
+                procfs_wlan_read_func,
+                NULL
+        }, {
+                PROCFS_S270_BLUETOOTH,
+                S_IFREG|S_IRUGO,
+                procfs_bluetooth_read_func,
+                NULL
+        }, { }
+};
+        
+static int __init add_procfs_files(void) {
+        const struct s270_procfs_item *item;
+
+        for (item = s270_procfs_items; item->name; item++) {
+                struct proc_dir_entry *proc;
+                
+                if (!(proc = create_proc_read_entry(
+                        item->name,
+                        item->mode,
+                        s270_procfs_dir,
+                        dispatch_read,
+                        (void*) item)))
+                        return -ENOMEM;
+                
+                proc->owner = THIS_MODULE;
+                proc->write_proc = dispatch_write;
+        }
+
+        return 0;
+}
+
+static void __exit remove_procfs_files(void) {
+        const struct s270_procfs_item *item;
+
+        for (item = s270_procfs_items; item->name; item++)
+                remove_proc_entry(item->name, s270_procfs_dir);
+}
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
+static int __init init_s270(void) {
+        int ret;
+
+        if (acpi_disabled)
+                return -ENODEV;
+
+        if (!force && !dmi_check_system(s270_dmi_table))
+                return -ENODEV;
+
+        s270bl_device = backlight_device_register("s270", NULL, &s270bl_props);
+        
+        if (IS_ERR(s270bl_device))
+                return PTR_ERR(s270bl_device);
+
+        if (!(s270_procfs_dir = proc_mkdir(PROCFS_S270_PREFIX, acpi_root_dir))) {
+                ret = -ENOMEM;
+                goto fail;
+        }
+
+        s270_procfs_dir->owner = THIS_MODULE;
+
+        if ((ret = add_procfs_files()) < 0)
+                goto fail;
+
+        /* Disable automatic brightness control by default, because
+         * this module was probably loaded to do brightness control in
+         * software. */
+         set_auto_brightness(0); 
+        
+        return 0;
+
+fail:
+
+        if (s270_procfs_dir) {
+                remove_procfs_files();
+                remove_proc_entry(PROCFS_S270_PREFIX, acpi_root_dir);
+        }
+
+        if (s270bl_device)
+                backlight_device_unregister(s270bl_device);
+
+        return ret;
+}
+
+static void __exit cleanup_s270(void) {
+
+        if (s270_procfs_dir) {
+                remove_procfs_files();
+                remove_proc_entry(PROCFS_S270_PREFIX, acpi_root_dir);
+        }
+
+        if (s270bl_device)
+                backlight_device_unregister(s270bl_device);
+
+        /* Enable automatic brightness control again */
+        set_auto_brightness(1);       
+}
+
+module_init(init_s270);
+module_exit(cleanup_s270);
+
+MODULE_AUTHOR("Lennart Poettering");
+MODULE_DESCRIPTION("MSI S270 Laptop Support");
+MODULE_VERSION("0.1");
+MODULE_LICENSE("GPL");
--- linux-source-2.6.17/drivers/acpi/Makefile	2006-06-18 03:49:35.000000000 +0200
+++ linux-source-2.6.17.lennart/drivers/acpi/Makefile	2006-08-10 01:41:58.000000000 +0200
@@ -55,5 +55,6 @@ obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
+obj-$(CONFIG_ACPI_MSI_S270)     += s270.o
 obj-y				+= scan.o motherboard.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
--- linux-source-2.6.17/drivers/acpi/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-source-2.6.17.lennart/drivers/acpi/Kconfig	2006-08-10 01:40:43.000000000 +0200
@@ -243,6 +243,19 @@ config ACPI_TOSHIBA
 	  If you have a legacy free Toshiba laptop (such as the Libretto L1
 	  series), say Y.
 
+config ACPI_MSI_S270
+	tristate "MSI S270 Laptop Extras"
+	depends on X86
+    depends on BACKLIGHT_CLASS_DEVICE
+	---help---
+	  This is a Linux ACPI driver for MSI S270 laptops. It adds
+	  support for Bluetooth, WLAN and LCD brightness control.
+
+	  More information about this driver is available at
+	  <http://0pointer.de/lennart/tchibo.html>.
+
+	  If you have an MSI S270 laptop, say Y or M here.
+
 config ACPI_CUSTOM_DSDT
 	bool "Include Custom DSDT"
 	depends on !STANDALONE
--- linux-source-2.6.17/MAINTAINERS	2006-06-18 03:49:35.000000000 +0200
+++ linux-source-2.6.17.lennart/MAINTAINERS	2006-08-10 01:16:50.000000000 +0200
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
