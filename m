Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTLDFwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 00:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbTLDFwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 00:52:04 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:29058 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262687AbTLDFv5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 00:51:57 -0500
Date: Thu, 4 Dec 2003 05:51:37 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org
Subject: Re: [RFC/PATCH] FUSYN Realtime & Robust mutexes for Linux try 2
Message-ID: <20031204055137.GH1216@mail.shareable.org>
References: <A20D5638D741DD4DBAAB80A95012C0AE0125DD4E@orsmsx409.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A20D5638D741DD4DBAAB80A95012C0AE0125DD4E@orsmsx409.jf.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Iñaky, thanks for your response!

Iñaky Pérez-González wrote:
> >     Sometimes if task A with high priority wants a resource which is
> >     locked by task B with lower priority, that should be an error
> >     condition: it can be dangerous to promote the priority of task B,
> >     if task B is not safe to run at a high priority.
> 
> That's a responsibility of the system designer; if he allows tasks to
> share locks, its up to him/her to do it safely.
> 
> I have requests from some vendors to extend this behavior to even
> SCHED_OTHER tasks, so that a FIFO task could promote it to FIFO. I
> personally shiver when thinking about this, but it makes 
> sense in some environments (some real time tasks doing important
> things and a normal task doing low priority cleanups, for example)

Oh, I assumed you _already_ boosted SCHED_OTHER tasks :)

If you are only doing priority inheritance for RT priorities, then
it's not such a big deal to have task B boosted.

> >     But highest-priority wakeup (at least) shouldn't be just for
> >     fuqueues: it should be implemented at a lower level, directly in
> >     the kernel's waitqueues.  Meaning: wake_up() should wake the
> >     highest priority task, not the first one queued, if that is
> >     appropriate for the queue or waker.
> 
> That was the first thing I thought of; however, it is not an easy
> task--for example, now you have to allocate a central node that has
> to live during the life of the waitqueue (unlike in futexes), and
> that didn't play too well -- with the current code, unlike my previous
> attempt with rtfutexes, it is not that much of a deal and could be 
> done, but I don't know how much of the interface I could emulate.

What do you need the central node for?

> >   - Is there a method for passing the locked state to another task?
> >     Compare-and-swap old-pid -> new-pid works when there isn't any
> >     contention, but a kernel call is needed in any of the
> >     kernel-controlled states.
> 
> That can be done, because if you are in non-KCO mode (ie: pid), the
> kernel by definition knows nil about the mutex, so just do the compare 
> and swap in user space and you are ready. No need to add any special
> code.

The question asks what to do in the KCO state.  I.e. when you want to
transfer a locked state and there are waiters.

> >   - For architectures which can't do compare-and-swap, a system call
> >     which does the equivalent (i.e. disables preemption, does
> >     compare-and-swap, enables preemption again) would be quite useful.
> >     Not for maximum performance, but to allow architecture-independent
> >     locking strategies to be written portably.
> 
> But the minute you are doing a system call you are better off calling
> directly the kernel for it to arbitrate the mutex in pure KCO mode.
> I think the overhead saving is worth an #ifdef in the source code for
> the lock operation...

If it is as simple as just keeping the mutex in KCO mode all the time
on archs which don't have compare-and-swap, or those that do if an
application doesn't have explicit asm code for that arch, that would
be very convenient.

I haven't thought through whether keeping a mutex in KCO mode has this
capability.  Perhaps you have and can state the answer?

> >   - Similarly, it would be good for the VFULOCK_ flags to depend on
> >     only 31 bits of the word, i.e. ignoring one of them.  Then
> >     architectures which don't have compare-and-swap but which do have
> >     test-and-set-bit can use that.
> 
> Another thing I discarded; then there is no way for the kernel to 
> identify the owner and most of fusyn's benefits disappear. However,
> I want to give it a second try, in such a way that it would disable
> owner identification (as well as priority inheritance). 

You don't lose the owner id, because pid is always positive so there's
a spare bit.

> Still I don't know how worth is it. Which are the arches that don't 
> support atomic compare-and-swap? [original i386, arm?, sparc32 ... ??]
> Is it worth the bloat added vs. removing for them the fast-lock path?

It means application developers who are using these primitives can
write arch-portable code without writing arch-specific locking logic
for every architecture.  Such applications could be: Perl interpreter,
Python interpreter, Java VM etc. - anything with locks in objects
where the locks need to be as streamlined as possible.

It would be great if the KCO state could be used to provide complete
portability, and then adding arch-specific asm code to the
applications becomes an optimisation, not a requirement.

Speaking of streamlined locks: with futex, it is possible to use fewer
than 32 bits for a lock because futex tests 32 bits against a supplied
value; it doesn't expect anything of the representation.  A spinlock
can be implemented with just one bit in an object, which is useful for
tiny, abundant objects such as Lisp-like cons cells.

More complex locks can be implemented with one or two bits in an
object and auxiliary user-space data structures hashing the object
address in the contended case (which is usually a very small subset of
all the objects).

In these ways, futex is very versatile.

Your next answer explains why fulock cannot be used in a similar way.
It would be very good to keep many of the priority inheritance and RT
scheduling properties of fuqueue while still allowing for the
versatile data uses of futex (or something similar to futex).  I guess
your code does achieve this, because your futex is implemented on top
of fuqueue?

> >   - Does the owner field have to be the pid or can a fulock use any
> >     kind of key value, as long as it isn't one of the reserved values,
> >     that's convenient to the application.
> 
> Anything that we can later use to point it to a 'struct task_struct'
> in a safe way will do. I used the PID because I didn't want to add yet 
> another pid-like field and usage stuff of kernel/pid.c to the task_struct. 
> In fact, it does the trick pretty well (other than the collisions on 
> reusage, but I have some plans for that).

Thinking this over, it occurs to me that you can also implement lock
stealing.  You know who the owner is, so you can send a signal to the
owner saying "please release the lock", but actually stealing a lock
requires kernel support doesn't it?  Just a thought, not sure how
useful that would be.

> Asides from the comments, it adds the most complex/bloating part,
> the priority-sorted thingie and chprio support vs not having the FUTEX_FD
> or requeue support...it comes to be, more or less equivalent, considering
> all the crap that has to be changed for the prioritization to work 
> respecting the incredibly stupid POSIX semantincs for mutex lifetimes.

Are there specified POSIX semantics for prioritisation and mutex interaction?

-- Jamie
