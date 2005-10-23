Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVJWV2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVJWV2E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 17:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVJWV2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 17:28:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24229 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750787AbVJWV2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 17:28:03 -0400
Date: Sun, 23 Oct 2005 14:27:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: clameter@sgi.com, rmk@arm.linux.org.uk, matthew@wil.cx, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] mm: split page table lock
Message-Id: <20051023142712.6c736dd3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0510221727060.18047@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0510221727060.18047@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> In this implementation, the spinlock is tucked inside the struct page of
>  the page table page: with a BUILD_BUG_ON in case it overflows - which it
>  would in the case of 32-bit PA-RISC with spinlock debugging enabled.

eh?   It's going to overflow an unsigned long on x86 too:

typedef struct {
	raw_spinlock_t raw_lock;
#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
	unsigned int break_lock;
#endif
#ifdef CONFIG_DEBUG_SPINLOCK
	unsigned int magic, owner_cpu;
	void *owner;
#endif
} spinlock_t;

I think we need a union here.

> +#define __pte_lockptr(page)	((spinlock_t *)&((page)->private))
> +#define pte_lock_init(_page)	do {					\
> +	BUILD_BUG_ON((size_t)(__pte_lockptr((struct page *)0) + 1) >	\
> +						sizeof(struct page));	\

The above assumes that page.private is the final field in struct page. 
That's fragile.

>  Splitting the lock is not quite for free: another cacheline access.
>  Ideally, I suppose we would use split ptlock only for multi-threaded
>  processes on multi-cpu machines; but deciding that dynamically would
>  have its own costs.  So for now enable it by config, at some number
>  of cpus - since the Kconfig language doesn't support inequalities, let
>  preprocessor compare that with NR_CPUS.  But I don't think it's worth
>  being user-configurable: for good testing of both split and unsplit
>  configs, split now at 4 cpus, and perhaps change that to 8 later.

I'll make it >= 2 for -mm.

> +#define __pte_lockptr(page)	((spinlock_t *)&((page)->private))
>  +#define pte_lock_init(_page)	do {					\
> +	BUILD_BUG_ON((size_t)(__pte_lockptr((struct page *)0) + 1) >	\
> +						sizeof(struct page));	\
