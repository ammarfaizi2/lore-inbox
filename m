Return-Path: <linux-kernel-owner+w=401wt.eu-S1751407AbXAOTav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbXAOTav (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbXAOTav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:30:51 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:50692 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbXAOTat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:30:49 -0500
Date: Tue, 16 Jan 2007 01:00:09 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul E McKenney <paulmck@linux.vnet.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [mm PATCH 5/6] RCU: debug trace for RCU
Message-ID: <20070115193009.GF32238@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20070115191909.GA32238@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070115191909.GA32238@in.ibm.com>
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



diff -puN include/linux/rcupreempt.h~rcu-preempt-trace include/linux/rcupreempt.h
--- linux-2.6.20-rc3-mm1-rcu/include/linux/rcupreempt.h~rcu-preempt-trace	2007-01-15 15:36:56.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/include/linux/rcupreempt.h	2007-01-15 15:36:56.000000000 +0530
@@ -61,5 +61,15 @@ extern void __rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
 extern void rcu_restart_cpu(int cpu);
 
+#ifdef CONFIG_RCU_TRACE
+struct rcupreempt_trace;
+extern int *rcupreempt_flipctr(int cpu);
+extern long rcupreempt_data_completed(void);
+extern int rcupreempt_flip_flag(int cpu);
+extern int rcupreempt_mb_flag(int cpu);
+extern char *rcupreempt_try_flip_state_name(void);
+extern struct rcupreempt_trace *rcupreempt_trace(void);
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* __LINUX_RCUPREEMPT_H */
diff -puN /dev/null include/linux/rcupreempt_trace.h
--- /dev/null	2006-03-26 18:34:52.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/include/linux/rcupreempt_trace.h	2007-01-15 15:36:56.000000000 +0530
@@ -0,0 +1,102 @@
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
+ * Copyright IBM Corporation, 2006
+ *
+ * Author:  Paul McKenney <paulmck@us.ibm.com>
+ * 
+ * Based on the original work by Paul McKenney <paulmck@us.ibm.com>
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
+	long		check_callbacks;
+	atomic_t	try_flip1;
+	long		try_flip2;
+	long		try_flip3;
+	atomic_t	try_flip_e1;
+	long		try_flip_i1;
+	long		try_flip_ie1;
+	long		try_flip_g1;
+	long		try_flip_a1;
+	long		try_flip_ae1;
+	long		try_flip_a2;
+	long		try_flip_z1;
+	long		try_flip_ze1;
+	long		try_flip_z2;
+	long		try_flip_m1;
+	long		try_flip_me1;
+	long		try_flip_m2;
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
+extern void rcupreempt_trace_try_flip_i1(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip_ie1(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip_g1(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip_a1(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip_ae1(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip_a2(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip_z1(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip_ze1(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip_z2(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip_m1(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip_me1(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_try_flip_m2(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_check_callbacks(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_done_remove(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_invoke(struct rcupreempt_trace *trace);
+extern void rcupreempt_trace_next_add(struct rcupreempt_trace *trace);
+
+#endif /* __KERNEL__ */
+#endif /* __LINUX_RCUPREEMPT_TRACE_H */
diff -puN kernel/Kconfig.preempt~rcu-preempt-trace kernel/Kconfig.preempt
--- linux-2.6.20-rc3-mm1-rcu/kernel/Kconfig.preempt~rcu-preempt-trace	2007-01-15 15:36:56.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/kernel/Kconfig.preempt	2007-01-15 15:36:56.000000000 +0530
@@ -89,3 +89,14 @@ config PREEMPT_RCU
 	  Say N if you are unsure.
 
 endchoice
+
+config RCU_TRACE
+	bool "Enable tracing for RCU - currently stats in debugfs"
+	select DEBUG_FS
+	default y
+	help
+	  This option provides tracing in RCU which presents stats
+          in debugfs for debugging RCU implementation.
+ 
+	  Say Y here if you want to enable RCU tracing
+	  Say N if you are unsure.
diff -puN kernel/Makefile~rcu-preempt-trace kernel/Makefile
--- linux-2.6.20-rc3-mm1-rcu/kernel/Makefile~rcu-preempt-trace	2007-01-15 15:36:56.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/kernel/Makefile	2007-01-15 15:36:56.000000000 +0530
@@ -48,6 +48,9 @@ obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_CLASSIC_RCU) += rcuclassic.o
 obj-$(CONFIG_PREEMPT_RCU) += rcupreempt.o
+ifeq ($(CONFIG_PREEMPT_RCU),y)
+obj-$(CONFIG_RCU_TRACE) += rcupreempt_trace.o
+endif
 obj-$(CONFIG_DEBUG_SYNCHRO_TEST) += synchro-test.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_UTS_NS) += utsname.o
diff -puN kernel/rcupreempt.c~rcu-preempt-trace kernel/rcupreempt.c
--- linux-2.6.20-rc3-mm1-rcu/kernel/rcupreempt.c~rcu-preempt-trace	2007-01-15 15:36:56.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/kernel/rcupreempt.c	2007-01-15 15:36:56.000000000 +0530
@@ -50,6 +50,7 @@
 #include <linux/delay.h>
 #include <linux/byteorder/swabb.h>
 #include <linux/cpumask.h>
+#include <linux/rcupreempt_trace.h>
 
 /*
  * PREEMPT_RCU data structures.
@@ -64,6 +65,9 @@ struct rcu_data {
 	struct rcu_head **waittail;
 	struct rcu_head *donelist;
 	struct rcu_head **donetail;
+#ifdef CONFIG_RCU_TRACE 
+	struct rcupreempt_trace trace;
+#endif /* #ifdef CONFIG_RCU_TRACE */
 };
 struct rcu_ctrlblk {
 	spinlock_t	fliplock;
@@ -87,6 +91,10 @@ enum rcu_try_flip_state {
 	RCU_TRY_FLIP_WAITMB	/* "M" */
 };
 static enum rcu_try_flip_state rcu_try_flip_state = RCU_TRY_FLIP_IDLE;
+#ifdef CONFIG_RCU_TRACE
+static char *rcu_try_flip_state_names[] =
+	{ "idle", "gp", "waitack", "waitzero", "waitmb" };
+#endif /* #ifdef CONFIG_RCU_TRACE */
 
 /*
  * Enum and per-CPU flag to determine when each CPU has seen
@@ -249,12 +257,14 @@ static void __rcu_advance_callbacks(void
 		if (rcu_data.waitlist != NULL) {
 			*rcu_data.donetail = rcu_data.waitlist;
 			rcu_data.donetail = rcu_data.waittail;
+			RCU_TRACE(rcupreempt_trace_move2done, &rcu_data.trace);
 		}
 		if (rcu_data.nextlist != NULL) {
 			rcu_data.waitlist = rcu_data.nextlist;
 			rcu_data.waittail = rcu_data.nexttail;
 			rcu_data.nextlist = NULL;
 			rcu_data.nexttail = &rcu_data.nextlist;
+			RCU_TRACE(rcupreempt_trace_move2wait, &rcu_data.trace);
 		} else {
 			rcu_data.waitlist = NULL;
 			rcu_data.waittail = &rcu_data.waitlist;
@@ -275,8 +285,11 @@ static void __rcu_advance_callbacks(void
  */
 static int rcu_try_flip_idle(int flipctr)
 {
-	if (!rcu_pending(smp_processor_id()))
-		return 1;
+	RCU_TRACE(rcupreempt_trace_try_flip_i1, &rcu_data.trace);
+	if (!rcu_pending(smp_processor_id())) {
+		RCU_TRACE(rcupreempt_trace_try_flip_ie1, &rcu_data.trace);
+  		return 1;
+	}
 	return 0;
 }
 
@@ -288,6 +301,7 @@ static int rcu_try_flip_in_gp(int flipct
 {
 	int cpu;
 
+	RCU_TRACE(rcupreempt_trace_try_flip_g1, &rcu_data.trace);
 	/*
 	 * Do the flip.
 	 */
@@ -315,15 +329,19 @@ static int rcu_try_flip_waitack(int flip
 {
 	int cpu;
 
+	RCU_TRACE(rcupreempt_trace_try_flip_a1, &rcu_data.trace);
 	for_each_possible_cpu(cpu)
-		if (per_cpu(rcu_flip_flag, cpu) != RCU_FLIP_SEEN) 
-			return 1;
-
+		if (per_cpu(rcu_flip_flag, cpu) != RCU_FLIP_SEEN) {
+			RCU_TRACE(rcupreempt_trace_try_flip_ae1, 
+							&rcu_data.trace);
+  			return 1;
+		}
 	/*
 	 * Make sure our checks above don't bleed into subsequent
 	 * waiting for the sum of the counters to reach zero.
 	 */
 	smp_mb();
+	RCU_TRACE(rcupreempt_trace_try_flip_a2, &rcu_data.trace);
 	return 0;
 }
 
@@ -337,13 +355,17 @@ static int rcu_try_flip_waitzero(int fli
 	int lastidx = !(flipctr & 0x1);
 	int sum = 0;
 
+	RCU_TRACE(rcupreempt_trace_try_flip_z1, &rcu_data.trace);
 	/* Check to see if the sum of the "last" counters is zero. */
 
 	for_each_possible_cpu(cpu)
 		sum += per_cpu(rcu_flipctr, cpu)[lastidx];
-	if (sum != 0)
+	if (sum != 0) {
+		RCU_TRACE(rcupreempt_trace_try_flip_ze1, &rcu_data.trace);
 		return 1;
+	}
 
+	RCU_TRACE(rcupreempt_trace_try_flip_z2, &rcu_data.trace);
 	/* Make sure we don't call for memory barriers before we see zero. */
 	smp_mb();
 
@@ -362,11 +384,16 @@ static int rcu_try_flip_waitmb(int flipc
 {
 	int cpu;
 
+	RCU_TRACE(rcupreempt_trace_try_flip_m1, &rcu_data.trace);
 	for_each_possible_cpu(cpu)
-		if (per_cpu(rcu_mb_flag, cpu) != RCU_MB_DONE)
+		if (per_cpu(rcu_mb_flag, cpu) != RCU_MB_DONE) {
+			RCU_TRACE(rcupreempt_trace_try_flip_me1, 
+							&rcu_data.trace);
 			return 1;
+		}
 
 	smp_mb(); /* Ensure that the above checks precede any following flip. */
+	RCU_TRACE(rcupreempt_trace_try_flip_m2, &rcu_data.trace);
 	return 0;
 }
 
@@ -384,8 +411,11 @@ static void rcu_try_flip(void)
 	long flipctr;
 	unsigned long oldirq;
 
-	if (unlikely(!spin_trylock_irqsave(&rcu_ctrlblk.fliplock, oldirq))) 
+	RCU_TRACE(rcupreempt_trace_try_flip1, &rcu_data.trace);
+	if (unlikely(!spin_trylock_irqsave(&rcu_ctrlblk.fliplock, oldirq))) {
+		RCU_TRACE(rcupreempt_trace_try_flip_e1, &rcu_data.trace);
 		return;
+	}
 
 	/*
 	 * Take the next transition(s) through the RCU grace-period
@@ -462,6 +492,7 @@ void rcu_check_callbacks(int cpu, int us
 		}
 	}
 	spin_lock_irqsave(&rcu_data.lock, oldirq);
+	RCU_TRACE(rcupreempt_trace_check_callbacks, &rcu_data.trace);
 	__rcu_advance_callbacks();
 	if (rcu_data.donelist == NULL)
 		spin_unlock_irqrestore(&rcu_data.lock, oldirq);
@@ -514,11 +545,13 @@ static void rcu_process_callbacks(struct
 	}
 	rcu_data.donelist = NULL;
 	rcu_data.donetail = &rcu_data.donelist;
+	RCU_TRACE(rcupreempt_trace_done_remove, &rcu_data.trace);
 	spin_unlock_irqrestore(&rcu_data.lock, flags);
 	while (list) {
 		next = list->next;
 		list->func(list);
 		list = next;
+		RCU_TRACE(rcupreempt_trace_invoke, &rcu_data.trace);
 	}
 }
 
@@ -533,6 +566,7 @@ void fastcall call_rcu(struct rcu_head *
 	__rcu_advance_callbacks();
 	*rcu_data.nexttail = head;
 	rcu_data.nexttail = &head->next;
+	RCU_TRACE(rcupreempt_trace_next_add, &rcu_data.trace);
 	spin_unlock_irqrestore(&rcu_data.lock, flags);
 }
 
@@ -585,6 +619,37 @@ void synchronize_kernel(void)
 	synchronize_rcu();
 }
 
+#ifdef RCU_TRACE
+int *rcupreempt_flipctr(int cpu)
+{
+	return &per_cpu(rcu_flipctr, cpu)[0];
+}
+long rcupreempt_data_completed(void)
+{
+	return rcu_data.completed;
+}
+int rcupreempt_flip_flag(int cpu)
+{
+	return per_cpu(rcu_flip_flag, cpu);
+}
+int rcupreempt_mb_flag(int cpu)
+{
+	return per_cpu(rcu_mb_flag, cpu);
+}
+char *rcupreempt_try_flip_state_name(void)
+{
+	return rcu_try_flip_state_names[rcu_try_flip_state];
+}
+struct rcupreempt_trace *rcupreempt_trace(void)
+{
+	return &rcu_data.trace;
+}
+EXPORT_SYMBOL_GPL(rcupreempt_flipctr);
+EXPORT_SYMBOL_GPL(rcupreempt_data_completed);
+EXPORT_SYMBOL_GPL(rcupreempt_flip_flag);
+EXPORT_SYMBOL_GPL(rcupreempt_mb_flag);
+EXPORT_SYMBOL_GPL(rcupreempt_try_flip_state_name);
+#endif /* #ifdef RCU_TRACE */
 
 EXPORT_SYMBOL_GPL(call_rcu);
 EXPORT_SYMBOL_GPL(rcu_batches_completed);
diff -puN /dev/null kernel/rcupreempt_trace.c
--- /dev/null	2006-03-26 18:34:52.000000000 +0530
+++ linux-2.6.20-rc3-mm1-rcu-dipankar/kernel/rcupreempt_trace.c	2007-01-15 15:36:56.000000000 +0530
@@ -0,0 +1,308 @@
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
+ * Copyright IBM Corporation, 2006
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
+#include <linux/debugfs.h>
+
+static struct mutex rcupreempt_trace_mutex;
+static char *rcupreempt_trace_buf;
+#define RCUPREEMPT_TRACE_BUF_SIZE 4096
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
+	atomic_inc(&trace->try_flip1);
+}
+void rcupreempt_trace_try_flip_e1(struct rcupreempt_trace *trace)
+{
+	atomic_inc(&trace->try_flip_e1);
+}
+void rcupreempt_trace_try_flip2(struct rcupreempt_trace *trace)
+{
+	trace->try_flip2++;
+}
+void rcupreempt_trace_try_flip3(struct rcupreempt_trace *trace)
+{
+	trace->try_flip3++;
+}
+void rcupreempt_trace_try_flip_i1(struct rcupreempt_trace *trace)
+{
+	trace->try_flip_i1++;
+}
+void rcupreempt_trace_try_flip_ie1(struct rcupreempt_trace *trace)
+{
+	trace->try_flip_ie1++;
+}
+void rcupreempt_trace_try_flip_g1(struct rcupreempt_trace *trace)
+{
+	trace->try_flip_g1++;
+}
+void rcupreempt_trace_try_flip_a1(struct rcupreempt_trace *trace)
+{
+	trace->try_flip_a1++;
+}
+void rcupreempt_trace_try_flip_ae1(struct rcupreempt_trace *trace)
+{
+	trace->try_flip_ae1++;
+}
+void rcupreempt_trace_try_flip_a2(struct rcupreempt_trace *trace)
+{
+	trace->try_flip_a2++;
+}
+void rcupreempt_trace_try_flip_z1(struct rcupreempt_trace *trace)
+{
+	trace->try_flip_z1++;
+}
+void rcupreempt_trace_try_flip_ze1(struct rcupreempt_trace *trace)
+{
+	trace->try_flip_ze1++;
+}
+void rcupreempt_trace_try_flip_z2(struct rcupreempt_trace *trace)
+{
+	trace->try_flip_z2++;
+}
+void rcupreempt_trace_try_flip_m1(struct rcupreempt_trace *trace)
+{
+	trace->try_flip_m1++;
+}
+void rcupreempt_trace_try_flip_me1(struct rcupreempt_trace *trace)
+{
+	trace->try_flip_me1++;
+}
+void rcupreempt_trace_try_flip_m2(struct rcupreempt_trace *trace)
+{
+	trace->try_flip_m2++;
+}
+void rcupreempt_trace_check_callbacks(struct rcupreempt_trace *trace)
+{
+	trace->check_callbacks++;
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
+
+static ssize_t rcustats_read(struct file *filp, char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	struct rcupreempt_trace *trace = rcupreempt_trace();
+	ssize_t bcount;
+
+	mutex_lock(&rcupreempt_trace_mutex);
+	snprintf(rcupreempt_trace_buf, RCUPREEMPT_TRACE_BUF_SIZE,
+		       "ggp=%ld lgp=%ld rcc=%ld\n"
+		       "na=%ld nl=%ld wa=%ld wl=%ld da=%ld dl=%ld dr=%ld di=%d\n"
+		       "1=%d e1=%d i1=%ld ie1=%ld g1=%ld a1=%ld ae1=%ld a2=%ld\n"
+		       "z1=%ld ze1=%ld z2=%ld m1=%ld me1=%ld m2=%ld\n",
+
+		       rcu_batches_completed(),
+		       rcupreempt_data_completed(),
+		       trace->check_callbacks,
+		       trace->next_add,
+		       trace->next_length,
+		       trace->wait_add,
+		       trace->wait_length,
+		       trace->done_add,
+		       trace->done_length,
+		       trace->done_remove,
+		       atomic_read(&trace->done_invoked),
+		       atomic_read(&trace->try_flip1),
+		       atomic_read(&trace->try_flip_e1),
+		       trace->try_flip_i1,
+		       trace->try_flip_ie1,
+		       trace->try_flip_g1,
+		       trace->try_flip_a1,
+		       trace->try_flip_ae1,
+		       trace->try_flip_a2,
+		       trace->try_flip_z1,
+		       trace->try_flip_ze1,
+		       trace->try_flip_z2,
+		       trace->try_flip_m1,
+		       trace->try_flip_me1,
+		       trace->try_flip_m2);
+	bcount = simple_read_from_buffer(buffer, count, ppos, 
+			rcupreempt_trace_buf, strlen(rcupreempt_trace_buf));
+	mutex_unlock(&rcupreempt_trace_mutex);
+	return bcount;
+}
+
+static ssize_t rcugp_read(struct file *filp, char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	long oldgp = rcu_batches_completed();
+	ssize_t bcount;
+
+	mutex_lock(&rcupreempt_trace_mutex);
+	synchronize_rcu();
+	snprintf(rcupreempt_trace_buf, RCUPREEMPT_TRACE_BUF_SIZE, 
+		"oldggp=%ld  newggp=%ld\n", oldgp, rcu_batches_completed());
+	bcount = simple_read_from_buffer(buffer, count, ppos, 
+			rcupreempt_trace_buf, strlen(rcupreempt_trace_buf));
+	mutex_unlock(&rcupreempt_trace_mutex);
+	return bcount;
+}
+
+static ssize_t rcuctrs_read(struct file *filp, char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	int cnt = 0;
+	int cpu;
+	int f = rcu_batches_completed() & 0x1;
+	ssize_t bcount;
+
+	mutex_lock(&rcupreempt_trace_mutex);
+
+	cnt += snprintf(&rcupreempt_trace_buf[cnt], RCUPREEMPT_TRACE_BUF_SIZE, 
+				"CPU last cur F M\n");
+	for_each_online_cpu(cpu) {
+		int *flipctr = rcupreempt_flipctr(cpu);
+		cnt += snprintf(&rcupreempt_trace_buf[cnt], 
+				RCUPREEMPT_TRACE_BUF_SIZE - cnt,
+					"%3d %4d %3d %d %d\n",
+			       cpu,
+			       flipctr[!f],
+			       flipctr[f],
+			       rcupreempt_flip_flag(cpu),
+			       rcupreempt_mb_flag(cpu));
+	}
+	cnt += snprintf(&rcupreempt_trace_buf[cnt],
+			RCUPREEMPT_TRACE_BUF_SIZE - cnt,
+			"ggp = %ld, state = %s\n",
+			rcupreempt_data_completed(), 
+			rcupreempt_try_flip_state_name());
+	cnt += snprintf(&rcupreempt_trace_buf[cnt], 
+			RCUPREEMPT_TRACE_BUF_SIZE - cnt,
+			"\n");
+	bcount = simple_read_from_buffer(buffer, count, ppos, 
+			rcupreempt_trace_buf, strlen(rcupreempt_trace_buf));
+	mutex_unlock(&rcupreempt_trace_mutex);
+	return bcount;
+}
+
+static struct file_operations rcustats_fops = {
+	.owner = THIS_MODULE,
+	.read = rcustats_read,
+};
+
+static struct file_operations rcugp_fops = {
+	.owner = THIS_MODULE,
+	.read = rcugp_read,
+};
+
+static struct file_operations rcuctrs_fops = {
+	.owner = THIS_MODULE,
+	.read = rcuctrs_read,
+};
+
+static struct dentry *rcudir, *statdir, *ctrsdir, *gpdir;
+static int rcupreempt_debugfs_init(void)
+{
+	rcudir = debugfs_create_dir("rcu", NULL);
+	if (!rcudir)
+		goto out;
+	statdir = debugfs_create_file("rcustats", 0444, rcudir, 
+						NULL, &rcustats_fops);
+	if (!statdir)
+		goto free_out;
+
+	gpdir = debugfs_create_file("rcugp", 0444, rcudir, NULL, &rcugp_fops);
+	if (!gpdir)
+		goto free_out;
+
+	ctrsdir = debugfs_create_file("rcuctrs", 0444, rcudir, 
+						NULL, &rcuctrs_fops);
+	if (!ctrsdir)
+		goto free_out;
+	return 0;
+free_out:
+	if (statdir)
+		debugfs_remove(statdir);
+	if (gpdir)
+		debugfs_remove(gpdir);
+	debugfs_remove(rcudir);
+out:
+	return 1;
+}
+
+static int __init rcupreempt_trace_init(void)
+{
+	mutex_init(&rcupreempt_trace_mutex);
+	rcupreempt_trace_buf = kmalloc(RCUPREEMPT_TRACE_BUF_SIZE, GFP_KERNEL);
+	if (!rcupreempt_trace_buf)
+		return 1;
+	return rcupreempt_debugfs_init();
+}
+
+static void __exit rcupreempt_trace_cleanup(void)
+{
+	debugfs_remove(statdir);
+	debugfs_remove(gpdir);
+	debugfs_remove(ctrsdir);
+	debugfs_remove(rcudir);
+	kfree(rcupreempt_trace_buf);
+}
+
+
+module_init(rcupreempt_trace_init);
+module_exit(rcupreempt_trace_cleanup);

_
