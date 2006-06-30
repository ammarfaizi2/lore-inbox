Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWF3NhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWF3NhS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 09:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWF3NhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 09:37:18 -0400
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:50646 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S932200AbWF3NhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 09:37:16 -0400
Date: Fri, 30 Jun 2006 06:29:01 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Message-ID: <20060630132901.GB22381@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200606230913.k5N9D73v032387@frankl.hpl.hp.com> <p73fyhmx1zv.fsf@verdi.suse.de> <20060630123629.GA22381@frankl.hpl.hp.com> <p73bqsax0iu.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73bqsax0iu.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Fri, Jun 30, 2006 at 02:59:05PM +0200, Andi Kleen wrote:
> Stephane Eranian <eranian@hpl.hp.com> writes:
> > 
> > __kprobes struct task_struct *
> > __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
> > {
> >         struct thread_struct *prev = &prev_p->thread,
> >                                  *next = &next_p->thread;
> >         int cpu = smp_processor_id();
> >         struct tss_struct *tss = &per_cpu(init_tss, cpu);
> > 
> >         if (unlikely(__get_cpu_var(pmu_ctx) || next_p->pfm_context))
> >                 __pfm_ctxswout(prev_p, next_p);
> > 
> >         /*
> >          * Reload esp0, LDT and the page table pointer:
> >          */
> >         tss->rsp0 = next->rsp0;
> > 
> > There is now a single hook and a conditional branch.
> > this is similar to what you have with the debug registers.
> 
> It's still more than there was before. Also __get_cpu_var 
> is quite a lot of instructions.
> 
Ok, let me explain why we have the pmu_tx per-cpu variable.
Perfmon supports per thread and cpu-wide monitoring (across all
threads running on one CPU).

In per-thread mode, a perfmon context is attached to the monitored
thread in task->pfm_context. When the thread is context switched in 
that context is also stored into the per-cpu variable to indicate
the currently active context. This may seem a bit redundant because
in this mode current->pfm_context == pmu_ctx in SMP mode. However
in UP mode, we support lazy save/restore and there pmu_ctx stores
the last owner.

In cpu-wide mode, the perfmon context is not attched to any thread.
It is logically attached to the CPU being monitored and is pointed
to by pmu_ctx. That variable is used to get to the active perfmon
context on PMU interrupt for instance (because current->pfm_context is
always NULL).

So why do we need care about context switch in cpu-wide mode?
It is because we support a mode where the idle thread is excluded
from cpu-wide monitoring. This is very useful to distinguish 
'useful kernel work' from 'idle'. As you realize, that means
that we need to turn off when the idle thread is context switched
in and turn it back on when it is switched off.

Having said that, and based on your suggestion, I think we could
simply mark the PERFMON flag in the idle thread when needed in cpu-wide
mode. That would bring the test in __switch_to() to something along
those lines:

	prev = &prev_p->thread;
	next = &next_p->thread;

	if (unlikely((prev->flags & PERFMON) || (next->flags & PERFMON)))
		pfm_switch_to(prev_p, next_p);

I could split prev from next and merge next into the DEBUG and BITMAP stuff
as you suggest below.

What do you think?

> I would suggest you borrow some bits in one of the process
> or thread info flags and then do a single test
> 
> if (unlikely(thr->flags & (DEBUG|PERFMON)) != 0) { 
>         if (flags & DEBUG)
>                 ... do debug ...
>         if (flags & PERFMON)
>                 ... do perfmon ...
> }
> 
> [which you're at it you can probably add ioports in there too -
> improving existing code is always a good thing]
> 
> Ideally flags is in some cache line that is already 
> touched during context switch. If not you might need
> to change the layout.
> 
> It's ok to put the do_perfmon stuff into a separate noinline
> function because that will disturb the register allocation
> in the caller less.
> 
> I would suggest doing this in separate preparing patches that
> first just do it for existing facilities.
> 
> -Andi
> 
> P.S.: My comments probably apply to the i386 versions too
> although I haven't read them.

Yes, this is the same for i386.

-- 
-Stephane
