Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317676AbSGKF5A>; Thu, 11 Jul 2002 01:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317680AbSGKF47>; Thu, 11 Jul 2002 01:56:59 -0400
Received: from gw.compusonic.fi ([195.255.196.126]:4306 "EHLO opensound.com")
	by vger.kernel.org with ESMTP id <S317676AbSGKF46>;
	Thu, 11 Jul 2002 01:56:58 -0400
Date: Thu, 11 Jul 2002 09:03:38 +0300 (EEST)
From: Hannu Savolainen <hannu@opensound.com>
To: george anzinger <george@mvista.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <3D2CA278.49BE1ADA@mvista.com>
Message-ID: <Pine.LNX.4.10.10207110847170.6183-100000@zeus.compusonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

IMHO the easiest solution is just making HZ selectable (100 or 1000 or
maybe 1024) when configuring the kernel. Also there has to be a variable
that exports the configured HZ value to modules. In that way users can
select HZ depending on their needs.

There are users who don't use power management. Instead they need higher
HZ for various reasons. Kernels compiled with HZ=1000 have been used
successfully since year 0 without any major problems. Making HZ
configurable just makes life easier for such users.

OTOH the higher wakeup rate during low power states can be cured by
temporarily lowering the hw clock rate from 1000 to 100. The timer
interrupt handler just increases jiffies by 10 (instead of 1). All code
compiled with HZ=1000 still works but there may be latency problems during
low power states.

On Wed, 10 Jul 2002, george anzinger wrote:

> "Grover, Andrew" wrote:
> > 
> > I'd like to see HZ closer to 100 than 1000, for CPU power reasons. Processor
> > power states like C3 may take 100 microseconds+ to enter/leave - time when
> > both the CPU isn't doing any work, but still drawing power as if it was. We
> > pop out of C3 whenever there is an interrupt, so reducing timer interrupts
> > is good from a power standpoint by amortizing the transition penalty over a
> > longer period of power savings.
> > 
> > But on the other hand, increasing HZ has perf/latency benefits, yes? Have
> > these been quantified? I'd either like to see a HZ that has balanced
> > power/performance, or could we perhaps detect we are on a system that cares
> > about power (aka a laptop) and tweak its value at runtime?
> 
> HZ is used in a LOT of places.  I suspect "tweaking" at run
> time would be a bit difficult.  
This is not a problem at all. Just define HZ as:

extern int system_hz;
#define HZ system_hz

After that all code will use variable HZ. Changing HZ on fly will be
dangerous. However HZ can be made a boot time (LILO) parameter.

> The high-res-timers patch give high resolution timers with
> out changing HZ.  Interrupts are scheculed as needed,
> between the 1/HZ ticks, so a quite system will have few (if
> any) interrupts between the ticks.
> 
> -- 
> George Anzinger   george@mvista.com
> High-res-timers: 
> http://sourceforge.net/projects/high-res-timers/
> Real time sched:  http://sourceforge.net/projects/rtsched/
> Preemption patch:
> http://www.kernel.org/pub/linux/kernel/people/rml
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)

