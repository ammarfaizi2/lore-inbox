Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268803AbUHZLxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268803AbUHZLxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268824AbUHZLvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:51:07 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:12949 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S268800AbUHZLpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:45:39 -0400
Date: Thu, 26 Aug 2004 20:50:45 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [RFC] buddy allocator without bitmap [0/4]
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>
Message-id: <412DCE95.5050207@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, these patches remove bitmaps from the buddy allocator and
are against 2.6.8.1-mm4.

I'm now working for memory-hotplug and my purpose of removing bitmaps
is to reduce the complexity of memory management structures.
By removing bitmaps, complexity of some kinds of codes will decrease
to some extent.

If you feel this patch itself is complex, please ask me :).

Algorithm:
Current buddy allocator, which uses bitmaps, records free page's order
to its bitmap. No-bitmap buddy allocator records a free page's order
to its page structure's page->private field.

Assume a zone whose zone_start_pfn is 0.
When page X of order Y is freed, buddy of page X is page Z = (X ^ (1 << Y)).
if page[Z].private == Y, the allocator can coalesce X and Z.
This algorithm itself works well, the problem would be performance.

Performance:
Because there is no access to bitmaps, the kernel's memory footprint looks
to be reduced. But by accessing a page structure directly even if we cannot
coalesce it, the kernel has to get one more cache-miss penalty when we free pages.

By my tiny test(repeats mmap, touch memory, munmap), performance of no-bitmap
allocator is not different from current kernel's allocator on both IA32 and IA64
server machine. But further more different types of tests are required.
If someone knows suitable benchmark to test page alloc/free, please tell me.

PG_private:
To record a free page's order to page->private, this code uses PG_private flag.
When a page is passed to free_pages(), it is guaranteed that PG_private is cleared.
(see free_pages_check())
I use PG_private/page->private filed only while zone->lock() is acquired, there is
no confusion of using page->private to record a free page's order.

IA64 fix:
zone->nr_mem_map is currently only for IA64, which can have memmap with holes.
If someone has better idea for how to manage memmap with hole, please tell me.

This part is for include files.

Thanks
Kame

-- 

=================


This patch removes bitmap from buddy allocator,
removes free_area_t's bitmap in include/linux/mmzone.h
and adds some definition in include/linux/mm.h

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
in its page->private field. If a page is free and it is a head of a free
memory chunk, page->private indicates the order of the page.
and PG_private bit is used to show propriety of information.

For coalescing, when there is a page which is a chunk of contiguous free pages
of order 'X', we can test whether the page is to be coalesced or not by
(page_is_free(buddy) && PagePrivate(buddy) && page_order(buddy) == 'X')
address of buddy can be calculated by the same way in bitmap case.

If page is free and on the buddy system, PG_private bit is set and has its order
in page->private. This scheme is safe because...
(a) when page is being freed, PG_private is not set. (see free_pages_check())
(b) when page is free and on the buddy system, PG_private is set.
These facts are guaranteed by zone->lock.
Only one thread can change a free page's PG_private bit and private field
at anytime.

in mmzone.h, zone->aligned_order is added. this is explained in next patch.

-- Kame


---

 linux-2.6.8.1-mm4-kame-kamezawa/include/linux/mm.h     |   19 +++++++++++++++++
 linux-2.6.8.1-mm4-kame-kamezawa/include/linux/mmzone.h |    5 +++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff -puN include/linux/mm.h~eliminate-bitmap-includes include/linux/mm.h
--- linux-2.6.8.1-mm4-kame/include/linux/mm.h~eliminate-bitmap-includes	2004-08-26 08:35:57.009479048 +0900
+++ linux-2.6.8.1-mm4-kame-kamezawa/include/linux/mm.h	2004-08-26 08:35:57.015478136 +0900
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
@@ -322,6 +325,22 @@ static inline void put_page(struct page
 #endif		/* CONFIG_HUGETLB_PAGE */

 /*
+ * These functions are used in alloc_pages()/free_pages(), buddy allocator.
+ * page_order(page) returns an order of a free page in buddy allocator.
+ *
+ * this is used with PG_private flag
+ *
+ * Note : all PG_private operations used in buddy system is done while
+ * zone->lock is acquired. So set and clear PG_private bit operation
+ * does not need to be atomic. No atomic flag oprations are not used in buddy
+ * allocator for performance reason.
+ */
+static inline int page_order(struct page *page)
+{
+	return (int)page->private;
+}
+
+/*
  * Multiple processes may "see" the same page. E.g. for untouched
  * mappings of /dev/null, all processes see the same page full of
  * zeroes, and text pages of executables and shared libraries have
diff -puN include/linux/mmzone.h~eliminate-bitmap-includes include/linux/mmzone.h
--- linux-2.6.8.1-mm4-kame/include/linux/mmzone.h~eliminate-bitmap-includes	2004-08-26 08:35:57.011478744 +0900
+++ linux-2.6.8.1-mm4-kame-kamezawa/include/linux/mmzone.h	2004-08-26 08:42:04.608595488 +0900
@@ -22,7 +22,6 @@

 struct free_area {
 	struct list_head	free_list;
-	unsigned long		*map;
 };

 struct pglist_data;
@@ -163,7 +162,10 @@ struct zone {

 	/*
 	 * free areas of different sizes
+	 * aligned_order shows the upper bound of aligned order,
+	 * means every page below it has a buddy.
 	 */
+	int                     aligned_order;
 	struct free_area	free_area[MAX_ORDER];

 	/*
@@ -212,6 +214,7 @@ struct zone {
 	char			*name;
 	unsigned long		spanned_pages;	/* total size, including holes */
 	unsigned long		present_pages;	/* amount of memory (excluding holes) */
+	int                     nr_mem_map;     /* num of contiguous memmap */
 } ____cacheline_maxaligned_in_smp;



_



