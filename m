Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbSJaAqx>; Wed, 30 Oct 2002 19:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbSJaAqx>; Wed, 30 Oct 2002 19:46:53 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:51630 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S264992AbSJaAqs>;
	Wed, 30 Oct 2002 19:46:48 -0500
Date: Thu, 31 Oct 2002 00:52:59 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: John Gardiner Myers <jgmyers@netscape.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021031005259.GA25651@bjl1.asuk.net>
References: <20021030230159.GB25231@bjl1.asuk.net> <Pine.LNX.4.44.0210301547170.1405-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210301547170.1405-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> The cost of the test will be basically the cost of a ->poll(), that is
> exactly the same cost of the very first read()/write() that you would do
> by following the current API rule.

No, the cost of ->poll() is somewhat less than read()/write(), because
the latter requires a system call and the former does not.  System
calls are still nowhere near as cheap as function calls.

> > I also agree with criticisms that epoll should test and send an event
> > on registration, but only _if_ the test is cheap.  Nothing to do with
> > correctness (I like the edge semantics as they are), but because
> > delivering one event is so infinitesimally low impact with epoll that
> > it's preferable to doing a single speculative read/write/whatever.
> >
> > Regarding the effectiveness of the optimisation, I'd guess that quite
> > a lot of incoming connections do not come with initial data in the
> > short scheduling time after a SYN (unless it's on a LAN).  I don't
> > know this for sure though.
> 
> Ok Jamie, try to explain me which kind of improvement this first drop will
> bring.

I have thought about an optimal server state machine.  (I presume from
your carefully thought out implementation that you have too).

In a state machine, each fd has some user-space state.  I've already
hinted at how this is used to prevent starvation/livelock on a busy
server, and make service fairer.

I would take that further and _defer_ the epoll_ctl() to register an
fd until the first time I have seen EAGAIN from that fd.  This is
because in some cases, epoll_ctl() would not be needed at all - so we
can remove that overhead, and the system call overhead.

Now you would force me to call read() or write() after the
epoll_ctl(), even though I _know_ the result is always going to be
EAGAIN.  You're forcing me to make an always redundant system call.
But I can't omit it, because that's a race condition.

So, I've thought about the _optimal_ state machine and it's clear that
epoll should test the condition on fd registration - for best
performance.  (Nothing to do with scalability, just raw performance).

> And also, how such first drop would not bring a "confusion" for the
> user, letting him think that he can go sleeping event w/out having first
> received EAGAIN. Isn't it better to say "you wait for events after EAGAIN",
> instead of "you wait for events after EAGAIN but after accept/connect".

Be careful with your rules.  epoll should work with blocking fds too,
if you understand the rules well enough, and fd registration doesn't
have to be done at the same time as accept/connect/pipe.

Your current rule in practice is:

	an event is generated on every "would-block" -> "ready" transition.
	after fd registration, you must treat the fd as "ready".

The proposed rule is this:

	an event is generated on every "would-block" -> "ready" transition.
	after fd registration, you may treat the fd as in any state you like.

The proposed rule is better because it permits better optimisations in
user space, as explained earlier.  (If you _really_ want to avoid the
call to ->poll() when user space doesn't care, make that a flag
argument to epoll_ctl()).

enjoy :)
-- Jamie

