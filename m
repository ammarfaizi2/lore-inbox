Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVASXKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVASXKp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVASXKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:10:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23690 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261960AbVASXK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:10:26 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050119213834.GC8471@dominikbrodowski.de> 
References: <20050119213834.GC8471@dominikbrodowski.de> 
To: Dominik Brodowski <linux@dominikbrodowski.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/4] interruptible rwsem operations (i386, core) 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 19 Jan 2005 23:10:20 +0000
Message-ID: <24595.1106176220@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dominik Brodowski <linux@dominikbrodowski.de> wrote:

> Add functions down_read_interruptible, and down_write_interruptible to rw
> semaphores. Implement these for i386.
> ...

> +static inline int
> +rwsem_down_interruptible_failed_common(struct rw_semaphore *sem,
> +			struct rwsem_waiter *waiter, signed long adjustment)
> +{
> ...

I wonder if you should check to see if there are any readers that can be woken
up if a sleeping writer is interrupted, but I can't think of a simple way to
do it.

> -struct rw_semaphore fastcall __sched *
> -rwsem_down_read_failed(struct rw_semaphore *sem)
> +void fastcall __sched rwsem_down_read_failed(struct rw_semaphore *sem)

Please don't.

> @@ -199,14 +253,33 @@ rwsem_down_read_failed(struct rw_semapho
>  				RWSEM_WAITING_BIAS - RWSEM_ACTIVE_BIAS);
>  
>  	rwsemtrace(sem, "Leaving rwsem_down_read_failed");
> -	return sem;

Ditto.

> -struct rw_semaphore fastcall __sched *
> -rwsem_down_write_failed(struct rw_semaphore *sem)
> +void fastcall __sched rwsem_down_write_failed(struct rw_semaphore *sem)

Ditto.

> @@ -216,10 +289,31 @@ rwsem_down_write_failed(struct rw_semaph
>  	rwsem_down_failed_common(sem, &waiter, -RWSEM_ACTIVE_BIAS);
>  
>  	rwsemtrace(sem, "Leaving rwsem_down_write_failed");
> -	return sem;

Ditto.

> @@ -99,11 +103,12 @@ static inline void __down_read(struct rw
>  {
>  	__asm__ __volatile__(
>  		"# beginning down_read\n\t"
> -LOCK_PREFIX	"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
> +LOCK_PREFIX	"  incl      %0\n\t" /* adds 0x00000001, returns the old value */

Ditto.

>  		"  js        2f\n\t" /* jump if we weren't granted the lock */
>  		"1:\n\t"
>  		LOCK_SECTION_START("")
>  		"2:\n\t"
> +		"  movl      %2,%%eax\n\t"

Splat.

>  		"  pushl     %%ecx\n\t"
>  		"  pushl     %%edx\n\t"
>  		"  call      rwsem_down_read_failed\n\t"

Splat.

> @@ -113,11 +118,41 @@ LOCK_PREFIX	"  incl      (%%eax)\n\t" /*
>  		LOCK_SECTION_END
>  		"# ending down_read\n\t"
>  		: "=m"(sem->count)
> -		: "a"(sem), "m"(sem->count)
> +		: "m"(sem->count), "m"(sem)
>  		: "memory", "cc");
>  }

You appear to be corrupting EAX.

> +static inline int __down_read_interruptible(struct rw_semaphore *sem)

Will corrupt EAX.

>  		"# beginning down_write\n\t"
> -LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtract 0x0000ffff, returns the old value */
> +LOCK_PREFIX	"  xadd      %%edx,%0\n\t" /* subtract 0x0000ffff, returns the old value */

Again, please don't. It's a lot more readable when it mentions EAX directly,
plus it's also independent of constraint reordering.

> +static inline int __down_write_interruptible(struct rw_semaphore *sem)

Will corrupt EAX and EDX.

David
