Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbVLMXth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbVLMXth (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbVLMXth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:49:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12497 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030276AbVLMXth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:49:37 -0500
Date: Tue, 13 Dec 2005 15:49:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] atomic_long_t & include/asm-generic/atomic.h V2
Message-Id: <20051213154916.6667b6d8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0512131417390.24002@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0512131417390.24002@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> V1->V2:
>  - Allow an arch to provide its on atomic_long_t, so that arches such
>    as sh64 can provide their own atomic_long_t.
>  - Make sure that atomic_long_read() always returns (long) even if the
>    arch uses 32 bit for atomic_long_t so that
>     printk("%ld", atomic_long_read(v))
>    always works (not sure how this could work right if atomic_long is
>    long long like for sh4 but I think that is up to the sh64 developers to
>    figure out).
> 
>  Several counters already have the need to use 64 atomic variables on 64
>  bit platforms (see mm_counter_t in sched.h). We have to do ugly ifdefs to
>  fall back to 32 bit atomic on 32 bit platforms.
> 
>  The VM statistics patch that I am working on will also need to make more 
>  extensive use of atomic64.
> 
>  This patch introduces a new type atomic_long_t by providing definitions in
>  asm-generic/atomic.h that works similar to the c "long" type. Its 32 bits on
>  32 bit platforms and 64 bits on 64 bit platforms.

I dunno, this still looks kludgy.  It looks like we couldn't be assed
implementing atomic_long_t in each architecture ;)

How about requiring that all 64-bit archs implement atomic64_t and do:

#if BIT_PER_LONG == 64

typedef atomic64_t atomic_long_t

static inline long atomic_long_read(atomic_long_t *vl)
{
	/* typecast the return value in case arch uses long long */
	return (long)atomic64_read((atomic64_t *)vl);
}

...

static inline void atomic_long_set(atomic_long_t *vl, long i)
{
	/*
	 * Do the cast separately to avoid possible cast-as-lval errors
	 */
	atomic64_t *v = (atomic64_t *)vl;
	atomic64_set(v, i);
}

#else

typedef atomic_t atomic_long_t

static inline long atomic_long_read(atomic_long_t *vl)
{
	return atomic_read((atomic_t *)vl);
}

...

static inline void atomic_long_set(atomic_long_t *vl, long i)
{
	atomic_t *v = (atomic_t *)vl;
	atomic_set(v, i);
}

#endif

?
