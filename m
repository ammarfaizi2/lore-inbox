Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269137AbUIHMDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269137AbUIHMDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269139AbUIHMDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:03:52 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:54230 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269137AbUIHMDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:03:35 -0400
Date: Wed, 08 Sep 2004 21:08:43 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: [RFC][PATCH] no bitmap buddy allocator : removing atomic ops (4/4)
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: linux-mm <linux-mm@kvack.org>, LHMS <lhms-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
Message-id: <413EF64B.2060407@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This part is part (4/4) and replaces atomic ops with non-atomic ops.
This micro optimization can improve the performance of the no-bitmap
buddy system.

To check effects of this patch. I made a tiny test.

************** test-program ********************
for(i = 0; i < 1000; i++) {
	mmap(16 Mega bytes, MAP_ANON);
	touch all pages;
	munmap(16 Mega bytes);
}
************************************************
Results of this program.
Host : Intex Xeon 1.8GHz x2, Memory 8Gbytes. Multi-user mode.

Reference Kernel --- linux-2.6.9-rc1-mm4
Total 0:35.79 System 33.89 User 1.88
Total 0:35.44 System 33.58 User 1.85
Total 0:35.75 System 33.81 User 1.91
Total 0:35.89 System 34.03 User 1.82
Total 0:35.93 System 34.03 User 1.84

No-bitmap without this micro-optimization patch
Total 0:37.58 System 35.69 User 1.89
Total 0:37.52 System 35.66 User 1.86
Total 0:37.56 System 35.68 User 1.88
Total 0:37.64 System 35.76 User 1.88
Total 0:37.72 System 35.89 User 1.82

No-bitmap with this micro-optimization patch.
Total 0:35.28 System 33.45 User 1.81
Total 0:35.38 System 33.62 User 1.75
Total 0:35.44 System 33.58 User 1.84
Total 0:35.52 System 33.58 User 1.90
Total 0:35.79 System 33.92 User 1.81

Single-user-mode.

reference-kernel  linux-2.6.9-rc1-mm4:
Total 0:35.20 System 33.32 User 1.88
Total 0:35.23 System 33.37 User 1.85
Total 0:35.58 System 33.77 User 1.81
Total 0:35.49 System 33.60 User 1.90
Total 0:35.79 System 33.80 User 1.99

No-bitmap without this micro-optimization patch
Total 0:36.83 System 35.16 User 1.67
Total 0:36.45 System 34.66 User 1.79
Total 0:36.81 System 35.10 User 1.70
Total 0:36.89 System 35.24 User 1.65
Total 0:36.82 System 35.14 User 1.68

No-bitmap with this micor-optimization patch:
Total 0:34.97 System 33.07 User 1.89
Total 0:34.94 System 32.98 User 1.95
Total 0:34.99 System 33.11 User 1.87
Total 0:34.90 System 33.14 User 1.76
Total 0:34.92 System 33.02 User 1.90


Results with this patch is better than ones without this by 2 seconds.
2/1000 = 2ms per 1 iteration (for 16 Megabytes alloc/free).

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

---

  test-kernel-kamezawa/include/linux/page-flags.h |    2 ++
  test-kernel-kamezawa/mm/page_alloc.c            |    8 ++++----
  2 files changed, 6 insertions(+), 4 deletions(-)

diff -puN include/linux/page-flags.h~eliminate-bitmap-opt include/linux/page-flags.h
--- test-kernel/include/linux/page-flags.h~eliminate-bitmap-opt	2004-09-08 18:48:43.115922392 +0900
+++ test-kernel-kamezawa/include/linux/page-flags.h	2004-09-08 18:48:43.120921632 +0900
@@ -239,6 +239,8 @@ extern unsigned long __read_page_state(u
  #define SetPagePrivate(page)	set_bit(PG_private, &(page)->flags)
  #define ClearPagePrivate(page)	clear_bit(PG_private, &(page)->flags)
  #define PagePrivate(page)	test_bit(PG_private, &(page)->flags)
+#define __SetPagePrivate(page)  __set_bit(PG_private, &(page)->flags)
+#define __ClearPagePrivate(page) __clear_bit(PG_private, &(page)->flags)

  #define PageWriteback(page)	test_bit(PG_writeback, &(page)->flags)
  #define SetPageWriteback(page)						\
diff -puN mm/page_alloc.c~eliminate-bitmap-opt mm/page_alloc.c
--- test-kernel/mm/page_alloc.c~eliminate-bitmap-opt	2004-09-08 18:48:43.118921936 +0900
+++ test-kernel-kamezawa/mm/page_alloc.c	2004-09-08 18:48:43.123921176 +0900
@@ -242,11 +242,11 @@ static inline void __free_pages_bulk (st
  		page_idx &= buddy_idx;
  		list_del(&buddy->lru);
  		/* for propriety of PG_private bit, we clear it */
-		ClearPagePrivate(buddy);
+		__ClearPagePrivate(buddy);
  	}
  	/* record the final order of the page */
  	coalesced_page = base + page_idx;
-	SetPagePrivate(coalesced_page);
+	__SetPagePrivate(coalesced_page);
  	set_page_order(coalesced_page,order);
  	list_add(&coalesced_page->lru, &zone->free_area[order].free_list);
  }
@@ -347,7 +347,7 @@ expand(struct zone *zone, struct page *p
  		list_add(&page[size].lru, &area->free_list);
  		/* Note: already have lock, we don't need to use atomic ops */
  		set_page_order(&page[size], high);
-		SetPagePrivate(&page[size]);
+		__SetPagePrivate(&page[size]);
  	}
  	return page;
  }
@@ -410,7 +410,7 @@ static struct page *__rmqueue(struct zon
  		page = list_entry(area->free_list.next, struct page, lru);
  		list_del(&page->lru);
  		/* Note: already have lock, we don't need to use atomic ops */
-		ClearPagePrivate(page);
+		__ClearPagePrivate(page);
  		zone->free_pages -= 1UL << order;
  		return expand(zone, page, order, current_order, area);
  	}

_

