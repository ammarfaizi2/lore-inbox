Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269549AbUJFWxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269549AbUJFWxq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269531AbUJFWvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:51:19 -0400
Received: from gizmo08ps.bigpond.com ([144.140.71.18]:53226 "HELO
	gizmo08ps.bigpond.com") by vger.kernel.org with SMTP
	id S269591AbUJFWq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:46:59 -0400
Message-ID: <416475DA.8070909@bigpond.net.au>
Date: Thu, 07 Oct 2004 08:46:50 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Ingo Molnar'" <mingo@elte.hu>, "'Ingo Molnar'" <mingo@redhat.com>,
       linux-kernel@vger.kernel.org, "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Subject: Re: Default cache_hot_time value back to 10ms
References: <200410061718.i96HI9606629@unix-os.sc.intel.com>
In-Reply-To: <200410061718.i96HI9606629@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
>>Chen, Kenneth W wrote on Tuesday, October 05, 2004 10:31 AM
>>
>>>We have experimented with similar thing, via bumping up sd->cache_hot_time to
>>>a very large number, like 1 sec.  What we measured was a equally low throughput.
>>>But that was because of not enough load balancing.
>>
>>Since we are talking about load balancing, we decided to measure various
>>value for cache_hot_time variable to see how it affects app performance. We
>>first establish baseline number with vanilla base kernel (default at 2.5ms),
>>then sweep that variable up to 1000ms.  All of the experiments are done with
>>Ingo's patch posted earlier.  Here are the result (test environment is 4-way
>>SMP machine, 32 GB memory, 500 disks running industry standard db transaction
>>processing workload):
>>
>>cache_hot_time  | workload throughput
>>--------------------------------------
>>         2.5ms  - 100.0   (0% idle)
>>         5ms    - 106.0   (0% idle)
>>         10ms   - 112.5   (1% idle)
>>         15ms   - 111.6   (3% idle)
>>         25ms   - 111.1   (5% idle)
>>         250ms  - 105.6   (7% idle)
>>         1000ms - 105.4   (7% idle)
>>
>>Clearly the default value for SMP has the worst application throughput (12%
>>below peak performance).  When set too low, kernel is too aggressive on load
>>balancing and we are still seeing cache thrashing despite the perf fix.
>>However, If set too high, kernel gets too conservative and not doing enough
>>load balance.
> 
> 
> Ingo Molnar wrote on Wednesday, October 06, 2004 12:48 AM
> 
>>could you please try the test in 1 msec increments around 10 msec? It
>>would be very nice to find a good formula and the 5 msec steps are too
>>coarse. I think it would be nice to test 7,9,11,13 msecs first, and then
>>the remaining 1 msec slots around the new maximum. (assuming the
>>workload measurement is stable.)
> 
> 
> I should've post the whole thing yesterday, we had measurement of 7.5 and
> 12.5 ms.  Here is the result (repeating 5, 10, 15 for easy reading).
> 
>  5   ms 106.0
>  7.5 ms 110.3
> 10   ms 112.5
> 12.5 ms 112.0
> 15   ms 111.6
> 
> 
> 
>>>This value was default to 10ms before domain scheduler, why does domain
>>>scheduler need to change it to 2.5ms? And on what bases does that decision
>>>take place?  We are proposing change that number back to 10ms.
>>
>>agreed. What value does cache_decay_ticks have on your box?
> 
> 
> 
> I see all the fancy calculation with cache_decay_ticks on x86, but nobody
> actually uses it in the domain scheduler.  Anyway, my box has that value
> hard coded to 10ms (ia64).
> 

If you fit a quadratic equation to this data, take the first derivative 
and then solve for zero it will give the cache_hot_time that maximizes 
the throughput.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
