Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTFICwV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 22:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbTFICwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 22:52:21 -0400
Received: from mail.webmaster.com ([216.152.64.131]:28060 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S261245AbTFICwT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 22:52:19 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Chris Friesen" <cfriesen@nortelnetworks.com>
Cc: "MarKol" <markol4@wp.pl>, <linux-kernel@vger.kernel.org>
Subject: RE: select for UNIX sockets?
Date: Sun, 8 Jun 2003 20:05:52 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEHBDIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <3EE2B878.6050809@nortelnetworks.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> David Schwartz wrote:
>
> > Yu are doing something wrong. You are using 'select' along
> > with blocking
> > I/O operations. You can't make bricks without clay. If you don't want to
> > block, you must use non-blocking socket operations. End of story.

> That's funny, I was under the impression that the whole point of
> using select()
> was to enable the use of blocking I/O.

	This is a very common misconception. No, the point of 'select' is to hint
to you when you should attempt a non-blocking socket operation. It has never
been the case that 'select' guaranteed that a following blocking operation
wouldn't block.

> If you are on a
> uniprocessor system, in
> a single thread, and select() says that a socket is writeable,
> then I had darn
> well better be able to write to that socket!

	No. A 'write' hit from 'select' cannot guarantee that any arbitrary 'write'
won't block unless the following 'write' is non-blocking.

	Consider a TCP connection. I get a 'write' hit, and then I call 'write' to
send 250Kb of data. Do you seriously want to argue that the kernel must
somehow handle that 250Kb without blocking?

> Sure, this gets more complicated when multiprocessing or
> multithreading, but the
> test program does neither of these.

	No, it's more complicated in many situations. Suppose the kernel says a
connected UDP socket won't block because the network interface the packet
would go out is unused. Before you can call 'send', the interface goes down
and the packet now has to take a congested network interface. The 'write'
will block.

> >  Just because 'select' indicates a write hit, you are not
> > assured that some
> > particular write at a later time will not block. Past
> > performance does not
> > guarantee future results.

> Think about the whole reason for select()'s existance. If a
> single-threaded app
> calls select() and is told a socket is writeable, then a write to
> that socket
> should either immediately succeed or immediately fail (if the
> other socket
> disappeared in between the calls, for instance).

	Sure, but you can't ensure this in all cases unless you set the socket
non-blocking. The kernel can't guarantee the future and it has no way of
knowing that it's important to the application that the following operation
not block unless yuo tell it.

> Now granted I use non-blocking I/O out of paranoia, but even
> there if select()
> says it is writeable and the send call returns EAGAIN then we get
> into a nice
> little infinite loop.

	Only if the application foolishly insists. For UDP, you should treat EAGAIN
as a hint that you're sending too fast. With UDP, the application is
responsible for send timing and can't foist this responsibility on the OS by
misusing 'select'.

> select() should be reliable.

	It cannot be made so without other greater losses. The perfect is the enemy
of the good. Use it as a hint.

	DS


