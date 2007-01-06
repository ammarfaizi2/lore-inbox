Return-Path: <linux-kernel-owner+w=401wt.eu-S1751123AbXAFCbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbXAFCbz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbXAFCbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:31:13 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36664 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbXAFCas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:30:48 -0500
Message-Id: <20070106023229.297246000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:12 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, Greg KH <gregkh@suse.de>,
       Chris Wright <chrisw@kernel.org>, Adrian Bunk <bunk@stusta.de>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Ingo Molnar <mingo@elte.hu>
Subject: [patch 19/50] sched: fix bad missed wakeups in the i386, x86_64, ia64, ACPI and APM idle code
Content-Disposition: inline; filename=sched-fix-bad-missed-wakeups-in-the-i386-x86_64-ia64-acpi-and-apm-idle-code.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

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
[chrisw: backport to 2.6.19.1]
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/apm.c        |    6 +++++-
 arch/i386/kernel/process.c    |    7 ++++++-
 arch/ia64/kernel/process.c    |   10 ++++++++--
 arch/x86_64/kernel/process.c  |    6 +++++-
 drivers/acpi/processor_idle.c |   12 ++++++++++--
 5 files changed, 34 insertions(+), 7 deletions(-)

--- linux-2.6.19.1.orig/arch/i386/kernel/apm.c
+++ linux-2.6.19.1/arch/i386/kernel/apm.c
@@ -784,7 +784,11 @@ static int apm_do_idle(void)
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
--- linux-2.6.19.1.orig/arch/i386/kernel/process.c
+++ linux-2.6.19.1/arch/i386/kernel/process.c
@@ -103,7 +103,12 @@ void default_idle(void)
 
 	if (!hlt_counter && boot_cpu_data.hlt_works_ok) {
 		current_thread_info()->status &= ~TS_POLLING;
-		smp_mb__after_clear_bit();
+		/*
+		 * TS_POLLING-cleared state must be visible before we
+		 * test NEED_RESCHED:
+		 */
+		smp_mb();
+
 		while (!need_resched()) {
 			local_irq_disable();
 			if (!need_resched())
--- linux-2.6.19.1.orig/arch/ia64/kernel/process.c
+++ linux-2.6.19.1/arch/ia64/kernel/process.c
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
--- linux-2.6.19.1.orig/arch/x86_64/kernel/process.c
+++ linux-2.6.19.1/arch/x86_64/kernel/process.c
@@ -111,7 +111,11 @@ static void default_idle(void)
 	local_irq_enable();
 
 	current_thread_info()->status &= ~TS_POLLING;
-	smp_mb__after_clear_bit();
+	/*
+	 * TS_POLLING-cleared state must be visible before we
+	 * test NEED_RESCHED:
+	 */
+	smp_mb();
 	while (!need_resched()) {
 		local_irq_disable();
 		if (!need_resched())
--- linux-2.6.19.1.orig/drivers/acpi/processor_idle.c
+++ linux-2.6.19.1/drivers/acpi/processor_idle.c
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

--
