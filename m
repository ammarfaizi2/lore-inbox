Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262298AbSJQXoo>; Thu, 17 Oct 2002 19:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262322AbSJQXoo>; Thu, 17 Oct 2002 19:44:44 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:10537 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S262298AbSJQXog>; Thu, 17 Oct 2002 19:44:36 -0400
Date: Fri, 18 Oct 2002 00:51:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 3/9 shmem_getpage reading holes
In-Reply-To: <Pine.LNX.4.44.0210180042480.7220-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210180050090.7220-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here I intended a patch to remove the unsatisfactory shmem_recalc_inode
(which tries to work out when vmscan has freed undirtied hole pages,
to relax its blocks-in-use limit; but can only do so per-inode when it
needs to be per-super).  I had hoped to use the releasepage method, but
it looks like it can't quite be bent to this task, the page might still
be rebusied after release.  2.4-ac uses a removepage method dedicated to
this, but I'm reluctant to ask for such a minor address_space_operation.

So, leave shmem_recalc_inode as is, but avoid the issue as much as
possible, by letting shmem_getpage use the empty_zero_page instead of
allocating when a hole is read (but this cannot be done when it's being
mapped, nowadays the nopage doesn't know if page will be copied or not).
Whereupon shmem_getpage(,,,SGP_READ) can do partial trunc's holdpage.

--- tmpfs2/mm/shmem.c	Thu Oct 17 22:00:59 2002
+++ tmpfs3/mm/shmem.c	Thu Oct 17 22:01:09 2002
@@ -51,12 +51,16 @@
 /* Keep swapped page count in private field of indirect struct page */
 #define nr_swapped		private
 
-/* Flag end-of-file treatment to shmem_getpage and shmem_swp_alloc */
+/* Flag allocation requirements to shmem_getpage and shmem_swp_alloc */
 enum sgp_type {
-	SGP_READ,	/* don't exceed i_size */
-	SGP_WRITE,	/* may exceed i_size */
+	SGP_READ,	/* don't exceed i_size, don't allocate page */
+	SGP_CACHE,	/* don't exceed i_size, may allocate page */
+	SGP_WRITE,	/* may exceed i_size, may allocate page */
 };
 
+static int shmem_getpage(struct inode *inode, unsigned long idx,
+			 struct page **pagep, enum sgp_type sgp);
+
 static inline struct page *shmem_dir_alloc(unsigned int gfp_mask)
 {
 	/*
@@ -138,8 +142,7 @@
  * @inode: inode to recalc
  *
  * We have to calculate the free blocks since the mm can drop
- * undirtied hole pages behind our back.  Later we should be
- * able to use the releasepage method to handle this better.
+ * undirtied hole pages behind our back.
  *
  * But normally   info->alloced == inode->i_mapping->nrpages + info->swapped
  * So mm freed is info->alloced - (inode->i_mapping->nrpages + info->swapped)
@@ -278,7 +281,7 @@
  *
  * @info:	info structure for the inode
  * @index:	index of the page to find
- * @sgp:	check and recheck i_size?
+ * @sgp:	check and recheck i_size? skip allocation?
  */
 static swp_entry_t *shmem_swp_alloc(struct shmem_inode_info *info, unsigned long index, enum sgp_type sgp)
 {
@@ -286,12 +289,15 @@
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	struct page *page = NULL;
 	swp_entry_t *entry;
+	static const swp_entry_t unswapped = {0};
 
 	if (sgp != SGP_WRITE &&
 	    ((loff_t) index << PAGE_CACHE_SHIFT) >= inode->i_size)
 		return ERR_PTR(-EINVAL);
 
 	while (!(entry = shmem_swp_entry(info, index, &page))) {
+		if (sgp == SGP_READ)
+			return (swp_entry_t *) &unswapped;
 		/*
 		 * Test free_blocks against 1 not 0, since we have 1 data
 		 * page (and perhaps indirect index pages) yet to allocate:
@@ -483,7 +489,6 @@
 
 static int shmem_notify_change(struct dentry *dentry, struct iattr *attr)
 {
-	static struct page *shmem_holdpage(struct inode *, unsigned long);
 	struct inode *inode = dentry->d_inode;
 	struct page *page = NULL;
 	long change = 0;
@@ -508,8 +513,9 @@
 			 * it assigned to swap.
 			 */
 			if (attr->ia_size & (PAGE_CACHE_SIZE-1)) {
-				page = shmem_holdpage(inode,
-					attr->ia_size >> PAGE_CACHE_SHIFT);
+				(void) shmem_getpage(inode,
+					attr->ia_size>>PAGE_CACHE_SHIFT,
+						&page, SGP_READ);
 			}
 		}
 	}
@@ -812,6 +818,16 @@
 		shmem_swp_unmap(entry);
 		spin_unlock(&info->lock);
 		swap_free(swap);
+	} else if (sgp == SGP_READ) {
+		shmem_swp_unmap(entry);
+		page = find_get_page(mapping, idx);
+		if (page && TestSetPageLocked(page)) {
+			spin_unlock(&info->lock);
+			wait_on_page_locked(page);
+			page_cache_release(page);
+			goto repeat;
+		}
+		spin_unlock(&info->lock);
 	} else {
 		shmem_swp_unmap(entry);
 		spin_unlock(&info->lock);
@@ -854,40 +870,14 @@
 		SetPageUptodate(page);
 	}
 
-	/* We have the page */
-	unlock_page(page);
-	*pagep = page;
+	if (page) {
+		unlock_page(page);
+		*pagep = page;
+	} else
+		*pagep = ZERO_PAGE(0);
 	return 0;
 }
 
-static struct page *shmem_holdpage(struct inode *inode, unsigned long idx)
-{
-	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct page *page;
-	swp_entry_t *entry;
-	swp_entry_t swap = {0};
-
-	/*
-	 * Somehow, it feels wrong for truncation down to cause any
-	 * allocation: so instead of a blind shmem_getpage, check that
-	 * the page has actually been instantiated before holding it.
-	 */
-	spin_lock(&info->lock);
-	page = find_get_page(inode->i_mapping, idx);
-	if (!page) {
-		entry = shmem_swp_entry(info, idx, NULL);
-		if (entry) {
-			swap = *entry;
-			shmem_swp_unmap(entry);
-		}
-	}
-	spin_unlock(&info->lock);
-	if (swap.val) {
-		(void) shmem_getpage(inode, idx, &page, SGP_READ);
-	}
-	return page;
-}
-
 struct page *shmem_nopage(struct vm_area_struct *vma, unsigned long address, int unused)
 {
 	struct inode *inode = vma->vm_file->f_dentry->d_inode;
@@ -899,7 +889,7 @@
 	idx += vma->vm_pgoff;
 	idx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
 
-	error = shmem_getpage(inode, idx, &page, SGP_READ);
+	error = shmem_getpage(inode, idx, &page, SGP_CACHE);
 	if (error)
 		return (error == -ENOMEM)? NOPAGE_OOM: NOPAGE_SIGBUS;
 
@@ -1191,7 +1181,8 @@
 		}
 		nr -= offset;
 
-		if (!list_empty(&mapping->i_mmap_shared))
+		if (!list_empty(&mapping->i_mmap_shared) &&
+		    page != ZERO_PAGE(0))
 			flush_dcache_page(page);
 
 		/*

