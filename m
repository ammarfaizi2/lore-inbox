Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267444AbSLEVBz>; Thu, 5 Dec 2002 16:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267440AbSLEU76>; Thu, 5 Dec 2002 15:59:58 -0500
Received: from [195.39.17.254] ([195.39.17.254]:17412 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267428AbSLEU6C>;
	Thu, 5 Dec 2002 15:58:02 -0500
Date: Wed, 4 Dec 2002 14:00:43 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp@lister.fornax.hu>
Subject: FYI: swsusp bigdiff
Message-ID: <20021204130043.GA8208@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is *not* for application.
								Pavel

--- clean/arch/i386/Kconfig	2002-11-29 21:16:30.000000000 +0100
+++ linux-swsusp/arch/i386/Kconfig	2002-11-29 21:29:34.000000000 +0100
@@ -789,8 +789,6 @@
 
 menu "Power management options (ACPI, APM)"
 
-source "drivers/acpi/Kconfig"
-
 config PM
 	bool "Power Management support"
 	---help---
@@ -811,6 +809,37 @@
 	  will issue the hlt instruction if nothing is to be done, thereby
 	  sending the processor to sleep and saving power.
 
+config SOFTWARE_SUSPEND
+	bool "Software Suspend (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && PM
+	---help---
+	  Enable the possibilty of suspendig machine. It doesn't need APM.
+	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
+	  (patch for sysvinit needed). 
+
+	  It creates an image which is saved in your active swaps. By the next
+	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
+	  detect the saved image, restore the memory from
+	  it and then it continues to run as before you've suspended.
+	  If you don't want the previous state to continue use the 'noresume'
+	  kernel option. However note that your partitions will be fsck'd and
+	  you must re-mkswap your swap partitions/files.
+
+	  Right now you may boot without resuming and then later resume but
+	  in meantime you cannot use those swap partitions/files which were
+	  involved in suspending. Also in this case there is a risk that buffers
+	  on disk won't match with saved ones.
+
+	  SMP is supported ``as-is''. There's a code for it but doesn't work.
+	  There have been problems reported relating SCSI.
+
+	  This option is about getting stable. However there is still some
+	  absence of features.
+
+	  For more information take a look at Documentation/swsusp.txt.
+
+source "drivers/acpi/Kconfig"
+
 config APM
 	tristate "Advanced Power Management BIOS support"
 	depends on PM
@@ -1516,35 +1545,6 @@
 
 menu "Kernel hacking"
 
-config SOFTWARE_SUSPEND
-	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM
-	---help---
-	  Enable the possibilty of suspendig machine. It doesn't need APM.
-	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
-	  (patch for sysvinit needed). 
-
-	  It creates an image which is saved in your active swaps. By the next
-	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
-	  detect the saved image, restore the memory from
-	  it and then it continues to run as before you've suspended.
-	  If you don't want the previous state to continue use the 'noresume'
-	  kernel option. However note that your partitions will be fsck'd and
-	  you must re-mkswap your swap partitions/files.
-
-	  Right now you may boot without resuming and then later resume but
-	  in meantime you cannot use those swap partitions/files which were
-	  involved in suspending. Also in this case there is a risk that buffers
-	  on disk won't match with saved ones.
-
-	  SMP is supported ``as-is''. There's a code for it but doesn't work.
-	  There have been problems reported relating SCSI.
-
-	  This option is about getting stable. However there is still some
-	  absence of features.
-
-	  For more information take a look at Documentation/swsusp.txt.
-
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
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
 
diff -ur -x '.dep*' -x '.hdep*' -x '*.[oas]' -x '*~' -x '#*' -x '*CVS*' -x '*.orig' -x '*.rej' -x '*.old' -x '.menu*' -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x '*RCS*' -x conmakehash -x map -x build -x build -x configure -x '*target*' -x '*.flags' -x '*.bak' clean/arch/i386/kernel/acpi_wakeup.S linux-swsusp/arch/i386/kernel/acpi_wakeup.S
--- clean/arch/i386/kernel/acpi_wakeup.S	2002-11-19 16:45:58.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/acpi_wakeup.S	2002-12-04 13:34:30.000000000 +0100
@@ -1,12 +1,21 @@
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
@@ -14,49 +23,70 @@
  	movw	$0xb800, %ax
 	movw	%ax,%fs
 	movw	$0x0e00 + 'L', %fs:(0x10)
+
 	cli
 	cld
-	  
+
 	# setup data segment
 	movw	%cs, %ax
-
-	addw	$(wakeup_data - wakeup_code) >> 4, %ax
-	movw	%ax, %ds
+	movw	%ax, %ds					# Make ds:0 point to wakeup_start
 	movw	%ax, %ss
-	mov	$(wakeup_stack - wakeup_data), %sp		# Private stack is needed for ASUS board
-	movw	$0x0e00 + 'S', %fs:(0x12)	
+	mov	wakeup_stack - wakeup_code, %sp			# Private stack is needed for ASUS board
+	movw	$0x0e00 + 'S', %fs:(0x12)
 
-	movl	real_magic - wakeup_data, %eax
+	pushl	$0						# Kill any dangerous flags
+	popfl
+
+	movl	real_magic - wakeup_code, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_real_magic
 
-	mov	video_mode - wakeup_data, %ax
+#if 1
+	lcall   $0xc000,$3
+#endif
+#if 0
+	mov	video_mode - wakeup_code, %ax
 	call	mode_set
+#endif
 
 	# set up page table
-	movl	(real_save_cr3 - wakeup_data), %eax
+#if 1
+	movl	$swapper_pg_dir-__PAGE_OFFSET, %eax
+#else
+	movl    (real_save_cr3 - wakeup_data), %eax
+#endif
 	movl	%eax, %cr3
 
 	# make sure %cr4 is set correctly (features, etc)
-	movl	(real_save_cr4 - wakeup_data), %eax
+	movl	real_save_cr4 - wakeup_code, %eax
 	movl	%eax, %cr4
 	movw	$0xb800, %ax
 	movw	%ax,%fs
 	movw	$0x0e00 + 'i', %fs:(0x12)
-
+	
 	# need a gdt
-	lgdt	real_save_gdt - wakeup_data
+	lgdt	real_save_gdt - wakeup_code
 
-	movl	(real_save_cr0 - wakeup_data), %eax
+	movl	real_save_cr0 - wakeup_code, %eax
 	movl	%eax, %cr0
+	jmp 1f
+1:
 	movw	$0x0e00 + 'n', %fs:(0x14)
 
-	movl	real_magic - wakeup_data, %eax
+	movl	real_magic - wakeup_code, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_real_magic
 
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
@@ -129,20 +159,12 @@
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
@@ -205,7 +227,6 @@
 	movw	$0x0e00 + '2', %ds:(0xb8018)
 	jmp bogus_magic2
 		
-
 ##
 # acpi_copy_wakeup_routine
 #
@@ -228,7 +249,7 @@
 
 	movl	%eax, %edi
 	leal	wakeup_start, %esi
-	movl	$(wakeup_end - wakeup_start) >> 2, %ecx
+	movl	$(wakeup_end - wakeup_start + 3) >> 2, %ecx
 
 	rep ;  movsl
 
@@ -290,8 +311,8 @@
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
@@ -310,5 +331,4 @@
 saved_idt:	.long	0,0
 saved_ldt:	.long	0
 saved_tss:	.long	0
-saved_cr0:	.long	0
 
--- clean/arch/i386/kernel/suspend.c	2002-11-19 16:45:58.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/suspend.c	2002-11-30 15:28:40.000000000 +0100
@@ -125,10 +125,3 @@
 	}
 
 }
-
-#ifdef CONFIG_SOFTWARE_SUSPEND
-/* Local variables for do_magic */
-int loop __nosavedata = 0;
-int loop2 __nosavedata = 0;
-
-#endif
--- clean/arch/i386/kernel/suspend_asm.S	2002-11-19 16:45:58.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/suspend_asm.S	2002-11-30 15:28:32.000000000 +0100
@@ -1,4 +1,7 @@
 .text
+
+/* Originally gcc generated, modified by hand */
+
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/page.h>
@@ -78,3 +81,11 @@
 .L1449:
 	popl %ebx
 	ret
+
+       .section .data.nosave
+loop:
+       .quad 0
+loop2:
+       .quad 0
+       .previous
+	
\ No newline at end of file
--- clean/arch/i386/kernel/traps.c	2002-11-23 19:55:14.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/traps.c	2002-11-23 19:57:42.000000000 +0100
@@ -212,6 +212,7 @@
 		ss = regs->xss & 0xffff;
 	}
 	print_modules();
+	mdelay(1000);
 	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s\nEFLAGS: %08lx\n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip, print_tainted(), regs->eflags);
 
@@ -224,6 +225,7 @@
 		regs->xds & 0xffff, regs->xes & 0xffff, ss);
 	printk("Process %s (pid: %d, threadinfo=%p task=%p)",
 		current->comm, current->pid, current_thread_info(), current);
+	mdelay(4000);
 	/*
 	 * When in-kernel, we also print out the stack and code at the
 	 * time of the fault..
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
--- clean/drivers/acpi/Kconfig	2002-11-01 00:37:09.000000000 +0100
+++ linux-swsusp/drivers/acpi/Kconfig	2002-11-23 21:16:32.000000000 +0100
@@ -58,8 +58,7 @@
 
 config ACPI_SLEEP
 	bool "Sleep States"
-	depends on X86 && ACPI && !ACPI_HT_ONLY
-	default SOFTWARE_SUSPEND
+	depends on X86 && ACPI && !ACPI_HT_ONLY && SOFTWARE_SUSPEND
 	---help---
 	  This option adds support for ACPI suspend states. 
 
--- clean/drivers/acpi/sleep.c	2002-11-29 21:16:34.000000000 +0100
+++ linux-swsusp/drivers/acpi/sleep.c	2002-11-30 00:27:14.000000000 +0100
@@ -674,7 +675,7 @@
 			ACPI_SYSTEM_FILE_SLEEP));
 	else {
 		entry->proc_fops = &acpi_system_sleep_fops;
-		entry->write_proc = acpi_system_write_sleep;
+		entry->proc_fops->write = acpi_system_write_sleep;
 	}
 
 	/* 'alarm' [R/W] */
--- clean/drivers/md/md.c	2002-11-23 19:55:20.000000000 +0100
+++ linux-swsusp/drivers/md/md.c	2002-11-23 19:57:55.000000000 +0100
@@ -36,6 +36,7 @@
 #include <linux/bio.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/buffer_head.h> /* for invalidate_bdev */
+#include <linux/suspend.h>
 
 #include <linux/init.h>
 
@@ -2466,6 +2467,8 @@
 
 		wait_event_interruptible(thread->wqueue,
 					 test_bit(THREAD_WAKEUP, &thread->flags));
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 
 		clear_bit(THREAD_WAKEUP, &thread->flags);
 
--- clean/kernel/suspend.c	2002-11-19 16:46:15.000000000 +0100
+++ linux-swsusp/kernel/suspend.c	2002-11-19 15:38:28.000000000 +0100
@@ -80,9 +80,9 @@
 #endif
 
 #define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
-#define ADDRESS(x) ((unsigned long) phys_to_virt(((x) << PAGE_SHIFT)))
-
-extern int C_A_D;
+#define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
+#define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)
+#define ADDRESS2(x) __ADDRESS(__pa(x))		/* Needed for x86-64 where some pages are in memory twice */
 
 /* References to section boundaries */
 extern char _text, _etext, _edata, __bss_start, _end;
@@ -145,10 +145,10 @@
 /*
  * Debug
  */
-#undef	DEBUG_DEFAULT
+#define	DEBUG_DEFAULT
 #undef	DEBUG_PROCESS
 #undef	DEBUG_SLOW
-#define TEST_SWSUSP 1		/* Set to 1 to reboot instead of halt machine after suspension */
+#define TEST_SWSUSP 0		/* Set to 1 to reboot instead of halt machine after suspension */
 
 #ifdef DEBUG_DEFAULT
 # define PRINTK(f, a...)       printk(f, ## a)
@@ -235,6 +235,7 @@
 	} while(todo);
 	
 	printk( "|\n" );
+	BUG_ON(in_atomic());
 	return 0;
 }
 
@@ -322,20 +323,20 @@
 	rw_swap_page_sync(READ, entry, page);
 
 	if (mode == MARK_SWAP_RESUME) {
-	  	if (!memcmp("SUSP1R",cur->swh.magic.magic,6))
+	  	if (!memcmp("S1",cur->swh.magic.magic,2))
 		  	memcpy(cur->swh.magic.magic,"SWAP-SPACE",10);
-		else if (!memcmp("SUSP2R",cur->swh.magic.magic,6))
+		else if (!memcmp("S2",cur->swh.magic.magic,2))
 			memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
 		else printk("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
 		      	name_resume, cur->swh.magic.magic);
 	} else {
 	  	if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)))
-		  	memcpy(cur->swh.magic.magic,"SUSP1R....",10);
+		  	memcpy(cur->swh.magic.magic,"S1SUSP....",10);
 		else if ((!memcmp("SWAPSPACE2",cur->swh.magic.magic,10)))
-			memcpy(cur->swh.magic.magic,"SUSP2R....",10);
+			memcpy(cur->swh.magic.magic,"S2SUSP....",10);
 		else panic("\nSwapspace is not swapspace (%.10s)\n", cur->swh.magic.magic);
 		cur->link.next = prev; /* prev is the first/last swap page of the resume area */
-		/* link.next lies *no more* in last 4 bytes of magic */
+		/* link.next lies *no more* in last 4/8 bytes of magic */
 	}
 	rw_swap_page_sync(WRITE, entry, page);
 	__free_page(page);
@@ -489,7 +490,6 @@
 			if (PageNosave(page))
 				continue;
 
-
 			if ((chunk_size=is_head_of_free_region(page))!=0) {
 				pfn += chunk_size - 1;
 				continue;
@@ -500,10 +500,9 @@
 			/*
 			 * Just copy whole code segment. Hopefully it is not that big.
 			 */
-			if (ADDRESS(pfn) >= (unsigned long)
-				&__nosave_begin && ADDRESS(pfn) < 
-				(unsigned long)&__nosave_end) {
-				PRINTK("[nosave %x]", ADDRESS(pfn));
+			if ((ADDRESS(pfn) >= (unsigned long) ADDRESS2(&__nosave_begin)) && 
+			    (ADDRESS(pfn) <  (unsigned long) ADDRESS2(&__nosave_end))) {
+				PRINTK("[nosave %lx]", ADDRESS(pfn));
 				continue;
 			}
 			/* Hmm, perhaps copying all reserved pages is not too healthy as they may contain 
@@ -513,7 +512,7 @@
 		nr_copy_pages++;
 		if (pagedir_p) {
 			pagedir_p->orig_address = ADDRESS(pfn);
-			copy_page(pagedir_p->address, pagedir_p->orig_address);
+			copy_page((void *) pagedir_p->address, (void *) pagedir_p->orig_address);
 			pagedir_p++;
 		}
 	}
@@ -549,7 +548,7 @@
 
 	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 
-	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, pagedir_order);
+	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, pagedir_order);
 	if(!pagedir)
 		return NULL;
 
@@ -558,11 +557,12 @@
 		SetPageNosave(page++);
 		
 	while(nr_copy_pages--) {
-		p->address = get_zeroed_page(GFP_ATOMIC);
+		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
 		if(!p->address) {
 			free_suspend_pagedir((unsigned long) pagedir);
 			return NULL;
 		}
+		printk(".");
 		SetPageNosave(virt_to_page(p->address));
 		p->orig_address = 0;
 		p++;
@@ -623,7 +623,7 @@
 static void free_some_memory(void)
 {
 	printk("Freeing memory: ");
-	while (try_to_free_pages(&contig_page_data.node_zones[ZONE_HIGHMEM], GFP_KSWAPD, 0))
+	while (shrink_all_memory(10000))
 		printk(".");
 	printk("|\n");
 }
@@ -676,7 +676,7 @@
 	}
 }
 
-static int suspend_save_image(void)
+static int suspend_prepare_image(void)
 {
 	struct sysinfo i;
 	unsigned int nr_needed_pages = 0;
@@ -725,9 +725,15 @@
 	 *
 	 * Following line enforces not writing to disk until we choose.
 	 */
-	drivers_unsuspend();
-	spin_unlock_irq(&suspend_pagedir_lock);
+
 	printk( "critical section/: done (%d pages copied)\n", nr_copy_pages );
+	spin_unlock_irq(&suspend_pagedir_lock);
+	return 0;
+}
+
+static void suspend_save_image(void)
+{
+	drivers_unsuspend();
 
 	lock_swapdevices();
 	write_suspend_image();
@@ -738,11 +744,11 @@
 	 * filesystem clean: it is not. (And it does not matter, if we resume
 	 * correctly, we'll mark system clean, anyway.)
 	 */
-	return 0;
 }
 
-void suspend_power_down(void)
+static void suspend_power_down(void)
 {
+	extern int C_A_D;
 	C_A_D = 0;
 	printk(KERN_EMERG "%s%s Trying to power down.\n", name_suspend, TEST_SWSUSP ? "Disable TEST_SWSUSP. NOT ": "");
 #ifdef CONFIG_VT
@@ -788,8 +794,8 @@
 
 	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
-	drivers_resume(RESUME_ALL_PHASES);
 	spin_unlock_irq(&suspend_pagedir_lock);
+	drivers_resume(RESUME_ALL_PHASES);
 
 	PRINTK( "Fixing swap signatures... " );
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
@@ -804,14 +810,17 @@
 {
 	mb();
 	barrier();
+	BUG_ON(in_atomic());
 	spin_lock_irq(&suspend_pagedir_lock);
 }
 
 void do_magic_suspend_2(void)
 {
 	read_swapfiles();
-	if (!suspend_save_image())
+	if (!suspend_prepare_image()) {	/* suspend_save_image realeses suspend_pagedir_lock */
+		suspend_save_image();
 		suspend_power_down();	/* FIXME: if suspend_power_down is commented out, console is lost after few suspends ?! */
+	}
 
 	printk(KERN_EMERG "%sSuspend failed, trying to recover...\n", name_suspend);
 	MDELAY(1000); /* So user can wait and report us messages if armageddon comes :-) */
@@ -827,7 +836,7 @@
 	PRINTK(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
 }
 
-void do_software_suspend(void)
+static void do_software_suspend(void)
 {
 	arch_prepare_suspend();
 	if (prepare_suspend_console())
@@ -1069,9 +1078,9 @@
 
 	PREPARENEXT; /* We have to read next position before we overwrite it */
 
-	if (!memcmp("SUSP1R",cur->swh.magic.magic,6))
+	if (!memcmp("S1",cur->swh.magic.magic,2))
 		memcpy(cur->swh.magic.magic,"SWAP-SPACE",10);
-	else if (!memcmp("SUSP2R",cur->swh.magic.magic,6))
+	else if (!memcmp("S2",cur->swh.magic.magic,2))
 		memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
 	else {
 		panic("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
--- clean/mm/page_alloc.c	2002-11-23 19:55:45.000000000 +0100
+++ linux-swsusp/mm/page_alloc.c	2002-11-23 19:58:23.000000000 +0100
@@ -387,7 +387,7 @@
 	unsigned long flags;
 	struct page *page = NULL;
 
-	if (order == 0) {
+	if ((order == 0) && !cold) {
 		struct per_cpu_pages *pcp;
 
 		pcp = &zone->pageset[get_cpu()].pcp[cold];

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
