Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934488AbWKYDz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934488AbWKYDz3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 22:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935138AbWKYDz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 22:55:29 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:34698 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S934488AbWKYDz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 22:55:28 -0500
Date: Fri, 24 Nov 2006 20:55:27 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] Introduce mutex_lock_timeout
Message-ID: <20061125035526.GF14076@parisc-linux.org>
References: <20061109182721.GN16952@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109182721.GN16952@parisc-linux.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No comment on this?

On Thu, Nov 09, 2006 at 11:27:21AM -0700, Matthew Wilcox wrote:
> 
> We have a couple of places in the tree that really could do with a
> down_timeout() function.  I noticed it in qla2xxx and ACPI, but maybe
> there are others that don't have the courtesy of putting "I wish we had
> a down_timeout" comment beside their implementation.
> 
> I don't really want to poke at 25 different implementations of
> down_timeout, but doing a mutex_timeout() seems easy enough, and at
> least qla2xxx can use it.
> 
> I mused on whether to put the timeout argument into the struct
> mutex, but on the whole, I thought it better to somewhat penalise
> mutex_lock_interruptible(), mutex_lock_nested and the mutex lock slowpaths
> in time than it was to penalise all mutex users in space.
> 
> Here's the patch to add mutex_lock_timeout().  I booted the resulting
> kernel on a parisc machine, but I wouldn't claim to have done any real
> testing.  It's fairly mechanical though.
> 
> diff --git a/include/asm-arm/mutex.h b/include/asm-arm/mutex.h
> index cb29d84..6fa4e5f 100644
> --- a/include/asm-arm/mutex.h
> +++ b/include/asm-arm/mutex.h
> @@ -44,7 +44,8 @@ __mutex_fastpath_lock(atomic_t *count, f
>  }
>  
>  static inline int
> -__mutex_fastpath_lock_retval(atomic_t *count, fastcall int (*fail_fn)(atomic_t *))
> +__mutex_fastpath_lock_retval(atomic_t *count, long jiffies,
> +			fastcall int (*fail_fn)(atomic_t *, long jiffies))
>  {
>  	int __ex_flag, __res;
>  
> @@ -60,7 +61,7 @@ __mutex_fastpath_lock_retval(atomic_t *c
>  
>  	__res |= __ex_flag;
>  	if (unlikely(__res != 0))
> -		__res = fail_fn(count);
> +		__res = fail_fn(count, jiffies);
>  	return __res;
>  }
>  
> diff --git a/include/asm-generic/mutex-dec.h b/include/asm-generic/mutex-dec.h
> index 0134151..92a93df 100644
> --- a/include/asm-generic/mutex-dec.h
> +++ b/include/asm-generic/mutex-dec.h
> @@ -37,10 +37,11 @@ __mutex_fastpath_lock(atomic_t *count, f
>   * or anything the slow path function returns.
>   */
>  static inline int
> -__mutex_fastpath_lock_retval(atomic_t *count, fastcall int (*fail_fn)(atomic_t *))
> +__mutex_fastpath_lock_retval(atomic_t *count, long jiffies,
> +				fastcall int (*fail_fn)(atomic_t *, long))
>  {
>  	if (unlikely(atomic_dec_return(count) < 0))
> -		return fail_fn(count);
> +		return fail_fn(count, jiffies);
>  	else {
>  		smp_mb();
>  		return 0;
> diff --git a/include/asm-generic/mutex-null.h b/include/asm-generic/mutex-null.h
> index e1bbbc7..5a65210 100644
> --- a/include/asm-generic/mutex-null.h
> +++ b/include/asm-generic/mutex-null.h
> @@ -11,7 +11,8 @@ #ifndef _ASM_GENERIC_MUTEX_NULL_H
>  #define _ASM_GENERIC_MUTEX_NULL_H
>  
>  #define __mutex_fastpath_lock(count, fail_fn)		fail_fn(count)
> -#define __mutex_fastpath_lock_retval(count, fail_fn)	fail_fn(count)
> +#define __mutex_fastpath_lock_retval(count, jiffies, fail_fn)	\
> +						fail_fn(count, jiffies)
>  #define __mutex_fastpath_unlock(count, fail_fn)		fail_fn(count)
>  #define __mutex_fastpath_trylock(count, fail_fn)	fail_fn(count)
>  #define __mutex_slowpath_needs_to_unlock()		1
> diff --git a/include/asm-generic/mutex-xchg.h b/include/asm-generic/mutex-xchg.h
> index 6a7e8c1..b5eee4e 100644
> --- a/include/asm-generic/mutex-xchg.h
> +++ b/include/asm-generic/mutex-xchg.h
> @@ -42,10 +42,11 @@ __mutex_fastpath_lock(atomic_t *count, f
>   * or anything the slow path function returns
>   */
>  static inline int
> -__mutex_fastpath_lock_retval(atomic_t *count, fastcall int (*fail_fn)(atomic_t *))
> +__mutex_fastpath_lock_retval(atomic_t *count, long jiffies,
> +			fastcall int (*fail_fn)(atomic_t *, long))
>  {
>  	if (unlikely(atomic_xchg(count, 0) != 1))
> -		return fail_fn(count);
> +		return fail_fn(count, jiffies);
>  	else {
>  		smp_mb();
>  		return 0;
> diff --git a/include/asm-i386/mutex.h b/include/asm-i386/mutex.h
> index 7a17d9e..7e13ded 100644
> --- a/include/asm-i386/mutex.h
> +++ b/include/asm-i386/mutex.h
> @@ -51,11 +51,11 @@ do {									\
>   * or anything the slow path function returns
>   */
>  static inline int
> -__mutex_fastpath_lock_retval(atomic_t *count,
> -			     int fastcall (*fail_fn)(atomic_t *))
> +__mutex_fastpath_lock_retval(atomic_t *count, long jiffies,
> +			     int fastcall (*fail_fn)(atomic_t *, long))
>  {
>  	if (unlikely(atomic_dec_return(count) < 0))
> -		return fail_fn(count);
> +		return fail_fn(count, jiffies);
>  	else
>  		return 0;
>  }
> diff --git a/include/asm-ia64/mutex.h b/include/asm-ia64/mutex.h
> index bed73a6..151f067 100644
> --- a/include/asm-ia64/mutex.h
> +++ b/include/asm-ia64/mutex.h
> @@ -36,10 +36,11 @@ __mutex_fastpath_lock(atomic_t *count, v
>   * or anything the slow path function returns.
>   */
>  static inline int
> -__mutex_fastpath_lock_retval(atomic_t *count, int (*fail_fn)(atomic_t *))
> +__mutex_fastpath_lock_retval(atomic_t *count, long jiffies,
> +				int (*fail_fn)(atomic_t *, long))
>  {
>  	if (unlikely(ia64_fetchadd4_acq(count, -1) != 1))
> -		return fail_fn(count);
> +		return fail_fn(count, jiffies);
>  	return 0;
>  }
>  
> diff --git a/include/asm-x86_64/mutex.h b/include/asm-x86_64/mutex.h
> index 16396b1..18668fa 100644
> --- a/include/asm-x86_64/mutex.h
> +++ b/include/asm-x86_64/mutex.h
> @@ -46,11 +46,11 @@ do {									\
>   * or anything the slow path function returns
>   */
>  static inline int
> -__mutex_fastpath_lock_retval(atomic_t *count,
> -			     int fastcall (*fail_fn)(atomic_t *))
> +__mutex_fastpath_lock_retval(atomic_t *count, long jiffies
> +			     int fastcall (*fail_fn)(atomic_t *, long))
>  {
>  	if (unlikely(atomic_dec_return(count) < 0))
> -		return fail_fn(count);
> +		return fail_fn(count, jiffies);
>  	else
>  		return 0;
>  }
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index 27c48da..b70caf2 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -122,6 +122,7 @@ static inline int fastcall mutex_is_lock
>   */
>  extern void fastcall mutex_lock(struct mutex *lock);
>  extern int fastcall mutex_lock_interruptible(struct mutex *lock);
> +extern int fastcall mutex_lock_timeout(struct mutex *lock, long jiffies);
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  extern void mutex_lock_nested(struct mutex *lock, unsigned int subclass);
> diff --git a/kernel/mutex.c b/kernel/mutex.c
> index 8c71cf7..d2ec4d3 100644
> --- a/kernel/mutex.c
> +++ b/kernel/mutex.c
> @@ -122,7 +122,8 @@ EXPORT_SYMBOL(mutex_unlock);
>   * Lock a mutex (possibly interruptible), slowpath:
>   */
>  static inline int __sched
> -__mutex_lock_common(struct mutex *lock, long state, unsigned int subclass)
> +__mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
> +			long jiffies)
>  {
>  	struct task_struct *task = current;
>  	struct mutex_waiter waiter;
> @@ -158,19 +159,19 @@ __mutex_lock_common(struct mutex *lock, 
>  		 * TASK_UNINTERRUPTIBLE case.)
>  		 */
>  		if (unlikely(state == TASK_INTERRUPTIBLE &&
> -						signal_pending(task))) {
> +				(signal_pending(task) || jiffies == 0))) {
>  			mutex_remove_waiter(lock, &waiter, task->thread_info);
>  			mutex_release(&lock->dep_map, 1, _RET_IP_);
>  			spin_unlock_mutex(&lock->wait_lock, flags);
>  
>  			debug_mutex_free_waiter(&waiter);
> -			return -EINTR;
> +			return jiffies ? -EINTR : -ETIMEDOUT;
>  		}
>  		__set_task_state(task, state);
>  
>  		/* didnt get the lock, go to sleep: */
>  		spin_unlock_mutex(&lock->wait_lock, flags);
> -		schedule();
> +		jiffies = schedule_timeout(jiffies);
>  		spin_lock_mutex(&lock->wait_lock, flags);
>  	}
>  
> @@ -194,7 +195,8 @@ __mutex_lock_slowpath(atomic_t *lock_cou
>  {
>  	struct mutex *lock = container_of(lock_count, struct mutex, count);
>  
> -	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0);
> +	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0,
> +						MAX_SCHEDULE_TIMEOUT);
>  }
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> @@ -202,7 +204,8 @@ void __sched
>  mutex_lock_nested(struct mutex *lock, unsigned int subclass)
>  {
>  	might_sleep();
> -	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass);
> +	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass,
> +						MAX_SCHEDULE_TIMEOUT);
>  }
>  
>  EXPORT_SYMBOL_GPL(mutex_lock_nested);
> @@ -256,10 +259,10 @@ __mutex_unlock_slowpath(atomic_t *lock_c
>  
>  /*
>   * Here come the less common (and hence less performance-critical) APIs:
> - * mutex_lock_interruptible() and mutex_trylock().
> + * mutex_lock_interruptible(), mutex_lock_timeout and mutex_trylock().
>   */
>  static int fastcall noinline __sched
> -__mutex_lock_interruptible_slowpath(atomic_t *lock_count);
> +__mutex_lock_interruptible_slowpath(atomic_t *lock_count, long jiffies);
>  
>  /***
>   * mutex_lock_interruptible - acquire the mutex, interruptable
> @@ -275,18 +278,39 @@ __mutex_lock_interruptible_slowpath(atom
>  int fastcall __sched mutex_lock_interruptible(struct mutex *lock)
>  {
>  	might_sleep();
> -	return __mutex_fastpath_lock_retval
> -			(&lock->count, __mutex_lock_interruptible_slowpath);
> +	return __mutex_fastpath_lock_retval(&lock->count,
> +		MAX_SCHEDULE_TIMEOUT, __mutex_lock_interruptible_slowpath);
>  }
>  
>  EXPORT_SYMBOL(mutex_lock_interruptible);
>  
> +/**
> + * mutex_lock_timeout - try to acquire the mutex and fail if it takes too long
> + * @lock: the mutex to be acquired
> + * @timeout: the number of jiffies to wait
> + *
> + * Lock the mutex like mutex_lock(), and return 0 if the mutex has
> + * been acquired or sleep until the mutex becomes available. If a
> + * signal arrives while waiting for the lock then this function
> + * returns -EINTR.  If the timeout expires, it returns -ETIMEDOUT.
> + *
> + * This function is similar to (but not equivalent to) down_interruptible().
> + */
> +int fastcall __sched mutex_lock_timeout(struct mutex *lock, long jiffies)
> +{
> +	might_sleep();
> +	return __mutex_fastpath_lock_retval(&lock->count, jiffies,
> +					__mutex_lock_interruptible_slowpath);
> +}
> +
> +EXPORT_SYMBOL(mutex_lock_timeout);
> +
>  static int fastcall noinline __sched
> -__mutex_lock_interruptible_slowpath(atomic_t *lock_count)
> +__mutex_lock_interruptible_slowpath(atomic_t *lock_count, long jiffies)
>  {
>  	struct mutex *lock = container_of(lock_count, struct mutex, count);
>  
> -	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE, 0);
> +	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE, 0, jiffies);
>  }
>  
>  /*
