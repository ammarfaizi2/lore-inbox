Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318221AbSHKH0j>; Sun, 11 Aug 2002 03:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318211AbSHKH02>; Sun, 11 Aug 2002 03:26:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36102 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318035AbSHKHZd>;
	Sun, 11 Aug 2002 03:25:33 -0400
Message-ID: <3D5614A0.ECA8FD88@zip.com.au>
Date: Sun, 11 Aug 2002 00:39:12 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 10/21] batched removal of pages from the LRU
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Convert all the bulk callers of lru_cache_del() to use the batched
pagevec_lru_del() function.

Change truncate_complete_page() to not delete the page from the LRU. 
Do it in page_cache_release() instead.  (This reintroduces the problem
with final-release-from-interrupt.  THat gets fixed further on).

This patch changes the truncate locking somewhat.  The removal from the
LRU now happens _after_ the page has been removed from the
address_space and has been unlocked.  So there is now a window where
the shrink_cache code can discover the to-be-freed page via the LRU
list.  But that's OK - the page is clean, its buffers (if any) are
clean.  It's not attached to any mapping.




 filemap.c |   79 +++++++++++++++++++++++++++++++++-----------------------------
 swap.c    |    2 -
 2 files changed, 44 insertions(+), 37 deletions(-)

--- 2.5.31/mm/filemap.c~batched-lru-del	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/filemap.c	Sun Aug 11 00:21:02 2002
@@ -118,10 +118,10 @@ void invalidate_inode_pages(struct inode
 	struct list_head *head, *curr;
 	struct page * page;
 	struct address_space *mapping = inode->i_mapping;
+	struct pagevec lru_pvec;
 
 	head = &mapping->clean_pages;
-
-	spin_lock(&pagemap_lru_lock);
+	pagevec_init(&lru_pvec);
 	write_lock(&mapping->page_lock);
 	curr = head->next;
 
@@ -143,10 +143,10 @@ void invalidate_inode_pages(struct inode
 		if (page_count(page) != 1)
 			goto unlock;
 
-		__lru_cache_del(page);
 		__remove_from_page_cache(page);
 		unlock_page(page);
-		page_cache_release(page);
+		if (!pagevec_add(&lru_pvec, page))
+			__pagevec_lru_del(&lru_pvec);
 		continue;
 unlock:
 		unlock_page(page);
@@ -154,7 +154,7 @@ unlock:
 	}
 
 	write_unlock(&mapping->page_lock);
-	spin_unlock(&pagemap_lru_lock);
+	pagevec_lru_del(&lru_pvec);
 }
 
 static int do_invalidatepage(struct page *page, unsigned long offset)
@@ -174,16 +174,14 @@ static inline void truncate_partial_page
 }
 
 /*
- * If truncate can remove the fs-private metadata from the page, it
- * removes the page from the LRU immediately.  This because some other thread
- * of control (eg, sendfile) may have a reference to the page.  But dropping
- * the final reference to an LRU page in interrupt context is illegal - it may
- * deadlock over pagemap_lru_lock.
+ * If truncate cannot remove the fs-private metadata from the page, the page
+ * becomes anonymous.  It will be left on the LRU and may even be mapped into
+ * user pagetables if we're racing with filemap_nopage().
  */
 static void truncate_complete_page(struct page *page)
 {
-	if (!PagePrivate(page) || do_invalidatepage(page, 0))
-		lru_cache_del(page);
+	if (PagePrivate(page))
+		do_invalidatepage(page, 0);
 
 	ClearPageDirty(page);
 	ClearPageUptodate(page);
@@ -204,8 +202,10 @@ static int truncate_list_pages(struct ad
 	struct list_head *curr;
 	struct page * page;
 	int unlocked = 0;
+	struct pagevec release_pvec;
 
- restart:
+	pagevec_init(&release_pvec);
+restart:
 	curr = head->next;
 	while (curr != head) {
 		unsigned long offset;
@@ -225,18 +225,17 @@ static int truncate_list_pages(struct ad
 				list_add_tail(head, curr);
 				write_unlock(&mapping->page_lock);
 				wait_on_page_writeback(page);
-				page_cache_release(page);
+				if (!pagevec_add(&release_pvec, page))
+					__pagevec_release(&release_pvec);
 				unlocked = 1;
 				write_lock(&mapping->page_lock);
 				goto restart;
 			}
 
 			list_del(head);
-			if (!failed)
-				/* Restart after this page */
+			if (!failed)		/* Restart after this page */
 				list_add(head, curr);
-			else
-				/* Restart on this page */
+			else			/* Restart on this page */
 				list_add_tail(head, curr);
 
 			write_unlock(&mapping->page_lock);
@@ -246,25 +245,27 @@ static int truncate_list_pages(struct ad
 				if (*partial && (offset + 1) == start) {
 					truncate_partial_page(page, *partial);
 					*partial = 0;
-				} else 
+				} else {
 					truncate_complete_page(page);
-
+				}
 				unlock_page(page);
-			} else
+			} else {
  				wait_on_page_locked(page);
-
-			page_cache_release(page);
-
-			if (need_resched()) {
-				__set_current_state(TASK_RUNNING);
-				schedule();
 			}
-
+			if (!pagevec_add(&release_pvec, page))
+				__pagevec_release(&release_pvec);
+			cond_resched();
 			write_lock(&mapping->page_lock);
 			goto restart;
 		}
 		curr = curr->next;
 	}
+	if (pagevec_count(&release_pvec)) {
+		write_unlock(&mapping->page_lock);
+		pagevec_release(&release_pvec);
+		write_lock(&mapping->page_lock);
+		unlocked = 1;
+	}
 	return unlocked;
 }
 
@@ -362,8 +363,10 @@ static int invalidate_list_pages2(struct
 	struct list_head *curr;
 	struct page * page;
 	int unlocked = 0;
+	struct pagevec release_pvec;
 
- restart:
+	pagevec_init(&release_pvec);
+restart:
 	curr = head->prev;
 	while (curr != head) {
 		page = list_entry(curr, struct page, list);
@@ -380,7 +383,8 @@ static int invalidate_list_pages2(struct
 				goto restart;
 			}
 
-			__unlocked = invalidate_this_page2(mapping, page, curr, head);
+			__unlocked = invalidate_this_page2(mapping,
+						page, curr, head);
 			unlock_page(page);
 			unlocked |= __unlocked;
 			if (!__unlocked) {
@@ -398,15 +402,18 @@ static int invalidate_list_pages2(struct
 			wait_on_page_locked(page);
 		}
 
-		page_cache_release(page);
-		if (need_resched()) {
-			__set_current_state(TASK_RUNNING);
-			schedule();
-		}
-
+		if (!pagevec_add(&release_pvec, page))
+			__pagevec_release(&release_pvec);
+		cond_resched();
 		write_lock(&mapping->page_lock);
 		goto restart;
 	}
+	if (pagevec_count(&release_pvec)) {
+		write_unlock(&mapping->page_lock);
+		pagevec_release(&release_pvec);
+		write_lock(&mapping->page_lock);
+		unlocked = 1;
+	}
 	return unlocked;
 }
 
--- 2.5.31/mm/swap.c~batched-lru-del	Sun Aug 11 00:20:33 2002
+++ 2.5.31-akpm/mm/swap.c	Sun Aug 11 00:21:02 2002
@@ -115,7 +115,7 @@ void __pagevec_release(struct pagevec *p
 		if (!put_page_testzero(page))
 			continue;
 
-		if (!lock_held && PageLRU(page)) {
+		if (!lock_held) {
 			spin_lock(&pagemap_lru_lock);
 			lock_held = 1;
 		}

.
