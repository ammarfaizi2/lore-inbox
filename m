Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbSIYD14>; Tue, 24 Sep 2002 23:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261902AbSIYD0l>; Tue, 24 Sep 2002 23:26:41 -0400
Received: from dp.samba.org ([66.70.73.150]:46720 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261898AbSIYDQr>;
	Tue, 24 Sep 2002 23:16:47 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: [PATCH] Module rewrite 2/20: bigrefs
Date: Wed, 25 Sep 2002 13:00:10 +1000
Message-Id: <20020925032201.CF8A72C14D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Bigrefs Implementation
Author: Rusty Russell
Status: Tested on 2.5.38

D: This is an implementation of cache-friendly reference counts.  The
D: refcounters work in two modes: the normal mode just incs and decs a
D: cache-aligned per-cpu counter.  When someone is waiting for the
D: reference count to hit 0, a flag is set and a shared reference
D: counter is decremented (which is slower).
D: 
D: This uses a simple non-intrusive synchronize_kernel() primitive.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13385-linux-2.5.38/include/linux/bigref.h .13385-linux-2.5.38.updated/include/linux/bigref.h
--- .13385-linux-2.5.38/include/linux/bigref.h	1970-01-01 10:00:00.000000000 +1000
+++ .13385-linux-2.5.38.updated/include/linux/bigref.h	2002-09-25 10:30:06.000000000 +1000
@@ -0,0 +1,78 @@
+#ifndef _LINUX_BIGREF_H
+#define _LINUX_BIGREF_H
+#include <linux/cache.h>
+#include <linux/smp.h>
+#include <linux/compiler.h>
+#include <linux/thread_info.h>
+#include <linux/preempt.h>
+#include <asm/atomic.h>
+
+/* Big reference counts for Linux.
+ *   (C) Copyright 2002 Paul Russell, IBM Corporation.
+ */
+
+struct bigref_percpu
+{
+	atomic_t counter;
+	int slow_mode;
+} ____cacheline_aligned_in_smp;
+
+struct bigref
+{
+	struct bigref_percpu ref[NR_CPUS];
+
+	atomic_t slow_count;
+	struct task_struct *waiter;
+};
+
+static inline void bigref_init(struct bigref *ref, int value)
+{
+	unsigned int i;
+	atomic_set(&ref->ref[0].counter, value);
+	for (i = 1; i < NR_CPUS; i++)
+		atomic_set(&ref->ref[i].counter, 0);
+	ref->waiter = NULL; /* To trap bugs */
+}
+
+extern void __bigref_inc(struct bigref *ref);
+extern int __bigref_dec(struct bigref *ref);
+
+/* We only need protection against local interrupts. */
+#ifndef __HAVE_LOCAL_INC
+#define local_inc(x) atomic_inc(x)
+#define local_dec(x) atomic_dec(x)
+#endif
+
+static inline void bigref_inc(struct bigref *ref)
+{
+	struct bigref_percpu *cpu;
+
+	cpu = &ref->ref[get_cpu()];
+	if (likely(!cpu->slow_mode))
+		local_inc(&cpu->counter);
+	else
+		__bigref_inc(ref);
+	put_cpu();
+}
+
+/* Return true if we were the last one to decrement it */
+static inline int bigref_dec(struct bigref *ref)
+{
+	struct bigref_percpu *cpu;
+	int ret = 0;
+
+	cpu = &ref->ref[get_cpu()];
+	if (likely(!cpu->slow_mode))
+		local_dec(&cpu->counter);
+	else
+		ret = __bigref_dec(ref);
+	put_cpu();
+	return ret;
+}
+
+/* Get the approximate value */
+extern int bigref_approx_val(struct bigref *ref);
+
+/* Wait for it refcount to hit zero (sleeps) */
+extern void bigref_wait_for_zero(struct bigref *ref);
+#endif /* _LINUX_BIGREF_H */ 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13385-linux-2.5.38/include/linux/sched.h .13385-linux-2.5.38.updated/include/linux/sched.h
--- .13385-linux-2.5.38/include/linux/sched.h	2002-09-21 13:55:19.000000000 +1000
+++ .13385-linux-2.5.38.updated/include/linux/sched.h	2002-09-25 10:30:06.000000000 +1000
@@ -445,8 +445,10 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 
 #if CONFIG_SMP
 extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
+extern void synchronize_kernel(void);
 #else
 # define set_cpus_allowed(p, new_mask) do { } while (0)
+# define synchronize_kernel() do { } while (0)
 #endif
 
 extern void set_user_nice(task_t *p, long nice);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13385-linux-2.5.38/kernel/Makefile .13385-linux-2.5.38.updated/kernel/Makefile
--- .13385-linux-2.5.38/kernel/Makefile	2002-09-21 13:55:19.000000000 +1000
+++ .13385-linux-2.5.38.updated/kernel/Makefile	2002-09-25 10:30:06.000000000 +1000
@@ -3,12 +3,12 @@
 #
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o dma.o
+		printk.o platform.o suspend.o dma.o bigref.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o pid.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o pid.o bigref.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13385-linux-2.5.38/kernel/bigref.c .13385-linux-2.5.38.updated/kernel/bigref.c
--- .13385-linux-2.5.38/kernel/bigref.c	1970-01-01 10:00:00.000000000 +1000
+++ .13385-linux-2.5.38.updated/kernel/bigref.c	2002-09-25 10:30:06.000000000 +1000
@@ -0,0 +1,78 @@
+/* Big reference counts for Linux.
+ *   (C) Copyright 2002 Paul Russell, IBM Corporation.
+ */
+#include <linux/bigref.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+
+/* Atomic is 24 bits on sparc, so make this 23. */
+#define BIGREF_BIAS (1 << 23)
+
+void __bigref_inc(struct bigref *ref)
+{
+	/* They *must* have read slow_mode before they touch slow
+           count, which is not guaranteed on all architectures. */
+	rmb();
+	atomic_inc(&ref->slow_count);
+}
+
+int __bigref_dec(struct bigref *ref)
+{
+	int ret = 0;
+	/* They *must* have read slow_mode before they touch slow
+           count, which is not guaranteed on all architectures. */
+	rmb();
+	if (atomic_dec_and_test(&ref->slow_count)) {
+		wake_up_process(ref->waiter);
+		ret = 1;
+	}
+	return ret;
+}
+
+/* Get the approximate value */
+int bigref_approx_val(struct bigref *ref)
+{
+	unsigned int i;
+	int total = 0;
+
+	for (i = 0; i < NR_CPUS; i++)
+		total += atomic_read(&ref->ref[i].counter);
+
+	return total;
+}
+
+void bigref_wait_for_zero(struct bigref *ref)
+{
+	unsigned int i;
+	int total;
+
+	atomic_set(&ref->slow_count, BIGREF_BIAS);
+	wmb();
+	for (i = 0; i < NR_CPUS; i++)
+		ref->ref[i].slow_mode = 1;
+	wmb();
+
+	/* Wait for that to sink in everywhere... */
+	synchronize_kernel();
+
+	/* Sum all the (now inactive) per-cpu counters */
+	total = bigref_approx_val(ref);
+
+	/* Now we move those counters into the slow counter, and take
+           away the bias again.  Leave one refcount for us. */
+	atomic_sub(BIGREF_BIAS + total - 1, &ref->slow_count);
+
+	/* Someone may dec to zero after the next step, so be ready. */
+	ref->waiter = current;
+	current->state = TASK_UNINTERRUPTIBLE;
+	wmb();
+
+	/* Drop (probably final) refcount */
+	__bigref_dec(ref);
+	schedule();
+}
+
+EXPORT_SYMBOL(__bigref_inc);
+EXPORT_SYMBOL(__bigref_dec);
+EXPORT_SYMBOL(bigref_approx_val);
+EXPORT_SYMBOL(bigref_wait_for_zero);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .13385-linux-2.5.38/kernel/sched.c .13385-linux-2.5.38.updated/kernel/sched.c
--- .13385-linux-2.5.38/kernel/sched.c	2002-09-23 08:54:54.000000000 +1000
+++ .13385-linux-2.5.38.updated/kernel/sched.c	2002-09-25 10:30:06.000000000 +1000
@@ -1898,6 +1898,50 @@ void __init init_idle(task_t *idle, int 
 }
 
 #if CONFIG_SMP
+/* This scales quite well (eg. 64 processors, average time to wait for
+   first schedule = jiffie/64.  Total time for all processors =
+   jiffie/63 + jiffie/62...
+
+   At 1024 cpus, this is about 7.5 jiffies.  And that assumes noone
+   schedules early. --RR */
+void synchronize_kernel(void)
+{
+	unsigned long cpus_allowed, old_cpus_allowed, old_prio, old_policy;
+	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
+	unsigned int i;
+
+	/* Save old values. */
+	read_lock_irq(&tasklist_lock);
+	old_cpus_allowed = current->cpus_allowed;
+	old_prio = current->rt_priority;
+	old_policy = current->policy;
+	read_unlock_irq(&tasklist_lock);
+
+	/* Create an unreal time task. */
+	setscheduler(current->pid, SCHED_FIFO, &param);
+
+	/* Make us schedulable on all other online CPUs: if we get
+	   preempted here it doesn't really matter, since it means we
+	   *did* run on the cpu returned by smp_processor_id(), which
+	   is all we care about. */
+	cpus_allowed = 0;
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_online(i) && i != smp_processor_id())
+			cpus_allowed |= (1 << i);
+
+	while (cpus_allowed) {
+		/* Change CPUs */
+		set_cpus_allowed(current, cpus_allowed);
+		/* Eliminate this one */
+		cpus_allowed &= ~(1 << smp_processor_id());
+	}
+
+	/* Back to normal. */
+	set_cpus_allowed(current, old_cpus_allowed);
+	param.sched_priority = old_prio;
+	setscheduler(current->pid, old_policy, &param);
+}
+
 /*
  * This is how migration works:
  *

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
