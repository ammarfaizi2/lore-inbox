Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWGHM7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWGHM7g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 08:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWGHM7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 08:59:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:11027 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964801AbWGHM7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 08:59:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=nUohdDfBYOI4DyeBTRQIs2+u85gIQkN4+kNj8nXcw7JVV3yR9P9O4fXpmyMgqWh3CZoJdr+6S+WgRzPzsnOWRiHO4nchapgraXRro/gL6Niu/cvcAB8ZBONdx/kApv/caVctTmpklLb4vRQiIGREmMCBgLILTyOfwFTWZ4wr3aU=
Date: Sat, 8 Jul 2006 14:59:37 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Esben Nielsen <nielsen.esben@googlemail.com>, mingo@elte.hu,
       oleg@tv-sign.ru, linux-kernel@vger.kernel.org, dino@us.ibm.com,
       tytso@us.ibm.com, dvhltc@us.ibm.com
Subject: Re: [PATCH -rt] catch put_task_struct RCU handling up to mainline
In-Reply-To: <20060707231524.GI1296@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0607081450150.11051@localhost.localdomain>
References: <20060707192955.GA2219@us.ibm.com>
 <Pine.LNX.4.64.0607072352390.12372@localhost.localdomain>
 <20060707231524.GI1296@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006, Paul E. McKenney wrote:

> On Fri, Jul 07, 2006 at 11:56:00PM +0100, Esben Nielsen wrote:
>> On Fri, 7 Jul 2006, Paul E. McKenney wrote:
>>
>>> Hello!
>>>
>>> Due to the separate -rt and mainline evolution of RCU signal handling,
>>> the -rt patchset now makes each task struct go through two RCU grace
>>> periods, with one call_rcu() in release_task() and with another
>>> in put_task_struct().  Only the call_rcu() in release_task() is
>>> required, since this is the one that is associated with tearing down
>>> the task structure.
>>>
>>> This patch removes the extra call_rcu() in put_task_struct(), synching
>>> this up with mainline.  Tested lightly on i386.
>>>
>>
>> The extra call_rcu() has an advantage:
>> It defers work away from the task doing the last put_task_struct().
>> It could be a priority 99 task with hard latency requirements doing
>> some PI boosting, forinstance. The extra call_rcu() defers non-RT work to
>> a low priority task. This is in generally a very good idea in a real-time
>> system.
>> So unless you can argue that the work defered is as small as the work of
>> doing a call_rcu() I would prefer the extra call_rcu().
>
> I would instead argue that the only way that the last put_task_struct()
> is an unrelated high-priority task is if it manipulating an already-exited
> task.  In particular, I believe that the sys_exit() path prohibits your
> example of priority-boosting an already-exited task by removing the
> exiting task from the various lists before doing the release_task()
> on itself.
>
> Please let me know what I am missing here!

You could very well be right (I don't know the details that well). But in 
that case the get/put_task_struct() in the PI code is not needed?
I think, however, it is needed because the task doing the (de)boosting 
gets a pointer to a task, enables preemption and drops all locks. It then 
uses the pointer. The task could have been deleted a long time ago if it 
wasn't used protected by get/put_task_struct().

This is an examble of why using reference counting in a RT system is a bad 
idea: Suddenly a highpriority task can end up doing the cleanup for low 
priority tasks.

The work should be defered to a low priority task. Using rcu is 
probably overkill because it also introduces other delays. A tasklet 
or a dedicated task would be better.

Esben

>
> 							Thanx, Paul
>
