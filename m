Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWDNS3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWDNS3i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 14:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWDNS3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 14:29:38 -0400
Received: from mga06.intel.com ([134.134.136.21]:5722 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751393AbWDNS3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 14:29:37 -0400
X-IronPort-AV: i="4.04,121,1144047600"; 
   d="scan'208"; a="23340492:sNHT19243938"
X-IronPort-AV: i="4.04,121,1144047600"; 
   d="scan'208"; a="23340485:sNHT26887098"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,121,1144047600"; 
   d="scan'208"; a="24062220:sNHT17649947"
Date: Fri, 14 Apr 2006 11:27:50 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: modify move_tasks() to improve load balancing outcomes
Message-ID: <20060414112750.A21908@unix-os.sc.intel.com>
References: <443DF64B.5060305@bigpond.net.au> <20060413165117.A15723@unix-os.sc.intel.com> <443EFFD2.4080400@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <443EFFD2.4080400@bigpond.net.au>; from pwil3058@bigpond.net.au on Fri, Apr 14, 2006 at 11:50:10AM +1000
X-OriginalArrivalTime: 14 Apr 2006 18:29:35.0342 (UTC) FILETIME=[617480E0:01C65FF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 11:50:10AM +1000, Peter Williams wrote:
> Siddha, Suresh B wrote:
> > On Thu, Apr 13, 2006 at 04:57:15PM +1000, Peter Williams wrote:
> >> Problem:
> >>
> >> The move_tasks() function is designed to move UP TO the amount of load 
> >> it is asked to move and in doing this it skips over tasks looking for 
> >> ones whose load weights are less than or equal to the remaining load to 
> >> be moved.  This is (in general) a good thing but it has the unfortunate 
> >> result of breaking one of the original load balancer's good points: 
> > 
> > with previous load balancer code it was a good point.. because all tasks
> > were weighted the same from load balancer perspective.. but now the
> > imbalance represents what task to move (atleast in the working
> > cases :)
> 
> That's the option 4 case in my original mail.  Are you suggesting that 
> it would have been the better option to adopt?  If so, why?

No. I was not suggesting option-4. With this change in move_tasks, we will 
be overriding the decision what ever we made while calculating imbalance.
Lets see for example, we have a simple DP system. With proc-0 running
one high priority and one low priority task, Proc-1 running one
low priority task. Ideally we would like to move low priority task from
P0 to P1. But with this patch, we may end up moving high priority task
from P0 to P1. But slowly after sometime(depending on high priority task
is on active/expired list), we will converge to the expected
solution..

> > you mean the highest priority task on the current active list of the new 
> > run queue, right?
> 
> Good point.  this_min_prio should probably be initialized to the minimum 
> of this_rq->curr->prio and this_rq->best_expired_prio rather just using 
> this_rq->curr->prio.

yes.

> 
> > 
> > There will be some unnecessary movements of high priority tasks because of
> > this...
> 
> How so.  At most one task per move_tasks() will be moved as a result of 
> this code that wouldn't have been moved otherwise.  That task will be a 
> high priority task stuck behind a higher priority task on its current 
> queue that will be the highest priority on its new queue causing a 
> preempt and access to the CPU.  I wouldn't call this unnecessary.

highest priority task can be in the expired list with normal priority
task running.. as in my above example.

> 
> > Peter, Are you sure that this is a converging solution? If we want to
> 
> Yes, I think we're getting there.
> 
> I think we need changes to try_to_wake_up() to help high priority tasks 
> find idle CPUs or CPUs where they would preempt when they wake up. 
> Leaving this to the load balancer is bad for these tasks latencies.  I 
> think that this change needs to be done independently of smpnice as it 
> would be useful even without smpnice.  I'm hoping Ingo or Nick will 
> comment on this proposal.
> 
> It would also help if you fixed the active load balance code so that 
> it's not necessary to distort normal load balancing to accommodate it. 
> I haven't had time to look at it myself (other than a quick glance) yet.

The only special check in find_busiest_group() helping MT/MC balancing
is pwr_now and pwr_move calculations.. These calculations will also help,
in future when we are dealing with sched groups which are not symmetric.
Asymmetries can be caused in scenarios like cpufreq, cpu logical hotplug..

I think we are unnecessarily behind active load balance...

thanks,
suresh
