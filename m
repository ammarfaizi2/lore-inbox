Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270294AbTGMQxT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270295AbTGMQxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:53:19 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:65413 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270294AbTGMQxS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:53:18 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 13 Jul 2003 10:00:38 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Jamie Lokier <jamie@shareable.org>
cc: "David S. Miller" <davem@redhat.com>, e0206@foo21.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kuznet@ms2.inr.ac.ru
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
In-Reply-To: <20030713140758.GF19132@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.55.0307130956530.14680@bigblue.dev.mcafeelabs.com>
References: <20030712181654.GB15643@srv.foo21.com>
 <Pine.LNX.4.55.0307121256200.4720@bigblue.dev.mcafeelabs.com>
 <20030712222457.3d132897.davem@redhat.com> <20030713140758.GF19132@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jul 2003, Jamie Lokier wrote:

> David S. Miller wrote:
> > Alexey, they seem to want to add some kind of POLLRDHUP thing,
> > comments wrt. TCP and elsewhere in the networking?  See below...
>
> POLLHUP is a mess.  It means different things according to the type of
> fd, precisely because it is considered an unmaskeable event for the
> poll() API so the standard meaning isn't useful for sockets.  (See the
> comments in tcp_poll()).
>
> POLLRDHUP makes sense because it could actually have a well-defined
> meaning: set iff reading the fd would return EOF.
>
> However, if a program is waiting on POLLRDHUP, you don't want the
> program to have to say "if this fd is a TCP socket then listen for
> POLLRDHUP else if this fd is another kind of socket call read to
> detect EOF else listen for POLLHUP".  Programs have enough
> version-specific special cases as it is.
>
> So I suggest:
>
>   - Everywhere that POLLHUP is currently set in a driver, socket etc.
>     it should set POLLRDHUP|POLLHUP - unless it specifically knows
>     about POLLRDHUP as in TCP (and presumably UDP, SCTP etc).

Returning POLLHUP to a caller waiting for POLLIN might break existing code
IMHO. After ppl reporting the O_RDONLY|O_TRUNC case I'm inclined to expect
everything from existing apps ;) POLLHUP should be returned to apps
waiting for POLLOUT while POLLRDHUP to ones for POLLIN.



- Davide

