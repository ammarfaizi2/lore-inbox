Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966409AbWKOHwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966409AbWKOHwj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966299AbWKOHvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:51:06 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:49869 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S966409AbWKOHui (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:38 -0500
Message-ID: <363577023.13886@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075027.139255636@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:16 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 09/28] readahead: rescue_pages()
Content-Disposition: inline; filename=readahead-rescue_pages.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce function rescue_pages() to protect pages in danger of thrashing.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc5-mm1.orig/mm/readahead.c
+++ linux-2.6.19-rc5-mm1/mm/readahead.c
@@ -708,6 +708,96 @@ unsigned long max_sane_readahead(unsigne
 }
 
 /*
+ * Adaptive read-ahead.
+ *
+ * Good read patterns are compact both in space and time. The read-ahead logic
+ * tries to grant larger read-ahead size to better readers under the constraint
+ * of system memory and load pressure.
+ *
+ * It employs two methods to estimate the max thrashing safe read-ahead size:
+ *   1. state based   - the default one
+ *   2. context based - the failsafe one
+ * The integration of the dual methods has the merit of being agile and robust.
+ * It makes the overall design clean: special cases are handled in general by
+ * the stateless method, leaving the stateful one simple and fast.
+ *
+ * To improve throughput and decrease read delay, the logic 'looks ahead'.
+ * In most read-ahead chunks, one page will be selected and tagged with
+ * PG_readahead. Later when the page with PG_readahead is read, the logic
+ * will be notified to submit the next read-ahead chunk in advance.
+ *
+ *                 a read-ahead chunk
+ *    +-----------------------------------------+
+ *    |       # PG_readahead                    |
+ *    +-----------------------------------------+
+ *            ^ When this page is read, notify me for the next read-ahead.
+ *
+ */
+
+#ifdef CONFIG_ADAPTIVE_READAHEAD
+
+/*
+ * Move pages in danger (of thrashing) to the head of inactive_list.
+ * Not expected to happen frequently.
+ *
+ * @page will be skipped: it's grabbed and won't die away.
+ * The following @nr_pages-1 pages will be protected.
+ */
+static unsigned long rescue_pages(struct page *page, unsigned long nr_pages)
+{
+	int pgrescue = 0;
+	pgoff_t index = page_index(page);
+	struct address_space *mapping = page_mapping(page);
+	struct page *grabbed_page = NULL;
+	struct zone *zone;
+
+	dprintk("rescue_pages(ino=%lu, index=%lu nr=%lu)\n",
+			mapping->host->i_ino, index, nr_pages);
+
+	for(;;) {
+		zone = page_zone(page);
+		spin_lock_irq(&zone->lru_lock);
+
+		if (!PageLRU(page))
+			goto out_unlock;
+
+		while (page_mapping(page) == mapping &&
+				page_index(page) == index) {
+			struct page *the_page = page;
+			page = list_entry((page)->lru.prev, struct page, lru);
+			if (!PageActive(the_page) &&
+					!PageLocked(the_page) &&
+					page_count(the_page) == 1) {
+				list_move(&the_page->lru, &zone->inactive_list);
+				pgrescue++;
+			}
+			index++;
+			if (!--nr_pages)
+				goto out_unlock;
+		}
+
+		spin_unlock_irq(&zone->lru_lock);
+		cond_resched();
+
+		if (grabbed_page)
+			page_cache_release(grabbed_page);
+		grabbed_page = page = find_get_page(mapping, index);
+		if (!page)
+			goto out;
+	}
+
+out_unlock:
+	spin_unlock_irq(&zone->lru_lock);
+out:
+	if (grabbed_page)
+		page_cache_release(grabbed_page);
+	ra_account(NULL, RA_EVENT_READAHEAD_RESCUE, pgrescue);
+	return nr_pages;
+}
+
+#endif /* CONFIG_ADAPTIVE_READAHEAD */
+
+/*
  * Read-ahead events accounting.
  */
 #ifdef CONFIG_DEBUG_READAHEAD

--
