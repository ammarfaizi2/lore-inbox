Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268034AbUIBWb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268034AbUIBWb6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269153AbUIBWb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:31:57 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:35296 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S268034AbUIBW2M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:28:12 -0400
Subject: Re: [RFC] New Time of day proposal (updated 9/2/04)
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <Pine.LNX.4.58.0409021458140.28532@schroedinger.engr.sgi.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.58.0409021458140.28532@schroedinger.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1094163757.14662.339.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 02 Sep 2004 15:22:37 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 15:09, Christoph Lameter wrote:
> > timeofday_hook()
> > 	now = read();			/* read the timesource */
> > 	ns = cyc2ns(now - offset_base); /* calc nsecs since last call */
> > 	ntp_ns = ntp_scale(ns);		/* apply ntp scaling */
> > 	system_time += ntp_ns;		/* add scaled value to system_time */
> > 	ntp_advance(ns);		/* advance ntp state machine by ns */
> > 	offset_base = now;		/* set new offset_base */
> 
> This would only work if the precision of the timer used is
> <=1ns and if you are actually able to caculate the nanoseconds that have
> passed. What do you do if the interval is lets say 100ns and the time the
> timeofday hook is being called can be anytime within this 100ns interval
> since the time source is not always precise?

Well, with the exception of the TSC, none of the current time sources
have <=1ns resolution, but I'm not sure I understand the problem you're
trying to point out. Could you clarify?

> I think its unavoidable to do some correction like provided by the time
> interpolator if the clock source does not provide ns.

Could you point to the specific correction you describe? 

> > o What is the cost of throwing around 64bit values for everything?
> > 	- Do we need an arch specific time structure that varies size
> > accordingly?
> 
> 64bit may be necessary at a minimum because with 4Ghz machine we may
> have counters with the frequency >2^32 cycles per second.
> 
> I would think that 128bit may be necessary (at least
> as an intermediate result during the scaling of the timesource to
> nanoseconds) since we want to be accurate to the nanosecond.

I worry 128bit math might be a bit too rich for the majority of systems
at the moment. I am open to it, although I suspect we can use other
tricks to get the same accuracy within a constrained bitspace.

> > o Some arches (arm, for example) do not have high res  timing hardware
> > 	- In this case we can have a "jiffies" timesource
> > 		- cyc2ns(x) =  x*(NSEC_PER_SEC/HZ)
> > 		- doesn't work for tickless systems
> 
> David M.s time interpolator logic is needed in those cases to insure that
> the clock works properly and that nanoseconds offset can be calculated in
> a consistent way although the exact timing of the increas / reading of the
> counter may vary within a certain time period.

Again, could you point me to the code (is this with your new patch, or
the older code)? I've looked at the time interpolator code, but I'm not
sure exactly what you mean. 

Thanks for the feedback! I really appreciate it!
-john

