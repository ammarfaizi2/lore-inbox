Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262178AbSJ2Uro>; Tue, 29 Oct 2002 15:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262184AbSJ2Uro>; Tue, 29 Oct 2002 15:47:44 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:62096 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262178AbSJ2Urn>; Tue, 29 Oct 2002 15:47:43 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 29 Oct 2002 13:03:34 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
In-Reply-To: <3DBEE645.3020808@netscape.com>
Message-ID: <Pine.LNX.4.44.0210291237240.1457-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, John Gardiner Myers wrote:

> >I bet Davide knows best.
> >
> Nope, he doesn't.

It is very easy for me to remain calm here. You're a funny guy. You're in
the computer science by many many years and still you're not able to
understand how edge triggered events works. And look, this apply to every
field, form ee to cs. Book suggestions would be requested here, but since
I believe grasping inside a technical library to be pretty fun, I'll leave
you this pleasure.



> >An easy solution is to have sys_epoll_ctl check if there is there is data
> >ready and make sure there is an edge to report in that case to the next call
> >of sys_epoll_ctl().
> >
> >
> This is the very solution I am proposing.

This is an example snippet code that can be used with the current API :

for(;;) {
        nfds = sys_epoll_wait(kdpfd, &pfds, -1);

        for(n = 0; n < nfds; ++n) {
                if(fd = pfds[n].fd) == s) {
                        client = accept(s, (struct sockaddr*)&local, &addrlen);
                        if(client < 0){
                                perror("accept");
                                continue;
                        }
                        if (sys_epoll_ctl(kdpfd, EP_CTL_ADD, client, POLLIN | POLLOUT) < 0) {
                                fprintf(stderr, "sys_epoll set insertion error: fd=%d\n", client);
                                return -1;
                        }
                        fd = client;
                }
                do_use_fd(fd);
        }
}

This is what will be used in case of your
failing-to-understand-edge-triggered-api method :

for(;;) {
        nfds = sys_epoll_wait(kdpfd, &pfds, -1);

        for(n = 0; n < nfds; ++n) {
                if(fd = pfds[n].fd) == s) {
                        client = accept(s, (struct sockaddr*)&local, &addrlen);
                        if(client < 0){
                                perror("accept");
                                continue;
                        }
                        if (sys_epoll_ctl(kdpfd, EP_CTL_ADD, client, POLLIN | POLLOUT) < 0) {
                                fprintf(stderr, "sys_epoll set insertion error: fd=%d\n", client);
                                return -1;
                        }
                } else
                        do_use_fd(fd);
        }
}

Why the heck ( and this for the 100th time ) do you want to go to wait for
an event on the newly born fd if :

1) On connect() you have the _full_ write I/O space available
2) On accept() it's very likely the you'll find something more than a SYN
	in the first packet

Besides, the first code is even more cleaner and simmetric, while adopting
your half *ss solution might suggest the user that he can go waiting for
events any time he wants. Like going to sleep the the wait queue of IDE
disk w/out having issued any command. Now to bring this 101, consider :

1) "issuing a command to an IDE disk" == "using read/write until EAGAIN"

2) "adding yourself on the IDE disk wait queue" == "calling sys_epoll_wait()"


PS: since my time is not infinite, and since I'm working on the changes we
agreed with Andrew I would suggest you either to take another look at the
code suggesting us new changes ( like you did yesterday ) or to go
shopping for books.



- Davide



