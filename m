Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVCXXGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVCXXGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 18:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVCXXGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 18:06:00 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:6281 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S261218AbVCXXFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 18:05:46 -0500
Date: Fri, 25 Mar 2005 00:05:31 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
In-Reply-To: <20050324113912.GA20911@elte.hu>
Message-Id: <Pine.OSF.4.05.10503242307330.25274-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005, Ingo Molnar wrote:

> 
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Here we have more unnecessary schedules.  So the condition to grab a 
> > lock should be:
> > 
> > 1. not owned.
> > 2. partially owned, and the owner is not RT.
> > 3. partially owned but the owner is RT and so is the grabber, and the
> >     grabber's priority is >= the owner's priority.
> 
> there's another approach that could solve this problem: let the 
> scheduler sort it all out. Esben Nielsen had this suggestion a couple of 
> months ago - i didnt follow it because i thought that technique would 
> create too many runnable tasks, but maybe that was a mistake. If we do 
> the owning of the lock once the wakee hits the CPU we avoid the 'partial 
> owner' problem, and we have the scheduler sort out priorities and 
> policies.
> 
> but i think i like the 'partial owner' (or rather 'owner pending') 
> technique a bit better, because it controls concurrency explicitly, and 
> it would thus e.g. allow another trick: when a new owner 'steals' a lock 
> from another in-flight task, then we could 'unwakeup' that in-flight 
> thread which could thus avoid two more context-switches on e.g. SMP 
> systems: hitting the CPU and immediately blocking on the lock. (But this 
> is a second-phase optimization which needs some core scheduler magic as 
> well, i guess i'll be the one to code it up.)
> 

I checked the implementation of a mutex I send in last fall. The unlock
operation does give ownership explicitly to the highest priority waiter,
as Ingo's implementation does.

Originally I planned for just having unlock to wake up the highest
priority owner and set lock->owner = NULL. The lock operation would be
something like
 while(lock->owner!=NULL)
   {
      schedule();
   } 
 grap the lock.

Then the first task, i.e. the one with highest priority on UP, will get it
first. On SMP a low priority task on another CPU might get in and take it.

I like the idea of having the scheduler take care of it - it is a very
optimal coded queue-system after all. That will work on UP but not on SMP.
Having the unlock operation to set the mutex in a "partially owned" state
will work better. The only problem I see, relative to Ingo's
implementation, is that then the awoken task have to go in and
change the state of the mutex, i.e. it has to lock the wait_lock again.
Will the extra schedulings being the problem happen offen enough in
practise to have the extra overhead?


> 	Ingo

Esben

