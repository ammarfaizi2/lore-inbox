Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWH1QNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWH1QNW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWH1QNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:13:22 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:47307 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751172AbWH1QNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:13:21 -0400
Date: Mon, 28 Aug 2006 21:43:27 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul E McKenney <paulmck@us.ibm.com>
Subject: Re: [PATCH 4/4] RCU: clean up RCU trace
Message-ID: <20060828161327.GF3325@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060828160845.GB3325@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828160845.GB3325@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch consolidates the RCU tracing code in the preemptible
RCU implementation, moves them to a separate "trace" file and
cleans up the #ifdefs. Moving to a separate file will eventually
allow dynamic tracing of RCU implementation.

Signed-off-by: Paul McKenney <paulmck@in.ibm.com>
Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---


 include/linux/rcupreempt_trace.h |   84 ++++++++++++++++++++++++++++
 kernel/Kconfig.preempt           |   11 +--
 kernel/Makefile                  |    1 
 kernel/rcupreempt.c              |  113 ++++++++++++---------------------------
 kernel/rcupreempt_trace.c        |   99 ++++++++++++++++++++++++++++++++++
 5 files changed, 225 insertions(+), 83 deletions(-)

diff -puN /dev/null include/linux/rcupreempt_trace.h
--- /dev/null	2006-08-28 19:57:17.885180500 +0530
+++ linux-2.6.18-rc3-rcu-dipankar/include/linux/rcupreempt_trace.h	2006-08-27 21:52:28.000000000 +0530
@@ -0,0 +1,84 @@
+/*
+ * Read-Copy Update mechanism for mutual exclusion (RT implementation)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2006
+ *
+ * Author:  Paul McKenney <paulmck@us.ibm.com>
+ * 
+ * Based on the original work by Paul McKenney <paul.mckenney@us.ibm.com>
+ * and inputs from Rusty Russell, Andrea Arcangeli and Andi Kleen.
+ * Papers:
+ * http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
+ * http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf (OLS2001)
+ *
+ * For detailed explanation of Read-Copy Update mechanism see -
+ * 		http://lse.sourceforge.net/locking/rcupdate.html
+ *
+ */
+
+#ifndef __LINUX_RCUPREEMPT_TRACE_H
+#define __LINUX_RCUPREEMPT_TRACE_H
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#include <linux/kernel.h>
+
+#include <asm/atomic.h>
+
+/*
+ * PREEMPT_RCU data structures.
+ */
+
+struct rcupreempt_trace {
+	long		next_length;
+	long		next_add;
+	long		wait_length;
+	long		wait_add;
+	long		done_length;
+	long		done_add;
+	long		done_remove;
+	atomic_t	done_invoked;
+	long		rcu_check_callbacks;
+	atomic_t	rcu_try_flip1;
+	long		rcu_try_flip2;
+	long		rcu_try_flip3;
+	atomic_t	rcu_try_flip_e1;
+	long		rcu_try_flip_e2;
+	long		rcu_try_flip_e3;
+};
+
+#ifdef CONFIG_RCU_TRACE
+#define RCU_TRACE(fn, arg) 	fn(arg);
+#else
+#define RCU_TRACE(fn, arg)
+#endif
+
+extern void rcupreempt_trace_move2done(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_move2wait(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip1(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip_e1(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip_e2(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip_e3(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip2(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip3(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_check_callbacks(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_done_remove(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_invoke(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_next_add(struct rcupreempt_trace *trace);
+
+#endif /* __KERNEL__ */
+#endif /* __LINUX_RCUPREEMPT_TRACE_H */
diff -puN kernel/Kconfig.preempt~rcu-preempt-trace kernel/Kconfig.preempt
--- linux-2.6.18-rc3-rcu/kernel/Kconfig.preempt~rcu-preempt-trace	2006-08-27 21:52:28.000000000 +0530
+++ linux-2.6.18-rc3-rcu-dipankar/kernel/Kconfig.preempt	2006-08-27 21:52:28.000000000 +0530
@@ -90,13 +90,12 @@ config PREEMPT_RCU
 
 endchoice
 
-config RCU_STATS
-	bool "/proc stats for preemptible RCU read-side critical sections"
-	depends on PREEMPT_RCU
+config RCU_TRACE
+	bool "Enable tracing for RCU - currently stats in /proc"
 	default y
 	help
-	  This option provides /proc stats to provide debugging info for
-	  the preemptible realtime RCU implementation.
+	  This option provides tracing in RCU which presents /proc 
+          stats for debugging RCU implementation.
 
-	  Say Y here if you want to see RCU stats in /proc
+	  Say Y here if you want to enable RCU tracing
 	  Say N if you are unsure.
diff -puN kernel/Makefile~rcu-preempt-trace kernel/Makefile
--- linux-2.6.18-rc3-rcu/kernel/Makefile~rcu-preempt-trace	2006-08-27 21:52:28.000000000 +0530
+++ linux-2.6.18-rc3-rcu-dipankar/kernel/Makefile	2006-08-27 21:52:28.000000000 +0530
@@ -49,6 +49,7 @@ obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_CLASSIC_RCU) += rcupdate.o rcuclassic.o
 obj-$(CONFIG_PREEMPT_RCU) += rcupdate.o rcupreempt.o
+obj-$(CONFIG_RCU_TRACE) += rcupreempt_trace.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_TASK_DELAY_ACCT) += delayacct.o
 obj-$(CONFIG_TASKSTATS) += taskstats.o
diff -puN kernel/rcupreempt.c~rcu-preempt-trace kernel/rcupreempt.c
--- linux-2.6.18-rc3-rcu/kernel/rcupreempt.c~rcu-preempt-trace	2006-08-27 21:52:28.000000000 +0530
+++ linux-2.6.18-rc3-rcu-dipankar/kernel/rcupreempt.c	2006-08-27 21:52:28.000000000 +0530
@@ -48,6 +48,7 @@
 #include <linux/delay.h>
 #include <linux/byteorder/swabb.h>
 #include <linux/cpumask.h>
+#include <linux/rcupreempt_trace.h>
 
 /*
  * PREEMPT_RCU data structures.
@@ -63,23 +64,9 @@ struct rcu_data {
 	struct rcu_head **waittail;
 	struct rcu_head *donelist;
 	struct rcu_head **donetail;
-#ifdef CONFIG_RCU_STATS
-	long		n_next_length;
-	long		n_next_add;
-	long		n_wait_length;
-	long		n_wait_add;
-	long		n_done_length;
-	long		n_done_add;
-	long		n_done_remove;
-	atomic_t	n_done_invoked;
-	long		n_rcu_check_callbacks;
-	atomic_t	n_rcu_try_flip1;
-	long		n_rcu_try_flip2;
-	long		n_rcu_try_flip3;
-	atomic_t	n_rcu_try_flip_e1;
-	long		n_rcu_try_flip_e2;
-	long		n_rcu_try_flip_e3;
-#endif /* #ifdef CONFIG_RCU_STATS */
+#ifdef CONFIG_RCU_TRACE
+	struct rcupreempt_trace trace;
+#endif /* #ifdef CONFIG_RCU_TRACE */
 };
 struct rcu_ctrlblk {
 	spinlock_t	fliplock;
@@ -180,22 +167,14 @@ static void __rcu_advance_callbacks(void
 		if (rcu_data.waitlist != NULL) {
 			*rcu_data.donetail = rcu_data.waitlist;
 			rcu_data.donetail = rcu_data.waittail;
-#ifdef CONFIG_RCU_STATS
-			rcu_data.n_done_length += rcu_data.n_wait_length;
-			rcu_data.n_done_add += rcu_data.n_wait_length;
-			rcu_data.n_wait_length = 0;
-#endif /* #ifdef CONFIG_RCU_STATS */
+			RCU_TRACE(rcupreempt_trace_move2done, &rcu_data.trace);
 		}
 		if (rcu_data.nextlist != NULL) {
 			rcu_data.waitlist = rcu_data.nextlist;
 			rcu_data.waittail = rcu_data.nexttail;
 			rcu_data.nextlist = NULL;
 			rcu_data.nexttail = &rcu_data.nextlist;
-#ifdef CONFIG_RCU_STATS
-			rcu_data.n_wait_length += rcu_data.n_next_length;
-			rcu_data.n_wait_add += rcu_data.n_next_length;
-			rcu_data.n_next_length = 0;
-#endif /* #ifdef CONFIG_RCU_STATS */
+			RCU_TRACE(rcupreempt_trace_move2wait, &rcu_data.trace);
 		} else {
 			rcu_data.waitlist = NULL;
 			rcu_data.waittail = &rcu_data.waitlist;
@@ -220,22 +199,16 @@ static void rcu_try_flip(void)
 	unsigned long oldirq;
 
 	flipctr = rcu_ctrlblk.completed;
-#ifdef CONFIG_RCU_STATS
-	atomic_inc(&rcu_data.n_rcu_try_flip1);
-#endif /* #ifdef CONFIG_RCU_STATS */
+	RCU_TRACE(rcupreempt_trace_try_flip1, &rcu_data.trace);
 	if (unlikely(!spin_trylock_irqsave(&rcu_ctrlblk.fliplock, oldirq))) {
-#ifdef CONFIG_RCU_STATS
-		atomic_inc(&rcu_data.n_rcu_try_flip_e1);
-#endif /* #ifdef CONFIG_RCU_STATS */
+		RCU_TRACE(rcupreempt_trace_try_flip_e1, &rcu_data.trace);
 		return;
 	}
 	if (unlikely(flipctr != rcu_ctrlblk.completed)) {
 
 		/* Our work is done!  ;-) */
 
-#ifdef CONFIG_RCU_STATS
-		rcu_data.n_rcu_try_flip_e2++;
-#endif /* #ifdef CONFIG_RCU_STATS */
+		RCU_TRACE(rcupreempt_trace_try_flip_e2, &rcu_data.trace);
 		spin_unlock_irqrestore(&rcu_ctrlblk.fliplock, oldirq);
 		return;
 	}
@@ -246,14 +219,11 @@ static void rcu_try_flip(void)
 	 * that started prior to the previous flip.
 	 */
 
-#ifdef CONFIG_RCU_STATS
-	rcu_data.n_rcu_try_flip2++;
-#endif /* #ifdef CONFIG_RCU_STATS */
+	RCU_TRACE(rcupreempt_trace_try_flip2, &rcu_data.trace);
 	for_each_possible_cpu(cpu) {
 		if (atomic_read(&per_cpu(rcu_flipctr, cpu)[!flipctr]) != 0) {
-#ifdef CONFIG_RCU_STATS
-			rcu_data.n_rcu_try_flip_e3++;
-#endif /* #ifdef CONFIG_RCU_STATS */
+			RCU_TRACE(rcupreempt_trace_try_flip_e3, 
+							&rcu_data.trace);
 			spin_unlock_irqrestore(&rcu_ctrlblk.fliplock, oldirq);
 			return;
 		}
@@ -264,9 +234,7 @@ static void rcu_try_flip(void)
 	smp_mb();
 	rcu_ctrlblk.completed++;
 
-#ifdef CONFIG_RCU_STATS
-	rcu_data.n_rcu_try_flip3++;
-#endif /* #ifdef CONFIG_RCU_STATS */
+	RCU_TRACE(rcupreempt_trace_try_flip3, &rcu_data.trace);
 	spin_unlock_irqrestore(&rcu_ctrlblk.fliplock, oldirq);
 }
 
@@ -281,9 +249,7 @@ void rcu_check_callbacks(int cpu, int us
 		}
 	}
 	spin_lock_irqsave(&rcu_data.lock, oldirq);
-#ifdef CONFIG_RCU_STATS
-	rcu_data.n_rcu_check_callbacks++;
-#endif /* #ifdef CONFIG_RCU_STATS */
+	RCU_TRACE(rcupreempt_trace_check_callbacks, &rcu_data.trace);
 	__rcu_advance_callbacks();
 	if (rcu_data.donelist == NULL) {
 		spin_unlock_irqrestore(&rcu_data.lock, oldirq);
@@ -306,18 +272,13 @@ static void rcu_process_callbacks(unsign
 	}
 	rcu_data.donelist = NULL;
 	rcu_data.donetail = &rcu_data.donelist;
-#ifdef CONFIG_RCU_STATS
-	rcu_data.n_done_remove += rcu_data.n_done_length;
-	rcu_data.n_done_length = 0;
-#endif /* #ifdef CONFIG_RCU_STATS */
+	RCU_TRACE(rcupreempt_trace_done_remove, &rcu_data.trace);
 	spin_unlock_irqrestore(&rcu_data.lock, flags);
 	while (list) {
 		next = list->next;
 		list->func(list);
 		list = next;
-#ifdef CONFIG_RCU_STATS
-		atomic_inc(&rcu_data.n_done_invoked);
-#endif /* #ifdef CONFIG_RCU_STATS */
+		RCU_TRACE(rcupreempt_trace_invoke, &rcu_data.trace);
 	}
 }
 
@@ -332,10 +293,7 @@ void fastcall call_rcu(struct rcu_head *
 	__rcu_advance_callbacks();
 	*rcu_data.nexttail = head;
 	rcu_data.nexttail = &head->next;
-#ifdef CONFIG_RCU_STATS
-	rcu_data.n_next_add++;
-	rcu_data.n_next_length++;
-#endif /* #ifdef CONFIG_RCU_STATS */
+	RCU_TRACE(rcupreempt_trace_next_add, &rcu_data.trace);
 	spin_unlock_irqrestore(&rcu_data.lock, flags);
 }
 
@@ -389,9 +347,10 @@ void synchronize_kernel(void)
 	synchronize_rcu();
 }
 
-#ifdef CONFIG_RCU_STATS
+#ifdef CONFIG_RCU_TRACE
 int rcu_read_proc_data(char *page)
 {
+	struct rcupreempt_trace *trace = &rcu_data.trace;
 	return sprintf(page,
 		       "ggp=%ld lgp=%ld rcc=%ld\n"
 		       "na=%ld nl=%ld wa=%ld wl=%ld da=%ld dl=%ld dr=%ld di=%d\n"
@@ -399,23 +358,23 @@ int rcu_read_proc_data(char *page)
 
 		       rcu_ctrlblk.completed,
 		       rcu_data.completed,
-		       rcu_data.n_rcu_check_callbacks,
+		       trace->rcu_check_callbacks,
 
-		       rcu_data.n_next_add,
-		       rcu_data.n_next_length,
-		       rcu_data.n_wait_add,
-		       rcu_data.n_wait_length,
-		       rcu_data.n_done_add,
-		       rcu_data.n_done_length,
-		       rcu_data.n_done_remove,
-		       atomic_read(&rcu_data.n_done_invoked),
-
-		       atomic_read(&rcu_data.n_rcu_try_flip1),
-		       rcu_data.n_rcu_try_flip2,
-		       rcu_data.n_rcu_try_flip3,
-		       atomic_read(&rcu_data.n_rcu_try_flip_e1),
-		       rcu_data.n_rcu_try_flip_e2,
-		       rcu_data.n_rcu_try_flip_e3);
+		       trace->next_add,
+		       trace->next_length,
+		       trace->wait_add,
+		       trace->wait_length,
+		       trace->done_add,
+		       trace->done_length,
+		       trace->done_remove,
+		       atomic_read(&trace->done_invoked),
+
+		       atomic_read(&trace->rcu_try_flip1),
+		       trace->rcu_try_flip2,
+		       trace->rcu_try_flip3,
+		       atomic_read(&trace->rcu_try_flip_e1),
+		       trace->rcu_try_flip_e2,
+		       trace->rcu_try_flip_e3);
 }
 
 int rcu_read_proc_gp_data(char *page)
@@ -454,7 +413,7 @@ int rcu_read_proc_ctrs_data(char *page)
 	return (cnt);
 }
 
-#endif /* #ifdef CONFIG_RCU_STATS */
+#endif /* #ifdef CONFIG_RCU_TRACE */
 
 EXPORT_SYMBOL_GPL(call_rcu);
 EXPORT_SYMBOL_GPL(rcu_batches_completed);
diff -puN /dev/null kernel/rcupreempt_trace.c
--- /dev/null	2006-08-28 19:57:17.885180500 +0530
+++ linux-2.6.18-rc3-rcu-dipankar/kernel/rcupreempt_trace.c	2006-08-27 21:52:28.000000000 +0530
@@ -0,0 +1,99 @@
+/*
+ * Read-Copy Update tracing for realtime implementation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2006
+ *
+ * Papers:  http://www.rdrop.com/users/paulmck/RCU
+ *
+ * For detailed explanation of Read-Copy Update mechanism see -
+ * 		Documentation/RCU/ *.txt
+ *
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/rcupdate.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <asm/atomic.h>
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/completion.h>
+#include <linux/moduleparam.h>
+#include <linux/percpu.h>
+#include <linux/notifier.h>
+#include <linux/rcupdate.h>
+#include <linux/cpu.h>
+#include <linux/mutex.h>
+#include <linux/rcupreempt_trace.h>
+
+void rcupreempt_trace_move2done(struct rcupreempt_trace *trace)
+{
+	trace->done_length += trace->wait_length;
+	trace->done_add += trace->wait_length;
+	trace->wait_length = 0;
+}
+void rcupreempt_trace_move2wait(struct rcupreempt_trace *trace)
+{
+	trace->wait_length += trace->next_length;
+	trace->wait_add += trace->next_length;
+	trace->next_length = 0;
+}
+void rcupreempt_trace_try_flip1(struct rcupreempt_trace *trace)
+{
+	atomic_inc(&trace->rcu_try_flip1);
+}
+void rcupreempt_trace_try_flip_e1(struct rcupreempt_trace *trace)
+{
+	atomic_inc(&trace->rcu_try_flip_e1);
+}
+void rcupreempt_trace_try_flip_e2(struct rcupreempt_trace *trace)
+{
+	trace->rcu_try_flip_e2++;
+}
+void rcupreempt_trace_try_flip_e3(struct rcupreempt_trace *trace)
+{
+	trace->rcu_try_flip_e3++;
+}
+void rcupreempt_trace_try_flip2(struct rcupreempt_trace *trace)
+{
+	trace->rcu_try_flip2++;
+}
+void rcupreempt_trace_try_flip3(struct rcupreempt_trace *trace)
+{
+	trace->rcu_try_flip3++;
+}
+void rcupreempt_trace_check_callbacks(struct rcupreempt_trace *trace)
+{
+	trace->rcu_check_callbacks++;
+}
+void rcupreempt_trace_done_remove(struct rcupreempt_trace *trace)
+{
+	trace->done_remove += trace->done_length;
+	trace->done_length = 0;
+}
+void rcupreempt_trace_invoke(struct rcupreempt_trace *trace)
+{
+	atomic_inc(&trace->done_invoked);
+}
+void rcupreempt_trace_next_add(struct rcupreempt_trace *trace)
+{
+        trace->next_add++;
+        trace->next_length++;
+}

_
