Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVCRWv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVCRWv7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVCRWv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:51:59 -0500
Received: from zeus.kernel.org ([204.152.189.113]:24536 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262090AbVCRWrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 17:47:40 -0500
Date: Fri, 18 Mar 2005 14:22:38 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: gregkh@suse.de, tony.luck@intel.com, len.brown@intel.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: [patch 12/12] ACPI based root bridge hot-add
Message-ID: <20050318142238.L1145@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050318133856.A878@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050318133856.A878@unix-os.sc.intel.com>; from rajesh.shah@intel.com on Fri, Mar 18, 2005 at 01:38:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

acpiphp changes to support acpi based root bridge hot-add.
This patch applies on top of the acpiphp re-write patch by
Matthew Wilcox at:
http://marc.theaimsgroup.com/?l=linux-ia64&m=110616116714938&w=2

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
---

 linux-2.6.11-mm4-iohp-rshah1/drivers/pci/hotplug/acpiphp_glue.c |  211 +++++++++-
 1 files changed, 202 insertions(+), 9 deletions(-)

diff -puN drivers/pci/hotplug/acpiphp_glue.c~acpiphp_h2p_add drivers/pci/hotplug/acpiphp_glue.c
--- linux-2.6.11-mm4-iohp/drivers/pci/hotplug/acpiphp_glue.c~acpiphp_h2p_add	2005-03-16 13:37:08.716126010 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/pci/hotplug/acpiphp_glue.c	2005-03-16 13:37:08.825501009 -0800
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
@@ -802,6 +806,143 @@ static int acpiphp_check_bridge(struct a
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
@@ -822,8 +963,19 @@ static void handle_hotplug_event_bridge(
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
 
@@ -923,6 +1075,47 @@ static void handle_hotplug_event_func(ac
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
@@ -935,15 +1128,15 @@ static struct acpi_pci_driver acpi_pci_h
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
_
