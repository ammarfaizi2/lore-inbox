Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270292AbTGMQsT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270293AbTGMQsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:48:18 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:62853 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270292AbTGMQsD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:48:03 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 13 Jul 2003 09:55:23 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
In-Reply-To: <20030713131210.GA19132@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307130932300.14680@bigblue.dev.mcafeelabs.com>
References: <20030712181654.GB15643@srv.foo21.com> <20030712194432.GE10450@mail.jlokier.co.uk>
 <20030712205114.GC15643@srv.foo21.com> <20030713131210.GA19132@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003, Jamie Lokier wrote:

> Eric Varsanyi wrote:
> > > Well then, use epoll's level-triggered mode.  It's quite easy - it's
> > > the default now. :)
> >
> > The problem with all the level triggered schemes (poll, select, epoll w/o
> > EPOLLET) is that they call every driver and poll status for every call into
> > the kernel. This appeared to be killing my app's performance and I verified
> > by writing some simple micro benchmarks.
>
> OH! :-O
>
> Level-triggered epoll_wait() time _should_ be scalable - proportional
> to the number of ready events, not the number of listening events.  If
> this is not the case then it's a bug in epoll.

Jamie, he is talking about select here.


> Reading the code in eventpoll.c et al, I think that some time will
> be taken for fds that are transitioning on events which you're not
> interested in.  Notably, each time a TCP segment is sent and
> acknowledged by the other end, poll-waiters are woken, your task will
> be woken and do some work in epoll_wait(), but no events are returned
> if you are only listening for read availability.
>
> I'm not 100% sure of this, but tracing through
>
>     skb->destructor
>     -> sock_wfree()
>     -> tcp_write_space()
>     -> wake_up_interruptible()
>     -> ep_poll_callback()
>
> it looks as though _every_ TCP ACK you receive will cause epoll to wake up
> a task which is interested in _any_ socket events, but then in
>
>     <context switch>
>     ep_poll()
>     -> ep_events_transfer()
>     -> ep_send_events()
>
> no events are transferred, so ep_poll() will loop and try again.  This
> is quite unfortunate if true, as many of the apps which need to scale
> write a lot of segments without receiving very much.

That's true, it is the beauty of the poll hook ;) I said this a long time
ago. It is addressable by a wake_up_mask() and some code all around. I did
not see (as long as other didn't) any performance impact bacause of this,
with throughput that remained steady flat under any ratio of hot/cold fds.
Since it is easily addressable and will not require an API change, I'd
rather wait for someone to report a real (or even unreal) load that makes
epoll to not flat-scale.



- Davide

