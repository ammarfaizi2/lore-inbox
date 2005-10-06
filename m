Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVJFXq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVJFXq1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVJFXq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:46:27 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:2253 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750898AbVJFXq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:46:26 -0400
Date: Thu, 6 Oct 2005 18:46:24 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 14/22] ppc64: RPA PHP to EEH code movement
Message-ID: <20051006234624.GO29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006232032.GA29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


14-rpaphp-migrate.patch

This patch moves some pci device add & remove code from the PCI
hotplug directory to the arch/ppc64/kernel directory, and cleans 
it up a tad. The primary reason for this is that the code performs
some fairly generic operations that are shared with the PCI error
recovery code (living in the arch/ppc64/kernel directory).

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci_dlpar.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci_dlpar.c	2005-10-06 17:54:00.306445890 -0500
@@ -0,0 +1,174 @@
+/*
+ * PCI Dynamic LPAR, PCI Hot Plug and PCI EEH recovery code
+ * for RPA-compliant PPC64 platform.
+ * Copyright (C) 2003 Linda Xie <lxie@us.ibm.com>
+ * Copyright (C) 2005 International Business Machines
+ *
+ * Updates, 2005, John Rose <johnrose@austin.ibm.com>
+ * Updates, 2005, Linas Vepstas <linas@austin.ibm.com>
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/pci.h>
+#include <asm/pci-bridge.h>
+
+static struct pci_bus *
+find_bus_among_children(struct pci_bus *bus,
+                        struct device_node *dn)
+{
+	struct pci_bus *child = NULL;
+	struct list_head *tmp;
+	struct device_node *busdn;
+
+	busdn = pci_bus_to_OF_node(bus);
+	if (busdn == dn)
+		return bus;
+
+	list_for_each(tmp, &bus->children) {
+		child = find_bus_among_children(pci_bus_b(tmp), dn);
+		if (child)
+			break;
+	};
+	return child;
+}
+
+struct pci_bus *
+pcibios_find_pci_bus(struct device_node *dn)
+{
+	struct pci_dn *pdn = dn->data;
+
+	if (!pdn  || !pdn->phb || !pdn->phb->bus)
+		return NULL;
+
+	return find_bus_among_children(pdn->phb->bus, dn);
+}
+
+/**
+ * pcibios_remove_pci_devices - remove all devices under this bus
+ *
+ * Remove all of the PCI devices under this bus both from the
+ * linux pci device tree, and from the ppc64 EEH address cache.
+ */
+void
+pcibios_remove_pci_devices(struct pci_bus *bus)
+{
+	struct pci_dev *dev, *tmp;
+
+	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
+		eeh_remove_bus_device(dev);
+		pci_remove_bus_device(dev);
+	}
+}
+
+/* Must be called before pci_bus_add_devices */
+static void
+pcibios_fixup_new_pci_devices(struct pci_bus *bus, int fix_bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		/*
+		 * Skip already-present devices (which are on the
+		 * global device list.)
+		 */
+		if (list_empty(&dev->global_list)) {
+			int i;
+
+			/* Need to setup IOMMU tables */
+			ppc_md.iommu_dev_setup(dev);
+
+			if(fix_bus)
+				pcibios_fixup_device_resources(dev, bus);
+			pci_read_irq_line(dev);
+			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+				struct resource *r = &dev->resource[i];
+
+				if (r->parent || !r->start || !r->flags)
+					continue;
+				pci_claim_resource(dev, i);
+			}
+		}
+	}
+}
+
+static int
+pcibios_pci_config_bridge(struct pci_dev *dev)
+{
+	u8 sec_busno;
+	struct pci_bus *child_bus;
+	struct pci_dev *child_dev;
+
+	/* Get busno of downstream bus */
+	pci_read_config_byte(dev, PCI_SECONDARY_BUS, &sec_busno);
+
+	/* Add to children of PCI bridge dev->bus */
+	child_bus = pci_add_new_bus(dev->bus, dev, sec_busno);
+	if (!child_bus) {
+		printk (KERN_ERR "%s: could not add second bus\n", __FUNCTION__);
+		return -EIO;
+	}
+	sprintf(child_bus->name, "PCI Bus #%02x", child_bus->number);
+
+	pci_scan_child_bus(child_bus);
+
+	list_for_each_entry(child_dev, &child_bus->devices, bus_list) {
+		eeh_add_device_late(child_dev);
+	}
+
+	/* Fixup new pci devices without touching bus struct */
+	pcibios_fixup_new_pci_devices(child_bus, 0);
+
+	/* Make the discovered devices available */
+	pci_bus_add_devices(child_bus);
+	return 0;
+}
+
+/**
+ * pcibios_add_pci_devices - adds new pci devices to bus
+ *
+ * This routine will find and fixup new pci devices under
+ * the indicated bus. This routine presumes that there
+ * might already be some devices under this pridge, so
+ * it carefully treis o add only new devices.  (And that
+ * is how this routine differes from other, similar pcibios
+ * routines.)
+ */
+void
+pcibios_add_pci_devices(struct pci_bus * bus)
+{
+	int slotno, num;
+	struct pci_dev *dev;
+	struct device_node *dn = pci_bus_to_OF_node(bus);
+
+	eeh_add_device_tree_early(dn);
+
+	/* pci_scan_slot should find all children */
+	slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
+	num = pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
+	if (num) {
+		pcibios_fixup_new_pci_devices(bus, 1);
+		pci_bus_add_devices(bus);
+	}
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		eeh_add_device_late (dev);
+		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+			pcibios_pci_config_bridge(dev);
+	}
+}
Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/Makefile
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/Makefile	2005-10-06 17:50:25.365604176 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/Makefile	2005-10-06 17:54:00.307445749 -0500
@@ -37,7 +37,7 @@
 			 bpa_iic.o spider-pic.o
 
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o
-obj-$(CONFIG_EEH)		+= eeh.o eeh_event.o
+obj-$(CONFIG_EEH)		+= eeh.o eeh_event.o pci_dlpar.o
 obj-$(CONFIG_PROC_FS)		+= proc_ppc64.o
 obj-$(CONFIG_RTAS_FLASH)	+= rtas_flash.o
 obj-$(CONFIG_SMP)		+= smp.o
Index: linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/pci/hotplug/rpaphp_pci.c	2005-10-06 17:53:57.832792967 -0500
+++ linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpaphp_pci.c	2005-10-06 17:54:00.308445609 -0500
@@ -30,36 +30,6 @@
 
 #include "rpaphp.h"
 
-static struct pci_bus *find_bus_among_children(struct pci_bus *bus,
-					struct device_node *dn)
-{
-	struct pci_bus *child = NULL;
-	struct list_head *tmp;
-	struct device_node *busdn;
-
-	busdn = pci_bus_to_OF_node(bus);
-	if (busdn == dn)
-		return bus;
-
-	list_for_each(tmp, &bus->children) {
-		child = find_bus_among_children(pci_bus_b(tmp), dn);
-		if (child)
-			break;
-	}
-	return child;
-}
-
-struct pci_bus *rpaphp_find_pci_bus(struct device_node *dn)
-{
-	struct pci_dn *pdn = dn->data;
-
-	if (!pdn  || !pdn->phb || !pdn->phb->bus)
-		return NULL;
-
-	return find_bus_among_children(pdn->phb->bus, dn);
-}
-EXPORT_SYMBOL_GPL(rpaphp_find_pci_bus);
-
 static int rpaphp_get_sensor_state(struct slot *slot, int *state)
 {
 	int rc;
@@ -118,7 +88,7 @@
 			/* config/unconfig adapter */
 			*value = slot->state;
 		} else {
-			bus = rpaphp_find_pci_bus(slot->dn);
+			bus = pcibios_find_pci_bus(slot->dn);
 			if (bus && !list_empty(&bus->devices))
 				*value = CONFIGURED;
 			else
@@ -129,117 +99,6 @@
 	return rc;
 }
 
-/* Must be called before pci_bus_add_devices */
-static void 
-rpaphp_fixup_new_pci_devices(struct pci_bus *bus, int fix_bus)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		/*
-		 * Skip already-present devices (which are on the
-		 * global device list.)
-		 */
-		if (list_empty(&dev->global_list)) {
-			int i;
-			
-			/* Need to setup IOMMU tables */
-			ppc_md.iommu_dev_setup(dev);
-
-			if(fix_bus)
-				pcibios_fixup_device_resources(dev, bus);
-			pci_read_irq_line(dev);
-			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-				struct resource *r = &dev->resource[i];
-
-				if (r->parent || !r->start || !r->flags)
-					continue;
-				pci_claim_resource(dev, i);
-			}
-		}
-	}
-}
-
-static int rpaphp_pci_config_bridge(struct pci_dev *dev)
-{
-	u8 sec_busno;
-	struct pci_bus *child_bus;
-	struct pci_dev *child_dev;
-
-	dbg("Enter %s:  BRIDGE dev=%s\n", __FUNCTION__, pci_name(dev));
-
-	/* get busno of downstream bus */
-	pci_read_config_byte(dev, PCI_SECONDARY_BUS, &sec_busno);
-		
-	/* add to children of PCI bridge dev->bus */
-	child_bus = pci_add_new_bus(dev->bus, dev, sec_busno);
-	if (!child_bus) {
-		err("%s: could not add second bus\n", __FUNCTION__);
-		return -EIO;
-	}
-	sprintf(child_bus->name, "PCI Bus #%02x", child_bus->number);
-	/* do pci_scan_child_bus */
-	pci_scan_child_bus(child_bus);
-
-	list_for_each_entry(child_dev, &child_bus->devices, bus_list) {
-		eeh_add_device_late(child_dev);
-	}
-
-	 /* fixup new pci devices without touching bus struct */
-	rpaphp_fixup_new_pci_devices(child_bus, 0);
-
-	/* Make the discovered devices available */
-	pci_bus_add_devices(child_bus);
-	return 0;
-}
-
-/*****************************************************************************
- rpaphp_pci_config_slot() will  configure all devices under the
- given slot->dn and return the the first pci_dev.
- *****************************************************************************/
-int
-rpaphp_config_pci_adapter(struct pci_bus *bus)
-{
-	struct device_node *dn = pci_bus_to_OF_node(bus);
-	struct pci_dev *dev = NULL;
-	int rc = -ENODEV;
-	int slotno;
-	int num;
-
-	dbg("Enter %s: dn=%s bus=%s\n", __FUNCTION__, dn->full_name, bus->name);
-	if (!dn || !dn->child)
-		goto exit;
-
-	eeh_add_device_tree_early(dn);
-	
-	slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
-
-	/* pci_scan_slot should find all children */
-	num = pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
-	if (num) {
-		rpaphp_fixup_new_pci_devices(bus, 1);
-		pci_bus_add_devices(bus);
-	}
-	if (list_empty(&bus->devices)) {
-		err("%s: No new device found\n", __FUNCTION__);
-		goto exit;
-	}
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
-			rpaphp_pci_config_bridge(dev);
-	}
-
-	dbg("%s: pci_devs of slot[%s]\n", __FUNCTION__, dn->full_name);
-	list_for_each_entry (dev, &bus->devices, bus_list)
-		dbg("\t%s\n", pci_name(dev));
-
-	rc = 0;
-exit:
-	dbg("Exit %s:  rc=%d\n", __FUNCTION__, rc);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(rpaphp_config_pci_adapter);
-
 static void print_slot_pci_funcs(struct pci_bus *bus)
 {
 	struct device_node *dn;
@@ -255,17 +114,6 @@
 	return;
 }
 
-int rpaphp_unconfig_pci_adapter(struct pci_bus *bus)
-{
-	struct pci_dev *dev, *tmp;
-
-	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
-		eeh_remove_bus_device(dev);
-		pci_remove_bus_device(dev);
-	}
-	return 0;
-}
-
 static int setup_pci_hotplug_slot_info(struct slot *slot)
 {
 	dbg("%s Initilize the PCI slot's hotplug->info structure ...\n",
@@ -301,7 +149,7 @@
 	struct pci_bus *bus;
 
 	BUG_ON(!dn);
-	bus = rpaphp_find_pci_bus(dn);
+	bus = pcibios_find_pci_bus(dn);
 	if (!bus) {
 		err("%s: no pci_bus for dn %s\n", __FUNCTION__, dn->full_name);
 		goto exit_rc;
@@ -326,10 +174,7 @@
 		if (slot->hotplug_slot->info->adapter_status == NOT_CONFIGURED) {
 			dbg("%s CONFIGURING pci adapter in slot[%s]\n",  
 				__FUNCTION__, slot->name);
-			if (rpaphp_config_pci_adapter(slot->bus)) {
-				err("%s: CONFIG pci adapter failed\n", __FUNCTION__);
-				goto exit_rc;		
-			}
+			pcibios_add_pci_devices(slot->bus);
 
 		} else if (slot->hotplug_slot->info->adapter_status != CONFIGURED) {
 			err("%s: slot[%s]'s adapter_status is NOT_VALID.\n",
@@ -375,16 +220,10 @@
 	/* if slot is not empty, enable the adapter */
 	if (state == PRESENT) {
 		dbg("%s : slot[%s] is occupied.\n", __FUNCTION__, slot->name);
-		retval = rpaphp_config_pci_adapter(slot->bus);
-		if (!retval) {
-			slot->state = CONFIGURED;
-			dbg("%s: PCI devices in slot[%s] has been configured\n", 
+		pcibios_add_pci_devices(slot->bus);
+		slot->state = CONFIGURED;
+		dbg("%s: PCI devices in slot[%s] has been configured\n", 
 				__FUNCTION__, slot->name);
-		} else {
-			slot->state = NOT_CONFIGURED;
-			dbg("%s: no pci_dev struct for adapter in slot[%s]\n",
-			    __FUNCTION__, slot->name);
-		}
 	} else if (state == EMPTY) {
 		dbg("%s : slot[%s] is empty\n", __FUNCTION__, slot->name);
 		slot->state = EMPTY;
Index: linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpadlpar_core.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/pci/hotplug/rpadlpar_core.c	2005-10-06 17:53:57.834792686 -0500
+++ linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpadlpar_core.c	2005-10-06 17:54:00.309445469 -0500
@@ -194,9 +194,8 @@
 static int dlpar_add_pci_slot(char *drc_name, struct device_node *dn)
 {
 	struct pci_dev *dev;
-	int rc;
 
-	if (rpaphp_find_pci_bus(dn))
+	if (pcibios_find_pci_bus(dn))
 		return -EINVAL;
 
 	/* Add pci bus */
@@ -208,12 +207,7 @@
 	}
 
 	if (dn->child) {
-		rc = rpaphp_config_pci_adapter(dev->subordinate);
-		if (rc < 0) {
-			printk(KERN_ERR "%s: unable to enable slot %s\n",
-				__FUNCTION__, drc_name);
-			return -EIO;
-		}
+		pcibios_add_pci_devices(dev->subordinate);
 	}
 
 	/* Add hotplug slot */
@@ -252,7 +246,7 @@
 	struct pci_dn *pdn;
 	int rc = 0;
 
-	if (!rpaphp_find_pci_bus(dn))
+	if (!pcibios_find_pci_bus(dn))
 		return -EINVAL;
 
 	slot = find_slot(dn);
@@ -397,7 +391,7 @@
 	struct pci_bus *bus;
 	struct slot *slot;
 
-	bus = rpaphp_find_pci_bus(dn);
+	bus = pcibios_find_pci_bus(dn);
 	if (!bus)
 		return -EINVAL;
 
Index: linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpaphp_core.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/pci/hotplug/rpaphp_core.c	2005-10-06 17:50:25.366604035 -0500
+++ linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpaphp_core.c	2005-10-06 17:54:00.310445328 -0500
@@ -426,7 +426,8 @@
 
 	dbg("DISABLING SLOT %s\n", slot->name);
 	down(&rpaphp_sem);
-	retval = rpaphp_unconfig_pci_adapter(slot->bus);
+	pcibios_remove_pci_devices(slot->bus);
+	retval = 0;
 	up(&rpaphp_sem);
 	slot->state = NOT_CONFIGURED;
 	info("%s: devices in slot[%s] unconfigured.\n", __FUNCTION__,
Index: linux-2.6.14-rc2-git6/include/asm-ppc64/pci-bridge.h
===================================================================
--- linux-2.6.14-rc2-git6.orig/include/asm-ppc64/pci-bridge.h	2005-10-06 17:50:25.366604035 -0500
+++ linux-2.6.14-rc2-git6/include/asm-ppc64/pci-bridge.h	2005-10-06 17:54:00.310445328 -0500
@@ -103,9 +103,18 @@
 		return bus->sysdata; /* Must be root bus (PHB) */
 }
 
+/** Find the bus corresponding to the indicated device node */
+struct pci_bus * pcibios_find_pci_bus(struct device_node *dn);
+
 extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 					 struct device_node *dev);
 
+/** Remove all of the PCI devices under this bus */
+void pcibios_remove_pci_devices(struct pci_bus *bus);
+
+/** Discover new pci devices under this bus, and add them */
+void pcibios_add_pci_devices(struct pci_bus * bus);
+
 extern int pcibios_remove_root_bus(struct pci_controller *phb);
 
 extern void phbs_remap_io(void);
