Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312248AbSCYCZ5>; Sun, 24 Mar 2002 21:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312253AbSCYCZr>; Sun, 24 Mar 2002 21:25:47 -0500
Received: from [202.135.142.196] ([202.135.142.196]:39434 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S312248AbSCYCZh>; Sun, 24 Mar 2002 21:25:37 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Ulrich Drepper <drepper@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores) 
In-Reply-To: Your message of "Sun, 24 Mar 2002 19:25:20 BST."
             <3C9E1A10.F7AA6D6E@loewe-komp.de> 
Date: Mon, 25 Mar 2002 13:28:44 +1100
Message-Id: <E16pKE0-0004Rb-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3C9E1A10.F7AA6D6E@loewe-komp.de> you write:
> I can't see a reason why the ack-futex is needed. I think we can simply
> delete it.
> When deleted, the broadcast wouldn't block on ack (also preventing 
> schedule ping-pong). With the cond->lock it's save to have several
> broadcasters. That's fine.

No, you might end up waking someone who did the pthread_cond_wait()
after you did the pthread_cond_broadcast in place of one of the
existing pthread_cond_wait() threads.

I don't believe this is allowed.  

> But:
> static int __pthread_cond_wait(pthread_cond_t *cond,
>                                pthread_mutex_t *mutex,
>                                const struct timespec *reltime)
> {
>         int ret;
> 
>         /* Increment first so broadcaster knows we are waiting. */
> 	futex_down(&cond->lock);
>         atomic_inc(cond->num_waiting);
> (*)     futex_up(&mutex, 1);
> a)	futex_up(&cond->lock, 1);  [move into syscall]
>         do {
> b)                ret = futex_down_time(&cond, ABSTIME); [cond_timed_wait]
>         } while (ret < 0 && errno == EINTR);
> 	[futex_up(&cond->lock, 1); /* release condvar */]
> 
>         futex_down(&mutex->futex);
>         return ret;
> }
> 
> With the original code, we have a "signal/broadcast lost window (a->b)" 
> that shouldn't be there:

Where?  Having done the inc, the futex_up at (a) will fall through,
giving the "thread behaves as if it [signal or broadcast] were issued
after the about-to-block thread has blocked."

> So we would need to enhance the futex_down_timed() call, to
> atomically release the cond->lock on entry, re-aquiring on exit (because
> of the loop).
> This boils down to a cond_var syscall to me (wouldn't sys_ulock(,,OP)
> a better name ? with OPs like MUTEX_UP,MUTEX_DOWN, SEMA_UPn, SEMA_DOWNn, 
> COND_WAIT, COND_TIMED_WAIT, COND_SIGNAL, COND_BROADCAST, RWLOCK_WRLOCK,
> RWLOCK_RDLOCK,RWLOCK_UNLOCK)

You're talking about a completely different beast.

So the summary is: futexes not sufficient to implement pthreads
locking.  That's fine; I can drop all the "extension for pthreads"
futex patches and leave the code as-is ('cept the UP_FAIR patch, which
is independent of this debate).

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
