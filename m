Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbWALSkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbWALSkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 13:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbWALSkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 13:40:15 -0500
Received: from smtp-out.google.com ([216.239.45.12]:38112 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932654AbWALSkO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 13:40:14 -0500
Message-ID: <43C6A24E.9080901@google.com>
Date: Thu, 12 Jan 2006 10:39:10 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C4A3E9.1040301@google.com> <43C4F8EE.50208@bigpond.net.au> <200601120129.16315.kernel@kolivas.org> <43C58117.9080706@bigpond.net.au> <43C5A8C6.1040305@bigpond.net.au>
In-Reply-To: <43C5A8C6.1040305@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>> But I was thinking more about the code that (in the original) handled 
>> the case where the number of tasks to be moved was less than 1 but 
>> more than 0 (i.e. the cases where "imbalance" would have been reduced 
>> to zero when divided by SCHED_LOAD_SCALE).  I think that I got that 
>> part wrong and you can end up with a bias load to be moved which is 
>> less than any of the bias_prio values for any queued tasks (in 
>> circumstances where the original code would have rounded up to 1 and 
>> caused a move).  I think that the way to handle this problem is to 
>> replace 1 with "average bias prio" within that logic.  This would 
>> guarantee at least one task with a bias_prio small enough to be moved.
>>
>> I think that this analysis is a strong argument for my original patch 
>> being the cause of the problem so I'll go ahead and generate a fix. 
>> I'll try to have a patch available later this morning.
> 
> 
> Attached is a patch that addresses this problem.  Unlike the description 
> above it does not use "average bias prio" as that solution would be very 
> complicated.  Instead it makes the assumption that NICE_TO_BIAS_PRIO(0) 
> is a "good enough" for this purpose as this is highly likely to be the 
> median bias prio and the median is probably better for this purpose than 
> the average.
> 
> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>

Doesn't fix the perf issue.

M.


> Peter
> 
> 
> ------------------------------------------------------------------------
> 
> Index: MM-2.6.X/kernel/sched.c
> ===================================================================
> --- MM-2.6.X.orig/kernel/sched.c	2006-01-12 09:23:38.000000000 +1100
> +++ MM-2.6.X/kernel/sched.c	2006-01-12 10:44:50.000000000 +1100
> @@ -2116,11 +2116,11 @@ find_busiest_group(struct sched_domain *
>  				(avg_load - this_load) * this->cpu_power)
>  			/ SCHED_LOAD_SCALE;
>  
> -	if (*imbalance < SCHED_LOAD_SCALE) {
> +	if (*imbalance < NICE_TO_BIAS_PRIO(0) * SCHED_LOAD_SCALE) {
>  		unsigned long pwr_now = 0, pwr_move = 0;
>  		unsigned long tmp;
>  
> -		if (max_load - this_load >= SCHED_LOAD_SCALE*2) {
> +		if (max_load - this_load >= NICE_TO_BIAS_PRIO(0) * SCHED_LOAD_SCALE*2) {
>  			*imbalance = NICE_TO_BIAS_PRIO(0);
>  			return busiest;
>  		}

