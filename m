Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbVCOCfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbVCOCfg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 21:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVCOCfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 21:35:36 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:63432 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262208AbVCOCfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 21:35:23 -0500
X-Comment: AT&T Maillennium special handling code - c
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
From: Albert Cahalan <albert@users.sf.net>
To: Matt Mackall <mpm@selenic.com>
Cc: john stultz <johnstul@us.ibm.com>, Christoph Lameter <clameter@sgi.com>,
       lkml <linux-kernel@vger.kernel.org>,
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
In-Reply-To: <20050314202702.GF32638@waste.org>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
	 <20050313004902.GD3163@waste.org>
	 <1110825765.30498.370.camel@cog.beaverton.ibm.com>
	 <20050314192918.GC32638@waste.org>
	 <1110829401.30498.383.camel@cog.beaverton.ibm.com>
	 <20050314195110.GD32638@waste.org>
	 <1110830647.30498.388.camel@cog.beaverton.ibm.com>
	 <20050314202702.GF32638@waste.org>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 21:16:12 -0500
Message-Id: <1110852973.1967.180.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 12:27 -0800, Matt Mackall wrote:
> On Mon, Mar 14, 2005 at 12:04:07PM -0800, john stultz wrote:
> > > > > > > > +static inline cycle_t read_timesource(struct timesource_t* ts)
> > > > > > > > +{
> > > > > > > > +	switch (ts->type) {
> > > > > > > > +	case TIMESOURCE_MMIO_32:
> > > > > > > > +		return (cycle_t)readl(ts->mmio_ptr);
> > > > > > > > +	case TIMESOURCE_MMIO_64:
> > > > > > > > +		return (cycle_t)readq(ts->mmio_ptr);
> > > > > > > > +	case TIMESOURCE_CYCLES:
> > > > > > > > +		return (cycle_t)get_cycles();
> > > > > > > > +	default:/* case: TIMESOURCE_FUNCTION */
> > > > > > > > +		return ts->read_fnct();
> > > > > > > > +	}
> > > > > > > > +}
> > > Well where we'd read an MMIO address, we'd simply set read_fnct to
> > > generic_timesource_mmio32 or so. And that function just does the read.
> > > So both that function and read_timesource become one-liners and we
> > > drop the conditional branches in the switch.
> > 
> > However the vsyscall/fsyscall bits cannot call in-kernel functions (as
> > they execute in userspace or a sudo-userspace). As it stands now in my
> > design TIMESOURCE_FUNCTION timesources will not be usable for
> > vsyscall/fsyscall implementations, so I'm not sure if that's doable.
> > 
> > I'd be interested you've got a way around that.
> 
> We can either stick all the generic mmio timer functions in the
> vsyscall page (they're tiny) or leave the vsyscall using type/ptr but
> have the kernel internally use only the function pointer. Someone
> who's more familiar with the vsyscall timer code should chime in here.

When the vsyscall page is created, copy the one needed function
into it. The kernel is already self-modifying in many places; this
is nothing new.



