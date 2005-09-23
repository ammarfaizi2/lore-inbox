Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbVIWR21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVIWR21 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbVIWR21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:28:27 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:16110 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1750844AbVIWR20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:28:26 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 23 Sep 2005 10:31:05 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Vadim Lobanov <vlobanov@speakeasy.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] epoll
In-Reply-To: <Pine.LNX.4.58.0509222254390.5524@shell2.speakeasy.net>
Message-ID: <Pine.LNX.4.63.0509231027300.10222@localhost.localdomain>
References: <Pine.LNX.4.58.0509221950010.15726@shell2.speakeasy.net>
 <Pine.LNX.4.63.0509222233020.7372@localhost.localdomain>
 <Pine.LNX.4.58.0509222254390.5524@shell2.speakeasy.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2005, Vadim Lobanov wrote:

> On Thu, 22 Sep 2005, Davide Libenzi wrote:
>
>> This born from the initial epoll implementation, that was using the size
>> parameter to size the hash. Since now epoll uses rbtrees, the parameter is
>> no more used. Changing the API to remove it, and break userspace, was/is
>> not a good idea.
>>
>
> Any thoughts on allowing a size of '0'?

We would need to change man pages for that, and this IMHO w/out a strong 
reason of doing so.



>> Yes, it is nicer if epoll behaves like poll. (*)
>>
>
> No patch needed from me here, then?

No need thx. I'll be sending the one-liner to the list right now.



>>> 3. Wakeup
>>> As determined by testing with userland code, the sys_tgkill() and
>>> sys_tkill() functions currently will NOT wake up a sleeping
>>> epoll_wait(). Effectively, this means that epoll_wait() is NOT a pthread
>>> cancellation point. There are two potential issues with this:
>>> - epoll_wait() meets the unofficial(?) definition of a "system call that
>>> may block".
>>> - epoll_wait() behaves differently from poll() and friends.
>>
>> The epoll_wait() wait loop is the standard one that even poll() uses (prep
>> wait, make interruptible, test signals, sched timeo). So if poll() is woke
>> up, so should epoll_wait(). A minimal code snippet that proves poll()
>> behing woke up, and epoll_wait() not, would help.
>>
>
> Certainly. :-) See end of email for sample program.

I'm afraid you need to bug the glibc guys, since I think they wrap 
sys_poll(). Try the test program below, when defining _X_, that makes it 
call sys_poll() directly. It will have the same epoll_wait() behaviour.




- Davide





#include <sys/epoll.h>
#include <sys/poll.h>
#include <pthread.h>
#include <stdio.h>
#include <linux/unistd.h>
#include <errno.h>
#include <unistd.h>


#define __NR_xpoll __NR_poll

#define __sys_xpoll(ufds, nfds, timeout) _syscall3(int, xpoll, struct pollfd *, ufds, \
 						   unsigned int, nfds, long, timeout)

__sys_xpoll(ufds, nfds, timeout);


void * run (int * fd) {
 	struct epoll_event result;

 	printf("Wait forever while polling.\n");
#if defined(_E_)
 	epoll_wait(*fd, &result, 1, -1);
#elif defined(_X_)
 	xpoll(NULL, 0, -1);
#else
 	poll(NULL, 0, -1);
#endif
 	printf("Uhoh! Something is borked!\n");

 	return NULL;
}

int main (void) {
 	int events;
 	pthread_t thread;

#if defined(_E_)
 	events = epoll_create(1);
#endif
 	pthread_create(&thread, NULL, (void * (*) (void *))run, &events);
 	getchar();
 	printf("Try to kill the thread.\n");
 	pthread_cancel(thread);
 	pthread_join(thread, NULL);
 	printf("Success.\n");
#if defined(_E_)
 	close(events);
#endif

 	return 0;
}

