Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTJXCK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 22:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbTJXCK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 22:10:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38902 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261939AbTJXCKZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 22:10:25 -0400
Message-ID: <3F988A0B.4010803@mvista.com>
Date: Thu, 23 Oct 2003 19:10:19 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Pavel Machek <pavel@suse.cz>, Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
References: <20031022233306.GA6461@elf.ucw.cz>	 <1066866741.1114.71.camel@cog.beaverton.ibm.com>	 <20031023081750.GB854@openzaurus.ucw.cz>  <3F9838B4.5010401@mvista.com>	 <1066942532.1119.98.camel@cog.beaverton.ibm.com>	 <3F985FB0.1070901@mvista.com> <1066955396.1122.133.camel@cog.beaverton.ibm.com>
In-Reply-To: <1066955396.1122.133.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Thu, 2003-10-23 at 16:09, George Anzinger wrote:
> 
>>john stultz wrote:
>>
>>>On Thu, 2003-10-23 at 13:23, George Anzinger wrote:
>>>
>>>>I lost (never saw) the first of this thread, BUT, if this is 2.6, I strongly 
>>>>recommend that settimeofday() NOT be called.  It will try to adjust 
>>>>wall_to_motonoic, but, as this appears to be a correction for time lost while 
>>>>sleeping, wall_to_monotonic should not change.
>>>
>>>While suspended should the notion monotonic time be incrementing? If
>>>we're not incrementing jiffies, then uptime isn't being incremented, so
>>>to me it doesn't follow that the monotonic time should be incrementing
>>>as well. 
>>
>>Uh, not moving jiffies?  What does this say about any timers that may be 
>>pending?  Say for cron or some such?  Like I said, I picked up this thread a bit 
>>late, but, seems to me that if time is passing, it should pass on both the 
>>jiffies AND the wall clocks.
> 
> 
> My understanding is that we are suspending the box (ie: putting your
> laptop to sleep/hybernate), so for all practical purposes the box is off
> waiting until it is woken up. During that time I don't believe we
> receive timer interrupts. When we are woken up, we should update the
> system time and continue, but as the box wasn't running during the
> interim we shouldn't be increasing the notion of monotonic time. 
> 
> 
>>>It may very well be a POSIX timers spec issue, but it just strikes me as
>>>odd.
>>
>>The spec thing would relate to any sleeps or timers that are pending.  The spec 
>>would seem to say they should complete somewhere near the requested wall time, 
>>but NEVER before.  By not moving jiffies, I think they will be a bit late.  Now, 
>>if they were to complete during the sleep, well those should fire at completion 
>>of the sleep.  If the are to complete after the sleep, then, it seems to me, 
>>they should fire at the requested time.
> 
> 
> Hmmm. That last sentence gives me pause. I guess it comes down to how
> you request your timer expiration: in wall time or system time.  I
> always thought it was in system time, but you know this stuff better
> then I, so I'll defer.

The request can be on the wall clock or on clock_monotonic.  Still, we went 
round and round about how a tick on one should be a tick on the other.  My 
understanding is that the pm_timer was put in the ACPIC to handle this, but then 
I don't know how far down power is going, nor for how long.  I would think at 
some point the discontinuity would be large enough that one would want some user 
service to run and "fix" all the broken time assumptions.  Some sort of a soft 
reboot that would kick the ntp code, cron and so on, much as is done at boot.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

ps, long week end, out till Tuesday...

