Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292802AbSCDTuU>; Mon, 4 Mar 2002 14:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292803AbSCDTuL>; Mon, 4 Mar 2002 14:50:11 -0500
Received: from zero.tech9.net ([209.61.188.187]:1296 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292802AbSCDTuF>;
	Mon, 4 Mar 2002 14:50:05 -0500
Subject: Re: [PATCH] Fast Userspace Mutexes III.
From: Robert Love <rml@tech9.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, matthew@hairy.beasts.org, bcrl@redhat.com,
        david@mysql.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
        Hubertus Franke <frankeh@watson.ibm.com>
In-Reply-To: <E16hjZY-0001AV-00@wagner.rustcorp.com.au>
In-Reply-To: <E16hjZY-0001AV-00@wagner.rustcorp.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 04 Mar 2002 14:49:51 -0500
Message-Id: <1015271393.15277.112.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-03-03 at 22:55, Rusty Russell wrote:
> 1) Use mmap/mprotect bits, not new syscall (thanks RTH, Erik Biederman)
> 2) Fix wakeup race in kernel (thanks Martin Wirth, Paul Mackerras)
> 3) Simplify locking to a single atomic (no more arch specifics!)
> 4) Use wake-one by handcoding queues.
> 5) Comments added.
> 
> Thanks to all for feedback and review: I'd appreciate a comment from
> those arch's which need to do something with the PROT_SEM bit.
> 
> Once again, tested on 2.4.18 UP PPC, compiles on 2.5.6-pre1.
> 
> Bad news is that we're up to 206 lines again.
> Rusty.

Good work.  I likee.

I have a couple comments and question:

> +static spinlock_t futex_lock = SPIN_LOCK_UNLOCKED;

Could we make this per-waitqueue?

> +asmlinkage int sys_futex(void *uaddr, int op)
< [...]
> +	switch (op) {
> +	case 1:
> +		ret = futex_up(head, page_address(page) + pos_in_page);
> +		break;
> +	case -1:

We should do:

	#define FUTEX_UP	1
	#define FUTEX_DOWN	-1

and put them in a common header (i.e. include/linux so both the kernel
and glibc will use it) and use that in our code and the kernel code. 
Just a finishing detail ...

> +static inline int __update_count(atomic_t *count, int incr)
> +{
> +	int old_count, tmp;
> +
> +	/* preempt_disable() */
> +	old_count = atomic_read(count);
> +	tmp = old_count > 0 ? old_count : 0;
> +	atomic_set(count, tmp + incr);
> +	return old_count;
> +}

You will want to do:

	int old_count, tmp;

	preempt_disable();
	old count = atomic_read(count);
	tmp = old_count > 0 ? old_count : 0;
	atomic_set(count, tmp + incr);
	preempt_enable();

	return old_count;

here.  The preempt statements compile away if CONFIG_PREEMPT is not set,
so you can just put them in, even on arches that don't do preemption
yet.

... oh, and I would love an example of using it in userspace ;)

Nice work, Rusty.

	Robert Love

