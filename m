Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269229AbUICCIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269229AbUICCIC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 22:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269528AbUICCEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 22:04:41 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:56009 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269229AbUICCCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 22:02:50 -0400
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       albert@users.sourceforge.net, Ulrich.Windl@rz.uni-regensburg.de,
       clameter@sgi.com, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <4137CB3E.4060205@mvista.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
	 <4137CB3E.4060205@mvista.com>
Content-Type: text/plain
Message-Id: <1094176704.14662.453.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 02 Sep 2004 18:58:24 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 18:39, George Anzinger wrote:
> john stultz wrote:
> > +static cycle_t jiffies_read(void)
> > +{
> > +	cycle_t ret = get_jiffies_64();
> > +	return ret;
> > +}
> > +
> > +static cycle_t jiffies_delta(cycle_t now, cycle_t then)
> > +{
> > +	/* simple subtraction, no need to mask */
> > +	return now - then;
> > +}
> 
> This should be inline...

Unfortunately they cannot be, as they are used as function pointers
through the struct timesource interface. 

> > +
> > +static nsec_t jiffies_cyc2ns(cycle_t cyc, cycle_t* remainder)
> > +{
> > +
> > +	cyc *= NSEC_PER_SEC/HZ;
> 
> Hm... This assumes that 1/HZ is what is needed here.  Today this value is 
> 999898.  Not exactly reachable by NSEC_PER_SEC/HZ.  Or did I miss something, 
> like the relationship of jiffie to 1/HZ and to real time.

You're right. You'd think with the recent discussions I would have
already fixed that, but it slipped by. I'll fix it to use ACTHZ in the
next release. Good catch. 


> > +int ntp_leapsecond(struct timespec now)
> > +{
> > +	/*
> > +	 * Leap second processing. If in leap-insert state at
> > +	 * the end of the day, the system clock is set back one
> > +	 * second; if in leap-delete state, the system clock is
> > +	 * set ahead one second. The microtime() routine or
> > +	 * external clock driver will insure that reported time
> > +	 * is always monotonic. The ugly divides should be
> > +	 * replaced.
> 
> ??  Is this really to be hidden?  I rather though this was just the same as a 
> user driven clock setting.  In any case, it is a slew of the wall clock and 
> should be presented to abs timer code so that the abs timers can be corrected. 
> This means a call to "clock_was_set()" AND an update of the mono_to_wall value.

Hmm. Looking at that comment, it seems a bit outdated. I'll see if I can
update it to be more clear. 

And yes, clock_was_set() is on my list. I realized I dropped it, but I
wanted to make sure I was using it properly before I just threw it in.


> > +void do_gettimeofday(struct timeval *tv)
> > +{
> > +	nsec_t wall, sys;
> > +	unsigned long seq;
> > +
> > +	/* atomically read wall and sys time */
> > +	do {
> > +		seq = read_seqbegin(&system_time_lock);
> > +
> > +		wall = wall_time_offset;
> > +		sys = __monotonic_clock();
> > +
> > +	} while (read_seqretry(&system_time_lock, seq));
> > +
> > +	/* add them and convert to timeval */
> > +	*tv = ns2timeval(wall+sys);
> > +}
> I am not sure you don't want to seperate the locking from the clock read.   This 
> so one lock can be put around larger bits of code.  For example, in 
> posix-times.c we need to get all three clocks under the same lock (that being 
> monotonic, wall_time_offset, and jiffies (and possibly as sub jiffie value)).

Well, all the values in timeofday.c are protected by the
system_time_lock, so I'm trying to minimize the locks. I do want to kill
off xtime and thus the xtime lock, so jiffies will be by itself and will
need a jiffies_lock of some sort. However part of this effort is to ween
folks off of using jiffies as a time value, thus in the future it should
only be used inside the timer subsystem as a interrupt counter. 

Thinking about it more, the NTP code could probably drop the ntp_lock
and just use the system_time_lock, but I think I'll push that
optimization off for a bit. 

> Something like:
> void get_tod_parts(nsec_t *wall, nsec_t *mon)
> {
> 	*wall = wall_time_offset;
> 	*mon  = __monotonic_clock();
> }
> 
> This could then be used in a larger function with out the double locking.

I understood your point above, but I'm not sure I see double locking.
__monotonic_clock() is lock free for exactly this reason.


> > +int do_settimeofday(struct timespec *tv)
> > +{
> > +	/* convert timespec to ns */
> > +	nsec_t newtime = timespec2ns(tv);
> > +
> > +	/* atomically adjust wall_time_offset to the desired value */
> > +	write_seqlock_irq(&system_time_lock);
> > +
> > +	wall_time_offset = newtime - __monotonic_clock();
> > +
> > +	/* clear NTP settings */
> > +	ntp_clear();
> > +
> > +	write_sequnlock_irq(&system_time_lock);
> 
> Also need a clock_was_set() call here.

Yep! 

Thanks for the feedback, George!
-john

