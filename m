Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267576AbTGMNx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 09:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267587AbTGMNx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 09:53:58 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:33684 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S267576AbTGMNx5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 09:53:57 -0400
Date: Sun, 13 Jul 2003 15:07:58 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, e0206@foo21.com,
       linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
Message-ID: <20030713140758.GF19132@mail.jlokier.co.uk>
References: <20030712181654.GB15643@srv.foo21.com> <Pine.LNX.4.55.0307121256200.4720@bigblue.dev.mcafeelabs.com> <20030712222457.3d132897.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712222457.3d132897.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Alexey, they seem to want to add some kind of POLLRDHUP thing,
> comments wrt. TCP and elsewhere in the networking?  See below...

POLLHUP is a mess.  It means different things according to the type of
fd, precisely because it is considered an unmaskeable event for the
poll() API so the standard meaning isn't useful for sockets.  (See the
comments in tcp_poll()).

POLLRDHUP makes sense because it could actually have a well-defined
meaning: set iff reading the fd would return EOF.

However, if a program is waiting on POLLRDHUP, you don't want the
program to have to say "if this fd is a TCP socket then listen for
POLLRDHUP else if this fd is another kind of socket call read to
detect EOF else listen for POLLHUP".  Programs have enough
version-specific special cases as it is.

So I suggest:

  - Everywhere that POLLHUP is currently set in a driver, socket etc.
    it should set POLLRDHUP|POLLHUP - unless it specifically knows
    about POLLRDHUP as in TCP (and presumably UDP, SCTP etc).

-- Jamie
