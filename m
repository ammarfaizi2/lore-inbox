Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUEYH0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUEYH0T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 03:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUEYH0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 03:26:18 -0400
Received: from ozlabs.org ([203.10.76.45]:30148 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264382AbUEYH0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 03:26:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16562.62797.965964.514970@cargo.ozlabs.ibm.com>
Date: Tue, 25 May 2004 17:27:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org, olh@suse.de
Cc: anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH][PPC64] Avoid bogus real IRQ numbers
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Early in the boot process on pSeries machines, we look in the Open
Firmware device tree for information about the interrupt assignments,
and assign virtual IRQ numbers for each physical IRQ.  There is
currently a couple of bugs in this code which result in us assigning
virtual IRQs for nonexistent physical IRQs.  This causes problems when
we call the firmware to enable or disable those nonexistent physical
IRQs.  Some versions at least of the firmware will hit an assertion
failure and crash the machine when this happens.

This patch fixes the bugs and ensures that we don't try and use
nonexistent physical IRQ numbers.  One bug was that we were mapping
ISA interrupts, which is unnecessary since virtual IRQ numbers 0 - 15
are reserved for them.  The other was that when we had a PCI interrupt
(which is always in the range 1 to 4, corresponding to INTA to INTD)
which didn't have a mapping in the PCI host bridge above it, we were
just using the original number (usually 1) rather than ignoring it.

Please apply.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/prom.c ppc64-2.5-pseries/arch/ppc64/kernel/prom.c
--- linux-2.5/arch/ppc64/kernel/prom.c	2004-04-27 18:07:44.000000000 +1000
+++ ppc64-2.5-pseries/arch/ppc64/kernel/prom.c	2004-05-24 17:27:11.000000000 +1000
@@ -2189,11 +2189,13 @@
 		ints = imap - nintrc;
 		reg = ints - naddrc;
 	}
+	if (p == NULL) {
 #ifdef DEBUG_IRQ
-	if (p == NULL)
 		printk("hmmm, int tree for %s doesn't have ctrler\n",
 		       np->full_name);
 #endif
+		return 0;
+	}
 	*irq = ints;
 	*ictrler = p;
 	return nintrc;
@@ -2204,7 +2206,7 @@
 		       int measure_only)
 {
 	unsigned int *ints;
-	int intlen, intrcells;
+	int intlen, intrcells, intrcount;
 	int i, j, n;
 	unsigned int *irq, virq;
 	struct device_node *ic;
@@ -2214,34 +2216,40 @@
 		return mem_start;
 	intrcells = prom_n_intr_cells(np);
 	intlen /= intrcells * sizeof(unsigned int);
-	np->n_intrs = intlen;
 	np->intrs = (struct interrupt_info *) mem_start;
 	mem_start += intlen * sizeof(struct interrupt_info);
 
 	if (measure_only)
 		return mem_start;
 
-	for (i = 0; i < intlen; ++i) {
-		np->intrs[i].line = 0;
-		np->intrs[i].sense = 1;
+	intrcount = 0;
+	for (i = 0; i < intlen; ++i, ints += intrcells) {
 		n = map_interrupt(&irq, &ic, np, ints, intrcells);
 		if (n <= 0)
 			continue;
-		virq = virt_irq_create_mapping(irq[0]);
-		if (virq == NO_IRQ) {
-			printk(KERN_CRIT "Could not allocate interrupt "
-			       "number for %s\n", np->full_name);
-		} else
-			np->intrs[i].line = irq_offset_up(virq);
+
+		/* don't map IRQ numbers under a cascaded 8259 controller */
+		if (ic && device_is_compatible(ic, "chrp,iic")) {
+			np->intrs[intrcount].line = irq[0];
+		} else {
+			virq = virt_irq_create_mapping(irq[0]);
+			if (virq == NO_IRQ) {
+				printk(KERN_CRIT "Could not allocate interrupt"
+				       " number for %s\n", np->full_name);
+				continue;
+			}
+			np->intrs[intrcount].line = irq_offset_up(virq);
+		}
 
 		/* We offset irq numbers for the u3 MPIC by 128 in PowerMac */
 		if (systemcfg->platform == PLATFORM_POWERMAC && ic && ic->parent) {
 			char *name = get_property(ic->parent, "name", NULL);
 			if (name && !strcmp(name, "u3"))
-				np->intrs[i].line += 128;
+				np->intrs[intrcount].line += 128;
 		}
+		np->intrs[intrcount].sense = 1;
 		if (n > 1)
-			np->intrs[i].sense = irq[1];
+			np->intrs[intrcount].sense = irq[1];
 		if (n > 2) {
 			printk("hmmm, got %d intr cells for %s:", n,
 			       np->full_name);
@@ -2249,8 +2257,9 @@
 				printk(" %d", irq[j]);
 			printk("\n");
 		}
-		ints += intrcells;
+		++intrcount;
 	}
+	np->n_intrs = intrcount;
 
 	return mem_start;
 }
