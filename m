Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWIALJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWIALJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 07:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWIALJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 07:09:58 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:63925 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751471AbWIALJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 07:09:55 -0400
Date: Fri, 1 Sep 2006 13:09:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, frankeh@watson.ibm.com,
       rhim@cc.gateh.edu
Subject: [patch 3/9] Guest page hinting: volatile page cache.
Message-ID: <20060901110948.GD15684@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Hubertus Franke <frankeh@watson.ibm.com>
From: Himanshu Raj <rhim@cc.gatech.edu>

[patch 3/9] Guest page hinting: volatile page cache.

A new page state "volatile" is introduced that is used for clean,
uptodate page cache pages. The host can choose to discard volatile
pages as part of its vmscan operation instead of writing them to the
hosts paging device. This greatly reduces the i/o needed by the host
if it gets under memory pressure. The guest system doesn't notice
that a volatile page is gone until it tries to access the page or
tries to make it stable again. Then the guest needs to remove the
page from the cache. A guest access to a discarded page causes the
host to deliver a new kind of fault to the guest - the discard fault.
After the guest has removed the page it is reloaded from the backing
device.

The code added by this patch uses the volatile state for all page cache
pages, even for pages which are referenced by writable ptes. The host
needs to be able to check the dirty state of the pages. Since the host
doesn't know where the page table entries of the guest are located,
the volatile state as introduced by this patch is only usable on
architectures with per-page dirty bits (s390 only). For per-pte dirty
bit architectures some additional code is needed.

The interesting question is where to put the state transitions between
the volatile and the stable state. The simple solution is the make a
page stable whenever a lookup is done or a page reference is derived
from a page table entry. Attempts to make pages volatile are added at
strategic points. Now what are the conditions that prevent a page from
being made volatile? There are 10 conditions:
1) The page is reserved. Some sort of special page.
2) The page is marked dirty in the struct page. The page content is
   more recent than the data on the backing device. The host cannot
   access the linux internal dirty bit so the page needs to be stable.
3) The page is in writeback. The page content is needed for i/o.
4) The page is locked. Someone has exclusive access to the page.
5) The page is anonymous. Swap cache support needs additional code.
6) The page has no mapping. No backing, the page cannot be recreated.
7) The page is not uptodate.
8) The page has private information. try_to_release_page can fail,
   e.g. in case the private information is journaling data. The discard
   fault need to be able to remove the page.
9) The page is already discarded.
10) The page map count is not equal to the page reference count - 1.
   The discard fault handler can remove the page cache reference and
   all mappers of a page. It cannot remove the page reference for any
   other user of the page.

The transitions to stable are done by find_get_pages() and its variants,
in get_user_pages if called with a pages parameter, by copy-on-write in
do_wp_page, and by the early copy-on-write in do_no_page. To make enough
pages discardable by the host an attempt to do the transition to volatile
state is done when a page gets unlocked (unlock_page), when writeback has
finished (test_clear_page_dirty), when the page reference counter is
decreased (put_page_testzero), and when the page map counter is increased
(page_add_file_rmap).

All page references acquired with find_get_page and friends can be used
to access the page frame content. A page reference grabbed from a page
table cannot be used to access the page content. A page_make_stable
needs to be done first and if that fails the page needs to get discarded.
That removes the page table entry as well.

Two new page flags are added. To guard against concurrent page state
updates the PG_state_change flag is used. It prevents that a transition
to the stable state can "overtake" a transition to volatile state.
If page_make_volatile has already done the 10 checks it will issue
the state change primitive. If in the meantime on of the conditions has
changed the user that requires the page in stable state will have to wait
until the make volatile operation has finished. The make volatile
operation does not wait for the PG_state_change if make stable has set
the bit. Instead the attempt to make the page volatile fails. The reason
is that test_clear_page_dirty is called from interrupt context and waiting
for the bit might dead-lock.

The second new page flag is the PG_discarded bit. This bit is set for
discarded pages. It prevents multiple removes of a page from the page
cache due to concurrent discard faults and/or normal page removals.
It also prevents the re-add of isolated pages to the lru list in vmscan
if the page has been discarded while it was not on the lru list.

Another noticable change is that the first few lines of code in
try_to_unmap_one that calculates the address from the page and the vma
is moved out of try_to_unmap_one to the callers. This is done to make
try_to_unmap_one usable for the removal of discarded pages in
page_unmap_all.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 fs/buffer.c                 |    1 
 include/linux/mm.h          |    8 +
 include/linux/page-flags.h  |   13 +++
 include/linux/page-states.h |   55 +++++++++++++
 include/linux/pagemap.h     |    1 
 mm/Makefile                 |    1 
 mm/filemap.c                |   73 +++++++++++++++++-
 mm/memory.c                 |   44 ++++++++++
 mm/page-discard.c           |  178 ++++++++++++++++++++++++++++++++++++++++++++
 mm/page-writeback.c         |    3 
 mm/page_alloc.c             |    3 
 mm/rmap.c                   |   68 ++++++++++++++--
 mm/vmscan.c                 |   56 +++++++++----
 13 files changed, 471 insertions(+), 33 deletions(-)

diff -urpN linux-2.6/fs/buffer.c linux-2.6-patched/fs/buffer.c
--- linux-2.6/fs/buffer.c	2006-09-01 12:49:30.000000000 +0200
+++ linux-2.6-patched/fs/buffer.c	2006-09-01 12:49:36.000000000 +0200
@@ -105,6 +105,7 @@ __clear_page_buffers(struct page *page)
 {
 	ClearPagePrivate(page);
 	set_page_private(page, 0);
+	page_make_volatile(page, 2);
 	page_cache_release(page);
 }
 
diff -urpN linux-2.6/include/linux/mm.h linux-2.6-patched/include/linux/mm.h
--- linux-2.6/include/linux/mm.h	2006-09-01 12:49:36.000000000 +0200
+++ linux-2.6-patched/include/linux/mm.h	2006-09-01 12:49:36.000000000 +0200
@@ -308,11 +308,17 @@ struct page {
 
 /*
  * Drop a ref, return true if the refcount fell to zero (the page has no users)
+ * put_page_testzero checks if the page can be made volatile if the page
+ * still has users and guest page hinting is enabled.
  */
 static inline int put_page_testzero(struct page *page)
 {
+	int ret;
 	VM_BUG_ON(atomic_read(&page->_count) == 0);
-	return atomic_dec_and_test(&page->_count);
+	ret = atomic_dec_and_test(&page->_count);
+	if (!ret)
+		page_make_volatile(page, 1);
+	return ret;
 }
 
 /*
diff -urpN linux-2.6/include/linux/page-flags.h linux-2.6-patched/include/linux/page-flags.h
--- linux-2.6/include/linux/page-flags.h	2006-09-01 12:49:32.000000000 +0200
+++ linux-2.6-patched/include/linux/page-flags.h	2006-09-01 12:49:36.000000000 +0200
@@ -105,6 +105,9 @@
 #define PG_uncached		31	/* Page has been mapped as uncached */
 #endif
 
+#define PG_state_change		21	/* HV page state is changing. */
+#define PG_discarded		22	/* HV page has been discarded. */
+
 /*
  * Manipulation of page state flags
  */
@@ -254,6 +257,16 @@
 #define SetPageReadahead(page)	set_bit(PG_readahead, &(page)->flags)
 #define TestClearPageReadahead(page) test_and_clear_bit(PG_readahead, &(page)->flags)
 
+#define PageStateChange(page) test_bit(PG_state_change, &(page)->flags)
+#define ClearPageStateChange(page) clear_bit(PG_state_change, &(page)->flags)
+#define TestSetPageStateChange(page) \
+		test_and_set_bit(PG_state_change, &(page)->flags)
+
+#define PageDiscarded(page)	test_bit(PG_discarded, &(page)->flags)
+#define ClearPageDiscarded(page) clear_bit(PG_discarded, &(page)->flags)
+#define TestSetPageDiscarded(page) \
+		test_and_set_bit(PG_discarded, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
diff -urpN linux-2.6/include/linux/pagemap.h linux-2.6-patched/include/linux/pagemap.h
--- linux-2.6/include/linux/pagemap.h	2006-09-01 12:49:32.000000000 +0200
+++ linux-2.6-patched/include/linux/pagemap.h	2006-09-01 12:49:36.000000000 +0200
@@ -114,6 +114,7 @@ int add_to_page_cache_lru(struct page *p
 				unsigned long index, gfp_t gfp_mask);
 extern void remove_from_page_cache(struct page *page);
 extern void __remove_from_page_cache(struct page *page);
+extern void __remove_from_page_cache_nocheck(struct page *page);
 
 /*
  * Return byte-offset into filesystem object for page.
diff -urpN linux-2.6/include/linux/page-states.h linux-2.6-patched/include/linux/page-states.h
--- linux-2.6/include/linux/page-states.h	2006-09-01 12:49:36.000000000 +0200
+++ linux-2.6-patched/include/linux/page-states.h	2006-09-01 12:49:36.000000000 +0200
@@ -16,17 +16,72 @@
 #else
 
 /* Guest page hinting architecture primitives:
+ * - page_host_discards:
+ *     Indicates whether the host system discards guest pages or not.
  * - page_set_unused:
  *     Indicates to the host that the page content is of no interest
  *     to the guest. The host can "forget" the page content and replace
  *     it with a page containing zeroes.
  * - page_set_stable:
  *     Indicate to the host that the page content is needed by the guest.
+ * - page_set_volatile:
+ *     Make the page discardable by the host. Instead of writing the
+ *     page to the hosts swap device, the host can remove the page.
+ *     A guest that accesses such a discarded page gets a special
+ *     discard fault.
+ * - page_set_stable_if_present:
+ *     The page state is set to stable if the page has not been discarded
+ *     by the host. The check and the state change have to be done
+ *     atomically.
+ * - page_discarded:
+ *     Returns true if the page has been discarded by the host.
  */
 
+#define page_host_discards()			(0)
 #define page_set_unused(_page,_order)		do { } while (0)
 #define page_set_stable(_page,_order)		do { } while (0)
+#define page_set_volatile(_page)		do { } while (0)
+#define page_set_stable_if_present(_page)	(1)
+#define page_discarded(_page)			(0)
 
 #endif
 
+/*
+ * Common guest page hinting functions. The compiler will turn them
+ * into nop's if page_host_discards as primitive is defined as (0):
+ * - page_make_stable:
+ *     Tries to make a page stable. This operation can fail if the
+ *     host has discarded a page. The function returns != 0 if the
+ *     page could not be made stable.
+ * - page_make_volatile:
+ *     Tries to make a page volatile. There are a number of conditions
+ *     that prevent a page from becoming volatile. If at least one
+ *     is true the function does nothing. See mm/page-states.c for
+ *     details.
+ * - page_discard:
+ *     Removes a discarded page from the system. The page is removed
+ *     from the LRU list and the radix tree of its mapping.
+ *     page_discard uses page_unmap_all to remove all page table
+ *     entries for a page.
+ */
+extern void page_unmap_all(struct page *page);
+extern void page_discard(struct page *page);
+
+static inline int page_make_stable(struct page *page)
+{
+	extern int  __page_make_stable(struct page *);
+	if (!page_host_discards())
+		return 1;
+	return __page_make_stable(page);
+}
+
+static inline void page_make_volatile(struct page *page, unsigned int offset)
+{
+	extern void __page_make_volatile(struct page *, unsigned int offset);
+	if (!page_host_discards())
+		return;
+	if (likely(!test_bit(PG_discarded, &page->flags)))
+		__page_make_volatile(page, offset);
+}
+
 #endif /* _LINUX_PAGE_STATES_H */
diff -urpN linux-2.6/mm/filemap.c linux-2.6-patched/mm/filemap.c
--- linux-2.6/mm/filemap.c	2006-09-01 12:49:33.000000000 +0200
+++ linux-2.6-patched/mm/filemap.c	2006-09-01 12:49:36.000000000 +0200
@@ -118,7 +118,7 @@ extern u32 readahead_debug_level;
  * sure the page is locked and that nobody else uses it - or that usage
  * is safe.  The caller must hold a write_lock on the mapping's tree_lock.
  */
-void __remove_from_page_cache(struct page *page)
+void inline __remove_from_page_cache_nocheck(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 
@@ -127,6 +127,28 @@ void __remove_from_page_cache(struct pag
 	mapping->nrpages--;
 	__dec_zone_page_state(page, NR_FILE_PAGES);
 }
+
+void __remove_from_page_cache(struct page *page)
+{
+	/*
+	 * Check if the discard fault handler already removed
+	 * the page from the page cache. If not set the discard
+	 * bit in the page flags to prevent double page free if
+	 * a discard fault is racing with normal page free.
+	 */
+	if (page_host_discards() && TestSetPageDiscarded(page))
+		return;
+
+	__remove_from_page_cache_nocheck(page);
+
+	/*
+	 * Check the hardware page state and clear the discard
+	 * bit in the page flags only if the page is not
+	 * discarded.
+	 */
+	if (page_host_discards() && !page_discarded(page))
+		ClearPageDiscarded(page);
+}
 EXPORT_SYMBOL(__remove_from_page_cache);
 
 void remove_from_page_cache(struct page *page)
@@ -567,6 +589,7 @@ void fastcall unlock_page(struct page *p
 	if (!TestClearPageLocked(page))
 		BUG();
 	smp_mb__after_clear_bit(); 
+	page_make_volatile(page, 1);
 	wake_up_page(page, PG_locked);
 }
 EXPORT_SYMBOL(unlock_page);
@@ -671,6 +694,14 @@ struct page * find_get_page(struct addre
 	if (page)
 		page_cache_get(page);
 	read_unlock_irq(&mapping->tree_lock);
+	if (page && unlikely(!page_make_stable(page))) {
+		/*
+		 * The page has been discarded by the host. Run the
+		 * discard handler and return NULL.
+		 */
+		page_discard(page);
+		page = NULL;
+	}
 	return page;
 }
 EXPORT_SYMBOL(find_get_page);
@@ -715,7 +746,15 @@ repeat:
 	page = radix_tree_lookup(&mapping->page_tree, offset);
 	if (page) {
 		page_cache_get(page);
-		if (TestSetPageLocked(page)) {
+		if (unlikely(!page_make_stable(page))) {
+			/*
+			 * The page has been discarded by the host. Run the
+			 * discard handler and return NULL.
+			 */
+			read_unlock_irq(&mapping->tree_lock);
+			page_discard(page);
+			return NULL;
+		} else if (TestSetPageLocked(page)) {
 			read_unlock_irq(&mapping->tree_lock);
 			__lock_page(page);
 			read_lock_irq(&mapping->tree_lock);
@@ -800,11 +839,24 @@ unsigned find_get_pages(struct address_s
 	unsigned int i;
 	unsigned int ret;
 
+repeat:
 	read_lock_irq(&mapping->tree_lock);
 	ret = radix_tree_gang_lookup(&mapping->page_tree,
 				(void **)pages, start, nr_pages);
-	for (i = 0; i < ret; i++)
+	for (i = 0; i < ret; i++) {
 		page_cache_get(pages[i]);
+		if (likely(page_make_stable(pages[i])))
+			continue;
+		/*
+		 * Make stable failed, we discard the page and retry the
+		 * whole operation.
+		 */
+		read_unlock_irq(&mapping->tree_lock);
+		page_discard(pages[i]);
+		while (i--)
+			page_cache_release(pages[i]);
+		goto repeat;
+	}
 	read_unlock_irq(&mapping->tree_lock);
 	return ret;
 }
@@ -860,11 +912,24 @@ unsigned find_get_pages_tag(struct addre
 	unsigned int i;
 	unsigned int ret;
 
+repeat:
 	read_lock_irq(&mapping->tree_lock);
 	ret = radix_tree_gang_lookup_tag(&mapping->page_tree,
 				(void **)pages, *index, nr_pages, tag);
-	for (i = 0; i < ret; i++)
+	for (i = 0; i < ret; i++) {
 		page_cache_get(pages[i]);
+		if (likely(page_make_stable(pages[i])))
+			continue;
+		/*
+		 * Make stable failed, we discard the page and retry the
+		 * whole operation.
+		 */
+		read_unlock_irq(&mapping->tree_lock);
+		page_discard(pages[i]);
+		while (i--)
+			page_cache_release(pages[i]);
+		goto repeat;
+	}
 	if (ret)
 		*index = pages[ret - 1]->index + 1;
 	read_unlock_irq(&mapping->tree_lock);
diff -urpN linux-2.6/mm/Makefile linux-2.6-patched/mm/Makefile
--- linux-2.6/mm/Makefile	2006-09-01 12:49:33.000000000 +0200
+++ linux-2.6-patched/mm/Makefile	2006-09-01 12:50:14.000000000 +0200
@@ -28,3 +28,4 @@ obj-$(CONFIG_MEMORY_HOTPLUG) += memory_h
 obj-$(CONFIG_FS_XIP) += filemap_xip.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_SMP) += allocpercpu.o
+obj-$(CONFIG_PAGE_STATES) += page-discard.o
diff -urpN linux-2.6/mm/memory.c linux-2.6-patched/mm/memory.c
--- linux-2.6/mm/memory.c	2006-09-01 12:49:33.000000000 +0200
+++ linux-2.6-patched/mm/memory.c	2006-09-01 12:49:36.000000000 +0200
@@ -1058,6 +1058,7 @@ int get_user_pages(struct task_struct *t
 			if (write)
 				foll_flags |= FOLL_WRITE;
 
+retry:
 			cond_resched();
 			while (!(page = follow_page(vma, start, foll_flags))) {
 				int ret;
@@ -1087,6 +1088,22 @@ int get_user_pages(struct task_struct *t
 					BUG();
 				}
 			}
+			if (foll_flags & FOLL_GET) {
+				/*
+				 * The pages are only made stable in case
+				 * an additional reference is acquired. This
+				 * includes the case of a non-null pages array.
+				 * If no additional reference is taken it
+				 * implies that the caller can deal with page
+				 * faults in case the page is swapped out.
+				 * In this case the caller can deal with
+				 * discard faults as well.
+				 */
+				if (unlikely(!page_make_stable(page))) {
+					page_discard(page);
+					goto retry;
+				}
+			}
 			if (pages) {
 				pages[i] = page;
 
@@ -1552,6 +1569,12 @@ static int do_wp_page(struct mm_struct *
 	 * Ok, we need to copy. Oh, well..
 	 */
 	page_cache_get(old_page);
+	/*
+	 * To copy the content of old_page it needs to be stable.
+	 * page_cache_release on old_page will make it volatile again.
+	 */
+	if (unlikely(!page_make_stable(old_page)))
+		goto discard;
 gotten:
 	pte_unmap_unlock(page_table, ptl);
 
@@ -1613,6 +1636,10 @@ oom:
 unwritable_page:
 	page_cache_release(old_page);
 	return VM_FAULT_SIGBUS;
+discard:
+	pte_unmap_unlock(page_table, ptl);
+	page_discard(old_page);
+	return VM_FAULT_MAJOR;
 }
 
 /*
@@ -2177,6 +2204,10 @@ retry:
 
 			if (unlikely(anon_vma_prepare(vma)))
 				goto oom;
+			if (unlikely(!page_make_stable(new_page))) {
+				page_discard(new_page);
+				goto retry;
+			}
 			page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 			if (!page)
 				goto oom;
@@ -2321,7 +2352,9 @@ static inline int handle_pte_fault(struc
 	pte_t entry;
 	pte_t old_entry;
 	spinlock_t *ptl;
+	int rc;
 
+again:
 	old_entry = entry = *pte;
 	if (!pte_present(entry)) {
 		if (pte_none(entry)) {
@@ -2343,9 +2376,16 @@ static inline int handle_pte_fault(struc
 	if (unlikely(!pte_same(*pte, entry)))
 		goto unlock;
 	if (write_access) {
-		if (!pte_write(entry))
-			return do_wp_page(mm, vma, address,
+		if (!pte_write(entry)) {
+			rc = do_wp_page(mm, vma, address,
 					pte, pmd, ptl, entry);
+			if (page_host_discards() &&
+			    unlikely(rc == VM_FAULT_MAJOR)) {
+				pte = pte_alloc_map(mm, pmd, address);
+				goto again;
+			}
+			return rc;
+		}
 		entry = pte_mkdirty(entry);
 	}
 	entry = pte_mkyoung(entry);
diff -urpN linux-2.6/mm/page_alloc.c linux-2.6-patched/mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c	2006-09-01 12:49:36.000000000 +0200
+++ linux-2.6-patched/mm/page_alloc.c	2006-09-01 12:49:36.000000000 +0200
@@ -215,7 +215,8 @@ static void bad_page(struct page *page)
 			1 << PG_slab    |
 			1 << PG_swapcache |
 			1 << PG_writeback |
-			1 << PG_buddy );
+			1 << PG_buddy |
+			1 << PG_discarded );
 	set_page_count(page, 0);
 	reset_page_mapcount(page);
 	page->mapping = NULL;
diff -urpN linux-2.6/mm/page-discard.c linux-2.6-patched/mm/page-discard.c
--- linux-2.6/mm/page-discard.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/mm/page-discard.c	2006-09-01 12:49:36.000000000 +0200
@@ -0,0 +1,178 @@
+/*
+ * mm/page-discard.c
+ *
+ * (C) Copyright IBM Corp. 2005, 2006
+ *
+ * Guest page hinting functions.
+ *
+ * Authors: Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *          Hubertus Franke <frankeh@watson.ibm.com>
+ *          Himanshu Raj <rhim@cc.gatech.edu>
+ */
+
+#include <linux/mm.h>
+#include <linux/mm_inline.h>
+#include <linux/pagemap.h>
+#include <linux/rmap.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/buffer_head.h>
+
+#include "internal.h"
+
+/*
+ * Check if there is something that prevents the page from changing
+ * its state to volatile.
+ */
+static inline int __page_discardable(struct page *page,unsigned int offset)
+{
+	/*
+	 * There are several conditions that prevent a page from becoming
+	 * volatile. The first check is for the page bits.
+	 */
+	if (PageDirty(page) || PageReserved(page) || PageWriteback(page) ||
+	    PageLocked(page) || PagePrivate(page) || PageDiscarded(page) ||
+	    !PageUptodate(page) || !PageLRU(page) || PageAnon(page))
+		return 0;
+
+	/*
+	 * If the page has been truncated there is no point in making
+	 * it volatile. It will be freed soon. If the mapping ever had
+	 * locked pages all pages of the mapping will stay stable.
+	 */
+	if (!page_mapping(page))
+		return 0;
+
+	/*
+	 * The last check is the critical one. We check the reference
+	 * counter of the page against the number of mappings. The caller
+	 * of make_volatile passes an offset, that is the number of extra
+	 * references. For most calls that is 1 extra reference for the
+	 * page-cache. In some cases the caller itself holds an additional
+	 * reference, then the offset is 2. If the page map counter is equal
+	 * to the page count minus the offset then there is no other
+	 * (unknown) user of the page in the system and we can make the
+	 * page volatile.
+	 */
+	BUG_ON(page_mapcount(page) > page_count(page) - offset);
+	if (page_mapcount(page) != page_count(page) - offset)
+		return 0;
+
+	return 1;
+}
+
+/*
+ * Attempts to change the state of a page to volatile. If there is
+ * something preventing the state change the page stays in its current
+ * state.
+ */
+void __page_make_volatile(struct page *page, unsigned int offset)
+{
+	/*
+	 * If we can't get the PG_state_change bit just give up. The
+	 * worst that can happen is that the page will stay in stable
+	 * state although it might be volatile.
+	 */
+	preempt_disable();
+	if (!TestSetPageStateChange(page)) {
+		if (__page_discardable(page, offset))
+			page_set_volatile(page);
+		ClearPageStateChange(page);
+	}
+	preempt_enable();
+}
+EXPORT_SYMBOL(__page_make_volatile);
+
+/*
+ * Attempts to change the state of a page to stable. The host could
+ * have removed a volatile page, the page_set_stable_if_present call
+ * can fail.
+ *
+ * returns "0" on success and "1" on failure
+ */
+int __page_make_stable(struct page *page)
+{
+	/*
+	 * Postpone state change to stable until PG_state_change bit is
+	 * cleared. As long as PG_state_change is set another cpu is in
+	 * page_make_volatile for this page. That makes sure
+	 * that no caller of make_stable "overtakes" a make_volatile
+	 * leaving the page in volatile where stable is required.
+	 * The caller of make_stable need to make sure that no caller
+	 * of make_volatile can make the page volatile right after
+	 * make_stable has finished. That is done by requiring that
+	 * page has been locked or that the page_count has been
+	 * increased before make_stable is called. In both cases a
+	 * subsequent call page_make_volatile will fail.
+	 */
+	while (PageStateChange(page))
+		cpu_relax();
+	return page_set_stable_if_present(page);
+}
+EXPORT_SYMBOL(__page_make_stable);
+
+/**
+ * __page_discard() - remove a discarded page from the cache
+ *
+ * @page: the page
+ *
+ * The page passed to this function needs to be locked.
+ */
+static void __page_discard(struct page *page)
+{
+	struct address_space *mapping;
+	struct zone *zone;
+
+	/* Paranoia checks. */
+	BUG_ON(PageWriteback(page));
+	BUG_ON(PageDirty(page));
+	BUG_ON(PagePrivate(page));
+
+	/* Set the discarded bit early. */
+	if (TestSetPageDiscarded(page))
+		return;
+
+	/* Unmap the page from all page tables. */
+	page_unmap_all(page);
+
+	/*
+	 * Remove the page from LRU if it is currently added.
+	 * The users of isolate_lru_pages need to check the
+	 * discarded bit before readding the page to the LRU.
+	 */
+	zone = page_zone(page);
+	spin_lock_irq(&zone->lru_lock);
+	if (PageLRU(page)) {
+		/* Unlink page from lru. */
+		__ClearPageLRU(page);
+		del_page_from_lru(zone, page);
+	}
+	spin_unlock_irq(&zone->lru_lock);
+
+	/* We can't handle swap cache pages (yet). */
+	BUG_ON(PageSwapCache(page));
+
+	/* Remove page from page cache. */
+ 	mapping = page->mapping;
+	write_lock_irq(&mapping->tree_lock);
+	__remove_from_page_cache_nocheck(page);
+	write_unlock_irq(&mapping->tree_lock);
+	__put_page(page);
+}
+
+/**
+ * page_discard() - remove a discarded page from the cache
+ *
+ * @page: the page
+ *
+ * Before calling this function an additional page reference needs to
+ * be acquired. This reference is released by the function.
+ */
+void page_discard(struct page *page)
+{
+	lock_page(page);
+	__page_discard(page);
+	unlock_page(page);
+	page_cache_release(page);
+}
+EXPORT_SYMBOL(page_discard);
diff -urpN linux-2.6/mm/page-writeback.c linux-2.6-patched/mm/page-writeback.c
--- linux-2.6/mm/page-writeback.c	2006-09-01 12:49:33.000000000 +0200
+++ linux-2.6-patched/mm/page-writeback.c	2006-09-01 12:49:36.000000000 +0200
@@ -858,6 +858,7 @@ int test_clear_page_dirty(struct page *p
 			radix_tree_tag_clear(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
+			page_make_volatile(page, 2);
 			write_unlock_irqrestore(&mapping->tree_lock, flags);
 			/*
 			 * We can continue to use `mapping' here because the
@@ -924,6 +925,8 @@ int test_clear_page_writeback(struct pag
 						page_index(page),
 						PAGECACHE_TAG_WRITEBACK);
 		write_unlock_irqrestore(&mapping->tree_lock, flags);
+		if (ret)
+			page_make_volatile(page, 2);
 	} else {
 		ret = TestClearPageWriteback(page);
 	}
diff -urpN linux-2.6/mm/rmap.c linux-2.6-patched/mm/rmap.c
--- linux-2.6/mm/rmap.c	2006-09-01 12:49:33.000000000 +0200
+++ linux-2.6-patched/mm/rmap.c	2006-09-01 12:49:36.000000000 +0200
@@ -565,6 +565,7 @@ void page_add_file_rmap(struct page *pag
 {
 	if (atomic_inc_and_test(&page->_mapcount))
 		__inc_zone_page_state(page, NR_FILE_MAPPED);
+	page_make_volatile(page, 1);
 }
 
 /**
@@ -606,19 +607,14 @@ void page_remove_rmap(struct page *page)
  * repeatedly from either try_to_unmap_anon or try_to_unmap_file.
  */
 static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
-				int migration)
+				unsigned long address, int migration)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long address;
 	pte_t *pte;
 	pte_t pteval;
 	spinlock_t *ptl;
 	int ret = SWAP_AGAIN;
 
-	address = vma_address(page, vma);
-	if (address == -EFAULT)
-		goto out;
-
 	pte = page_check_address(page, mm, address, &ptl);
 	if (!pte)
 		goto out;
@@ -788,6 +784,7 @@ static int try_to_unmap_anon(struct page
 {
 	struct anon_vma *anon_vma;
 	struct vm_area_struct *vma;
+	unsigned long address;
 	int ret = SWAP_AGAIN;
 
 	anon_vma = page_lock_anon_vma(page);
@@ -795,7 +792,10 @@ static int try_to_unmap_anon(struct page
 		return ret;
 
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
-		ret = try_to_unmap_one(page, vma, migration);
+		address = vma_address(page, vma);
+		if (address == -EFAULT)
+			continue;
+		ret = try_to_unmap_one(page, vma, address, migration);
 		if (ret == SWAP_FAIL || !page_mapped(page))
 			break;
 	}
@@ -819,6 +819,7 @@ static int try_to_unmap_file(struct page
 	struct vm_area_struct *vma;
 	struct prio_tree_iter iter;
 	int ret = SWAP_AGAIN;
+	unsigned long address;
 	unsigned long cursor;
 	unsigned long max_nl_cursor = 0;
 	unsigned long max_nl_size = 0;
@@ -826,7 +827,10 @@ static int try_to_unmap_file(struct page
 
 	spin_lock(&mapping->i_mmap_lock);
 	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
-		ret = try_to_unmap_one(page, vma, migration);
+		address = vma_address(page, vma);
+		if (address == -EFAULT)
+			continue;
+		ret = try_to_unmap_one(page, vma, address, migration);
 		if (ret == SWAP_FAIL || !page_mapped(page))
 			goto out;
 	}
@@ -927,3 +931,51 @@ int try_to_unmap(struct page *page, int 
 	return ret;
 }
 
+#if defined(CONFIG_PAGE_STATES)
+
+/**
+ * page_unmap_all - removes all mappings of a page
+ *
+ * @page: the page which mapping in the vma should be struck down
+ *
+ * the caller needs to hold page lock
+ */
+void page_unmap_all(struct page* page)
+{
+	struct address_space *mapping = page_mapping(page);
+	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
+	struct vm_area_struct *vma;
+	struct prio_tree_iter iter;
+	unsigned long address;
+
+	BUG_ON(!PageLocked(page) || PageReserved(page) || PageAnon(page));
+
+	spin_lock(&mapping->i_mmap_lock);
+	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
+		address = vma_address(page, vma);
+		if (address == -EFAULT)
+			continue;
+		BUG_ON(try_to_unmap_one(page, vma, address, 0) == SWAP_FAIL);
+	}
+
+	if (list_empty(&mapping->i_mmap_nonlinear))
+		goto out;
+
+	/*
+	 * Remove the non-linear mappings of the page. This is
+	 * awfully slow, but we have to find that discarded page..
+	 */
+	list_for_each_entry(vma, &mapping->i_mmap_nonlinear,
+			    shared.vm_set.list) {
+		address = vma->vm_start;
+		while (address < vma->vm_end) {
+			BUG_ON(try_to_unmap_one(page, vma, address, 0) == SWAP_FAIL);
+			address += PAGE_SIZE;
+		}
+	}
+
+out:
+	spin_unlock(&mapping->i_mmap_lock);
+}
+
+#endif
diff -urpN linux-2.6/mm/vmscan.c linux-2.6-patched/mm/vmscan.c
--- linux-2.6/mm/vmscan.c	2006-09-01 12:49:33.000000000 +0200
+++ linux-2.6-patched/mm/vmscan.c	2006-09-01 12:49:36.000000000 +0200
@@ -681,13 +681,20 @@ static unsigned long shrink_inactive_lis
 		 */
 		while (!list_empty(&page_list)) {
 			page = lru_to_page(&page_list);
-			VM_BUG_ON(PageLRU(page));
-			SetPageLRU(page);
 			list_del(&page->lru);
-			if (PageActive(page))
-				add_page_to_active_list(zone, page);
-			else
-				add_page_to_inactive_list(zone, page);
+			/*
+			 * Only readd the page to lru list if it has not
+			 * been discarded.
+			 */
+			if (!page_host_discards() ||
+			    likely(!PageDiscarded(page))) {
+				VM_BUG_ON(PageLRU(page));
+				SetPageLRU(page);
+				if (PageActive(page))
+					add_page_to_active_list(zone, page);
+				else
+					add_page_to_inactive_list(zone, page);
+			}
 			if (!pagevec_add(&pvec, page)) {
 				spin_unlock_irq(&zone->lru_lock);
 				__pagevec_release(&pvec);
@@ -813,13 +820,20 @@ force_reclaim_mapped:
 	while (!list_empty(&l_inactive)) {
 		page = lru_to_page(&l_inactive);
 		prefetchw_prev_lru_page(page, &l_inactive, flags);
-		VM_BUG_ON(PageLRU(page));
-		SetPageLRU(page);
-		VM_BUG_ON(!PageActive(page));
-		ClearPageActive(page);
+		/*
+		 * Only readd the page to lru list if it has not
+		 * been discarded.
+		 */
+		if (!page_host_discards() || likely(!PageDiscarded(page))) {
+			VM_BUG_ON(PageLRU(page));
+			SetPageLRU(page);
+			VM_BUG_ON(!PageActive(page));
+			ClearPageActive(page);
+			list_move(&page->lru, &zone->inactive_list);
+			pgmoved++;
+		} else
+			list_del(&page->lru);
 
-		list_move(&page->lru, &zone->inactive_list);
-		pgmoved++;
 		if (!pagevec_add(&pvec, page)) {
 			zone->nr_inactive += pgmoved;
 			spin_unlock_irq(&zone->lru_lock);
@@ -843,11 +857,19 @@ force_reclaim_mapped:
 	while (!list_empty(&l_active)) {
 		page = lru_to_page(&l_active);
 		prefetchw_prev_lru_page(page, &l_active, flags);
-		VM_BUG_ON(PageLRU(page));
-		SetPageLRU(page);
-		VM_BUG_ON(!PageActive(page));
-		list_move(&page->lru, &zone->active_list);
-		pgmoved++;
+		/*
+		 * Only readd the page to lru list if it has not
+		 * been discarded.
+		 */
+		if (!page_host_discards() || likely(!PageDiscarded(page))) {
+			VM_BUG_ON(PageLRU(page));
+			SetPageLRU(page);
+			VM_BUG_ON(!PageActive(page));
+			list_move(&page->lru, &zone->active_list);
+			pgmoved++;
+		} else
+			list_del(&page->lru);
+
 		if (!pagevec_add(&pvec, page)) {
 			zone->nr_active += pgmoved;
 			pgmoved = 0;
