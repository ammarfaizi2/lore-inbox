Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWJMKYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWJMKYo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 06:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWJMKYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 06:24:44 -0400
Received: from cantor2.suse.de ([195.135.220.15]:16022 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751130AbWJMKYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 06:24:42 -0400
Date: Fri, 13 Oct 2006 12:24:19 +0200
From: Holger Macht <hmacht@suse.de>
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, akpm@osdl.org
Subject: [PATCH 3/3] Add support for the generic backlight device to the TOSHIBA ACPI driver
Message-ID: <20061013102419.GD4234@homac.suse.de>
Mail-Followup-To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, len.brown@intel.com, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the generic backlight interface below
/sys/class/backlight.  The patch keeps the procfs brightness handling for
backward compatibility.

For this to archive, the patch adds two generic functions get_lcd and
set_lcd to be used both by the procfs related and the sysfs related
methods.

Signed-off-by: Holger Macht <hmacht@suse.de>
---

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f0bd84a..d9bb370 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -227,6 +227,7 @@ config ACPI_IBM_DOCK
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
 	depends on X86
+	select BACKLIGHT_DEVICE
 	---help---
 	  This driver adds support for access to certain system settings
 	  on "legacy free" Toshiba laptops.  These laptops can be recognized by
diff --git a/drivers/acpi/toshiba_acpi.c b/drivers/acpi/toshiba_acpi.c
index 7fe0b7a..2f35f89 100644
--- a/drivers/acpi/toshiba_acpi.c
+++ b/drivers/acpi/toshiba_acpi.c
@@ -41,6 +41,8 @@ #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/backlight.h>
+
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_drivers.h>
@@ -210,6 +212,7 @@ static acpi_status hci_read1(u32 reg, u3
 }
 
 static struct proc_dir_entry *toshiba_proc_dir /*= 0*/ ;
+static struct backlight_device *toshiba_backlight_device;
 static int force_fan;
 static int last_key_event;
 static int key_event_valid;
@@ -271,14 +274,23 @@ dispatch_write(struct file *file, const 
 	return result;
 }
 
-static char *read_lcd(char *p)
+static int get_lcd(struct backlight_device *bd)
 {
 	u32 hci_result;
 	u32 value;
 
 	hci_read1(HCI_LCD_BRIGHTNESS, &value, &hci_result);
 	if (hci_result == HCI_SUCCESS) {
-		value = value >> HCI_LCD_BRIGHTNESS_SHIFT;
+		return (value >> HCI_LCD_BRIGHTNESS_SHIFT);
+	} else
+		return -EFAULT;
+}
+
+static char *read_lcd(char *p)
+{
+	int value = get_lcd(NULL);
+
+	if (value >= 0) {
 		p += sprintf(p, "brightness:              %d\n", value);
 		p += sprintf(p, "brightness_levels:       %d\n",
 			     HCI_LCD_BRIGHTNESS_LEVELS);
@@ -289,22 +301,34 @@ static char *read_lcd(char *p)
 	return p;
 }
 
+static int set_lcd(int value)
+{
+	u32 hci_result;
+
+	value = value << HCI_LCD_BRIGHTNESS_SHIFT;
+	hci_write1(HCI_LCD_BRIGHTNESS, value, &hci_result);
+	if (hci_result != HCI_SUCCESS)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int set_lcd_status(struct backlight_device *bd)
+{
+	return set_lcd(bd->props->brightness);
+}
+
 static unsigned long write_lcd(const char *buffer, unsigned long count)
 {
 	int value;
-	u32 hci_result;
+	int ret = count;
 
 	if (sscanf(buffer, " brightness : %i", &value) == 1 &&
-	    value >= 0 && value < HCI_LCD_BRIGHTNESS_LEVELS) {
-		value = value << HCI_LCD_BRIGHTNESS_SHIFT;
-		hci_write1(HCI_LCD_BRIGHTNESS, value, &hci_result);
-		if (hci_result != HCI_SUCCESS)
-			return -EFAULT;
-	} else {
-		return -EINVAL;
-	}
-
-	return count;
+	    value >= 0 && value < HCI_LCD_BRIGHTNESS_LEVELS)
+		ret = set_lcd(value);
+	else
+		ret = -EINVAL;
+	return ret;
 }
 
 static char *read_video(char *p)
@@ -506,6 +530,26 @@ static acpi_status __exit remove_device(
 	return AE_OK;
 }
 
+static struct backlight_properties toshiba_backlight_data = {
+        .owner          = THIS_MODULE,
+        .get_brightness = get_lcd,
+        .update_status  = set_lcd_status,
+        .max_brightness = HCI_LCD_BRIGHTNESS_LEVELS - 1,
+};
+
+static void __exit toshiba_acpi_exit(void)
+{
+	if (toshiba_backlight_device)
+		backlight_device_unregister(toshiba_backlight_device);
+
+	remove_device();
+
+	if (toshiba_proc_dir)
+		remove_proc_entry(PROC_TOSHIBA, acpi_root_dir);
+
+	return;
+}
+
 static int __init toshiba_acpi_init(void)
 {
 	acpi_status status = AE_OK;
@@ -546,17 +590,15 @@ static int __init toshiba_acpi_init(void
 			remove_proc_entry(PROC_TOSHIBA, acpi_root_dir);
 	}
 
-	return (ACPI_SUCCESS(status)) ? 0 : -ENODEV;
-}
-
-static void __exit toshiba_acpi_exit(void)
-{
-	remove_device();
-
-	if (toshiba_proc_dir)
-		remove_proc_entry(PROC_TOSHIBA, acpi_root_dir);
+	toshiba_backlight_device = backlight_device_register("toshiba", NULL,
+						&toshiba_backlight_data);
+        if (IS_ERR(toshiba_backlight_device)) {
+		printk(KERN_ERR "Could not register toshiba backlight device\n");
+		toshiba_backlight_device = NULL;
+		toshiba_acpi_exit();
+	}
 
-	return;
+	return (ACPI_SUCCESS(status)) ? 0 : -ENODEV;
 }
 
 module_init(toshiba_acpi_init);
