Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265636AbSKTDjQ>; Tue, 19 Nov 2002 22:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbSKTDjQ>; Tue, 19 Nov 2002 22:39:16 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:57734 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265636AbSKTDjN>; Tue, 19 Nov 2002 22:39:13 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 19 Nov 2002 19:46:44 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Edgar Toernig <froese@gmx.de>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <20021120030919.GA9007@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0211191939430.1107-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Jamie Lokier wrote:

> I have a question about:
>
> > struct epoll_fd {
> > 	int fd;
> > 	unsigned short events;
> > 	unsigned short revents;
> > 	__uint64_t obj;
> > };
>
> What value does the `fd' field have when a file descriptor being
> polled has been renumbered (by dup/close or dup2/close or
> fcntl(F_DUPFD)/close or passing through a unix domain socket)?
>
> If we are honest, the `obj' field is absolutely essential as its the
> only value which uniquely identifies the file descriptor if you have
> done anything unusual with the fds.
>
> The `fd' field, on the other hand, is not guaranteed to correspond
> with the correct file descriptor number.  So.... perhaps the structure
> should contain an `obj' field and _no_ `fd' field?
>
> This doesn't affect applications.  Those which use `obj' for something
> interesting (i.e. a pointer) will have the `fd' value stored in the
> pointed-to data structure, while simple applications can just store
> the original `fd' value in `obj' in the first place.

Even if I agree with you here, this will make the API asymmetrical. We
will have :

struct epoll_fd {
	unsigned short events;
	unsigned short revents;
	__uint64_t obj;
};


int epoll_ctl(int epfd, int op, int fd, struct epoll_fd *pfd);

Where the "fd" is used only for EPOLL_CTL_ADD, and "obj" for EPOLL_CTL_DEL
and EPOLL_CTL_MOD.




> > It'll be possible to add epfd1 inside epfd2, not epfd1 inside epfd1.
>
> Beware of overflowing the kernel stack.  If epfd4 becomes readable,
> and wakes up epfd3, which wakes up epfd2, which wakes up epfd1...  If
> that is implemented recursively than I can write malicious code which
> will crash the kernel.  Note that this isn't a cycle.  It's possible
> to code the wakeups so this cannot happen but still have the expected
> behaviour.
>
> A circular arrangement should be fine, if silly.  The semantics are
> quite logical and don't require special cases: epfd2 becoming readable
> will trigger epfd1 to become readable if it isn't already.  If you
> make a cycle, that's silly but still behaves as you'd expect.  If
> epfd1 becomes readable, it wakes up epfd1...  which is already
> readable so nothing further happens.  Similarly with larger cycles.
> Assuming you've avoided stack overflow for acyclic graphs, there won't
> be any problem with cyclic ones.

This is a problem with the new callback'd wake_up(). I'd be tempted to not
permit epoll fd inclusion inside other epoll fds.




- Davide


