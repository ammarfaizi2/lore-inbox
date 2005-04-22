Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVDVBRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVDVBRB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 21:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVDVBRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 21:17:01 -0400
Received: from holomorphy.com ([66.93.40.71]:56289 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261905AbVDVBQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 21:16:59 -0400
Date: Thu, 21 Apr 2005 18:16:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: sync_page() smp_mb() comment
Message-ID: <20050422011658.GE2104@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The smp_mb() is becaus sync_page() doesn't have PG_locked while it
accesses page_mapping(page). The comments in the patch (the entire
patch is the addition of this comment) try to explain further how
and why smp_mb() is used.


mm/filemap.c: 93595c327bbdc43fcea91b513fd750d1a73edfec
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -139,7 +139,25 @@ static int sync_page(void *word)
 	page = container_of((page_flags_t *)word, struct page, flags);
 
 	/*
-	 * FIXME, fercrissake.  What is this barrier here for?
+	 * page_mapping() is being called without PG_locked held.
+	 * Some knowledge of the state and use of the page is used to
+	 * reduce the requirements down to a memory barrier.
+	 * The danger here is of a stale page_mapping() return value
+	 * indicating a struct address_space different from the one it's
+	 * associated with when it is associated with one.
+	 * After smp_mb(), it's either the correct page_mapping() for
+	 * the page, or an old page_mapping() and the page's own
+	 * page_mapping() has gone NULL.
+	 * The ->sync_page() address_space operation must tolerate
+	 * page_mapping() going NULL. By an amazing coincidence,
+	 * this comes about because none of the users of the page
+	 * in the ->sync_page() methods make essential use of the
+	 * page_mapping(), merely passing the page down to the backing
+	 * device's unplug functions when it's non-NULL, which in turn
+	 * ignore it for all cases but swap, where only page->private is
+	 * of interest. When page_mapping() does go NULL, the entire
+	 * call stack gracefully ignores the page and returns.
+	 * -- wli
 	 */
 	smp_mb();
 	mapping = page_mapping(page);
