Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbUCVRFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 12:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbUCVRFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 12:05:36 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:12044 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262120AbUCVRFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 12:05:33 -0500
Date: Mon, 22 Mar 2004 17:05:33 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: VMA_MERGING_FIXUP and patch
Message-ID: <Pine.LNX.4.44.0403221640230.11645-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a reminder that you still have several #if VMA_MERGING_FIXUPs
in your 2.6.5-rc2-aa1 tree, so mprotects and mremaps are not merging
vmas at all.

I can understand if you'd prefer to leave the mremaps that way,
at least for now.  (I do have code to decide whether any page is
shared, will post later in anobjrmap 7/6, you could use the same
to allow mremap vma merging if unproblematic.)  But I think you
ought to get to merging the mprotects, aren't there apps which
will give you a frightening number of vmas unless merged?

Here's some minor updates (no hurry) to objrmap.c,
mirroring recentish s390 mods to mainline rmap.c:
the page_test_and_clear_dirty I mentioned before.

Hmm, I wonder, is that safe to be calling set_page_dirty
from inside the page rmap lock?  Andrew?

Hugh

--- 2.6.5-rc2-aa1/mm/objrmap.c	2004-03-22 11:38:55.000000000 +0000
+++ linux/mm/objrmap.c	2004-03-22 16:34:29.421216936 +0000
@@ -212,7 +212,7 @@ int fastcall page_referenced(struct page
 	BUG_ON(!page->mapping);
 
 	if (page_test_and_clear_young(page))
-		mark_page_accessed(page);
+		referenced++;
 
 	if (TestClearPageReferenced(page))
 		referenced++;
@@ -327,8 +327,11 @@ void fastcall page_remove_rmap(struct pa
 	if (!page_mapped(page))
 		goto out_unlock;
 
-	if (!--page->mapcount)
+	if (!--page->mapcount) {
+		if (page_test_and_clear_dirty(page))
+			set_page_dirty(page);
 		dec_page_state(nr_mapped);
+	}
 
 	if (PageAnon(page))
 		anon_vma_page_unlink(page);
@@ -520,6 +523,8 @@ int fastcall try_to_unmap(struct page * 
 		ret = try_to_unmap_anon(page);
 
 	if (!page_mapped(page)) {
+		if (page_test_and_clear_dirty(page))
+			set_page_dirty(page);
 		dec_page_state(nr_mapped);
 		ret = SWAP_SUCCESS;
 	}

