Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265031AbUELMLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbUELMLw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 08:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265032AbUELMLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 08:11:52 -0400
Received: from se1.ruf.uni-freiburg.de ([132.230.2.221]:39568 "EHLO
	se1.ruf.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S265031AbUELMLn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 08:11:43 -0400
X-Scanned: Wed, 12 May 2004 14:11:11 +0200 Nokia Message Protector V1.3.30 2004040916 - RELEASE
To: Andy Grover <andrew.grover@intel.com>,
       Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Bug Fix: 2.6.6 ACPI modules couldn't unload properly
References: <xb7u0ynqqr5.fsf@savona.informatik.uni-freiburg.de>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 12 May 2004 14:11:10 +0200
Message-ID: <xb7d659rgkh.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    Dan> I've enabled ACPI and boot with "acpi=force".  I loaded the
    Dan> ACPI modules "processor", "ac", "battery" and "button".  When
    Dan> I unload any of these modules, I get an oops.  Unloading of
    Dan> these modules didn't occur in 2.6.5 and 2.6.2.

The bug  is due to  the removal of  procfs entries that  are non-empty
directories.  This  leads to  a failed assertion  in the  procfs code,
which dumps an oops message.  (Would this leak to kernel memory leak?)
(Why this  doesn't happen  in 2.6.5 and  2.6.2 is still  mysterious to
me.)

The fix  is to  remove all entries  created by the  corresponding ACPI
modules before removing a directory in /proc.

Here is the patch, against kernel 2.6.6:


--- linux-2.6.6/drivers/acpi/ac.c	2004/05/12 09:51:05	1.1
+++ linux-2.6.6-acpi-procfs-patch/drivers/acpi/ac.c	2004/05/12 09:53:33	1.2
@@ -178,20 +178,23 @@
 }
 
 
 static int
 acpi_ac_remove_fs (
 	struct acpi_device	*device)
 {
 	ACPI_FUNCTION_TRACE("acpi_ac_remove_fs");
 
 	if (acpi_device_dir(device)) {
+		remove_proc_entry(ACPI_AC_FILE_STATE,
+				  acpi_device_dir(device));
+
 		remove_proc_entry(acpi_device_bid(device), acpi_ac_dir);
 		acpi_device_dir(device) = NULL;
 	}
 
 	return_VALUE(0);
 }
 
 
 /* --------------------------------------------------------------------------
                                    Driver Model
--- linux-2.6.6/drivers/acpi/battery.c	2004/05/12 09:55:49	1.1
+++ linux-2.6.6-acpi-procfs-patch/drivers/acpi/battery.c	2004/05/12 09:58:08	1.2
@@ -672,20 +672,27 @@
 }
 
 
 static int
 acpi_battery_remove_fs (
 	struct acpi_device	*device)
 {
 	ACPI_FUNCTION_TRACE("acpi_battery_remove_fs");
 
 	if (acpi_device_dir(device)) {
+		remove_proc_entry(ACPI_BATTERY_FILE_ALARM,
+				  acpi_device_dir(device));
+		remove_proc_entry(ACPI_BATTERY_FILE_STATUS,
+				  acpi_device_dir(device));
+		remove_proc_entry(ACPI_BATTERY_FILE_INFO,
+				  acpi_device_dir(device));
+
 		remove_proc_entry(acpi_device_bid(device), acpi_battery_dir);
 		acpi_device_dir(device) = NULL;
 	}
 
 	return_VALUE(0);
 }
 
 
 /* --------------------------------------------------------------------------
                                  Driver Interface
--- linux-2.6.6/drivers/acpi/button.c	2004/05/12 08:02:46	1.1
+++ linux-2.6.6-acpi-procfs-patch/drivers/acpi/button.c	2004/05/12 09:47:30	1.2
@@ -234,20 +234,30 @@
 static int
 acpi_button_remove_fs (
 	struct acpi_device	*device)
 {
 	struct acpi_button	*button = NULL;
 
 	ACPI_FUNCTION_TRACE("acpi_button_remove_fs");
 
 	button = acpi_driver_data(device);
 	if (acpi_device_dir(device)) {
+		if (button->type == ACPI_BUTTON_TYPE_LID)
+			remove_proc_entry(ACPI_BUTTON_FILE_STATE,
+					     acpi_device_dir(device));
+		remove_proc_entry(ACPI_BUTTON_FILE_INFO,
+				     acpi_device_dir(device));
+
+		remove_proc_entry(acpi_device_bid(device),
+				     acpi_device_dir(device)->parent);
+
+
 		switch (button->type) {
 			case ACPI_BUTTON_TYPE_POWER:
 			case ACPI_BUTTON_TYPE_POWERF:
 				remove_proc_entry(ACPI_BUTTON_SUBCLASS_POWER, 
 					acpi_button_dir);
 				break;
 			case ACPI_BUTTON_TYPE_SLEEP:
 			case ACPI_BUTTON_TYPE_SLEEPF:
 				remove_proc_entry(ACPI_BUTTON_SUBCLASS_SLEEP, 
 					acpi_button_dir);
--- linux-2.6.6/drivers/acpi/ec.c	2004/05/12 10:07:39	1.1
+++ linux-2.6.6-acpi-procfs-patch/drivers/acpi/ec.c	2004/05/12 10:08:36	1.2
@@ -541,20 +541,26 @@
 	return_VALUE(0);
 }
 
 
 static int
 acpi_ec_remove_fs (
 	struct acpi_device	*device)
 {
 	ACPI_FUNCTION_TRACE("acpi_ec_remove_fs");
 
+	if (acpi_device_dir(device)) {
+		remove_proc_entry(ACPI_EC_FILE_INFO, acpi_device_dir(device));
+		remove_proc_entry(acpi_device_bid(device), acpi_ec_dir);
+		acpi_device_dir(device) = NULL;
+	}
+
 	return_VALUE(0);
 }
 
 
 /* --------------------------------------------------------------------------
                                Driver Interface
    -------------------------------------------------------------------------- */
 
 static int
 acpi_ec_add (
--- linux-2.6.6/drivers/acpi/fan.c	2004/05/12 10:09:09	1.1
+++ linux-2.6.6-acpi-procfs-patch/drivers/acpi/fan.c	2004/05/12 10:09:54	1.2
@@ -178,20 +178,22 @@
 }
 
 
 static int
 acpi_fan_remove_fs (
 	struct acpi_device	*device)
 {
 	ACPI_FUNCTION_TRACE("acpi_fan_remove_fs");
 
 	if (acpi_device_dir(device)) {
+		remove_proc_entry(ACPI_FAN_FILE_STATE,
+				  acpi_device_dir(device));
 		remove_proc_entry(acpi_device_bid(device), acpi_fan_dir);
 		acpi_device_dir(device) = NULL;
 	}
 
 	return_VALUE(0);
 }
 
 
 /* --------------------------------------------------------------------------
                                  Driver Interface
--- linux-2.6.6/drivers/acpi/power.c	2004/05/12 10:10:15	1.1
+++ linux-2.6.6-acpi-procfs-patch/drivers/acpi/power.c	2004/05/12 10:10:59	1.2
@@ -475,20 +475,22 @@
 }
 
 
 static int
 acpi_power_remove_fs (
 	struct acpi_device	*device)
 {
 	ACPI_FUNCTION_TRACE("acpi_power_remove_fs");
 
 	if (acpi_device_dir(device)) {
+		remove_proc_entry(ACPI_POWER_FILE_STATUS,
+				  acpi_device_dir(device));
 		remove_proc_entry(acpi_device_bid(device), acpi_power_dir);
 		acpi_device_dir(device) = NULL;
 	}
 
 	return_VALUE(0);
 }
 
 
 /* --------------------------------------------------------------------------
                                 Driver Interface
--- linux-2.6.6/drivers/acpi/thermal.c	2004/05/12 10:13:01	1.1
+++ linux-2.6.6-acpi-procfs-patch/drivers/acpi/thermal.c	2004/05/12 10:13:36	1.2
@@ -1132,20 +1132,30 @@
 }
 
 
 static int
 acpi_thermal_remove_fs (
 	struct acpi_device	*device)
 {
 	ACPI_FUNCTION_TRACE("acpi_thermal_remove_fs");
 
 	if (acpi_device_dir(device)) {
+		remove_proc_entry(ACPI_THERMAL_FILE_POLLING_FREQ,
+				  acpi_device_dir(device));
+		remove_proc_entry(ACPI_THERMAL_FILE_COOLING_MODE,
+				  acpi_device_dir(device));
+		remove_proc_entry(ACPI_THERMAL_FILE_TRIP_POINTS,
+				  acpi_device_dir(device));
+		remove_proc_entry(ACPI_THERMAL_FILE_TEMPERATURE,
+				  acpi_device_dir(device));
+		remove_proc_entry(ACPI_THERMAL_FILE_STATE,
+				  acpi_device_dir(device));
 		remove_proc_entry(acpi_device_bid(device), acpi_thermal_dir);
 		acpi_device_dir(device) = NULL;
 	}
 
 	return_VALUE(0);
 }
 
 
 /* --------------------------------------------------------------------------
                                  Driver Interface




-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

