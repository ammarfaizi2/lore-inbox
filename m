Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264685AbSJUABd>; Sun, 20 Oct 2002 20:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264686AbSJUABd>; Sun, 20 Oct 2002 20:01:33 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:48517 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264685AbSJUABc>; Sun, 20 Oct 2002 20:01:32 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 20 Oct 2002 17:16:14 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Hanna Linder <hannal@us.ibm.com>
Subject: [patch] sys_epoll ...
Message-ID: <Pine.LNX.4.44.0210201650000.989-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Per Linus request I implemented a syscall interface to the old /dev/epoll
to avoid the creation of magic inodes inside /dev. Since the new
implementation shares 95% of the code with the old one, the old interface
is maintained for compatibility with existing users. The new syscall
interface adds three system calls ( Linus doesn't like multiplexing ) :


#define EP_CTL_ADD 1
#define EP_CTL_DEL 2
#define EP_CTL_MOD 3

asmlinkage int sys_epoll_create(int maxfds);
asmlinkage int sys_epoll_ctl(int epfd, int op, int fd, unsigned int events);
asmlinkage int sys_epoll_wait(int epfd, struct pollfd **events, int timeout);


The function sys_epoll_create() creates a sys_epoll "object" by allocation
space for "maxfds" descriptors. The sys_epoll "object" is basically a
file descriptor, and this enable the new interface to :

1) Mantain compatibility with the existing interface
2) Avoid the creation of a sys_epoll_close() syscall
3) Reuse 95% of the existing code
4) Inherit the file* automatic cleanup code w/out having to code a
	dedicated one

The function sys_epoll_ctl() is the controller interface and what it does
is pretty obvious. The "op" parameter is either EP_CTL_ADD, EP_CTL_DEL or
EP_CTL_MOD and the parameter "fd" is the target of the operation. The last
parameter "events" is used in both EP_CTL_ADD and EP_CTL_MOD and rapresent
the event interest mask. The function sys_epoll_wait() waits for events by
allowing a maximum timeout "timeout" in milliseconds and returns the
number of events ( struct pollfd ) that the caller will find available at
"*events". The port of the old /dev/epoll to 2.5.44 and the new sys_epoll
are available at :

http://www.xmailserver.org/linux-patches/nio-improve.html#patches




- Davide




