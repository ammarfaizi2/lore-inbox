Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161226AbWALUDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161226AbWALUDa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 15:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbWALUDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 15:03:30 -0500
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:60227 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1161226AbWALUD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 15:03:29 -0500
Message-ID: <43C6B60E.2000003@bigpond.net.au>
Date: Fri, 13 Jan 2006 07:03:26 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <43C4A3E9.1040301@google.com> <43C4F8EE.50208@bigpond.net.au> <200601120129.16315.kernel@kolivas.org> <43C58117.9080706@bigpond.net.au> <43C5A8C6.1040305@bigpond.net.au> <43C6A24E.9080901@google.com>
In-Reply-To: <43C6A24E.9080901@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 12 Jan 2006 20:03:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
> 
>>>
>>> But I was thinking more about the code that (in the original) handled 
>>> the case where the number of tasks to be moved was less than 1 but 
>>> more than 0 (i.e. the cases where "imbalance" would have been reduced 
>>> to zero when divided by SCHED_LOAD_SCALE).  I think that I got that 
>>> part wrong and you can end up with a bias load to be moved which is 
>>> less than any of the bias_prio values for any queued tasks (in 
>>> circumstances where the original code would have rounded up to 1 and 
>>> caused a move).  I think that the way to handle this problem is to 
>>> replace 1 with "average bias prio" within that logic.  This would 
>>> guarantee at least one task with a bias_prio small enough to be moved.
>>>
>>> I think that this analysis is a strong argument for my original patch 
>>> being the cause of the problem so I'll go ahead and generate a fix. 
>>> I'll try to have a patch available later this morning.
>>
>>
>>
>> Attached is a patch that addresses this problem.  Unlike the 
>> description above it does not use "average bias prio" as that solution 
>> would be very complicated.  Instead it makes the assumption that 
>> NICE_TO_BIAS_PRIO(0) is a "good enough" for this purpose as this is 
>> highly likely to be the median bias prio and the median is probably 
>> better for this purpose than the average.
>>
>> Signed-off-by: Peter Williams <pwil3058@bigpond.com.au>
> 
> 
> Doesn't fix the perf issue.

OK, thanks.  I think there's a few more places where SCHED_LOAD_SCALE 
needs to be multiplied by NICE_TO_BIAS_PRIO(0).  Basically, anywhere 
that it's added to, subtracted from or compared to a load.  In those 
cases it's being used as a scaled version of 1 and we need a scaled 
version of NICE_TO_BIAS_PRIO(0).  I'll have another patch later today.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
