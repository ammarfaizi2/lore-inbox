Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbTETBbU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 21:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbTETBbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 21:31:19 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:52866 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263428AbTETBbN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 21:31:13 -0400
Date: Tue, 20 May 2003 02:44:03 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex API cleanups, futex-api-cleanup-2.5.69-A2
Message-ID: <20030520014403.GA14851@mail.jlokier.co.uk>
References: <20030520010913.3300F2C05E@lists.samba.org> <Pine.LNX.4.55.0305191813240.6565@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0305191813240.6565@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> > In message <20030519233353.GD13706@mail.jlokier.co.uk> you write:
> > > Ingo Molnar wrote:
> > > > FUTEX_FD is an instant DoS, it allows the pinning of one page per file
> > > > descriptor, per thread. With a default limit of 1024 open files per
> > > > thread, and 256 threads (on a sane/conservative setup), this means 1 GB of
> > > > RAM can be pinned down by a normal unprivileged user.
> > >
> > > The correct solution [;)] is EP_FUTEX - allow a futex to be specified
> > > as the source of an epoll event.
> 
> Futexes do support f_op->poll(), isn't it Rusty ? If so, they're supported
> by epoll ...

Yes, they do and it should work (I haven't tried, though).

There is a practical problem when waiting on a futex in multiple
threads using epoll: you need a separate fd per waiter, rather than an
fd per waited-on futex.  This is because some uses of futexes depend
on waiters being woken in the exact order that they were queued.

To get this ordering, every waiter must allocate its own fd.  The only
practical way to do this is allocate the fd just prior to waiting, and
release it afterwards.

As you can imagine, with many threads this implies a lot of fds, which
are in limited supply, and a high rate of allocation and deallocation,
which may be relatively slow.

-- Jamie
