Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317777AbSGKHNE>; Thu, 11 Jul 2002 03:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317778AbSGKHND>; Thu, 11 Jul 2002 03:13:03 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38135 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317777AbSGKHNB>;
	Thu, 11 Jul 2002 03:13:01 -0400
Message-ID: <3D2D308C.ECE3CA5E@mvista.com>
Date: Thu, 11 Jul 2002 00:15:24 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hannu Savolainen <hannu@opensound.com>
CC: "Grover, Andrew" <andrew.grover@intel.com>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <Pine.LNX.4.10.10207110847170.6183-100000@zeus.compusonic.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hannu Savolainen wrote:
> 
> Hi,
> 
> IMHO the easiest solution is just making HZ selectable (100 or 1000 or
> maybe 1024) when configuring the kernel. Also there has to be a variable
> that exports the configured HZ value to modules. In that way users can
> select HZ depending on their needs.
> 
> There are users who don't use power management. Instead they need higher
> HZ for various reasons. Kernels compiled with HZ=1000 have been used
> successfully since year 0 without any major problems. Making HZ
> configurable just makes life easier for such users.
> 
> OTOH the higher wakeup rate during low power states can be cured by
> temporarily lowering the hw clock rate from 1000 to 100. The timer
> interrupt handler just increases jiffies by 10 (instead of 1). All code
> compiled with HZ=1000 still works but there may be latency problems during
> low power states.
> 
> On Wed, 10 Jul 2002, george anzinger wrote:
> 
> > "Grover, Andrew" wrote:
> > >
> > > I'd like to see HZ closer to 100 than 1000, for CPU power reasons. Processor
> > > power states like C3 may take 100 microseconds+ to enter/leave - time when
> > > both the CPU isn't doing any work, but still drawing power as if it was. We
> > > pop out of C3 whenever there is an interrupt, so reducing timer interrupts
> > > is good from a power standpoint by amortizing the transition penalty over a
> > > longer period of power savings.
> > >
> > > But on the other hand, increasing HZ has perf/latency benefits, yes? Have
> > > these been quantified? I'd either like to see a HZ that has balanced
> > > power/performance, or could we perhaps detect we are on a system that cares
> > > about power (aka a laptop) and tweak its value at runtime?
> >
> > HZ is used in a LOT of places.  I suspect "tweaking" at run
> > time would be a bit difficult.
> This is not a problem at all. Just define HZ as:
> 
> extern int system_hz;
> #define HZ system_hz
> 
> After that all code will use variable HZ. Changing HZ on fly will be
> dangerous. However HZ can be made a boot time (LILO) parameter.

This is not really advisable.  A good deal to of the timer
code depends on HZ being a constant so that calculations are
done at compile time.  A lot of this code would be
measurably slower if these calculations were required at run
time.  For example, often a divide is used with the
understanding that it will be done at compile time, not run
time.

-g

> 
> > The high-res-timers patch give high resolution timers with
> > out changing HZ.  Interrupts are scheculed as needed,
> > between the 1/HZ ticks, so a quite system will have few (if
> > any) interrupts between the ticks.
> >
> > --
> > George Anzinger   george@mvista.com
> > High-res-timers:
> > http://sourceforge.net/projects/high-res-timers/
> > Real time sched:  http://sourceforge.net/projects/rtsched/
> > Preemption patch:
> > http://www.kernel.org/pub/linux/kernel/people/rml
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 
> Best regards,
> 
> Hannu
> -----
> Hannu Savolainen (hannu@opensound.com)
> http://www.opensound.com (Open Sound System (OSS))
> http://www.compusonic.fi (Finnish OSS pages)

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
