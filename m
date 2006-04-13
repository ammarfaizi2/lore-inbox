Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbWDMXyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWDMXyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWDMXye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:54:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32470 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965053AbWDMXyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:54:33 -0400
Date: Thu, 13 Apr 2006 16:54:11 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Lee Schermerhorn <lee.schermerhorn@hp.com>, linux-mm@kvack.org,
       Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20060413235411.15398.44170.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/5] Swapless V2: try_to_unmap() - Rename ignrefs to "migration"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try_to_unmap: Rename ignore_refs to migrate

migrate is a better name since we implement special handling for
page migration later.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-rc1-mm2/mm/rmap.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/mm/rmap.c	2006-04-02 20:22:10.000000000 -0700
+++ linux-2.6.17-rc1-mm2/mm/rmap.c	2006-04-13 12:56:10.000000000 -0700
@@ -578,7 +578,7 @@ void page_remove_rmap(struct page *page)
  * repeatedly from either try_to_unmap_anon or try_to_unmap_file.
  */
 static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
-				int ignore_refs)
+				int migration)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -602,7 +602,7 @@ static int try_to_unmap_one(struct page 
 	 */
 	if ((vma->vm_flags & VM_LOCKED) ||
 			(ptep_clear_flush_young(vma, address, pte)
-				&& !ignore_refs)) {
+				&& !migration)) {
 		ret = SWAP_FAIL;
 		goto out_unmap;
 	}
@@ -736,7 +736,7 @@ static void try_to_unmap_cluster(unsigne
 	pte_unmap_unlock(pte - 1, ptl);
 }
 
-static int try_to_unmap_anon(struct page *page, int ignore_refs)
+static int try_to_unmap_anon(struct page *page, int migration)
 {
 	struct anon_vma *anon_vma;
 	struct vm_area_struct *vma;
@@ -747,7 +747,7 @@ static int try_to_unmap_anon(struct page
 		return ret;
 
 	list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
-		ret = try_to_unmap_one(page, vma, ignore_refs);
+		ret = try_to_unmap_one(page, vma, migration);
 		if (ret == SWAP_FAIL || !page_mapped(page))
 			break;
 	}
@@ -764,7 +764,7 @@ static int try_to_unmap_anon(struct page
  *
  * This function is only called from try_to_unmap for object-based pages.
  */
-static int try_to_unmap_file(struct page *page, int ignore_refs)
+static int try_to_unmap_file(struct page *page, int migration)
 {
 	struct address_space *mapping = page->mapping;
 	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
@@ -778,7 +778,7 @@ static int try_to_unmap_file(struct page
 
 	spin_lock(&mapping->i_mmap_lock);
 	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, pgoff, pgoff) {
-		ret = try_to_unmap_one(page, vma, ignore_refs);
+		ret = try_to_unmap_one(page, vma, migration);
 		if (ret == SWAP_FAIL || !page_mapped(page))
 			goto out;
 	}
@@ -863,16 +863,16 @@ out:
  * SWAP_AGAIN	- we missed a mapping, try again later
  * SWAP_FAIL	- the page is unswappable
  */
-int try_to_unmap(struct page *page, int ignore_refs)
+int try_to_unmap(struct page *page, int migration)
 {
 	int ret;
 
 	BUG_ON(!PageLocked(page));
 
 	if (PageAnon(page))
-		ret = try_to_unmap_anon(page, ignore_refs);
+		ret = try_to_unmap_anon(page, migration);
 	else
-		ret = try_to_unmap_file(page, ignore_refs);
+		ret = try_to_unmap_file(page, migration);
 
 	if (!page_mapped(page))
 		ret = SWAP_SUCCESS;
