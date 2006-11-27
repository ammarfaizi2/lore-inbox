Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758390AbWK0QnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758390AbWK0QnR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 11:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758393AbWK0QnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 11:43:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:23120 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1758387AbWK0QnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 11:43:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=tklNylg59s8U5cPSeDXZvKMJcbock7LyXh9pdMebQaxpPS6yNmJiOTfmsVT8anX4h056Y0NjWdyQgjBaTiPVexCNJx/37CWSltsUiG2s4iK1VJQoj6EsG5vgJJU0iSmtP0O7szJEmxMa1PkayfVkud3iqCbbi8h2E9FhrPD74aw=
Date: Mon, 27 Nov 2006 17:43:28 +0100
From: Alessandro Guido <alessandro.guido@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org, len.brown@intel.com
Subject: [PATCH] acpi: add backlight support to the sony_acpi driver (v2)
Message-Id: <20061127174328.30e8856e.alessandro.guido@gmail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the sony_acpi driver to use the backlight subsysyem for
adjusting the monitor brightness. Old way of changing the brightness will be
still available for compatibility with existing tools.

Signed-off-by: Alessandro Guido <alessandro.guido@gmail.com>
---

 Kconfig     |    1 +
 sony_acpi.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 49 insertions(+), 5 deletions(-)

Index: linux-2.6.18/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.18.orig/drivers/acpi/Kconfig
+++ linux-2.6.18/drivers/acpi/Kconfig
@@ -251,6 +251,7 @@ config ACPI_TOSHIBA
 config ACPI_SONY
 	tristate "Sony Laptop Extras"
 	depends on X86 && ACPI
+	select BACKLIGHT_CLASS_DEVICE
 	default m
 	  ---help---
 	  This mini-driver drives the ACPI SNC device present in the
Index: linux-2.6.18/drivers/acpi/sony_acpi.c
===================================================================
--- linux-2.6.18.orig/drivers/acpi/sony_acpi.c
+++ linux-2.6.18/drivers/acpi/sony_acpi.c
@@ -27,13 +27,19 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/backlight.h>
+#include <linux/err.h>
 #include <acpi/acpi_drivers.h>
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
 
 #define ACPI_SNC_CLASS		"sony"
 #define ACPI_SNC_HID		"SNY5001"
-#define ACPI_SNC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.2"
+#define ACPI_SNC_DRIVER_NAME	"ACPI Sony Notebook Control Driver v0.3"
+
+/* the device uses 1-based values, while the backlight subsystem uses
+   0-based values */
+#define SONY_MAX_BRIGHTNESS	8
 
 #define LOG_PFX			KERN_WARNING "sony_acpi: "
 
@@ -49,6 +55,16 @@ MODULE_PARM_DESC(debug, "set this to 1 (
 static acpi_handle sony_acpi_handle;
 static struct proc_dir_entry *sony_acpi_dir;
 
+static int sony_backlight_update_status(struct backlight_device *bd);
+static int sony_backlight_get_brightness(struct backlight_device *bd);
+static struct backlight_device *sony_backlight_device;
+static struct backlight_properties sony_backlight_properties = {
+	.owner		= THIS_MODULE,
+	.update_status	= sony_backlight_update_status,
+	.get_brightness	= sony_backlight_get_brightness,
+	.max_brightness	= SONY_MAX_BRIGHTNESS - 1,
+};
+
 static struct sony_acpi_value {
 	char			*name;	 /* name of the entry */
 	struct proc_dir_entry 	*proc;	 /* /proc entry */
@@ -65,7 +81,7 @@ static struct sony_acpi_value {
 		.acpiget	= "GBRT",
 		.acpiset	= "SBRT",
 		.min		= 1,
-		.max		= 8,
+		.max		= SONY_MAX_BRIGHTNESS,
 		.debug		= 0,
 	},
 	{
@@ -73,7 +89,7 @@ static struct sony_acpi_value {
 		.acpiget	= "GPBR",
 		.acpiset	= "SPBR",
 		.min		= 1,
-		.max		= 8,
+		.max		= SONY_MAX_BRIGHTNESS,
 		.debug		= 0,
 	},
 	{
@@ -276,6 +292,7 @@ static int sony_acpi_add(struct acpi_dev
 {
 	acpi_status status;
 	int result;
+	acpi_handle handle;
 	struct sony_acpi_value *item;
 
 	sony_acpi_handle = device->handle;
@@ -303,9 +320,15 @@ static int sony_acpi_add(struct acpi_dev
 		}
 	}
 
-	for (item = sony_acpi_values; item->name; ++item) {
-		acpi_handle handle;
+	if (ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle, "GBRT", &handle))) {
+		sony_backlight_device = backlight_device_register("sony", NULL,
+					&sony_backlight_properties);
+	        if (IS_ERR(sony_backlight_device)) {
+        	        printk(LOG_PFX "unable to register backlight device\n");
+		}
+	}
 
+	for (item = sony_acpi_values; item->name; ++item) {
 		if (!debug && item->debug)
 			continue;
 
@@ -358,6 +381,9 @@ static int sony_acpi_remove(struct acpi_
 	acpi_status status;
 	struct sony_acpi_value *item;
 
+	if (sony_backlight_device)
+		backlight_device_unregister(sony_backlight_device);
+
 	if (debug) {
 		status = acpi_remove_notify_handler(sony_acpi_handle,
 						    ACPI_DEVICE_NOTIFY,
@@ -375,6 +401,23 @@ static int sony_acpi_remove(struct acpi_
 	return 0;
 }
 
+static int sony_backlight_update_status(struct backlight_device *bd)
+{
+	return acpi_callsetfunc(sony_acpi_handle, "SBRT",
+				bd->props->brightness + 1,
+				NULL);
+}
+
+static int sony_backlight_get_brightness(struct backlight_device *bd)
+{
+	int value;
+
+	if (acpi_callgetfunc(sony_acpi_handle, "GBRT", &value))
+		return 0;
+	/* brightness levels are 1-based, while backlight ones are 0-based */
+	return value - 1;
+}
+
 static struct acpi_driver sony_acpi_driver = {
 	.name	= ACPI_SNC_DRIVER_NAME,
 	.class	= ACPI_SNC_CLASS,
