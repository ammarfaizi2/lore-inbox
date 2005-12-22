Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbVLVL54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVLVL54 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 06:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVLVL54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 06:57:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13203 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964788AbVLVL5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 06:57:55 -0500
Date: Thu, 22 Dec 2005 11:57:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 5/9] mutex subsystem, core
Message-ID: <20051222115753.GB30964@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>,
	David Howells <dhowells@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
	Russell King <rmk+lkml@arm.linux.org.uk>
References: <20051222114233.GF18878@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222114233.GF18878@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include <linux/config.h>

we don't need config.h anymore, it's included implicitly now.

> +#include <asm/atomic.h>

Any chance we could include this after the <linux/*.h> headers ?

> +#include <linux/spinlock_types.h>

What do we need this one for?

> +struct mutex {
> +	// 1: unlocked, 0: locked, negative: locked, possible waiters

please use /* */ comments.

> +	atomic_t		count;
> +	spinlock_t		wait_lock;
> +	struct list_head	wait_list;
> +#ifdef CONFIG_DEBUG_MUTEXES
> +	struct thread_info	*owner;
> +	struct list_head	held_list;
> +	unsigned long		acquire_ip;
> +	const char 		*name;
> +	void			*magic;
> +#endif
> +};

I know we generally don't like typedefs, but mutex is like spinlocks one
of those cases where the internals should be completely opaqueue, so a mutex_t
sounds like a good idea.

> +#include <linux/syscalls.h>

What do you we need this header for?

> +static inline void __mutex_lock_atomic(struct mutex *lock)
> +{
> +#ifdef __ARCH_WANT_XCHG_BASED_ATOMICS
> +	if (unlikely(atomic_xchg(&lock->count, 0) != 1))
> +		__mutex_lock_noinline(&lock->count);
> +#else
> +	atomic_dec_call_if_negative(&lock->count, __mutex_lock_noinline);
> +#endif
> +}

this is the kind of thing I meant in the comment to the announcement.

Just having this in arch code would kill all these ifdefs  over mutex.c

