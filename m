Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311519AbSCTECI>; Tue, 19 Mar 2002 23:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311501AbSCTEAf>; Tue, 19 Mar 2002 23:00:35 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:41230 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311504AbSCTD7d>; Tue, 19 Mar 2002 22:59:33 -0500
Message-ID: <3C9808CB.14E1CAB5@zip.com.au>
Date: Tue, 19 Mar 2002 19:58:03 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: aa-100-local_pages
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Background:

  When a task wants to allocate a page (from a classzone), it calls
  into the page allocator, then into the page stealer and frees some
  pages.  The problem with this is that when that task returns to the
  page allocator it may find that other threads have whizzed in and
  stolen all the pages which were freed.

  So when the task frees up pages, they first are freed into a
  per-task free pages pool, so they are exclusively available to the
  task which did the page reclaimng.

Or that's how it *used* to work.

Andrea made one change to the local_pages code: add a check: when
adding reclaimed pages to the process's local pages list, we ensure
that we only retain pages which match the classzone which the caller is
trying to get pages from.

I ended up deciding that a lot of the local_pages code is not needed -
it releases many pages into the local list and then later releases all
of these except one back into the global pools.  It looks like
something which never got completely implemented.

So I ended up taking out a bunch of code.  We now just have a single
current->local_page, and a current->classzone which is used to
determine whether we should hang onto a particular page.

It's much simpler and works the same.  The only advantage I can see to
the list-based approach was that it batches work up, and will have
better I-cache behaviour.  But the amount of covered code is in fact
quite small.

The cache footprint of the shrink_cache loop is really huge, and it's
quite possible that it's thrashing on machines with a small L1.  A much
more effective way of addressing that would be to batch up the
->writepage and try_to_release_page() work, rather than the page
freeing.



=====================================

--- 2.4.19-pre3/include/linux/sched.h~aa-100-local_pages	Tue Mar 19 19:48:54 2002
+++ 2.4.19-pre3-akpm/include/linux/sched.h	Tue Mar 19 19:49:13 2002
@@ -280,6 +280,18 @@ struct user_struct {
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
 
+struct zone_struct;
+
+/*
+ * Used when a task if trying to free some pages for its own
+ * use - to prevent other tasks/CPUs from stealing the just-freed
+ * pages.
+ */
+struct local_page {
+	struct page *page;
+	struct zone_struct * classzone;
+};
+
 struct task_struct {
 	/*
 	 * offsets of these are hardcoded elsewhere - touch with care
@@ -325,8 +337,7 @@ struct task_struct {
 
 	struct task_struct *next_task, *prev_task;
 	struct mm_struct *active_mm;
-	struct list_head local_pages;
-	unsigned int allocation_order, nr_local_pages;
+	struct local_page local_page;
 
 /* task state */
 	struct linux_binfmt *binfmt;
--- 2.4.19-pre3/mm/page_alloc.c~aa-100-local_pages	Tue Mar 19 19:48:54 2002
+++ 2.4.19-pre3-akpm/mm/page_alloc.c	Tue Mar 19 19:49:14 2002
@@ -121,7 +121,7 @@ static void __free_pages_ok (struct page
 		BUG();
 	page->flags &= ~((1<<PG_referenced) | (1<<PG_dirty));
 
-	if (current->flags & PF_FREE_PAGES)
+	if (order == 0 && current->flags & PF_FREE_PAGES)
 		goto local_freelist;
  back_local_freelist:
 
@@ -174,14 +174,12 @@ static void __free_pages_ok (struct page
 	return;
 
  local_freelist:
-	if (current->nr_local_pages)
+	if ((current->local_page.page) ||
+	    !memclass(page_zone(page), current->local_page.classzone) ||
+	    in_interrupt())
 		goto back_local_freelist;
-	if (in_interrupt())
-		goto back_local_freelist;		
 
-	list_add(&page->list, &current->local_pages);
-	page->index = order;
-	current->nr_local_pages++;
+	current->local_page.page = page;
 }
 
 #define MARK_USED(index, order, area) \
@@ -268,70 +266,49 @@ static struct page * balance_classzone(z
 	struct page * page = NULL;
 	int __freed = 0;
 
-	if (!(gfp_mask & __GFP_WAIT))
-		goto out;
 	if (in_interrupt())
 		BUG();
 
-	current->allocation_order = order;
+	if (current->local_page.page)
+		BUG();
+	current->local_page.classzone = classzone;
 	current->flags |= PF_MEMALLOC | PF_FREE_PAGES;
 
 	__freed = try_to_free_pages(classzone, gfp_mask, order);
 
 	current->flags &= ~(PF_MEMALLOC | PF_FREE_PAGES);
 
-	if (current->nr_local_pages) {
-		struct list_head * entry, * local_pages;
-		struct page * tmp;
-		int nr_pages;
-
-		local_pages = &current->local_pages;
-
-		if (likely(__freed)) {
-			/* pick from the last inserted so we're lifo */
-			entry = local_pages->next;
-			do {
-				tmp = list_entry(entry, struct page, list);
-				if (tmp->index == order && memclass(page_zone(tmp), classzone)) {
-					list_del(entry);
-					current->nr_local_pages--;
-					set_page_count(tmp, 1);
-					page = tmp;
-
-					if (page->buffers)
-						BUG();
-					if (page->mapping)
-						BUG();
-					if (!VALID_PAGE(page))
-						BUG();
-					if (PageSwapCache(page))
-						BUG();
-					if (PageLocked(page))
-						BUG();
-					if (PageLRU(page))
-						BUG();
-					if (PageActive(page))
-						BUG();
-					if (PageDirty(page))
-						BUG();
-
-					break;
-				}
-			} while ((entry = entry->next) != local_pages);
+	if (current->local_page.page) {
+		page = current->local_page.page;
+		current->local_page.page = NULL;
+
+		if (order != 0) {
+			/* The local page won't suit */
+			__free_pages_ok(page, 0);
+			page = NULL;
+			goto out;
 		}
-
-		nr_pages = current->nr_local_pages;
-		/* free in reverse order so that the global order will be lifo */
-		while ((entry = local_pages->prev) != local_pages) {
-			list_del(entry);
-			tmp = list_entry(entry, struct page, list);
-			__free_pages_ok(tmp, tmp->index);
-			if (!nr_pages--)
-				BUG();
-		}
-		current->nr_local_pages = 0;
+		if (!memclass(page_zone(page), classzone))
+			BUG();
+		set_page_count(page, 1);
+		if (page->buffers)
+			BUG();
+		if (page->mapping)
+			BUG();
+		if (!VALID_PAGE(page))
+			BUG();
+		if (PageSwapCache(page))
+			BUG();
+		if (PageLocked(page))
+			BUG();
+		if (PageLRU(page))
+			BUG();
+		if (PageActive(page))
+			BUG();
+		if (PageDirty(page))
+			BUG();
 	}
- out:
+out:
 	*freed = __freed;
 	return page;
 }
--- 2.4.19-pre3/kernel/fork.c~aa-100-local_pages	Tue Mar 19 19:48:54 2002
+++ 2.4.19-pre3-akpm/kernel/fork.c	Tue Mar 19 19:48:54 2002
@@ -659,7 +659,7 @@ int do_fork(unsigned long clone_flags, u
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = jiffies;
 
-	INIT_LIST_HEAD(&p->local_pages);
+	p->local_page.page = NULL;
 
 	retval = -ENOMEM;
 	/* copy all the process information */

-
