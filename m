Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbQJ0Xw0>; Fri, 27 Oct 2000 19:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129622AbQJ0XwQ>; Fri, 27 Oct 2000 19:52:16 -0400
Received: from smtp01.primenet.com ([206.165.6.131]:46324 "EHLO
	smtp01.primenet.com") by vger.kernel.org with ESMTP
	id <S129495AbQJ0XwH>; Fri, 27 Oct 2000 19:52:07 -0400
From: Terry Lambert <tlambert@primenet.com>
Message-Id: <200010272308.QAA29462@usr01.primenet.com>
Subject: Re: kqueue microbenchmark results
To: dank@alumni.caltech.edu
Date: Fri, 27 Oct 2000 23:08:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jlemon@flugsvamp.com (Jonathan Lemon),
        gid@cisco.com (Gideon Glass), sim@stormix.com (Simon Kirby),
        chat@FreeBSD.ORG, linux-kernel@vger.kernel.org
In-Reply-To: <39F9AB95.735E26A7@alumni.caltech.edu> from "Dan Kegel" at Oct 27, 2000 09:21:41 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Which is precisely why you need to know where in the chain of events this
> > happened. Otherwise if I see
> > 
> >         'read on fd 5'
> >         'read on fd 5'
> > 
> > How do I know which read is for which fd in the multithreaded case
> 
> That can't happen, can it?  Let's say the following happens:
>    close(5)
>    accept() = 5
>    call kevent() and rebind fd 5
> The 'close(5)' would remove the old fd 5 events.  Therefore,
> any fd 5 events you see returned from kevent are for the new fd 5.
> 
> (I suspect it helps that kevent() is both the only way to
> bind events and the only way to pick them up; makes it harder
> for one thread to sneak a new fd into the event list without
> the thread calling kevent() noticing.)

Strictly speaking, it can happen in two cases:

1)	single acceptor thread, multiple worker threads

2)	multiple anonymous "work to do" threads

In both these cases, the incoming requests from a client are
given to any thread, rather than a particular thread.

In the first case, we can have (id:executer order:event):

1:1:open 5
2:2:read 5
3:4:read 5
2:3:close 5

If thread 2 processes the close event before thread 3 processes
the read event, then when thread 3 attempts procssing, it will
fail.

Technically, this is a group ordering problem in the design of
the software, which should instead queue all events to a dispatch
thread, and the threads should use IPC to serialize processing of
serial events.  This is similar to the problem with async mounted
FS recovery in event of a crash: without ordering guarantees, you
can only get to a "good" state, not necessarily "the one correct
state".

In the second case, we can have:

1:2:read 5
2:1:open 5
3:4:read 5
2:3:close 5

This is just a non-degenerate form of the first case, where we
allow thread 1 and all other threads to be identical, and don't
serialize open state initialization.

The NetWare for UNIX system uses this model.  The benefit is
that all user space threads can be identical.  This means that
I can use either threads or processes, and it won't matter, so
my software can run on older systems that lack "perfect" threads
models, simply by using processes, and putting client state into
shared memory.

In this case, there is no need for inter-thread synchronization;
instead, we must insist that events be dispatched sequentially,
and that the events be processed serially.  This effectively
requires event processing completion notigfication from user
space to kernel space.

In NetWare for UNIX, this was accomplished using a streams MUX
which knew that the NetWare protocol was request-response.  This
also permitted "busy" responses to be turned around in kernel
space, without incurring a kernel-to-user space scheduling
penalty.  It also permitted "piggyback", where an ioctl to the
mux was used to respond, and combined sending a response with
the next read.  This reduced protection domain crossing and the
context switch overhead by 50%.  Finally, the MUX sent requests
to user space in LIFO order.  This approach is called "hot engine
scheduling", in that the last reader in from user space is the
most likely to have its pages in core, so as to not need swapping
to handle the next request.

I was architect of much of the process model discussed above; as
you can see, there are some significant performance wins to be
had by building the right interfaces, and putting the code on
the right side of the user/kernel boundary.

In any case, the answer is that you can not assume that the only
correct way to solve a problem like event inversion is serialization
of events in user space (or kernel space).  This is not strictly a
"threaded application implementation" issue, and it is not strictly
a kernel serialization of event delivery issue.

Another case, which NetWare did not handle, is that of rejected
authentication.  Even if you went with the first model, and forced
your programmers to use expensive inter-thread synchronization, or
worse, bound each client to a single thread in the server, thus
rendering the system likely to have skewed thread load, getting
worse the longer the connection was up, you would still have the
problem of rejected authentication.  A client might attempt to
send authentication followed by commands in the same packet series,
without waiting for an explicit ACK after each one (i.e. it might
attempt to implement a sliding window over a virtual circuit), and
the system on the other end might dilligently queue the events,
only to have the authentication be rejected, but with packets
queued already to user space for processing, assuming serialization
in user space.  You would then need a much more complex mechanism,
to allow you to invalidate an already queued event to another
thread, which you don't know about in your thread, before you
release the interlock.  Otherwise the client may get responses
without a valid authentication.

You need look no further than LDAPv3 for an example of a protocol
where this is possible (assuming X.509 certificate based SASL
authentication, where authentication is not challenge-response,
but where it consists solely of presenting ones certificate).


When considering this API, you have to consider more than just
the programming models you think are "right", you have to
consider all of the that are possible.

All in all, this is an interesting discussion.  8-).


					Terry Lambert
					terry@lambert.org
---
Any opinions in this posting are my own and not those of my present
or previous employers.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
