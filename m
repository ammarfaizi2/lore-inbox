Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbVLGWxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbVLGWxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbVLGWxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:53:12 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:46722 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S1030422AbVLGWxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:53:08 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200512072254.jB7MshKJ023610@auster.physics.adelaide.edu.au>
Subject: Re: 2.6.14-rt21: slow-running clock
To: johnstul@us.ibm.com (john stultz)
Date: Thu, 8 Dec 2005 09:24:42 +1030 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
       linux-kernel@vger.kernel.org
In-Reply-To: <1133928070.10613.19.camel@cog.beaverton.ibm.com> from "john stultz" at Dec 06, 2005 08:01:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > When running Ingo's 2.6.14-rt21 (and in fact rt kernels back to at least
> > > > 2.6.13-rc days), the clock on my i915-based laptop runs slow.  The degree
> > > > of slowness appears directly related to how busy the machine is.  If
> > > > it is just sitting around doing very little the time is kept rather
> > > > well.  However, as soon as the load increases the RTC and system time
> > > > diverge significantly.  For example, running jackd for 2 minutes results
> > > > in the system time loosing as much as 20 seconds compared to the CMOS RTC.
> > > > Processes doing HDD I/O also seem to affect the system time similarly.
> > > > 
> > > > Selectively disabling different timer-related kernel options does not make
> > > > any difference.  However, the clock seems fine under vanilla 2.6.14,
> > > > suggesting an issue somewhere in the rt patches.
> > > 
> > > Could you please send me your dmesg and the output of:
> > > 
> > > 	cat  /sys/devices/system/clocksource/clocksource0/*
> > 
> > First the contents of the above /sys/ files:
> > 
> >   /sys/devices/system/clocksource/clocksource0/current_clocksource:
> >     c3tsc
> > 
> >   /sys/devices/system/clocksource/clocksource0/available_clocksource
> >     acpi_pm jiffies c3tsc pit
> 
> Odd. I'm not sure why the acpi_pm wasn't chosen by default if it was
> available and the TSC fell back to the c3tsc. It might be something in
> the -RT tree that's changed that bit. Could you try the following and
> see if it doesn't resolve the timekeeping problems you're seeing?
> 
> echo "acpi_pm" >  /sys/devices/system/clocksource/clocksource0/current_clocksource

Upon executing the above command the system time started behaving correctly
once more.

> Still it sounds like something isn't right w/ either the c3tsc code or
> the cpufreq notification code.

That is indeed what it appears.  When c3tsc is in use timing goes haywire.

I'm also wondering whether this might be related to one other thing I
noticed a week or so back (also reported to the list, but thus far no
followups). If I enabled the (new) "High resolution timers" feature (as
distinct from HPET), things like /usr/bin/sleep run for far longer than
they should irrespective of machine load.  For example, "sleep 1" from bash
actually delays 38 seconds, not 1 second as expected.

> Would you be willing to test further patches?

Yes.

> Also could you try booting w/ idle=poll and see if that changes the
> behavior?

Booting with idle=poll did indeed alter the behaviour.  Firstly, the
current_clocksource became tsc, not c3tsc.  Secondly, the
available_clocksource listed 

  acpi_pm jiffies tsc pit

In other words, c3tsc wasn't there but tsc was.  In terms of time accuracy
it seemed that with idle=poll the system time was kept accurately in this
case as well.  I also noted in dmesg output the following:

  Time: tsc clocksource has been installed.

Unlike the normal case (where idle=poll was not specified) there was no
mention of a "fallback" to a "C3-safe tsc".

For interest I also booted a plain 2.6.14 kernel to see how the clocksources
were set up there.  However, the /sys/devices/system/clocksource/ directory
did not exist under this kernel version so I wasn't able to conclude anything
(other than the fact that /sys/devices/system/clocksource/ must be something
added by the rt patchset).  There also wasn't any dmesg output of the
form
  Time: ...

Regards
  jonathan
