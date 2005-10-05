Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030386AbVJEVnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbVJEVnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbVJEVnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:43:47 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:46989 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1030386AbVJEVnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:43:47 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: discuss@x86-64.org
Subject: [PATCH][Fix] swsusp: avoid possible page tables corruption during resume on x86-64
Date: Wed, 5 Oct 2005 23:44:51 +0200
User-Agent: KMail/1.8.2
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200510011813.54755.rjw@sisk.pl> <200510041909.00714.ak@suse.de>
In-Reply-To: <200510041909.00714.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510052344.52198.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary =========
The following patch makes swsusp avoid the possible temporary corruption of
page translation tables during resume on x86-64.  This is achieved by creating
a copy of the relevant page tables that will not be modified by swsusp and can
be safely used by it on resume.

Problem description ==========
The problem is that during resume on x86-64 swsusp may temporarily corrupt
the page tables used for the direct mapping of RAM.  If that happens, a page
fault occurs and cannot be handled properly, which leads to the
solid hang of the affected system.  This leads to the loss of the system's state
from before suspend and may result in the loss of data or the corruption
of filesystems, so it is a serious issue.  Also, it appears to happen quite often
(for me, as often as 50% of the time).

The problem is related to the fact that (at least) one of the PMD entries used in
the direct memory mapping  (starting at PAGE_OFFSET) points to a page table the
physical address of which is much greater than the physical address of the PMD
entry itself.  Moreover, unfortunately, the physical address of the page table
before suspend (i.e. the one stored in the suspend image) happens to be
different to the physical address of the corresponding page table used during
resume (i.e. the one that is valid right before swsusp_arch_resume() in
arch/x86_64/kernel/suspend_asm.S is executed).  Thus while the image is
restored, the "offending" PMD entry gets overwritten, so it does not point to
the right physical address any more (i.e. there's no page table at the address
pointed to by it, because it points to the address the page table has been at
during suspend).  Consequently, if the PMD entry is used later on, and it _is_
used in the process of copying the image pages, a page fault occurs, but it
cannot be handled in the normal way and the system hangs.

Proposed solution =========
To avoid the corruption of the page tables during resume the patch creates
a copy of them that will not be overwritten by swsusp and can be used by it
safely during resume.  This copy is created during the initialization of the
system along with the original page tables, because it has to be located
in the same page frames on every boot (otherwise swsusp could
overwrite it).

Alternatively, we could create such a copy of the page translation tables
on demand, before swsusp starts to restore the original state of the system
from the suspend image, but this would require that atomic memory allocations
be used while there's almost no free RAM.  Then, theoretically the memory
allocations could fail leading to the failure of the entire resume process.
To avoid that risk I have decided to use the preallocated resume page tables,
although this makes some 4KB page frames be permanently reserved
(eg. 3 page frames for a system with no more than 1GB of RAM).

The additional advantage of the proposed approach is that the code used for
populatingvthe original page tables can also be used for populating the resume
pagevtables (any alternative solution would require the use of some additional
code for this purpose).

Please consider the patch for applying.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc3-git5/arch/x86_64/kernel/suspend.c
===================================================================
--- linux-2.6.14-rc3-git5.orig/arch/x86_64/kernel/suspend.c	2005-10-05 21:12:41.000000000 +0200
+++ linux-2.6.14-rc3-git5/arch/x86_64/kernel/suspend.c	2005-10-05 22:24:13.000000000 +0200
@@ -9,6 +9,7 @@
 
 #include <linux/config.h>
 #include <linux/smp.h>
+#include <linux/mm.h>
 #include <linux/suspend.h>
 #include <asm/proto.h>
 
@@ -140,4 +141,15 @@
 
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+unsigned long resume_table_start_pfn, resume_table_end_pfn;
 
+int arch_prepare_suspend(void)
+{
+	unsigned long pfn;
+
+	for (pfn = resume_table_start_pfn; pfn < resume_table_end_pfn; pfn++)
+		SetPageNosave(pfn_to_page(pfn));
+	return 0;
+}
+#endif /* CONFIG_SOFTWARE_SUSPEND */
Index: linux-2.6.14-rc3-git5/arch/x86_64/kernel/suspend_asm.S
===================================================================
--- linux-2.6.14-rc3-git5.orig/arch/x86_64/kernel/suspend_asm.S	2005-10-05 21:12:41.000000000 +0200
+++ linux-2.6.14-rc3-git5/arch/x86_64/kernel/suspend_asm.S	2005-10-05 22:24:13.000000000 +0200
@@ -40,11 +40,11 @@
 	ret
 
 ENTRY(swsusp_arch_resume)
-	/* set up cr3 */	
-	leaq	init_level4_pgt(%rip),%rax
-	subq	$__START_KERNEL_map,%rax
-	movq	%rax,%cr3
-
+	/* switch to the resume page tables */
+	leaq	resume_level4_pgt(%rip), %rax
+	subq	$__START_KERNEL_map, %rax
+	movq	%rax, %cr3
+	/* Flush TLB */
 	movq	mmu_cr4_features(%rip), %rax
 	movq	%rax, %rdx
 	andq	$~(1<<7), %rdx	# PGE
@@ -69,6 +69,10 @@
 	movq	pbe_next(%rdx), %rdx
 	jmp	loop
 done:
+	/* go back to the original page tables */
+	leaq	init_level4_pgt(%rip), %rax
+	subq	$__START_KERNEL_map, %rax
+	movq	%rax, %cr3
 	/* Flush TLB, including "global" things (vmalloc) */
 	movq	mmu_cr4_features(%rip), %rax
 	movq	%rax, %rdx
@@ -102,3 +106,13 @@
 	xorq	%rax, %rax
 
 	ret
+
+	.section	".data.nosave"
+	.align PAGE_SIZE
+ENTRY(resume_level4_pgt)
+	.quad	0x0000000000002007 + __PHYSICAL_START	/* -> level3_ident_pgt */
+	.fill	255,8,0
+	.quad	0x000000000000a007 + __PHYSICAL_START
+	.fill	254,8,0
+	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
+	.quad	0x0000000000003007 + __PHYSICAL_START	/* -> level3_kernel_pgt */
Index: linux-2.6.14-rc3-git5/include/asm-x86_64/suspend.h
===================================================================
--- linux-2.6.14-rc3-git5.orig/include/asm-x86_64/suspend.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc3-git5/include/asm-x86_64/suspend.h	2005-10-05 21:32:05.000000000 +0200
@@ -6,11 +6,20 @@
 #include <asm/desc.h>
 #include <asm/i387.h>
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+extern unsigned long resume_table_start_pfn, resume_table_end_pfn;
+extern pgd_t resume_level4_pgt[];
+
+#define pgd_offset_resume(address) (resume_level4_pgt + pgd_index(address))
+
+extern int arch_prepare_suspend(void);
+#else
 static inline int
 arch_prepare_suspend(void)
 {
 	return 0;
 }
+#endif
 
 /* Image of the saved processor state. If you touch this, fix acpi_wakeup.S. */
 struct saved_context {
Index: linux-2.6.14-rc3-git5/arch/x86_64/mm/init.c
===================================================================
--- linux-2.6.14-rc3-git5.orig/arch/x86_64/mm/init.c	2005-10-05 21:14:45.000000000 +0200
+++ linux-2.6.14-rc3-git5/arch/x86_64/mm/init.c	2005-10-05 22:24:28.000000000 +0200
@@ -36,6 +36,7 @@
 #include <asm/mmu_context.h>
 #include <asm/proto.h>
 #include <asm/smp.h>
+#include <asm/suspend.h>
 
 #ifndef Dprintk
 #define Dprintk(x...)
@@ -260,6 +261,14 @@
 	pmds = (end + PMD_SIZE - 1) >> PMD_SHIFT;
 	tables = round_up(puds * sizeof(pud_t), PAGE_SIZE) +
 		 round_up(pmds * sizeof(pmd_t), PAGE_SIZE);
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	/*
+	 * We need to create a copy of the direct mapping page tables
+	 * that will be used during resume from disk, so we allocate
+	 * twice as much room as needed for the direct mapping alone
+	 */
+	tables += tables;
+#endif
 
 	table_start = find_e820_area(0x8000, __pa_symbol(&_text), tables);
 	if (table_start == -1UL)
@@ -275,6 +284,9 @@
 void __init init_memory_mapping(unsigned long start, unsigned long end)
 { 
 	unsigned long next; 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	unsigned long start_phys = start;
+#endif
 
 	Dprintk("init_memory_mapping\n");
 
@@ -306,6 +318,26 @@
 	early_printk("kernel direct mapping tables upto %lx @ %lx-%lx\n", end, 
 	       table_start<<PAGE_SHIFT, 
 	       table_end<<PAGE_SHIFT);
+#ifdef CONFIG_SOFTWARE_SUSPEND
+
+	resume_table_start_pfn = table_end;
+
+	start = (unsigned long)__va(start_phys);
+
+	for (; start < end; start = next) {
+		int map;
+		unsigned long pud_phys;
+		pud_t *pud = alloc_low_page(&map, &pud_phys);
+		next = start + PGDIR_SIZE;
+		if (next > end)
+			next = end;
+		phys_pud_init(pud, __pa(start), __pa(next));
+		set_pgd(pgd_offset_resume(start), mk_kernel_pgd(pud_phys));
+		unmap_low_page(map);
+	}
+
+	resume_table_end_pfn = table_end;
+#endif
 }
 
 extern struct x8664_pda cpu_pda[NR_CPUS];
Index: linux-2.6.14-rc3-git5/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc3-git5.orig/kernel/power/swsusp.c	2005-10-05 21:12:41.000000000 +0200
+++ linux-2.6.14-rc3-git5/kernel/power/swsusp.c	2005-10-05 21:24:50.000000000 +0200
@@ -672,7 +672,6 @@
 		return 0;
 
 	page = pfn_to_page(pfn);
-	BUG_ON(PageReserved(page) && PageNosave(page));
 	if (PageNosave(page))
 		return 0;
 	if (PageReserved(page) && pfn_is_nosave(pfn)) {
