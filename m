Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265111AbUGGMvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbUGGMvt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 08:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUGGMvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 08:51:22 -0400
Received: from linuxhacker.ru ([217.76.32.60]:2775 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265104AbUGGMti (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:49:38 -0400
Date: Wed, 7 Jul 2004 15:47:32 +0300
From: Oleg Drokin <green@clusterfs.com>
To: linux-kernel@vger.kernel.org, braam@clusterfs.com
Subject: [3/9] Lustre VFS patches for 2.6
Message-ID: <20040707124732.GA25917@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds intent opertion and intent release callback to
struct open_intent, so that interested code
can know what is about to be performed. Also magic is added to ease tracing
of use of uninitialized intents.  Initialize intents on usage, fill in correct
intent operation. Make wrappers that initialize intents to some sane values for
intent-unaware code and old-API compatibility.

 fs/exec.c             |   10 ++++---
 fs/namei.c            |   69 ++++++++++++++++++++++++++++++++++++++++++++------
 fs/namespace.c        |    1 
 fs/open.c             |   28 +++++++++++++++-----
 fs/stat.c             |   10 +++++--
 fs/xattr.c            |   12 +++++---
 include/linux/fs.h    |    2 +
 include/linux/namei.h |   34 ++++++++++++++++++++++++
 8 files changed, 141 insertions(+), 25 deletions(-)

Index: linus-2.6.7-bk-latest/include/linux/namei.h
===================================================================
--- linus-2.6.7-bk-latest.orig/include/linux/namei.h	2004-07-07 10:56:34.232378296 +0300
+++ linus-2.6.7-bk-latest/include/linux/namei.h	2004-07-07 11:41:48.569736296 +0300
@@ -2,14 +2,40 @@
 #define _LINUX_NAMEI_H
 
 #include <linux/linkage.h>
+#include <linux/string.h>
 
 struct vfsmount;
 
+/* intent opcodes */
+#define IT_OPEN		(1)
+#define IT_CREAT	(1<<1)
+#define IT_READDIR	(1<<2)
+#define IT_GETATTR	(1<<3)
+#define IT_LOOKUP	(1<<4)
+#define IT_UNLINK	(1<<5)
+#define IT_TRUNC	(1<<6)
+#define IT_GETXATTR	(1<<7)
+
+#define INTENT_MAGIC 0x19620323
+
 struct open_intent {
+	int	magic;
+	int	op;
+	void	(*op_release)(struct open_intent *);
 	int	flags;
 	int	create_mode;
+	union {
+		void *fs_data; /* FS-specific intent data */
+	} d;
 };
 
+static inline void intent_init(struct open_intent *it, int op)
+{
+	memset(it, 0, sizeof(*it));
+	it->magic = INTENT_MAGIC;
+	it->op = op;
+}
+
 enum { MAX_NESTED_LINKS = 5 };
 
 struct nameidata {
@@ -53,14 +76,22 @@
 #define LOOKUP_ACCESS		(0x0400)
 
 extern int FASTCALL(__user_walk(const char __user *, unsigned, struct nameidata *));
+extern int FASTCALL(__user_walk_it(const char __user *, unsigned, struct nameidata *));
 #define user_path_walk(name,nd) \
 	__user_walk(name, LOOKUP_FOLLOW, nd)
+#define user_path_walk_it(name,nd) \
+	__user_walk_it(name, LOOKUP_FOLLOW, nd)
 #define user_path_walk_link(name,nd) \
 	__user_walk(name, 0, nd)
+#define user_path_walk_link_it(name,nd) \
+	__user_walk_it(name, 0, nd)
 extern int FASTCALL(path_lookup(const char *, unsigned, struct nameidata *));
+extern int FASTCALL(path_lookup_it(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_walk(const char *, struct nameidata *));
+extern int FASTCALL(path_walk_it(const char *, struct nameidata *));
 extern int FASTCALL(link_path_walk(const char *, struct nameidata *));
 extern void path_release(struct nameidata *);
+extern void intent_release(struct open_intent *);
 
 extern struct dentry * lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry * lookup_hash(struct qstr *, struct dentry *);
Index: linus-2.6.7-bk-latest/include/linux/fs.h
===================================================================
--- linus-2.6.7-bk-latest.orig/include/linux/fs.h	2004-07-07 10:56:33.720456120 +0300
+++ linus-2.6.7-bk-latest/include/linux/fs.h	2004-07-07 11:38:42.864967712 +0300
@@ -583,6 +583,7 @@
 	spinlock_t		f_ep_lock;
 #endif /* #ifdef CONFIG_EPOLL */
 	struct address_space	*f_mapping;
+	struct open_intent	*f_it;
 };
 extern spinlock_t files_lock;
 #define file_list_lock() spin_lock(&files_lock);
@@ -1201,6 +1202,7 @@
 extern int do_truncate(struct dentry *, loff_t start);
 extern struct file *filp_open(const char *, int, int);
 extern struct file * dentry_open(struct dentry *, struct vfsmount *, int);
+extern struct file * dentry_open_it(struct dentry *, struct vfsmount *, int, struct open_intent *);
 extern int filp_close(struct file *, fl_owner_t id);
 extern char * getname(const char __user *);
 
Index: linus-2.6.7-bk-latest/fs/namei.c
===================================================================
--- linus-2.6.7-bk-latest.orig/fs/namei.c	2004-07-07 10:56:13.455536856 +0300
+++ linus-2.6.7-bk-latest/fs/namei.c	2004-07-07 11:38:42.866967408 +0300
@@ -272,8 +272,19 @@
 	return 0;
 }
 
+void intent_release(struct open_intent *it)
+{
+	if (!it)
+		return;
+	if (it->magic != INTENT_MAGIC)
+		return;
+	if (it->op_release)
+		it->op_release(it);
+}
+
 void path_release(struct nameidata *nd)
 {
+	intent_release(&nd->intent.open);
 	dput(nd->dentry);
 	mntput(nd->mnt);
 }
@@ -790,8 +801,14 @@
 	return err;
 }
 
+int fastcall path_walk_it(const char * name, struct nameidata *nd)
+{
+	current->total_link_count = 0;
+	return link_path_walk(name, nd);
+}
 int fastcall path_walk(const char * name, struct nameidata *nd)
 {
+	intent_init(&nd->intent.open, IT_LOOKUP);
 	current->total_link_count = 0;
 	return link_path_walk(name, nd);
 }
@@ -800,7 +817,7 @@
 /* returns 1 if everything is done */
 static int __emul_lookup_dentry(const char *name, struct nameidata *nd)
 {
-	if (path_walk(name, nd))
+	if (path_walk_it(name, nd))
 		return 0;		/* something went wrong... */
 
 	if (!nd->dentry->d_inode || S_ISDIR(nd->dentry->d_inode->i_mode)) {
@@ -878,7 +895,18 @@
 	return 1;
 }
 
-int fastcall path_lookup(const char *name, unsigned int flags, struct nameidata *nd)
+static inline int it_mode_from_lookup_flags(int flags)
+{
+	int mode = IT_LOOKUP;
+
+	if (flags & LOOKUP_OPEN)
+		mode = IT_OPEN;
+	if (flags & LOOKUP_CREATE)
+		mode |= IT_CREAT;
+	return mode;
+}
+
+int fastcall path_lookup_it(const char *name, unsigned int flags, struct nameidata *nd)
 {
 	int retval;
 
@@ -914,6 +942,12 @@
 	return retval;
 }
 
+int fastcall path_lookup(const char *name, unsigned int flags, struct nameidata *nd)
+{
+	intent_init(&nd->intent.open, it_mode_from_lookup_flags(flags));
+	return path_lookup_it(name, flags, nd);
+}
+
 /*
  * Restricted form of lookup. Doesn't follow links, single-component only,
  * needs parent already locked. Doesn't follow mounts.
@@ -964,7 +998,7 @@
 }
 
 /* SMP-safe */
-struct dentry * lookup_one_len(const char * name, struct dentry * base, int len)
+struct dentry * lookup_one_len_it(const char * name, struct dentry * base, int len, struct nameidata *nd)
 {
 	unsigned long hash;
 	struct qstr this;
@@ -984,11 +1018,16 @@
 	}
 	this.hash = end_name_hash(hash);
 
-	return lookup_hash(&this, base);
+	return __lookup_hash(&this, base, nd);
 access:
 	return ERR_PTR(-EACCES);
 }
 
+struct dentry * lookup_one_len(const char * name, struct dentry * base, int len)
+{
+	return lookup_one_len_it(name, base, len, NULL);
+}
+
 /*
  *	namei()
  *
@@ -1000,18 +1039,24 @@
  * that namei follows links, while lnamei does not.
  * SMP-safe
  */
-int fastcall __user_walk(const char __user *name, unsigned flags, struct nameidata *nd)
+int fastcall __user_walk_it(const char __user *name, unsigned flags, struct nameidata *nd)
 {
 	char *tmp = getname(name);
 	int err = PTR_ERR(tmp);
 
 	if (!IS_ERR(tmp)) {
-		err = path_lookup(tmp, flags, nd);
+		err = path_lookup_it(tmp, flags, nd);
 		putname(tmp);
 	}
 	return err;
 }
 
+int fastcall __user_walk(const char __user *name, unsigned flags, struct nameidata *nd)
+{
+	intent_init(&nd->intent.open, it_mode_from_lookup_flags(flags));
+	return __user_walk_it(name, flags, nd);
+}
+
 /*
  * It's inline, so penalty for filesystems that don't use sticky bit is
  * minimal.
@@ -1296,7 +1341,7 @@
 	 * The simplest case - just a plain lookup.
 	 */
 	if (!(flag & O_CREAT)) {
-		error = path_lookup(pathname, lookup_flags(flag)|LOOKUP_OPEN, nd);
+		error = path_lookup_it(pathname, lookup_flags(flag), nd);
 		if (error)
 			return error;
 		goto ok;
@@ -1305,7 +1350,8 @@
 	/*
 	 * Create - we need to know the parent.
 	 */
-	error = path_lookup(pathname, LOOKUP_PARENT|LOOKUP_OPEN|LOOKUP_CREATE, nd);
+	nd->intent.open.op |= IT_CREAT;
+	error = path_lookup_it(pathname, LOOKUP_PARENT, nd);
 	if (error)
 		return error;
 
@@ -2214,6 +2260,7 @@
 static int __vfs_follow_link(struct nameidata *nd, const char *link)
 {
 	int res = 0;
+	struct open_intent it = nd->intent.open;
 	char *name;
 	if (IS_ERR(link))
 		goto fail;
@@ -2224,6 +2271,9 @@
 			/* weird __emul_prefix() stuff did it */
 			goto out;
 	}
+	intent_init(&nd->intent.open, it.op);
+	nd->intent.open.flags = it.flags;
+	nd->intent.open.create_mode = it.create_mode;
 	res = link_path_walk(link, nd);
 out:
 	if (nd->depth || res || nd->last_type!=LAST_NORM)
@@ -2322,6 +2372,7 @@
 	return res;
 }
 
+
 int page_symlink(struct inode *inode, const char *symname, int len)
 {
 	struct address_space *mapping = inode->i_mapping;
@@ -2385,8 +2436,10 @@
 EXPORT_SYMBOL(page_symlink);
 EXPORT_SYMBOL(page_symlink_inode_operations);
 EXPORT_SYMBOL(path_lookup);
+EXPORT_SYMBOL(path_lookup_it);
 EXPORT_SYMBOL(path_release);
 EXPORT_SYMBOL(path_walk);
+EXPORT_SYMBOL(path_walk_it);
 EXPORT_SYMBOL(permission);
 EXPORT_SYMBOL(unlock_rename);
 EXPORT_SYMBOL(vfs_create);
Index: linus-2.6.7-bk-latest/fs/open.c
===================================================================
--- linus-2.6.7-bk-latest.orig/fs/open.c	2004-07-07 10:56:13.610513296 +0300
+++ linus-2.6.7-bk-latest/fs/open.c	2004-07-07 11:38:42.867967256 +0300
@@ -216,11 +216,12 @@
 	struct inode * inode;
 	int error;
 
+	intent_init(&nd.intent.open, IT_GETATTR);
 	error = -EINVAL;
 	if (length < 0)	/* sorry, but loff_t says... */
 		goto out;
 
-	error = user_path_walk(path, &nd);
+	error = user_path_walk_it(path, &nd);
 	if (error)
 		goto out;
 	inode = nd.dentry->d_inode;
@@ -475,6 +476,7 @@
 	kernel_cap_t old_cap;
 	int res;
 
+	intent_init(&nd.intent.open, IT_GETATTR);
 	if (mode & ~S_IRWXO)	/* where's F_OK, X_OK, W_OK, R_OK? */
 		return -EINVAL;
 
@@ -498,7 +500,7 @@
 	else
 		current->cap_effective = current->cap_permitted;
 
-	res = __user_walk(filename, LOOKUP_FOLLOW|LOOKUP_ACCESS, &nd);
+	res = __user_walk_it(filename, LOOKUP_FOLLOW|LOOKUP_ACCESS, &nd);
 	if (!res) {
 		res = permission(nd.dentry->d_inode, mode, &nd);
 		/* SuS v2 requires we report a read only fs too */
@@ -520,7 +522,8 @@
 	struct nameidata nd;
 	int error;
 
-	error = __user_walk(filename, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &nd);
+	intent_init(&nd.intent.open, IT_GETATTR);
+	error = __user_walk_it(filename, LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &nd);
 	if (error)
 		goto out;
 
@@ -571,7 +574,8 @@
 	struct nameidata nd;
 	int error;
 
-	error = __user_walk(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY | LOOKUP_NOALT, &nd);
+	intent_init(&nd.intent.open, IT_GETATTR);
+	error = __user_walk_it(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY | LOOKUP_NOALT, &nd);
 	if (error)
 		goto out;
 
@@ -754,6 +758,7 @@
 {
 	int namei_flags, error;
 	struct nameidata nd;
+	intent_init(&nd.intent.open, IT_OPEN);
 
 	namei_flags = flags;
 	if ((namei_flags+1) & O_ACCMODE)
@@ -763,14 +768,14 @@
 
 	error = open_namei(filename, namei_flags, mode, &nd);
 	if (!error)
-		return dentry_open(nd.dentry, nd.mnt, flags);
+		return dentry_open_it(nd.dentry, nd.mnt, flags, &nd.intent.open);
 
 	return ERR_PTR(error);
 }
 
 EXPORT_SYMBOL(filp_open);
 
-struct file *dentry_open(struct dentry *dentry, struct vfsmount *mnt, int flags)
+struct file *dentry_open_it(struct dentry *dentry, struct vfsmount *mnt, int flags, struct open_intent *it)
 {
 	struct file * f;
 	struct inode *inode;
@@ -782,6 +787,7 @@
 		goto cleanup_dentry;
 	f->f_flags = flags;
 	f->f_mode = (flags+1) & O_ACCMODE;
+	f->f_it = it;
 	inode = dentry->d_inode;
 	if (f->f_mode & FMODE_WRITE) {
 		error = get_write_access(inode);
@@ -800,6 +806,7 @@
 		error = f->f_op->open(inode,f);
 		if (error)
 			goto cleanup_all;
+		intent_release(it);
 	}
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
@@ -825,11 +832,20 @@
 cleanup_file:
 	put_filp(f);
 cleanup_dentry:
+	intent_release(it);
 	dput(dentry);
 	mntput(mnt);
 	return ERR_PTR(error);
 }
 
+struct file *dentry_open(struct dentry *dentry, struct vfsmount *mnt, int flags)
+{
+	struct open_intent it;
+	intent_init(&it, IT_LOOKUP);
+
+	return dentry_open_it(dentry, mnt, flags, &it);
+}
+
 EXPORT_SYMBOL(dentry_open);
 
 /*
Index: linus-2.6.7-bk-latest/fs/stat.c
===================================================================
--- linus-2.6.7-bk-latest.orig/fs/stat.c	2004-07-07 10:56:13.635509496 +0300
+++ linus-2.6.7-bk-latest/fs/stat.c	2004-07-07 11:38:42.868967104 +0300
@@ -59,15 +59,15 @@
 	}
 	return 0;
 }
-
 EXPORT_SYMBOL(vfs_getattr);
 
 int vfs_stat(char __user *name, struct kstat *stat)
 {
 	struct nameidata nd;
 	int error;
+	intent_init(&nd.intent.open, IT_GETATTR);
 
-	error = user_path_walk(name, &nd);
+	error = user_path_walk_it(name, &nd);
 	if (!error) {
 		error = vfs_getattr(nd.mnt, nd.dentry, stat);
 		path_release(&nd);
@@ -81,8 +81,9 @@
 {
 	struct nameidata nd;
 	int error;
+	intent_init(&nd.intent.open, IT_GETATTR);
 
-	error = user_path_walk_link(name, &nd);
+	error = user_path_walk_link_it(name, &nd);
 	if (!error) {
 		error = vfs_getattr(nd.mnt, nd.dentry, stat);
 		path_release(&nd);
@@ -96,9 +97,12 @@
 {
 	struct file *f = fget(fd);
 	int error = -EBADF;
+	struct nameidata nd;
+	intent_init(&nd.intent.open, IT_GETATTR);
 
 	if (f) {
 		error = vfs_getattr(f->f_vfsmnt, f->f_dentry, stat);
+		intent_release(&nd.intent.open);
 		fput(f);
 	}
 	return error;
Index: linus-2.6.7-bk-latest/fs/namespace.c
===================================================================
--- linus-2.6.7-bk-latest.orig/fs/namespace.c	2004-07-07 10:56:13.605514056 +0300
+++ linus-2.6.7-bk-latest/fs/namespace.c	2004-07-07 11:38:42.868967104 +0300
@@ -117,6 +117,7 @@
 
 static void detach_mnt(struct vfsmount *mnt, struct nameidata *old_nd)
 {
+	memset(old_nd, 0, sizeof(*old_nd));
 	old_nd->dentry = mnt->mnt_mountpoint;
 	old_nd->mnt = mnt->mnt_parent;
 	mnt->mnt_parent = mnt;
Index: linus-2.6.7-bk-latest/fs/exec.c
===================================================================
--- linus-2.6.7-bk-latest.orig/fs/exec.c	2004-07-07 10:56:13.395545976 +0300
+++ linus-2.6.7-bk-latest/fs/exec.c	2004-07-07 11:38:42.869966952 +0300
@@ -121,8 +121,9 @@
 	struct nameidata nd;
 	int error;
 
+	intent_init(&nd.intent.open, IT_OPEN);
 	nd.intent.open.flags = FMODE_READ;
-	error = __user_walk(library, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);
+	error = user_path_walk_it(library, &nd);
 	if (error)
 		goto out;
 
@@ -134,7 +135,7 @@
 	if (error)
 		goto exit;
 
-	file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
+	file = dentry_open_it(nd.dentry, nd.mnt, O_RDONLY, &nd.intent.open);
 	error = PTR_ERR(file);
 	if (IS_ERR(file))
 		goto out;
@@ -474,8 +475,9 @@
 	int err;
 	struct file *file;
 
+	intent_init(&nd.intent.open, IT_OPEN);
 	nd.intent.open.flags = FMODE_READ;
-	err = path_lookup(name, LOOKUP_FOLLOW|LOOKUP_OPEN, &nd);
+	err = path_lookup_it(name, LOOKUP_FOLLOW, &nd);
 	file = ERR_PTR(err);
 
 	if (!err) {
@@ -488,7 +490,7 @@
 				err = -EACCES;
 			file = ERR_PTR(err);
 			if (!err) {
-				file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
+				file = dentry_open_it(nd.dentry, nd.mnt, O_RDONLY, &nd.intent.open);
 				if (!IS_ERR(file)) {
 					err = deny_write_access(file);
 					if (err) {
Index: linus-2.6.7-bk-latest/fs/xattr.c
===================================================================
--- linus-2.6.7-bk-latest.orig/fs/xattr.c	2004-07-07 10:56:13.643508280 +0300
+++ linus-2.6.7-bk-latest/fs/xattr.c	2004-07-07 11:38:42.870966800 +0300
@@ -161,7 +161,8 @@
 	struct nameidata nd;
 	ssize_t error;
 
-	error = user_path_walk(path, &nd);
+	intent_init(&nd.intent.open, IT_GETXATTR);
+	error = user_path_walk_it(path, &nd);
 	if (error)
 		return error;
 	error = getxattr(nd.dentry, name, value, size);
@@ -176,7 +177,8 @@
 	struct nameidata nd;
 	ssize_t error;
 
-	error = user_path_walk_link(path, &nd);
+	intent_init(&nd.intent.open, IT_GETXATTR);
+	error = user_path_walk_link_it(path, &nd);
 	if (error)
 		return error;
 	error = getxattr(nd.dentry, name, value, size);
@@ -242,7 +244,8 @@
 	struct nameidata nd;
 	ssize_t error;
 
-	error = user_path_walk(path, &nd);
+	intent_init(&nd.intent.open, IT_GETXATTR);
+	error = user_path_walk_it(path, &nd);
 	if (error)
 		return error;
 	error = listxattr(nd.dentry, list, size);
@@ -256,7 +259,8 @@
 	struct nameidata nd;
 	ssize_t error;
 
-	error = user_path_walk_link(path, &nd);
+	intent_init(&nd.intent.open, IT_GETXATTR);
+	error = user_path_walk_link_it(path, &nd);
 	if (error)
 		return error;
 	error = listxattr(nd.dentry, list, size);
