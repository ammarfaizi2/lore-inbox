Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVBSSGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVBSSGl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 13:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVBSSGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 13:06:40 -0500
Received: from [83.102.214.158] ([83.102.214.158]:54988 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S261759AbVBSSFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 13:05:49 -0500
X-Comment-To: Alex Tomas
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       alex@clusterfs.com
Subject: Re: [RFC] pdirops: vfs patch
References: <m34qg84em2.fsf@bzzz.home.net>
From: Alex Tomas <alex@clusterfs.com>
Organization: ClusterFS Inc.
Date: Sat, 19 Feb 2005 21:04:18 +0300
In-Reply-To: <m34qg84em2.fsf@bzzz.home.net> (Alex Tomas's message of "Sat,
 19 Feb 2005 20:57:25 +0300")
Message-ID: <m3zmy02zq5.fsf@bzzz.home.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 fs/inode.c         |    1 
 fs/namei.c         |   66 ++++++++++++++++++++++++++++++++++++++---------------
 include/linux/fs.h |   11 ++++----
 3 files changed, 54 insertions(+), 24 deletions(-)

Index: linux-2.6.10/fs/namei.c
===================================================================
--- linux-2.6.10.orig/fs/namei.c	2005-01-28 19:32:13.000000000 +0300
+++ linux-2.6.10/fs/namei.c	2005-02-19 20:40:05.763437304 +0300
@@ -104,6 +104,28 @@
  * any extra contention...
  */
 
+static inline struct semaphore * lock_sem(struct inode *dir, struct qstr *name)
+{
+	if (IS_PDIROPS(dir)) {
+		struct super_block *sb;
+		/* name->hash expected to be already calculated */
+		sb = dir->i_sb;
+		BUG_ON(sb->s_pdirops_sems == NULL);
+		return sb->s_pdirops_sems + name->hash % sb->s_pdirops_size;
+	}
+	return &dir->i_sem;
+}
+
+static inline void lock_dir(struct inode *dir, struct qstr *name)
+{
+	down(lock_sem(dir, name));
+}
+
+static inline void unlock_dir(struct inode *dir, struct qstr *name)
+{
+	up(lock_sem(dir, name));
+}
+
 /* In order to reduce some races, while at the same time doing additional
  * checking and hopefully speeding things up, we copy filenames to the
  * kernel data space before using them..
@@ -380,7 +402,7 @@
 	struct dentry * result;
 	struct inode *dir = parent->d_inode;
 
-	down(&dir->i_sem);
+	lock_dir(dir, name);
 	/*
 	 * First re-do the cached lookup just in case it was created
 	 * while we waited for the directory semaphore..
@@ -406,7 +428,7 @@
 			else
 				result = dentry;
 		}
-		up(&dir->i_sem);
+		unlock_dir(dir, name);
 		return result;
 	}
 
@@ -414,7 +436,7 @@
 	 * Uhhuh! Nasty case: the cache was re-populated while
 	 * we waited on the semaphore. Need to revalidate.
 	 */
-	up(&dir->i_sem);
+	unlock_dir(dir, name);
 	if (result->d_op && result->d_op->d_revalidate) {
 		if (!result->d_op->d_revalidate(result, nd) && !d_invalidate(result)) {
 			dput(result);
@@ -1182,12 +1204,26 @@
 /*
  * p1 and p2 should be directories on the same fs.
  */
-struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
+struct dentry *lock_rename(struct dentry *p1, struct qstr *n1,
+				struct dentry *p2, struct qstr *n2)
 {
 	struct dentry *p;
 
 	if (p1 == p2) {
-		down(&p1->d_inode->i_sem);
+		if (IS_PDIROPS(p1->d_inode)) {
+			unsigned int h1, h2;
+			h1 = n1->hash % p1->d_inode->i_sb->s_pdirops_size;
+			h2 = n2->hash % p2->d_inode->i_sb->s_pdirops_size;
+			if (h1 < h2) {
+				lock_dir(p1->d_inode, n1);
+				lock_dir(p2->d_inode, n2);
+			} else if (h1 > h2) {
+				lock_dir(p2->d_inode, n2);
+				lock_dir(p1->d_inode, n1);
+			} else
+				lock_dir(p1->d_inode, n1);
+		} else
+			down(&p1->d_inode->i_sem);
 		return NULL;
 	}
 
@@ -1195,31 +1231,35 @@
 
 	for (p = p1; p->d_parent != p; p = p->d_parent) {
 		if (p->d_parent == p2) {
-			down(&p2->d_inode->i_sem);
-			down(&p1->d_inode->i_sem);
+			lock_dir(p2->d_inode, n2);
+			lock_dir(p1->d_inode, n1);
 			return p;
 		}
 	}
 
 	for (p = p2; p->d_parent != p; p = p->d_parent) {
 		if (p->d_parent == p1) {
-			down(&p1->d_inode->i_sem);
-			down(&p2->d_inode->i_sem);
+			lock_dir(p1->d_inode, n1);
+			lock_dir(p2->d_inode, n2);
 			return p;
 		}
 	}
 
-	down(&p1->d_inode->i_sem);
-	down(&p2->d_inode->i_sem);
+	lock_dir(p1->d_inode, n1);
+	lock_dir(p2->d_inode, n2);
 	return NULL;
 }
 
-void unlock_rename(struct dentry *p1, struct dentry *p2)
+void unlock_rename(struct dentry *p1, struct qstr *n1,
+			struct dentry *p2, struct qstr *n2)
 {
-	up(&p1->d_inode->i_sem);
+	unlock_dir(p1->d_inode, n1);
 	if (p1 != p2) {
-		up(&p2->d_inode->i_sem);
+		unlock_dir(p2->d_inode, n2);
 		up(&p1->d_inode->i_sb->s_vfs_rename_sem);
+	} else if (IS_PDIROPS(p1->d_inode) && 
+			n1->hash != n2->hash) {
+		unlock_dir(p2->d_inode, n2);
 	}
 }
 
@@ -1386,13 +1426,13 @@
 
 	dir = nd->dentry;
 	nd->flags &= ~LOOKUP_PARENT;
-	down(&dir->d_inode->i_sem);
+	lock_dir(dir->d_inode, &nd->last);
 	dentry = __lookup_hash(&nd->last, nd->dentry, nd);
 
 do_last:
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry)) {
-		up(&dir->d_inode->i_sem);
+		unlock_dir(dir->d_inode, &nd->last);
 		goto exit;
 	}
 
@@ -1401,7 +1441,7 @@
 		if (!IS_POSIXACL(dir->d_inode))
 			mode &= ~current->fs->umask;
 		error = vfs_create(dir->d_inode, dentry, mode, nd);
-		up(&dir->d_inode->i_sem);
+		unlock_dir(dir->d_inode, &nd->last);		
 		dput(nd->dentry);
 		nd->dentry = dentry;
 		if (error)
@@ -1415,7 +1455,7 @@
 	/*
 	 * It already exists.
 	 */
-	up(&dir->d_inode->i_sem);
+	unlock_dir(dir->d_inode, &nd->last);
 
 	error = -EEXIST;
 	if (flag & O_EXCL)
@@ -1499,7 +1539,7 @@
 		goto exit;
 	}
 	dir = nd->dentry;
-	down(&dir->d_inode->i_sem);
+	lock_dir(dir->d_inode, &nd->last);
 	dentry = __lookup_hash(&nd->last, nd->dentry, nd);
 	putname(nd->last.name);
 	goto do_last;
@@ -1517,7 +1557,7 @@
 {
 	struct dentry *dentry;
 
-	down(&nd->dentry->d_inode->i_sem);
+	lock_dir(nd->dentry->d_inode, &nd->last);
 	dentry = ERR_PTR(-EEXIST);
 	if (nd->last_type != LAST_NORM)
 		goto fail;
@@ -1602,7 +1642,7 @@
 		}
 		dput(dentry);
 	}
-	up(&nd.dentry->d_inode->i_sem);
+	unlock_dir(nd.dentry->d_inode, &nd.last);
 	path_release(&nd);
 out:
 	putname(tmp);
@@ -1656,7 +1696,7 @@
 			error = vfs_mkdir(nd.dentry->d_inode, dentry, mode);
 			dput(dentry);
 		}
-		up(&nd.dentry->d_inode->i_sem);
+		unlock_dir(nd.dentry->d_inode, &nd.last);
 		path_release(&nd);
 out:
 		putname(tmp);
@@ -1757,14 +1797,14 @@
 			error = -EBUSY;
 			goto exit1;
 	}
-	down(&nd.dentry->d_inode->i_sem);
+	lock_dir(nd.dentry->d_inode, &nd.last);
 	dentry = lookup_hash(&nd.last, nd.dentry);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 		error = vfs_rmdir(nd.dentry->d_inode, dentry);
 		dput(dentry);
 	}
-	up(&nd.dentry->d_inode->i_sem);
+	unlock_dir(nd.dentry->d_inode, &nd.last);
 exit1:
 	path_release(&nd);
 exit:
@@ -1826,7 +1866,7 @@
 	error = -EISDIR;
 	if (nd.last_type != LAST_NORM)
 		goto exit1;
-	down(&nd.dentry->d_inode->i_sem);
+	lock_dir(nd.dentry->d_inode, &nd.last);
 	dentry = lookup_hash(&nd.last, nd.dentry);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
@@ -1840,7 +1880,7 @@
 	exit2:
 		dput(dentry);
 	}
-	up(&nd.dentry->d_inode->i_sem);
+	unlock_dir(nd.dentry->d_inode, &nd.last);
 	if (inode)
 		iput(inode);	/* truncate the inode here */
 exit1:
@@ -1902,7 +1942,7 @@
 			error = vfs_symlink(nd.dentry->d_inode, dentry, from, S_IALLUGO);
 			dput(dentry);
 		}
-		up(&nd.dentry->d_inode->i_sem);
+		unlock_dir(nd.dentry->d_inode, &nd.last);
 		path_release(&nd);
 out:
 		putname(to);
@@ -1986,7 +2026,7 @@
 		error = vfs_link(old_nd.dentry, nd.dentry->d_inode, new_dentry);
 		dput(new_dentry);
 	}
-	up(&nd.dentry->d_inode->i_sem);
+	unlock_dir(nd.dentry->d_inode, &nd.last);
 out_release:
 	path_release(&nd);
 out:
@@ -2174,7 +2214,7 @@
 	if (newnd.last_type != LAST_NORM)
 		goto exit2;
 
-	trap = lock_rename(new_dir, old_dir);
+	trap = lock_rename(new_dir, &newnd.last, old_dir, &oldnd.last);
 
 	old_dentry = lookup_hash(&oldnd.last, old_dir);
 	error = PTR_ERR(old_dentry);
@@ -2212,7 +2252,7 @@
 exit4:
 	dput(old_dentry);
 exit3:
-	unlock_rename(new_dir, old_dir);
+	unlock_rename(new_dir, &newnd.last, old_dir, &oldnd.last);
 exit2:
 	path_release(&newnd);
 exit1:
Index: linux-2.6.10/fs/super.c
===================================================================
--- linux-2.6.10.orig/fs/super.c	2005-01-28 19:32:13.000000000 +0300
+++ linux-2.6.10/fs/super.c	2005-02-19 18:11:50.000000000 +0300
@@ -172,6 +172,10 @@
 		down_write(&s->s_umount);
 		fs->kill_sb(s);
 		put_filesystem(fs);
+		if (s->s_flags & S_PDIROPS) {
+			BUG_ON(s->s_pdirops_sems == NULL);
+			kfree(s->s_pdirops_sems);
+		}
 		put_super(s);
 	}
 }
@@ -791,6 +795,22 @@
 
 EXPORT_SYMBOL(get_sb_single);
 
+static int init_pdirops_sems(struct super_block *sb)
+{
+	int i;
+
+	/* XXX: should be memsize dependent? -bzzz */
+	sb->s_pdirops_size = 1024;
+	
+	sb->s_pdirops_sems = kmalloc(sizeof(struct semaphore) *
+					sb->s_pdirops_size, GFP_KERNEL);
+	if (sb->s_pdirops_sems == NULL)
+		return -ENOMEM;
+	for (i = 0; i < sb->s_pdirops_size; i++)
+		sema_init(&sb->s_pdirops_sems[i], 1);
+	return 0;
+}
+
 struct vfsmount *
 do_kern_mount(const char *fstype, int flags, const char *name, void *data)
 {
@@ -827,6 +847,11 @@
  	error = security_sb_kern_mount(sb, secdata);
  	if (error)
  		goto out_sb;
+	if (sb->s_flags & S_PDIROPS) {
+		error = init_pdirops_sems(sb);
+		if (error)
+			goto out_sb;
+	}
 	mnt->mnt_sb = sb;
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = sb->s_root;
Index: linux-2.6.10/include/linux/fs.h
===================================================================
--- linux-2.6.10.orig/include/linux/fs.h	2005-01-28 19:32:15.000000000 +0300
+++ linux-2.6.10/include/linux/fs.h	2005-02-19 18:11:50.000000000 +0300
@@ -150,6 +150,7 @@
 #define S_DIRSYNC	64	/* Directory modifications are synchronous */
 #define S_NOCMTIME	128	/* Do not update file c/mtime */
 #define S_SWAPFILE	256	/* Do not truncate: swapon got its bmaps */
+#define S_PDIROPS	512	/* Parallel directory operations */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -180,6 +181,7 @@
 #define IS_NODIRATIME(inode)	__IS_FLG(inode, MS_NODIRATIME)
 #define IS_POSIXACL(inode)	__IS_FLG(inode, MS_POSIXACL)
 #define IS_ONE_SECOND(inode)	__IS_FLG(inode, MS_ONE_SECOND)
+#define IS_PDIROPS(inode)	__IS_FLG(inode, S_PDIROPS)
 
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
 #define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)
@@ -797,6 +799,8 @@
 	 * even looking at it. You had been warned.
 	 */
 	struct semaphore s_vfs_rename_sem;	/* Kludge */
+	struct semaphore 	*s_pdirops_sems;
+	int			s_pdirops_size;
 };
 
 /*
Index: linux-2.6.10/include/linux/namei.h
===================================================================
--- linux-2.6.10.orig/include/linux/namei.h	2005-01-28 19:29:50.000000000 +0300
+++ linux-2.6.10/include/linux/namei.h	2005-02-19 19:59:19.291357592 +0300
@@ -69,8 +69,10 @@
 extern int follow_down(struct vfsmount **, struct dentry **);
 extern int follow_up(struct vfsmount **, struct dentry **);
 
-extern struct dentry *lock_rename(struct dentry *, struct dentry *);
-extern void unlock_rename(struct dentry *, struct dentry *);
+extern struct dentry *lock_rename(struct dentry *, struct qstr *,
+				struct dentry *, struct qstr *);
+extern void unlock_rename(struct dentry *, struct qstr *,
+			struct dentry *, struct qstr *);
 
 static inline void nd_set_link(struct nameidata *nd, char *path)
 {

