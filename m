Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbWEXL06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbWEXL06 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbWEXL0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:26:43 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:59008 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932686AbWEXLTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:07 -0400
Message-ID: <348469540.21464@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111901.976888971@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:12:56 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 10/33] readahead: support functions
Content-Disposition: inline; filename=readahead-support-functions.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several support functions of adaptive read-ahead.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 include/linux/mm.h |   11 +++++
 mm/readahead.c     |  107 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

--- linux-2.6.17-rc4-mm3.orig/include/linux/mm.h
+++ linux-2.6.17-rc4-mm3/include/linux/mm.h
@@ -1029,6 +1029,17 @@ void handle_ra_miss(struct address_space
 		    struct file_ra_state *ra, pgoff_t offset);
 unsigned long max_sane_readahead(unsigned long nr);
 
+#ifdef CONFIG_ADAPTIVE_READAHEAD
+extern int readahead_ratio;
+#else
+#define readahead_ratio 1
+#endif /* CONFIG_ADAPTIVE_READAHEAD */
+
+static inline int prefer_adaptive_readahead(void)
+{
+	return readahead_ratio >= 10;
+}
+
 /* Do stack extension */
 extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
 #ifdef CONFIG_IA64
--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -683,6 +683,113 @@ unsigned long max_sane_readahead(unsigne
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
+ * The nature of read-ahead allows false tests to occur occasionally.
+ * Here we just do not bother to call get_page(), it's meaningless anyway.
+ */
+static inline struct page *__find_page(struct address_space *mapping,
+							pgoff_t offset)
+{
+	return radix_tree_lookup(&mapping->page_tree, offset);
+}
+
+static inline struct page *find_page(struct address_space *mapping,
+							pgoff_t offset)
+{
+	struct page *page;
+
+	read_lock_irq(&mapping->tree_lock);
+	page = __find_page(mapping, offset);
+	read_unlock_irq(&mapping->tree_lock);
+	return page;
+}
+
+/*
+ * Move pages in danger (of thrashing) to the head of inactive_list.
+ * Not expected to happen frequently.
+ */
+static unsigned long rescue_pages(struct page *page, unsigned long nr_pages)
+{
+	int pgrescue;
+	pgoff_t index;
+	struct zone *zone;
+	struct address_space *mapping;
+
+	BUG_ON(!nr_pages || !page);
+	pgrescue = 0;
+	index = page_index(page);
+	mapping = page_mapping(page);
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
+			page = next_page(page);
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
+
+		cond_resched();
+		page = find_page(mapping, index);
+		if (!page)
+			goto out;
+	}
+out_unlock:
+	spin_unlock_irq(&zone->lru_lock);
+out:
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
