Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262310AbSJ2VJg>; Tue, 29 Oct 2002 16:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262325AbSJ2VJf>; Tue, 29 Oct 2002 16:09:35 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:4241 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262310AbSJ2VJb>; Tue, 29 Oct 2002 16:09:31 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 29 Oct 2002 13:25:24 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: bert hubert <ahu@ds9a.nl>
cc: Hanna Linder <hannal@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021029130943.GA13728@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0210291312500.1457-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, bert hubert wrote:

> On Mon, Oct 28, 2002 at 04:57:12PM -0800, Davide Libenzi wrote:
>
> > The epoll interface has to be used with non-blocking fds. The EAGAIN
> > return code from read/write tells you that you can go safely to wait for
> > events for that fd because you making the read/write to return EAGAIN, you
> > consumed the whole I/O space for that fd. Consuming the whole I/O space
> > meant that you brought the signal to zero ( talking in ee terms ), and a
> > followinf 0->1 transaction will trigger the event. Where 1 means I/O space
> > available ...
>
> I tried to modify the mtasker webserver
> (http://ds9a.nl/mtasker/releases/mtasker-0.2.tar.gz) to work with epoll
> instead of select and, well, this is awkward.
>
> The right way to use epoll is (schematically);
>
> 	int clientfd=accept();
> 	setnonblocking(clientfd);
>
> 	epfd=epoll_create();
> 	epoll_ctl(epfd,EP_CTL_ADD, clientfd, POLLIN);
>
> 	for(;;) {
> 		if(read(clientfd)<0 && errno==EAGAIN) {
> 			epoll_wait(epfd);
> 			continue;
> 		}
>                 epoll_ctl(epfd,EP_CTL_DEL, clientfd); // remove again
> 		break;
> 	}
>
> This requires having the fd in epoll before trying to read, which means a
> weird interface where you have to register your interest, try to read, and
> unregister your interface in case it succeeded.
>
> This means two epoll syscalls per read.

Bert, you don't need to do that. Like I wrote in the latest man pages, you
can easily add the fd inside the interest set with POLLIN | POLLOUT when
the fd born ( accept/connect ) and leave it there for its whole life. The
fact that the API is edge triggered garanties you that you won't receive
any events when the fd is not used. I personallt tried to measure the
number of stale events and is basically ( better definitely ) uninfluent.


> This is all solved if epoll_ctl() creates an edge if it finds that the poll
> condition is met at insert time.
>
> The way it works now is way more awkward then using regular poll(), the way
> it works now is very easy to do wrong because of this awkwardness. Even
> semi-correct which zeroes the pollstate before calling epoll is wrong:
>
> 	for(;;) {
> 		if(read(clientfd)<0 && errno==EAGAIN) {
> 			waitOn(clientfd);  /* function which registers our
>                                               interest with a central
> 			                      dispatcher and waits */
> 			continue;
> 		}
> 		break;
> 	}
>
> Code like this would appear in many userspace threading abstractions, like
> GNU Pth or mtasker. Instead, we need:
>
> 	for(;;) {
> 		registerReadInterest(clientfd);
> 		if(read(clientfd)<0 && errno==EAGAIN) {
> 			waitOn(clientfd);  /* function which waits for our
> 			                      interest be satisfied */
> 			continue;
> 		}
> 		deleteReadInterest(clientfd);
> 		break;
> 	}
>
> If epoll_ctl make epoll_wait report an edge in case it finds that there is
> already data, all this is way way simpler, allowing:
>
> 	waitOn(clientfd); /* function which registers interest and waits for
> 	                     an edge to appear */
> 	read(clientfd);

You can do all this easily, expecially with API that has a core dispatch
loop like GNU PTH. The example http server used to test it is an example
on how to use it ( with coroutines ).


Hanna, is it possible for you guys to cleanup ephttpd and make it an
example program for sys_epoll ?



- Davide



