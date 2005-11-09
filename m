Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbVKIOPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVKIOPc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 09:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbVKIOP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 09:15:29 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:28032 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1750873AbVKIOO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 09:14:59 -0500
Message-Id: <20051109141543.388245000@localhost.localdomain>
References: <20051109134938.757187000@localhost.localdomain>
Date: Wed, 09 Nov 2005 21:49:52 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 14/16] readahead: laptop mode support
Content-Disposition: inline; filename=readahead-laptop-mode.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the laptop drive is spinned down, defer look-ahead to spin up time.

The implementation employs a poll based method, for performance is not a
concern in this code path. The poll interval is set to 64KB, which should
be small enough for movies/musics.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/writeback.h |    6 ++++++
 mm/page-writeback.c       |    2 +-
 mm/readahead.c            |   30 ++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

--- linux-2.6.14-mm1.orig/include/linux/writeback.h
+++ linux-2.6.14-mm1/include/linux/writeback.h
@@ -90,6 +90,12 @@ void laptop_io_completion(void);
 void laptop_sync_completion(void);
 void throttle_vm_writeout(void);
 
+extern struct timer_list laptop_mode_wb_timer;
+static inline int laptop_spinned_down(void)
+{
+	return !timer_pending(&laptop_mode_wb_timer);
+}
+
 /* These are exported to sysctl. */
 extern int dirty_background_ratio;
 extern int vm_dirty_ratio;
--- linux-2.6.14-mm1.orig/mm/page-writeback.c
+++ linux-2.6.14-mm1/mm/page-writeback.c
@@ -369,7 +369,7 @@ static void wb_timer_fn(unsigned long un
 static void laptop_timer_fn(unsigned long unused);
 
 static DEFINE_TIMER(wb_timer, wb_timer_fn, 0, 0);
-static DEFINE_TIMER(laptop_mode_wb_timer, laptop_timer_fn, 0, 0);
+DEFINE_TIMER(laptop_mode_wb_timer, laptop_timer_fn, 0, 0);
 
 /*
  * Periodic writeback of "old" data.
--- linux-2.6.14-mm1.orig/mm/readahead.c
+++ linux-2.6.14-mm1/mm/readahead.c
@@ -14,6 +14,7 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
+#include <linux/writeback.h>
 
 /* The default number of max/min read-ahead pages. */
 #define KB(size)	(((size)*1024 + PAGE_CACHE_SIZE-1) / PAGE_CACHE_SIZE)
@@ -1115,6 +1116,30 @@ out:
 }
 
 /*
+ * Set a new look-ahead mark at @new_index.
+ * Return 0 if the new mark is successfully set.
+ */
+static inline int renew_lookahead(struct address_space *mapping,
+				struct file_ra_state *ra,
+				pgoff_t index, pgoff_t new_index)
+{
+	struct page *page;
+
+	if (index == ra->lookahead_index &&
+			new_index >= ra->readahead_index)
+		return 1;
+
+	page = find_page(mapping, new_index);
+	if (!page)
+		return 1;
+
+	SetPageReadahead(page);
+	if (ra->lookahead_index == index)
+		ra->lookahead_index = new_index;
+	return 0;
+}
+
+/*
  * State based calculation of read-ahead request.
  *
  * This figure shows the meaning of file_ra_state members:
@@ -1962,6 +1987,11 @@ page_cache_readahead_adaptive(struct add
 							end_index - index);
 			return 0;
 		}
+		if (laptop_mode && laptop_spinned_down()) {
+			if (!renew_lookahead(mapping, ra, index,
+						index + LAPTOP_POLL_INTERVAL))
+				return 0;
+		}
 	}
 
 	if (page)

--
