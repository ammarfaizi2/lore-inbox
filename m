Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVELIjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVELIjL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 04:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVELIjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 04:39:11 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:35259 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261338AbVELIhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 04:37:36 -0400
Date: Thu, 12 May 2005 14:08:19 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: schwidefsky@de.ibm.com, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] (How to) Let idle CPUs sleep
Message-ID: <20050512083819.GC17644@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050507182728.GA29592@in.ibm.com> <1115524211.17482.23.camel@localhost.localdomain> <427D921F.8070602@yahoo.com.au> <20050508121932.GA3055@in.ibm.com> <427F02CE.7080108@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <427F02CE.7080108@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 04:27:26PM +1000, Nick Piggin wrote:
> I could probably find some time to do my implementation if you have
> a complete working patch for eg. UML.

Well, turns out that if we restrict the amount of time idle cpus are 
allowed to sleep, then there is very little change reqd in the scheduler.
Most of the calculation of exponential sleep times can be done outside
it (in the idle CPU's code).

First, the scheduler support to zero cpu_load[] counters before idle
cpu sleeps.

---

 linux-2.6.12-rc3-mm3-vatsa/include/linux/sched.h |    1 
 linux-2.6.12-rc3-mm3-vatsa/kernel/sched.c        |   33 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff -puN kernel/sched.c~sched-nohz kernel/sched.c
--- linux-2.6.12-rc3-mm3/kernel/sched.c~sched-nohz	2005-05-11 17:05:13.000000000 +0530
+++ linux-2.6.12-rc3-mm3-vatsa/kernel/sched.c	2005-05-11 17:06:38.000000000 +0530
@@ -2323,6 +2323,39 @@ static void rebalance_tick(int this_cpu,
 		}
 	}
 }
+
+#ifdef CONFIG_NO_IDLE_HZ
+/*
+ * Try hard to pull tasks. Called by idle task before it sleeps cutting off
+ * local timer ticks.  This clears the various load counters and tries to pull
+ * tasks.
+ *
+ * Returns 1 if tasks were pulled over, 0 otherwise.
+ */
+int idle_balance_retry(void)
+{
+	int j, moved = 0, this_cpu = smp_processor_id();
+	runqueue_t *this_rq = this_rq();
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	for (j = 0; j < 3; j++)
+		this_rq->cpu_load[j] = 0;
+
+	rebalance_tick(this_cpu, this_rq, SCHED_IDLE);
+
+	if (this_rq->nr_running) {
+		moved = 1;
+		set_tsk_need_resched(current);
+	}
+
+	local_irq_restore(flags);
+
+	return moved;
+}
+#endif
+
 #else
 /*
  * on UP we do not need to balance between CPUs:
diff -puN include/linux/sched.h~sched-nohz include/linux/sched.h
--- linux-2.6.12-rc3-mm3/include/linux/sched.h~sched-nohz	2005-05-11 17:05:13.000000000 +0530
+++ linux-2.6.12-rc3-mm3-vatsa/include/linux/sched.h	2005-05-11 17:13:19.000000000 +0530
@@ -897,6 +897,7 @@ extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, struct sched_param *);
 extern task_t *idle_task(int cpu);
+extern int idle_balance_retry(void);
 
 void yield(void);
 

_


A sample patch that implements exponential sleep time is below. Note that this 
patch only makes idle cpu pretend as if it is asleep (instead of really cutting
of timer ticks). I used this merely to test the scheduler change.

Martin,
	You probably need something like this for S390 arch!



---

 linux-2.6.12-rc3-mm3-vatsa/arch/i386/Kconfig          |    4 +
 linux-2.6.12-rc3-mm3-vatsa/arch/i386/kernel/apic.c    |   16 ++++--
 linux-2.6.12-rc3-mm3-vatsa/arch/i386/kernel/irq.c     |    4 +
 linux-2.6.12-rc3-mm3-vatsa/arch/i386/kernel/process.c |   47 ++++++++++++++++--
 linux-2.6.12-rc3-mm3-vatsa/arch/i386/kernel/smp.c     |    6 ++
 5 files changed, 69 insertions(+), 8 deletions(-)

diff -puN arch/i386/Kconfig~vst-sim arch/i386/Kconfig
--- linux-2.6.12-rc3-mm3/arch/i386/Kconfig~vst-sim	2005-05-10 15:53:33.000000000 +0530
+++ linux-2.6.12-rc3-mm3-vatsa/arch/i386/Kconfig	2005-05-10 15:54:22.000000000 +0530
@@ -443,6 +443,10 @@ config X86_OOSTORE
 	depends on (MWINCHIP3D || MWINCHIP2 || MWINCHIPC6) && MTRR
 	default y
 
+config NO_IDLE_HZ
+        bool "Tickless Idle CPUs support"
+        default n
+
 config HPET_TIMER
 	bool "HPET Timer Support"
 	help
diff -puN arch/i386/kernel/process.c~vst-sim arch/i386/kernel/process.c
--- linux-2.6.12-rc3-mm3/arch/i386/kernel/process.c~vst-sim	2005-05-10 15:53:34.000000000 +0530
+++ linux-2.6.12-rc3-mm3-vatsa/arch/i386/kernel/process.c	2005-05-12 14:06:16.000000000 +0530
@@ -94,6 +94,12 @@ void enable_hlt(void)
 
 EXPORT_SYMBOL(enable_hlt);
 
+DEFINE_PER_CPU(int, idle_asleep);
+DEFINE_PER_CPU(unsigned long, sleep_duration);
+
+#define MAX_SLEEP_DURATION 	128	/* in tick counts */
+#define MIN_SLEEP_DURATION	8	/* in tick counts */
+
 /*
  * We use this if we don't have any better
  * idle routine..
@@ -102,8 +108,36 @@ void default_idle(void)
 {
 	if (!hlt_counter && boot_cpu_data.hlt_works_ok) {
 		local_irq_disable();
-		if (!need_resched())
-			safe_halt();
+		if (!need_resched()) {
+			unsigned long jif_next, jif_delta;
+
+			jif_next = next_timer_interrupt();
+			jif_delta = jif_next - jiffies;
+
+			if (jif_delta > MIN_SLEEP_DURATION) {
+				unsigned long slpint;
+
+				if (idle_balance_retry()) {
+					local_irq_enable();
+					return;
+				}
+
+				slpint = min(__get_cpu_var(sleep_duration),
+					     jif_delta);
+
+				jif_next = jiffies + slpint;
+				/* Hack to discard local timer ticks */
+				__get_cpu_var(idle_asleep) = 1;
+				cpu_set(smp_processor_id(), nohz_cpu_mask);
+				local_irq_enable();
+				while ((jiffies < jif_next-1) &&
+					 __get_cpu_var(idle_asleep))
+					cpu_relax();
+				__get_cpu_var(idle_asleep) = 0;
+				cpu_clear(smp_processor_id(), nohz_cpu_mask);
+			} else
+				safe_halt();
+		}
 		else
 			local_irq_enable();
 	} else {
@@ -178,6 +212,8 @@ void cpu_idle(void)
 {
 	int cpu = _smp_processor_id();
 
+	__get_cpu_var(sleep_duration) = MIN_SLEEP_DURATION;
+
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
@@ -189,7 +225,7 @@ void cpu_idle(void)
 			rmb();
 			idle = pm_idle;
 
-			if (!idle)
+			//if (!idle)
 				idle = default_idle;
 
 			if (cpu_is_offline(cpu))
@@ -197,7 +233,12 @@ void cpu_idle(void)
 
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 			idle();
+
+			if (__get_cpu_var(sleep_duration) < MAX_SLEEP_DURATION)
+				__get_cpu_var(sleep_duration) *= 2;
+
 		}
+		__get_cpu_var(sleep_duration) = MIN_SLEEP_DURATION;
 		schedule();
 	}
 }
diff -puN arch/i386/kernel/irq.c~vst-sim arch/i386/kernel/irq.c
--- linux-2.6.12-rc3-mm3/arch/i386/kernel/irq.c~vst-sim	2005-05-10 15:53:34.000000000 +0530
+++ linux-2.6.12-rc3-mm3-vatsa/arch/i386/kernel/irq.c	2005-05-10 15:53:47.000000000 +0530
@@ -46,6 +46,8 @@ static union irq_ctx *hardirq_ctx[NR_CPU
 static union irq_ctx *softirq_ctx[NR_CPUS];
 #endif
 
+DECLARE_PER_CPU(int, idle_asleep);
+
 /*
  * do_IRQ handles all normal device IRQ's (the special
  * SMP cross-CPU interrupts have their own specific
@@ -60,6 +62,8 @@ fastcall unsigned int do_IRQ(struct pt_r
 	u32 *isp;
 #endif
 
+	__get_cpu_var(idle_asleep) = 0;
+
 	irq_enter();
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 1KB free? */
diff -puN arch/i386/kernel/smp.c~vst-sim arch/i386/kernel/smp.c
--- linux-2.6.12-rc3-mm3/arch/i386/kernel/smp.c~vst-sim	2005-05-11 16:59:38.000000000 +0530
+++ linux-2.6.12-rc3-mm3-vatsa/arch/i386/kernel/smp.c	2005-05-11 16:59:58.000000000 +0530
@@ -309,6 +309,8 @@ static inline void leave_mm (unsigned lo
  * 2) Leave the mm if we are in the lazy tlb mode.
  */
 
+DECLARE_PER_CPU(int, idle_asleep);
+
 fastcall void smp_invalidate_interrupt(struct pt_regs *regs)
 {
 	unsigned long cpu;
@@ -336,6 +338,7 @@ fastcall void smp_invalidate_interrupt(s
 			leave_mm(cpu);
 	}
 	ack_APIC_irq();
+	__get_cpu_var(idle_asleep) = 0;
 	smp_mb__before_clear_bit();
 	cpu_clear(cpu, flush_cpumask);
 	smp_mb__after_clear_bit();
@@ -598,6 +601,8 @@ void smp_send_stop(void)
 fastcall void smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
+
+	__get_cpu_var(idle_asleep) = 0;
 }
 
 fastcall void smp_call_function_interrupt(struct pt_regs *regs)
@@ -607,6 +612,7 @@ fastcall void smp_call_function_interrup
 	int wait = call_data->wait;
 
 	ack_APIC_irq();
+	__get_cpu_var(idle_asleep) = 0;
 	/*
 	 * Notify initiating CPU that I've grabbed the data and am
 	 * about to execute the function
diff -puN arch/i386/kernel/apic.c~vst-sim arch/i386/kernel/apic.c
--- linux-2.6.12-rc3-mm3/arch/i386/kernel/apic.c~vst-sim	2005-05-10 15:53:36.000000000 +0530
+++ linux-2.6.12-rc3-mm3-vatsa/arch/i386/kernel/apic.c	2005-05-10 15:53:47.000000000 +0530
@@ -1171,6 +1171,8 @@ inline void smp_local_timer_interrupt(st
 	 */
 }
 
+DECLARE_PER_CPU(int, idle_asleep);
+
 /*
  * Local APIC timer interrupt. This is the most natural way for doing
  * local interrupts, but local timer interrupts can be emulated by
@@ -1185,15 +1187,19 @@ fastcall void smp_apic_timer_interrupt(s
 	int cpu = smp_processor_id();
 
 	/*
-	 * the NMI deadlock-detector uses this.
-	 */
-	per_cpu(irq_stat, cpu).apic_timer_irqs++;
-
-	/*
 	 * NOTE! We'd better ACK the irq immediately,
 	 * because timer handling can be slow.
 	 */
 	ack_APIC_irq();
+
+	if (__get_cpu_var(idle_asleep))
+		return;
+
+	/*
+	 * the NMI deadlock-detector uses this.
+	 */
+	per_cpu(irq_stat, cpu).apic_timer_irqs++;
+
 	/*
 	 * update_process_times() expects us to have done irq_enter().
 	 * Besides, if we don't timer interrupts ignore the global

_
-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
