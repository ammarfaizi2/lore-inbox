Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWJMKY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWJMKY2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 06:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWJMKY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 06:24:28 -0400
Received: from cantor2.suse.de ([195.135.220.15]:13718 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751129AbWJMKY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 06:24:26 -0400
Date: Fri, 13 Oct 2006 12:24:03 +0200
From: Holger Macht <hmacht@suse.de>
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, akpm@osdl.org
Subject: [PATCH 2/3] Add support for the generic backlight device to the ASUS ACPI driver
Message-ID: <20061013102403.GC4234@homac.suse.de>
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

Signed-off-by: Holger Macht <hmacht@suse.de>
---

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 19b0d22..f0bd84a 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -172,6 +172,7 @@ config ACPI_NUMA
 config ACPI_ASUS
         tristate "ASUS/Medion Laptop Extras"
 	depends on X86
+	select BACKLIGHT_DEVICE
         ---help---
           This driver provides support for extra features of ACPI-compatible
           ASUS laptops. As some of Medion laptops are made by ASUS, it may also
diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
index e9ee4c5..041760d 100644
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -35,6 +35,7 @@ #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/backlight.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
@@ -390,6 +391,8 @@ static struct model_data model_conf[END_
 /* procdir we use */
 static struct proc_dir_entry *asus_proc_dir;
 
+static struct backlight_device *asus_backlight_device;
+
 /*
  * This header is made available to allow proper configuration given model,
  * revision number , ... this info cannot go in struct asus_hotk because it is
@@ -769,7 +772,7 @@ proc_write_lcd(struct file *file, const 
 	return count;
 }
 
-static int read_brightness(void)
+static int read_brightness(struct backlight_device *bd)
 {
 	int value;
 
@@ -791,9 +794,10 @@ static int read_brightness(void)
 /*
  * Change the brightness level
  */
-static void set_brightness(int value)
+static int set_brightness(int value)
 {
 	acpi_status status = 0;
+	int ret = 0;
 
 	/* SPLV laptop */
 	if (hotk->methods->brightness_set) {
@@ -801,11 +805,12 @@ static void set_brightness(int value)
 				    value, NULL))
 			printk(KERN_WARNING
 			       "Asus ACPI: Error changing brightness\n");
-		return;
+			ret = -EIO;
+		goto out;
 	}
 
 	/* No SPLV method if we are here, act as appropriate */
-	value -= read_brightness();
+	value -= read_brightness(NULL);
 	while (value != 0) {
 		status = acpi_evaluate_object(NULL, (value > 0) ?
 					      hotk->methods->brightness_up :
@@ -815,15 +820,22 @@ static void set_brightness(int value)
 		if (ACPI_FAILURE(status))
 			printk(KERN_WARNING
 			       "Asus ACPI: Error changing brightness\n");
+			ret = -EIO;
 	}
-	return;
+out:
+	return ret;
+}
+
+static int set_brightness_status(struct backlight_device *bd)
+{
+	return set_brightness(bd->props->brightness);
 }
 
 static int
 proc_read_brn(char *page, char **start, off_t off, int count, int *eof,
 	      void *data)
 {
-	return sprintf(page, "%d\n", read_brightness());
+	return sprintf(page, "%d\n", read_brightness(NULL));
 }
 
 static int
@@ -1326,6 +1338,26 @@ static int asus_hotk_remove(struct acpi_
 	return 0;
 }
 
+static struct backlight_properties asus_backlight_data = {
+        .owner          = THIS_MODULE,
+        .get_brightness = read_brightness,
+        .update_status  = set_brightness_status,
+        .max_brightness = 15,
+};
+
+static void __exit asus_acpi_exit(void)
+{
+	if (asus_backlight_device)
+		backlight_device_unregister(asus_backlight_device);
+
+	acpi_bus_unregister_driver(&asus_hotk_driver);
+	remove_proc_entry(PROC_ASUS, acpi_root_dir);
+
+	kfree(asus_info);
+
+	return;
+}
+
 static int __init asus_acpi_init(void)
 {
 	int result;
@@ -1363,17 +1395,15 @@ static int __init asus_acpi_init(void)
 		return result;
 	}
 
-	return 0;
-}
-
-static void __exit asus_acpi_exit(void)
-{
-	acpi_bus_unregister_driver(&asus_hotk_driver);
-	remove_proc_entry(PROC_ASUS, acpi_root_dir);
-
-	kfree(asus_info);
+	asus_backlight_device = backlight_device_register("asus", NULL,
+							  &asus_backlight_data);
+        if (IS_ERR(asus_backlight_device)) {
+		printk(KERN_ERR "Could not register asus backlight device\n");
+		asus_backlight_device = NULL;
+		asus_acpi_exit();
+	}
 
-	return;
+	return 0;
 }
 
 module_init(asus_acpi_init);
