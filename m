Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSGSOwX>; Fri, 19 Jul 2002 10:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316663AbSGSOwX>; Fri, 19 Jul 2002 10:52:23 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:33947 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S315285AbSGSOwU>; Fri, 19 Jul 2002 10:52:20 -0400
From: Erich Focht <efocht@ess.nec.de>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>
Subject: [PATCH]: scheduler complex macros fixes
Date: Fri, 19 Jul 2002 16:55:07 +0200
User-Agent: KMail/1.4.1
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_V34I8T6VRB7721QBGJAR"
Message-Id: <200207191655.07285.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_V34I8T6VRB7721QBGJAR
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

The attached patch fixes problems with the "complex" macros in the
scheduler, as discussed about a week ago with Ingo on this mailing list.
On some platforms (at least IA64, sparc64) the RQ lock must be released
before the context switch in order to avoid a potential deadlock. The
macros used in 2.5.26 are buggy and allow the load_balancer to steal the
prev task right before the context switch occurs. If the prev task
exits in the mean time, the kernel crashes.

These fixes are already in Ingo's patches for the SCHED_BATCH extension
but didn't make it into 2.5.26. They are a MUST for the platforms using
complex macros, please consider applying...

Regards,
Erich

--------------Boundary-00=_V34I8T6VRB7721QBGJAR
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="O1_schedfix-2.5.26.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="O1_schedfix-2.5.26.diff"

diff -urNp linux-2.5.26/include/asm-arm/system.h linux-2.5.26-schedfix/include/asm-arm/system.h
--- linux-2.5.26/include/asm-arm/system.h	Wed Jul 17 01:49:26 2002
+++ linux-2.5.26-schedfix/include/asm-arm/system.h	Fri Jul 19 15:44:20 2002
@@ -64,10 +64,9 @@ extern asmlinkage void __backtrace(void)
 struct thread_info;
 extern struct task_struct *__switch_to(struct thread_info *, struct thread_info *);
 
-#define prepare_arch_schedule(prev)		do { } while(0)
-#define finish_arch_schedule(prev)		do { } while(0)
-#define prepare_arch_switch(rq)			do { } while(0)
-#define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
+#define prepare_arch_switch(rq, next)	do { } while(0)
+#define finish_arch_switch(rq, prev)	spin_unlock_irq(&(rq)->lock)
+#define task_running(rq, p)		((rq)->curr == (p))
 
 #define switch_to(prev,next,last)					\
 	do {			 					\
diff -urNp linux-2.5.26/include/asm-i386/system.h linux-2.5.26-schedfix/include/asm-i386/system.h
--- linux-2.5.26/include/asm-i386/system.h	Wed Jul 17 01:49:22 2002
+++ linux-2.5.26-schedfix/include/asm-i386/system.h	Fri Jul 19 15:44:10 2002
@@ -11,10 +11,9 @@
 struct task_struct;	/* one of the stranger aspects of C forward declarations.. */
 extern void FASTCALL(__switch_to(struct task_struct *prev, struct task_struct *next));
 
-#define prepare_arch_schedule(prev)		do { } while(0)
-#define finish_arch_schedule(prev)		do { } while(0)
-#define prepare_arch_switch(rq)			do { } while(0)
-#define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
+#define prepare_arch_switch(rq, next)	do { } while(0)
+#define finish_arch_switch(rq, prev)	spin_unlock_irq(&(rq)->lock)
+#define task_running(rq, p)		((rq)->curr == (p))
 
 #define switch_to(prev,next,last) do {					\
 	asm volatile("pushl %%esi\n\t"					\
diff -urNp linux-2.5.26/include/asm-ia64/system.h linux-2.5.26-schedfix/include/asm-ia64/system.h
--- linux-2.5.26/include/asm-ia64/system.h	Wed Jul 17 01:49:32 2002
+++ linux-2.5.26-schedfix/include/asm-ia64/system.h	Fri Jul 19 13:40:26 2002
@@ -429,6 +429,10 @@ extern void ia64_load_extra (struct task
 } while (0)
 #endif
 
+#define prepare_arch_switch(rq, next)	do {spin_lock(&(next)->switch_lock); spin_unlock(&(rq)->lock);} while(0)
+#define finish_arch_switch(rq, prev)	do {spin_unlock_irq(&(prev)->switch_lock);} while(0)
+#define task_running(rq, p)	(((rq)->curr == (p)) || spin_is_locked(&(p)->switch_lock))
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
diff -urNp linux-2.5.26/include/asm-ppc/system.h linux-2.5.26-schedfix/include/asm-ppc/system.h
--- linux-2.5.26/include/asm-ppc/system.h	Wed Jul 17 01:49:32 2002
+++ linux-2.5.26-schedfix/include/asm-ppc/system.h	Fri Jul 19 15:44:35 2002
@@ -83,10 +83,9 @@ extern void cacheable_memzero(void *p, u
 struct device_node;
 extern void note_scsi_host(struct device_node *, void *);
 
-#define prepare_arch_schedule(prev)		do { } while(0)
-#define finish_arch_schedule(prev)		do { } while(0)
-#define prepare_arch_switch(rq)			do { } while(0)
-#define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
+#define prepare_arch_switch(rq, next)	do { } while(0)
+#define finish_arch_switch(rq, prev)	spin_unlock_irq(&(rq)->lock)
+#define task_running(rq, p)		((rq)->curr == (p))
 
 struct task_struct;
 extern void __switch_to(struct task_struct *, struct task_struct *);
diff -urNp linux-2.5.26/include/asm-s390/system.h linux-2.5.26-schedfix/include/asm-s390/system.h
--- linux-2.5.26/include/asm-s390/system.h	Wed Jul 17 01:49:38 2002
+++ linux-2.5.26-schedfix/include/asm-s390/system.h	Fri Jul 19 15:44:03 2002
@@ -18,10 +18,9 @@
 #endif
 #include <linux/kernel.h>
 
-#define prepare_arch_schedule(prev)		do { } while (0)
-#define finish_arch_schedule(prev)		do { } while (0)
-#define prepare_arch_switch(rq)			do { } while (0)
-#define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
+#define prepare_arch_switch(rq, next)	do { } while(0)
+#define finish_arch_switch(rq, prev)	spin_unlock_irq(&(rq)->lock)
+#define task_running(rq, p)		((rq)->curr == (p))
 
 #define switch_to(prev,next,last) do {					     \
 	if (prev == next)						     \
diff -urNp linux-2.5.26/include/asm-s390x/system.h linux-2.5.26-schedfix/include/asm-s390x/system.h
--- linux-2.5.26/include/asm-s390x/system.h	Wed Jul 17 01:49:38 2002
+++ linux-2.5.26-schedfix/include/asm-s390x/system.h	Fri Jul 19 15:44:28 2002
@@ -18,10 +18,9 @@
 #endif
 #include <linux/kernel.h>
 
-#define prepare_arch_schedule(prev)		do { } while (0)
-#define finish_arch_schedule(prev)		do { } while (0)
-#define prepare_arch_switch(rq)			do { } while (0)
-#define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
+#define prepare_arch_switch(rq, next)	do { } while(0)
+#define finish_arch_switch(rq, prev)	spin_unlock_irq(&(rq)->lock)
+#define task_running(rq, p)		((rq)->curr == (p))
 
 #define switch_to(prev,next),last do {					     \
 	if (prev == next)						     \
diff -urNp linux-2.5.26/include/asm-sparc64/system.h linux-2.5.26-schedfix/include/asm-sparc64/system.h
--- linux-2.5.26/include/asm-sparc64/system.h	Wed Jul 17 01:49:22 2002
+++ linux-2.5.26-schedfix/include/asm-sparc64/system.h	Fri Jul 19 15:52:41 2002
@@ -144,13 +144,12 @@ extern void __flushw_user(void);
 #define flush_user_windows flushw_user
 #define flush_register_windows flushw_all
 
-#define prepare_arch_schedule(prev)	task_lock(prev)
-#define finish_arch_schedule(prev)	task_unlock(prev)
-#define prepare_arch_switch(rq)		\
-do {	spin_unlock(&(rq)->lock);	\
-	flushw_all();			\
-} while (0)
-#define finish_arch_switch(rq)		__sti()
+#define prepare_arch_switch(rq, next)	do {spin_lock(&(next)->switch_lock); \
+					    spin_unlock(&(rq)->lock);
+					    flushw_all(); \
+					} while(0)
+#define finish_arch_switch(rq, prev)	do {spin_unlock_irq(&(prev)->switch_lock);} while(0)
+#define task_running(rq, p)	(((rq)->curr == (p)) || spin_is_locked(&(p)->switch_lock))
 
 #ifndef CONFIG_DEBUG_SPINLOCK
 #define CHECK_LOCKS(PREV)	do { } while(0)
diff -urNp linux-2.5.26/include/asm-x86_64/system.h linux-2.5.26-schedfix/include/asm-x86_64/system.h
--- linux-2.5.26/include/asm-x86_64/system.h	Wed Jul 17 01:49:29 2002
+++ linux-2.5.26-schedfix/include/asm-x86_64/system.h	Fri Jul 19 15:44:42 2002
@@ -13,10 +13,9 @@
 #define LOCK_PREFIX ""
 #endif
 
-#define prepare_arch_schedule(prev)            do { } while(0)
-#define finish_arch_schedule(prev)             do { } while(0)
-#define prepare_arch_switch(rq)                        do { } while(0)
-#define finish_arch_switch(rq)                 spin_unlock_irq(&(rq)->lock)
+#define prepare_arch_switch(rq, next)	do { } while(0)
+#define finish_arch_switch(rq, prev)	spin_unlock_irq(&(rq)->lock)
+#define task_running(rq, p)		((rq)->curr == (p))
 
 #define __STR(x) #x
 #define STR(x) __STR(x)
diff -urNp linux-2.5.26/include/linux/init_task.h linux-2.5.26-schedfix/include/linux/init_task.h
--- linux-2.5.26/include/linux/init_task.h	Wed Jul 17 01:49:25 2002
+++ linux-2.5.26-schedfix/include/linux/init_task.h	Fri Jul 19 13:42:23 2002
@@ -78,6 +78,7 @@
     pending:		{ NULL, &tsk.pending.head, {{0}}},		\
     blocked:		{{0}},						\
     alloc_lock:		SPIN_LOCK_UNLOCKED,				\
+    switch_lock:	SPIN_LOCK_UNLOCKED,				\
     journal_info:	NULL,						\
 }
 
diff -urNp linux-2.5.26/include/linux/sched.h linux-2.5.26-schedfix/include/linux/sched.h
--- linux-2.5.26/include/linux/sched.h	Wed Jul 17 01:49:25 2002
+++ linux-2.5.26-schedfix/include/linux/sched.h	Fri Jul 19 13:40:26 2002
@@ -359,6 +359,8 @@ struct task_struct {
    	u32 self_exec_id;
 /* Protection of (de-)allocation: mm, files, fs, tty */
 	spinlock_t alloc_lock;
+/* context-switch lock */
+	spinlock_t switch_lock;
 
 /* journalling filesystem info */
 	void *journal_info;
diff -urNp linux-2.5.26/kernel/#sched.c.rej# linux-2.5.26-schedfix/kernel/#sched.c.rej#
--- linux-2.5.26/kernel/fork.c	Wed Jul 17 01:49:25 2002
+++ linux-2.5.26-schedfix/kernel/fork.c	Fri Jul 19 13:40:26 2002
@@ -675,6 +675,7 @@ struct task_struct *do_fork(unsigned lon
 		init_completion(&vfork);
 	}
 	spin_lock_init(&p->alloc_lock);
+	spin_lock_init(&p->switch_lock);
 
 	clear_tsk_thread_flag(p,TIF_SIGPENDING);
 	init_sigpending(&p->pending);
diff -urNp linux-2.5.26/kernel/sched.c linux-2.5.26-schedfix/kernel/sched.c
--- linux-2.5.26/kernel/sched.c	Wed Jul 17 01:49:29 2002
+++ linux-2.5.26-schedfix/kernel/sched.c	Fri Jul 19 16:09:39 2002
@@ -306,7 +306,7 @@ void wait_task_inactive(task_t * p)
 repeat:
 	preempt_disable();
 	rq = task_rq(p);
-	if (unlikely(rq->curr == p)) {
+	if (unlikely(task_running(rq, p))) {
 		cpu_relax();
 		/*
 		 * enable/disable preemption just to make this
@@ -317,7 +317,7 @@ repeat:
 		goto repeat;
 	}
 	rq = task_rq_lock(p, &flags);
-	if (unlikely(rq->curr == p)) {
+	if (unlikely(task_running(rq, p))) {
 		task_rq_unlock(rq, &flags);
 		preempt_enable();
 		goto repeat;
@@ -337,7 +337,7 @@ repeat:
  */
 void kick_if_running(task_t * p)
 {
-	if (p == task_rq(p)->curr)
+	if ((task_running(task_rq(p), p)) && (p->cpu != smp_processor_id()))
 		resched_task(p);
 }
 #endif
@@ -365,7 +365,7 @@ repeat_lock_task:
 		 * Fast-migrate the task if it's not running or runnable
 		 * currently. Do not violate hard affinity.
 		 */
-		if (unlikely(sync && (rq->curr != p) &&
+		if (unlikely(sync && !task_running(rq, p) &&
 			(task_cpu(p) != smp_processor_id()) &&
 			(p->cpus_allowed & (1UL << smp_processor_id())))) {
 
@@ -443,8 +443,7 @@ void sched_exit(task_t * p)
 #if CONFIG_SMP || CONFIG_PREEMPT
 asmlinkage void schedule_tail(task_t *prev)
 {
-	finish_arch_switch(this_rq());
-	finish_arch_schedule(prev);
+	finish_arch_switch(this_rq(), prev);
 }
 #endif
 
@@ -646,7 +645,7 @@ skip_queue:
 
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
 	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
-		((p) != (rq)->curr) &&					\
+		((p) != (rq)->curr) &&	!task_running(rq, p)  &&	\
 			((p)->cpus_allowed & (1UL << (this_cpu))))
 
 	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
@@ -816,7 +815,6 @@ need_resched:
 	rq = this_rq();
 
 	release_kernel_lock(prev, smp_processor_id());
-	prepare_arch_schedule(prev);
 	prev->sleep_timestamp = jiffies;
 	spin_lock_irq(&rq->lock);
 
@@ -873,11 +871,11 @@ switch_tasks:
 		rq->nr_switches++;
 		rq->curr = next;
 	
-		prepare_arch_switch(rq);
+		prepare_arch_switch(rq, next);
 		prev = context_switch(prev, next);
 		barrier();
 		rq = this_rq();
-		finish_arch_switch(rq);
+		finish_arch_switch(rq, prev);
 	} else
 		spin_unlock_irq(&rq->lock);
 	finish_arch_schedule(prev);
@@ -1106,7 +1104,7 @@ void set_user_nice(task_t *p, long nice)
 		 * If the task is running and lowered its priority,
 		 * or increased its priority then reschedule its CPU:
 		 */
-		if ((NICE_TO_PRIO(nice) < p->static_prio) || (p == rq->curr))
+		if ((NICE_TO_PRIO(nice) < p->static_prio) || task_running(rq, p))
 			resched_task(rq->curr);
 	}
 out_unlock:
@@ -1779,7 +1777,7 @@ void set_cpus_allowed(task_t *p, unsigne
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
 	 */
-	if (!p->array && (p != rq->curr)) {
+	if (!p->array && !task_running(rq, p)) {
 		set_task_cpu(p, __ffs(p->cpus_allowed));
 		task_rq_unlock(rq, &flags);
 		goto out;

--------------Boundary-00=_V34I8T6VRB7721QBGJAR--

