Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVFBWdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVFBWdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 18:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVFBWdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 18:33:42 -0400
Received: from fmr20.intel.com ([134.134.136.19]:58589 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261444AbVFBWdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:33:14 -0400
Message-Id: <20050602224327.051278000@csdlinux-1>
References: <20050602224147.177031000@csdlinux-1>
Date: Thu, 02 Jun 2005 15:41:49 -0700
From: rajesh.shah@intel.com
To: gregkh@suse.de, ink@jurassic.park.msu.ru, ak@suse.de, len.brown@intel.com,
       akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       acpi-devel@lists.sourceforge.net, Rajesh Shah <rajesh.shah@intel.com>
Subject: [patch 2/2] i386/x86_64: collect host bridge resources v2
Content-Disposition: inline; filename=i386-host-bridge-resources-v2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reads and stores host bridge resources reported by
ACPI BIOS for i386 and x86_64 systems.  This is needed since
ACPI hotplug code now uses the PCI core for resource management. 

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>

Index: linux-2.6.12-rc5/arch/i386/pci/acpi.c
===================================================================
--- linux-2.6.12-rc5.orig/arch/i386/pci/acpi.c
+++ linux-2.6.12-rc5/arch/i386/pci/acpi.c
@@ -5,14 +5,165 @@
 #include <asm/hw_irq.h>
 #include "pci.h"
 
+static void inline
+add_resource_range(int idx, struct pci_bus *bus,
+		struct acpi_resource_address64 *addr, unsigned long flags)
+{
+	memset(bus->resource[idx], 0, sizeof(*(bus->resource[idx])));
+	bus->resource[idx]->name = bus->name;
+	bus->resource[idx]->start = addr->min_address_range;
+	bus->resource[idx]->end = addr->max_address_range;
+	bus->resource[idx]->flags = flags;
+}
+
+static acpi_status
+add_resources(struct acpi_resource *acpi_res, void *context)
+{
+	struct acpi_resource_address64 address;
+	struct pci_bus *bus = context;
+	int idx;
+	unsigned long flags = 0;
+	struct resource *busr;
+
+	if (acpi_res->id != ACPI_RSTYPE_ADDRESS16 &&
+	    acpi_res->id != ACPI_RSTYPE_ADDRESS32 &&
+	    acpi_res->id != ACPI_RSTYPE_ADDRESS64)
+		return AE_OK;
+
+	if (ACPI_FAILURE(acpi_resource_to_address64(acpi_res, &address)))
+		return AE_OK;
+
+	/*
+	 * Per the ACPI spec, we should pick up only ACPI_PRODUCER type
+	 * resources. However, many BIOSs get this wrong and report
+	 * resources they pass down as ACPI_CONSUMER type resources. For now,
+	 * pick up all resources here.
+	 */
+	if (address.address_length <= 0)
+		return AE_OK;
+
+	switch (address.resource_type) {
+		case ACPI_IO_RANGE:
+			flags = IORESOURCE_IO;
+			break;
+		case ACPI_MEMORY_RANGE:
+			flags = IORESOURCE_MEM;
+			if (address.attribute.memory.cache_attribute ==
+					ACPI_PREFETCHABLE_MEMORY)
+				flags |= IORESOURCE_PREFETCH;
+			break;
+		default:
+			return AE_OK;
+			break;
+	}
+	for (idx = 0; idx < PCI_BUS_NUM_RESOURCES; idx++) {
+		if (!bus->resource[idx]) {
+			bus->resource[idx] = kmalloc(
+					sizeof(*(bus->resource[idx])),
+					GFP_KERNEL);
+			if (!bus->resource[idx])
+				break;
+			add_resource_range(idx, bus, &address, flags);
+			return AE_OK;
+		}
+		busr = bus->resource[idx];
+		if (busr->flags != flags)
+			continue;
+		/* Consolidate adjacent resource ranges */
+		if (busr->end + 1 == address.min_address_range) {
+			busr->end = address.max_address_range;
+			return AE_OK;
+		}
+		if (address.max_address_range + 1 == busr->start) {
+			busr->start = address.min_address_range;
+			return AE_OK;
+		}
+		/* Consolidate overlapping resource ranges */
+		if (address.max_address_range < busr->start)
+			continue;
+		if (address.min_address_range > busr->end)
+			continue;
+		if (address.min_address_range < busr->start)
+			busr->start = address.min_address_range;
+		if (address.max_address_range > busr->end)
+			busr->end = address.max_address_range;
+		return AE_OK;
+	}
+	printk(KERN_WARNING
+		"PCI: Cannot add host bridge range %Lx-%Lx, type %x\n",
+		address.min_address_range, address.max_address_range,
+		address.resource_type);
+	return AE_ERROR;
+}
+
+static int __devinit
+verify_root_windows(struct pci_bus *bus)
+{
+	int i, num_io = 0, num_mem = 0;
+	int type_mask = IORESOURCE_IO | IORESOURCE_MEM;
+
+	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
+		if (!bus->resource[i])
+			continue;
+		switch (bus->resource[i]->flags & type_mask) {
+			case IORESOURCE_IO:
+				num_io++;
+				break;
+			case IORESOURCE_MEM:
+				num_mem++;
+				break;
+			default:
+				break;
+		}
+	}
+
+	if (num_io || num_mem)
+		return 1;
+	else
+		printk(KERN_WARNING
+			"PCI: BIOS reported bogus host bridge resources\n");
+	return 0;
+}
+
+static void __devinit
+pcibios_setup_root_windows(struct pci_bus *bus, acpi_handle handle)
+{
+	int i;
+	acpi_status status;
+	struct resource *bres[PCI_BUS_NUM_RESOURCES];
+
+	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
+		bres[i] = bus->resource[i];
+		bus->resource[i] = NULL;
+	}
+
+	sprintf(bus->name, "PCI Bus #%02x", bus->number);
+	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
+			add_resources, bus);
+	if (ACPI_FAILURE(status) || !verify_root_windows(bus)) {
+		printk(KERN_WARNING
+			"PCI: Falling back to default host bridge resources\n");
+		for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
+			kfree(bus->resource[i]);
+			bus->resource[i] = bres[i];
+		}
+	}
+}
+
+
 struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_device *device, int domain, int busnum)
 {
+	struct pci_bus *bus;
+
 	if (domain != 0) {
 		printk(KERN_WARNING "PCI: Multiple domains not supported\n");
 		return NULL;
 	}
 
-	return pcibios_scan_root(busnum);
+	bus =  pcibios_scan_root(busnum);
+	if (bus) 
+		pcibios_setup_root_windows(bus, device->handle);
+	return bus;
 }
 
 extern int pci_routeirq;

--
