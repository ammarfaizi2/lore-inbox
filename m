Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264139AbTDOWjY (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 18:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264140AbTDOWjY 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 18:39:24 -0400
Received: from holomorphy.com ([66.224.33.161]:904 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264139AbTDOWjH 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 18:39:07 -0400
Date: Tue, 15 Apr 2003 15:50:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [cpumask_t 1/3] core changes for 2.5.67-bk6
Message-ID: <20030415225036.GE12487@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Core changes for extended cpu masks. Basically use a machine word
#if NR_CPUS < BITS_PER_LONG, otherwise, use a structure with an array
of unsigned longs for it. Sprinkle it around the scheduler and a few
other odd places that play with the cpu bitmasks. Back-ended by a
bitmap ADT capable of dealing with arbitrary-width bitmaps, with the
obvious micro-optimizations for NR_CPUS < BITS_PER_LONG and UP.

NR_CPUS % BITS_PER_LONG != 0 is invalid while NR_CPUS > BITS_PER_LONG.

cpus_weight(), cpus_shift_left(), cpus_shift_right(), and
cpus_complement() are from Martin Hicks.


diff -urpN linux-2.5.67-bk6/drivers/base/node.c cpu-2.5.67-bk6-1/drivers/base/node.c
--- linux-2.5.67-bk6/drivers/base/node.c	2003-04-07 10:30:43.000000000 -0700
+++ cpu-2.5.67-bk6-1/drivers/base/node.c	2003-04-15 14:39:40.000000000 -0700
@@ -7,7 +7,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/node.h>
-
+#include <linux/cpumask.h>
 #include <asm/topology.h>
 
 
@@ -31,7 +31,16 @@ struct device_driver node_driver = {
 static ssize_t node_read_cpumap(struct device * dev, char * buf)
 {
 	struct node *node_dev = to_node(to_root(dev));
-        return sprintf(buf,"%lx\n",node_dev->cpumap);
+	cpumask_t tmp = node_dev->cpumap;
+	int k, len = 0;
+
+	for (k = 0; k < CPU_ARRAY_SIZE; ++k) {
+        	int j = sprintf(buf,"%lx\n", cpus_coerce(tmp));
+		len += j;
+		buf += j;
+		cpus_shift_right(tmp, tmp, BITS_PER_LONG);
+	}
+	return len;
 }
 static DEVICE_ATTR(cpumap,S_IRUGO,node_read_cpumap,NULL);
 
diff -urpN linux-2.5.67-bk6/include/linux/bitmap.h cpu-2.5.67-bk6-1/include/linux/bitmap.h
--- linux-2.5.67-bk6/include/linux/bitmap.h	1969-12-31 16:00:00.000000000 -0800
+++ cpu-2.5.67-bk6-1/include/linux/bitmap.h	2003-04-15 14:39:40.000000000 -0700
@@ -0,0 +1,131 @@
+#ifndef __LINUX_BITMAP_H
+#define __LINUX_BITMAP_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/config.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/string.h>
+
+static inline int bitmap_empty(volatile unsigned long *bitmap, int bits)
+{
+	int k;
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
+		if (bitmap[k])
+			return 0;
+
+	return 1;
+}
+
+static inline int bitmap_full(volatile unsigned long *bitmap, int bits)
+{
+	int k;
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
+		if (~bitmap[k])
+			return 0;
+
+	return 1;
+}
+
+static inline int bitmap_equal(volatile unsigned long *bitmap1, volatile unsigned long *bitmap2, int bits)
+{
+	int k;
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
+		if (bitmap1[k] != bitmap2[k])
+			return 0;
+
+	return 1;
+}
+
+static inline void bitmap_complement(volatile unsigned long *bitmap, int bits)
+{
+	int k;
+
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
+		bitmap[k] = ~bitmap[k];
+}
+
+static inline void bitmap_clear(volatile unsigned long *bitmap, int bits)
+{
+	CLEAR_BITMAP((unsigned long *)bitmap, bits);
+}
+
+static inline void bitmap_fill(volatile unsigned long *bitmap, int bits)
+{
+	memset((unsigned long *)bitmap, 0xff, BITS_TO_LONGS(bits)*sizeof(unsigned long));
+}
+
+static inline void bitmap_copy(volatile unsigned long *dst, volatile unsigned long *src, int bits)
+{
+	memcpy((unsigned long *)dst, (unsigned long *)src, BITS_TO_LONGS(bits)*sizeof(unsigned long));
+}
+
+static inline void bitmap_shift_left(volatile unsigned long *,volatile unsigned long *,int,int);
+static inline void bitmap_shift_right(volatile unsigned long *dst, volatile unsigned long *src, int shift, int bits)
+{
+	int k;
+	DECLARE_BITMAP(__shr_tmp, bits);
+
+	bitmap_clear(__shr_tmp, bits);
+	for (k = 0; k < bits - shift; ++k)
+		if (test_bit(k + shift, src))
+			set_bit(k, __shr_tmp);
+	bitmap_copy(dst, __shr_tmp, bits);
+}
+
+static inline void bitmap_shift_left(volatile unsigned long *dst, volatile unsigned long *src, int shift, int bits)
+{
+	int k;
+	DECLARE_BITMAP(__shl_tmp, bits);
+
+	bitmap_clear(__shl_tmp, bits);
+	for (k = bits; k >= shift; --k)
+		if (test_bit(k - shift, src))
+			set_bit(k, __shl_tmp);
+	bitmap_copy(dst, __shl_tmp, bits);
+}
+
+static inline void bitmap_and(volatile unsigned long *dst, volatile unsigned long *bitmap1, volatile unsigned long *bitmap2, int bits)
+{
+	int k;
+
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
+		dst[k] = bitmap1[k] & bitmap2[k];
+}
+
+static inline void bitmap_or(volatile unsigned long *dst, volatile unsigned long *bitmap1, volatile unsigned long *bitmap2, int bits)
+{
+	int k;
+
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
+		dst[k] = bitmap1[k] | bitmap2[k];
+}
+
+#if BITS_PER_LONG == 32
+static inline int bitmap_weight(volatile unsigned long *bitmap, int bits)
+{
+	int k, w = 0;
+
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
+		w += hweight32(bitmap[k]);
+
+	return w;
+}
+#elif BITS_PER_LONG == 64
+static inline int bitmap_weight(volatile unsigned long *bitmap, int bits)
+{
+	int k, w = 0;
+
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
+		w += hweight64(bitmap[k]);
+
+	return w;
+}
+#endif
+
+#endif
+
+#endif /* __LINUX_BITMAP_H */
diff -urpN linux-2.5.67-bk6/include/linux/cpumask.h cpu-2.5.67-bk6-1/include/linux/cpumask.h
--- linux-2.5.67-bk6/include/linux/cpumask.h	1969-12-31 16:00:00.000000000 -0800
+++ cpu-2.5.67-bk6-1/include/linux/cpumask.h	2003-04-15 14:39:40.000000000 -0700
@@ -0,0 +1,112 @@
+#ifndef __LINUX_CPUMASK_H
+#define __LINUX_CPUMASK_H
+
+#define CPU_ARRAY_SIZE		BITS_TO_LONGS(NR_CPUS)
+
+#if NR_CPUS > BITS_PER_LONG
+
+#include <linux/bitmap.h>
+
+struct cpumask
+{
+	unsigned long mask[CPU_ARRAY_SIZE];
+};
+
+typedef struct cpumask cpumask_t;
+
+#define cpu_set(cpu, map)		set_bit(cpu, (map).mask)
+#define cpu_clear(cpu, map)		clear_bit(cpu, (map).mask)
+#define cpu_isset(cpu, map)		test_bit(cpu, (map).mask)
+#define cpu_test_and_set(cpu, map)	test_and_set_bit(cpu, (map).mask)
+
+#define cpus_and(dst,src1,src2)	bitmap_and((dst).mask,(src1).mask, (src2).mask, NR_CPUS)
+#define cpus_or(dst,src1,src2)	bitmap_or((dst).mask, (src1).mask, (src2).mask, NR_CPUS)
+#define cpus_clear(map)		bitmap_clear((map).mask, NR_CPUS)
+#define cpus_complement(map)	bitmap_complement((map).mask, NR_CPUS)
+#define cpus_equal(map1, map2)	bitmap_equal((map1).mask, (map2).mask, NR_CPUS)
+#define cpus_empty(map)		bitmap_empty(map.mask, NR_CPUS)
+#define cpus_weight(map)		bitmap_weight((map).mask, NR_CPUS)
+#define cpus_shift_right(d, s, n)	bitmap_shift_right((d).mask, (s).mask, n, NR_CPUS)
+#define cpus_shift_left(d, s, n)	bitmap_shift_left((d).mask, (s).mask, n, NR_CPUS)
+#define first_cpu(map)		find_first_bit((map).mask, NR_CPUS)
+#define next_cpu(cpu, map)	find_next_bit((map).mask, NR_CPUS, cpu)
+
+/* only ever use this for things that are _never_ used on large boxen */
+#define cpus_coerce(map)	((map).mask[0])
+#define any_online_cpu(map)	find_first_bit((map).mask, NR_CPUS)
+
+/*
+ * um, these need to be usable as static initializers
+ */
+#define CPU_MASK_ALL	{ {[0 ... CPU_ARRAY_SIZE-1] = ~0UL} }
+#define CPU_MASK_NONE	{ {[0 ... CPU_ARRAY_SIZE-1] =  0UL} }
+
+#else /* NR_CPUS <= BITS_PER_LONG */
+
+typedef unsigned long cpumask_t;
+
+#define cpu_set(cpu, map)		do { map |= 1UL << (cpu); } while (0)
+#define cpu_clear(cpu, map)		do { map &= ~(1UL << (cpu)); } while (0)
+#define cpu_isset(cpu, map)		((map) & (1UL << (cpu)))
+#define cpu_test_and_set(cpu, map)	test_and_set_bit(cpu, &(map))
+
+#define cpus_and(dst,src1,src2)		do { dst = (src1) & (src2); } while (0)
+#define cpus_or(dst,src1,src2)		do { dst = (src1) | (src2); } while (0)
+#define cpus_clear(map)			do { map = 0UL; } while (0)
+#define cpus_complement(map)		do { map = ~(map); } while (0)
+#define cpus_equal(map1, map2)		((map1) == (map2))
+#define cpus_empty(map)			((map) != 0UL)
+
+#if BITS_PER_LONG == 32
+#define cpus_weight(map)		hweight32(map)
+#elif BITS_PER_LONG == 64
+#define cpus_weight(map)		hweight64(map)
+#endif
+
+#define cpus_shift_right(dst, src, n)	do { dst = (src) >> (n); } while (0)
+#define cpus_shift_left(dst, src, n)	do { dst = (src) >> (n); } while (0)
+
+#define any_online_cpu(map)		((map) != 0UL)
+
+#ifdef CONFIG_SMP
+#define first_cpu(map)			__ffs(map)
+#define next_cpu(cpu, map)		__ffs((map) & ~((1UL << (cpu)) - 1))
+#define CPU_MASK_ALL	~0UL
+#define CPU_MASK_NONE	0UL
+#else /* UP */
+#define first_cpu(map)			0
+#define next_cpu(cpu, map)		1
+#define CPU_MASK_ALL	1UL
+#define CPU_MASK_NONE	0UL
+#endif
+
+/* only ever use this for things that are _never_ used on large boxen */
+#define cpus_coerce(map)		(map)
+
+#endif /* NR_CPUS <= BITS_PER_LONG */
+
+#ifdef CONFIG_SMP
+extern cpumask_t cpu_online_map;
+
+#define num_online_cpus()		cpus_weight(cpu_online_map)
+#define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
+#else
+#define	cpu_online_map			0x1UL
+#define num_online_cpus()		1
+#define cpu_online(cpu)			({ BUG_ON((cpu) != 0); 1; })
+#endif
+
+static inline int next_online_cpu(int cpu, cpumask_t map)
+{
+	do
+		cpu = next_cpu(cpu, map);
+	while (cpu < NR_CPUS && !cpu_online(cpu));
+	return cpu;
+}
+
+#define for_each_cpu(cpu, map)						\
+	for (cpu = first_cpu(map); cpu < NR_CPUS; cpu = next_cpu(cpu,map))
+#define for_each_online_cpu(cpu, map)					\
+	for (cpu = first_cpu(map); cpu < NR_CPUS; cpu = next_online_cpu(cpu,map))
+
+#endif /* __LINUX_CPUMASK_H */
diff -urpN linux-2.5.67-bk6/include/linux/init_task.h cpu-2.5.67-bk6-1/include/linux/init_task.h
--- linux-2.5.67-bk6/include/linux/init_task.h	2003-04-15 14:38:03.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/linux/init_task.h	2003-04-15 14:39:40.000000000 -0700
@@ -68,7 +68,7 @@
 	.prio		= MAX_PRIO-20,					\
 	.static_prio	= MAX_PRIO-20,					\
 	.policy		= SCHED_NORMAL,					\
-	.cpus_allowed	= ~0UL,						\
+	.cpus_allowed	= CPU_MASK_ALL,					\
 	.mm		= NULL,						\
 	.active_mm	= &init_mm,					\
 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
diff -urpN linux-2.5.67-bk6/include/linux/irq.h cpu-2.5.67-bk6-1/include/linux/irq.h
--- linux-2.5.67-bk6/include/linux/irq.h	2003-04-07 10:31:07.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/linux/irq.h	2003-04-15 14:39:40.000000000 -0700
@@ -44,7 +44,7 @@ struct hw_interrupt_type {
 	void (*disable)(unsigned int irq);
 	void (*ack)(unsigned int irq);
 	void (*end)(unsigned int irq);
-	void (*set_affinity)(unsigned int irq, unsigned long mask);
+	void (*set_affinity)(unsigned int irq, unsigned long dest);
 };
 
 typedef struct hw_interrupt_type  hw_irq_controller;
diff -urpN linux-2.5.67-bk6/include/linux/node.h cpu-2.5.67-bk6-1/include/linux/node.h
--- linux-2.5.67-bk6/include/linux/node.h	2003-04-07 10:32:51.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/linux/node.h	2003-04-15 14:39:40.000000000 -0700
@@ -20,9 +20,10 @@
 #define _LINUX_NODE_H_
 
 #include <linux/device.h>
+#include <linux/cpumask.h>
 
 struct node {
-	unsigned long cpumap;	/* Bitmap of CPUs on the Node */
+	cpumask_t cpumap;	/* Bitmap of CPUs on the Node */
 	struct sys_root sysroot;
 };
 
diff -urpN linux-2.5.67-bk6/include/linux/rcupdate.h cpu-2.5.67-bk6-1/include/linux/rcupdate.h
--- linux-2.5.67-bk6/include/linux/rcupdate.h	2003-04-07 10:30:58.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/linux/rcupdate.h	2003-04-15 14:39:40.000000000 -0700
@@ -40,6 +40,7 @@
 #include <linux/spinlock.h>
 #include <linux/threads.h>
 #include <linux/percpu.h>
+#include <linux/cpumask.h>
 
 /**
  * struct rcu_head - callback structure for use with RCU
@@ -67,7 +68,7 @@ struct rcu_ctrlblk {
 	spinlock_t	mutex;		/* Guard this struct                  */
 	long		curbatch;	/* Current batch number.	      */
 	long		maxbatch;	/* Max requested batch number.        */
-	unsigned long	rcu_cpu_mask; 	/* CPUs that need to switch in order  */
+	cpumask_t	rcu_cpu_mask; 	/* CPUs that need to switch in order  */
 					/* for current batch to proceed.      */
 };
 
@@ -114,7 +115,7 @@ static inline int rcu_pending(int cpu) 
 	     rcu_batch_before(RCU_batch(cpu), rcu_ctrlblk.curbatch)) ||
 	    (list_empty(&RCU_curlist(cpu)) &&
 			 !list_empty(&RCU_nxtlist(cpu))) ||
-	    test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask))
+	    cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask))
 		return 1;
 	else
 		return 0;
diff -urpN linux-2.5.67-bk6/include/linux/sched.h cpu-2.5.67-bk6-1/include/linux/sched.h
--- linux-2.5.67-bk6/include/linux/sched.h	2003-04-15 14:38:03.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/linux/sched.h	2003-04-15 14:39:41.000000000 -0700
@@ -12,6 +12,7 @@
 #include <linux/jiffies.h>
 #include <linux/rbtree.h>
 #include <linux/thread_info.h>
+#include <linux/cpumask.h>
 
 #include <asm/system.h>
 #include <asm/semaphore.h>
@@ -197,7 +198,7 @@ struct mm_struct {
 	unsigned long arg_start, arg_end, env_start, env_end;
 	unsigned long rss, total_vm, locked_vm;
 	unsigned long def_flags;
-	unsigned long cpu_vm_mask;
+	cpumask_t cpu_vm_mask;
 	unsigned long swap_address;
 
 	unsigned dumpable:1;
@@ -331,7 +332,7 @@ struct task_struct {
 	unsigned long last_run;
 
 	unsigned long policy;
-	unsigned long cpus_allowed;
+	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
 
 	struct list_head tasks;
@@ -467,7 +468,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_KSWAPD	0x00040000	/* I am kswapd */
 
 #if CONFIG_SMP
-extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
+extern void set_cpus_allowed(task_t *p, cpumask_t new_mask);
 #else
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
diff -urpN linux-2.5.67-bk6/include/linux/smp.h cpu-2.5.67-bk6-1/include/linux/smp.h
--- linux-2.5.67-bk6/include/linux/smp.h	2003-04-07 10:31:44.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/linux/smp.h	2003-04-15 14:39:41.000000000 -0700
@@ -115,9 +115,6 @@ void smp_prepare_boot_cpu(void);
 #define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
-#define cpu_online_map				1
-#define cpu_online(cpu)				({ BUG_ON((cpu) != 0); 1; })
-#define num_online_cpus()			1
 #define num_booting_cpus()			1
 #define cpu_possible(cpu)			({ BUG_ON((cpu) != 0); 1; })
 #define smp_prepare_boot_cpu()			do {} while (0)
diff -urpN linux-2.5.67-bk6/kernel/fork.c cpu-2.5.67-bk6-1/kernel/fork.c
--- linux-2.5.67-bk6/kernel/fork.c	2003-04-15 14:38:03.000000000 -0700
+++ cpu-2.5.67-bk6-1/kernel/fork.c	2003-04-15 14:39:41.000000000 -0700
@@ -257,7 +257,7 @@ static inline int dup_mmap(struct mm_str
 	mm->free_area_cache = TASK_UNMAPPED_BASE;
 	mm->map_count = 0;
 	mm->rss = 0;
-	mm->cpu_vm_mask = 0;
+	cpus_clear(mm->cpu_vm_mask);
 	pprev = &mm->mmap;
 
 	/*
diff -urpN linux-2.5.67-bk6/kernel/module.c cpu-2.5.67-bk6-1/kernel/module.c
--- linux-2.5.67-bk6/kernel/module.c	2003-04-15 14:38:03.000000000 -0700
+++ cpu-2.5.67-bk6-1/kernel/module.c	2003-04-15 14:39:41.000000000 -0700
@@ -300,6 +300,7 @@ static int stopref(void *cpu)
 {
 	int irqs_disabled = 0;
 	int prepared = 0;
+	cpumask_t allowed_mask = CPU_MASK_NONE;
 
 	sprintf(current->comm, "kmodule%lu\n", (unsigned long)cpu);
 
@@ -308,7 +309,8 @@ static int stopref(void *cpu)
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
 	setscheduler(current->pid, SCHED_FIFO, &param);
 #endif
-	set_cpus_allowed(current, 1UL << (unsigned long)cpu);
+	cpu_set((int)cpu, allowed_mask);
+	set_cpus_allowed(current, allowed_mask);
 
 	/* Ack: we are alive */
 	atomic_inc(&stopref_thread_ack);
@@ -361,7 +363,7 @@ static void stopref_set_state(enum stopr
 static int stop_refcounts(void)
 {
 	unsigned int i, cpu;
-	unsigned long old_allowed;
+	cpumask_t old_allowed, allowed_mask = CPU_MASK_NONE;
 	int ret = 0;
 
 	/* One thread per cpu.  We'll do our own. */
@@ -369,7 +371,8 @@ static int stop_refcounts(void)
 
 	/* FIXME: racy with set_cpus_allowed. */
 	old_allowed = current->cpus_allowed;
-	set_cpus_allowed(current, 1UL << (unsigned long)cpu);
+	cpu_set(cpu, allowed_mask);
+	set_cpus_allowed(current, allowed_mask);
 
 	atomic_set(&stopref_thread_ack, 0);
 	stopref_num_threads = 0;
diff -urpN linux-2.5.67-bk6/kernel/rcupdate.c cpu-2.5.67-bk6-1/kernel/rcupdate.c
--- linux-2.5.67-bk6/kernel/rcupdate.c	2003-04-07 10:30:34.000000000 -0700
+++ cpu-2.5.67-bk6-1/kernel/rcupdate.c	2003-04-15 14:39:41.000000000 -0700
@@ -47,7 +47,7 @@
 /* Definition for rcupdate control block. */
 struct rcu_ctrlblk rcu_ctrlblk = 
 	{ .mutex = SPIN_LOCK_UNLOCKED, .curbatch = 1, 
-	  .maxbatch = 1, .rcu_cpu_mask = 0 };
+	  .maxbatch = 1, .rcu_cpu_mask = CPU_MASK_NONE };
 DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
 
 /* Fake initialization required by compiler */
@@ -106,7 +106,7 @@ static void rcu_start_batch(long newbatc
 		rcu_ctrlblk.maxbatch = newbatch;
 	}
 	if (rcu_batch_before(rcu_ctrlblk.maxbatch, rcu_ctrlblk.curbatch) ||
-	    (rcu_ctrlblk.rcu_cpu_mask != 0)) {
+	    !cpus_empty(rcu_ctrlblk.rcu_cpu_mask)) {
 		return;
 	}
 	rcu_ctrlblk.rcu_cpu_mask = cpu_online_map;
@@ -121,7 +121,7 @@ static void rcu_check_quiescent_state(vo
 {
 	int cpu = smp_processor_id();
 
-	if (!test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask)) {
+	if (!cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask)) {
 		return;
 	}
 
@@ -139,13 +139,13 @@ static void rcu_check_quiescent_state(vo
 	}
 
 	spin_lock(&rcu_ctrlblk.mutex);
-	if (!test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask)) {
+	if (!cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask)) {
 		spin_unlock(&rcu_ctrlblk.mutex);
 		return;
 	}
-	clear_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask);
+	cpu_clear(cpu, rcu_ctrlblk.rcu_cpu_mask);
 	RCU_last_qsctr(cpu) = RCU_QSCTR_INVALID;
-	if (rcu_ctrlblk.rcu_cpu_mask != 0) {
+	if (!cpus_empty(rcu_ctrlblk.rcu_cpu_mask)) {
 		spin_unlock(&rcu_ctrlblk.mutex);
 		return;
 	}
diff -urpN linux-2.5.67-bk6/kernel/sched.c cpu-2.5.67-bk6-1/kernel/sched.c
--- linux-2.5.67-bk6/kernel/sched.c	2003-04-15 14:38:03.000000000 -0700
+++ cpu-2.5.67-bk6-1/kernel/sched.c	2003-04-15 14:39:41.000000000 -0700
@@ -502,7 +502,7 @@ repeat_lock_task:
 			 */
 			if (unlikely(sync && !task_running(rq, p) &&
 				(task_cpu(p) != smp_processor_id()) &&
-				(p->cpus_allowed & (1UL << smp_processor_id())))) {
+				cpu_isset(smp_processor_id(), p->cpus_allowed))) {
 
 				set_task_cpu(p, smp_processor_id());
 				task_rq_unlock(rq, &flags);
@@ -776,13 +776,14 @@ static inline void double_rq_unlock(runq
  */
 static void sched_migrate_task(task_t *p, int dest_cpu)
 {
-	unsigned long old_mask;
+	cpumask_t old_mask, new_mask = CPU_MASK_NONE;
 
 	old_mask = p->cpus_allowed;
-	if (!(old_mask & (1UL << dest_cpu)))
+	if (!cpu_isset(dest_cpu, old_mask))
 		return;
 	/* force the process onto the specified CPU */
-	set_cpus_allowed(p, 1UL << dest_cpu);
+	cpu_set(dest_cpu, new_mask);
+	set_cpus_allowed(p, new_mask);
 
 	/* restore the cpus allowed mask */
 	set_cpus_allowed(p, old_mask);
@@ -795,7 +796,7 @@ static void sched_migrate_task(task_t *p
 static int sched_best_cpu(struct task_struct *p)
 {
 	int i, minload, load, best_cpu, node = 0;
-	unsigned long cpumask;
+	cpumask_t cpumask;
 
 	best_cpu = task_cpu(p);
 	if (cpu_rq(best_cpu)->nr_running <= 2)
@@ -813,7 +814,7 @@ static int sched_best_cpu(struct task_st
 	minload = 10000000;
 	cpumask = node_to_cpumask(node);
 	for (i = 0; i < NR_CPUS; ++i) {
-		if (!(cpumask & (1UL << i)))
+		if (!cpu_isset(i, cpumask))
 			continue;
 		if (cpu_rq(i)->nr_running < minload) {
 			best_cpu = i;
@@ -893,7 +894,7 @@ static inline unsigned int double_lock_b
 /*
  * find_busiest_queue - find the busiest runqueue among the cpus in cpumask.
  */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance, unsigned long cpumask)
+static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance, cpumask_t cpumask)
 {
 	int nr_running, load, max_load, i;
 	runqueue_t *busiest, *rq_src;
@@ -928,7 +929,7 @@ static inline runqueue_t *find_busiest_q
 	busiest = NULL;
 	max_load = 1;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!((1UL << i) & cpumask))
+		if (!cpu_isset(i, cpumask))
 			continue;
 
 		rq_src = cpu_rq(i);
@@ -1000,7 +1001,7 @@ static inline void pull_task(runqueue_t 
  * We call this with the current runqueue locked,
  * irqs disabled.
  */
-static void load_balance(runqueue_t *this_rq, int idle, unsigned long cpumask)
+static void load_balance(runqueue_t *this_rq, int idle, cpumask_t cpumask)
 {
 	int imbalance, idx, this_cpu = smp_processor_id();
 	runqueue_t *busiest;
@@ -1054,7 +1055,7 @@ skip_queue:
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
 	((jiffies - (p)->last_run > cache_decay_ticks) &&	\
 		!task_running(rq, p) &&					\
-			((p)->cpus_allowed & (1UL << (this_cpu))))
+			(cpu_isset(this_cpu, (p)->cpus_allowed)))
 
 	curr = curr->prev;
 
@@ -1097,10 +1098,10 @@ out:
 static void balance_node(runqueue_t *this_rq, int idle, int this_cpu)
 {
 	int node = find_busiest_node(cpu_to_node(this_cpu));
-	unsigned long cpumask, this_cpumask = 1UL << this_cpu;
 
 	if (node >= 0) {
-		cpumask = node_to_cpumask(node) | this_cpumask;
+		cpumask_t cpumask = node_to_cpumask(node);
+		cpu_set(this_cpu, cpumask);
 		spin_lock(&this_rq->lock);
 		load_balance(this_rq, idle, cpumask);
 		spin_unlock(&this_rq->lock);
@@ -1891,7 +1892,7 @@ out_unlock:
 asmlinkage long sys_sched_setaffinity(pid_t pid, unsigned int len,
 				      unsigned long __user *user_mask_ptr)
 {
-	unsigned long new_mask;
+	cpumask_t new_mask;
 	int retval;
 	task_t *p;
 
@@ -1901,8 +1902,8 @@ asmlinkage long sys_sched_setaffinity(pi
 	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
 		return -EFAULT;
 
-	new_mask &= cpu_online_map;
-	if (!new_mask)
+	cpus_and(new_mask, new_mask, cpu_online_map);
+	if (cpus_empty(new_mask))
 		return -EINVAL;
 
 	read_lock(&tasklist_lock);
@@ -1944,7 +1945,7 @@ asmlinkage long sys_sched_getaffinity(pi
 				      unsigned long __user *user_mask_ptr)
 {
 	unsigned int real_len;
-	unsigned long mask;
+	cpumask_t mask;
 	int retval;
 	task_t *p;
 
@@ -1960,7 +1961,7 @@ asmlinkage long sys_sched_getaffinity(pi
 		goto out_unlock;
 
 	retval = 0;
-	mask = p->cpus_allowed & cpu_online_map;
+	cpus_and(mask, p->cpus_allowed, cpu_online_map);
 
 out_unlock:
 	read_unlock(&tasklist_lock);
@@ -2293,16 +2294,15 @@ typedef struct {
  * task must not exit() & deallocate itself prematurely.  The
  * call is not atomic; no spinlocks may be held.
  */
-void set_cpus_allowed(task_t *p, unsigned long new_mask)
+void set_cpus_allowed(task_t *p, cpumask_t new_mask)
 {
 	unsigned long flags;
 	migration_req_t req;
 	runqueue_t *rq;
 
 #if 0 /* FIXME: Grab cpu_lock, return error on this case. --RR */
-	new_mask &= cpu_online_map;
-	if (!new_mask)
-		BUG();
+	cpus_and(new_mask, new_mask, cpu_online_map);
+	BUG_ON(cpus_empty(new_mask));
 #endif
 
 	rq = task_rq_lock(p, &flags);
@@ -2311,7 +2311,7 @@ void set_cpus_allowed(task_t *p, unsigne
 	 * Can the task run on the task's current CPU? If not then
 	 * migrate the thread off to a proper CPU.
 	 */
-	if (new_mask & (1UL << task_cpu(p))) {
+	if (cpu_isset(task_cpu(p), new_mask)) {
 		task_rq_unlock(rq, &flags);
 		return;
 	}
@@ -2320,7 +2320,7 @@ void set_cpus_allowed(task_t *p, unsigne
 	 * it is sufficient to simply update the task's cpu field.
 	 */
 	if (!p->array && !task_running(rq, p)) {
-		set_task_cpu(p, __ffs(p->cpus_allowed));
+		set_task_cpu(p, first_cpu(p->cpus_allowed));
 		task_rq_unlock(rq, &flags);
 		return;
 	}
@@ -2345,6 +2345,7 @@ static int migration_thread(void * data)
 	int cpu = (long) data;
 	runqueue_t *rq;
 	int ret;
+	cpumask_t allowed_mask = CPU_MASK_NONE;
 
 	daemonize("migration/%d", cpu);
 	set_fs(KERNEL_DS);
@@ -2353,7 +2354,8 @@ static int migration_thread(void * data)
 	 * Either we are running on the right CPU, or there's a
 	 * a migration thread on the target CPU, guaranteed.
 	 */
-	set_cpus_allowed(current, 1UL << cpu);
+	cpu_set(cpu, allowed_mask);
+	set_cpus_allowed(current, allowed_mask);
 
 	ret = setscheduler(0, SCHED_FIFO, &param);
 
@@ -2381,7 +2383,11 @@ static int migration_thread(void * data)
 		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed & cpu_online_map);
+		{
+			cpumask_t tmp;
+			cpus_and(tmp, p->cpus_allowed, cpu_online_map);
+			cpu_dest = first_cpu(tmp);
+		}
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
 		cpu_src = task_cpu(p);
diff -urpN linux-2.5.67-bk6/kernel/softirq.c cpu-2.5.67-bk6-1/kernel/softirq.c
--- linux-2.5.67-bk6/kernel/softirq.c	2003-04-15 14:38:03.000000000 -0700
+++ cpu-2.5.67-bk6-1/kernel/softirq.c	2003-04-15 14:39:41.000000000 -0700
@@ -308,15 +308,16 @@ void __init softirq_init(void)
 static int ksoftirqd(void * __bind_cpu)
 {
 	int cpu = (int) (long) __bind_cpu;
+	cpumask_t allowed_mask = CPU_MASK_NONE;
 
 	daemonize("ksoftirqd/%d", cpu);
 	set_user_nice(current, 19);
 	current->flags |= PF_IOTHREAD;
 
 	/* Migrate to the right CPU */
-	set_cpus_allowed(current, 1UL << cpu);
-	if (smp_processor_id() != cpu)
-		BUG();
+	cpu_set(cpu, allowed_mask);
+	set_cpus_allowed(current, allowed_mask);
+	BUG_ON(smp_processor_id() != cpu);
 
 	__set_current_state(TASK_INTERRUPTIBLE);
 	mb();
diff -urpN linux-2.5.67-bk6/kernel/workqueue.c cpu-2.5.67-bk6-1/kernel/workqueue.c
--- linux-2.5.67-bk6/kernel/workqueue.c	2003-04-15 14:38:03.000000000 -0700
+++ cpu-2.5.67-bk6-1/kernel/workqueue.c	2003-04-15 14:39:41.000000000 -0700
@@ -169,6 +169,7 @@ static int worker_thread(void *__startup
 	int cpu = cwq - cwq->wq->cpu_wq;
 	DECLARE_WAITQUEUE(wait, current);
 	struct k_sigaction sa;
+	cpumask_t allowed_mask = CPU_MASK_NONE;
 
 	daemonize("%s/%d", startup->name, cpu);
 	allow_signal(SIGCHLD);
@@ -176,7 +177,8 @@ static int worker_thread(void *__startup
 	cwq->thread = current;
 
 	set_user_nice(current, -10);
-	set_cpus_allowed(current, 1UL << cpu);
+	cpu_set(cpu, allowed_mask);
+	set_cpus_allowed(current, allowed_mask);
 
 	complete(&startup->done);
 
