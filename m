Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWECUH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWECUH4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 16:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWECUH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 16:07:56 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:6334 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1750782AbWECUH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 16:07:56 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-Id: <20060503200755.1608.87580.sendpatchset@tetsuo.zabbo.net>
Subject: [PATCH] AOP_TRUNCATED_PAGE victims in read_pages() belong in the LRU
Date: Wed,  3 May 2006 13:07:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AOP_TRUNCATED_PAGE victims in read_pages() belong in the LRU

Nick Piggin rightly pointed out that the introduction of AOP_TRUNCATED_PAGE to
read_pages() was wrong to leave A_T_P victim pages in the page cache but not
put them in the LRU.  Failing to do so hid them from the VM.

A_T_P just means that the aop method unlocked the page rather than performing
IO.  It would be very rare that the page was truncated between the unlock and
testing A_T_P.  So we leave the pages in the LRU for likely reuse soon rather
than backing them back out of the page cache.  We do this by matching the
behaviour before the A_T_P introduction which added pages to the LRU regardless
of what ->readpage() did.

This doesn't include the unrelated cleanup in Nick's initial fix which changed
read_pages() to return void to match its only caller's behaviour of ignoring
errors.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 mm/readahead.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

Index: 2.6.17-rc3-git7-read_pages-fix/mm/readahead.c
===================================================================
--- 2.6.17-rc3-git7-read_pages-fix.orig/mm/readahead.c
+++ 2.6.17-rc3-git7-read_pages-fix/mm/readahead.c
@@ -182,14 +182,11 @@ static int read_pages(struct address_spa
 		list_del(&page->lru);
 		if (!add_to_page_cache(page, mapping,
 					page->index, GFP_KERNEL)) {
-			ret = mapping->a_ops->readpage(filp, page);
-			if (ret != AOP_TRUNCATED_PAGE) {
-				if (!pagevec_add(&lru_pvec, page))
-					__pagevec_lru_add(&lru_pvec);
-				continue;
-			} /* else fall through to release */
-		}
-		page_cache_release(page);
+			mapping->a_ops->readpage(filp, page);
+			if (!pagevec_add(&lru_pvec, page))
+				__pagevec_lru_add(&lru_pvec);
+		} else
+			page_cache_release(page);
 	}
 	pagevec_lru_add(&lru_pvec);
 	ret = 0;
