Return-Path: <linux-kernel-owner+w=401wt.eu-S965086AbWLMTTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbWLMTTR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWLMTTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:19:17 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:60945 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965086AbWLMTTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:19:16 -0500
Subject: Re: [RFC] HZ free ntp
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0612131338420.1867@scrub.home>
References: <20061204204024.2401148d.akpm@osdl.org>
	 <Pine.LNX.4.64.0612060348150.1868@scrub.home>
	 <20061205203013.7073cb38.akpm@osdl.org>
	 <1165393929.24604.222.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0612061334230.1867@scrub.home>
	 <20061206131155.GA8558@elte.hu>
	 <Pine.LNX.4.64.0612061422190.1867@scrub.home>
	 <1165956021.20229.10.camel@localhost>
	 <Pine.LNX.4.64.0612131338420.1867@scrub.home>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 11:19:09 -0800
Message-Id: <1166037549.6425.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 14:47 +0100, Roman Zippel wrote:
> Hi,
> 
> On Tue, 12 Dec 2006, john stultz wrote:
> 
> > Basically INTERVAL_LENGTH_NSEC defines the NTP interval length that the
> > time code will use to accumulate with. In this patch I've pushed it out
> > to a full second, but it could be set via config (NSEC_PER_SEC/HZ for
> > regular systems, something larger for systems using dynticks).
> 
> Why do you want to use such an interval? This makes everything only more
> complicated.
> The largest possible interval is freq cycles (or 1 second without
> adjustments). That is the base interval and without redesigning NTP we
> can't change that. This base interval can be subdivided into smaller
> intervals for incremental updates.

Indeed, larger then 1 second intervals would require the second_overflow
code to be reworked too. However, I'm not proposing larger then 1 second
intervals at this point. I'm just allowing for non-HZ intervals.

> You cannot choose arbitrary intervals otherwise you get other problems,
> e.g. with your patch time_offset handling is broken.

I'm not seeing this yet. Any more details? 


> > +	/* calculate the length of one NTP adjusted second */
> > +	second_length = (u64)(tick_usec * NSEC_PER_USEC * USER_HZ);
> > +	second_length += (s64)CLOCK_TICK_ADJUST;
> > +	adj_length = (s64)time_freq;
> > +
> > +	/* calculate tick length @ HZ*/
> > +	tick_length = (second_length << TICK_LENGTH_SHIFT)
> > +			+ (adj_length << (TICK_LENGTH_SHIFT - SHIFT_NSEC));
> > +	do_div(tick_length, HZ);
> > +	tick_nsec = tick_length >> TICK_LENGTH_SHIFT;
> > +
> > +
> > +	/* calculate interval_length_base */
> > +	/* XXX - this is broken up to avoid 64bit overlfows */
> > +	interval_length_base = second_length * INTERVAL_LENGTH_NSEC;
> > +	interval_length_base <<= 2;
> > +	do_div(interval_length_base, NSEC_PER_SEC);
> > +	interval_length_base <<= TICK_LENGTH_SHIFT-2;
> 
> You don't have to introduce anything new, it's tick_length that changes
> and HZ that becomes a variable in this function.

So, forgive me for rehashing this, but it seems we're cross talking
again. The context here is the dynticks code. Where HZ doesn't change,
but we get interrupts at much reduced rates. The problem is, if the
interrupts slow to ~1 per second frequencies, we end up spending a ton
of time in the main update_wall_time loop, processing that 1 second in
1/HZ chunks. The current code is correct, but just wastes a lot of time.

So I'm trying to come up w/ an approach (the earlier, and broken,
exponential accumulation patch had the same intention), that allows us
to accumulate time in larger chunks. However, in doing so we have to
work w/ the ntp.c code which (as Ingo earlier mentioned) has a number of
HZ based assumptions.

This last patch tries to give NTP and the timekeeping an agreed upon
chunk (I chose "interval" as the term, since "tick" is somewhat
connected to HZ) of time upon which accumulation is done, so we can have
courser second updates, or finer grained updates, depending on config
settings.

In fairness, the patch probably going about this in a less then perfect
way, but that's why I'm asking for your feedback and suggestions. What
are your thoughts for reducing the time spent in the update_wall_time
loop in the context of dynticks?

thanks
-john

