Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbUCJPSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 10:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUCJPSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 10:18:25 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:21974 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S262259AbUCJPSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 10:18:17 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200403101517.i2AFHCfZ084981@fsgi900.americas.sgi.com>
Subject: [2.6 PATCH] Altix affinity fix
To: davidm@napali.hpl.hp.com
Date: Wed, 10 Mar 2004 09:17:12 -0600 (CST)
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix for affinity bug.


-- Pat

Patrick Gefre
Silicon Graphics, Inc.                     (E-Mail)  pfg@sgi.com
2750 Blue Water Rd                         (Voice)   (651) 683-3127
Eagan, MN 55121-1400                       (FAX)     (651) 683-3054




# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1694  -> 1.1695 
#	arch/ia64/sn/kernel/irq.c	1.20    -> 1.21   
#	arch/ia64/sn/io/sn2/shub_intr.c	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/08	pfg@sgi.com	1.1695
# arch/ia64/sn/io/sn2/shub_intr.c
#     Use the proper calling args for the pcireg_ functions
# arch/ia64/sn/kernel/irq.c
#     Use the cpu mask as an input arg rather than the cpu ID
#     Discard the redirect bit if set.
# --------------------------------------------
#
diff -Nru a/arch/ia64/sn/io/sn2/shub_intr.c b/arch/ia64/sn/io/sn2/shub_intr.c
--- a/arch/ia64/sn/io/sn2/shub_intr.c	Mon Mar  8 17:48:39 2004
+++ b/arch/ia64/sn/io/sn2/shub_intr.c	Mon Mar  8 17:48:39 2004
@@ -200,7 +200,6 @@
 	int cpuphys, slice;
 	nasid_t nasid;
 	unsigned long xtalk_addr;
-	void		*bridge = intr->bi_soft->bs_base;
 	int		irq;
 	int		i;
 	int		old_cpu;
@@ -237,13 +236,13 @@
 	for (bit = 0; bit < 8; bit++) {
 		if (intr->bi_ibits & (1 << bit) ) {
 			/* Disable interrupts. */
-			pcireg_intr_enable_bit_clr(bridge, bit);
+			pcireg_intr_enable_bit_clr(intr->bi_soft, bit);
 			/* Reset Host address (Interrupt destination) */
-			pcireg_intr_addr_addr_set(bridge, bit, xtalk_addr);
+			pcireg_intr_addr_addr_set(intr->bi_soft, bit, xtalk_addr);
 			/* Enable interrupt */
-			pcireg_intr_enable_bit_set(bridge, bit);
+			pcireg_intr_enable_bit_set(intr->bi_soft, bit);
 			/* Force an interrupt, just in case. */
-			pcireg_force_intr_set(bridge, bit);
+			pcireg_force_intr_set(intr->bi_soft, bit);
 		}
 	}
 	irq = intr->bi_irq;
diff -Nru a/arch/ia64/sn/kernel/irq.c b/arch/ia64/sn/kernel/irq.c
--- a/arch/ia64/sn/kernel/irq.c	Mon Mar  8 17:48:39 2004
+++ b/arch/ia64/sn/kernel/irq.c	Mon Mar  8 17:48:39 2004
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/bootmem.h>
+#include <linux/cpumask.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/sn/sgi.h>
@@ -118,10 +119,11 @@
 }
 
 static void
-sn_set_affinity_irq(unsigned int irq, unsigned long cpu)
+sn_set_affinity_irq(unsigned int irq, cpumask_t mask)
 {
 #ifdef CONFIG_SMP
 	int redir = 0;
+	int cpu;
 	struct sn_intr_list_t *p = sn_intr_list[irq];
 	pcibr_intr_t intr;
 	extern void sn_shub_redirect_intr(pcibr_intr_t intr, unsigned long cpu);
@@ -135,7 +137,9 @@
 	if (intr == NULL)
 		return; 
 
+	cpu = first_cpu(mask);
 	sn_shub_redirect_intr(intr, cpu);
+	irq = irq & 0xff;  /* strip off redirect bit, if someone stuck it on. */
 	(void) set_irq_affinity_info(irq, cpu_physical_id(intr->bi_cpu), redir);
 #endif /* CONFIG_SMP */
 }
