Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313317AbSDUAuA>; Sat, 20 Apr 2002 20:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313318AbSDUAt7>; Sat, 20 Apr 2002 20:49:59 -0400
Received: from zero.tech9.net ([209.61.188.187]:3852 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313317AbSDUAtw>;
	Sat, 20 Apr 2002 20:49:52 -0400
Subject: [PATCH] 2.4-ac updated O(1) scheduler
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-Njjp8etVoibhhXY5Q3Ak"
X-Mailer: Ximian Evolution 1.0.3 
Date: 20 Apr 2002 20:49:56 -0400
Message-Id: <1019350197.9288.197.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Njjp8etVoibhhXY5Q3Ak
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Halo,

The attached patch updates Ingo Molnar's ultra-scalable O(1) scheduler
in 2.4-ac to the latest code base.  It contains various fixes, cleanups,
and new features.  All changes are from 2.5 or patches pending for 2.5.

Specifically, this patch makes the following changes to the scheduler in
Alan's tree:

	- remove wake_up_sync and friends, we don't need them now
	- abstract away access to need_resched
	- fix scheduler deadlock on some platforms
	- sched_yield optimizations and cleanup
	- better use MAX_RT_PRIO define instead of magic numbers
	- misc. code cleanups
	- misc. fixes and optimizations

and most importantly:

	- backport the migration_thread and associated code to 2.4

The migration_thread code has the interrupt-off fix and William Lee
Irwin's new migration_init routine, both of which are pending for 2.5.

Note I have sent this to Alan already, so it should be in a future
2.4-ac.  You can get a better description as well as the patches in
logical chunks from:

	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/sched

I will also make available fully updated base O(1)-scheduler patches for
2.4.18 and the latest prepatch shortly. 

Enjoy,

	Robert Love


--=-Njjp8etVoibhhXY5Q3Ak
Content-Disposition: attachment; filename=sched-fixes-O1-rml-2.4.19-pre7-ac2-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=sched-fixes-O1-rml-2.4.19-pre7-ac2-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre7-ac2/arch/i386/kernel/i8259.c linux/arch/i386/ke=
rnel/i8259.c
--- linux-2.4.19-pre7-ac2/arch/i386/kernel/i8259.c	Sat Apr 20 17:47:38 2002
+++ linux/arch/i386/kernel/i8259.c	Sat Apr 20 18:59:23 2002
@@ -79,7 +79,6 @@
  * through the ICC by us (IPIs)
  */
 #ifdef CONFIG_SMP
-BUILD_SMP_INTERRUPT(task_migration_interrupt,TASK_MIGRATION_VECTOR)
 BUILD_SMP_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
 BUILD_SMP_INTERRUPT(invalidate_interrupt,INVALIDATE_TLB_VECTOR)
 BUILD_SMP_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
@@ -474,9 +473,6 @@
 	 */
 	set_intr_gate(RESCHEDULE_VECTOR, reschedule_interrupt);
=20
-	/* IPI for task migration */
-	set_intr_gate(TASK_MIGRATION_VECTOR, task_migration_interrupt);
-
 	/* IPI for invalidation */
 	set_intr_gate(INVALIDATE_TLB_VECTOR, invalidate_interrupt);
=20
diff -urN linux-2.4.19-pre7-ac2/arch/i386/kernel/smp.c linux/arch/i386/kern=
el/smp.c
--- linux-2.4.19-pre7-ac2/arch/i386/kernel/smp.c	Sat Apr 20 17:47:38 2002
+++ linux/arch/i386/kernel/smp.c	Sat Apr 20 18:59:23 2002
@@ -484,35 +484,6 @@
 	do_flush_tlb_all_local();
 }
=20
-static spinlock_t migration_lock =3D SPIN_LOCK_UNLOCKED;
-static task_t *new_task;
-
-/*
- * This function sends a 'task migration' IPI to another CPU.
- * Must be called from syscall contexts, with interrupts *enabled*.
- */
-void smp_migrate_task(int cpu, task_t *p)
-{
-	/*
-	 * The target CPU will unlock the migration spinlock:
-	 */
-	spin_lock(&migration_lock);
-	new_task =3D p;
-	send_IPI_mask(1 << cpu, TASK_MIGRATION_VECTOR);
-}
-
-/*
- * Task migration callback.
- */
-asmlinkage void smp_task_migration_interrupt(void)
-{
-	task_t *p;
-
-	ack_APIC_irq();
-	p =3D new_task;
-	spin_unlock(&migration_lock);
-	sched_task_migrated(p);
-}
 /*
  * this function sends a 'reschedule' IPI to another CPU.
  * it goes straight through and wastes no time serializing
diff -urN linux-2.4.19-pre7-ac2/fs/pipe.c linux/fs/pipe.c
--- linux-2.4.19-pre7-ac2/fs/pipe.c	Sat Apr 20 17:44:56 2002
+++ linux/fs/pipe.c	Sat Apr 20 18:44:35 2002
@@ -115,7 +115,7 @@
 		 * writers synchronously that there is more
 		 * room.
 		 */
-		wake_up_interruptible_sync(PIPE_WAIT(*inode));
+		wake_up_interruptible(PIPE_WAIT(*inode));
 		if (!PIPE_EMPTY(*inode))
 			BUG();
 		goto do_more_read;
@@ -215,7 +215,7 @@
 			 * is going to give up this CPU, so it doesnt have
 			 * to do idle reschedules.
 			 */
-			wake_up_interruptible_sync(PIPE_WAIT(*inode));
+			wake_up_interruptible(PIPE_WAIT(*inode));
 			PIPE_WAITING_WRITERS(*inode)++;
 			pipe_wait(inode);
 			PIPE_WAITING_WRITERS(*inode)--;
diff -urN linux-2.4.19-pre7-ac2/include/asm-i386/hw_irq.h linux/include/asm=
-i386/hw_irq.h
--- linux-2.4.19-pre7-ac2/include/asm-i386/hw_irq.h	Sat Apr 20 17:45:18 200=
2
+++ linux/include/asm-i386/hw_irq.h	Sat Apr 20 19:06:12 2002
@@ -41,8 +41,7 @@
 #define ERROR_APIC_VECTOR	0xfe
 #define INVALIDATE_TLB_VECTOR	0xfd
 #define RESCHEDULE_VECTOR	0xfc
-#define TASK_MIGRATION_VECTOR	0xfb
-#define CALL_FUNCTION_VECTOR	0xfa
+#define CALL_FUNCTION_VECTOR	0xfb
=20
 /*
  * Local APIC timer IRQ vector is on a different priority level,
diff -urN linux-2.4.19-pre7-ac2/include/linux/sched.h linux/include/linux/s=
ched.h
--- linux-2.4.19-pre7-ac2/include/linux/sched.h	Sat Apr 20 17:45:12 2002
+++ linux/include/linux/sched.h	Sat Apr 20 19:06:13 2002
@@ -149,8 +149,7 @@
 extern void update_one_process(task_t *p, unsigned long user,
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
-extern void sched_task_migrated(task_t *p);
-extern void smp_migrate_task(int cpu, task_t *task);
+extern void migration_init(void);
 extern unsigned long cache_decay_ticks;
 extern int set_user(uid_t new_ruid, int dumpclear);
=20
@@ -450,7 +449,12 @@
  */
 #define _STK_LIM	(8*1024*1024)
=20
+#if CONFIG_SMP
 extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
+#else
+#define set_cpus_allowed(p, new_mask)	do { } while (0)
+#endif
+
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
@@ -577,7 +581,6 @@
 #define CURRENT_TIME (xtime.tv_sec)
=20
 extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, in=
t nr));
-extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mod=
e, int nr));
 extern void FASTCALL(sleep_on(wait_queue_head_t *q));
 extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
 				      signed long timeout));
@@ -591,13 +594,9 @@
 #define wake_up(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIB=
LE, 1)
 #define wake_up_nr(x, nr)		__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTER=
RUPTIBLE, nr)
 #define wake_up_all(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRU=
PTIBLE, 0)
-#define wake_up_sync(x)			__wake_up_sync((x),TASK_UNINTERRUPTIBLE | TASK_I=
NTERRUPTIBLE, 1)
-#define wake_up_sync_nr(x, nr)		__wake_up_sync((x),TASK_UNINTERRUPTIBLE | =
TASK_INTERRUPTIBLE, nr)
 #define wake_up_interruptible(x)	__wake_up((x),TASK_INTERRUPTIBLE, 1)
 #define wake_up_interruptible_nr(x, nr)	__wake_up((x),TASK_INTERRUPTIBLE, =
nr)
 #define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
-#define wake_up_interruptible_sync(x)	__wake_up_sync((x),TASK_INTERRUPTIBL=
E, 1)
-#define wake_up_interruptible_sync_nr(x) __wake_up_sync((x),TASK_INTERRUPT=
IBLE,  nr)
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options,=
 struct rusage * ru);
=20
 extern int in_group_p(gid_t);
@@ -919,6 +918,31 @@
 	return res;
 }
=20
+static inline void set_need_resched(void)
+{
+	current->need_resched =3D 1;
+}
+
+static inline void clear_need_resched(void)
+{
+	current->need_resched =3D 0;
+}
+
+static inline void set_tsk_need_resched(struct task_struct *tsk)
+{
+	tsk->need_resched =3D 1;
+}
+
+static inline void clear_tsk_need_resched(struct task_struct *tsk)
+{
+	tsk->need_resched =3D 0;
+}
+
+static inline int need_resched(void)
+{
+	return unlikely(current->need_resched);
+}
+
 #endif /* __KERNEL__ */
=20
 #endif
diff -urN linux-2.4.19-pre7-ac2/init/main.c linux/init/main.c
--- linux-2.4.19-pre7-ac2/init/main.c	Sat Apr 20 17:45:10 2002
+++ linux/init/main.c	Sat Apr 20 18:59:23 2002
@@ -458,6 +458,10 @@
  */
 static void __init do_basic_setup(void)
 {
+	/* Start the per-CPU migration threads */
+#if CONFIG_SMP
+	migration_init();
+#endif
=20
 	/*
 	 * Tell the world that we're going to be the grim
diff -urN linux-2.4.19-pre7-ac2/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.4.19-pre7-ac2/kernel/ksyms.c	Sat Apr 20 17:45:10 2002
+++ linux/kernel/ksyms.c	Sat Apr 20 18:59:23 2002
@@ -434,7 +434,6 @@
 /* process management */
 EXPORT_SYMBOL(complete_and_exit);
 EXPORT_SYMBOL(__wake_up);
-EXPORT_SYMBOL(__wake_up_sync);
 EXPORT_SYMBOL(wake_up_process);
 EXPORT_SYMBOL(sleep_on);
 EXPORT_SYMBOL(sleep_on_timeout);
@@ -444,7 +443,9 @@
 EXPORT_SYMBOL(schedule_timeout);
 EXPORT_SYMBOL(sys_sched_yield);
 EXPORT_SYMBOL(set_user_nice);
-EXPORT_SYMBOL(set_cpus_allowed);
+#ifdef CONFIG_SMP
+EXPORT_SYMBOL_GPL(set_cpus_allowed);
+#endif
 EXPORT_SYMBOL(jiffies);
 EXPORT_SYMBOL(xtime);
 EXPORT_SYMBOL(do_gettimeofday);
diff -urN linux-2.4.19-pre7-ac2/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-pre7-ac2/kernel/sched.c	Sat Apr 20 17:45:10 2002
+++ linux/kernel/sched.c	Sat Apr 20 19:03:14 2002
@@ -22,17 +22,18 @@
 #include <linux/kernel_stat.h>
=20
 /*
- * Priority of a process goes from 0 to 139. The 0-99
- * priority range is allocated to RT tasks, the 100-139
- * range is for SCHED_OTHER tasks. Priority values are
- * inverted: lower p->prio value means higher priority.
+ * Priority of a process goes from 0 to MAX_PRIO-1.  The
+ * 0 to MAX_RT_PRIO-1 priority range is allocated to RT tasks,
+ * the MAX_RT_PRIO to MAX_PRIO range is for SCHED_OTHER tasks.
+ * Priority values are inverted: lower p->prio value means higher
+ * priority.
  */
 #define MAX_RT_PRIO		100
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
=20
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
- * to static priority [ 100 ... 139 (MAX_PRIO-1) ],
+ * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
  * and back.
  */
 #define NICE_TO_PRIO(nice)	(MAX_RT_PRIO + (nice) + 20)
@@ -125,8 +126,6 @@
=20
 struct prio_array {
 	int nr_active;
-	spinlock_t *lock;
-	runqueue_t *rq;
 	unsigned long bitmap[BITMAP_SIZE];
 	list_t queue[MAX_PRIO];
 };
@@ -140,10 +139,13 @@
  */
 struct runqueue {
 	spinlock_t lock;
+	spinlock_t frozen;
 	unsigned long nr_running, nr_switches, expired_timestamp;
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
+	task_t *migration_thread;
+	list_t migration_queue;
 } ____cacheline_aligned;
=20
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -154,21 +156,21 @@
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
=20
-static inline runqueue_t *lock_task_rq(task_t *p, unsigned long *flags)
+static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
 {
-	struct runqueue *__rq;
+	struct runqueue *rq;
=20
 repeat_lock_task:
-	__rq =3D task_rq(p);
-	spin_lock_irqsave(&__rq->lock, *flags);
-	if (unlikely(__rq !=3D task_rq(p))) {
-		spin_unlock_irqrestore(&__rq->lock, *flags);
+	rq =3D task_rq(p);
+	spin_lock_irqsave(&rq->lock, *flags);
+	if (unlikely(rq !=3D task_rq(p))) {
+		spin_unlock_irqrestore(&rq->lock, *flags);
 		goto repeat_lock_task;
 	}
-	return __rq;
+	return rq;
 }
=20
-static inline void unlock_task_rq(runqueue_t *rq, unsigned long *flags)
+static inline void task_rq_unlock(runqueue_t *rq, unsigned long *flags)
 {
 	spin_unlock_irqrestore(&rq->lock, *flags);
 }
@@ -179,7 +181,7 @@
 static inline void dequeue_task(struct task_struct *p, prio_array_t *array=
)
 {
 	array->nr_active--;
-	list_del_init(&p->run_list);
+	list_del(&p->run_list);
 	if (list_empty(array->queue + p->prio))
 		__clear_bit(p->prio, array->bitmap);
 }
@@ -253,7 +255,7 @@
=20
 	need_resched =3D p->need_resched;
 	wmb();
-	p->need_resched =3D 1;
+	set_tsk_need_resched(p);
 	if (!need_resched && (p->cpu !=3D smp_processor_id()))
 		smp_send_reschedule(p->cpu);
 }
@@ -275,26 +277,12 @@
 		cpu_relax();
 		barrier();
 	}
-	rq =3D lock_task_rq(p, &flags);
+	rq =3D task_rq_lock(p, &flags);
 	if (unlikely(rq->curr =3D=3D p)) {
-		unlock_task_rq(rq, &flags);
+		task_rq_unlock(rq, &flags);
 		goto repeat;
 	}
-	unlock_task_rq(rq, &flags);
-}
-
-/*
- * The SMP message passing code calls this function whenever
- * the new task has arrived at the target CPU. We move the
- * new task into the local runqueue.
- *
- * This function must be called with interrupts disabled.
- */
-void sched_task_migrated(task_t *new_task)
-{
-	wait_task_inactive(new_task);
-	new_task->cpu =3D smp_processor_id();
-	wake_up_process(new_task);
+	task_rq_unlock(rq, &flags);
 }
=20
 /*
@@ -321,32 +309,35 @@
  * "current->state =3D TASK_RUNNING" to mark yourself runnable
  * without the overhead of this.
  */
-static int try_to_wake_up(task_t * p, int synchronous)
+static int try_to_wake_up(task_t * p)
 {
 	unsigned long flags;
 	int success =3D 0;
 	runqueue_t *rq;
=20
-	rq =3D lock_task_rq(p, &flags);
+	rq =3D task_rq_lock(p, &flags);
 	p->state =3D TASK_RUNNING;
 	if (!p->array) {
 		activate_task(p, rq);
-		if ((rq->curr =3D=3D rq->idle) || (p->prio < rq->curr->prio))
+		if (p->prio < rq->curr->prio)
 			resched_task(rq->curr);
 		success =3D 1;
 	}
-	unlock_task_rq(rq, &flags);
+	task_rq_unlock(rq, &flags);
 	return success;
 }
=20
 int wake_up_process(task_t * p)
 {
-	return try_to_wake_up(p, 0);
+	return try_to_wake_up(p);
 }
=20
 void wake_up_forked_process(task_t * p)
 {
-	runqueue_t *rq =3D this_rq();
+	runqueue_t *rq;
+
+	rq =3D this_rq();
+	spin_lock_irq(&rq->lock);
=20
 	p->state =3D TASK_RUNNING;
 	if (!rt_task(p)) {
@@ -359,7 +350,6 @@
 		p->sleep_avg =3D p->sleep_avg * CHILD_PENALTY / 100;
 		p->prio =3D effective_prio(p);
 	}
-	spin_lock_irq(&rq->lock);
 	p->cpu =3D smp_processor_id();
 	activate_task(p, rq);
 	spin_unlock_irq(&rq->lock);
@@ -393,7 +383,7 @@
 #if CONFIG_SMP
 asmlinkage void schedule_tail(task_t *prev)
 {
-	spin_unlock_irq(&this_rq()->lock);
+	spin_unlock_irq(&this_rq()->frozen);
 }
 #endif
=20
@@ -416,16 +406,7 @@
 		mmdrop(oldmm);
 	}
=20
-	/*
-	 * Here we just switch the register state and the stack. There are
-	 * 3 processes affected by a context switch:
-	 *
-	 * prev =3D=3D> .... =3D=3D> (last =3D> next)
-	 *
-	 * It's the 'much more previous' 'prev' that is on next's stack,
-	 * but prev is set to (the just run) 'last' process by switch_to().
-	 * This might sound slightly confusing but makes tons of sense.
-	 */
+	/* Here we just switch the register state and the stack. */
 	switch_to(prev, next, prev);
 }
=20
@@ -520,12 +501,14 @@
 	busiest =3D NULL;
 	max_load =3D 1;
 	for (i =3D 0; i < smp_num_cpus; i++) {
-		rq_src =3D cpu_rq(cpu_logical_map(i));
-		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[i]))
+		int logical =3D cpu_logical_map(i);
+
+		rq_src =3D cpu_rq(logical);
+		if (idle || (rq_src->nr_running < this_rq->prev_nr_running[logical]))
 			load =3D rq_src->nr_running;
 		else
-			load =3D this_rq->prev_nr_running[i];
-		this_rq->prev_nr_running[i] =3D rq_src->nr_running;
+			load =3D this_rq->prev_nr_running[logical];
+		this_rq->prev_nr_running[logical] =3D rq_src->nr_running;
=20
 		if ((load > max_load) && (rq_src !=3D this_rq)) {
 			busiest =3D rq_src;
@@ -547,7 +530,7 @@
 	 * Make sure nothing changed since we checked the
 	 * runqueue length.
 	 */
-	if (busiest->nr_running <=3D this_rq->nr_running + 1)
+	if (busiest->nr_running <=3D nr_running + 1)
 		goto out_unlock;
=20
 	/*
@@ -592,7 +575,7 @@
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
 	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
 		((p) !=3D (rq)->curr) &&					\
-			(tmp->cpus_allowed & (1 << (this_cpu))))
+			((p)->cpus_allowed & (1 << (this_cpu))))
=20
 	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
 		curr =3D curr->next;
@@ -612,7 +595,7 @@
 	this_rq->nr_running++;
 	enqueue_task(next, this_rq->active);
 	if (next->prio < current->prio)
-		current->need_resched =3D 1;
+		set_need_resched();
 	if (!idle && --imbalance) {
 		if (array =3D=3D busiest->expired) {
 			array =3D busiest->active;
@@ -686,7 +669,7 @@
=20
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array !=3D rq->active) {
-		p->need_resched =3D 1;
+		set_tsk_need_resched(p);
 		return;
 	}
 	spin_lock(&rq->lock);
@@ -697,7 +680,7 @@
 		 */
 		if ((p->policy =3D=3D SCHED_RR) && !--p->time_slice) {
 			p->time_slice =3D TASK_TIMESLICE(p);
-			p->need_resched =3D 1;
+			set_tsk_need_resched(p);
=20
 			/* put it at the end of the queue: */
 			dequeue_task(p, rq->active);
@@ -717,7 +700,7 @@
 		p->sleep_avg--;
 	if (!--p->time_slice) {
 		dequeue_task(p, rq->active);
-		p->need_resched =3D 1;
+		set_tsk_need_resched(p);
 		p->prio =3D effective_prio(p);
 		p->time_slice =3D TASK_TIMESLICE(p);
=20
@@ -743,14 +726,18 @@
  */
 asmlinkage void schedule(void)
 {
-	task_t *prev =3D current, *next;
-	runqueue_t *rq =3D this_rq();
+	task_t *prev, *next;
+	runqueue_t *rq;
 	prio_array_t *array;
 	list_t *queue;
 	int idx;
=20
 	BUG_ON(in_interrupt());
=20
+need_resched:
+	prev =3D current;
+	rq =3D this_rq();
+
 	release_kernel_lock(prev, smp_processor_id());
 	prev->sleep_timestamp =3D jiffies;
 	spin_lock_irq(&rq->lock);
@@ -797,23 +784,30 @@
=20
 switch_tasks:
 	prefetch(next);
-	prev->need_resched =3D 0;
+	clear_tsk_need_resched(prev);
=20
 	if (likely(prev !=3D next)) {
 		rq->nr_switches++;
 		rq->curr =3D next;
+		spin_lock(&rq->frozen);
+		spin_unlock(&rq->lock);
+	=09
 		context_switch(prev, next);
 		/*
 		 * The runqueue pointer might be from another CPU
 		 * if the new task was last running on a different
 		 * CPU - thus re-load it.
 		 */
-		barrier();
+		mb();
 		rq =3D this_rq();
+		spin_unlock_irq(&rq->frozen);
+	} else {
+		spin_unlock_irq(&rq->lock);
 	}
-	spin_unlock_irq(&rq->lock);
=20
 	reacquire_kernel_lock(current);
+	if (need_resched())
+		goto need_resched;
 	return;
 }
=20
@@ -826,44 +820,34 @@
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() retu=
rns
  * zero in this (rare) case, and we handle it by continuing to scan the qu=
eue.
  */
-static inline void __wake_up_common (wait_queue_head_t *q, unsigned int mo=
de,
-			 	     int nr_exclusive, const int sync)
+static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mod=
e,
+				    int nr_exclusive)
 {
 	struct list_head *tmp;
+	unsigned int state;
+	wait_queue_t *curr;
 	task_t *p;
=20
-	list_for_each(tmp,&q->task_list) {
-		unsigned int state;
-		wait_queue_t *curr =3D list_entry(tmp, wait_queue_t, task_list);
-
+	list_for_each(tmp, &q->task_list) {
+		curr =3D list_entry(tmp, wait_queue_t, task_list);
 		p =3D curr->task;
 		state =3D p->state;
-		if ((state & mode) &&
-				try_to_wake_up(p, sync) &&
-				((curr->flags & WQ_FLAG_EXCLUSIVE) &&
-					!--nr_exclusive))
-			break;
+		if ((state & mode) && try_to_wake_up(p) &&
+			((curr->flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive))
+				break;
 	}
 }
=20
-void __wake_up(wait_queue_head_t *q, unsigned int mode, int nr)
+void __wake_up(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
 {
-	if (q) {
-		unsigned long flags;
-		wq_read_lock_irqsave(&q->lock, flags);
-		__wake_up_common(q, mode, nr, 0);
-		wq_read_unlock_irqrestore(&q->lock, flags);
-	}
-}
+	unsigned long flags;
=20
-void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr)
-{
-	if (q) {
-		unsigned long flags;
-		wq_read_lock_irqsave(&q->lock, flags);
-		__wake_up_common(q, mode, nr, 1);
-		wq_read_unlock_irqrestore(&q->lock, flags);
-	}
+	if (unlikely(!q))
+		return;
+
+	wq_read_lock_irqsave(&q->lock, flags);
+	__wake_up_common(q, mode, nr_exclusive);
+	wq_read_unlock_irqrestore(&q->lock, flags);
 }
=20
 void complete(struct completion *x)
@@ -872,7 +856,7 @@
=20
 	wq_write_lock_irqsave(&x->wait.lock, flags);
 	x->done++;
-	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, =
0);
+	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1);
 	wq_write_unlock_irqrestore(&x->wait.lock, flags);
 }
=20
@@ -959,34 +943,6 @@
 	return timeout;
 }
=20
-/*
- * Change the current task's CPU affinity. Migrate the process to a
- * proper CPU and schedule away if the current CPU is removed from
- * the allowed bitmask.
- */
-void set_cpus_allowed(task_t *p, unsigned long new_mask)
-{
-	new_mask &=3D cpu_online_map;
-	if (!new_mask)
-		BUG();
-	if (p !=3D current)
-		BUG();
-
-	p->cpus_allowed =3D new_mask;
-	/*
-	 * Can the task run on the current CPU? If not then
-	 * migrate the process off to a proper CPU.
-	 */
-	if (new_mask & (1UL << smp_processor_id()))
-		return;
-#if CONFIG_SMP
-	current->state =3D TASK_UNINTERRUPTIBLE;
-	smp_migrate_task(__ffs(new_mask), current);
-
-	schedule();
-#endif
-}
-
 void scheduling_functions_end_here(void) { }
=20
 void set_user_nice(task_t *p, long nice)
@@ -1001,7 +957,7 @@
 	 * We have to be careful, if called from sys_setpriority(),
 	 * the task might be in the middle of scheduling on another CPU.
 	 */
-	rq =3D lock_task_rq(p, &flags);
+	rq =3D task_rq_lock(p, &flags);
 	if (rt_task(p)) {
 		p->static_prio =3D NICE_TO_PRIO(nice);
 		goto out_unlock;
@@ -1021,7 +977,7 @@
 			resched_task(rq->curr);
 	}
 out_unlock:
-	unlock_task_rq(rq, &flags);
+	task_rq_unlock(rq, &flags);
 }
=20
 #ifndef __alpha__
@@ -1069,7 +1025,7 @@
  */
 int task_prio(task_t *p)
 {
-	return p->prio - 100;
+	return p->prio - MAX_RT_PRIO;
 }
=20
 int task_nice(task_t *p)
@@ -1114,7 +1070,7 @@
 	 * To be able to change p->policy safely, the apropriate
 	 * runqueue lock must be held.
 	 */
-	rq =3D lock_task_rq(p, &flags);
+	rq =3D task_rq_lock(p, &flags);
=20
 	if (policy < 0)
 		policy =3D p->policy;
@@ -1124,13 +1080,13 @@
 				policy !=3D SCHED_OTHER)
 			goto out_unlock;
 	}
-=09
+
 	/*
-	 * Valid priorities for SCHED_FIFO and SCHED_RR are 1..99, valid
-	 * priority for SCHED_OTHER is 0.
+	 * Valid priorities for SCHED_FIFO and SCHED_RR are 1..MAX_RT_PRIO-1,
+	 * valid priority for SCHED_OTHER is 0.
 	 */
 	retval =3D -EINVAL;
-	if (lp.sched_priority < 0 || lp.sched_priority > 99)
+	if (lp.sched_priority < 0 || lp.sched_priority > MAX_RT_PRIO - 1)
 		goto out_unlock;
 	if ((policy =3D=3D SCHED_OTHER) !=3D (lp.sched_priority =3D=3D 0))
 		goto out_unlock;
@@ -1149,15 +1105,15 @@
 	retval =3D 0;
 	p->policy =3D policy;
 	p->rt_priority =3D lp.sched_priority;
-	if (rt_task(p))
-		p->prio =3D 99 - p->rt_priority;
+	if (policy !=3D SCHED_OTHER)
+		p->prio =3D (MAX_RT_PRIO - 1) - p->rt_priority;
 	else
 		p->prio =3D p->static_prio;
 	if (array)
 		activate_task(p, task_rq(p));
=20
 out_unlock:
-	unlock_task_rq(rq, &flags);
+	task_rq_unlock(rq, &flags);
 out_unlock_tasklist:
 	read_unlock_irq(&tasklist_lock);
=20
@@ -1229,17 +1185,11 @@
=20
 asmlinkage long sys_sched_yield(void)
 {
-	task_t *prev =3D current, *next;
-	runqueue_t *rq =3D this_rq();
+	runqueue_t *rq;
 	prio_array_t *array;
-	list_t *queue;
=20
-	if (unlikely(prev->state !=3D TASK_RUNNING)) {
-		schedule();
-		return 0;
-	}
-	release_kernel_lock(prev, smp_processor_id());
-	prev->sleep_timestamp =3D jiffies;
+	rq =3D this_rq();
+
 	/*
 	 * Decrease the yielding task's priority by one, to avoid
 	 * livelocks. This priority loss is temporary, it's recovered
@@ -1265,27 +1215,9 @@
 		list_add_tail(&current->run_list, array->queue + current->prio);
 		__set_bit(current->prio, array->bitmap);
 	}
-	/*
-	 * Context-switch manually. This is equivalent to
-	 * calling schedule(), but faster, because yield()
-	 * knows lots of things that can be optimized away
-	 * from the generic scheduler path:
-	 */
-	queue =3D array->queue + sched_find_first_bit(array->bitmap);
-	next =3D list_entry(queue->next, task_t, run_list);
-	prefetch(next);
-
-	prev->need_resched =3D 0;
-	if (likely(prev !=3D next)) {
-		rq->nr_switches++;
-		rq->curr =3D next;
-		context_switch(prev, next);
-		barrier();
-		rq =3D this_rq();
-	}
-	spin_unlock_irq(&rq->lock);
+	spin_unlock(&rq->lock);
=20
-	reacquire_kernel_lock(current);
+	schedule();
=20
 	return 0;
 }
@@ -1297,7 +1229,7 @@
 	switch (policy) {
 	case SCHED_FIFO:
 	case SCHED_RR:
-		ret =3D 99;
+		ret =3D MAX_RT_PRIO - 1;
 		break;
 	case SCHED_OTHER:
 		ret =3D 0;
@@ -1436,6 +1368,12 @@
 	read_unlock(&tasklist_lock);
 }
=20
+/*
+ * double_rq_lock - safely lock two runqueues
+ *
+ * Note this does not disable interrupts like task_rq_lock,
+ * you need to do so manually before calling.
+ */
 static inline void double_rq_lock(runqueue_t *rq1, runqueue_t *rq2)
 {
 	if (rq1 =3D=3D rq2)
@@ -1451,6 +1389,12 @@
 	}
 }
=20
+/*
+ * double_rq_unlock - safely unlock two runqueues
+ *
+ * Note this does not restore interrupts like task_rq_unlock,
+ * you need to do so manually after calling.
+ */
 static inline void double_rq_unlock(runqueue_t *rq1, runqueue_t *rq2)
 {
 	spin_unlock(&rq1->lock);
@@ -1460,7 +1404,7 @@
=20
 void init_idle(task_t *idle, int cpu)
 {
-	runqueue_t *idle_rq =3D cpu_rq(cpu), *rq =3D idle->array->rq;
+	runqueue_t *idle_rq =3D cpu_rq(cpu), *rq =3D cpu_rq(idle->cpu);
 	unsigned long flags;
=20
 	__save_flags(flags);
@@ -1474,7 +1418,7 @@
 	idle->state =3D TASK_RUNNING;
 	idle->cpu =3D cpu;
 	double_rq_unlock(idle_rq, rq);
-	idle->need_resched =3D 1;
+	set_tsk_need_resched(idle);
 	__restore_flags(flags);
 }
=20
@@ -1492,14 +1436,14 @@
 		runqueue_t *rq =3D cpu_rq(i);
 		prio_array_t *array;
=20
-		rq->active =3D rq->arrays + 0;
+		rq->active =3D rq->arrays;
 		rq->expired =3D rq->arrays + 1;
 		spin_lock_init(&rq->lock);
+		spin_lock_init(&rq->frozen);
+		INIT_LIST_HEAD(&rq->migration_queue);
=20
 		for (j =3D 0; j < 2; j++) {
 			array =3D rq->arrays + j;
-			array->rq =3D rq;
-			array->lock =3D &rq->lock;
 			for (k =3D 0; k < MAX_PRIO; k++) {
 				INIT_LIST_HEAD(array->queue + k);
 				__clear_bit(k, array->bitmap);
@@ -1528,3 +1472,216 @@
 	atomic_inc(&init_mm.mm_count);
 	enter_lazy_tlb(&init_mm, current, smp_processor_id());
 }
+
+#if CONFIG_SMP
+
+/*
+ * This is how migration works:
+ *
+ * 1) we queue a migration_req_t structure in the source CPU's
+ *    runqueue and wake up that CPU's migration thread.
+ * 2) we down() the locked semaphore =3D> thread blocks.
+ * 3) migration thread wakes up (implicitly it forces the migrated
+ *    thread off the CPU)
+ * 4) it gets the migration request and checks whether the migrated
+ *    task is still in the wrong runqueue.
+ * 5) if it's in the wrong runqueue then the migration thread removes
+ *    it and puts it into the right queue.
+ * 6) migration thread up()s the semaphore.
+ * 7) we wake up and the migration is done.
+ */
+
+typedef struct {
+	list_t list;
+	task_t *task;
+	struct semaphore sem;
+} migration_req_t;
+
+/*
+ * Change a given task's CPU affinity. Migrate the process to a
+ * proper CPU and schedule it away if the CPU it's executing on
+ * is removed from the allowed bitmask.
+ *
+ * NOTE: the caller must have a valid reference to the task, the
+ * task must not exit() & deallocate itself prematurely.  No
+ * spinlocks can be held.
+ */
+void set_cpus_allowed(task_t *p, unsigned long new_mask)
+{
+	unsigned long flags;
+	migration_req_t req;
+	runqueue_t *rq;
+
+	new_mask &=3D cpu_online_map;
+	if (!new_mask)
+		BUG();
+
+	rq =3D task_rq_lock(p, &flags);
+	p->cpus_allowed =3D new_mask;
+	/*
+	 * Can the task run on the task's current CPU? If not then
+	 * migrate the process off to a proper CPU.
+	 */
+	if (new_mask & (1UL << p->cpu)) {
+		task_rq_unlock(rq, &flags);
+		return;
+	}
+
+	init_MUTEX_LOCKED(&req.sem);
+	req.task =3D p;
+	list_add(&req.list, &rq->migration_queue);
+	task_rq_unlock(rq, &flags);
+	wake_up_process(rq->migration_thread);
+
+	down(&req.sem);
+}
+
+/*
+ * Treat the bits of migration_mask as lock bits.
+ * If the bit corresponding to the cpu a migration_thread is
+ * running on then we have failed to claim our cpu and must
+ * yield in order to find another.
+ */
+static volatile unsigned long migration_mask;
+static atomic_t migration_threads_seeking_cpu;
+static struct completion migration_complete
+			=3D COMPLETION_INITIALIZER(migration_complete);
+
+static int migration_thread(void * unused)
+{
+	struct sched_param param =3D { sched_priority: MAX_RT_PRIO - 1 };
+	runqueue_t *rq;
+	int ret;
+
+	daemonize();
+	sigfillset(&current->blocked);
+	set_fs(KERNEL_DS);
+	ret =3D setscheduler(0, SCHED_FIFO, &param);
+
+	/*
+	 * We have to migrate manually - there is no migration thread
+	 * to do this for us yet :-)
+	 *
+	 * We use the following property of the Linux scheduler. At
+	 * this point no other task is running, so by keeping all
+	 * migration threads running, the load-balancer will distribute
+	 * them between all CPUs equally. At that point every migration
+	 * task binds itself to the current CPU.
+	 */
+
+	/*
+	 * Enter the loop with preemption disabled so that
+	 * smp_processor_id() remains valid through the check. The
+	 * interior of the wait loop re-enables preemption in an
+	 * attempt to get scheduled off the current cpu. When the
+	 * loop is exited the lock bit in migration_mask is acquired
+	 * and preemption is disabled on the way out. This way the
+	 * cpu acquired remains valid when ->cpus_allowed is set.
+	 */
+	while (test_and_set_bit(smp_processor_id(), &migration_mask))
+		yield();
+
+	current->cpus_allowed =3D 1 << smp_processor_id();
+	rq =3D this_rq();
+	rq->migration_thread =3D current;
+
+	/*
+	 * Now that we've bound ourselves to a cpu, post to
+	 * migration_threads_seeking_cpu and wait for everyone else.
+	 * Preemption should remain disabled and the cpu should remain
+	 * in busywait. Yielding the cpu will allow the livelock
+	 * where where a timing pattern causes an idle task seeking a
+	 * migration_thread to always find the unbound migration_thread=20
+	 * running on the cpu's it tries to steal tasks from.
+	 */
+	atomic_dec(&migration_threads_seeking_cpu);
+	while (atomic_read(&migration_threads_seeking_cpu))
+		cpu_relax();
+
+	sprintf(current->comm, "migration_CPU%d", smp_processor_id());
+
+	/*
+	 * Everyone's found their cpu, so now wake migration_init().
+	 * Multiple wakeups are harmless; removal from the waitqueue
+	 * has locking built-in, and waking an empty queue is valid.
+	 */
+	complete(&migration_complete);
+
+	/*
+	 * Initiate the event loop.
+	 */
+	for (;;) {
+		runqueue_t *rq_src, *rq_dest;
+		struct list_head *head;
+		int cpu_src, cpu_dest;
+		migration_req_t *req;
+		unsigned long flags;
+		task_t *p;
+
+		spin_lock_irqsave(&rq->lock, flags);
+		head =3D &rq->migration_queue;
+		current->state =3D TASK_INTERRUPTIBLE;
+		if (list_empty(head)) {
+			spin_unlock_irqrestore(&rq->lock, flags);
+			schedule();
+			continue;
+		}
+		req =3D list_entry(head->next, migration_req_t, list);
+		list_del_init(head->next);
+		spin_unlock_irqrestore(&rq->lock, flags);
+
+		p =3D req->task;
+		cpu_dest =3D __ffs(p->cpus_allowed);
+		rq_dest =3D cpu_rq(cpu_dest);
+repeat:
+		cpu_src =3D p->cpu;
+		rq_src =3D cpu_rq(cpu_src);
+
+		local_irq_save(flags);
+		double_rq_lock(rq_src, rq_dest);
+		if (p->cpu !=3D cpu_src) {
+			local_irq_restore(flags);
+			double_rq_unlock(rq_src, rq_dest);
+			goto repeat;
+		}
+		if (rq_src =3D=3D rq) {
+			p->cpu =3D cpu_dest;
+			if (p->array) {
+				deactivate_task(p, rq_src);
+				activate_task(p, rq_dest);
+			}
+		}
+		local_irq_restore(flags);
+		double_rq_unlock(rq_src, rq_dest);
+
+		up(&req->sem);
+	}
+}
+
+void __init migration_init(void)
+{
+	unsigned long orig_cache_decay_ticks;
+	int cpu;
+
+	atomic_set(&migration_threads_seeking_cpu, smp_num_cpus);
+
+	orig_cache_decay_ticks =3D cache_decay_ticks;
+	cache_decay_ticks =3D 0;
+
+	for (cpu =3D 0; cpu < smp_num_cpus; cpu++)
+		if (kernel_thread(migration_thread, NULL,
+				CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
+			BUG();
+
+	/*
+	 * We cannot have missed the wakeup for the migration_thread
+	 * bound for the cpu migration_init() is running on cannot
+	 * acquire this cpu until migration_init() has yielded it by
+	 * means of wait_for_completion().
+	 */
+	wait_for_completion(&migration_complete);
+
+	cache_decay_ticks =3D orig_cache_decay_ticks;
+}
+
+#endif /* CONFIG_SMP */

--=-Njjp8etVoibhhXY5Q3Ak--

