Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbUBZXJj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbUBZXJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:09:12 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:39929 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261236AbUBZXG2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:06:28 -0500
Message-ID: <403E7BEE.9040203@mvista.com>
Date: Thu, 26 Feb 2004 15:06:22 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Albert Cahalan <albert@users.sourceforge.net>,
       David Ford <david+powerix@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
References: <403C014F.2040504@blue-labs.org>	 <1077674048.10393.369.camel@cube>  <403C2E56.2060503@blue-labs.org>	 <1077679677.10393.431.camel@cube>  <403CCD3A.7080200@mvista.com>	 <1077725042.8084.482.camel@cube>  <403D0F63.3050101@mvista.com> <1077760348.2857.129.camel@cog.beaverton.ibm.com>
In-Reply-To: <1077760348.2857.129.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Wed, 2004-02-25 at 13:10, George Anzinger wrote:
> 
>>Albert Cahalan wrote:
>>
>>>This is NOT sane. Remeber that procps doesn't get to see HZ.
>>>Only USER_HZ is available, as the AT_CLKTCK ELF note.
>>>
>>>I think the way to fix this is to skip or add a tick
>>>every now and then, so that the long-term HZ is exact.
>>>
>>>Another way is to simply choose between pure old-style
>>>tick-based timekeeping and pure new-style cycle-based
>>>(TSC or ACPI) timekeeping. Systems with uncooperative
>>>hardware have to use the old-style time keeping. This
>>>should simply the code greatly.
>>
>>On checking the code and thinking about this, I would suggest that we change 
>>start_time in the task struct to be the wall time (or monotonic time if that 
>>seems better).  I only find two places this is used, in proc and in the 
>>accounting code.  Both of these could easily be changed.  Of course, even 
>>leaving it as it is, they could be changed to report more correct values by 
>>using the correct conversions to translate the system HZ to USER_HZ.
> 
> 
> Is this close to what your thinking of? 
> I can't reproduce the issue on my systems, so I'll need someone else to
> test this. 

More or less.  I wonder if:




static inline long jiffies_to_clock_t(long x)
{
	u64 tmp = (u64)x * TICK_NSEC;
	div64(tmp, (NSEC_PER_SEC / USER_HZ));
	return (long)x;
}
might be better as it addresses the overflow issue.  Should be able to toss the 
#if (HZ % USER_HZ)==0 test too.  We could get carried away and do scaled math to 
eliminate the div64 but I don't think this path is used enough to justify the 
clarity ;) that would make.

-g

> 
> thanks
> -john
> 
> --- 1.5/include/linux/times.h	Sun Nov  9 19:26:08 2003
> +++ edited/include/linux/times.h	Wed Feb 25 17:39:11 2004
> @@ -7,7 +7,7 @@
>  #include <asm/param.h>
>  
>  #if (HZ % USER_HZ)==0
> -# define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))
> +# define jiffies_to_clock_t(x) (((x*TICK_NSEC*HZ)/NSEC_PER_SEC) / (HZ / USER_HZ))
>  #else
>  # define jiffies_to_clock_t(x) ((clock_t) jiffies_64_to_clock_t((u64) x))
>  #endif
> 
> 
> 
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

