Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbVAQSHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVAQSHg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbVAQSHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:07:35 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:18441 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262468AbVAQRu6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:50:58 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] FAT: fs/fat/* cleanup
References: <87pt04oszi.fsf@devron.myhome.or.jp>
	<87llasosxu.fsf@devron.myhome.or.jp>
	<87hdlgoswe.fsf_-_@devron.myhome.or.jp>
	<87d5w4osuv.fsf_-_@devron.myhome.or.jp>
	<878y6sostl.fsf_-_@devron.myhome.or.jp>
	<874qhgosrf.fsf_-_@devron.myhome.or.jp>
	<87zmz8ne5p.fsf_-_@devron.myhome.or.jp>
	<877jmcne0o.fsf_-_@devron.myhome.or.jp>
	<873bx0ndze.fsf_-_@devron.myhome.or.jp>
	<87y8eslzdq.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 18 Jan 2005 02:50:44 +0900
In-Reply-To: <87y8eslzdq.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Tue, 18 Jan 2005 02:49:21 +0900")
Message-ID: <87u0pglzbf.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is just cleanup (whitespace, and place of functions is changed).
No changes of logic.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/cache.c           |   68 ---
 fs/fat/dir.c             |  252 ++++++-----
 fs/fat/file.c            |  168 +++++--
 fs/fat/inode.c           | 1035 +++++++++++++++++++++++------------------------
 fs/fat/misc.c            |   94 +---
 include/linux/msdos_fs.h |  113 ++---
 6 files changed, 846 insertions(+), 884 deletions(-)

diff -puN fs/fat/cache.c~fat_cleanup fs/fat/cache.c
--- linux-2.6.10/fs/fat/cache.c~fat_cleanup	2005-01-10 01:57:57.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/fat/cache.c	2005-01-10 05:07:47.000000000 +0900
@@ -296,7 +296,7 @@ static int __fat_access(struct super_blo
 	return next;
 }
 
-/* 
+/*
  * Returns the this'th FAT entry, -1 if it is an end-of-file entry. If
  * new_value is != -1, that FAT entry is replaced by it.
  */
@@ -343,7 +343,7 @@ int fat_get_cluster(struct inode *inode,
 	int nr;
 
 	BUG_ON(MSDOS_I(inode)->i_start == 0);
-	
+
 	*fclus = 0;
 	*dclus = MSDOS_I(inode)->i_start;
 	if (cluster == 0)
@@ -368,7 +368,7 @@ int fat_get_cluster(struct inode *inode,
 
 		nr = fat_access(sb, *dclus, -1);
 		if (nr < 0)
- 			return nr;
+			return nr;
 		else if (nr == FAT_ENT_FREE) {
 			fat_fs_panic(sb, "%s: invalid cluster chain"
 				     " (i_pos %lld)", __FUNCTION__,
@@ -437,65 +437,3 @@ int fat_bmap(struct inode *inode, sector
 	}
 	return 0;
 }
-
-/* Free all clusters after the skip'th cluster. */
-int fat_free(struct inode *inode, int skip)
-{
-	struct super_block *sb = inode->i_sb;
-	int nr, ret, fclus, dclus;
-
-	if (MSDOS_I(inode)->i_start == 0)
-		return 0;
-
-	if (skip) {
-		ret = fat_get_cluster(inode, skip - 1, &fclus, &dclus);
-		if (ret < 0)
-			return ret;
-		else if (ret == FAT_ENT_EOF)
-			return 0;
-
-		nr = fat_access(sb, dclus, -1);
-		if (nr == FAT_ENT_EOF)
-			return 0;
-		else if (nr > 0) {
-			/*
-			 * write a new EOF, and get the remaining cluster
-			 * chain for freeing.
-			 */
-			nr = fat_access(sb, dclus, FAT_ENT_EOF);
-		}
-		if (nr < 0)
-			return nr;
-
-		fat_cache_inval_inode(inode);
-	} else {
-		fat_cache_inval_inode(inode);
-
-		nr = MSDOS_I(inode)->i_start;
-		MSDOS_I(inode)->i_start = 0;
-		MSDOS_I(inode)->i_logstart = 0;
-		mark_inode_dirty(inode);
-	}
-
-	lock_fat(sb);
-	do {
-		nr = fat_access(sb, nr, FAT_ENT_FREE);
-		if (nr < 0)
-			goto error;
-		else if (nr == FAT_ENT_FREE) {
-			fat_fs_panic(sb, "%s: deleting beyond EOF (i_pos %lld)",
-				     __FUNCTION__, MSDOS_I(inode)->i_pos);
-			nr = -EIO;
-			goto error;
-		}
-		if (MSDOS_SB(sb)->free_clusters != -1)
-			MSDOS_SB(sb)->free_clusters++;
-		inode->i_blocks -= MSDOS_SB(sb)->cluster_size >> 9;
-	} while (nr != FAT_ENT_EOF);
-	fat_clusters_flush(sb);
-	nr = 0;
-error:
-	unlock_fat(sb);
-
-	return nr;
-}
diff -puN fs/fat/dir.c~fat_cleanup fs/fat/dir.c
--- linux-2.6.10/fs/fat/dir.c~fat_cleanup	2005-01-10 01:57:57.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/fat/dir.c	2005-01-10 05:07:47.000000000 +0900
@@ -20,20 +20,8 @@
 #include <linux/dirent.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
-
 #include <asm/uaccess.h>
 
-static int fat_dir_ioctl(struct inode * inode, struct file * filp,
-		  unsigned int cmd, unsigned long arg);
-static int fat_readdir(struct file *filp, void *dirent, filldir_t filldir);
-
-struct file_operations fat_dir_operations = {
-	.read		= generic_read_dir,
-	.readdir	= fat_readdir,
-	.ioctl		= fat_dir_ioctl,
-	.fsync		= file_fsync,
-};
-
 /*
  * Convert Unicode 16 to UTF8, translated Unicode, or ASCII.
  * If uni_xlate is enabled and we can't get a 1:1 conversion, use a
@@ -44,9 +32,8 @@ struct file_operations fat_dir_operation
  * but ignore that right now.
  * Ahem... Stack smashing in ring 0 isn't fun. Fixed.
  */
-static int
-uni16_to_x8(unsigned char *ascii, wchar_t *uni, int uni_xlate,
-	    struct nls_table *nls)
+static int uni16_to_x8(unsigned char *ascii, wchar_t *uni, int uni_xlate,
+		       struct nls_table *nls)
 {
 	wchar_t *ip, ec;
 	unsigned char *op, nc;
@@ -84,20 +71,6 @@ uni16_to_x8(unsigned char *ascii, wchar_
 	return (op - ascii);
 }
 
-#if 0
-static void dump_de(struct msdos_dir_entry *de)
-{
-	int i;
-	unsigned char *p = (unsigned char *) de;
-	printk("[");
-
-	for (i = 0; i < 32; i++, p++) {
-		printk("%02x ", *p);
-	}
-	printk("]\n");
-}
-#endif
-
 static inline int
 fat_short2uni(struct nls_table *t, unsigned char *c, int clen, wchar_t *uni)
 {
@@ -123,17 +96,17 @@ fat_short2lower_uni(struct nls_table *t,
 		charlen = 1;
 	} else if (charlen <= 1) {
 		unsigned char nc = t->charset2lower[*c];
-		
+
 		if (!nc)
 			nc = *c;
-		
+
 		if ( (charlen = t->char2uni(&nc, 1, uni)) < 0) {
 			*uni = 0x003f;	/* a question mark */
 			charlen = 1;
 		}
 	} else
 		*uni = wc;
-	
+
 	return charlen;
 }
 
@@ -150,7 +123,7 @@ fat_shortname2uni(struct nls_table *nls,
 	else if (opt & VFAT_SFN_DISPLAY_WINNT) {
 		if (lower)
 			len = fat_short2lower_uni(nls, buf, buf_size, uni_buf);
-		else 
+		else
 			len = fat_short2uni(nls, buf, buf_size, uni_buf);
 	} else
 		len = fat_short2uni(nls, buf, buf_size, uni_buf);
@@ -326,6 +299,8 @@ EODir:
 	return res;
 }
 
+EXPORT_SYMBOL(fat_search_long);
+
 struct fat_ioctl_filldir_callback {
 	struct dirent __user *dirent;
 	int result;
@@ -336,8 +311,6 @@ struct fat_ioctl_filldir_callback {
 	int short_len;
 };
 
-EXPORT_SYMBOL(fat_search_long);
-
 static int fat_readdirx(struct inode *inode, struct file *filp, void *dirent,
 			filldir_t filldir, int short_only, int both)
 {
@@ -362,7 +335,7 @@ static int fat_readdirx(struct inode *in
 	int chi, chl, i, i2, j, last, last_u, dotoffset = 0;
 	loff_t i_pos, cpos;
 	int ret = 0;
-	
+
 	lock_kernel();
 
 	cpos = filp->f_pos;
@@ -385,7 +358,7 @@ static int fat_readdirx(struct inode *in
 		goto out;
 	}
 
- 	bh = NULL;
+	bh = NULL;
 GetNew:
 	long_slots = 0;
 	if (fat_get_entry(inode,&cpos,&bh,&de,&i_pos) == -1)
@@ -694,6 +667,132 @@ static int fat_dir_ioctl(struct inode * 
 	return ret;
 }
 
+struct file_operations fat_dir_operations = {
+	.read		= generic_read_dir,
+	.readdir	= fat_readdir,
+	.ioctl		= fat_dir_ioctl,
+	.fsync		= file_fsync,
+};
+
+static int fat_get_short_entry(struct inode *dir, loff_t *pos,
+			       struct buffer_head **bh,
+			       struct msdos_dir_entry **de, loff_t *i_pos)
+{
+	while (fat_get_entry(dir, pos, bh, de, i_pos) >= 0) {
+		/* free entry or long name entry or volume label */
+		if (!IS_FREE((*de)->name) && !((*de)->attr & ATTR_VOLUME))
+			return 0;
+	}
+	return -ENOENT;
+}
+
+/* See if directory is empty */
+int fat_dir_empty(struct inode *dir)
+{
+	struct buffer_head *bh;
+	struct msdos_dir_entry *de;
+	loff_t cpos, i_pos;
+	int result = 0;
+
+	bh = NULL;
+	cpos = 0;
+	while (fat_get_short_entry(dir, &cpos, &bh, &de, &i_pos) >= 0) {
+		if (strncmp(de->name, MSDOS_DOT   , MSDOS_NAME) &&
+		    strncmp(de->name, MSDOS_DOTDOT, MSDOS_NAME)) {
+			result = -ENOTEMPTY;
+			break;
+		}
+	}
+	brelse(bh);
+	return result;
+}
+
+EXPORT_SYMBOL(fat_dir_empty);
+
+/*
+ * fat_subdirs counts the number of sub-directories of dir. It can be run
+ * on directories being created.
+ */
+int fat_subdirs(struct inode *dir)
+{
+	struct buffer_head *bh;
+	struct msdos_dir_entry *de;
+	loff_t cpos, i_pos;
+	int count = 0;
+
+	bh = NULL;
+	cpos = 0;
+	while (fat_get_short_entry(dir, &cpos, &bh, &de, &i_pos) >= 0) {
+		if (de->attr & ATTR_DIR)
+			count++;
+	}
+	brelse(bh);
+	return count;
+}
+
+/*
+ * Scans a directory for a given file (name points to its formatted name).
+ * Returns an error code or zero.
+ */
+int fat_scan(struct inode *dir, const unsigned char *name,
+	     struct buffer_head **bh, struct msdos_dir_entry **de,
+	     loff_t *i_pos)
+{
+	loff_t cpos;
+
+	*bh = NULL;
+	cpos = 0;
+	while (fat_get_short_entry(dir, &cpos, bh, de, i_pos) >= 0) {
+		if (!strncmp((*de)->name, name, MSDOS_NAME))
+			return 0;
+	}
+	return -ENOENT;
+}
+
+EXPORT_SYMBOL(fat_scan);
+
+static struct buffer_head *fat_extend_dir(struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	struct buffer_head *bh, *res = NULL;
+	int nr, sec_per_clus = MSDOS_SB(sb)->sec_per_clus;
+	sector_t sector, last_sector;
+
+	if (MSDOS_SB(sb)->fat_bits != 32) {
+		if (inode->i_ino == MSDOS_ROOT_INO)
+			return ERR_PTR(-ENOSPC);
+	}
+
+	nr = fat_add_cluster(inode);
+	if (nr < 0)
+		return ERR_PTR(nr);
+
+	sector = ((sector_t)nr - 2) * sec_per_clus + MSDOS_SB(sb)->data_start;
+	last_sector = sector + sec_per_clus;
+	for ( ; sector < last_sector; sector++) {
+		if ((bh = sb_getblk(sb, sector))) {
+			memset(bh->b_data, 0, sb->s_blocksize);
+			set_buffer_uptodate(bh);
+			mark_buffer_dirty(bh);
+			if (!res)
+				res = bh;
+			else
+				brelse(bh);
+		}
+	}
+	if (res == NULL)
+		res = ERR_PTR(-EIO);
+	if (inode->i_size & (sb->s_blocksize - 1)) {
+		fat_fs_panic(sb, "Odd directory size");
+		inode->i_size = (inode->i_size + sb->s_blocksize)
+			& ~((loff_t)sb->s_blocksize - 1);
+	}
+	inode->i_size += MSDOS_SB(sb)->cluster_size;
+	MSDOS_I(inode)->mmu_private += MSDOS_SB(sb)->cluster_size;
+
+	return res;
+}
+
 /* This assumes that size of cluster is above the 32*slots */
 
 int fat_add_entries(struct inode *dir,int slots, struct buffer_head **bh,
@@ -722,7 +821,7 @@ int fat_add_entries(struct inode *dir,in
 			offset = curr;
 		}
 	}
-	if ((dir->i_ino == MSDOS_ROOT_INO) && (MSDOS_SB(sb)->fat_bits != 32)) 
+	if ((dir->i_ino == MSDOS_ROOT_INO) && (MSDOS_SB(sb)->fat_bits != 32))
 		return -ENOSPC;
 	new_bh = fat_extend_dir(dir);
 	if (IS_ERR(new_bh))
@@ -773,80 +872,3 @@ int fat_new_dir(struct inode *dir, struc
 }
 
 EXPORT_SYMBOL(fat_new_dir);
-
-static int fat_get_short_entry(struct inode *dir, loff_t *pos,
-			       struct buffer_head **bh,
-			       struct msdos_dir_entry **de, loff_t *i_pos)
-{
-	while (fat_get_entry(dir, pos, bh, de, i_pos) >= 0) {
-		/* free entry or long name entry or volume label */
-		if (!IS_FREE((*de)->name) && !((*de)->attr & ATTR_VOLUME))
-			return 0;
-	}
-	return -ENOENT;
-}
-
-/* See if directory is empty */
-int fat_dir_empty(struct inode *dir)
-{
-	struct buffer_head *bh;
-	struct msdos_dir_entry *de;
-	loff_t cpos, i_pos;
-	int result = 0;
-
-	bh = NULL;
-	cpos = 0;
-	while (fat_get_short_entry(dir, &cpos, &bh, &de, &i_pos) >= 0) {
-		if (strncmp(de->name, MSDOS_DOT   , MSDOS_NAME) &&
-		    strncmp(de->name, MSDOS_DOTDOT, MSDOS_NAME)) {
-			result = -ENOTEMPTY;
-			break;
-		}
-	}
-	brelse(bh);
-	return result;
-}
-
-EXPORT_SYMBOL(fat_dir_empty);
-
-/*
- * fat_subdirs counts the number of sub-directories of dir. It can be run
- * on directories being created.
- */
-int fat_subdirs(struct inode *dir)
-{
-	struct buffer_head *bh;
-	struct msdos_dir_entry *de;
-	loff_t cpos, i_pos;
-	int count = 0;
-
-	bh = NULL;
-	cpos = 0;
-	while (fat_get_short_entry(dir, &cpos, &bh, &de, &i_pos) >= 0) {
-		if (de->attr & ATTR_DIR)
-			count++;
-	}
-	brelse(bh);
-	return count;
-}
-
-/*
- * Scans a directory for a given file (name points to its formatted name).
- * Returns an error code or zero.
- */
-int fat_scan(struct inode *dir, const unsigned char *name,
-	     struct buffer_head **bh, struct msdos_dir_entry **de,
-	     loff_t *i_pos)
-{
-	loff_t cpos;
-
-	*bh = NULL;
-	cpos = 0;
-	while (fat_get_short_entry(dir, &cpos, bh, de, i_pos) >= 0) {
-		if (!strncmp((*de)->name, name, MSDOS_NAME))
-			return 0;
-	}
-	return -ENOENT;
-}
-
-EXPORT_SYMBOL(fat_scan);
diff -puN fs/fat/file.c~fat_cleanup fs/fat/file.c
--- linux-2.6.10/fs/fat/file.c~fat_cleanup	2005-01-10 01:57:57.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/fat/file.c	2005-01-10 05:07:45.000000000 +0900
@@ -6,13 +6,26 @@
  *  regular file handling primitives for fat-based filesystems
  */
 
+#include <linux/module.h>
 #include <linux/time.h>
 #include <linux/msdos_fs.h>
 #include <linux/smp_lock.h>
 #include <linux/buffer_head.h>
 
 static ssize_t fat_file_write(struct file *filp, const char __user *buf,
-			      size_t count, loff_t *ppos);
+			      size_t count, loff_t *ppos)
+{
+	struct inode *inode = filp->f_dentry->d_inode;
+	int retval;
+
+	retval = generic_file_write(filp, buf, count, ppos);
+	if (retval > 0) {
+		inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
+		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
+		mark_inode_dirty(inode);
+	}
+	return retval;
+}
 
 struct file_operations fat_file_operations = {
 	.llseek		= generic_file_llseek,
@@ -25,63 +38,117 @@ struct file_operations fat_file_operatio
 	.sendfile	= generic_file_sendfile,
 };
 
-struct inode_operations fat_file_inode_operations = {
-	.truncate	= fat_truncate,
-	.setattr	= fat_notify_change,
-};
-
-int fat_get_block(struct inode *inode, sector_t iblock,
-		  struct buffer_head *bh_result, int create)
+int fat_notify_change(struct dentry *dentry, struct iattr *attr)
 {
-	struct super_block *sb = inode->i_sb;
-	sector_t phys;
-	int err;
+	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
+	struct inode *inode = dentry->d_inode;
+	int mask, error = 0;
 
-	err = fat_bmap(inode, iblock, &phys);
-	if (err)
-		return err;
-	if (phys) {
-		map_bh(bh_result, sb, phys);
-		return 0;
-	}
-	if (!create)
-		return 0;
-	if (iblock != MSDOS_I(inode)->mmu_private >> sb->s_blocksize_bits) {
-		fat_fs_panic(sb, "corrupted file size (i_pos %lld, %lld)",
-			     MSDOS_I(inode)->i_pos, MSDOS_I(inode)->mmu_private);
-		return -EIO;
+	lock_kernel();
+
+	/* FAT cannot truncate to a longer file */
+	if (attr->ia_valid & ATTR_SIZE) {
+		if (attr->ia_size > inode->i_size) {
+			error = -EPERM;
+			goto out;
+		}
 	}
-	if (!((unsigned long)iblock & (MSDOS_SB(sb)->sec_per_clus - 1))) {
-		int error;
 
-		error = fat_add_cluster(inode);
-		if (error < 0)
-			return error;
+	error = inode_change_ok(inode, attr);
+	if (error) {
+		if (sbi->options.quiet)
+			error = 0;
+		goto out;
+	}
+	if (((attr->ia_valid & ATTR_UID) &&
+	     (attr->ia_uid != sbi->options.fs_uid)) ||
+	    ((attr->ia_valid & ATTR_GID) &&
+	     (attr->ia_gid != sbi->options.fs_gid)) ||
+	    ((attr->ia_valid & ATTR_MODE) &&
+	     (attr->ia_mode & ~MSDOS_VALID_MODE)))
+		error = -EPERM;
+
+	if (error) {
+		if (sbi->options.quiet)
+			error = 0;
+		goto out;
 	}
-	MSDOS_I(inode)->mmu_private += sb->s_blocksize;
-	err = fat_bmap(inode, iblock, &phys);
-	if (err)
-		return err;
-	if (!phys)
-		BUG();
-	set_buffer_new(bh_result);
-	map_bh(bh_result, sb, phys);
-	return 0;
+	error = inode_setattr(inode, attr);
+	if (error)
+		goto out;
+
+	if (S_ISDIR(inode->i_mode))
+		mask = sbi->options.fs_dmask;
+	else
+		mask = sbi->options.fs_fmask;
+	inode->i_mode &= S_IFMT | (S_IRWXUGO & ~mask);
+out:
+	unlock_kernel();
+	return error;
 }
 
-static ssize_t fat_file_write(struct file *filp, const char __user *buf,
-			      size_t count, loff_t *ppos)
+EXPORT_SYMBOL(fat_notify_change);
+
+/* Free all clusters after the skip'th cluster. */
+static int fat_free(struct inode *inode, int skip)
 {
-	struct inode *inode = filp->f_dentry->d_inode;
-	int retval;
+	struct super_block *sb = inode->i_sb;
+	int nr, ret, fclus, dclus;
 
-	retval = generic_file_write(filp, buf, count, ppos);
-	if (retval > 0) {
-		inode->i_mtime = inode->i_ctime = CURRENT_TIME_SEC;
-		MSDOS_I(inode)->i_attrs |= ATTR_ARCH;
+	if (MSDOS_I(inode)->i_start == 0)
+		return 0;
+
+	if (skip) {
+		ret = fat_get_cluster(inode, skip - 1, &fclus, &dclus);
+		if (ret < 0)
+			return ret;
+		else if (ret == FAT_ENT_EOF)
+			return 0;
+
+		nr = fat_access(sb, dclus, -1);
+		if (nr == FAT_ENT_EOF)
+			return 0;
+		else if (nr > 0) {
+			/*
+			 * write a new EOF, and get the remaining cluster
+			 * chain for freeing.
+			 */
+			nr = fat_access(sb, dclus, FAT_ENT_EOF);
+		}
+		if (nr < 0)
+			return nr;
+
+		fat_cache_inval_inode(inode);
+	} else {
+		fat_cache_inval_inode(inode);
+
+		nr = MSDOS_I(inode)->i_start;
+		MSDOS_I(inode)->i_start = 0;
+		MSDOS_I(inode)->i_logstart = 0;
 		mark_inode_dirty(inode);
 	}
-	return retval;
+
+	lock_fat(sb);
+	do {
+		nr = fat_access(sb, nr, FAT_ENT_FREE);
+		if (nr < 0)
+			goto error;
+		else if (nr == FAT_ENT_FREE) {
+			fat_fs_panic(sb, "%s: deleting beyond EOF (i_pos %lld)",
+				     __FUNCTION__, MSDOS_I(inode)->i_pos);
+			nr = -EIO;
+			goto error;
+		}
+		if (MSDOS_SB(sb)->free_clusters != -1)
+			MSDOS_SB(sb)->free_clusters++;
+		inode->i_blocks -= MSDOS_SB(sb)->cluster_size >> 9;
+	} while (nr != FAT_ENT_EOF);
+	fat_clusters_flush(sb);
+	nr = 0;
+error:
+	unlock_fat(sb);
+
+	return nr;
 }
 
 void fat_truncate(struct inode *inode)
@@ -90,7 +157,7 @@ void fat_truncate(struct inode *inode)
 	const unsigned int cluster_size = sbi->cluster_size;
 	int nr_clusters;
 
-	/* 
+	/*
 	 * This protects against truncating a file bigger than it was then
 	 * trying to write into the hole.
 	 */
@@ -106,3 +173,8 @@ void fat_truncate(struct inode *inode)
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
 	mark_inode_dirty(inode);
 }
+
+struct inode_operations fat_file_inode_operations = {
+	.truncate	= fat_truncate,
+	.setattr	= fat_notify_change,
+};
diff -puN fs/fat/inode.c~fat_cleanup fs/fat/inode.c
--- linux-2.6.10/fs/fat/inode.c~fat_cleanup	2005-01-10 01:57:57.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/fat/inode.c	2005-01-10 05:07:47.000000000 +0900
@@ -7,7 +7,7 @@
  *
  *  Fixes:
  *
- *  	Max Cohan: Fixed invalid FSINFO offset when info_sector is 0
+ *	Max Cohan: Fixed invalid FSINFO offset when info_sector is 0
  */
 
 #include <linux/module.h>
@@ -32,8 +32,76 @@
 static int fat_default_codepage = CONFIG_FAT_DEFAULT_CODEPAGE;
 static char fat_default_iocharset[] = CONFIG_FAT_DEFAULT_IOCHARSET;
 
-static int fat_statfs(struct super_block *sb, struct kstatfs *buf);
-static int fat_write_inode(struct inode *inode, int wait);
+
+static int fat_get_block(struct inode *inode, sector_t iblock,
+			 struct buffer_head *bh_result, int create)
+{
+	struct super_block *sb = inode->i_sb;
+	sector_t phys;
+	int err;
+
+	err = fat_bmap(inode, iblock, &phys);
+	if (err)
+		return err;
+	if (phys) {
+		map_bh(bh_result, sb, phys);
+		return 0;
+	}
+	if (!create)
+		return 0;
+	if (iblock != MSDOS_I(inode)->mmu_private >> sb->s_blocksize_bits) {
+		fat_fs_panic(sb, "corrupted file size (i_pos %lld, %lld)",
+			     MSDOS_I(inode)->i_pos, MSDOS_I(inode)->mmu_private);
+		return -EIO;
+	}
+	if (!((unsigned long)iblock & (MSDOS_SB(sb)->sec_per_clus - 1))) {
+		int error;
+
+		error = fat_add_cluster(inode);
+		if (error < 0)
+			return error;
+	}
+	MSDOS_I(inode)->mmu_private += sb->s_blocksize;
+	err = fat_bmap(inode, iblock, &phys);
+	if (err)
+		return err;
+	if (!phys)
+		BUG();
+	set_buffer_new(bh_result);
+	map_bh(bh_result, sb, phys);
+	return 0;
+}
+
+static int fat_writepage(struct page *page, struct writeback_control *wbc)
+{
+	return block_write_full_page(page, fat_get_block, wbc);
+}
+
+static int fat_readpage(struct file *file, struct page *page)
+{
+	return block_read_full_page(page, fat_get_block);
+}
+
+static int fat_prepare_write(struct file *file, struct page *page,
+			     unsigned from, unsigned to)
+{
+	return cont_prepare_write(page, from, to, fat_get_block,
+				  &MSDOS_I(page->mapping->host)->mmu_private);
+}
+
+static sector_t _fat_bmap(struct address_space *mapping, sector_t block)
+{
+	return generic_block_bmap(mapping, block, fat_get_block);
+}
+
+static struct address_space_operations fat_aops = {
+	.readpage	= fat_readpage,
+	.writepage	= fat_writepage,
+	.sync_page	= block_sync_page,
+	.prepare_write	= fat_prepare_write,
+	.commit_write	= generic_commit_write,
+	.bmap		= _fat_bmap
+};
 
 /*
  * New FAT inode stuff. We do the following:
@@ -122,7 +190,102 @@ struct inode *fat_iget(struct super_bloc
 	return inode;
 }
 
-static int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de);
+static int is_exec(unsigned char *extension)
+{
+	unsigned char *exe_extensions = "EXECOMBAT", *walk;
+
+	for (walk = exe_extensions; *walk; walk += 3)
+		if (!strncmp(extension, walk, 3))
+			return 1;
+	return 0;
+}
+
+static int fat_calc_dir_size(struct inode *inode)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	int ret, fclus, dclus;
+
+	inode->i_size = 0;
+	if (MSDOS_I(inode)->i_start == 0)
+		return 0;
+
+	ret = fat_get_cluster(inode, FAT_ENT_EOF, &fclus, &dclus);
+	if (ret < 0)
+		return ret;
+	inode->i_size = (fclus + 1) << sbi->cluster_bits;
+
+	return 0;
+}
+
+/* doesn't deal with root inode */
+static int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
+{
+	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	int error;
+
+	MSDOS_I(inode)->i_pos = 0;
+	inode->i_uid = sbi->options.fs_uid;
+	inode->i_gid = sbi->options.fs_gid;
+	inode->i_version++;
+	inode->i_generation = get_seconds();
+
+	if ((de->attr & ATTR_DIR) && !IS_FREE(de->name)) {
+		inode->i_generation &= ~1;
+		inode->i_mode = MSDOS_MKMODE(de->attr,
+			S_IRWXUGO & ~sbi->options.fs_dmask) | S_IFDIR;
+		inode->i_op = sbi->dir_ops;
+		inode->i_fop = &fat_dir_operations;
+
+		MSDOS_I(inode)->i_start = le16_to_cpu(de->start);
+		if (sbi->fat_bits == 32)
+			MSDOS_I(inode)->i_start |= (le16_to_cpu(de->starthi) << 16);
+
+		MSDOS_I(inode)->i_logstart = MSDOS_I(inode)->i_start;
+		error = fat_calc_dir_size(inode);
+		if (error < 0)
+			return error;
+		MSDOS_I(inode)->mmu_private = inode->i_size;
+
+		inode->i_nlink = fat_subdirs(inode);
+	} else { /* not a directory */
+		inode->i_generation |= 1;
+		inode->i_mode = MSDOS_MKMODE(de->attr,
+		    ((sbi->options.showexec &&
+			!is_exec(de->ext))
+			? S_IRUGO|S_IWUGO : S_IRWXUGO)
+		    & ~sbi->options.fs_fmask) | S_IFREG;
+		MSDOS_I(inode)->i_start = le16_to_cpu(de->start);
+		if (sbi->fat_bits == 32)
+			MSDOS_I(inode)->i_start |= (le16_to_cpu(de->starthi) << 16);
+
+		MSDOS_I(inode)->i_logstart = MSDOS_I(inode)->i_start;
+		inode->i_size = le32_to_cpu(de->size);
+		inode->i_op = &fat_file_inode_operations;
+		inode->i_fop = &fat_file_operations;
+		inode->i_mapping->a_ops = &fat_aops;
+		MSDOS_I(inode)->mmu_private = inode->i_size;
+	}
+	if(de->attr & ATTR_SYS)
+		if (sbi->options.sys_immutable)
+			inode->i_flags |= S_IMMUTABLE;
+	MSDOS_I(inode)->i_attrs = de->attr & ATTR_UNUSED;
+	/* this is as close to the truth as we can get ... */
+	inode->i_blksize = sbi->cluster_size;
+	inode->i_blocks = ((inode->i_size + (sbi->cluster_size - 1))
+			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
+	inode->i_mtime.tv_sec = inode->i_atime.tv_sec =
+		date_dos2unix(le16_to_cpu(de->time), le16_to_cpu(de->date));
+	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = 0;
+	inode->i_ctime.tv_sec =
+		MSDOS_SB(sb)->options.isvfat
+		? date_dos2unix(le16_to_cpu(de->ctime), le16_to_cpu(de->cdate))
+		: inode->i_mtime.tv_sec;
+	inode->i_ctime.tv_nsec = de->ctime_ms * 1000000;
+	MSDOS_I(inode)->i_ctime_ms = de->ctime_ms;
+
+	return 0;
+}
 
 struct inode *fat_build_inode(struct super_block *sb,
 			struct msdos_dir_entry *de, loff_t i_pos, int *res)
@@ -177,29 +340,343 @@ static void fat_clear_inode(struct inode
 
 static void fat_put_super(struct super_block *sb)
 {
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+
+	if (!(sb->s_flags & MS_RDONLY))
+		fat_clusters_flush(sb);
+
+	if (sbi->nls_disk) {
+		unload_nls(sbi->nls_disk);
+		sbi->nls_disk = NULL;
+		sbi->options.codepage = fat_default_codepage;
+	}
+	if (sbi->nls_io) {
+		unload_nls(sbi->nls_io);
+		sbi->nls_io = NULL;
+	}
+	if (sbi->options.iocharset != fat_default_iocharset) {
+		kfree(sbi->options.iocharset);
+		sbi->options.iocharset = fat_default_iocharset;
+	}
+
+	sb->s_fs_info = NULL;
+	kfree(sbi);
+}
+
+static kmem_cache_t *fat_inode_cachep;
+
+static struct inode *fat_alloc_inode(struct super_block *sb)
+{
+	struct msdos_inode_info *ei;
+	ei = kmem_cache_alloc(fat_inode_cachep, SLAB_KERNEL);
+	if (!ei)
+		return NULL;
+	return &ei->vfs_inode;
+}
+
+static void fat_destroy_inode(struct inode *inode)
+{
+	kmem_cache_free(fat_inode_cachep, MSDOS_I(inode));
+}
+
+static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+{
+	struct msdos_inode_info *ei = (struct msdos_inode_info *)foo;
+
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR) {
+		spin_lock_init(&ei->cache_lru_lock);
+		ei->nr_caches = 0;
+		ei->cache_valid_id = FAT_CACHE_VALID + 1;
+		INIT_LIST_HEAD(&ei->cache_lru);
+		INIT_HLIST_NODE(&ei->i_fat_hash);
+		inode_init_once(&ei->vfs_inode);
+	}
+}
+
+static int __init fat_init_inodecache(void)
+{
+	fat_inode_cachep = kmem_cache_create("fat_inode_cache",
+					     sizeof(struct msdos_inode_info),
+					     0, SLAB_RECLAIM_ACCOUNT,
+					     init_once, NULL);
+	if (fat_inode_cachep == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+static void __exit fat_destroy_inodecache(void)
+{
+	if (kmem_cache_destroy(fat_inode_cachep))
+		printk(KERN_INFO "fat_inode_cache: not all structures were freed\n");
+}
+
+static int fat_remount(struct super_block *sb, int *flags, char *data)
+{
+	*flags |= MS_NODIRATIME;
+	return 0;
+}
+
+static int fat_statfs(struct super_block *sb, struct kstatfs *buf)
+{
+	int free, nr, ret;
+
+	if (MSDOS_SB(sb)->free_clusters != -1)
+		free = MSDOS_SB(sb)->free_clusters;
+	else {
+		lock_fat(sb);
+		if (MSDOS_SB(sb)->free_clusters != -1)
+			free = MSDOS_SB(sb)->free_clusters;
+		else {
+			free = 0;
+			for (nr = 2; nr < MSDOS_SB(sb)->clusters + 2; nr++) {
+				ret = fat_access(sb, nr, -1);
+				if (ret < 0) {
+					unlock_fat(sb);
+					return ret;
+				} else if (ret == FAT_ENT_FREE)
+					free++;
+			}
+			MSDOS_SB(sb)->free_clusters = free;
+		}
+		unlock_fat(sb);
+	}
+
+	buf->f_type = sb->s_magic;
+	buf->f_bsize = MSDOS_SB(sb)->cluster_size;
+	buf->f_blocks = MSDOS_SB(sb)->clusters;
+	buf->f_bfree = free;
+	buf->f_bavail = free;
+	buf->f_namelen = MSDOS_SB(sb)->options.isvfat ? 260 : 12;
+
+	return 0;
+}
+
+static int fat_write_inode(struct inode *inode, int wait)
+{
+	struct super_block *sb = inode->i_sb;
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	struct buffer_head *bh;
+	struct msdos_dir_entry *raw_entry;
+	loff_t i_pos;
+
+retry:
+	i_pos = MSDOS_I(inode)->i_pos;
+	if (inode->i_ino == MSDOS_ROOT_INO || !i_pos) {
+		return 0;
+	}
+	lock_kernel();
+	if (!(bh = sb_bread(sb, i_pos >> sbi->dir_per_block_bits))) {
+		printk(KERN_ERR "FAT: unable to read inode block "
+		       "for updating (i_pos %lld)\n", i_pos);
+		unlock_kernel();
+		return -EIO;
+	}
+	spin_lock(&sbi->inode_hash_lock);
+	if (i_pos != MSDOS_I(inode)->i_pos) {
+		spin_unlock(&sbi->inode_hash_lock);
+		brelse(bh);
+		unlock_kernel();
+		goto retry;
+	}
+
+	raw_entry = &((struct msdos_dir_entry *) (bh->b_data))
+	    [i_pos & (sbi->dir_per_block - 1)];
+	if (S_ISDIR(inode->i_mode)) {
+		raw_entry->attr = ATTR_DIR;
+		raw_entry->size = 0;
+	}
+	else {
+		raw_entry->attr = ATTR_NONE;
+		raw_entry->size = cpu_to_le32(inode->i_size);
+	}
+	raw_entry->attr |= MSDOS_MKATTR(inode->i_mode) |
+	    MSDOS_I(inode)->i_attrs;
+	raw_entry->start = cpu_to_le16(MSDOS_I(inode)->i_logstart);
+	raw_entry->starthi = cpu_to_le16(MSDOS_I(inode)->i_logstart >> 16);
+	fat_date_unix2dos(inode->i_mtime.tv_sec, &raw_entry->time, &raw_entry->date);
+	if (sbi->options.isvfat) {
+		fat_date_unix2dos(inode->i_ctime.tv_sec,&raw_entry->ctime,&raw_entry->cdate);
+		raw_entry->ctime_ms = MSDOS_I(inode)->i_ctime_ms; /* use i_ctime.tv_nsec? */
+	}
+	spin_unlock(&sbi->inode_hash_lock);
+	mark_buffer_dirty(bh);
+	brelse(bh);
+	unlock_kernel();
+	return 0;
+}
+
+static int fat_show_options(struct seq_file *m, struct vfsmount *mnt);
+static struct super_operations fat_sops = {
+	.alloc_inode	= fat_alloc_inode,
+	.destroy_inode	= fat_destroy_inode,
+	.write_inode	= fat_write_inode,
+	.delete_inode	= fat_delete_inode,
+	.put_super	= fat_put_super,
+	.statfs		= fat_statfs,
+	.clear_inode	= fat_clear_inode,
+	.remount_fs	= fat_remount,
+
+	.read_inode	= make_bad_inode,
+
+	.show_options	= fat_show_options,
+};
+
+/*
+ * a FAT file handle with fhtype 3 is
+ *  0/  i_ino - for fast, reliable lookup if still in the cache
+ *  1/  i_generation - to see if i_ino is still valid
+ *          bit 0 == 0 iff directory
+ *  2/  i_pos(8-39) - if ino has changed, but still in cache
+ *  3/  i_pos(4-7)|i_logstart - to semi-verify inode found at i_pos
+ *  4/  i_pos(0-3)|parent->i_logstart - maybe used to hunt for the file on disc
+ *
+ * Hack for NFSv2: Maximum FAT entry number is 28bits and maximum
+ * i_pos is 40bits (blocknr(32) + dir offset(8)), so two 4bits
+ * of i_logstart is used to store the directory entry offset.
+ */
+
+static struct dentry *
+fat_decode_fh(struct super_block *sb, __u32 *fh, int len, int fhtype,
+	      int (*acceptable)(void *context, struct dentry *de),
+	      void *context)
+{
+	if (fhtype != 3)
+		return ERR_PTR(-ESTALE);
+	if (len < 5)
+		return ERR_PTR(-ESTALE);
+
+	return sb->s_export_op->find_exported_dentry(sb, fh, NULL, acceptable, context);
+}
+
+static struct dentry *fat_get_dentry(struct super_block *sb, void *inump)
+{
+	struct inode *inode = NULL;
+	struct dentry *result;
+	__u32 *fh = inump;
+
+	inode = iget(sb, fh[0]);
+	if (!inode || is_bad_inode(inode) || inode->i_generation != fh[1]) {
+		if (inode)
+			iput(inode);
+		inode = NULL;
+	}
+	if (!inode) {
+		loff_t i_pos;
+		int i_logstart = fh[3] & 0x0fffffff;
+
+		i_pos = (loff_t)fh[2] << 8;
+		i_pos |= ((fh[3] >> 24) & 0xf0) | (fh[4] >> 28);
+
+		/* try 2 - see if i_pos is in F-d-c
+		 * require i_logstart to be the same
+		 * Will fail if you truncate and then re-write
+		 */
+
+		inode = fat_iget(sb, i_pos);
+		if (inode && MSDOS_I(inode)->i_logstart != i_logstart) {
+			iput(inode);
+			inode = NULL;
+		}
+	}
+	if (!inode) {
+		/* For now, do nothing
+		 * What we could do is:
+		 * follow the file starting at fh[4], and record
+		 * the ".." entry, and the name of the fh[2] entry.
+		 * The follow the ".." file finding the next step up.
+		 * This way we build a path to the root of
+		 * the tree. If this works, we lookup the path and so
+		 * get this inode into the cache.
+		 * Finally try the fat_iget lookup again
+		 * If that fails, then weare totally out of luck
+		 * But all that is for another day
+		 */
+	}
+	if (!inode)
+		return ERR_PTR(-ESTALE);
+
+
+	/* now to find a dentry.
+	 * If possible, get a well-connected one
+	 */
+	result = d_alloc_anon(inode);
+	if (result == NULL) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+	result->d_op = sb->s_root->d_op;
+	return result;
+}
+
+static int
+fat_encode_fh(struct dentry *de, __u32 *fh, int *lenp, int connectable)
+{
+	int len = *lenp;
+	struct inode *inode =  de->d_inode;
+	u32 ipos_h, ipos_m, ipos_l;
+
+	if (len < 5)
+		return 255; /* no room */
+
+	ipos_h = MSDOS_I(inode)->i_pos >> 8;
+	ipos_m = (MSDOS_I(inode)->i_pos & 0xf0) << 24;
+	ipos_l = (MSDOS_I(inode)->i_pos & 0x0f) << 28;
+	*lenp = 5;
+	fh[0] = inode->i_ino;
+	fh[1] = inode->i_generation;
+	fh[2] = ipos_h;
+	fh[3] = ipos_m | MSDOS_I(inode)->i_logstart;
+	spin_lock(&de->d_lock);
+	fh[4] = ipos_l | MSDOS_I(de->d_parent->d_inode)->i_logstart;
+	spin_unlock(&de->d_lock);
+	return 3;
+}
+
+static struct dentry *fat_get_parent(struct dentry *child)
+{
+	struct buffer_head *bh=NULL;
+	struct msdos_dir_entry *de = NULL;
+	struct dentry *parent = NULL;
+	int res;
+	loff_t i_pos = 0;
+	struct inode *inode;
 
-	if (!(sb->s_flags & MS_RDONLY))
-		fat_clusters_flush(sb);
+	lock_kernel();
+	res = fat_scan(child->d_inode, MSDOS_DOTDOT, &bh, &de, &i_pos);
 
-	if (sbi->nls_disk) {
-		unload_nls(sbi->nls_disk);
-		sbi->nls_disk = NULL;
-		sbi->options.codepage = fat_default_codepage;
-	}
-	if (sbi->nls_io) {
-		unload_nls(sbi->nls_io);
-		sbi->nls_io = NULL;
-	}
-	if (sbi->options.iocharset != fat_default_iocharset) {
-		kfree(sbi->options.iocharset);
-		sbi->options.iocharset = fat_default_iocharset;
+	if (res < 0)
+		goto out;
+	inode = fat_build_inode(child->d_sb, de, i_pos, &res);
+	if (res)
+		goto out;
+	if (!inode)
+		res = -EACCES;
+	else {
+		parent = d_alloc_anon(inode);
+		if (!parent) {
+			iput(inode);
+			res = -ENOMEM;
+		}
 	}
 
-	sb->s_fs_info = NULL;
-	kfree(sbi);
+ out:
+	if(bh)
+		brelse(bh);
+	unlock_kernel();
+	if (res)
+		return ERR_PTR(res);
+	else
+		return parent;
 }
 
+static struct export_operations fat_export_ops = {
+	.decode_fh	= fat_decode_fh,
+	.encode_fh	= fat_encode_fh,
+	.get_dentry	= fat_get_dentry,
+	.get_parent	= fat_get_parent,
+};
+
 static int fat_show_options(struct seq_file *m, struct vfsmount *mnt)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(mnt->mnt_sb);
@@ -516,23 +993,6 @@ static int parse_options(char *options, 
 
 	if (opts->unicode_xlate)
 		opts->utf8 = 0;
-	
-	return 0;
-}
-
-static int fat_calc_dir_size(struct inode *inode)
-{
-	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
-	int ret, fclus, dclus;
-
-	inode->i_size = 0;
-	if (MSDOS_I(inode)->i_start == 0)
-		return 0;
-
-	ret = fat_get_cluster(inode, FAT_ENT_EOF, &fclus, &dclus);
-	if (ret < 0)
-		return ret;
-	inode->i_size = (fclus + 1) << sbi->cluster_bits;
 
 	return 0;
 }
@@ -560,245 +1020,21 @@ static int fat_read_root(struct inode *i
 		MSDOS_I(inode)->i_start = 0;
 		inode->i_size = sbi->dir_entries * sizeof(struct msdos_dir_entry);
 	}
-	inode->i_blksize = sbi->cluster_size;
-	inode->i_blocks = ((inode->i_size + (sbi->cluster_size - 1))
-			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
-	MSDOS_I(inode)->i_logstart = 0;
-	MSDOS_I(inode)->mmu_private = inode->i_size;
-
-	MSDOS_I(inode)->i_attrs = 0;
-	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec = 0;
-	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec = 0;
-	MSDOS_I(inode)->i_ctime_ms = 0;
-	inode->i_nlink = fat_subdirs(inode)+2;
-
-	return 0;
-}
-
-/*
- * a FAT file handle with fhtype 3 is
- *  0/  i_ino - for fast, reliable lookup if still in the cache
- *  1/  i_generation - to see if i_ino is still valid
- *          bit 0 == 0 iff directory
- *  2/  i_pos(8-39) - if ino has changed, but still in cache
- *  3/  i_pos(4-7)|i_logstart - to semi-verify inode found at i_pos
- *  4/  i_pos(0-3)|parent->i_logstart - maybe used to hunt for the file on disc
- *
- * Hack for NFSv2: Maximum FAT entry number is 28bits and maximum
- * i_pos is 40bits (blocknr(32) + dir offset(8)), so two 4bits
- * of i_logstart is used to store the directory entry offset.
- */
-
-static struct dentry *
-fat_decode_fh(struct super_block *sb, __u32 *fh, int len, int fhtype, 
-	      int (*acceptable)(void *context, struct dentry *de),
-	      void *context)
-{
-	if (fhtype != 3)
-		return ERR_PTR(-ESTALE);
-	if (len < 5)
-		return ERR_PTR(-ESTALE);
-
-	return sb->s_export_op->find_exported_dentry(sb, fh, NULL, acceptable, context);
-}
-
-static struct dentry *fat_get_dentry(struct super_block *sb, void *inump)
-{
-	struct inode *inode = NULL;
-	struct dentry *result;
-	__u32 *fh = inump;
-
-	inode = iget(sb, fh[0]);
-	if (!inode || is_bad_inode(inode) || inode->i_generation != fh[1]) {
-		if (inode)
-			iput(inode);
-		inode = NULL;
-	}
-	if (!inode) {
-		loff_t i_pos;
-		int i_logstart = fh[3] & 0x0fffffff;
-
-		i_pos = (loff_t)fh[2] << 8;
-		i_pos |= ((fh[3] >> 24) & 0xf0) | (fh[4] >> 28);
-
-		/* try 2 - see if i_pos is in F-d-c
-		 * require i_logstart to be the same
-		 * Will fail if you truncate and then re-write
-		 */
-
-		inode = fat_iget(sb, i_pos);
-		if (inode && MSDOS_I(inode)->i_logstart != i_logstart) {
-			iput(inode);
-			inode = NULL;
-		}
-	}
-	if (!inode) {
-		/* For now, do nothing
-		 * What we could do is:
-		 * follow the file starting at fh[4], and record
-		 * the ".." entry, and the name of the fh[2] entry.
-		 * The follow the ".." file finding the next step up.
-		 * This way we build a path to the root of
-		 * the tree. If this works, we lookup the path and so
-		 * get this inode into the cache.
-		 * Finally try the fat_iget lookup again
-		 * If that fails, then weare totally out of luck
-		 * But all that is for another day
-		 */
-	}
-	if (!inode)
-		return ERR_PTR(-ESTALE);
-
-	
-	/* now to find a dentry.
-	 * If possible, get a well-connected one
-	 */
-	result = d_alloc_anon(inode);
-	if (result == NULL) {
-		iput(inode);
-		return ERR_PTR(-ENOMEM);
-	}
-	result->d_op = sb->s_root->d_op;
-	return result;
-}
-
-static int
-fat_encode_fh(struct dentry *de, __u32 *fh, int *lenp, int connectable)
-{
-	int len = *lenp;
-	struct inode *inode =  de->d_inode;
-	u32 ipos_h, ipos_m, ipos_l;
-	
-	if (len < 5)
-		return 255; /* no room */
-
-	ipos_h = MSDOS_I(inode)->i_pos >> 8;
-	ipos_m = (MSDOS_I(inode)->i_pos & 0xf0) << 24;
-	ipos_l = (MSDOS_I(inode)->i_pos & 0x0f) << 28;
-	*lenp = 5;
-	fh[0] = inode->i_ino;
-	fh[1] = inode->i_generation;
-	fh[2] = ipos_h;
-	fh[3] = ipos_m | MSDOS_I(inode)->i_logstart;
-	spin_lock(&de->d_lock);
-	fh[4] = ipos_l | MSDOS_I(de->d_parent->d_inode)->i_logstart;
-	spin_unlock(&de->d_lock);
-	return 3;
-}
-
-static struct dentry *fat_get_parent(struct dentry *child)
-{
-	struct buffer_head *bh=NULL;
-	struct msdos_dir_entry *de = NULL;
-	struct dentry *parent = NULL;
-	int res;
-	loff_t i_pos = 0;
-	struct inode *inode;
-
-	lock_kernel();
-	res = fat_scan(child->d_inode, MSDOS_DOTDOT, &bh, &de, &i_pos);
-
-	if (res < 0)
-		goto out;
-	inode = fat_build_inode(child->d_sb, de, i_pos, &res);
-	if (res)
-		goto out;
-	if (!inode)
-		res = -EACCES;
-	else {
-		parent = d_alloc_anon(inode);
-		if (!parent) {
-			iput(inode);
-			res = -ENOMEM;
-		}
-	}
-
- out:
-	if(bh)
-		brelse(bh);
-	unlock_kernel();
-	if (res)
-		return ERR_PTR(res);
-	else
-		return parent;
-}
-
-static kmem_cache_t *fat_inode_cachep;
-
-static struct inode *fat_alloc_inode(struct super_block *sb)
-{
-	struct msdos_inode_info *ei;
-	ei = (struct msdos_inode_info *)kmem_cache_alloc(fat_inode_cachep, SLAB_KERNEL);
-	if (!ei)
-		return NULL;
-	return &ei->vfs_inode;
-}
-
-static void fat_destroy_inode(struct inode *inode)
-{
-	kmem_cache_free(fat_inode_cachep, MSDOS_I(inode));
-}
-
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
-{
-	struct msdos_inode_info *ei = (struct msdos_inode_info *) foo;
-
-	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
-	    SLAB_CTOR_CONSTRUCTOR) {
-		spin_lock_init(&ei->cache_lru_lock);
-		ei->nr_caches = 0;
-		ei->cache_valid_id = FAT_CACHE_VALID + 1;
-		INIT_LIST_HEAD(&ei->cache_lru);
-		INIT_HLIST_NODE(&ei->i_fat_hash);
-		inode_init_once(&ei->vfs_inode);
-	}
-}
- 
-int __init fat_init_inodecache(void)
-{
-	fat_inode_cachep = kmem_cache_create("fat_inode_cache",
-					     sizeof(struct msdos_inode_info),
-					     0, SLAB_RECLAIM_ACCOUNT,
-					     init_once, NULL);
-	if (fat_inode_cachep == NULL)
-		return -ENOMEM;
-	return 0;
-}
+	inode->i_blksize = sbi->cluster_size;
+	inode->i_blocks = ((inode->i_size + (sbi->cluster_size - 1))
+			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
+	MSDOS_I(inode)->i_logstart = 0;
+	MSDOS_I(inode)->mmu_private = inode->i_size;
 
-void __exit fat_destroy_inodecache(void)
-{
-	if (kmem_cache_destroy(fat_inode_cachep))
-		printk(KERN_INFO "fat_inode_cache: not all structures were freed\n");
-}
+	MSDOS_I(inode)->i_attrs = 0;
+	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec = 0;
+	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = inode->i_ctime.tv_nsec = 0;
+	MSDOS_I(inode)->i_ctime_ms = 0;
+	inode->i_nlink = fat_subdirs(inode)+2;
 
-static int fat_remount(struct super_block *sb, int *flags, char *data)
-{
-	*flags |= MS_NODIRATIME;
 	return 0;
 }
 
-static struct super_operations fat_sops = { 
-	.alloc_inode	= fat_alloc_inode,
-	.destroy_inode	= fat_destroy_inode,
-	.write_inode	= fat_write_inode,
-	.delete_inode	= fat_delete_inode,
-	.put_super	= fat_put_super,
-	.statfs		= fat_statfs,
-	.clear_inode	= fat_clear_inode,
-	.remount_fs	= fat_remount,
-
-	.read_inode	= make_bad_inode,
-
-	.show_options	= fat_show_options,
-};
-
-static struct export_operations fat_export_ops = {
-	.decode_fh	= fat_decode_fh,
-	.encode_fh	= fat_encode_fh,
-	.get_dentry	= fat_get_dentry,
-	.get_parent	= fat_get_parent,
-};
-
 /*
  * Read the super block of an MS-DOS FS.
  */
@@ -937,7 +1173,7 @@ int fat_fill_super(struct super_block *s
 		sbi->root_cluster = le32_to_cpu(b->root_cluster);
 
 		sb->s_maxbytes = 0xffffffff;
-		
+
 		/* MC - if info_sector is 0, don't multiply by 0 */
 		sbi->fsinfo_sector = le16_to_cpu(b->info_sector);
 		if (sbi->fsinfo_sector == 0)
@@ -1079,259 +1315,6 @@ out_fail:
 
 EXPORT_SYMBOL(fat_fill_super);
 
-static int fat_statfs(struct super_block *sb, struct kstatfs *buf)
-{
-	int free, nr, ret;
-       
-	if (MSDOS_SB(sb)->free_clusters != -1)
-		free = MSDOS_SB(sb)->free_clusters;
-	else {
-		lock_fat(sb);
-		if (MSDOS_SB(sb)->free_clusters != -1)
-			free = MSDOS_SB(sb)->free_clusters;
-		else {
-			free = 0;
-			for (nr = 2; nr < MSDOS_SB(sb)->clusters + 2; nr++) {
-				ret = fat_access(sb, nr, -1);
-				if (ret < 0) {
-					unlock_fat(sb);
-					return ret;
-				} else if (ret == FAT_ENT_FREE)
-					free++;
-			}
-			MSDOS_SB(sb)->free_clusters = free;
-		}
-		unlock_fat(sb);
-	}
-
-	buf->f_type = sb->s_magic;
-	buf->f_bsize = MSDOS_SB(sb)->cluster_size;
-	buf->f_blocks = MSDOS_SB(sb)->clusters;
-	buf->f_bfree = free;
-	buf->f_bavail = free;
-	buf->f_namelen = MSDOS_SB(sb)->options.isvfat ? 260 : 12;
-
-	return 0;
-}
-
-static int is_exec(unsigned char *extension)
-{
-	unsigned char *exe_extensions = "EXECOMBAT", *walk;
-
-	for (walk = exe_extensions; *walk; walk += 3)
-		if (!strncmp(extension, walk, 3))
-			return 1;
-	return 0;
-}
-
-static int fat_writepage(struct page *page, struct writeback_control *wbc)
-{
-	return block_write_full_page(page,fat_get_block, wbc);
-}
-static int fat_readpage(struct file *file, struct page *page)
-{
-	return block_read_full_page(page,fat_get_block);
-}
-
-static int
-fat_prepare_write(struct file *file, struct page *page,
-			unsigned from, unsigned to)
-{
-	return cont_prepare_write(page,from,to,fat_get_block,
-		&MSDOS_I(page->mapping->host)->mmu_private);
-}
-
-static sector_t _fat_bmap(struct address_space *mapping, sector_t block)
-{
-	return generic_block_bmap(mapping,block,fat_get_block);
-}
-
-static struct address_space_operations fat_aops = {
-	.readpage	= fat_readpage,
-	.writepage	= fat_writepage,
-	.sync_page	= block_sync_page,
-	.prepare_write	= fat_prepare_write,
-	.commit_write	= generic_commit_write,
-	.bmap		= _fat_bmap
-};
-
-/* doesn't deal with root inode */
-static int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
-{
-	struct super_block *sb = inode->i_sb;
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	int error;
-
-	MSDOS_I(inode)->i_pos = 0;
-	inode->i_uid = sbi->options.fs_uid;
-	inode->i_gid = sbi->options.fs_gid;
-	inode->i_version++;
-	inode->i_generation = get_seconds();
-	
-	if ((de->attr & ATTR_DIR) && !IS_FREE(de->name)) {
-		inode->i_generation &= ~1;
-		inode->i_mode = MSDOS_MKMODE(de->attr,
-			S_IRWXUGO & ~sbi->options.fs_dmask) | S_IFDIR;
-		inode->i_op = sbi->dir_ops;
-		inode->i_fop = &fat_dir_operations;
-
-		MSDOS_I(inode)->i_start = le16_to_cpu(de->start);
-		if (sbi->fat_bits == 32)
-			MSDOS_I(inode)->i_start |= (le16_to_cpu(de->starthi) << 16);
-
-		MSDOS_I(inode)->i_logstart = MSDOS_I(inode)->i_start;
-		error = fat_calc_dir_size(inode);
-		if (error < 0)
-			return error;
-		MSDOS_I(inode)->mmu_private = inode->i_size;
-
-		inode->i_nlink = fat_subdirs(inode);
-	} else { /* not a directory */
-		inode->i_generation |= 1;
-		inode->i_mode = MSDOS_MKMODE(de->attr,
-		    ((sbi->options.showexec &&
-		       !is_exec(de->ext))
-		    	? S_IRUGO|S_IWUGO : S_IRWXUGO)
-		    & ~sbi->options.fs_fmask) | S_IFREG;
-		MSDOS_I(inode)->i_start = le16_to_cpu(de->start);
-		if (sbi->fat_bits == 32)
-			MSDOS_I(inode)->i_start |= (le16_to_cpu(de->starthi) << 16);
-
-		MSDOS_I(inode)->i_logstart = MSDOS_I(inode)->i_start;
-		inode->i_size = le32_to_cpu(de->size);
-	        inode->i_op = &fat_file_inode_operations;
-	        inode->i_fop = &fat_file_operations;
-		inode->i_mapping->a_ops = &fat_aops;
-		MSDOS_I(inode)->mmu_private = inode->i_size;
-	}
-	if(de->attr & ATTR_SYS)
-		if (sbi->options.sys_immutable)
-			inode->i_flags |= S_IMMUTABLE;
-	MSDOS_I(inode)->i_attrs = de->attr & ATTR_UNUSED;
-	/* this is as close to the truth as we can get ... */
-	inode->i_blksize = sbi->cluster_size;
-	inode->i_blocks = ((inode->i_size + (sbi->cluster_size - 1))
-			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
-	inode->i_mtime.tv_sec = inode->i_atime.tv_sec =
-		date_dos2unix(le16_to_cpu(de->time), le16_to_cpu(de->date));
-	inode->i_mtime.tv_nsec = inode->i_atime.tv_nsec = 0;
-	inode->i_ctime.tv_sec =
-		MSDOS_SB(sb)->options.isvfat
-		? date_dos2unix(le16_to_cpu(de->ctime), le16_to_cpu(de->cdate))
-		: inode->i_mtime.tv_sec;
-	inode->i_ctime.tv_nsec = de->ctime_ms * 1000000;
-	MSDOS_I(inode)->i_ctime_ms = de->ctime_ms;
-
-	return 0;
-}
-
-static int fat_write_inode(struct inode *inode, int wait)
-{
-	struct super_block *sb = inode->i_sb;
-	struct msdos_sb_info *sbi = MSDOS_SB(sb);
-	struct buffer_head *bh;
-	struct msdos_dir_entry *raw_entry;
-	loff_t i_pos;
-
-retry:
-	i_pos = MSDOS_I(inode)->i_pos;
-	if (inode->i_ino == MSDOS_ROOT_INO || !i_pos) {
-		return 0;
-	}
-	lock_kernel();
-	if (!(bh = sb_bread(sb, i_pos >> sbi->dir_per_block_bits))) {
-		printk(KERN_ERR "FAT: unable to read inode block "
-		       "for updating (i_pos %lld)\n", i_pos);
-		unlock_kernel();
-		return -EIO;
-	}
-	spin_lock(&sbi->inode_hash_lock);
-	if (i_pos != MSDOS_I(inode)->i_pos) {
-		spin_unlock(&sbi->inode_hash_lock);
-		brelse(bh);
-		unlock_kernel();
-		goto retry;
-	}
-
-	raw_entry = &((struct msdos_dir_entry *) (bh->b_data))
-	    [i_pos & (sbi->dir_per_block - 1)];
-	if (S_ISDIR(inode->i_mode)) {
-		raw_entry->attr = ATTR_DIR;
-		raw_entry->size = 0;
-	}
-	else {
-		raw_entry->attr = ATTR_NONE;
-		raw_entry->size = cpu_to_le32(inode->i_size);
-	}
-	raw_entry->attr |= MSDOS_MKATTR(inode->i_mode) |
-	    MSDOS_I(inode)->i_attrs;
-	raw_entry->start = cpu_to_le16(MSDOS_I(inode)->i_logstart);
-	raw_entry->starthi = cpu_to_le16(MSDOS_I(inode)->i_logstart >> 16);
-	fat_date_unix2dos(inode->i_mtime.tv_sec, &raw_entry->time, &raw_entry->date);
-	if (sbi->options.isvfat) {
-		fat_date_unix2dos(inode->i_ctime.tv_sec,&raw_entry->ctime,&raw_entry->cdate);
-		raw_entry->ctime_ms = MSDOS_I(inode)->i_ctime_ms; /* use i_ctime.tv_nsec? */
-	}
-	spin_unlock(&sbi->inode_hash_lock);
-	mark_buffer_dirty(bh);
-	brelse(bh);
-	unlock_kernel();
-	return 0;
-}
-
-
-int fat_notify_change(struct dentry * dentry, struct iattr * attr)
-{
-	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
-	struct inode *inode = dentry->d_inode;
-	int mask, error = 0;
-
-	lock_kernel();
-
-	/* FAT cannot truncate to a longer file */
-	if (attr->ia_valid & ATTR_SIZE) {
-		if (attr->ia_size > inode->i_size) {
-			error = -EPERM;
-			goto out;
-		}
-	}
-
-	error = inode_change_ok(inode, attr);
-	if (error) {
-		if (sbi->options.quiet)
-			error = 0;
- 		goto out;
-	}
-
-	if (((attr->ia_valid & ATTR_UID) && 
-	     (attr->ia_uid != sbi->options.fs_uid)) ||
-	    ((attr->ia_valid & ATTR_GID) && 
-	     (attr->ia_gid != sbi->options.fs_gid)) ||
-	    ((attr->ia_valid & ATTR_MODE) &&
-	     (attr->ia_mode & ~MSDOS_VALID_MODE)))
-		error = -EPERM;
-
-	if (error) {
-		if (sbi->options.quiet)  
-			error = 0;
-		goto out;
-	}
-	error = inode_setattr(inode, attr);
-	if (error)
-		goto out;
-
-	if (S_ISDIR(inode->i_mode))
-		mask = sbi->options.fs_dmask;
-	else
-		mask = sbi->options.fs_fmask;
-	inode->i_mode &= S_IFMT | (S_IRWXUGO & ~mask);
-out:
-	unlock_kernel();
-	return error;
-}
-
-EXPORT_SYMBOL(fat_notify_change);
-
 int __init fat_cache_init(void);
 void __exit fat_cache_destroy(void);
 
diff -puN fs/fat/misc.c~fat_cleanup fs/fat/misc.c
--- linux-2.6.10/fs/fat/misc.c~fat_cleanup	2005-01-10 01:57:57.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/fat/misc.c	2005-01-10 05:07:47.000000000 +0900
@@ -88,8 +88,8 @@ int fat_add_cluster(struct inode *inode)
 	struct super_block *sb = inode->i_sb;
 	int ret, count, limit, new_dclus, new_fclus, last;
 	int cluster_bits = MSDOS_SB(sb)->cluster_bits;
-	
-	/* 
+
+	/*
 	 * We must locate the last cluster of the file to add this new
 	 * one (new_dclus) to the end of the link list (the FAT).
 	 *
@@ -109,7 +109,7 @@ int fat_add_cluster(struct inode *inode)
 
 	/* find free FAT entry */
 	lock_fat(sb);
-	
+
 	if (MSDOS_SB(sb)->free_clusters == 0) {
 		unlock_fat(sb);
 		return -ENOSPC;
@@ -145,7 +145,7 @@ int fat_add_cluster(struct inode *inode)
 	if (MSDOS_SB(sb)->free_clusters != -1)
 		MSDOS_SB(sb)->free_clusters--;
 	fat_clusters_flush(sb);
-	
+
 	unlock_fat(sb);
 
 	/* add new one to the last of the cluster chain */
@@ -169,65 +169,23 @@ int fat_add_cluster(struct inode *inode)
 	return new_dclus;
 }
 
-struct buffer_head *fat_extend_dir(struct inode *inode)
-{
-	struct super_block *sb = inode->i_sb;
-	struct buffer_head *bh, *res = NULL;
-	int nr, sec_per_clus = MSDOS_SB(sb)->sec_per_clus;
-	sector_t sector, last_sector;
-
-	if (MSDOS_SB(sb)->fat_bits != 32) {
-		if (inode->i_ino == MSDOS_ROOT_INO)
-			return ERR_PTR(-ENOSPC);
-	}
-
-	nr = fat_add_cluster(inode);
-	if (nr < 0)
-		return ERR_PTR(nr);
-	
-	sector = ((sector_t)nr - 2) * sec_per_clus + MSDOS_SB(sb)->data_start;
-	last_sector = sector + sec_per_clus;
-	for ( ; sector < last_sector; sector++) {
-		if ((bh = sb_getblk(sb, sector))) {
-			memset(bh->b_data, 0, sb->s_blocksize);
-			set_buffer_uptodate(bh);
-			mark_buffer_dirty(bh);
-			if (!res)
-				res = bh;
-			else
-				brelse(bh);
-		}
-	}
-	if (res == NULL)
-		res = ERR_PTR(-EIO);
-	if (inode->i_size & (sb->s_blocksize - 1)) {
-		fat_fs_panic(sb, "Odd directory size");
-		inode->i_size = (inode->i_size + sb->s_blocksize)
-			& ~((loff_t)sb->s_blocksize - 1);
-	}
-	inode->i_size += MSDOS_SB(sb)->cluster_size;
-	MSDOS_I(inode)->mmu_private += MSDOS_SB(sb)->cluster_size;
-
-	return res;
-}
-
-/* Linear day numbers of the respective 1sts in non-leap years. */
-
-static int day_n[] = { 0,31,59,90,120,151,181,212,243,273,304,334,0,0,0,0 };
-		  /* JanFebMarApr May Jun Jul Aug Sep Oct Nov Dec */
-
-
 extern struct timezone sys_tz;
 
+/* Linear day numbers of the respective 1sts in non-leap years. */
+static int day_n[] = {
+   /* Jan  Feb  Mar  Apr   May  Jun  Jul  Aug  Sep  Oct  Nov  Dec */
+	0,  31,  59,  90,  120, 151, 181, 212, 243, 273, 304, 334, 0, 0, 0, 0
+};
 
 /* Convert a MS-DOS time/date pair to a UNIX date (seconds since 1 1 70). */
-
-int date_dos2unix(unsigned short time,unsigned short date)
+int date_dos2unix(unsigned short time, unsigned short date)
 {
-	int month,year,secs;
+	int month, year, secs;
 
-	/* first subtract and mask after that... Otherwise, if
-	   date == 0, bad things happen */
+	/*
+	 * first subtract and mask after that... Otherwise, if
+	 * date == 0, bad things happen
+	 */
 	month = ((date >> 5) - 1) & 15;
 	year = date >> 9;
 	secs = (time & 31)*2+60*((time >> 5) & 63)+(time >> 11)*3600+86400*
@@ -238,12 +196,10 @@ int date_dos2unix(unsigned short time,un
 	return secs;
 }
 
-
 /* Convert linear UNIX date to a MS-DOS time/date pair. */
-
-void fat_date_unix2dos(int unix_date,__le16 *time, __le16 *date)
+void fat_date_unix2dos(int unix_date, __le16 *time, __le16 *date)
 {
-	int day,year,nl_day,month;
+	int day, year, nl_day, month;
 
 	unix_date -= sys_tz.tz_minuteswest*60;
 
@@ -255,16 +211,18 @@ void fat_date_unix2dos(int unix_date,__l
 	    (((unix_date/3600) % 24) << 11));
 	day = unix_date/86400-3652;
 	year = day/365;
-	if ((year+3)/4+365*year > day) year--;
+	if ((year+3)/4+365*year > day)
+		year--;
 	day -= (year+3)/4+365*year;
 	if (day == 59 && !(year & 3)) {
 		nl_day = day;
 		month = 2;
-	}
-	else {
+	} else {
 		nl_day = (year & 3) || day <= 59 ? day : day-1;
-		for (month = 0; month < 12; month++)
-			if (day_n[month] > nl_day) break;
+		for (month = 0; month < 12; month++) {
+			if (day_n[month] > nl_day)
+				break;
+		}
 	}
 	*date = cpu_to_le16(nl_day-day_n[month-1]+1+(month << 5)+(year << 9));
 }
@@ -279,10 +237,10 @@ EXPORT_SYMBOL(fat_date_unix2dos);
    AV. want the next entry (took one explicit de=NULL in vfat/namei.c).
    AV. It's done in fat_get_entry() (inlined), here the slow case lives.
    AV. Additionally, when we return -1 (i.e. reached the end of directory)
-   AV. we make bh NULL. 
+   AV. we make bh NULL.
  */
 
-int fat__get_entry(struct inode *dir, loff_t *pos,struct buffer_head **bh,
+int fat__get_entry(struct inode *dir, loff_t *pos, struct buffer_head **bh,
 		   struct msdos_dir_entry **de, loff_t *i_pos)
 {
 	struct super_block *sb = dir->i_sb;
diff -puN include/linux/msdos_fs.h~fat_cleanup include/linux/msdos_fs.h
--- linux-2.6.10/include/linux/msdos_fs.h~fat_cleanup	2005-01-10 01:57:57.000000000 +0900
+++ linux-2.6.10-hirofumi/include/linux/msdos_fs.h	2005-01-10 05:10:38.000000000 +0900
@@ -12,6 +12,10 @@
 #define MSDOS_DPB_BITS	4		/* log2(MSDOS_DPB) */
 #define MSDOS_DPS	(SECTOR_SIZE / sizeof(struct msdos_dir_entry))
 #define MSDOS_DPS_BITS	4		/* log2(MSDOS_DPS) */
+#define CF_LE_W(v)	le16_to_cpu(v)
+#define CF_LE_L(v)	le32_to_cpu(v)
+#define CT_LE_W(v)	cpu_to_le16(v)
+#define CT_LE_L(v)	cpu_to_le32(v)
 
 
 #define MSDOS_SUPER_MAGIC 0x4d44 /* MD */
@@ -23,37 +27,37 @@
 #define FAT_MAX_DIR_ENTRIES	(65536)
 #define FAT_MAX_DIR_SIZE	(FAT_MAX_DIR_ENTRIES << MSDOS_DIR_BITS)
 
-#define ATTR_NONE    0 /* no attribute bits */
-#define ATTR_RO      1  /* read-only */
-#define ATTR_HIDDEN  2  /* hidden */
-#define ATTR_SYS     4  /* system */
-#define ATTR_VOLUME  8  /* volume label */
-#define ATTR_DIR     16 /* directory */
-#define ATTR_ARCH    32 /* archived */
+#define ATTR_NONE	0	/* no attribute bits */
+#define ATTR_RO		1	/* read-only */
+#define ATTR_HIDDEN	2	/* hidden */
+#define ATTR_SYS	4	/* system */
+#define ATTR_VOLUME	8	/* volume label */
+#define ATTR_DIR	16	/* directory */
+#define ATTR_ARCH	32	/* archived */
 
 /* attribute bits that are copied "as is" */
-#define ATTR_UNUSED  (ATTR_VOLUME | ATTR_ARCH | ATTR_SYS | ATTR_HIDDEN)
+#define ATTR_UNUSED	(ATTR_VOLUME | ATTR_ARCH | ATTR_SYS | ATTR_HIDDEN)
 /* bits that are used by the Windows 95/Windows NT extended FAT */
-#define ATTR_EXT     (ATTR_RO | ATTR_HIDDEN | ATTR_SYS | ATTR_VOLUME)
+#define ATTR_EXT	(ATTR_RO | ATTR_HIDDEN | ATTR_SYS | ATTR_VOLUME)
 
-#define CASE_LOWER_BASE 8	/* base is lower case */
-#define CASE_LOWER_EXT  16	/* extension is lower case */
+#define CASE_LOWER_BASE	8	/* base is lower case */
+#define CASE_LOWER_EXT	16	/* extension is lower case */
 
-#define DELETED_FLAG 0xe5 /* marks file as deleted when in name[0] */
-#define IS_FREE(n) (!*(n) || *(n) == DELETED_FLAG)
+#define DELETED_FLAG	0xe5	/* marks file as deleted when in name[0] */
+#define IS_FREE(n)	(!*(n) || *(n) == DELETED_FLAG)
 
 /* valid file mode bits */
 #define MSDOS_VALID_MODE (S_IFREG | S_IFDIR | S_IRWXU | S_IRWXG | S_IRWXO)
 /* Convert attribute bits and a mask to the UNIX mode. */
 #define MSDOS_MKMODE(a, m) (m & (a & ATTR_RO ? S_IRUGO|S_IXUGO : S_IRWXUGO))
 /* Convert the UNIX mode to MS-DOS attribute bits. */
-#define MSDOS_MKATTR(m) ((m & S_IWUGO) ? ATTR_NONE : ATTR_RO)
+#define MSDOS_MKATTR(m)	((m & S_IWUGO) ? ATTR_NONE : ATTR_RO)
 
-#define MSDOS_NAME 11 /* maximum name length */
-#define MSDOS_LONGNAME 256 /* maximum name length */
-#define MSDOS_SLOTS 21  /* max # of slots needed for short and long names */
-#define MSDOS_DOT    ".          " /* ".", padded to MSDOS_NAME chars */
-#define MSDOS_DOTDOT "..         " /* "..", padded to MSDOS_NAME chars */
+#define MSDOS_NAME	11	/* maximum name length */
+#define MSDOS_LONGNAME	256	/* maximum name length */
+#define MSDOS_SLOTS	21	/* max # of slots for short and long names */
+#define MSDOS_DOT	".          "	/* ".", padded to MSDOS_NAME chars */
+#define MSDOS_DOTDOT	"..         "	/* "..", padded to MSDOS_NAME chars */
 
 /* media of boot sector */
 #define FAT_VALID_MEDIA(x)	((0xF8 <= (x) && (x) <= 0xFF) || (x) == 0xF0)
@@ -61,24 +65,24 @@
 	MSDOS_SB(s)->fat_bits == 16 ? 0xFF00 : 0xF00) | (x))
 
 /* maximum number of clusters */
-#define MAX_FAT12 0xFF4
-#define MAX_FAT16 0xFFF4
-#define MAX_FAT32 0x0FFFFFF6
-#define MAX_FAT(s) (MSDOS_SB(s)->fat_bits == 32 ? MAX_FAT32 : \
+#define MAX_FAT12	0xFF4
+#define MAX_FAT16	0xFFF4
+#define MAX_FAT32	0x0FFFFFF6
+#define MAX_FAT(s)	(MSDOS_SB(s)->fat_bits == 32 ? MAX_FAT32 : \
 	MSDOS_SB(s)->fat_bits == 16 ? MAX_FAT16 : MAX_FAT12)
 
 /* bad cluster mark */
-#define BAD_FAT12 0xFF7
-#define BAD_FAT16 0xFFF7
-#define BAD_FAT32 0x0FFFFFF7
-#define BAD_FAT(s) (MSDOS_SB(s)->fat_bits == 32 ? BAD_FAT32 : \
+#define BAD_FAT12	0xFF7
+#define BAD_FAT16	0xFFF7
+#define BAD_FAT32	0x0FFFFFF7
+#define BAD_FAT(s)	(MSDOS_SB(s)->fat_bits == 32 ? BAD_FAT32 : \
 	MSDOS_SB(s)->fat_bits == 16 ? BAD_FAT16 : BAD_FAT12)
 
 /* standard EOF */
-#define EOF_FAT12 0xFFF
-#define EOF_FAT16 0xFFFF
-#define EOF_FAT32 0x0FFFFFFF
-#define EOF_FAT(s) (MSDOS_SB(s)->fat_bits == 32 ? EOF_FAT32 : \
+#define EOF_FAT12	0xFFF
+#define EOF_FAT16	0xFFFF
+#define EOF_FAT32	0x0FFFFFFF
+#define EOF_FAT(s)	(MSDOS_SB(s)->fat_bits == 32 ? EOF_FAT32 : \
 	MSDOS_SB(s)->fat_bits == 16 ? EOF_FAT16 : EOF_FAT12)
 
 #define FAT_ENT_FREE	(0)
@@ -96,7 +100,7 @@
 #define	VFAT_IOCTL_READDIR_BOTH		_IOR('r', 1, struct dirent [2])
 #define	VFAT_IOCTL_READDIR_SHORT	_IOR('r', 2, struct dirent [2])
 
-/* 
+/*
  * vfat shortname flags
  */
 #define VFAT_SFN_DISPLAY_LOWER	0x0001 /* convert to lowercase for display */
@@ -105,18 +109,6 @@
 #define VFAT_SFN_CREATE_WIN95	0x0100 /* emulate win95 rule for create */
 #define VFAT_SFN_CREATE_WINNT	0x0200 /* emulate winnt rule for create */
 
-/*
- * Conversion from and to little-endian byte order. (no-op on i386/i486)
- *
- * Naming: Ca_b_c, where a: F = from, T = to, b: LE = little-endian,
- * BE = big-endian, c: W = word (16 bits), L = longword (32 bits)
- */
-
-#define CF_LE_W(v) le16_to_cpu(v)
-#define CF_LE_L(v) le32_to_cpu(v)
-#define CT_LE_W(v) cpu_to_le16(v)
-#define CT_LE_L(v) cpu_to_le32(v)
-
 struct fat_boot_sector {
 	__u8	ignored[3];	/* Boot strap short or near jump */
 	__u8	system_id[8];	/* Name - can be used to special case
@@ -161,7 +153,7 @@ struct msdos_dir_entry {
 	__le16	ctime;		/* Creation time */
 	__le16	cdate;		/* Creation date */
 	__le16	adate;		/* Last access date */
-	__le16   starthi;	/* High 16 bits of cluster in FAT32 */
+	__le16	starthi;	/* High 16 bits of cluster in FAT32 */
 	__le16	time,date,start;/* time, date and first cluster */
 	__le32	size;		/* file size (in bytes) */
 };
@@ -179,9 +171,9 @@ struct msdos_dir_slot {
 };
 
 struct vfat_slot_info {
-	int long_slots;		       /* number of long slots in filename */
-	loff_t longname_offset;	       /* dir offset for longname start */
-	loff_t i_pos;		       /* on-disk position of directory entry */
+	int long_slots;		/* number of long slots in filename */
+	loff_t longname_offset;	/* dir offset for longname start */
+	loff_t i_pos;		/* on-disk position of directory entry */
 };
 
 #ifdef __KERNEL__
@@ -259,11 +251,11 @@ struct msdos_inode_info {
 	unsigned int cache_valid_id;
 
 	loff_t mmu_private;
-	int i_start;	/* first cluster or 0 */
-	int i_logstart;	/* logical first cluster */
-	int i_attrs;	/* unused attribute bits */
-	int i_ctime_ms;	/* unused change time in milliseconds */
-	loff_t i_pos;	/* on-disk position of directory entry or 0 */
+	int i_start;		/* first cluster or 0 */
+	int i_logstart;		/* logical first cluster */
+	int i_attrs;		/* unused attribute bits */
+	int i_ctime_ms;		/* unused change time in milliseconds */
+	loff_t i_pos;		/* on-disk position of directory entry or 0 */
 	struct hlist_node i_fat_hash;	/* hash by i_location */
 	struct inode vfs_inode;
 };
@@ -305,20 +297,20 @@ static inline void fatwchar_to16(__u8 *d
 }
 
 /* fat/cache.c */
-extern int fat_access(struct super_block *sb, int nr, int new_value);
-extern int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys);
 extern void fat_cache_inval_inode(struct inode *inode);
+extern int fat_access(struct super_block *sb, int nr, int new_value);
 extern int fat_get_cluster(struct inode *inode, int cluster,
 			   int *fclus, int *dclus);
-extern int fat_free(struct inode *inode, int skip);
+extern int fat_bmap(struct inode *inode, sector_t sector, sector_t *phys);
 
 /* fat/dir.c */
 extern struct file_operations fat_dir_operations;
 extern int fat_search_long(struct inode *inode, const unsigned char *name,
 			   int name_len, int anycase,
 			   loff_t *spos, loff_t *lpos);
-extern int fat_add_entries(struct inode *dir, int slots, struct buffer_head **bh,
-			struct msdos_dir_entry **de, loff_t *i_pos);
+extern int fat_add_entries(struct inode *dir, int slots,
+			   struct buffer_head **bh,
+			   struct msdos_dir_entry **de, loff_t *i_pos);
 extern int fat_new_dir(struct inode *dir, struct inode *parent, int is_vfat);
 extern int fat_dir_empty(struct inode *dir);
 extern int fat_subdirs(struct inode *dir);
@@ -329,8 +321,7 @@ extern int fat_scan(struct inode *dir, c
 /* fat/file.c */
 extern struct file_operations fat_file_operations;
 extern struct inode_operations fat_file_inode_operations;
-extern int fat_get_block(struct inode *inode, sector_t iblock,
-			 struct buffer_head *bh_result, int create);
+extern int fat_notify_change(struct dentry * dentry, struct iattr * attr);
 extern void fat_truncate(struct inode *inode);
 
 /* fat/inode.c */
@@ -341,7 +332,6 @@ extern struct inode *fat_build_inode(str
 			struct msdos_dir_entry *de, loff_t i_pos, int *res);
 int fat_fill_super(struct super_block *sb, void *data, int silent,
 		   struct inode_operations *fs_dir_inode_ops, int isvfat);
-extern int fat_notify_change(struct dentry * dentry, struct iattr * attr);
 
 /* fat/misc.c */
 extern void fat_fs_panic(struct super_block *s, const char *fmt, ...);
@@ -349,7 +339,6 @@ extern void lock_fat(struct super_block 
 extern void unlock_fat(struct super_block *sb);
 extern void fat_clusters_flush(struct super_block *sb);
 extern int fat_add_cluster(struct inode *inode);
-extern struct buffer_head *fat_extend_dir(struct inode *inode);
 extern int date_dos2unix(unsigned short time, unsigned short date);
 extern void fat_date_unix2dos(int unix_date, __le16 *time, __le16 *date);
 extern int fat__get_entry(struct inode *dir, loff_t *pos,
_
