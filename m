Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWCQBv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWCQBv5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbWCQBv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:51:57 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:34458 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751437AbWCQBvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:51:52 -0500
Date: Thu, 16 Mar 2006 17:52:09 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, dipankar@in.ibm.com, suparna@in.ibm.com
Subject: [PATCH -rt, RFC] rid rcu_read_lock() and _unlock() of common-case atomics
Message-ID: <20060317015209.GA2886@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is an RFC, -not- intended for inclusion because it does not help
x86 performance or latency.  (Yes, it does remove atomic instructions
in the common case, but memory barriers on x86 are implemented as ...
atomic instructions!!!)

That said, it is a step towards a lighter-weight rcu_read_lock()
implementation, so sending it out to get feedback.  Work underway
to also get rid of the memory barriers...

The patch relies on the fact that both rcu_read_lock() and
rcu_read_unlock() disable hardware interrupts, which has the
side-effect of also disabling preemption.  So, if rcu_read_lock()
finds a counter value of zero, there cannot possibly be another
CPU wanting to update that same counter.  Similar reasoning is
applied to rcu_read_unlock() -- see comments below.

							Thanx, Paul

 include/linux/sched.h |    1 +
 kernel/rcupreempt.c   |   31 ++++++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 5 deletions(-)

diff -urpNa -X dontdiff linux-2.6.15-rt16-splitPREEMPT_RCU/include/linux/sched.h linux-2.6.15-rt16-sPR-optatomic/include/linux/sched.h
--- linux-2.6.15-rt16-splitPREEMPT_RCU/include/linux/sched.h	2006-03-15 22:10:19.000000000 -0800
+++ linux-2.6.15-rt16-sPR-optatomic/include/linux/sched.h	2006-03-15 22:10:12.000000000 -0800
@@ -893,6 +893,7 @@ struct task_struct {
 	int rcu_read_lock_nesting;
 	atomic_t *rcu_flipctr1;
 	atomic_t *rcu_flipctr2;
+	int rcu_read_lock_cpu;
 #endif
 #ifdef CONFIG_SCHEDSTATS
 	struct sched_info sched_info;
diff -urpNa -X dontdiff linux-2.6.15-rt16-splitPREEMPT_RCU/kernel/rcupreempt.c linux-2.6.15-rt16-sPR-optatomic/kernel/rcupreempt.c
--- linux-2.6.15-rt16-splitPREEMPT_RCU/kernel/rcupreempt.c	2006-02-24 11:19:50.000000000 -0800
+++ linux-2.6.15-rt16-sPR-optatomic/kernel/rcupreempt.c	2006-03-15 22:07:15.000000000 -0800
@@ -127,14 +127,24 @@ rcu_read_lock(void)
 		/*
 		 * Outermost nesting of rcu_read_lock(), so atomically
 		 * increment the current counter for the current CPU.
+		 * However, if the counter is zero, there can be no
+		 * race with another decrement.  In addition, since
+		 * we have interrupts disabled, there can be no race
+		 * with another increment.
 		 */
 
 		flipctr = rcu_ctrlblk.completed & 0x1;
 		smp_read_barrier_depends();
 		current->rcu_flipctr1 = &(__get_cpu_var(rcu_flipctr)[flipctr]);
-		/* Can optimize to non-atomic on fastpath, but start simple. */
-		atomic_inc(current->rcu_flipctr1);
-		smp_mb__after_atomic_inc();  /* might optimize out... */
+		current->rcu_read_lock_cpu = smp_processor_id();
+		if (atomic_read(current->rcu_flipctr1) == 0) {
+			atomic_set(current->rcu_flipctr1,
+				   atomic_read(current->rcu_flipctr1) + 1);
+			smp_mb();  /* will optimize out... */
+		} else {
+			atomic_inc(current->rcu_flipctr1);
+			smp_mb__after_atomic_inc();  /* will optimize out... */
+		}
 		if (unlikely(flipctr != (rcu_ctrlblk.completed & 0x1))) {
 
 			/*
@@ -170,13 +180,24 @@ rcu_read_unlock(void)
 
 		/*
 		 * Just atomically decrement whatever we incremented.
+		 * However, if the counter is equal to one, there can
+		 * be no other concurrent decrement.  In addition, since
+		 * we have interrupts disabled, there can be no
+		 * concurrent increment.
 		 * Might later want to awaken some task waiting for the
 		 * grace period to complete, but keep it simple for the
 		 * moment.
 		 */
 
-		smp_mb__before_atomic_dec();
-		atomic_dec(current->rcu_flipctr1);
+		if ((atomic_read(current->rcu_flipctr1) == 1) &&
+		    (current->rcu_read_lock_cpu == smp_processor_id())) {
+			atomic_set(current->rcu_flipctr1,
+				   atomic_read(current->rcu_flipctr1) - 1);
+			smp_mb();  /* will optimize out... */
+		} else {
+			smp_mb__before_atomic_dec();
+			atomic_dec(current->rcu_flipctr1);
+		}
 		current->rcu_flipctr1 = NULL;
 		if (unlikely(current->rcu_flipctr2 != NULL)) {
 			atomic_dec(current->rcu_flipctr2);
