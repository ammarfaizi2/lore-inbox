Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVEPRfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVEPRfI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 13:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVEPRen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 13:34:43 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:31741 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261769AbVEPRe3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 13:34:29 -0400
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
In-Reply-To: <Pine.LNX.4.62.0505141251490.18681@schroedinger.engr.sgi.com>
References: <1116029796.26454.2.camel@cog.beaverton.ibm.com>
	 <1116029872.26454.4.camel@cog.beaverton.ibm.com>
	 <1116029971.26454.7.camel@cog.beaverton.ibm.com>
	 <1116030058.26454.10.camel@cog.beaverton.ibm.com>
	 <1116030139.26454.13.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.62.0505141251490.18681@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Mon, 16 May 2005 10:34:18 -0700
Message-Id: <1116264858.26990.39.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-14 at 12:55 -0700, Christoph Lameter wrote:
> On Fri, 13 May 2005, john stultz wrote:
> 
> > I look forward to your comments and feedback.
> 
> Here is the implementation of the IA64 timesources for the new time of 
> day subsystem.

Great!

> This is quite straighforward. Thanks John. However, the ITC
> interpolator can no longer use MMIO in SMP situations since there is no 
> provision for jitter compensation in the new time of day subsystem. I have
> implemented that via a function now which will slow down clock access
> for non SGI IA64 hardware significantly since it will not be able to use
> the fastcall anymore.
> 
> I am working on the fastcall but I would need a couple of changes
> to the core code to make the following symbols non-static since they
> will need to be accessed from the fast syscall handler:
> 
> timesource
> system_time
> wall_time_offset
> offset_base


Actually that shouldn't be necessary. Look at my arch-x86-64 patch or
vsyscall-i386 patch for how the arch_vsyscall_gtod_update() function is
used. It provides an arch specific hook called by the timeofday core to
provide the information you desire. 

Please let me know if it is not sufficient for some reason. 

[snip]

> I would recommend to add jitter compensation to the time sources. Otherwise
> each ITC/TSC like timesource will have to implement that on its own.

Just to clarify for others, this is the same unsynced cpu cycle counter
problem that affects the TSC on i386 and x86-64. ia64 gets around the
problem by checking on every call to gettimeofday() if the ITC value is
less then the ITC value used on the previous call to gettimeofday(). If
the value is less (ie: would result in time going backwards) it just
uses the last value to calculate time. It then uses cmpxchg to
atomically update the last ITC value. 

The problem I have with this is it that if the ITCs are not synced, they
really are not good timesources. If one cpu's ITC is behind another, the
net result of the above algorithm is cpu 2 will always just use cpu 1's
last calculated time. This could cause jumps in time when a process
moves from cpu2 to cpu1.

Since it only affects the TSC and ITC, I think keeping the decision to
use cmpxchg in the timesource code, as you've implemented with the ITC
is the best way to go. If you really want to you can special case the
arch specific fsyscall code by switching on the time source .name, and
that would allow you to use a similar cmpxchg algorithm there as well. 


thanks
-john

