Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWDLQ5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWDLQ5G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 12:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWDLQ5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 12:57:05 -0400
Received: from mga06.intel.com ([134.134.136.21]:14990 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932207AbWDLQ5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 12:57:04 -0400
X-IronPort-AV: i="4.04,115,1144047600"; 
   d="scan'208"; a="22441238:sNHT38946334"
X-IronPort-AV: i="4.04,115,1144047600"; 
   d="scan'208"; a="22441233:sNHT35562597"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,115,1144047600"; 
   d="scan'208"; a="22372522:sNHT57384544"
Date: Wed, 12 Apr 2006 09:55:34 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: move enough load to balance average load per task
Message-ID: <20060412095534.A7293@unix-os.sc.intel.com>
References: <4439FF0C.8030407@bigpond.net.au> <20060410181237.A26977@unix-os.sc.intel.com> <443C3FD8.2060906@bigpond.net.au> <20060411185709.A2401@unix-os.sc.intel.com> <443C8AEC.9010309@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <443C8AEC.9010309@bigpond.net.au>; from pwil3058@bigpond.net.au on Wed, Apr 12, 2006 at 03:06:52PM +1000
X-OriginalArrivalTime: 12 Apr 2006 16:57:02.0604 (UTC) FILETIME=[1EF06CC0:01C65E52]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2006 at 03:06:52PM +1000, Peter Williams wrote:
> Siddha, Suresh B wrote:
> > Is there an example for this?
> 
> Yes, we just take a slight variation of your scenario that prompted the 
> first patch (to which this patch is a minor modification) by adding one 
> normal priority task to each of the CPUs.  This gives us a 2 CPU system 
> with CPU-0 having 2 high priority tasks plus 1 normal priority task and 
> CPU-1 having two normal priority tasks.  Clearly, the desirable load 
> balancing outcome would be for the two high priority tasks to be on 
> different CPUs otherwise we have a high priority task stuck on a run 
> queue while a normal priority is running on another (less heavily 
> loaded) CPU.
> 
> In order to analyze what happens during load balancing, let's use W as 
> the load weight for a normal task and suppose that the load weights of 
> the two high priority tasks are (W + k) and that "this" == CPU-1 in 
> find_busiest_queue().  This will result in "busiest" == CPU-0 and:
> 
> this_load = 2W
> this_load_per_task = W
> max_load = 3W + 2k
> busiest_load_per_task = W + 2k / 3
> avg_load = 5W / 2 + k
> max_pull = W / 2 + k
> *imbalance = W / 2 + k
> 
> Whenever k < (3W / 2) this will result in *imbalance < 
> busiest_load_per_task and we end up in the small imbalance code.
> 
> (max_load - this_load) = W + 2k which is greater than 
> busiest_load_per_task so we decide that we want to move some load from 
> "busiest" to "this".
> 
> Without this patch we would set *imbalance to busiest_load_per_task and 
> the only task on "busiest" that has a weighted load less than or equal 
> to this value is the normal task so this is the one that will be moved 
> resulting:
> 
> this_load = 3W
> this_load_per_task = W
> max_load = 2W + 2k
> busiest_load_per_task = W + k
> 
> Even if you reverse the roles of "busiest" and "this", this will be 
> considered balanced and the system will stabilize in this undesirable 
> state.  NB, as predicted, the average load per task on "this" hasn't 
> changed and the average load per task on "busiest" has increased.  We 
> still have the situation where a high priority task is stuck on a run 
> queue while a low priority task is running on another CPU -- we've 
> failed :-(.

for such a 'k' value, we fail anyhow. For example, how does the normal
load balance detect an imbalance in this below situation?

this_load = 3W
this_load_per_task = W
max_load = 2W + 2k
busiest_load_per_task = W + k

if we really want to distribute 'N' higher priority tasks(however small or
big is the priority difference between low and high priority tasks) on to 
'N' different cpus, we will need really different approach for load 
balancing..

thanks,
suresh

> 
> With this patch, *imbalance will be set to (W + 4k / 3) which is bigger 
> than the weighted load of the high priority tasks so one of them will be 
> moved resulting in:
> 
> this_load = 3W + k
> this_load_per_task = W + k / 3
> max_load = 2W + k
> busiest_load_per_task = W + k / 2
> 
> > 
> >> and whether this_load_per_task will get bigger is 
> >> indeterminate.  With this patch there IS a chance that 
> >> busiest_load_per_task will decrease and an INCREASED chance that 
> >> this_load_per_task will get bigger.  Ergo we have increased the 
> >> probability that the (absolute) difference between this_load_per_task 
> >> and busiest_load_per_task will decrease.  This is a desirable outcome.
> > 
> > All I am saying is we are more aggressive.. I don't have any issue with
> > the desired outcome..
> 
> We need to be more aggressive but not too aggressive and I think this 
> patch achieves the required balance.
> 
> NB busiest_load_per_task < *imbalance < (max_load - this_load) is true 
> for this path through the code.  To be precise, *imbalance will be half 
> way between busiest_load_per_task and (max_load - this_load).
> 
> Peter
> -- 
> Peter Williams                                   pwil3058@bigpond.net.au
> 
> "Learning, n. The kind of ignorance distinguishing the studious."
>   -- Ambrose Bierce
