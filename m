Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbRFMIiW>; Wed, 13 Jun 2001 04:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbRFMIiL>; Wed, 13 Jun 2001 04:38:11 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:20105 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S261268AbRFMIiD>; Wed, 13 Jun 2001 04:38:03 -0400
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch] 2.4.5-ac13 ramfs and tmpfs accounting
Organisation: SAP LinuxLab
Date: 13 Jun 2001 10:37:14 +0200
Message-ID: <m3d7886ait.fsf@linux.local>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

ramfs accounting does not get notified when a clean page gets dropped
from the inode.

Also tmpfs should use the new function to do accurate accounting. Else
the cached field in -ac will get spurious negative values.

The following patch fixes both.

Greetings
		Christoph

diff -uNr 5-ac13/fs/ramfs/inode.c 5-ac13-a/fs/ramfs/inode.c
--- 5-ac13/fs/ramfs/inode.c	Tue Jun 12 09:51:39 2001
+++ 5-ac13-a/fs/ramfs/inode.c	Wed Jun 13 09:54:22 2001
@@ -289,7 +289,7 @@
 	return 0;
 }
 
-static void ramfs_truncatepage(struct page *page)
+static void ramfs_removepage(struct page *page)
 {
 	struct inode *inode = (struct inode *)page->mapping->host;
 
@@ -659,7 +659,7 @@
 	writepage:	ramfs_writepage,
 	prepare_write:	ramfs_prepare_write,
 	commit_write:	ramfs_commit_write,
-	truncatepage:	ramfs_truncatepage,
+	removepage:	ramfs_removepage,
 };
 
 static struct file_operations ramfs_file_operations = {
diff -uNr 5-ac13/include/linux/fs.h 5-ac13-a/include/linux/fs.h
--- 5-ac13/include/linux/fs.h	Tue Jun 12 17:34:25 2001
+++ 5-ac13-a/include/linux/fs.h	Wed Jun 13 10:23:48 2001
@@ -368,7 +368,7 @@
 	int (*sync_page)(struct page *);
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
-	void (*truncatepage)(struct page *); /* called from truncate_complete_page */
+	void (*removepage)(struct page *); /* called when page gets removed from the inode */
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
 	int (*bmap)(struct address_space *, long);
 };
diff -uNr 5-ac13/mm/filemap.c 5-ac13-a/mm/filemap.c
--- 5-ac13/mm/filemap.c	Tue Jun 12 09:51:45 2001
+++ 5-ac13-a/mm/filemap.c	Wed Jun 13 09:56:43 2001
@@ -82,6 +82,9 @@
 {
 	struct address_space * mapping = page->mapping;
 
+	if (mapping->a_ops->removepage)
+		mapping->a_ops->removepage(page);
+	
 	mapping->nrpages--;
 	list_del(&page->list);
 	page->mapping = NULL;
@@ -206,9 +209,6 @@
 	if (!page->buffers || block_flushpage(page, 0))
 		lru_cache_del(page);
 
-	if (page->mapping->a_ops->truncatepage)
-		page->mapping->a_ops->truncatepage(page);
-	
 	/*
 	 * We remove the page from the page cache _after_ we have
 	 * destroyed all buffer-cache references to it. Otherwise some
diff -uNr 5-ac13/mm/shmem.c 5-ac13-a/mm/shmem.c
--- 5-ac13/mm/shmem.c	Tue Jun 12 09:51:45 2001
+++ 5-ac13-a/mm/shmem.c	Wed Jun 13 09:56:20 2001
@@ -51,42 +51,16 @@
 
 #define BLOCKS_PER_PAGE (PAGE_SIZE/512)
 
-/*
- * shmem_recalc_inode - recalculate the size of an inode
- *
- * @inode: inode to recalc
- * @swap:  additional swap pages freed externally
- *
- * We have to calculate the free blocks since the mm can drop pages
- * behind our back
- *
- * But we know that normally
- * inodes->i_blocks/BLOCKS_PER_PAGE == 
- * 			inode->i_mapping->nrpages + info->swapped
- *
- * So the mm freed 
- * inodes->i_blocks/BLOCKS_PER_PAGE - 
- * 			(inode->i_mapping->nrpages + info->swapped)
- *
- * It has to be called with the spinlock held.
- *
- * The swap parameter is a performance hack for truncate.
- */
-
-static void shmem_recalc_inode(struct inode * inode, unsigned long swap)
+static void shmem_removepage(struct page *page)
 {
-	unsigned long freed;
+	struct inode *inode = (struct inode *)page->mapping->host;
+	struct shmem_sb_info * sbinfo = SHMEM_SB(inode->i_sb);
 
-	freed = (inode->i_blocks/BLOCKS_PER_PAGE) -
-		(inode->i_mapping->nrpages + SHMEM_I(inode)->swapped);
-	if (freed){
-		struct shmem_sb_info * sbinfo = SHMEM_SB(inode->i_sb);
-		inode->i_blocks -= freed*BLOCKS_PER_PAGE;
-		spin_lock (&sbinfo->stat_lock);
-		sbinfo->free_blocks += freed;
-		spin_unlock (&sbinfo->stat_lock);
-		atomic_sub(freed-swap, &shmem_nrpages);
-	}
+	inode->i_blocks -= BLOCKS_PER_PAGE;
+	spin_lock (&sbinfo->stat_lock);
+	sbinfo->free_blocks++;
+	spin_unlock (&sbinfo->stat_lock);
+	atomic_dec(&shmem_nrpages);
 }
 
 static swp_entry_t * shmem_swp_entry (struct shmem_inode_info *info, unsigned long index) 
@@ -166,6 +140,7 @@
 	unsigned long freed = 0;
 	swp_entry_t **base, **ptr, **last;
 	struct shmem_inode_info * info = SHMEM_I(inode);
+	struct shmem_sb_info * sbinfo = SHMEM_SB(inode->i_sb);
 
 	down(&info->sem);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
@@ -202,7 +177,9 @@
 out:
 	info->max_index = index;
 	info->swapped -= freed;
-	shmem_recalc_inode(inode, freed);
+	spin_lock(&sbinfo->stat_lock);
+	sbinfo->free_blocks += freed;
+	spin_unlock(&sbinfo->stat_lock);
 	spin_unlock (&info->lock);
 	up(&info->sem);
 }
@@ -257,7 +234,6 @@
 	entry = shmem_swp_entry(info, page->index);
 	if (IS_ERR(entry))	/* this had been allocted on page allocation */
 		BUG();
-	shmem_recalc_inode(page->mapping->host, 0);
 	error = -EAGAIN;
 	if (entry->val)
 		BUG();
@@ -1155,7 +1131,8 @@
 
 
 static struct address_space_operations shmem_aops = {
-	writepage: shmem_writepage
+	removepage:	shmem_removepage,
+	writepage:	shmem_writepage,
 };
 
 static struct file_operations shmem_file_operations = {

