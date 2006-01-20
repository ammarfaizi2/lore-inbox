Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWATMx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWATMx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 07:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWATMx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 07:53:57 -0500
Received: from 81-178-84-64.dsl.pipex.com ([81.178.84.64]:61878 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750924AbWATMx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 07:53:56 -0500
Date: Fri, 20 Jan 2006 12:53:42 +0000
To: linux-kernel@vger.kernel.org
Cc: john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] timer tsc ensure we allow for initial tsc and tsc sync
Message-ID: <20060120125342.GA7632@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have been seeing "BUG: soft lockup detected on CPU#0!" messages
from testing runs of mainline for some time.  This has only been
showing on a very small subset of the systems under test, as it
turns out the slower ones.

Resolving this issue is complex, not because the fix itself is
complex but because of the timer rework which is currently pending
in -mm.  As a result this patch is against 2.6.16-rc1.  So far
we have had no such errors from runs against -mm, but I am unsure
whether that system eliminates this issue, or mearly is lucky as
faster systems are currently with mainline.

John perhaps you could comment?  Also, how experimental is the timer
code, is it likely to go into 2.6.16 or is it more experimental
than that?  If so perhaps we need to try and slip a fix like this
underneath it.

Comments?

-apw

=== 8< ===
timer tsc ensure we allow for initial tsc and tsc sync

During early initialisation we select the timer source to use for
the high resolution time source.  When selecting the TSC we don't
take into account the initial value of the TSC, this leads to a
jump in the clock at the next clock tick.  We also fail to take into
account that the TSC synchronisation in an SMP system resets the TSC.

In both cases this will lead to the timer believing that 0-N TSC
ticks have passed since the last real timer tick.  This will lead
to the clock jumping ahead by nearly the maximum time represented
by the lower 32bits of the TSC.  For a 1GHz machine this is close to
4s, on slower boxes this can exceed 10s and trip the softlock tests.

In this example a 360Mhz system is booted with CONFIG_PRINTK_TIME
enabled.  Not that in both cases 11s 'passes':

[...]
[17179569.184000] Detected 360.156 MHz processor.
[17179569.184000] Using tsc for high-res timesource
[17179569.184000] Console: colour VGA+ 80x25
[17179580.184000] BUG: soft lockup detected on CPU#0!
[...]
[17179581.844000] ...trying to set up timer as Virtual Wire IRQ... works.
[17179582.136000] checking TSC synchronization across 4 CPUs: passed.
[17179593.032000] BUG: soft lockup detected on CPU#0!
[...]

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 arch/i386/kernel/smpboot.c          |    4 ++++
 arch/i386/kernel/timers/timer_tsc.c |   16 ++++++++++++++++
 include/asm-i386/timer.h            |    1 +
 3 files changed, 21 insertions(+)
diff -upN reference/arch/i386/kernel/smpboot.c current/arch/i386/kernel/smpboot.c
--- reference/arch/i386/kernel/smpboot.c
+++ current/arch/i386/kernel/smpboot.c
@@ -52,6 +52,7 @@
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
+#include <asm/timer.h>
 
 #include <mach_apic.h>
 #include <mach_wakecpu.h>
@@ -283,6 +284,9 @@ static void __init synchronize_tsc_bp (v
 		atomic_inc(&tsc_count_stop);
 	}
 
+	/* Ensure we know that the tsc based timer is aware of the change. */
+	tsc_changed();
+
 	sum = 0;
 	for (i = 0; i < NR_CPUS; i++) {
 		if (cpu_isset(i, cpu_callout_map)) {
diff -upN reference/arch/i386/kernel/timers/timer_tsc.c current/arch/i386/kernel/timers/timer_tsc.c
--- reference/arch/i386/kernel/timers/timer_tsc.c
+++ current/arch/i386/kernel/timers/timer_tsc.c
@@ -516,11 +516,15 @@ static int __init init_tsc(char* overrid
 				result++; /* rounding the result */
 
 			hpet_usec_quotient = result;
+
+			hpet_last = hpet_readl(HPET_COUNTER);
 		} else
 #endif
 		{
 			tsc_quotient = calibrate_tsc();
 		}
+		/* Assume this is the last mark offset time */
+		rdtsc(last_tsc_low, last_tsc_high);
 
 		if (tsc_quotient) {
 			fast_gettimeoffset_quotient = tsc_quotient;
@@ -561,6 +565,18 @@ static int tsc_resume(void)
 	return 0;
 }
 
+/*
+ * When SMP systems are booted we synchronise their TSC's, part of this
+ * process involves resetting them all to zero.  At this point it is
+ * important that we rerecord the tsc value else we will jump the clock
+ * forward by 0-N tsc ticks.  For a 1Ghz machine this is approximatly 4s
+ * for slower systems it can exceed the 10s softlock timer.
+ */
+void tsc_changed(void)
+{
+	tsc_resume();
+}
+
 #ifndef CONFIG_X86_TSC
 /* disable flag for tsc.  Takes effect by clearing the TSC cpu flag
  * in cpu/common.c */
diff -upN reference/include/asm-i386/timer.h current/include/asm-i386/timer.h
--- reference/include/asm-i386/timer.h
+++ current/include/asm-i386/timer.h
@@ -38,6 +38,7 @@ struct init_timer_opts {
 extern struct timer_opts* __init select_timer(void);
 extern void clock_fallback(void);
 void setup_pit_timer(void);
+void tsc_changed(void);
 
 /* Modifiers for buggy PIT handling */
 
