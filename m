Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbTLFCdK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 21:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264934AbTLFCdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 21:33:10 -0500
Received: from fmr06.intel.com ([134.134.136.7]:26028 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264933AbTLFCcv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 21:32:51 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [robustmutexes] RE: [RFC/PATCH] FUSYN Realtime & Robust mutexesfor Linux try 2
Date: Fri, 5 Dec 2003 18:32:45 -0800
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE0125DEC2@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [robustmutexes] RE: [RFC/PATCH] FUSYN Realtime & Robust mutexesfor Linux try 2
Thread-Index: AcO7kaykT21qVV72SG2Ub4IQAWzwGAADAANA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Discussion on impl'on details of robust and real-time mutexes" 
	<robustmutexes@lists.osdl.org>
Cc: "Jamie Lokier" <jamie@shareable.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Dec 2003 02:32:46.0128 (UTC) FILETIME=[3BA4A300:01C3BBA1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Scott Wood 
> On Thu, Dec 04, 2003 at 01:27:42AM -0800, Perez-Gonzalez, Inaky wrote:
> > Heh ... doing it for SCHED_OTHER becomes a nightmare, and I still
> > am not that sure is feasible without major surgery on the way
> 
> I'd consider it the expected behavior, though, even if POSIX doesn't
> mandate it (the user did request PI on the lock, and it's only for

Now that makes full sense -- ok, so that means I cannot renice it
that easily.

> What sort of
> problems with the scheduler do you see, other than an extra field to
> the task_struct to store the old dynamic priority?

They are not problems with the scheduler per se, is how to keep the
stuff around. 

You have to keep many things, namely policy and priority consistant,
and at the same time, you have to hide them from user space.

Now, boosting up to FIFO/RR from other is a no brainer, because 
task->prio won't be modified, but boosting from OTHER to OTHER is
dead ugly, as the estimator is going to fiddle with task->prio
left and right, and now you really want it to do it based on
the parameters of the boosting thread, not yours.

So I guess I have to save more than just the dynamic prio. Probably
I am just making a fuss of it because I am too lazy. I will look
again into it,. 

> In any case, returning an error if a non-RT task blocks on a PI lock
> is not likely what the user wants, and completely broken if you
> intend to use it inside the kernel for mutex-like semaphores.  If
> ...

All agreed--expect it to be working IANF.

> > So we have to allocate it, add the waiters to it and deallocate it when
> > the wait list is empty.
> 
> However, instead of allocating the memory on demand, you can keep a
> pool of available queues.  Every time a task is created, allocate
> one and add it to the queue; every time a task dies, retrieve one
> and free it.  Since a task can only wait on one queue at a time,
> you won't run out of queues (unless you want to implement some sort

I like the idea, specially because the guarantees, but I don't know
how accepted it will be:

1 the wait queue is just the base type, fulock builds on top of it,
  so a fulock is bigger than a fuqueue. So, you would have to allocate
  on of each for each task for it to make sense (if some time we add
  rwlocks, something similar would happen).

  We could also say: ok, we split them, but then you'd have to allocate
  the extra stuff somewhere else and are back in square 1 (not to mention
  all the complications introduced for doing that).

2 Many tasks are not going to use locks in user space, so they will
  not need at all that associated queue/lock, thus the space would be 
  wasted for every task that does not use them.

3 It'd slow down task creation time.

It really comes up to be a balancing decision: are we willing to put up
with the wasted space (2) and (3) to get rid of the -ENOMEM problem?\

I think I will implement a configurable proof of concept see how it 
works.

As a side note, the best thing for user space would be to call back
if it sees an -ENOMEM (something akin to -EAGAIN).

On the other side, we could somehow force a hi/lo watermarks in the
number of readily available fulocks/fuqueues in the kmem caches for
each.

> ...
> 
> This would be beneficial for userspace usage as well, as blocking
> on a queue would no longer be subject to a return value of -ENOMEM
> (which is generally undesireable in what's supposed to be a
> predictable real-time application).

kernel space does not have the allocation problem; if you are using
fuqueues or fulocks from kernel code, it is up to the caller to provide
the structure.

Thanks for the input, I will put it to good use :] Let's see if I can
scratch some time next week to put it to work.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
