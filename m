Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286935AbSA2KbZ>; Tue, 29 Jan 2002 05:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289462AbSA2KbR>; Tue, 29 Jan 2002 05:31:17 -0500
Received: from ns.caldera.de ([212.34.180.1]:31408 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S286935AbSA2KbF>;
	Tue, 29 Jan 2002 05:31:05 -0500
Date: Tue, 29 Jan 2002 11:30:58 +0100
From: Christoph Hellwig <hch@caldera.de>
To: linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wli@holomorphy.com
Subject: [PATCH] hashed page waitqueues for 2.5
Message-ID: <20020129113058.A7423@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
	wli@holomorphy.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III's seems to be almost unnotices in the
mainline although it is merged in Rik's -rmap tree.

The below patch is based on his latest 2.4.17 patch + my wake_up_page
change from -rmap12.  It applies against 2.5.3-pre{5,6} (atleast).

I'd be happy if everyone could take a look at it.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.

diff -uNr -Xdontdiff ../master/linux-2.5.3-pre5/drivers/char/agp/agpgart_be.c linux/drivers/char/agp/agpgart_be.c
--- ../master/linux-2.5.3-pre5/drivers/char/agp/agpgart_be.c	Sat Dec 22 20:06:55 2001
+++ linux/drivers/char/agp/agpgart_be.c	Tue Jan 29 11:10:43 2002
@@ -820,7 +820,7 @@
 	page = virt_to_page(pt);
 	atomic_dec(&page->count);
 	clear_bit(PG_locked, &page->flags);
-	wake_up(&page->wait);
+	wake_up_page(page);
 	free_page((unsigned long) pt);
 	atomic_dec(&agp_bridge.current_memory_agp);
 }
@@ -2812,7 +2812,7 @@
 	page = virt_to_page(pt);
 	atomic_dec(&page->count);
 	clear_bit(PG_locked, &page->flags);
-	wake_up(&page->wait);
+	wake_up_page(page);
 	free_page((unsigned long) pt);
 	atomic_dec(&agp_bridge.current_memory_agp);
 }
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre5/drivers/char/drm/i810_dma.c linux/drivers/char/drm/i810_dma.c
--- ../master/linux-2.5.3-pre5/drivers/char/drm/i810_dma.c	Mon Jan 28 13:52:28 2002
+++ linux/drivers/char/drm/i810_dma.c	Tue Jan 29 11:09:47 2002
@@ -294,14 +294,14 @@
 
 static void i810_free_page(drm_device_t *dev, unsigned long page)
 {
-	if(page == 0UL)
-		return;
+	if (page) {
+		struct page *p = virt_to_page(page);
 
-	atomic_dec(&virt_to_page(page)->count);
-	clear_bit(PG_locked, &virt_to_page(page)->flags);
-	wake_up(&virt_to_page(page)->wait);
-	free_page(page);
-	return;
+		atomic_dec(&p->count);
+		clear_bit(PG_locked, &p->flags);
+		wake_up_page(p);
+		free_page(p);
+	}
 }
 
 static int i810_dma_cleanup(drm_device_t *dev)
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre5/fs/buffer.c linux/fs/buffer.c
--- ../master/linux-2.5.3-pre5/fs/buffer.c	Mon Jan 28 13:52:33 2002
+++ linux/fs/buffer.c	Tue Jan 29 11:06:39 2002
@@ -1966,7 +1966,7 @@
  *
  * The kiobuf must already be locked for IO.  IO is submitted
  * asynchronously: you need to check page->locked, page->uptodate, and
- * maybe wait on page->wait.
+ * maybe wait on page_waitqueue(page).
  *
  * It is up to the caller to make sure that there are enough blocks
  * passed in to completely map the iobufs to disk.
@@ -2024,7 +2024,7 @@
  * Start I/O on a page.
  * This function expects the page to be locked and may return
  * before I/O is complete. You then have to check page->locked,
- * page->uptodate, and maybe wait on page->wait.
+ * page->uptodate, and maybe wait on page_waitqueue(page).
  *
  * brw_page() is SMP-safe, although it's being called with the
  * kernel lock held - but the code is ready.
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre5/include/linux/mm.h linux/include/linux/mm.h
--- ../master/linux-2.5.3-pre5/include/linux/mm.h	Mon Jan 28 13:52:34 2002
+++ linux/include/linux/mm.h	Tue Jan 29 11:12:28 2002
@@ -156,7 +156,6 @@
 					   updated asynchronously */
 	struct list_head lru;		/* Pageout list, eg. active_list;
 					   protected by pagemap_lru_lock !! */
-	wait_queue_head_t wait;		/* Page locked?  Stand in line... */
 	struct page **pprev_hash;	/* Complement to *next_hash. */
 	struct buffer_head * buffers;	/* Buffer maps us to a disk block. */
 	void *virtual;			/* Kernel virtual address (NULL if
@@ -236,7 +235,7 @@
  * - private pages which have been modified may need to be swapped out
  *   to swap space and (later) to be read back into memory.
  * During disk I/O, PG_locked is used. This bit is set before I/O
- * and reset when I/O completes. page->wait is a wait queue of all
+ * and reset when I/O completes. page_waitqueue(page) is a wait queue of all
  * tasks waiting for the I/O on this page to complete.
  * PG_uptodate tells whether the page's contents is valid.
  * When a read completes, the page becomes uptodate, unless a disk I/O
@@ -337,6 +336,23 @@
 #define ClearPageReserved(page)		clear_bit(PG_reserved, &(page)->flags)
 
 /*
+ * Knuth recommends primes in approximately golden ratio to the maximum
+ * integer representable by a machine word for multiplicative hashing.
+ * Chuck Lever verified the effectiveness of this technique for several
+ * hash tables in his paper documenting the benchmark results:
+ * http://www.citi.umich.edu/techreports/reports/citi-tr-00-1.pdf
+ */
+#if BITS_PER_LONG == 32
+#define GOLDEN_RATIO_PRIME 2654435761UL
+
+#elif BITS_PER_LONG == 64
+#define GOLDEN_RATIO_PRIME 11400714819323198549UL
+
+#else
+#error Define GOLDEN_RATIO_PRIME in mm_inline.h for your wordsize.
+#endif
+
+/*
  * Error return values for the *_nopage functions
  */
 #define NOPAGE_SIGBUS	(NULL)
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre5/include/linux/mmzone.h linux/include/linux/mmzone.h
--- ../master/linux-2.5.3-pre5/include/linux/mmzone.h	Thu Nov 22 20:46:19 2001
+++ linux/include/linux/mmzone.h	Tue Jan 29 11:12:28 2002
@@ -7,6 +7,7 @@
 #include <linux/config.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/wait.h>
 
 /*
  * Free memory management - zoned buddy allocator.
@@ -48,6 +49,35 @@
 	free_area_t		free_area[MAX_ORDER];
 
 	/*
+	 * wait_table           -- the array holding the hash table
+	 * wait_table_size      -- the size of the hash table array
+	 * wait_table_shift     -- wait_table_size
+	 *                             == BITS_PER_LONG (1 << wait_table_bits)
+	 *
+	 * The purpose of all these is to keep track of the people
+	 * waiting for a page to become available and make them
+	 * runnable again when possible. The trouble is that this
+	 * consumes a lot of space, especially when so few things
+	 * wait on pages at a given time. So instead of using
+	 * per-page waitqueues, we use a waitqueue hash table.
+	 *
+	 * The bucket discipline is to sleep on the same queue when
+	 * colliding and wake all in that wait queue when removing.
+	 * When something wakes, it must check to be sure its page is
+	 * truly available, a la thundering herd. The cost of a
+	 * collision is great, but given the expected load of the
+	 * table, they should be so rare as to be outweighed by the
+	 * benefits from the saved space.
+	 *
+	 *__wait_on_page() and unlock_page() in mm/filemap.c, are the
+	 * primary users of these fields, and in mm/page_alloc.c
+	 * free_area_init_core() performs the initialization of them.
+	 */
+	wait_queue_head_t *wait_table;
+	unsigned long      wait_table_size;
+	unsigned long      wait_table_shift;
+
+	/*
 	 * Discontig memory support fields.
 	 */
 	struct pglist_data	*zone_pgdat;
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre5/include/linux/pagemap.h linux/include/linux/pagemap.h
--- ../master/linux-2.5.3-pre5/include/linux/pagemap.h	Thu Nov 22 20:46:44 2001
+++ linux/include/linux/pagemap.h	Tue Jan 29 11:12:35 2002
@@ -97,6 +97,8 @@
 		___wait_on_page(page);
 }
 
+extern void wake_up_page(struct page *);
+
 extern struct page * grab_cache_page (struct address_space *, unsigned long);
 extern struct page * grab_cache_page_nowait (struct address_space *, unsigned long);
 
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre5/kernel/ksyms.c linux/kernel/ksyms.c
--- ../master/linux-2.5.3-pre5/kernel/ksyms.c	Mon Jan 28 13:52:35 2002
+++ linux/kernel/ksyms.c	Tue Jan 29 11:09:48 2002
@@ -202,6 +202,7 @@
 EXPORT_SYMBOL(unlock_buffer);
 EXPORT_SYMBOL(__wait_on_buffer);
 EXPORT_SYMBOL(___wait_on_page);
+EXPORT_SYMBOL(wake_up_page);
 EXPORT_SYMBOL(generic_direct_IO);
 EXPORT_SYMBOL(block_write_full_page);
 EXPORT_SYMBOL(block_read_full_page);
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre5/mm/filemap.c linux/mm/filemap.c
--- ../master/linux-2.5.3-pre5/mm/filemap.c	Mon Jan 28 13:52:35 2002
+++ linux/mm/filemap.c	Tue Jan 29 11:19:07 2002
@@ -764,19 +764,59 @@
 	return 0;
 }
 
+/*
+ * In order to wait for pages to become available there must be
+ * waitqueues associated with pages. By using a hash table of
+ * waitqueues where the bucket discipline is to maintain all
+ * waiters on the same queue and wake all when any of the pages
+ * become available, and for the woken contexts to check to be
+ * sure the appropriate page became available, this saves space
+ * at a cost of "thundering herd" phenomena during rare hash
+ * collisions. This cost is great enough that effective hashing
+ * is necessary to maintain performance.
+ */
+static inline wait_queue_head_t *page_waitqueue(struct page *page)
+{
+	const zone_t *zone = page->zone;
+	wait_queue_head_t *wait = zone->wait_table;
+	unsigned long hash = (unsigned long)page;
+
+	hash *= GOLDEN_RATIO_PRIME;
+	hash >>= zone->wait_table_shift;
+
+	return &wait[hash];
+}
+
+
 /* 
  * Wait for a page to get unlocked.
  *
  * This must be called with the caller "holding" the page,
  * ie with increased "page->count" so that the page won't
  * go away during the wait..
+ *
+ * The waiting strategy is to get on a waitqueue determined
+ * by hashing. Waiters will then collide, and the newly woken
+ * task must then determine whether it was woken for the page
+ * it really wanted, and go back to sleep on the waitqueue if
+ * that wasn't it. With the waitqueue semantics, it never leaves
+ * the waitqueue unless it calls, so the loop moves forward one
+ * iteration every time there is
+ * (1) a collision 
+ * and
+ * (2) one of the colliding pages is woken
+ *
+ * This is the thundering herd problem, but it is expected to
+ * be very rare due to the few pages that are actually being
+ * waited on at any given time and the quality of the hash function.
  */
 void ___wait_on_page(struct page *page)
 {
 	struct task_struct *tsk = current;
+	wait_queue_head_t *waitqueue = page_waitqueue(page);
 	DECLARE_WAITQUEUE(wait, tsk);
 
-	add_wait_queue(&page->wait, &wait);
+	add_wait_queue(waitqueue, &wait);
 	do {
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (!PageLocked(page))
@@ -784,19 +824,34 @@
 		sync_page(page);
 		schedule();
 	} while (PageLocked(page));
-	tsk->state = TASK_RUNNING;
-	remove_wait_queue(&page->wait, &wait);
+	__set_task_state(tsk, TASK_RUNNING);
+	remove_wait_queue(waitqueue, &wait);
 }
 
+/*
+ * unlock_page() is the other half of the story just above
+ * __wait_on_page(). Here a couple of quick checks are done
+ * and a couple of flags are set on the page, and then all
+ * of the waiters for all of the pages in the appropriate
+ * wait queue are woken.
+ */
 void unlock_page(struct page *page)
 {
+	wait_queue_head_t *waitqueue = page_waitqueue(page);
 	clear_bit(PG_launder, &(page)->flags);
 	smp_mb__before_clear_bit();
 	if (!test_and_clear_bit(PG_locked, &(page)->flags))
 		BUG();
 	smp_mb__after_clear_bit(); 
-	if (waitqueue_active(&(page)->wait))
-	wake_up(&(page)->wait);
+
+	/*
+	 * Although the default semantics of wake_up() are
+	 * to wake all, here the specific function is used
+	 * to make it even more explicit that a number of
+	 * pages are being waited on here.
+	 */
+	if(waitqueue_active(waitqueue))
+		wake_up_all(waitqueue);
 }
 
 /*
@@ -808,7 +863,7 @@
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
 
-	add_wait_queue_exclusive(&page->wait, &wait);
+	add_wait_queue_exclusive(page_waitqueue(page), &wait);
 	for (;;) {
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (PageLocked(page)) {
@@ -818,10 +873,14 @@
 		if (!TryLockPage(page))
 			break;
 	}
-	tsk->state = TASK_RUNNING;
-	remove_wait_queue(&page->wait, &wait);
+	__set_task_state(tsk, TASK_RUNNING);
+	remove_wait_queue(page_waitqueue(page), &wait);
+}
+
+void wake_up_page(struct page *page)
+{
+	wake_up(page_waitqueue(page));
 }
-	
 
 /*
  * Get an exclusive lock on the page, optimistically
diff -uNr -Xdontdiff ../master/linux-2.5.3-pre5/mm/page_alloc.c linux/mm/page_alloc.c
--- ../master/linux-2.5.3-pre5/mm/page_alloc.c	Tue Jan 15 10:59:16 2002
+++ linux/mm/page_alloc.c	Tue Jan 29 11:06:39 2002
@@ -624,6 +624,44 @@
 	} 
 }
 
+/*
+ * Helper functions to size the waitqueue hash table.
+ * Essentially these want to choose hash table sizes sufficiently
+ * large so that collisions trying to wait on pages are rare.
+ * But in fact, the number of active page waitqueues on typical
+ * systems is ridiculously low, less than 200. So this is even
+ * conservative, even though it seems large.
+ *
+ * The constant PAGES_PER_WAITQUEUE specifies the ratio of pages to
+ * waitqueues, i.e. the size of the waitq table given the number of pages.
+ */
+
+#define PAGES_PER_WAITQUEUE		256
+
+static inline unsigned long wait_table_size(unsigned long pages)
+{
+	unsigned long size = 1;
+
+	pages /= PAGES_PER_WAITQUEUE;
+
+	while(size < pages)
+		size <<= 1;
+
+	return size;
+}
+
+
+/*
+ * This is an integer logarithm so that shifts can be used later
+ * to extract the more random high bits from the multiplicative
+ * hash function before the remainder is taken.
+ */
+static inline unsigned long wait_table_bits(unsigned long size)
+{
+	return ffz(~size);
+}
+
+
 #define LONG_ALIGN(x) (((x)+(sizeof(long))-1)&~((sizeof(long))-1))
 
 /*
@@ -687,7 +725,6 @@
 	for (p = lmem_map; p < lmem_map + totalpages; p++) {
 		set_page_count(p, 0);
 		SetPageReserved(p);
-		init_waitqueue_head(&p->wait);
 		memlist_init(&p->list);
 	}
 
@@ -708,9 +745,28 @@
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
 		zone->need_balance = 0;
+
 		if (!size)
 			continue;
 
+		/*
+		 * The per-page waitqueue mechanism requires hash tables
+		 * whose buckets are waitqueues. These hash tables are  
+		 * per-zone, and dynamically sized according to the size
+		 * of the zone so as to maintain a good ratio of waiters
+		 * to hash table buckets. Right here we just allocate
+		 * and initialize them for later use (in filemap.c)
+		 */
+		zone->wait_table_size = wait_table_size(size);
+		zone->wait_table_shift =
+			BITS_PER_LONG - wait_table_bits(zone->wait_table_size);
+		zone->wait_table = (wait_queue_head_t *)
+			alloc_bootmem_node(pgdat,
+				zone->wait_table_size
+					* sizeof(wait_queue_head_t));
+		for(i = 0; i < zone->wait_table_size; ++i)
+			init_waitqueue_head(zone->wait_table + i);
+
 		pgdat->nr_zones = j+1;
 
 		mask = (realsize / zone_balance_ratio[j]);
