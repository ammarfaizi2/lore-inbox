Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289189AbSAGNcl>; Mon, 7 Jan 2002 08:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289200AbSAGNWD>; Mon, 7 Jan 2002 08:22:03 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37773 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S289191AbSAGNV1>;
	Mon, 7 Jan 2002 08:21:27 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: torvalds@transmeta.com, viro@math.psu.edu, phillips@bonn-fries.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: PATCH 2.5.2.9: ext2 unbork fs.h (part 6/7)
Message-Id: <20020107132122.E2E941F6F@gtf.org>
Date: Mon,  7 Jan 2002 07:21:22 -0600 (CST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patch6 desc: add sb->s_op->{alloc,destroy}_inode to VFS API



diff -Naur -X /g/g/lib/dontdiff linux-fs5/fs/Makefile linux-fs6/fs/Makefile
--- linux-fs5/fs/Makefile	Fri Nov 30 01:39:02 2001
+++ linux-fs6/fs/Makefile	Mon Jan  7 08:43:30 2002
@@ -7,7 +7,7 @@
 
 O_TARGET := fs.o
 
-export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o
+export-objs :=	filesystems.o open.o dcache.o buffer.o bio.o inode.o
 mod-subdirs :=	nls
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
diff -Naur -X /g/g/lib/dontdiff linux-fs5/fs/inode.c linux-fs6/fs/inode.c
--- linux-fs5/fs/inode.c	Sun Jan  6 23:29:19 2002
+++ linux-fs6/fs/inode.c	Mon Jan  7 12:37:41 2002
@@ -5,6 +5,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/mm.h>
@@ -75,12 +76,25 @@
 
 static kmem_cache_t * inode_cachep;
 
-#define alloc_inode() \
-	 ((struct inode *) kmem_cache_alloc(inode_cachep, SLAB_KERNEL))
+static struct inode *alloc_inode (struct super_block *sb)
+{
+	if (sb && sb->s_op && sb->s_op->alloc_inode)
+		return sb->s_op->alloc_inode(sb);
+
+	return kmem_cache_alloc(inode_cachep, SLAB_NOFS);
+}
+
 static void destroy_inode(struct inode *inode) 
 {
 	if (inode_has_buffers(inode))
 		BUG();
+
+	if (inode && inode->i_sb && inode->i_sb->s_op &&
+	    inode->i_sb->s_op->destroy_inode) {
+		inode->i_sb->s_op->destroy_inode(inode);
+		return;
+	}
+
 	kmem_cache_free(inode_cachep, (inode));
 }
 
@@ -90,7 +104,7 @@
  * once, because the fields are idempotent across use
  * of the inode, so let the slab aware of that.
  */
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+void inode_init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct inode * inode = (struct inode *) foo;
 
@@ -112,6 +126,7 @@
 		spin_lock_init(&inode->i_data.i_shared_lock);
 	}
 }
+EXPORT_SYMBOL(inode_init_once);
 
 /*
  * Put the inode on the super block's dirty list.
@@ -780,7 +795,12 @@
 	static struct address_space_operations empty_aops;
 	static struct inode_operations empty_iops;
 	static struct file_operations empty_fops;
-	memset(&inode->u, 0, sizeof(inode->u));
+
+	/* special case, 'u' may have been cleared/reset elsewhere */
+	if (!inode->i_sb || !inode->i_sb->s_op ||
+	    !inode->i_sb->s_op->alloc_inode)
+		memset(&inode->u, 0, sizeof(inode->u));
+
 	inode->i_sock = 0;
 	inode->i_op = &empty_iops;
 	inode->i_fop = &empty_fops;
@@ -812,22 +832,22 @@
  * lists.
  */
  
-struct inode * get_empty_inode(void)
+struct inode * get_empty_inode(struct super_block *sb)
 {
 	static unsigned long last_ino;
 	struct inode * inode;
 
 	spin_lock_prefetch(&inode_lock);
 	
-	inode = alloc_inode();
+	inode = alloc_inode(sb);
 	if (inode)
 	{
 		spin_lock(&inode_lock);
 		inodes_stat.nr_inodes++;
 		list_add(&inode->i_list, &inode_in_use);
-		inode->i_sb = NULL;
-		inode->i_dev = NODEV;
-		inode->i_blkbits = 0;
+		inode->i_sb = sb;
+                inode->i_dev = sb ? sb->s_dev : NODEV;
+                inode->i_blkbits = sb ? sb->s_blocksize_bits : 0;
 		inode->i_ino = ++last_ino;
 		inode->i_flags = 0;
 		atomic_set(&inode->i_count, 1);
@@ -848,7 +868,7 @@
 {
 	struct inode * inode;
 
-	inode = alloc_inode();
+	inode = alloc_inode(sb);
 	if (inode) {
 		struct inode * old;
 
@@ -1178,7 +1198,7 @@
 
 	/* inode slab cache */
 	inode_cachep = kmem_cache_create("inode_cache", sizeof(struct inode),
-					 0, SLAB_HWCACHE_ALIGN, init_once,
+					 0, SLAB_HWCACHE_ALIGN, inode_init_once,
 					 NULL);
 	if (!inode_cachep)
 		panic("cannot create inode slab cache");
diff -Naur -X /g/g/lib/dontdiff linux-fs5/include/linux/fs.h linux-fs6/include/linux/fs.h
--- linux-fs5/include/linux/fs.h	Mon Jan  7 07:50:01 2002
+++ linux-fs6/include/linux/fs.h	Mon Jan  7 07:50:14 2002
@@ -885,6 +885,8 @@
 	int (*remount_fs) (struct super_block *, int *, char *);
 	void (*clear_inode) (struct inode *);
 	void (*umount_begin) (struct super_block *);
+	struct inode * (*alloc_inode) (struct super_block *);
+	void (*destroy_inode) (struct inode *);
 
 	/* Following are for knfsd to interact with "interesting" filesystems
 	 * Currently just reiserfs, but possibly FAT and others later
@@ -1345,17 +1347,11 @@
 }
 
 extern void clear_inode(struct inode *);
-extern struct inode * get_empty_inode(void);
+extern struct inode * get_empty_inode(struct super_block *);
 
 static inline struct inode * new_inode(struct super_block *sb)
 {
-	struct inode *inode = get_empty_inode();
-	if (inode) {
-		inode->i_sb = sb;
-		inode->i_dev = sb->s_dev;
-		inode->i_blkbits = sb->s_blocksize_bits;
-	}
-	return inode;
+	return get_empty_inode(sb);
 }
 extern void remove_suid(struct inode *inode);
 
diff -Naur -X /g/g/lib/dontdiff linux-fs5/net/socket.c linux-fs6/net/socket.c
--- linux-fs5/net/socket.c	Wed Oct 17 21:38:28 2001
+++ linux-fs6/net/socket.c	Mon Jan  7 07:47:31 2002
@@ -440,7 +440,7 @@
 	struct inode * inode;
 	struct socket * sock;
 
-	inode = get_empty_inode();
+	inode = get_empty_inode(NULL);
 	if (!inode)
 		return NULL;
 
