Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWF3M7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWF3M7I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 08:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWF3M7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 08:59:08 -0400
Received: from mx1.suse.de ([195.135.220.2]:60624 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932065AbWF3M7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 08:59:07 -0400
To: eranian@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
References: <200606230913.k5N9D73v032387@frankl.hpl.hp.com>
	<p73fyhmx1zv.fsf@verdi.suse.de>
	<20060630123629.GA22381@frankl.hpl.hp.com>
From: Andi Kleen <ak@suse.de>
Date: 30 Jun 2006 14:59:05 +0200
In-Reply-To: <20060630123629.GA22381@frankl.hpl.hp.com>
Message-ID: <p73bqsax0iu.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian <eranian@hpl.hp.com> writes:

> Andi,
> 
> Thanks for your feedback. I will make the changes you
> requested.
> 
> About the context switch code, what about I do the following
> in __switch_to():
> 
> __kprobes struct task_struct *
> __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
> {
>         struct thread_struct *prev = &prev_p->thread,
>                                  *next = &next_p->thread;
>         int cpu = smp_processor_id();
>         struct tss_struct *tss = &per_cpu(init_tss, cpu);
> 
>         if (unlikely(__get_cpu_var(pmu_ctx) || next_p->pfm_context))
>                 __pfm_ctxswout(prev_p, next_p);
> 
>         /*
>          * Reload esp0, LDT and the page table pointer:
>          */
>         tss->rsp0 = next->rsp0;
> 
> There is now a single hook and a conditional branch.
> this is similar to what you have with the debug registers.

It's still more than there was before. Also __get_cpu_var 
is quite a lot of instructions.

I would suggest you borrow some bits in one of the process
or thread info flags and then do a single test

if (unlikely(thr->flags & (DEBUG|PERFMON)) != 0) { 
        if (flags & DEBUG)
                ... do debug ...
        if (flags & PERFMON)
                ... do perfmon ...
}

[which you're at it you can probably add ioports in there too -
improving existing code is always a good thing]

Ideally flags is in some cache line that is already 
touched during context switch. If not you might need
to change the layout.

It's ok to put the do_perfmon stuff into a separate noinline
function because that will disturb the register allocation
in the caller less.

I would suggest doing this in separate preparing patches that
first just do it for existing facilities.

-Andi

P.S.: My comments probably apply to the i386 versions too
although I haven't read them.
