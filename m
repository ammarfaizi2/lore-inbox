Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316192AbSFAAMo>; Fri, 31 May 2002 20:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316965AbSFAAMo>; Fri, 31 May 2002 20:12:44 -0400
Received: from c-24-126-73-164.we.client2.attbi.com ([24.126.73.164]:47609
	"EHLO kegel.com") by vger.kernel.org with ESMTP id <S316192AbSFAAMn>;
	Fri, 31 May 2002 20:12:43 -0400
Date: Fri, 31 May 2002 17:13:43 -0700
From: Dan Kegel <dank@kegel.com>
Message-Id: <200206010013.g510Dhi20565@kegel.com>
To: linux-kernel@vger.kernel.org
Subject: Minipatch to free SKBs on OOM
Cc: dank@alumni.caltech.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A coworker was running into OOM problems when doing heavy
networking, and came up with the following patch.  He says
it's the smallest subset of the existing mm patches that
solves his problem.
Can someone who knows the mm code comment on the quality 
and safety of this patch?
This is against vanilla 2.4.19-pre9.
Thanks,
Dan

--- linux/mm/page_alloc.c.orig	Fri May 31 16:04:21 2002
+++ linux/mm/page_alloc.c	Fri May 31 16:38:28 2002
@@ -414,8 +414,13 @@
 	struct page * page;
 
 	page = alloc_pages(gfp_mask, order);
-	if (!page)
-		return 0;
+	if (!page) {
+		refill_inactive(1 << order);
+		(void) kmem_cache_reap(gfp_mask);
+		page = alloc_pages(gfp_mask, order);
+		if (!page)
+			return 0;
+	}
 	return (unsigned long) page_address(page);
 }
 
--- linux/mm/vmscan.c.orig	Fri May 31 16:04:21 2002
+++ linux/mm/vmscan.c	Fri May 31 16:41:11 2002
@@ -531,7 +531,7 @@
  * We move them the other way when we see the
  * reference bit on the page.
  */
-static void refill_inactive(int nr_pages)
+void refill_inactive(int nr_pages)
 {
 	struct list_head * entry;
 
@@ -597,6 +597,10 @@
 			return 1;
 	} while (--priority);
 
+	refill_inactive(nr_pages);
+	if (kmem_cache_reap(gfp_mask))
+		return 1;
+
 	/*
 	 * Hmm.. Cache shrink failed - time to kill something?
 	 * Mhwahahhaha! This is the part I really like. Giggle.
--- linux/include/linux/swap.h.orig	Fri May 31 16:22:01 2002
+++ linux/include/linux/swap.h	Fri May 31 16:32:57 2002
@@ -112,6 +112,7 @@
 /* linux/mm/vmscan.c */
 extern wait_queue_head_t kswapd_wait;
 extern int FASTCALL(try_to_free_pages(zone_t *, unsigned int, unsigned int));
+extern void refill_inactive(int nr_pages);
 
 /* linux/mm/page_io.c */
 extern void rw_swap_page(int, struct page *);
