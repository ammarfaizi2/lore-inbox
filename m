Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129478AbQKHUcO>; Wed, 8 Nov 2000 15:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129679AbQKHUcE>; Wed, 8 Nov 2000 15:32:04 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:15113 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129601AbQKHUb4>;
	Wed, 8 Nov 2000 15:31:56 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200011082031.XAA20453@ms2.inr.ac.ru>
Subject: Re: [patch] NE2000
To: morton@nortelnetworks.com (Andrew Morton)
Date: Wed, 8 Nov 2000 23:31:28 +0300 (MSK)
Cc: andrewm@uow.edu.au, davem@redhat.com (Dave Miller),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A076B91.80C63C58@asiapacificm01.nt.com> from "Andrew Morton" at Nov 7, 0 02:40:17 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

[ Dave, please, look! I will strain brains this night too.
  Indeed, this sounds dubious. ]

No, Andrew, this is surely not related to either of puzzles even if it
is really buggy place. ping does not use either tcp or socket lock. 8)

> Can sock_fasync() be called when we're on a waitqueue, not in
> state TASK_RUNNING and prior to schedule()?

No top level syscalls can be called in either state but running.
That funny BUG() proves the opposite, but this must not happen in any case.
At least, I still cannot reproduce this here. 8)

Alexey



> OK, there are a few areas which look fishy.
> 
> Calling __lock_sock when we're getting ready to wait
> on a different waitqueue looks like a rather risky area.
> We have a single task which is on two waitqueues.
> 
> Consider the case of tcp_data_wait():
> 
> 	add_wait_queue(sk->sleep)
> 	set_current_state(TASK_INTERRUPTIBLE);
> 	release_sock(sk);
> 	if (...)	/* Suppose this evaluates to false */
> 		schedule_timeout();
> 	lock_sock();
> 
> 	__lock_sock()
> 	{
> 		add_wait_queue_exclusive(sk->lock.wq);
> 		/* Window 1: What does a wake_up(sk->sleep) do here? */
> 		current->state = TASK_EXCLUSIVE | TASK_UNINTERRUPTIBLE;
> 		/* Window 2: Bad things happen here */
> 		schedule();
> 
> If someone does a wakeup(sk->sleep) in Window 2 in
> __lock_sock() the wakeup code will think that the
> task is sleeping on sk->sleep in state
> TASK_EXCLUSIVE|TASK_UNINTERRUPTIBLE,
> when in fact it is not.  So a wakeup which _should_ have gone to
> a different exclusive task actually goes to this one. This is
> fantastically hard to hit because of the direction of the
> waitqueue scan.
> 
> If the wakeup on sk->sleep happens during Window 1
> it will be completely lost, but that's OK because
> this task is not yet TASK_EXCLUSIVE (providing the
> write ordering behaves as we want?)
> 
> If a wakeup on sk->lock.wq happens during Window 1
> it will be completely lost.
> 
> wait_for_connect() and wait_for_tcp_memory() play similar
> games with lock_sock() whereby they can appear to be on
> two waitqueues at the same time. And again, because
> lock_sock() uses TASK_EXCLUSIVE a wake_up on sk->sleep
> could choose this task instead of a TASK_EXCLUSIVE task
> which is _really_ sleeping on sk->sleep.
> 
> Now, this may not be a problem in practise, and in fact the
> above may not be bugs because I missed something. But I suggest you
> have a think about it.  My brain is starting to hurt.
> 
> But none of these explain Jorge's problem.  How he got to where
> he did in !TASK_RUNNING.  Plus the possible lock_sock problems
> just look too damn hard to hit to explain Jorge's repeatability.
> 
> It may be useful to put a Pentium hardware watchpoint onto
> current->state.  Does kdb support those?
> 
> Can sock_fasync() be called when we're on a waitqueue, not in
> state TASK_RUNNING and prior to schedule()?
> 
> inet_wait_for_connect() is OK.
> wait_for_tcp_connect() is OK.
> tcp_close() is OK.
> 
> Also, are you sure that all occurrences of 
> 
> 	current->state = <whatever>;
> 
> are still safe on weakly ordered CPUs? (Not that this
> would explain Jorge's problem).
> 
> hmm..  khttpd tries to do wake-one, but
> interruptible_sleep_on_timeout() confounds it.
> Bummer.
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
