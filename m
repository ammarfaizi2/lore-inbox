Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274651AbRITUyR>; Thu, 20 Sep 2001 16:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274648AbRITUyJ>; Thu, 20 Sep 2001 16:54:09 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:55037 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274650AbRITUxz>;
	Thu, 20 Sep 2001 16:53:55 -0400
Date: Thu, 20 Sep 2001 16:54:18 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/block_dev.c cleanup
In-Reply-To: <Pine.GSO.4.21.0109201201590.3498-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0109201645540.5631-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Sep 2001, Alexander Viro wrote:

> On Thu, 20 Sep 2001, Chris Mason wrote:
> 
> > > <nod>  And if you add Andrea's (perfectly valid) observation re having no
> > > need to sync any fs structures we might have for that device, you get
> > > __block_fsync().  After that it's easy to merge blkdev_close() code into
> > > blkdev_put().
> > > 
> > >
> > 
> > Ok, __block_fsync is much better than just fsync_dev.
> > 
> > Are there other parts of blkdev_close you want merged into 
> > blkdev_put? Without changing the reread blocks on last close 
> > semantics, I think this is all we can do.
> > 
> > As far as I can tell, bdev->bd_inode is valid to send 
> > to __block_fsync, am I missing something?
> 
> Eventually that will be the right thing, but only after we allocate
> bd_inode upon blkdev_get()/blkdev_open() instead of trying to cannibalize
> the inode passed to blkdev_open().
> 
> I'm testing that chunk right now (it also kills all the fake_inode crap in
> block_dev.c).

OK, it seems to be working here.  It doesn't fix anything in rd.c - all
it does is crapectomy in block_dev.c.   Pseudo-fs added, inodes are
allocated there upon blkdev_open() and blkdev_get(), ->bd_inode is
always from that pseudo-fs and never equal to inode passed into blkdev_open().

Crap with fake inodes is gone - we simply use ->bd_inode.  ->a_ops for
block device inodes is not set at all - neither in devices.c nor in devfs.
We set it for inodes on pseudo-fs and setting ->i_mapping upon open()
does the right thing.

All mess with keeping the first inode alive is gone - no need to do that
anymore.

diff -urN S10-pre12/drivers/block/rd.c linux/drivers/block/rd.c
--- S10-pre12/drivers/block/rd.c	Thu Sep 20 15:27:18 2001
+++ linux/drivers/block/rd.c	Thu Sep 20 15:26:09 2001
@@ -420,7 +420,6 @@
 			/* bdev->bd_sem is held by caller */
 			bdev->bd_openers++;
 			bdev->bd_cache_openers++;
-			bdev->bd_inode = inode;
 		}
 	}
 
diff -urN S10-pre12/fs/block_dev.c linux/fs/block_dev.c
--- S10-pre12/fs/block_dev.c	Thu Sep 20 15:27:24 2001
+++ linux/fs/block_dev.c	Thu Sep 20 15:40:04 2001
@@ -18,6 +18,7 @@
 #include <linux/iobuf.h>
 #include <linux/highmem.h>
 #include <linux/blkdev.h>
+#include <linux/module.h>
 
 #include <asm/uaccess.h>
 
@@ -365,6 +366,53 @@
 }
 
 /*
+ * pseudo-fs
+ */
+
+static struct super_block *bd_read_super(struct super_block *sb, void *data, int silent)
+{
+	static struct super_operations sops = {};
+	struct inode *root = new_inode(sb);
+	if (!root)
+		return NULL;
+	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
+	root->i_uid = root->i_gid = 0;
+	root->i_atime = root->i_mtime = root->i_ctime = CURRENT_TIME;
+	sb->s_blocksize = 1024;
+	sb->s_blocksize_bits = 10;
+	sb->s_magic = 0x62646576;
+	sb->s_op = &sops;
+	sb->s_root = d_alloc(NULL, &(const struct qstr) { "bdev:", 5, 0 });
+	if (!sb->s_root) {
+		iput(root);
+		return NULL;
+	}
+	sb->s_root->d_sb = sb;
+	sb->s_root->d_parent = sb->s_root;
+	d_instantiate(sb->s_root, root);
+	return sb;
+}
+
+static DECLARE_FSTYPE(bd_type, "bdev", bd_read_super, FS_NOMOUNT);
+
+static struct vfsmount *bd_mnt;
+
+static int get_inode(struct block_device *bdev)
+{
+	if (!bdev->bd_inode) {
+		struct inode *inode = new_inode(bd_mnt->mnt_sb);
+		if (!inode)
+			return -ENOMEM;
+		inode->i_rdev = to_kdev_t(bdev->bd_dev);
+		atomic_inc(&bdev->bd_count);	/* will go away */
+		inode->i_bdev = bdev;
+		inode->i_data.a_ops = &def_blk_aops;
+		bdev->bd_inode = inode;
+	}
+	return 0;
+}
+
+/*
  * bdev cache handling - shamelessly stolen from inode.c
  * We use smaller hashtable, though.
  */
@@ -394,7 +442,7 @@
 
 void __init bdev_cache_init(void)
 {
-	int i;
+	int i, err;
 	struct list_head *head = bdev_hashtable;
 
 	i = HASH_SIZE;
@@ -410,6 +458,13 @@
 					 NULL);
 	if (!bdev_cachep)
 		panic("Cannot create bdev_cache SLAB cache");
+	err = register_filesystem(&bd_type);
+	if (err)
+		panic("Cannot register bdev pseudo-fs");
+	bd_mnt = kern_mount(&bd_type);
+	err = PTR_ERR(bd_mnt);
+	if (IS_ERR(bd_mnt))
+		panic("Cannot create bdev pseudo-fs");
 }
 
 /*
@@ -598,18 +653,13 @@
 
 int ioctl_by_bdev(struct block_device *bdev, unsigned cmd, unsigned long arg)
 {
-	struct inode inode_fake;
 	int res;
 	mm_segment_t old_fs = get_fs();
 
 	if (!bdev->bd_op->ioctl)
 		return -EINVAL;
-	memset(&inode_fake, 0, sizeof(inode_fake));
-	inode_fake.i_rdev = to_kdev_t(bdev->bd_dev);
-	inode_fake.i_bdev = bdev;
-	init_waitqueue_head(&inode_fake.i_wait);
 	set_fs(KERNEL_DS);
-	res = bdev->bd_op->ioctl(&inode_fake, NULL, cmd, arg);
+	res = bdev->bd_op->ioctl(bdev->bd_inode, NULL, cmd, arg);
 	set_fs(old_fs);
 	return res;
 }
@@ -619,6 +669,12 @@
 	int ret = -ENODEV;
 	kdev_t rdev = to_kdev_t(bdev->bd_dev); /* this should become bdev */
 	down(&bdev->bd_sem);
+
+	if (get_inode(bdev)) {
+		up(&bdev->bd_sem);
+		return -ENOMEM;
+	}
+
 	lock_kernel();
 	if (!bdev->bd_op)
 		bdev->bd_op = get_blkfops(MAJOR(rdev));
@@ -631,23 +687,22 @@
 		 */
 		struct file fake_file = {};
 		struct dentry fake_dentry = {};
-		struct inode *fake_inode = get_empty_inode();
 		ret = -ENOMEM;
-		if (fake_inode) {
-			fake_file.f_mode = mode;
-			fake_file.f_flags = flags;
-			fake_file.f_dentry = &fake_dentry;
-			fake_dentry.d_inode = fake_inode;
-			fake_inode->i_rdev = rdev;
-			ret = 0;
-			if (bdev->bd_op->open)
-				ret = bdev->bd_op->open(fake_inode, &fake_file);
-			if (!ret) {
-				bdev->bd_openers++;
-				atomic_inc(&bdev->bd_count);
-			} else if (!bdev->bd_openers)
-				bdev->bd_op = NULL;
-			iput(fake_inode);
+		fake_file.f_mode = mode;
+		fake_file.f_flags = flags;
+		fake_file.f_dentry = &fake_dentry;
+		fake_dentry.d_inode = bdev->bd_inode;
+		ret = 0;
+		if (bdev->bd_op->open)
+			ret = bdev->bd_op->open(bdev->bd_inode, &fake_file);
+		if (!ret) {
+			bdev->bd_openers++;
+			atomic_inc(&bdev->bd_count);
+		} else if (!bdev->bd_openers) {
+			struct inode *bd_inode = bdev->bd_inode;
+			bdev->bd_op = NULL;
+			bdev->bd_inode = NULL;
+			iput(bd_inode);
 		}
 	}
 	unlock_kernel();
@@ -669,6 +724,12 @@
 	filp->f_flags |= O_LARGEFILE;
 
 	down(&bdev->bd_sem);
+
+	if (get_inode(bdev)) {
+		up(&bdev->bd_sem);
+		return -ENOMEM;
+	}
+
 	lock_kernel();
 	if (!bdev->bd_op)
 		bdev->bd_op = get_blkfops(MAJOR(inode->i_rdev));
@@ -678,20 +739,15 @@
 			ret = bdev->bd_op->open(inode,filp);
 		if (!ret) {
 			bdev->bd_openers++;
-			if (!bdev->bd_cache_openers && bdev->bd_inode)
-				BUG();
-			if (bdev->bd_cache_openers && !bdev->bd_inode)
-				BUG();
-			if (!bdev->bd_cache_openers++)
-				bdev->bd_inode = inode;
-			else {
-				if (bdev->bd_inode != inode && !inode->i_mapping_overload++) {
-					inode->i_mapping = bdev->bd_inode->i_mapping;
-					atomic_inc(&bdev->bd_inode->i_count);
-				}
-			}
-		} else if (!bdev->bd_openers)
+			bdev->bd_cache_openers++;
+			inode->i_mapping = bdev->bd_inode->i_mapping;
+			inode->i_mapping_overload++;
+		} else if (!bdev->bd_openers) {
+			struct inode *bd_inode = bdev->bd_inode;
 			bdev->bd_op = NULL;
+			bdev->bd_inode = NULL;
+			iput(bd_inode);
+		}
 	}	
 	unlock_kernel();
 	up(&bdev->bd_sem);
@@ -702,28 +758,24 @@
 {
 	int ret = 0;
 	kdev_t rdev = to_kdev_t(bdev->bd_dev); /* this should become bdev */
+	struct inode *bd_inode = bdev->bd_inode;
+
 	down(&bdev->bd_sem);
 	lock_kernel();
 	if (kind == BDEV_FILE)
-		fsync_dev(rdev);
+		__block_fsync(bd_inode);
 	else if (kind == BDEV_FS)
 		fsync_no_super(rdev);
 	/* only filesystems uses buffer cache for the metadata these days */
 	if (kind == BDEV_FS)
 		invalidate_buffers(rdev);
-	if (bdev->bd_op->release) {
-		struct inode * fake_inode = get_empty_inode();
-		ret = -ENOMEM;
-		if (fake_inode) {
-			fake_inode->i_rdev = rdev;
-			ret = bdev->bd_op->release(fake_inode, NULL);
-			iput(fake_inode);
-		} else
-			printk(KERN_WARNING "blkdev_put: ->release couldn't be run due -ENOMEM\n");
-	}
-	if (!--bdev->bd_openers)
-		bdev->bd_op = NULL;	/* we can't rely on driver being */
-					/* kind to stay around. */
+	if (bdev->bd_op->release)
+		ret = bdev->bd_op->release(bd_inode, NULL);
+	if (!--bdev->bd_openers) {
+		bdev->bd_op = NULL;
+		bdev->bd_inode = NULL;
+		iput(bd_inode);
+	}
 	unlock_kernel();
 	up(&bdev->bd_sem);
 	bdput(bdev);
@@ -736,8 +788,6 @@
 	int ret = 0;
 	struct inode * bd_inode = bdev->bd_inode;
 
-	if (bd_inode->i_mapping != inode->i_mapping)
-		BUG();
 	down(&bdev->bd_sem);
 	lock_kernel();
 	/* cache coherency protocol */
@@ -745,11 +795,9 @@
 		struct super_block * sb;
 
 		/* flush the pagecache to disk */
-		__block_fsync(inode);
+		__block_fsync(bd_inode);
 		/* drop the pagecache, uptodate info is on disk by now */
 		truncate_inode_pages(inode->i_mapping, 0);
-		/* forget the bdev pagecache address space */
-		bdev->bd_inode = NULL;
 
 		/* if the fs was mounted ro just throw away most of its caches */
 		sb = get_super(inode->i_rdev);
@@ -782,16 +830,17 @@
 			drop_super(sb);
 		}
 	}
-	if (inode != bd_inode && !--inode->i_mapping_overload) {
+	if (!--inode->i_mapping_overload)
 		inode->i_mapping = &inode->i_data;
-		iput(bd_inode);
-	}
 
 	/* release the device driver */
 	if (bdev->bd_op->release)
 		ret = bdev->bd_op->release(inode, NULL);
-	if (!--bdev->bd_openers)
+	if (!--bdev->bd_openers) {
 		bdev->bd_op = NULL;
+		bdev->bd_inode = NULL;
+		iput(bd_inode);
+	}
 	unlock_kernel();
 	up(&bdev->bd_sem);
 
diff -urN S10-pre12/fs/devices.c linux/fs/devices.c
--- S10-pre12/fs/devices.c	Thu Sep 20 15:27:24 2001
+++ linux/fs/devices.c	Thu Sep 20 15:26:09 2001
@@ -206,7 +206,6 @@
 		inode->i_cdev = cdget(rdev);
 	} else if (S_ISBLK(mode)) {
 		inode->i_fop = &def_blk_fops;
-		inode->i_mapping->a_ops = &def_blk_aops;
 		inode->i_rdev = to_kdev_t(rdev);
 		inode->i_bdev = bdget(rdev);
 	} else if (S_ISFIFO(mode))

