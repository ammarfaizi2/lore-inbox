Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266479AbUIMMN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266479AbUIMMN4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 08:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266534AbUIMMN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 08:13:56 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:38156 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S266479AbUIMMM7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 08:12:59 -0400
Message-ID: <20040913161255.A18665@castle.nmd.msu.ru>
Date: Mon, 13 Sep 2004 16:12:55 +0400
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix for fsync ignoring writing errors
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

AFACS, currently metadata writing errors are ignored and not returned from
sys_fsync on ext2 and ext3 filesystems.
That is, at least ext2 and ext3.

Both ext2 and ext3 resort to sync_inode() in their ->sync_inode method, which
in turn calls ->write_inode.  ->write_inode method has void type, and any IO
errors happening inside are lost.

Any objections to making ->write_inode return the error code?

Signed-off-by: Andrey Savochkin <saw@saw.sw.com.sg>

---
 Documentation/filesystems/Locking |    2 +-
 Documentation/filesystems/vfs.txt |    2 +-
 fs/adfs/adfs.h                    |    2 +-
 fs/adfs/inode.c                   |    6 ++++--
 fs/affs/inode.c                   |    7 ++++---
 fs/bfs/inode.c                    |    7 ++++---
 fs/ext2/ext2.h                    |    2 +-
 fs/ext2/inode.c                   |    4 ++--
 fs/ext3/inode.c                   |   10 +++++-----
 fs/fat/inode.c                    |    7 ++++---
 fs/fs-writeback.c                 |   12 ++++++++----
 fs/hfs/hfs_fs.h                   |    2 +-
 fs/hfs/inode.c                    |   15 ++++++++-------
 fs/hfsplus/hfsplus_fs.h           |    2 +-
 fs/hfsplus/inode.c                |    9 +++++----
 fs/hfsplus/super.c                |    9 +++++----
 fs/jfs/inode.c                    |   10 ++++++----
 fs/jfs/super.c                    |    2 +-
 fs/minix/inode.c                  |    5 +++--
 fs/nfs/inode.c                    |   10 +++++++---
 fs/ntfs/inode.c                   |   24 ------------------------
 fs/ntfs/inode.h                   |    1 -
 fs/ntfs/super.c                   |    2 +-
 fs/qnx4/inode.c                   |    9 +++++----
 fs/reiserfs/inode.c               |    5 +++--
 fs/sysv/inode.c                   |    3 ++-
 fs/sysv/sysv.h                    |    2 +-
 fs/udf/inode.c                    |    6 ++++--
 fs/udf/udfdecl.h                  |    2 +-
 fs/ufs/inode.c                    |    6 ++++--
 fs/umsdos/inode.c                 |    6 ++++--
 fs/xfs/linux-2.6/xfs_super.c      |    4 +++-
 include/linux/affs_fs.h           |    2 +-
 include/linux/ext3_fs.h           |    2 +-
 include/linux/fs.h                |    2 +-
 include/linux/msdos_fs.h          |    2 +-
 include/linux/reiserfs_fs.h       |    2 +-
 include/linux/ufs_fs.h            |    2 +-
 38 files changed, 106 insertions(+), 101 deletions(-)

===== Documentation/filesystems/Locking 1.49 vs edited =====
--- 1.49/Documentation/filesystems/Locking	2004-08-15 00:07:11 +04:00
+++ edited/Documentation/filesystems/Locking	2004-09-10 18:34:42 +04:00
@@ -90,7 +90,7 @@ prototypes:
 	void (*destroy_inode)(struct inode *);
 	void (*read_inode) (struct inode *);
 	void (*dirty_inode) (struct inode *);
-	void (*write_inode) (struct inode *, int);
+	int (*write_inode) (struct inode *, int);
 	void (*put_inode) (struct inode *);
 	void (*drop_inode) (struct inode *);
 	void (*delete_inode) (struct inode *);
===== Documentation/filesystems/vfs.txt 1.5 vs edited =====
--- 1.5/Documentation/filesystems/vfs.txt	2003-02-24 23:16:14 +03:00
+++ edited/Documentation/filesystems/vfs.txt	2004-09-10 18:34:42 +04:00
@@ -176,7 +176,7 @@ filesystem. As of kernel 2.1.99, the fol
 
 struct super_operations {
 	void (*read_inode) (struct inode *);
-	void (*write_inode) (struct inode *, int);
+	int (*write_inode) (struct inode *, int);
 	void (*put_inode) (struct inode *);
 	void (*drop_inode) (struct inode *);
 	void (*delete_inode) (struct inode *);
===== fs/fs-writeback.c 1.62 vs edited =====
--- 1.62/fs/fs-writeback.c	2004-08-27 10:31:38 +04:00
+++ edited/fs/fs-writeback.c	2004-09-10 19:17:36 +04:00
@@ -133,10 +133,11 @@ out:
 
 EXPORT_SYMBOL(__mark_inode_dirty);
 
-static void write_inode(struct inode *inode, int sync)
+static int write_inode(struct inode *inode, int sync)
 {
 	if (inode->i_sb->s_op->write_inode && !is_bad_inode(inode))
-		inode->i_sb->s_op->write_inode(inode, sync);
+		return inode->i_sb->s_op->write_inode(inode, sync);
+	return 0;
 }
 
 /*
@@ -170,8 +171,11 @@ __sync_single_inode(struct inode *inode,
 	ret = do_writepages(mapping, wbc);
 
 	/* Don't write the inode if only I_DIRTY_PAGES was set */
-	if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
-		write_inode(inode, wait);
+	if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC)) {
+		int err = write_inode(inode, wait);
+		if (ret == 0)
+			ret = err;
+	}
 
 	if (wait) {
 		int err = filemap_fdatawait(mapping);
===== fs/adfs/adfs.h 1.10 vs edited =====
--- 1.10/fs/adfs/adfs.h	2004-09-08 10:33:11 +04:00
+++ edited/fs/adfs/adfs.h	2004-09-10 18:34:42 +04:00
@@ -66,7 +66,7 @@ struct adfs_discmap {
 
 /* Inode stuff */
 struct inode *adfs_iget(struct super_block *sb, struct object_info *obj);
-void adfs_write_inode(struct inode *inode,int unused);
+int adfs_write_inode(struct inode *inode,int unused);
 int adfs_notify_change(struct dentry *dentry, struct iattr *attr);
 
 /* map.c */
===== fs/adfs/inode.c 1.21 vs edited =====
--- 1.21/fs/adfs/inode.c	2004-09-08 10:33:11 +04:00
+++ edited/fs/adfs/inode.c	2004-09-10 18:34:42 +04:00
@@ -373,10 +373,11 @@ out:
  * The adfs-specific inode data has already been updated by
  * adfs_notify_change()
  */
-void adfs_write_inode(struct inode *inode, int unused)
+int adfs_write_inode(struct inode *inode, int unused)
 {
 	struct super_block *sb = inode->i_sb;
 	struct object_info obj;
+	int ret;
 
 	lock_kernel();
 	obj.file_id	= inode->i_ino;
@@ -387,7 +388,8 @@ void adfs_write_inode(struct inode *inod
 	obj.attr	= ADFS_I(inode)->attr;
 	obj.size	= inode->i_size;
 
-	adfs_dir_update(sb, &obj);
+	ret = adfs_dir_update(sb, &obj);
 	unlock_kernel();
+	return ret;
 }
 MODULE_LICENSE("GPL");
===== fs/affs/inode.c 1.20 vs edited =====
--- 1.20/fs/affs/inode.c	2004-09-04 07:11:38 +04:00
+++ edited/fs/affs/inode.c	2004-09-10 18:34:42 +04:00
@@ -181,7 +181,7 @@ bad_inode:
 	return;
 }
 
-void
+int
 affs_write_inode(struct inode *inode, int unused)
 {
 	struct super_block	*sb = inode->i_sb;
@@ -194,11 +194,11 @@ affs_write_inode(struct inode *inode, in
 
 	if (!inode->i_nlink)
 		// possibly free block
-		return;
+		return 0;
 	bh = affs_bread(sb, inode->i_ino);
 	if (!bh) {
 		affs_error(sb,"write_inode","Cannot read block %lu",inode->i_ino);
-		return;
+		return -EIO;
 	}
 	tail = AFFS_TAIL(sb, bh);
 	if (tail->stype == cpu_to_be32(ST_ROOT)) {
@@ -226,6 +226,7 @@ affs_write_inode(struct inode *inode, in
 	mark_buffer_dirty_inode(bh, inode);
 	affs_brelse(bh);
 	affs_free_prealloc(inode);
+	return 0;
 }
 
 int
===== fs/bfs/inode.c 1.29 vs edited =====
--- 1.29/fs/bfs/inode.c	2004-08-24 13:08:53 +04:00
+++ edited/fs/bfs/inode.c	2004-09-10 18:34:42 +04:00
@@ -85,7 +85,7 @@ static void bfs_read_inode(struct inode 
 	brelse(bh);
 }
 
-static void bfs_write_inode(struct inode * inode, int unused)
+static int bfs_write_inode(struct inode * inode, int unused)
 {
 	unsigned long ino = inode->i_ino;
 	struct bfs_inode * di;
@@ -94,7 +94,7 @@ static void bfs_write_inode(struct inode
 
 	if (ino < BFS_ROOT_INO || ino > BFS_SB(inode->i_sb)->si_lasti) {
 		printf("Bad inode number %s:%08lx\n", inode->i_sb->s_id, ino);
-		return;
+		return -EIO;
 	}
 
 	lock_kernel();
@@ -103,7 +103,7 @@ static void bfs_write_inode(struct inode
 	if (!bh) {
 		printf("Unable to read inode %s:%08lx\n", inode->i_sb->s_id, ino);
 		unlock_kernel();
-		return;
+		return -EIO;
 	}
 
 	off = (ino - BFS_ROOT_INO)%BFS_INODES_PER_BLOCK;
@@ -129,6 +129,7 @@ static void bfs_write_inode(struct inode
 	mark_buffer_dirty(bh);
 	brelse(bh);
 	unlock_kernel();
+	return 0;
 }
 
 static void bfs_delete_inode(struct inode * inode)
===== fs/ext2/ext2.h 1.20 vs edited =====
--- 1.20/fs/ext2/ext2.h	2004-09-04 04:22:32 +04:00
+++ edited/fs/ext2/ext2.h	2004-09-10 18:34:42 +04:00
@@ -115,7 +115,7 @@ extern unsigned long ext2_count_free (st
 
 /* inode.c */
 extern void ext2_read_inode (struct inode *);
-extern void ext2_write_inode (struct inode *, int);
+extern int ext2_write_inode (struct inode *, int);
 extern void ext2_put_inode (struct inode *);
 extern void ext2_delete_inode (struct inode *);
 extern int ext2_sync_inode (struct inode *);
===== fs/ext2/inode.c 1.78 vs edited =====
--- 1.78/fs/ext2/inode.c	2004-09-04 04:26:46 +04:00
+++ edited/fs/ext2/inode.c	2004-09-10 18:34:42 +04:00
@@ -1248,9 +1248,9 @@ static int ext2_update_inode(struct inod
 	return err;
 }
 
-void ext2_write_inode(struct inode *inode, int wait)
+int ext2_write_inode(struct inode *inode, int wait)
 {
-	ext2_update_inode(inode, wait);
+	return ext2_update_inode(inode, wait);
 }
 
 int ext2_sync_inode(struct inode *inode)
===== fs/ext3/inode.c 1.101 vs edited =====
--- 1.101/fs/ext3/inode.c	2004-08-27 10:31:38 +04:00
+++ edited/fs/ext3/inode.c	2004-09-10 18:34:42 +04:00
@@ -2745,21 +2745,21 @@ out_brelse:
  * `stuff()' is running, and the new i_size will be lost.  Plus the inode
  * will no longer be on the superblock's dirty inode list.
  */
-void ext3_write_inode(struct inode *inode, int wait)
+int ext3_write_inode(struct inode *inode, int wait)
 {
 	if (current->flags & PF_MEMALLOC)
-		return;
+		return 0;
 
 	if (ext3_journal_current_handle()) {
 		jbd_debug(0, "called recursively, non-PF_MEMALLOC!\n");
 		dump_stack();
-		return;
+		return -EIO;
 	}
 
 	if (!wait)
-		return;
+		return 0;
 
-	ext3_force_commit(inode->i_sb);
+	return ext3_force_commit(inode->i_sb);
 }
 
 /*
===== fs/fat/inode.c 1.100 vs edited =====
--- 1.100/fs/fat/inode.c	2004-09-05 03:04:54 +04:00
+++ edited/fs/fat/inode.c	2004-09-10 18:34:42 +04:00
@@ -1227,7 +1227,7 @@ static int fat_fill_inode(struct inode *
 	return 0;
 }
 
-void fat_write_inode(struct inode *inode, int wait)
+int fat_write_inode(struct inode *inode, int wait)
 {
 	struct super_block *sb = inode->i_sb;
 	struct buffer_head *bh;
@@ -1237,14 +1237,14 @@ void fat_write_inode(struct inode *inode
 retry:
 	i_pos = MSDOS_I(inode)->i_pos;
 	if (inode->i_ino == MSDOS_ROOT_INO || !i_pos) {
-		return;
+		return 0;
 	}
 	lock_kernel();
 	if (!(bh = sb_bread(sb, i_pos >> MSDOS_SB(sb)->dir_per_block_bits))) {
 		printk(KERN_ERR "FAT: unable to read inode block "
 		       "for updating (i_pos %lld)\n", i_pos);
 		unlock_kernel();
-		return /* -EIO */;
+		return -EIO;
 	}
 	spin_lock(&fat_inode_lock);
 	if (i_pos != MSDOS_I(inode)->i_pos) {
@@ -1277,6 +1277,7 @@ retry:
 	mark_buffer_dirty(bh);
 	brelse(bh);
 	unlock_kernel();
+	return 0;
 }
 
 
===== fs/hfs/hfs_fs.h 1.2 vs edited =====
--- 1.2/fs/hfs/hfs_fs.h	2004-08-23 12:14:59 +04:00
+++ edited/fs/hfs/hfs_fs.h	2004-09-10 18:34:42 +04:00
@@ -198,7 +198,7 @@ extern struct address_space_operations h
 
 extern struct inode *hfs_new_inode(struct inode *, struct qstr *, int);
 extern void hfs_inode_write_fork(struct inode *, struct hfs_extent *, u32 *, u32 *);
-extern void hfs_write_inode(struct inode *, int);
+extern int hfs_write_inode(struct inode *, int);
 extern int hfs_inode_setattr(struct dentry *, struct iattr *);
 extern void hfs_inode_read_fork(struct inode *inode, struct hfs_extent *ext,
 				u32 log_size, u32 phys_size, u32 clump_size);
===== fs/hfs/inode.c 1.17 vs edited =====
--- 1.17/fs/hfs/inode.c	2004-08-31 12:09:38 +04:00
+++ edited/fs/hfs/inode.c	2004-09-10 18:34:42 +04:00
@@ -381,7 +381,7 @@ void hfs_inode_write_fork(struct inode *
 					 HFS_SB(inode->i_sb)->alloc_blksz);
 }
 
-void hfs_write_inode(struct inode *inode, int unused)
+int hfs_write_inode(struct inode *inode, int unused)
 {
 	struct hfs_find_data fd;
 	hfs_cat_rec rec;
@@ -395,27 +395,27 @@ void hfs_write_inode(struct inode *inode
 			break;
 		case HFS_EXT_CNID:
 			hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
-			return;
+			return 0;
 		case HFS_CAT_CNID:
 			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
-			return;
+			return 0;
 		default:
 			BUG();
-			return;
+			return -EIO;
 		}
 	}
 
 	if (HFS_IS_RSRC(inode)) {
 		mark_inode_dirty(HFS_I(inode)->rsrc_inode);
-		return;
+		return 0;
 	}
 
 	if (!inode->i_nlink)
-		return;
+		return 0;
 
 	if (hfs_find_init(HFS_SB(inode->i_sb)->cat_tree, &fd))
 		/* panic? */
-		return;
+		return -EIO;
 
 	fd.search_key->cat = HFS_I(inode)->cat_key;
 	if (hfs_brec_find(&fd))
@@ -460,6 +460,7 @@ void hfs_write_inode(struct inode *inode
 	}
 out:
 	hfs_find_exit(&fd);
+	return 0;
 }
 
 static struct dentry *hfs_file_lookup(struct inode *dir, struct dentry *dentry,
===== fs/hfsplus/hfsplus_fs.h 1.2 vs edited =====
--- 1.2/fs/hfsplus/hfsplus_fs.h	2004-08-23 12:14:59 +04:00
+++ edited/fs/hfsplus/hfsplus_fs.h	2004-09-10 18:34:42 +04:00
@@ -333,7 +333,7 @@ extern struct address_space_operations h
 void hfsplus_inode_read_fork(struct inode *, struct hfsplus_fork_raw *);
 void hfsplus_inode_write_fork(struct inode *, struct hfsplus_fork_raw *);
 int hfsplus_cat_read_inode(struct inode *, struct hfs_find_data *);
-void hfsplus_cat_write_inode(struct inode *);
+int hfsplus_cat_write_inode(struct inode *);
 struct inode *hfsplus_new_inode(struct super_block *, int);
 void hfsplus_delete_inode(struct inode *);
 
===== fs/hfsplus/inode.c 1.6 vs edited =====
--- 1.6/fs/hfsplus/inode.c	2004-08-31 12:09:38 +04:00
+++ edited/fs/hfsplus/inode.c	2004-09-10 18:34:42 +04:00
@@ -484,22 +484,22 @@ int hfsplus_cat_read_inode(struct inode 
 	return res;
 }
 
-void hfsplus_cat_write_inode(struct inode *inode)
+int hfsplus_cat_write_inode(struct inode *inode)
 {
 	struct hfs_find_data fd;
 	hfsplus_cat_entry entry;
 
 	if (HFSPLUS_IS_RSRC(inode)) {
 		mark_inode_dirty(HFSPLUS_I(inode).rsrc_inode);
-		return;
+		return 0;
 	}
 
 	if (!inode->i_nlink)
-		return;
+		return 0;
 
 	if (hfs_find_init(HFSPLUS_SB(inode->i_sb).cat_tree, &fd))
 		/* panic? */
-		return;
+		return -EIO;
 
 	if (hfsplus_find_cat(inode->i_sb, inode->i_ino, &fd))
 		/* panic? */
@@ -547,4 +547,5 @@ void hfsplus_cat_write_inode(struct inod
 	}
 out:
 	hfs_find_exit(&fd);
+	return 0;
 }
===== fs/hfsplus/super.c 1.2 vs edited =====
--- 1.2/fs/hfsplus/super.c	2004-03-04 18:15:12 +03:00
+++ edited/fs/hfsplus/super.c	2004-09-10 18:42:33 +04:00
@@ -94,20 +94,20 @@ static void hfsplus_read_inode(struct in
 	make_bad_inode(inode);
 }
 
-void hfsplus_write_inode(struct inode *inode, int unused)
+int hfsplus_write_inode(struct inode *inode, int unused)
 {
 	struct hfsplus_vh *vhdr;
+	int ret = 0;
 
 	dprint(DBG_INODE, "hfsplus_write_inode: %lu\n", inode->i_ino);
 	hfsplus_ext_write_extent(inode);
 	if (inode->i_ino >= HFSPLUS_FIRSTUSER_CNID) {
-		hfsplus_cat_write_inode(inode);
-		return;
+		return hfsplus_cat_write_inode(inode);
 	}
 	vhdr = HFSPLUS_SB(inode->i_sb).s_vhdr;
 	switch (inode->i_ino) {
 	case HFSPLUS_ROOT_CNID:
-		hfsplus_cat_write_inode(inode);
+		ret = hfsplus_cat_write_inode(inode);
 		break;
 	case HFSPLUS_EXT_CNID:
 		if (vhdr->ext_file.total_size != cpu_to_be64(inode->i_size)) {
@@ -148,6 +148,7 @@ void hfsplus_write_inode(struct inode *i
 		hfs_btree_write(HFSPLUS_SB(inode->i_sb).attr_tree);
 		break;
 	}
+	return ret;
 }
 
 static void hfsplus_clear_inode(struct inode *inode)
===== fs/jfs/inode.c 1.40 vs edited =====
--- 1.40/fs/jfs/inode.c	2004-08-18 23:32:20 +04:00
+++ edited/fs/jfs/inode.c	2004-09-10 18:42:33 +04:00
@@ -106,10 +106,10 @@ int jfs_commit_inode(struct inode *inode
 	return rc;
 }
 
-void jfs_write_inode(struct inode *inode, int wait)
+int jfs_write_inode(struct inode *inode, int wait)
 {
 	if (test_cflag(COMMIT_Nolink, inode))
-		return;
+		return 0;
 	/*
 	 * If COMMIT_DIRTY is not set, the inode isn't really dirty.
 	 * It has been committed since the last change, but was still
@@ -118,12 +118,14 @@ void jfs_write_inode(struct inode *inode
 	 if (!test_cflag(COMMIT_Dirty, inode)) {
 		/* Make sure committed changes hit the disk */
 		jfs_flush_journal(JFS_SBI(inode->i_sb)->log, wait);
-		return;
+		return 0;
 	 }
 
 	if (jfs_commit_inode(inode, wait)) {
 		jfs_err("jfs_write_inode: jfs_commit_inode failed!");
-	}
+		return -EIO;
+	} else
+		return 0;
 }
 
 void jfs_delete_inode(struct inode *inode)
===== fs/jfs/super.c 1.55 vs edited =====
--- 1.55/fs/jfs/super.c	2004-08-24 13:08:54 +04:00
+++ edited/fs/jfs/super.c	2004-09-10 18:42:33 +04:00
@@ -77,7 +77,7 @@ extern int jfs_sync(void *);
 extern void jfs_read_inode(struct inode *inode);
 extern void jfs_dirty_inode(struct inode *inode);
 extern void jfs_delete_inode(struct inode *inode);
-extern void jfs_write_inode(struct inode *inode, int wait);
+extern int jfs_write_inode(struct inode *inode, int wait);
 
 extern struct dentry *jfs_get_parent(struct dentry *dentry);
 extern int jfs_extendfs(struct super_block *, s64, int);
===== fs/minix/inode.c 1.42 vs edited =====
--- 1.42/fs/minix/inode.c	2004-08-24 13:08:53 +04:00
+++ edited/fs/minix/inode.c	2004-09-10 18:42:33 +04:00
@@ -18,7 +18,7 @@
 #include <linux/vfs.h>
 
 static void minix_read_inode(struct inode * inode);
-static void minix_write_inode(struct inode * inode, int wait);
+static int minix_write_inode(struct inode * inode, int wait);
 static int minix_statfs(struct super_block *sb, struct kstatfs *buf);
 static int minix_remount (struct super_block * sb, int * flags, char * data);
 
@@ -505,9 +505,10 @@ static struct buffer_head *minix_update_
 		return V2_minix_update_inode(inode);
 }
 
-static void minix_write_inode(struct inode * inode, int wait)
+static int minix_write_inode(struct inode * inode, int wait)
 {
 	brelse(minix_update_inode(inode));
+	return 0;
 }
 
 int minix_sync_inode(struct inode * inode)
===== fs/nfs/inode.c 1.120 vs edited =====
--- 1.120/fs/nfs/inode.c	2004-09-02 23:43:48 +04:00
+++ edited/fs/nfs/inode.c	2004-09-10 18:42:33 +04:00
@@ -57,7 +57,7 @@ static int nfs_update_inode(struct inode
 
 static struct inode *nfs_alloc_inode(struct super_block *sb);
 static void nfs_destroy_inode(struct inode *);
-static void nfs_write_inode(struct inode *,int);
+static int nfs_write_inode(struct inode *,int);
 static void nfs_delete_inode(struct inode *);
 static void nfs_clear_inode(struct inode *);
 static void nfs_umount_begin(struct super_block *);
@@ -110,12 +110,16 @@ nfs_fattr_to_ino_t(struct nfs_fattr *fat
 	return nfs_fileid_to_ino_t(fattr->fileid);
 }
 
-static void
+static int
 nfs_write_inode(struct inode *inode, int sync)
 {
 	int flags = sync ? FLUSH_WAIT : 0;
+	int ret;
 
-	nfs_commit_inode(inode, 0, 0, flags);
+	ret = nfs_commit_inode(inode, 0, 0, flags);
+	if (ret < 0)
+		return ret;
+	return 0;
 }
 
 static void
===== fs/ntfs/inode.c 1.126 vs edited =====
--- 1.126/fs/ntfs/inode.c	2004-08-24 01:37:03 +04:00
+++ edited/fs/ntfs/inode.c	2004-09-10 19:17:36 +04:00
@@ -2453,28 +2453,4 @@ err_out:
 	return err;
 }
 
-/**
- * ntfs_write_inode_vfs - write out a dirty inode
- * @vi:		inode to write out
- * @sync:	if true, write out synchronously
- *
- * Write out a dirty inode to disk including any extent inodes if present.
- *
- * If @sync is true, commit the inode to disk and wait for io completion.  This
- * is done using write_mft_record().
- *
- * If @sync is false, just schedule the write to happen but do not wait for i/o
- * completion.  In 2.6 kernels, scheduling usually happens just by virtue of
- * marking the page (and in this case mft record) dirty but we do not implement
- * this yet as write_mft_record() largely ignores the @sync parameter and
- * always performs synchronous writes.
- *
- * This functions does not have a return value which is the required behaviour
- * for the VFS super_operations ->dirty_inode function.
- */
-void ntfs_write_inode_vfs(struct inode *vi, int sync)
-{
-	ntfs_write_inode(vi, sync);
-}
-
 #endif /* NTFS_RW */
===== fs/ntfs/inode.h 1.40 vs edited =====
--- 1.40/fs/ntfs/inode.h	2004-07-22 13:47:15 +04:00
+++ edited/fs/ntfs/inode.h	2004-09-10 19:17:36 +04:00
@@ -286,7 +286,6 @@ extern void ntfs_truncate(struct inode *
 extern int ntfs_setattr(struct dentry *dentry, struct iattr *attr);
 
 extern int ntfs_write_inode(struct inode *vi, int sync);
-extern void ntfs_write_inode_vfs(struct inode *vi, int sync);
 
 static inline void ntfs_commit_inode(struct inode *vi)
 {
===== fs/ntfs/super.c 1.165 vs edited =====
--- 1.165/fs/ntfs/super.c	2004-08-27 10:41:48 +04:00
+++ edited/fs/ntfs/super.c	2004-09-10 19:17:36 +04:00
@@ -2157,7 +2157,7 @@ struct super_operations ntfs_sops = {
 #ifdef NTFS_RW
 	//.dirty_inode	= NULL,			/* VFS: Called from
 	//					   __mark_inode_dirty(). */
-	.write_inode	= ntfs_write_inode_vfs,	/* VFS: Write dirty inode to
+	.write_inode	= ntfs_write_inode,	/* VFS: Write dirty inode to
 						   disk. */
 	//.drop_inode	= NULL,			/* VFS: Called just after the
 	//					   inode reference count has
===== fs/qnx4/inode.c 1.35 vs edited =====
--- 1.35/fs/qnx4/inode.c	2004-08-24 13:08:53 +04:00
+++ edited/fs/qnx4/inode.c	2004-09-10 19:17:36 +04:00
@@ -78,7 +78,7 @@ static void qnx4_write_super(struct supe
 	unlock_kernel();
 }
 
-static void qnx4_write_inode(struct inode *inode, int unused)
+static int qnx4_write_inode(struct inode *inode, int unused)
 {
 	struct qnx4_inode_entry *raw_inode;
 	int block, ino;
@@ -87,12 +87,12 @@ static void qnx4_write_inode(struct inod
 
 	QNX4DEBUG(("qnx4: write inode 1.\n"));
 	if (inode->i_nlink == 0) {
-		return;
+		return 0;
 	}
 	if (!ino) {
 		printk("qnx4: bad inode number on dev %s: %d is out of range\n",
 		       inode->i_sb->s_id, ino);
-		return;
+		return -EIO;
 	}
 	QNX4DEBUG(("qnx4: write inode 2.\n"));
 	block = ino / QNX4_INODES_PER_BLOCK;
@@ -101,7 +101,7 @@ static void qnx4_write_inode(struct inod
 		printk("qnx4: major problem: unable to read inode from dev "
 		       "%s\n", inode->i_sb->s_id);
 		unlock_kernel();
-		return;
+		return -EIO;
 	}
 	raw_inode = ((struct qnx4_inode_entry *) bh->b_data) +
 	    (ino % QNX4_INODES_PER_BLOCK);
@@ -117,6 +117,7 @@ static void qnx4_write_inode(struct inod
 	mark_buffer_dirty(bh);
 	brelse(bh);
 	unlock_kernel();
+	return 0;
 }
 
 #endif
===== fs/reiserfs/inode.c 1.109 vs edited =====
--- 1.109/fs/reiserfs/inode.c	2004-07-12 12:00:53 +04:00
+++ edited/fs/reiserfs/inode.c	2004-09-10 19:17:36 +04:00
@@ -1504,7 +1504,7 @@ int reiserfs_encode_fh(struct dentry *de
 ** to properly mark inodes for datasync and such, but only actually
 ** does something when called for a synchronous update.
 */
-void reiserfs_write_inode (struct inode * inode, int do_sync) {
+int reiserfs_write_inode (struct inode * inode, int do_sync) {
     struct reiserfs_transaction_handle th ;
     int jbegin_count = 1 ;
 
@@ -1512,7 +1512,7 @@ void reiserfs_write_inode (struct inode 
         reiserfs_warning (inode->i_sb,
 			  "clm-6005: writing inode %lu on readonly FS",
 			  inode->i_ino) ;
-        return ;
+        return -EROFS;
     }
     /* memory pressure can sometimes initiate write_inode calls with sync == 1,
     ** these cases are just when the system needs ram, not when the 
@@ -1526,6 +1526,7 @@ void reiserfs_write_inode (struct inode 
 	journal_end_sync(&th, inode->i_sb, jbegin_count) ;
 	reiserfs_write_unlock(inode->i_sb);
     }
+    return 0;
 }
 
 /* FIXME: no need any more. right? */
===== fs/sysv/inode.c 1.34 vs edited =====
--- 1.34/fs/sysv/inode.c	2004-08-24 13:08:53 +04:00
+++ edited/fs/sysv/inode.c	2004-09-10 19:17:36 +04:00
@@ -260,13 +260,14 @@ static struct buffer_head * sysv_update_
 	return bh;
 }
 
-void sysv_write_inode(struct inode * inode, int wait)
+int sysv_write_inode(struct inode * inode, int wait)
 {
 	struct buffer_head *bh;
 	lock_kernel();
 	bh = sysv_update_inode(inode);
 	brelse(bh);
 	unlock_kernel();
+	return 0;
 }
 
 int sysv_sync_inode(struct inode * inode)
===== fs/sysv/sysv.h 1.5 vs edited =====
--- 1.5/fs/sysv/sysv.h	2004-04-16 19:39:35 +04:00
+++ edited/fs/sysv/sysv.h	2004-09-10 19:17:36 +04:00
@@ -134,7 +134,7 @@ extern unsigned long sysv_count_free_blo
 extern void sysv_truncate(struct inode *);
 
 /* inode.c */
-extern void sysv_write_inode(struct inode *, int);
+extern int sysv_write_inode(struct inode *, int);
 extern int sysv_sync_inode(struct inode *);
 extern int sysv_sync_file(struct file *, struct dentry *, int);
 extern void sysv_set_inode(struct inode *, dev_t);
===== fs/udf/inode.c 1.41 vs edited =====
--- 1.41/fs/udf/inode.c	2004-09-09 23:04:34 +04:00
+++ edited/fs/udf/inode.c	2004-09-10 19:17:36 +04:00
@@ -1316,11 +1316,13 @@ udf_convert_permissions(struct fileEntry
  *	Written, tested, and released.
  */
 
-void udf_write_inode(struct inode * inode, int sync)
+int udf_write_inode(struct inode * inode, int sync)
 {
+	int ret;
 	lock_kernel();
-	udf_update_inode(inode, sync);
+	ret = udf_update_inode(inode, sync);
 	unlock_kernel();
+	return ret;
 }
 
 int udf_sync_inode(struct inode * inode)
===== fs/udf/udfdecl.h 1.17 vs edited =====
--- 1.17/fs/udf/udfdecl.h	2004-09-09 22:49:06 +04:00
+++ edited/fs/udf/udfdecl.h	2004-09-10 19:17:36 +04:00
@@ -99,7 +99,7 @@ extern void udf_read_inode(struct inode 
 extern void udf_put_inode(struct inode *);
 extern void udf_delete_inode(struct inode *);
 extern void udf_clear_inode(struct inode *);
-extern void udf_write_inode(struct inode *, int);
+extern int udf_write_inode(struct inode *, int);
 extern long udf_block_map(struct inode *, long);
 extern int8_t inode_bmap(struct inode *, int, kernel_lb_addr *, uint32_t *, kernel_lb_addr *, uint32_t *, uint32_t *, struct buffer_head **);
 extern int8_t udf_add_aext(struct inode *, kernel_lb_addr *, int *, kernel_lb_addr, uint32_t, struct buffer_head **, int);
===== fs/ufs/inode.c 1.23 vs edited =====
--- 1.23/fs/ufs/inode.c	2004-04-13 19:46:51 +04:00
+++ edited/fs/ufs/inode.c	2004-09-10 19:17:36 +04:00
@@ -788,11 +788,13 @@ static int ufs_update_inode(struct inode
 	return 0;
 }
 
-void ufs_write_inode (struct inode * inode, int wait)
+int ufs_write_inode (struct inode * inode, int wait)
 {
+	int ret;
 	lock_kernel();
-	ufs_update_inode (inode, wait);
+	ret = ufs_update_inode (inode, wait);
 	unlock_kernel();
+	return ret;
 }
 
 int ufs_sync_inode (struct inode *inode)
===== fs/umsdos/inode.c 1.14 vs edited =====
--- 1.14/fs/umsdos/inode.c	2002-11-05 18:35:59 +03:00
+++ edited/fs/umsdos/inode.c	2004-09-10 19:17:36 +04:00
@@ -312,11 +312,12 @@ out:
 /*
  * Update the disk with the inode content
  */
-void UMSDOS_write_inode (struct inode *inode, int wait)
+int UMSDOS_write_inode (struct inode *inode, int wait)
 {
 	struct iattr newattrs;
+	int ret;
 
-	fat_write_inode (inode, wait);
+	ret = fat_write_inode (inode, wait);
 	newattrs.ia_mtime = inode->i_mtime;
 	newattrs.ia_atime = inode->i_atime;
 	newattrs.ia_ctime = inode->i_ctime;
@@ -330,6 +331,7 @@ void UMSDOS_write_inode (struct inode *i
  * UMSDOS_notify_change (inode, &newattrs);
 
  * inode->i_state &= ~I_DIRTY; / * FIXME: this doesn't work.  We need to remove ourselves from list on dirty inodes. /mn/ */
+	return ret;
 }
 
 
===== fs/xfs/linux-2.6/xfs_super.c 1.87 vs edited =====
--- 1.87/fs/xfs/linux-2.6/xfs_super.c	2004-08-24 13:08:53 +04:00
+++ edited/fs/xfs/linux-2.6/xfs_super.c	2004-09-10 19:17:36 +04:00
@@ -356,7 +356,7 @@ destroy_inodecache( void )
  * at the point when it is unpinned after a log write,
  * since this is when the inode itself becomes flushable. 
  */
-STATIC void
+STATIC int
 linvfs_write_inode(
 	struct inode		*inode,
 	int			sync)
@@ -364,12 +364,14 @@ linvfs_write_inode(
 	vnode_t			*vp = LINVFS_GET_VP(inode);
 	int			error, flags = FLUSH_INODE;
 
+	error = 0;
 	if (vp) {
 		vn_trace_entry(vp, __FUNCTION__, (inst_t *)__return_address);
 		if (sync)
 			flags |= FLUSH_SYNC;
 		VOP_IFLUSH(vp, flags, error);
 	}
+	return error;
 }
 
 STATIC void
===== include/linux/affs_fs.h 1.8 vs edited =====
--- 1.8/include/linux/affs_fs.h	2004-09-08 10:33:12 +04:00
+++ edited/include/linux/affs_fs.h	2004-09-10 19:17:36 +04:00
@@ -62,7 +62,7 @@ extern void			 affs_put_inode(struct ino
 extern void			 affs_delete_inode(struct inode *inode);
 extern void			 affs_clear_inode(struct inode *inode);
 extern void			 affs_read_inode(struct inode *inode);
-extern void			 affs_write_inode(struct inode *inode, int);
+extern int			 affs_write_inode(struct inode *inode, int);
 extern int			 affs_add_entry(struct inode *dir, struct inode *inode, struct dentry *dentry, s32 type);
 
 /* super.c */
===== include/linux/ext3_fs.h 1.32 vs edited =====
--- 1.32/include/linux/ext3_fs.h	2004-08-23 12:14:48 +04:00
+++ edited/include/linux/ext3_fs.h	2004-09-10 19:17:36 +04:00
@@ -724,7 +724,7 @@ extern struct buffer_head * ext3_getblk 
 extern struct buffer_head * ext3_bread (handle_t *, struct inode *, int, int, int *);
 
 extern void ext3_read_inode (struct inode *);
-extern void ext3_write_inode (struct inode *, int);
+extern int  ext3_write_inode (struct inode *, int);
 extern int  ext3_setattr (struct dentry *, struct iattr *);
 extern void ext3_put_inode (struct inode *);
 extern void ext3_delete_inode (struct inode *);
===== include/linux/fs.h 1.345 vs edited =====
--- 1.345/include/linux/fs.h	2004-09-08 10:33:13 +04:00
+++ edited/include/linux/fs.h	2004-09-10 19:17:36 +04:00
@@ -960,7 +960,7 @@ struct super_operations {
 	void (*read_inode) (struct inode *);
   
    	void (*dirty_inode) (struct inode *);
-	void (*write_inode) (struct inode *, int);
+	int (*write_inode) (struct inode *, int);
 	void (*put_inode) (struct inode *);
 	void (*drop_inode) (struct inode *);
 	void (*delete_inode) (struct inode *);
===== include/linux/msdos_fs.h 1.36 vs edited =====
--- 1.36/include/linux/msdos_fs.h	2004-09-05 01:51:33 +04:00
+++ edited/include/linux/msdos_fs.h	2004-09-10 19:17:36 +04:00
@@ -276,7 +276,7 @@ extern void fat_put_super(struct super_b
 int fat_fill_super(struct super_block *sb, void *data, int silent,
 		   struct inode_operations *fs_dir_inode_ops, int isvfat);
 extern int fat_statfs(struct super_block *sb, struct kstatfs *buf);
-extern void fat_write_inode(struct inode *inode, int wait);
+extern int fat_write_inode(struct inode *inode, int wait);
 extern int fat_notify_change(struct dentry * dentry, struct iattr * attr);
 
 /* fat/misc.c */
===== include/linux/reiserfs_fs.h 1.72 vs edited =====
--- 1.72/include/linux/reiserfs_fs.h	2004-08-24 04:57:02 +04:00
+++ edited/include/linux/reiserfs_fs.h	2004-09-10 19:17:36 +04:00
@@ -1945,7 +1945,7 @@ void reiserfs_read_locked_inode(struct i
 int reiserfs_find_actor(struct inode * inode, void *p) ;
 int reiserfs_init_locked_inode(struct inode * inode, void *p) ;
 void reiserfs_delete_inode (struct inode * inode);
-void reiserfs_write_inode (struct inode * inode, int) ;
+int reiserfs_write_inode (struct inode * inode, int) ;
 struct dentry *reiserfs_get_dentry(struct super_block *, void *) ;
 struct dentry *reiserfs_decode_fh(struct super_block *sb, __u32 *data,
                                      int len, int fhtype,
===== include/linux/ufs_fs.h 1.12 vs edited =====
--- 1.12/include/linux/ufs_fs.h	2004-09-08 10:33:16 +04:00
+++ edited/include/linux/ufs_fs.h	2004-09-10 19:17:36 +04:00
@@ -898,7 +898,7 @@ extern struct inode * ufs_new_inode (str
 extern u64  ufs_frag_map (struct inode *, sector_t);
 extern void ufs_read_inode (struct inode *);
 extern void ufs_put_inode (struct inode *);
-extern void ufs_write_inode (struct inode *, int);
+extern int ufs_write_inode (struct inode *, int);
 extern int ufs_sync_inode (struct inode *);
 extern void ufs_delete_inode (struct inode *);
 extern struct buffer_head * ufs_getfrag (struct inode *, unsigned, int, int *);
