Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWCaSE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWCaSE4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWCaSEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:04:55 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:59089 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932177AbWCaSEz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:04:55 -0500
Date: Fri, 31 Mar 2006 12:04:52 -0600
To: Nathan Fontenot <nfont@austin.ibm.com>, Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries: EEH Cleanup
Message-ID: <20060331180452.GY2172@austin.ibm.com>
References: <200603311013.22208.nfont@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603311013.22208.nfont@austin.ibm.com>
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply.

This patch removes unnecessary exports, marks functions as static when
possible, and simplifies some list-related code.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
Paul, please apply and forward upstream.  

On Fri, Mar 31, 2006 at 10:13:21AM -0600, Nathan Fontenot wrote:
> This patch removes unnecessary exports, marks functions as static when
> possible, and simplifies some list-related code.

Nathan's original patch did not apply cleanly for me, nor did it build 
cleanly.  However, the one below does.

Linas.

 arch/powerpc/platforms/pseries/eeh.c |   62 ++++++++++++++++-------------------
 include/asm-powerpc/eeh.h            |   20 -----------
 2 files changed, 30 insertions(+), 52 deletions(-)

Index: linux-2.6.16-git19/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.16-git19.orig/arch/powerpc/platforms/pseries/eeh.c	2006-03-31 11:38:49.000000000 -0600
+++ linux-2.6.16-git19/arch/powerpc/platforms/pseries/eeh.c	2006-03-31 11:54:24.901762378 -0600
@@ -865,7 +865,7 @@ void __init eeh_init(void)
  * on the CEC architecture, type of the device, on earlier boot
  * command-line arguments & etc.
  */
-void eeh_add_device_early(struct device_node *dn)
+static void eeh_add_device_early(struct device_node *dn)
 {
 	struct pci_controller *phb;
 	struct eeh_early_enable_info info;
@@ -882,7 +882,6 @@ void eeh_add_device_early(struct device_
 	info.buid_lo = BUID_LO(phb->buid);
 	early_enable_eeh(dn, &info);
 }
-EXPORT_SYMBOL_GPL(eeh_add_device_early);
 
 void eeh_add_device_tree_early(struct device_node *dn)
 {
@@ -893,20 +892,6 @@ void eeh_add_device_tree_early(struct de
 }
 EXPORT_SYMBOL_GPL(eeh_add_device_tree_early);
 
-void eeh_add_device_tree_late(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
- 		eeh_add_device_late(dev);
- 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
- 			struct pci_bus *subbus = dev->subordinate;
- 			if (subbus)
- 				eeh_add_device_tree_late(subbus);
- 		}
-	}
-}
-
 /**
  * eeh_add_device_late - perform EEH initialization for the indicated pci device
  * @dev: pci device for which to set up EEH
@@ -914,7 +899,7 @@ void eeh_add_device_tree_late(struct pci
  * This routine must be used to complete EEH initialization for PCI
  * devices that were added after system boot (e.g. hotplug, dlpar).
  */
-void eeh_add_device_late(struct pci_dev *dev)
+static void eeh_add_device_late(struct pci_dev *dev)
 {
 	struct device_node *dn;
 	struct pci_dn *pdn;
@@ -933,16 +918,33 @@ void eeh_add_device_late(struct pci_dev 
 
 	pci_addr_cache_insert_device (dev);
 }
-EXPORT_SYMBOL_GPL(eeh_add_device_late);
+
+void eeh_add_device_tree_late(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+ 		eeh_add_device_late(dev);
+ 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+ 			struct pci_bus *subbus = dev->subordinate;
+ 			if (subbus)
+ 				eeh_add_device_tree_late(subbus);
+ 		}
+	}
+}
+EXPORT_SYMBOL_GPL(eeh_add_device_tree_late);
 
 /**
  * eeh_remove_device - undo EEH setup for the indicated pci device
  * @dev: pci device to be removed
  *
- * This routine should be when a device is removed from a running
- * system (e.g. by hotplug or dlpar).
+ * This routine should be called when a device is removed from
+ * a running system (e.g. by hotplug or dlpar).  It unregisters
+ * the PCI device from the EEH subsystem.  I/O errors affecting
+ * this device will no longer be detected after this call; thus,
+ * i/o errors affecting this slot may leave this device unusable.
  */
-void eeh_remove_device(struct pci_dev *dev)
+static void eeh_remove_device(struct pci_dev *dev)
 {
 	struct device_node *dn;
 	if (!dev || !eeh_subsystem_enabled)
@@ -958,21 +960,17 @@ void eeh_remove_device(struct pci_dev *d
 	PCI_DN(dn)->pcidev = NULL;
 	pci_dev_put (dev);
 }
-EXPORT_SYMBOL_GPL(eeh_remove_device);
 
 void eeh_remove_bus_device(struct pci_dev *dev)
 {
+	struct pci_bus *bus = dev->subordinate;
+	struct pci_dev *child, *tmp;
+
 	eeh_remove_device(dev);
-	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		struct pci_bus *bus = dev->subordinate;
-		struct list_head *ln;
-		if (!bus)
-			return; 
-		for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
-			struct pci_dev *pdev = pci_dev_b(ln);
-			if (pdev)
-				eeh_remove_bus_device(pdev);
-		}
+
+	if (bus && dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		list_for_each_entry_safe(child, tmp, &bus->devices, bus_list)
+			 eeh_remove_bus_device(child);
 	}
 }
 EXPORT_SYMBOL_GPL(eeh_remove_bus_device);
Index: linux-2.6.16-git19/include/asm-powerpc/eeh.h
===================================================================
--- linux-2.6.16-git19.orig/include/asm-powerpc/eeh.h	2006-03-19 23:53:29.000000000 -0600
+++ linux-2.6.16-git19/include/asm-powerpc/eeh.h	2006-03-31 11:47:35.000000000 -0600
@@ -60,24 +60,10 @@ void __init pci_addr_cache_build(void);
  * device (including config space i/o).  Call eeh_add_device_late
  * to finish the eeh setup for this device.
  */
-void eeh_add_device_early(struct device_node *);
-void eeh_add_device_late(struct pci_dev *dev);
 void eeh_add_device_tree_early(struct device_node *);
 void eeh_add_device_tree_late(struct pci_bus *);
 
 /**
- * eeh_remove_device - undo EEH setup for the indicated pci device
- * @dev: pci device to be removed
- *
- * This routine should be called when a device is removed from
- * a running system (e.g. by hotplug or dlpar).  It unregisters
- * the PCI device from the EEH subsystem.  I/O errors affecting
- * this device will no longer be detected after this call; thus,
- * i/o errors affecting this slot may leave this device unusable.
- */
-void eeh_remove_device(struct pci_dev *);
-
-/**
  * eeh_remove_device_recursive - undo EEH for device & children.
  * @dev: pci device to be removed
  *
@@ -116,12 +102,6 @@ static inline int eeh_dn_check_failure(s
 
 static inline void pci_addr_cache_build(void) { }
 
-static inline void eeh_add_device_early(struct device_node *dn) { }
-
-static inline void eeh_add_device_late(struct pci_dev *dev) { }
-
-static inline void eeh_remove_device(struct pci_dev *dev) { }
-
 static inline void eeh_add_device_tree_early(struct device_node *dn) { }
 
 static inline void eeh_add_device_tree_late(struct pci_bus *bus) { }
