Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263050AbVCQLeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbVCQLeS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 06:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263044AbVCQLdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:33:46 -0500
Received: from ozlabs.org ([203.10.76.45]:19861 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263050AbVCQKjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 05:39:55 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16953.24238.129364.460820@cargo.ozlabs.ibm.com>
Date: Thu, 17 Mar 2005 21:40:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Nathan Lynch <ntl@pobox.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] PPC64 preliminary changes to OF fixup functions
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Preliminary modifications to support using some of the interpret_func
family of functions at runtime.  Changes the mem_start argument to be
passed by reference, and the return type to int for error handling to
be implemented in following patches.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

 arch/ppc64/kernel/prom.c |  135 ++++++++++++++-------------
 1 files changed, 71 insertions(+), 64 deletions(-)

Index: linux-2.6.11-bk10/arch/ppc64/kernel/prom.c
===================================================================
--- linux-2.6.11-bk10.orig/arch/ppc64/kernel/prom.c	2005-03-14 21:49:40.000000000 +0000
+++ linux-2.6.11-bk10/arch/ppc64/kernel/prom.c	2005-03-14 21:49:46.000000000 +0000
@@ -73,8 +73,8 @@ struct isa_reg_property {
 };
 
 
-typedef unsigned long interpret_func(struct device_node *, unsigned long,
-				     int, int, int);
+typedef int interpret_func(struct device_node *, unsigned long *,
+			   int, int, int);
 
 extern struct rtas_t rtas;
 extern struct lmb lmb;
@@ -255,9 +255,9 @@ static int __devinit map_interrupt(unsig
 	return nintrc;
 }
 
-static unsigned long __init finish_node_interrupts(struct device_node *np,
-						   unsigned long mem_start,
-						   int measure_only)
+static int __init finish_node_interrupts(struct device_node *np,
+					 unsigned long *mem_start,
+					 int measure_only)
 {
 	unsigned int *ints;
 	int intlen, intrcells, intrcount;
@@ -267,14 +267,14 @@ static unsigned long __init finish_node_
 
 	ints = (unsigned int *) get_property(np, "interrupts", &intlen);
 	if (ints == NULL)
-		return mem_start;
+		return 0;
 	intrcells = prom_n_intr_cells(np);
 	intlen /= intrcells * sizeof(unsigned int);
-	np->intrs = (struct interrupt_info *) mem_start;
-	mem_start += intlen * sizeof(struct interrupt_info);
+	np->intrs = (struct interrupt_info *) (*mem_start);
+	(*mem_start) += intlen * sizeof(struct interrupt_info);
 
 	if (measure_only)
-		return mem_start;
+		return 0;
 
 	intrcount = 0;
 	for (i = 0; i < intlen; ++i, ints += intrcells) {
@@ -315,13 +315,13 @@ static unsigned long __init finish_node_
 	}
 	np->n_intrs = intrcount;
 
-	return mem_start;
+	return 0;
 }
 
-static unsigned long __init interpret_pci_props(struct device_node *np,
-						unsigned long mem_start,
-						int naddrc, int nsizec,
-						int measure_only)
+static int __init interpret_pci_props(struct device_node *np,
+				      unsigned long *mem_start,
+				      int naddrc, int nsizec,
+				      int measure_only)
 {
 	struct address_range *adr;
 	struct pci_reg_property *pci_addrs;
@@ -331,7 +331,7 @@ static unsigned long __init interpret_pc
 		get_property(np, "assigned-addresses", &l);
 	if (pci_addrs != 0 && l >= sizeof(struct pci_reg_property)) {
 		i = 0;
-		adr = (struct address_range *) mem_start;
+		adr = (struct address_range *) (*mem_start);
 		while ((l -= sizeof(struct pci_reg_property)) >= 0) {
 			if (!measure_only) {
 				adr[i].space = pci_addrs[i].addr.a_hi;
@@ -343,15 +343,15 @@ static unsigned long __init interpret_pc
 		}
 		np->addrs = adr;
 		np->n_addrs = i;
-		mem_start += i * sizeof(struct address_range);
+		(*mem_start) += i * sizeof(struct address_range);
 	}
-	return mem_start;
+	return 0;
 }
 
-static unsigned long __init interpret_dbdma_props(struct device_node *np,
-						  unsigned long mem_start,
-						  int naddrc, int nsizec,
-						  int measure_only)
+static int __init interpret_dbdma_props(struct device_node *np,
+					unsigned long *mem_start,
+					int naddrc, int nsizec,
+					int measure_only)
 {
 	struct reg_property32 *rp;
 	struct address_range *adr;
@@ -372,7 +372,7 @@ static unsigned long __init interpret_db
 	rp = (struct reg_property32 *) get_property(np, "reg", &l);
 	if (rp != 0 && l >= sizeof(struct reg_property32)) {
 		i = 0;
-		adr = (struct address_range *) mem_start;
+		adr = (struct address_range *) (*mem_start);
 		while ((l -= sizeof(struct reg_property32)) >= 0) {
 			if (!measure_only) {
 				adr[i].space = 2;
@@ -383,16 +383,16 @@ static unsigned long __init interpret_db
 		}
 		np->addrs = adr;
 		np->n_addrs = i;
-		mem_start += i * sizeof(struct address_range);
+		(*mem_start) += i * sizeof(struct address_range);
 	}
 
-	return mem_start;
+	return 0;
 }
 
-static unsigned long __init interpret_macio_props(struct device_node *np,
-						  unsigned long mem_start,
-						  int naddrc, int nsizec,
-						  int measure_only)
+static int __init interpret_macio_props(struct device_node *np,
+					unsigned long *mem_start,
+					int naddrc, int nsizec,
+					int measure_only)
 {
 	struct reg_property32 *rp;
 	struct address_range *adr;
@@ -413,7 +413,7 @@ static unsigned long __init interpret_ma
 	rp = (struct reg_property32 *) get_property(np, "reg", &l);
 	if (rp != 0 && l >= sizeof(struct reg_property32)) {
 		i = 0;
-		adr = (struct address_range *) mem_start;
+		adr = (struct address_range *) (*mem_start);
 		while ((l -= sizeof(struct reg_property32)) >= 0) {
 			if (!measure_only) {
 				adr[i].space = 2;
@@ -424,16 +424,16 @@ static unsigned long __init interpret_ma
 		}
 		np->addrs = adr;
 		np->n_addrs = i;
-		mem_start += i * sizeof(struct address_range);
+		(*mem_start) += i * sizeof(struct address_range);
 	}
 
-	return mem_start;
+	return 0;
 }
 
-static unsigned long __init interpret_isa_props(struct device_node *np,
-						unsigned long mem_start,
-						int naddrc, int nsizec,
-						int measure_only)
+static int __init interpret_isa_props(struct device_node *np,
+				      unsigned long *mem_start,
+				      int naddrc, int nsizec,
+				      int measure_only)
 {
 	struct isa_reg_property *rp;
 	struct address_range *adr;
@@ -442,7 +442,7 @@ static unsigned long __init interpret_is
 	rp = (struct isa_reg_property *) get_property(np, "reg", &l);
 	if (rp != 0 && l >= sizeof(struct isa_reg_property)) {
 		i = 0;
-		adr = (struct address_range *) mem_start;
+		adr = (struct address_range *) (*mem_start);
 		while ((l -= sizeof(struct isa_reg_property)) >= 0) {
 			if (!measure_only) {
 				adr[i].space = rp[i].space;
@@ -453,16 +453,16 @@ static unsigned long __init interpret_is
 		}
 		np->addrs = adr;
 		np->n_addrs = i;
-		mem_start += i * sizeof(struct address_range);
+		(*mem_start) += i * sizeof(struct address_range);
 	}
 
-	return mem_start;
+	return 0;
 }
 
-static unsigned long __init interpret_root_props(struct device_node *np,
-						 unsigned long mem_start,
-						 int naddrc, int nsizec,
-						 int measure_only)
+static int __init interpret_root_props(struct device_node *np,
+				       unsigned long *mem_start,
+				       int naddrc, int nsizec,
+				       int measure_only)
 {
 	struct address_range *adr;
 	int i, l;
@@ -472,7 +472,7 @@ static unsigned long __init interpret_ro
 	rp = (unsigned int *) get_property(np, "reg", &l);
 	if (rp != 0 && l >= rpsize) {
 		i = 0;
-		adr = (struct address_range *) mem_start;
+		adr = (struct address_range *) (*mem_start);
 		while ((l -= rpsize) >= 0) {
 			if (!measure_only) {
 				adr[i].space = 0;
@@ -484,26 +484,30 @@ static unsigned long __init interpret_ro
 		}
 		np->addrs = adr;
 		np->n_addrs = i;
-		mem_start += i * sizeof(struct address_range);
+		(*mem_start) += i * sizeof(struct address_range);
 	}
 
-	return mem_start;
+	return 0;
 }
 
-static unsigned long __init finish_node(struct device_node *np,
-					unsigned long mem_start,
-					interpret_func *ifunc,
-					int naddrc, int nsizec,
-					int measure_only)
+static int __init finish_node(struct device_node *np,
+			      unsigned long *mem_start,
+			      interpret_func *ifunc,
+			      int naddrc, int nsizec,
+			      int measure_only)
 {
 	struct device_node *child;
-	int *ip;
+	int *ip, rc = 0;
 
 	/* get the device addresses and interrupts */
 	if (ifunc != NULL)
-		mem_start = ifunc(np, mem_start, naddrc, nsizec, measure_only);
+		rc = ifunc(np, mem_start, naddrc, nsizec, measure_only);
+	if (rc)
+		goto out;
 
-	mem_start = finish_node_interrupts(np, mem_start, measure_only);
+	rc = finish_node_interrupts(np, mem_start, measure_only);
+	if (rc)
+		goto out;
 
 	/* Look for #address-cells and #size-cells properties. */
 	ip = (int *) get_property(np, "#address-cells", NULL);
@@ -539,11 +543,14 @@ static unsigned long __init finish_node(
 		       || !strcmp(np->type, "media-bay"))))
 		ifunc = NULL;
 
-	for (child = np->child; child != NULL; child = child->sibling)
-		mem_start = finish_node(child, mem_start, ifunc,
-					naddrc, nsizec, measure_only);
-
-	return mem_start;
+	for (child = np->child; child != NULL; child = child->sibling) {
+		rc = finish_node(child, mem_start, ifunc,
+				 naddrc, nsizec, measure_only);
+		if (rc)
+			goto out;
+	}
+out:
+	return rc;
 }
 
 /**
@@ -555,7 +562,7 @@ static unsigned long __init finish_node(
  */
 void __init finish_device_tree(void)
 {
-	unsigned long mem, size;
+	unsigned long start, end, size = 0;
 
 	DBG(" -> finish_device_tree\n");
 
@@ -568,11 +575,11 @@ void __init finish_device_tree(void)
 	virt_irq_init();
 
 	/* Finish device-tree (pre-parsing some properties etc...) */
-	size = finish_node(allnodes, 0, NULL, 0, 0, 1);
-	mem = (unsigned long)abs_to_virt(lmb_alloc(size, 128));
-	if (finish_node(allnodes, mem, NULL, 0, 0, 0) != mem + size)
-		BUG();
-
+	finish_node(allnodes, &size, NULL, 0, 0, 1);
+	end = start = (unsigned long)abs_to_virt(lmb_alloc(size, 128));
+	finish_node(allnodes, &end, NULL, 0, 0, 0);
+	BUG_ON(end != start + size);
+		
 	DBG(" <- finish_device_tree\n");
 }
 
