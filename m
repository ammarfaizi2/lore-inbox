Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422722AbWBIQya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422722AbWBIQya (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWBIQya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:54:30 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:2768 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932359AbWBIQy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:54:29 -0500
Date: Thu, 9 Feb 2006 16:54:07 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Pavel Machek <pavel@ucw.cz>, john@neggie.net, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [PATCH] Add generic backlight support to toshiba_acpi driver
Message-ID: <20060209165407.GA20754@srcf.ucam.org>
References: <20060207133456.GA2452@srcf.ucam.org> <20060208090757.GB11895@elf.ucw.cz> <Pine.LNX.4.61.0602091747070.30108@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602091747070.30108@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 05:47:49PM +0100, Jan Engelhardt wrote:

> Note to self: Don't forget to change 2.6-sony-acpi?.diff from -mm to use 
> this /sys/class/backlight instead of /proc/acpi/sony/brightness when it's 
> ready.

Ah, you're maintaining that now. Here you go (Stelian took a look and 
seemed happy with it - the /sys/class/backlight stuff is in mainstream)

diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index 7636bba..6505b24 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -27,6 +27,8 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/backlight.h>
+#include <linux/err.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
@@ -62,6 +64,8 @@ static struct acpi_driver sony_acpi_driv
 static acpi_handle sony_acpi_handle;
 static struct proc_dir_entry *sony_acpi_dir;
 
+static struct backlight_device *sony_backlight_device;
+
 static struct sony_acpi_value {
 	char			*name;	 /* name of the entry */
 	struct proc_dir_entry 	*proc;	 /* /proc entry */
@@ -258,6 +262,31 @@ static acpi_status sony_walk_callback(ac
 	return AE_OK;
 }
 
+static int sony_brightness_get(struct backlight_device *bd) 
+{
+	int value;
+
+	if (acpi_callgetfunc(sony_acpi_handle, "GBRT", &value))
+		return 0;
+
+	return value-1;
+}
+	
+
+static int sony_brightness_set(struct backlight_device *bd, int value) {
+	value &= 0x7;
+	value++;
+
+	return acpi_callsetfunc(sony_acpi_handle, "SBRT", value, NULL);
+}
+
+static struct backlight_properties sonybl_data = {
+	.owner          = THIS_MODULE,
+	.get_brightness = sony_brightness_get,
+	.set_brightness = sony_brightness_set,
+	.max_brightness = 7,
+};
+
 static int __init sony_acpi_add(struct acpi_device *device)
 {
 	acpi_status status;
@@ -378,12 +407,24 @@ static int __init sony_acpi_init(void)
 		remove_proc_entry("sony", acpi_root_dir);
 		return -ENODEV;
 	}
+
+	sony_backlight_device = backlight_device_register ("sony_bl", NULL,
+							   &sonybl_data);
+
+	if (IS_ERR (sony_backlight_device)) {
+		printk("Unable to register backlight\n");
+		acpi_bus_unregister_driver(&sony_acpi_driver);
+		remove_proc_entry("sony", acpi_root_dir);
+		return -ENODEV;
+	}
+
 	return 0;
 }
 
 
 static void __exit sony_acpi_exit(void)
 {
+	backlight_device_unregister(sony_backlight_device);
 	acpi_bus_unregister_driver(&sony_acpi_driver);
 	remove_proc_entry("sony", acpi_root_dir);
 }

-- 
Matthew Garrett | mjg59@srcf.ucam.org
