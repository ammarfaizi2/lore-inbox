Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUIORXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUIORXu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266708AbUIORWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:22:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:25532 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266643AbUIORST
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:18:19 -0400
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: george anzinger <george@mvista.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <Pine.LNX.4.58.0409150940420.1249@schroedinger.engr.sgi.com>
References: <1095265942.29408.2847.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409150940420.1249@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1095268408.29408.2918.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 15 Sep 2004 10:13:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-15 at 09:46, Christoph Lameter wrote:
> On Wed, 15 Sep 2004, john stultz wrote:
> 
> > > struct time_source_t {
> > > 	u8 type;
> > > 	u8 shift;
> > > 	u32 multiply;
> > > 	void *address;
> > > 	u64 mask;
> > > 	int (*interrupt_at)(u64 counter_value);
> > > };
> >
> > Could you explain the interrupt_at function further?
> 
> Generates a timer interrupt when a certain counter value has been reached.
> This is a common feature of most clock chips that I am aware of.

Well, not all time sources have that feature. Both TSC, and cyclone
don't. You'd have to do something else for those. This is why my
proposal has absolutely nothing to do with interrupt generation. It has
a single hook that needs to be called only every once in a while, which
can be done however any architecture wants. 

Interrupt generation has more to do with soft-timers and scheduling then
time of day anyway. 

> > > 	make_time_source(1200000000, TIME_SOURCE_FUNCTION, cpu_time_filtered, 44, itm_setup);
> >
> > Out of curiosity, what happens in your fsyscall code in these cases
> > where TIME_SOURCE_FUNCTION is used?
> 
> It backs out of the fast call track and does a regular call instead.

Ok, just curious. 

> > > /* simulation of the old tick behavior */
> > > tick(u64 when) {
> > > 	/* do tick stuff */
> > >
> > > 	/* time base update .... */
> > > 	time_source_adjust(0);
> > > 	/* Schedule next timer tick */
> > > 	event_new(when + NSEC_PER_SEC / HZ , tick,  when + NSEC_PER_SEC / HZ);
> > > }
> >
> > Hmm. This is getting somewhat tangled in my mind. Who is calling tick()
> > originally? How is event_run being called?
> 
> This is just some toying around with the concept. Maybe tick could be
> called by the regular timer interrupt?

Ok, no worries. Its just one of the big reasons I started my earlier
proposal is to lessen the dependencies and cleanup the interactions
between the interrupt generation, soft-timer and the time of day code. 


> > > /* New tick would be scheduled by the ntp logic when a correction is needed.
> > >  * ntp logic needs to decide when to skip a few nanosecond or slow down the clock or
> > >  * make the clock run faster.
> > >  * One way to do this is to accumulate a time difference to real time.
> > >  * if this time difference is small and positive then skip time forward a bit.
> > >  * if the time difference is negative then slow down the clock.
> > >  * if the time difference is way too high then accelerate the clock
> > >  */
> >
> > Well, this is still a bit vague.  do_adjtimex gives us 4 values we need
> > to use in adjusting time. The parts-per-million (ppm - all of which are
> > signed) tick adjustment value, the ppm frequency adjustment, the ppm
> > offset adjustment, and the singleshot offset adjustment length (# of
> > nsecs in which we apply the maximum ppm singleshot offset adjustment).
> >
> > How do these 4 values get translated to adjusting the time source?
> 
> I agree this is vague and I have no clue here. I hoped that you
> could come up with some may to use these functions for adjtimex etc? I
> would need some time to figure out how the adjusting works in order to
> come up with a solution. I thought we agreed you do the NTP and time
> adjustment things ;-) I have never touched that code....

Heh. Well, I don't think anyone wants to do the NTP work, but I did have
to go through it to implement my proposal. Unfortunately it isn't
something that can easily be tacked on to any design, so you're going to
have to understand some aspects of it if you want to do your own
design.  That said, if you have any questions, hopefully I can explain
my interpretation of the existing code as well as my own implementation.

> > You might want to just swipe my timeofday-core patch and re-work the
> > timesource.h interface to your liking (make it like time_source_t). That
> > way you get all the NTP details as well as the interrupt separation for
> > free.
> 
> Will have a look at it and put it together when I have some time.

Sure thing, and I'll try to take a stab at it myself after next week.


thanks
-john

