Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbVKNVsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVKNVsE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbVKNVsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:48:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:22157 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751029AbVKNVsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:48:02 -0500
Date: Mon, 14 Nov 2005 13:46:50 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Adam Litke <agl@us.ibm.com>
cc: linux-mm@kvack.org, ak@suse.de, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com, wli@holomorphy.com
Subject: Re: [RFC] NUMA memory policy support for HUGE pages
In-Reply-To: <1131980814.13502.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0511141340160.4663@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0511111051080.20589@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.62.0511111225100.21071@schroedinger.engr.sgi.com>
 <1131980814.13502.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is V2 of the patch.

Changes:

- Cleaned up by folding find_or_alloc() into hugetlb_no_page().

- Consolidate common code in the memory policy layer by creating a new 
  function interleave_nid().

Patch on top of allocation patch and the cpuset patch that Andrew already 
accepted.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm2/mm/mempolicy.c
===================================================================
--- linux-2.6.14-mm2.orig/mm/mempolicy.c	2005-11-14 12:51:23.000000000 -0800
+++ linux-2.6.14-mm2/mm/mempolicy.c	2005-11-14 13:16:51.000000000 -0800
@@ -1181,6 +1181,34 @@ static unsigned offset_il_node(struct me
 	return nid;
 }
 
+/* Caculate a node number for interleave */
+static inline unsigned interleave_nid(struct mempolicy *pol,
+		 struct vm_area_struct *vma, unsigned long addr, int shift)
+{
+	if (vma) {
+		unsigned long off;
+
+		off = vma->vm_pgoff;
+		off += (addr - vma->vm_start) >> shift;
+		return offset_il_node(pol, vma, off);
+	} else
+		return interleave_nodes(pol);
+}
+
+/* Return a zonelist suitable for a huge page allocation. */
+struct zonelist *huge_zonelist(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct mempolicy *pol = get_vma_policy(current, vma, addr);
+
+	if (pol->policy == MPOL_INTERLEAVE) {
+		unsigned nid;
+
+		nid = interleave_nid(pol, vma, addr, HPAGE_SHIFT);
+		return NODE_DATA(nid)->node_zonelists + gfp_zone(GFP_HIGHUSER);
+	}
+	return zonelist_policy(GFP_HIGHUSER, pol);
+}
+
 /* Allocate a page in interleaved policy.
    Own path because it needs to do special accounting. */
 static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
@@ -1229,15 +1257,8 @@ alloc_page_vma(gfp_t gfp, struct vm_area
 
 	if (unlikely(pol->policy == MPOL_INTERLEAVE)) {
 		unsigned nid;
-		if (vma) {
-			unsigned long off;
-			off = vma->vm_pgoff;
-			off += (addr - vma->vm_start) >> PAGE_SHIFT;
-			nid = offset_il_node(pol, vma, off);
-		} else {
-			/* fall back to process interleaving */
-			nid = interleave_nodes(pol);
-		}
+
+		nid = interleave_nid(pol, vma, addr, PAGE_SHIFT);
 		return alloc_page_interleave(gfp, 0, nid);
 	}
 	return __alloc_pages(gfp, 0, zonelist_policy(gfp, pol));
Index: linux-2.6.14-mm2/mm/hugetlb.c
===================================================================
--- linux-2.6.14-mm2.orig/mm/hugetlb.c	2005-11-14 12:51:23.000000000 -0800
+++ linux-2.6.14-mm2/mm/hugetlb.c	2005-11-14 13:37:16.000000000 -0800
@@ -33,11 +33,12 @@ static void enqueue_huge_page(struct pag
 	free_huge_pages_node[nid]++;
 }
 
-static struct page *dequeue_huge_page(void)
+static struct page *dequeue_huge_page(struct vm_area_struct *vma,
+				unsigned long address)
 {
 	int nid = numa_node_id();
 	struct page *page = NULL;
-	struct zonelist *zonelist = NODE_DATA(nid)->node_zonelists;
+	struct zonelist *zonelist = huge_zonelist(vma, address);
 	struct zone **z;
 
 	for (z = zonelist->zones; *z; z++) {
@@ -83,13 +84,13 @@ void free_huge_page(struct page *page)
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
@@ -192,7 +193,7 @@ static unsigned long set_max_huge_pages(
 	spin_lock(&hugetlb_lock);
 	try_to_free_low(count);
 	while (count < nr_huge_pages) {
-		struct page *page = dequeue_huge_page();
+		struct page *page = dequeue_huge_page(NULL, 0);
 		if (!page)
 			break;
 		update_and_free_page(page);
@@ -361,42 +362,6 @@ void unmap_hugepage_range(struct vm_area
 	flush_tlb_range(vma, start, end);
 }
 
-static struct page *find_or_alloc_huge_page(struct address_space *mapping,
-				unsigned long idx, int shared)
-{
-	struct page *page;
-	int err;
-
-retry:
-	page = find_lock_page(mapping, idx);
-	if (page)
-		goto out;
-
-	if (hugetlb_get_quota(mapping))
-		goto out;
-	page = alloc_huge_page();
-	if (!page) {
-		hugetlb_put_quota(mapping);
-		goto out;
-	}
-
-	if (shared) {
-		err = add_to_page_cache(page, mapping, idx, GFP_KERNEL);
-		if (err) {
-			put_page(page);
-			hugetlb_put_quota(mapping);
-			if (err == -EEXIST)
-				goto retry;
-			page = NULL;
-		}
-	} else {
-		/* Caller expects a locked page */
-		lock_page(page);
-	}
-out:
-	return page;
-}
-
 static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, pte_t *ptep, pte_t pte)
 {
@@ -414,7 +379,7 @@ static int hugetlb_cow(struct mm_struct 
 	}
 
 	page_cache_get(old_page);
-	new_page = alloc_huge_page();
+	new_page = alloc_huge_page(vma, address);
 
 	if (!new_page) {
 		page_cache_release(old_page);
@@ -463,10 +428,32 @@ int hugetlb_no_page(struct mm_struct *mm
 	 * Use page lock to guard against racing truncation
 	 * before we get page_table_lock.
 	 */
-	page = find_or_alloc_huge_page(mapping, idx,
-			vma->vm_flags & VM_SHARED);
-	if (!page)
-		goto out;
+retry:
+	page = find_lock_page(mapping, idx);
+	if (!page) {
+		if (hugetlb_get_quota(mapping))
+			goto out;
+
+		page = alloc_huge_page(vma, address);
+		if (!page) {
+			hugetlb_put_quota(mapping);
+			goto out;
+		}
+
+		if (vma->vm_flags & VM_SHARED) {
+			int err;
+
+			err = add_to_page_cache(page, mapping, idx, GFP_KERNEL);
+			if (err) {
+				put_page(page);
+				hugetlb_put_quota(mapping);
+				if (err == -EEXIST)
+					goto retry;
+				goto out;
+			}
+		}
+		lock_page(page);
+	}
 
 	BUG_ON(!PageLocked(page));
 
Index: linux-2.6.14-mm2/include/linux/mempolicy.h
===================================================================
--- linux-2.6.14-mm2.orig/include/linux/mempolicy.h	2005-11-14 12:51:22.000000000 -0800
+++ linux-2.6.14-mm2/include/linux/mempolicy.h	2005-11-14 12:51:23.000000000 -0800
@@ -159,6 +159,8 @@ extern void numa_policy_init(void);
 extern void numa_policy_rebind(const nodemask_t *old, const nodemask_t *new);
 extern struct mempolicy default_policy;
 extern unsigned next_slab_node(struct mempolicy *policy);
+extern struct zonelist *huge_zonelist(struct vm_area_struct *vma,
+				unsigned long addr);
 
 int do_migrate_pages(struct mm_struct *mm,
 	const nodemask_t *from_nodes, const nodemask_t *to_nodes, int flags);
Index: linux-2.6.14-mm2/include/linux/hugetlb.h
===================================================================
--- linux-2.6.14-mm2.orig/include/linux/hugetlb.h	2005-11-14 12:51:17.000000000 -0800
+++ linux-2.6.14-mm2/include/linux/hugetlb.h	2005-11-14 12:51:23.000000000 -0800
@@ -22,7 +22,7 @@ int hugetlb_report_meminfo(char *);
 int hugetlb_report_node_meminfo(int, char *);
 int is_hugepage_mem_enough(size_t);
 unsigned long hugetlb_total_pages(void);
-struct page *alloc_huge_page(void);
+struct page *alloc_huge_page(struct vm_area_struct *, unsigned long);
 void free_huge_page(struct page *);
 int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, int write_access);
@@ -97,7 +97,7 @@ static inline unsigned long hugetlb_tota
 #define is_hugepage_only_range(mm, addr, len)	0
 #define hugetlb_free_pgd_range(tlb, addr, end, floor, ceiling) \
 						do { } while (0)
-#define alloc_huge_page()			({ NULL; })
+#define alloc_huge_page(vma, addr)		({ NULL; })
 #define free_huge_page(p)			({ (void)(p); BUG(); })
 #define hugetlb_fault(mm, vma, addr, write)	({ BUG(); 0; })
 
