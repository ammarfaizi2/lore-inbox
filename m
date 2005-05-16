Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVEPSqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVEPSqY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 14:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVEPSqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 14:46:24 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:1192 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261792AbVEPSpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 14:45:47 -0400
Subject: Re: IA64 implementation of timesource for new time of day subsystem
From: john stultz <johnstul@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, linux-ia64@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0505161100240.1653@schroedinger.engr.sgi.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com>
	 <1116029872.26454.4.camel@cog.beaverton.ibm.com>
	 <1116029971.26454.7.camel@cog.beaverton.ibm.com>
	 <1116030058.26454.10.camel@cog.beaverton.ibm.com>
	 <1116030139.26454.13.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.62.0505141251490.18681@schroedinger.engr.sgi.com>
	 <1116264858.26990.39.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.62.0505161100240.1653@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Mon, 16 May 2005 11:45:36 -0700
Message-Id: <1116269136.26990.67.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 11:09 -0700, Christoph Lameter wrote:
> On Mon, 16 May 2005, john stultz wrote:
> 
> > Actually that shouldn't be necessary. Look at my arch-x86-64 patch or
> > vsyscall-i386 patch for how the arch_vsyscall_gtod_update() function is
> > used. It provides an arch specific hook called by the timeofday core to
> > provide the information you desire. 
> > 
> > Please let me know if it is not sufficient for some reason. 
> 
> Obviously this wont work since you cannot execute C code nor functions in 
> an ia64 fastcall. I need the variables exported.

No. Look at the x86-64 code. The generic timeofday core calls
arch_update_vsyscall_gtod() (sorry for the function name confusion
above) any time the timekeeping variables change. 

All you need is to do is define  implement an ia64 version of
arch_update_vsyscall_gtod() which can then export the values passed to
it in whatever form you desire so it can be used by the fastcall.


> > > I would recommend to add jitter compensation to the time sources. Otherwise
> > > each ITC/TSC like timesource will have to implement that on its own.
> > 
> > Just to clarify for others, this is the same unsynced cpu cycle counter
> > problem that affects the TSC on i386 and x86-64. ia64 gets around the
> > problem by checking on every call to gettimeofday() if the ITC value is
> > less then the ITC value used on the previous call to gettimeofday(). If
> > the value is less (ie: would result in time going backwards) it just
> > uses the last value to calculate time. It then uses cmpxchg to
> > atomically update the last ITC value. 
> 
> Nope. You are way off here. Unsynched cpu cycle counters lead to the ITC 
> timesource not being registered.
> 
> > The problem I have with this is it that if the ITCs are not synced, they
> > really are not good timesources. If one cpu's ITC is behind another, the
> > net result of the above algorithm is cpu 2 will always just use cpu 1's
> > last calculated time. This could cause jumps in time when a process
> > moves from cpu2 to cpu1.
> 
> Note again that the use of cmpxchg is NOT covering the case of ITCs not 
> being synced. If the ITCs are not synced then no timesource will be 
> established for ITC!
> 
> This is the case of ITC's running synchronous but at a tiny offset. The 
> startup on IA64 syncs the ITCs but cannot guarantee a complete sync. There 
> may be a small offset of a few clock ticks. The cmpxchg is 
> needed to compensate for that small offset. I imagine that other 
> architectures have similar issues.

Just per-cpu cycle counters like the TSC and ITC to my knowledge. The
PPC timebase increments off of a global bus-signal, so it is not
affected. I'd be interested in other examples, though.


> > Since it only affects the TSC and ITC, I think keeping the decision to
> > use cmpxchg in the timesource code, as you've implemented with the ITC
> > is the best way to go. If you really want to you can special case the
> > arch specific fsyscall code by switching on the time source .name, and
> > that would allow you to use a similar cmpxchg algorithm there as well. 
> 
> Again this will not work on IA64 since it does the fast system calls in a 
> different way.

I think you'll find otherwise. The arch_update_vsyscall_gtod() interface
gives each arch quite a bit of flexibility in how to implement their own
accelerated timeofday. 

In pseudo code, all you would need to do is something like:

arch_update_vsyscall_gtod(wall_time, offset_base, timesource, ntp_adj):

	fastcall_data.wall = wall_time
	fastcall_data.base = offset_base
	fastcall_data.ts = timesource
	fastcall_data.ntpadj = ntp_adj


fastcall_gtod(): [I understand this would be done in asm]

	switch(fastcall_data.ts.type):
	case TIMESOURCE_MMIO:
		now = <mmio read code>
	case TIMESOURCE_CYCLE:	
		bow = <cycle read code>
	case TIMESOURCE_FUNCTION:
		# special case for itc
		if (fastcall_data.ts.name == "itc")
			now = <cycle jitter read>
		else
			return gettimeofday()

	offset = (now - fastcall_data.base)
	offset *= fastcall_data.ts.mult 
	offset += fastcall_data.ntpadj
	offset >>= fastcall_data.ts.shift 

	return fastcall_data.wall + offset


> Clock jitter can affect multiple clock sources that may fluctuate
> in a minor way due to a variety of influences. Jitter compensation may 
> help in these situations.

Forgive me as I'm just not aware of these, and am thus hesitant to
change the core code for two known cases that can be cleanly dealt with
in the timesource driver code.

thanks
-john

