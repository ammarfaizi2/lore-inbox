Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132396AbRAQQIX>; Wed, 17 Jan 2001 11:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135311AbRAQQIN>; Wed, 17 Jan 2001 11:08:13 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:3593 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S132396AbRAQQH7>; Wed, 17 Jan 2001 11:07:59 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA2569D7.00584D99.00@d73mta05.au.ibm.com>
Date: Wed, 17 Jan 2001 21:04:43 +0530
Subject: Common Abstraction of Notification & Completion Handling
	 Mechanisms - observations and potential RFC
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been looking at various notification and operation completion
processing mechanisms that we currently have in the kernel. (The
"operation" is typically I/O, but could be something else too).

This comes about as a result of observing  similar patterns in async i/o
handling aspects in filter filesystems and then in layered block drivers
like lvm and evms with kiobuf, and  recalling a suggestion that Ben LaHaise
had made about extending the wait queue interface to support callbacks.
Coming to think of it, we might observe similar patterns elsewhere wherever
there is a need for some processing that needs to be done on the completion
of an operation or in a more general sense, on the triggering of an event.

The pattern is something like this:

1. Post process data : Invoke callbacks for layers above (reverse order) :
(layer1 is the highest level - layer n lowest)
    i.e.  callbackn(argn) -> ....  -> callback2(arg2) -> callback1(arg1)
    - the sequence may get aborted temporarily at any level if required
(e.g for error correction)
2. Mark data as ready for use ( e.g unlock buffer/page, mark as up-to-date
etc)
    (We could perhaps think of this as a level0 callback)
3. Notify registered consumers
- wakeup synchronous waiters   (typically wait_queue based)
- signal async consumers (SIGIO)
(hereafter any further processing happens in the context of the consumer)

We have all the separate mechanisms that are needed to achieve this (I
wonder if we have too many; and if we have some duplication of logic / data
structure patterns in certain cases, just to handle slight distinctions in
flavour ).

Here are some of them:
1. io completion callback routines + private data embedded in specific i/o
structures
    -- in bh, kiobuf (for example) ( sock structure too ?)
2. task queues that can be used for triggering a list of callbacks perhaps
?
3. wait queues for registering synchronous waiters
4. fasync helper routines for registering async waiters to be signalled
(SIGIO)

Other places where we have a callback, arg pattern:
- timer callback + arg (specially for timer events)
- softirq handlers ?

So, if we wanted to have a generic abstraction for the mentioned pattern,
it could be done using a collection of the following:
     - something like a task queue for queueing up multiple callbacks to be
invoked in LIFO order; add some extra functionality to break in case a
callback returns a failure.
     - a wait queue for synchronous waiters
     - an fasync pointer for asynchronous notification requesters
     - a status field (to check on completion status)
     - a private data pointer (to help store persistent state; such state
may also be required for operation
        cancellation)
     - A zeroth level callback registered in the  queue during
initialization to mark the status as completed
     and then notify synchronous and asynchronous waiters
     - Now, if there are multiple related event structures - like compound
events (compound i/os - e.g multiple bh's componded to a page or kiobuf,
sub-kiobufs compounded to a compound kiobuf etc), then there is a
requirement of triggering a similar sequence on that compound event. Have
still not decided at what stage this should happen and how.
     - Another item to think about is the operation cancellation path

One question is whether an extension to the wait queue is indeed
appropriate for the above. Or should it be a different abstraction in
itself ?

I know this needs further thinking through, and definitely some more
detailing, but I'd like to hear some feedback on how it sounds. Besides, I
don't know if anyone is already working on something like this. Does it
even make sense to attempt this ?

Regards
Suparna

  Suparna Bhattacharya
  Systems Software Group, IBM Global Services, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
