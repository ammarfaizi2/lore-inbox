Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280343AbRKJASd>; Fri, 9 Nov 2001 19:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280351AbRKJASQ>; Fri, 9 Nov 2001 19:18:16 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:53659 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280343AbRKJARz>;
	Fri, 9 Nov 2001 19:17:55 -0500
Date: Fri, 9 Nov 2001 19:17:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [CFT][PATCH] long-living cache for block devices
Message-ID: <Pine.GSO.4.21.0111091903220.12581-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, patch below fixes the problems with flushing block device
cache too early + closes a bunch of races.  Right now it assumes that
->check_media_change() works for all block devices; we can either fix
the drivers to make that assumption 100% correct (i.e. if in doubt -
say that it had been changed) or uncomment truncate_inode_pages() in
blkdev_put() and make it conditional on device (i.e. called only if
->check_media_change() is unreliable).  Frankly, I would prefer the
former.

	Logics looks so: upon the final close() we finish all pending
IO and destroy all buffer_heads for device.  However, we leave pages
alive.  block_device stays alive as long as it has pages in cache.
unregister_blkdev() drops the cache for all devices with that major.
->bd_op handling had been sanitized, so the last remnants of rmmod
races for block devices should be gone now.

	Patch works here.  Please, help with testing.

diff -urN S15-pre2/fs/block_dev.c S15-pre2-new/fs/block_dev.c
--- S15-pre2/fs/block_dev.c	Tue Nov  6 11:36:38 2001
+++ S15-pre2-new/fs/block_dev.c	Fri Nov  9 19:01:50 2001
@@ -221,6 +221,18 @@
 static struct vfsmount *bd_mnt;
 
 /*
+ * drivers.
+ */
+
+static struct {
+	const char *name;
+	struct block_device_operations *bdops;
+	struct list_head bdevs;
+} blkdevs[MAX_BLKDEV];
+
+static LIST_HEAD(killable);
+
+/*
  * bdev cache handling - shamelessly stolen from inode.c
  * We use smaller hashtable, though.
  */
@@ -246,6 +258,8 @@
 		memset(bdev, 0, sizeof(*bdev));
 		sema_init(&bdev->bd_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
+		INIT_LIST_HEAD(&bdev->bd_devs);
+		INIT_LIST_HEAD(&bdev->bd_list);
 	}
 }
 
@@ -274,6 +288,8 @@
 	err = PTR_ERR(bd_mnt);
 	if (IS_ERR(bd_mnt))
 		panic("Cannot create bdev pseudo-fs");
+	for (i = 0; i < MAX_BLKDEV; i++)
+		INIT_LIST_HEAD(&blkdevs[i].bdevs);
 }
 
 /*
@@ -296,6 +312,7 @@
 		if (bdev->bd_dev != dev)
 			continue;
 		atomic_inc(&bdev->bd_count);
+		list_del_init(&bdev->bd_list);
 		return bdev;
 	}
 	return NULL;
@@ -346,19 +363,46 @@
 	inode->i_mapping = &inode->i_data;
 }
 
+static void __bdput(struct block_device *bdev)
+{
+	struct list_head *p;
+	while ( (p = bdev->bd_inodes.next) != &bdev->bd_inodes ) {
+		__bd_forget(list_entry(p, struct inode, i_devices));
+	}
+	list_del_init(&bdev->bd_hash);
+	list_del_init(&bdev->bd_devs);
+	list_del_init(&bdev->bd_list);
+	spin_unlock(&bdev_lock);
+	iput(bdev->bd_inode);
+	destroy_bdev(bdev);
+}
+
+void shrink_bdcache(void)
+{
+	struct block_device *bdev;
+	struct list_head *p;
+retry:
+	spin_lock(&bdev_lock);
+	list_for_each(p, &killable) {
+		bdev = list_entry(p, struct block_device, bd_list);
+		if (bdev->bd_inode->i_mapping->nrpages == 0) {
+			__bdput(bdev);
+			goto retry;
+		}
+	}
+	spin_unlock(&bdev_lock);
+}
+
 void bdput(struct block_device *bdev)
 {
 	if (atomic_dec_and_lock(&bdev->bd_count, &bdev_lock)) {
-		struct list_head *p;
 		if (bdev->bd_openers)
 			BUG();
-		list_del(&bdev->bd_hash);
-		while ( (p = bdev->bd_inodes.next) != &bdev->bd_inodes ) {
-			__bd_forget(list_entry(p, struct inode, i_devices));
-		}
-		spin_unlock(&bdev_lock);
-		iput(bdev->bd_inode);
-		destroy_bdev(bdev);
+		list_add(&bdev->bd_list, &killable);
+		if (bdev->bd_inode->i_mapping->nrpages == 0)
+			__bdput(bdev);
+		else
+			spin_unlock(&bdev_lock);
 	}
 }
  
@@ -368,6 +412,7 @@
 	spin_lock(&bdev_lock);
 	if (inode->i_bdev) {
 		atomic_inc(&inode->i_bdev->bd_count);
+		list_del_init(&inode->i_bdev->bd_list);
 		spin_unlock(&bdev_lock);
 		return 0;
 	}
@@ -396,11 +441,6 @@
 	spin_unlock(&bdev_lock);
 }
 
-static struct {
-	const char *name;
-	struct block_device_operations *bdops;
-} blkdevs[MAX_BLKDEV];
-
 int get_blkdev_list(char * p)
 {
 	int i;
@@ -415,62 +455,118 @@
 	return len;
 }
 
-/*
-	Return the function table of a device.
-	Load the driver if needed.
-*/
-const struct block_device_operations * get_blkfops(unsigned int major)
-{
-	const struct block_device_operations *ret = NULL;
-
-	/* major 0 is used for non-device mounts */
-	if (major && major < MAX_BLKDEV) {
-#ifdef CONFIG_KMOD
-		if (!blkdevs[major].bdops) {
-			char name[20];
-			sprintf(name, "block-major-%d", major);
-			request_module(name);
-		}
-#endif
-		ret = blkdevs[major].bdops;
-	}
-	return ret;
-}
-
 int register_blkdev(unsigned int major, const char * name, struct block_device_operations *bdops)
 {
+	spin_lock(&bdev_lock);
 	if (major == 0) {
 		for (major = MAX_BLKDEV-1; major > 0; major--) {
-			if (blkdevs[major].bdops == NULL) {
+			if (!blkdevs[major].name) {
 				blkdevs[major].name = name;
 				blkdevs[major].bdops = bdops;
+				spin_unlock(&bdev_lock);
 				return major;
 			}
 		}
+		spin_unlock(&bdev_lock);
 		return -EBUSY;
 	}
-	if (major >= MAX_BLKDEV)
+	if (major >= MAX_BLKDEV) {
+		spin_unlock(&bdev_lock);
 		return -EINVAL;
-	if (blkdevs[major].bdops && blkdevs[major].bdops != bdops)
+	}
+	if (blkdevs[major].name) {
+		spin_unlock(&bdev_lock);
 		return -EBUSY;
+	}
 	blkdevs[major].name = name;
 	blkdevs[major].bdops = bdops;
+	spin_unlock(&bdev_lock);
 	return 0;
 }
 
 int unregister_blkdev(unsigned int major, const char * name)
 {
+	struct list_head *p;
+	struct block_device *bdev;
 	if (major >= MAX_BLKDEV)
 		return -EINVAL;
-	if (!blkdevs[major].bdops)
-		return -EINVAL;
-	if (strcmp(blkdevs[major].name, name))
+	spin_lock(&bdev_lock);
+	if (!blkdevs[major].bdops || strcmp(blkdevs[major].name, name)) {
+		spin_unlock(&bdev_lock);
 		return -EINVAL;
-	blkdevs[major].name = NULL;
+	}
 	blkdevs[major].bdops = NULL;
+	while ( (p = blkdevs[major].bdevs.next) != &blkdevs[major].bdevs ) {
+		bdev = list_entry(p, struct block_device, bd_devs);
+		atomic_inc(&bdev->bd_count);
+		list_del_init(&bdev->bd_list);
+		list_del_init(p);
+		bdev->bd_op = NULL;
+		spin_unlock(&bdev_lock);
+		truncate_inode_pages(bdev->bd_inode->i_mapping, 0);
+		bdput(bdev);
+		spin_lock(&bdev_lock);
+	}
+	blkdevs[major].name = NULL;
+	spin_unlock(&bdev_lock);
 	return 0;
 }
 
+static struct block_device_operations *get_bdops(int major)
+{
+	struct block_device_operations *ops = NULL;
+	spin_lock(&bdev_lock);
+	if (major < MAX_BLKDEV) {
+		ops = blkdevs[major].bdops;
+		if (ops && ops->owner && !try_inc_mod_count(ops->owner))
+			ops = NULL;
+	}
+	spin_unlock(&bdev_lock);
+	return ops;
+}
+
+static void put_bdops(struct block_device_operations *ops)
+{
+	if (ops->owner)
+		__MOD_DEC_USE_COUNT(ops->owner);
+}
+
+int bd_activate(struct block_device *bdev)
+{
+	struct block_device_operations *ops;
+	int major = MAJOR(to_kdev_t(bdev->bd_dev));
+	spin_lock(&bdev_lock);
+	ops = bdev->bd_op;
+	if (ops) {
+		if (!ops->owner || try_inc_mod_count(ops->owner)) {
+			spin_unlock(&bdev_lock);
+			return 1;
+		}
+		bdev->bd_op = NULL;
+		list_del_init(&bdev->bd_devs);
+	}
+	spin_unlock(&bdev_lock);
+	ops = get_bdops(major);
+#ifdef CONFIG_KMOD
+	if (!ops && major < MAX_BLKDEV) {
+		char name[20];
+		sprintf(name, "block-major-%d", major);
+		request_module(name);
+		ops = get_bdops(major);
+	}
+#endif
+	if (!ops)
+		return 0;
+	spin_lock(&bdev_lock);
+	if (!bdev->bd_op) {
+		bdev->bd_op = ops;
+		list_add(&bdev->bd_devs, &blkdevs[major].bdevs);
+	} else if (bdev->bd_op != ops)
+		BUG();
+	spin_unlock(&bdev_lock);
+	return 1;
+}
+
 /*
  * This routine checks whether a removable media has been changed,
  * and invalidates all buffer-cache-entries in that case. This
@@ -482,25 +578,15 @@
  */
 int check_disk_change(kdev_t dev)
 {
-	int i;
-	const struct block_device_operations * bdops = NULL;
+	struct block_device_operations * bdops = get_bdops(MAJOR(dev));
 
-	i = MAJOR(dev);
-	if (i < MAX_BLKDEV)
-		bdops = blkdevs[i].bdops;
-	if (bdops == NULL) {
-		devfs_handle_t de;
-
-		de = devfs_find_handle (NULL, NULL, i, MINOR (dev),
-					DEVFS_SPECIAL_BLK, 0);
-		if (de) bdops = devfs_get_ops (de);
-	}
 	if (bdops == NULL)
 		return 0;
-	if (bdops->check_media_change == NULL)
-		return 0;
-	if (!bdops->check_media_change(dev))
+
+	if (!bdops->check_media_change || !bdops->check_media_change(dev)) {
+		put_bdops(bdops);
 		return 0;
+	}
 
 	printk(KERN_DEBUG "VFS: Disk change detected on device %s\n",
 		bdevname(dev));
@@ -510,6 +596,7 @@
 
 	if (bdops->revalidate)
 		bdops->revalidate(dev);
+	put_bdops(bdops);
 	return 1;
 }
 
@@ -528,31 +615,25 @@
 
 static int do_open(struct block_device *bdev, struct inode *inode, struct file *file)
 {
-	int ret = -ENXIO;
+	int ret;
 	kdev_t dev = to_kdev_t(bdev->bd_dev);
 
+	if (!bd_activate(bdev))
+		return -ENXIO;
+
 	down(&bdev->bd_sem);
-	lock_kernel();
-	if (!bdev->bd_op)
-		bdev->bd_op = get_blkfops(MAJOR(dev));
-	if (bdev->bd_op) {
-		ret = 0;
-		if (bdev->bd_op->owner)
-			__MOD_INC_USE_COUNT(bdev->bd_op->owner);
-		if (bdev->bd_op->open)
-			ret = bdev->bd_op->open(inode, file);
-		if (!ret) {
-			bdev->bd_openers++;
-			bdev->bd_inode->i_size = blkdev_size(dev);
-			bdev->bd_inode->i_blkbits = blksize_bits(block_size(dev));
-		} else {
-			if (bdev->bd_op->owner)
-				__MOD_DEC_USE_COUNT(bdev->bd_op->owner);
-			if (!bdev->bd_openers)
-				bdev->bd_op = NULL;
-		}
+	ret = 0;
+	if (bdev->bd_op->open) {
+		lock_kernel();
+		ret = bdev->bd_op->open(inode, file);
+		unlock_kernel();
 	}
-	unlock_kernel();
+	if (!ret) {
+		bdev->bd_openers++;
+		bdev->bd_inode->i_size = blkdev_size(dev);
+		bdev->bd_inode->i_blkbits = blksize_bits(block_size(dev));
+	} else
+		put_bdops(bdev->bd_op);
 	up(&bdev->bd_sem);
 	if (ret)
 		bdput(bdev);
@@ -579,8 +660,6 @@
 
 int blkdev_open(struct inode * inode, struct file * filp)
 {
-	struct block_device *bdev;
-
 	/*
 	 * Preserve backwards compatibility and allow large file access
 	 * even if userspace doesn't ask for it explicitly. Some mkfs
@@ -590,9 +669,7 @@
 	filp->f_flags |= O_LARGEFILE;
 
 	bd_acquire(inode);
-	bdev = inode->i_bdev;
-
-	return do_open(bdev, inode, filp);
+	return do_open(inode->i_bdev, inode, filp);
 }	
 
 int blkdev_put(struct block_device *bdev, int kind)
@@ -607,14 +684,14 @@
 		__block_fsync(bd_inode);
 	else if (kind == BDEV_FS)
 		fsync_no_super(rdev);
-	if (!--bdev->bd_openers)
-		kill_bdev(bdev);
+	if (!--bdev->bd_openers) {
+		detach_metadata(bdev->bd_inode->i_mapping);
+		/* XXX: The next is needed if ->check... is broken */
+		/* truncate_inode_pages(bdev->bd_inode->i_mapping, 0); */
+	}
 	if (bdev->bd_op->release)
 		ret = bdev->bd_op->release(bd_inode, NULL);
-	if (bdev->bd_op->owner)
-		__MOD_DEC_USE_COUNT(bdev->bd_op->owner);
-	if (!bdev->bd_openers)
-		bdev->bd_op = NULL;
+	put_bdops(bdev->bd_op);
 	unlock_kernel();
 	up(&bdev->bd_sem);
 	bdput(bdev);
diff -urN S15-pre2/fs/devfs/base.c S15-pre2-new/fs/devfs/base.c
--- S15-pre2/fs/devfs/base.c	Tue Nov  6 11:36:39 2001
+++ S15-pre2-new/fs/devfs/base.c	Fri Nov  9 19:01:48 2001
@@ -1296,17 +1296,11 @@
 	printk ("%s: devfs_register(): NULL name pointer\n", DEVFS_NAME);
 	return NULL;
     }
-    if (ops == NULL)
+    if (ops == NULL && !S_ISBLK (mode) )
     {
-	if ( S_ISBLK (mode) ) ops = (void *) get_blkfops (major);
-	if (ops == NULL)
-	{
-	    printk ("%s: devfs_register(%s): NULL ops pointer\n",
-		    DEVFS_NAME, name);
-	    return NULL;
-	}
-	printk ("%s: devfs_register(%s): NULL ops, got %p from major table\n",
-		DEVFS_NAME, name, ops);
+	printk ("%s: devfs_register(%s): NULL ops pointer\n",
+		DEVFS_NAME, name);
+	return NULL;
     }
     if ( S_ISDIR (mode) )
     {
@@ -2000,7 +1994,6 @@
 int devfs_register_blkdev (unsigned int major, const char *name,
 			   struct block_device_operations *bdops)
 {
-    if (boot_options & OPTION_ONLY) return 0;
     return register_blkdev (major, name, bdops);
 }   /*  End Function devfs_register_blkdev  */
 
@@ -2034,7 +2027,6 @@
 
 int devfs_unregister_blkdev (unsigned int major, const char *name)
 {
-    if (boot_options & OPTION_ONLY) return 0;
     return unregister_blkdev (major, name);
 }   /*  End Function devfs_unregister_blkdev  */
 
@@ -2173,24 +2165,17 @@
 static int check_disc_changed (struct devfs_entry *de)
 {
     int tmp;
+    int res;
     kdev_t dev = MKDEV (de->u.fcb.u.device.major, de->u.fcb.u.device.minor);
-    struct block_device_operations *bdops = de->u.fcb.ops;
     extern int warn_no_part;
 
     if ( !S_ISBLK (de->mode) ) return 0;
-    if (bdops == NULL) return 0;
-    if (bdops->check_media_change == NULL) return 0;
-    if ( !bdops->check_media_change (dev) ) return 0;
-    printk ( KERN_DEBUG "VFS: Disk change detected on device %s\n",
-	     kdevname (dev) );
-    if (invalidate_device(dev, 0))
-	printk("VFS: busy inodes on changed media..\n");
     /*  Ugly hack to disable messages about unable to read partition table  */
     tmp = warn_no_part;
     warn_no_part = 0;
-    if (bdops->revalidate) bdops->revalidate (dev);
+    res = check_disk_change(dev);
     warn_no_part = tmp;
-    return 1;
+    return res;
 }   /*  End Function check_disc_changed  */
 
 
@@ -2366,12 +2351,8 @@
     {
 	inode->i_rdev = MKDEV (de->u.fcb.u.device.major,
 			       de->u.fcb.u.device.minor);
-	if (bd_acquire(inode) == 0)
-	{
-	    if (!inode->i_bdev->bd_op && de->u.fcb.ops)
-		inode->i_bdev->bd_op = de->u.fcb.ops;
-	}
-	else printk ("%s: get_vfs_inode(%d): no block device from bdget()\n",
+	if (bd_acquire(inode) != 0)
+		printk ("%s: get_vfs_inode(%d): no block device from bdget()\n",
 		     DEVFS_NAME, (int) inode->i_ino);
     }
     else if ( S_ISFIFO (de->inode.mode) ) inode->i_fop = &def_fifo_fops;
@@ -2478,10 +2459,7 @@
     df = &de->u.fcb;
     file->private_data = de->info;
     if ( S_ISBLK (inode->i_mode) )
-    {
 	file->f_op = &def_blk_fops;
-	if (df->ops) inode->i_bdev->bd_op = df->ops;
-    }
     else file->f_op = fops_get ( (struct file_operations*) df->ops );
     if (file->f_op)
 	err = file->f_op->open ? (*file->f_op->open) (inode, file) : 0;
diff -urN S15-pre2/fs/super.c S15-pre2-new/fs/super.c
--- S15-pre2/fs/super.c	Tue Nov  6 11:36:39 2001
+++ S15-pre2-new/fs/super.c	Fri Nov  9 19:01:48 2001
@@ -535,7 +535,6 @@
 {
 	struct inode *inode;
 	struct block_device *bdev;
-	struct block_device_operations *bdops;
 	struct super_block * s;
 	struct nameidata nd;
 	struct list_head *p;
@@ -559,9 +558,6 @@
 		goto out;
 	bd_acquire(inode);
 	bdev = inode->i_bdev;
-	bdops = devfs_get_ops ( devfs_get_handle_from_inode (inode) );
-	if (bdops) bdev->bd_op = bdops;
-	/* Done with lookups, semaphore down */
 	dev = to_kdev_t(bdev->bd_dev);
 	if (!(flags & MS_RDONLY))
 		mode |= FMODE_WRITE;
@@ -994,7 +990,6 @@
 	bdev = bdget(kdev_t_to_nr(ROOT_DEV));
 	if (!bdev)
 		panic(__FUNCTION__ ": unable to allocate root device");
-	bdev->bd_op = devfs_get_ops (handle);
 	path_start = devfs_generate_path (handle, path + 5, sizeof (path) - 5);
 	mode = FMODE_READ;
 	if (!(root_mountflags & MS_RDONLY))
diff -urN S15-pre2/include/linux/fs.h S15-pre2-new/include/linux/fs.h
--- S15-pre2/include/linux/fs.h	Fri Nov  9 18:58:20 2001
+++ S15-pre2-new/include/linux/fs.h	Fri Nov  9 19:01:49 2001
@@ -422,6 +422,8 @@
 	const struct block_device_operations *bd_op;
 	struct semaphore	bd_sem;	/* open/close mutex */
 	struct list_head	bd_inodes;
+	struct list_head	bd_devs;
+	struct list_head	bd_list;
 };
 
 struct inode {
@@ -1075,7 +1077,7 @@
 extern int blkdev_put(struct block_device *, int);
 
 /* fs/devices.c */
-extern const struct block_device_operations *get_blkfops(unsigned int);
+extern int bd_activate(struct block_device *);
 extern int register_chrdev(unsigned int, const char *, struct file_operations *);
 extern int unregister_chrdev(unsigned int, const char *);
 extern int chrdev_open(struct inode *, struct file *);
diff -urN S15-pre2/mm/filemap.c S15-pre2-new/mm/filemap.c
--- S15-pre2/mm/filemap.c	Fri Nov  9 18:58:21 2001
+++ S15-pre2-new/mm/filemap.c	Fri Nov  9 19:01:49 2001
@@ -244,6 +244,61 @@
 	page_cache_release(page);
 }
 
+static int detach_list_pages(struct list_head *head)
+{
+	struct list_head *curr;
+	struct page * page;
+	int unlocked = 0;
+
+ restart:
+	curr = head->prev;
+	while (curr != head) {
+		unsigned long offset;
+
+		page = list_entry(curr, struct page, list);
+		offset = page->index;
+
+		/* Is one of the pages to truncate? */
+		if (page->buffers) {
+			page_cache_get(page);
+			if (TryLockPage(page)) {
+				/* Restart on this page */
+				list_del(head);
+				list_add(head, curr);
+				spin_unlock(&pagecache_lock);
+				wait_on_page(page);
+			} else {
+				/* Restart after this page */
+				list_del(head);
+				list_add_tail(head, curr);
+				spin_unlock(&pagecache_lock);
+				try_to_free_buffers(page, 0);
+				UnlockPage(page);
+			}
+			page_cache_release(page);
+			spin_lock(&pagecache_lock);
+			unlocked = 1;
+			goto restart;
+		}
+		curr = curr->prev;
+	}
+	return unlocked;
+}
+
+void detach_metadata(struct address_space *mapping)
+{
+	int unlocked;
+
+	spin_lock(&pagecache_lock);
+	do {
+		unlocked = detach_list_pages(&mapping->clean_pages);
+		unlocked |= detach_list_pages(&mapping->dirty_pages);
+		unlocked |= detach_list_pages(&mapping->locked_pages);
+	} while (unlocked);
+	/* Traversed all three lists without dropping the lock */
+	spin_unlock(&pagecache_lock);
+}
+
 static int FASTCALL(truncate_list_pages(struct list_head *, unsigned long, unsigned *));
 static int truncate_list_pages(struct list_head *head, unsigned long start, unsigned *partial)
 {
diff -urN S15-pre2/mm/swapfile.c S15-pre2-new/mm/swapfile.c
--- S15-pre2/mm/swapfile.c	Tue Nov  6 11:36:41 2001
+++ S15-pre2-new/mm/swapfile.c	Fri Nov  9 19:01:48 2001
@@ -916,16 +916,12 @@
 
 	if (S_ISBLK(swap_inode->i_mode)) {
 		kdev_t dev = swap_inode->i_rdev;
-		struct block_device_operations *bdops;
 
 		p->swap_device = dev;
 		set_blocksize(dev, PAGE_SIZE);
 		
 		bd_acquire(swap_inode);
 		bdev = swap_inode->i_bdev;
-		bdops = devfs_get_ops(devfs_get_handle_from_inode(swap_inode));
-		if (bdops) bdev->bd_op = bdops;
-
 		error = blkdev_get(bdev, FMODE_READ|FMODE_WRITE, 0, BDEV_SWAP);
 		if (error)
 			goto bad_swap_2;
diff -urN S15-pre2/mm/vmscan.c S15-pre2-new/mm/vmscan.c
--- S15-pre2/mm/vmscan.c	Fri Nov  9 18:58:21 2001
+++ S15-pre2-new/mm/vmscan.c	Fri Nov  9 19:01:49 2001
@@ -576,6 +576,7 @@
 
 	shrink_dcache_memory(priority, gfp_mask);
 	shrink_icache_memory(priority, gfp_mask);
+	shrink_bdcache();
 #ifdef CONFIG_QUOTA
 	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
 #endif

