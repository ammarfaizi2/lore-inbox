Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSKCRNv>; Sun, 3 Nov 2002 12:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262218AbSKCRNu>; Sun, 3 Nov 2002 12:13:50 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:26755 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262215AbSKCRNs>; Sun, 3 Nov 2002 12:13:48 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 3 Nov 2002 09:30:00 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: bert hubert <ahu@ds9a.nl>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] total-epoll r2 ...
In-Reply-To: <20021103132133.GA21319@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0211030923001.7501-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, bert hubert wrote:

> On Sat, Nov 02, 2002 at 12:17:31PM -0800, Davide Libenzi wrote:
>
> > *) The old /dev/epoll access has been dropped with this release.
>
> Four things:

Thank you very much for your report Bert !


> 1)
> unsure if it should still live in drivers/char then.

You're absolutely right.
Linus, is ./fs the right place for it ?




> 2)
> The 'drop an event on insertion' feature works as advertised. I'm unable to
> trigger the much feared & discussed race condition.
>
> >From a cursory glance at the code, I wonder if this condition might return
> on SMP. I'm a complete locking nono, but as far as I can see there is no
> protection against fd meeting its poll condition between here:
>
>         /* Attach the item to the poll hooks */
>         poll_initwait_ex(&pt, 1, ep_ptable_queue_proc, dpi);
>         revents = tfile->f_op->poll(tfile, &pt);   // <- get poll condition
>         poll_freewait(&pt);
>
>         /* We have to drop the new item inside our item list to keep track of it */
>         write_lock_irqsave(&ep->lock, flags);
>
>         list_add(&dpi->llink, ep_hash_entry(ep, ep_hash_index(ep, tfile)));
>
> and here:
>
>         /* If the file is already "ready" we drop him inside the ready list */
>         if (revents & pfd->events)
>                 list_add(&dpi->rdllink, &ep->rdllist);
>
>         write_unlock_irqrestore(&ep->lock, flags);
>
> Which would again lead us to miss the edge. But I may be wildly wrong about
> this.

It's just fine because at that point the poll callbacks are already setup
and if the target file will issue a wakeup, it will be caught.



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

I'll check it right now ... and thank you very much for the exploit code,
that always help :)



> 4)
> Behaviour when exceeding 'maxevents' edges on epoll_wait. At one point I
> managed to get epoll to 'forget' a socket and never more return
> events for it. As yet, I've been unable to reproduce this, but I saw it
> happen. Not entirely sure what the semantics are in that case, the code in
> the kernel appears to suggest that events will then be reported on the next
> call to epoll_wait?

The epoll code keeps a list of ready file*. For each ready file and until
the number of polled events is less of 'maxevents', the ready file is
removed from the list and it is reported to userspace. So if you give
epoll a 'maxevents' of 5 and there're 100 events, 95 will remain in the
ready list.




- Davide


