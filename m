Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263077AbVCQLg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbVCQLg7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 06:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263043AbVCQLfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:35:40 -0500
Received: from ozlabs.org ([203.10.76.45]:23445 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263048AbVCQKky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 05:40:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16953.24301.839167.512527@cargo.ozlabs.ibm.com>
Date: Thu, 17 Mar 2005 21:41:49 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Nathan Lynch <ntl@pobox.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] PPC64 make OF node fixup code usable at runtime
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At boot we recurse through the device tree "fixing up" various fields
and properties in the device nodes.  Long ago, to support DLPAR and
hotplug, we largely duplicated some of this fixup code, the main
difference being that the new code used kmalloc for allocating various
data structures which are attached to the new device nodes.

This patch introduces a helper function (prom_alloc) for handling
allocations at both boot and runtime, kills most of the duplicated
code, and makes finish_node, finish_node_interrupts, and
interpret_pci_props suitable for use at runtime by converting them to
use prom_alloc.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

 arch/ppc64/kernel/prom.c |  177 +++++++++------------------
 1 files changed, 62 insertions(+), 115 deletions(-)

Index: linux-2.6.11-bk10/arch/ppc64/kernel/prom.c
===================================================================
--- linux-2.6.11-bk10.orig/arch/ppc64/kernel/prom.c	2005-03-14 21:49:46.000000000 +0000
+++ linux-2.6.11-bk10/arch/ppc64/kernel/prom.c	2005-03-14 21:54:08.000000000 +0000
@@ -103,6 +103,25 @@ static DEFINE_RWLOCK(devtree_lock);
 struct device_node *of_chosen;
 
 /*
+ * Wrapper for allocating memory for various data that needs to be
+ * attached to device nodes as they are processed at boot or when
+ * added to the device tree later (e.g. DLPAR).  At boot there is
+ * already a region reserved so we just increment *mem_start by size;
+ * otherwise we call kmalloc.
+ */
+static void * prom_alloc(unsigned long size, unsigned long *mem_start)
+{
+	unsigned long tmp;
+
+	if (!mem_start)
+		return kmalloc(size, GFP_KERNEL);
+
+	tmp = *mem_start;
+	*mem_start += size;
+	return (void *)tmp;
+}
+
+/*
  * Find the device_node with a given phandle.
  */
 static struct device_node * find_phandle(phandle ph)
@@ -255,9 +274,9 @@ static int __devinit map_interrupt(unsig
 	return nintrc;
 }
 
-static int __init finish_node_interrupts(struct device_node *np,
-					 unsigned long *mem_start,
-					 int measure_only)
+static int __devinit finish_node_interrupts(struct device_node *np,
+					    unsigned long *mem_start,
+					    int measure_only)
 {
 	unsigned int *ints;
 	int intlen, intrcells, intrcount;
@@ -270,8 +289,10 @@ static int __init finish_node_interrupts
 		return 0;
 	intrcells = prom_n_intr_cells(np);
 	intlen /= intrcells * sizeof(unsigned int);
-	np->intrs = (struct interrupt_info *) (*mem_start);
-	(*mem_start) += intlen * sizeof(struct interrupt_info);
+
+	np->intrs = prom_alloc(intlen * sizeof(*(np->intrs)), mem_start);
+	if (!np->intrs)
+		return -ENOMEM;
 
 	if (measure_only)
 		return 0;
@@ -318,33 +339,39 @@ static int __init finish_node_interrupts
 	return 0;
 }
 
-static int __init interpret_pci_props(struct device_node *np,
-				      unsigned long *mem_start,
-				      int naddrc, int nsizec,
-				      int measure_only)
+static int __devinit interpret_pci_props(struct device_node *np,
+					 unsigned long *mem_start,
+					 int naddrc, int nsizec,
+					 int measure_only)
 {
 	struct address_range *adr;
 	struct pci_reg_property *pci_addrs;
-	int i, l;
+	int i, l, n_addrs;
 
 	pci_addrs = (struct pci_reg_property *)
 		get_property(np, "assigned-addresses", &l);
-	if (pci_addrs != 0 && l >= sizeof(struct pci_reg_property)) {
-		i = 0;
-		adr = (struct address_range *) (*mem_start);
-		while ((l -= sizeof(struct pci_reg_property)) >= 0) {
-			if (!measure_only) {
-				adr[i].space = pci_addrs[i].addr.a_hi;
-				adr[i].address = pci_addrs[i].addr.a_lo |
-					((u64)pci_addrs[i].addr.a_mid << 32);
-				adr[i].size = pci_addrs[i].size_lo;
-			}
-			++i;
-		}
-		np->addrs = adr;
-		np->n_addrs = i;
-		(*mem_start) += i * sizeof(struct address_range);
+	if (!pci_addrs)
+		return 0;
+
+	n_addrs = l / sizeof(*pci_addrs);
+
+	adr = prom_alloc(n_addrs * sizeof(*adr), mem_start);
+	if (!adr)
+		return -ENOMEM;
+ 
+ 	if (measure_only)
+ 		return 0;
+ 
+ 	np->addrs = adr;
+ 	np->n_addrs = n_addrs;
+ 
+ 	for (i = 0; i < n_addrs; i++) {
+ 		adr[i].space = pci_addrs[i].addr.a_hi;
+ 		adr[i].address = pci_addrs[i].addr.a_lo |
+			((u64)pci_addrs[i].addr.a_mid << 32);
+ 		adr[i].size = pci_addrs[i].size_lo;
 	}
+
 	return 0;
 }
 
@@ -490,11 +517,11 @@ static int __init interpret_root_props(s
 	return 0;
 }
 
-static int __init finish_node(struct device_node *np,
-			      unsigned long *mem_start,
-			      interpret_func *ifunc,
-			      int naddrc, int nsizec,
-			      int measure_only)
+static int __devinit finish_node(struct device_node *np,
+				 unsigned long *mem_start,
+				 interpret_func *ifunc,
+				 int naddrc, int nsizec,
+				 int measure_only)
 {
 	struct device_node *child;
 	int *ip, rc = 0;
@@ -1627,54 +1654,6 @@ static void remove_node_proc_entries(str
 #endif /* CONFIG_PROC_DEVICETREE */
 
 /*
- * Fix up n_intrs and intrs fields in a new device node
- *
- */
-static int of_finish_dynamic_node_interrupts(struct device_node *node)
-{
-	int intrcells, intlen, i;
-	unsigned *irq, *ints, virq;
-	struct device_node *ic;
-
-	ints = (unsigned int *)get_property(node, "interrupts", &intlen);
-	intrcells = prom_n_intr_cells(node);
-	intlen /= intrcells * sizeof(unsigned int);
-	node->n_intrs = intlen;
-	node->intrs = kmalloc(sizeof(struct interrupt_info) * intlen,
-			      GFP_KERNEL);
-	if (!node->intrs)
-		return -ENOMEM;
-
-	for (i = 0; i < intlen; ++i) {
-		int n, j;
-		node->intrs[i].line = 0;
-		node->intrs[i].sense = 1;
-		n = map_interrupt(&irq, &ic, node, ints, intrcells);
-		if (n <= 0)
-			continue;
-		virq = virt_irq_create_mapping(irq[0]);
-		if (virq == NO_IRQ) {
-			printk(KERN_CRIT "Could not allocate interrupt "
-			       "number for %s\n", node->full_name);
-			return -ENOMEM;
-		}
-		node->intrs[i].line = irq_offset_up(virq);
-		if (n > 1)
-			node->intrs[i].sense = irq[1];
-		if (n > 2) {
-			printk(KERN_DEBUG "hmmm, got %d intr cells for %s:", n,
-			       node->full_name);
-			for (j = 0; j < n; ++j)
-				printk(" %d", irq[j]);
-			printk("\n");
-		}
-		ints += intrcells;
-	}
-	return 0;
-}
-
-
-/*
  * Fix up the uninitialized fields in a new device node:
  * name, type, n_addrs, addrs, n_intrs, intrs, and pci-specific fields
  *
@@ -1685,7 +1664,9 @@ static int of_finish_dynamic_node_interr
  * This should probably be split up into smaller chunks.
  */
 
-static int of_finish_dynamic_node(struct device_node *node)
+static int of_finish_dynamic_node(struct device_node *node,
+				  unsigned long *unused1, int unused2,
+				  int unused3, int unused4)
 {
 	struct device_node *parent = of_get_parent(node);
 	u32 *regs;
@@ -1710,41 +1691,6 @@ static int of_finish_dynamic_node(struct
 	if ((ibm_phandle = (unsigned int *)get_property(node, "ibm,phandle", NULL)))
 		node->linux_phandle = *ibm_phandle;
 
-	/* do the work of interpret_pci_props */
-	if (parent->type && !strcmp(parent->type, "pci")) {
-		struct address_range *adr;
-		struct pci_reg_property *pci_addrs;
-		int i, l;
-
-		pci_addrs = (struct pci_reg_property *)
-			get_property(node, "assigned-addresses", &l);
-		if (pci_addrs != 0 && l >= sizeof(struct pci_reg_property)) {
-			i = 0;
-			adr = kmalloc(sizeof(struct address_range) * 
-				      (l / sizeof(struct pci_reg_property)),
-				      GFP_KERNEL);
-			if (!adr) {
-				err = -ENOMEM;
-				goto out;
-			}
-			while ((l -= sizeof(struct pci_reg_property)) >= 0) {
-				adr[i].space = pci_addrs[i].addr.a_hi;
-				adr[i].address = pci_addrs[i].addr.a_lo |
-					((u64)pci_addrs[i].addr.a_mid << 32);
-				adr[i].size = pci_addrs[i].size_lo;
-				++i;
-			}
-			node->addrs = adr;
-			node->n_addrs = i;
-		}
-	}
-
-	/* now do the work of finish_node_interrupts */
-	if (get_property(node, "interrupts", NULL)) {
-		err = of_finish_dynamic_node_interrupts(node);
-		if (err) goto out;
-	}
-
 	/* now do the rough equivalent of update_dn_pci_info, this
 	 * probably is not correct for phb's, but should work for
 	 * IOAs and slots.
@@ -1796,7 +1742,8 @@ int of_add_node(const char *path, struct
 		return -EINVAL; /* could also be ENOMEM, though */
 	}
 
-	if (0 != (err = of_finish_dynamic_node(np))) {
+	err = finish_node(np, NULL, of_finish_dynamic_node, 0, 0, 0);
+	if (err < 0) {
 		kfree(np);
 		return err;
 	}
