Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUDCQAE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 11:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbUDCQAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 11:00:04 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38066
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261817AbUDCP75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 10:59:57 -0500
Date: Sat, 3 Apr 2004 17:59:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       hugh@veritas.com, vrajesh@umich.edu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040403155958.GF2307@dualathlon.random>
References: <20040401173649.22f734cd.akpm@osdl.org> <20040402020022.GN18585@dualathlon.random> <20040402104334.A871@infradead.org> <20040402164634.GF21341@dualathlon.random> <20040402195927.A6659@infradead.org> <20040402192941.GP21341@dualathlon.random> <20040402205410.A7194@infradead.org> <20040402203514.GR21341@dualathlon.random> <20040403094058.A13091@infradead.org> <20040403152026.GE2307@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040403152026.GE2307@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2004 at 05:20:26PM +0200, Andrea Arcangeli wrote:
> if you want you can give a spin to this patch. As far as the old code
> worked (i.e. with hugetlbfs=n) this should work too, since it disables
> the compound feature completely, but if it works it probably only hides
> the real bug. You can use rc3-aa3 for this (it already has the latest
> robustness fixes I posted to you)
> 
> --- x/mm/page_alloc.c.~1~	2004-04-02 20:37:14.000000000 +0200
> +++ x/mm/page_alloc.c	2004-04-03 17:15:52.647449336 +0200
> @@ -563,7 +563,9 @@ __alloc_pages(unsigned int gfp_mask, uns
>  	cold = 0;
>  	if (gfp_mask & __GFP_COLD)
>  		cold = __GFP_COLD;
> +#if 0
>  	if (gfp_mask & __GFP_NO_COMP)
> +#endif
>  		cold |= __GFP_NO_COMP;
>  
>  	zones = zonelist->zones;  /* the list of zones suitable for gfp_mask */

I've written another piece of debugging code for you, this is also to
apply on top of rc3-aa3, but of course not at the same time as the above
one. The above one disables compound compeltely, while the below one is
trying to debug what's going wrong in compound.

Basically I store a backup copy of page->private into page->mapping
(arch is 32bit so they're the same size). we know for sure you're not
going to map into userspace those order >0 pages since hugetlbfs is off,
so reusing mapcount as a backup copy of page->private for compound pages
should be ok.

this way when we get the screwed page->private we see what's going on,
and if page->mapping is still pointing to 'page'. If page->mapping ==
page at least we know it's only page->private being corrupt. I don't
really see how can ppc32 corrupt page->private though.

--- x-debug/mm/page_alloc.c.~1~	2004-04-02 20:37:14.000000000 +0200
+++ x-debug/mm/page_alloc.c	2004-04-03 17:55:16.629069504 +0200
@@ -122,6 +122,7 @@ static void prep_compound_page(struct pa
 
 		SetPageCompound(p);
 		p->private = (unsigned long)page;
+		p->mapcount = (unsigned int)page; /* works 32bit only */
 	}
 }
 
@@ -130,16 +131,30 @@ static void destroy_compound_page(struct
 	int i;
 	int nr_pages = 1 << order;
 
-	if (page[1].index != order)
+	if (page[1].index != order) {
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__);
 		bad_page(__FUNCTION__, page);
+	}
+	if ((unsigned long) page != page->private || page->private != page->mapcount) {
+		printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__);
+		printk("private %lx real %x page %p\n", page->private, page->mapcount, page);
+		bad_page(__FUNCTION__, page);
+	}
 
 	for (i = 0; i < nr_pages; i++) {
 		struct page *p = page + i;
 
-		if (!PageCompound(p))
+		if (!PageCompound(p)) {
+			printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__);
+			printk("index %d\n", i);
 			bad_page(__FUNCTION__, p);
-		if (p->private != (unsigned long)page)
+		}
+		if (p->private != (unsigned long)page || p->private != p->mapcount) {
+			printk("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__);
+			printk("index %d private %lx real %x page %p\n", i, p->private, p->mapcount, page);
 			bad_page(__FUNCTION__, p);
+			
+		}
 		ClearPageCompound(p);
 	}
 }
@@ -211,7 +226,6 @@ static inline void __free_pages_bulk (st
 static inline void free_pages_check(const char *function, struct page *page)
 {
 	if (	page->mapping != NULL ||
-		page->mapcount ||
 		page_count(page) != 0 ||
 		(page->flags & (
 			1 << PG_lru	|
@@ -316,7 +330,6 @@ static void prep_new_page(struct page * 
 		struct page * page = _page + i;
 
 		if (page->mapping ||
-		    page->mapcount ||
 		    (page->flags & (
 				    1 << PG_private	|
 				    1 << PG_locked	|
@@ -336,6 +349,7 @@ static void prep_new_page(struct page * 
 				 1 << PG_checked | 1 << PG_mappedtodisk |
 				 1 << PG_compound);
 		page->private = 0;
+		page->mapcount = 0;
 		set_page_count(page, 1);
 	}
 }
