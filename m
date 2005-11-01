Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVKALc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVKALc6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 06:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVKALc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 06:32:58 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33978 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750744AbVKALc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 06:32:58 -0500
Date: Tue, 1 Nov 2005 12:33:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc5-rt6  -- False NMI lockup detects
Message-ID: <20051101113304.GB2871@elte.hu>
References: <1130250219.21118.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130250219.21118.11.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Ingo and Thomas,
> 
> On some of my machines, I've been experiencing false NMI lockups.  
> This usually happens on slower machines, and taking a look into this, 
> it seems to be due to a short time where no processes are using 
> timers, and the ktimer interrupts aren't needed. So the APIC timer, 
> which now is used only for the ktimers, has a five second pause, and 
> causes the NMI to go off.  The NMI uses the apic timer to determine 
> lockups.
> 
> So, I added a more generic method. This only works for x86 for now, 
> but it has a #ifdef to keep other archs working until it implements 
> this as well.  I added a nmi_irq_incr which is called by __do_IRQ in 
> the generic code.  This is what is used in the NMI code to determine 
> if the CPU has locked up.  This way we don't have to worry about what 
> resource we are using for timers.

but e.g. the APIC timer doesnt go through do_IRQ(), it has its own 
special IRQ entry code. The simple solution would be to also include the 
IRQ#0 count in the NMI watchdog detection condition - i.e. something 
like the patch below. Hm?

	Ingo

Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -521,7 +521,7 @@ void notrace nmi_watchdog_tick (struct p
 	 */
 	int sum, cpu = smp_processor_id();
 
-	sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
+	sum = per_cpu(irq_stat, cpu).apic_timer_irqs + kstat_irqs(0);
 
 	profile_tick(CPU_PROFILING, regs);
 	if (nmi_show_regs[cpu]) {
