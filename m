Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423559AbWKFF7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423559AbWKFF7V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 00:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423560AbWKFF7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 00:59:20 -0500
Received: from pool-71-111-72-250.ptldor.dsl-w.verizon.net ([71.111.72.250]:54819
	"EHLO IBM-8EC8B5596CA.beaverton.ibm.com") by vger.kernel.org
	with ESMTP id S1423559AbWKFF7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 00:59:20 -0500
Date: Sun, 5 Nov 2006 21:57:45 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Falk Hueffner <falk@debian.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: ipc/msg.c "cleanup" breaks fakeroot on Alpha
Message-ID: <20061106055745.GA4080@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <87d583f97t.fsf@debian.org> <20061104172954.GA3668@elte.hu> <Pine.LNX.4.64.0611040938490.25218@g5.osdl.org> <87bqnnjd1w.fsf@debian.org> <Pine.LNX.4.64.0611041019180.25218@g5.osdl.org> <454E0B1F.7090106@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454E0B1F.7090106@colorfullife.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2006 at 05:02:39PM +0100, Manfred Spraul wrote:
> Linus Torvalds wrote:
> 
> >[ Removed the kernel mailing list ]
> > 
> >
> [kernel mailing list added back]
> 
> >As far as I can tell, people hold one or the other, but not both, and 
> >happily do strange things to "r_msg". The code seems to _know_ that it is 
> >racy, since in addition to the volatile, it does things like:
> >
> >		...
> >               msr->r_msg = NULL;
> >               wake_up_process(msr->r_tsk);
> >               smp_mb();
> >               msr->r_msg = ERR_PTR(res);
> >		...
> >
> >and that memory barrier again doesn't really seem to make a whole lot of 
> >sense.
> >
> msr is a msg_receiver structure. The structure is stored on the stack of 
> msr->r_tsk.
> The smp_mb() guarantees that the wake_up_process is complete before 
> ERR_PTR(res) is stored into msr->r_msg.

OK, so matching code in sys_msgrcv() spins on the r_tsk pointer
until it becomes non-NULL.  Can't say that I understand why the
first assignment to msr->r_msg cannot simply be ERR_PTR(res), but
I am probably missing something basic.  But your explanation below
clears that up, thank you!

I also don't understand why the code in sys_msgrcv() doesn't have
to remap the msqid, similar to the way it is done in sys_semtimedop().

Is there some reference counter that I am failing to see?  There is
the ipc_rcu_getref() on the send side, and something similar seems
like it would work on the read side -- though with additional cache
thrashing, so probably cheaper to remap the id.

So, what am I missing here?  How does a msgrcv() racing with an rmid()
avoid taking a lock on a message queue that just got freed?  (The
ipc_lock_by_ptr() in "Lockless receive, part 3".)  My concern is the
following sequence of steps:

o	expunge_all() invokes wake_up_process() and sets r_msg.

o	sys_msgrcv() is awakened, but for whatever reason does
	not actually start executing (e.g., lots of other busy
	processes at higher priority).

o	expunge_all() returns to freeque(), which runs through the
	rest of its processing, finally calling ipc_rcu_putref().

o	ipc_rcu_putref() invokes call_rcu() to free the message
	queue after a grace period.

o	ipc_immediate_free() is invoked at the end of a grace
	period, freeing the message queue.

o	sys_msgrcv() finally gets a chance to run, and does an
	rcu_read_lock() -- but too late!!!

o	sys_msgrcv() does ipc_lock_by_ptr() on a message-queue
	data structure that has already been freed.  Things
	degrade rapidly from here...

Or is there some subtlety that prevents this?

If this problem is real, either an ipc_rcu_getref() before the
msg_unlock() before the schedule() and an ipc_rcu_putref() after
the rcu_read_lock() following the schedule(), both in sys_msgrcv()
on the one hand...  Or remap the msqid after the rcu_read_lock()
following the schedule on the other.

						Thanx, Paul

> >But I don't know. It clearly _tries_ to do some smart locking, I just 
> >don't see what the rules are. 
> >
> > 
> >
> The codes tries to to a lockless receive:
> - the mutex is only required to create/destroy queues.
> - normal queue operations are protected by msg_lock(msqid), which is a 
> spinlock. One spinlock for each queue.
> - if a receiving thread doesn't find a message, then it adds a 
> msg_receiver structure into msq->q_receivers. This linked list is stored 
> in the message queue structure and protected by msg_lock(msqid).
> - if a sending thread finds a msg_receiver structure, then it removes 
> the structure from the msq->q_receivers linked list, places the message 
> into msr->r_msg and wakes up the receiver. All operations happen under 
> msg_lock(msqid)
> - the receiver notices that there is a message in it's msr->r_msg 
> structure and copies it to user space, without acquiring msg_lock(msqid).
> 
> ipc/sem.c uses the same idea, I added a longer block with documentation 
> (around line 150 in ipc/sem.c)
> 
> I'm only aware of one tricky race:
> - the sender calls wake_up_process().
> - as soon as the receiver finds something in r_msg, it can return to 
> user space. user space can call exit(3). do_exit destroys the task 
> structure.
> - wake_up_process will cause an oops if it's called after do_exit().
> This race happened on s390. The solution is this block:
> 
>                msr->r_msg = NULL;
>                wake_up_process(msr->r_tsk);
>                smp_mb();
>                msr->r_msg = ERR_PTR(res);
> 
> Initially, r_msg is ERR_PTR(-EAGAIN). The sender first sets it to NULL 
> ("message pending"), then calls wake_up_process(), then a memory 
> barrier, then the final value.
> 
> Back to the bug report:
> "volatile" shouln't be necessary. The critical part is this loop:
> 
>                msg = (struct msg_msg*)msr_d.r_msg;
>                while (msg == NULL) {
>                        cpu_relax();
>                        msg = (struct msg_msg *)msr_d.r_msg;
>                }
> And cpu_relax is a barrier().
> On i386, removing the "volatile" has no effect, the .o remains identical.
> Falk, could you compare the .o files with/without volatile? Are there 
> any differences?
> 
> The oops was caused by try_to_wake_up, called by expunge_all.
> I.e.:
> - either the msq->q_receivers linked list got corrupted
> - or the target thread was destroyed before wake_up_process completed.
> Theoretically, both things are impossible:
> - msq->q_receivers is protected by msq_lock()
> - the target thread task_struct is guaranteed to remain in scope due to 
> the "msg == NULL" loop.
> 
> I'll try to reproduce the oops on i386 - but I don't see a bug right now.
> 
> --
>    Manfred
