Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267740AbUHaKbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267740AbUHaKbG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 06:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267748AbUHaKbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 06:31:06 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:30174 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267740AbUHaKaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 06:30:52 -0400
Date: Tue, 31 Aug 2004 19:36:01 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [RFC] buddy allocator without bitmap(2) [0/3]
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>
Message-id: <41345491.1020209@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
thanks for many advices on previous RFC.

This new patch is against 2.6.9-rc1-mm1.
A new algorithm is implemented.

Considering advises on previous patch, I think the problems of that was
(1) vagueness of zone->aligned_order
(2) vagueness of zone->nr_mem_map
(3) using pfn_valid() in the core of buddy allocator only for rare case.
(ex) readability ;)

I removed these (1)-(3) and this version is not so micro-optimized.
I think inner-loop of free_pages_bulk() becomes simpler.

I added one more PG_xxx flag, PG_buddyend and reserve one page as a stopper.
PG_buddyend is set in boot-time and never cleared. This flags works as a
lower-address stopper of buddy allocator.The reserved one page works as a
higher-address stopper. "No accessing not-existing page" is guaranteed by these two.
About a usage of PG_buddyend flag, please read patch.
There is a sample illustration in attached patch.

Advantage:
  - information about buddy system is fully stored in the mem_map.
  - no bitmap
  - can work well on discontiguous mem_map.
Disadvantage:
  - using one more PG_xxx flag.
  - If mem_map is not aligned, reserve one page as a victim for buddy allocater.

How about this approach ?

Regards
-- Kame


This patch removes bitmap from buddy allocator,
removes free_area_t's bitmap in include/linux/mmzone.h
and adds some definition in include/linux/mm.h

This is the 1st patch.

Currently,Linux's page allocator uses buddy algorithm and codes for buddy
allocator uses bitmaps. For what is bitmaps are used ?

(*) for recording "a page is free" and page's order.

here, page's order means size of contiguous free pages.
if a free page[x] 's order is Y, there are contiguous free pages
among page[X] to page[X + 2^(Y) - 1]

If a page is free and is a head of contiguous free pages of order 'X',
we can record it by
set_bit(free_area[X]->map, index of page[X] in this order)

For coalescing, when there is a chunk of free pages of order 'X',
we can test whether we can coalesce or not by,
test_bit(free_aera[X]->bitmap,index_of_buddy)
index_of_buddy can be calculated by (index_of_page ^ (1 << order))

This patch removes bitmap and recording a free page's order
in its page structure's page->private field. If a page is free and
it is a head of a free contiguous memory chunk, page->private indicates
the order of the page.PG_private bit is used to show propriety of this field.

For coalescing, when there is a page which is a chunk of contiguous free pages
of order 'X', we can test whether the page is to be coalesced or not by
(page_is_free(buddy) && PagePrivate(buddy) && page_order(buddy) == 'X')
address of buddy can be calculated by the same way in bitmap case.

If page is free and on the buddy system, PG_private bit is set
and has its order in page->private. This scheme is safe because...
(a) when page is being freed, PG_private is not set. (see free_pages_check())
(b) when page is free and on the buddy system, PG_private is set.
These facts are guaranteed by zone->lock.
Only one thread can change a free page's PG_private bit and private field
at anytime.

[ Not MAX_ORDER aligned memory ]
If all memory are aligned to system's MAX_ORDER, all buddy algorithm works
fine and there is no trouble.But if memory is not aligned, we must check
"whether buddy exists or not?".
Checking this in main-loop of free_pages_bulk() is ugly but a page which
has no buddy in some order can be calculated in boot time.

New PG_xxx flag, PG_buddyend flag is introduced.
This flag works as a stopper of buddy coalescing.

A page is on the lower address end of mem_map and it cannot have
its lower address buddy is marked as PG_buddyend. Please see below.

If mem_map's start address is aligned, pages & buddy looks like this

order   start_pfn   ->                     higher address
         -------------------------------------
0       |  |  |  |  |  |  |  |  |  |  |  |  | ..
         -------------------------------------
1       |     |     |     |     |     |     |
         -------------------------------------
2       |           |           |           |
         -------------------------------------
3       |                       |
         -------------------------------------

If mem_map start address is not aligned, some of "lower address buddy"
disappears.

            ----------------------------------
0          |X |  |  |  |  |  |  |  |  |  |  | ..
            ----------------------------------
1             |X    |     |     |     |     |
               -------------------------------
2                   |X          |           |
                     -------------------------
3                               |X
                                 -------------

A group of pages marked 'X' in each order never has its lower address buddy.
'X' pages are marked as PG_buddyend.

Now,this check can work well enough to avoid coalescing not aligned pages.
-----------------------
buddy_index = page_index ^ (1 << order)
if ((buddy_index < page_index)  &&
     PageBuddyend(base + page_index))
       stop coalescing.
-----------------------

Above is for lower address case, How about higher address ?
If higher end of mem_map is not aligned to MAX_ORDER, we reserve
the highest address page and don't put it into buddy system. (don't pass to
free_pages())
This one page is a victim for buddy allocator, and this is enough.


-- Kame


---

  linux-2.6.9-rc1-mm1-k-kamezawa/include/linux/mm.h         |   24 ++++++++++++++
  linux-2.6.9-rc1-mm1-k-kamezawa/include/linux/mmzone.h     |    1
  linux-2.6.9-rc1-mm1-k-kamezawa/include/linux/page-flags.h |   10 +++++
  3 files changed, 34 insertions(+), 1 deletion(-)

diff -puN include/linux/mm.h~eliminate-bitmap-includes include/linux/mm.h
--- linux-2.6.9-rc1-mm1-k/include/linux/mm.h~eliminate-bitmap-includes	2004-08-31 18:37:04.186101664 +0900
+++ linux-2.6.9-rc1-mm1-k-kamezawa/include/linux/mm.h	2004-08-31 18:37:04.194100448 +0900
@@ -209,6 +209,9 @@ struct page {
  					 * usually used for buffer_heads
  					 * if PagePrivate set; used for
  					 * swp_entry_t if PageSwapCache
+					 * When page is free:
+					 * this indicates order of page
+					 * in buddy allocator.
  					 */
  	struct address_space *mapping;	/* If low bit clear, points to
  					 * inode address_space, or NULL.
@@ -322,6 +325,27 @@ static inline void put_page(struct page
  #endif		/* CONFIG_HUGETLB_PAGE */

  /*
+ * These functions are used in alloc_pages()/free_pages(), buddy allocator.
+ * page_order(page) returns an order of a free page in buddy allocator.
+ *
+ * this is used with PG_private flag
+ *
+ * Note : all PG_private operations used in buddy system is done while
+ * zone->lock is acquired. So set and clear PG_private bit operation
+ * does not need to be atomic.
+ */
+
+static inline int page_order(struct page *page)
+{
+	return page->private;
+}
+
+static inline void set_page_order(struct page *page, int order)
+{
+	page->private = order;
+}
+
+/*
   * Multiple processes may "see" the same page. E.g. for untouched
   * mappings of /dev/null, all processes see the same page full of
   * zeroes, and text pages of executables and shared libraries have
diff -puN include/linux/mmzone.h~eliminate-bitmap-includes include/linux/mmzone.h
--- linux-2.6.9-rc1-mm1-k/include/linux/mmzone.h~eliminate-bitmap-includes	2004-08-31 18:37:04.188101360 +0900
+++ linux-2.6.9-rc1-mm1-k-kamezawa/include/linux/mmzone.h	2004-08-31 18:37:04.195100296 +0900
@@ -22,7 +22,6 @@

  struct free_area {
  	struct list_head	free_list;
-	unsigned long		*map;
  };

  struct pglist_data;
diff -puN include/linux/page-flags.h~eliminate-bitmap-includes include/linux/page-flags.h
--- linux-2.6.9-rc1-mm1-k/include/linux/page-flags.h~eliminate-bitmap-includes	2004-08-31 18:37:04.190101056 +0900
+++ linux-2.6.9-rc1-mm1-k-kamezawa/include/linux/page-flags.h	2004-08-31 18:37:04.196100144 +0900
@@ -44,6 +44,12 @@
   * space, they need to be kmapped separately for doing IO on the pages.  The
   * struct page (these bits with information) are always mapped into kernel
   * address space...
+ *
+ * PG_buddyend pages don't have its buddy in buddy allocator in some meaning.
+ * If a page is on the lower address end of mem_map and a buddy of it, in some
+ * order, is below the end, a page is marked as PG_buddyend. If a page is on
+ * the higher addres end of mem_map and a buddy of it,in some order, is above
+ * the end, a page is marked as PG_buddyend.
   */

  /*
@@ -75,6 +81,7 @@
  #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
  #define PG_reclaim		18	/* To be reclaimed asap */

+#define PG_buddyend             19      /* end of the buddy allocator */

  /*
   * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -290,6 +297,9 @@ extern unsigned long __read_page_state(u
  #define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
  #define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)

+#define PageBuddyend(page)      test_bit(PG_buddyend, &(page)->flags)
+#define SetPageBuddyend(page)   set_bit(PG_buddyend, &(page)->flags)
+
  #ifdef CONFIG_SWAP
  #define PageSwapCache(page)	test_bit(PG_swapcache, &(page)->flags)
  #define SetPageSwapCache(page)	set_bit(PG_swapcache, &(page)->flags)

_




