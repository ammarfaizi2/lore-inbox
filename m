Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbUDBSkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 13:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbUDBSkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 13:40:55 -0500
Received: from mail.shareable.org ([81.29.64.88]:1686 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S264155AbUDBSkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 13:40:52 -0500
Date: Fri, 2 Apr 2004 19:40:35 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ben Mansell <ben@zeus.com>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Is POLLHUP an input-only or bidirectional condition? (was: epoll reporting events when it hasn't been asked to)
Message-ID: <20040402184035.GA653@mail.shareable.org>
References: <Pine.LNX.4.58.0404020950560.3066@stones.cam.zeus.com> <Pine.LNX.4.44.0404020717350.1828-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404020717350.1828-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[New thread because I want people who understand POLLHUP to clarify.
 The parent thread's question was: why does epoll always report POLLHUP
 and POLLERR conditions even when the program didn't ask for those.
 The trivial answer is because that's what poll() does.]

Davide Libenzi wrote:
> Handling by, for example, removing the fd from the epoll set and 
> unregistering/freeing the associated data structures. IMO we can leave the 
> current behaviour, but if someone sees huge problems with this, the fix is 
> a one-liner.

None of select, poll or epoll allow a program to ignore POLLERR while
checking POLLIN or POLLOUT.  So at least epoll is consistent with the
other two.

It is possible to ignore POLLHUP conditions with select(), but not
poll() or epoll.  For sockets at least, POLLHUP should indicate the
socket is fully closed, so that reading and writing will both fail.
Thus it makes sense that POLLHUP is not ignorable, although curiously
select() only treats POLLHUP as an _input_ condition, so it won't wake
something that's waiting only for output readiness.  poll() will
always wake even if you're only waiting for POLLOUT.

POLLERR is set by UDP sockets with a pending error condition, and that
will be reported whether you read or write to the socket (except in
some perverse conditions where MSG_MORE has been used - then app state
machines could get confused).  So it's appropriate for a POLLIN or
POLLOUT waiter to be woken when there's a POLLERR condition.

Summary: epoll is consistent with poll().  I'm not sure why poll() and
select() treat POLLHUP differnently.  A poll() for POLLOUT will be
woken by a POLLHUP condition, yet a select() for output will _not_ be
woken by a POLLHUP condition.

Perhaps that indicates some confusion over what POLLHUP is supposed to
mean, and when it should be set by devices and/or sockets: is it for
input hangup conditions that allow further output, or for total hangup
conditions where input and output are both guaranteed to fail?

If it's the latter, as it seems to be for sockets, then the poll() and
epoll behaviour makes sense, but select() doesn't.  If it's the
former, then the select() behaviour is the only one that makes sense.

Hence my question: does anyone know for sure which POLLHUP behaviour
is correct and sensible?

-- Jamie


