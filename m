Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135939AbREJAhn>; Wed, 9 May 2001 20:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135944AbREJAhf>; Wed, 9 May 2001 20:37:35 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:15378 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135939AbREJAh2>; Wed, 9 May 2001 20:37:28 -0400
Date: Wed, 9 May 2001 19:58:58 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] writepage method changes 
Message-ID: <Pine.LNX.4.21.0105091940430.15959-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, 

Here is the updated version of the patch to add the "priority" argument to
writepage(). All implementations have been fixed.

No referenced bit changes as I still think its not worth passing this
information down to writepage().

Note: I've removed ramfs_writepage(). If there is no writepage function
pointer for a given address_space_ops the page will be kept dirty and
moved to the active list (which btw avoids page_launder() from looping on
ramfs pages which will always be dirty), so I don't see any purpose for
ramfs_writepage(). Why the heck it was there before? 


(I know the patch is big, but I want Linus to read it, so its not
compressed)


diff -Nur --exclude-from=exclude linux.orig/fs/adfs/inode.c linux/fs/adfs/inode.c
--- linux.orig/fs/adfs/inode.c	Mon May  7 20:47:26 2001
+++ linux/fs/adfs/inode.c	Wed May  9 20:48:01 2001
@@ -53,9 +53,9 @@
 	return 0;
 }
 
-static int adfs_writepage(struct page *page)
+static int adfs_writepage(struct page *page, int priority)
 {
-	return block_write_full_page(page, adfs_get_block);
+	return block_write_full_page(page, adfs_get_block, priority);
 }
 
 static int adfs_readpage(struct file *file, struct page *page)
diff -Nur --exclude-from=exclude linux.orig/fs/affs/file.c linux/fs/affs/file.c
--- linux.orig/fs/affs/file.c	Mon May  7 20:47:26 2001
+++ linux/fs/affs/file.c	Wed May  9 20:47:28 2001
@@ -409,9 +409,9 @@
 	return -ENOSPC;
 }
 
-static int affs_writepage(struct page *page)
+static int affs_writepage(struct page *page, int priority)
 {
-	return block_write_full_page(page, affs_get_block);
+	return block_write_full_page(page, affs_get_block, priority);
 }
 static int affs_readpage(struct file *file, struct page *page)
 {
diff -Nur --exclude-from=exclude linux.orig/fs/bfs/file.c linux/fs/bfs/file.c
--- linux.orig/fs/bfs/file.c	Mon May  7 20:47:26 2001
+++ linux/fs/bfs/file.c	Wed May  9 20:49:42 2001
@@ -135,9 +135,9 @@
 	return err;
 }
 
-static int bfs_writepage(struct page *page)
+static int bfs_writepage(struct page *page, int priority)
 {
-	return block_write_full_page(page, bfs_get_block);
+	return block_write_full_page(page, bfs_get_block, priority);
 }
 
 static int bfs_readpage(struct file *file, struct page *page)
diff -Nur --exclude-from=exclude linux.orig/fs/buffer.c linux/fs/buffer.c
--- linux.orig/fs/buffer.c	Mon May  7 20:47:26 2001
+++ linux/fs/buffer.c	Wed May  9 21:08:07 2001
@@ -1933,12 +1933,22 @@
 	return err;
 }
 
-int block_write_full_page(struct page *page, get_block_t *get_block)
+int block_write_full_page(struct page *page, get_block_t *get_block, int priority)
 {
 	struct inode *inode = page->mapping->host;
 	unsigned long end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 	unsigned offset;
 	int err;
+
+	/* 
+	 * If priority is zero, there is no need to actually 
+	 * send the page data to disk.
+	 */
+	if (!priority)
+		return -1;
+
+	/* We're going to write the page out: mark it clean */
+	ClearPageDirty(page);
 
 	/* easy case */
 	if (page->index < end_index)
diff -Nur --exclude-from=exclude linux.orig/fs/ext2/inode.c linux/fs/ext2/inode.c
--- linux.orig/fs/ext2/inode.c	Mon May  7 20:47:26 2001
+++ linux/fs/ext2/inode.c	Tue May  8 20:46:54 2001
@@ -650,9 +650,9 @@
 	return NULL;
 }
 
-static int ext2_writepage(struct page *page)
+static int ext2_writepage(struct page *page, int priority)
 {
-	return block_write_full_page(page,ext2_get_block);
+	return block_write_full_page(page,ext2_get_block,priority);
 }
 static int ext2_readpage(struct file *file, struct page *page)
 {
diff -Nur --exclude-from=exclude linux.orig/fs/fat/inode.c linux/fs/fat/inode.c
--- linux.orig/fs/fat/inode.c	Mon May  7 20:47:26 2001
+++ linux/fs/fat/inode.c	Wed May  9 20:46:19 2001
@@ -735,9 +735,9 @@
 	return 0;
 }
 
-static int fat_writepage(struct page *page)
+static int fat_writepage(struct page *page, int priority)
 {
-	return block_write_full_page(page,fat_get_block);
+	return block_write_full_page(page,fat_get_block, priority);
 }
 static int fat_readpage(struct file *file, struct page *page)
 {
diff -Nur --exclude-from=exclude linux.orig/fs/hfs/inode.c linux/fs/hfs/inode.c
--- linux.orig/fs/hfs/inode.c	Mon May  7 20:47:26 2001
+++ linux/fs/hfs/inode.c	Wed May  9 20:47:51 2001
@@ -220,9 +220,9 @@
 	return __hfs_notify_change(dentry, attr, HFS_HDR);
 }
 
-static int hfs_writepage(struct page *page)
+static int hfs_writepage(struct page *page, int priority)
 {
-	return block_write_full_page(page,hfs_get_block);
+	return block_write_full_page(page,hfs_get_block,priority);
 }
 static int hfs_readpage(struct file *file, struct page *page)
 {
diff -Nur --exclude-from=exclude linux.orig/fs/hpfs/file.c linux/fs/hpfs/file.c
--- linux.orig/fs/hpfs/file.c	Mon May  7 20:47:26 2001
+++ linux/fs/hpfs/file.c	Wed May  9 20:44:46 2001
@@ -93,9 +93,9 @@
 	return 0;
 }
 
-static int hpfs_writepage(struct page *page)
+static int hpfs_writepage(struct page *page, int priority)
 {
-	return block_write_full_page(page,hpfs_get_block);
+	return block_write_full_page(page,hpfs_get_block,priority);
 }
 static int hpfs_readpage(struct file *file, struct page *page)
 {
diff -Nur --exclude-from=exclude linux.orig/fs/minix/inode.c linux/fs/minix/inode.c
--- linux.orig/fs/minix/inode.c	Mon May  7 20:47:26 2001
+++ linux/fs/minix/inode.c	Wed May  9 20:44:17 2001
@@ -398,9 +398,9 @@
 	return NULL;
 }
 
-static int minix_writepage(struct page *page)
+static int minix_writepage(struct page *page, int priority)
 {
-	return block_write_full_page(page,minix_get_block);
+	return block_write_full_page(page,minix_get_block,priority);
 }
 static int minix_readpage(struct file *file, struct page *page)
 {
diff -Nur --exclude-from=exclude linux.orig/fs/nfs/write.c linux/fs/nfs/write.c
--- linux.orig/fs/nfs/write.c	Mon May  7 20:47:26 2001
+++ linux/fs/nfs/write.c	Wed May  9 20:43:13 2001
@@ -251,13 +251,22 @@
  * Write an mmapped page to the server.
  */
 int
-nfs_writepage(struct page *page)
+nfs_writepage(struct page *page, int priority)
 {
 	struct inode *inode;
 	unsigned long end_index;
 	unsigned offset = PAGE_CACHE_SIZE;
 	int err;
 	struct address_space *mapping = page->mapping;
+
+	if (!priority)
+		return -1;
+
+	/* 
+	 * We're going to write the page: mark it clean
+	 */
+
+	ClearPageDirty (page);
 
 	if (!mapping)
 		BUG();
diff -Nur --exclude-from=exclude linux.orig/fs/qnx4/inode.c linux/fs/qnx4/inode.c
--- linux.orig/fs/qnx4/inode.c	Mon May  7 20:47:26 2001
+++ linux/fs/qnx4/inode.c	Wed May  9 20:47:40 2001
@@ -415,9 +415,9 @@
 	return;
 }
 
-static int qnx4_writepage(struct page *page)
+static int qnx4_writepage(struct page *page, int priority)
 {
-	return block_write_full_page(page,qnx4_get_block);
+	return block_write_full_page(page,qnx4_get_block,priority);
 }
 static int qnx4_readpage(struct file *file, struct page *page)
 {
diff -Nur --exclude-from=exclude linux.orig/fs/ramfs/inode.c linux/fs/ramfs/inode.c
--- linux.orig/fs/ramfs/inode.c	Mon May  7 20:47:26 2001
+++ linux/fs/ramfs/inode.c	Wed May  9 20:50:57 2001
@@ -74,17 +74,6 @@
 	return 0;
 }
 
-/*
- * Writing: just make sure the page gets marked dirty, so that
- * the page stealer won't grab it.
- */
-static int ramfs_writepage(struct page *page)
-{
-	SetPageDirty(page);
-	UnlockPage(page);
-	return 0;
-}
-
 static int ramfs_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
 {
 	void *addr = kmap(page);
@@ -277,7 +266,6 @@
 
 static struct address_space_operations ramfs_aops = {
 	readpage:	ramfs_readpage,
-	writepage:	ramfs_writepage,
 	prepare_write:	ramfs_prepare_write,
 	commit_write:	ramfs_commit_write
 };
diff -Nur --exclude-from=exclude linux.orig/fs/reiserfs/inode.c linux/fs/reiserfs/inode.c
--- linux.orig/fs/reiserfs/inode.c	Mon May  7 20:47:26 2001
+++ linux/fs/reiserfs/inode.c	Wed May  9 21:00:23 2001
@@ -1855,9 +1855,16 @@
 //
 // modified from ext2_writepage is
 //
-static int reiserfs_writepage (struct page * page)
+static int reiserfs_writepage (struct page * page, int priority)
 {
     struct inode *inode = page->mapping->host ;
+
+    if (!priority)
+	    return -1;
+
+    /* We're going to write the page out: mark it clean. */
+    ClearPageDirty(page);
+
     reiserfs_wait_on_write_block(inode->i_sb) ;
     return reiserfs_write_full_page(page) ;
 }
diff -Nur --exclude-from=exclude linux.orig/fs/smbfs/file.c linux/fs/smbfs/file.c
--- linux.orig/fs/smbfs/file.c	Mon May  7 20:47:26 2001
+++ linux/fs/smbfs/file.c	Wed May  9 20:46:03 2001
@@ -152,13 +152,20 @@
  * We are called with the page locked and we unlock it when done.
  */
 static int
-smb_writepage(struct page *page)
+smb_writepage(struct page *page, int priority)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode;
 	unsigned long end_index;
 	unsigned offset = PAGE_CACHE_SIZE;
 	int err;
+
+	if (!priority)
+		return -1;
+	/*
+	 * We're going to write the page out: mark it clean. 
+	 */
+	ClearPageDirty(page);
 
 	if (!mapping)
 		BUG();
diff -Nur --exclude-from=exclude linux.orig/fs/sysv/inode.c linux/fs/sysv/inode.c
--- linux.orig/fs/sysv/inode.c	Mon May  7 20:47:26 2001
+++ linux/fs/sysv/inode.c	Wed May  9 20:45:05 2001
@@ -916,9 +916,9 @@
 	return NULL;
 }
 
-static int sysv_writepage(struct page *page)
+static int sysv_writepage(struct page *page, int priority)
 {
-	return block_write_full_page(page,sysv_get_block);
+	return block_write_full_page(page,sysv_get_block,priority);
 }
 static int sysv_readpage(struct file *file, struct page *page)
 {
diff -Nur --exclude-from=exclude linux.orig/fs/udf/file.c linux/fs/udf/file.c
--- linux.orig/fs/udf/file.c	Mon May  7 20:47:26 2001
+++ linux/fs/udf/file.c	Wed May  9 20:49:05 2001
@@ -67,13 +67,20 @@
 	return 0;
 }
 
-static int udf_adinicb_writepage(struct page *page)
+static int udf_adinicb_writepage(struct page *page, int priority)
 {
 	struct inode *inode = page->mapping->host;
 
 	struct buffer_head *bh;
 	int block;
 	char *kaddr;
+	
+	if (!priority)
+		return -1;
+	/*
+	 * We're going to write the page out: mark it clean.
+	 */
+	ClearPageDirty(page);
 
 	if (!PageLocked(page))
 		PAGE_BUG(page);
diff -Nur --exclude-from=exclude linux.orig/fs/udf/inode.c linux/fs/udf/inode.c
--- linux.orig/fs/udf/inode.c	Mon May  7 20:47:26 2001
+++ linux/fs/udf/inode.c	Wed May  9 21:01:09 2001
@@ -125,9 +125,9 @@
 		udf_trunc(inode);
 }
 
-static int udf_writepage(struct page *page)
+static int udf_writepage(struct page *page, int priority)
 {
-	return block_write_full_page(page, udf_get_block);
+	return block_write_full_page(page, udf_get_block, priority);
 }
 
 static int udf_readpage(struct file *file, struct page *page)
@@ -202,7 +202,7 @@
 	mark_buffer_dirty(bh);
 	udf_release_data(bh);
 
-	inode->i_data.a_ops->writepage(page);
+	inode->i_data.a_ops->writepage(page, 1);
 	page_cache_release(page);
 
 	mark_inode_dirty(inode);
diff -Nur --exclude-from=exclude linux.orig/fs/ufs/inode.c linux/fs/ufs/inode.c
--- linux.orig/fs/ufs/inode.c	Mon May  7 20:47:26 2001
+++ linux/fs/ufs/inode.c	Wed May  9 20:46:42 2001
@@ -518,9 +518,9 @@
 	return NULL;
 }
 
-static int ufs_writepage(struct page *page)
+static int ufs_writepage(struct page *page, int priority)
 {
-	return block_write_full_page(page,ufs_getfrag_block);
+	return block_write_full_page(page,ufs_getfrag_block,priority);
 }
 static int ufs_readpage(struct file *file, struct page *page)
 {
diff -Nur --exclude-from=exclude linux.orig/include/linux/fs.h linux/include/linux/fs.h
--- linux.orig/include/linux/fs.h	Tue May  8 16:45:42 2001
+++ linux/include/linux/fs.h	Tue May  8 22:22:38 2001
@@ -362,7 +362,7 @@
 struct address_space;
 
 struct address_space_operations {
-	int (*writepage)(struct page *);
+	int (*writepage)(struct page *, int);
 	int (*readpage)(struct file *, struct page *);
 	int (*sync_page)(struct page *);
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
@@ -1268,7 +1268,7 @@
 /* Generic buffer handling for block filesystems.. */
 extern int block_flushpage(struct page *, unsigned long);
 extern int block_symlink(struct inode *, const char *, int);
-extern int block_write_full_page(struct page*, get_block_t*);
+extern int block_write_full_page(struct page*, get_block_t*, int priority);
 extern int block_read_full_page(struct page*, get_block_t*);
 extern int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
 extern int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
diff -Nur --exclude-from=exclude linux.orig/include/linux/nfs_fs.h linux/include/linux/nfs_fs.h
--- linux.orig/include/linux/nfs_fs.h	Tue May  8 16:45:48 2001
+++ linux/include/linux/nfs_fs.h	Tue May  8 22:23:50 2001
@@ -194,7 +194,7 @@
 /*
  * linux/fs/nfs/write.c
  */
-extern int  nfs_writepage(struct page *);
+extern int  nfs_writepage(struct page *, int priority);
 extern int  nfs_flush_incompatible(struct file *file, struct page *page);
 extern int  nfs_updatepage(struct file *, struct page *, unsigned int, unsigned int);
 /*
diff -Nur --exclude-from=exclude linux.orig/mm/filemap.c linux/mm/filemap.c
--- linux.orig/mm/filemap.c	Mon May  7 20:47:26 2001
+++ linux/mm/filemap.c	Tue May  8 22:22:50 2001
@@ -411,7 +411,7 @@
  */
 void filemap_fdatasync(struct address_space * mapping)
 {
-	int (*writepage)(struct page *) = mapping->a_ops->writepage;
+	int (*writepage)(struct page *, int) = mapping->a_ops->writepage;
 
 	spin_lock(&pagecache_lock);
 
@@ -430,8 +430,7 @@
 		lock_page(page);
 
 		if (PageDirty(page)) {
-			ClearPageDirty(page);
-			writepage(page);
+			writepage(page, 1);
 		} else
 			UnlockPage(page);
 
diff -Nur --exclude-from=exclude linux.orig/mm/shmem.c linux/mm/shmem.c
--- linux.orig/mm/shmem.c	Mon May  7 20:47:26 2001
+++ linux/mm/shmem.c	Tue May  8 22:23:01 2001
@@ -221,13 +221,16 @@
  * once.  We still need to guard against racing with
  * shmem_getpage_locked().  
  */
-static int shmem_writepage(struct page * page)
+static int shmem_writepage(struct page * page, int priority)
 {
 	int error = 0;
 	struct shmem_inode_info *info;
 	swp_entry_t *entry, swap;
 	struct inode *inode;
 
+	if (!priority)
+		return -1;
+
 	if (!PageLocked(page))
 		BUG();
 	
@@ -243,6 +246,8 @@
 	if (!swap.val)
 		goto out;
 
+	ClearPageDirty(page);	
+
 	spin_lock(&info->lock);
 	entry = shmem_swp_entry(info, page->index);
 	if (IS_ERR(entry))	/* this had been allocted on page allocation */
@@ -265,7 +270,6 @@
 
 	spin_unlock(&info->lock);
 out:
-	set_page_dirty(page);
 	UnlockPage(page);
 	return error;
 }
diff -Nur --exclude-from=exclude linux.orig/mm/swap_state.c linux/mm/swap_state.c
--- linux.orig/mm/swap_state.c	Mon May  7 20:47:26 2001
+++ linux/mm/swap_state.c	Tue May  8 21:39:44 2001
@@ -21,7 +21,7 @@
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
  */
-static int swap_writepage(struct page *page)
+static int swap_writepage(struct page *page, int priority)
 {
 	/* One for the page cache, one for this user, one for page->buffers */
 	if (page_count(page) > 2 + !!page->buffers)
@@ -30,10 +30,14 @@
 		goto in_use;
 
 	/* We could remove it here, but page_launder will do it anyway */
+	ClearPageDirty(page);
 	UnlockPage(page);
 	return 0;
 
 in_use:
+	if (!priority) 
+		return -1;
+	ClearPageDirty(page);
 	rw_swap_page(WRITE, page);
 	return 0;
 }
diff -Nur --exclude-from=exclude linux.orig/mm/vmscan.c linux/mm/vmscan.c
--- linux.orig/mm/vmscan.c	Mon May  7 20:47:26 2001
+++ linux/mm/vmscan.c	Tue May  8 22:23:32 2001
@@ -472,33 +472,30 @@
 		}
 
 		/*
-		 * Dirty swap-cache page? Write it out if
+		 * Dirty page? Write it out if
 		 * last copy..
 		 */
 		if (PageDirty(page)) {
-			int (*writepage)(struct page *) = page->mapping->a_ops->writepage;
+			int (*writepage)(struct page *, int) = 
+				page->mapping->a_ops->writepage;
 
 			if (!writepage)
 				goto page_active;
-
-			/* First time through? Move it to the back of the list */
-			if (!launder_loop) {
-				list_del(page_lru);
-				list_add(page_lru, &inactive_dirty_list);
+			
+			page_cache_get(page);
+			list_del(page_lru);
+			list_add(page_lru, &inactive_dirty_list);
+			spin_unlock(&pagemap_lru_lock);
+		
+			if (writepage(page, launder_loop)) {
+				spin_lock(&pagemap_lru_lock);
 				UnlockPage(page);
+				page_cache_release(page);
 				continue;
 			}
-
-			/* OK, do a physical asynchronous write to swap.  */
-			ClearPageDirty(page);
-			page_cache_get(page);
-			spin_unlock(&pagemap_lru_lock);
-
-			writepage(page);
-			page_cache_release(page);
-
-			/* And re-start the thing.. */
+		
 			spin_lock(&pagemap_lru_lock);
+			page_cache_release(page);
 			continue;
 		}
 

