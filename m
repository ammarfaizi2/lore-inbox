Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUBVFoV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 00:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUBVFoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 00:44:21 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:57984 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S261160AbUBVFoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 00:44:19 -0500
Date: Sat, 21 Feb 2004 21:44:17 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-ID: <20040222054417.GA14775@dingdong.cryptoapps.com>
References: <20040222023638.GA13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org> <20040222031113.GB13840@dingdong.cryptoapps.com> <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org> <20040222033111.GA14197@dingdong.cryptoapps.com> <4038299E.9030907@cyberone.com.au> <40382BAA.1000802@cyberone.com.au> <4038307B.2090405@cyberone.com.au> <40383300.5010203@matchmail.com> <4038402A.4030708@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4038402A.4030708@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 04:37:46PM +1100, Nick Piggin wrote:

> Can you upgrade to 2.6.3-mm2? It would be ideal if you could test
> this patch against that kernel due to the other VM changes.

Sure.

> Chris, could you test this too please? Thanks.

I tested this change to a stock 2.6.3 kernel and saw a marginally
better situation... 650MB in slab instead of 850MB:

===== page_alloc.c 1.186 vs edited =====
--- 1.186/mm/page_alloc.c	Wed Feb 18 19:43:04 2004
+++ edited/page_alloc.c	Sat Feb 21 21:05:32 2004
@@ -764,13 +764,18 @@
 
 EXPORT_SYMBOL(nr_free_pages);
 
+/*
+ * return the number of non-highmem pages (we should probably rename
+ * this function? --cw)
+ */
 unsigned int nr_used_zone_pages(void)
 {
 	unsigned int pages = 0;
 	struct zone *zone;
 
 	for_each_zone(zone)
-		pages += zone->nr_active + zone->nr_inactive;
+		if (!is_highmem(zone))
+		    pages += zone->nr_active + zone->nr_inactive;
 
 	return pages;
 }


I'll test -mm2 with your patch shortly.

> 

> @@ -145,7 +145,7 @@ static int shrink_slab(unsigned long sca
>  	if (down_trylock(&shrinker_sem))
>  		return 0;
>  
> -	pages = nr_used_zone_pages();
> +	pages = nr_lowmem_lru_pages();

Cool. I think renaming this i a good idea.

> -unsigned int nr_used_zone_pages(void)
> +unsigned int nr_lowmem_lru_pages(void)
>  {
> +	pg_data_t *pgdat;
>  	unsigned int pages = 0;
> -	struct zone *zone;
>  
> -	for_each_zone(zone)
> -		pages += zone->nr_active + zone->nr_inactive;
> +	for_each_pgdat(pgdat) {
> +		int i;
> +		for (i = 0; i < ZONE_HIGHMEM; i++) {
> +			struct zone *zone = pgdat->node_zones + i;
> +			pages += zone->nr_active + zone->nr_inactive;
> +		}
> +	}

Why not just check is_highmem(zone) here?

> -extern unsigned int nr_used_zone_pages(void);
> +extern unsigned int nr_lowmem_lru_pages(void);

Since shrink_slab() is the only consumer of this why not move the
function to vmscan.c just above shrink_slab()?


