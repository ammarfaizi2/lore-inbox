Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbUDDUYy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 16:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbUDDUYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 16:24:54 -0400
Received: from mail.shareable.org ([81.29.64.88]:32407 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262774AbUDDUYv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 16:24:51 -0400
Date: Sun, 4 Apr 2004 21:24:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ben Mansell <ben@zeus.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is POLLHUP an input-only or bidirectional condition? (was: epoll reporting events when it hasn't been asked to)
Message-ID: <20040404202437.GA16266@mail.shareable.org>
References: <20040402184035.GA653@mail.shareable.org> <Pine.LNX.4.44.0404031334440.2122-100000@bigblue.dev.mdolabs.com> <20040403223541.GB6122@mail.shareable.org> <Pine.LNX.4.58.0404041912460.5216@stones.cam.zeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404041912460.5216@stones.cam.zeus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Mansell wrote:
> Since you have to generate the pollfd array for each time you call
> poll(), there is no real extra cost in taking a fd out temporarily

Wrong.  You don't have to generate the pollfd array each time.  That's
why there are separate events and revents fields.  Quite often no
changes are required between each call to poll(), and only small
changes the rest of the time.

(Of course there is no escaping the O(n) overhead that the _kernel_
has when it scans the array, but it's avoidable in userspace).

> With epoll, adding a fd into the epoll set is a separate operation from
> the epoll_wait(), so if you really don't want to listen for any events
> on one FD, you'll have to do a EPOLL_DEL, and then later on do a
> EPOLL_ADD again if you want to bring it back in. Which is a bit nasty
> and inefficient.

No.  If you don't want to listen for any events, and you predict those
events haven't occurred already (POLLHUP, POLLERR, usually POLLIN),
don't do any epoll_ctl() operations at all.  Just call epoll_wait().

When you receive an event that you didn't want to listen for, set the
corresponding flag in your userspace structure, and call EPOLL_CTL_MOD
or EPOLL_CTL_DEL, depending on whether there are any other events you
still want to listen for.

See, your proposed method is slower than mine.  I avoid *all*
epoll_ctl() calls in the common path.

Only in the uncommon path might I process an unwanted POLLHUP or
POLLERR event, and in those cases either I may as well close the fd
now (POLLHUP, after read to determine if it's EOF or an error), or the
EPOLL_CTL_DEL if I want to ignore that fd for a while (POLLERR) is
negligable because that's a rare event.

> As Richard Kettlewell's excellent poll test shows, relying on anything
> but the basics of poll() is impossible if you are trying to write code
> for several different OSs (or just different versions of the same OS!)
> Whatever poll() returns, all you can do is force a read() or a write()
> to try and find out what events really happened.

Indeed.  Sometimes I wonder why there is anything other than POLLIN
and POLLOUT, given that the only reasonable response to the other
flags is to call read() to find out what happened.  (Then again, maybe
read() isn't enough to get error conditions (as flagged by POLLERR) on
some broken OSs, and only MSG_ERRQUEUE will report them?  I don't know).

> This is not something you'd want to do if the application, by
> unsetting POLLIN & POLLOUT, has shown that it doesn't want to read()
> or write().

Indeed.  That's why if you do receive POLLHUP or POLLERR and you're
not interested in handling them right now, then _after_ receiving the
events call EPOLL_CTL_DEL, not before.  That lazy method usually
avoids the system call.

-- Jamie
