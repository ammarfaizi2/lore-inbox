Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbSJDOrY>; Fri, 4 Oct 2002 10:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261890AbSJDOqB>; Fri, 4 Oct 2002 10:46:01 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:25010 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S261846AbSJDOh3> convert rfc822-to-8bit; Fri, 4 Oct 2002 10:37:29 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] 2.5.40 s390 (2/27): include.
Date: Fri, 4 Oct 2002 16:25:19 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210041625.19387.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 include file changes for 2.5.39. 

diff -urN linux-2.5.40/include/asm-s390/hardirq.h linux-2.5.40-s390/include/asm-s390/hardirq.h
--- linux-2.5.40/include/asm-s390/hardirq.h	Tue Oct  1 09:07:50 2002
+++ linux-2.5.40-s390/include/asm-s390/hardirq.h	Fri Oct  4 16:14:42 2002
@@ -14,15 +14,13 @@
 
 #include <linux/config.h>
 #include <linux/threads.h>
-#include <asm/lowcore.h>
 #include <linux/sched.h>
 #include <linux/cache.h>
+#include <asm/lowcore.h>
 
 /* entry.S is sensitive to the offsets of these fields */
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int __local_irq_count;
-	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
 } ____cacheline_aligned irq_cpustat_t;
@@ -30,64 +28,75 @@
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
 /*
- * Are we in an interrupt context? Either doing bottom half
- * or hardware interrupt processing?
+ * We put the hardirq and softirq counter into the preemption
+ * counter. The bitmask has the following meaning:
+ *
+ * - bits 0-7 are the preemption count (max preemption depth: 256)
+ * - bits 8-15 are the softirq count (max # of softirqs: 256)
+ * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
+ *
+ * - ( bit 26 is the PREEMPT_ACTIVE flag. )
+ *
+ * PREEMPT_MASK: 0x000000ff
+ * SOFTIRQ_MASK: 0x0000ff00
+ * HARDIRQ_MASK: 0x00010000
  */
-#define in_interrupt() ({ int __cpu = smp_processor_id(); \
-	(local_irq_count(__cpu) + local_bh_count(__cpu) != 0); })
 
-#define in_irq() (local_irq_count(smp_processor_id()) != 0)
-  
-#ifndef CONFIG_SMP
+#define PREEMPT_BITS	8
+#define SOFTIRQ_BITS	8
+#define HARDIRQ_BITS	1
+
+#define PREEMPT_SHIFT	0
+#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
+#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
+
+#define __MASK(x)	((1UL << (x))-1)
+
+#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
+#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
+#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
+
+#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
+#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
+
+#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
+#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
+#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
+
+/*
+ * Are we doing bottom half or hardware interrupt processing?
+ * Are we in a softirq context? Interrupt context?
+ */
+#define in_irq()		(hardirq_count())
+#define in_softirq()		(softirq_count())
+#define in_interrupt()		(irq_count())
 
-#define hardirq_trylock(cpu)	(local_irq_count(cpu) == 0)
-#define hardirq_endlock(cpu)	do { } while (0)
-  
-#define hardirq_enter(cpu)	(local_irq_count(cpu)++)
-#define hardirq_exit(cpu)	(local_irq_count(cpu)--)
-
-#define synchronize_irq()	do { } while (0)
-
-#else	/* CONFIG_SMP */
-
-#include <asm/atomic.h>
-#include <asm/smp.h>
-
-extern atomic_t global_irq_holder;
-extern atomic_t global_irq_lock;
-extern atomic_t global_irq_count;
-
-static inline void release_irqlock(int cpu)
-{
-	/* if we didn't own the irq lock, just ignore.. */
-	if (atomic_read(&global_irq_holder) ==  cpu) {
-		atomic_set(&global_irq_holder,NO_PROC_ID);
-		atomic_set(&global_irq_lock,0);
-	}
-}
-
-static inline void hardirq_enter(int cpu)
-{
-        ++local_irq_count(cpu);
-	atomic_inc(&global_irq_count);
-}
-
-static inline void hardirq_exit(int cpu)
-{
-	atomic_dec(&global_irq_count);
-        --local_irq_count(cpu);
-}
-
-static inline int hardirq_trylock(int cpu)
-{
-	return !atomic_read(&global_irq_count) &&
-	       !atomic_read(&global_irq_lock);
-}
 
-#define hardirq_endlock(cpu)	do { } while (0)
+#define hardirq_trylock()	(!in_interrupt())
+#define hardirq_endlock()	do { } while (0)
 
-extern void synchronize_irq(void);
+#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
+
+extern void do_call_softirq(void);
+
+#define in_atomic()	(preempt_count() != 0)
+#define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
+
+#define irq_exit()							\
+do {									\
+	preempt_count() -= HARDIRQ_OFFSET;				\
+	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
+		/* Use the async. stack for softirq */			\
+		do_call_softirq();					\
+} while (0)
+
+#ifndef CONFIG_SMP
+# define synchronize_irq(irq)	barrier()
+#else
+  extern void synchronize_irq(unsigned int irq);
+#endif /* CONFIG_SMP */
 
-#endif	/* CONFIG_SMP */
+extern void show_stack(unsigned long * esp);
 
 #endif /* __ASM_HARDIRQ_H */
diff -urN linux-2.5.40/include/asm-s390/irq.h linux-2.5.40-s390/include/asm-s390/irq.h
--- linux-2.5.40/include/asm-s390/irq.h	Tue Oct  1 09:07:35 2002
+++ linux-2.5.40-s390/include/asm-s390/irq.h	Fri Oct  4 16:14:42 2002
@@ -897,67 +897,6 @@
 	return cc;
 }
 
-/*
- * Various low-level irq details needed by irq.c, process.c,
- * time.c, io_apic.c and smp.c
- *
- * Interrupt entry/exit code at both C and assembly level
- */
-
-#ifdef CONFIG_SMP
-
-#include <asm/atomic.h>
-
-static inline void irq_enter(int cpu, unsigned int irq)
-{
-        hardirq_enter(cpu);
-        while (atomic_read(&global_irq_lock) != 0) {
-                eieio();
-        }
-}
-
-static inline void irq_exit(int cpu, unsigned int irq)
-{
-        hardirq_exit(cpu);
-        release_irqlock(cpu);
-}
-
-
-#else
-
-#define irq_enter(cpu, irq)     (++local_irq_count(cpu))
-#define irq_exit(cpu, irq)      (--local_irq_count(cpu))
-
-#endif
-
-#define __STR(x) #x
-#define STR(x) __STR(x)
-
-/*
- * x86 profiling function, SMP safe. We might want to do this in
- * assembly totally?
- * is this ever used anyway?
- */
-extern char _stext;
-static inline void s390_do_profile (unsigned long addr)
-{
-        if (prof_buffer && current->pid) {
-#ifndef CONFIG_ARCH_S390X
-                addr &= 0x7fffffff;
-#endif
-                addr -= (unsigned long) &_stext;
-                addr >>= prof_shift;
-                /*
-                 * Don't ignore out-of-bounds EIP values silently,
-                 * put them into the last histogram slot, so if
-                 * present, they will show up as a sharp peak.
-                 */
-                if (addr > prof_len-1)
-                        addr = prof_len-1;
-                atomic_inc((atomic_t *)&prof_buffer[addr]);
-        }
-}
-
 #include <asm/s390io.h>
 
 #define get_irq_lock(irq) &ioinfo[irq]->irq_lock
diff -urN linux-2.5.40/include/asm-s390/kmap_types.h linux-2.5.40-s390/include/asm-s390/kmap_types.h
--- linux-2.5.40/include/asm-s390/kmap_types.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.40-s390/include/asm-s390/kmap_types.h	Fri Oct  4 16:14:42 2002
@@ -0,0 +1,21 @@
+#ifdef __KERNEL__
+#ifndef _ASM_KMAP_TYPES_H
+#define _ASM_KMAP_TYPES_H
+
+enum km_type {
+	KM_BOUNCE_READ,
+	KM_SKB_SUNRPC_DATA,
+	KM_SKB_DATA_SOFTIRQ,
+	KM_USER0,
+	KM_USER1,
+	KM_BIO_SRC_IRQ,
+	KM_BIO_DST_IRQ,
+	KM_PTE0,
+	KM_PTE1,
+	KM_IRQ0,
+	KM_IRQ1,
+	KM_TYPE_NR
+};
+
+#endif
+#endif /* __KERNEL__ */
diff -urN linux-2.5.40/include/asm-s390/param.h linux-2.5.40-s390/include/asm-s390/param.h
--- linux-2.5.40/include/asm-s390/param.h	Tue Oct  1 09:06:17 2002
+++ linux-2.5.40-s390/include/asm-s390/param.h	Fri Oct  4 16:14:42 2002
@@ -9,6 +9,12 @@
 #ifndef _ASMS390_PARAM_H
 #define _ASMS390_PARAM_H
 
+#ifdef __KERNEL__
+# define HZ		100		/* Internal kernel timer frequency */
+# define USER_HZ	100		/* .. some user interfaces are in "ticks" */
+# define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
+#endif
+
 #ifndef HZ
 #define HZ 100
 #endif
@@ -25,8 +31,4 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
-#ifdef __KERNEL__
-# define CLOCKS_PER_SEC		HZ	/* frequency at which times() counts */
-#endif
-
 #endif
diff -urN linux-2.5.40/include/asm-s390/pgalloc.h linux-2.5.40-s390/include/asm-s390/pgalloc.h
--- linux-2.5.40/include/asm-s390/pgalloc.h	Tue Oct  1 09:07:07 2002
+++ linux-2.5.40-s390/include/asm-s390/pgalloc.h	Fri Oct  4 16:14:42 2002
@@ -16,6 +16,8 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <linux/threads.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
 
 #define check_pgt_cache()	do {} while (0)
 
diff -urN linux-2.5.40/include/asm-s390/pgtable.h linux-2.5.40-s390/include/asm-s390/pgtable.h
--- linux-2.5.40/include/asm-s390/pgtable.h	Tue Oct  1 09:07:34 2002
+++ linux-2.5.40-s390/include/asm-s390/pgtable.h	Fri Oct  4 16:14:42 2002
@@ -176,6 +176,8 @@
 #define _SEGMENT_TABLE  (_USER_SEG_TABLE_LEN|0x80000000|0x100)
 #define _KERNSEG_TABLE  (_KERNEL_SEG_TABLE_LEN)
 
+#define USER_STD_MASK           0x00000080UL
+
 /*
  * No mapping available
  */
diff -urN linux-2.5.40/include/asm-s390/rwsem.h linux-2.5.40-s390/include/asm-s390/rwsem.h
--- linux-2.5.40/include/asm-s390/rwsem.h	Tue Oct  1 09:06:59 2002
+++ linux-2.5.40-s390/include/asm-s390/rwsem.h	Fri Oct  4 16:14:42 2002
@@ -48,9 +48,11 @@
 
 struct rwsem_waiter;
 
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *);
+extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *);
 extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *);
+extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *);
+extern struct rw_semaphore *rwsem_downgrade_write(struct rw_semaphore *);
 
 /*
  * the semaphore definition
@@ -105,6 +107,27 @@
 }
 
 /*
+ * trylock for reading -- returns 1 if successful, 0 if contention
+ */
+static inline int __down_read_trylock(struct rw_semaphore *sem)
+{
+	signed long old, new;
+
+	__asm__ __volatile__(
+		"   l    %0,0(%2)\n"
+		"0: ltr  %1,%0\n"
+		"   jm   1f\n"
+		"   ahi  %1,%3\n"
+		"   cs   %0,%1,0(%2)\n"
+		"   jl   0b\n"
+		"1:"
+                : "=&d" (old), "=&d" (new)
+		: "a" (&sem->count), "i" (RWSEM_ACTIVE_READ_BIAS)
+		: "cc", "memory" );
+	return old >= 0 ? 1 : 0;
+}
+
+/*
  * lock for writing
  */
 static inline void __down_write(struct rw_semaphore *sem)
@@ -126,6 +149,26 @@
 }
 
 /*
+ * trylock for writing -- returns 1 if successful, 0 if contention
+ */
+static inline int __down_write_trylock(struct rw_semaphore *sem)
+{
+	signed long old;
+
+	__asm__ __volatile__(
+		"   l    %0,0(%1)\n"
+		"0: ltr  %0,%0\n"
+		"   jnz  1f\n"
+		"   cs   %0,%2,0(%1)\n"
+		"   jl   0b\n"
+		"1:"
+                : "=&d" (old)
+		: "a" (&sem->count), "d" (RWSEM_ACTIVE_WRITE_BIAS)
+		: "cc", "memory" );
+	return (old == RWSEM_UNLOCKED_VALUE) ? 1 : 0;
+}
+
+/*
  * unlock after reading
  */
 static inline void __up_read(struct rw_semaphore *sem)
@@ -169,6 +212,27 @@
 }
 
 /*
+ * downgrade write lock to read lock
+ */
+static inline void __downgrade_write(struct rw_semaphore *sem)
+{
+	signed long old, new, tmp;
+
+	tmp = -RWSEM_WAITING_BIAS;
+	__asm__ __volatile__(
+		"   l    %0,0(%2)\n"
+		"0: lr   %1,%0\n"
+		"   a    %1,%3\n"
+		"   cs   %0,%1,0(%2)\n"
+		"   jl   0b"
+                : "=&d" (old), "=&d" (new)
+		: "a" (&sem->count), "m" (tmp)
+		: "cc", "memory" );
+	if (new > 1) // FIXME: is this correct ?!?
+		rwsem_downgrade_wake(sem);
+}
+
+/*
  * implement atomic add functionality
  */
 static inline void rwsem_atomic_add(long delta, struct rw_semaphore *sem)
diff -urN linux-2.5.40/include/asm-s390/smp.h linux-2.5.40-s390/include/asm-s390/smp.h
--- linux-2.5.40/include/asm-s390/smp.h	Tue Oct  1 09:07:00 2002
+++ linux-2.5.40-s390/include/asm-s390/smp.h	Fri Oct  4 16:14:42 2002
@@ -11,7 +11,7 @@
 
 #include <linux/config.h>
 #include <linux/threads.h>
-#include <linux/ptrace.h>
+#include <linux/bitops.h>
 
 #if defined(__KERNEL__) && defined(CONFIG_SMP) && !defined(__ASSEMBLY__)
 
@@ -29,6 +29,7 @@
 } sigp_info;
 
 extern volatile unsigned long cpu_online_map;
+extern unsigned long cpu_possible_map;
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 
@@ -46,14 +47,20 @@
 
 #define smp_processor_id() (current_thread_info()->cpu)
 
-extern __inline__ int cpu_logical_map(int cpu)
+#define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
+#define cpu_possible(cpu) (cpu_possible_map & (1<<(cpu)))
+
+extern inline unsigned int num_online_cpus(void)
 {
-        return cpu;
+	return hweight32(cpu_online_map);
 }
 
-extern __inline__ int cpu_number_map(int cpu)
+extern inline int any_online_cpu(unsigned int mask)
 {
-        return cpu;
+	if (mask & cpu_online_map)
+		return __ffs(mask & cpu_online_map);
+
+	return -1;
 }
 
 extern __inline__ __u16 hard_smp_processor_id(void)
diff -urN linux-2.5.40/include/asm-s390/softirq.h linux-2.5.40-s390/include/asm-s390/softirq.h
--- linux-2.5.40/include/asm-s390/softirq.h	Tue Oct  1 09:06:23 2002
+++ linux-2.5.40-s390/include/asm-s390/softirq.h	Fri Oct  4 16:14:42 2002
@@ -9,34 +9,25 @@
 #ifndef __ASM_SOFTIRQ_H
 #define __ASM_SOFTIRQ_H
 
-#ifndef __LINUX_SMP_H
 #include <linux/smp.h>
-#endif
 
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 #include <asm/lowcore.h>
 
-#define __cpu_bh_enable(cpu) \
-                do { barrier(); local_bh_count(cpu)--; } while (0)
-#define cpu_bh_disable(cpu) \
-                do { local_bh_count(cpu)++; barrier(); } while (0)
-
-#define local_bh_disable()      cpu_bh_disable(smp_processor_id())
-#define __local_bh_enable()     __cpu_bh_enable(smp_processor_id())
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
+#define local_bh_disable() \
+		do { preempt_count() += SOFTIRQ_OFFSET; barrier(); } while (0)
+#define __local_bh_enable() \
+		do { barrier(); preempt_count() -= SOFTIRQ_OFFSET; } while (0)
 
 extern void do_call_softirq(void);
 
-#define local_bh_enable()			          	        \
-do {							                \
-        unsigned int *ptr = &local_bh_count(smp_processor_id());        \
-        barrier();                                                      \
-        if (!--*ptr)							\
-		if (softirq_pending(smp_processor_id()))		\
-			/* Use the async. stack for softirq */		\
-			do_call_softirq();				\
+#define local_bh_enable()						\
+do {									\
+	__local_bh_enable();						\
+	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
+		/* Use the async. stack for softirq */			\
+		do_call_softirq();					\
 } while (0)
 
 #endif	/* __ASM_SOFTIRQ_H */
diff -urN linux-2.5.40/include/asm-s390/spinlock.h linux-2.5.40-s390/include/asm-s390/spinlock.h
--- linux-2.5.40/include/asm-s390/spinlock.h	Tue Oct  1 09:07:57 2002
+++ linux-2.5.40-s390/include/asm-s390/spinlock.h	Fri Oct  4 16:14:42 2002
@@ -76,6 +76,8 @@
 
 #define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
+#define rwlock_is_locked(x) ((x)->lock != 0)
+
 #define _raw_read_lock(rw)   \
         asm volatile("   l     2,0(%1)\n"   \
                      "   j     1f\n"     \
diff -urN linux-2.5.40/include/asm-s390/system.h linux-2.5.40-s390/include/asm-s390/system.h
--- linux-2.5.40/include/asm-s390/system.h	Tue Oct  1 09:07:47 2002
+++ linux-2.5.40-s390/include/asm-s390/system.h	Fri Oct  4 16:14:42 2002
@@ -102,6 +102,77 @@
 }
 
 /*
+ * Atomic compare and exchange.  Compare OLD with MEM, if identical,
+ * store NEW in MEM.  Return the initial value in MEM.  Success is
+ * indicated by comparing RETURN with OLD.
+ */
+
+#define __HAVE_ARCH_CMPXCHG 1
+
+#define cmpxchg(ptr,o,n)\
+	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
+					(unsigned long)(n),sizeof(*(ptr))))
+
+static inline unsigned long
+__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
+{
+	unsigned long addr, prev, tmp;
+	int shift;
+
+        switch (size) {
+	case 1:
+		addr = (unsigned long) ptr;
+		shift = (3 ^ (addr & 3)) << 3;
+		addr ^= addr & 3;
+		asm volatile(
+			"    l   %0,0(%4)\n"
+			"0:  nr  %0,%5\n"
+                        "    lr  %1,%0\n"
+			"    or  %0,%2\n"
+			"    or  %1,%3\n"
+			"    cs  %0,%1,0(%4)\n"
+			"    jnl 1f\n"
+			"    xr  %1,%0\n"
+			"    nr  %1,%5\n"
+			"    jnz 0b\n"
+			"1:"
+			: "=&d" (prev), "=&d" (tmp)
+			: "d" (old << shift), "d" (new << shift), "a" (ptr),
+			  "d" (~(255 << shift))
+			: "memory", "cc" );
+		return prev >> shift;
+	case 2:
+		addr = (unsigned long) ptr;
+		shift = (2 ^ (addr & 2)) << 3;
+		addr ^= addr & 2;
+		asm volatile(
+			"    l   %0,0(%4)\n"
+			"0:  nr  %0,%5\n"
+                        "    lr  %1,%0\n"
+			"    or  %0,%2\n"
+			"    or  %1,%3\n"
+			"    cs  %0,%1,0(%4)\n"
+			"    jnl 1f\n"
+			"    xr  %1,%0\n"
+			"    nr  %1,%5\n"
+			"    jnz 0b\n"
+			"1:"
+			: "=&d" (prev), "=&d" (tmp)
+			: "d" (old << shift), "d" (new << shift), "a" (ptr),
+			  "d" (~(65535 << shift))
+			: "memory", "cc" );
+		return prev >> shift;
+	case 4:
+		asm volatile (
+			"    cs  %0,%2,0(%3)\n"
+			: "=&d" (prev) : "0" (old), "d" (new), "a" (ptr)
+			: "memory", "cc" );
+		return prev;
+        }
+        return old;
+}
+
+/*
  * Force strict CPU ordering.
  * And yes, this is required on UP too when we're talking
  * to devices.
@@ -146,6 +217,13 @@
 #define local_irq_restore(x) \
         __asm__ __volatile__("ssm   0(%0)" : : "a" (&x) : "memory")
 
+#define irqs_disabled()			\
+({					\
+	unsigned long flags;		\
+	local_save_flags(flags);	\
+        !((flags >> 24) & 3);		\
+})
+
 #define __load_psw(psw) \
 	__asm__ __volatile__("lpsw 0(%0)" : : "a" (&psw) : "cc" );
 
@@ -210,16 +288,6 @@
 
 #ifdef CONFIG_SMP
 
-extern void __global_cli(void);
-extern void __global_sti(void);
-
-extern unsigned long __global_save_flags(void);
-extern void __global_restore_flags(unsigned long);
-#define cli() __global_cli()
-#define sti() __global_sti()
-#define save_flags(x) ((x)=__global_save_flags())
-#define restore_flags(x) __global_restore_flags(x)
-
 extern void smp_ctl_set_bit(int cr, int bit);
 extern void smp_ctl_clear_bit(int cr, int bit);
 #define ctl_set_bit(cr, bit) smp_ctl_set_bit(cr, bit)
@@ -227,15 +295,9 @@
 
 #else
 
-#define cli() local_irq_disable()
-#define sti() local_irq_enable()
-#define save_flags(x) local_save_flags(x)
-#define restore_flags(x) local_irq_restore(x)
-
 #define ctl_set_bit(cr, bit) __ctl_set_bit(cr, bit)
 #define ctl_clear_bit(cr, bit) __ctl_clear_bit(cr, bit)
 
-
 #endif
 
 #ifdef __KERNEL__
diff -urN linux-2.5.40/include/asm-s390/tlbflush.h linux-2.5.40-s390/include/asm-s390/tlbflush.h
--- linux-2.5.40/include/asm-s390/tlbflush.h	Tue Oct  1 09:07:45 2002
+++ linux-2.5.40-s390/include/asm-s390/tlbflush.h	Fri Oct  4 16:14:42 2002
@@ -91,8 +91,7 @@
 
 static inline void __flush_tlb_mm(struct mm_struct * mm)
 {
-	if ((smp_num_cpus > 1) &&
-	    ((atomic_read(&mm->mm_count) != 1) ||
+	if (((atomic_read(&mm->mm_count) != 1) ||
 	     (mm->cpu_vm_mask != (1UL << smp_processor_id())))) {
 		mm->cpu_vm_mask = (1UL << smp_processor_id());
 		global_flush_tlb();
diff -urN linux-2.5.40/include/asm-s390x/bitops.h linux-2.5.40-s390/include/asm-s390x/bitops.h
--- linux-2.5.40/include/asm-s390x/bitops.h	Tue Oct  1 09:07:40 2002
+++ linux-2.5.40-s390/include/asm-s390x/bitops.h	Fri Oct  4 16:14:42 2002
@@ -811,7 +811,14 @@
  * hweightN: returns the hamming weight (i.e. the number
  * of bits set) of a N-bit word
  */
-
+#define hweight64(x)						\
+({								\
+	unsigned long __x = (x);				\
+	unsigned int __w;					\
+	__w = generic_hweight32((unsigned int) __x);		\
+	__w += generic_hweight32((unsigned int) (__x>>32));	\
+	__w;							\
+})
 #define hweight32(x) generic_hweight32(x)
 #define hweight16(x) generic_hweight16(x)
 #define hweight8(x) generic_hweight8(x)
diff -urN linux-2.5.40/include/asm-s390x/hardirq.h linux-2.5.40-s390/include/asm-s390x/hardirq.h
--- linux-2.5.40/include/asm-s390x/hardirq.h	Tue Oct  1 09:06:13 2002
+++ linux-2.5.40-s390/include/asm-s390x/hardirq.h	Fri Oct  4 16:14:42 2002
@@ -21,8 +21,6 @@
 /* entry.S is sensitive to the offsets of these fields */
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int __local_irq_count;
-	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
 	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
 } ____cacheline_aligned irq_cpustat_t;
@@ -30,64 +28,76 @@
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
 /*
- * Are we in an interrupt context? Either doing bottom half
- * or hardware interrupt processing?
+ * We put the hardirq and softirq counter into the preemption
+ * counter. The bitmask has the following meaning:
+ *
+ * - bits 0-7 are the preemption count (max preemption depth: 256)
+ * - bits 8-15 are the softirq count (max # of softirqs: 256)
+ * - bits 16-23 are the hardirq count (max # of hardirqs: 256)
+ *
+ * - ( bit 26 is the PREEMPT_ACTIVE flag. )
+ *
+ * PREEMPT_MASK: 0x000000ff
+ * SOFTIRQ_MASK: 0x0000ff00
+ * HARDIRQ_MASK: 0x00010000
  */
-#define in_interrupt() ({ int __cpu = smp_processor_id(); \
-	(local_irq_count(__cpu) + local_bh_count(__cpu) != 0); })
 
-#define in_irq() (local_irq_count(smp_processor_id()) != 0)
+#define PREEMPT_BITS	8
+#define SOFTIRQ_BITS	8
+// FIXME: we have 2^16 i/o and 2^16 external interrupts...
+#define HARDIRQ_BITS	1
+
+#define PREEMPT_SHIFT	0
+#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
+#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
+
+#define __MASK(x)	((1UL << (x))-1)
+
+#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
+#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
+#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
+
+#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
+#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
+
+#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
+#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
+#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
 
-#ifndef CONFIG_SMP
-  
-#define hardirq_trylock(cpu)	(local_irq_count(cpu) == 0)
-#define hardirq_endlock(cpu)	do { } while (0)
-  
-#define hardirq_enter(cpu)	(local_irq_count(cpu)++)
-#define hardirq_exit(cpu)	(local_irq_count(cpu)--)
+/*
+ * Are we doing bottom half or hardware interrupt processing?
+ * Are we in a softirq context? Interrupt context?
+ */
+#define in_irq()		(hardirq_count())
+#define in_softirq()		(softirq_count())
+#define in_interrupt()		(irq_count())
 
-#define synchronize_irq()	do { } while (0)
 
-#else
+#define hardirq_trylock()	(!in_interrupt())
+#define hardirq_endlock()	do { } while (0)
 
-#include <asm/atomic.h>
-#include <asm/smp.h>
+#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
-extern atomic_t global_irq_holder;
-extern atomic_t global_irq_lock;
-extern atomic_t global_irq_count;
-
-static inline void release_irqlock(int cpu)
-{
-	/* if we didn't own the irq lock, just ignore.. */
-	if (atomic_read(&global_irq_holder) ==  cpu) {
-		atomic_set(&global_irq_holder,NO_PROC_ID);
-                atomic_set(&global_irq_lock,0);
-	}
-}
-
-static inline void hardirq_enter(int cpu)
-{
-        ++local_irq_count(cpu);
-	atomic_inc(&global_irq_count);
-}
-
-static inline void hardirq_exit(int cpu)
-{
-	atomic_dec(&global_irq_count);
-        --local_irq_count(cpu);
-}
-
-static inline int hardirq_trylock(int cpu)
-{
-	return !atomic_read(&global_irq_count) && 
-               !atomic_read(&global_irq_lock);
-}
+extern void do_call_softirq(void);
 
-#define hardirq_endlock(cpu)	do { } while (0)
+#define in_atomic()	(preempt_count() != 0)
+#define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 
-extern void synchronize_irq(void);
+#define irq_exit()							\
+do {									\
+	preempt_count() -= HARDIRQ_OFFSET;				\
+	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
+		/* Use the async. stack for softirq */			\
+		do_call_softirq();					\
+} while (0)
 
+#ifndef CONFIG_SMP
+# define synchronize_irq(irq)	barrier()
+#else
+  extern void synchronize_irq(unsigned int irq);
 #endif /* CONFIG_SMP */
 
+extern void show_stack(unsigned long * esp);
+
 #endif /* __ASM_HARDIRQ_H */
diff -urN linux-2.5.40/include/asm-s390x/irq.h linux-2.5.40-s390/include/asm-s390x/irq.h
--- linux-2.5.40/include/asm-s390x/irq.h	Tue Oct  1 09:07:39 2002
+++ linux-2.5.40-s390/include/asm-s390x/irq.h	Fri Oct  4 16:14:42 2002
@@ -897,67 +897,6 @@
 	return cc;
 }
 
-/*
- * Various low-level irq details needed by irq.c, process.c,
- * time.c, io_apic.c and smp.c
- *
- * Interrupt entry/exit code at both C and assembly level
- */
-
-#ifdef CONFIG_SMP
-
-#include <asm/atomic.h>
-
-static inline void irq_enter(int cpu, unsigned int irq)
-{
-        hardirq_enter(cpu);
-        while (atomic_read(&global_irq_lock) != 0) {
-                eieio();
-        }
-}
-
-static inline void irq_exit(int cpu, unsigned int irq)
-{
-        hardirq_exit(cpu);
-        release_irqlock(cpu);
-}
-
-
-#else
-
-#define irq_enter(cpu, irq)     (++local_irq_count(cpu))
-#define irq_exit(cpu, irq)      (--local_irq_count(cpu))
-
-#endif
-
-#define __STR(x) #x
-#define STR(x) __STR(x)
-
-/*
- * x86 profiling function, SMP safe. We might want to do this in
- * assembly totally?
- * is this ever used anyway?
- */
-extern char _stext;
-static inline void s390_do_profile (unsigned long addr)
-{
-        if (prof_buffer && current->pid) {
-#ifndef CONFIG_ARCH_S390X
-                addr &= 0x7fffffff;
-#endif
-                addr -= (unsigned long) &_stext;
-                addr >>= prof_shift;
-                /*
-                 * Don't ignore out-of-bounds EIP values silently,
-                 * put them into the last histogram slot, so if
-                 * present, they will show up as a sharp peak.
-                 */
-                if (addr > prof_len-1)
-                        addr = prof_len-1;
-                atomic_inc((atomic_t *)&prof_buffer[addr]);
-        }
-}
-
 #include <asm/s390io.h>
 
 #define get_irq_lock(irq) &ioinfo[irq]->irq_lock
diff -urN linux-2.5.40/include/asm-s390x/kmap_types.h linux-2.5.40-s390/include/asm-s390x/kmap_types.h
--- linux-2.5.40/include/asm-s390x/kmap_types.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.40-s390/include/asm-s390x/kmap_types.h	Fri Oct  4 16:14:42 2002
@@ -0,0 +1,21 @@
+#ifdef __KERNEL__
+#ifndef _ASM_KMAP_TYPES_H
+#define _ASM_KMAP_TYPES_H
+
+enum km_type {
+	KM_BOUNCE_READ,
+	KM_SKB_SUNRPC_DATA,
+	KM_SKB_DATA_SOFTIRQ,
+	KM_USER0,
+	KM_USER1,
+	KM_BIO_SRC_IRQ,
+	KM_BIO_DST_IRQ,
+	KM_PTE0,
+	KM_PTE1,
+	KM_IRQ0,
+	KM_IRQ1,
+	KM_TYPE_NR
+};
+
+#endif
+#endif /* __KERNEL__ */
diff -urN linux-2.5.40/include/asm-s390x/param.h linux-2.5.40-s390/include/asm-s390x/param.h
--- linux-2.5.40/include/asm-s390x/param.h	Tue Oct  1 09:05:46 2002
+++ linux-2.5.40-s390/include/asm-s390x/param.h	Fri Oct  4 16:14:42 2002
@@ -9,11 +9,14 @@
 #ifndef _ASMS390_PARAM_H
 #define _ASMS390_PARAM_H
 
-#ifndef HZ
-#define HZ 100
 #ifdef __KERNEL__
-#define hz_to_std(a) (a)
+# define HZ		100		/* Internal kernel timer frequency */
+# define USER_HZ	100		/* .. some user interfaces are in "ticks" */
+# define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
 #endif
+
+#ifndef HZ
+#define HZ 100
 #endif
 
 #define EXEC_PAGESIZE	4096
@@ -28,8 +31,4 @@
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
 
-#ifdef __KERNEL__
-# define CLOCKS_PER_SEC		HZ	/* frequency at which times() counts */
-#endif
-                                 
 #endif
diff -urN linux-2.5.40/include/asm-s390x/pgalloc.h linux-2.5.40-s390/include/asm-s390x/pgalloc.h
--- linux-2.5.40/include/asm-s390x/pgalloc.h	Tue Oct  1 09:06:18 2002
+++ linux-2.5.40-s390/include/asm-s390x/pgalloc.h	Fri Oct  4 16:14:42 2002
@@ -16,6 +16,8 @@
 #include <linux/config.h>
 #include <asm/processor.h>
 #include <linux/threads.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
 
 #define check_pgt_cache()	do { } while (0)
 
diff -urN linux-2.5.40/include/asm-s390x/pgtable.h linux-2.5.40-s390/include/asm-s390x/pgtable.h
--- linux-2.5.40/include/asm-s390x/pgtable.h	Tue Oct  1 09:06:57 2002
+++ linux-2.5.40-s390/include/asm-s390x/pgtable.h	Fri Oct  4 16:14:42 2002
@@ -168,6 +168,8 @@
 #define _REGION_TABLE       (_REGION_THIRD|_REGION_THIRD_LEN|0x40|0x100)
 #define _KERN_REGION_TABLE  (_REGION_THIRD|_REGION_THIRD_LEN)
 
+#define USER_STD_MASK           0x0000000000000080UL
+
 /* Bits in the storage key */
 #define _PAGE_CHANGED    0x02          /* HW changed bit                   */
 #define _PAGE_REFERENCED 0x04          /* HW referenced bit                */
diff -urN linux-2.5.40/include/asm-s390x/rwsem.h linux-2.5.40-s390/include/asm-s390x/rwsem.h
--- linux-2.5.40/include/asm-s390x/rwsem.h	Tue Oct  1 09:06:27 2002
+++ linux-2.5.40-s390/include/asm-s390x/rwsem.h	Fri Oct  4 16:14:42 2002
@@ -48,9 +48,11 @@
 
 struct rwsem_waiter;
 
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *);
+extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *);
 extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *);
+extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *);
+extern struct rw_semaphore *rwsem_downgrade_write(struct rw_semaphore *);
 
 /*
  * the semaphore definition
@@ -105,6 +107,27 @@
 }
 
 /*
+ * trylock for reading -- returns 1 if successful, 0 if contention
+ */
+static inline int __down_read_trylock(struct rw_semaphore *sem)
+{
+	signed long old, new;
+
+	__asm__ __volatile__(
+		"   lg   %0,0(%2)\n"
+		"0: ltgr %1,%0\n"
+		"   jm   1f\n"
+		"   aghi %1,%3\n"
+		"   csg  %0,%1,0(%2)\n"
+		"   jl   0b\n"
+		"1:"
+                : "=&d" (old), "=&d" (new)
+		: "a" (&sem->count), "i" (RWSEM_ACTIVE_READ_BIAS)
+		: "cc", "memory" );
+	return old >= 0 ? 1 : 0;
+}
+
+/*
  * lock for writing
  */
 static inline void __down_write(struct rw_semaphore *sem)
@@ -126,6 +149,26 @@
 }
 
 /*
+ * trylock for writing -- returns 1 if successful, 0 if contention
+ */
+static inline int __down_write_trylock(struct rw_semaphore *sem)
+{
+	signed long old;
+
+	__asm__ __volatile__(
+		"   lg   %0,0(%1)\n"
+		"0: ltgr %0,%0\n"
+		"   jnz  1f\n"
+		"   csg  %0,%2,0(%1)\n"
+		"   jl   0b\n"
+		"1:"
+                : "=&d" (old)
+		: "a" (&sem->count), "d" (RWSEM_ACTIVE_WRITE_BIAS)
+		: "cc", "memory" );
+	return (old == RWSEM_UNLOCKED_VALUE) ? 1 : 0;
+}
+
+/*
  * unlock after reading
  */
 static inline void __up_read(struct rw_semaphore *sem)
@@ -169,6 +212,27 @@
 }
 
 /*
+ * downgrade write lock to read lock
+ */
+static inline void __downgrade_write(struct rw_semaphore *sem)
+{
+	signed long old, new, tmp;
+
+	tmp = -RWSEM_WAITING_BIAS;
+	__asm__ __volatile__(
+		"   lg   %0,0(%2)\n"
+		"0: lgr  %1,%0\n"
+		"   ag   %1,%3\n"
+		"   csg  %0,%1,0(%2)\n"
+		"   jl   0b"
+                : "=&d" (old), "=&d" (new)
+		: "a" (&sem->count), "m" (tmp)
+		: "cc", "memory" );
+	if (new > 1) // FIXME: is this correct ?!?
+		rwsem_downgrade_wake(sem);
+}
+
+/*
  * implement atomic add functionality
  */
 static inline void rwsem_atomic_add(long delta, struct rw_semaphore *sem)
diff -urN linux-2.5.40/include/asm-s390x/smp.h linux-2.5.40-s390/include/asm-s390x/smp.h
--- linux-2.5.40/include/asm-s390x/smp.h	Tue Oct  1 09:06:59 2002
+++ linux-2.5.40-s390/include/asm-s390x/smp.h	Fri Oct  4 16:14:42 2002
@@ -11,7 +11,7 @@
 
 #include <linux/config.h>
 #include <linux/threads.h>
-#include <linux/ptrace.h>
+#include <linux/bitops.h>
 
 #if defined(__KERNEL__) && defined(CONFIG_SMP) && !defined(__ASSEMBLY__)
 
@@ -29,6 +29,7 @@
 } sigp_info;
 
 extern volatile unsigned long cpu_online_map;
+extern volatile unsigned long cpu_possible_map;
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 
@@ -46,14 +47,20 @@
 
 #define smp_processor_id() (current_thread_info()->cpu)
 
-extern __inline__ int cpu_logical_map(int cpu)
+#define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
+#define cpu_possible(cpu) (cpu_possible_map & (1<<(cpu)))
+
+extern inline unsigned int num_online_cpus(void)
 {
-        return cpu;
+	return hweight64(cpu_online_map);
 }
 
-extern __inline__ int cpu_number_map(int cpu)
+extern inline int any_online_cpu(unsigned int mask)
 {
-        return cpu;
+	if (mask & cpu_online_map)
+		return __ffs(mask & cpu_online_map);
+
+	return -1;
 }
 
 extern __inline__ __u16 hard_smp_processor_id(void)
diff -urN linux-2.5.40/include/asm-s390x/softirq.h linux-2.5.40-s390/include/asm-s390x/softirq.h
--- linux-2.5.40/include/asm-s390x/softirq.h	Tue Oct  1 09:06:21 2002
+++ linux-2.5.40-s390/include/asm-s390x/softirq.h	Fri Oct  4 16:14:42 2002
@@ -9,34 +9,27 @@
 #ifndef __ASM_SOFTIRQ_H
 #define __ASM_SOFTIRQ_H
 
-#ifndef __LINUX_SMP_H
 #include <linux/smp.h>
-#endif
+#include <linux/preempt.h>
 
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 #include <asm/lowcore.h>
 
-#define __cpu_bh_enable(cpu) \
-                do { barrier(); local_bh_count(cpu)--; } while (0)
-#define cpu_bh_disable(cpu) \
-                do { local_bh_count(cpu)++; barrier(); } while (0)
-
-#define local_bh_disable()      cpu_bh_disable(smp_processor_id())
-#define __local_bh_enable()     __cpu_bh_enable(smp_processor_id())
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
+#define local_bh_disable() \
+		do { preempt_count() += SOFTIRQ_OFFSET; barrier(); } while (0)
+#define __local_bh_enable() \
+		do { barrier(); preempt_count() -= SOFTIRQ_OFFSET; } while (0)
 
 extern void do_call_softirq(void);
 
-#define local_bh_enable()			          	        \
-do {							                \
-        unsigned int *ptr = &local_bh_count(smp_processor_id());        \
-        barrier();                                                      \
-        if (!--*ptr)							\
-		if (softirq_pending(smp_processor_id()))		\
-			/* Use the async. stack for softirq */		\
-			do_call_softirq();				\
+#define local_bh_enable()						\
+do {									\
+	__local_bh_enable();						\
+	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
+		/* Use the async. stack for softirq */			\
+		do_call_softirq();					\
+	preempt_check_resched();					\
 } while (0)
 
 #endif	/* __ASM_SOFTIRQ_H */
diff -urN linux-2.5.40/include/asm-s390x/spinlock.h linux-2.5.40-s390/include/asm-s390x/spinlock.h
--- linux-2.5.40/include/asm-s390x/spinlock.h	Tue Oct  1 09:06:19 2002
+++ linux-2.5.40-s390/include/asm-s390x/spinlock.h	Fri Oct  4 16:14:42 2002
@@ -12,6 +12,13 @@
 #define __ASM_SPINLOCK_H
 
 /*
+ * Grmph, take care of %&#! user space programs that include
+ * asm/spinlock.h. The diagnose is only available in kernel
+ * context.
+ */
+#include <asm/lowcore.h>
+
+/*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
  *
@@ -76,6 +83,8 @@
 
 #define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
+#define rwlock_is_locked(x) ((x)->lock != 0)
+
 #define _raw_read_lock(rw)   \
         asm volatile("   lg    2,0(%1)\n"   \
                      "   j     1f\n"     \
diff -urN linux-2.5.40/include/asm-s390x/system.h linux-2.5.40-s390/include/asm-s390x/system.h
--- linux-2.5.40/include/asm-s390x/system.h	Tue Oct  1 09:07:40 2002
+++ linux-2.5.40-s390/include/asm-s390x/system.h	Fri Oct  4 16:14:42 2002
@@ -18,7 +18,7 @@
 #endif
 #include <linux/kernel.h>
 
-#define switch_to(prev,next),last do {					     \
+#define switch_to(prev,next,last) do {					     \
 	if (prev == next)						     \
 		break;							     \
 	save_fp_regs(&prev->thread.fp_regs);				     \
@@ -115,6 +115,83 @@
 }
 
 /*
+ * Atomic compare and exchange.  Compare OLD with MEM, if identical,
+ * store NEW in MEM.  Return the initial value in MEM.  Success is
+ * indicated by comparing RETURN with OLD.
+ */
+
+#define __HAVE_ARCH_CMPXCHG 1
+
+#define cmpxchg(ptr,o,n)\
+	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
+					(unsigned long)(n),sizeof(*(ptr))))
+
+static inline unsigned long
+__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
+{
+	unsigned long addr, prev, tmp;
+	int shift;
+
+        switch (size) {
+	case 1:
+		addr = (unsigned long) ptr;
+		shift = (3 ^ (addr & 3)) << 3;
+		addr ^= addr & 3;
+		asm volatile(
+			"    l   %0,0(%4)\n"
+			"0:  nr  %0,%5\n"
+                        "    lr  %1,%0\n"
+			"    or  %0,%2\n"
+			"    or  %1,%3\n"
+			"    cs  %0,%1,0(%4)\n"
+			"    jnl 1f\n"
+			"    xr  %1,%0\n"
+			"    nr  %1,%5\n"
+			"    jnz 0b\n"
+			"1:"
+			: "=&d" (prev), "=&d" (tmp)
+			: "d" (old << shift), "d" (new << shift), "a" (ptr),
+			  "d" (~(255 << shift))
+			: "memory", "cc" );
+		return prev >> shift;
+	case 2:
+		addr = (unsigned long) ptr;
+		shift = (2 ^ (addr & 2)) << 3;
+		addr ^= addr & 2;
+		asm volatile(
+			"    l   %0,0(%4)\n"
+			"0:  nr  %0,%5\n"
+                        "    lr  %1,%0\n"
+			"    or  %0,%2\n"
+			"    or  %1,%3\n"
+			"    cs  %0,%1,0(%4)\n"
+			"    jnl 1f\n"
+			"    xr  %1,%0\n"
+			"    nr  %1,%5\n"
+			"    jnz 0b\n"
+			"1:"
+			: "=&d" (prev), "=&d" (tmp)
+			: "d" (old << shift), "d" (new << shift), "a" (ptr),
+			  "d" (~(65535 << shift))
+			: "memory", "cc" );
+		return prev >> shift;
+	case 4:
+		asm volatile (
+			"    cs  %0,%2,0(%3)\n"
+			: "=&d" (prev) : "0" (old), "d" (new), "a" (ptr)
+			: "memory", "cc" );
+		return prev;
+	case 8:
+		asm volatile (
+			"    csg %0,%2,0(%3)\n"
+			: "=&d" (prev) : "0" (old), "d" (new), "a" (ptr)
+			: "memory", "cc" );
+		return prev;
+        }
+        return old;
+}
+
+/*
  * Force strict CPU ordering.
  * And yes, this is required on UP too when we're talking
  * to devices.
@@ -158,6 +235,13 @@
 #define local_irq_restore(x) \
         __asm__ __volatile__("ssm   0(%0)" : : "a" (&x) : "memory")
 
+#define irqs_disabled()			\
+({					\
+	unsigned long flags;		\
+	local_save_flags(flags);	\
+        !((flags >> 56) & 3);		\
+})
+
 #define __load_psw(psw) \
         __asm__ __volatile__("lpswe 0(%0)" : : "a" (&psw) : "cc" );
 
@@ -220,16 +304,6 @@
 
 #ifdef CONFIG_SMP
 
-extern void __global_cli(void);
-extern void __global_sti(void);
-
-extern unsigned long __global_save_flags(void);
-extern void __global_restore_flags(unsigned long);
-#define cli() __global_cli()
-#define sti() __global_sti()
-#define save_flags(x) ((x)=__global_save_flags())
-#define restore_flags(x) __global_restore_flags(x)
-
 extern void smp_ctl_set_bit(int cr, int bit);
 extern void smp_ctl_clear_bit(int cr, int bit);
 #define ctl_set_bit(cr, bit) smp_ctl_set_bit(cr, bit)
@@ -237,15 +311,9 @@
 
 #else
 
-#define cli() local_irq_disable()
-#define sti() local_irq_enable()
-#define save_flags(x) local_save_flags(x)
-#define restore_flags(x) local_irq_restore(x)
-
 #define ctl_set_bit(cr, bit) __ctl_set_bit(cr, bit)
 #define ctl_clear_bit(cr, bit) __ctl_clear_bit(cr, bit)
 
-
 #endif
 
 #ifdef __KERNEL__
diff -urN linux-2.5.40/include/asm-s390x/tlbflush.h linux-2.5.40-s390/include/asm-s390x/tlbflush.h
--- linux-2.5.40/include/asm-s390x/tlbflush.h	Tue Oct  1 09:07:31 2002
+++ linux-2.5.40-s390/include/asm-s390x/tlbflush.h	Fri Oct  4 16:14:42 2002
@@ -88,8 +88,7 @@
 
 static inline void __flush_tlb_mm(struct mm_struct * mm)
 {
-	if ((smp_num_cpus > 1) &&
-	    ((atomic_read(&mm->mm_count) != 1) ||
+	if (((atomic_read(&mm->mm_count) != 1) ||
 	     (mm->cpu_vm_mask != (1UL << smp_processor_id())))) {
 		mm->cpu_vm_mask = (1UL << smp_processor_id());
 		global_flush_tlb();

