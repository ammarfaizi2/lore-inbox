Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbVHEXXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbVHEXXT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 19:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVHEXXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 19:23:19 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:1251 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262041AbVHEXXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 19:23:18 -0400
Message-ID: <42F3F669.2080101@us.ibm.com>
Date: Fri, 05 Aug 2005 16:29:45 -0700
From: Darren Hart <dvhltc@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050727)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "lkml, " <linux-kernel@vger.kernel.org>
CC: "Piggin, Nick" <piggin@cyberone.com.au>,
       "Bligh, Martin" <mjbligh@us.ibm.com>,
       "Dobson, Matt" <colpatch@us.ibm.com>
Subject: sched_domains SD_BALANCE_FORK and sched_balance_self
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First off, apologies for not reviewing this code at 2.6.12-mm2, I was 
tied up with other things.  I have some concerns as to the intent vs. 
actual implementation of SD_BALANCE_FORK and the sched_balance_fork() 
routine.

ARCHS=i386,x86_64,ia64

First, iirc SD_NODE_INIT initializes the sched_domain that contains all 
the cpus in the system in node groups (with the exception of ia64 and 
the allnodes domain).  Correct?

SD_NODE_INIT for $ARCHS contains SD_BALANCE_FORK, and no other SD_*_INIT 
routines do.  This seems strange to me as it would seem more appropriate 
to balance within a node on fork as to not have to access the duplicated 
mm across nodes.  If we are going to use SD_BALANCE_FORK, wouldn't it 
make sense to push it down the sched_domain hierarchy to the SD_CPU_INIT 
level?

And now to sched_balance_self().  As I understand it the purpose of this 
method is to choose the "best" cpu to start a task on.  It seems to me 
that the best CPU for a forked process would be an idle CPU on the same 
node as the parent in order to stay close to it's memory.  Failing this, 
  we may need to move to other nodes if they are idle enough to warrant 
the move across node boundaries.  Thoughts?

For the comments below, flag = SD_BALANCE_FORK.

static int sched_balance_self(int cpu, int flag)
{
         struct task_struct *t = current;
         struct sched_domain *tmp, *sd = NULL;

         for_each_domain(cpu, tmp)
                 if (tmp->flags & flag)
                         sd = tmp;

This jumps to the highest level domain that supports SD_BALANCE_FORK 
which are the domains created with SD_NODE_INIT, so we look at all the 
CPUs on the system first rather than those local to the parent's node.



         while (sd) {
                 cpumask_t span;
                 struct sched_group *group;
                 int new_cpu;
                 int weight;

                 span = sd->span;
                 group = find_idlest_group(sd, t, cpu);
                 if (!group)
                         goto nextlevel;

                 new_cpu = find_idlest_cpu(group, cpu);
                 if (new_cpu == -1 || new_cpu == cpu)
                         goto nextlevel;

                 /* Now try balancing at a lower domain level */
                 cpu = new_cpu;
nextlevel:
                 sd = NULL;
                 weight = cpus_weight(span);
                 for_each_domain(cpu, tmp) {
                         if (weight <= cpus_weight(tmp->span))
                                 break;
                         if (tmp->flags & flag)
                                 sd = tmp;
                 }

If I am reading it right, this for_each_domain will exit immediately if 
jumped to via nextlevel and will only do any work if a new cpu is found 
to run on (which is fair sense there is no need to keep looking if the 
whole system doesn't have a better place for us to go).  If a new cpu 
_is_ assigned though, for_each_domain will start with the lowest level 
domain - which always has the smallest cpus_weight doesn't it?  If so, 
won't the (weight <= cpu...) condition always equate to true, ending the 
loop at the first domain?  If so, then that last loop doesn't do 
anything at all, ever.  If I am misreading this fragment, could someone 
please correct my thinking?


                 /* while loop will break here if sd == NULL */
         }

         return cpu;
}


So it seems to me that we should first look at the cpus on the local 
domain for SD_BALANCE_FORK.  SD_BALANCE_EXEC tasks however have a 
minimal mm and could probably be put on whichever cpu/group is the most 
idle, regardless of node.  Thoughts?


Thanks,


-- 
Darren Hart
IBM Linux Technology Center
Linux Kernel Team
Phone: 503 578 3185
   T/L: 775 3185
