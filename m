Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVCNTra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVCNTra (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbVCNTot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:44:49 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:40866 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261776AbVCNTnb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:43:31 -0500
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
From: john stultz <johnstul@us.ibm.com>
To: Matt Mackall <mpm@selenic.com>, Christoph Lameter <clameter@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
In-Reply-To: <20050314192918.GC32638@waste.org>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
	 <20050313004902.GD3163@waste.org>
	 <1110825765.30498.370.camel@cog.beaverton.ibm.com>
	 <20050314192918.GC32638@waste.org>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 11:43:21 -0800
Message-Id: <1110829401.30498.383.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 11:29 -0800, Matt Mackall wrote:
> On Mon, Mar 14, 2005 at 10:42:45AM -0800, john stultz wrote:
> > 
> > > > +static inline cycle_t read_timesource(struct timesource_t* ts)
> > > > +{
> > > > +	switch (ts->type) {
> > > > +	case TIMESOURCE_MMIO_32:
> > > > +		return (cycle_t)readl(ts->mmio_ptr);
> > > > +	case TIMESOURCE_MMIO_64:
> > > > +		return (cycle_t)readq(ts->mmio_ptr);
> > > > +	case TIMESOURCE_CYCLES:
> > > > +		return (cycle_t)get_cycles();
> > > > +	default:/* case: TIMESOURCE_FUNCTION */
> > > > +		return ts->read_fnct();
> > > > +	}
> > > > +}
> > > 
> > > Wouldn't it be better to change read_fnct to take a timesource * and
> > > then change all the other guys to generic_timesource_<foo> helper
> > > functions? This does away with the switch and makes it trivial to add
> > > new generic sources. Change mmio_ptr to void *private.
> > 
> > Not sure if I totally understand this, but originally I just had a read
> > function, but to allow this framework to function w/ ia64 fsyscalls (and
> > likely other arches vsyscalls) we need to pass the raw mmio pointers.
> > Thus the timesource type and switch idea was taken from the time
> > interpolator code.
> 
> Well for vsyscall, we can leave the mmio_ptr and type. But in-kernel,
> I think we'd rather always call read_fnct with generic helpers than hit this
> switch every time.

Huh. So if I understand you properly, all timesources should have valid
read_fnct pointers that return the cycle value, however we'll still
preserve the type and mmio_ptr so fsyscall/vsyscall bits can use them
externally?

Hmm. I'm a little cautious, as I really want to make the vsyscall
gettimeofday and regular do_gettimeofday be a similar as possible to
avoid some of the bugs we've seen between different gettimeofday
implementations. However I'm not completely against the idea.

Christoph: Do you have any thoughts on this?


> > > > +	if (time_suspend_state != TIME_RUNNING) {
> > > > +		printk(KERN_INFO "timeofday_suspend_hook: ACK! called while we're suspended!");
> > > 
> > > Line length. Perhaps BUG_ON instead.
> > 
> > Eh, its not fatal to BUG_ON seems a bit harsh. I'll fix the line length
> > though. 
> 
> Well there's a trade-off here. If it's something that should never
> happen and you only printk, you may never get a failure report
> (especially at KERN_INFO). It's good to be accomodating of external
> errors, but catching internal should-never-happen errors is important.

Fair enough. 


> > > Excellent question. 
> > 
> > Indeed.  Currently jiffies is used as both a interrupt counter and a
> > time unit, and I'm trying make it just the former. If I emulate it then
> > it stops functioning as a interrupt counter, and if I don't then I'll
> > probably break assumptions about jiffies being a time unit. So I'm not
> > sure which is the easiest path to go until all the users of jiffies are
> > audited for intent. 
> 
> Post this as a separate thread. There are various thoughts floating
> around on this already.

I'm a little busy with other things today, but I'll try to stir up a
discussion on this soon. 

thanks
-john


