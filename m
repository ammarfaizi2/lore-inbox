Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWDRIcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWDRIcI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 04:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWDRIcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 04:32:08 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:54490 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750810AbWDRIcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 04:32:06 -0400
Date: Tue, 18 Apr 2006 09:32:02 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: PATCH [3/3]: Provide generic backlight support in Toshiba ACPI driver
Message-ID: <20060418083202.GB13846@srcf.ucam.org>
References: <20060418082952.GA13811@srcf.ucam.org> <20060418083056.GA13846@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418083056.GA13846@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides support for altering Toshiba backlight brightness 
via /sys/class/backlight. It does not remove the legacy /proc interface.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

diff -urp drivers/acpi.bak/Kconfig drivers/acpi/Kconfig
--- drivers/acpi.bak/Kconfig	2006-04-18 08:51:49 +0100
+++ a/drivers/acpi/Kconfig	2006-04-18 09:24:45 +0100
@@ -219,7 +219,7 @@ config ACPI_IBM_DOCK
 
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
-	depends on X86
+	depends on X86 && BACKLIGHT_DEVICE
 	---help---
 	  This driver adds support for access to certain system settings
 	  on "legacy free" Toshiba laptops.  These laptops can be recognized by
diff -urp drivers/acpi.bak/toshiba_acpi.c drivers/acpi/toshiba_acpi.c
--- drivers/acpi.bak/toshiba_acpi.c	2006-04-03 04:22:10 +0100
+++ a/drivers/acpi/toshiba_acpi.c	2006-04-18 09:26:41 +0100
@@ -41,6 +41,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/backlight.h>
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_drivers.h>
@@ -97,6 +98,8 @@ MODULE_LICENSE("GPL");
 #define HCI_VIDEO_OUT_CRT		0x2
 #define HCI_VIDEO_OUT_TV		0x4
 
+static struct backlight_device *tosh_backlight_device;
+
 /* utility
  */
 
@@ -289,6 +292,19 @@ static char *read_lcd(char *p)
 	return p;
 }
 
+static int tosh_get_brightness(struct backlight_device *bd)
+{
+	int brightness;
+	u32 hci_result;
+
+	hci_read1(HCI_LCD_BRIGHTNESS, &brightness, &hci_result);
+	if (hci_result == HCI_SUCCESS) {
+		brightness = brightness >> HCI_LCD_BRIGHTNESS_SHIFT;
+		return brightness;
+	} else
+		return 0;
+}
+
 static unsigned long write_lcd(const char *buffer, unsigned long count)
 {
 	int value;
@@ -307,6 +323,28 @@ static unsigned long write_lcd(const cha
 	return count;
 }
 
+static int tosh_set_brightness(struct backlight_device *bd, int brightness)
+{
+	u32 hci_result;
+
+	if (brightness >= 0 && brightness < HCI_LCD_BRIGHTNESS_LEVELS) {
+		brightness= brightness << HCI_LCD_BRIGHTNESS_SHIFT;
+		hci_write1(HCI_LCD_BRIGHTNESS, brightness, &hci_result);
+		if (hci_result != HCI_SUCCESS)
+			return -EFAULT;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tosh_update_brightness(struct backlight_device *bd)
+{
+	int value = bd->props->brightness;
+	return tosh_set_brightness(bd, value);
+}
+
 static char *read_video(char *p)
 {
 	u32 hci_result;
@@ -477,6 +515,13 @@ static ProcItem proc_items[] = {
 	{NULL}
 };
 
+static struct backlight_properties toshbl_data = {
+	.owner          = THIS_MODULE,
+	.get_brightness = tosh_get_brightness,
+	.update_status  = tosh_update_brightness,
+	.max_brightness = HCI_LCD_BRIGHTNESS_LEVELS,
+};
+
 static acpi_status __init add_device(void)
 {
 	struct proc_dir_entry *proc;
@@ -546,6 +591,12 @@ static int __init toshiba_acpi_init(void
 			remove_proc_entry(PROC_TOSHIBA, acpi_root_dir);
 	}
 
+	tosh_backlight_device = backlight_device_register ("tosh-bl", NULL,
+							   &toshbl_data);
+
+	if (IS_ERR (tosh_backlight_device))
+		printk("Failed to register Toshiba backlight device\n");
+
 	return (ACPI_SUCCESS(status)) ? 0 : -ENODEV;
 }
 
@@ -556,6 +607,8 @@ static void __exit toshiba_acpi_exit(voi
 	if (toshiba_proc_dir)
 		remove_proc_entry(PROC_TOSHIBA, acpi_root_dir);
 
+	backlight_device_unregister(tosh_backlight_device);
+
 	return;
 }

-- 
Matthew Garrett | mjg59@srcf.ucam.org
