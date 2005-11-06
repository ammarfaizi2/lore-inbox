Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbVKFT2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVKFT2v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 14:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVKFT2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 14:28:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14732 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751062AbVKFT2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 14:28:50 -0500
Date: Sun, 6 Nov 2005 11:28:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: poison struct page for ptlock
Message-Id: <20051106112838.0d524f65.akpm@osdl.org>
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
> 
> While leaving most of the page_private() mods in place for the moment,
> could we please try this patch, or something like it?  Again to overlay
> the spinlock_t from &page->private onwards, with corrected BUILD_BUG_ON
> that we don't go beyond ->lru; with poisoning of the fields overlaid,
> and unsplit config verifying that the split config is safe to use them.
> 

This patch makes the ppc64 crash.  See
http://www.zip.com.au/~akpm/linux/patches/stuff/dsc02976.jpg

I don't know what the access address was (ia32 nicely tells you), but if
it's `DAR' then we have LIST_POISON1.  Which would indicate that the slab
page which backs the mm_struct itself is getting freed-up-pte-page
treatment, which is deeply screwed up.

I'll try it on x86_64 and ia64, see if it's specific to ppc64.

> 
>  include/linux/mm.h |   69 +++++++++++++++++++++++++++++++++++++++++++----------
>  1 files changed, 56 insertions(+), 13 deletions(-)
> 
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
> @@ -265,8 +266,8 @@ struct page {
>  #endif /* WANT_PAGE_VIRTUAL */
>  };
>  
> -#define page_private(page)		((page)->u.private)
> -#define set_page_private(page, v)	((page)->u.private = (v))
> +#define page_private(page)		((page)->private)
> +#define set_page_private(page, v)	((page)->private = (v))
>  
>  /*
>   * FIXME: take this include out, include page-flags.h in
> @@ -787,25 +788,67 @@ static inline pmd_t *pmd_alloc(struct mm
>  }
>  #endif /* CONFIG_MMU && !__ARCH_HAS_4LEVEL_HACK */
>  
> +/*
> + * In the split ptlock case, we shall be overlaying the struct page
> + * of a page table page with a spinlock starting at &page->private,
> + * ending dependent on architecture and config, but never beyond lru.
> + *
> + * So poison the struct page in all cases (in part to assert our
> + * territory: that pte locking owns these fields of a page table
> + * struct page), and verify it when freeing in the unsplit ptlock
> + * case, when none of these fields should have been touched.
> + * Poison lru back-to-front, to make sure list_del was not used.
> + *
> + * The time may come when important configs requiring split ptlock
> + * have a spinlock_t which cannot fit here: then kmalloc a spinlock_t
> + * (perhaps in its own cacheline) and keep the pointer in struct page.
> + */
> +static inline void poison_struct_page(struct page *page)
> +{
> +	page->private = (unsigned long) page;
> +	page->mapping = (struct address_space *) page;
> +	page->index   = (pgoff_t) page;
> +	page->lru.next = LIST_POISON2;
> +	page->lru.prev = LIST_POISON1;
> +}
> +
> +static inline void verify_struct_page(struct page *page)
> +{
> +	BUG_ON(page->private != (unsigned long) page);
> +	BUG_ON(page->mapping != (struct address_space *) page);
> +	BUG_ON(page->index   != (pgoff_t) page);
> +	BUG_ON(page->lru.next != LIST_POISON2);
> +	BUG_ON(page->lru.prev != LIST_POISON1);
> +	/*
> +	 * Reset page->mapping so free_pages_check won't complain.
> +	 */
> +	page->mapping = NULL;
> +}
> +
>  #if NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS
>  /*
>   * We tuck a spinlock to guard each pagetable page into its struct page,
>   * at page->private, with BUILD_BUG_ON to make sure that this will not
> - * overflow into the next struct page (as it might with DEBUG_SPINLOCK).
> - * When freeing, reset page->mapping so free_pages_check won't complain.
> + * overflow beyond page->lru (as it might with PA-RISC DEBUG_SPINLOCK).
>   */
> -#define __pte_lockptr(page)	&((page)->u.ptl)
> +#define __pte_lockptr(page)	((spinlock_t *)&((page)->private))
>  #define pte_lock_init(_page)	do {					\
> +	BUILD_BUG_ON(__pte_lockptr((struct page *)0) + 1 >		\
> +			(spinlock_t *)(&((struct page *)0)->lru + 1));	\
> +	poison_struct_page(_page);					\
>  	spin_lock_init(__pte_lockptr(_page));				\
>  } while (0)
> +/*
> + * When freeing, reset page->mapping so free_pages_check won't complain.
> + */
>  #define pte_lock_deinit(page)	((page)->mapping = NULL)
>  #define pte_lockptr(mm, pmd)	({(void)(mm); __pte_lockptr(pmd_page(*(pmd)));})
>  #else
>  /*
>   * We use mm->page_table_lock to guard all pagetable pages of the mm.
>   */
> -#define pte_lock_init(page)	do {} while (0)
> -#define pte_lock_deinit(page)	do {} while (0)
> +#define pte_lock_init(page)	poison_struct_page(page)
> +#define pte_lock_deinit(page)	verify_struct_page(page)
>  #define pte_lockptr(mm, pmd)	({(void)(pmd); &(mm)->page_table_lock;})
>  #endif /* NR_CPUS < CONFIG_SPLIT_PTLOCK_CPUS */
>  
