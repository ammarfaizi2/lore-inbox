Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311756AbSCXS0L>; Sun, 24 Mar 2002 13:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311760AbSCXS0C>; Sun, 24 Mar 2002 13:26:02 -0500
Received: from dialin-145-254-143-169.arcor-ip.net ([145.254.143.169]:49412
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S311756AbSCXSZt>; Sun, 24 Mar 2002 13:25:49 -0500
Message-ID: <3C9E1A10.F7AA6D6E@loewe-komp.de>
Date: Sun, 24 Mar 2002 19:25:20 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Martin.Wirth@dlr.de
CC: Rusty Russell <rusty@rustcorp.com.au>, Ulrich Drepper <drepper@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <E16nZqJ-0004mi-00@wagner.rustcorp.com.au> <3C99824B.2040307@dlr.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wirth wrote:
> 
> Rusty Russell wrote:
> 
> >2) Where this is suboptimal,
> 
> Up to know I was too focused on the wait functions, but there is
> also a problem with cond_broadcast (and the mutex-protected version of
> cond_signal): since they may block (on ack or lock) this opens up
> chances for priority inversion like problems. I think to be really
> usefull cond_broacast and cond_signal should have a non-blocking
> behaviour with predictible runtime.
> 
[real world example deleted]
> So for my applications a cond_broadcast blocking for the waiters is
> simply not acceptable.
> 
Exactly.
I can't see a reason why the ack-futex is needed. I think we can simply
delete it.
When deleted, the broadcast wouldn't block on ack (also preventing 
schedule ping-pong). With the cond->lock it's save to have several
broadcasters. That's fine.
But:
static int __pthread_cond_wait(pthread_cond_t *cond,
                               pthread_mutex_t *mutex,
                               const struct timespec *reltime)
{
        int ret;

        /* Increment first so broadcaster knows we are waiting. */
	futex_down(&cond->lock);
        atomic_inc(cond->num_waiting);
(*)     futex_up(&mutex, 1);
a)	futex_up(&cond->lock, 1);  [move into syscall]
        do {
b)                ret = futex_down_time(&cond, ABSTIME); [cond_timed_wait]
        } while (ret < 0 && errno == EINTR);
	[futex_up(&cond->lock, 1); /* release condvar */]

        futex_down(&mutex->futex);
        return ret;
}

With the original code, we have a "signal/broadcast lost window (a->b)" 
that shouldn't be there:

SUSV2 on pthread_cond_[timed]wait:
These functions atomically release mutex(*) and cause the calling 
thread to block on the condition variable cond; atomically here means
"atomically with respect to access by another thread to the mutex and 
then the condition variable". That is, if another thread is able to
acquire the mutex after the about-to-block thread has released it, then 
a subsequent call to pthread_cond_signal() or pthread_cond_broadcast() 
in that thread behaves as if it were issued after the about-to-block 
thread has blocked. 


So we would need to enhance the futex_down_timed() call, to
atomically release the cond->lock on entry, re-aquiring on exit (because
of the loop).
This boils down to a cond_var syscall to me (wouldn't sys_ulock(,,OP)
a better name ? with OPs like MUTEX_UP,MUTEX_DOWN, SEMA_UPn, SEMA_DOWNn, 
COND_WAIT, COND_TIMED_WAIT, COND_SIGNAL, COND_BROADCAST, RWLOCK_WRLOCK,
RWLOCK_RDLOCK,RWLOCK_UNLOCK)

Also note that we have to recalculate the relative time to sleep when
signalled - or just using an absolute time stamp.
If the syscall is interruptible, we open the "signal/broadcast lost 
window (a->b)" again... hmh (Here queuing up RT signals are much better
for handling the wakeup, because you can block them, and they don't get 
lost)

Alternatively when using the uwaitq: they could use a lock to serialize
an add/wait and a possibly parallel wake operation (but with the above
locks you can achieve exactly this)

-- 
-----------------------------------------------------------------------
Peter Waechtler
