Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269149AbUIBWRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269149AbUIBWRF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269183AbUIBWPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:15:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:63619 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269136AbUIBWLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:11:22 -0400
Date: Thu, 2 Sep 2004 15:09:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george@mvista.com, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, len.brown@intel.com,
       linux@dominikbrodowski.de, davidm@hpl.hp.com, ak@suse.de,
       paulus@samba.org, schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
In-Reply-To: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0409021458140.28532@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> timeofday_hook()
> 	now = read();			/* read the timesource */
> 	ns = cyc2ns(now - offset_base); /* calc nsecs since last call */
> 	ntp_ns = ntp_scale(ns);		/* apply ntp scaling */
> 	system_time += ntp_ns;		/* add scaled value to system_time */
> 	ntp_advance(ns);		/* advance ntp state machine by ns */
> 	offset_base = now;		/* set new offset_base */

This would only work if the precision of the timer used is
<=1ns and if you are actually able to caculate the nanoseconds that have
passed. What do you do if the interval is lets say 100ns and the time the
timeofday hook is being called can be anytime within this 100ns interval
since the time source is not always precise?

I think its unavoidable to do some correction like provided by the time
interpolator if the clock source does not provide ns.

> monotonic_clock()
> 	now = read();			/* read the timesource */
> 	ns = cyc2ns(now - offset_base);	/* calculate nsecs since last hook */
> 	ntp_ns = ntp_scale(ns);		/* apply ntp scaling */
> 	return system_time + ntp_ns; 	/* return system_time and scaled value

This works analogous to the time interpolator today. The scaling of the
timesource is omitted tough. Looks like we will be able to keep the
fastcalls for clock_gettime and gettime ofday.

> o What is the cost of throwing around 64bit values for everything?
> 	- Do we need an arch specific time structure that varies size
> accordingly?

64bit may be necessary at a minimum because with 4Ghz machine we may
have counters with the frequency >2^32 cycles per second.

I would think that 128bit may be necessary (at least
as an intermediate result during the scaling of the timesource to
nanoseconds) since we want to be accurate to the nanosecond.

> o Some arches (arm, for example) do not have high res  timing hardware
> 	- In this case we can have a "jiffies" timesource
> 		- cyc2ns(x) =  x*(NSEC_PER_SEC/HZ)
> 		- doesn't work for tickless systems

David M.s time interpolator logic is needed in those cases to insure that
the clock works properly and that nanoseconds offset can be calculated in
a consistent way although the exact timing of the increas / reading of the
counter may vary within a certain time period.
