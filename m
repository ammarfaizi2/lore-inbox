Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312302AbSCYEn7>; Sun, 24 Mar 2002 23:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312300AbSCYEns>; Sun, 24 Mar 2002 23:43:48 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:61455 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S312302AbSCYEne>; Sun, 24 Mar 2002 23:43:34 -0500
Date: Mon, 25 Mar 2002 15:46:23 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: pwaechtler@loewe-komp.de, drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Message-Id: <20020325154623.302f9e11.rusty@rustcorp.com.au>
In-Reply-To: <E16pKE0-0004Rb-00@wagner.rustcorp.com.au>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2002 13:28:44 +1100
Rusty Russell <rusty@rustcorp.com.au> wrote:
> So the summary is: futexes not sufficient to implement pthreads
> locking.

So let's go back to the more generic "exporting waitqueues to userspace" idea,
with a twist: we use a userspace address as the identifier on the waitq, which
gives us a unique identifier, but the kernel never actually derefs the
pointer.  (And in my prior kernel code I optimized it so that waking did an
implicit remove; not sure it's a win, so assumed that was removed here).

This gives code as below (Peter, Martin, please check):

/* Assume we have the following operations:

   uwaitq_add(void *uaddr);
   uwaitq_remove(void *uaddr);
   uwaitq_wake(void *uaddr, int wake_all_flag);
   uwaitq_wait(relative timeout);
*/
typedef struct
{
	int counter;
} pthread_mutex_t;

typedef struct 
{
	int condition;
} pthread_cond_t;

typedef struct
{
	unsigned int num_left;
	unsigned int initial_count;
} pthread_barrier_t;

#define PTHREAD_MUTEX_INITIALIZER { { 1 } }
#define PTHREAD_COND_INITIALIZER { 0, { 0 }, { 0 } }

int pthread_barrier_init(struct pthread_barrier_t *barrier,
			 void *addr,
			 unsigned int count)
{
	barrier->num_left = barrier->initial_count = count;
}

int pthread_barrier_wait(struct pthread_barrier_t *barrier)
{
	/* Use barrier address as uwaitq id. */
	uwaitq_add(barrier);
	if (atomic_dec_and_test(&barrier->num_left)) {
		/* Restore barrier. */
		barrier->num_left = barrier->initial_count;
		/* Wake the other threads */
		uwaitq_wake(barrier, 1 /* WAKE_ALL */);
		uwaitq_remove(barrier);
		return 0; /* PTHREAD_BARRIER_SERIAL_THREAD */
	}
	while (uwaitq_wait(NULL) == 0 || errno == EINTR);
	uwaitq_remove(barrier);
	return 1;
}

int pthread_cond_signal(pthread_cond_t *cond)
{
	return uwaitq_wake(cond, 0 /* WAKE_ONE */);
}

int pthread_cond_broadcast(pthread_cond_t *cond)
{
	return uwaitq_wake(cond, 1 /* WAKE_ALL */);
}

static int __pthread_cond_wait(pthread_cond_t *cond,
			       pthread_mutex_t *mutex,
			       const struct timespec *reltime)
{
	int ret;

	uwaitq_add(cond);
	futex_up(&mutex, 1);
	while ((ret = uwaitq_wait(reltime)) == 0 || errno == EINTR);
	uwaitq_remove(cond);
	futex_down(&mutex, NULL);
	return ret;
}

int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex)
{
	return __pthread_cond_wait(cond, mutex, NULL);
}

int pthread_cond_timedwait(pthread_cond_t *cond,
			   pthread_mutex_t *mutex,
			   const struct timespec *abstime)
{
	struct timeval _now;
	struct timespec now, rel;

	/* Absolute to relative */
	gettimeofday(&_now, NULL);
	TIMEVAL_TO_TIMESPEC(&_now, &now);
	if (now.tv_sec > abstime->tv_sec
	    || (now.tv_sec == abstime->tv_sec
		&& now.tv_nsec > abstime->tv_nsec))
		return ETIMEDOUT;

	rel.tv_sec = now.tv_sec - abstime->tv_sec;
	rel.tv_nsec = now.tv_usec - abstime->tv_usec;
	if (rel.tv_nsec < 0) {
		--rel.tv_sec;
		rel.tv_nsec += 1000000000;
	}
	return __pthread_cond_wait(cond, mutex, &rel);
}

-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
