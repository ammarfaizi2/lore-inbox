Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135939AbRD0LaK>; Fri, 27 Apr 2001 07:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135942AbRD0LaA>; Fri, 27 Apr 2001 07:30:00 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:48146 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135939AbRD0L3u>; Fri, 27 Apr 2001 07:29:50 -0400
Date: Fri, 27 Apr 2001 06:50:01 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] allow PF_MEMALLOC tasks to directly reclaim pages 
Message-ID: <Pine.LNX.4.21.0104270511160.2756-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Currently __alloc_pages() does not allow PF_MEMALLOC tasks to free clean
inactive pages.

This is senseless --- if the allocation has __GFP_WAIT set, its ok to grab
the pagemap_lru_lock/pagecache_lock/etc.

I checked all possible codepaths after reclaim_page() and they are ok.

The following patch fixes that.


--- linux/mm/page_alloc.c.orig	Fri Apr 27 05:59:35 2001
+++ linux/mm/page_alloc.c	Fri Apr 27 05:59:48 2001
@@ -295,8 +295,7 @@
 	 * Can we take pages directly from the inactive_clean
 	 * list?
 	 */
-	if (order == 0 && (gfp_mask & __GFP_WAIT) &&
-			!(current->flags & PF_MEMALLOC))
+	if (order == 0 && (gfp_mask & __GFP_WAIT))
 		direct_reclaim = 1;
 
 	/*


