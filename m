Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030575AbVKDAwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030575AbVKDAwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030574AbVKDAv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:51:56 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:65171
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1030554AbVKDAvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:51:50 -0500
Date: Thu, 3 Nov 2005 18:51:31 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 20/42]: ppc64: PCI hotplug common code elimination
Message-ID: <20051104005131.GA27000@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

20-rpaphp-eeh-cleanup.patch

This patch move some code from the rpaphp directory, to the ppc64 directory,
where it should have been all along (Among other things, I need it in the 
ppc64 directory for the PCI error recovery.)

Please note that patch affects TWO maintainers: Paul, after applying
the ppc64 part, please ask that GregKH appli the PCI part. It is safe
to have the ppc64 part go in first. It would be bad to have the 
PCI part go in first.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:35:39.290005477 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:36:41.255317484 -0600
@@ -1093,6 +1093,15 @@
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
@@ -1147,6 +1156,23 @@
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
Index: linux-2.6.14-git3/include/asm-ppc64/eeh.h
===================================================================
--- linux-2.6.14-git3.orig/include/asm-ppc64/eeh.h	2005-11-02 14:32:35.725740824 -0600
+++ linux-2.6.14-git3/include/asm-ppc64/eeh.h	2005-11-02 14:36:41.263316362 -0600
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
Index: linux-2.6.14-git3/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.14-git3.orig/drivers/pci/hotplug/rpaphp_pci.c	2005-11-02 14:28:58.955128188 -0600
+++ linux-2.6.14-git3/drivers/pci/hotplug/rpaphp_pci.c	2005-11-02 14:36:41.271315241 -0600
@@ -253,17 +253,6 @@
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
@@ -289,7 +278,7 @@
 	if (!dn)
 		goto exit;
 
-	enable_eeh(dn);
+	eeh_add_device_tree_early(dn);
 	dev = rpaphp_pci_config_slot(bus);
 	if (!dev) {
 		err("%s: can't find any devices.\n", __FUNCTION__);
@@ -303,30 +292,12 @@
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
