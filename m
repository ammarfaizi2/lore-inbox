Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVCMAug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVCMAug (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 19:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVCMAud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 19:50:33 -0500
Received: from waste.org ([216.27.176.166]:11191 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261274AbVCMAuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 19:50:02 -0500
Date: Sat, 12 Mar 2005 16:49:02 -0800
From: Matt Mackall <mpm@selenic.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Christoph Lameter <clameter@sgi.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
Message-ID: <20050313004902.GD3163@waste.org>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 05:24:15PM -0800, john stultz wrote:
> +struct timesource_t timesource_jiffies = {
> +	.name = "jiffies",
> +	.priority = 0, /* lowest priority*/
> +	.type = TIMESOURCE_FUNCTION,
> +	.read_fnct = jiffies_read,
> +	.mask = (cycle_t)~0,

Not sure this is right. The type of 0 is 'int' and the ~ will happen
before the cast to a potentially longer type.

> +	.mult = NSEC_PER_SEC/HZ,

Does rounding matter here? Alpha has HZ of 1024, so this comes out to
976562.5.

> +struct timesource_t {
> +	char* name;
> +	int priority;
> +	enum {
> +		TIMESOURCE_FUNCTION,
> +		TIMESOURCE_CYCLES,
> +		TIMESOURCE_MMIO_32,
> +		TIMESOURCE_MMIO_64
> +	} type;
> +	cycle_t (*read_fnct)(void);
> +	void __iomem* mmio_ptr;

Convention is * goes next to the variable name rather than the type.

> +/* XXX - this should go somewhere better! */
> +#ifndef readq
> +static inline unsigned long long readq(void __iomem *addr)

Somewhere in asm-generic..

> +static inline cycle_t read_timesource(struct timesource_t* ts)
> +{
> +	switch (ts->type) {
> +	case TIMESOURCE_MMIO_32:
> +		return (cycle_t)readl(ts->mmio_ptr);
> +	case TIMESOURCE_MMIO_64:
> +		return (cycle_t)readq(ts->mmio_ptr);
> +	case TIMESOURCE_CYCLES:
> +		return (cycle_t)get_cycles();
> +	default:/* case: TIMESOURCE_FUNCTION */
> +		return ts->read_fnct();
> +	}
> +}

Wouldn't it be better to change read_fnct to take a timesource * and
then change all the other guys to generic_timesource_<foo> helper
functions? This does away with the switch and makes it trivial to add
new generic sources. Change mmio_ptr to void *private.

> @@ -467,6 +468,7 @@
>  	pidhash_init();
>  	init_timers();
>  	softirq_init();
> +	timeofday_init();
>  	time_init();

Can we push time_init inside of timeofday_init?

> +/* Chapter 5: Kernel Variables [RFC 1589 pg. 28] */
> +/* 5.1 Interface Variables */
> +static int ntp_status		= STA_UNSYNC;		/* status */
> +static long ntp_offset;					/* usec */
> +static long ntp_constant	= 2;			/* ntp magic? */
> +static long ntp_maxerror	= NTP_PHASE_LIMIT;	/* usec */
> +static long ntp_esterror	= NTP_PHASE_LIMIT;	/* usec */
> +static const long ntp_tolerance	= MAXFREQ;		/* shifted ppm */
> +static const long ntp_precision	= 1;			/* constant */
> +
> +/* 5.2 Phase-Lock Loop Variables */
> +static long ntp_freq;					/* shifted ppm */
> +static long ntp_reftime;				/* sec */

You present a nice argument for not using tabs except at the beginning
of the line.

> +#define MILLION 1000000

Still a magic number despite being a define. Very meta. Unused.

> +/* int ntp_advance(nsec_t interval):
> + *	Periodic hook which increments NTP state machine by interval.
> + *  Returns the signed PPM adjustment to be used for the next interval.
> + *	This is ntp_hardclock in the RFC.

Why is it not ntp_hardclock here?

> + */
> +int ntp_advance(nsec_t interval)
> +{
> +	static u64 interval_sum=0;

Spaces.

> +	/* decrement singleshot offset interval */
> +	ss_offset_len =- interval;

Eh?

> +		/* bound the adjustment to MAXPHASE/MINSEC */
> +		if (tmp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
> +		    tmp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
> +		if (tmp < -(MAXPHASE / MINSEC) << SHIFT_UPDATE)
> +		    tmp = -(MAXPHASE / MINSEC) << SHIFT_UPDATE;

max, min?

> +	/* Make sure offset is bounded by MAXPHASE */
> +	if (tmp > MAXPHASE)
> +		tmp = MAXPHASE;
> +	if (tmp < -MAXPHASE)
> +		tmp = -MAXPHASE;

max, min.

> +	if ((ntp_status & STA_FLL) && (interval >= MINSEC)) {
> +		long damping;
> +		tmp = (offset / interval); /* ppm (usec/sec)*/

(unnecessary parens)

> +/* int ntp_adjtimex(struct timex* tx)
> + *	Interface to change NTP state machine
> + */
> +int ntp_adjtimex(struct timex* tx)
> +{
> +	long save_offset;
> +	int result;
> +	unsigned long flags;
> +
> +/*=[Sanity checking]===============================*/
> +	/* Check capabilities if we're trying to modify something */
> +	if (tx->modes && !capable(CAP_SYS_TIME))
> +		return -EPERM;

This is already done in do_adjtimex.

> +	/* clear everything */
> +	ntp_status |= STA_UNSYNC;
> +	ntp_maxerror = NTP_PHASE_LIMIT;
> +	ntp_esterror = NTP_PHASE_LIMIT;
> +	ss_offset_len=0;
> +	singleshot_adj=0;
> +	tick_adj=0;
> +	offset_adj =0;

Spacing.

> +/*[Nanosecond based variables]----------------

This comment style is weird. Kill the trailing dashes at least.

> +static enum { TIME_RUNNING, TIME_SUSPENDED } time_suspend_state = TIME_RUNNING;

Insert some line breaks.

> +	/* convert timespec to ns */
> +	nsec_t newtime = timespec2ns(tv);

> +	/* clear NTP settings */
> +	ntp_clear();

Pointless comments.

> +int do_adjtimex(struct timex *tx)
> +{
> +	do_gettimeofday(&tx->time);	/* set timex->time*/

Oh. Move the cap check back here..

> +	if (time_suspend_state != TIME_RUNNING) {
> +		printk(KERN_INFO "timeofday_suspend_hook: ACK! called while we're suspended!");

Line length. Perhaps BUG_ON instead.

> +	/* finally, update legacy time values */
> +	write_seqlock_irqsave(&xtime_lock, x_flags);
> +	xtime = ns2timespec(system_time + wall_time_offset);
> +	wall_to_monotonic = ns2timespec(wall_time_offset);
> +	wall_to_monotonic.tv_sec = -wall_to_monotonic.tv_sec;
> +	wall_to_monotonic.tv_nsec = -wall_to_monotonic.tv_nsec;
> +	/* XXX - should jiffies be updated here? */

Excellent question. 

-- 
Mathematics is the supreme nostalgia of our time.
