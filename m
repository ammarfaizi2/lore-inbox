Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264600AbTLFAlW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 19:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264867AbTLFAlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 19:41:22 -0500
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:14587 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S264600AbTLFAlT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 19:41:19 -0500
Date: Fri, 5 Dec 2003 19:41:11 -0500
To: "Discussion on impl'on details of robust and real-time
	 mutexes" <robustmutexes@lists.osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org
Subject: Re: [robustmutexes] RE: [RFC/PATCH] FUSYN Realtime & Robust mutexes for Linux try 2
Message-ID: <20031206004111.GA17731@yoda.timesys>
References: <A20D5638D741DD4DBAAB80A95012C0AE0125DD67@orsmsx409.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A20D5638D741DD4DBAAB80A95012C0AE0125DD67@orsmsx409.jf.intel.com>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 01:27:42AM -0800, Perez-Gonzalez, Inaky wrote:
> Heh ... doing it for SCHED_OTHER becomes a nightmare, and I still
> am not that sure is feasible without major surgery on the way
> the priority information is stored in the task_struct now; as well,
> POSIX says nothing about it, or at least is kind of gray in a sense
> where it seems only SCHED_{FIFO,RR} should be involved, so I am 
> really tempted not to do it (well, that's what is nicing it towards
> 20 :)

I'd consider it the expected behavior, though, even if POSIX doesn't
mandate it (the user did request PI on the lock, and it's only for
the duration of the critical section, when the user really shouldn't
be doing things that would break if done as a RT task).  What sort of
problems with the scheduler do you see, other than an extra field to
the task_struct to store the old dynamic priority?

In any case, returning an error if a non-RT task blocks on a PI lock
is not likely what the user wants, and completely broken if you
intend to use it inside the kernel for mutex-like semaphores.  If
instead you silently fail to boost, it wouldn't necessarily be
obvious to the user that you're not boosting.  IMHO, boosting
SCHED_NORMAL tasks is the only sane thing to do.

> Now, on ufuqueues (the ones that are associated to user space addresses,
> the true futex equivalent) that means you can't do the trick of the 
> futex chain lists, so you have on each chain a head per ufuqueue/user
> space address. That ufuqueue cannot be declared on the stack of one
> of the waiters, as it would disappear when it is woken up and might leave
> others dangling.
> 
> So we have to allocate it, add the waiters to it and deallocate it when 
> the wait list is empty.

However, instead of allocating the memory on demand, you can keep a
pool of available queues.  Every time a task is created, allocate
one and add it to the queue; every time a task dies, retrieve one
and free it.  Since a task can only wait on one queue at a time,
you won't run out of queues (unless you want to implement some sort
of wait for multiple objects; however, in such a case you could
allocate the extra queues on demand without affecting the normal
single-object case).

Thus, it would be a simple linked-list operation plus a spinlock to
acquire and release a queue whenever something blocks.  It would be
slower than the current waitqueue implementation, but not by much
(and it could be made configurable for those who want every last
cycle and don't care about real-time wait queues).

This would be beneficial for userspace usage as well, as blocking
on a queue would no longer be subject to a return value of -ENOMEM
(which is generally undesireable in what's supposed to be a
predictable real-time application).

> This is what complicates the whole thing and adds the blob of code
> that is vl_locate() [the allocation and addition to the list,
> checking for collisions when locks are dropped]. As the whole thing
> is kind of expensive, we better cache it for a few seconds, as
> chances are we will have some temporal locality (in fact, it
> happens, it improves the performance a lot),

If the pool is kept as a stack, you keep the cache benefits, as well
as allowing re-use of the queue across different locks.

-Scott
