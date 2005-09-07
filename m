Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVIGBUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVIGBUR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 21:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVIGBUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 21:20:17 -0400
Received: from womble.dur.ac.uk ([129.234.2.142]:40964 "EHLO womble.dur.ac.uk")
	by vger.kernel.org with ESMTP id S1751168AbVIGBUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 21:20:15 -0400
Date: Wed, 7 Sep 2005 02:20:01 +0100
From: Andrew Stribblehill <a.d.stribblehill@durham.ac.uk>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: tigran@veritas.com
Subject: [PATCH 2.6.13] bfs: fix endianness, signedness; add trivial bugfix
Message-ID: <20050907012001.GA4435@wompom>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tigran@veritas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Uptime: 16:45:07 up 6 days,  2:26, 21 users,  load average: 0.03, 0.02, 0.00
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Makes BFS code endianness-clean.


* Fixes some signedness warnings.


* Fixes a problem in fs/bfs/inode.c:164 where inodes not synced to disk
don't get fully marked as clean. Here's how to reproduce it:

# mount -o loop -t bfs /bfs.img /mnt
# df -i /mnt
Filesystem            Inodes   IUsed   IFree IUse% Mounted on
/bfs.img                  48       1      47    3% /mnt
# df -k /mnt
Filesystem           1K-blocks      Used Available Use% Mounted on
/bfs.img                   512         5       508   1% /mnt
# cp 60k-archive.zip /mnt/mt.zip
# df -k /mnt
Filesystem           1K-blocks      Used Available Use% Mounted on
/bfs.img                   512        65       447  13% /mnt
# df -i /mnt
Filesystem            Inodes   IUsed   IFree IUse% Mounted on
/bfs.img                  48       2      46    5% /mnt
# rm /mnt/mt.zip
# echo $?
0

 [If the unlink happens before the buffers flush, the following happens:]

# df -i /mnt
Filesystem            Inodes   IUsed   IFree IUse% Mounted on
/bfs.img                  48       2      46    5% /mnt
# df -k /mnt
Filesystem           1K-blocks      Used Available Use% Mounted on
/bfs.img                   512        65       447  13% /mnt


 fs/bfs/bfs.h           |    1 
 fs/bfs/dir.c           |   25 ++++++------
 fs/bfs/file.c          |   23 ++++++-----
 fs/bfs/inode.c         |  100 ++++++++++++++++++++++++++-----------------------
 include/linux/bfs_fs.h |   23 +++++------
 5 files changed, 92 insertions(+), 80 deletions(-)

Signed-off-by: Andrew Stribblehill <ads@wompom.org>

--- kernel/fs/bfs/bfs.h	2005-09-02 13:23:24.000000000 +0100
+++ kernel/fs/bfs/bfs.h	2005-09-02 15:01:52.000000000 +0100
@@ -20,7 +20,6 @@
 	unsigned long si_lasti;
 	unsigned long * si_imap;
 	struct buffer_head * si_sbh;		/* buffer header w/superblock */
-	struct bfs_super_block * si_bfs_sb;	/* superblock in si_sbh->b_data */
 };
 
 /*
--- kernel/fs/bfs/dir.c	2005-09-02 13:23:24.000000000 +0100
+++ kernel/fs/bfs/dir.c	2005-09-02 15:01:52.000000000 +0100
@@ -2,6 +2,7 @@
  *	fs/bfs/dir.c
  *	BFS directory operations.
  *	Copyright (C) 1999,2000  Tigran Aivazian <tigran@veritas.com>
+ *      Made endianness-clean by Andrew Stribblehill <ads@wompom.org> 2005
  */
 
 #include <linux/time.h>
@@ -20,9 +21,9 @@
 #define dprintf(x...)
 #endif
 
-static int bfs_add_entry(struct inode * dir, const char * name, int namelen, int ino);
+static int bfs_add_entry(struct inode * dir, const unsigned char * name, int namelen, int ino);
 static struct buffer_head * bfs_find_entry(struct inode * dir, 
-	const char * name, int namelen, struct bfs_dirent ** res_dir);
+	const unsigned char * name, int namelen, struct bfs_dirent ** res_dir);
 
 static int bfs_readdir(struct file * f, void * dirent, filldir_t filldir)
 {
@@ -53,7 +54,7 @@
 			de = (struct bfs_dirent *)(bh->b_data + offset);
 			if (de->ino) {
 				int size = strnlen(de->name, BFS_NAMELEN);
-				if (filldir(dirent, de->name, size, f->f_pos, de->ino, DT_UNKNOWN) < 0) {
+				if (filldir(dirent, de->name, size, f->f_pos, le16_to_cpu(de->ino), DT_UNKNOWN) < 0) {
 					brelse(bh);
 					unlock_kernel();
 					return 0;
@@ -107,7 +108,7 @@
 	inode->i_mapping->a_ops = &bfs_aops;
 	inode->i_mode = mode;
 	inode->i_ino = ino;
-	BFS_I(inode)->i_dsk_ino = ino;
+	BFS_I(inode)->i_dsk_ino = cpu_to_le16(ino);
 	BFS_I(inode)->i_sblock = 0;
 	BFS_I(inode)->i_eblock = 0;
 	insert_inode_hash(inode);
@@ -139,7 +140,7 @@
 	lock_kernel();
 	bh = bfs_find_entry(dir, dentry->d_name.name, dentry->d_name.len, &de);
 	if (bh) {
-		unsigned long ino = le32_to_cpu(de->ino);
+		unsigned long ino = (unsigned long)le16_to_cpu(de->ino);
 		brelse(bh);
 		inode = iget(dir->i_sb, ino);
 		if (!inode) {
@@ -183,7 +184,7 @@
 	inode = dentry->d_inode;
 	lock_kernel();
 	bh = bfs_find_entry(dir, dentry->d_name.name, dentry->d_name.len, &de);
-	if (!bh || de->ino != inode->i_ino) 
+	if (!bh || le16_to_cpu(de->ino) != inode->i_ino) 
 		goto out_brelse;
 
 	if (!inode->i_nlink) {
@@ -224,7 +225,7 @@
 				old_dentry->d_name.name, 
 				old_dentry->d_name.len, &old_de);
 
-	if (!old_bh || old_de->ino != old_inode->i_ino)
+	if (!old_bh || le16_to_cpu(old_de->ino) != old_inode->i_ino)
 		goto end_rename;
 
 	error = -EPERM;
@@ -270,7 +271,7 @@
 	.rename			= bfs_rename,
 };
 
-static int bfs_add_entry(struct inode * dir, const char * name, int namelen, int ino)
+static int bfs_add_entry(struct inode * dir, const unsigned char * name, int namelen, int ino)
 {
 	struct buffer_head * bh;
 	struct bfs_dirent * de;
@@ -304,7 +305,7 @@
 				}
 				dir->i_mtime = CURRENT_TIME_SEC;
 				mark_inode_dirty(dir);
-				de->ino = ino;
+				de->ino = cpu_to_le16((u16)ino);
 				for (i=0; i<BFS_NAMELEN; i++)
 					de->name[i] = (i < namelen) ? name[i] : 0;
 				mark_buffer_dirty(bh);
@@ -317,7 +318,7 @@
 	return -ENOSPC;
 }
 
-static inline int bfs_namecmp(int len, const char * name, const char * buffer)
+static inline int bfs_namecmp(int len, const unsigned char * name, const char * buffer)
 {
 	if (len < BFS_NAMELEN && buffer[len])
 		return 0;
@@ -325,7 +326,7 @@
 }
 
 static struct buffer_head * bfs_find_entry(struct inode * dir, 
-	const char * name, int namelen, struct bfs_dirent ** res_dir)
+	const unsigned char * name, int namelen, struct bfs_dirent ** res_dir)
 {
 	unsigned long block, offset;
 	struct buffer_head * bh;
@@ -346,7 +347,7 @@
 		}
 		de = (struct bfs_dirent *)(bh->b_data + offset);
 		offset += BFS_DIRENT_SIZE;
-		if (de->ino && bfs_namecmp(namelen, name, de->name)) {
+		if (le16_to_cpu(de->ino) && bfs_namecmp(namelen, name, de->name)) {
 			*res_dir = de;
 			return bh;
 		}
--- kernel/fs/bfs/file.c	2005-09-02 13:23:24.000000000 +0100
+++ kernel/fs/bfs/file.c	2005-09-02 15:05:44.000000000 +0100
@@ -40,8 +40,8 @@
 	return 0;
 }
 
-static int bfs_move_blocks(struct super_block *sb, unsigned long start, unsigned long end, 
-				unsigned long where)
+static int bfs_move_blocks(struct super_block *sb, unsigned long start,
+                           unsigned long end, unsigned long where)
 {
 	unsigned long i;
 
@@ -57,20 +57,21 @@
 static int bfs_get_block(struct inode * inode, sector_t block, 
 	struct buffer_head * bh_result, int create)
 {
-	long phys;
+	unsigned long phys;
 	int err;
 	struct super_block *sb = inode->i_sb;
 	struct bfs_sb_info *info = BFS_SB(sb);
 	struct bfs_inode_info *bi = BFS_I(inode);
 	struct buffer_head *sbh = info->si_sbh;
 
-	if (block < 0 || block > info->si_blocks)
+	if (block > info->si_blocks)
 		return -EIO;
 
 	phys = bi->i_sblock + block;
 	if (!create) {
 		if (phys <= bi->i_eblock) {
-			dprintf("c=%d, b=%08lx, phys=%08lx (granted)\n", create, block, phys);
+			dprintf("c=%d, b=%08lx, phys=%09lx (granted)\n",
+                                create, (unsigned long)block, phys);
 			map_bh(bh_result, sb, phys);
 		}
 		return 0;
@@ -80,7 +81,7 @@
 	   of blocks allocated for this file, we can grant it */
 	if (inode->i_size && phys <= bi->i_eblock) {
 		dprintf("c=%d, b=%08lx, phys=%08lx (interim block granted)\n", 
-				create, block, phys);
+				create, (unsigned long)block, phys);
 		map_bh(bh_result, sb, phys);
 		return 0;
 	}
@@ -88,11 +89,12 @@
 	/* the rest has to be protected against itself */
 	lock_kernel();
 
-	/* if the last data block for this file is the last allocated block, we can
-	   extend the file trivially, without moving it anywhere */
+	/* if the last data block for this file is the last allocated
+	   block, we can extend the file trivially, without moving it
+	   anywhere */
 	if (bi->i_eblock == info->si_lf_eblk) {
 		dprintf("c=%d, b=%08lx, phys=%08lx (simple extension)\n", 
-				create, block, phys);
+				create, (unsigned long)block, phys);
 		map_bh(bh_result, sb, phys);
 		info->si_freeb -= phys - bi->i_eblock;
 		info->si_lf_eblk = bi->i_eblock = phys;
@@ -114,7 +116,8 @@
 	} else
 		err = 0;
 
-	dprintf("c=%d, b=%08lx, phys=%08lx (moved)\n", create, block, phys);
+	dprintf("c=%d, b=%08lx, phys=%08lx (moved)\n",
+                create, (unsigned long)block, phys);
 	bi->i_sblock = phys;
 	phys += block;
 	info->si_lf_eblk = bi->i_eblock = phys;
--- kernel/fs/bfs/inode.c	2005-09-02 13:23:24.000000000 +0100
+++ kernel/fs/bfs/inode.c	2005-09-02 15:12:01.000000000 +0100
@@ -3,6 +3,8 @@
  *	BFS superblock and inode operations.
  *	Copyright (C) 1999,2000 Tigran Aivazian <tigran@veritas.com>
  *	From fs/minix, Copyright (C) 1991, 1992 Linus Torvalds.
+ *
+ *      Made endianness-clean by Andrew Stribblehill <ads@wompom.org>, 2005.
  */
 
 #include <linux/module.h>
@@ -54,46 +56,50 @@
 	off = (ino - BFS_ROOT_INO) % BFS_INODES_PER_BLOCK;
 	di = (struct bfs_inode *)bh->b_data + off;
 
-	inode->i_mode = 0x0000FFFF & di->i_mode;
-	if (di->i_vtype == BFS_VDIR) {
+	inode->i_mode = 0x0000FFFF &  le32_to_cpu(di->i_mode);
+	if (le32_to_cpu(di->i_vtype) == BFS_VDIR) {
 		inode->i_mode |= S_IFDIR;
 		inode->i_op = &bfs_dir_inops;
 		inode->i_fop = &bfs_dir_operations;
-	} else if (di->i_vtype == BFS_VREG) {
+	} else if (le32_to_cpu(di->i_vtype) == BFS_VREG) {
 		inode->i_mode |= S_IFREG;
 		inode->i_op = &bfs_file_inops;
 		inode->i_fop = &bfs_file_operations;
 		inode->i_mapping->a_ops = &bfs_aops;
 	}
 
-	inode->i_uid = di->i_uid;
-	inode->i_gid = di->i_gid;
-	inode->i_nlink = di->i_nlink;
+	BFS_I(inode)->i_sblock =  le32_to_cpu(di->i_sblock);
+	BFS_I(inode)->i_eblock =  le32_to_cpu(di->i_eblock);
+	inode->i_uid =  le32_to_cpu(di->i_uid);
+	inode->i_gid =  le32_to_cpu(di->i_gid);
+	inode->i_nlink =  le32_to_cpu(di->i_nlink);
 	inode->i_size = BFS_FILESIZE(di);
 	inode->i_blocks = BFS_FILEBLOCKS(di);
+        if (inode->i_size || inode->i_blocks) dprintf("Registered inode with %lld size, %ld blocks\n", inode->i_size, inode->i_blocks);
 	inode->i_blksize = PAGE_SIZE;
-	inode->i_atime.tv_sec = di->i_atime;
-	inode->i_mtime.tv_sec = di->i_mtime;
-	inode->i_ctime.tv_sec = di->i_ctime;
+	inode->i_atime.tv_sec =  le32_to_cpu(di->i_atime);
+	inode->i_mtime.tv_sec =  le32_to_cpu(di->i_mtime);
+	inode->i_ctime.tv_sec =  le32_to_cpu(di->i_ctime);
 	inode->i_atime.tv_nsec = 0;
 	inode->i_mtime.tv_nsec = 0;
 	inode->i_ctime.tv_nsec = 0;
-	BFS_I(inode)->i_dsk_ino = di->i_ino; /* can be 0 so we store a copy */
-	BFS_I(inode)->i_sblock = di->i_sblock;
-	BFS_I(inode)->i_eblock = di->i_eblock;
+	BFS_I(inode)->i_dsk_ino = le16_to_cpu(di->i_ino); /* can be 0 so we store a copy */
 
 	brelse(bh);
 }
 
 static int bfs_write_inode(struct inode * inode, int unused)
 {
-	unsigned long ino = inode->i_ino;
+	unsigned int ino = (u16)inode->i_ino;
+        unsigned long i_sblock;
 	struct bfs_inode * di;
 	struct buffer_head * bh;
 	int block, off;
 
+        dprintf("ino=%08x\n", ino);
+        
 	if (ino < BFS_ROOT_INO || ino > BFS_SB(inode->i_sb)->si_lasti) {
-		printf("Bad inode number %s:%08lx\n", inode->i_sb->s_id, ino);
+		printf("Bad inode number %s:%08x\n", inode->i_sb->s_id, ino);
 		return -EIO;
 	}
 
@@ -101,7 +107,7 @@
 	block = (ino - BFS_ROOT_INO)/BFS_INODES_PER_BLOCK + 1;
 	bh = sb_bread(inode->i_sb, block);
 	if (!bh) {
-		printf("Unable to read inode %s:%08lx\n", inode->i_sb->s_id, ino);
+		printf("Unable to read inode %s:%08x\n", inode->i_sb->s_id, ino);
 		unlock_kernel();
 		return -EIO;
 	}
@@ -109,24 +115,26 @@
 	off = (ino - BFS_ROOT_INO)%BFS_INODES_PER_BLOCK;
 	di = (struct bfs_inode *)bh->b_data + off;
 
-	if (inode->i_ino == BFS_ROOT_INO)
-		di->i_vtype = BFS_VDIR;
+	if (ino == BFS_ROOT_INO)
+		di->i_vtype = cpu_to_le32(BFS_VDIR);
 	else
-		di->i_vtype = BFS_VREG;
+		di->i_vtype = cpu_to_le32(BFS_VREG);
 
-	di->i_ino = inode->i_ino;
-	di->i_mode = inode->i_mode;
-	di->i_uid = inode->i_uid;
-	di->i_gid = inode->i_gid;
-	di->i_nlink = inode->i_nlink;
-	di->i_atime = inode->i_atime.tv_sec;
-	di->i_mtime = inode->i_mtime.tv_sec;
-	di->i_ctime = inode->i_ctime.tv_sec;
-	di->i_sblock = BFS_I(inode)->i_sblock;
-	di->i_eblock = BFS_I(inode)->i_eblock;
-	di->i_eoffset = di->i_sblock * BFS_BSIZE + inode->i_size - 1;
+	di->i_ino = cpu_to_le16(ino);
+	di->i_mode = cpu_to_le32(inode->i_mode);
+	di->i_uid = cpu_to_le32(inode->i_uid);
+	di->i_gid = cpu_to_le32(inode->i_gid);
+	di->i_nlink = cpu_to_le32(inode->i_nlink);
+	di->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
+	di->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
+	di->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
+        i_sblock = BFS_I(inode)->i_sblock;
+	di->i_sblock = cpu_to_le32(i_sblock);
+	di->i_eblock = cpu_to_le32(BFS_I(inode)->i_eblock);
+	di->i_eoffset = cpu_to_le32(i_sblock * BFS_BSIZE + inode->i_size - 1);
 
 	mark_buffer_dirty(bh);
+        dprintf("Written ino=%d into %d:%d\n",le16_to_cpu(di->i_ino),block,off);
 	brelse(bh);
 	unlock_kernel();
 	return 0;
@@ -140,11 +148,12 @@
 	int block, off;
 	struct super_block * s = inode->i_sb;
 	struct bfs_sb_info * info = BFS_SB(s);
+        struct bfs_inode_info * bi = BFS_I(inode);
 
-	dprintf("ino=%08lx\n", inode->i_ino);
+	dprintf("ino=%08lx\n", ino);
 
-	if (inode->i_ino < BFS_ROOT_INO || inode->i_ino > info->si_lasti) {
-		printf("invalid ino=%08lx\n", inode->i_ino);
+	if (ino < BFS_ROOT_INO || ino > info->si_lasti) {
+		printf("invalid ino=%08lx\n", ino);
 		return;
 	}
 	
@@ -160,13 +169,13 @@
 		return;
 	}
 	off = (ino - BFS_ROOT_INO)%BFS_INODES_PER_BLOCK;
-	di = (struct bfs_inode *)bh->b_data + off;
-	if (di->i_ino) {
-		info->si_freeb += BFS_FILEBLOCKS(di);
+	di = (struct bfs_inode *) bh->b_data + off;
+        if (bi->i_dsk_ino) {
+		info->si_freeb += 1 + bi->i_eblock - bi->i_sblock;
 		info->si_freei++;
-		clear_bit(di->i_ino, info->si_imap);
+		clear_bit(ino, info->si_imap);
 		dump_imap("delete_inode", s);
-	}
+        }
 	di->i_ino = 0;
 	di->i_sblock = 0;
 	mark_buffer_dirty(bh);
@@ -272,14 +281,14 @@
 
 void dump_imap(const char *prefix, struct super_block * s)
 {
-#if 0
+#ifdef DEBUG
 	int i;
 	char *tmpbuf = (char *)get_zeroed_page(GFP_KERNEL);
 
 	if (!tmpbuf)
 		return;
 	for (i=BFS_SB(s)->si_lasti; i>=0; i--) {
-		if (i>PAGE_SIZE-100) break;
+		if (i > PAGE_SIZE-100) break;
 		if (test_bit(i, BFS_SB(s)->si_imap))
 			strcat(tmpbuf, "1");
 		else
@@ -295,7 +304,7 @@
 	struct buffer_head * bh;
 	struct bfs_super_block * bfs_sb;
 	struct inode * inode;
-	int i, imap_len;
+	unsigned i, imap_len;
 	struct bfs_sb_info * info;
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
@@ -310,19 +319,18 @@
 	if(!bh)
 		goto out;
 	bfs_sb = (struct bfs_super_block *)bh->b_data;
-	if (bfs_sb->s_magic != BFS_MAGIC) {
+	if (le32_to_cpu(bfs_sb->s_magic) != BFS_MAGIC) {
 		if (!silent)
 			printf("No BFS filesystem on %s (magic=%08x)\n", 
-				s->s_id, bfs_sb->s_magic);
+				s->s_id,  le32_to_cpu(bfs_sb->s_magic));
 		goto out;
 	}
 	if (BFS_UNCLEAN(bfs_sb, s) && !silent)
 		printf("%s is unclean, continuing\n", s->s_id);
 
 	s->s_magic = BFS_MAGIC;
-	info->si_bfs_sb = bfs_sb;
 	info->si_sbh = bh;
-	info->si_lasti = (bfs_sb->s_start - BFS_BSIZE)/sizeof(struct bfs_inode) 
+	info->si_lasti = (le32_to_cpu(bfs_sb->s_start) - BFS_BSIZE)/sizeof(struct bfs_inode) 
 			+ BFS_ROOT_INO - 1;
 
 	imap_len = info->si_lasti/8 + 1;
@@ -346,8 +354,8 @@
 		goto out;
 	}
 
-	info->si_blocks = (bfs_sb->s_end + 1)>>BFS_BSIZE_BITS; /* for statfs(2) */
-	info->si_freeb = (bfs_sb->s_end + 1 - bfs_sb->s_start)>>BFS_BSIZE_BITS;
+	info->si_blocks = (le32_to_cpu(bfs_sb->s_end) + 1)>>BFS_BSIZE_BITS; /* for statfs(2) */
+	info->si_freeb = (le32_to_cpu(bfs_sb->s_end) + 1 -  cpu_to_le32(bfs_sb->s_start))>>BFS_BSIZE_BITS;
 	info->si_freei = 0;
 	info->si_lf_eblk = 0;
 	info->si_lf_sblk = 0;
--- kernel/include/linux/bfs_fs.h	2005-09-02 13:23:56.000000000 +0100
+++ kernel/include/linux/bfs_fs.h	2005-09-02 15:37:58.000000000 +0100
@@ -14,8 +14,9 @@
 #define BFS_INODES_PER_BLOCK	8
 
 /* SVR4 vnode type values (bfs_inode->i_vtype) */
-#define BFS_VDIR		2
-#define BFS_VREG		1
+#define BFS_VDIR 2L
+#define BFS_VREG 1L
+
 
 /* BFS inode layout on disk */
 struct bfs_inode {
@@ -58,22 +59,22 @@
 	__u32 s_padding[118];
 };
 
-#define BFS_NZFILESIZE(ip) \
-        (((ip)->i_eoffset + 1) - (ip)->i_sblock * BFS_BSIZE)
-
-#define BFS_FILESIZE(ip) \
-        ((ip)->i_sblock == 0 ? 0 : BFS_NZFILESIZE(ip))
-
-#define BFS_FILEBLOCKS(ip) \
-        ((ip)->i_sblock == 0 ? 0 : ((ip)->i_eblock + 1) - (ip)->i_sblock)
 
 #define BFS_OFF2INO(offset) \
         ((((offset) - BFS_BSIZE) / sizeof(struct bfs_inode)) + BFS_ROOT_INO)
 
 #define BFS_INO2OFF(ino) \
 	((__u32)(((ino) - BFS_ROOT_INO) * sizeof(struct bfs_inode)) + BFS_BSIZE)
+#define BFS_NZFILESIZE(ip) \
+        ((cpu_to_le32((ip)->i_eoffset) + 1) -  cpu_to_le32((ip)->i_sblock) * BFS_BSIZE)
+
+#define BFS_FILESIZE(ip) \
+        ((ip)->i_sblock == 0 ? 0 : BFS_NZFILESIZE(ip))
 
+#define BFS_FILEBLOCKS(ip) \
+        ((ip)->i_sblock == 0 ? 0 : (cpu_to_le32((ip)->i_eblock) + 1) -  cpu_to_le32((ip)->i_sblock))
 #define BFS_UNCLEAN(bfs_sb, sb)	\
-	((bfs_sb->s_from != -1) && (bfs_sb->s_to != -1) && !(sb->s_flags & MS_RDONLY))
+	((cpu_to_le32(bfs_sb->s_from) != -1) && (cpu_to_le32(bfs_sb->s_to) != -1) && !(sb->s_flags & MS_RDONLY))
+
 
 #endif	/* _LINUX_BFS_FS_H */

-- 
FAEROES SOUTHEAST ICELAND
SOUTHWEST 4 OR 5 BACKING SOUTH 6 TO GALE 8, BECOMING CYCLONIC LATER
IN SOUTHEAST ICELAND. RAIN OR SHOWERS. MODERATE OR GOOD
