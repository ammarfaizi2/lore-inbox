Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261844AbSJ2NDX>; Tue, 29 Oct 2002 08:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261850AbSJ2NDX>; Tue, 29 Oct 2002 08:03:23 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:44507 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261844AbSJ2NDW>;
	Tue, 29 Oct 2002 08:03:22 -0500
Date: Tue, 29 Oct 2002 14:09:43 +0100
From: bert hubert <ahu@ds9a.nl>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021029130943.GA13728@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	lse-tech@lists.sourceforge.net
References: <20021029004034.GA32118@outpost.ds9a.nl> <Pine.LNX.4.44.0210281652270.966-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210281652270.966-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 04:57:12PM -0800, Davide Libenzi wrote:

> The epoll interface has to be used with non-blocking fds. The EAGAIN
> return code from read/write tells you that you can go safely to wait for
> events for that fd because you making the read/write to return EAGAIN, you
> consumed the whole I/O space for that fd. Consuming the whole I/O space
> meant that you brought the signal to zero ( talking in ee terms ), and a
> followinf 0->1 transaction will trigger the event. Where 1 means I/O space
> available ...

I tried to modify the mtasker webserver
(http://ds9a.nl/mtasker/releases/mtasker-0.2.tar.gz) to work with epoll
instead of select and, well, this is awkward.

The right way to use epoll is (schematically);

	int clientfd=accept();
	setnonblocking(clientfd);

	epfd=epoll_create();
	epoll_ctl(epfd,EP_CTL_ADD, clientfd, POLLIN);

	for(;;) {
		if(read(clientfd)<0 && errno==EAGAIN) {
			epoll_wait(epfd);
			continue;
		}
                epoll_ctl(epfd,EP_CTL_DEL, clientfd); // remove again
		break;
	}

This requires having the fd in epoll before trying to read, which means a
weird interface where you have to register your interest, try to read, and
unregister your interface in case it succeeded.
	
This means two epoll syscalls per read.

This is all solved if epoll_ctl() creates an edge if it finds that the poll
condition is met at insert time.	

The way it works now is way more awkward then using regular poll(), the way
it works now is very easy to do wrong because of this awkwardness. Even
semi-correct which zeroes the pollstate before calling epoll is wrong:

	for(;;) {
		if(read(clientfd)<0 && errno==EAGAIN) {
			waitOn(clientfd);  /* function which registers our
                                              interest with a central
			                      dispatcher and waits */ 
			continue;
		}
		break;
	}
	
Code like this would appear in many userspace threading abstractions, like
GNU Pth or mtasker. Instead, we need:

	for(;;) {
		registerReadInterest(clientfd);
		if(read(clientfd)<0 && errno==EAGAIN) {
			waitOn(clientfd);  /* function which waits for our
			                      interest be satisfied */
			continue;
		}
		deleteReadInterest(clientfd);
		break;
	}

If epoll_ctl make epoll_wait report an edge in case it finds that there is
already data, all this is way way simpler, allowing:

	waitOn(clientfd); /* function which registers interest and waits for
	                     an edge to appear */
	read(clientfd);

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
