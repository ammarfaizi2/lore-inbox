Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbSJaSyL>; Thu, 31 Oct 2002 13:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSJaSyL>; Thu, 31 Oct 2002 13:54:11 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:17033 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262875AbSJaSyH>; Thu, 31 Oct 2002 13:54:07 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 31 Oct 2002 11:10:07 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021031150701.GA27801@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0210311043380.1562-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Jamie Lokier wrote:

> Davide, you have exactly explained ready lists, which I assume we'd
> already agreed on (cf. beer), and completely missed the point about
> deferring the call to epoll_ctl().  You haven't mentioned that at all
> your description.
>
> Consider cacheing http proxy server.  Let's say 25% of the requests to
> a proxy server are _not_ using pipelining.  Then you can save 25% of
> the calls to epoll_ctl() if network conditions are favourable.
>
> You do if I try to optimise by deferring the call to epoll_ctl().
> Let's see how my user space optimisation is affected in your description.
>
> At this point, I would call epoll_ctl().  Note, I do _not_ call
> epoll_ctl() after accept(), because that is a waste of time.  It is
> better to defer it because sometimes it is not needed at all.
>
> > This guy is _ready_ to generate an event. One of thenext time you'll call
> > epoll_wait(2) you'll find our famous fd ready to be used.
>
> Most of the time this works, but there's a race condition: after I saw
> EAGAIN and before I called epoll_ctl(), the state might have changed.
> So I must call read() after epoll_ctl(), even though it is 99.99%
> likely to return EAGAIN.
>
> Here is the system call sequence that I end up executing:
>
> 	- read() = nbytes
> 	- read() = EGAIN
> 	- epoll_ctl()		// Called first time we see EAGAIN,
> 				// if we will want to read more.
> 	- read() = EGAIN
>
> The final read is 99.99% likely to return EGAIN, and could be
> eliminated if epoll_ctl() had an option to test the condition.
>
> Do you avoid the cost of epoll_ctl() per new fd?

Jamie, the cost of epoll_ctl(2) is minimal/zero compared with the average
life of a connection. Also it might be done once at fd "creation" and one
at fd "removal". It's not inside an high frequency loop like epoll_wait(2).
Believe me, or ... do not believe me and show me a little performance data
that shows up this performance degradation due a soonish epoll_ctl(2). And
Jamie, if you really really want to use such pattern ( delaying the fd
registration, that IMHO does not help you in getting any performance boost )
you can still do it in user space ( poll() timeout 0 after epoll_ctl(2) ).
Jamie, I'm _really_ willing to be contradicted with performance data here.


> I would suggest, though, to simply provide both options: EP_CTL_ADD
> and EP_CTL_ADD_AND_TEST.  That's so explicit that nobody can be
> confused!

The EP_CTL_ADD_AND_TEST would do the poll() timeout 0 trick in kernel
space. Is it fast done in kernel ? Sure, you can measure something at
rates of 500000 of registration per second. Even here Jamie, I'm willing
to be contradicted by performance data. You're trying to optimize
something that is not inside an high frequency loop, and it's going to
give you any measurable improvement IMHO.




- Davide


