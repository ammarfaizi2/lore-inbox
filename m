Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263923AbRGBLro>; Mon, 2 Jul 2001 07:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263930AbRGBLrf>; Mon, 2 Jul 2001 07:47:35 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:40601 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S263923AbRGBLr1>; Mon, 2 Jul 2001 07:47:27 -0400
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch] tmpfs/ramfs accounting
Organisation: SAP LinuxLab
Date: 02 Jul 2001 13:46:41 +0200
Message-ID: <m3bsn35za6.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

here is the patch you backed out for -ac22.

I slightly changed the approach: I do not rely on removepage to
calculate the fs size any more since the special-casing was ugly and
PG_marker was dropped. But I use removepage for the shmem_nrpages
calculation.

Please apply
		Christoph

diff -uNr 5-ac22/fs/ramfs/inode.c 5-ac22-fix/fs/ramfs/inode.c
--- 5-ac22/fs/ramfs/inode.c	Mon Jul  2 09:13:18 2001
+++ 5-ac22-fix/fs/ramfs/inode.c	Mon Jul  2 09:55:52 2001
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
diff -uNr 5-ac22/include/linux/fs.h 5-ac22-fix/include/linux/fs.h
--- 5-ac22/include/linux/fs.h	Mon Jul  2 09:35:39 2001
+++ 5-ac22-fix/include/linux/fs.h	Mon Jul  2 10:32:04 2001
@@ -375,7 +375,7 @@
 	int (*sync_page)(struct page *);
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
-	void (*truncatepage)(struct page *); /* called from truncate_complete_page */
+	void (*removepage)(struct page *); /* called when page gets removed from the inode */
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
 	int (*bmap)(struct address_space *, long);
 };
diff -uNr 5-ac22/mm/filemap.c 5-ac22-fix/mm/filemap.c
--- 5-ac22/mm/filemap.c	Mon Jul  2 09:13:29 2001
+++ 5-ac22-fix/mm/filemap.c	Mon Jul  2 10:22:52 2001
@@ -87,6 +87,9 @@
 {
 	struct address_space * mapping = page->mapping;
 
+	if (mapping->a_ops->removepage)
+		mapping->a_ops->removepage(page);
+	
 	mapping->nrpages--;
 	list_del(&page->list);
 	page->mapping = NULL;
@@ -211,9 +214,6 @@
 	if (!page->buffers || block_flushpage(page, 0))
 		lru_cache_del(page);
 
-	if (page->mapping->a_ops->truncatepage)
-		page->mapping->a_ops->truncatepage(page);
-	
 	/*
 	 * We remove the page from the page cache _after_ we have
 	 * destroyed all buffer-cache references to it. Otherwise some
diff -uNr 5-ac22/mm/shmem.c 5-ac22-fix/mm/shmem.c
--- 5-ac22/mm/shmem.c	Mon Jul  2 09:13:29 2001
+++ 5-ac22-fix/mm/shmem.c	Mon Jul  2 10:54:55 2001
@@ -34,6 +34,7 @@
 #define TMPFS_MAGIC	0x01021994
 
 #define ENTRIES_PER_PAGE (PAGE_SIZE/sizeof(unsigned long))
+#define SHMEM_MAX_BLOCKS (SHMEM_NR_DIRECT + ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)
 
 #define SHMEM_SB(sb) (&sb->u.shmem_sb)
 
@@ -51,6 +52,11 @@
 
 #define BLOCKS_PER_PAGE (PAGE_SIZE/512)
 
+static void shmem_removepage(struct page *page)
+{
+	atomic_dec(&shmem_nrpages);
+}
+
 /*
  * shmem_recalc_inode - recalculate the size of an inode
  *
@@ -69,11 +75,9 @@
  * 			(inode->i_mapping->nrpages + info->swapped)
  *
  * It has to be called with the spinlock held.
- *
- * The swap parameter is a performance hack for truncate.
  */
 
-static void shmem_recalc_inode(struct inode * inode, unsigned long swap)
+static void shmem_recalc_inode(struct inode * inode)
 {
 	unsigned long freed;
 
@@ -85,7 +89,6 @@
 		spin_lock (&sbinfo->stat_lock);
 		sbinfo->free_blocks += freed;
 		spin_unlock (&sbinfo->stat_lock);
-		atomic_sub(freed-swap, &shmem_nrpages);
 	}
 }
 
@@ -202,7 +205,7 @@
 out:
 	info->max_index = index;
 	info->swapped -= freed;
-	shmem_recalc_inode(inode, freed);
+	shmem_recalc_inode(inode);
 	spin_unlock (&info->lock);
 	up(&info->sem);
 }
@@ -257,7 +260,7 @@
 	entry = shmem_swp_entry(info, page->index);
 	if (IS_ERR(entry))	/* this had been allocted on page allocation */
 		BUG();
-	shmem_recalc_inode(page->mapping->host, 0);
+	shmem_recalc_inode(page->mapping->host);
 	error = -EAGAIN;
 	if (entry->val)
 		BUG();
@@ -265,7 +268,6 @@
 	*entry = swap;
 	error = 0;
 	/* Remove the page from the page cache */
-	atomic_dec(&shmem_nrpages);
 	lru_cache_del(page);
 	remove_inode_page(page);
 
@@ -1086,6 +1088,8 @@
 	unsigned long max_inodes, inodes;
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
+	max_blocks = sbinfo->max_blocks;
+	max_inodes = sbinfo->max_inodes;
 	if (shmem_parse_options (data, NULL, &max_blocks, &max_inodes))
 		return -EINVAL;
 
@@ -1134,7 +1138,7 @@
 	sbinfo->free_blocks = blocks;
 	sbinfo->max_inodes = inodes;
 	sbinfo->free_inodes = inodes;
-	sb->s_maxbytes = (unsigned long long)(SHMEM_NR_DIRECT + (ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)) << PAGE_CACHE_SHIFT;
+	sb->s_maxbytes = (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT;
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = TMPFS_MAGIC;
@@ -1155,7 +1159,8 @@
 
 
 static struct address_space_operations shmem_aops = {
-	writepage: shmem_writepage
+	removepage:	shmem_removepage,
+	writepage:	shmem_writepage,
 };
 
 static struct file_operations shmem_file_operations = {
@@ -1334,9 +1339,11 @@
 	struct qstr this;
 	int vm_enough_memory(long pages);
 
-	error = -ENOMEM;
+	if (size > (unsigned long long) SHMEM_MAX_BLOCKS << PAGE_CACHE_SHIFT)
+		return ERR_PTR(-EINVAL);
+
 	if (!vm_enough_memory((size) >> PAGE_SHIFT))
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	this.name = name;
 	this.len = strlen(name);
@@ -1344,7 +1351,7 @@
 	root = tmpfs_fs_type.kern_mnt->mnt_root;
 	dentry = d_alloc(root, &this);
 	if (!dentry)
-		goto out;
+		return ERR_PTR(-ENOMEM);
 
 	error = -ENFILE;
 	file = get_empty_filp();
@@ -1370,7 +1377,6 @@
 	put_filp(file);
 put_dentry:
 	dput (dentry);
-out:
 	return ERR_PTR(error);	
 }
 /*

