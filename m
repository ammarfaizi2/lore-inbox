Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWFBXub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWFBXub (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 19:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbWFBXub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 19:50:31 -0400
Received: from alt.aurema.com ([203.217.18.57]:45151 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S1751550AbWFBXua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 19:50:30 -0400
Message-ID: <4480CE89.8080000@aurema.com>
Date: Sat, 03 Jun 2006 09:49:29 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       dev@openvz.org, Srivatsa <vatsa@in.ibm.com>, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, Balbir Singh <bsingharora@gmail.com>,
       Mike Galbraith <efault@gmx.de>, Sam Vilain <sam@vilain.net>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	<20060526042051.2886.70594.sendpatchset@heathwren.pw.nest>	<661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com>	<44781167.6060700@bigpond.net.au>	<447D95DE.1080903@sw.ru>	<447DBD44.5040602@in.ibm.com>	<447E9A1D.9040109@openvz.org>	<447EA694.8060407@in.ibm.com>	<1149187413.13336.24.camel@linuxchandra>	<447F77A4.3000102@bigpond.net.au>	<1149213759.10377.7.camel@linuxchandra>	<447FAEB0.3060103@aurema.com> <447FF7BB.9000104@in.ibm.com> <44803D5D.20303@bigpond.net.au> <44808A52.9040100@in.ibm.com>
In-Reply-To: <44808A52.9040100@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> Peter Williams wrote:
>> Balbir Singh wrote:
>>
>>> Peter Williams wrote:
>>> <snip>
>>>
>>>>>> But you don't need something as complex as CKRM either.  This capping
>>>>>
>>>>> All CKRM^W Resource Groups does is to group unrelated/related tasks 
>>>>> to a
>>>>> group and apply resource limits.
>>>>>
>>>>>
>>>>>> functionality coupled with (the lamented) PAGG patches (should 
>>>>>> have been called TAGG for "task aggregation" instead of PAGG for 
>>>>>> "process aggregation") would allow you to implement a kernel 
>>>>>> module that could apply caps to arbitrary groups of tasks.
>>>>>
>>>>> I do not follow how PAGG + this cap feature can be used to put cap of
>>>>> related/unrelated tasks. Can you provide little more explanation,
>>>>> please.
>>>>
>>>>
>>>> I would have thought it was fairly obvious.  PAGG supplies the task 
>>>> aggregation mechanism, these patches provide per task caps and all 
>>>> that's needed is the code that marries the two.
>>>>
>>>
>>> The problem is that with per-task caps, if I have a resource group A
>>> and I want to limit it to 10%, I need to limit each task in resource
>>> group A to 10% (which makes resource groups not so useful). Is my
>>> understanding correct?
>>
>>
>> Well the general idea is correct but your maths is wrong.  You'd have 
>> to give each of them a cap somewhere between 10% and 10% divided by 
>> the number of tasks in group A.  Exactly where in that range would 
>> vary depending on the CPU demand of each task and would need to be 
>> adjusted dynamically (unless they were very boring tasks whose demands 
>> were constant over time).
>>
> 
> 
> Hmm.. I thought my math was reasonable (but there is always so much to 
> learn)
>  From your formula, if I have 1 task in group A, I need to provide it with
> a cap of b/w 10 to 11%. For two tasks, I need to give them b/w 10 to 10.5%.
> If I have a hundred, it needs to be b/w 10% and 10.01%

Now your arithmetic is failing you.  According to my formula:

1. With one task in group A you give it 10% which is what you get when 
you divide 10% by one.

2. With two tasks in group A you give them each somewhere between 5% 
(which is 10% divided by 2) and 10%.  If they are equally busy you give 
them each 5% and if they are not equally busy you give them you give 
them larger caps.

Another, probably a better but more expensive, formula is to divide the 
10% between them in proportion to their demand.  Being careful not to 
give any of them a zero cap, of course.  I.e. in the two task 10% case 
they each get 5% if they are equally busy but if one is twice as busy as 
the other it gets a 6.6% cap and the other gets 3.3% (approximately).

Peter
-- 
Dr Peter Williams, Chief Scientist         <peterw@aurema.com>
Aurema Pty Limited
Level 2, 130 Elizabeth St, Sydney, NSW 2000, Australia
Tel:+61 2 9698 2322  Fax:+61 2 9699 9174 http://www.aurema.com
