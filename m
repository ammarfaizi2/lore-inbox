Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261886AbSJ2AR0>; Mon, 28 Oct 2002 19:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbSJ2AR0>; Mon, 28 Oct 2002 19:17:26 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:12955 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261886AbSJ2ARW>; Mon, 28 Oct 2002 19:17:22 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 16:32:50 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: bert hubert <ahu@ds9a.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021029001843.GB31212@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0210281631040.966-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, bert hubert wrote:

> On Mon, Oct 28, 2002 at 03:45:06PM -0800, John Gardiner Myers wrote:
>
> > As you have amply demonstrated, the current epoll API is error prone.
> > The API should be fixed to test the poll condition and, if necessary,
> > drop an event upon insertion to the set.
>
> That is a semantics change and not an API/ABI change. To reiterate, you
> mention the following scenario:
>
> for(;;) {
> 	nfds = sys_epoll_wait(kdpfd, &pfds, -1);
> 	for(n = 0; n < nfds; ++n) {
> 		if((fd = pfds[n].fd) == s) {
>                         /* 1: accept client (SYN/SYN|ACK/ACK completed) */
> 			client = accept(s, (struct sockaddr*)&local, &addrlen);
> 			if(client < 0){
> 				perror("accept");
> 				continue;
> 			}
>
> 			/* 2: packet comes in, client becomes readable  */
> 			/* 3: registering interest */
> 			if (sys_epoll_ctl(kdpfd, EP_CTL_ADD, client, POLLIN ) < 0) {
> 				fprintf(stderr, "sys_epoll set insertion error: fd=%d\n", client);
> 				return -1;
> 			}
>
> 			/* 4: interest only now registered, no edge will be
> 			   reported, our fd is lost */
>
> 			fd = client;
> 		}
> 		do_use_fd(fd);
> 	}
> }
>
> There are lots of ways to solve this, I bet Davide knows best. Perhaps it is
> solved already, you can't tell from only studying the API, the problem isn't
> intrinsic to it.

The code above it's just fine. The "fd" is not lost because the falling
through :

do_use_fd(fd);

will make good use of it.



- Davide


