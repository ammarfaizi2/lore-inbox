Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271921AbRIQRe5>; Mon, 17 Sep 2001 13:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271936AbRIQRes>; Mon, 17 Sep 2001 13:34:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22288 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271921AbRIQRef>; Mon, 17 Sep 2001 13:34:35 -0400
Date: Mon, 17 Sep 2001 10:33:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <Pine.LNX.4.33L.0109170923190.2990-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0109171010280.8961-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Sep 2001, Rik van Riel wrote:
>
> >  - truly anonymous pages (ie before they've been added to the swap cache)
> >    are not necessarily going to behave as nicely as other pages. They
> >    magically appear after VM scanning as a "1st reference", and I have a
> >    reasonably good argument that says that they'll have been aged up and
> >    down roughly the same number of times, which makes this more-or-less
> >    correct. But it's still a theoretical argument, nothing more.
>
> This nicely points out the problem with page aging which Linux
> has always had. Pages which are referenced all the time by the
> processes using them STILL get aged down all the time.
>
> I suspect that the biggest impact the reverse mapping patch
> has right now seems to be caused by fixing this behaviour and
> just aging up a page when it is referenced and down when it is
> not.

Well, here's a 10-line patch to make the anonymous pages get on the LRU
queues, and thus get aged along with all the others.

NOTE NOTE NOTE! This is _literally_ a 15-minute hack, and I expect that
there are paths where I forget to remove the page from the LRU queue
(which should result in a nice big oops in __free_pages_ok()).

Also, I didn't look into shm handling - it _looks_ like shm will remove
the page from the LRU list and re-insert it, which will lose all list
information, of course.

But the point being that keeping anonymous pages on the LRU list shouldn't
be all that hard. Even if I missed something on this first try.

		Linus

------
diff -u --recursive --new-file penguin/linux/mm/filemap.c linux/mm/filemap.c
--- penguin/linux/mm/filemap.c	Mon Sep 17 09:22:57 2001
+++ linux/mm/filemap.c	Mon Sep 17 09:15:45 2001
@@ -489,7 +489,6 @@
 	page->index = index;
 	add_page_to_inode_queue(mapping, page);
 	add_page_to_hash_queue(page, page_hash(mapping, index));
-	lru_cache_add(page);
 	spin_unlock(&pagecache_lock);
 }

diff -u --recursive --new-file penguin/linux/mm/memory.c linux/mm/memory.c
--- penguin/linux/mm/memory.c	Mon Sep 17 09:23:55 2001
+++ linux/mm/memory.c	Mon Sep 17 10:15:57 2001
@@ -958,6 +958,7 @@
 		if (pte_young(pte))
 			mark_page_accessed(old_page);
 		break_cow(vma, new_page, address, page_table);
+		lru_cache_add(new_page);

 		/* Free the old page.. */
 		new_page = old_page;
@@ -1198,6 +1199,7 @@
 		mm->rss++;
 		flush_page_to_ram(page);
 		entry = pte_mkwrite(pte_mkdirty(mk_pte(page, vma->vm_page_prot)));
+		lru_cache_add(page);
 	}

 	set_pte(page_table, entry);
diff -u --recursive --new-file penguin/linux/mm/shmem.c linux/mm/shmem.c
--- penguin/linux/mm/shmem.c	Mon Sep 17 09:22:57 2001
+++ linux/mm/shmem.c	Mon Sep 17 09:17:12 2001
@@ -356,6 +356,7 @@
 		flags = page->flags & ~((1 << PG_uptodate) | (1 << PG_error) | (1 << PG_referenced) | (1 << PG_arch_1));
 		page->flags = flags | (1 << PG_dirty);
 		add_to_page_cache_locked(page, mapping, idx);
+		lru_cache_add(page);
 		info->swapped--;
 		spin_unlock (&info->lock);
 	} else {
diff -u --recursive --new-file penguin/linux/mm/swap.c linux/mm/swap.c
--- penguin/linux/mm/swap.c	Wed Aug  8 15:17:26 2001
+++ linux/mm/swap.c	Mon Sep 17 09:50:33 2001
@@ -153,8 +153,6 @@
 void lru_cache_add(struct page * page)
 {
 	spin_lock(&pagemap_lru_lock);
-	if (!PageLocked(page))
-		BUG();
 	add_page_to_inactive_dirty_list(page);
 	page->age = 0;
 	spin_unlock(&pagemap_lru_lock);
@@ -176,7 +174,7 @@
 	} else if (PageInactiveClean(page)) {
 		del_page_from_inactive_clean_list(page);
 	} else {
-		printk("VM: __lru_cache_del, found unknown page ?!\n");
+//		printk("VM: __lru_cache_del, found unknown page ?!\n");
 	}
 	DEBUG_ADD_PAGE
 }
@@ -187,8 +185,6 @@
  */
 void lru_cache_del(struct page * page)
 {
-	if (!PageLocked(page))
-		BUG();
 	spin_lock(&pagemap_lru_lock);
 	__lru_cache_del(page);
 	spin_unlock(&pagemap_lru_lock);
diff -u --recursive --new-file penguin/linux/mm/swap_state.c linux/mm/swap_state.c
--- penguin/linux/mm/swap_state.c	Mon Sep 17 09:22:57 2001
+++ linux/mm/swap_state.c	Mon Sep 17 09:42:20 2001
@@ -147,6 +147,10 @@
  */
 void free_page_and_swap_cache(struct page *page)
 {
+	if (page_count(page) == 1 && !page->mapping) {
+		lru_cache_del(page);
+	}
+
 	/*
 	 * If we are the only user, then try to free up the swap cache.
 	 *

