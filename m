Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTESXUd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbTESXUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 19:20:33 -0400
Received: from c3po.aoltw.net ([64.236.137.25]:25519 "EHLO netscape.com")
	by vger.kernel.org with ESMTP id S263271AbTESXUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 19:20:31 -0400
Date: Mon, 19 May 2003 16:33:18 -0700 (PDT)
From: John Myers <jgmyers@netscape.com>
Message-Id: <200305192333.QAA12018@pagarcia.nscp.aoltw.net>
To: linux-aio@kvack.org
CC: linux-kernel@vger.kernel.org
Subject: Comparing the aio and epoll event frameworks.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following documents my understanding of the differences between
the epoll and aio event frameworks.  These differences stem from the
fact that epoll is designed for use by single threaded callers,
whereas aio is designed for use by multithreaded, thread pool callers.

I do not intend to criticise either design choice--each model (single
threaded vs. thread pool) has its uses and each model has requirements
of the event framework which conflict with the requirements of the
other.

The single threaded model has the advantage of more efficient use of a
single CPU and its associated cache.  A single threaded caller also
tends to have fewer locking issues to deal with.  As a result,
correctly written single threaded code tends to have a higher
throughput per CPU than thread pool code.

The thread pool model permits the application developer to write
blocking code.  Asynchronous code takes more time to write and debug,
especially when one is starting from an existing code base with
blocking code and when one needs to use third party libraries with
blocking APIs.  The thread pool model permits one to code
asynchronously only that 5% of the code where the program waits over
95% of the time, leaving the worker threads to deal with the rest.
The reduction in throughput one pays over the single threaded model is
effectively insurance against having the entire server stalled by an
overlooked blocking call or a page fault.

The biggest difference between the two frameworks is in the
cancellation semantics.  epoll gives single threaded callers a
guarantee that after a legitimate cancel (EPOLL_CTL_DEL) operation
returns to the caller there is no possibility of an in-progress event
for the canceled request being delivered through a subsequent call to
epoll_wait().  This meets a desire for single threaded callers to
not have to deal with cancel/complete races and permits them to
immediately free their application-side per-connection state.

Thread pool applications, on the other hand, have to deal with
cancel/complete races anyway.  Some other thread could have read the
event immediately before the cancel call.  For this reason, aio cancel
does not bother removing pending completions from the event ring.
When aio_cancel() is called on an operation that has already delivered
its completion event, has a completion event in the ring, or is not
cancelable, it returns -EAGAIN.  A thread pool application can deal
with this easily by waiting on a condition variable which is signaled 
by the thread that picked up the event.  A single threaded application
cannot block, so has to handle this condition by writing asynchronous
tear-down code.

Note that the fact that aio supports uncancelable operations (such as
every aio operation currently implemented in the base kernel) means
that single threaded callers which use such operations would need to
write this asynchronous tear-down code anyway.  Should aio later add
any cancelable operations that wouldn't be available through epoll, it
may want to add for single threaded callers a variant of io_cancel()
that removes any associated event from the ring.

Another difference between the two frameworks is in the prevention (or
lack thereof) of multiple simultaneous events for an operation/fd.
epoll effectively assumes that its caller will finish processing a
returned event before making a subsequent call to epoll_wait().  If
multiple threads each call epoll_wait() on the same eventpoll fd, the
application can easily end up with multiple threads simutaneously
handling identical events.  Worse, the application cannot tell how
many of these duplicate events are outstanding, so tear-down becomes
nigh impossible.  epoll_wait() was designed to only be called from a
single thread and it uses this design aspect to optimize for its usual
case of a single submission/add generating multiple events.

aio keeps a one event per submission rule to avoid such problems for
thread pool callers.  The tradeoff is that applications that want
subsequent events have to keep repaying the cost of submission.
Should the cost of submission turn out to be significant (I'm not
convinced it is with respect to the cost of handling the event) some
of this could be amortized by extending the aio framework with a
method for a thread which has obtained an intermediate event to
"re-arm" the operation once the thread has finished processing it.

