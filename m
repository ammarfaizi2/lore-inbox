Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbSKMUYF>; Wed, 13 Nov 2002 15:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262876AbSKMUYE>; Wed, 13 Nov 2002 15:24:04 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2564 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262796AbSKMUWY>;
	Wed, 13 Nov 2002 15:22:24 -0500
Date: Tue, 12 Nov 2002 22:51:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp for 2.5.47 [not for inclusion]
Message-ID: <20021112215159.GA141@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is patch I'm using. With this swsusp in 2.5.47 should work.
								Pavel

--- clean/arch/i386/kernel/Makefile	2002-11-12 18:40:26.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/Makefile	2002-11-12 22:22:53.000000000 +0100
@@ -24,7 +24,7 @@
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o suspend_asm.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_PROFILING)		+= profile.o
 obj-$(CONFIG_EDD)             	+= edd.o
--- clean/arch/i386/kernel/acpi.c	2002-09-22 23:46:52.000000000 +0200
+++ linux-swsusp/arch/i386/kernel/acpi.c	2002-11-02 19:10:07.000000000 +0100
@@ -542,6 +542,7 @@
  */
 void acpi_restore_state_mem (void)
 {
+	printk(KERN_CRIT "acpi_restore_state_mem() called\n");
 	acpi_restore_pmd();
 }
 
--- clean/arch/i386/kernel/acpi_wakeup.S	2002-06-03 11:43:27.000000000 +0200
+++ linux-swsusp/arch/i386/kernel/acpi_wakeup.S	2002-11-12 18:27:42.000000000 +0100
@@ -29,9 +29,12 @@
 	movl	real_magic - wakeup_data, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_real_magic
-
+#if 0
+	lcall   $0xc000,$3
+	jmp	bogus_real_magic
 	mov	video_mode - wakeup_data, %ax
 	call	mode_set
+#endif
 
 	# set up page table
 	movl	(real_save_cr3 - wakeup_data), %eax
@@ -129,7 +132,7 @@
 	.code32
 	ALIGN
 
-.org	0x300
+.org	0x1000
 wakeup_data:
 		.word 0
 real_save_gdt:	.word 0
@@ -140,9 +143,11 @@
 real_magic:	.long 0
 video_mode:	.long 0
 
-.org	0x500
+.org	0x2000
 wakeup_stack:
+.org	0x3000
 wakeup_end:
+.org	0x4000
 
 wakeup_pmode_return:
 	movl	$__KERNEL_DS, %eax
@@ -262,6 +267,48 @@
 
 ENTRY(saved_magic)	.long	0
 
+ENTRY(do_suspend_lowlevel)
+	cmpl $0,4(%esp)
+	jne .L1432
+	call save_processor_state
+
+	movl %esp, saved_context_esp
+	movl %eax, saved_context_eax
+	movl %ebx, saved_context_ebx
+	movl %ecx, saved_context_ecx
+	movl %edx, saved_context_edx
+	movl %ebp, saved_context_ebp
+	movl %esi, saved_context_esi
+	movl %edi, saved_context_edi
+	pushfl ; popl saved_context_eflags
+
+	movl $.L1432,saved_eip
+	movl %esp,saved_esp
+	movl %ebp,saved_ebp
+	movl %ebx,saved_ebx
+	movl %edi,saved_edi
+	movl %esi,saved_esi
+
+	pushl $3
+	call acpi_enter_sleep_state
+	addl $4,%esp
+	ret
+	.p2align 4,,7
+.L1432:
+	movl $104,%eax
+	movw %eax, %ds
+	movl saved_context_esp, %esp
+	movl saved_context_ebp, %ebp
+	movl saved_context_eax, %eax
+	movl saved_context_ebx, %ebx
+	movl saved_context_ecx, %ecx
+	movl saved_context_edx, %edx
+	movl saved_context_esi, %esi
+	movl saved_context_edi, %edi
+	call restore_processor_state
+	pushl saved_context_eflags ; popfl
+	ret
+
 ALIGN
 # saved registers
 saved_gdt:	.long	0,0
--- clean/arch/i386/kernel/head.S	2002-10-14 18:18:30.000000000 +0200
+++ linux-swsusp/arch/i386/kernel/head.S	2002-11-02 22:36:58.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/i386/head.S -- the 32-bit startup code.
+ *  linux/arch/i386/kernel/head.S -- the 32-bit startup code.
  *
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *
--- clean/arch/i386/kernel/suspend.c	2002-11-01 00:37:05.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/suspend.c	2002-11-12 18:12:40.000000000 +0100
@@ -28,26 +28,11 @@
 #include <asm/tlbflush.h>
 
 static struct saved_context saved_context;
+unsigned long saved_context_eax, saved_context_ebx, saved_context_ecx, saved_context_edx;
+unsigned long saved_context_esp, saved_context_ebp, saved_context_esi, saved_context_edi;
+unsigned long saved_context_eflags;
 
-/*
- * save_processor_context
- * 
- * Save the state of the processor before we go to sleep.
- *
- * return_stack is the value of the stack pointer (%esp) as the caller sees it.
- * A good way could not be found to obtain it from here (don't want to make _too_
- * many assumptions about the layout of the stack this far down.) Also, the 
- * handy little __builtin_frame_pointer(level) where level > 0, is blatantly 
- * buggy - it returns the value of the stack at the proper location, not the 
- * location, like it should (as of gcc 2.91.66)
- * 
- * Note that the context and timing of this function is pretty critical.
- * With a minimal amount of things going on in the caller and in here, gcc
- * does a good job of being just a dumb compiler.  Watch the assembly output
- * if anything changes, though, and make sure everything is going in the right
- * place. 
- */
-static inline void save_processor_context (void)
+void save_processor_state(void)
 {
 	kernel_fpu_begin();
 
@@ -60,23 +45,6 @@
 	asm volatile ("str %0"  : "=m" (saved_context.tr));
 
 	/*
-	 * save the general registers.
-	 * note that gcc has constructs to specify output of certain registers,
-	 * but they're not used here, because it assumes that you want to modify
-	 * those registers, so it tries to be smart and save them beforehand.
-	 * It's really not necessary, and kinda fishy (check the assembly output),
-	 * so it's avoided. 
-	 */
-	asm volatile ("movl %%esp, %0" : "=m" (saved_context.esp));
-	asm volatile ("movl %%eax, %0" : "=m" (saved_context.eax));
-	asm volatile ("movl %%ebx, %0" : "=m" (saved_context.ebx));
-	asm volatile ("movl %%ecx, %0" : "=m" (saved_context.ecx));
-	asm volatile ("movl %%edx, %0" : "=m" (saved_context.edx));
-	asm volatile ("movl %%ebp, %0" : "=m" (saved_context.ebp));
-	asm volatile ("movl %%esi, %0" : "=m" (saved_context.esi));
-	asm volatile ("movl %%edi, %0" : "=m" (saved_context.edi));
-	/* FIXME: Need to save XMM0..XMM15? */
-	/*
 	 * segment registers
 	 */
 	asm volatile ("movw %%es, %0" : "=m" (saved_context.es));
@@ -91,11 +59,6 @@
 	asm volatile ("movl %%cr2, %0" : "=r" (saved_context.cr2));
 	asm volatile ("movl %%cr3, %0" : "=r" (saved_context.cr3));
 	asm volatile ("movl %%cr4, %0" : "=r" (saved_context.cr4));
-
-	/*
-	 * eflags
-	 */
-	asm volatile ("pushfl ; popl %0" : "=m" (saved_context.eflags));
 }
 
 static void
@@ -106,26 +69,8 @@
         kernel_fpu_end();
 }
 
-/*
- * restore_processor_context
- * 
- * Restore the processor context as it was before we went to sleep
- * - descriptor tables
- * - control registers
- * - segment registers
- * - flags
- * 
- * Note that it is critical that this function is declared inline.  
- * It was separated out from restore_state to make that function
- * a little clearer, but it needs to be inlined because we won't have a
- * stack when we get here (so we can't push a return address).
- */
-static inline void restore_processor_context (void)
+void restore_processor_state(void)
 {
-	/*
-	 * first restore %ds, so we can access our data properly
-	 */
-	asm volatile ("movw %0, %%ds" :: "r" (__KERNEL_DS));
 
 	/*
 	 * control registers
@@ -144,24 +89,6 @@
 	asm volatile ("movw %0, %%ss" :: "r" (saved_context.ss));
 
 	/*
-	 * the other general registers
-	 *
-	 * note that even though gcc has constructs to specify memory 
-	 * input into certain registers, it will try to be too smart
-	 * and save them at the beginning of the function.  This is esp.
-	 * bad since we don't have a stack set up when we enter, and we 
-	 * want to preserve the values on exit. So, we set them manually.
-	 */
-	asm volatile ("movl %0, %%esp" :: "m" (saved_context.esp));
-	asm volatile ("movl %0, %%ebp" :: "m" (saved_context.ebp));
-	asm volatile ("movl %0, %%eax" :: "m" (saved_context.eax));
-	asm volatile ("movl %0, %%ebx" :: "m" (saved_context.ebx));
-	asm volatile ("movl %0, %%ecx" :: "m" (saved_context.ecx));
-	asm volatile ("movl %0, %%edx" :: "m" (saved_context.edx));
-	asm volatile ("movl %0, %%esi" :: "m" (saved_context.esi));
-	asm volatile ("movl %0, %%edi" :: "m" (saved_context.edi));
-
-	/*
 	 * now restore the descriptor tables to their proper values
 	 * ltr is done i fix_processor_context().
 	 */
@@ -170,42 +97,15 @@
 	asm volatile ("lldt %0" :: "m" (saved_context.ldt));
 
 	fix_processor_context();
-
-	/*
-	 * the flags
-	 */
-	asm volatile ("pushl %0 ; popfl" :: "m" (saved_context.eflags));
-
 	do_fpu_end();
 }
 
-#ifdef CONFIG_ACPI_SLEEP
-void do_suspend_lowlevel(int resume)
-{
-/*
- * FIXME: This function should really be written in assembly. Actually
- * requirement is that it does not touch stack, because %esp will be
- * wrong during resume before restore_processor_context(). Check
- * assembly if you modify this.
- */
-	if (!resume) {
-		save_processor_context();
-		acpi_save_register_state((unsigned long)&&acpi_sleep_done);
-		acpi_enter_sleep_state(3);
-		return;
-	}
-acpi_sleep_done:
-	acpi_restore_register_state();
-	restore_processor_context();
-}
-#endif
-
 void fix_processor_context(void)
 {
 	int cpu = smp_processor_id();
 	struct tss_struct * t = init_tss + cpu;
 
-	set_tss_desc(cpu,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy tsc or some similar stupidity. */
+	set_tss_desc(cpu,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy TSS or some similar stupidity. */
         cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
 
 	load_TR_desc();				/* This does ltr */
@@ -226,77 +126,9 @@
 
 }
 
-
 #ifdef CONFIG_SOFTWARE_SUSPEND
 /* Local variables for do_magic */
-static int loop __nosavedata = 0;
-static int loop2 __nosavedata = 0;
-
-/*
- * (KG): Since we affect stack here, we make this function as flat and easy
- * as possible in order to not provoke gcc to use local variables on the stack.
- * Note that on resume, all (expect nosave) variables will have the state from
- * the time of writing (suspend_save_image) and the registers (including the
- * stack pointer, but excluding the instruction pointer) will be loaded with 
- * the values saved at save_processor_context() time.
- */
-void do_magic(int resume)
-{
-	/* DANGER WILL ROBINSON!
-	 *
-	 * If this function is too difficult for gcc to optimize, it will crash and burn!
-	 * see above.
-	 *
-	 * DO NOT TOUCH.
-	 */
-
-	if (!resume) {
-		do_magic_suspend_1();
-		save_processor_context();	/* We need to capture registers and memory at "same time" */
-		do_magic_suspend_2();		/* If everything goes okay, this function does not return */
-		return;
-	}
+int loop __nosavedata = 0;
+int loop2 __nosavedata = 0;
 
-	/* We want to run from swapper_pg_dir, since swapper_pg_dir is stored in constant
-	 * place in memory 
-	 */
-
-        __asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swapper_pg_dir)));
-
-/*
- * Final function for resuming: after copying the pages to their original
- * position, it restores the register state.
- *
- * What about page tables? Writing data pages may toggle
- * accessed/dirty bits in our page tables. That should be no problems
- * with 4MB page tables. That's why we require have_pse.  
- *
- * This loops destroys stack from under itself, so it better should
- * not use any stack space, itself. When this function is entered at
- * resume time, we move stack to _old_ place.  This is means that this
- * function must use no stack and no local variables in registers,
- * until calling restore_processor_context();
- *
- * Critical section here: noone should touch saved memory after
- * do_magic_resume_1; copying works, because nr_copy_pages,
- * pagedir_nosave, loop and loop2 are nosavedata.
- */
-	do_magic_resume_1();
-
-	for (loop=0; loop < nr_copy_pages; loop++) {
-		/* You may not call something (like copy_page) here: see above */
-		for (loop2=0; loop2 < PAGE_SIZE; loop2++) {
-			*(((char *)((pagedir_nosave+loop)->orig_address))+loop2) =
-				*(((char *)((pagedir_nosave+loop)->address))+loop2);
-			__flush_tlb();
-		}
-	}
-
-	restore_processor_context();
-
-/* Ahah, we now run with our old stack, and with registers copied from
-   suspend time */
-
-	do_magic_resume_2();
-}
 #endif
--- clean/arch/i386/kernel/suspend_asm.S	2002-11-07 18:26:08.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/suspend_asm.S	2002-11-12 18:24:13.000000000 +0100
@@ -0,0 +1,80 @@
+.text
+#include <linux/linkage.h>
+#include <asm/segment.h>
+#include <asm/page.h>
+
+ENTRY(do_magic):
+	pushl %ebx
+	cmpl $0,8(%esp)
+	jne .L1450
+	call do_magic_suspend_1
+	call save_processor_state
+
+	movl %esp, saved_context_esp
+	movl %eax, saved_context_eax
+	movl %ebx, saved_context_ebx
+	movl %ecx, saved_context_ecx
+	movl %edx, saved_context_edx
+	movl %ebp, saved_context_ebp
+	movl %esi, saved_context_esi
+	movl %edi, saved_context_edi
+	pushfl ; popl saved_context_eflags
+
+	call do_magic_suspend_2
+	jmp .L1449
+	.p2align 4,,7
+.L1450:
+	movl $swapper_pg_dir-__PAGE_OFFSET,%ecx
+	movl %ecx,%cr3
+
+	call do_magic_resume_1
+	movl $0,loop
+	cmpl $0,nr_copy_pages
+	je .L1453
+	.p2align 4,,7
+.L1455:
+	movl $0,loop2
+	.p2align 4,,7
+.L1459:
+	movl pagedir_nosave,%ecx
+	movl loop,%eax
+	movl loop2,%edx
+	sall $4,%eax
+	movl 4(%ecx,%eax),%ebx
+	movl (%ecx,%eax),%eax
+	movb (%edx,%eax),%al
+	movb %al,(%edx,%ebx)
+	movl %cr3, %eax;              
+	movl %eax, %cr3;  # flush TLB 
+
+	movl loop2,%eax
+	leal 1(%eax),%edx
+	movl %edx,loop2
+	movl %edx,%eax
+	cmpl $4095,%eax
+	jbe .L1459
+	movl loop,%eax
+	leal 1(%eax),%edx
+	movl %edx,loop
+	movl %edx,%eax
+	cmpl nr_copy_pages,%eax
+	jb .L1455
+	.p2align 4,,7
+.L1453:
+	movl $104,%eax
+
+	movw %eax, %ds
+	movl saved_context_esp, %esp
+	movl saved_context_ebp, %ebp
+	movl saved_context_eax, %eax
+	movl saved_context_ebx, %ebx
+	movl saved_context_ecx, %ecx
+	movl saved_context_edx, %edx
+	movl saved_context_esi, %esi
+	movl saved_context_edi, %edi
+	call restore_processor_state
+	pushl saved_context_eflags ; popfl
+	call do_magic_resume_2
+.L1449:
+	popl %ebx
+	ret
--- clean/arch/i386/kernel/traps.c	2002-11-12 18:40:26.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/traps.c	2002-11-12 22:22:54.000000000 +0100
@@ -210,6 +210,7 @@
 		ss = regs->xss & 0xffff;
 	}
 	print_modules();
+	mdelay(1000);
 	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s\nEFLAGS: %08lx\n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip, print_tainted(), regs->eflags);
 
@@ -222,6 +223,7 @@
 		regs->xds & 0xffff, regs->xes & 0xffff, ss);
 	printk("Process %s (pid: %d, threadinfo=%p task=%p)",
 		current->comm, current->pid, current_thread_info(), current);
+	mdelay(4000);
 	/*
 	 * When in-kernel, we also print out the stack and code at the
 	 * time of the fault..
--- clean/drivers/ide/ide-disk.c	2002-11-12 18:40:35.000000000 +0100
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
--- clean/drivers/ide/ide-probe.c	2002-11-12 18:40:35.000000000 +0100
+++ linux-swsusp/drivers/ide/ide-probe.c	2002-11-12 22:23:02.000000000 +0100
@@ -1059,6 +1059,7 @@
 			 "%s","IDE Drive");
 		drive->gendev.parent = &hwif->gendev;
 		drive->gendev.bus = &ide_bus_type;
+		drive->gendev.driver_data = drive;
 		sprintf (name, "host%d/bus%d/target%d/lun%d",
 			(hwif->channel && hwif->mate) ?
 			hwif->mate->index : hwif->index,
--- clean/drivers/ide/ide.c	2002-11-12 18:40:35.000000000 +0100
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
 
--- clean/drivers/md/md.c	2002-11-12 18:40:36.000000000 +0100
+++ linux-swsusp/drivers/md/md.c	2002-11-12 22:23:03.000000000 +0100
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
--- clean/drivers/net/3c59x.c	2002-11-12 18:40:36.000000000 +0100
+++ linux-swsusp/drivers/net/3c59x.c	2002-11-12 22:23:03.000000000 +0100
@@ -809,6 +809,9 @@
 	spinlock_t lock;					/* Serialise access to device & its vortex_private */
 	spinlock_t mdio_lock;				/* Serialise access to mdio hardware */
 	u32 power_state[16];
+#ifdef CONFIG_PM
+	int in_suspend;
+#endif
 };
 
 /* The action to take with a media selection timer tick.
@@ -893,6 +896,10 @@
 	struct net_device *dev = pci_get_drvdata(pdev);
 
 	if (dev && dev->priv) {
+		struct vortex_private *vp = dev->priv;
+		if (vp->in_suspend)
+			return 0;
+		vp->in_suspend = 1;
 		if (netif_running(dev)) {
 			netif_device_detach(dev);
 			vortex_down(dev);
@@ -906,6 +913,10 @@
 	struct net_device *dev = pci_get_drvdata(pdev);
 
 	if (dev && dev->priv) {
+		struct vortex_private *vp = dev->priv;
+		if (!vp->in_suspend)
+			return 0;
+		vp->in_suspend = 1;
 		if (netif_running(dev)) {
 			vortex_up(dev);
 			netif_device_attach(dev);
--- clean/include/asm-i386/suspend.h	2002-11-01 00:37:39.000000000 +0100
+++ linux-swsusp/include/asm-i386/suspend.h	2002-11-07 17:57:46.000000000 +0100
@@ -15,8 +15,6 @@
 
 /* image of the saved processor state */
 struct saved_context {
-	unsigned long eax, ebx, ecx, edx;
-	unsigned long esp, ebp, esi, edi;
   	u16 es, fs, gs, ss;
 	unsigned long cr0, cr2, cr3, cr4;
 	u16 gdt_pad;
@@ -30,9 +28,14 @@
 	unsigned long tr;
 	unsigned long safety;
 	unsigned long return_address;
-	unsigned long eflags;
 } __attribute__((packed));
 
+/* We'll access these from assembly, so we'd better have them outside struct */
+extern unsigned long saved_context_eax, saved_context_ebx, saved_context_ecx, saved_context_edx;
+extern unsigned long saved_context_esp, saved_context_ebp, saved_context_esi, saved_context_edi;
+extern unsigned long saved_context_eflags;
+
+
 #define loaddebug(thread,register) \
                __asm__("movl %0,%%db" #register  \
                        : /* no output */ \
--- clean/include/linux/ide.h	2002-11-12 18:40:46.000000000 +0100
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
--- clean/kernel/suspend.c	2002-11-01 00:37:42.000000000 +0100
+++ linux-swsusp/kernel/suspend.c	2002-11-08 11:37:06.000000000 +0100
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
 
@@ -489,7 +490,6 @@
 			if (PageNosave(page))
 				continue;
 
-
 			if ((chunk_size=is_head_of_free_region(page))!=0) {
 				pfn += chunk_size - 1;
 				continue;
@@ -500,9 +500,8 @@
 			/*
 			 * Just copy whole code segment. Hopefully it is not that big.
 			 */
-			if (ADDRESS(pfn) >= (unsigned long)
-				&__nosave_begin && ADDRESS(pfn) < 
-				(unsigned long)&__nosave_end) {
+			if ((ADDRESS(pfn) >= (unsigned long) &__nosave_begin) && 
+			    (ADDRESS(pfn) <  (unsigned long) &__nosave_end)) {
 				PRINTK("[nosave %x]", ADDRESS(pfn));
 				continue;
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
+void suspend_save_image(void)
+{
+	drivers_unsuspend();
 
 	lock_swapdevices();
 	write_suspend_image();
@@ -738,7 +744,6 @@
 	 * filesystem clean: it is not. (And it does not matter, if we resume
 	 * correctly, we'll mark system clean, anyway.)
 	 */
-	return 0;
 }
 
 void suspend_power_down(void)
@@ -788,8 +793,8 @@
 
 	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
-	drivers_resume(RESUME_ALL_PHASES);
 	spin_unlock_irq(&suspend_pagedir_lock);
+	drivers_resume(RESUME_ALL_PHASES);
 
 	PRINTK( "Fixing swap signatures... " );
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
@@ -804,14 +809,17 @@
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
--- clean/mm/page_alloc.c	2002-11-12 18:40:47.000000000 +0100
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
