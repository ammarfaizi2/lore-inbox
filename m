Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261575AbSJ1WBw>; Mon, 28 Oct 2002 17:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSJ1WBw>; Mon, 28 Oct 2002 17:01:52 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:23708 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261572AbSJ1WBs>;
	Mon, 28 Oct 2002 17:01:48 -0500
Date: Mon, 28 Oct 2002 23:08:09 +0100
From: bert hubert <ahu@ds9a.nl>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, davidel@xmailserver.org,
       linux-aio@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] epoll more scalable than poll
Message-ID: <20021028220809.GB27798@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
	davidel@xmailserver.org, linux-aio@vger.kernel.org,
	lse-tech@lists.sourceforge.net
References: <53100000.1035832459@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53100000.1035832459@w-hlinder>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 11:14:19AM -0800, Hanna Linder wrote:

> 	The results of our testing show not only does the system call 
> interface to epoll perform as well as the /dev interface but also that epoll 
> is many times better than standard poll. No other implementations of poll 

Hanna,

Sure that this works? The following trivial program doesn't work on stdinput
when I'd expect it to. It just waits until the timeout passes end then
returns 0. It also does not work on a file, which is to be expected,
although 'select' returns with an immediate availability of data on a file
according to SuS.

Furthermore, there is some const weirdness going on, the ephttpd server has
a different second argument to sys_epoll_wait.

I compile this with:
cc -Wall -I/mnt/linux-2.5.44/include/    epoll.c   -o epoll


#include <stdio.h>
#include <errno.h>
#include <asm/page.h> 
#include <asm/poll.h> 
#include <linux/linkage.h>
#include <linux/eventpoll.h>
#include <linux/unistd.h>

#define __sys_epoll_create(maxfds) _syscall1(int, sys_epoll_create, int, maxfds)
#define __sys_epoll_ctl(epfd, op, fd, events) _syscall4(int, sys_epoll_ctl, \
int, epfd, int, op, int, fd, unsigned int, events)

#define __sys_epoll_wait(epfd, events, timeout) _syscall3(int, sys_epoll_wait, \
int, epfd, struct pollfd const **, events, int, timeout)

__sys_epoll_create(maxfds)
__sys_epoll_ctl(epfd, op, fd, events)
__sys_epoll_wait(epfd, events, timeout)

// asmlinkage int sys_epoll_wait(int epfd, struct pollfd const **events, int timeout);

int main()
{
	int kdpfd;
	struct pollfd const *pfds;
	int nfds;
	int timeout=2;
	
	if ((kdpfd = sys_epoll_create(10)) < 0) {
        	perror("sys_epoll_create");
                return -1;
        }
        if (sys_epoll_ctl(kdpfd, EP_CTL_ADD, 0, POLLIN ) < 0) {
		fprintf(stderr, "sys_epoll set insertion error: fd=%d\n", 0);

		return -1;
	}                                        

	nfds = sys_epoll_wait(kdpfd, &pfds, timeout * 1000);	
	fprintf(stderr,"sys_epoll_wait returned: %d\n",nfds);
	return 0;
}

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
