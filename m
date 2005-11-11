Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbVKKS5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVKKS5I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 13:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbVKKS5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 13:57:08 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:46482 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750957AbVKKS5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 13:57:07 -0500
Date: Fri, 11 Nov 2005 10:56:50 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Adam Litke <agl@us.ibm.com>
cc: linux-mm@kvack.org, ak@suse.de, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: [RFC] NUMA memory policy support for HUGE pages
Message-ID: <Pine.LNX.4.62.0511111051080.20589@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well since we got through respecting cpusets and allocating a page nearer 
to the processors so easy lets go for the full thing. Here is a draft of 
a patch that implements full NUMA policy support for it on top of the 
cpusets and the NUMA near allocation patch.

I am not sure that this is the right way to do it. Maybe we better put the 
whole allocator into the policy layer like alloc_pages_vma?

I needed to add two parameters to alloc_huge_page in order to get the 
allocation right for all policy cases. This means that find_lock_page 
has a plethora of parameters now. Maybe idx and the mapping could be 
deduced from addr and vma?

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/mempolicy.c	2005-11-10 14:33:16.000000000 -0800
+++ linux-2.6.14-mm1/mm/mempolicy.c	2005-11-11 10:47:24.000000000 -0800
@@ -1179,6 +1179,24 @@ static unsigned offset_il_node(struct me
 	return nid;
 }
 
+/* Return a zonelist suitable for a huge page allocation. */
+struct zonelist *huge_zonelist(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct mempolicy *pol = get_vma_policy(current, vma, addr);
+
+	if (pol->policy == MPOL_INTERLEAVE) {
+		unsigned nid;
+		unsigned long off;
+
+		off = vma->vm_pgoff;
+		off += (addr - vma->vm_start) >> HPAGE_SHIFT;
+		nid = offset_il_node(pol, vma, off);
+
+		return NODE_DATA(nid)->node_zonelists + gfp_zone(GFP_HIGHUSER);
+	}
+	return zonelist_policy(GFP_HIGHUSER, pol);
+}
+
 /* Allocate a page in interleaved policy.
    Own path because it needs to do special accounting. */
 static struct page *alloc_page_interleave(gfp_t gfp, unsigned order,
Index: linux-2.6.14-mm1/mm/hugetlb.c
===================================================================
--- linux-2.6.14-mm1.orig/mm/hugetlb.c	2005-11-11 10:04:00.000000000 -0800
+++ linux-2.6.14-mm1/mm/hugetlb.c	2005-11-11 10:32:45.000000000 -0800
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
@@ -343,7 +344,8 @@ void unmap_hugepage_range(struct vm_area
 	flush_tlb_range(vma, start, end);
 }
 
-static struct page *find_lock_huge_page(struct address_space *mapping,
+static struct page *find_lock_huge_page(struct vm_area_struct *vma,
+			unsigned long addr, struct address_space *mapping,
 			unsigned long idx)
 {
 	struct page *page;
@@ -363,7 +365,7 @@ retry:
 
 	if (hugetlb_get_quota(mapping))
 		goto out;
-	page = alloc_huge_page();
+	page = alloc_huge_page(vma, addr);
 	if (!page) {
 		hugetlb_put_quota(mapping);
 		goto out;
@@ -403,7 +405,7 @@ int hugetlb_fault(struct mm_struct *mm, 
 	 * Use page lock to guard against racing truncation
 	 * before we get page_table_lock.
 	 */
-	page = find_lock_huge_page(mapping, idx);
+	page = find_lock_huge_page(vma, address, mapping, idx);
 	if (!page)
 		goto out;
 
Index: linux-2.6.14-mm1/include/linux/mempolicy.h
===================================================================
--- linux-2.6.14-mm1.orig/include/linux/mempolicy.h	2005-11-10 13:32:00.000000000 -0800
+++ linux-2.6.14-mm1/include/linux/mempolicy.h	2005-11-11 10:29:00.000000000 -0800
@@ -159,6 +159,8 @@ extern void numa_policy_init(void);
 extern void numa_policy_rebind(const nodemask_t *old, const nodemask_t *new);
 extern struct mempolicy default_policy;
 extern unsigned next_slab_node(struct mempolicy *policy);
+extern struct zonelist *huge_zonelist(struct vm_area_struct *vma,
+				unsigned long addr);
 
 int do_migrate_pages(struct mm_struct *mm,
 	const nodemask_t *from_nodes, const nodemask_t *to_nodes, int flags);
Index: linux-2.6.14-mm1/include/linux/hugetlb.h
===================================================================
--- linux-2.6.14-mm1.orig/include/linux/hugetlb.h	2005-11-09 10:47:09.000000000 -0800
+++ linux-2.6.14-mm1/include/linux/hugetlb.h	2005-11-11 10:45:57.000000000 -0800
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
 
