Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbUKVLUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbUKVLUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 06:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbUKVLSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 06:18:02 -0500
Received: from holomorphy.com ([207.189.100.168]:49559 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262086AbUKVLRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 06:17:18 -0500
Date: Mon, 22 Nov 2004 03:17:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [bugfix] fix do_wp_page_mk_pte_writable() in 2.6.10-rc2-mm3
Message-ID: <20041122111709.GD2714@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 10:39:29PM -0800, Andrew Morton wrote:
> 4level-core-patch.patch
>   4level core patch

vma->vm_ops->page_mkwrite() is supposed to be able to sleep, but this
function doesn't unmap the pte across the call and worse yet, reuses
the pte across a drop and reacquisition of ->page_table_lock.


Index: mm3-2.6.10-rc2/mm/memory.c
===================================================================
--- mm3-2.6.10-rc2.orig/mm/memory.c	2004-11-22 02:54:12.815541779 -0800
+++ mm3-2.6.10-rc2/mm/memory.c	2004-11-22 02:57:22.095766811 -0800
@@ -1268,6 +1268,7 @@
 static inline int do_wp_page_mk_pte_writable(struct mm_struct *mm,
 					     struct vm_area_struct *vma,
 					     unsigned long address,
+					     pmd_t *pmd,
 					     pte_t *page_table,
 					     struct page *old_page,
 					     pte_t pte)
@@ -1279,6 +1280,7 @@
 	if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
 		/* Notify the page owner without the lock held so they can
 		 * sleep if they want to */
+		pte_unmap(page_table);
 		spin_unlock(&mm->page_table_lock);
 
 		if (vma->vm_ops->page_mkwrite(vma, old_page) < 0)
@@ -1291,6 +1293,7 @@
 		 * return, as we can count on the MMU to tell us if they didn't
 		 * also make it writable
 		 */
+		page_table = pte_offset_map(pmd, address);
 		if (!pte_same(*page_table, pte))
 			goto minor_fault;
 	}
@@ -1352,7 +1355,7 @@
 		unlock_page(old_page);
 		if (reuse)
 			/* We can just make the PTE writable */
-			return do_wp_page_mk_pte_writable(mm, vma, address,
+			return do_wp_page_mk_pte_writable(mm, vma, address, pmd,
 							  page_table, old_page,
 							  pte);
 	}
