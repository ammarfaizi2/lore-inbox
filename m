Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSKXTzO>; Sun, 24 Nov 2002 14:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbSKXTzO>; Sun, 24 Nov 2002 14:55:14 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3332 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261599AbSKXTzE>;
	Sun, 24 Nov 2002 14:55:04 -0500
Date: Sat, 23 Nov 2002 20:55:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: suspend-to-ram: don't crash when kernel gets big
Message-ID: <20021123195525.GA2776@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When kernel is too big (like 2.5.49 with pretty minimal options :-),
s3 triplefaults during resume. This fixes it, please apply,
								Pavel

--- clean/arch/i386/kernel/acpi.c	2002-09-22 23:46:52.000000000 +0200
+++ linux-swsusp/arch/i386/kernel/acpi.c	2002-11-20 15:30:31.000000000 +0100
@@ -446,74 +446,11 @@
 
 #ifdef CONFIG_ACPI_SLEEP
 
-#define DEBUG
-
-#ifdef DEBUG
-#include <linux/serial.h>
-#endif
-
 /* address in low memory of the wakeup routine. */
 unsigned long acpi_wakeup_address = 0;
 
-/* new page directory that we will be using */
-static pmd_t *pmd;
-
-/* saved page directory */
-static pmd_t saved_pmd;
-
-/* page which we'll use for the new page directory */
-static pte_t *ptep;
-
 extern unsigned long FASTCALL(acpi_copy_wakeup_routine(unsigned long));
 
-/*
- * acpi_create_identity_pmd
- *
- * Create a new, identity mapped pmd.
- *
- * Do this by creating new page directory, and marking all the pages as R/W
- * Then set it as the new Page Middle Directory.
- * And, of course, flush the TLB so it takes effect.
- *
- * We save the address of the old one, for later restoration.
- */
-static void acpi_create_identity_pmd (void)
-{
-	pgd_t *pgd;
-	int i;
-
-	ptep = (pte_t*)__get_free_page(GFP_KERNEL);
-
-	/* fill page with low mapping */
-	for (i = 0; i < PTRS_PER_PTE; i++)
-		set_pte(ptep + i, pfn_pte(i, PAGE_SHARED));
-
-	pgd = pgd_offset(current->active_mm, 0);
-	pmd = pmd_alloc(current->mm,pgd, 0);
-
-	/* save the old pmd */
-	saved_pmd = *pmd;
-
-	/* set the new one */
-	set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(ptep)));
-
-	/* flush the TLB */
-	local_flush_tlb();
-}
-
-/*
- * acpi_restore_pmd
- *
- * Restore the old pmd saved by acpi_create_identity_pmd and
- * free the page that said function alloc'd
- */
-static void acpi_restore_pmd (void)
-{
-	set_pmd(pmd, saved_pmd);
-	local_flush_tlb();
-	free_page((unsigned long)ptep);
-}
-
 /**
  * acpi_save_state_mem - save kernel state
  *
@@ -522,7 +459,15 @@
  */
 int acpi_save_state_mem (void)
 {
-	acpi_create_identity_pmd();
+	if (!cpu_has_pse) {
+		printk(KERN_ERR "You have S3 capable machine without pse? Wow!");
+		return 1;
+	}
+#if CONFIG_X86_PAE
+	panic("S3 and PAE do not like each other for now.");
+	return 1;
+#endif
+	init_physical_mapping(swapper_pg_dir, 0, USER_PTRS_PER_PGD);
 	acpi_copy_wakeup_routine(acpi_wakeup_address);
 
 	return 0;
@@ -542,7 +487,7 @@
  */
 void acpi_restore_state_mem (void)
 {
-	acpi_restore_pmd();
+	zap_low_mappings();
 }
 
 /**
@@ -555,7 +500,10 @@
  */
 void __init acpi_reserve_bootmem(void)
 {
+	extern long wakeup_start, wakeup_end;
 	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE);
+	if ((&wakeup_end - &wakeup_start) > PAGE_SIZE)
+		printk(KERN_CRIT "ACPI: Wakeup code way too big, will crash on attempt to suspend\n");
 	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n", acpi_wakeup_address);
 }
 
--- clean/arch/i386/kernel/acpi_wakeup.S	2002-11-19 16:45:58.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/acpi_wakeup.S	2002-11-20 14:56:23.000000000 +0100
@@ -1,12 +1,17 @@
-
 .text
 #include <linux/linkage.h>
 #include <asm/segment.h>
+#include <asm/page.h>
 
-# Do we need to deal with A20?
+#
+# wakeup_code runs in real mode, and at unknown address (determined at run-time).
+# Therefore it must only use relative jumps/calls. 
+#
+# Do we need to deal with A20? It seems okay
 
 ALIGN
-wakeup_start:
+	.align	4096
+ENTRY(wakeup_start)
 wakeup_code:
 	wakeup_code_start = .
 	.code16
@@ -14,49 +19,79 @@
  	movw	$0xb800, %ax
 	movw	%ax,%fs
 	movw	$0x0e00 + 'L', %fs:(0x10)
+	
 	cli
 	cld
-	  
-	# setup data segment
-	movw	%cs, %ax
 
-	addw	$(wakeup_data - wakeup_code) >> 4, %ax
-	movw	%ax, %ds
-	movw	%ax, %ss
-	mov	$(wakeup_stack - wakeup_data), %sp		# Private stack is needed for ASUS board
+# We are now probably running at something like 0x0000 : 0x1000
+	call here
+here:
+	pop	 %bx
+	subw	$(here-wakeup_start), %bx
+	shrw	$4, %bx
+	
+        # setup data segment
+        movw    %cs, %ax
+	addw    %bx, %ax
+	movw    %ax, %ds					# Make ds:0 point to wakeup_start
+	movw    %ax, %ss
+	mov	$(wakeup_stack-wakeup_code), %sp		# Private stack is needed for ASUS board
 	movw	$0x0e00 + 'S', %fs:(0x12)	
 
-	movl	real_magic - wakeup_data, %eax
+	pushl	$0						# Kill any dangerous flags
+	popfl
+	cli
+	cld
+	
+	movl	real_magic-wakeup_code, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_real_magic
-
-	mov	video_mode - wakeup_data, %ax
+#if 0
+	lcall   $0xc000,$3
+	jmp	bogus_real_magic
+#endif
+#if 0
+	mov	video_mode, %ax
 	call	mode_set
+#endif
 
 	# set up page table
-	movl	(real_save_cr3 - wakeup_data), %eax
+#	movl	real_save_cr3-wakeup_code, %eax
+	movl	$swapper_pg_dir-__PAGE_OFFSET,%eax
 	movl	%eax, %cr3
 
 	# make sure %cr4 is set correctly (features, etc)
-	movl	(real_save_cr4 - wakeup_data), %eax
+	movl	real_save_cr4-wakeup_code, %eax
 	movl	%eax, %cr4
 	movw	$0xb800, %ax
 	movw	%ax,%fs
 	movw	$0x0e00 + 'i', %fs:(0x12)
-
+	
 	# need a gdt
-	lgdt	real_save_gdt - wakeup_data
+	lgdt	real_save_gdt-wakeup_code
 
-	movl	(real_save_cr0 - wakeup_data), %eax
+	movl	real_save_cr0-wakeup_code, %eax
 	movl	%eax, %cr0
+	jmp 1f
+1:
 	movw	$0x0e00 + 'n', %fs:(0x14)
 
-	movl	real_magic - wakeup_data, %eax
+	movl	real_magic-wakeup_code, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_real_magic
 
 	ljmpl	$__KERNEL_CS,$wakeup_pmode_return
 
+wakeup_data:
+		.word 0
+real_save_gdt:	.word 0
+		.long 0
+real_save_cr0:	.long 0
+real_save_cr3:	.long 0
+real_save_cr4:	.long 0
+real_magic:	.long 0
+video_mode:	.long 0
+
 bogus_real_magic:
 	movw	$0x0e00 + 'B', %fs:(0x12)
 	jmp bogus_real_magic
@@ -129,20 +164,12 @@
 	.code32
 	ALIGN
 
-.org	0x300
-wakeup_data:
-		.word 0
-real_save_gdt:	.word 0
-		.long 0
-real_save_cr0:	.long 0
-real_save_cr3:	.long 0
-real_save_cr4:	.long 0
-real_magic:	.long 0
-video_mode:	.long 0
 
-.org	0x500
+.org	0x2000
 wakeup_stack:
-wakeup_end:
+.org	0x3000
+ENTRY(wakeup_end)
+.org	0x4000
 
 wakeup_pmode_return:
 	movl	$__KERNEL_DS, %eax
@@ -228,7 +258,7 @@
 
 	movl	%eax, %edi
 	leal	wakeup_start, %esi
-	movl	$(wakeup_end - wakeup_start) >> 2, %ecx
+	movl	$(wakeup_end - wakeup_start + 3) >> 2, %ecx
 
 	rep ;  movsl
 
@@ -290,8 +320,8 @@
 	ret
 	.p2align 4,,7
 .L1432:
-	movl $104,%eax
-	movw %eax, %ds
+	movl $__KERNEL_DS,%eax
+	movw %ax, %ds
 	movl saved_context_esp, %esp
 	movl saved_context_ebp, %ebp
 	movl saved_context_eax, %eax
@@ -310,5 +340,4 @@
 saved_idt:	.long	0,0
 saved_ldt:	.long	0
 saved_tss:	.long	0
-saved_cr0:	.long	0
 
--- clean/arch/i386/mm/init.c	2002-11-19 16:45:26.000000000 +0100
+++ linux-swsusp/arch/i386/mm/init.c	2002-11-20 15:05:29.000000000 +0100
@@ -117,24 +117,18 @@
 	}
 }
 
-/*
- * This maps the physical memory to kernel virtual address space, a total 
- * of max_low_pfn pages, by creating page tables starting from address 
- * PAGE_OFFSET.
- */
-static void __init kernel_physical_mapping_init(pgd_t *pgd_base)
+void init_physical_mapping(pgd_t *pgd_base, int pgd_ofs, int pgd_limit)
 {
 	unsigned long pfn;
 	pgd_t *pgd;
 	pmd_t *pmd;
 	pte_t *pte;
-	int pgd_ofs, pmd_ofs, pte_ofs;
+	int pmd_ofs, pte_ofs;
 
-	pgd_ofs = __pgd_offset(PAGE_OFFSET);
 	pgd = pgd_base + pgd_ofs;
 	pfn = 0;
 
-	for (; pgd_ofs < PTRS_PER_PGD && pfn < max_low_pfn; pgd++, pgd_ofs++) {
+	for (; pgd_ofs < pgd_limit && pfn < max_low_pfn; pgd++, pgd_ofs++) {
 		pmd = one_md_table_init(pgd);
 		for (pmd_ofs = 0; pmd_ofs < PTRS_PER_PMD && pfn < max_low_pfn; pmd++, pmd_ofs++) {
 			/* Map with big pages if possible, otherwise create normal page tables. */
@@ -151,6 +145,16 @@
 	}	
 }
 
+/*
+ * This maps the physical memory to kernel virtual address space, a total 
+ * of max_low_pfn pages, by creating page tables starting from address 
+ * PAGE_OFFSET.
+ */
+static void __init kernel_physical_mapping_init(pgd_t *pgd_base)
+{
+	init_physical_mapping(pgd_base, __pgd_offset(PAGE_OFFSET), PTRS_PER_PGD);
+}
+
 static inline int page_kills_ppro(unsigned long pagenr)
 {
 	if (pagenr >= 0x70000 && pagenr <= 0x7003F)
@@ -299,7 +303,7 @@
 #endif
 }
 
-void __init zap_low_mappings (void)
+void zap_low_mappings (void)
 {
 	int i;
 	/*

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
