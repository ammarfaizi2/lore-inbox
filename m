Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293565AbSCPALk>; Fri, 15 Mar 2002 19:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293556AbSCPALb>; Fri, 15 Mar 2002 19:11:31 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:58383 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S293591AbSCPAJs>; Fri, 15 Mar 2002 19:09:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: Martin Wirth <martin.wirth@dlr.de>, linux-kernel@vger.kernel.org,
        Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores) 
In-Reply-To: Your message of "Fri, 15 Mar 2002 17:23:33 BST."
             <3C922005.50608@loewe-komp.de> 
Date: Sat, 16 Mar 2002 11:12:35 +1100
Message-Id: <E16m1oK-0006oy-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3C922005.50608@loewe-komp.de> you write:
> Martin Wirth wrote:
> > Rusty Russell wrote:
> > 
> >>
> >> Discussions with Ulrich have reaffirmed my opinion that pthreads are
> >> crap.  Hence I'm not all that tempted to warp the (nice, clean,
> >> usable) futex code too far to meet pthreads' wierd needs.
> >>
> > Crap or not, there are tons of software based on pthreads and at least 
> > the NGPT team says that Linus
> > agreed to implement for necessary kernel-infrastructure for a full, fast 
> > pthread implementation.

Let me clarify my "pthreads are crap" statement.

I firmly believe that there is a place for clone & futex threaded
programs, which is not met by pthreads for cleanliness and performance
reasons, and that such programs will become increasingly important.

Therefore I refuse to penalise such progressive programs so we can
have standards compliance.  Hence my insistance on a clean, minimal,
useful interface.

> >> However, it's not too hard to implement condition variables using an
> >> unavailable mutex, if we go for "full" semaphores: ie. not just
> >> mutexes.  It requires a bit more of a stretch for kernel atomic ops...
> >>
> > A full semaphore is nice, but not a full replacement for a waitqueue (or 
> > a pthread condition variable brr..).
> > For the semaphore you always have to assure that the ups and downs are 
> > balanced, what is not the case
> > for the condition variable.
> > 
> 
> also remember pthread_cond_broadcast - waking up _all_ waiting threads.
> If the woken up threads check their condition and go to sleep again, is
> up to them ( read: the standard mandates that _all_ get woken up)
> 
> pthread_cond_signal notifies _one_ thread - which one depends on implementati
on
> ( I would like to see a priority based decision )

The solution I was referring to before, using full semaphores, would
look like so:

struct pthread_cond_t
{
	int num_waiting;
	struct futex wait, ack;
};

#define PTHREAD_COND_INITIALIZER { 0, { 0 }, { 0 } }

int pthread_cond_signal(pthread_cond_t *cond)
{
	if (cond->num_waiters)
		return futex_up(&cond->futex, 1);
	return 0;
}

int pthread_cond_broadcast(pthread_cond_t *cond)
{
	unsigned int waiters = cond->num_waiting;

	if (waiters) {
		futex_up(&cond->futex, waiters);
		/* Wait for ack before returning. */
		futex_down(&cond->ack);
	}
	return 0;
}

int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex)
{
	int ret;

	/* Increment first so broadcaster knows we are waiting. */
	atomic_inc(cond->num_waiting);
	futex_up(&mutex, 1);
	ret = futex_down(&cond);
	if (atomic_dec_and_test(cond->num_waiting))
		futex_up(&cond->ack);
	futex_down(&mutex->futex);
	return ret;
}

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
