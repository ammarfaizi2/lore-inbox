Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269866AbUJHLzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269866AbUJHLzO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269867AbUJHLzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:55:14 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:8877 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269866AbUJHLzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:55:00 -0400
Date: Fri, 08 Oct 2004 21:00:27 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [PATCH] no buddy bitmap patch revist : intro and includes [0/2]
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-mm <linux-mm@kvack.org>,
       LHMS <lhms-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>,
       Tony Luck <tony.luck@intel.com>, Dave Hansen <haveblue@us.ibm.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
Message-id: <4166815B.8030001@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Followings are patches for removing bitmaps from the buddy allocator,
against 2.6.9-rc3.
This is  benefical to memory-hot-plug stuffs, because this removes
a data structure which must meet to a host's physical memory layout.

Difference from one I posted yesterday is using CONFIG_HOLES_IN_ZONE
instead of HOLES_IN_ZONE and some fixes on comments.

This patch removes bitmaps in zone->free_area[] used in the buddy system.
Instead of using bitmaps, this patch records a free page's order in a page
struct itself using page->private field.

I removed "#define HOLES_IN_ZONE in asm/page.h" and added CONFIG_HOLES_IN_ZONE
to Kconfig. An architecuture which has memory holes in a zone has to set this CONFIG.
As far as I know, only ia64 with virtual memmap has to set this now.

In my performance test on ia64 SMP, there is no performance influence of this patch.

Kame <kamezawa.hiroyu@jp.fujitsu.com>
============= patches for include files ==================


This patch set removes bitmaps from the page allocator.

Purpose:
This is one step to manage physical memory in nonlinear / discontiguous way
and will reduce some amounts of codes to implement memory-hot-plug.

About this part:
This patch removes bitmaps from zone->free_area[] in include/linux/mmzone.h,
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
--- test-kernel/include/linux/mm.h~eliminate-bitmap-includes	2004-10-07 17:18:34.000000000 +0900
+++ test-kernel-kamezawa/include/linux/mm.h	2004-10-07 17:18:34.000000000 +0900
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
--- test-kernel/include/linux/mmzone.h~eliminate-bitmap-includes	2004-10-07 17:18:34.000000000 +0900
+++ test-kernel-kamezawa/include/linux/mmzone.h	2004-10-07 17:18:34.000000000 +0900
@@ -22,7 +22,6 @@

 struct free_area {
 	struct list_head	free_list;
-	unsigned long		*map;
 };

 struct pglist_data;
diff -puN include/linux/page-flags.h~eliminate-bitmap-includes include/linux/page-flags.h
--- test-kernel/include/linux/page-flags.h~eliminate-bitmap-includes	2004-10-07 17:18:34.000000000 +0900
+++ test-kernel-kamezawa/include/linux/page-flags.h	2004-10-07 17:18:34.000000000 +0900
@@ -238,6 +238,8 @@ extern unsigned long __read_page_state(u
 #define SetPagePrivate(page)	set_bit(PG_private, &(page)->flags)
 #define ClearPagePrivate(page)	clear_bit(PG_private, &(page)->flags)
 #define PagePrivate(page)	test_bit(PG_private, &(page)->flags)
+#define __SetPagePrivate(page)  __set_bit(PG_private, &(page)->flags)
+#define __ClearPagePrivate(page) __clear_bit(PG_private, &(page)->flags)

 #define PageWriteback(page)	test_bit(PG_writeback, &(page)->flags)
 #define SetPageWriteback(page)						\

_


