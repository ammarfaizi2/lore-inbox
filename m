Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130012AbQKGClJ>; Mon, 6 Nov 2000 21:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130640AbQKGCk7>; Mon, 6 Nov 2000 21:40:59 -0500
Received: from smtprch1.nortelnetworks.com ([192.135.215.14]:35538 "EHLO
	smtprch1.nortel.com") by vger.kernel.org with ESMTP
	id <S130012AbQKGCkw>; Mon, 6 Nov 2000 21:40:52 -0500
Message-ID: <3A076B91.80C63C58@asiapacificm01.nt.com>
Date: Tue, 07 Nov 2000 02:40:17 +0000
From: "Andrew Morton" <morton@nortelnetworks.com>
Organization: Nortel Networks, Wollongong Australia
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.0-test4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [patch] NE2000
In-Reply-To: <3A039E77.5DD87DF0@uow.edu.au> from "Andrew Morton" at Nov 4,
            0 08:45:01 am <200011061846.VAA20608@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > No, that code is correct, provided (current->state == TASK_RUNNING)
> > on entry.  If it isn't, there's a race window which can cause
> > lost wakeups.   As a check you could add:
> >
> >       if ((current->state & (TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE)) == 0)
> >               BUG();
> 
> Though it really cannot happen and really happens, as we have seen... 8)
> 
> In any case, Andrew, where is the race, when we enter in sleeping state?
> Wakeup is not lost, it is just not required when we are not going
> to schedule and force task to running state.
> 
> I still do not see how it is possible that task runs in sleeping state.
> Apparently, set_current_state is forgotten somewhere. Do you see, where? 8)
> 

OK, there are a few areas which look fishy.

Calling __lock_sock when we're getting ready to wait
on a different waitqueue looks like a rather risky area.
We have a single task which is on two waitqueues.

Consider the case of tcp_data_wait():

	add_wait_queue(sk->sleep)
	set_current_state(TASK_INTERRUPTIBLE);
	release_sock(sk);
	if (...)	/* Suppose this evaluates to false */
		schedule_timeout();
	lock_sock();

	__lock_sock()
	{
		add_wait_queue_exclusive(sk->lock.wq);
		/* Window 1: What does a wake_up(sk->sleep) do here? */
		current->state = TASK_EXCLUSIVE | TASK_UNINTERRUPTIBLE;
		/* Window 2: Bad things happen here */
		schedule();

If someone does a wakeup(sk->sleep) in Window 2 in
__lock_sock() the wakeup code will think that the
task is sleeping on sk->sleep in state
TASK_EXCLUSIVE|TASK_UNINTERRUPTIBLE,
when in fact it is not.  So a wakeup which _should_ have gone to
a different exclusive task actually goes to this one. This is
fantastically hard to hit because of the direction of the
waitqueue scan.

If the wakeup on sk->sleep happens during Window 1
it will be completely lost, but that's OK because
this task is not yet TASK_EXCLUSIVE (providing the
write ordering behaves as we want?)

If a wakeup on sk->lock.wq happens during Window 1
it will be completely lost.

wait_for_connect() and wait_for_tcp_memory() play similar
games with lock_sock() whereby they can appear to be on
two waitqueues at the same time. And again, because
lock_sock() uses TASK_EXCLUSIVE a wake_up on sk->sleep
could choose this task instead of a TASK_EXCLUSIVE task
which is _really_ sleeping on sk->sleep.

Now, this may not be a problem in practise, and in fact the
above may not be bugs because I missed something. But I suggest you
have a think about it.  My brain is starting to hurt.

But none of these explain Jorge's problem.  How he got to where
he did in !TASK_RUNNING.  Plus the possible lock_sock problems
just look too damn hard to hit to explain Jorge's repeatability.

It may be useful to put a Pentium hardware watchpoint onto
current->state.  Does kdb support those?

Can sock_fasync() be called when we're on a waitqueue, not in
state TASK_RUNNING and prior to schedule()?

inet_wait_for_connect() is OK.
wait_for_tcp_connect() is OK.
tcp_close() is OK.

Also, are you sure that all occurrences of 

	current->state = <whatever>;

are still safe on weakly ordered CPUs? (Not that this
would explain Jorge's problem).

hmm..  khttpd tries to do wake-one, but
interruptible_sleep_on_timeout() confounds it.
Bummer.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
