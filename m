Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318961AbSIIWW6>; Mon, 9 Sep 2002 18:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318958AbSIIWW1>; Mon, 9 Sep 2002 18:22:27 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:17931 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318946AbSIIWUP>;
	Mon, 9 Sep 2002 18:20:15 -0400
Date: Mon, 9 Sep 2002 15:22:01 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI hotplug changes for 2.5.34
Message-ID: <20020909222201.GN7433@kroah.com>
References: <20020909221627.GE7433@kroah.com> <20020909221955.GG7433@kroah.com> <20020909222016.GH7433@kroah.com> <20020909222037.GI7433@kroah.com> <20020909222057.GJ7433@kroah.com> <20020909222112.GK7433@kroah.com> <20020909222128.GL7433@kroah.com> <20020909222142.GM7433@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020909222142.GM7433@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.631   -> 1.632  
#	drivers/hotplug/cpqphp_core.c	1.7     -> 1.8    
#	drivers/hotplug/cpqphp.h	1.2     -> 1.3    
#	drivers/hotplug/cpqphp_ctrl.c	1.3     -> 1.4    
#	drivers/hotplug/cpqphp_nvram.c	1.3     -> 1.4    
#	drivers/hotplug/cpqphp_pci.c	1.6     -> 1.7    
#	drivers/hotplug/cpqphp_proc.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/09	greg@kroah.com	1.632
# Compaq PCI Hotplug driver: changed calls to pci_*_nodev() to pci_bus_*()
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/cpqphp.h b/drivers/hotplug/cpqphp.h
--- a/drivers/hotplug/cpqphp.h	Mon Sep  9 15:09:29 2002
+++ b/drivers/hotplug/cpqphp.h	Mon Sep  9 15:09:29 2002
@@ -292,16 +292,14 @@
 	struct pci_resource *io_head;
 	struct pci_resource *bus_head;
 	struct pci_dev *pci_dev;
-	struct pci_ops *pci_ops;
+	struct pci_bus *pci_bus;
 	struct proc_dir_entry* proc_entry;
 	struct proc_dir_entry* proc_entry2;
 	struct event_info event_queue[10];
 	struct slot *slot;
 	u8 next_event;
 	u8 interrupt;
-	u8 bus;
-	u8 device;
-	u8 function;
+	u8 bus;				/* bus number for the pci hotplug controller */
 	u8 rev;
 	u8 slot_device_offset;
 	u8 first_slot;
diff -Nru a/drivers/hotplug/cpqphp_core.c b/drivers/hotplug/cpqphp_core.c
--- a/drivers/hotplug/cpqphp_core.c	Mon Sep  9 15:09:29 2002
+++ b/drivers/hotplug/cpqphp_core.c	Mon Sep  9 15:09:29 2002
@@ -467,7 +467,7 @@
 //
 // Output:	SUCCESS or FAILURE
 //=============================================================================
-static int get_slot_mapping (struct pci_ops *ops, u8 bus_num, u8 dev_num, u8 *slot)
+static int get_slot_mapping (struct pci_bus *bus, u8 bus_num, u8 dev_num, u8 *slot)
 {
 	struct irq_routing_table *PCIIRQRoutingInfoLength;
 	u32 work;
@@ -476,7 +476,7 @@
 
 	u8 tbus, tdevice, tslot, bridgeSlot;
 
-	dbg("%s: %p, %d, %d, %p\n", __FUNCTION__, ops, bus_num, dev_num, slot);
+	dbg("%s: %p, %d, %d, %p\n", __FUNCTION__, bus, bus_num, dev_num, slot);
 
 	bridgeSlot = 0xFF;
 
@@ -490,7 +490,6 @@
 		return -1;
 	}
 
-
 	for (loop = 0; loop < len; ++loop) {
 		tbus = PCIIRQRoutingInfoLength->slots[loop].bus;
 		tdevice = PCIIRQRoutingInfoLength->slots[loop].devfn >> 3;
@@ -499,7 +498,8 @@
 		if ((tbus == bus_num) && (tdevice == dev_num)) {
 			*slot = tslot;
 
-			if (PCIIRQRoutingInfoLength != NULL) kfree(PCIIRQRoutingInfoLength );
+			if (PCIIRQRoutingInfoLength != NULL)
+				kfree(PCIIRQRoutingInfoLength);
 			return 0;
 		} else {
 			// Didn't get a match on the target PCI device. Check if the
@@ -508,10 +508,11 @@
 			// device, I need to save the bridge's slot number.  If I can't 
 			// find an entry for the target device, I will have to assume it's 
 			// on the other side of the bridge, and assign it the bridge's slot.
-			pci_read_config_dword_nodev (ops, tbus, tdevice, 0, PCI_REVISION_ID, &work);
+			bus->number = tbus;
+			pci_bus_read_config_dword (bus, PCI_DEVFN(tdevice, 0), PCI_REVISION_ID, &work);
 
 			if ((work >> 8) == PCI_TO_PCI_BRIDGE_CLASS) {
-				pci_read_config_dword_nodev (ops, tbus, tdevice, 0, PCI_PRIMARY_BUS, &work);
+				pci_bus_read_config_dword (bus, PCI_DEVFN(tdevice, 0), PCI_PRIMARY_BUS, &work);
 				// See if bridge's secondary bus matches target bus.
 				if (((work >> 8) & 0x000000FF) == (long) bus_num) {
 					bridgeSlot = tslot;
@@ -521,7 +522,6 @@
 
 	}
 
-
 	// If we got here, we didn't find an entry in the IRQ mapping table 
 	// for the target PCI device.  If we did determine that the target 
 	// device is on the other side of a PCI-to-PCI bridge, return the 
@@ -991,12 +991,20 @@
 	dbg ("    pcix_support           %s\n", ctrl->pcix_support == 0 ? "not supported" : "supported");
 
 	ctrl->pci_dev = pdev;
-	ctrl->pci_ops = pdev->bus->ops;
+
+	/* make our own copy of the pci bus structure, as we like tweaking it a lot */
+	ctrl->pci_bus = kmalloc (sizeof (*ctrl->pci_bus), GFP_KERNEL);
+	if (!ctrl->pci_bus) {
+		err("out of memory\n");
+		rc = -ENOMEM;
+		goto err_free_ctrl;
+	}
+	memcpy (ctrl->pci_bus, pdev->bus, sizeof (*ctrl->pci_bus));
+
 	ctrl->bus = pdev->bus->number;
-	ctrl->device = PCI_SLOT(pdev->devfn);
-	ctrl->function = PCI_FUNC(pdev->devfn);
 	ctrl->rev = rev;
-	dbg("bus device function rev: %d %d %d %d\n", ctrl->bus, ctrl->device, ctrl->function, ctrl->rev);
+	dbg("bus device function rev: %d %d %d %d\n", ctrl->bus,
+	     PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn), ctrl->rev);
 
 	init_MUTEX(&ctrl->crit_sect);
 	init_waitqueue_head(&ctrl->queue);
@@ -1004,7 +1012,7 @@
 	/* initialize our threads if they haven't already been started up */
 	rc = one_time_init();
 	if (rc) {
-		goto err_free_ctrl;
+		goto err_free_bus;
 	}
 	
 	dbg("pdev = %p\n", pdev);
@@ -1015,7 +1023,7 @@
 				pci_resource_len(pdev, 0), MY_NAME)) {
 		err("cannot reserve MMIO region\n");
 		rc = -ENOMEM;
-		goto err_free_ctrl;
+		goto err_free_bus;
 	}
 
 	ctrl->hpc_reg = ioremap(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
@@ -1043,7 +1051,7 @@
 	// in this case it will always be called for the "base"
 	// bus/dev/func of a slot.
 	// CS: this is leveraging the PCIIRQ routing code from the kernel (pci-pc.c: get_irq_routing_table)
-	rc = get_slot_mapping(ctrl->pci_ops, pdev->bus->number, (readb(ctrl->hpc_reg + SLOT_MASK) >> 4), &(ctrl->first_slot));
+	rc = get_slot_mapping(ctrl->pci_bus, pdev->bus->number, (readb(ctrl->hpc_reg + SLOT_MASK) >> 4), &(ctrl->first_slot));
 	dbg("get_slot_mapping: first_slot = %d, returned = %d\n", ctrl->first_slot, rc);
 	if (rc) {
 		err(msg_initialization_err, rc);
@@ -1188,6 +1196,8 @@
 	iounmap(ctrl->hpc_reg);
 err_free_mem_region:
 	release_mem_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
+err_free_bus:
+	kfree(ctrl->pci_bus);
 err_free_ctrl:
 	kfree(ctrl);
 	return rc;
@@ -1327,6 +1337,8 @@
 			res = res->next;
 			kfree(tres);
 		}
+
+		kfree (ctrl->pci_bus);
 
 		tctrl = ctrl;
 		ctrl = ctrl->next;
diff -Nru a/drivers/hotplug/cpqphp_ctrl.c b/drivers/hotplug/cpqphp_ctrl.c
--- a/drivers/hotplug/cpqphp_ctrl.c	Mon Sep  9 15:09:29 2002
+++ b/drivers/hotplug/cpqphp_ctrl.c	Mon Sep  9 15:09:29 2002
@@ -1471,7 +1471,8 @@
 		func->status = 0;
 	} else {
 		// Get vendor/device ID u32
-		rc = pci_read_config_dword_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_VENDOR_ID, &temp_register);
+		ctrl->pci_bus->number = func->bus;
+		rc = pci_bus_read_config_dword (ctrl->pci_bus, PCI_DEVFN(func->device, func->function), PCI_VENDOR_ID, &temp_register);
 		dbg("%s: pci_read_config_dword returns %d\n", __FUNCTION__, rc);
 		dbg("%s: temp_register is %x\n", __FUNCTION__, temp_register);
 
@@ -2082,7 +2083,9 @@
 	u8 index = 0;
 	u8 replace_flag;
 	u32 rc = 0;
+	unsigned int devfn;
 	struct slot* p_slot;
+	struct pci_bus *pci_bus = ctrl->pci_bus;
 	int physical_slot=0;
 
 	device = func->device; 
@@ -2094,8 +2097,11 @@
 
 	// Make sure there are no video controllers here
 	while (func && !rc) {
+		pci_bus->number = func->bus;
+		devfn = PCI_DEVFN(func->device, func->function);
+
 		// Check the Class Code
-		rc = pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, 0x0B, &class_code);
+		rc = pci_bus_read_config_byte (pci_bus, devfn, 0x0B, &class_code);
 		if (rc)
 			return rc;
 
@@ -2104,13 +2110,13 @@
 			rc = REMOVE_NOT_SUPPORTED;
 		} else {
 			// See if it's a bridge
-			rc = pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_HEADER_TYPE, &header_type);
+			rc = pci_bus_read_config_byte (pci_bus, devfn, PCI_HEADER_TYPE, &header_type);
 			if (rc)
 				return rc;
 
 			// If it's a bridge, check the VGA Enable bit
 			if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {
-				rc = pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_BRIDGE_CONTROL, &BCR);
+				rc = pci_bus_read_config_byte (pci_bus, devfn, PCI_BRIDGE_CONTROL, &BCR);
 				if (rc)
 					return rc;
 
@@ -2334,7 +2340,8 @@
 
 	dbg("%s\n", __FUNCTION__);
 	// Check for Multi-function device
-	rc = pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, 0x0E, &temp_byte);
+	ctrl->pci_bus->number = func->bus;
+	rc = pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(func->device, func->function), 0x0E, &temp_byte);
 	if (rc) {
 		dbg("%s: rc = %d\n", __FUNCTION__, rc);
 		return rc;
@@ -2372,7 +2379,7 @@
 		//  and creates a board structure
 
 		while ((function < max_functions) && (!stop_it)) {
-			pci_read_config_dword_nodev (ctrl->pci_ops, func->bus, func->device, function, 0x00, &ID);
+			pci_bus_read_config_dword (ctrl->pci_bus, PCI_DEVFN(func->device, function), 0x00, &ID);
 
 			if (ID == 0xFFFFFFFF) {	  // There's nothing there. 
 				function++;
@@ -2435,6 +2442,7 @@
 	u32 temp_register;
 	u32 base;
 	u32 ID;
+	unsigned int devfn;
 	struct pci_resource *mem_node;
 	struct pci_resource *p_mem_node;
 	struct pci_resource *io_node;
@@ -2445,17 +2453,22 @@
 	struct pci_resource *hold_bus_node;
 	struct irq_mapping irqs;
 	struct pci_func *new_slot;
+	struct pci_bus *pci_bus;
 	struct resource_lists temp_resources;
 
+	pci_bus = ctrl->pci_bus;
+	pci_bus->number = func->bus;
+	devfn = PCI_DEVFN(func->device, func->function);
+
 	// Check for Bridge
-	rc = pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_HEADER_TYPE, &temp_byte);
+	rc = pci_bus_read_config_byte (pci_bus, devfn, PCI_HEADER_TYPE, &temp_byte);
 	if (rc)
 		return rc;
 
 	if ((temp_byte & 0x7F) == PCI_HEADER_TYPE_BRIDGE) { // PCI-PCI Bridge
 		// set Primary bus
 		dbg("set Primary bus = %d\n", func->bus);
-		rc = pci_write_config_byte_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_PRIMARY_BUS, func->bus);
+		rc = pci_bus_write_config_byte (pci_bus, devfn, PCI_PRIMARY_BUS, func->bus);
 		if (rc)
 			return rc;
 
@@ -2470,29 +2483,29 @@
 		// set Secondary bus
 		temp_byte = bus_node->base;
 		dbg("set Secondary bus = %d\n", bus_node->base);
-		rc = pci_write_config_byte_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_SECONDARY_BUS, temp_byte);
+		rc = pci_bus_write_config_byte (pci_bus, devfn, PCI_SECONDARY_BUS, temp_byte);
 		if (rc)
 			return rc;
 
 		// set subordinate bus
 		temp_byte = bus_node->base + bus_node->length - 1;
 		dbg("set subordinate bus = %d\n", bus_node->base + bus_node->length - 1);
-		rc = pci_write_config_byte_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_SUBORDINATE_BUS, temp_byte);
+		rc = pci_bus_write_config_byte (pci_bus, devfn, PCI_SUBORDINATE_BUS, temp_byte);
 		if (rc)
 			return rc;
 
 		// set subordinate Latency Timer and base Latency Timer
 		temp_byte = 0x40;
-		rc = pci_write_config_byte_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_SEC_LATENCY_TIMER, temp_byte);
+		rc = pci_bus_write_config_byte (pci_bus, devfn, PCI_SEC_LATENCY_TIMER, temp_byte);
 		if (rc)
 			return rc;
-		rc = pci_write_config_byte_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_LATENCY_TIMER, temp_byte);
+		rc = pci_bus_write_config_byte (pci_bus, devfn, PCI_LATENCY_TIMER, temp_byte);
 		if (rc)
 			return rc;
 
 		// set Cache Line size
 		temp_byte = 0x08;
-		rc = pci_write_config_byte_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_CACHE_LINE_SIZE, temp_byte);
+		rc = pci_bus_write_config_byte (pci_bus, devfn, PCI_CACHE_LINE_SIZE, temp_byte);
 		if (rc)
 			return rc;
 
@@ -2568,10 +2581,10 @@
 
 			// set IO base and Limit registers
 			temp_byte = io_node->base >> 8;
-			rc = pci_write_config_byte_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_IO_BASE, temp_byte);
+			rc = pci_bus_write_config_byte (pci_bus, devfn, PCI_IO_BASE, temp_byte);
 
 			temp_byte = (io_node->base + io_node->length - 1) >> 8;
-			rc = pci_write_config_byte_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_IO_LIMIT, temp_byte);
+			rc = pci_bus_write_config_byte (pci_bus, devfn, PCI_IO_LIMIT, temp_byte);
 		} else {
 			kfree(hold_IO_node);
 			hold_IO_node = NULL;
@@ -2586,16 +2599,16 @@
 
 			// set Mem base and Limit registers
 			temp_word = mem_node->base >> 16;
-			rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_MEMORY_BASE, temp_word);
+			rc = pci_bus_write_config_word (pci_bus, devfn, PCI_MEMORY_BASE, temp_word);
 
 			temp_word = (mem_node->base + mem_node->length - 1) >> 16;
-			rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_MEMORY_LIMIT, temp_word);
+			rc = pci_bus_write_config_word (pci_bus, devfn, PCI_MEMORY_LIMIT, temp_word);
 		} else {
 			temp_word = 0xFFFF;
-			rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_MEMORY_BASE, temp_word);
+			rc = pci_bus_write_config_word (pci_bus, devfn, PCI_MEMORY_BASE, temp_word);
 
 			temp_word = 0x0000;
-			rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_MEMORY_LIMIT, temp_word);
+			rc = pci_bus_write_config_word (pci_bus, devfn, PCI_MEMORY_LIMIT, temp_word);
 
 			kfree(hold_mem_node);
 			hold_mem_node = NULL;
@@ -2610,16 +2623,16 @@
 
 			// set Pre Mem base and Limit registers
 			temp_word = p_mem_node->base >> 16;
-			rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_PREF_MEMORY_BASE, temp_word);
+			rc = pci_bus_write_config_word (pci_bus, devfn, PCI_PREF_MEMORY_BASE, temp_word);
 
 			temp_word = (p_mem_node->base + p_mem_node->length - 1) >> 16;
-			rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_PREF_MEMORY_LIMIT, temp_word);
+			rc = pci_bus_write_config_word (pci_bus, devfn, PCI_PREF_MEMORY_LIMIT, temp_word);
 		} else {
 			temp_word = 0xFFFF;
-			rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_PREF_MEMORY_BASE, temp_word);
+			rc = pci_bus_write_config_word (pci_bus, devfn, PCI_PREF_MEMORY_BASE, temp_word);
 
 			temp_word = 0x0000;
-			rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_PREF_MEMORY_LIMIT, temp_word);
+			rc = pci_bus_write_config_word (pci_bus, devfn, PCI_PREF_MEMORY_LIMIT, temp_word);
 
 			kfree(hold_p_mem_node);
 			hold_p_mem_node = NULL;
@@ -2635,7 +2648,9 @@
 			irqs.barber_pole = (irqs.barber_pole + 1) & 0x03;
 
 			ID = 0xFFFFFFFF;
-			pci_read_config_dword_nodev (ctrl->pci_ops, hold_bus_node->base, device, 0, 0x00, &ID);
+			pci_bus->number = hold_bus_node->base;
+			pci_bus_read_config_dword (pci_bus, PCI_DEVFN(device, 0), 0x00, &ID);
+			pci_bus->number = func->bus;
 
 			if (ID != 0xFFFFFFFF) {	  //  device Present
 				// Setup slot structure.
@@ -2703,7 +2718,7 @@
 			temp_byte = temp_resources.bus_head->base - 1;
 
 			// set subordinate bus
-			rc = pci_write_config_byte_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_SUBORDINATE_BUS, temp_byte);
+			rc = pci_bus_write_config_byte (pci_bus, devfn, PCI_SUBORDINATE_BUS, temp_byte);
 
 			if (temp_resources.bus_head->length == 0) {
 				kfree(temp_resources.bus_head);
@@ -2724,7 +2739,7 @@
 				hold_IO_node->base = io_node->base + io_node->length;
 
 				temp_byte = (hold_IO_node->base) >> 8;
-				rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_IO_BASE, temp_byte);
+				rc = pci_bus_write_config_word (pci_bus, devfn, PCI_IO_BASE, temp_byte);
 
 				return_resource(&(resources->io_head), io_node);
 			}
@@ -2742,13 +2757,13 @@
 					func->io_head = hold_IO_node;
 
 					temp_byte = (io_node->base - 1) >> 8;
-					rc = pci_write_config_byte_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_IO_LIMIT, temp_byte);
+					rc = pci_bus_write_config_byte (pci_bus, devfn, PCI_IO_LIMIT, temp_byte);
 
 					return_resource(&(resources->io_head), io_node);
 				} else {
 					// it doesn't need any IO
 					temp_word = 0x0000;
-					pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_IO_LIMIT, temp_word);
+					rc = pci_bus_write_config_word (pci_bus, devfn, PCI_IO_LIMIT, temp_word);
 
 					return_resource(&(resources->io_head), io_node);
 					kfree(hold_IO_node);
@@ -2774,7 +2789,7 @@
 				hold_mem_node->base = mem_node->base + mem_node->length;
 
 				temp_word = (hold_mem_node->base) >> 16;
-				rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_MEMORY_BASE, temp_word);
+				rc = pci_bus_write_config_word (pci_bus, devfn, PCI_MEMORY_BASE, temp_word);
 
 				return_resource(&(resources->mem_head), mem_node);
 			}
@@ -2792,14 +2807,14 @@
 
 					// configure end address
 					temp_word = (mem_node->base - 1) >> 16;
-					rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_MEMORY_LIMIT, temp_word);
+					rc = pci_bus_write_config_word (pci_bus, devfn, PCI_MEMORY_LIMIT, temp_word);
 
 					// Return unused resources to the pool
 					return_resource(&(resources->mem_head), mem_node);
 				} else {
 					// it doesn't need any Mem
 					temp_word = 0x0000;
-					rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_MEMORY_LIMIT, temp_word);
+					rc = pci_bus_write_config_word (pci_bus, devfn, PCI_MEMORY_LIMIT, temp_word);
 
 					return_resource(&(resources->mem_head), mem_node);
 					kfree(hold_mem_node);
@@ -2825,7 +2840,7 @@
 				hold_p_mem_node->base = p_mem_node->base + p_mem_node->length;
 
 				temp_word = (hold_p_mem_node->base) >> 16;
-				rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_PREF_MEMORY_BASE, temp_word);
+				rc = pci_bus_write_config_word (pci_bus, devfn, PCI_PREF_MEMORY_BASE, temp_word);
 
 				return_resource(&(resources->p_mem_head), p_mem_node);
 			}
@@ -2843,13 +2858,13 @@
 					func->p_mem_head = hold_p_mem_node;
 
 					temp_word = (p_mem_node->base - 1) >> 16;
-					rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_PREF_MEMORY_LIMIT, temp_word);
+					rc = pci_bus_write_config_word (pci_bus, devfn, PCI_PREF_MEMORY_LIMIT, temp_word);
 
 					return_resource(&(resources->p_mem_head), p_mem_node);
 				} else {
 					// it doesn't need any PMem
 					temp_word = 0x0000;
-					rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_PREF_MEMORY_LIMIT, temp_word);
+					rc = pci_bus_write_config_word (pci_bus, devfn, PCI_PREF_MEMORY_LIMIT, temp_word);
 
 					return_resource(&(resources->p_mem_head), p_mem_node);
 					kfree(hold_p_mem_node);
@@ -2870,14 +2885,14 @@
 
 		// enable card
 		command = 0x0157;	// = PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |  PCI_COMMAND_INVALIDATE | PCI_COMMAND_PARITY | PCI_COMMAND_SERR
-		rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_COMMAND, command);
+		rc = pci_bus_write_config_word (pci_bus, devfn, PCI_COMMAND, command);
 
 		// set Bridge Control Register
 		command = 0x07;		// = PCI_BRIDGE_CTL_PARITY | PCI_BRIDGE_CTL_SERR | PCI_BRIDGE_CTL_NO_ISA
-		rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_BRIDGE_CONTROL, command);
+		rc = pci_bus_write_config_word (pci_bus, devfn, PCI_BRIDGE_CONTROL, command);
 	} else if ((temp_byte & 0x7F) == PCI_HEADER_TYPE_NORMAL) {
 		// Standard device
-		rc = pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, 0x0B, &class_code);
+		rc = pci_bus_read_config_byte (pci_bus, devfn, 0x0B, &class_code);
 
 		if (class_code == PCI_BASE_CLASS_DISPLAY) {
 			// Display (video) adapter (not supported)
@@ -2887,10 +2902,10 @@
 		for (cloop = 0x10; cloop <= 0x24; cloop += 4) {
 			temp_register = 0xFFFFFFFF;
 
-			dbg("CND: bus=%d, device=%d, func=%d, offset=%d\n", func->bus, func->device, func->function, cloop);
-			rc = pci_write_config_dword_nodev(ctrl->pci_ops, func->bus, func->device, func->function, cloop, temp_register);
+			dbg("CND: bus=%d, devfn=%d, offset=%d\n", pci_bus->number, devfn, cloop);
+			rc = pci_bus_write_config_dword (pci_bus, devfn, cloop, temp_register);
 
-			rc = pci_read_config_dword_nodev (ctrl->pci_ops, func->bus, func->device, func->function, cloop, &temp_register);
+			rc = pci_bus_read_config_dword (pci_bus, devfn, cloop, &temp_register);
 			dbg("CND: base = 0x%x\n", temp_register);
 
 			if (temp_register) {	  // If this register is implemented
@@ -2971,7 +2986,7 @@
 					return(NOT_ENOUGH_RESOURCES);
 				}
 
-				rc = pci_write_config_dword_nodev(ctrl->pci_ops, func->bus, func->device, func->function, cloop, base);
+				rc = pci_bus_write_config_dword (pci_bus, devfn, cloop, base);
 
 				// Check for 64-bit base
 				if ((temp_register & 0x07L) == 0x04) {
@@ -2980,13 +2995,13 @@
 					// Upper 32 bits of address always zero on today's systems
 					// FIXME this is probably not true on Alpha and ia64???
 					base = 0;
-					rc = pci_write_config_dword_nodev(ctrl->pci_ops, func->bus, func->device, func->function, cloop, base);
+					rc = pci_bus_write_config_dword (pci_bus, devfn, cloop, base);
 				}
 			}
 		}		// End of base register loop
 
 		// Figure out which interrupt pin this function uses
-		rc = pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_INTERRUPT_PIN, &temp_byte);
+		rc = pci_bus_read_config_byte (pci_bus, devfn, PCI_INTERRUPT_PIN, &temp_byte);
 
 		// If this function needs an interrupt and we are behind a bridge
 		// and the pin is tied to something that's alread mapped,
@@ -2998,7 +3013,7 @@
 			IRQ = resources->irqs->interrupt[(temp_byte + resources->irqs->barber_pole - 1) & 0x03];
 		} else {
 			// Program IRQ based on card type
-			rc = pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, 0x0B, &class_code);
+			rc = pci_bus_read_config_byte (pci_bus, devfn, 0x0B, &class_code);
 
 			if (class_code == PCI_BASE_CLASS_STORAGE) {
 				IRQ = cpqhp_disk_irq;
@@ -3008,7 +3023,7 @@
 		}
 
 		// IRQ Line
-		rc = pci_write_config_byte_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_INTERRUPT_LINE, IRQ);
+		rc = pci_bus_write_config_byte (pci_bus, devfn, PCI_INTERRUPT_LINE, IRQ);
 
 		if (!behind_bridge) {
 			rc = cpqhp_set_irq(func->bus, func->device, temp_byte + 0x09, IRQ);
@@ -3022,19 +3037,19 @@
 
 		// Latency Timer
 		temp_byte = 0x40;
-		rc = pci_write_config_byte_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_LATENCY_TIMER, temp_byte);
+		rc = pci_bus_write_config_byte (pci_bus, devfn, PCI_LATENCY_TIMER, temp_byte);
 
 		// Cache Line size
 		temp_byte = 0x08;
-		rc = pci_write_config_byte_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_CACHE_LINE_SIZE, temp_byte);
+		rc = pci_bus_write_config_byte (pci_bus, devfn, PCI_CACHE_LINE_SIZE, temp_byte);
 
 		// disable ROM base Address
 		temp_dword = 0x00L;
-		rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_ROM_ADDRESS, temp_dword);
+		rc = pci_bus_write_config_word (pci_bus, devfn, PCI_ROM_ADDRESS, temp_dword);
 
 		// enable card
 		temp_word = 0x0157;	// = PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |  PCI_COMMAND_INVALIDATE | PCI_COMMAND_PARITY | PCI_COMMAND_SERR
-		rc = pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_COMMAND, temp_word);
+		rc = pci_bus_write_config_word (pci_bus, devfn, PCI_COMMAND, temp_word);
 	}			// End of Not-A-Bridge else
 	else {
 		// It's some strange type of PCI adapter (Cardbus?)
diff -Nru a/drivers/hotplug/cpqphp_nvram.c b/drivers/hotplug/cpqphp_nvram.c
--- a/drivers/hotplug/cpqphp_nvram.c	Mon Sep  9 15:09:29 2002
+++ b/drivers/hotplug/cpqphp_nvram.c	Mon Sep  9 15:09:29 2002
@@ -286,12 +286,12 @@
 			return(rc);
 
 		// The device Number
-		rc = add_byte( &pFill, ctrl->device, &usedbytes, &available);
+		rc = add_byte( &pFill, PCI_SLOT(ctrl->pci_dev->devfn), &usedbytes, &available);
 		if (rc)
 			return(rc);
 
 		// The function Number
-		rc = add_byte( &pFill, ctrl->function, &usedbytes, &available);
+		rc = add_byte( &pFill, PCI_FUNC(ctrl->pci_dev->devfn), &usedbytes, &available);
 		if (rc)
 			return(rc);
 
@@ -479,8 +479,9 @@
 		device = p_ev_ctrl->device;
 		function = p_ev_ctrl->function;
 
-		while ((bus != ctrl->bus) || (device != ctrl->device)
-		       || (function != ctrl->function)) {
+		while ((bus != ctrl->bus) ||
+		       (device != PCI_SLOT(ctrl->pci_dev->devfn)) || 
+		       (function != PCI_FUNC(ctrl->pci_dev->devfn))) {
 			nummem = p_ev_ctrl->mem_avail;
 			numpmem = p_ev_ctrl->p_mem_avail;
 			numio = p_ev_ctrl->io_avail;
diff -Nru a/drivers/hotplug/cpqphp_pci.c b/drivers/hotplug/cpqphp_pci.c
--- a/drivers/hotplug/cpqphp_pci.c	Mon Sep  9 15:09:29 2002
+++ b/drivers/hotplug/cpqphp_pci.c	Mon Sep  9 15:09:29 2002
@@ -150,8 +150,9 @@
 	//Create /proc/bus/pci proc entry for this device and bus device is on
 	//Notify the drivers of the change
 	if (temp_func->pci_dev) {
-		pci_proc_attach_device(temp_func->pci_dev);
-		pci_announce_device_to_drivers(temp_func->pci_dev);
+//		pci_insert_device (temp_func->pci_dev, bus);
+//		pci_proc_attach_device(temp_func->pci_dev);
+//		pci_announce_device_to_drivers(temp_func->pci_dev);
 	}
 
 	return 0;
@@ -326,15 +327,15 @@
 	return rc;
 }
 
-static int PCI_RefinedAccessConfig(struct pci_ops *ops, u8 bus, u8 device, u8 function, u8 offset, u32 *value)
+static int PCI_RefinedAccessConfig(struct pci_bus *bus, unsigned int devfn, u8 offset, u32 *value)
 {
 	u32 vendID = 0;
 
-	if (pci_read_config_dword_nodev (ops, bus, device, function, PCI_VENDOR_ID, &vendID) == -1)
+	if (pci_bus_read_config_dword (bus, devfn, PCI_VENDOR_ID, &vendID) == -1)
 		return -1;
 	if (vendID == 0xffffffff)
 		return -1;
-	return pci_read_config_dword_nodev (ops, bus, device, function, offset, value);
+	return pci_bus_read_config_dword (bus, devfn, offset, value);
 }
 
 
@@ -392,9 +393,11 @@
 	u32 work;
 	u8 tbus;
 
+	ctrl->pci_bus->number = bus_num;
+
 	for (tdevice = 0; tdevice < 0x100; tdevice++) {
 		//Scan for access first
-		if (PCI_RefinedAccessConfig(ctrl->pci_ops, bus_num, tdevice >> 3, tdevice & 0x7, 0x08, &work) == -1)
+		if (PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work) == -1)
 			continue;
 		dbg("Looking for nonbridge bus_num %d dev_num %d\n", bus_num, tdevice);
 		//Yep we got one. Not a bridge ?
@@ -406,12 +409,12 @@
 	}
 	for (tdevice = 0; tdevice < 0x100; tdevice++) {
 		//Scan for access first
-		if (PCI_RefinedAccessConfig(ctrl->pci_ops, bus_num, tdevice >> 3, tdevice & 0x7, 0x08, &work) == -1)
+		if (PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work) == -1)
 			continue;
 		dbg("Looking for bridge bus_num %d dev_num %d\n", bus_num, tdevice);
 		//Yep we got one. bridge ?
 		if ((work >> 8) == PCI_TO_PCI_BRIDGE_CLASS) {
-			pci_read_config_byte_nodev (ctrl->pci_ops, tbus, tdevice, 0, PCI_SECONDARY_BUS, &tbus);
+			pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(tdevice, 0), PCI_SECONDARY_BUS, &tbus);
 			dbg("Recurse on bus_num %d tdevice %d\n", tbus, tdevice);
 			if (PCI_ScanBusNonBridge(tbus, tdevice) == 0)
 				return 0;
@@ -450,19 +453,20 @@
 		if (tslot == slot) {
 			*bus_num = tbus;
 			*dev_num = tdevice;
-			pci_read_config_dword_nodev (ctrl->pci_ops, *bus_num, *dev_num >> 3, *dev_num & 0x7, PCI_VENDOR_ID, &work);
+			ctrl->pci_bus->number = tbus;
+			pci_bus_read_config_dword (ctrl->pci_bus, *dev_num, PCI_VENDOR_ID, &work);
 			if (!nobridge || (work == 0xffffffff)) {
 				if (PCIIRQRoutingInfoLength != NULL)
 					kfree(PCIIRQRoutingInfoLength );
 				return 0;
 			}
 
-			dbg("bus_num %d dev_num %d func_num %d\n", *bus_num, *dev_num >> 3, *dev_num & 0x7);
-			pci_read_config_dword_nodev (ctrl->pci_ops, *bus_num, *dev_num >> 3, *dev_num & 0x7, PCI_CLASS_REVISION, &work);
+			dbg("bus_num %d devfn %d\n", *bus_num, *dev_num);
+			pci_bus_read_config_dword (ctrl->pci_bus, *dev_num, PCI_CLASS_REVISION, &work);
 			dbg("work >> 8 (%x) = BRIDGE (%x)\n", work >> 8, PCI_TO_PCI_BRIDGE_CLASS);
 
 			if ((work >> 8) == PCI_TO_PCI_BRIDGE_CLASS) {
-				pci_read_config_byte_nodev (ctrl->pci_ops, *bus_num, *dev_num >> 3, *dev_num & 0x7, PCI_SECONDARY_BUS, &tbus);
+				pci_bus_read_config_byte (ctrl->pci_bus, *dev_num, PCI_SECONDARY_BUS, &tbus);
 				dbg("Scan bus for Non Bridge: bus %d\n", tbus);
 				if (PCI_ScanBusForNonBridge(ctrl, tbus, dev_num) == 0) {
 					*bus_num = tbus;
@@ -535,17 +539,17 @@
 	}
 
 	//     Save PCI configuration space for all devices in supported slots
-
+	ctrl->pci_bus->number = busnumber;
 	for (device = FirstSupported; device <= LastSupported; device++) {
 		ID = 0xFFFFFFFF;
-		rc = pci_read_config_dword_nodev (ctrl->pci_ops, busnumber, device, 0, PCI_VENDOR_ID, &ID);
+		rc = pci_bus_read_config_dword (ctrl->pci_bus, PCI_DEVFN(device, 0), PCI_VENDOR_ID, &ID);
 
 		if (ID != 0xFFFFFFFF) {	  //  device in slot
-			rc = pci_read_config_byte_nodev (ctrl->pci_ops, busnumber, device, 0, 0x0B, &class_code);
+			rc = pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(device, 0), 0x0B, &class_code);
 			if (rc)
 				return rc;
 
-			rc = pci_read_config_byte_nodev (ctrl->pci_ops, busnumber, device, 0, PCI_HEADER_TYPE, &header_type);
+			rc = pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(device, 0), PCI_HEADER_TYPE, &header_type);
 			if (rc)
 				return rc;
 
@@ -563,7 +567,7 @@
 				if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {   // P-P Bridge
 					//  Recurse the subordinate bus
 					//  get the subordinate bus number
-					rc = pci_read_config_byte_nodev (ctrl->pci_ops, busnumber, device, function, PCI_SECONDARY_BUS, &secondary_bus);
+					rc = pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(device, function), PCI_SECONDARY_BUS, &secondary_bus);
 					if (rc) {
 						return rc;
 					} else {
@@ -572,9 +576,9 @@
 						// Save secondary bus cfg spc
 						// with this recursive call.
 						rc = cpqhp_save_config(ctrl, sub_bus, 0);
-
 						if (rc)
 							return rc;
+						ctrl->pci_bus->number = busnumber;
 					}
 				}
 
@@ -602,7 +606,7 @@
 				new_slot->pci_dev = pci_find_slot(new_slot->bus, (new_slot->device << 3) | new_slot->function);
 
 				for (cloop = 0; cloop < 0x20; cloop++) {
-					rc = pci_read_config_dword_nodev (ctrl->pci_ops, busnumber, device, function, cloop << 2, (u32 *) & (new_slot-> config_space [cloop]));
+					rc = pci_bus_read_config_dword (ctrl->pci_bus, PCI_DEVFN(device, function), cloop << 2, (u32 *) & (new_slot-> config_space [cloop]));
 					if (rc)
 						return rc;
 				}
@@ -615,15 +619,15 @@
 				//  reading in Class Code and Header type.
 
 				while ((function < max_functions)&&(!stop_it)) {
-					rc = pci_read_config_dword_nodev (ctrl->pci_ops, busnumber, device, function, PCI_VENDOR_ID, &ID);
+					rc = pci_bus_read_config_dword (ctrl->pci_bus, PCI_DEVFN(device, function), PCI_VENDOR_ID, &ID);
 					if (ID == 0xFFFFFFFF) {	 // nothing there.
 						function++;
 					} else {  // Something there
-						rc = pci_read_config_byte_nodev (ctrl->pci_ops, busnumber, device, function, 0x0B, &class_code);
+						rc = pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(device, function), 0x0B, &class_code);
 						if (rc)
 							return rc;
 
-						rc = pci_read_config_byte_nodev (ctrl->pci_ops, busnumber, device, function, PCI_HEADER_TYPE, &header_type);
+						rc = pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(device, function), PCI_HEADER_TYPE, &header_type);
 						if (rc)
 							return rc;
 
@@ -677,12 +681,12 @@
 
 	ID = 0xFFFFFFFF;
 
-	pci_read_config_dword_nodev (ctrl->pci_ops, new_slot->bus, new_slot->device, 0, PCI_VENDOR_ID, &ID);
+	ctrl->pci_bus->number = new_slot->bus;
+	pci_bus_read_config_dword (ctrl->pci_bus, PCI_DEVFN(new_slot->device, 0), PCI_VENDOR_ID, &ID);
 
 	if (ID != 0xFFFFFFFF) {	  //  device in slot
-		pci_read_config_byte_nodev (ctrl->pci_ops, new_slot->bus, new_slot->device, 0, 0x0B, &class_code);
-
-		pci_read_config_byte_nodev (ctrl->pci_ops, new_slot->bus, new_slot->device, 0, PCI_HEADER_TYPE, &header_type);
+		pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(new_slot->device, 0), 0x0B, &class_code);
+		pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(new_slot->device, 0), PCI_HEADER_TYPE, &header_type);
 
 		if (header_type & 0x80)	// Multi-function device
 			max_functions = 8;
@@ -694,22 +698,22 @@
 		do {
 			if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {	  // PCI-PCI Bridge
 				//  Recurse the subordinate bus
-				pci_read_config_byte_nodev (ctrl->pci_ops, new_slot->bus, new_slot->device, function, PCI_SECONDARY_BUS, &secondary_bus);
+				pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(new_slot->device, function), PCI_SECONDARY_BUS, &secondary_bus);
 
 				sub_bus = (int) secondary_bus;
 
 				// Save the config headers for the secondary bus.
 				rc = cpqhp_save_config(ctrl, sub_bus, 0);
-
 				if (rc)
 					return(rc);
+				ctrl->pci_bus->number = new_slot->bus;
 
 			}	// End of IF
 
 			new_slot->status = 0;
 
 			for (cloop = 0; cloop < 0x20; cloop++) {
-				pci_read_config_dword_nodev (ctrl->pci_ops, new_slot->bus, new_slot->device, function, cloop << 2, (u32 *) & (new_slot-> config_space [cloop]));
+				pci_bus_read_config_dword (ctrl->pci_bus, PCI_DEVFN(new_slot->device, function), cloop << 2, (u32 *) & (new_slot-> config_space [cloop]));
 			}
 
 			function++;
@@ -720,14 +724,14 @@
 			//  reading in the Class Code and the Header type.
 
 			while ((function < max_functions) && (!stop_it)) {
-				pci_read_config_dword_nodev (ctrl->pci_ops, new_slot->bus, new_slot->device, function, PCI_VENDOR_ID, &ID);
+				pci_bus_read_config_dword (ctrl->pci_bus, PCI_DEVFN(new_slot->device, function), PCI_VENDOR_ID, &ID);
 
 				if (ID == 0xFFFFFFFF) {	 // nothing there.
 					function++;
 				} else {  // Something there
-					pci_read_config_byte_nodev (ctrl->pci_ops, new_slot->bus, new_slot->device, function, 0x0B, &class_code);
+					pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(new_slot->device, function), 0x0B, &class_code);
 
-					pci_read_config_byte_nodev (ctrl->pci_ops, new_slot->bus, new_slot->device, function, PCI_HEADER_TYPE, &header_type);
+					pci_bus_read_config_byte (ctrl->pci_bus, PCI_DEVFN(new_slot->device, function), PCI_HEADER_TYPE, &header_type);
 
 					stop_it++;
 				}
@@ -763,17 +767,21 @@
 	u32 rc;
 	struct pci_func *next;
 	int index = 0;
+	struct pci_bus *pci_bus = ctrl->pci_bus;
+	unsigned int devfn;
 
 	func = cpqhp_slot_find(func->bus, func->device, index++);
 
 	while (func != NULL) {
+		pci_bus->number = func->bus;
+		devfn = PCI_DEVFN(func->device, func->function);
 
 		// Check for Bridge
-		pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_HEADER_TYPE, &header_type);
+		pci_bus_read_config_byte (pci_bus, devfn, PCI_HEADER_TYPE, &header_type);
 
 		if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {
 			// PCI-PCI Bridge
-			pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_SECONDARY_BUS, &secondary_bus);
+			pci_bus_read_config_byte (pci_bus, devfn, PCI_SECONDARY_BUS, &secondary_bus);
 
 			sub_bus = (int) secondary_bus;
 
@@ -787,13 +795,14 @@
 
 				next = next->next;
 			}
+			pci_bus->number = func->bus;
 
 			//FIXME: this loop is duplicated in the non-bridge case.  The two could be rolled together
 			// Figure out IO and memory base lengths
 			for (cloop = 0x10; cloop <= 0x14; cloop += 4) {
 				temp_register = 0xFFFFFFFF;
-				pci_write_config_dword_nodev(ctrl->pci_ops, func->bus, func->device, func->function, cloop, temp_register);
-				pci_read_config_dword_nodev (ctrl->pci_ops, func->bus, func->device, func->function, cloop, &base);
+				pci_bus_write_config_dword (pci_bus, devfn, cloop, temp_register);
+				pci_bus_read_config_dword (pci_bus, devfn, cloop, &base);
 
 				if (base) {  // If this register is implemented
 					if (base & 0x01L) {
@@ -827,8 +836,8 @@
 			// Figure out IO and memory base lengths
 			for (cloop = 0x10; cloop <= 0x24; cloop += 4) {
 				temp_register = 0xFFFFFFFF;
-				pci_write_config_dword_nodev(ctrl->pci_ops, func->bus, func->device, func->function, cloop, temp_register);
-				pci_read_config_dword_nodev (ctrl->pci_ops, func->bus, func->device, func->function, cloop, &base);
+				pci_bus_write_config_dword (pci_bus, devfn, cloop, temp_register);
+				pci_bus_read_config_dword (pci_bus, devfn, cloop, &base);
 
 				if (base) {  // If this register is implemented
 					if (base & 0x01L) {
@@ -897,28 +906,31 @@
 	struct pci_resource *p_mem_node;
 	struct pci_resource *io_node;
 	struct pci_resource *bus_node;
+	struct pci_bus *pci_bus = ctrl->pci_bus;
+	unsigned int devfn;
 
 	func = cpqhp_slot_find(func->bus, func->device, index++);
 
 	while ((func != NULL) && func->is_a_board) {
+		pci_bus->number = func->bus;
+		devfn = PCI_DEVFN(func->device, func->function);
+
 		// Save the command register
-		pci_read_config_word_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_COMMAND, &save_command);
+		pci_bus_read_config_word (pci_bus, devfn, PCI_COMMAND, &save_command);
 
 		// disable card
 		command = 0x00;
-		pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_COMMAND, command);
+		pci_bus_write_config_word (pci_bus, devfn, PCI_COMMAND, command);
 
 		// Check for Bridge
-		pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_HEADER_TYPE, &header_type);
+		pci_bus_read_config_byte (pci_bus, devfn, PCI_HEADER_TYPE, &header_type);
 
 		if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {	  // PCI-PCI Bridge
 			// Clear Bridge Control Register
 			command = 0x00;
-			pci_write_config_word_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_BRIDGE_CONTROL, command);
-
-			pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_SECONDARY_BUS, &secondary_bus);
-
-			pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_SUBORDINATE_BUS, &temp_byte);
+			pci_bus_write_config_word (pci_bus, devfn, PCI_BRIDGE_CONTROL, command);
+			pci_bus_read_config_byte (pci_bus, devfn, PCI_SECONDARY_BUS, &secondary_bus);
+			pci_bus_read_config_byte (pci_bus, devfn, PCI_SUBORDINATE_BUS, &temp_byte);
 
 			bus_node =(struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
 			if (!bus_node)
@@ -931,9 +943,8 @@
 			func->bus_head = bus_node;
 
 			// Save IO base and Limit registers
-			pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_IO_BASE, &b_base);
-
-			pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_IO_LIMIT, &b_length);
+			pci_bus_read_config_byte (pci_bus, devfn, PCI_IO_BASE, &b_base);
+			pci_bus_read_config_byte (pci_bus, devfn, PCI_IO_LIMIT, &b_length);
 
 			if ((b_base <= b_length) && (save_command & 0x01)) {
 				io_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
@@ -946,10 +957,10 @@
 				io_node->next = func->io_head;
 				func->io_head = io_node;
 			}
-			// Save memory base and Limit registers
-			pci_read_config_word_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_MEMORY_BASE, &w_base);
 
-			pci_read_config_word_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_MEMORY_LIMIT, &w_length);
+			// Save memory base and Limit registers
+			pci_bus_read_config_word (pci_bus, devfn, PCI_MEMORY_BASE, &w_base);
+			pci_bus_read_config_word (pci_bus, devfn, PCI_MEMORY_LIMIT, &w_length);
 
 			if ((w_base <= w_length) && (save_command & 0x02)) {
 				mem_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
@@ -962,10 +973,10 @@
 				mem_node->next = func->mem_head;
 				func->mem_head = mem_node;
 			}
-			// Save prefetchable memory base and Limit registers
-			pci_read_config_word_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_PREF_MEMORY_BASE, &w_base);
 
-			pci_read_config_word_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_PREF_MEMORY_LIMIT, &w_length);
+			// Save prefetchable memory base and Limit registers
+			pci_bus_read_config_word (pci_bus, devfn, PCI_PREF_MEMORY_BASE, &w_base);
+			pci_bus_read_config_word (pci_bus, devfn, PCI_PREF_MEMORY_LIMIT, &w_length);
 
 			if ((w_base <= w_length) && (save_command & 0x02)) {
 				p_mem_node = (struct pci_resource *) kmalloc(sizeof(struct pci_resource), GFP_KERNEL);
@@ -980,12 +991,11 @@
 			}
 			// Figure out IO and memory base lengths
 			for (cloop = 0x10; cloop <= 0x14; cloop += 4) {
-				pci_read_config_dword_nodev (ctrl->pci_ops, func->bus, func->device, func->function, cloop, &save_base);
+				pci_bus_read_config_dword (pci_bus, devfn, cloop, &save_base);
 
 				temp_register = 0xFFFFFFFF;
-				pci_write_config_dword_nodev(ctrl->pci_ops, func->bus, func->device, func->function, cloop, temp_register);
-
-				pci_read_config_dword_nodev (ctrl->pci_ops, func->bus, func->device, func->function, cloop, &base);
+				pci_bus_write_config_dword (pci_bus, devfn, cloop, temp_register);
+				pci_bus_read_config_dword (pci_bus, devfn, cloop, &base);
 
 				temp_register = base;
 
@@ -1046,12 +1056,11 @@
 		} else if ((header_type & 0x7F) == 0x00) {	  // Standard header
 			// Figure out IO and memory base lengths
 			for (cloop = 0x10; cloop <= 0x24; cloop += 4) {
-				pci_read_config_dword_nodev (ctrl->pci_ops, func->bus, func->device, func->function, cloop, &save_base);
+				pci_bus_read_config_dword (pci_bus, devfn, cloop, &save_base);
 
 				temp_register = 0xFFFFFFFF;
-				pci_write_config_dword_nodev(ctrl->pci_ops, func->bus, func->device, func->function, cloop, temp_register);
-
-				pci_read_config_dword_nodev (ctrl->pci_ops, func->bus, func->device, func->function, cloop, &base);
+				pci_bus_write_config_dword (pci_bus, devfn, cloop, temp_register);
+				pci_bus_read_config_dword (pci_bus, devfn, cloop, &base);
 
 				temp_register = base;
 
@@ -1138,21 +1147,26 @@
 	u32 temp;
 	u32 rc;
 	int index = 0;
+	struct pci_bus *pci_bus = ctrl->pci_bus;
+	unsigned int devfn;
 
 	func = cpqhp_slot_find(func->bus, func->device, index++);
 
 	while (func != NULL) {
+		pci_bus->number = func->bus;
+		devfn = PCI_DEVFN(func->device, func->function);
+
 		// Start at the top of config space so that the control
 		// registers are programmed last
 		for (cloop = 0x3C; cloop > 0; cloop -= 4) {
-			pci_write_config_dword_nodev(ctrl->pci_ops, func->bus, func->device, func->function, cloop, func->config_space[cloop >> 2]);
+			pci_bus_write_config_dword (pci_bus, devfn, cloop, func->config_space[cloop >> 2]);
 		}
 
-		pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_HEADER_TYPE, &header_type);
+		pci_bus_read_config_byte (pci_bus, devfn, PCI_HEADER_TYPE, &header_type);
 
 		// If this is a bridge device, restore subordinate devices
 		if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {	  // PCI-PCI Bridge
-			pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_SECONDARY_BUS, &secondary_bus);
+			pci_bus_read_config_byte (pci_bus, devfn, PCI_SECONDARY_BUS, &secondary_bus);
 
 			sub_bus = (int) secondary_bus;
 
@@ -1172,7 +1186,7 @@
 			// they are the same.  If not, the board is different.
 
 			for (cloop = 16; cloop < 40; cloop += 4) {
-				pci_read_config_dword_nodev (ctrl->pci_ops, func->bus, func->device, func->function, cloop, &temp);
+				pci_bus_read_config_dword (pci_bus, devfn, cloop, &temp);
 
 				if (temp != func->config_space[cloop >> 2]) {
 					dbg("Config space compare failure!!! offset = %x\n", cloop);
@@ -1212,6 +1226,8 @@
 	u32 rc;
 	struct pci_func *next;
 	int index = 0;
+	struct pci_bus *pci_bus = ctrl->pci_bus;
+	unsigned int devfn;
 
 	if (!func->is_a_board)
 		return(ADD_NOT_SUPPORTED);
@@ -1219,7 +1235,10 @@
 	func = cpqhp_slot_find(func->bus, func->device, index++);
 
 	while (func != NULL) {
-		pci_read_config_dword_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_VENDOR_ID, &temp_register);
+		pci_bus->number = func->bus;
+		devfn = PCI_DEVFN(func->device, func->function);
+
+		pci_bus_read_config_dword (pci_bus, devfn, PCI_VENDOR_ID, &temp_register);
 
 		// No adapter present
 		if (temp_register == 0xFFFFFFFF)
@@ -1229,14 +1248,14 @@
 			return(ADAPTER_NOT_SAME);
 
 		// Check for same revision number and class code
-		pci_read_config_dword_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_CLASS_REVISION, &temp_register);
+		pci_bus_read_config_dword (pci_bus, devfn, PCI_CLASS_REVISION, &temp_register);
 
 		// Adapter not the same
 		if (temp_register != func->config_space[0x08 >> 2])
 			return(ADAPTER_NOT_SAME);
 
 		// Check for Bridge
-		pci_read_config_byte_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_HEADER_TYPE, &header_type);
+		pci_bus_read_config_byte (pci_bus, devfn, PCI_HEADER_TYPE, &header_type);
 
 		if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {	  // PCI-PCI Bridge
 			// In order to continue checking, we must program the
@@ -1244,7 +1263,7 @@
 			// for it's subordinate bus(es)
 
 			temp_register = func->config_space[0x18 >> 2];
-			pci_write_config_dword_nodev(ctrl->pci_ops, func->bus, func->device, func->function, PCI_PRIMARY_BUS, temp_register);
+			pci_bus_write_config_dword (pci_bus, devfn, PCI_PRIMARY_BUS, temp_register);
 
 			secondary_bus = (temp_register >> 8) & 0xFF;
 
@@ -1263,7 +1282,7 @@
 		// Check to see if it is a standard config header
 		else if ((header_type & 0x7F) == PCI_HEADER_TYPE_NORMAL) {
 			// Check subsystem vendor and ID
-			pci_read_config_dword_nodev (ctrl->pci_ops, func->bus, func->device, func->function, PCI_SUBSYSTEM_VENDOR_ID, &temp_register);
+			pci_bus_read_config_dword (pci_bus, devfn, PCI_SUBSYSTEM_VENDOR_ID, &temp_register);
 
 			if (temp_register != func->config_space[0x2C >> 2]) {
 				// If it's a SMART-2 and the register isn't filled
@@ -1277,10 +1296,8 @@
 			// Figure out IO and memory base lengths
 			for (cloop = 0x10; cloop <= 0x24; cloop += 4) {
 				temp_register = 0xFFFFFFFF;
-				pci_write_config_dword_nodev(ctrl->pci_ops, func->bus, func->device, func->function, cloop, temp_register);
-
-				pci_read_config_dword_nodev (ctrl->pci_ops, func->bus, func->device, func->function, cloop, &base);
-
+				pci_bus_write_config_dword (pci_bus, devfn, cloop, temp_register);
+				pci_bus_read_config_dword (pci_bus, devfn, cloop, &base);
 				if (base) {	  // If this register is implemented
 					if (base & 0x01L) {
 						// IO base
@@ -1436,8 +1453,8 @@
 			continue;
 		}
 		// find out if this entry is for an occupied slot
-		pci_read_config_dword_nodev (ctrl->pci_ops, primary_bus, dev_func >> 3, dev_func & 0x07, PCI_VENDOR_ID, &temp_dword);
-
+		ctrl->pci_bus->number = primary_bus;
+		pci_bus_read_config_dword (ctrl->pci_bus, dev_func, PCI_VENDOR_ID, &temp_dword);
 		dbg("temp_D_word = %x\n", temp_dword);
 
 		if (temp_dword != 0xFFFFFFFF) {
diff -Nru a/drivers/hotplug/cpqphp_proc.c b/drivers/hotplug/cpqphp_proc.c
--- a/drivers/hotplug/cpqphp_proc.c	Mon Sep  9 15:09:29 2002
+++ b/drivers/hotplug/cpqphp_proc.c	Mon Sep  9 15:09:29 2002
@@ -53,8 +53,9 @@
 	*eof = 1;
 
 	out += sprintf(out, "hot plug ctrl Info Page\n");
-	out += sprintf(out, "bus = %d, device = %d, function = %d\n",ctrl->bus,
-		       ctrl->device, ctrl->function);
+	out += sprintf(out, "bus = %d, device = %d, function = %d\n",
+		       ctrl->bus, PCI_SLOT(ctrl->pci_dev->devfn),
+		       PCI_FUNC(ctrl->pci_dev->devfn));
 	out += sprintf(out, "Free resources: memory\n");
 	index = 11;
 	res = ctrl->mem_head;
@@ -104,8 +105,9 @@
 	*eof = 1;
 
 	out += sprintf(out, "hot plug ctrl Info Page\n");
-	out += sprintf(out, "bus = %d, device = %d, function = %d\n",ctrl->bus,
-		       ctrl->device, ctrl->function);
+	out += sprintf(out, "bus = %d, device = %d, function = %d\n",
+		       ctrl->bus, PCI_SLOT(ctrl->pci_dev->devfn),
+		       PCI_FUNC(ctrl->pci_dev->devfn));
 
 	slot=ctrl->slot;
 
