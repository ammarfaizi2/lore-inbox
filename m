Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270338AbTGMTCA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 15:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270339AbTGMTCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 15:02:00 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:43412 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270338AbTGMTB5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 15:01:57 -0400
Date: Sun, 13 Jul 2003 20:15:59 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: "David S. Miller" <davem@redhat.com>, e0206@foo21.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
Message-ID: <20030713191559.GA20573@mail.jlokier.co.uk>
References: <20030712181654.GB15643@srv.foo21.com> <Pine.LNX.4.55.0307121256200.4720@bigblue.dev.mcafeelabs.com> <20030712222457.3d132897.davem@redhat.com> <20030713140758.GF19132@mail.jlokier.co.uk> <Pine.LNX.4.55.0307130956530.14680@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307130956530.14680@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> > However, if a program is waiting on POLLRDHUP, you don't want the
> > program to have to say "if this fd is a TCP socket then listen for
> > POLLRDHUP else if this fd is another kind of socket call read to
> > detect EOF else listen for POLLHUP".  Programs have enough
> > version-specific special cases as it is.
> >
> >   - Everywhere that POLLHUP is currently set in a driver, socket etc.
> >     it should set POLLRDHUP|POLLHUP - unless it specifically knows
> >     about POLLRDHUP as in TCP (and presumably UDP, SCTP etc).
> 
> Returning POLLHUP to a caller waiting for POLLIN might break existing code
> IMHO.

Oh, agreed.  I was(*) suggesting to add POLL_RDHUP to the set of
events reported by e.g. AF_UNIX sockets which are half-closed.  Not to
add POLLHUP to anything!  (Particularly as POLLHUP can't be ignored).

> After ppl reporting the O_RDONLY|O_TRUNC case I'm inclined to expect
> everything from existing apps ;) POLLHUP should be returned to apps
> waiting for POLLOUT while POLLRDHUP to ones for POLLIN.

Not sure exactly how you're thinking with that last sentence.

At present, it's impossible for socket code to return POLLHUP only to
apps which are waiting on POLLOUT - because POLLHUP is not maskable in
sys_poll's API.  Therefore sockets return POLLHUP only if they are
closed in both directions.

There is no way for a socket to return a HUP condition for someone who
is waiting only to write, but fortunately that doesn't matter :)

Back to the (*), (see above):

(*) There aren't that many places which set POLLHUP; they divide into:
sockets, ttys, SCSI-generic and PPP.  The latter two are not important
as they don't do half-close.

   __The critical thing with POLL_RDHUP is that it is set if read() would
   return EOF after returning data.__

   If this condition isn't met, than an app which is using POLL_RDHUP to
   optimise performance using epoll will hang occasionally.

Sockets are important: TCP is not the only thing to support
half-closing.  If an app is waiting for POLLRDHUP, and it doesn't know
what kind of socket it has been given (e.g. AF_UNIX), the network
stack had better return POLL_RDHUP when there's an EOF pending.

So we'd better add POLLRDHUP to all the socket types which do
half-closing.  For the rest, no change is required as POLLHUP is
non-maskable :)  (So apps should always say "if (events &
(POLLHUP|POLLRDHUP)) check_for_eof()").

And ttys?  They are problematic, because ttys can return EOF _after_
returning data without closing (and without being hung-up).  An epoll
loop which is reading a tty (and isn't programmed specially for a tty)
_must_ receive POLLRDHUP when the EOF is pending, else it may hang.

In other words, POLLRDHUP is the wrong name: the correct name is
POLLRDEOF.

-- Jamie
