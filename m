Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVC3WF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVC3WF0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 17:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbVC3WF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 17:05:26 -0500
Received: from pat.uio.no ([129.240.130.16]:35774 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262362AbVC3WE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 17:04:27 -0500
Subject: [RFC] Allow open intents to return a fully initialized file
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: linux-kernel@vger.kernel.org
Cc: Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 17:04:18 -0500
Message-Id: <1112220258.10771.31.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.7, required 12,
	autolearn=disabled, AWL 1.30, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch is to allow filesystems that support the lookup with
open intents optimization to return a fully initialized file pointer.

The main use for this is stuff like NFSv4 that does lookup + sets up
open state in a single atomic RPC call, and that wishes to cache the
state information in the struct file. Currently, the filesystem has to
save that state information, then hunt round for it in the open
file_operation (something which is race prone, and doesn't allow one to
clean up the mess if the VFS aborts the open before calling down to the
filesystem again).

The NFSv4 code that makes use of this patch may be found on

  http://client.linux-nfs.org/Linux-2.6.x/2.6.12-rc1/

Comments appreciated.

Cheers,
  Trond


----
VFS: Allow the filesystem to return a full file pointer on open intent

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---
 fs/exec.c             |   12 ++++++------
 fs/namei.c            |   19 ++++++++++++++++---
 fs/open.c             |   14 +++++++++++++-
 include/linux/namei.h |   10 ++++++++++
 4 files changed, 45 insertions(+), 10 deletions(-)

Index: linux-2.6.12-rc1/fs/namei.c
===================================================================
--- linux-2.6.12-rc1.orig/fs/namei.c
+++ linux-2.6.12-rc1/fs/namei.c
@@ -28,6 +28,7 @@
 #include <linux/syscalls.h>
 #include <linux/mount.h>
 #include <linux/audit.h>
+#include <linux/file.h>
 #include <asm/namei.h>
 #include <asm/uaccess.h>
 
@@ -318,6 +319,19 @@ void path_release_on_umount(struct namei
 }
 
 /*
+ * Open intents have to release any file pointer that was allocated
+ * but not used by the VFS.
+ */
+void path_release_open_intent(struct nameidata *nd)
+{
+	if ((nd->flags & LOOKUP_OPEN) && nd->intent.open.file != NULL) {
+		fput(nd->intent.open.file);
+		nd->intent.open.file = NULL;
+	}
+	path_release(nd);
+}
+
+/*
  * Internal lookup() using the new generic dcache.
  * SMP-safe
  */
@@ -1406,8 +1420,7 @@ int open_namei(const char * pathname, in
 		acc_mode |= MAY_APPEND;
 
 	/* Fill in the open() intent data */
-	nd->intent.open.flags = flag;
-	nd->intent.open.create_mode = mode;
+	nd_init_open_intent(nd, flag, mode);
 
 	/*
 	 * The simplest case - just a plain lookup.
@@ -1498,7 +1511,7 @@ ok:
 exit_dput:
 	dput(dentry);
 exit:
-	path_release(nd);
+	path_release_open_intent(nd);
 	return error;
 
 do_link:
Index: linux-2.6.12-rc1/fs/exec.c
===================================================================
--- linux-2.6.12-rc1.orig/fs/exec.c
+++ linux-2.6.12-rc1/fs/exec.c
@@ -123,7 +123,7 @@ asmlinkage long sys_uselib(const char __
 	struct nameidata nd;
 	int error;
 
-	nd.intent.open.flags = FMODE_READ;
+	nd_init_open_intent(&nd, FMODE_READ, 0);
 	error = __user_walk(library, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);
 	if (error)
 		goto out;
@@ -136,7 +136,7 @@ asmlinkage long sys_uselib(const char __
 	if (error)
 		goto exit;
 
-	file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
+	file = nd_open_file(&nd, O_RDONLY);
 	error = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto out;
@@ -164,7 +164,7 @@ asmlinkage long sys_uselib(const char __
 out:
   	return error;
 exit:
-	path_release(&nd);
+	path_release_open_intent(&nd);
 	goto out;
 }
 
@@ -491,7 +491,7 @@ struct file *open_exec(const char *name)
 	int err;
 	struct file *file;
 
-	nd.intent.open.flags = FMODE_READ;
+	nd_init_open_intent(&nd, FMODE_READ, 0);
 	err = path_lookup(name, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);
 	file = ERR_PTR(err);
 
@@ -505,7 +505,7 @@ struct file *open_exec(const char *name)
 				err = -EACCES;
 			file = ERR_PTR(err);
 			if (!err) {
-				file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
+				file = nd_open_file(&nd, O_RDONLY);
 				if (!IS_ERR(file)) {
 					err = deny_write_access(file);
 					if (err) {
@@ -517,7 +517,7 @@ out:
 				return file;
 			}
 		}
-		path_release(&nd);
+		path_release_open_intent(&nd);
 	}
 	goto out;
 }
Index: linux-2.6.12-rc1/include/linux/namei.h
===================================================================
--- linux-2.6.12-rc1.orig/include/linux/namei.h
+++ linux-2.6.12-rc1/include/linux/namei.h
@@ -8,6 +8,7 @@ struct vfsmount;
 struct open_intent {
 	int	flags;
 	int	create_mode;
+	struct file *file;
 };
 
 enum { MAX_NESTED_LINKS = 5 };
@@ -64,6 +65,15 @@ extern int FASTCALL(path_walk(const char
 extern int FASTCALL(link_path_walk(const char *, struct nameidata *));
 extern void path_release(struct nameidata *);
 extern void path_release_on_umount(struct nameidata *);
+extern void path_release_open_intent(struct nameidata *);
+
+extern struct file *nd_open_file(struct nameidata *nd, int flags);
+static inline void nd_init_open_intent(struct nameidata *nd, int flags, int mode)
+{
+	nd->intent.open.flags = flags;
+	nd->intent.open.create_mode = mode;
+	nd->intent.open.file = NULL;
+}
 
 extern struct dentry * lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry * lookup_hash(struct qstr *, struct dentry *);
Index: linux-2.6.12-rc1/fs/open.c
===================================================================
--- linux-2.6.12-rc1.orig/fs/open.c
+++ linux-2.6.12-rc1/fs/open.c
@@ -763,13 +763,25 @@ struct file *filp_open(const char * file
 
 	error = open_namei(filename, namei_flags, mode, &nd);
 	if (!error)
-		return dentry_open(nd.dentry, nd.mnt, flags);
+		return nd_open_file(&nd, flags);
 
 	return ERR_PTR(error);
 }
 
 EXPORT_SYMBOL(filp_open);
 
+struct file *nd_open_file(struct nameidata *nd, int flags)
+{
+	struct file *filp;
+
+	if ((nd->flags & LOOKUP_OPEN) && nd->intent.open.file != NULL) {
+		filp = nd->intent.open.file;
+		path_release(nd);
+	} else
+		filp = dentry_open(nd->dentry, nd->mnt, flags);
+	return filp;
+}
+
 struct file *dentry_open(struct dentry *dentry, struct vfsmount *mnt, int flags)
 {
 	struct file * f;

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

