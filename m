Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287456AbRLaFc3>; Mon, 31 Dec 2001 00:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287461AbRLaFcX>; Mon, 31 Dec 2001 00:32:23 -0500
Received: from dsl-213-023-038-110.arcor-ip.net ([213.23.38.110]:6669 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287457AbRLaFcR>;
	Mon, 31 Dec 2001 00:32:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC] [WIP] Unbork fs.h, 1 of 3
Date: Mon, 31 Dec 2001 06:36:01 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        linux-fsdevel@vger.kernel.org
Message-Id: <E16Kv7E-0003CM-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first patch of a series that will eventually remove the
filesystem-specific includes, the struct inode union and the struct 
super_block union from linux/fs.h.  For now, just the inode_info include for 
ext2 is removed, to demonstrate the general approach.

The three patches are:

  1) Add VFS support for per-filesystem inode caches
  2) Abstract all references to the inode union through an inline function
  3) Give ext2 its own inode cache and remove ext2_fs_i include from fs.h

The first two patches are independent of each other; patch (3) must be 
applied last.  These patch applies to both 2.4.16 or 2.4.17, with some small 
offsets.

The ultimate goal for fs.h to have no knowledge of specific filesystems, and, 
not to have to include filesystem-specific header files.  Since fs.h is 
widely included throughout the Linux tree, avoiding the need to include 
headers of many filesystems saves a significant amount of compilation time.  
There will also be fewer surprises when working with header files - currently 
some of the included header files include other headers, with the result that 
some filesystems have unexpected dependencies on others.  Further, the 
removal of the unions from struct inode and struct super_block means that 
instances of those structures can be exactly as big as they need to be, as 
opposed to needing to be as big as the largest of the inode types in the 
system[1].  Most importantly, this nearly completes the factorization of the 
system into filesystem-independent and filesystem-specific components.


The main reason that filesystem-specific headers are embedded in fs.h is so 
that the compiler can know the size of the filesystem-private union in struct 
inode.  A second reason is so that a structure can be defined such that a 
filesystem knows how to access it's private part of an inode, using  
something like: inode->u.ext2_i.i_dtime to get at the ext2-private 'i_dtime' 
field.

An attempt has been made in the past to address the obvious clumsiness of the 
inode unions by provide a (void *) pointer, generic_ip, as a member of the 
inode union, with a view to eventually converting all filesystems to use it.  
This approach has drawbacks: an extra dereference would be required for all 
filesystem-specific inode fields, there would be some extra cache lines 
touched and every inode allocation would access two separate slab caches.  
Considering the number and frequency of access of inodes in the system, it is 
desirable avoid these inefficiencies.

My approach here is to have the filesystem explicitly tell the VFS by means 
of new fields in the file_system_type struct, how large its private inode and 
super_block areas should be.  At filesystem registration time, the VFS 
creates a new slab cache with an object size of the requested size, plus the 
size of the generic part of the inode.  Access to private fields in the inode 
is abstracted through an inline function, so that the filesystem in unaware 
of whether it is accessing its private fields through the union, via address 
arithmetic, or via the generic_ip pointer for that matter.  Should the 
filesystem not specify a size, the size of the current union is assumed, and 
its inodes are allocated from the existing 'inode_cachep' slab cache.

As part of a filesystem's unregistration, its inode cache - which should be 
empty - is destroyed.  This patch as it stands has an issue with the system 
root in this regard: the root filesystem is not handled quite like other 
filesystems.  Instead of being unmounted, it is merely remounted RO.  
Nevertheless, the VFS still calls the module_exit for the root filesystem, 
which calls unregister_filesystem, which tries to destroy the its own inode 
cache, which isn't empty, because of special-case code connected with the 
root.  There is clearly a problem here - it seems that the special casing of 
the root is either not quite right yet, or the root should not be 
special-cased.  This requires further investigation, and comment is invited.  
It is because of the difficult nature of this problem that I am posting this 
patch now, instead of attempting to resolve this problem myself.

The symptom of the abovementioned problem is that you will see the message
'kmem_cache_destroy: Can't free all objects' after the 'power down' message. 
This is quite harmless, however, something needs to be done about it.

To apply this patch:

  cd /your/source/tree
  cat this/patch | patch -p0

I strongly recommended that this patch not be tested on a system containing
valuable data - user mode linux is the way to go here.

--
Daniel

[1] The nfs inode is the largest inode in the system.  Ext3 comes in second.  
The generic part of the inode is about two times the size of the ext2-private 
part, and is no doubt bigger than it needs to be.

[2] *Almost*.  The VFS still has specific knowledge of NFS (connected with 
mounting the root) and knows a detail or two about Reiserfs.

--- ../2.4.16.uml.clean/arch/um/fs/hostfs/hostfs_kern.c	Sun Dec 30 10:15:56 
2001
+++ ./arch/um/fs/hostfs/hostfs_kern.c	Mon Dec 31 00:38:02 2001
@@ -378,7 +378,7 @@
 	char *name;
 	int type, err = 0, rdev;
 
-	inode = get_empty_inode();
+	inode = get_empty_inode(inode->i_sb);
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
--- ../2.4.16.uml.clean/drivers/block/rd.c	Sun Dec 30 10:15:56 2001
+++ ./drivers/block/rd.c	Mon Dec 31 00:38:02 2001
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
--- ../2.4.16.uml.clean/fs/inode.c	Sun Dec 30 10:15:56 2001
+++ ./fs/inode.c	Mon Dec 31 01:09:58 2001
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
+	return (struct inode *) kmem_cache_alloc (cache? cache: inode_cachep, 
SLAB_KERNEL);
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
+	unsigned given = sb? sb->s_type->inode_private: 0; // only rd.c has null sb
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
+	if (fs->inode_private)
+		if (!(fs->inode_cache = kmem_cache_create (fs->name, 
+		    fs->inode_private + sizeof(struct inode) - 
sizeof(get_empty_inode(0)->u),
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
--- ../2.4.16.uml.clean/fs/super.c	Sun Dec 30 10:15:56 2001
+++ ./fs/super.c	Mon Dec 31 01:04:15 2001
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
--- ../2.4.16.uml.clean/include/linux/fs.h	Sun Dec 30 10:16:12 2001
+++ ./include/linux/fs.h	Mon Dec 31 00:38:02 2001
@@ -693,6 +693,9 @@
 #include <linux/cramfs_fs_sb.h>
 #include <linux/jffs2_fs_sb.h>
 
+extern struct file_system_type *file_systems;
+extern rwlock_t file_systems_lock;
+
 extern struct list_head super_blocks;
 extern spinlock_t sb_lock;
 
@@ -952,16 +955,28 @@
 	struct module *owner;
 	struct file_system_type * next;
 	struct list_head fs_supers;
+	unsigned super_private, inode_private;
+	struct kmem_cache_s *inode_cache;
 };
 
-#define DECLARE_FSTYPE(var,type,read,flags) \
+#define FILESYSTEM_TYPE(var,type,read,ssize,isize,flags) \
 struct file_system_type var = { \
 	name:		type, \
 	read_super:	read, \
+	super_private:	ssize, \
+	inode_private:	isize, \
 	fs_flags:	flags, \
 	owner:		THIS_MODULE, \
 }
 
+#define FILESYSTEM(var,type,read,ssize,isize) \
+	FILESYSTEM_TYPE(var,type,read,ssize,isize,FS_REQUIRES_DEV)
+
+/* Backward compatible declarations, remove when all updated */
+
+#define DECLARE_FSTYPE(var,type,read,flags) \
+	FILESYSTEM_TYPE(var,type,read,0,0,flags)
+
 #define DECLARE_FSTYPE_DEV(var,type,read) \
 	DECLARE_FSTYPE(var,type,read,FS_REQUIRES_DEV)
 
@@ -1327,18 +1342,21 @@
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
--- ../2.4.16.uml.clean/net/socket.c	Sun Dec 30 10:15:56 2001
+++ ./net/socket.c	Mon Dec 31 00:38:02 2001
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

