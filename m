Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVFASzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVFASzX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVFASwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:52:43 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:22269 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S261494AbVFASGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:06:37 -0400
Date: Wed, 01 Jun 2005 14:06:36 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] TASK_NONINTERACTIVE (was: Machine Freezes while Running
 Crossover Office)
In-reply-to: <20050601073544.GA21384@elte.hu>
To: linux-kernel@vger.kernel.org
Message-id: <200506011406.36098.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <1117291619.9665.6.camel@localhost>
 <courier.429C05C1.00005CC5@courier.cs.helsinki.fi>
 <20050601073544.GA21384@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 June 2005 03:35, Ingo Molnar wrote:
>Pekka, could you check whether the patch below solves your Wine
> problem (without hurting interactivity otherwise)?
>
> Ingo
>
>----
>
>this patch implements a task state bit (TASK_NONINTERACTIVE), which
> can be used by blocking points to mark the task's wait as
> "non-interactive". This does not mean the task will be considered a
> CPU-hog - the wait will simply not have an effect on the waiting
> task's priority - positive or negative alike. Right now only
> pipe_wait() will make use of it, because it's a common source of
> not-so-interactive waits (kernel compilation jobs, etc.).
>
>Signed-off-by: Ingo Molnar <mingo@elte.hu>
>
>--- linux/fs/pipe.c.orig
>+++ linux/fs/pipe.c
>@@ -39,7 +39,11 @@ void pipe_wait(struct inode * inode)
> {
>  DEFINE_WAIT(wait);
>
>- prepare_to_wait(PIPE_WAIT(*inode), &wait, TASK_INTERRUPTIBLE);
>+ /*
>+  * Pipes are system-local resources, so sleeping on them
>+  * is considered a noninteractive wait:
>+  */
>+ prepare_to_wait(PIPE_WAIT(*inode), &wait,
> TASK_INTERRUPTIBLE|TASK_NONINTERACTIVE); up(PIPE_SEM(*inode));
>  schedule();
>  finish_wait(PIPE_WAIT(*inode), &wait);
>--- linux/kernel/sched.c.orig
>+++ linux/kernel/sched.c
>@@ -1085,6 +1085,16 @@ out_activate:
>  }
>
>  /*
>+  * Tasks that have marked their sleep as noninteractive get
>+  * woken up without updating their sleep average. (i.e. their
>+  * sleep is handled in a priority-neutral manner, no priority
>+  * boost and no penalty.)
>+  */
>+ if (old_state & TASK_NONINTERACTIVE)
>+  __activate_task(p, rq);
>+ else
>+  activate_task(p, rq, cpu == this_cpu);
>+ /*
>   * Sync wakeups (i.e. those types of wakeups where the waker
>   * has indicated that it will leave the CPU in short order)
>   * don't trigger a preemption, if the woken up task will run on
>@@ -1092,7 +1102,6 @@ out_activate:
>   * the waker guarantees that the freshly woken up task is going
>   * to be considered on this CPU.)
>   */
>- activate_task(p, rq, cpu == this_cpu);
>  if (!sync || cpu != this_cpu) {
>   if (TASK_PREEMPTS_CURR(p, rq))
>    resched_task(rq->curr);
>--- linux/include/linux/sched.h.orig
>+++ linux/include/linux/sched.h
>@@ -112,6 +112,7 @@ extern unsigned long nr_iowait(void);
> #define TASK_TRACED  8
> #define EXIT_ZOMBIE  16
> #define EXIT_DEAD  32
>+#define TASK_NONINTERACTIVE 64

This define (64) is already used in the rc5-git5 patch, but with 
another name, so it fails during the patching...

How can we sort this?

> #define __set_task_state(tsk, state_value)  \
>  do { (tsk)->state = (state_value); } while (0)
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
