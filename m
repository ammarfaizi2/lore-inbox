Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287710AbSAFFEs>; Sun, 6 Jan 2002 00:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287714AbSAFFE3>; Sun, 6 Jan 2002 00:04:29 -0500
Received: from dsl-213-023-043-049.arcor-ip.net ([213.23.43.49]:37649 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287710AbSAFFES>;
	Sun, 6 Jan 2002 00:04:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT] Unbork fs.h + per-fs supers (fixed)
Date: Sun, 6 Jan 2002 06:08:13 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <E16MnM9-0001Fu-00@starship.berlin> <E16MsC5-0001H4-00@starship.berlin>
In-Reply-To: <E16MsC5-0001H4-00@starship.berlin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16N5Xc-0001Jr-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 5, 2002 03:53 pm, Daniel Phillips wrote:
> Don't use the above patch please, there's a stupid oversight - it seems 
> super_block has a couple of fields *after* the fs-private union, and the
> new code doesn't take that into account.

Yes, that was it all right.  This was fixed by moving the two 'don't use' 
inode fields before the union.  (The variable-sized component of such structs 
always has to come last.)  I also cleaned up the formatting of my additions 
along the lines discussed in the recent 'janitorial' thread.

Doing 'less /proc/slabinfo' shows the ext2 inode cache objects, at 416 bytes, 
are now 64 bytes smaller than they used to be.  More space could be saved by
relaxing the slab cache alignment for these objects from 64 bytes (686
cacheline) to 4 or 8 bytes.  Has anybody checked to see if hardware cacheline
alignment for inodes is really a win?

This patch now appears stable enough for testing - I'm running it on my
server at the moment.

To Apply:

  cd /your/2.4.17/tree
  cat this/patch | patch -p0

--
Daniel

--- ../2.4.17.clean/drivers/block/rd.c	Fri Dec 21 12:41:53 2001
+++ ./drivers/block/rd.c	Sat Jan  5 10:29:35 2002
@@ -673,7 +673,7 @@
 #endif
 	ram_device = MKDEV(MAJOR_NR, unit);
 
-	if ((inode = get_empty_inode()) == NULL)
+	if ((inode = get_empty_inode(NULL)) == NULL)
 		return;
 	memset(&infile, 0, sizeof(infile));
 	memset(&in_dentry, 0, sizeof(in_dentry));
@@ -683,7 +683,7 @@
 	infile.f_op = &def_blk_fops;
 	init_special_inode(inode, S_IFBLK | S_IRUSR, kdev_t_to_nr(device));
 
-	if ((out_inode = get_empty_inode()) == NULL)
+	if ((out_inode = get_empty_inode(NULL)) == NULL)
 		goto free_inode;
 	memset(&outfile, 0, sizeof(outfile));
 	memset(&out_dentry, 0, sizeof(out_dentry));
--- ../2.4.17.clean/fs/ext2/super.c	Fri Dec 21 12:41:55 2001
+++ ./fs/ext2/super.c	Sun Jan  6 01:50:44 2002
@@ -806,16 +806,23 @@
 	return 0;
 }
 
-static DECLARE_FSTYPE_DEV(ext2_fs_type, "ext2", ext2_read_super);
-
+static struct file_system_type ext2_fs = {
+	owner:		THIS_MODULE,
+	fs_flags:	FS_REQUIRES_DEV,
+	name:		"ext2",
+	read_super:	ext2_read_super,
+	super_size:	sizeof(struct ext2_sb_info),
+	inode_size:	sizeof(struct ext2_inode_info)
+};
+ 
 static int __init init_ext2_fs(void)
 {
-        return register_filesystem(&ext2_fs_type);
+        return register_filesystem(&ext2_fs);
 }
 
 static void __exit exit_ext2_fs(void)
 {
-	unregister_filesystem(&ext2_fs_type);
+	unregister_filesystem(&ext2_fs);
 }
 
 EXPORT_NO_SYMBOLS;
--- ../2.4.17.clean/fs/inode.c	Fri Dec 21 12:41:55 2001
+++ ./fs/inode.c	Sun Jan  6 03:42:25 2002
@@ -75,29 +75,32 @@
 
 static kmem_cache_t * inode_cachep;
 
-#define alloc_inode() \
-	 ((struct inode *) kmem_cache_alloc(inode_cachep, SLAB_KERNEL))
+static inline struct inode *alloc_inode(struct super_block *sb)
+{
+	kmem_cache_t *cache = sb? sb->s_type->inode_cache: NULL;
+	return (struct inode *) kmem_cache_alloc(cache? cache: inode_cachep, SLAB_KERNEL);
+}
+
 static void destroy_inode(struct inode *inode) 
 {
+	struct super_block *sb = inode->i_sb;
+	kmem_cache_t *cache = sb? sb->s_type->inode_cache: NULL;
 	if (inode_has_buffers(inode))
 		BUG();
-	kmem_cache_free(inode_cachep, (inode));
+	kmem_cache_free(cache? cache: inode_cachep, inode);
 }
 
-
 /*
  * These are initializations that only need to be done
  * once, because the fields are idempotent across use
  * of the inode, so let the slab aware of that.
  */
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static void init_once(void *p, kmem_cache_t *cache, unsigned long flags)
 {
-	struct inode * inode = (struct inode *) foo;
-
-	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
-	    SLAB_CTOR_CONSTRUCTOR)
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) == SLAB_CTOR_CONSTRUCTOR)
 	{
-		memset(inode, 0, sizeof(*inode));
+		struct inode *inode = (struct inode *) p;
+		kmem_cache_clear(cache, inode);
 		init_waitqueue_head(&inode->i_wait);
 		INIT_LIST_HEAD(&inode->i_hash);
 		INIT_LIST_HEAD(&inode->i_data.clean_pages);
@@ -710,6 +713,7 @@
 
 int shrink_icache_memory(int priority, int gfp_mask)
 {
+	struct file_system_type *fs;
 	int count = 0;
 
 	/*
@@ -725,7 +729,15 @@
 	count = inodes_stat.nr_unused / priority;
 
 	prune_icache(count);
+#if 0
+	/* Manfred thinks this isn't necessary */
 	kmem_cache_shrink(inode_cachep);
+	write_lock(&file_systems_lock);
+	for (fs = file_systems; fs; fs = fs->next)
+		kmem_cache_shrink(fs->inode_cache);
+	write_unlock(&file_systems_lock);
+	kmem_cache_shrink(inode_cachep);
+#endif
 	return 0;
 }
 
@@ -765,12 +777,14 @@
  * i_sb, i_ino, i_count, i_state and the lists have
  * been initialized elsewhere..
  */
-static void clean_inode(struct inode *inode)
+static void init_inode(struct inode *inode, struct super_block *sb)
 {
 	static struct address_space_operations empty_aops;
 	static struct inode_operations empty_iops;
 	static struct file_operations empty_fops;
-	memset(&inode->u, 0, sizeof(inode->u));
+	unsigned given = sb? sb->s_type->inode_size: 0; // only rd.c has null sb
+	memset(&inode->u, 0, given? given: sizeof(inode->u));
+	inode->i_sb = sb;
 	inode->i_sock = 0;
 	inode->i_op = &empty_iops;
 	inode->i_fop = &empty_fops;
@@ -802,20 +816,19 @@
  * lists.
  */
  
-struct inode * get_empty_inode(void)
+struct inode *get_empty_inode(struct super_block *sb)
 {
 	static unsigned long last_ino;
-	struct inode * inode;
+	struct inode *inode;
 
 	spin_lock_prefetch(&inode_lock);
-	
-	inode = alloc_inode();
+	inode = alloc_inode(sb);
 	if (inode)
 	{
 		spin_lock(&inode_lock);
 		inodes_stat.nr_inodes++;
 		list_add(&inode->i_list, &inode_in_use);
-		inode->i_sb = NULL;
+		inode->i_sb = NULL; // need this?
 		inode->i_dev = 0;
 		inode->i_blkbits = 0;
 		inode->i_ino = ++last_ino;
@@ -823,7 +836,7 @@
 		atomic_set(&inode->i_count, 1);
 		inode->i_state = 0;
 		spin_unlock(&inode_lock);
-		clean_inode(inode);
+		init_inode(inode, sb);
 	}
 	return inode;
 }
@@ -838,7 +851,7 @@
 {
 	struct inode * inode;
 
-	inode = alloc_inode();
+	inode = alloc_inode(sb);
 	if (inode) {
 		struct inode * old;
 
@@ -849,7 +862,6 @@
 			inodes_stat.nr_inodes++;
 			list_add(&inode->i_list, &inode_in_use);
 			list_add(&inode->i_hash, head);
-			inode->i_sb = sb;
 			inode->i_dev = sb->s_dev;
 			inode->i_blkbits = sb->s_blocksize_bits;
 			inode->i_ino = ino;
@@ -857,8 +869,7 @@
 			atomic_set(&inode->i_count, 1);
 			inode->i_state = I_LOCK;
 			spin_unlock(&inode_lock);
-
-			clean_inode(inode);
+			init_inode(inode, sb);
 
 			/* reiserfs specific hack right here.  We don't
 			** want this to last, and are looking for VFS changes
@@ -897,6 +908,21 @@
 		wait_on_inode(inode);
 	}
 	return inode;
+}
+
+int create_inode_cache(struct file_system_type *fs)
+{
+	if (fs->inode_size)
+		if (!(fs->inode_cache = kmem_cache_create(fs->name, 
+		    fs->inode_size + sizeof(struct inode) - sizeof(get_empty_inode(0)->u),
+		    0, SLAB_HWCACHE_ALIGN, init_once, NULL)))
+			return -ENOSPC;
+	return 0;
+}
+
+int destroy_inode_cache(struct file_system_type *fs)
+{
+	return kmem_cache_destroy(fs->inode_cache)? -EBUSY: 0;
 }
 
 static inline unsigned long hash(struct super_block *sb, unsigned long i_ino)
--- ../2.4.17.clean/fs/super.c	Fri Dec 21 12:42:03 2001
+++ ./fs/super.c	Sun Jan  6 03:44:18 2002
@@ -67,8 +67,8 @@
  *	Once the reference is obtained we can drop the spinlock.
  */
 
-static struct file_system_type *file_systems;
-static rwlock_t file_systems_lock = RW_LOCK_UNLOCKED;
+struct file_system_type *file_systems;
+rwlock_t file_systems_lock = RW_LOCK_UNLOCKED;
 
 /* WARNING: This can be used only if we _already_ own a reference */
 static void get_filesystem(struct file_system_type *fs)
@@ -105,10 +105,10 @@
  *	unregistered.
  */
  
-int register_filesystem(struct file_system_type * fs)
+int register_filesystem(struct file_system_type *fs)
 {
-	int res = 0;
-	struct file_system_type ** p;
+	struct file_system_type **p;
+	int err = 0;
 
 	if (!fs)
 		return -EINVAL;
@@ -118,11 +118,12 @@
 	write_lock(&file_systems_lock);
 	p = find_filesystem(fs->name);
 	if (*p)
-		res = -EBUSY;
+		err = -EBUSY;
 	else
-		*p = fs;
+		if (!(err = create_inode_cache(fs)))
+			*p = fs;
 	write_unlock(&file_systems_lock);
-	return res;
+	return err;
 }
 
 /**
@@ -137,23 +138,25 @@
  *	may be freed or reused.
  */
  
-int unregister_filesystem(struct file_system_type * fs)
+int unregister_filesystem(struct file_system_type *fs)
 {
-	struct file_system_type ** tmp;
-
+	struct file_system_type **p;
+	int err = -EINVAL;
 	write_lock(&file_systems_lock);
-	tmp = &file_systems;
-	while (*tmp) {
-		if (fs == *tmp) {
-			*tmp = fs->next;
+	p = &file_systems;
+	while (*p) {
+		if (*p == fs) {
+			if (fs->inode_cache && (err = destroy_inode_cache(fs)))
+				break;
+			*p = fs->next;
 			fs->next = NULL;
-			write_unlock(&file_systems_lock);
-			return 0;
+			err = 0;
+			break;
 		}
-		tmp = &(*tmp)->next;
+		p = &(*p)->next;
 	}
 	write_unlock(&file_systems_lock);
-	return -EINVAL;
+	return err;
 }
 
 static int fs_index(const char * __name)
@@ -419,11 +422,17 @@
  *	the request.
  */
  
-static struct super_block *alloc_super(void)
+static struct super_block *alloc_super(struct file_system_type *fs)
 {
-	struct super_block *s = kmalloc(sizeof(struct super_block),  GFP_USER);
-	if (s) {
-		memset(s, 0, sizeof(struct super_block));
+	struct super_block *s;
+        unsigned size = sizeof(struct super_block);
+
+	if (fs->super_size)
+		size += fs->super_size - sizeof(alloc_super(0)->u);
+
+	printk(">>> %s super size is %i\n", fs->name, size);
+	if ((s = kmalloc(size, GFP_USER))) {
+		memset(s, 0, size);
 		INIT_LIST_HEAD(&s->s_dirty);
 		INIT_LIST_HEAD(&s->s_locked_inodes);
 		INIT_LIST_HEAD(&s->s_files);
@@ -446,7 +455,7 @@
 				       void *data)
 {
 	struct super_block * s;
-	s = alloc_super();
+	s = alloc_super(type);
 	if (!s)
 		goto out;
 	s->s_dev = dev;
@@ -578,7 +587,7 @@
 		goto out1;
 
 	error = -ENOMEM;
-	s = alloc_super();
+	s = alloc_super(fs_type);
 	if (!s)
 		goto out1;
 	down_write(&s->s_umount);
@@ -664,7 +673,7 @@
 static struct super_block *get_sb_single(struct file_system_type *fs_type,
 	int flags, void *data)
 {
-	struct super_block * s = alloc_super();
+	struct super_block * s = alloc_super(fs_type);
 	if (!s)
 		return ERR_PTR(-ENOMEM);
 	down_write(&s->s_umount);
--- ../2.4.17.clean/include/linux/fs.h	Fri Dec 21 12:42:03 2001
+++ ./include/linux/fs.h	Sun Jan  6 03:26:53 2002
@@ -691,6 +691,9 @@
 #include <linux/cramfs_fs_sb.h>
 #include <linux/jffs2_fs_sb.h>
 
+extern struct file_system_type *file_systems;
+extern rwlock_t file_systems_lock;
+
 extern struct list_head super_blocks;
 extern spinlock_t sb_lock;
 
@@ -722,6 +725,21 @@
 	struct list_head	s_instances;
 	struct quota_mount_options s_dquot;	/* Diskquota specific options */
 
+	/*
+	 * The next field is for VFS *only*. No filesystems have any business
+	 * even looking at it. You had been warned.
+	 */
+	struct semaphore s_vfs_rename_sem;	/* Kludge */
+
+	/* The next field is used by knfsd when converting a (inode number based)
+	 * file handle into a dentry. As it builds a path in the dcache tree from
+	 * the bottom up, there may for a time be a subpath of dentrys which is not
+	 * connected to the main tree.  This semaphore ensure that there is only ever
+	 * one such free path per filesystem.  Note that unconnected files (or other
+	 * non-directories) are allowed, but not unconnected diretories.
+	 */
+	struct semaphore s_nfsd_free_path_sem;
+
 	union {
 		struct minix_sb_info	minix_sb;
 		struct ext2_sb_info	ext2_sb;
@@ -750,20 +768,6 @@
 		struct cramfs_sb_info	cramfs_sb;
 		void			*generic_sbp;
 	} u;
-	/*
-	 * The next field is for VFS *only*. No filesystems have any business
-	 * even looking at it. You had been warned.
-	 */
-	struct semaphore s_vfs_rename_sem;	/* Kludge */
-
-	/* The next field is used by knfsd when converting a (inode number based)
-	 * file handle into a dentry. As it builds a path in the dcache tree from
-	 * the bottom up, there may for a time be a subpath of dentrys which is not
-	 * connected to the main tree.  This semaphore ensure that there is only ever
-	 * one such free path per filesystem.  Note that unconnected files (or other
-	 * non-directories) are allowed, but not unconnected diretories.
-	 */
-	struct semaphore s_nfsd_free_path_sem;
 };
 
 /*
@@ -951,10 +955,14 @@
 	int fs_flags;
 	struct super_block *(*read_super) (struct super_block *, void *, int);
 	struct module *owner;
-	struct file_system_type * next;
+	struct file_system_type *next;
 	struct list_head fs_supers;
+	unsigned super_size, inode_size;
+	struct kmem_cache_s *inode_cache;
 };
 
+/* Backward compatible declarations, remove when all updated */
+
 #define DECLARE_FSTYPE(var,type,read,flags) \
 struct file_system_type var = { \
 	name:		type, \
@@ -1328,20 +1336,21 @@
 }
 
 extern void clear_inode(struct inode *);
-extern struct inode * get_empty_inode(void);
+extern struct inode *get_empty_inode(struct super_block *sb);
 
-static inline struct inode * new_inode(struct super_block *sb)
+static inline struct inode *new_inode(struct super_block *sb)
 {
-	struct inode *inode = get_empty_inode();
+	struct inode *inode = get_empty_inode(sb);
 	if (inode) {
-		inode->i_sb = sb;
 		inode->i_dev = sb->s_dev;
 		inode->i_blkbits = sb->s_blocksize_bits;
 	}
 	return inode;
 }
-extern void remove_suid(struct inode *inode);
 
+extern int create_inode_cache(struct file_system_type *fs);
+extern int destroy_inode_cache(struct file_system_type *fs);
+extern void remove_suid(struct inode *inode);
 extern void insert_inode_hash(struct inode *);
 extern void remove_inode_hash(struct inode *);
 extern struct file * get_empty_filp(void);
--- ../2.4.17.clean/include/linux/slab.h	Fri Dec 21 12:42:04 2001
+++ ./include/linux/slab.h	Sun Jan  6 03:27:29 2002
@@ -57,6 +57,7 @@
 extern int kmem_cache_shrink(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
 extern void kmem_cache_free(kmem_cache_t *, void *);
+extern void kmem_cache_clear(kmem_cache_t *, void *);
 
 extern void *kmalloc(size_t, int);
 extern void kfree(const void *);
--- ../2.4.17.clean/mm/slab.c	Fri Dec 21 12:42:05 2001
+++ ./mm/slab.c	Sat Jan  5 10:29:35 2002
@@ -1078,6 +1078,16 @@
 	slabp->free = 0;
 }
 
+void kmem_cache_clear(kmem_cache_t *cachep, void *objp)
+{
+	unsigned size = cachep->objsize;
+#if DEBUG
+	if (cachep->flags & SLAB_RED_ZONE)
+		size -= BYTES_PER_WORD*2;
+#endif
+	memset(objp, 0, size);
+}
+
 /*
  * Grow (by 1) the number of slabs within a cache.  This is called by
  * kmem_cache_alloc() when there are no active objs left in a cache.
--- ../2.4.17.clean/net/socket.c	Fri Dec 21 12:42:06 2001
+++ ./net/socket.c	Sat Jan  5 10:29:35 2002
@@ -438,11 +438,10 @@
 	struct inode * inode;
 	struct socket * sock;
 
-	inode = get_empty_inode();
+	inode = get_empty_inode(sock_mnt->mnt_sb);
 	if (!inode)
 		return NULL;
 
-	inode->i_sb = sock_mnt->mnt_sb;
 	sock = socki_lookup(inode);
 
 	inode->i_mode = S_IFSOCK|S_IRWXUGO;
