Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266794AbUFYWfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266794AbUFYWfr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 18:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUFYWfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 18:35:46 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:24113 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266794AbUFYWfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 18:35:33 -0400
Date: Fri, 25 Jun 2004 23:35:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: "Vladimir V. Saveliev" <vs@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] anon_vma list locking bug
Message-ID: <Pine.LNX.4.44.0406252329540.19814-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Saveliev reported anon_vma_unlink list_del BUG (LKML 24 June).
His testing is still in progress, but we believe it comes from a nasty
locking deficiency I introduced in 2.6.7's anon_vma_prepare.

Andrea's original anon_vma_prepare was fine, it needed no anon_vma lock
because it was always linking a freshly allocated structure; but my
find_mergeable enhancement let it adopt a neighbouring anon_vma, which
of course needs locking against a racing linkage from another mm -
which the earlier adjust_vma fix seems to have made more likely.

Does anon_vma->lock nest inside or outside page_table_lock?  Inside, but
that's not obvious without a lock ordering list: instead of listing the
order here, update the list in filemap.c; but a separate patch because
that's less urgent and more likely to get wrong or provoke controversy.

(Could do it with anon_vma lock after dropping page_table_lock, but
a long comment explaining why some code is safe suggests it's not.)

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.7/mm/rmap.c	2004-06-16 06:21:02.000000000 +0100
+++ linux/mm/rmap.c	2004-06-25 22:15:41.164841904 +0100
@@ -18,14 +18,11 @@
  */
 
 /*
- * Locking:
- * - the page->mapcount field is protected by the PG_maplock bit,
- *   which nests within the mm->page_table_lock,
- *   which nests within the page lock.
- * - because swapout locking is opposite to the locking order
- *   in the page fault path, the swapout path uses trylocks
- *   on the mm->page_table_lock
+ * Locking: see "Lock ordering" summary in filemap.c.
+ * In swapout, page_map_lock is held on entry to page_referenced and
+ * try_to_unmap, so they trylock for i_mmap_lock and page_table_lock.
  */
+
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
@@ -79,8 +76,12 @@ int anon_vma_prepare(struct vm_area_stru
 		/* page_table_lock to protect against threads */
 		spin_lock(&mm->page_table_lock);
 		if (likely(!vma->anon_vma)) {
+			if (!allocated)
+				spin_lock(&anon_vma->lock);
 			vma->anon_vma = anon_vma;
 			list_add(&vma->anon_vma_node, &anon_vma->head);
+			if (!allocated)
+				spin_unlock(&anon_vma->lock);
 			allocated = NULL;
 		}
 		spin_unlock(&mm->page_table_lock);

