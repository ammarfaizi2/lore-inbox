Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbUBYUv1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbUBYUrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:47:33 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:31478 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261460AbUBYUqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:46:10 -0500
Message-ID: <403D0986.8040405@mvista.com>
Date: Wed, 25 Feb 2004 12:45:58 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
CC: David Ford <david+powerix@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
References: <403C014F.2040504@blue-labs.org>	 <1077674048.10393.369.camel@cube>  <403C2E56.2060503@blue-labs.org>	 <1077679677.10393.431.camel@cube>  <403CCD3A.7080200@mvista.com> <1077725042.8084.482.camel@cube>
In-Reply-To: <1077725042.8084.482.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> On Wed, 2004-02-25 at 11:28, George Anzinger wrote:
> 
>>Albert Cahalan wrote:
>>
>>>On Wed, 2004-02-25 at 00:10, David Ford wrote:
> 
> 
>>>Actually, it seems that there is a -significant- time difference in this 
>>>
>>>>phantom clock now, I suspended my notebook to bring it home from the 
>>>>station, and now this time difference is greater than 9 minutes.  I 
>>>>suspect it's roughly 46 seconds plus the amount of time that my notebook 
>>>>was suspended.  Yes, I'm running ntpd.
>>>>
>>>>root     16894  0.0  0.0  1544  484 pts/3    S    Feb24   0:00 grep grep ps
>>>>Wed Feb 25 00:09:09 EST 2004
>>>
>>>OK, this is pointing right at the problem.
>>>
>>>Linux does not record process start times at all.
>>>Instead, it records the number of clock ticks
>>>from boot until the process starts.
>>>
>>>Either the boot time or current time is real.
>>>The other may be computed from the uptime, which
>>>may be measured in clock ticks.
>>
>>In 2.6.* boot time is captured at boot.  This is then adjusted when ever the 
>>clock is set.  Up time is the difference between the saved boot time and the 
>>current wall clock time.
>>
>>
>>>The clock doesn't tick when your laptop sleeps.
>>
>>I would guess that the clock adjustment made when the sleep ends is not 
>>adjusting the boot time as it should.  That code should set the clock by calling 
>>do_settimeofday() which will do the right thing.
> 
> 
> I don't think so. The problem might be fixable by advancing
> jiffies, crediting the extra ticks to idle time.
> Consider the current situation as I know it, in jiffies:
> 
> 00000 boot
> 10000 process 42 starts
> 20000 go to sleep
> 20000 wake (same jiffies, different time)
> 30000 process 51 starts
> 40000 ps examines the state of the system
> 
> Process 42 was started 10 seconds after boot. (10000 jiffies)
> Process 51 appears to be started 30 seconds after boot. (30000 jiffies + ???) 
> 
> Now we want to compute:
> 
> 1. real-world date and time for process start
> 2. length of process lifetime (real-world or not?)
> 
> What works for process 42 won't work for process 51,
> because they are on different sides of a hidden gap.
> 
> Another way to fix the problem is to move the boot time.
> It's kind of sick, but so are the alternatives.
> 
> 
>>As to small drifts of ~170 PPM, they are caused by code (ps I would guess) that 
>>assumes that jiffies is exactly 1/HZ whereas it is NOT in the 2.6.* kernel.  The 
>>size of the jiffie that the kernel uses is returned by:
>>
>>struct timespec tv;
>>:
>>:
>>clock_res(CLOCK_REALTIME, &tv);
>>
>>This will be in nanoseconds (and must be as that is what the wall clock is in).
> 
> 
> This is NOT sane. Remeber that procps doesn't get to see HZ.
> Only USER_HZ is available, as the AT_CLKTCK ELF note.

May be, I did not do this, but only cleaned up the internal notion of jiffy so 
timers would work more correctly.  If you go back to HZ=100, every thing works 
better in this regard.

On the other hand, what practical difference does it make?  Almost no user code 
even looks at USER_HZ.  Its just things like ps and friends as far as I can 
tell...  Possibly we should just fix the utilities to use the above call to get 
the jiffie size...  I don't know the full history, but was USER_HZ invented by 
the 2.5 changes?
> 
> I think the way to fix this is to skip or add a tick
> every now and then, so that the long-term HZ is exact.

This is REAL problem for any code that wants to use more exact time/ timers than 
the 1/HZ.  See, for example, the high res patch (signature).  You can not just 
throw in an extra tick every so often.
> 
> Another way is to simply choose between pure old-style
> tick-based timekeeping and pure new-style cycle-based
> (TSC or ACPI) timekeeping. Systems with uncooperative
> hardware have to use the old-style time keeping. This
> should simply the code greatly.

Hm, the reason 1/HZ is not used is that the x86 hardware (PIT, to be exact) can 
not give a good 1/1000 value...
> 
> 
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

