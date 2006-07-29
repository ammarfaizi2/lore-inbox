Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWG2XIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWG2XIf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 19:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWG2XIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 19:08:35 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:48001 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750741AbWG2XIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 19:08:34 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm][resend] Disable CPU hotplug during suspend
Date: Sun, 30 Jul 2006 01:07:49 +0200
User-Agent: KMail/1.9.3
Cc: Nathan Lynch <ntl@pobox.com>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <200607281015.30048.rjw@sisk.pl> <200607291418.32366.rjw@sisk.pl> <20060729214031.GP19076@localdomain>
In-Reply-To: <20060729214031.GP19076@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607300107.49863.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 July 2006 23:40, Nathan Lynch wrote:
> Rafael J. Wysocki wrote:
> > On Saturday 29 July 2006 00:40, Nathan Lynch wrote:
> > 
> > > But maybe I'm misunderstanding the motivation for using cpu 0 here.  I
> > > had assumed it was because on i386 (and others?) the BSP can't be
> > > offlined.  Is there some other reason?
> > 
> > Yes.
> > 
> > First, the arch-dependent suspend code assumes implicitly that it will be
> > running on the BSP, so some strange things may happen if it doesn't.
> > 
> > Second, we have to make sure that this function will always leaves the
> > same CPU online.  It's a bit difficult to explain, but I'll do my best.
> > Suppose that disable_nonboot_cpus() exits running on CPU1, assuming it's
> > possible.  Then the system memory state saved in the suspend image will
> > reflect this situation.  Now the resume code will almost certainly run on the
> > BSP (say it's CPU0), but when the system memory is restored from the suspend
> > image the kernel will think it's running on CPU1.
> > 
> > In the last patch I send yesterday I made disable_nonboot_cpus() check if the
> > first present CPU, first_cpu(cpu_present_map), is online, try to bring it up
> > if not and migrate itself to it before the loop over all online CPUs is run.
> > 
> > I think that's general enough.
> 
> I see, thanks for the explanation.
> 
> It doesn't look like SMP swsusp would work reliably on platforms where
> there's a possibility of the cpu maps in the resume and saved images
> not matching (e.g. ppc64 logical partitions, where cpu 0 could be
> removed before suspending).  But I guess that's largely a theoretical
> concern at this time. ;)

I think so. :-)

Appended is the full patch with corrections resulting from our discussion
here.

Andrew, could you please replace disable-cpu-hotplug-during-suspend.patch
with this one?

---
The current suspend code has to be run on one CPU, so we use the CPU
hotplug to take the non-boot CPUs offline on SMP machines.  However, we
should also make sure that these CPUs will not be enabled by someone else
after we have disabled them.

The functions disable_nonboot_cpus() and enable_nonboot_cpus() are moved to
kernel/cpu.c, because they now refer to some stuff in there that should
better be static.  Also it's better if disable_nonboot_cpus() returns an
error instead of panicking if something goes wrong, and
enable_nonboot_cpus() has no reason to panic(), because the CPUs may have
been enabled by the userland before it tries to take them online.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 include/linux/cpu.h     |    8 ++
 include/linux/suspend.h |    8 --
 kernel/cpu.c            |  138 +++++++++++++++++++++++++++++++++++++++++-------
 kernel/power/Makefile   |    2 
 kernel/power/disk.c     |    7 ++
 kernel/power/main.c     |   10 +--
 kernel/power/smp.c      |   62 ---------------------
 kernel/power/user.c     |   14 +++-
 8 files changed, 145 insertions(+), 104 deletions(-)

Index: linux-2.6.18-rc2-mm1/include/linux/suspend.h
===================================================================
--- linux-2.6.18-rc2-mm1.orig/include/linux/suspend.h	2006-07-28 21:03:21.000000000 +0200
+++ linux-2.6.18-rc2-mm1/include/linux/suspend.h	2006-07-28 21:03:25.000000000 +0200
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
Index: linux-2.6.18-rc2-mm1/kernel/power/smp.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/kernel/power/smp.c	2006-07-28 21:03:21.000000000 +0200
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
Index: linux-2.6.18-rc2-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/kernel/power/disk.c	2006-07-28 21:03:21.000000000 +0200
+++ linux-2.6.18-rc2-mm1/kernel/power/disk.c	2006-07-28 23:25:13.000000000 +0200
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
Index: linux-2.6.18-rc2-mm1/kernel/power/main.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/kernel/power/main.c	2006-07-28 21:03:21.000000000 +0200
+++ linux-2.6.18-rc2-mm1/kernel/power/main.c	2006-07-28 21:03:25.000000000 +0200
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
@@ -63,12 +64,9 @@ static int suspend_prepare(suspend_state
 
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
Index: linux-2.6.18-rc2-mm1/kernel/power/user.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/kernel/power/user.c	2006-07-28 21:03:21.000000000 +0200
+++ linux-2.6.18-rc2-mm1/kernel/power/user.c	2006-07-28 21:03:25.000000000 +0200
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
Index: linux-2.6.18-rc2-mm1/include/linux/cpu.h
===================================================================
--- linux-2.6.18-rc2-mm1.orig/include/linux/cpu.h	2006-07-28 21:03:21.000000000 +0200
+++ linux-2.6.18-rc2-mm1/include/linux/cpu.h	2006-07-28 21:03:25.000000000 +0200
@@ -89,4 +89,12 @@ int cpu_down(unsigned int cpu);
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
Index: linux-2.6.18-rc2-mm1/kernel/cpu.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/kernel/cpu.c	2006-07-28 21:03:21.000000000 +0200
+++ linux-2.6.18-rc2-mm1/kernel/cpu.c	2006-07-28 23:25:08.000000000 +0200
@@ -21,6 +21,11 @@ static DEFINE_MUTEX(cpu_bitmask_lock);
 
 static __cpuinitdata BLOCKING_NOTIFIER_HEAD(cpu_chain);
 
+/* If set, cpu_up and cpu_down will return -EBUSY and do nothing.
+ * Should always be manipulated under cpu_add_remove_lock
+ */
+static int cpu_hotplug_disabled;
+
 #ifdef CONFIG_HOTPLUG_CPU
 
 /* Crappy recursive lock-takers in cpufreq! Complain loudly about idiots */
@@ -108,30 +113,25 @@ static int take_cpu_down(void *unused)
 	return 0;
 }
 
-int cpu_down(unsigned int cpu)
+/* Requires cpu_add_remove_lock to be held */
+static int _cpu_down(unsigned int cpu)
 {
 	int err;
 	struct task_struct *p;
 	cpumask_t old_allowed, tmp;
 
-	mutex_lock(&cpu_add_remove_lock);
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
@@ -179,22 +179,32 @@ out_thread:
 	err = kthread_stop(p);
 out_allowed:
 	set_cpus_allowed(current, old_allowed);
-out:
+	return err;
+}
+
+int cpu_down(unsigned int cpu)
+{
+	int err = 0;
+
+	mutex_lock(&cpu_add_remove_lock);
+	if (cpu_hotplug_disabled)
+		err = -EBUSY;
+	else
+		err = _cpu_down(cpu);
+
 	mutex_unlock(&cpu_add_remove_lock);
 	return err;
 }
 #endif /*CONFIG_HOTPLUG_CPU*/
 
-int __devinit cpu_up(unsigned int cpu)
+/* Requires cpu_add_remove_lock to be held */
+static int __devinit _cpu_up(unsigned int cpu)
 {
 	int ret;
 	void *hcpu = (void *)(long)cpu;
 
-	mutex_lock(&cpu_add_remove_lock);
-	if (cpu_online(cpu) || !cpu_present(cpu)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (cpu_online(cpu) || !cpu_present(cpu))
+		return -EINVAL;
 
 	ret = blocking_notifier_call_chain(&cpu_chain, CPU_UP_PREPARE, hcpu);
 	if (ret == NOTIFY_BAD) {
@@ -219,7 +229,95 @@ out_notify:
 	if (ret != 0)
 		blocking_notifier_call_chain(&cpu_chain,
 				CPU_UP_CANCELED, hcpu);
+
+	return ret;
+}
+
+int __devinit cpu_up(unsigned int cpu)
+{
+	int err = 0;
+
+	mutex_lock(&cpu_add_remove_lock);
+	if (cpu_hotplug_disabled)
+		err = -EBUSY;
+	else
+		err = _cpu_up(cpu);
+
+	mutex_unlock(&cpu_add_remove_lock);
+	return err;
+}
+
+#ifdef CONFIG_SUSPEND_SMP
+static cpumask_t frozen_cpus;
+
+int disable_nonboot_cpus(void)
+{
+	int cpu, first_cpu, error;
+
+	mutex_lock(&cpu_add_remove_lock);
+	first_cpu = first_cpu(cpu_present_map);
+	if (!cpu_online(first_cpu)) {
+		error = _cpu_up(first_cpu);
+		if (error) {
+			printk(KERN_ERR "Could not bring CPU%d up.\n",
+				first_cpu);
+			goto out;
+		}
+	}
+	error = set_cpus_allowed(current, cpumask_of_cpu(first_cpu));
+	if (error) {
+		printk(KERN_ERR "Could not run on CPU%d\n", first_cpu);
+		goto out;
+	}
+	/* We take down all of the non-boot CPUs in one shot to avoid races
+	 * with the userspace trying to use the CPU hotplug at the same time
+	 */
+	cpus_clear(frozen_cpus);
+	printk("Disabling non-boot CPUs ...\n");
+	for_each_online_cpu(cpu) {
+		if (cpu == first_cpu)
+			continue;
+		error = _cpu_down(cpu);
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
+		/* Make sure the CPUs won't be enabled by someone else */
+		cpu_hotplug_disabled = 1;
+	} else {
+		printk(KERN_ERR "Non-boot CPUs are not disabled");
+	}
 out:
 	mutex_unlock(&cpu_add_remove_lock);
-	return ret;
+	return error;
+}
+
+void enable_nonboot_cpus(void)
+{
+	int cpu, error;
+
+	/* Allow everyone to use the CPU hotplug again */
+	mutex_lock(&cpu_add_remove_lock);
+	cpu_hotplug_disabled = 0;
+	mutex_unlock(&cpu_add_remove_lock);
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
 }
+#endif
Index: linux-2.6.18-rc2-mm1/kernel/power/Makefile
===================================================================
--- linux-2.6.18-rc2-mm1.orig/kernel/power/Makefile	2006-07-28 21:03:21.000000000 +0200
+++ linux-2.6.18-rc2-mm1/kernel/power/Makefile	2006-07-28 21:03:25.000000000 +0200
@@ -7,6 +7,4 @@ obj-y				:= main.o process.o console.o
 obj-$(CONFIG_PM_LEGACY)		+= pm.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o swap.o user.o
 
-obj-$(CONFIG_SUSPEND_SMP)	+= smp.o
-
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
