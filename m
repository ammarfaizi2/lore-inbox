Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbUJZA45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbUJZA45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 20:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbUJZA44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 20:56:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:45782 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261833AbUJZA4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 20:56:43 -0400
Subject: [PATCH] ppc64: Improve PCI config accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 26 Oct 2004 10:53:51 +1000
Message-Id: <1098752032.17887.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves the config space access routines on G5, by adding
a generic helper function to locate the pci_controller structure (to
be used by an upcoming new platform too) and cleaning up the pmac
routines. It includes the fix to skip devices that aren't present
in the OF tree that is necessary for newer G5 desktop models.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Index: linux-work/arch/ppc64/kernel/pmac.h
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pmac.h	2004-10-17 12:07:07.000000000 +1000
+++ linux-work/arch/ppc64/kernel/pmac.h	2004-10-26 10:38:38.799817160 +1000
@@ -18,7 +18,6 @@
 extern void pmac_pcibios_fixup(void);
 extern void pmac_pci_init(void);
 extern void pmac_setup_pci_dma(void);
-extern void fixup_k2_sata(struct pci_dev* dev);
 extern void pmac_check_ht_link(void);
 
 extern void pmac_setup_smp(void);
Index: linux-work/include/asm-ppc64/pci-bridge.h
===================================================================
--- linux-work.orig/include/asm-ppc64/pci-bridge.h	2004-10-26 08:30:21.000000000 +1000
+++ linux-work/include/asm-ppc64/pci-bridge.h	2004-10-26 10:38:38.800817008 +1000
@@ -101,5 +101,22 @@
 
 extern void phbs_remap_io(void);
 
+static inline struct pci_controller *pci_bus_to_host(struct pci_bus *bus)
+{
+	struct device_node *busdn;
+
+	busdn = bus->sysdata;
+	if (busdn == 0) {
+		struct pci_bus *b;
+		for (b = bus->parent; b && bus->sysdata == 0; b = b->parent)
+			;
+		busdn = b->sysdata;
+	}
+	if (busdn == NULL)
+		return NULL;
+	return busdn->phb;
+}
+
+
 #endif
 #endif /* __KERNEL__ */
Index: linux-work/arch/ppc64/kernel/pmac_pci.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pmac_pci.c	2004-10-17 12:07:07.000000000 +1000
+++ linux-work/arch/ppc64/kernel/pmac_pci.c	2004-10-26 10:38:38.803816552 +1000
@@ -46,7 +46,6 @@
  * assuming we won't have both UniNorth and Bandit */
 static int has_uninorth;
 static struct pci_controller *u3_agp;
-u8 pci_cache_line_size;
 struct pci_dev *k2_skiplist[2];
 
 static int __init fixup_one_level_bus_range(struct device_node *node, int higher)
@@ -150,16 +149,9 @@
 				      int offset, int len, u32 *val)
 {
 	struct pci_controller *hose;
-	struct device_node *busdn;
 	unsigned long addr;
 
-	if (bus->self)
-		busdn = pci_device_to_OF_node(bus->self);
-	else
-		busdn = bus->sysdata;	/* must be a phb */
-	if (busdn == NULL)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	hose = busdn->phb;
+	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -188,16 +180,9 @@
 				       int offset, int len, u32 val)
 {
 	struct pci_controller *hose;
-	struct device_node *busdn;
 	unsigned long addr;
 
-	if (bus->self)
-		busdn = pci_device_to_OF_node(bus->self);
-	else
-		busdn = bus->sysdata;	/* must be a phb */
-	if (busdn == NULL)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	hose = busdn->phb;
+	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
@@ -236,14 +221,44 @@
  * implement self-view of the HT host yet
  */
 
-static int skip_k2_device(struct pci_bus *bus, unsigned int devfn)
+/*
+ * This function deals with some "special cases" devices.
+ *
+ *  0 -> No special case
+ *  1 -> Skip the device but act as if the access was successfull
+ *       (return 0xff's on reads, eventually, cache config space
+ *       accesses in a later version)
+ * -1 -> Hide the device (unsuccessful acess)
+ */
+static int u3_ht_skip_device(struct pci_controller *hose,
+			     struct pci_bus *bus, unsigned int devfn)
 {
+	struct device_node *busdn, *dn;
 	int i;
 
+	/*
+	 * When a device in K2 is powered down, we die on config
+	 * cycle accesses. Fix that here.
+	 */
 	for (i=0; i<2; i++)
 		if (k2_skiplist[i] && k2_skiplist[i]->bus == bus &&
 		    k2_skiplist[i]->devfn == devfn)
 			return 1;
+
+	/* We only allow config cycles to devices that are in OF device-tree
+	 * as we are apparently having some weird things going on with some
+	 * revs of K2 on recent G5s
+	 */
+	if (bus->self)
+		busdn = pci_device_to_OF_node(bus->self);
+	else
+		busdn = hose->arch_data;
+	for (dn = busdn->child; dn; dn = dn->sibling)
+		if (dn->devfn == devfn)
+			break;
+	if (dn == NULL)
+		return -1;
+
 	return 0;
 }
 
@@ -259,8 +274,7 @@
 {
 	if (bus == hose->first_busno) {
 		/* For now, we don't self probe U3 HT bridge */
-		if (PCI_FUNC(devfn) != 0 || PCI_SLOT(devfn) > 7 ||
-		    PCI_SLOT(devfn) < 1)
+		if (PCI_SLOT(devfn) == 0)
 			return 0;
 		return ((unsigned long)hose->cfg_data) + U3_HT_CFA0(devfn, offset);
 	} else
@@ -271,39 +285,21 @@
 				    int offset, int len, u32 *val)
 {
 	struct pci_controller *hose;
-	struct device_node *busdn, *dn;
 	unsigned long addr;
 
-	if (bus->self)
-		busdn = pci_device_to_OF_node(bus->self);
-	else
-		busdn = bus->sysdata;	/* must be a phb */
-	if (busdn == NULL)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	hose = busdn->phb;
-	if (hose == NULL)
-		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	/* We only allow config cycles to devices that are in OF device-tree
-	 * as we are apparently having some weird things going on with some
-	 * revs of K2 on recent G5s
-	 */
-	for (dn = busdn->child; dn; dn = dn->sibling)
-		if (dn->devfn == devfn)
-			break;
-	if (dn == NULL)
+	hose = pci_bus_to_host(bus);      
+	if (hose == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	addr = u3_ht_cfg_access(hose, bus->number, devfn, offset);
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	/*
-	 * When a device in K2 is powered down, we die on config
-	 * cycle accesses. Fix that here. We may ultimately want
-	 * to cache the config space for those instead of returning
-	 * 0xffffffff's to make life easier to HW detection tools
-	 */
-	if (skip_k2_device(bus, devfn)) {
+
+	switch (u3_ht_skip_device(hose, bus, devfn)) {
+	case 0:
+		break;
+	case 1:
 		switch (len) {
 		case 1:
 			*val = 0xff; break;
@@ -313,6 +309,8 @@
 			*val = 0xfffffffful; break;
 		}
 		return PCIBIOS_SUCCESSFUL;
+	default:
+		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
 	/*
@@ -337,28 +335,24 @@
 				     int offset, int len, u32 val)
 {
 	struct pci_controller *hose;
-	struct device_node *busdn;
 	unsigned long addr;
 
-	if (bus->self)
-		busdn = pci_device_to_OF_node(bus->self);
-	else
-		busdn = bus->sysdata;	/* must be a phb */
-	if (busdn == NULL)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	hose = busdn->phb;
+	hose = pci_bus_to_host(bus);
 	if (hose == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	addr = u3_ht_cfg_access(hose, bus->number, devfn, offset);
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	/*
-	 * When a device in K2 is powered down, we die on config
-	 * cycle accesses. Fix that here.
-	 */
-	if (skip_k2_device(bus, devfn))
+
+	switch (u3_ht_skip_device(hose, bus, devfn)) {
+	case 0:
+		break;
+	case 1:
 		return PCIBIOS_SUCCESSFUL;
+	default:
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
 
 	/*
 	 * Note: the caller has already checked that offset is
@@ -675,7 +669,6 @@
 	pci_fix_bus_sysdata();
 
 	iommu_setup_u3();
-
 }
 
 static void __init pmac_fixup_phb_resources(void)
@@ -750,11 +743,6 @@
 	/* Tell pci.c to use the common resource allocation mecanism */
 	pci_probe_only = 0;
 	
-	/* HT don't do more than 64 bytes transfers. FIXME: Deal with
-	 * the exception of U3/AGP (hook into pci_set_mwi)
-	 */
-	pci_cache_line_size = 16; /* 64 bytes */
-
 	/* Allow all IO */
 	io_page_mask = -1;
 }
@@ -763,7 +751,7 @@
  * Disable second function on K2-SATA, it's broken
  * and disable IO BARs on first one
  */
-void fixup_k2_sata(struct pci_dev* dev)
+static void fixup_k2_sata(struct pci_dev* dev)
 {
 	int i;
 	u16 cmd;


