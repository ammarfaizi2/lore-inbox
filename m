Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263032AbRFJBkJ>; Sat, 9 Jun 2001 21:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263033AbRFJBkA>; Sat, 9 Jun 2001 21:40:00 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:28070 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S263032AbRFJBju>; Sat, 9 Jun 2001 21:39:50 -0400
Message-ID: <3B22CDFA.2BC46385@uow.edu.au>
Date: Sun, 10 Jun 2001 11:31:38 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] truncate_inode_pages
In-Reply-To: <Pine.GSO.4.21.0106091331120.19361-100000@weyl.math.psu.edu>,
		<Pine.GSO.4.21.0106091331120.19361-100000@weyl.math.psu.edu> <01061000533601.03897@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> This is easy, just set the list head to the page about to be truncated.

Works for me.

--- linux-2.4.5/mm/filemap.c	Mon May 28 13:31:49 2001
+++ linux-akpm/mm/filemap.c	Sun Jun 10 11:29:19 2001
@@ -235,12 +235,13 @@
 
 		/* Is one of the pages to truncate? */
 		if ((offset >= start) || (*partial && (offset + 1) == start)) {
+			list_del(head);
+			list_add_tail(head, curr);
 			if (TryLockPage(page)) {
 				page_cache_get(page);
 				spin_unlock(&pagecache_lock);
 				wait_on_page(page);
-				page_cache_release(page);
-				return 1;
+				goto out_restart;
 			}
 			page_cache_get(page);
 			spin_unlock(&pagecache_lock);
@@ -252,11 +253,14 @@
 				truncate_complete_page(page);
 
 			UnlockPage(page);
-			page_cache_release(page);
-			return 1;
+			goto out_restart;
 		}
 	}
 	return 0;
+out_restart:
+	page_cache_release(page);
+	spin_lock(&pagecache_lock);
+	return 1;
 }
 
 
@@ -273,15 +277,18 @@
 {
 	unsigned long start = (lstart + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	unsigned partial = lstart & (PAGE_CACHE_SIZE - 1);
+	int complete;
 
-repeat:
 	spin_lock(&pagecache_lock);
-	if (truncate_list_pages(&mapping->clean_pages, start, &partial))
-		goto repeat;
-	if (truncate_list_pages(&mapping->dirty_pages, start, &partial))
-		goto repeat;
-	if (truncate_list_pages(&mapping->locked_pages, start, &partial))
-		goto repeat;
+	do {
+		complete = 1;
+		while (truncate_list_pages(&mapping->clean_pages, start, &partial))
+			complete = 0;
+		while (truncate_list_pages(&mapping->dirty_pages, start, &partial))
+			complete = 0;
+		while (truncate_list_pages(&mapping->locked_pages, start, &partial))
+			complete = 0;
+	} while (!complete);
 	spin_unlock(&pagecache_lock);
 }
