Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWDRIaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWDRIaM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 04:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWDRIaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 04:30:12 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:2447 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750739AbWDRIaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 04:30:10 -0400
Date: Tue, 18 Apr 2006 09:29:52 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: PATCH [1/3]: Provide generic backlight support in Asus ACPI driver
Message-ID: <20060418082952.GA13811@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This allows Asus backlight control to be performed via 
/sys/class/backlight. It does not currently remove the legacy /proc 
interface.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

diff -urp drivers/acpi.bak/asus_acpi.c drivers/acpi/asus_acpi.c
--- drivers/acpi.bak/asus_acpi.c	2006-04-03 04:22:10 +0100
+++ a/drivers/acpi/asus_acpi.c	2006-04-18 09:23:58 +0100
@@ -38,6 +38,8 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/backlight.h>
+#include <linux/err.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
@@ -82,6 +84,8 @@ MODULE_PARM_DESC(asus_uid, "UID for entr
 module_param(asus_gid, uint, 0);
 MODULE_PARM_DESC(asus_gid, "GID for entries in /proc/acpi/asus.\n");
 
+static struct backlight_device *asus_backlight_device;
+
 /* For each model, all features implemented, 
  * those marked with R are relative to HOTK, A for absolute */
 struct model_data {
@@ -689,7 +693,7 @@ proc_write_lcd(struct file *file, const 
 	return count;
 }
 
-static int read_brightness(void)
+static int read_brightness(struct backlight_device *bd)
 {
 	int value;
 
@@ -711,39 +715,50 @@ static int read_brightness(void)
 /*
  * Change the brightness level
  */
-static void set_brightness(int value)
+static int set_brightness(struct backlight_device *bd, int value)
 {
 	acpi_status status = 0;
 
+	value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
+	/* 0 <= value <= 15 */
+
 	/* SPLV laptop */
 	if (hotk->methods->brightness_set) {
 		if (!write_acpi_int(hotk->handle, hotk->methods->brightness_set,
 				    value, NULL))
 			printk(KERN_WARNING
 			       "Asus ACPI: Error changing brightness\n");
-		return;
+		return -EINVAL;
 	}
 
 	/* No SPLV method if we are here, act as appropriate */
-	value -= read_brightness();
+	value -= read_brightness(NULL);
 	while (value != 0) {
 		status = acpi_evaluate_object(NULL, (value > 0) ?
 					      hotk->methods->brightness_up :
 					      hotk->methods->brightness_down,
 					      NULL, NULL);
 		(value > 0) ? value-- : value++;
-		if (ACPI_FAILURE(status))
+		if (ACPI_FAILURE(status)) {
 			printk(KERN_WARNING
 			       "Asus ACPI: Error changing brightness\n");
+			return -EINVAL;
+		}		
 	}
-	return;
+	return 0;
+}
+
+static int update_brightness(struct backlight_device *bd)
+{
+	int value = bd->props->brightness;
+	return set_brightness(bd, value);
 }
 
 static int
 proc_read_brn(char *page, char **start, off_t off, int count, int *eof,
 	      void *data)
 {
-	return sprintf(page, "%d\n", read_brightness());
+	return sprintf(page, "%d\n", read_brightness(NULL));
 }
 
 static int
@@ -754,9 +769,7 @@ proc_write_brn(struct file *file, const 
 
 	count = parse_arg(buffer, count, &value);
 	if (count > 0) {
-		value = (0 < value) ? ((15 < value) ? 15 : value) : 0;
-		/* 0 <= value <= 15 */
-		set_brightness(value);
+		set_brightness(NULL,value);
 	} else if (count < 0) {
 		printk(KERN_WARNING "Asus ACPI: Error reading user input\n");
 	}
@@ -1207,6 +1220,13 @@ static int asus_hotk_remove(struct acpi_
 	return 0;
 }
 
+static struct backlight_properties asusbl_data = {
+	.owner          = THIS_MODULE,
+	.get_brightness = read_brightness,
+	.update_status  = update_brightness,
+	.max_brightness = 15,
+};
+
 static int __init asus_acpi_init(void)
 {
 	int result;
@@ -1232,11 +1252,24 @@ static int __init asus_acpi_init(void)
 		return -ENODEV;
 	}
 
+	asus_backlight_device = backlight_device_register ("asus_bl", NULL,
+							   &asusbl_data);
+
+	if (IS_ERR (asus_backlight_device)) {
+		printk("Unable to register backlight\n");
+		acpi_bus_unregister_driver(&asus_hotk_driver);
+		remove_proc_entry(PROC_ASUS, acpi_root_dir);
+		
+		acpi_os_free(asus_info);
+		return -ENODEV;
+	}
+
 	return 0;
 }
 
 static void __exit asus_acpi_exit(void)
 {
+	backlight_device_unregister(asus_backlight_device);
 	acpi_bus_unregister_driver(&asus_hotk_driver);
 	remove_proc_entry(PROC_ASUS, acpi_root_dir);
 
diff -urp drivers/acpi.bak/Kconfig drivers/acpi/Kconfig
--- drivers/acpi.bak/Kconfig	2006-04-18 08:51:49 +0100
+++ a/drivers/acpi/Kconfig	2006-04-18 09:20:42 +0100
@@ -167,7 +167,7 @@ config ACPI_NUMA
 
 config ACPI_ASUS
         tristate "ASUS/Medion Laptop Extras"
-	depends on X86
+	depends on X86 && BACKLIGHT_DEVICE
         ---help---
           This driver provides support for extra features of ACPI-compatible
           ASUS laptops. As some of Medion laptops are made by ASUS, it may also

-- 
Matthew Garrett | mjg59@srcf.ucam.org
