Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266053AbUA1Psf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 10:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266054AbUA1PrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 10:47:19 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:9483 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266053AbUA1PlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 10:41:13 -0500
Date: Wed, 28 Jan 2004 23:40:17 +0800 (WST)
From: raven@themaw.net
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [PATCH 5/8] autofs4-2.6 - to support autofs 4.1.x
Message-ID: <Pine.LNX.4.58.0401282325580.17471@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=0.3, required 8,
	NO_REAL_NAME, PATCH_UNIFIED_DIFF, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch:

5-autofs4-2.6.0-test9-readdir.patch

This is the readdir implementation that does the late mount work when
directories already exist in autofs filesystem.

diff -Nur linux-2.6.0-0.test9.waitq2/fs/autofs4/autofs_i.h linux-2.6.0-0.test9.readdir/fs/autofs4/autofs_i.h
--- linux-2.6.0-0.test9.waitq2/fs/autofs4/autofs_i.h	2003-11-30 08:59:54.000000000 +0800
+++ linux-2.6.0-0.test9.readdir/fs/autofs4/autofs_i.h	2003-11-29 17:37:23.000000000 +0800
@@ -96,6 +96,7 @@
 	pid_t oz_pgrp;
 	int catatonic;
 	int version;
+	int sub_version;
 	unsigned long exp_timeout;
 	struct super_block *sb;
 	struct autofs_wait_queue *queues; /* Wait queue pointer */
@@ -128,6 +129,12 @@
 		(inf != NULL && inf->flags & AUTOFS_INF_EXPIRING);
 }
 
+static inline void autofs4_copy_atime(struct file *src, struct file *dst)
+{
+	dst->f_dentry->d_inode->i_atime = src->f_dentry->d_inode->i_atime;
+	return;
+}
+
 struct inode *autofs4_get_inode(struct super_block *, struct autofs_info *);
 struct autofs_info *autofs4_init_inf(struct autofs_sb_info *, mode_t mode);
 void autofs4_free_ino(struct autofs_info *);
@@ -144,6 +151,7 @@
 extern struct inode_operations autofs4_symlink_inode_operations;
 extern struct inode_operations autofs4_dir_inode_operations;
 extern struct inode_operations autofs4_root_inode_operations;
+extern struct file_operations autofs4_dir_operations;
 extern struct file_operations autofs4_root_operations;
 
 /* Initializing function */
@@ -160,7 +168,7 @@
 	NFY_EXPIRE
 };
 
-int autofs4_wait(struct autofs_sb_info *,struct qstr *, enum autofs_notify);
+int autofs4_wait(struct autofs_sb_info *,struct dentry *, enum autofs_notify);
 int autofs4_wait_release(struct autofs_sb_info *,autofs_wqt_t,int);
 void autofs4_catatonic_mode(struct autofs_sb_info *);
 
diff -Nur linux-2.6.0-0.test9.waitq2/fs/autofs4/expire.c linux-2.6.0-0.test9.readdir/fs/autofs4/expire.c
--- linux-2.6.0-0.test9.waitq2/fs/autofs4/expire.c	2003-11-30 08:59:54.000000000 +0800
+++ linux-2.6.0-0.test9.readdir/fs/autofs4/expire.c	2003-11-23 18:41:16.000000000 +0800
@@ -390,7 +390,7 @@
 		/* This is synchronous because it makes the daemon a
                    little easier */
 		de_info->flags |= AUTOFS_INF_EXPIRING;
-		ret = autofs4_wait(sbi, &dentry->d_name, NFY_EXPIRE);
+		ret = autofs4_wait(sbi, dentry, NFY_EXPIRE);
 		de_info->flags &= ~AUTOFS_INF_EXPIRING;
 		dput(dentry);
 	}
diff -Nur linux-2.6.0-0.test9.waitq2/fs/autofs4/inode.c linux-2.6.0-0.test9.readdir/fs/autofs4/inode.c
--- linux-2.6.0-0.test9.waitq2/fs/autofs4/inode.c	2003-11-30 08:59:54.000000000 +0800
+++ linux-2.6.0-0.test9.readdir/fs/autofs4/inode.c	2003-11-23 21:03:38.000000000 +0800
@@ -314,7 +314,7 @@
 	if (S_ISDIR(inf->mode)) {
 		inode->i_nlink = 2;
 		inode->i_op = &autofs4_dir_inode_operations;
-		inode->i_fop = &simple_dir_operations;
+		inode->i_fop = &autofs4_dir_operations;
 	} else if (S_ISLNK(inf->mode)) {
 		inode->i_size = inf->size;
 		inode->i_op = &autofs4_symlink_inode_operations;
diff -Nur linux-2.6.0-0.test9.waitq2/fs/autofs4/root.c linux-2.6.0-0.test9.readdir/fs/autofs4/root.c
--- linux-2.6.0-0.test9.waitq2/fs/autofs4/root.c	2003-11-30 08:59:54.000000000 +0800
+++ linux-2.6.0-0.test9.readdir/fs/autofs4/root.c	2003-11-30 10:16:18.977924576 +0800
@@ -4,6 +4,7 @@
  *
  *  Copyright 1997-1998 Transmeta Corporation -- All Rights Reserved
  *  Copyright 1999-2000 Jeremy Fitzhardinge <jeremy@goop.org>
+ *  Copyright 2001-2003 Ian Kent <raven@themaw.net>
  *
  * This file is part of the Linux kernel and is made available under
  * the terms of the GNU General Public License, version 2, or at your
@@ -24,17 +25,26 @@
 static int autofs4_dir_rmdir(struct inode *,struct dentry *);
 static int autofs4_dir_mkdir(struct inode *,struct dentry *,int);
 static int autofs4_root_ioctl(struct inode *, struct file *,unsigned int,unsigned long);
+static int autofs4_dir_open(struct inode *inode, struct file *file);
+static int autofs4_dir_close(struct inode *inode, struct file *file);
+static int autofs4_dir_readdir(struct file * filp, void * dirent, filldir_t filldir);
 static struct dentry *autofs4_root_lookup(struct inode *,struct dentry *, struct nameidata *);
 
 struct file_operations autofs4_root_operations = {
 	.open		= dcache_dir_open,
 	.release	= dcache_dir_close,
-	.llseek		= dcache_dir_lseek,
 	.read		= generic_read_dir,
 	.readdir	= dcache_readdir,
 	.ioctl		= autofs4_root_ioctl,
 };
 
+struct file_operations autofs4_dir_operations = {
+	.open		= autofs4_dir_open,
+	.release	= autofs4_dir_close,
+	.read		= generic_read_dir,
+	.readdir	= autofs4_dir_readdir,
+};
+
 struct inode_operations autofs4_root_inode_operations = {
 	.lookup		= autofs4_root_lookup,
 	.unlink		= autofs4_dir_unlink,
@@ -67,9 +77,210 @@
 	}
 }
 
+static void autofs4_check_pwd(struct file *file, struct file *fp)
+{
+	struct dentry *pwd = file->f_dentry;
+	struct dentry *new_pwd = fp->f_dentry;
+	struct vfsmount *new_mnt = fp->f_vfsmnt;
+
+	/* dentry is a pwd of mountpoint so move to it */
+	if (current->fs->pwd == pwd)
+		set_fs_pwd(current->fs, new_mnt, new_pwd);
+
+	/* dentry is root of a chrooted mountpoint so move to it */
+	if (current->fs->root == pwd) {
+		set_fs_root(current->fs, new_mnt, new_pwd);
+		/* alternate os ABI not supported  */
+		/* set_fs_altroot(); */
+	}
+}
+
+/*
+ * From 2.4 kernel readdir.c
+ */
+static int autofs4_dcache_readdir(struct file * filp, void * dirent, filldir_t filldir)
+{
+	int i;
+	struct dentry *dentry = filp->f_dentry;
+
+	i = filp->f_pos;
+	switch (i) {
+		case 0:
+			if (filldir(dirent, ".", 1, i, dentry->d_inode->i_ino, DT_DIR) < 0)
+				break;
+			i++;
+			filp->f_pos++;
+			/* fallthrough */
+		case 1:
+			if (filldir(dirent, "..", 2, i, dentry->d_parent->d_inode->i_ino, DT_DIR) < 0)
+				break;
+			i++;
+			filp->f_pos++;
+			/* fallthrough */
+		default: {
+			struct list_head *list;
+			int j = i-2;
+
+			spin_lock(&dcache_lock);
+			list = dentry->d_subdirs.next;
+
+			for (;;) {
+				if (list == &dentry->d_subdirs) {
+					spin_unlock(&dcache_lock);
+					return 0;
+				}
+				if (!j)
+					break;
+				j--;
+				list = list->next;
+			}
+
+			while(1) {
+				struct dentry *de = list_entry(list, struct dentry, d_child);
+
+				if (!d_unhashed(de) && de->d_inode) {
+					spin_unlock(&dcache_lock);
+					if (filldir(dirent, de->d_name.name, de->d_name.len, filp->f_pos, de->d_inode->i_ino, DT_UNKNOWN) < 0)
+						break;
+					spin_lock(&dcache_lock);
+				}
+				filp->f_pos++;
+				list = list->next;
+				if (list != &dentry->d_subdirs)
+					continue;
+				spin_unlock(&dcache_lock);
+				break;
+			}
+		}
+	}
+	return 0;
+}
+
+static int autofs4_dir_open(struct inode *inode, struct file *file)
+{
+	struct dentry *dentry = file->f_dentry;
+	struct vfsmount *mnt = file->f_vfsmnt;
+	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	int status;
+
+	DPRINTK(("autofs4_dir_open: file=%p dentry=%p %.*s\n",
+		file, dentry, dentry->d_name.len, dentry->d_name.name));
+
+	if (autofs4_oz_mode(sbi))
+		goto out;
+
+	if (autofs4_ispending(dentry)) {
+		DPRINTK(("autofs4_dir_open: dentry busy\n"));
+		return -EBUSY;
+	}
+
+	if (!d_mountpoint(dentry) && dentry->d_op && dentry->d_op->d_revalidate) {
+		struct nameidata nd;
+		int empty;
+
+		/* In case there are stale directory dentrys from a failed mount */
+		spin_lock(&dcache_lock);
+		empty = list_empty(&dentry->d_subdirs);
+		spin_unlock(&dcache_lock);
+
+		if (!empty)
+			d_invalidate(dentry);
+
+		nd.flags = LOOKUP_CONTINUE;
+		status = (dentry->d_op->d_revalidate)(dentry, &nd);
+
+		if (!status)
+			return -ENOENT;
+	}
+
+	if (d_mountpoint(dentry)) {
+		struct file *fp = NULL;
+		struct vfsmount *fp_mnt = mntget(mnt);
+		struct dentry *fp_dentry = dget(dentry);
+
+		while (follow_down(&fp_mnt, &fp_dentry) && d_mountpoint(fp_dentry));
+
+		fp = dentry_open(fp_dentry, fp_mnt, file->f_flags);
+		status = PTR_ERR(fp);
+		if (IS_ERR(fp)) {
+			file->private_data = NULL;
+			return status;
+		}
+		autofs4_check_pwd(file, fp);
+		file->private_data = fp;
+	}
+out:
+	return 0;
+}
+
+static int autofs4_dir_close(struct inode *inode, struct file *file)
+{
+	struct dentry *dentry = file->f_dentry;
+	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+
+	DPRINTK(("autofs4_dir_close: file=%p dentry=%p %.*s\n",
+		file, dentry, dentry->d_name.len, dentry->d_name.name));
+
+	if (autofs4_oz_mode(sbi))
+		goto out;
+
+	if (autofs4_ispending(dentry)) {
+		DPRINTK(("autofs4_dir_close: dentry busy\n"));
+		return -EBUSY;
+	}
+
+	if (d_mountpoint(dentry)) {
+		struct file *fp = file->private_data;
+
+		if (!fp)
+			return -ENOENT;
+
+		filp_close(fp, current->files);
+		file->private_data = NULL;
+	}
+out:
+	return 0;
+}
+
+static int autofs4_dir_readdir(struct file *file, void *dirent, filldir_t filldir)
+{
+	struct dentry *dentry = file->f_dentry;
+	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
+	int status;
+
+	DPRINTK(("autofs4_readdir: file=%p dentry=%p %.*s\n",
+		file, dentry, dentry->d_name.len, dentry->d_name.name));
+
+	if (autofs4_oz_mode(sbi))
+		goto out;
+
+	if (autofs4_ispending(dentry)) {
+		DPRINTK(("autofs4_readdir: dentry busy\n"));
+		return -EBUSY;
+	}
+
+	if (d_mountpoint(dentry)) {
+		struct file *fp = file->private_data;
+
+		if (!fp)
+			return -ENOENT;
+
+		if (!fp->f_op || !fp->f_op->readdir)
+			goto out;
+
+		status = vfs_readdir(fp, filldir, dirent);
+		file->f_pos = fp->f_pos;
+		if (status)
+			autofs4_copy_atime(file, fp);
+		return status;
+	}
+out:
+	return autofs4_dcache_readdir(file, dirent, filldir);
+}
+
 static int try_to_fill_dentry(struct dentry *dentry, 
 			      struct super_block *sb,
-			      struct autofs_sb_info *sbi)
+			      struct autofs_sb_info *sbi, int flags)
 {
 	struct autofs_info *de_info = autofs4_dentry_ino(dentry);
 	int status = 0;
@@ -78,11 +289,10 @@
            when expiration is done to trigger mount request with a new
            dentry */
 	if (de_info && (de_info->flags & AUTOFS_INF_EXPIRING)) {
-		DPRINTK(("try_to_fill_entry: waiting for expire %p name=%.*s, flags&PENDING=%s de_info=%p de_info->flags=%x\n",
-			 dentry, dentry->d_name.len, dentry->d_name.name, 
-			 dentry->d_flags & DCACHE_AUTOFS_PENDING?"t":"f",
-			 de_info, de_info?de_info->flags:0));
-		status = autofs4_wait(sbi, &dentry->d_name, NFY_NONE);
+		DPRINTK(("try_to_fill_entry: waiting for expire %p name=%.*s\n",
+			 dentry, dentry->d_name.len, dentry->d_name.name));
+
+		status = autofs4_wait(sbi, dentry, NFY_NONE);
 		
 		DPRINTK(("try_to_fill_entry: expire done status=%d\n", status));
 		
@@ -93,11 +303,11 @@
 		 dentry, dentry->d_name.len, dentry->d_name.name, dentry->d_inode));
 
 	/* Wait for a pending mount, triggering one if there isn't one already */
-	while(dentry->d_inode == NULL) {
-		DPRINTK(("try_to_fill_entry: waiting for mount name=%.*s, de_info=%p de_info->flags=%x\n",
-			 dentry->d_name.len, dentry->d_name.name, 
-			 de_info, de_info?de_info->flags:0));
-		status = autofs4_wait(sbi, &dentry->d_name, NFY_MOUNT);
+	if (dentry->d_inode == NULL) {
+		DPRINTK(("try_to_fill_entry: waiting for mount name=%.*s\n",
+			 dentry->d_name.len, dentry->d_name.name));
+
+		status = autofs4_wait(sbi, dentry, NFY_MOUNT);
 		 
 		DPRINTK(("try_to_fill_entry: mount done status=%d\n", status));
 
@@ -113,19 +323,21 @@
 			/* Return a negative dentry, but leave it "pending" */
 			return 1;
 		}
-	}
+	/* Trigger mount for path component or follow link */
+	} else if (flags & LOOKUP_CONTINUE || current->link_count) {
+		DPRINTK(("try_to_fill_entry: waiting for mount name=%.*s\n",
+			dentry->d_name.len, dentry->d_name.name));
 
-	/* If this is an unused directory that isn't a mount point,
-	   bitch at the daemon and fix it in user space */
-	spin_lock(&dcache_lock);
-	if (S_ISDIR(dentry->d_inode->i_mode) &&
-	    !d_mountpoint(dentry) && 
-	    list_empty(&dentry->d_subdirs)) {
-		DPRINTK(("try_to_fill_entry: mounting existing dir\n"));
-		spin_unlock(&dcache_lock);
-		return autofs4_wait(sbi, &dentry->d_name, NFY_MOUNT) == 0;
+		dentry->d_flags |= DCACHE_AUTOFS_PENDING;
+		status = autofs4_wait(sbi, dentry, NFY_MOUNT);
+
+		DPRINTK(("try_to_fill_entry: mount done status=%d\n", status));
+
+		if (status) {
+			dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
+			return 0;
+		}
 	}
-	spin_unlock(&dcache_lock);
 
 	/* We don't update the usages for the autofs daemon itself, this
 	   is necessary for recursive autofs mounts */
@@ -136,25 +348,24 @@
 	return 1;
 }
 
-
 /*
  * Revalidate is called on every cache lookup.  Some of those
  * cache lookups may actually happen while the dentry is not
  * yet completely filled in, and revalidate has to delay such
  * lookups..
  */
-static int autofs4_root_revalidate(struct dentry * dentry, struct nameidata *nd)
+static int autofs4_revalidate(struct dentry * dentry, struct nameidata *nd)
 {
 	struct inode * dir = dentry->d_parent->d_inode;
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
 	int oz_mode = autofs4_oz_mode(sbi);
+	int status = 1;
 
 	/* Pending dentry */
 	if (autofs4_ispending(dentry)) {
-		if (autofs4_oz_mode(sbi))
-			return 1;
-		else
-			return try_to_fill_dentry(dentry, dir->i_sb, sbi);
+		if (!oz_mode)
+			status = try_to_fill_dentry(dentry, dir->i_sb, sbi, nd->flags);
+		return status;
 	}
 
 	/* Negative dentry.. invalidate if "old" */
@@ -166,13 +377,12 @@
 	if (S_ISDIR(dentry->d_inode->i_mode) &&
 	    !d_mountpoint(dentry) && 
 	    list_empty(&dentry->d_subdirs)) {
-		DPRINTK(("autofs_root_revalidate: dentry=%p %.*s, emptydir\n",
+		DPRINTK(("autofs4_revalidate: dentry=%p %.*s, emptydir\n",
 			 dentry, dentry->d_name.len, dentry->d_name.name));
 		spin_unlock(&dcache_lock);
-		if (oz_mode)
-			return 1;
-		else
-			return try_to_fill_dentry(dentry, dir->i_sb, sbi);
+		if (!oz_mode)
+			status = try_to_fill_dentry(dentry, dir->i_sb, sbi, nd->flags);
+		return status;
 	}
 	spin_unlock(&dcache_lock);
 
@@ -183,16 +393,6 @@
 	return 1;
 }
 
-static int autofs4_revalidate(struct dentry *dentry, struct nameidata *nd)
-{
-	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
-
-	if (!autofs4_oz_mode(sbi))
-		autofs4_update_usage(dentry);
-
-	return 1;
-}
-
 static void autofs4_dentry_release(struct dentry *de)
 {
 	struct autofs_info *inf;
@@ -212,7 +412,7 @@
 
 /* For dentries of directories in the root dir */
 static struct dentry_operations autofs4_root_dentry_operations = {
-	.d_revalidate	= autofs4_root_revalidate,
+	.d_revalidate	= autofs4_revalidate,
 	.d_release	= autofs4_dentry_release,
 };
 
@@ -222,17 +422,117 @@
 	.d_release	= autofs4_dentry_release,
 };
 
-/* Lookups in non-root dirs never find anything - if it's there, it's
-   already in the dcache */
-/* SMP-safe */
+/*
+ * This subroutine is taken straight out of fs/namei.c since we need
+ * to do the lookup again in exaclty the same way.
+ */
+static struct dentry * real_lookup(struct dentry * parent, struct qstr * name, struct nameidata *nd)
+{
+	struct dentry * result;
+	struct inode *dir = parent->d_inode;
+
+	down(&dir->i_sem);
+	result = d_lookup(parent, name);
+	if (!result) {
+		struct dentry * dentry = d_alloc(parent, name);
+		result = ERR_PTR(-ENOMEM);
+		if (dentry) {
+			result = dir->i_op->lookup(dir, dentry, nd);
+			if (result)
+				dput(dentry);
+			else
+				result = dentry;
+		}
+		up(&dir->i_sem);
+		return result;
+	}
+
+	up(&dir->i_sem);
+	if (result->d_op && result->d_op->d_revalidate) {
+		if (!result->d_op->d_revalidate(result, nd) && !d_invalidate(result)) {
+			dput(result);
+			result = ERR_PTR(-ENOENT);
+		}
+	}
+	return result;
+}
+
+static int is_autofs4_mountpoint(struct dentry *parent)
+{
+	struct list_head *tmp;
+
+	DPRINTK(("autofs4_is_mountpoint: parent=%p %.*s\n",
+		parent, parent->d_name.len, parent->d_name.name));
+
+	spin_lock(&dcache_lock);
+	tmp = parent->d_subdirs.next;
+	while ( tmp != &parent->d_subdirs ) {
+		struct dentry * dentry = list_entry(tmp, struct dentry, d_child);
+
+		tmp = tmp->next;
+
+		if (is_autofs4_dentry(dentry) && !d_unhashed(dentry)) {
+			spin_unlock(&dcache_lock);
+			return 0;
+		}
+	}
+	spin_unlock(&dcache_lock);
+	return 1;
+}
+
+/* Lookups in non root directories */
 static struct dentry *autofs4_dir_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
-#if 0
-	DPRINTK(("autofs_dir_lookup: ignoring lookup of %.*s/%.*s\n",
-		 dentry->d_parent->d_name.len, dentry->d_parent->d_name.name,
-		 dentry->d_name.len, dentry->d_name.name));
-#endif
+	struct dentry *parent = dentry->d_parent;
+	struct autofs_sb_info *sbi = autofs4_sbi(parent->d_sb);
+	struct qstr *name = &dentry->d_name;
+	struct vfsmount *mnt = NULL;
+	int status = 0;
+
+	DPRINTK(("autofs4_dir_lookup: lookup of %p %.*s/%.*s\n",
+		dentry->d_parent,
+		dentry->d_parent->d_name.len, dentry->d_parent->d_name.name,
+		dentry->d_name.len, dentry->d_name.name));
+
+	if (autofs4_oz_mode(sbi))
+		goto out;
+
+	if (!is_autofs4_mountpoint(parent))
+		goto out;
+
+	/* If our pwd or root dentry is an autofs4 leaf node
+	 * we need to mount it and redo the lookup */
+	if (!d_mountpoint(parent)) {
+		DPRINTK(("autofs4_dir_lookup: waiting for mount name=%.*s\n",
+			parent->d_name.len, parent->d_name.name));
 
+		up(&dir->i_sem);
+		status = try_to_fill_dentry(parent, dir->i_sb, sbi, LOOKUP_CONTINUE);
+		down(&dir->i_sem);
+
+		DPRINTK(("autofs4_dir_lookup: mount done status=%d\n", status));
+
+		 if ( !status )
+			goto out;
+	}
+
+	read_lock(&current->fs->lock);
+	if (current->fs->pwd == parent )
+		mnt = lookup_mnt(current->fs->pwdmnt, parent);
+	else if (current->fs->root == parent)
+		mnt = lookup_mnt(current->fs->rootmnt, parent);
+	read_unlock(&current->fs->lock);
+
+	if ( !mnt )
+		goto out;
+
+	dput(nd->dentry);
+	mntput(nd->mnt);
+	nd->dentry = dget(mnt->mnt_root);
+	nd->mnt = mnt;
+
+	return real_lookup(mnt->mnt_root, name, nd);
+out:
 	dentry->d_fsdata = NULL;
 	d_add(dentry, NULL);
 	return NULL;
@@ -252,7 +552,6 @@
 
 	sbi = autofs4_sbi(dir->i_sb);
 
-	lock_kernel();
 	oz_mode = autofs4_oz_mode(sbi);
 	DPRINTK(("autofs_lookup: pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d\n",
 		 current->pid, process_group(current), sbi->catatonic, oz_mode));
@@ -290,7 +589,6 @@
 			return ERR_PTR(-ERESTARTNOINTR);
 		}
 	}
-	unlock_kernel();
 
 	/*
 	 * If this dentry is unhashed, then we shouldn't honour this
@@ -316,24 +614,20 @@
 	DPRINTK(("autofs_dir_symlink: %s <- %.*s\n", symname, 
 		 dentry->d_name.len, dentry->d_name.name));
 
-	lock_kernel();
 	if (!autofs4_oz_mode(sbi)) {
 		unlock_kernel();
 		return -EACCES;
 	}
 
 	ino = autofs4_init_ino(ino, sbi, S_IFLNK | 0555);
-	if (ino == NULL) {
-		unlock_kernel();
+	if (ino == NULL)
 		return -ENOSPC;
-	}
 
 	ino->size = strlen(symname);
 	ino->u.symlink = cp = kmalloc(ino->size + 1, GFP_KERNEL);
 
 	if (cp == NULL) {
 		kfree(ino);
-		unlock_kernel();
 		return -ENOSPC;
 	}
 
@@ -353,7 +647,6 @@
 
 	dir->i_mtime = CURRENT_TIME;
 
-	unlock_kernel();
 	return 0;
 }
 
@@ -378,7 +671,6 @@
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	
 	/* This allows root to remove symlinks */
-	lock_kernel();
 	if ( !autofs4_oz_mode(sbi) && !capable(CAP_SYS_ADMIN) ) {
 		unlock_kernel();
 		return -EACCES;
@@ -393,8 +685,6 @@
 
 	d_drop(dentry);
 
-	unlock_kernel();
-	
 	return 0;
 }
 
@@ -403,7 +693,6 @@
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	
-	lock_kernel();
 	if (!autofs4_oz_mode(sbi)) {
 		unlock_kernel();
 		return -EACCES;
@@ -412,7 +701,6 @@
 	spin_lock(&dcache_lock);
 	if (!list_empty(&dentry->d_subdirs)) {
 		spin_unlock(&dcache_lock);
-		unlock_kernel();
 		return -ENOTEMPTY;
 	}
 	__d_drop(dentry);
@@ -426,7 +714,6 @@
 	if (dir->i_nlink)
 		dir->i_nlink--;
 
-	unlock_kernel();
 	return 0;
 }
 
@@ -438,20 +725,15 @@
 	struct autofs_info *ino = autofs4_dentry_ino(dentry);
 	struct inode *inode;
 
-	lock_kernel();
-	if ( !autofs4_oz_mode(sbi) ) {
-		unlock_kernel();
+	if ( !autofs4_oz_mode(sbi) )
 		return -EACCES;
-	}
 
 	DPRINTK(("autofs_dir_mkdir: dentry %p, creating %.*s\n",
 		 dentry, dentry->d_name.len, dentry->d_name.name));
 
 	ino = autofs4_init_ino(ino, sbi, S_IFDIR | 0555);
-	if (ino == NULL) {
-		unlock_kernel();
+	if (ino == NULL)
 		return -ENOSPC;
-	}
 
 	inode = autofs4_get_inode(dir->i_sb, ino);
 	d_instantiate(dentry, inode);
@@ -467,10 +749,21 @@
 	dir->i_nlink++;
 	dir->i_mtime = CURRENT_TIME;
 
-	unlock_kernel();
 	return 0;
 }
 
+/* Identify autofs_dentries - this is so we can tell if there's
+   an extra dentry refcount or not.  We only hold a refcount on the
+   dentry if its non-negative (ie, d_inode != NULL)
+*/
+int is_autofs4_dentry(struct dentry *dentry)
+{
+	return dentry && dentry->d_inode &&
+		(dentry->d_op == &autofs4_root_dentry_operations ||
+		 dentry->d_op == &autofs4_dentry_operations) &&
+		dentry->d_fsdata != NULL;
+}
+
 /* Get/set timeout ioctl() operation */
 static inline int autofs4_get_set_timeout(struct autofs_sb_info *sbi,
 					 unsigned long *p)
@@ -496,16 +789,10 @@
 	return put_user(sbi->version, p);
 }
 
-/* Identify autofs_dentries - this is so we can tell if there's
-   an extra dentry refcount or not.  We only hold a refcount on the
-   dentry if its non-negative (ie, d_inode != NULL)
-*/
-int is_autofs4_dentry(struct dentry *dentry)
+/* Return protocol sub version */
+static inline int autofs4_get_protosubver(struct autofs_sb_info *sbi, int *p)
 {
-	return dentry && dentry->d_inode &&
-		(dentry->d_op == &autofs4_root_dentry_operations ||
-		 dentry->d_op == &autofs4_dentry_operations) &&
-		dentry->d_fsdata != NULL;
+	return put_user(sbi->sub_version, p);
 }
 
 /*
@@ -537,6 +824,8 @@
 		return 0;
 	case AUTOFS_IOC_PROTOVER: /* Get protocol version */
 		return autofs4_get_protover(sbi, (int *)arg);
+	case AUTOFS_IOC_PROTOSUBVER: /* Get protocol sub version */
+		return autofs4_get_protover(sbi, (int *)arg);
 	case AUTOFS_IOC_SETTIMEOUT:
 		return autofs4_get_set_timeout(sbi,(unsigned long *)arg);
 
diff -Nur linux-2.6.0-0.test9.waitq2/fs/autofs4/waitq.c linux-2.6.0-0.test9.readdir/fs/autofs4/waitq.c
--- linux-2.6.0-0.test9.waitq2/fs/autofs4/waitq.c	2003-11-30 09:07:29.000000000 +0800
+++ linux-2.6.0-0.test9.readdir/fs/autofs4/waitq.c	2003-11-30 10:16:29.756286016 +0800
@@ -3,6 +3,7 @@
  * linux/fs/autofs/waitq.c
  *
  *  Copyright 1997-1998 Transmeta Corporation -- All Rights Reserved
+ *  Copyright 2001-2003 Ian Kent <raven@themaw.net>
  *
  * This file is part of the Linux kernel and is made available under
  * the terms of the GNU General Public License, version 2, or at your
@@ -126,25 +127,64 @@
 		autofs4_catatonic_mode(sbi);
 }
 
-int autofs4_wait(struct autofs_sb_info *sbi, struct qstr *name,
+static int autofs4_getpath(struct autofs_sb_info *sbi,
+			   struct dentry *dentry, char **name)
+{
+	struct dentry *root = sbi->sb->s_root;
+	struct dentry *tmp;
+	char *buf = *name;
+	char *p;
+	int len = 0;
+
+	spin_lock(&dcache_lock);
+	for (tmp = dentry ; tmp != root ; tmp = tmp->d_parent)
+		len += tmp->d_name.len + 1;
+
+	if (--len > NAME_MAX) {
+		spin_unlock(&dcache_lock);
+		return 0;
+	}
+
+	*(buf + len) = '\0';
+	p = buf + len - dentry->d_name.len;
+	strncpy(p, dentry->d_name.name, dentry->d_name.len);
+
+	for (tmp = dentry->d_parent; tmp != root ; tmp = tmp->d_parent) {
+		*(--p) = '/';
+		p -= tmp->d_name.len;
+		strncpy(p, tmp->d_name.name, tmp->d_name.len);
+	}
+	spin_unlock(&dcache_lock);
+
+	return len;
+}
+
+int autofs4_wait(struct autofs_sb_info *sbi, struct dentry *dentry,
 		enum autofs_notify notify)
 {
 	struct autofs_wait_queue *wq;
-	int status;
+	char *name;
+	int len, status;
 
 	/* In catatonic mode, we don't wait for nobody */
 	if ( sbi->catatonic )
 		return -ENOENT;
 	
-	/* We shouldn't be able to get here, but just in case */
-	if ( name->len > NAME_MAX )
+	name = kmalloc(NAME_MAX + 1, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	len = autofs4_getpath(sbi, dentry, &name);
+	if (!len) {
+		kfree(name);
 		return -ENOENT;
+	}
 
 	spin_lock(&waitq_lock);
-	for ( wq = sbi->queues ; wq ; wq = wq->next ) {
-		if ( wq->hash == name->hash &&
-		     wq->len == name->len &&
-		     wq->name && !memcmp(wq->name,name->name,name->len) )
+	for (wq = sbi->queues ; wq ; wq = wq->next) {
+		if (wq->hash == dentry->d_name.hash &&
+		    wq->len == len &&
+		    wq->name && !memcmp(wq->name, name, len))
 			break;
 	}
 	spin_unlock(&waitq_lock);
@@ -152,22 +192,20 @@
 	if ( !wq ) {
 		/* Create a new wait queue */
 		wq = kmalloc(sizeof(struct autofs_wait_queue),GFP_KERNEL);
-		if ( !wq )
-			return -ENOMEM;
-
-		wq->name = kmalloc(name->len,GFP_KERNEL);
-		if ( !wq->name ) {
-			kfree(wq);
+		if ( !wq ) {
+			kfree(name);
 			return -ENOMEM;
 		}
+
 		wq->wait_queue_token = autofs4_next_wait_queue;
 		if (++autofs4_next_wait_queue == 0)
 			autofs4_next_wait_queue = 1;
 		init_waitqueue_head(&wq->queue);
-		wq->hash = name->hash;
-		wq->len = name->len;
+		wq->owner = current;
+		wq->hash = dentry->d_name.hash;
+		wq->name = name;
+		wq->len = len;
 		wq->status = -EINTR; /* Status return if interrupted */
-		memcpy(wq->name, name->name, name->len);
 		spin_lock(&waitq_lock);
 		wq->next = sbi->queues;
 		sbi->queues = wq;
@@ -179,8 +217,9 @@
 		wq->wait_ctr = 2;
 		if (notify != NFY_NONE) {
 			autofs4_notify_daemon(sbi,wq, 
-					      notify == NFY_MOUNT ? autofs_ptype_missing :
-								    autofs_ptype_expire_multi);
+				      notify == NFY_MOUNT ?
+						autofs_ptype_missing :
+						autofs_ptype_expire_multi);
 		}
 	} else {
 		wq->wait_ctr++;
diff -Nur linux-2.6.0-0.test9.waitq2/include/linux/auto_fs4.h linux-2.6.0-0.test9.readdir/include/linux/auto_fs4.h
--- linux-2.6.0-0.test9.waitq2/include/linux/auto_fs4.h	2003-11-30 08:59:54.000000000 +0800
+++ linux-2.6.0-0.test9.readdir/include/linux/auto_fs4.h	2003-11-23 18:24:20.000000000 +0800
@@ -23,6 +23,8 @@
 #define AUTOFS_MIN_PROTO_VERSION	3
 #define AUTOFS_MAX_PROTO_VERSION	4
 
+#define AUTOFS_PROTO_SUBVERSION         4
+
 /* Mask for expire behaviour */
 #define AUTOFS_EXP_IMMEDIATE		1
 #define AUTOFS_EXP_LEAVES		2
@@ -46,6 +48,7 @@
 };
 
 #define AUTOFS_IOC_EXPIRE_MULTI _IOW(0x93,0x66,int)
+#define AUTOFS_IOC_PROTOSUBVER  _IOR(0x93,0x67,int)
 
 
 #endif /* _LINUX_AUTO_FS4_H */
