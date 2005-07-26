Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVGZBD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVGZBD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 21:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVGZBD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 21:03:26 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:31892 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261588AbVGZBDY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 21:03:24 -0400
Subject: Re: [RFC - 0/12] NTP cleanup work (v. B4)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <Pine.LNX.4.61.0507210151570.3728@scrub.home>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0507171706490.3728@scrub.home>
	 <1121876812.4259.14.camel@leatherman>
	 <Pine.LNX.4.61.0507210151570.3728@scrub.home>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 18:03:17 -0700
Message-Id: <1122339797.30963.48.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-21 at 12:39 +0200, Roman Zippel wrote:
> Hi,
> 
> On Wed, 20 Jul 2005, john stultz wrote:
> 
> > I really don't think the NTP changes I've mailed is very complex.
> > Please, be specific and point to something you think is an issue and
> > I'll do my best to fix it.
> 
> Maybe I should explain, in what direction I would take it.
> Let's first only take tick based updates, one property I don't want to see 
> go away (and which you remove in the last patch), is to basically update 
> xtime at every tick by (tick_nsec+time_adj) (and maybe fold time_adjust 
> into time_adj), no multiply/divide just adds/shifts. Every second (or 
> maybe even less frequently) we update time_adj, where we even might 
> integrate a better to way to add previous errors due to SHIFT_HZ.

Hmm. Ok, would something like ntp_static_interval_adjustment() or
whatnot be a decent interface to provide a fixed single tick adjustment
as precalculated by the NTP state machine?  Similar to what I have in
patch 10, but via a separate interface?

> To add support for continous time sources, the generic ntp code would just 
> provide [tick,frequency,offset] values and the time source converts it 
> into its internal values. A tick based source calculates [tick_nsec, 
> time_adj] and a continous source calculates the [offset,multiplier]. These 
> values should be recalculated as infrequently as possible and not every 
> single tick as you do with ppc_adjtimex. This also means a continous 
> source updates xtime basically by calling gettimeofday (what ppc64 already 
> almost does) and doesn't use update_wall_time() at all.

Yep, that sounds doable. Although yes, the ppc_adjtimex is more
overhead, I went with the worse implementation to scratch out my idea
adn see if the ppc folks might scream and suggest the proper way.


> Maybe I'm missing something, but I don't see a reason to forcibly merge 
> both ways to update the clock, keep them seperate and let the generic ntp 
> code provide the basic parameters which the time source uses to update the 
> clock. The important thing is to precalculate as much as possible, so that 
> the runtime overhead is as low as possible and these precalculations 
> differ between time sources, so what your patches basically do is to 
> remove all of these precalculations and I can't convince myself to see 
> this as a good thing.

I don't know if that's the case. I am precalculating things, but maybe
we're misunderstanding each other. Regardless, yes, for the tick based
systems that can't go continuous I can preserve the existing behavior
(if not possibly improve it some).


> BTW do you have any user space test code for this? This might be useful to 
> verify that the changes are really correct and a prototype might be a good 
> way to demonstrate the kernel changes.

I do not right now, after seeing Rusty's talk at OLS this sounds like
quite a nice idea. I was thinking of a simple simulator that has two
files: the first a list of hardware time values and and the second a
list of operations (gettimeofday, timer_interrupt, adjtimex). We can
then generate time sequences and action sequences and run them through
the simulator of both the current and old implementations.

Not that this is completely trivial to do, but it did seem like a good
idea. I'll see what I can do. 

thanks
-john

