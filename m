Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312691AbSDONmI>; Mon, 15 Apr 2002 09:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312694AbSDONmI>; Mon, 15 Apr 2002 09:42:08 -0400
Received: from kim.it.uu.se ([130.238.12.178]:758 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S312691AbSDONmE>;
	Mon, 15 Apr 2002 09:42:04 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15546.55465.633283.770146@kim.it.uu.se>
Date: Mon, 15 Apr 2002 15:42:01 +0200
To: linux-kernel@vger.kernel.org
Subject: [CFT][PATCH] UP microoptimisation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On UP it's unnecessary to store or retrieve the CPU number of a process,
since it's a known constant. This patch implements a microoptimisation
by first replacing explicit accesses to ->thread_info->cpu by two new
macros, and then providing optimised stubs for these in UP kernels.

Works on x86, but unfortunately not yet on other archs; the problem
is the #include mess and where to put the UP versions of the macros.
Suggestions welcome.

This patch is for 2.5.8; a version for 2.4.19-pre6 is available in
<http://www.csd.uu.se/~mikpe/linux/patches/2.4/>.

/Mikael

diff -ruN linux-2.5.8/arch/i386/kernel/smpboot.c linux-2.5.8.up-opt/arch/i386/kernel/smpboot.c
--- linux-2.5.8/arch/i386/kernel/smpboot.c	Mon Apr 15 00:32:51 2002
+++ linux-2.5.8.up-opt/arch/i386/kernel/smpboot.c	Mon Apr 15 00:47:08 2002
@@ -1055,7 +1055,7 @@
 	map_cpu_to_boot_apicid(0, boot_cpu_apicid);
 
 	global_irq_holder = NO_PROC_ID;
-	current_thread_info()->cpu = 0;
+	set_thread_info_cpu(current_thread_info(), 0);
 	smp_tune_scheduling();
 
 	/*
diff -ruN linux-2.5.8/fs/proc/array.c linux-2.5.8.up-opt/fs/proc/array.c
--- linux-2.5.8/fs/proc/array.c	Mon Apr 15 00:32:53 2002
+++ linux-2.5.8.up-opt/fs/proc/array.c	Mon Apr 15 00:47:08 2002
@@ -389,7 +389,7 @@
 		task->nswap,
 		task->cnswap,
 		task->exit_signal,
-		task->thread_info->cpu);
+		thread_info_cpu(task->thread_info));
 	if(mm)
 		mmput(mm);
 	return res;
diff -ruN linux-2.5.8/include/asm-i386/smp.h linux-2.5.8.up-opt/include/asm-i386/smp.h
--- linux-2.5.8/include/asm-i386/smp.h	Wed Feb 20 03:10:54 2002
+++ linux-2.5.8.up-opt/include/asm-i386/smp.h	Mon Apr 15 00:47:08 2002
@@ -105,7 +105,7 @@
  * so this is correct in the x86 case.
  */
 
-#define smp_processor_id() (current_thread_info()->cpu)
+#define smp_processor_id() thread_info_cpu(current_thread_info())
 
 static __inline int hard_smp_processor_id(void)
 {
diff -ruN linux-2.5.8/include/asm-i386/thread_info.h linux-2.5.8.up-opt/include/asm-i386/thread_info.h
--- linux-2.5.8/include/asm-i386/thread_info.h	Mon Apr 15 00:32:54 2002
+++ linux-2.5.8.up-opt/include/asm-i386/thread_info.h	Mon Apr 15 00:47:42 2002
@@ -24,26 +24,44 @@
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
-	__u32			cpu;		/* current CPU */
-	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
-
 	mm_segment_t		addr_limit;	/* thread address space:
 					 	   0-0xBFFFFFFF for user-thead
 						   0-0xFFFFFFFF for kernel-thread
 						*/
-
+	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
+#ifdef CONFIG_SMP
+	__u32			cpu;		/* current CPU */
+#endif
 	__u8			supervisor_stack[0];
 };
 
+#ifdef CONFIG_SMP
+static inline int thread_info_cpu(const struct thread_info *ti)
+{
+	return ti->cpu;
+}
+static inline void set_thread_info_cpu(struct thread_info *ti, int cpu)
+{
+	ti->cpu = cpu;
+}
+#define TI_CPU_INIT	cpu: 0,
+#else
+static inline int thread_info_cpu(const struct thread_info *ti) { return 0; }
+static inline void set_thread_info_cpu(struct thread_info *ti, int cpu) { }
+#define TI_CPU_INIT	/*empty*/
+#endif
+
 #else /* !__ASSEMBLY__ */
 
 /* offsets into the thread_info struct for assembly code access */
 #define TI_TASK		0x00000000
 #define TI_EXEC_DOMAIN	0x00000004
 #define TI_FLAGS	0x00000008
-#define TI_CPU		0x0000000C
+#define TI_ADDR_LIMIT	0x0000000C
 #define TI_PRE_COUNT	0x00000010
-#define TI_ADDR_LIMIT	0x00000014
+#ifdef CONFIG_SMP
+#define TI_CPU		0x00000014
+#endif
 
 #endif
 
@@ -58,8 +76,8 @@
 	task:		&tsk,			\
 	exec_domain:	&default_exec_domain,	\
 	flags:		0,			\
-	cpu:		0,			\
 	addr_limit:	KERNEL_DS,		\
+	TI_CPU_INIT				\
 }
 
 #define init_thread_info	(init_thread_union.thread_info)
diff -ruN linux-2.5.8/kernel/sched.c linux-2.5.8.up-opt/kernel/sched.c
--- linux-2.5.8/kernel/sched.c	Mon Apr 15 00:32:54 2002
+++ linux-2.5.8.up-opt/kernel/sched.c	Mon Apr 15 00:47:08 2002
@@ -153,7 +153,7 @@
 
 #define cpu_rq(cpu)		(runqueues + (cpu))
 #define this_rq()		cpu_rq(smp_processor_id())
-#define task_rq(p)		cpu_rq((p)->thread_info->cpu)
+#define task_rq(p)		cpu_rq(thread_info_cpu((p)->thread_info))
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
@@ -264,8 +264,8 @@
 	need_resched = test_and_set_tsk_thread_flag(p,TIF_NEED_RESCHED);
 	nrpolling |= test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
 
-	if (!need_resched && !nrpolling && (p->thread_info->cpu != smp_processor_id()))
-		smp_send_reschedule(p->thread_info->cpu);
+	if (!need_resched && !nrpolling && (thread_info_cpu(p->thread_info) != smp_processor_id()))
+		smp_send_reschedule(thread_info_cpu(p->thread_info));
 	preempt_enable();
 #else
 	set_tsk_need_resched(p);
@@ -366,7 +366,7 @@
 		p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 		p->prio = effective_prio(p);
 	}
-	p->thread_info->cpu = smp_processor_id();
+	set_thread_info_cpu(p->thread_info, smp_processor_id());
 	activate_task(p, rq);
 
 	spin_unlock_irq(&rq->lock);
@@ -609,7 +609,7 @@
 	 */
 	dequeue_task(next, array);
 	busiest->nr_running--;
-	next->thread_info->cpu = this_cpu;
+	set_thread_info_cpu(next->thread_info, this_cpu);
 	this_rq->nr_running++;
 	enqueue_task(next, this_rq->active);
 	if (next->prio < current->prio)
@@ -1535,7 +1535,7 @@
 
 void __init init_idle(task_t *idle, int cpu)
 {
-	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(idle->thread_info->cpu);
+	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(thread_info_cpu(idle->thread_info));
 	unsigned long flags;
 
 	__save_flags(flags);
@@ -1547,7 +1547,7 @@
 	idle->array = NULL;
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
-	idle->thread_info->cpu = cpu;
+	set_thread_info_cpu(idle->thread_info, cpu);
 	double_rq_unlock(idle_rq, rq);
 	set_tsk_need_resched(idle);
 	__restore_flags(flags);
@@ -1655,7 +1655,7 @@
 	 * Can the task run on the task's current CPU? If not then
 	 * migrate the process off to a proper CPU.
 	 */
-	if (new_mask & (1UL << p->thread_info->cpu)) {
+	if (new_mask & (1UL << thread_info_cpu(p->thread_info))) {
 		task_rq_unlock(rq, &flags);
 		return;
 	}
@@ -1737,16 +1737,16 @@
 		cpu_dest = __ffs(p->cpus_allowed);
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
-		cpu_src = p->thread_info->cpu;
+		cpu_src = thread_info_cpu(p->thread_info);
 		rq_src = cpu_rq(cpu_src);
 
 		double_rq_lock(rq_src, rq_dest);
-		if (p->thread_info->cpu != cpu_src) {
+		if (thread_info_cpu(p->thread_info) != cpu_src) {
 			double_rq_unlock(rq_src, rq_dest);
 			goto repeat;
 		}
 		if (rq_src == rq) {
-			p->thread_info->cpu = cpu_dest;
+			set_thread_info_cpu(p->thread_info, cpu_dest);
 			if (p->array) {
 				deactivate_task(p, rq_src);
 				activate_task(p, rq_dest);
diff -ruN linux-2.5.8/kernel/signal.c linux-2.5.8.up-opt/kernel/signal.c
--- linux-2.5.8/kernel/signal.c	Tue Mar 19 01:10:08 2002
+++ linux-2.5.8.up-opt/kernel/signal.c	Mon Apr 15 00:47:08 2002
@@ -508,7 +508,7 @@
 	 * process of changing - but no harm is done by that
 	 * other than doing an extra (lightweight) IPI interrupt.
 	 */
-	if ((t->state == TASK_RUNNING) && (t->thread_info->cpu != smp_processor_id()))
+	if ((t->state == TASK_RUNNING) && (thread_info_cpu(t->thread_info) != smp_processor_id()))
 		kick_if_running(t);
 #endif
 	if (t->state & TASK_INTERRUPTIBLE) {
