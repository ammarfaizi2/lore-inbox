Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVHHW2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVHHW2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVHHW2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:28:16 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:60164 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932297AbVHHW2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:28:16 -0400
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC] atomic open(..., O_CREAT | ...)
Message-Id: <E1E2G68-0006H2-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 09 Aug 2005 00:27:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to make my filesystem be able to do file creation and opening
atomically.  This is needed for filesystems which cannot separate
checking open permission from the actual open operation.

Usually any filesystem served from userspace by an unprivileged (no
CAP_DAC_OVERRIDE) process will be such (ftp, sftp, etc.).

With nameidata->intent.open.* it is possible to do the actual open
from ->lookup() or ->create().  However there's no easy way to
associate the 'struct file *' returned by dentry_open() with the
filesystem's private file object.  Also if there's some error after
the file has been opened but before a successful return of the file
pointer, the filesystem has no way to know that it should destroy the
private file object.

The following patch makes this possible through a new file pointer
field in the open intent data, through which the filesystem can pass
an opened file to be returned by filp_open().

The filesystem can call dentry_open() from ->lookup() or ->create(),
and it in with it's private file data.  If there's an error the file
can be properly destroyed through f_op->release().

There's one question on which I'm not sure what is the best solution:

The filesystem needs to know whether it's f_op->open() method was
called from lookup/create, or from the filp_open(), because in the
first case it need not do anything (the private file object will be
created outside dentry_open()), but in the second case it must
actually prepare the private file object.

Two solutions come to mind:

  1) pass a special open flag to dentry_open() which will be passed on
     to f_op->open() in filp->f_flags

  2) create a new 'dentry_open_noopen()' variant, which doesn't call
     f_op->open()

Does one sound better?  Or something else?

Comments are welcome.

Thanks,
Miklos

Index: linux/include/linux/namei.h
===================================================================
--- linux.orig/include/linux/namei.h	2005-06-17 21:48:29.000000000 +0200
+++ linux/include/linux/namei.h	2005-08-06 17:12:55.000000000 +0200
@@ -8,6 +8,10 @@ struct vfsmount;
 struct open_intent {
 	int	flags;
 	int	create_mode;
+	int	orig_flags;
+
+	/* Fs may want to do dentry_open() in ->lookup(), or in ->create() */
+	struct file *file;
 };
 
 enum { MAX_NESTED_LINKS = 5 };
Index: linux/fs/open.c
===================================================================
--- linux.orig/fs/open.c	2005-08-06 12:34:14.000000000 +0200
+++ linux/fs/open.c	2005-08-08 13:03:08.000000000 +0200
@@ -762,9 +762,22 @@ struct file *filp_open(const char * file
 	if (namei_flags & O_TRUNC)
 		namei_flags |= 2;
 
+	/* Fill in the open() intent data */
+	nd.intent.open.flags = namei_flags;
+	nd.intent.open.create_mode = mode;
+	nd.intent.open.orig_flags = flags;
+	nd.intent.open.file = NULL;
+
 	error = open_namei(filename, namei_flags, mode, &nd);
-	if (!error)
-		return dentry_open(nd.dentry, nd.mnt, flags);
+	if (!error) {
+		if (nd.intent.open.file)
+			return nd.intent.open.file;
+		else 
+			return dentry_open(nd.dentry, nd.mnt, flags);
+	}
+
+	if (nd.intent.open.file && !IS_ERR(nd.intent.open.file))
+		fput(nd.intent.open.file);
 
 	return ERR_PTR(error);
 }
Index: linux/fs/namei.c
===================================================================
--- linux.orig/fs/namei.c	2005-08-06 12:35:59.000000000 +0200
+++ linux/fs/namei.c	2005-08-06 17:12:55.000000000 +0200
@@ -1423,10 +1423,6 @@ int open_namei(const char * pathname, in
 	if (flag & O_APPEND)
 		acc_mode |= MAY_APPEND;
 
-	/* Fill in the open() intent data */
-	nd->intent.open.flags = flag;
-	nd->intent.open.create_mode = mode;
-
 	/*
 	 * The simplest case - just a plain lookup.
 	 */
