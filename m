Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbULVUEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbULVUEi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 15:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbULVUEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 15:04:36 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:40578 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262030AbULVUEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 15:04:32 -0500
Date: Wed, 22 Dec 2004 12:02:54 -0800
From: Tony Lindgren <tony@atomide.com>
To: linux-os@analogic.com
Cc: Pavel Machek <pavel@suse.cz>, john stultz <johnstul@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
Message-ID: <20041222200254.GH13717@atomide.com>
References: <20041213125844.GY16322@dualathlon.random> <20041213191249.GB1052@elf.ucw.cz> <1102970039.1281.415.camel@cog.beaverton.ibm.com> <20041213204933.GA4693@elf.ucw.cz> <20041214013924.GB14617@atomide.com> <20041214093735.GA1063@elf.ucw.cz> <20041214211814.GA31226@atomide.com> <20041214220646.GC19218@elf.ucw.cz> <Pine.LNX.4.61.0412141751590.20391@chaos.analogic.com> <20041214231300.GD31226@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214231300.GD31226@atomide.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [041214 16:22]:
> * linux-os <linux-os@chaos.analogic.com> [041214 15:04]:
> > On Tue, 14 Dec 2004, Pavel Machek wrote:
> > 
> > >Hi!
> > >
> > >>>>The patch in question is at:
> > >>>>
> > >>>>http://linux-omap.bkbits.net:8080/main/user=tmlind/patch@1.2016.4.18?nav=!-|index.html|stats|!+|index.html|ChangeSet@-12w|cset@1.2016.4.18
> > >>>
> > >>>Wow, that's basically 8 lines of code plus driver for new
> > >>>hardware... Is it really that simple?
> > >>
> > >>Yeah, the key things are reprogramming the timer in the idle loop
> > >>based on next_timer_interrupt(), and calling timer_interrupt from
> > >>other interrupts as well :)
> > >>
> > >>Should we try a similar patch for x86/amd64? I'm not sure which timers
> > >>to use though? One should be programmable length for the interrupt,
> > >>and the other continuous for the timekeeping.
> > >
> > >Yes, it would certainly be interesting. 5% power savings, and no
> > >singing capacitors, while keeping HZ=1000. Sounds good to me.
> > >
> > >There are about 1000 timers available in PC, each having its own
> > >quirks. CMOS clock should be able to generate 1024Hz periodic timer
> > >(we currently do not use) and TSC we currently use for periodic timer
> > >should be usable in single-shot mode.
> > >								Pavel
> > >--
> > 
> > If you use that RTC timer, it needs to be something that can be
> > turned OFF. Many embedded applications use that because its the
> > only timer that the OS doesn't muck with. It also has very low
> > noise which makes in a good timing source for IIR filters for
> > high precision, low data-rate data acquisition (like 24 bits).
> 
> OK, thanks for the information. That could be the continuous timer
> then, and TSC the periodic timer.
> 
> > Since it generates an edge, its interrupt can't be shared.
> > I certainly hope that you don't use it. One can read the
> > time without disturbing the interrupt rate. One just
> > needs to use the existing rtc_lock and not spin with
> > the lock being held.
> 
> Yeah, the timer update would be just a read from the RTC timer.
> 
> > Currently the kernel RTC software allocates the RTC interrupt
> > even though it doesn't use it. This makes it necessary to
> > compile the RTC as a module and then remove it when another
> > driver needs to use the RTC interrupt source.
> 
> The interrupt could be used for timer wrap only.

Well just to follow up, I did some experiments over the weekend on
my old athlon box, and looks like it's doable. I'll set up something
common where various timers can register their no-tick functions.

So far I have APIC timer doing the no-tick interrupts, and nothing
yet for the timer to update time from. The code will using whatever
timers as long as they implement the right functions.

I'll post some patches when I have something working... Probably
after the holidays.

Tony
