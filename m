Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWEIHgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWEIHgm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 03:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWEIHgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 03:36:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13289 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751380AbWEIHgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 03:36:41 -0400
Date: Tue, 9 May 2006 00:33:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, pavel@suse.cz
Subject: Re: [PATCH -mm] swsusp: support creating bigger images
Message-Id: <20060509003334.70771572.akpm@osdl.org>
In-Reply-To: <200605021200.37424.rjw@sisk.pl>
References: <200605021200.37424.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Currently swsusp is only capable of creating suspend images that are not
> bigger than 1/2 of the normal zone, because it needs to create a copy of every
> page which should be included in the image.  This may hurt the system
> responsiveness after resume, especially on systems with less that 1 GB of RAM.
> 
> To allow swsusp to create bigger images we can use the observation that
> if some pages don't change after the snapshot image of the system has been
> created and before the image is entirely saved, they can be included in the
> image without copying.  Now if the mapped pages that are not mapped by the
> current task are considered, it turns out that they would change only if they
> were reclaimed by try_to_free_pages().  Thus if we take them out of reach
> of try_to_free_pages(), for example by (temporarily) moving them out of their
> respective LRU lists after creating the image, we will be able to include them
> in the image without copying.
> 
> If these pages are included in the image without copying, the amount of free
> memory needed by swsusp is usually much less than otherwise, so the size
> of the image may be bigger.  This also makes swsusp use less memory during
> suspend and saves us quite a lot of memory allocations and copyings.
> 

I have a host of minor problems with this patch.

> --- linux-2.6.17-rc3-mm1.orig/mm/rmap.c
> +++ linux-2.6.17-rc3-mm1/mm/rmap.c
>  
> +#ifdef CONFIG_SOFTWARE_SUSPEND
> +static int page_mapped_by_task(struct page *page, struct task_struct *task)
> +{
> +	struct vm_area_struct *vma;
> +	int ret = 0;
> +
> +	spin_lock(&task->mm->page_table_lock);
> +
> +	for (vma = task->mm->mmap; vma; vma = vma->vm_next)
> +		if (page_address_in_vma(page, vma) != -EFAULT) {
> +			ret = 1;
> +			break;
> +		}
> +
> +	spin_unlock(&task->mm->page_table_lock);
> +
> +	return ret;
> +}

task_struct.mm can sometimes be NULL.  This function assumes that it will
never be NULL.  That makes it a somewhat risky interface.  Are we sure it
can never be NULL?

> +/**
> + *	page_to_copy - determine if a page can be included in the
> + *	suspend image without copying (returns false if that's the case).
> + *
> + *	It is safe to include the page in the suspend image without
> + *	copying if (a) it's on the LRU and (b) it's mapped by a frozen task
> + *	(all tasks except for the current task should be frozen when it's
> + *	called).  Otherwise the page should be copied for this purpose
> + *	(compound pages are avoided for simplicity).
> + */
> +
> +int page_to_copy(struct page *page)
> +{
> +	if (!PageLRU(page) || PageCompound(page))
> +		return 1;
> +	if (page_mapped(page))
> +		return page_mapped_by_task(page, current);
> +
> +	return 1;
> +}

a) This is a poorly-chosen name for a globally-scoped function.  There's
   no indication in its name that it is a swsusp thing.

b) It hurts my brain.  "determine X and return false if it's true (!)",
   where "X" means "can it be included" whereas the name "page_to_copy"
   implies something seemingly unrelated - some semantic caller-defined
   consequence of X.

Shudder.  Please try again.

> +#endif /* CONFIG_SOFTWARE_SUSPEND */
> Index: linux-2.6.17-rc3-mm1/include/linux/rmap.h
> ===================================================================
> --- linux-2.6.17-rc3-mm1.orig/include/linux/rmap.h
> +++ linux-2.6.17-rc3-mm1/include/linux/rmap.h
> @@ -104,6 +104,14 @@ pte_t *page_check_address(struct page *,
>   */
>  unsigned long page_address_in_vma(struct page *, struct vm_area_struct *);
>  
> +#ifdef CONFIG_SOFTWARE_SUSPEND
> +/*
> + * Used to determine if the page can be included in the suspend image without
> + * copying
> + */
> +int page_to_copy(struct page *);
> +#endif

Please remove the ifdef here.

> +++ linux-2.6.17-rc3-mm1/kernel/power/snapshot.c
> --- linux-2.6.17-rc3-mm1.orig/kernel/power/snapshot.c
> +
> +unsigned int count_data_pages(unsigned int *total)
>  {
>  	struct zone *zone;
>  	unsigned long zone_pfn;
> -	unsigned int n = 0;
> +	unsigned int n, m;
>  
> +	n = m = 0;

Please avoid the multiple assignment.  Kernel coding style is super-simple
- no tricksy stuff.

	unsigned int n = 0;
	unsigned int m = 0;

See, if we put each declaration on its own line we get a little bit of room
for a comment explaining what it does.  Which is pretty much compulsory if
one insists on using identifiers like `m' and `n'.

>  	for_each_zone (zone) {

Might as well remove the extranous space here.

>  		if (is_highmem(zone))
>  			continue;
>  		mark_free_pages(zone);
> -		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
> -			n += saveable(zone, &zone_pfn);
> +		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
> +			unsigned long pfn = zone_pfn + zone->zone_start_pfn;
> +
> +			if (saveable(pfn)) {
> +				n++;
> +				if (!page_to_copy(pfn_to_page(pfn)))
> +					m++;
> +			}
> +		}
>  	}
> -	return n;
> +	if (total)
> +		*total = n;
> +
> +	return n - m;
>  }

See, I think `n' should be renamed to `pages_to_copy'.

I don't know what `m' should be renamed to, because that would require me
to understand `page_to_copy()', and I'm not smart enough for that.

>  /**
> + *	protect_data_pages - move data pages that need to be protected from
> + *	being reclaimed (ie. those included in the suspend image without
> + *	copying) out of their respective LRU lists.  This is done after the
> + *	image has been created so the LRU lists only have to be restored if
> + *	the suspend fails.
> + *
> + *	This function is only called from the critical section, ie. when
> + *	processes are frozen, there's only one CPU online and local IRQs
> + *	are disabled on it.
> + */
> +
> +static void protect_data_pages(struct pbe *pblist)
> +{
> +	struct pbe *p;
> +
> +	for_each_pbe (p, pblist)

extraneous space.

> -static int enough_free_mem(unsigned int nr_pages)
> +static int enough_free_mem(unsigned int nr_pages, unsigned int copy_pages)
>  {
>  	struct zone *zone;
> -	unsigned int n = 0;
> +	long n = 0;

Suggest you rename `n' to something useful while you're there.

> +	pr_debug("swsusp: pages needed: %u + %lu + %lu\n",
> +		 copy_pages,
> +		 (nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE,
> +		 EXTRA_PAGES);

Use DIV_ROUND_UP() here.

>  	for_each_zone (zone)
> -		if (!is_highmem(zone))
> +		if (!is_highmem(zone) && populated_zone(zone)) {
>  			n += zone->free_pages;
> -	pr_debug("swsusp: available memory: %u pages\n", n);
> -	return n > (nr_pages + PAGES_FOR_IO +
> -		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
> -}
> -
> -static int alloc_data_pages(struct pbe *pblist, gfp_t gfp_mask, int safe_needed)
> -{
> -	struct pbe *p;
> +			/*
> +			 * We're going to use atomic allocations, so we
> +			 * shouldn't count the lowmem reserves in the lower
> +			 * zones as available to us
> +			 */
> +			n -= zone->lowmem_reserve[ZONE_NORMAL];
> +		}
>  
> -	for_each_pbe (p, pblist) {
> -		p->address = (unsigned long)alloc_image_page(gfp_mask, safe_needed);
> -		if (!p->address)
> -			return -ENOMEM;
> -	}
> -	return 0;
> +	pr_debug("swsusp: available memory: %ld pages\n", n);
> +	return n > (long)(copy_pages + EXTRA_PAGES +
> +		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);

DIV_ROUND_UP().

>  asmlinkage int swsusp_save(void)
>  {
> -	unsigned int nr_pages;
> +	unsigned int nr_pages, copy_pages;

	unsigned int nr_pages;
	unsigned int pages_to_copy;


> +#if (defined(CONFIG_BLK_DEV_INITRD) && defined(CONFIG_BLK_DEV_RAM))
> +#define EXTRA_PAGES	(PAGES_FOR_IO + \
> +			(2 * CONFIG_BLK_DEV_RAM_SIZE * 1024) / PAGE_SIZE)
> +#else
> +#define EXTRA_PAGES	PAGES_FOR_IO
> +#endif

What is the significance of the ramdisk to the swsusp code?  (Need commenting).

EXTRA_PAGES is not a well-chosen identifier.  Please choose something
within the swsusp "namespace", if there's such a thing.

> ===================================================================
> --- linux-2.6.17-rc3-mm1.orig/kernel/power/swsusp.c
> +++ linux-2.6.17-rc3-mm1/kernel/power/swsusp.c
> @@ -177,28 +177,29 @@ int swsusp_shrink_memory(void)
>  	long size, tmp;
>  	struct zone *zone;
>  	unsigned long pages = 0;
> -	unsigned int i = 0;
> +	unsigned int to_save, i = 0;

	unsigned int pages_to_save;
	unsigned int i = 0;		/* Maybe a comment */

> ===================================================================
> --- linux-2.6.17-rc3-mm1.orig/mm/vmscan.c
> +++ linux-2.6.17-rc3-mm1/mm/vmscan.c
> @@ -1437,7 +1437,68 @@ out:
>  
>  	return ret;
>  }
> -#endif
> +
> +static LIST_HEAD(saved_active_pages);
> +static LIST_HEAD(saved_inactive_pages);
> +
> +/**
> + *	move_out_of_lru - software suspend includes some pages in the
> + *	suspend snapshot image without copying and these pages should be
> + *	procected from being reclaimed, which can be done by (temporarily)
> + *	moving them out of their respective LRU lists
> + *
> + *	It is to be called with local IRQs disabled.
> + */
> +
> +void move_out_of_lru(struct page *page)
> +{
> +	struct zone *zone = page_zone(page);
> +
> +	spin_lock(&zone->lru_lock);

Normally we'd check that PageLRU() is still true after acquiring the lock.

> +	if (PageActive(page)) {
> +		del_page_from_active_list(zone, page);
> +		list_add(&page->lru, &saved_active_pages);
> +	} else {
> +		del_page_from_inactive_list(zone, page);
> +		list_add(&page->lru, &saved_inactive_pages);
> +	}
> +	ClearPageLRU(page);
> +	spin_unlock(&zone->lru_lock);
> +}
> +
> +
> +/**
> + *	restore_active_inactive_lists - used by the software suspend to move
> + *	the pages taken out of the LRU by take_page_out_of_lru() back to
> + *	their respective active/inactive lists (if the suspend fails)
> + */
> +
> +void restore_active_inactive_lists(void)
> +{
> +	struct page *page;
> +	struct zone *zone;
> +
> +	while(!list_empty(&saved_active_pages)) {

Add a space after `while'.

> +		page = lru_to_page(&saved_active_pages);
> +		zone = page_zone(page);
> +		list_del(&page->lru);
> +		spin_lock_irq(&zone->lru_lock);
> +		SetPageLRU(page);
> +		add_page_to_active_list(zone, page);
> +		spin_unlock_irq(&zone->lru_lock);
> +	}
> +
> +	while(!list_empty(&saved_inactive_pages)) {

Ditto.

> +		page = lru_to_page(&saved_inactive_pages);
> +		zone = page_zone(page);
> +		list_del(&page->lru);
> +		spin_lock_irq(&zone->lru_lock);
> +		SetPageLRU(page);
> +		add_page_to_inactive_list(zone, page);
> +		spin_unlock_irq(&zone->lru_lock);
> +	}
> +}
> +#endif /* CONFIG_PM */

All the above code is inside CONFIG_PM, but afaik it's only used by
CONFIG_SOFTWARE_SUSPEND.


