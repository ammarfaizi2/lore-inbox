Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132416AbREHMpN>; Tue, 8 May 2001 08:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132425AbREHMox>; Tue, 8 May 2001 08:44:53 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:46566 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S132471AbREHMoe>; Tue, 8 May 2001 08:44:34 -0400
Date: Tue, 8 May 2001 12:56:02 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] allocation looping + kswapd CPU cycles 
Message-ID: <Pine.LNX.4.21.0105081225520.31900-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  In 2.4.3pre6, code in page_alloc.c:__alloc_pages(), changed from;

	try_to_free_pages(gfp_mask);
	wakeup_bdflush();
	if (!order)
		goto try_again;
to
	try_to_free_pages(gfp_mask);
	wakeup_bdflush();
	goto try_again;


  This introduced the effect of a non-zero order, __GFP_WAIT allocation
(without PF_MEMALLOC set), never returning failure.  The allocation keeps
looping in __alloc_pages(), kicking kswapd, until the allocation succeeds.

  If there is plenty of memory in the free-pools and inactive-lists
free_shortage() will return false, causing the state of these
free-pools/inactive-lists not to be 'improved' by kswapd.

  If there is nothing else changing/improving the free-pools or
inactive-lists, the allocation loops forever (kicking kswapd).

  Does anyone know why the 2.4.3pre6 change was made?

  The attached patch (against 2.4.5-pre1) fixes the looping symptom, by
adding a counter and looping only twice for non-zero order allocations.

  The real fix is to measure fragmentation and the progress of kswapd, but
that is too drastic for 2.4.x.

Mark


diff -ur linux-2.4.5-pre1/mm/page_alloc.c markhe-2.4.5-pre1/mm/page_alloc.c
--- linux-2.4.5-pre1/mm/page_alloc.c	Fri Apr 27 22:18:08 2001
+++ markhe-2.4.5-pre1/mm/page_alloc.c	Tue May  8 13:42:12 2001
@@ -275,6 +275,7 @@
 {
 	zone_t **zone;
 	int direct_reclaim = 0;
+	int loop;
 	unsigned int gfp_mask = zonelist->gfp_mask;
 	struct page * page;
 
@@ -313,6 +314,7 @@
 			&& nr_inactive_dirty_pages >= freepages.high)
 		wakeup_bdflush(0);
 
+	loop = 0;
 try_again:
 	/*
 	 * First, see if we have any zones with lots of free memory.
@@ -453,7 +455,8 @@
 		if (gfp_mask & __GFP_WAIT) {
 			memory_pressure++;
 			try_to_free_pages(gfp_mask);
-			goto try_again;
+			if (!order || loop++ < 2)
+				goto try_again;
 		}
 	}
 

