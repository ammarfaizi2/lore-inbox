Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbUK2L0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbUK2L0C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 06:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUK2L0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 06:26:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48105 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261677AbUK2LZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 06:25:09 -0500
Date: Mon, 29 Nov 2004 06:24:26 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, ahu@ds9a.nl, drepper@redhat.com
Subject: Re: Futex queue_me/get_user ordering
Message-ID: <20041129112426.GO10340@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20041113164048.2f31a8dd.akpm@osdl.org> <20041114090023.GA478@mail.shareable.org> <20041114010943.3d56985a.akpm@osdl.org> <20041114092308.GA4389@mail.shareable.org> <4197FF42.9070706@jp.fujitsu.com> <20041115020148.GA17979@mail.shareable.org> <41981D4D.9030505@jp.fujitsu.com> <20041115132218.GB25502@mail.shareable.org> <20041117084703.GL10340@devserv.devel.redhat.com> <20041126170649.GA8188@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041126170649.GA8188@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2004 at 05:06:49PM +0000, Jamie Lokier wrote:

Let's start with the questions:

> A few questions:
> 
>       1. Why are total_seq and so on 64 bit quantities?
> 
>          The comparison problem on overflow is solvable by changing
>          (total_seq > wakeup_seq) to (int32_t) (total_seq -
>          wakeup_seq) > 0, just like the kernel does with jiffies.
> 
>          If you imagine the number of waiters to exceed 2^31, you have
>          bigger problems, because:
> 
>       2. futex is 32 bits and can overflow.  If a waiter blocks, then
>          a waker is called 2^32 times in succession before the waiter
>          can schedule again, the waiter will remain blocked after the
>          waker returns.
> 
>          This is unlikely, except where it's done deliberately
>          (e.g. SIGSTOP/CONT), and it's a bug and it only needs two
>          threads!  It could perhaps be used for denial of service.

The only problem with the 32-bit overflow is if you get scheduled
away in between releasing the CV's internal lock, i.e.
lll_mutex_unlock (cond->__data.__lock);
and
        if (get_user(curval, (int __user *)uaddr) != 0) {
in kernel and don't get scheduled again for enough time to reach
this place within 2^31 pthread_cond_{*wait,signal,broadcast} calls.
There are no things on the userland side that would block and
in kernel the only place you can block is down_read on mm's mmap_sem
(but if the writer lock is held that long, other pthread_cond_*
calls couldn't get in either) or the short term spinlocks on the hash
bucket.  SIGSTOP/SIGCONT affect the whole process, so unless you are
talking about process shared condvars, these signals aren't going to help
you in exploiting it.

But, once you get past that point, current NPTL doesn't care if 2^31 or
more other cv calls happen, it uses the 64-bit vars to determine what to
do and they are big enough that overflows on them are just assumed not to
happen.  And only past that point the thread is blocked in longer-term
waiting.

>       3. Why is futex incremented in pthread_cond_wait?
>          I don't see the reason for it.

See
https://www.redhat.com/archives/phil-list/2004-May/msg00023.html
https://www.redhat.com/archives/phil-list/2004-May/msg00022.html

__data.__futex increases in pthread_cond_{signal,broadcast} are so that
pthread_cond_*wait detects pthread_cond_{signal,broadcast} that happened
in between releasing of internal cv lock in the *wait and being queued
on the futex's wait queue.  __data.__futex increases in pthread_cond_*wait
are so that FUTEX_CMP_REQUEUE in pthread_cond_broadcast detects
pthread_cond_*wait that happened in between releasing the internal
lock in *broadcast and test in FUTEX_CMP_REQUEUE.

>       4. In pthread_cond_broadcast, why is the mutex_unlock(lock)
>          dropped before calling FUTEX_CMP_REQUEUE?  Wouldn't it be
>          better to drop the lock just after, in which case
>          FUTEX_REQUEUE would be fine?
> 
>          pthread_cond_signal has no problem with holding the lock
>          across FUTEX_WAKE, and I do not see any reason why that would
>          be different for pthread_cond_broadcast.

Holding the internal lock over requeue kills performance of broadcast,
if you hold the internal lock over the requeue, all the threads you
wake up will block on the internal lock anyway.

	Jakub
