Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318915AbSG1HUm>; Sun, 28 Jul 2002 03:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318917AbSG1HUm>; Sun, 28 Jul 2002 03:20:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50693 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318915AbSG1HUl>;
	Sun, 28 Jul 2002 03:20:41 -0400
Message-ID: <3D439E09.3348E8D6@zip.com.au>
Date: Sun, 28 Jul 2002 00:32:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 1/13] misc fixes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There are a few VM-related patches in this series.  Mainly fixes;
feature work is on hold.

We have some fairly serious locking contention problems with the reverse
mapping's pte_chains.  Until we have a clear way out of that I believe
that it is best to not merge code which has a lot of rmap dependency.

It is apparent that these problems will not be solved by tweaking -
some redesign is needed.  In the 2.5 timeframe the only practical
solution appears to be page table sharing, based on Daniel's February
work.  Daniel and Dave McCracken are working that.


Some bits and pieces here:


- list_splice() has an open-coded list_empty() in it.  Use
  list_empty() instead.

- in shrink_cache() we have a local `nr_pages' which shadows another
  local.  Rename the inner one.  (Nikita Danilov)

- Add a BUG() on a can't-happen code path in page_remove_rmap().

- Tighten up the bug checks in the BH completion handlers - if the
  buffer is still under IO then it must be locked, because we unlock it
  inside the page_uptodate_lock.




 fs/buffer.c          |   10 ++++------
 include/linux/list.h |    4 +---
 mm/rmap.c            |    2 ++
 mm/vmscan.c          |    6 +++---
 4 files changed, 10 insertions(+), 12 deletions(-)

--- 2.5.29/include/linux/list.h~misc	Sat Jul 27 23:38:12 2002
+++ 2.5.29-akpm/include/linux/list.h	Sat Jul 27 23:38:12 2002
@@ -156,9 +156,7 @@ static inline void __list_splice(list_t 
  */
 static inline void list_splice(list_t *list, list_t *head)
 {
-	list_t *first = list->next;
-
-	if (first != list)
+	if (!list_empty(list))
 		__list_splice(list, head);
 }
 
--- 2.5.29/mm/vmscan.c~misc	Sat Jul 27 23:38:12 2002
+++ 2.5.29-akpm/mm/vmscan.c	Sat Jul 27 23:49:01 2002
@@ -200,8 +200,8 @@ shrink_cache(int nr_pages, zone_t *class
 			 * so the direct writes to the page cannot get lost.
 			 */
 			int (*writeback)(struct page *, int *);
-			const int nr_pages = SWAP_CLUSTER_MAX;
-			int nr_to_write = nr_pages;
+			const int cluster_size = SWAP_CLUSTER_MAX;
+			int nr_to_write = cluster_size;
 
 			writeback = mapping->a_ops->vm_writeback;
 			if (writeback == NULL)
@@ -209,7 +209,7 @@ shrink_cache(int nr_pages, zone_t *class
 			page_cache_get(page);
 			spin_unlock(&pagemap_lru_lock);
 			(*writeback)(page, &nr_to_write);
-			max_scan -= (nr_pages - nr_to_write);
+			max_scan -= (cluster_size - nr_to_write);
 			page_cache_release(page);
 			spin_lock(&pagemap_lru_lock);
 			continue;
--- 2.5.29/mm/rmap.c~misc	Sat Jul 27 23:38:12 2002
+++ 2.5.29-akpm/mm/rmap.c	Sat Jul 27 23:49:03 2002
@@ -205,6 +205,8 @@ void page_remove_rmap(struct page * page
 	}
 	printk("\n");
 	printk(KERN_ERR "page_remove_rmap: driver cleared PG_reserved ?\n");
+#else
+	BUG();
 #endif
 
 out:
--- 2.5.29/fs/buffer.c~misc	Sat Jul 27 23:38:16 2002
+++ 2.5.29-akpm/fs/buffer.c	Sat Jul 27 23:38:25 2002
@@ -514,9 +514,8 @@ static void end_buffer_async_read(struct
 		if (!buffer_uptodate(tmp))
 			page_uptodate = 0;
 		if (buffer_async_read(tmp)) {
-			if (buffer_locked(tmp))
-				goto still_busy;
-			BUG();
+			BUG_ON(!buffer_locked(tmp));
+			goto still_busy;
 		}
 		tmp = tmp->b_this_page;
 	} while (tmp != bh);
@@ -564,9 +563,8 @@ static void end_buffer_async_write(struc
 	tmp = bh->b_this_page;
 	while (tmp != bh) {
 		if (buffer_async_write(tmp)) {
-			if (buffer_locked(tmp))
-				goto still_busy;
-			BUG();
+			BUG_ON(!buffer_locked(tmp));
+			goto still_busy;
 		}
 		tmp = tmp->b_this_page;
 	}

.
