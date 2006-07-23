Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWGWP6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWGWP6g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 11:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWGWP6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 11:58:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:27261 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751240AbWGWP6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 11:58:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=Hn6tzqXbx6DFsK+IjCyiXYG5brUSXiq5z7/oSsxJvLomGHRsfAlgeLq4tvkDy0MnU7uwjy4WsrQP58dTGERv/60tkX8gO4RslTvKpPhwAdls/ZREDriYxSEJib2gzEPUZKmZ4DCziXTYMeagqcVOE9RafQvrLy8+tVBg+gItySE=
Date: Sun, 23 Jul 2006 17:58:49 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Steven Rostedt <rostedt@goodmis.org>
cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] [-rt] Fixes the timeout-bug in the rtmutex/PI-futex.
In-Reply-To: <1153666661.4002.4.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607231756070.9903@localhost.localdomain>
References: <20060723005210.973833000@localhost> 
 <Pine.LNX.4.64.0607230217390.11861@localhost.localdomain>
 <1153666661.4002.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Jul 2006, Steven Rostedt wrote:

> On Sun, 2006-07-23 at 02:18 +0100, Esben Nielsen wrote:
>> This patch fixes
>>
>> 1) The timeout bug in rtmutexes and PI futexes: When a task is blocked on a
>> lock with timeout and times out it will not wakeup until the owner of the lock
>> is done. This is because the owner is boosted to the same priority as the
>> blocked task and therefore has the CPU such the blocked task never gets around
>> to de-boost it!
>>
>> 2) setscheduler() now does the PI walking - but defers the work to the blocked
>> task.
>>
>> 3) In general it makes sure that a task, which is boosting another has enough
>> priority to do the de-boosting no matter how complicated the lock structure is,
>> or how many times the priorities have changed.
>>
>> The idea behind the patch is simple:
>> If a task is boosting another it is scheduled in LIFO order and it will never
>> loose it's priority. This property lasts until it has left the lock operation
>> (successfully or not).
>>
>> The needed priority to do the unboosting is stored in task->boosting_prio.
>> In the current patch this is always increasing (numerically decreasing) while
>> trying to take a lock. In a future it might be found safe to decrease
>> boosting_prio before finally leaving the lock operation.
>>
>>   include/linux/rtmutex.h                               |    1
>>   include/linux/sched.h                                 |    7
>>   kernel/fork.c                                         |    1
>>   kernel/rtmutex.c                                      |  151 +++++++++++++-----
>
> It is possible that these changes can break the pi code in rtmutex.c.

Hmm, I am quite confident this one doesn't :-) It is tested against my own
user-space unit tester and against Thomas's in-kernel rt-tester. And my 
stress PriorityInheritanceTest by the way.

> I
> haven't analyzed it enough yet.  But just so that you know that your
> changes don't break the code, and to make it easier for me to look at
> it. Please update Documentation/rt-mutex-design.txt including your
> changes.  This will be a good exercise to see if it doesn't really break
> anything, and it will give other reviewers a better starting point for
> review.

Is that up-to-date in the -rt tree? The last patch you sent was to 
2.6.18-rc2, right?

Esben

>
>>   kernel/rtmutex_common.h                               |    1
>>   kernel/sched.c                                        |   14 +
>>   scripts/rt-tester/t5-l4-pi-boost-deboost-setsched.tst |   42 +++--
>>   scripts/rt-tester/t5-l4-pi-boost-deboost.tst          |   12 -
>>   8 files changed, 167 insertions(+), 62 deletions(-)
>
> -- Steve
>
>
