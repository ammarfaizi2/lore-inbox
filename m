Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268928AbUJTSUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268928AbUJTSUW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268982AbUJTSRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:17:14 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:56028 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S268987AbUJTSN4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:13:56 -0400
Subject: Re: gradual timeofday overhaul
From: john stultz <johnstul@us.ibm.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>
In-Reply-To: <Pine.LNX.4.53.0410200441210.11067@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.61.0410192015420.6471@knorkaan.xs4all.nl>
	 <1098216701.20778.78.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0410200233280.9510@gockel.physik3.uni-rostock.de>
	 <1098233967.20778.93.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0410200441210.11067@gockel.physik3.uni-rostock.de>
Content-Type: text/plain
Message-Id: <1098296039.20778.150.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 20 Oct 2004 11:13:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 20:05, Tim Schmielau wrote:
> On Tue, 19 Oct 2004, john stultz wrote:
> 
> > As for the timeofday overhaul, I've had zero time to work on it
> > recently. I hate that I dropped code and then went missing for weeks.
> > I'll have to see if I can get a few cycles at home to sync up my current
> > tree and send it out. 
> 
> I still haven't looked at your code and it's discussion. From what I
> remember, I liked your proposal very much. It's surely where we want to
> end up someday. But from the above mail it strikes me that we just don't
> have enough manpower to get there all at once, so we should have a plan 
> for the time code to gradually evolve into what we finally want. I think 
> we could do it in the following steps:
> 
>   1. Sync up jiffies with the monotonic clock...
> 
>   2. Decouple jiffies from the actual interrupt counter...
> 
>   3. Increase HZ all the way up to 1e9....
> Thoughts?

They all sound good. I like the notion of basing jiffies off of system
time, rather then interrupt counts. However, I'm a little cautious of
changing the meaning of jiffies too drastically. 

Right now jiffies has two core meanings:
1. Count of the number of timer ticks that have passed.
2. Accurate system uptime, measured in units of 1/HZ
(Let me know if I forgot any others)

The problem being, neither of those meaning are 100% true. 
#1 isn't true because when we loose timer ticks, we try to compensate
for them (i386 specifically). But at the same time #2 isn't true because
the timer interrupts don't necessarily run at exactly HZ (again, i386
specifically).

Basically due to our hardware constraints, we need to break one of these
two assumptions. The problem is which do we choose? 

Do we base jiffies off of monotonic_clock(), guaranteeing #2 and
possibly breaking anyone who is assuming #1? Or do we change all users
of jiffies for time to use monotonic_clock, guaranteeing #1, which will
require quite a bit of work.

And which choice makes it harder for folks to create tickless systems?
Its a tough call.

On top of that, we still have the issue that the current  interpolation
used in the time of day subsystem is broken (in my opinion), and we need
to fix that before we can have a reliable monotonic_clock. 

The joke being of course that I'll need to set my /etc/ntp/ntp.drift
file to 500 to find the time to work on any of this. And really, anyone
who really found that funny needs to go home.

thanks
-john

