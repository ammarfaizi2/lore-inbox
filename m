Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262839AbSJAVml>; Tue, 1 Oct 2002 17:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262840AbSJAVml>; Tue, 1 Oct 2002 17:42:41 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:41461 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S262839AbSJAVmb>; Tue, 1 Oct 2002 17:42:31 -0400
Date: Tue, 1 Oct 2002 22:48:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 4/9 shmem_getpage locked 
In-Reply-To: <Pine.LNX.4.44.0210012240470.2602-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210012247520.2602-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The distinction between shmem_getpage and shmem_getpage_locked is
not helpful, particularly now info->sem is gone; and shmem_getpage
confusingly tailored to shmem_nopage's expectations.  Put the code
of shmem_getpage_locked into the frame of shmem_getpage, leaving
its callers to unlock_page afterwards.

--- tmpfs3/mm/shmem.c	Tue Oct  1 19:49:04 2002
+++ tmpfs4/mm/shmem.c	Tue Oct  1 19:49:09 2002
@@ -495,10 +495,6 @@
 
 /*
  * Move the page from the page cache to the swap cache.
- *
- * The page lock prevents multiple occurences of shmem_writepage at
- * once.  We still need to guard against racing with
- * shmem_getpage_locked().  
  */
 static int shmem_writepage(struct page * page)
 {
@@ -560,19 +556,16 @@
 }
 
 /*
- * shmem_getpage_locked - either get the page from swap or allocate a new one
+ * shmem_getpage - either get the page from swap or allocate a new one
  *
  * If we allocate a new one we do not mark it dirty. That's up to the
  * vm. If we swap it in we mark it dirty since we also free the swap
  * entry since a page cannot live in both the swap and page cache
- *
- * Called with the inode locked, so it cannot race with itself, but we
- * still need to guard against racing with shm_writepage(), which might
- * be trying to move the page to the swap cache as we run.
  */
-static struct page * shmem_getpage_locked(struct shmem_inode_info *info, struct inode * inode, unsigned long idx)
+static int shmem_getpage(struct inode *inode, unsigned long idx, struct page **pagep)
 {
 	struct address_space *mapping = inode->i_mapping;
+	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo;
 	struct page *page;
 	swp_entry_t *entry;
@@ -580,7 +573,7 @@
 	int error = 0;
 
 	if (idx >= SHMEM_MAX_INDEX)
-		return ERR_PTR(-EFBIG);
+		return -EFBIG;
 
 	/*
 	 * When writing, i_sem is held against truncation and other
@@ -595,15 +588,17 @@
 
 repeat:
 	page = find_lock_page(mapping, idx);
-	if (page)
-		return page;
+	if (page) {
+		*pagep = page;
+		return 0;
+	}
 
 	spin_lock(&info->lock);
 	shmem_recalc_inode(inode);
 	entry = shmem_swp_alloc(info, idx);
 	if (IS_ERR(entry)) {
 		spin_unlock(&info->lock);
-		return (void *)entry;
+		return PTR_ERR(entry);
 	}
 	swap = *entry;
 
@@ -623,7 +618,7 @@
 					error = -ENOMEM;
 				spin_unlock(&info->lock);
 				if (error)
-					return ERR_PTR(error);
+					return error;
 				goto repeat;
 			}
 			wait_on_page_locked(page);
@@ -652,7 +647,7 @@
 			spin_unlock(&info->lock);
 			unlock_page(page);
 			page_cache_release(page);
-			return ERR_PTR(error);
+			return error;
 		}
 
 		*entry = (swp_entry_t) {0};
@@ -665,7 +660,7 @@
 		spin_lock(&sbinfo->stat_lock);
 		if (sbinfo->free_blocks == 0) {
 			spin_unlock(&sbinfo->stat_lock);
-			return ERR_PTR(-ENOSPC);
+			return -ENOSPC;
 		}
 		sbinfo->free_blocks--;
 		spin_unlock(&sbinfo->stat_lock);
@@ -675,7 +670,7 @@
 			spin_lock(&sbinfo->stat_lock);
 			sbinfo->free_blocks++;
 			spin_unlock(&sbinfo->stat_lock);
-			return ERR_PTR(-ENOMEM);
+			return -ENOMEM;
 		}
 
 		spin_lock(&info->lock);
@@ -690,7 +685,7 @@
 			sbinfo->free_blocks++;
 			spin_unlock(&sbinfo->stat_lock);
 			if (error)
-				return ERR_PTR(error);
+				return error;
 			goto repeat;
 		}
 		spin_unlock(&info->lock);
@@ -700,30 +695,8 @@
 
 	/* We have the page */
 	SetPageUptodate(page);
-	return page;
-}
-
-static int shmem_getpage(struct inode * inode, unsigned long idx, struct page **ptr)
-{
-	struct shmem_inode_info *info = SHMEM_I(inode);
-	int error;
-
-	*ptr = ERR_PTR(-EFAULT);
-	if (inode->i_size <= (loff_t) idx * PAGE_CACHE_SIZE)
-		goto failed;
-
-	*ptr = shmem_getpage_locked(info, inode, idx);
-	if (IS_ERR (*ptr))
-		goto failed;
-
-	unlock_page(*ptr);
+	*pagep = page;
 	return 0;
-failed:
-	error = PTR_ERR(*ptr);
-	*ptr = NOPAGE_SIGBUS;
-	if (error == -ENOMEM)
-		*ptr = NOPAGE_OOM;
-	return error;
 }
 
 static struct page *shmem_holdpage(struct inode *inode, unsigned long idx)
@@ -747,26 +720,32 @@
 	}
 	spin_unlock(&info->lock);
 	if (swap.val) {
-		if (shmem_getpage(inode, idx, &page) < 0)
-			page = NULL;
+		if (shmem_getpage(inode, idx, &page) == 0)
+			unlock_page(page);
 	}
 	return page;
 }
 
-struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int unused)
+struct page *shmem_nopage(struct vm_area_struct *vma, unsigned long address, int unused)
 {
-	struct page * page;
-	unsigned int idx;
-	struct inode * inode = vma->vm_file->f_dentry->d_inode;
+	struct inode *inode = vma->vm_file->f_dentry->d_inode;
+	struct page *page;
+	unsigned long idx;
+	int error;
 
 	idx = (address - vma->vm_start) >> PAGE_CACHE_SHIFT;
 	idx += vma->vm_pgoff;
 
-	if (shmem_getpage(inode, idx, &page))
-		return page;
+	if (((loff_t) idx << PAGE_CACHE_SHIFT) >= inode->i_size)
+		return NOPAGE_SIGBUS;
 
+	error = shmem_getpage(inode, idx, &page);
+	if (error)
+		return (error == -ENOMEM)? NOPAGE_OOM: NOPAGE_SIGBUS;
+
+	unlock_page(page);
 	flush_page_to_ram(page);
-	return(page);
+	return page;
 }
 
 void shmem_lock(struct file * file, int lock)
@@ -882,7 +861,6 @@
 shmem_file_write(struct file *file,const char *buf,size_t count,loff_t *ppos)
 {
 	struct inode	*inode = file->f_dentry->d_inode; 
-	struct shmem_inode_info *info;
 	unsigned long	limit = current->rlim[RLIMIT_FSIZE].rlim_cur;
 	loff_t		pos;
 	struct page	*page;
@@ -973,11 +951,8 @@
 			__get_user(dummy, buf+bytes-1);
 		}
 
-		info = SHMEM_I(inode);
-		page = shmem_getpage_locked(info, inode, index);
-
-		status = PTR_ERR(page);
-		if (IS_ERR(page))
+		status = shmem_getpage(inode, index, &page);
+		if (status)
 			break;
 
 		/* We have exclusive IO access to the page.. */
@@ -1064,10 +1039,12 @@
 		if (index == end_index) {
 			nr = inode->i_size & ~PAGE_CACHE_MASK;
 			if (nr <= offset) {
+				unlock_page(page);
 				page_cache_release(page);
 				break;
 			}
 		}
+		unlock_page(page);
 		nr -= offset;
 
 		if (!list_empty(&mapping->i_mmap_shared))
@@ -1271,6 +1248,7 @@
 
 static int shmem_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
 {
+	int error;
 	int len;
 	struct inode *inode;
 	struct page *page;
@@ -1296,11 +1274,11 @@
 			iput(inode);
 			return -ENOMEM;
 		}
-		page = shmem_getpage_locked(info, inode, 0);
-		if (IS_ERR(page)) {
+		error = shmem_getpage(inode, 0, &page);
+		if (error) {
 			vm_unacct_memory(VM_ACCT(1));
 			iput(inode);
-			return PTR_ERR(page);
+			return error;
 		}
 		inode->i_op = &shmem_symlink_inode_operations;
 		spin_lock (&shmem_ilock);
@@ -1332,27 +1310,26 @@
 
 static int shmem_readlink(struct dentry *dentry, char *buffer, int buflen)
 {
-	struct page * page;
+	struct page *page;
 	int res = shmem_getpage(dentry->d_inode, 0, &page);
-
 	if (res)
 		return res;
-
-	res = vfs_readlink(dentry,buffer,buflen, kmap(page));
+	res = vfs_readlink(dentry, buffer, buflen, kmap(page));
 	kunmap(page);
+	unlock_page(page);
 	page_cache_release(page);
 	return res;
 }
 
 static int shmem_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
-	struct page * page;
+	struct page *page;
 	int res = shmem_getpage(dentry->d_inode, 0, &page);
 	if (res)
 		return res;
-
 	res = vfs_follow_link(nd, kmap(page));
 	kunmap(page);
+	unlock_page(page);
 	page_cache_release(page);
 	return res;
 }

