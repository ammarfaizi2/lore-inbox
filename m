Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVGVDNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVGVDNr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 23:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVGVDNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 23:13:47 -0400
Received: from ozlabs.org ([203.10.76.45]:6847 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262026AbVGVDKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 23:10:53 -0400
Date: Fri, 22 Jul 2005 13:10:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PPC64] Dynamically allocate segment tables
Message-ID: <20050722031023.GB22596@localhost.localdomain>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PPC64 machines before Power4 need a segment table page allocated for
each CPU.  Currently these are allocated statically in a big array in
head.S for all CPUs.  The segment tables need to be in the first
segment (so do_stab_bolted doesn't take a recursive fault on the stab
itself), but other than that there are no constraints which require
the stabs for the secondary CPUs to be statically allocated.

This patch allocates segment tables dynamically during boot, using
lmb_alloc() to ensure they are within the first 256M segment.  This
reduces the kernel image size by 192k...

Tested on RS64 iSeries, POWER3 pSeries, and POWER5.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/ppc64/kernel/head.S
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/head.S	2005-07-14 10:57:49.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/head.S	2005-07-21 15:23:31.000000000 +1000
@@ -2131,13 +2131,6 @@
 swapper_pg_dir:
 	.space	4096
 
-#ifdef CONFIG_SMP
-/* 1 page segment table per cpu (max 48, cpu0 allocated at STAB0_PHYS_ADDR) */
-	.globl	stab_array
-stab_array:
-	.space	4096 * 48
-#endif
-	
 /*
  * This space gets a copy of optional info passed to us by the bootstrap
  * Used to pass parameters into the kernel like root=/dev/sda1, etc.
Index: working-2.6/arch/ppc64/kernel/smp.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/smp.c	2005-07-06 10:30:12.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/smp.c	2005-07-21 14:55:28.000000000 +1000
@@ -65,8 +65,6 @@
 
 static volatile unsigned int cpu_callin_map[NR_CPUS];
 
-extern unsigned char stab_array[];
-
 void smp_call_function_interrupt(void);
 
 int smt_enabled_at_boot = 1;
@@ -492,19 +490,6 @@
 
 	paca[cpu].default_decr = tb_ticks_per_jiffy;
 
-	if (!cpu_has_feature(CPU_FTR_SLB)) {
-		void *tmp;
-
-		/* maximum of 48 CPUs on machines with a segment table */
-		if (cpu >= 48)
-			BUG();
-
-		tmp = &stab_array[PAGE_SIZE * cpu];
-		memset(tmp, 0, PAGE_SIZE); 
-		paca[cpu].stab_addr = (unsigned long)tmp;
-		paca[cpu].stab_real = virt_to_abs(tmp);
-	}
-
 	/* Make sure callin-map entry is 0 (can be leftover a CPU
 	 * hotplug
 	 */
Index: working-2.6/arch/ppc64/kernel/setup.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/setup.c	2005-07-14 10:57:49.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/setup.c	2005-07-21 15:23:31.000000000 +1000
@@ -1071,6 +1071,8 @@
 	irqstack_early_init();
 	emergency_stack_init();
 
+	stabs_alloc();
+
 	/* set up the bootmem stuff with available memory */
 	do_init_bootmem();
 	sparse_init();
Index: working-2.6/arch/ppc64/mm/stab.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/stab.c	2005-06-08 15:46:23.000000000 +1000
+++ working-2.6/arch/ppc64/mm/stab.c	2005-07-21 15:23:31.000000000 +1000
@@ -18,6 +18,8 @@
 #include <asm/mmu_context.h>
 #include <asm/paca.h>
 #include <asm/cputable.h>
+#include <asm/lmb.h>
+#include <asm/abs_addr.h>
 
 struct stab_entry {
 	unsigned long esid_data;
@@ -224,6 +226,39 @@
 extern void slb_initialize(void);
 
 /*
+ * Allocate segment tables for secondary CPUs.  These must all go in
+ * the first (bolted) segment, so that do_stab_bolted won't get a
+ * recursive segment miss on the segment table itself.
+ */
+void stabs_alloc(void)
+{
+	int cpu;
+
+	if (cpu_has_feature(CPU_FTR_SLB))
+		return;
+
+	for_each_cpu(cpu) {
+		unsigned long newstab;
+
+		if (cpu == 0)
+			continue; /* stab for CPU 0 is statically allocated */
+
+		newstab = lmb_alloc_base(PAGE_SIZE, PAGE_SIZE, 1<<SID_SHIFT);
+		if (! newstab)
+			panic("Unable to allocate segment table for CPU %d.\n",
+			      cpu);
+
+		newstab += KERNELBASE;
+
+		memset((void *)newstab, 0, PAGE_SIZE);
+
+		paca[cpu].stab_addr = newstab;
+		paca[cpu].stab_real = virt_to_abs(newstab);
+		printk(KERN_DEBUG "Segment table for CPU %d at 0x%lx virtual, 0x%lx absolute\n", cpu, paca[cpu].stab_addr, paca[cpu].stab_real);
+	}
+}
+
+/*
  * Build an entry for the base kernel segment and put it into
  * the segment table or SLB.  All other segment table or SLB
  * entries are faulted in.
Index: working-2.6/include/asm-ppc64/mmu.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mmu.h	2005-07-21 15:22:49.000000000 +1000
+++ working-2.6/include/asm-ppc64/mmu.h	2005-07-21 15:23:35.000000000 +1000
@@ -200,6 +200,8 @@
 			       unsigned long prpn,
 			       unsigned long vflags, unsigned long rflags);
 
+extern void stabs_alloc(void);
+
 #endif /* __ASSEMBLY__ */
 
 /*


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
