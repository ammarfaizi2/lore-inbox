Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270439AbTGMW5H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 18:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270434AbTGMW4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 18:56:36 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:56455 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270433AbTGMW4a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 18:56:30 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 13 Jul 2003 16:03:51 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: "David S. Miller" <davem@redhat.com>, e0206@foo21.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
In-Reply-To: <20030713191559.GA20573@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307131542000.15022@bigblue.dev.mcafeelabs.com>
References: <20030712181654.GB15643@srv.foo21.com>
 <Pine.LNX.4.55.0307121256200.4720@bigblue.dev.mcafeelabs.com>
 <20030712222457.3d132897.davem@redhat.com> <20030713140758.GF19132@mail.jlokier.co.uk>
 <Pine.LNX.4.55.0307130956530.14680@bigblue.dev.mcafeelabs.com>
 <20030713191559.GA20573@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003, Jamie Lokier wrote:

> > After ppl reporting the O_RDONLY|O_TRUNC case I'm inclined to expect
> > everything from existing apps ;) POLLHUP should be returned to apps
> > waiting for POLLOUT while POLLRDHUP to ones for POLLIN.
>
> Not sure exactly how you're thinking with that last sentence.

Brain farting, delete it ;) This is a nice page about POLLHUP treatment :

http://www.greenend.org.uk/rjk/2001/06/poll.html



> At present, it's impossible for socket code to return POLLHUP only to
> apps which are waiting on POLLOUT - because POLLHUP is not maskable in
> sys_poll's API.  Therefore sockets return POLLHUP only if they are
> closed in both directions.
>
> There is no way for a socket to return a HUP condition for someone who
> is waiting only to write, but fortunately that doesn't matter :)

Yes, this could be improved though. If we could only pass our event
interest mask to f_op->poll() the function will be able to register it
inside the wait queue structure and release only waiters that matches the
available condition.



> (*) There aren't that many places which set POLLHUP; they divide into:
> sockets, ttys, SCSI-generic and PPP.  The latter two are not important
> as they don't do half-close.
>
>    __The critical thing with POLL_RDHUP is that it is set if read() would
>    return EOF after returning data.__
>
>    If this condition isn't met, than an app which is using POLL_RDHUP to
>    optimise performance using epoll will hang occasionally.
>
> Sockets are important: TCP is not the only thing to support
> half-closing.  If an app is waiting for POLLRDHUP, and it doesn't know
> what kind of socket it has been given (e.g. AF_UNIX), the network
> stack had better return POLL_RDHUP when there's an EOF pending.
>
> So we'd better add POLLRDHUP to all the socket types which do
> half-closing.  For the rest, no change is required as POLLHUP is
> non-maskable :)  (So apps should always say "if (events &
> (POLLHUP|POLLRDHUP)) check_for_eof()").
>
> And ttys?  They are problematic, because ttys can return EOF _after_
> returning data without closing (and without being hung-up).  An epoll
> loop which is reading a tty (and isn't programmed specially for a tty)
> _must_ receive POLLRDHUP when the EOF is pending, else it may hang.
>
> In other words, POLLRDHUP is the wrong name: the correct name is
> POLLRDEOF.

Please replace 'it may hung' with 'it may hung if it is using the read()
return bytes check trick' ;)



- Davide

