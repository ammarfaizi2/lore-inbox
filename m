Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272227AbTHDUPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272228AbTHDUPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:15:45 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:51946 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272227AbTHDUPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:15:25 -0400
Date: Mon, 4 Aug 2003 22:14:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Cc: Patrick Mochel <mochel@osdl.org>
Subject: swsusp updates
Message-ID: <20030804201432.GA467@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here are swsusp updates, retransmitted. Please apply this time.

This fixes suspend with ^Z-ed processes (could corrupt data),
makes CONFIG_SOFTWARE_SUSPEND independend from CONFIG_ACPI_SLEEP,
fixes console after S3 and fixes too loud printks.

							Pavel

Index: linux/drivers/acpi/sleep/main.c
===================================================================
--- linux.orig/drivers/acpi/sleep/main.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/acpi/sleep/main.c	2003-07-22 12:53:27.000000000 +0200
@@ -69,10 +81,6 @@
  * First, we call to the device driver layer to save device state.
  * Once we have that, we save whatevery processor and kernel state we
  * need to memory.
- * If we're entering S4, we then write the memory image to disk.
- *
- * Only then is it safe for us to power down devices, since we may need
- * the disks and upstream buses to write to.
  */
 acpi_status
 acpi_system_save_state(
@@ -197,7 +205,7 @@
 		break;
 	}
 	local_irq_restore(flags);
-	printk(KERN_CRIT "Back to C!\n");
+	printk(KERN_DEBUG "Back to C!\n");
 
 	return status;
 }
@@ -226,6 +234,7 @@
 	if (state == ACPI_STATE_S4 && !acpi_gbl_FACS->S4bios_f)
 		return AE_ERROR;
 
+	prepare_suspend_console();
 	/*
 	 * TBD: S1 can be done without device_suspend.  Make a CONFIG_XX
 	 * to handle however when S1 failed without device_suspend.
@@ -270,6 +279,7 @@
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 	thaw_processes();
+	restore_console();
 
 	return status;
 }
Index: linux/arch/i386/kernel/Makefile
===================================================================
--- linux.orig/arch/i386/kernel/Makefile	2003-07-22 13:39:42.000000000 +0200
+++ linux/arch/i386/kernel/Makefile	2003-07-17 22:22:58.000000000 +0200
@@ -24,7 +24,8 @@
 obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o suspend_asm.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend.o
+obj-$(CONFIG_PM)		+= suspend_asm.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
 obj-$(CONFIG_X86_SUMMIT)	+= summit.o
 obj-$(CONFIG_EDD)             	+= edd.o
Index: linux/arch/i386/kernel/suspend_asm.S
===================================================================
--- linux.orig/arch/i386/kernel/suspend_asm.S	2003-07-22 13:39:42.000000000 +0200
+++ linux/arch/i386/kernel/suspend_asm.S	2003-07-20 15:02:12.000000000 +0200
@@ -32,6 +32,7 @@
 saved_context_eflags:
 	.long	0
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
 	.text
 
 ENTRY(do_magic)
@@ -117,4 +118,4 @@
 loop2:
        .quad 0
        .previous
-	
\ No newline at end of file
+#endif
Index: linux/arch/i386/kernel/sysenter.c
===================================================================
--- linux.orig/arch/i386/kernel/sysenter.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/arch/i386/kernel/sysenter.c	2003-07-17 22:22:58.000000000 +0200
@@ -31,8 +31,6 @@
 	wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
 	wrmsr(MSR_IA32_SYSENTER_ESP, tss->esp1, 0);
 	wrmsr(MSR_IA32_SYSENTER_EIP, (unsigned long) sysenter_entry, 0);
-
-	printk("Enabling SEP on CPU %d\n", cpu);
 	put_cpu();	
 }
 
Index: linux/drivers/acpi/Kconfig
===================================================================
--- linux.orig/drivers/acpi/Kconfig	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/acpi/Kconfig	2003-07-17 22:22:58.000000000 +0200
@@ -58,8 +58,8 @@
 	default y
 
 config ACPI_SLEEP
-	bool "Sleep States"
-	depends on X86 && ACPI && !ACPI_HT_ONLY && SOFTWARE_SUSPEND
+	bool "Sleep States (EXPERIMENTAL)"
+	depends on X86 && ACPI && !ACPI_HT_ONLY && EXPERIMENTAL
 	---help---
 	  This option adds support for ACPI suspend states. 
 
Index: linux/drivers/base/power.c
===================================================================
--- linux.orig/drivers/base/power.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/base/power.c	2003-07-17 22:22:58.000000000 +0200
@@ -52,8 +52,6 @@
 	struct device * dev;
 	int error = 0;
 
-	printk(KERN_EMERG "Suspending devices\n");
-
 	down_write(&devices_subsys.rwsem);
 	list_for_each_entry_reverse(dev,&devices_subsys.kset.list,kobj.entry) {
 		if (dev->driver && dev->driver->suspend) {
@@ -114,8 +112,6 @@
 		}
 	}
 	up_write(&devices_subsys.rwsem);
-
-	printk(KERN_EMERG "Devices Resumed\n");
 }
 
 /**
@@ -125,8 +121,6 @@
 {
 	struct device * dev;
 	
-	printk(KERN_EMERG "Shutting down devices\n");
-
 	down_write(&devices_subsys.rwsem);
 	list_for_each_entry_reverse(dev,&devices_subsys.kset.list,kobj.entry) {
 		pr_debug("shutting down %s: ",dev->name);
Index: linux/include/linux/reboot.h
===================================================================
--- linux.orig/include/linux/reboot.h	2003-07-22 13:39:42.000000000 +0200
+++ linux/include/linux/reboot.h	2003-07-17 22:22:58.000000000 +0200
@@ -21,7 +21,7 @@
  * CAD_OFF     Ctrl-Alt-Del sequence sends SIGINT to init task.
  * POWER_OFF   Stop OS and remove all power from system, if possible.
  * RESTART2    Restart system using given command string.
- * SW_SUSPEND  Suspend system using Software Suspend if compiled in
+ * SW_SUSPEND  Suspend system using software suspend if compiled in.
  */
 
 #define	LINUX_REBOOT_CMD_RESTART	0x01234567
Index: linux/include/linux/suspend.h
===================================================================
--- linux.orig/include/linux/suspend.h	2003-07-22 13:39:42.000000000 +0200
+++ linux/include/linux/suspend.h	2003-07-22 12:54:08.000000000 +0200
@@ -55,10 +55,6 @@
 
 extern int register_suspend_notifier(struct notifier_block *);
 extern int unregister_suspend_notifier(struct notifier_block *);
-extern void refrigerator(unsigned long);
-
-extern int freeze_processes(void);
-extern void thaw_processes(void);
 
 extern unsigned int nr_copy_pages __nosavedata;
 extern suspend_pagedir_t *pagedir_nosave __nosavedata;
@@ -76,15 +72,23 @@
 extern void do_suspend_lowlevel_s4bios(int resume);
 
 #else
-static inline void software_suspend(void)
-{
-}
+static inline void software_suspend(void) { }
 #define software_resume()		do { } while(0)
 #define register_suspend_notifier(a)	do { } while(0)
 #define unregister_suspend_notifier(a)	do { } while(0)
+#endif
+
+#ifdef CONFIG_PM
+extern void refrigerator(unsigned long);
+extern int freeze_processes(void);
+extern void thaw_processes(void);
+#else
 #define refrigerator(a)			do { BUG(); } while(0)
 #define freeze_processes()		do { panic("You need CONFIG_SOFTWARE_SUSPEND to do sleeps."); } while(0)
 #define thaw_processes()		do { } while(0)
 #endif
 
+extern int prepare_suspend_console(void);
+extern void restore_console(void);
+
 #endif /* _LINUX_SWSUSP_H */
Index: linux/kernel/Makefile
===================================================================
--- linux.orig/kernel/Makefile	2003-07-22 13:39:43.000000000 +0200
+++ linux/kernel/Makefile	2003-07-17 22:22:58.000000000 +0200
@@ -17,7 +17,7 @@
 obj-$(CONFIG_PM) += pm.o
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
-obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_PM) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
 
 ifneq ($(CONFIG_IA64),y)
Index: linux/kernel/suspend.c
===================================================================
--- linux.orig/kernel/suspend.c	2003-07-22 13:39:43.000000000 +0200
+++ linux/kernel/suspend.c	2003-07-22 13:46:26.000000000 +0200
@@ -5,7 +5,7 @@
  * machine suspend feature using pretty near only high-level routines
  *
  * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
- * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 1998,2001-2003 Pavel Machek <pavel@suse.cz>
  *
  * I'd like to thank the following people for their work:
  * 
@@ -65,6 +65,7 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
 extern long sys_sync(void);
 
 unsigned char software_suspend_enabled = 0;
@@ -78,7 +79,6 @@
 #undef SUSPEND_CONSOLE
 #endif
 
-#define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
 #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
 #define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)
 #define ADDRESS2(x) __ADDRESS(__pa(x))		/* Needed for x86-64 where some pages are in memory twice */
@@ -139,39 +139,45 @@
 
 static const char name_suspend[] = "Suspend Machine: ";
 static const char name_resume[] = "Resume Machine: ";
+#endif
 
 /*
  * Debug
  */
-#define	DEBUG_DEFAULT
-#undef	DEBUG_PROCESS
+#undef	DEBUG_DEFAULT
 #undef	DEBUG_SLOW
-#define TEST_SWSUSP 0		/* Set to 1 to reboot instead of halt machine after suspension */
+#define TEST_SWSUSP 1		/* Set to 1 to reboot instead of halt machine after suspension */
 
 #ifdef DEBUG_DEFAULT
-# define PRINTK(f, a...)       printk(f, ## a)
+# define PRINTK(f, a...)	printk(f, ## a)
 #else
-# define PRINTK(f, a...)
+# define PRINTK(f, a...)	do {} while (0)
 #endif
 
 #ifdef DEBUG_SLOW
 #define MDELAY(a) mdelay(a)
 #else
-#define MDELAY(a)
+#define MDELAY(a) do {} while (0)
 #endif
 
 /*
  * Refrigerator and related stuff
  */
 
-#define INTERESTING(p) \
-			/* We don't want to touch kernel_threads..*/ \
-			if (p->flags & PF_IOTHREAD) \
-				continue; \
-			if (p == current) \
-				continue; \
-			if (p->state == TASK_ZOMBIE) \
-				continue;
+/* 0 = Ignore this process when freezing/thawing, 1 = freeze/thaw this process */
+static inline int interesting_process(struct task_struct *p)
+{
+	if (p->flags & PF_IOTHREAD)
+		return 0;
+	if (p == current)
+		return 0;
+	if ((p->state == TASK_ZOMBIE) || (p->state == TASK_DEAD))
+		return 0;
+
+	return 1;
+}
+
+#define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
 
 /* Refrigerator is place where frozen processes are stored :-). */
 void refrigerator(unsigned long flag)
@@ -212,9 +218,12 @@
 		read_lock(&tasklist_lock);
 		do_each_thread(g, p) {
 			unsigned long flags;
-			INTERESTING(p);
+			if (!interesting_process(p))
+				continue;
 			if (p->flags & PF_FROZEN)
 				continue;
+			if (p->state == TASK_STOPPED)
+				continue;
 
 			/* FIXME: smp problem here: we may not access other process' flags
 			   without locking */
@@ -245,19 +254,56 @@
 	printk( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
-		INTERESTING(p);
-		
-		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
-		else
-			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
-		wake_up_process(p);
+ 		if (!interesting_process(p))
+			continue;
+ 		if (p->flags & PF_FROZEN) {
+ 			p->flags &= ~PF_FROZEN;
+ 			wake_up_process(p);
+ 		} else
+ 			PRINTK(KERN_INFO " Strange, %s not frozen\n", p->comm );
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
+	schedule();
 	printk( " done\n" );
 	MDELAY(500);
 }
 
+int prepare_suspend_console(void)
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
+	if (vt_waitactive(SUSPEND_CONSOLE)) {
+		printk(KERN_ERR "Bummer. Can't switch VCs.\n");
+		return 1;
+	}
+	orig_kmsg = kmsg_redirect;
+	kmsg_redirect = SUSPEND_CONSOLE;
+#endif
+#endif
+	return 0;
+}
+
+void restore_console(void)
+{
+	console_loglevel = orig_loglevel;
+#ifdef SUSPEND_CONSOLE
+	set_console (orig_fgconsole);
+#endif
+	return;
+}
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
 /*
  * Saving part...
  */
@@ -283,17 +329,6 @@
 	return 0;
 }
 
-/*
- * This is our sync function. With this solution we probably won't sleep
- * but that should not be a problem since tasks are stopped..
- */
-
-static inline void do_suspend_sync(void)
-{
-	blk_run_queues();
-#warning This might be broken. We need to somehow wait for data to reach the disk
-}
-
 /* We memorize in swapfile_used what swap devices are used for suspension */
 #define SWAPFILE_UNUSED    0
 #define SWAPFILE_SUSPEND   1	/* This is the suspending device */
@@ -561,7 +596,6 @@
 			free_suspend_pagedir((unsigned long) pagedir);
 			return NULL;
 		}
-		printk(".");
 		SetPageNosave(virt_to_page(p->address));
 		p->orig_address = 0;
 		p++;
@@ -569,39 +603,6 @@
 	return pagedir;
 }
 
-static int prepare_suspend_console(void)
-{
-	orig_loglevel = console_loglevel;
-	console_loglevel = new_loglevel;
-
-#ifdef CONFIG_VT
-	orig_fgconsole = fg_console;
-#ifdef SUSPEND_CONSOLE
-	if(vc_allocate(SUSPEND_CONSOLE))
-	  /* we can't have a free VC for now. Too bad,
-	   * we don't want to mess the screen for now. */
-		return 1;
-
-	set_console (SUSPEND_CONSOLE);
-	if(vt_waitactive(SUSPEND_CONSOLE)) {
-		PRINTK("Bummer. Can't switch VCs.");
-		return 1;
-	}
-	orig_kmsg = kmsg_redirect;
-	kmsg_redirect = SUSPEND_CONSOLE;
-#endif
-#endif
-	return 0;
-}
-
-static void restore_console(void)
-{
-	console_loglevel = orig_loglevel;
-#ifdef SUSPEND_CONSOLE
-	set_console (orig_fgconsole);
-#endif
-	return;
-}
 
 static int prepare_suspend_processes(void)
 {
@@ -852,7 +853,6 @@
 	free_pages((unsigned long) pagedir_nosave, pagedir_order);
 	spin_unlock_irq(&suspend_pagedir_lock);
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-	PRINTK(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
 }
 
 static void do_software_suspend(void)
@@ -861,20 +861,13 @@
 	if (prepare_suspend_console())
 		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
 	if (!prepare_suspend_processes()) {
-
 		/* At this point, all user processes and "dangerous"
                    kernel threads are stopped. Free some memory, as we
                    need half of memory free. */
-
 		free_some_memory();
 		
-		/* No need to invalidate any vfsmnt list -- they will be valid after resume, anyway.
-		 *
-		 * We sync here -- so you have consistent filesystem state when things go wrong.
-		 * -- so that noone writes to disk after we do atomic copy of data.
-		 */
-		PRINTK("Syncing disks before copy\n");
-		do_suspend_sync();
+		/* No need to invalidate any vfsmnt list -- they will be valid after resume, anyway. */
+		blk_run_queues();
 
 		/* Save state of all device drivers, and stop them. */		   
 		if(drivers_suspend()==0)
@@ -888,12 +881,11 @@
 			 * using normal kernel mechanism.
 			 */
 			do_magic(0);
-		PRINTK("Restarting processes...\n");
 		thaw_processes();
 	}
 	software_suspend_enabled = 1;
 	MDELAY(1000);
-	restore_console ();
+	restore_console();
 }
 
 /*
@@ -906,7 +898,7 @@
 		return;
 
 	software_suspend_enabled = 0;
-	BUG_ON(in_interrupt());
+	BUG_ON(in_atomic());
 	do_software_suspend();
 }
 
@@ -1279,4 +1271,5 @@
 
 EXPORT_SYMBOL(software_suspend);
 EXPORT_SYMBOL(software_suspend_enabled);
+#endif
 EXPORT_SYMBOL(refrigerator);
Index: linux/arch/i386/kernel/acpi/wakeup.S
===================================================================
--- linux.orig/arch/i386/kernel/acpi/wakeup.S	2003-07-22 13:39:42.000000000 +0200
+++ linux/arch/i386/kernel/acpi/wakeup.S	2003-07-22 13:26:01.000000000 +0200
@@ -43,6 +43,11 @@
 
 	testl	$1, video_flags - wakeup_code
 	jz	1f
+	/* It is miracle that this works:
+	   * PCI may or may not be initialized at this point
+	   * I'm told we should pass device ID to video bios
+	   However it works on some real machines...
+	 */
 	lcall   $0xc000,$3
 	movw	%cs, %ax
 	movw	%ax, %ds					# Bios might have played with that

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
