Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424264AbWKIXln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424264AbWKIXln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424262AbWKIXju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:39:50 -0500
Received: from www.osadl.org ([213.239.205.134]:7325 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161878AbWKIXjS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:39:18 -0500
Message-Id: <20061109233036.028997000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
Date: Thu, 09 Nov 2006 23:38:34 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Len Brown <lenb@kernel.org>, John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 17/19] dynticks: Fix nmi watchdog
Content-Disposition: inline; filename=dynticks-i386-nmi-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The NMI watchdog implementation assumes that the local APIC timer
interrupt is happening. This assumption is not longer true when
high resolution timers and dynamic ticks come into play, as they
may switch off the local APIC timer completely. Take the PIT/HPET
interrupts into account too, to avoid false positives.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux-2.6.19-rc5-mm1/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/arch/i386/kernel/nmi.c	2006-11-09 17:47:58.000000000 +0100
+++ linux-2.6.19-rc5-mm1/arch/i386/kernel/nmi.c	2006-11-09 20:52:29.000000000 +0100
@@ -23,6 +23,7 @@
 #include <linux/dmi.h>
 #include <linux/kprobes.h>
 #include <linux/cpumask.h>
+#include <linux/kernel_stat.h>
 
 #include <asm/smp.h>
 #include <asm/nmi.h>
@@ -920,9 +921,13 @@ __kprobes int nmi_watchdog_tick(struct p
 		cpu_clear(cpu, backtrace_mask);
 	}
 
-	sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
+	/*
+	 * Take the local apic timer and PIT/HPET into account. We don't
+	 * know which one is active, when we have highres/dyntick on
+	 */
+	sum = per_cpu(irq_stat, cpu).apic_timer_irqs + kstat_irqs(0);
 
-	/* if the apic timer isn't firing, this cpu isn't doing much */
+	/* if the none of the timers isn't firing, this cpu isn't doing much */
 	if (!touched && last_irq_sums[cpu] == sum) {
 		/*
 		 * Ayiee, looks like this CPU is stuck ...

--

