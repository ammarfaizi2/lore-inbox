Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287552AbSAPVC7>; Wed, 16 Jan 2002 16:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287591AbSAPVCv>; Wed, 16 Jan 2002 16:02:51 -0500
Received: from zero.tech9.net ([209.61.188.187]:8714 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287552AbSAPVCp>;
	Wed, 16 Jan 2002 16:02:45 -0500
Subject: [PATCH] 2.5.3-pre1: more scheduling updates
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 16 Jan 2002 16:06:07 -0500
Message-Id: <1011215176.1083.78.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

More scheduling related merges.  This time the code comes from Ingo's J0
patch, Rusty, and myself.  Again I am only including bug fixes and
cleanups that should be obviously correct, although most of these are a
bit less critical than the last patch I sent.

I am still refraining from anything that is controversial, especially
the load_balance and sched/idle_tick changes, which I'll leave to Ingo
and Davide.  I hope everyone can agree on a solution.

Itemized Changes:

- init and smp_boot fixes

- do lock order by address not rq_cpu

- remove old RT event comment

- make lock_task_rq return rq in lieu of passing it

- make lock_task_rq and unlock_task_rq inlines instead of defines

- grab spin_lock later in wake_up_forked_process

- remove RUN_CHILD_FIRST #if's.  it is clear this works, now.

- misc cleanups

	Robert Love

diff -urN linux-2.5.3-pre1/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux-2.5.3-pre1/arch/i386/kernel/smpboot.c	Tue Jan 15 18:05:21 2002
+++ linux/arch/i386/kernel/smpboot.c	Wed Jan 16 14:39:11 2002
@@ -462,6 +462,7 @@
 	 * things done here to the most necessary things.
 	 */
 	cpu_init();
+	init_idle();
 	smp_callin();
 	while (!atomic_read(&smp_commenced))
 		rep_nop();
@@ -470,8 +471,8 @@
 	 * the local TLBs too.
 	 */
 	local_flush_tlb();
+	idle_startup_done();
 
-	init_idle();
 	return cpu_idle();
 }
 
diff -urN linux-2.5.3-pre1/include/asm-i386/smplock.h linux/include/asm-i386/smplock.h
--- linux-2.5.3-pre1/include/asm-i386/smplock.h	Tue Jan 15 18:05:20 2002
+++ linux/include/asm-i386/smplock.h	Wed Jan 16 15:41:34 2002
@@ -19,8 +19,8 @@
 do {						\
 	if (unlikely(task->lock_depth >= 0)) {	\
 		spin_unlock(&kernel_flag);	\
-		release_irqlock(cpu);		\
-		__sti();			\
+		if (global_irq_holder == (cpu))	\
+			BUG();			\
 	}					\
 } while (0)
 
diff -urN linux-2.5.3-pre1/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.5.3-pre1/include/linux/sched.h	Tue Jan 15 18:05:20 2002
+++ linux/include/linux/sched.h	Wed Jan 16 15:41:29 2002
@@ -136,8 +136,11 @@
 extern rwlock_t tasklist_lock;
 extern spinlock_t mmlist_lock;
 
+typedef struct task_struct task_t;
+
 extern void sched_init(void);
 extern void init_idle(void);
+extern void idle_startup_done(void);
 extern void show_state(void);
 extern void cpu_init (void);
 extern void trap_init(void);
@@ -221,7 +224,6 @@
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
 
-typedef struct task_struct task_t;
 typedef struct prio_array prio_array_t;
 
 struct task_struct {
diff -urN linux-2.5.3-pre1/init/main.c linux/init/main.c
--- linux-2.5.3-pre1/init/main.c	Tue Jan 15 18:05:20 2002
+++ linux/init/main.c	Wed Jan 16 14:38:29 2002
@@ -290,8 +290,6 @@
 extern void setup_arch(char **);
 extern void cpu_idle(void);
 
-unsigned long wait_init_idle;
-
 #ifndef CONFIG_SMP
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -305,6 +303,16 @@
 
 #else
 
+static unsigned long __initdata wait_init_idle;
+
+void __init idle_startup_done(void)
+{
+	clear_bit(smp_processor_id(), &wait_init_idle);
+	while (wait_init_idle) {
+		cpu_relax();
+		barrier();
+	}
+}
 
 /* Called by boot processor to activate the rest. */
 static void __init smp_init(void)
@@ -315,6 +323,7 @@
 
 	smp_threads_ready=1;
 	smp_commence();
+	idle_startup_done();
 }
 
 #endif
@@ -411,6 +420,7 @@
 	check_bugs();
 	printk("POSIX conformance testing by UNIFIX\n");
 
+	init_idle();
 	/* 
 	 *	We count on the initial thread going ok 
 	 *	Like idlers init is an unlocked kernel thread, which will
@@ -418,14 +428,6 @@
 	 */
 	smp_init();
 
-	/*
-	 * Finally, we wait for all other CPU's, and initialize this
-	 * thread that will become the idle thread for the boot CPU.
-	 * After this, the scheduler is fully initialized, and we can
-	 * start creating and running new threads.
-	 */
-	init_idle();
-
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
 }
diff -urN linux-2.5.3-pre1/kernel/fork.c linux/kernel/fork.c
--- linux-2.5.3-pre1/kernel/fork.c	Tue Jan 15 18:05:20 2002
+++ linux/kernel/fork.c	Wed Jan 16 15:30:48 2002
@@ -746,23 +746,16 @@
 	if (p->ptrace & PT_PTRACED)
 		send_sig(SIGSTOP, p, 1);
 
-#define RUN_CHILD_FIRST 1
-#if RUN_CHILD_FIRST
 	wake_up_forked_process(p);		/* do this last */
-#else
-	wake_up_process(p);			/* do this last */
-#endif
 	++total_forks;
 	if (clone_flags & CLONE_VFORK)
 		wait_for_completion(&vfork);
-#if RUN_CHILD_FIRST
 	else
 		/*
 		 * Let the child process run first, to avoid most of the
 		 * COW overhead when the child exec()s afterwards.
 		 */
 		current->need_resched = 1;
-#endif
 
 fork_out:
 	return retval;
diff -urN linux-2.5.3-pre1/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.3-pre1/kernel/sched.c	Tue Jan 15 18:05:20 2002
+++ linux/kernel/sched.c	Wed Jan 16 15:40:20 2002
@@ -40,14 +40,9 @@
  *
  * Locking rule: those places that want to lock multiple runqueues
  * (such as the load balancing or the process migration code), lock
- * acquire operations must be ordered by rq->cpu.
- *
- * The RT event id is used to avoid calling into the the RT scheduler
- * if there is a RT task active in an SMP system but there is no
- * RT scheduling activity otherwise.
+ * acquire operations must be ordered by ascending &runqueue.
  */
 static struct runqueue {
-	int cpu;
 	spinlock_t lock;
 	unsigned long nr_running, nr_switches;
 	task_t *curr, *idle;
@@ -55,25 +50,31 @@
 	char __pad [SMP_CACHE_BYTES];
 } runqueues [NR_CPUS] __cacheline_aligned;
 
-#define this_rq()		(runqueues + smp_processor_id())
-#define task_rq(p)		(runqueues + (p)->cpu)
 #define cpu_rq(cpu)		(runqueues + (cpu))
-#define cpu_curr(cpu)		(runqueues[(cpu)].curr)
+#define this_rq()		cpu_rq(smp_processor_id())
+#define task_rq(p)		cpu_rq((p)->cpu)
+#define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->policy != SCHED_OTHER)
 
-#define lock_task_rq(rq,p,flags)				\
-do {								\
-repeat_lock_task:						\
-	rq = task_rq(p);					\
-	spin_lock_irqsave(&rq->lock, flags);			\
-	if (unlikely((rq)->cpu != (p)->cpu)) {			\
-		spin_unlock_irqrestore(&rq->lock, flags);	\
-		goto repeat_lock_task;				\
-	}							\
-} while (0)
+static inline runqueue_t *lock_task_rq(task_t *p, unsigned long *flags)
+{
+	struct runqueue *rq;
+
+repeat_lock_task:
+	rq = task_rq(p);
+	spin_lock_irqsave(&rq->lock, *flags);
+	if (unlikely(rq != task_rq(p))) {
+		spin_unlock_irqrestore(&rq->lock, *flags);
+		goto repeat_lock_task;
+	}
+	return rq;
+}
 
-#define unlock_task_rq(rq,p,flags)				\
-	spin_unlock_irqrestore(&rq->lock, flags)
+static inline void unlock_task_rq(runqueue_t *rq, task_t *p,
+							unsigned long *flags)
+{
+	spin_unlock_irqrestore(&rq->lock, *flags);
+}
 
 /*
  * Adding/removing a task to/from a priority array:
@@ -147,12 +148,12 @@
 		cpu_relax();
 		barrier();
 	}
-	lock_task_rq(rq, p, flags);
+	rq = lock_task_rq(p, &flags);
 	if (unlikely(rq->curr == p)) {
-		unlock_task_rq(rq, p, flags);
+		unlock_task_rq(rq, p, &flags);
 		goto repeat;
 	}
-	unlock_task_rq(rq, p, flags);
+	unlock_task_rq(rq, p, &flags);
 }
 
 /*
@@ -185,7 +186,7 @@
 	int success = 0;
 	runqueue_t *rq;
 
-	lock_task_rq(rq, p, flags);
+	rq = lock_task_rq(p, &flags);
 	p->state = TASK_RUNNING;
 	if (!p->array) {
 		activate_task(p, rq);
@@ -193,7 +194,7 @@
 			resched_task(rq->curr);
 		success = 1;
 	}
-	unlock_task_rq(rq, p, flags);
+	unlock_task_rq(rq, p, &flags);
 	return success;
 }
 
@@ -206,13 +207,13 @@
 {
 	runqueue_t *rq = this_rq();
 
-	spin_lock_irq(&rq->lock);
 	p->state = TASK_RUNNING;
 	if (!rt_task(p)) {
 		p->prio += MAX_USER_PRIO/10;
 		if (p->prio > MAX_PRIO-1)
 			p->prio = MAX_PRIO-1;
 	}
+	spin_lock_irq(&rq->lock);
 	activate_task(p, rq);
 	spin_unlock_irq(&rq->lock);
 }
@@ -333,7 +334,7 @@
 	if (max_load <= this_rq->nr_running)
 		return;
 	prev_max_load = max_load;
-	if (busiest->cpu < this_rq->cpu) {
+	if (busiest < this_rq) {
 		spin_unlock(&this_rq->lock);
 		spin_lock(&busiest->lock);
 		spin_lock(&this_rq->lock);
@@ -731,7 +732,7 @@
 	 * We have to be careful, if called from sys_setpriority(),
 	 * the task might be in the middle of scheduling on another CPU.
 	 */
-	lock_task_rq(rq, p, flags);
+	rq = lock_task_rq(p, &flags);
 	if (rt_task(p)) {
 		p->__nice = nice;
 		goto out_unlock;
@@ -745,7 +746,7 @@
 	if (array) {
 		enqueue_task(p, array);
 		/*
-		 * If the task is runnable and lowered its priority,
+		 * If the task is running and lowered its priority,
 		 * or increased its priority then reschedule its CPU:
 		 */
 		if ((nice < p->__nice) ||
@@ -753,7 +754,7 @@
 			resched_task(rq->curr);
 	}
 out_unlock:
-	unlock_task_rq(rq, p, flags);
+	unlock_task_rq(rq, p, &flags);
 }
 
 #ifndef __alpha__
@@ -830,7 +831,7 @@
 	 * To be able to change p->policy safely, the apropriate
 	 * runqueue lock must be held.
 	 */
-	lock_task_rq(rq,p,flags);
+	rq = lock_task_rq(p, &flags);
 
 	if (policy < 0)
 		policy = p->policy;
@@ -873,7 +874,7 @@
 		activate_task(p, task_rq(p));
 
 out_unlock:
-	unlock_task_rq(rq,p,flags);
+	unlock_task_rq(rq, p, &flags);
 out_unlock_tasklist:
 	read_unlock_irq(&tasklist_lock);
 
@@ -1116,14 +1117,12 @@
 	read_unlock(&tasklist_lock);
 }
 
-extern unsigned long wait_init_idle;
-
 static inline void double_rq_lock(runqueue_t *rq1, runqueue_t *rq2)
 {
 	if (rq1 == rq2)
 		spin_lock(&rq1->lock);
 	else {
-		if (rq1->cpu < rq2->cpu) {
+		if (rq1 < rq2) {
 			spin_lock(&rq1->lock);
 			spin_lock(&rq2->lock);
 		} else {
@@ -1154,14 +1153,9 @@
 	current->array = NULL;
 	current->prio = MAX_PRIO;
 	current->state = TASK_RUNNING;
-	clear_bit(smp_processor_id(), &wait_init_idle);
 	double_rq_unlock(this_rq, rq);
-	while (wait_init_idle) {
-		cpu_relax();
-		barrier();
-	}
 	current->need_resched = 1;
-	__sti();
+	__restore_flags(flags);
 }
 
 extern void init_timervecs(void);

