Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752809AbWKFM1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbWKFM1S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbWKFM1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:27:18 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:18315 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1752809AbWKFM1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:27:18 -0500
Date: Mon, 6 Nov 2006 07:26:55 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH? hrtimer_wakeup: fix a theoretical race wrt rt_mutex_slowlock()
In-Reply-To: <20061106120938.GA85@oleg>
Message-ID: <Pine.LNX.4.58.0611060720440.14553@gandalf.stny.rr.com>
References: <20061105193457.GA3082@oleg> <Pine.LNX.4.64.0611051423150.25218@g5.osdl.org>
 <Pine.LNX.4.58.0611051741070.2439@gandalf.stny.rr.com>
 <Pine.LNX.4.64.0611051906040.25218@g5.osdl.org> <20061106120938.GA85@oleg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Nov 2006, Oleg Nesterov wrote:

> On 11/05, Linus Torvalds wrote:
> >
> > Yeah, that seems a real bug. You _always_ need to actually do the thing
> > that you wait for _before_ you want it up. That's what all the scheduling
> > primitives depend on - you can't wake people up first, and then set the
> > condition variable.
> >
> > So if a rt_mutex depeds on something that is set inside the rq-lock, it
> > needs to get the task rw-lock in order to check it.
>
> No, rt_mutex is fine (I think).

I agree.  The problem isn't with rt_mutex.  It rt_mutex doesn't depend on
that condition to break out of the loop. That condition is an extra
condition that's there to stop in the case we timed out before the owner
released the lock. The real condition to break out of the loop is the
owner releasing the lock, and there's no known races there.

So the time out is what needs to make sure that rt_mutex sees the event.

>
> My changelog was very unclean and confusing, I'll try again. What we are
> doing is:
>
> 	rt_mutex_slowlock:
>
> 		task->state = TASK_INTERRUPTIBLE;
>
> 		mb();
>
> 		if (CONDITION)
> 			return -ETIMEDOUT;
>
> 		schedule();
>
> This is common and correct.
>
> 	hrtimer_wakeup:
>
> 		CONDITION = 1;			// [1]

Right! The changing of the condition isn't even in any spin lock. But that
condition needs be be completed before the changes done within the spin
lock, but unfortunately, the spin lock itself doesn't guarantee anything.

>
> 		spin_lock(rq->lock);
>
> 		task->state = TASK_RUNNING;	// [2]
>
> This needs 'wmb()' between [1] and [2] unless spin_lock() garantees memory
> ordering. Of course, rt_mutex can take rq->lock to solve this, but I don't
> think it would be right.

Correct, the solution should NOT change rt_mutex.  Your original patch is
the correct approach.

-- Steve

>
> Oleg.
>
>
