Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131328AbRCHLdd>; Thu, 8 Mar 2001 06:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131330AbRCHLdX>; Thu, 8 Mar 2001 06:33:23 -0500
Received: from relay.dera.gov.uk ([192.5.29.49]:49496 "HELO relay.dera.gov.uk")
	by vger.kernel.org with SMTP id <S131328AbRCHLdL>;
	Thu, 8 Mar 2001 06:33:11 -0500
Message-ID: <XFMail.20010308113248.gale@syntax.dera.gov.uk>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
In-Reply-To: <F112MQtFu9NHFto4pxw0000224a@hotmail.com>
Date: Thu, 08 Mar 2001 11:32:48 -0000 (GMT)
From: Tony Gale <gale@syntax.dera.gov.uk>
To: Ying Chen <yingchenb@hotmail.com>
Subject: RE: pthreads related issues
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think the following should explain the performance issue you are
seeing.

Quote from Kaz Kylheku <kaz@ashi.footprints.net>:

-------------------------------------------------------------------

When things run slower on SMP, there are usually these possible
explanations. 

Firstly, there may be cache thrashing: in order for threads to have a
consistent view of shared data across multiple processors, data has to
travel thorugh the interconnecting backplane, switch or what have you,
regardless of how small the footprint of the data is. On a single
processor, no such communication has to take place; the program can
work off the processor's on-chip cache.

Secondly, it may be the case that the threads are strictly alternating
in their acquisition of the mutex, which imposes a severe scheduling
penalty into the execution of the program. Imagine that each time the
producer creates an item, a context switch takes place to the consumer
to remove the item. Such a scenario runs much slower than if the
producer can append a large batch of items which the consumer removes
in one fell swoop when it gets a timeslice.

On Linux, the default mutexes implement a strict fairness policy; when
a mutex is unlocked, ownership is transferred to one of the threads
waiting for it, according to priority---even if some currently running
thread is prime and ready to seize the lock, it must wait its turn.
This behavior can readily lead to strict alternation under SMP,
because
as thread is busy inside the mutex, the other thread can execute on
another processor and independently reach the pthread_mutex_lock()
statement, at which point it is guaranteed that it is eligible to get
that mutex as soon as it is unlocked.

Ulrich Drepper, Xavier Leroy and I have discussed this matter at
length
some months since and decided to leave the mutexes as they are, with
the fairness behavior. You can gain access to alternate behaviors by
using one of the non-portable mutex types.  In glibc2.2 you have the
following:

    enum
    {
      PTHREAD_MUTEX_TIMED_NP,
      PTHREAD_MUTEX_RECURSIVE_NP,
      PTHREAD_MUTEX_ERRORCHECK_NP,
      PTHREAD_MUTEX_ADAPTIVE_NP
    #ifdef __USE_UNIX98
      ,
      PTHREAD_MUTEX_NORMAL = PTHREAD_MUTEX_TIMED_NP,
      PTHREAD_MUTEX_RECURSIVE = PTHREAD_MUTEX_RECURSIVE_NP,
      PTHREAD_MUTEX_ERRORCHECK = PTHREAD_MUTEX_ERRORCHECK_NP,
      PTHREAD_MUTEX_DEFAULT = PTHREAD_MUTEX_NORMAL
    #endif
    #ifdef __USE_GNU
      /* For compatibility.  */
      , PTHREAD_MUTEX_FAST_NP = PTHREAD_MUTEX_ADAPTIVE_NP
    #endif
    };

As you can see, the normal mutex now is PTHREAD_MUTEX_TIMED_NP, in
order to support the pthread_mutex_timedlock operation (which only
works with this mutex type). This mutex also has the fair scheduling
behavior that is so detrimental in some SMP scenarios.   It's
essentially your deluxe model with all the fixin's.

The PTHRED_MUTEX_ADAPTIVE_NP is a new mutex that is intended for high
throughput at the sacrifice of fairness and even CPU cycles.  This
mutex does not transfer ownership to a waiting thread, but rather
allows for competition. Also, over an SMP kernel, the lock operation
uses spinning to retry the lock to avoid the cost of immediate
descheduling. 

Try experimenting with this lock type to see how it affects the
behavior of your program. (To keep the program portable, you can use
#ifdef PTHREAD_ADAPTIVE_INITIALIZER_NP to test for the presence of
this
lock type).

--------------------------------------------------------------------

-tony


On 07-Mar-2001 Ying Chen wrote:
> Hi,
> 
> I think I forgot to include the subject on the email I sent last
> time.
> Not sure how many people saw it. I'm trying to send this message
> again...
> 
> I have two questions on Linux pthread related issues. Would anyone
> be able 
> to help?
> 
> 1. Does any one have some suggestions (pointers) on good kernel
> Linux thread 
> libraries?
> 2. We ran multi-threaded application using Linux pthread library on
> 2-way 
> SMP and UP intel platforms (with both 2.2 and 2.4 kernels). We see 
> significant increase in context switching when moving from UP to
> SMP, and 
> high CPU usage with no performance gain in turns of actual work
> being done 
> when moving to SMP, despite the fact the benchmark we are running
> is 
> CPU-bound. The kernel profiler indicates that the a lot of kernel
> CPU ticks 
> went to scheduling and signaling overheads. Has anyone seen
> something like 
> this before with pthread applications running on SMP platforms? Any
> suggestions or pointers on this subject?
> 

---
E-Mail: Tony Gale <gale@syntax.dera.gov.uk>
When you jump for joy, beware that no-one moves the ground from beneath
your feet.
		-- Stanislaw Lem, "Unkempt Thoughts"

The views expressed above are entirely those of the writer
and do not represent the views, policy or understanding of
any other person or official body.
