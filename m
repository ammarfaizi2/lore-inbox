Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266786AbUJVFNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUJVFNN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 01:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270862AbUJVFMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 01:12:48 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:37058 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269557AbUJVE7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 00:59:05 -0400
Date: Thu, 21 Oct 2004 21:58:54 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: William Lee Irwin III <wli@holomorphy.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Hugepages demand paging V1 [4/4]: Numa patch
In-Reply-To: <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0410212158290.3524@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* NUMA enhancements (rough first implementation)
	* Do not begin search for huge page memory at the first node
	  but start at the current node and then search previous and
	  the following nodes for memory.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9/mm/hugetlb.c
===================================================================
--- linux-2.6.9.orig/mm/hugetlb.c	2004-10-21 20:39:50.000000000 -0700
+++ linux-2.6.9/mm/hugetlb.c	2004-10-21 20:44:12.000000000 -0700
@@ -28,15 +28,30 @@
 	free_huge_pages_node[nid]++;
 }

-static struct page *dequeue_huge_page(void)
+static struct page *dequeue_huge_page(struct vm_area_struct *vma, unsigned long addr)
 {
 	int nid = numa_node_id();
+	int tid, nid2;
 	struct page *page = NULL;

 	if (list_empty(&hugepage_freelists[nid])) {
-		for (nid = 0; nid < MAX_NUMNODES; ++nid)
-			if (!list_empty(&hugepage_freelists[nid]))
-				break;
+		/* Prefer the neighboring nodes */
+		for (tid =1 ; tid < MAX_NUMNODES; tid++) {
+
+			/* Is there space in a following node ? */
+			nid2 = (nid + tid) % MAX_NUMNODES;
+			if (mpol_node_valid(nid2, vma, addr) &&
+				!list_empty(&hugepage_freelists[nid2]))
+					break;
+
+			/* or in an previous node ? */
+			if (tid > nid) continue;
+			nid2 = nid - tid;
+			if (mpol_node_valid(nid2, vma, addr) &&
+				!list_empty(&hugepage_freelists[nid2]))
+					break;
+		}
+		nid = nid2;
 	}
 	if (nid >= 0 && nid < MAX_NUMNODES &&
 	    !list_empty(&hugepage_freelists[nid])) {
@@ -75,13 +90,13 @@
 	spin_unlock(&hugetlb_lock);
 }

-struct page *alloc_huge_page(void)
+struct page *alloc_huge_page(struct vm_area_struct *vma, unsigned long addr)
 {
 	struct page *page;
 	int i;

 	spin_lock(&hugetlb_lock);
-	page = dequeue_huge_page();
+	page = dequeue_huge_page(vma, addr);
 	if (!page) {
 		spin_unlock(&hugetlb_lock);
 		return NULL;
@@ -181,7 +196,7 @@
 	spin_lock(&hugetlb_lock);
 	try_to_free_low(count);
 	while (count < nr_huge_pages) {
-		struct page *page = dequeue_huge_page();
+		struct page *page = dequeue_huge_page(NULL, 0);
 		if (!page)
 			break;
 		update_and_free_page(page);
@@ -255,7 +270,7 @@
 retry:
 	page = find_get_page(mapping, idx);
 	if (!page) {
-		page = alloc_huge_page();
+		page = alloc_huge_page(vma, addr);
 		if (!page)
 			/*
 			 * with strict overcommit accounting, we should never
Index: linux-2.6.9/include/linux/hugetlb.h
===================================================================
--- linux-2.6.9.orig/include/linux/hugetlb.h	2004-10-21 20:44:10.000000000 -0700
+++ linux-2.6.9/include/linux/hugetlb.h	2004-10-21 20:44:56.000000000 -0700
@@ -31,7 +31,7 @@
 				pmd_t *pmd, int write);
 int is_aligned_hugepage_range(unsigned long addr, unsigned long len);
 int pmd_huge(pmd_t pmd);
-struct page *alloc_huge_page(void);
+struct page *alloc_huge_page(struct vm_area_struct *vma, unsigned long addr);
 void free_huge_page(struct page *);

 extern unsigned long max_huge_pages;

