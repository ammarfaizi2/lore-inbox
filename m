Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTLMAue (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 19:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbTLMAud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 19:50:33 -0500
Received: from fmr05.intel.com ([134.134.136.6]:6285 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S262694AbTLMAuZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 19:50:25 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [robustmutexes] Re: [RFC/PATCH] FUSYN 5/10: kernel fuqueues
Date: Fri, 12 Dec 2003 16:50:13 -0800
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE0125E2BA@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [robustmutexes] Re: [RFC/PATCH] FUSYN 5/10: kernel fuqueues
Thread-Index: AcPA5SpMolPo09LaQ8OzUsHGeEhWBwAK0HSA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Discussion on impl'on details of robust and real-time mutexes" 
	<robustmutexes@lists.osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Dec 2003 00:50:13.0948 (UTC) FILETIME=[118CB7C0:01C3C113]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: William Lee Irwin III
> 
> > +static inline void __debug_outb (unsigned val, int port) {
> > +	__asm__ __volatile__ ("outb %b0,%w1" : : "a" (val), "Nd" (port));
> > +}
> > +static inline unsigned __debug_inb (int port) {
> > ...
> 
> In general, this kind of debug code shouldn't go in "shipped" patches.

Yep, all this is "devel" stuff that will be pruned up sooner or later (you
mention a few more occurrences, all fall under the same category).

It is disabled by default (and if it wasn't, it was by mistake). I still
don't consider this shipping patches, more an RFC and looking for feedback
(like yours) so that's why I didn't use too much time in removing all that.

> > +#define assert(c, a...)	 do { if ((DEBUG >= 0) && !(c)) BUG(); } while (0)
> 
> assert() is a no-no in Linux, for various reasons.

Why?? [asides from the obvious side effects]--BUG_ON(), what I'd use given
the need, is an assertion.

Anyway, I don't really use it. These "debugging" macros were a copy and paste 
from one of those bag-o-tricks I have for user space -- I probably use only
a handful of the macros and they will go away.

> On Wed, Dec 03, 2003 at 12:51:34AM -0800, inaky.perez-gonzalez@intel.com wrote:
> > + * FIXME: is it worth to have get/put? maybe they should be enforced
> > + *        for every fuqueue, this way we don't have to query the ops
> > + *        structure for the get/put method and if it is there, call
> > + *        it. We'd have to move the get/put ops over to the vlocator,
> > + *        but that's not much of a problem.
> > + *        The decission factor is that an atomic operation needs to
> > + *        lock the whole bus and is not as scalable as testing a ptr
> > + *        for NULLness.
> > + *        For simplicity, probably the idea of forcing the refcount in
> > + *        the fuqueue makes sense.
> 
> Basically, if there aren't multiple implementations of ->get()/->put()
> that need to be disambiguated, this should get left out.

There are multiple implementations (more about this at the bottom).

> > +/* Priority-sorted list */
> > +struct plist {
> > +	unsigned prio;
> > +	struct list_head node;
> > +};
> 
> Maybe the expectation is for short lists, but it might be better to use
> an rbtree or other sublinear insertion/removal structure for this. It
> would be nice if we had a generic heap structure for this sort of affair.

Yes, initially it is. I have in the short-term to do the plan to implement
a more efficient, O(1) version (using queue heads for each prio) as I know
I have a hard max of 140 queues (so in worth case, complexity would be
O(140) which is O(1)).

That approach would work quite well, if the added complexity is not too
much. I see the interest for other applications also. I'll try to give
it a shot someday, but I am quite short on bw now. Do you know if there
is some implementation lying around that I can cannibalize? [too lazy to
look around right now]

> > +void fuqueue_chprio (struct task_struct *task)
> > +{
> > ...
> > +	local_irq_save (flags);
> > +	preempt_disable();
> > +	get_task_struct (task);
> > +next:
> > +	/* Who is the task waiting for? safely acquire and lock it */
> > +	_raw_spin_lock (&task->fuqueue_wait_lock);
> > +	fuqueue = task->fuqueue_wait;
> > ...
> > ...
> > ...
> > +out_task_unlock:
> > +	_raw_spin_unlock (&task->fuqueue_wait_lock);
> > +	put_task_struct (task);
> > +out:
> > +	local_irq_restore (flags);
> > +	preempt_enable();
> > +	return;
> 
> Heavy use of _raw_spin_lock() like this is a poor practice.

Geee, it was suspicious nobody had yet complained about it. 

It looks plain ugly, but the propagation has to be quick with no irqs
in the middle, so I could unfold it into using:

local_irq_save()

spin_lock()
spin_unlock()...etc

local_irq_restore()

however, once I was in there, I saw a silly overhead to be doing and 
undoing the preemption when it had to be disabled anyway because of
the interrupts. Maybe it is an small stupid gain, but a gain, after all.

In some places I still have to clean up similar usages which do not
make sense to be unfold (these are the ones that walk the chains
up and down and the fuqueue_wait() one to avoid the resched on unlock).

> > +/** Fuqueue operations for usage within the kernel */
> > +struct fuqueue_ops fuqueue_ops = {
> > +	.get = NULL,
> > +	.put = NULL,
> > +	.wait_cancel = __fuqueue_wait_cancel,
> > +	.chprio = __fuqueue_chprio
> > +};
> 
> If this is all ->get() and ->put() are going to be, why bother?

Look into ufuqueue_ops, ufulock_ops.fuqueue_ops [ufulock.c, ufuqueue.c]. 
The problem is when these guys are being used for user space 
synchronization--then they need to be refcounted; when you use them 
inside the kernel only you control their life cycle and refcounting 
is not necessary.

Now, this still gives you the option to do the refcounting if you have a
kernel fulock embedded in some dynamic object and don't want to do the
management manually...it gives more flexibility, so I think at the end
is worth not to force the management but to keep them in the _ops structure.

Hey, thanks for the feedback!

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
