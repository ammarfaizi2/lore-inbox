Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269772AbUICTn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269772AbUICTn4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269486AbUICTnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:43:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15532 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269772AbUICTcr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:32:47 -0400
Date: Fri, 3 Sep 2004 20:32:43 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Greg KH <greg@kroah.com>, pcihpd-discuss@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: [PATCH] acpiphp domain support [3/5]
Message-ID: <20040903193243.GR642@parcelfarce.linux.theplanet.co.uk>
References: <20040903193027.GO642@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903193027.GO642@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


acpiphp doesn't work very well on a machine with multiple PCI domains.
This patch improves the situation by using pci_get_slot() instead of
pci_find_slot().  The new reference couting rules are documented at the
top of acpiphp_glue.c.  This necessitated some cleanup of error handling
paths and change of calling conventions.

The seg/bus/sub entries are removed from struct acpiphp_bridge and
retrieved from the pci_bus when necessary.  The per-bridge removal code
is moved from acpiphp_glue_exit() to the remove_bridge() method where
it should have been all along.

I've added my copyright and bumped the version number.

diff -urpNX build-tools/dontdiff linux-2.6/drivers/pci/hotplug/acpiphp.h hotplug-2.6/drivers/pci/hotplug/acpiphp.h
--- linux-2.6/drivers/pci/hotplug/acpiphp.h	2004-05-23 17:52:23.000000000 -0600
+++ hotplug-2.6/drivers/pci/hotplug/acpiphp.h	2004-09-02 13:35:46.000000000 -0600
@@ -101,10 +101,6 @@ struct acpiphp_bridge {
 	int type;
 	int nr_slots;
 
-	u8 seg;
-	u8 bus;
-	u8 sub;
-
 	u32 flags;
 
 	/* This bus (host bridge) or Secondary bus (PCI-to-PCI bridge) */
diff -urpNX build-tools/dontdiff linux-2.6/drivers/pci/hotplug/acpiphp_core.c hotplug-2.6/drivers/pci/hotplug/acpiphp_core.c
--- linux-2.6/drivers/pci/hotplug/acpiphp_core.c	2004-05-23 17:52:23.000000000 -0600
+++ hotplug-2.6/drivers/pci/hotplug/acpiphp_core.c	2004-09-03 08:09:15.181670908 -0600
@@ -7,6 +7,8 @@
  * Copyright (C) 2002 Hiroshi Aono (h-aono@ap.jp.nec.com)
  * Copyright (C) 2002,2003 Takayoshi Kochi (t-kochi@bq.jp.nec.com)
  * Copyright (C) 2002,2003 NEC Corporation
+ * Copyright (C) 2003,2004 Matthew Wilcox (matthew.wilcox@hp.com)
+ * Copyright (C) 2003,2004 Hewlett Packard
  *
  * All rights reserved.
  *
@@ -52,8 +54,8 @@ static LIST_HEAD(slot_list);
 /* local variables */
 static int num_slots;
 
-#define DRIVER_VERSION	"0.4"
-#define DRIVER_AUTHOR	"Greg Kroah-Hartman <gregkh@us.ibm.com>, Takayoshi Kochi <t-kochi@bq.jp.nec.com>"
+#define DRIVER_VERSION	"0.5"
+#define DRIVER_AUTHOR	"Greg Kroah-Hartman <gregkh@us.ibm.com>, Takayoshi Kochi <t-kochi@bq.jp.nec.com>, Matthew Wilcox <willy@hp.com>"
 #define DRIVER_DESC	"ACPI Hot Plug PCI Controller Driver"
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
diff -urpNX build-tools/dontdiff linux-2.6/drivers/pci/hotplug/acpiphp_glue.c hotplug-2.6/drivers/pci/hotplug/acpiphp_glue.c
--- linux-2.6/drivers/pci/hotplug/acpiphp_glue.c	2004-07-20 16:06:36.000000000 -0600
+++ hotplug-2.6/drivers/pci/hotplug/acpiphp_glue.c	2004-09-03 09:27:41.741039272 -0600
@@ -26,6 +26,16 @@
  *
  */
 
+/*
+ * Lifetime rules for pci_dev:
+ *  - The one in acpiphp_func has its refcount elevated by pci_get_slot()
+ *    when the driver is loaded or when an insertion event occurs.  It loses
+ *    a refcount when its ejected or the driver unloads.
+ *  - The one in acpiphp_bridge has its refcount elevated by pci_get_slot()
+ *    when the bridge is scanned and it loses a refcount when the bridge
+ *    is removed.
+ */
+
 #include <linux/init.h>
 #include <linux/module.h>
 
@@ -178,18 +188,20 @@ register_slot(acpi_handle handle, u32 lv
 
 		bridge->nr_slots++;
 
-		dbg("found ACPI PCI Hotplug slot at PCI %02x:%02x Slot:%d\n",
-		    slot->bridge->bus, slot->device, slot->sun);
+		dbg("found ACPI PCI Hotplug slot %d at PCI %04x:%02x:%02x\n",
+				slot->sun, pci_domain_nr(bridge->pci_bus),
+				bridge->pci_bus->number, slot->device);
 	}
 
 	newfunc->slot = slot;
 	list_add_tail(&newfunc->sibling, &slot->funcs);
 
 	/* associate corresponding pci_dev */
-	newfunc->pci_dev = pci_find_slot(bridge->bus,
+	newfunc->pci_dev = pci_get_slot(bridge->pci_bus,
 					 PCI_DEVFN(device, function));
 	if (newfunc->pci_dev) {
 		if (acpiphp_init_func_resource(newfunc) < 0) {
+			pci_dev_put(newfunc->pci_dev);
 			kfree(newfunc);
 			return AE_ERROR;
 		}
@@ -371,7 +383,7 @@ static void init_bridge_misc(struct acpi
 
 
 /* allocate and initialize host bridge data structure */
-static void add_host_bridge(acpi_handle *handle, int seg, int bus)
+static void add_host_bridge(acpi_handle *handle, struct pci_bus *pci_bus)
 {
 	acpi_status status;
 	struct acpiphp_bridge *bridge;
@@ -384,16 +396,11 @@ static void add_host_bridge(acpi_handle 
 
 	bridge->type = BRIDGE_TYPE_HOST;
 	bridge->handle = handle;
-	bridge->seg = seg;
-	bridge->bus = bus;
 
-	bridge->pci_bus = pci_find_bus(seg, bus);
+	bridge->pci_bus = pci_bus;
 
 	bridge->res_lock = SPIN_LOCK_UNLOCKED;
 
-	/* to be overridden when we decode _CRS	*/
-	bridge->sub = bridge->bus;
-
 	/* decode resources */
 
 	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
@@ -414,8 +421,18 @@ static void add_host_bridge(acpi_handle 
 	acpiphp_dump_resource(bridge);
 
 	if (bridge->bus_head) {
-		bridge->bus = bridge->bus_head->base;
-		bridge->sub = bridge->bus_head->base + bridge->bus_head->length - 1;
+		int base = bridge->bus_head->base;
+		int max = base + bridge->bus_head->length - 1;
+		if (bridge->bus_head->base != bridge->pci_bus->number) {
+			warn("ACPI says we have bus %d but Linux found "
+					"bus %d\n", base,
+					bridge->pci_bus->number);
+		}
+		if (max < bridge->pci_bus->subordinate) {
+			warn("ACPI says busses available up to %d, but "
+					"we found %d\n", max,
+					bridge->pci_bus->subordinate);
+		}
 	}
 
 	init_bridge_misc(bridge);
@@ -423,7 +440,7 @@ static void add_host_bridge(acpi_handle 
 
 
 /* allocate and initialize PCI-to-PCI bridge data structure */
-static void add_p2p_bridge(acpi_handle *handle, int seg, int bus, int dev, int fn)
+static void add_p2p_bridge(acpi_handle *handle, struct pci_dev *pci_dev)
 {
 	struct acpiphp_bridge *bridge;
 	u8 tmp8;
@@ -441,35 +458,24 @@ static void add_p2p_bridge(acpi_handle *
 
 	bridge->type = BRIDGE_TYPE_P2P;
 	bridge->handle = handle;
-	bridge->seg = seg;
-
-	bridge->pci_dev = pci_find_slot(bus, PCI_DEVFN(dev, fn));
-	if (!bridge->pci_dev) {
-		err("Can't get pci_dev\n");
-		kfree(bridge);
-		return;
-	}
 
-	bridge->pci_bus = bridge->pci_dev->subordinate;
+	bridge->pci_dev = pci_dev_get(pci_dev);
+	bridge->pci_bus = pci_dev->subordinate;
 	if (!bridge->pci_bus) {
 		err("This is not a PCI-to-PCI bridge!\n");
-		kfree(bridge);
-		return;
+		goto err;
 	}
 
 	bridge->res_lock = SPIN_LOCK_UNLOCKED;
 
-	bridge->bus = bridge->pci_bus->number;
-	bridge->sub = bridge->pci_bus->subordinate;
-
 	/*
 	 * decode resources under this P2P bridge
 	 */
 
 	/* I/O resources */
-	pci_read_config_byte(bridge->pci_dev, PCI_IO_BASE, &tmp8);
+	pci_read_config_byte(pci_dev, PCI_IO_BASE, &tmp8);
 	base = tmp8;
-	pci_read_config_byte(bridge->pci_dev, PCI_IO_LIMIT, &tmp8);
+	pci_read_config_byte(pci_dev, PCI_IO_LIMIT, &tmp8);
 	limit = tmp8;
 
 	switch (base & PCI_IO_RANGE_TYPE_MASK) {
@@ -477,26 +483,22 @@ static void add_p2p_bridge(acpi_handle *
 		base = (base << 8) & 0xf000;
 		limit = ((limit << 8) & 0xf000) + 0xfff;
 		bridge->io_head = acpiphp_make_resource((u64)base, limit - base + 1);
-		if (!bridge->io_head) {
-			err("out of memory\n");
-			kfree(bridge);
-			return;
-		}
+		if (!bridge->io_head)
+			goto oom;
+
 		dbg("16bit I/O range: %04x-%04x\n",
 		    (u32)bridge->io_head->base,
 		    (u32)(bridge->io_head->base + bridge->io_head->length - 1));
 		break;
 	case PCI_IO_RANGE_TYPE_32:
-		pci_read_config_word(bridge->pci_dev, PCI_IO_BASE_UPPER16, &tmp16);
+		pci_read_config_word(pci_dev, PCI_IO_BASE_UPPER16, &tmp16);
 		base = ((u32)tmp16 << 16) | ((base << 8) & 0xf000);
-		pci_read_config_word(bridge->pci_dev, PCI_IO_LIMIT_UPPER16, &tmp16);
+		pci_read_config_word(pci_dev, PCI_IO_LIMIT_UPPER16, &tmp16);
 		limit = (((u32)tmp16 << 16) | ((limit << 8) & 0xf000)) + 0xfff;
 		bridge->io_head = acpiphp_make_resource((u64)base, limit - base + 1);
-		if (!bridge->io_head) {
-			err("out of memory\n");
-			kfree(bridge);
-			return;
-		}
+		if (!bridge->io_head)
+			goto oom;
+
 		dbg("32bit I/O range: %08x-%08x\n",
 		    (u32)bridge->io_head->base,
 		    (u32)(bridge->io_head->base + bridge->io_head->length - 1));
@@ -509,24 +511,22 @@ static void add_p2p_bridge(acpi_handle *
 	}
 
 	/* Memory resources (mandatory for P2P bridge) */
-	pci_read_config_word(bridge->pci_dev, PCI_MEMORY_BASE, &tmp16);
+	pci_read_config_word(pci_dev, PCI_MEMORY_BASE, &tmp16);
 	base = (tmp16 & 0xfff0) << 16;
-	pci_read_config_word(bridge->pci_dev, PCI_MEMORY_LIMIT, &tmp16);
+	pci_read_config_word(pci_dev, PCI_MEMORY_LIMIT, &tmp16);
 	limit = ((tmp16 & 0xfff0) << 16) | 0xfffff;
 	bridge->mem_head = acpiphp_make_resource((u64)base, limit - base + 1);
-	if (!bridge->mem_head) {
-		err("out of memory\n");
-		kfree(bridge);
-		return;
-	}
+	if (!bridge->mem_head)
+		goto oom;
+
 	dbg("32bit Memory range: %08x-%08x\n",
 	    (u32)bridge->mem_head->base,
 	    (u32)(bridge->mem_head->base + bridge->mem_head->length-1));
 
 	/* Prefetchable Memory resources (optional) */
-	pci_read_config_word(bridge->pci_dev, PCI_PREF_MEMORY_BASE, &tmp16);
+	pci_read_config_word(pci_dev, PCI_PREF_MEMORY_BASE, &tmp16);
 	base = tmp16;
-	pci_read_config_word(bridge->pci_dev, PCI_PREF_MEMORY_LIMIT, &tmp16);
+	pci_read_config_word(pci_dev, PCI_PREF_MEMORY_LIMIT, &tmp16);
 	limit = tmp16;
 
 	switch (base & PCI_MEMORY_RANGE_TYPE_MASK) {
@@ -534,27 +534,21 @@ static void add_p2p_bridge(acpi_handle *
 		base = (base & 0xfff0) << 16;
 		limit = ((limit & 0xfff0) << 16) | 0xfffff;
 		bridge->p_mem_head = acpiphp_make_resource((u64)base, limit - base + 1);
-		if (!bridge->p_mem_head) {
-			err("out of memory\n");
-			kfree(bridge);
-			return;
-		}
+		if (!bridge->p_mem_head)
+			goto oom;
 		dbg("32bit Prefetchable memory range: %08x-%08x\n",
 		    (u32)bridge->p_mem_head->base,
 		    (u32)(bridge->p_mem_head->base + bridge->p_mem_head->length - 1));
 		break;
 	case PCI_PREF_RANGE_TYPE_64:
-		pci_read_config_dword(bridge->pci_dev, PCI_PREF_BASE_UPPER32, &base32u);
-		pci_read_config_dword(bridge->pci_dev, PCI_PREF_LIMIT_UPPER32, &limit32u);
+		pci_read_config_dword(pci_dev, PCI_PREF_BASE_UPPER32, &base32u);
+		pci_read_config_dword(pci_dev, PCI_PREF_LIMIT_UPPER32, &limit32u);
 		base64 = ((u64)base32u << 32) | ((base & 0xfff0) << 16);
 		limit64 = (((u64)limit32u << 32) | ((limit & 0xfff0) << 16)) + 0xfffff;
 
 		bridge->p_mem_head = acpiphp_make_resource(base64, limit64 - base64 + 1);
-		if (!bridge->p_mem_head) {
-			err("out of memory\n");
-			kfree(bridge);
-			return;
-		}
+		if (!bridge->p_mem_head)
+			goto oom;
 		dbg("64bit Prefetchable memory range: %08x%08x-%08x%08x\n",
 		    (u32)(bridge->p_mem_head->base >> 32),
 		    (u32)(bridge->p_mem_head->base & 0xffffffff),
@@ -568,6 +562,13 @@ static void add_p2p_bridge(acpi_handle *
 	}
 
 	init_bridge_misc(bridge);
+	return;
+ oom:
+	err("out of memory\n");
+ err:
+	pci_dev_put(pci_dev);
+	kfree(bridge);
+	return;
 }
 
 
@@ -577,14 +578,10 @@ find_p2p_bridge(acpi_handle handle, u32 
 {
 	acpi_status status;
 	acpi_handle dummy_handle;
-	unsigned long *segbus = context;
 	unsigned long tmp;
-	int seg, bus, device, function;
+	int device, function;
 	struct pci_dev *dev;
-
-	/* get PCI address */
-	seg = (*segbus >> 8) & 0xff;
-	bus = *segbus & 0xff;
+	struct pci_bus *pci_bus = context;
 
 	status = acpi_get_handle(handle, "_ADR", &dummy_handle);
 	if (ACPI_FAILURE(status))
@@ -599,20 +596,19 @@ find_p2p_bridge(acpi_handle handle, u32 
 	device = (tmp >> 16) & 0xffff;
 	function = tmp & 0xffff;
 
-	dev = pci_find_slot(bus, PCI_DEVFN(device, function));
+	dev = pci_get_slot(pci_bus, PCI_DEVFN(device, function));
 
-	if (!dev)
-		return AE_OK;
-
-	if (!dev->subordinate)
-		return AE_OK;
+	if (!dev || !dev->subordinate)
+		goto out;
 
 	/* check if this bridge has ejectable slots */
 	if (detect_ejectable_slots(handle) > 0) {
 		dbg("found PCI-to-PCI bridge at PCI %s\n", pci_name(dev));
-		add_p2p_bridge(handle, seg, bus, device, function);
+		add_p2p_bridge(handle, dev);
 	}
 
+ out:
+	pci_dev_put(dev);
 	return AE_OK;
 }
 
@@ -624,6 +620,7 @@ static int add_bridge(acpi_handle handle
 	unsigned long tmp;
 	int seg, bus;
 	acpi_handle dummy_handle;
+	struct pci_bus *pci_bus;
 
 	/* if the bridge doesn't have _STA, we assume it is always there */
 	status = acpi_get_handle(handle, "_STA", &dummy_handle);
@@ -653,18 +650,22 @@ static int add_bridge(acpi_handle handle
 		bus = 0;
 	}
 
+	pci_bus = pci_find_bus(seg, bus);
+	if (!pci_bus) {
+		err("Can't find bus %04x:%02x\n", seg, bus);
+		return 0;
+	}
+
 	/* check if this bridge has ejectable slots */
 	if (detect_ejectable_slots(handle) > 0) {
 		dbg("found PCI host-bus bridge with hot-pluggable slots\n");
-		add_host_bridge(handle, seg, bus);
+		add_host_bridge(handle, pci_bus);
 		return 0;
 	}
 
-	tmp = seg << 8 | bus;
-
 	/* search P2P bridges under this host bridge */
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
-				     find_p2p_bridge, &tmp, NULL);
+				     find_p2p_bridge, pci_bus, NULL);
 
 	if (ACPI_FAILURE(status))
 		warn("find_p2p_bridge faied (error code = 0x%x)\n",status);
@@ -672,10 +673,68 @@ static int add_bridge(acpi_handle handle
 	return 0;
 }
 
+static struct acpiphp_bridge *acpiphp_handle_to_bridge(acpi_handle handle)
+{
+	struct list_head *head;
+	list_for_each(head, &bridge_list) {
+		struct acpiphp_bridge *bridge = list_entry(head,
+						struct acpiphp_bridge, list);
+		if (bridge->handle == handle)
+			return bridge;
+	}
+
+	return NULL;
+}
 
 static void remove_bridge(acpi_handle handle)
 {
-	/* No-op for now .. */
+	struct list_head *list, *tmp;
+	struct acpiphp_bridge *bridge;
+	struct acpiphp_slot *slot;
+	acpi_status status;
+
+	bridge = acpiphp_handle_to_bridge(handle);
+	if (!bridge) {
+		err("Could not find bridge for handle %p\n", handle);
+		return;
+	}
+
+	status = acpi_remove_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
+					    handle_hotplug_event_bridge);
+	if (ACPI_FAILURE(status))
+		err("failed to remove notify handler\n");
+
+	slot = bridge->slots;
+	while (slot) {
+		struct acpiphp_slot *next = slot->next;
+		list_for_each_safe (list, tmp, &slot->funcs) {
+			struct acpiphp_func *func;
+			func = list_entry(list, struct acpiphp_func, sibling);
+			acpiphp_free_resource(&func->io_head);
+			acpiphp_free_resource(&func->mem_head);
+			acpiphp_free_resource(&func->p_mem_head);
+			acpiphp_free_resource(&func->bus_head);
+			status = acpi_remove_notify_handler(func->handle,
+						ACPI_SYSTEM_NOTIFY,
+						handle_hotplug_event_func);
+			if (ACPI_FAILURE(status))
+				err("failed to remove notify handler\n");
+			pci_dev_put(func->pci_dev);
+			list_del(list);
+			kfree(func);
+		}
+		kfree(slot);
+		slot = next;
+	}
+
+	acpiphp_free_resource(&bridge->io_head);
+	acpiphp_free_resource(&bridge->mem_head);
+	acpiphp_free_resource(&bridge->p_mem_head);
+	acpiphp_free_resource(&bridge->bus_head);
+
+	pci_dev_put(bridge->pci_dev);
+	list_del(&bridge->list);
+	kfree(bridge);
 }
 
 
@@ -782,9 +841,9 @@ static int power_off_slot(struct acpiphp
  */
 static int enable_device(struct acpiphp_slot *slot)
 {
-	u8 bus;
 	struct pci_dev *dev;
 	struct pci_bus *child;
+	struct pci_bus *bus = slot->bridge->pci_bus;
 	struct list_head *l;
 	struct acpiphp_func *func;
 	int retval = 0;
@@ -794,10 +853,11 @@ static int enable_device(struct acpiphp_
 		goto err_exit;
 
 	/* sanity check: dev should be NULL when hot-plugged in */
-	dev = pci_find_slot(slot->bridge->bus, PCI_DEVFN(slot->device, 0));
+	dev = pci_get_slot(bus, PCI_DEVFN(slot->device, 0));
 	if (dev) {
 		/* This case shouldn't happen */
 		err("pci_dev structure already exists.\n");
+		pci_dev_put(dev);
 		retval = -1;
 		goto err_exit;
 	}
@@ -807,21 +867,28 @@ static int enable_device(struct acpiphp_
 	if (retval)
 		goto err_exit;
 
-	/* returned `dev' is the *first function* only! */
-	num = pci_scan_slot(slot->bridge->pci_bus, PCI_DEVFN(slot->device, 0));
-	if (num)
-		pci_bus_add_devices(slot->bridge->pci_bus);
-	dev = pci_find_slot(slot->bridge->bus, PCI_DEVFN(slot->device, 0));
-
-	if (!dev) {
+	num = pci_scan_slot(bus, PCI_DEVFN(slot->device, 0));
+	if (num == 0) {
 		err("No new device found\n");
 		retval = -1;
 		goto err_exit;
 	}
 
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		/* Skip the devices we didn't just add */
+		if (!list_empty(&dev->global_list))
+			continue;
+		pcibios_fixup_device_resources(dev, bus);
+	}
+
+	pci_bus_add_devices(bus);
+	/* returned `dev' is the *first function* only! */
+	dev = pci_get_slot(bus, PCI_DEVFN(slot->device, 0));
+
 	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		pci_read_config_byte(dev, PCI_SECONDARY_BUS, &bus);
-		child = (struct pci_bus*) pci_add_new_bus(dev->bus, dev, bus);
+		u8 bus_nr;
+		pci_read_config_byte(dev, PCI_SECONDARY_BUS, &bus_nr);
+		child = pci_add_new_bus(dev->bus, dev, bus_nr);
 		pci_do_scan_bus(child);
 	}
 
@@ -829,16 +896,17 @@ static int enable_device(struct acpiphp_
 	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
 
-		func->pci_dev = pci_find_slot(slot->bridge->bus,
-					      PCI_DEVFN(slot->device,
+		func->pci_dev = pci_get_slot(bus, PCI_DEVFN(slot->device,
 							func->function));
 		if (!func->pci_dev)
 			continue;
 
 		/* configure device */
 		retval = acpiphp_configure_function(func);
-		if (retval)
+		if (retval) {
+			pci_dev_put(func->pci_dev);
 			goto err_exit;
+		}
 	}
 
 	slot->flags |= SLOT_ENABLED;
@@ -866,9 +934,12 @@ static int disable_device(struct acpiphp
 
 	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);
+		if (!func->pci_dev)
+			continue;
 
-		if (func->pci_dev)
-			acpiphp_unconfigure_function(func);
+		acpiphp_unconfigure_function(func);
+		pci_dev_put(func->pci_dev);
+		func->pci_dev = NULL;
 	}
 
 	slot->flags &= (~SLOT_ENABLED);
@@ -1116,46 +1187,6 @@ int __init acpiphp_glue_init(void)
  */
 void __exit acpiphp_glue_exit(void)
 {
-	struct list_head *l1, *l2, *n1, *n2;
-	struct acpiphp_bridge *bridge;
-	struct acpiphp_slot *slot, *next;
-	struct acpiphp_func *func;
-	acpi_status status;
-
-	list_for_each_safe (l1, n1, &bridge_list) {
-		bridge = (struct acpiphp_bridge *)l1;
-		slot = bridge->slots;
-		while (slot) {
-			next = slot->next;
-			list_for_each_safe (l2, n2, &slot->funcs) {
-				func = list_entry(l2, struct acpiphp_func, sibling);
-				acpiphp_free_resource(&func->io_head);
-				acpiphp_free_resource(&func->mem_head);
-				acpiphp_free_resource(&func->p_mem_head);
-				acpiphp_free_resource(&func->bus_head);
-				status = acpi_remove_notify_handler(func->handle,
-								    ACPI_SYSTEM_NOTIFY,
-								    handle_hotplug_event_func);
-				if (ACPI_FAILURE(status))
-					err("failed to remove notify handler\n");
-				kfree(func);
-			}
-			kfree(slot);
-			slot = next;
-		}
-		status = acpi_remove_notify_handler(bridge->handle, ACPI_SYSTEM_NOTIFY,
-						    handle_hotplug_event_bridge);
-		if (ACPI_FAILURE(status))
-			err("failed to remove notify handler\n");
-
-		acpiphp_free_resource(&bridge->io_head);
-		acpiphp_free_resource(&bridge->mem_head);
-		acpiphp_free_resource(&bridge->p_mem_head);
-		acpiphp_free_resource(&bridge->bus_head);
-
-		kfree(bridge);
-	}
-
 	acpi_pci_unregister_driver(&acpi_pci_hp_driver);
 }
 
@@ -1173,11 +1204,14 @@ int __init acpiphp_get_num_slots(void)
 
 	list_for_each (node, &bridge_list) {
 		bridge = (struct acpiphp_bridge *)node;
-		dbg("Bus%d %dslot(s)\n", bridge->bus, bridge->nr_slots);
+		dbg("Bus %04x:%02x has %d slot%s\n",
+				pci_domain_nr(bridge->pci_bus),
+				bridge->pci_bus->number, bridge->nr_slots,
+				bridge->nr_slots == 1 ? "" : "s");
 		num_slots += bridge->nr_slots;
 	}
 
-	dbg("Total %dslots\n", num_slots);
+	dbg("Total %d slots\n", num_slots);
 	return num_slots;
 }
 
@@ -1349,9 +1383,10 @@ u8 acpiphp_get_adapter_status(struct acp
 u32 acpiphp_get_address(struct acpiphp_slot *slot)
 {
 	u32 address;
+	struct pci_bus *pci_bus = slot->bridge->pci_bus;
 
-	address = ((slot->bridge->seg) << 16) |
-		  ((slot->bridge->bus) << 8) |
+	address = (pci_domain_nr(pci_bus) << 16) |
+		  (pci_bus->number << 8) |
 		  slot->device;
 
 	return address;

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
