Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWDSTyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWDSTyF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWDSTyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:54:04 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:4062 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751208AbWDSTyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:54:03 -0400
Date: Wed, 19 Apr 2006 20:53:58 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060419195356.GA24122@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sleep and power buttons are logically part of the keyboard, and it makes 
for them to be exposed via an input device rather than an odd file in 
/proc. This patch adds a keycode for lid switches (are we running out of 
keycodes?) and allows the button driver to register an input device.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

diff -ur drivers/acpi.bak/button.c drivers/acpi/button.c
--- drivers/acpi.bak/button.c	2006-04-03 04:22:10 +0100
+++ a/drivers/acpi/button.c	2006-04-19 20:36:05 +0100
@@ -26,6 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/input.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -102,6 +103,8 @@
 	.release = single_release,
 };
 
+static struct input_dev *input_dev;
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
@@ -260,6 +263,37 @@
                                 Driver Interface
    -------------------------------------------------------------------------- */
 
+static void acpi_button_report (struct acpi_button *button)
+{
+	int keycode = 0;
+
+	ACPI_FUNCTION_TRACE("acpi_button_report");
+
+	switch(button->type) {
+	case ACPI_BUTTON_TYPE_POWER:
+	case ACPI_BUTTON_TYPE_POWERF:
+		keycode = KEY_POWER;
+		break;
+	case ACPI_BUTTON_TYPE_SLEEP:
+	case ACPI_BUTTON_TYPE_SLEEPF:
+		keycode = KEY_SLEEP;
+		break;
+	case ACPI_BUTTON_TYPE_LID:
+		keycode = KEY_LID;
+		break;
+
+	}
+
+	if (keycode) {
+		input_report_key(input_dev, keycode, 1);
+		input_sync(input_dev);
+		input_report_key(input_dev, keycode, 0);
+		input_sync(input_dev);
+	}
+
+	return_VOID;
+}
+
 static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_button *button = (struct acpi_button *)data;
@@ -273,6 +307,7 @@
 	case ACPI_BUTTON_NOTIFY_STATUS:
 		acpi_bus_generate_event(button->device, event,
 					++button->pushed);
+		acpi_button_report(button);		
 		break;
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -467,6 +502,26 @@
 		return_VALUE(-ENODEV);
 	}
 
+	input_dev = input_allocate_device();
+
+	if (input_dev) {
+		int error;
+
+		input_dev->name = "ACPI button driver";
+		input_dev->phys = "acpi/input0";
+		input_dev->id.bustype = BUS_HOST;
+		input_dev->evbit[LONG(EV_KEY)] = BIT(EV_KEY);
+		set_bit(KEY_SLEEP, input_dev->keybit);
+		set_bit(KEY_POWER, input_dev->keybit);
+		set_bit(KEY_LID, input_dev->keybit);
+
+		error = input_register_device(input_dev);
+		if (error) {
+			printk(KERN_ERR "Unable to register ACPI input device\n");
+			input_free_device(input_dev);
+		}
+	}
+
 	return_VALUE(0);
 }
 
@@ -484,6 +539,9 @@
 		remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID, acpi_button_dir);
 	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
 
+	if (input_dev)
+		input_unregister_device(input_dev);
+
 	return_VOID;
 }
 
--- include/linux/input.h.bak	2006-04-19 20:47:58 +0100
+++ a/include/linux/input.h	2006-04-19 20:49:18 +0100
@@ -344,6 +344,7 @@
 #define KEY_FORWARDMAIL		233
 #define KEY_SAVE		234
 #define KEY_DOCUMENTS		235
+#define KEY_LID			237
 
 #define KEY_UNKNOWN		240

-- 
Matthew Garrett | mjg59@srcf.ucam.org
