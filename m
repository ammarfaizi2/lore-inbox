Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVHSXrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVHSXrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932757AbVHSXrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:47:55 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:6346
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932352AbVHSXry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:47:54 -0400
Subject: [PATCH 2.6.13-rc6-rt9]  PI aware dynamic priority adjustment
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ingo Molnar <mingo@elte.hu>
Cc: Roland McGrath <roland@redhat.com>, Oleg Nesterov <oleg@tv-sign.ru>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <20050818060126.GA13152@elte.hu>
References: <20050818060126.GA13152@elte.hu>
Content-Type: multipart/mixed; boundary="=-jS/4JlHkDI9NLW1dYTOJ"
Organization: linutronix
Date: Sat, 20 Aug 2005 01:48:23 +0200
Message-Id: <1124495303.23647.579.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jS/4JlHkDI9NLW1dYTOJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

On Thu, 2005-08-18 at 08:01 +0200, Ingo Molnar wrote:
> i have released the 2.6.13-rc6-rt9 tree, which can be downloaded from 
> the usual place:

I reworked the code for dynamically setting the priority of the hrtimer
softirq to be aware of PI. 

The current function "mutex_chprio()" in -rt9 is equivivalent to a
static priority assigment of the hrtimer softirq. The new PI aware
function resolves this nicely and the latency improvements are
impressive (factor 2-3). 

I stumbled over "//#define MUTEX_IRQS_OFF" in the first attempt. My
assumption that all code protected by pi_lock (which is a raw lock) is
irq save turned out to be  wrong. I missed that commented define :( 
I guess it was introduced during the "IRQ latency contest" to squeeze
out the last nsecs :)

Switching it back on is not really influencing system performance in a
measurable way, but it allows to use the pi aware boosting function in
irq context. 

Quite contrary it makes the system more snappy and the overall test
latencies go down. 

Ingo ???? 
I assume you run with tracing enabled all the time, which conceals this
regression.

This is not only a demand for HRT, I'm aware of a _real world_
application which requires such functionality depending on the status of
the device. It runs on a low performance machine so avoiding task
switches is really appreciated. 

--------------------------------------------

Find attached my current config and a simple test program for cyclic
scheduling. Read the top source comment what you need and where to get
it.

Please use the -n option for now until we have sorted out following
problems:

1. tasklist_lock contention

AFAICT tasklist_lock is the longest held lock in the kernel aside BKL,
but this problem seems to be solved.

send_sigqueue is called from posix_timer_fn() and acquires
tasklist_lock, which makes no sense to me.

send_sigqueue()s (l)onl(e)y user is the posix_timer function
(posix_timer_fn(), calling posix_timer_event()).

Each posix timer blocks the task from vanishing away by
get_task_struct(), which is protected by the held tasklist_lock.

The task can neither go away nor the signal handler can change until
put_task_struct() is called inside release_posix_timer(), which removes
any chance to do an invalid access to either task or sighand because the
relevant timer is deleted before the call to put_task_struct(). Also
this call is protected by tasklist_lock().

If I understand the code correctly then the tasklist_lock acquirement in
send_sigqueue() is superfluous. If not then the "(un)register action" of
put/get_task_struct() is just hot air action. AFAICS from kernel history
this interface was introduced to provide lock free access to certain
parts of the signaling code where the caller holds a reference to the
task structure instead of running through the PITA of find_task_by_pid()
- of course with tasklist_lock held - for every signal to deliver.

I ran already extensive tests on a kernel with the lock acquirement
removed without any problems - as expected by my shortsight :)

Can the experts please shed some light on me ?

Oleg, Paul, Roland ??? (Alphabetic order :)

If I'm not completely wrong, then this mechanism should be generalized
to allow other users than posixtimers a simple un/registering of this
protection. I know a couple of things where this would be useful. I'd be
happy to write up the relevant patch for the general interface.

If I missed something important, feel free to call me an (over-worked)
idiot :)


2. Drift of cyclic timers (armed by set_timer()):

Due to rounding errors and the drift adjustment code, the fixed
increment which is precalculated when the timer is set up and added on
rearm, I see creeping deviation from the timeline. 

I have a patch lined up to base the rearm on human (nsac) units, so this
effect will go away. But this is waste of time until (1.) is not solved.

George ???


Cheers,

tglx

-----------------------------------

Some numbers:

Test scenario:
PIII 666MHZ 128MB

Kernel command line: root=/dev/hda1 ro console=ttyS0,115200 lapic nmi_watchdog=2

Using lapic gives definitely better results than using the solely PIT
based version. Make sure to add it to your command line, if you have a
x86 box. PPC is fine without.


Load: 

ssh1# while true; do hackbench 20; done

ssh2# while true; do find -type f | xargs grep kernel; done 
(Over a large tree so caching is not relevant. The hd led is almost permanent on)

ping -f to the test box



All I(nterval)/Min/Act/Max values in usecs. 

test1:/home/tglx/cyclictest# ./cyclictest -p 80 -n -i 1100
293.12 276.22 198.22 88/202 12270 <---- output from /proc/loadavg

T: 0 ( 5407) P:80 I:    1100 C: 2047066 Min:       7 Act:      15 Max:      59

test1:/home/tglx/cyclictest# ./cyclictest -p 80 -n -t 2 -d 10
296.17 275.21 193.82 52/202 22270

T: 0 ( 5407) P:80 I:    1000 C: 1047066 Min:       7 Act:      15 Max:      60
T: 1 ( 5408) P:79 I:    1010 C: 1036659 Min:       7 Act:      11 Max:      79

test1:/home/tglx/cyclictest# ./cyclictest -p 80 -n -t 5
130.31 124.17 148.68 3/525 19070

T: 0 ( 5473) P:80 I:    1000 C: 2631537 Min:       7 Act:      18 Max:      73
T: 1 ( 5474) P:79 I:    1500 C: 1754358 Min:       7 Act:      15 Max:      70
T: 2 ( 5475) P:78 I:    2000 C: 1315769 Min:       6 Act:      13 Max:      70
T: 3 ( 5476) P:77 I:    2500 C: 1052615 Min:       7 Act:      12 Max:      68
T: 4 ( 5477) P:76 I:    3000 C:  877179 Min:       6 Act:      10 Max:      66

test1:/home/tglx/cyclictest# ./cyclictest -p 80 -n -t 5 -i 800 -d 240
177.44 130.70 129.67 15/176 7217

T: 0 (21198) P:80 I:     800 C: 1578221 Min:       7 Act:      13 Max:      82
T: 1 (21199) P:79 I:    1040 C: 1214016 Min:       7 Act:      12 Max:      84
T: 2 (21200) P:78 I:    1280 C:  986388 Min:       7 Act:      13 Max:      60
T: 3 (21201) P:77 I:    1520 C:  830643 Min:       7 Act:      14 Max:      71
T: 4 (21202) P:76 I:    1760 C:  717373 Min:       7 Act:      13 Max:      66

test1:/home/tglx/cyclictest# ./cyclictest -p 80 -n -t 5 -i 666 -d 33
79.75 106.97 106.85 43/869 30355

T: 0 (25687) P:80 I:     666 C: 9329552 Min:       6 Act:       9 Max:      79
T: 1 (25688) P:79 I:     699 C: 8889101 Min:       6 Act:      12 Max:      80
T: 2 (25689) P:78 I:     732 C: 8488363 Min:       6 Act:      10 Max:      87
T: 3 (25690) P:77 I:     765 C: 8122198 Min:       6 Act:      12 Max:      83
T: 4 (25692) P:76 I:     798 C: 7786318 Min:       6 Act:      10 Max:      94

-----------------------------------


diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6-rt9/include/linux/sched.h linux-2.6.13-rc6-rt9.work/include/linux/sched.h
--- linux-2.6.13-rc6-rt9/include/linux/sched.h	2005-08-18 17:37:42.000000000 +0200
+++ linux-2.6.13-rc6-rt9.work/include/linux/sched.h	2005-08-19 18:45:31.000000000 +0200
@@ -1134,7 +1134,7 @@ extern int idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, struct sched_param *);
 extern task_t *idle_task(int cpu);
 extern void mutex_setprio(task_t *p, int prio);
-extern void mutex_chprio(task_t *p, int prio);
+extern void pi_changeprio(task_t *p, int prio);
 extern int normal_prio(task_t *p);
 
 void yield(void);
diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6-rt9/kernel/rt.c linux-2.6.13-rc6-rt9.work/kernel/rt.c
--- linux-2.6.13-rc6-rt9/kernel/rt.c	2005-08-18 17:37:42.000000000 +0200
+++ linux-2.6.13-rc6-rt9.work/kernel/rt.c	2005-08-20 00:49:15.000000000 +0200
@@ -201,15 +201,9 @@ do {						\
 # define trace_local_irq_disable(ti)		raw_local_irq_disable()
 # define trace_local_irq_enable(ti)		raw_local_irq_enable()
 # define trace_local_irq_restore(flags, ti)	raw_local_irq_restore(flags)
-#else /* !CONFIG_RT_DEADLOCK_DETECT */
 
-/*
- * Two variants: irqs off and preempt-counter based.
- * preempt-counter based variant seems to be a bit faster.
- */
-//#define MUTEX_IRQS_OFF
+#else /* !CONFIG_RT_DEADLOCK_DETECT */
 
-#ifdef MUTEX_IRQS_OFF
 # define trace_lock_irq(lock, ti)		do { raw_local_irq_disable(); (void)(ti); } while (0)
 # define trace_lock_irqsave(lock, flags, ti)	do { raw_local_irq_save(flags); (void)(ti); } while (0)
 # define trace_unlock_irq(lock, ti)		raw_local_irq_enable()
@@ -217,15 +211,6 @@ do {						\
 # define trace_local_irq_disable(ti)		raw_local_irq_disable()
 # define trace_local_irq_enable(ti)		raw_local_irq_enable()
 # define trace_local_irq_restore(flags, ti)	raw_local_irq_restore(flags)
-#else
-# define trace_lock_irq(lock, ti)		preempt_disable_ti(ti)
-# define trace_lock_irqsave(lock, flags, ti)	do { (void)flags; preempt_disable_ti(ti); } while (0)
-# define trace_unlock_irq(lock, ti)		preempt_enable_ti(ti)
-# define trace_unlock_irqrestore(lock, flags, ti) do { (void)flags; preempt_enable_ti(ti); } while (0)
-# define trace_local_irq_disable(ti)		preempt_disable_ti(ti)
-# define trace_local_irq_enable(ti)		preempt_enable_ti(ti)
-# define trace_local_irq_restore(flags, ti)	do { (void)flags; preempt_enable_ti(ti); } while (0)
-#endif
 
 # define trace_unlock(lock, ti)			do { } while (0)
 
@@ -235,6 +220,7 @@ do {						\
 # define TRACE_WARN_ON_LOCKED(c)		do { } while (0)
 # define TRACE_OFF()				do { } while (0)
 # define TRACE_BUG_ON_LOCKED(c)			do { } while (0)
+
 #endif /* CONFIG_RT_DEADLOCK_DETECT */
 
 /*
@@ -829,6 +815,50 @@ static void pi_setprio(struct rt_mutex *
 	}
 }
 
+/* 
+ * Change priority of a task pi aware
+ * 
+ * There are several aspects to consider:
+ * - task is priority boosted
+ * - task is blocked on a mutex
+ *
+ */
+void pi_changeprio(struct task_struct *p, int prio)
+{
+	unsigned long flags;
+	int oldprio;
+
+	spin_lock_irqsave(&pi_lock, flags);
+
+	oldprio = p->normal_prio;
+	if (oldprio == prio)
+		goto out;
+
+	/* Set normal prio in any case */
+	p->normal_prio = prio;
+	
+	/* Check, if we can safely lower the priority */
+	if (prio > p->prio && !plist_empty(&p->pi_waiters)) {
+		struct rt_mutex_waiter *w;
+		w = plist_first_entry(&p->pi_waiters, 
+				      struct rt_mutex_waiter, pi_list);
+		if (w->ti->task->prio < prio)
+			prio = w->ti->task->prio;
+	}
+
+	if (prio == p->prio)
+		goto out;
+
+	/* Is task blocked on a mutex ? */
+	if (p->blocked_on)
+		pi_setprio(p->blocked_on->lock, p, prio);
+	else
+		mutex_setprio(p, prio);
+ out:
+	spin_unlock_irqrestore(&pi_lock, flags);
+
+}
+
 static void
 task_blocks_on_lock(struct rt_mutex_waiter *waiter, struct thread_info *ti,
 		    struct rt_mutex *lock __EIP_DECL__)
diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6-rt9/kernel/sched.c linux-2.6.13-rc6-rt9.work/kernel/sched.c
--- linux-2.6.13-rc6-rt9/kernel/sched.c	2005-08-18 17:37:42.000000000 +0200
+++ linux-2.6.13-rc6-rt9.work/kernel/sched.c	2005-08-19 18:44:31.000000000 +0200
@@ -3954,58 +3954,6 @@ void mutex_setprio(task_t *p, int prio)
 	task_rq_unlock(rq, &flags);
 }
 
-/*
- * Used by the PREEMPT_RT code to implement
- * priority inheritance logic for timers:
- *
- * (differs in that the priority change is permanent)
- */
-void mutex_chprio(task_t *p, int prio)
-{
-	unsigned long flags;
-	prio_array_t *array;
-	runqueue_t *rq;
-	int oldprio, prev_resched;
-
-	BUG_ON(prio < 0 || prio > MAX_PRIO);
-	WARN_ON(p->policy == SCHED_NORMAL);
-
-	rq = task_rq_lock(p, &flags);
-
-	oldprio = p->prio;
-	array = p->array;
-	if (array)
-		dequeue_task(p, array);
-	p->normal_prio = prio;
-	if (prio < p->prio)
-		p->prio = prio;
-
-	trace_special_pid(p->pid, oldprio, prio);
-	prev_resched = _need_resched();
-	if (array) {
-		/*
-		 * If changing to an RT priority then queue it
-		 * in the active array!
-		 */
-		if (rt_task(p))
-			array = rq->active;
-		enqueue_task(p, array);
-		/*
-		 * Reschedule if we are currently running on this runqueue and
-		 * our priority decreased, or if we are not currently running on
-		 * this runqueue and our priority is higher than the current's
-		 */
-		if (task_running(rq, p)) {
-			if (p->prio > oldprio)
-				resched_task(rq->curr);
-		} else if (TASK_PREEMPTS_CURR(p, rq))
-			resched_task(rq->curr);
-	}
-	trace_special(prev_resched, _need_resched(), 0);
-
-	task_rq_unlock(rq, &flags);
-}
-
 #ifdef __ARCH_WANT_SYS_NICE
 
 /*
diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6-rt9/kernel/softirq.c linux-2.6.13-rc6-rt9.work/kernel/softirq.c
--- linux-2.6.13-rc6-rt9/kernel/softirq.c	2005-08-18 17:37:42.000000000 +0200
+++ linux-2.6.13-rc6-rt9.work/kernel/softirq.c	2005-08-19 18:44:31.000000000 +0200
@@ -314,7 +314,7 @@ void raise_softirq_prio(unsigned long nr
 
 	if (prio > (MAX_RT_PRIO - 1))
 		prio = MAX_RT_PRIO - 1;
-	mutex_chprio(tsk, prio);
+	pi_changeprio(tsk, prio);
 	wake_up_process(tsk);
 }
 #endif
diff -uprN --exclude-from=/usr/local/bin/diffit.exclude linux-2.6.13-rc6-rt9/kernel/timer.c linux-2.6.13-rc6-rt9.work/kernel/timer.c
--- linux-2.6.13-rc6-rt9/kernel/timer.c	2005-08-18 17:37:43.000000000 +0200
+++ linux-2.6.13-rc6-rt9.work/kernel/timer.c	2005-08-19 18:44:31.000000000 +0200
@@ -1731,7 +1731,7 @@ static inline void recalc_priority(tvec_
 	if (prio == hrbase->hr_prio)
 		return;
 	hrbase->hr_prio = prio;
-	mutex_chprio(current, prio);
+	pi_changeprio(current, prio);
 	spin_unlock_irq(&hrbase->t_base.lock);
 	cond_resched();
 	spin_lock_irq(&hrbase->t_base.lock);



--=-jS/4JlHkDI9NLW1dYTOJ
Content-Disposition: attachment; filename=cyclictest-0.1.tar.bz2
Content-Type: application/x-bzip-compressed-tar; name=cyclictest-0.1.tar.bz2
Content-Transfer-Encoding: base64

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
JAC8TecA


--=-jS/4JlHkDI9NLW1dYTOJ
Content-Disposition: attachment; filename=test.config.bz2
Content-Type: application/x-bzip; name=test.config.bz2
Content-Transfer-Encoding: base64

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
kgv/xdyRThQkHZp0hkA=


--=-jS/4JlHkDI9NLW1dYTOJ--

