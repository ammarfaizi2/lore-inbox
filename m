Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUHDOTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUHDOTh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 10:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266075AbUHDOTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 10:19:36 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:26220 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S266069AbUHDOTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 10:19:25 -0400
Date: Wed, 4 Aug 2004 07:16:08 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: dipankar@in.ibm.com, shemminger@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] Updated RCU documentation improvement
Message-ID: <20040804141608.GA1865@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Updated based on feedback, and to apply to 2.6.8-rc3.  I will be
adding more detailed documentation to the Documentation directory
in a separate patch.

Thoughts?

							Thanx, Paul

diff -urpN -X ../dontdiff linux-2.5/include/linux/rcupdate.h linux-2.5.rcu_read_lock_comments/include/linux/rcupdate.h
--- linux-2.5/include/linux/rcupdate.h	Mon Aug  2 11:32:10 2004
+++ linux-2.5.rcu_read_lock_comments/include/linux/rcupdate.h	Wed Aug  4 06:32:07 2004
@@ -133,8 +133,53 @@ static inline int rcu_pending(int cpu) 
 	return 0;
 }
 
+/**
+ * rcu_read_lock - mark the beginning of an RCU read-side critical section.
+ *
+ * When synchronize_kernel() is invoked on one CPU while other CPUs
+ * are within RCU read-side critical sections, then the
+ * synchronize_kernel() is guaranteed to block until after all the other
+ * CPUs exit their critical sections.  Similarly, if call_rcu() is invoked
+ * on one CPU while other CPUs are within RCU read-side critical
+ * sections, invocation of the corresponding RCU callback is deferred
+ * until after the all the other CPUs exit their critical sections.
+ *
+ * Note, however, that RCU callbacks are permitted to run concurrently
+ * with RCU read-side critical sections.  One way that this can happen
+ * is via the following sequence of events: (1) CPU 0 enters an RCU
+ * read-side critical section, (2) CPU 1 invokes call_rcu() to register
+ * an RCU callback, (3) CPU 0 exits the RCU read-side critical section,
+ * (4) CPU 2 enters a RCU read-side critical section, (5) the RCU
+ * callback is invoked.  This is legal, because the RCU read-side critical
+ * section that was running concurrently with the call_rcu() (and which
+ * therefore might be referencing something that the corresponding RCU
+ * callback would free up) has completed before the corresponding
+ * RCU callback is invoked.
+ *
+ * RCU read-side critical sections may be nested.  Any deferred actions
+ * will be deferred until the outermost RCU read-side critical section
+ * completes.
+ *
+ * It is illegal to block while in an RCU read-side critical section.
+ */
 #define rcu_read_lock()		preempt_disable()
+
+/**
+ * rcu_read_unlock - marks the end of an RCU read-side critical section.
+ *
+ * See rcu_read_lock() for more information.
+ */
 #define rcu_read_unlock()	preempt_enable()
+
+/*
+ * So where is rcu_write_lock()?  It does not exist, as there is no
+ * way for writers to lock out RCU readers.  This is a feature, not
+ * a bug -- this property is what provides RCU's performance benefits.
+ * Of course, writers must coordinate with each other.  The normal
+ * spinlock primitives work well for this, but any other technique may be
+ * used as well.  RCU does not care how the writers keep out of each
+ * others' way, as long as they do so.
+ */
 
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
diff -urpN -X ../dontdiff linux-2.5/kernel/rcupdate.c linux-2.5.rcu_read_lock_comments/kernel/rcupdate.c
--- linux-2.5/kernel/rcupdate.c	Mon Aug  2 11:32:13 2004
+++ linux-2.5.rcu_read_lock_comments/kernel/rcupdate.c	Wed Aug  4 06:34:27 2004
@@ -65,14 +65,15 @@ static DEFINE_PER_CPU(struct tasklet_str
 #define RCU_tasklet(cpu) (per_cpu(rcu_tasklet, cpu))
 
 /**
- * call_rcu - Queue an RCU update request.
+ * call_rcu - Queue an RCU callback for invocation after a grace period.
  * @head: structure to be used for queueing the RCU updates.
  * @func: actual update function to be invoked after the grace period
  *
- * The update function will be invoked as soon as all CPUs have performed 
- * a context switch or been seen in the idle loop or in a user process. 
- * The read-side of critical section that use call_rcu() for updation must 
- * be protected by rcu_read_lock()/rcu_read_unlock().
+ * The update function will be invoked some time after a full grace
+ * period elapses, in other words after all currently executing RCU
+ * read-side critical sections have completed.  RCU read-side critical
+ * sections are delimited by rcu_read_lock() and rcu_read_unlock(),
+ * and may be nested.
  */
 void fastcall call_rcu(struct rcu_head *head,
 				void (*func)(struct rcu_head *rcu))
@@ -370,8 +371,13 @@ static void wakeme_after_rcu(struct rcu_
 }
 
 /**
- * synchronize-kernel - wait until all the CPUs have gone
- * through a "quiescent" state. It may sleep.
+ * synchronize_kernel - wait until a grace period has elapsed.
+ *
+ * Control will return to the caller some time after a full grace
+ * period has elapsed, in other words after all currently executing RCU
+ * read-side critical sections have completed.  RCU read-side critical
+ * sections are delimited by rcu_read_lock() and rcu_read_unlock(),
+ * and may be nested.
  */
 void synchronize_kernel(void)
 {
