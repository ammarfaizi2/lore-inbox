Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSGPJKv>; Tue, 16 Jul 2002 05:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSGPJKu>; Tue, 16 Jul 2002 05:10:50 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:53153 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S310190AbSGPJKh>;
	Tue, 16 Jul 2002 05:10:37 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: [PATCH] cpu_mask_t
Date: Tue, 16 Jul 2002 18:15:34 +1000
Message-Id: <20020716091406.B7D9B42CC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And this is part II.  Each arch implements cpu_mask_t, cpu_online_mask(&res,
mask), CPU_MASK_ALL, CPU_MASK_NONE, and we're done.

Boots, runs.

Name: CPU mask patch
Author: Rusty Russell
Status: Trivial
Depends: Hotcpu/migrate-to-cpu.patch.gz

D: This patch adds a cpu_mask_t for easy future expansion of cpu masks.
D: It also changes any_online_cpu to return NR_CPUS on failure, like
D: find_first_bit.

diff -urpN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25.30219/include/asm-i386/smp.h linux-2.5.25.30219.updated/include/asm-i386/smp.h
--- linux-2.5.25.30219/include/asm-i386/smp.h	Thu Jun 20 01:28:51 2002
+++ linux-2.5.25.30219.updated/include/asm-i386/smp.h	Tue Jul 16 17:18:55 2002
@@ -99,14 +99,6 @@ extern inline unsigned int num_online_cp
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
@@ -117,6 +109,23 @@ static __inline int logical_smp_processo
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
diff -urpN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25.30219/include/asm-ia64/smp.h linux-2.5.25.30219.updated/include/asm-ia64/smp.h
--- linux-2.5.25.30219/include/asm-ia64/smp.h	Thu Jun 20 01:28:51 2002
+++ linux-2.5.25.30219.updated/include/asm-ia64/smp.h	Tue Jul 16 17:18:55 2002
@@ -51,12 +51,22 @@ extern inline unsigned int num_online_cp
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
diff -urpN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25.30219/include/asm-ppc/smp.h linux-2.5.25.30219.updated/include/asm-ppc/smp.h
--- linux-2.5.25.30219/include/asm-ppc/smp.h	Thu Jun 20 01:28:51 2002
+++ linux-2.5.25.30219.updated/include/asm-ppc/smp.h	Tue Jul 16 17:18:55 2002
@@ -54,12 +54,21 @@ extern inline unsigned int num_online_cp
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
diff -urpN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25.30219/include/linux/init_task.h linux-2.5.25.30219.updated/include/linux/init_task.h
--- linux-2.5.25.30219/include/linux/init_task.h	Sun May 19 12:07:34 2002
+++ linux-2.5.25.30219.updated/include/linux/init_task.h	Tue Jul 16 17:18:55 2002
@@ -48,7 +48,7 @@
     prio:		MAX_PRIO-20,					
     static_prio:	MAX_PRIO-20,					
     policy:		SCHED_OTHER,					
-    cpus_allowed:	-1,						
+    cpus_allowed:	CPU_MASK_ALL,					
     mm:			NULL,						
     active_mm:		&init_mm,					
     run_list:		LIST_HEAD_INIT(tsk.run_list),			
diff -urpN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25.30219/include/linux/sched.h linux-2.5.25.30219.updated/include/linux/sched.h
--- linux-2.5.25.30219/include/linux/sched.h	Tue Jul 16 17:18:52 2002
+++ linux-2.5.25.30219.updated/include/linux/sched.h	Tue Jul 16 17:18:55 2002
@@ -20,6 +20,7 @@ extern unsigned long event;
 #include <asm/page.h>
 #include <asm/ptrace.h>
 #include <asm/mmu.h>
+#include <asm/current.h>
 
 #include <linux/smp.h>
 #include <linux/sem.h>
@@ -263,7 +264,7 @@ struct task_struct {
 	unsigned long sleep_timestamp;
 
 	unsigned long policy;
-	unsigned long cpus_allowed;
+	cpu_mask_t cpus_allowed;
 	unsigned int time_slice;
 
 	struct list_head tasks;
@@ -407,12 +408,12 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define _STK_LIM	(8*1024*1024)
 
 #if CONFIG_SMP
-extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
+extern void set_cpus_allowed(task_t *p, cpu_mask_t new_mask);
 static inline void migrate_to_cpu(unsigned int cpu)
 {
-	unsigned long mask = 0;
+	cpu_mask_t mask = CPU_MASK_NONE;
 	BUG_ON(!cpu_online(cpu));
-	__set_bit(cpu, &mask);
+	__set_bit(cpu, (unsigned long *)&mask);
 	set_cpus_allowed(current, mask);
 }
 #else
@@ -483,8 +484,6 @@ static inline struct task_struct *find_t
 /* per-UID process charging. */
 extern struct user_struct * alloc_uid(uid_t);
 extern void free_uid(struct user_struct *);
-
-#include <asm/current.h>
 
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
diff -urpN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25.30219/include/linux/smp.h linux-2.5.25.30219.updated/include/linux/smp.h
--- linux-2.5.25.30219/include/linux/smp.h	Fri Jun 21 09:41:55 2002
+++ linux-2.5.25.30219.updated/include/linux/smp.h	Tue Jul 16 17:18:55 2002
@@ -86,13 +86,16 @@ extern volatile int smp_msg_id;
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
diff -urpN -I $.*$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25.30219/kernel/sched.c linux-2.5.25.30219.updated/kernel/sched.c
--- linux-2.5.25.30219/kernel/sched.c	Tue Jul 16 17:18:52 2002
+++ linux-2.5.25.30219.updated/kernel/sched.c	Tue Jul 16 17:20:35 2002
@@ -367,7 +367,8 @@ repeat_lock_task:
 		 */
 		if (unlikely(sync && (rq->curr != p) &&
 			(task_cpu(p) != smp_processor_id()) &&
-			(p->cpus_allowed & (1UL << smp_processor_id())))) {
+			test_bit(smp_processor_id(),
+				 (unsigned long *)&p->cpus_allowed))) {
 
 			set_task_cpu(p, smp_processor_id());
 			task_rq_unlock(rq, &flags);
@@ -647,7 +648,7 @@ skip_queue:
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					
 	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	
 		((p) != (rq)->curr) &&					
-			((p)->cpus_allowed & (1UL << (this_cpu))))
+			(test_bit((this_cpu), (unsigned long *)&(p)->cpus_allowed)))
 
 	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
 		curr = curr->next;
@@ -1319,7 +1320,7 @@ out_unlock:
 asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
 				      unsigned long *user_mask_ptr)
 {
-	unsigned long new_mask;
+	cpu_mask_t online_mask, new_mask;
 	int retval;
 	task_t *p;
 
@@ -1329,8 +1330,8 @@ asmlinkage int sys_sched_setaffinity(pid
 	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
 		return -EFAULT;
 
-	new_mask &= cpu_online_map;
-	if (!new_mask)
+	cpu_online_mask(&online_mask, new_mask);
+	if (find_first_bit((unsigned long *)online_mask, NR_CPUS) == NR_CPUS)
 		return -EINVAL;
 
 	read_lock(&tasklist_lock);
@@ -1355,7 +1356,7 @@ asmlinkage int sys_sched_setaffinity(pid
 		goto out_unlock;
 
 	retval = 0;
-	set_cpus_allowed(p, new_mask);
+	set_cpus_allowed(p, online_mask);
 
 out_unlock:
 	put_task_struct(p);
@@ -1372,7 +1373,7 @@ asmlinkage int sys_sched_getaffinity(pid
 				      unsigned long *user_mask_ptr)
 {
 	unsigned int real_len;
-	unsigned long mask;
+	cpu_mask_t mask;
 	int retval;
 	task_t *p;
 
@@ -1388,7 +1389,7 @@ asmlinkage int sys_sched_getaffinity(pid
 		goto out_unlock;
 
 	retval = 0;
-	mask = p->cpus_allowed & cpu_online_map;
+	cpu_online_mask(&mask, p->cpus_allowed);
 
 out_unlock:
 	read_unlock(&tasklist_lock);
@@ -1746,16 +1747,12 @@ typedef struct {
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
@@ -1763,7 +1760,7 @@ void set_cpus_allowed(task_t *p, unsigne
 	 * Can the task run on the task's current CPU? If not then
 	 * migrate the process off to a proper CPU.
 	 */
-	if (new_mask & (1UL << task_cpu(p))) {
+	if (test_bit(task_cpu(p), (unsigned long *)&new_mask)) {
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
@@ -1772,7 +1769,8 @@ void set_cpus_allowed(task_t *p, unsigne
 	 * it is sufficient to simply update the task's cpu field.
 	 */
 	if (!p->array && (p != rq->curr)) {
-		set_task_cpu(p, __ffs(p->cpus_allowed));
+		set_task_cpu(p, any_online_cpu(p->cpus_allowed));
+		BUG_ON(task_cpu(p) >= NR_CPUS);
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
@@ -1838,7 +1836,7 @@ static int migration_thread(void * bind_
 		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed);
+		cpu_dest = any_online_cpu(p->cpus_allowed);
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
 		cpu_src = task_cpu(p);
@@ -1879,7 +1877,7 @@ void __init migration_init(void)
 				CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
 			BUG();
 	}
-	current->cpus_allowed = -1L;
+	current->cpus_allowed = CPU_MASK_ALL;
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
