Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbSJQXnD>; Thu, 17 Oct 2002 19:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262797AbSJQXnD>; Thu, 17 Oct 2002 19:43:03 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:37399 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S262796AbSJQXm7>; Thu, 17 Oct 2002 19:42:59 -0400
Date: Fri, 18 Oct 2002 00:49:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 2/9 shmem_getpage beyond eof
In-Reply-To: <Pine.LNX.4.44.0210180042480.7220-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210180047500.7220-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last set of tmpfs patches left shmem_getpage with an inadequate
next_index test to guard against races with truncation.  Now remove
that check and settle the issue with checks against i_size within
shmem_swp_alloc, which needs to know whether reading or writing.

--- tmpfs1/mm/shmem.c	Thu Oct 17 22:00:49 2002
+++ tmpfs2/mm/shmem.c	Thu Oct 17 22:00:59 2002
@@ -51,6 +51,12 @@
 /* Keep swapped page count in private field of indirect struct page */
 #define nr_swapped		private
 
+/* Flag end-of-file treatment to shmem_getpage and shmem_swp_alloc */
+enum sgp_type {
+	SGP_READ,	/* don't exceed i_size */
+	SGP_WRITE,	/* may exceed i_size */
+};
+
 static inline struct page *shmem_dir_alloc(unsigned int gfp_mask)
 {
 	/*
@@ -200,8 +206,6 @@
 	struct page **dir;
 	struct page *subdir;
 
-	if (index >= info->next_index)
-		return NULL;
 	if (index < SHMEM_NR_DIRECT)
 		return info->i_direct+index;
 	if (!info->i_indirect) {
@@ -274,20 +278,20 @@
  *
  * @info:	info structure for the inode
  * @index:	index of the page to find
+ * @sgp:	check and recheck i_size?
  */
-static swp_entry_t *shmem_swp_alloc(struct shmem_inode_info *info, unsigned long index)
+static swp_entry_t *shmem_swp_alloc(struct shmem_inode_info *info, unsigned long index, enum sgp_type sgp)
 {
 	struct inode *inode = &info->vfs_inode;
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	struct page *page = NULL;
 	swp_entry_t *entry;
 
-	while (!(entry = shmem_swp_entry(info, index, &page))) {
-		if (index >= info->next_index) {
-			entry = ERR_PTR(-EFAULT);
-			break;
-		}
+	if (sgp != SGP_WRITE &&
+	    ((loff_t) index << PAGE_CACHE_SHIFT) >= inode->i_size)
+		return ERR_PTR(-EINVAL);
 
+	while (!(entry = shmem_swp_entry(info, index, &page))) {
 		/*
 		 * Test free_blocks against 1 not 0, since we have 1 data
 		 * page (and perhaps indirect index pages) yet to allocate:
@@ -314,12 +318,21 @@
 			shmem_free_block(inode);
 			return ERR_PTR(-ENOMEM);
 		}
+		if (sgp != SGP_WRITE &&
+		    ((loff_t) index << PAGE_CACHE_SHIFT) >= inode->i_size) {
+			entry = ERR_PTR(-EINVAL);
+			break;
+		}
+		if (info->next_index <= index)
+			info->next_index = index + 1;
 	}
 	if (page) {
 		/* another task gave its page, or truncated the file */
 		shmem_free_block(inode);
 		shmem_dir_free(page);
 	}
+	if (info->next_index <= index && !IS_ERR(entry))
+		info->next_index = index + 1;
 	return entry;
 }
 
@@ -672,6 +685,7 @@
 
 	spin_lock(&info->lock);
 	shmem_recalc_inode(inode);
+	BUG_ON(index >= info->next_index);
 	entry = shmem_swp_entry(info, index, NULL);
 	BUG_ON(!entry);
 	BUG_ON(entry->val);
@@ -710,7 +724,7 @@
  * vm. If we swap it in we mark it dirty since we also free the swap
  * entry since a page cannot live in both the swap and page cache
  */
-static int shmem_getpage(struct inode *inode, unsigned long idx, struct page **pagep)
+static int shmem_getpage(struct inode *inode, unsigned long idx, struct page **pagep, enum sgp_type sgp)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -722,18 +736,6 @@
 
 	if (idx >= SHMEM_MAX_INDEX)
 		return -EFBIG;
-
-	/*
-	 * When writing, i_sem is held against truncation and other
-	 * writing, so next_index will remain as set here; but when
-	 * reading, idx must always be checked against next_index
-	 * after sleeping, lest truncation occurred meanwhile.
-	 */
-	spin_lock(&info->lock);
-	if (info->next_index <= idx)
-		info->next_index = idx + 1;
-	spin_unlock(&info->lock);
-
 repeat:
 	page = find_lock_page(mapping, idx);
 	if (page) {
@@ -744,7 +746,7 @@
 
 	spin_lock(&info->lock);
 	shmem_recalc_inode(inode);
-	entry = shmem_swp_alloc(info, idx);
+	entry = shmem_swp_alloc(info, idx, sgp);
 	if (IS_ERR(entry)) {
 		spin_unlock(&info->lock);
 		return PTR_ERR(entry);
@@ -761,7 +763,7 @@
 			page = read_swap_cache_async(swap);
 			if (!page) {
 				spin_lock(&info->lock);
-				entry = shmem_swp_alloc(info, idx);
+				entry = shmem_swp_alloc(info, idx, sgp);
 				if (IS_ERR(entry))
 					error = PTR_ERR(entry);
 				else {
@@ -830,7 +832,7 @@
 		}
 
 		spin_lock(&info->lock);
-		entry = shmem_swp_alloc(info, idx);
+		entry = shmem_swp_alloc(info, idx, sgp);
 		if (IS_ERR(entry))
 			error = PTR_ERR(entry);
 		else {
@@ -881,7 +883,7 @@
 	}
 	spin_unlock(&info->lock);
 	if (swap.val) {
-		(void) shmem_getpage(inode, idx, &page);
+		(void) shmem_getpage(inode, idx, &page, SGP_READ);
 	}
 	return page;
 }
@@ -897,10 +899,7 @@
 	idx += vma->vm_pgoff;
 	idx >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
 
-	if (((loff_t) idx << PAGE_CACHE_SHIFT) >= inode->i_size)
-		return NOPAGE_SIGBUS;
-
-	error = shmem_getpage(inode, idx, &page);
+	error = shmem_getpage(inode, idx, &page, SGP_READ);
 	if (error)
 		return (error == -ENOMEM)? NOPAGE_OOM: NOPAGE_SIGBUS;
 
@@ -1105,7 +1104,7 @@
 		 * what would it guard against? - so no deadlock here.
 		 */
 
-		status = shmem_getpage(inode, index, &page);
+		status = shmem_getpage(inode, index, &page, SGP_WRITE);
 		if (status)
 			break;
 
@@ -1170,9 +1169,9 @@
 				break;
 		}
 
-		desc->error = shmem_getpage(inode, index, &page);
+		desc->error = shmem_getpage(inode, index, &page, SGP_READ);
 		if (desc->error) {
-			if (desc->error == -EFAULT)
+			if (desc->error == -EINVAL)
 				desc->error = 0;
 			break;
 		}
@@ -1419,7 +1418,7 @@
 			iput(inode);
 			return -ENOMEM;
 		}
-		error = shmem_getpage(inode, 0, &page);
+		error = shmem_getpage(inode, 0, &page, SGP_WRITE);
 		if (error) {
 			vm_unacct_memory(VM_ACCT(1));
 			iput(inode);
@@ -1455,7 +1454,7 @@
 static int shmem_readlink(struct dentry *dentry, char *buffer, int buflen)
 {
 	struct page *page;
-	int res = shmem_getpage(dentry->d_inode, 0, &page);
+	int res = shmem_getpage(dentry->d_inode, 0, &page, SGP_READ);
 	if (res)
 		return res;
 	res = vfs_readlink(dentry, buffer, buflen, kmap(page));
@@ -1467,7 +1466,7 @@
 static int shmem_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct page *page;
-	int res = shmem_getpage(dentry->d_inode, 0, &page);
+	int res = shmem_getpage(dentry->d_inode, 0, &page, SGP_READ);
 	if (res)
 		return res;
 	res = vfs_follow_link(nd, kmap(page));

