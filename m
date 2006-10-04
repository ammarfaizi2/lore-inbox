Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWJDVtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWJDVtp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWJDVtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:49:45 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:63379 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751171AbWJDVti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:49:38 -0400
From: John Keller <jpk@sgi.com>
To: akpm@osdl.org
Cc: linux-ia64@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, John Keller <jpk@sgi.com>
Date: Wed, 04 Oct 2006 16:49:25 -0500
Message-Id: <20061004214925.3193.26724.sendpatchset@attica.americas.sgi.com>
Subject: [PATCH 1/3] - Altix: Add initial ACPI IO support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First phase in introducing ACPI support to SN.
In this phase, when running with an ACPI capable PROM,
the DSDT will define the root busses and all SN nodes
(SGIHUB, SGITIO). An ACPI bus driver will be registered
for the node devices, with the acpi_pci_root_driver being
used for the root busses. An ACPI vendor descriptor is
now used to pass platform specific information for both
nodes and busses, eliminating the need for the current
SAL calls. Also, with ACPI support, SN fixup code is no longer
needed to initiate the PCI bus scans, as the acpi_pci_root_driver
does that.

However, to maintain backward compatibility with non-ACPI capable
PROMs, none of the current 'fixup' code can been deleted, though
much restructuring has been done. For example, the bulk of the code
in io_common.c is relocated code that is now common regardless
of what PROM is running, while io_acpi_init.c and io_init.c contain
routines specific to an ACPI or non ACPI capable PROM respectively.

A new pci bus fixup platform vector has been created to provide
a hook for invoking platform specific bus fixup from pcibios_fixup_bus().

The size of io_space[] has been increased to support systems with
large IO configurations.


Signed-off-by: John Keller <jpk@sgi.com>

---

Resend #2 - resync with TOT


 arch/ia64/pci/pci.c                     |    4 
 arch/ia64/sn/kernel/Makefile            |    5 
 arch/ia64/sn/kernel/io_acpi_init.c      |  198 ++++++
 arch/ia64/sn/kernel/io_common.c         |  612 +++++++++++++++++++++
 arch/ia64/sn/kernel/io_init.c           |  626 +++-------------------
 arch/ia64/sn/kernel/iomv.c              |   11 
 arch/ia64/sn/kernel/setup.c             |   18 
 arch/ia64/sn/kernel/tiocx.c             |    2 
 arch/ia64/sn/pci/pcibr/pcibr_provider.c |   17 
 arch/ia64/sn/pci/tioce_provider.c       |   18 
 include/asm-ia64/io.h                   |    2 
 include/asm-ia64/machvec.h              |   12 
 include/asm-ia64/machvec_sn2.h          |    2 
 include/asm-ia64/sn/acpi.h              |   16 
 include/asm-ia64/sn/pcidev.h            |   22 
 include/asm-ia64/sn/sn_feature_sets.h   |    6 
 include/asm-ia64/sn/sn_sal.h            |    1 
 17 files changed, 990 insertions(+), 582 deletions(-)


Index: linux-2.6/arch/ia64/pci/pci.c
===================================================================
--- linux-2.6.orig/arch/ia64/pci/pci.c	2006-10-04 16:15:13.823132665 -0500
+++ linux-2.6/arch/ia64/pci/pci.c	2006-10-04 16:15:17.239540873 -0500
@@ -469,10 +469,11 @@ pcibios_fixup_resources(struct pci_dev *
 	}
 }
 
-static void __devinit pcibios_fixup_device_resources(struct pci_dev *dev)
+void __devinit pcibios_fixup_device_resources(struct pci_dev *dev)
 {
 	pcibios_fixup_resources(dev, 0, PCI_BRIDGE_RESOURCES);
 }
+EXPORT_SYMBOL_GPL(pcibios_fixup_device_resources);
 
 static void __devinit pcibios_fixup_bridge_resources(struct pci_dev *dev)
 {
@@ -493,6 +494,7 @@ pcibios_fixup_bus (struct pci_bus *b)
 	}
 	list_for_each_entry(dev, &b->devices, bus_list)
 		pcibios_fixup_device_resources(dev);
+	platform_pci_fixup_bus(b);
 
 	return;
 }
Index: linux-2.6/arch/ia64/sn/kernel/io_init.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/kernel/io_init.c	2006-10-04 16:15:13.827133143 -0500
+++ linux-2.6/arch/ia64/sn/kernel/io_init.c	2006-10-04 16:15:17.243541351 -0500
@@ -3,103 +3,28 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1992 - 1997, 2000-2005 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 1992 - 1997, 2000-2006 Silicon Graphics, Inc. All rights reserved.
  */
 
-#include <linux/bootmem.h>
-#include <linux/nodemask.h>
 #include <asm/sn/types.h>
 #include <asm/sn/addrs.h>
-#include <asm/sn/sn_feature_sets.h>
-#include <asm/sn/geo.h>
 #include <asm/sn/io.h>
-#include <asm/sn/l1.h>
 #include <asm/sn/module.h>
-#include <asm/sn/pcibr_provider.h>
+#include <asm/sn/intr.h>
 #include <asm/sn/pcibus_provider_defs.h>
 #include <asm/sn/pcidev.h>
-#include <asm/sn/simulator.h>
 #include <asm/sn/sn_sal.h>
-#include <asm/sn/tioca_provider.h>
-#include <asm/sn/tioce_provider.h>
 #include "xtalk/hubdev.h"
-#include "xtalk/xwidgetdev.h"
-
-
-extern void sn_init_cpei_timer(void);
-extern void register_sn_procfs(void);
-
-static struct list_head sn_sysdata_list;
-
-/* sysdata list struct */
-struct sysdata_el {
-	struct list_head entry;
-	void *sysdata;
-};
-
-struct slab_info {
-	struct hubdev_info hubdev;
-};
-
-struct brick {
-	moduleid_t id;		/* Module ID of this module        */
-	struct slab_info slab_info[MAX_SLABS + 1];
-};
-
-int sn_ioif_inited;		/* SN I/O infrastructure initialized? */
-
-struct sn_pcibus_provider *sn_pci_provider[PCIIO_ASIC_MAX_TYPES];	/* indexed by asic type */
-
-static int max_segment_number;		 /* Default highest segment number */
-static int max_pcibus_number = 255;	/* Default highest pci bus number */
 
 /*
- * Hooks and struct for unsupported pci providers
+ * The code in this file will only be executed when running with
+ * a PROM that does _not_ have base ACPI IO support.
+ * (i.e., SN_ACPI_BASE_SUPPORT() == 0)
  */
 
-static dma_addr_t
-sn_default_pci_map(struct pci_dev *pdev, unsigned long paddr, size_t size, int type)
-{
-	return 0;
-}
-
-static void
-sn_default_pci_unmap(struct pci_dev *pdev, dma_addr_t addr, int direction)
-{
-	return;
-}
-
-static void *
-sn_default_pci_bus_fixup(struct pcibus_bussoft *soft, struct pci_controller *controller)
-{
-	return NULL;
-}
-
-static struct sn_pcibus_provider sn_pci_default_provider = {
-	.dma_map = sn_default_pci_map,
-	.dma_map_consistent = sn_default_pci_map,
-	.dma_unmap = sn_default_pci_unmap,
-	.bus_fixup = sn_default_pci_bus_fixup,
-};
-
-/*
- * Retrieve the DMA Flush List given nasid, widget, and device.
- * This list is needed to implement the WAR - Flush DMA data on PIO Reads.
- */
-static inline u64
-sal_get_device_dmaflush_list(u64 nasid, u64 widget_num, u64 device_num,
-			     u64 address)
-{
-	struct ia64_sal_retval ret_stuff;
-	ret_stuff.status = 0;
-	ret_stuff.v0 = 0;
+static int max_segment_number;		 /* Default highest segment number */
+static int max_pcibus_number = 255;	/* Default highest pci bus number */
 
-	SAL_CALL_NOLOCK(ret_stuff,
-			(u64) SN_SAL_IOIF_GET_DEVICE_DMAFLUSH_LIST,
-			(u64) nasid, (u64) widget_num,
-			(u64) device_num, (u64) address, 0, 0, 0);
-	return ret_stuff.status;
-}
 
 /*
  * Retrieve the hub device info structure for the given nasid.
@@ -131,93 +56,20 @@ static inline u64 sal_get_pcibus_info(u6
 	return ret_stuff.v0;
 }
 
-/*
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
- * sn_pcidev_info_get() - Retrieve the pcidev_info struct for the specified
- *			  device.
- */
-inline struct pcidev_info *
-sn_pcidev_info_get(struct pci_dev *dev)
-{
-	struct pcidev_info *pcidev;
-
-	list_for_each_entry(pcidev,
-			    &(SN_PCI_CONTROLLER(dev)->pcidev_info), pdi_list) {
-		if (pcidev->pdi_linux_pcidev == dev) {
-			return pcidev;
-		}
-	}
-	return NULL;
-}
-
-/* Older PROM flush WAR
- *
- * 01/16/06 -- This war will be in place until a new official PROM is released.
- * Additionally note that the struct sn_flush_device_war also has to be
- * removed from arch/ia64/sn/include/xtalk/hubdev.h
- */
-static u8 war_implemented = 0;
-
-static s64 sn_device_fixup_war(u64 nasid, u64 widget, int device,
-			       struct sn_flush_device_common *common)
-{
-	struct sn_flush_device_war *war_list;
-	struct sn_flush_device_war *dev_entry;
-	struct ia64_sal_retval isrv = {0,0,0,0};
-
-	if (!war_implemented) {
-		printk(KERN_WARNING "PROM version < 4.50 -- implementing old "
-		       "PROM flush WAR\n");
-		war_implemented = 1;
-	}
-
-	war_list = kzalloc(DEV_PER_WIDGET * sizeof(*war_list), GFP_KERNEL);
-	if (!war_list)
-		BUG();
-
-	SAL_CALL_NOLOCK(isrv, SN_SAL_IOIF_GET_WIDGET_DMAFLUSH_LIST,
-			nasid, widget, __pa(war_list), 0, 0, 0 ,0);
-	if (isrv.status)
-		panic("sn_device_fixup_war failed: %s\n",
-		      ia64_sal_strerror(isrv.status));
-
-	dev_entry = war_list + device;
-	memcpy(common,dev_entry, sizeof(*common));
-	kfree(war_list);
-
-	return isrv.status;
-}
 
 /*
- * sn_fixup_ionodes() - This routine initializes the HUB data strcuture for
- *	each node in the system.
+ * sn_fixup_ionodes() - This routine initializes the HUB data structure for
+ *			each node in the system. This function is only
+ *			executed when running with a non-ACPI capable PROM.
  */
 static void __init sn_fixup_ionodes(void)
 {
-	struct sn_flush_device_kernel *sn_flush_device_kernel;
-	struct sn_flush_device_kernel *dev_entry;
+
 	struct hubdev_info *hubdev;
 	u64 status;
 	u64 nasid;
-	int i, widget, device, size;
+	int i;
+	extern void sn_common_hubdev_init(struct hubdev_info *);
 
 	/*
 	 * Get SGI Specific HUB chipset information.
@@ -240,70 +92,47 @@ static void __init sn_fixup_ionodes(void
 			max_segment_number = hubdev->max_segment_number;
 			max_pcibus_number = hubdev->max_pcibus_number;
 		}
+		sn_common_hubdev_init(hubdev);
+	}
+}
 
-		/* Attach the error interrupt handlers */
-		if (nasid & 1)
-			ice_error_init(hubdev);
-		else
-			hub_error_init(hubdev);
-
-		for (widget = 0; widget <= HUB_WIDGET_ID_MAX; widget++)
-			hubdev->hdi_xwidget_info[widget].xwi_hubinfo = hubdev;
-
-		if (!hubdev->hdi_flush_nasid_list.widget_p)
-			continue;
-
-		size = (HUB_WIDGET_ID_MAX + 1) *
-			sizeof(struct sn_flush_device_kernel *);
-		hubdev->hdi_flush_nasid_list.widget_p =
-			kzalloc(size, GFP_KERNEL);
-		if (!hubdev->hdi_flush_nasid_list.widget_p)
+/*
+ * sn_pci_legacy_window_fixup - Create PCI controller windows for
+ *				legacy IO and MEM space. This needs to
+ *				be done here, as the PROM does not have
+ *				ACPI support defining the root buses
+ *				and their resources (_CRS),
+ */
+static void
+sn_legacy_pci_window_fixup(struct pci_controller *controller,
+			   u64 legacy_io, u64 legacy_mem)
+{
+		controller->window = kcalloc(2, sizeof(struct pci_window),
+					     GFP_KERNEL);
+		if (controller->window == NULL)
 			BUG();
-
-		for (widget = 0; widget <= HUB_WIDGET_ID_MAX; widget++) {
-			size = DEV_PER_WIDGET *
-				sizeof(struct sn_flush_device_kernel);
-			sn_flush_device_kernel = kzalloc(size, GFP_KERNEL);
-			if (!sn_flush_device_kernel)
-				BUG();
-
-			dev_entry = sn_flush_device_kernel;
-			for (device = 0; device < DEV_PER_WIDGET;
-			     device++,dev_entry++) {
-				size = sizeof(struct sn_flush_device_common);
-				dev_entry->common = kzalloc(size, GFP_KERNEL);
-				if (!dev_entry->common)
-					BUG();
-
-				if (sn_prom_feature_available(
-						       PRF_DEVICE_FLUSH_LIST))
-					status = sal_get_device_dmaflush_list(
-						     nasid, widget, device,
-						     (u64)(dev_entry->common));
-				else
-					status = sn_device_fixup_war(nasid,
-						     widget, device,
-						     dev_entry->common);
-				if (status != SALRET_OK)
-					panic("SAL call failed: %s\n",
-					      ia64_sal_strerror(status));
-
-				spin_lock_init(&dev_entry->sfdl_flush_lock);
-			}
-
-			if (sn_flush_device_kernel)
-				hubdev->hdi_flush_nasid_list.widget_p[widget] =
-						       sn_flush_device_kernel;
-	        }
-	}
+		controller->window[0].offset = legacy_io;
+		controller->window[0].resource.name = "legacy_io";
+		controller->window[0].resource.flags = IORESOURCE_IO;
+		controller->window[0].resource.start = legacy_io;
+		controller->window[0].resource.end =
+	    			controller->window[0].resource.start + 0xffff;
+		controller->window[0].resource.parent = &ioport_resource;
+		controller->window[1].offset = legacy_mem;
+		controller->window[1].resource.name = "legacy_mem";
+		controller->window[1].resource.flags = IORESOURCE_MEM;
+		controller->window[1].resource.start = legacy_mem;
+		controller->window[1].resource.end =
+	    	       controller->window[1].resource.start + (1024 * 1024) - 1;
+		controller->window[1].resource.parent = &iomem_resource;
+		controller->windows = 2;
 }
 
 /*
  * sn_pci_window_fixup() - Create a pci_window for each device resource.
- *			   Until ACPI support is added, we need this code
- *			   to setup pci_windows for use by
- *			   pcibios_bus_to_resource(),
- *			   pcibios_resource_to_bus(), etc.
+ *			   It will setup pci_windows for use by
+ *			   pcibios_bus_to_resource(), pcibios_resource_to_bus(),
+ *			   etc.
  */
 static void
 sn_pci_window_fixup(struct pci_dev *dev, unsigned int count,
@@ -342,60 +171,22 @@ sn_pci_window_fixup(struct pci_dev *dev,
 	controller->window = new_window;
 }
 
-void sn_pci_unfixup_slot(struct pci_dev *dev)
-{
-	struct pci_dev *host_pci_dev = SN_PCIDEV_INFO(dev)->host_pci_dev;
-
-	sn_irq_unfixup(dev);
-	pci_dev_put(host_pci_dev);
-	pci_dev_put(dev);
-}
-
 /*
- * sn_pci_fixup_slot() - This routine sets up a slot's resources
- * consistent with the Linux PCI abstraction layer.  Resources acquired
- * from our PCI provider include PIO maps to BAR space and interrupt
- * objects.
+ * sn_more_slot_fixup() - We are not running with an ACPI capable PROM,
+ *			  and need to convert the pci_dev->resource
+ *			  'start' and 'end' addresses to mapped addresses,
+ *			  and setup the pci_controller->window array entries.
  */
-void sn_pci_fixup_slot(struct pci_dev *dev)
+void
+sn_more_slot_fixup(struct pci_dev *dev, struct pcidev_info *pcidev_info)
 {
 	unsigned int count = 0;
 	int idx;
-	int segment = pci_domain_nr(dev->bus);
-	int status = 0;
-	struct pcibus_bussoft *bs;
- 	struct pci_bus *host_pci_bus;
- 	struct pci_dev *host_pci_dev;
-	struct pcidev_info *pcidev_info;
 	s64 pci_addrs[PCI_ROM_RESOURCE + 1];
- 	struct sn_irq_info *sn_irq_info;
- 	unsigned long size;
- 	unsigned int bus_no, devfn;
-
-	pci_dev_get(dev); /* for the sysdata pointer */
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
-
-	/* Add pcidev_info to list in sn_pci_controller struct */
-	list_add_tail(&pcidev_info->pdi_list,
-		      &(SN_PCI_CONTROLLER(dev->bus)->pcidev_info));
+	unsigned long addr, end, size, start;
 
 	/* Copy over PIO Mapped Addresses */
 	for (idx = 0; idx <= PCI_ROM_RESOURCE; idx++) {
-		unsigned long start, end, addr;
 
 		if (!pcidev_info->pdi_pio_mapped_addr[idx]) {
 			pci_addrs[idx] = -1;
@@ -425,54 +216,19 @@ void sn_pci_fixup_slot(struct pci_dev *d
 	 */
 	if (count > 0)
 		sn_pci_window_fixup(dev, count, pci_addrs);
-
-	/*
-	 * Using the PROMs values for the PCI host bus, get the Linux
- 	 * PCI host_pci_dev struct and set up host bus linkages
- 	 */
-
-	bus_no = (pcidev_info->pdi_slot_host_handle >> 32) & 0xff;
-	devfn = pcidev_info->pdi_slot_host_handle & 0xffffffff;
- 	host_pci_bus = pci_find_bus(segment, bus_no);
- 	host_pci_dev = pci_get_slot(host_pci_bus, devfn);
-
-	pcidev_info->host_pci_dev = host_pci_dev;
-	pcidev_info->pdi_linux_pcidev = dev;
-	pcidev_info->pdi_host_pcidev_info = SN_PCIDEV_INFO(host_pci_dev);
-	bs = SN_PCIBUS_BUSSOFT(dev->bus);
-	pcidev_info->pdi_pcibus_info = bs;
-
-	if (bs && bs->bs_asic_type < PCIIO_ASIC_MAX_TYPES) {
-		SN_PCIDEV_BUSPROVIDER(dev) = sn_pci_provider[bs->bs_asic_type];
-	} else {
-		SN_PCIDEV_BUSPROVIDER(dev) = &sn_pci_default_provider;
-	}
-
-	/* Only set up IRQ stuff if this device has a host bus context */
-	if (bs && sn_irq_info->irq_irq) {
-		pcidev_info->pdi_sn_irq_info = sn_irq_info;
-		dev->irq = pcidev_info->pdi_sn_irq_info->irq_irq;
-		sn_irq_fixup(dev, sn_irq_info);
-	} else {
-		pcidev_info->pdi_sn_irq_info = NULL;
-		kfree(sn_irq_info);
-	}
 }
 
 /*
  * sn_pci_controller_fixup() - This routine sets up a bus's resources
- * consistent with the Linux PCI abstraction layer.
+ *			       consistent with the Linux PCI abstraction layer.
  */
-void sn_pci_controller_fixup(int segment, int busnum, struct pci_bus *bus)
+static void
+sn_pci_controller_fixup(int segment, int busnum, struct pci_bus *bus)
 {
-	int status;
-	int nasid, cnode;
+	s64 status = 0;
 	struct pci_controller *controller;
-	struct sn_pci_controller *sn_controller;
 	struct pcibus_bussoft *prom_bussoft_ptr;
-	struct hubdev_info *hubdev_info;
-	void *provider_soft;
-	struct sn_pcibus_provider *provider;
+
 
  	status = sal_get_pcibus_info((u64) segment, (u64) busnum,
  				     (u64) ia64_tpa(&prom_bussoft_ptr));
@@ -480,261 +236,77 @@ void sn_pci_controller_fixup(int segment
 		return;		/*bus # does not exist */
 	prom_bussoft_ptr = __va(prom_bussoft_ptr);
 
-	/* Allocate a sn_pci_controller, which has a pci_controller struct
-	 * as the first member.
-	 */
-	sn_controller = kzalloc(sizeof(struct sn_pci_controller), GFP_KERNEL);
-	if (!sn_controller)
+	controller = kzalloc(sizeof(*controller), GFP_KERNEL);
+	if (!controller)
 		BUG();
-	INIT_LIST_HEAD(&sn_controller->pcidev_info);
-	controller = &sn_controller->pci_controller;
 	controller->segment = segment;
 
-	if (bus == NULL) {
- 		bus = pci_scan_bus(busnum, &pci_root_ops, controller);
- 		if (bus == NULL)
- 			goto error_return; /* error, or bus already scanned */
- 		bus->sysdata = NULL;
-	}
-
-	if (bus->sysdata)
-		goto error_return; /* sysdata already alloc'd */
-
 	/*
-	 * Per-provider fixup.  Copies the contents from prom to local
-	 * area and links SN_PCIBUS_BUSSOFT().
+	 * Temporarily save the prom_bussoft_ptr for use by sn_bus_fixup().
+	 * (platform_data will be overwritten later in sn_common_bus_fixup())
 	 */
+	controller->platform_data = prom_bussoft_ptr;
 
-	if (prom_bussoft_ptr->bs_asic_type >= PCIIO_ASIC_MAX_TYPES)
-		goto error_return; /* unsupported asic type */
-
-	if (prom_bussoft_ptr->bs_asic_type == PCIIO_ASIC_TYPE_PPB)
-		goto error_return; /* no further fixup necessary */
-
-	provider = sn_pci_provider[prom_bussoft_ptr->bs_asic_type];
-	if (provider == NULL)
-		goto error_return; /* no provider registerd for this asic */
+	bus = pci_scan_bus(busnum, &pci_root_ops, controller);
+ 	if (bus == NULL)
+ 		goto error_return; /* error, or bus already scanned */
 
 	bus->sysdata = controller;
-	if (provider->bus_fixup)
-		provider_soft = (*provider->bus_fixup) (prom_bussoft_ptr, controller);
-	else
-		provider_soft = NULL;
-
-	if (provider_soft == NULL) {
-		/* fixup failed or not applicable */
-		bus->sysdata = NULL;
-		goto error_return;
-	}
-
-	/*
-	 * Setup pci_windows for legacy IO and MEM space.
-	 * (Temporary until ACPI support is in place.)
-	 */
-	controller->window = kcalloc(2, sizeof(struct pci_window), GFP_KERNEL);
-	if (controller->window == NULL)
-		BUG();
-	controller->window[0].offset = prom_bussoft_ptr->bs_legacy_io;
-	controller->window[0].resource.name = "legacy_io";
-	controller->window[0].resource.flags = IORESOURCE_IO;
-	controller->window[0].resource.start = prom_bussoft_ptr->bs_legacy_io;
-	controller->window[0].resource.end =
-	    controller->window[0].resource.start + 0xffff;
-	controller->window[0].resource.parent = &ioport_resource;
-	controller->window[1].offset = prom_bussoft_ptr->bs_legacy_mem;
-	controller->window[1].resource.name = "legacy_mem";
-	controller->window[1].resource.flags = IORESOURCE_MEM;
-	controller->window[1].resource.start = prom_bussoft_ptr->bs_legacy_mem;
-	controller->window[1].resource.end =
-	    controller->window[1].resource.start + (1024 * 1024) - 1;
-	controller->window[1].resource.parent = &iomem_resource;
-	controller->windows = 2;
-
-	/*
-	 * Generic bus fixup goes here.  Don't reference prom_bussoft_ptr
-	 * after this point.
-	 */
-
-	PCI_CONTROLLER(bus)->platform_data = provider_soft;
-	nasid = NASID_GET(SN_PCIBUS_BUSSOFT(bus)->bs_base);
-	cnode = nasid_to_cnodeid(nasid);
-	hubdev_info = (struct hubdev_info *)(NODEPDA(cnode)->pdinfo);
-	SN_PCIBUS_BUSSOFT(bus)->bs_xwidget_info =
-	    &(hubdev_info->hdi_xwidget_info[SN_PCIBUS_BUSSOFT(bus)->bs_xid]);
-
-	/*
-	 * If the node information we obtained during the fixup phase is invalid
-	 * then set controller->node to -1 (undetermined)
-	 */
-	if (controller->node >= num_online_nodes()) {
-		struct pcibus_bussoft *b = SN_PCIBUS_BUSSOFT(bus);
 
-		printk(KERN_WARNING "Device ASIC=%u XID=%u PBUSNUM=%u"
-				    "L_IO=%lx L_MEM=%lx BASE=%lx\n",
-			b->bs_asic_type, b->bs_xid, b->bs_persist_busnum,
-			b->bs_legacy_io, b->bs_legacy_mem, b->bs_base);
-		printk(KERN_WARNING "on node %d but only %d nodes online."
-			"Association set to undetermined.\n",
-			controller->node, num_online_nodes());
-		controller->node = -1;
-	}
 	return;
 
 error_return:
 
-	kfree(sn_controller);
+	kfree(controller);
 	return;
 }
 
-void sn_bus_store_sysdata(struct pci_dev *dev)
+/*
+ * sn_bus_fixup
+ */
+void
+sn_bus_fixup(struct pci_bus *bus)
 {
-	struct sysdata_el *element;
+	struct pci_dev *pci_dev = NULL;
+	struct pcibus_bussoft *prom_bussoft_ptr;
+	extern void sn_common_bus_fixup(struct pci_bus *,
+					struct pcibus_bussoft *);
 
-	element = kzalloc(sizeof(struct sysdata_el), GFP_KERNEL);
-	if (!element) {
-		dev_dbg(dev, "%s: out of memory!\n", __FUNCTION__);
-		return;
-	}
-	element->sysdata = SN_PCIDEV_INFO(dev);
-	list_add(&element->entry, &sn_sysdata_list);
-}
 
-void sn_bus_free_sysdata(void)
-{
-	struct sysdata_el *element;
-	struct list_head *list, *safe;
+	if (!bus->parent) {  /* If root bus */
+		prom_bussoft_ptr = PCI_CONTROLLER(bus)->platform_data;
+		if (prom_bussoft_ptr == NULL) {
+			printk(KERN_ERR
+			       "sn_bus_fixup: 0x%04x:0x%02x Unable to "
+			       "obtain prom_bussoft_ptr\n",
+			       pci_domain_nr(bus), bus->number);
+			return;
+		}
+		sn_common_bus_fixup(bus, prom_bussoft_ptr);
+		sn_legacy_pci_window_fixup(PCI_CONTROLLER(bus),
+					   prom_bussoft_ptr->bs_legacy_io,
+					   prom_bussoft_ptr->bs_legacy_mem);
+        }
+        list_for_each_entry(pci_dev, &bus->devices, bus_list) {
+                sn_pci_fixup_slot(pci_dev);
+        }
 
-	list_for_each_safe(list, safe, &sn_sysdata_list) {
-		element = list_entry(list, struct sysdata_el, entry);
-		list_del(&element->entry);
-		list_del(&(((struct pcidev_info *)
-			     (element->sysdata))->pdi_list));
-		kfree(element->sysdata);
-		kfree(element);
-	}
-	return;
 }
 
 /*
- * Ugly hack to get PCI setup until we have a proper ACPI namespace.
+ * sn_io_init - PROM does not have ACPI support to define nodes or root buses,
+ *		so we need to do things the hard way, including initiating the
+ *		bus scanning ourselves.
  */
 
-#define PCI_BUSES_TO_SCAN 256
-
-static int __init sn_pci_init(void)
+void __init sn_io_init(void)
 {
 	int i, j;
-	struct pci_dev *pci_dev = NULL;
-
-	if (!ia64_platform_is("sn2") || IS_RUNNING_ON_FAKE_PROM())
-		return 0;
-
-	/*
-	 * prime sn_pci_provider[].  Individial provider init routines will
-	 * override their respective default entries.
-	 */
-
-	for (i = 0; i < PCIIO_ASIC_MAX_TYPES; i++)
-		sn_pci_provider[i] = &sn_pci_default_provider;
 
-	pcibr_init_provider();
-	tioca_init_provider();
-	tioce_init_provider();
-
-	/*
-	 * This is needed to avoid bounce limit checks in the blk layer
-	 */
-	ia64_max_iommu_merge_mask = ~PAGE_MASK;
 	sn_fixup_ionodes();
-	sn_irq_lh_init();
-	INIT_LIST_HEAD(&sn_sysdata_list);
-	sn_init_cpei_timer();
-
-#ifdef CONFIG_PROC_FS
-	register_sn_procfs();
-#endif
 
 	/* busses are not known yet ... */
 	for (i = 0; i <= max_segment_number; i++)
 		for (j = 0; j <= max_pcibus_number; j++)
 			sn_pci_controller_fixup(i, j, NULL);
-
-	/*
-	 * Generic Linux PCI Layer has created the pci_bus and pci_dev 
-	 * structures - time for us to add our SN PLatform specific 
-	 * information.
-	 */
-
-	while ((pci_dev =
-		pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pci_dev)) != NULL)
-		sn_pci_fixup_slot(pci_dev);
-
-	sn_ioif_inited = 1;	/* sn I/O infrastructure now initialized */
-
-	return 0;
 }
-
-/*
- * hubdev_init_node() - Creates the HUB data structure and link them to it's 
- *	own NODE specific data area.
- */
-void hubdev_init_node(nodepda_t * npda, cnodeid_t node)
-{
-	struct hubdev_info *hubdev_info;
-	int size;
-	pg_data_t *pg;
-
-	size = sizeof(struct hubdev_info);
-
-	if (node >= num_online_nodes())	/* Headless/memless IO nodes */
-		pg = NODE_DATA(0);
-	else
-		pg = NODE_DATA(node);
-
-	hubdev_info = (struct hubdev_info *)alloc_bootmem_node(pg, size);
-
-	npda->pdinfo = (void *)hubdev_info;
-}
-
-geoid_t
-cnodeid_get_geoid(cnodeid_t cnode)
-{
-	struct hubdev_info *hubdev;
-
-	hubdev = (struct hubdev_info *)(NODEPDA(cnode)->pdinfo);
-	return hubdev->hdi_geoid;
-}
-
-void sn_generate_path(struct pci_bus *pci_bus, char *address)
-{
-	nasid_t nasid;
-	cnodeid_t cnode;
-	geoid_t geoid;
-	moduleid_t moduleid;
-	u16 bricktype;
-
-	nasid = NASID_GET(SN_PCIBUS_BUSSOFT(pci_bus)->bs_base);
-	cnode = nasid_to_cnodeid(nasid);
-	geoid = cnodeid_get_geoid(cnode);
-	moduleid = geo_module(geoid);
-
-	sprintf(address, "module_%c%c%c%c%.2d",
-		'0'+RACK_GET_CLASS(MODULE_GET_RACK(moduleid)),
-		'0'+RACK_GET_GROUP(MODULE_GET_RACK(moduleid)),
-		'0'+RACK_GET_NUM(MODULE_GET_RACK(moduleid)),
-		MODULE_GET_BTCHAR(moduleid), MODULE_GET_BPOS(moduleid));
-
-	/* Tollhouse requires slot id to be displayed */
-	bricktype = MODULE_GET_BTYPE(moduleid);
-	if ((bricktype == L1_BRICKTYPE_191010) ||
-	    (bricktype == L1_BRICKTYPE_1932))
-			sprintf(address, "%s^%d", address, geo_slot(geoid));
-}
-
-subsys_initcall(sn_pci_init);
-EXPORT_SYMBOL(sn_pci_fixup_slot);
-EXPORT_SYMBOL(sn_pci_unfixup_slot);
-EXPORT_SYMBOL(sn_pci_controller_fixup);
-EXPORT_SYMBOL(sn_bus_store_sysdata);
-EXPORT_SYMBOL(sn_bus_free_sysdata);
-EXPORT_SYMBOL(sn_generate_path);
Index: linux-2.6/arch/ia64/sn/kernel/iomv.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/kernel/iomv.c	2006-10-04 16:15:13.827133143 -0500
+++ linux-2.6/arch/ia64/sn/kernel/iomv.c	2006-10-04 16:15:17.243541351 -0500
@@ -3,10 +3,11 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2000-2003 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 2000-2003, 2006 Silicon Graphics, Inc. All rights reserved.
  */
 
 #include <linux/module.h>
+#include <linux/acpi.h>
 #include <asm/io.h>
 #include <asm/delay.h>
 #include <asm/vga.h>
@@ -15,6 +16,7 @@
 #include <asm/sn/pda.h>
 #include <asm/sn/sn_cpuid.h>
 #include <asm/sn/shub_mmr.h>
+#include <asm/sn/acpi.h>
 
 #define IS_LEGACY_VGA_IOPORT(p) \
 	(((p) >= 0x3b0 && (p) <= 0x3bb) || ((p) >= 0x3c0 && (p) <= 0x3df))
@@ -31,11 +33,14 @@ void *sn_io_addr(unsigned long port)
 {
 	if (!IS_RUNNING_ON_SIMULATOR()) {
 		if (IS_LEGACY_VGA_IOPORT(port))
-			port += vga_console_iobase;
+			return (__ia64_mk_io_addr(port));
 		/* On sn2, legacy I/O ports don't point at anything */
 		if (port < (64 * 1024))
 			return NULL;
-		return ((void *)(port | __IA64_UNCACHED_OFFSET));
+		if (SN_ACPI_BASE_SUPPORT())
+			return (__ia64_mk_io_addr(port));
+		else
+			return ((void *)(port | __IA64_UNCACHED_OFFSET));
 	} else {
 		/* but the simulator uses them... */
 		unsigned long addr;
Index: linux-2.6/arch/ia64/sn/kernel/setup.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/kernel/setup.c	2006-10-04 16:15:13.827133143 -0500
+++ linux-2.6/arch/ia64/sn/kernel/setup.c	2006-10-04 16:15:17.243541351 -0500
@@ -389,6 +389,14 @@ void __init sn_setup(char **cmdline_p)
 	ia64_sn_plat_set_error_handling_features();	// obsolete
 	ia64_sn_set_os_feature(OSF_MCA_SLV_TO_OS_INIT_SLV);
 	ia64_sn_set_os_feature(OSF_FEAT_LOG_SBES);
+	/*
+	 * Note: The calls to notify the PROM of ACPI and PCI Segment
+	 *	 support must be done prior to acpi_load_tables(), as
+	 *	 an ACPI capable PROM will rebuild the DSDT as result
+	 *	 of the call.
+	 */
+	ia64_sn_set_os_feature(OSF_PCISEGMENT_ENABLE);
+	ia64_sn_set_os_feature(OSF_ACPI_ENABLE);
 
 
 #if defined(CONFIG_VT) && defined(CONFIG_VGA_CONSOLE)
@@ -414,6 +422,16 @@ void __init sn_setup(char **cmdline_p)
 	if (! vga_console_membase)
 		sn_scan_pcdp();
 
+	/*
+	 *	Setup legacy IO space.
+	 *	vga_console_iobase maps to PCI IO Space address 0 on the
+	 * 	bus containing the VGA console.
+	 */
+	if (vga_console_iobase) {
+		io_space[0].mmio_base = vga_console_iobase;
+		io_space[0].sparse = 0;
+	}
+
 	if (vga_console_membase) {
 		/* usable vga ... make tty0 the preferred default console */
 		if (!strstr(*cmdline_p, "console="))
Index: linux-2.6/arch/ia64/sn/kernel/tiocx.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/kernel/tiocx.c	2006-10-04 16:15:13.827133143 -0500
+++ linux-2.6/arch/ia64/sn/kernel/tiocx.c	2006-10-04 16:15:17.243541351 -0500
@@ -552,7 +552,7 @@ static void __exit tiocx_exit(void)
 	bus_unregister(&tiocx_bus_type);
 }
 
-subsys_initcall(tiocx_init);
+fs_initcall(tiocx_init);
 module_exit(tiocx_exit);
 
 /************************************************************************
Index: linux-2.6/arch/ia64/sn/pci/pcibr/pcibr_provider.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/pci/pcibr/pcibr_provider.c	2006-10-04 16:15:13.827133143 -0500
+++ linux-2.6/arch/ia64/sn/pci/pcibr/pcibr_provider.c	2006-10-04 16:15:17.247541829 -0500
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2001-2004 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 2001-2004, 2006 Silicon Graphics, Inc. All rights reserved.
  */
 
 #include <linux/interrupt.h>
@@ -109,7 +109,6 @@ void *
 pcibr_bus_fixup(struct pcibus_bussoft *prom_bussoft, struct pci_controller *controller)
 {
 	int nasid, cnode, j;
-	cnodeid_t near_cnode;
 	struct hubdev_info *hubdev_info;
 	struct pcibus_info *soft;
 	struct sn_flush_device_kernel *sn_flush_device_kernel;
@@ -186,20 +185,6 @@ pcibr_bus_fixup(struct pcibus_bussoft *p
 		return NULL;
 	}
 
-	if (prom_bussoft->bs_asic_type == PCIIO_ASIC_TYPE_TIOCP) {
-		/* TIO PCI Bridge: find nearest node with CPUs */
-		int e = sn_hwperf_get_nearest_node(cnode, NULL, &near_cnode);
-
-		if (e < 0) {
-			near_cnode = (cnodeid_t)-1; /* use any node */
-			printk(KERN_WARNING "pcibr_bus_fixup: failed to find "
-				"near node with CPUs to TIO node %d, err=%d\n",
-				cnode, e);
-		}
-		controller->node = near_cnode;
-	}
-	else
-		controller->node = cnode;
 	return soft;
 }
 
Index: linux-2.6/include/asm-ia64/machvec.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/machvec.h	2006-10-04 16:15:13.827133143 -0500
+++ linux-2.6/include/asm-ia64/machvec.h	2006-10-04 16:15:17.247541829 -0500
@@ -36,6 +36,7 @@ typedef int ia64_mv_pci_legacy_read_t (s
 typedef int ia64_mv_pci_legacy_write_t (struct pci_bus *, u16 port, u32 val,
 					u8 size);
 typedef void ia64_mv_migrate_t(struct task_struct * task);
+typedef void ia64_mv_pci_fixup_bus_t (struct pci_bus *);
 
 /* DMA-mapping interface: */
 typedef void ia64_mv_dma_init (void);
@@ -95,6 +96,11 @@ machvec_noop_task (struct task_struct *t
 {
 }
 
+static inline void
+machvec_noop_bus (struct pci_bus *bus)
+{
+}
+
 extern void machvec_setup (char **);
 extern void machvec_timer_interrupt (int, void *, struct pt_regs *);
 extern void machvec_dma_sync_single (struct device *, dma_addr_t, size_t, int);
@@ -159,6 +165,7 @@ extern void machvec_tlb_migrate_finish (
 #  define platform_migrate		ia64_mv.migrate
 #  define platform_setup_msi_irq	ia64_mv.setup_msi_irq
 #  define platform_teardown_msi_irq	ia64_mv.teardown_msi_irq
+#  define platform_pci_fixup_bus	ia64_mv.pci_fixup_bus
 # endif
 
 /* __attribute__((__aligned__(16))) is required to make size of the
@@ -210,6 +217,7 @@ struct ia64_machine_vector {
 	ia64_mv_migrate_t *migrate;
 	ia64_mv_setup_msi_irq_t *setup_msi_irq;
 	ia64_mv_teardown_msi_irq_t *teardown_msi_irq;
+	ia64_mv_pci_fixup_bus_t *pci_fixup_bus;
 } __attribute__((__aligned__(16))); /* align attrib? see above comment */
 
 #define MACHVEC_INIT(name)			\
@@ -257,6 +265,7 @@ struct ia64_machine_vector {
 	platform_migrate,			\
 	platform_setup_msi_irq,			\
 	platform_teardown_msi_irq,		\
+	platform_pci_fixup_bus,			\
 }
 
 extern struct ia64_machine_vector ia64_mv;
@@ -416,5 +425,8 @@ extern int ia64_pci_legacy_write(struct 
 #ifndef platform_teardown_msi_irq
 # define platform_teardown_msi_irq	((ia64_mv_teardown_msi_irq_t*)NULL)
 #endif
+#ifndef platform_pci_fixup_bus
+# define platform_pci_fixup_bus	machvec_noop_bus
+#endif
 
 #endif /* _ASM_IA64_MACHVEC_H */
Index: linux-2.6/include/asm-ia64/machvec_sn2.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/machvec_sn2.h	2006-10-04 16:15:13.827133143 -0500
+++ linux-2.6/include/asm-ia64/machvec_sn2.h	2006-10-04 16:15:17.247541829 -0500
@@ -69,6 +69,7 @@ extern ia64_mv_dma_supported		sn_dma_sup
 extern ia64_mv_migrate_t		sn_migrate;
 extern ia64_mv_setup_msi_irq_t		sn_setup_msi_irq;
 extern ia64_mv_teardown_msi_irq_t	sn_teardown_msi_irq;
+extern ia64_mv_pci_fixup_bus_t		sn_pci_fixup_bus;
 
 
 /*
@@ -127,6 +128,7 @@ extern ia64_mv_teardown_msi_irq_t	sn_tea
 #define platform_setup_msi_irq		((ia64_mv_setup_msi_irq_t*)NULL)
 #define platform_teardown_msi_irq	((ia64_mv_teardown_msi_irq_t*)NULL)
 #endif
+#define platform_pci_fixup_bus		sn_pci_fixup_bus
 
 #include <asm/sn/io.h>
 
Index: linux-2.6/include/asm-ia64/sn/acpi.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/include/asm-ia64/sn/acpi.h	2006-10-04 16:15:17.247541829 -0500
@@ -0,0 +1,16 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006 Silicon Graphics, Inc. All rights reserved.
+ */
+
+#ifndef _ASM_IA64_SN_ACPI_H
+#define _ASM_IA64_SN_ACPI_H
+
+#include "acpi/acglobal.h"
+
+#define SN_ACPI_BASE_SUPPORT()   (acpi_gbl_DSDT->oem_revision >= 0x20101)
+
+#endif /* _ASM_IA64_SN_ACPI_H */
Index: linux-2.6/include/asm-ia64/sn/sn_feature_sets.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/sn/sn_feature_sets.h	2006-10-04 16:15:13.827133143 -0500
+++ linux-2.6/include/asm-ia64/sn/sn_feature_sets.h	2006-10-04 16:15:17.251542307 -0500
@@ -44,8 +44,14 @@ extern int sn_prom_feature_available(int
  * Once enabled, a feature cannot be disabled.
  *
  * By default, features are disabled unless explicitly enabled.
+ *
+ * These defines must be kept in sync with the corresponding
+ * PROM definitions in feature_sets.h.
  */
 #define  OSF_MCA_SLV_TO_OS_INIT_SLV	0
 #define  OSF_FEAT_LOG_SBES		1
+#define  OSF_ACPI_ENABLE		2
+#define  OSF_PCISEGMENT_ENABLE		3
+
 
 #endif /* _ASM_IA64_SN_FEATURE_SETS_H */
Index: linux-2.6/include/asm-ia64/sn/sn_sal.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/sn/sn_sal.h	2006-10-04 16:15:13.827133143 -0500
+++ linux-2.6/include/asm-ia64/sn/sn_sal.h	2006-10-04 16:15:17.251542307 -0500
@@ -77,6 +77,7 @@
 #define  SN_SAL_IOIF_GET_WIDGET_DMAFLUSH_LIST	   0x02000058	// deprecated
 #define  SN_SAL_IOIF_GET_DEVICE_DMAFLUSH_LIST	   0x0200005a
 
+#define SN_SAL_IOIF_INIT			   0x0200005f
 #define SN_SAL_HUB_ERROR_INTERRUPT		   0x02000060
 #define SN_SAL_BTE_RECOVER			   0x02000061
 #define SN_SAL_RESERVED_DO_NOT_USE		   0x02000062
Index: linux-2.6/include/asm-ia64/sn/pcidev.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/sn/pcidev.h	2006-10-04 16:15:13.827133143 -0500
+++ linux-2.6/include/asm-ia64/sn/pcidev.h	2006-10-04 16:15:17.251542307 -0500
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1992 - 1997, 2000-2005 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 1992 - 1997, 2000-2006 Silicon Graphics, Inc. All rights reserved.
  */
 #ifndef _ASM_IA64_SN_PCI_PCIDEV_H
 #define _ASM_IA64_SN_PCI_PCIDEV_H
@@ -12,31 +12,29 @@
 
 /*
  * In ia64, pci_dev->sysdata must be a *pci_controller. To provide access to
- * the pcidev_info structs for all devices under a controller, we extend the
- * definition of pci_controller, via sn_pci_controller, to include a list
- * of pcidev_info.
+ * the pcidev_info structs for all devices under a controller, we keep a
+ * list of pcidev_info under pci_controller->platform_data.
  */
-struct sn_pci_controller {
-	struct pci_controller pci_controller;
+struct sn_platform_data {
+	void *provider_soft;
 	struct list_head pcidev_info;
 };
 
-#define SN_PCI_CONTROLLER(dev) ((struct sn_pci_controller *) dev->sysdata)
+#define SN_PLATFORM_DATA(busdev) \
+	((struct sn_platform_data *)(PCI_CONTROLLER(busdev)->platform_data))
 
 #define SN_PCIDEV_INFO(dev)	sn_pcidev_info_get(dev)
 
-#define SN_PCIBUS_BUSSOFT_INFO(pci_bus) \
-	(struct pcibus_info *)((struct pcibus_bussoft *)(PCI_CONTROLLER((pci_bus))->platform_data))
 /*
  * Given a pci_bus, return the sn pcibus_bussoft struct.  Note that
  * this only works for root busses, not for busses represented by PPB's.
  */
 
 #define SN_PCIBUS_BUSSOFT(pci_bus) \
-        ((struct pcibus_bussoft *)(PCI_CONTROLLER((pci_bus))->platform_data))
+	((struct pcibus_bussoft *)(SN_PLATFORM_DATA(pci_bus)->provider_soft))
 
 #define SN_PCIBUS_BUSSOFT_INFO(pci_bus) \
-	(struct pcibus_info *)((struct pcibus_bussoft *)(PCI_CONTROLLER((pci_bus))->platform_data))
+	((struct pcibus_info *)(SN_PLATFORM_DATA(pci_bus)->provider_soft))
 /*
  * Given a struct pci_dev, return the sn pcibus_bussoft struct.  Note
  * that this is not equivalent to SN_PCIBUS_BUSSOFT(pci_dev->bus) due
@@ -72,8 +70,6 @@ extern void sn_irq_fixup(struct pci_dev 
 			 struct sn_irq_info *sn_irq_info);
 extern void sn_irq_unfixup(struct pci_dev *pci_dev);
 extern struct pcidev_info * sn_pcidev_info_get(struct pci_dev *);
-extern void sn_pci_controller_fixup(int segment, int busnum,
- 				    struct pci_bus *bus);
 extern void sn_bus_store_sysdata(struct pci_dev *dev);
 extern void sn_bus_free_sysdata(void);
 extern void sn_generate_path(struct pci_bus *pci_bus, char *address);
Index: linux-2.6/include/asm-ia64/io.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/io.h	2006-10-04 16:15:13.831133621 -0500
+++ linux-2.6/include/asm-ia64/io.h	2006-10-04 16:15:17.251542307 -0500
@@ -32,7 +32,7 @@
  */
 #define IO_SPACE_LIMIT		0xffffffffffffffffUL
 
-#define MAX_IO_SPACES_BITS		4
+#define MAX_IO_SPACES_BITS		8
 #define MAX_IO_SPACES			(1UL << MAX_IO_SPACES_BITS)
 #define IO_SPACE_BITS			24
 #define IO_SPACE_SIZE			(1UL << IO_SPACE_BITS)
Index: linux-2.6/arch/ia64/sn/pci/tioce_provider.c
===================================================================
--- linux-2.6.orig/arch/ia64/sn/pci/tioce_provider.c	2006-10-04 16:15:13.827133143 -0500
+++ linux-2.6/arch/ia64/sn/pci/tioce_provider.c	2006-10-04 16:15:17.251542307 -0500
@@ -15,7 +15,6 @@
 #include <asm/sn/pcidev.h>
 #include <asm/sn/pcibus_provider_defs.h>
 #include <asm/sn/tioce_provider.h>
-#include <asm/sn/sn2/sn_hwperf.h>
 
 /*
  * 1/26/2006
@@ -991,8 +990,6 @@ tioce_target_interrupt(struct sn_irq_inf
 static void *
 tioce_bus_fixup(struct pcibus_bussoft *prom_bussoft, struct pci_controller *controller)
 {
-	int my_nasid;
-	cnodeid_t my_cnode, mem_cnode;
 	struct tioce_common *tioce_common;
 	struct tioce_kernel *tioce_kern;
 	struct tioce *tioce_mmr;
@@ -1036,21 +1033,6 @@ tioce_bus_fixup(struct pcibus_bussoft *p
 		       tioce_common->ce_pcibus.bs_persist_segment,
 		       tioce_common->ce_pcibus.bs_persist_busnum);
 
-	/*
-	 * identify closest nasid for memory allocations
-	 */
-
-	my_nasid = NASID_GET(tioce_common->ce_pcibus.bs_base);
-	my_cnode = nasid_to_cnodeid(my_nasid);
-
-	if (sn_hwperf_get_nearest_node(my_cnode, &mem_cnode, NULL) < 0) {
-		printk(KERN_WARNING "tioce_bus_fixup: failed to find "
-		       "closest node with MEM to TIO node %d\n", my_cnode);
-		mem_cnode = (cnodeid_t)-1; /* use any node */
-	}
-
-	controller->node = mem_cnode;
-
 	return tioce_common;
 }
 
Index: linux-2.6/arch/ia64/sn/kernel/Makefile
===================================================================
--- linux-2.6.orig/arch/ia64/sn/kernel/Makefile	2006-10-04 16:15:13.827133143 -0500
+++ linux-2.6/arch/ia64/sn/kernel/Makefile	2006-10-04 16:15:17.251542307 -0500
@@ -4,13 +4,14 @@
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
 #
-# Copyright (C) 1999,2001-2005 Silicon Graphics, Inc.  All Rights Reserved.
+# Copyright (C) 1999,2001-2006 Silicon Graphics, Inc.  All Rights Reserved.
 #
 
 CPPFLAGS += -I$(srctree)/arch/ia64/sn/include
 
 obj-y				+= setup.o bte.o bte_error.o irq.o mca.o idle.o \
-				   huberror.o io_init.o iomv.o klconflib.o pio_phys.o \
+				   huberror.o io_acpi_init.o io_common.o \
+				   io_init.o iomv.o klconflib.o pio_phys.o \
 				   sn2/
 obj-$(CONFIG_IA64_GENERIC)      += machvec.o
 obj-$(CONFIG_SGI_TIOCX)		+= tiocx.o
Index: linux-2.6/arch/ia64/sn/kernel/io_acpi_init.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/ia64/sn/kernel/io_acpi_init.c	2006-10-04 16:15:17.255542785 -0500
@@ -0,0 +1,198 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006 Silicon Graphics, Inc. All rights reserved.
+ */
+
+#include <asm/sn/types.h>
+#include <asm/sn/addrs.h>
+#include <asm/sn/pcidev.h>
+#include <asm/sn/pcibus_provider_defs.h>
+#include <asm/sn/sn_sal.h>
+#include "xtalk/hubdev.h"
+#include <linux/acpi.h>
+
+
+/*
+ * The code in this file will only be executed when running with
+ * a PROM that has ACPI IO support. (i.e., SN_ACPI_BASE_SUPPORT() == 1)
+ */
+
+
+/*
+ * This value must match the UUID the PROM uses
+ * (io/acpi/defblk.c) when building a vendor descriptor.
+ */
+struct acpi_vendor_uuid sn_uuid = {
+	.subtype = 0,
+	.data	= { 0x2c, 0xc6, 0xa6, 0xfe, 0x9c, 0x44, 0xda, 0x11,
+		    0xa2, 0x7c, 0x08, 0x00, 0x69, 0x13, 0xea, 0x51 },
+};
+
+/*
+ * Perform the early IO init in PROM.
+ */
+static s64
+sal_ioif_init(u64 *result)
+{
+	struct ia64_sal_retval isrv = {0,0,0,0};
+
+	SAL_CALL_NOLOCK(isrv,
+			SN_SAL_IOIF_INIT, 0, 0, 0, 0, 0, 0, 0);
+	*result = isrv.v0;
+	return isrv.status;
+}
+
+/*
+ * sn_hubdev_add - The 'add' function of the acpi_sn_hubdev_driver.
+ *		   Called for every "SGIHUB" or "SGITIO" device defined
+ *		   in the ACPI namespace.
+ */
+static int __init
+sn_hubdev_add(struct acpi_device *device)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	u64 addr;
+	struct hubdev_info *hubdev;
+	struct hubdev_info *hubdev_ptr;
+	int i;
+	u64 nasid;
+	struct acpi_resource *resource;
+	int ret = 0;
+	acpi_status status;
+	struct acpi_resource_vendor_typed *vendor;
+	extern void sn_common_hubdev_init(struct hubdev_info *);
+
+	status = acpi_get_vendor_resource(device->handle, METHOD_NAME__CRS,
+					  &sn_uuid, &buffer);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR
+		       "sn_hubdev_add: acpi_get_vendor_resource() failed: %d\n",
+		        status);
+		return 1;
+	}
+
+	resource = buffer.pointer;
+	vendor = &resource->data.vendor_typed;
+	if ((vendor->byte_length - sizeof(struct acpi_vendor_uuid)) !=
+	    sizeof(struct hubdev_info *)) {
+		printk(KERN_ERR
+		       "sn_hubdev_add: Invalid vendor data length: %d\n",
+		        vendor->byte_length);
+		ret = 1;
+		goto exit;
+	}
+
+	memcpy(&addr, vendor->byte_data, sizeof(struct hubdev_info *));
+	hubdev_ptr = __va((struct hubdev_info *) addr);
+
+	nasid = hubdev_ptr->hdi_nasid;
+	i = nasid_to_cnodeid(nasid);
+	hubdev = (struct hubdev_info *)(NODEPDA(i)->pdinfo);
+	*hubdev = *hubdev_ptr;
+	sn_common_hubdev_init(hubdev);
+
+exit:
+	kfree(buffer.pointer);
+	return ret;
+}
+
+/*
+ * sn_get_bussoft_ptr() - The pcibus_bussoft pointer is found in
+ *			  the ACPI Vendor resource for this bus.
+ */
+static struct pcibus_bussoft *
+sn_get_bussoft_ptr(struct pci_bus *bus)
+{
+	u64 addr;
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_handle handle;
+	struct pcibus_bussoft *prom_bussoft_ptr;
+	struct acpi_resource *resource;
+	acpi_status status;
+	struct acpi_resource_vendor_typed *vendor;
+
+
+	handle = PCI_CONTROLLER(bus)->acpi_handle;
+	status = acpi_get_vendor_resource(handle, METHOD_NAME__CRS,
+					  &sn_uuid, &buffer);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR "get_acpi_pcibus_ptr: "
+		       "get_acpi_bussoft_info() failed: %d\n",
+		       status);
+		return NULL;
+	}
+	resource = buffer.pointer;
+	vendor = &resource->data.vendor_typed;
+
+	if ((vendor->byte_length - sizeof(struct acpi_vendor_uuid)) !=
+	     sizeof(struct pcibus_bussoft *)) {
+		printk(KERN_ERR
+		       "get_acpi_bussoft_ptr: Invalid vendor data "
+		       "length %d\n", vendor->byte_length);
+		kfree(buffer.pointer);
+		return NULL;
+	}
+	memcpy(&addr, vendor->byte_data, sizeof(struct pcibus_bussoft *));
+	prom_bussoft_ptr = __va((struct pcibus_bussoft *) addr);
+	kfree(buffer.pointer);
+
+	return prom_bussoft_ptr;
+}
+
+/*
+ * sn_acpi_bus_fixup
+ */
+void
+sn_acpi_bus_fixup(struct pci_bus *bus)
+{
+	struct pci_dev *pci_dev = NULL;
+	struct pcibus_bussoft *prom_bussoft_ptr;
+	extern void sn_common_bus_fixup(struct pci_bus *,
+					struct pcibus_bussoft *);
+
+	if (!bus->parent) {	/* If root bus */
+		prom_bussoft_ptr = sn_get_bussoft_ptr(bus);
+		if (prom_bussoft_ptr == NULL) {
+			printk(KERN_ERR
+			       "sn_pci_fixup_bus: 0x%04x:0x%02x Unable to "
+			       "obtain prom_bussoft_ptr\n",
+			       pci_domain_nr(bus), bus->number);
+			return;
+		}
+		sn_common_bus_fixup(bus, prom_bussoft_ptr);
+	}
+	list_for_each_entry(pci_dev, &bus->devices, bus_list) {
+		sn_pci_fixup_slot(pci_dev);
+	}
+}
+
+static struct acpi_driver acpi_sn_hubdev_driver = {
+	.name = "SGI HUBDEV Driver",
+	.ids = "SGIHUB,SGITIO",
+	.ops = {
+		.add = sn_hubdev_add,
+		},
+};
+
+
+/*
+ * sn_io_acpi_init - PROM has ACPI support for IO, defining at a minimum the
+ *		     nodes and root buses in the DSDT. As a result, bus scanning
+ *		     will be initiated by the Linux ACPI code.
+ */
+
+void __init
+sn_io_acpi_init(void)
+{
+	u64 result;
+	s64 status;
+
+	acpi_bus_register_driver(&acpi_sn_hubdev_driver);
+	status = sal_ioif_init(&result);
+	if (status || result)
+		panic("sal_ioif_init failed: [%lx] %s\n",
+		      status, ia64_sal_strerror(status));
+}
Index: linux-2.6/arch/ia64/sn/kernel/io_common.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/ia64/sn/kernel/io_common.c	2006-10-04 16:15:17.255542785 -0500
@@ -0,0 +1,612 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2006 Silicon Graphics, Inc. All rights reserved.
+ */
+
+#include <linux/bootmem.h>
+#include <asm/sn/types.h>
+#include <asm/sn/addrs.h>
+#include <asm/sn/sn_feature_sets.h>
+#include <asm/sn/geo.h>
+#include <asm/sn/io.h>
+#include <asm/sn/l1.h>
+#include <asm/sn/module.h>
+#include <asm/sn/pcibr_provider.h>
+#include <asm/sn/pcibus_provider_defs.h>
+#include <asm/sn/pcidev.h>
+#include <asm/sn/simulator.h>
+#include <asm/sn/sn_sal.h>
+#include <asm/sn/tioca_provider.h>
+#include <asm/sn/tioce_provider.h>
+#include "xtalk/hubdev.h"
+#include "xtalk/xwidgetdev.h"
+#include <linux/acpi.h>
+#include <asm/sn/sn2/sn_hwperf.h>
+#include <asm/sn/acpi.h>
+
+extern void sn_init_cpei_timer(void);
+extern void register_sn_procfs(void);
+extern void sn_acpi_bus_fixup(struct pci_bus *);
+extern void sn_bus_fixup(struct pci_bus *);
+extern void sn_acpi_slot_fixup(struct pci_dev *, struct pcidev_info *);
+extern void sn_more_slot_fixup(struct pci_dev *, struct pcidev_info *);
+extern void sn_legacy_pci_window_fixup(struct pci_controller *, u64, u64);
+extern void sn_io_acpi_init(void);
+extern void sn_io_init(void);
+
+
+static struct list_head sn_sysdata_list;
+
+/* sysdata list struct */
+struct sysdata_el {
+	struct list_head entry;
+	void *sysdata;
+};
+
+int sn_ioif_inited;		/* SN I/O infrastructure initialized? */
+
+struct sn_pcibus_provider *sn_pci_provider[PCIIO_ASIC_MAX_TYPES];	/* indexed by asic type */
+
+/*
+ * Hooks and struct for unsupported pci providers
+ */
+
+static dma_addr_t
+sn_default_pci_map(struct pci_dev *pdev, unsigned long paddr, size_t size, int type)
+{
+	return 0;
+}
+
+static void
+sn_default_pci_unmap(struct pci_dev *pdev, dma_addr_t addr, int direction)
+{
+	return;
+}
+
+static void *
+sn_default_pci_bus_fixup(struct pcibus_bussoft *soft, struct pci_controller *controller)
+{
+	return NULL;
+}
+
+static struct sn_pcibus_provider sn_pci_default_provider = {
+	.dma_map = sn_default_pci_map,
+	.dma_map_consistent = sn_default_pci_map,
+	.dma_unmap = sn_default_pci_unmap,
+	.bus_fixup = sn_default_pci_bus_fixup,
+};
+
+/*
+ * Retrieve the DMA Flush List given nasid, widget, and device.
+ * This list is needed to implement the WAR - Flush DMA data on PIO Reads.
+ */
+static inline u64
+sal_get_device_dmaflush_list(u64 nasid, u64 widget_num, u64 device_num,
+			     u64 address)
+{
+	struct ia64_sal_retval ret_stuff;
+	ret_stuff.status = 0;
+	ret_stuff.v0 = 0;
+
+	SAL_CALL_NOLOCK(ret_stuff,
+			(u64) SN_SAL_IOIF_GET_DEVICE_DMAFLUSH_LIST,
+			(u64) nasid, (u64) widget_num,
+			(u64) device_num, (u64) address, 0, 0, 0);
+	return ret_stuff.status;
+}
+
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
+/*
+ * sn_pcidev_info_get() - Retrieve the pcidev_info struct for the specified
+ *			  device.
+ */
+inline struct pcidev_info *
+sn_pcidev_info_get(struct pci_dev *dev)
+{
+	struct pcidev_info *pcidev;
+
+	list_for_each_entry(pcidev,
+			    &(SN_PLATFORM_DATA(dev)->pcidev_info), pdi_list) {
+		if (pcidev->pdi_linux_pcidev == dev)
+			return pcidev;
+	}
+	return NULL;
+}
+
+/* Older PROM flush WAR
+ *
+ * 01/16/06 -- This war will be in place until a new official PROM is released.
+ * Additionally note that the struct sn_flush_device_war also has to be
+ * removed from arch/ia64/sn/include/xtalk/hubdev.h
+ */
+static u8 war_implemented = 0;
+
+static s64 sn_device_fixup_war(u64 nasid, u64 widget, int device,
+			       struct sn_flush_device_common *common)
+{
+	struct sn_flush_device_war *war_list;
+	struct sn_flush_device_war *dev_entry;
+	struct ia64_sal_retval isrv = {0,0,0,0};
+
+	if (!war_implemented) {
+		printk(KERN_WARNING "PROM version < 4.50 -- implementing old "
+		       "PROM flush WAR\n");
+		war_implemented = 1;
+	}
+
+	war_list = kzalloc(DEV_PER_WIDGET * sizeof(*war_list), GFP_KERNEL);
+	if (!war_list)
+		BUG();
+
+	SAL_CALL_NOLOCK(isrv, SN_SAL_IOIF_GET_WIDGET_DMAFLUSH_LIST,
+			nasid, widget, __pa(war_list), 0, 0, 0 ,0);
+	if (isrv.status)
+		panic("sn_device_fixup_war failed: %s\n",
+		      ia64_sal_strerror(isrv.status));
+
+	dev_entry = war_list + device;
+	memcpy(common,dev_entry, sizeof(*common));
+	kfree(war_list);
+
+	return isrv.status;
+}
+
+/*
+ * sn_common_hubdev_init() - This routine is called to initialize the HUB data
+ *			     structure for each node in the system.
+ */
+void __init
+sn_common_hubdev_init(struct hubdev_info *hubdev)
+{
+
+	struct sn_flush_device_kernel *sn_flush_device_kernel;
+	struct sn_flush_device_kernel *dev_entry;
+	s64 status;
+	int widget, device, size;
+
+	/* Attach the error interrupt handlers */
+	if (hubdev->hdi_nasid & 1)	/* If TIO */
+		ice_error_init(hubdev);
+	else
+		hub_error_init(hubdev);
+
+	for (widget = 0; widget <= HUB_WIDGET_ID_MAX; widget++)
+		hubdev->hdi_xwidget_info[widget].xwi_hubinfo = hubdev;
+
+	if (!hubdev->hdi_flush_nasid_list.widget_p)
+		return;
+
+	size = (HUB_WIDGET_ID_MAX + 1) *
+		sizeof(struct sn_flush_device_kernel *);
+	hubdev->hdi_flush_nasid_list.widget_p =
+		kzalloc(size, GFP_KERNEL);
+	if (!hubdev->hdi_flush_nasid_list.widget_p)
+		BUG();
+
+	for (widget = 0; widget <= HUB_WIDGET_ID_MAX; widget++) {
+		size = DEV_PER_WIDGET *
+			sizeof(struct sn_flush_device_kernel);
+		sn_flush_device_kernel = kzalloc(size, GFP_KERNEL);
+		if (!sn_flush_device_kernel)
+			BUG();
+
+		dev_entry = sn_flush_device_kernel;
+		for (device = 0; device < DEV_PER_WIDGET;
+		     device++, dev_entry++) {
+			size = sizeof(struct sn_flush_device_common);
+			dev_entry->common = kzalloc(size, GFP_KERNEL);
+			if (!dev_entry->common)
+				BUG();
+			if (sn_prom_feature_available(PRF_DEVICE_FLUSH_LIST))
+				status = sal_get_device_dmaflush_list(
+					     hubdev->hdi_nasid, widget, device,
+					     (u64)(dev_entry->common));
+			else
+				status = sn_device_fixup_war(hubdev->hdi_nasid,
+							     widget, device,
+							     dev_entry->common);
+			if (status != SALRET_OK)
+				panic("SAL call failed: %s\n",
+				      ia64_sal_strerror(status));
+
+			spin_lock_init(&dev_entry->sfdl_flush_lock);
+		}
+
+		if (sn_flush_device_kernel)
+			hubdev->hdi_flush_nasid_list.widget_p[widget] =
+							 sn_flush_device_kernel;
+	}
+}
+
+void sn_pci_unfixup_slot(struct pci_dev *dev)
+{
+	struct pci_dev *host_pci_dev = SN_PCIDEV_INFO(dev)->host_pci_dev;
+
+	sn_irq_unfixup(dev);
+	pci_dev_put(host_pci_dev);
+	pci_dev_put(dev);
+}
+
+/*
+ * sn_pci_fixup_slot() - This routine sets up a slot's resources consistent
+ *			 with the Linux PCI abstraction layer. Resources
+ *			 acquired from our PCI provider include PIO maps
+ *			 to BAR space and interrupt objects.
+ */
+void sn_pci_fixup_slot(struct pci_dev *dev)
+{
+	int segment = pci_domain_nr(dev->bus);
+	int status = 0;
+	struct pcibus_bussoft *bs;
+ 	struct pci_bus *host_pci_bus;
+ 	struct pci_dev *host_pci_dev;
+	struct pcidev_info *pcidev_info;
+ 	struct sn_irq_info *sn_irq_info;
+ 	unsigned int bus_no, devfn;
+
+	pci_dev_get(dev); /* for the sysdata pointer */
+	pcidev_info = kzalloc(sizeof(struct pcidev_info), GFP_KERNEL);
+	if (!pcidev_info)
+		BUG();		/* Cannot afford to run out of memory */
+
+	sn_irq_info = kzalloc(sizeof(struct sn_irq_info), GFP_KERNEL);
+	if (!sn_irq_info)
+		BUG();		/* Cannot afford to run out of memory */
+
+	/* Call to retrieve pci device information needed by kernel. */
+	status = sal_get_pcidev_info((u64) segment, (u64) dev->bus->number,
+				     dev->devfn,
+				     (u64) __pa(pcidev_info),
+				     (u64) __pa(sn_irq_info));
+	if (status)
+		BUG(); /* Cannot get platform pci device information */
+
+	/* Add pcidev_info to list in pci_controller.platform_data */
+	list_add_tail(&pcidev_info->pdi_list,
+		      &(SN_PLATFORM_DATA(dev->bus)->pcidev_info));
+
+	if (!SN_ACPI_BASE_SUPPORT())
+		sn_more_slot_fixup(dev, pcidev_info);
+
+	/*
+	 * Using the PROMs values for the PCI host bus, get the Linux
+ 	 * PCI host_pci_dev struct and set up host bus linkages
+ 	 */
+
+	bus_no = (pcidev_info->pdi_slot_host_handle >> 32) & 0xff;
+	devfn = pcidev_info->pdi_slot_host_handle & 0xffffffff;
+ 	host_pci_bus = pci_find_bus(segment, bus_no);
+ 	host_pci_dev = pci_get_slot(host_pci_bus, devfn);
+
+	pcidev_info->host_pci_dev = host_pci_dev;
+	pcidev_info->pdi_linux_pcidev = dev;
+	pcidev_info->pdi_host_pcidev_info = SN_PCIDEV_INFO(host_pci_dev);
+	bs = SN_PCIBUS_BUSSOFT(dev->bus);
+	pcidev_info->pdi_pcibus_info = bs;
+
+	if (bs && bs->bs_asic_type < PCIIO_ASIC_MAX_TYPES) {
+		SN_PCIDEV_BUSPROVIDER(dev) = sn_pci_provider[bs->bs_asic_type];
+	} else {
+		SN_PCIDEV_BUSPROVIDER(dev) = &sn_pci_default_provider;
+	}
+
+	/* Only set up IRQ stuff if this device has a host bus context */
+	if (bs && sn_irq_info->irq_irq) {
+		pcidev_info->pdi_sn_irq_info = sn_irq_info;
+		dev->irq = pcidev_info->pdi_sn_irq_info->irq_irq;
+		sn_irq_fixup(dev, sn_irq_info);
+	} else {
+		pcidev_info->pdi_sn_irq_info = NULL;
+		kfree(sn_irq_info);
+	}
+}
+
+/*
+ * sn_common_bus_fixup - Perform platform specific bus fixup.
+ *			 Execute the ASIC specific fixup routine
+ *			 for this bus.
+ */
+void
+sn_common_bus_fixup(struct pci_bus *bus,
+		    struct pcibus_bussoft *prom_bussoft_ptr)
+{
+	int cnode;
+	struct pci_controller *controller;
+	struct hubdev_info *hubdev_info;
+	int nasid;
+	void *provider_soft;
+	struct sn_pcibus_provider *provider;
+	struct sn_platform_data *sn_platform_data;
+
+	controller = PCI_CONTROLLER(bus);
+	/*
+	 * Per-provider fixup.  Copies the bus soft structure from prom
+	 * to local area and links SN_PCIBUS_BUSSOFT().
+	 */
+
+	if (prom_bussoft_ptr->bs_asic_type >= PCIIO_ASIC_MAX_TYPES) {
+		printk(KERN_WARNING "sn_common_bus_fixup: Unsupported asic type, %d",
+		       prom_bussoft_ptr->bs_asic_type);
+		return;
+	}
+
+	if (prom_bussoft_ptr->bs_asic_type == PCIIO_ASIC_TYPE_PPB)
+		return;	/* no further fixup necessary */
+
+	provider = sn_pci_provider[prom_bussoft_ptr->bs_asic_type];
+	if (provider == NULL)
+		panic("sn_common_bus_fixup: No provider registered for this asic type, %d",
+		      prom_bussoft_ptr->bs_asic_type);
+
+	if (provider->bus_fixup)
+		provider_soft = (*provider->bus_fixup) (prom_bussoft_ptr,
+				 controller);
+	else
+		provider_soft = NULL;
+
+	/*
+	 * Generic bus fixup goes here.  Don't reference prom_bussoft_ptr
+	 * after this point.
+	 */
+	controller->platform_data = kzalloc(sizeof(struct sn_platform_data),
+					    GFP_KERNEL);
+	if (controller->platform_data == NULL)
+		BUG();
+	sn_platform_data =
+			(struct sn_platform_data *) controller->platform_data;
+	sn_platform_data->provider_soft = provider_soft;
+	INIT_LIST_HEAD(&((struct sn_platform_data *)
+			 controller->platform_data)->pcidev_info);
+	nasid = NASID_GET(SN_PCIBUS_BUSSOFT(bus)->bs_base);
+	cnode = nasid_to_cnodeid(nasid);
+	hubdev_info = (struct hubdev_info *)(NODEPDA(cnode)->pdinfo);
+	SN_PCIBUS_BUSSOFT(bus)->bs_xwidget_info =
+	    &(hubdev_info->hdi_xwidget_info[SN_PCIBUS_BUSSOFT(bus)->bs_xid]);
+
+	/*
+	 * If the node information we obtained during the fixup phase is
+	 * invalid then set controller->node to -1 (undetermined)
+	 */
+	if (controller->node >= num_online_nodes()) {
+		struct pcibus_bussoft *b = SN_PCIBUS_BUSSOFT(bus);
+
+		printk(KERN_WARNING "Device ASIC=%u XID=%u PBUSNUM=%u"
+		       "L_IO=%lx L_MEM=%lx BASE=%lx\n",
+		       b->bs_asic_type, b->bs_xid, b->bs_persist_busnum,
+		       b->bs_legacy_io, b->bs_legacy_mem, b->bs_base);
+		printk(KERN_WARNING "on node %d but only %d nodes online."
+		       "Association set to undetermined.\n",
+		       controller->node, num_online_nodes());
+		controller->node = -1;
+	}
+}
+
+void sn_bus_store_sysdata(struct pci_dev *dev)
+{
+	struct sysdata_el *element;
+
+	element = kzalloc(sizeof(struct sysdata_el), GFP_KERNEL);
+	if (!element) {
+		dev_dbg(dev, "%s: out of memory!\n", __FUNCTION__);
+		return;
+	}
+	element->sysdata = SN_PCIDEV_INFO(dev);
+	list_add(&element->entry, &sn_sysdata_list);
+}
+
+void sn_bus_free_sysdata(void)
+{
+	struct sysdata_el *element;
+	struct list_head *list, *safe;
+
+	list_for_each_safe(list, safe, &sn_sysdata_list) {
+		element = list_entry(list, struct sysdata_el, entry);
+		list_del(&element->entry);
+		list_del(&(((struct pcidev_info *)
+			     (element->sysdata))->pdi_list));
+		kfree(element->sysdata);
+		kfree(element);
+	}
+	return;
+}
+
+/*
+ * hubdev_init_node() - Creates the HUB data structure and link them to it's
+ *			own NODE specific data area.
+ */
+void hubdev_init_node(nodepda_t * npda, cnodeid_t node)
+{
+	struct hubdev_info *hubdev_info;
+	int size;
+	pg_data_t *pg;
+
+	size = sizeof(struct hubdev_info);
+
+	if (node >= num_online_nodes())	/* Headless/memless IO nodes */
+		pg = NODE_DATA(0);
+	else
+		pg = NODE_DATA(node);
+
+	hubdev_info = (struct hubdev_info *)alloc_bootmem_node(pg, size);
+
+	npda->pdinfo = (void *)hubdev_info;
+}
+
+geoid_t
+cnodeid_get_geoid(cnodeid_t cnode)
+{
+	struct hubdev_info *hubdev;
+
+	hubdev = (struct hubdev_info *)(NODEPDA(cnode)->pdinfo);
+	return hubdev->hdi_geoid;
+}
+
+void sn_generate_path(struct pci_bus *pci_bus, char *address)
+{
+	nasid_t nasid;
+	cnodeid_t cnode;
+	geoid_t geoid;
+	moduleid_t moduleid;
+	u16 bricktype;
+
+	nasid = NASID_GET(SN_PCIBUS_BUSSOFT(pci_bus)->bs_base);
+	cnode = nasid_to_cnodeid(nasid);
+	geoid = cnodeid_get_geoid(cnode);
+	moduleid = geo_module(geoid);
+
+	sprintf(address, "module_%c%c%c%c%.2d",
+		'0'+RACK_GET_CLASS(MODULE_GET_RACK(moduleid)),
+		'0'+RACK_GET_GROUP(MODULE_GET_RACK(moduleid)),
+		'0'+RACK_GET_NUM(MODULE_GET_RACK(moduleid)),
+		MODULE_GET_BTCHAR(moduleid), MODULE_GET_BPOS(moduleid));
+
+	/* Tollhouse requires slot id to be displayed */
+	bricktype = MODULE_GET_BTYPE(moduleid);
+	if ((bricktype == L1_BRICKTYPE_191010) ||
+	    (bricktype == L1_BRICKTYPE_1932))
+			sprintf(address, "%s^%d", address, geo_slot(geoid));
+}
+
+/*
+ * sn_pci_fixup_bus() - Perform SN specific setup of software structs
+ *			(pcibus_bussoft, pcidev_info) and hardware
+ *			registers, for the specified bus and devices under it.
+ */
+void __devinit
+sn_pci_fixup_bus(struct pci_bus *bus)
+{
+
+	if (SN_ACPI_BASE_SUPPORT())
+		sn_acpi_bus_fixup(bus);
+	else
+		sn_bus_fixup(bus);
+}
+
+/*
+ * sn_io_early_init - Perform early IO (and some non-IO) initialization.
+ *		      In particular, setup the sn_pci_provider[] array.
+ *		      This needs to be done prior to any bus scanning
+ *		      (acpi_scan_init()) in the ACPI case, as the SN
+ *		      bus fixup code will reference the array.
+ */
+static int __init
+sn_io_early_init(void)
+{
+	int i;
+
+	if (!ia64_platform_is("sn2") || IS_RUNNING_ON_FAKE_PROM())
+		return 0;
+
+	/*
+	 * prime sn_pci_provider[].  Individial provider init routines will
+	 * override their respective default entries.
+	 */
+
+	for (i = 0; i < PCIIO_ASIC_MAX_TYPES; i++)
+		sn_pci_provider[i] = &sn_pci_default_provider;
+
+	pcibr_init_provider();
+	tioca_init_provider();
+	tioce_init_provider();
+
+	/*
+	 * This is needed to avoid bounce limit checks in the blk layer
+	 */
+	ia64_max_iommu_merge_mask = ~PAGE_MASK;
+
+	sn_irq_lh_init();
+	INIT_LIST_HEAD(&sn_sysdata_list);
+	sn_init_cpei_timer();
+
+#ifdef CONFIG_PROC_FS
+	register_sn_procfs();
+#endif
+
+	printk(KERN_INFO "ACPI  DSDT OEM Rev 0x%x\n",
+	       acpi_gbl_DSDT->oem_revision);
+	if (SN_ACPI_BASE_SUPPORT())
+		sn_io_acpi_init();
+	else
+		sn_io_init();
+	return 0;
+}
+
+arch_initcall(sn_io_early_init);
+
+/*
+ * sn_io_late_init() - Perform any final platform specific IO initialization.
+ */
+
+int __init
+sn_io_late_init(void)
+{
+	struct pci_bus *bus;
+	struct pcibus_bussoft *bussoft;
+	cnodeid_t cnode;
+	nasid_t nasid;
+	cnodeid_t near_cnode;
+
+	if (!ia64_platform_is("sn2") || IS_RUNNING_ON_FAKE_PROM())
+		return 0;
+
+	/*
+	 * Setup closest node in pci_controller->node for
+	 * PIC, TIOCP, TIOCE (TIOCA does it during bus fixup using
+	 * info from the PROM).
+	 */
+	bus = NULL;
+	while ((bus = pci_find_next_bus(bus)) != NULL) {
+		bussoft = SN_PCIBUS_BUSSOFT(bus);
+		nasid = NASID_GET(bussoft->bs_base);
+		cnode = nasid_to_cnodeid(nasid);
+		if ((bussoft->bs_asic_type == PCIIO_ASIC_TYPE_TIOCP) ||
+		    (bussoft->bs_asic_type == PCIIO_ASIC_TYPE_TIOCE)) {
+			/* TIO PCI Bridge: find nearest node with CPUs */
+			int e = sn_hwperf_get_nearest_node(cnode, NULL,
+							   &near_cnode);
+			if (e < 0) {
+				near_cnode = (cnodeid_t)-1; /* use any node */
+				printk(KERN_WARNING "pcibr_bus_fixup: failed "
+				       "to find near node with CPUs to TIO "
+				       "node %d, err=%d\n", cnode, e);
+			}
+			PCI_CONTROLLER(bus)->node = near_cnode;
+		} else if (bussoft->bs_asic_type == PCIIO_ASIC_TYPE_PIC) {
+			PCI_CONTROLLER(bus)->node = cnode;
+		}
+	}
+
+	sn_ioif_inited = 1;	/* SN I/O infrastructure now initialized */
+
+	return 0;
+}
+
+fs_initcall(sn_io_late_init);
+
+EXPORT_SYMBOL(sn_pci_fixup_slot);
+EXPORT_SYMBOL(sn_pci_unfixup_slot);
+EXPORT_SYMBOL(sn_bus_store_sysdata);
+EXPORT_SYMBOL(sn_bus_free_sysdata);
+EXPORT_SYMBOL(sn_generate_path);
+
