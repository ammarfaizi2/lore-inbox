Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271207AbRICDzG>; Sun, 2 Sep 2001 23:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271186AbRICDyz>; Sun, 2 Sep 2001 23:54:55 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:6319 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271207AbRICDyQ>;
	Sun, 2 Sep 2001 23:54:16 -0400
Date: Sun, 2 Sep 2001 23:54:34 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] minixfs cleanup - directories in pagecache
Message-ID: <Pine.GSO.4.21.0109022354070.22951-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Minixfs directories handling is taken to pagecache.
The thing had been tested locally and it had been in -ac for
couple of months with no complaints.
	Please, apply.

diff -urN S10-pre4/fs/minix/bitmap.c S10-pre4-minix/fs/minix/bitmap.c
--- S10-pre4/fs/minix/bitmap.c	Fri Feb 16 20:12:05 2001
+++ S10-pre4-minix/fs/minix/bitmap.c	Sun Sep  2 23:32:54 2001
@@ -11,13 +11,9 @@
 
 /* bitmap.c contains the code that handles the inode and block bitmaps */
 
-#include <linux/sched.h>
+#include <linux/fs.h>
 #include <linux/minix_fs.h>
-#include <linux/stat.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
 #include <linux/locks.h>
-#include <linux/quotaops.h>
 
 #include <asm/bitops.h>
 
@@ -68,10 +64,6 @@
 		printk("trying to free block not in datazone\n");
 		return;
 	}
-	bh = get_hash_table(sb->s_dev,block,BLOCK_SIZE);
-	if (bh)
-		clear_bit(BH_Dirty, &bh->b_state);
-	brelse(bh);
 	zone = block - sb->u.minix_sb.s_firstdatazone + 1;
 	bit = zone & 8191;
 	zone >>= 13;
@@ -126,60 +118,53 @@
 		<< sb->u.minix_sb.s_log_zone_size);
 }
 
-static struct buffer_head *V1_minix_clear_inode(struct inode *inode)
+struct minix_inode *
+minix_V1_raw_inode(struct super_block *sb, ino_t ino, struct buffer_head **bh)
 {
-	struct buffer_head *bh;
-	struct minix_inode *raw_inode;
-	int ino, block;
-
-	ino = inode->i_ino;
-	if (!ino || ino > inode->i_sb->u.minix_sb.s_ninodes) {
-		printk("Bad inode number on dev %s: %d is out of range\n",
-		       kdevname(inode->i_dev), ino);
+	int block;
+	struct minix_sb_info *sbi = &sb->u.minix_sb;
+	struct minix_inode *p;
+
+	if (!ino || ino > sbi->s_ninodes) {
+		printk("Bad inode number on dev %s: %ld is out of range\n",
+		       bdevname(sb->s_dev), ino);
 		return NULL;
 	}
-	block = (2 + inode->i_sb->u.minix_sb.s_imap_blocks +
-		 inode->i_sb->u.minix_sb.s_zmap_blocks +
-		 (ino - 1) / MINIX_INODES_PER_BLOCK);
-	bh = bread(inode->i_dev, block, BLOCK_SIZE);
-	if (!bh) {
+	ino--;
+	block = 2 + sbi->s_imap_blocks + sbi->s_zmap_blocks +
+		 ino / MINIX_INODES_PER_BLOCK;
+	*bh = bread(sb->s_dev, block, BLOCK_SIZE);
+	if (!*bh) {
 		printk("unable to read i-node block\n");
 		return NULL;
 	}
-	raw_inode = ((struct minix_inode *)bh->b_data +
-		     (ino - 1) % MINIX_INODES_PER_BLOCK);
-	raw_inode->i_nlinks = 0;
-	raw_inode->i_mode = 0;
-	mark_buffer_dirty(bh);
-	return bh;
+	p = (void *)(*bh)->b_data;
+	return p + ino % MINIX_INODES_PER_BLOCK;
 }
 
-static struct buffer_head *V2_minix_clear_inode(struct inode *inode)
+struct minix2_inode *
+minix_V2_raw_inode(struct super_block *sb, ino_t ino, struct buffer_head **bh)
 {
-	struct buffer_head *bh;
-	struct minix2_inode *raw_inode;
-	int ino, block;
+	int block;
+	struct minix_sb_info *sbi = &sb->u.minix_sb;
+	struct minix2_inode *p;
 
-	ino = inode->i_ino;
-	if (!ino || ino > inode->i_sb->u.minix_sb.s_ninodes) {
-		printk("Bad inode number on dev %s: %d is out of range\n",
-		       kdevname(inode->i_dev), ino);
+	*bh = NULL;
+	if (!ino || ino > sbi->s_ninodes) {
+		printk("Bad inode number on dev %s: %ld is out of range\n",
+		       bdevname(sb->s_dev), ino);
 		return NULL;
 	}
-	block = (2 + inode->i_sb->u.minix_sb.s_imap_blocks +
-		 inode->i_sb->u.minix_sb.s_zmap_blocks +
-		 (ino - 1) / MINIX2_INODES_PER_BLOCK);
-	bh = bread(inode->i_dev, block, BLOCK_SIZE);
-	if (!bh) {
+	ino--;
+	block = 2 + sbi->s_imap_blocks + sbi->s_zmap_blocks +
+		 ino / MINIX2_INODES_PER_BLOCK;
+	*bh = bread(sb->s_dev, block, BLOCK_SIZE);
+	if (!*bh) {
 		printk("unable to read i-node block\n");
 		return NULL;
 	}
-	raw_inode = ((struct minix2_inode *) bh->b_data +
-		     (ino - 1) % MINIX2_INODES_PER_BLOCK);
-	raw_inode->i_nlinks = 0;
-	raw_inode->i_mode = 0;
-	mark_buffer_dirty(bh);
-	return bh;
+	p = (void *)(*bh)->b_data;
+	return p + ino % MINIX2_INODES_PER_BLOCK;
 }
 
 /* Clear the link count and mode of a deleted inode on disk. */
@@ -187,11 +172,25 @@
 static void minix_clear_inode(struct inode *inode)
 {
 	struct buffer_head *bh;
-	if (INODE_VERSION(inode) == MINIX_V1)
-		bh = V1_minix_clear_inode(inode);
-	else
-		bh = V2_minix_clear_inode(inode);
-	brelse (bh);
+	if (INODE_VERSION(inode) == MINIX_V1) {
+		struct minix_inode *raw_inode;
+		raw_inode = minix_V1_raw_inode(inode->i_sb, inode->i_ino, &bh);
+		if (raw_inode) {
+			raw_inode->i_nlinks = 0;
+			raw_inode->i_mode = 0;
+		}
+	} else {
+		struct minix2_inode *raw_inode;
+		raw_inode = minix_V2_raw_inode(inode->i_sb, inode->i_ino, &bh);
+		if (raw_inode) {
+			raw_inode->i_nlinks = 0;
+			raw_inode->i_mode = 0;
+		}
+	}
+	if (bh) {
+		mark_buffer_dirty(bh);
+		brelse (bh);
+	}
 }
 
 void minix_free_inode(struct inode * inode)
diff -urN S10-pre4/fs/minix/dir.c S10-pre4-minix/fs/minix/dir.c
--- S10-pre4/fs/minix/dir.c	Fri Feb 16 17:28:19 2001
+++ S10-pre4-minix/fs/minix/dir.c	Sun Sep  2 23:32:54 2001
@@ -6,53 +6,368 @@
  *  minix directory handling functions
  */
 
-#include <linux/string.h>
-#include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/minix_fs.h>
-#include <linux/stat.h>
+#include <linux/pagemap.h>
+
+typedef struct minix_dir_entry minix_dirent;
 
 static int minix_readdir(struct file *, void *, filldir_t);
 
 struct file_operations minix_dir_operations = {
 	read:		generic_read_dir,
 	readdir:	minix_readdir,
-	fsync:		file_fsync,
+	fsync:		minix_sync_file,
 };
 
-static int minix_readdir(struct file * filp,
-	void * dirent, filldir_t filldir)
+static inline void dir_put_page(struct page *page)
 {
-	unsigned int offset;
-	struct buffer_head * bh;
-	struct minix_dir_entry * de;
-	struct minix_sb_info * info;
+	kunmap(page);
+	page_cache_release(page);
+}
+
+static inline unsigned long dir_pages(struct inode *inode)
+{
+	return (inode->i_size+PAGE_CACHE_SIZE-1)>>PAGE_CACHE_SHIFT;
+}
+
+static int dir_commit_chunk(struct page *page, unsigned from, unsigned to)
+{
+	struct inode *dir = (struct inode *)page->mapping->host;
+	int err = 0;
+	page->mapping->a_ops->commit_write(NULL, page, from, to);
+	if (IS_SYNC(dir))
+		err = waitfor_one_page(page);
+	return err;
+}
+
+static struct page * dir_get_page(struct inode *dir, unsigned long n)
+{
+	struct address_space *mapping = dir->i_mapping;
+	struct page *page = read_cache_page(mapping, n,
+				(filler_t*)mapping->a_ops->readpage, NULL);
+	if (!IS_ERR(page)) {
+		wait_on_page(page);
+		kmap(page);
+		if (!Page_Uptodate(page))
+			goto fail;
+	}
+	return page;
+
+fail:
+	dir_put_page(page);
+	return ERR_PTR(-EIO);
+}
+
+static inline void *minix_next_entry(void *de, struct minix_sb_info *sbi)
+{
+	return (void*)((char*)de + sbi->s_dirsize);
+}
+
+static int minix_readdir(struct file * filp, void * dirent, filldir_t filldir)
+{
+	unsigned long pos = filp->f_pos;
 	struct inode *inode = filp->f_dentry->d_inode;
+	struct super_block *sb = inode->i_sb;
+	unsigned offset = pos & ~PAGE_CACHE_MASK;
+	unsigned long n = pos >> PAGE_CACHE_SHIFT;
+	unsigned long npages = dir_pages(inode);
+	struct minix_sb_info *sbi = &sb->u.minix_sb;
+	unsigned chunk_size = sbi->s_dirsize;
 
-	info = &inode->i_sb->u.minix_sb;
-	if (filp->f_pos & (info->s_dirsize - 1))
-		return -EBADF;
-	while (filp->f_pos < inode->i_size) {
-		offset = filp->f_pos & 1023;
-		bh = minix_bread(inode,(filp->f_pos)>>BLOCK_SIZE_BITS,0);
-		if (!bh) {
-			filp->f_pos += 1024-offset;
+	pos = (pos + chunk_size-1) & ~(chunk_size-1);
+	if (pos >= inode->i_size)
+		goto done;
+
+	for ( ; n < npages; n++, offset = 0) {
+		char *p, *kaddr, *limit;
+		struct page *page = dir_get_page(inode, n);
+
+		if (IS_ERR(page))
 			continue;
-		}
-		do {
-			de = (struct minix_dir_entry *) (offset + bh->b_data);
+		kaddr = (char *)page_address(page);
+		p = kaddr+offset;
+		limit = kaddr + PAGE_CACHE_SIZE - chunk_size;
+		for ( ; p <= limit ; p = minix_next_entry(p, sbi)) {
+			minix_dirent *de = (minix_dirent *)p;
 			if (de->inode) {
-				int size = strnlen(de->name, info->s_namelen);
-				if (filldir(dirent, de->name, size, filp->f_pos, de->inode, DT_UNKNOWN) < 0) {
-					brelse(bh);
-					return 0;
+				int over;
+				unsigned l = strnlen(de->name,sbi->s_namelen);
+
+				offset = p - kaddr;
+				over = filldir(dirent, de->name, l,
+						(n<<PAGE_CACHE_SHIFT) | offset,
+						de->inode, DT_UNKNOWN);
+				if (over) {
+					dir_put_page(page);
+					goto done;
 				}
 			}
-			offset += info->s_dirsize;
-			filp->f_pos += info->s_dirsize;
-		} while (offset < 1024 && filp->f_pos < inode->i_size);
-		brelse(bh);
+		}
+		dir_put_page(page);
 	}
+
+done:
+	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
 	UPDATE_ATIME(inode);
 	return 0;
+}
+
+static inline int namecompare(int len, int maxlen,
+	const char * name, const char * buffer)
+{
+	if (len < maxlen && buffer[len])
+		return 0;
+	return !memcmp(name, buffer, len);
+}
+
+/*
+ *	minix_find_entry()
+ *
+ * finds an entry in the specified directory with the wanted name. It
+ * returns the cache buffer in which the entry was found, and the entry
+ * itself (as a parameter - res_dir). It does NOT read the inode of the
+ * entry - you'll have to do that yourself if you want to.
+ */
+minix_dirent *minix_find_entry(struct dentry *dentry, struct page **res_page)
+{
+	const char * name = dentry->d_name.name;
+	int namelen = dentry->d_name.len;
+	struct inode * dir = dentry->d_parent->d_inode;
+	struct super_block * sb = dir->i_sb;
+	struct minix_sb_info * sbi = &sb->u.minix_sb;
+	unsigned long n;
+	unsigned long npages = dir_pages(dir);
+	struct page *page = NULL;
+	struct minix_dir_entry *de;
+
+	*res_page = NULL;
+
+	for (n = 0; n < npages; n++) {
+		char *kaddr;
+		page = dir_get_page(dir, n);
+		if (IS_ERR(page))
+			continue;
+
+		kaddr = (char*)page_address(page);
+		de = (struct minix_dir_entry *) kaddr;
+		kaddr += PAGE_CACHE_SIZE - sbi->s_dirsize;
+		for ( ; (char *) de <= kaddr ; de = minix_next_entry(de,sbi)) {
+			if (!de->inode)
+				continue;
+			if (namecompare(namelen,sbi->s_namelen,name,de->name))
+				goto found;
+		}
+		dir_put_page(page);
+	}
+	return NULL;
+
+found:
+	*res_page = page;
+	return de;
+}
+
+int minix_add_link(struct dentry *dentry, struct inode *inode)
+{
+	struct inode *dir = dentry->d_parent->d_inode;
+	const char * name = dentry->d_name.name;
+	int namelen = dentry->d_name.len;
+	struct super_block * sb = dir->i_sb;
+	struct minix_sb_info * sbi = &sb->u.minix_sb;
+	struct page *page = NULL;
+	struct minix_dir_entry * de;
+	unsigned long npages = dir_pages(dir);
+	unsigned long n;
+	char *kaddr;
+	unsigned from, to;
+	int err;
+
+	/* We take care of directory expansion in the same loop */
+	for (n = 0; n <= npages; n++) {
+		page = dir_get_page(dir, n);
+		err = PTR_ERR(page);
+		if (IS_ERR(page))
+			goto out;
+		kaddr = (char*)page_address(page);
+		de = (minix_dirent *)kaddr;
+		kaddr += PAGE_CACHE_SIZE - sbi->s_dirsize;
+		while ((char *)de <= kaddr) {
+			if (!de->inode)
+				goto got_it;
+			err = -EEXIST;
+			if (namecompare(namelen,sbi->s_namelen,name,de->name))
+				goto out_page;
+			de = minix_next_entry(de, sbi);
+		}
+		dir_put_page(page);
+	}
+	BUG();
+	return -EINVAL;
+
+got_it:
+	from = (char*)de - (char*)page_address(page);
+	to = from + sbi->s_dirsize;
+	lock_page(page);
+	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
+	if (err)
+		goto out_unlock;
+	memcpy (de->name, name, namelen);
+	memset (de->name + namelen, 0, sbi->s_dirsize - namelen - 2);
+	de->inode = inode->i_ino;
+	err = dir_commit_chunk(page, from, to);
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	mark_inode_dirty(dir);
+out_unlock:
+	UnlockPage(page);
+out_page:
+	dir_put_page(page);
+out:
+	return err;
+}
+
+int minix_delete_entry(struct minix_dir_entry *de, struct page *page)
+{
+	struct address_space *mapping = page->mapping;
+	struct inode *inode = (struct inode*)mapping->host;
+	char *kaddr = (char*)page_address(page);
+	unsigned from = (char*)de - kaddr;
+	unsigned to = from + inode->i_sb->u.minix_sb.s_dirsize;
+	int err;
+
+	lock_page(page);
+	err = mapping->a_ops->prepare_write(NULL, page, from, to);
+	if (err)
+		BUG();
+	de->inode = 0;
+	err = dir_commit_chunk(page, from, to);
+	UnlockPage(page);
+	dir_put_page(page);
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	mark_inode_dirty(inode);
+	return err;
+}
+
+int minix_make_empty(struct inode *inode, struct inode *dir)
+{
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page = grab_cache_page(mapping, 0);
+	struct minix_sb_info * sbi = &inode->i_sb->u.minix_sb;
+	struct minix_dir_entry * de;
+	char *base;
+	int err;
+
+	if (!page)
+		return -ENOMEM;
+	err = mapping->a_ops->prepare_write(NULL, page, 0, 2 * sbi->s_dirsize);
+	if (err)
+		goto fail;
+
+	base = (char*)page_address(page);
+	memset(base, 0, PAGE_CACHE_SIZE);
+
+	de = (struct minix_dir_entry *) base;
+	de->inode = inode->i_ino;
+	strcpy(de->name,".");
+	de = minix_next_entry(de, sbi);
+	de->inode = dir->i_ino;
+	strcpy(de->name,"..");
+
+	err = dir_commit_chunk(page, 0, 2 * sbi->s_dirsize);
+fail:
+	UnlockPage(page);
+	page_cache_release(page);
+	return err;
+}
+
+/*
+ * routine to check that the specified directory is empty (for rmdir)
+ */
+int minix_empty_dir(struct inode * inode)
+{
+	struct page *page = NULL;
+	unsigned long i, npages = dir_pages(inode);
+	struct minix_sb_info *sbi = &inode->i_sb->u.minix_sb;
+
+	for (i = 0; i < npages; i++) {
+		char *kaddr;
+		minix_dirent * de;
+		page = dir_get_page(inode, i);
+
+		if (IS_ERR(page))
+			continue;
+
+		kaddr = (char *)page_address(page);
+		de = (minix_dirent *)kaddr;
+		kaddr += PAGE_CACHE_SIZE - sbi->s_dirsize;
+
+		while ((char *)de <= kaddr) {
+			if (de->inode != 0) {
+				/* check for . and .. */
+				if (de->name[0] != '.')
+					goto not_empty;
+				if (!de->name[1]) {
+					if (de->inode != inode->i_ino)
+						goto not_empty;
+				} else if (de->name[1] != '.')
+					goto not_empty;
+				else if (de->name[2])
+					goto not_empty;
+			}
+			de = minix_next_entry(de, sbi);
+		}
+		dir_put_page(page);
+	}
+	return 1;
+
+not_empty:
+	dir_put_page(page);
+	return 0;
+}
+
+/* Releases the page */
+void minix_set_link(struct minix_dir_entry *de, struct page *page,
+	struct inode *inode)
+{
+	struct inode *dir = (struct inode*)page->mapping->host;
+	struct minix_sb_info *sbi = &dir->i_sb->u.minix_sb;
+	unsigned from = (char *)de-(char*)page_address(page);
+	unsigned to = from + sbi->s_dirsize;
+	int err;
+
+	lock_page(page);
+	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
+	if (err)
+		BUG();
+	de->inode = inode->i_ino;
+	err = dir_commit_chunk(page, from, to);
+	UnlockPage(page);
+	dir_put_page(page);
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	mark_inode_dirty(dir);
+}
+
+struct minix_dir_entry * minix_dotdot (struct inode *dir, struct page **p)
+{
+	struct page *page = dir_get_page(dir, 0);
+	struct minix_sb_info *sbi = &dir->i_sb->u.minix_sb;
+	struct minix_dir_entry *de = NULL;
+
+	if (!IS_ERR(page)) {
+		de = minix_next_entry(page_address(page), sbi);
+		*p = page;
+	}
+	return de;
+}
+
+ino_t minix_inode_by_name(struct dentry *dentry)
+{
+	struct page *page;
+	struct minix_dir_entry *de = minix_find_entry(dentry, &page);
+	ino_t res = 0;
+
+	if (de) {
+		res = de->inode;
+		dir_put_page(page);
+	}
+	return res;
 }
diff -urN S10-pre4/fs/minix/file.c S10-pre4-minix/fs/minix/file.c
--- S10-pre4/fs/minix/file.c	Fri Feb 16 19:00:24 2001
+++ S10-pre4-minix/fs/minix/file.c	Sun Sep  2 23:32:54 2001
@@ -13,7 +13,7 @@
  * We have mostly NULLs here: the current defaults are OK for
  * the minix filesystem.
  */
-static int minix_sync_file(struct file *, struct dentry *, int);
+int minix_sync_file(struct file *, struct dentry *, int);
 
 struct file_operations minix_file_operations = {
 	read:		generic_file_read,
@@ -26,14 +26,16 @@
 	truncate:	minix_truncate,
 };
 
-static int minix_sync_file(struct file * file,
-			   struct dentry *dentry,
-			   int datasync)
+int minix_sync_file(struct file * file, struct dentry *dentry, int datasync)
 {
 	struct inode *inode = dentry->d_inode;
+	int err  = fsync_inode_buffers(inode);
 
-	if (INODE_VERSION(inode) == MINIX_V1)
-		return V1_minix_sync_file(inode);
-	else
-		return V2_minix_sync_file(inode);
+	if (!(inode->i_state & I_DIRTY))
+		return err;
+	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
+		return err;
+	
+	err |= minix_sync_inode(inode);
+	return err ? -EIO : 0;
 }
diff -urN S10-pre4/fs/minix/inode.c S10-pre4-minix/fs/minix/inode.c
--- S10-pre4/fs/minix/inode.c	Thu Apr 19 23:46:46 2001
+++ S10-pre4-minix/fs/minix/inode.c	Sun Sep  2 23:32:54 2001
@@ -11,23 +11,15 @@
 
 #include <linux/module.h>
 
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/minix_fs.h>
 #include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/stat.h>
 #include <linux/locks.h>
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/highuid.h>
 #include <linux/blkdev.h>
 
-#include <asm/system.h>
-#include <asm/bitops.h>
-
-#include <linux/minix_fs.h>
-
 static void minix_read_inode(struct inode * inode);
 static void minix_write_inode(struct inode * inode, int wait);
 static int minix_statfs(struct super_block *sb, struct statfs *buf);
@@ -127,48 +119,6 @@
 	return 0;
 }
 
-/*
- * Check the root directory of the filesystem to make sure
- * it really _is_ a Minix filesystem, and to check the size
- * of the directory entry.
- */
-static const char * minix_checkroot(struct super_block *s, struct inode *dir)
-{
-	struct buffer_head *bh;
-	struct minix_dir_entry *de;
-	const char * errmsg;
-	int dirsize;
-
-	if (!S_ISDIR(dir->i_mode))
-		return "root directory is not a directory";
-
-	bh = minix_bread(dir, 0, 0);
-	if (!bh)
-		return "unable to read root directory";
-
-	de = (struct minix_dir_entry *) bh->b_data;
-	errmsg = "bad root directory '.' entry";
-	dirsize = BLOCK_SIZE;
-	if (de->inode == MINIX_ROOT_INO && strcmp(de->name, ".") == 0) {
-		errmsg = "bad root directory '..' entry";
-		dirsize = 8;
-	}
-
-	while ((dirsize <<= 1) < BLOCK_SIZE) {
-		de = (struct minix_dir_entry *) (bh->b_data + dirsize);
-		if (de->inode != MINIX_ROOT_INO)
-			continue;
-		if (strcmp(de->name, ".."))
-			continue;
-		s->u.minix_sb.s_dirsize = dirsize;
-		s->u.minix_sb.s_namelen = dirsize - 2;
-		errmsg = NULL;
-		break;
-	}
-	brelse(bh);
-	return errmsg;
-}
-
 static struct super_block *minix_read_super(struct super_block *s, void *data,
 				     int silent)
 {
@@ -177,9 +127,9 @@
 	struct minix_super_block *ms;
 	int i, block;
 	kdev_t dev = s->s_dev;
-	const char * errmsg;
 	struct inode *root_inode;
 	unsigned int hblock;
+	struct minix_sb_info *sbi = &s->u.minix_sb;
 
 	/* N.B. These should be compile-time tests.
 	   Unfortunately that is impossible. */
@@ -197,104 +147,96 @@
 		goto out_bad_sb;
 
 	ms = (struct minix_super_block *) bh->b_data;
-	s->u.minix_sb.s_ms = ms;
-	s->u.minix_sb.s_sbh = bh;
-	s->u.minix_sb.s_mount_state = ms->s_state;
+	sbi->s_ms = ms;
+	sbi->s_sbh = bh;
+	sbi->s_mount_state = ms->s_state;
 	s->s_blocksize = BLOCK_SIZE;
 	s->s_blocksize_bits = BLOCK_SIZE_BITS;
-	s->u.minix_sb.s_ninodes = ms->s_ninodes;
-	s->u.minix_sb.s_nzones = ms->s_nzones;
-	s->u.minix_sb.s_imap_blocks = ms->s_imap_blocks;
-	s->u.minix_sb.s_zmap_blocks = ms->s_zmap_blocks;
-	s->u.minix_sb.s_firstdatazone = ms->s_firstdatazone;
-	s->u.minix_sb.s_log_zone_size = ms->s_log_zone_size;
-	s->u.minix_sb.s_max_size = ms->s_max_size;
+	sbi->s_ninodes = ms->s_ninodes;
+	sbi->s_nzones = ms->s_nzones;
+	sbi->s_imap_blocks = ms->s_imap_blocks;
+	sbi->s_zmap_blocks = ms->s_zmap_blocks;
+	sbi->s_firstdatazone = ms->s_firstdatazone;
+	sbi->s_log_zone_size = ms->s_log_zone_size;
+	sbi->s_max_size = ms->s_max_size;
 	s->s_magic = ms->s_magic;
 	if (s->s_magic == MINIX_SUPER_MAGIC) {
-		s->u.minix_sb.s_version = MINIX_V1;
-		s->u.minix_sb.s_dirsize = 16;
-		s->u.minix_sb.s_namelen = 14;
-		s->u.minix_sb.s_link_max = MINIX_LINK_MAX;
+		sbi->s_version = MINIX_V1;
+		sbi->s_dirsize = 16;
+		sbi->s_namelen = 14;
+		sbi->s_link_max = MINIX_LINK_MAX;
 	} else if (s->s_magic == MINIX_SUPER_MAGIC2) {
-		s->u.minix_sb.s_version = MINIX_V1;
-		s->u.minix_sb.s_dirsize = 32;
-		s->u.minix_sb.s_namelen = 30;
-		s->u.minix_sb.s_link_max = MINIX_LINK_MAX;
+		sbi->s_version = MINIX_V1;
+		sbi->s_dirsize = 32;
+		sbi->s_namelen = 30;
+		sbi->s_link_max = MINIX_LINK_MAX;
 	} else if (s->s_magic == MINIX2_SUPER_MAGIC) {
-		s->u.minix_sb.s_version = MINIX_V2;
-		s->u.minix_sb.s_nzones = ms->s_zones;
-		s->u.minix_sb.s_dirsize = 16;
-		s->u.minix_sb.s_namelen = 14;
-		s->u.minix_sb.s_link_max = MINIX2_LINK_MAX;
+		sbi->s_version = MINIX_V2;
+		sbi->s_nzones = ms->s_zones;
+		sbi->s_dirsize = 16;
+		sbi->s_namelen = 14;
+		sbi->s_link_max = MINIX2_LINK_MAX;
 	} else if (s->s_magic == MINIX2_SUPER_MAGIC2) {
-		s->u.minix_sb.s_version = MINIX_V2;
-		s->u.minix_sb.s_nzones = ms->s_zones;
-		s->u.minix_sb.s_dirsize = 32;
-		s->u.minix_sb.s_namelen = 30;
-		s->u.minix_sb.s_link_max = MINIX2_LINK_MAX;
+		sbi->s_version = MINIX_V2;
+		sbi->s_nzones = ms->s_zones;
+		sbi->s_dirsize = 32;
+		sbi->s_namelen = 30;
+		sbi->s_link_max = MINIX2_LINK_MAX;
 	} else
 		goto out_no_fs;
 
 	/*
 	 * Allocate the buffer map to keep the superblock small.
 	 */
-	i = (s->u.minix_sb.s_imap_blocks + s->u.minix_sb.s_zmap_blocks) * sizeof(bh);
+	i = (sbi->s_imap_blocks + sbi->s_zmap_blocks) * sizeof(bh);
 	map = kmalloc(i, GFP_KERNEL);
 	if (!map)
 		goto out_no_map;
 	memset(map, 0, i);
-	s->u.minix_sb.s_imap = &map[0];
-	s->u.minix_sb.s_zmap = &map[s->u.minix_sb.s_imap_blocks];
+	sbi->s_imap = &map[0];
+	sbi->s_zmap = &map[sbi->s_imap_blocks];
 
 	block=2;
-	for (i=0 ; i < s->u.minix_sb.s_imap_blocks ; i++) {
-		if (!(s->u.minix_sb.s_imap[i]=bread(dev,block,BLOCK_SIZE)))
+	for (i=0 ; i < sbi->s_imap_blocks ; i++) {
+		if (!(sbi->s_imap[i]=bread(dev,block,BLOCK_SIZE)))
 			goto out_no_bitmap;
 		block++;
 	}
-	for (i=0 ; i < s->u.minix_sb.s_zmap_blocks ; i++) {
-		if (!(s->u.minix_sb.s_zmap[i]=bread(dev,block,BLOCK_SIZE)))
+	for (i=0 ; i < sbi->s_zmap_blocks ; i++) {
+		if (!(sbi->s_zmap[i]=bread(dev,block,BLOCK_SIZE)))
 			goto out_no_bitmap;
 		block++;
 	}
 
-	minix_set_bit(0,s->u.minix_sb.s_imap[0]->b_data);
-	minix_set_bit(0,s->u.minix_sb.s_zmap[0]->b_data);
+	minix_set_bit(0,sbi->s_imap[0]->b_data);
+	minix_set_bit(0,sbi->s_zmap[0]->b_data);
 
 	/* set up enough so that it can read an inode */
 	s->s_op = &minix_sops;
 	root_inode = iget(s, MINIX_ROOT_INO);
 	if (!root_inode)
 		goto out_no_root;
-	/*
-	 * Check the fs before we get the root dentry ...
-	 */
-	errmsg = minix_checkroot(s, root_inode);
-	if (errmsg)
-		goto out_bad_root;
 
 	s->s_root = d_alloc_root(root_inode);
 	if (!s->s_root)
 		goto out_iput;
 
-	s->s_root->d_op = &minix_dentry_operations;
+	if (!NO_TRUNCATE)
+		s->s_root->d_op = &minix_dentry_operations;
 
 	if (!(s->s_flags & MS_RDONLY)) {
 		ms->s_state &= ~MINIX_VALID_FS;
 		mark_buffer_dirty(bh);
 		s->s_dirt = 1;
 	}
-	if (!(s->u.minix_sb.s_mount_state & MINIX_VALID_FS))
+	if (!(sbi->s_mount_state & MINIX_VALID_FS))
 		printk ("MINIX-fs: mounting unchecked file system, "
 			"running fsck is recommended.\n");
- 	else if (s->u.minix_sb.s_mount_state & MINIX_ERROR_FS)
+ 	else if (sbi->s_mount_state & MINIX_ERROR_FS)
 		printk ("MINIX-fs: mounting file system with errors, "
 			"running fsck is recommended.\n");
 	return s;
 
-out_bad_root:
-	if (!silent)
-		printk("MINIX-fs: %s\n", errmsg);
 out_iput:
 	iput(root_inode);
 	goto out_freemap;
@@ -307,11 +249,11 @@
 out_no_bitmap:
 	printk("MINIX-fs: bad superblock or unable to read bitmaps\n");
     out_freemap:
-	for (i = 0; i < s->u.minix_sb.s_imap_blocks; i++)
-		brelse(s->u.minix_sb.s_imap[i]);
-	for (i = 0; i < s->u.minix_sb.s_zmap_blocks; i++)
-		brelse(s->u.minix_sb.s_zmap[i]);
-	kfree(s->u.minix_sb.s_imap);
+	for (i = 0; i < sbi->s_imap_blocks; i++)
+		brelse(sbi->s_imap[i]);
+	for (i = 0; i < sbi->s_zmap_blocks; i++)
+		brelse(sbi->s_zmap[i]);
+	kfree(sbi->s_imap);
 	goto out_release;
 
 out_no_map:
@@ -359,45 +301,6 @@
 		return V2_minix_get_block(inode, block, bh_result, create);
 }
 
-/*
- * the global minix fs getblk function.
- */
-struct buffer_head *minix_getblk(struct inode *inode, int block, int create)
-{
-	struct buffer_head dummy;
-	int error;
-
-	dummy.b_state = 0;
-	dummy.b_blocknr = -1000;
-	error = minix_get_block(inode, block, &dummy, create);
-	if (!error && buffer_mapped(&dummy)) {
-		struct buffer_head *bh;
-		bh = getblk(dummy.b_dev, dummy.b_blocknr, BLOCK_SIZE);
-		if (buffer_new(&dummy)) {
-			memset(bh->b_data, 0, BLOCK_SIZE);
-			mark_buffer_uptodate(bh, 1);
-			mark_buffer_dirty(bh);
-		}
-		return bh;
-	}
-	return NULL;
-}
-
-struct buffer_head * minix_bread(struct inode * inode, int block, int create)
-{
-	struct buffer_head * bh;
-
-	bh = minix_getblk(inode, block, create);
-	if (!bh || buffer_uptodate(bh))
-		return bh;
-	ll_rw_block(READ, 1, &bh);
-	wait_on_buffer(bh);
-	if (buffer_uptodate(bh))
-		return bh;
-	brelse(bh);
-	return NULL;
-}
-
 static int minix_writepage(struct page *page)
 {
 	return block_write_full_page(page,minix_get_block);
@@ -414,7 +317,7 @@
 {
 	return generic_block_bmap(mapping,block,minix_get_block);
 }
-struct address_space_operations minix_aops = {
+static struct address_space_operations minix_aops = {
 	readpage: minix_readpage,
 	writepage: minix_writepage,
 	sync_page: block_sync_page,
@@ -423,6 +326,23 @@
 	bmap: minix_bmap
 };
 
+void minix_set_inode(struct inode *inode, dev_t rdev)
+{
+	if (S_ISREG(inode->i_mode)) {
+		inode->i_op = &minix_file_inode_operations;
+		inode->i_fop = &minix_file_operations;
+		inode->i_mapping->a_ops = &minix_aops;
+	} else if (S_ISDIR(inode->i_mode)) {
+		inode->i_op = &minix_dir_inode_operations;
+		inode->i_fop = &minix_dir_operations;
+		inode->i_mapping->a_ops = &minix_aops;
+	} else if (S_ISLNK(inode->i_mode)) {
+		inode->i_op = &page_symlink_inode_operations;
+		inode->i_mapping->a_ops = &minix_aops;
+	} else
+		init_special_inode(inode, inode->i_mode, rdev);
+}
+
 /*
  * The minix V1 function to read an inode.
  */
@@ -430,26 +350,11 @@
 {
 	struct buffer_head * bh;
 	struct minix_inode * raw_inode;
-	int block, ino;
+	int i;
 
-	ino = inode->i_ino;
-	inode->i_mode = 0;
-	if (!ino || ino > inode->i_sb->u.minix_sb.s_ninodes) {
-		printk("Bad inode number on dev %s"
-		       ": %d is out of range\n",
-			kdevname(inode->i_dev), ino);
+	raw_inode = minix_V1_raw_inode(inode->i_sb, inode->i_ino, &bh);
+	if (!raw_inode)
 		return;
-	}
-	block = 2 + inode->i_sb->u.minix_sb.s_imap_blocks +
-		    inode->i_sb->u.minix_sb.s_zmap_blocks +
-		    (ino-1)/MINIX_INODES_PER_BLOCK;
-	if (!(bh=bread(inode->i_dev,block, BLOCK_SIZE))) {
-		printk("Major problem: unable to read inode from dev "
-		       "%s\n", kdevname(inode->i_dev));
-		return;
-	}
-	raw_inode = ((struct minix_inode *) bh->b_data) +
-		    (ino-1)%MINIX_INODES_PER_BLOCK;
 	inode->i_mode = raw_inode->i_mode;
 	inode->i_uid = (uid_t)raw_inode->i_uid;
 	inode->i_gid = (gid_t)raw_inode->i_gid;
@@ -457,20 +362,9 @@
 	inode->i_size = raw_inode->i_size;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = raw_inode->i_time;
 	inode->i_blocks = inode->i_blksize = 0;
-	for (block = 0; block < 9; block++)
-		inode->u.minix_i.u.i1_data[block] = raw_inode->i_zone[block];
-	if (S_ISREG(inode->i_mode)) {
-		inode->i_op = &minix_file_inode_operations;
-		inode->i_fop = &minix_file_operations;
-		inode->i_mapping->a_ops = &minix_aops;
-	} else if (S_ISDIR(inode->i_mode)) {
-		inode->i_op = &minix_dir_inode_operations;
-		inode->i_fop = &minix_dir_operations;
-	} else if (S_ISLNK(inode->i_mode)) {
-		inode->i_op = &page_symlink_inode_operations;
-		inode->i_mapping->a_ops = &minix_aops;
-	} else
-		init_special_inode(inode, inode->i_mode, raw_inode->i_zone[0]);
+	for (i = 0; i < 9; i++)
+		inode->u.minix_i.u.i1_data[i] = raw_inode->i_zone[i];
+	minix_set_inode(inode, raw_inode->i_zone[0]);
 	brelse(bh);
 }
 
@@ -481,26 +375,11 @@
 {
 	struct buffer_head * bh;
 	struct minix2_inode * raw_inode;
-	int block, ino;
+	int i;
 
-	ino = inode->i_ino;
-	inode->i_mode = 0;
-	if (!ino || ino > inode->i_sb->u.minix_sb.s_ninodes) {
-		printk("Bad inode number on dev %s"
-		       ": %d is out of range\n",
-			kdevname(inode->i_dev), ino);
-		return;
-	}
-	block = 2 + inode->i_sb->u.minix_sb.s_imap_blocks +
-		    inode->i_sb->u.minix_sb.s_zmap_blocks +
-		    (ino-1)/MINIX2_INODES_PER_BLOCK;
-	if (!(bh=bread(inode->i_dev,block, BLOCK_SIZE))) {
-		printk("Major problem: unable to read inode from dev "
-		       "%s\n", kdevname(inode->i_dev));
+	raw_inode = minix_V2_raw_inode(inode->i_sb, inode->i_ino, &bh);
+	if (!raw_inode)
 		return;
-	}
-	raw_inode = ((struct minix2_inode *) bh->b_data) +
-		    (ino-1)%MINIX2_INODES_PER_BLOCK;
 	inode->i_mode = raw_inode->i_mode;
 	inode->i_uid = (uid_t)raw_inode->i_uid;
 	inode->i_gid = (gid_t)raw_inode->i_gid;
@@ -510,20 +389,9 @@
 	inode->i_atime = raw_inode->i_atime;
 	inode->i_ctime = raw_inode->i_ctime;
 	inode->i_blocks = inode->i_blksize = 0;
-	for (block = 0; block < 10; block++)
-		inode->u.minix_i.u.i2_data[block] = raw_inode->i_zone[block];
-	if (S_ISREG(inode->i_mode)) {
-		inode->i_op = &minix_file_inode_operations;
-		inode->i_fop = &minix_file_operations;
-		inode->i_mapping->a_ops = &minix_aops;
-	} else if (S_ISDIR(inode->i_mode)) {
-		inode->i_op = &minix_dir_inode_operations;
-		inode->i_fop = &minix_dir_operations;
-	} else if (S_ISLNK(inode->i_mode)) {
-		inode->i_op = &page_symlink_inode_operations;
-		inode->i_mapping->a_ops = &minix_aops;
-	} else
-		init_special_inode(inode, inode->i_mode, raw_inode->i_zone[0]);
+	for (i = 0; i < 10; i++)
+		inode->u.minix_i.u.i2_data[i] = raw_inode->i_zone[i];
+	minix_set_inode(inode, raw_inode->i_zone[0]);
 	brelse(bh);
 }
 
@@ -545,23 +413,11 @@
 {
 	struct buffer_head * bh;
 	struct minix_inode * raw_inode;
-	int ino, block;
+	int i;
 
-	ino = inode->i_ino;
-	if (!ino || ino > inode->i_sb->u.minix_sb.s_ninodes) {
-		printk("Bad inode number on dev %s"
-		       ": %d is out of range\n",
-			kdevname(inode->i_dev), ino);
-		return 0;
-	}
-	block = 2 + inode->i_sb->u.minix_sb.s_imap_blocks + inode->i_sb->u.minix_sb.s_zmap_blocks +
-		(ino-1)/MINIX_INODES_PER_BLOCK;
-	if (!(bh=bread(inode->i_dev, block, BLOCK_SIZE))) {
-		printk("unable to read i-node block\n");
+	raw_inode = minix_V1_raw_inode(inode->i_sb, inode->i_ino, &bh);
+	if (!raw_inode)
 		return 0;
-	}
-	raw_inode = ((struct minix_inode *)bh->b_data) +
-		(ino-1)%MINIX_INODES_PER_BLOCK;
 	raw_inode->i_mode = inode->i_mode;
 	raw_inode->i_uid = fs_high2lowuid(inode->i_uid);
 	raw_inode->i_gid = fs_high2lowgid(inode->i_gid);
@@ -570,8 +426,8 @@
 	raw_inode->i_time = inode->i_mtime;
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
 		raw_inode->i_zone[0] = kdev_t_to_nr(inode->i_rdev);
-	else for (block = 0; block < 9; block++)
-		raw_inode->i_zone[block] = inode->u.minix_i.u.i1_data[block];
+	else for (i = 0; i < 9; i++)
+		raw_inode->i_zone[i] = inode->u.minix_i.u.i1_data[i];
 	mark_buffer_dirty(bh);
 	return bh;
 }
@@ -583,23 +439,11 @@
 {
 	struct buffer_head * bh;
 	struct minix2_inode * raw_inode;
-	int ino, block;
+	int i;
 
-	ino = inode->i_ino;
-	if (!ino || ino > inode->i_sb->u.minix_sb.s_ninodes) {
-		printk("Bad inode number on dev %s"
-		       ": %d is out of range\n",
-			kdevname(inode->i_dev), ino);
+	raw_inode = minix_V2_raw_inode(inode->i_sb, inode->i_ino, &bh);
+	if (!raw_inode)
 		return 0;
-	}
-	block = 2 + inode->i_sb->u.minix_sb.s_imap_blocks + inode->i_sb->u.minix_sb.s_zmap_blocks +
-		(ino-1)/MINIX2_INODES_PER_BLOCK;
-	if (!(bh=bread(inode->i_dev, block, BLOCK_SIZE))) {
-		printk("unable to read i-node block\n");
-		return 0;
-	}
-	raw_inode = ((struct minix2_inode *)bh->b_data) +
-		(ino-1)%MINIX2_INODES_PER_BLOCK;
 	raw_inode->i_mode = inode->i_mode;
 	raw_inode->i_uid = fs_high2lowuid(inode->i_uid);
 	raw_inode->i_gid = fs_high2lowgid(inode->i_gid);
@@ -610,8 +454,8 @@
 	raw_inode->i_ctime = inode->i_ctime;
 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
 		raw_inode->i_zone[0] = kdev_t_to_nr(inode->i_rdev);
-	else for (block = 0; block < 10; block++)
-		raw_inode->i_zone[block] = inode->u.minix_i.u.i2_data[block];
+	else for (i = 0; i < 10; i++)
+		raw_inode->i_zone[i] = inode->u.minix_i.u.i2_data[i];
 	mark_buffer_dirty(bh);
 	return bh;
 }
diff -urN S10-pre4/fs/minix/itree_common.c S10-pre4-minix/fs/minix/itree_common.c
--- S10-pre4/fs/minix/itree_common.c	Tue Jul  3 21:09:13 2001
+++ S10-pre4-minix/fs/minix/itree_common.c	Sun Sep  2 23:32:54 2001
@@ -87,7 +87,7 @@
 		*branch[n].p = branch[n].key;
 		mark_buffer_uptodate(bh, 1);
 		unlock_buffer(bh);
-		mark_buffer_dirty(bh);
+		mark_buffer_dirty_inode(bh, inode);
 		parent = nr;
 	}
 	if (n == num)
@@ -127,7 +127,7 @@
 
 	/* had we spliced it onto indirect block? */
 	if (where->bh)
-		mark_buffer_dirty(where->bh);
+		mark_buffer_dirty_inode(where->bh, inode);
 
 	mark_inode_dirty(inode);
 	return 0;
@@ -320,14 +320,14 @@
 		if (partial == chain)
 			mark_inode_dirty(inode);
 		else
-			mark_buffer_dirty(partial->bh);
+			mark_buffer_dirty_inode(partial->bh, inode);
 		free_branches(inode, &nr, &nr+1, (chain+n-1) - partial);
 	}
 	/* Clear the ends of indirect blocks on the shared branch */
 	while (partial > chain) {
 		free_branches(inode, partial->p + 1, block_end(partial->bh),
 				(chain+n-1) - partial);
-		mark_buffer_dirty(partial->bh);
+		mark_buffer_dirty_inode(partial->bh, inode);
 		brelse (partial->bh);
 		partial--;
 	}
@@ -344,74 +344,4 @@
 	}
 	inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 	mark_inode_dirty(inode);
-}
-
-static int sync_block (struct inode * inode, block_t block, int wait)
-{
-	struct buffer_head * bh;
-	
-	if (!block)
-		return 0;
-	bh = get_hash_table(inode->i_dev, block_to_cpu(block), BLOCK_SIZE);
-	if (!bh)
-		return 0;
-	if (wait && buffer_req(bh) && !buffer_uptodate(bh)) {
-		brelse(bh);
-		return -1;
-	}
-	if (wait || !buffer_uptodate(bh) || !buffer_dirty(bh))
-	{
-		brelse(bh);
-		return 0;
-	}
-	ll_rw_block(WRITE, 1, &bh);
-	atomic_dec(&bh->b_count);
-	return 0;
-}
-
-static int sync_indirect(struct inode *inode, block_t iblock, int depth,
-			 int wait)
-{
-	struct buffer_head * ind_bh = NULL;
-	int rc, err = 0;
-
-	if (!iblock)
-		return 0;
-
-	rc = sync_block (inode, iblock, wait);
-	if (rc)
-		return rc;
-
-	ind_bh = bread(inode->i_dev, block_to_cpu(iblock), BLOCK_SIZE);
-	if (!ind_bh)
-		return -1;
-
-	if (--depth) {
-		block_t *p = (block_t*)ind_bh->b_data;
-		block_t *end = block_end(ind_bh);
-		while (p < end) {
-			rc = sync_indirect (inode, *p++, depth, wait);
-			if (rc > 0)
-				break;
-			if (rc)
-				err = rc;
-		}
-	}
-	brelse(ind_bh);
-	return err;
-}
-
-static inline int sync_file(struct inode * inode)
-{
-	int wait, err = 0, i;
-	block_t *idata = i_data(inode);
-	
-	lock_kernel();
-	err = generic_buffer_fdatasync(inode, 0, ~0UL);
-	for (wait=0; wait<=1; wait++)
-		for (i=1; i<DEPTH; i++)
-			err |= sync_indirect(inode, idata[DIRECT+i-1], i, wait);
-	err |= minix_sync_inode (inode);
-	unlock_kernel();
-	return (err < 0) ? -EIO : 0;
 }
diff -urN S10-pre4/fs/minix/itree_v1.c S10-pre4-minix/fs/minix/itree_v1.c
--- S10-pre4/fs/minix/itree_v1.c	Fri Feb 16 19:00:24 2001
+++ S10-pre4-minix/fs/minix/itree_v1.c	Sun Sep  2 23:32:54 2001
@@ -1,6 +1,6 @@
-#include <linux/sched.h>
-#include <linux/locks.h>
+#include <linux/fs.h>
 #include <linux/minix_fs.h>
+#include <linux/locks.h>
 #include <linux/smp_lock.h>
 
 enum {DEPTH = 3, DIRECT = 7};	/* Only double indirect */
@@ -55,9 +55,4 @@
 void V1_minix_truncate(struct inode * inode)
 {
 	truncate(inode);
-}
-
-int V1_minix_sync_file(struct inode * inode)
-{
-	return sync_file(inode);
 }
diff -urN S10-pre4/fs/minix/itree_v2.c S10-pre4-minix/fs/minix/itree_v2.c
--- S10-pre4/fs/minix/itree_v2.c	Fri Feb 16 19:00:24 2001
+++ S10-pre4-minix/fs/minix/itree_v2.c	Sun Sep  2 23:32:54 2001
@@ -1,6 +1,6 @@
-#include <linux/sched.h>
-#include <linux/locks.h>
+#include <linux/fs.h>
 #include <linux/minix_fs.h>
+#include <linux/locks.h>
 #include <linux/smp_lock.h>
 
 enum {DIRECT = 7, DEPTH = 4};	/* Have triple indirect */
@@ -60,9 +60,4 @@
 void V2_minix_truncate(struct inode * inode)
 {
 	truncate(inode);
-}
-
-int V2_minix_sync_file(struct inode * inode)
-{
-	return sync_file(inode);
 }
diff -urN S10-pre4/fs/minix/namei.c S10-pre4-minix/fs/minix/namei.c
--- S10-pre4/fs/minix/namei.c	Fri Feb 16 19:13:57 2001
+++ S10-pre4-minix/fs/minix/namei.c	Sun Sep  2 23:32:54 2001
@@ -4,84 +4,33 @@
  *  Copyright (C) 1991, 1992  Linus Torvalds
  */
 
-#include <linux/sched.h>
+#include <linux/fs.h>
 #include <linux/minix_fs.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/stat.h>
-#include <linux/fcntl.h>
-#include <linux/errno.h>
-#include <linux/quotaops.h>
-
-#include <asm/uaccess.h>
-
-/*
- * comment out this line if you want names > info->s_namelen chars to be
- * truncated. Else they will be disallowed (ENAMETOOLONG).
- */
-/* #define NO_TRUNCATE */
+#include <linux/pagemap.h>
 
-static inline int namecompare(int len, int maxlen,
-	const char * name, const char * buffer)
+static inline void inc_count(struct inode *inode)
 {
-	if (len < maxlen && buffer[len])
-		return 0;
-	return !memcmp(name, buffer, len);
+	inode->i_nlink++;
+	mark_inode_dirty(inode);
 }
 
-/*
- *	minix_find_entry()
- *
- * finds an entry in the specified directory with the wanted name. It
- * returns the cache buffer in which the entry was found, and the entry
- * itself (as a parameter - res_dir). It does NOT read the inode of the
- * entry - you'll have to do that yourself if you want to.
- */
-static struct buffer_head * minix_find_entry(struct inode * dir,
-	const char * name, int namelen, struct minix_dir_entry ** res_dir)
-{
-	unsigned long block, offset;
-	struct buffer_head * bh;
-	struct minix_sb_info * info;
-	struct minix_dir_entry *de;
-
-	*res_dir = NULL;
-	info = &dir->i_sb->u.minix_sb;
-	if (namelen > info->s_namelen) {
-#ifdef NO_TRUNCATE
-		return NULL;
-#else
-		namelen = info->s_namelen;
-#endif
-	}
-	bh = NULL;
-	block = offset = 0;
-	while (block*BLOCK_SIZE+offset < dir->i_size) {
-		if (!bh) {
-			bh = minix_bread(dir,block,0);
-			if (!bh) {
-				block++;
-				continue;
-			}
-		}
-		de = (struct minix_dir_entry *) (bh->b_data + offset);
-		offset += info->s_dirsize;
-		if (de->inode && namecompare(namelen,info->s_namelen,name,de->name)) {
-			*res_dir = de;
-			return bh;
-		}
-		if (offset < bh->b_size)
-			continue;
-		brelse(bh);
-		bh = NULL;
-		offset = 0;
-		block++;
-	}
-	brelse(bh);
-	return NULL;
+static inline void dec_count(struct inode *inode)
+{
+	inode->i_nlink--;
+	mark_inode_dirty(inode);
 }
 
-#ifndef NO_TRUNCATE
+static int add_nondir(struct dentry *dentry, struct inode *inode)
+{
+	int err = minix_add_link(dentry, inode);
+	if (!err) {
+		d_instantiate(dentry, inode);
+		return 0;
+	}
+	dec_count(inode);
+	iput(inode);
+	return err;
+}
 
 static int minix_hash(struct dentry *dentry, struct qstr *qstr)
 {
@@ -103,27 +52,22 @@
 	return 0;
 }
 
-#endif
-
 struct dentry_operations minix_dentry_operations = {
-#ifndef NO_TRUNCATE
 	d_hash:		minix_hash,
-#endif
 };
 
 static struct dentry *minix_lookup(struct inode * dir, struct dentry *dentry)
 {
 	struct inode * inode = NULL;
-	struct minix_dir_entry * de;
-	struct buffer_head * bh;
+	ino_t ino;
+
+	dentry->d_op = dir->i_sb->s_root->d_op;
 
-#ifndef NO_TRUNCATE
-	dentry->d_op = &minix_dentry_operations;
-#endif
-	bh = minix_find_entry(dir, dentry->d_name.name, dentry->d_name.len, &de);
-	if (bh) {
-		int ino = de->inode;
-		brelse (bh);
+	if (dentry->d_name.len > dir->i_sb->u.minix_sb.s_namelen)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	ino = minix_inode_by_name(dentry);
+	if (ino) {
 		inode = iget(dir->i_sb, ino);
  
 		if (!inode)
@@ -133,481 +77,226 @@
 	return NULL;
 }
 
-/*
- *	minix_add_entry()
- *
- * adds a file entry to the specified directory, returning a possible
- * error value if it fails.
- *
- * NOTE!! The inode part of 'de' is left at 0 - which means you
- * may not sleep between calling this and putting something into
- * the entry, as someone else might have used it while you slept.
- */
-static int minix_add_entry(struct inode * dir,
-	const char * name, int namelen,
-	struct buffer_head ** res_buf,
-	struct minix_dir_entry ** res_dir)
+static int minix_mknod(struct inode * dir, struct dentry *dentry, int mode, int rdev)
 {
-	int i;
-	unsigned long block, offset;
-	struct buffer_head * bh;
-	struct minix_dir_entry * de;
-	struct minix_sb_info * info;
+	int error;
+	struct inode * inode = minix_new_inode(dir, &error);
 
-	*res_buf = NULL;
-	*res_dir = NULL;
-	info = &dir->i_sb->u.minix_sb;
-	if (namelen > info->s_namelen) {
-#ifdef NO_TRUNCATE
-		return -ENAMETOOLONG;
-#else
-		namelen = info->s_namelen;
-#endif
-	}
-	if (!namelen)
-		return -ENOENT;
-	bh = NULL;
-	block = offset = 0;
-	while (1) {
-		if (!bh) {
-			bh = minix_bread(dir,block,1);
-			if (!bh)
-				return -ENOSPC;
-		}
-		de = (struct minix_dir_entry *) (bh->b_data + offset);
-		offset += info->s_dirsize;
-		if (block*bh->b_size + offset > dir->i_size) {
-			de->inode = 0;
-			dir->i_size = block*bh->b_size + offset;
-			mark_inode_dirty(dir);
-		}
-		if (!de->inode) {
-			dir->i_mtime = dir->i_ctime = CURRENT_TIME;
-			mark_inode_dirty(dir);
-			for (i = 0; i < info->s_namelen ; i++)
-				de->name[i] = (i < namelen) ? name[i] : 0;
-			dir->i_version = ++event;
-			mark_buffer_dirty(bh);
-			*res_dir = de;
-			break;
-		}
-		if (offset < bh->b_size)
-			continue;
-		brelse(bh);
-		bh = NULL;
-		offset = 0;
-		block++;
+	if (inode) {
+		inode->i_mode = mode;
+		minix_set_inode(inode, rdev);
+		mark_inode_dirty(inode);
+		error = add_nondir(dentry, inode);
 	}
-	*res_buf = bh;
-	return 0;
+	return error;
 }
 
 static int minix_create(struct inode * dir, struct dentry *dentry, int mode)
 {
-	int error;
-	struct inode * inode;
-	struct buffer_head * bh;
-	struct minix_dir_entry * de;
-
-	inode = minix_new_inode(dir, &error);
-	if (!inode)
-		return error;
-	inode->i_op = &minix_file_inode_operations;
-	inode->i_fop = &minix_file_operations;
-	inode->i_mapping->a_ops = &minix_aops;
-	inode->i_mode = mode;
-	mark_inode_dirty(inode);
-	error = minix_add_entry(dir, dentry->d_name.name,
-				dentry->d_name.len, &bh ,&de);
-	if (error) {
-		inode->i_nlink--;
-		mark_inode_dirty(inode);
-		iput(inode);
-		return error;
-	}
-	de->inode = inode->i_ino;
-	mark_buffer_dirty(bh);
-	brelse(bh);
-	d_instantiate(dentry, inode);
-	return 0;
+	return minix_mknod(dir, dentry, mode, 0);
 }
 
-static int minix_mknod(struct inode * dir, struct dentry *dentry, int mode, int rdev)
+static int minix_symlink(struct inode * dir, struct dentry *dentry,
+	  const char * symname)
 {
-	int error;
+	int err = -ENAMETOOLONG;
+	int i = strlen(symname)+1;
 	struct inode * inode;
-	struct buffer_head * bh;
-	struct minix_dir_entry * de;
 
-	inode = minix_new_inode(dir, &error);
+	if (i > dir->i_sb->s_blocksize)
+		goto out;
+
+	inode = minix_new_inode(dir, &err);
 	if (!inode)
-		return error;
-	inode->i_uid = current->fsuid;
-	init_special_inode(inode, mode, rdev);
-	mark_inode_dirty(inode);
-	error = minix_add_entry(dir, dentry->d_name.name, dentry->d_name.len, &bh, &de);
-	if (error) {
-		inode->i_nlink--;
-		mark_inode_dirty(inode);
-		iput(inode);
-		return error;
-	}
-	de->inode = inode->i_ino;
-	mark_buffer_dirty(bh);
-	brelse(bh);
-	d_instantiate(dentry, inode);
-	return 0;
-}
+		goto out;
 
-static int minix_mkdir(struct inode * dir, struct dentry *dentry, int mode)
-{
-	int error;
-	struct inode * inode;
-	struct buffer_head * bh, *dir_block;
-	struct minix_dir_entry * de;
-	struct minix_sb_info * info;
+	inode->i_mode = S_IFLNK | 0777;
+	minix_set_inode(inode, 0);
+	err = block_symlink(inode, symname, i);
+	if (err)
+		goto out_fail;
 
-	info = &dir->i_sb->u.minix_sb;
-	if (dir->i_nlink >= info->s_link_max)
-		return -EMLINK;
-	inode = minix_new_inode(dir, &error);
-	if (!inode)
-		return error;
-	inode->i_op = &minix_dir_inode_operations;
-	inode->i_fop = &minix_dir_operations;
-	inode->i_size = 2 * info->s_dirsize;
-	dir_block = minix_bread(inode,0,1);
-	if (!dir_block) {
-		inode->i_nlink--;
-		mark_inode_dirty(inode);
-		iput(inode);
-		return -ENOSPC;
-	}
-	de = (struct minix_dir_entry *) dir_block->b_data;
-	de->inode=inode->i_ino;
-	strcpy(de->name,".");
-	de = (struct minix_dir_entry *) (dir_block->b_data + info->s_dirsize);
-	de->inode = dir->i_ino;
-	strcpy(de->name,"..");
-	inode->i_nlink = 2;
-	mark_buffer_dirty(dir_block);
-	brelse(dir_block);
-	inode->i_mode = S_IFDIR | mode;
-	if (dir->i_mode & S_ISGID)
-		inode->i_mode |= S_ISGID;
-	mark_inode_dirty(inode);
-	error = minix_add_entry(dir, dentry->d_name.name,
-				dentry->d_name.len, &bh, &de);
-	if (error) {
-		inode->i_nlink=0;
-		iput(inode);
-		return error;
-	}
-	de->inode = inode->i_ino;
-	mark_buffer_dirty(bh);
-	dir->i_nlink++;
-	mark_inode_dirty(dir);
-	brelse(bh);
-	d_instantiate(dentry, inode);
-	return 0;
+	err = add_nondir(dentry, inode);
+out:
+	return err;
+
+out_fail:
+	dec_count(inode);
+	iput(inode);
+	goto out;
 }
 
-/*
- * routine to check that the specified directory is empty (for rmdir)
- */
-static int empty_dir(struct inode * inode)
+static int minix_link(struct dentry * old_dentry, struct inode * dir,
+	struct dentry *dentry)
 {
-	unsigned int block, offset;
-	struct buffer_head * bh;
-	struct minix_dir_entry * de;
-	struct minix_sb_info * info;
+	struct inode *inode = old_dentry->d_inode;
 
-	info = &inode->i_sb->u.minix_sb;
-	block = 0;
-	bh = NULL;
-	offset = 2*info->s_dirsize;
-	if (inode->i_size & (info->s_dirsize-1))
-		goto bad_dir;
-	if (inode->i_size < offset)
-		goto bad_dir;
-	bh = minix_bread(inode,0,0);
-	if (!bh)
-		goto bad_dir;
-	de = (struct minix_dir_entry *) bh->b_data;
-	if (!de->inode || strcmp(de->name,"."))
-		goto bad_dir;
-	de = (struct minix_dir_entry *) (bh->b_data + info->s_dirsize);
-	if (!de->inode || strcmp(de->name,".."))
-		goto bad_dir;
-	while (block*BLOCK_SIZE+offset < inode->i_size) {
-		if (!bh) {
-			bh = minix_bread(inode,block,0);
-			if (!bh) {
-				block++;
-				continue;
-			}
-		}
-		de = (struct minix_dir_entry *) (bh->b_data + offset);
-		offset += info->s_dirsize;
-		if (de->inode) {
-			brelse(bh);
-			return 0;
-		}
-		if (offset < bh->b_size)
-			continue;
-		brelse(bh);
-		bh = NULL;
-		offset = 0;
-		block++;
-	}
-	brelse(bh);
-	return 1;
-bad_dir:
-	brelse(bh);
-	printk("Bad directory on device %s\n",
-	       kdevname(inode->i_dev));
-	return 1;
-}
+	if (S_ISDIR(inode->i_mode))
+		return -EPERM;
 
-static int minix_rmdir(struct inode * dir, struct dentry *dentry)
-{
-	int retval;
-	struct inode * inode;
-	struct buffer_head * bh;
-	struct minix_dir_entry * de;
+	if (inode->i_nlink >= inode->i_sb->u.minix_sb.s_link_max)
+		return -EMLINK;
 
-	inode = NULL;
-	bh = minix_find_entry(dir, dentry->d_name.name,
-			      dentry->d_name.len, &de);
-	retval = -ENOENT;
-	if (!bh)
-		goto end_rmdir;
-	inode = dentry->d_inode;
-
-	if (!empty_dir(inode)) {
-		retval = -ENOTEMPTY;
-		goto end_rmdir;
-	}
-	if (de->inode != inode->i_ino) {
-		retval = -ENOENT;
-		goto end_rmdir;
-	}
-	if (inode->i_nlink != 2)
-		printk("empty directory has nlink!=2 (%d)\n",inode->i_nlink);
-	de->inode = 0;
-	dir->i_version = ++event;
-	mark_buffer_dirty(bh);
-	inode->i_nlink=0;
-	mark_inode_dirty(inode);
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
-	dir->i_nlink--;
-	mark_inode_dirty(dir);
-	retval = 0;
-end_rmdir:
-	brelse(bh);
-	return retval;
+	inode->i_ctime = CURRENT_TIME;
+	inc_count(inode);
+	atomic_inc(&inode->i_count);
+	return add_nondir(dentry, inode);
 }
 
-static int minix_unlink(struct inode * dir, struct dentry *dentry)
+static int minix_mkdir(struct inode * dir, struct dentry *dentry, int mode)
 {
-	int retval;
 	struct inode * inode;
-	struct buffer_head * bh;
-	struct minix_dir_entry * de;
+	int err = -EMLINK;
 
-	retval = -ENOENT;
-	inode = dentry->d_inode;
-	bh = minix_find_entry(dir, dentry->d_name.name,
-			      dentry->d_name.len, &de);
-	if (!bh || de->inode != inode->i_ino)
-		goto end_unlink;
-	if (!inode->i_nlink) {
-		printk("Deleting nonexistent file (%s:%lu), %d\n",
-			kdevname(inode->i_dev),
-		       inode->i_ino, inode->i_nlink);
-		inode->i_nlink=1;
-	}
-	de->inode = 0;
-	dir->i_version = ++event;
-	mark_buffer_dirty(bh);
-	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
-	mark_inode_dirty(dir);
-	inode->i_nlink--;
-	inode->i_ctime = dir->i_ctime;
-	mark_inode_dirty(inode);
-	retval = 0;
-end_unlink:
-	brelse(bh);
-	return retval;
-}
+	if (dir->i_nlink >= dir->i_sb->u.minix_sb.s_link_max)
+		goto out;
 
-static int minix_symlink(struct inode * dir, struct dentry *dentry,
-		  const char * symname)
-{
-	struct minix_dir_entry * de;
-	struct inode * inode = NULL;
-	struct buffer_head * bh = NULL;
-	int i;
-	int err;
+	inc_count(dir);
 
-	err = -ENAMETOOLONG;
-	i = strlen(symname)+1;
-	if (i>1024)
-		goto out;
 	inode = minix_new_inode(dir, &err);
 	if (!inode)
-		goto out;
+		goto out_dir;
 
-	inode->i_mode = S_IFLNK | 0777;
-	inode->i_op = &page_symlink_inode_operations;
-	inode->i_mapping->a_ops = &minix_aops;
-	err = block_symlink(inode, symname, i);
+	inode->i_mode = S_IFDIR | mode;
+	if (dir->i_mode & S_ISGID)
+		inode->i_mode |= S_ISGID;
+	minix_set_inode(inode, 0);
+
+	inc_count(inode);
+
+	err = minix_make_empty(inode, dir);
 	if (err)
-		goto fail;
+		goto out_fail;
 
-	err = minix_add_entry(dir, dentry->d_name.name,
-			    dentry->d_name.len, &bh, &de);
+	err = minix_add_link(dentry, inode);
 	if (err)
-		goto fail;
+		goto out_fail;
 
-	de->inode = inode->i_ino;
-	mark_buffer_dirty(bh);
-	brelse(bh);
 	d_instantiate(dentry, inode);
 out:
 	return err;
-fail:
-	inode->i_nlink--;
-	mark_inode_dirty(inode);
+
+out_fail:
+	dec_count(inode);
+	dec_count(inode);
 	iput(inode);
+out_dir:
+	dec_count(dir);
 	goto out;
 }
 
-static int minix_link(struct dentry * old_dentry, struct inode * dir,
-	       struct dentry *dentry)
+static int minix_unlink(struct inode * dir, struct dentry *dentry)
 {
-	int error;
-	struct inode *inode = old_dentry->d_inode;
+	int err = -ENOENT;
+	struct inode * inode = dentry->d_inode;
+	struct page * page;
 	struct minix_dir_entry * de;
-	struct buffer_head * bh;
 
-	if (S_ISDIR(inode->i_mode))
-		return -EPERM;
+	de = minix_find_entry(dentry, &page);
+	if (!de)
+		goto end_unlink;
 
-	if (inode->i_nlink >= inode->i_sb->u.minix_sb.s_link_max)
-		return -EMLINK;
+	err = minix_delete_entry(de, page);
+	if (err)
+		goto end_unlink;
 
-	error = minix_add_entry(dir, dentry->d_name.name,
-				dentry->d_name.len, &bh, &de);
-	if (error) {
-		brelse(bh);
-		return error;
-	}
-	de->inode = inode->i_ino;
-	mark_buffer_dirty(bh);
-	brelse(bh);
-	inode->i_nlink++;
-	inode->i_ctime = CURRENT_TIME;
-	mark_inode_dirty(inode);
-	atomic_inc(&inode->i_count);
-	d_instantiate(dentry, inode);
-	return 0;
+	inode->i_ctime = dir->i_ctime;
+	dec_count(inode);
+end_unlink:
+	return err;
 }
 
-#define PARENT_INO(buffer) \
-(((struct minix_dir_entry *) ((buffer)+info->s_dirsize))->inode)
+static int minix_rmdir(struct inode * dir, struct dentry *dentry)
+{
+	struct inode * inode = dentry->d_inode;
+	int err = -ENOTEMPTY;
+
+	if (minix_empty_dir(inode)) {
+		err = minix_unlink(dir, dentry);
+		if (!err) {
+			dec_count(dir);
+			dec_count(inode);
+		}
+	}
+	return err;
+}
 
-/*
- * Anybody can rename anything with this: the permission checks are left to the
- * higher-level routines.
- */
 static int minix_rename(struct inode * old_dir, struct dentry *old_dentry,
 			   struct inode * new_dir, struct dentry *new_dentry)
 {
-	struct inode * old_inode, * new_inode;
-	struct buffer_head * old_bh, * new_bh, * dir_bh;
-	struct minix_dir_entry * old_de, * new_de;
-	struct minix_sb_info * info;
-	int retval;
-
-	info = &old_dir->i_sb->u.minix_sb;
-	new_bh = dir_bh = NULL;
-	old_inode = old_dentry->d_inode;
-	new_inode = new_dentry->d_inode;
-	old_bh = minix_find_entry(old_dir, old_dentry->d_name.name,
-				  old_dentry->d_name.len, &old_de);
-	retval = -ENOENT;
-	if (!old_bh || old_de->inode != old_inode->i_ino)
-		goto end_rename;
-	retval = -EPERM;
-	new_bh = minix_find_entry(new_dir, new_dentry->d_name.name,
-				  new_dentry->d_name.len, &new_de);
-	if (new_bh) {
-		if (!new_inode) {
-			brelse(new_bh);
-			new_bh = NULL;
-		}
-	}
+	struct minix_sb_info * info = &old_dir->i_sb->u.minix_sb;
+	struct inode * old_inode = old_dentry->d_inode;
+	struct inode * new_inode = new_dentry->d_inode;
+	struct page * dir_page = NULL;
+	struct minix_dir_entry * dir_de = NULL;
+	struct page * old_page;
+	struct minix_dir_entry * old_de;
+	int err = -ENOENT;
+
+	old_de = minix_find_entry(old_dentry, &old_page);
+	if (!old_de)
+		goto out;
+
 	if (S_ISDIR(old_inode->i_mode)) {
-		if (new_inode) {
-			retval = -ENOTEMPTY;
-			if (!empty_dir(new_inode))
-				goto end_rename;
-		}
-		retval = -EIO;
-		dir_bh = minix_bread(old_inode,0,0);
-		if (!dir_bh)
-			goto end_rename;
-		if (PARENT_INO(dir_bh->b_data) != old_dir->i_ino)
-			goto end_rename;
-		retval = -EMLINK;
-		if (!new_inode && new_dir != old_dir &&
-				new_dir->i_nlink >= info->s_link_max)
-			goto end_rename;
+		err = -EIO;
+		dir_de = minix_dotdot(old_inode, &dir_page);
+		if (!dir_de)
+			goto out_old;
 	}
-	if (!new_bh) {
-		retval = minix_add_entry(new_dir,
-					 new_dentry->d_name.name,
-					 new_dentry->d_name.len,
-					 &new_bh, &new_de);
-		if (retval)
-			goto end_rename;
-	}
-/* ok, that's it */
-	new_de->inode = old_inode->i_ino;
-	old_de->inode = 0;
-	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
-	old_dir->i_version = ++event;
-	mark_inode_dirty(old_dir);
-	new_dir->i_ctime = new_dir->i_mtime = CURRENT_TIME;
-	new_dir->i_version = ++event;
-	mark_inode_dirty(new_dir);
+
 	if (new_inode) {
-		new_inode->i_nlink--;
+		struct page * new_page;
+		struct minix_dir_entry * new_de;
+
+		err = -ENOTEMPTY;
+		if (dir_de && !minix_empty_dir(new_inode))
+			goto out_dir;
+
+		err = -ENOENT;
+		new_de = minix_find_entry(new_dentry, &new_page);
+		if (!new_de)
+			goto out_dir;
+		inc_count(old_inode);
+		minix_set_link(new_de, new_page, old_inode);
 		new_inode->i_ctime = CURRENT_TIME;
-		mark_inode_dirty(new_inode);
-	}
-	mark_buffer_dirty(old_bh);
-	mark_buffer_dirty(new_bh);
-	if (dir_bh) {
-		PARENT_INO(dir_bh->b_data) = new_dir->i_ino;
-		mark_buffer_dirty(dir_bh);
-		old_dir->i_nlink--;
-		mark_inode_dirty(old_dir);
-		if (new_inode) {
+		if (dir_de)
 			new_inode->i_nlink--;
-			mark_inode_dirty(new_inode);
-		} else {
-			new_dir->i_nlink++;
-			mark_inode_dirty(new_dir);
+		dec_count(new_inode);
+	} else {
+		if (dir_de) {
+			err = -EMLINK;
+			if (new_dir->i_nlink >= info->s_link_max)
+				goto out_dir;
+		}
+		inc_count(old_inode);
+		err = minix_add_link(new_dentry, old_inode);
+		if (err) {
+			dec_count(old_inode);
+			goto out_dir;
 		}
+		if (dir_de)
+			inc_count(new_dir);
+	}
+
+	minix_delete_entry(old_de, old_page);
+	dec_count(old_inode);
+
+	if (dir_de) {
+		minix_set_link(dir_de, dir_page, new_dir);
+		dec_count(old_dir);
 	}
-	retval = 0;
-end_rename:
-	brelse(dir_bh);
-	brelse(old_bh);
-	brelse(new_bh);
-	return retval;
+	return 0;
+
+out_dir:
+	if (dir_de) {
+		kunmap(dir_page);
+		page_cache_release(dir_page);
+	}
+out_old:
+	kunmap(old_page);
+	page_cache_release(old_page);
+out:
+	return err;
 }
 
 /*
diff -urN S10-pre4/include/linux/minix_fs.h S10-pre4-minix/include/linux/minix_fs.h
--- S10-pre4/include/linux/minix_fs.h	Fri Feb 16 19:00:50 2001
+++ S10-pre4-minix/include/linux/minix_fs.h	Sun Sep  2 23:32:54 2001
@@ -89,6 +89,14 @@
 
 #ifdef __KERNEL__
 
+/*
+ * change the define below to 0 if you want names > info->s_namelen chars to be
+ * truncated. Else they will be disallowed (ENAMETOOLONG).
+ */
+#define NO_TRUNCATE 1
+
+extern struct minix_inode * minix_V1_raw_inode(struct super_block *, ino_t, struct buffer_head **);
+extern struct minix2_inode * minix_V2_raw_inode(struct super_block *, ino_t, struct buffer_head **);
 extern struct inode * minix_new_inode(const struct inode * dir, int * error);
 extern void minix_free_inode(struct inode * inode);
 extern unsigned long minix_count_free_inodes(struct super_block *sb);
@@ -96,19 +104,25 @@
 extern void minix_free_block(struct inode * inode, int block);
 extern unsigned long minix_count_free_blocks(struct super_block *sb);
 
-extern struct buffer_head * minix_getblk(struct inode *, int, int);
-extern struct buffer_head * minix_bread(struct inode *, int, int);
-
 extern void V1_minix_truncate(struct inode *);
 extern void V2_minix_truncate(struct inode *);
 extern void minix_truncate(struct inode *);
 extern int minix_sync_inode(struct inode *);
-extern int V1_minix_sync_file(struct inode *);
-extern int V2_minix_sync_file(struct inode *);
+extern void minix_set_inode(struct inode *, dev_t);
 extern int V1_minix_get_block(struct inode *, long, struct buffer_head *, int);
 extern int V2_minix_get_block(struct inode *, long, struct buffer_head *, int);
 
-extern struct address_space_operations minix_aops;
+extern struct minix_dir_entry *minix_find_entry(struct dentry*, struct page**);
+extern int minix_add_link(struct dentry*, struct inode*);
+extern int minix_delete_entry(struct minix_dir_entry*, struct page*);
+extern int minix_make_empty(struct inode*, struct inode*);
+extern int minix_empty_dir(struct inode*);
+extern void minix_set_link(struct minix_dir_entry*, struct page*, struct inode*);
+extern struct minix_dir_entry *minix_dotdot(struct inode*, struct page**);
+extern ino_t minix_inode_by_name(struct dentry*);
+
+extern int minix_sync_file(struct file *, struct dentry *, int);
+
 extern struct inode_operations minix_file_inode_operations;
 extern struct inode_operations minix_dir_inode_operations;
 extern struct file_operations minix_file_operations;

