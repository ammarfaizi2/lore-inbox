Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281488AbRLGOLi>; Fri, 7 Dec 2001 09:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281512AbRLGOLS>; Fri, 7 Dec 2001 09:11:18 -0500
Received: from mario.gams.at ([194.42.96.10]:33640 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S281488AbRLGOLH>;
	Fri, 7 Dec 2001 09:11:07 -0500
Message-Id: <200112071411.PAA26298@merlin.gams.co.at>
Content-Type: text/plain; charset=US-ASCII
From: Axel Kittenberger <Axel.Kittenberger@maxxio.at>
Organization: Maxxio Technologies
To: torvalds@transmeta.com
Subject: [Patch 2.5.1-pre6] returning release() values
Date: Fri, 7 Dec 2001 15:11:04 +0100
X-Mailer: KMail [version 1.3.2]
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've recently written a char device driver can really fail when closeing 
(release()  call) . However had to discover that the return value is 
swallowed into the kernel and gets replaced by an all-okay 0 when it reaches 
the userspace.

Having such a driver, one discovers an awful amount of places (mostly in 
userspace) where the close() return value gets illegally discarded :/  Well 
at least this patch should annhilate one of these places inside the linux 
kernel....

- Axel Kittenberger

diff -ru linux-2.5.1-pre6/fs/file_table.c linux/fs/file_table.c
--- linux-2.5.1-pre6/fs/file_table.c	Mon Sep 17 22:16:30 2001
+++ linux/fs/file_table.c	Fri Dec  7 14:28:46 2001
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
+	return retval;
 }

 struct file * fget(unsigned int fd)
diff -ru linux-2.5.1-pre6/fs/open.c linux/fs/open.c
--- linux-2.5.1-pre6/fs/open.c	Fri Oct 12 22:48:42 2001
+++ linux/fs/open.c	Fri Dec  7 14:28:46 2001
@@ -835,7 +835,10 @@
 	}
 	fcntl_dirnotify(0, filp, 0);
 	locks_remove_posix(filp, id);
-	fput(filp);
+	if (retval == 0)
+		retval = fput(filp);
+	else
+		fput(filp);
 	return retval;
 }
 
diff -ru linux-2.5.1-pre6/include/linux/file.h linux/include/linux/file.h
--- linux-2.5.1-pre6/include/linux/file.h	Wed Aug 23 20:22:26 2000
+++ linux/include/linux/file.h	Fri Dec  7 14:28:46 2001
@@ -5,7 +5,7 @@
 #ifndef __LINUX_FILE_H
 #define __LINUX_FILE_H

-extern void FASTCALL(fput(struct file *));
+extern int FASTCALL(fput(struct file *));
 extern struct file * FASTCALL(fget(unsigned int fd));

 static inline int get_close_on_exec(unsigned int fd)
