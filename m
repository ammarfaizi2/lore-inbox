Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVFUAKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVFUAKt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 20:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVFUAKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 20:10:16 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:47285 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261859AbVFTXzh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:55:37 -0400
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <Pine.LNX.4.61.0506202231070.3728@scrub.home>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506181344000.3743@scrub.home>
	 <1119287354.9947.22.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506202231070.3728@scrub.home>
Content-Type: text/plain
Date: Mon, 20 Jun 2005 16:55:34 -0700
Message-Id: <1119311734.9947.143.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 00:05 +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 20 Jun 2005, john stultz wrote:
> 
> > > I see lots of new u64 variables. I'm especially interested how this code 
> > > scales down to small and slow machines, where such a precision is absolute 
> > > overkill. How do these patches change current and possibly common time 
> > > operations?
> > 
> > 
> > Hey Roman, 
> > 	That's a good issue to bring up. With regards to the timeofday
> > infrastructure, there are two performance concerns (though let me know
> > if I'm forgetting something):
> 
> You don't really answer the core question, why do you change everything to 
> nanoseconds and 64bit values?


Well, for a reasonable range of timesource frequencies and interval
lengths, the cycle values needs to be 64 bits wide and the mult/shift
operation to convert cycles to time is going to need to done with 64
bits.

Since xtime is currently a timespec, we already keep nanosecond
precision using 64 bits. It was then just a question of how complicated
is it to do the manipulations with timespecs vs flat 64 bits worth of
nanoseconds.  Nanoseconds made the design cleaner, so I went with them
keeping the option to optimize in the future when real issues arose. 


> > On smaller systems, timer interrupt processing is a concern, with the
> > shift to HZ=1000, we got a number of complaints from folks w/ old 486s
> > where time would drift due lost ticks. This would happen when something
> > (usually IDE in PIO mode) would disable interrupts and they would miss a
> > ton of timer interrupts. Also the impact of running the timekeeping code
> > 10x more frequently was seen in a number of cases.
> > 
> > With the new infrastructure, timekeeping is all done via a soft-timer
> > outside of interrupt context. In fact, the timekeeping soft-timer is
> > setup to run every 50ms instead of every ms. This should help overall
> > performance on slower systems using high HZ values.
> 
> With -mm you can now choose the HZ value, so that's not really the 
> problem anymore. A lot of archs even never changed to a higher HZ value. 
> So now I still like to know how does the complexity change compared to the 
> old code?

Well, even if it is less of a concern with lower HZ values, my code
should still reduce the interrupt overhead for those who would like to
have higher HZ values to improve latency. (Although until I have
numbers, its all just talk. :)


> > As for gettimefoday() syscall performance, I one had some numbers, but I
> > would need to re-create them. I'll see if I can grab a slower box and
> > give you some hard numbers. The gettimeofday() path is fairly
> > streamlined and should be pretty straight forward in the patch (see
> > kernel/timeofday.c), so let me know if you have specific concerns. 
> > 
> > There will probably be a bit of a drop, but I have some ideas for
> > cacheing a precomputed timeval in the timekeeping soft-timer if its a
> > serious issue.
> 
> Well, AFAICT on slower machines (older and embedded stuff) it's a serious 
> issue. The current code calculates the timeval with some simple 32bit 
> calculations. Your code introduces the nsec step, which means several 
> 64bit calculations and suddenly the overhead explodes on some machines.
> 
> As m68k maintainer I see no reason to ever switch to your new code, which 
> might leave you with the dilemma having to maintain two versions of the 
> timer code. What reason could I have to switch to the new timer code?
> 
> I had no problems with a little more overhead, like a _few_ more 64bit 
> operations per second (and preferably add/shifts), but I'm not really 
> enthusiastic about the new code. Why don't you keep the main part 32 bits 
> (or long)? What's wrong with using timeval or timespec?

Well, I think the only overhead to be worried with is just in
gettimeofday(), but let me get some hard numbers to show that. I've
already implemented some optimized caching for x86-64's vsyscall-gtod
implementation, so let me also try to make an arch generic version and
see if I cannot settle your concerns.

> I like the concept of the a time source in your patch. m68k already uses a 
> number of timer related callbacks into machine specific code. If I could 
> replace that with a timer driver, I'd be really happy. OTOH if it requires 
> several expensive conversion between different time formats, I rather keep 
> the current code.

Thanks, I really appreciate your review and feedback. I very much want
this to be a solution everyone can be happy (or at least indifferent)
with.

thanks
-john

