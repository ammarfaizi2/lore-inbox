Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVCOWOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVCOWOR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVCOWMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:12:18 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:52468 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261907AbVCOWKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:10:40 -0500
Message-ID: <42375CC2.9070805@mvista.com>
Date: Tue, 15 Mar 2005 14:08:02 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Christoph Lameter <clameter@sgi.com>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.58.0503142116320.16655@schroedinger.engr.sgi.com> <1110911106.30498.457.camel@cog.beaverton.ibm.com>
In-Reply-To: <1110911106.30498.457.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Mon, 2005-03-14 at 21:37 -0800, Christoph Lameter wrote:
> 
>>Note that similarities exist between the posix clock and the time sources.
>>Will all time sources be exportable as posix clocks?
> 
> 
> At this point I'm not familiar enough with the posix clocks interface to
> say, although its probably outside the scope of the initial timeofday
> rework.

I do think we need to consider the needs of that subsystem.  Clock wise, it 
makes a monotonic and a real time clock available to the user.  The real time 
clock is just a timespec version of the timeval gettimeofday clock.  At the 
current time, the monotonic clock is the real time clock plus wall_to_monotonic. 
  All that is rather simple and straight forward, an I don't recommend adding 
any other clocks unless there is a real need.

The interesting thing is that the posix timers are based on the posix clocks 
which are base on wall_clock, and the jiffies clock which is what runs the 
timers.  In order to make sense of timer requests it is neccessary to, 
atomically, grab all three clocks (i.e. wall_clock aka gettimeofday, 
wall_to_monotonic, and jiffies with the jiffies offset).  The code can then 
figure out when a timer needs to expire in jiffies time in order to expire at a 
given wall or monotonic time.  Currently the xtime_time sequence lock is used to 
do this.

Another issue that posix timers brings forward is the need to know when the 
clock is set.  This is needed to cause timers that were requested to expire at 
some absolute wall_time to do so even if time is set while they are running.  A 
word on how this is done is in order...

Since the processing of a clock set by the posix timers code may, in fact, allow 
the time to be set more than once before the affected timers are adjusted (or 
rather to avoid the locking rats nest not allowing this would cause), the 
wall_to_monotonic value is exploited.  In particular, a clock setting changes 
this value by the exact amount that time was adjusted.  So, each posix timer 
carries the value of wall_to_monotonic that was in use when the timer was 
started.  The clock_was_set code uses this to compute the clock movement and 
thus the adjustment needed to make the timer expire at the right time.

What this translates to in the new code is a) the need for a way to atomically 
get all the key times (wall, monotonic, jiffie) and b) access to a value that 
will allow it to compute the amount of time a clock set, or a series of clock 
settings, changed time by.  Of course, it also needs the clock_was_set() notify 
call.
> 
> Do you have a link that might explain the posix clocks spec and its
> intent?

Well, there is my signature :)  Really, on the high-res-timers project site you 
want to download the support patch.  In there, among other things, is a set of 
man pages on posix clocks & timers.  The patch applies to any kernel and just 
adds a new set of directories off of Documentation.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

