Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWACNPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWACNPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWACNPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:15:31 -0500
Received: from smtp102.plus.mail.mud.yahoo.com ([68.142.206.235]:57207 "HELO
	smtp102.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932250AbWACNPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:15:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Li8OEdLge6eUOtXp7kA0jpiq/c52iVFoL3nwPt36RJvX9UjenMwyK+lNHXcNnWfmOdS5wl4F6wVoTxj98MNaHG6rQD0yTs5uRpvjVUW1N00xQFpJkqSzOutAUSaCO7b1Ar5l8VRPUcTcwfsMyF5Am4tQiJ7Ez31zLusT+tuOMXE=  ;
Message-ID: <43BA78EC.7050603@yahoo.com.au>
Date: Wed, 04 Jan 2006 00:15:24 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 08/19] mutex subsystem, core
References: <20060103100807.GH23289@elte.hu>
In-Reply-To: <20060103100807.GH23289@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> +
> +/*
> + * Spinlock based trylock, we take the spinlock and check whether we
> + * can get the lock:
> + */
> +static inline int __mutex_trylock_nonatomic(atomic_t *lock_count)
> +{
> +	struct mutex *lock = container_of(lock_count, struct mutex, count);
> +	int prev;
> +
> +	spin_lock_mutex(&lock->wait_lock);
> +
> +	prev = atomic_xchg(&lock->count, -1);
> +	if (likely(prev == 1))
> +		debug_mutex_set_owner(lock, current_thread_info() __RET_IP__);
> +	/* Set it back to 0 if there are no waiters: */
> +	if (likely(list_empty(&lock->wait_list)))
> +		atomic_set(&lock->count, 0);
> +
> +	spin_unlock_mutex(&lock->wait_lock);
> +
> +	return prev == 1;
> +}
> +
> +/***
> + * mutex_trylock - try acquire the mutex, without waiting
> + * @lock: the mutex to be acquired
> + *
> + * Try to acquire the mutex atomically. Returns 1 if the mutex
> + * has been acquired successfully, and 0 on contention.
> + *
> + * NOTE: this function follows the spin_trylock() convention, so
> + * it is negated to the down_trylock() return values! Be careful
> + * about this when converting semaphore users to mutexes.
> + *
> + * This function must not be used in interrupt context. The
> + * mutex must be released by the same task that acquired it.
> + */
> +int fastcall mutex_trylock(struct mutex *lock)
> +{
> +	return __mutex_fastpath_trylock(&lock->count,
> +					__mutex_trylock_nonatomic);
> +}
> +

[snip]

> +
> +#define spin_lock_mutex(lock)			spin_lock(lock)
> +#define spin_unlock_mutex(lock)			spin_unlock(lock)

Is this an interrupt deadlock, or do you not allow interrupt contexts
to even trylock a mutex?

If the former, I would simply use atomic_cmpxchg unconditionally for
the trylock and not use a spinlock fallback function at all.

Alternately, you may 'trylock' the spinlock, but it just seems like
extra code for not much reason (when you can use atomic_cmpxchg).

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
