Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbVKOVos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbVKOVos (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 16:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbVKOVos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 16:44:48 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:4291 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751055AbVKOVor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 16:44:47 -0500
Date: Tue, 15 Nov 2005 13:44:03 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: akpm@osdl.org
cc: Adam Litke <agl@us.ibm.com>, linux-mm@kvack.org, ak@suse.de,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
       wli@holomorphy.com
Subject: [PATCH] Add NUMA policy support for huge pages.
Message-ID: <Pine.LNX.4.62.0511151342310.10995@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The huge_zonelist() function in the memory policy layer
provides an list of zones ordered by NUMA distance. The hugetlb
layer will walk that list looking for a zone that has available huge pages
but is also in the nodeset of the current cpuset.

This patch does not contain the folding of find_or_alloc_huge_page() that
was controversial in the earlier discussion.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm2/mm/mempolicy.c
===================================================================
--- linux-2.6.14-mm2.orig/mm/mempolicy.c	2005-11-15 10:29:53.000000000 -0800
+++ linux-2.6.14-mm2/mm/mempolicy.c	2005-11-15 12:30:26.000000000 -0800
@@ -1005,6 +1005,34 @@ static unsigned offset_il_node(struct me
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
@@ -1053,15 +1081,8 @@ alloc_page_vma(gfp_t gfp, struct vm_area
 
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
--- linux-2.6.14-mm2.orig/mm/hugetlb.c	2005-11-15 11:36:44.000000000 -0800
+++ linux-2.6.14-mm2/mm/hugetlb.c	2005-11-15 13:12:33.000000000 -0800
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
@@ -378,8 +379,9 @@ void unmap_hugepage_range(struct vm_area
 	flush_tlb_range(vma, start, end);
 }
 
-static struct page *find_or_alloc_huge_page(struct address_space *mapping,
-				unsigned long idx, int shared)
+static struct page *find_or_alloc_huge_page(struct vm_area_struct *vma,
+			unsigned long addr, struct address_space *mapping,
+			unsigned long idx, int shared)
 {
 	struct page *page;
 	int err;
@@ -391,7 +393,7 @@ retry:
 
 	if (hugetlb_get_quota(mapping))
 		goto out;
-	page = alloc_huge_page();
+	page = alloc_huge_page(vma, addr);
 	if (!page) {
 		hugetlb_put_quota(mapping);
 		goto out;
@@ -431,7 +433,7 @@ static int hugetlb_cow(struct mm_struct 
 	}
 
 	page_cache_get(old_page);
-	new_page = alloc_huge_page();
+	new_page = alloc_huge_page(vma, address);
 
 	if (!new_page) {
 		page_cache_release(old_page);
@@ -480,7 +482,7 @@ int hugetlb_no_page(struct mm_struct *mm
 	 * Use page lock to guard against racing truncation
 	 * before we get page_table_lock.
 	 */
-	page = find_or_alloc_huge_page(mapping, idx,
+	page = find_or_alloc_huge_page(vma, address, mapping, idx,
 			vma->vm_flags & VM_SHARED);
 	if (!page)
 		goto out;
Index: linux-2.6.14-mm2/include/linux/mempolicy.h
===================================================================
--- linux-2.6.14-mm2.orig/include/linux/mempolicy.h	2005-11-15 10:29:52.000000000 -0800
+++ linux-2.6.14-mm2/include/linux/mempolicy.h	2005-11-15 12:30:26.000000000 -0800
@@ -158,6 +158,8 @@ extern void numa_default_policy(void);
 extern void numa_policy_init(void);
 extern void numa_policy_rebind(const nodemask_t *old, const nodemask_t *new);
 extern struct mempolicy default_policy;
+extern struct zonelist *huge_zonelist(struct vm_area_struct *vma,
+		unsigned long addr);
 
 int do_migrate_pages(struct mm_struct *mm,
 	const nodemask_t *from_nodes, const nodemask_t *to_nodes, int flags);
Index: linux-2.6.14-mm2/include/linux/hugetlb.h
===================================================================
--- linux-2.6.14-mm2.orig/include/linux/hugetlb.h	2005-11-15 10:29:52.000000000 -0800
+++ linux-2.6.14-mm2/include/linux/hugetlb.h	2005-11-15 12:30:26.000000000 -0800
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
 
