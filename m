Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265775AbSKAUjm>; Fri, 1 Nov 2002 15:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265776AbSKAUjm>; Fri, 1 Nov 2002 15:39:42 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:34742 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265775AbSKAUjl>;
	Fri, 1 Nov 2002 15:39:41 -0500
Date: Fri, 1 Nov 2002 20:45:42 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
Message-ID: <20021101204542.GA1780@bjl1.asuk.net>
References: <20021031230215.GA29671@bjl1.asuk.net> <Pine.LNX.4.44.0210311642300.1562-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210311642300.1562-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> > In other words, add another op to sys_futex() called FUTEX_EPOLL which
> > directly registers the futex on an epoll interest list, and let epoll
> > report those events as futex events.
> 
> Jamie, the futex support can be easily done with one line of code patch. I
> still prefer the one-to-one mapping between futexes and files.

I forgot something important: futex notifcations must be _exactly
counted_ for some uses of futexes.  It's all very subtle, but there's
an example in Rusty's futex library where a token is passed to one of
the waiters, and waiters are queued up behind each other in the order
they started waiting.  (See futex_up_fair() in usersem.h).  You need
this to prevent starvation, with Alan's example of waiting for
multiple futexes being a particularly nasty case.

Because of this, and the way your one-liner works, I think* that a
multi-threaded program will need to allocate one fd per waiter to
guarantee the counter - not one fd per waited-upon futex.  So when
1000 threads are waiting on some global mutex (as happens), they'll
need an fd each - they can't share one.

  * - If I'm wrong about this, please someone correct me.

Consequently, fds will need to be allocated when a thread wants to
wait, instead of lazily once per contended futex - hence a higher rate
of allocations and deallocations.

The fixes for this are twofold:

    1. You must change file_send_notify() so that it takes a count which
       limits the number of notifications (like FUTEX_WAKE), and returns
       the number of notifications sent.

    2. The futex's queue of waiters must contain the epoll waiters _and_
       waitqueue waiters, in the order that they started waiting.  It's
       not enough to wake the epoll waiters first, and if any
       notifications are left, wake the others, nor vice versa.

Futex epolls are a bit fiddly.

-- Jamie
