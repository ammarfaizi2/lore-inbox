Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315611AbSECJEI>; Fri, 3 May 2002 05:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315610AbSECJEH>; Fri, 3 May 2002 05:04:07 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:15364 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S315611AbSECJEC>; Fri, 3 May 2002 05:04:02 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Paul Menage <pmenage@ensim.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace exec_permission_lite() with inlined vfs_permission() 
In-Reply-To: Your message of "Thu, 02 May 2002 22:16:37 EDT."
             <Pine.GSO.4.21.0205022159040.17171-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 02:03:47 -0700
Message-Id: <E173Yyh-0004zD-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How about something like the patch below?

- i_op->permission() now takes an extra argument, "dcache_locked", and 
should return -EAGAIN if it's called with the dcache_lock held and it 
can't handle it.

- callers should use permission() or permission_locked() as appropriate

- some filesystems (sysctl, smbfs, coda ioctl) can ignore dcache_locked,
as their permission methods never doing anything involving blocking or
locks

- procfs root checks now rely on the dcache_lock to synchronise access 
to current->fs->* and target_proc->fs->* and avoid taking reference 
counts on dentries and mounts.

- nfs and coda give -EAGAIN if they would need to make an rpc call when 
dcache_lock is held

- intermezzo gives up immediately if dcache_lock is held. Also fixed 
horribly ugly abuse of i_op->permission.

If this is OK, let me know and I'll split it up into a few smaller
chunks and send it to Linus (and the relevant FS maintainers).

i_op->permission() also looks like an easy candidate for BKL removal.

Paul

diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.13/Documentation/filesystems/Locking linux-2.5.13-permission/Documentation/filesystems/Locking
--- linux-2.5.13/Documentation/filesystems/Locking	Thu May  2 17:22:48 2002
+++ linux-2.5.13-permission/Documentation/filesystems/Locking	Fri May  3 00:54:17 2002
@@ -41,7 +41,7 @@
 	int (*readlink) (struct dentry *, char *,int);
 	int (*follow_link) (struct dentry *, struct nameidata *);
 	void (*truncate) (struct inode *);
-	int (*permission) (struct inode *, int);
+	int (*permission) (struct inode *, int, int dcache_locked);
 	int (*revalidate) (struct dentry *);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct dentry *, struct iattr *);
@@ -66,7 +66,7 @@
 follow_link:	no	no
 truncate:	no	yes		(see below)
 setattr:	no	yes
-permission:	yes	no
+permission:		no		(see below)
 getattr:				(see below)
 revalidate:	no			(see below)
 setxattr:	no	yes
@@ -76,6 +76,7 @@
 	Additionally, ->rmdir(), ->unlink() and ->rename() have ->i_sem on
 victim.
 	cross-directory ->rename() has (per-superblock) ->s_vfs_rename_sem.
+	->permission() has BKL if dcache_locked is 0, otherwise has dcache_lock
 	->revalidate(), it may be called both with and without the i_sem
 on dentry->d_inode.
 	->truncate() is never called directly - it's a callback, not a
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.13/Documentation/filesystems/vfs.txt linux-2.5.13-permission/Documentation/filesystems/vfs.txt
--- linux-2.5.13/Documentation/filesystems/vfs.txt	Thu May  2 17:22:42 2002
+++ linux-2.5.13-permission/Documentation/filesystems/vfs.txt	Fri May  3 00:53:22 2002
@@ -253,7 +253,7 @@
 	int (*writepage) (struct file *, struct page *);
 	int (*bmap) (struct inode *,int);
 	void (*truncate) (struct inode *);
-	int (*permission) (struct inode *, int);
+	int (*permission) (struct inode *, int, int);
 	int (*smap) (struct inode *,int);
 	int (*updatepage) (struct file *, struct page *, const char *,
 				unsigned long, unsigned int, int);
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.13/fs/coda/dir.c linux-2.5.13-permission/fs/coda/dir.c
--- linux-2.5.13/fs/coda/dir.c	Thu May  2 17:22:42 2002
+++ linux-2.5.13-permission/fs/coda/dir.c	Fri May  3 01:40:27 2002
@@ -146,9 +146,8 @@
 }
 
 
-int coda_permission(struct inode *inode, int mask)
+int coda_permission(struct inode *inode, int mask, int dcache_locked)
 {
-	umode_t mode = inode->i_mode;
         int error;
  
 	if (!mask)
@@ -159,6 +158,9 @@
 	if (coda_cache_check(inode, mask))
 		return 0; 
 
+	if(dcache_locked)
+		return -EAGAIN;
+
         error = venus_access(inode->i_sb, coda_i2f(inode), mask);
     
 	if (!error)
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.13/fs/coda/pioctl.c linux-2.5.13-permission/fs/coda/pioctl.c
--- linux-2.5.13/fs/coda/pioctl.c	Thu May  2 17:22:55 2002
+++ linux-2.5.13-permission/fs/coda/pioctl.c	Fri May  3 01:39:18 2002
@@ -24,25 +24,8 @@
 #include <linux/coda_fs_i.h>
 #include <linux/coda_psdev.h>
 
-/* pioctl ops */
-static int coda_ioctl_permission(struct inode *inode, int mask);
-static int coda_pioctl(struct inode * inode, struct file * filp, 
-                       unsigned int cmd, unsigned long user_data);
-
-/* exported from this file */
-struct inode_operations coda_ioctl_inode_operations =
-{
-	permission:	coda_ioctl_permission,
-	setattr:	coda_notify_change,
-};
-
-struct file_operations coda_ioctl_operations = {
-	owner:		THIS_MODULE,
-	ioctl:		coda_pioctl,
-};
-
 /* the coda pioctl inode ops */
-static int coda_ioctl_permission(struct inode *inode, int mask)
+static int coda_ioctl_permission(struct inode *inode, int mask, int dcache_locked)
 {
         return 0;
 }
@@ -92,3 +75,15 @@
         return error;
 }
 
+/* exported from this file */
+struct inode_operations coda_ioctl_inode_operations =
+{
+	permission:	coda_ioctl_permission,
+	setattr:	coda_notify_change,
+};
+
+struct file_operations coda_ioctl_operations = {
+	owner:		THIS_MODULE,
+	ioctl:		coda_pioctl,
+};
+
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.13/fs/intermezzo/dir.c linux-2.5.13-permission/fs/intermezzo/dir.c
--- linux-2.5.13/fs/intermezzo/dir.c	Thu May  2 17:22:45 2002
+++ linux-2.5.13-permission/fs/intermezzo/dir.c	Fri May  3 01:39:18 2002
@@ -70,7 +70,7 @@
 /*
  * these are initialized in super.c
  */
-extern int presto_permission(struct inode *inode, int mask);
+extern int presto_permission(struct inode *inode, int mask, int dcache_locked);
 int presto_ilookup_uid = 0;
 
 extern int presto_prep(struct dentry *, struct presto_cache **,
@@ -782,12 +782,15 @@
  * appropriate permission function. Thus we do not worry here about ACLs
  * or EAs. -SHP
  */
-int presto_permission(struct inode *inode, int mask)
+int presto_permission(struct inode *inode, int mask, int dcache_locked)
 {
         unsigned short mode = inode->i_mode;
         struct presto_cache *cache;
         int rc;
 
+	if(dcache_locked)
+	    return -EAGAIN;
+
         ENTRY;
         if ( presto_can_ilookup() && !(mask & S_IWOTH)) {
                 CDEBUG(D_CACHE, "ilookup on %ld OK\n", inode->i_ino);
@@ -804,23 +807,15 @@
 
                 if ( S_ISREG(mode) && fiops && fiops->permission ) {
                         EXIT;
-                        return fiops->permission(inode, mask);
+                        return fiops->permission(inode, mask, dcache_locked);
                 }
                 if ( S_ISDIR(mode) && diops && diops->permission ) {
                         EXIT;
-                        return diops->permission(inode, mask);
+                        return diops->permission(inode, mask, dcache_locked);
                 }
         }
 
-        /* The cache filesystem doesn't have its own permission function,
-         * but we don't want to duplicate the VFS code here.  In order
-         * to avoid looping from permission calling this function again,
-         * we temporarily override the permission operation while we call
-         * the VFS permission function.
-         */
-        inode->i_op->permission = NULL;
-        rc = permission(inode, mask);
-        inode->i_op->permission = &presto_permission;
+	rc = vfs_permission(inode, mask);
 
         EXIT;
         return rc;
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.13/fs/intermezzo/file.c linux-2.5.13-permission/fs/intermezzo/file.c
--- linux-2.5.13/fs/intermezzo/file.c	Thu May  2 17:22:41 2002
+++ linux-2.5.13-permission/fs/intermezzo/file.c	Fri May  3 01:39:18 2002
@@ -46,7 +46,7 @@
 /*
  * these are initialized in super.c
  */
-extern int presto_permission(struct inode *inode, int mask);
+extern int presto_permission(struct inode *inode, int mask, int dcache_locked);
 extern int presto_opendir_upcall(int minor, struct dentry *de, int async);
 
 extern int presto_prep(struct dentry *, struct presto_cache **,
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.13/fs/namei.c linux-2.5.13-permission/fs/namei.c
--- linux-2.5.13/fs/namei.c	Thu May  2 18:57:38 2002
+++ linux-2.5.13-permission/fs/namei.c	Fri May  3 01:39:18 2002
@@ -153,7 +153,7 @@
  * for filesystem access without changing the "normal" uids which
  * are used for other things..
  */
-int vfs_permission(struct inode * inode, int mask)
+inline int vfs_permission(struct inode * inode, int mask)
 {
 	umode_t			mode = inode->i_mode;
 
@@ -201,12 +201,19 @@
 	return -EACCES;
 }
 
+static inline int permission_locked(struct inode *inode, int mask) {
+
+	if (inode->i_op && inode->i_op->permission) 
+		return inode->i_op->permission(inode, mask, 1);
+	return vfs_permission(inode, mask);
+}
+
 int permission(struct inode * inode,int mask)
 {
 	if (inode->i_op && inode->i_op->permission) {
 		int retval;
 		lock_kernel();
-		retval = inode->i_op->permission(inode, mask);
+		retval = inode->i_op->permission(inode, mask, 0);
 		unlock_kernel();
 		return retval;
 	}
@@ -300,40 +307,6 @@
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
@@ -578,7 +551,7 @@
 		struct qstr this;
 		unsigned int c;
 
-		err = exec_permission_lite(inode);
+		err = permission_locked(inode, MAY_EXEC);
 		if (err == -EAGAIN) {
 			unlock_nd(nd);
 			err = permission(inode, MAY_EXEC);
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.13/fs/nfs/dir.c linux-2.5.13-permission/fs/nfs/dir.c
--- linux-2.5.13/fs/nfs/dir.c	Thu May  2 17:22:53 2002
+++ linux-2.5.13-permission/fs/nfs/dir.c	Fri May  3 01:39:18 2002
@@ -1100,7 +1100,7 @@
 }
 
 int
-nfs_permission(struct inode *inode, int mask)
+nfs_permission(struct inode *inode, int mask, int dcache_locked) 
 {
 	int			error = vfs_permission(inode, mask);
 
@@ -1120,6 +1120,10 @@
 	    && (current->fsuid != 0) && (current->fsgid != 0)
 	    && error != -EACCES)
 		goto out;
+	
+	error = -EAGAIN;
+	if (dcache_locked) 
+		goto out;
 
 	error = NFS_PROTO(inode)->access(inode, mask, 0);
 
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.13/fs/proc/base.c linux-2.5.13-permission/fs/proc/base.c
--- linux-2.5.13/fs/proc/base.c	Thu May  2 17:22:40 2002
+++ linux-2.5.13-permission/fs/proc/base.c	Fri May  3 01:45:57 2002
@@ -180,16 +180,23 @@
 	return result;
 }
 
-static int proc_root_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
-{
-	struct fs_struct *fs;
-	int result = -ENOENT;
+static struct fs_struct *get_task_fs(struct inode *inode) {
+
+	struct fs_struct *fs = NULL;
 	task_lock(proc_task(inode));
 	fs = proc_task(inode)->fs;
 	if(fs)
 		atomic_inc(&fs->count);
 	task_unlock(proc_task(inode));
-	if (fs) {
+	return fs;
+}
+
+static int proc_root_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
+{
+	int result = -ENOENT;
+	struct fs_struct *fs = get_task_fs(inode);
+
+	if(fs) {
 		read_lock(&fs->lock);
 		*mnt = mntget(fs->rootmnt);
 		*dentry = dget(fs->root);
@@ -262,20 +269,24 @@
 
 /* permission checks */
 
-static int proc_check_root(struct inode *inode)
+static int proc_check_root(struct inode *inode, int locked)
 {
 	struct dentry *de, *base, *root;
 	struct vfsmount *our_vfsmnt, *vfsmnt, *mnt;
-	int res = 0;
+	struct fs_struct *fs = get_task_fs(inode);
+	int res = -EACCES;
 
-	if (proc_root_link(inode, &root, &vfsmnt)) /* Ewww... */
+	if (!fs) 
 		return -ENOENT;
-	read_lock(&current->fs->lock);
-	our_vfsmnt = mntget(current->fs->rootmnt);
-	base = dget(current->fs->root);
-	read_unlock(&current->fs->lock);
+	
+	if(!locked)
+		spin_lock(&dcache_lock);
+
+	root = fs->root;
+	vfsmnt = fs->rootmnt;
+	our_vfsmnt = current->fs->rootmnt;
+	base = current->fs->root;
 
-	spin_lock(&dcache_lock);
 	de = root;
 	mnt = vfsmnt;
 
@@ -288,25 +299,24 @@
 
 	if (!is_subdir(de, base))
 		goto out;
-	spin_unlock(&dcache_lock);
 
-exit:
-	dput(base);
-	mntput(our_vfsmnt);
-	dput(root);
-	mntput(mnt);
+	res = 0;
+
+ out:
+	if(!locked)
+		spin_unlock(&dcache_lock);
+	
+	put_fs_struct(fs);
+
 	return res;
-out:
-	spin_unlock(&dcache_lock);
-	res = -EACCES;
-	goto exit;
 }
 
-static int proc_permission(struct inode *inode, int mask)
+static int proc_permission(struct inode *inode, int mask, int dcache_locked)
 {
-	if (vfs_permission(inode, mask) != 0)
-		return -EACCES;
-	return proc_check_root(inode);
+	int ret;
+	if ((ret = vfs_permission(inode, mask)) != 0)
+		return ret;
+	return proc_check_root(inode, dcache_locked);
 }
 
 static ssize_t pid_maps_read(struct file * file, char * buf,
@@ -534,7 +544,7 @@
 
 	if (current->fsuid != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
 		goto out;
-	error = proc_check_root(inode);
+	error = proc_check_root(inode, 0);
 	if (error)
 		goto out;
 
@@ -576,7 +586,7 @@
 
 	if (current->fsuid != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
 		goto out;
-	error = proc_check_root(inode);
+	error = proc_check_root(inode, 0);
 	if (error)
 		goto out;
 
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.13/fs/smbfs/file.c linux-2.5.13-permission/fs/smbfs/file.c
--- linux-2.5.13/fs/smbfs/file.c	Thu May  2 17:22:56 2002
+++ linux-2.5.13-permission/fs/smbfs/file.c	Fri May  3 01:39:18 2002
@@ -369,7 +369,7 @@
  * privileges, so we need our own check for this.
  */
 static int
-smb_file_permission(struct inode *inode, int mask)
+smb_file_permission(struct inode *inode, int mask, int dcache_locked)
 {
 	int mode = inode->i_mode;
 	int error = 0;
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.13/include/linux/coda_linux.h linux-2.5.13-permission/include/linux/coda_linux.h
--- linux-2.5.13/include/linux/coda_linux.h	Thu May  2 17:22:43 2002
+++ linux-2.5.13-permission/include/linux/coda_linux.h	Fri May  3 01:20:32 2002
@@ -38,7 +38,7 @@
 int coda_open(struct inode *i, struct file *f);
 int coda_flush(struct file *f);
 int coda_release(struct inode *i, struct file *f);
-int coda_permission(struct inode *inode, int mask);
+int coda_permission(struct inode *inode, int mask, int dcache_locked);
 int coda_revalidate_inode(struct dentry *);
 int coda_notify_change(struct dentry *, struct iattr *);
 int coda_isnullfid(ViceFid *fid);
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.13/include/linux/dcache.h linux-2.5.13-permission/include/linux/dcache.h
--- linux-2.5.13/include/linux/dcache.h	Thu May  2 18:30:16 2002
+++ linux-2.5.13-permission/include/linux/dcache.h	Thu May  2 21:53:55 2002
@@ -86,6 +86,7 @@
 
 struct dentry_operations {
 	int (*d_revalidate)(struct dentry *, int);
+	int (*d_revalidate_locked)(struct dentry *, int);
 	int (*d_hash) (struct dentry *, struct qstr *);
 	int (*d_compare) (struct dentry *, struct qstr *, struct qstr *);
 	int (*d_delete)(struct dentry *);
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.13/include/linux/fs.h linux-2.5.13-permission/include/linux/fs.h
--- linux-2.5.13/include/linux/fs.h	Thu May  2 18:30:16 2002
+++ linux-2.5.13-permission/include/linux/fs.h	Fri May  3 01:07:25 2002
@@ -756,7 +756,7 @@
 	int (*readlink) (struct dentry *, char *,int);
 	int (*follow_link) (struct dentry *, struct nameidata *);
 	void (*truncate) (struct inode *);
-	int (*permission) (struct inode *, int);
+	int (*permission) (struct inode *, int, int);
 	int (*revalidate) (struct dentry *);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct dentry *, struct iattr *);
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.13/include/linux/nfs_fs.h linux-2.5.13-permission/include/linux/nfs_fs.h
--- linux-2.5.13/include/linux/nfs_fs.h	Thu May  2 21:55:39 2002
+++ linux-2.5.13-permission/include/linux/nfs_fs.h	Fri May  3 01:19:52 2002
@@ -237,7 +237,7 @@
 				struct nfs_fattr *);
 extern int __nfs_refresh_inode(struct inode *, struct nfs_fattr *);
 extern int nfs_revalidate(struct dentry *);
-extern int nfs_permission(struct inode *, int);
+extern int nfs_permission(struct inode *, int, int);
 extern int nfs_open(struct inode *, struct file *);
 extern int nfs_release(struct inode *, struct file *);
 extern int __nfs_revalidate_inode(struct nfs_server *, struct inode *);
diff -aur -X /mnt/elbrus/home/pmenage/dontdiff linux-2.5.13/kernel/sysctl.c linux-2.5.13-permission/kernel/sysctl.c
--- linux-2.5.13/kernel/sysctl.c	Thu May  2 17:22:41 2002
+++ linux-2.5.13-permission/kernel/sysctl.c	Fri May  3 01:21:04 2002
@@ -122,7 +122,7 @@
 
 static ssize_t proc_readsys(struct file *, char *, size_t, loff_t *);
 static ssize_t proc_writesys(struct file *, const char *, size_t, loff_t *);
-static int proc_sys_permission(struct inode *, int);
+static int proc_sys_permission(struct inode *, int, int);
 
 struct file_operations proc_sys_file_operations = {
 	read:		proc_readsys,
@@ -701,7 +701,7 @@
 	return do_rw_proc(1, file, (char *) buf, count, ppos);
 }
 
-static int proc_sys_permission(struct inode *inode, int op)
+static int proc_sys_permission(struct inode *inode, int op, int dcache_locked)
 {
 	return test_perm(inode->i_mode, op);
 }


