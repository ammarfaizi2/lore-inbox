Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318750AbSIKMvk>; Wed, 11 Sep 2002 08:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318751AbSIKMvk>; Wed, 11 Sep 2002 08:51:40 -0400
Received: from verein.lst.de ([212.34.181.86]:30732 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S318750AbSIKMve>;
	Wed, 11 Sep 2002 08:51:34 -0400
Date: Wed, 11 Sep 2002 14:55:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: marcelo@conectiva.com.br
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] rework inode allocation to allow filesystems more control
Message-ID: <20020911145557.A13949@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, marcelo@conectiva.com.br,
	viro@math.psu.edu, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ->alloc_inode and ->destroy_inode super operations to
allow the filesystem control the allocation of struct inode, e.g. to
have it's private inode and the VFS one n the same slab cache.

This allows to break worst-offenders like NFS out of the big inode union
and make VM balancing better by wasting less ram for inodes.  It also
speedups filesystems that don't want to touch that union in struct
inode, like JFS, XFS or FreeVxFS (once switched over).  It is a straight
backport from Al's code in 2.5 and has proven stable in Red Hat's
recent beta releases (limbo, null).  Al has ACKed my patch submission.

NOTE: you want my b_inode removal patch applied before this one.


diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Thu Aug 29 03:02:23 2002
+++ b/fs/inode.c	Thu Aug 29 03:02:23 2002
@@ -75,13 +75,59 @@
 
 static kmem_cache_t * inode_cachep;
 
-#define alloc_inode() \
-	 ((struct inode *) kmem_cache_alloc(inode_cachep, SLAB_KERNEL))
+static struct inode *alloc_inode(struct super_block *sb)
+{
+	static struct address_space_operations empty_aops;
+	static struct inode_operations empty_iops;
+	static struct file_operations empty_fops;
+	struct inode *inode;
+
+	if (sb->s_op->alloc_inode)
+		inode = sb->s_op->alloc_inode(sb);
+	else {
+		inode = (struct inode *) kmem_cache_alloc(inode_cachep, SLAB_KERNEL);
+		/* will die */
+		if (inode)
+			memset(&inode->u, 0, sizeof(inode->u));
+	}
+
+	if (inode) {
+		struct address_space * const mapping = &inode->i_data;
+
+		inode->i_sb = sb;
+		inode->i_dev = sb->s_dev;
+		inode->i_blkbits = sb->s_blocksize_bits;
+		inode->i_flags = 0;
+		atomic_set(&inode->i_count, 1);
+		inode->i_sock = 0;
+		inode->i_op = &empty_iops;
+		inode->i_fop = &empty_fops;
+		inode->i_nlink = 1;
+		atomic_set(&inode->i_writecount, 0);
+		inode->i_size = 0;
+		inode->i_blocks = 0;
+		inode->i_generation = 0;
+		memset(&inode->i_dquot, 0, sizeof(inode->i_dquot));
+		inode->i_pipe = NULL;
+		inode->i_bdev = NULL;
+		inode->i_cdev = NULL;
+
+		mapping->a_ops = &empty_aops;
+		mapping->host = inode;
+		mapping->gfp_mask = GFP_HIGHUSER;
+		inode->i_mapping = mapping;
+	}
+	return inode;
+}
+
 static void destroy_inode(struct inode *inode) 
 {
 	if (inode_has_buffers(inode))
 		BUG();
-	kmem_cache_free(inode_cachep, (inode));
+	if (inode->i_sb->s_op->destroy_inode)
+		inode->i_sb->s_op->destroy_inode(inode);
+	else
+		kmem_cache_free(inode_cachep, inode);
 }
 
 
@@ -90,27 +136,30 @@
  * once, because the fields are idempotent across use
  * of the inode, so let the slab aware of that.
  */
+void inode_init_once(struct inode *inode)
+{
+	memset(inode, 0, sizeof(*inode));
+	init_waitqueue_head(&inode->i_wait);
+	INIT_LIST_HEAD(&inode->i_hash);
+	INIT_LIST_HEAD(&inode->i_data.clean_pages);
+	INIT_LIST_HEAD(&inode->i_data.dirty_pages);
+	INIT_LIST_HEAD(&inode->i_data.locked_pages);
+	INIT_LIST_HEAD(&inode->i_dentry);
+	INIT_LIST_HEAD(&inode->i_dirty_buffers);
+	INIT_LIST_HEAD(&inode->i_dirty_data_buffers);
+	INIT_LIST_HEAD(&inode->i_devices);
+	sema_init(&inode->i_sem, 1);
+	sema_init(&inode->i_zombie, 1);
+	spin_lock_init(&inode->i_data.i_shared_lock);
+}
+
 static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct inode * inode = (struct inode *) foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
-	{
-		memset(inode, 0, sizeof(*inode));
-		init_waitqueue_head(&inode->i_wait);
-		INIT_LIST_HEAD(&inode->i_hash);
-		INIT_LIST_HEAD(&inode->i_data.clean_pages);
-		INIT_LIST_HEAD(&inode->i_data.dirty_pages);
-		INIT_LIST_HEAD(&inode->i_data.locked_pages);
-		INIT_LIST_HEAD(&inode->i_dentry);
-		INIT_LIST_HEAD(&inode->i_dirty_buffers);
-		INIT_LIST_HEAD(&inode->i_dirty_data_buffers);
-		INIT_LIST_HEAD(&inode->i_devices);
-		sema_init(&inode->i_sem, 1);
-		sema_init(&inode->i_zombie, 1);
-		spin_lock_init(&inode->i_data.i_shared_lock);
-	}
+		inode_init_once(inode);
 }
 
 /*
@@ -757,72 +806,28 @@
 	return inode;
 }
 
-/*
- * This just initializes the inode fields
- * to known values before returning the inode..
- *
- * i_sb, i_ino, i_count, i_state and the lists have
- * been initialized elsewhere..
- */
-static void clean_inode(struct inode *inode)
-{
-	static struct address_space_operations empty_aops;
-	static struct inode_operations empty_iops;
-	static struct file_operations empty_fops;
-	memset(&inode->u, 0, sizeof(inode->u));
-	inode->i_sock = 0;
-	inode->i_op = &empty_iops;
-	inode->i_fop = &empty_fops;
-	inode->i_nlink = 1;
-	atomic_set(&inode->i_writecount, 0);
-	inode->i_size = 0;
-	inode->i_blocks = 0;
-	inode->i_generation = 0;
-	memset(&inode->i_dquot, 0, sizeof(inode->i_dquot));
-	inode->i_pipe = NULL;
-	inode->i_bdev = NULL;
-	inode->i_cdev = NULL;
-	inode->i_data.a_ops = &empty_aops;
-	inode->i_data.host = inode;
-	inode->i_data.gfp_mask = GFP_HIGHUSER;
-	inode->i_mapping = &inode->i_data;
-}
-
 /**
- * get_empty_inode 	- obtain an inode
+ *	new_inode 	- obtain an inode
+ *	@sb: superblock
  *
- * This is called by things like the networking layer
- * etc that want to get an inode without any inode
- * number, or filesystems that allocate new inodes with
- * no pre-existing information.
- *
- * On a successful return the inode pointer is returned. On a failure
- * a %NULL pointer is returned. The returned inode is not on any superblock
- * lists.
+ *	Allocates a new inode for given superblock.
  */
  
-struct inode * get_empty_inode(void)
+struct inode * new_inode(struct super_block *sb)
 {
 	static unsigned long last_ino;
 	struct inode * inode;
 
 	spin_lock_prefetch(&inode_lock);
 	
-	inode = alloc_inode();
-	if (inode)
-	{
+	inode = alloc_inode(sb);
+	if (inode) {
 		spin_lock(&inode_lock);
 		inodes_stat.nr_inodes++;
 		list_add(&inode->i_list, &inode_in_use);
-		inode->i_sb = NULL;
-		inode->i_dev = 0;
-		inode->i_blkbits = 0;
 		inode->i_ino = ++last_ino;
-		inode->i_flags = 0;
-		atomic_set(&inode->i_count, 1);
 		inode->i_state = 0;
 		spin_unlock(&inode_lock);
-		clean_inode(inode);
 	}
 	return inode;
 }
@@ -837,7 +842,7 @@
 {
 	struct inode * inode;
 
-	inode = alloc_inode();
+	inode = alloc_inode(sb);
 	if (inode) {
 		struct inode * old;
 
@@ -848,16 +853,9 @@
 			inodes_stat.nr_inodes++;
 			list_add(&inode->i_list, &inode_in_use);
 			list_add(&inode->i_hash, head);
-			inode->i_sb = sb;
-			inode->i_dev = sb->s_dev;
-			inode->i_blkbits = sb->s_blocksize_bits;
 			inode->i_ino = ino;
-			inode->i_flags = 0;
-			atomic_set(&inode->i_count, 1);
 			inode->i_state = I_LOCK;
 			spin_unlock(&inode_lock);
-
-			clean_inode(inode);
 
 			/* reiserfs specific hack right here.  We don't
 			** want this to last, and are looking for VFS changes
diff -Nru a/fs/super.c b/fs/super.c
--- a/fs/super.c	Thu Aug 29 03:02:23 2002
+++ b/fs/super.c	Thu Aug 29 03:02:23 2002
@@ -262,6 +262,7 @@
  */
 static struct super_block *alloc_super(void)
 {
+	static struct super_operations empty_sops = {};
 	struct super_block *s = kmalloc(sizeof(struct super_block),  GFP_USER);
 	if (s) {
 		memset(s, 0, sizeof(struct super_block));
@@ -279,6 +280,7 @@
 		sema_init(&s->s_dquot.dqio_sem, 1);
 		sema_init(&s->s_dquot.dqoff_sem, 1);
 		s->s_maxbytes = MAX_NON_LFS;
+		s->s_op = &empty_sops;
 	}
 	return s;
 }
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Thu Aug 29 03:02:23 2002
+++ b/include/linux/fs.h	Thu Aug 29 03:02:23 2002
@@ -873,6 +873,9 @@
  * without the big kernel lock held in all filesystems.
  */
 struct super_operations {
+   	struct inode *(*alloc_inode)(struct super_block *sb);
+	void (*destroy_inode)(struct inode *);
+
 	void (*read_inode) (struct inode *);
   
   	/* reiserfs kludge.  reiserfs needs 64 bits of information to
@@ -1336,6 +1339,7 @@
 #define user_path_walk(name,nd)	 __user_walk(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, nd)
 #define user_path_walk_link(name,nd) __user_walk(name, LOOKUP_POSITIVE, nd)
 
+extern void inode_init_once(struct inode *);
 extern void iput(struct inode *);
 extern void force_delete(struct inode *);
 extern struct inode * igrab(struct inode *);
@@ -1349,18 +1353,7 @@
 }
 
 extern void clear_inode(struct inode *);
-extern struct inode * get_empty_inode(void);
-
-static inline struct inode * new_inode(struct super_block *sb)
-{
-	struct inode *inode = get_empty_inode();
-	if (inode) {
-		inode->i_sb = sb;
-		inode->i_dev = sb->s_dev;
-		inode->i_blkbits = sb->s_blocksize_bits;
-	}
-	return inode;
-}
+extern struct inode *new_inode(struct super_block *sb);
 extern void remove_suid(struct inode *inode);
 
 extern void insert_inode_hash(struct inode *);
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Thu Aug 29 03:02:23 2002
+++ b/kernel/ksyms.c	Thu Aug 29 03:02:23 2002
@@ -138,6 +138,7 @@
 EXPORT_SYMBOL(iunique);
 EXPORT_SYMBOL(iget4);
 EXPORT_SYMBOL(iput);
+EXPORT_SYMBOL(inode_init_once);
 EXPORT_SYMBOL(force_delete);
 EXPORT_SYMBOL(follow_up);
 EXPORT_SYMBOL(follow_down);
@@ -518,7 +519,7 @@
 EXPORT_SYMBOL(init_special_inode);
 EXPORT_SYMBOL(read_ahead);
 EXPORT_SYMBOL(get_hash_table);
-EXPORT_SYMBOL(get_empty_inode);
+EXPORT_SYMBOL(new_inode);
 EXPORT_SYMBOL(insert_inode_hash);
 EXPORT_SYMBOL(remove_inode_hash);
 EXPORT_SYMBOL(buffer_insert_inode_queue);
diff -Nru a/net/socket.c b/net/socket.c
--- a/net/socket.c	Thu Aug 29 03:02:23 2002
+++ b/net/socket.c	Thu Aug 29 03:02:23 2002
@@ -437,11 +437,11 @@
 	struct inode * inode;
 	struct socket * sock;
 
-	inode = get_empty_inode();
+	inode = new_inode(sock_mnt->mnt_sb);
 	if (!inode)
 		return NULL;
 
-	inode->i_sb = sock_mnt->mnt_sb;
+	inode->i_dev = NODEV;
 	sock = socki_lookup(inode);
 
 	inode->i_mode = S_IFSOCK|S_IRWXUGO;
