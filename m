Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287616AbRLaTiJ>; Mon, 31 Dec 2001 14:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287634AbRLaTiF>; Mon, 31 Dec 2001 14:38:05 -0500
Received: from dsl-213-023-043-129.arcor-ip.net ([213.23.43.129]:50180 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287623AbRLaThq>;
	Mon, 31 Dec 2001 14:37:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] [WIP] Unbork fs.h, 3 of 3
Date: Mon, 31 Dec 2001 20:41:25 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0112311004580.1404-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0112311004580.1404-100000@penguin.transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, Alexander Viro <viro@math.psu.edu>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16L8JK-0000ao-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 31, 2001 07:16 pm, Linus Torvalds wrote:
> How about using a descriptor structure instead of the macro, and making
> the filesystem declaration syntax look more like
> 
> 	static struct file_system_type ext2_descriptor = {
> 		owner:		THIS_MODULE,
> 		fs_flags:	FS_REQUIRES_DEV,
> 		name:		"ext2",
> 		read_super:	ext2_read_super,
> 		super_size:	sizeof(ext2_sb_info),
		^^^^^---> changed sb to super, lines up better
> 		inode_size:	sizeof(struct ext2_inode_info)
> 	};
> 
> which is more readable, and inherently documents _what_ those things are.
>
> [snip halfway macro format]
>
> What do you think?

It's much nicer, here's (1 of 3) again, with the Linus-style ext2_fs
declaration.

--
Daniel

--- ../2.4.16.uml.clean/arch/um/fs/hostfs/hostfs_kern.c	Mon Dec 31 03:15:49 2001
+++ ./arch/um/fs/hostfs/hostfs_kern.c	Mon Dec 31 18:28:57 2001
@@ -378,7 +378,7 @@
 	char *name;
 	int type, err = 0, rdev;
 
-	inode = get_empty_inode();
+	inode = get_empty_inode(sb);
 	if(inode == NULL) return(NULL);
 	inode->u.hostfs_i.host_filename = NULL;
 	inode->u.hostfs_i.fd = -1;
@@ -395,7 +395,6 @@
 		kfree(name);
 	}
 	else type = HOSTFS_DIR;
-	inode->i_sb = sb;
 
 	if(type == HOSTFS_SYMLINK)
 		inode->i_op = &page_symlink_inode_operations;
--- ../2.4.16.uml.clean/drivers/block/rd.c	Mon Dec 31 02:55:36 2001
+++ ./drivers/block/rd.c	Mon Dec 31 18:28:57 2001
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
--- ../2.4.16.uml.clean/fs/ext2/super.c	Sun Dec 30 10:15:56 2001
+++ ./fs/ext2/super.c	Mon Dec 31 19:19:01 2001
@@ -798,16 +798,23 @@
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
--- ../2.4.16.uml.clean/fs/inode.c	Mon Dec 31 02:55:36 2001
+++ ./fs/inode.c	Mon Dec 31 18:53:23 2001
@@ -75,16 +75,23 @@
 
 static kmem_cache_t * inode_cachep;
 
-#define alloc_inode() \
-	 ((struct inode *) kmem_cache_alloc(inode_cachep, SLAB_KERNEL))
-static void destroy_inode(struct inode *inode) 
+int foo_count;
+
+static inline struct inode *alloc_inode (struct super_block *sb)
 {
+	kmem_cache_t *cache = sb? sb->s_type->inode_cache: NULL;
+	return (struct inode *) kmem_cache_alloc (cache? cache: inode_cachep, SLAB_KERNEL);
+}
+
+static void destroy_inode (struct inode *inode) 
+{
+	struct super_block *sb = inode->i_sb;
+	kmem_cache_t *cache = sb? sb->s_type->inode_cache: NULL;
 	if (inode_has_buffers(inode))
 		BUG();
-	kmem_cache_free(inode_cachep, (inode));
+	kmem_cache_free (cache? cache: inode_cachep, inode);
 }
 
-
 /*
  * These are initializations that only need to be done
  * once, because the fields are idempotent across use
@@ -661,7 +668,7 @@
 	 !inode_has_buffers(inode))
 #define INODE(entry)	(list_entry(entry, struct inode, i_list))
 
-void prune_icache(int goal)
+void prune_icache (int goal)
 {
 	LIST_HEAD(list);
 	struct list_head *entry, *freeable = &list;
@@ -710,6 +717,7 @@
 
 int shrink_icache_memory(int priority, int gfp_mask)
 {
+	struct file_system_type *fs;
 	int count = 0;
 
 	/*
@@ -725,7 +733,15 @@
 	count = inodes_stat.nr_unused / priority;
 
 	prune_icache(count);
+#if 0
+	/* Manfred thinks this isn't necessary */
 	kmem_cache_shrink(inode_cachep);
+	write_lock(&file_systems_lock);
+	for (fs = file_systems; fs; fs = fs->next)
+		kmem_cache_shrink (fs->inode_cache);
+	write_unlock(&file_systems_lock);
+	kmem_cache_shrink(inode_cachep);
+#endif
 	return 0;
 }
 
@@ -765,12 +781,14 @@
  * i_sb, i_ino, i_count, i_state and the lists have
  * been initialized elsewhere..
  */
-static void clean_inode(struct inode *inode)
+static void clean_inode (struct super_block *sb, struct inode *inode)
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
@@ -802,20 +820,19 @@
  * lists.
  */
  
-struct inode * get_empty_inode(void)
+struct inode *get_empty_inode (struct super_block *sb)
 {
 	static unsigned long last_ino;
-	struct inode * inode;
+	struct inode *inode;
 
 	spin_lock_prefetch(&inode_lock);
-	
-	inode = alloc_inode();
+	inode = alloc_inode (sb);
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
@@ -823,7 +840,7 @@
 		atomic_set(&inode->i_count, 1);
 		inode->i_state = 0;
 		spin_unlock(&inode_lock);
-		clean_inode(inode);
+		clean_inode(sb, inode);
 	}
 	return inode;
 }
@@ -838,7 +855,7 @@
 {
 	struct inode * inode;
 
-	inode = alloc_inode();
+	inode = alloc_inode (sb);
 	if (inode) {
 		struct inode * old;
 
@@ -849,7 +866,6 @@
 			inodes_stat.nr_inodes++;
 			list_add(&inode->i_list, &inode_in_use);
 			list_add(&inode->i_hash, head);
-			inode->i_sb = sb;
 			inode->i_dev = sb->s_dev;
 			inode->i_blkbits = sb->s_blocksize_bits;
 			inode->i_ino = ino;
@@ -857,8 +873,7 @@
 			atomic_set(&inode->i_count, 1);
 			inode->i_state = I_LOCK;
 			spin_unlock(&inode_lock);
-
-			clean_inode(inode);
+			clean_inode(sb, inode);
 
 			/* reiserfs specific hack right here.  We don't
 			** want this to last, and are looking for VFS changes
@@ -897,6 +912,22 @@
 		wait_on_inode(inode);
 	}
 	return inode;
+}
+
+int create_inode_cache (struct file_system_type *fs)
+{
+	if (fs->inode_size)
+		if (!(fs->inode_cache = kmem_cache_create (fs->name, 
+		    fs->inode_size + sizeof(struct inode) - sizeof(get_empty_inode(0)->u),
+		    0, SLAB_HWCACHE_ALIGN, init_once, NULL)))
+			return -ENOSPC;
+	return 0;
+}
+
+int destroy_inode_cache (struct file_system_type *fs)
+{
+	printk("Destroying inode cache for %s\n", fs->name);
+	return kmem_cache_destroy (fs->inode_cache)? -EBUSY: 0;
 }
 
 static inline unsigned long hash(struct super_block *sb, unsigned long i_ino)
--- ../2.4.16.uml.clean/fs/super.c	Mon Dec 31 02:55:36 2001
+++ ./fs/super.c	Mon Dec 31 18:28:57 2001
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
+int register_filesystem (struct file_system_type *fs)
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
+		if (!(err = create_inode_cache (fs)))
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
+int unregister_filesystem (struct file_system_type *fs)
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
+			if (fs->inode_cache && (err = destroy_inode_cache (fs)))
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
--- ../2.4.16.uml.clean/include/linux/fs.h	Mon Dec 31 02:55:36 2001
+++ ./include/linux/fs.h	Mon Dec 31 18:50:45 2001
@@ -693,6 +693,9 @@
 #include <linux/cramfs_fs_sb.h>
 #include <linux/jffs2_fs_sb.h>
 
+extern struct file_system_type *file_systems;
+extern rwlock_t file_systems_lock;
+
 extern struct list_head super_blocks;
 extern spinlock_t sb_lock;
 
@@ -950,10 +953,14 @@
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
@@ -1327,18 +1334,21 @@
 }
 
 extern void clear_inode(struct inode *);
-extern struct inode * get_empty_inode(void);
+extern struct inode *get_empty_inode (struct super_block *sb);
 
-static inline struct inode * new_inode(struct super_block *sb)
+static inline struct inode *new_inode (struct super_block *sb)
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
+
+int create_inode_cache (struct file_system_type *fs);
+int destroy_inode_cache (struct file_system_type *fs);
+
 extern void remove_suid(struct inode *inode);
 
 extern void insert_inode_hash(struct inode *);
--- ../2.4.16.uml.clean/net/socket.c	Mon Dec 31 02:55:36 2001
+++ ./net/socket.c	Mon Dec 31 18:28:58 2001
@@ -440,11 +440,10 @@
 	struct inode * inode;
 	struct socket * sock;
 
-	inode = get_empty_inode();
+	inode = get_empty_inode(sock_mnt->mnt_sb);
 	if (!inode)
 		return NULL;
 
-	inode->i_sb = sock_mnt->mnt_sb;
 	sock = socki_lookup(inode);
 
 	inode->i_mode = S_IFSOCK|S_IRWXUGO;
