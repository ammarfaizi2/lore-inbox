Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422778AbWKEWxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422778AbWKEWxx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 17:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422791AbWKEWxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 17:53:53 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:24807 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1422778AbWKEWxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 17:53:53 -0500
Date: Sun, 5 Nov 2006 17:53:32 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Oleg Nesterov <oleg@tv-sign.ru>, Thomas Gleixner <tglx@linutronix.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH? hrtimer_wakeup: fix a theoretical race wrt rt_mutex_slowlock()
In-Reply-To: <Pine.LNX.4.64.0611051423150.25218@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0611051741070.2439@gandalf.stny.rr.com>
References: <20061105193457.GA3082@oleg> <Pine.LNX.4.64.0611051423150.25218@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 5 Nov 2006, Linus Torvalds wrote:

>
> That said, since "task->state" in only tested _inside_ the runqueue lock,
> there is no race that I can see. Since we've gotten the runqueue lock in
> order to even check task-state, the processor that _sets_ task state must
> not only have done the "spin_lock()", it must also have done the
> "spin_unlock()", and _that_ will not allow either the timeout or the task
> state to haev leaked out from under it (because that would imply that the
> critical region leaked out too).
>
> So I don't think the race exists anyway - the schedule() will return
> immediately (because it will see TASK_RUNNING), and we'll just retry.
>

This whole situation is very theoretical, but I think this actually can
happen *theoretically*.


OK, the spin_lock doesn't do any serialization, but the unlock does. But
the problem can happen before the unlock. Because of the loop.

CPU 1                                    CPU 2

    task_rq_lock()

    p->state = TASK_RUNNING;


                                      (from bottom of for loop)
                                      set_current_state(TASK_INTERRUPTIBLE);

                                    for (;;) {  (looping)

                                      if (timeout && !timeout->task)


   (now CPU implements)
   t->task = NULL

   task_rq_unlock();

                                   schedule() (with state == TASK_INTERRUPTIBLE)


Again, this is very theoretical, and I don't even think that this can
happen if you tried to make it.  But I guess if hardware were to change in
the future with the same rules that we have today with barriers, that this
can be a race.

-- Steve


