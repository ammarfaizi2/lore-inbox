Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135811AbRECRbM>; Thu, 3 May 2001 13:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135814AbRECRbD>; Thu, 3 May 2001 13:31:03 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:15140 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135811AbRECRaz>; Thu, 3 May 2001 13:30:55 -0400
Date: Thu, 3 May 2001 19:28:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.4 alpha semaphores optimization
Message-ID: <20010503192848.V1162@athlon.random>
In-Reply-To: <20010503194747.A552@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010503194747.A552@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Thu, May 03, 2001 at 07:47:47PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2001 at 07:47:47PM +0400, Ivan Kokshaysky wrote:
> Initially I tried to use __builtin_expect in the rwsem.h, but found
> that it doesn't help at all in the small inline functions - it works
> as expected only in a reasonably large block of code. Converting these
> functions into the macros won't help, as callers are inline
> functions also.
> On the other hand, gcc 3.0 generates quite a good code for
> conditional branches (comparisons like value < 0, value == 0
> predicted as false etc.). In the cases where expected value is 0,
> we can use cmpeq instruction.
> Other changes:
>  - added atomic_add_return_prev() for __down_write()
>  - removed some mb's for non-SMP
>  - removed non-inline up()/down_xx() when semaphore/waitqueue debugging
>    isn't enabled.

I'd love if you could port it on top of this one and to fix it so that
it can handle up to 2^32 sleepers and not only 2^16 like we have to do
on the 32bit archs to get good performance:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.4aa3/00_rwsem-11

I just wrote the prototype, it only needs to be implemented see
linux/include/asm-alpha/rwsem_xchgadd.h:

--------------------------------------------------------------
#ifndef _ALPHA_RWSEM_XCHGADD_H
#define _ALPHA_RWSEM_XCHGADD_H

/* WRITEME */

static inline void __down_read(struct rw_semaphore *sem)
{
}

static inline void __down_write(struct rw_semaphore *sem)
{
}

static inline void __up_read(struct rw_semaphore *sem)
{
}

static inline void __up_write(struct rw_semaphore *sem)
{
}

static inline long rwsem_xchgadd(long value, long * count)
{
	return value;
}

#endif
--------------------------------------------------------------

You only need to fill the above 5 inlined fast paths to make it working
and that's the only thing in the whole alpha tree about the rwsem.

The above patch also provides the fastest write fast path for x86 archs
and the fastest rwsem spinlock based. I didn't yet re-benchmarked the
whole thing yet but still my up_write definitely has to be faster than
the one in 2.4.4 vanilla and the other fast paths have to be the same
speed.

Andrea
