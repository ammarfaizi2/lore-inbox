Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVDCGVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVDCGVv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 01:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVDCGVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 01:21:51 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:51383 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261522AbVDCGVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 01:21:36 -0500
Date: Sat, 2 Apr 2005 22:21:50 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: dipankar@in.ibm.com, shemminger@osdl.org, manfred@colorfullife.com,
       bunk@stusta.de
Subject: [RFC,PATCH 2/4] Deprecate synchronize_kernel, GPL replacement
Message-ID: <20050403062149.GA1656@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The synchronize_kernel() primitive is used for quite a few different
purposes: waiting for RCU readers, waiting for NMIs, waiting for interrupts,
and so on.  This makes RCU code harder to read, since synchronize_kernel()
might or might not have matching rcu_read_lock()s.  This patch creates
a new synchronize_rcu() that is to be used for RCU readers and a new
synchronize_sched() that is used for the rest.  These two new primitives
currently have the same implementation, but this is might well change
with additional real-time support.  Both new primitives are GPL-only,
the old primitive is deprecated.

Signed-off-by: <paulmck@us.ibm.com>
---
Depends on earlier "Add deprecated_for_modules" patch.

 include/linux/rcupdate.h |   24 +++++++++++++++++++++---
 kernel/rcupdate.c        |   16 ++++++++++++++--
 2 files changed, 35 insertions(+), 5 deletions(-)

diff -urpN -X dontdiff linux-2.6.12-rc1/include/linux/rcupdate.h linux-2.6.12-rc1-bettersk/include/linux/rcupdate.h
--- linux-2.6.12-rc1/include/linux/rcupdate.h	Tue Mar  1 23:37:50 2005
+++ linux-2.6.12-rc1-bettersk/include/linux/rcupdate.h	Sat Apr  2 13:06:15 2005
@@ -41,6 +41,7 @@
 #include <linux/percpu.h>
 #include <linux/cpumask.h>
 #include <linux/seqlock.h>
+#include <linux/module.h>
 
 /**
  * struct rcu_head - callback structure for use with RCU
@@ -157,9 +158,9 @@ static inline int rcu_pending(int cpu)
 /**
  * rcu_read_lock - mark the beginning of an RCU read-side critical section.
  *
- * When synchronize_kernel() is invoked on one CPU while other CPUs
+ * When synchronize_rcu() is invoked on one CPU while other CPUs
  * are within RCU read-side critical sections, then the
- * synchronize_kernel() is guaranteed to block until after all the other
+ * synchronize_rcu() is guaranteed to block until after all the other
  * CPUs exit their critical sections.  Similarly, if call_rcu() is invoked
  * on one CPU while other CPUs are within RCU read-side critical
  * sections, invocation of the corresponding RCU callback is deferred
@@ -256,6 +257,21 @@ static inline int rcu_pending(int cpu)
 						(p) = (v); \
 					})
 
+/**
+ * synchronize_sched - block until all CPUs have exited any non-preemptive
+ * kernel code sequences.
+ *
+ * This means that all preempt_disable code sequences, including NMI and
+ * hardware-interrupt handlers, in progress on entry will have completed
+ * before this primitive returns.  However, this does not guarantee that
+ * softirq handlers will have completed, since in some kernels 
+ * 
+ * This primitive provides the guarantees made by the (deprecated)
+ * synchronize_kernel() API.  In contrast, synchronize_rcu() only
+ * guarantees that rcu_read_lock() sections will have completed.
+ */
+#define synchronize_sched() synchronize_rcu()
+
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
 extern void rcu_restart_cpu(int cpu);
@@ -265,7 +281,9 @@ extern void FASTCALL(call_rcu(struct rcu
 				void (*func)(struct rcu_head *head)));
 extern void FASTCALL(call_rcu_bh(struct rcu_head *head,
 				void (*func)(struct rcu_head *head)));
-extern void synchronize_kernel(void);
+extern deprecated_for_modules void synchronize_kernel(void);
+extern void synchronize_rcu(void);
+void synchronize_idle(void);
 
 #endif /* __KERNEL__ */
 #endif /* __LINUX_RCUPDATE_H */
diff -urpN -X dontdiff linux-2.6.12-rc1/kernel/rcupdate.c linux-2.6.12-rc1-bettersk/kernel/rcupdate.c
--- linux-2.6.12-rc1/kernel/rcupdate.c	Tue Mar  1 23:37:30 2005
+++ linux-2.6.12-rc1-bettersk/kernel/rcupdate.c	Sat Apr  2 13:10:09 2005
@@ -444,15 +444,18 @@ static void wakeme_after_rcu(struct rcu_
 }
 
 /**
- * synchronize_kernel - wait until a grace period has elapsed.
+ * synchronize_rcu - wait until a grace period has elapsed.
  *
  * Control will return to the caller some time after a full grace
  * period has elapsed, in other words after all currently executing RCU
  * read-side critical sections have completed.  RCU read-side critical
  * sections are delimited by rcu_read_lock() and rcu_read_unlock(),
  * and may be nested.
+ *
+ * If your read-side code is not protected by rcu_read_lock(), do -not-
+ * use synchronize_rcu().
  */
-void synchronize_kernel(void)
+void synchronize_rcu(void)
 {
 	struct rcu_synchronize rcu;
 
@@ -464,7 +467,16 @@ void synchronize_kernel(void)
 	wait_for_completion(&rcu.completion);
 }
 
+/*
+ * Deprecated, use synchronize_rcu() or synchronize_sched() instead.
+ */
+void synchronize_kernel(void)
+{
+	synchronize_rcu();
+}
+
 module_param(maxbatch, int, 0);
 EXPORT_SYMBOL(call_rcu);
 EXPORT_SYMBOL(call_rcu_bh);
+EXPORT_SYMBOL_GPL(synchronize_rcu);
 EXPORT_SYMBOL(synchronize_kernel);
