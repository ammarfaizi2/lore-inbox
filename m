Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129771AbRA3DJa>; Mon, 29 Jan 2001 22:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129101AbRA3DJU>; Mon, 29 Jan 2001 22:09:20 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:33279 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129771AbRA3DJE>; Mon, 29 Jan 2001 22:09:04 -0500
Message-ID: <3A763048.BB95E15A@uow.edu.au>
Date: Tue, 30 Jan 2001 03:08:56 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@linuxcare.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
In-Reply-To: Your message of "Tue, 30 Jan 2001 12:05:41 +1100." <E14NPVU-0005nZ-00@halfway>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> > In message <3A74451F.DA29FD17@uow.edu.au> you write:
> > >     http://www.uwsg.iu.edu/hypermail/linux/kernel/0005.3/0269.html
> > >
> > > A lot of the timer deletion races are hard to fix because of
> > > the deadlock problem.
> 
> Double take: we *did* fix the problems with del_timer_sync().

A bit.

> We should probably have renamed del_timer to del_time_async and make
> everyone fix their code though.

That renaming is an absolute precondition.  We just use

#define del_timer_async del_timer

and as the janitors go through fixing stuff, rename known-to-be-correct
usage of del_timer to del_timer_async.  This is the only way
we can keep track of which code still needs looking at.

It's often trivial.  But sometimes not, such as in SCSI.

We also need to clean up the initialisation of timers with some
nice macros, similar to list.h, semaphore.h, etc.  

> The `text vanishing under timer in
> module' problem is solved by the pending module cleanup for 2.5.

mm..  A very common bug is this:

xxx_handler(void *something)
{
	use(something);
or:     assume(something->foo != 1);
}

xxx_close(something)
{
	del_timer(&something->timer);
	kfree(something);
or:     something->foo = 1;
}

So xxx_handler can "use" freed memory.  There really is a large amount
of breakage here.  Just pick a random user of del_timer() and ask
yourself "what if the handler is running after del_timer returns".

Generally, it doesn't happen, because it's in fact quite rare for
a timer to actually expire, and because a lot of the buggy code
is on rarely-used paths such as close() methods.  I've never seen
a bug report which could be attributed to a timer deletion race - partly
because SMP machines are rare, partly because they tend to be used
with a less exotic range of device drivers and partly because some
random subsytem went stupid and there was nothing concrete to report.

Now, there _is_ a correct solution, and that is to create a new timer
API. Probably one in which the timers are reference counted and their
storage is not managed by the users of the API.

It's a shame to create a second API (but we had two timer APIs up to
a few months back anyway...).  But it's also an opportunity.  The
proposed SMP-scalable timers could benefit from not having to be
back-compatible.  Some of the remaining locking and cross-CPU
traffic could be tossed out if a clean slate were available. 

But I don't see a way around the need for synchronous deletion and
the deadlock risk which that introduces.

The morbid amongst us can read the netdev thread from May 2000,
when timer outrage was at its peak:

	http://www.wcug.wwu.edu/lists/netdev/200005/threads.html
-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
