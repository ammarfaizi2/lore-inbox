Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265163AbSJaD7Q>; Wed, 30 Oct 2002 22:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265166AbSJaD7Q>; Wed, 30 Oct 2002 22:59:16 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:48797 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265163AbSJaD7O>; Wed, 30 Oct 2002 22:59:14 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 30 Oct 2002 20:15:08 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021031005259.GA25651@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0210301924190.1452-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Jamie Lokier wrote:

> No, the cost of ->poll() is somewhat less than read()/write(), because
> the latter requires a system call and the former does not.  System
> calls are still nowhere near as cheap as function calls.

Jamie, it's not for the cost, it's that IMHO is useless. And might
generate confusion on the API usage.



> I have thought about an optimal server state machine.  (I presume from
> your carefully thought out implementation that you have too).
>
> In a state machine, each fd has some user-space state.  I've already
> hinted at how this is used to prevent starvation/livelock on a busy
> server, and make service fairer.
>
> I would take that further and _defer_ the epoll_ctl() to register an
> fd until the first time I have seen EAGAIN from that fd.  This is
> because in some cases, epoll_ctl() would not be needed at all - so we
> can remove that overhead, and the system call overhead.
>
> Now you would force me to call read() or write() after the
> epoll_ctl(), even though I _know_ the result is always going to be
> EAGAIN.  You're forcing me to make an always redundant system call.
> But I can't omit it, because that's a race condition.
>
> So, I've thought about the _optimal_ state machine and it's clear that
> epoll should test the condition on fd registration - for best
> performance.  (Nothing to do with scalability, just raw performance).

Jamie I don't force you to call read/write soon. Your state machine will
have a state 0, from where everything starts. Let's say that this server
is an SMTP server and that supports PIPELINING. When a client connect (
you accept ) you will basically have your acceptor routine that puts the
fd for the new connection inside your list of ready-fds. Such list will
contain connection status, state machine state and a callback at the bare
bone. The whenever you feel it appropriate you pop the fd from the ready
list and you call the associated callback. That for state 0 will have
encoded "send SMTP welcome message" to the client. The socket write buffer
will be empty and you write() will return != EAGAIN. So you keep your fd
inside your ready list. Having a ready list enables you to handle
priorities, fairness, etc... Having successfully sent the welcome string
will move you to the next state, state 1. Whenever you'll find it
appropriate, you'll call again the callback associated with the file
descriptor, that for state 1 will have encoded "read SMTP command". Now
suppose that the SMTP client is lazy and you have nothing in the input
buffer ( or you partially read the SMTP command ). The read() will return
EAGAIN, you remain in state 1 and you remove the fd from your ready list.
This guy is _ready_ to generate an event. One of thenext time you'll call
epoll_wait(2) you'll find our famous fd ready to be used. You push it in
the ready list, and it's up to you, based on your fairness policies, to
use it soon or not. <b> The important thing is that you keep it in your
ready list and you do not go wait for it </b> Now the PIPELINING stuff
makes it worth to have your ready-fds list to apply fairness rules among
your clients. The above pattern repeats by moving your state machine among
your states, until finally, you reach the final state where you drop the
connection. Now, this one, that is a typical state machine implementation
can be _trivially_ implemented with epoll, and I don't see how adding an
initial event might help in this design. The other even more trivial
implementation using coroutines shows its semplicitly in a pretty clear
way.



> Be careful with your rules.  epoll should work with blocking fds too,
> if you understand the rules well enough, and fd registration doesn't
> have to be done at the same time as accept/connect/pipe.

Obviously you can register the fd whenever you want. I would take _a_lot_
of care using it with blocking files. Not because it will crash or
something like this but because you might stall you app on a reat/write
operation. Suppose you received your event, and you have 2000 bytes in
your input buffer for example. You start reading the data with a blocking
file and when the data is over you'll be waiting on tha system call, that
is definitely what you want to do in a 1:N ( one task, N files )
application architecture. You don't really want to use blocking files with
an edge triggered event API.



> Your current rule in practice is:
>
> 	an event is generated on every "would-block" -> "ready" transition.
> 	after fd registration, you must treat the fd as "ready".
>
> The proposed rule is this:
>
> 	an event is generated on every "would-block" -> "ready" transition.
> 	after fd registration, you may treat the fd as in any state you like.
>
> The proposed rule is better because it permits better optimisations in
> user space, as explained earlier.  (If you _really_ want to avoid the
> call to ->poll() when user space doesn't care, make that a flag
> argument to epoll_ctl()).

I still prefer 1) Jamie, besides the system call cost ( that is not always
a cost, see soon ready ops ), there's the fact of making the user to
follow a behavior pattern. That point 2) leaves uncertain. Now, I guess
that we will spend a lot of time arguing and talking about nothing. Let's
go to the code. Show me with real code ( possibly not 25000 lines :) )
where you get stuck w/out having the initial event and if it makes sense
and there's no clean way to solve it in user space, I'll seriously
consider your ( and John ) proposal.




- Davide


