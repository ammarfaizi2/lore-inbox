Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbUKPCSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbUKPCSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 21:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbUKPCSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 21:18:07 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:11211 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261758AbUKPCSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 21:18:00 -0500
Message-ID: <41996353.1060604@cyberone.com.au>
Date: Tue, 16 Nov 2004 13:17:55 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: colpatch@us.ibm.com
CC: Darren Hart <dvhltc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] scheduler: rebalance_tick interval update
References: <1100558313.17202.58.camel@localhost.localdomain>	 <4199550E.1030704@cyberone.com.au> <1100569992.30259.20.camel@arrakis>
In-Reply-To: <1100569992.30259.20.camel@arrakis>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matthew Dobson wrote:

>On Mon, 2004-11-15 at 17:17, Nick Piggin wrote:
>
>>Darren Hart wrote:
>>
>>
>>>The current rebalance_tick() code assigns each sched_domain's
>>>last_balance field to += interval after performing a load_balance.  If
>>>interval is 10, this has the effect of saying:  we want to run
>>>load_balance at time = 10, 20, 30, 40, etc...  If for example
>>>last_balance=10 and for some reason rebalance_tick can't be run until
>>>30, load_balance will be called and last_balance will be updated to 20,
>>>causing it to call load_balance again immediately the next time it is
>>>called since the interval is 10 and we are already at >30.  It seems to
>>>me that it would make much more sense for last_balance to be assigned
>>>jiffies after a load_balance, then the meaning of last_balance is more
>>>exact: "this domain was last balanced at jiffies" rather than "we last
>>>handled the balance we were supposed to do at 20, at some indeterminate
>>>time".  The following patch makes this change.
>>>
>>>
>>>
>>Hi Darren,
>>
>>This is how I first implemented it... but I think this will cause
>>rebalance points of each processor to tend to become synchronised
>>(rather than staggered) as ticks get lost.
>>
>
>
>But isn't that what this is supposed to stop:
>
>        unsigned long j = jiffies + CPU_OFFSET(this_cpu);
>....
>                if (j - sd->last_balance >= interval) {
>                        if (load_balance(this_cpu, this_rq, sd, idle)) {
>                                /* We've pulled tasks over so no longer idle */
>                                idle = NOT_IDLE;
>                        }
>                        sd->last_balance += interval;
>                }
>
>The CPU_OFFSET() macro is designed to spread out the balancing so they
>don't all occur at the same time, no?
>
>

Yes, but if you balance n ticks since the last _rebalance_, then things will
be able to drift. Let's say 2 CPUs, they balance at 10 jiffies intervals,
5 jiffies apart:

jiffy   CPU0                              CPU1
0       rebalance (next, 10)
5                                         rebalance (next, 15)
10      rebalance (next, 20)
15                                        rebalance can't be run until
                                          30 as per Darren's example.
20      rebalance (next, 30)
30      rebalance (next, 40)              rebalance (next, 40)

So CPU0 and CPU1 are now synchronised. Having the next balance be calculated
from the _current_ time leaves you open to all sorts of these drift issues.

Another example, in some ticks, a CPU won't see the updated 'jiffies', other
times it will (at least on Altix systems, this can happen).

