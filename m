Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbVJTXAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbVJTXAA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 19:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVJTXAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 19:00:00 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11473 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932546AbVJTW77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 18:59:59 -0400
Date: Thu, 20 Oct 2005 15:59:50 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>,
       Magnus Damm <magnus.damm@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051020225950.19761.62167.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 3/4] Swap migration V3: MPOL_MF_MOVE interface
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add page migration support via swap to the NUMA policy layer

This patch adds page migration support to the NUMA policy layer. An additional
flag MPOL_MF_MOVE is introduced for mbind. If MPOL_MF_MOVE is specified then
pages that do not conform to the memory policy will be evicted from memory.
When they get pages back in new pages will be allocated following the numa policy.

Version 2
- Add vma_migratable() function for future enhancements.
- No side effects on WARN_ON
- Remove move_pages for now
- Make patch fit 2.6.14-rc4-mm1

Version 3
- Add check to not migrate pages shared with other processes (but allow
  migration of memory shared between threads having a common mm_struct)
- MPOL_MF_MOVE_ALL to override and move even pages shared with other
  processes. This only works if the process issuing this call has
  CAP_SYS_RESOURCE because this enables the moving of pages owned
  by other processes.
- MPOL_MF_DISCONTIG_OK (internal use only) to not check for continuous VMAs.
  Enable MPOL_MF_DISCONTIG_OK if policy to be set is NULL (default policy).

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-rc4-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/mm/mempolicy.c	2005-10-17 10:24:16.000000000 -0700
+++ linux-2.6.14-rc4-mm1/mm/mempolicy.c	2005-10-20 13:33:12.000000000 -0700
@@ -83,9 +83,13 @@
 #include <linux/init.h>
 #include <linux/compat.h>
 #include <linux/mempolicy.h>
+#include <linux/swap.h>
 #include <asm/tlbflush.h>
 #include <asm/uaccess.h>
 
+/* Internal MPOL_MF_xxx flags */
+#define MPOL_MF_DISCONTIG_OK (1<<20)	/* Skip checks for continuous vmas */
+
 static kmem_cache_t *policy_cache;
 static kmem_cache_t *sn_cache;
 
@@ -179,9 +183,62 @@ static struct mempolicy *mpol_new(int mo
 	return policy;
 }
 
+/* Check if we are the only process mapping the page in question */
+static inline int single_mm_mapping(struct mm_struct *mm,
+			struct address_space *mapping)
+{
+	struct vm_area_struct *vma;
+	struct prio_tree_iter iter;
+	int rc = 1;
+
+	spin_lock(&mapping->i_mmap_lock);
+	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, 0, ULONG_MAX)
+		if (mm != vma->vm_mm) {
+			rc = 0;
+			goto out;
+		}
+	list_for_each_entry(vma, &mapping->i_mmap_nonlinear, shared.vm_set.list)
+		if (mm != vma->vm_mm) {
+			rc = 0;
+			goto out;
+		}
+out:
+	spin_unlock(&mapping->i_mmap_lock);
+	return rc;
+}
+
+/*
+ * Add a page to be migrated to the pagelist
+ */
+static void migrate_page_add(struct vm_area_struct *vma,
+	struct page *page, struct list_head *pagelist, unsigned long flags)
+{
+	int rc;
+
+	/*
+	 * Avoid migrating a page that is shared by others and not writable.
+	 */
+	if ((flags & MPOL_MF_MOVE_ALL) ||
+	    PageAnon(page) ||
+	    mapping_writably_mapped(page->mapping) ||
+	    single_mm_mapping(vma->vm_mm, page->mapping)
+	   ) {
+
+		rc = isolate_lru_page(page, pagelist);
+		/*
+		 * If the isolate attempt was not successful
+		 * then we just encountered an unswappable
+		 * page. Something must be wrong.
+	 	 */
+		WARN_ON(rc == 0);
+	}
+}
+
 /* Ensure all existing pages follow the policy. */
 static int check_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long addr, unsigned long end, nodemask_t *nodes)
+		unsigned long addr, unsigned long end,
+		nodemask_t *nodes, unsigned long flags,
+		struct list_head *pagelist)
 {
 	pte_t *orig_pte;
 	pte_t *pte;
@@ -200,15 +257,23 @@ static int check_pte_range(struct vm_are
 			continue;
 		}
 		nid = pfn_to_nid(pfn);
-		if (!node_isset(nid, *nodes))
-			break;
+		if (!node_isset(nid, *nodes)) {
+			if (pagelist) {
+				struct page *page = pfn_to_page(pfn);
+
+				migrate_page_add(vma, page, pagelist, flags);
+			} else
+				break;
+		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
 	pte_unmap_unlock(orig_pte, ptl);
 	return addr != end;
 }
 
 static inline int check_pmd_range(struct vm_area_struct *vma, pud_t *pud,
-		unsigned long addr, unsigned long end, nodemask_t *nodes)
+		unsigned long addr, unsigned long end,
+		nodemask_t *nodes, unsigned long flags,
+		struct list_head *pagelist)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -218,14 +283,17 @@ static inline int check_pmd_range(struct
 		next = pmd_addr_end(addr, end);
 		if (pmd_none_or_clear_bad(pmd))
 			continue;
-		if (check_pte_range(vma, pmd, addr, next, nodes))
+		if (check_pte_range(vma, pmd, addr, next, nodes,
+				    flags, pagelist))
 			return -EIO;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
 
 static inline int check_pud_range(struct vm_area_struct *vma, pgd_t *pgd,
-		unsigned long addr, unsigned long end, nodemask_t *nodes)
+		unsigned long addr, unsigned long end,
+		nodemask_t *nodes, unsigned long flags,
+		struct list_head *pagelist)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -235,14 +303,17 @@ static inline int check_pud_range(struct
 		next = pud_addr_end(addr, end);
 		if (pud_none_or_clear_bad(pud))
 			continue;
-		if (check_pmd_range(vma, pud, addr, next, nodes))
+		if (check_pmd_range(vma, pud, addr, next, nodes,
+				    flags, pagelist))
 			return -EIO;
 	} while (pud++, addr = next, addr != end);
 	return 0;
 }
 
 static inline int check_pgd_range(struct vm_area_struct *vma,
-		unsigned long addr, unsigned long end, nodemask_t *nodes)
+		unsigned long addr, unsigned long end,
+		nodemask_t *nodes, unsigned long flags,
+		struct list_head *pagelist)
 {
 	pgd_t *pgd;
 	unsigned long next;
@@ -252,16 +323,31 @@ static inline int check_pgd_range(struct
 		next = pgd_addr_end(addr, end);
 		if (pgd_none_or_clear_bad(pgd))
 			continue;
-		if (check_pud_range(vma, pgd, addr, next, nodes))
+		if (check_pud_range(vma, pgd, addr, next, nodes,
+				    flags, pagelist))
 			return -EIO;
 	} while (pgd++, addr = next, addr != end);
 	return 0;
 }
 
+/* Check if a vma is migratable */
+static inline int vma_migratable(struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & (
+			VM_LOCKED |
+			VM_IO |
+			VM_RESERVED |
+			VM_DENYWRITE |
+			VM_SHM
+	   ))
+		return 0;
+	return 1;
+}
+
 /* Step 1: check the range */
 static struct vm_area_struct *
 check_range(struct mm_struct *mm, unsigned long start, unsigned long end,
-	    nodemask_t *nodes, unsigned long flags)
+	    nodemask_t *nodes, unsigned long flags, struct list_head *pagelist)
 {
 	int err;
 	struct vm_area_struct *first, *vma, *prev;
@@ -273,17 +359,24 @@ check_range(struct mm_struct *mm, unsign
 		return ERR_PTR(-EACCES);
 	prev = NULL;
 	for (vma = first; vma && vma->vm_start < end; vma = vma->vm_next) {
-		if (!vma->vm_next && vma->vm_end < end)
-			return ERR_PTR(-EFAULT);
-		if (prev && prev->vm_end < vma->vm_start)
-			return ERR_PTR(-EFAULT);
-		if ((flags & MPOL_MF_STRICT) && !is_vm_hugetlb_page(vma)) {
+		if (!(flags & MPOL_MF_DISCONTIG_OK)) {
+			if (!vma->vm_next && vma->vm_end < end)
+				return ERR_PTR(-EFAULT);
+			if (prev && prev->vm_end < vma->vm_start)
+				return ERR_PTR(-EFAULT);
+		}
+		if (!is_vm_hugetlb_page(vma) &&
+		    ((flags & MPOL_MF_STRICT) ||
+		     ((flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) &&
+		      vma_migratable(vma)
+		   ))) {
 			unsigned long endvma = vma->vm_end;
 			if (endvma > end)
 				endvma = end;
 			if (vma->vm_start > start)
 				start = vma->vm_start;
-			err = check_pgd_range(vma, start, endvma, nodes);
+			err = check_pgd_range(vma, start, endvma, nodes,
+						flags, pagelist);
 			if (err) {
 				first = ERR_PTR(err);
 				break;
@@ -357,33 +450,59 @@ long do_mbind(unsigned long start, unsig
 	struct mempolicy *new;
 	unsigned long end;
 	int err;
+	LIST_HEAD(pagelist);
 
-	if ((flags & ~(unsigned long)(MPOL_MF_STRICT)) || mode > MPOL_MAX)
+	if ((flags & ~(unsigned long)(MPOL_MF_STRICT | MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+	    || mode > MPOL_MAX)
 		return -EINVAL;
+	if ((flags & MPOL_MF_MOVE_ALL) && !capable(CAP_SYS_RESOURCE))
+		return -EPERM;
+
 	if (start & ~PAGE_MASK)
 		return -EINVAL;
+
 	if (mode == MPOL_DEFAULT)
 		flags &= ~MPOL_MF_STRICT;
+
 	len = (len + PAGE_SIZE - 1) & PAGE_MASK;
 	end = start + len;
+
 	if (end < start)
 		return -EINVAL;
 	if (end == start)
 		return 0;
+
 	if (mpol_check_policy(mode, nmask))
 		return -EINVAL;
+
 	new = mpol_new(mode, nmask);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 
+	/*
+	 * If we are using the default policy then operation
+	 * on discontinuous address spaces is okay after all
+	 */
+	if (!new)
+		flags |= MPOL_MF_DISCONTIG_OK;
+
 	PDprintk("mbind %lx-%lx mode:%ld nodes:%lx\n",start,start+len,
 			mode,nodes_addr(nodes)[0]);
 
 	down_write(&mm->mmap_sem);
-	vma = check_range(mm, start, end, nmask, flags);
+	vma = check_range(mm, start, end, nmask, flags,
+	      (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ? &pagelist : NULL);
 	err = PTR_ERR(vma);
-	if (!IS_ERR(vma))
+	if (!IS_ERR(vma)) {
 		err = mbind_range(vma, start, end, new);
+		if (!list_empty(&pagelist))
+			swapout_pages(&pagelist);
+		if (!err  && !list_empty(&pagelist) && (flags & MPOL_MF_STRICT))
+				err = -EIO;
+	}
+	if (!list_empty(&pagelist))
+		putback_lru_pages(&pagelist);
+
 	up_write(&mm->mmap_sem);
 	mpol_free(new);
 	return err;
Index: linux-2.6.14-rc4-mm1/include/linux/mempolicy.h
===================================================================
--- linux-2.6.14-rc4-mm1.orig/include/linux/mempolicy.h	2005-10-17 10:24:13.000000000 -0700
+++ linux-2.6.14-rc4-mm1/include/linux/mempolicy.h	2005-10-20 13:26:28.000000000 -0700
@@ -22,6 +22,8 @@
 
 /* Flags for mbind */
 #define MPOL_MF_STRICT	(1<<0)	/* Verify existing pages in the mapping */
+#define MPOL_MF_MOVE	(1<<1)	/* Move pages owned by this process to conform to mapping */
+#define MPOL_MF_MOVE_ALL (1<<2)	/* Move every page to conform to mapping */
 
 #ifdef __KERNEL__
 
