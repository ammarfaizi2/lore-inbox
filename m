Return-Path: <linux-kernel-owner+willy=40w.ods.org-S768056AbUKBIrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S768056AbUKBIrd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 03:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbUKBIrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 03:47:32 -0500
Received: from sullivan.realtime.net ([205.238.132.76]:32006 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S384469AbUKBIrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 03:47:17 -0500
Date: Tue, 2 Nov 2004 02:46:58 -0600 (CST)
Message-Id: <200411020846.iA28kw3g051219@sullivan.realtime.net>
To: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <greg@kroah.com>,
       Maneesh Soni <maneesh@in.ibm.com>
From: Milton Miller <miltonm@bga.com>
Cc: linux-kernel@vger.kernel.org
Subject: sysfs backing store error path confusion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs_new_dirent returns ERR_PTR(-ENOMEM) if kmalloc fails but the callers
were expecting NULL.  

Compile & link tested.  (Yes, changing the callee would be a smaller change).

===== fs/sysfs/dir.c 1.24 vs edited =====
--- 1.24/fs/sysfs/dir.c	2004-11-01 21:46:46 +01:00
+++ edited/fs/sysfs/dir.c	2004-11-02 09:12:31 +01:00
@@ -55,8 +55,8 @@ int sysfs_make_dirent(struct sysfs_diren
 	struct sysfs_dirent * sd;
 
 	sd = sysfs_new_dirent(parent_sd, element);
-	if (!sd)
-		return -ENOMEM;
+	if (IS_ERR(sd))
+		return PTR_ERR(sd);
 
 	sd->s_mode = mode;
 	sd->s_type = type;
@@ -332,13 +332,18 @@ static int sysfs_dir_open(struct inode *
 {
 	struct dentry * dentry = file->f_dentry;
 	struct sysfs_dirent * parent_sd = dentry->d_fsdata;
+	struct sysfs_dirent * sd;
 
 	down(&dentry->d_inode->i_sem);
-	file->private_data = sysfs_new_dirent(parent_sd, NULL);
+	sd = sysfs_new_dirent(parent_sd, NULL);
 	up(&dentry->d_inode->i_sem);
 
-	return file->private_data ? 0 : -ENOMEM;
+	if (IS_ERR(sd))
+		return PTR_ERR(sd);
+	
+	file->private_data = sd;
 
+	return 0;
 }
 
 static int sysfs_dir_close(struct inode *inode, struct file *file)
