Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWAPUQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWAPUQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWAPUQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:16:27 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:50323 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751187AbWAPUQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:16:26 -0500
Subject: Re: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3
	oops on suspend and more (bonus oops shot!)]
From: john stultz <johnstul@us.ibm.com>
To: Mattia Dongili <malattia@linux.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060114120816.GA3554@inferi.kami.home>
References: <20060110170037.4a614245.akpm@osdl.org>
	 <15632.83.103.117.254.1136989660.squirrel@picard.linux.it>
	 <20060110235554.GA3527@inferi.kami.home>
	 <20060110170037.4a614245.akpm@osdl.org> <20060111100016.GC2574@elf.ucw.cz>
	 <20060110235554.GA3527@inferi.kami.home>
	 <20060110170037.4a614245.akpm@osdl.org>
	 <20060111184027.GB4735@inferi.kami.home>
	 <20060112220825.GA3490@inferi.kami.home>
	 <1137108362.2890.141.camel@cog.beaverton.ibm.com>
	 <20060114120816.GA3554@inferi.kami.home>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 12:16:21 -0800
Message-Id: <1137442582.27699.12.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-14 at 13:08 +0100, Mattia Dongili wrote:
> On Thu, Jan 12, 2006 at 03:26:01PM -0800, john stultz wrote:
> > On Thu, 2006-01-12 at 23:08 +0100, Mattia Dongili wrote:
> > > [cleaned up some Cc as this is not interesting to all MLs]
> > > first bisection spotted the cause of the stalls at boot (happening while
> > > starting portmap and after usb-storage scan):
> > > 
> > > time-clocksource-infrastructure.patch
> > > time-generic-timekeeping-infrastructure.patch
> > > time-i386-conversion-part-1-move-timer_pitc-to-i8253c.patch
> > > time-i386-conversion-part-2-rework-tsc-support.patch
> > > time-i386-conversion-part-3-enable-generic-timekeeping.patch
> > > time-i386-conversion-part-4-remove-old-timer_opts-code.patch
> > > time-i386-conversion-part-5-acpi-pm-variable-renaming-and-config-change.patch
> > > time-i386-clocksource-drivers.patch
> > > time-fix-cpu-frequency-detection.patch
> > > 
> > > Cc-ed john stultz
> > > 
> > > actually git bisect[1] pointed to time-fix-cpu-frequency-detection.patch
> > > but it's clearly wrong. Reverting all the above patches (I suppose they
> > > are somewhat related) fixes the stalls I experience. I can test
> > > corrections if necessary.
[snip]
> > Looking at the log here:
> > http://oioio.altervista.org/linux/boot-2.6.15-mm2.3
> > 
> > I'm curious if you're getting cpufreq effects during interval while the
> > TSC is being used as a clocksource before we switch to using the acpi_pm
> > clocksource.
> 
> What should I expect? I didn't notice anything in particular and
> actually the box stays alive for just a few minutes, then reiserfs
> explodes so I have no chance to notice anything in the long run.
> 
> > After the system boots up, does it keep accurate time? Time doesn't
> > obviously move too fast or to slow compared to a watch?
> 
> yes, during the short time it stays alive there's no difference between
> my watch and my laptop.

Ok, that's good. It means the ACPI PM clocksource is doing the right
thing.


> > Few things to try (independently):
> > 1. Does booting w/ idle=poll change the behavior?
> 
> yes, no more stalls

Ok, this points to the TSC is changing frequency (likely due to C3
halting). 

> > 2. Does booting w/ clocksource=jiffies change the behavior?
> 
> yes, same as above

Ok, good, interrupts are getting there at the right frequency.

> > 3. After booting up, run: 
> >    echo tsc > /sys/devices/system/clocksource/clocksource0/current_clocksource
> >    And check that the system keeps accurate time.
> 
> didn't try as there seems to be no problem in timekeeping

Well, it would have re-inforced the TSC being the issue, but I'm fairly
confident that that is the case.


My theory: The stalls are due to the TSC frequency not being consistent
for the small window at boot between when it is installed and when the
ACPI PM clocksource is installed.

I'll try to narrow that window down a bit and see if that doesn't
resolve the issue.

thanks
-john


