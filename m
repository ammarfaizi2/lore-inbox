Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUDWK2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUDWK2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 06:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264779AbUDWK2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 06:28:44 -0400
Received: from holomorphy.com ([207.189.100.168]:24488 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264153AbUDWK2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 06:28:41 -0400
Date: Fri, 23 Apr 2004 03:28:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: put_page() tries to handle hugepages but fails
Message-ID: <20040423102824.GF743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
References: <20040423081856.GJ9243@zax> <20040423013437.1f2b8fc6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423013437.1f2b8fc6.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 01:34:37AM -0700, Andrew Morton wrote:
> We could certainly remove the test for a null destructor in there and
> require that compound pages have a destructor installed.
> But the main reason why that code is in there is for transparently handling
> direct-io into hugepage regions.  That code does perform put_page against
> 4k pageframes within the huge page and it does follow the pointer to the
> head page.
> With your patch applied get_user_pages() and bio_release_pages() will
> manipulate the refcounts of the inner 4k pages rather than the head pages
> and things will explode.
> We could change follow_hugetlb_page() to always take a ref against the head
> page and we could teach bio_release_pages() to perform appropriate pfn
> masking to locate the head page, and perform similar tricks for
> futexes-in-large-pages.  But with the code as-is the refcounting works
> transparently.
> If it's "broken" I wanna know why.

The destructor is never invoked from that path, but it's not the path that
should free it anyway. To me it appears the call to __page_cache_release()
on the head of the hugepage should just be removed in favor of doing
nothing; at best it can only race against concurrent put_page(), see
page_count(page) vanish, and accidentally call free_hot_page() against
the head of the hugepage. As hugepages are never on the LRU, the
remainder of __page_cache_release() should be a nop for them.

Untested patch below.


-- wli


Index: wli-2.6.6-rc2-mm1/mm/swap.c
===================================================================
--- wli-2.6.6-rc2-mm1.orig/mm/swap.c	2004-04-21 05:19:58.000000000 -0700
+++ wli-2.6.6-rc2-mm1/mm/swap.c	2004-04-23 03:21:22.000000000 -0700
@@ -41,15 +41,12 @@
 	if (unlikely(PageCompound(page))) {
 		page = (struct page *)page->private;
 		if (put_page_testzero(page)) {
-			if (page[1].mapping) {	/* destructor? */
-				(*(void (*)(struct page *))page[1].mapping)(page);
-			} else {
-				__page_cache_release(page);
-			}
+			void (*destructor)(struct page *);
+			destructor = (void (*)(struct page *))page[1].mapping;
+			BUG_ON(!destructor);
+			(*destructor)(page);
 		}
-		return;
-	}
-	if (!PageReserved(page) && put_page_testzero(page))
+	} else if (!PageReserved(page) && put_page_testzero(page))
 		__page_cache_release(page);
 }
 EXPORT_SYMBOL(put_page);
