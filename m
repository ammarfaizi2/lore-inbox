Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbVHHOxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbVHHOxn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbVHHOxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:53:43 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:42428 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750920AbVHHOxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:53:43 -0400
Date: Mon, 8 Aug 2005 20:24:21 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org, tuukka.tikkanen@elektrobit.com, george@mvista.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Message-ID: <20050808145421.GB4738@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200508031559.24704.kernel@kolivas.org> <20050805123754.GA1262@in.ibm.com> <20050808072600.GE28070@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808072600.GE28070@atomide.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 12:26:01AM -0700, Tony Lindgren wrote:
> Good point, and it would be nice to have it resolved for systems that support
> idling individual CPUs. The current setup was done because when I was tinkering
> with the amd76x_pm patch a while a back, I noticed that idling the cpu
> disconnects all cpus from the bus. (As far as I remember)
> So this may need to be configured depending on the system.

What do you mean by "idling" a cpu? Is it reprogramming the timer source
to skip ticks? Or putting the cpu actually in some low-power state?
And what do you mean by "disconnect all CPUs from the bus"? Is it
the system bus? And what happens if the CPUs are disconnected from
the bus like this while it is executing?

Both requirements (idling all CPUs together vs individually) I think
will make the patch more complex.  Are such systems (which require having to 
idle all CPUs together) pretty common that we have to care about?!


> > - All CPUs seem to cut off the same number of ticks (dyn_tick->skip). Isn't
> >   this wrong, considering that the timer list is per-CPU? This will cause
> >   some timers to be serviced much later than usual.
> 
> Yes if it's done on per-CPU basis. In the current setup the first interrupt
> will kick the system off the dyn-tick state and the timers get checked again.

But that may be too late on some CPUs. If dyn_tick->skip = 100, all
CPUs skip 100 ticks. However some CPUs may have timers that need to be
service much before that.

> > - The fact that dyn_tick_state is global and accessed from all CPUs
> >   is probably a scalability concern, especially if we allow the ticks
> >   to be cut off on per-CPU basis.
> 
> >From idling devices point of view, we still need some global variable I
> believe. How else would you be able to tell all devices that the whole
> system does not have any timers for next 2 seconds?

Why would anyone want to know that? Moreover, when we enable this
per-CPU, the no-timer-interval is also distributed across CPUs.

> But in any case on P4 systems the APIC timer is not the bottleneck as
> stopping or reprogramming PIT also kills APIC. (This does not happen on P3
> systems). So the bottleneck most likely is the length of PIT.

On these systems, do you disabled APIC (dyntick=noapic)?

> HRT + VST depend on APIC only, and does not use next_timer_interrupt().

AFAIK, it supports pm timer too and yes it has its own implementation
of next_timer_interrupt, which makes it more work for merging. 
At this point, looks like dyn-tick is gaining more momentum and is 
more likely a candidate for merging. I will send out my SMP-support
changes to dynamic tick soon.

> You may also want to check out the ARM implementation as it does not have
> the issues listed above, which are mostly x86 specific issues.

Thanks for the pointer. Will look at it.


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
