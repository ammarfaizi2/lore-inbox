Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVE0Had@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVE0Had (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVE0Had
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:30:33 -0400
Received: from mail-05.iinet.net.au ([203.59.3.37]:15257 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261824AbVE0HVp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 03:21:45 -0400
Message-ID: <4296CA7A.4050806@cyberone.com.au>
Date: Fri, 27 May 2005 17:21:30 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] improve SMP reschedule and idle routines
Content-Type: multipart/mixed;
 boundary="------------080005080101020006050203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080005080101020006050203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

OK, done a bit of work on all other architectures, and diffed to the
latest -mm. Any chance you can put it in -mm, Andrew?

Also, while I was there, I thought I'd add the set_need_resched()
thing to all the other architectures. I couldn't be bothered doing
2 patches, sorry.

So, this has been tested on i386, ia64, ppc64, sparc64, x86-64, however
some of those (esp. ppc64) use different idle routines for different
architectures. Needs testing.

David's ACK'ed the sparc64 changes, and Ingo's ACK'ed the rationale
of the patch if not this exact one ;)

No other architectures even compile tested, but they've at least got
something there now.

Quick audit of cpu_idle functions was interesting. I changed some, but
they need review from maintainers, and some need more help. Is it worth
sending this to linux-arch?

alpha - set TIF_POLLING_NRFLAG.

arm26 - how did it work before?! (fixed?)

h8300 - Is sleeping racy vs interrupts?
        The H8/300 manual I found indicates yes, however disabling IRQs
        over the sleep mean only NMIs can wake it up, so can't fix easily
        without doing spin waiting.

m68knommu - "stop" if need_resched() is *SET*?!? (changed, is this right?)
          - Is sleeping racy vs interrupts?

parisc - set TIF_POLLING_NRFLAG.

s390 - local irq disable before checking need_resched doesn't gain
       anything (removed, OK?)

sh64 - Is sleeping racy vs interrupts?

sparc - IRQs need to be on here => changed local_irq_save to _disable.
      - Changed idle loop so don't go to schedule() if pm_idle is NULL!
      - set TIF_POLLING_NRFLAG for SMP.
      - TODO: needs secondary CPUs to disable preempt

um - I'm too lazy to really look. Might be OK :P

xtensa - obviously not tested with preempt (hopefully fixed?)

Thanks,
Nick


--------------080005080101020006050203
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
  atomic test and set there. The only other time this should be set is
  when the task's quantum expires, in the timer interrupt - this is
  protected against because the rq lock is irq-safe.

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
--- linux-2.6.orig/kernel/sched.c	2005-05-27 15:41:27.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-05-27 15:43:38.000000000 +1000
@@ -845,21 +845,28 @@ static void deactivate_task(struct task_
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
+	if (unlikely(test_tsk_thread_flag(p, TIF_NEED_RESCHED)))
+		return;
+	
+	set_tsk_thread_flag(p, TIF_NEED_RESCHED);
 
-	if (!need_resched && !nrpolling && (task_cpu(p) != smp_processor_id()))
-		smp_send_reschedule(task_cpu(p));
+	cpu = task_cpu(p);
+	if (cpu == smp_processor_id())
+		return;
+
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
--- linux-2.6.orig/arch/i386/kernel/process.c	2005-05-27 15:40:26.000000000 +1000
+++ linux-2.6/arch/i386/kernel/process.c	2005-05-27 15:55:49.000000000 +1000
@@ -102,14 +102,19 @@ EXPORT_SYMBOL(enable_hlt);
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
 #ifdef CONFIG_APM_MODULE
@@ -123,29 +128,14 @@ EXPORT_SYMBOL(default_idle);
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
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -181,31 +171,33 @@ static inline void play_dead(void)
  */
 void cpu_idle(void)
 {
-	int cpu = _smp_processor_id();
-
-	set_tsk_need_resched(current);
+	int cpu = smp_processor_id();
 
+	set_need_resched();
+	set_thread_flag(TIF_POLLING_NRFLAG);
+	
 	/* endless idle loop with no priority at all */
 	while (1) {
-		while (!need_resched()) {
-			void (*idle)(void);
+		void (*idle)(void);
+  
+		if (__get_cpu_var(cpu_idle_state))
+			__get_cpu_var(cpu_idle_state) = 0;
+  
+		rmb();
+		idle = pm_idle;
+  
+		if (!idle)
+			idle = default_idle;
+  
+		if (cpu_is_offline(cpu))
+			play_dead();
 
-			if (__get_cpu_var(cpu_idle_state))
-				__get_cpu_var(cpu_idle_state) = 0;
+		__get_cpu_var(irq_stat).idle_timestamp = jiffies;
+		idle();
 
-			rmb();
-			idle = pm_idle;
-
-			if (!idle)
-				idle = default_idle;
-
-			if (cpu_is_offline(cpu))
-				play_dead();
-
-			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
-			idle();
-		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
@@ -248,15 +240,12 @@ static void mwait_idle(void)
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
--- linux-2.6.orig/init/main.c	2005-05-27 15:41:26.000000000 +1000
+++ linux-2.6/init/main.c	2005-05-27 15:43:38.000000000 +1000
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
--- linux-2.6.orig/arch/i386/kernel/apm.c	2005-05-27 15:40:25.000000000 +1000
+++ linux-2.6/arch/i386/kernel/apm.c	2005-05-27 15:43:38.000000000 +1000
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
--- linux-2.6.orig/drivers/acpi/processor_idle.c	2005-05-27 15:40:33.000000000 +1000
+++ linux-2.6/drivers/acpi/processor_idle.c	2005-05-27 15:43:38.000000000 +1000
@@ -164,6 +164,14 @@ acpi_processor_power_activate (
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
 
 static atomic_t 	c3_cpu_count;
 
@@ -176,7 +184,7 @@ static void acpi_processor_idle (void)
 	int			sleep_ticks = 0;
 	u32			t1, t2 = 0;
 
-	pr = processors[_smp_processor_id()];
+	pr = processors[smp_processor_id()];
 	if (!pr)
 		return;
 
@@ -196,8 +204,13 @@ static void acpi_processor_idle (void)
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
@@ -277,7 +290,8 @@ static void acpi_processor_idle (void)
 		if (pm_idle_save)
 			pm_idle_save();
 		else
-			safe_halt();
+			acpi_safe_halt();
+
 		/*
                  * TBD: Can't get time duration while in C1, as resumes
 		 *      go to an ISR rather than here.  Need to instrument
@@ -407,16 +421,6 @@ end:
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
--- linux-2.6.orig/arch/i386/kernel/smpboot.c	2005-05-27 15:40:27.000000000 +1000
+++ linux-2.6/arch/i386/kernel/smpboot.c	2005-05-27 15:43:38.000000000 +1000
@@ -477,6 +477,8 @@ set_cpu_sibling_map(int cpu)
  */
 static void __devinit start_secondary(void *unused)
 {
+	preempt_disable();
+
 	/*
 	 * Dont put anything before smp_callin(), SMP
 	 * booting is too fragile that we want to limit the
Index: linux-2.6/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/x86_64/kernel/process.c	2005-05-27 15:40:30.000000000 +1000
+++ linux-2.6/arch/x86_64/kernel/process.c	2005-05-27 15:53:07.000000000 +1000
@@ -85,12 +85,19 @@ EXPORT_SYMBOL(enable_hlt);
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
 
@@ -101,29 +108,16 @@ void default_idle(void)
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
@@ -162,24 +156,26 @@ EXPORT_SYMBOL_GPL(cpu_idle_wait);
  */
 void cpu_idle (void)
 {
-	set_tsk_need_resched(current);
+	set_need_resched();
+	set_thread_flag(TIF_POLLING_NRFLAG);
 
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
 
@@ -194,15 +190,12 @@ static void mwait_idle(void)
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
--- linux-2.6.orig/arch/ppc64/kernel/idle.c	2005-05-27 15:40:28.000000000 +1000
+++ linux-2.6/arch/ppc64/kernel/idle.c	2005-05-27 15:43:38.000000000 +1000
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
--- linux-2.6.orig/arch/ia64/kernel/process.c	2005-05-27 15:40:28.000000000 +1000
+++ linux-2.6/arch/ia64/kernel/process.c	2005-05-27 15:59:15.000000000 +1000
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
@@ -261,18 +266,17 @@ void __attribute__((noreturn))
 cpu_idle (void)
 {
 	void (*mark_idle)(int) = ia64_mark_idle;
-
-	set_tsk_need_resched(current);
+  	int cpu = smp_processor_id();
+	set_need_resched();
+	set_thread_flag(TIF_POLLING_NRFLAG);
 
 	/* endless idle loop with no priority at all */
 	while (1) {
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
 
@@ -284,17 +288,17 @@ cpu_idle (void)
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
-		if (cpu_is_offline(smp_processor_id()))
+		if (cpu_is_offline(cpu))
 			play_dead();
 	}
 }
Index: linux-2.6/arch/ia64/kernel/smpboot.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/smpboot.c	2005-05-27 15:40:28.000000000 +1000
+++ linux-2.6/arch/ia64/kernel/smpboot.c	2005-05-27 15:43:38.000000000 +1000
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
--- linux-2.6.orig/arch/ppc64/kernel/smp.c	2005-05-27 15:37:57.000000000 +1000
+++ linux-2.6/arch/ppc64/kernel/smp.c	2005-05-27 15:43:38.000000000 +1000
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
--- linux-2.6.orig/arch/sparc64/kernel/smp.c	2005-04-11 19:32:15.000000000 +1000
+++ linux-2.6/arch/sparc64/kernel/smp.c	2005-05-27 15:43:38.000000000 +1000
@@ -144,6 +144,9 @@ void __init smp_callin(void)
 		membar("#LoadLoad");
 
 	cpu_set(cpuid, cpu_online_map);
+
+	/* idle thread is expected to have preempt disabled */
+	preempt_disable();
 }
 
 void cpu_panic(void)
@@ -1167,20 +1170,9 @@ void __init smp_cpus_done(unsigned int m
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
--- linux-2.6.orig/arch/sparc64/kernel/process.c	2005-05-27 15:37:58.000000000 +1000
+++ linux-2.6/arch/sparc64/kernel/process.c	2005-05-27 15:43:38.000000000 +1000
@@ -74,7 +74,9 @@ void cpu_idle(void)
 		while (!need_resched())
 			barrier();
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		check_pgt_cache();
 	}
 }
@@ -83,21 +85,31 @@ void cpu_idle(void)
 
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
+	cpuinfo_sparc *cpuinfo = &local_cpu_data();
 	set_thread_flag(TIF_POLLING_NRFLAG);
+
 	while(1) {
 		if (need_resched()) {
-			unidle_me();
-			clear_thread_flag(TIF_POLLING_NRFLAG);
+			cpuinfo->idle_volume = 0;
+			preempt_enable_no_resched();
 			schedule();
-			set_thread_flag(TIF_POLLING_NRFLAG);
+			preempt_disable();
 			check_pgt_cache();
 		}
-		idle_me_harder();
+		cpuinfo->idle_volume++;
 
 		/* The store ordering is so that IRQ handlers on
 		 * other cpus see our increasing idleness for the buddy
Index: linux-2.6/arch/alpha/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/alpha/kernel/process.c	2004-10-19 17:20:02.000000000 +1000
+++ linux-2.6/arch/alpha/kernel/process.c	2005-05-27 16:17:11.000000000 +1000
@@ -43,22 +43,21 @@
 #include "proto.h"
 #include "pci_impl.h"
 
-void default_idle(void)
-{
-	barrier();
-}
-
 void
 cpu_idle(void)
 {
+	set_need_resched();
+	set_thread_flag(TIF_POLLING_NRFLAG);
+	
 	while (1) {
-		void (*idle)(void) = default_idle;
 		/* FIXME -- EV6 and LCA45 know how to power down
 		   the CPU.  */
 
 		while (!need_resched())
-			idle();
+			cpu_relax();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/alpha/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/alpha/kernel/smp.c	2005-04-11 19:32:07.000000000 +1000
+++ linux-2.6/arch/alpha/kernel/smp.c	2005-05-27 16:05:05.000000000 +1000
@@ -128,7 +128,11 @@ wait_boot_cpu_to_stop(int cpuid)
 void __init
 smp_callin(void)
 {
-	int cpuid = hard_smp_processor_id();
+	int cpuid;
+	
+	preempt_disable();
+
+	cpuid = hard_smp_processor_id();
 
 	if (cpu_test_and_set(cpuid, cpu_online_map)) {
 		printk("??, cpu 0x%x already present??\n", cpuid);
Index: linux-2.6/arch/s390/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/smp.c	2005-05-27 15:40:29.000000000 +1000
+++ linux-2.6/arch/s390/kernel/smp.c	2005-05-27 16:41:53.000000000 +1000
@@ -528,6 +528,8 @@ extern void pfault_fini(void);
 
 int __devinit start_secondary(void *cpuvoid)
 {
+	preempt_disable();
+
         /* Setup the cpu */
         cpu_init();
         /* init per CPU timer */
Index: linux-2.6/arch/sparc/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/process.c	2005-05-27 15:37:58.000000000 +1000
+++ linux-2.6/arch/sparc/kernel/process.c	2005-05-27 16:56:29.000000000 +1000
@@ -72,6 +72,13 @@ struct thread_info *current_set[NR_CPUS]
  */
 void default_idle(void)
 {
+	if (pm_idle) {
+		while (!need_resched())
+			(*pm_idle)();
+	} else {
+		while (!need_resched())
+			cpu_relax();
+	}
 }
 
 #ifndef CONFIG_SMP
@@ -83,6 +90,8 @@ void default_idle(void)
  */
 void cpu_idle(void)
 {
+	set_need_resched();
+
 	/* endless idle loop with no priority at all */
 	for (;;) {
 		if (ARCH_SUN4C_SUN4) {
@@ -92,12 +101,11 @@ void cpu_idle(void)
 			static unsigned long fps;
 			unsigned long now;
 			unsigned long faults;
-			unsigned long flags;
 
 			extern unsigned long sun4c_kernel_faults;
 			extern void sun4c_grow_kernel_ring(void);
 
-			local_irq_save(flags);
+			local_irq_disable();
 			now = jiffies;
 			count -= (now - last_jiffies);
 			last_jiffies = now;
@@ -113,14 +121,14 @@ void cpu_idle(void)
 					sun4c_grow_kernel_ring();
 				}
 			}
-			local_irq_restore(flags);
+			local_irq_enable();
 		}
 
-		while((!need_resched()) && pm_idle) {
-			(*pm_idle)();
-		}
+		default_idle();
 
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		check_pgt_cache();
 	}
 }
@@ -130,13 +138,19 @@ void cpu_idle(void)
 /* This is being executed in task 0 'user space'. */
 void cpu_idle(void)
 {
+	
+        set_need_resched();
+        set_thread_flag(TIF_POLLING_NRFLAG);
+			
 	/* endless idle loop with no priority at all */
 	while(1) {
-		if(need_resched()) {
-			schedule();
-			check_pgt_cache();
-		}
-		barrier(); /* or else gcc optimizes... */
+		while (!need_resched())
+			cpu_relax();
+
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+		check_pgt_cache();
 	}
 }
 
Index: linux-2.6/arch/ppc/kernel/idle.c
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/idle.c	2005-03-02 19:37:32.000000000 +1100
+++ linux-2.6/arch/ppc/kernel/idle.c	2005-05-27 16:40:35.000000000 +1000
@@ -50,8 +50,6 @@ void default_idle(void)
 		}
 #endif
 	}
-	if (need_resched())
-		schedule();
 }
 
 /*
@@ -59,11 +57,20 @@ void default_idle(void)
  */
 void cpu_idle(void)
 {
-	for (;;)
-		if (ppc_md.idle != NULL)
-			ppc_md.idle();
-		else
-			default_idle();
+	set_need_resched();
+
+	for (;;) {
+		while (need_resched()) {
+			if (ppc_md.idle != NULL)
+				ppc_md.idle();
+			else
+				default_idle();
+		}
+
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+	}
 }
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_6xx)
Index: linux-2.6/arch/m32r/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/m32r/kernel/process.c	2005-03-02 19:38:48.000000000 +1100
+++ linux-2.6/arch/m32r/kernel/process.c	2005-05-27 16:31:57.000000000 +1000
@@ -94,6 +94,8 @@ static void poll_idle (void)
  */
 void cpu_idle (void)
 {
+	set_need_resched();
+	
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
@@ -104,7 +106,9 @@ void cpu_idle (void)
 
 			idle();
 		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/frv/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/frv/kernel/process.c	2005-03-02 19:37:24.000000000 +1100
+++ linux-2.6/arch/frv/kernel/process.c	2005-05-27 16:19:12.000000000 +1000
@@ -77,16 +77,21 @@ void (*idle)(void) = core_sleep_idle;
  */
 void cpu_idle(void)
 {
+	int cpu = smp_processor_id();
+	set_need_resched();
+	
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
-			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
+			irq_stat[cpu].idle_timestamp = jiffies;
 
 			if (!frv_dma_inprogress && idle)
 				idle();
 		}
-
+		
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/cris/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/cris/kernel/process.c	2004-08-15 11:11:02.000000000 +1000
+++ linux-2.6/arch/cris/kernel/process.c	2005-05-27 16:17:58.000000000 +1000
@@ -191,6 +191,8 @@ extern void default_idle(void);
  */
 void cpu_idle (void)
 {
+	set_need_resched();
+	
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
@@ -201,7 +203,9 @@ void cpu_idle (void)
 
 			idle();
 		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 
 }
Index: linux-2.6/arch/mips/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/smp.c	2005-03-30 10:39:06.000000000 +1000
+++ linux-2.6/arch/mips/kernel/smp.c	2005-05-27 16:36:18.000000000 +1000
@@ -83,7 +83,11 @@ extern ATTRIB_NORET void cpu_idle(void);
  */
 asmlinkage void start_secondary(void)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
+
+	preempt_disable();
+	
+	cpu = smp_processor_id();
 
 	cpu_probe();
 	cpu_report();
Index: linux-2.6/arch/parisc/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/process.c	2005-03-30 10:39:06.000000000 +1000
+++ linux-2.6/arch/parisc/kernel/process.c	2005-05-27 16:38:19.000000000 +1000
@@ -88,11 +88,16 @@ void default_idle(void)
  */
 void cpu_idle(void)
 {
+	set_need_resched();
+	set_thread_flag(TIF_POLLING_NRFLAG);
+	
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched())
 			barrier();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		check_pgt_cache();
 	}
 }
Index: linux-2.6/arch/ppc/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/ppc/kernel/smp.c	2005-03-30 10:39:08.000000000 +1000
+++ linux-2.6/arch/ppc/kernel/smp.c	2005-05-27 16:41:15.000000000 +1000
@@ -326,6 +326,8 @@ int __devinit start_secondary(void *unus
 {
 	int cpu;
 
+	preempt_disable();
+
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
 
Index: linux-2.6/arch/sh/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/sh/kernel/process.c	2005-03-02 19:37:35.000000000 +1100
+++ linux-2.6/arch/sh/kernel/process.c	2005-05-27 16:46:21.000000000 +1000
@@ -51,28 +51,26 @@ void enable_hlt(void)
 
 EXPORT_SYMBOL(enable_hlt);
 
-void default_idle(void)
+void cpu_idle(void)
 {
+	set_need_resched();
+	
 	/* endless idle loop with no priority at all */
 	while (1) {
 		if (hlt_counter) {
-			while (1)
-				if (need_resched())
-					break;
+			while (!need_resched())
+				cpu_relax();
 		} else {
 			while (!need_resched())
 				cpu_sleep();
 		}
 
+		preempt_disable_no_resched();
 		schedule();
+		preempt_enable();
 	}
 }
 
-void cpu_idle(void)
-{
-	default_idle();
-}
-
 void machine_restart(char * __unused)
 {
 	/* SR.BL=1 and invoke address error to let CPU reset (manual reset) */
Index: linux-2.6/arch/m68k/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/m68k/kernel/process.c	2004-10-19 17:20:06.000000000 +1000
+++ linux-2.6/arch/m68k/kernel/process.c	2005-05-27 16:32:57.000000000 +1000
@@ -98,11 +98,15 @@ void (*idle)(void) = default_idle;
  */
 void cpu_idle(void)
 {
+	set_need_resched();
+	
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched())
 			idle();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/mips/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/process.c	2005-03-02 19:37:29.000000000 +1100
+++ linux-2.6/arch/mips/kernel/process.c	2005-05-27 16:37:18.000000000 +1000
@@ -53,12 +53,16 @@ void default_idle (void)
  */
 ATTRIB_NORET void cpu_idle(void)
 {
+	set_need_resched();
+	
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched())
 			if (cpu_wait)
 				(*cpu_wait)();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable()
 	}
 }
 
Index: linux-2.6/arch/m68knommu/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/m68knommu/kernel/process.c	2005-03-02 19:37:27.000000000 +1100
+++ linux-2.6/arch/m68knommu/kernel/process.c	2005-05-27 16:35:50.000000000 +1000
@@ -45,11 +45,8 @@ asmlinkage void ret_from_fork(void);
  */
 void default_idle(void)
 {
-	while(1) {
-		if (need_resched())
-			__asm__("stop #0x2000" : : : "cc");
-		schedule();
-	}
+	while (!need_resched())
+		__asm__("stop #0x2000" : : : "cc");
 }
 
 void (*idle)(void) = default_idle;
@@ -62,8 +59,15 @@ void (*idle)(void) = default_idle;
  */
 void cpu_idle(void)
 {
+	set_need_resched();
+
 	/* endless idle loop with no priority at all */
-	idle();
+	while (1) {
+		idle();
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+	}
 }
 
 void machine_restart(char * __unused)
Index: linux-2.6/arch/sh/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/sh/kernel/smp.c	2005-03-30 10:39:09.000000000 +1000
+++ linux-2.6/arch/sh/kernel/smp.c	2005-05-27 16:46:35.000000000 +1000
@@ -109,7 +109,11 @@ int __cpu_up(unsigned int cpu)
 
 int start_secondary(void *unused)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
+	
+	preempt_disable();
+	
+	cpu = smp_processor_id();
 
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
Index: linux-2.6/arch/parisc/kernel/smp.c
===================================================================
--- linux-2.6.orig/arch/parisc/kernel/smp.c	2005-03-30 10:39:06.000000000 +1000
+++ linux-2.6/arch/parisc/kernel/smp.c	2005-05-27 16:37:48.000000000 +1000
@@ -462,6 +462,8 @@ void __init smp_callin(void)
 	void *istack;
 #endif
 
+	preempt_disable();
+
 	smp_cpu_init(slave_id);
 
 #if 0	/* NOT WORKING YET - see entry.S */
Index: linux-2.6/arch/m32r/kernel/smpboot.c
===================================================================
--- linux-2.6.orig/arch/m32r/kernel/smpboot.c	2005-03-30 10:39:05.000000000 +1000
+++ linux-2.6/arch/m32r/kernel/smpboot.c	2005-05-27 16:32:12.000000000 +1000
@@ -424,6 +424,7 @@ void __init smp_cpus_done(unsigned int m
  *==========================================================================*/
 int __init start_secondary(void *unused)
 {
+	preempt_disable();
 	cpu_init();
 	smp_callin();
 	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
Index: linux-2.6/arch/s390/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/s390/kernel/process.c	2005-03-02 19:37:34.000000000 +1100
+++ linux-2.6/arch/s390/kernel/process.c	2005-05-27 16:44:28.000000000 +1000
@@ -101,11 +101,6 @@ void default_idle(void)
 	int cpu, rc;
 
 	local_irq_disable();
-        if (need_resched()) {
-		local_irq_enable();
-                schedule();
-                return;
-        }
 
 	/* CPU is going idle. */
 	cpu = smp_processor_id();
@@ -121,7 +116,7 @@ void default_idle(void)
 	__ctl_set_bit(8, 15);
 
 #ifdef CONFIG_HOTPLUG_CPU
-	if (cpu_is_offline(smp_processor_id()))
+	if (cpu_is_offline(cpu))
 		cpu_die();
 #endif
 
@@ -161,8 +156,15 @@ void default_idle(void)
 
 void cpu_idle(void)
 {
-	for (;;)
-		default_idle();
+	set_need_resched();
+
+	for (;;) {
+		while (!need_resched())
+			default_idle();
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+	}
 }
 
 void show_regs(struct pt_regs *regs)
Index: linux-2.6/arch/sh64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/sh64/kernel/process.c	2005-03-30 10:39:10.000000000 +1000
+++ linux-2.6/arch/sh64/kernel/process.c	2005-05-27 16:49:18.000000000 +1000
@@ -307,23 +307,21 @@ __setup("hlt", hlt_setup);
 
 static inline void hlt(void)
 {
-	if (hlt_counter)
-		return;
-
 	__asm__ __volatile__ ("sleep" : : : "memory");
 }
 
 /*
  * The idle loop on a uniprocessor SH..
  */
-void default_idle(void)
+void cpu_idle(void)
 {
+	set_need_resched();
+	
 	/* endless idle loop with no priority at all */
 	while (1) {
 		if (hlt_counter) {
-			while (1)
-				if (need_resched())
-					break;
+			while (!need_resched())
+				cpu_relax();
 		} else {
 			local_irq_disable();
 			while (!need_resched()) {
@@ -334,13 +332,11 @@ void default_idle(void)
 			}
 			local_irq_enable();
 		}
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
-}
 
-void cpu_idle(void)
-{
-	default_idle();
 }
 
 void machine_restart(char * __unused)
Index: linux-2.6/arch/arm26/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/arm26/kernel/process.c	2005-03-02 19:37:23.000000000 +1100
+++ linux-2.6/arch/arm26/kernel/process.c	2005-05-27 16:16:41.000000000 +1000
@@ -73,16 +73,16 @@ __setup("hlt", hlt_setup);
  */
 void cpu_idle(void)
 {
+	set_need_resched();
+
 	/* endless idle loop with no priority at all */
-	preempt_disable();
 	while (1) {
-		while (!need_resched()) {
-			local_irq_disable();
-			if (!need_resched() && !hlt_counter)
-				local_irq_enable();
-		}
+		while (!need_resched())
+			cpu_relax();
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
 	}
-	schedule();
 }
 
 static char reboot_mode = 'h';
Index: linux-2.6/arch/arm/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/arm/kernel/process.c	2005-05-27 15:37:54.000000000 +1000
+++ linux-2.6/arch/arm/kernel/process.c	2005-05-27 16:14:46.000000000 +1000
@@ -84,10 +84,14 @@ EXPORT_SYMBOL(pm_power_off);
  */
 void default_idle(void)
 {
-	local_irq_disable();
-	if (!need_resched() && !hlt_counter)
-		arch_idle();
-	local_irq_enable();
+	if (hlt_counter)
+		cpu_relax()
+	else {
+		local_irq_disable();
+		if (!need_resched())
+			arch_idle();
+		local_irq_enable();
+	}
 }
 
 /*
@@ -97,6 +101,7 @@ void default_idle(void)
  */
 void cpu_idle(void)
 {
+	set_need_resched();
 	local_fiq_enable();
 
 	/* endless idle loop with no priority at all */
@@ -104,13 +109,13 @@ void cpu_idle(void)
 		void (*idle)(void) = pm_idle;
 		if (!idle)
 			idle = default_idle;
-		preempt_disable();
 		leds_event(led_idle_start);
 		while (!need_resched())
 			idle();
 		leds_event(led_idle_end);
-		preempt_enable();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/h8300/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/h8300/kernel/process.c	2004-10-19 17:20:03.000000000 +1000
+++ linux-2.6/arch/h8300/kernel/process.c	2005-05-27 16:30:44.000000000 +1000
@@ -53,22 +53,17 @@ asmlinkage void ret_from_fork(void);
 #if !defined(CONFIG_H8300H_SIM) && !defined(CONFIG_H8S_SIM)
 void default_idle(void)
 {
-	while(1) {
-		if (need_resched()) {
-			local_irq_enable();
-			__asm__("sleep");
-			local_irq_disable();
-		}
-		schedule();
+	local_irq_disable();
+	if (need_resched()) {
+		local_irq_enable();
+		/* XXX: race here! What if need_resched() gets set now? */
+		__asm__("sleep");
 	}
 }
 #else
 void default_idle(void)
 {
-	while(1) {
-		if (need_resched())
-			schedule();
-	}
+	cpu_relax();
 }
 #endif
 void (*idle)(void) = default_idle;
@@ -81,7 +76,14 @@ void (*idle)(void) = default_idle;
  */
 void cpu_idle(void)
 {
-	idle();
+	set_need_resched();
+	while (1) {
+		while (!need_resched())
+			idle();
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+	}
 }
 
 void machine_restart(char * __unused)
Index: linux-2.6/arch/xtensa/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/xtensa/kernel/process.c	2005-05-27 15:40:31.000000000 +1000
+++ linux-2.6/arch/xtensa/kernel/process.c	2005-05-27 17:02:46.000000000 +1000
@@ -91,13 +91,15 @@ coprocessor_info_t coprocessor_info[] = 
 void cpu_idle(void)
 {
   	local_irq_enable();
+	set_need_resched();
 
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched())
 			platform_idle();
-		preempt_enable();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 	}
 }
 
Index: linux-2.6/arch/v850/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/v850/kernel/process.c	2004-06-24 18:59:47.000000000 +1000
+++ linux-2.6/arch/v850/kernel/process.c	2005-05-27 17:01:42.000000000 +1000
@@ -36,11 +36,8 @@ extern void ret_from_fork (void);
 /* The idle loop.  */
 void default_idle (void)
 {
-	while (1) {
-		while (! need_resched ())
-			asm ("halt; nop; nop; nop; nop; nop" ::: "cc");
-		schedule ();
-	}
+	while (! need_resched ())
+		asm ("halt; nop; nop; nop; nop; nop" ::: "cc");
 }
 
 void (*idle)(void) = default_idle;
@@ -53,8 +50,17 @@ void (*idle)(void) = default_idle;
  */
 void cpu_idle (void)
 {
+	set_need_resched();
+	
 	/* endless idle loop with no priority at all */
-	(*idle) ();
+	while (1) {
+		while (!need_resched())
+			(*idle) ();
+
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+	}
 }
 
 /*

--------------080005080101020006050203--
