Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbWBGNfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWBGNfB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWBGNfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:35:01 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:23204 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S965064AbWBGNfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:35:00 -0500
Date: Tue, 7 Feb 2006 13:34:56 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: john@neggie.net
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] Add generic backlight support to toshiba_acpi driver
Message-ID: <20060207133456.GA2452@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The included patch adds support for interacting with the toshiba_acpi 
backlight control through the generic backlight interface 
(/sys/class/backlight).

ACPI folk: this gives us the benefit of a consistent interface to LCD 
brightness. Is it worth me converting the other drivers over?

Signed-Off-By: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 5243f0c..69ed5c2 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -215,7 +215,7 @@ config ACPI_IBM
 
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
-	depends on X86
+	depends on X86 && BACKLIGHT_DEVICE
 	default y
 	---help---
 	  This driver adds support for access to certain system settings
diff --git a/drivers/acpi/toshiba_acpi.c b/drivers/acpi/toshiba_acpi.c
index b2fa688..f263f62 100644
--- a/drivers/acpi/toshiba_acpi.c
+++ b/drivers/acpi/toshiba_acpi.c
@@ -60,6 +60,7 @@
 #include <linux/suspend.h>
 #include <linux/miscdevice.h>
 #include <linux/toshiba.h>
+#include <linux/backlight.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
@@ -117,6 +118,8 @@ MODULE_LICENSE("GPL");
 #define HCI_VIDEO_OUT_CRT		0x2
 #define HCI_VIDEO_OUT_TV		0x4
 
+static struct backlight_device *tosh_backlight_device;
+
 /* utility
  */
 
@@ -315,6 +318,19 @@ static char *read_lcd(char *p)
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
@@ -333,6 +349,22 @@ static unsigned long write_lcd(const cha
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
 static char *read_video(char *p)
 {
 	u32 hci_result;
@@ -588,6 +620,13 @@ static struct miscdevice tosh_device = {
 	&tosh_fops
 };
 
+static struct backlight_properties toshbl_data = {
+	.owner          = THIS_MODULE,
+	.get_brightness = tosh_get_brightness,
+	.set_brightness = tosh_set_brightness,
+	.max_brightness = HCI_LCD_BRIGHTNESS_LEVELS,
+};
+
 static void
 setup_tosh_info(void)
 {
@@ -891,6 +930,12 @@ static int __init toshiba_acpi_init(void
 		}
 	}
 
+	tosh_backlight_device = backlight_device_register ("tosh-bl", NULL,
+							   &toshbl_data);
+
+	if (IS_ERR (tosh_backlight_device))
+		printk("Failed to register Toshiba backlight device\n");
+
 	return (ACPI_SUCCESS(status)) ? 0 : -ENODEV;
 }
 
@@ -909,6 +954,8 @@ static void __exit toshiba_acpi_exit(voi
 
 	old_driver_emulation_exit();
 
+	backlight_device_unregister(tosh_backlight_device);
+
 	printk(MY_INFO "Toshiba Laptop ACPI Extras unloaded\n");
 
 	return;

-- 
Matthew Garrett | mjg59@srcf.ucam.org
