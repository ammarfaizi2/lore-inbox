Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWF2UoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWF2UoW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWF2UoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:44:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932471AbWF2UoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:44:20 -0400
Date: Thu, 29 Jun 2006 13:47:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: kaos@ocs.com.au, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: i386 IPI handlers running with hardirq_count == 0
Message-Id: <20060629134731.518120b8.akpm@osdl.org>
In-Reply-To: <20060629201752.GA25300@elte.hu>
References: <p73wtb0w6dp.fsf@verdi.suse.de>
	<9914.1151600442@ocs3.ocs.com.au>
	<20060629201752.GA25300@elte.hu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Keith Owens <kaos@ocs.com.au> wrote:
> 
> > My question has nothing to do with NMI.  I am querying inconsistent 
> > behaviour amongst normal IPIs, this list :-
> > 
> > i386 function                   irq_enter?
> > smp_apic_timer_interrupt           yes
> > smp_call_function_interrupt        yes
> > smp_error_interrupt                yes
> > smp_invalidate_interrupt           no - why
> > smp_reschedule_interrupt           no (does not need it)
> > smp_spurious_interrupt             yes
> > smp_thermal_interrupt              yes
> > 
> > x86_64 function                 irq_enter?
> > mce_threshold_interrupt            yes
> > smp_apic_timer_interrupt           yes
> > smp_call_function_interrupt        yes
> > smp_error_interrupt                yes
> > smp_invalidate_interrupt           no - why
> > smp_reschedule_interrupt           no (does not need it)
> > smp_spurious_interrupt             yes
> > smp_thermal_interrupt              yes
> 
> irq_enter() is mostly just for the purpose of in_interrupt()/in_irq() to 
> work as expected, not much else. [also the timer code assumes that 
> update_process_times() is called in a HARDIRQ_OFFSET elevated context, 
> so the apic timer IRQ needs irq_enter() too.] The 
> smp_invalidate_interrupt() and smp_reschedule_interrupt() is 
> performance-critical and they dont need irq_enter()/irq_exit().
> 
> Since smp_call_function_interrupt() can be called with driver-supplied 
> function vectors, it's best to keep the irq_enter()/exit there. [for 
> example mm/slab.c has some in_interrupt() sanity checks.] Obviously 
> do_IRQ() itself needs irq_enter()/exit() too - plus the APIC timer irq 
> as mentioned above.
>  
> Otherwise, the rest of the SMP functions technically dont need 
> irq_enter()/irq_exit(). [i.e. threshold, error, spurious and thermal] We 
> could remove it from them.
> 

There's a risk that spin_unlock() in an IPI handler could blow up due to it
trying to reschedule.  But preempt_schedule() explicitly checks the CPU's
interupt flag so as long as that doesn't change we're OK.
