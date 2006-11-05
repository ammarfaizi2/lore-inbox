Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932677AbWKEXIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbWKEXIr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 18:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932745AbWKEXIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 18:08:47 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:25786 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S932677AbWKEXIq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 18:08:46 -0500
Date: Mon, 6 Nov 2006 02:08:37 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH? hrtimer_wakeup: fix a theoretical race wrt rt_mutex_slowlock()
Message-ID: <20061105230837.GA3134@oleg>
References: <20061105193457.GA3082@oleg> <Pine.LNX.4.64.0611051423150.25218@g5.osdl.org> <Pine.LNX.4.58.0611051741070.2439@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0611051741070.2439@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05, Steven Rostedt wrote:
> 
> On Sun, 5 Nov 2006, Linus Torvalds wrote:
> 
> >
> > That said, since "task->state" in only tested _inside_ the runqueue lock,
> > there is no race that I can see. Since we've gotten the runqueue lock in
> > order to even check task-state, the processor that _sets_ task state must
> > not only have done the "spin_lock()", it must also have done the
> > "spin_unlock()", and _that_ will not allow either the timeout or the task
> > state to haev leaked out from under it (because that would imply that the
> > critical region leaked out too).
> >
> > So I don't think the race exists anyway - the schedule() will return
> > immediately (because it will see TASK_RUNNING), and we'll just retry.
> >
> 
> This whole situation is very theoretical, but I think this actually can
> happen *theoretically*.
> 
> 
> OK, the spin_lock doesn't do any serialization, but the unlock does. But
> the problem can happen before the unlock. Because of the loop.

Yes, yes, thanks.

( Actually, this was more "is my understanding correct?" than a patch )

Thanks!

> CPU 1                                    CPU 2
> 
>     task_rq_lock()
> 
>     p->state = TASK_RUNNING;
> 
> 
>                                       (from bottom of for loop)
>                                       set_current_state(TASK_INTERRUPTIBLE);
> 
>                                     for (;;) {  (looping)
> 
>                                       if (timeout && !timeout->task)
> 
> 
>    (now CPU implements)
>    t->task = NULL
> 
>    task_rq_unlock();
> 
>                                    schedule() (with state == TASK_INTERRUPTIBLE)
> 
> 
> Again, this is very theoretical, and I don't even think that this can
> happen if you tried to make it.  But I guess if hardware were to change in
> the future with the same rules that we have today with barriers, that this
> can be a race.
> 
> -- Steve
> 
> 

