Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSKXRso>; Sun, 24 Nov 2002 12:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSKXRso>; Sun, 24 Nov 2002 12:48:44 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:17285 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261518AbSKXRsm>; Sun, 24 Nov 2002 12:48:42 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 24 Nov 2002 09:56:38 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Felix von Leitner <felix-kerel@fefe.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: epoll_wait conflicts with man page
In-Reply-To: <20021124174635.GB16255@codeblau.de>
Message-ID: <Pine.LNX.4.50.0211240952190.7401-100000@blue1.dev.mcafeelabs.com>
References: <20021124174635.GB16255@codeblau.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2002, Felix von Leitner wrote:

> I just implemented epoll_create, epoll_ctl and epoll_wait for the diet
> libc and found that epoll_wait in 2.5.59 does not expect struct
> epoll_event* as second argument but actually struct pollfd*.
>
> That makes it more useful in one sense because porting old poll programs
> is easier this way.  On the other hand, it makes the whole API less
> useful because the epoll_ctl call is documented to use struct
> epoll_event which contains opaque user data to enlist a file descriptor.
> This data can now not be passed back to user space because it does not
> fit in struct pollfd.
>
> By the way: the epoll API looks great!  I especially like the opaque
> user specified data thing, however making it a union is not so smart
> because strace can't meaningfully display it.  Also, I would move the
> "int fd" out of the union because it is universally useful to know the
> file descriptor without having to save it in the opaque data.

This will be the file that I'll submit to Ulrich for inclusion in glibc :


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

#endif /* #ifdef __USE_XOPEN */

#ifdef __USE_GNU
	EPOLLMSG = 0x400,
#define EPOLLMSG EPOLLMSG
#endif /* #ifdef __USE_GNU */

	EPOLLERR = 0x008,
#define EPOLLERR EPOLLERR

	EPOLLHUP = 0x010
#define EPOLLHUP EPOLLHUP

};


/* Valid opcodes ( "op" parameter ) to issue to epoll_ctl() */
#define EPOLL_CTL_ADD 1	/* Add a file decriptor to the interface */
#define EPOLL_CTL_DEL 2	/* Remove a file decriptor from the interface */
#define EPOLL_CTL_MOD 3	/* Change file decriptor epoll_event structure */


typedef union epoll_data {
	void *ptr;
	int fd;
	__uint32_t u32;
	__uint64_t u64;
} epoll_data_t;

struct epoll_event {
	__uint32_t events;	/* Epoll events */
	epoll_data_t data;	/* User data variable */
};


__BEGIN_DECLS


/*
 * Creates an epoll instance.
 *
 * Returns an fd for the new instance.
 *
 * The "size" parameter is a hint specifying the number of file
 * descriptors to be associated with the new instance.
 *
 * The fd returned by epoll_create() should be closed with close().
 */
extern int epoll_create(int size);


/*
 * Manipulate an epoll instance "epfd".
 *
 * Returns 0 in case of success, -1 in case of error ( the "errno" variable
 * will contain the specific error code )
 *
 * The "op" parameter is one of the EPOLL_CTL_* constants defined above.
 * The "fd" parameter is the target of the operation.
 * The "event" parameter describes which events the caller is interested
 * in and any associated user data.
 */
extern int epoll_ctl(int epfd, int op, int fd, struct epoll_event *event) __THROW;


/*
 * Wait for events on an epoll instance "epfd".
 *
 * Returns the number of triggered events returned in "events" buffer.
 * Or -1 in case of error with the "errno" variable set to the specific error code.
 *
 * The "events" parameter is a buffer that will contain triggered events.
 * The "maxevents" is the maximum number of events to be returned
 * ( usually size of "events" ).
 * The "timeout" parameter specifies the maximum wait time in milliseconds
 * ( -1 == infinite ).
 */
extern int epoll_wait(int epfd, struct epoll_event *events, int maxevents,
		      int timeout) __THROW;

__END_DECLS


#endif /* #ifndef _SYS_EPOLL_H */


This is waht my current code implements. As soon has Linus will merge my
latest bits ( likely in 2.5.50 ) this will be the interface exposed by the
kernel, and the one that will go in glibc. The latest change is the
removal of "revents" ( Jamie suggestion ) and the usage of "events" for
both setting the interest mask and retrieving the available events.




- Davide


