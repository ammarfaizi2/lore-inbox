Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbVJFXjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVJFXjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVJFXjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:39:25 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:17038 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932080AbVJFXjZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:39:25 -0400
Date: Thu, 6 Oct 2005 18:39:23 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 11/22] ppc64: RPA PHP and EEH common code
Message-ID: <20051006233923.GL29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006232032.GA29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


11-rpaphp-eeh-cleanup.patch

This patch move some code from the rpaphp directory, to the ppc64 directory,
where it should have been all along (Among other things, I need it in the 
ppc64 directory for the PCI error recovery.)

Please note that patch affects TWO maintainers: Paul, after applying
the ppc64 part, please ask that GregKH appli the PCI part. It is safe
to have the ppc64 part go in first. It would be bad to have the 
PCI part go in first.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/eeh.c	2005-10-06 17:53:02.164603746 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c	2005-10-06 17:53:52.475544639 -0500
@@ -1094,6 +1094,15 @@
 }
 EXPORT_SYMBOL_GPL(eeh_add_device_early);
 
+void eeh_add_device_tree_early(struct device_node *dn)
+{
+	struct device_node *sib;
+	for (sib = dn->child; sib; sib = sib->sibling)
+		eeh_add_device_tree_early(sib);
+	eeh_add_device_early(dn);
+}
+EXPORT_SYMBOL_GPL(eeh_add_device_tree_early);
+
 /**
  * eeh_add_device_late - perform EEH initialization for the indicated pci device
  * @dev: pci device for which to set up EEH
@@ -1148,6 +1157,23 @@
 }
 EXPORT_SYMBOL_GPL(eeh_remove_device);
 
+void eeh_remove_bus_device(struct pci_dev *dev)
+{
+	eeh_remove_device(dev);
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		struct pci_bus *bus = dev->subordinate;
+		struct list_head *ln;
+		if (!bus)
+			return; 
+		for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
+			struct pci_dev *pdev = pci_dev_b(ln);
+			if (pdev)
+				eeh_remove_bus_device(pdev);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(eeh_remove_bus_device);
+
 static int proc_eeh_show(struct seq_file *m, void *v)
 {
 	unsigned int cpu;
Index: linux-2.6.14-rc2-git6/include/asm-ppc64/eeh.h
===================================================================
--- linux-2.6.14-rc2-git6.orig/include/asm-ppc64/eeh.h	2005-10-06 17:51:48.669915765 -0500
+++ linux-2.6.14-rc2-git6/include/asm-ppc64/eeh.h	2005-10-06 17:53:52.476544499 -0500
@@ -55,6 +55,7 @@
  * to finish the eeh setup for this device.
  */
 void eeh_add_device_early(struct device_node *);
+void eeh_add_device_tree_early(struct device_node *);
 void eeh_add_device_late(struct pci_dev *);
 
 /**
@@ -70,6 +71,15 @@
 void eeh_remove_device(struct pci_dev *);
 
 /**
+ * eeh_remove_device_recursive - undo EEH for device & children.
+ * @dev: pci device to be removed
+ *
+ * As above, this removes the device; it also removes child
+ * pci devices as well.
+ */
+void eeh_remove_bus_device(struct pci_dev *);
+
+/**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
  *
  * If this macro yields TRUE, the caller relays to eeh_check_failure()
Index: linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/pci/hotplug/rpaphp_pci.c	2005-10-06 17:50:27.039369330 -0500
+++ linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpaphp_pci.c	2005-10-06 17:53:52.477544359 -0500
@@ -251,17 +251,6 @@
 	return dev;
 }
 
-static void enable_eeh(struct device_node *dn)
-{
-	struct device_node *sib;
-
-	for (sib = dn->child; sib; sib = sib->sibling) 
-		enable_eeh(sib);
-	eeh_add_device_early(dn);
-	return;
-	
-}
-
 static void print_slot_pci_funcs(struct pci_bus *bus)
 {
 	struct device_node *dn;
@@ -287,7 +276,7 @@
 	if (!dn)
 		goto exit;
 
-	enable_eeh(dn);
+	eeh_add_device_tree_early(dn);
 	dev = rpaphp_pci_config_slot(bus);
 	if (!dev) {
 		err("%s: can't find any devices.\n", __FUNCTION__);
@@ -301,30 +290,12 @@
 }
 EXPORT_SYMBOL_GPL(rpaphp_config_pci_adapter);
 
-static void rpaphp_eeh_remove_bus_device(struct pci_dev *dev)
-{
-	eeh_remove_device(dev);
-	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		struct pci_bus *bus = dev->subordinate;
-		struct list_head *ln;
-		if (!bus)
-			return; 
-		for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
-			struct pci_dev *pdev = pci_dev_b(ln);
-			if (pdev)
-				rpaphp_eeh_remove_bus_device(pdev);
-		}
-
-	}
-	return;
-}
-
 int rpaphp_unconfig_pci_adapter(struct pci_bus *bus)
 {
 	struct pci_dev *dev, *tmp;
 
 	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
-		rpaphp_eeh_remove_bus_device(dev);
+		eeh_remove_bus_device(dev);
 		pci_remove_bus_device(dev);
 	}
 	return 0;
