Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbTADBDa>; Fri, 3 Jan 2003 20:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267739AbTADBDa>; Fri, 3 Jan 2003 20:03:30 -0500
Received: from users.ccur.com ([208.248.32.211]:12432 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S264931AbTADBC4>;
	Fri, 3 Jan 2003 20:02:56 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200301040111.BAA00401@rudolph.ccur.com>
Subject: Re: 2.4.21-pre2 stalls out when running unixbench
To: akpm@digeo.com (Andrew Morton)
Date: Fri, 3 Jan 2003 20:11:04 -0500 (EST)
Cc: joe.korty@ccur.com (Joe Korty), sct@redhat.com, adilger@clusterfs.com,
       rusty@rustcorp.com.au, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, hch@sgi.com
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <3E15F2F5.356A933D@digeo.com> from "Andrew Morton" at Jan 03, 2003 12:30:45 PM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the previous episode of "travails of a geriatric kernel jock",
> Andrew Morton wrote:
> > 
> >  Unpatched 2.4.20 does the same thing.
> > 
> 
> No it doesn't.
> 
> Good news is that 2.4.20 plus recent ext3 fixes doesn't lock up
> either.


Hi Andrew,
I have continued to play with the problem, and have gathered more evidence.

Everything works (kinda) when I back out the attached 2.4.20-pre1
patches.  I am not sure how to uniquely identify patches in the BK
tree, so I have enclosed the full text of each at the end of this
letter.

A remaining problem are long stallouts not present in 2.4.20.  The
stallouts are of uniform duration, 20 seconds, triggered aperiodically.

To show the aperiodic nature of the stallouts, I've replaced my simple dot test:

    while true; do sync; sleep 1; echo -e '.\c'; done

with a new version that prints a newline each time sync(1) takes more than
three seconds to run:

    #!/bin/bash
    (
    while true; do
	sleep 1
	(sleep 3; echo) &
	child=$!
	sync
	printf .
	kill $child >/dev/null
    done
    ) 2>/dev/null

The dot output pattern for a long run (unmeasured but between 1/2 and
1 hr) looks like:

...............
.........................................................
......
.........................................................
......
.........................................................
........
.........................................................
......
.........................................................
......
.........................................................
........
.........................................................
......
.........................................................
......
.........................................................
........
.........................................................
......
.........................................................
......
.........................................................
.........
.........................................................
......
.........................................................
......
.........................................................
........
.........................................................
......
.........................................................
......
.........................................................
.........
.........................................................
......
.........................................................
......
.........................................................
........
.........................................................
......
..........................................................



# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.757.33.12 -> 1.757.33.13
#	      kernel/ksyms.c	1.65    -> 1.66   
#	  include/linux/fs.h	1.70    -> 1.71   
#	        net/socket.c	1.12    -> 1.12.1.1
#	          fs/super.c	1.46    -> 1.47   
#	          fs/inode.c	1.35    -> 1.36   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/29	hch@sgi.com	1.757.33.13
# [PATCH] backport 2.5 inode allocation changes
# 
# This patch adds ->alloc_inode and ->destroy_inode super operations to
# allow the filesystem control the allocation of struct inode, e.g. to
# have it's private inode and the VFS one n the same slab cache.
# 
# It allows to break worst-offenders like NFS out of the big inode union
# and make VM balancing better by wasting less ram for inodes.  It also
# speedups filesystems that don't want to touch that union in struct
# inode, like JFS, XFS or FreeVxFS (once switched over).  It is a straight
# backport from Al's code in 2.5 and has proven stable in Red Hat's
# recent beta releases (limbo, null).  Al has ACKed my patch submission.
# 
# Credits go to Daniel Phillips for the initial design.
# 
# NOTE: you want my b_inode removal patch applied before this one.
# --------------------------------------------
#
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Fri Jan  3 18:08:59 2003
+++ b/fs/inode.c	Fri Jan  3 18:08:59 2003
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
--- a/fs/super.c	Fri Jan  3 18:08:59 2003
+++ b/fs/super.c	Fri Jan  3 18:08:59 2003
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
--- a/include/linux/fs.h	Fri Jan  3 18:08:59 2003
+++ b/include/linux/fs.h	Fri Jan  3 18:08:59 2003
@@ -879,6 +879,9 @@
  * without the big kernel lock held in all filesystems.
  */
 struct super_operations {
+   	struct inode *(*alloc_inode)(struct super_block *sb);
+	void (*destroy_inode)(struct inode *);
+
 	void (*read_inode) (struct inode *);
   
   	/* reiserfs kludge.  reiserfs needs 64 bits of information to
@@ -1367,6 +1370,7 @@
 #define user_path_walk(name,nd)	 __user_walk(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, nd)
 #define user_path_walk_link(name,nd) __user_walk(name, LOOKUP_POSITIVE, nd)
 
+extern void inode_init_once(struct inode *);
 extern void iput(struct inode *);
 extern void force_delete(struct inode *);
 extern struct inode * igrab(struct inode *);
@@ -1380,18 +1384,7 @@
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
--- a/kernel/ksyms.c	Fri Jan  3 18:08:59 2003
+++ b/kernel/ksyms.c	Fri Jan  3 18:08:59 2003
@@ -142,6 +142,7 @@
 EXPORT_SYMBOL(iunique);
 EXPORT_SYMBOL(iget4);
 EXPORT_SYMBOL(iput);
+EXPORT_SYMBOL(inode_init_once);
 EXPORT_SYMBOL(force_delete);
 EXPORT_SYMBOL(follow_up);
 EXPORT_SYMBOL(follow_down);
@@ -523,7 +524,7 @@
 EXPORT_SYMBOL(init_special_inode);
 EXPORT_SYMBOL(read_ahead);
 EXPORT_SYMBOL(get_hash_table);
-EXPORT_SYMBOL(get_empty_inode);
+EXPORT_SYMBOL(new_inode);
 EXPORT_SYMBOL(insert_inode_hash);
 EXPORT_SYMBOL(remove_inode_hash);
 EXPORT_SYMBOL(buffer_insert_list);
diff -Nru a/net/socket.c b/net/socket.c
--- a/net/socket.c	Fri Jan  3 18:08:59 2003
+++ b/net/socket.c	Fri Jan  3 18:08:59 2003
@@ -436,11 +436,11 @@
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















# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.757.33.11 -> 1.757.33.12
#	      kernel/ksyms.c	1.64    -> 1.65   
#	fs/reiserfs/journal.c	1.24    -> 1.25   
#	  include/linux/fs.h	1.69    -> 1.70   
#	 fs/reiserfs/inode.c	1.39    -> 1.40   
#	include/linux/reiserfs_fs_sb.h	1.14    -> 1.15   
#	         fs/buffer.c	1.76    -> 1.77   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/29	hch@sgi.com	1.757.33.12
# [PATCH] cleanup b_inode usage and fix onstack inode abuse
# 
# Currently the b_inode of struct buffer_head is a pointer to an inode, but
# it only always used as bool value.
# 
# This patch changes it to be a flag bit in the bh state.  This allows
# us to shape of 32bit rom struct buffer_head for other uses like
# the lower layer private data that LVM2 needs or an increase of b_size
# that IA64 boxens with 64k pages need.
# 
# I also cleanes up buffer.c be removing lots of duplicated code and
# enables the alloc_inode patch by removing the last on-stack inodes.
# 
# The patch has been ACKed by akpm and sct and a very similar change
# went into early 2.5.
# --------------------------------------------
#
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Fri Jan  3 18:09:07 2003
+++ b/fs/buffer.c	Fri Jan  3 18:09:07 2003
@@ -583,37 +583,29 @@
 	return bh;
 }
 
-void buffer_insert_inode_queue(struct buffer_head *bh, struct inode *inode)
+void buffer_insert_list(struct buffer_head *bh, struct list_head *list)
 {
 	spin_lock(&lru_list_lock);
-	if (bh->b_inode)
+	if (buffer_attached(bh))
 		list_del(&bh->b_inode_buffers);
-	bh->b_inode = inode;
-	list_add(&bh->b_inode_buffers, &inode->i_dirty_buffers);
+	set_buffer_attached(bh);
+	list_add(&bh->b_inode_buffers, list);
 	spin_unlock(&lru_list_lock);
 }
 
-void buffer_insert_inode_data_queue(struct buffer_head *bh, struct inode *inode)
-{
-	spin_lock(&lru_list_lock);
-	if (bh->b_inode)
-		list_del(&bh->b_inode_buffers);
-	bh->b_inode = inode;
-	list_add(&bh->b_inode_buffers, &inode->i_dirty_data_buffers);
-	spin_unlock(&lru_list_lock);
-}
-
-/* The caller must have the lru_list lock before calling the 
-   remove_inode_queue functions.  */
+/*
+ * The caller must have the lru_list lock before calling the 
+ * remove_inode_queue functions.
+ */
 static void __remove_inode_queue(struct buffer_head *bh)
 {
-	bh->b_inode = NULL;
 	list_del(&bh->b_inode_buffers);
+	clear_buffer_attached(bh);
 }
 
 static inline void remove_inode_queue(struct buffer_head *bh)
 {
-	if (bh->b_inode)
+	if (buffer_attached(bh))
 		__remove_inode_queue(bh);
 }
 
@@ -831,10 +823,10 @@
 int fsync_buffers_list(struct list_head *list)
 {
 	struct buffer_head *bh;
-	struct inode tmp;
+	struct list_head tmp;
 	int err = 0, err2;
 	
-	INIT_LIST_HEAD(&tmp.i_dirty_buffers);
+	INIT_LIST_HEAD(&tmp);
 	
 	spin_lock(&lru_list_lock);
 
@@ -842,10 +834,10 @@
 		bh = BH_ENTRY(list->next);
 		list_del(&bh->b_inode_buffers);
 		if (!buffer_dirty(bh) && !buffer_locked(bh))
-			bh->b_inode = NULL;
+			clear_buffer_attached(bh);
 		else {
-			bh->b_inode = &tmp;
-			list_add(&bh->b_inode_buffers, &tmp.i_dirty_buffers);
+			set_buffer_attached(bh);
+			list_add(&bh->b_inode_buffers, &tmp);
 			if (buffer_dirty(bh)) {
 				get_bh(bh);
 				spin_unlock(&lru_list_lock);
@@ -865,8 +857,8 @@
 		}
 	}
 
-	while (!list_empty(&tmp.i_dirty_buffers)) {
-		bh = BH_ENTRY(tmp.i_dirty_buffers.prev);
+	while (!list_empty(&tmp)) {
+		bh = BH_ENTRY(tmp.prev);
 		remove_inode_queue(bh);
 		get_bh(bh);
 		spin_unlock(&lru_list_lock);
@@ -1138,7 +1130,7 @@
  */
 static void __put_unused_buffer_head(struct buffer_head * bh)
 {
-	if (bh->b_inode)
+	if (unlikely(buffer_attached(bh)))
 		BUG();
 	if (nr_unused_buffer_heads >= MAX_UNUSED_BUFFERS) {
 		kmem_cache_free(bh_cachep, bh);
diff -Nru a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
--- a/fs/reiserfs/inode.c	Fri Jan  3 18:09:07 2003
+++ b/fs/reiserfs/inode.c	Fri Jan  3 18:09:07 2003
@@ -102,9 +102,9 @@
 }
 
 static void add_to_flushlist(struct inode *inode, struct buffer_head *bh) {
-    struct inode *jinode = &(SB_JOURNAL(inode->i_sb)->j_dummy_inode) ;
+    struct reiserfs_journal *j = SB_JOURNAL(inode->i_sb) ;
 
-    buffer_insert_inode_queue(bh, jinode) ;
+    buffer_insert_list(bh, &j->j_dirty_buffers) ;
 }
 
 //
diff -Nru a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
--- a/fs/reiserfs/journal.c	Fri Jan  3 18:09:07 2003
+++ b/fs/reiserfs/journal.c	Fri Jan  3 18:09:07 2003
@@ -1937,7 +1937,7 @@
   memset(journal_writers, 0, sizeof(char *) * 512) ; /* debug code */
 
   INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_bitmap_nodes) ;
-  INIT_LIST_HEAD(&(SB_JOURNAL(p_s_sb)->j_dummy_inode.i_dirty_buffers)) ;
+  INIT_LIST_HEAD(&SB_JOURNAL(p_s_sb)->j_dirty_buffers) ;
   reiserfs_allocate_list_bitmaps(p_s_sb, SB_JOURNAL(p_s_sb)->j_list_bitmap, 
                                  SB_BMAP_NR(p_s_sb)) ;
   allocate_bitmap_nodes(p_s_sb) ;
@@ -2933,7 +2933,7 @@
   SB_JOURNAL_LIST_INDEX(p_s_sb) = jindex ;
 
   /* write any buffers that must hit disk before this commit is done */
-  fsync_inode_buffers(&(SB_JOURNAL(p_s_sb)->j_dummy_inode)) ;
+  fsync_buffers_list(&(SB_JOURNAL(p_s_sb)->j_dirty_buffers)) ;
 
   /* honor the flush and async wishes from the caller */
   if (flush) {
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Fri Jan  3 18:09:07 2003
+++ b/include/linux/fs.h	Fri Jan  3 18:09:07 2003
@@ -219,6 +219,7 @@
 	BH_Async,	/* 1 if the buffer is under end_buffer_io_async I/O */
 	BH_Wait_IO,	/* 1 if we should write out this buffer */
 	BH_Launder,	/* 1 if we can throttle on this buffer */
+	BH_Attached,	/* 1 if b_inode_buffers is linked into a list */
 	BH_JBD,		/* 1 if it has an attached journal_head */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
@@ -266,7 +267,6 @@
 	unsigned long b_rsector;	/* Real buffer location on disk */
 	wait_queue_head_t b_wait;
 
-	struct inode *	     b_inode;
 	struct list_head     b_inode_buffers;	/* doubly linked list of inode dirty buffers */
 };
 
@@ -1170,8 +1170,18 @@
 extern void FASTCALL(__mark_dirty(struct buffer_head *bh));
 extern void FASTCALL(__mark_buffer_dirty(struct buffer_head *bh));
 extern void FASTCALL(mark_buffer_dirty(struct buffer_head *bh));
-extern void FASTCALL(buffer_insert_inode_queue(struct buffer_head *, struct inode *));
-extern void FASTCALL(buffer_insert_inode_data_queue(struct buffer_head *, struct inode *));
+
+extern void FASTCALL(buffer_insert_list(struct buffer_head *, struct list_head *));
+
+static inline void buffer_insert_inode_queue(struct buffer_head *bh, struct inode *inode)
+{
+	buffer_insert_list(bh, &inode->i_dirty_buffers);
+}
+
+static inline void buffer_insert_inode_data_queue(struct buffer_head *bh, struct inode *inode)
+{
+	buffer_insert_list(bh, &inode->i_dirty_data_buffers);
+}
 
 static inline int atomic_set_buffer_dirty(struct buffer_head *bh)
 {
@@ -1184,6 +1194,21 @@
 		set_bit(BH_Async, &bh->b_state);
 	else
 		clear_bit(BH_Async, &bh->b_state);
+}
+
+static inline void set_buffer_attached(struct buffer_head *bh)
+{
+	__set_bit(BH_Attached, &bh->b_state);
+}
+
+static inline void clear_buffer_attached(struct buffer_head *bh)
+{
+	clear_bit(BH_Attached, &bh->b_state);
+}
+
+static inline int buffer_attached(struct buffer_head *bh)
+{
+	return test_bit(BH_Attached, &bh->b_state);
 }
 
 /*
diff -Nru a/include/linux/reiserfs_fs_sb.h b/include/linux/reiserfs_fs_sb.h
--- a/include/linux/reiserfs_fs_sb.h	Fri Jan  3 18:09:07 2003
+++ b/include/linux/reiserfs_fs_sb.h	Fri Jan  3 18:09:07 2003
@@ -312,7 +312,7 @@
   int j_free_bitmap_nodes ;
   int j_used_bitmap_nodes ;
   struct list_head j_bitmap_nodes ;
-  struct inode j_dummy_inode ;
+  struct list_head j_dirty_buffers ;
   struct reiserfs_list_bitmap j_list_bitmap[JOURNAL_NUM_BITMAPS] ;	/* array of bitmaps to record the deleted blocks */
   struct reiserfs_journal_list j_journal_list[JOURNAL_LIST_COUNT] ;	    /* array of all the journal lists */
   struct reiserfs_journal_cnode *j_hash_table[JOURNAL_HASH_SIZE] ; 	    /* hash table for real buffer heads in current trans */ 
diff -Nru a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Fri Jan  3 18:09:07 2003
+++ b/kernel/ksyms.c	Fri Jan  3 18:09:07 2003
@@ -526,8 +526,7 @@
 EXPORT_SYMBOL(get_empty_inode);
 EXPORT_SYMBOL(insert_inode_hash);
 EXPORT_SYMBOL(remove_inode_hash);
-EXPORT_SYMBOL(buffer_insert_inode_queue);
-EXPORT_SYMBOL(buffer_insert_inode_data_queue);
+EXPORT_SYMBOL(buffer_insert_list);
 EXPORT_SYMBOL(make_bad_inode);
 EXPORT_SYMBOL(is_bad_inode);
 EXPORT_SYMBOL(event);

