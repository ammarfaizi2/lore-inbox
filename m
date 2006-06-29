Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWF2UWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWF2UWo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWF2UWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:22:43 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:32187 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932408AbWF2UWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:22:42 -0400
Date: Thu, 29 Jun 2006 22:17:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: i386 IPI handlers running with hardirq_count == 0
Message-ID: <20060629201752.GA25300@elte.hu>
References: <p73wtb0w6dp.fsf@verdi.suse.de> <9914.1151600442@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9914.1151600442@ocs3.ocs.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5127]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Keith Owens <kaos@ocs.com.au> wrote:

> My question has nothing to do with NMI.  I am querying inconsistent 
> behaviour amongst normal IPIs, this list :-
> 
> i386 function                   irq_enter?
> smp_apic_timer_interrupt           yes
> smp_call_function_interrupt        yes
> smp_error_interrupt                yes
> smp_invalidate_interrupt           no - why
> smp_reschedule_interrupt           no (does not need it)
> smp_spurious_interrupt             yes
> smp_thermal_interrupt              yes
> 
> x86_64 function                 irq_enter?
> mce_threshold_interrupt            yes
> smp_apic_timer_interrupt           yes
> smp_call_function_interrupt        yes
> smp_error_interrupt                yes
> smp_invalidate_interrupt           no - why
> smp_reschedule_interrupt           no (does not need it)
> smp_spurious_interrupt             yes
> smp_thermal_interrupt              yes

irq_enter() is mostly just for the purpose of in_interrupt()/in_irq() to 
work as expected, not much else. [also the timer code assumes that 
update_process_times() is called in a HARDIRQ_OFFSET elevated context, 
so the apic timer IRQ needs irq_enter() too.] The 
smp_invalidate_interrupt() and smp_reschedule_interrupt() is 
performance-critical and they dont need irq_enter()/irq_exit().

Since smp_call_function_interrupt() can be called with driver-supplied 
function vectors, it's best to keep the irq_enter()/exit there. [for 
example mm/slab.c has some in_interrupt() sanity checks.] Obviously 
do_IRQ() itself needs irq_enter()/exit() too - plus the APIC timer irq 
as mentioned above.
 
Otherwise, the rest of the SMP functions technically dont need 
irq_enter()/irq_exit(). [i.e. threshold, error, spurious and thermal] We 
could remove it from them.

	Ingo
