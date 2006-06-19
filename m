Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWFSAUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWFSAUd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 20:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWFSAUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 20:20:33 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:56766 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750715AbWFSAUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 20:20:32 -0400
Message-ID: <4495EC40.70301@in.ibm.com>
Date: Mon, 19 Jun 2006 05:43:52 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>, kernel@kolivas.org, sam@vilain.net,
       bsingharora@gmail.com, vatsa@in.ibm.com, dev@openvz.org,
       linux-kernel@vger.kernel.org, efault@gmx.de, kingsley@aurema.com,
       ckrm-tech@lists.sourceforge.net, mingo@elte.hu,
       rene.herman@keyaccess.nl
Subject: Re: [PATCH 0/4] sched: Add CPU rate caps
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest> <20060618025046.77b0cecf.akpm@osdl.org> <449529FE.1040008@bigpond.net.au>
In-Reply-To: <449529FE.1040008@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Andrew Morton wrote:
> 
>> On Sun, 18 Jun 2006 18:26:38 +1000
>> Peter Williams <pwil3058@bigpond.net.au> wrote:
>>
>> People are going to want to extend this to capping a *group* of tasks, 
>> with
>> some yet-to-be-determined means of tying those tasks together.  How well
>> suited is this code to that extension?
> 
> 
> Quite good.  It can be used from outside the scheduler to impose caps on 
> arbitrary groups of tasks.  Were the PAGG interface available I could 
> knock up a module to demonstrate this.  When/if the "task watchers" 
> patch is included I will try and implement a higher level mechanism 
> using that.  The general technique is to get an estimate of the 
> "effective number" of tasks in the group (similar to load) and give each 
> task in the group a cap which is the group's cap divided by the 
> effective number of tasks (or the group cap whichever is smaller -- i.e. 
> the effective number of tasks could be less than one).
>)


There is one possible issue with this approach. Lets assume that we desire
a cap of 10 for a set of two tasks. As discussed earlier, each task
would get a limit of 5% if they are equally busy.

Lets call the group as G1 and the tasks as T1 and T2.

If we have another group called G2 with tasks T3, T4 and T5 and a soft
cap of 90. Then each of T3, T4 and T5 would get a soft cap of
30% (assuming that they are equally busy). Now if T5 stops using its limit
for a while let say its cpu utilization is 10% - how do we divide the saved
20% between T1, T2, T3 and T4.

In a group scenario, the balance 20% should be shared between T3 and T4.

Also mathematically

A group is a superset of task

It is hard to implement things for a task and make it work for groups,
but if we had something for groups, we could easily adapt it to tasks
by making each group equal to a task


 
> Doing it inside the scheduler is also doable but would have some locking 
> issues.  The run queue lock could no longer be used to protect the data 
> as there's no guarantee that all the tasks in the group are associated 
> with the same queue.
> 
>>
>> If the task can exceed its cap without impacting any other tasks (ie: 
>> there
>> is spare idle capacity), what happens?
> 
> 
> That's the difference between soft and hard caps.  If it's a soft cap 
> then the task is allowed to exceed it if there's spare capacity.  If 
> it's a hard cap it's not.
> 

By how much is the task allowed to exceed if there is spare capacity?
Will the spare capacity allocation require resetting of caps to implement
the new caps?

>>  I trust that spare capacity gets
>> used?  (Is this termed "work conserving"?)
> 
> 
> Soft caps, yes.  Hard caps, no.
> 

-- 
	Cheers,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
