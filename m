Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbUEEF77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUEEF77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 01:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbUEEF77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 01:59:59 -0400
Received: from reformers.mr.itd.umich.edu ([141.211.93.147]:9654 "EHLO
	reformers.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S262100AbUEEF74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 01:59:56 -0400
Date: Wed, 5 May 2004 01:59:46 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@red.engin.umich.edu
To: Andrew Morton <akpm@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] partial prefetch for vma_prio_tree_next
Message-ID: <Pine.LNX.4.58.0405050157570.18870@red.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds prefetches for walking a vm_set.list. Adding
prefetches for prio tree traversals is tricky and may lead to
cache trashing. So this patch just adds prefetches only when
walking a vm_set.list.

I haven't done any benchmarks to show that this patch improves
performance. However, this patch should help to improve performance
when vm_set.lists are long, e.g., libc. Since we only prefetch
vmas that are guaranteed to be used in the near future, this patch
should not result in cache trashing, theoretically.

I didn't add any NULL checks before prefetching because prefetch.h
clearly says prefetch(0) is okay. Patch is against 2.6.6-rc3-mm1.


 mm/prio_tree.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff -puN mm/prio_tree.c~vma_prefetch mm/prio_tree.c
--- mmlinux-2.6/mm/prio_tree.c~vma_prefetch	2004-05-05 01:20:56.000000000 -0400
+++ mmlinux-2.6-jaya/mm/prio_tree.c	2004-05-05 01:21:53.000000000 -0400
@@ -628,28 +628,37 @@ struct vm_area_struct *vma_prio_tree_nex
 		 * First call is with NULL vma
 		 */
 		ptr = prio_tree_first(root, iter, begin, end);
-		if (ptr)
-			return prio_tree_entry(ptr, struct vm_area_struct,
+		if (ptr) {
+			next = prio_tree_entry(ptr, struct vm_area_struct,
 						shared.prio_tree_node);
-		else
+			prefetch(next->shared.vm_set.head);
+			return next;
+		} else
 			return NULL;
 	}

 	if (vma->shared.vm_set.parent) {
-		if (vma->shared.vm_set.head)
-			return vma->shared.vm_set.head;
+		if (vma->shared.vm_set.head) {
+			next = vma->shared.vm_set.head;
+			prefetch(next->shared.vm_set.list.next);
+			return next;
+		}
 	} else {
 		next = list_entry(vma->shared.vm_set.list.next,
 				struct vm_area_struct, shared.vm_set.list);
-		if (!next->shared.vm_set.head)
+		if (!next->shared.vm_set.head) {
+			prefetch(next->shared.vm_set.list.next);
 			return next;
+		}
 	}

 	ptr = prio_tree_next(root, iter, begin, end);
-	if (ptr)
-		return prio_tree_entry(ptr, struct vm_area_struct,
+	if (ptr) {
+		next = prio_tree_entry(ptr, struct vm_area_struct,
 					shared.prio_tree_node);
-	else
+		prefetch(next->shared.vm_set.head);
+		return next;
+	} else
 		return NULL;
 }
 EXPORT_SYMBOL(vma_prio_tree_next);

_
