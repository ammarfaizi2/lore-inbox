Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262404AbSJaPBT>; Thu, 31 Oct 2002 10:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262408AbSJaPBT>; Thu, 31 Oct 2002 10:01:19 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:56240 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262404AbSJaPBR>;
	Thu, 31 Oct 2002 10:01:17 -0500
Date: Thu, 31 Oct 2002 15:07:01 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021031150701.GA27801@bjl1.asuk.net>
References: <20021031005259.GA25651@bjl1.asuk.net> <Pine.LNX.4.44.0210301924190.1452-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210301924190.1452-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> [long description of ready lists]

Davide, you have exactly explained ready lists, which I assume we'd
already agreed on (cf. beer), and completely missed the point about
deferring the call to epoll_ctl().  You haven't mentioned that at all
your description.

Consider cacheing http proxy server.  Let's say 25% of the requests to
a proxy server are _not_ using pipelining.  Then you can save 25% of
the calls to epoll_ctl() if network conditions are favourable.

> Jamie I don't force you to call read/write soon.

You do if I try to optimise by deferring the call to epoll_ctl().
Let's see how my user space optimisation is affected in your description.

> Your state machine will
> have a state 0, from where everything starts. Let's say that this server
> is an SMTP server and that supports PIPELINING. When a client connect (
> you accept ) you will basically have your acceptor routine that puts the
> fd for the new connection inside your list of ready-fds. Such list will
> contain connection status, state machine state and a callback at the bare
> bone. The whenever you feel it appropriate you pop the fd from the ready
> list and you call the associated callback. That for state 0 will have
> encoded "send SMTP welcome message" to the client. The socket write buffer
> will be empty and you write() will return != EAGAIN. So you keep your fd
> inside your ready list. Having a ready list enables you to handle
> priorities, fairness, etc... Having successfully sent the welcome string
> will move you to the next state, state 1. Whenever you'll find it
> appropriate, you'll call again the callback associated with the file
> descriptor, that for state 1 will have encoded "read SMTP command". Now
> suppose that the SMTP client is lazy and you have nothing in the input
> buffer ( or you partially read the SMTP command ). The read() will return
> EAGAIN, you remain in state 1 and you remove the fd from your ready list.

At this point, I would call epoll_ctl().  Note, I do _not_ call
epoll_ctl() after accept(), because that is a waste of time.  It is
better to defer it because sometimes it is not needed at all.

> This guy is _ready_ to generate an event. One of thenext time you'll call
> epoll_wait(2) you'll find our famous fd ready to be used.

Most of the time this works, but there's a race condition: after I saw
EAGAIN and before I called epoll_ctl(), the state might have changed.
So I must call read() after epoll_ctl(), even though it is 99.99%
likely to return EAGAIN.

Here is the system call sequence that I end up executing:

	- read() = nbytes
	- read() = EGAIN
	- epoll_ctl()		// Called first time we see EAGAIN,
				// if we will want to read more.
	- read() = EGAIN

The final read is 99.99% likely to return EGAIN, and could be
eliminated if epoll_ctl() had an option to test the condition.

> Now, this one, that is a typical state machine implementation
> can be _trivially_ implemented with epoll, and I don't see how adding an
> initial event might help in this design. The other even more trivial
> implementation using coroutines shows its semplicitly in a pretty clear
> way.

That's because it doesn't help in that design.  It helps in a
different (faster in some scenarios ;) design.

> You don't really want to use blocking files with
> an edge triggered event API.

Agreed, it is rarely useful, but I felt your description ("event after
AGAIN") was technically incorrect.  Of course it would be ok to
_specify_ the API as only giving defined behaviour for non-blocking I/O.

> >
> > 	an event is generated on every "would-block" -> "ready" transition.
> > 	after fd registration, you must treat the fd as "ready".
> >
> > The proposed rule is this:
> >
> > 	an event is generated on every "would-block" -> "ready" transition.
> > 	after fd registration, you may treat the fd as in any state you like.
> >
> > The proposed rule is better because it permits better optimisations in
> > user space, as explained earlier.  (If you _really_ want to avoid the
> > call to ->poll() when user space doesn't care, make that a flag
> > argument to epoll_ctl()).
> 
> I still prefer 1) Jamie, besides the system call cost ( that is not always
> a cost, see soon ready ops ),

Do you avoid the cost of epoll_ctl() per new fd?

> there's the fact of making the user to follow a behavior
> pattern. That point 2) leaves uncertain.

That's the point :-) Flexibility is _good_.  It means that somebody
can implement a technique that you haven't thought of.

With 2) the _programmer_ (let's assume some level of understanding)
can use the exact application code that you offered.  It will work fine.

However if they're feeling clever, like me, they can optimise further.

I would suggest, though, to simply provide both options: EP_CTL_ADD
and EP_CTL_ADD_AND_TEST.  That's so explicit that nobody can be
confused!

> Show me with real code ( possibly not 25000 lines :) )
> where you get stuck w/out having the initial event and if it makes sense
> and there's no clean way to solve it in user space, I'll seriously
> consider your ( and John ) proposal.

Davide, I don't write buggy code deliberately.  My code would not get
stuck using present epoll.  Neither APIs 1) nor 2) have a bug, but
version 1) is slower with some kinds of state machine.

(Don't confuse me with the person who said your API is buggy -- it is
_not_ buggy, it's just not as flexible as it should be).

I can write code that shows the optimisation if that would make it
clearer.

-- Jamie
