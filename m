Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSHJP0r>; Sat, 10 Aug 2002 11:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317035AbSHJP0r>; Sat, 10 Aug 2002 11:26:47 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:32526 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S317034AbSHJP0d>; Sat, 10 Aug 2002 11:26:33 -0400
Date: Sat, 10 Aug 2002 19:29:54 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>,
       Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.30] alpha: interrupt/preempt update [6/10]
Message-ID: <20020810192954.E20534@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one is large mostly because of massive code deletion.
- cli, sti an so on go away;
- irq_smp.c goes to /dev/null; the only leftover (synchronize_irq)
  moved to irq.c;
- hardirq count field in the preemption counter extended to 12 bits -
  one more than required for wildfire.

Ivan.

--- 2.5.30/include/asm-alpha/thread_info.h	Mon May  6 10:31:10 2002
+++ linux/include/asm-alpha/thread_info.h	Sat Aug 10 01:24:08 2002
@@ -19,7 +19,7 @@ struct thread_info {
 
 	struct exec_domain	*exec_domain;	/* execution domain */
 	mm_segment_t		addr_limit;	/* thread address space */
-	int			cpu;		/* current CPU */
+	long			cpu;		/* current CPU */
 	int			preempt_count; /* 0 => preemptable, <0 => BUG */
 
 	int bpt_nsaved;
@@ -54,7 +54,7 @@ register struct thread_info *__current_t
 
 #endif /* __ASSEMBLY__ */
 
-#define PREEMPT_ACTIVE		0x4000000
+#define PREEMPT_ACTIVE		0x40000000
 
 /*
  * Thread information flags:
--- 2.5.30/include/asm-alpha/smplock.h	Mon Aug  5 00:56:41 2002
+++ linux/include/asm-alpha/smplock.h	Sat Aug 10 01:24:08 2002
@@ -15,12 +15,10 @@ extern spinlock_t kernel_flag;
 /*
  * Release global kernel lock and global interrupt lock
  */
-static __inline__ void release_kernel_lock(struct task_struct *task, int cpu)
+static __inline__ void release_kernel_lock(struct task_struct *task)
 {
-	if (task->lock_depth >= 0)
+	if (unlikely(task->lock_depth >= 0))
 		spin_unlock(&kernel_flag);
-	release_irqlock(cpu);
-	local_irq_enable();
 }
 
 /*
@@ -28,7 +26,7 @@ static __inline__ void release_kernel_lo
  */
 static __inline__ void reacquire_kernel_lock(struct task_struct *task)
 {
-	if (task->lock_depth >= 0)
+	if (unlikely(task->lock_depth >= 0))
 		spin_lock(&kernel_flag);
 }
 
@@ -41,8 +39,14 @@ static __inline__ void reacquire_kernel_
  */
 static __inline__ void lock_kernel(void)
 {
+#ifdef CONFIG_PREEMPT
+	if (current->lock_depth == -1)
+		spin_lock(&kernel_flag);
+	++current->lock_depth;
+#else
 	if (!++current->lock_depth)
 		spin_lock(&kernel_flag);
+#endif
 }
 
 static __inline__ void unlock_kernel(void)
--- 2.5.30/include/asm-alpha/softirq.h	Mon Mar 18 23:37:10 2002
+++ linux/include/asm-alpha/softirq.h	Sat Aug 10 01:24:08 2002
@@ -1,35 +1,21 @@
 #ifndef _ALPHA_SOFTIRQ_H
 #define _ALPHA_SOFTIRQ_H
 
-#include <linux/stddef.h>
-#include <asm/atomic.h>
+#include <linux/preempt.h>
 #include <asm/hardirq.h>
 
-extern inline void cpu_bh_disable(int cpu)
-{
-	local_bh_count(cpu)++;
-	barrier();
-}
-
-extern inline void __cpu_bh_enable(int cpu)
-{
-	barrier();
-	local_bh_count(cpu)--;
-}
-
-#define __local_bh_enable()	__cpu_bh_enable(smp_processor_id())
-#define local_bh_disable()	cpu_bh_disable(smp_processor_id())
+#define local_bh_disable() \
+		do { preempt_count() += SOFTIRQ_OFFSET; barrier(); } while (0)
+#define __local_bh_enable() \
+		do { barrier(); preempt_count() -= SOFTIRQ_OFFSET; } while (0)
 
 #define local_bh_enable()					\
 do {								\
-	int cpu;						\
-								\
-	barrier();						\
-	cpu = smp_processor_id();				\
-	if (!--local_bh_count(cpu) && softirq_pending(cpu))	\
+	__local_bh_enable();					\
+	if (unlikely(!in_interrupt() &&				\
+		     softirq_pending(smp_processor_id())))	\
 		do_softirq();					\
+	preempt_check_resched();				\
 } while (0)
-
-#define in_softirq() (local_bh_count(smp_processor_id()) != 0)
 
 #endif /* _ALPHA_SOFTIRQ_H */
--- 2.5.30/include/asm-alpha/system.h	Sat Aug 10 01:19:52 2002
+++ linux/include/asm-alpha/system.h	Sat Aug 10 01:24:08 2002
@@ -311,32 +311,6 @@ extern int __min_ipl;
 #define local_irq_save(flags)	do { (flags) = swpipl(IPL_MAX); barrier(); } while(0)
 #define local_irq_restore(flags)	do { barrier(); setipl(flags); barrier(); } while(0)
 
-#ifdef CONFIG_SMP
-
-extern int global_irq_holder;
-
-#define save_and_cli(flags)     (save_flags(flags), cli())
-
-extern void __global_cli(void);
-extern void __global_sti(void);
-extern unsigned long __global_save_flags(void);
-extern void __global_restore_flags(unsigned long flags);
-
-#define cli()                   __global_cli()
-#define sti()                   __global_sti()
-#define save_flags(flags)	((flags) = __global_save_flags())
-#define restore_flags(flags)    __global_restore_flags(flags)
-
-#else /* CONFIG_SMP */
-
-#define cli()			local_irq_disable()
-#define sti()			local_irq_enable()
-#define save_flags(flags)	local_save_flags(flags)
-#define save_and_cli(flags)	local_irq_save(flags)
-#define restore_flags(flags)	local_irq_restore(flags)
-
-#endif /* CONFIG_SMP */
-
 /*
  * TB routines..
  */
--- 2.5.30/include/asm-alpha/smp.h	Sat Aug 10 01:20:59 2002
+++ linux/include/asm-alpha/smp.h	Sat Aug 10 01:24:08 2002
@@ -30,7 +30,6 @@ struct cpuinfo_alpha {
 	int need_new_asn;
 	int asn_lock;
 	unsigned long ipi_count;
-	unsigned long irq_attempt[NR_IRQS];
 	unsigned long prof_multiplier;
 	unsigned long prof_counter;
 	unsigned char mcheck_expected;
--- 2.5.30/include/asm-alpha/hardirq.h	Mon Mar 18 23:37:05 2002
+++ linux/include/asm-alpha/hardirq.h	Sat Aug 10 01:24:08 2002
@@ -7,91 +7,91 @@
 /* entry.S is sensitive to the offsets of these fields */
 typedef struct {
 	unsigned long __softirq_pending;
-	unsigned int __local_irq_count;
-	unsigned int __local_bh_count;
 	unsigned int __syscall_count;
+	unsigned long idle_timestamp;
 	struct task_struct * __ksoftirqd_task;
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
 /*
- * Are we in an interrupt context? Either doing bottom half
- * or hardware interrupt processing?
+ * We put the hardirq and softirq counter into the preemption
+ * counter. The bitmask has the following meaning:
+ *
+ * - bits 0-7 are the preemption count (max preemption depth: 256)
+ * - bits 8-15 are the softirq count (max # of softirqs: 256)
+ * - bits 16-27 are the hardirq count (max # of hardirqs: 4096)
+ *
+ * - ( bit 30 is the PREEMPT_ACTIVE flag. )
+ *
+ * PREEMPT_MASK: 0x000000ff
+ * SOFTIRQ_MASK: 0x0000ff00
+ * HARDIRQ_MASK: 0x0fff0000
  */
 
-#define in_interrupt()						\
-({								\
-	int __cpu = smp_processor_id();				\
-	(local_irq_count(__cpu) + local_bh_count(__cpu)) != 0;	\
-})
+#define PREEMPT_BITS	8
+#define SOFTIRQ_BITS	8
+#define HARDIRQ_BITS	12
+
+#define PREEMPT_SHIFT	0
+#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
+#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
+
+#define __MASK(x)	((1UL << (x))-1)
+
+#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
+#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
+#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
+
+#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
+#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
+#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
+
+#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
+#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
+#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
 
-#define in_irq() (local_irq_count(smp_processor_id()) != 0)
-
-#ifndef CONFIG_SMP
+/*
+ * The hardirq mask has to be large enough to have
+ * space for potentially all IRQ sources in the system
+ * nesting on a single CPU:
+ */
+#if (1 << HARDIRQ_BITS) < NR_IRQS
+#error HARDIRQ_BITS is too low!
+#endif
 
-extern unsigned long __irq_attempt[];
-#define irq_attempt(cpu, irq)  ((void)(cpu), __irq_attempt[irq])
+/*
+ * Are we doing bottom half or hardware interrupt processing?
+ * Are we in a softirq context? Interrupt context?
+ */
+#define in_irq()		(hardirq_count())
+#define in_softirq()		(softirq_count())
+#define in_interrupt()		(irq_count())
 
-#define hardirq_trylock(cpu)	(local_irq_count(cpu) == 0)
-#define hardirq_endlock(cpu)	((void) 0)
 
-#define irq_enter(cpu, irq)	(local_irq_count(cpu)++)
-#define irq_exit(cpu, irq)	(local_irq_count(cpu)--)
+#define hardirq_trylock()	(!in_interrupt())
+#define hardirq_endlock()	do { } while (0)
 
-#define synchronize_irq()	barrier()
+#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
 
+#if CONFIG_PREEMPT
+# define IRQ_EXIT_OFFSET (HARDIRQ_OFFSET-1)
 #else
+#define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
+# endif
+#define irq_exit()						\
+do {								\
+		preempt_count() -= IRQ_EXIT_OFFSET;		\
+		if (!in_interrupt() &&				\
+		    softirq_pending(smp_processor_id()))	\
+			do_softirq();				\
+		preempt_enable_no_resched();			\
+} while (0)
 
-#define irq_attempt(cpu, irq) (cpu_data[cpu].irq_attempt[irq])
-
-#include <asm/atomic.h>
-#include <linux/spinlock.h>
-#include <asm/smp.h>
-
-extern int global_irq_holder;
-extern spinlock_t global_irq_lock;
-
-static inline int irqs_running (void)
-{
-	int i;
-
-	for (i = 0; i < smp_num_cpus; i++)
-		if (local_irq_count(i))
-			return 1;
-	return 0;
-}
-
-static inline void release_irqlock(int cpu)
-{
-	/* if we didn't own the irq lock, just ignore.. */
-	if (global_irq_holder == cpu) {
-		global_irq_holder = NO_PROC_ID;
-		spin_unlock(&global_irq_lock);
-        }
-}
-
-static inline void irq_enter(int cpu, int irq)
-{
-	++local_irq_count(cpu);
-
-	while (spin_is_locked(&global_irq_lock))
-		barrier();
-}
-
-static inline void irq_exit(int cpu, int irq)
-{
-        --local_irq_count(cpu);
-}
-
-static inline int hardirq_trylock(int cpu)
-{
-	return !local_irq_count(cpu) && !spin_is_locked(&global_irq_lock);
-}
-
-#define hardirq_endlock(cpu)	do { } while (0)
-
-extern void synchronize_irq(void);
-
+#ifndef CONFIG_SMP
+# define synchronize_irq(irq)	barrier()
+#else
+  extern void synchronize_irq(unsigned int irq);
 #endif /* CONFIG_SMP */
+
 #endif /* _ALPHA_HARDIRQ_H */
--- 2.5.30/arch/alpha/kernel/traps.c	Sat Jun 22 02:36:54 2002
+++ linux/arch/alpha/kernel/traps.c	Sat Aug 10 01:24:08 2002
@@ -182,7 +182,7 @@ die_if_kernel(char * str, struct pt_regs
 
 	if (test_and_set_thread_flag (TIF_DIE_IF_KERNEL)) {
 		printk("die_if_kernel recursion detected.\n");
-		sti();
+		local_irq_enable();
 		while (1);
 	}
 	do_exit(SIGSEGV);
@@ -613,7 +613,7 @@ got_exception:
 
 	if (test_and_set_thread_flag (TIF_DIE_IF_KERNEL)) {
 		printk("die_if_kernel recursion detected.\n");
-		sti();
+		local_irq_enable();
 		while (1);
 	}
 	do_exit(SIGSEGV);
--- 2.5.30/arch/alpha/kernel/Makefile	Wed Jun 19 23:46:59 2002
+++ linux/arch/alpha/kernel/Makefile	Sat Aug 10 01:24:08 2002
@@ -23,7 +23,7 @@ ifdef CONFIG_VGA_HOSE
 obj-y	 += console.o
 endif
 
-obj-$(CONFIG_SMP)    += smp.o irq_smp.o
+obj-$(CONFIG_SMP)    += smp.o
 obj-$(CONFIG_PCI)    += pci.o pci_iommu.o
 obj-$(CONFIG_SRM_ENV)	+= srm_env.o
 
--- 2.5.30/arch/alpha/kernel/smp.c	Sat Aug 10 01:20:59 2002
+++ linux/arch/alpha/kernel/smp.c	Sat Aug 10 01:24:08 2002
@@ -117,8 +117,6 @@ smp_store_cpu_info(int cpuid)
 	cpu_data[cpuid].last_asn = ASN_FIRST_VERSION;
 	cpu_data[cpuid].need_new_asn = 0;
 	cpu_data[cpuid].asn_lock = 0;
-	local_irq_count(cpuid) = 0;
-	local_bh_count(cpuid) = 0;
 }
 
 /*
@@ -632,15 +630,13 @@ smp_percpu_timer_interrupt(struct pt_reg
 		/* We need to make like a normal interrupt -- otherwise
 		   timer interrupts ignore the global interrupt lock,
 		   which would be a Bad Thing.  */
-		irq_enter(cpu, RTC_IRQ);
+		irq_enter();
 
 		update_process_times(user);
 
 		data->prof_counter = data->prof_multiplier;
-		irq_exit(cpu, RTC_IRQ);
 
-		if (softirq_pending(cpu))
-			do_softirq();
+		irq_exit();
 	}
 }
 
--- 2.5.30/arch/alpha/kernel/irq_alpha.c	Mon Mar 18 23:37:08 2002
+++ linux/arch/alpha/kernel/irq_alpha.c	Sat Aug 10 01:24:08 2002
@@ -14,10 +14,6 @@
 #include "proto.h"
 #include "irq_impl.h"
 
-#ifndef CONFIG_SMP
-unsigned long __irq_attempt[NR_IRQS];
-#endif
-
 /* Hack minimum IPL during interrupt processing for broken hardware.  */
 #ifdef CONFIG_ALPHA_BROKEN_IRQ_MASK
 int __min_ipl;
@@ -63,7 +59,6 @@ do_entInt(unsigned long type, unsigned l
 		smp_percpu_timer_interrupt(&regs);
 		cpu = smp_processor_id();
 		if (cpu != boot_cpuid) {
-		        irq_attempt(cpu, RTC_IRQ)++;
 		        kstat.irqs[cpu][RTC_IRQ]++;
 		} else {
 			handle_irq(RTC_IRQ, &regs);
--- 2.5.30/arch/alpha/kernel/irq_smp.c	Mon Aug  5 00:56:40 2002
+++ linux/arch/alpha/kernel/irq_smp.c	Thu Jan  1 00:00:00 1970
@@ -1,250 +0,0 @@
-/*
- *	linux/arch/alpha/kernel/irq_smp.c
- *
- */
-
-#include <linux/kernel.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/interrupt.h>
-#include <linux/random.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/irq.h>
-
-#include <asm/system.h>
-#include <asm/io.h>
-
-
-/* Who has global_irq_lock. */
-int global_irq_holder = NO_PROC_ID;
-
-/* This protects IRQ's. */
-spinlock_t global_irq_lock = SPIN_LOCK_UNLOCKED;
-
-/* Global IRQ locking depth. */
-static void *previous_irqholder = NULL;
-
-#define MAXCOUNT 100000000
-
-
-static void
-show(char * str, void *where)
-{
-#if 0
-	int i;
-        unsigned long *stack;
-#endif
-        int cpu = smp_processor_id();
-
-        printk("\n%s, CPU %d: %p\n", str, cpu, where);
-        printk("irq:  %d [%d %d]\n",
-	       irqs_running(),
-               local_irq_count(0),
-               local_irq_count(1));
-
-        printk("bh:   %d [%d %d]\n",
-	       spin_is_locked(&global_bh_lock) ? 1 : 0,
-	       local_bh_count(0),
-	       local_bh_count(1));
-#if 0
-        stack = (unsigned long *) &str;
-        for (i = 40; i ; i--) {
-		unsigned long x = *++stack;
-                if (x > (unsigned long) &init_task_union &&
-		    x < (unsigned long) &vsprintf) {
-			printk("<[%08lx]> ", x);
-                }
-        }
-#endif
-}
-
-static inline void
-wait_on_irq(int cpu, void *where)
-{
-	int count = MAXCOUNT;
-
-	for (;;) {
-
-		/*
-		 * Wait until all interrupts are gone. Wait
-		 * for bottom half handlers unless we're
-		 * already executing in one..
-		 */
-		if (!irqs_running()) {
-			if (local_bh_count(cpu)
-			    || !spin_is_locked(&global_bh_lock))
-				break;
-		}
-
-		/* Duh, we have to loop. Release the lock to avoid deadlocks */
-		spin_unlock(&global_irq_lock);
-
-		for (;;) {
-			if (!--count) {
-				show("wait_on_irq", where);
-				count = MAXCOUNT;
-			}
-			local_irq_enable();
-			udelay(1); /* make sure to run pending irqs */
-			local_irq_disable();
-
-			if (irqs_running())
-				continue;
-			if (spin_is_locked(&global_irq_lock))
-				continue;
-			if (!local_bh_count(cpu)
-			    && spin_is_locked(&global_bh_lock))
-				continue;
-			if (spin_trylock(&global_irq_lock))
-				break;
-		}
-	}
-}
-
-static inline void
-get_irqlock(int cpu, void* where)
-{
-	if (!spin_trylock(&global_irq_lock)) {
-		/* Do we already hold the lock?  */
-		if (cpu == global_irq_holder)
-			return;
-		/* Uhhuh.. Somebody else got it.  Wait.  */
-		spin_lock(&global_irq_lock);
-	}
-
-	/*
-	 * Ok, we got the lock bit.
-	 * But that's actually just the easy part.. Now
-	 * we need to make sure that nobody else is running
-	 * in an interrupt context. 
-	 */
-	wait_on_irq(cpu, where);
-
-	/*
-	 * Finally.
-	 */
-#ifdef CONFIG_DEBUG_SPINLOCK
-	global_irq_lock.task = current;
-	global_irq_lock.previous = where;
-#endif
-	global_irq_holder = cpu;
-	previous_irqholder = where;
-}
-
-void
-__global_cli(void)
-{
-	int cpu = smp_processor_id();
-	void *where = __builtin_return_address(0);
-
-	/*
-	 * Maximize ipl.  If ipl was previously 0 and if this thread
-	 * is not in an irq, then take global_irq_lock.
-	 */
-	if (swpipl(IPL_MAX) == IPL_MIN && !local_irq_count(cpu))
-		get_irqlock(cpu, where);
-}
-
-void
-__global_sti(void)
-{
-        int cpu = smp_processor_id();
-
-        if (!local_irq_count(cpu))
-		release_irqlock(cpu);
-	local_irq_enable();
-}
-
-/*
- * SMP flags value to restore to:
- * 0 - global cli
- * 1 - global sti
- * 2 - local cli
- * 3 - local sti
- */
-unsigned long
-__global_save_flags(void)
-{
-        int retval;
-        int local_enabled;
-        unsigned long flags;
-	int cpu = smp_processor_id();
-
-        local_save_flags(flags);
-        local_enabled = (!(flags & 7));
-        /* default to local */
-        retval = 2 + local_enabled;
-
-        /* Check for global flags if we're not in an interrupt.  */
-        if (!local_irq_count(cpu)) {
-                if (local_enabled)
-                        retval = 1;
-                if (global_irq_holder == cpu)
-                        retval = 0;
-	}
-	return retval;
-}
-
-void
-__global_restore_flags(unsigned long flags)
-{
-        switch (flags) {
-        case 0:
-                __global_cli();
-                break;
-        case 1:
-                __global_sti();
-                break;
-        case 2:
-                local_irq_disable();
-                break;
-        case 3:
-                local_irq_enable();
-                break;
-        default:
-                printk(KERN_ERR "global_restore_flags: %08lx (%p)\n",
-                        flags, __builtin_return_address(0));
-        }
-}
-
-/*
- * From its use, I infer that synchronize_irq() stalls a thread until
- * the effects of a command to an external device are known to have
- * taken hold.  Typically, the command is to stop sending interrupts.
- * The strategy here is wait until there is at most one processor
- * (this one) in an irq.  The memory barrier serializes the write to
- * the device and the subsequent accesses of global_irq_count.
- * --jmartin
- */
-#define DEBUG_SYNCHRONIZE_IRQ 0
-
-void
-synchronize_irq(void)
-{
-#if 0
-	/* Joe's version.  */
-	int cpu = smp_processor_id();
-	int local_count;
-	int global_count;
-	int countdown = 1<<24;
-	void *where = __builtin_return_address(0);
-
-	mb();
-	do {
-		local_count = local_irq_count(cpu);
-		global_count = atomic_read(&global_irq_count);
-		if (DEBUG_SYNCHRONIZE_IRQ && (--countdown == 0)) {
-			printk("%d:%d/%d\n", cpu, local_count, global_count);
-			show("synchronize_irq", where);
-			break;
-		}
-	} while (global_count != local_count);
-#else
-	/* Jay's version.  */
-	if (irqs_running()) {
-		cli();
-		sti();
-	}
-#endif
-}
--- 2.5.30/arch/alpha/kernel/alpha_ksyms.c	Sat Jun  1 00:56:25 2002
+++ linux/arch/alpha/kernel/alpha_ksyms.c	Sat Aug 10 01:24:08 2002
@@ -31,6 +31,8 @@
 #include <asm/machvec.h>
 #include <asm/pgalloc.h>
 #include <asm/semaphore.h>
+#include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
 
 #define __KERNEL_SYSCALLS__
 #include <asm/unistd.h>
@@ -213,15 +215,9 @@ EXPORT_SYMBOL(flush_tlb_range);
 EXPORT_SYMBOL(flush_tlb_page);
 EXPORT_SYMBOL(smp_imb);
 EXPORT_SYMBOL(cpu_data);
-EXPORT_SYMBOL(__cpu_number_map);
 EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(smp_call_function);
 EXPORT_SYMBOL(smp_call_function_on_cpu);
-EXPORT_SYMBOL(global_irq_holder);
-EXPORT_SYMBOL(__global_cli);
-EXPORT_SYMBOL(__global_sti);
-EXPORT_SYMBOL(__global_save_flags);
-EXPORT_SYMBOL(__global_restore_flags);
 EXPORT_SYMBOL(atomic_dec_and_lock);
 #ifdef CONFIG_DEBUG_SPINLOCK
 EXPORT_SYMBOL(spin_unlock);
--- 2.5.30/arch/alpha/kernel/irq.c	Sat Aug 10 01:20:59 2002
+++ linux/arch/alpha/kernel/irq.c	Sat Aug 10 01:24:08 2002
@@ -75,13 +75,7 @@ int
 handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
 		 struct irqaction *action)
 {
-	int status;
-	int cpu = smp_processor_id();
-
-	kstat.irqs[cpu][irq]++;
-	irq_enter(cpu, irq);
-
-	status = 1;	/* Force the "do bottom halves" bit */
+	int status = 1;	/* Force the "do bottom halves" bit */
 
 	do {
 		if (!(action->flags & SA_INTERRUPT))
@@ -97,8 +91,6 @@ handle_IRQ_event(unsigned int irq, struc
 		add_interrupt_randomness(irq);
 	local_irq_disable();
 
-	irq_exit(cpu, irq);
-
 	return status;
 }
 
@@ -130,12 +122,7 @@ void
 disable_irq(unsigned int irq)
 {
 	disable_irq_nosync(irq);
-
-	if (!local_irq_count(smp_processor_id())) {
-		do {
-			barrier();
-		} while (irq_desc[irq].status & IRQ_INPROGRESS);
-	}
+	synchronize_irq(irq);
 }
 
 void
@@ -602,7 +589,8 @@ handle_irq(int irq, struct pt_regs * reg
 		return;
 	}
 
-	irq_attempt(cpu, irq)++;
+	irq_enter();
+	kstat.irqs[cpu][irq]++;
 	spin_lock_irq(&desc->lock); /* mask also the higher prio events */
 	desc->handler->ack(irq);
 	/*
@@ -661,8 +649,7 @@ out:
 	desc->handler->end(irq);
 	spin_unlock(&desc->lock);
 
-	if (softirq_pending(cpu))
-		do_softirq();
+	irq_exit();
 }
 
 /*
@@ -694,7 +681,7 @@ probe_irq_on(void)
 
 	/* Wait for longstanding interrupts to trigger. */
 	for (delay = jiffies + HZ/50; time_after(delay, jiffies); )
-		/* about 20ms delay */ synchronize_irq();
+		/* about 20ms delay */ barrier();
 
 	/* enable any unassigned irqs (we must startup again here because
 	   if a longstanding irq happened in the previous stage, it may have
@@ -715,7 +702,7 @@ probe_irq_on(void)
 	 * Wait for spurious interrupts to trigger
 	 */
 	for (delay = jiffies + HZ/10; time_after(delay, jiffies); )
-		/* about 100ms delay */ synchronize_irq();
+		/* about 100ms delay */ barrier();
 
 	/*
 	 * Now filter out any obviously spurious interrupts
@@ -813,3 +800,15 @@ probe_irq_off(unsigned long val)
 		irq_found = -irq_found;
 	return irq_found;
 }
+
+#ifdef CONFIG_SMP
+void synchronize_irq(unsigned int irq)
+{
+        /* is there anything to synchronize with? */
+	if (!irq_desc[irq].action)
+		return;
+
+	while (irq_desc[irq].status & IRQ_INPROGRESS)
+		barrier();
+}
+#endif
