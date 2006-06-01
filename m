Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWFAXVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWFAXVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 19:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWFAXVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 19:21:43 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:49877 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1750907AbWFAXVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 19:21:42 -0400
Message-ID: <447F7684.10405@bigpond.net.au>
Date: Fri, 02 Jun 2006 09:21:40 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest> <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com> <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru> <447E26AC.7010102@bigpond.net.au> <447E9ADA.90805@sw.ru>
In-Reply-To: <447E9ADA.90805@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Thu, 1 Jun 2006 23:21:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
>>>>> Using a timer for releasing tasks from their sinbin sounds like a  bit
>>>>> of an overhead. Given that there could be 10s of thousands of tasks.
>>>>
>>>>
>>>>
>>>> The more runnable tasks there are the less likely it is that any of 
>>>> them is exceeding its hard cap due to normal competition for the 
>>>> CPUs.  So I think that it's unlikely that there will ever be a very 
>>>> large number of tasks in the sinbin at the same time.
>>>
>>> for containers this can be untrue...
>>
>>
>> Why will this be untrue for containers?
> if one container having 100 running tasks inside exceeded it's credit, 
> it should be delayed. i.e. 100 tasks should be placed in sinbin if I 
> understand your algo correctly. the second container having 100 tasks as 
> well will do the same.

1. Caps are set on a per task basis not on a group basis.
2. Sinbinning is the last resort and only used for hard caps.  The soft 
capping mechanism is also applied to hard capped tasks and natural 
competition also tends to reduce usage rates.

In general, sinbinning will only kick in on lightly loaded systems where 
there is no competition for CPU resources.

Further, there is a natural ceiling of 999 per CPU on the number tasks 
that will ever be in the sinbin at the same time.  To achieve this 
maximum some very unusual circumstances have to prevail:

1. these 999 tasks must be the only runnable tasks on the system,
2. they all must have a cap of 1/1000, and
3. the distribution of CPU among them must be perfectly fair so that 
they all have the expected average usage rate of 1/999.

If you add one more task to this mix the average usage would be 1/1000 
and if they all had that none would be exceeding their cap and there 
would be no sinbinning at all.  Of course, in reality, half would be 
slightly above the average and half slightly below and about 500 would 
be sinbinned.  But this reality check also applies to the 999 and 
somewhat less than 999 would actually be sinbinned.

As the number of runnable tasks increases beyond 1000 then the number 
that have a usage rate greater than their cap will decrease and quickly 
reach zero.

So the conclusion is that the maximum number of sinbinned tasks per CPU 
is given by:

min(1000 / min_cpu_rate_cap - 1, nr_running)

As you can see, if a minimum cap cpu of 1 causes problems we can just 
increase that minimum.

And once again I ask what's so special about containers that changes this?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
