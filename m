Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWDZAf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWDZAf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 20:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWDZAf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 20:35:58 -0400
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:7822 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932172AbWDZAf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 20:35:57 -0400
Message-ID: <444EC06B.2080804@bigpond.net.au>
Date: Wed, 26 Apr 2006 10:35:55 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] sched: fix evaluation of skip_for_load in move_tasks()
References: <444D9290.6070706@bigpond.net.au> <20060425092840.A23188@unix-os.sc.intel.com> <444EAF74.8090705@bigpond.net.au> <20060425171521.B24677@unix-os.sc.intel.com>
In-Reply-To: <20060425171521.B24677@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 26 Apr 2006 00:35:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Wed, Apr 26, 2006 at 09:23:32AM +1000, Peter Williams wrote:
>> Siddha, Suresh B wrote:
>>> I think we need to change this to
>>> 	if (skip_for_load && idx < this_best_prio && idx == busiest_best_prio)
>>> 		skip_for_load = !busiest_best_prio_seen;
>>>
>>> Otherwise we will reset skip_for_load to '0' even for the tasks whose prio is 
>>> less than this_best_prio but not equal to busiest_best_prio.
>> And why is that a problem?  The intention of this code is to make sure 
>> at least one busiest_best_prio task doesn't get moved as a result of the 
>> "skip for reasons of load weight" mechanism being overridden by the "idx 
>> < this_best_prio" exception.  I can't see how this intention is being 
>> subverted.
> 
> There might be scenarios where we will endup moving other priority tasks(
> not those with busiest_best_prio) which will still become highest priority
> on new queue. This may or may not be bad. But this was not our intention
> with the intended code, right?

I considered this (as part of the original code to allow override of the 
skip for cases where moving a task will make it the best priority on the 
CPU -- NB no extra caveats about finding the best priority task which 
meets the criteria) and decided that it wasn't worth worrying about as 
the complexity of the code required to handle it would be considerable.

Also, because we are actually moving a bigger load than is required to 
balance the total weighted loads on the two queues, there's an argument 
that we should move the smallest one that meets the requirement.  With 
these conflicting arguments, it seems best just to move the first one we 
find that meets the criteria and is movable.

Load balancing is probabilistic at best and extra effort trying to be 
perfect will be wasted.  This is even more the case when you take into 
account the fact that as soon as you release the locks on the queues 
everything is highly likely to change anyway.

I figured that this code is consistent with the original load balancing 
code in this regard.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
