Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269179AbUIIA4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269179AbUIIA4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 20:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269190AbUIIA4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 20:56:24 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:24060 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S269179AbUIIA4S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 20:56:18 -0400
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
From: john stultz <johnstul@us.ibm.com>
To: george anzinger <george@mvista.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, clameter@sgi.com,
       Len Brown <len.brown@intel.com>, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com, jimix@us.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, greg kh <greg@kroah.com>,
       Patricia Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <413F9F17.5010904@mvista.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
	 <4137CB3E.4060205@mvista.com> <1094193731.434.7232.camel@cube>
	 <41381C2D.7080207@mvista.com>
	 <1094239673.14662.510.camel@cog.beaverton.ibm.com>
	 <4138EBE5.2080205@mvista.com>
	 <1094254342.29408.64.camel@cog.beaverton.ibm.com>
	 <41390622.2010602@mvista.com>
	 <1094666844.29408.67.camel@cog.beaverton.ibm.com>
	 <413F9F17.5010904@mvista.com>
Content-Type: text/plain
Message-Id: <1094691118.29408.102.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 08 Sep 2004 17:51:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 17:08, George Anzinger wrote:
> john stultz wrote:
> > On Fri, 2004-09-03 at 17:02, George Anzinger wrote:
> > 
> >>>Again, monotonic_clock() and friends are NTP adjusted, so drift caused
> >>>by inaccurate calibration shouldn't be a problem the interval timer code
> >>>should need to worry about (outside of maybe adjusting its interval time
> >>>if its always arriving late/early). If possible the timesource
> >>>calibration code should be improved, but that's icing on the cake and
> >>>isn't critical.
> >>>
> >>
> >>Are you providing a way to predict what clock count provide a given time offset 
> >>INCLUDING ntp?  If so, cool.  If not we need to get this conversion right.  We 
> >>will go into this more on your return.
> > 
> > 
> > Sorry, I'm not sure what you mean. Mind expanding on the idea while my
> > brain warms back up?
> 
> The issue is this:  A user wants a timer to fire at exactly time B which is 
> several hours later than now (time A).  We need to know how to measure this time 
> with the timer resources (not the clock as you are talking about it).  Currently 
> we do something like delta_jiffies = timespec_to_jiffies(B - A) and set up a 
> jiffies timer to expire in delta_jiffies.  At this time we "assume" in 
> timespec_to_jiffies() that we _know_ how long a jiffie is in terms of wall clock 
> nanoseconds.  We also assume (possibly incorrectly) that this number is "good 
> enough" even with ntp messing things up.  I think this means that we assume 
> that, on the average, we have the right conversion and that any drift will be a) 
> small and b) on the average 0 (or real close to it).

Why must we use jiffies to tell when a timer expires? Honestly I'd like
to see xtime and jiffies both disappear, but I'm not very familiar w/
the soft-timer code, so forgive me if I'm misunderstanding. 

So instead of calculating delta_jiffies, just mark the timer to expire
at B. Then each interrupt, you use get_fast_timestamp() to decide if now
is greater then B. If so, expire it. 

Then we can look at being able to program timer interrupts to occur as
close as possible to the next soft-timer's expiration time.  

-john

