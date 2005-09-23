Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbVIWSjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbVIWSjM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVIWSjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:39:12 -0400
Received: from mail23.sea5.speakeasy.net ([69.17.117.25]:53649 "EHLO
	mail23.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751131AbVIWSjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:39:10 -0400
Date: Fri, 23 Sep 2005 11:39:03 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] epoll
In-Reply-To: <Pine.LNX.4.63.0509231027300.10222@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0509231123440.9215@shell4.speakeasy.net>
References: <Pine.LNX.4.58.0509221950010.15726@shell2.speakeasy.net>
 <Pine.LNX.4.63.0509222233020.7372@localhost.localdomain>
 <Pine.LNX.4.58.0509222254390.5524@shell2.speakeasy.net>
 <Pine.LNX.4.63.0509231027300.10222@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2005, Davide Libenzi wrote:

> >>> 3. Wakeup
> >>> As determined by testing with userland code, the sys_tgkill() and
> >>> sys_tkill() functions currently will NOT wake up a sleeping
> >>> epoll_wait(). Effectively, this means that epoll_wait() is NOT a pthread
> >>> cancellation point. There are two potential issues with this:
> >>> - epoll_wait() meets the unofficial(?) definition of a "system call that
> >>> may block".
> >>> - epoll_wait() behaves differently from poll() and friends.
> >>
> >> The epoll_wait() wait loop is the standard one that even poll() uses (prep
> >> wait, make interruptible, test signals, sched timeo). So if poll() is woke
> >> up, so should epoll_wait(). A minimal code snippet that proves poll()
> >> behing woke up, and epoll_wait() not, would help.
> >>
> >
> > Certainly. :-) See end of email for sample program.
>
> I'm afraid you need to bug the glibc guys, since I think they wrap
> sys_poll(). Try the test program below, when defining _X_, that makes it
> call sys_poll() directly. It will have the same epoll_wait() behaviour.

I'm still a bit confused by how the pthread implementation fits
together. Correct me if the following is wrong, please:
Whenever the user wants to cancel a pthread, glibc eventually calls
{sys-}tgkill() upon the given thread, causing the kernel to return EINTR
to the blocking system call, in this case epoll_wait(). It is glibc's
job to catch this return value and realize that the thread is ready to be
killed, which it is not doing in the case of epoll_wait().
Or is the "current thread has been cancelled and should be killed" check
happening elsewhere / in some other way?

By the way, I already brought this up on the glibc mailing list (before
I sent it to LKML), and it seems they couldn't care less.
(http://sources.redhat.com/ml/libc-alpha/2005-09/msg00071.html)

> - Davide
>

-Vadim Lobanov

>
> #include <sys/epoll.h>
> #include <sys/poll.h>
> #include <pthread.h>
> #include <stdio.h>
> #include <linux/unistd.h>
> #include <errno.h>
> #include <unistd.h>
>
>
> #define __NR_xpoll __NR_poll
>
> #define __sys_xpoll(ufds, nfds, timeout) _syscall3(int, xpoll, struct pollfd *, ufds, \
>  						   unsigned int, nfds, long, timeout)
>
> __sys_xpoll(ufds, nfds, timeout);
>
>
> void * run (int * fd) {
>  	struct epoll_event result;
>
>  	printf("Wait forever while polling.\n");
> #if defined(_E_)
>  	epoll_wait(*fd, &result, 1, -1);
> #elif defined(_X_)
>  	xpoll(NULL, 0, -1);
> #else
>  	poll(NULL, 0, -1);
> #endif
>  	printf("Uhoh! Something is borked!\n");
>
>  	return NULL;
> }
>
> int main (void) {
>  	int events;
>  	pthread_t thread;
>
> #if defined(_E_)
>  	events = epoll_create(1);
> #endif
>  	pthread_create(&thread, NULL, (void * (*) (void *))run, &events);
>  	getchar();
>  	printf("Try to kill the thread.\n");
>  	pthread_cancel(thread);
>  	pthread_join(thread, NULL);
>  	printf("Success.\n");
> #if defined(_E_)
>  	close(events);
> #endif
>
>  	return 0;
> }
>
>
