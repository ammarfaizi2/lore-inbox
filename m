Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261397AbTCGG40>; Fri, 7 Mar 2003 01:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbTCGG40>; Fri, 7 Mar 2003 01:56:26 -0500
Received: from dp.samba.org ([66.70.73.150]:60802 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261397AbTCGG4M>;
	Fri, 7 Mar 2003 01:56:12 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: Patch/resubmit linux-2.5.63-bk4 try_module_get simplification 
In-reply-to: Your message of "Sun, 02 Mar 2003 09:33:24 -0800."
             <200303021733.JAA15313@adam.yggdrasil.com> 
Date: Fri, 07 Mar 2003 17:35:43 +1100
Message-Id: <20030307070646.B24F92C05A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200303021733.JAA15313@adam.yggdrasil.com> you write:
> 	Is there enough traffic on the module reference counts to make
> this trade-off worthwhile?  On x86, the module_ref array is 512 bytes
> per module (SMP_CACHE_BYTES=16 x NR_CPUS=32).  For example, my gateway

Good question.  NR_CPUS=32 is a bad default for x86, to begin with.  I
have also been working on a better kmalloc_percpu routine, so modules
(and, of course, anything else which can benefit) can switch across to
that (if DECLARE_PER_CPU is to work in modules, we *need* something
like this, which was my motivation).

I did write a "bigref" implementation a while back (attached below,
probably bitrotted), which uses a fairly simple "go to single refcount
when someone is watching" approach.  It uses synchronize_kernel() to
ensure that noone is currently doing the "if (!slow_mode)
local_inc()", but I think a cleverer implementation might use
something like Roman's speculative approach maybe?

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

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

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.42/include/linux/bigref.h working-2.5.42-bigrefs/include/linux/bigref.h
--- linux-2.5.42/include/linux/bigref.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.42-bigrefs/include/linux/bigref.h	Tue Oct 15 17:51:16 2002
@@ -0,0 +1,81 @@
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
+/* Initialize the bigref in slow mode */
+extern void bigref_init_slow(struct bigref *ref, int value);
+
+/* Move it to fast mode */
+extern void bigref_start_fast(struct bigref *ref);
+
+/* Get the approximate value */
+extern int bigref_val(struct bigref *ref);
+
+/* Wait for it refcount to hit zero (sleeps) */
+extern int bigref_wait_for_zero(struct bigref *ref, long task_state);
+
+/* Is it currently in fast mode? */
+static inline int bigref_is_fast(struct bigref *ref)
+{
+	/* Could use any cpu's, but this is cache-friendly if we're
+	   about to frob the counter */
+	return !ref->ref[smp_processor_id()].slow_mode;
+}
+
+extern void __bigref_inc(struct bigref *ref);
+extern void __bigref_dec(struct bigref *ref);
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
+static inline void bigref_dec(struct bigref *ref)
+{
+	struct bigref_percpu *cpu;
+
+	cpu = &ref->ref[get_cpu()];
+	if (likely(!cpu->slow_mode))
+		local_dec(&cpu->counter);
+	else
+		__bigref_dec(ref);
+	put_cpu();
+}
+#endif /* _LINUX_BIGREF_H */ 
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.42/include/linux/sched.h working-2.5.42-bigrefs/include/linux/sched.h
--- linux-2.5.42/include/linux/sched.h	Tue Oct 15 15:30:04 2002
+++ working-2.5.42-bigrefs/include/linux/sched.h	Tue Oct 15 17:51:16 2002
@@ -449,8 +449,10 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 
 #if CONFIG_SMP
 extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
+extern void synchronize_kernel(void);
 #else
 # define set_cpus_allowed(p, new_mask) do { } while (0)
+# define synchronize_kernel() do { } while (0)
 #endif
 
 extern void set_user_nice(task_t *p, long nice);
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.42/kernel/Makefile working-2.5.42-bigrefs/kernel/Makefile
--- linux-2.5.42/kernel/Makefile	Tue Oct 15 15:30:05 2002
+++ working-2.5.42-bigrefs/kernel/Makefile	Tue Oct 15 17:51:16 2002
@@ -3,12 +3,12 @@
 #
 
 export-objs = signal.o sys.o kmod.o workqueue.o ksyms.o pm.o exec_domain.o \
-	      printk.o platform.o suspend.o dma.o module.o cpufreq.o
+	      printk.o platform.o suspend.o dma.o module.o cpufreq.o bigref.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o workqueue.o futex.o platform.o pid.o
+	    signal.o sys.o kmod.o workqueue.o futex.o platform.o pid.o bigref.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.42/kernel/bigref.c working-2.5.42-bigrefs/kernel/bigref.c
--- linux-2.5.42/kernel/bigref.c	Thu Jan  1 10:00:00 1970
+++ working-2.5.42-bigrefs/kernel/bigref.c	Tue Oct 15 18:02:43 2002
@@ -0,0 +1,122 @@
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
+void __bigref_dec(struct bigref *ref)
+{
+	/* They *must* have read slow_mode before they touch slow
+           count, which is not guaranteed on all architectures. */
+	rmb();
+	if (atomic_dec_and_test(&ref->slow_count))
+		wake_up_process(ref->waiter);
+}
+
+void bigref_init_slow(struct bigref *ref, int value)
+{
+	unsigned int i;
+
+	/* Bias by 1 so it doesn't fall to zero with noone waiting. */
+	atomic_set(&ref->slow_count, value+1);
+	for (i = 0; i < NR_CPUS; i++) {
+		atomic_set(&ref->ref[i].counter, 0);
+		ref->ref[i].slow_mode = 1;
+	}
+	ref->waiter = NULL; /* To trap bugs */
+}
+
+/* Start it in fast mode */
+void bigref_start_fast(struct bigref *ref)
+{
+	unsigned int i;
+
+	/* Remove bias. */
+	atomic_sub(1, &ref->slow_count);
+	for (i = 0; i < NR_CPUS; i++)
+		ref->ref[i].slow_mode = 0;
+}
+
+/* Get the approximate value */
+int bigref_val(struct bigref *ref)
+{
+	unsigned int i;
+	int total;
+
+	total = atomic_read(&ref->slow_count);
+	for (i = 0; i < NR_CPUS; i++)
+		total += atomic_read(&ref->ref[i].counter);
+
+	return total;
+}
+
+int bigref_wait_for_zero(struct bigref *ref, long task_state)
+{
+	unsigned int i;
+	int total;
+
+	/* Boost it high so noone drops it to zero. */
+	atomic_add(BIGREF_BIAS, &ref->slow_count);
+	wmb();
+	for (i = 0; i < NR_CPUS; i++)
+		ref->ref[i].slow_mode = 1;
+	wmb();
+
+	/* Wait for that to sink in everywhere... */
+	synchronize_kernel();
+
+	/* Sum all the (now inactive) per-cpu counters */
+	total = BIGREF_BIAS;
+	for (i = 0; i < NR_CPUS; i++)
+		total += atomic_read(&ref->ref[i].counter);
+
+	/* Now we move those counters into the slow counter, and take
+           away the bias again.  Leave one refcount for us. */
+	atomic_sub(total - 1, &ref->slow_count);
+
+	/* Someone may dec to zero after the next step, so be ready. */
+	ref->waiter = current;
+	current->state = task_state;
+	wmb();
+
+	/* Drop (probably final) refcount */
+	__bigref_dec(ref);
+	schedule();
+
+	/* Not interrupted? */
+	if (atomic_read(&ref->slow_count) == 0)
+		return 0;
+
+	/* Revert the bigref to fast mode (assumes once it hits zero
+           it won't increase again, so code is safe) */
+	for (i = 0; i < NR_CPUS; i++) {
+		/* We already included previous per-cpu counters into
+		   total, so reset them */
+		atomic_set(&ref->ref[i].counter, 0);
+		wmb();
+		ref->ref[i].slow_mode = 0;
+	}
+
+	/* Might have decremented to zero in the meantime. */
+	if (bigref_val(ref) == 0)
+		return 0;
+	else
+		return -EINTR;
+}
+
+EXPORT_SYMBOL(__bigref_inc);
+EXPORT_SYMBOL(__bigref_dec);
+EXPORT_SYMBOL(bigref_val);
+EXPORT_SYMBOL(bigref_wait_for_zero);
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.42/kernel/sched.c working-2.5.42-bigrefs/kernel/sched.c
--- linux-2.5.42/kernel/sched.c	Tue Oct 15 15:31:06 2002
+++ working-2.5.42-bigrefs/kernel/sched.c	Tue Oct 15 17:51:16 2002
@@ -1910,6 +1910,50 @@ void __init init_idle(task_t *idle, int 
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
+	/* Highest priority we can manage. */
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
