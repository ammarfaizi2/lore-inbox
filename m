Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266627AbTAOP3M>; Wed, 15 Jan 2003 10:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266637AbTAOP3L>; Wed, 15 Jan 2003 10:29:11 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:39067 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id <S266627AbTAOP3E>;
	Wed, 15 Jan 2003 10:29:04 -0500
Message-Id: <200301151544.KAA17539@moss-shockers.ncsc.mil>
Date: Wed, 15 Jan 2003 10:44:52 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: [RFC] Changes to the LSM file-related hooks for 2.5.58
To: ak@muc.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-security-module@wirex.com, viro@math.psu.edu, sds@epoch.ncsc.mil
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: /Mjw1bBEGtPmtGuIQo/F6g==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Andi Kleen" <ak@muc.de> writes:
> Adding release_private_file requires fixing all code that uses 
> init_private_file (including possible third party code). Otherwise
> you have some subtle leak. It would better to rename init_private_file to
> some other name and add appropiate comments so that this can be catched 
> easily at compile time.

Thanks for the suggestion.  I've split out this logical change into a
separate patch and reworked it in accordance with your suggestion.  See
below.  Let me know if this does not address your concern.

 fs/exportfs/expfs.c |    5 ++---
 fs/file_table.c     |   33 ++++++++++++++++++++++++++-------
 fs/nfsd/vfs.c       |    5 ++---
 include/linux/fs.h  |    5 ++++-
 kernel/ksyms.c      |    3 ++-
 5 files changed, 36 insertions(+), 15 deletions(-)
-----

===== fs/file_table.c 1.16 vs edited =====
--- 1.16/fs/file_table.c	Tue Nov 26 14:29:39 2002
+++ edited/fs/file_table.c	Wed Jan 15 09:39:17 2003
@@ -93,11 +93,13 @@
 
 /*
  * Clear and initialize a (private) struct file for the given dentry,
- * and call the open function (if any).  The caller must verify that
- * inode->i_fop is not NULL.
+ * allocate the security structure, and call the open function (if any).  The 
+ * caller must verify that inode->i_fop is not NULL.  The file should
+ * be released using close_private_file.
  */
-int init_private_file(struct file *filp, struct dentry *dentry, int mode)
+int open_private_file(struct file *filp, struct dentry *dentry, int mode)
 {
+	int error;
 	memset(filp, 0, sizeof(*filp));
 	eventpoll_init_file(filp);
 	filp->f_mode   = mode;
@@ -106,10 +108,27 @@
 	filp->f_uid    = current->fsuid;
 	filp->f_gid    = current->fsgid;
 	filp->f_op     = dentry->d_inode->i_fop;
-	if (filp->f_op->open)
-		return filp->f_op->open(dentry->d_inode, filp);
-	else
-		return 0;
+	error = security_file_alloc(filp);
+	if (!error)
+		if (filp->f_op->open) {
+			error = filp->f_op->open(dentry->d_inode, filp);
+			if (error)
+				security_file_free(filp);
+		}
+	return error;
+}
+
+/*
+ * Release a private file by calling the release function (if any) and
+ * freeing the security structure.
+ */
+void close_private_file(struct file *file)
+{
+	struct inode * inode = file->f_dentry->d_inode;
+
+	if (file->f_op && file->f_op->release)
+		file->f_op->release(inode, file);
+	security_file_free(file);
 }
 
 void fput(struct file * file)
===== fs/exportfs/expfs.c 1.9 vs edited =====
--- 1.9/fs/exportfs/expfs.c	Thu Oct 10 19:07:34 2002
+++ edited/fs/exportfs/expfs.c	Wed Jan 15 09:38:53 2003
@@ -353,7 +353,7 @@
 	/*
 	 * Open the directory ...
 	 */
-	error = init_private_file(&file, dentry, FMODE_READ);
+	error = open_private_file(&file, dentry, FMODE_READ);
 	if (error)
 		goto out;
 	error = -EINVAL;
@@ -381,8 +381,7 @@
 	}
 
 out_close:
-	if (file.f_op->release)
-		file.f_op->release(dir, &file);
+	close_private_file(&file);
 out:
 	return error;
 }
===== fs/nfsd/vfs.c 1.55 vs edited =====
--- 1.55/fs/nfsd/vfs.c	Fri Jan 10 20:00:12 2003
+++ edited/fs/nfsd/vfs.c	Wed Jan 15 09:39:35 2003
@@ -468,7 +468,7 @@
 		DQUOT_INIT(inode);
 	}
 
-	err = init_private_file(filp, dentry, mode);
+	err = open_private_file(filp, dentry, mode);
 	if (!err) {
 		filp->f_flags = flags;
 		filp->f_vfsmnt = fhp->fh_export->ex_mnt;
@@ -491,8 +491,7 @@
 	struct dentry	*dentry = filp->f_dentry;
 	struct inode	*inode = dentry->d_inode;
 
-	if (filp->f_op->release)
-		filp->f_op->release(inode, filp);
+	close_private_file(filp);
 	if (filp->f_mode & FMODE_WRITE)
 		put_write_access(inode);
 }
===== include/linux/fs.h 1.210 vs edited =====
--- 1.210/include/linux/fs.h	Wed Jan  8 15:37:23 2003
+++ edited/include/linux/fs.h	Wed Jan 15 09:41:28 2003
@@ -492,7 +492,10 @@
 #define get_file(x)	atomic_inc(&(x)->f_count)
 #define file_count(x)	atomic_read(&(x)->f_count)
 
-extern int init_private_file(struct file *, struct dentry *, int);
+/* Initialize and open a private file and allocate its security structure. */
+extern int open_private_file(struct file *, struct dentry *, int);
+/* Release a private file and free its security structure. */
+extern void close_private_file(struct file *file);
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
 
===== kernel/ksyms.c 1.178 vs edited =====
--- 1.178/kernel/ksyms.c	Mon Jan 13 04:24:04 2003
+++ edited/kernel/ksyms.c	Wed Jan 15 09:41:47 2003
@@ -179,7 +179,8 @@
 EXPORT_SYMBOL(end_buffer_io_sync);
 EXPORT_SYMBOL(__mark_inode_dirty);
 EXPORT_SYMBOL(get_empty_filp);
-EXPORT_SYMBOL(init_private_file);
+EXPORT_SYMBOL(open_private_file);
+EXPORT_SYMBOL(close_private_file);
 EXPORT_SYMBOL(filp_open);
 EXPORT_SYMBOL(filp_close);
 EXPORT_SYMBOL(put_filp);





--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

