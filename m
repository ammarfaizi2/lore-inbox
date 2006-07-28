Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751939AbWG1ASq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbWG1ASq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 20:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbWG1ASq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 20:18:46 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:25788 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751939AbWG1ASp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 20:18:45 -0400
Date: Thu, 27 Jul 2006 17:19:19 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org, tglx@linutronix.de
Cc: rostedt@goodmis.org, dipankar@in.ibm.com, billh@gnuppy.monkey.org,
       nielsen.esben@googlemail.com, mingo@elte.hu, tytso@us.ibm.com,
       dvhltc@us.ibm.com
Subject: [RFC, PATCH, -rt] Early prototype RCU priority-boost patch
Message-ID: <20060728001918.GA2634@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is a very crude not-for-inclusion patch that boosts priority of
RCU read-side critical sections, but only when they are preempted, and
only to the highest non-RT priority.  The rcu_read_unlock() primitive
does the unboosting.  There are a large number of things that this patch
does -not- do, including:

o	Boost RCU read-side critical sections to the highest possible
	priority.  One might wish to do this in OOM situations.  Or
	if the grace period is extending too long.  I played with this
	a bit some months back, see:

		http://www.rdrop.com/users/paulmck/patches/RCUboost-20.patch

	to see what I was thinking.  Or similarly-numbered patches,
	see http://www.rdrop.com/users/paulmck/patches for the full
	list.  Lots of subtly broken approaches for those who are
	interested in subtle breakage.

	One must carefully resolve races between boosting and the
	to-be-boosted task slipping out of its RCU read-side critical
	section.  My thought has been to grab the to-be-boosted task
	by the throat, and only boost it if it is (1) still in an
	RCU read-side critical section and (2) not running.  If you
	try boosting a thread that is already running, the races between
	boosting and rcu_read_unlock() are insanely complex, particularly
	for implementations of rcu_read_unlock() that don't use atomic
	instructions or memory barriers.  ;-)

	Much better to either have the thread boost itself or to make
	sure the thread is not running if having someone else boost it.

o	Boost RCU read-side critical sections that must block waiting
	for a non-raw spinlock.  The URL noted above shows one approach
	I was messing with some time back.

o	Boost RCU read-side critical sections based on the priority of
	tasks doing synchronize_rcu() and call_rcu().  (This was something
	Steve Rostedt suggested at OLS.)  One thing at a time!  ;-)

o	Implementing preemption thresholding, as suggested by Bill Huey.
	I am taking the coward's way out on this for the moment in order
	to improve the odds of getting something useful done (as opposed
	to getting something potentially even more useful only half done).

Anyway, the following patch compiles and passes lightweight "smoke" tests.
It almost certainly has fatal flaws -- for, example, I don't see how it
would handle yet another task doing a lock-based priority boost between
the time the task is RCU-boosted and the time it de-boosts itself in
rcu_read_unlock().

Again, not for inclusion in its present form, but any enlightenment would
be greatly appreciated.

(Thomas, you did ask for this!!!)

							Thanx, Paul

Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com> (but not for inclusion)
---

 include/linux/init_task.h |    1 +
 include/linux/rcupdate.h  |    2 ++
 include/linux/sched.h     |    3 +++
 kernel/rcupreempt.c       |   11 +++++++++++
 kernel/sched.c            |    8 ++++++++
 5 files changed, 25 insertions(+)

diff -urpNa -X dontdiff linux-2.6.17-rt7/include/linux/init_task.h linux-2.6.17-rt7-rcubp/include/linux/init_task.h
--- linux-2.6.17-rt7/include/linux/init_task.h	2006-07-27 14:29:55.000000000 -0700
+++ linux-2.6.17-rt7-rcubp/include/linux/init_task.h	2006-07-27 14:34:20.000000000 -0700
@@ -89,6 +89,7 @@ extern struct group_info init_groups;
 	.prio		= MAX_PRIO-20,					\
 	.static_prio	= MAX_PRIO-20,					\
 	.normal_prio	= MAX_PRIO-20,					\
+	.rcu_prio	= MAX_PRIO,					\
 	.policy		= SCHED_NORMAL,					\
 	.cpus_allowed	= CPU_MASK_ALL,					\
 	.mm		= NULL,						\
diff -urpNa -X dontdiff linux-2.6.17-rt7/include/linux/rcupdate.h linux-2.6.17-rt7-rcubp/include/linux/rcupdate.h
--- linux-2.6.17-rt7/include/linux/rcupdate.h	2006-07-27 14:29:55.000000000 -0700
+++ linux-2.6.17-rt7-rcubp/include/linux/rcupdate.h	2006-07-27 14:34:20.000000000 -0700
@@ -175,6 +175,8 @@ extern int rcu_needs_cpu(int cpu);
 
 #else /* #ifndef CONFIG_PREEMPT_RCU */
 
+#define RCU_PREEMPT_BOOST_PRIO MAX_USER_RT_PRIO  /* Initial boost level. */
+
 #define rcu_qsctr_inc(cpu)
 #define rcu_bh_qsctr_inc(cpu)
 #define call_rcu_bh(head, rcu) call_rcu(head, rcu)
diff -urpNa -X dontdiff linux-2.6.17-rt7/include/linux/sched.h linux-2.6.17-rt7-rcubp/include/linux/sched.h
--- linux-2.6.17-rt7/include/linux/sched.h	2006-07-27 14:29:55.000000000 -0700
+++ linux-2.6.17-rt7-rcubp/include/linux/sched.h	2006-07-27 14:34:20.000000000 -0700
@@ -851,6 +851,9 @@ struct task_struct {
 	int oncpu;
 #endif
 	int prio, static_prio, normal_prio;
+#ifdef CONFIG_PREEMPT_RCU
+	int rcu_prio;
+#endif
 	struct list_head run_list;
 	prio_array_t *array;
 
diff -urpNa -X dontdiff linux-2.6.17-rt7/kernel/rcupreempt.c linux-2.6.17-rt7-rcubp/kernel/rcupreempt.c
--- linux-2.6.17-rt7/kernel/rcupreempt.c	2006-07-27 14:29:55.000000000 -0700
+++ linux-2.6.17-rt7-rcubp/kernel/rcupreempt.c	2006-07-27 14:34:20.000000000 -0700
@@ -147,6 +147,17 @@ rcu_read_lock(void)
 			atomic_inc(current->rcu_flipctr2);
 			smp_mb__after_atomic_inc();  /* might optimize out... */
 		}
+		if (unlikely(current->rcu_prio <= RCU_PREEMPT_BOOST_PRIO)) {
+			int new_prio = MAX_PRIO;
+
+			current->rcu_prio = MAX_PRIO;
+			if (new_prio > current->static_prio)
+				new_prio = current->static_prio;
+			if (new_prio > current->normal_prio)
+				new_prio = current->normal_prio;
+			/* How to account for lock-based prio boost? */
+			rt_mutex_setprio(current, new_prio);
+		}
 	}
 	trace_special((unsigned long) current->rcu_flipctr1,
 		      (unsigned long) current->rcu_flipctr2,
diff -urpNa -X dontdiff linux-2.6.17-rt7/kernel/sched.c linux-2.6.17-rt7-rcubp/kernel/sched.c
--- linux-2.6.17-rt7/kernel/sched.c	2006-07-27 14:29:55.000000000 -0700
+++ linux-2.6.17-rt7-rcubp/kernel/sched.c	2006-07-27 14:58:40.000000000 -0700
@@ -3685,6 +3685,14 @@ asmlinkage void __sched preempt_schedule
 		return;
 
 need_resched:
+#ifdef CONFIG_PREEMPT_RT
+	if (unlikely(current->rcu_read_lock_nesting > 0) &&
+	    (current->rcu_prio > RCU_PREEMPT_BOOST_PRIO)) {
+		current->rcu_prio = RCU_PREEMPT_BOOST_PRIO;
+		if (current->rcu_prio < current->prio)
+			rt_mutex_setprio(current, current->rcu_prio);
+	}
+#endif
 	local_irq_disable();
 	add_preempt_count(PREEMPT_ACTIVE);
 	/*
