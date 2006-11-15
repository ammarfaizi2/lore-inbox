Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030577AbWKOPZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030577AbWKOPZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 10:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030576AbWKOPZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 10:25:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:15542 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030573AbWKOPZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 10:25:05 -0500
From: John Keller <jpk@sgi.com>
To: linux-acpi@vger.kernel.org
Cc: akpm@osdl.org, len.brown@intel.com, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       gregkh@suse.de, linux-kernel@vger.kernel.org, ayoung@sgi.com,
       jes@sgi.com, John Keller <jpk@sgi.com>
Date: Wed, 15 Nov 2006 09:24:54 -0600
Message-Id: <20061115152454.6047.64973.sendpatchset@attica.americas.sgi.com>
Subject: [PATCH 1/3] - Altix: ACPI SSDT PCI device support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add SN platform support for running with an ACPI
capable PROM that defines PCI devices in SSDT
tables. There is a SSDT table for every occupied
slot on a root bus, containing info for every
PPB and/or device on the bus. The SSDTs will be
dynamically loaded/unloaded at hotplug enable/disable.

Platform specific information that is currently
passed via a SAL call, will now be passed via the
Vendor resource in the ACPI Device object(s) defined
in each SSDT.

Signed-off-by: John Keller <jpk@sgi.com>

---

 Note: This patch is dependent on a previous set of SN ACPI
       patches.

        altix-add-initial-acpi-io-support.patch
        altix-sn-acpi-hotplug-support.patch
        altix-initial-acpi-support-rom-shadowing.patch


 arch/ia64/sn/kernel/io_acpi_init.c      |  314 ++++++++++++++++++++--
 arch/ia64/sn/kernel/io_common.c         |   68 ----
 arch/ia64/sn/kernel/io_init.c           |   54 +++
 arch/ia64/sn/pci/pcibr/pcibr_provider.c |    6 
 include/asm-ia64/sn/acpi.h              |    5 
 include/asm-ia64/sn/pcibr_provider.h    |    2 
 include/asm-ia64/sn/pcidev.h            |    8 
 7 files changed, 362 insertions(+), 95 deletions(-)


Index: linux-2.6/arch/ia64/sn/kernel/io_acpi_init.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/kernel/io_acpi_init.c	2006-10-23 08:57:24.672453172 -0500
+++ linux-2.6/arch/ia64/sn/kernel/io_acpi_init.c	2006-10-23 09:16:25.245957610 -0500
@@ -13,6 +13,7 @@
 #include <asm/sn/sn_sal.h>
 #include "xtalk/hubdev.h"
 #include <linux/acpi.h>
+#include <acpi/acnamesp.h>
 
 
 /*
@@ -31,6 +32,12 @@ struct acpi_vendor_uuid sn_uuid = {
 		    0xa2, 0x7c, 0x08, 0x00, 0x69, 0x13, 0xea, 0x51 },
 };
 
+struct sn_pcidev_match {
+	u8 bus;
+	unsigned int devfn;
+	acpi_handle handle;
+};
+
 /*
  * Perform the early IO init in PROM.
  */
@@ -119,9 +126,11 @@ sn_get_bussoft_ptr(struct pci_bus *bus)
 	status = acpi_get_vendor_resource(handle, METHOD_NAME__CRS,
 					  &sn_uuid, &buffer);
 	if (ACPI_FAILURE(status)) {
-		printk(KERN_ERR "get_acpi_pcibus_ptr: "
-		       "get_acpi_bussoft_info() failed: %d\n",
-		       status);
+		printk(KERN_ERR "%s: "
+		       "acpi_get_vendor_resource() failed (0x%x) for: ",
+		       __FUNCTION__, status);
+		acpi_ns_print_node_pathname(handle, NULL);
+		printk("\n");
 		return NULL;
 	}
 	resource = buffer.pointer;
@@ -130,8 +139,8 @@ sn_get_bussoft_ptr(struct pci_bus *bus)
 	if ((vendor->byte_length - sizeof(struct acpi_vendor_uuid)) !=
 	     sizeof(struct pcibus_bussoft *)) {
 		printk(KERN_ERR
-		       "get_acpi_bussoft_ptr: Invalid vendor data "
-		       "length %d\n", vendor->byte_length);
+		       "%s: Invalid vendor data length %d\n",
+			__FUNCTION__, vendor->byte_length);
 		kfree(buffer.pointer);
 		return NULL;
 	}
@@ -143,34 +152,254 @@ sn_get_bussoft_ptr(struct pci_bus *bus)
 }
 
 /*
- * sn_acpi_bus_fixup
+ * sn_extract_device_info - Extract the pcidev_info and the sn_irq_info
+ *			    pointers from the vendor resource using the
+ *			    provided acpi handle, and copy the structures
+ *			    into the argument buffers.
  */
-void
-sn_acpi_bus_fixup(struct pci_bus *bus)
+static int
+sn_extract_device_info(acpi_handle handle, struct pcidev_info **pcidev_info,
+		    struct sn_irq_info **sn_irq_info)
 {
-	struct pci_dev *pci_dev = NULL;
-	struct pcibus_bussoft *prom_bussoft_ptr;
-	extern void sn_common_bus_fixup(struct pci_bus *,
-					struct pcibus_bussoft *);
+	u64 addr;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct sn_irq_info *irq_info, *irq_info_prom;
+	struct pcidev_info *pcidev_ptr, *pcidev_prom_ptr;
+	struct acpi_resource *resource;
+	int ret = 0;
+	acpi_status status;
+	struct acpi_resource_vendor_typed *vendor;
 
-	if (!bus->parent) {	/* If root bus */
-		prom_bussoft_ptr = sn_get_bussoft_ptr(bus);
-		if (prom_bussoft_ptr == NULL) {
+	/*
+	 * The pointer to this device's pcidev_info structure in
+	 * the PROM, is in the vendor resource.
+	 */
+	status = acpi_get_vendor_resource(handle, METHOD_NAME__CRS,
+					  &sn_uuid, &buffer);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR
+		       "%s: acpi_get_vendor_resource() failed (0x%x) for: ",
+		        __FUNCTION__, status);
+		acpi_ns_print_node_pathname(handle, NULL);
+		printk("\n");
+		return 1;
+	}
+
+	resource = buffer.pointer;
+	vendor = &resource->data.vendor_typed;
+	if ((vendor->byte_length - sizeof(struct acpi_vendor_uuid)) !=
+	    sizeof(struct pci_devdev_info *)) {
+		printk(KERN_ERR
+		       "%s: Invalid vendor data length: %d for: ",
+		        __FUNCTION__, vendor->byte_length);
+		acpi_ns_print_node_pathname(handle, NULL);
+		printk("\n");
+		ret = 1;
+		goto exit;
+	}
+
+	pcidev_ptr = kzalloc(sizeof(struct pcidev_info), GFP_KERNEL);
+	if (!pcidev_ptr)
+		panic("%s: Unable to alloc memory for pcidev_info", __FUNCTION__);
+
+	memcpy(&addr, vendor->byte_data, sizeof(struct pcidev_info *));
+	pcidev_prom_ptr = __va(addr);
+	memcpy(pcidev_ptr, pcidev_prom_ptr, sizeof(struct pcidev_info));
+
+	/* Get the IRQ info */
+	irq_info = kzalloc(sizeof(struct sn_irq_info), GFP_KERNEL);
+	if (!irq_info)
+		 panic("%s: Unable to alloc memory for sn_irq_info", __FUNCTION__);
+
+	if (pcidev_ptr->pdi_sn_irq_info) {
+		irq_info_prom = __va(pcidev_ptr->pdi_sn_irq_info);
+		memcpy(irq_info, irq_info_prom, sizeof(struct sn_irq_info));
+	}
+
+	*pcidev_info = pcidev_ptr;
+	*sn_irq_info = irq_info;
+
+exit:
+	kfree(buffer.pointer);
+	return ret;
+}
+
+static unsigned int
+get_host_devfn(acpi_handle device_handle, acpi_handle rootbus_handle)
+{
+	unsigned long adr;
+	acpi_handle child;
+	unsigned int devfn;
+	int function;
+	acpi_handle parent;
+	int slot;
+	acpi_status status;
+
+	/*
+	 * Do an upward search to find the root bus device, and
+	 * obtain the host devfn from the previous child device.
+	 */
+	child = device_handle;
+	while (child) {
+		status = acpi_get_parent(child, &parent);
+		if (ACPI_FAILURE(status)) {
+			printk(KERN_ERR "%s: acpi_get_parent() failed "
+			       "(0x%x) for: ", __FUNCTION__, status);
+			acpi_ns_print_node_pathname(child, NULL);
+			printk("\n");
+			panic("%s: Unable to find host devfn\n", __FUNCTION__);
+		}
+		if (parent == rootbus_handle)
+			break;
+		child = parent;
+	}
+	if (!child) {
+		printk(KERN_ERR "%s: Unable to find root bus for: ",
+		       __FUNCTION__);
+		acpi_ns_print_node_pathname(device_handle, NULL);
+		printk("\n");
+		BUG();
+	}
+
+	status = acpi_evaluate_integer(child, METHOD_NAME__ADR, NULL, &adr);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR "%s: Unable to get _ADR (0x%x) for: ",
+		       __FUNCTION__, status);
+		acpi_ns_print_node_pathname(child, NULL);
+		printk("\n");
+		panic("%s: Unable to find host devfn\n", __FUNCTION__);
+	}
+
+	slot = (adr >> 16) & 0xffff;
+       	function = adr & 0xffff;
+	devfn = PCI_DEVFN(slot, function);
+	return devfn;
+}
+
+/*
+ * find_matching_device - Callback routine to find the ACPI device
+ *			  that matches up with our pci_dev device.
+ *			  Matching is done on bus number and devfn.
+ *			  To find the bus number for a particular
+ *			  ACPI device, we must look at the _BBN method
+ *			  of its parent.
+ */
+static acpi_status
+find_matching_device(acpi_handle handle, u32 lvl, void *context, void **rv)
+{
+	unsigned long bbn = -1;
+	unsigned long adr;
+	acpi_handle parent = NULL;
+	acpi_status status;
+	unsigned int devfn;
+	int function;
+	int slot;
+	struct sn_pcidev_match *info = context;
+
+        status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL,
+                                       &adr);
+        if (ACPI_SUCCESS(status)) {
+		status = acpi_get_parent(handle, &parent);
+		if (ACPI_FAILURE(status)) {
 			printk(KERN_ERR
-			       "sn_pci_fixup_bus: 0x%04x:0x%02x Unable to "
-			       "obtain prom_bussoft_ptr\n",
-			       pci_domain_nr(bus), bus->number);
-			return;
+			       "%s: acpi_get_parent() failed (0x%x) for: ",
+		       		__FUNCTION__, status);
+			acpi_ns_print_node_pathname(handle, NULL);
+			printk("\n");
+			return AE_OK;
+		}
+		status = acpi_evaluate_integer(parent, METHOD_NAME__BBN,
+					       NULL, &bbn);
+		if (ACPI_FAILURE(status)) {
+			printk(KERN_ERR
+			  "%s: Failed to find _BBN in parent of: ",
+		       		__FUNCTION__);
+			acpi_ns_print_node_pathname(handle, NULL);
+			printk("\n");
+			return AE_OK;
+		}
+
+                slot = (adr >> 16) & 0xffff;
+                function = adr & 0xffff;
+                devfn = PCI_DEVFN(slot, function);
+                if ((info->devfn == devfn) && (info->bus == bbn)) {
+			/* We have a match! */
+			info->handle = handle;
+			return 1;
 		}
-		sn_common_bus_fixup(bus, prom_bussoft_ptr);
 	}
-	list_for_each_entry(pci_dev, &bus->devices, bus_list) {
-		sn_pci_fixup_slot(pci_dev);
+	return AE_OK;
+}
+
+/*
+ * sn_acpi_get_pcidev_info - Search ACPI namespace for the acpi
+ *			     device matching the specified pci_dev,
+ *			     and return the pcidev info and irq info.
+ */
+int
+sn_acpi_get_pcidev_info(struct pci_dev *dev, struct pcidev_info **pcidev_info,
+			struct sn_irq_info **sn_irq_info)
+{
+	unsigned int host_devfn;
+	struct sn_pcidev_match pcidev_match;
+	acpi_handle rootbus_handle;
+	unsigned long segment;
+	acpi_status status;
+
+	rootbus_handle = PCI_CONTROLLER(dev)->acpi_handle;
+        status = acpi_evaluate_integer(rootbus_handle, METHOD_NAME__SEG, NULL,
+                                       &segment);
+        if (ACPI_SUCCESS(status)) {
+		if (segment != pci_domain_nr(dev)) {
+			printk(KERN_ERR
+			       "%s: Segment number mismatch, 0x%lx vs 0x%x for: ",
+			       __FUNCTION__, segment, pci_domain_nr(dev));
+			acpi_ns_print_node_pathname(rootbus_handle, NULL);
+			printk("\n");
+			return 1;
+		}
+	} else {
+		printk(KERN_ERR "%s: Unable to get __SEG from: ",
+		       __FUNCTION__);
+		acpi_ns_print_node_pathname(rootbus_handle, NULL);
+		printk("\n");
+		return 1;
 	}
+
+	/*
+	 * We want to search all devices in this segment/domain
+	 * of the ACPI namespace for the matching ACPI device,
+	 * which holds the pcidev_info pointer in its vendor resource.
+	 */
+	pcidev_match.bus = dev->bus->number;
+	pcidev_match.devfn = dev->devfn;
+	pcidev_match.handle = NULL;
+
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, rootbus_handle, ACPI_UINT32_MAX,
+			    find_matching_device, &pcidev_match, NULL);
+
+	if (!pcidev_match.handle) {
+		printk(KERN_ERR
+		       "%s: Could not find matching ACPI device for %s.\n",
+		       __FUNCTION__, pci_name(dev));
+		return 1;
+	}
+
+	if (sn_extract_device_info(pcidev_match.handle, pcidev_info, sn_irq_info))
+		return 1;
+
+	/* Build up the pcidev_info.pdi_slot_host_handle */
+	host_devfn = get_host_devfn(pcidev_match.handle, rootbus_handle);
+	(*pcidev_info)->pdi_slot_host_handle =
+			((unsigned long) pci_domain_nr(dev) << 40) |
+					/* bus == 0 */
+					host_devfn;
+	return 0;
 }
 
 /*
- * sn_acpi_slot_fixup - Perform any SN specific slot fixup.
+ * sn_acpi_slot_fixup - Obtain the pcidev_info and sn_irq_info.
+ *			Perform any SN specific slot fixup.
  *			At present there does not appear to be
  *			any generic way to handle a ROM image
  *			that has been shadowed by the PROM, so
@@ -179,11 +408,18 @@ sn_acpi_bus_fixup(struct pci_bus *bus)
  */
 
 void
-sn_acpi_slot_fixup(struct pci_dev *dev, struct pcidev_info *pcidev_info)
+sn_acpi_slot_fixup(struct pci_dev *dev)
 {
 	void __iomem *addr;
+	struct pcidev_info *pcidev_info = NULL;
+	struct sn_irq_info *sn_irq_info = NULL;
 	size_t size;
 
+	if (sn_acpi_get_pcidev_info(dev, &pcidev_info, &sn_irq_info)) {
+		panic("%s:  Failure obtaining pcidev_info for %s\n",
+		      __FUNCTION__, pci_name(dev));
+	}
+
 	if (pcidev_info->pdi_pio_mapped_addr[PCI_ROM_RESOURCE]) {
 		/*
 		 * A valid ROM image exists and has been shadowed by the
@@ -200,8 +436,11 @@ sn_acpi_slot_fixup(struct pci_dev *dev, 
 						(unsigned long) addr + size;
 		dev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_BIOS_COPY;
 	}
+	sn_pci_fixup_slot(dev, pcidev_info, sn_irq_info);
 }
 
+EXPORT_SYMBOL(sn_acpi_slot_fixup);
+
 static struct acpi_driver acpi_sn_hubdev_driver = {
 	.name = "SGI HUBDEV Driver",
 	.ids = "SGIHUB,SGITIO",
@@ -212,6 +451,33 @@ static struct acpi_driver acpi_sn_hubdev
 
 
 /*
+ * sn_acpi_bus_fixup -  Perform SN specific setup of software structs
+ *			(pcibus_bussoft, pcidev_info) and hardware
+ *			registers, for the specified bus and devices under it.
+ */
+void
+sn_acpi_bus_fixup(struct pci_bus *bus)
+{
+	struct pci_dev *pci_dev = NULL;
+	struct pcibus_bussoft *prom_bussoft_ptr;
+
+	if (!bus->parent) {	/* If root bus */
+		prom_bussoft_ptr = sn_get_bussoft_ptr(bus);
+		if (prom_bussoft_ptr == NULL) {
+			printk(KERN_ERR
+			       "%s: 0x%04x:0x%02x Unable to "
+			       "obtain prom_bussoft_ptr\n",
+			       __FUNCTION__, pci_domain_nr(bus), bus->number);
+			return;
+		}
+		sn_common_bus_fixup(bus, prom_bussoft_ptr);
+	}
+	list_for_each_entry(pci_dev, &bus->devices, bus_list) {
+		sn_acpi_slot_fixup(pci_dev);
+	}
+}
+
+/*
  * sn_io_acpi_init - PROM has ACPI support for IO, defining at a minimum the
  *		     nodes and root buses in the DSDT. As a result, bus scanning
  *		     will be initiated by the Linux ACPI code.
Index: linux-2.6/arch/ia64/sn/kernel/io_common.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/kernel/io_common.c	2006-10-23 08:57:24.668452675 -0500
+++ linux-2.6/arch/ia64/sn/kernel/io_common.c	2006-10-26 11:04:30.120075293 -0500
@@ -26,14 +26,10 @@
 #include <linux/acpi.h>
 #include <asm/sn/sn2/sn_hwperf.h>
 #include <asm/sn/acpi.h>
+#include "acpi/acglobal.h"
 
 extern void sn_init_cpei_timer(void);
 extern void register_sn_procfs(void);
-extern void sn_acpi_bus_fixup(struct pci_bus *);
-extern void sn_bus_fixup(struct pci_bus *);
-extern void sn_acpi_slot_fixup(struct pci_dev *, struct pcidev_info *);
-extern void sn_more_slot_fixup(struct pci_dev *, struct pcidev_info *);
-extern void sn_legacy_pci_window_fixup(struct pci_controller *, u64, u64);
 extern void sn_io_acpi_init(void);
 extern void sn_io_init(void);
 
@@ -48,6 +44,9 @@ struct sysdata_el {
 
 int sn_ioif_inited;		/* SN I/O infrastructure initialized? */
 
+int sn_acpi_rev;		/* SN ACPI revision */
+EXPORT_SYMBOL_GPL(sn_acpi_rev);
+
 struct sn_pcibus_provider *sn_pci_provider[PCIIO_ASIC_MAX_TYPES];	/* indexed by asic type */
 
 /*
@@ -99,25 +98,6 @@ sal_get_device_dmaflush_list(u64 nasid, 
 }
 
 /*
- * Retrieve the pci device information given the bus and device|function number.
- */
-static inline u64
-sal_get_pcidev_info(u64 segment, u64 bus_number, u64 devfn, u64 pci_dev,
-		    u64 sn_irq_info)
-{
-	struct ia64_sal_retval ret_stuff;
-	ret_stuff.status = 0;
-	ret_stuff.v0 = 0;
-
-	SAL_CALL_NOLOCK(ret_stuff,
-			(u64) SN_SAL_IOIF_GET_PCIDEV_INFO,
-			(u64) segment, (u64) bus_number, (u64) devfn,
-			(u64) pci_dev,
-			sn_irq_info, 0, 0);
-	return ret_stuff.v0;
-}
-
-/*
  * sn_pcidev_info_get() - Retrieve the pcidev_info struct for the specified
  *			  device.
  */
@@ -249,47 +229,22 @@ void sn_pci_unfixup_slot(struct pci_dev 
 }
 
 /*
- * sn_pci_fixup_slot() - This routine sets up a slot's resources consistent
- *			 with the Linux PCI abstraction layer. Resources
- *			 acquired from our PCI provider include PIO maps
- *			 to BAR space and interrupt objects.
+ * sn_pci_fixup_slot()
  */
-void sn_pci_fixup_slot(struct pci_dev *dev)
+void sn_pci_fixup_slot(struct pci_dev *dev, struct pcidev_info *pcidev_info,
+		       struct sn_irq_info *sn_irq_info)
 {
 	int segment = pci_domain_nr(dev->bus);
-	int status = 0;
 	struct pcibus_bussoft *bs;
  	struct pci_bus *host_pci_bus;
  	struct pci_dev *host_pci_dev;
-	struct pcidev_info *pcidev_info;
- 	struct sn_irq_info *sn_irq_info;
  	unsigned int bus_no, devfn;
 
 	pci_dev_get(dev); /* for the sysdata pointer */
-	pcidev_info = kzalloc(sizeof(struct pcidev_info), GFP_KERNEL);
-	if (!pcidev_info)
-		BUG();		/* Cannot afford to run out of memory */
-
-	sn_irq_info = kzalloc(sizeof(struct sn_irq_info), GFP_KERNEL);
-	if (!sn_irq_info)
-		BUG();		/* Cannot afford to run out of memory */
-
-	/* Call to retrieve pci device information needed by kernel. */
-	status = sal_get_pcidev_info((u64) segment, (u64) dev->bus->number,
-				     dev->devfn,
-				     (u64) __pa(pcidev_info),
-				     (u64) __pa(sn_irq_info));
-	if (status)
-		BUG(); /* Cannot get platform pci device information */
 
 	/* Add pcidev_info to list in pci_controller.platform_data */
 	list_add_tail(&pcidev_info->pdi_list,
 		      &(SN_PLATFORM_DATA(dev->bus)->pcidev_info));
-
-	if (SN_ACPI_BASE_SUPPORT())
-		sn_acpi_slot_fixup(dev, pcidev_info);
-	else
-		sn_more_slot_fixup(dev, pcidev_info);
 	/*
 	 * Using the PROMs values for the PCI host bus, get the Linux
  	 * PCI host_pci_dev struct and set up host bus linkages
@@ -489,11 +444,6 @@ void sn_generate_path(struct pci_bus *pc
 			sprintf(address, "%s^%d", address, geo_slot(geoid));
 }
 
-/*
- * sn_pci_fixup_bus() - Perform SN specific setup of software structs
- *			(pcibus_bussoft, pcidev_info) and hardware
- *			registers, for the specified bus and devices under it.
- */
 void __devinit
 sn_pci_fixup_bus(struct pci_bus *bus)
 {
@@ -519,6 +469,9 @@ sn_io_early_init(void)
 	if (!ia64_platform_is("sn2") || IS_RUNNING_ON_FAKE_PROM())
 		return 0;
 
+	/* we set the acpi revision to that of the DSDT table OEM rev. */
+	sn_acpi_rev = acpi_gbl_DSDT->oem_revision;
+
 	/*
 	 * prime sn_pci_provider[].  Individial provider init routines will
 	 * override their respective default entries.
@@ -605,7 +558,6 @@ sn_io_late_init(void)
 
 fs_initcall(sn_io_late_init);
 
-EXPORT_SYMBOL(sn_pci_fixup_slot);
 EXPORT_SYMBOL(sn_pci_unfixup_slot);
 EXPORT_SYMBOL(sn_bus_store_sysdata);
 EXPORT_SYMBOL(sn_bus_free_sysdata);
Index: linux-2.6/arch/ia64/sn/kernel/io_init.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/kernel/io_init.c	2006-10-23 08:57:24.672453172 -0500
+++ linux-2.6/arch/ia64/sn/kernel/io_init.c	2006-10-23 09:16:25.245957610 -0500
@@ -56,6 +56,25 @@ static inline u64 sal_get_pcibus_info(u6
 	return ret_stuff.v0;
 }
 
+/*
+ * Retrieve the pci device information given the bus and device|function number.
+ */
+static inline u64
+sal_get_pcidev_info(u64 segment, u64 bus_number, u64 devfn, u64 pci_dev,
+		    u64 sn_irq_info)
+{
+	struct ia64_sal_retval ret_stuff;
+	ret_stuff.status = 0;
+	ret_stuff.v0 = 0;
+
+	SAL_CALL_NOLOCK(ret_stuff,
+			(u64) SN_SAL_IOIF_GET_PCIDEV_INFO,
+			(u64) segment, (u64) bus_number, (u64) devfn,
+			(u64) pci_dev,
+			sn_irq_info, 0, 0);
+	return ret_stuff.v0;
+}
+
 
 /*
  * sn_fixup_ionodes() - This routine initializes the HUB data structure for
@@ -172,18 +191,40 @@ sn_pci_window_fixup(struct pci_dev *dev,
 }
 
 /*
- * sn_more_slot_fixup() - We are not running with an ACPI capable PROM,
+ * sn_io_slot_fixup() -   We are not running with an ACPI capable PROM,
  *			  and need to convert the pci_dev->resource
  *			  'start' and 'end' addresses to mapped addresses,
  *			  and setup the pci_controller->window array entries.
  */
 void
-sn_more_slot_fixup(struct pci_dev *dev, struct pcidev_info *pcidev_info)
+sn_io_slot_fixup(struct pci_dev *dev)
 {
 	unsigned int count = 0;
 	int idx;
 	s64 pci_addrs[PCI_ROM_RESOURCE + 1];
 	unsigned long addr, end, size, start;
+	struct pcidev_info *pcidev_info;
+	struct sn_irq_info *sn_irq_info;
+	int status;
+
+	pcidev_info = kzalloc(sizeof(struct pcidev_info), GFP_KERNEL);
+	if (!pcidev_info)
+		panic("%s: Unable to alloc memory for pcidev_info", __FUNCTION__);
+
+	sn_irq_info = kzalloc(sizeof(struct sn_irq_info), GFP_KERNEL);
+	if (!sn_irq_info)
+		panic("%s: Unable to alloc memory for sn_irq_info", __FUNCTION__);
+
+	/* Call to retrieve pci device information needed by kernel. */
+	status = sal_get_pcidev_info((u64) pci_domain_nr(dev),
+		(u64) dev->bus->number,
+		dev->devfn,
+		(u64) __pa(pcidev_info),
+		(u64) __pa(sn_irq_info));
+
+	if (status)
+		BUG(); /* Cannot get platform pci device information */
+
 
 	/* Copy over PIO Mapped Addresses */
 	for (idx = 0; idx <= PCI_ROM_RESOURCE; idx++) {
@@ -219,8 +260,12 @@ sn_more_slot_fixup(struct pci_dev *dev, 
 	 */
 	if (count > 0)
 		sn_pci_window_fixup(dev, count, pci_addrs);
+
+	sn_pci_fixup_slot(dev, pcidev_info, sn_irq_info);
 }
 
+EXPORT_SYMBOL(sn_io_slot_fixup);
+
 /*
  * sn_pci_controller_fixup() - This routine sets up a bus's resources
  *			       consistent with the Linux PCI abstraction layer.
@@ -272,9 +317,6 @@ sn_bus_fixup(struct pci_bus *bus)
 {
 	struct pci_dev *pci_dev = NULL;
 	struct pcibus_bussoft *prom_bussoft_ptr;
-	extern void sn_common_bus_fixup(struct pci_bus *,
-					struct pcibus_bussoft *);
-
 
 	if (!bus->parent) {  /* If root bus */
 		prom_bussoft_ptr = PCI_CONTROLLER(bus)->platform_data;
@@ -291,7 +333,7 @@ sn_bus_fixup(struct pci_bus *bus)
 					   prom_bussoft_ptr->bs_legacy_mem);
         }
         list_for_each_entry(pci_dev, &bus->devices, bus_list) {
-                sn_pci_fixup_slot(pci_dev);
+                sn_io_slot_fixup(pci_dev);
         }
 
 }
Index: linux-2.6/arch/ia64/sn/pci/pcibr/pcibr_provider.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/pci/pcibr/pcibr_provider.c	2006-10-23 08:56:18.684259160 -0500
+++ linux-2.6/arch/ia64/sn/pci/pcibr/pcibr_provider.c	2006-10-23 09:16:25.249958106 -0500
@@ -20,7 +20,8 @@
 #include "xtalk/hubdev.h"
 
 int
-sal_pcibr_slot_enable(struct pcibus_info *soft, int device, void *resp)
+sal_pcibr_slot_enable(struct pcibus_info *soft, int device, void *resp,
+                      char **ssdt)
 {
 	struct ia64_sal_retval ret_stuff;
 	u64 busnum;
@@ -32,7 +33,8 @@ sal_pcibr_slot_enable(struct pcibus_info
 	segment = soft->pbi_buscommon.bs_persist_segment;
 	busnum = soft->pbi_buscommon.bs_persist_busnum;
 	SAL_CALL_NOLOCK(ret_stuff, (u64) SN_SAL_IOIF_SLOT_ENABLE, segment,
-			busnum, (u64) device, (u64) resp, 0, 0, 0);
+			busnum, (u64) device, (u64) resp, (u64)ia64_tpa(ssdt),
+			0, 0);
 
 	return (int)ret_stuff.v0;
 }
Index: linux-2.6/include/asm-ia64/sn/acpi.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/sn/acpi.h	2006-10-23 08:56:18.688259657 -0500
+++ linux-2.6/include/asm-ia64/sn/acpi.h	2006-10-23 09:16:25.249958106 -0500
@@ -9,8 +9,7 @@
 #ifndef _ASM_IA64_SN_ACPI_H
 #define _ASM_IA64_SN_ACPI_H
 
-#include "acpi/acglobal.h"
-
-#define SN_ACPI_BASE_SUPPORT()   (acpi_gbl_DSDT->oem_revision >= 0x20101)
+extern int sn_acpi_rev;
+#define SN_ACPI_BASE_SUPPORT()   (sn_acpi_rev >= 0x20101)
 
 #endif /* _ASM_IA64_SN_ACPI_H */
Index: linux-2.6/include/asm-ia64/sn/pcibr_provider.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/sn/pcibr_provider.h	2006-10-23 08:48:18.740640326 -0500
+++ linux-2.6/include/asm-ia64/sn/pcibr_provider.h	2006-10-23 09:16:25.249958106 -0500
@@ -142,7 +142,7 @@ extern int 		pcibr_ate_alloc(struct pcib
 extern void 		pcibr_ate_free(struct pcibus_info *, int);
 extern void 		ate_write(struct pcibus_info *, int, int, u64);
 extern int sal_pcibr_slot_enable(struct pcibus_info *soft, int device,
-				 void *resp);
+				 void *resp, char **ssdt);
 extern int sal_pcibr_slot_disable(struct pcibus_info *soft, int device,
 				  int action, void *resp);
 extern u16 sn_ioboard_to_pci_bus(struct pci_bus *pci_bus);
Index: linux-2.6/include/asm-ia64/sn/pcidev.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/sn/pcidev.h	2006-10-23 08:56:18.688259657 -0500
+++ linux-2.6/include/asm-ia64/sn/pcidev.h	2006-10-23 09:16:25.249958106 -0500
@@ -70,10 +70,16 @@ extern void sn_irq_fixup(struct pci_dev 
 			 struct sn_irq_info *sn_irq_info);
 extern void sn_irq_unfixup(struct pci_dev *pci_dev);
 extern struct pcidev_info * sn_pcidev_info_get(struct pci_dev *);
+extern void sn_bus_fixup(struct pci_bus *);
+extern void sn_acpi_bus_fixup(struct pci_bus *);
+extern void sn_common_bus_fixup(struct pci_bus *, struct pcibus_bussoft *);
 extern void sn_bus_store_sysdata(struct pci_dev *dev);
 extern void sn_bus_free_sysdata(void);
 extern void sn_generate_path(struct pci_bus *pci_bus, char *address);
-extern void sn_pci_fixup_slot(struct pci_dev *dev);
+extern void sn_io_slot_fixup(struct pci_dev *);
+extern void sn_acpi_slot_fixup(struct pci_dev *);
+extern void sn_pci_fixup_slot(struct pci_dev *dev, struct pcidev_info *,
+			      struct sn_irq_info *);
 extern void sn_pci_unfixup_slot(struct pci_dev *dev);
 extern void sn_irq_lh_init(void);
 #endif				/* _ASM_IA64_SN_PCI_PCIDEV_H */
