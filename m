Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbTCKXfB>; Tue, 11 Mar 2003 18:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261725AbTCKXfB>; Tue, 11 Mar 2003 18:35:01 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:42484 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261723AbTCKXez>;
	Tue, 11 Mar 2003 18:34:55 -0500
Message-ID: <3E6E74C8.9040006@mvista.com>
Date: Tue, 11 Mar 2003 15:44:08 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Joel.Becker@oracle.com,
       "Martin J. Bligh" <mbligh@aracnet.com>, wim.coekaerts@oracle.com
Subject: Re: [RFC][PATCH] linux-2.5.64_monotonic-clock_A1
References: <1047411561.16614.684.camel@w-jstultz2.beaverton.ibm.com>	 <1047411650.16613.687.camel@w-jstultz2.beaverton.ibm.com>	 <3E6E5989.6060301@mvista.com>	 <1047419933.16615.704.camel@w-jstultz2.beaverton.ibm.com>	 <3E6E65BC.2060200@mvista.com> <1047423553.16608.723.camel@w-jstultz2.beaverton.ibm.com>
In-Reply-To: <1047423553.16608.723.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Tue, 2003-03-11 at 14:39, george anzinger wrote:
> 
> 
>>I must have confused you.  I am woking on a get time of day sort of 
>>thing.  In time.c, the gettimeofday code calls get_offset() and then 
>>adds in lost ticks (ticks clocked by the PIT interrupt but not yet 
>>rolled into the wall clock (xtime).  I was thinking that get_offset 
>>might be defined to add this its result.
> 
> 
> I'm still not quite following that. But as long as we're both pointing
> at the same code and grunting in agreement I think I'll just let it
> slide ;)
> 
> 
> 
>>But, back to the problem I am trying to solve.  The posixtimers code 
>>is in the common kernel and needs the result returned by get_offset 
>>OR, we could define a new function, get_monotonictimeofday(), which 
>>returns the jiffies since boot + get_offset() + pending ticks (i.e. it 
>>would be the same as gettimeofday except it would use jiffies_64 
>>instead of xtime to get its result.  The format would be a timespec, 
>>i.e. the same as xtime.
> 
> 
> 
> Actually, what is the difference between the call you're trying to
> implement and monotonic_clock() (outside of the timespec return)?  Could
> you point me to the specific code you are describing? It sounds like
> we're working on basically the same solution from two different angles. 

The code is in .../kernel/posix-timers.c  look for:
do_posix_clock_monotonic_gettime(struct timespec *tp)

It currently just converts jiffies_64, but it needs to add the sub 
jiffie get_offset() to do the right thing.

As to the difference, my function returns time to the user and is used 
to set up timers and even clock_nanosleep.  It must be something that 
ticks at the same rate at the wall clock.  It is not clear that a full 
TSC clock does this, i.e. I suspect (nay, I KNOW) there is drift 
between the two.
> 
> 
> 
>>This translates directly into a system call and is also used in the 
>>timers code to convert from wall clock time to jiffies time for timers.
>>
>>Either way, we have a bit of a mess due to the arch dependency.  I 
>>don't really care which way it goes, but I do think it should be 
>>resolved in 2.5.
> 
> 
> Well, if the generic interfaces aren't providing what you need, then a
> new interface needs to be considered. This is precisely what the
> hangcheck-timer code ran into, and is why we're working on this
> monotonic_clock() code (which is intended be arch independent in the
> future). 
> 
Right.  As is the above.  It is already in the common kernel.  We do 
need the get_offset() extension, however.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

