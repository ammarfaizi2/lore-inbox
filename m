Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261737AbSJ1XH2>; Mon, 28 Oct 2002 18:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261745AbSJ1XH2>; Mon, 28 Oct 2002 18:07:28 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:34454 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261737AbSJ1XH0>; Mon, 28 Oct 2002 18:07:26 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 15:23:10 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: bert hubert <ahu@ds9a.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>, <lse-tech@lists.sourceforge.net>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021028225821.GA29868@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0210281518060.966-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, bert hubert wrote:

> The interface is also lovely:
>
> for(;;) {
>   nfds = sys_epoll_wait(kdpfd, &pfds, -1);
>   fprintf(stderr,"sys_epoll_wait returned: %d\n",nfds);
>
>   for(n=0;n<nfds;++n) {
>     if(pfds[n].fd==s) {
>       client=accept(s, (struct sockaddr*)&local, &addrlen);
>
>       if(client<0){
> 	perror("accept");
> 	continue;
>       }
>       if (sys_epoll_ctl(kdpfd, EP_CTL_ADD, client, POLLIN ) < 0) {
> 	fprintf(stderr, "sys_epoll set insertion error: fd=%d\n", client);
> 	return -1;
>       }
>     }
>     else
>       printf("something happened on fd %d\n", pfds[n].fd);
>   }
> }

This is how you probably want to use it :

for(;;) {
	nfds = sys_epoll_wait(kdpfd, &pfds, -1);

	for(n = 0; n < nfds; ++n) {
		if(fd = pfds[n].fd) == s) {
			client = accept(s, (struct sockaddr*)&local, &addrlen);
			if(client < 0){
				perror("accept");
				continue;
			}
			if (sys_epoll_ctl(kdpfd, EP_CTL_ADD, client, POLLIN ) < 0) {
				fprintf(stderr, "sys_epoll set insertion error: fd=%d\n", client);
				return -1;
			}
			fd = client;
		}

		do_use_fd(fd);
	}
}




- Davide


