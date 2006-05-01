Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWEAJwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWEAJwp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 05:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWEAJwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 05:52:45 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:45197 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751098AbWEAJwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 05:52:44 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>, ebiederm@xmission.com
Message-Id: <20060501095407.16902.78809.sendpatchset@cherry.local>
Subject: [PATCH] kexec: Avoid overwriting the current pgd (x86_64)
Date: Mon,  1 May 2006 18:52:43 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kexec: Avoid overwriting the current pgd (x86_64)

This patch upgrades the x86_64-specific kexec code to avoid overwriting the
current pgd. Overwriting the current pgd is bad when CONFIG_CRASH_DUMP is used
to start a secondary kernel that dumps the memory of the previous kernel.

The code introduces a new set of page tables called "page_table_a". These
tables are used to provide an executable identity mapping without overwriting
the current pgd. The already existing page table is renamed to "page_table_b".

KEXEC_CONTROL_CODE_SIZE is changed into a single page too.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 The patch has been tested with regular kexec and CONFIG_CRASH_DUMP.
 Apply on top of 2.6.17-rc3.

 arch/x86_64/kernel/machine_kexec.c   |  138 ++++++++++++++++++++++++----------
 arch/x86_64/kernel/relocate_kernel.S |   23 ++++-
 include/asm-x86_64/kexec.h           |    3
 include/linux/kexec.h                |    7 +
 4 files changed, 126 insertions(+), 45 deletions(-)

--- 0001/arch/x86_64/kernel/machine_kexec.c
+++ work/arch/x86_64/kernel/machine_kexec.c	2006-05-01 13:14:46.000000000 +0900
@@ -2,6 +2,9 @@
  * machine_kexec.c - handle transition of Linux booting another kernel
  * Copyright (C) 2002-2005 Eric Biederman  <ebiederm@xmission.com>
  *
+ * 2006-04-27 Magnus Damm <damm@opensource.se>:
+ * - rewrote identity map code to avoid overwriting current pgd
+ *
  * This source code is licensed under the GNU General Public License,
  * Version 2.  See the file COPYING for more details.
  */
@@ -96,11 +99,15 @@ out:
 }
 
 
-static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
+static int create_page_table_b(struct kimage *image)
 {
-	pgd_t *level4p;
-	level4p = (pgd_t *)__va(start_pgtable);
- 	return init_level4_page(image, level4p, 0, end_pfn << PAGE_SHIFT);
+	image->page_table_b = kimage_alloc_control_pages(image, 0);
+
+	if (!image->page_table_b)
+		return -ENOMEM;
+
+ 	return init_level4_page(image, page_address(image->page_table_b),
+				0, end_pfn << PAGE_SHIFT);
 }
 
 static void set_idt(void *newidt, u16 limit)
@@ -147,32 +154,93 @@ static void load_segments(void)
 typedef NORET_TYPE void (*relocate_new_kernel_t)(unsigned long indirection_page,
 					unsigned long control_code_buffer,
 					unsigned long start_address,
-					unsigned long pgtable) ATTRIB_NORET;
+					unsigned long page_table_a,
+					unsigned long page_table_b) ATTRIB_NORET;
 
 const extern unsigned char relocate_new_kernel[];
 const extern unsigned long relocate_new_kernel_size;
 
-int machine_kexec_prepare(struct kimage *image)
+static int allocate_page_table_a(struct kimage *image)
 {
-	unsigned long start_pgtable, control_code_buffer;
-	int result;
+	struct page *page;
+	int k = sizeof(image->page_table_a) / sizeof(image->page_table_a[0]);
+
+	for (; k > 0; k--) {
+		page = kimage_alloc_control_pages(image, 0);
+		if (!page)
+			return -ENOMEM;
 
-	/* Calculate the offsets */
-	start_pgtable = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
-	control_code_buffer = start_pgtable + PAGE_SIZE;
-
-	/* Setup the identity mapped 64bit page table */
-	result = init_pgtable(image, start_pgtable);
-	if (result)
-		return result;
-
-	/* Place the code in the reboot code buffer */
-	memcpy(__va(control_code_buffer), relocate_new_kernel,
-						relocate_new_kernel_size);
+		clear_page(page_address(page));
+		image->page_table_a[k - 1] = page;
+	}
 
 	return 0;
 }
 
+#define _PAGE_KERNEL_EXEC __PAGE_KERNEL_EXEC
+#define pa_page(page) __pa_symbol(page_address(page)) /* __pa() miscompiles */
+
+static int create_mapping(struct page *root, struct page **pages, 
+			  unsigned long va, unsigned long pa)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	int k = 0;
+
+	pgd = (pgd_t *)page_address(root) + pgd_index(va);
+	if (!pgd_present(*pgd))
+		set_pgd(pgd, __pgd(pa_page(pages[k++]) | _KERNPG_TABLE));
+
+	pud = pud_offset(pgd, va);
+	if (!pud_present(*pud))
+		set_pud(pud, __pud(pa_page(pages[k++]) | _KERNPG_TABLE));
+
+	pmd = pmd_offset(pud, va);
+	if (!pmd_present(*pmd))
+		set_pmd(pmd, __pmd(pa_page(pages[k++]) | _KERNPG_TABLE));
+
+	pte = (pte_t *)page_address(pmd_page(*pmd)) + pte_index(va);
+	set_pte(pte, __pte(pa | _PAGE_KERNEL_EXEC));
+
+	return k;
+}
+
+int machine_kexec_prepare(struct kimage *image)
+{
+	void *control_page;
+	unsigned long pa;
+	int k;
+
+	k = allocate_page_table_a(image);
+	if (k)
+		return k;
+
+	/* fill in control_page with assembly code */
+
+	control_page = page_address(image->control_code_page);
+	memcpy(control_page, relocate_new_kernel, relocate_new_kernel_size);
+
+	/* map the control_page at the virtual address of relocate_kernel.S */
+
+	pa = __pa(control_page);
+
+	k = create_mapping(image->page_table_a[0], 
+			   &image->page_table_a[1],
+			   (unsigned long)relocate_new_kernel, pa);
+
+	/* identity map the control_page */
+
+	create_mapping(image->page_table_a[0], 
+		       &image->page_table_a[k + 1],
+		       pa, pa);
+
+	/* create identity mapped page table aka page_table_b */
+
+	return create_page_table_b(image);
+}
+
 void machine_kexec_cleanup(struct kimage *image)
 {
 	return;
@@ -185,34 +253,25 @@ void machine_kexec_cleanup(struct kimage
 NORET_TYPE void machine_kexec(struct kimage *image)
 {
 	unsigned long page_list;
-	unsigned long control_code_buffer;
-	unsigned long start_pgtable;
+	unsigned long control_code;
+	unsigned long page_table_a;
+	unsigned long page_table_b;
 	relocate_new_kernel_t rnk;
 
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
 
-	/* Calculate the offsets */
 	page_list = image->head;
-	start_pgtable = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
-	control_code_buffer = start_pgtable + PAGE_SIZE;
-
-	/* Set the low half of the page table to my identity mapped
-	 * page table for kexec.  Leave the high half pointing at the
-	 * kernel pages.   Don't bother to flush the global pages
-	 * as that will happen when I fully switch to my identity mapped
-	 * page table anyway.
-	 */
-	memcpy(__va(read_cr3()), __va(start_pgtable), PAGE_SIZE/2);
-	__flush_tlb();
-
+	control_code = __pa(page_address(image->control_code_page));
+	page_table_a = __pa(page_address(image->page_table_a[0]));
+	page_table_b = __pa(page_address(image->page_table_b));
 
 	/* The segment registers are funny things, they are
 	 * automatically loaded from a table, in memory wherever you
 	 * set them to a specific selector, but this table is never
-	 * accessed again unless you set the segment to a different selector.
+	 * accessed again you set the segment to a different selector.
 	 *
-	 * The more common model are caches where the behide
+	 * The more common model is are caches where the behide
 	 * the scenes work is done, but is also dropped at arbitrary
 	 * times.
 	 *
@@ -225,7 +284,8 @@ NORET_TYPE void machine_kexec(struct kim
 	 */
 	set_gdt(phys_to_virt(0),0);
 	set_idt(phys_to_virt(0),0);
+
 	/* now call it */
-	rnk = (relocate_new_kernel_t) control_code_buffer;
-	(*rnk)(page_list, control_code_buffer, image->start, start_pgtable);
+	rnk = (relocate_new_kernel_t) relocate_new_kernel;
+	(*rnk)(page_list, control_code, image->start, page_table_a, page_table_b);
 }
--- 0001/arch/x86_64/kernel/relocate_kernel.S
+++ work/arch/x86_64/kernel/relocate_kernel.S	2006-05-01 12:32:50.000000000 +0900
@@ -7,6 +7,10 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/page.h>
+
+.text
+.align (1 << PAGE_SHIFT)
 
 	/*
 	 * Must be relocatable PIC code callable as a C function, that once
@@ -18,21 +22,32 @@ relocate_new_kernel:
 	/* %rdi page_list
 	 * %rsi reboot_code_buffer
 	 * %rdx start address
-	 * %rcx page_table
-	 * %r8  arg5
+	 * %rcx page_table_a
+	 * %r8  page_table_b
 	 * %r9  arg6
 	 */
-
+	
 	/* zero out flags, and disable interrupts */
 	pushq $0
 	popfq
 
+	/* switch to page_table_a */
+	movq    %rcx, %cr3
+
 	/* set a new stack at the bottom of our page... */
 	lea   4096(%rsi), %rsp
 
 	/* store the parameters back on the stack */
 	pushq	%rdx /* store the start address */
 
+	/* jump to identity mapped page */
+	movq    %rsi, %rax
+	addq    $(identity_mapped - relocate_new_kernel), %rax
+	pushq   %rax
+	ret
+
+identity_mapped:
+	
 	/* Set cr0 to a known state:
 	 * 31 1 == Paging enabled
 	 * 18 0 == Alignment check disabled
@@ -69,7 +84,7 @@ relocate_new_kernel:
 	/* Switch to the identity mapped page tables,
 	 * and flush the TLB.
 	*/
-	movq	%rcx, %cr3
+	movq	%r8, %cr3
 
 	/* Do the copies */
 	movq	%rdi, %rcx 	/* Put the page_list in %rcx */
--- 0001/include/asm-x86_64/kexec.h
+++ work/include/asm-x86_64/kexec.h	2006-05-01 12:32:50.000000000 +0900
@@ -21,8 +21,7 @@
 /* Maximum address we can use for the control pages */
 #define KEXEC_CONTROL_MEMORY_LIMIT     (0xFFFFFFFFFFUL)
 
-/* Allocate one page for the pdp and the second for the code */
-#define KEXEC_CONTROL_CODE_SIZE  (4096UL + 4096UL)
+#define KEXEC_CONTROL_CODE_SIZE  4096
 
 /* The native architecture */
 #define KEXEC_ARCH KEXEC_ARCH_X86_64
--- 0003/include/linux/kexec.h
+++ work/include/linux/kexec.h	2006-05-01 12:32:50.000000000 +0900
@@ -71,6 +71,9 @@ struct kimage {
 
 	/* page_table_a[] holds enough pages to create a new page table
 	 * that maps the control page twice..
+	 *
+	 * page_table_b points to the root page of a page table which is used
+	 * to provide identity mapping of all ram.
 	 */
 
 #if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
@@ -79,6 +82,10 @@ struct kimage {
 #if defined(CONFIG_X86_32) && defined(CONFIG_X86_PAE)
 	struct page *page_table_a[5]; /* (2 * pte) + (2 * pmd) + pgd */
 #endif
+#if defined(CONFIG_X86_64)
+	struct page *page_table_a[7]; /* 2 * (pte + pud + pmd) + pgd */
+	struct page *page_table_b;
+#endif
 
 	unsigned long nr_segments;
 	struct kexec_segment segment[KEXEC_SEGMENT_MAX];
