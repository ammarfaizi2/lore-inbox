Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSKRDZJ>; Sun, 17 Nov 2002 22:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbSKRDZJ>; Sun, 17 Nov 2002 22:25:09 -0500
Received: from hera.cwi.nl ([192.16.191.8]:1690 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261290AbSKRDZH>;
	Sun, 17 Nov 2002 22:25:07 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 18 Nov 2002 04:32:07 +0100 (MET)
Message-Id: <UTC200211180332.gAI3W7l02598.aeb@smtp.cwi.nl>
To: dwmw2@infradead.org
Subject: jffs mknod
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A moment ago I moved my old mknod patch to 2.5.recent.
Current source has some strange casting back and forth
between dev_t and int, so having it dev_t everywhere
is certainly an improvement.

While doing so I encountered jffs/inode-v23.c:jffs_mknod().
It does

jffs_mknod(struct inode *dir, struct dentry *dentry, int mode, int rdev) {
	kdev_t dev = to_kdev_t(rdev);
	raw_inode.dsize = sizeof(kdev_t);
	jffs_write_node(c, node, &raw_inode, dentry->d_name.name,
		(unsigned char *)&dev, 0, NULL);
}

a rather strange thing to do. A kdev_t is a kernel-internal thing.
For me it is a pointer, others perhaps think of it as an integer,
but its size and format depend on the kernel version.
Moreover, the result of this will depend on the machine's endianness.
Normally, a filesystem should define its own data format.

What format should be written?

Andries

--- /linux/2.5/linux-2.5.47/linux/fs/jffs/inode-v23.c	Sat Oct 12 19:28:48 2002
+++ /linux/2.5/linux-2.5.47d/linux/fs/jffs/inode-v23.c	Mon Nov 18 04:33:11 2002
@@ -1069,7 +1069,7 @@
 
 
 static int
-jffs_mknod(struct inode *dir, struct dentry *dentry, int mode, int rdev)
+jffs_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t rdev)
 {
 	struct jffs_raw_inode raw_inode;
 	struct jffs_file *dir_f;
@@ -1077,7 +1077,6 @@
 	struct jffs_control *c;
 	struct inode *inode;
 	int result = 0;
-	kdev_t dev = to_kdev_t(rdev);
 	int err;
 
 	D1(printk("***jffs_mknod()\n"));
@@ -1111,7 +1110,7 @@
 	raw_inode.mtime = raw_inode.atime;
 	raw_inode.ctime = raw_inode.atime;
 	raw_inode.offset = 0;
-	raw_inode.dsize = sizeof(kdev_t);
+	raw_inode.dsize = sizeof(dev_t);
 	raw_inode.rsize = 0;
 	raw_inode.nsize = dentry->d_name.len;
 	raw_inode.nlink = 1;
@@ -1121,7 +1120,7 @@
 
 	/* Write the new node to the flash.  */
 	if ((err = jffs_write_node(c, node, &raw_inode, dentry->d_name.name,
-				   (unsigned char *)&dev, 0, NULL)) < 0) {
+				   (unsigned char *)&rdev, 0, NULL)) < 0) {
 		D(printk("jffs_mknod(): jffs_write_node() failed.\n"));
 		result = err;
 		goto jffs_mknod_err;
@@ -1724,9 +1723,9 @@
 		/* If the node is a device of some sort, then the number of
 		   the device should be read from the flash memory and then
 		   added to the inode's i_rdev member.  */
-		kdev_t rdev;
-		jffs_read_data(f, (char *)&rdev, 0, sizeof(kdev_t));
-		init_special_inode(inode, inode->i_mode, kdev_t_to_nr(rdev));
+		dev_t rdev;
+		jffs_read_data(f, (char *)&rdev, 0, sizeof(dev_t));
+		init_special_inode(inode, inode->i_mode, rdev);
 	}
 
 	D3(printk (KERN_NOTICE "read_inode(): up biglock\n"));
