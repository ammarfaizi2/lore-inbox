Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317488AbSGTUTC>; Sat, 20 Jul 2002 16:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317494AbSGTUTB>; Sat, 20 Jul 2002 16:19:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38644 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317488AbSGTUSr>; Sat, 20 Jul 2002 16:18:47 -0400
Subject: [PATCH] generalized spin_lock_bit
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@conectiva.com.br,
       wli@holomorphy.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Jul 2002 13:21:51 -0700
Message-Id: <1027196511.1555.767.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, 

The attached patch implements bit-sized spinlocks via the following
interfaces:

	static inline void spin_lock_bit(int nr, unsigned long * lock)
	static inline void spin_unlock_bit(int nr, unsigned long * lock)

This is to abstract the per-page bit-sized locking used in rmap and fold
those uses into a general interface.  Right now the VM code is using its
own interface.  This patch replaces those uses with the above interface.
The locks optimize away on UP (which they currently do not).  They are
preempt-safe.  Object code should remain the same for SMP while UP will
no longer have the unneeded locks.

Thanks to Christoph Hellwig for prodding to make it per-architecture,
Ben LaHaise for the loop optimization, and William Irwin for the
original bit locking.

Patch is against 2.5.27, please apply.

	Robert Love

diff -urN linux-2.5.27/include/asm-i386/spinlock.h linux/include/asm-i386/spinlock.h
--- linux-2.5.27/include/asm-i386/spinlock.h	Sat Jul 20 12:11:11 2002
+++ linux/include/asm-i386/spinlock.h	Sat Jul 20 12:41:45 2002
@@ -128,6 +128,30 @@
 		:"=m" (lock->lock) : : "memory");
 }
 
+/*
+ * Bit-sized spinlocks.  Introduced by the VM code to fit locks
+ * where no lock has gone before.
+ */
+static inline void _raw_spin_lock_bit(int nr, unsigned long * lock)
+{
+	/*
+	 * Assuming the lock is uncontended, this never enters
+	 * the body of the outer loop. If it is contended, then
+	 * within the inner loop a non-atomic test is used to
+	 * busywait with less bus contention for a good time to
+	 * attempt to acquire the lock bit.
+	 */
+	while (test_and_set_bit(nr, lock)) {
+		while (test_bit(nr, lock))
+			cpu_relax();
+	}
+}
+
+static inline void _raw_spin_unlock_bit(int nr, unsigned long * lock)
+{
+	clear_bit(nr, lock);
+}
+
 
 /*
  * Read-write spinlocks, allowing multiple readers
diff -urN linux-2.5.27/include/linux/page-flags.h linux/include/linux/page-flags.h
--- linux-2.5.27/include/linux/page-flags.h	Sat Jul 20 12:11:09 2002
+++ linux/include/linux/page-flags.h	Sat Jul 20 12:41:45 2002
@@ -229,31 +229,6 @@
 #define TestClearPageDirect(page)	test_and_clear_bit(PG_direct, &(page)->flags)
 
 /*
- * inlines for acquisition and release of PG_chainlock
- */
-static inline void pte_chain_lock(struct page *page)
-{
-	/*
-	 * Assuming the lock is uncontended, this never enters
-	 * the body of the outer loop. If it is contended, then
-	 * within the inner loop a non-atomic test is used to
-	 * busywait with less bus contention for a good time to
-	 * attempt to acquire the lock bit.
-	 */
-	preempt_disable();
-	while (test_and_set_bit(PG_chainlock, &page->flags)) {
-		while (test_bit(PG_chainlock, &page->flags))
-			cpu_relax();
-	}
-}
-
-static inline void pte_chain_unlock(struct page *page)
-{
-	clear_bit(PG_chainlock, &page->flags);
-	preempt_enable();
-}
-
-/*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
  * but it may again do so one day.
  */
diff -urN linux-2.5.27/include/linux/spinlock.h linux/include/linux/spinlock.h
--- linux-2.5.27/include/linux/spinlock.h	Sat Jul 20 12:11:19 2002
+++ linux/include/linux/spinlock.h	Sat Jul 20 12:41:45 2002
@@ -83,12 +83,15 @@
 # define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
 #endif
 
-#define spin_lock_init(lock)	do { (void)(lock); } while(0)
-#define _raw_spin_lock(lock)	(void)(lock) /* Not "unused variable". */
-#define spin_is_locked(lock)	((void)(lock), 0)
-#define _raw_spin_trylock(lock)	((void)(lock), 1)
-#define spin_unlock_wait(lock)	do { (void)(lock); } while(0)
-#define _raw_spin_unlock(lock)	do { (void)(lock); } while(0)
+#define spin_lock_init(lock)		do { (void)(lock); } while(0)
+#define _raw_spin_lock(lock)		(void)(lock) /* no "unused variable" */
+#define spin_is_locked(lock)		((void)(lock), 0)
+#define _raw_spin_trylock(lock)		((void)(lock), 1)
+#define spin_unlock_wait(lock)		do { (void)(lock); } while(0)
+#define _raw_spin_unlock(lock)		do { (void)(lock); } while(0)
+
+#define _raw_spin_lock_bit(nr, lock)	do { (void)(lock); } while(0)
+#define _raw_spin_unlock_bit(nr, lock)	do { (void)(lock); } while(0)
 
 /*
  * Read-write spinlocks, allowing multiple readers
@@ -177,11 +180,23 @@
 #define write_trylock(lock)	({preempt_disable();_raw_write_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})
 
+#define spin_lock_bit(nr, lock) \
+do { \
+	preempt_disable(); \
+	_raw_spin_lock_bit(nr, lock); \
+} while(0)
+
+#define spin_unlock_bit(nr, lock) \
+do { \
+	_raw_spin_unlock_bit(nr, lock); \
+	preempt_enable(); \
+} while(0)
+
 #else
 
 #define preempt_get_count()		(0)
 #define preempt_disable()		do { } while (0)
-#define preempt_enable_no_resched()	do {} while(0)
+#define preempt_enable_no_resched()	do { } while(0)
 #define preempt_enable()		do { } while (0)
 #define preempt_check_resched()		do { } while (0)
 
@@ -190,6 +205,9 @@
 #define spin_unlock(lock)		_raw_spin_unlock(lock)
 #define spin_unlock_no_resched(lock)	_raw_spin_unlock(lock)
 
+#define spin_lock_bit(lock, nr)		_raw_spin_lock_bit(nr, lock)
+#define spin_unlock_bit(lock, nr)	_raw_spin_unlock_bit(nr, lock)
+
 #define read_lock(lock)			_raw_read_lock(lock)
 #define read_unlock(lock)		_raw_read_unlock(lock)
 #define write_lock(lock)		_raw_write_lock(lock)
diff -urN linux-2.5.27/mm/rmap.c linux/mm/rmap.c
--- linux-2.5.27/mm/rmap.c	Sat Jul 20 12:12:20 2002
+++ linux/mm/rmap.c	Sat Jul 20 12:42:54 2002
@@ -61,7 +61,7 @@
  *
  * Quick test_and_clear_referenced for all mappings to a page,
  * returns the number of processes which referenced the page.
- * Caller needs to hold the pte_chain_lock.
+ * Caller needs to hold the PG_chainlock bit.
  */
 int page_referenced(struct page * page)
 {
@@ -110,7 +110,7 @@
 		return;
 
 #ifdef DEBUG_RMAP
-	pte_chain_lock(page);
+	spin_lock_bit(PG_chainlock, &page->flags);
 	{
 		struct pte_chain * pc;
 		if (PageDirect(page)) {
@@ -123,10 +123,10 @@
 			}
 		}
 	}
-	pte_chain_unlock(page);
+	spin_unlock_bit(PG_chainlock, &page->flags);
 #endif
 
-	pte_chain_lock(page);
+	spin_lock_bit(PG_chainlock, &page->flags);
 
 	if (PageDirect(page)) {
 		/* Convert a direct pointer into a pte_chain */
@@ -147,7 +147,7 @@
 		SetPageDirect(page);
 	}
 
-	pte_chain_unlock(page);
+	spin_unlock_bit(PG_chainlock, &page->flags);
 }
 
 /**
@@ -170,7 +170,7 @@
 	if (!pfn_valid(pfn) || PageReserved(page))
 		return;
 
-	pte_chain_lock(page);
+	spin_lock_bit(PG_chainlock, &page->flags);
 
 	if (PageDirect(page)) {
 		if (page->pte.direct == ptep) {
@@ -208,7 +208,7 @@
 #endif
 
 out:
-	pte_chain_unlock(page);
+	spin_unlock_bit(PG_chainlock, &page->flags);
 	return;
 			
 }
@@ -224,7 +224,7 @@
  * Locking:
  *	pagemap_lru_lock		page_launder()
  *	    page lock			page_launder(), trylock
- *		pte_chain_lock		page_launder()
+ *		PG_chainlock bit	page_launder()
  *		    mm->page_table_lock	try_to_unmap_one(), trylock
  */
 static int FASTCALL(try_to_unmap_one(struct page *, pte_t *));
@@ -386,7 +386,7 @@
  * This function unlinks pte_chain from the singly linked list it
  * may be on and adds the pte_chain to the free list. May also be
  * called for new pte_chain structures which aren't on any list yet.
- * Caller needs to hold the pte_chain_lock if the page is non-NULL.
+ * Caller needs to hold the PG_chainlock bit if the page is non-NULL.
  */
 static inline void pte_chain_free(struct pte_chain * pte_chain,
 		struct pte_chain * prev_pte_chain, struct page * page)
@@ -407,7 +407,7 @@
  *
  * Returns a pointer to a fresh pte_chain structure. Allocates new
  * pte_chain structures as required.
- * Caller needs to hold the page's pte_chain_lock.
+ * Caller needs to hold the page's PG_chainlock bit.
  */
 static inline struct pte_chain * pte_chain_alloc()
 {
diff -urN linux-2.5.27/mm/vmscan.c linux/mm/vmscan.c
--- linux-2.5.27/mm/vmscan.c	Sat Jul 20 12:11:08 2002
+++ linux/mm/vmscan.c	Sat Jul 20 12:43:33 2002
@@ -42,7 +42,7 @@
 	return page_count(page) - !!PagePrivate(page) == 1;
 }
 
-/* Must be called with page's pte_chain_lock held. */
+/* Must be called with page's PG_chainlock bit held. */
 static inline int page_mapping_inuse(struct page * page)
 {
 	struct address_space *mapping = page->mapping;
@@ -137,11 +137,11 @@
 		 * The page is in active use or really unfreeable. Move to
 		 * the active list.
 		 */
-		pte_chain_lock(page);
+		spin_lock_bit(PG_chainlock, &page->flags);
 		if (page_referenced(page) && page_mapping_inuse(page)) {
 			del_page_from_inactive_list(page);
 			add_page_to_active_list(page);
-			pte_chain_unlock(page);
+			spin_unlock_bit(PG_chainlock, &page->flags);
 			unlock_page(page);
 			KERNEL_STAT_INC(pgactivate);
 			continue;
@@ -155,7 +155,7 @@
 		 */
 		if (page->pte.chain && !page->mapping && !PagePrivate(page)) {
 			page_cache_get(page);
-			pte_chain_unlock(page);
+			spin_unlock_bit(PG_chainlock, &page->flags);
 			spin_unlock(&pagemap_lru_lock);
 			if (!add_to_swap(page)) {
 				activate_page(page);
@@ -166,7 +166,7 @@
 			}
 			page_cache_release(page);
 			spin_lock(&pagemap_lru_lock);
-			pte_chain_lock(page);
+			spin_lock_bit(PG_chainlock, &page->flags);
 		}
 
 		/*
@@ -179,14 +179,14 @@
 				case SWAP_FAIL:
 					goto page_active;
 				case SWAP_AGAIN:
-					pte_chain_unlock(page);
+					spin_unlock_bit(PG_chainlock, &page->flags);
 					unlock_page(page);
 					continue;
 				case SWAP_SUCCESS:
 					; /* try to free the page below */
 			}
 		}
-		pte_chain_unlock(page);
+		spin_unlock_bit(PG_chainlock, &page->flags);
 		mapping = page->mapping;
 
 		if (PageDirty(page) && is_page_cache_freeable(page) &&
@@ -316,7 +316,7 @@
 		 */
 		del_page_from_inactive_list(page);
 		add_page_to_active_list(page);
-		pte_chain_unlock(page);
+		spin_unlock_bit(PG_chainlock, &page->flags);
 		unlock_page(page);
 		KERNEL_STAT_INC(pgactivate);
 	}
@@ -345,16 +345,16 @@
 
 		KERNEL_STAT_INC(pgscan);
 
-		pte_chain_lock(page);
+		spin_lock_bit(PG_chainlock, &page->flags);
 		if (page->pte.chain && page_referenced(page)) {
 			list_del(&page->lru);
 			list_add(&page->lru, &active_list);
-			pte_chain_unlock(page);
+			spin_unlock_bit(PG_chainlock, &page->flags);
 			continue;
 		}
 		del_page_from_active_list(page);
 		add_page_to_inactive_list(page);
-		pte_chain_unlock(page);
+		spin_unlock_bit(PG_chainlock, &page->flags);
 		KERNEL_STAT_INC(pgdeactivate);
 	}
 	spin_unlock(&pagemap_lru_lock);

