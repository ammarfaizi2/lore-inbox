Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267173AbSKSTWM>; Tue, 19 Nov 2002 14:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbSKSTWL>; Tue, 19 Nov 2002 14:22:11 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7172 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267173AbSKSTVt>;
	Tue, 19 Nov 2002 14:21:49 -0500
Date: Tue, 19 Nov 2002 17:31:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp@lister.fornax.hu>
Subject: Make swsusp work [testing patch]
Message-ID: <20021119163124.GA6497@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should make swsusp work. [Don't apply, dirty hacks ahead].

								Pavel

--- clean/arch/i386/kernel/acpi.c	2002-09-22 23:46:52.000000000 +0200
+++ linux-swsusp/arch/i386/kernel/acpi.c	2002-11-17 12:52:00.000000000 +0100
@@ -555,7 +555,8 @@
  */
 void __init acpi_reserve_bootmem(void)
 {
-	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE);
+	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(10*PAGE_SIZE);
+	/* FIXME: have to check wakeup code is not > PAGE_SIZE! */
 	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n", acpi_wakeup_address);
 }
 
--- clean/arch/i386/kernel/acpi_wakeup.S	2002-11-19 16:45:58.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/acpi_wakeup.S	2002-11-19 16:17:58.000000000 +0100
@@ -1,11 +1,16 @@
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
+	.align	4096
 wakeup_start:
 wakeup_code:
 	wakeup_code_start = .
@@ -14,49 +19,81 @@
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
+	movl $swapper_pg_dir-__PAGE_OFFSET,%eax			# This should work but does not :-( Crashes with "Li"
+								# Normally it crashes with "Lin". Ouch,.
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
+#	andl	 $0x7fffffff,%eax	
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
@@ -129,22 +166,16 @@
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
+.org	0x3000
 wakeup_end:
+.org	0x4000
 
 wakeup_pmode_return:
+	# It crashes *just* before here :-(
+	
 	movl	$__KERNEL_DS, %eax
 	movl	%eax, %ds
 	movw	$0x0e00 + 'u', %ds:(0xb8016)
@@ -205,6 +236,9 @@
 	movw	$0x0e00 + '2', %ds:(0xb8018)
 	jmp bogus_magic2
 		
+.org 0x123456
+eat_some_memory:	
+		.long 0
 
 ##
 # acpi_copy_wakeup_routine
@@ -228,7 +262,7 @@
 
 	movl	%eax, %edi
 	leal	wakeup_start, %esi
-	movl	$(wakeup_end - wakeup_start) >> 2, %ecx
+	movl	$(wakeup_end - wakeup_start + 3) >> 2, %ecx
 
 	rep ;  movsl
 
@@ -290,8 +324,8 @@
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
@@ -310,5 +344,4 @@
 saved_idt:	.long	0,0
 saved_ldt:	.long	0
 saved_tss:	.long	0
-saved_cr0:	.long	0
 
--- clean/arch/i386/kernel/traps.c	2002-11-19 16:45:58.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/traps.c	2002-11-19 15:38:07.000000000 +0100
@@ -211,6 +211,7 @@
 		ss = regs->xss & 0xffff;
 	}
 	print_modules();
+	mdelay(1000);
 	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s\nEFLAGS: %08lx\n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip, print_tainted(), regs->eflags);
 
@@ -223,6 +224,7 @@
 		regs->xds & 0xffff, regs->xes & 0xffff, ss);
 	printk("Process %s (pid: %d, threadinfo=%p task=%p)",
 		current->comm, current->pid, current_thread_info(), current);
+	mdelay(4000);
 	/*
 	 * When in-kernel, we also print out the stack and code at the
 	 * time of the fault..
--- clean/arch/i386/mm/init.c	2002-11-19 16:45:26.000000000 +0100
+++ linux-swsusp/arch/i386/mm/init.c	2002-11-17 23:09:28.000000000 +0100
@@ -488,7 +488,7 @@
 	 * the WP-bit has been tested.
 	 */
 #ifndef CONFIG_SMP
-	zap_low_mappings();
+//	zap_low_mappings();
 #endif
 }
 
--- clean/drivers/ide/ide-disk.c	2002-11-19 16:45:32.000000000 +0100
+++ linux-swsusp/drivers/ide/ide-disk.c	2002-11-12 22:23:02.000000000 +0100
@@ -1412,24 +1412,6 @@
 	return call_idedisk_standby(drive, 0);
 }
 
-static int call_idedisk_suspend (ide_drive_t *drive, int arg)
-{
-	ide_task_t args;
-	u8 suspend = (arg) ? WIN_SLEEPNOW2 : WIN_SLEEPNOW1;
-	memset(&args, 0, sizeof(ide_task_t));
-	args.tfRegister[IDE_COMMAND_OFFSET]	= suspend;
-	args.command_type			= ide_cmd_type_parser(&args);
-	return ide_raw_taskfile(drive, &args, NULL);
-}
-
-static int do_idedisk_suspend (ide_drive_t *drive)
-{
-	if (drive->suspend_reset)
-		return 1;
-
-	return call_idedisk_suspend(drive, 0);
-}
-
 #if 0
 static int call_idedisk_checkpower (ide_drive_t *drive, int arg)
 {
@@ -1456,13 +1438,6 @@
 }
 #endif
 
-static int do_idedisk_resume (ide_drive_t *drive)
-{
-	if (!drive->suspend_reset)
-		return 1;
-	return 0;
-}
-
 static int do_idedisk_flushcache (ide_drive_t *drive)
 {
 	ide_task_t args;
@@ -1561,6 +1536,53 @@
 #endif
 }
 
+static int idedisk_suspend(struct device *dev, u32 state, u32 level)
+{
+	ide_drive_t *drive = dev->driver_data;
+
+	printk("Suspending device %p\n", dev->driver_data);
+
+	/* I hope that every freeze operation from the upper levels have
+	 * already been done...
+	 */
+
+	if (level != SUSPEND_SAVE_STATE)
+		return 0;
+	BUG_ON(in_interrupt());
+
+	printk("Waiting for commands to finish\n");
+
+	/* wait until all commands are finished */
+	/* FIXME: waiting for spinlocks should be done instead. */
+	if (!(HWGROUP(drive)))
+		printk("No hwgroup?\n");
+	while (HWGROUP(drive)->handler)
+		yield();
+
+	/* set the drive to standby */
+	printk(KERN_INFO "suspending: %s ", drive->name);
+	do_idedisk_standby(drive);
+	drive->blocked = 1;
+
+	while (HWGROUP(drive)->handler)
+		yield();
+
+	return 0;
+}
+
+static int idedisk_resume(struct device *dev, u32 level)
+{
+	ide_drive_t *drive = dev->driver_data;
+
+	if (level != RESUME_RESTORE_STATE)
+		return 0;
+	if (!drive->blocked)
+		panic("ide: Resume but not suspended?\n");
+
+	drive->blocked = 0;
+	return 0;
+}
+
 static void idedisk_setup (ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
@@ -1671,6 +1693,7 @@
 {
 	struct gendisk *g = drive->disk;
 
+	do_idedisk_standby(drive);
 	if ((drive->id->cfs_enable_2 & 0x3000) && drive->wcache)
 		if (do_idedisk_flushcache(drive))
 			printk (KERN_INFO "%s: Write Cache FAILED Flushing!\n",
@@ -1696,9 +1719,6 @@
 	.supports_dma		= 1,
 	.supports_dsc_overlap	= 0,
 	.cleanup		= idedisk_cleanup,
-	.standby		= do_idedisk_standby,
-	.suspend		= do_idedisk_suspend,
-	.resume			= do_idedisk_resume,
 	.flushcache		= do_idedisk_flushcache,
 	.do_request		= do_rw_disk,
 	.sense			= idedisk_dump_status,
@@ -1709,6 +1729,10 @@
 	.proc			= idedisk_proc,
 	.attach			= idedisk_attach,
 	.drives			= LIST_HEAD_INIT(idedisk_driver.drives),
+	.gen_driver		= {
+		.suspend	= idedisk_suspend,
+		.resume		= idedisk_resume,
+	}
 };
 
 static int idedisk_open(struct inode *inode, struct file *filp)
@@ -1835,8 +1859,7 @@
 
 static int idedisk_init (void)
 {
-	ide_register_driver(&idedisk_driver);
-	return 0;
+	return ide_register_driver(&idedisk_driver);
 }
 
 module_init(idedisk_init);
--- clean/drivers/ide/ide-probe.c	2002-11-19 16:46:03.000000000 +0100
+++ linux-swsusp/drivers/ide/ide-probe.c	2002-11-19 16:12:23.000000000 +0100
@@ -1058,6 +1058,7 @@
 			 "%s","IDE Drive");
 		drive->gendev.parent = &hwif->gendev;
 		drive->gendev.bus = &ide_bus_type;
+		drive->gendev.driver_data = drive;
 		sprintf (name, "ide/host%d/bus%d/target%d/lun%d",
 			(hwif->channel && hwif->mate) ?
 			hwif->mate->index : hwif->index,
--- clean/drivers/ide/ide.c	2002-11-19 16:45:32.000000000 +0100
+++ linux-swsusp/drivers/ide/ide.c	2002-11-12 22:23:02.000000000 +0100
@@ -3122,21 +3122,6 @@
 #endif
 }
 
-static int default_standby (ide_drive_t *drive)
-{
-	return 0;
-}
-
-static int default_suspend (ide_drive_t *drive)
-{
-	return 0;
-}
-
-static int default_resume (ide_drive_t *drive)
-{
-	return 0;
-}
-
 static int default_flushcache (ide_drive_t *drive)
 {
 	return 0;
@@ -3193,9 +3178,6 @@
 {
 	ide_driver_t *d = drive->driver;
 
-	if (d->standby == NULL)		d->standby = default_standby;
-	if (d->suspend == NULL)		d->suspend = default_suspend;
-	if (d->resume == NULL)		d->resume = default_resume;
 	if (d->flushcache == NULL)	d->flushcache = default_flushcache;
 	if (d->do_request == NULL)	d->do_request = default_do_request;
 	if (d->end_request == NULL)	d->end_request = default_end_request;
@@ -3274,13 +3256,8 @@
 	ide_drive_t * drive = container_of(dev,ide_drive_t,gendev);
 	ide_driver_t * driver = drive->driver;
 
-	if (driver) {
-		if (driver->standby)
-			driver->standby(drive);
-		if (driver->cleanup)
-			driver->cleanup(drive);
-	}
-	
+	if (driver && driver->cleanup)
+		driver->cleanup(drive);
 	return 0;
 }
 
--- clean/drivers/md/md.c	2002-11-19 16:46:05.000000000 +0100
+++ linux-swsusp/drivers/md/md.c	2002-11-19 15:38:15.000000000 +0100
@@ -36,6 +36,7 @@
 #include <linux/bio.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/buffer_head.h> /* for invalidate_bdev */
+#include <linux/suspend.h>
 
 #include <linux/init.h>
 
@@ -2470,6 +2471,8 @@
 
 		wait_event_interruptible(thread->wqueue,
 					 test_bit(THREAD_WAKEUP, &thread->flags));
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 
 		clear_bit(THREAD_WAKEUP, &thread->flags);
 
@@ -2774,7 +2777,7 @@
 	if (!ok) {
 		mddev->recovery_running = -EIO;
 		md_recover_arrays();
-		// stop recovery, signal do_sync ....
+		/* stop recovery, signal do_sync .... */
 	}
 }
 
@@ -2795,6 +2798,9 @@
 	struct list_head *tmp;
 	unsigned long last_check;
 
+	if (current->flags & PF_FREEZE)
+		refrigerator(PF_IOTHREAD);
+
 	/* just incase thread restarts... */
 	if (mddev->recovery_running <= 0)
 		return;
@@ -2810,6 +2816,9 @@
 		mddev->curr_resync = 2;
 
 		ITERATE_MDDEV(mddev2,tmp) {
+			if (current->flags & PF_FREEZE)
+				refrigerator(PF_IOTHREAD);
+
 			if (mddev2 == mddev)
 				continue;
 			if (mddev2->curr_resync && 
@@ -2909,6 +2918,9 @@
 		 */
 		cond_resched();
 
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
+
 		currspeed = (j-mddev->resync_mark_cnt)/2/((jiffies-mddev->resync_mark)/HZ +1) +1;
 
 		if (currspeed > sysctl_speed_limit_min) {
--- clean/include/linux/ide.h	2002-11-19 16:45:45.000000000 +0100
+++ linux-swsusp/include/linux/ide.h	2002-11-12 22:23:13.000000000 +0100
@@ -1189,9 +1189,6 @@
 	unsigned supports_dma		: 1;
 	unsigned supports_dsc_overlap	: 1;
 	int		(*cleanup)(ide_drive_t *);
-	int		(*standby)(ide_drive_t *);
-	int		(*suspend)(ide_drive_t *);
-	int		(*resume)(ide_drive_t *);
 	int		(*flushcache)(ide_drive_t *);
 	ide_startstop_t	(*do_request)(ide_drive_t *, struct request *, sector_t);
 	int		(*end_request)(ide_drive_t *, int, int);
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
--- clean/mm/page_alloc.c	2002-11-19 16:45:47.000000000 +0100
+++ linux-swsusp/mm/page_alloc.c	2002-11-12 22:23:14.000000000 +0100
@@ -368,7 +368,7 @@
 	unsigned long flags;
 	struct page *page = NULL;
 
-	if (order == 0) {
+	if ((order == 0) && !cold) {
 		struct per_cpu_pages *pcp;
 
 		pcp = &zone->pageset[get_cpu()].pcp[cold];

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
