Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261737AbREVOSx>; Tue, 22 May 2001 10:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbREVOSo>; Tue, 22 May 2001 10:18:44 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:31667 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261737AbREVOS3>;
	Tue, 22 May 2001 10:18:29 -0400
Date: Tue, 22 May 2001 10:18:28 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] struct char_device
Message-ID: <Pine.GSO.4.21.0105221007460.15685-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linus, patch below adds the missing half of kdev_t -
for block devices we already have a unique pointer (struct block_device *,
inode->i_bdev) and that adds a similar animal for character devices.
	That is, it adds a new structure (struct char_device) and a cache
indexed by dev_t. init_special_inode() sets ->i_cdev to corresponding
element of cache (creating it if needed).
	Result: ->i_cdev is shared by all inodes of given character device
(i.e. if we need per-device objects we can put them there), we can use
stuct char_device * as ID for character devices, we can (in 2.5) get
rid of i_rdev - it's covered by ->i_bdev and ->i_cdev now.
	Patch is pretty straightforward - cache handling is lifted from
fs/block_device, the rest is trivial.
	Please, consider applying.
							Al

diff -urN S5-pre4/fs/Makefile S5-pre4-cdev/fs/Makefile
--- S5-pre4/fs/Makefile	Thu May  3 17:13:26 2001
+++ S5-pre4-cdev/fs/Makefile	Tue May 22 09:12:11 2001
@@ -11,8 +11,8 @@
 mod-subdirs :=	nls
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
-		super.o  block_dev.o stat.o exec.o pipe.o namei.o fcntl.o \
-		ioctl.o readdir.o select.o fifo.o locks.o \
+		super.o block_dev.o char_dev.o stat.o exec.o pipe.o namei.o \
+		fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
 		filesystems.o
 
diff -urN S5-pre4/fs/block_dev.c S5-pre4-cdev/fs/block_dev.c
--- S5-pre4/fs/block_dev.c	Sat May 19 22:46:35 2001
+++ S5-pre4-cdev/fs/block_dev.c	Tue May 22 08:34:44 2001
@@ -392,7 +392,7 @@
 	}
 }
 
-void __init bdev_init(void)
+void __init bdev_cache_init(void)
 {
 	int i;
 	struct list_head *head = bdev_hashtable;
diff -urN S5-pre4/fs/char_dev.c S5-pre4-cdev/fs/char_dev.c
--- S5-pre4/fs/char_dev.c	Wed Dec 31 19:00:00 1969
+++ S5-pre4-cdev/fs/char_dev.c	Tue May 22 10:03:10 2001
@@ -0,0 +1,114 @@
+/*
+ *  linux/fs/block_dev.c
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+
+#define HASH_BITS	6
+#define HASH_SIZE	(1UL << HASH_BITS)
+#define HASH_MASK	(HASH_SIZE-1)
+static struct list_head cdev_hashtable[HASH_SIZE];
+static spinlock_t cdev_lock = SPIN_LOCK_UNLOCKED;
+static kmem_cache_t * cdev_cachep;
+
+#define alloc_cdev() \
+	 ((struct char_device *) kmem_cache_alloc(cdev_cachep, SLAB_KERNEL))
+#define destroy_cdev(cdev) kmem_cache_free(cdev_cachep, (cdev))
+
+static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+{
+	struct char_device * cdev = (struct char_device *) foo;
+
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR)
+	{
+		memset(cdev, 0, sizeof(*cdev));
+		sema_init(&cdev->sem, 1);
+	}
+}
+
+void __init cdev_cache_init(void)
+{
+	int i;
+	struct list_head *head = cdev_hashtable;
+
+	i = HASH_SIZE;
+	do {
+		INIT_LIST_HEAD(head);
+		head++;
+		i--;
+	} while (i);
+
+	cdev_cachep = kmem_cache_create("cdev_cache",
+					 sizeof(struct char_device),
+					 0, SLAB_HWCACHE_ALIGN, init_once,
+					 NULL);
+	if (!cdev_cachep)
+		panic("Cannot create cdev_cache SLAB cache");
+}
+
+/*
+ * Most likely _very_ bad one - but then it's hardly critical for small
+ * /dev and can be fixed when somebody will need really large one.
+ */
+static inline unsigned long hash(dev_t dev)
+{
+	unsigned long tmp = dev;
+	tmp = tmp + (tmp >> HASH_BITS) + (tmp >> HASH_BITS*2);
+	return tmp & HASH_MASK;
+}
+
+static struct char_device *cdfind(dev_t dev, struct list_head *head)
+{
+	struct list_head *p;
+	struct char_device *cdev;
+	for (p=head->next; p!=head; p=p->next) {
+		cdev = list_entry(p, struct char_device, hash);
+		if (cdev->dev != dev)
+			continue;
+		atomic_inc(&cdev->count);
+		return cdev;
+	}
+	return NULL;
+}
+
+struct char_device *cdget(dev_t dev)
+{
+	struct list_head * head = cdev_hashtable + hash(dev);
+	struct char_device *cdev, *new_cdev;
+	spin_lock(&cdev_lock);
+	cdev = cdfind(dev, head);
+	spin_unlock(&cdev_lock);
+	if (cdev)
+		return cdev;
+	new_cdev = alloc_cdev();
+	if (!new_cdev)
+		return NULL;
+	atomic_set(&new_cdev->count,1);
+	new_cdev->dev = dev;
+	spin_lock(&cdev_lock);
+	cdev = cdfind(dev, head);
+	if (!cdev) {
+		list_add(&new_cdev->hash, head);
+		spin_unlock(&cdev_lock);
+		return new_cdev;
+	}
+	spin_unlock(&cdev_lock);
+	destroy_cdev(new_cdev);
+	return cdev;
+}
+
+void cdput(struct char_device *cdev)
+{
+	if (atomic_dec_and_test(&cdev->count)) {
+		spin_lock(&cdev_lock);
+		list_del(&cdev->hash);
+		spin_unlock(&cdev_lock);
+		destroy_cdev(cdev);
+	}
+}
+
diff -urN S5-pre4/fs/dcache.c S5-pre4-cdev/fs/dcache.c
--- S5-pre4/fs/dcache.c	Sat Apr 28 02:12:56 2001
+++ S5-pre4-cdev/fs/dcache.c	Tue May 22 09:22:43 2001
@@ -1250,6 +1250,9 @@
 kmem_cache_t *bh_cachep;
 EXPORT_SYMBOL(bh_cachep);
 
+extern void bdev_cache_init(void);
+extern void cdev_cache_init(void);
+
 void __init vfs_caches_init(unsigned long mempages)
 {
 	bh_cachep = kmem_cache_create("buffer_head",
@@ -1279,4 +1282,7 @@
 #endif
 
 	dcache_init(mempages);
+	inode_init(mempages);
+	bdev_cache_init();
+	cdev_cache_init();
 }
diff -urN S5-pre4/fs/devfs/base.c S5-pre4-cdev/fs/devfs/base.c
--- S5-pre4/fs/devfs/base.c	Sat May 19 22:46:35 2001
+++ S5-pre4-cdev/fs/devfs/base.c	Tue May 22 08:51:03 2001
@@ -2256,6 +2256,7 @@
     {
 	inode->i_rdev = MKDEV (de->u.fcb.u.device.major,
 			       de->u.fcb.u.device.minor);
+	inode->i_cdev = cdget (kdev_t_to_nr(inode->i_rdev));
     }
     else if ( S_ISBLK (de->inode.mode) )
     {
diff -urN S5-pre4/fs/devices.c S5-pre4-cdev/fs/devices.c
--- S5-pre4/fs/devices.c	Fri Feb 16 19:00:19 2001
+++ S5-pre4-cdev/fs/devices.c	Tue May 22 08:31:04 2001
@@ -203,6 +203,7 @@
 	if (S_ISCHR(mode)) {
 		inode->i_fop = &def_chr_fops;
 		inode->i_rdev = to_kdev_t(rdev);
+		inode->i_cdev = cdget(rdev);
 	} else if (S_ISBLK(mode)) {
 		inode->i_fop = &def_blk_fops;
 		inode->i_rdev = to_kdev_t(rdev);
diff -urN S5-pre4/fs/inode.c S5-pre4-cdev/fs/inode.c
--- S5-pre4/fs/inode.c	Sat May 19 22:46:35 2001
+++ S5-pre4-cdev/fs/inode.c	Mon May 21 22:49:48 2001
@@ -497,6 +497,10 @@
 		bdput(inode->i_bdev);
 		inode->i_bdev = NULL;
 	}
+	if (inode->i_cdev) {
+		cdput(inode->i_cdev);
+		inode->i_cdev = NULL;
+	}
 	inode->i_state = I_CLEAR;
 }
 
@@ -750,6 +754,7 @@
 	memset(&inode->i_dquot, 0, sizeof(inode->i_dquot));
 	inode->i_pipe = NULL;
 	inode->i_bdev = NULL;
+	inode->i_cdev = NULL;
 	inode->i_data.a_ops = &empty_aops;
 	inode->i_data.host = inode;
 	inode->i_data.gfp_mask = GFP_HIGHUSER;
diff -urN S5-pre4/include/linux/fs.h S5-pre4-cdev/include/linux/fs.h
--- S5-pre4/include/linux/fs.h	Sat May 19 22:46:36 2001
+++ S5-pre4-cdev/include/linux/fs.h	Tue May 22 09:14:25 2001
@@ -384,6 +384,14 @@
 	int			gfp_mask;	/* how to allocate the pages */
 };
 
+struct char_device {
+	struct list_head	hash;
+	atomic_t		count;
+	dev_t			dev;
+	atomic_t		openers;
+	struct semaphore	sem;
+};
+
 struct block_device {
 	struct list_head	bd_hash;
 	atomic_t		bd_count;
@@ -426,8 +434,10 @@
 	struct address_space	*i_mapping;
 	struct address_space	i_data;	
 	struct dquot		*i_dquot[MAXQUOTAS];
+	/* These three should probably be a union */
 	struct pipe_inode_info	*i_pipe;
 	struct block_device	*i_bdev;
+	struct char_device	*i_cdev;
 
 	unsigned long		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
@@ -982,6 +992,8 @@
 extern int unregister_blkdev(unsigned int, const char *);
 extern struct block_device *bdget(dev_t);
 extern void bdput(struct block_device *);
+extern struct char_device *cdget(dev_t);
+extern void cdput(struct char_device *);
 extern int blkdev_open(struct inode *, struct file *);
 extern struct file_operations def_blk_fops;
 extern struct file_operations def_fifo_fops;
diff -urN S5-pre4/init/main.c S5-pre4-cdev/init/main.c
--- S5-pre4/init/main.c	Sat May 19 22:46:36 2001
+++ S5-pre4-cdev/init/main.c	Tue May 22 08:34:09 2001
@@ -93,7 +93,6 @@
 extern void ppc_init(void);
 extern void sysctl_init(void);
 extern void signals_init(void);
-extern void bdev_init(void);
 extern int init_pcmcia_ds(void);
 extern void net_notifier_init(void);
 
@@ -569,8 +568,6 @@
 	ccwcache_init();
 #endif
 	signals_init();
-	bdev_init();
-	inode_init(mempages);
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
 #endif
diff -urN S5-pre4/kernel/ksyms.c S5-pre4-cdev/kernel/ksyms.c
--- S5-pre4/kernel/ksyms.c	Sat May 19 22:46:37 2001
+++ S5-pre4-cdev/kernel/ksyms.c	Tue May 22 09:06:47 2001
@@ -186,6 +186,8 @@
 EXPORT_SYMBOL(notify_change);
 EXPORT_SYMBOL(set_blocksize);
 EXPORT_SYMBOL(getblk);
+EXPORT_SYMBOL(cdget);
+EXPORT_SYMBOL(cdput);
 EXPORT_SYMBOL(bdget);
 EXPORT_SYMBOL(bdput);
 EXPORT_SYMBOL(bread);

