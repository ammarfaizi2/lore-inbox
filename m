Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVJNXAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVJNXAG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 19:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVJNXAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 19:00:06 -0400
Received: from silver.veritas.com ([143.127.12.111]:13989 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1750789AbVJNXAC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 19:00:02 -0400
Date: Fri, 14 Oct 2005 23:59:07 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Adam Litke <agl@us.ibm.com>, David Gibson <david@gibson.dropbear.id.au>,
       William Irwin <wli@holomorphy.com>, Ken Chen <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 22/21] mm: fix unmap_vmas with inner ptlock
Message-ID: <Pine.LNX.4.61.0510142355560.20844@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Oct 2005 22:59:58.0400 (UTC) FILETIME=[FFF83400:01C5D112]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

He who lectures others about hugetlbfs truncation might discover that
it's got screwed by his very own self.  I replaced zap_hugepage_range by
unmap_hugepage_range, overlooking that zap used "len" but unmap "end".

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 fs/hugetlbfs/inode.c |    6 +-----
 1 files changed, 1 insertion(+), 5 deletions(-)

--- mm21/fs/hugetlbfs/inode.c	2005-10-11 23:57:59.000000000 +0100
+++ mm22/fs/hugetlbfs/inode.c	2005-10-14 23:28:42.000000000 +0100
@@ -284,7 +284,6 @@ hugetlb_vmtruncate_list(struct prio_tree
 
 	vma_prio_tree_foreach(vma, &iter, root, h_pgoff, ULONG_MAX) {
 		unsigned long h_vm_pgoff;
-		unsigned long v_length;
 		unsigned long v_offset;
 
 		h_vm_pgoff = vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT);
@@ -295,11 +294,8 @@ hugetlb_vmtruncate_list(struct prio_tree
 		if (h_vm_pgoff >= h_pgoff)
 			v_offset = 0;
 
-		v_length = vma->vm_end - vma->vm_start;
-
 		unmap_hugepage_range(vma,
-				vma->vm_start + v_offset,
-				v_length - v_offset);
+				vma->vm_start + v_offset, vma->vm_end);
 	}
 }
 
