Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSFTQCn>; Thu, 20 Jun 2002 12:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSFTQCm>; Thu, 20 Jun 2002 12:02:42 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:10695 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315200AbSFTQCf>; Thu, 20 Jun 2002 12:02:35 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cpu_mask_t
Date: Fri, 21 Jun 2002 02:06:54 +1000
Message-Id: <E17L4SV-0007hm-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that typedefing a struct makes the #includes really hairy
(asm/smp.h needs the definition which is in linux/sched.h), so I just
made it a per-arch typedef.  So, please discard the and_region patch.

I also fixed the migration code (it needs to combine the online map
with the allowed map to choose another CPU).

You can revert ChangeSet 1.490.1.66 (adds cpu_online_map for UP), as
noone should be using it directly now (outside per-arch, of course).

Name: CPU mask patch
Author: Rusty Russell
Status: Trivial

D: This patch adds a cpu_mask_t for easy future expansion of cpu masks,
D: and an easy "migrate_to_cpu()" call for simple in-kernel affinity.  It
D: also changes any_online_cpu to return NR_CPUS on failure, like
D: find_first_bit.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/Documentation/sched-coding.txt working-2.5.23-sched/Documentation/sched-coding.txt
--- linux-2.5.23/Documentation/sched-coding.txt	Thu May 30 10:00:45 2002
+++ working-2.5.23-sched/Documentation/sched-coding.txt	Fri Jun 21 00:48:15 2002
@@ -103,7 +103,10 @@
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/arch/ppc64/kernel/rtasd.c working-2.5.23-sched/arch/ppc64/kernel/rtasd.c
--- linux-2.5.23/arch/ppc64/kernel/rtasd.c	Mon Jun 10 16:03:47 2002
+++ working-2.5.23-sched/arch/ppc64/kernel/rtasd.c	Fri Jun 21 00:48:15 2002
@@ -221,7 +221,7 @@
 #endif
 
 	cpu = 0;
-	set_cpus_allowed(current, 1UL << cpu_logical_map(cpu));
+	migrate_to_cpu(cpu);
 
 	while(1) {
 		do {
@@ -255,8 +255,7 @@
 			cpu = 0;
 		}
 
-		set_cpus_allowed(current, 1UL << cpu_logical_map(cpu));
-
+		migrate_to_cpu(cpu);
 
 		/* Check all cpus for pending events before sleeping*/
 		if (!first_pass) {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/include/asm-i386/smp.h working-2.5.23-sched/include/asm-i386/smp.h
--- linux-2.5.23/include/asm-i386/smp.h	Thu Jun 20 01:28:51 2002
+++ working-2.5.23-sched/include/asm-i386/smp.h	Fri Jun 21 01:52:45 2002
@@ -99,14 +99,6 @@
 	return hweight32(cpu_online_map);
 }
 
-extern inline int any_online_cpu(unsigned int mask)
-{
-	if (mask & cpu_online_map)
-		return __ffs(mask & cpu_online_map);
-
-	return -1;
-}
-
 static __inline int hard_smp_processor_id(void)
 {
 	/* we don't want to mark this access volatile - bad code generation */
@@ -117,6 +109,23 @@
 {
 	/* we don't want to mark this access volatile - bad code generation */
 	return GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR));
+}
+
+/* This has to be bitop capable, so for most archs, an unsigned long */
+typedef unsigned long cpu_mask_t;
+#define CPU_MASK_ALL (~0UL)
+#define CPU_MASK_NONE (0UL)
+
+static inline void cpu_online_mask(cpu_mask_t *res, cpu_mask_t mask)
+{
+	*res = (mask & cpu_online_map);
+}
+
+static inline unsigned int any_online_cpu(cpu_mask_t mask)
+{
+	if (mask & cpu_online_map)
+		return __ffs(mask & cpu_online_map);
+	return NR_CPUS;
 }
 
 #endif /* !__ASSEMBLY__ */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/include/asm-ia64/smp.h working-2.5.23-sched/include/asm-ia64/smp.h
--- linux-2.5.23/include/asm-ia64/smp.h	Thu Jun 20 01:28:51 2002
+++ working-2.5.23-sched/include/asm-ia64/smp.h	Fri Jun 21 01:53:00 2002
@@ -51,12 +51,22 @@
 	return hweight64(cpu_online_map);
 }
 
-extern inline int any_online_cpu(unsigned int mask)
+/* This has to be bitop capable, so for most archs, an unsigned long */
+typedef unsigned long cpu_mask_t;
+#define CPU_MASK_ALL (~0UL)
+#define CPU_MASK_NONE (0UL)
+
+static inline void cpu_online_mask(cpu_mask_t *res, cpu_mask_t mask)
+{
+	*res = (mask & cpu_online_map);
+}
+
+static inline unsigned int any_online_cpu(cpu_mask_t mask)
 {
 	if (mask & cpu_online_map)
 		return __ffs(mask & cpu_online_map);
 
-	return -1;
+	return NR_CPUS;
 }
 
 /*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/include/asm-ppc/smp.h working-2.5.23-sched/include/asm-ppc/smp.h
--- linux-2.5.23/include/asm-ppc/smp.h	Thu Jun 20 01:28:51 2002
+++ working-2.5.23-sched/include/asm-ppc/smp.h	Fri Jun 21 01:53:12 2002
@@ -54,12 +54,21 @@
 	return hweight32(cpu_online_map);
 }
 
-extern inline int any_online_cpu(unsigned int mask)
+typedef unsigned long cpu_mask_t;
+#define CPU_MASK_ALL (~0UL)
+#define CPU_MASK_NONE (0UL)
+
+static inline void cpu_online_mask(cpu_mask_t *res, cpu_mask_t mask)
+{
+	*res = (mask & cpu_online_map);
+}
+
+static inline unsigned int any_online_cpu(cpu_mask_t mask)
 {
 	if (mask & cpu_online_map)
 		return __ffs(mask & cpu_online_map);
 
-	return -1;
+	return NR_CPUS;
 }
 
 extern int smp_hw_index[];
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/include/linux/init_task.h working-2.5.23-sched/include/linux/init_task.h
--- linux-2.5.23/include/linux/init_task.h	Sun May 19 12:07:34 2002
+++ working-2.5.23-sched/include/linux/init_task.h	Fri Jun 21 01:50:32 2002
@@ -48,7 +48,7 @@
     prio:		MAX_PRIO-20,					\
     static_prio:	MAX_PRIO-20,					\
     policy:		SCHED_OTHER,					\
-    cpus_allowed:	-1,						\
+    cpus_allowed:	CPU_MASK_ALL,					\
     mm:			NULL,						\
     active_mm:		&init_mm,					\
     run_list:		LIST_HEAD_INIT(tsk.run_list),			\
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/include/linux/sched.h working-2.5.23-sched/include/linux/sched.h
--- linux-2.5.23/include/linux/sched.h	Thu Jun 20 01:28:52 2002
+++ working-2.5.23-sched/include/linux/sched.h	Fri Jun 21 01:36:32 2002
@@ -21,6 +21,7 @@
 #include <asm/page.h>
 #include <asm/ptrace.h>
 #include <asm/mmu.h>
+#include <asm/current.h>
 
 #include <linux/smp.h>
 #include <linux/sem.h>
@@ -264,7 +265,7 @@
 	unsigned long sleep_timestamp;
 
 	unsigned long policy;
-	unsigned long cpus_allowed;
+	cpu_mask_t cpus_allowed;
 	unsigned int time_slice;
 
 	struct list_head tasks;
@@ -408,9 +409,17 @@
 #define _STK_LIM	(8*1024*1024)
 
 #if CONFIG_SMP
-extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
+extern void set_cpus_allowed(task_t *p, cpu_mask_t new_mask);
+static inline void migrate_to_cpu(unsigned int cpu)
+{
+	cpu_mask_t mask = CPU_MASK_NONE;
+	BUG_ON(!cpu_online(cpu));
+	__set_bit(cpu, (unsigned long *)&mask);
+	set_cpus_allowed(current, mask);
+}
 #else
-# define set_cpus_allowed(p, new_mask) do { } while (0)
+#define set_cpus_allowed(p, new_mask) do { } while (0)
+#define migrate_to_cpu(cpu) do { BUG_ON((cpu) != 0); } while(0)
 #endif
 
 extern void set_user_nice(task_t *p, long nice);
@@ -477,8 +486,6 @@
 /* per-UID process charging. */
 extern struct user_struct * alloc_uid(uid_t);
 extern void free_uid(struct user_struct *);
-
-#include <asm/current.h>
 
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/include/linux/smp.h working-2.5.23-sched/include/linux/smp.h
--- linux-2.5.23/include/linux/smp.h	Thu Jun 20 01:28:52 2002
+++ working-2.5.23-sched/include/linux/smp.h	Fri Jun 21 01:24:07 2002
@@ -91,6 +91,7 @@
 #define __per_cpu_data
 #define per_cpu(var, cpu)			var
 #define this_cpu(var)				var
+#define cpu_online_mask(res,mask) do { *(res) = ((mask) & 1); } while(0)
 
 #endif /* !SMP */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/kernel/sched.c working-2.5.23-sched/kernel/sched.c
--- linux-2.5.23/kernel/sched.c	Thu Jun 20 01:28:52 2002
+++ working-2.5.23-sched/kernel/sched.c	Fri Jun 21 01:49:47 2002
@@ -367,7 +367,8 @@
 		 */
 		if (unlikely(sync && (rq->curr != p) &&
 			(p->thread_info->cpu != smp_processor_id()) &&
-			(p->cpus_allowed & (1UL << smp_processor_id())))) {
+			test_bit(smp_processor_id(),
+				 (unsigned long *)&p->cpus_allowed))) {
 
 			p->thread_info->cpu = smp_processor_id();
 			task_rq_unlock(rq, &flags);
@@ -647,7 +648,7 @@
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
 	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
 		((p) != (rq)->curr) &&					\
-			((p)->cpus_allowed & (1UL << (this_cpu))))
+			(test_bit((this_cpu), (unsigned long *)&(p)->cpus_allowed)))
 
 	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
 		curr = curr->next;
@@ -1319,7 +1320,7 @@
 asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
 				      unsigned long *user_mask_ptr)
 {
-	unsigned long new_mask;
+	cpu_mask_t online_mask, new_mask;
 	int retval;
 	task_t *p;
 
@@ -1329,8 +1330,8 @@
 	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
 		return -EFAULT;
 
-	new_mask &= cpu_online_map;
-	if (!new_mask)
+	cpu_online_mask(&online_mask, new_mask);
+	if (find_first_bit((unsigned long *)online_mask, NR_CPUS) == NR_CPUS)
 		return -EINVAL;
 
 	read_lock(&tasklist_lock);
@@ -1355,7 +1356,7 @@
 		goto out_unlock;
 
 	retval = 0;
-	set_cpus_allowed(p, new_mask);
+	set_cpus_allowed(p, online_mask);
 
 out_unlock:
 	put_task_struct(p);
@@ -1372,7 +1373,7 @@
 				      unsigned long *user_mask_ptr)
 {
 	unsigned int real_len;
-	unsigned long mask;
+	cpu_mask_t mask;
 	int retval;
 	task_t *p;
 
@@ -1388,7 +1389,7 @@
 		goto out_unlock;
 
 	retval = 0;
-	mask = p->cpus_allowed & cpu_online_map;
+	cpu_online_mask(&mask, p->cpus_allowed);
 
 out_unlock:
 	read_unlock(&tasklist_lock);
@@ -1734,16 +1735,12 @@
  * task must not exit() & deallocate itself prematurely.  The
  * call is not atomic; no spinlocks may be held.
  */
-void set_cpus_allowed(task_t *p, unsigned long new_mask)
+void set_cpus_allowed(task_t *p, cpu_mask_t new_mask)
 {
 	unsigned long flags;
 	migration_req_t req;
 	runqueue_t *rq;
 
-	new_mask &= cpu_online_map;
-	if (!new_mask)
-		BUG();
-
 	preempt_disable();
 	rq = task_rq_lock(p, &flags);
 	p->cpus_allowed = new_mask;
@@ -1751,7 +1748,7 @@
 	 * Can the task run on the task's current CPU? If not then
 	 * migrate the process off to a proper CPU.
 	 */
-	if (new_mask & (1UL << p->thread_info->cpu)) {
+	if (test_bit(p->thread_info->cpu, (unsigned long *)&new_mask)) {
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
@@ -1760,7 +1757,8 @@
 	 * it is sufficient to simply update the task's cpu field.
 	 */
 	if (!p->array && (p != rq->curr)) {
-		p->thread_info->cpu = __ffs(p->cpus_allowed);
+		p->thread_info->cpu = any_online_cpu(p->cpus_allowed);
+		BUG_ON(p->thread_info->cpu >= NR_CPUS);
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
@@ -1795,7 +1793,7 @@
 	if (cpu != 0) {
 		while (!cpu_rq(0)->migration_thread)
 			yield();
-		set_cpus_allowed(current, 1UL << cpu);
+		migrate_to_cpu(cpu);
 	}
 	printk("migration_task %d on cpu=%d\n", cpu, smp_processor_id());
 	ret = setscheduler(0, SCHED_FIFO, &param);
@@ -1826,7 +1825,7 @@
 		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed);
+		cpu_dest = any_online_cpu(p->cpus_allowed);
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
 		cpu_src = p->thread_info->cpu;
@@ -1857,7 +1856,12 @@
 {
 	int cpu;
 
-	current->cpus_allowed = 1UL << 0;
+	/* Must not be preempted with cpus_allowed all zero. */
+	cpu = get_cpu();
+	current->cpus_allowed = CPU_MASK_NONE;
+	__set_bit(cpu, (unsigned long *)&current->cpus_allowed);
+	put_cpu();
+
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;
@@ -1865,7 +1869,7 @@
 				CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
 			BUG();
 	}
-	current->cpus_allowed = -1L;
+	current->cpus_allowed = CPU_MASK_ALL;
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.23/kernel/softirq.c working-2.5.23-sched/kernel/softirq.c
--- linux-2.5.23/kernel/softirq.c	Thu Jun 20 01:28:52 2002
+++ working-2.5.23-sched/kernel/softirq.c	Fri Jun 21 00:48:15 2002
@@ -370,8 +370,7 @@
 	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 
-	/* Migrate to the right CPU */
-	set_cpus_allowed(current, 1UL << cpu);
+	migrate_to_cpu(cpu);
 	if (smp_processor_id() != cpu)
 		BUG();
 
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
