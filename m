Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVEEOxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVEEOxK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 10:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVEEOxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 10:53:10 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:14500 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262122AbVEEOwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 10:52:53 -0400
Message-ID: <427A3340.1020305@yahoo.com.au>
Date: Fri, 06 May 2005 00:52:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: mingo@elte.hu, george@mvista.com,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: VST and Sched Load Balance
References: <20050407124629.GA17268@in.ibm.com> <425530AB.90605@yahoo.com.au> <20050505143958.GA20162@in.ibm.com>
In-Reply-To: <20050505143958.GA20162@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Thu, Apr 07, 2005 at 11:07:55PM +1000, Nick Piggin wrote:

>>I think we do care, yes. It could be pretty harmful to sleep for
>>even a few 10s of ms on a regular basis for some workloads. Although
>>I guess many of those will be covered by try_to_wake_up events...
>>
>>Not sure in practice, I would imagine it will hurt some multiprocessor
>>workloads.
> 
> 
> I am looking at the recent changes in load balance and I see that load
> balance on fork has been introduced (SD_BALANCE_FORK). I think this changes
> the whole scenario.
> 
> Considering the fact that there was already balance on wake_up and the 
> fact that the scheduler checks for imbalance before running the idle task
> (load_balance_newidle), I don't know if sleeping idle CPUs can cause a 
> load imbalance (fork/wakeup happening on other CPUs will probably push
> tasks to it and wake it up anyway? exits can change the balance, but probably
> is not relevant here?)
> 

Well, there are a lot of ifs and buts. Some domains won't implement
fork balancing, others won't do newidle balancing, wake balancing,
wake to idle, etc etc.

I think my idea of allowing max_interval to be extended to a
sufficiently large value if one CPU goes idle, and shutting off all
CPU's rebalancing completely if no tasks are running for some time
should cater to both hypervisor images and power saving concerns.
While not being very intrusive to normal operation of the scheduler.

> Except for a small fact: if the CPU sleeps w/o taking rebalance_ticks,
> its cpu_load[] can become incorrect over a period.
> 
> I noticed that load_balance_newidle uses newidle_idx to gauge the current cpu's 
> load. As a result, it can see non-zero load for the idle cpu. Because of this 
> it can decide to not pull tasks.  
> 
> The rationale here (of using non-zero load): is it to try and let the
> cpu become idle? Somehow, this doesn't make sense, because in the very next 
> rebalance_tick (assuming that the idle cpu does not sleep), it will start using 
> the idle_idx, which will cause the load to show up as zero and can cause the 
> idle CPU to pull some tasks.
> 
> Have I missed something here?
> 

No. I think tou are right in that we'll want to make sure cpu_load is
zero before cutting the timer tick.

> Anyway, if the idle cpu were to sleep instead, the next rebalance_tick will 
> not happen and it will not pull the tasks to restore load balance.
> 
> If my above understanding is correct, I see two potential solutions for this:
> 
> 
> 	A. Have load_balance_newidle use zero load for current cpu while
> 	  checking for busiest cpu.
> 	B. Or, if we want to retain load_balance_newidle the way it is, have 
> 	  the idle thread call back scheduler to zero the load and retry
> 	  load balance, _when_ it decides that it wants to sleep (there
> 	  are conditions under which a idle cpu may not want to sleep. for ex:
> 	  the next timer is only a tick, 1ms, away).
> 
> In either case, if the load balance still fails to pull any tasks, then it means
> there is really no imbalance. Tasks that will be added into the system later 
> (fork/wake_up) will be balanced across the CPUs because of the load-balance 
> code that runs during those events.
> 
> A possible patch for B follows below:
> 

Yeah something like that should do it.

-- 
SUSE Labs, Novell Inc.

