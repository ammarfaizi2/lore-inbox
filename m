Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVJJRXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVJJRXM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVJJRXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:23:12 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16611 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751075AbVJJRXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:23:10 -0400
Date: Mon, 10 Oct 2005 19:22:58 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: linux-kernel@vger.kernel.org, mingo@elte.hu, Andrew Morton <akpm@osdl.org>,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com,
       Christoph Hellwig <hch@infradead.org>, oleg@tv-sign.ru,
       tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <1128168344.15115.496.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.61.0510100213480.3728@scrub.home>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0509301825290.3728@scrub.home> <1128168344.15115.496.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 1 Oct 2005, Thomas Gleixner wrote:

> > > ktimers seperate the "timer API" from the "timeout API". 
> > I'm not really happy with these names, timeouts are what timers do, so 
> > these names don't tell at all, what the difference is.
> 
> There is a clear distinction between timers and timeouts.
> 
> >From IT-dictonary:
> 
> "Timeout is a specified period of time that will be allowed to elapse in
> a system before a specified event is to take place, unless another
> specified event occurs first; in either case, the period is terminated
> when either event takes place."
> 
> "A timer is a specialized type of clock. A timer can be used to control
> the sequence of an event or process."

IOW a timer uses timeouts to control a sequence of events, it's still part 
of the same thing, which makes "timer API" and "timeout API" very 
confusing.

> > Calling them "process timer" and "kernel timer" would include their main 
> > usage, although that also means ptimer were the more correct abbreviation.
> 
> As said before I think the disctinction between timers and timeouts
> makes perfectly sense and ktimers are _not_ restricted to process
> timers. 

"main usage" != "restricted to"

> > > +#ifndef KTIME_IS_SCALAR
> > > +typedef union {
> > > +	s64	tv64;
> > > +	struct {
> > > +#ifdef __BIG_ENDIAN
> > > +	s32	sec, nsec;
> > > +#else
> > > +	s32	nsec, sec;
> > > +#endif
> > > +	} tv;
> > > +} ktime_t;
> > > +
> > > +#else
> > > +
> > > +typedef s64 ktime_t;
> > > +
> > > +#endif
> > 
> > Making the union unconditional, would make tv64 always available and a lot 
> > of macros unnessary.
> 
> nsec,sec storage format is essentially different to the scalar storage
> format and has to be handled different.
> 
> The above gives a clear distinction between scalar and sec/nsec based
> cases. So you cannot mess up without notice. 

There are enough macros to do this anyway. There are a number of 
operations which are identical. Separating them artifically makes 
everything only more complicated.

> > > +struct ktimer {
> > > +	struct rb_node		node;
> > > +	struct list_head	list;
> > > +	ktime_t			expires;
> > > +	ktime_t			expired;
> > > +	ktime_t			interval;
> > > +	int 	 	 	overrun;
> > > +	unsigned long		status;
> > > +	void 			(*function)(void *);
> > > +	void			*data;
> > > +	struct ktimer_base 	*base;
> > > +};
> > 
> > This structure is rather large and I think a lot can be avoided.
> > - list: AFAICT it's only used by run_ktimer_queue() to get the first 
> > pending entry. This can also be done by keeping track of the first entry 
> > in the base structure (useful in other places as well).
> 
> You are right that the list is not necessary for the plain integration
> into the current system, but it is necessary once you start to upgrade
> to high resolution timers.

Could you please specifiy these requirements?

> > - expired: can be replaced by base->last_expired (may also be useful in 
> > other places)
> 
> How gives base->last_expired a per timer expired information? And where
> would it be useful ?

If a callback needs that information, it can it get from there.

> > - status: only user is ktimer_active(), the same test can be done by 
> > testing node.rb_parent.
> 
> Uurg. Been there and discarded the idea, because its ugly and clashes
> with further extensibilty requirements e.g. high resolution timers,
> where we have more than two states. 
> 
> Having status information bound to arbitrary pointers is trading a
> variable against flexibility, cleanliness and maintainability. 

If you want to introduce more states later, it requires changing _one_ 
macro, so I don't really see the problem.

> > - interval/overrun: this is only needed by itimers and I think it's 
> > possible to leave it there. Main change would be to let 'function' return 
> > a value indicating whether to rearm the timer or not (this includes 
> > expires is updated).
> 
> It is also used by the posix timer code and I plan to do another round
> of simplification also there.

Please explain.

> I do not want to end up with a next round of discussion there about
> either introducing tons of new ifdefs, macros or redesigning the code
> base another time. 

I don't really see why this should be an excuse to introduce now more 
complex code than really necessary. If that extra complexity can't stand 
on it's own please introduce as soon as it becomes necessary.
I like most of the patch, but I would prefer to do a simple 
implementation/ cleanup first and then build anything more complex on top 
of it. If you need another complete redesign for this, then you likely do 
something wrong already now.

> > Not using 64bit math here allows gcc to generate better code, e.g. gcc 
> > has to add another test for "nsec < 0" because the condition code is 
> > already used for the overflow, adding the "sec--" instead is IMO faster 
> > (i.e. less likely).
> 
> i686
> DOADD32         00000048
> DOADD64         0000002a
> DOSUB32         00000060
> DOSUB64         0000002f
> arm
> DOADD32         0000004c
> DOADD64         0000004c
> DOSUB32         00000040
> DOSUB64         00000038
> m68k
> DOADD32         0000003c
> DOADD64         0000002e
> DOSUB32         00000036
> DOSUB64         00000028
> powerpc
> DOADD32         00000040
> DOADD64         00000044
> DOSUB32         00000044
> DOSUB64         00000044
> 
> Please do not tell me that size does not matter. :)
> 
> I attached the assembler dumps, so you can have a look yourself. I did
> these tests during the implementation and decided on the results rather
> than on assumptions about gcc.

Did you look at the generating code? Most of it is function prologue/ 
epilogue, which is quite unimportant for inline functions. The other thing 
I forgot to mention last time is that passing values by reference instead 
of value also makes a difference.
For m68k I actually got smaller code this way (mostly because addx/subx 
are limited in their addressing modes). In the other cases I'm actually 
surprised gcc doesn't use the previous result from the sub and adds 
another test. The remaining difference comes from how gcc deals with 
structure vs. integral values, which could use some improvement, 
especially the add case should have produced nearly identical results.

Anyway, this point wasn't that important, it's only microoptimizations and 
at least having the option to change it later (after more tests) is fine 
with me.

> > Could you explain a little the resolution handling behind in your patch?
> > If I read SUS correctly clock resolution and timer resolution don't have 
> > to be the same, the first is returned by clock_getres() and the latter 
> > only documented somewhere (and AFAICT our implementation always returned 
> > the wrong value).
> 
> As far as I understand SUS timer resolution is equal to clock resolution
> and the timer value/interval is rounded up to the resolution.

Please check the rationale about clocks and timers. It talks about clocks 
and timer services based on them and their resolutions can be different.

> > IMO this also means we can don't have to make the rounding that 
> > complicated. Actually it could be done automatically by the timer, e.g. 
> > interval timer are reprogrammed at (now + interval) and the timer 
> > resolution will automatically round it up.
> 
> Reprogramming interval timers by now + interval is completely wrong.
> Reprogramming has to be 
> timer->expires + interval and nothing else. 

Where do get the requirement for an explicit rounding from?
The point is that the timer should not expire early, but there is more 
than one way to do this and can be done implicitly using the timer 
resolution.

> > > +	/* Get current time */
> > > +	now = base->get_time();
> > 
> > As get_time() is not necessarily cheap, it can be avoided for nonrelative 
> > timers by comparing it with the first pending timer. Maintaining a pointer 
> > to the first timer here, avoids the timer list and is a simple check 
> > whether the time source needs any reprogramming later.
> 
> Would you please care to read the complete related code to find out why
> this does not work. This is totaly unrelated to reprogramming of the
> time event source in the HRT case.

You saw that I restricted this to "nonrelative timers"?

> > > +	if ktime_cmp(timer->expires, <=, now) {
> > > +		timer->expired = now;
> > > +		/* The caller takes care of expiry */
> > > +		if (!(mode & KTIMER_NOCHECK))
> > > +			return -1;
> > 
> > I think KTIMER_NOFAIL would be better name, for a while that had me 
> > confused, as you actually do check the value, but you don't fail it and 
> > enqueue it anyway.
> 
> It does not fail. It returns in the case that the timer is already
> expired. The NOCHECK flag is used to skip the check.

It returns with a failure value!? The NOCHECK name is ambiguous about what 
should not be checked, the NOFAIL name is more clear that the caller 
doesn't need to check the return value, because the function won't fail.

bye, Roman
