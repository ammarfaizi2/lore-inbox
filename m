Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163306AbWLGUsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163306AbWLGUsu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 15:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163330AbWLGUsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 15:48:50 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47233 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163329AbWLGUss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 15:48:48 -0500
Date: Thu, 7 Dec 2006 21:47:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Len Brown <lenb@kernel.org>,
       linux-kernel@vger.kernel.org, ak@suse.de,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] x86_64: do not enable the NMI watchdog by default
Message-ID: <20061207204745.GC13327@elte.hu>
References: <20061206223025.GA17227@elte.hu> <200612061857.30248.len.brown@intel.com> <20061207121135.GA15529@elte.hu> <20061207123011.4b723788@localhost.localdomain> <20061207123836.213c3214.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207123836.213c3214.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> (the patch doesn't vaguely apply btw).

patch below should apply to tail of current-ish -mm. Build and boot 
tested on x86_64.

	Ingo

---------------------->
Subject: [patch] x86_64: do not enable the NMI watchdog by default
From: Ingo Molnar <mingo@elte.hu>

do not enable the NMI watchdog by default. Now that we have
lockdep i cannot remember the last time it caught a real bug,
but the NMI watchdog can /cause/ problems. Furthermore, to the
typical user, an NMI watchdog assert results in a total lockup
anyway (if under X). In that sense, all that the NMI watchdog
does is that it makes the system /less/ stable and /less/
debuggable.

people can still enable it either after bootup via:

   echo 1 > /proc/sys/kernel/nmi

or via the nmi_watchdog=1 or nmi_watchdog=2 boot options.

build and boot tested on an Athlon64 box.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86_64/kernel/apic.c    |    1 -
 arch/x86_64/kernel/io_apic.c |    1 -
 arch/x86_64/kernel/nmi.c     |    2 +-
 arch/x86_64/kernel/smpboot.c |    1 -
 include/asm-x86_64/nmi.h     |    1 -
 5 files changed, 1 insertion(+), 5 deletions(-)

Index: linux-mm-genapic.q/arch/x86_64/kernel/apic.c
===================================================================
--- linux-mm-genapic.q.orig/arch/x86_64/kernel/apic.c
+++ linux-mm-genapic.q/arch/x86_64/kernel/apic.c
@@ -427,7 +427,6 @@ void __cpuinit setup_local_APIC (void)
 			oldvalue, value);
 	}
 
-	nmi_watchdog_default();
 	setup_apic_nmi_watchdog(NULL);
 	apic_pm_activate();
 }
Index: linux-mm-genapic.q/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux-mm-genapic.q.orig/arch/x86_64/kernel/io_apic.c
+++ linux-mm-genapic.q/arch/x86_64/kernel/io_apic.c
@@ -1580,7 +1580,6 @@ static int try_apic_pin(int apic, int pi
 	 * Ok, does IRQ0 through the IOAPIC work?
 	 */
 	if (!no_timer_check && timer_irq_works()) {
-		nmi_watchdog_default();
 		if (nmi_watchdog == NMI_IO_APIC) {
 			disable_8259A_irq(0);
 			setup_nmi();
Index: linux-mm-genapic.q/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-mm-genapic.q.orig/arch/x86_64/kernel/nmi.c
+++ linux-mm-genapic.q/arch/x86_64/kernel/nmi.c
@@ -183,7 +183,7 @@ static __cpuinit inline int nmi_known_cp
 }
 
 /* Run after command line and cpu_init init, but before all other checks */
-void nmi_watchdog_default(void)
+static inline void nmi_watchdog_default(void)
 {
 	if (nmi_watchdog != NMI_DEFAULT)
 		return;
Index: linux-mm-genapic.q/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-mm-genapic.q.orig/arch/x86_64/kernel/smpboot.c
+++ linux-mm-genapic.q/arch/x86_64/kernel/smpboot.c
@@ -1080,7 +1080,6 @@ static int __init smp_sanity_check(unsig
  */
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	nmi_watchdog_default();
 	current_cpu_data = boot_cpu_data;
 	current_thread_info()->cpu = 0;  /* needed? */
 	set_cpu_sibling_map(0);
Index: linux-mm-genapic.q/include/asm-x86_64/nmi.h
===================================================================
--- linux-mm-genapic.q.orig/include/asm-x86_64/nmi.h
+++ linux-mm-genapic.q/include/asm-x86_64/nmi.h
@@ -59,7 +59,6 @@ extern void disable_timer_nmi_watchdog(v
 extern void enable_timer_nmi_watchdog(void);
 extern int nmi_watchdog_tick (struct pt_regs * regs, unsigned reason);
 
-extern void nmi_watchdog_default(void);
 extern int setup_nmi_watchdog(char *);
 
 extern atomic_t nmi_active;
