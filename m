Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318014AbSHZJG0>; Mon, 26 Aug 2002 05:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318020AbSHZJG0>; Mon, 26 Aug 2002 05:06:26 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:15840 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S318014AbSHZJGW>; Mon, 26 Aug 2002 05:06:22 -0400
Message-ID: <20020826091038.25100.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Mon, 26 Aug 2002 11:10:37 +0200
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MM patches against 2.5.31
References: <3D644C70.6D100EA5@zip.com.au> <20020822112806.28099.qmail@thales.mathematik.uni-ulm.de> <3D6989F7.9ED1948A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D6989F7.9ED1948A@zip.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2002 at 06:52:55PM -0700, Andrew Morton wrote:
> Christian Ehrhardt wrote:
> > 
> > On Wed, Aug 21, 2002 at 07:29:04PM -0700, Andrew Morton wrote:
> > >
> > > I've uploaded a rollup of pending fixes and feature work
> > > against 2.5.31 to
> > >
> > > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.31/2.5.31-mm1/
> > >
> > > The rolled up patch there is suitable for ongoing testing and
> > > development.  The individual patches are in the broken-out/
> > > directory and should all be documented.
> > 
> > Sorry, but we still have the page release race in multiple places.
> > Look at the following (page starts with page_count == 1):
> > 
> 
> So we do.  It's a hugely improbable race, so there's no huge rush
> to fix it.

Actually the race seems to happen in real life (it does explain the
the pte.chain != NULL BUG) and it is not that improbable with preempt.

> Looks like the same race is present in -ac kernels,
> actually, if add_to_swap() fails.  Also perhaps 2.4 is exposed if
> swap_writepage() is synchronous, and page reclaim races with 
> zap_page_range.  ho-hum.

I didn't check each kernel, but I agree that most of the recent kernels
have the potential for this race. Your tree just happend to be the
one where I found it first.

> What I'm inclined to do there is to change __page_cache_release()
> to not attempt to free the page at all.  Just let it sit on the
> LRU until page reclaim encounters it.  With the anon-free-via-pagevec
> patch, very, very, very few pages actually get their final release in
> __page_cache_release() - zero on uniprocessor, I expect.

It's not just a Problem with __page_cache_release, but yes it seems
to be a SMP only race.

> And change pagevec_release() to take the LRU lock before dropping
> the refcount on the pages.
> 
> That means there will need to be two flavours of pagevec_release():
> one which expects the pages to become freeable (and takes the LRU
> lock in anticipation of this).  And one which doesn't expect the
> pages to become freeable.  The latter will leave the occasional
> zero-count page on the LRU, as above.
> 
> Sound sane?

So the rules would be:
* if you bring the page count to zero call __free_pages_ok unless the
  page is on the lru.
* if someone (reclaim page) walking the lru finds a page with page count zero
  remove it from the lru and call __free_pages_ok.

This requires that ANYTHING that ends up calling put_page_testzero
must happen under the lru lock. This doesn't sound like a good idea
but it seems to be possible to do it race free.

I'd actually go for the following (patch in it compiles state but
otherwise untested below to illustrate what I'm talking about):

The basic idea is to move the logic into page_cache_get. The rules
would be:
1. if you bring the page count to zero (using put_page_testzero) it
   is your job to call __free_pages_ok eventually. Before doing so
   make sure that the page is no longer on the lru.
2. You may only call page_cache_get to duplicate an existing reference,
   i.e. page_cache_get could be made to BUG_ON(page_count(page) == 0).
3. If you got a pointer to a page without holding a reference (this
   is only allowd to happen if we found the pointer on an lru list)
   call page_cache_get_lru UNDER the lru lock and just leave the page
   alone if that would resurrect the page. page_cache_get_lru would
   basically look like this (implementation details below):

   int page_cache_get_lru (struct page * page) {
	if (!atomic_inc_and_test_for_one (&page->count))
		return 1;
	atomic_dec (&page->count);
	return 0;
   }

Proof of correctness:
A page is called dead if its page count reached zero before (no matter
what the page count currently is). Once a page is dead there can be
at most two pointers to the page: One held by the lru and the other
one held by the thread freeing the page. Any thread accessing the page
via the lru list will first call page_cache_get_lru under the lru lock,
the thread freeing the page will not read the page count anymore.
As page_cache_get_lru will not resurrect the page there will never
be a page count != 0 visible outside the lru lock on a dead page.
This meas that each thread trying to access the dead page via the lru
list will detect that the page is dead and leave it alone. It follows
that each page is freed at most once.
Suppose a page could be leaked under these rules. This would require
someone calling __put_page (or atomic_dec (&page->count)) to bring the
page count to zero on a not already dead page. However, the only place
where this happens is in page_cache_get_lru and it only happens if the
page is already dead.

Now let's look at the ugly part: implementation.
The basic problem is that we don't habe an atomic_inc_and_test_for_one
function and it is unlikely that we'll get one on all architectures. The
solution (and this is the ugly part) is a change in the semantics of
page->count. The value -1 now means no reference, 0 means one reference etc.

This way we can define
put_page_testzero    as   atomic_add_negative (-1, &page->count);   and
get_page_testzero    as   atomic_inc_and_test (&page->count);

Here's the promised (untested) patch against bk7 to illustrate what
I'm talking about:

diff -ur linux-2.5.31-bk7/include/linux/mm.h linux-2.5.31-cae/include/linux/mm.h
--- linux-2.5.31-bk7/include/linux/mm.h	Sun Aug 25 18:30:38 2002
+++ linux-2.5.31-cae/include/linux/mm.h	Sun Aug 25 21:40:57 2002
@@ -184,6 +184,11 @@
 /*
  * Methods to modify the page usage count.
  *
+ * NOTE: Real page counts start at -1 for no reference. This is a hack
+ * to be able to implement get_page_testzero with the existing portable
+ * atomic functions. The value exposed via set_page_count and page_count
+ * is (1+page->count).
+ *
  * What counts for a page usage:
  * - cache mapping   (page->mapping)
  * - private data    (page->private)
@@ -192,12 +197,25 @@
  *
  * Also, many kernel routines increase the page count before a critical
  * routine so they can be sure the page doesn't go away from under them.
+ *
+ * A special Problem is the lru lists. Presence on one of these lists
+ * does not increase the page count. The FIRST thread that brings the
+ * page count back to zero is responsible to remove the page from the
+ * lru list and actually free it (__free_pages_ok). This means that we
+ * can only get a reference to a page that is on a lru list, if this
+ * page is not already dead, i.e. about to be removed from the lru list.
+ * To do this we call get_page_testzero which will increment the page
+ * count and return true if we just resurrected the page i.e. the real
+ * page->count is now zero indicating one user. In this case we drop
+ * the reference again using __put_page. Both calls must happen under
+ * the lru lock.
  */
 #define get_page(p)		atomic_inc(&(p)->count)
 #define __put_page(p)		atomic_dec(&(p)->count)
-#define put_page_testzero(p) 	atomic_dec_and_test(&(p)->count)
-#define page_count(p)		atomic_read(&(p)->count)
-#define set_page_count(p,v) 	atomic_set(&(p)->count, v)
+#define put_page_testzero(p) 	atomic_add_negative(-1, &(p)->count)
+#define page_count(p)		(1+atomic_read(&(p)->count))
+#define set_page_count(p,v) 	atomic_set(&(p)->count, v-1)
+#define get_page_testzero(p)	atomic_inc_and_test(&(p)->count)
 extern void FASTCALL(__page_cache_release(struct page *));
 #define put_page(p)							\
 	do {								\
diff -ur linux-2.5.31-bk7/include/linux/pagemap.h linux-2.5.31-cae/include/linux/pagemap.h
--- linux-2.5.31-bk7/include/linux/pagemap.h	Sun Aug 25 18:30:38 2002
+++ linux-2.5.31-cae/include/linux/pagemap.h	Sun Aug 25 21:56:30 2002
@@ -22,7 +22,43 @@
 #define PAGE_CACHE_MASK		PAGE_MASK
 #define PAGE_CACHE_ALIGN(addr)	(((addr)+PAGE_CACHE_SIZE-1)&PAGE_CACHE_MASK)
 
-#define page_cache_get(x)	get_page(x)
+/*
+ * Get a reference to the page. This function must not be called on
+ * a dead page, i.e. a page that has page count zero. If the page is
+ * still on a lru_list use page_cache_get_lru instead.
+ */
+static inline void page_cache_get (struct page * page)
+{
+	BUG_ON(page_count(page) == 0);
+	get_page(page);
+}
+
+/*
+ * Try to get a reference to page that we found on an lru list.
+ * The lru lists may contain pages with page count zero. We must
+ * not take a reference to such a page because it is already about
+ * to be freed (once it is of the lru lists). If we'd take a reference
+ * the page would eventually be freed twice.
+ * 
+ * The return value is true if we sucessfully incremented the page count.
+ * 
+ * This function must be called with the lru lock held. 
+ */
+static inline int page_cache_get_lru (struct page * page)
+{
+	/*
+	 * Yes there is a window where the page count is not zero
+	 * even though the page is dead. This is one of the reasons
+	 * why the caller must hold the lru lock. Due to the lru_lock
+	 * only the thread that is about to free the page can have
+	 * a reference to this page. This thread will not test the
+	 * page count anymore.
+	 */
+	if (!get_page_testzero (page))
+		return 1;
+	__put_page (page);
+	return 0;
+}
 
 static inline void page_cache_release(struct page *page)
 {
diff -ur linux-2.5.31-bk7/mm/swap.c linux-2.5.31-cae/mm/swap.c
--- linux-2.5.31-bk7/mm/swap.c	Sun Aug 25 18:30:38 2002
+++ linux-2.5.31-cae/mm/swap.c	Sun Aug 25 11:28:55 2002
@@ -77,7 +77,6 @@
 void __page_cache_release(struct page *page)
 {
 	unsigned long flags;
-	BUG_ON(page_count(page) != 0);
 
 	spin_lock_irqsave(&_pagemap_lru_lock, flags);
 	if (TestClearPageLRU(page)) {
@@ -86,11 +85,8 @@
 		else
 			del_page_from_inactive_list(page);
 	}
-	if (page_count(page) != 0)
-		page = NULL;
 	spin_unlock_irqrestore(&_pagemap_lru_lock, flags);
-	if (page)
-		__free_pages_ok(page, 0);
+	__free_pages_ok(page, 0);
 }
 
 /*
@@ -131,8 +127,7 @@
 			else
 				del_page_from_inactive_list(page);
 		}
-		if (page_count(page) == 0)
-			pagevec_add(&pages_to_free, page);
+		pagevec_add(&pages_to_free, page);
 	}
 	if (lock_held)
 		spin_unlock_irq(&_pagemap_lru_lock);
diff -ur linux-2.5.31-bk7/mm/vmscan.c linux-2.5.31-cae/mm/vmscan.c
--- linux-2.5.31-bk7/mm/vmscan.c	Sun Aug 25 18:30:38 2002
+++ linux-2.5.31-cae/mm/vmscan.c	Sun Aug 25 21:44:07 2002
@@ -92,6 +92,10 @@
 	return page_count(page) - !!PagePrivate(page) == 2;
 }
 
+/*
+ * The caller must hold a reference to each page in the list. We drop
+ * this reference if and only if we remove the page from the page_list.
+ */
 static /* inline */ int
 shrink_list(struct list_head *page_list, int nr_pages, zone_t *classzone,
 		unsigned int gfp_mask, int priority, int *max_scan)
@@ -295,24 +299,23 @@
 	spin_lock_irq(&_pagemap_lru_lock);
 	while (max_scan > 0 && nr_pages > 0) {
 		struct page *page;
+		struct list_head * curr;
 		int n = 0;
 
-		while (n < nr_to_process && !list_empty(&inactive_list)) {
-			page = list_entry(inactive_list.prev, struct page, lru);
+		curr = inactive_list.prev;
+		while (n < nr_to_process && (&inactive_list != curr)) {
+			page = list_entry(curr, struct page, lru);
 
-			prefetchw_prev_lru_page(page, &inactive_list, flags);
+			prefetchw_prev_lru_page(page, curr, flags);
+			curr = curr->prev;
 
+			/* Is the page already dead ? */
+			if (!page_cache_get_lru (page))
+				continue;
 			if (!TestClearPageLRU(page))
 				BUG();
 			list_del(&page->lru);
-			if (page_count(page) == 0) {
-				/* It is currently in pagevec_release() */
-				SetPageLRU(page);
-				list_add(&page->lru, &inactive_list);
-				continue;
-			}
 			list_add(&page->lru, &page_list);
-			page_cache_get(page);
 			n++;
 		}
 		spin_unlock_irq(&_pagemap_lru_lock);
@@ -381,15 +384,19 @@
 	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
 	struct page *page;
 	struct pagevec pvec;
+	struct list_head *curr;
 
 	lru_add_drain();
 	spin_lock_irq(&_pagemap_lru_lock);
-	while (nr_pages && !list_empty(&active_list)) {
-		page = list_entry(active_list.prev, struct page, lru);
-		prefetchw_prev_lru_page(page, &active_list, flags);
+	curr = active_list.prev;
+	while (nr_pages && (&active_list != curr)) {
+		page = list_entry(curr, struct page, lru);
+		prefetchw_prev_lru_page(page, curr, flags);
+		curr = curr->prev;
+		if (!page_cache_get_lru (page))
+			continue;
 		if (!TestClearPageLRU(page))
 			BUG();
-		page_cache_get(page);
 		list_move(&page->lru, &l_hold);
 		nr_pages--;
 	}

-- 
THAT'S ALL FOLKS!
