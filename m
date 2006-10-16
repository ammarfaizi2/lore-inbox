Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422762AbWJPQ2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422762AbWJPQ2r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422758AbWJPQ2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:28:46 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:37833 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1422741AbWJPQ2m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:28:42 -0400
Message-Id: <20061016162804.404125000@szeredi.hu>
References: <20061016162709.369579000@szeredi.hu>
User-Agent: quilt/0.45-1
Date: Mon, 16 Oct 2006 18:27:18 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [patch 09/12] fuse: add support for block device based filesystems
Content-Disposition: inline; filename=fuse_blockdev.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I never intended this, but people started using fuse to implement
block device based "real" filesystems (ntfs-3g, zfs).

The following four patches add better support for these kinds of
filesystems.  Unlike "normal" fuse filesystems, using this feature
should require superuser privileges (enforced by the fusermount
utility).

Thanks to Szabolcs Szakacsits for the input and testing.

This patch adds a 'fuseblk' filesystem type, which is only different
from the 'fuse' filesystem type in how the 'dev_name' mount argument
is interpreted.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

---
Index: linux/Documentation/filesystems/fuse.txt
===================================================================
--- linux.orig/Documentation/filesystems/fuse.txt	2006-10-16 16:17:30.000000000 +0200
+++ linux/Documentation/filesystems/fuse.txt	2006-10-16 16:21:33.000000000 +0200
@@ -51,6 +51,22 @@ homepage:
 
   http://fuse.sourceforge.net/
 
+Filesystem type
+~~~~~~~~~~~~~~~
+
+The filesystem type given to mount(2) can be one of the following:
+
+'fuse'
+
+  This is the usual way to mount a FUSE filesystem.  The first
+  argument of the mount system call may contain an arbitrary string,
+  which is not interpreted by the kernel.
+
+'fuseblk'
+
+  The filesystem is block device based.  The first argument of the
+  mount system call is interpreted as the name of the device.
+
 Mount options
 ~~~~~~~~~~~~~
 
Index: linux/fs/fuse/inode.c
===================================================================
--- linux.orig/fs/fuse/inode.c	2006-10-16 16:17:36.000000000 +0200
+++ linux/fs/fuse/inode.c	2006-10-16 16:21:33.000000000 +0200
@@ -591,6 +591,14 @@ static int fuse_get_sb(struct file_syste
 	return get_sb_nodev(fs_type, flags, raw_data, fuse_fill_super, mnt);
 }
 
+static int fuse_get_sb_blk(struct file_system_type *fs_type,
+			   int flags, const char *dev_name,
+			   void *raw_data, struct vfsmount *mnt)
+{
+	return get_sb_bdev(fs_type, flags, dev_name, raw_data, fuse_fill_super,
+			   mnt);
+}
+
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuse",
@@ -598,6 +606,14 @@ static struct file_system_type fuse_fs_t
 	.kill_sb	= kill_anon_super,
 };
 
+static struct file_system_type fuseblk_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "fuseblk",
+	.get_sb		= fuse_get_sb_blk,
+	.kill_sb	= kill_block_super,
+	.fs_flags	= FS_REQUIRES_DEV,
+};
+
 static decl_subsys(fuse, NULL, NULL);
 static decl_subsys(connections, NULL, NULL);
 
@@ -617,24 +633,34 @@ static int __init fuse_fs_init(void)
 
 	err = register_filesystem(&fuse_fs_type);
 	if (err)
-		printk("fuse: failed to register filesystem\n");
-	else {
-		fuse_inode_cachep = kmem_cache_create("fuse_inode",
-						      sizeof(struct fuse_inode),
-						      0, SLAB_HWCACHE_ALIGN,
-						      fuse_inode_init_once, NULL);
-		if (!fuse_inode_cachep) {
-			unregister_filesystem(&fuse_fs_type);
-			err = -ENOMEM;
-		}
-	}
+		goto out;
 
+	err = register_filesystem(&fuseblk_fs_type);
+	if (err)
+		goto out_unreg;
+
+	fuse_inode_cachep = kmem_cache_create("fuse_inode",
+					      sizeof(struct fuse_inode),
+					      0, SLAB_HWCACHE_ALIGN,
+					      fuse_inode_init_once, NULL);
+	err = -ENOMEM;
+	if (!fuse_inode_cachep)
+		goto out_unreg2;
+
+	return 0;
+
+ out_unreg2:
+	unregister_filesystem(&fuseblk_fs_type);
+ out_unreg:
+	unregister_filesystem(&fuse_fs_type);
+ out:
 	return err;
 }
 
 static void fuse_fs_cleanup(void)
 {
 	unregister_filesystem(&fuse_fs_type);
+	unregister_filesystem(&fuseblk_fs_type);
 	kmem_cache_destroy(fuse_inode_cachep);
 }
 

--
