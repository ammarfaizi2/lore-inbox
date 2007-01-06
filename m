Return-Path: <linux-kernel-owner+w=401wt.eu-S1751208AbXAFH1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbXAFH1e (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 02:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbXAFH1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 02:27:11 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:59141 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751204AbXAFH1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 02:27:09 -0500
Message-ID: <368068421.78607@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20070106072729.755581784@mail.ustc.edu.cn>
References: <20070106072626.911640026@mail.ustc.edu.cn>
User-Agent: quilt/0.45-1
Date: Sat, 06 Jan 2007 15:26:29 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] readahead: context based method: update ra_min
Content-Disposition: inline; filename=readahead-context-based-method-update-ra_min.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Classify the 4 cases into 2 classes, and assign proper ra_min for them.
Also update comments correspondly.

Signed-off-by: Fengguang Wu <wfg@mail.ustc.edu.cn>

---
 mm/readahead.c |   49 +++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

--- linux-2.6.20-rc3-mm1.orig/mm/readahead.c
+++ linux-2.6.20-rc3-mm1/mm/readahead.c
@@ -1285,17 +1285,26 @@ static int
 try_context_based_readahead(struct address_space *mapping,
 			struct file_ra_state *ra,
 			struct page *page, pgoff_t offset,
-			unsigned long ra_min, unsigned long ra_max)
+			unsigned long req_size, unsigned long ra_max)
 {
 	pgoff_t start;
+	unsigned long ra_min;
 	unsigned long ra_size;
 	unsigned long la_size;
 
-	/* Check if there is a segment of history pages, and its end index.
+	/*
+	 * Check if there is a segment of history pages, and its end index.
 	 * Based on which we decide whether and where to start read-ahead.
-	 *
-	 * Case 1: we have a current page.
-	 * 	   Search forward for a nearby hole.
+	 */
+
+	/*
+	 * Select a reasonable large initial size for sequential reads.
+	 */
+	ra_min = min(req_size * 4, mapping->backing_dev_info->ra_pages0);
+
+	/*
+	 * Case s1: we have a current page.
+	 * =======> Search forward for a nearby hole.
 	 */
 	read_lock_irq(&mapping->tree_lock);
 	if (page) {
@@ -1308,8 +1317,9 @@ try_context_based_readahead(struct addre
 		return -1;
 	}
 
-	/* Case 2: current page is missing; previous page is present.
-	 *         Just do read-ahead from the current index on.
+	/*
+	 * Case s2: current page is missing; previous page is present.
+	 * =======> Just do read-ahead from the current index on.
 	 * There's clear sign of sequential reading. It can be
 	 * 	a) seek => read => this read
 	 * 	b) cache hit read(s) => this read
@@ -1321,26 +1331,33 @@ try_context_based_readahead(struct addre
 		goto has_history_pages;
 	}
 
-	/* Case 2x: the same context info as 2.
-	 * It can be the early stage of semi-sequential reads(interleaved/nfsd),
-	 * or an ugly random one.  So be conservative.
+	/*
+	 * Not an obvious sequential read:
+	 * select a conservative initial size, plus user prefered agressiveness.
+	 */
+	ra_min = min(req_size, MIN_RA_PAGES) +
+		 readahead_hit_rate * 8192 / PAGE_CACHE_SIZE;
+
+	/*
+	 * Case r1: the same context info as s2, but not that obvious.
+	 * =======> The same action as s2, but be conservative.
+	 * It can be the early stage of intermixed sequential reads,
+	 * or an ugly random one.
 	 */
 	if (readahead_hit_rate && __probe_page(mapping, offset - 1)) {
 		start = offset;
-		if (ra_min > 2 * readahead_hit_rate)
-		    ra_min = 2 * readahead_hit_rate;
 		goto has_history_pages;
 	}
 
-	/* Case 3: no current/previous pages;
-	 *         sparse read-ahead is enabled: ok, be aggressive.
-	 *         Check if there's any adjecent history pages.
+	/*
+	 * Case r2: no current/previous pages; sparse read-ahead is enabled.
+	 * =======> Do sparse read-ahead if there are adjecent history pages.
 	 */
 	if (readahead_hit_rate > 1) {
 		start = radix_tree_scan_data_backward(&mapping->page_tree,
 							       offset, ra_min);
 		if (start != ULONG_MAX && offset - start < ra_min) {
-			ra_min += offset - start;
+			ra_min *= 2;
 			offset = ++start; /* pretend the request starts here */
 			goto has_history_pages;
 		}

--
