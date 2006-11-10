Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424325AbWKJBTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424325AbWKJBTT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 20:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424323AbWKJBTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 20:19:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:48219 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1424326AbWKJBTS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 20:19:18 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,407,1157353200"; 
   d="scan'208"; a="14038138:sNHT23225454"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 17/19] dynticks: Fix nmi watchdog
Date: Thu, 9 Nov 2006 17:19:16 -0800
Message-ID: <EB12A50964762B4D8111D55B764A8454DD054E@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 17/19] dynticks: Fix nmi watchdog
Thread-Index: AccEWpTMFVn8Nvf5TxysRvFFXKFxEAAC4Jsg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Andrew Morton" <akpm@osdl.org>
Cc: "LKML" <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Len Brown" <lenb@kernel.org>, "John Stultz" <johnstul@us.ibm.com>,
       "Arjan van de Ven" <arjan@infradead.org>, "Andi Kleen" <ak@suse.de>,
       "Roman Zippel" <zippel@linux-m68k.org>
X-OriginalArrivalTime: 10 Nov 2006 01:19:16.0928 (UTC) FILETIME=[3D8E9C00:01C70466]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Thomas Gleixner
>Sent: Thursday, November 09, 2006 3:39 PM
>To: Andrew Morton
>Cc: LKML; Ingo Molnar; Len Brown; John Stultz; Arjan van de 
>Ven; Andi Kleen; Roman Zippel
>Subject: [patch 17/19] dynticks: Fix nmi watchdog
>
>From: Thomas Gleixner <tglx@linutronix.de>
>
>The NMI watchdog implementation assumes that the local APIC timer
>interrupt is happening. This assumption is not longer true when
>high resolution timers and dynamic ticks come into play, as they
>may switch off the local APIC timer completely. Take the PIT/HPET
>interrupts into account too, to avoid false positives.
>
>Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>Signed-off-by: Ingo Molnar <mingo@elte.hu>
>
>Index: linux-2.6.19-rc5-mm1/arch/i386/kernel/nmi.c
>===================================================================
>--- linux-2.6.19-rc5-mm1.orig/arch/i386/kernel/nmi.c	
>2006-11-09 17:47:58.000000000 +0100
>+++ linux-2.6.19-rc5-mm1/arch/i386/kernel/nmi.c	
>2006-11-09 20:52:29.000000000 +0100
>@@ -23,6 +23,7 @@
> #include <linux/dmi.h>
> #include <linux/kprobes.h>
> #include <linux/cpumask.h>
>+#include <linux/kernel_stat.h>
> 
> #include <asm/smp.h>
> #include <asm/nmi.h>
>@@ -920,9 +921,13 @@ __kprobes int nmi_watchdog_tick(struct p
> 		cpu_clear(cpu, backtrace_mask);
> 	}
> 
>-	sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
>+	/*
>+	 * Take the local apic timer and PIT/HPET into account. We don't
>+	 * know which one is active, when we have highres/dyntick on
>+	 */
>+	sum = per_cpu(irq_stat, cpu).apic_timer_irqs + kstat_irqs(0);
> 
>-	/* if the apic timer isn't firing, this cpu isn't doing much */
>+	/* if the none of the timers isn't firing, this cpu 
>isn't doing much */
> 	if (!touched && last_irq_sums[cpu] == sum) {
> 		/*
> 		 * Ayiee, looks like this CPU is stuck ...
>

Similar change is needed for x86-64 as well. No?

Thanks,
Venki
