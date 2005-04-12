Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVDLFi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVDLFi6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVDLFh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:37:28 -0400
Received: from fmr20.intel.com ([134.134.136.19]:12208 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S262050AbVDLFd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 01:33:56 -0400
Subject: [PATCH 6/6]suspend/resume SMP support
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1113283867.27646.434.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 12 Apr 2005 13:31:15 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using CPU hotplug to support suspend/resume SMP. Both S3 and S4 use
disable/enable_nonboot_cpus API. The S4 part is based on Pavel's
original S4 SMP patch.

Signed-off-by: Li Shaohua<shaohua.li@intel.com>
---

 linux-2.6.11-root/drivers/acpi/Kconfig    |    2 
 linux-2.6.11-root/include/linux/suspend.h |    2 
 linux-2.6.11-root/kernel/power/Kconfig    |    2 
 linux-2.6.11-root/kernel/power/disk.c     |   36 ++++++-----
 linux-2.6.11-root/kernel/power/main.c     |   16 +++--
 linux-2.6.11-root/kernel/power/smp.c      |   91 +++++++++++-------------------
 linux-2.6.11-root/kernel/power/swsusp.c   |    2 
 7 files changed, 69 insertions(+), 82 deletions(-)

diff -puN drivers/acpi/Kconfig~smp_sleep drivers/acpi/Kconfig
--- linux-2.6.11/drivers/acpi/Kconfig~smp_sleep	2005-04-12 11:11:14.884685080 +0800
+++ linux-2.6.11-root/drivers/acpi/Kconfig	2005-04-12 11:11:14.898682952 +0800
@@ -57,7 +57,7 @@ if ACPI_INTERPRETER
 
 config ACPI_SLEEP
 	bool "Sleep States (EXPERIMENTAL)"
-	depends on X86
+	depends on X86 && (!SMP || HOTPLUG_CPU)
 	depends on EXPERIMENTAL
 	default y
 	---help---
diff -puN include/linux/suspend.h~smp_sleep include/linux/suspend.h
--- linux-2.6.11/include/linux/suspend.h~smp_sleep	2005-04-12 11:11:14.885684928 +0800
+++ linux-2.6.11-root/include/linux/suspend.h	2005-04-12 11:11:14.898682952 +0800
@@ -58,7 +58,7 @@ static inline int software_suspend(void)
 }
 #endif
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_HOTPLUG_CPU
 extern void disable_nonboot_cpus(void);
 extern void enable_nonboot_cpus(void);
 #else
diff -puN kernel/power/disk.c~smp_sleep kernel/power/disk.c
--- linux-2.6.11/kernel/power/disk.c~smp_sleep	2005-04-12 11:11:14.887684624 +0800
+++ linux-2.6.11-root/kernel/power/disk.c	2005-04-12 11:11:14.899682800 +0800
@@ -117,8 +117,8 @@ static void finish(void)
 {
 	device_resume();
 	platform_finish();
-	enable_nonboot_cpus();
 	thaw_processes();
+	enable_nonboot_cpus();
 	pm_restore_console();
 }
 
@@ -131,28 +131,36 @@ static int prepare_processes(void)
 
 	sys_sync();
 
+	disable_nonboot_cpus();
+
 	if (freeze_processes()) {
 		error = -EBUSY;
-		return error;
+		goto enable_cpu;
 	}
 
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
 		if (pm_ops && pm_ops->prepare) {
 			if ((error = pm_ops->prepare(PM_SUSPEND_DISK)))
-				return error;
+				goto thaw;
 		}
 	}
 
 	/* Free memory before shutting down devices. */
 	free_some_memory();
-
 	return 0;
+thaw:
+	thaw_processes();
+enable_cpu:
+	enable_nonboot_cpus();
+	pm_restore_console();
+	return error;
 }
 
 static void unprepare_processes(void)
 {
-	enable_nonboot_cpus();
+	platform_finish();
 	thaw_processes();
+	enable_nonboot_cpus();
 	pm_restore_console();
 }
 
@@ -160,15 +168,9 @@ static int prepare_devices(void)
 {
 	int error;
 
-	disable_nonboot_cpus();
-	if ((error = device_suspend(PMSG_FREEZE))) {
+	if ((error = device_suspend(PMSG_FREEZE)))
 		printk("Some devices failed to suspend\n");
-		platform_finish();
-		enable_nonboot_cpus();
-		return error;
-	}
-
-	return 0;
+	return error;
 }
 
 /**
@@ -185,9 +187,9 @@ int pm_suspend_disk(void)
 	int error;
 
 	error = prepare_processes();
-	if (!error) {
-		error = prepare_devices();
-	}
+	if (error)
+		return error;
+	error = prepare_devices();
 
 	if (error) {
 		unprepare_processes();
@@ -250,7 +252,7 @@ static int software_resume(void)
 
 	if ((error = prepare_processes())) {
 		swsusp_close();
-		goto Cleanup;
+		goto Done;
 	}
 
 	pr_debug("PM: Reading swsusp image.\n");
diff -puN kernel/power/Kconfig~smp_sleep kernel/power/Kconfig
--- linux-2.6.11/kernel/power/Kconfig~smp_sleep	2005-04-12 11:11:14.888684472 +0800
+++ linux-2.6.11-root/kernel/power/Kconfig	2005-04-12 11:11:14.899682800 +0800
@@ -28,7 +28,7 @@ config PM_DEBUG
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM && SWAP
+	depends on EXPERIMENTAL && PM && SWAP && (HOTPLUG_CPU || !SMP)
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.
diff -puN kernel/power/main.c~smp_sleep kernel/power/main.c
--- linux-2.6.11/kernel/power/main.c~smp_sleep	2005-04-12 11:11:14.890684168 +0800
+++ linux-2.6.11-root/kernel/power/main.c	2005-04-12 11:11:14.899682800 +0800
@@ -59,6 +59,13 @@ static int suspend_prepare(suspend_state
 
 	pm_prepare_console();
 
+	disable_nonboot_cpus();
+
+	if (num_online_cpus() != 1) {
+		error = -EPERM;
+		goto Enable_cpu;
+	}
+
 	if (freeze_processes()) {
 		error = -EAGAIN;
 		goto Thaw;
@@ -89,6 +96,8 @@ static int suspend_prepare(suspend_state
 		pm_ops->finish(state);
  Thaw:
 	thaw_processes();
+ Enable_cpu:
+	enable_nonboot_cpus();
 	pm_restore_console();
 	return error;
 }
@@ -127,6 +136,7 @@ static void suspend_finish(suspend_state
 	if (pm_ops && pm_ops->finish)
 		pm_ops->finish(state);
 	thaw_processes();
+	enable_nonboot_cpus();
 	pm_restore_console();
 }
 
@@ -164,12 +174,6 @@ static int enter_state(suspend_state_t s
 		goto Unlock;
 	}
 
-	/* Suspend is hard to get right on SMP. */
-	if (num_online_cpus() != 1) {
-		error = -EPERM;
-		goto Unlock;
-	}
-
 	pr_debug("PM: Preparing system for suspend\n");
 	if ((error = suspend_prepare(state)))
 		goto Unlock;
diff -puN kernel/power/smp.c~smp_sleep kernel/power/smp.c
--- linux-2.6.11/kernel/power/smp.c~smp_sleep	2005-04-12 11:11:14.891684016 +0800
+++ linux-2.6.11-root/kernel/power/smp.c	2005-04-12 11:11:14.899682800 +0800
@@ -13,73 +13,52 @@
 #include <linux/interrupt.h>
 #include <linux/suspend.h>
 #include <linux/module.h>
+#include <linux/cpu.h>
 #include <asm/atomic.h>
 #include <asm/tlbflush.h>
 
-static atomic_t cpu_counter, freeze;
-
-
-static void smp_pause(void * data)
-{
-	struct saved_context ctxt;
-	__save_processor_state(&ctxt);
-	printk("Sleeping in:\n");
-	dump_stack();
-	atomic_inc(&cpu_counter);
-	while (atomic_read(&freeze)) {
-		/* FIXME: restore takes place at random piece inside this.
-		   This should probably be written in assembly, and
-		   preserve general-purpose registers, too
-
-		   What about stack? We may need to move to new stack here.
-
-		   This should better be ran with interrupts disabled.
-		 */
-		cpu_relax();
-		barrier();
-	}
-	atomic_dec(&cpu_counter);
-	__restore_processor_state(&ctxt);
-}
-
-static cpumask_t oldmask;
+/* This is protected by pm_sem semaphore */
+static cpumask_t frozen_cpus;
 
 void disable_nonboot_cpus(void)
 {
-	oldmask = current->cpus_allowed;
-	set_cpus_allowed(current, cpumask_of_cpu(0));
-	printk("Freezing CPUs (at %d)", _smp_processor_id());
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(HZ);
-	printk("...");
-	BUG_ON(_smp_processor_id() != 0);
-
-	/* FIXME: for this to work, all the CPUs must be running
-	 * "idle" thread (or we deadlock). Is that guaranteed? */
-
-	atomic_set(&cpu_counter, 0);
-	atomic_set(&freeze, 1);
-	smp_call_function(smp_pause, NULL, 0, 0);
-	while (atomic_read(&cpu_counter) < (num_online_cpus() - 1)) {
-		cpu_relax();
-		barrier();
+	int cpu, error;
+
+	error = 0;
+	cpus_clear(frozen_cpus);
+	printk("Freezing cpus ...\n");
+	for_each_online_cpu(cpu) {
+		if (cpu == 0)
+			continue;
+		error = cpu_down(cpu);
+		if (!error) {
+			cpu_set(cpu, frozen_cpus);
+			printk("CPU%d is down\n", cpu);
+			continue;
+		}
+		printk("Error taking cpu %d down: %d\n", cpu, error);
 	}
-	printk("ok\n");
+	BUG_ON(smp_processor_id() != 0);
+	if (error)
+		panic("cpus not sleeping");
 }
 
 void enable_nonboot_cpus(void)
 {
-	printk("Restarting CPUs");
-	atomic_set(&freeze, 0);
-	while (atomic_read(&cpu_counter)) {
-		cpu_relax();
-		barrier();
-	}
-	printk("...");
-	set_cpus_allowed(current, oldmask);
-	schedule();
-	printk("ok\n");
+	int cpu, error;
 
+	printk("Thawing cpus ...\n");
+	for_each_cpu_mask(cpu, frozen_cpus) {
+		error = smp_prepare_cpu(cpu);
+		if (!error)
+			error = cpu_up(cpu);
+		if (!error) {
+			printk("CPU%d is up\n", cpu);
+			continue;
+		}
+		printk("Error taking cpu %d up: %d\n", cpu, error);
+		panic("Not enough cpus");
+	}
+	cpus_clear(frozen_cpus);
 }
 
-
diff -puN kernel/power/swsusp.c~smp_sleep kernel/power/swsusp.c
--- linux-2.6.11/kernel/power/swsusp.c~smp_sleep	2005-04-12 11:11:14.892683864 +0800
+++ linux-2.6.11-root/kernel/power/swsusp.c	2005-04-12 11:11:14.900682648 +0800
@@ -1194,8 +1194,10 @@ static const char * sanity_check(void)
 		return "version";
 	if (strcmp(swsusp_info.uts.machine,system_utsname.machine))
 		return "machine";
+#if 0
 	if(swsusp_info.cpus != num_online_cpus())
 		return "number of cpus";
+#endif
 	return NULL;
 }
 
_


