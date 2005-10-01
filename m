Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbVJAQNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVJAQNE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 12:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVJAQNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 12:13:04 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:55015 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750813AbVJAQND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 12:13:03 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Discuss x86-64" <discuss@x86-64.org>
Subject: [RFC][PATCH][Fix] swsusp: Yet another attempt to fix Bug #4959
Date: Sat, 1 Oct 2005 18:13:54 +0200
User-Agent: KMail/1.8.2
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510011813.54755.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following is yet another attempt to fix Bug #4959.

This one uses the code in mm/init.c directly.  For this purpose
it introduces a modified version of init_memory_mapping()
which is compiled if CONFIG_SOFTWARE_SUSPEND is set.

This function allocates twice as much memory as needed for the direct
mapping page tables and assigns the second half of it to the resume page
tables.  This area is later marked with PG_nosave by swsusp, so that it is
not overwritten during resume.

Your comments, criticisms and (preferably) suggestions will be appreciated.

Greetings,
Rafael


Index: linux-2.6.14-rc3/arch/x86_64/kernel/suspend.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/x86_64/kernel/suspend.c	2005-10-01 10:37:53.000000000 +0200
+++ linux-2.6.14-rc3/arch/x86_64/kernel/suspend.c	2005-10-01 14:29:48.000000000 +0200
@@ -9,6 +9,7 @@
 
 #include <linux/config.h>
 #include <linux/smp.h>
+#include <linux/mm.h>
 #include <linux/suspend.h>
 #include <asm/proto.h>
 
@@ -140,4 +141,15 @@
 
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+extern unsigned long resume_table_start, resume_table_end;
 
+int arch_prepare_suspend(void)
+{
+	unsigned long pfn;
+
+	for (pfn = resume_table_start; pfn < resume_table_end; pfn++)
+		SetPageNosave(pfn_to_page(pfn));
+	return 0;
+}
+#endif /* CONFIG_SOFTWARE_SUSPEND */
Index: linux-2.6.14-rc3/arch/x86_64/kernel/suspend_asm.S
===================================================================
--- linux-2.6.14-rc3.orig/arch/x86_64/kernel/suspend_asm.S	2005-10-01 10:37:53.000000000 +0200
+++ linux-2.6.14-rc3/arch/x86_64/kernel/suspend_asm.S	2005-10-01 14:29:48.000000000 +0200
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
Index: linux-2.6.14-rc3/include/asm-x86_64/suspend.h
===================================================================
--- linux-2.6.14-rc3.orig/include/asm-x86_64/suspend.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc3/include/asm-x86_64/suspend.h	2005-10-01 11:38:47.000000000 +0200
@@ -6,11 +6,15 @@
 #include <asm/desc.h>
 #include <asm/i387.h>
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
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
Index: linux-2.6.14-rc3/arch/x86_64/mm/init.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/x86_64/mm/init.c	2005-10-01 10:40:03.000000000 +0200
+++ linux-2.6.14-rc3/arch/x86_64/mm/init.c	2005-10-01 14:31:34.000000000 +0200
@@ -260,6 +260,9 @@
 	pmds = (end + PMD_SIZE - 1) >> PMD_SHIFT;
 	tables = round_up(puds * sizeof(pud_t), PAGE_SIZE) +
 		 round_up(pmds * sizeof(pmd_t), PAGE_SIZE);
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	tables += tables;
+#endif
 
 	table_start = find_e820_area(0x8000, __pa_symbol(&_text), tables);
 	if (table_start == -1UL)
@@ -272,6 +275,7 @@
 /* Setup the direct mapping of the physical memory at PAGE_OFFSET.
    This runs before bootmem is initialized and gets pages directly from the 
    physical memory. To access them they are temporarily mapped. */
+#ifndef CONFIG_SOFTWARE_SUSPEND
 void __init init_memory_mapping(unsigned long start, unsigned long end)
 { 
 	unsigned long next; 
@@ -307,6 +311,69 @@
 	       table_start<<PAGE_SHIFT, 
 	       table_end<<PAGE_SHIFT);
 }
+#else
+
+extern pgd_t resume_level4_pgt[];
+
+#define pgd_offset_resume(address) (resume_level4_pgt + pgd_index(address))
+
+unsigned long resume_table_start, resume_table_end;
+
+void __init init_memory_mapping(unsigned long start, unsigned long end)
+{
+	unsigned long next, start_phys;
+	int map;
+	pud_t *pud;
+	unsigned long pud_phys;
+
+	Dprintk("init_memory_mapping\n");
+
+	/*
+	 * Find space for the kernel direct mapping tables.
+	 * Later we should allocate these tables in the local node of the memory
+	 * mapped.  Unfortunately this is done currently before the nodes are
+	 * discovered.
+	 */
+	find_early_table_space(end);
+
+	start_phys = start;
+
+	start = (unsigned long)__va(start_phys);
+	end = (unsigned long)__va(end);
+
+	for (; start < end; start = next) {
+		pud = alloc_low_page(&map, &pud_phys);
+		next = start + PGDIR_SIZE;
+		if (next > end)
+			next = end;
+		phys_pud_init(pud, __pa(start), __pa(next));
+		set_pgd(pgd_offset_k(start), mk_kernel_pgd(pud_phys));
+		unmap_low_page(map);
+	}
+
+	resume_table_start = table_end;
+
+	start = (unsigned long)__va(start_phys);
+
+	for (; start < end; start = next) {
+		pud = alloc_low_page(&map, &pud_phys);
+		next = start + PGDIR_SIZE;
+		if (next > end)
+			next = end;
+		phys_pud_init(pud, __pa(start), __pa(next));
+		set_pgd(pgd_offset_resume(start), mk_kernel_pgd(pud_phys));
+		unmap_low_page(map);
+	}
+
+	resume_table_end = table_end;
+
+	asm volatile("movq %%cr4,%0" : "=r" (mmu_cr4_features));
+	__flush_tlb_all();
+	early_printk("kernel direct mapping tables upto %lx @ %lx-%lx\n", end,
+	       table_start<<PAGE_SHIFT,
+	       resume_table_start<<PAGE_SHIFT);
+}
+#endif /* CONFIG_SOFTWARE_SUSPEND */
 
 extern struct x8664_pda cpu_pda[NR_CPUS];
 
Index: linux-2.6.14-rc3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc3.orig/kernel/power/swsusp.c	2005-10-01 10:40:02.000000000 +0200
+++ linux-2.6.14-rc3/kernel/power/swsusp.c	2005-10-01 11:38:47.000000000 +0200
@@ -672,7 +672,6 @@
 		return 0;
 
 	page = pfn_to_page(pfn);
-	BUG_ON(PageReserved(page) && PageNosave(page));
 	if (PageNosave(page))
 		return 0;
 	if (PageReserved(page) && pfn_is_nosave(pfn)) {
