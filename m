Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVCNTwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVCNTwL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVCNTwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:52:11 -0500
Received: from waste.org ([216.27.176.166]:10919 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261776AbVCNTvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:51:48 -0500
Date: Mon, 14 Mar 2005 11:51:10 -0800
From: Matt Mackall <mpm@selenic.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Christoph Lameter <clameter@sgi.com>, lkml <linux-kernel@vger.kernel.org>,
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
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
Message-ID: <20050314195110.GD32638@waste.org>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com> <20050313004902.GD3163@waste.org> <1110825765.30498.370.camel@cog.beaverton.ibm.com> <20050314192918.GC32638@waste.org> <1110829401.30498.383.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110829401.30498.383.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 11:43:21AM -0800, john stultz wrote:
> On Mon, 2005-03-14 at 11:29 -0800, Matt Mackall wrote:
> > On Mon, Mar 14, 2005 at 10:42:45AM -0800, john stultz wrote:
> > > 
> > > > > +static inline cycle_t read_timesource(struct timesource_t* ts)
> > > > > +{
> > > > > +	switch (ts->type) {
> > > > > +	case TIMESOURCE_MMIO_32:
> > > > > +		return (cycle_t)readl(ts->mmio_ptr);
> > > > > +	case TIMESOURCE_MMIO_64:
> > > > > +		return (cycle_t)readq(ts->mmio_ptr);
> > > > > +	case TIMESOURCE_CYCLES:
> > > > > +		return (cycle_t)get_cycles();
> > > > > +	default:/* case: TIMESOURCE_FUNCTION */
> > > > > +		return ts->read_fnct();
> > > > > +	}
> > > > > +}
> > > > 
> > > > Wouldn't it be better to change read_fnct to take a timesource * and
> > > > then change all the other guys to generic_timesource_<foo> helper
> > > > functions? This does away with the switch and makes it trivial to add
> > > > new generic sources. Change mmio_ptr to void *private.
> > > 
> > > Not sure if I totally understand this, but originally I just had a read
> > > function, but to allow this framework to function w/ ia64 fsyscalls (and
> > > likely other arches vsyscalls) we need to pass the raw mmio pointers.
> > > Thus the timesource type and switch idea was taken from the time
> > > interpolator code.
> > 
> > Well for vsyscall, we can leave the mmio_ptr and type. But in-kernel,
> > I think we'd rather always call read_fnct with generic helpers than hit this
> > switch every time.
> 
> Huh. So if I understand you properly, all timesources should have valid
> read_fnct pointers that return the cycle value, however we'll still
> preserve the type and mmio_ptr so fsyscall/vsyscall bits can use them
> externally?

Well where we'd read an MMIO address, we'd simply set read_fnct to
generic_timesource_mmio32 or so. And that function just does the read.
So both that function and read_timesource become one-liners and we
drop the conditional branches in the switch.

-- 
Mathematics is the supreme nostalgia of our time.
