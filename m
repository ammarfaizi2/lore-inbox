Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283234AbRK2OCW>; Thu, 29 Nov 2001 09:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283233AbRK2OCN>; Thu, 29 Nov 2001 09:02:13 -0500
Received: from mario.gams.at ([194.42.96.10]:26418 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S283229AbRK2OCH>;
	Thu, 29 Nov 2001 09:02:07 -0500
Message-Id: <200111291402.PAA31637@merlin.gams.co.at>
Content-Type: text/plain; charset=US-ASCII
From: Axel Kittenberger <Axel.Kittenberger@maxxio.at>
Organization: Maxxio Technologies
To: linux-kernel@vger.kernel.org
Subject: Patch (2.4.16): forwarding release() return values
Date: Thu, 29 Nov 2001 15:02:06 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of ie. char devices relase() call get's swallowed inside the 
kernel. Guess normally it should go upward until it reaches the close() call 
originated in the userspace, however it returns always 0.

Following patch fixes that.

(BTW: I'm not used to how the patching procedure works here, if I'm expected 
to do something else except posting here, please point me to it)

--- linux-2.4.16-org/include/linux/file.h	Wed Aug 23 20:22:26 2000
+++ linux/include/linux/file.h	Thu Nov 29 13:46:42 2001
@@ -5,7 +5,7 @@
 #ifndef __LINUX_FILE_H
 #define __LINUX_FILE_H

-extern void FASTCALL(fput(struct file *));
+extern int FASTCALL(fput(struct file *));
 extern struct file * FASTCALL(fget(unsigned int fd));
  
 static inline int get_close_on_exec(unsigned int fd)
--- linux-2.4.16-org/fs/file_table.c	Mon Sep 17 22:16:30 2001
+++ linux/fs/file_table.c	Thu Nov 29 14:33:35 2001
@@ -97,20 +97,21 @@
 		return 0;
 }

-void fput(struct file * file)
+int fput(struct file * file)
 {
 	struct dentry * dentry = file->f_dentry;
 	struct vfsmount * mnt = file->f_vfsmnt;
 	struct inode * inode = dentry->d_inode;
-
+	int retval = 0;
+        
 	if (atomic_dec_and_test(&file->f_count)) {
 		locks_remove_flock(file);
 
 		if (file->f_iobuf)
 			free_kiovec(1, &file->f_iobuf);
 
-		if (file->f_op && file->f_op->release)
-			file->f_op->release(inode, file);
+		if (file->f_op && file->f_op->release)
+			retval = file->f_op->release(inode, file);
 		fops_put(file->f_op);
 		if (file->f_mode & FMODE_WRITE)
 			put_write_access(inode);
@@ -124,6 +125,7 @@
 		dput(dentry);
 		mntput(mnt);
 	}
+        return retval;
 }

 struct file * fget(unsigned int fd)
--- linux-2.4.16-org/fs/open.c	Fri Oct 12 22:48:42 2001
+++ linux/fs/open.c	Thu Nov 29 13:53:31 2001
@@ -835,7 +835,10 @@
 	}
 	fcntl_dirnotify(0, filp, 0);
 	locks_remove_posix(filp, id);
-	fput(filp);
+	if (retval == 0)
+		retval = fput(filp);
+        else 
+		fput(filp);
 	return retval;
 }

