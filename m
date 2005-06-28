Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVF1GUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVF1GUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVF1GUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:20:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:39404 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261925AbVF1Fdz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:55 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] acpi hotplug: aCPI based root bridge hot-add
In-Reply-To: <1119936774423@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:54 -0700
Message-Id: <11199367741570@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] acpi hotplug: aCPI based root bridge hot-add

acpiphp changes to support acpi based root bridge hot-add.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 8e7561cfbdf00fb1cee694cef0e825d0548aedbc
tree e17b88f3200fb35ea62c7f6896cf21977d551b8a
parent 2f523b15901f654a9448bbd47ebe1e783ec3195b
author Rajesh Shah <rajesh.shah@intel.com> Thu, 28 Apr 2005 00:25:56 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:43 -0700

 drivers/pci/hotplug/acpiphp_glue.c |  211 ++++++++++++++++++++++++++++++++++--
 1 files changed, 202 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -6,6 +6,8 @@
  * Copyright (C) 2002,2003 NEC Corporation
  * Copyright (C) 2003-2005 Matthew Wilcox (matthew.wilcox@hp.com)
  * Copyright (C) 2003-2005 Hewlett Packard
+ * Copyright (C) 2005 Rajesh Shah (rajesh.shah@intel.com)
+ * Copyright (C) 2005 Intel Corporation
  *
  * All rights reserved.
  *
@@ -304,13 +306,15 @@ static void init_bridge_misc(struct acpi
 				     register_slot, bridge, NULL);
 
 	/* install notify handler */
-	status = acpi_install_notify_handler(bridge->handle,
+	if (bridge->type != BRIDGE_TYPE_HOST) {
+		status = acpi_install_notify_handler(bridge->handle,
 					     ACPI_SYSTEM_NOTIFY,
 					     handle_hotplug_event_bridge,
 					     bridge);
 
-	if (ACPI_FAILURE(status)) {
-		err("failed to register interrupt notify handler\n");
+		if (ACPI_FAILURE(status)) {
+			err("failed to register interrupt notify handler\n");
+		}
 	}
 
 	list_add(&bridge->list, &bridge_list);
@@ -820,6 +824,143 @@ static int acpiphp_check_bridge(struct a
 	return retval;
 }
 
+static void program_hpp(struct pci_dev *dev, struct acpiphp_bridge *bridge)
+{
+	u16 pci_cmd, pci_bctl;
+	struct pci_dev *cdev;
+
+	/* Program hpp values for this device */
+	if (!(dev->hdr_type == PCI_HEADER_TYPE_NORMAL ||
+			(dev->hdr_type == PCI_HEADER_TYPE_BRIDGE &&
+			(dev->class >> 8) == PCI_CLASS_BRIDGE_PCI)))
+		return;
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE,
+			bridge->hpp.cache_line_size);
+	pci_write_config_byte(dev, PCI_LATENCY_TIMER,
+			bridge->hpp.latency_timer);
+	pci_read_config_word(dev, PCI_COMMAND, &pci_cmd);
+	if (bridge->hpp.enable_SERR)
+		pci_cmd |= PCI_COMMAND_SERR;
+	else
+		pci_cmd &= ~PCI_COMMAND_SERR;
+	if (bridge->hpp.enable_PERR)
+		pci_cmd |= PCI_COMMAND_PARITY;
+	else
+		pci_cmd &= ~PCI_COMMAND_PARITY;
+	pci_write_config_word(dev, PCI_COMMAND, pci_cmd);
+
+	/* Program bridge control value and child devices */
+	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI) {
+		pci_write_config_byte(dev, PCI_SEC_LATENCY_TIMER,
+				bridge->hpp.latency_timer);
+		pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &pci_bctl);
+		if (bridge->hpp.enable_SERR)
+			pci_bctl |= PCI_BRIDGE_CTL_SERR;
+		else
+			pci_bctl &= ~PCI_BRIDGE_CTL_SERR;
+		if (bridge->hpp.enable_PERR)
+			pci_bctl |= PCI_BRIDGE_CTL_PARITY;
+		else
+			pci_bctl &= ~PCI_BRIDGE_CTL_PARITY;
+		pci_write_config_word(dev, PCI_BRIDGE_CONTROL, pci_bctl);
+		if (dev->subordinate) {
+			list_for_each_entry(cdev, &dev->subordinate->devices,
+					bus_list)
+				program_hpp(cdev, bridge);
+		}
+	}
+}
+
+static void acpiphp_set_hpp_values(acpi_handle handle, struct pci_bus *bus)
+{
+	struct acpiphp_bridge bridge;
+	struct pci_dev *dev;
+
+	memset(&bridge, 0, sizeof(bridge));
+	bridge.handle = handle;
+	decode_hpp(&bridge);
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		program_hpp(dev, &bridge);
+
+}
+
+/*
+ * Remove devices for which we could not assign resources, call
+ * arch specific code to fix-up the bus
+ */
+static void acpiphp_sanitize_bus(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+	int i;
+	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		for (i=0; i<PCI_BRIDGE_RESOURCES; i++) {
+			struct resource *res = &dev->resource[i];
+			if ((res->flags & type_mask) && !res->start &&
+					res->end) {
+				/* Could not assign a required resources
+				 * for this device, remove it */
+				pci_remove_bus_device(dev);
+				break;
+			}
+		}
+	}
+}
+
+/* Program resources in newly inserted bridge */
+static int acpiphp_configure_bridge (acpi_handle handle)
+{
+	struct acpi_pci_id pci_id;
+	struct pci_bus *bus;
+
+	if (ACPI_FAILURE(acpi_get_pci_id(handle, &pci_id))) {
+		err("cannot get PCI domain and bus number for bridge\n");
+		return -EINVAL;
+	}
+	bus = pci_find_bus(pci_id.segment, pci_id.bus);
+	if (!bus) {
+		err("cannot find bus %d:%d\n",
+				pci_id.segment, pci_id.bus);
+		return -EINVAL;
+	}
+
+	pci_bus_size_bridges(bus);
+	pci_bus_assign_resources(bus);
+	acpiphp_sanitize_bus(bus);
+	acpiphp_set_hpp_values(handle, bus);
+	pci_enable_bridges(bus);
+	return 0;
+}
+
+static void handle_bridge_insertion(acpi_handle handle, u32 type)
+{
+	struct acpi_device *device, *pdevice;
+	acpi_handle phandle;
+
+	if ((type != ACPI_NOTIFY_BUS_CHECK) &&
+			(type != ACPI_NOTIFY_DEVICE_CHECK)) {
+		err("unexpected notification type %d\n", type);
+		return;
+	}
+
+	acpi_get_parent(handle, &phandle);
+	if (acpi_bus_get_device(phandle, &pdevice)) {
+		dbg("no parent device, assuming NULL\n");
+		pdevice = NULL;
+	}
+	if (acpi_bus_add(&device, pdevice, handle, ACPI_BUS_TYPE_DEVICE)) {
+		err("cannot add bridge to acpi list\n");
+		return;
+	}
+	if (!acpiphp_configure_bridge(handle) &&
+		!acpi_bus_start(device))
+		add_bridge(handle);
+	else
+		err("cannot configure and start bridge\n");
+
+}
+
 /*
  * ACPI event handlers
  */
@@ -840,8 +981,19 @@ static void handle_hotplug_event_bridge(
 	char objname[64];
 	struct acpi_buffer buffer = { .length = sizeof(objname),
 				      .pointer = objname };
+	struct acpi_device *device;
 
-	bridge = (struct acpiphp_bridge *)context;
+	if (acpi_bus_get_device(handle, &device)) {
+		/* This bridge must have just been physically inserted */
+		handle_bridge_insertion(handle, type);
+		return;
+	}
+
+	bridge = acpiphp_handle_to_bridge(handle);
+	if (!bridge) {
+		err("cannot get bridge info\n");
+		return;
+	}
 
 	acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
 
@@ -941,6 +1093,47 @@ static void handle_hotplug_event_func(ac
 	}
 }
 
+static int is_root_bridge(acpi_handle handle)
+{
+	acpi_status status;
+	struct acpi_device_info *info;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	int i;
+
+	status = acpi_get_object_info(handle, &buffer);
+	if (ACPI_SUCCESS(status)) {
+		info = buffer.pointer;
+		if ((info->valid & ACPI_VALID_HID) &&
+			!strcmp(PCI_ROOT_HID_STRING,
+					info->hardware_id.value)) {
+			acpi_os_free(buffer.pointer);
+			return 1;
+		}
+		if (info->valid & ACPI_VALID_CID) {
+			for (i=0; i < info->compatibility_id.count; i++) {
+				if (!strcmp(PCI_ROOT_HID_STRING,
+					info->compatibility_id.id[i].value)) {
+					acpi_os_free(buffer.pointer);
+					return 1;
+				}
+			}
+		}
+	}
+	return 0;
+}
+
+static acpi_status
+find_root_bridges(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	int *count = (int *)context;
+
+	if (is_root_bridge(handle)) {
+		acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
+				handle_hotplug_event_bridge, NULL);
+			(*count)++;
+	}
+	return AE_OK ;
+}
 
 static struct acpi_pci_driver acpi_pci_hp_driver = {
 	.add =		add_bridge,
@@ -953,15 +1146,15 @@ static struct acpi_pci_driver acpi_pci_h
  */
 int __init acpiphp_glue_init(void)
 {
-	int num;
-
-	if (list_empty(&pci_root_buses))
-		return -1;
+	int num = 0;
 
-	num = acpi_pci_register_driver(&acpi_pci_hp_driver);
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+			ACPI_UINT32_MAX, find_root_bridges, &num, NULL);
 
 	if (num <= 0)
 		return -1;
+	else
+		acpi_pci_register_driver(&acpi_pci_hp_driver);
 
 	return 0;
 }

