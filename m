Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293659AbSCKXBP>; Mon, 11 Mar 2002 18:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310133AbSCKXBE>; Mon, 11 Mar 2002 18:01:04 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:10674 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S293659AbSCKW7u>; Mon, 11 Mar 2002 17:59:50 -0500
Message-ID: <3C8D36D0.C43162A2@didntduck.org>
Date: Mon, 11 Mar 2002 17:59:28 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
CC: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] struct superblock cleanup - minixfs
Content-Type: multipart/mixed;
 boundary="------------F35276E6465D04DC5B835184"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F35276E6465D04DC5B835184
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

These two patches are the start of cleaning up the union of
filesystem-specific structures in struct super_block.  The goal is to
remove dependence on filesystem headers in fs.h.  The first patch
abstracts the access to the minix_sb_info structure through the function
minix_sb().  The second patch switches to using kmalloc to allocate the
structure.

Patches are against 2.5.6.

-- 

						Brian Gerst
--------------F35276E6465D04DC5B835184
Content-Type: text/plain; charset=us-ascii;
 name="sb-minix-a1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-minix-a1"

diff -urN -X scripts/dontdiff linux-2.5.6/fs/minix/bitmap.c linux/fs/minix/bitmap.c
--- linux-2.5.6/fs/minix/bitmap.c	Wed Feb  6 11:47:05 2002
+++ linux/fs/minix/bitmap.c	Thu Mar  7 09:46:20 2002
@@ -52,6 +52,7 @@
 void minix_free_block(struct inode * inode, int block)
 {
 	struct super_block * sb = inode->i_sb;
+	struct minix_sb_info * sbi = minix_sb(sb);
 	struct buffer_head * bh;
 	unsigned int bit,zone;
 
@@ -59,19 +60,19 @@
 		printk("trying to free block on nonexistent device\n");
 		return;
 	}
-	if (block < sb->u.minix_sb.s_firstdatazone ||
-	    block >= sb->u.minix_sb.s_nzones) {
+	if (block < sbi->s_firstdatazone ||
+	    block >= sbi->s_nzones) {
 		printk("trying to free block not in datazone\n");
 		return;
 	}
-	zone = block - sb->u.minix_sb.s_firstdatazone + 1;
+	zone = block - sbi->s_firstdatazone + 1;
 	bit = zone & 8191;
 	zone >>= 13;
-	if (zone >= sb->u.minix_sb.s_zmap_blocks) {
+	if (zone >= sbi->s_zmap_blocks) {
 		printk("minix_free_block: nonexistent bitmap buffer\n");
 		return;
 	}
-	bh = sb->u.minix_sb.s_zmap[zone];
+	bh = sbi->s_zmap[zone];
 	if (!minix_test_and_clear_bit(bit,bh->b_data))
 		printk("free_block (%s:%d): bit already cleared\n",
 		       sb->s_id, block);
@@ -82,6 +83,7 @@
 int minix_new_block(struct inode * inode)
 {
 	struct super_block * sb = inode->i_sb;
+	struct minix_sb_info * sbi = minix_sb(sb);
 	struct buffer_head * bh;
 	int i,j;
 
@@ -92,8 +94,8 @@
 repeat:
 	j = 8192;
 	bh = NULL;
-	for (i = 0; i < sb->u.minix_sb.s_zmap_blocks; i++) {
-		bh = sb->u.minix_sb.s_zmap[i];
+	for (i = 0; i < sbi->s_zmap_blocks; i++) {
+		bh = sbi->s_zmap[i];
 		if ((j = minix_find_first_zero_bit(bh->b_data, 8192)) < 8192)
 			break;
 	}
@@ -104,25 +106,26 @@
 		goto repeat;
 	}
 	mark_buffer_dirty(bh);
-	j += i*8192 + sb->u.minix_sb.s_firstdatazone-1;
-	if (j < sb->u.minix_sb.s_firstdatazone ||
-	    j >= sb->u.minix_sb.s_nzones)
+	j += i*8192 + sbi->s_firstdatazone-1;
+	if (j < sbi->s_firstdatazone ||
+	    j >= sbi->s_nzones)
 		return 0;
 	return j;
 }
 
 unsigned long minix_count_free_blocks(struct super_block *sb)
 {
-	return (count_free(sb->u.minix_sb.s_zmap, sb->u.minix_sb.s_zmap_blocks,
-		sb->u.minix_sb.s_nzones - sb->u.minix_sb.s_firstdatazone + 1)
-		<< sb->u.minix_sb.s_log_zone_size);
+	struct minix_sb_info *sbi = minix_sb(sb);
+	return (count_free(sbi->s_zmap, sbi->s_zmap_blocks,
+		sbi->s_nzones - sbi->s_firstdatazone + 1)
+		<< sbi->s_log_zone_size);
 }
 
 struct minix_inode *
 minix_V1_raw_inode(struct super_block *sb, ino_t ino, struct buffer_head **bh)
 {
 	int block;
-	struct minix_sb_info *sbi = &sb->u.minix_sb;
+	struct minix_sb_info *sbi = minix_sb(sb);
 	struct minix_inode *p;
 
 	if (!ino || ino > sbi->s_ninodes) {
@@ -146,7 +149,7 @@
 minix_V2_raw_inode(struct super_block *sb, ino_t ino, struct buffer_head **bh)
 {
 	int block;
-	struct minix_sb_info *sbi = &sb->u.minix_sb;
+	struct minix_sb_info *sbi = minix_sb(sb);
 	struct minix2_inode *p;
 
 	*bh = NULL;
@@ -198,17 +201,17 @@
 	struct buffer_head * bh;
 	unsigned long ino;
 
-	if (inode->i_ino < 1 || inode->i_ino > inode->i_sb->u.minix_sb.s_ninodes) {
+	if (inode->i_ino < 1 || inode->i_ino > minix_sb(inode->i_sb)->s_ninodes) {
 		printk("free_inode: inode 0 or nonexistent inode\n");
 		return;
 	}
 	ino = inode->i_ino;
-	if ((ino >> 13) >= inode->i_sb->u.minix_sb.s_imap_blocks) {
+	if ((ino >> 13) >= minix_sb(inode->i_sb)->s_imap_blocks) {
 		printk("free_inode: nonexistent imap in superblock\n");
 		return;
 	}
 
-	bh = inode->i_sb->u.minix_sb.s_imap[ino >> 13];
+	bh = minix_sb(inode->i_sb)->s_imap[ino >> 13];
 	minix_clear_inode(inode);
 	clear_inode(inode);
 	if (!minix_test_and_clear_bit(ino & 8191, bh->b_data))
@@ -233,8 +236,8 @@
 	bh = NULL;
 	*error = -ENOSPC;
 	lock_super(sb);
-	for (i = 0; i < sb->u.minix_sb.s_imap_blocks; i++) {
-		bh = inode->i_sb->u.minix_sb.s_imap[i];
+	for (i = 0; i < minix_sb(sb)->s_imap_blocks; i++) {
+		bh = minix_sb(inode->i_sb)->s_imap[i];
 		if ((j = minix_find_first_zero_bit(bh->b_data, 8192)) < 8192)
 			break;
 	}
@@ -251,7 +254,7 @@
 	}
 	mark_buffer_dirty(bh);
 	j += i*8192;
-	if (!j || j > inode->i_sb->u.minix_sb.s_ninodes) {
+	if (!j || j > minix_sb(inode->i_sb)->s_ninodes) {
 		iput(inode);
 		unlock_super(sb);
 		return NULL;
@@ -272,6 +275,6 @@
 
 unsigned long minix_count_free_inodes(struct super_block *sb)
 {
-	return count_free(sb->u.minix_sb.s_imap, sb->u.minix_sb.s_imap_blocks,
-		sb->u.minix_sb.s_ninodes + 1);
+	return count_free(minix_sb(sb)->s_imap, minix_sb(sb)->s_imap_blocks,
+		minix_sb(sb)->s_ninodes + 1);
 }
diff -urN -X scripts/dontdiff linux-2.5.6/fs/minix/dir.c linux/fs/minix/dir.c
--- linux-2.5.6/fs/minix/dir.c	Wed Feb 20 01:47:36 2002
+++ linux/fs/minix/dir.c	Thu Mar  7 09:36:53 2002
@@ -77,7 +77,7 @@
 	unsigned offset = pos & ~PAGE_CACHE_MASK;
 	unsigned long n = pos >> PAGE_CACHE_SHIFT;
 	unsigned long npages = dir_pages(inode);
-	struct minix_sb_info *sbi = &sb->u.minix_sb;
+	struct minix_sb_info *sbi = minix_sb(sb);
 	unsigned chunk_size = sbi->s_dirsize;
 
 	pos = (pos + chunk_size-1) & ~(chunk_size-1);
@@ -140,7 +140,7 @@
 	int namelen = dentry->d_name.len;
 	struct inode * dir = dentry->d_parent->d_inode;
 	struct super_block * sb = dir->i_sb;
-	struct minix_sb_info * sbi = &sb->u.minix_sb;
+	struct minix_sb_info * sbi = minix_sb(sb);
 	unsigned long n;
 	unsigned long npages = dir_pages(dir);
 	struct page *page = NULL;
@@ -178,7 +178,7 @@
 	const char * name = dentry->d_name.name;
 	int namelen = dentry->d_name.len;
 	struct super_block * sb = dir->i_sb;
-	struct minix_sb_info * sbi = &sb->u.minix_sb;
+	struct minix_sb_info * sbi = minix_sb(sb);
 	struct page *page = NULL;
 	struct minix_dir_entry * de;
 	unsigned long npages = dir_pages(dir);
@@ -236,7 +236,7 @@
 	struct inode *inode = (struct inode*)mapping->host;
 	char *kaddr = (char*)page_address(page);
 	unsigned from = (char*)de - kaddr;
-	unsigned to = from + inode->i_sb->u.minix_sb.s_dirsize;
+	unsigned to = from + minix_sb(inode->i_sb)->s_dirsize;
 	int err;
 
 	lock_page(page);
@@ -256,7 +256,7 @@
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct page *page = grab_cache_page(mapping, 0);
-	struct minix_sb_info * sbi = &inode->i_sb->u.minix_sb;
+	struct minix_sb_info * sbi = minix_sb(inode->i_sb);
 	struct minix_dir_entry * de;
 	char *base;
 	int err;
@@ -291,7 +291,7 @@
 {
 	struct page *page = NULL;
 	unsigned long i, npages = dir_pages(inode);
-	struct minix_sb_info *sbi = &inode->i_sb->u.minix_sb;
+	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
 
 	for (i = 0; i < npages; i++) {
 		char *kaddr;
@@ -334,7 +334,7 @@
 	struct inode *inode)
 {
 	struct inode *dir = (struct inode*)page->mapping->host;
-	struct minix_sb_info *sbi = &dir->i_sb->u.minix_sb;
+	struct minix_sb_info *sbi = minix_sb(dir->i_sb);
 	unsigned from = (char *)de-(char*)page_address(page);
 	unsigned to = from + sbi->s_dirsize;
 	int err;
@@ -354,7 +354,7 @@
 struct minix_dir_entry * minix_dotdot (struct inode *dir, struct page **p)
 {
 	struct page *page = dir_get_page(dir, 0);
-	struct minix_sb_info *sbi = &dir->i_sb->u.minix_sb;
+	struct minix_sb_info *sbi = minix_sb(dir->i_sb);
 	struct minix_dir_entry *de = NULL;
 
 	if (!IS_ERR(page)) {
diff -urN -X scripts/dontdiff linux-2.5.6/fs/minix/inode.c linux/fs/minix/inode.c
--- linux-2.5.6/fs/minix/inode.c	Wed Feb 20 01:47:36 2002
+++ linux/fs/minix/inode.c	Thu Mar  7 09:39:46 2002
@@ -36,7 +36,7 @@
 
 static void minix_commit_super(struct super_block * sb)
 {
-	mark_buffer_dirty(sb->u.minix_sb.s_sbh);
+	mark_buffer_dirty(minix_sb(sb)->s_sbh);
 	sb->s_dirt = 0;
 }
 
@@ -45,7 +45,7 @@
 	struct minix_super_block * ms;
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		ms = sb->u.minix_sb.s_ms;
+		ms = minix_sb(sb)->s_ms;
 
 		if (ms->s_state & MINIX_VALID_FS)
 			ms->s_state &= ~MINIX_VALID_FS;
@@ -58,17 +58,18 @@
 static void minix_put_super(struct super_block *sb)
 {
 	int i;
+	struct minix_sb_info *sbi = minix_sb(sb);
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		sb->u.minix_sb.s_ms->s_state = sb->u.minix_sb.s_mount_state;
-		mark_buffer_dirty(sb->u.minix_sb.s_sbh);
+		sbi->s_ms->s_state = sbi->s_mount_state;
+		mark_buffer_dirty(sbi->s_sbh);
 	}
-	for (i = 0; i < sb->u.minix_sb.s_imap_blocks; i++)
-		brelse(sb->u.minix_sb.s_imap[i]);
-	for (i = 0; i < sb->u.minix_sb.s_zmap_blocks; i++)
-		brelse(sb->u.minix_sb.s_zmap[i]);
-	brelse (sb->u.minix_sb.s_sbh);
-	kfree(sb->u.minix_sb.s_imap);
+	for (i = 0; i < sbi->s_imap_blocks; i++)
+		brelse(sbi->s_imap[i]);
+	for (i = 0; i < sbi->s_zmap_blocks; i++)
+		brelse(sbi->s_zmap[i]);
+	brelse (sbi->s_sbh);
+	kfree(sbi->s_imap);
 
 	return;
 }
@@ -129,32 +130,33 @@
 
 static int minix_remount (struct super_block * sb, int * flags, char * data)
 {
+	struct minix_sb_info * sbi = minix_sb(sb);
 	struct minix_super_block * ms;
 
-	ms = sb->u.minix_sb.s_ms;
+	ms = sbi->s_ms;
 	if ((*flags & MS_RDONLY) == (sb->s_flags & MS_RDONLY))
 		return 0;
 	if (*flags & MS_RDONLY) {
 		if (ms->s_state & MINIX_VALID_FS ||
-		    !(sb->u.minix_sb.s_mount_state & MINIX_VALID_FS))
+		    !(sbi->s_mount_state & MINIX_VALID_FS))
 			return 0;
 		/* Mounting a rw partition read-only. */
-		ms->s_state = sb->u.minix_sb.s_mount_state;
-		mark_buffer_dirty(sb->u.minix_sb.s_sbh);
+		ms->s_state = sbi->s_mount_state;
+		mark_buffer_dirty(sbi->s_sbh);
 		sb->s_dirt = 1;
 		minix_commit_super(sb);
 	}
 	else {
 	  	/* Mount a partition which is read-only, read-write. */
-		sb->u.minix_sb.s_mount_state = ms->s_state;
+		sbi->s_mount_state = ms->s_state;
 		ms->s_state &= ~MINIX_VALID_FS;
-		mark_buffer_dirty(sb->u.minix_sb.s_sbh);
+		mark_buffer_dirty(sbi->s_sbh);
 		sb->s_dirt = 1;
 
-		if (!(sb->u.minix_sb.s_mount_state & MINIX_VALID_FS))
+		if (!(sbi->s_mount_state & MINIX_VALID_FS))
 			printk ("MINIX-fs warning: remounting unchecked fs, "
 				"running fsck is recommended.\n");
-		else if ((sb->u.minix_sb.s_mount_state & MINIX_ERROR_FS))
+		else if ((sbi->s_mount_state & MINIX_ERROR_FS))
 			printk ("MINIX-fs warning: remounting fs with errors, "
 				"running fsck is recommended.\n");
 	}
@@ -168,7 +170,7 @@
 	struct minix_super_block *ms;
 	int i, block;
 	struct inode *root_inode;
-	struct minix_sb_info *sbi = &s->u.minix_sb;
+	struct minix_sb_info *sbi = minix_sb(s);
 
 	/* N.B. These should be compile-time tests.
 	   Unfortunately that is impossible. */
@@ -316,14 +318,15 @@
 
 static int minix_statfs(struct super_block *sb, struct statfs *buf)
 {
+	struct minix_sb_info *sbi = minix_sb(sb);
 	buf->f_type = sb->s_magic;
 	buf->f_bsize = sb->s_blocksize;
-	buf->f_blocks = (sb->u.minix_sb.s_nzones - sb->u.minix_sb.s_firstdatazone) << sb->u.minix_sb.s_log_zone_size;
+	buf->f_blocks = (sbi->s_nzones - sbi->s_firstdatazone) << sbi->s_log_zone_size;
 	buf->f_bfree = minix_count_free_blocks(sb);
 	buf->f_bavail = buf->f_bfree;
-	buf->f_files = sb->u.minix_sb.s_ninodes;
+	buf->f_files = sbi->s_ninodes;
 	buf->f_ffree = minix_count_free_inodes(sb);
-	buf->f_namelen = sb->u.minix_sb.s_namelen;
+	buf->f_namelen = sbi->s_namelen;
 	return 0;
 }
 
diff -urN -X scripts/dontdiff linux-2.5.6/fs/minix/itree_v1.c linux/fs/minix/itree_v1.c
--- linux-2.5.6/fs/minix/itree_v1.c	Wed Feb  6 11:47:05 2002
+++ linux/fs/minix/itree_v1.c	Thu Mar  7 08:38:13 2002
@@ -28,7 +28,7 @@
 
 	if (block < 0) {
 		printk("minix_bmap: block<0");
-	} else if (block >= (inode->i_sb->u.minix_sb.s_max_size/BLOCK_SIZE)) {
+	} else if (block >= (minix_sb(inode->i_sb)->s_max_size/BLOCK_SIZE)) {
 		printk("minix_bmap: block>big");
 	} else if (block < 7) {
 		offsets[n++] = block;
diff -urN -X scripts/dontdiff linux-2.5.6/fs/minix/itree_v2.c linux/fs/minix/itree_v2.c
--- linux-2.5.6/fs/minix/itree_v2.c	Wed Feb  6 11:47:05 2002
+++ linux/fs/minix/itree_v2.c	Thu Mar  7 08:38:13 2002
@@ -28,7 +28,7 @@
 
 	if (block < 0) {
 		printk("minix_bmap: block<0");
-	} else if (block >= (inode->i_sb->u.minix_sb.s_max_size/BLOCK_SIZE)) {
+	} else if (block >= (minix_sb(inode->i_sb)->s_max_size/BLOCK_SIZE)) {
 		printk("minix_bmap: block>big");
 	} else if (block < 7) {
 		offsets[n++] = block;
diff -urN -X scripts/dontdiff linux-2.5.6/fs/minix/namei.c linux/fs/minix/namei.c
--- linux-2.5.6/fs/minix/namei.c	Wed Feb 20 01:47:36 2002
+++ linux/fs/minix/namei.c	Thu Mar  7 08:38:13 2002
@@ -38,7 +38,7 @@
 	int i;
 	const unsigned char *name;
 
-	i = dentry->d_inode->i_sb->u.minix_sb.s_namelen;
+	i = minix_sb(dentry->d_inode->i_sb)->s_namelen;
 	if (i >= qstr->len)
 		return 0;
 	/* Truncate the name in place, avoids having to define a compare
@@ -63,7 +63,7 @@
 
 	dentry->d_op = dir->i_sb->s_root->d_op;
 
-	if (dentry->d_name.len > dir->i_sb->u.minix_sb.s_namelen)
+	if (dentry->d_name.len > minix_sb(dir->i_sb)->s_namelen)
 		return ERR_PTR(-ENAMETOOLONG);
 
 	ino = minix_inode_by_name(dentry);
@@ -131,7 +131,7 @@
 {
 	struct inode *inode = old_dentry->d_inode;
 
-	if (inode->i_nlink >= inode->i_sb->u.minix_sb.s_link_max)
+	if (inode->i_nlink >= minix_sb(inode->i_sb)->s_link_max)
 		return -EMLINK;
 
 	inode->i_ctime = CURRENT_TIME;
@@ -145,7 +145,7 @@
 	struct inode * inode;
 	int err = -EMLINK;
 
-	if (dir->i_nlink >= dir->i_sb->u.minix_sb.s_link_max)
+	if (dir->i_nlink >= minix_sb(dir->i_sb)->s_link_max)
 		goto out;
 
 	inc_count(dir);
@@ -221,7 +221,7 @@
 static int minix_rename(struct inode * old_dir, struct dentry *old_dentry,
 			   struct inode * new_dir, struct dentry *new_dentry)
 {
-	struct minix_sb_info * info = &old_dir->i_sb->u.minix_sb;
+	struct minix_sb_info * info = minix_sb(old_dir->i_sb);
 	struct inode * old_inode = old_dentry->d_inode;
 	struct inode * new_inode = new_dentry->d_inode;
 	struct page * dir_page = NULL;
diff -urN -X scripts/dontdiff linux-2.5.6/include/linux/minix_fs.h linux/include/linux/minix_fs.h
--- linux-2.5.6/include/linux/minix_fs.h	Wed Feb  6 11:47:05 2002
+++ linux/include/linux/minix_fs.h	Thu Mar  7 09:54:58 2002
@@ -32,7 +32,7 @@
 #define MINIX_V1		0x0001		/* original minix fs */
 #define MINIX_V2		0x0002		/* minix V2 fs */
 
-#define INODE_VERSION(inode)	inode->i_sb->u.minix_sb.s_version
+#define INODE_VERSION(inode)	minix_sb(inode->i_sb)->s_version
 
 /*
  * This is the original minix inode layout on disk.
@@ -90,6 +90,7 @@
 #ifdef __KERNEL__
 
 #include <linux/minix_fs_i.h>
+#include <linux/minix_fs_sb.h>
 
 /*
  * change the define below to 0 if you want names > info->s_namelen chars to be
@@ -131,6 +132,11 @@
 extern struct file_operations minix_dir_operations;
 extern struct dentry_operations minix_dentry_operations;
 
+static inline struct minix_sb_info *minix_sb(struct super_block *sb)
+{
+	return &sb->u.minix_sb;
+}
+
 static inline struct minix_inode_info *minix_i(struct inode *inode)
 {
 	return list_entry(inode, struct minix_inode_info, vfs_inode);

--------------F35276E6465D04DC5B835184
Content-Type: text/plain; charset=us-ascii;
 name="sb-minix-b1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-minix-b1"

diff -urN linux/fs/minix/inode.c linux2/fs/minix/inode.c
--- linux/fs/minix/inode.c	Thu Mar  7 09:39:46 2002
+++ linux2/fs/minix/inode.c	Thu Mar  7 10:12:22 2002
@@ -70,6 +70,8 @@
 		brelse(sbi->s_zmap[i]);
 	brelse (sbi->s_sbh);
 	kfree(sbi->s_imap);
+	sb->u.generic_sbp = NULL;
+	kfree(sbi);
 
 	return;
 }
@@ -170,7 +172,12 @@
 	struct minix_super_block *ms;
 	int i, block;
 	struct inode *root_inode;
-	struct minix_sb_info *sbi = minix_sb(s);
+	struct minix_sb_info *sbi;
+
+	sbi = kmalloc(sizeof(struct minix_sb_info), GFP_KERNEL);
+	if (!sbi)
+		return -ENOMEM;
+	s->u.generic_sbp = sbi;
 
 	/* N.B. These should be compile-time tests.
 	   Unfortunately that is impossible. */
@@ -313,6 +320,8 @@
 out_bad_sb:
 	printk("MINIX-fs: unable to read superblock\n");
  out:
+	s->u.generic_sbp = NULL;
+	kfree(sbi);
 	return -EINVAL;
 }
 
diff -urN linux/include/linux/fs.h linux2/include/linux/fs.h
--- linux/include/linux/fs.h	Thu Mar  7 09:55:00 2002
+++ linux2/include/linux/fs.h	Thu Mar  7 10:11:08 2002
@@ -650,7 +650,6 @@
 #define MNT_FORCE	0x00000001	/* Attempt to forcibily umount */
 #define MNT_DETACH	0x00000002	/* Just detach from the tree */
 
-#include <linux/minix_fs_sb.h>
 #include <linux/ext2_fs_sb.h>
 #include <linux/ext3_fs_sb.h>
 #include <linux/hpfs_fs_sb.h>
@@ -708,7 +707,6 @@
 	char s_id[32];				/* Informational name */
 
 	union {
-		struct minix_sb_info	minix_sb;
 		struct ext2_sb_info	ext2_sb;
 		struct ext3_sb_info	ext3_sb;
 		struct hpfs_sb_info	hpfs_sb;
diff -urN linux/include/linux/minix_fs.h linux2/include/linux/minix_fs.h
--- linux/include/linux/minix_fs.h	Thu Mar  7 09:54:58 2002
+++ linux2/include/linux/minix_fs.h	Thu Mar  7 09:58:42 2002
@@ -134,7 +134,7 @@
 
 static inline struct minix_sb_info *minix_sb(struct super_block *sb)
 {
-	return &sb->u.minix_sb;
+	return sb->u.generic_sbp;
 }
 
 static inline struct minix_inode_info *minix_i(struct inode *inode)

--------------F35276E6465D04DC5B835184--

