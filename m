Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288701AbSADRmh>; Fri, 4 Jan 2002 12:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280984AbSADRlM>; Fri, 4 Jan 2002 12:41:12 -0500
Received: from holomorphy.com ([216.36.33.161]:31424 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S281450AbSADRlA>;
	Fri, 4 Jan 2002 12:41:00 -0500
Date: Fri, 4 Jan 2002 09:40:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: riel@surriel.com, mjc@kernel.org, bcrl@redhat.com
Subject: hashed waitqueues
Message-ID: <20020104094049.A10326@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, riel@surriel.com, mjc@kernel.org,
	bcrl@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a long-discussed space optimization for the VM system, with
what is expected to be a minor time tradeoff.

Typically very few waitqueues are in use at a given time. Maintaining
a field within per-page data structures is expensive, and uses 16 bytes
per page, or approximately 3MB of space on my 768MB home machine.
An alternative is to maintain a hash table of waitqueues so that there
is only one waitqueue for every N pages. The bucket discipline is to
put all waiters on the same queue and wake all, where the waiters go
back to sleep when woken for the wrong page. The hash table should be
sized so that the load is low enough to make collisions rare, and this
does not require much space due to the number of waitqueues typically
in use. The patch against rmap10b, tested on UP i386, follows.

mjc, riel, please apply.


Cheers,
Bill


diff --minimal -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Fri Jan  4 09:14:28 2002
+++ b/include/linux/mm.h	Fri Jan  4 09:14:28 2002
@@ -161,7 +161,6 @@
 	unsigned char age;		/* Page aging counter. */
 	unsigned char zone;		/* Memory zone the page belongs to. */
 	struct pte_chain * pte_chain;	/* Reverse pte mapping pointer. */
-	wait_queue_head_t wait;		/* Page locked?  Stand in line... */
 	struct page **pprev_hash;	/* Complement to *next_hash. */
 	struct buffer_head * buffers;	/* Buffer maps us to a disk block. */
 
diff --minimal -Nru a/include/linux/mm_inline.h b/include/linux/mm_inline.h
--- a/include/linux/mm_inline.h	Fri Jan  4 09:14:28 2002
+++ b/include/linux/mm_inline.h	Fri Jan  4 09:14:28 2002
@@ -4,6 +4,39 @@
 #include <linux/mm.h>
 
 /*
+ * Knuth recommends primes in approximately golden ratio to the maximum
+ * integer representable by a machine word for multiplicative hashing.
+ * Chuck Lever verified the effectiveness of this technique for several
+ * hash tables in his paper documenting the benchmark results:
+ * http://www.citi.umich.edu/techreports/reports/citi-tr-00-1.pdf
+ */
+#define GOLDEN_RATIO_PRIME 2654435761UL
+
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
+	const zone_t *zone = page_zone(page);
+	wait_queue_head_t *wait = zone->wait_table;
+	unsigned long hash = (unsigned long)page;
+
+	hash *= GOLDEN_RATIO_PRIME;
+	hash >>= BITS_PER_LONG - zone->wait_table_bits;
+	hash &= zone->wait_table_size - 1;
+
+	return &wait[hash];
+}
+
+/*
  * These inline functions tend to need bits and pieces of all the
  * other VM include files, meaning they cannot be defined inside
  * one of the other VM include files.
diff --minimal -Nru a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	Fri Jan  4 09:14:28 2002
+++ b/include/linux/mmzone.h	Fri Jan  4 09:14:28 2002
@@ -7,6 +7,7 @@
 #include <linux/config.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/wait.h>
 
 /*
  * Free memory management - zoned buddy allocator.
@@ -52,6 +53,35 @@
 	struct list_head	inactive_dirty_list;
 	struct list_head	inactive_clean_list;
 	free_area_t		free_area[MAX_ORDER];
+
+	/*
+	 * wait_table           -- the array holding the hash table
+	 * wait_table_size      -- the size of the hash table array
+	 * wait_table_bits      -- wait_table_size == (1 << wait_table_bits)
+	 *                         so it's the integer logarithm of the size
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
+	unsigned long      wait_table_bits;
 
 	/*
 	 * Discontig memory support fields.
diff --minimal -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Fri Jan  4 09:14:28 2002
+++ b/mm/filemap.c	Fri Jan  4 09:14:28 2002
@@ -782,13 +782,28 @@
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
 	DECLARE_WAITQUEUE(wait, tsk);
 
-	add_wait_queue(&page->wait, &wait);
+	add_wait_queue(page_waitqueue(page), &wait);
 	do {
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (!PageLocked(page))
@@ -796,10 +811,17 @@
 		sync_page(page);
 		schedule();
 	} while (PageLocked(page));
-	tsk->state = TASK_RUNNING;
-	remove_wait_queue(&page->wait, &wait);
+	__set_task_state(tsk, TASK_RUNNING);
+	remove_wait_queue(page_waitqueue(page), &wait);
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
 	clear_bit(PG_launder, &(page)->flags);
@@ -807,8 +829,18 @@
 	if (!test_and_clear_bit(PG_locked, &(page)->flags))
 		BUG();
 	smp_mb__after_clear_bit(); 
-	if (waitqueue_active(&(page)->wait))
-	wake_up(&(page)->wait);
+
+	if(!page_waitqueue(page))
+		BUG();
+
+	/*
+	 * Although the default semantics of wake_up() are
+	 * to wake all, here the specific function is used
+	 * to make it even more explicit that a number of
+	 * pages are being waited on here.
+	 */
+	if(waitqueue_active(page_waitqueue(page)))
+		wake_up_all(page_waitqueue(page));
 }
 
 /*
@@ -820,7 +852,7 @@
 	struct task_struct *tsk = current;
 	DECLARE_WAITQUEUE(wait, tsk);
 
-	add_wait_queue_exclusive(&page->wait, &wait);
+	add_wait_queue_exclusive(page_waitqueue(page), &wait);
 	for (;;) {
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (PageLocked(page)) {
@@ -830,8 +862,8 @@
 		if (!TryLockPage(page))
 			break;
 	}
-	tsk->state = TASK_RUNNING;
-	remove_wait_queue(&page->wait, &wait);
+	__set_task_state(tsk, TASK_RUNNING);
+	remove_wait_queue(page_waitqueue(page), &wait);
 }
 	
 
diff --minimal -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Fri Jan  4 09:14:28 2002
+++ b/mm/page_alloc.c	Fri Jan  4 09:14:28 2002
@@ -809,6 +809,44 @@
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
@@ -883,9 +921,28 @@
 		INIT_LIST_HEAD(&zone->active_list);
 		INIT_LIST_HEAD(&zone->inactive_dirty_list);
 		INIT_LIST_HEAD(&zone->inactive_clean_list);
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
+		zone->wait_table_bits = wait_table_bits(zone->wait_table_size);
+		zone->wait_table = (wait_queue_head_t *)
+			alloc_bootmem_node(pgdat,
+					zone->wait_table_size
+						* sizeof(wait_queue_head_t));
+
+		for(i = 0; i < zone->wait_table_size; ++i)
+			init_waitqueue_head(zone->wait_table + i);
+
 		pgdat->nr_zones = j+1;
 
 		mask = (realsize / zone_balance_ratio[j]);
@@ -926,7 +983,6 @@
 			set_page_zone(page, pgdat->node_id * MAX_NR_ZONES + j);
 			init_page_count(page);
 			__SetPageReserved(page);
-			init_waitqueue_head(&page->wait);
 			memlist_init(&page->list);
 			if (j != ZONE_HIGHMEM)
 				set_page_address(page, __va(zone_start_paddr));
