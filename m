Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319511AbSIMBxa>; Thu, 12 Sep 2002 21:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319488AbSIMBvp>; Thu, 12 Sep 2002 21:51:45 -0400
Received: from dp.samba.org ([66.70.73.150]:14288 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319493AbSIMBu5>;
	Thu, 12 Sep 2002 21:50:57 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Hot unplug CPU 3/4
Date: Fri, 13 Sep 2002 11:55:09 +1000
Message-Id: <20020913015549.447922C06D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: set_cpus_allowed can fail
Author: Rusty Russell
Status: Tested on 2.5.30 SMP
Depends: Hotcpu/cpumask.patch.gz

D: Simply moves the "is this mask valid?" check inside set_cpus_allowed,
D: since it might be racy otherwise in the context of adding/removing
D: CPUs.  This also introduces the CPU brlock.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32767-linux-2.5.33/arch/i386/kernel/smpboot.c .32767-linux-2.5.33.updated/arch/i386/kernel/smpboot.c
--- .32767-linux-2.5.33/arch/i386/kernel/smpboot.c	2002-09-04 16:04:52.000000000 +1000
+++ .32767-linux-2.5.33.updated/arch/i386/kernel/smpboot.c	2002-09-04 16:05:11.000000000 +1000
@@ -45,6 +45,7 @@
 
 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
+#include <linux/brlock.h>
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
@@ -458,8 +459,9 @@ int __init start_secondary(void *unused)
 	 * the local TLBs too.
 	 */
 	local_flush_tlb();
-	set_bit(smp_processor_id(), cpu_online_map);
-	wmb();
+	br_write_lock_irq(BR_CPU_LOCK);
+  	set_bit(smp_processor_id(), cpu_online_map);
+	br_write_unlock_irq(BR_CPU_LOCK);
 	return cpu_idle();
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32767-linux-2.5.33/arch/ppc/kernel/smp.c .32767-linux-2.5.33.updated/arch/ppc/kernel/smp.c
--- .32767-linux-2.5.33/arch/ppc/kernel/smp.c	2002-09-04 16:04:52.000000000 +1000
+++ .32767-linux-2.5.33.updated/arch/ppc/kernel/smp.c	2002-09-04 16:05:11.000000000 +1000
@@ -432,7 +432,9 @@ int __cpu_up(unsigned int cpu)
 	printk("Processor %d found.\n", cpu);
 
 	smp_ops->give_timebase();
-	set_bit(cpu, cpu_online_map);
+	br_write_lock_irq(BR_CPU_LOCK);
+	set_bit(cpu, &cpu_online_map);
+	br_write_unlock_irq(BR_CPU_LOCK);
 	return 0;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32767-linux-2.5.33/include/linux/brlock.h .32767-linux-2.5.33.updated/include/linux/brlock.h
--- .32767-linux-2.5.33/include/linux/brlock.h	2002-08-28 09:29:52.000000000 +1000
+++ .32767-linux-2.5.33.updated/include/linux/brlock.h	2002-09-04 16:05:11.000000000 +1000
@@ -34,6 +34,7 @@
 /* Register bigreader lock indices here. */
 enum brlock_indices {
 	BR_NETPROTO_LOCK,
+	BR_CPU_LOCK,
 	__BR_END
 };
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32767-linux-2.5.33/include/linux/sched.h .32767-linux-2.5.33.updated/include/linux/sched.h
--- .32767-linux-2.5.33/include/linux/sched.h	2002-09-04 16:04:53.000000000 +1000
+++ .32767-linux-2.5.33.updated/include/linux/sched.h	2002-09-04 16:05:11.000000000 +1000
@@ -425,9 +425,14 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define _STK_LIM	(8*1024*1024)
 
 #if CONFIG_SMP
-extern void set_cpus_allowed(task_t *p, const unsigned long new_mask[]);
+extern int set_cpus_allowed(task_t *p, const unsigned long new_mask[]);
 #else
-# define set_cpus_allowed(p, new_mask) do { } while (0)
+static inline int set_cpus_allowed(struct task_struct *p,
+				   const unsigned long *new_mask)
+{
+	if (!(*new_mask & 1)) return -EINVAL;
+	return 0;
+}
 #endif
 #define CPU_MASK_NONE { 0 }
 #define CPU_MASK_ALL { [0 ... BITS_TO_LONG(NR_CPUS)-1 ] = ~0UL }
@@ -435,9 +440,9 @@ extern void set_cpus_allowed(task_t *p, 
 static inline void migrate_to_cpu(unsigned int cpu)
 {
 	DECLARE_BITMAP(mask, NR_CPUS) = CPU_MASK_NONE;
-	BUG_ON(!cpu_online(cpu));
 	__set_bit(cpu, mask);
-	set_cpus_allowed(current, mask);
+	if (set_cpus_allowed(current, mask) != 0)
+		BUG();
 }
 
 extern void set_user_nice(task_t *p, long nice);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32767-linux-2.5.33/kernel/sched.c .32767-linux-2.5.33.updated/kernel/sched.c
--- .32767-linux-2.5.33/kernel/sched.c	2002-09-04 16:04:53.000000000 +1000
+++ .32767-linux-2.5.33.updated/kernel/sched.c	2002-09-04 16:05:32.000000000 +1000
@@ -30,6 +30,7 @@
 #include <linux/notifier.h>
 #include <linux/delay.h>
 #include <linux/bitops.h>
+#include <linux/brlock.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -1553,9 +1554,6 @@ asmlinkage int sys_sched_setaffinity(pid
 	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
 		return -EFAULT;
 
-	if (any_online_cpu(new_mask) == NR_CPUS)
-		return -EINVAL;
-
 	read_lock(&tasklist_lock);
 
 	p = find_process_by_pid(pid);
@@ -1577,8 +1575,7 @@ asmlinkage int sys_sched_setaffinity(pid
 			!capable(CAP_SYS_NICE))
 		goto out_unlock;
 
-	retval = 0;
-	set_cpus_allowed(p, new_mask);
+	retval = set_cpus_allowed(p, new_mask);
 
 out_unlock:
 	put_task_struct(p);
@@ -1914,29 +1911,30 @@ typedef struct {
  * task must not exit() & deallocate itself prematurely.  The
  * call is not atomic; no spinlocks may be held.
  */
-void set_cpus_allowed(task_t *p, const unsigned long new_mask[])
+int set_cpus_allowed(task_t *p, const unsigned long new_mask[])
 {
 	unsigned long flags;
 	migration_req_t req;
 	runqueue_t *rq;
-
-#if 0 /* FIXME: Grab cpu_lock, return error on this case. --RR */
-	new_mask &= cpu_online_map;
-	if (!new_mask)
-		BUG();
-#endif
+	int ret = 0;
 
 	preempt_disable();
 	rq = task_rq_lock(p, &flags);
+	/* Let's not deal with cpus leaving us */
+	br_read_lock(BR_CPU_LOCK);
+	if (any_online_cpu(new_mask) == NR_CPUS) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	memcpy(p->cpus_allowed, new_mask, sizeof(p->cpus_allowed));
 	/*
 	 * Can the task run on the task's current CPU? If not then
 	 * migrate the thread off to a proper CPU.
 	 */
-	if (test_bit(task_cpu(p), new_mask)) {
-		task_rq_unlock(rq, &flags);
-		goto out;
-	}
+	if (test_bit(task_cpu(p), new_mask))
+		goto out_unlock;
+
 	/*
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
@@ -1944,17 +1942,24 @@ void set_cpus_allowed(task_t *p, const u
 	if (!p->array && !task_running(rq, p)) {
 		set_task_cpu(p, any_online_cpu(p->cpus_allowed));
 		task_rq_unlock(rq, &flags);
-		goto out;
+		goto out_unlock;
 	}
 	init_completion(&req.done);
 	req.task = p;
 	list_add(&req.list, &rq->migration_queue);
+	br_read_unlock(BR_CPU_LOCK);
 	task_rq_unlock(rq, &flags);
 	wake_up_process(rq->migration_thread);
 
 	wait_for_completion(&req.done);
-out:
 	preempt_enable();
+	return 0;
+
+ out_unlock:
+	br_read_unlock(BR_CPU_LOCK);
+	task_rq_unlock(rq, &flags);
+	preempt_enable();
+	return ret;
 }
 
 /*

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
