Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbVHIWDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbVHIWDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 18:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbVHIWDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 18:03:42 -0400
Received: from fmr23.intel.com ([143.183.121.15]:38363 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S964994AbVHIWDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 18:03:41 -0400
Date: Tue, 9 Aug 2005 15:03:32 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: "lkml, " <linux-kernel@vger.kernel.org>,
       "Piggin, Nick" <piggin@cyberone.com.au>,
       "Bligh, Martin" <mjbligh@us.ibm.com>,
       "Dobson, Matt" <colpatch@us.ibm.com>, nickpiggin@yahoo.com.au,
       mingo@elte.hu
Subject: Re: sched_domains SD_BALANCE_FORK and sched_balance_self
Message-ID: <20050809150331.A1938@unix-os.sc.intel.com>
References: <42F3F669.2080101@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42F3F669.2080101@us.ibm.com>; from dvhltc@us.ibm.com on Fri, Aug 05, 2005 at 04:29:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 04:29:45PM -0700, Darren Hart wrote:
> I have some concerns as to the intent vs.  actual implementation of 
> SD_BALANCE_FORK and the sched_balance_fork() routine.

Intent and implementation match. Problem is with the intent ;-)

This has the intent info.

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=147cbb4bbe991452698f0772d8292f22825710ba

To solve these issues, we need to make the sched domain and its parameters
CMP aware. And dynamically we need to adjust these parameters based
on the system properties.

> SD_NODE_INIT for $ARCHS contains SD_BALANCE_FORK, and no other SD_*_INIT 
> routines do.  This seems strange to me as it would seem more appropriate 
> to balance within a node on fork as to not have to access the duplicated 
> mm across nodes.  If we are going to use SD_BALANCE_FORK, wouldn't it 
> make sense to push it down the sched_domain hierarchy to the SD_CPU_INIT 
> level?

Ideally SD_BALANCE_FORK needs to be set for the domains starting from the
lowest domain to the SMP domain.

> It seems to me that the best CPU for a forked process would be an idle 
> CPU on the same  node as the parent in order to stay close to it's memory.  
> Failing this, we may need to move to other nodes if they are idle enough 
> to warrant the move across node boundaries.  Thoughts?

We can choose the leastly loaded CPU in the home node and we can let the
load balance to move it to other nodes if there is an imbalance.

For exec, we can have the SD_BALANCE_EXEC for all the sched domains, which
is the case today.

>          while (sd) {
>                  cpumask_t span;
>                  struct sched_group *group;
>                  int new_cpu;
>                  int weight;
> 
>                  span = sd->span;
>                  group = find_idlest_group(sd, t, cpu);
>                  if (!group)
>                          goto nextlevel;
> 
>                  new_cpu = find_idlest_cpu(group, cpu);
>                  if (new_cpu == -1 || new_cpu == cpu)
>                          goto nextlevel;
> 
>                  /* Now try balancing at a lower domain level */
>                  cpu = new_cpu;
> nextlevel:
>                  sd = NULL;
>                  weight = cpus_weight(span);
>                  for_each_domain(cpu, tmp) {
>                          if (weight <= cpus_weight(tmp->span))
>                                  break;
>                          if (tmp->flags & flag)
>                                  sd = tmp;
>                  }
> 
> If I am reading it right, this for_each_domain will exit immediately if 
> jumped to via nextlevel and will only do any work if a new cpu is found 
> to run on (which is fair sense there is no need to keep looking if the 
> whole system doesn't have a better place for us to go).  If a new cpu 
> _is_ assigned though, for_each_domain will start with the lowest level 
> domain - which always has the smallest cpus_weight doesn't it?  If so, 
> won't the (weight <= cpu...) condition always equate to true, ending the 

no. last loop will take you to the domain which has the flag and is 
immd below the parent domain from where we started.

thanks,
suresh
