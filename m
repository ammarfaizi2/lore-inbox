Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269630AbUJGMa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269630AbUJGMa4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 08:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUJGMaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 08:30:55 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:19946 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269809AbUJGMRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 08:17:11 -0400
Date: Thu, 07 Oct 2004 21:22:41 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [PATCH]  no buddy bitmap patch : intro and includes [0/2]
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Luck, Tony" <tony.luck@intel.com>, Dave Hansen <haveblue@us.ibm.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
Message-id: <41653511.60905@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Followings are patches for removing bitmaps from buddy allocator, against 2.6.9-rc3.
I think this version is much clearer than ones I posted a month ago.

The problem I was worried about was how to deal with memmap's holes in a zone.
and I decided to use pfn_valid() simply. Now, there is no messy codes :)

pfn_valid() is used when macro "HOLES_IN_ZONE" is defined.
It is defined only in ia64 now.

Here is kernbench result on my tiger4 (Itanium2 1.3GHz x2, 8 Gbytes memory)

Average Optimal -j 8 Load Run (Perfroming 5 run of make -j 8 on linux-2.6.8 source tree):

                Elapsed Time  User Time  System Time Percent CPU  Context Switches   Sleeps
2.6.9-rc3         699.906      1322.01     39.336       194            64390         74416.8
no-bitmap         698.334      1321.79     38.58        194.2          64435.4       74622.2

If there is unclear point, please tell me.

Thanks.
Kame <kamezawa.hiroyu@jp.fujitsu.com>

=== patch for include files ===

This patch removes bitmap from zone->free_area[] in include/linux/mmzone.h,
and adds some comments on page->private field in include/linux/mm.h.

non-atomic ops for changing PG_private bit is added in include/page-flags.h.
zone->lock is always acquired when PG_private of "a free page" is changed.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


---

 test-kernel-kamezawa/include/linux/mm.h         |    2 ++
 test-kernel-kamezawa/include/linux/mmzone.h     |    1 -
 test-kernel-kamezawa/include/linux/page-flags.h |    2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff -puN include/linux/mm.h~eliminate-bitmap-includes include/linux/mm.h
--- test-kernel/include/linux/mm.h~eliminate-bitmap-includes	2004-10-07 17:18:34.062982800 +0900
+++ test-kernel-kamezawa/include/linux/mm.h	2004-10-07 17:18:34.070981584 +0900
@@ -209,6 +209,8 @@ struct page {
 					 * usually used for buffer_heads
 					 * if PagePrivate set; used for
 					 * swp_entry_t if PageSwapCache
+					 * When page is free, this indicates
+					 * order in the buddy system.
 					 */
 	struct address_space *mapping;	/* If low bit clear, points to
 					 * inode address_space, or NULL.
diff -puN include/linux/mmzone.h~eliminate-bitmap-includes include/linux/mmzone.h
--- test-kernel/include/linux/mmzone.h~eliminate-bitmap-includes	2004-10-07 17:18:34.065982344 +0900
+++ test-kernel-kamezawa/include/linux/mmzone.h	2004-10-07 17:18:34.071981432 +0900
@@ -22,7 +22,6 @@

 struct free_area {
 	struct list_head	free_list;
-	unsigned long		*map;
 };

 struct pglist_data;
diff -puN include/linux/page-flags.h~eliminate-bitmap-includes include/linux/page-flags.h
--- test-kernel/include/linux/page-flags.h~eliminate-bitmap-includes	2004-10-07 17:18:34.067982040 +0900
+++ test-kernel-kamezawa/include/linux/page-flags.h	2004-10-07 17:18:34.071981432 +0900
@@ -238,6 +238,8 @@ extern unsigned long __read_page_state(u
 #define SetPagePrivate(page)	set_bit(PG_private, &(page)->flags)
 #define ClearPagePrivate(page)	clear_bit(PG_private, &(page)->flags)
 #define PagePrivate(page)	test_bit(PG_private, &(page)->flags)
+#define __SetPagePrivate(page)  __set_bit(PG_private, &(page)->flags)
+#define __ClearPagePrivate(page) __clear_bit(PG_private, &(page)->flags)

 #define PageWriteback(page)	test_bit(PG_writeback, &(page)->flags)
 #define SetPageWriteback(page)						\

_

