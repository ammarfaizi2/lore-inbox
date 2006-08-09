Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030666AbWHIKgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030666AbWHIKgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030667AbWHIKgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:36:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4517 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030666AbWHIKga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:36:30 -0400
Date: Wed, 9 Aug 2006 12:36:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
Subject: Re: [RFC][PATCH -mm 5/5] swsusp: Introduce some helpful constants
Message-ID: <20060809103615.GL3308@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608091213.18418.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608091213.18418.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-08-09 12:13:18, Rafael J. Wysocki wrote:
> Introduce some constants that hopefully will help improve the readability kernel/power/snapshot.c |   45 +++++++++++++++++++++++++--------------------
>  1 files changed, 25 insertions(+), 20 deletions(-)
>

You probably want to add signed-off-by:... aha, it is below the
patch. Some script went crazy inserting diff at wrong place. Otherwise
ACK.

							Pavel

> Index: linux-2.6.18-rc3-mm2/kernel/power/snapshot.c
> ===================================================================
> --- linux-2.6.18-rc3-mm2.orig/kernel/power/snapshot.c
> +++ linux-2.6.18-rc3-mm2/kernel/power/snapshot.c
> @@ -57,6 +57,11 @@ static void *buffer;
>   *	so that swsusp_free() can release it.
>   */
>  
> +#define PG_ANY		0
> +#define PG_SAFE		1
> +#define PG_UNSAFE_CLEAR	1
> +#define PG_UNSAFE_KEEP	0
> +
>  static unsigned int allocated_unsafe_pages;
>  
>  static void *get_image_page(gfp_t gfp_mask, int safe_needed)
> @@ -357,7 +362,7 @@ create_memory_bm(struct memory_bitmap *b
>  	zone_bm = create_zone_bm_list(nr, &ca);
>  	bm->zone_bm_list = zone_bm;
>  	if (!zone_bm) {
> -		chain_free(&ca, 1);
> +		chain_free(&ca, PG_UNSAFE_CLEAR);
>  		return -ENOMEM;
>  	}
>  
> @@ -410,7 +415,7 @@ create_memory_bm(struct memory_bitmap *b
>  
>  Free:
>  	bm->p_list = ca.chain;
> -	free_memory_bm(bm, 1);
> +	free_memory_bm(bm, PG_UNSAFE_CLEAR);
>  	return -ENOMEM;
>  }
>  
> @@ -936,15 +941,15 @@ swsusp_alloc(struct memory_bitmap *orig_
>  {
>  	int error;
>  
> -	error = create_memory_bm(orig_bm, GFP_ATOMIC, 0);
> +	error = create_memory_bm(orig_bm, GFP_ATOMIC, PG_ANY);
>  	if (error)
>  		goto Free;
>  
> -	error = create_memory_bm(copy_bm, GFP_ATOMIC, 0);
> +	error = create_memory_bm(copy_bm, GFP_ATOMIC, PG_ANY);
>  	if (error)
>  		goto Free;
>  
> -	error = get_highmem_buffer(0);
> +	error = get_highmem_buffer(PG_ANY);
>  	if (error)
>  		goto Free;
>  
> @@ -1078,7 +1083,7 @@ int snapshot_read_next(struct snapshot_h
>  
>  	if (!buffer) {
>  		/* This makes the buffer be freed by swsusp_free() */
> -		buffer = get_image_page(GFP_ATOMIC, 0);
> +		buffer = get_image_page(GFP_ATOMIC, PG_ANY);
>  		if (!buffer)
>  			return -ENOMEM;
>  	}
> @@ -1299,10 +1304,10 @@ prepare_highmem_image(struct memory_bitm
>  {
>  	unsigned int to_alloc;
>  
> -	if (create_memory_bm(bm, GFP_ATOMIC, 1))
> +	if (create_memory_bm(bm, GFP_ATOMIC, PG_SAFE))
>  		return -ENOMEM;
>  
> -	if (get_highmem_buffer(1))
> +	if (get_highmem_buffer(PG_SAFE))
>  		return -ENOMEM;
>  
>  	to_alloc = count_free_highmem_pages();
> @@ -1415,8 +1420,8 @@ static inline int last_highmem_page_copi
>  
>  static inline void free_highmem_data(void)
>  {
> -	free_memory_bm(safe_highmem_bm, 1);
> -	free_image_page(buffer, 1);
> +	free_memory_bm(safe_highmem_bm, PG_UNSAFE_CLEAR);
> +	free_image_page(buffer, PG_UNSAFE_CLEAR);
>  }
>  #else
>  static inline int get_safe_write_buffer(void) { return 0; }
> @@ -1465,19 +1470,19 @@ prepare_image(struct memory_bitmap *new_
>  	int error;
>  
>  	/* If there is no highmem, the buffer will not be necessary */
> -	free_image_page(buffer, 1);
> +	free_image_page(buffer, PG_UNSAFE_CLEAR);
>  
>  	nr_highmem = count_highmem_image_pages(bm);
>  	error = mark_unsafe_pages(bm);
>  	if (error)
>  		goto Free;
>  
> -	error = create_memory_bm(new_bm, GFP_ATOMIC, 1);
> +	error = create_memory_bm(new_bm, GFP_ATOMIC, PG_SAFE);
>  	if (error)
>  		goto Free;
>  
>  	duplicate_memory_bitmap(new_bm, bm);
> -	free_memory_bm(bm, 0);
> +	free_memory_bm(bm, PG_UNSAFE_KEEP);
>  	if (nr_highmem > 0) {
>  		error = prepare_highmem_image(bm, &nr_highmem);
>  		if (error)
> @@ -1494,7 +1499,7 @@ prepare_image(struct memory_bitmap *new_
>  	nr_pages = nr_copy_pages - nr_highmem - allocated_unsafe_pages;
>  	nr_pages = DIV_ROUND_UP(nr_pages, PBES_PER_LINKED_PAGE);
>  	while (nr_pages > 0) {
> -		lp = get_image_page(GFP_ATOMIC, 1);
> +		lp = get_image_page(GFP_ATOMIC, PG_SAFE);
>  		if (!lp) {
>  			error = -ENOMEM;
>  			goto Free;
> @@ -1525,7 +1530,7 @@ prepare_image(struct memory_bitmap *new_
>  	/* Free the reserved safe pages so that chain_alloc() can use them */
>  	while (sp_list) {
>  		lp = sp_list->next;
> -		free_image_page(sp_list, 1);
> +		free_image_page(sp_list, PG_UNSAFE_CLEAR);
>  		sp_list = lp;
>  	}
>  	return 0;
> @@ -1604,7 +1609,7 @@ int snapshot_write_next(struct snapshot_
>  	if (handle->offset == 0) {
>  		if (!buffer)
>  			/* This makes the buffer be freed by swsusp_free() */
> -			buffer = get_image_page(GFP_ATOMIC, 0);
> +			buffer = get_image_page(GFP_ATOMIC, PG_ANY);
>  
>  		if (!buffer)
>  			return -ENOMEM;
> @@ -1618,7 +1623,7 @@ int snapshot_write_next(struct snapshot_
>  			if (error)
>  				return error;
>  
> -			error = create_memory_bm(&copy_bm, GFP_ATOMIC, 0);
> +			error = create_memory_bm(&copy_bm, GFP_ATOMIC, PG_ANY);
>  			if (error)
>  				return error;
>  
> @@ -1668,7 +1673,7 @@ void snapshot_write_finalize(struct snap
>  	copy_last_highmem_page();
>  	/* Free only if we have loaded the image entirely */
>  	if (handle->prev && handle->cur > nr_meta_pages + nr_copy_pages) {
> -		free_memory_bm(&orig_bm, 1);
> +		free_memory_bm(&orig_bm, PG_UNSAFE_CLEAR);
>  		free_highmem_data();
>  	}
>  }
> @@ -1710,7 +1715,7 @@ int restore_highmem(void)
>  	struct highmem_pbe *pbe = highmem_pblist;
>  	void *buf;
>  
> -	buf = get_image_page(GFP_ATOMIC, 1);
> +	buf = get_image_page(GFP_ATOMIC, PG_SAFE);
>  	if (!buf)
>  		return -ENOMEM;
>  
> @@ -1718,7 +1723,7 @@ int restore_highmem(void)
>  		swap_two_pages_data(pbe->copy_page, pbe->orig_page, buf);
>  		pbe = pbe->next;
>  	}
> -	free_image_page(buf, 1);
> +	free_image_page(buf, PG_UNSAFE_CLEAR);
>  	return 0;
>  }
>  #endif /* CONFIG_HIGHMEM */
> 
> of the code.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
