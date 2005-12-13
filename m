Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbVLMASt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbVLMASt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 19:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVLMASt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 19:18:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49360 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932253AbVLMASs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 19:18:48 -0500
Date: Mon, 12 Dec 2005 16:19:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-Id: <20051212161944.3185a3f9.akpm@osdl.org>
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> The attached patch introduces a simple mutex implementation as an alternative
> to the usual semaphore implementation where simple mutex functionality is all
> that is required.
> 
> This is useful in two ways:
> 
>  (1) A number of archs only provide very simple atomic instructions (such as
>      XCHG on i386, TAS on M68K, SWAP on FRV) which aren't sufficient to
>      implement full semaphore support directly. Instead spinlocks must be
>      employed to implement fuller functionality.
> 
>  (2) This makes it obvious in what way the semaphore is being used: whether
>      it's being used as a mutex or being used as a counter.
> 
> This patch set does the following:
> 
>  (1) Provides a simple xchg() based semaphore as a default for all
>      architectures that don't wish to override it and provide their own.
> 
>      Overriding is possible by setting CONFIG_ARCH_IMPLEMENTS_MUTEX and
>      supplying asm/mutex.h
> 
>      Partial overriding is possible by #defining mutex_grab(), mutex_release()
>      and is_mutex_locked() to perform the appropriate optimised functions.
> 
>  (2) Provides linux/mutex.h as a common include for gaining access to mutex
>      semaphores.
> 
>  (3) Provides linux/semaphore.h as a common include for gaining access to all
>      the different types of semaphore that may be used from within the kernel.
> 
>  (4) Renames down*() to down_sem*() and up() to up_sem() for the traditional
>      semaphores, and removes init_MUTEX*() and DECLARE_MUTEX*() from
>      asm/semaphore.h
> 
>  (5) Redirects the following to apply to the new mutexes rather than the
>      traditional semaphores:
> 
> 	down()
> 	down_trylock()
> 	down_interruptible()
> 	up()
> 	init_MUTEX()
>      	init_MUTEX_LOCKED()
> 	DECLARE_MUTEX()
> 	DECLARE_MUTEX_LOCKED()
> 
>      On the basis that most usages of semaphores are as mutexes, this makes
>      sense for in most cases it's just then a matter of changing the type from
>      struct semaphore to struct mutex. In some cases, sema_init() has to be
>      changed to init_MUTEX*() also.
> 
>  (6) Generally include linux/semaphore.h in place of asm/semaphore.h.
> 
>  (7) Provides a debugging config option CONFIG_DEBUG_MUTEX_OWNER by which the
>      mutex owner can be tracked and by which over-upping can be detected.

Maybe I'm not understanding all this, but...

I'd have thought that the way to do this is to simply reimplement down(),
up(), down_trylock(), etc using the new xchg-based code and to then hunt
down those few parts of the kernel which actually use the old semaphore's
counting feature and convert them to use down_sem(), up_sem(), etc.  And
rename all the old semaphore code: s/down/down_sem/etc.

So after such a transformation, this new "mutex" thingy would not exist.

>  include/linux/mutex.h        |   32 +++++++

But it does.

> +#define mutex_grab(mutex)	(xchg(&(mutex)->state, 1) == 0)

mutex_trylock(), please.

> +#define is_mutex_locked(mutex)	((mutex)->state)

Let's keep the namespace consistent.  mutex_is_locked().

> +static inline void down(struct mutex *mutex)
> +{
> +	if (mutex_grab(mutex)) {

likely()

> +#ifdef CONFIG_DEBUG_MUTEX_OWNER
> +		mutex->__owner = current;
> +#endif
> +	}
> +	else {
> +		__down(mutex);
> +	}
> +}
> +
> +/*
> + * sleep interruptibly until we get the mutex
> + * - return 0 if successful, -EINTR if interrupted
> + */
> +static inline int down_interruptible(struct mutex *mutex)
> +{
> +	if (mutex_grab(mutex)) {

likely()

> +static inline int down_trylock(struct mutex *mutex)
> +{
> +	if (mutex_grab(mutex)) {

etc.

You could just put likely() into mutex_trylock().  err, mutex_grab().

> +/*
> + * release the mutex
> + */
> +static inline void up(struct mutex *mutex)
> +{
> +	unsigned long flags;
> +
> +#ifdef CONFIG_DEBUG_MUTEX_OWNER
> +	if (mutex->__owner != current)
> +		__up_bad(mutex);
> +	mutex->__owner = NULL;
> +#endif
> +
> +	/* must prevent a race */
> +	spin_lock_irqsave(&mutex->wait_lock, flags);
> +	if (!list_empty(&mutex->wait_list))
> +		__up(mutex);
> +	else
> +		mutex_release(mutex);
> +	spin_unlock_irqrestore(&mutex->wait_lock, flags);
> +}

This is too large to inline.

It's also significantly slower than the existing up()?

