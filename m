Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbVKHVFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbVKHVFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbVKHVFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:05:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:32432 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030357AbVKHVFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:05:11 -0500
Date: Tue, 8 Nov 2005 13:04:58 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       torvalds@osdl.org, Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Magnus Damm <magnus.damm@gmail.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Paul Jackson <pj@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, Andi Kleen <ak@suse.de>
Message-Id: <20051108210447.31330.42320.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
References: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 8/8] Direct Migration V2: SWAP_REFERENCE for try_to_unmap()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Distinguish in try_to_umap_one between the case when the page is truly
unswappable from the case when the page was recently referenced.

The page migration code uses try_to_unmap_one and can avoid calling
try_to_unmap again if there was a persistent failure.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm1/include/linux/rmap.h
===================================================================
--- linux-2.6.14-mm1.orig/include/linux/rmap.h	2005-11-07 18:18:14.000000000 -0800
+++ linux-2.6.14-mm1/include/linux/rmap.h	2005-11-07 18:48:11.000000000 -0800
@@ -120,6 +120,7 @@ unsigned long page_address_in_vma(struct
  */
 #define SWAP_SUCCESS	0
 #define SWAP_AGAIN	1
-#define SWAP_FAIL	2
+#define SWAP_REFERENCE	2
+#define SWAP_FAIL	3
 
 #endif	/* _LINUX_RMAP_H */
Index: linux-2.6.14-mm1/mm/rmap.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/rmap.c	2005-11-07 18:18:14.000000000 -0800
+++ linux-2.6.14-mm1/mm/rmap.c	2005-11-07 18:48:11.000000000 -0800
@@ -546,16 +546,20 @@ static int try_to_unmap_one(struct page 
 
 	/*
 	 * If the page is mlock()d, we cannot swap it out.
-	 * If it's recently referenced (perhaps page_referenced
-	 * skipped over this mm) then we should reactivate it.
-	 *
 	 * Pages belonging to VM_RESERVED regions should not happen here.
 	 */
-	if ((vma->vm_flags & (VM_LOCKED|VM_RESERVED)) ||
-			ptep_clear_flush_young(vma, address, pte)) {
+	if (vma->vm_flags & (VM_LOCKED|VM_RESERVED)) {
 		ret = SWAP_FAIL;
 		goto out_unmap;
 	}
+	/*
+	 * If the page is recently referenced (perhaps page_referenced
+	 * skipped over this mm) then we may want to reactivate it.
+	 */
+	if (ptep_clear_flush_young(vma, address, pte)) {
+		ret = SWAP_REFERENCE;
+		goto out_unmap;
+	}
 
 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address, page_to_pfn(page));
@@ -706,7 +710,9 @@ static int try_to_unmap_anon(struct page
 
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
 		ret = try_to_unmap_one(page, vma);
-		if (ret == SWAP_FAIL || !page_mapped(page))
+		if (ret == SWAP_FAIL ||
+		    ret == SWAP_REFERENCE ||
+		    !page_mapped(page))
 			break;
 	}
 	spin_unlock(&anon_vma->lock);
@@ -737,7 +743,9 @@ static int try_to_unmap_file(struct page
 	spin_lock(&mapping->i_mmap_lock);
 	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
 		ret = try_to_unmap_one(page, vma);
-		if (ret == SWAP_FAIL || !page_mapped(page))
+		if (ret == SWAP_FAIL ||
+		    ret == SWAP_REFERENCE ||
+		    !page_mapped(page))
 			goto out;
 	}
 
@@ -822,7 +830,9 @@ out:
  *
  * SWAP_SUCCESS	- we succeeded in removing all mappings
  * SWAP_AGAIN	- we missed a mapping, try again later
+ * SWAP_REFERENCE - the page was recently referenced
  * SWAP_FAIL	- the page is unswappable
+ *
  */
 int try_to_unmap(struct page *page)
 {
Index: linux-2.6.14-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/vmscan.c	2005-11-07 18:38:59.000000000 -0800
+++ linux-2.6.14-mm1/mm/vmscan.c	2005-11-07 18:51:25.000000000 -0800
@@ -471,6 +471,7 @@ static int shrink_list(struct list_head 
 		 */
 		if (page_mapped(page) && mapping) {
 			switch (try_to_unmap(page)) {
+			case SWAP_REFERENCE:
 			case SWAP_FAIL:
 				goto activate_locked;
 			case SWAP_AGAIN:
@@ -689,8 +690,9 @@ int migrate_page_remove_references(struc
 	for(i = 0; i < 10 && page_mapped(page); i++) {
 		int rc = try_to_unmap(page);
 
-		if (rc == SWAP_SUCCESS)
+		if (rc == SWAP_SUCCESS || rc == SWAP_FAIL)
 			break;
+
 		/*
 		 * If there are other runnable processes then running
 		 * them may make it possible to unmap the page
