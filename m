Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312899AbSCZA7U>; Mon, 25 Mar 2002 19:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312900AbSCZA7M>; Mon, 25 Mar 2002 19:59:12 -0500
Received: from [202.135.142.196] ([202.135.142.196]:28174 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S312899AbSCZA66>; Mon, 25 Mar 2002 19:58:58 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: Martin.Wirth@dlr.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores) 
In-Reply-To: Your message of "Mon, 25 Mar 2002 12:56:36 BST."
             <3C9F1074.6030902@loewe-komp.de> 
Date: Tue, 26 Mar 2002 12:02:06 +1100
Message-Id: <E16pfLi-0001lX-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3C9F1074.6030902@loewe-komp.de> you write:
> > 	while ((ret = uwaitq_wait(reltime)) == 0 || errno == EINTR);
> > 	uwaitq_remove(cond);
> > 	futex_down(&mutex, NULL);
> > 	return ret;
> > }
> 
> 
> I assume that uwaitq_wait() will modify the reltime (which is legal)
> if signalled. Otherwise we would wait 2*retime, and so on

Oh yeah, I'll have to split that out and handle it.  Not worth having
the kernel do it as it's hardly going to be a fast path...

> Then we have to be careful about errno and the return values:

Sigh.  Yep.  I was pretty lax...

> I assume that uwaitq_wait() will return -1 and errno==ENOENT or similar
> if we are not on the queue (anymore), -1 and ETIMEDOUT on timeout,
> -1 and EINVAL on illegal cond or reltime ,zero on wakeup?

uwaitq_wait() which does not follow a uwaitq_add() would be some kind
of error, yes.  ETIMEDOUT on timeout, yes.  EFAULT on illegal cond
(that's all it can tell, that the address isn't in the user's range),
and 0 on success.

OK, new tidier version...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

/* Assume we have the following operations:

   uwaitq_add(void *uaddr);
   uwaitq_remove(void *uaddr);
   uwaitq_wake(void *uaddr, int wake_all_flag);
   uwaitq_wait(relative timeout);

   And on top of them:
   futex_down(struct futex *);
   futex_up(struct futex *);
*/
typedef struct futex pthread_mutex_t;

typedef struct 
{
	int dummy; /* This could be an empty struct for gcc */
} pthread_cond_t;

typedef struct
{
	unsigned int num_left;
	unsigned int initial_count;
} pthread_barrier_t;

#define PTHREAD_MUTEX_INITIALIZER FUTEX_INITIALIZER
#define PTHREAD_COND_INITIALIZER { 0 }

int pthread_barrier_init(struct pthread_barrier_t *barrier,
			 void *addr,
			 unsigned int count)
{
	barrier->num_left = barrier->initial_count = count;
}

int pthread_barrier_wait(struct pthread_barrier_t *barrier)
{
	int ret;

	/* Use barrier address as uwaitq id. */
	ret = uwaitq_add(barrier);
	if (ret < 0)
		return ret;

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

int pthread_cond_wait(pthread_cond_t *cond, pthread_mutex_t *mutex)
{
	int ret, saved_errno;

	uwaitq_add(cond);
	futex_up(&mutex);
	while ((ret = uwaitq_wait(NULL)) == 0 || errno == EINTR);
	saved_errno = errno;
	uwaitq_remove(cond);
	futex_down(&mutex);
	errno = saved_errno;
	return ret;
}

int pthread_cond_timedwait(pthread_cond_t *cond,
			   pthread_mutex_t *mutex,
			   const struct timespec *abstime)
{
	struct timeval _now;
	struct timespec now, rel;
	int saved_errno, ret;

	/* Absolute to relative */
 again:
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

	uwaitq_add(cond);
	futex_up(&mutex);
	ret = uwaitq_wait(&rel);
	if (ret < 0 && errno == EINTR)
		goto again;

	saved_errno = errno;
	uwaitq_remove(cond);
	futex_down(&mutex);
	errno = saved_errno;

	return ret;
}
