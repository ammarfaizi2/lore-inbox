Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbSKCNPF>; Sun, 3 Nov 2002 08:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261859AbSKCNPF>; Sun, 3 Nov 2002 08:15:05 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:57062 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261857AbSKCNPB>;
	Sun, 3 Nov 2002 08:15:01 -0500
Date: Sun, 3 Nov 2002 14:21:33 +0100
From: bert hubert <ahu@ds9a.nl>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] total-epoll r2 ...
Message-ID: <20021103132133.GA21319@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211021126110.951-100000@blue1.dev.mcafeelabs.com> <Pine.LNX.4.44.0211021215100.951-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211021215100.951-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 12:17:31PM -0800, Davide Libenzi wrote:

> *) The old /dev/epoll access has been dropped with this release.

Four things:

1) 
unsure if it should still live in drivers/char then.

2) 
The 'drop an event on insertion' feature works as advertised. I'm unable to
trigger the much feared & discussed race condition.

>From a cursory glance at the code, I wonder if this condition might return
on SMP. I'm a complete locking nono, but as far as I can see there is no
protection against fd meeting its poll condition between here:

        /* Attach the item to the poll hooks */
        poll_initwait_ex(&pt, 1, ep_ptable_queue_proc, dpi);
        revents = tfile->f_op->poll(tfile, &pt);   // <- get poll condition
        poll_freewait(&pt);

        /* We have to drop the new item inside our item list to keep track of it */
        write_lock_irqsave(&ep->lock, flags);

        list_add(&dpi->llink, ep_hash_entry(ep, ep_hash_index(ep, tfile)));

and here:

        /* If the file is already "ready" we drop him inside the ready list */
        if (revents & pfd->events)
                list_add(&dpi->rdllink, &ep->rdllist);

        write_unlock_irqrestore(&ep->lock, flags);

Which would again lead us to miss the edge. But I may be wildly wrong about
this.

3)
Using epoll on tty behaves weirdly, I think this is a bug. I see epoll_wait
returning immediately, but it returns 0, even though I set timeout to
infinite (-1). 'Exploit code:'

#include <stdio.h>
#include <errno.h>
#include <asm/page.h> 
#include <asm/poll.h> 
#include <linux/linkage.h>
#include <linux/eventpoll.h>
#include <linux/unistd.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

#define __sys_epoll_create(maxfds) _syscall1(int, sys_epoll_create, int, maxfds)
#define __sys_epoll_ctl(epfd, op, fd, events) _syscall4(int, sys_epoll_ctl, \
int, epfd, int, op, int, fd, unsigned int, events)

#define __sys_epoll_wait(epfd, events, maxevents, timeout) _syscall4(int, sys_epoll_wait, \
int, epfd, struct pollfd *, events, int, maxevents,int, timeout)

__sys_epoll_create(maxfds)
__sys_epoll_ctl(epfd, op, fd, events)
__sys_epoll_wait(epfd, events, maxevents, timeout)

int main()
{
	int kdpfd;
	struct pollfd pfds[100];
	int nfds;
	int n;
	char line[80];
	int ret;
	
	if ((kdpfd = sys_epoll_create(10)) < 0) {
        	perror("sys_epoll_create");
                return -1;
        }
	
        if (sys_epoll_ctl(kdpfd, EP_CTL_ADD, 0, POLLIN ) < 0) {
		fprintf(stderr, "sys_epoll set insertion error: fd=%d\n", 0);
		return -1;
	}                           
	
	for(;;) {
		nfds = sys_epoll_wait(kdpfd, pfds, 100, -1);	
		fprintf(stderr,"sys_epoll_wait returned: %d\n",nfds);
		
		for(n=0;n<nfds;++n) {
			if((ret=read(pfds[n].fd,line,79))>0)
				printf("read from fd %d: '%.*s'\n", pfds[n].fd, ret>1 ? ret-1 : 0,line);
		}
	}
	
	return 0;
}

This code runs more as expected when redirecting stderr to a file, strangely
enough. In that case, epoll_wait returns 0 once per keystroke, but only
returns '1' after enter is pressed.

4)
Behaviour when exceeding 'maxevents' edges on epoll_wait. At one point I
managed to get epoll to 'forget' a socket and never more return
events for it. As yet, I've been unable to reproduce this, but I saw it
happen. Not entirely sure what the semantics are in that case, the code in
the kernel appears to suggest that events will then be reported on the next
call to epoll_wait?

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
