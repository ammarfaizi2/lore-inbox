Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbVJBKYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbVJBKYw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 06:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbVJBKYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 06:24:52 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:36329 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751047AbVJBKYv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 06:24:51 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH][Fix] swsusp: Yet another attempt to fix Bug #4959
Date: Sun, 2 Oct 2005 12:25:46 +0200
User-Agent: KMail/1.8.2
Cc: "Discuss x86-64" <discuss@x86-64.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200510011813.54755.rjw@sisk.pl> <200510012145.30067.ak@suse.de>
In-Reply-To: <200510012145.30067.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510021225.47048.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 1 of October 2005 21:45, Andi Kleen wrote:
> On Saturday 01 October 2005 18:13, Rafael J. Wysocki wrote:
> 
> >
> > This function allocates twice as much memory as needed for the direct
> > mapping page tables and assigns the second half of it to the resume page
> > tables.  This area is later marked with PG_nosave by swsusp, so that it is
> > not overwritten during resume.
> >
> I prefered it when the additional page tables were allocated only on demand.

Me too.  Let's get back to that patch, then. :-)

Comments etc. will be appreciated.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc3-git1/arch/x86_64/kernel/suspend.c
===================================================================
--- linux-2.6.14-rc3-git1.orig/arch/x86_64/kernel/suspend.c	2005-10-02 10:39:41.000000000 +0200
+++ linux-2.6.14-rc3-git1/arch/x86_64/kernel/suspend.c	2005-10-02 12:12:27.000000000 +0200
@@ -11,6 +11,8 @@
 #include <linux/smp.h>
 #include <linux/suspend.h>
 #include <asm/proto.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
 
 struct saved_context saved_context;
 
@@ -140,4 +142,132 @@
 
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+/* Defined in kernel/power/swsusp.c */
+extern unsigned long get_usable_page(unsigned gfp_mask);
+extern void free_eaten_memory(void);
+/* Defined in arch/x86_64/kernel/suspend_asm.S */
+extern int restore_image(void);
 
+pgd_t *temp_level4_pgt;
+
+static void **pages;
+
+static inline void *__add_page(void)
+{
+	void **c;
+
+	c = (void **)get_usable_page(GFP_ATOMIC);
+	if (c) {
+		*c = pages;
+		pages = c;
+	}
+	return c;
+}
+
+static inline void *__next_page(void)
+{
+	void **c;
+
+	c = pages;
+	if (c) {
+		pages = *c;
+		*c = NULL;
+	}
+	return c;
+}
+
+/*
+ * Try to allocate as many usable pages as needed and daisy chain them.
+ * If one allocation fails, free the pages allocated so far
+ */
+static int alloc_usable_pages(unsigned long n)
+{
+	void *p;
+
+	pages = NULL;
+	do
+		if (!__add_page())
+			break;
+	while (--n);
+	if (n) {
+		p = __next_page();
+		while (p) {
+			free_page((unsigned long)p);
+			p = __next_page();
+		}
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void phys_pud_init(pud_t *pud, unsigned long address, unsigned long end)
+{
+	long i, j;
+
+	i = pud_index(address);
+	pud = pud + i;
+	for (; i < PTRS_PER_PUD; pud++, i++) {
+		unsigned long paddr;
+		pmd_t *pmd;
+
+		paddr = address + i*PUD_SIZE;
+		if (paddr >= end)
+			break;
+
+		pmd = (pmd_t *)__next_page();
+		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
+		for (j = 0; j < PTRS_PER_PMD; pmd++, j++, paddr += PMD_SIZE) {
+			unsigned long pe;
+
+			if (paddr >= end)
+				break;
+			pe = _PAGE_NX|_PAGE_PSE | _KERNPG_TABLE | _PAGE_GLOBAL | paddr;
+			pe &= __supported_pte_mask;
+			set_pmd(pmd, __pmd(pe));
+		}
+	}
+}
+
+static void set_up_temporary_mappings(void)
+{
+	unsigned long start, end, next;
+
+	temp_level4_pgt = (pgd_t *)__next_page();
+
+	/* It is safe to reuse the original kernel mapping */
+	set_pgd(temp_level4_pgt + pgd_index(__START_KERNEL_map),
+		init_level4_pgt[pgd_index(__START_KERNEL_map)]);
+
+	/* Set up the direct mapping from scratch */
+	start = (unsigned long)pfn_to_kaddr(0);
+	end = (unsigned long)pfn_to_kaddr(end_pfn);
+
+	for (; start < end; start = next) {
+		pud_t *pud = (pud_t *)__next_page();
+		next = start + PGDIR_SIZE;
+		if (next > end)
+			next = end;
+		phys_pud_init(pud, __pa(start), __pa(next));
+		set_pgd(temp_level4_pgt + pgd_index(start),
+			mk_kernel_pgd(__pa(pud)));
+	}
+}
+
+int swsusp_arch_resume(void)
+{
+	unsigned long n;
+
+	n = ((end_pfn << PAGE_SHIFT) + PUD_SIZE - 1) >> PUD_SHIFT;
+	n += (n + PTRS_PER_PUD - 1) / PTRS_PER_PUD + 1;
+	pr_debug("swsusp_arch_resume(): pages needed = %lu\n", n);
+	if (alloc_usable_pages(n)) {
+		free_eaten_memory();
+		return -ENOMEM;
+	}
+	/* We have got enough memory and from now on we cannot recover */
+	set_up_temporary_mappings();
+	restore_image();
+	return 0;
+}
+#endif /* CONFIG_SOFTWARE_SUSPEND */
Index: linux-2.6.14-rc3-git1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc3-git1.orig/kernel/power/swsusp.c	2005-10-02 10:39:41.000000000 +0200
+++ linux-2.6.14-rc3-git1/kernel/power/swsusp.c	2005-10-02 12:11:08.000000000 +0200
@@ -1095,7 +1095,7 @@
 	*eaten_memory = c;
 }
 
-static unsigned long get_usable_page(unsigned gfp_mask)
+unsigned long get_usable_page(unsigned gfp_mask)
 {
 	unsigned long m;
 
@@ -1109,7 +1109,7 @@
 	return m;
 }
 
-static void free_eaten_memory(void)
+void free_eaten_memory(void)
 {
 	unsigned long m;
 	void **c;
@@ -1481,11 +1481,12 @@
 	/* Allocate memory for the image and read the data from swap */
 
 	error = check_pagedir(pagedir_nosave);
-	free_eaten_memory();
+
 	if (!error)
 		error = data_read(pagedir_nosave);
 
 	if (error) { /* We fail cleanly */
+		free_eaten_memory();
 		for_each_pbe (p, pagedir_nosave)
 			if (p->address) {
 				free_page(p->address);
Index: linux-2.6.14-rc3-git1/arch/x86_64/kernel/suspend_asm.S
===================================================================
--- linux-2.6.14-rc3-git1.orig/arch/x86_64/kernel/suspend_asm.S	2005-10-02 10:39:41.000000000 +0200
+++ linux-2.6.14-rc3-git1/arch/x86_64/kernel/suspend_asm.S	2005-10-02 11:30:55.000000000 +0200
@@ -39,12 +39,13 @@
 	call swsusp_save
 	ret
 
-ENTRY(swsusp_arch_resume)
-	/* set up cr3 */	
-	leaq	init_level4_pgt(%rip),%rax
-	subq	$__START_KERNEL_map,%rax
-	movq	%rax,%cr3
-
+ENTRY(restore_image)
+	/* switch to temporary page tables */
+	movq	$__PAGE_OFFSET, %rdx
+	movq	temp_level4_pgt(%rip), %rax
+	subq	%rdx, %rax
+	movq	%rax, %cr3
+	/* Flush TLB */
 	movq	mmu_cr4_features(%rip), %rax
 	movq	%rax, %rdx
 	andq	$~(1<<7), %rdx	# PGE
@@ -69,6 +70,10 @@
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
