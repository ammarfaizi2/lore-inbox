Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbUJYB2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbUJYB2r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 21:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbUJYB2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 21:28:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:6861 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261651AbUJYB2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 21:28:38 -0400
Subject: [PATCH] ppc64: Rework PCI <-> OF node matching
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 11:26:30 +1000
Message-Id: <1098667590.26695.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reworks the code that deals with matching PCI devices
with Open Firmware device nodes. This code made several incorrect
assumptions and can be simplified significantly. The main functional
difference now is that PHBs are no longer special cased, but that
shouldn't cause any specific problem.
It also fixes a problem where u3_iommu.c wouldn't work for PCI
devices that lacked a matching OF device node.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/kernel/u3_iommu.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/u3_iommu.c	2004-10-17 12:07:07.000000000 +1000
+++ linux-work/arch/ppc64/kernel/u3_iommu.c	2004-10-25 11:12:22.000000000 +1000
@@ -267,6 +267,7 @@
 
 void iommu_setup_u3(void)
 {
+	struct pci_controller *phb, *tmp;
 	struct pci_dev *dev = NULL;
 	struct device_node *dn;
 
@@ -299,6 +300,11 @@
 		if (dn)
 			dn->iommu_table = &iommu_table_u3;
 	}
+	/* We also make sure we set all PHBs ... */
+	list_for_each_entry_safe(phb, tmp, &hose_list, list_node) {
+		dn = (struct device_node *)phb->arch_data;
+		dn->iommu_table = &iommu_table_u3;
+	}
 }
 
 void __init alloc_u3_dart_table(void)
Index: linux-work/arch/ppc64/kernel/pci_dn.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pci_dn.c	2004-10-20 13:01:00.000000000 +1000
+++ linux-work/arch/ppc64/kernel/pci_dn.c	2004-10-25 11:15:30.000000000 +1000
@@ -46,29 +46,13 @@
 {
 	struct pci_controller *phb = data;
 	u32 *regs;
-	char *device_type = get_property(dn, "device_type", NULL);
-	char *model;
 
 	dn->phb = phb;
-	if (device_type && (strcmp(device_type, "pci") == 0) &&
-			(get_property(dn, "class-code", NULL) == 0)) {
-		/* special case for PHB's.  Sigh. */
-		regs = (u32 *)get_property(dn, "bus-range", NULL);
-		dn->busno = regs[0];
-
-		model = (char *)get_property(dn, "model", NULL);
-
-		if (strstr(model, "U3"))
-			dn->devfn = -1;
-		else
-			dn->devfn = 0;	/* assumption */
-	} else {
-		regs = (u32 *)get_property(dn, "reg", NULL);
-		if (regs) {
-			/* First register entry is addr (00BBSS00)  */
-			dn->busno = (regs[0] >> 16) & 0xff;
-			dn->devfn = (regs[0] >> 8) & 0xff;
-		}
+	regs = (u32 *)get_property(dn, "reg", NULL);
+	if (regs) {
+		/* First register entry is addr (00BBSS00)  */
+		dn->busno = (regs[0] >> 16) & 0xff;
+		dn->devfn = (regs[0] >> 8) & 0xff;
 	}
 	return NULL;
 }
@@ -97,20 +81,25 @@
 	struct device_node *dn, *nextdn;
 	void *ret;
 
-	if (pre && ((ret = pre(start, data)) != NULL))
-		return ret;
+	/* We started with a phb, iterate all childs */
 	for (dn = start->child; dn; dn = nextdn) {
+		u32 *classp, class;
+
 		nextdn = NULL;
-		if (get_property(dn, "class-code", NULL)) {
-			if (pre && ((ret = pre(dn, data)) != NULL))
-				return ret;
-			if (dn->child)
-				/* Depth first...do children */
-				nextdn = dn->child;
-			else if (dn->sibling)
-				/* ok, try next sibling instead. */
-				nextdn = dn->sibling;
-		}
+		classp = (u32 *)get_property(dn, "class-code", NULL);
+		class = classp ? *classp : 0;
+
+		if (pre && ((ret = pre(dn, data)) != NULL))
+			return ret;
+
+		/* If we are a PCI bridge, go down */
+		if (dn->child && ((class >> 8) == PCI_CLASS_BRIDGE_PCI ||
+				  (class >> 8) == PCI_CLASS_BRIDGE_CARDBUS))
+			/* Depth first...do children */
+			nextdn = dn->child;
+		else if (dn->sibling)
+			/* ok, try next sibling instead. */
+			nextdn = dn->sibling;
 		if (!nextdn) {
 			/* Walk up to next valid sibling. */
 			do {
@@ -124,26 +113,16 @@
 	return NULL;
 }
 
-/*
- * Same as traverse_pci_devices except this does it for all phbs.
- */
-static void *traverse_all_pci_devices(traverse_func pre)
+void __devinit pci_devs_phb_init_dynamic(struct pci_controller *phb)
 {
-	struct pci_controller *phb, *tmp;
-	void *ret;
+	struct device_node * dn = (struct device_node *) phb->arch_data;
 
-	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
-		if ((ret = traverse_pci_devices(phb->arch_data, pre, phb))
-				!= NULL)
-			return ret;
-	return NULL;
-}
+	/* PHB nodes themselves must not match */
+	dn->devfn = dn->busno = -1;
+	dn->phb = phb;
 
-void __devinit pci_devs_phb_init_dynamic(struct pci_controller *phb)
-{
 	/* Update dn->phb ptrs for new phb and children devices */
-	traverse_pci_devices((struct device_node *)phb->arch_data,
-			update_dn_pci_info, phb);
+	traverse_pci_devices(dn, update_dn_pci_info, phb);
 }
 
 /*
@@ -154,6 +133,7 @@
 {
 	int busno = ((unsigned long)data >> 8) & 0xff;
 	int devfn = ((unsigned long)data) & 0xff;
+
 	return ((devfn == dn->devfn) && (busno == dn->busno)) ? dn : NULL;
 }
 
@@ -180,10 +160,8 @@
 
 	phb_dn = phb->arch_data;
 	dn = traverse_pci_devices(phb_dn, is_devfn_node, (void *)searchval);
-	if (dn) {
+	if (dn)
 		dev->sysdata = dn;
-		/* ToDo: call some device init hook here */
-	}
 	return dn;
 }
 EXPORT_SYMBOL(fetch_dev_dn);
@@ -195,8 +173,11 @@
  */
 void __init pci_devs_phb_init(void)
 {
+	struct pci_controller *phb, *tmp;
+
 	/* This must be done first so the device nodes have valid pci info! */
-	traverse_all_pci_devices(update_dn_pci_info);
+	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
+		pci_devs_phb_init_dynamic(phb);
 }
 
 

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

