Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752292AbWKFLHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbWKFLHn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 06:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752286AbWKFLHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 06:07:43 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:58857 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1751975AbWKFLHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 06:07:42 -0500
Date: Mon, 6 Nov 2006 15:09:38 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH? hrtimer_wakeup: fix a theoretical race wrt rt_mutex_slowlock()
Message-ID: <20061106120938.GA85@oleg>
References: <20061105193457.GA3082@oleg> <Pine.LNX.4.64.0611051423150.25218@g5.osdl.org> <Pine.LNX.4.58.0611051741070.2439@gandalf.stny.rr.com> <Pine.LNX.4.64.0611051906040.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611051906040.25218@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05, Linus Torvalds wrote:
> 
> On Sun, 5 Nov 2006, Steven Rostedt wrote:
> > 
> > This whole situation is very theoretical, but I think this actually can
> > happen *theoretically*.
> > 
> > OK, the spin_lock doesn't do any serialization, but the unlock does. But
> > the problem can happen before the unlock. Because of the loop.
> > 
> > CPU 1                                    CPU 2
> > 
> >     task_rq_lock()
> > 
> >     p->state = TASK_RUNNING;
> > 
> > 
> >                                       (from bottom of for loop)
> >                                       set_current_state(TASK_INTERRUPTIBLE);
> > 
> >                                     for (;;) {  (looping)
> > 
> >                                       if (timeout && !timeout->task)
> > 
> > 
> >    (now CPU implements)
> >    t->task = NULL
> > 
> >    task_rq_unlock();
> > 
> >                                    schedule() (with state == TASK_INTERRUPTIBLE)
> 
> Yeah, that seems a real bug. You _always_ need to actually do the thing 
> that you wait for _before_ you want it up. That's what all the scheduling 
> primitives depend on - you can't wake people up first, and then set the 
> condition variable.
> 
> So if a rt_mutex depeds on something that is set inside the rq-lock, it 
> needs to get the task rw-lock in order to check it.

No, rt_mutex is fine (I think).

My changelog was very unclean and confusing, I'll try again. What we are
doing is:

	rt_mutex_slowlock:

		task->state = TASK_INTERRUPTIBLE;

		mb();

		if (CONDITION)
			return -ETIMEDOUT;

		schedule();

This is common and correct.

	hrtimer_wakeup:

		CONDITION = 1;			// [1]

		spin_lock(rq->lock);

		task->state = TASK_RUNNING;	// [2]

This needs 'wmb()' between [1] and [2] unless spin_lock() garantees memory
ordering. Of course, rt_mutex can take rq->lock to solve this, but I don't
think it would be right.

Oleg.

