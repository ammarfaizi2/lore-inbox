Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317500AbSGJI36>; Wed, 10 Jul 2002 04:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317503AbSGJI35>; Wed, 10 Jul 2002 04:29:57 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:35741 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317500AbSGJI3x>;
	Wed, 10 Jul 2002 04:29:53 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cpu_mask_t
Date: Wed, 10 Jul 2002 18:34:23 +1000
Message-Id: <20020710083120.0B21246EB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the last of my cpu_online_map damage, completing the abstraction.

Please apply,
Rusty.

Name: CPU mask patch
Author: Rusty Russell
Status: Trivial

D: This patch adds a cpu_mask_t for easy future expansion of cpu masks,
D: and an easy "migrate_to_cpu()" call for simple in-kernel affinity.  It
D: also changes any_online_cpu to return NR_CPUS on failure, like
D: find_first_bit.

diff -urN -I $.*$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/include/linux/init_task.h working-2.5.25-cpumask/include/linux/init_task.h
--- linux-2.5.25/include/linux/init_task.h	Sun May 19 12:07:34 2002
+++ working-2.5.25-cpumask/include/linux/init_task.h	Wed Jul 10 18:10:13 2002
@@ -48,7 +48,7 @@
     prio:		MAX_PRIO-20,					
     static_prio:	MAX_PRIO-20,					
     policy:		SCHED_OTHER,					
-    cpus_allowed:	-1,						
+    cpus_allowed:	CPU_MASK_ALL,					
     mm:			NULL,						
     active_mm:		&init_mm,					
     run_list:		LIST_HEAD_INIT(tsk.run_list),			
diff -urN -I $.*$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/include/linux/sched.h working-2.5.25-cpumask/include/linux/sched.h
--- linux-2.5.25/include/linux/sched.h	Sun Jul  7 02:12:24 2002
+++ working-2.5.25-cpumask/include/linux/sched.h	Wed Jul 10 18:10:13 2002
@@ -20,6 +20,7 @@
 #include <asm/page.h>
 #include <asm/ptrace.h>
 #include <asm/mmu.h>
+#include <asm/current.h>
 
 #include <linux/smp.h>
 #include <linux/sem.h>
@@ -263,7 +264,7 @@
 	unsigned long sleep_timestamp;
 
 	unsigned long policy;
-	unsigned long cpus_allowed;
+	cpu_mask_t cpus_allowed;
 	unsigned int time_slice;
 
 	struct list_head tasks;
@@ -407,9 +408,17 @@
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
@@ -475,8 +484,6 @@
 /* per-UID process charging. */
 extern struct user_struct * alloc_uid(uid_t);
 extern void free_uid(struct user_struct *);
-
-#include <asm/current.h>
 
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
diff -urN -I $.*$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/include/linux/smp.h working-2.5.25-cpumask/include/linux/smp.h
--- linux-2.5.25/include/linux/smp.h	Fri Jun 21 09:41:55 2002
+++ working-2.5.25-cpumask/include/linux/smp.h	Wed Jul 10 18:16:18 2002
@@ -86,13 +86,16 @@
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
-#define cpu_online_map				1
 #define cpu_online(cpu)				1
 #define num_online_cpus()			1
 #define __per_cpu_data
 #define per_cpu(var, cpu)			var
 #define this_cpu(var)				var
-
+typedef unsigned long cpu_mask_t;
+#define CPU_MASK_ALL 1
+#define CPU_MASK_NONE 0
+#define cpu_online_mask(res,mask) do { *(res) = ((mask) & 1); } while(0)
+#define any_online_cpu(mask) (((mask) & 1) ? 0 : 1)
 #endif /* !SMP */
 
 #define get_cpu()	({ preempt_disable(); smp_processor_id(); })
diff -urN -I $.*$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/arch/ppc64/kernel/rtasd.c working-2.5.25-cpumask/arch/ppc64/kernel/rtasd.c
--- linux-2.5.25/arch/ppc64/kernel/rtasd.c	Mon Jun 10 16:03:47 2002
+++ working-2.5.25-cpumask/arch/ppc64/kernel/rtasd.c	Wed Jul 10 18:10:13 2002
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
diff -urN -I $.*$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/include/asm-i386/smp.h working-2.5.25-cpumask/include/asm-i386/smp.h
--- linux-2.5.25/include/asm-i386/smp.h	Thu Jun 20 01:28:51 2002
+++ working-2.5.25-cpumask/include/asm-i386/smp.h	Wed Jul 10 18:10:13 2002
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
diff -urN -I $.*$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/include/asm-ia64/smp.h working-2.5.25-cpumask/include/asm-ia64/smp.h
--- linux-2.5.25/include/asm-ia64/smp.h	Thu Jun 20 01:28:51 2002
+++ working-2.5.25-cpumask/include/asm-ia64/smp.h	Wed Jul 10 18:10:13 2002
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
diff -urN -I $.*$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/include/asm-ppc/smp.h working-2.5.25-cpumask/include/asm-ppc/smp.h
--- linux-2.5.25/include/asm-ppc/smp.h	Thu Jun 20 01:28:51 2002
+++ working-2.5.25-cpumask/include/asm-ppc/smp.h	Wed Jul 10 18:10:13 2002
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
diff -urN -I $.*$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/kernel/sched.c working-2.5.25-cpumask/kernel/sched.c
--- linux-2.5.25/kernel/sched.c	Sun Jul  7 02:12:24 2002
+++ working-2.5.25-cpumask/kernel/sched.c	Wed Jul 10 18:10:13 2002
@@ -367,7 +367,8 @@
 		 */
 		if (unlikely(sync && (rq->curr != p) &&
 			(task_cpu(p) != smp_processor_id()) &&
-			(p->cpus_allowed & (1UL << smp_processor_id())))) {
+			test_bit(smp_processor_id(),
+				 (unsigned long *)&p->cpus_allowed))) {
 
 			set_task_cpu(p, smp_processor_id());
 			task_rq_unlock(rq, &flags);
@@ -647,7 +648,7 @@
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					
 	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	
 		((p) != (rq)->curr) &&					
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
@@ -1746,16 +1747,12 @@
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
@@ -1763,7 +1760,7 @@
 	 * Can the task run on the task's current CPU? If not then
 	 * migrate the process off to a proper CPU.
 	 */
-	if (new_mask & (1UL << task_cpu(p))) {
+	if (test_bit(task_cpu(p), (unsigned long *)&new_mask)) {
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
@@ -1772,7 +1769,8 @@
 	 * it is sufficient to simply update the task's cpu field.
 	 */
 	if (!p->array && (p != rq->curr)) {
-		set_task_cpu(p, __ffs(p->cpus_allowed));
+		set_task_cpu(p, any_online_cpu(p->cpus_allowed));
+		BUG_ON(task_cpu(p) >= NR_CPUS);
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
@@ -1807,7 +1805,7 @@
 	if (cpu != master_migration_thread) {
 		while (!cpu_rq(master_migration_thread)->migration_thread)
 			yield();
-		set_cpus_allowed(current, 1UL << cpu);
+		migrate_to_cpu(cpu);
 	}
 	printk("migration_task %d on cpu=%dn", cpu, smp_processor_id());
 	ret = setscheduler(0, SCHED_FIFO, &param);
@@ -1838,7 +1836,7 @@
 		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed);
+		cpu_dest = any_online_cpu(p->cpus_allowed);
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
 		cpu_src = task_cpu(p);
@@ -1869,9 +1867,13 @@
 {
 	int cpu;
 
-	master_migration_thread = smp_processor_id();
-	current->cpus_allowed = 1UL << master_migration_thread;
-	
+	/* Must not be preempted with cpus_allowed all zero. */
+	master_migration_thread = get_cpu();
+	current->cpus_allowed = CPU_MASK_NONE;
+	__set_bit(master_migration_thread,
+		  (unsigned long *)&current->cpus_allowed);
+	put_cpu();
+
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
 			continue;
@@ -1879,7 +1881,7 @@
 				CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
 			BUG();
 	}
-	current->cpus_allowed = -1L;
+	current->cpus_allowed = CPU_MASK_ALL;
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))
diff -urN -I $.*$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/kernel/softirq.c working-2.5.25-cpumask/kernel/softirq.c
--- linux-2.5.25/kernel/softirq.c	Sun Jul  7 02:12:24 2002
+++ working-2.5.25-cpumask/kernel/softirq.c	Wed Jul 10 18:10:13 2002
@@ -370,8 +370,7 @@
 	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 
-	/* Migrate to the right CPU */
-	set_cpus_allowed(current, 1UL << cpu);
+	migrate_to_cpu(cpu);
 	if (smp_processor_id() != cpu)
 		BUG();
 
diff -urN -I $.*$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.25/Documentation/sched-coding.txt working-2.5.25-cpumask/Documentation/sched-coding.txt
--- linux-2.5.25/Documentation/sched-coding.txt	Thu May 30 10:00:45 2002
+++ working-2.5.25-cpumask/Documentation/sched-coding.txt	Wed Jul 10 18:10:13 2002
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
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
