Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312070AbSCQQkk>; Sun, 17 Mar 2002 11:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312068AbSCQQkW>; Sun, 17 Mar 2002 11:40:22 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:40689 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S312069AbSCQQj7>; Sun, 17 Mar 2002 11:39:59 -0500
Message-ID: <3C94C6BA.7080306@didntduck.org>
Date: Sun, 17 Mar 2002 11:39:22 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, tigran@veritas.com
Subject: [PATCH] struct super_block cleanup - bfs
Content-Type: multipart/mixed;
 boundary="------------070702080303090909040802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070702080303090909040802
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Seperates bfs_sb_info from struct super_block.

-- 

						Brian Gerst

--------------070702080303090909040802
Content-Type: text/plain;
 name="sb-bfs-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb-bfs-1"

diff -urN linux-2.5.7-pre2/fs/bfs/bfs_defs.h linux/fs/bfs/bfs_defs.h
--- linux-2.5.7-pre2/fs/bfs/bfs_defs.h	Thu Mar  7 21:18:04 2002
+++ linux/fs/bfs/bfs_defs.h	Sun Mar 17 11:20:35 2002
@@ -1,14 +1,3 @@
-#define su_lasti	u.bfs_sb.si_lasti
-#define su_blocks	u.bfs_sb.si_blocks
-#define su_freeb	u.bfs_sb.si_freeb
-#define su_freei	u.bfs_sb.si_freei
-#define su_lf_ioff	u.bfs_sb.si_lf_ioff
-#define su_lf_sblk	u.bfs_sb.si_lf_sblk
-#define su_lf_eblk	u.bfs_sb.si_lf_eblk
-#define su_imap		u.bfs_sb.si_imap
-#define su_sbh		u.bfs_sb.si_sbh
-#define su_bfs_sb	u.bfs_sb.si_bfs_sb
-
 #define printf(format, args...) \
 	printk(KERN_ERR "BFS-fs: %s(): " format, __FUNCTION__, ## args)
 
diff -urN linux-2.5.7-pre2/fs/bfs/dir.c linux/fs/bfs/dir.c
--- linux-2.5.7-pre2/fs/bfs/dir.c	Thu Mar  7 21:18:57 2002
+++ linux/fs/bfs/dir.c	Sun Mar 17 11:25:38 2002
@@ -78,20 +78,21 @@
 	int err;
 	struct inode * inode;
 	struct super_block * s = dir->i_sb;
+	struct bfs_sb_info * info = BFS_SB(s);
 	unsigned long ino;
 
 	inode = new_inode(s);
 	if (!inode)
 		return -ENOSPC;
 	lock_kernel();
-	ino = find_first_zero_bit(s->su_imap, s->su_lasti);
-	if (ino > s->su_lasti) {
+	ino = find_first_zero_bit(info->si_imap, info->si_lasti);
+	if (ino > info->si_lasti) {
 		unlock_kernel();
 		iput(inode);
 		return -ENOSPC;
 	}
-	set_bit(ino, s->su_imap);	
-	s->su_freei--;
+	set_bit(ino, info->si_imap);	
+	info->si_freei--;
 	inode->i_uid = current->fsuid;
 	inode->i_gid = (dir->i_mode & S_ISGID) ? dir->i_gid : current->fsgid;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
@@ -318,11 +319,9 @@
 {
 	unsigned long block, offset;
 	struct buffer_head * bh;
-	struct bfs_sb_info * info;
 	struct bfs_dirent * de;
 
 	*res_dir = NULL;
-	info = &dir->i_sb->u.bfs_sb;
 	if (namelen > BFS_NAMELEN)
 		return NULL;
 	bh = NULL;
diff -urN linux-2.5.7-pre2/fs/bfs/file.c linux/fs/bfs/file.c
--- linux-2.5.7-pre2/fs/bfs/file.c	Thu Mar  7 21:18:15 2002
+++ linux/fs/bfs/file.c	Sun Mar 17 10:36:53 2002
@@ -60,10 +60,11 @@
 	long phys;
 	int err;
 	struct super_block *sb = inode->i_sb;
+	struct bfs_sb_info *info = BFS_SB(sb);
 	struct bfs_inode_info *bi = BFS_I(inode);
-	struct buffer_head *sbh = sb->su_sbh;
+	struct buffer_head *sbh = info->si_sbh;
 
-	if (block < 0 || block > sb->su_blocks)
+	if (block < 0 || block > info->si_blocks)
 		return -EIO;
 
 	phys = bi->i_sblock + block;
@@ -89,12 +90,12 @@
 
 	/* if the last data block for this file is the last allocated block, we can
 	   extend the file trivially, without moving it anywhere */
-	if (bi->i_eblock == sb->su_lf_eblk) {
+	if (bi->i_eblock == info->si_lf_eblk) {
 		dprintf("c=%d, b=%08lx, phys=%08lx (simple extension)\n", 
 				create, block, phys);
 		map_bh(bh_result, sb, phys);
-		sb->su_freeb -= phys - bi->i_eblock;
-		sb->su_lf_eblk = bi->i_eblock = phys;
+		info->si_freeb -= phys - bi->i_eblock;
+		info->si_lf_eblk = bi->i_eblock = phys;
 		mark_inode_dirty(inode);
 		mark_buffer_dirty(sbh);
 		err = 0;
@@ -102,7 +103,7 @@
 	}
 
 	/* Ok, we have to move this entire file to the next free block */
-	phys = sb->su_lf_eblk + 1;
+	phys = info->si_lf_eblk + 1;
 	if (bi->i_sblock) { /* if data starts on block 0 then there is no data */
 		err = bfs_move_blocks(inode->i_sb, bi->i_sblock, 
 				bi->i_eblock, phys);
@@ -116,11 +117,11 @@
 	dprintf("c=%d, b=%08lx, phys=%08lx (moved)\n", create, block, phys);
 	bi->i_sblock = phys;
 	phys += block;
-	sb->su_lf_eblk = bi->i_eblock = phys;
+	info->si_lf_eblk = bi->i_eblock = phys;
 
 	/* this assumes nothing can write the inode back while we are here
 	 * and thus update inode->i_blocks! (XXX)*/
-	sb->su_freeb -= bi->i_eblock - bi->i_sblock + 1 - inode->i_blocks;
+	info->si_freeb -= bi->i_eblock - bi->i_sblock + 1 - inode->i_blocks;
 	mark_inode_dirty(inode);
 	mark_buffer_dirty(sbh);
 	map_bh(bh_result, sb, phys);
diff -urN linux-2.5.7-pre2/fs/bfs/inode.c linux/fs/bfs/inode.c
--- linux-2.5.7-pre2/fs/bfs/inode.c	Sat Mar 16 00:17:32 2002
+++ linux/fs/bfs/inode.c	Sun Mar 17 11:24:27 2002
@@ -39,7 +39,7 @@
 	struct buffer_head * bh;
 	int block, off;
 
-	if (ino < BFS_ROOT_INO || ino > inode->i_sb->su_lasti) {
+	if (ino < BFS_ROOT_INO || ino > BFS_SB(inode->i_sb)->si_lasti) {
 		printf("Bad inode number %s:%08lx\n", inode->i_sb->s_id, ino);
 		make_bad_inode(inode);
 		return;
@@ -91,7 +91,7 @@
 	struct buffer_head * bh;
 	int block, off;
 
-	if (ino < BFS_ROOT_INO || ino > inode->i_sb->su_lasti) {
+	if (ino < BFS_ROOT_INO || ino > BFS_SB(inode->i_sb)->si_lasti) {
 		printf("Bad inode number %s:%08lx\n", inode->i_sb->s_id, ino);
 		return;
 	}
@@ -137,10 +137,11 @@
 	struct buffer_head * bh;
 	int block, off;
 	struct super_block * s = inode->i_sb;
+	struct bfs_sb_info * info = BFS_SB(s);
 
 	dprintf("ino=%08lx\n", inode->i_ino);
 
-	if (inode->i_ino < BFS_ROOT_INO || inode->i_ino > inode->i_sb->su_lasti) {
+	if (inode->i_ino < BFS_ROOT_INO || inode->i_ino > info->si_lasti) {
 		printf("invalid ino=%08lx\n", inode->i_ino);
 		return;
 	}
@@ -159,9 +160,9 @@
 	off = (ino - BFS_ROOT_INO)%BFS_INODES_PER_BLOCK;
 	di = (struct bfs_inode *)bh->b_data + off;
 	if (di->i_ino) {
-		s->su_freeb += BFS_FILEBLOCKS(di);
-		s->su_freei++;
-		clear_bit(di->i_ino, s->su_imap);
+		info->si_freeb += BFS_FILEBLOCKS(di);
+		info->si_freei++;
+		clear_bit(di->i_ino, info->si_imap);
 		dump_imap("delete_inode", s);
 	}
 	di->i_ino = 0;
@@ -172,9 +173,9 @@
 	/* if this was the last file, make the previous 
 	   block "last files last block" even if there is no real file there,
 	   saves us 1 gap */
-	if (s->su_lf_eblk == BFS_I(inode)->i_eblock) {
-		s->su_lf_eblk = BFS_I(inode)->i_sblock - 1;
-		mark_buffer_dirty(s->su_sbh);
+	if (info->si_lf_eblk == BFS_I(inode)->i_eblock) {
+		info->si_lf_eblk = BFS_I(inode)->i_sblock - 1;
+		mark_buffer_dirty(info->si_sbh);
 	}
 	unlock_kernel();
 	clear_inode(inode);
@@ -182,18 +183,22 @@
 
 static void bfs_put_super(struct super_block *s)
 {
-	brelse(s->su_sbh);
-	kfree(s->su_imap);
+	struct bfs_sb_info *info = BFS_SB(s);
+	brelse(info->si_sbh);
+	kfree(info->si_imap);
+	kfree(info);
+	s->u.generic_sbp = NULL;
 }
 
 static int bfs_statfs(struct super_block *s, struct statfs *buf)
 {
+	struct bfs_sb_info *info = BFS_SB(s);
 	buf->f_type = BFS_MAGIC;
 	buf->f_bsize = s->s_blocksize;
-	buf->f_blocks = s->su_blocks;
-	buf->f_bfree = buf->f_bavail = s->su_freeb;
-	buf->f_files = s->su_lasti + 1 - BFS_ROOT_INO;
-	buf->f_ffree = s->su_freei;
+	buf->f_blocks = info->si_blocks;
+	buf->f_bfree = buf->f_bavail = info->si_freeb;
+	buf->f_files = info->si_lasti + 1 - BFS_ROOT_INO;
+	buf->f_ffree = info->si_freei;
 	buf->f_fsid.val[0] = kdev_t_to_nr(s->s_dev);
 	buf->f_namelen = BFS_NAMELEN;
 	return 0;
@@ -202,7 +207,7 @@
 static void bfs_write_super(struct super_block *s)
 {
 	if (!(s->s_flags & MS_RDONLY))
-		mark_buffer_dirty(s->su_sbh);
+		mark_buffer_dirty(BFS_SB(s)->si_sbh);
 	s->s_dirt = 0;
 }
 
@@ -267,14 +272,14 @@
 
 	if (!tmpbuf)
 		return;
-	for (i=s->su_lasti; i>=0; i--) {
+	for (i=BFS_SB(s)->si_lasti; i>=0; i--) {
 		if (i>PAGE_SIZE-100) break;
-		if (test_bit(i, s->su_imap))
+		if (test_bit(i, BFS_SB(s)->si_imap))
 			strcat(tmpbuf, "1");
 		else
 			strcat(tmpbuf, "0");
 	}
-	printk(KERN_ERR "BFS-fs: %s: lasti=%08lx <%s>\n", prefix, s->su_lasti, tmpbuf);
+	printk(KERN_ERR "BFS-fs: %s: lasti=%08lx <%s>\n", prefix, BFS_SB(s)->si_lasti, tmpbuf);
 	free_page((unsigned long)tmpbuf);
 #endif
 }
@@ -285,6 +290,13 @@
 	struct bfs_super_block * bfs_sb;
 	struct inode * inode;
 	int i, imap_len;
+	struct bfs_sb_info * info;
+
+	info = kmalloc(sizeof(struct bfs_super_block), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	s->u.generic_sbp = info;
+	memset(info, 0, sizeof(struct bfs_super_block));
 
 	sb_set_blocksize(s, BFS_BSIZE);
 
@@ -302,49 +314,49 @@
 		printf("%s is unclean, continuing\n", s->s_id);
 
 	s->s_magic = BFS_MAGIC;
-	s->su_bfs_sb = bfs_sb;
-	s->su_sbh = bh;
-	s->su_lasti = (bfs_sb->s_start - BFS_BSIZE)/sizeof(struct bfs_inode) 
+	info->si_bfs_sb = bfs_sb;
+	info->si_sbh = bh;
+	info->si_lasti = (bfs_sb->s_start - BFS_BSIZE)/sizeof(struct bfs_inode) 
 			+ BFS_ROOT_INO - 1;
 
-	imap_len = s->su_lasti/8 + 1;
-	s->su_imap = kmalloc(imap_len, GFP_KERNEL);
-	if (!s->su_imap)
+	imap_len = info->si_lasti/8 + 1;
+	info->si_imap = kmalloc(imap_len, GFP_KERNEL);
+	if (!info->si_imap)
 		goto out;
-	memset(s->su_imap, 0, imap_len);
+	memset(info->si_imap, 0, imap_len);
 	for (i=0; i<BFS_ROOT_INO; i++) 
-		set_bit(i, s->su_imap);
+		set_bit(i, info->si_imap);
 
 	s->s_op = &bfs_sops;
 	inode = iget(s, BFS_ROOT_INO);
 	if (!inode) {
-		kfree(s->su_imap);
+		kfree(info->si_imap);
 		goto out;
 	}
 	s->s_root = d_alloc_root(inode);
 	if (!s->s_root) {
 		iput(inode);
-		kfree(s->su_imap);
+		kfree(info->si_imap);
 		goto out;
 	}
 
-	s->su_blocks = (bfs_sb->s_end + 1)>>BFS_BSIZE_BITS; /* for statfs(2) */
-	s->su_freeb = (bfs_sb->s_end + 1 - bfs_sb->s_start)>>BFS_BSIZE_BITS;
-	s->su_freei = 0;
-	s->su_lf_eblk = 0;
-	s->su_lf_sblk = 0;
-	s->su_lf_ioff = 0;
-	for (i=BFS_ROOT_INO; i<=s->su_lasti; i++) {
+	info->si_blocks = (bfs_sb->s_end + 1)>>BFS_BSIZE_BITS; /* for statfs(2) */
+	info->si_freeb = (bfs_sb->s_end + 1 - bfs_sb->s_start)>>BFS_BSIZE_BITS;
+	info->si_freei = 0;
+	info->si_lf_eblk = 0;
+	info->si_lf_sblk = 0;
+	info->si_lf_ioff = 0;
+	for (i=BFS_ROOT_INO; i<=info->si_lasti; i++) {
 		inode = iget(s,i);
 		if (BFS_I(inode)->i_dsk_ino == 0)
-			s->su_freei++;
+			info->si_freei++;
 		else {
-			set_bit(i, s->su_imap);
-			s->su_freeb -= inode->i_blocks;
-			if (BFS_I(inode)->i_eblock > s->su_lf_eblk) {
-				s->su_lf_eblk = BFS_I(inode)->i_eblock;
-				s->su_lf_sblk = BFS_I(inode)->i_sblock;
-				s->su_lf_ioff = BFS_INO2OFF(i);
+			set_bit(i, info->si_imap);
+			info->si_freeb -= inode->i_blocks;
+			if (BFS_I(inode)->i_eblock > info->si_lf_eblk) {
+				info->si_lf_eblk = BFS_I(inode)->i_eblock;
+				info->si_lf_sblk = BFS_I(inode)->i_sblock;
+				info->si_lf_ioff = BFS_INO2OFF(i);
 			}
 		}
 		iput(inode);
@@ -358,6 +370,8 @@
 
 out:
 	brelse(bh);
+	kfree(info);
+	s->u.generic_sbp = NULL;
 	return -EINVAL;
 }
 
diff -urN linux-2.5.7-pre2/include/linux/bfs_fs.h linux/include/linux/bfs_fs.h
--- linux-2.5.7-pre2/include/linux/bfs_fs.h	Thu Mar  7 21:18:28 2002
+++ linux/include/linux/bfs_fs.h	Sun Mar 17 11:23:52 2002
@@ -7,6 +7,7 @@
 #define _LINUX_BFS_FS_H
 
 #include <linux/bfs_fs_i.h>
+#include <linux/bfs_fs_sb.h>
 
 #define BFS_BSIZE_BITS		9
 #define BFS_BSIZE		(1<<BFS_BSIZE_BITS)
@@ -89,6 +90,11 @@
 extern struct inode_operations bfs_dir_inops;
 extern struct file_operations bfs_dir_operations;
 
+static inline struct bfs_sb_info *BFS_SB(struct super_block *sb)
+{
+	return sb->u.generic_sbp;
+}
+
 static inline struct bfs_inode_info *BFS_I(struct inode *inode)
 {
 	return list_entry(inode, struct bfs_inode_info, vfs_inode);
diff -urN linux-2.5.7-pre2/include/linux/fs.h linux/include/linux/fs.h
--- linux-2.5.7-pre2/include/linux/fs.h	Sat Mar 16 00:17:34 2002
+++ linux/include/linux/fs.h	Sun Mar 17 11:23:50 2002
@@ -656,7 +656,6 @@
 #include <linux/hfs_fs_sb.h>
 #include <linux/adfs_fs_sb.h>
 #include <linux/reiserfs_fs_sb.h>
-#include <linux/bfs_fs_sb.h>
 #include <linux/udf_fs_sb.h>
 #include <linux/jffs2_fs_sb.h>
 
@@ -706,7 +705,6 @@
 		struct hfs_sb_info	hfs_sb;
 		struct adfs_sb_info	adfs_sb;
 		struct reiserfs_sb_info	reiserfs_sb;
-		struct bfs_sb_info	bfs_sb;
 		struct udf_sb_info	udf_sb;
 		struct jffs2_sb_info	jffs2_sb;
 		void			*generic_sbp;

--------------070702080303090909040802--

