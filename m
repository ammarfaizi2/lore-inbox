Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbSKUA5A>; Wed, 20 Nov 2002 19:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266233AbSKUA47>; Wed, 20 Nov 2002 19:56:59 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:62852 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S266199AbSKUA46>; Wed, 20 Nov 2002 19:56:58 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 20 Nov 2002 17:04:41 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Mark Mielke <mark@mark.mielke.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <20021121005502.GE12650@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0211201703050.974-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2002, Jamie Lokier wrote:

> That is a good idea, if we go for the union.

This is the include file I'm thinking to submit to Ulrich for glibc
inclusion :



#ifndef	_SYS_EPOLL_H
#define	_SYS_EPOLL_H	1

#include <sys/types.h>


enum EPOLL_EVENTS {
	EPOLLIN = 0x001,
#define EPOLLIN EPOLLIN

	EPOLLPRI = 0x002,
#define EPOLLPRI EPOLLPRI

	EPOLLOUT = 0x004,
#define EPOLLOUT EPOLLOUT

#ifdef __USE_XOPEN

	EPOLLRDNORM = 0x040,
#define EPOLLRDNORM EPOLLRDNORM

	EPOLLRDBAND = 0x080,
#define EPOLLRDBAND EPOLLRDBAND

	EPOLLWRNORM = 0x100,
#define EPOLLWRNORM EPOLLWRNORM

	EPOLLWRBAND = 0x200,
#define EPOLLWRBAND EPOLLWRBAND

#endif

#ifdef __USE_GNU
	EPOLLMSG = 0x400,
#define EPOLLMSG EPOLLMSG
#endif

	EPOLLERR = 0x008,
#define EPOLLERR EPOLLERR

	EPOLLHUP = 0x010
#define EPOLLHUP EPOLLHUP

};



/* Valid opcodes to issue to epoll_ctl() */
#define EPOLL_CTL_ADD 1	/* Add a file decriptor to the interface */
#define EPOLL_CTL_DEL 2	/* Remove a file decriptor from the interface */
#define EPOLL_CTL_MOD 3	/* Change file decriptor epoll_event structure */


typedef union epoll_obj {
	void *ptr;
	int fd;
	__uint32_t u32[2];
	__uint64_t u64;
} epoll_obj_t;

struct epoll_event {
	unsigned short events;	/* Required events */
	unsigned short revents;	/* Returned events */
	epoll_obj_t data;	/* User data variable */
};


__BEGIN_DECLS

/*
 * Creates an epoll interface by suggesting the requested size in terms
 * of file descriptors that will be presumably stored inside the interface.
 * The integer returned by epoll_create() should be closed with close().
 */
extern int epoll_create(int size);

/*
 * Controller function for the epoll interface. Valid values for the "op"
 * parameter are the EPOLL_CTL_* constant defined above. The "fd" parameter
 * is the target of the operation while the "event" parameter describe which
 * events the caller is interested in and the data ( obj ) he associates
 * the the file "fd".
 */
extern int epoll_ctl(int epfd, int op, int fd, struct epoll_event *event) __THROW;

/*
 * Wait for events on the epoll interface. The function will return the number
 * of events that will be available inside the memory area pointed by "events".
 * Up to "maxevents" events will be copied. The "timeout" parameter enable the
 * caller to specify a miximum wait time in milliseconds ( -1 == infinite ).
 */
extern int epoll_wait(int epfd, struct epoll_event *events, int maxevents,
		      int timeout) __THROW;

__END_DECLS


#endif /* #ifndef _SYS_EPOLL_H */



Comments ?






- Davide


