Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751503AbWCMQHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbWCMQHJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 11:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWCMQHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 11:07:08 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:2011 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S1751503AbWCMQHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 11:07:07 -0500
Date: Mon, 13 Mar 2006 17:06:58 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.16-rc6-rt1
In-Reply-To: <20060313142951.GA6246@elte.hu>
Message-ID: <Pine.LNX.4.44L0.0603131637590.30465-100000@lifa01.phys.au.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2006, Ingo Molnar wrote:

>
> * Esben Nielsen <simlo@phys.au.dk> wrote:
>
> > However, I notice it re-introduces long latencies :-( The problem is
> > that the time need in adjust_prio_chain is proportional to the lock
> > depth and the function is called with two raw spinlocks held. This is
> > no problem when the locks are in the kernel and thus not very deeply
> > nested, but when it is exposed to futexes there is a problem as Joe
> > user can increase the task latency of the system by crafting deep
> > locking structures in userspace.
>
> i dont think that's a problem. For userspace futexes we'll (have to)
> introduce some sensible locking depth anyway.
>
> > I will be on paternity leave soonish. I might get time solve it as I
> > originally suggested some months back when my daughter is asleep. The
> > solution I suggested last fall, includes releasing _all_ locks at each
> > iteration in the loop in adjust_prio_chain such that higher priority
> > tasks gets a chance to run. To avoid having tasks released in the
> > middle get/put_tast_struct() are needed. That will cost extra atomic
> > instructions compared to the present implementation. Are people
> > prepared to pay that price? I am not talking about the scheduler based
> > solution; just doing the PI iteration in a little different (and
> > slightly more epensive) way.
>
> well, we'd have to see the code for that, but i'm afraid this would be
> fundamentally racy. What if another CPU changes one of the data
> structures along the way?

Or a higher priority task change the structures along the way...
The basic loop is:

start of loop (no held spin-locks here):
- You have a task pointer (this_task), which is valid because you have
done get_task_struct() on it.
- You take the this_task->pi_lock.
- Does it need a priority change - if not (and no deadlock detection)
  break
- Change the priority.
- You check blocked_on - if NULL break
- Try lock the mutex's, lock->wait_lock. On failure release
  this->task_pi_lock and goto start of loop.
- Get the owner out: new_owner=->rt_mutex_owner(lock)
- if new_owner==NULL break
- Use get_task_struct(new_owner)
- Release this_task->pi_lock and lock->wait_lock.
- put_task_struct(this_task)
- this_task = new_owner
- goto start of loop.

At break:
unlock this_task->pi_lock;
put_task_struct(this_task)

Notice the above loop has to be taken just before schedule() after
releasing all spin-locks in down() operations with this_task=lock->owner.
The reverse operation is unly needed in down_interrubtible() at signals or timeout. It has
to be defered to after releasing all locks but before fixing the priority of
current if it was boosted.

Notice that while one task is traversing the loop another higher
priority task can lock on the same mutex and do the same boosting the
priorities even higher. That should be no problem. The lower priority task
will just see that the priority of this_task is ok and break out of
the loop.  Similarly if locks are released in the middle.

The extra cost is get/put_task_struct() (which is expensive ??) Maybe RCU
can be used instead?
Saved is the accounting pi_locks taken in adjust_prio_chain.

Esben


>
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

