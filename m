Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268419AbTGLUgn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 16:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268427AbTGLUgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 16:36:43 -0400
Received: from ev2.cpe.orbis.net ([209.173.192.122]:48292 "EHLO srv.foo21.com")
	by vger.kernel.org with ESMTP id S268419AbTGLUgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 16:36:35 -0400
Date: Sat, 12 Jul 2003 15:51:14 -0500
From: Eric Varsanyi <e0206@foo21.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Eric Varsanyi <e0206@foo21.com>, linux-kernel@vger.kernel.org,
       davidel@xmailserver.org
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
Message-ID: <20030712205114.GC15643@srv.foo21.com>
References: <20030712181654.GB15643@srv.foo21.com> <20030712194432.GE10450@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712194432.GE10450@mail.jlokier.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In a level triggered world this all just works because the read ready
> > indication is driven back to the app as long as the socket state is half
> > closed. The event driven epoll mechanism folds these two indications
> > together and thus loses one 'edge'.
> 
> Well then, use epoll's level-triggered mode.  It's quite easy - it's
> the default now. :)

The problem with all the level triggered schemes (poll, select, epoll w/o
EPOLLET) is that they call every driver and poll status for every call into
the kernel. This appeared to be killing my app's performance and I verified
by writing some simple micro benchmarks.

I can post the details and code if anyone is interested, the summary is
that on 1 idle FD poll, select, epoll all take about 900ns on a 2.8G P4
(around the overhead of any syscall). With 10 idle FD's (pipes or sockets)
the overhead is around 2.5uSec, at 400fd's (a light load for this app)
we're up to 80uSec per call and the app is spending almost 100% of one
CPU in system mode with even a light tickling of I/O activity on a few
of the fd's.

As we start to scale up to production sized fd sets it gets crazy: around
8000 completely idle fd's the cost is 4ms per syscall. At this point
even a high real load (which gathers lots of I/O per call) doesn't cover the
now very high latency for each trip into the kernel to gather more work.

What was interesting is the response time was non-linear up to around 400-500
fd's, then went steep and linear after that, so you pay much more (maybe due
to some cache effects, I didn't pursue) for each connecting client in a light
load environment.

This is not web traffic, the clients typically connect and sit mostly idle.

> If there's an EOF condition pending after you called read(), and then
> you call epoll_wait(), you _should_ see another EPOLLIN condition
> immediately.
> 
> If you aren't seeing epoll_wait() return with EPOLLIN when there's an
> EOF pending, *and* you haven't set EPOLLET in the event flags, that's
> a bug in epoll.  Is that what you're seeing?

No, I am not asserting there is a problem with epoll in level triggered
mode (I've only used poll and select in level triggered mode, so I can't
say for sure it works either).

-Eric Varsanyi
