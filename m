Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbVJLTBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbVJLTBo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 15:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbVJLTBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 15:01:44 -0400
Received: from pat.uio.no ([129.240.130.16]:39140 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751507AbVJLTBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 15:01:42 -0400
Subject: Re: [RFC] atomic create+open
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1EPh1j-0000jR-00@dorka.pomaz.szeredi.hu>
References: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
	 <1128616864.8396.32.camel@lade.trondhjem.org>
	 <E1ENZ8u-0003JS-00@dorka.pomaz.szeredi.hu>
	 <E1ENZCQ-0003K3-00@dorka.pomaz.szeredi.hu>
	 <1128619526.16534.8.camel@lade.trondhjem.org>
	 <E1ENZZl-0003OO-00@dorka.pomaz.szeredi.hu>
	 <1128620528.16534.26.camel@lade.trondhjem.org>
	 <E1ENZu1-0003SP-00@dorka.pomaz.szeredi.hu>
	 <1128623899.31797.14.camel@lade.trondhjem.org>
	 <E1ENani-0003c4-00@dorka.pomaz.szeredi.hu>
	 <1128626258.31797.34.camel@lade.trondhjem.org>
	 <E1ENcAr-0003jz-00@dorka.pomaz.szeredi.hu>
	 <1128633138.31797.52.camel@lade.trondhjem.org>
	 <E1ENlI2-0004Gt-00@dorka.pomaz.szeredi.hu>
	 <1128692289.8519.75.camel@lade.trondhjem.org>
	 <E1ENslH-00057W-00@dorka.pomaz.szeredi.hu>
	 <1128698035.8583.36.camel@lade.trondhjem.org>
	 <E1ENu8h-0005Kd-00@dorka.pomaz.szeredi.hu>
	 <1128702227.8583.69.camel@lade.trondhjem.org>
	 <E1ENvzx-0005VT-00@dorka.pomaz.szeredi.hu>
	 <1129061494.11164.38.camel@lade.trondhjem.org>
	 <E1EPeM4-0000Xz-00@dorka.pomaz.szeredi.hu>
	 <1129123257.8561.27.camel@lade.trondhjem.org>
	 <E1EPh1j-0000jR-00@dorka.pomaz.szeredi.hu>
Content-Type: multipart/mixed; boundary="=-H23xmUJFbGobYWfeT6t4"
Date: Wed, 12 Oct 2005 15:01:26 -0400
Message-Id: <1129143686.8434.64.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.926, required 12,
	autolearn=disabled, AWL 1.07, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-H23xmUJFbGobYWfeT6t4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

on den 12.10.2005 Klokka 15:52 (+0200) skreiv Miklos Szeredi:

> > I don't care either way since we will not be supporting non-intent based
> > opens for NFSv4.
> 
> I need this for FUSE, since non-create opens and non-exclusive open of
> positive dentry will be done through ->open().

How about something like the following instead? That gives you the
option of choosing a non-standard initialisation for the intent case,
with the default being ->open().

Cheers,
  Trond

--=-H23xmUJFbGobYWfeT6t4
Content-Disposition: inline; filename=linux-2.6.14-11-open_file_intents.dif
Content-Type: text/plain; name=linux-2.6.14-11-open_file_intents.dif; charset=utf-8
Content-Transfer-Encoding: 7bit

VFS: Allow the filesystem to return a full file pointer on open intent

 This is needed by NFSv4 for atomicity reasons: our open command is in
 fact a lookup+open, so we need to be able to propagate open context
 information from lookup() into the resulting struct file's
 private_data field.

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---
 fs/exec.c             |   12 +++---
 fs/namei.c            |   93 ++++++++++++++++++++++++++++++++++++++++++++++----
 fs/open.c             |   79 ++++++++++++++++++++++++++++++++++--------
 include/linux/namei.h |    8 ++++
 4 files changed, 165 insertions(+), 27 deletions(-)

Index: linux-2.6.14-rc4/fs/namei.c
===================================================================
--- linux-2.6.14-rc4.orig/fs/namei.c
+++ linux-2.6.14-rc4/fs/namei.c
@@ -28,6 +28,7 @@
 #include <linux/syscalls.h>
 #include <linux/mount.h>
 #include <linux/audit.h>
+#include <linux/file.h>
 #include <asm/namei.h>
 #include <asm/uaccess.h>
 
@@ -317,6 +318,18 @@ void path_release_on_umount(struct namei
 	mntput_no_expire(nd->mnt);
 }
 
+/**
+ * release_open_intent - free up open intent resources
+ * @nd: pointer to nameidata
+ */
+void release_open_intent(struct nameidata *nd)
+{
+	if (nd->intent.open.file->f_dentry == NULL)
+		put_filp(nd->intent.open.file);
+	else
+		fput(nd->intent.open.file);
+}
+
 /*
  * Internal lookup() using the new generic dcache.
  * SMP-safe
@@ -1052,6 +1065,70 @@ out:
 	return retval;
 }
 
+static int __path_lookup_intent_open(const char *name, unsigned int lookup_flags,
+		struct nameidata *nd, int open_flags, int create_mode)
+{
+	struct file *filp = get_empty_filp();
+	int err;
+
+	if (filp == NULL)
+		return -ENFILE;
+	nd->intent.open.file = filp;
+	nd->intent.open.flags = open_flags;
+	nd->intent.open.create_mode = create_mode;
+	err = path_lookup(name, lookup_flags|LOOKUP_OPEN, nd);
+	if (IS_ERR(nd->intent.open.file)) {
+		if (err == 0) {
+			err = PTR_ERR(nd->intent.open.file);
+			path_release(nd);
+		}
+	} else if (err != 0)
+		release_open_intent(nd);
+	return err;
+}
+
+/**
+ * path_lookup_open - lookup a file path with open intent
+ * @name: pointer to file name
+ * @lookup_flags: lookup intent flags
+ * @nd: pointer to nameidata
+ * @open_flags: open intent flags
+ */
+int path_lookup_open(const char *name, unsigned int lookup_flags,
+		struct nameidata *nd, int open_flags)
+{
+	return __path_lookup_intent_open(name, lookup_flags, nd,
+			open_flags, 0);
+}
+
+/**
+ * path_lookup_create - lookup a file path with open + create intent
+ * @name: pointer to file name
+ * @lookup_flags: lookup intent flags
+ * @nd: pointer to nameidata
+ * @open_flags: open intent flags
+ * @create_mode: create intent flags
+ */
+int path_lookup_create(const char *name, unsigned int lookup_flags,
+		struct nameidata *nd, int open_flags, int create_mode)
+{
+	return __path_lookup_intent_open(name, lookup_flags|LOOKUP_CREATE, nd,
+			open_flags, create_mode);
+}
+
+int __user_path_lookup_open(const char __user *name, unsigned int lookup_flags,
+		struct nameidata *nd, int open_flags)
+{
+	char *tmp = getname(name);
+	int err = PTR_ERR(tmp);
+
+	if (!IS_ERR(tmp)) {
+		err = __path_lookup_intent_open(tmp, lookup_flags, nd, open_flags, 0);
+		putname(tmp);
+	}
+	return err;
+}
+
 /*
  * Restricted form of lookup. Doesn't follow links, single-component only,
  * needs parent already locked. Doesn't follow mounts.
@@ -1416,27 +1493,27 @@ int may_open(struct nameidata *nd, int a
  */
 int open_namei(const char * pathname, int flag, int mode, struct nameidata *nd)
 {
-	int acc_mode, error = 0;
+	int acc_mode, error;
 	struct path path;
 	struct dentry *dir;
 	int count = 0;
 
 	acc_mode = ACC_MODE(flag);
 
+	/* O_TRUNC implies we need access checks for write permissions */
+	if (flag & O_TRUNC)
+		acc_mode |= MAY_WRITE;
+
 	/* Allow the LSM permission hook to distinguish append 
 	   access from general write access. */
 	if (flag & O_APPEND)
 		acc_mode |= MAY_APPEND;
 
-	/* Fill in the open() intent data */
-	nd->intent.open.flags = flag;
-	nd->intent.open.create_mode = mode;
-
 	/*
 	 * The simplest case - just a plain lookup.
 	 */
 	if (!(flag & O_CREAT)) {
-		error = path_lookup(pathname, lookup_flags(flag)|LOOKUP_OPEN, nd);
+		error = path_lookup_open(pathname, lookup_flags(flag), nd, flag);
 		if (error)
 			return error;
 		goto ok;
@@ -1445,7 +1522,7 @@ int open_namei(const char * pathname, in
 	/*
 	 * Create - we need to know the parent.
 	 */
-	error = path_lookup(pathname, LOOKUP_PARENT|LOOKUP_OPEN|LOOKUP_CREATE, nd);
+	error = path_lookup_create(pathname, LOOKUP_PARENT, nd, flag, mode);
 	if (error)
 		return error;
 
@@ -1520,6 +1597,8 @@ ok:
 exit_dput:
 	dput_path(&path, nd);
 exit:
+	if (!IS_ERR(nd->intent.open.file))
+		release_open_intent(nd);
 	path_release(nd);
 	return error;
 
Index: linux-2.6.14-rc4/fs/exec.c
===================================================================
--- linux-2.6.14-rc4.orig/fs/exec.c
+++ linux-2.6.14-rc4/fs/exec.c
@@ -126,8 +126,7 @@ asmlinkage long sys_uselib(const char __
 	struct nameidata nd;
 	int error;
 
-	nd.intent.open.flags = FMODE_READ;
-	error = __user_walk(library, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);
+	error = __user_path_lookup_open(library, LOOKUP_FOLLOW, &nd, FMODE_READ);
 	if (error)
 		goto out;
 
@@ -139,7 +138,7 @@ asmlinkage long sys_uselib(const char __
 	if (error)
 		goto exit;
 
-	file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
+	file = nameidata_to_filp(&nd, O_RDONLY);
 	error = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto out;
@@ -167,6 +166,7 @@ asmlinkage long sys_uselib(const char __
 out:
   	return error;
 exit:
+	release_open_intent(&nd);
 	path_release(&nd);
 	goto out;
 }
@@ -490,8 +490,7 @@ struct file *open_exec(const char *name)
 	int err;
 	struct file *file;
 
-	nd.intent.open.flags = FMODE_READ;
-	err = path_lookup(name, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);
+	err = path_lookup_open(name, LOOKUP_FOLLOW, &nd, FMODE_READ);
 	file = ERR_PTR(err);
 
 	if (!err) {
@@ -504,7 +503,7 @@ struct file *open_exec(const char *name)
 				err = -EACCES;
 			file = ERR_PTR(err);
 			if (!err) {
-				file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
+				file = nameidata_to_filp(&nd, O_RDONLY);
 				if (!IS_ERR(file)) {
 					err = deny_write_access(file);
 					if (err) {
@@ -516,6 +515,7 @@ out:
 				return file;
 			}
 		}
+		release_open_intent(&nd);
 		path_release(&nd);
 	}
 	goto out;
Index: linux-2.6.14-rc4/include/linux/namei.h
===================================================================
--- linux-2.6.14-rc4.orig/include/linux/namei.h
+++ linux-2.6.14-rc4/include/linux/namei.h
@@ -8,6 +8,7 @@ struct vfsmount;
 struct open_intent {
 	int	flags;
 	int	create_mode;
+	struct file *file;
 };
 
 enum { MAX_NESTED_LINKS = 5 };
@@ -65,6 +66,13 @@ extern int FASTCALL(link_path_walk(const
 extern void path_release(struct nameidata *);
 extern void path_release_on_umount(struct nameidata *);
 
+extern int __user_path_lookup_open(const char __user *, unsigned lookup_flags, struct nameidata *nd, int open_flags);
+extern int path_lookup_open(const char *, unsigned lookup_flags, struct nameidata *, int open_flags);
+extern struct file *lookup_instantiate_filp(struct nameidata *nd, struct dentry *dentry,
+		int (*open)(struct inode *, struct file *));
+extern struct file *nameidata_to_filp(struct nameidata *nd, int flags);
+extern void release_open_intent(struct nameidata *);
+
 extern struct dentry * lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry * lookup_hash(struct qstr *, struct dentry *);
 
Index: linux-2.6.14-rc4/fs/open.c
===================================================================
--- linux-2.6.14-rc4.orig/fs/open.c
+++ linux-2.6.14-rc4/fs/open.c
@@ -739,7 +739,8 @@ asmlinkage long sys_fchown(unsigned int 
 }
 
 static struct file *__dentry_open(struct dentry *dentry, struct vfsmount *mnt,
-					int flags, struct file *f)
+					int flags, struct file *f,
+					int (*open)(struct inode *, struct file *))
 {
 	struct inode *inode;
 	int error;
@@ -761,11 +762,14 @@ static struct file *__dentry_open(struct
 	f->f_op = fops_get(inode->i_fop);
 	file_move(f, &inode->i_sb->s_files);
 
-	if (f->f_op && f->f_op->open) {
-		error = f->f_op->open(inode,f);
+	if (!open && f->f_op)
+		open = f->f_op->open;
+	if (open) {
+		error = open(inode, f);
 		if (error)
 			goto cleanup_all;
 	}
+
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
 	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
@@ -814,28 +818,75 @@ struct file *filp_open(const char * file
 {
 	int namei_flags, error;
 	struct nameidata nd;
-	struct file *f;
 
 	namei_flags = flags;
 	if ((namei_flags+1) & O_ACCMODE)
 		namei_flags++;
-	if (namei_flags & O_TRUNC)
-		namei_flags |= 2;
-
-	error = -ENFILE;
-	f = get_empty_filp();
-	if (f == NULL)
-		return ERR_PTR(error);
 
 	error = open_namei(filename, namei_flags, mode, &nd);
 	if (!error)
-		return __dentry_open(nd.dentry, nd.mnt, flags, f);
+		return nameidata_to_filp(&nd, flags);
 
-	put_filp(f);
 	return ERR_PTR(error);
 }
 EXPORT_SYMBOL(filp_open);
 
+/**
+ * lookup_instantiate_filp - instantiates the open intent filp
+ * @nd: pointer to nameidata
+ * @dentry: pointer to dentry
+ * @open: open callback
+ *
+ * Helper for filesystems that want to use lookup open intents and pass back
+ * a fully instantiated struct file to the caller.
+ * This function is meant to be called from within a filesystem's
+ * lookup method.
+ * Note that in case of error, nd->intent.open.file is destroyed, but the
+ * path information remains valid.
+ * If the open callback is set to NULL, then the standard f_op->open()
+ * filesystem callback is substituted.
+ */
+struct file *lookup_instantiate_filp(struct nameidata *nd, struct dentry *dentry,
+		int (*open)(struct inode *, struct file *))
+{
+	if (IS_ERR(nd->intent.open.file))
+		goto out;
+	if (IS_ERR(dentry))
+		goto out_err;
+	nd->intent.open.file = __dentry_open(dget(dentry), mntget(nd->mnt),
+					     nd->intent.open.flags - 1,
+					     nd->intent.open.file,
+					     open);
+out:
+	return nd->intent.open.file;
+out_err:
+	release_open_intent(nd);
+	nd->intent.open.file = (struct file *)dentry;
+	goto out;
+}
+EXPORT_SYMBOL_GPL(lookup_instantiate_filp);
+
+/**
+ * nameidata_to_filp - convert a nameidata to an open filp.
+ * @nd: pointer to nameidata
+ * @flags: open flags
+ *
+ * Note that this function destroys the original nameidata
+ */
+struct file *nameidata_to_filp(struct nameidata *nd, int flags)
+{
+	struct file *filp;
+
+	/* Pick up the filp from the open intent */
+	filp = nd->intent.open.file;
+	/* Has the filesystem initialised the file for us? */
+	if (filp->f_dentry == NULL)
+		filp = __dentry_open(nd->dentry, nd->mnt, flags, filp, NULL);
+	else
+		path_release(nd);
+	return filp;
+}
+
 struct file *dentry_open(struct dentry *dentry, struct vfsmount *mnt, int flags)
 {
 	int error;
@@ -846,7 +897,7 @@ struct file *dentry_open(struct dentry *
 	if (f == NULL)
 		return ERR_PTR(error);
 
-	return __dentry_open(dentry, mnt, flags, f);
+	return __dentry_open(dentry, mnt, flags, f, NULL);
 }
 EXPORT_SYMBOL(dentry_open);
 

--=-H23xmUJFbGobYWfeT6t4--

