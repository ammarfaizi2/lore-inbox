Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318067AbSGXVMU>; Wed, 24 Jul 2002 17:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318097AbSGXVMT>; Wed, 24 Jul 2002 17:12:19 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:13810 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S318067AbSGXVMQ>;
	Wed, 24 Jul 2002 17:12:16 -0400
Message-ID: <3D3F1465.ACA06312@mvista.com>
Date: Wed, 24 Jul 2002 13:56:05 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       Ingo Molnar <mingo@elte.hu>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memorycorruptionin2.5.27?]
References: <Pine.LNX.4.44.0207240927370.15114-100000@home.transmeta.com> <1027529360.3581.1213.camel@sinai>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Wed, 2002-07-24 at 09:40, Linus Torvalds wrote:
> 
> > Just as an example, in the not too distant future what _will_ happen is
> > that
> >
> >       spin_lock_irqsave()
> >       ..
> >       spin_unlock_irqrestore()
> >
> > will not necessarily increment the preemtion count. Why should they?
> > They've disabled local interrupts, so there's no preemption to protect
> > against. That's just an _obvious_ optimization.

I thought this was the thing to do back at the beginning of
the preemption saga, but now I am not so sure.  Lately I
have been doing a bit of code in the clock routines.  These
get called from both interrupt context and from normal
context and thus need to use the IRQ locks.  The task entry
does a spin_lock_irq() and the interrupt routine KNOWS
interrupts are off and just does a spin_lock().  The inner
code just knows that it is wrapped by an IRQ off and so does
not use the IRQ version of the spin locks it needs.

The above change would auger that the "inner" code should
use _raw* spinlocks OR should use the nested IRQ locks.  But
an IRQ lock is a LOT more expensive (due to the hardware
sync implied by messing with the interrupt system) than inc
and dec on a counter.

This, by the way, is the same reason that
preempt_enable()/preemp_disable() should be preferred over
local_irq_disable()/local_irq_enable() when either would do
the job.
> 
> So obvious it is even in my queue :)
> 
> I do not think we are ready yet - there is just way too much code that
> does not pair up as you mention... but I have played with the patch and
> some debugging to see just how feasible it is.  Fairly soon.
> 
> Note that other preemptible kernels (IRIX and BeOS, for example) do not
> even have a preemption count -- all spinlocks also disable interrupts.
> Not that I am suggesting that, I am very fond of our preempt_count
> mechanism, but its a point to consider even if it were feasible (e.g. we
> did not have spinlocks held for hundreds of milliseconds).
> 
> > We can easily add a debugging check to spin_unlock() that says:
> >
> >       /* Somebody messed up, doesn't hold any other preemption thing
> >        * than this lock that is now getting released, and has interrupts
> >        * disabled
> >        */
> >       BUG_ON(preempt_count() == 1 && interrupts_enabled())
> >
> > No?
> 
> Pretty similar to the debugging I played with... as long as it goes away
> eventually (who wants this in their unlock path?) we certainly should
> add it at some point.

I think we also need to have debugging code in the
local_irq_enable() to make sure the correct preemption
enable is being done.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
