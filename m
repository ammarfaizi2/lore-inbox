Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSKRP6O>; Mon, 18 Nov 2002 10:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSKRP6N>; Mon, 18 Nov 2002 10:58:13 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:25221 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262808AbSKRP6M>; Mon, 18 Nov 2002 10:58:12 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 08:05:32 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Ulrich Drepper <drepper@redhat.com>
Subject: [rfc] epoll interface change and glibc bits ...
Message-ID: <Pine.LNX.4.44.0211180753090.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1) epoll's event structure extension

I received quite a few request to extend the event structure to have space
for an opaque user data object. The eventpoll event structure will turn to
be :

struct epollfd {
	int fd;
	unsigned short int events, revents;
	unsigned long obj;
};

and the epoll_ctl() function will turn to :

int epoll_ctl(int epfd, int op, struct epollfd *pfd);



2) epoll bits in glibc

I was talking to Ulrich Drepper about adding epoll bits inside glibc. His
first objection was to store epoll bits inside poll.h, that IMHO is wrong
because epoll semantics are completely different from poll(). My idea of
the <sys/epoll.h> include file would be this :

#ifndef _SYS_EPOLL_H
#define _SYS_EPOLL_H 1

#include <bits/poll.h>

/* Valid opcodes to issue to sys_epoll_ctl() */
#define EP_CTL_ADD 1
#define EP_CTL_DEL 2
#define EP_CTL_MOD 3

struct epollfd {
        int fd;
        unsigned short int events, revents;
        unsigned long obj;
};

__BEGIN_DECLS

extern int epoll_create(int size);
extern int epoll_ctl(int epfd, int op, struct epollfd *pfd) THROW;
extern int epoll_wait(int epfd, struct epollfd *events, int maxevents,
                      int timeout) THROW;

__END_DECLS

#endif  /* sys/epoll.h */


But he does not like epoll to include <bits/poll.h> and he  would like
epoll to redefine POLLIN, POLLOUT, ... to EPOLLIN, EPOLLOUT, ...
In my opinion it is right for epoll to include <bits/poll.h> because those
are bits that f_op->poll() returns, and renaming those bits inside another
include file will require more maintainance. If the kernel will be
extended to support more POLL* bits, they will have to go only inside
<bits/poll.h> w/out having another file to be updated IMHO.



I would like to receive feedback on those issues ...





- Davide



