Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289367AbSA1UYR>; Mon, 28 Jan 2002 15:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289377AbSA1UWR>; Mon, 28 Jan 2002 15:22:17 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:50190 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S289367AbSA1UTV>;
	Mon, 28 Jan 2002 15:19:21 -0500
Date: Mon, 28 Jan 2002 11:07:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        Swsusp mailing list <swsusp@lister.fornax.hu>
Subject: swsusp for 2.4.17 -- newer ide supported
Message-ID: <20020128100704.GA3013@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is newer version of swsusp patch. It now supports newer ide
driver (which just about everybody uses). It sometimes fails to
suspend when top is running, otherwise no bugs are known. Try to break
this one!
								Pavel

--- clean.2.4/CREDITS	Tue Dec 25 22:39:18 2001
+++ linux-swsusp.24/CREDITS	Wed Jan 23 11:54:15 2002
@@ -1666,6 +1666,11 @@
 S: D-91080 Uttenreuth
 S: Germany
 
+N: Gabor Kuti
+E: seasons@falcon.sch.bme.hu
+E: seasons@makosteszta.sote.hu
+D: Author and Maintainer for Software Suspend
+
 N: Jaroslav Kysela
 E: perex@suse.cz
 W: http://www.perex.cz
@@ -1838,7 +1843,8 @@
 E: pavel@ucw.cz
 E: pavel@suse.cz
 D: Softcursor for vga, hypertech cdrom support, vcsa bugfix, nbd
-D: sun4/330 port, capabilities for elf, speedup for rm on ext2, USB
+D: sun4/330 port, capabilities for elf, speedup for rm on ext2, USB,
+D: x86-64 port, software suspend
 S: Volkova 1131
 S: 198 00 Praha 9
 S: Czech Republic
--- clean.2.4/Documentation/Configure.help	Tue Dec 25 22:39:18 2001
+++ linux-swsusp.24/Documentation/Configure.help	Wed Jan 23 11:56:19 2002
@@ -112,6 +112,31 @@
   like MGA monitors that you are very unlikely to see on today's
   systems.
 
+Software Suspend
+CONFIG_SOFTWARE_SUSPEND
+  Enable the possibilty of suspendig machine. It doesn't need APM.
+  You may suspend your machine by either pressing Sysrq-d or with
+  'swsusp' or 'shutdown -z <time>' (patch for sysvinit needed). It
+  creates an image which is saved in your active swaps. By the next
+  booting the kernel detects the saved image, restores the memory from
+  it and then it continues to run as before you've suspended.
+  If you don't want the previous state to continue use the 'noresume'
+  kernel option. However note that your partitions will be fsck'd and
+  you must re-mkswap your swap partitions/files.
+
+  Right now you may boot without resuming and then later resume but
+  in meantime you cannot use those swap partitions/files which were
+  involved in suspending. Also in this case there is a risk that buffers
+  on disk won't match with saved ones.
+
+  SMP is supported ``as-is''. There's a code for it but doesn't work.
+  There have been problems reported relating SCSI.
+  
+  This option is about getting stable. However there is still some
+  absence of features.
+
+  For more information take a look at Documentation/swsusp.txt.
+
 Symmetric Multi-Processing support
 CONFIG_SMP
   This enables support for systems with more than one CPU. If you have
--- clean.2.4/MAINTAINERS	Tue Dec 25 22:39:19 2001
+++ linux-swsusp.24/MAINTAINERS	Wed Jan 23 11:54:15 2002
@@ -1378,6 +1378,14 @@
 L:	linux-raid@vger.kernel.org
 S:	Maintained
 
+SOFTWARE SUSPEND:
+P:	Gabor Kuti
+M:	seasons@falcon.sch.bme.hu
+M:	seasons@makosteszta.sote.hu
+L:	http://lister.fornax.hu/mailman/listinfo/swsusp
+W:	http://falcon.sch.bme.hu/~seasons/linux
+S:	Maintained
+
 SONIC NETWORK DRIVER
 P:	Thomas Bogendoerfer
 M:	tsbogend@alpha.franken.de
--- clean.2.4/arch/i386/config.in	Tue Dec 25 22:39:19 2001
+++ linux-swsusp.24/arch/i386/config.in	Wed Jan 23 11:54:15 2002
@@ -404,6 +404,9 @@
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
+if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+   dep_bool 'Software Suspend' CONFIG_SOFTWARE_SUSPEND $CONFIG_PM
+fi
 
 bool 'Kernel debugging' CONFIG_DEBUG_KERNEL
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
--- clean.2.4/arch/i386/defconfig	Wed Dec  5 23:45:54 2001
+++ linux-swsusp.24/arch/i386/defconfig	Wed Jan 23 11:54:15 2002
@@ -105,6 +105,7 @@
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
 # CONFIG_APM is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
 
 #
 # Memory Technology Devices (MTD)
--- clean.2.4/arch/i386/kernel/apm.c	Wed Dec  5 23:45:54 2001
+++ linux-swsusp.24/arch/i386/kernel/apm.c	Wed Jan 23 11:54:15 2002
@@ -1677,6 +1677,7 @@
 	daemonize();
 
 	strcpy(current->comm, "kapm-idled");
+	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 	current->tty = NULL;	/* get rid of controlling tty */
 
--- clean.2.4/arch/i386/kernel/process.c	Fri Oct  5 03:42:54 2001
+++ linux-swsusp.24/arch/i386/kernel/process.c	Wed Jan 23 11:54:15 2002
@@ -736,6 +736,20 @@
 	}
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+/*
+ * We reload there esp0, LDT, page table pointer only. Other processor
+ * registers including segment ones are restored before calling this function
+ */
+void activate_task(struct task_struct *tsk_p)
+{
+	struct thread_struct *tsk = &tsk_p->thread;
+	struct tss_struct *tss = init_tss + smp_processor_id();
+
+	tss->esp0 = tsk->esp0;
+}
+#endif
+
 asmlinkage int sys_fork(struct pt_regs regs)
 {
 	return do_fork(SIGCHLD, regs.esp, &regs, 0);
--- clean.2.4/arch/i386/kernel/signal.c	Fri Sep 14 23:15:40 2001
+++ linux-swsusp.24/arch/i386/kernel/signal.c	Wed Jan 23 11:54:15 2002
@@ -20,6 +20,7 @@
 #include <linux/stddef.h>
 #include <linux/tty.h>
 #include <linux/personality.h>
+#include <linux/suspend.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -595,6 +596,11 @@
 	if ((regs->xcs & 3) != 3)
 		return 1;
 
+	if (current->flags & PF_FREEZE) {
+		refrigerator();
+		goto no_signal;
+	}
+
 	if (!oldset)
 		oldset = &current->blocked;
 
@@ -705,6 +711,7 @@
 		return 1;
 	}
 
+ no_signal:
 	/* Did we come from a system call? */
 	if (regs->orig_eax >= 0) {
 		/* Restart the system call - no handlers present */
--- clean.2.4/arch/i386/vmlinux.lds	Mon Jul  2 23:40:14 2001
+++ linux-swsusp.24/arch/i386/vmlinux.lds	Wed Jan 23 11:54:15 2002
@@ -54,6 +54,12 @@
   __init_end = .;
 
   . = ALIGN(4096);
+  __nosave_begin = .;
+  .data_nosave : { *(.data.nosave) }
+  . = ALIGN(4096);
+  __nosave_end = .;
+
+  . = ALIGN(4096);
   .data.page_aligned : { *(.data.idt) }
 
   . = ALIGN(32);
--- clean.2.4/drivers/acpi/ospm/system/sm.c	Wed Oct 24 23:06:22 2001
+++ linux-swsusp.24/drivers/acpi/ospm/system/sm.c	Wed Jan 23 11:54:15 2002
@@ -146,7 +146,9 @@
 			system->states[i] = TRUE;
 		}
 	}
-
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	system->states[4] = TRUE;;
+#endif
 	status = sm_osl_add_device(system);
 	if (ACPI_FAILURE(status)) {
 		goto end;
--- clean.2.4/drivers/acpi/ospm/system/sm_osl.c	Tue Dec 25 22:39:20 2001
+++ linux-swsusp.24/drivers/acpi/ospm/system/sm_osl.c	Wed Jan 23 11:54:15 2002
@@ -140,7 +140,10 @@
 	if (system->states[value] != TRUE)
 		return -EINVAL;
 	
-	sm_osl_suspend(value);
+	if (value != ACPI_S4)
+		sm_osl_suspend(value);
+	else
+		software_suspend();
 	
 	return (count);
 }
@@ -685,6 +688,9 @@
 	 */
 	if (state == ACPI_S2 || state == ACPI_S3) {
 #ifdef DONT_USE_UNTIL_LOWLEVEL_CODE_EXISTS
+		/* That && trick is *not going to work*. Read gcc
+		   specs. That explicitely says: jumping from other
+		   function is *not allowed*. */ 
 		wakeup_address = acpi_save_state_mem((unsigned long)&&acpi_sleep_done);
 
 		if (!wakeup_address) goto acpi_sleep_done;
@@ -692,11 +698,12 @@
 		acpi_set_firmware_waking_vector(
 			(ACPI_PHYSICAL_ADDRESS)wakeup_address);
 #endif
-	} else if (state == ACPI_S4)
+	} else if (state == ACPI_S4) {
 #ifdef DONT_USE_UNTIL_LOWLEVEL_CODE_EXISTS
 		if (acpi_save_state_disk((unsigned long)&&acpi_sleep_done)) 
-			goto acpi_sleep_done;
+			goto acpi_sleep_done
 #endif
+	}
 
 	/* set status, since acpi_enter_sleep_state won't return unless something
 	 * goes wrong, or it's just S1.
--- clean.2.4/drivers/block/ll_rw_blk.c	Mon Oct 29 21:11:17 2001
+++ linux-swsusp.24/drivers/block/ll_rw_blk.c	Wed Jan 23 11:54:15 2002
@@ -816,6 +816,9 @@
  * particular, no other flags, are changed by generic_make_request or
  * any lower level drivers.
  * */
+
+kdev_t suspend_device;
+
 void generic_make_request (int rw, struct buffer_head * bh)
 {
 	int major = MAJOR(bh->b_rdev);
@@ -824,6 +827,8 @@
 
 	if (!bh->b_end_io)
 		BUG();
+	if (suspend_device && (bh->b_rdev != suspend_device))
+		panic("Attempted to corrupt disk.");
 
 	/* Test device size, when known. */
 	if (blk_size[major])
--- clean.2.4/drivers/char/sysrq.c	Tue Dec 25 22:39:21 2001
+++ linux-swsusp.24/drivers/char/sysrq.c	Wed Jan 23 11:54:15 2002
@@ -27,6 +27,7 @@
 #include <linux/quotaops.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
 
 #include <linux/spinlock.h>
 
@@ -332,6 +333,22 @@
 	action_msg:	"Kill All Tasks (even init)",
 };
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+static void sysrq_handle_swsusp(int key, struct pt_regs *pt_regs,
+		struct kbd_struct *kbd, struct tty_struct *tty) {
+        if(!software_suspend_enabled) {
+		printk("Software Suspend is not possible now\n");
+		return;
+	}
+	software_suspend();
+}
+static struct sysrq_key_op sysrq_swsusp_op = {
+	handler:	sysrq_handle_swsusp,
+	help_msg:	"suspenD",
+	action_msg:	"Software suspend\n",
+};
+#endif
+
 /* END SIGNAL SYSRQ HANDLERS BLOCK */
 
 
@@ -354,7 +371,11 @@
 		 and will never arive */
 /* b */	&sysrq_reboot_op,
 /* c */	NULL,
+#ifdef CONFIG_SOFTWARE_SUSPEND
+/* d */	&sysrq_swsusp_op,
+#else
 /* d */	NULL,
+#endif
 /* e */	&sysrq_term_op,
 /* f */	NULL,
 /* g */	NULL,
--- clean.2.4/drivers/char/tty_io.c	Tue Dec 25 22:39:21 2001
+++ linux-swsusp.24/drivers/char/tty_io.c	Wed Jan 23 11:54:15 2002
@@ -223,6 +223,7 @@
 	}
 	if (tty->magic != TTY_MAGIC) {
 		printk(badmagic, kdevname(device), routine);
+		printk("Magic should be %lx, is %lx (@%lx)\n", tty->magic, TTY_MAGIC, &tty->magic);
 		return 1;
 	}
 #endif
--- clean.2.4/drivers/ide/hd.c	Mon Oct 15 22:27:42 2001
+++ linux-swsusp.24/drivers/ide/hd.c	Wed Jan 23 11:54:15 2002
@@ -346,6 +346,13 @@
 		hd_request();
 }
 
+void do_reset_hd(void)
+{
+	DEVICE_INTR = NULL;
+	reset = 1;
+	reset_hd();
+}
+
 /*
  * Ok, don't know what to do with the unexpected interrupts: on some machines
  * doing a reset and a retry seems to result in an eternal loop. Right now I
--- clean.2.4/drivers/ide/ide-disk.c	Tue Dec 25 22:39:21 2001
+++ linux-swsusp.24/drivers/ide/ide-disk.c	Mon Jan 28 10:33:59 2002
@@ -47,6 +47,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
+#include <linux/suspend.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -59,6 +60,8 @@
 #define IS_PDC4030_DRIVE (0)	/* auto-NULLs out pdc4030 code */
 #endif
 
+static int driver_blocked = 0;
+
 static void idedisk_bswap_data (void *buffer, int wcount)
 {
 	u16 *p = buffer;
@@ -367,6 +370,8 @@
  */
 static ide_startstop_t do_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)
 {
+	if (driver_blocked)
+		panic("Request while ide driver is blocked?");
 	if (IDE_CONTROL_REG)
 		OUT_BYTE(drive->ctl,IDE_CONTROL_REG);
 	OUT_BYTE(0x00, IDE_FEATURE_REG);
@@ -888,6 +893,74 @@
 	ide_register_module(&idedisk_module);
 	MOD_DEC_USE_COUNT;
 	return 0;
+}
+
+void panic_box(void)
+{
+	panic("Attempted to corrupt something: ide operation was pending accross suspend/resume.\n");
+}
+
+int ide_disks_busy(void)
+{
+	int i;
+	for (i=0; i<MAX_HWIFS; i++) {
+		struct hwgroup_s *hwgroup = ide_hwifs[i].hwgroup;
+		if (!hwgroup) continue;
+		if ((hwgroup->handler) && (hwgroup->handler != panic_box))
+			return 1;
+	}
+	return 0;
+}
+
+void ide_disk_suspend(void)
+{
+	int i;
+	printk("ide_disk_suspend()\n");
+	while (ide_disks_busy()) {
+		printk("*");
+		schedule();
+	}
+	for (i=0; i<MAX_HWIFS; i++) {
+		struct hwgroup_s *hwgroup = ide_hwifs[i].hwgroup;
+
+		if (!hwgroup) continue;
+		hwgroup->handler_save = hwgroup->handler;
+		hwgroup->handler = panic_box;
+	}
+	driver_blocked = 1;
+	if (ide_disks_busy())
+		panic("How did you get that request through?!");
+}
+
+/* unsuspend and resume should be equal in the ideal world */
+
+void ide_disk_unsuspend(void)
+{
+	int i;
+	printk("ide_disk_unsuspend()\n");
+	for (i=0; i<MAX_HWIFS; i++) {
+		struct hwgroup_s *hwgroup = ide_hwifs[i].hwgroup;
+
+		if (!hwgroup) continue;
+		hwgroup->handler = hwgroup->handler_save;
+		hwgroup->handler_save = NULL;
+	}
+	driver_blocked = 0;
+}
+
+void ide_disk_resume(void)
+{
+	int i;
+	printk("ide_disk_resume()\n");
+	for (i=0; i<MAX_HWIFS; i++) {
+		struct hwgroup_s *hwgroup = ide_hwifs[i].hwgroup;
+
+		if (!hwgroup) continue;
+		if (hwgroup->handler != panic_box)
+			panic("Handler was not set to panic?");
+		hwgroup->handler_save = NULL;
+	}
+	driver_blocked = 0;
 }
 
 module_init(idedisk_init);
--- clean.2.4/drivers/usb/storage/usb.c	Wed Dec  5 23:46:02 2001
+++ linux-swsusp.24/drivers/usb/storage/usb.c	Wed Jan 23 11:54:15 2002
@@ -316,6 +316,7 @@
 	 */
 	exit_files(current);
 	current->files = init_task.files;
+	current->flags |= PF_IOTHREAD;
 	atomic_inc(&current->files->count);
 	daemonize();
 
--- clean.2.4/fs/buffer.c	Tue Dec 25 22:39:27 2001
+++ linux-swsusp.24/fs/buffer.c	Wed Jan 23 11:54:15 2002
@@ -129,6 +129,8 @@
 		wake_up(&bh->b_wait);
 }
 
+DECLARE_TASK_QUEUE(tq_bdflush);
+
 /*
  * Rewrote the wait-routines to use the "new" wait-queue functionality,
  * and getting rid of the cli-sti pairs. The wait-queue routines still
@@ -2785,6 +2787,9 @@
 
 	for (;;) {
 		CHECK_EMERGENCY_SYNC
+#ifdef CONFIG_SOFTWARE_SUSPEND
+		run_task_queue(&tq_bdflush);
+#endif
 
 		spin_lock(&lru_list_lock);
 		if (!write_some_buffers(NODEV) || balance_dirty_state() < 0) {
@@ -2823,6 +2828,8 @@
 
 		/* update interval */
 		interval = bdf_prm.b_un.interval;
+		if (current->flags & PF_FREEZE)
+			refrigerator();
 		if (interval) {
 			tsk->state = TASK_INTERRUPTIBLE;
 			schedule_timeout(interval);
--- clean.2.4/include/asm-generic/bitops.h	Tue Nov 28 02:47:38 2000
+++ linux-swsusp.24/include/asm-generic/bitops.h	Wed Jan 23 11:54:15 2002
@@ -51,6 +51,12 @@
 	return ((mask & *addr) != 0);
 }
 
+/*
+ * fls: find last bit set.
+ */
+
+#define fls(x) generic_fls(x)
+
 #ifdef __KERNEL__
 
 /*
--- clean.2.4/include/asm-i386/bitops.h	Mon Nov  5 21:42:13 2001
+++ linux-swsusp.24/include/asm-i386/bitops.h	Wed Jan 23 11:54:15 2002
@@ -330,6 +330,12 @@
 	return word;
 }
 
+/*
+ * fls: find last bit set.
+ */
+
+#define fls(x) generic_fls(x)
+
 #ifdef __KERNEL__
 
 /**
--- clean.2.4/include/asm-i386/suspend.h	Sun Nov 11 20:26:37 2001
+++ linux-swsusp.24/include/asm-i386/suspend.h	Wed Jan 23 11:54:15 2002
@@ -0,0 +1,308 @@
+#ifndef __ASM_I386_SWSUSP_H
+#define __ASM_I386_SWSUSP_H
+#endif /* __ASM_I386_SWSUSP_H */
+
+#ifdef SUSPEND_C
+
+#include <asm/desc.h>
+#include <asm/i387.h>
+
+static inline void
+arch_prepare_suspend(void)
+{
+	if (!cpu_has_pse)
+		panic("pse required");
+}
+
+
+/* image of the saved processor state */
+struct saved_context {
+	u32 eax, ebx, ecx, edx;
+	u32 esp, ebp, esi, edi;
+	u16 es, fs, gs, ss;
+	u32 cr0, cr2, cr3, cr4;
+	u16 gdt_pad;
+	u16 gdt_limit;
+	u32 gdt_base;
+	u16 idt_pad;
+	u16 idt_limit;
+	u32 idt_base;
+	u16 ldt;
+	u16 tss;
+	u32 tr;
+	u32 safety;
+	u32 return_address;
+	u32 eflags;
+} __attribute__((packed));
+
+static struct saved_context saved_context;
+
+#define loaddebug(thread,register) \
+               __asm__("movl %0,%%db" #register  \
+                       : /* no output */ \
+                       :"r" ((thread)->debugreg[register]))
+
+ 
+/*
+ * save_processor_context
+ * 
+ * Save the state of the processor before we go to sleep.
+ *
+ * return_stack is the value of the stack pointer (%esp) as the caller sees it.
+ * A good way could not be found to obtain it from here (don't want to make _too_
+ * many assumptions about the layout of the stack this far down.) Also, the 
+ * handy little __builtin_frame_pointer(level) where level > 0, is blatantly 
+ * buggy - it returns the value of the stack at the proper location, not the 
+ * location, like it should (as of gcc 2.91.66)
+ * 
+ * Note that the context and timing of this function is pretty critical.
+ * With a minimal amount of things going on in the caller and in here, gcc
+ * does a good job of being just a dumb compiler.  Watch the assembly output
+ * if anything changes, though, and make sure everything is going in the right
+ * place. 
+ */
+static inline void save_processor_context (void)
+{
+	kernel_fpu_begin();
+
+	/*
+	 * descriptor tables
+	 */
+	asm volatile ("sgdt (%0)" : "=m" (saved_context.gdt_limit));
+	asm volatile ("sidt (%0)" : "=m" (saved_context.idt_limit));
+	asm volatile ("sldt (%0)" : "=m" (saved_context.ldt));
+	asm volatile ("str (%0)"  : "=m" (saved_context.tr));
+
+	/*
+	 * save the general registers.
+	 * note that gcc has constructs to specify output of certain registers,
+	 * but they're not used here, because it assumes that you want to modify
+	 * those registers, so it tries to be smart and save them beforehand.
+	 * It's really not necessary, and kinda fishy (check the assembly output),
+	 * so it's avoided. 
+	 */
+	asm volatile ("movl %%esp, (%0)" : "=m" (saved_context.esp));
+	asm volatile ("movl %%eax, (%0)" : "=m" (saved_context.eax));
+	asm volatile ("movl %%ebx, (%0)" : "=m" (saved_context.ebx));
+	asm volatile ("movl %%ecx, (%0)" : "=m" (saved_context.ecx));
+	asm volatile ("movl %%edx, (%0)" : "=m" (saved_context.edx));
+	asm volatile ("movl %%ebp, (%0)" : "=m" (saved_context.ebp));
+	asm volatile ("movl %%esi, (%0)" : "=m" (saved_context.esi));
+	asm volatile ("movl %%edi, (%0)" : "=m" (saved_context.edi));
+
+	/*
+	 * segment registers
+	 */
+	asm volatile ("movw %%es, %0" : "=r" (saved_context.es));
+	asm volatile ("movw %%fs, %0" : "=r" (saved_context.fs));
+	asm volatile ("movw %%gs, %0" : "=r" (saved_context.gs));
+	asm volatile ("movw %%ss, %0" : "=r" (saved_context.ss));
+
+	/*
+	 * control registers 
+	 */
+	asm volatile ("movl %%cr0, %0" : "=r" (saved_context.cr0));
+	asm volatile ("movl %%cr2, %0" : "=r" (saved_context.cr2));
+	asm volatile ("movl %%cr3, %0" : "=r" (saved_context.cr3));
+	asm volatile ("movl %%cr4, %0" : "=r" (saved_context.cr4));
+
+	/*
+	 * eflags
+	 */
+	asm volatile ("pushfl ; popl (%0)" : "=m" (saved_context.eflags));
+}
+
+void fix_processor_context(void)
+{
+	int nr = smp_processor_id();
+	struct tss_struct * t = &init_tss[nr];
+
+	printk("Tss desc..."); mdelay(1000);
+	set_tss_desc(nr,t);	/* This just modifies memory; should not be neccessary. But... This is neccessary, because 386 hardware has concept of busy tsc or some similar stupidity. */
+        gdt_table[__TSS(nr)].b &= 0xfffffdff;
+
+	printk("Tr..."); mdelay(1000);
+	load_TR(nr);		/* This does ltr */
+
+	printk("LDT..."); mdelay(1000);
+	load_LDT(current->active_mm);	/* This does lldt */
+
+	printk("Debug..."); mdelay(1000);
+	/*
+	 * Now maybe reload the debug registers
+	 */
+	if (current->thread.debugreg[7]){
+                loaddebug(&current->thread, 0);
+                loaddebug(&current->thread, 1);
+                loaddebug(&current->thread, 2);
+                loaddebug(&current->thread, 3);
+                /* no 4 and 5 */
+                loaddebug(&current->thread, 6);
+                loaddebug(&current->thread, 7);
+	}
+
+}
+
+void
+do_fpu_end(void)
+{
+        /* restore FPU regs if necessary */
+	/* Do it out of line so that gcc does not move cr0 load to some stupid place */
+	printk("FPU..."); mdelay(1000);
+        kernel_fpu_end();
+}
+
+/*
+ * restore_processor_context
+ * 
+ * Restore the processor context as it was before we went to sleep
+ * - descriptor tables
+ * - control registers
+ * - segment registers
+ * - flags
+ * 
+ * Note that it is critical that this function is declared inline.  
+ * It was separated out from restore_state to make that function
+ * a little clearer, but it needs to be inlined because we won't have a
+ * stack when we get here (so we can't push a return address).
+ */
+static inline void restore_processor_context (void)
+{
+	/*
+	 * first restore %ds, so we can access our data properly
+	 */
+	asm volatile (".align 4");
+	asm volatile ("movw %0, %%ds" :: "r" ((u16)__KERNEL_DS));
+
+
+	/*
+	 * control registers
+	 */
+	asm volatile ("movl %0, %%cr4" :: "r" (saved_context.cr4));
+	asm volatile ("movl %0, %%cr3" :: "r" (saved_context.cr3));
+	asm volatile ("movl %0, %%cr2" :: "r" (saved_context.cr2));
+	asm volatile ("movl %0, %%cr0" :: "r" (saved_context.cr0));
+	
+	/*
+	 * segment registers
+	 */
+	asm volatile ("movw %0, %%es" :: "r" (saved_context.es));
+	asm volatile ("movw %0, %%fs" :: "r" (saved_context.fs));
+	asm volatile ("movw %0, %%gs" :: "r" (saved_context.gs));
+	asm volatile ("movw %0, %%ss" :: "r" (saved_context.ss));
+
+	/*
+	 * the other general registers
+	 *
+	 * note that even though gcc has constructs to specify memory 
+	 * input into certain registers, it will try to be too smart
+	 * and save them at the beginning of the function.  This is esp.
+	 * bad since we don't have a stack set up when we enter, and we 
+	 * want to preserve the values on exit. So, we set them manually.
+	 */
+	asm volatile ("movl %0, %%esp" :: "m" (saved_context.esp));
+	asm volatile ("movl %0, %%ebp" :: "m" (saved_context.ebp));
+	asm volatile ("movl %0, %%eax" :: "m" (saved_context.eax));
+	asm volatile ("movl %0, %%ebx" :: "m" (saved_context.ebx));
+	asm volatile ("movl %0, %%ecx" :: "m" (saved_context.ecx));
+	asm volatile ("movl %0, %%edx" :: "m" (saved_context.edx));
+	asm volatile ("movl %0, %%esi" :: "m" (saved_context.esi));
+	asm volatile ("movl %0, %%edi" :: "m" (saved_context.edi));
+
+	/*
+	 * now restore the descriptor tables to their proper values
+	 */
+	asm volatile ("lgdt (%0)" :: "m" (saved_context.gdt_limit));
+	asm volatile ("lidt (%0)" :: "m" (saved_context.idt_limit));
+	asm volatile ("lldt (%0)" :: "m" (saved_context.ldt));
+
+#if 0
+	printk("Reloading old TR..."); mdelay(1000);
+
+	asm volatile ("ltr (%0)"  :: "m" (saved_context.tr));
+#endif
+
+	printk("Calling fix_processor_context..."); mdelay(1000);
+	fix_processor_context();
+
+	/*
+	 * the flags
+	 */
+	asm volatile ("pushl %0 ; popfl" :: "m" (saved_context.eflags));
+
+	do_fpu_end();
+}
+
+
+#if 1
+/* Local variables for do_magic */
+static int loop __nosavedata = 0;
+static int loop2 __nosavedata = 0;
+
+/*
+ * (KG): Since we affect stack here, we make this function as flat and easy
+ * as possible in order to not provoke gcc to use local variables on the stack.
+ * Note that on resume, all (expect nosave) variables will have the state from
+ * the time of writing (suspend_save_image) and the registers (including the
+ * stack pointer, but excluding the instruction pointer) will be loaded with 
+ * the values saved at save_processor_context() time.
+ */
+static void do_magic(int resume)
+{
+	/* DANGER WILL ROBINSON!
+	 *
+	 * If this function is too difficult for gcc to optimize, it will crash and burn!
+	 * see above.
+	 *
+	 * DO NOT TOUCH.
+	 */
+
+	if (!resume) {
+		do_magic_suspend_1();
+		save_processor_context();	/* We need to capture registers and memory at "same time" */
+		do_magic_suspend_2();
+		restore_processor_context();
+		return;
+	}
+
+	/* We want to run from swapper_pg_dir, since swapper_pg_dir is stored in constant
+	 * place in memory 
+	 */
+
+        __asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swapper_pg_dir)));
+
+/*
+ * Final function for resuming: after copying the pages to their original
+ * position, it restores the register state.
+ */
+
+	do_magic_resume_1();
+
+	/* Critical section here: noone should touch memory from now */
+	/* This works, because nr_copy_pages, pagedir_nosave, loop and loop2 are nosavedata */
+	for (loop=0; loop < nr_copy_pages; loop++) {
+		/* You may not call something (like copy_page) here:
+		   We may absolutely not use stack at this point */
+		for (loop2=0; loop2 < PAGE_SIZE; loop2++) {
+			*(((char *)((pagedir_nosave+loop)->orig_address))+loop2) =
+				*(((char *)((pagedir_nosave+loop)->address))+loop2);
+			__flush_tlb();
+		}
+	}
+/* FIXME: What about page tables? Writing data pages may toggle
+   accessed/dirty bits in our page tables. That should be no problems
+   with 4MB page tables. That's why we require have_pse. */
+
+/* Danger: previous loop probably destroyed our current stack. Better hope it did not use
+   any stack space, itself.
+
+   When this function is entered at resume time, we move stack to _old_ place.
+   This is means that this function must use no stack and no local variables in registers.
+*/
+	restore_processor_context();
+/* Ahah, we now run with our old stack, and with registers copied from suspend time */
+
+	do_magic_resume_2();
+}
+#endif
+#endif 
--- clean.2.4/include/linux/bitops.h	Mon Nov  5 21:42:13 2001
+++ linux-swsusp.24/include/linux/bitops.h	Wed Jan 23 11:54:15 2002
@@ -1,6 +1,6 @@
 #ifndef _LINUX_BITOPS_H
 #define _LINUX_BITOPS_H
-
+#include <asm/bitops.h>
 
 /*
  * ffs: find first bit set. This is defined the same way as
@@ -35,6 +35,47 @@
 		r += 1;
 	}
 	return r;
+}
+
+/*
+ * fls: find last bit set.
+ */
+
+extern __inline__ int generic_fls(int x)
+{
+	int r = 32;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff0000)) {
+		x <<= 16;
+		r -= 16;
+	}
+	if (!(x & 0xff000000)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xf0000000)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xc0000000)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x80000000)) {
+		x <<= 1;
+		r -= 1;
+	}
+	return r;
+}
+
+extern __inline__ int get_bitmask_order(unsigned int count)
+{
+	int order;
+	
+	order = fls(count);
+	return order;	/* We could be slightly more clever with -1 here... */
 }
 
 /*
--- clean.2.4/include/linux/ide.h	Mon Nov  5 21:43:28 2001
+++ linux-swsusp.24/include/linux/ide.h	Wed Jan 23 13:43:48 2002
@@ -468,7 +468,7 @@
 
 typedef struct hwif_s {
 	struct hwif_s	*next;		/* for linked-list in ide_hwgroup_t */
-	void		*hwgroup;	/* actually (ide_hwgroup_t *) */
+	struct hwgroup_s *hwgroup;	/* actually (ide_hwgroup_t *) */
 	ide_ioreg_t	io_ports[IDE_NR_PORTS];	/* task file registers */
 	hw_regs_t	hw;		/* Hardware info */
 	ide_drive_t	drives[MAX_DRIVES];	/* drive info */
@@ -543,6 +543,7 @@
 
 typedef struct hwgroup_s {
 	ide_handler_t		*handler;/* irq handler, if active */
+	ide_handler_t		*handler_save;/* irq handler, if active */
 	volatile int		busy;	/* BOOL: protects all fields below */
 	int			sleeping; /* BOOL: wake us up on timer expiry */
 	ide_drive_t		*drive;	/* current drive */
@@ -697,11 +698,9 @@
  * structure directly (the allocation/layout may change!).
  *
  */
-#ifndef _IDE_C
 extern	ide_hwif_t	ide_hwifs[];		/* master data repository */
 extern	ide_module_t	*ide_modules;
 extern	ide_module_t	*ide_probe;
-#endif
 extern int noautodma;
 
 /*
--- clean.2.4/include/linux/init.h	Tue Dec 25 22:39:30 2001
+++ linux-swsusp.24/include/linux/init.h	Wed Jan 23 12:00:49 2002
@@ -111,6 +111,9 @@
  */
 #define module_exit(x)	__exitcall(x);
 
+/* Data marked not to be saved by software_suspend() */
+#define __nosavedata __attribute__ ((__section__ (".data.nosave")))
+
 #else	/* MODULE */
 
 #define __init
--- clean.2.4/include/linux/mm.h	Tue Dec 25 22:39:30 2001
+++ linux-swsusp.24/include/linux/mm.h	Wed Jan 23 12:01:11 2002
@@ -285,6 +285,7 @@
 #define PG_arch_1		13
 #define PG_reserved		14
 #define PG_launder		15	/* written out by VM pressure.. */
+#define PG_nosave		29
 
 /* Make it prettier to test the above... */
 #define UnlockPage(page)	unlock_page(page)
@@ -338,6 +339,12 @@
 
 #define SetPageReserved(page)		set_bit(PG_reserved, &(page)->flags)
 #define ClearPageReserved(page)		clear_bit(PG_reserved, &(page)->flags)
+
+#define PageNosave(page)	test_bit(PG_nosave, &(page)->flags)
+#define PageSetNosave(page)	set_bit(PG_nosave, &(page)->flags)
+#define PageTestandSetNosave(page)	test_and_set_bit(PG_nosave, &(page)->flags)
+#define PageClearNosave(page)		clear_bit(PG_nosave, &(page)->flags)
+#define PageTestandClearNosave(page)	test_and_clear_bit(PG_nosave, &(page)->flags)
 
 /*
  * Error return values for the *_nopage functions
--- clean.2.4/include/linux/reboot.h	Fri Feb  9 23:46:13 2001
+++ linux-swsusp.24/include/linux/reboot.h	Wed Jan 23 11:54:15 2002
@@ -20,6 +20,7 @@
  * CAD_OFF     Ctrl-Alt-Del sequence sends SIGINT to init task.
  * POWER_OFF   Stop OS and remove all power from system, if possible.
  * RESTART2    Restart system using given command string.
+ * SW_SUSPEND  Suspend system using Software Suspend if compiled in
  */
 
 #define	LINUX_REBOOT_CMD_RESTART	0x01234567
@@ -28,6 +29,7 @@
 #define	LINUX_REBOOT_CMD_CAD_OFF	0x00000000
 #define	LINUX_REBOOT_CMD_POWER_OFF	0x4321FEDC
 #define	LINUX_REBOOT_CMD_RESTART2	0xA1B2C3D4
+#define	LINUX_REBOOT_CMD_SW_SUSPEND	0xD000FCE2
 
 
 #ifdef __KERNEL__
@@ -45,6 +47,13 @@
 extern void machine_restart(char *cmd);
 extern void machine_halt(void);
 extern void machine_power_off(void);
+
+/*
+ * Architecture-independent suspend facility
+ */
+
+extern void software_suspend(void);
+extern unsigned char software_suspend_enabled;
 
 #endif
 
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean.2.4/include/linux/sched.h linux-swsusp.24/include/linux/sched.h
--- clean.2.4/include/linux/sched.h	Tue Dec 25 22:39:30 2001
+++ linux-swsusp.24/include/linux/sched.h	Wed Jan 23 12:01:06 2002
@@ -427,6 +427,9 @@
 #define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
 #define PF_FREE_PAGES	0x00002000	/* per process page freeing */
 #define PF_NOIO		0x00004000	/* avoid generating further I/O */
+#define PF_FROZEN	0x00008000	/* frozen for system suspend */
+#define PF_FREEZE	0x00010000	/* this task should be frozen for suspend */
+#define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
 
 #define PF_USEDFPU	0x00100000	/* task used FPU this quantum (SMP) */
 
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean.2.4/include/linux/suspend.h linux-swsusp.24/include/linux/suspend.h
--- clean.2.4/include/linux/suspend.h	Sun Nov 11 20:26:35 2001
+++ linux-swsusp.24/include/linux/suspend.h	Wed Jan 23 12:01:11 2002
@@ -0,0 +1,64 @@
+#ifndef _LINUX_SWSUSP_H
+#define _LINUX_SWSUSP_H
+
+#include <asm/suspend.h>
+#include <linux/swap.h>
+#include <linux/notifier.h>
+#include <linux/config.h>
+
+extern unsigned char software_suspend_enabled;
+
+#define NORESUME	 1
+#define RESUME_SPECIFIED 2
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+/* page backup entry */
+typedef struct pbe {
+	unsigned long address;		/* address of the copy */
+	unsigned long orig_address;	/* original address of page */
+	swp_entry_t swap_address;	
+	swp_entry_t dummy;		/* we need scratch space at 
+					 * end of page (see link, diskpage)
+					 */
+} suspend_pagedir_t;
+
+#define SWAP_FILENAME_MAXLENGTH	32
+
+struct suspend_header {
+	__u32 version_code;
+	unsigned long num_physpages;
+	char machine[8];
+	char version[20];
+	int num_cpus;
+	int page_size;
+	unsigned long suspend_pagedir;
+	unsigned int num_pbes;
+	struct swap_location {
+		char filename[SWAP_FILENAME_MAXLENGTH];
+	} swap_location[MAX_SWAPFILES];
+};
+
+#define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
+   
+extern struct tq_struct suspend_tq;
+
+/* mm/vmscan.c */
+extern int shrink_mem(void);
+
+/* kernel/swsusp.c */
+extern void software_suspend(void);
+extern void software_resume(void);
+extern int resume_setup(char *str);
+
+extern int register_suspend_notifier(struct notifier_block *);
+extern int unregister_suspend_notifier(struct notifier_block *);
+extern void refrigerator(void);
+#else
+#define software_suspend()		do { } while(0)
+#define software_resume()		do { } while(0)
+#define register_suspend_notifier(a)	do { } while(0)
+#define unregister_suspend_notifier(a)	do { } while(0)
+#define refrigerator()			do { BUG(); } while(0)
+#endif
+
+#endif /* _LINUX_SWSUSP_H */
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean.2.4/include/linux/tqueue.h linux-swsusp.24/include/linux/tqueue.h
--- clean.2.4/include/linux/tqueue.h	Mon Nov  5 21:42:13 2001
+++ linux-swsusp.24/include/linux/tqueue.h	Wed Jan 23 12:00:49 2002
@@ -66,7 +66,7 @@
 #define DECLARE_TASK_QUEUE(q)	LIST_HEAD(q)
 #define TQ_ACTIVE(q)		(!list_empty(&q))
 
-extern task_queue tq_timer, tq_immediate, tq_disk;
+extern task_queue tq_timer, tq_immediate, tq_disk, tq_bdflush;
 
 /*
  * To implement your own list of active bottom halfs, use the following
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean.2.4/init/main.c linux-swsusp.24/init/main.c
--- clean.2.4/init/main.c	Tue Dec 25 22:39:30 2001
+++ linux-swsusp.24/init/main.c	Wed Jan 23 11:54:20 2002
@@ -27,6 +27,7 @@
 #include <linux/iobuf.h>
 #include <linux/bootmem.h>
 #include <linux/tty.h>
+#include <linux/suspend.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -765,6 +766,10 @@
 #endif
 	rd_load();
 #endif
+
+	/* This has to be before mounting root, because even readonly mount of reiserfs would replay
+	   log corrupting stuff */
+	software_resume();
 
 	/* Mount the root filesystem.. */
 	mount_root();
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean.2.4/kernel/Makefile linux-swsusp.24/kernel/Makefile
--- clean.2.4/kernel/Makefile	Mon Sep 17 06:22:40 2001
+++ linux-swsusp.24/kernel/Makefile	Wed Jan 23 11:54:21 2002
@@ -19,6 +19,7 @@
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
+obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean.2.4/kernel/context.c linux-swsusp.24/kernel/context.c
--- clean.2.4/kernel/context.c	Thu Oct 11 20:17:22 2001
+++ linux-swsusp.24/kernel/context.c	Wed Jan 23 11:54:21 2002
@@ -72,6 +72,7 @@
 
 	daemonize();
 	strcpy(curtask->comm, "keventd");
+	current->flags |= PF_IOTHREAD;
 	keventd_running = 1;
 	keventd_task = curtask;
 
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean.2.4/kernel/signal.c linux-swsusp.24/kernel/signal.c
--- clean.2.4/kernel/signal.c	Wed Dec  5 23:46:07 2001
+++ linux-swsusp.24/kernel/signal.c	Wed Jan 23 11:54:21 2002
@@ -463,7 +463,7 @@
  * No need to set need_resched since signal event passing
  * goes through ->blocked
  */
-static inline void signal_wake_up(struct task_struct *t)
+inline void signal_wake_up(struct task_struct *t)
 {
 	t->sigpending = 1;
 
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean.2.4/kernel/softirq.c linux-swsusp.24/kernel/softirq.c
--- clean.2.4/kernel/softirq.c	Wed Oct 31 19:26:02 2001
+++ linux-swsusp.24/kernel/softirq.c	Wed Jan 23 11:54:21 2002
@@ -366,6 +366,7 @@
 
 	daemonize();
 	current->nice = 19;
+	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 
 	/* Migrate to the right CPU */
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean.2.4/kernel/suspend.c linux-swsusp.24/kernel/suspend.c
--- clean.2.4/kernel/suspend.c	Sun Nov 11 20:26:28 2001
+++ linux-swsusp.24/kernel/suspend.c	Mon Jan 28 10:46:09 2002
@@ -0,0 +1,1294 @@
+/*
+ * linux/kernel/swsusp.c
+ *
+ * This file is to realize architecture-independent
+ * machine suspend feature using pretty near only high-level routines
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001 Pavel Machek <pavel@suse.cz>
+ *
+ * I'd like to thank the following people for their work:
+ * 
+ * Pavel Machek <pavel@ucw.cz>:
+ * Modifications, defectiveness pointing, being with me at the very beginning,
+ * suspend to swap space, stop all tasks.
+ *
+ * Steve Doddi <dirk@loth.demon.co.uk>: 
+ * Support the possibility of hardware state restoring.
+ *
+ * Raph <grey.havens@earthling.net>:
+ * Support for preserving states of network devices and virtual console
+ * (including X and svgatextmode)
+ *
+ * Kurt Garloff <garloff@suse.de>:
+ * Straightened the critical function in order to prevent compilers from
+ * playing tricks with local variables.
+ *
+ * Andreas Mohr <a.mohr@mailto.de>
+ *
+ * Alex Badea <vampire@go.ro>:
+ * Fixed runaway init
+ *
+ * More state savers are welcome. Especially for the scsi layer...
+ *
+ * For TODOs,FIXMEs also look in Documentation/swsusp.txt
+ *
+ * BIG FAT WARNING *********************************************************
+ *
+ * If you have devices using DMA...
+ *				...say goodbye to your data.
+ *
+ * If you touch anything on disk between suspend and resume...
+ *				...kiss your data goodbye.
+ *
+ * If your disk driver does not support suspend...
+ *				...you'd better find out how to get along
+ *				   without your data.
+ */
+
+/*
+ * TODO:
+ *
+ * - we should launch a kernel_thread to process suspend request, cleaning up
+ * bdflush from this task. (check apm.c for something similar).
+ */
+
+/* FIXME: try to poison to memory */
+
+#include <linux/mm.h>
+#include <linux/swapctl.h>
+#include <linux/suspend.h>
+#include <linux/smp_lock.h>
+#include <linux/file.h>
+#include <linux/utsname.h>
+#include <linux/version.h>
+#include <linux/compile.h>
+#include <linux/delay.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/locks.h>
+#include <linux/vt_kern.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/kbd_kern.h>
+#include <linux/keyboard.h>
+#include <linux/spinlock.h>
+#include <linux/genhd.h>
+#include <linux/kernel.h>
+#include <linux/major.h>
+#include <linux/blk.h>
+#include <linux/swap.h>
+
+#include <asm/uaccess.h>
+#include <asm/mmu_context.h>
+#include <asm/pgtable.h>
+#include <asm/io.h>
+
+unsigned char software_suspend_enabled = 0;
+
+/* #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1) */
+/* With SUSPEND_CONSOLE defined, it suspend looks *really* cool, but
+   we probably do not take enough locks for switching consoles, etc,
+   so bad things might happen.
+*/
+#ifndef CONFIG_VT
+#undef SUSPEND_CONSOLE
+#endif
+
+#define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
+#define ADDRESS(x) ((unsigned long) phys_to_virt(((x) << PAGE_SHIFT)))
+
+extern void wakeup_bdflush(void);
+extern asmlinkage int sys_sched_yield(void);
+extern int C_A_D;
+
+/* References to section boundaries */
+extern char _text, _etext, _edata, __bss_start, _end;
+extern char __nosave_begin, __nosave_end;
+
+extern int console_loglevel;
+extern kdev_t suspend_device;
+extern int is_head_of_free_region(struct page *);
+
+/* Locks */
+spinlock_t suspend_pagedir_lock __nosavedata = SPIN_LOCK_UNLOCKED;
+
+/* Debug data */
+static int __nosavedata resume_dev = 0;
+
+/* Variables to be preserved over suspend */
+static int new_loglevel = 7;
+static int orig_loglevel = 0;
+static int orig_fgconsole;
+static int pagedir_order_check;
+static int nr_copy_pages_check;
+
+static int resume_status = 0;
+static char resume_file[256] = "";			/* For resume= kernel option */
+
+/* Local variables that should not be affected by save */
+static unsigned int nr_copy_pages __nosavedata = 0;
+
+/* Suspend pagedir is allocated before final copy, therefore it
+   must be freed after resume 
+
+   Warning: this is evil. There are actually two pagedirs at time of
+   resume. One is "pagedir_save", which is empty frame allocated at
+   time of suspend, that must be freed. Second is "pagedir_nosave", 
+   allocated at time of resume, that travells through memory not to
+   collide with anything.
+ */
+static suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
+static unsigned long pagedir_save;
+static int pagedir_order __nosavedata = 0;
+
+struct link {
+	char dummy[PAGE_SIZE - sizeof(swp_entry_t)];
+	swp_entry_t next;
+};
+
+union diskpage {
+	union swap_header swh;
+	struct link link;
+	struct suspend_header sh;
+};
+
+/*
+ * XXX: We try to keep some more pages free so that I/O operations succeed
+ * without paging. Might this be more?
+ *
+ * [If this is not enough, might it corrupt our data silently?]
+ */
+#define PAGES_FOR_IO	512
+
+static const char *name_suspend = "Suspend Machine: ";
+static const char *name_resume = "Resume Machine: ";
+
+/*
+ * Debug
+ */
+#define	DEBUG_DEFAULT	1
+#undef	DEBUG_PROCESS
+#undef	DEBUG_SLOW
+
+#ifdef DEBUG_DEFAULT
+#define PRINTD(func, f, a...)	\
+	do { \
+		printk("%s", func); \
+		printk(f, ## a); \
+	} while(0)
+#define PRINTS(f, a...)	PRINTD(name_suspend, f, ## a)
+#define PRINTR(f, a...)	PRINTD(name_resume, f, ## a)
+#define PRINTK(f, a...)	printk(f, ## a)
+#else
+#define PRINTD(func, f, a...)
+#define PRINTS(f, a...)
+#define PRINTR(f, a...)
+#define PRINTK(f, a...)
+#endif
+#ifdef DEBUG_SLOW
+#define MDELAY(a) mdelay(a)
+#else
+#define MDELAY(a)
+#endif
+
+/*
+ * Refrigerator and related stuff
+ */
+
+#define INTERESTING(p) \
+			/* We don't want to touch kernel_threads..*/ \
+			if (p->flags & PF_IOTHREAD) \
+				continue; \
+			if (p == current) \
+				continue; \
+			if (p->state == TASK_ZOMBIE) \
+				continue;
+
+/* Refrigerator is place where frozen processes are stored :-). */
+void refrigerator(void)
+{
+	/* You need correct to work with real-time processes.
+	   OTOH, this way one process may see (via /proc/) some other
+	   process in stopped state (and thereby discovered we were
+	   suspended. We probably do not care. 
+	 */
+	long save;
+	save = current->state;
+	current->state = TASK_STOPPED;
+//	PRINTK("%s entered refrigerator\n", current->comm);
+	printk(":");
+	current->flags &= ~PF_FREEZE;
+	current->flags |= PF_FROZEN;
+	while (current->flags & PF_FROZEN)
+		schedule();
+//	PRINTK("%s left refrigerator\n", current->comm);
+	printk(":");
+	current->state = save;
+}
+
+/* 0 = success, else # of processes that we failed to stop */
+static int freeze_processes(void)
+{
+	int todo, start_time;
+	struct task_struct *p;
+	
+	PRINTS( "Waiting for tasks to stop... " );
+	
+	start_time = jiffies;
+	do {
+		todo = 0;
+		read_lock(&tasklist_lock);
+		for_each_task(p) {
+			unsigned long flags;
+			INTERESTING(p);
+			if (p->flags & PF_FROZEN)
+				continue;
+
+			/* FIXME: smp problem here: we may not access other process' flags
+			   without locking */
+			p->flags |= PF_FREEZE;
+			spin_lock_irqsave(&p->sigmask_lock, flags);
+			signal_wake_up(p);
+			spin_unlock_irqrestore(&p->sigmask_lock, flags);
+			todo++;
+		}
+		read_unlock(&tasklist_lock);
+		sys_sched_yield();
+		schedule();
+		if (time_after(jiffies, start_time + TIMEOUT)) {
+			PRINTK( "\n" );
+			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
+			return todo;
+		}
+	} while(todo);
+	
+	PRINTK( " ok\n" );
+	return 0;
+}
+
+static void thaw_processes(void)
+{
+	struct task_struct *p;
+
+	PRINTR( "Restarting tasks..." );
+	read_lock(&tasklist_lock);
+	for_each_task(p) {
+		INTERESTING(p);
+		
+		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
+		else
+			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
+		wake_up_process(p);
+	}
+	read_unlock(&tasklist_lock);
+	PRINTK( " done\n" );
+	MDELAY(500);
+}
+
+/*
+ * Saving part...
+ */
+
+static __inline__ int fill_suspend_header(struct suspend_header *sh,
+						unsigned short *swapfile_used)
+{
+	memset((char *)sh, 0, sizeof(*sh));
+
+	sh->version_code = LINUX_VERSION_CODE;
+	sh->num_physpages = num_physpages;
+	strncpy(sh->machine, system_utsname.machine, 8);
+	strncpy(sh->version, system_utsname.version, 20);
+	sh->num_cpus = smp_num_cpus;
+	sh->page_size = PAGE_SIZE;
+	sh->suspend_pagedir = (unsigned long)pagedir_nosave;
+	if (pagedir_save != pagedir_nosave)
+		panic("Must not happen");
+	sh->num_pbes = nr_copy_pages;
+	/* TODO: needed? mounted fs' last mounted date comparison
+	 * [so they haven't been mounted since last suspend.
+	 * Maybe it isn't.] [we'd need to do this for _all_ fs-es]
+	 */
+	return 0;
+}
+
+/*
+ * This is our sync function. With this solution we probably won't sleep
+ * but that should not be a problem since tasks are stopped..
+ */
+
+static void do_suspend_sync(void)
+{
+	sync_dev(0);
+	while (1) {
+		run_task_queue(&tq_disk);
+		if (!TQ_ACTIVE(tq_disk))
+			break;
+		printk(KERN_ERR "Hm, tq_disk is not empty after run_task_queue\n");
+	}
+}
+
+static unsigned short swapfile_used[MAX_SWAPFILES];
+
+/* mode == 0 suspend
+   mode == 2 resume */
+static void mark_swapfiles(swp_entry_t prev, int mode, int root_swap)
+{
+	swp_entry_t entry;
+	union diskpage *cur = (union diskpage *)get_free_page(GFP_ATOMIC);
+	int i;
+
+	if (!cur)
+		panic("Out of memory in mark_swapfiles");
+	for(i=0; i < MAX_SWAPFILES; i++) {
+		if(!swapfile_used[i])
+			continue;
+
+		/* XXX: this is dirty hack to get first page of swap file */
+		entry = SWP_ENTRY(i, 0);
+		lock_page(virt_to_page((unsigned long)cur));
+		rw_swap_page_nolock(READ, entry, (char *) cur);
+
+		if (mode == 2) {
+			if (!memcmp("SUSP1R",cur->swh.magic.magic,6))
+				strcpy(cur->swh.magic.magic,"SWAP-SPACE");
+			else if (!memcmp("SUSP2R",cur->swh.magic.magic,6))
+				strcpy(cur->swh.magic.magic,"SWAPSPACE2");
+			else printk("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
+				    name_resume, cur->swh.magic.magic);
+		} else {
+			if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)))
+				strcpy(cur->swh.magic.magic,"SUSP1P....");
+			else if ((!memcmp("SWAPSPACE2",cur->swh.magic.magic,10)))
+				strcpy(cur->swh.magic.magic,"SUSP2P....");
+			else panic("\nSwapspace is not swapspace (%.10s)\n", cur->swh.magic.magic);
+			/* link.next lies in last 4 bytes of magic */
+		}
+
+		if (!mode && (i == root_swap)) {
+			cur->swh.magic.magic[5]='R'; /* marked as 'root' */
+			cur->link.next = prev;
+		}
+#if 0
+		{
+			int j;
+			printk("I=%d ", i);
+			for (j=0; j<10; j++)
+				printk("%c", cur->swh.magic.magic[j]);
+		}
+#endif
+		lock_page(virt_to_page((unsigned long)cur));
+		rw_swap_page_nolock(WRITE, entry, (char *)cur);
+	}
+	free_page((unsigned long)cur);
+}
+
+#if 0
+swp_entry_t my_get_swap_page(void)
+{
+	swp_entry_t res;
+	/* What locks does get_swap_page need? */
+	res = get_swap_page();
+	return res;
+}
+#endif
+
+static int write_suspend_image(void)
+{
+	int i;
+	swp_entry_t entry, prev = { 0 };
+	int nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
+	union diskpage *cur,  *buffer = (union diskpage *)get_free_page(GFP_ATOMIC);
+	unsigned long address;
+
+	memset((char *)swapfile_used, 0, sizeof(swapfile_used));
+	swapfile_used[0] = 1;	/* FIXME */
+
+	PRINTS( "Writing data to swap (%d pages): ", nr_copy_pages );
+	for (i=0; i<nr_copy_pages; i++) {
+		if (!(i%100))
+			PRINTK( "." );
+		if (!(entry = get_swap_page()).val)
+			panic("\nNot enough swapspace when writing data" );
+		
+//		swapfile_used[SWP_TYPE(entry)] = 1;
+		address = (pagedir_nosave+i)->address;
+		lock_page(virt_to_page(address));
+		{
+			long dummy1, dummy2;
+			get_swaphandle_info(entry, &dummy1, &suspend_device, &dummy2);
+		}
+		rw_swap_page_nolock(WRITE, entry, (char *) address);
+		(pagedir_nosave+i)->swap_address = entry;
+	}
+	PRINTK(" done\n");
+	PRINTS( "Writing pagedir (%d pages): ", nr_pgdir_pages);
+	for (i=0; i<nr_pgdir_pages; i++) {
+		cur = (union diskpage *)((char *) pagedir_nosave)+i;
+		if ((char *) cur != (((char *) pagedir_nosave) + i*PAGE_SIZE))
+			panic("Something is of wrong size");
+		PRINTK( "." );
+		if (!(entry = get_swap_page()).val) {
+			printk(KERN_CRIT "Not enough swapspace when writing pgdir\n" );
+			panic("Don't know how to recover");
+			free_page((unsigned long) buffer);
+			return -ENOSPC;
+		}
+//		swapfile_used[SWP_TYPE(entry)] = 1;
+		if (sizeof(swp_entry_t) != sizeof(long))
+			panic("I need swp_entry_t to be sizeof long, otherwise next assignment could damage pagedir");
+		if (PAGE_SIZE % sizeof(struct pbe))
+			panic("I need PAGE_SIZE to be integer multiple of struct pbe, otherwise next assignment could damage pagedir");
+		cur->link.next = prev;				
+		lock_page(virt_to_page((unsigned long)cur));
+		rw_swap_page_nolock(WRITE, entry, (char *) cur);
+		prev = entry;
+	}
+	PRINTK(", header");
+	if (sizeof(struct suspend_header) > PAGE_SIZE-sizeof(swp_entry_t))
+		panic("sizeof(struct suspend_header) too big: %d",
+				sizeof(struct suspend_header));
+	if (sizeof(union diskpage) != PAGE_SIZE)
+		panic("union diskpage has bad size");
+	if (!(entry = get_swap_page()).val)
+		panic( "\nNot enough swapspace when writing header" );
+//	swapfile_used[SWP_TYPE(entry)] = 1;
+
+	cur = (void *) buffer;
+	if(fill_suspend_header(&cur->sh, swapfile_used))
+		panic("\nOut of memory while writing header");
+		
+	cur->link.next = prev;
+
+	lock_page(virt_to_page((unsigned long)cur));
+	rw_swap_page_nolock(WRITE, entry, (char *) cur);
+	prev = entry;
+	/*
+	 * If we have more than one swapfile the one that contains
+	 * the very first block for resuming is marked as SUSP[12]R
+	 * while the other ones are marked as SUSP[12]P. We test it in
+	 * sys_swapon().
+	 */
+	PRINTK( ", signature" );
+	if (SWP_TYPE(entry) != 0)
+		panic("Need just one swapfile");
+	mark_swapfiles(prev, 0, SWP_TYPE(entry));
+	PRINTK( ", done\n" );
+
+	MDELAY(1000);
+	free_page((unsigned long) buffer);
+	return 0;
+}
+
+/* if pagedir_p != NULL it also copies the counted pages */
+static int count_and_copy_data_pages(struct pbe *pagedir_p)
+{
+	int chunk_size;
+	int nr_copy_pages = 0;
+	int loop;
+	
+	if (max_mapnr != num_physpages)
+		panic("mapnr is not expected");
+	for(loop = 0; loop < max_mapnr; loop++) {
+		if(PageHighMem(mem_map+loop))
+			panic("No highmem for me, sorry.");
+		if(!PageReserved(mem_map+loop)) {
+			if(PageNosave(mem_map+loop))
+				continue;
+
+			if((chunk_size=is_head_of_free_region(mem_map+loop))!=0) {
+				loop += chunk_size - 1;
+				continue;
+			}
+		} else if(PageReserved(mem_map+loop)) {
+			if(PageNosave(mem_map+loop))
+				panic("What?");
+
+			/*
+			 * Just copy whole code segment. Hopefully it is not that big.
+			 */
+			if (ADDRESS(loop) >= (unsigned long)
+				&__nosave_begin && ADDRESS(loop) < 
+				(unsigned long)&__nosave_end) {
+				printk("[nosave]");
+				continue;
+			}
+			/* Hmm, perhaps copying all reserved pages is not too healthy as they may contain 
+			   critical bios data? */
+		} else panic("No third thing should be possible");
+
+		nr_copy_pages++;
+		if(pagedir_p) {
+			pagedir_p->orig_address = ADDRESS(loop);
+			copy_page(pagedir_p->address, pagedir_p->orig_address);
+			pagedir_p++;
+		}
+	}
+	return nr_copy_pages;
+}
+
+static void free_suspend_pagedir(unsigned long this_pagedir)
+{
+	struct page *page = mem_map;
+	int i;
+	unsigned long this_pagedir_end = this_pagedir +
+		(PAGE_SIZE << pagedir_order);
+
+	for(i=0; i < num_physpages; i++, page++) {
+		if(!PageTestandClearNosave(page))
+			continue;
+
+		if(ADDRESS(i) >= this_pagedir && ADDRESS(i) < this_pagedir_end)
+			continue; /* old pagedir gets freed in one */
+		
+		free_page(ADDRESS(i));
+	}
+	free_pages(this_pagedir, pagedir_order);
+}
+
+static suspend_pagedir_t *create_suspend_pagedir(int nr_copy_pages)
+{
+	int i;
+	suspend_pagedir_t *pagedir;
+	struct pbe *p;
+	struct page *page;
+
+	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
+
+	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, pagedir_order);
+	if(!pagedir)
+		return NULL;
+
+	page = virt_to_page(pagedir);
+	for(i=0; i < 1<<pagedir_order; i++)
+		PageSetNosave(page++);
+		
+	while(nr_copy_pages--) {
+		p->address = get_free_page(GFP_ATOMIC);
+		if(!p->address) {
+			panic("oom");
+			free_suspend_pagedir((unsigned long) pagedir);
+			return NULL;
+		}
+		PageSetNosave(virt_to_page(p->address));
+		p->orig_address = 0;
+		p++;
+	}
+	return pagedir;
+}
+
+static int prepare_suspend_console(void)
+{
+	orig_loglevel = console_loglevel;
+	console_loglevel = new_loglevel;
+
+#ifdef CONFIG_VT
+	orig_fgconsole = fg_console;
+#ifdef SUSPEND_CONSOLE
+	if(vc_allocate(SUSPEND_CONSOLE))
+	  /* we can't have a free VC for now. Too bad,
+	   * we don't want to mess the screen for now. */
+		return 1;
+
+	set_console (SUSPEND_CONSOLE);
+	if(vt_waitactive(SUSPEND_CONSOLE)) {
+		PRINTS("Bummer. Can't switch VCs.");
+		return 1;
+	}
+#endif
+#endif
+	return 0;
+}
+
+static void restore_console(void)
+{
+	console_loglevel = orig_loglevel;
+#ifdef SUSPEND_CONSOLE
+	set_console (orig_fgconsole);
+#endif
+	return;
+}
+
+static int prepare_suspend_processes(void)
+{
+	PRINTS( "Stopping processes\n" );
+	MDELAY(1000);
+	if (freeze_processes()) {
+		PRINTS( "Not all processes stopped!\n" );
+//		panic("Some processes survived?\n");
+		thaw_processes();
+		return 1;
+	}
+	do_suspend_sync();
+	return 0;
+}
+
+/*
+ *	Free as much memory as possible
+ */
+
+static void **eaten_memory;
+
+static void eat_memory(void)
+{
+	int i = 0;
+	void **c= eaten_memory, *m;
+
+	printk("Eating pages ");
+	while ((m = (void *) get_free_page(GFP_HIGHUSER))) {
+		memset(m, 0, PAGE_SIZE);
+		eaten_memory = m;
+		if (!(i%100))
+			printk( ".(%d)", i ); 
+		*eaten_memory = c;
+		c = eaten_memory;
+		i++; 
+#if 1
+	/* 40000 == 160MB */
+	/* 10000 for 64MB */
+	/* 2500 for  16MB */
+		if (i > 40000)
+			break;
+#endif
+	}
+	printk("(%dK)\n", i*4);
+}
+
+static void free_memory(void)
+{
+	int i = 0;
+	void **c = eaten_memory, *f;
+	
+	printk( "Freeing pages " );
+	while (c) {
+		if (!(i%5000))
+		printk( "." ); 
+		f = *c;
+		c = *c;
+		if (f) { free_page( (long) f ); i++; }
+	}
+	printk( "(%dK)\n", i*4 );
+	eaten_memory = NULL;
+}
+
+/*
+ * Try to free as much memory as possible, but do not OOM-kill anyone
+ *
+ * Notice: all userland should be stopped at this point, or livelock is possible.
+ */
+static void free_some_memory(void)
+{
+#if 1
+	PRINTS("Freeing memory: ");
+	while (try_to_free_pages(&contig_page_data.node_zones[ZONE_HIGHMEM], GFP_KSWAPD, 0))
+		printk(".");
+	printk("\n");
+#else
+	printk("Using memeat\n");
+	eat_memory();
+	free_memory();
+#endif
+}
+
+static int suspend_save_image(void)
+{
+	struct sysinfo i;
+	unsigned int nr_needed_pages = 0;
+
+	pagedir_nosave = NULL;
+	PRINTS( "/critical section: Counting pages to copy" );
+	nr_copy_pages = count_and_copy_data_pages(NULL);
+	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
+	
+	PRINTK(" (pages needed: %d+%d=%d free: %d)\n",nr_copy_pages,PAGES_FOR_IO,nr_needed_pages,nr_free_pages());
+	if(nr_free_pages() < nr_needed_pages) {
+		printk(KERN_CRIT "%sCouldn't get enough free pages, on %d pages short\n",
+		       name_suspend, nr_needed_pages-nr_free_pages());
+		panic("Not enough free pages");
+		spin_unlock_irq(&suspend_pagedir_lock);
+		return 1;
+	}
+	si_swapinfo(&i);
+	if (i.freeswap < nr_needed_pages)  {
+		printk(KERN_CRIT "%sThere's not enough swap space available, on %ld pages short\n",
+		       name_suspend, nr_needed_pages-i.freeswap);
+		panic("Not enough swap space");
+		spin_unlock_irq(&suspend_pagedir_lock);
+		return 1;
+	}
+
+	PRINTK( "Alloc pagedir\n" ); 
+	pagedir_save = pagedir_nosave = create_suspend_pagedir(nr_copy_pages);
+	if(!pagedir_nosave) {
+		/* Shouldn't happen */
+		printk(KERN_CRIT "%sCouldn't allocate enough pages\n",name_suspend);
+		panic("Really should not happen");
+		spin_unlock_irq(&suspend_pagedir_lock);
+		return 1;
+	}
+	nr_copy_pages_check = nr_copy_pages;
+	pagedir_order_check = pagedir_order;
+
+	if (nr_copy_pages != count_and_copy_data_pages(pagedir_nosave))	/* copy */
+		panic("Count and copy returned another count than when counting?\n");
+
+	/*
+	 * End of critical section. From now on, we can write to memory,
+	 * but we should not touch disk. This specially means we must _not_
+	 * touch swap space! Except we must write out our image of course.
+	 *
+	 * Following line enforces not writing to disk until we choose.
+	 */
+	suspend_device = -1;					/* We do not want any writes, thanx */
+#ifdef CONFIG_BLK_DEV_IDE
+	ide_disk_unsuspend();
+#endif
+	spin_unlock_irq(&suspend_pagedir_lock);
+	PRINTS( "critical section/: done (%d pages copied)\n", nr_copy_pages );
+
+	write_suspend_image();
+
+	/* Image is saved, call sync & restart machine */
+	PRINTS( "Syncing disks\n" );
+	/* It is important _NOT_ to umount filesystems at this point. We want
+	 * them synced (in case something goes wrong) but we DO not want to mark
+	 * filesystem clean: it is not. (And it does not matter, if we resume
+	 * correctly, we'll mark system clean, anyway.)
+	 */
+#if 0
+	do_suspend_sync();
+/* Is this really so bright idea? We might corrupt FS here! */
+#endif
+	return 0;
+}
+
+void suspend_power_down(void)
+{
+	C_A_D = 0;
+	printk(KERN_EMERG "%sTrying to power down.\n", name_suspend);
+#ifdef CONFIG_VT
+	printk(KERN_EMERG "shift_state: %04x\n", shift_state);
+	mdelay(1000);
+	if ((shift_state & (1 << KG_CTRL)))
+		machine_power_off();
+	else
+#endif
+		machine_restart(NULL);
+
+
+	printk(KERN_EMERG "%sProbably not capable for powerdown. System halted.\n", name_suspend);
+	machine_halt();
+	while (1);
+	/* NOTREACHED */
+}
+
+static void restore_task(void)
+{
+	MDELAY(1000);
+#if 0
+	/* Should not be neccessary -- we saved whole CPU context */
+	PRINTR( "Activating task\n" );
+	activate_mm(current->mm,current->mm);
+	activate_task(current);
+#endif
+}
+
+/* forward decl */
+static void do_software_suspend(void);
+
+/*
+ * Magic happens here
+ */
+
+static void do_magic_resume_1(void)
+{
+	barrier();
+	mb();
+	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
+
+	printk( "Waiting for DMAs to settle down...\n");
+	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
+			   Do it with disabled interrupts for best effect. That way, if some
+			   driver scheduled DMA, we have good chance for DMA to finish ;-). */
+}
+
+static void do_magic_resume_2(void)
+{
+	if (nr_copy_pages_check != nr_copy_pages)
+		panic("nr_copy_pages changed?!");
+	if (pagedir_order_check != pagedir_order)
+		panic("pagedir_order changed?!");
+
+	PRINTR( "Freeing prev allocated pagedir\n" );
+	free_suspend_pagedir(pagedir_save);
+	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
+#ifdef CONFIG_BLK_DEV_HD
+	do_reset_hd();			/* Kill all controller state */
+#endif
+#ifdef CONFIG_BLK_DEV_IDE
+	ide_disk_resume();
+#endif
+	spin_unlock_irq(&suspend_pagedir_lock);
+
+	PRINTK( "Fixing swap signatures... " );
+	swapfile_used[0] = 1;		/* FIXME: Of course, swapfile_used can not survive suspend: It is initialized *after*
+					   copy :-( */
+	/* FIXME: this means that you have to do _just one_ swapon */
+	mark_swapfiles(((swp_entry_t) {0}), 2, 0);
+	PRINTK( "ok\n" );
+
+#if 0
+	restore_task ();	/* Should not be neccessary! */
+#endif
+#ifdef SUSPEND_CONSOLE
+	update_screen(fg_console);	/* Hmm, is this the problem? */
+#endif
+	suspend_tq.routine = (void *)do_software_suspend;
+}
+
+static void do_magic_suspend_1(void)
+{
+	mb();
+	barrier();
+	spin_lock_irq(&suspend_pagedir_lock);
+}
+
+static void do_magic_suspend_2(void)
+{
+	if (!suspend_save_image()) {
+#if 1
+		suspend_power_down ();	/* FIXME: if suspend_power_down is commented out, console is lost after few suspends ?! */
+#endif
+	}
+
+	suspend_device = 0;
+	printk(KERN_WARNING "%sSuspend failed, trying to continue recover\n", name_suspend);
+	MDELAY(1000); /* So user can wait and report us messages if armageddon comes :-) */
+
+	panic("Suspend failed");
+	barrier();
+	mb();
+	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
+	mdelay(1000);
+
+	free_pages((unsigned long) pagedir_nosave, pagedir_order);
+	spin_unlock_irq(&suspend_pagedir_lock);
+	swapfile_used[0] = 1;		/* FIXME: Of course, swapfile_used can not survive suspend: It is initialized *after*
+					   copy :-( */
+	/* FIXME: this means that you have to do _just one_ swapon */
+	mark_swapfiles(((swp_entry_t) {0}), 2, 0);
+
+#ifdef SUSPEND_CONSOLE
+	update_screen(fg_console);	/* Hmm, is this the problem? */
+#endif
+	suspend_tq.routine = (void *)do_software_suspend;
+
+}
+
+#define SUSPEND_C
+#include <asm/suspend.h>
+
+/*
+ * This function is triggered using process bdflush. We try to swap out as
+ * much as we can then make a copy of the occupied pages in memory so we can
+ * make a copy of kernel state atomically, the I/O needed by saving won't
+ * bother us anymore.
+ */
+static void do_software_suspend(void)
+{
+	arch_prepare_suspend();
+	if (!prepare_suspend_console()) {
+		if (!prepare_suspend_processes()) {
+			free_some_memory();
+
+			/* No need to invalidate any vfsmnt list -- they will be valid after resume, anyway.
+			 *
+			 * We sync here -- so you have consistent filesystem state when things go wrong.
+			 * -- so that noone writes to disk after we do atomic copy of data.
+			 */
+			PRINTS( "Syncing disks before copy\n" );
+			do_suspend_sync();
+#if 0
+			schedule_timeout(1*HZ);	/* Is this needed to get data properly to disk? */
+#endif
+#ifdef CONFIG_BLK_DEV_IDE
+			ide_disk_suspend();
+#else
+#error Are you sure your disk driver supports suspend?
+#endif
+			do_magic(0);			/* This function returns after machine woken up from resume */
+			PRINTR("Restarting processes...\n");
+			thaw_processes();
+		}
+	}
+	software_suspend_enabled = 1;
+	PRINTR( "Done resume from %x\n", resume_dev );
+	MDELAY(1000);
+	restore_console ();
+}
+
+struct tq_struct suspend_tq =
+	{ routine: (void *)(void *)do_software_suspend, 
+	  data: 0 };
+
+/*
+ * This is the trigger function, we must queue ourself since we
+ * can be called from interrupt && bdflush context is needed
+ */
+void software_suspend(void)
+{
+	if(!software_suspend_enabled)
+		return;
+
+	software_suspend_enabled = 0;
+	queue_task(&suspend_tq, &tq_bdflush);
+	wakeup_bdflush();
+}
+
+/* More restore stuff */
+
+/* FIXME: Why not memcpy(to, from, 1<<pagedir_order*PAGE_SIZE)? */
+static void copy_pagedir(suspend_pagedir_t *to, suspend_pagedir_t *from)
+{
+	int i;
+	char *topointer=(char *)to, *frompointer=(char *)from;
+
+	for(i=0; i < 1 << pagedir_order; i++) {
+		copy_page(topointer, frompointer);
+		topointer += PAGE_SIZE;
+		frompointer += PAGE_SIZE;
+	}
+}
+
+#define does_collide(addr)	\
+		does_collide_order(pagedir_nosave, addr, 0)
+
+/*
+ * Returns true if given address/order collides with any orig_address 
+ */
+static int does_collide_order(suspend_pagedir_t *pagedir, unsigned long addr,
+		int order)
+{
+	int i;
+	unsigned long addre = addr + (PAGE_SIZE<<order);
+	
+	for(i=0; i < nr_copy_pages; i++)
+		if((pagedir+i)->orig_address >= addr &&
+			(pagedir+i)->orig_address < addre)
+			return 1;
+
+	return 0;
+}
+
+/*
+ * We check here that pagedir & pages it points to won't collide with pages
+ * where we're going to restore from the loaded pages later
+ */
+
+static int check_pagedir(void)
+{
+	int i;
+
+	for(i=0; i < nr_copy_pages; i++) {
+		unsigned long addr;
+
+		do {
+			addr = get_free_page(GFP_ATOMIC);
+			if(!addr)
+				return -ENOMEM;
+		} while (does_collide(addr));
+
+		(pagedir_nosave+i)->address = addr;
+	}
+	return 0;
+}
+
+static int relocate_pagedir(void)
+{
+	/* This is deep magic
+	   We have to avoid recursion (not to overflow kernel stack), and that's why
+	   code looks pretty cryptic
+	*/
+	suspend_pagedir_t *new_pagedir, *old_pagedir = pagedir_nosave;
+	void **eaten_memory = NULL;
+	void **c = eaten_memory, *m, *f;
+
+
+	if(!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
+		printk("not neccessary\n");
+		return 0;
+	}
+
+	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order))) {
+		memset(m, 0, PAGE_SIZE);
+		if (!does_collide_order(old_pagedir, (unsigned long)m, pagedir_order))
+			break;
+		eaten_memory = m;
+		printk( "." ); 
+		*eaten_memory = c;
+		c = eaten_memory;
+	}
+
+	if (!m)
+		return -ENOMEM;
+
+	pagedir_nosave = new_pagedir = m;
+	copy_pagedir(new_pagedir, old_pagedir);
+
+	c = eaten_memory;
+	while(c) {
+		printk(":");
+		f = *c;
+		c = *c;
+		if (f)
+			free_pages((unsigned long)f, pagedir_order);
+	}
+	printk("okay\n");
+	return 0;
+}
+
+/*
+ * Sanity check if this image makes sense with this kernel/swap context
+ * I really don't think that it's foolproof but more than nothing..
+ */
+
+static int sanity_check_failed(char *reason)
+{
+	printk(KERN_ERR "%s%s\n",name_resume,reason);
+	return -EPERM;
+}
+
+static int sanity_check(struct suspend_header *sh)
+{
+	if(sh->version_code != LINUX_VERSION_CODE)
+		return sanity_check_failed("Incorrect kernel version");
+	if(sh->num_physpages != num_physpages)
+		return sanity_check_failed("Incorrect memory size");
+	if(strncmp(sh->machine, system_utsname.machine, 8))
+		return sanity_check_failed("Incorrect machine type");
+	if(strncmp(sh->version, system_utsname.version, 20))
+		return sanity_check_failed("Incorrect version");
+	if(sh->num_cpus != smp_num_cpus)
+		return sanity_check_failed("Incorrect number of cpus");
+	if(sh->page_size != PAGE_SIZE)
+		return sanity_check_failed("Incorrect PAGE_SIZE");
+	return 0;
+}
+
+int bdev_read(kdev_t dev, long pos, void *buf, long count)
+{
+	struct buffer_head *bh;
+	if ((pos%PAGE_SIZE) || (count != PAGE_SIZE)) panic("Sorry, dave, I can't let you do that!\n");
+	bh = bread(dev, pos/PAGE_SIZE, PAGE_SIZE);
+	if (!bh || (!bh->b_data)) {
+		return -1;
+	}
+	memcpy(buf, bh->b_data, PAGE_SIZE);
+	brelse(bh);			/* FIXME: maybe bforget should be here */
+	return 0;
+} 
+
+/* Checked up-to HERE */
+
+int resume_try_to_read(const char * specialfile)
+{
+	union diskpage *cur;
+	swp_entry_t next;
+	int i, nr_pgdir_pages, error;
+	kdev_t dev = name_to_kdev_t(specialfile);
+	int blksize = 0;
+
+	cur = (void *) get_free_page(GFP_ATOMIC);
+	if (!cur) {
+		printk( "%sNot enough memory?\n", name_resume );
+		error = -ENOMEM;
+		goto resume_read_error;
+	}
+
+	printk("Resuming from device %x\n", dev);
+	resume_dev = dev;
+
+	if (!blksize_size[MAJOR(dev)]) {
+		printk("Blocksize not known?\n");
+	} else blksize = blksize_size[MAJOR(dev)][MINOR(dev)];
+	if (!blksize) {
+		printk("Blocksize not set?\n");
+		blksize = 0;
+	}
+	set_blocksize(dev, PAGE_SIZE);
+
+#define READTO(pos, ptr) \
+	if (bdev_read(dev, pos, ptr, PAGE_SIZE)) { error = -EIO; goto resume_read_error; }
+#define PREPARENEXT \
+	{	next = cur->link.next; \
+		next.val = SWP_OFFSET(next) * PAGE_SIZE; \
+        }
+
+	error = -EIO;
+	READTO(0, cur);
+
+	if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)) ||
+	    (!memcmp("SWAPSPACE2",cur->swh.magic.magic,10))) {
+		printk(KERN_ERR "%sThis is normal swap space\n", name_resume );
+		error = -EINVAL;
+		goto resume_read_error;
+	}
+
+	PREPARENEXT; /* We have to read next position before we overwrite it */
+
+	if (!memcmp("SUSP1R",cur->swh.magic.magic,6))
+		strcpy(cur->swh.magic.magic,"SWAP-SPACE");
+	else if (!memcmp("SUSP2R",cur->swh.magic.magic,6))
+		strcpy(cur->swh.magic.magic,"SWAPSPACE2");
+	else {
+		panic("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
+			name_resume, cur->swh.magic.magic);
+	}
+	printk( "%sSignature found, resuming\n", name_resume );
+	MDELAY(1000);
+
+	READTO(next.val, cur);
+
+	error = -EPERM;
+	if (sanity_check(&cur->sh))
+		goto resume_read_error;
+
+	/* Probably this is the same machine */	
+
+	PREPARENEXT;
+
+	pagedir_save = cur->sh.suspend_pagedir;
+	nr_copy_pages = cur->sh.num_pbes;
+	nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
+	pagedir_order = get_bitmask_order(nr_pgdir_pages);
+
+	error = -ENOMEM;
+	pagedir_nosave = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, pagedir_order);
+	if(!pagedir_nosave)
+		goto resume_read_error;
+
+	PRINTR( "%sReading pagedir, ", name_resume );
+
+	/* We get pages in reverse order of saving! */
+	error=-EIO;
+	for (i=nr_pgdir_pages-1; i>=0; i--) {
+		if (!next.val)
+			panic( "Preliminary end of suspended data?" );
+		cur = (union diskpage *)((char *) pagedir_nosave)+i;
+		READTO(next.val, cur);
+		PREPARENEXT;
+	}
+	if (next.val)
+		panic( "Suspended data too long?" );
+
+	printk("Relocating pagedir");
+	if((error=relocate_pagedir())!=0)
+		goto resume_read_error;
+	if((error=check_pagedir())!=0)
+		goto resume_read_error;
+
+	PRINTK( "image data (%d pages): ", nr_copy_pages );
+	error = -EIO;
+	for(i=0; i < nr_copy_pages; i++) {
+		swp_entry_t swap_address = (pagedir_nosave+i)->swap_address;
+		if (!(i%100))
+			PRINTK( "." );
+		next.val = SWP_OFFSET (swap_address) * PAGE_SIZE;
+		/* You do not need to check for overlaps...
+		   ... check_pagedir already did this work */
+		READTO(next.val, (char *)((pagedir_nosave+i)->address));
+	}
+	PRINTK( " done\n" );
+	error = 0;
+
+resume_read_error:
+	switch (error) {
+		case 0:
+			PRINTR("Reading resume file was successful\n");
+			break;
+		case -EINVAL:
+			break;
+		case -EIO:
+			printk( "%sI/O error\n", name_resume);
+			panic("Wanted to resume but it did not work\n");
+			break;
+		case -ENOENT:
+			printk( "%s%s: No such file or directory\n", name_resume, specialfile);
+			panic("Wanted to resume but it did not work\n");
+			break;
+		default:
+			printk( "%sError %d resuming\n", name_resume, error );
+			panic("Wanted to resume but it did not work\n");
+	}
+	set_blocksize(dev, blksize);	/* Needed! In case its is normal swap space */
+	MDELAY(1000);
+	return error;
+}
+
+/*
+ * Called from init kernel_thread.
+ * We check if we have an image and if so we try to resume
+ */
+
+void software_resume(void)
+{
+#ifdef CONFIG_SMP
+	printk(KERN_WARNING "Software Suspend has a malfunctioning SMP support. Disabled :(\n");
+#else
+	/* We enable the possibility of machine suspend */
+	software_suspend_enabled = 1;
+#endif
+	if(!resume_status)
+		return;
+
+	printk( "%s", name_resume );
+	if(resume_status == NORESUME) {
+		/* FIXME: Signature should be restored here */
+		printk( "disabled\n" );
+		return;
+	}
+	MDELAY(1000);
+
+	orig_loglevel = console_loglevel;
+	console_loglevel = new_loglevel;
+
+	if(!resume_file[0] && resume_status == RESUME_SPECIFIED) {
+		printk( "nowhere to resume from\n" );
+		return;
+	}
+
+	printk( "resuming from %s\n", resume_file);
+	if(resume_try_to_read(resume_file))
+		goto read_failure;
+
+	do_magic(1);
+	panic("This never returns");
+
+read_failure:
+	console_loglevel = orig_loglevel;
+	return;
+}
+
+
+int resume_setup(char *str)
+{
+	if(resume_status)
+		return 1;
+
+	strncpy( resume_file, str, 255 );
+	resume_status = RESUME_SPECIFIED;
+
+	return 1;
+}
+
+static int __init software_noresume(char *str)
+{
+	if(!resume_status)
+		resume_status = NORESUME;
+	
+	return 1;
+}
+
+__setup("noresume", software_noresume);
+__setup("resume=", resume_setup);
+
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean.2.4/kernel/sys.c linux-swsusp.24/kernel/sys.c
--- clean.2.4/kernel/sys.c	Tue Sep 18 23:10:43 2001
+++ linux-swsusp.24/kernel/sys.c	Wed Jan 23 11:54:21 2002
@@ -4,6 +4,7 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/utsname.h>
@@ -322,6 +323,16 @@
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
 		machine_restart(buffer);
 		break;
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	case LINUX_REBOOT_CMD_SW_SUSPEND:
+		if(!software_suspend_enabled)
+			return -EAGAIN;
+		
+		software_suspend();
+		do_exit(0);
+		break;
+#endif
 
 	default:
 		unlock_kernel();
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean.2.4/mm/page_alloc.c linux-swsusp.24/mm/page_alloc.c
--- clean.2.4/mm/page_alloc.c	Wed Dec  5 23:46:07 2001
+++ linux-swsusp.24/mm/page_alloc.c	Wed Jan 23 11:54:21 2002
@@ -18,6 +18,7 @@
 #include <linux/bootmem.h>
 #include <linux/slab.h>
 #include <linux/compiler.h>
+#include <linux/suspend.h>
 
 int nr_swap_pages;
 int nr_active_pages;
@@ -216,6 +217,46 @@
 
 	return NULL;
 }
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+int is_head_of_free_region(struct page *p)
+{
+	pg_data_t *pgdat = pgdat_list;
+	unsigned type;
+	unsigned long flags;
+
+	for (type=0;type < MAX_NR_ZONES; type++) {
+		zone_t *zone = pgdat->node_zones + type;
+		int order = MAX_ORDER - 1;
+		free_area_t *area;
+		struct list_head *head, *curr;
+		spin_lock_irqsave(&zone->lock, flags);	/* Should not matter as we need quiescent system for suspend anyway, but... */
+
+		do {
+			area = zone->free_area + order;
+			head = &area->free_list;
+			curr = head;
+
+			for(;;) {
+				if(!curr) {
+//					printk("FIXME: this should not happen but it does!!!");
+					break;
+				}
+				if(p != memlist_entry(curr, struct page, list)) {
+					curr = memlist_next(curr);
+					if (curr == head)
+						break;
+					continue;
+				}
+				return 1 << order;
+			}
+		} while(order--);
+		spin_unlock_irqrestore(&zone->lock, flags);
+
+	}
+	return 0;
+}
+#endif /* CONFIG_SOFTWARE_SUSPEND */
 
 #ifndef CONFIG_DISCONTIGMEM
 struct page *_alloc_pages(unsigned int gfp_mask, unsigned int order)
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean.2.4/mm/page_io.c linux-swsusp.24/mm/page_io.c
--- clean.2.4/mm/page_io.c	Wed Dec  5 23:46:07 2001
+++ linux-swsusp.24/mm/page_io.c	Wed Jan 23 11:54:21 2002
@@ -87,11 +87,15 @@
  *  - it's marked as being swap-cache
  *  - it's associated with the swap inode
  */
+extern long suspend_device;
 void rw_swap_page(int rw, struct page *page)
 {
 	swp_entry_t entry;
 
 	entry.val = page->index;
+
+	if (suspend_device)
+		panic("I refuse to corrupt memory/swap.");
 
 	if (!PageLocked(page))
 		PAGE_BUG(page);
diff -ur -x .dep* -x .hdep* -x *.[oas] -x *~ -x #* -x *CVS* -x *.orig -x *.rej -x *.old -x .menu* -x asm -x local.h -x System.map -x autoconf.h -x compile.h -x version.h -x .version -x defkeymap.c -x uni_hash.tbl -x zImage -x vmlinux -x vmlinuz -x TAGS -x bootsect -x *RCS* -x conmakehash -x map -x build -x build -x configure -x *target* -x *.flags -x *.bak clean.2.4/mm/vmscan.c linux-swsusp.24/mm/vmscan.c
--- clean.2.4/mm/vmscan.c	Tue Dec 25 22:39:30 2001
+++ linux-swsusp.24/mm/vmscan.c	Wed Jan 23 11:54:21 2002
@@ -731,8 +731,12 @@
 		add_wait_queue(&kswapd_wait, &wait);
 
 		mb();
-		if (kswapd_can_sleep())
+		if (kswapd_can_sleep()) {
+			if (current->flags & PF_FREEZE)
+				refrigerator();
 			schedule();
+		}
+		
 
 		__set_current_state(TASK_RUNNING);
 		remove_wait_queue(&kswapd_wait, &wait);
Only in linux-swsusp.24/scripts: mkdep
Only in linux-swsusp.24/scripts: split-include

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
