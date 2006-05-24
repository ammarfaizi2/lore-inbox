Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbWEXEk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWEXEk6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 00:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWEXEk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 00:40:57 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:15806 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932573AbWEXEkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 00:40:47 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>, vgoyal@in.ibm.com,
       ebiederm@xmission.com
Message-Id: <20060524044247.14219.13579.sendpatchset@cherry.local>
In-Reply-To: <20060524044232.14219.68240.sendpatchset@cherry.local>
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
Subject: [PATCH 03/03] kexec: Avoid overwriting the current pgd (V2, x86_64)
Date: Wed, 24 May 2006 13:40:46 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kexec: Avoid overwriting the current pgd (V2, x86_64)

This patch upgrades the x86_64-specific kexec code to avoid overwriting the
current pgd. Overwriting the current pgd is bad when CONFIG_CRASH_DUMP is used
to start a secondary kernel that dumps the memory of the previous kernel.

The code introduces a new set of page tables called "page_table_a". These
tables are used to provide an executable identity mapping without overwriting
the current pgd. The already existing page table is renamed to "page_table_b".

KEXEC_CONTROL_CODE_SIZE is changed into a single page. This updated version of
the patch also moves the segment handling code into the reloacte_kernel.S.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 The patch has been tested with regular kexec and CONFIG_CRASH_DUMP.
 Applies on top of 2.6.16 and 2.6.17-rc4.

 arch/x86_64/kernel/machine_kexec.c   |  193 +++++++++++++++++-----------------
 arch/x86_64/kernel/relocate_kernel.S |   84 +++++++++++++-
 include/asm-x86_64/kexec.h           |   15 ++
 3 files changed, 189 insertions(+), 103 deletions(-)

--- 0001/arch/x86_64/kernel/machine_kexec.c
+++ work/arch/x86_64/kernel/machine_kexec.c	2006-05-19 12:09:39.000000000 +0900
@@ -2,6 +2,10 @@
  * machine_kexec.c - handle transition of Linux booting another kernel
  * Copyright (C) 2002-2005 Eric Biederman  <ebiederm@xmission.com>
  *
+ * 2006-05-19 Magnus Damm <damm@opensource.se>:
+ * - rewrote identity map code to avoid overwriting current pgd
+ * - moved segment handling code into relocate_kernel.S
+ *
  * This source code is licensed under the GNU General Public License,
  * Version 2.  See the file COPYING for more details.
  */
@@ -96,81 +100,110 @@ out:
 }
 
 
-static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
+static int create_page_table_b(struct kimage *image)
 {
-	pgd_t *level4p;
-	level4p = (pgd_t *)__va(start_pgtable);
- 	return init_level4_page(image, level4p, 0, end_pfn << PAGE_SHIFT);
-}
+	struct kimage_arch *arch = &image->arch_data;
 
-static void set_idt(void *newidt, u16 limit)
-{
-	struct desc_ptr curidt;
+	arch->page_table_b = kimage_alloc_control_pages(image, 0);
 
-	/* x86-64 supports unaliged loads & stores */
-	curidt.size    = limit;
-	curidt.address = (unsigned long)newidt;
+	if (!arch->page_table_b)
+		return -ENOMEM;
 
-	__asm__ __volatile__ (
-		"lidtq %0\n"
-		: : "m" (curidt)
-		);
-};
+ 	return init_level4_page(image, page_address(arch->page_table_b),
+				0, end_pfn << PAGE_SHIFT);
+}
 
+typedef NORET_TYPE void (*relocate_new_kernel_t)(unsigned long indirection_page,
+					unsigned long control_code_buffer,
+					unsigned long start_address,
+					unsigned long page_table_a,
+					unsigned long page_table_b) ATTRIB_NORET;
+
+const extern unsigned char relocate_new_kernel[];
+const extern unsigned long relocate_new_kernel_size;
 
-static void set_gdt(void *newgdt, u16 limit)
+static int allocate_page_table_a(struct kimage *image)
 {
-	struct desc_ptr curgdt;
+	struct kimage_arch *arch = &image->arch_data;
+	struct page *page;
+	int k = sizeof(arch->page_table_a) / sizeof(arch->page_table_a[0]);
 
-	/* x86-64 supports unaligned loads & stores */
-	curgdt.size    = limit;
-	curgdt.address = (unsigned long)newgdt;
+	for (; k > 0; k--) {
+		page = kimage_alloc_control_pages(image, 0);
+		if (!page)
+			return -ENOMEM;
 
-	__asm__ __volatile__ (
-		"lgdtq %0\n"
-		: : "m" (curgdt)
-		);
-};
+		clear_page(page_address(page));
+		arch->page_table_a[k - 1] = page;
+	}
 
-static void load_segments(void)
-{
-	__asm__ __volatile__ (
-		"\tmovl %0,%%ds\n"
-		"\tmovl %0,%%es\n"
-		"\tmovl %0,%%ss\n"
-		"\tmovl %0,%%fs\n"
-		"\tmovl %0,%%gs\n"
-		: : "a" (__KERNEL_DS) : "memory"
-		);
+	return 0;
 }
 
-typedef NORET_TYPE void (*relocate_new_kernel_t)(unsigned long indirection_page,
-					unsigned long control_code_buffer,
-					unsigned long start_address,
-					unsigned long pgtable) ATTRIB_NORET;
+#define _PAGE_KERNEL_EXEC __PAGE_KERNEL_EXEC
+#define pa_page(page) __pa_symbol(page_address(page)) /* __pa() miscompiles */
 
-const extern unsigned char relocate_new_kernel[];
-const extern unsigned long relocate_new_kernel_size;
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
 
 int machine_kexec_prepare(struct kimage *image)
 {
-	unsigned long start_pgtable, control_code_buffer;
-	int result;
+	void *control_page;
+	unsigned long pa;
+	int k;
 
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
+	memset(&image->arch_data, 0, sizeof(image->arch_data));
 
-	return 0;
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
+	k = create_mapping(image->arch_data.page_table_a[0], 
+			   &image->arch_data.page_table_a[1],
+			   (unsigned long)relocate_new_kernel, pa);
+
+	/* identity map the control_page */
+
+	create_mapping(image->arch_data.page_table_a[0], 
+		       &image->arch_data.page_table_a[k + 1],
+		       pa, pa);
+
+	/* create identity mapped page table aka page_table_b */
+
+	return create_page_table_b(image);
 }
 
 void machine_kexec_cleanup(struct kimage *image)
@@ -185,47 +218,17 @@ void machine_kexec_cleanup(struct kimage
 NORET_TYPE void machine_kexec(struct kimage *image)
 {
 	unsigned long page_list;
-	unsigned long control_code_buffer;
-	unsigned long start_pgtable;
+	unsigned long control_code;
+	unsigned long page_table_a;
+	unsigned long page_table_b;
 	relocate_new_kernel_t rnk;
 
-	/* Interrupts aren't acceptable while we reboot */
-	local_irq_disable();
-
-	/* Calculate the offsets */
 	page_list = image->head;
-	start_pgtable = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
-	control_code_buffer = start_pgtable + PAGE_SIZE;
+	control_code = __pa(page_address(image->control_code_page));
+	page_table_a = __pa(page_address(image->arch_data.page_table_a[0]));
+	page_table_b = __pa(page_address(image->arch_data.page_table_b));
 
-	/* Set the low half of the page table to my identity mapped
-	 * page table for kexec.  Leave the high half pointing at the
-	 * kernel pages.   Don't bother to flush the global pages
-	 * as that will happen when I fully switch to my identity mapped
-	 * page table anyway.
-	 */
-	memcpy(__va(read_cr3()), __va(start_pgtable), PAGE_SIZE/2);
-	__flush_tlb();
-
-
-	/* The segment registers are funny things, they are
-	 * automatically loaded from a table, in memory wherever you
-	 * set them to a specific selector, but this table is never
-	 * accessed again unless you set the segment to a different selector.
-	 *
-	 * The more common model are caches where the behide
-	 * the scenes work is done, but is also dropped at arbitrary
-	 * times.
-	 *
-	 * I take advantage of this here by force loading the
-	 * segments, before I zap the gdt with an invalid value.
-	 */
-	load_segments();
-	/* The gdt & idt are now invalid.
-	 * If you want to load them you must set up your own idt & gdt.
-	 */
-	set_gdt(phys_to_virt(0),0);
-	set_idt(phys_to_virt(0),0);
 	/* now call it */
-	rnk = (relocate_new_kernel_t) control_code_buffer;
-	(*rnk)(page_list, control_code_buffer, image->start, start_pgtable);
+	rnk = (relocate_new_kernel_t) relocate_new_kernel;
+	(*rnk)(page_list, control_code, image->start, page_table_a, page_table_b);
 }
--- 0001/arch/x86_64/kernel/relocate_kernel.S
+++ work/arch/x86_64/kernel/relocate_kernel.S	2006-05-19 12:11:13.000000000 +0900
@@ -2,11 +2,18 @@
  * relocate_kernel.S - put the kernel image in place to boot
  * Copyright (C) 2002-2005 Eric Biederman  <ebiederm@xmission.com>
  *
+ * 2006-05-19 Magnus Damm <damm@opensource.se>:
+ * - moved segment handling code from machine_kexec.c
+ *
  * This source code is licensed under the GNU General Public License,
  * Version 2.  See the file COPYING for more details.
  */
 
 #include <linux/linkage.h>
+#include <asm/page.h>
+
+.text
+.align (1 << PAGE_SHIFT)
 
 	/*
 	 * Must be relocatable PIC code callable as a C function, that once
@@ -18,21 +25,69 @@ relocate_new_kernel:
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
+	/* setup idt */
+
+	movq	%rsi, %rax
+	addq	$(idt_48 - relocate_new_kernel), %rax
+	lidtq	(%rax)
+
+	/* setup gdt */
+
+	movq	%rsi, %rax
+	addq	$(gdt - relocate_new_kernel), %rax
+	movq	%rsi, %r9
+	addq	$((gdt_48 - relocate_new_kernel) + 2), %r9
+	movq	%rax, (%r9)
+	
+	movq	%rsi, %rax
+	addq	$(gdt_48 - relocate_new_kernel), %rax
+	lgdtq	(%rax)
+
+	/* setup data segment registers */
+
+	xorl	%eax,%eax
+	movl	%eax, %ds
+	movl	%eax, %es
+	movl	%eax, %fs
+	movl	%eax, %gs
+	movl	%eax, %ss
+
 	/* set a new stack at the bottom of our page... */
 	lea   4096(%rsi), %rsp
 
+	/* load new code segment */
+
+	movq	%rsp, %rcx
+	xorq	%rax, %rax
+	pushq	%rax                                              /* SS */
+	pushq	%rcx                                              /* ESP */
+	pushq	%rax                                              /* RFLAGS */
+
+	movq	$(gdt_code - gdt), %rax
+	pushq	%rax                                              /* CS */
+
+	movq	%rsi, %rax
+	addq	$(identity_mapped - relocate_new_kernel), %rax
+	pushq	%rax                                              /* RIP */
+
+	iretq
+	
+identity_mapped:
 	/* store the parameters back on the stack */
 	pushq	%rdx /* store the start address */
-
+	
 	/* Set cr0 to a known state:
 	 * 31 1 == Paging enabled
 	 * 18 0 == Alignment check disabled
@@ -69,7 +124,7 @@ relocate_new_kernel:
 	/* Switch to the identity mapped page tables,
 	 * and flush the TLB.
 	*/
-	movq	%rcx, %cr3
+	movq	%r8, %cr3
 
 	/* Do the copies */
 	movq	%rdi, %rcx 	/* Put the page_list in %rcx */
@@ -136,6 +191,25 @@ relocate_new_kernel:
 	xorq	%r15, %r15
 
 	ret
+	.align	16
+gdt:
+	.long   0x00000000  /* NULL descriptor */
+	.long   0x00000000
+gdt_code:
+	.long   0x00000000  /* code descriptor */
+	.long   0x00209800
+
+gdt_end:
+	.align	4
+	
+idt_48:
+	.word	0				# idt limit = 0
+	.quad	0, 0				# idt base = 0L
+
+gdt_48:
+	.word	gdt_end - gdt - 1		# gdt limit
+	.quad	0, 0				# gdt base (filled in later)
+
 relocate_new_kernel_end:
 
 	.globl relocate_new_kernel_size
--- 0002/include/asm-x86_64/kexec.h
+++ work/include/asm-x86_64/kexec.h	2006-05-19 12:07:33.000000000 +0900
@@ -21,15 +21,24 @@
 /* Maximum address we can use for the control pages */
 #define KEXEC_CONTROL_MEMORY_LIMIT     (0xFFFFFFFFFFUL)
 
-/* Allocate one page for the pdp and the second for the code */
-#define KEXEC_CONTROL_CODE_SIZE  (4096UL + 4096UL)
+#define KEXEC_CONTROL_CODE_SIZE  4096
 
 /* The native architecture */
 #define KEXEC_ARCH KEXEC_ARCH_X86_64
 
 #define MAX_NOTE_BYTES 1024
 
-struct kimage_arch {};
+struct kimage_arch {
+	/* page_table_a[] holds enough pages to create a new page table
+	 * that maps the control page twice..
+	 *
+	 * page_table_b points to the root page of a page table which is used
+	 * to provide identity mapping of all ram.
+	 */
+
+	struct page *page_table_a[7]; /* 2 * (pte + pud + pmd) + pgd */
+	struct page *page_table_b;
+};
 
 /*
  * Saving the registers of the cpu on which panic occured in
