Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265023AbSIRCNW>; Tue, 17 Sep 2002 22:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265020AbSIRCNG>; Tue, 17 Sep 2002 22:13:06 -0400
Received: from dp.samba.org ([66.70.73.150]:61613 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265023AbSIRCMO>;
	Tue, 17 Sep 2002 22:12:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Subject: [PATCH] In-kernel module loader 3/7
Date: Wed, 18 Sep 2002 12:07:39 +1000
Message-Id: <20020918021714.E9A292C13A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Bigrefs Implementation
Author: Rusty Russell
Status: Tested on 2.5.35
Depends: Misc/later.patch.gz

D: This is an implementation of cache-friendly reference counts.  The
D: refcounters work in two modes: the normal mode just incs and decs a
D: cache-aligned per-cpu counter.  When someone is waiting for the
D: reference count to hit 0, a flag is set and a shared reference
D: counter is decremented (which is slower).
D: 
D: This uses the wait_for_later() primitive, but it doesn't need to:
D: it could manually reschedule on each online CPU.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11594-2.5.35-bigrefs.pre/include/linux/bigref.h .11594-2.5.35-bigrefs/include/linux/bigref.h
--- .11594-2.5.35-bigrefs.pre/include/linux/bigref.h	1970-01-01 10:00:00.000000000 +1000
+++ .11594-2.5.35-bigrefs/include/linux/bigref.h	2002-09-18 07:25:34.000000000 +1000
@@ -0,0 +1,73 @@
+#ifndef _LINUX_BIGREF_H
+#define _LINUX_BIGREF_H
+#include <linux/cache.h>
+#include <linux/smp.h>
+#include <linux/compiler.h>
+#include <linux/thread_info.h>
+#include <asm/atomic.h>
+
+/* Big reference counts for Linux.
+ *   (C) Copyright 2002 Paul Russell, IBM Corporation.
+ */
+
+struct bigref_percpu
+{
+	int counter;
+	int slow_mode;
+} ____cacheline_aligned;
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
+	ref->ref[0].counter = value;
+	for (i = 1; i < NR_CPUS; i++)
+		ref->ref[i].counter = 0;
+	ref->waiter = NULL; /* To trap bugs */
+}
+
+extern void __bigref_inc(struct bigref *ref);
+extern void __bigref_dec(struct bigref *ref);
+
+/* Stopping interrupts faster than atomics on many archs (and more
+   easily optimized if they're not) */
+static inline void bigref_inc(struct bigref *ref)
+{
+	unsigned long flags;
+	struct bigref_percpu *cpu;
+
+	local_irq_save(flags);
+	cpu = &ref->ref[smp_processor_id()];
+	if (likely(!cpu->slow_mode))
+		cpu->counter++;
+	else
+		__bigref_inc(ref);
+	local_irq_restore(flags);
+}
+
+static inline void bigref_dec(struct bigref *ref)
+{
+	unsigned long flags;
+	struct bigref_percpu *cpu;
+
+	local_irq_save(flags);
+	cpu = &ref->ref[smp_processor_id()];
+	if (likely(!cpu->slow_mode))
+		cpu->counter--;
+	else
+		__bigref_dec(ref);
+	local_irq_restore(flags);
+}
+
+/* Get the approximate value */
+extern int bigref_approx_val(struct bigref *ref);
+
+extern void bigref_wait_for_zero(struct bigref *ref);
+#endif /* _LINUX_BIGREF_H */ 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11594-2.5.35-bigrefs.pre/kernel/Makefile .11594-2.5.35-bigrefs/kernel/Makefile
--- .11594-2.5.35-bigrefs.pre/kernel/Makefile	2002-09-18 07:25:32.000000000 +1000
+++ .11594-2.5.35-bigrefs/kernel/Makefile	2002-09-18 07:25:34.000000000 +1000
@@ -10,12 +10,12 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o dma.o
+		printk.o platform.o suspend.o dma.o bigref.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o bigref.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11594-2.5.35-bigrefs.pre/kernel/bigref.c .11594-2.5.35-bigrefs/kernel/bigref.c
--- .11594-2.5.35-bigrefs.pre/kernel/bigref.c	1970-01-01 10:00:00.000000000 +1000
+++ .11594-2.5.35-bigrefs/kernel/bigref.c	2002-09-18 07:25:34.000000000 +1000
@@ -0,0 +1,74 @@
+/* Big reference counts for Linux.
+ *   (C) Copyright 2002 Paul Russell, IBM Corporation.
+ */
+#include <linux/bigref.h>
+#include <linux/later.h>
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
+void __bigref_dec(struct bigref *ref)
+{
+	/* They *must* have read slow_mode before they touch slow
+           count, which is not guaranteed on all architectures. */
+	rmb();
+	if (atomic_dec_and_test(&ref->slow_count))
+		wake_up_process(ref->waiter);
+}
+
+/* Get the approximate value */
+int bigref_approx_val(struct bigref *ref)
+{
+	unsigned int i;
+	int total = 0;
+
+	for (i = 0; i < NR_CPUS; i++)
+		total += ref->ref[i].counter;
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
+	/* Wait for that to sink in everywhere... */
+	wait_for_later();
+
+	/* Sum all the (now inactive) per-cpu counters */
+	for (i = 0, total = 0; i < NR_CPUS; i++)
+		total += ref->ref[i].counter;
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

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
