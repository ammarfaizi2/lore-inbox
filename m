Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUJFA7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUJFA7P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 20:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUJFA7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 20:59:15 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:53922 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266574AbUJFA7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 20:59:00 -0400
Message-ID: <41634350.90207@yahoo.com.au>
Date: Wed, 06 Oct 2004 10:58:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: "'Ingo Molnar'" <mingo@redhat.com>, linux-kernel@vger.kernel.org,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: Default cache_hot_time value back to 10ms
References: <200410060042.i960gn631637@unix-os.sc.intel.com>
In-Reply-To: <200410060042.i960gn631637@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:
> Chen, Kenneth W wrote on Tuesday, October 05, 2004 10:31 AM
> 
>>We have experimented with similar thing, via bumping up sd->cache_hot_time to
>>a very large number, like 1 sec.  What we measured was a equally low throughput.
>>But that was because of not enough load balancing.
> 
> 
> Since we are talking about load balancing, we decided to measure various
> value for cache_hot_time variable to see how it affects app performance. We
> first establish baseline number with vanilla base kernel (default at 2.5ms),
> then sweep that variable up to 1000ms.  All of the experiments are done with
> Ingo's patch posted earlier.  Here are the result (test environment is 4-way
> SMP machine, 32 GB memory, 500 disks running industry standard db transaction
> processing workload):
> 
> cache_hot_time  | workload throughput
> --------------------------------------
>          2.5ms  - 100.0   (0% idle)
>          5ms    - 106.0   (0% idle)
>          10ms   - 112.5   (1% idle)
>          15ms   - 111.6   (3% idle)
>          25ms   - 111.1   (5% idle)
>          250ms  - 105.6   (7% idle)
>          1000ms - 105.4   (7% idle)
> 
> Clearly the default value for SMP has the worst application throughput (12%
> below peak performance).  When set too low, kernel is too aggressive on load
> balancing and we are still seeing cache thrashing despite the perf fix.
> However, If set too high, kernel gets too conservative and not doing enough
> load balance.
> 

Great testing, thanks.

> This value was default to 10ms before domain scheduler, why does domain
> scheduler need to change it to 2.5ms? And on what bases does that decision
> take place?  We are proposing change that number back to 10ms.
> 

IIRC Ingo wanted it lower, to closer match previous values (correct
me if I'm wrong).

I think your patch would be fine though (when timeslicing tasks on
the same CPU, I've typically seen large regressions when going below
a 10ms timeslice, even on a small cache CPU (512K).
