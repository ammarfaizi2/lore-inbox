Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUF0RIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUF0RIT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 13:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbUF0RIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 13:08:19 -0400
Received: from gprs214-210.eurotel.cz ([160.218.214.210]:19584 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264154AbUF0RHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 13:07:43 -0400
Date: Sun, 27 Jun 2004 19:07:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Next step of smp support & fix device suspending
Message-ID: <20040627170724.GA4126@elf.ucw.cz>
References: <20040625115529.GA764@elf.ucw.cz> <20040626154607.5d3464e4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040626154607.5d3464e4.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  This introduces functions for stopping all-but-boot-cpus, which will
> >  be needed for smp suspend, and fixes level for calling driver model:
> 
> hm, this breaks the build.
> 
> kernel/built-in.o(.text+0x21731): In function `software_suspend':
> /usr/src/25/kernel/power/swsusp.c:841: undefined reference to `disable_nonboot_cpus'
> kernel/built-in.o(.text+0x2175f):/usr/src/25/kernel/power/swsusp.c:857: undefined reference to `enable_nonboot_cpus'
> 
> I'll drop all the swpsup patches, as they seem to be in some flux.

That's smp, right? Sorry about that.

Can you take this one, instead? [cc-ed lkml]

It fixes levels for calling driver model, puts devices into sleep
before powering down (so that emergency parking does not happen), and
actually introduces SMP support, but its disabled for now. Plus
noone should try to freeze_processes() when thats not implemented, we
now BUG()s -- we do not want Heisenbugs.

Thanks,
								Pavel

Index: linux/include/linux/suspend.h
===================================================================
--- linux.orig/include/linux/suspend.h	2004-06-22 12:53:19.000000000 +0200
+++ linux/include/linux/suspend.h	2004-06-25 13:07:52.000000000 +0200
@@ -67,20 +67,19 @@
 extern void pm_restore_console(void);
 
 #else
-static inline void refrigerator(unsigned long flag)
-{
-
-}
-static inline int freeze_processes(void)
-{
-	return 0;
-}
-static inline void thaw_processes(void)
-{
-
-}
+static inline void refrigerator(unsigned long flag) {}
+static inline int freeze_processes(void) { BUG(); }
+static inline void thaw_processes(void) {}
 #endif	/* CONFIG_PM */
 
+#ifdef CONFIG_SMP
+extern void disable_nonboot_cpus(void);
+extern void enable_nonboot_cpus(void);
+#else
+static inline void disable_nonboot_cpus(void) {}
+static inline void enable_nonboot_cpus(void) {}
+#endif
+
 asmlinkage void do_magic(int is_resume);
 asmlinkage void do_magic_resume_1(void);
 asmlinkage void do_magic_resume_2(void);
Index: linux/kernel/power/swsusp.c
===================================================================
--- linux.orig/kernel/power/swsusp.c	2004-06-22 12:53:19.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-06-27 18:25:28.000000000 +0200
@@ -693,6 +701,7 @@
 	else
 #endif
 	{
+		device_suspend(3);
 		device_shutdown();
 		machine_power_off();
 	}
@@ -713,7 +722,7 @@
 	mb();
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 
-	device_power_down(4);
+	device_power_down(3);
 	PRINTK( "Waiting for DMAs to settle down...\n");
 	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
 			   Do it with disabled interrupts for best effect. That way, if some
@@ -782,7 +796,7 @@
 {
 	int is_problem;
 	read_swapfiles();
-	device_power_down(4);
+	device_power_down(3);
 	is_problem = suspend_prepare_image();
 	device_power_up();
 	spin_unlock_irq(&suspend_pagedir_lock);
@@ -799,7 +813,6 @@
 	barrier();
 	mb();
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
-	mdelay(1000);
 
 	free_pages((unsigned long) pagedir_nosave, pagedir_order);
 	spin_unlock_irq(&suspend_pagedir_lock);
@@ -836,9 +849,10 @@
                    need half of memory free. */
 
 		free_some_memory();
-		
-		/* Save state of all device drivers, and stop them. */		   
-		if ((res = device_suspend(4))==0)
+		disable_nonboot_cpus();
+		/* Save state of all device drivers, and stop them. */
+		printk("Suspending devices... ");
+		if ((res = device_suspend(3))==0) {
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *
@@ -849,7 +863,9 @@
 			 * using normal kernel mechanism.
 			 */
 			do_magic(0);
+		}
 		thaw_processes();
+		enable_nonboot_cpus();
 	} else
 		res = -EBUSY;
 	software_suspend_enabled = 1;
@@ -1201,7 +1205,9 @@
 	printk( "resuming from %s\n", resume_file);
 	if (read_suspend_image(resume_file, 0))
 		goto read_failure;
-	device_suspend(4);
+	/* FIXME: Should we stop processes here, just to be safer? */
+	disable_nonboot_cpus();
+	device_suspend(3);
 	do_magic(1);
 	panic("This never returns");
 
Index: linux/kernel/power/smp.c
===================================================================
--- linux.orig/kernel/power/smp.c	2004-06-22 12:53:19.000000000 +0200
+++ linux/kernel/power/smp.c	2004-06-25 13:06:10.000000000 +0200
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
+void disable_nonboot_cpus(void)
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
+void enable_nonboot_cpus(void)
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
 



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
