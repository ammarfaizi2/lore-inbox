Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267623AbSKTDBe>; Tue, 19 Nov 2002 22:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267624AbSKTDBe>; Tue, 19 Nov 2002 22:01:34 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:28807 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267623AbSKTDBd>;
	Tue, 19 Nov 2002 22:01:33 -0500
Date: Wed, 20 Nov 2002 03:09:19 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Edgar Toernig <froese@gmx.de>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021120030919.GA9007@bjl1.asuk.net>
References: <3DD9CDB2.2075CCB4@gmx.de> <Pine.LNX.4.44.0211191721350.1918-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211191721350.1918-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question about:

> struct epoll_fd {
> 	int fd;
> 	unsigned short events;
> 	unsigned short revents;
> 	__uint64_t obj;
> };

What value does the `fd' field have when a file descriptor being
polled has been renumbered (by dup/close or dup2/close or
fcntl(F_DUPFD)/close or passing through a unix domain socket)?

If we are honest, the `obj' field is absolutely essential as its the
only value which uniquely identifies the file descriptor if you have
done anything unusual with the fds.

The `fd' field, on the other hand, is not guaranteed to correspond
with the correct file descriptor number.  So.... perhaps the structure
should contain an `obj' field and _no_ `fd' field?

This doesn't affect applications.  Those which use `obj' for something
interesting (i.e. a pointer) will have the `fd' value stored in the
pointed-to data structure, while simple applications can just store
the original `fd' value in `obj' in the first place.

> > And what happens then?  Will the set refers to the fds from the sender
> > process or of fds of the receiving process (which may not even have
> > all those fds open)?
> 
> Uhm !? It'll refer to files opened on the other process. To handle this
> correctly we should prevent an epoll file to be passed with SCM_RIGHTS in
> net/core/scm.c. I mean, no catastrophic things should happen, only the
> interface won't work correctly. I don't know if the extra handling code is
> worth, but we should definitely put this inside epoll(2).

See above - same problem occurs with dup() and variants.  The problem
is that epoll is really reporting events on a file*, and the mapping
back to fd is not always meaningful.

SCM_RIGHTS is just one of the ways to renumber fds, and disallowing it
won't fix the exact same problem caused by dup().  Thus SCM_RIGHTS
should be allowed because there is no reason to disallow it - and it
is actually useful for some kinds of server implementation.

> > Hehe, sure.  But could become tricky: someone may build a circular chain
> > of epoll-fd-sets.
> 
> It'll be possible to add epfd1 inside epfd2, not epfd1 inside epfd1.

Beware of overflowing the kernel stack.  If epfd4 becomes readable,
and wakes up epfd3, which wakes up epfd2, which wakes up epfd1...  If
that is implemented recursively than I can write malicious code which
will crash the kernel.  Note that this isn't a cycle.  It's possible
to code the wakeups so this cannot happen but still have the expected
behaviour.

A circular arrangement should be fine, if silly.  The semantics are
quite logical and don't require special cases: epfd2 becoming readable
will trigger epfd1 to become readable if it isn't already.  If you
make a cycle, that's silly but still behaves as you'd expect.  If
epfd1 becomes readable, it wakes up epfd1...  which is already
readable so nothing further happens.  Similarly with larger cycles.
Assuming you've avoided stack overflow for acyclic graphs, there won't
be any problem with cyclic ones.

-- Jamie
