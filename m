Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264308AbUEIIDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbUEIIDZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 04:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264306AbUEIIDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 04:03:25 -0400
Received: from qfep05.superonline.com ([212.252.122.161]:48523 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S264308AbUEIICs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 04:02:48 -0400
Message-ID: <409DE596.8000808@superonline.com>
Date: Sun, 09 May 2004 11:02:30 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: len.brown@intel.com
Subject: Re: OOPS :  2.4.27-pre2 + latest ACPI
References: <409D50AE.2020908@superonline.com> <409D52D3.5080500@superonline.com>
In-Reply-To: <409D52D3.5080500@superonline.com>
Content-Type: multipart/mixed;
 boundary="------------030900070302040504000308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030900070302040504000308
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit

I backed-out the new module hunks and the
oops went-away. Seems like there are still
problems with the module unloading code.

I attached what I backed-out as a diff below.

Regards;
Özkan Sezer

--------------030900070302040504000308
Content-Type: text/plain;
 name="acpi_backout_module.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi_backout_module.diff"

diff -urN orig/drivers/acpi/ac.c work/drivers/acpi/ac.c
--- orig/drivers/acpi/ac.c	2004-05-09 10:50:52.000000000 +0300
+++ work/drivers/acpi/ac.c	2004-05-09 10:52:20.000000000 +0300
@@ -156,7 +156,6 @@
 			acpi_ac_dir);
 		if (!acpi_device_dir(device))
 			return_VALUE(-ENODEV);
-		acpi_device_dir(device)->owner = THIS_MODULE;
 	}
 
 	/* 'state' [R] */
@@ -169,7 +168,6 @@
 	else {
 		entry->read_proc = acpi_ac_read_state;
 		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
 	}
 
 	return_VALUE(0);
@@ -320,7 +318,6 @@
 	acpi_ac_dir = proc_mkdir(ACPI_AC_CLASS, acpi_root_dir);
 	if (!acpi_ac_dir)
 		return_VALUE(-ENODEV);
-	acpi_ac_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_ac_driver);
 	if (result < 0) {
diff -urN orig/drivers/acpi/battery.c work/drivers/acpi/battery.c
--- orig/drivers/acpi/battery.c	2004-05-09 10:50:52.000000000 +0300
+++ work/drivers/acpi/battery.c	2004-05-09 10:52:20.000000000 +0300
@@ -613,7 +613,6 @@
 			acpi_battery_dir);
 		if (!acpi_device_dir(device))
 			return_VALUE(-ENODEV);
-		acpi_device_dir(device)->owner = THIS_MODULE;
 	}
 
 	/* 'info' [R] */
@@ -626,7 +625,6 @@
 	else {
 		entry->read_proc = acpi_battery_read_info;
 		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
 	}
 
 	/* 'status' [R] */
@@ -639,7 +637,6 @@
 	else {
 		entry->read_proc = acpi_battery_read_state;
 		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
 	}
 
 	/* 'alarm' [R/W] */
@@ -653,7 +650,6 @@
 		entry->read_proc = acpi_battery_read_alarm;
 		entry->write_proc = acpi_battery_write_alarm;
 		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
 	}
 
 	return_VALUE(0);
@@ -805,7 +801,6 @@
 	acpi_battery_dir = proc_mkdir(ACPI_BATTERY_CLASS, acpi_root_dir);
 	if (!acpi_battery_dir)
 		return_VALUE(-ENODEV);
-	acpi_battery_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_battery_driver);
 	if (result < 0) {
diff -urN orig/drivers/acpi/bus.c work/drivers/acpi/bus.c
--- orig/drivers/acpi/bus.c	2004-05-09 10:50:52.000000000 +0300
+++ work/drivers/acpi/bus.c	2004-05-09 10:52:20.000000000 +0300
@@ -1769,23 +1769,15 @@
 }
 
 
-struct acpi_device *acpi_fixed_pwr_button;
-struct acpi_device *acpi_fixed_sleep_button;
-
-EXPORT_SYMBOL(acpi_fixed_pwr_button);
-EXPORT_SYMBOL(acpi_fixed_sleep_button);
-
 static int
 acpi_bus_scan_fixed (
 	struct acpi_device	*root)
 {
 	int			result = 0;
+	struct acpi_device	*device = NULL;
 
 	ACPI_FUNCTION_TRACE("acpi_bus_scan_fixed");
 
-	acpi_fixed_pwr_button = NULL;
-	acpi_fixed_sleep_button = NULL;
-
 	if (!root)
 		return_VALUE(-ENODEV);
 
@@ -1793,11 +1785,11 @@
 	 * Enumerate all fixed-feature devices.
 	 */
 	if (acpi_fadt.pwr_button == 0)
-		result = acpi_bus_add(&acpi_fixed_pwr_button, acpi_root, 
+		result = acpi_bus_add(&device, acpi_root, 
 			NULL, ACPI_BUS_TYPE_POWER_BUTTON);
 
 	if (acpi_fadt.sleep_button == 0)
-		result = acpi_bus_add(&acpi_fixed_sleep_button, acpi_root, 
+		result = acpi_bus_add(&device, acpi_root, 
 			NULL, ACPI_BUS_TYPE_SLEEP_BUTTON);
 
 	return_VALUE(result);
@@ -1972,10 +1964,8 @@
 	acpi_ec_init();		/* ACPI Embedded Controller */
 #endif
 #ifdef CONFIG_ACPI_PCI
-	if (!acpi_pci_disabled) {
-		acpi_pci_link_init();	/* ACPI PCI Interrupt Link */
-		acpi_pci_root_init();	/* ACPI PCI Root Bridge */
-	}
+	acpi_pci_link_init();	/* ACPI PCI Interrupt Link */
+	acpi_pci_root_init();	/* ACPI PCI Root Bridge */
 #endif
 	/*
 	 * Enumerate devices in the ACPI namespace.
diff -urN orig/drivers/acpi/button.c work/drivers/acpi/button.c
--- orig/drivers/acpi/button.c	2004-05-09 10:50:52.000000000 +0300
+++ work/drivers/acpi/button.c	2004-05-09 10:52:20.000000000 +0300
@@ -69,8 +69,6 @@
    -------------------------------------------------------------------------- */
 
 static struct proc_dir_entry	*acpi_button_dir;
-extern struct acpi_device 	*acpi_fixed_pwr_button;
-extern struct acpi_device	*acpi_fixed_sleep_button;
 
 static int
 acpi_button_read_info (
@@ -173,15 +171,10 @@
 				acpi_button_dir);
 		break;
 	}
-	
-	if (!entry)
-		return_VALUE(-ENODEV);
-	entry->owner = THIS_MODULE;
 
 	acpi_device_dir(device) = proc_mkdir(acpi_device_bid(device), entry);
 	if (!acpi_device_dir(device))
 		return_VALUE(-ENODEV);
-	acpi_device_dir(device)->owner = THIS_MODULE;
 
 	/* 'info' [R] */
 	entry = create_proc_entry(ACPI_BUTTON_FILE_INFO,
@@ -193,7 +186,6 @@
 	else {
 		entry->read_proc = acpi_button_read_info;
 		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
 	}
 	
 	if (button->type==ACPI_BUTTON_TYPE_LID){
@@ -207,7 +199,6 @@
 	    else {
 		entry->read_proc = acpi_button_lid_read_state;
 		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
 	    }
 	}
 
@@ -219,28 +210,10 @@
 acpi_button_remove_fs (
 	struct acpi_device	*device)
 {
-	struct acpi_button	*button = NULL;
-
 	ACPI_FUNCTION_TRACE("acpi_button_remove_fs");
 
-	button = acpi_driver_data(device);
 	if (acpi_device_dir(device)) {
-		switch (button->type) {
-			case ACPI_BUTTON_TYPE_POWER:
-			case ACPI_BUTTON_TYPE_POWERF:
-				remove_proc_entry(ACPI_BUTTON_SUBCLASS_POWER, 
-					acpi_button_dir);
-				break;
-			case ACPI_BUTTON_TYPE_SLEEP:
-			case ACPI_BUTTON_TYPE_SLEEPF:
-				remove_proc_entry(ACPI_BUTTON_SUBCLASS_SLEEP, 
-					acpi_button_dir);
-				break;
-			case ACPI_BUTTON_TYPE_LID:
-				remove_proc_entry(ACPI_BUTTON_SUBCLASS_LID, 
-					acpi_button_dir);
-				break;
-		}
+		remove_proc_entry(acpi_device_bid(device), acpi_button_dir);
 		acpi_device_dir(device) = NULL;
 	}
 
@@ -497,7 +470,6 @@
 	acpi_button_dir = proc_mkdir(ACPI_BUTTON_CLASS, acpi_root_dir);
 	if (!acpi_button_dir)
 		return_VALUE(-ENODEV);
-	acpi_button_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_button_driver);
 	if (result < 0) {
@@ -514,12 +486,6 @@
 {
 	ACPI_FUNCTION_TRACE("acpi_button_exit");
 
-	if(acpi_fixed_pwr_button) 
-		acpi_button_remove(acpi_fixed_pwr_button, ACPI_BUS_TYPE_POWER_BUTTON);
-
-	if(acpi_fixed_sleep_button)
-		acpi_button_remove(acpi_fixed_sleep_button, ACPI_BUS_TYPE_SLEEP_BUTTON);
-
 	acpi_bus_unregister_driver(&acpi_button_driver);
 
 	remove_proc_entry(ACPI_BUTTON_CLASS, acpi_root_dir);
diff -urN orig/drivers/acpi/fan.c work/drivers/acpi/fan.c
--- orig/drivers/acpi/fan.c	2004-05-09 10:50:52.000000000 +0300
+++ work/drivers/acpi/fan.c	2004-05-09 10:52:20.000000000 +0300
@@ -151,7 +151,6 @@
 			acpi_fan_dir);
 		if (!acpi_device_dir(device))
 			return_VALUE(-ENODEV);
-		acpi_device_dir(device)->owner = THIS_MODULE;
 	}
 
 	/* 'status' [R/W] */
@@ -165,7 +164,6 @@
 		entry->read_proc = acpi_fan_read_state;
 		entry->write_proc = acpi_fan_write_state;
 		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
 	}
 
 	return_VALUE(0);
@@ -269,7 +267,6 @@
 	acpi_fan_dir = proc_mkdir(ACPI_FAN_CLASS, acpi_root_dir);
 	if (!acpi_fan_dir)
 		return_VALUE(-ENODEV);
-	acpi_fan_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_fan_driver);
 	if (result < 0) {
diff -urN orig/drivers/acpi/Makefile work/drivers/acpi/Makefile
--- orig/drivers/acpi/Makefile	2004-05-09 10:50:52.000000000 +0300
+++ work/drivers/acpi/Makefile	2004-05-09 10:52:20.000000000 +0300
@@ -14,7 +14,7 @@
 
 EXTRA_CFLAGS	+= $(ACPI_CFLAGS)
 
-export-objs 	:= acpi_ksyms.o processor.o bus.o
+export-objs 	:= acpi_ksyms.o processor.o
 
 obj-$(CONFIG_ACPI)	:= acpi_ksyms.o 
 
diff -urN orig/drivers/acpi/thermal.c work/drivers/acpi/thermal.c
--- orig/drivers/acpi/thermal.c	2004-05-09 10:50:52.000000000 +0300
+++ work/drivers/acpi/thermal.c	2004-05-09 10:52:20.000000000 +0300
@@ -1051,7 +1051,6 @@
 			acpi_thermal_dir);
 		if (!acpi_device_dir(device))
 			return_VALUE(-ENODEV);
-		acpi_device_dir(device)->owner = THIS_MODULE;
 	}
 
 	/* 'state' [R] */
@@ -1064,7 +1063,6 @@
 	else {
 		entry->read_proc = acpi_thermal_read_state;
 		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
 	}
 
 	/* 'temperature' [R] */
@@ -1077,7 +1075,6 @@
 	else {
 		entry->read_proc = acpi_thermal_read_temperature;
 		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
 	}
 
 	/* 'trip_points' [R/W] */
@@ -1091,7 +1088,6 @@
 		entry->read_proc = acpi_thermal_read_trip_points;
 		entry->write_proc = acpi_thermal_write_trip_points;
 		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
 	}
 
 	/* 'cooling_mode' [R/W] */
@@ -1105,7 +1101,6 @@
 		entry->read_proc = acpi_thermal_read_cooling_mode;
 		entry->write_proc = acpi_thermal_write_cooling_mode;
 		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
 	}
 
 	/* 'polling_frequency' [R/W] */
@@ -1119,7 +1114,6 @@
 		entry->read_proc = acpi_thermal_read_polling;
 		entry->write_proc = acpi_thermal_write_polling;
 		entry->data = acpi_driver_data(device);
-		entry->owner = THIS_MODULE;
 	}
 
 	return_VALUE(0);
@@ -1338,7 +1332,6 @@
 	acpi_thermal_dir = proc_mkdir(ACPI_THERMAL_CLASS, acpi_root_dir);
 	if (!acpi_thermal_dir)
 		return_VALUE(-ENODEV);
-	acpi_thermal_dir->owner = THIS_MODULE;
 
 	result = acpi_bus_register_driver(&acpi_thermal_driver);
 	if (result < 0) {
diff -urN orig/drivers/acpi/toshiba_acpi.c work/drivers/acpi/toshiba_acpi.c
--- orig/drivers/acpi/toshiba_acpi.c	2004-05-09 10:50:53.000000000 +0300
+++ work/drivers/acpi/toshiba_acpi.c	2004-05-09 10:52:20.000000000 +0300
@@ -503,8 +503,6 @@
 		proc = create_proc_read_entry(item->name,
 			S_IFREG | S_IRUGO | S_IWUSR,
 			toshiba_proc_dir, (read_proc_t*)dispatch_read, item);
-		if (proc)
-			proc->owner = THIS_MODULE;
 		if (proc && item->write_func)
 			proc->write_proc = (write_proc_t*)dispatch_write;
 	}
@@ -552,7 +550,6 @@
 	if (!toshiba_proc_dir) {
 		status = AE_ERROR;
 	} else {
-		toshiba_proc_dir->owner = THIS_MODULE;
 		status = add_device();
 		if (ACPI_FAILURE(status))
 			remove_proc_entry(PROC_TOSHIBA, acpi_root_dir);

--------------030900070302040504000308--

