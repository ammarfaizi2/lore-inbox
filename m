Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289102AbSAJAlG>; Wed, 9 Jan 2002 19:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289103AbSAJAk4>; Wed, 9 Jan 2002 19:40:56 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:62646 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S289102AbSAJAki>; Wed, 9 Jan 2002 19:40:38 -0500
Date: Thu, 10 Jan 2002 00:42:08 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>, Dave Jones <davej@suse.de>,
        Ben LaHaise <bcrl@redhat.com>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pagecache lock ordering
Message-ID: <Pine.LNX.4.21.0201100007350.1080-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's two places, do_buffer_fdatasync and __find_lock_page_helper,
which violate the pagemap_lru_lock before pagecache_lock rule,
if page_cache_release frees page calling lru_cache_del.

I was worried when I saw Ben's patch to move lru_cache_del down
into __free_pages_ok: thought it might cause a spinlock ordering
violation somewhere.  Source check showed up no new problem from
his patch, but these two already a problem (and still a problem
when Ben's patch goes in).

Hugh

--- 2.4.18-pre2/mm/filemap.c	Wed Jan  9 18:17:39 2002
+++ linux/mm/filemap.c	Wed Jan  9 19:11:17 2002
@@ -493,6 +493,7 @@
 {
 	struct list_head *curr;
 	struct page *page;
+	struct page *relpage = NULL;
 	int retval = 0;
 
 	spin_lock(&pagecache_lock);
@@ -509,6 +510,9 @@
 
 		page_cache_get(page);
 		spin_unlock(&pagecache_lock);
+		if (relpage)
+			page_cache_release(relpage);
+		relpage = page;
 		lock_page(page);
 
 		/* The buffers could have been free'd while we waited for the page lock */
@@ -518,10 +522,11 @@
 		UnlockPage(page);
 		spin_lock(&pagecache_lock);
 		curr = page->list.next;
-		page_cache_release(page);
 	}
 	spin_unlock(&pagecache_lock);
 
+	if (relpage)
+		page_cache_release(relpage);
 	return retval;
 }
 
@@ -900,14 +905,15 @@
 		if (TryLockPage(page)) {
 			spin_unlock(&pagecache_lock);
 			lock_page(page);
-			spin_lock(&pagecache_lock);
 
 			/* Has the page been re-allocated while we slept? */
 			if (page->mapping != mapping || page->index != offset) {
 				UnlockPage(page);
 				page_cache_release(page);
+				spin_lock(&pagecache_lock);
 				goto repeat;
 			}
+			spin_lock(&pagecache_lock);
 		}
 	}
 	return page;

