Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbUEGBW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUEGBW2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 21:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUEGBW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 21:22:28 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:31620 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262272AbUEGBWZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 21:22:25 -0400
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
From: john stultz <johnstul@us.ibm.com>
To: ganzinger@mvista.com
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, Andrew Morton <akpm@osdl.org>,
       kaukasoi@elektroni.ee.tut.fi, linux-kernel@vger.kernel.org,
       davem@redhat.com
In-Reply-To: <409AD95F.8080502@mvista.com>
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
Content-Type: text/plain
Message-Id: <1083892878.9664.226.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 06 May 2004 18:21:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-06 at 17:33, George Anzinger wrote:
> john stultz wrote:
> > Roughly, I'd like to see the time code for all arches in 2.7 to look
> > like:
> > 
> > u64 system_time 	/* NTP adjusted nanosecs since boot */
> > u64 wall_time_offset	/* offset to system_time for time of day */
> > u64 offset_base		/* last read raw hw value */
> 
> Hm.  In 2.6 we use an NTP adjusted wall time and a wall_to_monotonic offset.  I 
> don't really see the advantage here.  Does this change buy us something?
> For what its worth, I introduced the wall_to_monotonic offset just because it 
> was easier to do (and understand, I think) in the current kernel.

Well, in my opinion it seems much cleaner. Right now any time we adjust
xtime, we have to remember to adjust wall_to_monotonic. I believe we've
had issues where a change was made to just one and not the other. 

This is easier and has simpler rules. system_time always increments and
is only modified by the periodic time_interrupt_hook(). Then
wall_time_offset is only changes by do_settimeofday(). In fact, I hope
to make these values static to the time code, so that all in-kernel
users must go through the monotonic_clock() and do_gettimeofday()
interfaces. 

To be brutal, I'd like to see xtime killed completely. Jiffies and HZ
too, although I'd be happy with those two being made static to the
interval timer code. There are too many places where folks have tried to
extrapolate a time value from some global accounting variable, and w/ HZ
not quite being exactly 1000 now on i386, all that code is just slightly
wrong. Its spaghetti code now, and we just need to put that mess behind
a few clean understandable interfaces.  

But hey, that's me dreaming, I'm sure there will be some reason odd
someone will need to get into the guts of the time code and we'll have
to break the opacity. :)

And I do realize we'll also need a get_timestamp() or something that
will quickly return a low-res timestamp like the current value of
system_time. I don't intend for all those users of xtime or jiffies to
really go out and hit hardware to calculate a nanosecond accurate time
value. 

> > And ignoring the magic NTP_GUNK macros, that's all there is to it
> > (Although don't kid your self, the NTP_GUNK is nasty). 
> 
> Right, and it needs to be recast to use secs and nanosecs...  

Yea, yea, you're right. u64 nanosecond values are just so much simpler
to work with, until you hit the NTP code. 

> But you forget the 
> accounting code which needs the periodic interrupt to charge time to whom ever.

True, although I'd like to avoid doing that in the time subsystem.
Instead the interval timer subsystem would run the accounting code,
which would then call get_timestamp() to calculate the amount of time to
charge a process. 

thanks
-john


