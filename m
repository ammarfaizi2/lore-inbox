Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWAFAaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWAFAaU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWAFAaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:30:19 -0500
Received: from lixom.net ([66.141.50.11]:59626 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S932325AbWAFAaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:30:16 -0500
Date: Thu, 5 Jan 2006 18:29:19 -0600
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>,
       PPC64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
Message-ID: <20060106002919.GA29190@pb15.lixom.net>
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <20060105143502.GA16816@elte.hu> <43BD4C66.60001@austin.ibm.com> <20060105222106.GA26474@elte.hu> <43BDA672.4090704@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BDA672.4090704@austin.ibm.com>
User-Agent: Mutt/1.5.9i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 05:06:26PM -0600, Joel Schopp wrote:

> Here is a first pass at a powerpc file for the fast paths just as an 
> FYI/RFC. It is completely untested, but compiles.

You really should test it, it saves reviewers time. It's not that hard
to at least try booting it.

Besides the isync comments earlier, there's a bunch of whitespace issues
going on. Did you copy and paste the code from somewhere? If so, you
should move the original copyright over too.

All your macros use spaces instead of tabs up to the \, should be
changed.

All tmp variables should be ints, since the atomic_t counter is a 32-bit
variable. If you use longs, and lwarx (loads 32-bit without sign
extend), the comparison with < 0 will never be true.

> Index: 2.6.15-mutex14/include/asm-powerpc/mutex.h
> ===================================================================
> --- 2.6.15-mutex14.orig/include/asm-powerpc/mutex.h	2006-01-04 14:46:31.%N -0600
> +++ 2.6.15-mutex14/include/asm-powerpc/mutex.h	2006-01-05 16:25:41.%N -0600
> @@ -1,9 +1,83 @@
>  /*
> - * Pull in the generic implementation for the mutex fastpath.
> + * include/asm-powerpc/mutex.h

No need to keep filenames in files.

>   *
> - * TODO: implement optimized primitives instead, or leave the generic
> - * implementation in place, or pick the atomic_xchg() based generic
> - * implementation. (see asm-generic/mutex-xchg.h for details)
> + * PowerPC optimized mutex locking primitives
> + *
> + * Please look into asm-generic/mutex-xchg.h for a formal definition.
> + * Copyright (C) 2006 Joel Schopp <jschopp@austin.ibm.com>, IBM
>   */
> +#ifndef _ASM_MUTEX_H
> +#define _ASM_MUTEX_H
> +#define __mutex_fastpath_lock(count, fail_fn)\
> +do{                                     \
> +	long tmp;                       \
> +	__asm__ __volatile__(		\
> +"1:	lwarx		%0,0,%1\n"      \
> +"	addic	        %0,%0,-1\n"     \
> +"	stwcx.          %0,0,%1\n"      \
> +"	bne-            1b\n"           \
> +"	isync           \n"             \
> +	: "=&r" (tmp)                   \
> +	: "r" (&(count)->counter)       \
> +	: "cr0", "memory");             \
> +	if (unlikely(tmp < 0))          \
> +		fail_fn(count);         \
> +} while (0)                              

trailing whitespace

> +
> +#define __mutex_fastpath_unlock(count, fail_fn)\
> +do{                                         \
> +	long tmp;                           \
> +	__asm__ __volatile__(SYNC_ON_SMP    \
> +"1:	lwarx		%0,0,%1\n"          \
> +"	addic	        %0,%0,1\n"          \
> +"	stwcx.          %0,0,%1\n"          \
> +"       bne-            1b\n"               \

space vs tab

> +	: "=&r" (tmp)                       \
> +	: "r" (&(count)->counter)           \
> +	: "cr0", "memory");                 \
> +	if (unlikely(tmp <= 0))             \
> +		fail_fn(count);             \
> +} while (0)
> +
> +
> +static inline int 

trailing whitespace

> +__mutex_fastpath_trylock(atomic_t* count, int (*fail_fn)(atomic_t*))

atomic_t *count

> +{
> +	long tmp;
> +	__asm__ __volatile__(
> +"1:     lwarx		%0,0,%1\n"
> +"       cmpwi           0,%0,1\n"
> +"       bne-            2f\n"
> +"       stwcx.          %0,0,%1\n"

space vs tab on the above 4 lines

Shouldn't you decrement the counter before the store?

> +"	bne-		1b\n"
> +"	isync\n"
> +"2:"
> +	: "=&r" (tmp)
> +	: "r" (&(count)->counter)
> +	: "cr0", "memory");
> +
> +	return (int)tmp;
> +
> +}
> +
> +#define __mutex_slowpath_needs_to_unlock()		1
>  
> -#include <asm-generic/mutex-dec.h>
> +static inline int 

trailing whitespace

> +__mutex_fastpath_lock_retval(atomic_t* count, int (*fail_fn)(atomic_t *))

atomic_t *count

> +{
> +	long tmp;

counter is a 32-bit variable, so should tmp be otherwise the < 0
comparison can never be true.

> +	__asm__ __volatile__(
> +"1:	lwarx		%0,0,%1\n"
> +"	addic	        %0,%0,-1\n"
> +"	stwcx.          %0,0,%1\n"
> +"	bne-            1b\n"
> +"	isync           \n"
> +	: "=&r" (tmp)
> +	: "r" (&(count)->counter)
> +	: "cr0", "memory");
> +	if (unlikely(tmp < 0))
> +		return fail_fn(count);
> +	else
> +		return 0;
> +}
> +#endif

