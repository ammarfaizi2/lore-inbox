Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269119AbUIHLfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269119AbUIHLfd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269120AbUIHLfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:35:33 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:36074 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269119AbUIHLfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:35:12 -0400
Date: Wed, 08 Sep 2004 20:40:25 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [RFC][PATCH] no bitmap buddy allocator:  remove free_area->map (0/4)
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: LHMS <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
Message-id: <413EEFA9.9030007@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series of patches remove bitmaps from kernel's page allocator,
so-called buddy allocator.This is part (0/4) and removes free_area->map.

By removing bitmap, we can reduce a strcuture whose size is depends on
installed memory size.
Removing it is good for implementing memory-hotplug and some other codes.

In buddy system, a page's order means size of contiguous free pages.
If a free page[x] 's order is Y, there are contiguous free pages
from page[X] to page[X + 2^(Y) - 1]

In this patch, when a page is a head of contiguous free pages of order X,
it is marked with PG_private and set page->private to X.
A page's buddy in order X is simply calculated by

buddy_idx = page_idx ^ (1 << X).

We can coalece 2 contiguous pages if
let buddy = pfn_to_page(zone->zone_start_pfn + page_idx ^ (1 << X)),
(page_is_free(buddy) && PagePrivate(buddy) && page_order(buddy) == 'X')

Although a look of code is changed, this algorithm itself is not different from
the original buddy allocator. Only difference is there is no bitmap.


Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>



---

  test-kernel-kamezawa/include/linux/mm.h     |   26 ++++++++++++++++++++++++++
  test-kernel-kamezawa/include/linux/mmzone.h |    7 ++++++-
  2 files changed, 32 insertions(+), 1 deletion(-)

diff -puN include/linux/mm.h~eliminate-bitmap-includes include/linux/mm.h
--- test-kernel/include/linux/mm.h~eliminate-bitmap-includes	2004-09-08 17:31:41.341538896 +0900
+++ test-kernel-kamezawa/include/linux/mm.h	2004-09-08 17:31:41.346538136 +0900
@@ -213,6 +213,9 @@ struct page {
  					 * usually used for buffer_heads
  					 * if PagePrivate set; used for
  					 * swp_entry_t if PageSwapCache
+					 * When page is free:
+					 * this indicates order of page
+					 * in buddy allocator.
  					 */
  	struct address_space *mapping;	/* If low bit clear, points to
  					 * inode address_space, or NULL.
@@ -326,6 +329,29 @@ static inline void put_page(struct page
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
+#define PAGE_INVALID_ORDER (~0UL)
+
+static inline unsigned long page_order(struct page *page)
+{
+	return page->private;
+}
+
+static inline void set_page_order(struct page *page,unsigned long order)
+{
+	page->private = order;
+}
+
+/*
   * Multiple processes may "see" the same page. E.g. for untouched
   * mappings of /dev/null, all processes see the same page full of
   * zeroes, and text pages of executables and shared libraries have
diff -puN include/linux/mmzone.h~eliminate-bitmap-includes include/linux/mmzone.h
--- test-kernel/include/linux/mmzone.h~eliminate-bitmap-includes	2004-09-08 17:31:41.343538592 +0900
+++ test-kernel-kamezawa/include/linux/mmzone.h	2004-09-08 17:31:41.347537984 +0900
@@ -22,7 +22,6 @@

  struct free_area {
  	struct list_head	free_list;
-	unsigned long		*map;
  };

  struct pglist_data;
@@ -207,6 +206,12 @@ struct zone {
  	unsigned long		zone_start_pfn;

  	/*
+	 * indicates start_pfn/end_pfn of initialized mem_map
+	 */
+	unsigned long           memmap_start_pfn;
+	unsigned long           memmap_end_pfn;
+
+        /*
  	 * rarely used fields:
  	 */
  	char			*name;

_

