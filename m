Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSHHHix>; Thu, 8 Aug 2002 03:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSHHHix>; Thu, 8 Aug 2002 03:38:53 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:61632 "EHLO
	lists.samba.org") by vger.kernel.org with ESMTP id <S316538AbSHHHit>;
	Thu, 8 Aug 2002 03:38:49 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cpumask_t
Date: Thu, 08 Aug 2002 17:39:18 +1000
Message-Id: <20020808074422.E414A4ADA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, this removes the "NR_CPUS < BITS_PER_LONG" assumption, with a
few per-arch helpers (cpu_online_mask(mask) and any_online_cpu(mask)).

I've tested this now with making cpumask_t a struct, and it works fine
(at the moment it's unsigned long for every arch, no change).

First tiny patch adds a "migrate_to_cpu(cpu)" helper to handle that
(common) case simply.

Hot-unplug cpu patch does more cpu mask manip, so I want this fixed FIRST.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: migrate_to_cpu patch
Author: Rusty Russell
Status: Trivial

D: This patch adds an easy "migrate_to_cpu()" call for simple
D: in-kernel affinity, in preparation for generic cpu maps.

diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29.9350/Documentation/sched-coding.txt linux-2.5.29.9350.updated/Documentation/sched-coding.txt
--- linux-2.5.29.9350/Documentation/sched-coding.txt	Thu May 30 10:00:45 2002
+++ linux-2.5.29.9350.updated/Documentation/sched-coding.txt	Sat Jul 27 17:14:47 2002
@@ -103,7 +103,10 @@ void set_user_nice(task_t *p, long nice)
 	Sets the "nice" value of task p to the given value.
 int setscheduler(pid_t pid, int policy, struct sched_param *param)
 	Sets the scheduling policy and parameters for the given pid.
-void set_cpus_allowed(task_t *p, unsigned long new_mask)
+void migrate_to_cpu(unsigned int cpu)
+	Migrates the current task to the cpu and nails it there.  This
+	is a more convenient form of:
+void set_cpus_allowed(task_t *p, cpu_mask_t new_mask)
 	Sets a given task's CPU affinity and migrates it to a proper cpu.
 	Callers must have a valid reference to the task and assure the
 	task not exit prematurely.  No locks can be held during the call.
diff -urpN -I '\$.*\$' --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5600-linux-2.5.30/arch/ppc64/kernel/rtasd.c .5600-linux-2.5.30.updated/arch/ppc64/kernel/rtasd.c
--- .5600-linux-2.5.30/arch/ppc64/kernel/rtasd.c	2002-07-25 10:13:04.000000000 +1000
+++ .5600-linux-2.5.30.updated/arch/ppc64/kernel/rtasd.c	2002-08-06 10:56:10.000000000 +1000
@@ -226,7 +226,7 @@ repeat:
 			continue;
 
 		DEBUG("scheduling on %d\n", cpu);
-		set_cpus_allowed(current, 1UL << cpu);
+		migrate_to_cpu(cpu);
 		DEBUG("watchdog scheduled on cpu %d\n", smp_processor_id());
 
 		do {
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29.9350/include/linux/sched.h linux-2.5.29.9350.updated/include/linux/sched.h
--- linux-2.5.29.9350/include/linux/sched.h	Sat Jul 27 15:24:39 2002
+++ linux-2.5.29.9350.updated/include/linux/sched.h	Sat Jul 27 17:14:47 2002
@@ -411,8 +411,16 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 
 #if CONFIG_SMP
 extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
+static inline void migrate_to_cpu(unsigned int cpu)
+{
+	unsigned long mask = 0;
+	BUG_ON(!cpu_online(cpu));
+	__set_bit(cpu, &mask);
+	set_cpus_allowed(current, mask);
+}
 #else
-# define set_cpus_allowed(p, new_mask) do { } while (0)
+#define set_cpus_allowed(p, new_mask) do { } while (0)
+#define migrate_to_cpu(cpu) do { BUG_ON((cpu) != 0); } while(0)
 #endif
 
 extern void set_user_nice(task_t *p, long nice);
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29.9350/kernel/softirq.c linux-2.5.29.9350.updated/kernel/softirq.c
--- linux-2.5.29.9350/kernel/softirq.c	Sat Jul 27 16:07:05 2002
+++ linux-2.5.29.9350.updated/kernel/softirq.c	Sat Jul 27 17:14:47 2002
@@ -361,8 +361,7 @@ static int ksoftirqd(void * __bind_cpu)
 	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 
-	/* Migrate to the right CPU */
-	set_cpus_allowed(current, 1UL << cpu);
+	migrate_to_cpu(cpu);
 	if (smp_processor_id() != cpu)
 		BUG();
 
diff -urpN -I '\$.*\$' --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5600-linux-2.5.30/kernel/sched.c .5600-linux-2.5.30.updated/kernel/sched.c
--- .5600-linux-2.5.30/kernel/sched.c	2002-08-02 11:15:10.000000000 +1000
+++ .5600-linux-2.5.30.updated/kernel/sched.c	2002-08-06 10:56:45.000000000 +1000
@@ -1972,7 +1973,7 @@ static int migration_thread(void * data)
 	sigfillset(&current->blocked);
 	set_fs(KERNEL_DS);
 
-	set_cpus_allowed(current, 1UL << cpu);
+	migrate_to_cpu(cpu);
 
 	/*
 	 * Migration can happen without a migration thread on the
Name: CPU mask patch
Author: Rusty Russell
Status: Trivial
Depends: Hotcpu/migrate-to-cpu.patch.gz

D: This patch adds a cpumask_t for easy future expansion of cpu masks.
D: It also changes any_online_cpu to return NR_CPUS on failure, like
D: find_first_bit.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25506-2.5.30-cpumask.pre/include/asm-i386/smp.h .25506-2.5.30-cpumask/include/asm-i386/smp.h
--- .25506-2.5.30-cpumask.pre/include/asm-i386/smp.h	2002-08-02 11:15:10.000000000 +1000
+++ .25506-2.5.30-cpumask/include/asm-i386/smp.h	2002-08-08 17:27:18.000000000 +1000
@@ -90,17 +90,26 @@ extern volatile unsigned long cpu_callou
 #define cpu_possible(cpu) (cpu_callout_map & (1<<(cpu)))
 #define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
 
-extern inline unsigned int num_online_cpus(void)
+/* This has to be bitop capable, so for most archs, an unsigned long */
+typedef unsigned long cpumask_t;
+#define CPU_MASK_ALL (~0UL)
+#define CPU_MASK_NONE (0UL)
+
+static inline void cpu_online_mask(cpumask_t *res, const cpumask_t *mask)
 {
-	return hweight32(cpu_online_map);
+	*res = (*mask & cpu_online_map);
 }
 
-extern inline int any_online_cpu(unsigned int mask)
+static inline unsigned int any_online_cpu(const cpumask_t *mask)
 {
-	if (mask & cpu_online_map)
-		return __ffs(mask & cpu_online_map);
+	if (*mask & cpu_online_map)
+		return __ffs(*mask & cpu_online_map);
+	return NR_CPUS;
+}
 
-	return -1;
+static inline unsigned int num_online_cpus(void)
+{
+	return hweight32(cpu_online_map);
 }
 
 static __inline int hard_smp_processor_id(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25506-2.5.30-cpumask.pre/include/asm-ia64/smp.h .25506-2.5.30-cpumask/include/asm-ia64/smp.h
--- .25506-2.5.30-cpumask.pre/include/asm-ia64/smp.h	2002-06-20 01:28:51.000000000 +1000
+++ .25506-2.5.30-cpumask/include/asm-ia64/smp.h	2002-08-08 17:27:18.000000000 +1000
@@ -51,12 +51,22 @@ extern inline unsigned int num_online_cp
 	return hweight64(cpu_online_map);
 }
 
-extern inline int any_online_cpu(unsigned int mask)
+/* This has to be bitop capable, so for most archs, an unsigned long */
+typedef unsigned long cpumask_t;
+#define CPU_MASK_ALL (~0UL)
+#define CPU_MASK_NONE (0UL)
+
+static inline void cpu_online_mask(cpumask_t *res, const cpumask_t *mask)
 {
-	if (mask & cpu_online_map)
-		return __ffs(mask & cpu_online_map);
+	*res = (*mask & cpu_online_map);
+}
 
-	return -1;
+static inline unsigned int any_online_cpu(const cpumask_t *mask)
+{
+	if (*mask & cpu_online_map)
+		return __ffs(*mask & cpu_online_map);
+
+	return NR_CPUS;
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25506-2.5.30-cpumask.pre/include/asm-ppc/smp.h .25506-2.5.30-cpumask/include/asm-ppc/smp.h
--- .25506-2.5.30-cpumask.pre/include/asm-ppc/smp.h	2002-07-27 15:24:39.000000000 +1000
+++ .25506-2.5.30-cpumask/include/asm-ppc/smp.h	2002-08-08 17:27:18.000000000 +1000
@@ -56,12 +56,20 @@ extern inline unsigned int num_online_cp
 	return hweight32(cpu_online_map);
 }
 
-extern inline int any_online_cpu(unsigned int mask)
+typedef unsigned long cpumask_t;
+#define CPU_MASK_ALL (~0UL)
+#define CPU_MASK_NONE (0UL)
+
+static inline void cpu_online_mask(cpumask_t *res, const cpumask_t *mask)
 {
-	if (mask & cpu_online_map)
-		return __ffs(mask & cpu_online_map);
+	*res = (*mask & cpu_online_map);
+}
 
-	return -1;
+static inline unsigned int any_online_cpu(const cpumask_t *mask)
+{
+	if (*mask & cpu_online_map)
+		return __ffs(*mask & cpu_online_map);
+	return NR_CPUS;
 }
 
 extern int __cpu_up(unsigned int cpu);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25506-2.5.30-cpumask.pre/include/asm-ppc64/smp.h .25506-2.5.30-cpumask/include/asm-ppc64/smp.h
--- .25506-2.5.30-cpumask.pre/include/asm-ppc64/smp.h	2002-07-25 10:13:17.000000000 +1000
+++ .25506-2.5.30-cpumask/include/asm-ppc64/smp.h	2002-08-08 17:27:18.000000000 +1000
@@ -53,6 +53,23 @@ static inline int num_online_cpus(void)
 	return nr;
 }
 
+typedef unsigned long cpumask_t;
+#define CPU_MASK_ALL (~0UL)
+#define CPU_MASK_NONE (0UL)
+
+static inline void cpu_online_mask(cpumask_t *res, const cpumask_t *mask)
+{
+	*res = (mask & cpu_online_map);
+}
+
+static inline unsigned int any_online_cpu(const cpumask_t *mask)
+{
+	if (*mask & cpu_online_map)
+		return __ffs(*mask & cpu_online_map);
+
+	return NR_CPUS;
+}
+
 extern volatile unsigned long cpu_callin_map[NR_CPUS];
 
 #define smp_processor_id() (get_paca()->xPacaIndex)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25506-2.5.30-cpumask.pre/include/asm-sparc64/smp.h .25506-2.5.30-cpumask/include/asm-sparc64/smp.h
--- .25506-2.5.30-cpumask.pre/include/asm-sparc64/smp.h	2002-06-21 09:41:55.000000000 +1000
+++ .25506-2.5.30-cpumask/include/asm-sparc64/smp.h	2002-08-08 17:27:18.000000000 +1000
@@ -70,11 +70,20 @@ extern unsigned long cpu_online_map;
 extern atomic_t sparc64_num_cpus_online;
 #define num_online_cpus()	(atomic_read(&sparc64_num_cpus_online))
 
-static inline int any_online_cpu(unsigned long mask)
+typedef unsigned long cpumask_t;
+#define CPU_MASK_ALL (~0UL)
+#define CPU_MASK_NONE (0UL)
+
+static inline void cpu_online_mask(cpumask_t *res, const cpumask_t *mask)
 {
-	if ((mask &= cpu_online_map) != 0UL)
-		return __ffs(mask);
-	return -1;
+	*res = (*mask & cpu_online_map);
+}
+
+static inline int any_online_cpu(const cpumask_t *mask)
+{
+	if (*mask & cpu_online_map) != 0UL)
+		return __ffs(*mask & cpu_online_map);
+	return NR_CPUS;
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25506-2.5.30-cpumask.pre/include/linux/init_task.h .25506-2.5.30-cpumask/include/linux/init_task.h
--- .25506-2.5.30-cpumask.pre/include/linux/init_task.h	2002-07-25 10:13:18.000000000 +1000
+++ .25506-2.5.30-cpumask/include/linux/init_task.h	2002-08-08 17:27:18.000000000 +1000
@@ -48,7 +48,7 @@
     prio:		MAX_PRIO-20,					\
     static_prio:	MAX_PRIO-20,					\
     policy:		SCHED_NORMAL,					\
-    cpus_allowed:	-1,						\
+    cpus_allowed:	CPU_MASK_ALL,					\
     mm:			NULL,						\
     active_mm:		&init_mm,					\
     run_list:		LIST_HEAD_INIT(tsk.run_list),			\
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25506-2.5.30-cpumask.pre/include/linux/sched.h .25506-2.5.30-cpumask/include/linux/sched.h
--- .25506-2.5.30-cpumask.pre/include/linux/sched.h	2002-08-08 17:26:59.000000000 +1000
+++ .25506-2.5.30-cpumask/include/linux/sched.h	2002-08-08 17:27:18.000000000 +1000
@@ -20,6 +20,7 @@ extern unsigned long event;
 #include <asm/page.h>
 #include <asm/ptrace.h>
 #include <asm/mmu.h>
+#include <asm/current.h>
 
 #include <linux/smp.h>
 #include <linux/sem.h>
@@ -262,7 +263,7 @@ struct task_struct {
 	unsigned long sleep_timestamp;
 
 	unsigned long policy;
-	unsigned long cpus_allowed;
+	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
 
 	struct list_head tasks;
@@ -410,13 +411,13 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define _STK_LIM	(8*1024*1024)
 
 #if CONFIG_SMP
-extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
+extern void set_cpus_allowed(task_t *p, cpumask_t *new_mask);
 static inline void migrate_to_cpu(unsigned int cpu)
 {
-	unsigned long mask = 0;
+	cpumask_t mask = CPU_MASK_NONE;
 	BUG_ON(!cpu_online(cpu));
-	__set_bit(cpu, &mask);
-	set_cpus_allowed(current, mask);
+	__set_bit(cpu, (unsigned long *)&mask);
+	set_cpus_allowed(current, &mask);
 }
 #else
 #define set_cpus_allowed(p, new_mask) do { } while (0)
@@ -487,8 +488,6 @@ static inline struct task_struct *find_t
 extern struct user_struct * alloc_uid(uid_t);
 extern void free_uid(struct user_struct *);
 
-#include <asm/current.h>
-
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern void do_timer(struct pt_regs *);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25506-2.5.30-cpumask.pre/include/linux/smp.h .25506-2.5.30-cpumask/include/linux/smp.h
--- .25506-2.5.30-cpumask.pre/include/linux/smp.h	2002-08-02 11:15:10.000000000 +1000
+++ .25506-2.5.30-cpumask/include/linux/smp.h	2002-08-08 17:27:18.000000000 +1000
@@ -93,13 +93,18 @@ int cpu_up(unsigned int cpu);
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
-#define cpu_online_map				1
 #define cpu_online(cpu)				({ cpu; 1; })
 #define num_online_cpus()			1
 #define __per_cpu_data
 #define per_cpu(var, cpu)			var
 #define this_cpu(var)				var
 
+typedef unsigned long cpumask_t;
+#define CPU_MASK_ALL 1
+#define CPU_MASK_NONE 0
+#define cpu_online_mask(res,mask) do { *(res) = (*(mask) & 1); } while(0)
+#define any_online_cpu(mask) ((*(mask) & 1) ? 0 : 1)
+
 /* Need to know about CPUs going up/down? */
 static inline int register_cpu_notifier(struct notifier_block *nb)
 {
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25506-2.5.30-cpumask.pre/kernel/sched.c .25506-2.5.30-cpumask/kernel/sched.c
--- .25506-2.5.30-cpumask.pre/kernel/sched.c	2002-08-08 17:26:59.000000000 +1000
+++ .25506-2.5.30-cpumask/kernel/sched.c	2002-08-08 17:27:18.000000000 +1000
@@ -415,7 +415,8 @@ repeat_lock_task:
 		 */
 		if (unlikely(sync && !task_running(rq, p) &&
 			(task_cpu(p) != smp_processor_id()) &&
-			(p->cpus_allowed & (1UL << smp_processor_id())))) {
+			test_bit(smp_processor_id(),
+				 (unsigned long *)&p->cpus_allowed))) {
 
 			set_task_cpu(p, smp_processor_id());
 			task_rq_unlock(rq, &flags);
@@ -789,7 +790,7 @@ skip_queue:
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
 	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
 		!task_running(rq, p) &&					\
-			((p)->cpus_allowed & (1UL << (this_cpu))))
+		(test_bit((this_cpu), (unsigned long *)&(p)->cpus_allowed)))
 
 	curr = curr->prev;
 
@@ -1542,7 +1543,7 @@ out_unlock:
 asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
 				      unsigned long *user_mask_ptr)
 {
-	unsigned long new_mask;
+	cpumask_t online_mask, new_mask;
 	int retval;
 	task_t *p;
 
@@ -1552,8 +1553,8 @@ asmlinkage int sys_sched_setaffinity(pid
 	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
 		return -EFAULT;
 
-	new_mask &= cpu_online_map;
-	if (!new_mask)
+	cpu_online_mask(&online_mask, &new_mask);
+	if (find_first_bit((unsigned long *)&online_mask, NR_CPUS) == NR_CPUS)
 		return -EINVAL;
 
 	read_lock(&tasklist_lock);
@@ -1578,7 +1579,7 @@ asmlinkage int sys_sched_setaffinity(pid
 		goto out_unlock;
 
 	retval = 0;
-	set_cpus_allowed(p, new_mask);
+	set_cpus_allowed(p, &online_mask);
 
 out_unlock:
 	put_task_struct(p);
@@ -1595,7 +1596,7 @@ asmlinkage int sys_sched_getaffinity(pid
 				      unsigned long *user_mask_ptr)
 {
 	unsigned int real_len;
-	unsigned long mask;
+	cpumask_t mask;
 	int retval;
 	task_t *p;
 
@@ -1611,7 +1612,7 @@ asmlinkage int sys_sched_getaffinity(pid
 		goto out_unlock;
 
 	retval = 0;
-	mask = p->cpus_allowed & cpu_online_map;
+	cpu_online_mask(&mask, &p->cpus_allowed);
 
 out_unlock:
 	read_unlock(&tasklist_lock);
@@ -1914,7 +1915,7 @@ typedef struct {
  * task must not exit() & deallocate itself prematurely.  The
  * call is not atomic; no spinlocks may be held.
  */
-void set_cpus_allowed(task_t *p, unsigned long new_mask)
+void set_cpus_allowed(task_t *p, cpumask_t *new_mask)
 {
 	unsigned long flags;
 	migration_req_t req;
@@ -1928,12 +1929,12 @@ void set_cpus_allowed(task_t *p, unsigne
 
 	preempt_disable();
 	rq = task_rq_lock(p, &flags);
-	p->cpus_allowed = new_mask;
+	p->cpus_allowed = *new_mask;
 	/*
 	 * Can the task run on the task's current CPU? If not then
 	 * migrate the thread off to a proper CPU.
 	 */
-	if (new_mask & (1UL << task_cpu(p))) {
+	if (test_bit(task_cpu(p), (unsigned long *)new_mask)) {
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
@@ -1942,7 +1943,8 @@ void set_cpus_allowed(task_t *p, unsigne
 	 * it is sufficient to simply update the task's cpu field.
 	 */
 	if (!p->array && !task_running(rq, p)) {
-		set_task_cpu(p, __ffs(p->cpus_allowed));
+		set_task_cpu(p, any_online_cpu(&p->cpus_allowed));
+		BUG_ON(task_cpu(p) >= NR_CPUS);
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
@@ -2010,7 +2012,7 @@ static int migration_thread(void * data)
 		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed);
+		cpu_dest = any_online_cpu(&p->cpus_allowed);
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
 		cpu_src = task_cpu(p);
