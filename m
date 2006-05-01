Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWEAJtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWEAJtS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 05:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWEAJtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 05:49:18 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:34701 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751095AbWEAJtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 05:49:17 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>, ebiederm@xmission.com
Message-Id: <20060501095041.16897.49541.sendpatchset@cherry.local>
Subject: [PATCH] kexec: Avoid overwriting the current pgd (i386)
Date: Mon,  1 May 2006 18:49:16 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kexec: Avoid overwriting the current pgd (i386)

This patch upgrades the i386-specific kexec code to avoid overwriting the
current pgd. Overwriting the current pgd is bad when CONFIG_CRASH_DUMP is used
to start a secondary kernel that dumps the memory of the previous kernel.

The code introduces a new set of page tables called "page_table_a". These
tables are used to provide an executable identity mapping without overwriting
the current pgd.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 The patch has been tested with regular kexec and CONFIG_CRASH_DUMP.
 Both PAE and non-PAE configurations work well. Apply on top of 2.6.17-rc3.

 arch/i386/kernel/machine_kexec.c   |  174 +++++++++++++++++++-----------------
 arch/i386/kernel/relocate_kernel.S |   19 +++
 include/linux/kexec.h              |   11 ++
 3 files changed, 121 insertions(+), 83 deletions(-)

--- 0001/arch/i386/kernel/machine_kexec.c
+++ work/arch/i386/kernel/machine_kexec.c	2006-05-01 11:38:13.000000000 +0900
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
@@ -19,72 +22,6 @@
 #include <asm/desc.h>
 #include <asm/system.h>
 
-#define PAGE_ALIGNED __attribute__ ((__aligned__(PAGE_SIZE)))
-
-#define L0_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
-#define L1_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
-#define L2_ATTR (_PAGE_PRESENT)
-
-#define LEVEL0_SIZE (1UL << 12UL)
-
-#ifndef CONFIG_X86_PAE
-#define LEVEL1_SIZE (1UL << 22UL)
-static u32 pgtable_level1[1024] PAGE_ALIGNED;
-
-static void identity_map_page(unsigned long address)
-{
-	unsigned long level1_index, level2_index;
-	u32 *pgtable_level2;
-
-	/* Find the current page table */
-	pgtable_level2 = __va(read_cr3());
-
-	/* Find the indexes of the physical address to identity map */
-	level1_index = (address % LEVEL1_SIZE)/LEVEL0_SIZE;
-	level2_index = address / LEVEL1_SIZE;
-
-	/* Identity map the page table entry */
-	pgtable_level1[level1_index] = address | L0_ATTR;
-	pgtable_level2[level2_index] = __pa(pgtable_level1) | L1_ATTR;
-
-	/* Flush the tlb so the new mapping takes effect.
-	 * Global tlb entries are not flushed but that is not an issue.
-	 */
-	load_cr3(pgtable_level2);
-}
-
-#else
-#define LEVEL1_SIZE (1UL << 21UL)
-#define LEVEL2_SIZE (1UL << 30UL)
-static u64 pgtable_level1[512] PAGE_ALIGNED;
-static u64 pgtable_level2[512] PAGE_ALIGNED;
-
-static void identity_map_page(unsigned long address)
-{
-	unsigned long level1_index, level2_index, level3_index;
-	u64 *pgtable_level3;
-
-	/* Find the current page table */
-	pgtable_level3 = __va(read_cr3());
-
-	/* Find the indexes of the physical address to identity map */
-	level1_index = (address % LEVEL1_SIZE)/LEVEL0_SIZE;
-	level2_index = (address % LEVEL2_SIZE)/LEVEL1_SIZE;
-	level3_index = address / LEVEL2_SIZE;
-
-	/* Identity map the page table entry */
-	pgtable_level1[level1_index] = address | L0_ATTR;
-	pgtable_level2[level2_index] = __pa(pgtable_level1) | L1_ATTR;
-	set_64bit(&pgtable_level3[level3_index],
-					       __pa(pgtable_level2) | L2_ATTR);
-
-	/* Flush the tlb so the new mapping takes effect.
-	 * Global tlb entries are not flushed but that is not an issue.
-	 */
-	load_cr3(pgtable_level3);
-}
-#endif
-
 static void set_idt(void *newidt, __u16 limit)
 {
 	struct Xgt_desc_struct curidt;
@@ -96,7 +33,6 @@ static void set_idt(void *newidt, __u16 
 	load_idt(&curidt);
 };
 
-
 static void set_gdt(void *newgdt, __u16 limit)
 {
 	struct Xgt_desc_struct curgdt;
@@ -131,12 +67,66 @@ typedef asmlinkage NORET_TYPE void (*rel
 					unsigned long indirection_page,
 					unsigned long reboot_code_buffer,
 					unsigned long start_address,
-					unsigned int has_pae) ATTRIB_NORET;
+					unsigned long page_table_a,
+					unsigned long has_pae) ATTRIB_NORET;
 
 const extern unsigned char relocate_new_kernel[];
 extern void relocate_new_kernel_end(void);
 const extern unsigned int relocate_new_kernel_size;
 
+static int allocate_page_table_a(struct kimage *image)
+{
+	struct page *page;
+	int k = sizeof(image->page_table_a) / sizeof(image->page_table_a[0]);
+
+	for (; k > 0; k--) {
+		page = kimage_alloc_control_pages(image, 0);
+		if (!page)
+			return -ENOMEM;
+
+		clear_page(page_address(page));
+		image->page_table_a[k - 1] = page;
+	}
+
+	return 0;
+}
+
+/* workaround for include/asm-i386/pgtable-3level.h */
+
+#ifdef CONFIG_X86_PAE
+#undef pud_present
+#define pud_present(pud) (pud_val(pud) & _PAGE_PRESENT)
+#endif
+
+#define pa_page(page) __pa(page_address(page))
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
 /*
  * A architecture hook called to validate the
  * proposed image and prepare the control pages
@@ -152,6 +142,33 @@ const extern unsigned int relocate_new_k
  */
 int machine_kexec_prepare(struct kimage *image)
 {
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
 	return 0;
 }
 
@@ -170,24 +187,16 @@ void machine_kexec_cleanup(struct kimage
 NORET_TYPE void machine_kexec(struct kimage *image)
 {
 	unsigned long page_list;
-	unsigned long reboot_code_buffer;
-
+	unsigned long control_code;
+	unsigned long page_table_a;
 	relocate_new_kernel_t rnk;
 
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
 
-	/* Compute some offsets */
-	reboot_code_buffer = page_to_pfn(image->control_code_page)
-								<< PAGE_SHIFT;
 	page_list = image->head;
-
-	/* Set up an identity mapping for the reboot_code_buffer */
-	identity_map_page(reboot_code_buffer);
-
-	/* copy it out */
-	memcpy((void *)reboot_code_buffer, relocate_new_kernel,
-						relocate_new_kernel_size);
+	control_code = __pa(page_address(image->control_code_page));
+	page_table_a = __pa(page_address(image->page_table_a[0]));
 
 	/* The segment registers are funny things, they are
 	 * automatically loaded from a table, in memory wherever you
@@ -209,6 +218,7 @@ NORET_TYPE void machine_kexec(struct kim
 	set_idt(phys_to_virt(0),0);
 
 	/* now call it */
-	rnk = (relocate_new_kernel_t) reboot_code_buffer;
-	(*rnk)(page_list, reboot_code_buffer, image->start, cpu_has_pae);
+	rnk = (relocate_new_kernel_t) relocate_new_kernel;
+	(*rnk)(page_list, control_code, image->start, 
+	       page_table_a, (unsigned long)cpu_has_pae);
 }
--- 0001/arch/i386/kernel/relocate_kernel.S
+++ work/arch/i386/kernel/relocate_kernel.S	2006-05-01 11:13:14.000000000 +0900
@@ -7,7 +7,11 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/page.h>
 
+.text
+.align (1 << PAGE_SHIFT)
+	
 	/*
 	 * Must be relocatable PIC code callable as a C function, that once
 	 * it starts can not use the previous processes stack.
@@ -18,18 +22,31 @@ relocate_new_kernel:
 	movl  4(%esp), %ebx /* page_list */
 	movl  8(%esp), %ebp /* reboot_code_buffer */
 	movl  12(%esp), %edx /* start address */
-	movl  16(%esp), %ecx /* cpu_has_pae */
+	movl  16(%esp), %edi /* page_table_a */
+	movl  20(%esp), %ecx /* cpu_has_pae */
 
 	/* zero out flags, and disable interrupts */
 	pushl $0
 	popfl
 
+	/* switch to page_table_a */
+	movl	%edi, %eax
+	movl	%eax, %cr3
+
 	/* set a new stack at the bottom of our page... */
 	lea   4096(%ebp), %esp
 
 	/* store the parameters back on the stack */
 	pushl   %edx /* store the start address */
 
+	/* jump to identity mapped page */
+	movl	%ebp, %eax
+	addl	$(identity_mapped - relocate_new_kernel), %eax
+	pushl	%eax
+	ret
+	
+identity_mapped:	
+	
 	/* Set cr0 to a known state:
 	 * 31 0 == Paging disabled
 	 * 18 0 == Alignment check disabled
--- 0001/include/linux/kexec.h
+++ work/include/linux/kexec.h	2006-05-01 11:13:14.000000000 +0900
@@ -69,6 +69,17 @@ struct kimage {
 	unsigned long start;
 	struct page *control_code_page;
 
+	/* page_table_a[] holds enough pages to create a new page table
+	 * that maps the control page twice..
+	 */
+
+#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
+	struct page *page_table_a[3]; /* (2 * pte) + pgd */
+#endif
+#if defined(CONFIG_X86_32) && defined(CONFIG_X86_PAE)
+	struct page *page_table_a[5]; /* (2 * pte) + (2 * pmd) + pgd */
+#endif
+
 	unsigned long nr_segments;
 	struct kexec_segment segment[KEXEC_SEGMENT_MAX];
 
