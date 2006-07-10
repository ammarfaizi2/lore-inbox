Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbWGJPvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbWGJPvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWGJPvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:51:13 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:1186 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964906AbWGJPvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:51:12 -0400
Date: Mon, 10 Jul 2006 08:51:47 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: mingo@elte.hu, oleg@tv-sign.ru, linux-kernel@vger.kernel.org,
       dino@us.ibm.com, tytso@us.ibm.com, dvhltc@us.ibm.com
Subject: Re: [PATCH -rt] catch put_task_struct RCU handling up to mainline
Message-ID: <20060710155147.GB1446@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060707192955.GA2219@us.ibm.com> <Pine.LNX.4.64.0607072352390.12372@localhost.localdomain> <20060707231524.GI1296@us.ibm.com> <Pine.LNX.4.64.0607081450150.11051@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607081450150.11051@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 02:59:37PM +0100, Esben Nielsen wrote:
> On Fri, 7 Jul 2006, Paul E. McKenney wrote:
> 
> >On Fri, Jul 07, 2006 at 11:56:00PM +0100, Esben Nielsen wrote:
> >>On Fri, 7 Jul 2006, Paul E. McKenney wrote:
> >>
> >>>Hello!
> >>>
> >>>Due to the separate -rt and mainline evolution of RCU signal handling,
> >>>the -rt patchset now makes each task struct go through two RCU grace
> >>>periods, with one call_rcu() in release_task() and with another
> >>>in put_task_struct().  Only the call_rcu() in release_task() is
> >>>required, since this is the one that is associated with tearing down
> >>>the task structure.
> >>>
> >>>This patch removes the extra call_rcu() in put_task_struct(), synching
> >>>this up with mainline.  Tested lightly on i386.
> >>>
> >>
> >>The extra call_rcu() has an advantage:
> >>It defers work away from the task doing the last put_task_struct().
> >>It could be a priority 99 task with hard latency requirements doing
> >>some PI boosting, forinstance. The extra call_rcu() defers non-RT work to
> >>a low priority task. This is in generally a very good idea in a real-time
> >>system.
> >>So unless you can argue that the work defered is as small as the work of
> >>doing a call_rcu() I would prefer the extra call_rcu().
> >
> >I would instead argue that the only way that the last put_task_struct()
> >is an unrelated high-priority task is if it manipulating an already-exited
> >task.  In particular, I believe that the sys_exit() path prohibits your
> >example of priority-boosting an already-exited task by removing the
> >exiting task from the various lists before doing the release_task()
> >on itself.
> >
> >Please let me know what I am missing here!
> 
> You could very well be right (I don't know the details that well). But in 
> that case the get/put_task_struct() in the PI code is not needed?
> I think, however, it is needed because the task doing the (de)boosting 
> gets a pointer to a task, enables preemption and drops all locks. It then 
> uses the pointer. The task could have been deleted a long time ago if it 
> wasn't used protected by get/put_task_struct().
> 
> This is an examble of why using reference counting in a RT system is a bad 
> idea: Suddenly a highpriority task can end up doing the cleanup for low 
> priority tasks.

My belief is that the scenarios that lead to this situation involve error
situations -- in which case the dying task will be missing whatever
deadlines it had anyway, because it died before it could complete
its work.  So, I agree that we need the get/put_task_struct() calls,
but I believe that their job is to keep the system running in face of
application errors.  Otherwise, it would be really hard to debug the
application, right?

That said, it is entirely possible that I am missing a code path where
a correctly written application could legitimately force a high-priority
task to do cleanup work on behalf of a low-priority path.

> The work should be defered to a low priority task. Using rcu is 
> probably overkill because it also introduces other delays. A tasklet 
> or a dedicated task would be better.

Agreed -- if there is in fact a legitimate non-error code path, then
a patch that used some deferral mechanism would be good.  But RCU is
overkill, and misleading overkill at that!

							Thanx, Paul
