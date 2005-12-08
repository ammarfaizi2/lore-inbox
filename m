Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932618AbVLHCpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932618AbVLHCpg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 21:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVLHCpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 21:45:36 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:53699 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932618AbVLHCpg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 21:45:36 -0500
Subject: Re: 2.6.14-rt21: slow-running clock
From: john stultz <johnstul@us.ibm.com>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512072254.jB7MshKJ023610@auster.physics.adelaide.edu.au>
References: <200512072254.jB7MshKJ023610@auster.physics.adelaide.edu.au>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 18:45:33 -0800
Message-Id: <1134009933.10613.73.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 09:24 +1030, Jonathan Woithe wrote:
> > > > > When running Ingo's 2.6.14-rt21 (and in fact rt kernels back to at least
> > > > > 2.6.13-rc days), the clock on my i915-based laptop runs slow.  The degree
> > > > > of slowness appears directly related to how busy the machine is.  If
> > > > > it is just sitting around doing very little the time is kept rather
> > > > > well.  However, as soon as the load increases the RTC and system time
> > > > > diverge significantly.  For example, running jackd for 2 minutes results
> > > > > in the system time loosing as much as 20 seconds compared to the CMOS RTC.
> > > > > Processes doing HDD I/O also seem to affect the system time similarly.
> > > > > 
> > > > > Selectively disabling different timer-related kernel options does not make
> > > > > any difference.  However, the clock seems fine under vanilla 2.6.14,
> > > > > suggesting an issue somewhere in the rt patches.
> > > > 
> > > > Could you please send me your dmesg and the output of:
> > > > 
> > > > 	cat  /sys/devices/system/clocksource/clocksource0/*
> > > 
> > > First the contents of the above /sys/ files:
> > > 
> > >   /sys/devices/system/clocksource/clocksource0/current_clocksource:
> > >     c3tsc
> > > 
> > >   /sys/devices/system/clocksource/clocksource0/available_clocksource
> > >     acpi_pm jiffies c3tsc pit
> > 
> > Odd. I'm not sure why the acpi_pm wasn't chosen by default if it was
> > available and the TSC fell back to the c3tsc. It might be something in
> > the -RT tree that's changed that bit. Could you try the following and
> > see if it doesn't resolve the timekeeping problems you're seeing?
> > 
> > echo "acpi_pm" >  /sys/devices/system/clocksource/clocksource0/current_clocksource
> 
> Upon executing the above command the system time started behaving correctly
> once more.

Ok, something in the -rt patches is probably changing the selection
order.

> > Still it sounds like something isn't right w/ either the c3tsc code or
> > the cpufreq notification code.
> 
> That is indeed what it appears.  When c3tsc is in use timing goes haywire.

That narrows it down nicely.

> I'm also wondering whether this might be related to one other thing I
> noticed a week or so back (also reported to the list, but thus far no
> followups). If I enabled the (new) "High resolution timers" feature (as
> distinct from HPET), things like /usr/bin/sleep run for far longer than
> they should irrespective of machine load.  For example, "sleep 1" from bash
> actually delays 38 seconds, not 1 second as expected.

Does disabling the "High resolution timers" feature change the behavior
all?

> > Would you be willing to test further patches?
> 
> Yes.

Great. I'll try to work out something that will give me a better idea of
what exactly is going on.

> > Also could you try booting w/ idle=poll and see if that changes the
> > behavior?
> 
> Booting with idle=poll did indeed alter the behaviour.  Firstly, the
> current_clocksource became tsc, not c3tsc.  Secondly, the
> available_clocksource listed 
> 
>   acpi_pm jiffies tsc pit

Seeing tsc instead of c3tsc is expected. idle=poll avoids letting the
cpu go into C3 mode which halts the TSC. This halting would be bad if we
used the TSC by itself for timekeeping, so we only enable the c3tsc
clocksource if the system starts entering C3 mode.


> In other words, c3tsc wasn't there but tsc was.  In terms of time accuracy
> it seemed that with idle=poll the system time was kept accurately in this
> case as well.  I also noted in dmesg output the following:
> 
>   Time: tsc clocksource has been installed.
> 
> Unlike the normal case (where idle=poll was not specified) there was no
> mention of a "fallback" to a "C3-safe tsc".

Thats very interesting that idle=poll worked around the issue. More
digging will be necessary.

Thanks so much for the great testing and feedback! 
I really appreciate it!
-john



