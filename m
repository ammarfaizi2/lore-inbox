Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbVKARmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVKARmL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVKARmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:42:10 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:59872 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751040AbVKARmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:42:09 -0500
Subject: Re: 2.6.14-rc5-rt6  -- False NMI lockup detects
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051101113304.GB2871@elte.hu>
References: <1130250219.21118.11.camel@localhost.localdomain>
	 <20051101113304.GB2871@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 01 Nov 2005 12:41:51 -0500
Message-Id: <1130866911.29788.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 12:33 +0100, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Hi Ingo and Thomas,
> > 
> > On some of my machines, I've been experiencing false NMI lockups.  
> > This usually happens on slower machines, and taking a look into this, 
> > it seems to be due to a short time where no processes are using 
> > timers, and the ktimer interrupts aren't needed. So the APIC timer, 
> > which now is used only for the ktimers, has a five second pause, and 
> > causes the NMI to go off.  The NMI uses the apic timer to determine 
> > lockups.
> > 
> > So, I added a more generic method. This only works for x86 for now, 
> > but it has a #ifdef to keep other archs working until it implements 
> > this as well.  I added a nmi_irq_incr which is called by __do_IRQ in 
> > the generic code.  This is what is used in the NMI code to determine 
> > if the CPU has locked up.  This way we don't have to worry about what 
> > resource we are using for timers.
> 
> but e.g. the APIC timer doesnt go through do_IRQ(), it has its own 
> special IRQ entry code. The simple solution would be to also include the 
> IRQ#0 count in the NMI watchdog detection condition - i.e. something 
> like the patch below. Hm?
> 
> 	Ingo
> 
> Index: linux/arch/i386/kernel/nmi.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/nmi.c
> +++ linux/arch/i386/kernel/nmi.c
> @@ -521,7 +521,7 @@ void notrace nmi_watchdog_tick (struct p
>  	 */
>  	int sum, cpu = smp_processor_id();
>  
> -	sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
> +	sum = per_cpu(irq_stat, cpu).apic_timer_irqs + kstat_irqs(0);
>  
>  	profile_tick(CPU_PROFILING, regs);
>  	if (nmi_show_regs[cpu]) {

:) I thought about doing that too, but I wanted a more generic solution.
I think I would have just put the nmi_incr in the apic interrupt handler
as well.  That way we might some day be able to pull out the
nmi_watchdog detect code out of the arch specific all together.

-- Steve


