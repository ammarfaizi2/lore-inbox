Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbULHQrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbULHQrk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 11:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbULHQrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 11:47:40 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:40660 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261264AbULHQrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 11:47:35 -0500
From: Mike Werner <werner@sgi.com>
Reply-To: werner@sgi.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc3] sys_ioctl: Add an unlocked_ioctl file operation
Date: Wed, 8 Dec 2004 08:49:26 -0800
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412080849.26377.werner@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# Add an unlocked_ioctl file operation
# It assumes if unlocked_ioctl is defined in fops
# then the driver can handle concurrency and
# lock_kernel isn't called.
#
# Signed-off-by: Mike Werner  <werner@sgi.com>
# 
diff -Nru a/fs/ioctl.c b/fs/ioctl.c
--- a/fs/ioctl.c	2004-12-07 16:14:55 -08:00
+++ b/fs/ioctl.c	2004-12-07 16:14:55 -08:00
@@ -16,6 +16,8 @@
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
 
+/* Any additions in file_ioctl need to be added to the lock_kernel filter in sys_ioctl */
+ 
 static int file_ioctl(struct file *filp,unsigned int cmd,unsigned long arg)
 {
 	int error;
@@ -46,7 +48,9 @@
 		case FIONREAD:
 			return put_user(i_size_read(inode) - filp->f_pos, p);
 	}
-	if (filp->f_op && filp->f_op->ioctl)
+	if (filp->f_op && filp->f_op->unlocked_ioctl)
+		return filp->f_op->unlocked_ioctl(inode, filp, cmd, arg);
+	else if (filp->f_op && filp->f_op->ioctl)
 		return filp->f_op->ioctl(inode, filp, cmd, arg);
 	return -ENOTTY;
 }
@@ -56,7 +60,7 @@
 {	
 	struct file * filp;
 	unsigned int flag;
-	int on, error = -EBADF;
+	int on, locked, error = -EBADF;
 
 	filp = fget(fd);
 	if (!filp)
@@ -68,7 +72,26 @@
                 goto out;
         }
 
-	lock_kernel();
+	switch (cmd) {
+		case FIOCLEX:
+		case FIONCLEX:
+		case FIONBIO:
+		case FIOASYNC:
+		case FIOQSIZE:
+		case FIBMAP:
+		case FIGETBSZ:
+		case FIONREAD:
+			lock_kernel();
+			locked=1;
+			break;
+		default:
+			locked=0;
+			if (filp->f_op && !filp->f_op->unlocked_ioctl) {
+				lock_kernel();
+				locked=1;
+			}
+	}
+
 	switch (cmd) {
 		case FIOCLEX:
 			set_close_on_exec(fd, 1);
@@ -127,10 +150,13 @@
 			error = -ENOTTY;
 			if (S_ISREG(filp->f_dentry->d_inode->i_mode))
 				error = file_ioctl(filp, cmd, arg);
+			else if (filp->f_op && filp->f_op->unlocked_ioctl)
+				error = filp->f_op->unlocked_ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
 			else if (filp->f_op && filp->f_op->ioctl)
 				error = filp->f_op->ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
 	}
-	unlock_kernel();
+	if (locked)
+		unlock_kernel();
 	fput(filp);
 
 out:
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	2004-12-07 16:14:55 -08:00
+++ b/include/linux/fs.h	2004-12-07 16:14:55 -08:00
@@ -915,6 +915,7 @@
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
+	int (*unlocked_ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
 	int (*open) (struct inode *, struct file *);
 	int (*flush) (struct file *);
