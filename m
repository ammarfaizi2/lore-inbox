Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWDUAAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWDUAAP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWDUAAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:00:15 -0400
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:38728 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932155AbWDUAAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:00:14 -0400
Message-ID: <4448208B.7020000@bigpond.net.au>
Date: Fri, 21 Apr 2006 10:00:11 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: akpm@osdl.org, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] smpnice: don't consider sched groups which are lightly
 loaded for balancing
References: <20060328185202.A1135@unix-os.sc.intel.com> <442A0235.1060305@bigpond.net.au> <20060329145242.A11376@unix-os.sc.intel.com> <442B1AE8.5030005@bigpond.net.au> <20060329165052.C11376@unix-os.sc.intel.com> <442B3111.5030808@bigpond.net.au> <20060401204824.A8662@unix-os.sc.intel.com> <442F7871.4030405@bigpond.net.au> <20060419182444.A5081@unix-os.sc.intel.com> <444719F8.2050602@bigpond.net.au> <20060420100457.B10267@unix-os.sc.intel.com>
In-Reply-To: <20060420100457.B10267@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 21 Apr 2006 00:00:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Thu, Apr 20, 2006 at 03:19:52PM +1000, Peter Williams wrote:
>>> This patch doesn't fix this issue for example:
>>> 4-way simple MP system. P0 containing two high priority tasks, P1 containing
>>> one high priority and two normal priority tasks, one high priotity task
>>> each on P2, P3. Current load balance doesn't detect/fix the
>>> imbalance by moving one of the normal priority task running on P1 to P2 or P3.
>> Is this always the case or just a possibility?  Please describe the hole 
>> it slips through (and please do that every time you provide a scenario).
> 
> I thought a scenario is enough to show the hole :) Anyhow, I brought this 
> issue before also..
> http://www.ussg.iu.edu/hypermail/linux/kernel/0604.0/0517.html
> 
> Load balance on P2 or P3 will always show P0 as max load but it will not
> be able to move any load from P0. As
> imbalance will be always < busiest_load_per_task and
> max_load - this_load will be < imbn(2) * busiest_load_per_task...
> and pwr_move will be <= pwr_now...

This will depend on how high the priority of the high priority tasks are 
relative to normal tasks.  E.g. it's quite possible to have two high 
priority tasks whose combined load weight is less than that of two 
normal tasks and a high priority task.

> 
> Basically sched groups with highest priority tasks can mask the 
> imbalance between the other sched groups with in the same domain. 

Sometimes.

I don't think that this stable state is so bad that anything special 
needs to be done especially as the fact that high priority tasks tend to 
only use the CPU in short bursts means that it probably won't exist for 
very long.

To paraphrase Ingo (from another thread), load balancing is a 
probabilistic exercise.  For a start, achieving a deterministic optimal 
distribution would be an NP algorithm and by the time you determined the 
correct distribution (which could be a very long time) the "state" 
information on which the determination was based would have changed 
(possibly a lot).  This latter bit (probably minus the possibly a lot) 
is true anyway as find_busiest_group() and find_busiest_queue() are 
called without locks meaning that the state upon which their results are 
determined may change before move_tasks() is called.

I think this justifies saying that this scenario probably doesn't matter 
and, therefore, fixing it isn't urgent.

BTW I agree with your earlier statements that the modification to 
move_tasks() to circumvent the skip mechanism in some circumstances 
needs to be refined so that it doesn't move the highest priority task of 
the busiest queue.  I'll be submitting a patch later today.

I think that the next thing that needs to be addressed after that is a 
modification to try_to_wake_up() to improve the distribution of high 
priority tasks across CPUs.  I think that just sticking them on any CPU 
and waiting for the load balancing code to kick in and move them 
unnecessarily increases their latency.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
