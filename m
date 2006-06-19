Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWFSDho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWFSDho (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 23:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbWFSDho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 23:37:44 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:26057 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750717AbWFSDhn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 23:37:43 -0400
Message-ID: <44961A77.800@in.ibm.com>
Date: Mon, 19 Jun 2006 09:01:03 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Peter Williams <peterw@aurema.com>, Andrew Morton <akpm@osdl.org>,
       dev@openvz.org, vatsa@in.ibm.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, bsingharora@gmail.com, efault@gmx.de,
       kernel@kolivas.org, sam@vilain.net, kingsley@aurema.com, mingo@elte.hu,
       rene.herman@keyaccess.nl
Subject: Re: [ckrm-tech] [PATCH 0/4] sched: Add CPU rate caps
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest>	<20060618025046.77b0cecf.akpm@osdl.org>	<449529FE.1040008@bigpond.net.au>	<4495EC40.70301@in.ibm.com> <4495F7FE.9030601@aurema.com> <449609E4.1030908@in.ibm.com> <44961758.6070305@bigpond.net.au>
In-Reply-To: <44961758.6070305@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Balbir Singh wrote:
> 
>> Peter Williams wrote:
>>

<snip>

>> Is it possible that the effective tasks
>> is greater than the limit of the group?
> 
> 
> Yes.
> 
>> How do we handle this scenario?
> 
> 
> You've got the problem back to front.  If the number of effective tasks 
> is less than the group limit then you have the situation that needs 
> special handling (not the other way around).  I.e. if the number of 
> effective tasks is less than the group limit then (strictly speaking) 
> there's no need to do any capping at all as the demand is less than the 
> limit.  However, in the case where the group limit is less than one CPU 
> (i.e. less than 1000) the recommended thing to do would be set the limit 
> of each task in the group to the group limit.
> 
> Obviously, group limits can be greater than one CPU (i.e. 1000).
> 
> The number of CPUs on the system also needs to be taken into account for 
> group capping as if the group cap is greater than the number of CPUs 
> there's no way it can be exceeded and tasks in this group would not need 
> any processing.
>

What if we have a group limit of 100 (out of 1000) and 150 effective tasks in
the group? How do you calculate the cap of each task?
I hope my understanding of effective tasks is correct.

<snip>
 
>>>
>>> I should have elaborated here that (conceptually) modifying this code 
>>> to apply caps to groups of tasks instead of individual tasks is 
>>> simple.  It mainly involves moving most the data (statistics plus cap 
>>> values) to a group structure and then modifying the code to update 
>>> statistics for the group instead of the task and then make the 
>>> decisions about whether a task should have a cap enforced (i.e. moved 
>>> to one of the soft cap priorities or sin binned) based on the group 
>>> statistics.
>>>
>>> However, maintaining and accessing the group statistics will require 
>>> additional locking as the run queue lock will no longer be able to 
>>> protect the data as not all tasks in the group will be associated 
>>> with the same CPU.  Care will be needed to ensure that this new 
>>> locking doesn't lead to dead locks with the run queue locks.
>>>
>>> In addition to the extra overhead caused by these locking 
>>> requirements, the code for gathering the statistics will need to be 
>>> more complex also adding to the overhead.  There is also the issue of 
>>> increased serialization (there is already some due to load balancing) 
>>> of task scheduling to be considered although, to be fair, this 
>>> increased serialization will be within groups.
>>>
>>>
>>
>> The f-series CPU controller does all of what you say in 403 lines 
>> (including
>> comments and copyright). I think the biggest advantage of maintaining the
>> group statistics in the kernel is that certain scheduling decisions 
>> can be
>> made based on group statistics rather than task statistics, which 
>> makes the
>> mechanism independent of the number of tasks in the group (isolates the
>> groups from changes in number of tasks).
> 
> 
> Yes, that's one of its advantages.  Both methods have advantages and 
> disadvantages.
> 
> Peter


-- 
	Cheers,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
