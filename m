Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263772AbTCVR2p>; Sat, 22 Mar 2003 12:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263776AbTCVR2p>; Sat, 22 Mar 2003 12:28:45 -0500
Received: from verein.lst.de ([212.34.181.86]:20998 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S263772AbTCVR2g>;
	Sat, 22 Mar 2003 12:28:36 -0500
Date: Sat, 22 Mar 2003 18:39:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] devfs_mk_symlink simplification
Message-ID: <20030322183938.B21623@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All devfs_mk_symlink arguments except the from and to strings are
unused.  Bring the prototype in shape.


diff -Nru a/arch/um/drivers/line.c b/arch/um/drivers/line.c
--- a/arch/um/drivers/line.c	Sat Mar 22 15:37:12 2003
+++ b/arch/um/drivers/line.c	Sat Mar 22 15:37:12 2003
@@ -438,7 +438,7 @@
 
 	from = line_driver->symlink_from;
 	to = line_driver->symlink_to;
-	err = devfs_mk_symlink(NULL, from, 0, to, NULL, NULL);
+	err = devfs_mk_symlink(from, to);
 	if(err) printk("Symlink creation from /dev/%s to /dev/%s "
 		       "returned %d\n", from, to, err);
 
diff -Nru a/arch/um/drivers/mmapper_kern.c b/arch/um/drivers/mmapper_kern.c
--- a/arch/um/drivers/mmapper_kern.c	Sat Mar 22 15:37:12 2003
+++ b/arch/um/drivers/mmapper_kern.c	Sat Mar 22 15:37:12 2003
@@ -127,8 +127,7 @@
 	devfs_register (NULL, "mmapper", DEVFS_FL_DEFAULT, 
 			30, 0, S_IFCHR | S_IRUGO | S_IWUGO, 
 			&mmapper_fops, NULL); 
-	devfs_mk_symlink(NULL, "mmapper0", DEVFS_FL_DEFAULT, "mmapper",
-			 NULL, NULL);
+	devfs_mk_symlink("mmapper0", "mmapper");
 	return(0);
 }
 
diff -Nru a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
--- a/drivers/md/dm-ioctl.c	Sat Mar 22 15:37:12 2003
+++ b/drivers/md/dm-ioctl.c	Sat Mar 22 15:37:12 2003
@@ -1089,8 +1089,6 @@
 	.owner	 = THIS_MODULE,
 };
 
-static devfs_handle_t _ctl_handle;
-
 static struct miscdevice _dm_misc = {
 	.minor = MISC_DYNAMIC_MINOR,
 	.name  = DM_NAME,
@@ -1115,8 +1113,7 @@
 		return r;
 	}
 
-	r = devfs_mk_symlink(NULL, DM_DIR "/control", DEVFS_FL_DEFAULT,
-			"../misc/" DM_NAME, &_ctl_handle, NULL);
+	r = devfs_mk_symlink(DM_DIR "/control", "../misc/" DM_NAME);
 	if (r) {
 		DMERR("devfs_mk_symlink failed for control device");
 		goto failed;
diff -Nru a/drivers/media/radio/miropcm20-rds.c b/drivers/media/radio/miropcm20-rds.c
--- a/drivers/media/radio/miropcm20-rds.c	Sat Mar 22 15:37:12 2003
+++ b/drivers/media/radio/miropcm20-rds.c	Sat Mar 22 15:37:12 2003
@@ -125,8 +125,8 @@
 	if (error)
 		return error;
 
-	error = devfs_mk_symlink(NULL, "v4l/rds/radiotext", 0,
-				 "../misc/radiotext", NULL, NULL);
+	error = devfs_mk_symlink("v4l/rds/radiotext",
+				 "../misc/radiotext");
 	if (error)
 		misc_deregister(&rds_miscdev);
 
diff -Nru a/fs/devfs/base.c b/fs/devfs/base.c
--- a/fs/devfs/base.c	Sat Mar 22 15:37:12 2003
+++ b/fs/devfs/base.c	Sat Mar 22 15:37:12 2003
@@ -1607,8 +1607,7 @@
 }   /*  End Function devfs_unregister  */
 
 static int devfs_do_symlink (devfs_handle_t dir, const char *name,
-			     unsigned int flags, const char *link,
-			     devfs_handle_t *handle, void *info)
+			     const char *link, devfs_handle_t *handle)
 {
     int err;
     unsigned int linklength;
@@ -1638,7 +1637,7 @@
 	kfree (newlink);
 	return -ENOTDIR;
     }
-    de->info = info;
+    de->info = NULL;
     de->u.symlink.linkname = newlink;
     de->u.symlink.length = linklength;
     if ( ( err = _devfs_append_entry (dir, de, NULL) ) != 0 )
@@ -1660,32 +1659,25 @@
 
 /**
  *	devfs_mk_symlink Create a symbolic link in the devfs namespace.
- *	@dir: The handle to the parent devfs directory entry. If this is %NULL the
- *		new name is relative to the root of the devfs.
- *	@name: The name of the entry.
- *	@flags: A set of bitwise-ORed flags (DEVFS_FL_*).
- *	@link: The destination name.
- *	@handle: The handle to the symlink entry is written here. This may be %NULL.
- *	@info: An arbitrary pointer which will be associated with the entry.
+ *	@from: The name of the entry.
+ *	@to: Name of the destination
  *
  *	Returns 0 on success, else a negative error code is returned.
  */
 
-int devfs_mk_symlink (devfs_handle_t dir, const char *name, unsigned int flags,
-		      const char *link, devfs_handle_t *handle, void *info)
+int devfs_mk_symlink(const char *from, const char *to)
 {
-    int err;
-    devfs_handle_t de;
+	devfs_handle_t de;
+	int err;
 
-    if (handle != NULL) *handle = NULL;
-    DPRINTK (DEBUG_REGISTER, "(%s)\n", name);
-    err = devfs_do_symlink (dir, name, flags, link, &de, info);
-    if (err) return err;
-    if (handle == NULL) de->vfs_deletable = TRUE;
-    else *handle = de;
-    devfsd_notify (de, DEVFSD_NOTIFY_REGISTERED, flags & DEVFS_FL_WAIT);
-    return 0;
-}   /*  End Function devfs_mk_symlink  */
+	err = devfs_do_symlink(NULL, from, to, &de);
+	if (!err) {
+		de->vfs_deletable = TRUE;
+		devfsd_notify(de, DEVFSD_NOTIFY_REGISTERED, 0);
+	}
+
+	return err;
+}
 
 
 /**
@@ -2398,8 +2390,7 @@
     /*  First try to get the devfs entry for this directory  */
     parent = get_devfs_entry_from_vfs_inode (dir);
     if (parent == NULL) return -ENOENT;
-    err = devfs_do_symlink (parent, dentry->d_name.name, DEVFS_FL_NONE,
-			    symname, &de, NULL);
+    err = devfs_do_symlink (parent, dentry->d_name.name, symname, &de);
     DPRINTK (DEBUG_DISABLED, "(%s): errcode from <devfs_do_symlink>: %d\n",
 	     dentry->d_name.name, err);
     if (err < 0) return err;
diff -Nru a/fs/devfs/util.c b/fs/devfs/util.c
--- a/fs/devfs/util.c	Sat Mar 22 15:37:12 2003
+++ b/fs/devfs/util.c	Sat Mar 22 15:37:12 2003
@@ -87,7 +87,6 @@
 int devfs_register_tape (devfs_handle_t de)
 {
     int pos;
-    devfs_handle_t slave;
     char name[32], dest[64];
     static unsigned int tape_counter;
     int n = tape_counter++;
@@ -96,7 +95,7 @@
     if (pos < 0) return -1;
     strncpy (dest + pos, "../", 3);
     sprintf (name, "tapes/tape%u", n);
-    devfs_mk_symlink (NULL, name, DEVFS_FL_DEFAULT, dest + pos, &slave, NULL);
+    devfs_mk_symlink (name, dest + pos);
     return n;
 }   /*  End Function devfs_register_tape  */
 EXPORT_SYMBOL(devfs_register_tape);
diff -Nru a/fs/partitions/check.c b/fs/partitions/check.c
--- a/fs/partitions/check.c	Sat Mar 22 15:37:12 2003
+++ b/fs/partitions/check.c	Sat Mar 22 15:37:12 2003
@@ -185,7 +185,7 @@
 {
 #ifdef CONFIG_DEVFS_FS
 	int pos = 0;
-	devfs_handle_t dir, slave;
+	devfs_handle_t dir;
 	char dirname[64], symlink[16];
 
 	if (dev->flags & GENHD_FL_DEVFS) {
@@ -205,8 +205,7 @@
 	}
 	dev->number = devfs_alloc_unique_number (&disc_numspace);
 	sprintf(symlink, "discs/disc%d", dev->number);
-	devfs_mk_symlink(NULL, symlink, DEVFS_FL_DEFAULT,
-			  dirname + pos, &slave, NULL);
+	devfs_mk_symlink(symlink, dirname + pos);
 	dev->disk_de = devfs_register(dir, "disc", 0,
 			    dev->major, dev->first_minor,
 			    S_IFBLK | S_IRUSR | S_IWUSR, dev->fops, NULL);
@@ -222,7 +221,6 @@
 	sprintf(vname, "cdroms/cdrom%d", dev->number);
 	if (dev->de) {
 		int pos;
-		devfs_handle_t slave;
 		char rname[64];
 
 		dev->disk_de = devfs_register(dev->de, "cd", DEVFS_FL_DEFAULT,
@@ -233,8 +231,7 @@
 		pos = devfs_generate_path(dev->disk_de, rname+3, sizeof(rname)-3);
 		if (pos >= 0) {
 			strncpy(rname + pos, "../", 3);
-			devfs_mk_symlink(NULL, vname, DEVFS_FL_DEFAULT,
-					 rname + pos, &slave, NULL);
+			devfs_mk_symlink(vname, rname + pos);
 		}
 	} else {
 		dev->disk_de = devfs_register (NULL, vname, DEVFS_FL_DEFAULT,
diff -Nru a/include/linux/devfs_fs_kernel.h b/include/linux/devfs_fs_kernel.h
--- a/include/linux/devfs_fs_kernel.h	Sat Mar 22 15:37:12 2003
+++ b/include/linux/devfs_fs_kernel.h	Sat Mar 22 15:37:12 2003
@@ -41,9 +41,7 @@
 				      unsigned int major, unsigned int minor,
 				      umode_t mode, void *ops, void *info);
 extern void devfs_unregister (devfs_handle_t de);
-extern int devfs_mk_symlink (devfs_handle_t dir, const char *name,
-			     unsigned int flags, const char *link,
-			     devfs_handle_t *handle, void *info);
+extern int devfs_mk_symlink (const char *name, const char *link);
 extern devfs_handle_t devfs_mk_dir (devfs_handle_t dir, const char *name,
 				    void *info);
 extern int devfs_generate_path (devfs_handle_t de, char *path, int buflen);
@@ -78,9 +76,7 @@
 {
     return;
 }
-static inline int devfs_mk_symlink (devfs_handle_t dir, const char *name,
-				    unsigned int flags, const char *link,
-				    devfs_handle_t *handle, void *info)
+static inline int devfs_mk_symlink (const char *name, const char *link)
 {
     return 0;
 }
