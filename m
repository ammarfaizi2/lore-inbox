Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVEPEYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVEPEYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 00:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVEPEYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 00:24:12 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:61329 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261329AbVEPEWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 00:22:05 -0400
Message-ID: <42881FE2.2000302@yahoo.com.au>
Date: Mon, 16 May 2005 14:21:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>, linux-ia64@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] improve SMP reschedule and idle routines
Content-Type: multipart/mixed;
 boundary="------------010008090205060201020909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010008090205060201020909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This has so far been ported to and tested on i386, x86_64,
ppc64, ia64. I've done an untested hack for sparc64 too.

Unfortunately the change will have to touch all architectures,
but fortunately the above ones are among the more complex.

This patch improves cross CPU rescheduling performance, and
idle reschedule performance by a significant amount on the
systems I've tested on (SMP G5, quad McKinley, SMP+HT P4 Xeon)
in microbenchmarks.

I bet it could give a measurable boost on real workloads on
some systems too. And I think it is a good cleanup in general.

Comments?

-- 
SUSE Labs, Novell Inc.

--------------010008090205060201020909
Content-Type: text/plain;
 name="sched-resched-opt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-resched-opt.patch"

Make some changes to the NEED_RESCHED and POLLING_NRFLAG to reduce
confusion, and make their semantics rigid. Also have preempt explicitly
disabled in idle routines. Improves efficiency of resched_task and some
cpu_idle routines.

* In resched_task:
- TIF_NEED_RESCHED is only cleared with the task's runqueue lock held,
  and as we hold it during resched_task, then there is no need for an
  atomic test and set there. (The only time this may prevent an IPI is
  when the task's quantum expires in the timer interrupt - this is a
  very rare race to bother with in comparison with the cost).

- If TIF_NEED_RESCHED is set, then we don't need to do anything. It
  won't get unset until the task get's schedule()d off.

- If we are running on the same CPU as the task we resched, then set
  TIF_NEED_RESCHED and no further action is required.

- If we are running on another CPU, and TIF_POLLING_NRFLAG is *not* set
  after TIF_NEED_RESCHED has been set, then we need to send an IPI.

Using these rules, we are able to remove the test and set operation in
resched_task, and make clear the previously vague semantics of POLLING_NRFLAG.

* In idle routines:
- Enter cpu_idle with preempt disabled. When the need_resched() condition
  becomes true, explicitly call schedule(). This makes things a bit clearer
  (IMO), but haven't updated all architectures yet.

- Many do a test and clear of TIF_NEED_RESCHED for some reason. According
  to the resched_task rules, this isn't needed (and actually breaks the
  assumption that TIF_NEED_RESCHED is only cleared with the runqueue lock
  held). So remove that. Generally one less locked memory op when switching
  to the idle thread.

- Many idle routines clear TIF_POLLING_NRFLAG, and only set it in the inner
  most polling idle loops. The above resched_task semantics allow it to be
  set until before the last time need_resched() is checked before going into
  a halt requiring interrupt wakeup.

  Many idle routines simply never enter such a halt, and so POLLING_NRFLAG
  can be always left set, completely eliminating resched IPIs when rescheduling
  the idle task.

  POLLING_NRFLAG width can be increased, to reduce the chance of resched IPIs.

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-05-16 13:51:42.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-05-16 13:52:16.000000000 +1000
@@ -805,21 +805,28 @@ static void deactivate_task(struct task_
 #ifdef CONFIG_SMP
 static void resched_task(task_t *p)
 {
-	int need_resched, nrpolling;
+	int cpu;
 
 	assert_spin_locked(&task_rq(p)->lock);
 
-	/* minimise the chance of sending an interrupt to poll_idle() */
-	nrpolling = test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
-	need_resched = test_and_set_tsk_thread_flag(p,TIF_NEED_RESCHED);
-	nrpolling |= test_tsk_thread_flag(p,TIF_POLLING_NRFLAG);
+	if (test_tsk_thread_flag(p, TIF_NEED_RESCHED))
+		return;
+	
+	set_tsk_thread_flag(p, TIF_NEED_RESCHED);
+
+	cpu = task_cpu(p);
+	if (cpu == smp_processor_id())
+		return;
 
-	if (!need_resched && !nrpolling && (task_cpu(p) != smp_processor_id()))
-		smp_send_reschedule(task_cpu(p));
+	/* NEED_RESCHED must be visible before we test POLLING_NRFLAG */
+	smp_mb();
+	if (!test_tsk_thread_flag(p, TIF_POLLING_NRFLAG))
+		smp_send_reschedule(cpu);
 }
 #else
 static inline void resched_task(task_t *p)
 {
+	assert_spin_locked(&task_rq(p)->lock);
 	set_tsk_need_resched(p);
 }
 #endif
Index: linux-2.6/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/process.c	2005-05-16 13:50:52.000000000 +1000
+++ linux-2.6/arch/i386/kernel/process.c	2005-05-16 13:52:16.000000000 +1000
@@ -95,14 +95,19 @@ EXPORT_SYMBOL(enable_hlt);
  */
 void default_idle(void)
 {
+	local_irq_enable();
+
 	if (!hlt_counter && boot_cpu_data.hlt_works_ok) {
-		local_irq_disable();
-		if (!need_resched())
+		clear_thread_flag(TIF_POLLING_NRFLAG);
+		smp_mb__after_clear_bit();
+		while (!need_resched()) {
+			local_irq_disable();
 			safe_halt();
-		else
-			local_irq_enable();
+		}
+		set_thread_flag(TIF_POLLING_NRFLAG);
 	} else {
-		cpu_relax();
+		while (!need_resched())
+			cpu_relax();
 	}
 }
 
@@ -113,29 +118,14 @@ void default_idle(void)
  */
 static void poll_idle (void)
 {
-	int oldval;
-
 	local_irq_enable();
 
-	/*
-	 * Deal with another CPU just having chosen a thread to
-	 * run here:
-	 */
-	oldval = test_and_clear_thread_flag(TIF_NEED_RESCHED);
-
-	if (!oldval) {
-		set_thread_flag(TIF_POLLING_NRFLAG);
-		asm volatile(
-			"2:"
-			"testl %0, %1;"
-			"rep; nop;"
-			"je 2b;"
-			: : "i"(_TIF_NEED_RESCHED), "m" (current_thread_info()->flags));
-
-		clear_thread_flag(TIF_POLLING_NRFLAG);
-	} else {
-		set_need_resched();
-	}
+	asm volatile(
+		"2:"
+		"testl %0, %1;"
+		"rep; nop;"
+		"je 2b;"
+		: : "i"(_TIF_NEED_RESCHED), "m" (current_thread_info()->flags));
 }
 
 /*
@@ -146,24 +136,27 @@ static void poll_idle (void)
  */
 void cpu_idle (void)
 {
+	set_thread_flag(TIF_POLLING_NRFLAG);
+	
 	/* endless idle loop with no priority at all */
 	while (1) {
-		while (!need_resched()) {
-			void (*idle)(void);
+		void (*idle)(void);
 
-			if (__get_cpu_var(cpu_idle_state))
-				__get_cpu_var(cpu_idle_state) = 0;
+		if (__get_cpu_var(cpu_idle_state))
+			__get_cpu_var(cpu_idle_state) = 0;
 
-			rmb();
-			idle = pm_idle;
+		rmb();
+		idle = pm_idle;
 
-			if (!idle)
-				idle = default_idle;
+		if (!idle)
+			idle = default_idle;
 
-			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
-			idle();
-		}
+		__get_cpu_var(irq_stat).idle_timestamp = jiffies;
+		idle();
+
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
@@ -206,15 +199,12 @@ static void mwait_idle(void)
 {
 	local_irq_enable();
 
-	if (!need_resched()) {
-		set_thread_flag(TIF_POLLING_NRFLAG);
-		do {
-			__monitor((void *)&current_thread_info()->flags, 0, 0);
-			if (need_resched())
-				break;
-			__mwait(0, 0);
-		} while (!need_resched());
-		clear_thread_flag(TIF_POLLING_NRFLAG);
+	while (!need_resched()) {
+		__monitor((void *)&current_thread_info()->flags, 0, 0);
+		smp_mb();
+		if (need_resched())
+			break;
+		__mwait(0, 0);
 	}
 }
 
Index: linux-2.6/init/main.c
===================================================================
--- linux-2.6.orig/init/main.c	2005-05-16 13:49:23.000000000 +1000
+++ linux-2.6/init/main.c	2005-05-16 13:52:16.000000000 +1000
@@ -382,7 +382,7 @@ static void noinline rest_init(void)
 	kernel_thread(init, NULL, CLONE_FS | CLONE_SIGHAND);
 	numa_default_policy();
 	unlock_kernel();
-	preempt_enable_no_resched();
+	/* Don't re-enable preemption */
 	cpu_idle();
 } 
 
Index: linux-2.6/arch/i386/kernel/apm.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/apm.c	2005-05-16 13:49:23.000000000 +1000
+++ linux-2.6/arch/i386/kernel/apm.c	2005-05-16 13:52:16.000000000 +1000
@@ -767,8 +767,20 @@ static int set_system_power_state(u_shor
 static int apm_do_idle(void)
 {
 	u32	eax;
+	u8	ret;
+	int	idled = 0;
 
-	if (apm_bios_call_simple(APM_FUNC_IDLE, 0, 0, &eax)) {
+	clear_thread_flag(TIF_POLLING_NRFLAG);
+	smp_mb__after_clear_bit();
+	if (!need_resched()) {
+		idled = 1;
+		ret = apm_bios_call_simple(APM_FUNC_IDLE, 0, 0, &eax);
+	}
+	set_thread_flag(TIF_POLLING_NRFLAG);
+	if (!idled)
+		return 0;
+
+	if (ret) {
 		static unsigned long t;
 
 		/* This always fails on some SMP boards running UP kernels.
Index: linux-2.6/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.orig/drivers/acpi/processor_idle.c	2005-05-16 13:50:53.000000000 +1000
+++ linux-2.6/drivers/acpi/processor_idle.c	2005-05-16 13:52:16.000000000 +1000
@@ -162,6 +162,14 @@ acpi_processor_power_activate (
 	return;
 }
 
+static void acpi_safe_halt (void)
+{
+	clear_thread_flag(TIF_POLLING_NRFLAG);
+	smp_mb__after_clear_bit();
+	while (!need_resched())
+		safe_halt();
+	set_thread_flag(TIF_POLLING_NRFLAG);
+}
 
 static void acpi_processor_idle (void)
 {
@@ -171,7 +179,7 @@ static void acpi_processor_idle (void)
 	int			sleep_ticks = 0;
 	u32			t1, t2 = 0;
 
-	pr = processors[_smp_processor_id()];
+	pr = processors[smp_processor_id()];
 	if (!pr)
 		return;
 
@@ -191,8 +199,13 @@ static void acpi_processor_idle (void)
 	}
 
 	cx = pr->power.state;
-	if (!cx)
-		goto easy_out;
+	if (!cx) {
+		if (pm_idle_save)
+			pm_idle_save();
+		else
+			acpi_safe_halt();
+		return;
+	}
 
 	/*
 	 * Check BM Activity
@@ -272,7 +285,8 @@ static void acpi_processor_idle (void)
 		if (pm_idle_save)
 			pm_idle_save();
 		else
-			safe_halt();
+			acpi_safe_halt();
+
 		/*
                  * TBD: Can't get time duration while in C1, as resumes
 		 *      go to an ISR rather than here.  Need to instrument
@@ -384,16 +398,6 @@ end:
 	 */
 	if (next_state != pr->power.state)
 		acpi_processor_power_activate(pr, next_state);
-
-	return;
-
- easy_out:
-	/* do C1 instead of busy loop */
-	if (pm_idle_save)
-		pm_idle_save();
-	else
-		safe_halt();
-	return;
 }
 
 
Index: linux-2.6/arch/i386/kernel/smpboot.c
===================================================================
--- linux-2.6.orig/arch/i386/kernel/smpboot.c	2005-05-16 13:50:52.000000000 +1000
+++ linux-2.6/arch/i386/kernel/smpboot.c	2005-05-16 13:52:16.000000000 +1000
@@ -416,6 +416,8 @@ static int cpucount;
  */
 static void __init start_secondary(void *unused)
 {
+	preempt_disable();
+
 	/*
 	 * Dont put anything before smp_callin(), SMP
 	 * booting is too fragile that we want to limit the
Index: linux-2.6/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/x86_64/kernel/process.c	2005-05-16 13:50:53.000000000 +1000
+++ linux-2.6/arch/x86_64/kernel/process.c	2005-05-16 13:52:16.000000000 +1000
@@ -84,12 +84,19 @@ EXPORT_SYMBOL(enable_hlt);
  */
 void default_idle(void)
 {
+	local_irq_enable();
+
 	if (!atomic_read(&hlt_counter)) {
-		local_irq_disable();
-		if (!need_resched())
+		clear_thread_flag(TIF_POLLING_NRFLAG);
+		smp_mb__after_clear_bit();
+		while (!need_resched()) {
+			local_irq_disable();
 			safe_halt();
-		else
-			local_irq_enable();
+		}
+		set_thread_flag(TIF_POLLING_NRFLAG);
+	} else {
+		while (!need_resched())
+			cpu_relax();
 	}
 }
 
@@ -100,29 +107,16 @@ void default_idle(void)
  */
 static void poll_idle (void)
 {
-	int oldval;
-
 	local_irq_enable();
 
-	/*
-	 * Deal with another CPU just having chosen a thread to
-	 * run here:
-	 */
-	oldval = test_and_clear_thread_flag(TIF_NEED_RESCHED);
-
-	if (!oldval) {
-		set_thread_flag(TIF_POLLING_NRFLAG); 
-		asm volatile(
-			"2:"
-			"testl %0,%1;"
-			"rep; nop;"
-			"je 2b;"
-			: :
-			"i" (_TIF_NEED_RESCHED), 
-			"m" (current_thread_info()->flags));
-	} else {
-		set_need_resched();
-	}
+	asm volatile(
+		"2:"
+		"testl %0,%1;"
+		"rep; nop;"
+		"je 2b;"
+		: :
+		"i" (_TIF_NEED_RESCHED), 
+		"m" (current_thread_info()->flags));
 }
 
 void cpu_idle_wait(void)
@@ -161,22 +155,25 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
  */
 void cpu_idle (void)
 {
+	set_thread_flag(TIF_POLLING_NRFLAG);
+
 	/* endless idle loop with no priority at all */
 	while (1) {
-		while (!need_resched()) {
-			void (*idle)(void);
+		void (*idle)(void);
 
-			if (__get_cpu_var(cpu_idle_state))
-				__get_cpu_var(cpu_idle_state) = 0;
+		if (__get_cpu_var(cpu_idle_state))
+			__get_cpu_var(cpu_idle_state) = 0;
 
-			rmb();
-			idle = pm_idle;
-			if (!idle)
-				idle = default_idle;
-			idle();
-		}
+		rmb();
+		idle = pm_idle;
+		if (!idle)
+			idle = default_idle;
+
+		idle();
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
@@ -191,15 +188,12 @@ static void mwait_idle(void)
 {
 	local_irq_enable();
 
-	if (!need_resched()) {
-		set_thread_flag(TIF_POLLING_NRFLAG);
-		do {
-			__monitor((void *)&current_thread_info()->flags, 0, 0);
-			if (need_resched())
-				break;
-			__mwait(0, 0);
-		} while (!need_resched());
-		clear_thread_flag(TIF_POLLING_NRFLAG);
+	while (!need_resched()) {
+		__monitor((void *)&current_thread_info()->flags, 0, 0);
+		smp_mb();
+		if (need_resched())
+			break;
+		__mwait(0, 0);
 	}
 }
 
Index: linux-2.6/arch/ppc64/kernel/idle.c
===================================================================
--- linux-2.6.orig/arch/ppc64/kernel/idle.c	2005-05-16 13:49:23.000000000 +1000
+++ linux-2.6/arch/ppc64/kernel/idle.c	2005-05-16 13:52:16.000000000 +1000
@@ -74,9 +74,10 @@ static void yield_shared_processor(void)
 static int iSeries_idle(void)
 {
 	struct paca_struct *lpaca;
-	long oldval;
 	unsigned long CTRL;
 
+	set_thread_flag(TIF_POLLING_NRFLAG);
+
 	/* ensure iSeries run light will be out when idle */
 	clear_thread_flag(TIF_RUN_LIGHT);
 	CTRL = mfspr(CTRLF);
@@ -86,32 +87,21 @@ static int iSeries_idle(void)
 	lpaca = get_paca();
 
 	while (1) {
-		if (lpaca->lppaca.shared_proc) {
-			if (ItLpQueue_isLpIntPending(lpaca->lpqueue_ptr))
-				process_iSeries_events();
-			if (!need_resched())
-				yield_shared_processor();
-		} else {
-			oldval = test_and_clear_thread_flag(TIF_NEED_RESCHED);
-
-			if (!oldval) {
-				set_thread_flag(TIF_POLLING_NRFLAG);
-
-				while (!need_resched()) {
-					HMT_medium();
-					if (ItLpQueue_isLpIntPending(lpaca->lpqueue_ptr))
-						process_iSeries_events();
-					HMT_low();
-				}
-
+		while (!need_resched()) {
+			HMT_low();
+			if (ItLpQueue_isLpIntPending(lpaca->lpqueue_ptr)) {
 				HMT_medium();
-				clear_thread_flag(TIF_POLLING_NRFLAG);
-			} else {
-				set_need_resched();
+				process_iSeries_events();
+				HMT_low();
 			}
+			if (lpaca->lppaca.shared_proc)
+				yield_shared_processor();
 		}
+		HMT_medium();
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 
 	return 0;
@@ -121,32 +111,24 @@ static int iSeries_idle(void)
 
 static int default_idle(void)
 {
-	long oldval;
 	unsigned int cpu = smp_processor_id();
-
+	set_thread_flag(TIF_POLLING_NRFLAG);
+	
 	while (1) {
-		oldval = test_and_clear_thread_flag(TIF_NEED_RESCHED);
-
-		if (!oldval) {
-			set_thread_flag(TIF_POLLING_NRFLAG);
-
-			while (!need_resched() && !cpu_is_offline(cpu)) {
-				barrier();
-				/*
-				 * Go into low thread priority and possibly
-				 * low power mode.
-				 */
-				HMT_low();
-				HMT_very_low();
-			}
-
-			HMT_medium();
-			clear_thread_flag(TIF_POLLING_NRFLAG);
-		} else {
-			set_need_resched();
+		while (!need_resched() && !cpu_is_offline(cpu)) {
+			barrier();
+			/*
+			 * Go into low thread priority and possibly
+			 * low power mode.
+			 */
+			HMT_low();
+			HMT_very_low();
 		}
+		HMT_medium();
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
 			cpu_die();
 	}
@@ -160,12 +142,12 @@ DECLARE_PER_CPU(unsigned long, smt_snooz
 
 int dedicated_idle(void)
 {
-	long oldval;
 	struct paca_struct *lpaca = get_paca(), *ppaca;
 	unsigned long start_snooze;
 	unsigned long *smt_snooze_delay = &__get_cpu_var(smt_snooze_delay);
 	unsigned int cpu = smp_processor_id();
 
+	set_thread_flag(TIF_POLLING_NRFLAG);
 	ppaca = &paca[cpu ^ 1];
 
 	while (1) {
@@ -175,66 +157,67 @@ int dedicated_idle(void)
 		 */
 		lpaca->lppaca.idle = 1;
 
-		oldval = test_and_clear_thread_flag(TIF_NEED_RESCHED);
-		if (!oldval) {
-			set_thread_flag(TIF_POLLING_NRFLAG);
-			start_snooze = __get_tb() +
+		start_snooze = __get_tb() +
 				*smt_snooze_delay * tb_ticks_per_usec;
-			while (!need_resched() && !cpu_is_offline(cpu)) {
-				/*
-				 * Go into low thread priority and possibly
-				 * low power mode.
-				 */
-				HMT_low();
-				HMT_very_low();
 
-				if (*smt_snooze_delay == 0 ||
-				    __get_tb() < start_snooze)
-					continue;
+		while (!need_resched() && !cpu_is_offline(cpu)) {
+			/*
+			 * Go into low thread priority and possibly
+			 * low power mode.
+			 */
+			HMT_low();
+			HMT_very_low();
 
-				HMT_medium();
+			if (*smt_snooze_delay == 0 || __get_tb() < start_snooze)
+				continue;
 
-				if (!(ppaca->lppaca.idle)) {
-					local_irq_disable();
+			HMT_medium();
 
-					/*
-					 * We are about to sleep the thread
-					 * and so wont be polling any
-					 * more.
-					 */
-					clear_thread_flag(TIF_POLLING_NRFLAG);
-
-					/*
-					 * SMT dynamic mode. Cede will result
-					 * in this thread going dormant, if the
-					 * partner thread is still doing work.
-					 * Thread wakes up if partner goes idle,
-					 * an interrupt is presented, or a prod
-					 * occurs.  Returning from the cede
-					 * enables external interrupts.
-					 */
-					if (!need_resched())
-						cede_processor();
-					else
-						local_irq_enable();
-				} else {
-					/*
-					 * Give the HV an opportunity at the
-					 * processor, since we are not doing
-					 * any work.
-					 */
-					poll_pending();
-				}
-			}
+			if (!(ppaca->lppaca.idle)) {
+				local_irq_disable();
 
-			clear_thread_flag(TIF_POLLING_NRFLAG);
-		} else {
-			set_need_resched();
+				/*
+				 * We are about to sleep the thread
+				 * and so wont be polling any
+				 * more.
+				 */
+				clear_thread_flag(TIF_POLLING_NRFLAG);
+
+				/* 
+				 * Must have TIF_POLLING_NRFLAG clear visible
+				 * before checking need_resched
+				 */
+				smp_mb__after_clear_bit();
+
+				/*
+				 * SMT dynamic mode. Cede will result
+				 * in this thread going dormant, if the
+				 * partner thread is still doing work.
+				 * Thread wakes up if partner goes idle,
+				 * an interrupt is presented, or a prod
+				 * occurs.  Returning from the cede
+				 * enables external interrupts.
+				 */
+				if (!need_resched())
+					cede_processor();
+				else
+					local_irq_enable();
+				set_thread_flag(TIF_POLLING_NRFLAG);
+			} else {
+				/*
+				 * Give the HV an opportunity at the
+				 * processor, since we are not doing
+				 * any work.
+				 */
+				poll_pending();
+			}
 		}
 
 		HMT_medium();
 		lpaca->lppaca.idle = 0;
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
 			cpu_die();
 	}
@@ -245,6 +228,7 @@ static int shared_idle(void)
 {
 	struct paca_struct *lpaca = get_paca();
 	unsigned int cpu = smp_processor_id();
+	set_thread_flag(TIF_POLLING_NRFLAG);
 
 	while (1) {
 		/*
@@ -256,6 +240,9 @@ static int shared_idle(void)
 		while (!need_resched() && !cpu_is_offline(cpu)) {
 			local_irq_disable();
 
+			clear_thread_flag(TIF_POLLING_NRFLAG);
+			smp_mb__after_clear_bit();
+
 			/*
 			 * Yield the processor to the hypervisor.  We return if
 			 * an external interrupt occurs (which are driven prior
@@ -270,11 +257,14 @@ static int shared_idle(void)
 				cede_processor();
 			else
 				local_irq_enable();
+			set_thread_flag(TIF_POLLING_NRFLAG);
 		}
 
 		HMT_medium();
 		lpaca->lppaca.idle = 0;
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		if (cpu_is_offline(smp_processor_id()) &&
 		    system_state == SYSTEM_RUNNING)
 			cpu_die();
@@ -289,10 +279,12 @@ static int native_idle(void)
 {
 	while(1) {
 		/* check CPU type here */
-		if (!need_resched())
+		while (!need_resched())
 			power4_idle();
-		if (need_resched())
-			schedule();
+
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
 
 		if (cpu_is_offline(_smp_processor_id()) &&
 		    system_state == SYSTEM_RUNNING)
Index: linux-2.6/arch/ia64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/process.c	2005-05-16 13:50:52.000000000 +1000
+++ linux-2.6/arch/ia64/kernel/process.c	2005-05-16 14:04:56.000000000 +1000
@@ -195,11 +195,16 @@ update_pal_halt_status(int status)
 void
 default_idle (void)
 {
-	while (!need_resched())
-		if (can_do_pal_halt)
+	if (can_do_pal_halt) {
+		clear_thread_flag(TIF_POLLING_NRFLAG);
+		smp_mb__after_clear_bit();
+		while (!need_resched())
 			safe_halt();
-		else
+		set_thread_flag(TIF_POLLING_NRFLAG);
+	} else {
+		while (!need_resched())
 			cpu_relax();
+	}
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -261,16 +266,17 @@ void __attribute__((noreturn))
 cpu_idle (void)
 {
 	void (*mark_idle)(int) = ia64_mark_idle;
+  	int cpu = smp_processor_id();
+	set_thread_flag(TIF_POLLING_NRFLAG);
 
 	/* endless idle loop with no priority at all */
 	while (1) {
+
+		if (!need_resched()) {
+			void (*idle)(void);
 #ifdef CONFIG_SMP
-		if (!need_resched())
 			min_xtp();
 #endif
-		while (!need_resched()) {
-			void (*idle)(void);
-
 			if (__get_cpu_var(cpu_idle_state))
 				__get_cpu_var(cpu_idle_state) = 0;
 
@@ -282,15 +288,15 @@ cpu_idle (void)
 			if (!idle)
 				idle = default_idle;
 			(*idle)();
-		}
-
-		if (mark_idle)
-			(*mark_idle)(0);
-
+			if (mark_idle)
+				(*mark_idle)(0);
 #ifdef CONFIG_SMP
-		normal_xtp();
+			normal_xtp();
 #endif
+		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		check_pgt_cache();
 		if (cpu_is_offline(smp_processor_id()))
 			play_dead();
Index: linux-2.6/arch/ia64/kernel/smpboot.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/smpboot.c	2005-05-16 13:50:52.000000000 +1000
+++ linux-2.6/arch/ia64/kernel/smpboot.c	2005-05-16 13:52:16.000000000 +1000
@@ -393,6 +393,8 @@ smp_callin (void)
 int __devinit
 start_secondary (void *unused)
 {
+	preempt_disable();
+
 	/* Early console may use I/O ports */
 	ia64_set_kr(IA64_KR_IO_BASE, __pa(ia64_iobase));
 	Dprintk("start_secondary: starting CPU 0x%x\n", hard_smp_processor_id());
Index: linux-2.6/arch/ppc64/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/ppc64/kernel/smp.c	2005-05-16 13:50:52.000000000 +1000
+++ linux-2.6/arch/ppc64/kernel/smp.c	2005-05-16 13:52:16.000000000 +1000
@@ -561,7 +561,10 @@ int __devinit __cpu_up(unsigned int cpu)
 /* Activate a secondary processor. */
 int __devinit start_secondary(void *unused)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
+	
+	preempt_disable();
+	cpu = smp_processor_id();
 
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
Index: linux-2.6/arch/sparc64/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/sparc64/kernel/smp.c	2005-05-16 13:49:23.000000000 +1000
+++ linux-2.6/arch/sparc64/kernel/smp.c	2005-05-16 13:52:16.000000000 +1000
@@ -1167,20 +1167,9 @@ void __init smp_cpus_done(unsigned int m
 	       (bogosum/(5000/HZ))%100);
 }
 
-/* This needn't do anything as we do not sleep the cpu
- * inside of the idler task, so an interrupt is not needed
- * to get a clean fast response.
- *
- * XXX Reverify this assumption... -DaveM
- *
- * Addendum: We do want it to do something for the signal
- *           delivery case, we detect that by just seeing
- *           if we are trying to send this to an idler or not.
- */
 void smp_send_reschedule(int cpu)
 {
-	if (cpu_data(cpu).idle_volume == 0)
-		smp_receive_signal(cpu);
+	smp_receive_signal(cpu);
 }
 
 /* This is a nop because we capture all other cpus
Index: linux-2.6/arch/sparc64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/sparc64/kernel/process.c	2005-05-16 13:50:53.000000000 +1000
+++ linux-2.6/arch/sparc64/kernel/process.c	2005-05-16 13:52:16.000000000 +1000
@@ -74,7 +74,9 @@ void cpu_idle(void)
 		while (!need_resched())
 			barrier();
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		check_pgt_cache();
 	}
 }
@@ -83,21 +85,32 @@ void cpu_idle(void)
 
 /*
  * the idle loop on a UltraMultiPenguin...
+ * 
+ * TIF_POLLING_NRFLAG is set because we do not sleep the cpu
+ * inside of the idler task, so an interrupt is not needed
+ * to get a clean fast response.
+ *
+ * XXX Reverify this assumption... -DaveM
+ *
+ * Addendum: We do want it to do something for the signal
+ *           delivery case, we detect that by just seeing
+ *           if we are trying to send this to an idler or not.
  */
-#define idle_me_harder()	(cpu_data(smp_processor_id()).idle_volume += 1)
-#define unidle_me()		(cpu_data(smp_processor_id()).idle_volume = 0)
 void cpu_idle(void)
 {
+	cpuinfo_sparc cpuinfo = cpu_data(smp_processor_id());
 	set_thread_flag(TIF_POLLING_NRFLAG);
+
 	while(1) {
 		if (need_resched()) {
+			cpuinfo.idle_volume = 0;
 			unidle_me();
-			clear_thread_flag(TIF_POLLING_NRFLAG);
+			preempt_enable_no_resched();
 			schedule();
-			set_thread_flag(TIF_POLLING_NRFLAG);
+			preempt_disable();
 			check_pgt_cache();
 		}
-		idle_me_harder();
+		cpuinfo.idle_volume++;
 
 		/* The store ordering is so that IRQ handlers on
 		 * other cpus see our increasing idleness for the buddy

--------------010008090205060201020909--

