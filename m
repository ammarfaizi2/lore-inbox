Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265314AbUGMPGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265314AbUGMPGx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 11:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbUGMPGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 11:06:53 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:38903 "EHLO
	kartuli.timesys") by vger.kernel.org with ESMTP id S265314AbUGMPGJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 11:06:09 -0400
Message-ID: <40F3FA53.2010907@timesys.com>
Date: Tue, 13 Jul 2004 11:05:55 -0400
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Joe Korty <joe.korty@ccur.com>, linux-kernel@vger.kernel.org,
       Greg Weeks <greg.weeks@timesys.com>, Scott Wood <scott@timesys.com>
Subject: Re: preempt-timing-2.6.8-rc1
References: <20040713122805.GZ21066@holomorphy.com> <20040713143600.GA22758@tsunami.ccur.com> <20040713144028.GH21066@holomorphy.com>
In-Reply-To: <20040713144028.GH21066@holomorphy.com>
Content-Type: multipart/mixed;
 boundary="------------010701000908080102080500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010701000908080102080500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

William Lee Irwin III wrote:

>On Tue, Jul 13, 2004 at 05:28:05AM -0700, William Lee Irwin III wrote:
>  
>
>>>This patch uses the preemption counter increments and decrements to time
>>>non-preemptible critical sections.
>>>This is an instrumentation patch intended to help determine the causes of
>>>scheduling latency related to long non-preemptible critical sections.
>>>Changes from 2.6.7-based patch:
>>>(1) fix unmap_vmas() check correctly this time
>>>(2) add touch_preempt_timing() to cond_resched_lock()
>>>(3) depend on preempt until it's worked out wtf goes wrong without it
>>>      
>>>
>
>On Tue, Jul 13, 2004 at 10:36:00AM -0400, Joe Korty wrote:
>  
>
>>You preemption-block hold times will improve *enormously* if you move all
>>softirq processing down to the daemon (and possibly raise the daemon to
>>one of the higher SCHED_RR priorities, to compensate for softirq processing
>>no longer happening at interrupt level).
>>    
>>
>
>Plausible. Got a patch?
>  
>

How about this?  It moves softirqs to a thread but keeps the old spill 
thread.

This is a patch against 2.6.6 written primarily by Scott Wood.

Signed-off-by: La Monte H.P. Yarroll <piggy@timesys.com> under TS0058

-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell's sig


--------------010701000908080102080500
Content-Type: text/x-patch;
 name="softirq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="softirq.patch"

--- linux-orig/include/asm-alpha/hardirq.h
+++ linux/include/asm-alpha/hardirq.h
@@ -86,14 +86,18 @@
 #define in_atomic()	(preempt_count() != 0)
 #define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 # endif
-#define irq_exit()						\
-do {								\
-		preempt_count() -= IRQ_EXIT_OFFSET;		\
-		if (!in_interrupt() &&				\
-		    softirq_pending(smp_processor_id()))	\
-			do_softirq();				\
-		preempt_enable_no_resched();			\
+
+#ifndef CONFIG_SOFTIRQ_THREADS
+#define irq_exit()							\
+do {									\
+		preempt_count() -= IRQ_EXIT_OFFSET;			\
+		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+			do_softirq();					\
+		preempt_enable_no_resched();				\
 } while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #ifndef CONFIG_SMP
 # define synchronize_irq(irq)	barrier()
--- linux-orig/include/asm-arm/hardirq.h
+++ linux/include/asm-arm/hardirq.h
@@ -81,6 +81,7 @@
 
 extern asmlinkage void __do_softirq(void);
 
+#ifndef CONFIG_SOFTIRQ_THREADS
 #define irq_exit()							\
 	do {								\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -88,6 +89,9 @@
 			__do_softirq();					\
 		preempt_enable_no_resched();				\
 	} while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #define synchronize_irq(irq)	barrier()
 #else
--- linux-orig/include/asm-arm26/hardirq.h
+++ linux/include/asm-arm26/hardirq.h
@@ -76,6 +76,8 @@
 #endif
 
 #ifndef CONFIG_SMP
+
+#ifndef CONFIG_SOFTIRQ_THREADS
 #define irq_exit()							\
 	do {								\
 		preempt_count() -= HARDIRQ_OFFSET;			\
@@ -83,6 +85,9 @@
 			__asm__("bl%? __do_softirq": : : "lr");/* out of line */\
 		preempt_enable_no_resched();				\
 	} while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #define synchronize_irq(irq)	barrier()
 #else
--- linux-orig/include/asm-cris/hardirq.h
+++ linux/include/asm-cris/hardirq.h
@@ -84,6 +84,9 @@
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
+
+
+#ifndef CONFIG_SOFTIRQ_THREADS
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -91,6 +94,9 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #define synchronize_irq(irq)	barrier()
 
--- linux-orig/include/asm-h8300/hardirq.h
+++ linux/include/asm-h8300/hardirq.h
@@ -82,6 +82,8 @@
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
 
+
+#ifndef CONFIG_SOFTIRQ_THREADS
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -89,6 +91,9 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #ifndef CONFIG_SMP
 # define synchronize_irq(irq)	barrier()
--- linux-orig/include/asm-i386/hardirq.h
+++ linux/include/asm-i386/hardirq.h
@@ -84,6 +84,8 @@
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
+
+#ifndef CONFIG_SOFTIRQ_THREADS
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -91,6 +93,9 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #ifndef CONFIG_SMP
 # define synchronize_irq(irq)	barrier()
--- linux-orig/include/asm-m68k/hardirq.h
+++ linux/include/asm-m68k/hardirq.h
@@ -78,6 +78,8 @@
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
+
+#ifndef CONFIG_SOFTIRQ_THREADS
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -85,6 +87,9 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #define synchronize_irq(irq)	barrier()
 
--- linux-orig/include/asm-m68knommu/hardirq.h
+++ linux/include/asm-m68knommu/hardirq.h
@@ -86,6 +86,7 @@
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
 
+#ifndef CONFIG_SOFTIRQ_THREADS
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -93,6 +94,9 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #ifndef CONFIG_SMP
 # define synchronize_irq(irq)	barrier()
--- linux-orig/include/asm-mips/hardirq.h
+++ linux/include/asm-mips/hardirq.h
@@ -87,13 +87,18 @@
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
-#define irq_exit()                                                     \
-do {                                                                   \
-	preempt_count() -= IRQ_EXIT_OFFSET;                     \
-	if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-		do_softirq();                                   \
-	preempt_enable_no_resched();                            \
+
+#ifndef CONFIG_SOFTIRQ_THREADS
+#define irq_exit()							\
+do {									\
+	preempt_count() -= IRQ_EXIT_OFFSET;				\
+	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
+		do_softirq();						\
+	preempt_enable_no_resched();					\
 } while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #ifndef CONFIG_SMP
 # define synchronize_irq(irq)	barrier()
--- linux-orig/include/asm-parisc/hardirq.h
+++ linux/include/asm-parisc/hardirq.h
@@ -96,13 +96,17 @@
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
 
-#define irq_exit()								\
-do {										\
-		preempt_count() -= IRQ_EXIT_OFFSET;				\
-		if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
-			do_softirq();						\
-		preempt_enable_no_resched();					\
+#ifndef CONFIG_SOFTIRQ_THREADS
+#define irq_exit()							\
+do {									\
+		preempt_count() -= IRQ_EXIT_OFFSET;			\
+		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+			do_softirq();					\
+		preempt_enable_no_resched();				\
 } while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #ifdef CONFIG_SMP
   extern void synchronize_irq (unsigned int irq);
--- linux-orig/include/asm-ppc/hardirq.h
+++ linux/include/asm-ppc/hardirq.h
@@ -88,13 +88,18 @@
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
+
+#ifndef CONFIG_SOFTIRQ_THREADS
 #define irq_exit()							\
-do {									\
+do {                                                                    \
 	preempt_count() -= IRQ_EXIT_OFFSET;				\
 	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
 		do_softirq();						\
 	preempt_enable_no_resched();					\
 } while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #ifndef CONFIG_SMP
 # define synchronize_irq(irq)	barrier()
--- linux-orig/include/asm-ppc64/hardirq.h
+++ linux/include/asm-ppc64/hardirq.h
@@ -87,6 +87,8 @@
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
+
+#ifndef CONFIG_SOFTIRQ_THREADS
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -94,6 +96,9 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #ifndef CONFIG_SMP
 # define synchronize_irq(irq)	barrier()
--- linux-orig/include/asm-sh/hardirq.h
+++ linux/include/asm-sh/hardirq.h
@@ -81,6 +81,8 @@
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
+
+#ifndef CONFIG_SOFTIRQ_THREADS
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -88,6 +90,9 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #ifndef CONFIG_SMP
 # define synchronize_irq(irq)	barrier()
--- linux-orig/include/asm-sparc/hardirq.h
+++ linux/include/asm-sparc/hardirq.h
@@ -87,13 +87,18 @@
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
-#define irq_exit()                                                      \
-do {                                                                    \
-                preempt_count() -= IRQ_EXIT_OFFSET;                     \
-                if (!in_interrupt() && softirq_pending(smp_processor_id())) \
-                        do_softirq();                                   \
-                preempt_enable_no_resched();                            \
+
+#ifndef CONFIG_SOFTIRQ_THREADS
+#define irq_exit()							\
+do {									\
+		preempt_count() -= IRQ_EXIT_OFFSET;			\
+		if (!in_interrupt() && softirq_pending(smp_processor_id())) \
+			do_softirq();					\
+		preempt_enable_no_resched();				\
 } while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #ifndef CONFIG_SMP
 # define synchronize_irq(irq)	barrier()
--- linux-orig/include/asm-sparc64/hardirq.h
+++ linux/include/asm-sparc64/hardirq.h
@@ -86,6 +86,8 @@
 # define in_atomic()	(preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
+
+#ifndef CONFIG_SOFTIRQ_THREADS
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -93,6 +95,9 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #ifndef CONFIG_SMP
 # define synchronize_irq(irq)	barrier()
--- linux-orig/include/asm-v850/hardirq.h
+++ linux/include/asm-v850/hardirq.h
@@ -80,13 +80,17 @@
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
 
-#define irq_exit()							      \
-do {									      \
-	preempt_count() -= IRQ_EXIT_OFFSET;				      \
-	if (!in_interrupt() && softirq_pending(smp_processor_id()))	      \
-		do_softirq();						      \
-	preempt_enable_no_resched();					      \
+#ifndef CONFIG_SOFTIRQ_THREADS
+#define irq_exit()							\
+do {									\
+	preempt_count() -= IRQ_EXIT_OFFSET;				\
+	if (!in_interrupt() && softirq_pending(smp_processor_id()))	\
+		do_softirq();						\
+	preempt_enable_no_resched();					\
 } while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #ifndef CONFIG_SMP
 # define synchronize_irq(irq)	barrier()
--- linux-orig/include/asm-x86_64/hardirq.h
+++ linux/include/asm-x86_64/hardirq.h
@@ -85,6 +85,8 @@
 # define in_atomic()   (preempt_count() != 0)
 # define IRQ_EXIT_OFFSET HARDIRQ_OFFSET
 #endif
+
+#ifndef CONFIG_SOFTIRQ_THREADS
 #define irq_exit()							\
 do {									\
 		preempt_count() -= IRQ_EXIT_OFFSET;			\
@@ -92,6 +94,9 @@
 			do_softirq();					\
 		preempt_enable_no_resched();				\
 } while (0)
+#else
+#define irq_exit()              (preempt_count() -= HARDIRQ_OFFSET)
+#endif
 
 #ifndef CONFIG_SMP
 # define synchronize_irq(irq)	barrier()
--- linux-orig/include/linux/interrupt.h
+++ linux/include/linux/interrupt.h
@@ -59,6 +59,8 @@
 #endif
 
 /* SoftIRQ primitives.  */
+#ifndef CONFIG_SOFTIRQ_THREADS
+
 #define local_bh_disable() \
 		do { preempt_count() += SOFTIRQ_OFFSET; barrier(); } while (0)
 #define __local_bh_enable() \
@@ -66,6 +68,27 @@
 
 extern void local_bh_enable(void);
 
+#else
+
+/* As far as I can tell, local_bh_disable() didn't stop ksoftirqd
+   from running before.  Since all softirqs now run from one of
+   the ksoftirqds, this shouldn't be necessary. */
+
+static inline void local_bh_disable(void)
+{
+}
+
+static inline void __local_bh_enable(void)
+{
+}
+
+static inline void local_bh_enable(void)
+{
+}
+
+#endif
+
+
 /* PLEASE, avoid to allocate new softirqs, if you need not _really_ high
    frequency threaded job scheduling. For almost all the purposes
    tasklets are more than enough. F.e. all serial device BHs et
--- linux-orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -541,6 +541,11 @@
 #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 
+/* Thread is an IRQ handler.  This is used to determine which softirq
+   thread to wake. */
+
+#define PF_IRQHANDLER 0x10000000
+
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
 #else
@@ -916,6 +921,9 @@
 
 extern void signal_wake_up(struct task_struct *t, int resume_stopped);
 
+asmlinkage long sys_sched_setscheduler(pid_t pid, int policy,
+                                       struct sched_param __user *param);
+
 /*
  * Wrappers for p->thread_info->cpu access. No-op on UP.
  */
--- linux-orig/init/Kconfig
+++ linux/init/Kconfig
@@ -265,6 +265,18 @@
 
 	  If unsure, say N.
 
+config SOFTIRQ_THREADS
+	bool "Run all softirqs in threads"
+	depends on PREEMPT
+	help
+	  This option creates a second softirq thread per CPU, which
+	  runs at high real-time priority, to replace the softirqs
+	  which were previously run immediately.  This allows these
+	  softirqs to be prioritized, so as to avoid preempting
+	  very high priority real-time tasks.  This also allows
+	  certain spinlocks to be converted into sleeping mutexes,
+	  for futher reduction of scheduling latency.
+
 endmenu		# General setup
 
 
--- linux-orig/kernel/softirq.c
+++ linux/kernel/softirq.c
@@ -15,6 +15,11 @@
 #include <linux/percpu.h>
 #include <linux/cpu.h>
 #include <linux/kthread.h>
+#include <asm/uaccess.h>
+ 
+#ifdef CONFIG_SOFTIRQ_THREADS
+static const int softirq_prio = MAX_USER_RT_PRIO - 3;
+#endif
 
 #include <asm/irq.h>
 /*
@@ -44,6 +49,10 @@
 
 static DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
 
+#ifdef CONFIG_SOFTIRQ_THREADS
+static DEFINE_PER_CPU(struct task_struct *, ksoftirqd_high_prio);
+#endif
+
 /*
  * we cannot loop indefinitely here to avoid userspace starvation,
  * but we also don't want to introduce a worst case 1/HZ latency
@@ -59,6 +68,19 @@
 		wake_up_process(tsk);
 }
 
+#ifdef CONFIG_SOFTIRQ_THREADS
+
+static inline void wakeup_softirqd_high_prio(void)
+{
+	/* Interrupts are disabled: no need to stop preemption */
+	struct task_struct *tsk = __get_cpu_var(ksoftirqd_high_prio);
+
+	if (tsk && tsk->state != TASK_RUNNING)
+		wake_up_process(tsk);
+}
+
+#endif
+
 /*
  * We restart softirq processing MAX_SOFTIRQ_RESTART times,
  * and we fall back to softirqd after that.
@@ -113,8 +135,13 @@
 	__u32 pending;
 	unsigned long flags;
 
+#ifdef CONFIG_SOFTIRQ_THREADS
+	if (in_interrupt())
+		BUG();
+#else
 	if (in_interrupt())
 		return;
+#endif
 
 	local_irq_save(flags);
 
@@ -130,17 +157,20 @@
 
 #endif
 
+#ifndef CONFIG_SOFTIRQ_THREADS
+
 void local_bh_enable(void)
 {
 	__local_bh_enable();
 	WARN_ON(irqs_disabled());
-	if (unlikely(!in_interrupt() &&
-		     local_softirq_pending()))
+	if (unlikely(!in_interrupt() && local_softirq_pending()))
 		invoke_softirq();
 	preempt_check_resched();
 }
 EXPORT_SYMBOL(local_bh_enable);
 
+#endif
+
 /*
  * This function must run with irqs disabled!
  */
@@ -157,8 +187,19 @@
 	 * Otherwise we wake up ksoftirqd to make sure we
 	 * schedule the softirq soon.
 	 */
+#ifdef CONFIG_SOFTIRQ_THREADS
+
+	if (in_interrupt() || (current->flags & PF_IRQHANDLER))
+		wakeup_softirqd_high_prio();
+	else
+		wakeup_softirqd();
+
+#else
+
 	if (!in_interrupt())
 		wakeup_softirqd();
+
+#endif
 }
 
 EXPORT_SYMBOL(raise_softirq_irqoff);
@@ -320,6 +361,47 @@
 	open_softirq(HI_SOFTIRQ, tasklet_hi_action, NULL);
 }
 
+#ifdef CONFIG_SOFTIRQ_THREADS
+ 
+static int ksoftirqd_high_prio(void *__bind_cpu)
+{
+	int cpu = (int)(long)__bind_cpu;
+	struct sched_param param = { .sched_priority = softirq_prio };
+
+	/* Yuck.  Thanks for separating the implementation from the
+	   user API. */
+
+	set_fs(KERNEL_DS);
+	sys_sched_setscheduler(0, SCHED_FIFO, &param);
+	
+	current->flags |= PF_NOFREEZE;
+
+	/* Migrate to the right CPU */
+	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+	BUG_ON(smp_processor_id() != cpu);
+
+	__set_current_state(TASK_INTERRUPTIBLE);
+	mb();
+
+	__get_cpu_var(ksoftirqd_high_prio) = current;
+
+	for (;;) {
+		if (!local_softirq_pending())
+			schedule();
+
+		__set_current_state(TASK_RUNNING);
+
+		while (local_softirq_pending()) {
+ 			do_softirq();
+			cond_resched();
+		}
+
+		__set_current_state(TASK_INTERRUPTIBLE);
+	}
+}
+
+#endif
+
 static int ksoftirqd(void * __bind_cpu)
 {
 	set_user_nice(current, 19);
@@ -425,15 +507,28 @@
 	case CPU_UP_PREPARE:
 		BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
 		BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
-		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
+		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/l%d", hotcpu);
 		if (IS_ERR(p)) {
-			printk("ksoftirqd for %i failed\n", hotcpu);
+			printk("ksoftirqd/l%i failed\n", hotcpu);
 			return NOTIFY_BAD;
 		}
 		kthread_bind(p, hotcpu);
   		per_cpu(ksoftirqd, hotcpu) = p;
+#ifdef CONFIG_SOFTIRQ_THREADS
+		p = kthread_create(ksoftirqd_high_prio, hcpu, "ksoftirqd/h%d", hotcpu);
+		if (IS_ERR(p)) {
+			printk("ksoftirqd/h%i failed\n", hotcpu);
+			return NOTIFY_BAD;
+		}
+		per_cpu(ksoftirqd_high_prio, hotcpu) = p;
+		kthread_bind(p, hotcpu);
+  		per_cpu(ksoftirqd_high_prio, hotcpu) = p;
+#endif
  		break;
 	case CPU_ONLINE:
+#ifdef CONFIG_SOFTIRQ_THREADS
+		wake_up_process(per_cpu(ksoftirqd_high_prio, hotcpu));
+#endif
 		wake_up_process(per_cpu(ksoftirqd, hotcpu));
 		break;
 #ifdef CONFIG_HOTPLUG_CPU
--- linux-orig/kernel/timer.c
+++ linux/kernel/timer.c
@@ -910,12 +910,16 @@
 void do_timer(struct pt_regs *regs)
 {
 	jiffies_64++;
+	update_times();
+
 #ifndef CONFIG_SMP
 	/* SMP process accounting uses the local APIC timer */
 
+	// Do this after update_times(), so that the softirq thread
+	// is not counted as running all the time.
+
 	update_process_times(user_mode(regs));
 #endif
-	update_times();
 }
 
 #if !defined(__alpha__) && !defined(__ia64__)
--- linux-orig/mm/slab.c
+++ linux/mm/slab.c
@@ -2593,7 +2593,7 @@
 {
 	struct list_head *walk;
 
-#if DEBUG
+#if DEBUG && !defined(CONFIG_SOFTIRQ_THREADS)
 	BUG_ON(!in_interrupt());
 	BUG_ON(in_irq());
 #endif
--- linux-orig/net/ipv4/ipconfig.c
+++ linux/net/ipv4/ipconfig.c
@@ -1085,8 +1085,13 @@
 
 		jiff = jiffies + (d->next ? CONF_INTER_TIMEOUT : timeout);
 		while (time_before(jiffies, jiff) && !ic_got_reply) {
-			barrier();
-			cpu_relax();
+			// Wait queues are apparently too hard
+			// for the ipconfig people, but we
+			// need to drop the BKL here to allow
+			// preemption.
+			
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(1);
 		}
 #ifdef IPCONFIG_DHCP
 		/* DHCP isn't done until we get a DHCPACK. */

--------------010701000908080102080500--
