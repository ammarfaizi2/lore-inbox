Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283204AbSAFWNr>; Sun, 6 Jan 2002 17:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285593AbSAFWNk>; Sun, 6 Jan 2002 17:13:40 -0500
Received: from dsl-213-023-043-049.arcor-ip.net ([213.23.43.49]:10250 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S282967AbSAFWNT>;
	Sun, 6 Jan 2002 17:13:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [RFC] Unbork fs.h, 1 of 4
Date: Sun, 6 Jan 2002 23:17:07 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16NLbK-0001LE-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first of a set of 4 patches, totalling 2,142 lines, the end 
result of which is the removal of four lines from include/linux/fs.h:

    291: #include <linux/ext2_fs_i.h>
    670: #include <linux/ext2_fs_sb.h>
    481: struct ext2_inode_info ext2_i;    (union member)
    727: struct ext2_sb_info ext2_sb;      (union member)

With these four lines gone, several things happen:

  - Ext2 in-memory inodes and super_blocks get somewhat smaller
  - The kernel build speeds up a little (fewer header files compiled)
  - Header dependencies get simpler and more maintainable
  - The two excised header files can be merged with ext2_fs.h

How did those four ext2-specific lines come to be part of fs.h in the first 
place?  They're there so that the compiler can compute a size for the inode 
and super_block structs, and compute offsets to the fields of the unions.
Please see my original post, "[RFC] [WIP] Unbork fs.h", for a more extensive 
discussion of why this is bad.  I'll summarize the main points here:

  - The size of the struct is governed by the largest member of the union,
    and since inodes at least are very numerous, a lot of memory is wasted.

  - Touching any filesystem's header forces recompilations of any file that
    includes fs.h.

  - All the symbols of every filesystem's header end up in the same 
    namespace, and this namespace is imported by every file that includes
    fs.h, of which there are many.

  - Some filesystem-specific header files include other headers and some
    of those header files include other headers and so on, so that it is 
    difficult to know which headers are actually being included.  Even
    worse, the includes change over time.

  - The complex header includes force the use of various tricks to allow
    header files to be ignored if they are inadvertently included more
    than once.  This is cruft that should not be needed.

In formulating a strategy to correct these problems, I set out the following 
goals:

  1) Efficiency: no slowdown in any operation

  2) Memory usage: no increase in the size of any object

  3) Forward compatibility: requires no changes to existing filesystems unless
     it is desired to take advantage of the new functionality.

  4) Incremental approach: no requirement to update all filesystems at the 
     same time.

  5) Appropriate Factorization: the vfs supplies as much generic 
     functionality as it can, so that code does not have to be replicated 
     throughout individual filesystems, but at the same time, does not
     require new elaborate machinery to do so.

  6) Robust approach, not prone to subtle execution errors, and likely to
     survive continued evolution of the code base.

  7) Simple approach, easy to understand.

After considering how to tackle this problem for some time (more than a year)
I settled on the following approach:

  a) Implement vfs support for variable per-filesystem inode and super_block 
     sizes, and for inodes, optional per-filesystem slab caches.

  b) Abstract all references to the current inode and super block unions 
     through (type safe) inline functions, so that the access method can
     be defined at one central point.  The inline function uses an explicit
     cast, eliminating the need for the filesystem-private part of the
     inode to be embedded in the declaration of the system inode.

  c) Apply the above abstraction throughout the Ext2 filesystem, that is,
     change all references to the structure unions to call the inline
     functions for inodes and super blocks respectively.

  d) At this point, fs.h no longer needs to include ext2's private
     structure declarations, so these can be removed, as can the
     ext2-specific members of the unions.

At step (d) the overarching objective has been achieved: individual 
filesystems will include the system headers and not the other way around.

In my implementation, the filesystem-private structures immediately follow 
the generic parts of the inode and super_block structs, as they have done 
traditionally.  The thing that changes is, the structures do not have to be 
declared together.  Instead the addressing calculation is performed by the 
inline access function, and consists simply of adding the size of the generic 
part of an inode to the input address.  Because the function is inline, in 
many cases this can be optimized by the compiler according to context, which 
achieves goal (1) above: the new access code is exactly as fast as the old 
code.

Since inodes and super_blocks become variable sized objects, the vfs needs to 
have some means of knowing their sizes.  My solution here is to encode the 
size of the variable part of the inode and super_block in the structure that 
describes general parameters of filesystem, the file_system_type struct.  
This requires two new integer fields per filesystem type - it is hard to 
imagine a more economical way to express this.

At filesystem registration time, an inode slab cache is created using the 
filesystem type's specified size.  No such cache is created for super_blocks 
since they are relatively few in number.  Instead, super blocks are 
kmalloc'ed according to their specified size.  (Factoid: kmalloc uses a 
cascade of binary-sized slab caches internally.)  In either case, the minimum 
possible memory is used to cache the objects - the situation where all inodes 
in the system had to be the same size as the largest inode is eliminated.  
This satisfies goal (2) above.

If no size is specified for either the inode or super block private areas 
then the objects are allocated in the traditional way.  This provides 
complete forward compatibility with existing filesystems and permits an 
incremental approach to modifying all the filesystems currently in the Linux 
tree, satisfying goals (3) and (4) above.  As well, this allows filesystem 
maintainers to implement the changes needed to use the new approach at a 
convenient time and a convenient pace.

As for goals (4), (5) and (6), the extent to which they have been achieved is 
for you to judge.  My opinion is that they have been satisfied.

Where this is going
-------------------
At this point, I will stop work on these patches (except for maintainance) 
until a concensus is reached on the approach.  Assuming that consensus is 
positive, and assuming Linus blesses it, I will then forward-port the patch 
set to the 2.5 series.  Once integrated, the common vfs mechanism would be 
available for use by all other filesystems in the tree, which at present 
number around 30.  That's a lot, but fortunately, for each filesystem, only 4 
lines need to be changed (deleted) outside the scope of the filesystem 
proper.  In fact, a converted filesystem will function correctly with or 
without these global changes, further simplifying maintainance issues.

After all filesystem-specific includes have been removed from fs.h, it is 
possible to make further improvements: the unions themselves can finally be 
removed, which will require a one-line change to every filesystem and the 
'optional' nature of the filesystem size fields can be changed to 
'mandatory', slightly improving the efficiency of and simplifying the vfs 
code.  Once in the 2.5 tree, the code will no longer have to account for the 
possibility that an inode has a null superblock, again slightly simplifying 
and streamlining it.

It is for consideration whether the generic inode and super_block pointer 
fields should be kept in the common inode or moved into the scope of the 
specific filesystems.  This is a close call.  If the generic pointers do move 
out of the common structures then some special case allocation for inodes 
that use only the generic field should be done, since all will have the same 
size.  In any event, switching from one approach or the other will, at that 
point, have only a small impact on the code base, as opposed to the massive 
impact of the sum total of the changes to all the filesystems that will have 
been carried out by then.

The approach I used to modify Ext2 would work well for all the filesystems in 
the tree.  Most of the work consists of a simple global edit along the lines 
of:

   s/u.ext2_i./ext2_i(inode)->/

After doing this for both inode and super block fields, there will certainly 
be a few odds and ends to clean up, but the total time required for this 
change is likely to be measured in minutes.  Besides that, a pair of inline 
functions along the lines of:

    static inline struct ext2_sb_info *ext2_s(struct super_block *sb)
    {
           return (struct ext2_sb_info *) &(sb->u);
    }

is required.  Note: after all unions have been removed entirely from all the 
filesystems, the expression &(sb->u) above will be replaced by the more 
appealing expression (sb + 1) and the union will be removed from the common 
structures themselves.

Applying and Using the patch
----------------------------
I am running with this patch set applied now.  While I will provide no 
guarantees, it does seems to be working for me.  I have not subjected it to 
stress testing at this point, and I doubt I will have time for it.  I hope 
that someone else will be able to do this and report results.  (Hopefully not 
oopses!)

Note that there is a section of code in fs/super.c bracketed in an #ifdef 1, 
with the comment 'Manfred thinks...' that the code isn't needed at all, and 
that the system will run better without it.  Since I did not want to be 
testing that conjecture and the stability of the patch proper at the same 
time, I conservatively left this code in, as well as my generalization of it. 
Anybody who is interested in seeing if the system actually does run better 
without it is invited to try (I have logged a few hours both ways but without 
benchmarking or stress testing).

If you run the patch, the first thing you may want to do is 'cat 
/proc/slabinfo'.  You will see a slab cache named 'ext2', which holds ext2's 
inodes.  Note the difference in size between that cache and the generic 
inode_cache, which on my system amounts to 64 bytes (improvement!).  This is 
a good way to confirm that the patch set is actually applied and running.

The Patches
-----------
There are four patches in this set:

   1) VFS: changes to support variable sized inodes and super blocks
   2) Ext2: remove all but one references to the inode union
   3) Ext2: remove all but one references to the super block union
   4) Ext2: enable the new functionality and remove the fs.h dependencies

Each patch leaves you with a buildable, working system, but none of the new 
functionality is enabled until the fourth patch is applied.  Patch (3) 
requires patch (2), and patch (4) requires all the other patches. In other 
words, patch (2) and (3) and be applied and tested without changing the VFS, 
if desired.

This patch provides the VFS mechanism for handling filesystem-specific
inode and super block sizes.

To apply:

    cd /your/2.4.17/tree
    cat this/patch | patch -p1

--
Daniel

--- 2.4.17.clean/drivers/block/rd.c	Fri Dec 21 12:41:53 2001
+++ 2.4.17/drivers/block/rd.c	Sun Jan  6 16:29:03 2002
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
--- 2.4.17.clean/fs/inode.c	Fri Dec 21 12:41:55 2001
+++ 2.4.17/fs/inode.c	Sun Jan  6 16:30:25 2002
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
@@ -725,7 +729,16 @@
 	count = inodes_stat.nr_unused / priority;
 
 	prune_icache(count);
+#if 1
+	/* Manfred thinks this isn't necessary */
 	kmem_cache_shrink(inode_cachep);
+	write_lock(&file_systems_lock);
+	for (fs = file_systems; fs; fs = fs->next)
+		if (fs->inode_cache)
+			kmem_cache_shrink(fs->inode_cache);
+	write_unlock(&file_systems_lock);
+	kmem_cache_shrink(inode_cachep);
+#endif
 	return 0;
 }
 
@@ -765,12 +778,14 @@
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
@@ -802,20 +817,19 @@
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
@@ -823,7 +837,7 @@
 		atomic_set(&inode->i_count, 1);
 		inode->i_state = 0;
 		spin_unlock(&inode_lock);
-		clean_inode(inode);
+		init_inode(inode, sb);
 	}
 	return inode;
 }
@@ -838,7 +852,7 @@
 {
 	struct inode * inode;
 
-	inode = alloc_inode();
+	inode = alloc_inode(sb);
 	if (inode) {
 		struct inode * old;
 
@@ -849,7 +863,6 @@
 			inodes_stat.nr_inodes++;
 			list_add(&inode->i_list, &inode_in_use);
 			list_add(&inode->i_hash, head);
-			inode->i_sb = sb;
 			inode->i_dev = sb->s_dev;
 			inode->i_blkbits = sb->s_blocksize_bits;
 			inode->i_ino = ino;
@@ -857,8 +870,7 @@
 			atomic_set(&inode->i_count, 1);
 			inode->i_state = I_LOCK;
 			spin_unlock(&inode_lock);
-
-			clean_inode(inode);
+			init_inode(inode, sb);
 
 			/* reiserfs specific hack right here.  We don't
 			** want this to last, and are looking for VFS changes
@@ -897,6 +909,21 @@
 		wait_on_inode(inode);
 	}
 	return inode;
+}
+
+int create_inode_cache(struct file_system_type *fs)
+{
+	if (fs->inode_size)
+		if (!(fs->inode_cache = kmem_cache_create(fs->name, 
+		    offsetof(struct inode, u) + fs->inode_size,
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
--- 2.4.17.clean/fs/super.c	Fri Dec 21 12:42:03 2001
+++ 2.4.17/fs/super.c	Sun Jan  6 16:29:03 2002
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
@@ -419,11 +422,16 @@
  *	the request.
  */
  
-static struct super_block *alloc_super(void)
+static struct super_block *alloc_super(struct file_system_type *fs)
 {
-	struct super_block *s = kmalloc(sizeof(struct super_block),  GFP_USER);
-	if (s) {
-		memset(s, 0, sizeof(struct super_block));
+	struct super_block *s;
+        unsigned size = fs->super_size?
+	    offsetof(struct super_block, u) + fs->super_size:
+	    sizeof(struct super_block);
+
+	printk(">>> %s super size is %i\n", fs->name, size); // loseme
+	if ((s = kmalloc(size, GFP_USER))) {
+		memset(s, 0, size);
 		INIT_LIST_HEAD(&s->s_dirty);
 		INIT_LIST_HEAD(&s->s_locked_inodes);
 		INIT_LIST_HEAD(&s->s_files);
@@ -446,7 +454,7 @@
 				       void *data)
 {
 	struct super_block * s;
-	s = alloc_super();
+	s = alloc_super(type);
 	if (!s)
 		goto out;
 	s->s_dev = dev;
@@ -578,7 +586,7 @@
 		goto out1;
 
 	error = -ENOMEM;
-	s = alloc_super();
+	s = alloc_super(fs_type);
 	if (!s)
 		goto out1;
 	down_write(&s->s_umount);
@@ -664,7 +672,7 @@
 static struct super_block *get_sb_single(struct file_system_type *fs_type,
 	int flags, void *data)
 {
-	struct super_block * s = alloc_super();
+	struct super_block * s = alloc_super(fs_type);
 	if (!s)
 		return ERR_PTR(-ENOMEM);
 	down_write(&s->s_umount);
--- 2.4.17.clean/include/linux/fs.h	Fri Dec 21 12:42:03 2001
+++ 2.4.17/include/linux/fs.h	Sun Jan  6 17:20:12 2002
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
--- 2.4.17.clean/include/linux/slab.h	Fri Dec 21 12:42:04 2001
+++ 2.4.17/include/linux/slab.h	Sun Jan  6 16:32:28 2002
@@ -57,6 +57,7 @@
 extern int kmem_cache_shrink(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
 extern void kmem_cache_free(kmem_cache_t *, void *);
+extern void kmem_cache_clear(kmem_cache_t *, void *);
 
 extern void *kmalloc(size_t, int);
 extern void kfree(const void *);
--- 2.4.17.clean/mm/slab.c	Fri Dec 21 12:42:05 2001
+++ 2.4.17/mm/slab.c	Sun Jan  6 16:29:03 2002
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
--- 2.4.17.clean/net/socket.c	Fri Dec 21 12:42:06 2001
+++ 2.4.17/net/socket.c	Sun Jan  6 16:29:03 2002
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
