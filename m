Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVJWVtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVJWVtv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 17:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbVJWVtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 17:49:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63145 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750702AbVJWVtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 17:49:50 -0400
Date: Sun, 23 Oct 2005 14:49:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: clameter@sgi.com, rmk@arm.linux.org.uk, matthew@wil.cx, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] mm: split page table lock
Message-Id: <20051023144900.4a23704d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0510221727060.18047@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0510221727060.18047@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I did the make-it-a-union thing.  Seems OK.

Hugh Dickins <hugh@veritas.com> wrote:
>
> +#if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
>  +/*
>  + * We tuck a spinlock to guard each pagetable page into its struct page,
>  + * at page->private, with BUILD_BUG_ON to make sure that this will not
>  + * overflow into the next struct page (as it might with DEBUG_SPINLOCK).
>  + * When freeing, reset page->mapping so free_pages_check won't complain.
>  + */
>  +#define __pte_lockptr(page)	((spinlock_t *)&((page)->private))
>  +#define pte_lock_init(_page)	do {					\
>  +	BUILD_BUG_ON((size_t)(__pte_lockptr((struct page *)0) + 1) >	\
>  +						sizeof(struct page));	\
>  +	spin_lock_init(__pte_lockptr(_page));				\
>  +} while (0)
>  +#define pte_lock_deinit(page)	((page)->mapping = NULL)
>  +#define pte_lockptr(mm, pmd)	({(void)(mm); __pte_lockptr(pmd_page(*(pmd)));})
>  +#else

Why does pte_lock_deinit() zap ->mapping?  That doesn't seem to have
anything to do with anything?

