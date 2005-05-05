Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVEEMTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVEEMTh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 08:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVEEMTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 08:19:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:58246 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262072AbVEEMT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 08:19:26 -0400
Date: Thu, 5 May 2005 14:19:24 +0200
From: Andi Kleen <ak@suse.de>
To: Len Brown <len.brown@intel.com>
Cc: Andi Kleen <ak@suse.de>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>, John Stultz <johnstul@us.ibm.com>,
       Asit K Mallick <asit.k.mallick@intel.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, trenn@suse.de
Subject: Re: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Message-ID: <20050505121924.GN28441@wotan.suse.de>
References: <20050429172605.A23722@unix-os.sc.intel.com> <20050502163821.GE7342@wotan.suse.de> <20050502101631.A4875@unix-os.sc.intel.com> <20050502190850.GN7342@wotan.suse.de> <1115271213.7637.126.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115271213.7637.126.camel@d845pe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2005 at 01:33:33AM -0400, Brown, Len wrote:
> Re: no idle tick
> 
> Idle power savings does not by itself justify HZ=0.
> We'll get the same idle power consumption with HZ=1.


Power consumption is not the only reason for no tick in idle.
The other big one is virtualization. If you have lots
of virtual machines running on a hypervisor you really
dont want them to wake up regularly even when idle.

I would advise you have a talk about this with
the people in your company who work in this area ,-)

> Linux should probably default to HZ=100, and have
> the capability to speed up to HZ=1000 at run-time
> if applications request it; and it should slow down
> to HZ=10 in deep idle.

There is no interface to request this.

Also for this you need all the infrastructure for a fully dynamic
tick already, and when you have that you can go the full way.

But currently disabling the timer tick in non idle is still
some time away, in particular the CPU statistics support
in generic code needs quite some revamp for this. On the other
hand no tick in idle is mostly possible (biggest left often
issues seem to be RCU and interaction with ACPI on x86) 


> If we keep HZ=10 in idle rather than going all
> the way to HZ=0, it allows the C-state promotion code
> to work without any special cases to wake the system
> when idle just to promote to a deeper C-state --
> i.e. like it works today.


I think the C state code needs improvements anyways,
and when it gets that there is not much reason to not
let it talk to the timer code.

The current (somewhat dumb) C promotion algorithm
can be made to work with no-timer-tick-in-idle
by giving a simply hint to the delay timer code
to not delay longer than the timeout of the current
C state (and so delay in a staircase pattern
for longer and longer) 

But I hope in future a better algorithm can be found
that takes into account how busy the machine is on average and
uses that as an estimate to predict which C state should
be used next. e.g. a most idle box that only occasionally
wakes up can go back directly into C2 or C3 again, no
need to go through C1.

Thomas is working in this area.

> 
> Re: multiple LAPIC rates on SMP
> 
> This concept doesn't work when it is needed (C3)
> and isn't needed when it works (C1/C2).
> 
> This is because the LAPIC timer stops in C3,
> and the latencies in C1/C2 are so low that
> it doesn't matter what the tick rate is.

First we need it anyways for the virtualization case
(where idle CPUs need to be fully idle) 
and then it does not make much sense to me to wake up
that often and eat power when not needed. 


> Re: using TSC to patch things up
> 
> Nope.  TSC is variable on some processors with P-states,
> and on some processors it stops in C3.

But it is constant on others, and on those it can
be a valuable speedup.  And variable TSC can be dealt
with with some infrastructure work. With cpufreq 
we know the current frequency (except in thermal throttle,
but ignoring that is quite reasonable imho). Ok there
is APM with SMM code that does it behind your back , 
but that can be probably ignored too now ,-) On x86-64
all these wards dont exist anyways. 


The missing infrastructure is that the timer interrupt code
needs to be rerun when the frequency changes to fix
up the TSC base and the TSC base needs to be kept per CPU,
not global. I hope to get this done eventually on x86-64
at least.

Using is especially important on systems without HPET
(which is unfortunately missing in some modern high volume chipsets :-(((=, 
because reprogramming the PIT all the time is really slow and
using the TSC helps doing that less often.
 
> On the systems I'm aware of, LAPIC timer is based
> on the bus speed rather than the core speed.  So
> today it should be constant or zero -- that is until
> some HW guy decides to throttle the bus at run-time
> to save power.  Based on the history of the TSC --
> frozen in C3 and sometimes variable with MHz changes;
> it would not surprise me a bit to see the LAPIC, now
> frozen in C3, become variable in some future power
> saving state that varies bus speed.

cpufreq callbacks can deal with that.

> 
> Re: re-calibrating the un-frozen LAPIC timer 
> 
> I think we're on thin-ice if we endeavor to continue
> to use the LAPIC timer.  The multiple LAPIC rates
> on SMP concept is defunct (above), so the only benefit
> of using the LAPIC timer is that it is lower latency
> to re-program it when we re-program the global rate.
> But then we have to do this on all logical processors
> and we have to add the code correct it with a
> stable reference time-source.

I disagree. LAPIC is still the only sane choice for
a per CPU timer on a SMP system. On UP they are not needed,
but I suspect UP only laptops will eventually die out
when everything new becomes dual core .. 

> 1. disable LAPIC timer use on uni-processor
>    it adds no value, and breaks if C3 is supported.

I did that already on x86-64.

> 2. disable LAPIC timer use on SMP, via
>    Venki's timer broadcast patch, or similar.

Strongly disagreed.

> 3. Transparently use HZ=10 in "deep idle"

See above.

-Andi


