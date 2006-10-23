Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWJWPEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWJWPEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964917AbWJWPEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:04:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54159 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964913AbWJWPEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:04:51 -0400
Date: Mon, 23 Oct 2006 17:04:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] swsusp: Improve handling of highmem
Message-ID: <20061023150444.GC31273@elf.ucw.cz>
References: <200610142156.05161.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610142156.05161.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

> Currently swsusp saves the contents of highmem pages by copying them to the
> normal zone which is quite inefficient  (eg. it requires two normal pages to be
> used for saving one highmem page).  This may be improved by using highmem
> for saving the contents of saveable highmem pages.
...
>  include/linux/suspend.h |    9 
>  kernel/power/power.h    |    2 
>  kernel/power/snapshot.c |  841 ++++++++++++++++++++++++++++++++++++------------
>  kernel/power/swap.c     |    2 
>  kernel/power/swsusp.c   |   53 +--
>  kernel/power/user.c     |    2 
>  mm/vmscan.c             |    3 

Well, I just hoped that highmem would quietly die out...

...
> +static struct page *alloc_image_page(gfp_t gfp_mask) {
> +	struct page *page;

{ should go on new line.

>  	memory_bm_position_reset(orig_bm);
>  	memory_bm_position_reset(copy_bm);
>  	do {
>  		pfn = memory_bm_next_pfn(orig_bm);
> -		if (likely(pfn != BM_END_OF_MAP)) {
> -			struct page *page;
> -			void *src;
> -
> -			page = pfn_to_page(pfn);
> -			src = page_address(page);
> -			page = pfn_to_page(memory_bm_next_pfn(copy_bm));
> -			copy_data_page(page_address(page), src);
> -		}
> +		if (likely(pfn != BM_END_OF_MAP))
> +			copy_data_page(memory_bm_next_pfn(copy_bm), pfn);
>  	} while (pfn != BM_END_OF_MAP);
>  }

While(1) and "if (pfn != BM_END_OF_MAP) { ...break; } ? Why do you
need to test pfn != BM_END_OF_MAP *three* times?

> Index: linux-2.6.18-mm3/mm/vmscan.c
> ===================================================================
> --- linux-2.6.18-mm3.orig/mm/vmscan.c
> +++ linux-2.6.18-mm3/mm/vmscan.c
> @@ -1233,6 +1233,9 @@ out:
>  	}
>  	if (!all_zones_ok) {
>  		cond_resched();
> +
> +		try_to_freeze();
> +
>  		goto loop_again;
>  	}

What is this?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
