Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261758AbTCLQld>; Wed, 12 Mar 2003 11:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261762AbTCLQld>; Wed, 12 Mar 2003 11:41:33 -0500
Received: from verein.lst.de ([212.34.181.86]:54280 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261758AbTCLQlY>;
	Wed, 12 Mar 2003 11:41:24 -0500
Date: Wed, 12 Mar 2003 17:52:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove DEVFS_FL_REMOVABLE
Message-ID: <20030312175206.D11173@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devfs tries to be super smart and rereads partition tables at all
kinds of wierd points.  This breaks a bunch of stuff were you
can't get the right disk changed information (i.e. CompactFlash).

If people actually needs this kind of stuff they should just call partx
from devfsd instead of relying on the kernel doing something like this.

Cleans up the devfs code significatnly (i.e. removes tons of junk)


--- 1.27/arch/um/drivers/ubd_kern.c	Sat Mar  8 17:50:21 2003
+++ edited/arch/um/drivers/ubd_kern.c	Wed Mar 12 10:35:30 2003
@@ -507,7 +507,7 @@
 	/* /dev/ubd/N style names */
 	sprintf(devfs_name, "%d", unit);
 	*handle_out = devfs_register(dir_handle, devfs_name,
-				     DEVFS_FL_REMOVABLE, major, minor,
+				     0, major, minor,
 				     S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP |
 				     S_IWGRP, &ubd_blops, NULL);
 	disk->private_data = &ubd_dev[unit];
--- 1.73/fs/devfs/base.c	Tue Mar 11 09:42:24 2003
+++ edited/fs/devfs/base.c	Wed Mar 12 11:10:01 2003
@@ -758,7 +758,6 @@
     rwlock_t lock;                   /*  Lock for searching(R)/updating(W)   */
     struct devfs_entry *first;
     struct devfs_entry *last;
-    unsigned short num_removable;    /*  Lock for writing but not reading    */
     unsigned char no_more_additions:1;
 };
 
@@ -766,7 +765,6 @@
 {
     struct block_device_operations *ops;
     dev_t dev;
-    unsigned char removable:1;
 };
 
 struct cdev_type
@@ -1017,7 +1015,6 @@
  *	_devfs_append_entry - Append a devfs entry to a directory's child list.
  *	@dir:  The directory to add to.
  *	@de:  The devfs entry to append.
- *	@removable: If TRUE, increment the count of removable devices for %dir.
  *	@old_de: If an existing entry exists, it will be written here. This may
  *		 be %NULL. An implicit devfs_get() is performed on this entry.
  *
@@ -1028,7 +1025,7 @@
  */
 
 static int _devfs_append_entry (devfs_handle_t dir, devfs_handle_t de,
-				int removable, devfs_handle_t *old_de)
+				devfs_handle_t *old_de)
 {
     int retval;
 
@@ -1056,7 +1053,6 @@
 	    if (dir->u.dir.first == NULL) dir->u.dir.first = de;
 	    else dir->u.dir.last->next = de;
 	    dir->u.dir.last = de;
-	    if (removable) ++dir->u.dir.num_removable;
 	    retval = 0;
 	}
 	else retval = -EEXIST;
@@ -1095,13 +1091,13 @@
 	 == NULL ) return NULL;
     new->u.cdev.dev = devfs_alloc_devnum (S_IFCHR |S_IRUSR |S_IWUSR);
     new->u.cdev.ops = &devfsd_fops;
-    _devfs_append_entry (root_entry, new, FALSE, NULL);
+    _devfs_append_entry (root_entry, new, NULL);
 #ifdef CONFIG_DEVFS_DEBUG
     if ( ( new = _devfs_alloc_entry (".stat", 0, S_IFCHR | S_IRUGO | S_IWUGO) )
 	 == NULL ) return NULL;
     new->u.cdev.dev = devfs_alloc_devnum (S_IFCHR | S_IRUGO | S_IWUGO);
     new->u.cdev.ops = &stat_fops;
-    _devfs_append_entry (root_entry, new, FALSE, NULL);
+    _devfs_append_entry (root_entry, new, NULL);
 #endif
     return root_entry;
 }   /*  End Function _devfs_get_root_entry  */
@@ -1164,7 +1160,7 @@
 	{
 	    de = _devfs_alloc_entry (name, next_pos, MODE_DIR);
 	    devfs_get (de);
-	    if ( !de || _devfs_append_entry (dir, de, FALSE, &old) )
+	    if ( !de || _devfs_append_entry (dir, de, &old) )
 	    {
 		devfs_put (de);
 		if ( !old || !S_ISDIR (old->mode) )
@@ -1498,7 +1494,6 @@
 	de->u.bdev.dev = dev;
 	de->u.cdev.autogen = devnum != 0;
 	de->u.bdev.ops = ops;
-	if (flags & DEVFS_FL_REMOVABLE) de->u.bdev.removable = TRUE;
     } else {
 	PRINTK ("(%s): illegal mode: %x\n", name, mode);
 	devfs_put (de);
@@ -1516,7 +1511,7 @@
 	de->inode.uid = 0;
 	de->inode.gid = 0;
     }
-    err = _devfs_append_entry(dir, de, flags & DEVFS_FL_REMOVABLE, NULL);
+    err = _devfs_append_entry(dir, de, NULL);
     if (err)
     {
 	PRINTK ("(%s): could not append to parent, err: %d\n", name, err);
@@ -1553,8 +1548,6 @@
     else de->next->prev = de->prev;
     de->prev = de;          /*  Indicate we're unhooked                      */
     de->next = NULL;        /*  Force early termination for <devfs_readdir>  */
-    if (S_ISBLK (de->mode) && de->u.bdev.removable )
-	--parent->u.dir.num_removable;
     return TRUE;
 }   /*  End Function _devfs_unhook  */
 
@@ -1648,7 +1641,7 @@
     de->info = info;
     de->u.symlink.linkname = newlink;
     de->u.symlink.length = linklength;
-    if ( ( err = _devfs_append_entry (dir, de, FALSE, NULL) ) != 0 )
+    if ( ( err = _devfs_append_entry (dir, de, NULL) ) != 0 )
     {
 	PRINTK ("(%s): could not append to parent, err: %d\n", name, err);
 	devfs_put (dir);
@@ -1725,7 +1718,7 @@
 	return NULL;
     }
     de->info = info;
-    if ( ( err = _devfs_append_entry (dir, de, FALSE, &old) ) != 0 )
+    if ( ( err = _devfs_append_entry (dir, de, &old) ) != 0 )
     {
 	PRINTK ("(%s): could not append to dir: %p \"%s\", err: %d\n",
 		name, dir, dir->name, err);
@@ -1921,102 +1914,6 @@
 }   /*  End Function try_modload  */
 
 
-/**
- *	check_disc_changed - Check if a removable disc was changed.
- *	@de: The device.
- *
- *	Returns 1 if the media was changed, else 0.
- *
- *	This function may block, and may indirectly cause the parent directory
- *	contents to be changed due to partition re-reading.
- */
-
-static int check_disc_changed (struct devfs_entry *de)
-{
-	int tmp;
-	int retval = 0;
-	dev_t dev = de->u.bdev.dev;
-	extern int warn_no_part;
-
-	if (!S_ISBLK(de->mode))
-		return 0;
-	/* Ugly hack to disable messages about unable to read partition table */
-	tmp = warn_no_part;
-	warn_no_part = 0;
-	retval = __check_disk_change(dev);
-	warn_no_part = tmp;
-	return retval;
-}   /*  End Function check_disc_changed  */
-
-/**
- *	scan_dir_for_removable - Scan a directory for removable media devices and check media.
- *	@dir: The directory.
- *
- *	This function may block, and may indirectly cause the directory
- *	contents to be changed due to partition re-reading. The directory will
- *	be locked for reading.
- */
-
-static void scan_dir_for_removable (struct devfs_entry *dir)
-{
-    struct devfs_entry *de;
-
-    read_lock (&dir->u.dir.lock);
-    if (dir->u.dir.num_removable < 1) de = NULL;
-    else
-    {
-	for (de = dir->u.dir.first; de != NULL; de = de->next)
-	{
-	    if (S_ISBLK (de->mode) && de->u.bdev.removable) break;
-	}
-	devfs_get (de);
-    }
-    read_unlock (&dir->u.dir.lock);
-    if (de) check_disc_changed (de);
-    devfs_put (de);
-}   /*  End Function scan_dir_for_removable  */
-
-/**
- *	get_removable_partition - Get removable media partition.
- *	@dir: The parent directory.
- *	@name: The name of the entry.
- *	@namelen: The number of characters in <<name>>.
- *
- *	Returns 1 if the media was changed, else 0.
- *
- *	This function may block, and may indirectly cause the directory
- *	contents to be changed due to partition re-reading. The directory must
- *	be locked for reading upon entry, and will be unlocked upon exit.
- */
-
-static int get_removable_partition (struct devfs_entry *dir, const char *name,
-				    unsigned int namelen)
-{
-    int retval;
-    struct devfs_entry *de;
-
-    if (dir->u.dir.num_removable < 1)
-    {
-	read_unlock (&dir->u.dir.lock);
-	return 0;
-    }
-    for (de = dir->u.dir.first; de != NULL; de = de->next)
-    {
-	if (!S_ISBLK (de->mode) || !de->u.bdev.removable) continue;
-	if (strcmp (de->name, "disc") == 0) break;
-	/*  Support for names where the partition is appended to the disc name
-	 */
-	if (de->namelen >= namelen) continue;
-	if (strncmp (de->name, name, de->namelen) == 0) break;
-    }
-    devfs_get (de);
-    read_unlock (&dir->u.dir.lock);
-    retval = de ? check_disc_changed (de) : 0;
-    devfs_put (de);
-    return retval;
-}   /*  End Function get_removable_partition  */
-
-
 /*  Superblock operations follow  */
 
 static struct inode_operations devfs_iops;
@@ -2166,7 +2063,6 @@
     switch ( (long) file->f_pos )
     {
       case 0:
-	scan_dir_for_removable (parent);
 	err = (*filldir) (dirent, "..", 2, file->f_pos,
 			  parent_ino (file->f_dentry), DT_DIR);
 	if (err == -EINVAL) break;
@@ -2404,18 +2300,7 @@
     if (parent == NULL) return ERR_PTR (-ENOENT);
     read_lock (&parent->u.dir.lock);
     de = _devfs_search_dir (parent, dentry->d_name.name, dentry->d_name.len);
-    if (de) read_unlock (&parent->u.dir.lock);
-    else
-    {   /*  Try re-reading the partition (media may have changed)  */
-	if ( get_removable_partition (parent, dentry->d_name.name,
-				      dentry->d_name.len) )  /*  Unlocks  */
-	{   /*  Media did change  */
-	    read_lock (&parent->u.dir.lock);
-	    de = _devfs_search_dir (parent, dentry->d_name.name,
-				    dentry->d_name.len);
-	    read_unlock (&parent->u.dir.lock);
-	}
-    }
+    read_unlock (&parent->u.dir.lock);
     lookup_info.de = de;
     init_waitqueue_head (&lookup_info.wait_queue);
     dentry->d_fsdata = &lookup_info;
@@ -2542,7 +2427,7 @@
     de = _devfs_alloc_entry (dentry->d_name.name, dentry->d_name.len, mode);
     if (!de) return -ENOMEM;
     de->vfs_deletable = TRUE;
-    if ( ( err = _devfs_append_entry (parent, de, FALSE, NULL) ) != 0 )
+    if ( ( err = _devfs_append_entry (parent, de, NULL) ) != 0 )
 	return err;
     de->inode.uid = current->euid;
     de->inode.gid = current->egid;
@@ -2610,7 +2495,7 @@
 	de->u.cdev.dev = rdev;
     else if (S_ISBLK (mode))
 	de->u.bdev.dev = rdev;
-    if ( ( err = _devfs_append_entry (parent, de, FALSE, NULL) ) != 0 )
+    if ( ( err = _devfs_append_entry (parent, de, NULL) ) != 0 )
 	return err;
     de->inode.uid = current->euid;
     de->inode.gid = current->egid;
===== fs/partitions/check.c 1.96 vs edited =====
--- 1.96/fs/partitions/check.c	Sat Mar  8 17:50:30 2003
+++ edited/fs/partitions/check.c	Wed Mar 12 10:35:00 2003
@@ -156,7 +156,6 @@
 {
 #ifdef CONFIG_DEVFS_FS
 	devfs_handle_t dir;
-	unsigned int devfs_flags = DEVFS_FL_DEFAULT;
 	struct hd_struct *p = dev->part;
 	char devname[16];
 
@@ -165,10 +164,8 @@
 	dir = dev->de;
 	if (!dir)
 		return;
-	if (dev->flags & GENHD_FL_REMOVABLE)
-		devfs_flags |= DEVFS_FL_REMOVABLE;
 	sprintf(devname, "part%d", part);
-	p[part-1].de = devfs_register (dir, devname, devfs_flags,
+	p[part-1].de = devfs_register (dir, devname, 0,
 				    dev->major, dev->first_minor + part,
 				    S_IFBLK | S_IRUSR | S_IWUSR,
 				    dev->fops, NULL);
@@ -185,11 +182,8 @@
 #ifdef CONFIG_DEVFS_FS
 	int pos = 0;
 	devfs_handle_t dir, slave;
-	unsigned int devfs_flags = DEVFS_FL_DEFAULT;
 	char dirname[64], symlink[16];
 
-	if (dev->flags & GENHD_FL_REMOVABLE)
-		devfs_flags |= DEVFS_FL_REMOVABLE;
 	if (dev->flags & GENHD_FL_DEVFS) {
 		dir = dev->de;
 		if (!dir)  /*  Aware driver wants to block disc management  */
@@ -209,7 +203,7 @@
 	sprintf(symlink, "discs/disc%d", dev->number);
 	devfs_mk_symlink(NULL, symlink, DEVFS_FL_DEFAULT,
 			  dirname + pos, &slave, NULL);
-	dev->disk_de = devfs_register(dir, "disc", devfs_flags,
+	dev->disk_de = devfs_register(dir, "disc", 0,
 			    dev->major, dev->first_minor,
 			    S_IFBLK | S_IRUSR | S_IWUSR, dev->fops, NULL);
 #endif
--- 1.30/include/linux/devfs_fs_kernel.h	Tue Mar 11 08:58:19 2003
+++ edited/include/linux/devfs_fs_kernel.h	Wed Mar 12 10:51:40 2003
@@ -13,7 +13,6 @@
 
 #define DEVFS_FL_NONE           0x000 /* This helps to make code more readable
 				       */
-#define DEVFS_FL_REMOVABLE      0x008 /* This is a removable media device    */
 #define DEVFS_FL_WAIT           0x010 /* Wait for devfsd to finish           */
 #define DEVFS_FL_CURRENT_OWNER  0x020 /* Set initial ownership to current    */
 #define DEVFS_FL_DEFAULT        DEVFS_FL_NONE
