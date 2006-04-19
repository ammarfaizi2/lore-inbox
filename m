Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWDSSuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWDSSuI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWDSSuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:50:07 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:62122 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751149AbWDSSuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:50:05 -0400
Date: Wed, 19 Apr 2006 19:49:59 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Patrick Mochel <mochel@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: PATCH [2/3]: Provide generic backlight support in IBM ACPI driver
Message-ID: <20060419184959.GA23766@srcf.ucam.org>
References: <20060418082952.GA13811@srcf.ucam.org> <20060418161100.GA31763@linux.intel.com> <20060419184909.GB23513@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419184909.GB23513@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

diff -ur drivers/acpi.bak/ibm_acpi.c drivers/acpi/ibm_acpi.c
--- drivers/acpi.bak/ibm_acpi.c	2006-04-03 04:22:10 +0100
+++ a/drivers/acpi/ibm_acpi.c	2006-04-19 19:40:48 +0100
@@ -78,6 +78,8 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/backlight.h>
+#include <linux/err.h>
 #include <asm/uaccess.h>
 
 #include <acpi/acpi_drivers.h>
@@ -243,6 +245,8 @@
 
 static struct proc_dir_entry *proc_dir = NULL;
 
+static struct backlight_device *ibm_backlight_device;
+
 #define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
 #define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
 #define strlencmp(a,b) (strncmp((a), (b), strlen(b)))
@@ -1318,15 +1322,25 @@
 
 static int brightness_offset = 0x31;
 
+static int brightness_read_value(struct backlight_device *bd)
+{
+	u8 level;
+	if (!acpi_ec_read(brightness_offset, &level))
+		return -EIO;
+
+	level &= 0x7;
+	return level;
+}
+
 static int brightness_read(char *p)
 {
 	int len = 0;
-	u8 level;
+	int level = brightness_read_value(NULL);
 
-	if (!acpi_ec_read(brightness_offset, &level)) {
+	if (level < 0) {
 		len += sprintf(p + len, "level:\t\tunreadable\n");
 	} else {
-		len += sprintf(p + len, "level:\t\t%d\n", level & 0x7);
+		len += sprintf(p + len, "level:\t\t%d\n", level);
 		len += sprintf(p + len, "commands:\tup, down\n");
 		len += sprintf(p + len, "commands:\tlevel <level>"
 			       " (<level> is 0-7)\n");
@@ -1338,9 +1352,38 @@
 #define BRIGHTNESS_UP	4
 #define BRIGHTNESS_DOWN	5
 
+static int brightness_write_value(int value)
+{
+	int current_value = brightness_read_value(NULL);
+	int inc;
+	int cmos_cmd; 
+
+	value &= 7;
+
+	cmos_cmd = value > current_value ? BRIGHTNESS_UP : BRIGHTNESS_DOWN;
+
+	inc = value > current_value ? 1 : -1;
+
+	while (value != current_value) {
+		current_value += inc;
+
+		if (!cmos_eval(cmos_cmd))
+			return -EIO;
+		if (!acpi_ec_write(brightness_offset, current_value))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static int brightness_update_value(struct backlight_device *bd)
+{
+	int value = bd->props->brightness;
+	return brightness_write_value(value);
+}
+
 static int brightness_write(char *buf)
 {
-	int cmos_cmd, inc, i;
 	u8 level;
 	int new_level;
 	char *cmd;
@@ -1360,14 +1403,8 @@
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
+		brightness_write_value(new_level);
+		
 	}
 
 	return 0;
@@ -1895,10 +1932,21 @@
 IBM_PARAM(volume);
 IBM_PARAM(fan);
 
+
+static struct backlight_properties ibmbl_data = {
+        .owner          = THIS_MODULE,
+        .get_brightness = brightness_read_value,
+        .update_status  = brightness_update_value,
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
 
@@ -1966,6 +2014,13 @@
 		}
 	}
 
+	ibm_backlight_device = backlight_device_register ("ibm_bl", NULL,
+							  &ibmbl_data);
+        if (IS_ERR (ibm_backlight_device)) {
+		printk(KERN_ERR "Unable to register IBM backlight driver\n");
+		ibm_backlight_device = NULL;
+	}
+
 	return 0;
 }
 
diff -ur drivers/acpi.bak/Kconfig drivers/acpi/Kconfig
--- drivers/acpi.bak/Kconfig	2006-04-18 08:51:49 +0100
+++ a/drivers/acpi/Kconfig	2006-04-19 19:39:03 +0100
@@ -196,6 +196,7 @@
 config ACPI_IBM
 	tristate "IBM ThinkPad Laptop Extras"
 	depends on X86
+	select BACKLIGHT_DEVICE
 	---help---
 	  This is a Linux ACPI driver for the IBM ThinkPad laptops. It adds
 	  support for Fn-Fx key combinations, Bluetooth control, video

-- 
Matthew Garrett | mjg59@srcf.ucam.org
