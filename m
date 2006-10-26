Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423270AbWJZK4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423270AbWJZK4w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423274AbWJZK4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:56:51 -0400
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:40364 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1423270AbWJZK4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:56:49 -0400
Date: Thu, 26 Oct 2006 16:27:31 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: rusty@rustcorp.com.au, torvalds@osdl.org, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, vatsa@in.ibm.com,
       dipankar@in.ibm.com, gaughen@us.ibm.com, arjan@linux.intel.org,
       davej@redhat.com, venkatesh.pallipadi@intel.com, kiran@scalex86.org
Subject: [PATCH 4/5] lock_cpu_hotplug: Redesign - Lightweight implementation of lock_cpu_hotplug.
Message-ID: <20061026105731.GE11803@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061026104858.GA11803@in.ibm.com> <20061026105058.GB11803@in.ibm.com> <20061026105342.GC11803@in.ibm.com> <20061026105523.GD11803@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026105523.GD11803@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Refcount + Workqueue) implementation for cpu_hotplug "locking".
It is analogous to a unfair rwsem. But it is *extremely* lightweight in 
the reader-fast-path.

Based on valuable inputs by Paul E McKenney, Srivatsa Vaddagiri, Dipankar Sarma
and Ingo Molnar.

Signed-off-by : Gautham R Shenoy <ego@in.ibm.com>

---
 include/linux/cpu.h |    2 
 init/main.c         |    1 
 kernel/cpu.c        |  231 ++++++++++++++++++++++++++++++++++++++++++----------
 3 files changed, 194 insertions(+), 40 deletions(-)

Index: hotplug/init/main.c
===================================================================
--- hotplug.orig/init/main.c
+++ hotplug/init/main.c
@@ -573,6 +573,7 @@ asmlinkage void __init start_kernel(void
 	vfs_caches_init_early();
 	cpuset_init_early();
 	mem_init();
+	cpu_hotplug_init();
 	kmem_cache_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
Index: hotplug/include/linux/cpu.h
===================================================================
--- hotplug.orig/include/linux/cpu.h
+++ hotplug/include/linux/cpu.h
@@ -65,6 +65,7 @@ static inline void unregister_cpu_notifi
 extern struct sysdev_class cpu_sysdev_class;
 
 #ifdef CONFIG_HOTPLUG_CPU
+extern void cpu_hotplug_init(void);
 /* Stop CPUs going up and down. */
 extern void lock_cpu_hotplug(void);
 extern void unlock_cpu_hotplug(void);
@@ -78,6 +79,7 @@ extern void unlock_cpu_hotplug(void);
 int cpu_down(unsigned int cpu);
 #define cpu_is_offline(cpu) unlikely(!cpu_online(cpu))
 #else
+#define cpu_hotplug_init()	do { } while (0)
 #define lock_cpu_hotplug()	do { } while (0)
 #define unlock_cpu_hotplug()	do { } while (0)
 #define lock_cpu_hotplug_interruptible() 0
Index: hotplug/kernel/cpu.c
===================================================================
--- hotplug.orig/kernel/cpu.c
+++ hotplug/kernel/cpu.c
@@ -1,6 +1,10 @@
 /* CPU control.
  * (C) 2001, 2002, 2003, 2004 Rusty Russell
  *
+ * Hotplug - Locking
+ * 2006: Implemented by Gautham R Shenoy with the aid of some valuable inputs
+ * from Paul E McKenney, Srivatsa Vaddagiri, Dipankar Sarma and Ingo Molnar.
+ *
  * This code is licenced under the GPL.
  */
 #include <linux/proc_fs.h>
@@ -14,10 +18,11 @@
 #include <linux/kthread.h>
 #include <linux/stop_machine.h>
 #include <linux/mutex.h>
-
-/* This protects CPUs going up and down... */
-static DEFINE_MUTEX(cpu_add_remove_lock);
-static DEFINE_MUTEX(cpu_bitmask_lock);
+#include <asm/percpu.h>
+#include <linux/cpumask.h>
+#include <linux/types.h>
+#include <linux/wait.h>
+#include <linux/rcupdate.h>
 
 static __cpuinitdata RAW_NOTIFIER_HEAD(cpu_chain);
 
@@ -26,52 +31,202 @@ static __cpuinitdata RAW_NOTIFIER_HEAD(c
  */
 static int cpu_hotplug_disabled;
 
+/************************************************************************
+ *                    A FEW CONTEXT SPECIFIC DEFINITIONS		*
+ * ---------------------------------------------------------------------*
+ * - reader : task which tries to *prevent* a cpu hotplug event.      	*
+ * - writer : task which tries to *perform* a cpu hotplug event.	*
+ * - write-operation: cpu hotplug operation.                          	*
+ *                                                                    	*
+ ************************************************************************/
+
+/************************************************************************
+ *                    THE PROTOCOL                                    	*
+ *----------------------------------------------------------------------*
+ *- Analogous to RWSEM, only not so fair                              	*
+ *- Readers assume control iff:						*
+ *    a) No other reader has a reference and no writer is writing.	*
+ *    OR								*
+ *    b) Atleast one reader (on *any* cpu) has a reference.		*
+ *- Writer assumes control iff:						*
+ *  there are no active readers and there are no active writers.	*
+ *- Writer, on completion would preferable wake up other waiting.	*
+ *  writers over the waiting readers.					*
+ *- The *last* writer wakes up all the waiting readers.			*
+ ************************************************************************/
+
+static struct {
+	unsigned int status; /* Read mostly global */
+	/* The following variables are only for the slowpath */
+	spinlock_t lock;
+	wait_queue_head_t read_queue;
+	wait_queue_head_t write_queue;
+} cpu_hotplug;
+
+DEFINE_PER_CPU(int, refcount) = {0};
+
+ /* cpu_hotplug.status can be one of the following */
+#define NO_WRITERS    	0x00000000 /* Obvious from name */
+#define WRITER_WAITING  0x00000001 /* Writer present, but is waiting */
+#define WRITER_ACTIVE	0x00000002 /* Writer is performing write */
+
+#define writer_exists() cpu_hotplug.status
+
+/* Returns the number of readers in the system */
+static inline int nr_readers(void)
+{
+	int count=0, i;
+
+	for_each_possible_cpu(i)
+		count +=  per_cpu(refcount, i);
+
+	return count;
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
+void __init cpu_hotplug_init(void)
+{
+	cpu_hotplug.status = NO_WRITERS;
+	spin_lock_init(&cpu_hotplug.lock);
+	init_waitqueue_head(&cpu_hotplug.read_queue);
+	init_waitqueue_head(&cpu_hotplug.write_queue);
+}
 
-/* Crappy recursive lock-takers in cpufreq! Complain loudly about idiots */
-static struct task_struct *recursive;
-static int recursive_depth;
+static void slow_path_reader_lock(void);
+static void slow_path_reader_unlock(void);
 
+/**********************************************************************
+       MAIN CPU_HOTPLUG (LOCK/ UNLOCK/ BEGIN/ DONE) CODE
+ *********************************************************************/
+
+/*  Blocks iff write operation is on-going
+*  OR
+*  A writer is waiting and there are no other readers.
+*/
 void lock_cpu_hotplug(void)
 {
-	struct task_struct *tsk = current;
-
-	if (tsk == recursive) {
-		static int warnings = 10;
-		if (warnings) {
-			printk(KERN_ERR "Lukewarm IQ detected in hotplug locking\n");
-			WARN_ON(1);
-			warnings--;
-		}
-		recursive_depth++;
+	preempt_disable();
+	if (likely(!writer_exists())) {
+		per_cpu(refcount, smp_processor_id())++;
+		preempt_enable();
 		return;
 	}
-	mutex_lock(&cpu_bitmask_lock);
-	recursive = tsk;
+	preempt_enable();
+	slow_path_reader_lock();
 }
 EXPORT_SYMBOL_GPL(lock_cpu_hotplug);
 
 void unlock_cpu_hotplug(void)
 {
-	WARN_ON(recursive != current);
-	if (recursive_depth) {
-		recursive_depth--;
+	preempt_disable();
+	if (likely(!writer_exists())) {
+		per_cpu(refcount, smp_processor_id())--;
+		preempt_enable();
 		return;
 	}
-	mutex_unlock(&cpu_bitmask_lock);
-	recursive = NULL;
+	preempt_enable();
+	slow_path_reader_unlock();
 }
 EXPORT_SYMBOL_GPL(unlock_cpu_hotplug);
 
+#endif /* CONFIG_HOTPLUG_CPU */
+
+static void cpu_hotplug_begin(void)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	spin_lock(&cpu_hotplug.lock);
+	if (likely(cpu_hotplug.status == NO_WRITERS)) {
+		cpu_hotplug.status = WRITER_WAITING;
+		spin_unlock(&cpu_hotplug.lock);
+
+		/* Allow new readers to see this change in status and
+		 * notify them to take the slowpath.
+		 *
+		 * Also allow the older readers who have not seen the status
+		 * change to bump up/down their percpu refcount.
+		 */
+		synchronize_sched();
+
+		spin_lock(&cpu_hotplug.lock);
+		if (!nr_readers()) {
+			cpu_hotplug.status = WRITER_ACTIVE;
+			spin_unlock(&cpu_hotplug.lock);
+			return;
+		}
+	}
+
+	add_wait_queue_exclusive(&cpu_hotplug.write_queue, &wait);
+	__set_current_state(TASK_UNINTERRUPTIBLE);
+	spin_unlock(&cpu_hotplug.lock);
+	schedule();
+	remove_wait_queue(&cpu_hotplug.write_queue, &wait);
+}
+
+static void cpu_hotplug_done(void)
+{
+	spin_lock(&cpu_hotplug.lock);
+
+	if (!list_empty(&cpu_hotplug.write_queue.task_list))
+		wake_up(&cpu_hotplug.write_queue);
+	else {
+		cpu_hotplug.status = NO_WRITERS;
+		if (!list_empty(&cpu_hotplug.read_queue.task_list))
+			wake_up_all(&cpu_hotplug.read_queue);
+	}
+
+	spin_unlock(&cpu_hotplug.lock);
+}
+
+/**********************************************************************
+			READER SLOWPATH CODE.
+ **********************************************************************/
+#ifdef CONFIG_HOTPLUG_CPU
+static void slow_path_reader_lock(void)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	spin_lock(&cpu_hotplug.lock);
+
+	while (writer_exists()) {
+		/* This check makes the whole business unfair */
+		if (cpu_hotplug.status == WRITER_WAITING && nr_readers())
+			goto out;
+
+		add_wait_queue(&cpu_hotplug.read_queue, &wait);
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+		spin_unlock(&cpu_hotplug.lock);
+		schedule();
+		remove_wait_queue(&cpu_hotplug.read_queue, &wait);
+		spin_lock(&cpu_hotplug.lock);
+	}
+out:
+	per_cpu(refcount, smp_processor_id())++;
+	spin_unlock(&cpu_hotplug.lock);
+
+}
+
+static void slow_path_reader_unlock(void)
+{
+	spin_lock(&cpu_hotplug.lock);
+	per_cpu(refcount, smp_processor_id())--;
+	if (!nr_readers() &&
+		!list_empty(&cpu_hotplug.write_queue.task_list)) {
+		cpu_hotplug.status = WRITER_ACTIVE;
+		wake_up(&cpu_hotplug.write_queue);
+	}
+	spin_unlock(&cpu_hotplug.lock);
+}
+
 #endif	/* CONFIG_HOTPLUG_CPU */
 
 /* Need to know about CPUs going up/down? */
 int __cpuinit register_cpu_notifier(struct notifier_block *nb)
 {
 	int ret;
-	mutex_lock(&cpu_add_remove_lock);
+	lock_cpu_hotplug();
 	ret = raw_notifier_chain_register(&cpu_chain, nb);
-	mutex_unlock(&cpu_add_remove_lock);
+	unlock_cpu_hotplug();
 	return ret;
 }
 
@@ -81,9 +236,9 @@ EXPORT_SYMBOL(register_cpu_notifier);
 
 void unregister_cpu_notifier(struct notifier_block *nb)
 {
-	mutex_lock(&cpu_add_remove_lock);
+	lock_cpu_hotplug();
 	raw_notifier_chain_unregister(&cpu_chain, nb);
-	mutex_unlock(&cpu_add_remove_lock);
+	unlock_cpu_hotplug();
 }
 EXPORT_SYMBOL(unregister_cpu_notifier);
 
@@ -146,9 +301,7 @@ static int _cpu_down(unsigned int cpu)
 	cpu_clear(cpu, tmp);
 	set_cpus_allowed(current, tmp);
 
-	mutex_lock(&cpu_bitmask_lock);
 	p = __stop_machine_run(take_cpu_down, NULL, cpu);
-	mutex_unlock(&cpu_bitmask_lock);
 
 	if (IS_ERR(p)) {
 		/* CPU didn't die: tell everyone.  Can't complain. */
@@ -192,13 +345,13 @@ int cpu_down(unsigned int cpu)
 {
 	int err = 0;
 
-	mutex_lock(&cpu_add_remove_lock);
+	cpu_hotplug_begin();
 	if (cpu_hotplug_disabled)
 		err = -EBUSY;
 	else
 		err = _cpu_down(cpu);
 
-	mutex_unlock(&cpu_add_remove_lock);
+	cpu_hotplug_done();
 	return err;
 }
 #endif /*CONFIG_HOTPLUG_CPU*/
@@ -221,9 +374,7 @@ static int __devinit _cpu_up(unsigned in
 	}
 
 	/* Arch-specific enabling code. */
-	mutex_lock(&cpu_bitmask_lock);
 	ret = __cpu_up(cpu);
-	mutex_unlock(&cpu_bitmask_lock);
 	if (ret != 0)
 		goto out_notify;
 	BUG_ON(!cpu_online(cpu));
@@ -243,13 +394,13 @@ int __devinit cpu_up(unsigned int cpu)
 {
 	int err = 0;
 
-	mutex_lock(&cpu_add_remove_lock);
+	cpu_hotplug_begin();
 	if (cpu_hotplug_disabled)
 		err = -EBUSY;
 	else
 		err = _cpu_up(cpu);
 
-	mutex_unlock(&cpu_add_remove_lock);
+	cpu_hotplug_done();
 	return err;
 }
 
@@ -260,7 +411,7 @@ int disable_nonboot_cpus(void)
 {
 	int cpu, first_cpu, error;
 
-	mutex_lock(&cpu_add_remove_lock);
+	cpu_hotplug_begin();
 	first_cpu = first_cpu(cpu_present_map);
 	if (!cpu_online(first_cpu)) {
 		error = _cpu_up(first_cpu);
@@ -301,7 +452,7 @@ int disable_nonboot_cpus(void)
 		printk(KERN_ERR "Non-boot CPUs are not disabled");
 	}
 out:
-	mutex_unlock(&cpu_add_remove_lock);
+	cpu_hotplug_done();
 	return error;
 }
 
@@ -310,9 +461,9 @@ void enable_nonboot_cpus(void)
 	int cpu, error;
 
 	/* Allow everyone to use the CPU hotplug again */
-	mutex_lock(&cpu_add_remove_lock);
+	lock_cpu_hotplug();
 	cpu_hotplug_disabled = 0;
-	mutex_unlock(&cpu_add_remove_lock);
+	unlock_cpu_hotplug();
 
 	printk("Enabling non-boot CPUs ...\n");
 	for_each_cpu_mask(cpu, frozen_cpus) {
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
