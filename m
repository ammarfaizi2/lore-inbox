Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268680AbTGLW5G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 18:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268683AbTGLW5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 18:57:06 -0400
Received: from ev2.cpe.orbis.net ([209.173.192.122]:2470 "EHLO srv.foo21.com")
	by vger.kernel.org with ESMTP id S268680AbTGLW5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 18:57:03 -0400
Date: Sat, 12 Jul 2003 18:11:47 -0500
From: Eric Varsanyi <e0206@foo21.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Eric Varsanyi <e0206@foo21.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
Message-ID: <20030712231147.GI15643@srv.foo21.com>
References: <20030712181654.GB15643@srv.foo21.com> <20030712194432.GE10450@mail.jlokier.co.uk> <20030712205114.GC15643@srv.foo21.com> <Pine.LNX.4.55.0307121346140.4720@bigblue.dev.mcafeelabs.com> <20030712211941.GD15643@srv.foo21.com> <Pine.LNX.4.55.0307121436460.4720@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307121436460.4720@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I guess my only argument would be that edge triggered mode isn't really
> > workable with TCP connections if there's no way to solve the ambiguity
> > between EOF and no data in buffer (at least w/o an extra syscall). I just
> > realized that the race you mention in the man page (reading data from
> > the 'next' event that hasn't been polled into user mode yet) will lead to
> > the same issue: how do you know if you got this event because you consumed
> > the data on the previous interrupt or if this is an EOF condition.
> 
> (Sorry, I missed this)
> You can work that out very easily. When your read/write returns a lower
> number of bytes, it means that it is time to stop processing this fd. If
> events happened meanwhile, you will get them at the next epoll_wait(). If
> not, the next time they'll happen. There's no blind spot if you follow
> this simple rule, and you do not even have the extra syscall with EAGAIN.

The scenario that I think is still uncovered (edge trigger only):

User					Kernel
--------				----------
					Read data added to socket

					Socket posts read event to epfd

epoll_wait()				Event cleared from epfd, EPOLLIN
					  returned to user

					more read data added to socket

					Socket posts a new read event to epfd

read() until short read with EAGAIN 	all data read from socket

epoll_wait()				returns another EPOLLIN for socket and
					  clears it from epfd

read(), returns 0 right away		socket buffer is empty

This is your 'false positive' case in the epoll(4) man page.

How does the app tell the 0 read here from a read EOF coming from the remote?

If it assumes this is a false positive and there was also an EOF
indication, the EOF will be lost; if it assumes it an EOF the connection
will be prematurely terminated.

-Eric
