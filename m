Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129690AbQKMPsa>; Mon, 13 Nov 2000 10:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbQKMPsU>; Mon, 13 Nov 2000 10:48:20 -0500
Received: from solar.students.cs.uu.nl ([131.211.82.28]:9875 "HELO
	mail.students.cs.uu.nl") by vger.kernel.org with SMTP
	id <S129690AbQKMPsJ>; Mon, 13 Nov 2000 10:48:09 -0500
Date: Mon, 13 Nov 2000 16:48:02 +0100 (MET)
From: Eelco Dolstra <edolstra@students.cs.uu.nl>
To: chaffee@cs.berkeley.edu, mikulas@artax.karlin.mff.cuni.cz,
        linux-kernel@vger.kernel.org
Cc: lubaldo@adinet.com.uy
Subject: [PATCH] fix for truncate() in FAT & HPFS
Message-ID: <Pine.GSO.4.21.0011131603390.620-100000@linde.students.cs.uu.nl>
X-Org: Students of the Department of Computer Science; Utrecht UniversityP.O. Box 80.089; 3508 TB  Utrecht; The Netherlands.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch fixes the truncate() bug in the HPFS and FAT
drivers.  As reported by Ivan Baldo, the FAT driver mildly corrupts
the file system when truncate() is used to grow a file.  The problem
is that FAT doesn't support holes, and therefore the allocation of a
file must match its file size.

The HPFS driver has more or less the same problem, with the difference
that it BUG()s in fs/hpfs/file.c at line 81 (typically with a message
like "sector ... not found in external anode ffffffff").

The solution is to have truncate() grow the allocation of the file to
the proper size.  The code to do that already exists; namely,
cont_prepare_write() in fs/buffer.c.  So, this patch adds a function
cont_grow_file() that does the right setup and calls
cont_prepare_write() (basically, it does what generic_file_write()
does without actually writing any data).

This patch applies to 2.4.0-test11-pre4.

Regards,

Eelco.

diff -ur old/fs/buffer.c linux/fs/buffer.c
--- old/fs/buffer.c	Mon Nov 13 16:24:42 2000
+++ linux/fs/buffer.c	Mon Nov 13 16:27:24 2000
@@ -1753,6 +1753,42 @@
 	return 0;
 }
 
+/*
+ * Grow the allocation of the file (in *bytes) to match the size of
+ * the file (in i->i_size), using cont_prepare_write().  This is for
+ * filesystems like FAT and HPFS that don't allow holes.
+ */
+int cont_grow_file(struct inode *i, get_block_t *get_block,
+        unsigned long *bytes)
+{
+	struct page *page;
+	unsigned long index, offset;
+	int status;
+
+	offset = (i->i_size & (PAGE_CACHE_SIZE - 1));
+	index = i->i_size >> PAGE_CACHE_SHIFT;
+
+	page = grab_cache_page(i->i_mapping, index);
+	if (!page) return -ENOMEM;
+	if (!PageLocked(page)) PAGE_BUG(page);
+
+	/* Prepare to write at i_size.  This will allocate new sectors
+	   as appropriate and zero them out. */
+	status = cont_prepare_write(page, offset, offset, get_block, bytes);
+
+	if (*bytes < i->i_size)
+		/* The file was not succesfully resized to the
+		   requested size.  Then we must reset i_size to the
+		   actual allocation. */
+		i->i_size = *bytes;
+
+	kunmap(page);
+	UnlockPage(page);
+	page_cache_release(page);
+
+	return status;
+}
+
 int block_truncate_page(struct address_space *mapping, loff_t from, get_block_t *get_block)
 {
 	unsigned long index = from >> PAGE_CACHE_SHIFT;
diff -ur old/fs/fat/file.c linux/fs/fat/file.c
--- old/fs/fat/file.c	Wed Apr 12 18:47:29 2000
+++ linux/fs/fat/file.c	Mon Nov 13 16:27:24 2000
@@ -114,25 +114,36 @@
 	return retval;
 }
 
+#define CLUSTERS(sbi, size) \
+(((size) + SECTOR_SIZE * (sbi)->cluster_size - 1) >> (sbi)->cluster_bits)
+
 void fat_truncate(struct inode *inode)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
-	int cluster;
+	int status;
+	unsigned long current_clusters, new_clusters;
 
 	/* Why no return value?  Surely the disk could fail... */
 	if (IS_RDONLY (inode))
 		return /* -EPERM */;
 	if (IS_IMMUTABLE(inode))
 		return /* -EPERM */;
-	cluster = SECTOR_SIZE*sbi->cluster_size;
-	/* 
-	 * This protects against truncating a file bigger than it was then
-	 * trying to write into the hole.
-	 */
-	if (MSDOS_I(inode)->mmu_private > inode->i_size)
-		MSDOS_I(inode)->mmu_private = inode->i_size;
 
-	fat_free(inode,(inode->i_size+(cluster-1))>>sbi->cluster_bits);
+	current_clusters = CLUSTERS(sbi, MSDOS_I(inode)->mmu_private);
+	new_clusters = CLUSTERS(sbi, inode->i_size);
+
+	if (new_clusters < current_clusters) { /* shrink allocation */
+		fat_free(inode, new_clusters);
+	} else if (new_clusters > current_clusters) { /* grow allocation */
+		status = cont_grow_file(inode, fat_get_block,
+			&MSDOS_I(inode)->mmu_private);
+		if (status)
+			printk( "fat_truncate: unable to grow file "
+				"to %Ld bytes, error = %d\n", 
+				inode->i_size, -status);
+	} /* else do nothing, the allocation doesn't change */
+
+	MSDOS_I(inode)->mmu_private = inode->i_size;
 	MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty(inode);
diff -ur old/fs/hpfs/file.c linux/fs/hpfs/file.c
--- old/fs/hpfs/file.c	Thu Jul 13 06:58:44 2000
+++ linux/fs/hpfs/file.c	Mon Nov 13 16:27:24 2000
@@ -11,6 +11,8 @@
 #include <linux/smp_lock.h>
 #include "hpfs_fn.h"
 
+#define BLOCKS(size) (((size) + 511) >> 9)
+
 /* HUH? */
 int hpfs_open(struct inode *i, struct file *f)
 {
@@ -46,7 +48,7 @@
 	unsigned n, disk_secno;
 	struct fnode *fnode;
 	struct buffer_head *bh;
-	if (((inode->i_size + 511) >> 9) <= file_secno) return 0;
+	if (BLOCKS(inode->u.hpfs_i.mmu_private) <= file_secno) return 0;
 	n = file_secno - inode->i_hpfs_file_sec;
 	if (n < inode->i_hpfs_n_secs) return inode->i_hpfs_disk_sec + n;
 	if (!(fnode = hpfs_map_fnode(inode->i_sb, inode->i_ino, &bh))) return 0;
@@ -58,11 +60,27 @@
 
 void hpfs_truncate(struct inode *i)
 {
+	unsigned long current_blocks = BLOCKS(i->u.hpfs_i.mmu_private);
+	unsigned long new_blocks = BLOCKS(i->i_size);
+	int status;
+
 	if (IS_IMMUTABLE(i)) return /*-EPERM*/;
-	i->i_hpfs_n_secs = 0;
-	i->i_blocks = 1 + ((i->i_size + 511) >> 9);
+
+	if (new_blocks < current_blocks) { /* shrink allocation */
+		i->i_hpfs_n_secs = 0;
+		i->i_blocks = 1 + new_blocks;
+		hpfs_truncate_btree(i->i_sb, i->i_ino, 1, new_blocks);
+	} else if (new_blocks > current_blocks) { /* grow allocation */
+		status = cont_grow_file(i, hpfs_get_block,
+			&i->u.hpfs_i.mmu_private);
+		if (status)
+			printk( "HPFS: unable to grow file "
+				"to %Ld bytes, error = %d\n", 
+				i->i_size, -status);
+	}
+	/* else do nothing, the allocation doesn't change */
+
 	i->u.hpfs_i.mmu_private = i->i_size;
-	hpfs_truncate_btree(i->i_sb, i->i_ino, 1, ((i->i_size + 511) >> 9));
 	hpfs_write_inode(i);
 }
 
diff -ur old/include/linux/fs.h linux/include/linux/fs.h
--- old/include/linux/fs.h	Mon Nov 13 16:24:49 2000
+++ linux/include/linux/fs.h	Mon Nov 13 16:27:24 2000
@@ -1189,6 +1189,7 @@
 extern int block_prepare_write(struct page*, unsigned, unsigned, get_block_t*);
 extern int cont_prepare_write(struct page*, unsigned, unsigned, get_block_t*,
 				unsigned long *);
+extern int cont_grow_file(struct inode *, get_block_t *, unsigned long *);
 extern int block_sync_page(struct page *);
 
 int generic_block_bmap(struct address_space *, long, get_block_t *);
diff -ur old/kernel/ksyms.c linux/kernel/ksyms.c
--- old/kernel/ksyms.c	Mon Nov 13 16:24:51 2000
+++ linux/kernel/ksyms.c	Mon Nov 13 16:27:24 2000
@@ -195,6 +195,7 @@
 EXPORT_SYMBOL(block_prepare_write);
 EXPORT_SYMBOL(block_sync_page);
 EXPORT_SYMBOL(cont_prepare_write);
+EXPORT_SYMBOL(cont_grow_file);
 EXPORT_SYMBOL(generic_commit_write);
 EXPORT_SYMBOL(block_truncate_page);
 EXPORT_SYMBOL(generic_block_bmap);






-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
