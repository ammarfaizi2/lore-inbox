Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWAKMYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWAKMYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWAKMYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:24:18 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:23756 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751201AbWAKMYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:24:17 -0500
Message-ID: <43C4F8EE.50208@bigpond.net.au>
Date: Wed, 11 Jan 2006 23:24:14 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@google.com>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm seems significanty slower than mainline on kernbench
References: <43C45BDC.1050402@google.com> <200601111249.05881.kernel@kolivas.org> <43C46F99.1000902@bigpond.net.au> <200601111407.05738.kernel@kolivas.org> <43C47E32.4020001@bigpond.net.au> <43C4941D.6080302@bigpond.net.au> <43C4A3E9.1040301@google.com>
In-Reply-To: <43C4A3E9.1040301@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 11 Jan 2006 12:24:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> Peter Williams wrote:
> 
>> Peter Williams wrote:
>>
>>> Con Kolivas wrote:
>>>
>>>> On Wed, 11 Jan 2006 01:38 pm, Peter Williams wrote:
>>>>
>>>>> Con Kolivas wrote:
>>>>> > I guess we need to check whether reversing this patch helps.
>>>>>
>>>>> It would be interesting to see if it does.
>>>>>
>>>>> If it does we probably have to wear the cost (and try to reduce it) as
>>>>> without this change smp nice support is fairly ineffective due to the
>>>>> fact that it moves exactly the same tasks as would be moved without 
>>>>> it.
>>>>>  At the most it changes the frequency at which load balancing occurs.
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> I disagree. I think the current implementation changes the balancing 
>>>> according to nice much more effectively than previously where by 
>>>> their very nature, low priority tasks were balanced more frequently 
>>>> and ended up getting their own cpu.
>>>
>>>
>>>
>>>
>>> I can't follow the logic here and I certainly don't see much 
>>> difference in practice.
>>
>>
>>
>> I think I've figured out why I'm not seeing much difference in 
>> practice.  I'm only testing on 2 CPU systems and it seems to me that 
>> the main difference that the SMP nice patch will have is in selecting 
>> which CPU to steal tasks from (grabbing the one with the highest 
>> priority tasks) and this is a non issue on a 2 CPU system.  :-(
>>
>> So I should revise my statement to say that it doesn't make much 
>> difference if there's only 2 CPUs.
>>
> 
> If nothing's niced, why would it be affecting scheduling decisions at all?

Load balancing decisions.

> That seems broken to me ?

But, yes, given that the problem goes away when the patch is removed 
(which we're still waiting to see) it's broken.  I think the problem is 
probably due to the changed metric (i.e. biased load instead of simple 
load) causing idle_balance() to fail more often (i.e. it decides to not 
bother moving any tasks more often than it otherwise would) which would 
explain the increased idle time being seen.  This means that the fix 
would be to review the criteria for deciding whether to move tasks in 
idle_balance().

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
