Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289197AbSAGN1C>; Mon, 7 Jan 2002 08:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289191AbSAGNWH>; Mon, 7 Jan 2002 08:22:07 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:38029 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S289192AbSAGNV2>;
	Mon, 7 Jan 2002 08:21:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: torvalds@transmeta.com, viro@math.psu.edu, phillips@bonn-fries.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: PATCH 2.5.2.9: ext2 unbork fs.h (part 7/7)
Message-Id: <20020107132122.F25FE1F70@gtf.org>
Date: Mon,  7 Jan 2002 07:21:22 -0600 (CST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch7 desc: implement ext2 use of s_op->{alloc,destroy}





diff -Naur -X /g/g/lib/dontdiff linux-fs6/fs/ext2/ext2_fs.h linux-fs7/fs/ext2/ext2_fs.h
--- linux-fs6/fs/ext2/ext2_fs.h	Mon Jan  7 07:54:33 2002
+++ linux-fs7/fs/ext2/ext2_fs.h	Mon Jan  7 08:28:12 2002
@@ -596,7 +596,8 @@
 extern int ext2_sync_inode (struct inode *);
 extern void ext2_discard_prealloc (struct inode *);
 extern void ext2_truncate (struct inode *);
-extern void ext2_clear_inode (struct inode *inode);
+extern struct inode *ext2_alloc_inode (struct super_block *sb);
+extern void ext2_destroy_inode (struct inode *inode);
 
 /* ioctl.c */
 extern int ext2_ioctl (struct inode *, struct file *, unsigned int,
diff -Naur -X /g/g/lib/dontdiff linux-fs6/fs/ext2/ext2_fs_i.h linux-fs7/fs/ext2/ext2_fs_i.h
--- linux-fs6/fs/ext2/ext2_fs_i.h	Mon Sep 17 20:16:30 2001
+++ linux-fs7/fs/ext2/ext2_fs_i.h	Mon Jan  7 05:08:38 2002
@@ -36,6 +36,10 @@
 	__u32	i_prealloc_count;
 	__u32	i_dir_start_lookup;
 	int	i_new_inode:1;	/* Is a freshly allocated inode */
+
+#ifdef __KERNEL__
+	struct inode i_inode_data;
+#endif
 };
 
 #endif	/* _LINUX_EXT2_FS_I */
diff -Naur -X /g/g/lib/dontdiff linux-fs6/fs/ext2/ialloc.c linux-fs7/fs/ext2/ialloc.c
--- linux-fs6/fs/ext2/ialloc.c	Mon Jan  7 08:58:19 2002
+++ linux-fs7/fs/ext2/ialloc.c	Mon Jan  7 08:28:54 2002
@@ -335,18 +335,7 @@
 	inode = new_inode(sb);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-
-	/* allocate private per-inode info.  note that for
-	 * the error cases below, iput and s_op->clear_inode
-	 * will handle freeing the private area.
-	 */
-	inode->u.ext2_ip = kmem_cache_alloc(ext2_ino_cache, SLAB_NOFS);
-	if (!inode->u.ext2_ip) {
-		err = -ENOMEM;
-		goto no_priv;
-	}
-	ei = inode->u.ext2_ip;
-	memset(ei, 0, sizeof(*ei));
+	ei = ext2_i(inode);
 
 	lock_super (sb);
 
@@ -439,7 +428,6 @@
 	mark_buffer_dirty(bh2);
 fail:
 	unlock_super(sb);
-no_priv:
 	make_bad_inode(inode);
 	iput(inode);
 	return ERR_PTR(err);
diff -Naur -X /g/g/lib/dontdiff linux-fs6/fs/ext2/inode.c linux-fs7/fs/ext2/inode.c
--- linux-fs6/fs/ext2/inode.c	Mon Jan  7 09:20:19 2002
+++ linux-fs7/fs/ext2/inode.c	Mon Jan  7 12:24:15 2002
@@ -37,7 +37,7 @@
 MODULE_DESCRIPTION("Second Extended Filesystem");
 MODULE_LICENSE("GPL");
 
-
+extern void inode_init_once(void *, kmem_cache_t *, unsigned long);
 static int ext2_update_inode(struct inode * inode, int do_sync);
 
 /*
@@ -890,7 +890,7 @@
 {
 	struct super_block *sb = inode->i_sb;
 	struct ext2_sb_info *esb = ext2_sb(sb);
-	struct ext2_inode_info *ei;
+	struct ext2_inode_info *ei = ext2_i(inode);
 	struct buffer_head * bh;
 	struct ext2_inode * raw_inode;
 	unsigned long block_group;
@@ -900,12 +900,6 @@
 	unsigned long offset;
 	struct ext2_group_desc * gdp;
 
-	inode->u.ext2_ip = kmem_cache_alloc(ext2_ino_cache, SLAB_NOFS);
-	if (!inode->u.ext2_ip)
-		goto bad_inode;
-	ei = inode->u.ext2_ip;
-	memset(ei, 0, sizeof(*ei));
-
 	if ((inode->i_ino != EXT2_ROOT_INO && inode->i_ino != EXT2_ACL_IDX_INO &&
 	     inode->i_ino != EXT2_ACL_DATA_INO &&
 	     inode->i_ino < EXT2_FIRST_INO(sb)) ||
@@ -1034,10 +1028,6 @@
 	return;
 	
 bad_inode:
-	if (inode->u.ext2_ip) {
-		kmem_cache_free(ext2_ino_cache, inode->u.ext2_ip);
-		inode->u.ext2_ip = NULL;
-	}
 	make_bad_inode(inode);
 	return;
 }
@@ -1181,12 +1171,26 @@
 	return ext2_update_inode (inode, 1);
 }
 
-void ext2_clear_inode (struct inode *inode)
+struct inode *ext2_alloc_inode (struct super_block *sb)
 {
-	struct ext2_inode_info *ei = inode->u.ext2_ip;
+	struct ext2_inode_info *ei;
+	struct inode *inode;
 
-	if (ei) {
-		kmem_cache_free(ext2_ino_cache, ei);
-		inode->u.ext2_ip = NULL;
-	}
+	ei = kmem_cache_alloc(ext2_ino_cache, SLAB_NOFS);
+	if (!ei)
+		return NULL;
+	inode = &ei->i_inode_data;
+
+	memset(ei, 0, sizeof(*ei));
+	inode_init_once(inode, ext2_ino_cache, SLAB_CTOR_CONSTRUCTOR);
+
+	inode->u.ext2_ip = ei;	/* set self-ref */
+	return inode;
+}
+
+void ext2_destroy_inode (struct inode *inode)
+{
+	struct ext2_inode_info *ei = ext2_i(inode);
+	kmem_cache_free(ext2_ino_cache, ei);
 }
+
diff -Naur -X /g/g/lib/dontdiff linux-fs6/fs/ext2/super.c linux-fs7/fs/ext2/super.c
--- linux-fs6/fs/ext2/super.c	Mon Jan  7 07:32:50 2002
+++ linux-fs7/fs/ext2/super.c	Mon Jan  7 12:24:50 2002
@@ -160,7 +160,9 @@
 	write_inode:	ext2_write_inode,
 	put_inode:	ext2_put_inode,
 	delete_inode:	ext2_delete_inode,
-	clear_inode:	ext2_clear_inode,
+	alloc_inode:	ext2_alloc_inode,
+	destroy_inode:	ext2_destroy_inode,
+
 	put_super:	ext2_put_super,
 	write_super:	ext2_write_super,
 	statfs:		ext2_statfs,
diff -Naur -X /g/g/lib/dontdiff linux-fs6/include/linux/fs.h linux-fs7/include/linux/fs.h
--- linux-fs6/include/linux/fs.h	Mon Jan  7 07:50:14 2002
+++ linux-fs7/include/linux/fs.h	Mon Jan  7 08:41:12 2002
@@ -503,7 +503,7 @@
 		struct socket			socket_i;
 		struct jffs2_inode_info		jffs2_i;
 
-		struct ext2_inode_info		*ext2_ip;
+		struct ext2_inode_info		*ext2_ip;     /* ref to self */
 
 		void				*generic_ip;
 	} u;
