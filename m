Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268641AbUJDViW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268641AbUJDViW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268637AbUJDViB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:38:01 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27604 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268657AbUJDVek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:34:40 -0400
Date: Mon, 4 Oct 2004 23:35:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: annabellesgarden@yahoo.de, linux-kernel@vger.kernel.org
Subject: [patch, 2.6.9-rc3-mm2] preemption debugging
Message-ID: <20041004213553.GA14530@elte.hu>
References: <200410041634.24937.annabellesgarden@yahoo.de> <20041004122304.4f545f3c.akpm@osdl.org> <20041004122533.0a85a1ad.akpm@osdl.org> <20041004212633.GA13527@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004212633.GA13527@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > I'm suspecting that something is causing preempt_count() to overflow
> > into the softirq counter.  An imbalanced preempt_disable(), for
> > example.
> 
> yes, that was it. Must not put side-effects into a macro that is NOP
> on !SMP.

btw., this bug was particularly nasty costing me a couple of hours,
since it triggered in neigh_periodic_timer() and due to the softirq
count the mismatch didnt show only until much later in irq_exit() when
there was no trace of the timer context anymore. So i obviously first
suspected the IRQ changes ... To prevent similar bugs:

The patch below does quite extensive preempt-count debugging and catches
this bug (and others) right when they happen. It also consolidates
DEBUG_SMP_PROCESSOR_ID into DEBUG_PREEMPT. We might want to carry this
in -mm a bit?

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -2963,8 +2963,37 @@ static inline int dependent_idle(const r
 }
 #endif
 
-#if defined(CONFIG_PREEMPT) && defined(__smp_processor_id) && \
-				defined(CONFIG_DEBUG_SMP_PROCESSOR_ID)
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_DEBUG_PREEMPT)
+
+void fastcall add_preempt_count(int val)
+{
+	/*
+	 * Underflow?
+	 */
+	BUG_ON(((int)preempt_count() < 0));
+	preempt_count() += val;
+	/*
+	 * Spinlock count overflowing soon?
+	 */
+	BUG_ON((preempt_count() & PREEMPT_MASK) >= PREEMPT_MASK-10);
+}
+EXPORT_SYMBOL(add_preempt_count);
+
+void fastcall sub_preempt_count(int val)
+{
+	/*
+	 * Underflow?
+	 */
+	BUG_ON(val > preempt_count());
+	/*
+	 * Is the spinlock portion underflowing?
+	 */
+	BUG_ON((val < PREEMPT_MASK) && !(preempt_count() & PREEMPT_MASK));
+	preempt_count() -= val;
+}
+EXPORT_SYMBOL(sub_preempt_count);
+
+#ifdef __smp_processor_id
 /*
  * Debugging check.
  */
@@ -3015,7 +3044,9 @@ out:
 
 EXPORT_SYMBOL(smp_processor_id);
 
-#endif
+#endif /* __smp_processor_id */
+
+#endif /* PREEMPT && DEBUG_PREEMPT */
 
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 
@@ -3330,7 +3361,7 @@ asmlinkage void __sched preempt_schedule
 		return;
 
 need_resched:
-	preempt_count() += PREEMPT_ACTIVE;
+	add_preempt_count(PREEMPT_ACTIVE);
 	/*
 	 * We keep the big kernel semaphore locked, but we
 	 * clear ->lock_depth so that schedule() doesnt
@@ -3344,7 +3375,7 @@ need_resched:
 #ifdef CONFIG_PREEMPT_BKL
 	task->lock_depth = saved_lock_depth;
 #endif
-	preempt_count() -= PREEMPT_ACTIVE;
+	sub_preempt_count(PREEMPT_ACTIVE);
 
 	/* we could miss a preemption opportunity between schedule and now */
 	barrier();
@@ -4319,12 +4350,14 @@ asmlinkage long sys_sched_yield(void)
 
 static inline void __cond_resched(void)
 {
+
+
 	if (preempt_count() & PREEMPT_ACTIVE)
 		return;
 	do {
-		preempt_count() += PREEMPT_ACTIVE;
+		add_preempt_count(PREEMPT_ACTIVE);
 		schedule();
-		preempt_count() -= PREEMPT_ACTIVE;
+		sub_preempt_count(PREEMPT_ACTIVE);
 	} while (need_resched());
 }
 
--- linux/kernel/irq/handle.c.orig
+++ linux/kernel/irq/handle.c
@@ -77,7 +77,7 @@ irqreturn_t no_action(int cpl, void *dev
  */
 void irq_exit(void)
 {
-	preempt_count() -= IRQ_EXIT_OFFSET;
+	sub_preempt_count(IRQ_EXIT_OFFSET);
 	if (!in_interrupt() && local_softirq_pending())
 		do_softirq();
 	preempt_enable_no_resched();
--- linux/kernel/timer.c.orig
+++ linux/kernel/timer.c
@@ -465,7 +465,14 @@ repeat:
 			smp_wmb();
 			timer->base = NULL;
 			spin_unlock_irq(&base->lock);
-			fn(data);
+			{
+				u32 preempt_count = preempt_count();
+				fn(data);
+				if (preempt_count != preempt_count()) {
+					printk("huh, entered %p with %08x, exited with %08x?\n", fn, preempt_count, preempt_count());
+					BUG();
+				}
+			}
 			spin_lock_irq(&base->lock);
 			goto repeat;
 		}
--- linux/kernel/softirq.c.orig
+++ linux/kernel/softirq.c
@@ -142,7 +142,7 @@ void local_bh_enable(void)
 	 * Keep preemption disabled until we are done with
 	 * softirq processing:
  	 */
-	preempt_count() -= SOFTIRQ_OFFSET - 1;
+	sub_preempt_count(SOFTIRQ_OFFSET - 1);
 
 	if (unlikely(!in_interrupt() && local_softirq_pending()))
 		invoke_softirq();
--- linux/include/linux/interrupt.h.orig
+++ linux/include/linux/interrupt.h
@@ -70,9 +70,9 @@ extern void enable_irq(unsigned int irq)
 
 /* SoftIRQ primitives.  */
 #define local_bh_disable() \
-		do { preempt_count() += SOFTIRQ_OFFSET; barrier(); } while (0)
+		do { add_preempt_count(SOFTIRQ_OFFSET); barrier(); } while (0)
 #define __local_bh_enable() \
-		do { barrier(); preempt_count() -= SOFTIRQ_OFFSET; } while (0)
+		do { barrier(); sub_preempt_count(SOFTIRQ_OFFSET); } while (0)
 
 extern void local_bh_enable(void);
 
--- linux/include/linux/hardirq.h.orig
+++ linux/include/linux/hardirq.h
@@ -82,10 +82,10 @@ extern void synchronize_irq(unsigned int
 #endif
 
 #ifdef CONFIG_GENERIC_HARDIRQS
-#define nmi_enter()		(preempt_count() += HARDIRQ_OFFSET)
-#define nmi_exit()		(preempt_count() -= HARDIRQ_OFFSET)
 
-#define irq_enter()		(preempt_count() += HARDIRQ_OFFSET)
+#define irq_enter()		add_preempt_count(HARDIRQ_OFFSET)
+#define nmi_enter()		irq_enter()
+#define nmi_exit()		sub_preempt_count(HARDIRQ_OFFSET)
 extern void irq_exit(void);
 #endif
 
--- linux/include/linux/smp.h.orig
+++ linux/include/linux/smp.h
@@ -110,7 +110,7 @@ static inline void smp_send_reschedule(i
 #endif /* !SMP */
 
 #ifdef __smp_processor_id
-# if defined(CONFIG_PREEMPT) && defined(CONFIG_DEBUG_SMP_PROCESSOR_ID)
+# if defined(CONFIG_PREEMPT) && defined(CONFIG_DEBUG_PREEMPT)
   /*
    * temporary debugging check detecting places that use
    * smp_processor_id() in a potentially unsafe way:
--- linux/include/linux/preempt.h.orig
+++ linux/include/linux/preempt.h
@@ -9,17 +9,18 @@
 #include <linux/config.h>
 #include <linux/linkage.h>
 
-#define preempt_count()	(current_thread_info()->preempt_count)
+#ifdef CONFIG_DEBUG_PREEMPT
+  extern void fastcall add_preempt_count(int val);
+  extern void fastcall sub_preempt_count(int val);
+#else
+# define add_preempt_count(val)	do { preempt_count() += (val); } while (0)
+# define sub_preempt_count(val)	do { preempt_count() -= (val); } while (0)
+#endif
 
-#define inc_preempt_count() \
-do { \
-	preempt_count()++; \
-} while (0)
+#define inc_preempt_count() add_preempt_count(1)
+#define dec_preempt_count() sub_preempt_count(1)
 
-#define dec_preempt_count() \
-do { \
-	preempt_count()--; \
-} while (0)
+#define preempt_count()	(current_thread_info()->preempt_count)
 
 #ifdef CONFIG_PREEMPT
 
@@ -51,9 +52,15 @@ do { \
 
 #else
 
+#ifdef CONFIG_PREEMPT_TIMING
+#define preempt_disable()		inc_preempt_count()
+#define preempt_enable_no_resched()	dec_preempt_count()
+#define preempt_enable()		dec_preempt_count()
+#else
 #define preempt_disable()		do { } while (0)
 #define preempt_enable_no_resched()	do { } while (0)
 #define preempt_enable()		do { } while (0)
+#endif
 #define preempt_check_resched()		do { } while (0)
 
 #endif
--- linux/lib/Kconfig.debug.orig
+++ linux/lib/Kconfig.debug
@@ -52,14 +52,15 @@ config DEBUG_SPINLOCK_SLEEP
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.
 
-config DEBUG_SMP_PROCESSOR_ID
-	bool "Preempt-unsafe smp_processor_id() checking"
+config DEBUG_PREEMPT
+	bool "Debug preemptible kernel"
 	depends on PREEMPT && X86
 	default y
 	help
 	  If you say Y here then the kernel will use a debug variant of the
 	  commonly used smp_processor_id() function and will print warnings
-	  if kernel code uses it in a preemption-unsafe way.
+	  if kernel code uses it in a preemption-unsafe way. Also, the kernel
+	  will detect preemption count underflows.
 
 config DEBUG_HIGHMEM
 	bool "Highmem debugging"
