Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261903AbULCDAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbULCDAo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 22:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbULCDAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 22:00:44 -0500
Received: from [61.48.52.229] ([61.48.52.229]:495 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261903AbULCDAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 22:00:19 -0500
Date: Thu, 2 Dec 2004 18:50:35 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412030250.iB32oZQ02969@adam.yggdrasil.com>
To: maneesh@in.ibm.com
Subject: [PATCH 2.6.10-rc2-bk15] sysfs_dir_close memory leak
Cc: akpm@osdl.org, chrisw@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	sysfs_dir_close did not free the "cursor" sysfs_dirent
used for keeping track of position in the list of sysfs_dirent nodes.
Consequently, doing a "find /sys" would leak a sysfs_dirent for
each of the 1140 directories in my /sys tree, or about 36kB
each time.

	This patch was generated against a sysfs tree with a
bunch of other changes, but should apply to the stock Linux tree
with the appropriate line number adjustments.

	If this patch looks OK, I would appreciate it if someone
would forward it downstream for integration.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l


diff -u9 linux.prev/fs/sysfs/dir.c linux.noleak/fs/sysfs/dir.c
--- linux.prev/fs/sysfs/dir.c	2004-12-02 14:51:01.000000000 +0800
+++ linux.noleak/fs/sysfs/dir.c	2004-12-03 10:42:06.000000000 +0800
@@ -346,18 +346,21 @@
 static int sysfs_dir_close(struct inode *inode, struct file *file)
 {
 	struct dentry * dentry = file->f_dentry;
 	struct sysfs_dirent * cursor = file->private_data;
 
 	down(&dentry->d_inode->i_sem);
 	list_del_init(&cursor->s_sibling);
 	up(&dentry->d_inode->i_sem);
 
+	BUG_ON(cursor->s_dentry != NULL);
+	release_sysfs_dirent(cursor);
+
 	return 0;
 }
 
 /* Relationship between s_mode and the DT_xxx types */
 static inline unsigned char dt_type(struct sysfs_dirent *sd)
 {
 	return (sd->s_mode >> 12) & 15;
 }
 
