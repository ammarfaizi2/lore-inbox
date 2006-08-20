Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751765AbWHTWwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWHTWwP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 18:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWHTWwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 18:52:15 -0400
Received: from tango.0pointer.de ([217.160.223.3]:46088 "EHLO
	tango.0pointer.de") by vger.kernel.org with ESMTP id S1751765AbWHTWwM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 18:52:12 -0400
Date: Mon, 21 Aug 2006 00:52:09 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: len.brown@intel.com, rubini@vision.unipv.it, pavel@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] misc,acpi,backlight: MSI S270 Laptop support, third try
Message-ID: <20060820225209.GA5453@curacao>
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

This is the third version of my MSI S270 Laptop driver. Most things I
wrote about the first two versions are still true:

http://marc.theaimsgroup.com/?l=linux-acpi&m=115517193510912&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=115522739203174&w=2

Changes from the second version are:

- Added a new DMI entry for a supported laptop model

- Renamed to "msi-laptop.c" (originally s270.c). This driver probably
  works on more MSI laptops than just the S270. (On request of Thomas
  Renninger)

- Don't use a static brightness level translation table, instead just
  multiply/divide by 31 to convert from harware to software brightness
  levels (On request of Pavel Machek)

- Split up "if" lines (on request of Pavel Machek)

- Fix the maximum brightness level passed to the backlight control
  subsystem. 

Applies to Linus' current GIT tree. (2.6.18pre)

Requires the ec_transaction patch I posted earlier.

Please merge! 

I wonder who's the right one to ask for merging, since this driver
sits in drivers/misc/. According to MAINTAINERS Alessandro Rubini
maintains that directory. However it's somewhat based on the ACPI EC
access stuff I posted earlier, hence the APCI tree might be another
path to get this merged. Len, Alessandro, which one of you shall I
bug to get this driver commited?

Thanks,
        Lennart

Signed-off-by: Lennart Poettering <mzxreary@0pointer.de>
---
 MAINTAINERS               |    7 +
 drivers/misc/Kconfig      |   19 ++
 drivers/misc/Makefile     |    1 
 drivers/misc/msi-laptop.c |  386 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 413 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 21116cc..6210002 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1949,6 +1949,13 @@ M:	rubini@ipvvis.unipv.it
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
+MSI LAPTOP SUPPORT
+P:	Lennart Poettering
+M:	mzxreary@0pointer.de
+L:	https://tango.0pointer.de/mailman/listinfo/s270-linux
+W:	http://0pointer.de/lennart/tchibo.html
+S:	Maintained
+
 MTRR AND SIMILAR SUPPORT [i386]
 P:	Richard Gooch
 M:	rgooch@atnf.csiro.au
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 7fc692a..d25b0db 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -28,5 +28,24 @@ config IBM_ASM
 
 	  If unsure, say N.
 
+config MSI_LAPTOP
+        tristate "MSI Laptop Extras"
+        depends on X86
+        depends on ACPI_EC
+        depends on BACKLIGHT_CLASS_DEVICE
+        ---help---
+          This is a driver for laptops built by MSI (MICRO-STAR 
+	  INTERNATIONAL):
+	      
+	      MSI MegaBook S270 (MS-1013)
+	      Cytron/TCM/Medion/Tchibo MD96100/SAM2000
+	   
+	  It adds support for Bluetooth, WLAN and LCD brightness control.
+
+          More information about this driver is available at
+          <http://0pointer.de/lennart/tchibo.html>.
+
+          If you have an MSI S270 laptop, say Y or M here.
+
 endmenu
 
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 19c2b85..1328c5f 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -5,3 +5,4 @@ obj- := misc.o	# Dummy rule to force bui
 
 obj-$(CONFIG_IBM_ASM)	+= ibmasm/
 obj-$(CONFIG_HDPU_FEATURES)	+= hdpuftrs/
+obj-$(CONFIG_MSI_LAPTOP)     += msi-laptop.o
diff --git a/drivers/misc/msi-laptop.c b/drivers/misc/msi-laptop.c
new file mode 100644
index 0000000..450c800
--- /dev/null
+++ b/drivers/misc/msi-laptop.c
@@ -0,0 +1,386 @@
+/*-*-linux-c-*-*/
+
+/* $Id: msi-laptop.c 115 2006-08-20 20:02:54Z lennart $ */
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
+ * msi-laptop.c - MSI S270 laptop support. This laptop is sold under
+ * various brands, including "Cytron/TCM/Medion/Tchibo MD96100".
+ *
+ * This driver exports a few files in /sys/devices/platform/msi-laptop-pf/:
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
+ * available to userspace under /sys/class/backlight/msi-laptop-bl/.
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
+#define MSI_DRIVER_VERSION "0.3"
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
+static int set_lcd_level(int level) {
+        u8 buf[2];
+        
+        if (level < 0 || level >= MSI_LCD_LEVEL_MAX)
+                return -EINVAL;
+        
+        buf[0] = 0x80;
+        buf[1] = (u8) (level*31);
+        
+        return ec_transaction(MSI_EC_COMMAND_LCD_LEVEL, buf, sizeof(buf), NULL, 0);
+}
+
+static int get_lcd_level(void) {
+        u8 wdata = 0, rdata;
+        int result;
+
+        result = ec_transaction(MSI_EC_COMMAND_LCD_LEVEL, &wdata, 1, &rdata, 1);
+        if (result < 0)
+                return result;
+
+        return (int) rdata / 31;
+}
+
+static int get_auto_brightness(void) {
+        u8 wdata = 4, rdata;
+        int result;
+
+        result = ec_transaction(MSI_EC_COMMAND_LCD_LEVEL, &wdata, 1, &rdata, 1);
+        if (result < 0)
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
+        result = ec_transaction(MSI_EC_COMMAND_LCD_LEVEL, wdata, 1, &rdata, 1);
+        if (result < 0)
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
+        result = ec_transaction(MSI_EC_COMMAND_WIRELESS, &wdata, 1, &rdata, 1);
+        if (result < 0)
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
+static struct backlight_properties msibl_props = {
+        .owner		= THIS_MODULE,
+	.get_brightness = bl_get_brightness,
+        .update_status  = bl_update_status,
+	.max_brightness = MSI_LCD_LEVEL_MAX-1,
+};
+
+static struct backlight_device *msibl_device;
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
+        ret = get_wireless_state(&enabled, NULL);
+        if (ret < 0)
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
+        ret = get_wireless_state(NULL, &enabled);
+        if (ret < 0)
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
+        ret = get_lcd_level();
+        if (ret < 0)
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
+        ret = set_lcd_level(level);
+        if (ret < 0)
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
+        ret = get_auto_brightness();
+        if (ret < 0)
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
+        ret = set_auto_brightness(enable);
+        if (ret < 0)
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
+static struct attribute *msipf_attributes[] = {
+	&dev_attr_lcd_level.attr,
+	&dev_attr_auto_brightness.attr,
+	&dev_attr_bluetooth.attr,
+	&dev_attr_wlan.attr,
+	NULL
+};
+
+static struct attribute_group msipf_attribute_group = {
+	.attrs = msipf_attributes
+};
+
+static struct platform_driver msipf_driver = {
+	.driver = {
+		.name = "msi-laptop-pf",
+		.owner = THIS_MODULE,
+	}
+};
+
+static struct platform_device *msipf_device;
+
+/*** Initialization ***/
+
+static struct dmi_system_id __initdata msi_dmi_table[] = {
+        {
+                .ident = "MSI S270",
+                .matches = {
+                        DMI_MATCH(DMI_SYS_VENDOR, "MICRO-STAR INT'L CO.,LTD"),
+                        DMI_MATCH(DMI_PRODUCT_NAME, "MS-1013"),
+                }
+        },
+        {
+                .ident = "Medion MD96100",
+                .matches = {
+                        DMI_MATCH(DMI_SYS_VENDOR, "NOTEBOOK"),
+                        DMI_MATCH(DMI_PRODUCT_NAME, "SAM2000"),
+                }
+        },
+        { }
+};
+
+
+static int __init msi_init(void) {
+        int ret;
+
+        if (acpi_disabled)
+                return -ENODEV;
+
+        if (!force && !dmi_check_system(msi_dmi_table))
+                return -ENODEV;
+
+        if (auto_brightness < 0 || auto_brightness > 2)
+                return -EINVAL;
+
+        /* Register backlight stuff */
+        
+        msibl_device = backlight_device_register("msi-laptop-bl", NULL, &msibl_props);
+        if (IS_ERR(msibl_device))
+                return PTR_ERR(msibl_device);
+
+        ret = platform_driver_register(&msipf_driver);
+        if (ret)
+                goto fail_backlight;
+
+        /* Register platform stuff */
+        
+        msipf_device = platform_device_register_simple("msi-laptop-pf", -1, NULL, 0);
+	if (IS_ERR(msipf_device)) {
+		ret = PTR_ERR(msipf_device);
+		goto fail_platform_driver;
+	}
+
+        ret = sysfs_create_group(&msipf_device->dev.kobj, &msipf_attribute_group);
+        if (ret)
+                goto fail_platform_device;
+
+        /* Disable automatic brightness control by default because
+         * this module was probably loaded to do brightness control in
+         * software. */
+
+        if (auto_brightness != 2)
+                set_auto_brightness(auto_brightness);
+        
+        printk(KERN_INFO "msi-laptop: driver "MSI_DRIVER_VERSION" successfully loaded.\n");
+        
+        return 0;
+
+fail_platform_device:
+        
+        platform_device_unregister(msipf_device);
+
+fail_platform_driver:
+
+        platform_driver_unregister(&msipf_driver);
+        
+fail_backlight:
+
+        backlight_device_unregister(msibl_device);
+        
+        return ret;
+}
+
+static void __exit msi_cleanup(void) {
+
+        sysfs_remove_group(&msipf_device->dev.kobj, &msipf_attribute_group);
+        platform_device_unregister(msipf_device);
+        platform_driver_unregister(&msipf_driver);
+        backlight_device_unregister(msibl_device);
+
+        /* Enable automatic brightness control again */
+        if (auto_brightness != 2)
+                set_auto_brightness(1);     
+
+        printk(KERN_INFO "msi-laptop: driver unloaded.\n");
+}
+
+module_init(msi_init);
+module_exit(msi_cleanup);
+
+MODULE_AUTHOR("Lennart Poettering");
+MODULE_DESCRIPTION("MSI Laptop Support");
+MODULE_VERSION(MSI_DRIVER_VERSION);
+MODULE_LICENSE("GPL");
-- 
1.4.1

