Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265578AbUANK4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 05:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265646AbUANK4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 05:56:15 -0500
Received: from nikam.ms.mff.cuni.cz ([195.113.18.106]:27603 "EHLO
	nikam.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265578AbUANKz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 05:55:57 -0500
Date: Wed, 14 Jan 2004 11:55:57 +0100
From: Jan Hubicka <jh@suse.cz>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: More 3.4 compilation fixes
Message-ID: <20040114105557.GC26326@kam.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
GCC now converts sprintf (a,"%s",b) to strcpy.  This lose on kernel
as strcpy is not inlined and not present in library, so one gets linker failure.
It seems to make sense to apply this optimization by hand.

Honza

diff -urp ./fs/reiserfs.old/prints.c ./fs/reiserfs/prints.c
--- ./fs/reiserfs.old/prints.c	2004-01-13 01:03:29.000000000 +0100
+++ ./fs/reiserfs/prints.c	2004-01-13 15:41:59.000000000 +0100
@@ -110,7 +110,7 @@ static void sprintf_de_head( char *buf, 
 static void sprintf_item_head (char * buf, struct item_head * ih)
 {
     if (ih) {
-	sprintf (buf, "%s", (ih_version (ih) == KEY_FORMAT_3_6) ? "*3.6* " : "*3.5*");
+	strcpy (buf, (ih_version (ih) == KEY_FORMAT_3_6) ? "*3.6* " : "*3.5*");
 	sprintf_le_key (buf + strlen (buf), &(ih->ih_key));
 	sprintf (buf + strlen (buf), ", item_len %d, item_location %d, "
 		 "free_space(entry_count) %d",
diff -urp ./drivers/net.old/e100/e100_main.c ./drivers/net/e100/e100_main.c
--- ./drivers/net.old/e100/e100_main.c	2004-01-13 15:39:12.000000000 +0100
+++ ./drivers/net/e100/e100_main.c	2004-01-13 16:19:41.000000000 +0100
@@ -3940,8 +3940,7 @@ static int e100_ethtool_gstrings(struct 
 		memset(strings, 0, info.len * ETH_GSTRING_LEN);
 
 		for (i = 0; i < info.len; i++) {
-			sprintf(strings + i * ETH_GSTRING_LEN, "%s",
-				test_strings[i]);
+			strcpy(strings + i * ETH_GSTRING_LEN, test_strings[i]);
 		}
 		if (copy_to_user(ifr->ifr_data, &info, sizeof (info)))
 			ret = -EFAULT;
diff -urp ./drivers/acpi.old/ac.c ./drivers/acpi/ac.c
--- ./drivers/acpi.old/ac.c	2004-01-13 00:30:57.000000000 +0100
+++ ./drivers/acpi/ac.c	2004-01-13 00:31:39.000000000 +0100
@@ -246,8 +246,8 @@ acpi_ac_add (
 	memset(ac, 0, sizeof(struct acpi_ac));
 
 	ac->handle = device->handle;
-	sprintf(acpi_device_name(device), "%s", ACPI_AC_DEVICE_NAME);
-	sprintf(acpi_device_class(device), "%s", ACPI_AC_CLASS);
+	strcpy(acpi_device_name(device), ACPI_AC_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_AC_CLASS);
 	acpi_driver_data(device) = ac;
 
 	result = acpi_ac_get_state(ac);
diff -urp ./drivers/acpi.old/asus_acpi.c ./drivers/acpi/asus_acpi.c
--- ./drivers/acpi.old/asus_acpi.c	2004-01-13 00:30:57.000000000 +0100
+++ ./drivers/acpi/asus_acpi.c	2004-01-13 00:33:27.000000000 +0100
@@ -869,8 +869,8 @@ static int __init asus_hotk_add(struct a
 	memset(hotk, 0, sizeof(struct asus_hotk));
 
 	hotk->handle = device->handle;
-	sprintf(acpi_device_name(device), "%s", ACPI_HOTK_DEVICE_NAME);
-	sprintf(acpi_device_class(device), "%s", ACPI_HOTK_CLASS);
+	strcpy(acpi_device_name(device), ACPI_HOTK_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_HOTK_CLASS);
 	acpi_driver_data(device) = hotk;
 	hotk->device = device;
diff -urp ./drivers/acpi.old/battery.c ./drivers/acpi/battery.c
--- ./drivers/acpi.old/battery.c	2004-01-13 00:30:57.000000000 +0100
+++ ./drivers/acpi/battery.c	2004-01-13 00:33:16.000000000 +0100
@@ -735,8 +735,8 @@ acpi_battery_add (
 	memset(battery, 0, sizeof(struct acpi_battery));
 
 	battery->handle = device->handle;
-	sprintf(acpi_device_name(device), "%s", ACPI_BATTERY_DEVICE_NAME);
-	sprintf(acpi_device_class(device), "%s", ACPI_BATTERY_CLASS);
+	strcpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 	acpi_driver_data(device) = battery;
 
 	result = acpi_battery_check(battery);
diff -urp ./drivers/acpi.old/bus.c ./drivers/acpi/bus.c
--- ./drivers/acpi.old/bus.c	2004-01-13 00:30:57.000000000 +0100
+++ ./drivers/acpi/bus.c	2004-01-13 00:32:43.000000000 +0100
@@ -296,8 +296,8 @@ acpi_bus_generate_event (
 	if (!event)
 		return_VALUE(-ENOMEM);
 
-	sprintf(event->device_class, "%s", device->pnp.device_class);
-	sprintf(event->bus_id, "%s", device->pnp.bus_id);
+	strcpy(event->device_class, device->pnp.device_class);
+	strcpy(event->bus_id, device->pnp.bus_id);
 	event->type = type;
 	event->data = data;
 
diff -urp ./drivers/acpi.old/button.c ./drivers/acpi/button.c
--- ./drivers/acpi.old/button.c	2004-01-13 00:30:57.000000000 +0100
+++ ./drivers/acpi/button.c	2004-01-13 00:35:06.000000000 +0100
@@ -316,35 +316,35 @@ acpi_button_add (
 	 */
 	if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_POWER)) {
 		button->type = ACPI_BUTTON_TYPE_POWER;
-		sprintf(acpi_device_name(device), "%s",
+		strcpy(acpi_device_name(device), 
 			ACPI_BUTTON_DEVICE_NAME_POWER);
 		sprintf(acpi_device_class(device), "%s/%s", 
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
 	}
 	else if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_POWERF)) {
 		button->type = ACPI_BUTTON_TYPE_POWERF;
-		sprintf(acpi_device_name(device), "%s",
+		strcpy(acpi_device_name(device),
 			ACPI_BUTTON_DEVICE_NAME_POWERF);
 		sprintf(acpi_device_class(device), "%s/%s", 
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
 	}
 	else if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_SLEEP)) {
 		button->type = ACPI_BUTTON_TYPE_SLEEP;
-		sprintf(acpi_device_name(device), "%s",
+		strcpy(acpi_device_name(device),
 			ACPI_BUTTON_DEVICE_NAME_SLEEP);
 		sprintf(acpi_device_class(device), "%s/%s", 
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
 	}
 	else if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_SLEEPF)) {
 		button->type = ACPI_BUTTON_TYPE_SLEEPF;
-		sprintf(acpi_device_name(device), "%s",
+		strcpy(acpi_device_name(device),
 			ACPI_BUTTON_DEVICE_NAME_SLEEPF);
 		sprintf(acpi_device_class(device), "%s/%s", 
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
 	}
 	else if (!strcmp(acpi_device_hid(device), ACPI_BUTTON_HID_LID)) {
 		button->type = ACPI_BUTTON_TYPE_LID;
-		sprintf(acpi_device_name(device), "%s",
+		strcpy(acpi_device_name(device),
 			ACPI_BUTTON_DEVICE_NAME_LID);
 		sprintf(acpi_device_class(device), "%s/%s", 
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
diff -urp ./drivers/acpi.old/ec.c ./drivers/acpi/ec.c
--- ./drivers/acpi.old/ec.c	2004-01-13 00:30:57.000000000 +0100
+++ ./drivers/acpi/ec.c	2004-01-13 00:31:51.000000000 +0100
@@ -578,8 +578,8 @@ acpi_ec_add (
 	ec->handle = device->handle;
 	ec->uid = -1;
 	ec->lock = SPIN_LOCK_UNLOCKED;
-	sprintf(acpi_device_name(device), "%s", ACPI_EC_DEVICE_NAME);
-	sprintf(acpi_device_class(device), "%s", ACPI_EC_CLASS);
+	strcpy(acpi_device_name(device), ACPI_EC_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_EC_CLASS);
 	acpi_driver_data(device) = ec;
 
 	/* Use the global lock for all EC transactions? */
diff -urp ./drivers/acpi.old/fan.c ./drivers/acpi/fan.c
--- ./drivers/acpi.old/fan.c	2004-01-13 00:30:57.000000000 +0100
+++ ./drivers/acpi/fan.c	2004-01-13 00:32:54.000000000 +0100
@@ -214,8 +214,8 @@ acpi_fan_add (
 	memset(fan, 0, sizeof(struct acpi_fan));
 
 	fan->handle = device->handle;
-	sprintf(acpi_device_name(device), "%s", ACPI_FAN_DEVICE_NAME);
-	sprintf(acpi_device_class(device), "%s", ACPI_FAN_CLASS);
+	strcpy(acpi_device_name(device), ACPI_FAN_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_FAN_CLASS);
 	acpi_driver_data(device) = fan;
 
 	result = acpi_bus_get_power(fan->handle, &state);
diff -urp ./drivers/acpi.old/pci_link.c ./drivers/acpi/pci_link.c
--- ./drivers/acpi.old/pci_link.c	2004-01-13 00:30:57.000000000 +0100
+++ ./drivers/acpi/pci_link.c	2004-01-13 00:35:39.000000000 +0100
@@ -599,8 +599,8 @@ acpi_pci_link_add (
 
 	link->device = device;
 	link->handle = device->handle;
-	sprintf(acpi_device_name(device), "%s", ACPI_PCI_LINK_DEVICE_NAME);
-	sprintf(acpi_device_class(device), "%s", ACPI_PCI_LINK_CLASS);
+	strcpy(acpi_device_name(device), ACPI_PCI_LINK_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_PCI_LINK_CLASS);
 	acpi_driver_data(device) = link;
 
 	result = acpi_pci_link_get_possible(link);
diff -urp ./drivers/acpi.old/pci_root.c ./drivers/acpi/pci_root.c
--- ./drivers/acpi.old/pci_root.c	2004-01-13 00:30:57.000000000 +0100
+++ ./drivers/acpi/pci_root.c	2004-01-13 00:32:30.000000000 +0100
@@ -227,8 +227,8 @@ acpi_pci_root_add (
 	memset(root, 0, sizeof(struct acpi_pci_root));
 
 	root->handle = device->handle;
-	sprintf(acpi_device_name(device), "%s", ACPI_PCI_ROOT_DEVICE_NAME);
-	sprintf(acpi_device_class(device), "%s", ACPI_PCI_ROOT_CLASS);
+	strcpy(acpi_device_name(device), ACPI_PCI_ROOT_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_PCI_ROOT_CLASS);
 	acpi_driver_data(device) = root;
 
 	/*
diff -urp ./drivers/acpi.old/power.c ./drivers/acpi/power.c
--- ./drivers/acpi.old/power.c	2004-01-13 00:30:57.000000000 +0100
+++ ./drivers/acpi/power.c	2004-01-13 00:35:25.000000000 +0100
@@ -503,9 +503,9 @@ acpi_power_add (
 	memset(resource, 0, sizeof(struct acpi_power_resource));
 
 	resource->handle = device->handle;
-	sprintf(resource->name, "%s", device->pnp.bus_id);
-	sprintf(acpi_device_name(device), "%s", ACPI_POWER_DEVICE_NAME);
-	sprintf(acpi_device_class(device), "%s", ACPI_POWER_CLASS);
+	strcpy(resource->name, device->pnp.bus_id);
+	strcpy(acpi_device_name(device), ACPI_POWER_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_POWER_CLASS);
 	acpi_driver_data(device) = resource;
 
 	/* Evalute the object to get the system level and resource order. */
diff -urp ./drivers/acpi.old/processor.c ./drivers/acpi/processor.c
--- ./drivers/acpi.old/processor.c	2004-01-13 00:30:57.000000000 +0100
+++ ./drivers/acpi/processor.c	2004-01-13 00:33:05.000000000 +0100
@@ -1705,8 +1705,8 @@ acpi_processor_add (
 	memset(pr, 0, sizeof(struct acpi_processor));
 
 	pr->handle = device->handle;
-	sprintf(acpi_device_name(device), "%s", ACPI_PROCESSOR_DEVICE_NAME);
-	sprintf(acpi_device_class(device), "%s", ACPI_PROCESSOR_CLASS);
+	strcpy(acpi_device_name(device), ACPI_PROCESSOR_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_PROCESSOR_CLASS);
 	acpi_driver_data(device) = pr;
 
 	result = acpi_processor_get_info(pr);
diff -urp ./drivers/acpi.old/scan.c ./drivers/acpi/scan.c
--- ./drivers/acpi.old/scan.c	2004-01-13 00:30:57.000000000 +0100
+++ ./drivers/acpi/scan.c	2004-01-13 00:34:33.000000000 +0100
@@ -483,13 +483,13 @@ static void acpi_device_get_busid(struct
 	 */
 	switch (type) {
 	case ACPI_BUS_TYPE_SYSTEM:
-		sprintf(device->pnp.bus_id, "%s", "ACPI");
+		strcpy(device->pnp.bus_id, "ACPI");
 		break;
 	case ACPI_BUS_TYPE_POWER_BUTTON:
-		sprintf(device->pnp.bus_id, "%s", "PWRF");
+		strcpy(device->pnp.bus_id, "PWRF");
 		break;
 	case ACPI_BUS_TYPE_SLEEP_BUTTON:
-		sprintf(device->pnp.bus_id, "%s", "SLPF");
+		strcpy(device->pnp.bus_id, "SLPF");
 		break;
 	default:
 		acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
@@ -500,7 +500,7 @@ static void acpi_device_get_busid(struct
 			else
 				break;
 		}
-		sprintf(device->pnp.bus_id, "%s", bus_id);
+		strcpy(device->pnp.bus_id, bus_id);
 		break;
 	}
 }
@@ -562,16 +562,16 @@ static void acpi_device_set_id(struct ac
 	 */
 	if ((parent == ACPI_ROOT_OBJECT) && (type == ACPI_BUS_TYPE_DEVICE)) {
 		hid = ACPI_BUS_HID;
-		sprintf(device->pnp.device_name, "%s", ACPI_BUS_DEVICE_NAME);
-		sprintf(device->pnp.device_class, "%s", ACPI_BUS_CLASS);
+		strcpy(device->pnp.device_name, ACPI_BUS_DEVICE_NAME);
+		strcpy(device->pnp.device_class, ACPI_BUS_CLASS);
 	}
 
 	if (hid) {
-		sprintf(device->pnp.hardware_id, "%s", hid);
+		strcpy(device->pnp.hardware_id, hid);
 		device->flags.hardware_id = 1;
 	}
 	if (uid) {
-		sprintf(device->pnp.unique_id, "%s", uid);
+		strcpy(device->pnp.unique_id, uid);
 		device->flags.unique_id = 1;
 	}
 	if (cid_list) {
diff -urp ./drivers/acpi.old/thermal.c ./drivers/acpi/thermal.c
--- ./drivers/acpi.old/thermal.c	2004-01-13 00:30:57.000000000 +0100
+++ ./drivers/acpi/thermal.c	2004-01-13 00:33:46.000000000 +0100
@@ -1245,9 +1245,9 @@ acpi_thermal_add (
 	memset(tz, 0, sizeof(struct acpi_thermal));
 
 	tz->handle = device->handle;
-	sprintf(tz->name, "%s", device->pnp.bus_id);
-	sprintf(acpi_device_name(device), "%s", ACPI_THERMAL_DEVICE_NAME);
-	sprintf(acpi_device_class(device), "%s", ACPI_THERMAL_CLASS);
+	strcpy(tz->name, device->pnp.bus_id);
+	strcpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
 	acpi_driver_data(device) = tz;
 
 	result = acpi_thermal_get_info(tz);
