Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262310AbSKCTAk>; Sun, 3 Nov 2002 14:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262322AbSKCTAk>; Sun, 3 Nov 2002 14:00:40 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:63619 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262310AbSKCTAj>; Sun, 3 Nov 2002 14:00:39 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 3 Nov 2002 11:15:39 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: bert hubert <ahu@ds9a.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] total-epoll r2 ...
In-Reply-To: <20021103132133.GA21319@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0211031113220.954-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, bert hubert wrote:

> 3)
> Using epoll on tty behaves weirdly, I think this is a bug. I see epoll_wait
> returning immediately, but it returns 0, even though I set timeout to
> infinite (-1). 'Exploit code:'
>
> #include <stdio.h>
> #include <errno.h>
> #include <asm/page.h>
> #include <asm/poll.h>
> #include <linux/linkage.h>
> #include <linux/eventpoll.h>
> #include <linux/unistd.h>
> #include <string.h>
> #include <stdlib.h>
> #include <unistd.h>
>
> #define __sys_epoll_create(maxfds) _syscall1(int, sys_epoll_create, int, maxfds)
> #define __sys_epoll_ctl(epfd, op, fd, events) _syscall4(int, sys_epoll_ctl, \
> int, epfd, int, op, int, fd, unsigned int, events)
>
> #define __sys_epoll_wait(epfd, events, maxevents, timeout) _syscall4(int, sys_epoll_wait, \
> int, epfd, struct pollfd *, events, int, maxevents,int, timeout)
>
> __sys_epoll_create(maxfds)
> __sys_epoll_ctl(epfd, op, fd, events)
> __sys_epoll_wait(epfd, events, maxevents, timeout)
>
> int main()
> {
> 	int kdpfd;
> 	struct pollfd pfds[100];
> 	int nfds;
> 	int n;
> 	char line[80];
> 	int ret;
>
> 	if ((kdpfd = sys_epoll_create(10)) < 0) {
>         	perror("sys_epoll_create");
>                 return -1;
>         }
>
>         if (sys_epoll_ctl(kdpfd, EP_CTL_ADD, 0, POLLIN ) < 0) {
> 		fprintf(stderr, "sys_epoll set insertion error: fd=%d\n", 0);
> 		return -1;
> 	}
>
> 	for(;;) {
> 		nfds = sys_epoll_wait(kdpfd, pfds, 100, -1);
> 		fprintf(stderr,"sys_epoll_wait returned: %d\n",nfds);
>
> 		for(n=0;n<nfds;++n) {
> 			if((ret=read(pfds[n].fd,line,79))>0)
> 				printf("read from fd %d: '%.*s'\n", pfds[n].fd, ret>1 ? ret-1 : 0,line);
> 		}
> 	}
>
> 	return 0;
> }
>
> This code runs more as expected when redirecting stderr to a file, strangely
> enough. In that case, epoll_wait returns 0 once per keystroke, but only
> returns '1' after enter is pressed.

Thank you for your very clear report Bert. It's fixed now. It was an easy
fix. I will post a patch later today containing this fix and other things
to Linus and lkml.




- Davide


