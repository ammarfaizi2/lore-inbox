Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUDEKjO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 06:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbUDEKjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 06:39:13 -0400
Received: from kempelen.iit.bme.hu ([152.66.241.120]:28587 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S261803AbUDEKib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 06:38:31 -0400
Date: Mon, 5 Apr 2004 12:38:28 +0200 (MET DST)
Message-Id: <200404051038.i35AcS505895@kempelen.iit.bme.hu>
From: Miklos Szeredi <mszeredi@inf.bme.hu>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC] [PATCH] allowing user mounts (updated for 2.6.5)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows the use of the mount syscall by non-root users in a
controlled, and secure way.  For a detailed explanation on what this
patch does see the earlier relase notes:

  http://marc.theaimsgroup.com/?l=linux-kernel&m=107701231914499&w=2

Comments, suggestions are welcome.

Miklos

diff -rup linux-2.6.5.orig/fs/filesystems.c linux-2.6.5/fs/filesystems.c
--- linux-2.6.5.orig/fs/filesystems.c	2003-12-18 03:59:18.000000000 +0100
+++ linux-2.6.5/fs/filesystems.c	2004-04-05 10:54:37.000000000 +0200
@@ -222,7 +222,8 @@ struct file_system_type *get_fs_type(con
 	if (fs && !try_module_get(fs->owner))
 		fs = NULL;
 	read_unlock(&file_systems_lock);
-	if (!fs && (request_module("%s", name) == 0)) {
+	if (!fs && capable(CAP_SYS_ADMIN) && 
+	    (request_module("%s", name) == 0)) {
 		read_lock(&file_systems_lock);
 		fs = *(find_filesystem(name));
 		if (fs && !try_module_get(fs->owner))
diff -rup linux-2.6.5.orig/fs/namespace.c linux-2.6.5/fs/namespace.c
--- linux-2.6.5.orig/fs/namespace.c	2004-04-05 10:50:46.000000000 +0200
+++ linux-2.6.5/fs/namespace.c	2004-04-05 10:54:37.000000000 +0200
@@ -25,13 +25,16 @@
 
 extern int __init init_rootfs(void);
 extern int __init sysfs_init(void);
+extern void put_filesystem(struct file_system_type *fs);
+
+#define MAX_MOUNTS 256
 
 /* spinlock for vfsmount related operations, inplace of dcache_lock */
 spinlock_t vfsmount_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 static struct list_head *mount_hashtable;
 static int hash_mask, hash_bits;
 static kmem_cache_t *mnt_cache; 
-
+struct mounts_stat_struct mounts_stat = { .max_mounts = MAX_MOUNTS };
 static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)
 {
 	unsigned long tmp = ((unsigned long) mnt / L1_CACHE_BYTES);
@@ -40,10 +43,38 @@ static inline unsigned long hash(struct 
 	return tmp & hash_mask;
 }
 
+static inline int inc_nr_mounts(void)
+{
+	int err = 0;
+	spin_lock(&vfsmount_lock);
+	if (capable(CAP_SYS_ADMIN) ||
+	    mounts_stat.nr_mounts < mounts_stat.max_mounts)
+		mounts_stat.nr_mounts++;
+	else
+		err = mounts_stat.max_mounts ? -EMFILE : -EPERM;
+	spin_unlock(&vfsmount_lock);
+	return err;
+}
+
+static inline void dec_nr_mounts(void)
+{
+	spin_lock(&vfsmount_lock);
+	mounts_stat.nr_mounts--;
+	spin_unlock(&vfsmount_lock);		
+}
+
 struct vfsmount *alloc_vfsmnt(const char *name)
 {
-	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL); 
-	if (mnt) {
+	struct vfsmount *mnt;
+	int err = inc_nr_mounts();
+	if (err)
+		return ERR_PTR(err);
+
+	mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL); 
+	if (!mnt) {
+		dec_nr_mounts();
+		return ERR_PTR(-ENOMEM);
+	} else {
 		memset(mnt, 0, sizeof(struct vfsmount));
 		atomic_set(&mnt->mnt_count,1);
 		INIT_LIST_HEAD(&mnt->mnt_hash);
@@ -66,6 +97,7 @@ void free_vfsmnt(struct vfsmount *mnt)
 {
 	kfree(mnt->mnt_devname);
 	kmem_cache_free(mnt_cache, mnt);
+	dec_nr_mounts();
 }
 
 /*
@@ -147,13 +179,14 @@ clone_mnt(struct vfsmount *old, struct d
 	struct super_block *sb = old->mnt_sb;
 	struct vfsmount *mnt = alloc_vfsmnt(old->mnt_devname);
 
-	if (mnt) {
+	if (!IS_ERR(mnt)) {
 		mnt->mnt_flags = old->mnt_flags;
 		atomic_inc(&sb->s_active);
 		mnt->mnt_sb = sb;
 		mnt->mnt_root = dget(root);
 		mnt->mnt_mountpoint = mnt->mnt_root;
 		mnt->mnt_parent = mnt;
+		mnt->user = capable(CAP_SYS_ADMIN) ? 0 : current->fsuid;
 	}
 	return mnt;
 }
@@ -238,6 +271,8 @@ static int show_vfsmnt(struct seq_file *
 		if (mnt->mnt_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
 	}
+	if (mnt->user)
+		seq_printf(m, ",user=%i", mnt->user);
 	if (mnt->mnt_sb->s_op->show_options)
 		err = mnt->mnt_sb->s_op->show_options(m, mnt);
 	seq_puts(m, " 0 0\n");
@@ -388,8 +423,10 @@ asmlinkage long sys_umount(char __user *
 		goto dput_and_out;
 
 	retval = -EPERM;
-	if (!capable(CAP_SYS_ADMIN))
-		goto dput_and_out;
+	if (!capable(CAP_SYS_ADMIN)) {
+		if(nd.mnt->user != current->fsuid || (flags & MNT_FORCE))
+			goto dput_and_out;
+	}
 
 	retval = do_umount(nd.mnt, flags);
 dput_and_out:
@@ -409,20 +446,15 @@ asmlinkage long sys_oldumount(char __use
 
 static int mount_is_safe(struct nameidata *nd)
 {
-	if (capable(CAP_SYS_ADMIN))
-		return 0;
-	return -EPERM;
-#ifdef notyet
-	if (S_ISLNK(nd->dentry->d_inode->i_mode))
-		return -EPERM;
-	if (nd->dentry->d_inode->i_mode & S_ISVTX) {
-		if (current->uid != nd->dentry->d_inode->i_uid)
+	if (!capable(CAP_SYS_ADMIN)) {
+		if (!S_ISDIR(nd->dentry->d_inode->i_mode) &&
+		    !S_ISREG(nd->dentry->d_inode->i_mode))
+			return -EPERM;
+		if (current->fsuid != nd->dentry->d_inode->i_uid ||
+		    permission(nd->dentry->d_inode, MAY_WRITE, nd))
 			return -EPERM;
 	}
-	if (permission(nd->dentry->d_inode, MAY_WRITE, nd))
-		return -EPERM;
 	return 0;
-#endif
 }
 
 static int
@@ -444,8 +476,8 @@ static struct vfsmount *copy_tree(struct
 	struct nameidata nd;
 
 	res = q = clone_mnt(mnt, dentry);
-	if (!q)
-		goto Enomem;
+	if (IS_ERR(q))
+		goto out_error;
 	q->mnt_mountpoint = mnt->mnt_mountpoint;
 
 	p = mnt;
@@ -463,8 +495,8 @@ static struct vfsmount *copy_tree(struct
 			nd.mnt = q;
 			nd.dentry = p->mnt_mountpoint;
 			q = clone_mnt(p, p->mnt_root);
-			if (!q)
-				goto Enomem;
+			if (IS_ERR(q))
+				goto out_error;
 			spin_lock(&vfsmount_lock);
 			list_add_tail(&q->mnt_list, &res->mnt_list);
 			attach_mnt(q, &nd);
@@ -472,13 +504,13 @@ static struct vfsmount *copy_tree(struct
 		}
 	}
 	return res;
- Enomem:
+ out_error:
 	if (res) {
 		spin_lock(&vfsmount_lock);
 		umount_tree(res);
 		spin_unlock(&vfsmount_lock);
 	}
-	return NULL;
+	return q;
 }
 
 static int graft_tree(struct vfsmount *mnt, struct nameidata *nd)
@@ -538,11 +570,14 @@ static int do_loopback(struct nameidata 
 	down_write(&current->namespace->sem);
 	err = -EINVAL;
 	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
-		err = -ENOMEM;
 		if (recurse)
 			mnt = copy_tree(old_nd.mnt, old_nd.dentry);
 		else
 			mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+		if (IS_ERR(mnt)) {
+			err = PTR_ERR(mnt);
+			goto out;
+		}
 	}
 
 	if (mnt) {
@@ -555,6 +590,7 @@ static int do_loopback(struct nameidata 
 			mntput(mnt);
 	}
 
+ out:
 	up_write(&current->namespace->sem);
 	path_release(&old_nd);
 	return err;
@@ -654,14 +690,28 @@ static int do_add_mount(struct nameidata
 			int mnt_flags, char *name, void *data)
 {
 	struct vfsmount *mnt;
-	int err;
+	int err = mount_is_safe(nd);
+	if(err)
+		return err;
 
 	if (!type || !memchr(type, 0, PAGE_SIZE))
 		return -EINVAL;
 
 	/* we need capabilities... */
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
+	if (!capable(CAP_SYS_ADMIN)) {
+		/* but allow "safe" filesystems anyway */
+		int issafe = 0;
+		struct file_system_type *t = get_fs_type(type);
+		if(t) {
+			issafe = t->fs_flags & FS_SAFE;
+			put_filesystem(t);
+		}
+		if(!issafe)
+			return -EPERM;
+
+		/* users should not have suid or dev files */
+		mnt_flags |= (MNT_NOSUID | MNT_NODEV);
+	}
 
 	mnt = do_kern_mount(type, flags, name, data);
 	err = PTR_ERR(mnt);
@@ -801,6 +851,7 @@ int copy_namespace(int flags, struct tas
 	struct namespace *new_ns;
 	struct vfsmount *rootmnt = NULL, *pwdmnt = NULL, *altrootmnt = NULL;
 	struct fs_struct *fs = tsk->fs;
+	int err;
 
 	if (!namespace)
 		return 0;
@@ -810,11 +861,7 @@ int copy_namespace(int flags, struct tas
 	if (!(flags & CLONE_NEWNS))
 		return 0;
 
-	if (!capable(CAP_SYS_ADMIN)) {
-		put_namespace(namespace);
-		return -EPERM;
-	}
-
+	err = -ENOMEM;
 	new_ns = kmalloc(sizeof(struct namespace), GFP_KERNEL);
 	if (!new_ns)
 		goto out;
@@ -826,7 +873,8 @@ int copy_namespace(int flags, struct tas
 	down_write(&tsk->namespace->sem);
 	/* First pass: copy the tree topology */
 	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root);
-	if (!new_ns->root) {
+	if (IS_ERR(new_ns->root)) {
+		err = PTR_ERR(new_ns->root);
 		up_write(&tsk->namespace->sem);
 		kfree(new_ns);
 		goto out;
@@ -876,7 +924,7 @@ int copy_namespace(int flags, struct tas
 
 out:
 	put_namespace(namespace);
-	return -ENOMEM;
+	return err;
 }
 
 asmlinkage long sys_mount(char __user * dev_name, char __user * dir_name,
diff -rup linux-2.6.5.orig/fs/super.c linux-2.6.5/fs/super.c
--- linux-2.6.5.orig/fs/super.c	2004-04-05 10:50:46.000000000 +0200
+++ linux-2.6.5/fs/super.c	2004-04-05 11:02:10.000000000 +0200
@@ -726,7 +726,7 @@ struct vfsmount *
 do_kern_mount(const char *fstype, int flags, const char *name, void *data)
 {
 	struct file_system_type *type = get_fs_type(fstype);
-	struct super_block *sb = ERR_PTR(-ENOMEM);
+	struct super_block *sb;
 	struct vfsmount *mnt;
 	int error;
 	char *secdata = NULL;
@@ -735,24 +735,23 @@ do_kern_mount(const char *fstype, int fl
 		return ERR_PTR(-ENODEV);
 
 	mnt = alloc_vfsmnt(name);
-	if (!mnt)
+	error = PTR_ERR(mnt);
+	if (IS_ERR(mnt))
 		goto out;
 
 	if (data) {
 		secdata = alloc_secdata();
-		if (!secdata) {
-			sb = ERR_PTR(-ENOMEM);
+		error = -ENOMEM;
+		if (!secdata)
 			goto out_mnt;
-		}
 
 		error = security_sb_copy_data(type, data, secdata);
-		if (error) {
-			sb = ERR_PTR(error);
+		if (error)
 			goto out_free_secdata;
-		}
 	}
 
 	sb = type->get_sb(type, flags, name, data);
+	error = PTR_ERR(sb);
 	if (IS_ERR(sb))
 		goto out_free_secdata;
  	error = security_sb_kern_mount(sb, secdata);
@@ -762,20 +761,20 @@ do_kern_mount(const char *fstype, int fl
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = sb->s_root;
 	mnt->mnt_parent = mnt;
+	mnt->user = capable(CAP_SYS_ADMIN) ? 0 : current->fsuid;
 	up_write(&sb->s_umount);
 	put_filesystem(type);
 	return mnt;
 out_sb:
 	up_write(&sb->s_umount);
 	deactivate_super(sb);
-	sb = ERR_PTR(error);
 out_free_secdata:
 	free_secdata(secdata);
 out_mnt:
 	free_vfsmnt(mnt);
 out:
 	put_filesystem(type);
-	return (struct vfsmount *)sb;
+	return ERR_PTR(error);
 }
 
 struct vfsmount *kern_mount(struct file_system_type *type)
diff -rup linux-2.6.5.orig/include/linux/fs.h linux-2.6.5/include/linux/fs.h
--- linux-2.6.5.orig/include/linux/fs.h	2004-04-05 10:50:50.000000000 +0200
+++ linux-2.6.5/include/linux/fs.h	2004-04-05 11:03:55.000000000 +0200
@@ -55,6 +55,12 @@ struct files_stat_struct {
 };
 extern struct files_stat_struct files_stat;
 
+struct mounts_stat_struct {
+	int nr_mounts;
+	int max_mounts;
+};
+extern struct mounts_stat_struct mounts_stat;
+
 struct inodes_stat_t {
 	int nr_inodes;
 	int nr_unused;
@@ -90,6 +96,7 @@ extern int leases_enable, dir_notify_ena
 /* public flags for file_system_type */
 #define FS_REQUIRES_DEV 1 
 #define FS_BINARY_MOUNTDATA 2
+#define FS_SAFE		4	/* Safe to mount by user */
 #define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
 #define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
 				  * as nfs_rename() will be cleaned up
diff -rup linux-2.6.5.orig/include/linux/mount.h linux-2.6.5/include/linux/mount.h
--- linux-2.6.5.orig/include/linux/mount.h	2003-12-18 03:58:08.000000000 +0100
+++ linux-2.6.5/include/linux/mount.h	2004-04-05 10:54:37.000000000 +0200
@@ -30,6 +30,7 @@ struct vfsmount
 	atomic_t mnt_count;
 	int mnt_flags;
 	char *mnt_devname;		/* Name of device e.g. /dev/dsk/hda1 */
+	uid_t user;
 	struct list_head mnt_list;
 };
 
diff -rup linux-2.6.5.orig/include/linux/sysctl.h linux-2.6.5/include/linux/sysctl.h
--- linux-2.6.5.orig/include/linux/sysctl.h	2004-04-05 10:50:50.000000000 +0200
+++ linux-2.6.5/include/linux/sysctl.h	2004-04-05 10:54:37.000000000 +0200
@@ -624,8 +624,8 @@ enum
 	FS_NRFILE=6,	/* int:current number of allocated filedescriptors */
 	FS_MAXFILE=7,	/* int:maximum number of filedescriptors that can be allocated */
 	FS_DENTRY=8,
-	FS_NRSUPER=9,	/* int:current number of allocated super_blocks */
-	FS_MAXSUPER=10,	/* int:maximum number of super_blocks that can be allocated */
+	FS_NRMOUNT=9,	/* int:current number of mounts */
+	FS_MAXMOUNT=10,	/* int:maximum number of mounts allowed */
 	FS_OVERFLOWUID=11,	/* int: overflow UID */
 	FS_OVERFLOWGID=12,	/* int: overflow GID */
 	FS_LEASES=13,	/* int: leases enabled */
diff -rup linux-2.6.5.orig/kernel/sysctl.c linux-2.6.5/kernel/sysctl.c
--- linux-2.6.5.orig/kernel/sysctl.c	2004-04-05 10:50:51.000000000 +0200
+++ linux-2.6.5/kernel/sysctl.c	2004-04-05 10:54:37.000000000 +0200
@@ -793,6 +793,22 @@ static ctl_table fs_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 	{
+		.ctl_name	= FS_NRMOUNT,
+		.procname	= "mount-nr",
+		.data		= &mounts_stat.nr_mounts,
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= FS_MAXMOUNT,
+		.procname	= "mount-max",
+		.data		= &mounts_stat.max_mounts,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
 		.ctl_name	= FS_OVERFLOWUID,
 		.procname	= "overflowuid",
 		.data		= &fs_overflowuid,

