Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289188AbSAGNWL>; Mon, 7 Jan 2002 08:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289199AbSAGNWA>; Mon, 7 Jan 2002 08:22:00 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:35725 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S289189AbSAGNV0>;
	Mon, 7 Jan 2002 08:21:26 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: torvalds@transmeta.com, viro@math.psu.edu, phillips@bonn-fries.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: PATCH 2.5.2.9: ext2 unbork fs.h (part 4/7)
Message-Id: <20020107132122.8CB9A1F6D@gtf.org>
Date: Mon,  7 Jan 2002 07:21:22 -0600 (CST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch4 desc: dynamically allocate inode->u.ext2_ip




diff -Naur -X /g/g/lib/dontdiff linux-fs3/fs/ext2/dir.c linux-fs4/fs/ext2/dir.c
--- linux-fs3/fs/ext2/dir.c	Mon Jan  7 01:53:55 2002
+++ linux-fs4/fs/ext2/dir.c	Mon Jan  7 02:01:30 2002
@@ -24,6 +24,7 @@
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
 #include <linux/ext2_fs_sb.h>
+#include <linux/ext2_fs_i.h>
 #include <linux/pagemap.h>
 
 typedef struct ext2_dir_entry_2 ext2_dirent;
diff -Naur -X /g/g/lib/dontdiff linux-fs3/fs/ext2/ialloc.c linux-fs4/fs/ext2/ialloc.c
--- linux-fs3/fs/ext2/ialloc.c	Mon Jan  7 01:54:10 2002
+++ linux-fs4/fs/ext2/ialloc.c	Mon Jan  7 08:57:52 2002
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
 #include <linux/ext2_fs_sb.h>
+#include <linux/ext2_fs_i.h>
 #include <linux/locks.h>
 #include <linux/quotaops.h>
 
@@ -316,7 +317,7 @@
 
 struct inode * ext2_new_inode (const struct inode * dir, int mode)
 {
-	const struct ext2_inode_info *di = &dir->u.ext2_i;
+	const struct ext2_inode_info *di = dir->u.ext2_ip;
 	struct ext2_inode_info *ei;
 	struct super_block * sb;
 	struct buffer_head * bh;
@@ -334,9 +335,22 @@
 	inode = new_inode(sb);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	ei = ext2_i(inode);
+
+	/* allocate private per-inode info.  note that for
+	 * the error cases below, iput and s_op->clear_inode
+	 * will handle freeing the private area.
+	 */
+	inode->u.ext2_ip = kmem_cache_alloc(ext2_ino_cache, SLAB_NOFS);
+	if (!inode->u.ext2_ip) {
+		err = -ENOMEM;
+		goto no_priv;
+	}
+	ei = inode->u.ext2_ip;
+	memset(ei, 0, sizeof(*ei));
 
 	lock_super (sb);
+
+
 	es = esb->s_es;
 repeat:
 	if (S_ISDIR(mode))
@@ -425,6 +439,7 @@
 	mark_buffer_dirty(bh2);
 fail:
 	unlock_super(sb);
+no_priv:
 	make_bad_inode(inode);
 	iput(inode);
 	return ERR_PTR(err);
diff -Naur -X /g/g/lib/dontdiff linux-fs3/fs/ext2/inode.c linux-fs4/fs/ext2/inode.c
--- linux-fs3/fs/ext2/inode.c	Mon Jan  7 09:19:39 2002
+++ linux-fs4/fs/ext2/inode.c	Mon Jan  7 09:19:50 2002
@@ -25,6 +25,7 @@
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
 #include <linux/ext2_fs_sb.h>
+#include <linux/ext2_fs_i.h>
 #include <linux/locks.h>
 #include <linux/smp_lock.h>
 #include <linux/sched.h>
@@ -889,7 +890,7 @@
 {
 	struct super_block *sb = inode->i_sb;
 	struct ext2_sb_info *esb = ext2_sb(sb);
-	struct ext2_inode_info *ei = ext2_i(inode);
+	struct ext2_inode_info *ei;
 	struct buffer_head * bh;
 	struct ext2_inode * raw_inode;
 	unsigned long block_group;
@@ -899,6 +900,12 @@
 	unsigned long offset;
 	struct ext2_group_desc * gdp;
 
+	inode->u.ext2_ip = kmem_cache_alloc(ext2_ino_cache, SLAB_NOFS);
+	if (!inode->u.ext2_ip)
+		goto bad_inode;
+	ei = inode->u.ext2_ip;
+	memset(ei, 0, sizeof(*ei));
+
 	if ((inode->i_ino != EXT2_ROOT_INO && inode->i_ino != EXT2_ACL_IDX_INO &&
 	     inode->i_ino != EXT2_ACL_DATA_INO &&
 	     inode->i_ino < EXT2_FIRST_INO(sb)) ||
@@ -1027,6 +1034,10 @@
 	return;
 	
 bad_inode:
+	if (inode->u.ext2_ip) {
+		kmem_cache_free(ext2_ino_cache, inode->u.ext2_ip);
+		inode->u.ext2_ip = NULL;
+	}
 	make_bad_inode(inode);
 	return;
 }
@@ -1168,4 +1179,14 @@
 int ext2_sync_inode (struct inode *inode)
 {
 	return ext2_update_inode (inode, 1);
+}
+
+void ext2_clear_inode (struct inode *inode)
+{
+	struct ext2_inode_info *ei = inode->u.ext2_ip;
+
+	if (ei) {
+		kmem_cache_free(ext2_ino_cache, ei);
+		inode->u.ext2_ip = NULL;
+	}
 }
diff -Naur -X /g/g/lib/dontdiff linux-fs3/fs/ext2/ioctl.c linux-fs4/fs/ext2/ioctl.c
--- linux-fs3/fs/ext2/ioctl.c	Sun Jan  6 23:08:18 2002
+++ linux-fs4/fs/ext2/ioctl.c	Mon Jan  7 02:01:46 2002
@@ -9,6 +9,7 @@
 
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
+#include <linux/ext2_fs_i.h>
 #include <linux/sched.h>
 #include <asm/uaccess.h>
 
diff -Naur -X /g/g/lib/dontdiff linux-fs3/fs/ext2/namei.c linux-fs4/fs/ext2/namei.c
--- linux-fs3/fs/ext2/namei.c	Sun Jan  6 23:08:18 2002
+++ linux-fs4/fs/ext2/namei.c	Mon Jan  7 02:01:49 2002
@@ -31,6 +31,7 @@
 
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
+#include <linux/ext2_fs_i.h>
 #include <linux/pagemap.h>
 
 /*
diff -Naur -X /g/g/lib/dontdiff linux-fs3/fs/ext2/super.c linux-fs4/fs/ext2/super.c
--- linux-fs3/fs/ext2/super.c	Mon Jan  7 07:02:23 2002
+++ linux-fs4/fs/ext2/super.c	Mon Jan  7 07:03:16 2002
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
 #include <linux/ext2_fs_sb.h>
+#include <linux/ext2_fs_i.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/locks.h>
@@ -159,6 +160,7 @@
 	write_inode:	ext2_write_inode,
 	put_inode:	ext2_put_inode,
 	delete_inode:	ext2_delete_inode,
+	clear_inode:	ext2_clear_inode,
 	put_super:	ext2_put_super,
 	write_super:	ext2_write_super,
 	statfs:		ext2_statfs,
@@ -824,15 +826,22 @@
 }
 
 static DECLARE_FSTYPE_DEV(ext2_fs_type, "ext2", ext2_read_super);
+kmem_cache_t *ext2_ino_cache = NULL;
 
 static int __init init_ext2_fs(void)
 {
+	ext2_ino_cache = kmem_cache_create("ext2_ino",
+					   sizeof(struct ext2_inode_info),
+					   0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+	if (!ext2_ino_cache)
+		return -ENOMEM;
         return register_filesystem(&ext2_fs_type);
 }
 
 static void __exit exit_ext2_fs(void)
 {
 	unregister_filesystem(&ext2_fs_type);
+	kmem_cache_destroy(ext2_ino_cache);
 }
 
 EXPORT_NO_SYMBOLS;
diff -Naur -X /g/g/lib/dontdiff linux-fs3/fs/ext2/symlink.c linux-fs4/fs/ext2/symlink.c
--- linux-fs3/fs/ext2/symlink.c	Mon Jan  7 00:46:02 2002
+++ linux-fs4/fs/ext2/symlink.c	Mon Jan  7 02:01:55 2002
@@ -19,6 +19,7 @@
 
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
+#include <linux/ext2_fs_i.h>
 
 static int ext2_readlink(struct dentry *dentry, char *buffer, int buflen)
 {
diff -Naur -X /g/g/lib/dontdiff linux-fs3/include/linux/ext2_fs.h linux-fs4/include/linux/ext2_fs.h
--- linux-fs3/include/linux/ext2_fs.h	Mon Jan  7 08:00:23 2002
+++ linux-fs4/include/linux/ext2_fs.h	Mon Jan  7 07:06:38 2002
@@ -17,6 +17,7 @@
 #define _LINUX_EXT2_FS_H
 
 #include <linux/types.h>
+#include <linux/slab.h>
 
 /*
  * The second extended filesystem constants/structures
@@ -583,9 +584,9 @@
 
 static inline struct ext2_inode_info *ext2_i(struct inode *inode)
 {
-	if (!inode)
+	if (!inode->u.ext2_ip)
 		BUG();
-	return &inode->u.ext2_i;
+	return inode->u.ext2_ip;
 }
 
 extern void ext2_read_inode (struct inode *);
@@ -595,6 +596,7 @@
 extern int ext2_sync_inode (struct inode *);
 extern void ext2_discard_prealloc (struct inode *);
 extern void ext2_truncate (struct inode *);
+extern void ext2_clear_inode (struct inode *inode);
 
 /* ioctl.c */
 extern int ext2_ioctl (struct inode *, struct file *, unsigned int,
@@ -609,6 +611,7 @@
 	return sb->u.ext2_sbp;
 }
 
+extern kmem_cache_t *ext2_ino_cache;
 extern void ext2_error (struct super_block *, const char *, const char *, ...)
 	__attribute__ ((format (printf, 3, 4)));
 extern NORET_TYPE void ext2_panic (struct super_block *, const char *,
diff -Naur -X /g/g/lib/dontdiff linux-fs3/include/linux/fs.h linux-fs4/include/linux/fs.h
--- linux-fs3/include/linux/fs.h	Mon Jan  7 06:54:45 2002
+++ linux-fs4/include/linux/fs.h	Mon Jan  7 06:51:02 2002
@@ -287,7 +287,6 @@
 
 #include <linux/pipe_fs_i.h>
 #include <linux/minix_fs_i.h>
-#include <linux/ext2_fs_i.h>
 #include <linux/ext3_fs_i.h>
 #include <linux/hpfs_fs_i.h>
 #include <linux/ntfs_fs_i.h>
@@ -314,6 +313,8 @@
 #include <linux/jffs2_fs_i.h>
 #include <linux/cramfs_fs_sb.h>
 
+struct ext2_inode_info;
+
 /*
  * Attribute flags.  These should be or-ed together to figure out what
  * has been changed!
@@ -476,7 +477,6 @@
 	__u32			i_generation;
 	union {
 		struct minix_inode_info		minix_i;
-		struct ext2_inode_info		ext2_i;
 		struct ext3_inode_info		ext3_i;
 		struct hpfs_inode_info		hpfs_i;
 		struct ntfs_inode_info		ntfs_i;
@@ -502,6 +502,9 @@
 		struct proc_inode_info		proc_i;
 		struct socket			socket_i;
 		struct jffs2_inode_info		jffs2_i;
+
+		struct ext2_inode_info		*ext2_ip;
+
 		void				*generic_ip;
 	} u;
 };
