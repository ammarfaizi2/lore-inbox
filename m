Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292270AbSCMECW>; Tue, 12 Mar 2002 23:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292289AbSCMECN>; Tue, 12 Mar 2002 23:02:13 -0500
Received: from [202.135.142.196] ([202.135.142.196]:53772 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S292270AbSCMECE>; Tue, 12 Mar 2002 23:02:04 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: frankeh@watson.ibm.com, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores) 
In-Reply-To: Your message of "Tue, 12 Mar 2002 09:56:42 CDT."
             <20020312145542.2C8613FE06@smtp.linux.ibm.com> 
Date: Wed, 13 Mar 2002 15:02:10 +1100
Message-Id: <E16kzxq-0004HJ-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020312145542.2C8613FE06@smtp.linux.ibm.com> you write:
> > If we basically export "add_to_waitqueue", "del_from_waitqueue",
> > "wait_for_waitqueue" and "wakeup_waitqueue" syscalls, we have a more
> > powerful interface: the kernel need not touch userspace addresses at
> > all (no kmap/kunmap, no worried about spinlocks vs. rwlocks).
> 
> Rusty, aren't you now going back to the design that I implemented after Ben's
> comments. 

> From the get-go, I never touched the user address in the kernel, as
> I thought it would require detailed knowledge of the user level
> locking strategy.

Yes, as with my initial patch (like you, I had a semaphore in the
kernel).  However, with two separate syscalls, you don't need to
allocate anything in the kernel, and still know nothing about the
userspace locking.

> Could you explain, why you need add_to_waitqueue and wait_for_waitqueue as 
> separate calls ? Is it for resolving a race conditions ?

Yep.  Exactly analogous to the kernel idiom (add to queue, check, sleep).
(Except the "waker dequeues us" microoptimization).

> One comment with respect to multiple wait queues and rwsems:
> Again it will allow you to do reader-pref and/or writer-pref, but not 
> something like FIFO, i.e. wake up a writer if first waiter or wake up all 
> readers if first ..... and so on.
> I don't know whether the latter is terrible important ...

(Aside: I'm still reluctant to implement strict FIFO locks until
someone shows a starvation case in the current locks).

I thought about this a little.  If we add a flags arg to the
sys_uwaitq_wake() and make sys_uwaitq_wait() return the flags used by
the waker, and sys_uwaitq_wake return 1 if it woke someone...

	#define UWAITQ_PASSING 1
    up:
	ret = sys_uwaitq_wake(cookie, UWAITQ_PASSING);
	if (ret < 0) return -1;
	/* No waiters actually waiting? */
	if (ret == 0) {
		lock->counter = 1;
		sys_uwaitq_wake(cookie, 0);
	}

    down:
	sys_uwaitq_queue(cookie);
	if (atomic dec counter to 0) {
		sys_uwaitq_queue(0); /* unqueue */
		return 0;
	}
	ret = sys_uwaitq_wait(cookie);
	if (ret < 0)
		return -1;
	if (ret == UWAITQ_PASSING)
		return 0;
	goto down; /* spin again */

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
