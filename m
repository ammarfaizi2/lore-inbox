Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268235AbUHFT0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268235AbUHFT0w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268246AbUHFT0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:26:33 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:26341 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268245AbUHFTYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:24:05 -0400
Date: Sun, 8 Aug 2004 00:51:39 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       Robert Olsson <Robert.Olsson@data.slu.se>, netdev@oss.sgi.com
Subject: Re: RCU : Document RCU api [4/5]
Message-ID: <20040807192139.GE3936@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040807191536.GA3936@in.ibm.com> <20040807191729.GB3936@in.ibm.com> <20040807191841.GC3936@in.ibm.com> <20040807192023.GD3936@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040807192023.GD3936@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from Paul for additional documentation of api.

Thanks
Dipankar



Updated based on feedback, and to apply to 2.6.8-rc3.  I will be
adding more detailed documentation to the Documentation directory
in a separate patch.

Signed-off-by: Paul McKenney <paulmck@us.ibm.com>


 include/linux/rcupdate.h |   65 ++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/rcupdate.c        |   39 +++++++++++++++++-----------
 2 files changed, 88 insertions(+), 16 deletions(-)

diff -puN include/linux/rcupdate.h~rcu-api-doc include/linux/rcupdate.h
--- linux-2.6.8-rc3-mm1/include/linux/rcupdate.h~rcu-api-doc	2004-08-07 15:29:49.000000000 +0530
+++ linux-2.6.8-rc3-mm1-dipankar/include/linux/rcupdate.h	2004-08-07 15:29:49.000000000 +0530
@@ -154,11 +154,74 @@ static inline int rcu_pending(int cpu)
 		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
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
+
+/**
+ * rcu_read_lock_bh - mark the beginning of a softirq-only RCU critical section
+ *
+ * This is equivalent of rcu_read_lock(), but to be used when updates
+ * are being done using call_rcu_bh(). Since call_rcu_bh() callbacks
+ * consider completion of a softirq handler to be a quiescent state,
+ * a process in RCU read-side critical section must be protected by
+ * disabling softirqs. Read-side critical sections in interrupt context
+ * can use just rcu_read_lock().
+ *
+ */
 #define rcu_read_lock_bh()	local_bh_disable()
-#define rcu_read_unlock_bh()	local_bh_enable()
 
+/*
+ * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
+ *
+ * See rcu_read_lock_bh() for more information.
+ */
+#define rcu_read_unlock_bh()	local_bh_enable()
+  
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
 extern void rcu_restart_cpu(int cpu);
diff -puN kernel/rcupdate.c~rcu-api-doc kernel/rcupdate.c
--- linux-2.6.8-rc3-mm1/kernel/rcupdate.c~rcu-api-doc	2004-08-07 15:29:49.000000000 +0530
+++ linux-2.6.8-rc3-mm1-dipankar/kernel/rcupdate.c	2004-08-07 15:29:49.000000000 +0530
@@ -73,14 +73,15 @@ static DEFINE_PER_CPU(struct tasklet_str
 static int maxbatch = 10;
 
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
@@ -98,17 +99,20 @@ void fastcall call_rcu(struct rcu_head *
 }
 
 /**
- * call_rcu_bh - Queue an RCU update request for which softirq handler
- * completion is a quiescent state.
+ * call_rcu_bh - Queue an RCU for invocation after a quicker grace period.
  * @head: structure to be used for queueing the RCU updates.
  * @func: actual update function to be invoked after the grace period
  *
- * The update function will be invoked as soon as all CPUs have performed 
- * a context switch or been seen in the idle loop or in a user process
- * or has exited a softirq handler that it may have been executing.
- * The read-side of critical section that use call_rcu_bh() for updation must 
- * be protected by rcu_read_lock_bh()/rcu_read_unlock_bh() if it is
- * in process context.
+ * The update function will be invoked some time after a full grace
+ * period elapses, in other words after all currently executing RCU
+ * read-side critical sections have completed. call_rcu_bh() assumes
+ * that the read-side critical sections end on completion of a softirq
+ * handler. This means that read-side critical sections in process
+ * context must not be interrupted by softirqs. This interface is to be
+ * used when most of the read-side critical sections are in softirq context.
+ * RCU read-side critical sections are delimited by rcu_read_lock() and 
+ * rcu_read_unlock(), * if in interrupt context or rcu_read_lock_bh() 
+ * and rcu_read_unlock_bh(), if in process context. These may be nested.
  */
 void fastcall call_rcu_bh(struct rcu_head *head,
 				void (*func)(struct rcu_head *rcu))
@@ -439,8 +443,13 @@ static void wakeme_after_rcu(struct rcu_
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

_
