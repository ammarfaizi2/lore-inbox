Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269173AbUJFNv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269173AbUJFNv7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269177AbUJFNv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:51:59 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:14716 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269173AbUJFNvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:51:50 -0400
Message-ID: <4163F6A9.7000604@yahoo.com.au>
Date: Wed, 06 Oct 2004 23:44:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: [patch] sched: auto-tuning task-migration
References: <200410060042.i960gn631637@unix-os.sc.intel.com> <20041006132930.GA1814@elte.hu>
In-Reply-To: <20041006132930.GA1814@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> 
> 
>>Since we are talking about load balancing, we decided to measure
>>various value for cache_hot_time variable to see how it affects app
>>performance. We first establish baseline number with vanilla base
>>kernel (default at 2.5ms), then sweep that variable up to 1000ms.  All
>>of the experiments are done with Ingo's patch posted earlier.  Here
>>are the result (test environment is 4-way SMP machine, 32 GB memory,
>>500 disks running industry standard db transaction processing
>>workload):
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
> 
> 
> the following patch adds a new feature to the scheduler: during bootup
> it measures migration costs and sets up cache_hot value accordingly.
> 
> The measurement is point-to-point, i.e. it can be used to measure the
> migration costs in cache hierarchies - e.g. by NUMA setup code. The
> patch prints out a matrix of migration costs between CPUs. 
> (self-migration means pure cache dirtying cost)
> 
> Here are a couple of matrixes from testsystems:
> 
> A 2-way Celeron/128K box:
> 
>  arch cache_decay_nsec: 1000000
>  migration cost matrix (cache_size: 131072, cpu: 467 MHz):
>          [00]  [01]
>  [00]:    9.6  12.0
>  [01]:   12.2   9.8
>  min_delta: 12586890
>  using cache_decay nsec: 12586890 (12 msec)
> 
> a 2-way/4-way P4/512K HT box:
> 
>  arch cache_decay_nsec: 2000000
>  migration cost matrix (cache_size: 524288, cpu: 2379 MHz):
>          [00]  [01]  [02]  [03]
>  [00]:    6.1   6.1   5.7   6.1
>  [01]:    6.7   6.2   6.7   6.2
>  [02]:    5.9   5.9   6.1   5.0
>  [03]:    6.7   6.2   6.7   6.2
>  min_delta: 6053016
>  using cache_decay nsec: 6053016 (5 msec)
> 
> an 8-way P3/2MB Xeon box:
> 
>  arch cache_decay_nsec: 6000000
>  migration cost matrix (cache_size: 2097152, cpu: 700 MHz):
>          [00]  [01]  [02]  [03]  [04]  [05]  [06]  [07]
>  [00]:   92.1 184.8 184.8 184.8 184.9  90.7  90.6  90.7
>  [01]:  181.3  92.7  88.5  88.6  88.5 181.5 181.3 181.4
>  [02]:  181.4  88.4  92.5  88.4  88.5 181.4 181.3 181.4
>  [03]:  181.4  88.4  88.5  92.5  88.4 181.5 181.2 181.4
>  [04]:  181.4  88.5  88.4  88.4  92.5 181.5 181.3 181.5
>  [05]:   87.2 181.5 181.4 181.5 181.4  90.0  87.0  87.1
>  [06]:   87.2 181.5 181.4 181.5 181.4  87.9  90.0  87.1
>  [07]:   87.2 181.5 181.4 181.5 181.4  87.9  87.0  90.0
>  min_delta: 91815564
>  using cache_decay nsec: 91815564 (87 msec)
> 

Very cool. I reckon you may want to make the final number
non linear if possible, because a 2MB cache probably doesn't
need double the cache decay time of a 1MB cache.

And possible things need to be tuned a bit, eg. 12ms for the
128K celeron may be a bit large (even though it does have a
slow bus).

But this is a nice starting point.
