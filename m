Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262539AbTCRVeZ>; Tue, 18 Mar 2003 16:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262551AbTCRVeZ>; Tue, 18 Mar 2003 16:34:25 -0500
Received: from hera.cwi.nl ([192.16.191.8]:45551 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262539AbTCRVeT>;
	Tue, 18 Mar 2003 16:34:19 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 18 Mar 2003 22:45:14 +0100 (MET)
Message-Id: <UTC200303182145.h2ILjEB29313.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] dev_t [1/3]
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that 2.5.65 is out, the next dev_t patch.
It was a bit large and unreadable, so I split it into
three clean pieces. Afterwards, since many people ask
for this, a fourth patch that actually changes the
type of dev_t (not to be applied yet, that is just for
playing).

The first patch is the cdev-kill patch that I sent out
earlier. It is no use having two forms of chardev registration
in the source, and my version of the path of small modifications
does not pass through this version, although the final result
will not be that different. So, kill cdev_cachep, cdev_cache_init,
cdfind, cdget, cdput, inode->i_cdev, struct char_device.
All of this is dead code today.

The second patch removes MAX_CHRDEV.

The third patch polishes linux/major.h.

The fourth patch, not to be applied, changes the type of dev_t.

Andries

--------------- 01-cdev-kill ---------------
diff -u --recursive --new-file -X /linux/dontdiff a/fs/char_dev.c b/fs/char_dev.c
--- a/fs/char_dev.c	Tue Mar 18 11:48:22 2003
+++ b/fs/char_dev.c	Tue Mar 18 21:14:21 2003
@@ -23,110 +23,10 @@
 
 /* serial module kmod load support */
 struct tty_driver *get_tty_driver(kdev_t device);
-#define isa_tty_dev(ma)	(ma == TTY_MAJOR || ma == TTYAUX_MAJOR)
+#define is_a_tty_dev(ma)	(ma == TTY_MAJOR || ma == TTYAUX_MAJOR)
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
-static void init_once(void *foo, kmem_cache_t *cachep, unsigned long flags)
-{
-	struct char_device *cdev = (struct char_device *) foo;
-
-	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
-	    SLAB_CTOR_CONSTRUCTOR)
-		memset(cdev, 0, sizeof(*cdev));
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
@@ -144,7 +44,8 @@
 	read_lock(&chrdevs_lock);
 	for (i = 0; i < MAX_CHRDEV ; i++) {
 		if (chrdevs[i].fops) {
-			len += sprintf(page+len, "%3d %s\n", i, chrdevs[i].name);
+			len += sprintf(page+len, "%3d %s\n",
+				       i, chrdevs[i].name);
 		}
 	}
 	read_unlock(&chrdevs_lock);
@@ -152,13 +53,14 @@
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
-	struct file_operations *ret = NULL;
+	struct file_operations *ret;
 
 	if (!major || major >= MAX_CHRDEV)
 		return NULL;
@@ -167,10 +69,12 @@
 	ret = fops_get(chrdevs[major].fops);
 	read_unlock(&chrdevs_lock);
 #ifdef CONFIG_KMOD
-	if (ret && isa_tty_dev(major)) {
+	if (ret && is_a_tty_dev(major)) {
 		lock_kernel();
 		if (need_serial(major,minor)) {
 			/* Force request_module anyway, but what for? */
+			/* The reason is that we may have a driver for
+			   /dev/tty1 already, but need one for /dev/ttyS1. */
 			fops_put(ret);
 			ret = NULL;
 		}
@@ -189,7 +93,8 @@
 	return ret;
 }
 
-int register_chrdev(unsigned int major, const char * name, struct file_operations *fops)
+int register_chrdev(unsigned int major, const char *name,
+		    struct file_operations *fops)
 {
 	if (major == 0) {
 		write_lock(&chrdevs_lock);
diff -u --recursive --new-file -X /linux/dontdiff a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c	Tue Mar 18 11:48:22 2003
+++ b/fs/dcache.c	Tue Mar 18 21:14:21 2003
@@ -1562,7 +1562,6 @@
 EXPORT_SYMBOL(d_genocide);
 
 extern void bdev_cache_init(void);
-extern void cdev_cache_init(void);
 
 void __init vfs_caches_init(unsigned long mempages)
 {
@@ -1583,5 +1582,4 @@
 	files_init(mempages); 
 	mnt_init(mempages);
 	bdev_cache_init();
-	cdev_cache_init();
 }
diff -u --recursive --new-file -X /linux/dontdiff a/fs/devfs/base.c b/fs/devfs/base.c
--- a/fs/devfs/base.c	Tue Mar 18 11:48:22 2003
+++ b/fs/devfs/base.c	Tue Mar 18 21:14:21 2003
@@ -2119,7 +2119,6 @@
     if ( S_ISCHR (de->mode) )
     {
 	inode->i_rdev = to_kdev_t(de->u.cdev.dev);
-	inode->i_cdev = cdget(de->u.cdev.dev);
     }
     else if ( S_ISBLK (de->mode) )
     {
diff -u --recursive --new-file -X /linux/dontdiff a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Tue Mar 18 11:48:22 2003
+++ b/fs/inode.c	Tue Mar 18 21:14:48 2003
@@ -128,7 +128,6 @@
 		memset(&inode->i_dquot, 0, sizeof(inode->i_dquot));
 		inode->i_pipe = NULL;
 		inode->i_bdev = NULL;
-		inode->i_cdev = NULL;
 		inode->i_rdev = to_kdev_t(0);
 		inode->i_security = NULL;
 		if (security_inode_alloc(inode)) {
@@ -242,10 +241,6 @@
 		inode->i_sb->s_op->clear_inode(inode);
 	if (inode->i_bdev)
 		bd_forget(inode);
-	else if (inode->i_cdev) {
-		cdput(inode->i_cdev);
-		inode->i_cdev = NULL;
-	}
 	inode->i_state = I_CLEAR;
 }
 
@@ -1293,7 +1288,6 @@
 	if (S_ISCHR(mode)) {
 		inode->i_fop = &def_chr_fops;
 		inode->i_rdev = to_kdev_t(rdev);
-		inode->i_cdev = cdget(rdev);
 	} else if (S_ISBLK(mode)) {
 		inode->i_fop = &def_blk_fops;
 		inode->i_rdev = to_kdev_t(rdev);
@@ -1302,5 +1296,6 @@
 	else if (S_ISSOCK(mode))
 		inode->i_fop = &bad_sock_fops;
 	else
-		printk(KERN_DEBUG "init_special_inode: bogus i_mode (%o)\n", mode);
+		printk(KERN_DEBUG "init_special_inode: bogus i_mode (%o)\n",
+		       mode);
 }
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Tue Mar 18 11:48:23 2003
+++ b/include/linux/fs.h	Tue Mar 18 21:14:21 2003
@@ -329,12 +329,6 @@
 	struct address_space	*assoc_mapping;	/* ditto */
 };
 
-struct char_device {
-	struct list_head	hash;
-	atomic_t		count;
-	dev_t			dev;
-};
-
 struct block_device {
 	struct list_head	bd_hash;
 	atomic_t		bd_count;
@@ -386,7 +380,6 @@
 	struct list_head	i_devices;
 	struct pipe_inode_info	*i_pipe;
 	struct block_device	*i_bdev;
-	struct char_device	*i_cdev;
 
 	unsigned long		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
@@ -1044,8 +1037,6 @@
 extern int bd_acquire(struct inode *inode);
 extern void bd_forget(struct inode *inode);
 extern void bdput(struct block_device *);
-extern struct char_device *cdget(dev_t);
-extern void cdput(struct char_device *);
 extern int blkdev_open(struct inode *, struct file *);
 extern int blkdev_close(struct inode *, struct file *);
 extern struct file_operations def_blk_fops;
diff -u --recursive --new-file -X /linux/dontdiff a/kernel/ksyms.c b/kernel/ksyms.c
--- a/kernel/ksyms.c	Tue Mar 18 11:48:23 2003
+++ b/kernel/ksyms.c	Tue Mar 18 21:14:21 2003
@@ -202,8 +202,6 @@
 EXPORT_SYMBOL(set_blocksize);
 EXPORT_SYMBOL(sb_set_blocksize);
 EXPORT_SYMBOL(sb_min_blocksize);
-EXPORT_SYMBOL(cdget);
-EXPORT_SYMBOL(cdput);
 EXPORT_SYMBOL(bdget);
 EXPORT_SYMBOL(bdput);
 EXPORT_SYMBOL(bd_claim);
