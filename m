Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293602AbSCSD0z>; Mon, 18 Mar 2002 22:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293603AbSCSD0g>; Mon, 18 Mar 2002 22:26:36 -0500
Received: from [202.135.142.194] ([202.135.142.194]:14854 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S293602AbSCSD0b>; Mon, 18 Mar 2002 22:26:31 -0500
Date: Tue, 19 Mar 2002 14:28:42 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ulrich Drepper <drepper@redhat.com>
Cc: martin.wirth@dlr.de, pwaechtler@loewe-komp.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Message-Id: <20020319142842.0d9291c2.rusty@rustcorp.com.au>
In-Reply-To: <1016412720.2194.16.camel@myware.mynet>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Mar 2002 16:52:00 -0800
Ulrich Drepper <drepper@redhat.com> wrote:

> On Sat, 2002-03-16 at 22:50, Rusty Russell wrote:
> 
> > Only vs. pthread_cond_broadcast.
> 
> No.  pthread_barrier_wait has the same problem.  It has to wake up lots
> of thread.

Hmmm....

What do you WANT in a kernel primitive then?  Given that we now have mutexes,
what else do we need to make pthreads relatively painless?

> > And if you're using that you probably
> > have some other performance issues anyway?
> 
> Why?  Conditional variables are of use in situations with loosely
> coupled threads.

I meant vs. pthread_cond_signal.

Look, here is an example implementation.  Please suggest:
1) Where this is flawed,
2) Where this is suboptimal,
3) What kernel primitive would help to resolve these?

Thanks,
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

/* Assume we have the following semaphore operations:

   futex_down(futex);
   futex_down_time(futex, relative timeout);
   futex_up(futex, count);
*/
typedef struct
{
	struct futex futex;
} pthread_mutex_t;

typedef struct 
{
	int num_waiting;
	struct futex wait, ack;
} pthread_cond_t;

typedef struct
{
	unsigned int num_left;
	struct futex wait;
	unsigned int initial_count;
} pthread_barrier_t;

#define PTHREAD_MUTEX_INITIALIZER { { 1 } }
#define PTHREAD_COND_INITIALIZER { 0, { 0 }, { 0 } }

int pthread_barrier_init(struct pthread_barrier_t *barrier,
			 void *addr,
			 unsigned int count)
{
	barrier->num_left = barrier->initial_count = count;
	barrier->wait.count = 0;
}

int pthread_barrier_wait(struct pthread_barrier_t *barrier)
{
	if (atomic_dec_and_test(&barrier->num_left)) {
		/* Restore barrier. */
		barrier->num_left = barrier->initial_count;
		/* Wake the other threads */
		futex_up(&barrier->wait, barrier->initial_count-1);
		return 0; /* PTHREAD_BARRIER_SERIAL_THREAD */
	}
	while (futex_down(&barrier->wait) == 0 || errno == EINTR);
	return 1;
}

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
		/* Re-initialize ACK.  Could have been upped by
                   pthread_cond_signal and pthread_cond_wait. */
		cond->ack.count = 0;
		futex_up(&cond->futex, waiters);
		/* Wait for ack before returning. */
		futex_down(&cond->ack);
	}
	return 0;
}

static int __pthread_cond_wait(pthread_cond_t *cond,
			       pthread_mutex_t *mutex,
			       const struct timespec *reltime)
{
	int ret;

	/* Increment first so broadcaster knows we are waiting. */
	atomic_inc(cond->num_waiting);
	futex_up(&mutex, 1);
	do {
		ret = futex_down_time(&cond, reltime);
	} while (ret < 0 && errno == EINTR);
	if (atomic_dec_and_test(cond->num_waiting))
		futex_up(&cond->ack);
	futex_down(&mutex->futex);
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
