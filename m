Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbTFIWzp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 18:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTFIWzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 18:55:45 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:30385 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262257AbTFIWzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 18:55:42 -0400
To: "David Schwartz" <davids@webmaster.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: select for UNIX sockets?
References: <MDEHLPKNGKAHNMBLJOLKOEKFDIAA.davids@webmaster.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 10 Jun 2003 00:24:17 +0200
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKOEKFDIAA.davids@webmaster.com>
Message-ID: <m3isredh4e.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Schwartz" <davids@webmaster.com> writes:

> 	For the last time, there is no socket queue. You wouldn't want there
> to be
> one.

Sure. No queue. Of course.

And these are only misleading names - net/unix/af_unix.c:
static int unix_dgram_sendmsg(struct kiocb *kiocb, struct socket *sock,
                              struct msghdr *msg, int len)
{
...

       if (unix_peer(other) != sk &&
            skb_queue_len(&other->receive_queue) > other->max_ack_backlog) {
 
and then

        skb_queue_tail(&other->receive_queue, skb);
        unix_state_runlock(other);
        other->data_ready(other, len);
        sock_put(other);

Right?

> 	Consider a UDP application that is sending packets to two
> destinations, one
> over a 56Kbps serial link running PPP and one over gigabit Ethernet. If
> there were a socket send queue, the packets going over the 56Kbps serial
> link would block the packets going over the gigabit Ethernet.

First, PPP and Ethernet use IP/UDP and not local UNIX sockets.
Second, I hope you don't want to tell me PPP and Ethernet have no
device queues, do you? Sure there are "virtual" devices with no queue,
but that's another story.
Have you checked what the above scenario would do? I guess the PPP would
really limit the rate if you used only one socket.

Having no per-sender socket queue for UDP/IP is totally irrelevant here.

> > But if select() on sockets is illegal, should we make it return -Esth
> > instead of success. Certainly, we should get rid of invalid kernel code,
> > right?
> 
> 	No, it is legal, you are just misusing it. If you don't want your
> socket
> operations to ever block, use non-blocking socket operations. If you use
> UDP, or another connectionless protocol, you should understand that *you*
> are responsible for transmit pacing.

I'm not talking about I/O operation, the problem is in select().
Tell me - how can I use select() with UNIX local sockets (wrt write
descriptors) and it's effectively not a NOP?

> 	Such as where the packet you send is actually *going*.

It's going to another local socket, of course. man bind/connect and see
a strace log I've posted. The kernel know this very well.

> 	I guess I'm not getting through. The fact is, you don't have the
> guarantee
> that you think you have.

I don't want a guarantee. I want the select() doing what it has to do.
I.e. checking if the receiving queue (which, of course, does not exist),
connected with connect() first, has a room for a datagram. Unconnected
sockets can be dealt with later.
I see it's me not getting through - do you want select() (wrt write
descriptors) on UNIX datagram sockets effectively a NOP?

The question if send/sendto/etc() will actually block is, of course,
another matter. For example, the (nonexistent) queue could be filled
by another process between my calls to select() and send(). I have no
problem with send() blocking but I want select() to check if the
connected socket could accept anything at all at the time select()
is called (and wait for such condition/timeout otherwise).

> I'm giving you examples to show you why you don't
> have that guarantee. You argue that the examples don't apply to your
> specific case.

Sure, UDP/IP has nothing to do with UNIX sockets.

> I'm not saying they do. I'm saying that because there are
> unavoidable cases where what you're trying to do won't work, then what
> you're trying to do is not guaranteed to work in all cases and you shouldn't
> try to do it.

What *I* should do is really unimportant here. What the *kernel* should do
is all that now matters.

> 	The kernel does not remember that you got a write hit on 'select'
> and use
> it to somehow ensure that your next 'write' doesn't block. A 'write' hit
> from 'select' is just a hint and not an absolute guarantee that whatever
> 'write' operation you happen to choose to do won't block.

A "write" hit from select() is not a hit - it's exactly nothing and this
is the problem.
Have you at least looked at the actual code? unix_dgram_sendmsg() and
datagram_poll()?
-- 
Krzysztof Halasa
Network Administrator
