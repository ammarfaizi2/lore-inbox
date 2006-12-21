Return-Path: <linux-kernel-owner+w=401wt.eu-S1423117AbWLUV3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423117AbWLUV3i (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 16:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423118AbWLUV3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 16:29:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57807 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423117AbWLUV3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 16:29:37 -0500
Date: Thu, 21 Dec 2006 22:26:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [patch] high-res timers: fix APIC event-broadcasting code
Message-ID: <20061221212644.GA26977@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Subject: [patch] high-res timers: fix APIC event-broadcasting code
From: Ingo Molnar <mingo@elte.hu>

this patch fixes a bug in the APCI-C3-turns-off-lapic related 
event-broadcasting code: it accidentally reactivated the global tick, 
instead of the global event emulation layer.

The effect of this bug was a rare bootup hang on one of my test-laptops 
- but it could also result in other types of timer related problems (but 
not hangs in an already running system), such as imprecise high-res 
timeouts.

Debugged via SysRq-Q.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/i386/kernel/apic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-hres-timers.q/arch/i386/kernel/apic.c
===================================================================
--- linux-hres-timers.q.orig/arch/i386/kernel/apic.c
+++ linux-hres-timers.q/arch/i386/kernel/apic.c
@@ -506,7 +506,7 @@ void switch_APIC_timer_to_ipi(void *cpum
 	int cpu = smp_processor_id();
 
 	if (cpu_isset(cpu, mask) && levt->event_handler)
-		clockevents_set_global_broadcast(levt, 1);
+		clockevents_set_broadcast(levt, 1);
 }
 EXPORT_SYMBOL_GPL(switch_APIC_timer_to_ipi);
 
@@ -517,7 +517,7 @@ void switch_ipi_to_APIC_timer(void *cpum
 	int cpu = smp_processor_id();
 
 	if (cpu_isset(cpu, mask) && levt->event_handler)
-		clockevents_set_global_broadcast(levt, 0);
+		clockevents_set_broadcast(levt, 0);
 }
 EXPORT_SYMBOL_GPL(switch_ipi_to_APIC_timer);
 
