Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbTFGXzX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 19:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbTFGXzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 19:55:23 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:22657 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S264047AbTFGXzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 19:55:21 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: select for UNIX sockets?
References: <MDEHLPKNGKAHNMBLJOLKMEOBDHAA.davids@webmaster.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 08 Jun 2003 02:04:10 +0200
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEOBDHAA.davids@webmaster.com>
Message-ID: <m3of19h1tx.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Schwartz" <davids@webmaster.com> writes:

> 	You are doing something wrong. You are using 'select' along with
> blocking
> I/O operations. You can't make bricks without clay. If you don't want to
> block, you must use non-blocking socket operations. End of story.

There is a little problem here. Do you see any place for select() here?
There isn't any.

If you have a working select(), you can use (blocking or non-blocking)
I/O functions a get a) low latency b) small CPU overhead.
If you want to use non-blocking I/O, either with broken select() or
without it at all, you get either a) high latency, or b) high CPU overhead.

> 	Just because 'select' indicates a write hit, you are not assured
> that some
> particular write at a later time will not block. Past performance does not
> guarantee future results.

The problem is select() on UNIX datagram sockets returns immediately,
and thus it could be well substituted by a NOP. There isn't any
"performance".

> 	Suppose, for example, a machine has two network interfaces. One is very
> busy, queue full, and one is totally idle, queue empty. What do you think
> 'select' for write on an unconnected UDP socket should do? If you say it
> should block, then it can block forever even if there's plenty of buffer
> space on the network card you were going to send to. So, it can't block, it
> must indicate writability.

That's a little different problem, and a datagram will be transmitted by
this busy interface at last (while you will never send a datagram if nobody
is reading the socket).

Hoverer, select() doesn't work on connected sockets either (I missed
the fact the example program doesn't connect at first, but it's
unimportant here).

> 	You have any number of sane choices. My suggestion is that you make the
> socket non-blocking and treat an EWOULDBLOCK return as equivalent to
> success. You can additionally take it as a hint that the packet will be as
> if it was dropped.

You essentially transform a code such as:
while () {
        select();
        blocking_send();
}

into:

while() {
        non_blocking_send();
}

Not very CPU-friendly :-(

Having working select() on at least connected sockets is a must.

intrepid:/tmp$ strace -f ./test 2>&1 |egrep 'socket|bind|connect|send|recv'

[pid  1051] socket(PF_UNIX, SOCK_DGRAM, 0) = 3
[pid  1051] bind(3, {sa_family=AF_UNIX, path="/tmp/test"}, 11) = 0
[pid  1050] socket(PF_UNIX, SOCK_DGRAM, 0) = 3
[pid  1050] connect(3, {sa_family=AF_UNIX, path="/tmp/test"}, 11) = 0
[pid  1050] send(3, "\1", 1, 0)         = 1
[pid  1050] send(3, "\1", 1, 0)         = 1
[pid  1050] send(3, "\1", 1, 0)         = 1
[pid  1050] send(3, "\1", 1, 0)         = 1
[pid  1050] send(3, "\1", 1, 0)         = 1
[pid  1050] send(3, "\1", 1, 0)         = 1
[pid  1050] send(3, "\1", 1, 0)         = 1
[pid  1050] send(3, "\1", 1, 0)         = 1
[pid  1050] send(3, "\1", 1, 0)         = 1
[pid  1050] send(3, "\1", 1, 0)         = 1
[pid  1050] send(3, "\1", 1, 0)         = 1 <<<<< the last packet queued
[pid  1050] send(3, "\1", 1, 0 <unfinished ...>    <<<<<< doesn't fit in queue
[pid  1051] recvfrom(3, "\1", 2000, 0, NULL, NULL) = 1
[pid  1051] recvfrom(3, "\1", 2000, 0, NULL, NULL) = 1
[pid  1051] recvfrom(3, "\1", 2000, 0, NULL, NULL) = 1
[pid  1051] recvfrom(3, "\1", 2000, 0, NULL, NULL) = 1
[pid  1051] recvfrom(3, "\1", 2000, 0, NULL, NULL) = 1   <<<<< makes room
[pid  1050] <... send resumed> )        = 1
[pid  1050] send(3, "\1", 1, 0)         = 1
[pid  1050] send(3, "\1", 1, 0)         = 1
[pid  1050] send(3, "\1", 1, 0)         = 1
[pid  1050] send(3, "\1", 1, 0)         = 1
[pid  1050] send(3, "\1", 1, 0 <unfinished ...>
-- 
Krzysztof Halasa
Network Administrator
