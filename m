Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSIEMyz>; Thu, 5 Sep 2002 08:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317473AbSIEMyz>; Thu, 5 Sep 2002 08:54:55 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:28824 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317468AbSIEMyy>; Thu, 5 Sep 2002 08:54:54 -0400
Message-ID: <3D7805A4.1BF0E967@softhome.net>
Date: Thu, 05 Sep 2002 18:32:20 -0700
From: Inguva <inguva@softhome.net>
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH]:2.4.19: do_revalidate in chown
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
Requesting for comments on the below findings and the patch.

sys_stat() does a do_revalidate() after user_path_walk() but sys_chown()
does not. This causes sys_chown() to use incorrect attribute information
on distributed file systems.  The sys_stat does do_revalidate() to
revalidate the inodes for proper NFS attibute caching.
But when sys_chown calls chown_common after the user_path_walk, no
checks are being done regarding the dentry values, which contain cached
inode values. On Distributed File system environments there may be a
likelyhood that these values may not be current and there is a
likelihood of stale values being read.
Hence doing a do_revalidate before the chown calls will help address
this issue.
Below is a patch which does that.

Regards,
Inguva


diff -urN ./fs/open.c ./fs-fixed/open.c
--- ./fs/open.c Thu Sep  5 02:34:38 2002
+++ ./fs-fixed/open.c Thu Sep  5 14:44:24 2002
@@ -20,6 +20,8 @@

 #define special_file(m)
(S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))

+extern int do_revalidate(struct dentry *);
+
 int vfs_statfs(struct super_block *sb, struct statfs *buf)
 {
  int retval = -ENODEV;
@@ -608,7 +610,9 @@

  error = user_path_walk(filename, &nd);
  if (!error) {
-  error = chown_common(nd.dentry, user, group);
+  error = do_revalidate(nd.dentry);
+  if (!error)
+   error = chown_common(nd.dentry, user, group);
   path_release(&nd);
  }
  return error;
@@ -621,7 +625,9 @@

  error = user_path_walk_link(filename, &nd);
  if (!error) {
-  error = chown_common(nd.dentry, user, group);
+  error = do_revalidate(nd.dentry);
+  if (!error)
+   error = chown_common(nd.dentry, user, group);
   path_release(&nd);
  }
  return error;
@@ -632,12 +638,15 @@
 {
  struct file * file;
  int error = -EBADF;
-
- file = fget(fd);
- if (file) {
-  error = chown_common(file->f_dentry, user, group);
-  fput(file);
- }
+
+ if(!do_revalidate(file->f_dentry))
+  {
+  file = fget(fd);
+  if (file) {
+   error = chown_common(file->f_dentry, user, group);
+   fput(file);
+   }
+  }
  return error;
 }

diff -urN ./fs/stat.c ./fs-fixed/stat.c
--- ./fs/stat.c Thu Sep  5 09:59:52 2002
+++ ./fs-fixed/stat.c Thu Sep  5 14:44:24 2002
@@ -13,11 +13,12 @@

 #include <asm/uaccess.h>

+extern int do_revalidate(struct dentry *);
+
 /*
  * Revalidate the inode. This is required for proper NFS attribute
caching.
  */
-static __inline__ int
-do_revalidate(struct dentry *dentry)
+int do_revalidate(struct dentry *dentry)
 {
  struct inode * inode = dentry->d_inode;
  if (inode->i_op && inode->i_op->revalidate)


