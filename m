Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314727AbSECRXq>; Fri, 3 May 2002 13:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314801AbSECRXp>; Fri, 3 May 2002 13:23:45 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:14862 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S314727AbSECRXm>; Fri, 3 May 2002 13:23:42 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Paul Menage <pmenage@ensim.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace exec_permission_lite() with inlined vfs_permission() 
In-Reply-To: Your message of "Fri, 03 May 2002 05:09:53 EDT."
             <Pine.GSO.4.21.0205030504490.18432-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 10:23:27 -0700
Message-Id: <E173gmF-0005eC-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Argument-dependent locking rules are Wrong. 

Fair enough. 

>In any case, what does it
>buy you compared to extra method? 

It avoids a proliferation of methods; but that's probably a less strong 
issue than your aim of avoiding argument-dependent locking.

>Moreover, the thing you had proposed
>for procfs means that we'll need to check the argument and grab dcache_lock
>if it's 0.  Plus similar fun with unlocking.
>

That's one place where having the locking rules determined by a
parameter actually simplifies the code quite nicely, even if it is Wrong
... Although having said that, I've just spotted a potential deadlock
between task_lock() and dcache_lock. As far as I can see, nowhere
currently holds both at once, but I don't think there's an ordering
defined. It should be safe if we require the alloc_lock of any process to
be nested inside dcache_lock if they're both taken.

Here's a patch (below) with hopefully more tasteful locking rules, and
multiple methods:

- i_op->permission() is unchanged from 2.5.13

- i_op->permission_locked() should return -EAGAIN if it can't complete safely

- NFS permission_locked() returns -EAGAIN if it would have to do an rpc

- proc permission_locked() returns -EAGAIN if the target process and
current process have different roots, without checking for containment.
This could be fairly easily avoided by holding the alloc_lock() on the
target process for the whole traversal, if desired.

Is something like this more acceptable? It actually struck me how few
fs-specific directory permission() methods there were in the tree -
almost all directories leave it NULL and let vfs_permission() do the
work. The only common place where this patch is potentially going to
make a noticeable difference is the case of a non-root user accessing
NFS. I'm not sure whether this is going to outweigh the cost of having
to check two mostly-NULL methods instead of one, compared to just
inlining vfs_permission().

BTW, exit_namespace() reads p->namespace outside of the alloc_lock.
While this isn't really a problem, as no-one calls exit_namespace() on
something other than current or a failed fork(), it looks like a
theoretical race.


diff -X /mnt/elbrus/home/pmenage/dontdiff -aur linux-2.5.13/Documentation/filesystems/Locking linux-2.5.13-permission2/Documentation/filesystems/Locking
--- linux-2.5.13/Documentation/filesystems/Locking	Thu May  2 17:22:48 2002
+++ linux-2.5.13-permission2/Documentation/filesystems/Locking	Fri May  3 02:28:27 2002
@@ -42,6 +42,7 @@
 	int (*follow_link) (struct dentry *, struct nameidata *);
 	void (*truncate) (struct inode *);
 	int (*permission) (struct inode *, int);
+	int (*permission_locked) (struct inode *, int);
 	int (*revalidate) (struct dentry *);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct dentry *, struct iattr *);
@@ -67,6 +68,7 @@
 truncate:	no	yes		(see below)
 setattr:	no	yes
 permission:	yes	no
+permission_locked: no	no		(see below)
 getattr:				(see below)
 revalidate:	no			(see below)
 setxattr:	no	yes
@@ -76,6 +78,7 @@
 	Additionally, ->rmdir(), ->unlink() and ->rename() have ->i_sem on
 victim.
 	cross-directory ->rename() has (per-superblock) ->s_vfs_rename_sem.
+	->permission_locked() has dcache_lock
 	->revalidate(), it may be called both with and without the i_sem
 on dentry->d_inode.
 	->truncate() is never called directly - it's a callback, not a
diff -X /mnt/elbrus/home/pmenage/dontdiff -aur linux-2.5.13/Documentation/filesystems/vfs.txt linux-2.5.13-permission2/Documentation/filesystems/vfs.txt
--- linux-2.5.13/Documentation/filesystems/vfs.txt	Thu May  2 17:22:42 2002
+++ linux-2.5.13-permission2/Documentation/filesystems/vfs.txt	Fri May  3 02:27:10 2002
@@ -254,6 +254,7 @@
 	int (*bmap) (struct inode *,int);
 	void (*truncate) (struct inode *);
 	int (*permission) (struct inode *, int);
+	int (*permission_locked) (struct inode *, int);
 	int (*smap) (struct inode *,int);
 	int (*updatepage) (struct file *, struct page *, const char *,
 				unsigned long, unsigned int, int);
diff -X /mnt/elbrus/home/pmenage/dontdiff -aur linux-2.5.13/fs/bad_inode.c linux-2.5.13-permission2/fs/bad_inode.c
--- linux-2.5.13/fs/bad_inode.c	Thu May  2 17:22:44 2002
+++ linux-2.5.13-permission2/fs/bad_inode.c	Fri May  3 02:26:15 2002
@@ -47,20 +47,21 @@
 
 struct inode_operations bad_inode_ops =
 {
-	create:		EIO_ERROR,
-	lookup:		EIO_ERROR,
-	link:		EIO_ERROR,
-	unlink:		EIO_ERROR,
-	symlink:	EIO_ERROR,
-	mkdir:		EIO_ERROR,
-	rmdir:		EIO_ERROR,
-	mknod:		EIO_ERROR,
-	rename:		EIO_ERROR,
-	readlink:	EIO_ERROR,
-	follow_link:	bad_follow_link,
-	truncate:	EIO_ERROR,
-	permission:	EIO_ERROR,
-	revalidate:	EIO_ERROR,
+	create:			EIO_ERROR,
+	lookup:			EIO_ERROR,
+	link:			EIO_ERROR,
+	unlink:			EIO_ERROR,
+	symlink:		EIO_ERROR,
+	mkdir:			EIO_ERROR,
+	rmdir:			EIO_ERROR,
+	mknod:			EIO_ERROR,
+	rename:			EIO_ERROR,
+	readlink:		EIO_ERROR,
+	follow_link:		bad_follow_link,
+	truncate:		EIO_ERROR,
+	permission:		EIO_ERROR,
+	permission_locked:	EIO_ERROR,
+	revalidate:		EIO_ERROR,
 };
 
 
diff -X /mnt/elbrus/home/pmenage/dontdiff -aur linux-2.5.13/fs/namei.c linux-2.5.13-permission2/fs/namei.c
--- linux-2.5.13/fs/namei.c	Thu May  2 18:57:38 2002
+++ linux-2.5.13-permission2/fs/namei.c	Fri May  3 03:19:36 2002
@@ -153,7 +153,7 @@
  * for filesystem access without changing the "normal" uids which
  * are used for other things..
  */
-int vfs_permission(struct inode * inode, int mask)
+inline int vfs_permission(struct inode * inode, int mask)
 {
 	umode_t			mode = inode->i_mode;
 
@@ -201,6 +201,26 @@
 	return -EACCES;
 }
 
+static inline int permission_locked(struct inode *inode, int mask) {
+
+	struct inode_operations *i_op = inode->i_op;
+	
+	if(i_op) {
+		if(i_op->permission_locked) {
+			return i_op->permission_locked(inode, mask);
+		} else {
+			/* 
+			 * If we have permission() and no
+			 * permission_locked(), we have to take the
+			 * slow path 
+			 */
+			if(i_op->permission)
+				return -EAGAIN;
+		}
+	}
+	return vfs_permission(inode, mask);
+}
+
 int permission(struct inode * inode,int mask)
 {
 	if (inode->i_op && inode->i_op->permission) {
@@ -300,40 +320,6 @@
 }
 
 /*
- * Short-cut version of permission(), for calling by
- * path_walk(), when dcache lock is held.  Combines parts
- * of permission() and vfs_permission(), and tests ONLY for
- * MAY_EXEC permission.
- *
- * If appropriate, check DAC only.  If not appropriate, or
- * short-cut DAC fails, then call permission() to do more
- * complete permission check.
- */
-static inline int exec_permission_lite(struct inode *inode)
-{
-	umode_t	mode = inode->i_mode;
-
-	if ((inode->i_op && inode->i_op->permission))
-		return -EAGAIN;
-
-	if (current->fsuid == inode->i_uid)
-		mode >>= 6;
-	else if (in_group_p(inode->i_gid))
-		mode >>= 3;
-
-	if (mode & MAY_EXEC)
-		return 0;
-
-	if ((inode->i_mode & S_IXUGO) && capable(CAP_DAC_OVERRIDE))
-		return 0;
-
-	if (S_ISDIR(inode->i_mode) && capable(CAP_DAC_READ_SEARCH))
-		return 0;
-
-	return -EACCES;
-}
-
-/*
  * This is called when everything else fails, and we actually have
  * to go to the low-level filesystem to find out what we should do..
  *
@@ -578,7 +564,7 @@
 		struct qstr this;
 		unsigned int c;
 
-		err = exec_permission_lite(inode);
+		err = permission_locked(inode, MAY_EXEC);
 		if (err == -EAGAIN) {
 			unlock_nd(nd);
 			err = permission(inode, MAY_EXEC);
diff -X /mnt/elbrus/home/pmenage/dontdiff -aur linux-2.5.13/fs/nfs/dir.c linux-2.5.13-permission2/fs/nfs/dir.c
--- linux-2.5.13/fs/nfs/dir.c	Thu May  2 17:22:53 2002
+++ linux-2.5.13-permission2/fs/nfs/dir.c	Fri May  3 02:35:29 2002
@@ -54,18 +54,19 @@
 };
 
 struct inode_operations nfs_dir_inode_operations = {
-	create:		nfs_create,
-	lookup:		nfs_lookup,
-	link:		nfs_link,
-	unlink:		nfs_unlink,
-	symlink:	nfs_symlink,
-	mkdir:		nfs_mkdir,
-	rmdir:		nfs_rmdir,
-	mknod:		nfs_mknod,
-	rename:		nfs_rename,
-	permission:	nfs_permission,
-	revalidate:	nfs_revalidate,
-	setattr:	nfs_notify_change,
+	create:			nfs_create,
+	lookup:			nfs_lookup,
+	link:			nfs_link,
+	unlink:			nfs_unlink,
+	symlink:		nfs_symlink,
+	mkdir:			nfs_mkdir,
+	rmdir:			nfs_rmdir,
+	mknod:			nfs_mknod,
+	rename:			nfs_rename,
+	permission:		nfs_permission,
+	permission_locked:	nfs_permission_locked,
+	revalidate:		nfs_revalidate,
+	setattr:		nfs_notify_change,
 };
 
 typedef u32 * (*decode_dirent_t)(u32 *, struct nfs_entry *, int);
@@ -1099,8 +1100,7 @@
 	return error;
 }
 
-int
-nfs_permission(struct inode *inode, int mask)
+int nfs_permission_locked(struct inode *inode, int mask) 
 {
 	int			error = vfs_permission(inode, mask);
 
@@ -1120,9 +1120,22 @@
 	    && (current->fsuid != 0) && (current->fsgid != 0)
 	    && error != -EACCES)
 		goto out;
+	
+	error = -EAGAIN;
 
-	error = NFS_PROTO(inode)->access(inode, mask, 0);
+ out:
+	return error;
+}
 
+int nfs_permission(struct inode *inode, int mask) 
+{
+	int error = nfs_permission_locked(inode, mask);
+
+	if(error != -EAGAIN) 
+		goto out;
+
+	error = NFS_PROTO(inode)->access(inode, mask, 0);
+	
 	if (error == -EACCES && NFS_CLIENT(inode)->cl_droppriv &&
 	    current->uid != 0 && current->gid != 0 &&
 	    (current->fsuid != current->uid || current->fsgid != current->gid))
diff -X /mnt/elbrus/home/pmenage/dontdiff -aur linux-2.5.13/fs/proc/base.c linux-2.5.13-permission2/fs/proc/base.c
--- linux-2.5.13/fs/proc/base.c	Thu May  2 17:22:40 2002
+++ linux-2.5.13-permission2/fs/proc/base.c	Fri May  3 03:29:53 2002
@@ -309,6 +309,38 @@
 	return proc_check_root(inode);
 }
 
+static int proc_permission_locked(struct inode *inode, int mask)
+{
+	int ret;
+	struct task_struct *task = proc_task(inode);
+	if((ret = vfs_permission(inode, mask)))
+		return ret;
+
+	task_lock(task);
+
+	ret = -ENOENT;
+	if(!task->fs)
+		goto out;
+
+	ret = -EAGAIN;
+
+	/* It's not safe to grab a reference to task->fs, so we give
+           up if the roots aren't trivially the same */
+
+	if(task->fs->root != current->fs->root)
+		goto out;
+
+	if(task->fs->rootmnt != current->fs->rootmnt)
+		goto out;
+
+	ret = 0;
+
+ out:
+	task_unlock(task);
+
+	return ret;
+}
+
 static ssize_t pid_maps_read(struct file * file, char * buf,
 			      size_t count, loff_t *ppos)
 {
@@ -932,8 +964,9 @@
  * proc directories can do almost nothing..
  */
 static struct inode_operations proc_fd_inode_operations = {
-	lookup:		proc_lookupfd,
-	permission:	proc_permission,
+	lookup:            proc_lookupfd,
+	permission:	   proc_permission,
+	permission_locked: proc_permission_locked,
 };
 
 /* SMP-safe */
diff -X /mnt/elbrus/home/pmenage/dontdiff -aur linux-2.5.13/include/linux/fs.h linux-2.5.13-permission2/include/linux/fs.h
--- linux-2.5.13/include/linux/fs.h	Thu May  2 18:30:16 2002
+++ linux-2.5.13-permission2/include/linux/fs.h	Fri May  3 03:01:46 2002
@@ -757,6 +757,7 @@
 	int (*follow_link) (struct dentry *, struct nameidata *);
 	void (*truncate) (struct inode *);
 	int (*permission) (struct inode *, int);
+	int (*permission_locked) (struct inode *, int);
 	int (*revalidate) (struct dentry *);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct dentry *, struct iattr *);
diff -X /mnt/elbrus/home/pmenage/dontdiff -aur linux-2.5.13/include/linux/nfs_fs.h linux-2.5.13-permission2/include/linux/nfs_fs.h
--- linux-2.5.13/include/linux/nfs_fs.h	Thu May  2 21:55:39 2002
+++ linux-2.5.13-permission2/include/linux/nfs_fs.h	Fri May  3 03:02:39 2002
@@ -238,6 +238,7 @@
 extern int __nfs_refresh_inode(struct inode *, struct nfs_fattr *);
 extern int nfs_revalidate(struct dentry *);
 extern int nfs_permission(struct inode *, int);
+extern int nfs_permission_locked(struct inode *, int);
 extern int nfs_open(struct inode *, struct file *);
 extern int nfs_release(struct inode *, struct file *);
 extern int __nfs_revalidate_inode(struct nfs_server *, struct inode *);





