Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310561AbSCPTzv>; Sat, 16 Mar 2002 14:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310549AbSCPTze>; Sat, 16 Mar 2002 14:55:34 -0500
Received: from dialin-145-254-147-143.arcor-ip.net ([145.254.147.143]:43524
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S310540AbSCPTzX>; Sat, 16 Mar 2002 14:55:23 -0500
Message-ID: <3C93A1A4.2FDCA723@loewe-komp.de>
Date: Sat, 16 Mar 2002 20:48:52 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.18-ul i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Martin Wirth <martin.wirth@dlr.de>, linux-kernel@vger.kernel.org,
        Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
In-Reply-To: <E16m1oK-0006oy-00@wagner.rustcorp.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> In message <3C922005.50608@loewe-komp.de> you write:
> > Martin Wirth wrote:
> > > Rusty Russell wrote:
> > >
> > >>
> > >> Discussions with Ulrich have reaffirmed my opinion that pthreads are
> > >> crap.  Hence I'm not all that tempted to warp the (nice, clean,
> > >> usable) futex code too far to meet pthreads' wierd needs.
> > >>
> > > Crap or not, there are tons of software based on pthreads and at least
> > > the NGPT team says that Linus
> > > agreed to implement for necessary kernel-infrastructure for a full, fast
> > > pthread implementation.
> 
> Let me clarify my "pthreads are crap" statement.
> 
> I firmly believe that there is a place for clone & futex threaded
> programs, which is not met by pthreads for cleanliness and performance
> reasons, and that such programs will become increasingly important.
> 
> Therefore I refuse to penalise such progressive programs so we can
> have standards compliance.  Hence my insistance on a clean, minimal,
> useful interface.
> 
> > >> However, it's not too hard to implement condition variables using an
> > >> unavailable mutex, if we go for "full" semaphores: ie. not just
> > >> mutexes.  It requires a bit more of a stretch for kernel atomic ops...
> > >>
> > > A full semaphore is nice, but not a full replacement for a waitqueue (or
> > > a pthread condition variable brr..).
> > > For the semaphore you always have to assure that the ups and downs are
> > > balanced, what is not the case
> > > for the condition variable.
> > >
> >
> > also remember pthread_cond_broadcast - waking up _all_ waiting threads.
> > If the woken up threads check their condition and go to sleep again, is
> > up to them ( read: the standard mandates that _all_ get woken up)
> >
> > pthread_cond_signal notifies _one_ thread - which one depends on implementati
> on
> > ( I would like to see a priority based decision )
> 

I have to correct myself. This is the description of SUSV2 about
pthread_cond_signal/broadcast:

---snip---
These two functions are used to unblock threads blocked on a 
condition variable. 

The pthread_cond_signal() call unblocks at least one of the threads 
that are blocked on the specified condition variable cond (if any 
threads are blocked on cond). 

The pthread_cond_broadcast() call unblocks all threads currently 
blocked on the specified condition variable cond. 

If more than one thread is blocked on a condition variable, the 
scheduling policy determines the order in which threads are unblocked. 
When each thread unblocked as a result of a pthread_cond_signal() or 
pthread_cond_broadcast() returns from its call to pthread_cond_wait() 
or pthread_cond_timedwait(), the thread owns the mutex with which it 
called pthread_cond_wait() or pthread_cond_timedwait(). The thread(s) 
that are unblocked contend for the mutex according to the scheduling 
policy (if applicable), and as if each had called pthread_mutex_lock(). 

The pthread_cond_signal() or pthread_cond_broadcast() functions may 
be called by a thread whether or not it currently owns the mutex that 
threads calling pthread_cond_wait() or pthread_cond_timedwait() have 
associated with the condition variable during their waits; however, if 
predictable scheduling behaviour is required, then that mutex is locked 
by the thread calling pthread_cond_signal() or pthread_cond_broadcast(). 

The pthread_cond_signal() and pthread_cond_broadcast() functions have 
no effect if there are no threads currently blocked on cond.

RETURN VALUE

  If successful, the pthread_cond_signal() and pthread_cond_broadcast() 
  functions return zero. Otherwise, an error number is returned to
  indicate the error. 

ERRORS

  The pthread_cond_signal() and pthread_cond_broadcast() function 
  may fail if: 

 [EINVAL]
   The value cond does not refer to an initialised condition variable. 

   These functions will not return an error code of [EINTR]. 
--snip---

So the semantic of a condvar implies that when returning from a 
"succesful" wait [ i.e. not ETIMEDOUT] , the thread owns the mutex. 
Therefore the scheduler _should_ only wake up the highest priority 
waiting thread - it does not matter if we signal or broadcast!
It's the same operation in effect. Perhaps the broadcast is there 
for implementations that wouldn't queue up (or wake up) the waiters 
in priority order?

For this, I think, kernel support is best, since the waiters get 
woken up in priority order giving wake_one semantics.

For pthread_cond_timedwait() a kernel timer is necessary.
So making the signal/broadcast a syscall that does NOT lead to
a context switch would be benefical. At the next scheduling point
the kernel decides whom to wake up, also checking for timed waiters
to return with ETIMEDOUT.

Then there is the issue with a crashing process holding locks.
I think on IRIX the waiters get a trap causing them to die - what
else one could do?

[after writing and deleting some pseudo code]

I think the condvars are best implemented in shmem + kernel semaphores.
The only issue is a pthread_cond_timedwait - but a semaphore op IS
interruptible. Besides alarm(2)/setitimer(2) - what are other timeout 
mechanisms in Linux? 

In QNX Neutrino you have TimerTimeout() to arm a kernel timeout
for any blocking state (to avoid the window in alarm/timer_settime
and the blocking function call)

Without this you can hardly implement a reliable timeout (with
sub second resolution) for pthread_cond_timedwait or sigtimedwait.

So for PTHREAD_PROCESS_PRIVATE one could use futexes - on
PTHREAD_PROCESS_SHARED it has to reside in the kernel anyway and you
naturally have to live with context switches and a performance hit.

Now the problem with N:M threading model: here it's necessary to
prevent the kernel from blocking the whole process? 
Well, what is pthread_setconcurrency(int new_level) for?


And, what is so bad about condvars? How would you implement a 
typical consumer/producer problem?

To cite Stevens (Vol II, page 165): 
... "mutexes are for locking and cannot be used for waiting."
page 167: "A mutex is for locking and a condition variable is for 
waiting. ... and both are needed"

-- 
-----------------------------------------------------------------------
Peter Waechtler
