Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbUDDSvi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 14:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbUDDSvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 14:51:38 -0400
Received: from [212.44.21.72] ([212.44.21.72]:11449 "EHLO watergate.zeus.co.uk")
	by vger.kernel.org with ESMTP id S262579AbUDDSvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 14:51:36 -0400
Date: Sun, 4 Apr 2004 19:51:28 +0100 (BST)
From: Ben Mansell <ben@zeus.com>
X-X-Sender: ben@stones.cam.zeus.com
To: Jamie Lokier <jamie@shareable.org>
cc: Davide Libenzi <davidel@xmailserver.org>, Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is POLLHUP an input-only or bidirectional condition? (was: epoll
 reporting events when it hasn't been asked to)
In-Reply-To: <20040403223541.GB6122@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0404041912460.5216@stones.cam.zeus.com>
References: <20040402184035.GA653@mail.shareable.org>
 <Pine.LNX.4.44.0404031334440.2122-100000@bigblue.dev.mdolabs.com>
 <20040403223541.GB6122@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanner: exiscan *1BACiO-0002NU-00*iclslZeEPRE* (Zeus Technology Ltd)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2004, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > Looking at poll(2) though, it seems that it does the same thing if
> > you set the event mask to 0. So epoll is coherent with poll(2) in this.
>
> Yes.  SUSv3 says POLLHUP, POLLERR and POLLNVAL are always reported
> even if not requested.

Fair enough. However, if you're writing poll()-based code that doesn't
want to listen to any events on a fd, you just wouldn't add it into the
pollfd array in the first place. Since you have to generate the pollfd
array for each time you call poll(), there is no real extra cost in
taking a fd out temporarily, and putting it back in later when we care
about what is going on with it.

With epoll, adding a fd into the epoll set is a separate operation from
the epoll_wait(), so if you really don't want to listen for any events
on one FD, you'll have to do a EPOLL_DEL, and then later on do a
EPOLL_ADD again if you want to bring it back in. Which is a bit nasty
and inefficient.

It would be nice if there was some shortcut to doing this. I'd still
favour epoll only reporting POLLHUP|POLLERR events if the fd was also
registered for POLLIN|POLLOUT. It may not be consistent with SUSv3's
definition of poll(), but does it matter? epoll is not poll.

As Richard Kettlewell's excellent poll test shows, relying on anything
but the basics of poll() is impossible if you are trying to write code
for several different OSs (or just different versions of the same OS!)
Whatever poll() returns, all you can do is force a read() or a write()
to try and find out what events really happened. This is not something
you'd want to do if the application, by unsetting POLLIN & POLLOUT, has
shown that it doesn't want to read() or write().



Ben
