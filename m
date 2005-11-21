Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVKUUnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVKUUnT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVKUUnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:43:18 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:10888 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932462AbVKUUnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:43:18 -0500
Date: Mon, 21 Nov 2005 12:43:01 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>,
       ak@suse.de
Message-Id: <20051121204301.10630.76569.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/4] mempolicies: private pointer in check_range and MPOL_MF_INVERT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] memory policies: Genericize check_range()

This was was first posted at
http://marc.theaimsgroup.com/?l=linux-mm&m=113149240227584&w=2

(Part of this functionality is also contained in the direct migration
pathset. The functionality here is more generic and independent of that
patchset.)

- Add internal flags MPOL_MF_INVERT to control check_range() behavior.

- Replace the pagelist passed through by check_range by a general
  private pointer that may be used for other purposes.
  (The following patches will use that to merge numa_maps into
  mempolicy.c and to better group the page migration code in
  the policy layer)

- Improve some comments.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc1-mm2/mm/mempolicy.c
===================================================================
--- linux-2.6.15-rc1-mm2.orig/mm/mempolicy.c	2005-11-21 10:51:46.000000000 -0800
+++ linux-2.6.15-rc1-mm2/mm/mempolicy.c	2005-11-21 12:02:32.000000000 -0800
@@ -88,8 +88,9 @@
 #include <asm/tlbflush.h>
 #include <asm/uaccess.h>
 
-/* Internal MPOL_MF_xxx flags */
+/* Internal flags */
 #define MPOL_MF_DISCONTIG_OK (MPOL_MF_INTERNAL << 0)	/* Skip checks for continuous vmas */
+#define MPOL_MF_INVERT (MPOL_MF_INTERNAL << 1)		/* Invert check for nodemask */
 
 static kmem_cache_t *policy_cache;
 static kmem_cache_t *sn_cache;
@@ -232,11 +233,11 @@ static void migrate_page_add(struct vm_a
 	}
 }
 
-/* Ensure all existing pages follow the policy. */
+/* Scan through pages checking if pages follow certain conditions. */
 static int check_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end,
 		const nodemask_t *nodes, unsigned long flags,
-		struct list_head *pagelist)
+		void *private)
 {
 	pte_t *orig_pte;
 	pte_t *pte;
@@ -246,6 +247,7 @@ static int check_pte_range(struct vm_are
 	do {
 		unsigned long pfn;
 		unsigned int nid;
+		struct page *page;
 
 		if (!pte_present(*pte))
 			continue;
@@ -254,15 +256,16 @@ static int check_pte_range(struct vm_are
 			print_bad_pte(vma, *pte, addr);
 			continue;
 		}
-		nid = pfn_to_nid(pfn);
-		if (!node_isset(nid, *nodes)) {
-			if (pagelist) {
-				struct page *page = pfn_to_page(pfn);
+		page = pfn_to_page(pfn);
+		nid = page_to_nid(page);
+		if (node_isset(nid, *nodes) == !!(flags & MPOL_MF_INVERT))
+			continue;
+
+		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+			migrate_page_add(vma, page, private, flags);
+		else
+			break;
 
-				migrate_page_add(vma, page, pagelist, flags);
-			} else
-				break;
-		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap_unlock(orig_pte, ptl);
 	return addr != end;
@@ -271,7 +274,7 @@ static int check_pte_range(struct vm_are
 static inline int check_pmd_range(struct vm_area_struct *vma, pud_t *pud,
 		unsigned long addr, unsigned long end,
 		const nodemask_t *nodes, unsigned long flags,
-		struct list_head *pagelist)
+		void *private)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -282,7 +285,7 @@ static inline int check_pmd_range(struct
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
 		if (check_pte_range(vma, pmd, addr, next, nodes,
-				    flags, pagelist))
+				    flags, private))
 			return -EIO;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
@@ -291,7 +294,7 @@ static inline int check_pmd_range(struct
 static inline int check_pud_range(struct vm_area_struct *vma, pgd_t *pgd,
 		unsigned long addr, unsigned long end,
 		const nodemask_t *nodes, unsigned long flags,
-		struct list_head *pagelist)
+		void *private)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -302,7 +305,7 @@ static inline int check_pud_range(struct
 		if (pud_none_or_clear_bad(pud))
 			continue;
 		if (check_pmd_range(vma, pud, addr, next, nodes,
-				    flags, pagelist))
+				    flags, private))
 			return -EIO;
 	} while (pud++, addr = next, addr != end);
 	return 0;
@@ -311,7 +314,7 @@ static inline int check_pud_range(struct
 static inline int check_pgd_range(struct vm_area_struct *vma,
 		unsigned long addr, unsigned long end,
 		const nodemask_t *nodes, unsigned long flags,
-		struct list_head *pagelist)
+		void *private)
 {
 	pgd_t *pgd;
 	unsigned long next;
@@ -322,7 +325,7 @@ static inline int check_pgd_range(struct
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
 		if (check_pud_range(vma, pgd, addr, next, nodes,
-				    flags, pagelist))
+				    flags, private))
 			return -EIO;
 	} while (pgd++, addr = next, addr != end);
 	return 0;
@@ -344,7 +347,7 @@ static inline int vma_migratable(struct 
  */
 static struct vm_area_struct *
 check_range(struct mm_struct *mm, unsigned long start, unsigned long end,
-	    const nodemask_t *nodes, unsigned long flags, struct list_head *pagelist)
+	    const nodemask_t *nodes, unsigned long flags, void *private)
 {
 	int err;
 	struct vm_area_struct *first, *vma, *prev;
@@ -373,7 +376,7 @@ check_range(struct mm_struct *mm, unsign
 			if (vma->vm_start > start)
 				start = vma->vm_start;
 			err = check_pgd_range(vma, start, endvma, nodes,
-						flags, pagelist);
+						flags, private);
 			if (err) {
 				first = ERR_PTR(err);
 				break;
@@ -461,7 +464,8 @@ long do_mbind(unsigned long start, unsig
 	int err;
 	LIST_HEAD(pagelist);
 
-	if ((flags & ~(unsigned long)(MPOL_MF_STRICT|MPOL_MF_MOVE|MPOL_MF_MOVE_ALL))
+	if ((flags & ~(unsigned long)(MPOL_MF_STRICT |
+				      MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
 	    || mode > MPOL_MAX)
 		return -EINVAL;
 	if ((flags & MPOL_MF_MOVE_ALL) && !capable(CAP_SYS_RESOURCE))
@@ -499,8 +503,9 @@ long do_mbind(unsigned long start, unsig
 			mode,nodes_addr(nodes)[0]);
 
 	down_write(&mm->mmap_sem);
-	vma = check_range(mm, start, end, nmask, flags,
-	      (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ? &pagelist : NULL);
+	vma = check_range(mm, start, end, nmask,
+			  flags | MPOL_MF_INVERT, &pagelist);
+
 	err = PTR_ERR(vma);
 	if (!IS_ERR(vma)) {
 		int nr_failed = 0;
@@ -655,7 +660,6 @@ int do_migrate_pages(struct mm_struct *m
 	nodemask_t nodes;
 
 	nodes_andnot(nodes, *from_nodes, *to_nodes);
-	nodes_complement(nodes, nodes);
 
 	down_read(&mm->mmap_sem);
 	check_range(mm, mm->mmap->vm_start, TASK_SIZE, &nodes,
