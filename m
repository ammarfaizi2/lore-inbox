Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265107AbUFBW4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265107AbUFBW4W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 18:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbUFBW4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 18:56:22 -0400
Received: from gprs214-9.eurotel.cz ([160.218.214.9]:11138 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265107AbUFBW4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 18:56:05 -0400
Date: Thu, 3 Jun 2004 00:55:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: vojtech@ucw.cz
Subject: SMP support for swsusp, and strange serio/i8042 problems
Message-ID: <20040602225549.GA16454@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here's experimental (works-for-me-mostly) SMP support for
swsusp. While debugging it, I hit strange problem with i8042
driver. If I change #if 0 to #if 1 *and* kernel is CONFIG_SMP, it dies
during first schedule(). Ouch.

Why is 8042 marked as system device, btw? Stopping timer for system
device is likely useless; first resume is called and only after that
interrupts are reenabled.

								Pavel

--- clean.amd/drivers/base/power/shutdown.c	2004-04-05 16:50:19.000000000 +0200
+++ linux/drivers/base/power/shutdown.c	2004-06-02 22:27:03.000000000 +0200
@@ -8,6 +8,7 @@
  *
  */
 
+#define DEBUG
 #include <linux/config.h>
 #include <linux/device.h>
 #include <asm/semaphore.h>
@@ -52,14 +53,14 @@
 	struct device * dev;
 	
 	down_write(&devices_subsys.rwsem);
+	printk("Shutting down devices: ");
 	list_for_each_entry_reverse(dev,&devices_subsys.kset.list,kobj.entry) {
-		pr_debug("shutting down %s: ",dev->bus_id);
 		if (dev->driver && dev->driver->shutdown) {
-			pr_debug("Ok\n");
+			printk("%s, ",dev->bus_id);
 			dev->driver->shutdown(dev);
-		} else
-			pr_debug("Ignored.\n");
+		}
 	}
+	printk("ok\n");
 	up_write(&devices_subsys.rwsem);
 
 	sysdev_shutdown();
--- clean.amd/drivers/base/power/suspend.c	2003-09-28 22:05:43.000000000 +0200
+++ linux/drivers/base/power/suspend.c	2004-06-02 22:38:56.000000000 +0200
@@ -113,10 +113,13 @@
 	int error = 0;
 	struct device * dev;
 
+	printk("Powering down devices: ");
 	list_for_each_entry_reverse(dev,&dpm_off_irq,power.entry) {
+		printk("%s ", dev->bus_id);
 		if ((error = suspend_device(dev,state)))
 			break;
 	} 
+	printk("ok?\n"); 
 	if (error)
 		goto Error;
 	if ((error = sysdev_suspend(state)))
--- clean.amd/drivers/base/sys.c	2004-04-05 16:50:19.000000000 +0200
+++ linux/drivers/base/sys.c	2004-06-02 23:13:07.000000000 +0200
@@ -302,18 +302,17 @@
 {
 	struct sysdev_class * cls;
 
-	pr_debug("Suspending System Devices\n");
+	printk("Suspending System Devices: ");
 
 	list_for_each_entry_reverse(cls,&system_subsys.kset.list,
 				    kset.kobj.entry) {
 		struct sys_device * sysdev;
 
-		pr_debug("Suspending type '%s':\n",
-			 kobject_name(&cls->kset.kobj));
+		printk("%s: ", kobject_name(&cls->kset.kobj));
 
 		list_for_each_entry(sysdev,&cls->kset.list,kobj.entry) {
 			struct sysdev_driver * drv;
-			pr_debug(" %s\n",kobject_name(&sysdev->kobj));
+			printk(" %s, ",kobject_name(&sysdev->kobj));
 
 			/* Call global drivers first. */
 			list_for_each_entry(drv,&global_drivers,entry) {
@@ -332,6 +331,7 @@
 				cls->suspend(sysdev,state);
 		}
 	}
+	printk("ok\n");
 	return 0;
 }
 
@@ -349,17 +349,16 @@
 {
 	struct sysdev_class * cls;
 
-	pr_debug("Resuming System Devices\n");
+	printk("Resuming System Devices: ");
 
 	list_for_each_entry(cls,&system_subsys.kset.list,kset.kobj.entry) {
 		struct sys_device * sysdev;
 
-		pr_debug("Resuming type '%s':\n",
-			 kobject_name(&cls->kset.kobj));
+		printk("%s: ", kobject_name(&cls->kset.kobj));
 
 		list_for_each_entry(sysdev,&cls->kset.list,kobj.entry) {
 			struct sysdev_driver * drv;
-			pr_debug(" %s\n",kobject_name(&sysdev->kobj));
+			printk(" %s, ",kobject_name(&sysdev->kobj));
 
 			/* First, call the class-specific one */
 			if (cls->resume)
@@ -379,6 +378,7 @@
 
 		}
 	}
+	printk("ok\n");
 	return 0;
 }
 
--- clean.amd/drivers/input/serio/i8042.c	2004-04-05 16:50:21.000000000 +0200
+++ linux/drivers/input/serio/i8042.c	2004-06-02 23:32:15.000000000 +0200
@@ -832,12 +833,13 @@
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
@@ -845,12 +847,15 @@
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
--- clean.amd/include/linux/suspend.h	2004-05-20 23:11:46.000000000 +0200
+++ linux/include/linux/suspend.h	2004-06-01 12:53:43.000000000 +0200
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
--- clean.amd/kernel/power/Makefile	2003-09-28 22:06:44.000000000 +0200
+++ linux/kernel/power/Makefile	2004-06-01 12:53:43.000000000 +0200
@@ -1,4 +1,5 @@
 obj-y				:= main.o process.o console.o pm.o
+obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
 obj-$(CONFIG_PM_DISK)		+= disk.o pmdisk.o
 
--- clean.amd/kernel/power/console.c	2004-02-20 12:39:39.000000000 +0100
+++ linux/kernel/power/console.c	2004-06-01 14:34:38.000000000 +0200
@@ -7,6 +7,7 @@
 #include <linux/vt_kern.h>
 #include <linux/kbd_kern.h>
 #include <linux/console.h>
+#include <linux/delay.h>
 #include "power.h"
 
 static int new_loglevel = 10;
--- clean.amd/kernel/power/smp.c	2004-05-21 11:49:20.000000000 +0200
+++ linux/kernel/power/smp.c	2004-06-03 00:22:43.000000000 +0200
@@ -1 +1,66 @@
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
+static void smp_pause(void * data)
+{
+	atomic_inc(&cpu_counter);
+	while (atomic_read(&freeze)) {
+		cpu_relax();
+		barrier();
+	}
+	atomic_dec(&cpu_counter);
+	__flush_tlb_global();		/* CPU now wakes up into completely different system. Update its caches. */
+	/* Ahha, we might be expected to have different FPU registers etc. Ouch. */
+}
+
+void smp_freeze(void)
+{
+	printk("Freezing CPUs\n");
+	set_cpus_allowed(current, cpumask_of_cpu(0));
+	schedule();
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
+	printk("Restarting CPUs...");
+	atomic_set(&freeze, 0);
+	while (atomic_read(&cpu_counter)) {
+		cpu_relax();
+		barrier();
+	}
+	printk("ok\n");
+	/* FIXME: we probably should make this task go back to "any cpu" mode */
+}
+
 
--- clean.amd/kernel/power/swsusp.c	2004-05-21 12:26:43.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-06-02 23:46:56.000000000 +0200
@@ -851,8 +851,11 @@
 
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
@@ -862,8 +865,16 @@
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
@@ -1187,8 +1198,7 @@
 static int __init software_resume(void)
 {
 	if (num_online_cpus() > 1) {
-		printk(KERN_WARNING "Software Suspend has malfunctioning SMP support. Disabled :(\n");	
-		return -EINVAL;
+		printk(KERN_WARNING "SMP support is very experimental.\n");	
 	}
 	/* We enable the possibility of machine suspend */
 	software_suspend_enabled = 1;
@@ -1215,6 +1225,8 @@
 	printk( "resuming from %s\n", resume_file);
 	if (read_suspend_image(resume_file, 0))
 		goto read_failure;
+	mdelay(1000);
+	smp_freeze();
 	device_suspend(4);
 	do_magic(1);
 	panic("This never returns");



-- 
934a471f20d6580d5aad759bf0d97ddc
