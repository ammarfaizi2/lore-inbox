Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVIYGng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVIYGng (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 02:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVIYGng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 02:43:36 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:32093 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751201AbVIYGne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 02:43:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=inNgHxcG85FszceyV8ijLEkpR7xCIrzulvefL9WPXKiljfcCPrey1DdlVdsFdcEBOg0jmn4N/DyCLcf74hFAtlbrolwA7hFjvmZVMK6VQUSpuyDtyeCEV6Ibit1BXPiEroCweVzSou2sqzLRpNv572TE3JUfAz0znTus1kHuWew=
From: Tejun Heo <htejun@gmail.com>
To: zwane@linuxpower.ca, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050925064218.E7558977@htj.dyndns.org>
In-Reply-To: <20050925064218.E7558977@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6 04/04] brsem: convert cpucontrol to brsem
Message-ID: <20050925064218.642A9DFD@htj.dyndns.org>
Date: Sun, 25 Sep 2005 15:43:27 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

04_brsem_convert-cpucontrol-to-brsem.patch

	cpucontrol synchronizes cpu hotplugging and used to be a
	semaphore.  This patch converts it to brsem.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 include/linux/brsem.h |    4 +-
 include/linux/cpu.h   |   16 ++++++---
 init/main.c           |    1 
 kernel/brsem.c        |   38 +++++++++++++++--------
 kernel/cpu.c          |   81 +++++++++++++++++++++++++++++++++++++++++++-------
 5 files changed, 110 insertions(+), 30 deletions(-)

Index: linux-work/include/linux/cpu.h
===================================================================
--- linux-work.orig/include/linux/cpu.h	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/include/linux/cpu.h	2005-09-25 15:42:04.000000000 +0900
@@ -23,7 +23,7 @@
 #include <linux/node.h>
 #include <linux/compiler.h>
 #include <linux/cpumask.h>
-#include <asm/semaphore.h>
+#include <linux/brsem.h>
 
 struct cpu {
 	int node_id;		/* The node which contains the CPU */
@@ -59,10 +59,11 @@ extern struct sysdev_class cpu_sysdev_cl
 
 #ifdef CONFIG_HOTPLUG_CPU
 /* Stop CPUs going up and down. */
-extern struct semaphore cpucontrol;
-#define lock_cpu_hotplug()	down(&cpucontrol)
-#define unlock_cpu_hotplug()	up(&cpucontrol)
-#define lock_cpu_hotplug_interruptible() down_interruptible(&cpucontrol)
+extern struct brsem cpucontrol;
+extern struct task_struct *cpucontrol_holder;
+#define lock_cpu_hotplug()	brsem_down_read(&cpucontrol)
+#define unlock_cpu_hotplug()	brsem_up_read(&cpucontrol)
+#define is_cpu_hotplug_holder()	(cpucontrol_holder == current)
 #define hotcpu_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
 		{ .notifier_call = fn, .priority = pri };	\
@@ -74,11 +75,14 @@ extern int __attribute__((weak)) smp_pre
 #else
 #define lock_cpu_hotplug()	do { } while (0)
 #define unlock_cpu_hotplug()	do { } while (0)
-#define lock_cpu_hotplug_interruptible() 0
+#define is_cpu_hotplug_holder()	0
 #define hotcpu_notifier(fn, pri)
 
 /* CPUs don't go offline once they're online w/o CONFIG_HOTPLUG_CPU */
 static inline int cpu_is_offline(int cpu) { return 0; }
 #endif
 
+/* cpucontrol initializer, called from init/main.c */
+void cpucontrol_init(void);
+
 #endif /* _LINUX_CPU_H_ */
Index: linux-work/init/main.c
===================================================================
--- linux-work.orig/init/main.c	2005-09-25 15:42:03.000000000 +0900
+++ linux-work/init/main.c	2005-09-25 15:42:04.000000000 +0900
@@ -513,6 +513,7 @@ asmlinkage void __init start_kernel(void
 	setup_per_cpu_pageset();
 	numa_policy_init();
 	brsem_init_early();
+	cpucontrol_init();
 	if (late_time_init)
 		late_time_init();
 	calibrate_delay();
Index: linux-work/kernel/cpu.c
===================================================================
--- linux-work.orig/kernel/cpu.c	2005-09-25 15:26:32.000000000 +0900
+++ linux-work/kernel/cpu.c	2005-09-25 15:42:04.000000000 +0900
@@ -15,8 +15,39 @@
 #include <linux/stop_machine.h>
 #include <asm/semaphore.h>
 
-/* This protects CPUs going up and down... */
-DECLARE_MUTEX(cpucontrol);
+/*
+ * cpucontrol is a brsem used to synchronize cpu hotplug events.
+ * Invoking lock_cpu_hotplug() read-locks cpucontrol and no
+ * hotplugging events will occur until it's released.
+ *
+ * Unfortunately, brsem itself makes use of lock_cpu_hotplug() and
+ * performing brsem write-lock operations on cpucontrol deadlocks.
+ * This is avoided by...
+ *
+ * a. guaranteeing that cpu hotplug events won't occur during the
+ *    write-lock operations, and
+ *
+ * b. skipping lock_cpu_hotplug() inside brsem.
+ *
+ * #a is achieved by acquiring and releasing cpucontrol_mutex outside
+ * cpucontrol write-lock.  #b is achieved by skipping
+ * lock_cpu_hotplug() inside brsem if the current task is
+ * cpucontrol_mutex holder (is_cpu_hotplug_holder() test).
+ *
+ * Also, note that cpucontrol is first initialized with
+ * BRSEM_BYPASS_INITIALIZER and then initialized again with
+ * __create_brsem() instead of simply using create_brsem().  This is
+ * necessary as cpucontrol brsem gets used way before brsem subsystem
+ * becomes up and running.
+ *
+ * Until brsem is properly initialized, all brsem ops succeed
+ * unconditionally.  cpucontrol becomes operational only after
+ * cpucontrol_init() is finished, which should be called after
+ * brsem_init_early().
+ */
+struct brsem cpucontrol = BRSEM_BYPASS_INITIALIZER;
+static DECLARE_MUTEX(cpucontrol_mutex);
+struct task_struct *cpucontrol_holder;
 
 static struct notifier_block *cpu_chain;
 
@@ -25,22 +56,45 @@ int register_cpu_notifier(struct notifie
 {
 	int ret;
 
-	if ((ret = down_interruptible(&cpucontrol)) != 0)
+	if ((ret = brsem_down_read_interruptible(&cpucontrol)) != 0)
 		return ret;
 	ret = notifier_chain_register(&cpu_chain, nb);
-	up(&cpucontrol);
+	brsem_up_read(&cpucontrol);
 	return ret;
 }
 EXPORT_SYMBOL(register_cpu_notifier);
 
 void unregister_cpu_notifier(struct notifier_block *nb)
 {
-	down(&cpucontrol);
+	brsem_down_read(&cpucontrol);
 	notifier_chain_unregister(&cpu_chain, nb);
-	up(&cpucontrol);
+	brsem_up_read(&cpucontrol);
 }
 EXPORT_SYMBOL(unregister_cpu_notifier);
 
+static int write_lock_cpucontrol(void)
+{
+	int ret;
+
+	if ((ret = down_interruptible(&cpucontrol_mutex)) != 0)
+		return ret;
+	BUG_ON(cpucontrol_holder);
+	cpucontrol_holder = current;
+	if ((ret = brsem_down_write_interruptible(&cpucontrol)) != 0) {
+		cpucontrol_holder = NULL;
+		up(&cpucontrol_mutex);
+		return ret;
+	}
+	return 0;
+}
+
+static void write_unlock_cpucontrol(void)
+{
+	brsem_up_write(&cpucontrol);
+	cpucontrol_holder = NULL;
+	up(&cpucontrol_mutex);
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 static inline void check_for_tasks(int cpu)
 {
@@ -80,7 +134,7 @@ int cpu_down(unsigned int cpu)
 	struct task_struct *p;
 	cpumask_t old_allowed, tmp;
 
-	if ((err = lock_cpu_hotplug_interruptible()) != 0)
+	if ((err = write_lock_cpucontrol()) != 0)
 		return err;
 
 	if (num_online_cpus() == 1) {
@@ -145,7 +199,7 @@ out_thread:
 out_allowed:
 	set_cpus_allowed(current, old_allowed);
 out:
-	unlock_cpu_hotplug();
+	write_unlock_cpucontrol();
 	return err;
 }
 #endif /*CONFIG_HOTPLUG_CPU*/
@@ -155,7 +209,7 @@ int __devinit cpu_up(unsigned int cpu)
 	int ret;
 	void *hcpu = (void *)(long)cpu;
 
-	if ((ret = down_interruptible(&cpucontrol)) != 0)
+	if ((ret = write_lock_cpucontrol()) != 0)
 		return ret;
 
 	if (cpu_online(cpu) || !cpu_present(cpu)) {
@@ -184,6 +238,13 @@ out_notify:
 	if (ret != 0)
 		notifier_call_chain(&cpu_chain, CPU_UP_CANCELED, hcpu);
 out:
-	up(&cpucontrol);
+	write_unlock_cpucontrol();
 	return ret;
 }
+
+void cpucontrol_init(void)
+{
+	struct brsem *sem;
+	sem = __create_brsem(&cpucontrol);
+	BUG_ON(!sem);
+}
Index: linux-work/kernel/brsem.c
===================================================================
--- linux-work.orig/kernel/brsem.c	2005-09-25 15:42:03.000000000 +0900
+++ linux-work/kernel/brsem.c	2005-09-25 15:42:04.000000000 +0900
@@ -156,7 +156,7 @@ static void coac_schedule_work_per_cpu(v
 	schedule_work(works + smp_processor_id());
 }
 
-static void call_on_all_cpus(void (*func)(void *), void *data)
+static void call_on_all_cpus(void (*func)(void *), void *data, int skip_cpulock)
 {
 	static DECLARE_MUTEX(coac_mutex); /* serializes uses of coac_works */
 	static struct work_struct coac_works[NR_CPUS];
@@ -174,7 +174,8 @@ static void call_on_all_cpus(void (*func
 	}
 
 	down(&coac_mutex);
-	lock_cpu_hotplug();
+	if (!skip_cpulock)
+		lock_cpu_hotplug();
 
 	/*
 	 * If we're on keventd, scheduling work and waiting for it
@@ -202,7 +203,8 @@ static void call_on_all_cpus(void (*func
 		wait_for_completion(&coac_arg.completion);
 	}
 
-	unlock_cpu_hotplug();
+	if (!skip_cpulock)
+		unlock_cpu_hotplug();
 	up(&coac_mutex);
 }
 
@@ -305,7 +307,7 @@ static int expand_brsem(int target_idx)
 	ebarg.new_len = new_len;
 	atomic_set(&ebarg.failed, 0);
 
-	call_on_all_cpus(expand_brsem_cpucb, &ebarg);
+	call_on_all_cpus(expand_brsem_cpucb, &ebarg, 0);
 
 	res = -ENOMEM;
 	if (atomic_read(&ebarg.failed))
@@ -405,13 +407,13 @@ static void sync_brsem_cpucb(void *data)
 	__brsem_leave_crit();
 }
 
-static void sync_brsem(struct brsem *sem, int write_locking)
+static void sync_brsem(struct brsem *sem, int write_locking, int skip_cpulock)
 {
 	int cpu;
 
 	if (brsem_initialized) {
 		struct sync_brsem_arg sbarg = { sem, write_locking };
-		call_on_all_cpus(sync_brsem_cpucb, &sbarg);
+		call_on_all_cpus(sync_brsem_cpucb, &sbarg, skip_cpulock);
 		return;
 	}
 
@@ -420,7 +422,8 @@ static void sync_brsem(struct brsem *sem
 	 * single threaded.  Sync manually.  Note that lockings are
 	 * not necessary here.  They're done just for consistency.
 	 */
-	lock_cpu_hotplug();
+	if (!skip_cpulock)
+		lock_cpu_hotplug();
 	spin_lock_crit(&sem->lock);
 	for_each_online_cpu(cpu) {
 		int *p = per_cpu(brsem_rcnt_ar, cpu) + sem->idx;
@@ -429,14 +432,15 @@ static void sync_brsem(struct brsem *sem
 		*p = write_locking ? INT_MIN : 0;
 	}
 	spin_unlock_crit(&sem->lock);
-	unlock_cpu_hotplug();
+	if (!skip_cpulock)
+		unlock_cpu_hotplug();
 }
 
 static void do_destroy_brsem(struct brsem *sem)
 {
 	check_idx(sem);
 
-	sync_brsem(sem, 0);
+	sync_brsem(sem, 0, 0);
 	BUG_ON(sem->master_rcnt != 0);
 
 	spin_lock(&brsem_alloc_lock);
@@ -586,8 +590,14 @@ void __brsem_up_read_slow(struct brsem *
 	__brsem_leave_crit();
 }
 
+/*
+ * skip_cpulock is used to avoid deadlocks when write operations are
+ * performed on cpu hotplug brsem.  See kernel/cpu.c for more
+ * information.
+ */
 static int __brsem_down_write(struct brsem *sem, int interruptible)
 {
+	int skip_cpulock = is_cpu_hotplug_holder();
 	int res;
 
 	if (is_bypass(sem))
@@ -601,7 +611,7 @@ static int __brsem_down_write(struct brs
 	} else
 		down(&sem->write_mutex);
 
-	sync_brsem(sem, 1);
+	sync_brsem(sem, 1, skip_cpulock);
 
 	spin_lock_crit(&sem->lock);
 
@@ -619,7 +629,7 @@ static int __brsem_down_write(struct brs
 		finish_wait(&sem->write_wait, &wait);
 
 		if (interruptible && signal_pending(current)) {
-			sync_brsem(sem, 0);
+			sync_brsem(sem, 0, skip_cpulock);
 			wake_up_all(&sem->read_wait);
 			up(&sem->write_mutex);
 			return -EINTR;
@@ -661,12 +671,14 @@ int brsem_down_write_interruptible(struc
  */
 void brsem_up_write(struct brsem *sem)
 {
+	int skip_cpulock = is_cpu_hotplug_holder();
+
 	if (is_bypass(sem))
 		return;
 	check_idx(sem);
 
 	BUG_ON(sem->master_rcnt);
-	sync_brsem(sem, 0);
+	sync_brsem(sem, 0, skip_cpulock);
 	wake_up_all(&sem->read_wait);
 	up(&sem->write_mutex);
 }
@@ -856,7 +868,7 @@ void __init brsem_init(void)
 	brsem_initialized = 1;
 
 	/* Make sure other cpus see above change */
-	call_on_all_cpus(dummy_cpucb, NULL);
+	call_on_all_cpus(dummy_cpucb, NULL, 0);
 }
 
 EXPORT_SYMBOL(__create_brsem);
Index: linux-work/include/linux/brsem.h
===================================================================
--- linux-work.orig/include/linux/brsem.h	2005-09-25 15:42:03.000000000 +0900
+++ linux-work/include/linux/brsem.h	2005-09-25 15:42:04.000000000 +0900
@@ -65,7 +65,9 @@ void brsem_init(void);
 
 /*
  * The following initializer and __create_brsem() are for cases where
- * brsem should be used before brsem_init_early() is finished.
+ * brsem should be used before brsem_init_early() is finished.  If
+ * you're trying to use brsem for such cases, refer to
+ * include/linux/cpu.h and kernel/cpu.c for example.
  */
 #define BRSEM_BYPASS_INITIALIZER	{ .idx = 0, .flags = BRSEM_F_BYPASS }
 

