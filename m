Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269745AbUICTd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269745AbUICTd5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269767AbUICTdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:33:55 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:6295 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269783AbUICTcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:32:17 -0400
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
In-Reply-To: <41381C2D.7080207@mvista.com>
References: <1094159238.14662.318.camel@cog.beaverton.ibm.com>
	 <1094159379.14662.322.camel@cog.beaverton.ibm.com>
	 <4137CB3E.4060205@mvista.com> <1094193731.434.7232.camel@cube>
	 <41381C2D.7080207@mvista.com>
Content-Type: text/plain
Message-Id: <1094239673.14662.510.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 03 Sep 2004 12:27:54 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 00:24, George Anzinger wrote:
> Albert Cahalan wrote:
> > On Thu, 2004-09-02 at 21:39, George Anzinger wrote:
> > 
> >>john stultz wrote:
> > 
> > 
> >>>+
> >>>+static nsec_t jiffies_cyc2ns(cycle_t cyc, cycle_t* remainder)
> >>>+{
> >>>+
> >>>+	cyc *= NSEC_PER_SEC/HZ;
> >>
> >>Hm... This assumes that 1/HZ is what is needed here.  Today this value is 
> >>999898.  Not exactly reachable by NSEC_PER_SEC/HZ.  Or did I miss something, 
> >>like the relationship of jiffie to 1/HZ and to real time.
> > 
> > 
> > HZ not being HZ is the source of many foul problems.
> > 
> > NTP should be able to correct for the error. For systems
> > not running NTP, provide a fake NTP to make corrections
> > based on the expected frequency error.
> > 
> > Based on that, skip or double-up on the ticks to make
> > them be exactly HZ over long periods of time.
> 
> There are several problems here.  First, to make this possible, you will have to 
> outlaw several values for HZ (1024 comes to mind).  Second, like it or not, 1/HZ 
> or something close to it, is the timer resolution.  I think we need to try and 
> keep this a power of 10, mostly because there are a lot of folks who just don't 
> understand it if it is not.  And third, you need to get real close to it with 
> the hardware timer.  If you introduce NTP or some such to fix things, well, 
> things just break another place.  For example, we started 2.6 with HZ=1000 and 
> had problems like:
>  > time sleep 10
> sleeping for 9.9 seconds.  This will just not do.  Any corrections made to the 
> wall clock really need to be made to the timer system as well.  As it is we 
> assume that, by correctly choosing the tick value, the wall clock will be 
> correct on average, even under NTP.  I.e. that the NTP correction will be, over 
> time, very small.  We really do want code that is much more accurate than "time 
> sleep 10" to be right, i.e. if we sleep for x nanoseconds, the wall clock will 
> have changed by x nanoseconds while we did so.

I feel trying to keep two notions of time, one in the timeofday code and
one in the timer code is the real issue. Trying to better keep them
synced will just lead to madness. Instead the timer subsystem needs to
move to using monotonic_clock(), or get_lowres_timestamp() instead of
using jiffies for its notion of time. Jiffies is just an interrupt
counter. 

This somewhat ignores the fact that we're discussing a "jiffies
timesource", which I only implemented as a lowest common denominator /
if you really don't have anything better / thanks the academy for its'
worst time source ever award/ simple example of the timesource code.

More and more I think I need a t-shirt that reads "jiffies ain't time".

thanks
-john

