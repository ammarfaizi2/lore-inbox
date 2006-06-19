Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWFSLf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWFSLf5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 07:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWFSLf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 07:35:57 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:29277 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932353AbWFSLf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 07:35:56 -0400
Message-ID: <44968C19.7050501@bigpond.net.au>
Date: Mon, 19 Jun 2006 21:35:53 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Peter Williams <peterw@aurema.com>, Andrew Morton <akpm@osdl.org>,
       dev@openvz.org, vatsa@in.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, bsingharora@gmail.com, efault@gmx.de,
       kernel@kolivas.org, sam@vilain.net, kingsley@aurema.com, mingo@elte.hu,
       rene.herman@keyaccess.nl
Subject: Re: [ckrm-tech] [PATCH 0/4] sched: Add CPU rate caps
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest>	<20060618025046.77b0cecf.akpm@osdl.org>	<449529FE.1040008@bigpond.net.au>	<4495EC40.70301@in.ibm.com> <4495F7FE.9030601@aurema.com> <449609E4.1030908@in.ibm.com> <44961758.6070305@bigpond.net.au> <44961A77.800@in.ibm.com> <44961EFC.8080809@bigpond.net.au> <4496608D.6000502@in.ibm.com>
In-Reply-To: <4496608D.6000502@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 19 Jun 2006 11:35:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Peter Williams wrote:
>> Balbir Singh wrote:
>>
>>> Peter Williams wrote:
>>>
>>>> Balbir Singh wrote:
>>>>
>>>>> Peter Williams wrote:
>>>>>
>>>
>>> <snip>
>>>
>>>>> Is it possible that the effective tasks
>>>>> is greater than the limit of the group?
>>>>
>>>>
>>>>
>>>> Yes.
>>>>
>>>>> How do we handle this scenario?
>>>>
>>>>
>>>>
>>>> You've got the problem back to front.  If the number of effective 
>>>> tasks is less than the group limit then you have the situation that 
>>>> needs special handling (not the other way around).  I.e. if the 
>>>> number of effective tasks is less than the group limit then 
>>>> (strictly speaking) there's no need to do any capping at all as the 
>>>> demand is less than the limit.  However, in the case where the group 
>>>> limit is less than one CPU (i.e. less than 1000) the recommended 
>>>> thing to do would be set the limit of each task in the group to the 
>>>> group limit.
>>>>
>>>> Obviously, group limits can be greater than one CPU (i.e. 1000).
>>>>
>>>> The number of CPUs on the system also needs to be taken into account 
>>>> for group capping as if the group cap is greater than the number of 
>>>> CPUs there's no way it can be exceeded and tasks in this group would 
>>>> not need any processing.
>>>>
>>>
>>> What if we have a group limit of 100 (out of 1000) and 150 effective 
>>> tasks in
>>> the group? How do you calculate the cap of each task?
>>
>>
>> Personally I'd round up to 1 :-) but rounding down to zero is also an 
>> option.  The reason I'd opt for 1 is that a zero cap has a special 
>> meaning i.e. background.
>>
>>> I hope my understanding of effective tasks is correct.
>>
>>
>> Yes, but I think that you fail to realize that this problem (a lower 
>> limit to what caps can be enforced) exists for any mechanism due to 
>> the fact we're stuck with discrete mathematics in computers.  This 
>> includes floating point representations of numbers which are just 
>> crude (discrete maths) approximations of real numbers.
> 
> I do appreciate and realize the problem, thats why I asked the question.
> 
> There are some ways of solving this problem (that I could think about)
> 
> 1. Keep a whole number and fraction pair and increment the fraction until
>   it reaches a whole number and then schedule the task when the whole
>   number value reaches a minimal threshold. Or provide tasks with some
>   minimal whole number ticks in advance and then do not schedule them
>   again till their fractions add up to the whole number (credit system).
> 
>   For example if T1 and T2 have a cap of 0.5%. Then represent the values
>   as whole number zero and fraction represented as 1 and divisor as 2.
> 
>   Every two ticks their whole number would become 1 and fraction 0, 
> divisor 2.
>   Schedule the tasks for a tick whenever its whole number becomes 1
>   and reset then its whole number to 0.

You're over engineering and you're not solving the problem.  You're just 
moving it down a bit.

> 
> 
> 2. In a group based cap management system, schedule some tasks (highest 
> priority)
>   until their cap run out. In the subsequent rounds pick and choose 
> tasks that
>   did not get a chance to run earlier.
> 
> Solving this is indeed a interesting problem.
> 

Once again, you're over engineering and probably making the problem worse.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
