Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264041AbTEWMoI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 08:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264053AbTEWMoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 08:44:07 -0400
Received: from pat.uio.no ([129.240.130.16]:18117 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264041AbTEWMnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 08:43:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16078.6093.339198.108592@charged.uio.no>
Date: Fri, 23 May 2003 14:45:01 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH 1/4] Optimize NFS open() calls by means of 'intents'...
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Minor cleanup of open() code. Put the original open flags, mode, etc. into
an 'opendata' structure that can be passed as an intent to lookup.



diff -u --recursive --new-file linux-2.5.69/fs/namei.c linux-2.5.69-01-open1/fs/namei.c
--- linux-2.5.69/fs/namei.c	2003-05-05 07:49:54.000000000 +0200
+++ linux-2.5.69-01-open1/fs/namei.c	2003-05-22 15:30:50.000000000 +0200
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/namei.h>
+#include <linux/open.h>
 #include <linux/quotaops.h>
 #include <linux/pagemap.h>
 #include <linux/dnotify.h>
@@ -1204,19 +1205,18 @@
  * for symlinks (where the permissions are checked later).
  * SMP-safe
  */
-int open_namei(const char * pathname, int flag, int mode, struct nameidata *nd)
+int open_namei(const char * pathname, struct opendata *opendata, struct nameidata *nd)
 {
-	int acc_mode, error = 0;
+	int flag = opendata->flag;
+	int error = 0;
 	struct dentry *dentry;
 	struct dentry *dir;
 	int count = 0;
 
-	acc_mode = ACC_MODE(flag);
-
 	/* Allow the LSM permission hook to distinguish append 
 	   access from general write access. */
 	if (flag & O_APPEND)
-		acc_mode |= MAY_APPEND;
+		opendata->acc_mode |= MAY_APPEND;
 
 	/*
 	 * The simplest case - just a plain lookup.
@@ -1258,6 +1258,7 @@
 
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode) {
+		int mode = opendata->mode;
 		if (!IS_POSIXACL(dir->d_inode))
 			mode &= ~current->fs->umask;
 		error = vfs_create(dir->d_inode, dentry, mode);
@@ -1267,7 +1268,7 @@
 		if (error)
 			goto exit;
 		/* Don't check for write permission, don't truncate */
-		acc_mode = 0;
+		opendata->acc_mode = 0;
 		flag &= ~O_TRUNC;
 		goto ok;
 	}
@@ -1299,7 +1300,7 @@
 	if (dentry->d_inode && S_ISDIR(dentry->d_inode->i_mode))
 		goto exit;
 ok:
-	error = may_open(nd, acc_mode, flag);
+	error = may_open(nd, opendata->acc_mode, flag);
 	if (error)
 		goto exit;
 	return 0;
diff -u --recursive --new-file linux-2.5.69/fs/open.c linux-2.5.69-01-open1/fs/open.c
--- linux-2.5.69/fs/open.c	2003-05-21 02:23:23.000000000 +0200
+++ linux-2.5.69-01-open1/fs/open.c	2003-05-22 14:25:57.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/namei.h>
+#include <linux/open.h>
 #include <linux/backing-dev.h>
 #include <linux/security.h>
 #include <linux/mount.h>
@@ -602,6 +603,8 @@
 	return error;
 }
 
+#define ACC_MODE(x) ("\000\004\002\006"[(x)&O_ACCMODE])
+
 /*
  * Note that while the flag value (low two bits) for sys_open means:
  *	00 - read-only
@@ -620,14 +623,19 @@
 {
 	int namei_flags, error;
 	struct nameidata nd;
+	struct opendata opendata = {
+		.flag = flags,
+		.mode = mode,
+	};
 
 	namei_flags = flags;
 	if ((namei_flags+1) & O_ACCMODE)
 		namei_flags++;
 	if (namei_flags & O_TRUNC)
 		namei_flags |= 2;
+	opendata.acc_mode = ACC_MODE(namei_flags);
 
-	error = open_namei(filename, namei_flags, mode, &nd);
+	error = open_namei(filename, &opendata, &nd);
 	if (!error)
 		return dentry_open(nd.dentry, nd.mnt, flags);
 
diff -u --recursive --new-file linux-2.5.69/include/linux/fs.h linux-2.5.69-01-open1/include/linux/fs.h
--- linux-2.5.69/include/linux/fs.h	2003-05-17 23:09:32.000000000 +0200
+++ linux-2.5.69-01-open1/include/linux/fs.h	2003-05-22 14:25:57.000000000 +0200
@@ -23,6 +23,7 @@
 
 struct iovec;
 struct nameidata;
+struct opendata;
 struct pipe_inode_info;
 struct poll_table_struct;
 struct statfs;
@@ -1135,7 +1136,7 @@
 }
 extern int do_pipe(int *);
 
-extern int open_namei(const char *, int, int, struct nameidata *);
+extern int open_namei(const char *, struct opendata *, struct nameidata *);
 extern int may_open(struct nameidata *, int, int);
 
 extern int kernel_read(struct file *, unsigned long, char *, unsigned long);
diff -u --recursive --new-file linux-2.5.69/include/linux/open.h linux-2.5.69-01-open1/include/linux/open.h
--- linux-2.5.69/include/linux/open.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.69-01-open1/include/linux/open.h	2003-05-22 14:25:57.000000000 +0200
@@ -0,0 +1,17 @@
+#ifndef _LINUX_OPEN_H
+#define _LINUX_OPEN_H
+
+struct opendata {
+	int flag;
+	int mode;
+	int acc_mode;
+
+#if 0
+	/* Private data to be added to the filp->private_data field */
+	void *private;
+	/* Callback for destroying private data in case of an error */
+	void (*destroy)(struct opendata *, void *);
+#endif
+};
+
+#endif
