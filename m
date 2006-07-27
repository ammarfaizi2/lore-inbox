Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWG0Hz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWG0Hz5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 03:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWG0Hzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 03:55:53 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:38617 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750744AbWG0Hzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 03:55:31 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/3] Disable CPU hotplug during suspend
Date: Thu, 27 Jul 2006 09:52:14 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200607270914.08774.rjw@sisk.pl>
In-Reply-To: <200607270914.08774.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607270952.14774.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current suspend code has to be run on one CPU, so we use the CPU
hotplug to take the non-boot CPUs offline on SMP machines.  However, we
should also make sure that these CPUs will not be enabled by someone
else after we have disabled them.

The functions disable_nonboot_cpus() and enable_nonboot_cpus() are
moved to kernel/cpu.c, because they now refer to some stuff in there that
should better be static.  Also it's better if disable_nonboot_cpus() returns
an error instead of panicking if something goes wrong, and
enable_nonboot_cpus() has no reason to panic(), because the CPUs may have
been enabled by the userland before it tries to take them online.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/cpu.h     |    8 +++
 include/linux/suspend.h |    8 ---
 kernel/cpu.c            |  109 +++++++++++++++++++++++++++++++++++++++++-------
 kernel/power/Makefile   |    2 
 kernel/power/disk.c     |    7 ++-
 kernel/power/main.c     |   10 +---
 kernel/power/smp.c      |   62 ---------------------------
 kernel/power/user.c     |   14 +++---
 8 files changed, 121 insertions(+), 99 deletions(-)

Index: linux-2.6.18-rc2/include/linux/suspend.h
===================================================================
--- linux-2.6.18-rc2.orig/include/linux/suspend.h	2006-07-26 08:52:42.000000000 +0200
+++ linux-2.6.18-rc2/include/linux/suspend.h	2006-07-27 08:01:29.000000000 +0200
@@ -57,14 +57,6 @@ static inline int software_suspend(void)
 }
 #endif /* CONFIG_PM */
 
-#ifdef CONFIG_SUSPEND_SMP
-extern void disable_nonboot_cpus(void);
-extern void enable_nonboot_cpus(void);
-#else
-static inline void disable_nonboot_cpus(void) {}
-static inline void enable_nonboot_cpus(void) {}
-#endif
-
 void save_processor_state(void);
 void restore_processor_state(void);
 struct saved_context;
Index: linux-2.6.18-rc2/kernel/power/smp.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/power/smp.c	2006-07-26 08:52:42.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,62 +0,0 @@
-/*
- * drivers/power/smp.c - Functions for stopping other CPUs.
- *
- * Copyright 2004 Pavel Machek <pavel@suse.cz>
- * Copyright (C) 2002-2003 Nigel Cunningham <ncunningham@clear.net.nz>
- *
- * This file is released under the GPLv2.
- */
-
-#undef DEBUG
-
-#include <linux/smp_lock.h>
-#include <linux/interrupt.h>
-#include <linux/suspend.h>
-#include <linux/module.h>
-#include <linux/cpu.h>
-#include <asm/atomic.h>
-#include <asm/tlbflush.h>
-
-/* This is protected by pm_sem semaphore */
-static cpumask_t frozen_cpus;
-
-void disable_nonboot_cpus(void)
-{
-	int cpu, error;
-
-	error = 0;
-	cpus_clear(frozen_cpus);
-	printk("Freezing cpus ...\n");
-	for_each_online_cpu(cpu) {
-		if (cpu == 0)
-			continue;
-		error = cpu_down(cpu);
-		if (!error) {
-			cpu_set(cpu, frozen_cpus);
-			printk("CPU%d is down\n", cpu);
-			continue;
-		}
-		printk("Error taking cpu %d down: %d\n", cpu, error);
-	}
-	BUG_ON(raw_smp_processor_id() != 0);
-	if (error)
-		panic("cpus not sleeping");
-}
-
-void enable_nonboot_cpus(void)
-{
-	int cpu, error;
-
-	printk("Thawing cpus ...\n");
-	for_each_cpu_mask(cpu, frozen_cpus) {
-		error = cpu_up(cpu);
-		if (!error) {
-			printk("CPU%d is up\n", cpu);
-			continue;
-		}
-		printk("Error taking cpu %d up: %d\n", cpu, error);
-		panic("Not enough cpus");
-	}
-	cpus_clear(frozen_cpus);
-}
-
Index: linux-2.6.18-rc2/kernel/power/disk.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/power/disk.c	2006-07-26 08:52:49.000000000 +0200
+++ linux-2.6.18-rc2/kernel/power/disk.c	2006-07-27 08:06:15.000000000 +0200
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/pm.h>
+#include <linux/cpu.h>
 
 #include "power.h"
 
@@ -72,7 +73,10 @@ static int prepare_processes(void)
 	int error;
 
 	pm_prepare_console();
-	disable_nonboot_cpus();
+
+	error = disable_nonboot_cpus();
+	if (error)
+		goto enable_cpus;
 
 	if (freeze_processes()) {
 		error = -EBUSY;
@@ -84,6 +88,7 @@ static int prepare_processes(void)
 		return 0;
 thaw:
 	thaw_processes();
+enable_cpus:
 	enable_nonboot_cpus();
 	pm_restore_console();
 	return error;
Index: linux-2.6.18-rc2/kernel/power/main.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/power/main.c	2006-07-26 08:52:42.000000000 +0200
+++ linux-2.6.18-rc2/kernel/power/main.c	2006-07-27 08:06:09.000000000 +0200
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/pm.h>
 #include <linux/console.h>
+#include <linux/cpu.h>
 
 #include "power.h"
 
@@ -51,7 +52,7 @@ void pm_set_ops(struct pm_ops * ops)
 
 static int suspend_prepare(suspend_state_t state)
 {
-	int error = 0;
+	int error;
 	unsigned int free_pages;
 
 	if (!pm_ops || !pm_ops->enter)
@@ -59,12 +60,9 @@ static int suspend_prepare(suspend_state
 
 	pm_prepare_console();
 
-	disable_nonboot_cpus();
-
-	if (num_online_cpus() != 1) {
-		error = -EPERM;
+	error = disable_nonboot_cpus();
+	if (error)
 		goto Enable_cpu;
-	}
 
 	if (freeze_processes()) {
 		error = -EAGAIN;
Index: linux-2.6.18-rc2/kernel/power/user.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/power/user.c	2006-07-26 08:52:49.000000000 +0200
+++ linux-2.6.18-rc2/kernel/power/user.c	2006-07-27 08:05:56.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/swapops.h>
 #include <linux/pm.h>
 #include <linux/fs.h>
+#include <linux/cpu.h>
 
 #include <asm/uaccess.h>
 
@@ -139,12 +140,15 @@ static int snapshot_ioctl(struct inode *
 		if (data->frozen)
 			break;
 		down(&pm_sem);
-		disable_nonboot_cpus();
-		if (freeze_processes()) {
-			thaw_processes();
-			enable_nonboot_cpus();
-			error = -EBUSY;
+		error = disable_nonboot_cpus();
+		if (!error) {
+			error = freeze_processes();
+			if (error) {
+				thaw_processes();
+				error = -EBUSY;
+			}
 		}
+		enable_nonboot_cpus();
 		up(&pm_sem);
 		if (!error)
 			data->frozen = 1;
Index: linux-2.6.18-rc2/include/linux/cpu.h
===================================================================
--- linux-2.6.18-rc2.orig/include/linux/cpu.h	2006-07-16 11:38:15.000000000 +0200
+++ linux-2.6.18-rc2/include/linux/cpu.h	2006-07-27 08:05:35.000000000 +0200
@@ -95,4 +95,12 @@ int cpu_down(unsigned int cpu);
 static inline int cpu_is_offline(int cpu) { return 0; }
 #endif
 
+#ifdef CONFIG_SUSPEND_SMP
+extern int disable_nonboot_cpus(void);
+extern void enable_nonboot_cpus(void);
+#else
+static inline int disable_nonboot_cpus(void) { return 0; }
+static inline void enable_nonboot_cpus(void) {}
+#endif
+
 #endif /* _LINUX_CPU_H_ */
Index: linux-2.6.18-rc2/kernel/cpu.c
===================================================================
--- linux-2.6.18-rc2.orig/kernel/cpu.c	2006-07-16 11:38:16.000000000 +0200
+++ linux-2.6.18-rc2/kernel/cpu.c	2006-07-27 08:15:35.000000000 +0200
@@ -20,6 +20,11 @@ static DEFINE_MUTEX(cpucontrol);
 
 static __cpuinitdata BLOCKING_NOTIFIER_HEAD(cpu_chain);
 
+/* If set, cpu_up and cpu_down will return -EPERM and do nothing.
+ * Should always be manipulated with the cpucontrol mutex locked.
+ */
+static int cpu_hotplug_disabled;
+
 #ifdef CONFIG_HOTPLUG_CPU
 static struct task_struct *lock_cpu_hotplug_owner;
 static int lock_cpu_hotplug_depth;
@@ -116,32 +121,25 @@ static int take_cpu_down(void *unused)
 	return 0;
 }
 
-int cpu_down(unsigned int cpu)
+/* Requires the cpucontrol mutex to be locked */
+static int __cpu_down(unsigned int cpu)
 {
 	int err;
 	struct task_struct *p;
 	cpumask_t old_allowed, tmp;
 
-	if ((err = lock_cpu_hotplug_interruptible()) != 0)
-		return err;
-
-	if (num_online_cpus() == 1) {
-		err = -EBUSY;
-		goto out;
-	}
+	if (num_online_cpus() == 1)
+		return -EBUSY;
 
-	if (!cpu_online(cpu)) {
-		err = -EINVAL;
-		goto out;
-	}
+	if (!cpu_online(cpu))
+		return -EINVAL;
 
 	err = blocking_notifier_call_chain(&cpu_chain, CPU_DOWN_PREPARE,
 						(void *)(long)cpu);
 	if (err == NOTIFY_BAD) {
 		printk("%s: attempt to take down CPU %u failed\n",
 				__FUNCTION__, cpu);
-		err = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	/* Ensure that we are not runnable on dying cpu */
@@ -186,7 +184,22 @@ out_thread:
 	err = kthread_stop(p);
 out_allowed:
 	set_cpus_allowed(current, old_allowed);
-out:
+	return err;
+}
+
+int cpu_down(unsigned int cpu)
+{
+	int err;
+
+	err = lock_cpu_hotplug_interruptible();
+	if (err)
+		return err;
+
+	if (cpu_hotplug_disabled)
+		err = -EPERM;
+	else
+		err = __cpu_down(cpu);
+
 	unlock_cpu_hotplug();
 	return err;
 }
@@ -200,6 +213,11 @@ int __devinit cpu_up(unsigned int cpu)
 	if ((ret = lock_cpu_hotplug_interruptible()) != 0)
 		return ret;
 
+	if (cpu_hotplug_disabled) {
+		ret = -EPERM;
+		goto out;
+	}
+
 	if (cpu_online(cpu) || !cpu_present(cpu)) {
 		ret = -EINVAL;
 		goto out;
@@ -230,3 +248,64 @@ out:
 	unlock_cpu_hotplug();
 	return ret;
 }
+
+#ifdef CONFIG_SUSPEND_SMP
+static cpumask_t frozen_cpus;
+
+int disable_nonboot_cpus(void)
+{
+	int cpu, error = 0;
+
+	/* We take down all of the non-boot CPUs in one shot to avoid races
+	 * with the userspace trying to use the CPU hotplug at the same time
+	 */
+	lock_cpu_hotplug();
+	cpus_clear(frozen_cpus);
+	printk("Disabling non-boot CPUs ...\n");
+	for_each_online_cpu(cpu) {
+		if (cpu == 0)
+			continue;
+		error = __cpu_down(cpu);
+		if (!error) {
+			cpu_set(cpu, frozen_cpus);
+			printk("CPU%d is down\n", cpu);
+		} else {
+			printk(KERN_ERR "Error taking CPU%d down: %d\n",
+				cpu, error);
+			break;
+		}
+	}
+	if (!error) {
+		BUG_ON(num_online_cpus() > 1);
+		BUG_ON(raw_smp_processor_id() != 0);
+		/* Make sure the CPUs won't be enabled by someone else */
+		cpu_hotplug_disabled = 1;
+	} else {
+		printk(KERN_ERR "Non-boot CPUs are not disabled");
+	}
+	unlock_cpu_hotplug();
+	return error;
+}
+
+void enable_nonboot_cpus(void)
+{
+	int cpu, error;
+
+	/* Allow everyone to use the CPU hotplug again */
+	lock_cpu_hotplug();
+	cpu_hotplug_disabled = 0;
+	unlock_cpu_hotplug();
+
+	printk("Enabling non-boot CPUs ...\n");
+	for_each_cpu_mask(cpu, frozen_cpus) {
+		error = cpu_up(cpu);
+		if (!error) {
+			printk("CPU%d is up\n", cpu);
+			continue;
+		}
+		printk(KERN_WARNING "Error taking CPU%d up: %d\n",
+			cpu, error);
+	}
+	cpus_clear(frozen_cpus);
+}
+#endif
Index: linux-2.6.18-rc2/kernel/power/Makefile
===================================================================
--- linux-2.6.18-rc2.orig/kernel/power/Makefile	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc2/kernel/power/Makefile	2006-07-27 08:07:28.000000000 +0200
@@ -7,6 +7,4 @@ obj-y				:= main.o process.o console.o
 obj-$(CONFIG_PM_LEGACY)		+= pm.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o swap.o user.o
 
-obj-$(CONFIG_SUSPEND_SMP)	+= smp.o
-
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o

