Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266809AbTBGXII>; Fri, 7 Feb 2003 18:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266810AbTBGXII>; Fri, 7 Feb 2003 18:08:08 -0500
Received: from hera.cwi.nl ([192.16.191.8]:11696 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S266809AbTBGXIE>;
	Fri, 7 Feb 2003 18:08:04 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 8 Feb 2003 00:17:37 +0100 (MET)
Message-Id: <UTC200302072317.h17NHbZ08117.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] kill i_cdev and struct char_device
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Struct char_device does nothing but hang in a hash chain,
and consequently is completely superfluous.
The patch below removes it, and the slab cache for them, and
the inode i_cdev field.

[patch against 2.5.59, not clean against current bk;
will resubmit against 2.5.60 when that appears]

[the whole purpose of struct block_device is to provide the link
between a device number and a struct block_device_operations.
struct char_device has no such function, indeed, no function at all]

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/fs/char_dev.c b/fs/char_dev.c
--- a/fs/char_dev.c	Fri Nov 22 22:40:28 2002
+++ b/fs/char_dev.c	Fri Feb  7 23:23:35 2003
@@ -27,109 +27,6 @@
 #define need_serial(ma,mi) (get_tty_driver(mk_kdev(ma,mi)) == NULL)
 #endif
 
-#define HASH_BITS	6
-#define HASH_SIZE	(1UL << HASH_BITS)
-#define HASH_MASK	(HASH_SIZE-1)
-static struct list_head cdev_hashtable[HASH_SIZE];
-static spinlock_t cdev_lock = SPIN_LOCK_UNLOCKED;
-static kmem_cache_t * cdev_cachep;
-
-#define alloc_cdev() \
-	 ((struct char_device *) kmem_cache_alloc(cdev_cachep, SLAB_KERNEL))
-#define destroy_cdev(cdev) kmem_cache_free(cdev_cachep, (cdev))
-
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
-{
-	struct char_device * cdev = (struct char_device *) foo;
-
-	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
-	    SLAB_CTOR_CONSTRUCTOR)
-	{
-		memset(cdev, 0, sizeof(*cdev));
-		sema_init(&cdev->sem, 1);
-	}
-}
-
-void __init cdev_cache_init(void)
-{
-	int i;
-	struct list_head *head = cdev_hashtable;
-
-	i = HASH_SIZE;
-	do {
-		INIT_LIST_HEAD(head);
-		head++;
-		i--;
-	} while (i);
-
-	cdev_cachep = kmem_cache_create("cdev_cache",
-					 sizeof(struct char_device),
-					 0, SLAB_HWCACHE_ALIGN, init_once,
-					 NULL);
-	if (!cdev_cachep)
-		panic("Cannot create cdev_cache SLAB cache");
-}
-
-/*
- * Most likely _very_ bad one - but then it's hardly critical for small
- * /dev and can be fixed when somebody will need really large one.
- */
-static inline unsigned long hash(dev_t dev)
-{
-	unsigned long tmp = dev;
-	tmp = tmp + (tmp >> HASH_BITS) + (tmp >> HASH_BITS*2);
-	return tmp & HASH_MASK;
-}
-
-static struct char_device *cdfind(dev_t dev, struct list_head *head)
-{
-	struct list_head *p;
-	struct char_device *cdev;
-	list_for_each(p, head) {
-		cdev = list_entry(p, struct char_device, hash);
-		if (cdev->dev != dev)
-			continue;
-		atomic_inc(&cdev->count);
-		return cdev;
-	}
-	return NULL;
-}
-
-struct char_device *cdget(dev_t dev)
-{
-	struct list_head * head = cdev_hashtable + hash(dev);
-	struct char_device *cdev, *new_cdev;
-	spin_lock(&cdev_lock);
-	cdev = cdfind(dev, head);
-	spin_unlock(&cdev_lock);
-	if (cdev)
-		return cdev;
-	new_cdev = alloc_cdev();
-	if (!new_cdev)
-		return NULL;
-	atomic_set(&new_cdev->count,1);
-	new_cdev->dev = dev;
-	spin_lock(&cdev_lock);
-	cdev = cdfind(dev, head);
-	if (!cdev) {
-		list_add(&new_cdev->hash, head);
-		spin_unlock(&cdev_lock);
-		return new_cdev;
-	}
-	spin_unlock(&cdev_lock);
-	destroy_cdev(new_cdev);
-	return cdev;
-}
-
-void cdput(struct char_device *cdev)
-{
-	if (atomic_dec_and_lock(&cdev->count, &cdev_lock)) {
-		list_del(&cdev->hash);
-		spin_unlock(&cdev_lock);
-		destroy_cdev(cdev);
-	}
-}
-
 struct device_struct {
 	const char * name;
 	struct file_operations * fops;
@@ -155,11 +52,12 @@
 }
 
 /*
-	Return the function table of a device.
-	Load the driver if needed.
-	Increment the reference count of module in question.
-*/
-static struct file_operations * get_chrfops(unsigned int major, unsigned int minor)
+ *	Return the function table of a device.
+ *	Load the driver if needed.
+ *	Increment the reference count of module in question.
+ */
+static struct file_operations *
+get_chrfops(unsigned int major, unsigned int minor)
 {
 	struct file_operations *ret = NULL;
 
@@ -192,7 +90,9 @@
 	return ret;
 }
 
-int register_chrdev(unsigned int major, const char * name, struct file_operations *fops)
+int
+register_chrdev(unsigned int major, const char *name,
+		struct file_operations *fops)
 {
 	if (devfs_only())
 		return 0;
diff -u --recursive --new-file -X /linux/dontdiff a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c	Fri Nov 22 22:40:20 2002
+++ b/fs/dcache.c	Fri Feb  7 23:40:34 2003
@@ -1424,7 +1424,6 @@
 EXPORT_SYMBOL(d_genocide);
 
 extern void bdev_cache_init(void);
-extern void cdev_cache_init(void);
 
 void __init vfs_caches_init(unsigned long mempages)
 {
@@ -1445,5 +1444,4 @@
 	files_init(mempages); 
 	mnt_init(mempages);
 	bdev_cache_init();
-	cdev_cache_init();
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/devfs/base.c b/fs/devfs/base.c
--- a/fs/devfs/base.c	Sat Jan 18 23:54:40 2003
+++ b/fs/devfs/base.c	Fri Feb  7 23:16:00 2003
@@ -2184,7 +2184,6 @@
     if ( S_ISCHR (de->mode) )
     {
 	inode->i_rdev = to_kdev_t(de->u.cdev.dev);
-	inode->i_cdev = cdget(de->u.cdev.dev);
     }
     else if ( S_ISBLK (de->mode) )
     {
diff -u --recursive --new-file -X /linux/dontdiff a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Sat Jan 18 23:54:29 2003
+++ b/fs/inode.c	Fri Feb  7 23:17:42 2003
@@ -117,7 +117,6 @@
 		memset(&inode->i_dquot, 0, sizeof(inode->i_dquot));
 		inode->i_pipe = NULL;
 		inode->i_bdev = NULL;
-		inode->i_cdev = NULL;
 		inode->i_security = NULL;
 		if (security_inode_alloc(inode)) {
 			if (inode->i_sb->s_op->destroy_inode)
@@ -229,10 +228,6 @@
 		inode->i_sb->s_op->clear_inode(inode);
 	if (inode->i_bdev)
 		bd_forget(inode);
-	else if (inode->i_cdev) {
-		cdput(inode->i_cdev);
-		inode->i_cdev = NULL;
-	}
 	inode->i_state = I_CLEAR;
 }
 
@@ -1272,7 +1267,6 @@
 	if (S_ISCHR(mode)) {
 		inode->i_fop = &def_chr_fops;
 		inode->i_rdev = to_kdev_t(rdev);
-		inode->i_cdev = cdget(rdev);
 	} else if (S_ISBLK(mode)) {
 		inode->i_fop = &def_blk_fops;
 		inode->i_rdev = to_kdev_t(rdev);
@@ -1281,5 +1275,6 @@
 	else if (S_ISSOCK(mode))
 		inode->i_fop = &bad_sock_fops;
 	else
-		printk(KERN_DEBUG "init_special_inode: bogus i_mode (%o)\n", mode);
+		printk(KERN_DEBUG "init_special_inode: bogus i_mode (%o)\n",
+		       mode);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Sat Jan 18 23:54:40 2003
+++ b/include/linux/fs.h	Fri Feb  7 23:19:28 2003
@@ -328,14 +328,6 @@
 	struct address_space	*assoc_mapping;	/* ditto */
 };
 
-struct char_device {
-	struct list_head	hash;
-	atomic_t		count;
-	dev_t			dev;
-	atomic_t		openers;
-	struct semaphore	sem;
-};
-
 struct block_device {
 	struct list_head	bd_hash;
 	atomic_t		bd_count;
@@ -382,11 +374,11 @@
 	struct address_space	*i_mapping;
 	struct address_space	i_data;
 	struct dquot		*i_dquot[MAXQUOTAS];
+
 	/* These three should probably be a union */
 	struct list_head	i_devices;
 	struct pipe_inode_info	*i_pipe;
 	struct block_device	*i_bdev;
-	struct char_device	*i_cdev;
 
 	unsigned long		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
@@ -1070,8 +1062,6 @@
 extern int bd_acquire(struct inode *inode);
 extern void bd_forget(struct inode *inode);
 extern void bdput(struct block_device *);
-extern struct char_device *cdget(dev_t);
-extern void cdput(struct char_device *);
 extern int blkdev_open(struct inode *, struct file *);
 extern int blkdev_close(struct inode *, struct file *);
 extern struct file_operations def_blk_fops;
diff -u --recursive --new-file -X /linux/dontdiff a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Sat Jan 18 23:54:35 2003
+++ b/kernel/ksyms.c	Fri Feb  7 23:28:40 2003
@@ -203,8 +203,6 @@
 EXPORT_SYMBOL(set_blocksize);
 EXPORT_SYMBOL(sb_set_blocksize);
 EXPORT_SYMBOL(sb_min_blocksize);
-EXPORT_SYMBOL(cdget);
-EXPORT_SYMBOL(cdput);
 EXPORT_SYMBOL(bdget);
 EXPORT_SYMBOL(bdput);
 EXPORT_SYMBOL(bd_claim);
