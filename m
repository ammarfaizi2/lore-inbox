Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267165AbSKTBw3>; Tue, 19 Nov 2002 20:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267395AbSKTBw2>; Tue, 19 Nov 2002 20:52:28 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:18822 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S267165AbSKTBwS>; Tue, 19 Nov 2002 20:52:18 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 19 Nov 2002 17:59:52 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Edgar Toernig <froese@gmx.de>
cc: Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <3DD9CDB2.2075CCB4@gmx.de>
Message-ID: <Pine.LNX.4.44.0211191721350.1918-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Edgar Toernig wrote:

> > You get EEXIST
> > Well, there's the remote possibility, trying very badly from two threads,
> > to add the same fd twice. It is an harmless condition though.
>
> Just IMHO: I would prefer a different behaviour:
>
> 	int epoll_ctl(int epfd, int fd, int events)
>
> which registers interest for "events" on "fd" and retuns previous
> registered events for that fd (implies that the fd is removed when
> "events" is 0) or -1 for error.
>
> If you don't like it, at least an EP_CTL_GET should be added though.
>
> Btw, what errno for an invalid fd (not epfd)?

I don't like things to happen for magic bits conditions. EPOLL_CTL_ADD
requires the same code internally and is more clear for the user. If
someone won't shoot me before, I think the final interface will be :

#include <bits/poll.h>

#define EPOLLIN POLLIN
...


#define EPOLL_CTL_ADD 1
#define EPOLL_CTL_DEL 2
#define EPOLL_CTL_MOD 3


struct epoll_fd {
	int fd;
	unsigned short events;
	unsigned short revents;
	__uint64_t obj;
};


int epoll_create(int size);
int epoll_ctl(int epfd, int op, struct epollfd *pfd);
int epoll_wait(int epfd, struct epollfd *events, int maxevents, int timeout);


Ulrich, is it right for you or do you want EPOLL* bits to be directly
defined as numbers instead of assuming the POLL* vaules ?


At the very end the opaque object might help in many cases while it won't
hurt other cases.



> > You might find your machine a little bit frozen :)
> > Either 1) I remove the read lock from poll() or 2) I check the condition
> > at insetion time to avoid it. I very much prefer 2)
>
> Hehe, sure.  But could become tricky: someone may build a circular chain
> of epoll-fd-sets.

It'll be possible to add epfd1 inside epfd2, not epfd1 inside epfd1.



> > I'd say yes. SCM_RIGHTS should simply do an in-kernel file* to remote task
> > descriptor mapping.
>
> And what happens then?  Will the set refers to the fds from the sender
> process or of fds of the receiving process (which may not even have
> all those fds open)?

Uhm !? It'll refer to files opened on the other process. To handle this
correctly we should prevent an epoll file to be passed with SCM_RIGHTS in
net/core/scm.c. I mean, no catastrophic things should happen, only the
interface won't work correctly. I don't know if the extra handling code is
worth, but we should definitely put this inside epoll(2).



> Another btw, what happens on close of an fd?  Will it get removed from all
> epoll-fd-sets automatically?

Yes, obviously.




- Davide


