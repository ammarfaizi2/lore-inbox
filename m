Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbVKUUnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbVKUUnv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVKUUnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:43:46 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:2242 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932459AbVKUUnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:43:24 -0500
Date: Mon, 21 Nov 2005 12:43:17 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ak@suse.de,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051121204317.10630.92857.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051121204301.10630.76569.sendpatchset@schroedinger.engr.sgi.com>
References: <20051121204301.10630.76569.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 4/4] Move page migration related functions near do_migrate_pages()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Group page migration functions in mempolicy.c

Add a forward declaration for migrate_page_add (like gather_stats()) and use
our new found mobility to group all page migration related function around
do_migrate_pages().

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.15-rc1-mm2/mm/mempolicy.c
===================================================================
--- linux-2.6.15-rc1-mm2.orig/mm/mempolicy.c	2005-11-21 12:14:43.000000000 -0800
+++ linux-2.6.15-rc1-mm2/mm/mempolicy.c	2005-11-21 12:21:00.000000000 -0800
@@ -188,55 +188,9 @@ static struct mempolicy *mpol_new(int mo
 	return policy;
 }
 
-/* Check if we are the only process mapping the page in question */
-static inline int single_mm_mapping(struct mm_struct *mm,
-			struct address_space *mapping)
-{
-	struct vm_area_struct *vma;
-	struct prio_tree_iter iter;
-	int rc = 1;
-
-	spin_lock(&mapping->i_mmap_lock);
-	vma_prio_tree_foreach(vma, &iter, &mapping->i_mmap, 0, ULONG_MAX)
-		if (mm != vma->vm_mm) {
-			rc = 0;
-			goto out;
-		}
-	list_for_each_entry(vma, &mapping->i_mmap_nonlinear, shared.vm_set.list)
-		if (mm != vma->vm_mm) {
-			rc = 0;
-			goto out;
-		}
-out:
-	spin_unlock(&mapping->i_mmap_lock);
-	return rc;
-}
-
-/*
- * Add a page to be migrated to the pagelist
- */
-static void migrate_page_add(struct vm_area_struct *vma,
-	struct page *page, struct list_head *pagelist, unsigned long flags)
-{
-	/*
-	 * Avoid migrating a page that is shared by others and not writable.
-	 */
-	if ((flags & MPOL_MF_MOVE_ALL) || !page->mapping || PageAnon(page) ||
-	    mapping_writably_mapped(page->mapping) ||
-	    single_mm_mapping(vma->vm_mm, page->mapping)) {
-		int rc = isolate_lru_page(page);
-
-		if (rc == 1)
-			list_add(&page->lru, pagelist);
-		/*
-		 * If the isolate attempt was not successful then we just
-		 * encountered an unswappable page. Something must be wrong.
-	 	 */
-		WARN_ON(rc == 0);
-	}
-}
-
 static void gather_stats(struct page *, void *);
+static void migrate_page_add(struct vm_area_struct *vma,
+	struct page *page, struct list_head *pagelist, unsigned long flags);
 
 /* Scan through pages checking if pages follow certain conditions. */
 static int check_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
@@ -448,90 +402,6 @@ static int contextualize_policy(int mode
 	return mpol_check_policy(mode, nodes);
 }
 
-static int swap_pages(struct list_head *pagelist)
-{
-	LIST_HEAD(moved);
-	LIST_HEAD(failed);
-	int n;
-
-	n = migrate_pages(pagelist, NULL, &moved, &failed);
-	putback_lru_pages(&failed);
-	putback_lru_pages(&moved);
-
-	return n;
-}
-
-long do_mbind(unsigned long start, unsigned long len,
-		unsigned long mode, nodemask_t *nmask, unsigned long flags)
-{
-	struct vm_area_struct *vma;
-	struct mm_struct *mm = current->mm;
-	struct mempolicy *new;
-	unsigned long end;
-	int err;
-	LIST_HEAD(pagelist);
-
-	if ((flags & ~(unsigned long)(MPOL_MF_STRICT |
-				      MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
-	    || mode > MPOL_MAX)
-		return -EINVAL;
-	if ((flags & MPOL_MF_MOVE_ALL) && !capable(CAP_SYS_RESOURCE))
-		return -EPERM;
-
-	if (start & ~PAGE_MASK)
-		return -EINVAL;
-
-	if (mode == MPOL_DEFAULT)
-		flags &= ~MPOL_MF_STRICT;
-
-	len = (len + PAGE_SIZE - 1) & PAGE_MASK;
-	end = start + len;
-
-	if (end < start)
-		return -EINVAL;
-	if (end == start)
-		return 0;
-
-	if (mpol_check_policy(mode, nmask))
-		return -EINVAL;
-
-	new = mpol_new(mode, nmask);
-	if (IS_ERR(new))
-		return PTR_ERR(new);
-
-	/*
-	 * If we are using the default policy then operation
-	 * on discontinuous address spaces is okay after all
-	 */
-	if (!new)
-		flags |= MPOL_MF_DISCONTIG_OK;
-
-	PDprintk("mbind %lx-%lx mode:%ld nodes:%lx\n",start,start+len,
-			mode,nodes_addr(nodes)[0]);
-
-	down_write(&mm->mmap_sem);
-	vma = check_range(mm, start, end, nmask,
-			  flags | MPOL_MF_INVERT, &pagelist);
-
-	err = PTR_ERR(vma);
-	if (!IS_ERR(vma)) {
-		int nr_failed = 0;
-
-		err = mbind_range(vma, start, end, new);
-		if (!list_empty(&pagelist))
-			nr_failed = swap_pages(&pagelist);
-
-		if (!err && nr_failed && (flags & MPOL_MF_STRICT))
-			err = -EIO;
-	}
-	if (!list_empty(&pagelist))
-		putback_lru_pages(&pagelist);
-
-	up_write(&mm->mmap_sem);
-	mpol_free(new);
-	return err;
-}
-
 /* Set the process memory policy */
 long do_set_mempolicy(int mode, nodemask_t *nodes)
 {
@@ -652,6 +522,71 @@ long do_get_mempolicy(int *policy, nodem
 }
 
 /*
+ * page migration
+ */
+
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
+	/*
+	 * Avoid migrating a page that is shared by others and not writable.
+	 */
+	if ((flags & MPOL_MF_MOVE_ALL) || !page->mapping || PageAnon(page) ||
+	    mapping_writably_mapped(page->mapping) ||
+	    single_mm_mapping(vma->vm_mm, page->mapping)) {
+		int rc = isolate_lru_page(page);
+
+		if (rc == 1)
+			list_add(&page->lru, pagelist);
+		/*
+		 * If the isolate attempt was not successful then we just
+		 * encountered an unswappable page. Something must be wrong.
+	 	 */
+		WARN_ON(rc == 0);
+	}
+}
+
+static int swap_pages(struct list_head *pagelist)
+{
+	LIST_HEAD(moved);
+	LIST_HEAD(failed);
+	int n;
+
+	n = migrate_pages(pagelist, NULL, &moved, &failed);
+	putback_lru_pages(&failed);
+	putback_lru_pages(&moved);
+
+	return n;
+}
+
+/*
  * For now migrate_pages simply swaps out the pages from nodes that are in
  * the source set but not in the target set. In the future, we would
  * want a function that moves pages between the two nodesets in such
@@ -681,6 +616,77 @@ int do_migrate_pages(struct mm_struct *m
 	return count;
 }
 
+long do_mbind(unsigned long start, unsigned long len,
+		unsigned long mode, nodemask_t *nmask, unsigned long flags)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm = current->mm;
+	struct mempolicy *new;
+	unsigned long end;
+	int err;
+	LIST_HEAD(pagelist);
+
+	if ((flags & ~(unsigned long)(MPOL_MF_STRICT |
+				      MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
+	    || mode > MPOL_MAX)
+		return -EINVAL;
+	if ((flags & MPOL_MF_MOVE_ALL) && !capable(CAP_SYS_RESOURCE))
+		return -EPERM;
+
+	if (start & ~PAGE_MASK)
+		return -EINVAL;
+
+	if (mode == MPOL_DEFAULT)
+		flags &= ~MPOL_MF_STRICT;
+
+	len = (len + PAGE_SIZE - 1) & PAGE_MASK;
+	end = start + len;
+
+	if (end < start)
+		return -EINVAL;
+	if (end == start)
+		return 0;
+
+	if (mpol_check_policy(mode, nmask))
+		return -EINVAL;
+
+	new = mpol_new(mode, nmask);
+	if (IS_ERR(new))
+		return PTR_ERR(new);
+
+	/*
+	 * If we are using the default policy then operation
+	 * on discontinuous address spaces is okay after all
+	 */
+	if (!new)
+		flags |= MPOL_MF_DISCONTIG_OK;
+
+	PDprintk("mbind %lx-%lx mode:%ld nodes:%lx\n",start,start+len,
+			mode,nodes_addr(nodes)[0]);
+
+	down_write(&mm->mmap_sem);
+	vma = check_range(mm, start, end, nmask,
+			  flags | MPOL_MF_INVERT, &pagelist);
+
+	err = PTR_ERR(vma);
+	if (!IS_ERR(vma)) {
+		int nr_failed = 0;
+
+		err = mbind_range(vma, start, end, new);
+		if (!list_empty(&pagelist))
+			nr_failed = swap_pages(&pagelist);
+
+		if (!err && nr_failed && (flags & MPOL_MF_STRICT))
+			err = -EIO;
+	}
+	if (!list_empty(&pagelist))
+		putback_lru_pages(&pagelist);
+
+	up_write(&mm->mmap_sem);
+	mpol_free(new);
+	return err;
+}
+
 /*
  * User space interface with variable sized bitmaps for nodelists.
  */
