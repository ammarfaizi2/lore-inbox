Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264540AbRFMEjL>; Wed, 13 Jun 2001 00:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264541AbRFMEiw>; Wed, 13 Jun 2001 00:38:52 -0400
Received: from moon.govshops.com ([207.32.111.5]:54538 "HELO mail.govshops.com")
	by vger.kernel.org with SMTP id <S264540AbRFMEit>;
	Wed, 13 Jun 2001 00:38:49 -0400
From: "Alok K. Dhir" <alok@dhir.net>
To: "'Rik van Riel'" <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.4.6-pre2 page_launder() improvements
Date: Wed, 13 Jun 2001 00:42:45 -0400
Message-ID: <000e01c0f3c3$4a71fb10$1e01a8c0@dhir.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
In-Reply-To: <Pine.LNX.4.33.0106100128100.4239-100000@duckman.distro.conectiva>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are these page_launder improvements included in 2.4.6-pre3?  Linus
mentions "VM tuning has also happened" in the announcement - but there
doesn't seem to be mention of it in his list of changes from -pre2...

Thanks

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Rik van Riel
> Sent: Sunday, June 10, 2001 12:41 AM
> To: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH] 2.4.6-pre2 page_launder() improvements
> 
> 
> [Request For Testers ... patch below]
> 
> Hi,
> 
> during my holidays I've written the following patch 
> (forward-ported to 2.4.6-pre2 and improved a tad today), 
> which implements these improvements to page_launder():
> 
> 1) don't "roll over" inactive_dirty pages to the back of the
>    list, but reclaim them in something more resembling LRU
>    order;  this is especially good when the system has tons
>    of inactive_dirty pages due to eg. background scanning
> 
> 2) eliminate the infinite penalty clean pages had over dirty
>    pages by not scanning the complete inactive_dirty list and
>    letting real dirty pages build up near the front of the
>    list ... we flush them asynchronously when we have enough
>    of them
> 
> 3) when going into the launder_loop, we scan a larger fraction
>    of the inactive_dirty list; under most workloads this means
>    we can always flush the dirty pages asynchronously because
>    we'll have clean, freeable pages in the part of the list we
>    only scan in the launder_loop
> 
> 4) when we have only dirty pages and cannot free pages, we
>    remember this for the next run of page_launder() and won't
>    waste CPU by scanning pages without flushing them in the
>    launder loop (after maxlaunder goes negative)
> 
> 5) this same logic is used to control when we use synchronous
>    IO; only when we cannot free any pages now do we wait on
>    IO, this stops kswapd CPU wastage under heavy write loads
> 
> 6) the "sync" argument to page_launder() now means whether
>    we're _allowed_ to do synchronous IO or not ... page_launder()
>    is now smart enough to determine if we should use asynchronous
>    IO only or if we should wait on IO
> 
> This patch has given excellent results on my laptop and my 
> workstation here and seems to improve kernel behaviour in 
> tests quite a bit. I can play mp3's unbuffered during 
> moderate write loads or moderately heavy IO ;)
> 
> YMMV, please test it. If it works great for everybody I'd 
> like to get this improvement merged into the next -pre kernel.
> 
> regards,
> 
> Rik
> --
> Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml
> 
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
> 
> 		http://www.surriel.com/
> http://www.conectiva.com/	http://distro.conectiva.com/
> 
> 
> diff -ur linux-2.4.6-pre2-virgin/include/linux/mm.h 
> linux-2.4.6-pre2/include/linux/mm.h
> --- linux-2.4.6-pre2-virgin/include/linux/mm.h	Sun Jun 
> 10 00:44:01 2001
> +++ linux-2.4.6-pre2/include/linux/mm.h	Sat Jun  9 23:19:54 2001
> @@ -169,6 +169,7 @@
>  #define PG_inactive_clean	11
>  #define PG_highmem		12
>  #define PG_checked		13	/* kill me in 2.5.<early>. */
> +#define PG_marker		14
>  				/* bits 21-29 unused */
>  #define PG_arch_1		30
>  #define PG_reserved		31
> @@ -242,6 +243,9 @@
>  #define PageInactiveClean(page)	
> test_bit(PG_inactive_clean, &(page)->flags)
>  #define SetPageInactiveClean(page)	
> set_bit(PG_inactive_clean, &(page)->flags)
>  #define ClearPageInactiveClean(page)	
> clear_bit(PG_inactive_clean, &(page)->flags)
> +
> +#define PageMarker(page)	test_bit(PG_marker, &(page)->flags)
> +#define SetPageMarker(page)	set_bit(PG_marker, &(page)->flags)
> 
>  #ifdef CONFIG_HIGHMEM
>  #define PageHighMem(page)		test_bit(PG_highmem, 
> &(page)->flags)
> diff -ur linux-2.4.6-pre2-virgin/include/linux/swap.h 
> linux-2.4.6-pre2/include/linux/swap.h
> --- linux-2.4.6-pre2-virgin/include/linux/swap.h	Sun Jun 
> 10 00:44:01 2001
> +++ linux-2.4.6-pre2/include/linux/swap.h	Sat Jun  9 23:19:54 2001
> @@ -205,6 +205,16 @@
>  	page->zone->inactive_dirty_pages++; \
>  }
> 
> +/* Like the above, but add us after the bookmark. */
> +#define add_page_to_inactive_dirty_list_marker(page) { \
> +	DEBUG_ADD_PAGE \
> +	ZERO_PAGE_BUG \
> +	SetPageInactiveDirty(page); \
> +	list_add(&(page)->lru, marker_lru); \
> +	nr_inactive_dirty_pages++; \
> +	page->zone->inactive_dirty_pages++; \
> +}
> +
>  #define add_page_to_inactive_clean_list(page) { \
>  	DEBUG_ADD_PAGE \
>  	ZERO_PAGE_BUG \
> diff -ur linux-2.4.6-pre2-virgin/mm/vmscan.c 
> linux-2.4.6-pre2/mm/vmscan.c
> --- linux-2.4.6-pre2-virgin/mm/vmscan.c	Sun Jun 10 00:44:02 2001
> +++ linux-2.4.6-pre2/mm/vmscan.c	Sun Jun 10 00:57:25 2001
> @@ -407,7 +407,7 @@
>  /**
>   * page_launder - clean dirty inactive pages, move to 
> inactive_clean list
>   * @gfp_mask: what operations we are allowed to do
> - * @sync: should we wait synchronously for the cleaning of pages
> + * @sync: are we allowed to do synchronous IO in emergencies ?
>   *
>   * When this function is called, we are most likely low on free +
>   * inactive_clean pages. Since we want to refill those pages 
> as @@ -428,20 +428,54 @@
>  #define CAN_DO_BUFFERS		(gfp_mask & __GFP_BUFFER)
>  int page_launder(int gfp_mask, int sync)
>  {
> +	static int cannot_free_pages;
>  	int launder_loop, maxscan, cleaned_pages, maxlaunder;
> -	struct list_head * page_lru;
> +	struct list_head * page_lru, * marker_lru;
>  	struct page * page;
> 
> +	/* Our bookmark of where we are in the inactive_dirty list. */
> +	struct page marker_page_struct = {
> +		flags: (1<<PG_marker),
> +		lru: { NULL, NULL },
> +	};
> +	marker_lru = &marker_page_struct.lru;
> +
>  	launder_loop = 0;
>  	maxlaunder = 0;
>  	cleaned_pages = 0;
> 
>  dirty_page_rescan:
>  	spin_lock(&pagemap_lru_lock);
> -	maxscan = nr_inactive_dirty_pages;
> -	while ((page_lru = inactive_dirty_list.prev) != 
> &inactive_dirty_list &&
> -				maxscan-- > 0) {
> +	/*
> +	 * By not scanning all inactive dirty pages we'll write out
> +	 * really old dirty pages before evicting newer clean pages.
> +	 * This should cause some LRU behaviour if we have a large
> +	 * amount of inactive pages (due to eg. drop behind).
> +	 *
> +	 * It also makes us accumulate dirty pages until we have enough
> +	 * to be worth writing to disk without causing excessive disk
> +	 * seeks and eliminates the infinite penalty clean 
> pages incurred
> +	 * vs. dirty pages.
> +	 */
> +	maxscan = nr_inactive_dirty_pages / 4;
> +	if (launder_loop)
> +		maxscan *= 2;
> +	list_add_tail(marker_lru, &inactive_dirty_list);
> +	while ((page_lru = marker_lru->prev) != &inactive_dirty_list &&
> +			maxscan-- > 0 && free_shortage()) {
>  		page = list_entry(page_lru, struct page, lru);
> +		/* We move the bookmark forward by flipping the 
> page ;) */
> +		list_del(page_lru);
> +		list_add(page_lru, marker_lru);
> +
> +		/* Don't waste CPU if chances are we cannot 
> free anything. */
> +		if (launder_loop && maxlaunder < 0 && cannot_free_pages)
> +			break;
> +
> +		/* Skip other people's marker pages. */
> +		if (PageMarker(page)) {
> +			continue;
> +		}
> 
>  		/* Wrong page on list?! (list corruption, 
> should not happen) */
>  		if (!PageInactiveDirty(page)) {
> @@ -454,7 +488,6 @@
> 
>  		/* Page is or was in use?  Move it to the 
> active list. */
>  		if (PageReferenced(page) || page->age > 0 ||
> -				page->zone->free_pages > 
> page->zone->pages_high ||
>  				(!page->buffers && 
> page_count(page) > 1) ||
>  				page_ramdisk(page)) {
>  			del_page_from_inactive_dirty_list(page);
> @@ -464,11 +497,9 @@
> 
>  		/*
>  		 * The page is locked. IO in progress?
> -		 * Move it to the back of the list.
> +		 * Skip the page, we'll take a look when it unlocks.
>  		 */
>  		if (TryLockPage(page)) {
> -			list_del(page_lru);
> -			list_add(page_lru, &inactive_dirty_list);
>  			continue;
>  		}
> 
> @@ -482,10 +513,8 @@
>  			if (!writepage)
>  				goto page_active;
> 
> -			/* First time through? Move it to the 
> back of the list */
> +			/* First time through? Skip the page. */
>  			if (!launder_loop || !CAN_DO_IO) {
> -				list_del(page_lru);
> -				list_add(page_lru, 
> &inactive_dirty_list);
>  				UnlockPage(page);
>  				continue;
>  			}
> @@ -544,7 +573,7 @@
> 
>  			/* The buffers were not freed. */
>  			if (!clearedbuf) {
> -				add_page_to_inactive_dirty_list(page);
> +				
> add_page_to_inactive_dirty_list_marker(page);
> 
>  			/* The page was only in the buffer cache. */
>  			} else if (!page->mapping) {
> @@ -600,6 +629,8 @@
>  			UnlockPage(page);
>  		}
>  	}
> +	/* Remove our marker. */
> +	list_del(marker_lru);
>  	spin_unlock(&pagemap_lru_lock);
> 
>  	/*
> @@ -615,16 +646,29 @@
>  	 */
>  	if ((CAN_DO_IO || CAN_DO_BUFFERS) && !launder_loop && 
> free_shortage()) {
>  		launder_loop = 1;
> -		/* If we cleaned pages, never do synchronous IO. */
> -		if (cleaned_pages)
> +		/*
> +		 * If we, or the previous process running 
> page_launder(),
> +		 * managed to free any pages we never do synchronous IO.
> +		 */
> +		if (cleaned_pages || !cannot_free_pages)
>  			sync = 0;
> +		/* Else, do synchronous IO (if we are allowed to). */
> +		else if (sync)
> +			sync = 1;
>  		/* We only do a few "out of order" flushes. */
>  		maxlaunder = MAX_LAUNDER;
> -		/* Kflushd takes care of the rest. */
> +		/* Let bdflush take care of the rest. */
>  		wakeup_bdflush(0);
>  		goto dirty_page_rescan;
>  	}
> 
> +	/*
> +	 * If we failed to free pages (because all pages are dirty)
> +	 * we remember this for the next time. This will prevent us
> +	 * from wasting too much CPU here.
> +	 */
> +	cannot_free_pages = !cleaned_pages;
> +
>  	/* Return the number of pages moved to the 
> inactive_clean list. */
>  	return cleaned_pages;
>  }
> @@ -852,7 +896,7 @@
>  	 * list, so this is a relatively cheap operation.
>  	 */
>  	if (free_shortage()) {
> -		ret += page_launder(gfp_mask, user);
> +		ret += page_launder(gfp_mask, 1);
>  		shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
>  		shrink_icache_memory(DEF_PRIORITY, gfp_mask);
>  	}
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the 
> FAQ at  http://www.tux.org/lkml/
> 

