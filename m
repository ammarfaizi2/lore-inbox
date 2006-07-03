Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWGCBAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWGCBAq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 21:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWGCBAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 21:00:33 -0400
Received: from thunk.org ([69.25.196.29]:4292 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750958AbWGCBAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 21:00:25 -0400
Message-Id: <20060703010023.430751000@candygram.thunk.org>
References: <20060703005333.706556000@candygram.thunk.org>
Date: Sun, 02 Jul 2006 20:53:39 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 6/8] inode-diet: Move i_cindex from struct inode to struct file
Content-Disposition: inline; filename=inode-slim-6
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

inode.i_cindex isn't initialized until the character device is opened
anyway, and there are far more struct inodes in memory than there are
struct file.  So move the cindex field to file.f_cindex, and change
the one(!) user of cindex to use file pointer, which is in fact simpler.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>


Index: linux-2.6.17-mm5/include/linux/fs.h
===================================================================
--- linux-2.6.17-mm5.orig/include/linux/fs.h	2006-07-02 20:29:16.000000000 -0400
+++ linux-2.6.17-mm5/include/linux/fs.h	2006-07-02 20:29:49.000000000 -0400
@@ -528,7 +528,6 @@
 		struct block_device	*i_bdev;
 		struct cdev		*i_cdev;
 	};
-	int			i_cindex;
 
 	__u32			i_generation;
 
@@ -749,6 +748,7 @@
 	spinlock_t		f_ep_lock;
 #endif /* #ifdef CONFIG_EPOLL */
 	struct address_space	*f_mapping;
+	int			f_cindex;
 };
 extern spinlock_t files_lock;
 #define file_list_lock() spin_lock(&files_lock);
Index: linux-2.6.17-mm5/fs/char_dev.c
===================================================================
--- linux-2.6.17-mm5.orig/fs/char_dev.c	2006-07-02 20:25:46.000000000 -0400
+++ linux-2.6.17-mm5/fs/char_dev.c	2006-07-02 20:29:49.000000000 -0400
@@ -288,7 +288,7 @@
 		p = inode->i_cdev;
 		if (!p) {
 			inode->i_cdev = p = new;
-			inode->i_cindex = idx;
+			filp->f_cindex = idx;
 			list_add(&inode->i_devices, &p->list);
 			new = NULL;
 		} else if (!cdev_get(p))
Index: linux-2.6.17-mm5/drivers/ieee1394/ieee1394_core.h
===================================================================
--- linux-2.6.17-mm5.orig/drivers/ieee1394/ieee1394_core.h	2006-07-02 20:25:31.000000000 -0400
+++ linux-2.6.17-mm5/drivers/ieee1394/ieee1394_core.h	2006-07-02 20:29:49.000000000 -0400
@@ -212,7 +212,7 @@
 /* return the index (within a minor number block) of a file */
 static inline unsigned char ieee1394_file_to_instance(struct file *file)
 {
-	return file->f_dentry->d_inode->i_cindex;
+	return file->f_cindex;
 }
 
 extern int hpsb_disable_irm;

--
