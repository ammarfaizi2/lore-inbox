Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVKEFce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVKEFce (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 00:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVKEFce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 00:32:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16288 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751227AbVKEFce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 00:32:34 -0500
Date: Fri, 4 Nov 2005 21:32:25 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: poison struct page for ptlock
Message-Id: <20051104213225.39d4c2a3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0511031924210.31509@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511031924210.31509@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> The split ptlock patch enlarged the default SMP PREEMPT struct page from
> 32 to 36 bytes on most 32-bit platforms, from 32 to 44 bytes on PA-RISC
> 7xxx (without PREEMPT).  That was not my intention, and I don't believe
> that split ptlock deserves any such slice of the user's memory.

Only with preempt and >= 4 CPUs.  Vendors don't ship preemptible kernels,
especially on SMP.  So the impact is minor.

> While leaving most of the page_private() mods in place for the moment,
> could we please try this patch, or something like it?  Again to overlay
> the spinlock_t from &page->private onwards, with corrected BUILD_BUG_ON
> that we don't go beyond ->lru; with poisoning of the fields overlaid,
> and unsplit config verifying that the split config is safe to use them.

Does your family know you do this sort of thing?

> --- 2.6.14-git6/include/linux/mm.h	2005-11-03 18:38:01.000000000 +0000
> +++ linux/include/linux/mm.h	2005-11-03 18:46:06.000000000 +0000
> @@ -226,18 +226,19 @@ struct page {
>  					 * to show when page is mapped
>  					 * & limit reverse map searches.
>  					 */
> -	union {
> -		unsigned long private;	/* Mapping-private opaque data:
> +	unsigned long private;		/* Mapping-private opaque data:
>  					 * usually used for buffer_heads
>  					 * if PagePrivate set; used for
>  					 * swp_entry_t if PageSwapCache
>  					 * When page is free, this indicates
>  					 * order in the buddy system.
>  					 */
> -#if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
> -		spinlock_t ptl;
> -#endif
> -	} u;
> +	/*
> +	 * Along with private, the mapping, index and lru fields of a
> +	 * page table page's struct page may be overlaid by a spinlock
> +	 * for pte locking: see comment on "split ptlock" below.  Please
> +	 * do not rearrange these fields without considering that usage.
> +	 */
>  	struct address_space *mapping;	/* If low bit clear, points to
>  					 * inode address_space, or NULL.
>  					 * If page mapped as anonymous

What happened to my suggestion that we use anonymous structs here, and
abandon gcc-2.9x?

> @@ -265,8 +266,8 @@ struct page {
>  #endif /* WANT_PAGE_VIRTUAL */
>  };
>  
> -#define page_private(page)		((page)->u.private)
> -#define set_page_private(page, v)	((page)->u.private = (v))
> +#define page_private(page)		((page)->private)
> +#define set_page_private(page, v)	((page)->private = (v))

Need to rename ->private to ->_private here, otherwise people will start
using page->private again.

