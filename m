Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbTJFJAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 05:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbTJFJA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 05:00:29 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:49128 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262804AbTJFJAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 05:00:09 -0400
Date: Mon, 6 Oct 2003 14:30:30 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, Greg KH <gregkh@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: [RFC 2/6] sysfs-mount.patch
Message-ID: <20031006090030.GG4220@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20031006085915.GE4220@in.ibm.com> <20031006090003.GF4220@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006090003.GF4220@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o This patch provides mount related changes for sysfs backing store. Now, 
  sysfs_init() just registers the sysfs filesystem and do not mount it. 

o The global sysfs_mount indicates whether sysfs is mounted or not. For this
  we initialize it in fs/super.c:do_kern_mount(). It looks like more of a hack.

o We also have new dir_operations and dir_inode_operations structs for sysfs 
  directories including the root directory.

o sysfs inode links are obtained from sysfs_get_link_count().


 fs/super.c       |    5 +++++
 fs/sysfs/mount.c |   26 ++++++--------------------
 init/do_mounts.c |    1 +
 3 files changed, 12 insertions(+), 20 deletions(-)

diff -puN init/do_mounts.c~sysfs-mount init/do_mounts.c
--- linux-2.6.0-test6/init/do_mounts.c~sysfs-mount	2003-10-06 11:54:59.000000000 +0530
+++ linux-2.6.0-test6-maneesh/init/do_mounts.c	2003-10-06 11:55:14.000000000 +0530
@@ -189,6 +189,7 @@ done:
 	sys_umount("/sys", 0);
 out:
 	sys_rmdir("/sys");
+	sysfs_mount = NULL;
 	return res;
 fail:
 	res = 0;
diff -puN fs/super.c~sysfs-mount fs/super.c
--- linux-2.6.0-test6/fs/super.c~sysfs-mount	2003-10-06 11:55:03.000000000 +0530
+++ linux-2.6.0-test6-maneesh/fs/super.c	2003-10-06 11:55:14.000000000 +0530
@@ -32,6 +32,7 @@
 #include <linux/security.h>
 #include <linux/vfs.h>
 #include <linux/writeback.h>		/* for the emergency remount stuff */
+#include <linux/sysfs.h>
 #include <asm/uaccess.h>
 
 
@@ -692,6 +693,10 @@ do_kern_mount(const char *fstype, int fl
 	mnt->mnt_mountpoint = sb->s_root;
 	mnt->mnt_parent = mnt;
 	up_write(&sb->s_umount);
+
+	if (!strcmp(fstype, "sysfs"))
+		sysfs_mount = mnt;
+
 	put_filesystem(type);
 	return mnt;
 out_sb:
diff -puN fs/sysfs/mount.c~sysfs-mount fs/sysfs/mount.c
--- linux-2.6.0-test6/fs/sysfs/mount.c~sysfs-mount	2003-10-06 11:55:07.000000000 +0530
+++ linux-2.6.0-test6-maneesh/fs/sysfs/mount.c	2003-10-06 11:55:14.000000000 +0530
@@ -2,8 +2,6 @@
  * mount.c - operations for initializing and mounting sysfs.
  */
 
-#define DEBUG 
-
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
@@ -14,7 +12,7 @@
 /* Random magic number */
 #define SYSFS_MAGIC 0x62656572
 
-struct vfsmount *sysfs_mount;
+struct vfsmount *sysfs_mount = NULL;
 struct super_block * sysfs_sb = NULL;
 
 static struct super_operations sysfs_ops = {
@@ -35,10 +33,9 @@ static int sysfs_fill_super(struct super
 
 	inode = sysfs_new_inode(S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO);
 	if (inode) {
-		inode->i_op = &simple_dir_inode_operations;
-		inode->i_fop = &simple_dir_operations;
-		/* directory inodes start off with i_nlink == 2 (for "." entry) */
-		inode->i_nlink++;	
+		inode->i_op = &sysfs_dir_inode_operations;
+		inode->i_fop = &sysfs_dir_operations;
+		inode->i_nlink += sysfs_get_link_count(NULL);	
 	} else {
 		pr_debug("sysfs: could not get root inode\n");
 		return -ENOMEM;
@@ -63,21 +60,10 @@ static struct super_block *sysfs_get_sb(
 static struct file_system_type sysfs_fs_type = {
 	.name		= "sysfs",
 	.get_sb		= sysfs_get_sb,
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= kill_anon_super,
 };
 
 int __init sysfs_init(void)
 {
-	int err;
-
-	err = register_filesystem(&sysfs_fs_type);
-	if (!err) {
-		sysfs_mount = kern_mount(&sysfs_fs_type);
-		if (IS_ERR(sysfs_mount)) {
-			printk(KERN_ERR "sysfs: could not mount!\n");
-			err = PTR_ERR(sysfs_mount);
-			sysfs_mount = NULL;
-		}
-	}
-	return err;
+	return register_filesystem(&sysfs_fs_type);
 }

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
