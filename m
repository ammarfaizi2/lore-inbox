Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbTFIC5r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 22:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTFIC5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 22:57:47 -0400
Received: from mail.webmaster.com ([216.152.64.131]:37020 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261428AbTFIC5p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 22:57:45 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>, <linux-kernel@vger.kernel.org>
Subject: RE: select for UNIX sockets?
Date: Sun, 8 Jun 2003 20:11:20 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEHBDIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <m3of19h1tx.fsf@defiant.pm.waw.pl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "David Schwartz" <davids@webmaster.com> writes:

> > 	You are doing something wrong. You are using 'select' along with
> > blocking
> > I/O operations. You can't make bricks without clay. If you don't want to
> > block, you must use non-blocking socket operations. End of story.

> There is a little problem here. Do you see any place for select() here?
> There isn't any.

	For unconnected UDP sockets, I see no place for 'select'ing for write. No.

> If you have a working select(), you can use (blocking or non-blocking)
> I/O functions a get a) low latency b) small CPU overhead.
> If you want to use non-blocking I/O, either with broken select() or
> without it at all, you get either a) high latency, or b) high CPU
> overhead.

	It is fundamental that an application that sends UDP packets must control
the transmit timing. That's just the way it is with UDP.

> > 	Just because 'select' indicates a write hit, you are not assured
> > that some
> > particular write at a later time will not block. Past
> > performance does not
> > guarantee future results.

> The problem is select() on UNIX datagram sockets returns immediately,
> and thus it could be well substituted by a NOP. There isn't any
> "performance".

	Right. It's silly to 'select' on an unconnected UDP datagram socket. There
is no single defined buffer whose fullness or emptiness can be the subject
of the 'select'ing. It's not like TCP where there's a send queue and the
network stack is responsible for transmit pacing. With UDP, the application
is responsible for transmit pacing.

> > 	Suppose, for example, a machine has two network interfaces.
> One is very
> > busy, queue full, and one is totally idle, queue empty. What do
> you think
> > 'select' for write on an unconnected UDP socket should do? If you say it
> > should block, then it can block forever even if there's plenty of buffer
> > space on the network card you were going to send to. So, it
> can't block, it
> > must indicate writability.

> That's a little different problem, and a datagram will be transmitted by
> this busy interface at last (while you will never send a datagram
> if nobody
> is reading the socket).

> Hoverer, select() doesn't work on connected sockets either (I missed
> the fact the example program doesn't connect at first, but it's
> unimportant here).

	It really doesn't matter. UDP applications have to control the transmit
pacing at application level. There is absolutely no way for the kernel to
know whether the path to the recipient is congested or not.

> > 	You have any number of sane choices. My suggestion is that
> > you make the
> > socket non-blocking and treat an EWOULDBLOCK return as equivalent to
> > success. You can additionally take it as a hint that the packet
> > will be as
> > if it was dropped.

> You essentially transform a code such as:
> while () {
>         select();
>         blocking_send();
> }
>
> into:
>
> while() {
>         non_blocking_send();
> }
>
> Not very CPU-friendly :-(

	No, no no. This is not how you write UDP applications. If you're sending
UDP, you must have a transmit scheduler somewhere.

> Having working select() on at least connected sockets is a must.

	The kernel can't tell you when to send because that depends upon factors
that are remote. The application *MUST* schedule its transmissions. There's
no two ways about it.

	Yes, it would be nice of the kernel helped more. But the application has to
deal with remote packet loss as well. It HAS TO decide when to send the
packet and can't rely upon the availability or unavailability of local
resources to mean anything with regard to the connection as a whole.

	DS


