Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVFUPJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVFUPJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVFUPJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:09:49 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:5804 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262101AbVFUPIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:08:38 -0400
Date: Tue, 21 Jun 2005 17:08:30 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
In-Reply-To: <1119311734.9947.143.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0506211542580.3728@scrub.home>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.61.0506181344000.3743@scrub.home>  <1119287354.9947.22.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.61.0506202231070.3728@scrub.home> <1119311734.9947.143.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 20 Jun 2005, john stultz wrote:

> > You don't really answer the core question, why do you change everything to 
> > nanoseconds and 64bit values?
> 
> 
> Well, for a reasonable range of timesource frequencies and interval
> lengths, the cycle values needs to be 64 bits wide and the mult/shift
> operation to convert cycles to time is going to need to done with 64
> bits.
> 
> Since xtime is currently a timespec, we already keep nanosecond
> precision using 64 bits. It was then just a question of how complicated
> is it to do the manipulations with timespecs vs flat 64 bits worth of
> nanoseconds.  Nanoseconds made the design cleaner, so I went with them
> keeping the option to optimize in the future when real issues arose. 

That might be the case, but your patch makes it very hard to verify.
You don't fix the old code, you just drop in a complete new 
implementation, so you have to explain it a bit more.
What's exactly wrong with old design and why wasn't possible to fix it 
incrementally? How exactly is your new design superior?

> > With -mm you can now choose the HZ value, so that's not really the 
> > problem anymore. A lot of archs even never changed to a higher HZ value. 
> > So now I still like to know how does the complexity change compared to the 
> > old code?
> 
> Well, even if it is less of a concern with lower HZ values, my code
> should still reduce the interrupt overhead for those who would like to
> have higher HZ values to improve latency. (Although until I have
> numbers, its all just talk. :)

For machines where it actually matters, I can only see that calculations 
have gotten more complex and thus slower. You need to provide a little 
more detailed information, why this necessary.

> Well, I think the only overhead to be worried with is just in
> gettimeofday(), but let me get some hard numbers to show that. I've
> already implemented some optimized caching for x86-64's vsyscall-gtod
> implementation, so let me also try to make an arch generic version and
> see if I cannot settle your concerns.

I don't need any practical numbers, I can already see from the code, that 
it's much worse and unless you eliminate the 64bit calculations from the 
fast path, I don't know what you are trying to optimize.

> > I like the concept of the a time source in your patch. m68k already uses a 
> > number of timer related callbacks into machine specific code. If I could 
> > replace that with a timer driver, I'd be really happy. OTOH if it requires 
> > several expensive conversion between different time formats, I rather keep 
> > the current code.
> 
> Thanks, I really appreciate your review and feedback. I very much want
> this to be a solution everyone can be happy (or at least indifferent)
> with.

I would seriously suggest you rework the first patch and fix the existing 
code instead or you have to explain why the current code is unfixable, but 
that would require to actually replace the old code. Having two 
alternative implementations is really the worst solution.

John, you are _very_ vague here, could you please go into more detail, why 
you did certain design decisions? "Simplicity" can't be the only reason, 
good perfomance is far more important.

bye, Roman
