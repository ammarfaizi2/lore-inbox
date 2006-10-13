Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWJMKYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWJMKYK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 06:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbWJMKYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 06:24:10 -0400
Received: from mail.suse.de ([195.135.220.2]:25491 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751121AbWJMKYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 06:24:08 -0400
Date: Fri, 13 Oct 2006 12:23:45 +0200
From: Holger Macht <hmacht@suse.de>
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, akpm@osdl.org
Subject: [PATCH 1/3] Add support for the generic backlight device to the IBM ACPI driver
Message-ID: <20061013102345.GB4234@homac.suse.de>
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

For this to archive, the patch adds two generic functions brightness_get
and brightness_set to be used both by the procfs related and the sysfs
related methods.

Signed-off-by: Holger Macht <hmacht@suse.de>
---

This is an updated version of the patch earlier sent which selects the
right Kconfig option BACKLIGHT_DEVICE.

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 0f9d4be..19b0d22 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -200,6 +200,7 @@ config ACPI_ASUS
 config ACPI_IBM
 	tristate "IBM ThinkPad Laptop Extras"
 	depends on X86
+	select BACKLIGHT_DEVICE
 	---help---
 	  This is a Linux ACPI driver for the IBM ThinkPad laptops. It adds
 	  support for Fn-Fx key combinations, Bluetooth control, video
diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 15fc124..1160f92 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -78,6 +78,7 @@ #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/backlight.h>
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_drivers.h>
@@ -243,6 +244,8 @@ struct ibm_struct {
 
 static struct proc_dir_entry *proc_dir = NULL;
 
+static struct backlight_device *ibm_backlight_device;
+
 #define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
 #define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
 #define strlencmp(a,b) (strncmp((a), (b), strlen(b)))
@@ -1381,12 +1384,22 @@ static int ecdump_write(char *buf)
 
 static int brightness_offset = 0x31;
 
+static int brightness_get(struct backlight_device *bd)
+{
+       u8 level;
+       if (!acpi_ec_read(brightness_offset, &level))
+               return -EIO;
+       
+       level &= 0x7;
+       return level;
+}
+
 static int brightness_read(char *p)
 {
 	int len = 0;
-	u8 level;
+	int level;
 
-	if (!acpi_ec_read(brightness_offset, &level)) {
+	if ((level = brightness_get(NULL)) < 0) {
 		len += sprintf(p + len, "level:\t\tunreadable\n");
 	} else {
 		len += sprintf(p + len, "level:\t\t%d\n", level & 0x7);
@@ -1401,16 +1414,34 @@ static int brightness_read(char *p)
 #define BRIGHTNESS_UP	4
 #define BRIGHTNESS_DOWN	5
 
-static int brightness_write(char *buf)
+static int brightness_set(int value)
 {
 	int cmos_cmd, inc, i;
-	u8 level;
+	int current_value = brightness_get(NULL);
+	
+	value &= 7;
+	
+	cmos_cmd = value > current_value ? BRIGHTNESS_UP : BRIGHTNESS_DOWN;
+	inc = value > current_value ? 1 : -1;
+	for (i = current_value; i != value; i += inc) {
+		if (!cmos_eval(cmos_cmd))
+			return -EIO;
+		if (!acpi_ec_write(brightness_offset, i + inc))
+			return -EIO;
+	}
+	
+	return 0;
+}
+
+static int brightness_write(char *buf)
+{
+	int level;
 	int new_level;
 	char *cmd;
 
 	while ((cmd = next_cmd(&buf))) {
-		if (!acpi_ec_read(brightness_offset, &level))
-			return -EIO;
+		if ((level = brightness_get(NULL)) < 0)
+			return level;
 		level &= 7;
 
 		if (strlencmp(cmd, "up") == 0) {
@@ -1423,19 +1454,17 @@ static int brightness_write(char *buf)
 		} else
 			return -EINVAL;
 
-		cmos_cmd = new_level > level ? BRIGHTNESS_UP : BRIGHTNESS_DOWN;
-		inc = new_level > level ? 1 : -1;
-		for (i = level; i != new_level; i += inc) {
-			if (!cmos_eval(cmos_cmd))
-				return -EIO;
-			if (!acpi_ec_write(brightness_offset, i + inc))
-				return -EIO;
-		}
+		brightness_set(new_level);
 	}
 
 	return 0;
 }
 
+static int brightness_update_status(struct backlight_device *bd)
+{
+	return brightness_set(bd->props->brightness);
+}
+
 static int volume_offset = 0x30;
 
 static int volume_read(char *p)
@@ -1965,10 +1994,20 @@ IBM_PARAM(brightness);
 IBM_PARAM(volume);
 IBM_PARAM(fan);
 
+static struct backlight_properties ibm_backlight_data = {
+        .owner          = THIS_MODULE,
+        .get_brightness = brightness_get,
+        .update_status  = brightness_update_status,
+        .max_brightness = 7,
+};
+
 static void acpi_ibm_exit(void)
 {
 	int i;
 
+	if (ibm_backlight_device)
+		backlight_device_unregister(ibm_backlight_device);
+
 	for (i = ARRAY_SIZE(ibms) - 1; i >= 0; i--)
 		ibm_exit(&ibms[i]);
 
@@ -2036,6 +2075,14 @@ #endif
 		}
 	}
 
+	ibm_backlight_device = backlight_device_register("ibm", NULL,
+							 &ibm_backlight_data);
+        if (IS_ERR(ibm_backlight_device)) {
+		printk(IBM_ERR "Could not register ibm backlight device\n");
+		ibm_backlight_device = NULL;
+		acpi_ibm_exit();
+	}
+	
 	return 0;
 }
 
