Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTIYRy0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbTIYRVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:21:03 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:45278 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261329AbTIYRR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:17:27 -0400
Date: Thu, 25 Sep 2003 19:16:40 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (4/19): micro optimizations.
Message-ID: <20030925171640.GE2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Put cpu number to lowcore.
 - Put percpu_offset to lowcore.
 - Put current pointer to lowcore.
 - Replace barrier() with cpu_relax().

diffstat:
 arch/s390/kernel/entry.S   |    3 ++-
 arch/s390/kernel/entry64.S |    3 ++-
 arch/s390/kernel/head.S    |    2 ++
 arch/s390/kernel/head64.S  |    3 +++
 arch/s390/kernel/setup.c   |   19 +++++++------------
 arch/s390/kernel/smp.c     |   15 ++++++++++-----
 arch/s390/lib/delay.c      |    5 +++--
 arch/s390/mm/fault.c       |    5 ++---
 include/asm-s390/current.h |   10 ++--------
 include/asm-s390/hardirq.h |   28 +++++++++++++++-------------
 include/asm-s390/lowcore.h |   12 ++++++++++--
 include/asm-s390/percpu.h  |    8 ++++++++
 include/asm-s390/smp.h     |    2 +-
 13 files changed, 67 insertions(+), 48 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Thu Sep 25 18:33:22 2003
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Thu Sep 25 18:33:24 2003
@@ -141,7 +141,8 @@
 	stam    %a4,%a4,__THREAD_ar4(%r2)	# store kernel access reg. 4
 	lam     %a2,%a2,__THREAD_ar2(%r3)	# load kernel access reg. 2
 	lam     %a4,%a4,__THREAD_ar4(%r3)	# load kernel access reg. 4
-	lm	%r6,%r15,24(%r15)	# load resume registers of next task
+	lm	%r6,%r15,24(%r15)	# load __switch_to registers of next task
+	st	%r3,__LC_CURRENT	# __LC_CURRENT = current task struct
 	l	%r3,__THREAD_info(%r3)  # load thread_info from task struct
 	ahi	%r3,8192
 	st	%r3,__LC_KERNEL_STACK	# __LC_KERNEL_STACK = new kernel stack
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Thu Sep 25 18:33:22 2003
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Thu Sep 25 18:33:24 2003
@@ -127,7 +127,8 @@
         stam    %a4,%a4,__THREAD_ar4(%r2)	# store kernel access reg. 4
         lam     %a2,%a2,__THREAD_ar2(%r3)	# load kernel access reg. 2
         lam     %a4,%a4,__THREAD_ar4(%r3)	# load kernel access reg. 4
-        lmg     %r6,%r15,48(%r15)       # load resume registers of next task
+        lmg     %r6,%r15,48(%r15)       # load __switch_to registers of next task
+	stg	%r3,__LC_CURRENT	# __LC_CURRENT = current task struct
 	lg	%r3,__THREAD_info(%r3)  # load thread_info from task struct
 	aghi	%r3,16384
 	stg	%r3,__LC_KERNEL_STACK	# __LC_KERNEL_STACK = new kernel stack
diff -urN linux-2.6/arch/s390/kernel/head.S linux-2.6-s390/arch/s390/kernel/head.S
--- linux-2.6/arch/s390/kernel/head.S	Mon Sep  8 21:49:58 2003
+++ linux-2.6-s390/arch/s390/kernel/head.S	Thu Sep 25 18:33:24 2003
@@ -30,6 +30,7 @@
 #include <linux/config.h>
 #include <asm/setup.h>
 #include <asm/lowcore.h>
+#include <asm/offsets.h>
 
 #ifndef CONFIG_IPL
         .org   0
@@ -633,6 +634,7 @@
 # Setup stack
 #
         l     %r15,.Linittu-.LPG2(%r13)
+	mvc   __LC_CURRENT(4),__TI_task(%r15)
         ahi   %r15,8192                 # init_task_union + 8192
         st    %r15,__LC_KERNEL_STACK    # set end of kernel stack
         ahi   %r15,-96
diff -urN linux-2.6/arch/s390/kernel/head64.S linux-2.6-s390/arch/s390/kernel/head64.S
--- linux-2.6/arch/s390/kernel/head64.S	Mon Sep  8 21:50:01 2003
+++ linux-2.6-s390/arch/s390/kernel/head64.S	Thu Sep 25 18:33:24 2003
@@ -30,6 +30,7 @@
 #include <linux/config.h>
 #include <asm/setup.h>
 #include <asm/lowcore.h>
+#include <asm/offsets.h>
 
 #ifndef CONFIG_IPL
         .org   0
@@ -642,6 +643,8 @@
 # Setup stack
 #
 	larl  %r15,init_thread_union
+	lg    %r14,__TI_task(%r15)      # cache current in lowcore
+	stg   %r14,__LC_CURRENT
         aghi  %r15,16384                # init_task_union + 16384
         stg   %r15,__LC_KERNEL_STACK    # set end of kernel stack
         aghi  %r15,-160
diff -urN linux-2.6/arch/s390/kernel/setup.c linux-2.6-s390/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	Mon Sep  8 21:49:52 2003
+++ linux-2.6-s390/arch/s390/kernel/setup.c	Thu Sep 25 18:33:24 2003
@@ -97,7 +97,6 @@
          */
         asm volatile ("stidp %0": "=m" (S390_lowcore.cpu_data.cpu_id));
         S390_lowcore.cpu_data.cpu_addr = addr;
-        S390_lowcore.cpu_data.cpu_nr = nr;
 
         /*
          * Force FPU initialization:
@@ -418,7 +417,7 @@
 	 * we are rounding upwards:
 	 */
 	start_pfn = (__pa(&_end) + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	end_pfn = memory_end >> PAGE_SHIFT;
+	end_pfn = max_pfn = memory_end >> PAGE_SHIFT;
 
 	/*
 	 * Initialize the boot-time allocator (with low memory only):
@@ -497,21 +496,17 @@
 	lc->io_new_psw.addr = PSW_ADDR_AMODE + (unsigned long) io_int_handler;
 	lc->ipl_device = S390_lowcore.ipl_device;
 	lc->jiffy_timer = -1LL;
-#ifndef CONFIG_ARCH_S390X
-	lc->kernel_stack = ((__u32) &init_thread_union) + 8192;
-	lc->async_stack = (__u32)
-		__alloc_bootmem(2*PAGE_SIZE, 2*PAGE_SIZE, 0) + 8192;
-	set_prefix((__u32) lc);
-#else /* CONFIG_ARCH_S390X */
-	lc->kernel_stack = ((__u64) &init_thread_union) + 16384;
-	lc->async_stack = (__u64)
-		__alloc_bootmem(4*PAGE_SIZE, 4*PAGE_SIZE, 0) + 16384;
+	lc->kernel_stack = ((unsigned long) &init_thread_union) + THREAD_SIZE;
+	lc->async_stack = (unsigned long)
+		__alloc_bootmem(ASYNC_SIZE, ASYNC_SIZE, 0) + ASYNC_SIZE;
+	lc->current_task = (unsigned long) init_thread_union.thread_info.task;
+#ifdef CONFIG_ARCH_S390X
 	if (MACHINE_HAS_DIAG44)
 		lc->diag44_opcode = 0x83000044;
 	else
 		lc->diag44_opcode = 0x07000700;
-	set_prefix((__u32)(__u64) lc);
 #endif /* CONFIG_ARCH_S390X */
+	set_prefix((u32)(unsigned long) lc);
         cpu_init();
         __cpu_logical_map[0] = S390_lowcore.cpu_data.cpu_addr;
 
diff -urN linux-2.6/arch/s390/kernel/smp.c linux-2.6-s390/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	Thu Sep 25 18:33:22 2003
+++ linux-2.6-s390/arch/s390/kernel/smp.c	Thu Sep 25 18:33:24 2003
@@ -138,11 +138,11 @@
 
 	/* Wait for response */
 	while (atomic_read(&data.started) != cpus)
-		barrier();
+		cpu_relax();
 
 	if (wait)
 		while (atomic_read(&data.finished) != cpus)
-			barrier();
+			cpu_relax();
 	spin_unlock(&call_lock);
 
 	return 0;
@@ -207,7 +207,8 @@
 	cpu_clear(smp_processor_id(), cpu_restart_map);
 	if (smp_processor_id() == 0) {
 		/* Wait for all other cpus to enter do_machine_restart. */
-		while (!cpus_empty(cpu_restart_map));
+		while (!cpus_empty(cpu_restart_map))
+			cpu_relax();
 		/* Store status of other cpus. */
 		do_store_status();
 		/*
@@ -524,8 +525,11 @@
 	__asm__ __volatile__("stam  0,15,0(%0)"
 			     : : "a" (&cpu_lowcore->access_regs_save_area)
 			     : "memory");
-        eieio();
-        signal_processor(cpu,sigp_restart);
+	cpu_lowcore->percpu_offset = __per_cpu_offset[cpu];
+        cpu_lowcore->current_task = (unsigned long) idle;
+        cpu_lowcore->cpu_data.cpu_nr = cpu;
+	eieio();
+	signal_processor(cpu,sigp_restart);
 
 	while (!cpu_online(cpu));
 	return 0;
@@ -570,6 +574,7 @@
 {
 	cpu_set(smp_processor_id(), cpu_online_map);
 	cpu_set(smp_processor_id(), cpu_possible_map);
+	S390_lowcore.percpu_offset = __per_cpu_offset[smp_processor_id()];
 }
 
 void smp_cpus_done(unsigned int max_cpus)
diff -urN linux-2.6/arch/s390/lib/delay.c linux-2.6-s390/arch/s390/lib/delay.c
--- linux-2.6/arch/s390/lib/delay.c	Mon Sep  8 21:49:59 2003
+++ linux-2.6-s390/arch/s390/lib/delay.c	Thu Sep 25 18:33:24 2003
@@ -34,7 +34,8 @@
 }
 
 /*
- * Waits for 'usecs' microseconds using the tod clock
+ * Waits for 'usecs' microseconds using the tod clock, giving up the time slice
+ * of the virtual PU inbetween to avoid congestion.
  */
 void __udelay(unsigned long usecs)
 {
@@ -44,7 +45,7 @@
                 return;
         asm volatile ("STCK %0" : "=m" (start_cc));
         do {
+		cpu_relax();
                 asm volatile ("STCK %0" : "=m" (end_cc));
         } while (((end_cc - start_cc)/4096) < usecs);
 }
-
diff -urN linux-2.6/arch/s390/mm/fault.c linux-2.6-s390/arch/s390/mm/fault.c
--- linux-2.6/arch/s390/mm/fault.c	Mon Sep  8 21:50:21 2003
+++ linux-2.6-s390/arch/s390/mm/fault.c	Thu Sep 25 18:33:24 2003
@@ -488,7 +488,7 @@
 int pfault_init(void)
 {
 	pfault_refbk_t refbk =
-		{ 0x258, 0, 5, 2, __LC_KERNEL_STACK, 1ULL << 48, 1ULL << 48,
+		{ 0x258, 0, 5, 2, __LC_CURRENT, 1ULL << 48, 1ULL << 48,
 		  __PF_RES_FIELD };
         int rc;
 
@@ -555,8 +555,7 @@
 	/*
 	 * Get the token (= address of kernel stack of affected task).
 	 */
-	tsk = (struct task_struct *)
-		(*((unsigned long *) __LC_PFAULT_INTPARM) - THREAD_SIZE);
+	tsk = *(struct task_struct **) __LC_PFAULT_INTPARM;
 
 	/*
 	 * We got all needed information from the lowcore and can
diff -urN linux-2.6/include/asm-s390/current.h linux-2.6-s390/include/asm-s390/current.h
--- linux-2.6/include/asm-s390/current.h	Mon Sep  8 21:50:32 2003
+++ linux-2.6-s390/include/asm-s390/current.h	Thu Sep 25 18:33:24 2003
@@ -12,17 +12,11 @@
 #define _S390_CURRENT_H
 
 #ifdef __KERNEL__
-
-#include <linux/thread_info.h>
+#include <asm/lowcore.h>
 
 struct task_struct;
 
-static inline struct task_struct * get_current(void)
-{
-	return current_thread_info()->task;
-}
-
-#define current get_current()
+#define current ((struct task_struct *const)S390_lowcore.current_task)
 
 #endif
 
diff -urN linux-2.6/include/asm-s390/hardirq.h linux-2.6-s390/include/asm-s390/hardirq.h
--- linux-2.6/include/asm-s390/hardirq.h	Mon Sep  8 21:50:43 2003
+++ linux-2.6-s390/include/asm-s390/hardirq.h	Thu Sep 25 18:33:24 2003
@@ -18,14 +18,17 @@
 #include <linux/cache.h>
 #include <asm/lowcore.h>
 
-/* entry.S is sensitive to the offsets of these fields */
+/* irq_cpustat_t is unused currently, but could be converted
+ * into a percpu variable instead of storing softirq_pending
+ * on the lowcore */
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int __syscall_count;
-	struct task_struct * __ksoftirqd_task; /* waitqueue is too large */
-} ____cacheline_aligned irq_cpustat_t;
+} irq_cpustat_t;
 
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
+#define softirq_pending(cpu) (lowcore_ptr[(cpu)]->softirq_pending)
+#define local_softirq_pending() (S390_lowcore.softirq_pending)
+
+#define __ARCH_IRQ_STAT
 
 /*
  * We put the hardirq and softirq counter into the preemption
@@ -76,7 +79,12 @@
 #define hardirq_trylock()	(!in_interrupt())
 #define hardirq_endlock()	do { } while (0)
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
+#define irq_enter()							\
+do {									\
+	BUG_ON( hardirq_count() );					\
+	(preempt_count() += HARDIRQ_OFFSET);				\
+} while(0)
+	
 
 extern void do_call_softirq(void);
 
@@ -93,16 +101,10 @@
 #define irq_exit()							\
 do {									\
 	preempt_count() -= IRQ_EXIT_OFFSET;				\
-	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
+	if (!in_interrupt() && local_softirq_pending())			\
 		/* Use the async. stack for softirq */			\
 		do_call_softirq();					\
 	preempt_enable_no_resched();					\
 } while (0)
 
-#ifndef CONFIG_SMP
-# define synchronize_irq(irq)	barrier()
-#else
-  extern void synchronize_irq(unsigned int irq);
-#endif /* CONFIG_SMP */
-
 #endif /* __ASM_HARDIRQ_H */
diff -urN linux-2.6/include/asm-s390/lowcore.h linux-2.6-s390/include/asm-s390/lowcore.h
--- linux-2.6/include/asm-s390/lowcore.h	Mon Sep  8 21:50:04 2003
+++ linux-2.6-s390/include/asm-s390/lowcore.h	Thu Sep 25 18:33:24 2003
@@ -65,6 +65,7 @@
 #define __LC_CPUADDR                    0xC68
 #define __LC_IPLDEV                     0xC7C
 #define __LC_JIFFY_TIMER		0xC80
+#define __LC_CURRENT			0xC90
 #else /* __s390x__ */
 #define __LC_KERNEL_STACK               0xD40
 #define __LC_ASYNC_STACK                0xD48
@@ -72,6 +73,7 @@
 #define __LC_CPUADDR                    0xD98
 #define __LC_IPLDEV                     0xDB8
 #define __LC_JIFFY_TIMER		0xDC0
+#define __LC_CURRENT			0xDD8
 #endif /* __s390x__ */
 
 #define __LC_PANIC_MAGIC                0xE00
@@ -169,7 +171,10 @@
         /* SMP info area: defined by DJB */
         __u64        jiffy_timer;              /* 0xc80 */
 	__u32        ext_call_fast;            /* 0xc88 */
-        __u8         pad11[0xe00-0xc8c];       /* 0xc8c */
+	__u32        percpu_offset;            /* 0xc8c */
+	__u32        current_task;	       /* 0xc90 */
+	__u32        softirq_pending;	       /* 0xc94 */
+        __u8         pad11[0xe00-0xc98];       /* 0xc98 */
 
         /* 0xe00 is used as indicator for dump tools */
         /* whether the kernel died with panic() or not */
@@ -244,7 +249,10 @@
         /* SMP info area: defined by DJB */
         __u64        jiffy_timer;              /* 0xdc0 */
 	__u64        ext_call_fast;            /* 0xdc8 */
-        __u8         pad12[0xe00-0xdd0];       /* 0xdd0 */
+	__u64        percpu_offset;            /* 0xdd0 */
+	__u64        current_task;	       /* 0xdd8 */
+	__u64        softirq_pending;	       /* 0xde0 */
+        __u8         pad12[0xe00-0xde8];       /* 0xde8 */
 
         /* 0xe00 is used as indicator for dump tools */
         /* whether the kernel died with panic() or not */
diff -urN linux-2.6/include/asm-s390/percpu.h linux-2.6-s390/include/asm-s390/percpu.h
--- linux-2.6/include/asm-s390/percpu.h	Mon Sep  8 21:50:32 2003
+++ linux-2.6-s390/include/asm-s390/percpu.h	Thu Sep 25 18:33:24 2003
@@ -2,5 +2,13 @@
 #define __ARCH_S390_PERCPU__
 
 #include <asm-generic/percpu.h>
+#include <asm/lowcore.h>
+
+/*
+ * s390 uses the generic implementation for per cpu data, with the exception that
+ * the offset of the cpu local data area is cached in the cpu's lowcore memory
+ */
+#undef __get_cpu_var
+#define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, S390_lowcore.percpu_offset))
 
 #endif /* __ARCH_S390_PERCPU__ */
diff -urN linux-2.6/include/asm-s390/smp.h linux-2.6-s390/include/asm-s390/smp.h
--- linux-2.6/include/asm-s390/smp.h	Mon Sep  8 21:50:06 2003
+++ linux-2.6-s390/include/asm-s390/smp.h	Thu Sep 25 18:33:24 2003
@@ -46,7 +46,7 @@
  
 #define PROC_CHANGE_PENALTY	20		/* Schedule penalty */
 
-#define smp_processor_id() (current_thread_info()->cpu)
+#define smp_processor_id() (S390_lowcore.cpu_data.cpu_nr)
 
 #define cpu_online(cpu) cpu_isset(cpu, cpu_online_map)
 #define cpu_possible(cpu) cpu_isset(cpu, cpu_possible_map)
