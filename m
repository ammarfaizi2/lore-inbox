Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293521AbSCUHsO>; Thu, 21 Mar 2002 02:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293541AbSCUHsF>; Thu, 21 Mar 2002 02:48:05 -0500
Received: from mario.gams.at ([194.42.96.10]:17448 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S293521AbSCUHry>;
	Thu, 21 Mar 2002 02:47:54 -0500
Message-Id: <200203210747.IAA25949@merlin.gams.co.at>
Content-Type: text/plain; charset=US-ASCII
From: Axel Kittenberger <Axel.Kittenberger@maxxio.at>
Organization: Maxxio Technologies
To: linux-kernel@vger.kernel.org
Subject: Patch, forward release() return values to the close() call
Date: Thu, 21 Mar 2002 08:47:36 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here goes my liitle patchy, once again :o)

Whats it's about?

When close()ing an charcter device one expects the return value of the 
charcter drivers release() call to be forwarded to the close() called in 
userspace. However thats not the case, the kernel swallows the release() 
value, and always returns 0 to the userspace's close(). (tha char drivers 
release() function is called in fput() as it would have a void return value)

It may sound weired at first but there are actually device drivers than can 
fail on close(), in my case it's a driver to program a LCA, the userspace 
application signals end of data by closing the device, the driver finalizes 
the download, and the LCA reports if it has accepted it's new program, if not 
close() should return a non-zero value, indicating the operation did not 
complete successfully.

----

diff -r -u linux-2.4.18-orig/fs/file_table.c linux-2.4.18/fs/file_table.c
--- linux-2.4.18-orig/fs/file_table.c   Mon Sep 17 22:16:30 2001
+++ linux-2.4.18/fs/file_table.c        Wed Mar 20 16:35:34 2002
@@ -97,11 +97,12 @@
                return 0;
 }

-void fput(struct file * file)
+int fput(struct file * file)
 {
        struct dentry * dentry = file->f_dentry;
        struct vfsmount * mnt = file->f_vfsmnt;
        struct inode * inode = dentry->d_inode;
+       int retval = 0;

        if (atomic_dec_and_test(&file->f_count)) {
                locks_remove_flock(file);
@@ -110,7 +111,7 @@
                        free_kiovec(1, &file->f_iobuf);

                if (file->f_op && file->f_op->release)
-                       file->f_op->release(inode, file);
+                       retval = file->f_op->release(inode, file);
                fops_put(file->f_op);
                if (file->f_mode & FMODE_WRITE)
                        put_write_access(inode);
@@ -124,6 +125,7 @@
                dput(dentry);
                mntput(mnt);
        }
+       return retval;
 }

 struct file * fget(unsigned int fd)
diff -r -u linux-2.4.18-orig/fs/open.c linux-2.4.18/fs/open.c
--- linux-2.4.18-orig/fs/open.c Fri Oct 12 22:48:42 2001
+++ linux-2.4.18/fs/open.c      Wed Mar 20 16:34:12 2002
@@ -835,7 +835,10 @@
        }
        fcntl_dirnotify(0, filp, 0);
        locks_remove_posix(filp, id);
-       fput(filp);
+       if (retval == 0)
+               retval = fput(filp);
+       else
+               fput(filp);
        return retval;
 }

diff -r -u linux-2.4.18-orig/include/linux/file.h 
linux-2.4.18/include/linux/file.h
--- linux-2.4.18-orig/include/linux/file.h      Wed Aug 23 20:22:26 2000
+++ linux-2.4.18/include/linux/file.h   Wed Mar 20 16:32:36 2002
@@ -5,7 +5,7 @@
 #ifndef __LINUX_FILE_H
 #define __LINUX_FILE_H

-extern void FASTCALL(fput(struct file *));
+extern int FASTCALL(fput(struct file *));
 extern struct file * FASTCALL(fget(unsigned int fd));

 static inline int get_close_on_exec(unsigned int fd)
