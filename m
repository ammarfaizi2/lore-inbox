Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbVCNSo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVCNSo5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 13:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVCNSo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 13:44:56 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:50355 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261692AbVCNSmy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 13:42:54 -0500
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
From: john stultz <johnstul@us.ibm.com>
To: Matt Mackall <mpm@selenic.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
In-Reply-To: <20050313004902.GD3163@waste.org>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
	 <20050313004902.GD3163@waste.org>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 10:42:45 -0800
Message-Id: <1110825765.30498.370.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-12 at 16:49 -0800, Matt Mackall wrote:
> On Fri, Mar 11, 2005 at 05:24:15PM -0800, john stultz wrote:
> > +struct timesource_t timesource_jiffies = {
> > +	.name = "jiffies",
> > +	.priority = 0, /* lowest priority*/
> > +	.type = TIMESOURCE_FUNCTION,
> > +	.read_fnct = jiffies_read,
> > +	.mask = (cycle_t)~0,
> 
> Not sure this is right. The type of 0 is 'int' and the ~ will happen
> before the cast to a potentially longer type.

Good point. I'll change it to Andreas' suggestion of (type)-1.


> > +	.mult = NSEC_PER_SEC/HZ,
> 
> Does rounding matter here? Alpha has HZ of 1024, so this comes out to
> 976562.5.

Actually, there are probably a number of places where I need to be
better with rounding. Its a good idea there as well.

> > +static inline cycle_t read_timesource(struct timesource_t* ts)
> > +{
> > +	switch (ts->type) {
> > +	case TIMESOURCE_MMIO_32:
> > +		return (cycle_t)readl(ts->mmio_ptr);
> > +	case TIMESOURCE_MMIO_64:
> > +		return (cycle_t)readq(ts->mmio_ptr);
> > +	case TIMESOURCE_CYCLES:
> > +		return (cycle_t)get_cycles();
> > +	default:/* case: TIMESOURCE_FUNCTION */
> > +		return ts->read_fnct();
> > +	}
> > +}
> 
> Wouldn't it be better to change read_fnct to take a timesource * and
> then change all the other guys to generic_timesource_<foo> helper
> functions? This does away with the switch and makes it trivial to add
> new generic sources. Change mmio_ptr to void *private.

Not sure if I totally understand this, but originally I just had a read
function, but to allow this framework to function w/ ia64 fsyscalls (and
likely other arches vsyscalls) we need to pass the raw mmio pointers.
Thus the timesource type and switch idea was taken from the time
interpolator code.


> > @@ -467,6 +468,7 @@
> >  	pidhash_init();
> >  	init_timers();
> >  	softirq_init();
> > +	timeofday_init();
> >  	time_init();
> 
> Can we push time_init inside of timeofday_init?

Ideally, yea, but this way is cleaner until all the arches are converted
to the new timeofday code.

> > +/* Chapter 5: Kernel Variables [RFC 1589 pg. 28] */
> > +/* 5.1 Interface Variables */
> > +static int ntp_status		= STA_UNSYNC;		/* status */
> > +static long ntp_offset;					/* usec */
> > +static long ntp_constant	= 2;			/* ntp magic? */
> > +static long ntp_maxerror	= NTP_PHASE_LIMIT;	/* usec */
> > +static long ntp_esterror	= NTP_PHASE_LIMIT;	/* usec */
> > +static const long ntp_tolerance	= MAXFREQ;		/* shifted ppm */
> > +static const long ntp_precision	= 1;			/* constant */
> > +
> > +/* 5.2 Phase-Lock Loop Variables */
> > +static long ntp_freq;					/* shifted ppm */
> > +static long ntp_reftime;				/* sec */
> 
> You present a nice argument for not using tabs except at the beginning
> of the line.

Yea, I should have caught that earlier. I have the tab length set to 4
in my editor. Sorry. 


> > +#define MILLION 1000000
> 
> Still a magic number despite being a define. Very meta. Unused.

Should have been yanked along with ntp_scale(). Good catch.

> > +/* int ntp_advance(nsec_t interval):
> > + *	Periodic hook which increments NTP state machine by interval.
> > + *  Returns the signed PPM adjustment to be used for the next interval.
> > + *	This is ntp_hardclock in the RFC.
> 
> Why is it not ntp_hardclock here?

I'm not sure if ntp_hardclock is a very good name. Since we're advancing
the state machine, ntp_advance() seems to be more clear to me. However
if the NTP folks care enough then I'll be fine with changing it.

> > +	/* decrement singleshot offset interval */
> > +	ss_offset_len =- interval;
> 
> Eh?

Gah! Great catch! I would have never seen that terrible typo!



> > +		/* bound the adjustment to MAXPHASE/MINSEC */
> > +		if (tmp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
> > +		    tmp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
> > +		if (tmp < -(MAXPHASE / MINSEC) << SHIFT_UPDATE)
> > +		    tmp = -(MAXPHASE / MINSEC) << SHIFT_UPDATE;
> 
> max, min?
> 
> > +	/* Make sure offset is bounded by MAXPHASE */
> > +	if (tmp > MAXPHASE)
> > +		tmp = MAXPHASE;
> > +	if (tmp < -MAXPHASE)
> > +		tmp = -MAXPHASE;
> 
> max, min.

Good idea. 


> > +int do_adjtimex(struct timex *tx)
> > +{
> > +	do_gettimeofday(&tx->time);	/* set timex->time*/
> 
> Oh. Move the cap check back here..

Will do.

> > +	if (time_suspend_state != TIME_RUNNING) {
> > +		printk(KERN_INFO "timeofday_suspend_hook: ACK! called while we're suspended!");
> 
> Line length. Perhaps BUG_ON instead.

Eh, its not fatal to BUG_ON seems a bit harsh. I'll fix the line length
though. 


> > +	/* finally, update legacy time values */
> > +	write_seqlock_irqsave(&xtime_lock, x_flags);
> > +	xtime = ns2timespec(system_time + wall_time_offset);
> > +	wall_to_monotonic = ns2timespec(wall_time_offset);
> > +	wall_to_monotonic.tv_sec = -wall_to_monotonic.tv_sec;
> > +	wall_to_monotonic.tv_nsec = -wall_to_monotonic.tv_nsec;
> > +	/* XXX - should jiffies be updated here? */
> 
> Excellent question. 

Indeed.  Currently jiffies is used as both a interrupt counter and a
time unit, and I'm trying make it just the former. If I emulate it then
it stops functioning as a interrupt counter, and if I don't then I'll
probably break assumptions about jiffies being a time unit. So I'm not
sure which is the easiest path to go until all the users of jiffies are
audited for intent. 

As for the code style bits: Thanks, I'll try to clean those up.

I really appreciate the time you took to review my code! 

Thanks again for the feedback!
-john

