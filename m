Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTLDE5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 23:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTLDE5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 23:57:55 -0500
Received: from fmr06.intel.com ([134.134.136.7]:40896 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262540AbTLDE5u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 23:57:50 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [RFC/PATCH] FUSYN Realtime & Robust mutexes for Linux try 2
Date: Wed, 3 Dec 2003 20:57:23 -0800
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE0125DD4E@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH] FUSYN Realtime & Robust mutexes for Linux try 2
Thread-Index: AcO6HNibYjfgsK6WReGCLnknp6+SAgAAF5MA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Jamie Lokier" <jamie@shareable.org>
Cc: <linux-kernel@vger.kernel.org>, <robustmutexes@lists.osdl.org>
X-OriginalArrivalTime: 04 Dec 2003 04:57:24.0104 (UTC) FILETIME=[1B4B3080:01C3BA23]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jamie Lokier [mailto:jamie@shareable.org]

> Here's my first thoughts, on reading Documentation/fusyn.txt.
> 
>   - Everything here can be implemented on top of regular futex, but
>     that doesn't mean the implementation will be efficient or robust.
>     (This is because, in general, any kind of futex/fuqueue/whatever
>     implementation can be moved from kernel space to userspace, using
>     the real kernel futexes to simulate the waitqueues and spinlocks
>     that are called in futex.c).

I thought that initially, and my first tries (last year?) went into 
that direction, but there are many holes (unless I am wrong). For 
example:

 - [minor] avoidance of priority inversions: you cannot leave the 
   lock unlocked while transferring ownership and race conditions
   trying to implement this.

 - priority inheritance/protection: hell on heels, you will have so
   many system calls into the kernel and race conditions that it is
   probably not worth it. Big surgery would be needed to 
   implement the wait_cancel of a boosting thread. You need
   to be able to find who is owning what and follow a possibly long
   ownership/wait chain (more kernel) to boost (reprioritize) each
   owner until hitting the end. This implies having the privilege and
   the means to look it up.

 - robustness: you need the kernel help, at least to identify the dead
   guy, and for most applications that they want to use this for, it
   has to be snap quick. Maybe it could be made fast, but not as much
   as now (you'd have to query the vfulock, verify that nobody else is
   trying to initiate recovery -- this requires another lock, which 
   requires robustness too, chicken and egg -- and then perform the
   recovery); a PITA, to summarize

> There are some good ideas in here, for people who need the features:
> 
>   - Priority inheritence is ok _when_ you want it.

That's why it is enabled only on request; it bothers me that having
it forces some things, like having to do wait_cancel from interrupt
contexts and stuff like that. Fortunately, chprio also requires that,
so serves as a justification for having it. 

I still need to quantify the overall effects of that, btw.

>     Sometimes if task A with high priority wants a resource which is
>     locked by task B with lower priority, that should be an error
>     condition: it can be dangerous to promote the priority of task B,
>     if task B is not safe to run at a high priority.

That's a responsibility of the system designer; if he allows tasks to
share locks, its up to him/her to do it safely.

I have requests from some vendors to extend this behavior to even
SCHED_OTHER tasks, so that a FIFO task could promote it to FIFO. I
personally shiver when thinking about this, but it makes 
sense in some environments (some real time tasks doing important
things and a normal task doing low priority cleanups, for example)

>     But highest-priority wakeup (at least) shouldn't be just for
>     fuqueues: it should be implemented at a lower level, directly in
>     the kernel's waitqueues.  Meaning: wake_up() should wake the
>     highest priority task, not the first one queued, if that is
>     appropriate for the queue or waker.

That was the first thing I thought of; however, it is not an easy
task--for example, now you have to allocate a central node that has
to live during the life of the waitqueue (unlike in futexes), and
that didn't play too well -- with the current code, unlike my previous
attempt with rtfutexes, it is not that much of a deal and could be 
done, but I don't know how much of the interface I could emulate.

As well, supporting the priority change while waiting requires some
more work...

It is in my todo list to add some more bits to the fuqueue layer so
it can do everything waitqueues do with the priority based interface.

It'd be interesting to experiment in some subsystem by changing the
usage of waitqueues for fuqueues, see what happens. 
 
>   - Is there a method for passing the locked state to another task?
>     Compare-and-swap old-pid -> new-pid works when there isn't any
>     contention, but a kernel call is needed in any of the
>     kernel-controlled states.

That can be done, because if you are in non-KCO mode (ie: pid), the
kernel by definition knows nil about the mutex, so just do the compare 
and swap in user space and you are ready. No need to add any special
code.

>   - It's very unpleasant that rwlocks enter the kernel when there is
>     more than one reader.  Hashed rwlocks can be implemented in
>     ...

Sure it is--will keep this in mind; I still haven't thought too much 
about it.

>   - For architectures which can't do compare-and-swap, a system call
>     which does the equivalent (i.e. disables preemption, does
>     compare-and-swap, enables preemption again) would be quite useful.
>     Not for maximum performance, but to allow architecture-independent
>     locking strategies to be written portably.

But the minute you are doing a system call you are better off calling
directly the kernel for it to arbitrate the mutex in pure KCO mode.
I think the overhead saving is worth an #ifdef in the source code for
the lock operation...

But yes, doing single binary releases complicates this; how does NPTL
solve it now? I don't think Ulrich supports i386, does he? no he does
not. Even a trap for an undefined instruction could solve it for that
case...

>   - Similarly, it would be good for the VFULOCK_ flags to depend on
>     only 31 bits of the word, i.e. ignoring one of them.  Then
>     architectures which don't have compare-and-swap but which do have
>     test-and-set-bit can use that.

Another thing I discarded; then there is no way for the kernel to 
identify the owner and most of fusyn's benefits disappear. However,
I want to give it a second try, in such a way that it would disable
owner identification (as well as priority inheritance). 

Still I don't know how worth is it. Which are the arches that don't 
support atomic compare-and-swap? [original i386, arm?, sparc32 ... ??]
Is it worth the bloat added vs. removing for them the fast-lock path?

>   - Does the owner field have to be the pid or can a fulock use any
>     kind of key value, as long as it isn't one of the reserved values,
>     that's convenient to the application.

Anything that we can later use to point it to a 'struct task_struct'
in a safe way will do. I used the PID because I didn't want to add yet 
another pid-like field and usage stuff of kernel/pid.c to the task_struct. 
In fact, it does the trick pretty well (other than the collisions on 
reusage, but I have some plans for that).
 
>   - It's a huge patch.  A nice thing about futex.c is that it's
>     relatively small (your patch is 9 times larger).  The original
>     futex design was more complicated, and written specifically for
>     mutexes.  Then it was made simpler and I think smaller at the same
>     time.  Perhaps putting some of the RT priority capabilities
>     directly into kernel waitqueues would help with this.

I agree with that, but think about the pieces. The only part that is
strictly equivalent to futexes is the ufuqueues, so that's ufuqueue.c, 
fuqueue.c and vlocator.c. The splitting is necessary to allow parts
and pieces to be shared by the fulocks.

Asides from the comments, it adds the most complex/bloating part,
the priority-sorted thingie and chprio support vs not having the FUTEX_FD
or requeue support...it comes to be, more or less equivalent, considering
all the crap that has to be changed for the prioritization to work 
respecting the incredibly stupid POSIX semantincs for mutex lifetimes.

Well, thanks for the comments--I will keep them in the backburner,
specially the test-and-set-bit thingie. I'll try to tackle it after I do the
KCO mode on call to properly support priority protection, as well as 
improving the owner identification method. 

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
