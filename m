Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVAYHnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVAYHnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVAYHnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:43:23 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:56266 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S261861AbVAYHl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:41:59 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Christoph Lameter <clameter@sgi.com>
Date: Tue, 25 Jan 2005 08:41:10 +0100
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A2)
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
Message-ID: <41F60627.3898.134873AE@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <Pine.LNX.4.58.0501241513470.17986@schroedinger.engr.sgi.com>
References: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.88.0+V=3.88+U=2.07.079+R=06 December 2004+T=98396@20050125.072708Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jan 2005 at 15:24, Christoph Lameter wrote:

> On Mon, 24 Jan 2005, john stultz wrote:
> 
> > +/* __monotonic_clock():
> > + *		private function, must hold system_time_lock lock when being
> > + *		called. Returns the monotonically increasing number of
> > + *		nanoseconds	since the system booted (adjusted by NTP scaling)
> > + */
> > +static nsec_t __monotonic_clock(void)
> > +{
> > +	nsec_t ret, ns_offset;
> > +	cycle_t now, delta;
> > +
> > +	/* read timesource */
> > +	now = read_timesource(timesource);
> > +
> > +	/* calculate the delta since the last clock_interrupt */
> > +	delta = (now - offset_base) & timesource->mask;
> > +
> > +	/* convert to nanoseconds */
> > +	ns_offset = cyc2ns(timesource, delta, NULL);
> > +
> > +	/* apply the NTP scaling */
> > +	ns_offset = ntp_scale(ns_offset);
> 
> The monotonic clock is the time base for the gettime and gettimeofday
> functions. This means ntp_scale() is called every time that the kernel or
> an application access time.

It depends on what you want: There is little sense in implementing a nanosecond 
clock model with NTP when the result is wrong by several microseconds IMHO. You 
don't know what the time is used for, so just get the best you can. Thos only 
wanting some crude time, could be happy with the jiffies (or their equivalent), 
right?

Regards,
Ulrich

> 
> As pointed out before this will dramatically worsen the performance
> compared to the current code base.
> 
> ntp_scale() also will make it difficult to implement optimized arch
> specific version of function for timer access.
> 
> The fastcalls would have to be disabled on ia64 to make this work. Its
> likely extremely difficult to implement a fastcall if it involves
> ntp_scale().
> 


