Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVCZQEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVCZQEj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 11:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVCZQEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 11:04:38 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:53142 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261157AbVCZQEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 11:04:35 -0500
Date: Sat, 26 Mar 2005 11:04:24 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Esben Nielsen <simlo@phys.au.dk>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
In-Reply-To: <Pine.OSF.4.05.10503242307330.25274-100000@da410.phys.au.dk>
Message-ID: <Pine.LNX.4.58.0503261047190.27746@localhost.localdomain>
References: <Pine.OSF.4.05.10503242307330.25274-100000@da410.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Mar 2005, Esben Nielsen wrote:
> >
>
> I checked the implementation of a mutex I send in last fall. The unlock
> operation does give ownership explicitly to the highest priority waiter,
> as Ingo's implementation does.
>
> Originally I planned for just having unlock to wake up the highest
> priority owner and set lock->owner = NULL. The lock operation would be
> something like
>  while(lock->owner!=NULL)
>    {
>       schedule();
>    }
>  grap the lock.
>
> Then the first task, i.e. the one with highest priority on UP, will get it
> first. On SMP a low priority task on another CPU might get in and take it.

This could be dangerous on SMP then, because, if a higher priority process
on the CPU of the process that grabbed the lock, preempted it, then the
other CPU can spin on this since it would be the highest priority process
for that CPU.  Not to mention that you have to make sure that priority
inheritance was still implemented for the higher priority process woken up
but having it stollen by the lower priority process.


>
> I like the idea of having the scheduler take care of it - it is a very
> optimal coded queue-system after all. That will work on UP but not on SMP.
> Having the unlock operation to set the mutex in a "partially owned" state
> will work better. The only problem I see, relative to Ingo's
> implementation, is that then the awoken task have to go in and
> change the state of the mutex, i.e. it has to lock the wait_lock again.
> Will the extra schedulings being the problem happen offen enough in
> practise to have the extra overhead?

Another answer is to have the "pending owner" bit be part of the task
structure. A flag maybe.  If a higher priority process comes in and
decides to grab the lock from this owner, it does a test_and_clear on the
this flag on the pending owner task.  When the pending owner task wakes
up, it does the test_and_clear on its own bit.  Who ever had the bit set
on the test wins. If the higher prio task were to clear it first, then it
takes the ownership away from the pending owner.  If the pending owner
were to clear the bit first, it won and would contiue as though it got the
lock.  The higher priority tasks would do this test within the wait_lock
to keep from having more than one trying to grab the lock from the pending
owner, but the pending owner won't need to do anything since it will know
if it was the new owner just by testing its own bit.

-- Steve

