Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272718AbRILIYb>; Wed, 12 Sep 2001 04:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272706AbRILIYX>; Wed, 12 Sep 2001 04:24:23 -0400
Received: from sydney2.au.ibm.com ([202.135.142.197]:10244 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S272717AbRILIYL>; Wed, 12 Sep 2001 04:24:11 -0400
Date: Wed, 12 Sep 2001 18:24:40 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre7aa1
Message-Id: <20010912182440.3975719b.rusty@rustcorp.com.au>
In-Reply-To: <20010910175416.A714@athlon.random>
In-Reply-To: <20010910175416.A714@athlon.random>
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2001 17:54:17 +0200
Andrea Arcangeli <andrea@suse.de> wrote:
> Only in 2.4.10pre7aa1: 00_rcu-1
> 
> 	wait_for_rcu and call_rcu implementation (from IBM). I did some
> 	modifications with respect to the original version from IBM.
> 	In particular I dropped the vmalloc_rcu/kmalloc_rcu, the
> 	rcu_head must always be allocated in the data structures, it has
> 	to be a field of a class, rather than hiding it in the allocation
> 	and playing dirty and risky with casts on a bigger allocation.

Hi Andrea, 

	Like the kernel threads approach, but AFAICT it won't work for the case of two CPUs running wait_for_rcu at the same time (on a 4-way or above).

	Please try actually *using* the RCU code before you complain about the wrappers: you'll end up writing your own wrappers.  I look forward to seeing what you come up with (handling the case of the rcu structure in an arbitrary offset within the structure is possible, but my solutions were all less neat).

Preferred patch below,
Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.4.7-module/include/linux/rcupdate.h working-2.4.7-rcu/include/linux/rcupdate.h
--- working-2.4.7-module/include/linux/rcupdate.h	Thu Jan  1 10:00:00 1970
+++ working-2.4.7-rcu/include/linux/rcupdate.h	Wed Aug 29 10:19:13 2001
@@ -0,0 +1,58 @@
+#ifndef _LINUX_RCUPDATE_H
+#define _LINUX_RCUPDATE_H
+/* Read-Copy-Update For Linux. */
+#include <linux/malloc.h>
+#include <linux/cache.h>
+#include <linux/vmalloc.h>
+#include <asm/atomic.h>
+
+struct rcu_head
+{
+	struct rcu_head *next;
+	void (*func)(void *obj);
+};
+
+/* Count of pending requests: for optimization in schedule() */
+extern atomic_t rcu_pending;
+
+/* Queues future request. */
+void call_rcu(struct rcu_head *head, void (*func)(void *head));
+
+/* Convenience wrappers: */
+static inline void *kmalloc_rcu(size_t size, int flags)
+{
+	void *ret;
+
+	size += L1_CACHE_ALIGN(sizeof(struct rcu_head));
+	ret = kmalloc(size, flags);
+	if (!ret)
+		return NULL;
+	return ret + L1_CACHE_ALIGN(sizeof(struct rcu_head));
+}
+
+static inline void kfree_rcu(void *obj)
+{
+	call_rcu(obj - L1_CACHE_ALIGN(sizeof(struct rcu_head)),
+		 (void (*)(void *))kfree);
+}
+
+static inline void *vmalloc_rcu(size_t size)
+{
+	void *ret;
+
+	size += L1_CACHE_ALIGN(sizeof(struct rcu_head));
+	ret = vmalloc(size);
+	if (!ret)
+		return NULL;
+	return ret + L1_CACHE_ALIGN(sizeof(struct rcu_head));
+}
+
+static inline void vfree_rcu(void *obj)
+{
+	call_rcu(obj - L1_CACHE_ALIGN(sizeof(struct rcu_head)),
+		 (void (*)(void *))vfree);
+}
+
+/* Called by schedule() when batch reference count drops to zero. */
+void rcu_batch_done(void);
+#endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.4.7-module/kernel/Makefile working-2.4.7-rcu/kernel/Makefile
--- working-2.4.7-module/kernel/Makefile	Sat Dec 30 09:07:24 2000
+++ working-2.4.7-rcu/kernel/Makefile	Wed Aug 29 10:12:08 2001
@@ -9,12 +9,12 @@
 
 O_TARGET := kernel.o
 
-export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o
+export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o rcupdate.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o
+	    signal.o sys.o kmod.o context.o rcupdate.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.4.7-module/kernel/rcupdate.c working-2.4.7-rcu/kernel/rcupdate.c
--- working-2.4.7-module/kernel/rcupdate.c	Thu Jan  1 10:00:00 1970
+++ working-2.4.7-rcu/kernel/rcupdate.c	Wed Aug 29 10:20:31 2001
@@ -0,0 +1,65 @@
+/* Read-Copy-Update For Linux. */
+#include <linux/rcupdate.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+
+/* Count of pending requests: for optimization in schedule() */
+atomic_t rcu_pending = ATOMIC_INIT(0);
+
+/* Two batches per CPU : one (pending) is an internal queue of waiting
+   requests, being prepended to as new requests come in.  The other
+   (rcu_waiting) is waiting completion of schedule()s on all CPUs. */
+struct rcu_batch
+{
+	/* Two sets of queues: one queueing, one waiting quiescent finish */
+	int queueing;
+	/* Three queues: hard interrupt, soft interrupt, neither */
+	struct rcu_head *head[2][3];
+} __attribute__((__aligned__(SMP_CACHE_BYTES)));
+
+static struct rcu_batch rcu_batch[NR_CPUS];
+
+void call_rcu(struct rcu_head *head, void (*func)(void *head))
+{
+	unsigned cpu = smp_processor_id();
+	unsigned state;
+	struct rcu_head **headp;
+
+	head->func = func;
+	if (in_interrupt()) {
+		if (in_irq()) state = 2;
+		else state = 1;
+	} else state = 0;
+
+	/* Figure out which queue we're on. */
+	headp = &rcu_batch[cpu].head[rcu_batch[cpu].queueing][state];
+
+	atomic_inc(&rcu_pending);
+	/* Prepend to this CPU's list: no locks needed. */
+	head->next = *headp;
+	*headp = head;
+}
+
+/* Calls every callback in the waiting rcu batch. */
+void rcu_batch_done(void)
+{
+	struct rcu_head *i, *next;
+	struct rcu_batch *mybatch;
+	unsigned int q;
+
+	mybatch = &rcu_batch[smp_processor_id()];
+	/* Call callbacks: probably delete themselves, must not schedule. */
+	for (q = 0; q < 3; q++) {
+		for (i = mybatch->head[!mybatch->queueing][q]; i; i = next) {
+			next = i->next;
+			i->func(i);
+			atomic_dec(&rcu_pending);
+		}
+		mybatch->head[!mybatch->queueing][q] = NULL;
+	}
+
+	/* Start queueing on this batch. */
+	mybatch->queueing = !mybatch->queueing;
+}
+
+EXPORT_SYMBOL(call_rcu);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.4.7-module/kernel/sched.c working-2.4.7-rcu/kernel/sched.c
--- working-2.4.7-module/kernel/sched.c	Sun Jul 22 13:13:25 2001
+++ working-2.4.7-rcu/kernel/sched.c	Wed Aug 29 10:23:02 2001
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <linux/completion.h>
+#include <linux/rcupdate.h>
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -99,12 +100,15 @@
 	struct schedule_data {
 		struct task_struct * curr;
 		cycles_t last_schedule;
+		int ring_count, finished_count;
 	} schedule_data;
 	char __pad [SMP_CACHE_BYTES];
-} aligned_data [NR_CPUS] __cacheline_aligned = { {{&init_task,0}}};
+} aligned_data [NR_CPUS] __cacheline_aligned = { {{&init_task,0,0,0}}};
 
 #define cpu_curr(cpu) aligned_data[(cpu)].schedule_data.curr
 #define last_schedule(cpu) aligned_data[(cpu)].schedule_data.last_schedule
+#define ring_count(cpu) aligned_data[(cpu)].schedule_data.ring_count
+#define finished_count(cpu) aligned_data[(cpu)].schedule_data.finished_count
 
 struct kernel_stat kstat;
 
@@ -544,6 +548,10 @@
 
 	release_kernel_lock(prev, this_cpu);
 
+	if (atomic_read(&rcu_pending))
+		goto rcu_process;
+rcu_process_back:
+
 	/*
 	 * 'sched_data' is protected by the fact that we can run
 	 * only one process per CPU.
@@ -693,6 +701,19 @@
 	c = goodness(prev, this_cpu, prev->active_mm);
 	next = prev;
 	goto still_running_back;
+
+rcu_process:
+	/* Avoid cache line effects if value hasn't changed */
+	c = ring_count((this_cpu + 1) % smp_num_cpus) + 1;
+	if (c != ring_count(this_cpu)) {
+		/* Do subtraction to avoid int wrap corner case */
+		if (c - finished_count(this_cpu) >= 0) {
+			rcu_batch_done();
+			finished_count(this_cpu) = c + smp_num_cpus;
+		}
+		ring_count(this_cpu) = c;
+	}
+	goto rcu_process_back;
 
 move_rr_last:
 	if (!prev->counter) {
