Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbVI3Axl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbVI3Axl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVI3Axl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:53:41 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:23766 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932527AbVI3AxP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:53:15 -0400
Date: Thu, 29 Sep 2005 19:53:14 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] ppc64: EEH PCI address cache cleanups
Message-ID: <20050930005313.GB6173@austin.ibm.com>
References: <20050930004800.GL29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930004800.GL29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


02-eeh-addr-cache-cleanup.patch

This is a minor patch to clean up a buglet related to the PCI address cache.
(The buglet doesn't manifes itself unless there are also bugs elsewhere,
which is why its minor.).  Also:

-- Improved debug printing.
-- Declare some private routines as static
-- Adds reference counting to struct pci_dn->pcidev structure

Signed-off-by: Linas Vepstas <linas@linas.org>

Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/eeh.c	2005-09-29 13:09:10.306972480 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/eeh.c	2005-09-29 13:41:44.868689967 -0500
@@ -219,9 +219,9 @@
 	while (*p) {
 		parent = *p;
 		piar = rb_entry(parent, struct pci_io_addr_range, rb_node);
-		if (alo < piar->addr_lo) {
+		if (ahi < piar->addr_lo) {
 			p = &parent->rb_left;
-		} else if (ahi > piar->addr_hi) {
+		} else if (alo > piar->addr_hi) {
 			p = &parent->rb_right;
 		} else {
 			if (dev != piar->pcidev ||
@@ -240,6 +240,11 @@
 	piar->pcidev = dev;
 	piar->flags = flags;
 
+#ifdef DEBUG
+	printk(KERN_DEBUG "PIAR: insert range=[%lx:%lx] dev=%s\n",
+	                  alo, ahi, pci_name (dev));
+#endif
+
 	rb_link_node(&piar->rb_node, parent, p);
 	rb_insert_color(&piar->rb_node, &pci_io_addr_cache_root.rb_root);
 
@@ -301,7 +306,7 @@
  * we maintain a cache of devices that can be quickly searched.
  * This routine adds a device to that cache.
  */
-void pci_addr_cache_insert_device(struct pci_dev *dev)
+static void pci_addr_cache_insert_device(struct pci_dev *dev)
 {
 	unsigned long flags;
 
@@ -344,7 +349,7 @@
  * the tree multiple times (once per resource).
  * But so what; device removal doesn't need to be that fast.
  */
-void pci_addr_cache_remove_device(struct pci_dev *dev)
+static void pci_addr_cache_remove_device(struct pci_dev *dev)
 {
 	unsigned long flags;
 
@@ -366,6 +371,9 @@
 {
 	struct pci_dev *dev = NULL;
 
+	if (!eeh_subsystem_enabled)
+		return;
+
 	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
 
 	while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
@@ -837,7 +845,7 @@
 	info.buid_lo = BUID_LO(phb->buid);
 	early_enable_eeh(dn, &info);
 }
-EXPORT_SYMBOL(eeh_add_device_early);
+EXPORT_SYMBOL_GPL(eeh_add_device_early);
 
 /**
  * eeh_add_device_late - perform EEH initialization for the indicated pci device
@@ -848,6 +856,8 @@
  */
 void eeh_add_device_late(struct pci_dev *dev)
 {
+	struct device_node *dn;
+
 	if (!dev || !eeh_subsystem_enabled)
 		return;
 
@@ -855,9 +865,13 @@
 	printk(KERN_DEBUG "EEH: adding device %s\n", pci_name(dev));
 #endif
 
+	pci_dev_get (dev);
+	dn = pci_device_to_OF_node(dev);
+	PCI_DN(dn)->pcidev = dev;
+
 	pci_addr_cache_insert_device (dev);
 }
-EXPORT_SYMBOL(eeh_add_device_late);
+EXPORT_SYMBOL_GPL(eeh_add_device_late);
 
 /**
  * eeh_remove_device - undo EEH setup for the indicated pci device
@@ -868,6 +882,7 @@
  */
 void eeh_remove_device(struct pci_dev *dev)
 {
+	struct device_node *dn;
 	if (!dev || !eeh_subsystem_enabled)
 		return;
 
@@ -876,8 +891,12 @@
 	printk(KERN_DEBUG "EEH: remove device %s\n", pci_name(dev));
 #endif
 	pci_addr_cache_remove_device(dev);
+
+	dn = pci_device_to_OF_node(dev);
+	PCI_DN(dn)->pcidev = NULL;
+	pci_dev_put (dev);
 }
-EXPORT_SYMBOL(eeh_remove_device);
+EXPORT_SYMBOL_GPL(eeh_remove_device);
 
 static int proc_eeh_show(struct seq_file *m, void *v)
 {
Index: linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci.h
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/ppc64/kernel/pci.h	2005-09-29 13:09:10.306972480 -0500
+++ linux-2.6.14-rc2-git6/arch/ppc64/kernel/pci.h	2005-09-29 13:36:08.550882158 -0500
@@ -39,10 +39,6 @@
 void pci_devs_phb_init(void);
 void pci_devs_phb_init_dynamic(struct pci_controller *phb);
 
-/* PCI address cache management routines */
-void pci_addr_cache_insert_device(struct pci_dev *dev);
-void pci_addr_cache_remove_device(struct pci_dev *dev);
-
 /* From rtas_pci.h */
 void init_pci_config_tokens (void);
 unsigned long get_phb_buid (struct device_node *);
