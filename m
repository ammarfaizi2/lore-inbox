Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317911AbSHKHnD>; Sun, 11 Aug 2002 03:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318232AbSHKH1F>; Sun, 11 Aug 2002 03:27:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31750 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317945AbSHKHZE>;
	Sun, 11 Aug 2002 03:25:04 -0400
Message-ID: <3D561482.AC248312@zip.com.au>
Date: Sun, 11 Aug 2002 00:38:42 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 5/21] pagevec infrastructure
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



This is the first patch in a series of eight which address
pagemap_lru_lock contention, and which simplify the VM locking
hierarchy.

Most testing has been done with all eight patches applied, so it would
be best not to cherrypick, please.

The workload which was optimised was: 4x500MHz PIII CPUs, mem=512m, six
disks, six filesystems, six processes each flat-out writing a large
file onto one of the disks.  ie: heavy page replacement load.

The frequency with which pagemap_lru_lock is taken is reduced by 90%.

Lockmeter claims that pagemap_lru_lock contention on the 4-way has been
reduced by 98%.  Total amount of system time lost to lock spinning went
from 2.5% to 0.85%.

Anton ran a similar test on 8-way PPC, the reduction in system time was
around 25%, and the reduction in time spent playing with
pagemap_lru_lock was 80%.

	http://samba.org/~anton/linux/2.5.30/standard/
versus
	http://samba.org/~anton/linux/2.5.30/akpm/

Throughput changes on uniprocessor are modest: a 1% speedup with this
workload due to shortened code paths and improved cache locality.

The patches do two main things:

1: In almost all places where the kernel was doing something with
   lots of pages one-at-a-time, convert the code to do the same thing
   sixteen-pages-at-a-time.  Take the lock once rather than sixteen
   times.  Take the lock for the minimum possible time.

2: Multithread the pagecache reclaim function: don't hold
   pagemap_lru_lock while reclaiming pagecache pages.  That function
   was massively expensive.

One fallout from this work is that we never take any other locks while
holding pagemap_lru_lock.  So this lock conceptually disappears from
the VM locking hierarchy.


So.  This is all basically a code tweak to improve kernel scalability. 
It does it by optimising the existing design, rather than by redesign. 
There is little conceptual change to how the VM works.

This is as far as I can tweak it.  It seems that the results are now
acceptable on SMP.  But things are still bad on NUMA.  It is expected
that the per-zone LRU and per-zone LRU lock patches will fix NUMA as
well, but that has yet to be tested.


This first patch introduces `struct pagevec', which is the basic unit
of batched work.  It is simply:

struct pagevec {
	unsigned nr;
	struct page *pages[16];
};

pagevecs are used in the following patches to get the VM away from
page-at-a-time operations.

This patch includes all the pagevec library functions which are used in
later patches.





 include/linux/pagevec.h |   76 ++++++++++++++++++++++
 mm/page_alloc.c         |    9 ++
 mm/swap.c               |  160 +++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 236 insertions(+), 9 deletions(-)

--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.5.31-akpm/include/linux/pagevec.h	Sun Aug 11 00:21:03 2002
@@ -0,0 +1,76 @@
+/*
+ * include/linux/pagevec.h
+ *
+ * In many places it is efficient to batch an operation up against multiple
+ * pages.  A pagevec is a multipage container which is used for that.
+ */
+
+#define PAGEVEC_SIZE	16
+
+struct page;
+
+struct pagevec {
+	unsigned nr;
+	struct page *pages[PAGEVEC_SIZE];
+};
+
+void __pagevec_release(struct pagevec *pvec);
+void __pagevec_release_nonlru(struct pagevec *pvec);
+void __pagevec_free(struct pagevec *pvec);
+void __pagevec_lru_add(struct pagevec *pvec);
+void __pagevec_lru_del(struct pagevec *pvec);
+void pagevec_deactivate_inactive(struct pagevec *pvec);
+
+static inline void pagevec_init(struct pagevec *pvec)
+{
+	pvec->nr = 0;
+}
+
+static inline unsigned pagevec_count(struct pagevec *pvec)
+{
+	return pvec->nr;
+}
+
+static inline unsigned pagevec_space(struct pagevec *pvec)
+{
+	return PAGEVEC_SIZE - pvec->nr;
+}
+
+/*
+ * Add a page to a pagevec.  Returns the number of slots still available.
+ */
+static inline unsigned pagevec_add(struct pagevec *pvec, struct page *page)
+{
+	pvec->pages[pvec->nr++] = page;
+	return pagevec_space(pvec);
+}
+
+static inline void pagevec_release(struct pagevec *pvec)
+{
+	if (pagevec_count(pvec))
+		__pagevec_release(pvec);
+}
+
+static inline void pagevec_release_nonlru(struct pagevec *pvec)
+{
+	if (pagevec_count(pvec))
+		__pagevec_release_nonlru(pvec);
+}
+
+static inline void pagevec_free(struct pagevec *pvec)
+{
+	if (pagevec_count(pvec))
+		__pagevec_free(pvec);
+}
+
+static inline void pagevec_lru_add(struct pagevec *pvec)
+{
+	if (pagevec_count(pvec))
+		__pagevec_lru_add(pvec);
+}
+
+static inline void pagevec_lru_del(struct pagevec *pvec)
+{
+	if (pagevec_count(pvec))
+		__pagevec_lru_del(pvec);
+}
--- 2.5.31/mm/swap.c~pagevec	Sun Aug 11 00:20:32 2002
+++ 2.5.31-akpm/mm/swap.c	Sun Aug 11 00:21:02 2002
@@ -17,11 +17,9 @@
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
 #include <linux/pagemap.h>
+#include <linux/pagevec.h>
 #include <linux/init.h>
-
-#include <asm/dma.h>
-#include <asm/uaccess.h> /* for copy_to/from_user */
-#include <asm/pgtable.h>
+#include <linux/prefetch.h>
 
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
@@ -38,6 +36,9 @@ static inline void activate_page_nolock(
 	}
 }
 
+/*
+ * FIXME: speed this up?
+ */
 void activate_page(struct page * page)
 {
 	spin_lock(&pagemap_lru_lock);
@@ -51,9 +52,10 @@ void activate_page(struct page * page)
  */
 void lru_cache_add(struct page * page)
 {
-	if (!TestSetPageLRU(page)) {
+	if (!PageLRU(page)) {
 		spin_lock(&pagemap_lru_lock);
-		add_page_to_inactive_list(page);
+		if (!TestSetPageLRU(page))
+			add_page_to_inactive_list(page);
 		spin_unlock(&pagemap_lru_lock);
 	}
 }
@@ -68,11 +70,10 @@ void lru_cache_add(struct page * page)
 void __lru_cache_del(struct page * page)
 {
 	if (TestClearPageLRU(page)) {
-		if (PageActive(page)) {
+		if (PageActive(page))
 			del_page_from_active_list(page);
-		} else {
+		else
 			del_page_from_inactive_list(page);
-		}
 	}
 }
 
@@ -88,6 +89,147 @@ void lru_cache_del(struct page * page)
 }
 
 /*
+ * Batched page_cache_release().  Decrement the reference count on all the
+ * pagevec's pages.  If it fell to zero then remove the page from the LRU and
+ * free it.
+ *
+ * Avoid taking pagemap_lru_lock if possible, but if it is taken, retain it
+ * for the remainder of the operation.
+ *
+ * The locking in this function is against shrink_cache(): we recheck the
+ * page count inside the lock to see whether shrink_cache grabbed the page
+ * via the LRU.  If it did, give up: shrink_cache will free it.
+ *
+ * This function reinitialises the caller's pagevec.
+ */
+void __pagevec_release(struct pagevec *pvec)
+{
+	int i;
+	int lock_held = 0;
+	struct pagevec pages_to_free;
+
+	pagevec_init(&pages_to_free);
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+
+		if (!put_page_testzero(page))
+			continue;
+
+		if (!lock_held && PageLRU(page)) {
+			spin_lock(&pagemap_lru_lock);
+			lock_held = 1;
+		}
+
+		if (TestClearPageLRU(page)) {
+			if (PageActive(page))
+				del_page_from_active_list(page);
+			else
+				del_page_from_inactive_list(page);
+		}
+		if (page_count(page) == 0)
+			pagevec_add(&pages_to_free, page);
+	}
+	if (lock_held)
+		spin_unlock(&pagemap_lru_lock);
+
+	pagevec_free(&pages_to_free);
+	pagevec_init(pvec);
+}
+
+/*
+ * pagevec_release() for pages which are known to not be on the LRU
+ *
+ * This function reinitialises the caller's pagevec.
+ */
+void __pagevec_release_nonlru(struct pagevec *pvec)
+{
+	int i;
+	struct pagevec pages_to_free;
+
+	pagevec_init(&pages_to_free);
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+
+		BUG_ON(PageLRU(page));
+		if (put_page_testzero(page))
+			pagevec_add(&pages_to_free, page);
+	}
+	pagevec_free(&pages_to_free);
+	pagevec_init(pvec);
+}
+
+/*
+ * Move all the inactive pages to the head of the inactive list
+ * and release them.  Reinitialises the caller's pagevec.
+ */
+void pagevec_deactivate_inactive(struct pagevec *pvec)
+{
+	int i;
+	int lock_held = 0;
+
+	if (pagevec_count(pvec) == 0)
+		return;
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+
+		if (!lock_held) {
+			if (PageActive(page) || !PageLRU(page))
+				continue;
+			spin_lock(&pagemap_lru_lock);
+			lock_held = 1;
+		}
+		if (!PageActive(page) && PageLRU(page))
+			list_move(&page->lru, &inactive_list);
+	}
+	if (lock_held)
+		spin_unlock(&pagemap_lru_lock);
+	__pagevec_release(pvec);
+}
+
+/*
+ * Add the passed pages to the inactive_list, then drop the caller's refcount
+ * on them.  Reinitialises the caller's pagevec.
+ */
+void __pagevec_lru_add(struct pagevec *pvec)
+{
+	int i;
+
+	spin_lock(&pagemap_lru_lock);
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+
+		if (TestSetPageLRU(page))
+			BUG();
+		add_page_to_inactive_list(page);
+	}
+	spin_unlock(&pagemap_lru_lock);
+	pagevec_release(pvec);
+}
+
+/*
+ * Remove the passed pages from the LRU, then drop the caller's refcount on
+ * them.  Reinitialises the caller's pagevec.
+ */
+void __pagevec_lru_del(struct pagevec *pvec)
+{
+	int i;
+
+	spin_lock(&pagemap_lru_lock);
+	for (i = 0; i < pagevec_count(pvec); i++) {
+		struct page *page = pvec->pages[i];
+
+		if (!TestClearPageLRU(page))
+			BUG();
+		if (PageActive(page))
+			del_page_from_active_list(page);
+		else
+			del_page_from_inactive_list(page);
+	}
+	spin_unlock(&pagemap_lru_lock);
+	pagevec_release(pvec);
+}
+
+/*
  * Perform any setup for the swap system
  */
 void __init swap_setup(void)
--- 2.5.31/mm/page_alloc.c~pagevec	Sun Aug 11 00:20:32 2002
+++ 2.5.31-akpm/mm/page_alloc.c	Sun Aug 11 00:21:03 2002
@@ -22,6 +22,7 @@
 #include <linux/compiler.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
+#include <linux/pagevec.h>
 
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
@@ -458,6 +459,14 @@ void page_cache_release(struct page *pag
 	}
 }
 
+void __pagevec_free(struct pagevec *pvec)
+{
+	int i = pagevec_count(pvec);
+
+	while (--i >= 0)
+		__free_pages_ok(pvec->pages[i], 0);
+}
+
 void __free_pages(struct page *page, unsigned int order)
 {
 	if (!PageReserved(page) && put_page_testzero(page))

.
