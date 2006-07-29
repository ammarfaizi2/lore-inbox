Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWG2We1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWG2We1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 18:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWG2We1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 18:34:27 -0400
Received: from mta5.srv.hcvlny.cv.net ([167.206.4.200]:15062 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750730AbWG2We1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 18:34:27 -0400
Date: Sat, 29 Jul 2006 18:34:21 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: 2.6.18-rc2-mm1
In-reply-to: <1154119190.21787.2528.camel@stark>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Balbir Singh <balbir@in.ibm.com>
Message-id: <44CBE26D.5090901@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <20060727015639.9c89db57.akpm@osdl.org>
 <6bffcb0e0607270632i2ae56e21k40fb12c712980de0@mail.gmail.com>
 <6bffcb0e0607280117k68184559t531b737815b2c6e9@mail.gmail.com>
 <20060728013442.6fabae54.akpm@osdl.org> <1154112567.21787.2522.camel@stark>
 <6bffcb0e0607281253j28e04ba2icec85589e9390b3e@mail.gmail.com>
 <1154119190.21787.2528.camel@stark>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley wrote:
> On Fri, 2006-07-28 at 21:53 +0200, Michal Piotrowski wrote:
> 
>>On 28/07/06, Matt Helsley <matthltc@us.ibm.com> wrote:
>>
>>>On Fri, 2006-07-28 at 01:34 -0700, Andrew Morton wrote:
>>>
>>>>On Fri, 28 Jul 2006 10:17:44 +0200
>>>>"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
>>>>
>>>>
>>>>>Matt, can you look at this?
>>>>>
>>>>>My hunt file shows me, that this patches are causing oops.
>>>>>GOOD
>>>>>#
>>>>>#
>>>>>task-watchers-task-watchers.patch
>>>>>task-watchers-register-process-events-task-watcher.patch
>>>>>task-watchers-refactor-process-events.patch
>>>>>task-watchers-make-process-events-configurable-as.patch
>>>>>task-watchers-allow-task-watchers-to-block.patch
>>>>>task-watchers-register-audit-task-watcher.patch
>>>>>task-watchers-register-per-task-delay-accounting.patch
>>>>>task-watchers-register-profile-as-a-task-watcher.patch
>>>>>task-watchers-add-support-for-per-task-watchers.patch
>>>>>task-watchers-register-semundo-task-watcher.patch
>>>>>task-watchers-register-per-task-semundo-watcher.patch
>>>>>BAD
>>>>
>>>>Thanks for working that out.
>>>
>>>        I noticed the delay accounting functions in the stack trace. Perhaps
>>>task-watchers-register-per-task-delay-accounting.patch is causing the
>>>problem.
>>
>>Confirmed.
> 
> 
> Excellent, thanks for the rapid confirmation. I'll work with Shailabh
> and Balbir to fix this. In the meantime perhaps
> task-watchers-register-per-task-delay-accounting.patch should be dropped
> from -mm.
> 
> Cheers,
> 	-Matt Helsley
> 


The error is almost certainly because delayacct_tsk_init is being
called at WATCH_TASK_CLONE (which is triggered after the task has been
added to the tasklist) rather than WATCH_INIT (before).

__delayacct_tsk_init, which gets notified by WATCH_TASK_* initializes
the spinlock tsk->delays_lock which could get used as soon as task is
present in tasklist. The lockup is very likely due to use of this
uninitialized spinlock.

So the fix should be to change WATCH_TASK_CLONE to WATCH_TASK_INIT
in the delayacct_watch_task function created by this patch.

--Shailabh



