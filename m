Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbTAUUCV>; Tue, 21 Jan 2003 15:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267209AbTAUUCV>; Tue, 21 Jan 2003 15:02:21 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:44942 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267208AbTAUUCT>;
	Tue, 21 Jan 2003 15:02:19 -0500
Subject: Re: [PATCH][2.5] hangcheck-timer
From: john stultz <johnstul@us.ibm.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030121172941.GT20972@ca-server1.us.oracle.com>
References: <200301210135.h0L1ZFa06867@eng2.beaverton.ibm.com>
	 <1043113336.32478.97.camel@w-jstultz2.beaverton.ibm.com>
	 <20030121020015.GQ20972@ca-server1.us.oracle.com>
	 <1043117157.32472.116.camel@w-jstultz2.beaverton.ibm.com>
	 <20030121172941.GT20972@ca-server1.us.oracle.com>
Content-Type: text/plain
Organization: 
Message-Id: <1043179438.15689.36.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 21 Jan 2003 12:03:58 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-21 at 09:29, Joel Becker wrote:
> On Mon, Jan 20, 2003 at 06:45:57PM -0800, john stultz wrote:
> > > 	I'll look into it, but it must absolutely be in terms of wall
> > > clock time as measured from outside the system.
> > 
> > Completely understandable. do_gettimeofday will give you just that (w/o
> > the conversion muck w/ HZ and loops_per_jiffy). 
> 
> 	It looks as though gettimeofday calculates wall time from
> jiffies.  If you udelay(), jiffies doesn't increment and you lose time
> (this is exactly what I'm trying to track here).  How does gettimeofday
> avoid this (maybe I'm misreading the code)?  

gettimeofday calculates wall time by adding xtime + jiffies-wall_jiffies
+ timer->offset(). In most cases timer->offset() is calculated from the
TSC, so even if jiffies does not increment, the offset value keeps on
increasing to keep wall time increasing. 

So ideally this would provide you with what you need. But, of course,
there is one gotcha... 

In the situation you describe, an interrupt happens (call this time_0),
jiffies is incremented and timer->offset() is restarted. Should the next
interrupt be blocked for 3 ticks, timer->offset() will compensate for
that time (time_1,time_2,time_3). However, when the next interrupt does
occur, the offset will be cleared again, causing a discontinuity in time
(back to time_1). 

I have been working on a patch to fix by detecting at interrupt time if
we have lost ticks (by checking against an alternate time source) and
compensating appropriately. Currently my fix is for the cyclone-timer
code in 2.4, and I'll be releasing a 2.5 version soon as well. Once that
is tested well enough I'll generate a TSC version for submission. 

So, currently do_gettimeofday() won't quite do it for you. Your
hangcheck_fire code will get get called after an interrupt, so the
timer->offset() has already been cleared. However, that will hopefully
not be case forever. Since I assume you want your module to work on
systems which do not necessarily have sync'ed TSCs (like certain NUMA
boxes), might you consider continuing using get_cycles() for now,
however place it behind a my_gettimeofday() function. That way, once
this issue is fixed, we can just do a simple
s/my_gettimeofday/do_gettimeofday on your code and be done with it?

In addition to making this easier to fix later, going from cycles->wall
time behind my_gettimeofday() should also fix the case where the cpu_feq
changes causing your earlier second->cycle calculation to be be invalid.
Let me know what you think of this.

thanks
-john

Oh yea, one more thing: I gave the earlier released 2.4 module a whirl,
and the printk() before machine_restart() never gets flushed out to the
logs. Makes it a bit confusing if you are trying to determine if the
hangcheck module or something else bounced the box. 

