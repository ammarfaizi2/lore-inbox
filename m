Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310256AbSCPLZS>; Sat, 16 Mar 2002 06:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310255AbSCPLZL>; Sat, 16 Mar 2002 06:25:11 -0500
Received: from mail.epost.de ([64.39.38.76]:34759 "EHLO mail.epost.de")
	by vger.kernel.org with ESMTP id <S310261AbSCPLY7>;
	Sat, 16 Mar 2002 06:24:59 -0500
Message-ID: <3C932B2E.90709@dlr.de>
Date: Sat, 16 Mar 2002 12:23:26 +0100
From: Martin Wirth <martin.wirth@dlr.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: de-DE
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <E16m1oK-0006oy-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rusty Russell wrote:

>
>The solution I was referring to before, using full semaphores, would
>look like so:
>
>struct pthread_cond_t
>{
>	int num_waiting;
>	struct futex wait, ack;
>};
>
>#define PTHREAD_COND_INITIALIZER { 0, { 0 }, { 0 } }
>
>int pthread_cond_signal(pthread_cond_t *cond)
>{
>	if (cond->num_waiters)
>		return futex_up(&cond->futex, 1);
>	return 0;
>}
>
>int pthread_cond_broadcast(pthread_cond_t *cond)
>{
>	unsigned int waiters = cond->num_waiting;
>
>	if (waiters) {
>		futex_up(&cond->futex, waiters);
>		/* Wait for ack before returning. */
>		futex_down(&cond->ack);
>	}
>	return 0;
>}
>
>int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex)
>{
>	int ret;
>
>	/* Increment first so broadcaster knows we are waiting. */
>	atomic_inc(cond->num_waiting);
>	futex_up(&mutex, 1);
>	ret = futex_down(&cond);
>	if (atomic_dec_and_test(cond->num_waiting))
>		futex_up(&cond->ack);
>	futex_down(&mutex->futex);
>	return ret;
>}
>
In principle that works. But one of  things that's less nice with 
pthread_cond_wait is
that you sometimes have a (most of the time) unnecessary schedule 
ping-pong, and with the
approach above you always have this (due to ack). And secondly if 
futex_up(&f, N) for N > 1
relies on the chained wakeup in the kernels futex_up routine the 
broadcast may take a while to
complete (the lowest priority waiter penalizes all others queued behind 
him). A semaphore simply is no full replacement for a waitqueue with 
wake_all.

Martin

P.S.  With respect to pthreads I was not thinking of a bloated N:M 
library, but of some simple
fast pthread semantics compatible wrapper for _clone etc.   






