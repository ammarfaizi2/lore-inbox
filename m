Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317946AbSHaT63>; Sat, 31 Aug 2002 15:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317980AbSHaT63>; Sat, 31 Aug 2002 15:58:29 -0400
Received: from dsl-213-023-043-117.arcor-ip.net ([213.23.43.117]:54249 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317946AbSHaT6V>;
	Sat, 31 Aug 2002 15:58:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Subject: Re: [RFC] [PATCH] Include LRU in page count
Date: Sat, 31 Aug 2002 21:47:29 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
References: <3D644C70.6D100EA5@zip.com.au> <E17kunE-0003IO-00@starship> <20020831161448.12564.qmail@thales.mathematik.uni-ulm.de>
In-Reply-To: <20020831161448.12564.qmail@thales.mathematik.uni-ulm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17lEDR-0004Qq-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 August 2002 18:14, Christian Ehrhardt wrote:
> On Sat, Aug 31, 2002 at 01:03:07AM +0200, Daniel Phillips wrote:
> > static inline void page_cache_release(struct page *page)
> > {
> > 	if (page_count(page) == 2 && spin_trylock(&pagemap_lru_lock)) {
> > 		if (PageLRU(page) && page_count(page) == 2)
> > 			__lru_cache_del(page);
> > 		spin_unlock(&pagemap_lru_lock);
> > 	}
> > 	put_page(page);
> > }
> 
> Just saw that this can still race e.g. with lru_cache_add (not
> hard to fix though):
> 
> | void lru_cache_add(struct page * page)
> | {
> |        if (!TestSetPageLRU(page)) {
> 
> Window is here: Once we set the PageLRU bit page_cache_release
> assumes that there is a reference held by the lru cache.
> 
> |                spin_lock(&pagemap_lru_lock);
> |                add_page_to_inactive_list(page);
> |#if LRU_PLUS_CACHE==2
> |                get_page(page);
> |#endif
> 
> But only starting at this point the reference actually exists.
> 
> |                spin_unlock(&pagemap_lru_lock);
> |        }
> |}
> 
> Solution: Change the PageLRU bit inside the lock. Looks like
> lru_cache_add is the only place that doesn't hold the lru lock to
> change the LRU flag and it's probably not a good idea even without
> the patch.

Thanks.  I sniffed at that very thing a little yesterday and decided that
lru_cache_add must always be called on a page that isn't on the lru.  It's
really hard to prove that though - just look at the acres of sewage in
filemap.c and the various creepy-crawly things that call put_dirty_page.

Coding it so the race isn't even possible is a much better idea.  In the
process of getting rid of the TestSet and TestClear bitops, I'd
inadvertently done that already, this way:

void lru_cache_add(struct page * page)
{
	spin_lock(&pagemap_lru_lock);
	BUG_ON(PageLRU(page));
	SetPageLRU(page);
	get_page(page);
	add_page_to_inactive_list(page);
	spin_unlock(&pagemap_lru_lock);
}

So at least we get an easy-to-understand BUG instead of a much harder
to find side effect.  That said, the assumption that a page is never
on the lru at the time of this call is too fragile at best and likely
wrong - see shmem_writepage->add_to_page_cache_locked.

So we want:

void lru_cache_add(struct page * page)
{
	spin_lock(&pagemap_lru_lock);
	if (likely(!PageLRU(page))) {
		add_page_to_inactive_list(page);
		SetPageLRU(page);
		get_page(page);
	}
	spin_unlock(&pagemap_lru_lock);
}

> Two more comments: I don't think it is a good idea to use
> put_page_nofree in __lru_cache_del. This is probably safe now but
> it adds an additional rule that lru_cache_del can't be called without
> holding a second reference to the page.

That was intentional.  We always do hold an additional reference where
this is used, and if that changes in the future the author better at
least take a look at the rules.  Another way of looking at it: since
all the code paths that use this rely on the page staying around for
further operations after the lru delete, it is a bug for sure if the
count goes to zero during the lru delete.

I'd call that one a documentation bug.

> Also there may be lru only pages on the active list, i.e. refill
> inactive should have this hunk as well:
> 
> > +#if LRU_PLUS_CACHE==2
> > +             BUG_ON(!page_count(page));
> > +             if (unlikely(page_count(page) == 1)) {
> > +                     mmstat(vmscan_free_page);
> > +                     BUG_ON(!TestClearPageLRU(page)); // side effect abuse!!
> > +                     put_page(page);
> > +                     continue;
> > +             }
> > +#endif

If we have orphans on the active list, we'd probably better just count
them and figure out what we're doing wrong to put them there in the first
place.  In time they will migrate to the inactive list and get cleaned
up.

Yesterday's patch had a pretty big performance bug: at the bottom of the
shrink_cache loop where a cache page is finally removed, I had:

	UnlockPage(page);
	page_cache_release(page);

but we hold the lru lock there, so the page always becomes an orphan, to
be picked up later.  The sensible thing to do is:

	__lru_cache_del(page);
	UnlockPage(page);
	put_page(page);

Besides that, I cleaned up yesterdays side-effecty BUG_ON, and removed the
TestSet/Clear to just Set/ClearPageLRU.  It's tempting to do a lot more,
but with some effort I resisted that.

Manfred suggested an approach to de-racing this race using
atomic_dec_and_lock, which needs to be compared to the current approach.
More on that later.

-- 
Daniel

--- 2.4.19.clean/fs/proc/proc_misc.c	Fri Aug  2 20:39:45 2002
+++ 2.4.19/fs/proc/proc_misc.c	Fri Aug 30 21:32:20 2002
@@ -539,6 +539,28 @@
 		entry->proc_fops = f;
 }
 
+struct mmstats mmstats;
+
+char *mmnames[] = {
+	"page_cache_release",
+	"page_cache_release_test_lru",
+	"page_cache_release_del_lru",
+	"shrink_cache_del_lru",
+	"put_page_testzero",
+	"lru_cache_del",
+	"truncate_lru_cache_del",
+	NULL,
+};
+
+static int read_mmstats(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	char **names = mmnames;
+	unsigned *stats = (unsigned *) &mmstats, len = 0;
+	for (; *names; *names++, *stats++) if (strlen(*names)) 
+		len += sprintf(page + len, "%s %u\n", *names, *stats);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
 void __init proc_misc_init(void)
 {
 	struct proc_dir_entry *entry;
@@ -546,6 +568,7 @@
 		char *name;
 		int (*read_proc)(char*,char**,off_t,int,int*,void*);
 	} *p, simple_ones[] = {
+		{"mmstats",     read_mmstats},
 		{"loadavg",     loadavg_read_proc},
 		{"uptime",	uptime_read_proc},
 		{"meminfo",	meminfo_read_proc},
--- 2.4.19.clean/include/linux/mm.h	Fri Aug  2 20:39:45 2002
+++ 2.4.19/include/linux/mm.h	Sat Aug 31 18:56:17 2002
@@ -35,6 +35,20 @@
  * mmap() functions).
  */
 
+extern struct mmstats {
+	unsigned release;
+	unsigned release_test_page;
+	unsigned release_free_page;
+	unsigned vmscan_free_page;
+	unsigned testzero;
+	unsigned lru_cache_del;
+	unsigned truncate_lru_cache_del;
+} mmstats;
+
+extern char *mmnames[];
+
+#define mmstat(field) mmstats.field++
+
 /*
  * This struct defines a memory VMM memory area. There is one of these
  * per VM-area/task.  A VM area is any part of the process virtual memory
@@ -180,6 +194,15 @@
 } mem_map_t;
 
 /*
+ * There is only one 'core' page-freeing function.
+ */
+extern void FASTCALL(__free_pages(struct page *page, unsigned int order));
+extern void FASTCALL(free_pages(unsigned long addr, unsigned int order));
+
+#define __free_page(page) __free_pages((page), 0)
+#define free_page(addr) free_pages((addr),0)
+
+/*
  * Methods to modify the page usage count.
  *
  * What counts for a page usage:
@@ -191,12 +214,34 @@
  * Also, many kernel routines increase the page count before a critical
  * routine so they can be sure the page doesn't go away from under them.
  */
-#define get_page(p)		atomic_inc(&(p)->count)
-#define put_page(p)		__free_page(p)
-#define put_page_testzero(p) 	atomic_dec_and_test(&(p)->count)
 #define page_count(p)		atomic_read(&(p)->count)
 #define set_page_count(p,v) 	atomic_set(&(p)->count, v)
 
+extern void FASTCALL(__free_pages(struct page *page, unsigned int order));
+
+static inline void get_page(struct page *page)
+{
+	atomic_inc(&page->count);
+}
+
+static inline void put_page_nofree(struct page *page)
+{
+	BUG_ON(!page_count(page));
+	atomic_dec(&page->count);
+}
+
+static inline int put_page_testzero(struct page *page)
+{
+	mmstat(testzero);
+	BUG_ON(!page_count(page));
+	return atomic_dec_and_test(&page->count);
+}
+
+static inline void put_page(struct page *page)
+{
+	__free_page(page);
+}
+
 /*
  * Various page->flags bits:
  *
@@ -394,6 +439,8 @@
 #define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
 
 #define PageLRU(page)		test_bit(PG_lru, &(page)->flags)
+#define SetPageLRU(page)	set_bit(PG_lru, &(page)->flags)
+#define ClearPageLRU(page)	clear_bit(PG_lru, &(page)->flags)
 #define TestSetPageLRU(page)	test_and_set_bit(PG_lru, &(page)->flags)
 #define TestClearPageLRU(page)	test_and_clear_bit(PG_lru, &(page)->flags)
 
@@ -451,15 +498,6 @@
  */
 #define get_free_page get_zeroed_page
 
-/*
- * There is only one 'core' page-freeing function.
- */
-extern void FASTCALL(__free_pages(struct page *page, unsigned int order));
-extern void FASTCALL(free_pages(unsigned long addr, unsigned int order));
-
-#define __free_page(page) __free_pages((page), 0)
-#define free_page(addr) free_pages((addr),0)
-
 extern void show_free_areas(void);
 extern void show_free_areas_node(pg_data_t *pgdat);
 
@@ -518,11 +556,6 @@
 
 extern struct address_space swapper_space;
 #define PageSwapCache(page) ((page)->mapping == &swapper_space)
-
-static inline int is_page_cache_freeable(struct page * page)
-{
-	return page_count(page) - !!page->buffers == 1;
-}
 
 extern int can_share_swap_page(struct page *);
 extern int remove_exclusive_swap_page(struct page *);
--- 2.4.19.clean/include/linux/pagemap.h	Mon Feb 25 14:38:13 2002
+++ 2.4.19/include/linux/pagemap.h	Sat Aug 31 18:58:43 2002
@@ -27,9 +27,38 @@
 #define PAGE_CACHE_SIZE		PAGE_SIZE
 #define PAGE_CACHE_MASK		PAGE_MASK
 #define PAGE_CACHE_ALIGN(addr)	(((addr)+PAGE_CACHE_SIZE-1)&PAGE_CACHE_MASK)
+#define LRU_PLUS_CACHE 2
+#define LRU_DEL_HEURISTIC
 
 #define page_cache_get(x)	get_page(x)
-#define page_cache_release(x)	__free_page(x)
+
+static inline void page_cache_release(struct page *page)
+{
+	mmstat(release);
+#if LRU_PLUS_CACHE==2
+#ifdef LRU_DEL_HEURISTIC
+	if (page_count(page) == 2 && spin_trylock(&pagemap_lru_lock)) {
+		mmstat(release_test_page);
+		if (PageLRU(page) && page_count(page) == 2) {
+			mmstat(release_free_page);
+			__lru_cache_del(page);
+		}
+		spin_unlock(&pagemap_lru_lock);
+	}
+#endif
+#endif
+	put_page(page);
+}
+
+static inline int has_buffers(struct page *page)
+{
+	return !!page->buffers;
+}
+
+static inline int is_page_cache_freeable(struct page *page)
+{
+	return page_count(page) - has_buffers(page) == LRU_PLUS_CACHE;
+}
 
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
--- 2.4.19.clean/include/linux/swap.h	Fri Aug  2 20:39:46 2002
+++ 2.4.19/include/linux/swap.h	Sat Aug 31 18:56:11 2002
@@ -168,17 +168,9 @@
  * List add/del helper macros. These must be called
  * with the pagemap_lru_lock held!
  */
-#define DEBUG_LRU_PAGE(page)			\
-do {						\
-	if (!PageLRU(page))			\
-		BUG();				\
-	if (PageActive(page))			\
-		BUG();				\
-} while (0)
-
 #define add_page_to_active_list(page)		\
 do {						\
-	DEBUG_LRU_PAGE(page);			\
+	BUG_ON(PageActive(page));		\
 	SetPageActive(page);			\
 	list_add(&(page)->lru, &active_list);	\
 	nr_active_pages++;			\
@@ -186,13 +178,13 @@
 
 #define add_page_to_inactive_list(page)		\
 do {						\
-	DEBUG_LRU_PAGE(page);			\
 	list_add(&(page)->lru, &inactive_list);	\
 	nr_inactive_pages++;			\
 } while (0)
 
 #define del_page_from_active_list(page)		\
 do {						\
+	BUG_ON(!PageActive(page));		\
 	list_del(&(page)->lru);			\
 	ClearPageActive(page);			\
 	nr_active_pages--;			\
--- 2.4.19.clean/mm/filemap.c	Fri Aug  2 20:39:46 2002
+++ 2.4.19/mm/filemap.c	Fri Aug 30 21:40:33 2002
@@ -198,10 +198,12 @@
 		if (page->buffers && !try_to_free_buffers(page, 0))
 			goto unlock;
 
-		if (page_count(page) != 1)
+		if (page_count(page) != LRU_PLUS_CACHE)
 			goto unlock;
 
+#if LRU_PLUS_CACHE==1
 		__lru_cache_del(page);
+#endif
 		__remove_inode_page(page);
 		UnlockPage(page);
 		page_cache_release(page);
@@ -234,8 +236,10 @@
 static void truncate_complete_page(struct page *page)
 {
 	/* Leave it on the LRU if it gets converted into anonymous buffers */
-	if (!page->buffers || do_flushpage(page, 0))
+	if (!page->buffers || do_flushpage(page, 0)) {
+		mmstat(truncate_lru_cache_del);
 		lru_cache_del(page);
+	}
 
 	/*
 	 * We remove the page from the page cache _after_ we have
@@ -345,7 +349,7 @@
 	 * The page is locked and we hold the pagecache_lock as well
 	 * so both page_count(page) and page->buffers stays constant here.
 	 */
-	if (page_count(page) == 1 + !!page->buffers) {
+	if (is_page_cache_freeable(page)) {
 		/* Restart after this page */
 		list_del(head);
 		list_add_tail(head, curr);
--- 2.4.19.clean/mm/page_alloc.c	Fri Aug  2 20:39:46 2002
+++ 2.4.19/mm/page_alloc.c	Fri Aug 30 21:55:03 2002
@@ -82,9 +82,12 @@
 	/* Yes, think what happens when other parts of the kernel take 
 	 * a reference to a page in order to pin it for io. -ben
 	 */
+#if LRU_PLUS_CACHE==2
+	BUG_ON(PageLRU(page));
+#else
 	if (PageLRU(page))
 		lru_cache_del(page);
-
+#endif
 	if (page->buffers)
 		BUG();
 	if (page->mapping)
--- 2.4.19.clean/mm/swap.c	Wed Nov  7 01:44:20 2001
+++ 2.4.19/mm/swap.c	Sat Aug 31 18:56:07 2002
@@ -57,11 +57,31 @@
  */
 void lru_cache_add(struct page * page)
 {
+#if LRU_PLUS_CACHE==2
+	spin_lock(&pagemap_lru_lock);
+	if (likely(!PageLRU(page))) {
+		add_page_to_inactive_list(page);
+		SetPageLRU(page);
+		get_page(page);
+	}
+	spin_unlock(&pagemap_lru_lock);
+#else
 	if (!TestSetPageLRU(page)) {
 		spin_lock(&pagemap_lru_lock);
 		add_page_to_inactive_list(page);
 		spin_unlock(&pagemap_lru_lock);
 	}
+#endif
+}
+
+static inline void del_page_from_lru_list(struct page *page)
+{
+	BUG_ON(!PageLRU(page));
+	if (PageActive(page))
+		del_page_from_active_list(page);
+	else
+		del_page_from_inactive_list(page);
+	mmstat(lru_cache_del);
 }
 
 /**
@@ -73,13 +93,14 @@
  */
 void __lru_cache_del(struct page * page)
 {
-	if (TestClearPageLRU(page)) {
-		if (PageActive(page)) {
-			del_page_from_active_list(page);
-		} else {
-			del_page_from_inactive_list(page);
-		}
-	}
+#if LRU_PLUS_CACHE==2
+	del_page_from_lru_list(page);
+	ClearPageLRU(page);
+	put_page_nofree(page);
+#else
+	if (TestClearPageLRU(page))
+		del_page_from_lru_list(page);
+#endif
 }
 
 /**
--- 2.4.19.clean/mm/swapfile.c	Fri Aug  2 20:39:46 2002
+++ 2.4.19/mm/swapfile.c	Fri Aug 30 21:32:20 2002
@@ -239,7 +239,7 @@
 		if (p->swap_map[SWP_OFFSET(entry)] == 1) {
 			/* Recheck the page count with the pagecache lock held.. */
 			spin_lock(&pagecache_lock);
-			if (page_count(page) - !!page->buffers == 2)
+			if (page_count(page) - has_buffers(page) == LRU_PLUS_CACHE + 1)
 				retval = 1;
 			spin_unlock(&pagecache_lock);
 		}
@@ -263,16 +263,16 @@
 	if (!PageLocked(page))
 		BUG();
 	switch (page_count(page)) {
-	case 3:
-		if (!page->buffers)
+	case LRU_PLUS_CACHE + 2:
+		if (!has_buffers(page))
 			break;
 		/* Fallthrough */
-	case 2:
+	case LRU_PLUS_CACHE + 1:
 		if (!PageSwapCache(page))
 			break;
 		retval = exclusive_swap_page(page);
 		break;
-	case 1:
+	case LRU_PLUS_CACHE:
 		if (PageReserved(page))
 			break;
 		retval = 1;
@@ -280,6 +280,11 @@
 	return retval;
 }
 
+static inline int only_cached(struct page *page)
+{
+	return page_count(page) - has_buffers(page) == LRU_PLUS_CACHE + 1;
+}
+
 /*
  * Work out if there are any other processes sharing this
  * swap cache page. Free it if you can. Return success.
@@ -294,7 +299,7 @@
 		BUG();
 	if (!PageSwapCache(page))
 		return 0;
-	if (page_count(page) - !!page->buffers != 2)	/* 2: us + cache */
+	if (!only_cached(page))
 		return 0;
 
 	entry.val = page->index;
@@ -307,7 +312,7 @@
 	if (p->swap_map[SWP_OFFSET(entry)] == 1) {
 		/* Recheck the page count with the pagecache lock held.. */
 		spin_lock(&pagecache_lock);
-		if (page_count(page) - !!page->buffers == 2) {
+		if (only_cached(page)) {
 			__delete_from_swap_cache(page);
 			SetPageDirty(page);
 			retval = 1;
@@ -343,7 +348,7 @@
 	if (page) {
 		page_cache_get(page);
 		/* Only cache user (+us), or swap space full? Free it! */
-		if (page_count(page) - !!page->buffers == 2 || vm_swap_full()) {
+		if (only_cached(page) || vm_swap_full()) {
 			delete_from_swap_cache(page);
 			SetPageDirty(page);
 		}
--- 2.4.19.clean/mm/vmscan.c	Fri Aug  2 20:39:46 2002
+++ 2.4.19/mm/vmscan.c	Sat Aug 31 19:15:20 2002
@@ -89,7 +89,7 @@
 		mm->rss--;
 		UnlockPage(page);
 		{
-			int freeable = page_count(page) - !!page->buffers <= 2;
+			int freeable = page_count(page) - has_buffers(page) <= LRU_PLUS_CACHE + 1;
 			page_cache_release(page);
 			return freeable;
 		}
@@ -356,20 +356,31 @@
 		BUG_ON(PageActive(page));
 
 		list_del(entry);
+#if LRU_PLUS_CACHE==2
+		BUG_ON(!page_count(page));
+		if (unlikely(page_count(page) == 1)) {
+			mmstat(vmscan_free_page);
+			BUG_ON(!PageLRU(page));
+			ClearPageLRU(page);
+			put_page(page);
+			continue;
+		}
+#endif
 		list_add(entry, &inactive_list);
 
+#if LRU_PLUS_CACHE==1
 		/*
 		 * Zero page counts can happen because we unlink the pages
 		 * _after_ decrementing the usage count..
 		 */
 		if (unlikely(!page_count(page)))
 			continue;
-
+#endif
 		if (!memclass(page_zone(page), classzone))
 			continue;
 
 		/* Racy check to avoid trylocking when not worthwhile */
-		if (!page->buffers && (page_count(page) != 1 || !page->mapping))
+		if (!page->buffers && (page_count(page) != LRU_PLUS_CACHE || !page->mapping))
 			goto page_mapped;
 
 		/*
@@ -434,9 +445,9 @@
 					 */
 					spin_lock(&pagemap_lru_lock);
 					UnlockPage(page);
+#if LRU_PLUS_CACHE==1
 					__lru_cache_del(page);
-
-					/* effectively free the page here */
+#endif
 					page_cache_release(page);
 
 					if (--nr_pages)
@@ -507,9 +518,7 @@
 
 		__lru_cache_del(page);
 		UnlockPage(page);
-
-		/* effectively free the page here */
-		page_cache_release(page);
+		put_page(page);
 
 		if (--nr_pages)
 			continue;
