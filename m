Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317342AbSGDGYg>; Thu, 4 Jul 2002 02:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317343AbSGDGYf>; Thu, 4 Jul 2002 02:24:35 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:36829 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317342AbSGDGYc>;
	Thu, 4 Jul 2002 02:24:32 -0400
Message-ID: <3D23EA93.7090106@us.ibm.com>
Date: Wed, 03 Jul 2002 23:26:27 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mochel@osdl.org
CC: Greg KH <gregkh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] remove BKL from driverfs
Content-Type: multipart/mixed;
 boundary="------------060006010200090105010605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060006010200090105010605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I saw your talk about driverfs at OLS and it got my attention.  When 
my BKL debugging patch showed some use of the BKL in driverfs, I was 
very dissapointed (you can blame Greg if you want).

text from dmesg after BKL debugging patch:
release of recursive BKL hold, depth: 1
[ 0]main:492
[ 1]inode:149

I see no reason to hold the BKL in your situation.  I replaced it with 
i_sem in some places and just plain removed it in others.  I believe 
that you get all of the protection that you need from dcache_lock in 
the dentry insert and activate.  Can you prove me wrong?

-- 
Dave Hansen
haveblue@us.ibm.com

--------------060006010200090105010605
Content-Type: text/plain;
 name="driverfs-bkl_remove-2.5.24-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="driverfs-bkl_remove-2.5.24-0.patch"

--- linux-2.5.24-clean/fs/driverfs/inode.c	Thu Jun 20 15:53:45 2002
+++ linux/fs/driverfs/inode.c	Wed Jul  3 23:18:23 2002
@@ -146,20 +146,16 @@
 static int driverfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	int res;
-	lock_kernel();
 	dentry->d_op = &driverfs_dentry_dir_ops;
  	res = driverfs_mknod(dir, dentry, mode | S_IFDIR, 0);
-	unlock_kernel();
 	return res;
 }
 
 static int driverfs_create(struct inode *dir, struct dentry *dentry, int mode)
 {
 	int res;
-	lock_kernel();
 	dentry->d_op = &driverfs_dentry_file_ops;
  	res = driverfs_mknod(dir, dentry, mode | S_IFREG, 0);
-	unlock_kernel();
 	return res;
 }
 
@@ -211,9 +207,9 @@
 	if (driverfs_empty(dentry)) {
 		struct inode *inode = dentry->d_inode;
 
-		lock_kernel();
+		down(&inode->i_sem);
 		inode->i_nlink--;
-		unlock_kernel();
+		up(&inode->i_sem);
 		dput(dentry);
 		error = 0;
 	}
@@ -353,8 +349,9 @@
 driverfs_file_lseek(struct file *file, loff_t offset, int orig)
 {
 	loff_t retval = -EINVAL;
+        struct inode *inode = file->f_dentry->d_inode->i_mapping->host;
 
-	lock_kernel();
+	down(&inode->i_sem);	
 	switch(orig) {
 	case 0:
 		if (offset > 0) {
@@ -371,7 +368,7 @@
 	default:
 		break;
 	}
-	unlock_kernel();
+	up(&inode->i_sem);
 	return retval;
 }
 

--------------060006010200090105010605--

