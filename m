Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbTCYNoD>; Tue, 25 Mar 2003 08:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262647AbTCYNoD>; Tue, 25 Mar 2003 08:44:03 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:60943 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262646AbTCYNnr>; Tue, 25 Mar 2003 08:43:47 -0500
Date: Tue, 25 Mar 2003 14:54:54 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] restore character device hash
Message-ID: <Pine.LNX.4.44.0303251454340.16750-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch restores the character device hash, which will is more
suitable to manage a large number of character devices.
I used the chance to add a grep-friendly prefix to the char_device
members.

bye, Roman

diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev1/fs/char_dev.c linux-2.5.66-cdev2/fs/char_dev.c
--- linux-2.5.66-cdev1/fs/char_dev.c	2003-03-25 11:02:13.000000000 +0100
+++ linux-2.5.66-cdev2/fs/char_dev.c	2003-03-25 11:02:27.000000000 +0100
@@ -23,10 +23,114 @@
 
 /* serial module kmod load support */
 struct tty_driver *get_tty_driver(kdev_t device);
-#define is_a_tty_dev(ma)	(ma == TTY_MAJOR || ma == TTYAUX_MAJOR)
+#define isa_tty_dev(ma)	(ma == TTY_MAJOR || ma == TTYAUX_MAJOR)
 #define need_serial(ma,mi) (get_tty_driver(mk_kdev(ma,mi)) == NULL)
 #endif
 
+#define HASH_BITS	6
+#define HASH_SIZE	(1UL << HASH_BITS)
+#define HASH_MASK	(HASH_SIZE-1)
+static struct list_head cdev_hashtable[HASH_SIZE];
+static spinlock_t cdev_lock = SPIN_LOCK_UNLOCKED;
+static kmem_cache_t *cdev_cachep;
+
+#define alloc_cdev() \
+	 ((struct char_device *) kmem_cache_alloc(cdev_cachep, SLAB_KERNEL))
+#define destroy_cdev(cdev) kmem_cache_free(cdev_cachep, (cdev))
+
+static void init_once(void *foo, kmem_cache_t *cachep, unsigned long flags)
+{
+	struct char_device *cdev = (struct char_device *) foo;
+
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR)
+		memset(cdev, 0, sizeof(*cdev));
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
+
+	list_for_each(p, head) {
+		cdev = list_entry(p, struct char_device, cd_hash);
+		if (cdev->cd_dev == dev) {
+			atomic_inc(&cdev->cd_count);
+			return cdev;
+		}
+	}
+	return NULL;
+}
+
+struct char_device *cdget(dev_t dev)
+{
+	struct list_head * head = cdev_hashtable + hash(dev);
+	struct char_device *cdev, *new_cdev;
+
+	spin_lock(&cdev_lock);
+	cdev = cdfind(dev, head);
+	spin_unlock(&cdev_lock);
+	if (cdev)
+		return cdev;
+
+	new_cdev = alloc_cdev();
+	if (!new_cdev)
+		return NULL;
+	atomic_set(&new_cdev->cd_count, 1);
+	new_cdev->cd_dev = dev;
+
+	spin_lock(&cdev_lock);
+	cdev = cdfind(dev, head);
+	if (!cdev) {
+		list_add(&new_cdev->cd_hash, head);
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
+	if (atomic_dec_and_lock(&cdev->cd_count, &cdev_lock)) {
+		list_del(&cdev->cd_hash);
+		spin_unlock(&cdev_lock);
+		destroy_cdev(cdev);
+	}
+}
+
 struct device_struct {
 	const char * name;
 	struct file_operations * fops;
@@ -44,8 +148,7 @@ int get_chrdev_list(char *page)
 	read_lock(&chrdevs_lock);
 	for (i = 0; i < MAX_CHRDEV ; i++) {
 		if (chrdevs[i].fops) {
-			len += sprintf(page+len, "%3d %s\n",
-				       i, chrdevs[i].name);
+			len += sprintf(page+len, "%3d %s\n", i, chrdevs[i].name);
 		}
 	}
 	read_unlock(&chrdevs_lock);
@@ -53,14 +156,13 @@ int get_chrdev_list(char *page)
 }
 
 /*
- *	Return the function table of a device.
- *	Load the driver if needed.
- *	Increment the reference count of module in question.
- */
-static struct file_operations *
-get_chrfops(unsigned int major, unsigned int minor)
+	Return the function table of a device.
+	Load the driver if needed.
+	Increment the reference count of module in question.
+*/
+static struct file_operations * get_chrfops(unsigned int major, unsigned int minor)
 {
-	struct file_operations *ret;
+	struct file_operations *ret = NULL;
 
 	if (!major || major >= MAX_CHRDEV)
 		return NULL;
@@ -69,12 +171,10 @@ get_chrfops(unsigned int major, unsigned
 	ret = fops_get(chrdevs[major].fops);
 	read_unlock(&chrdevs_lock);
 #ifdef CONFIG_KMOD
-	if (ret && is_a_tty_dev(major)) {
+	if (ret && isa_tty_dev(major)) {
 		lock_kernel();
 		if (need_serial(major,minor)) {
 			/* Force request_module anyway, but what for? */
-			/* The reason is that we may have a driver for
-			   /dev/tty1 already, but need one for /dev/ttyS1. */
 			fops_put(ret);
 			ret = NULL;
 		}
@@ -93,8 +193,7 @@ get_chrfops(unsigned int major, unsigned
 	return ret;
 }
 
-int register_chrdev(unsigned int major, const char *name,
-		    struct file_operations *fops)
+int register_chrdev(unsigned int major, const char * name, struct file_operations *fops)
 {
 	if (major == 0) {
 		write_lock(&chrdevs_lock);
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev1/fs/dcache.c linux-2.5.66-cdev2/fs/dcache.c
--- linux-2.5.66-cdev1/fs/dcache.c	2003-03-25 10:47:05.000000000 +0100
+++ linux-2.5.66-cdev2/fs/dcache.c	2003-03-25 11:02:27.000000000 +0100
@@ -1564,6 +1564,7 @@ kmem_cache_t *filp_cachep;
 EXPORT_SYMBOL(d_genocide);
 
 extern void bdev_cache_init(void);
+extern void cdev_cache_init(void);
 
 void __init vfs_caches_init(unsigned long mempages)
 {
@@ -1584,4 +1585,5 @@ void __init vfs_caches_init(unsigned lon
 	files_init(mempages); 
 	mnt_init(mempages);
 	bdev_cache_init();
+	cdev_cache_init();
 }
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev1/fs/devfs/base.c linux-2.5.66-cdev2/fs/devfs/base.c
--- linux-2.5.66-cdev1/fs/devfs/base.c	2003-03-25 10:47:10.000000000 +0100
+++ linux-2.5.66-cdev2/fs/devfs/base.c	2003-03-25 11:02:27.000000000 +0100
@@ -2012,6 +2012,7 @@ static struct inode *_devfs_get_vfs_inod
     if ( S_ISCHR (de->mode) )
     {
 	inode->i_rdev = to_kdev_t(de->u.cdev.dev);
+	inode->i_cdev = cdget(de->u.cdev.dev);
     }
     else if ( S_ISBLK (de->mode) )
     {
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev1/fs/inode.c linux-2.5.66-cdev2/fs/inode.c
--- linux-2.5.66-cdev1/fs/inode.c	2003-03-25 11:02:13.000000000 +0100
+++ linux-2.5.66-cdev2/fs/inode.c	2003-03-25 11:02:27.000000000 +0100
@@ -128,6 +128,7 @@ static struct inode *alloc_inode(struct 
 		memset(&inode->i_dquot, 0, sizeof(inode->i_dquot));
 		inode->i_pipe = NULL;
 		inode->i_bdev = NULL;
+		inode->i_cdev = NULL;
 		inode->i_rdev = to_kdev_t(0);
 		inode->i_security = NULL;
 		if (security_inode_alloc(inode)) {
@@ -241,6 +242,10 @@ void clear_inode(struct inode *inode)
 		inode->i_sb->s_op->clear_inode(inode);
 	if (inode->i_bdev)
 		bd_forget(inode);
+	else if (inode->i_cdev) {
+		cdput(inode->i_cdev);
+		inode->i_cdev = NULL;
+	}
 	inode->i_state = I_CLEAR;
 }
 
@@ -1310,6 +1315,7 @@ void init_special_inode(struct inode *in
 	if (S_ISCHR(mode)) {
 		inode->i_fop = &def_chr_fops;
 		inode->i_rdev = to_kdev_t(rdev);
+		inode->i_cdev = cdget(rdev);
 	} else if (S_ISBLK(mode)) {
 		inode->i_fop = &def_blk_fops;
 		inode->i_rdev = to_kdev_t(rdev);
@@ -1318,6 +1324,5 @@ void init_special_inode(struct inode *in
 	else if (S_ISSOCK(mode))
 		inode->i_fop = &bad_sock_fops;
 	else
-		printk(KERN_DEBUG "init_special_inode: bogus i_mode (%o)\n",
-		       mode);
+		printk(KERN_DEBUG "init_special_inode: bogus i_mode (%o)\n", mode);
 }
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev1/include/linux/fs.h linux-2.5.66-cdev2/include/linux/fs.h
--- linux-2.5.66-cdev1/include/linux/fs.h	2003-03-25 11:02:13.000000000 +0100
+++ linux-2.5.66-cdev2/include/linux/fs.h	2003-03-25 11:02:27.000000000 +0100
@@ -331,6 +331,12 @@ struct address_space {
 	struct address_space	*assoc_mapping;	/* ditto */
 };
 
+struct char_device {
+	struct list_head	cd_hash;
+	atomic_t		cd_count;
+	dev_t			cd_dev;
+};
+
 struct block_device {
 	struct list_head	bd_hash;
 	atomic_t		bd_count;
@@ -382,6 +388,7 @@ struct inode {
 	struct list_head	i_devices;
 	struct pipe_inode_info	*i_pipe;
 	struct block_device	*i_bdev;
+	struct char_device	*i_cdev;
 
 	unsigned long		i_dnotify_mask; /* Directory notify events */
 	struct dnotify_struct	*i_dnotify; /* for directory notifications */
@@ -1058,6 +1065,8 @@ extern void blk_run_queues(void);
 extern int register_chrdev(unsigned int, const char *, struct file_operations *);
 extern int unregister_chrdev(unsigned int, const char *);
 extern int chrdev_open(struct inode *, struct file *);
+extern struct char_device *cdget(dev_t);
+extern void cdput(struct char_device *);
 
 /* fs/block_dev.c */
 #define BDEVNAME_SIZE	32	/* Largest string for a blockdev identifier */
diff -pur -X /home/devel/roman/nodiff linux-2.5.66-cdev1/kernel/ksyms.c linux-2.5.66-cdev2/kernel/ksyms.c
--- linux-2.5.66-cdev1/kernel/ksyms.c	2003-03-25 10:48:31.000000000 +0100
+++ linux-2.5.66-cdev2/kernel/ksyms.c	2003-03-25 11:02:27.000000000 +0100
@@ -203,6 +203,8 @@ EXPORT_SYMBOL(notify_change);
 EXPORT_SYMBOL(set_blocksize);
 EXPORT_SYMBOL(sb_set_blocksize);
 EXPORT_SYMBOL(sb_min_blocksize);
+EXPORT_SYMBOL(cdget);
+EXPORT_SYMBOL(cdput);
 EXPORT_SYMBOL(bdget);
 EXPORT_SYMBOL(bdput);
 EXPORT_SYMBOL(bd_claim);

