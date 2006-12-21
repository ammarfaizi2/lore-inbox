Return-Path: <linux-kernel-owner+w=401wt.eu-S1160998AbWLUMTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbWLUMTX (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 07:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWLUMTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 07:19:23 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54283 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030279AbWLUMTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 07:19:22 -0500
Date: Thu, 21 Dec 2006 13:16:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, Len Brown <len.brown@intel.com>
Subject: [patch] sched: fix bad missed wakeups in the i386, x86_64, ia64, ACPI and APM idle code
Message-ID: <20061221121656.GA9263@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] sched: fix bad missed wakeups in the i386, x86_64, ia64, ACPI and APM idle code
From: Ingo Molnar <mingo@elte.hu>

Fernando Lopez-Lezcano reported frequent scheduling latencies and audio 
xruns starting at the 2.6.18-rt kernel, and those problems persisted all 
until current -rt kernels. The latencies were serious and unjustified by 
system load, often in the milliseconds range.

After a patient and heroic multi-month effort of Fernando, where he 
tested dozens of kernels, tried various configs, boot options, 
test-patches of mine and provided latency traces of those incidents, the 
following 'smoking gun' trace was captured by him:

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
  IRQ_19-1479  1D..1    0us : __trace_start_sched_wakeup (try_to_wake_up)
  IRQ_19-1479  1D..1    0us : __trace_start_sched_wakeup <<...>-5856> (37 0)
  IRQ_19-1479  1D..1    0us : __trace_start_sched_wakeup (c01262ba 0 0)
  IRQ_19-1479  1D..1    0us : resched_task (try_to_wake_up)
  IRQ_19-1479  1D..1    0us : __spin_unlock_irqrestore (try_to_wake_up)
  ...
  <idle>-0     1...1   11us!: default_idle (cpu_idle)
  ...
  <idle>-0     0Dn.1  602us : smp_apic_timer_interrupt (c0103baf 1 0)
  ...
   <...>-5856  0D..2  618us : __switch_to (__schedule)
   <...>-5856  0D..2  618us : __schedule <<idle>-0> (20 162)
   <...>-5856  0D..2  619us : __spin_unlock_irq (__schedule)
   <...>-5856  0...1  619us : trace_stop_sched_switched (__schedule)
   <...>-5856  0D..1  619us : trace_stop_sched_switched <<...>-5856> (37 0)

what is visible in this trace is that CPU#1 ran try_to_wake_up() for 
PID:5856, it placed PID:5856 on CPU#0's runqueue and ran resched_task() 
for CPU#0. But it decided to not send an IPI that no CPU - due to 
TS_POLLING. But CPU#0 never woke up after its NEED_RESCHED bit was set, 
and only rescheduled to PID:5856 upon the next lapic timer IRQ. The 
result was a 600+ usecs latency and a missed wakeup!

the bug turned out to be an idle-wakeup bug introduced into the mainline 
kernel this summer via an optimization in the x86_64 tree:

    commit 495ab9c045e1b0e5c82951b762257fe1c9d81564
    Author: Andi Kleen <ak@suse.de>
    Date:   Mon Jun 26 13:59:11 2006 +0200

    [PATCH] i386/x86-64/ia64: Move polling flag into thread_info_status

    During some profiling I noticed that default_idle causes a lot of
    memory traffic. I think that is caused by the atomic operations
    to clear/set the polling flag in thread_info. There is actually
    no reason to make this atomic - only the idle thread does it
    to itself, other CPUs only read it. So I moved it into ti->status.

the problem is this type of change:

        if (!hlt_counter && boot_cpu_data.hlt_works_ok) {
-               clear_thread_flag(TIF_POLLING_NRFLAG);
+               current_thread_info()->status &= ~TS_POLLING;
                smp_mb__after_clear_bit();
                while (!need_resched()) {
                        local_irq_disable();

this changes clear_thread_flag() to an explicit clearing of TS_POLLING. 
clear_thread_flag() is defined as:

        clear_bit(flag, &ti->flags);

and clear_bit() is a LOCK-ed atomic instruction on all x86 platforms:

  static inline void clear_bit(int nr, volatile unsigned long * addr)
  {
          __asm__ __volatile__( LOCK_PREFIX
                  "btrl %1,%0"

hence smp_mb__after_clear_bit() is defined as a simple compile barrier:

  #define smp_mb__after_clear_bit()       barrier()

but the explicit TS_POLLING clearing introduced by the patch:

+               current_thread_info()->status &= ~TS_POLLING;

is not an atomic op! So the clearing of the TS_POLLING bit is freely 
reorderable with the reading of the NEED_RESCHED bit - and both now 
reside in different memory addresses.

CPU idle wakeup very much depends on ordered memory ops, the clearing of 
the TS_POLLING flag must always be done before we test need_resched() 
and hit the idle instruction(s). [Symmetrically, the wakeup code needs 
to set NEED_RESCHED before it tests the TS_POLLING flag, so memory 
ordering is paramount.]

Fernando's dual-core Athlon64 system has a sufficiently advanced memory 
ordering model so that it triggered this scenario very often.

( And it also turned out that the reason why these latencies never
  triggered on my testsystems is that i routinely use idle=poll, which
  was the only idle variant not affected by this bug. )

The fix is to change the smp_mb__after_clear_bit() to an smp_mb(), to 
act as an absolute barrier between the TS_POLLING write and the 
NEED_RESCHED read. This affects almost all idling methods (default, 
ACPI, APM), on all 3 x86 architectures: i386, x86_64, ia64.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Tested-by: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
---
 arch/i386/kernel/apm.c        |    6 +++++-
 arch/i386/kernel/process.c    |    7 ++++++-
 arch/ia64/kernel/process.c    |   10 ++++++++--
 arch/x86_64/kernel/process.c  |    6 +++++-
 drivers/acpi/processor_idle.c |   12 ++++++++++--
 5 files changed, 34 insertions(+), 7 deletions(-)

Index: linux/arch/i386/kernel/apm.c
===================================================================
--- linux.orig/arch/i386/kernel/apm.c
+++ linux/arch/i386/kernel/apm.c
@@ -785,7 +785,11 @@ static int apm_do_idle(void)
 	polling = !!(current_thread_info()->status & TS_POLLING);
 	if (polling) {
 		current_thread_info()->status &= ~TS_POLLING;
-		smp_mb__after_clear_bit();
+		/*
+		 * TS_POLLING-cleared state must be visible before we
+		 * test NEED_RESCHED:
+		 */
+		smp_mb();
 	}
 	if (!need_resched()) {
 		idled = 1;
Index: linux/arch/i386/kernel/process.c
===================================================================
--- linux.orig/arch/i386/kernel/process.c
+++ linux/arch/i386/kernel/process.c
@@ -102,7 +102,12 @@ void default_idle(void)
 {
 	if (!hlt_counter && boot_cpu_data.hlt_works_ok) {
 		current_thread_info()->status &= ~TS_POLLING;
-		smp_mb__after_clear_bit();
+		/*
+		 * TS_POLLING-cleared state must be visible before we
+		 * test NEED_RESCHED:
+		 */
+		smp_mb();
+
 		local_irq_disable();
 		if (!need_resched())
 			safe_halt();	/* enables interrupts racelessly */
Index: linux/arch/ia64/kernel/process.c
===================================================================
--- linux.orig/arch/ia64/kernel/process.c
+++ linux/arch/ia64/kernel/process.c
@@ -268,10 +268,16 @@ cpu_idle (void)
 
 	/* endless idle loop with no priority at all */
 	while (1) {
-		if (can_do_pal_halt)
+		if (can_do_pal_halt) {
 			current_thread_info()->status &= ~TS_POLLING;
-		else
+			/*
+			 * TS_POLLING-cleared state must be visible before we
+			 * test NEED_RESCHED:
+			 */
+			smp_mb();
+		} else {
 			current_thread_info()->status |= TS_POLLING;
+		}
 
 		if (!need_resched()) {
 			void (*idle)(void);
Index: linux/arch/x86_64/kernel/process.c
===================================================================
--- linux.orig/arch/x86_64/kernel/process.c
+++ linux/arch/x86_64/kernel/process.c
@@ -109,7 +109,11 @@ void exit_idle(void)
 static void default_idle(void)
 {
 	current_thread_info()->status &= ~TS_POLLING;
-	smp_mb__after_clear_bit();
+	/*
+	 * TS_POLLING-cleared state must be visible before we
+	 * test NEED_RESCHED:
+	 */
+	smp_mb();
 	local_irq_disable();
 	if (!need_resched()) {
 		/* Enables interrupts one instruction before HLT.
Index: linux/drivers/acpi/processor_idle.c
===================================================================
--- linux.orig/drivers/acpi/processor_idle.c
+++ linux/drivers/acpi/processor_idle.c
@@ -211,7 +211,11 @@ acpi_processor_power_activate(struct acp
 static void acpi_safe_halt(void)
 {
 	current_thread_info()->status &= ~TS_POLLING;
-	smp_mb__after_clear_bit();
+	/*
+	 * TS_POLLING-cleared state must be visible before we
+	 * test NEED_RESCHED:
+	 */
+	smp_mb();
 	if (!need_resched())
 		safe_halt();
 	current_thread_info()->status |= TS_POLLING;
@@ -345,7 +349,11 @@ static void acpi_processor_idle(void)
 	 */
 	if (cx->type == ACPI_STATE_C2 || cx->type == ACPI_STATE_C3) {
 		current_thread_info()->status &= ~TS_POLLING;
-		smp_mb__after_clear_bit();
+		/*
+		 * TS_POLLING-cleared state must be visible before we
+		 * test NEED_RESCHED:
+		 */
+		smp_mb();
 		if (need_resched()) {
 			current_thread_info()->status |= TS_POLLING;
 			local_irq_enable();
