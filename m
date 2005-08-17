Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbVHQXPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVHQXPb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 19:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbVHQXPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 19:15:31 -0400
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:42653 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751312AbVHQXPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 19:15:30 -0400
Message-ID: <4303C510.3010702@bigpond.net.au>
Date: Thu, 18 Aug 2005 09:15:28 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Schedulers benchmark - Was: [ANNOUNCE][RFC] PlugSched-5.2.4 for
 2.6.12 and 2.6.13-rc6
References: <43001E18.8020707@bigpond.net.au> <6bffcb0e05081614498879a72@mail.gmail.com> <4302F0D8.6050409@bigpond.net.au> <200508171903.43985.kernel@kolivas.org>
In-Reply-To: <200508171903.43985.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 17 Aug 2005 23:15:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Wed, 17 Aug 2005 18:10, Peter Williams wrote:
> 
>>Michal Piotrowski wrote:
>>
>>>Hi,
>>>here are schedulers benchmark (part2):
>>>[bits deleted]
>>
>>Here's a summary of your output generated using the attached Python script.
>>
>>              |         Build Statistics | Overall Statistics
>>
>>-----------------------------------------------------------------------
>>     Scheduler|   Real    CPU  SYS   TPT |    CPU   TPT    delay    CXSW
>>
>>              | (secs) (secs)  (%)   (%) | (secs)   (%)  (secs)
>>
>>-----------------------------------------------------------------------
>>     ingosched| 3128.5 5056.3 8.18 161.6 | 5379.5 171.9 159367.4 1556452
>>     staircase| 3131.2 5032.6 8.09 160.7 | 5352.9 170.9 135193.0 1670366
>>spa_no_frills| 3103.8 5049.5 7.98 162.7 | 5266.7 169.7 172384.8  520937
>>   zaphod(d,d)| 3561.7 4823.8 9.25 135.4 | 5132.0 144.1 148361.5 1771617
>>   zaphod(d,0)| 3551.2 4809.9 9.19 135.4 | 5114.7 144.0 144022.0 1784814
>>   zaphod(0,d)| 3126.8 5063.2 8.11 161.9 | 5278.1 168.8 173438.4  573587
>>   zaphod(0,0)| 3105.5 5052.9 7.98 162.7 | 5254.8 169.2 165774.4  577534
>>     nicksched| 3294.7 5095.1 9.10 154.6 | 5425.4 164.6 104298.2 2205665
>>
>>where the (x,y) after zaphod means (max_ia_bonus, max_tpt_bonus) and "d"
>>means default.  I had to kill a few significant digits to squeeze it
>>into 71 columns.  Overall statistics are extracted from the schedstats
>>data.  In the "Build Statistics" "CPU" is the sum of the user and sys
>>times and "SYS" is the percentage of that which was sys time (as I feel
>>that is a better thing to compare than raw sys times).
>>
>>I was intrigued by the fact that zaphod(d,d) and zaphod(d,0) take longer
>>in real time but use less cpu.  I was assuming that this meant that some
>>other job was getting some cpu but the schedstats data doesn't support
>>that.  Also it wouldn't make sense anyway as you'd expect jobs doing the
>>same amount of work to use roughly the same amount of cpu.  My latest
>>theory is that your machine has hyper threads and this artifact is
>>caused by the mechanism in the scheduler for handling tasks with
>>differing priority in sibling hyper thread channels.  Does your system
>>have hyper threads?
> 
> 
> That would only do something if there was a difference in 'nice' levels.

Not in zaphod and spa_no_frills.  They user dynamic priority.  I may 
rethink this as the argument for using dynamic priority mainly applies 
to the entitlement based mode of zaphod.

> What 
> you're seeing is the fact that balancing is intimately tied in with timeslice 
> size and you have increased idle time.

I partially agree in that reducing the time slice size would reduce the 
size of the effect but it's not the cause of the effect.  The hyper 
threading code is the cause.

BTW  I'm wondering why the TPT column (i.e. cpu time / real elapsed 
time) is so low for all schedulers.  It's been a long time since I ran 
your "contest" benchmarks for any of these schedulers but I seem to 
recall that they all did a lot better than this when I extracted the 
equivalent data from the output.  Generally, I think that they all used 
greater than 95% of the available cpu time which would be the equivalent 
of TPT values of 190% or more in this case.

Another interesting thing to be noted in these numbers is that the cost 
of the extra context switches caused by the "improved interactive 
performance" measures doesn't seem to be very significant.

It also looks as if the overhead for zaphod's IA bonus mechanism needs 
to be reduced.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
