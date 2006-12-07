Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032096AbWLGMNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032096AbWLGMNW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 07:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032097AbWLGMNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 07:13:22 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54711 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032096AbWLGMNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 07:13:21 -0500
Date: Thu, 7 Dec 2006 13:11:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, ak@suse.de,
       Linus Torvalds <torvalds@osdl.org>
Subject: [patch] x86_64: do not enable the NMI watchdog by default
Message-ID: <20061207121135.GA15529@elte.hu>
References: <20061206223025.GA17227@elte.hu> <200612061857.30248.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612061857.30248.len.brown@intel.com>
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


* Len Brown <len.brown@intel.com> wrote:

> Personally I have never been a big fan of having the NMI watchdog 
> running by default on all systems -- but Andi insists that it helps 
> him debug failures, so tick it does...

enabling it by default was IMO a really bad decision and it needs to be 
undone via the patch attached further below.

If Andi wants to debug stuff via the NMI wachdog, he should use the 
nmi_watchdog=2 boot option: next to the tty=ttyS0 serial console 
options, initcall_debug, apic=debug, earlyprintk and myriads of other 
kernel-hackers-only boot options that we all use to 'help debug 
failures' ...

also, lock debugging facilities catch lockup possibilities (and actual 
lockups) alot more efficiently, i cannot remember the last time the NMI 
watchdog caught anything on my boxes without some other facility not 
triggering first. (and i have it enabled everywhere)

I have run a quick analysis over all locking related crashes i triggered 
on one particular testbox over the past 2 weeks. Out of 26 separate lock 
related incidents spread out equally over that timeframe (out of 497 
bootups on this box), this was the distribution of debugging facilities 
that caught the bugs:

      1  BUG: spinlock lockup on
      1  [ INFO: inconsistent lock state ]
      2  BUG: scheduling while atomic
      2  [ BUG: bad unlock balance detected! ]
      2  BUG: sleeping function called from invalid context
      6  BUG: scheduling with irqs disabled
      5  [ INFO: hard-safe -> hard-unsafe lock order detected ]
      7  BUG: using smp_processor_id() in preemptible [] code

8 were caught by lockdep, 8 by atomicity checks in the scheduler, 7 by 
DEBUG_PREEMPT and 1 by DEBUG_SPINLOCK.

Note: zero were caught by the NMI watchdog, and i run the NMI watchdog 
enabled by default on all architectures, and i have serial logging of 
everything.

but even for the typical distro kernel and for the typical user, the NMI 
watchdog is normally useless, because NMI lockups rarely make it into 
the syslog and X just locks up without showing anything on the screen.

	Ingo

----------------------->
Subject: [patch] x86_64: do not enable the NMI watchdog by default
From: Ingo Molnar <mingo@elte.hu>

do not enable the NMI watchdog by default. Now that we have lockdep i 
cannot remember the last time it caught a real bug, but the NMI watchdog 
can /cause/ problems. Furthermore, to the typical user, an NMI watchdog 
assert results in a total lockup anyway (if under X). In that sense, all 
that the NMI watchdog does is that it makes the system /less/ stable and 
/less/ debuggable.

people can still enable it either after bootup via:

   echo 1 > /proc/sys/kernel/nmi

or via the nmi_watchdog=1 or nmi_watchdog=2 boot options.

build and boot tested on an Athlon64 box.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86_64/kernel/apic.c    |    1 -
 arch/x86_64/kernel/io_apic.c |    5 +----
 arch/x86_64/kernel/nmi.c     |    2 +-
 arch/x86_64/kernel/smpboot.c |    1 -
 include/asm-x86_64/nmi.h     |    1 -
 5 files changed, 2 insertions(+), 8 deletions(-)

Index: linux/arch/x86_64/kernel/apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/apic.c
+++ linux/arch/x86_64/kernel/apic.c
@@ -443,7 +443,6 @@ void __cpuinit setup_local_APIC (void)
 			oldvalue, value);
 	}
 
-	nmi_watchdog_default();
 	setup_apic_nmi_watchdog(NULL);
 	apic_pm_activate();
 }
Index: linux/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/io_apic.c
+++ linux/arch/x86_64/kernel/io_apic.c
@@ -1604,7 +1604,6 @@ static inline void check_timer(void)
 		 */
 		unmask_IO_APIC_irq(0);
 		if (!no_timer_check && timer_irq_works()) {
-			nmi_watchdog_default();
 			if (nmi_watchdog == NMI_IO_APIC) {
 				disable_8259A_irq(0);
 				setup_nmi();
@@ -1630,10 +1629,8 @@ static inline void check_timer(void)
 		setup_ExtINT_IRQ0_pin(apic2, pin2, vector);
 		if (timer_irq_works()) {
 			apic_printk(APIC_VERBOSE," works.\n");
-			nmi_watchdog_default();
-			if (nmi_watchdog == NMI_IO_APIC) {
+			if (nmi_watchdog == NMI_IO_APIC)
 				setup_nmi();
-			}
 			return;
 		}
 		/*
Index: linux/arch/x86_64/kernel/nmi.c
===================================================================
--- linux.orig/arch/x86_64/kernel/nmi.c
+++ linux/arch/x86_64/kernel/nmi.c
@@ -181,7 +181,7 @@ static __cpuinit inline int nmi_known_cp
 }
 
 /* Run after command line and cpu_init init, but before all other checks */
-void nmi_watchdog_default(void)
+static inline void nmi_watchdog_default(void)
 {
 	if (nmi_watchdog != NMI_DEFAULT)
 		return;
Index: linux/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux.orig/arch/x86_64/kernel/smpboot.c
+++ linux/arch/x86_64/kernel/smpboot.c
@@ -866,7 +866,6 @@ static int __init smp_sanity_check(unsig
  */
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	nmi_watchdog_default();
 	current_cpu_data = boot_cpu_data;
 	current_thread_info()->cpu = 0;  /* needed? */
 	set_cpu_sibling_map(0);
Index: linux/include/asm-x86_64/nmi.h
===================================================================
--- linux.orig/include/asm-x86_64/nmi.h
+++ linux/include/asm-x86_64/nmi.h
@@ -59,7 +59,6 @@ extern void disable_timer_nmi_watchdog(v
 extern void enable_timer_nmi_watchdog(void);
 extern int nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
 
-extern void nmi_watchdog_default(void);
 extern int setup_nmi_watchdog(char *);
 
 extern atomic_t nmi_active;
