Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbTCKW3x>; Tue, 11 Mar 2003 17:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261646AbTCKW3x>; Tue, 11 Mar 2003 17:29:53 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:35836 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261644AbTCKW3w>;
	Tue, 11 Mar 2003 17:29:52 -0500
Message-ID: <3E6E65BC.2060200@mvista.com>
Date: Tue, 11 Mar 2003 14:39:56 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Joel.Becker@oracle.com,
       "Martin J. Bligh" <mbligh@aracnet.com>, wim.coekaerts@oracle.com
Subject: Re: [RFC][PATCH] linux-2.5.64_monotonic-clock_A1
References: <1047411561.16614.684.camel@w-jstultz2.beaverton.ibm.com>	 <1047411650.16613.687.camel@w-jstultz2.beaverton.ibm.com>	 <3E6E5989.6060301@mvista.com> <1047419933.16615.704.camel@w-jstultz2.beaverton.ibm.com>
In-Reply-To: <1047419933.16615.704.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Tue, 2003-03-11 at 13:47, george anzinger wrote:
> 
>>Some comments below on the scaling.
> 
> 
> Thanks, I'll try to digest your comments and get back to you.
> 
> 
> 
>>On a related note, I would like to extend the CLOCK_MONOTONIC code to 
>>the same res as CLOCK_REALTIME in the POSIX clocks and timers patch. 
>>The patch uses jiffies_64 for CLOCK_MONOTONIC, so what I would like to 
>>do is use get_offset() to fill in the sub_jiffies part. Is this 
>>function available (i.e. timer->get_offset()) on all archs?
> 
> 
> 
> Nope, the timer_opts structure is i386 only. Further, the need for the
> monotonic_clock() interface is because timer->get_offset() only returns
> 32bits of information, which on a 2Ghz cpu is only ~2 seconds worth of
> time. We need multiple minutes worth of time to be returned, thus the 64
> bit return of monotonic_clock. 
> 
> I considered making get_offset() return a 64bit value, but worried that
> the cost of the 64bit math would hurt gettimeofday too much to be worth
> it. So rather then complicate a heavily used function to handle a very
> rare case, we decided to implement a new interface that doesn't need to
> be as fast as gettimeofday, but can handle long periods of time w/o
> interrupts.
> 
> 
> 
>>It seems to me that the lost jiffies should be rolled into 
>>get_offset().  Have you considered doing this?
> 
> 
> I'm not sure I'm following this? get_offset returns the amount of time
> since mark_offset() was called(last interrupt). The lost-jiffies
> compensation code I added uses get_offset() to detect how many jiffies
> should have passed. How do you suggest rolling it into get_offset?

I must have confused you.  I am woking on a get time of day sort of 
thing.  In time.c, the gettimeofday code calls get_offset() and then 
adds in lost ticks (ticks clocked by the PIT interrupt but not yet 
rolled into the wall clock (xtime).  I was thinking that get_offset 
might be defined to add this its result.

But, back to the problem I am trying to solve.  The posixtimers code 
is in the common kernel and needs the result returned by get_offset 
OR, we could define a new function, get_monotonictimeofday(), which 
returns the jiffies since boot + get_offset() + pending ticks (i.e. it 
would be the same as gettimeofday except it would use jiffies_64 
instead of xtime to get its result.  The format would be a timespec, 
i.e. the same as xtime.

This translates directly into a system call and is also used in the 
timers code to convert from wall clock time to jiffies time for timers.

Either way, we have a bit of a mess due to the arch dependency.  I 
don't really care which way it goes, but I do think it should be 
resolved in 2.5.

thanks
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

