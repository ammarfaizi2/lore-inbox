Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVKVMcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVKVMcJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 07:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbVKVMcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 07:32:09 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:53159 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964898AbVKVMcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 07:32:08 -0500
Subject: Re: [patch 6/12] mm: remove bad_range
From: Dave Hansen <haveblue@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20051121124126.14370.50844.sendpatchset@didi.local0.net>
References: <20051121123906.14370.3039.sendpatchset@didi.local0.net>
	 <20051121124126.14370.50844.sendpatchset@didi.local0.net>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 13:32:04 +0100
Message-Id: <1132662725.6696.45.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 10:12 -0500, Nick Piggin wrote:
> )
> X-Fetchmail-Warning: recipient address lkml2@sr71.net didn't match any local name
> 
> bad_range is supposed to be a temporary check. It would be a pity to throw
> it out. Make it depend on CONFIG_DEBUG_VM instead.
> 
> CONFIG_HOLES_IN_ZONE systems were relying on this to check pfn_valid in
> the page allocator. Add that to page_is_buddy instead.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> 
> Index: linux-2.6/mm/page_alloc.c
> ===================================================================
> --- linux-2.6.orig/mm/page_alloc.c
> +++ linux-2.6/mm/page_alloc.c
> @@ -81,6 +81,7 @@ int min_free_kbytes = 1024;
>  unsigned long __initdata nr_kernel_pages;
>  unsigned long __initdata nr_all_pages;
>  
> +#ifdef CONFIG_DEBUG_VM
>  static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
>  {
>  	int ret = 0;
> @@ -122,6 +123,13 @@ static int bad_range(struct zone *zone, 
>  	return 0;
>  }
>  
> +#else
> +static inline int bad_range(struct zone *zone, struct page *page)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static void bad_page(const char *function, struct page *page)
...
>  static inline int page_is_buddy(struct page *page, int order)
>  {
> +#ifdef CONFIG_HOLES_IN_ZONE
> +	if (!pfn_valid(page_to_pfn(page)))
> +		return 0;
> +#endif
> +
>         if (PagePrivate(page)           &&
>             (page_order(page) == order) &&
>              page_count(page) == 0)
> @@ -320,17 +334,15 @@ static inline void __free_pages_bulk (st
>  		struct free_area *area;
>  		struct page *buddy;
>  
> -		combined_idx = __find_combined_index(page_idx, order);
>  		buddy = __page_find_buddy(page, page_idx, order);
> -
> -		if (bad_range(zone, buddy))
> -			break;
>  		if (!page_is_buddy(buddy, order))
>  			break;		/* Move the buddy up one level. */

I seem to also remember a case with this bad_range() check was useful
for zones that don't have their boundaries aligned on a MAX_ORDER
boundary.  Would this change break such a zone?  Do we care?

-- Dave

