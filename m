Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVFTWoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVFTWoK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 18:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVFTWoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:44:08 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:48038 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262284AbVFTWFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:05:35 -0400
Date: Tue, 21 Jun 2005 00:05:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
In-Reply-To: <1119287354.9947.22.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.61.0506202231070.3728@scrub.home>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.61.0506181344000.3743@scrub.home> <1119287354.9947.22.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 20 Jun 2005, john stultz wrote:

> > I see lots of new u64 variables. I'm especially interested how this code 
> > scales down to small and slow machines, where such a precision is absolute 
> > overkill. How do these patches change current and possibly common time 
> > operations?
> 
> 
> Hey Roman, 
> 	That's a good issue to bring up. With regards to the timeofday
> infrastructure, there are two performance concerns (though let me know
> if I'm forgetting something):

You don't really answer the core question, why do you change everything to 
nanoseconds and 64bit values?

> On smaller systems, timer interrupt processing is a concern, with the
> shift to HZ=1000, we got a number of complaints from folks w/ old 486s
> where time would drift due lost ticks. This would happen when something
> (usually IDE in PIO mode) would disable interrupts and they would miss a
> ton of timer interrupts. Also the impact of running the timekeeping code
> 10x more frequently was seen in a number of cases.
> 
> With the new infrastructure, timekeeping is all done via a soft-timer
> outside of interrupt context. In fact, the timekeeping soft-timer is
> setup to run every 50ms instead of every ms. This should help overall
> performance on slower systems using high HZ values.

With -mm you can now choose the HZ value, so that's not really the 
problem anymore. A lot of archs even never changed to a higher HZ value. 
So now I still like to know how does the complexity change compared to the 
old code?

> As for gettimefoday() syscall performance, I one had some numbers, but I
> would need to re-create them. I'll see if I can grab a slower box and
> give you some hard numbers. The gettimeofday() path is fairly
> streamlined and should be pretty straight forward in the patch (see
> kernel/timeofday.c), so let me know if you have specific concerns. 
> 
> There will probably be a bit of a drop, but I have some ideas for
> cacheing a precomputed timeval in the timekeeping soft-timer if its a
> serious issue.

Well, AFAICT on slower machines (older and embedded stuff) it's a serious 
issue. The current code calculates the timeval with some simple 32bit 
calculations. Your code introduces the nsec step, which means several 
64bit calculations and suddenly the overhead explodes on some machines.

As m68k maintainer I see no reason to ever switch to your new code, which 
might leave you with the dilemma having to maintain two versions of the 
timer code. What reason could I have to switch to the new timer code?

I had no problems with a little more overhead, like a _few_ more 64bit 
operations per second (and preferably add/shifts), but I'm not really 
enthusiastic about the new code. Why don't you keep the main part 32 bits 
(or long)? What's wrong with using timeval or timespec?

I like the concept of the a time source in your patch. m68k already uses a 
number of timer related callbacks into machine specific code. If I could 
replace that with a timer driver, I'd be really happy. OTOH if it requires 
several expensive conversion between different time formats, I rather keep 
the current code.

bye, Roman
