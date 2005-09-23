Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbVIWGAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbVIWGAO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 02:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbVIWGAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 02:00:14 -0400
Received: from mail23.sea5.speakeasy.net ([69.17.117.25]:41602 "EHLO
	mail23.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751418AbVIWGAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 02:00:12 -0400
Date: Thu, 22 Sep 2005 23:00:11 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Davide Libenzi <davidel@xmailserver.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] epoll
In-Reply-To: <Pine.LNX.4.63.0509222233020.7372@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0509222254390.5524@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0509221950010.15726@shell2.speakeasy.net>
 <Pine.LNX.4.63.0509222233020.7372@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2005, Davide Libenzi wrote:

> On Thu, 22 Sep 2005, Vadim Lobanov wrote:
>
> > 1. Size
> > The size parameter to sys_epoll_create() is simply sanity-checked (has
> > to be greater than zero) and then ignored. I presume the current
> > implementation works perfectly without this parameter, so I am rather
> > curious why it is even passed in. Historical reasons? Future code
> > improvements? On the same note, I'd like to suggest that '0' also should
> > be an allowed value, for the case when the application really does not
> > know what the size estimate should be.
>
> This born from the initial epoll implementation, that was using the size
> parameter to size the hash. Since now epoll uses rbtrees, the parameter is
> no more used. Changing the API to remove it, and break userspace, was/is
> not a good idea.
>

Any thoughts on allowing a size of '0'?

>
> > 2. Timeout
> > It seems that the timeout parameter in sys_epoll_wait() is not handled
> > quite correctly. According to the manpages, a value of '-1' means
> > infinite timeout, but the effect of other negative values is left
> > undefined. In fact, if you run a userland program that calls
> > epoll_wait() with a timeout value of '-2', the kernel prints an error
> > into /var/log/messages from within schedule_timeout(), due to its
> > argument being negative. It seems there are two ways to correct this
> > behavior:
> > - Check the passed timeout for being less than '-1', and return an
> > error. A new errno value needs to be introduced into the epoll_wait()
> > API.
> > - Redefine the epoll_wait() API to accept any negative value as an
> > infinite timeout, and change the code appropriately.
>
> Yes, it is nicer if epoll behaves like poll. (*)
>

No patch needed from me here, then?

>
> > 3. Wakeup
> > As determined by testing with userland code, the sys_tgkill() and
> > sys_tkill() functions currently will NOT wake up a sleeping
> > epoll_wait(). Effectively, this means that epoll_wait() is NOT a pthread
> > cancellation point. There are two potential issues with this:
> > - epoll_wait() meets the unofficial(?) definition of a "system call that
> > may block".
> > - epoll_wait() behaves differently from poll() and friends.
>
> The epoll_wait() wait loop is the standard one that even poll() uses (prep
> wait, make interruptible, test signals, sched timeo). So if poll() is woke
> up, so should epoll_wait(). A minimal code snippet that proves poll()
> behing woke up, and epoll_wait() not, would help.
>

Certainly. :-) See end of email for sample program.

>
> > 4. Code Duplication
> > As sys_tgkill() and sys_tkill() are currently written, a large portion
> > of the two functions is duplicated. It might make sense to pull that
> > equivalent code out into a separate function.
>
> This should be moved in "[RFC] something else" ;)
>

Alright.

>
> > Comments please? In particular, the pthread cancellation issue is
> > worrysome. In the case that any of the above points turn into actual
> > code TODOs, I'll be more than happy to cook up and submit the patches.
>
> [*] No need, since it's a one liner.
>

Here's a sample program that illustrates difference in pthread killing
between poll and epoll:
================================================================
#include <sys/epoll.h>
#include <sys/poll.h>
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

//#define _E_

void * run (int * fd) {
    struct epoll_event result;

    printf("Wait forever while polling.\n");
#ifdef _E_
    epoll_wait(*fd, &result, 1, -1);
#else
    poll(NULL, 0, -1);
#endif
    printf("Uhoh! Something is borked!\n");

    return NULL;
}

int main (void) {
    int events;
    pthread_t thread;

#ifdef _E_
    events = epoll_create(1);
#endif
    pthread_create(&thread, NULL, (void * (*) (void *))run, &events);
    getchar();
    printf("Try to kill the thread.\n");
    pthread_cancel(thread);
    pthread_join(thread, NULL);
    printf("Success.\n");
#ifdef _E_
    close(events);
#endif

    return 0;
}
================================================================
gcc -lpthread -Wall -o test test.c
================================================================

>
> - Davide
>

-Vadim Lobanov
