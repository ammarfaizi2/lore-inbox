Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbTGMM5h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 08:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbTGMM5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 08:57:37 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:26260 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264448AbTGMM5e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 08:57:34 -0400
Date: Sun, 13 Jul 2003 14:12:10 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Eric Varsanyi <e0206@foo21.com>
Cc: linux-kernel@vger.kernel.org, davidel@xmailserver.org
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
Message-ID: <20030713131210.GA19132@mail.jlokier.co.uk>
References: <20030712181654.GB15643@srv.foo21.com> <20030712194432.GE10450@mail.jlokier.co.uk> <20030712205114.GC15643@srv.foo21.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712205114.GC15643@srv.foo21.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Varsanyi wrote:
> > Well then, use epoll's level-triggered mode.  It's quite easy - it's
> > the default now. :)
> 
> The problem with all the level triggered schemes (poll, select, epoll w/o
> EPOLLET) is that they call every driver and poll status for every call into
> the kernel. This appeared to be killing my app's performance and I verified
> by writing some simple micro benchmarks.

OH! :-O

Level-triggered epoll_wait() time _should_ be scalable - proportional
to the number of ready events, not the number of listening events.  If
this is not the case then it's a bug in epoll.

In principle, you will see a large delay only if you don't handle
those events (e.g. by calling read() on each ready fd), so that they
are still ready.

Reading the code in eventpoll.c et al, I think that some time will
be taken for fds that are transitioning on events which you're not
interested in.  Notably, each time a TCP segment is sent and
acknowledged by the other end, poll-waiters are woken, your task will
be woken and do some work in epoll_wait(), but no events are returned
if you are only listening for read availability.

I'm not 100% sure of this, but tracing through

    skb->destructor
    -> sock_wfree()
    -> tcp_write_space()
    -> wake_up_interruptible()
    -> ep_poll_callback()

it looks as though _every_ TCP ACK you receive will cause epoll to wake up
a task which is interested in _any_ socket events, but then in

    <context switch>
    ep_poll()
    -> ep_events_transfer()
    -> ep_send_events()

no events are transferred, so ep_poll() will loop and try again.  This
is quite unfortunate if true, as many of the apps which need to scale
write a lot of segments without receiving very much.

> As we start to scale up to production sized fd sets it gets crazy: around
> 8000 completely idle fd's the cost is 4ms per syscall. At this point
> even a high real load (which gathers lots of I/O per call) doesn't cover the
> now very high latency for each trip into the kernel to gather more work.

It should only be 4ms per syscall if it's actually returning ~8000
ready events.  If you're listening to 8000 but only, say, 10 are
ready, it should be fast.

> What was interesting is the response time was non-linear up to around 400-500
> fd's, then went steep and linear after that, so you pay much more (maybe due
> to some cache effects, I didn't pursue) for each connecting client in a light
> load environment.

> This is not web traffic, the clients typically connect and sit mostly idle.

Can you post your code?

(Btw, I don't disagree with POLLRDHUP - I think it's a fine idea.  I'd
use it.  It'd be unfortunate if it only worked with some socket types
and was not set by others, though.  Global search and replace POLLHUP
with "POLLHUP | POLLRDHUP" in most setters?  Following that a bit
further, we might as well admit that POLLHUP should be called
POLLWRHUP.)

-- Jamie
