Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVAURg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVAURg4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 12:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbVAURg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 12:36:56 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:45979 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262428AbVAURgg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 12:36:36 -0500
Date: Fri, 21 Jan 2005 09:35:49 -0800
From: Tony Lindgren <tony@atomide.com>
To: George Anzinger <george@mvista.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Pavel Machek <pavel@suse.cz>,
       john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050121173549.GC14554@atomide.com>
References: <20050119000556.GB14749@atomide.com> <20050119094342.GB25623@elf.ucw.cz> <20050119171323.GB14545@atomide.com> <20050119174858.GB12647@dualathlon.random> <41EEE648.2010309@mvista.com> <20050119231702.GJ14545@atomide.com> <41EEFA4A.4070605@mvista.com> <20050120080441.GF9975@atomide.com> <41F03A65.8040707@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F03A65.8040707@mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* George Anzinger <george@mvista.com> [050120 15:10]:
> Tony Lindgren wrote:
> >* George Anzinger <george@mvista.com> [050119 16:25]:
> >
> >>Tony Lindgren wrote:
> >>
> >>>* George Anzinger <george@mvista.com> [050119 15:00]:
> >>>
> >>>
> >>>>I don't think you will ever get good time if you EVER reprogramm the 
> >>>>PIT. That is why the VST patch on sourceforge does NOT touch the PIT, 
> >>>>it only turns off the interrupt by interrupting the interrupt path (not 
> >>>>changing the PIT).  This allows the PIT to be the "gold standard" in 
> >>>>time that it is designed to be.  The wake up interrupt, then needs to 
> >>>>come from an independent timer.  My patch requires a local APIC for 
> >>>>this.  Patch is available at 
> >>>>http://sourceforge.net/projects/high-res-timers/
> >>>
> >>>
> >>>Well on my test systems I have pretty good accurate time. But I agree,
> >>>PIT is not the best option for interrupt. It should be possible to use
> >>>other interrupt sources as well.

But then again reprogramming PIT in my patch should not be that bad,
as it's not done under load.

> >>>It should not matter where the timer interrupt comes from, as long as 
> >>>it comes when programmed. Updating time should be separate from timer
> >>>interrupts. Currently we have a problem where time is tied to the
> >>>timer interrupt.
> >>
> >>In the HRT code time is most correctly stated as wall_time + 
> >>get_arch_cycles_since(wall_jiffies) (plus conversion or two:)).  This is 
> >>some what removed from the tick interrupt, but is resynced to that 
> >>interrupt more or less each interrupt.
> >
> >
> >That sounds very accurate :)
> >
> >
> >>A second issue is trying to get the jiffies update as close to the run of 
> >>the timer list as possible.  Without this we have no hope of high res 
> >>timers.
> >
> >
> >OK. But if the timer interrupt is separated from updating the time,
> >the next timer interrupt should be programmable to happen exactly
> >when a HRT timer needs it, right?
> 
> First, HRT uses a two phase system of timing.  The first phase is the 
> normal timer list expires the timer.  The timer is then handed to the high 
> res code which keeps a list of timers that are to expire prior to the next 
> jiffie.  An interrupt is scheduled to make this happen.  Depending on the 
> hardware available, this can come from the same timer or a different timer. 
> For example on x86 systems with a local apic we use the apic timer to 
> generate this interrupt.  It triggers either a tasklet for UP or SMP with 
> out per cpu timers or a soft irq for SMP systems with per cpu timers.
> 
> What this means is that, for timers near but just after a jiffie, the 
> run_timer list being late can make the HR timer late.

Thanks for explaining that. So basically catching up with jiffies after
skipping ticks could easily delay the HRT timer.

If jiffies was calculated from hw timer, updating time after skipping
jiffies would be fast, and then this problem would go away, right?

> This code on on sourceforge if you want a closer look...

I'll take a look at it.

> >Hmm, how about using a pool of programmable timers available on the 
> >system for the timer interrupts and HRT? Or is one interrupt source
> >always enough?
> 
> Hardware heaven :), but no thanks.  A reliable tick generator for the 
> jiffies timer and one additional timer (or one per cpu) works well in the 
> x86.
> 
> If you have something like the PPC where you can mess with the timer with 
> out loosing time, that works well also.  The correct formulation would be a 
> "clock" that can be read quickly and a timer tied to the same "rock" that 
> uses the same count units as the clock.  PARISC has a counter that just 
> counts and a compare register.  When they are equal an interrupt is 
> generated.  That is a nice set up.

Yes, many ARMs have this setup as well.

> Now the X86 is bad and has little hope of being fixed for these reasons:
> a.) the TSC is fast and easy to read but its not clocked at any given 
> frequency and, on some platforms, it changes without notifying the software.
> b.) the PIT and the PMTIMER are both in I/O space and so take forever to 
> access.
> c.) All three of these use different units (but at least the PMTIMER is 
> (supposed to be) related to the PIT clock.
> d.) the HPET, again is in I/O space.  I suspect that it uses a reasonable 
> "rock" but, as I understand it, it knocks out the PIT and, of course it 
> uses units unrelated to all the others.

The timers on x86 are quite messy...

Tony
