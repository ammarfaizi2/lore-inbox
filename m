Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271928AbRIQRX4>; Mon, 17 Sep 2001 13:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271921AbRIQRXu>; Mon, 17 Sep 2001 13:23:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:44164 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S271928AbRIQRXb>;
	Mon, 17 Sep 2001 13:23:31 -0400
Date: Mon, 17 Sep 2001 13:23:41 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: linux-kernel@vger.kernel.org
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [CFT][PATCH] (2.4.10-pre10) lazy allocation of struct block_device
In-Reply-To: <Pine.GSO.4.21.0109161747500.18507-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0109171321360.21974-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Ported to 2.4.10-pre10, fixed a braino in md.c.  Please, help
with testing.
								Al

diff -urN S10-pre10/drivers/block/rd.c S10-pre10-bdev/drivers/block/rd.c
--- S10-pre10/drivers/block/rd.c	Sun Sep 16 18:11:37 2001
+++ S10-pre10-bdev/drivers/block/rd.c	Mon Sep 17 13:16:33 2001
@@ -374,10 +374,8 @@
 	for (i = 0 ; i < NUM_RAMDISKS; i++) {
 		struct block_device *bdev = rd_bdev[i];
 		rd_bdev[i] = NULL;
-		if (bdev) {
+		if (bdev)
 			blkdev_put(bdev, BDEV_FILE);
-			bdput(bdev);
-		}
 		destroy_buffers(MKDEV(MAJOR_NR, i));
 	}
 
diff -urN S10-pre10/drivers/char/raw.c S10-pre10-bdev/drivers/char/raw.c
--- S10-pre10/drivers/char/raw.c	Tue Jul  3 21:09:09 2001
+++ S10-pre10-bdev/drivers/char/raw.c	Mon Sep 17 13:16:33 2001
@@ -100,6 +100,7 @@
 		goto out;
 
 	rdev = to_kdev_t(bdev->bd_dev);
+	atomic_inc(&bdev->bd_count);
 	err = blkdev_get(bdev, filp->f_mode, 0, BDEV_RAW);
 	if (err)
 		goto out;
diff -urN S10-pre10/drivers/md/md.c S10-pre10-bdev/drivers/md/md.c
--- S10-pre10/drivers/md/md.c	Sun Sep 16 18:11:44 2001
+++ S10-pre10-bdev/drivers/md/md.c	Mon Sep 17 13:19:28 2001
@@ -649,11 +649,11 @@
 
 static void unlock_rdev (mdk_rdev_t *rdev)
 {
-	if (!rdev->bdev)
-		MD_BUG();
-	blkdev_put(rdev->bdev, BDEV_RAW);
-	bdput(rdev->bdev);
+	struct block_device *bdev = rdev->bdev;
 	rdev->bdev = NULL;
+	if (!bdev)
+		MD_BUG();
+	blkdev_put(bdev, BDEV_RAW);
 }
 
 void md_autodetect_dev (kdev_t dev);
diff -urN S10-pre10/fs/block_dev.c S10-pre10-bdev/fs/block_dev.c
--- S10-pre10/fs/block_dev.c	Sun Sep 16 18:11:52 2001
+++ S10-pre10-bdev/fs/block_dev.c	Mon Sep 17 13:16:33 2001
@@ -389,6 +389,7 @@
 	{
 		memset(bdev, 0, sizeof(*bdev));
 		sema_init(&bdev->bd_sem, 1);
+		INIT_LIST_HEAD(&bdev->bd_inodes);
 	}
 }
 
@@ -466,16 +467,57 @@
 
 void bdput(struct block_device *bdev)
 {
-	if (atomic_dec_and_test(&bdev->bd_count)) {
-		spin_lock(&bdev_lock);
+	if (atomic_dec_and_lock(&bdev->bd_count, &bdev_lock)) {
+		struct list_head *p;
 		if (atomic_read(&bdev->bd_openers))
 			BUG();
 		list_del(&bdev->bd_hash);
+		while ( (p = bdev->bd_inodes.next) != &bdev->bd_inodes ) {
+			struct inode *inode;
+			inode = list_entry(p, struct inode, i_devices);
+			list_del(p);
+			inode->i_bdev = NULL;
+		}
 		spin_unlock(&bdev_lock);
 		destroy_bdev(bdev);
 	}
 }
 
+int bd_acquire(struct inode *inode)
+{
+	struct block_device *bdev;
+	spin_lock(&bdev_lock);
+	if (inode->i_bdev) {
+		atomic_inc(&inode->i_bdev->bd_count);
+		spin_unlock(&bdev_lock);
+		return 0;
+	}
+	spin_unlock(&bdev_lock);
+	bdev = bdget(kdev_t_to_nr(inode->i_rdev));
+	if (!bdev)
+		return -ENOMEM;
+	spin_lock(&bdev_lock);
+	if (!inode->i_bdev) {
+		inode->i_bdev = bdev;
+		list_add(&inode->i_devices, &bdev->bd_inodes);
+	} else if (inode->i_bdev != bdev)
+		BUG();
+	spin_unlock(&bdev_lock);
+	return 0;
+}
+
+/* Call when you free inode */
+
+void bd_forget(struct inode *inode)
+{
+	spin_lock(&bdev_lock);
+	if (inode->i_bdev) {
+		list_del(&inode->i_devices);
+		inode->i_bdev = NULL;
+	}
+	spin_unlock(&bdev_lock);
+}
+
 static struct {
 	const char *name;
 	struct block_device_operations *bdops;
@@ -646,13 +688,17 @@
 		}
 	}
 	up(&bdev->bd_sem);
+	if (ret)
+		bdput(bdev);
 	return ret;
 }
 
 int blkdev_open(struct inode * inode, struct file * filp)
 {
 	int ret = -ENXIO;
-	struct block_device *bdev = inode->i_bdev;
+	struct block_device *bdev;
+	bd_acquire(inode);
+	bdev = inode->i_bdev;
 	down(&bdev->bd_sem);
 	lock_kernel();
 	if (!bdev->bd_op)
@@ -668,6 +714,8 @@
 	}	
 	unlock_kernel();
 	up(&bdev->bd_sem);
+	if (ret)
+		bdput(bdev);
 	return ret;
 }	
 
@@ -700,6 +748,7 @@
 					/* kind to stay around. */
 	unlock_kernel();
 	up(&bdev->bd_sem);
+	bdput(bdev);
 	return ret;
 }
 
diff -urN S10-pre10/fs/devfs/base.c S10-pre10-bdev/fs/devfs/base.c
--- S10-pre10/fs/devfs/base.c	Sun Sep 16 18:11:52 2001
+++ S10-pre10-bdev/fs/devfs/base.c	Mon Sep 17 13:16:33 2001
@@ -2247,6 +2247,12 @@
 static struct file_operations devfs_dir_fops;
 static struct inode_operations devfs_symlink_iops;
 
+static void devfs_clear_inode (struct inode *inode)
+{
+	if (S_ISBLK(inode->i_mode))
+		bdput(inode->i_bdev);
+}
+
 static void devfs_read_inode (struct inode *inode)
 {
     struct devfs_entry *de;
@@ -2278,8 +2284,7 @@
     {
 	inode->i_rdev = MKDEV (de->u.fcb.u.device.major,
 			       de->u.fcb.u.device.minor);
-	inode->i_bdev = bdget (kdev_t_to_nr(inode->i_rdev));
-	if (inode->i_bdev)
+	if (bd_acquire(inode) == 0)
 	{
 	    if (!inode->i_bdev->bd_op && de->u.fcb.ops)
 		inode->i_bdev->bd_op = de->u.fcb.ops;
@@ -2384,6 +2389,7 @@
 { 
     read_inode:    devfs_read_inode,
     write_inode:   devfs_write_inode,
+    clear_inode:   devfs_clear_inode,
     statfs:        devfs_statfs,
 };
 
diff -urN S10-pre10/fs/devices.c S10-pre10-bdev/fs/devices.c
--- S10-pre10/fs/devices.c	Thu May 24 18:26:44 2001
+++ S10-pre10-bdev/fs/devices.c	Mon Sep 17 13:16:33 2001
@@ -207,7 +207,6 @@
 	} else if (S_ISBLK(mode)) {
 		inode->i_fop = &def_blk_fops;
 		inode->i_rdev = to_kdev_t(rdev);
-		inode->i_bdev = bdget(rdev);
 	} else if (S_ISFIFO(mode))
 		inode->i_fop = &def_fifo_fops;
 	else if (S_ISSOCK(mode))
diff -urN S10-pre10/fs/inode.c S10-pre10-bdev/fs/inode.c
--- S10-pre10/fs/inode.c	Sun Sep 16 18:11:52 2001
+++ S10-pre10-bdev/fs/inode.c	Mon Sep 17 13:16:33 2001
@@ -516,11 +516,9 @@
 	DQUOT_DROP(inode);
 	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->clear_inode)
 		inode->i_sb->s_op->clear_inode(inode);
-	if (inode->i_bdev) {
-		bdput(inode->i_bdev);
-		inode->i_bdev = NULL;
-	}
-	if (inode->i_cdev) {
+	if (inode->i_bdev)
+		bd_forget(inode);
+	else if (inode->i_cdev) {
 		cdput(inode->i_cdev);
 		inode->i_cdev = NULL;
 	}
@@ -778,6 +776,7 @@
 	inode->i_size = 0;
 	inode->i_generation = 0;
 	memset(&inode->i_dquot, 0, sizeof(inode->i_dquot));
+	INIT_LIST_HEAD(&inode->i_devices);
 	inode->i_pipe = NULL;
 	inode->i_bdev = NULL;
 	inode->i_cdev = NULL;
diff -urN S10-pre10/fs/partitions/ibm.c S10-pre10-bdev/fs/partitions/ibm.c
--- S10-pre10/fs/partitions/ibm.c	Sun Sep 16 18:11:53 2001
+++ S10-pre10-bdev/fs/partitions/ibm.c	Mon Sep 17 13:16:33 2001
@@ -47,9 +47,10 @@
 {
 	struct block_device *bdev = bdget(kdev_t_to_nr(kdev));
 	int rc = blkdev_get(bdev, 0, 1, BDEV_FILE);
-        if ( rc == 0 )
+        if ( rc == 0 ) {
 		rc = ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo);
-	blkdev_put(bdev,BDEV_FILE);
+		blkdev_put(bdev,BDEV_FILE);
+	}
 	return rc;
 }
 
@@ -58,9 +59,10 @@
 {
 	struct block_device *bdev = bdget(kdev_t_to_nr(kdev));
 	int rc = blkdev_get(bdev, 0, 1, BDEV_FILE);
-        if ( rc == 0 )
+        if ( rc == 0 ) {
 		rc = ioctl_by_bdev(bdev, BIODASDINFO, (unsigned long)(info));
-	blkdev_put(bdev,BDEV_FILE);
+		blkdev_put(bdev,BDEV_FILE);
+	}
 	return rc;
 }
 
diff -urN S10-pre10/fs/super.c S10-pre10-bdev/fs/super.c
--- S10-pre10/fs/super.c	Sun Sep 16 18:11:54 2001
+++ S10-pre10-bdev/fs/super.c	Mon Sep 17 13:16:33 2001
@@ -925,6 +925,7 @@
 	error = -EACCES;
 	if (nd.mnt->mnt_flags & MNT_NODEV)
 		goto out;
+	bd_acquire(inode);
 	bdev = inode->i_bdev;
 	bdops = devfs_get_ops ( devfs_get_handle_from_inode (inode) );
 	if (bdops) bdev->bd_op = bdops;
@@ -982,8 +983,6 @@
 	if (!fs_type->read_super(s, data, 0))
 		goto out_fail;
 	unlock_super(s);
-	/* tell bdcache that we are going to keep this one */
-	atomic_inc(&bdev->bd_count);
 	get_filesystem(fs_type);
 	path_release(&nd);
 	return s;
@@ -1128,10 +1127,9 @@
 	sb->s_type = NULL;
 	unlock_super(sb);
 	unlock_kernel();
-	if (bdev) {
+	if (bdev)
 		blkdev_put(bdev, BDEV_FS);
-		bdput(bdev);
-	} else
+	else
 		put_unnamed_dev(dev);
 	spin_lock(&sb_lock);
 	list_del(&sb->s_list);
@@ -1718,6 +1716,7 @@
 	if (!ROOT_DEV)
 		panic("I have no root and I want to scream");
 
+retry:
 	bdev = bdget(kdev_t_to_nr(ROOT_DEV));
 	if (!bdev)
 		panic(__FUNCTION__ ": unable to allocate root device");
@@ -1729,7 +1728,7 @@
 	retval = blkdev_get(bdev, mode, 0, BDEV_FS);
 	if (retval == -EROFS) {
 		root_mountflags |= MS_RDONLY;
-		retval = blkdev_get(bdev, FMODE_READ, 0, BDEV_FS);
+		goto retry;
 	}
 	if (retval) {
 	        /*
@@ -1977,6 +1976,7 @@
 		int blivet;
 		struct block_device *ramdisk = old_rootmnt->mnt_sb->s_bdev;
 
+		atomic_inc(&ramdisk->bd_count);
 		blivet = blkdev_get(ramdisk, FMODE_READ, 0, BDEV_FS);
 		printk(KERN_NOTICE "Trying to unmount old root ... ");
 		if (!blivet) {
diff -urN S10-pre10/include/linux/fs.h S10-pre10-bdev/include/linux/fs.h
--- S10-pre10/include/linux/fs.h	Sun Sep 16 18:11:55 2001
+++ S10-pre10-bdev/include/linux/fs.h	Mon Sep 17 13:16:33 2001
@@ -406,6 +406,7 @@
 	atomic_t		bd_openers;
 	const struct block_device_operations *bd_op;
 	struct semaphore	bd_sem;	/* open/close mutex */
+	struct list_head	bd_inodes;
 };
 
 struct inode {
@@ -440,6 +441,7 @@
 	struct address_space	*i_mapping;
 	struct address_space	i_data;	
 	struct dquot		*i_dquot[MAXQUOTAS];
+	struct list_head	i_devices;
 	/* These three should probably be a union */
 	struct pipe_inode_info	*i_pipe;
 	struct block_device	*i_bdev;
@@ -1031,6 +1033,8 @@
 extern int register_blkdev(unsigned int, const char *, struct block_device_operations *);
 extern int unregister_blkdev(unsigned int, const char *);
 extern struct block_device *bdget(dev_t);
+extern int bd_acquire(struct inode *inode);
+extern void bd_forget(struct inode *inode);
 extern void bdput(struct block_device *);
 extern struct char_device *cdget(dev_t);
 extern void cdput(struct char_device *);
diff -urN S10-pre10/mm/swapfile.c S10-pre10-bdev/mm/swapfile.c
--- S10-pre10/mm/swapfile.c	Sun Sep 16 18:11:56 2001
+++ S10-pre10-bdev/mm/swapfile.c	Mon Sep 17 13:16:33 2001
@@ -764,6 +764,7 @@
 		p->swap_device = dev;
 		set_blocksize(dev, PAGE_SIZE);
 		
+		bd_acquire(swap_inode);
 		bdev = swap_inode->i_bdev;
 		bdops = devfs_get_ops(devfs_get_handle_from_inode(swap_inode));
 		if (bdops) bdev->bd_op = bdops;

