Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUFWMSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUFWMSb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUFWMSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:18:31 -0400
Received: from gprs214-143.eurotel.cz ([160.218.214.143]:45451 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261205AbUFWMSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:18:15 -0400
Date: Wed, 23 Jun 2004 14:17:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: SMP support for swsusp (this one actually works for me)
Message-ID: <20040623121727.GA26623@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here's SMP support for swsusp; this one actually works for me [with
keyboard hack], but I'd like more testers. If it looks okay, I'll
merge simple pieces with andrew.
								Pavel

Index: linux/drivers/input/serio/i8042.c
===================================================================
--- linux.orig/drivers/input/serio/i8042.c	2004-06-22 12:53:19.000000000 +0200
+++ linux/drivers/input/serio/i8042.c	2004-06-22 12:38:06.000000000 +0200
@@ -841,12 +841,13 @@
 		return -1;
 	}
 
+#if 0
 	if (i8042_mux_present)
 		if (i8042_enable_mux_mode(&i8042_aux_values, NULL) ||
 		    i8042_enable_mux_ports(&i8042_aux_values)) {
 			printk(KERN_WARNING "i8042: failed to resume active multiplexor, mouse won't work.\n");
 		}
-
+#endif
 /*
  * Reconnect anything that was connected to the ports.
  */
@@ -854,12 +855,15 @@
 	if (i8042_kbd_values.exists && i8042_activate_port(&i8042_kbd_port) == 0)
 		serio_reconnect(&i8042_kbd_port);
 
+#if 0
 	if (i8042_aux_values.exists && i8042_activate_port(&i8042_aux_port) == 0)
 		serio_reconnect(&i8042_aux_port);
 
 	for (i = 0; i < 4; i++)
 		if (i8042_mux_values[i].exists && i8042_activate_port(i8042_mux_port + i) == 0)
 			serio_reconnect(i8042_mux_port + i);
+#endif
+
 /*
  * Restart timer (for polling "stuck" data)
  */
Index: linux/include/linux/suspend.h
===================================================================
--- linux.orig/include/linux/suspend.h	2004-06-22 12:53:19.000000000 +0200
+++ linux/include/linux/suspend.h	2004-06-03 00:27:20.000000000 +0200
@@ -81,6 +81,14 @@
 }
 #endif	/* CONFIG_PM */
 
+#ifdef CONFIG_SMP
+extern void smp_freeze(void);
+extern void smp_restart(void);
+#else
+static inline void smp_freeze(void) {}
+static inline void smp_restart(void) {}
+#endif
+
 asmlinkage void do_magic(int is_resume);
 asmlinkage void do_magic_resume_1(void);
 asmlinkage void do_magic_resume_2(void);
Index: linux/kernel/power/process.c
===================================================================
--- linux.orig/kernel/power/process.c	2004-06-22 12:53:19.000000000 +0200
+++ linux/kernel/power/process.c	2004-06-03 00:27:56.000000000 +0200
@@ -109,7 +109,6 @@
 			wake_up_process(p);
 		} else
 			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
-		wake_up_process(p);
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
Index: linux/kernel/power/swsusp.c
===================================================================
--- linux.orig/kernel/power/swsusp.c	2004-06-22 12:53:19.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-06-10 23:09:07.000000000 +0200
@@ -837,8 +855,11 @@
 
 		free_some_memory();
 		
-		/* Save state of all device drivers, and stop them. */		   
-		if ((res = device_suspend(4))==0)
+		mdelay(1000);
+		smp_freeze();
+		/* Save state of all device drivers, and stop them. */
+		printk("Suspending devices... ");
+		if ((res = device_suspend(4))==0) {
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *
@@ -848,8 +869,16 @@
 			 * unsuspends all device drivers, and writes memory to disk
 			 * using normal kernel mechanism.
 			 */
+			printk("ok\n");
+#if 1
 			do_magic(0);
+#else
+			device_resume();
+#endif
+		}
 		thaw_processes();
+		printk("Processes thawed\n");
+		smp_restart();
 	} else
 		res = -EBUSY;
 	software_suspend_enabled = 1;
@@ -1173,8 +1204,7 @@
 static int __init software_resume(void)
 {
 	if (num_online_cpus() > 1) {
-		printk(KERN_WARNING "Software Suspend has malfunctioning SMP support. Disabled :(\n");	
-		return -EINVAL;
+		printk(KERN_WARNING "SMP support is very experimental.\n");	
 	}
 	/* We enable the possibility of machine suspend */
 	software_suspend_enabled = 1;
@@ -1201,6 +1231,8 @@
 	printk( "resuming from %s\n", resume_file);
 	if (read_suspend_image(resume_file, 0))
 		goto read_failure;
+	mdelay(1000);
+	smp_freeze();
 	device_suspend(4);
 	do_magic(1);
 	panic("This never returns");
Index: linux/arch/i386/power/cpu.c
===================================================================
--- linux.orig/arch/i386/power/cpu.c	2004-06-22 12:53:19.000000000 +0200
+++ linux/arch/i386/power/cpu.c	2004-06-09 14:38:54.000000000 +0200
@@ -27,7 +27,6 @@
 #include <asm/tlbflush.h>
 
 static struct saved_context saved_context;
-static void fix_processor_context(void);
 
 unsigned long saved_context_eax, saved_context_ebx;
 unsigned long saved_context_ecx, saved_context_edx;
@@ -37,33 +36,38 @@
 
 extern void enable_sep_cpu(void *);
 
-void save_processor_state(void)
+void __save_processor_state(struct saved_context *ctxt)
 {
 	kernel_fpu_begin();
 
 	/*
 	 * descriptor tables
 	 */
-	asm volatile ("sgdt %0" : "=m" (saved_context.gdt_limit));
-	asm volatile ("sidt %0" : "=m" (saved_context.idt_limit));
-	asm volatile ("sldt %0" : "=m" (saved_context.ldt));
-	asm volatile ("str %0"  : "=m" (saved_context.tr));
+	asm volatile ("sgdt %0" : "=m" (ctxt->gdt_limit));
+	asm volatile ("sidt %0" : "=m" (ctxt->idt_limit));
+	asm volatile ("sldt %0" : "=m" (ctxt->ldt));
+	asm volatile ("str %0"  : "=m" (ctxt->tr));
 
 	/*
 	 * segment registers
 	 */
-	asm volatile ("movw %%es, %0" : "=m" (saved_context.es));
-	asm volatile ("movw %%fs, %0" : "=m" (saved_context.fs));
-	asm volatile ("movw %%gs, %0" : "=m" (saved_context.gs));
-	asm volatile ("movw %%ss, %0" : "=m" (saved_context.ss));
+	asm volatile ("movw %%es, %0" : "=m" (ctxt->es));
+	asm volatile ("movw %%fs, %0" : "=m" (ctxt->fs));
+	asm volatile ("movw %%gs, %0" : "=m" (ctxt->gs));
+	asm volatile ("movw %%ss, %0" : "=m" (ctxt->ss));
 
 	/*
 	 * control registers 
 	 */
-	asm volatile ("movl %%cr0, %0" : "=r" (saved_context.cr0));
-	asm volatile ("movl %%cr2, %0" : "=r" (saved_context.cr2));
-	asm volatile ("movl %%cr3, %0" : "=r" (saved_context.cr3));
-	asm volatile ("movl %%cr4, %0" : "=r" (saved_context.cr4));
+	asm volatile ("movl %%cr0, %0" : "=r" (ctxt->cr0));
+	asm volatile ("movl %%cr2, %0" : "=r" (ctxt->cr2));
+	asm volatile ("movl %%cr3, %0" : "=r" (ctxt->cr3));
+	asm volatile ("movl %%cr4, %0" : "=r" (ctxt->cr4));
+}
+
+void save_processor_state(void)
+{
+	__save_processor_state(&saved_context);
 }
 
 static void
@@ -75,32 +79,59 @@
 	mxcsr_feature_mask_init();
 }
 
-void restore_processor_state(void)
+
+static void fix_processor_context(void)
+{
+	int cpu = smp_processor_id();
+	struct tss_struct * t = init_tss + cpu;
+
+	set_tss_desc(cpu,t);	/* This just modifies memory; should not be necessary. But... This is necessary, because 386 hardware has concept of busy TSS or some similar stupidity. */
+        cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
+
+	load_TR_desc();				/* This does ltr */
+	load_LDT(&current->active_mm->context);	/* This does lldt */
+
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
+void __restore_processor_state(struct saved_context *ctxt)
 {
 
 	/*
 	 * control registers
 	 */
-	asm volatile ("movl %0, %%cr4" :: "r" (saved_context.cr4));
-	asm volatile ("movl %0, %%cr3" :: "r" (saved_context.cr3));
-	asm volatile ("movl %0, %%cr2" :: "r" (saved_context.cr2));
-	asm volatile ("movl %0, %%cr0" :: "r" (saved_context.cr0));
+	asm volatile ("movl %0, %%cr4" :: "r" (ctxt->cr4));
+	asm volatile ("movl %0, %%cr3" :: "r" (ctxt->cr3));
+	asm volatile ("movl %0, %%cr2" :: "r" (ctxt->cr2));
+	asm volatile ("movl %0, %%cr0" :: "r" (ctxt->cr0));
 
 	/*
 	 * segment registers
 	 */
-	asm volatile ("movw %0, %%es" :: "r" (saved_context.es));
-	asm volatile ("movw %0, %%fs" :: "r" (saved_context.fs));
-	asm volatile ("movw %0, %%gs" :: "r" (saved_context.gs));
-	asm volatile ("movw %0, %%ss" :: "r" (saved_context.ss));
+	asm volatile ("movw %0, %%es" :: "r" (ctxt->es));
+	asm volatile ("movw %0, %%fs" :: "r" (ctxt->fs));
+	asm volatile ("movw %0, %%gs" :: "r" (ctxt->gs));
+	asm volatile ("movw %0, %%ss" :: "r" (ctxt->ss));
 
 	/*
 	 * now restore the descriptor tables to their proper values
 	 * ltr is done i fix_processor_context().
 	 */
-	asm volatile ("lgdt %0" :: "m" (saved_context.gdt_limit));
-	asm volatile ("lidt %0" :: "m" (saved_context.idt_limit));
-	asm volatile ("lldt %0" :: "m" (saved_context.ldt));
+	asm volatile ("lgdt %0" :: "m" (ctxt->gdt_limit));
+	asm volatile ("lidt %0" :: "m" (ctxt->idt_limit));
+	asm volatile ("lldt %0" :: "m" (ctxt->ldt));
 
 	/*
 	 * sysenter MSRs
@@ -112,31 +143,11 @@
 	do_fpu_end();
 }
 
-static void fix_processor_context(void)
+void restore_processor_state(void)
 {
-	int cpu = smp_processor_id();
-	struct tss_struct * t = init_tss + cpu;
-
-	set_tss_desc(cpu,t);	/* This just modifies memory; should not be necessary. But... This is necessary, because 386 hardware has concept of busy TSS or some similar stupidity. */
-        cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
-
-	load_TR_desc();				/* This does ltr */
-	load_LDT(&current->active_mm->context);	/* This does lldt */
-
-	/*
-	 * Now maybe reload the debug registers
-	 */
-	if (current->thread.debugreg[7]){
-                loaddebug(&current->thread, 0);
-                loaddebug(&current->thread, 1);
-                loaddebug(&current->thread, 2);
-                loaddebug(&current->thread, 3);
-                /* no 4 and 5 */
-                loaddebug(&current->thread, 6);
-                loaddebug(&current->thread, 7);
-	}
-
+	__restore_processor_state(&saved_context);
 }
 
+
 EXPORT_SYMBOL(save_processor_state);
 EXPORT_SYMBOL(restore_processor_state);
Index: linux/kernel/power/smp.c
===================================================================
--- linux.orig/kernel/power/smp.c	2004-06-22 12:53:19.000000000 +0200
+++ linux/kernel/power/smp.c	2004-06-09 14:42:51.000000000 +0200
@@ -0,0 +1,85 @@
+/*
+ * drivers/power/smp.c - Functions for stopping other CPUs.
+ *
+ * Copyright 2004 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Nigel Cunningham <ncunningham@clear.net.nz>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#undef DEBUG
+
+#include <linux/smp_lock.h>
+#include <linux/interrupt.h>
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <asm/atomic.h>
+#include <asm/tlbflush.h>
+
+static atomic_t cpu_counter, freeze;
+
+
+static void smp_pause(void * data)
+{
+	struct saved_context ctxt;
+	__save_processor_state(&ctxt);
+	printk("Sleeping in:\n");
+	dump_stack();
+	atomic_inc(&cpu_counter);
+	while (atomic_read(&freeze)) {
+		/* FIXME: restore takes place at random piece inside this. 
+		   This should probably be written in assembly, and
+		   preserve general-purpose registers, too
+
+		   What about stack? We may need to move to new stack here.
+
+		   This should better be ran with interrupts disabled.
+		 */
+		cpu_relax();
+		barrier();
+	}
+	atomic_dec(&cpu_counter);
+	__restore_processor_state(&ctxt);
+}
+
+cpumask_t oldmask;
+
+void smp_freeze(void)
+{
+	printk("Freezing CPUs (at %d)", smp_processor_id());
+	oldmask = current->cpus_allowed;
+	set_cpus_allowed(current, cpumask_of_cpu(0));
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(HZ);
+	printk("...");
+	BUG_ON(smp_processor_id() != 0);
+
+	/* FIXME: for this to work, all the CPUs must be running
+	 * "idle" thread (or we deadlock). Is that guaranteed? */
+
+	atomic_set(&cpu_counter, 0);
+	atomic_set(&freeze, 1);
+	smp_call_function(smp_pause, NULL, 0, 0);
+	while (atomic_read(&cpu_counter) < (num_online_cpus() - 1)) {
+		cpu_relax();
+		barrier();
+	}
+	printk("ok\n");
+}
+
+void smp_restart(void)
+{
+	printk("Restarting CPUs");
+	atomic_set(&freeze, 0);
+	while (atomic_read(&cpu_counter)) {
+		cpu_relax();
+		barrier();
+	}
+	printk("...");
+	set_cpus_allowed(current, oldmask);
+	schedule();
+	printk("ok\n");
+
+}
+
+
Index: linux/kernel/power/Makefile
===================================================================
--- linux.orig/kernel/power/Makefile	2004-06-22 12:53:19.000000000 +0200
+++ linux/kernel/power/Makefile	2004-06-09 14:42:55.000000000 +0200
@@ -1,4 +1,5 @@
 obj-y				:= main.o process.o console.o pm.o
+obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
 obj-$(CONFIG_PM_DISK)		+= disk.o pmdisk.o
 

--- clean/kernel/sched.c	2004-06-22 12:36:47.000000000 +0200
+++ linux/kernel/sched.c	2004-06-22 12:39:00.000000000 +0200
@@ -3558,6 +3558,7 @@
 		p = kthread_create(migration_thread, hcpu, "migration/%d",cpu);
 		if (IS_ERR(p))
 			return NOTIFY_BAD;
+		p->flags |= PF_NOFREEZE;
 		kthread_bind(p, cpu);
 		/* Must be high prio: stop_machine expects to yield to it. */
 		rq = task_rq_lock(p, &flags);
%diffstat
 Documentation/power/swsusp.txt   |    5 +
 Documentation/power/video.txt    |    4 +
 arch/i386/kernel/cpu/mtrr/main.c |    3 +
 arch/i386/kernel/signal.c        |    3 -
 arch/i386/power/cpu.c            |  109 +++++++++++++++++++++------------------
 arch/i386/power/swsusp.S         |    4 -
 arch/x86_64/kernel/time.c        |   31 +++++++++--
 drivers/acpi/event.c             |   24 +++-----
 drivers/acpi/thermal.c           |   15 +++++
 drivers/input/power.c            |   12 ++++
 drivers/input/serio/i8042.c      |    6 +-
 include/linux/suspend.h          |    8 ++
 kernel/power/Makefile            |    1 
 kernel/power/process.c           |    1 
 kernel/power/smp.c               |   85 ++++++++++++++++++++++++++++++
 kernel/power/swsusp.c            |   78 +++++++++++++++++++--------
 kernel/signal.c                  |    6 +-
 17 files changed, 293 insertions(+), 102 deletions(-)


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
