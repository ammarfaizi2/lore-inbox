Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270032AbTGLXsN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 19:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270034AbTGLXsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 19:48:13 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:56463 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270032AbTGLXsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 19:48:10 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sat, 12 Jul 2003 16:55:10 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Eric Varsanyi <e0206@foo21.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] epoll and half closed TCP connections
In-Reply-To: <20030712231147.GI15643@srv.foo21.com>
Message-ID: <Pine.LNX.4.55.0307121653550.4720@bigblue.dev.mcafeelabs.com>
References: <20030712181654.GB15643@srv.foo21.com> <20030712194432.GE10450@mail.jlokier.co.uk>
 <20030712205114.GC15643@srv.foo21.com> <Pine.LNX.4.55.0307121346140.4720@bigblue.dev.mcafeelabs.com>
 <20030712211941.GD15643@srv.foo21.com> <Pine.LNX.4.55.0307121436460.4720@bigblue.dev.mcafeelabs.com>
 <20030712231147.GI15643@srv.foo21.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jul 2003, Eric Varsanyi wrote:

> > (Sorry, I missed this)
> > You can work that out very easily. When your read/write returns a lower
> > number of bytes, it means that it is time to stop processing this fd. If
> > events happened meanwhile, you will get them at the next epoll_wait(). If
> > not, the next time they'll happen. There's no blind spot if you follow
> > this simple rule, and you do not even have the extra syscall with EAGAIN.
>
> The scenario that I think is still uncovered (edge trigger only):
>
> User					Kernel
> --------				----------
> 					Read data added to socket
>
> 					Socket posts read event to epfd
>
> epoll_wait()				Event cleared from epfd, EPOLLIN
> 					  returned to user
>
> 					more read data added to socket
>
> 					Socket posts a new read event to epfd
>
> read() until short read with EAGAIN 	all data read from socket
>
> epoll_wait()				returns another EPOLLIN for socket and
> 					  clears it from epfd
>
> read(), returns 0 right away		socket buffer is empty

read will return -1 with errno=EAGAIN in that case, not zero.



- Davide

