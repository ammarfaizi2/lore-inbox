Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbTFJV21 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTFJV1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:27:12 -0400
Received: from mail.webmaster.com ([216.152.64.131]:42748 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S263971AbTFJV0r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 17:26:47 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: select for UNIX sockets?
Date: Tue, 10 Jun 2003 14:40:26 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEDDDJAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <m3isredh4e.fsf@defiant.pm.waw.pl>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "David Schwartz" <davids@webmaster.com> writes:

> > For the last time, there is no socket queue. You wouldn't want there
> > to be
> > one.

> Sure. No queue. Of course.

	Yep.

> And these are only misleading names - net/unix/af_unix.c:
> static int unix_dgram_sendmsg(struct kiocb *kiocb, struct socket *sock,
>                               struct msghdr *msg, int len)
> {
> ...
>
>        if (unix_peer(other) != sk &&
>             skb_queue_len(&other->receive_queue) >
> other->max_ack_backlog) {

	That looks like a *receive* queue to me. We were talking about selecting
for writes, weren't we.

> and then
>
>         skb_queue_tail(&other->receive_queue, skb);
>         unix_state_runlock(other);
>         other->data_ready(other, len);
>         sock_put(other);
>
> Right?

	Looks like another receive queue to me. There is no send queue and you
wouldn't want there to be one.

> > Consider a UDP application that is sending packets to two
> > destinations, one
> > over a 56Kbps serial link running PPP and one over gigabit Ethernet. If
> > there were a socket send queue, the packets going over the 56Kbps serial
> > link would block the packets going over the gigabit Ethernet.

> First, PPP and Ethernet use IP/UDP and not local UNIX sockets.
> Second, I hope you don't want to tell me PPP and Ethernet have no
> device queues, do you? Sure there are "virtual" devices with no queue,
> but that's another story.
> Have you checked what the above scenario would do? I guess the PPP would
> really limit the rate if you used only one socket.

	They have device queues, they have no socket send queues.

> Having no per-sender socket queue for UDP/IP is totally irrelevant here.

	It is relevent. Because when you select for write, you're trying to find
out whether there's space to write to the socket. That would require there
to be something for there to be space in or not to be space in. Whatever you
want to call that (I call it a 'socket send queue', but it doesn't matter)
that queue doesn't exist for UDP and you wouldn't want it to exist.

	With UDP, or any connectionless protocol, the application is ultimately
responsible for transmit pacing. You could argue that it would be nice if
the kernel helped out more than it currently does, but it has no obligation
to do so.

	DS


