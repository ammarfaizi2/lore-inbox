Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292000AbSBYRU1>; Mon, 25 Feb 2002 12:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291989AbSBYRUQ>; Mon, 25 Feb 2002 12:20:16 -0500
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:3456 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290109AbSBYRTw>;
	Mon, 25 Feb 2002 12:19:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net
Subject: [PATCH] Son of Unbork (1 of 3)
Date: Sat, 23 Feb 2002 19:12:36 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16egez-00006K-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This three patch set completes the removal of ext2-specific includes from 
fs.h.  When this is done, your kernel will compile a little faster, the Ext2 
source will be organized a little better, and then infamous fs.h super_block 
union will no longer hurt your eyes.  When every filesystem has been changed 
in a similar way, fs.h will finally be generic, in-memory super_blocks will be
somewhat smaller, and the kernel will compile quite a lot faster.  And peace
will come once more to Middle-Earth.  (I made that last part up.)

Patch 1 adds alloc_super and destroy_super methods to struct file_system.  A 
filesystem that supplies these methods must take care of its own superblock 
allocation and freeing.  A filesystem that does not supply these methods will 
continue to have its superblocks allocated according to the size of struct 
super_block, including the remaining unions of filesystem-private data.

Eventually, all filesystems will use the private allocation methods, and the 
filesystem-private union will be removed entirely.  For now the union remains,
though it will soon start to shrink, saving space in the smaller superblocks.

Patch 2 of this set (it's a long one) provides all the necessary changes to 
Ext2 to take advantage of the new superblock allocation methods, and removes
the existing dependency on Ext2 from fs.h.

The last patch of this set removes two header files that are made redundant
by the preceding two patches.

To apply:

    cd /your/source/tree/..
    patch -p1 <this/patch

-- 
Daniel

--- 2.5.5.clean/fs/super.c	Wed Feb 20 03:11:02 2002
+++ 2.5.5/fs/super.c	Sat Feb 23 15:31:50 2002
@@ -238,7 +238,7 @@
 struct file_system_type *get_fs_type(const char *name)
 {
 	struct file_system_type *fs;
-	
+
 	read_lock(&file_systems_lock);
 	fs = *(find_filesystem(name));
 	if (fs && !try_inc_mod_count(fs->owner))
@@ -256,13 +256,15 @@
 
 /**
  *	alloc_super	-	create new superblock
+ *	@type: filesystem type
  *
  *	Allocates and initializes a new &struct super_block.  alloc_super()
- *	returns a pointer new superblock or %NULL if allocation had failed.
+ *	returns a pointer to new superblock or %NULL if allocation failed.
  */
-static struct super_block *alloc_super(void)
+static struct super_block *alloc_super(struct file_system_type *type)
 {
-	struct super_block *s = kmalloc(sizeof(struct super_block),  GFP_USER);
+	struct super_block *s = (type->alloc_super)? (type->alloc_super)():
+		kmalloc(sizeof(struct super_block), GFP_USER);
 	if (s) {
 		memset(s, 0, sizeof(struct super_block));
 		INIT_LIST_HEAD(&s->s_dirty);
@@ -279,6 +281,7 @@
 		sema_init(&s->s_dquot.dqio_sem, 1);
 		sema_init(&s->s_dquot.dqoff_sem, 1);
 		s->s_maxbytes = MAX_NON_LFS;
+		s->s_type = type;
 	}
 	return s;
 }
@@ -289,9 +292,12 @@
  *
  *	Frees a superblock.
  */
-static inline void destroy_super(struct super_block *s)
+static inline void destroy_super(struct super_block *sb)
 {
-	kfree(s);
+	if (sb->s_type->destroy_super)
+		sb->s_type->destroy_super(sb);
+	else
+		kfree(sb);
 }
 
 /* Superblock refcounting  */
@@ -357,22 +363,20 @@
 	put_super(s);
 	return 0;
 }
- 
+
 /**
  *	insert_super	-	put superblock on the lists
  *	@s:	superblock in question
- *	@type:	filesystem type it will belong to
  *
  *	Associates superblock with fs type and puts it on per-type and global
  *	superblocks' lists.  Should be called with sb_lock held; drops it.
  */
-static void insert_super(struct super_block *s, struct file_system_type *type)
+static void insert_super(struct super_block *sb)
 {
-	s->s_type = type;
-	list_add(&s->s_list, super_blocks.prev);
-	list_add(&s->s_instances, &type->fs_supers);
+	list_add(&sb->s_list, super_blocks.prev);
+	list_add(&sb->s_instances, &sb->s_type->fs_supers);
 	spin_unlock(&sb_lock);
-	get_filesystem(type);
+	get_filesystem(sb->s_type);
 }
 
 static void put_anon_dev(kdev_t dev);
@@ -481,7 +485,7 @@
  *	Scans the superblock list and finds the superblock of the file system
  *	mounted on the device given. %NULL is returned if no match is found.
  */
- 
+
 struct super_block * get_super(kdev_t dev)
 {
 	struct super_block * s;
@@ -603,7 +607,7 @@
 struct super_block *get_anon_super(struct file_system_type *type,
 	int (*compare)(struct super_block *,void *), void *data)
 {
-	struct super_block *s = alloc_super();
+	struct super_block *s = alloc_super(type);
 	int dev;
 	struct list_head *p;
 
@@ -634,7 +638,7 @@
 	}
 
 	s->s_dev = mk_kdev(0, dev);
-	insert_super(s, type);
+	insert_super(s);
 	return s;
 }
 
@@ -686,7 +690,7 @@
 		goto out1;
 
 	error = -ENOMEM;
-	s = alloc_super();
+	s = alloc_super(fs_type);
 	if (!s)
 		goto out1;
 
@@ -714,7 +718,7 @@
 	s->s_dev = dev;
 	s->s_bdev = bdev;
 	s->s_flags = flags;
-	insert_super(s, fs_type);
+	insert_super(s);
 	strncpy(s->s_id, bdevname(dev), sizeof(s->s_id));
 	error = fill_super(s, data, flags & MS_VERBOSE ? 1 : 0);
 	if (error)
--- 2.5.5.clean/include/linux/fs.h	Wed Feb 20 03:10:58 2002
+++ 2.5.5/include/linux/fs.h	Sat Feb 23 15:31:50 2002
@@ -941,6 +941,8 @@
 struct file_system_type {
 	const char *name;
 	int fs_flags;
+	struct super_block *(*alloc_super) (void);
+	void (*destroy_super) (struct super_block *);
 	struct super_block *(*get_sb) (struct file_system_type *, int, char *, void *);
 	struct module *owner;
 	struct file_system_type * next;

