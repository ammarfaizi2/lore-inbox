Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263809AbUEGVjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbUEGVjf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 17:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbUEGVje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 17:39:34 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:54968 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263810AbUEGVjb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 17:39:31 -0400
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
From: john stultz <johnstul@us.ibm.com>
To: ganzinger@mvista.com
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, Andrew Morton <akpm@osdl.org>,
       kaukasoi@elektroni.ee.tut.fi, lkml <linux-kernel@vger.kernel.org>,
       davem@redhat.com
In-Reply-To: <409BF486.40500@mvista.com>
References: <403D0F63.3050101@mvista.com>
	 <1077760348.2857.129.camel@cog.beaverton.ibm.com>
	 <403E7BEE.9040203@mvista.com>
	 <1077837016.2857.171.camel@cog.beaverton.ibm.com>
	 <403E8D5B.9040707@mvista.com>
	 <1081895880.4705.57.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0404141353450.21779@gockel.physik3.uni-rostock.de>
	 <1081967295.4705.96.camel@cog.beaverton.ibm.com>
	 <20040415103711.GA320@elektroni.ee.tut.fi>
	 <Pine.LNX.4.53.0404151302140.28278@gockel.physik3.uni-rostock.de>
	 <20040415161436.GA21613@elektroni.ee.tut.fi>
	 <Pine.LNX.4.53.0405011540390.25435@gockel.physik3.uni-rostock.de>
	 <20040501184105.2cd1c784.akpm@osdl.org>
	 <Pine.LNX.4.53.0405020352480.26994@gockel.physik3.uni-rostock.de>
	 <1083638458.9664.134.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0405040804180.2215@gockel.physik3.uni-rostock.de>
	 <1083682764.4324.33.camel@leatherman>  <409AD95F.8080502@mvista.com>
	 <1083892878.9664.226.camel@cog.beaverton.ibm.com>
	 <409BF486.40500@mvista.com>
Content-Type: text/plain
Message-Id: <1083965912.4638.20.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 07 May 2004 14:38:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-07 at 13:41, George Anzinger wrote:
> john stultz wrote:
> > On Thu, 2004-05-06 at 17:33, George Anzinger wrote:
> > 
> >>john stultz wrote:
> >>
> >>>Roughly, I'd like to see the time code for all arches in 2.7 to look
> >>>like:
> >>>
> >>>u64 system_time 	/* NTP adjusted nanosecs since boot */
> >>>u64 wall_time_offset	/* offset to system_time for time of day */
> >>>u64 offset_base		/* last read raw hw value */
> >>
> >>Hm.  In 2.6 we use an NTP adjusted wall time and a wall_to_monotonic offset.  I 
> >>don't really see the advantage here.  Does this change buy us something?
> >>For what its worth, I introduced the wall_to_monotonic offset just because it 
> >>was easier to do (and understand, I think) in the current kernel.
> > 
> > 
> > Well, in my opinion it seems much cleaner. Right now any time we adjust
> > xtime, we have to remember to adjust wall_to_monotonic. I believe we've
> > had issues where a change was made to just one and not the other. 
> > 
> > This is easier and has simpler rules. system_time always increments and
> > is only modified by the periodic time_interrupt_hook(). Then
> > wall_time_offset is only changes by do_settimeofday(). In fact, I hope
> > to make these values static to the time code, so that all in-kernel
> > users must go through the monotonic_clock() and do_gettimeofday()
> > interfaces. 
> 
> All that is fine for the kernel coder and such, but the fact remains that 
> gettimeofday() is the BIG user and I keep seeing folks trying to make it faster. 
>   Also xtime.tv_sec is used a LOT in the kernel under the name: get_seconds().

<sigh> You're may be right. Having to convert from a u64 nanosec value
to a timeval in sys_gettimeofday() as well as get_seconds() may be a
performance problem. But I'm not completely convinced, as we already
have to play games shifting from timevals to timespecs and back. I'm not
sure the nsec/1000000 will kill us.  

Pragmatically I'm willing to bend on that one by using timespecs instead
of u64s. But while I'm in the design phase, thinking of the problem as
juggling u64 nanoseconds simplifies it. Be it a u64 or a timespec, it
really doesn't change the design all that much. One you get to use "+"
and the other you use "time_add()".

thanks
-john



