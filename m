Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130749AbQKTAdC>; Sun, 19 Nov 2000 19:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130695AbQKTAcx>; Sun, 19 Nov 2000 19:32:53 -0500
Received: from linuxcare.com.au ([203.29.91.49]:42503 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129645AbQKTAcs>; Sun, 19 Nov 2000 19:32:48 -0500
Date: Mon, 20 Nov 2000 11:02:34 +1100
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Compile bugfix for ramfs limits
Message-ID: <20001120110234.B12332@linuxcare.com>
Mail-Followup-To: dgibson, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: David Gibson <dgibson@linuxcare.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops.. <linux/spinlock.h> not <asm/spinlock.h>. The patch below
implements resource limits for ramfs, and unlike the previous version
actually compiles.

-- 
David Gibson, Technical Support Engineer, Linuxcare, Inc.
+61 2 6262 8990
dgibson@linuxcare.com, http://www.linuxcare.com/ 
Linuxcare. Support for the revolution.

diff -uNr test11-pre5/Documentation/filesystems/ramfs.txt test11-pre5-ramfs/Documentation/filesystems/ramfs.txt
--- test11-pre5/Documentation/filesystems/ramfs.txt	Thu Jan  1 10:00:00 1970
+++ test11-pre5-ramfs/Documentation/filesystems/ramfs.txt	Wed Nov 15 14:12:08 2000
@@ -0,0 +1,47 @@
+	ramfs - An automatically resizing memory based filesystem
+
+
+  Ramfs is a file system which keeps all files in RAM. It allows read
+  and write access. In contrast to RAM disks, which get allocated a
+  fixed amount of RAM, ramfs grows and shrinks to accommodate the
+  files it contains.
+
+  You can mount the ramfs with:
+      mount -t ramfs none /mnt/wherever
+
+  Then just create and use files. When the filesystem is unmounted, all
+  its contents are lost.
+
+  NOTE! This filesystem is probably most useful not as a real
+  filesystem, but as an example of how virtual filesystems can be
+  written.
+
+Resource limits:
+
+By default a ramfs will be limited to using half of (physical) memory
+for storing file contents, a bit over that when the metadata is
+included. The resource usage limits of ramfs can be controlled with
+the following mount options:
+
+	maxsize=NNN
+		Sets the maximum allowed memory usage of the
+filesystem to NNN kilobytes. This will be rounded down to a multiple
+of the page size. The default is half of physical memory. NB.  unlike
+most of the other limits, setting this to zero does *not* mean no
+limit, but will actually limit the size of the filesystem data to zero
+pages. There might be a use for this in some perverse situation.
+	
+	maxfilesize=NNN
+		Sets the maximum size of a single file on the
+filesystem to NNN kilobytes. This will be rounded down to a multiple
+of the page size. If NNN=0 there is no limit. The default is no limit.
+
+       maxdentries=NNN
+		Sets the maximum number of directory entries (hard
+links) on the filesystem to NNN. If NNN=0 there is no limit. By
+default this is set to maxsize/4.
+
+	maxinodes=NNN
+		Sets the maximum number of inodes (i.e. distinct
+files) on the filesystem to NNN. If NNN=0 there is no limit. The
+default is no limit (but there can never be more inodes than dentries).
diff -uNr test11-pre5/fs/ramfs/inode.c test11-pre5-ramfs/fs/ramfs/inode.c
--- test11-pre5/fs/ramfs/inode.c	Wed Nov 15 14:06:48 2000
+++ test11-pre5-ramfs/fs/ramfs/inode.c	Mon Nov 20 10:50:24 2000
@@ -4,6 +4,7 @@
  * Copyright (C) 2000 Linus Torvalds.
  *               2000 Transmeta Corp.
  *
+ * Usage limits added by David Gibson, Linuxcare Australia.
  * This file is released under the GPL.
  */
 
@@ -28,8 +29,18 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/locks.h>
+#include <linux/highmem.h>
+#include <linux/malloc.h>
 
 #include <asm/uaccess.h>
+#include <linux/spinlock.h>
+
+#if PAGE_CACHE_SIZE % 1024
+#error Oh no, PAGE_CACHE_SIZE is not divisible by 1k! I cannot cope.
+#endif
+
+#define IBLOCKS_PER_PAGE  (PAGE_CACHE_SIZE / 512)
+#define K_PER_PAGE (PAGE_CACHE_SIZE / 1024)
 
 /* some random number */
 #define RAMFS_MAGIC	0x858458f6
@@ -40,8 +51,174 @@
 static struct file_operations ramfs_file_operations;
 static struct inode_operations ramfs_dir_inode_operations;
 
+/*
+ * ramfs super-block data in memory
+ */
+struct ramfs_sb_info {
+	/* Prevent races accessing the used block
+	 * counts. Conceptually, this could probably be a semaphore,
+	 * but the only thing we do while holding the lock is
+	 * arithmetic, so there's no point */
+	spinlock_t ramfs_lock;
+
+	/* It is important that at least the free counts below be
+	   signed.  free_XXX may become negative if a limit is changed
+	   downwards (with a remount) below the current usage. */	  
+
+	/* maximum number of pages in a file */
+	long max_file_pages;
+
+	/* max total number of data pages */
+	long max_pages;
+	/* free_pages = max_pages - total number of pages currently in use */
+	long free_pages;
+	
+	/* max number of inodes */
+	long max_inodes;
+	/* free_inodes = max_inodes - total number of inodes currently in use */
+	long free_inodes;
+
+	/* max number of dentries */
+	long max_dentries;
+	/* free_dentries = max_dentries - total number of dentries in use */
+	long free_dentries;
+};
+
+#define RAMFS_SB(sb) ((struct ramfs_sb_info *)((sb)->u.generic_sbp))
+
+/*
+ * Resource limit helper functions
+ */
+
+static inline void lock_rsb(struct ramfs_sb_info *rsb)
+{
+	spin_lock(&(rsb->ramfs_lock));
+}
+
+static inline void unlock_rsb(struct ramfs_sb_info *rsb)
+{
+	spin_unlock(&(rsb->ramfs_lock));
+}
+
+/* Decrements the free inode count and returns true, or returns false
+ * if there are no free inodes */
+static int ramfs_alloc_inode(struct super_block *sb)
+{
+	struct ramfs_sb_info *rsb = RAMFS_SB(sb);
+	int ret = 1;
+
+	lock_rsb(rsb);
+	if (!rsb->max_inodes || rsb->free_inodes > 0)
+		rsb->free_inodes--;
+	else
+		ret = 0;
+	unlock_rsb(rsb);
+	
+	return ret;
+}
+
+/* Increments the free inode count */
+static void ramfs_dealloc_inode(struct super_block *sb)
+{
+	struct ramfs_sb_info *rsb = RAMFS_SB(sb);
+	
+	lock_rsb(rsb);
+	rsb->free_inodes++;
+	unlock_rsb(rsb);
+}
+
+/* Decrements the free dentry count and returns true, or returns false
+ * if there are no free dentries */
+static int ramfs_alloc_dentry(struct super_block *sb)
+{
+	struct ramfs_sb_info *rsb = RAMFS_SB(sb);
+	int ret = 1;
+
+	lock_rsb(rsb);
+	if (!rsb->max_dentries || rsb->free_dentries > 0)
+		rsb->free_dentries--;
+	else
+		ret = 0;
+	unlock_rsb(rsb);
+	
+	return ret;
+}
+
+/* Increments the free dentry count */
+static void ramfs_dealloc_dentry(struct super_block *sb)
+{
+	struct ramfs_sb_info *rsb = RAMFS_SB(sb);
+	
+	lock_rsb(rsb);
+	rsb->free_dentries++;
+	unlock_rsb(rsb);
+}
+
+/* If the given page can be added to the give inode for ramfs, return
+ * true and update the filesystem's free page count and the inode's
+ * i_blocks field. Always returns true if the file is already used by
+ * ramfs (ie. PageDirty(page) is true)  */
+int ramfs_alloc_page(struct inode *inode, struct page *page)
+{
+	int ret = 1;
+
+	if (!PageDirty(page)) {
+		struct ramfs_sb_info *rsb = RAMFS_SB(inode->i_sb);
+		lock_rsb(rsb);
+		
+		if ( (rsb->free_pages > 0) &&
+		     ( !rsb->max_file_pages ||
+		       (inode->i_data.nrpages <= rsb->max_file_pages) ) ) {
+			inode->i_blocks += IBLOCKS_PER_PAGE;
+			rsb->free_pages--;
+			SetPageDirty(page);
+		} else {
+			ClearPageUptodate(page);
+			ret = 0;
+		}
+
+		unlock_rsb(rsb);
+	}
+
+	return ret;
+}
+
+void ramfs_dealloc_page(struct inode *inode, struct page *page)
+{
+	struct ramfs_sb_info *rsb = RAMFS_SB(inode->i_sb);
+
+	if (! PageDirty(page))
+		return;
+
+	lock_rsb(rsb);
+
+	ClearPageDirty(page);
+	
+	rsb->free_pages++;
+	inode->i_blocks -= IBLOCKS_PER_PAGE;
+	
+	if (rsb->free_pages > rsb->max_pages) {
+		printk(KERN_ERR "ramfs: Error in page allocation, free_pages (%ld) > max_pages (%ld)\n", rsb->free_pages, rsb->max_pages);
+	}
+
+	unlock_rsb(rsb);
+}
+
+
+
 static int ramfs_statfs(struct super_block *sb, struct statfs *buf)
 {
+	struct ramfs_sb_info *rsb = RAMFS_SB(sb);
+
+	lock_rsb(rsb);
+	buf->f_blocks = rsb->max_pages;
+	buf->f_files = rsb->max_inodes;
+
+	buf->f_bfree = rsb->free_pages;
+	buf->f_bavail = buf->f_bfree;
+	buf->f_ffree = rsb->free_inodes;
+	unlock_rsb(rsb);
+
 	buf->f_type = RAMFS_MAGIC;
 	buf->f_bsize = PAGE_CACHE_SIZE;
 	buf->f_namelen = 255;
@@ -80,19 +257,29 @@
  */
 static int ramfs_writepage(struct file *file, struct page *page)
 {
-	SetPageDirty(page);
+	struct inode *inode = (struct inode *)page->mapping->host;
+
+	if (! ramfs_alloc_page(inode, page))
+		return -ENOSPC;
+
 	return 0;
 }
 
 static int ramfs_prepare_write(struct file *file, struct page *page, unsigned offset, unsigned to)
 {
-	void *addr = kmap(page);
+	struct inode *inode = (struct inode *)page->mapping->host;
+	void *addr;
+
+	if (! ramfs_alloc_page(inode, page)) {
+		return -ENOSPC;
+	}
+
+	addr = (void *) kmap(page);
 	if (!Page_Uptodate(page)) {
 		memset(addr, 0, PAGE_CACHE_SIZE);
 		flush_dcache_page(page);
 		SetPageUptodate(page);
 	}
-	SetPageDirty(page);
 	return 0;
 }
 
@@ -107,9 +294,21 @@
 	return 0;
 }
 
-struct inode *ramfs_get_inode(struct super_block *sb, int mode, int dev)
+static void ramfs_removepage(struct page *page)
 {
-	struct inode * inode = get_empty_inode();
+	struct inode *inode = (struct inode *)page->mapping->host;
+
+	ramfs_dealloc_page(inode, page);
+}
+
+static struct inode *ramfs_get_inode(struct super_block *sb, int mode, int dev)
+{
+	struct inode * inode;
+
+	if (! ramfs_alloc_inode(sb))
+		return NULL;
+
+	inode = get_empty_inode();
 
 	if (inode) {
 		inode->i_sb = sb;
@@ -141,23 +340,35 @@
 			inode->i_op = &page_symlink_inode_operations;
 			break;
 		}
-	}
+	} else
+		ramfs_dealloc_inode(sb);
+
 	return inode;
 }
 
 /*
- * File creation. Allocate an inode, and we're done..
+ * File creation. Allocate an inode, update free inode and dentry counts
+ * and we're done..
  */
 static int ramfs_mknod(struct inode *dir, struct dentry *dentry, int mode, int dev)
 {
-	struct inode * inode = ramfs_get_inode(dir->i_sb, mode, dev);
+	struct super_block *sb = dir->i_sb;
+	struct inode * inode;
 	int error = -ENOSPC;
 
+	if (! ramfs_alloc_dentry(sb))
+		return error;
+
+	inode = ramfs_get_inode(dir->i_sb, mode, dev);
+
 	if (inode) {
 		d_instantiate(dentry, inode);
 		dget(dentry);		/* Extra count - pin the dentry in core */
 		error = 0;
+	} else {
+		ramfs_dealloc_dentry(sb);
 	}
+
 	return error;
 }
 
@@ -176,11 +387,15 @@
  */
 static int ramfs_link(struct dentry *old_dentry, struct inode * dir, struct dentry * dentry)
 {
+	struct super_block *sb = dir->i_sb;
 	struct inode *inode = old_dentry->d_inode;
 
 	if (S_ISDIR(inode->i_mode))
 		return -EPERM;
 
+	if (! ramfs_alloc_dentry(sb))
+		return -ENOSPC;
+
 	inode->i_nlink++;
 	atomic_inc(&inode->i_count);	/* New dentry reference */
 	dget(dentry);		/* Extra pinning count for the created dentry */
@@ -227,6 +442,7 @@
  */
 static int ramfs_unlink(struct inode * dir, struct dentry *dentry)
 {
+	struct super_block *sb = dir->i_sb;
 	int retval = -ENOTEMPTY;
 
 	if (ramfs_empty(dentry)) {
@@ -234,6 +450,9 @@
 
 		inode->i_nlink--;
 		dput(dentry);			/* Undo the count from "create" - this does all the work */
+
+		ramfs_dealloc_dentry(sb);
+
 		retval = 0;
 	}
 	return retval;
@@ -249,6 +468,8 @@
  */
 static int ramfs_rename(struct inode * old_dir, struct dentry *old_dentry, struct inode * new_dir,struct dentry *new_dentry)
 {
+	struct super_block *sb = new_dir->i_sb;
+
 	int error = -ENOTEMPTY;
 
 	if (ramfs_empty(new_dentry)) {
@@ -256,6 +477,7 @@
 		if (inode) {
 			inode->i_nlink--;
 			dput(new_dentry);
+			ramfs_dealloc_dentry(sb);
 		}
 		error = 0;
 	}
@@ -275,11 +497,174 @@
 	return error;
 }
 
+static void ramfs_delete_inode(struct inode *inode)
+{
+	ramfs_dealloc_inode(inode->i_sb);
+
+	clear_inode(inode);
+}
+
+static void ramfs_put_super(struct super_block *sb)
+{
+	kfree(sb->u.generic_sbp);
+}
+
+struct ramfs_params {
+	long pages;
+	long filepages;
+	long inodes;
+	long dentries;
+};
+
+static int parse_options(char * options, struct ramfs_params *p)
+{
+	char save = 0, *savep = NULL, *optname, *value;
+
+	p->pages = -1;
+	p->filepages = -1;
+	p->inodes = -1;
+	p->dentries = -1;
+
+	for (optname = strtok(options,","); optname;
+	     optname = strtok(NULL,",")) {
+		if ((value = strchr(optname,'=')) != NULL) {
+			save = *value;
+			savep = value;
+			*value++ = 0;
+		}
+
+		if (!strcmp(optname, "maxfilesize") && value) {
+			p->filepages = simple_strtoul(value, &value, 0)
+				/ K_PER_PAGE;
+			if (*value)
+				return -EINVAL;
+		} else if (!strcmp(optname, "maxsize") && value) {
+			p->pages = simple_strtoul(value, &value, 0)
+				/ K_PER_PAGE;
+			if (*value)
+				return -EINVAL;
+		} else if (!strcmp(optname, "maxinodes") && value) {
+			p->inodes = simple_strtoul(value, &value, 0);
+			if (*value)
+				return -EINVAL;
+		} else if (!strcmp(optname, "maxdentries") && value) {
+			p->dentries = simple_strtoul(value, &value, 0);
+			if (*value)
+				return -EINVAL;
+		}
+
+		if (optname != options)
+			*(optname-1) = ',';
+		if (value)
+			*savep = save;
+/*  		if (ret == 0) */
+/*  			break; */
+	}
+
+	return 0;
+}
+
+static void init_limits(struct ramfs_sb_info *rsb, struct ramfs_params *p)
+{
+	struct sysinfo si;
+
+	si_meminfo(&si);
+
+	/* By default we set the limits to be:
+	       - Allow this ramfs to take up to half of all available RAM
+	       - No limit on filesize (except no file may be bigger that
+	         the total max size, obviously)
+	       - dentries limited to one per 4k of data space
+	       - No limit to the number of inodes (except that there
+	         are never more inodes than dentries).
+	*/
+	rsb->max_pages = (si.totalram / 2);
+
+	if (p->pages >= 0)
+		rsb->max_pages = p->pages;
+
+	rsb->max_file_pages = 0;
+	if (p->filepages >= 0)
+		rsb->max_file_pages = p->filepages;
+
+	rsb->max_dentries = rsb->max_pages * K_PER_PAGE / 4;
+	if (p->dentries >= 0)
+		rsb->max_dentries = p->dentries;
+
+	rsb->max_inodes = 0;
+	if (p->inodes >= 0)
+		rsb->max_inodes = p->inodes;
+
+	rsb->free_pages = rsb->max_pages;
+	rsb->free_inodes = rsb->max_inodes;
+	rsb->free_dentries = rsb->max_dentries;
+
+	return;
+}
+
+/* reset_limits is called during a remount to change the usage limits.
+
+   This will suceed, even if the new limits are lower than current
+   usage. This is the intended behaviour - new allocations will fail
+   until usage falls below the new limit */
+static void reset_limits(struct ramfs_sb_info *rsb, struct ramfs_params *p)
+{
+	lock_rsb(rsb);
+
+	if (p->pages >= 0) {
+		int used_pages = rsb->max_pages - rsb->free_pages;
+
+		rsb->max_pages = p->pages;
+		rsb->free_pages = rsb->max_pages - used_pages;
+	}
+
+	if (p->filepages >= 0) {
+		rsb->max_file_pages = p->filepages;
+	}
+	
+
+	if (p->dentries >= 0) {
+		int used_dentries = rsb->max_dentries - rsb->free_dentries;
+
+		rsb->max_dentries = p->dentries;
+		rsb->free_dentries = rsb->max_dentries - used_dentries;
+	}
+
+	if (p->inodes >= 0) {
+		int used_inodes = rsb->max_inodes - rsb->free_inodes;
+
+		rsb->max_inodes = p->inodes;
+		rsb->free_inodes = rsb->max_inodes - used_inodes;
+	}
+
+	unlock_rsb(rsb);
+}
+
+static int ramfs_remount(struct super_block * sb, int * flags, char * data)
+{
+	struct ramfs_params params;
+	struct ramfs_sb_info * rsb = RAMFS_SB(sb);
+
+	if (parse_options((char *)data, &params) != 0)
+		return -EINVAL;
+
+	reset_limits(rsb, &params);
+
+	printk(KERN_DEBUG "ramfs: remount [%s]\n", (char *)data);
+	printk(KERN_DEBUG "ramfs: max_file_pages = %ld\n", rsb->max_file_pages);
+	printk(KERN_DEBUG "ramfs: max_pages = %ld\n", rsb->max_pages);
+	printk(KERN_DEBUG "ramfs: max_inodes = %ld\n", rsb->max_inodes);
+	printk(KERN_DEBUG "ramfs: max_dentries = %ld\n", rsb->max_dentries);
+
+	return 0;
+}
+
 static struct address_space_operations ramfs_aops = {
 	readpage:	ramfs_readpage,
 	writepage:	ramfs_writepage,
 	prepare_write:	ramfs_prepare_write,
-	commit_write:	ramfs_commit_write
+	commit_write:	ramfs_commit_write,
+	removepage:     ramfs_removepage,
 };
 
 static struct file_operations ramfs_file_operations = {
@@ -308,17 +693,37 @@
 static struct super_operations ramfs_ops = {
 	statfs:		ramfs_statfs,
 	put_inode:	force_delete,
+	delete_inode:	ramfs_delete_inode,
+	put_super:      ramfs_put_super,
+	remount_fs:     ramfs_remount,
 };
 
+/*
+ * Initialisation
+ */
+
 static struct super_block *ramfs_read_super(struct super_block * sb, void * data, int silent)
 {
 	struct inode * inode;
 	struct dentry * root;
+	struct ramfs_sb_info * rsb;
+	struct ramfs_params params;
 
 	sb->s_blocksize = PAGE_CACHE_SIZE;
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = RAMFS_MAGIC;
 	sb->s_op = &ramfs_ops;
+
+	sb->u.generic_sbp = kmalloc(sizeof(struct ramfs_sb_info), GFP_KERNEL);
+	rsb = RAMFS_SB(sb);
+
+	spin_lock_init(&rsb->ramfs_lock);
+
+	if (parse_options((char *)data, &params) != 0)
+		return NULL;
+
+	init_limits(rsb, &params);
+
 	inode = ramfs_get_inode(sb, S_IFDIR | 0755, 0);
 	if (!inode)
 		return NULL;
@@ -329,6 +734,12 @@
 		return NULL;
 	}
 	sb->s_root = root;
+
+	printk(KERN_DEBUG "ramfs: mounted [%s]\n", (char *)data);
+	printk(KERN_DEBUG "ramfs: max_file_pages = %ld\n", rsb->max_file_pages);
+	printk(KERN_DEBUG "ramfs: max_pages = %ld\n", rsb->max_pages);
+	printk(KERN_DEBUG "ramfs: max_inodes = %ld\n", rsb->max_inodes);
+	printk(KERN_DEBUG "ramfs: max_dentries = %ld\n", rsb->max_dentries);
 	return sb;
 }
 
diff -uNr test11-pre5/include/linux/fs.h test11-pre5-ramfs/include/linux/fs.h
--- test11-pre5/include/linux/fs.h	Wed Nov 15 14:06:51 2000
+++ test11-pre5-ramfs/include/linux/fs.h	Fri Nov 17 16:08:30 2000
@@ -354,6 +354,7 @@
 	int (*sync_page)(struct page *);
 	int (*prepare_write)(struct file *, struct page *, unsigned, unsigned);
 	int (*commit_write)(struct file *, struct page *, unsigned, unsigned);
+	void (*removepage)(struct page *); /* called from __remove_inode_page */
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
 	int (*bmap)(struct address_space *, long);
 };
diff -uNr test11-pre5/mm/filemap.c test11-pre5-ramfs/mm/filemap.c
--- test11-pre5/mm/filemap.c	Wed Nov 15 14:06:51 2000
+++ test11-pre5-ramfs/mm/filemap.c	Wed Nov 15 14:12:08 2000
@@ -93,6 +93,11 @@
  */
 void __remove_inode_page(struct page *page)
 {
+	struct address_space *mapping = page->mapping;
+
+	if (mapping && mapping->a_ops && mapping->a_ops->removepage)
+		mapping->a_ops->removepage(page);
+
 	remove_page_from_inode_queue(page);
 	remove_page_from_hash_queue(page);
 	page->mapping = NULL;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
