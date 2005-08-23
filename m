Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVHWSwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVHWSwj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 14:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVHWSwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 14:52:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:27349 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932274AbVHWSwi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 14:52:38 -0400
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, George Anzinger <george@mvista.com>,
       frank@tuxrocks.com, Anton Blanchard <anton@samba.org>,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.61.0508230134210.3728@scrub.home>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508152115480.3728@scrub.home>
	 <1124151001.8630.87.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508162337130.3728@scrub.home>
	 <1124241449.8630.137.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508182213100.3728@scrub.home>
	 <1124505151.22195.78.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508202204240.3728@scrub.home>
	 <1124737075.22195.114.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0508230134210.3728@scrub.home>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 11:52:24 -0700
Message-Id: <1124823150.22195.137.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-23 at 13:30 +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 22 Aug 2005, john stultz wrote:
> 
> > The reason why we calculate the interval_length in the continuous
> > timesource case is because we are not assuming anything about the
> > frequency that the timekeeping_periodic_hook() is called.
> 
> The problem with your patch is that it doesn't allow making such 
> assumptions.
> Anyway, it's rather simple, if you want to update the time asynchronously:
> 
> 	cycle_offset = get_cycles() - last_update;
> 
> 	while (cycle_offset >= update_cycles) {
> 		cycle_offset -= update_cycles;
> 		last_update += update_cycles;
> 		// at init: system_update = update_cycles * mult;
> 		system_time += system_update;
> 		xtime += [tick_nsec, time_adj];
> 	}
> 
> 	error = system_time - (xtime.tv_nsec << shift);
> 
> 	if (abs(error) > update_cycles/2) {
> 		mult_adj = (error +- update_cycles/2) / update_cycles;
> 		mult += mult_adj;
> 		system_update += mult_adj * update_cycles;
> 		system_time -= mult_adj * cycle_offset;
> 		error -= mult_adj * cycle_offset;
> 	}
> 
> 	if (xtime.tv_nsec + (error >> shift) > NSEC_PER_SEC) {
> 		system_time -= NSEC_PER_SEC << shift;
> 		second_overflow();
> 	}


AH! Ok, now I get it. Forgive me for being so dense, but code is just so
much more concrete and understandable. Let me take a swing at
integrating some of this idea into my code and then we can go around
again. :)


> The last one may become a bit of a challenge to keep as much as possible 
> code common without abusing the preprocessor too much. In any case some 
> functions will differ completely anyway, especially gettimeofday will be 
> optimized differently depending on the arch/clock requirements, OTOH
> introducing a common gettimeofday (that would even require a 64bit 
> divide) would be a huge mistake.

I'd always want to allow for arch specific implementations, but there
are many cases where the code is doing the exact same thing, so I'd like
to at least consolidate those users. No divides in the hot-path are
necessary.

Thanks again for the review and patience. I really do appreciate it.

thanks
-john

