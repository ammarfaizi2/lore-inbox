Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270654AbTHORu4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 13:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270659AbTHORu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 13:50:56 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:52893 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S270654AbTHORuy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 13:50:54 -0400
Subject: Re: PIT, TSC and power management [was: Re: 2.6.0-test3 "loosing
	ticks"]
From: john stultz <johnstul@us.ibm.com>
To: Charles Lepple <clepple@ghz.cc>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3F3C272E.7060702@ghz.cc>
References: <20030813014735.GA225@timothyparkinson.com>
	 <1060793667.10731.1437.camel@cog.beaverton.ibm.com>
	 <20030814171703.GA10889@mail.jlokier.co.uk>
	 <1060882084.10732.1588.camel@cog.beaverton.ibm.com>
	 <3F3C272E.7060702@ghz.cc>
Content-Type: text/plain
Organization: 
Message-Id: <1060969733.10731.1604.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Aug 2003 10:48:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-14 at 17:19, Charles Lepple wrote:
> I also see the time offset problem (Athlon MP 2000+ x2, Tyan S2460 m/b, 
> 2.6.0-test{1,2,3}) but it is most noticeable when I have amd76x_pm 
> installed (it's not in 2.6.x yet, but a late 2.5.x patch was posted to 
> LKML a little while back).
> 
> amd76x_pm is roughly equivalent to ACPI C2 idling, but since my BIOS 
> doesn't export any C-state functionality to the kernel ACPI code, I am 
> stuck with letting amd76x_pm frob the chipset registers. A quick look at 
> AMD's datasheets does not indicate that a return from C2 should cause 
> much delay at all-- if I understand the timing requirements correctly, 
> it would have to sit for more than 1 ms to miss more than one interrupt. 
> That said, I don't see any missing interrupts indicated in 
> /proc/interrupts, nor do any such messages appear in the kernel logs.

In this case you're throttling the cpu frequency. This affects the
frequency the TSC updates, which makes it very hard to use the TSC as a
timesource (the cpu_freq notifier tries to compensate by changing the
tsc multiplier but my systems don't have cpu_freq drivers, so I've not
seen it work). 

> Brings up another question: does the "try HZ=100" suggestion still apply 
> for these faster machines? I would think that if HZ=1000 is too fast, 
> then at least an occasional lost interrupt would be logged.

If you're losing interrupts and the lost-tick detection code is not
compensating, shifting back to HZ=100 just tries to minimize the
problem. 

 
> When using the TSC for time-of-day, I generally have to set tick to 
> 10200 or somewhere thereabouts. ntpd usually gives up after a few hours, 
> though, so I presume that this value for tick is only good for a certain 
> combination of processor load and planetary alignment.
> 
> I booted with clock=pit to test that, and now I need tick=9963 
> (according to adjtimex's configuration routine). However, that makes the 
> clock jump all over the place, with ntpd making step adjustments +/- 2 
> seconds every 5 minutes.
> 
> > Approximately at what rate does it skew?
> 
> Well, it's not constant, and I don't trust the tick values given above, 
> since they don't seem to hold true for long.


Do these problems still show when you're not using the amd76x_pm?


> > Does ntpdate -b <server> set it properly?
> 
> I'm confused. Are there cases where a step time adjustment would fail? 
> Is there a possibility that the kernel is rejecting ntpd's step 
> adjustments? (I presume that these use the same as 'ntpdate -b'; 
> specifically, the time is not slewed.)

Well, depending on how ntp is compiled, it could use stime, rather then
settimeofday. This causes ntp to set the time on average .5 seconds off
the desired time. Since .5 is outside the .128 sec slew boundary, ntp 
will do another step adjustment which has the same poor accuracy. This
results in ntp just hopping back and forth around the desired time. 

thanks
-john


