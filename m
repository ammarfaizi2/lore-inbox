Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267239AbSK3NWj>; Sat, 30 Nov 2002 08:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267240AbSK3NWj>; Sat, 30 Nov 2002 08:22:39 -0500
Received: from [195.39.17.254] ([195.39.17.254]:9220 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267239AbSK3NWd>;
	Sat, 30 Nov 2002 08:22:33 -0500
Date: Sat, 30 Nov 2002 14:28:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: S3 fixes for 2.5.50
Message-ID: <20021130132859.GA135@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This cleans up acpi.c sleep, and fixes it to work when kernel is too
big (pagetable created by hand by acpi.c was too small). Please apply,

								Pavel

--- clean/arch/i386/kernel/acpi.c	2002-09-22 23:46:52.000000000 +0200
+++ linux-swsusp/arch/i386/kernel/acpi.c	2002-11-24 20:29:33.000000000 +0100
@@ -446,72 +446,19 @@
 
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
+static void init_low_mapping(pgd_t *pgd, int pgd_ofs, int pgd_limit)
 {
-	pgd_t *pgd;
-	int i;
-
-	ptep = (pte_t*)__get_free_page(GFP_KERNEL);
+	int pgd_ofs = 0;
 
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
+	while ((pgd_ofs < pgd_limit) && (pgd_ofs + USER_PTRS_PER_PGD < PTRS_PER_PGD)) {
+		set_pgd(pgd, *(pgd+USER_PTRS_PER_PGD));
+		pgd_ofs++, pgd++;
+	}
 }
 
 /**
@@ -522,7 +469,11 @@
  */
 int acpi_save_state_mem (void)
 {
-	acpi_create_identity_pmd();
+#if CONFIG_X86_PAE
+	panic("S3 and PAE do not like each other for now.");
+	return 1;
+#endif
+	init_low_mapping(swapper_pg_dir, 0, USER_PTRS_PER_PGD);
 	acpi_copy_wakeup_routine(acpi_wakeup_address);
 
 	return 0;
@@ -542,7 +493,7 @@
  */
 void acpi_restore_state_mem (void)
 {
-	acpi_restore_pmd();
+	zap_low_mappings();
 }
 
 /**
@@ -555,7 +506,10 @@
  */
 void __init acpi_reserve_bootmem(void)
 {
+	extern char wakeup_start, wakeup_end;
 	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE);
+	if ((&wakeup_end - &wakeup_start) > PAGE_SIZE)
+		printk(KERN_CRIT "ACPI: Wakeup code way too big, will crash on attempt to suspend\n");
 	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n", acpi_wakeup_address);
 }
 
--- clean/arch/i386/kernel/acpi_wakeup.S	2002-11-19 16:45:58.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/acpi_wakeup.S	2002-11-28 11:06:26.000000000 +0100
@@ -1,62 +1,101 @@
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
+# Do we need to deal with A20? It is okay: ACPI specs says A20 must be enabled
+#
+# If physical address of wakeup_code is 0x12345, BIOS should call us with
+# cs = 0x1234, eip = 0x05
+# 
 
 ALIGN
-wakeup_start:
+	.align	4096
+ENTRY(wakeup_start)
 wakeup_code:
 	wakeup_code_start = .
 	.code16
 
+	mov $0xa0, %al		;  	outb %al, $0x80
  	movw	$0xb800, %ax
 	movw	%ax,%fs
 	movw	$0x0e00 + 'L', %fs:(0x10)
+	mov $0xaf, %al		;  	outb %al, $0x80	
+	
 	cli
 	cld
-	  
-	# setup data segment
-	movw	%cs, %ax
+	mov $0xae, %al		;  	outb %al, $0x80		
 
-	addw	$(wakeup_data - wakeup_code) >> 4, %ax
-	movw	%ax, %ds
-	movw	%ax, %ss
-	mov	$(wakeup_stack - wakeup_data), %sp		# Private stack is needed for ASUS board
-	movw	$0x0e00 + 'S', %fs:(0x12)	
+	mov $0xad, %al		;  	outb %al, $0x80			
+	
+        # setup data segment
+        movw    %cs, %ax
+	movw    %ax, %ds					# Make ds:0 point to wakeup_start
+	movw    %ax, %ss
+	mov	$(wakeup_stack-wakeup_code), %sp		# Private stack is needed for ASUS board
+	mov $0xac, %al		;  	outb %al, $0x80				
+	movw	$0x0e00 + 'S', %fs:(0x12)
+	mov $0xab, %al		;  	outb %al, $0x80					
+
+	pushl	$0						# Kill any dangerous flags
+	popfl
+	mov $0xaa, %al		;  	outb %al, $0x80
 
-	movl	real_magic - wakeup_data, %eax
+	movl	real_magic-wakeup_code, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_real_magic
 
-	mov	video_mode - wakeup_data, %ax
+#if 0
+	mov $0xa1, %al		;  	outb %al, $0x80
+	lcall   $0xc000,$3
+#endif
+#if 0
+	mov $0xa2, %al		;  	outb %al, $0x80
+	mov	video_mode-wakeup_code, %ax
 	call	mode_set
+#endif
 
+	mov $0xa3, %al		;  	outb %al, $0x80
 	# set up page table
-	movl	(real_save_cr3 - wakeup_data), %eax
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
+	mov $0xa4, %al		;  	outb %al, $0x80
+	movl	real_magic-wakeup_code, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_real_magic
 
+	mov $0xa5, %al		;  	outb %al, $0x80
 	ljmpl	$__KERNEL_CS,$wakeup_pmode_return
 
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
@@ -129,22 +168,15 @@
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
+	mov $0xa6, %al		;  	outb %al, $0x80	
 	movl	$__KERNEL_DS, %eax
 	movl	%eax, %ds
 	movw	$0x0e00 + 'u', %ds:(0xb8016)
@@ -228,7 +264,7 @@
 
 	movl	%eax, %edi
 	leal	wakeup_start, %esi
-	movl	$(wakeup_end - wakeup_start) >> 2, %ecx
+	movl	$(wakeup_end - wakeup_start + 3) >> 2, %ecx
 
 	rep ;  movsl
 
@@ -290,8 +326,8 @@
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
@@ -310,5 +346,4 @@
 saved_idt:	.long	0,0
 saved_ldt:	.long	0
 saved_tss:	.long	0
-saved_cr0:	.long	0
 
--- clean/arch/i386/mm/init.c	2002-11-19 16:45:26.000000000 +0100
+++ linux-swsusp/arch/i386/mm/init.c	2002-11-24 20:18:22.000000000 +0100
@@ -299,7 +299,7 @@
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
