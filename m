Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbUBQKAx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 05:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUBQKAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 05:00:53 -0500
Received: from kempelen.iit.bme.hu ([152.66.241.120]:65022 "EHLO
	kempelen.iit.bme.hu") by vger.kernel.org with ESMTP id S264547AbUBQKAD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 05:00:03 -0500
Date: Tue, 17 Feb 2004 11:00:00 +0100 (MET)
Message-Id: <200402171000.i1HA00U29578@kempelen.iit.bme.hu>
From: Miklos Szeredi <mszeredi@inf.bme.hu>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC] [PATCH] allowing user mounts 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (against 2.6.3-rc4) allows the use of the mount syscall by
non-root users in a controlled, and secure (I hope) way.  I'd very
much appreciate any comments, and guesses at the chance (in hell) of
getting something like this into the main kernel.

The patch does the following:

  - adds a new vfsmount counter (/proc/sys/fs/mount-nr)
  
  - adds a vfsmount limit (/proc/sys/fs/mount-max)
  
  - user is not allowed to go over this limit when mounting, superuser
  is allowed unlimited mounts (similarly to the open file limit).  The
  limit of zero is equivalent to the current situation
  
  - allows bind mount to a directory owned and writable by the user
  
  - allows mounting of a filesystem which is declared "safe" (FS_SAFE
  filesystem flag), same restrictions as above
  
  - automatic module loading is not allowed when user is mounting,
  nosuid and nodev flags are added to user mounts
  
  - adds a new "user" field to vfsmount.  This is 0 if mount is done
  with CAP_SYS_ADMIN, current->fsuid otherwise
  
  - if vfsmount->user is nonzero then this shows up as user=UID in
  /proc/mounts
  
  - allows unmount of a filesystem which was mounted by the same user
    (forced unmount is not allowed)
  
  - allows use of the CLONE_NEWNS flag of clone() by users, with the
  limitation to the number of mounts as above

The FS_SAFE flag is needed for the FUSE filesystem, so non-root users
can mount their own userspace filesystem implemetations.  Allowing
bind mounts is a nice feature (and it seems Al Viro had plans for
implementing this).  

Remounts and move mounts are not yet allowed to users, because these
are a bit more tricky, but should be possible to do.

Of course (u)mount(8) try to be clever and not allow this sort of
mount, so I've included two simple programs at the end: 'bindmount'
and 'real-umount'.  To try out mounting an FS_SAFE filesystem, check
out the CVS version of FUSE (instructions are at:
http://sourceforge.net/cvs/?group_id=21636), and after installation
remove the suid bit from the fusermount executable.

Miklos

diff -ru linux-2.6.3-rc4.orig/fs/filesystems.c linux-2.6.3-rc4/fs/filesystems.c
--- linux-2.6.3-rc4.orig/fs/filesystems.c	2003-12-18 03:59:18.000000000 +0100
+++ linux-2.6.3-rc4/fs/filesystems.c	2004-02-17 10:08:04.000000000 +0100
@@ -222,7 +222,8 @@
 	if (fs && !try_module_get(fs->owner))
 		fs = NULL;
 	read_unlock(&file_systems_lock);
-	if (!fs && (request_module("%s", name) == 0)) {
+	if (!fs && capable(CAP_SYS_ADMIN) && 
+	    (request_module("%s", name) == 0)) {
 		read_lock(&file_systems_lock);
 		fs = *(find_filesystem(name));
 		if (fs && !try_module_get(fs->owner))
diff -ru linux-2.6.3-rc4.orig/fs/namespace.c linux-2.6.3-rc4/fs/namespace.c
--- linux-2.6.3-rc4.orig/fs/namespace.c	2004-02-17 10:20:40.000000000 +0100
+++ linux-2.6.3-rc4/fs/namespace.c	2004-02-17 10:08:04.000000000 +0100
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
@@ -40,10 +43,38 @@
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
@@ -66,6 +97,7 @@
 {
 	kfree(mnt->mnt_devname);
 	kmem_cache_free(mnt_cache, mnt);
+	dec_nr_mounts();
 }
 
 /*
@@ -147,13 +179,14 @@
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
@@ -238,6 +271,8 @@
 		if (mnt->mnt_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
 	}
+	if (mnt->user)
+		seq_printf(m, ",user=%i", mnt->user);
 	if (mnt->mnt_sb->s_op->show_options)
 		err = mnt->mnt_sb->s_op->show_options(m, mnt);
 	seq_puts(m, " 0 0\n");
@@ -388,8 +423,10 @@
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
@@ -409,20 +446,15 @@
 
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
@@ -444,8 +476,8 @@
 	struct nameidata nd;
 
 	res = q = clone_mnt(mnt, dentry);
-	if (!q)
-		goto Enomem;
+	if (IS_ERR(q))
+		goto out_error;
 	q->mnt_mountpoint = mnt->mnt_mountpoint;
 
 	p = mnt;
@@ -463,8 +495,8 @@
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
@@ -472,13 +504,13 @@
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
@@ -538,11 +570,14 @@
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
@@ -555,6 +590,7 @@
 			mntput(mnt);
 	}
 
+ out:
 	up_write(&current->namespace->sem);
 	path_release(&old_nd);
 	return err;
@@ -654,14 +690,28 @@
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
@@ -797,6 +847,7 @@
 	struct namespace *new_ns;
 	struct vfsmount *rootmnt = NULL, *pwdmnt = NULL, *altrootmnt = NULL;
 	struct fs_struct *fs = tsk->fs;
+	int err;
 
 	if (!namespace)
 		return 0;
@@ -806,11 +857,7 @@
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
@@ -822,7 +869,8 @@
 	down_write(&tsk->namespace->sem);
 	/* First pass: copy the tree topology */
 	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root);
-	if (!new_ns->root) {
+	if (IS_ERR(new_ns->root)) {
+		err = PTR_ERR(new_ns->root);
 		up_write(&tsk->namespace->sem);
 		kfree(new_ns);
 		goto out;
@@ -872,7 +920,7 @@
 
 out:
 	put_namespace(namespace);
-	return -ENOMEM;
+	return err;
 }
 
 asmlinkage long sys_mount(char __user * dev_name, char __user * dir_name,
diff -ru linux-2.6.3-rc4.orig/fs/super.c linux-2.6.3-rc4/fs/super.c
--- linux-2.6.3-rc4.orig/fs/super.c	2004-02-17 10:20:40.000000000 +0100
+++ linux-2.6.3-rc4/fs/super.c	2004-02-17 10:17:38.000000000 +0100
@@ -705,7 +705,7 @@
 do_kern_mount(const char *fstype, int flags, const char *name, void *data)
 {
 	struct file_system_type *type = get_fs_type(fstype);
-	struct super_block *sb = ERR_PTR(-ENOMEM);
+	struct super_block *sb;
 	struct vfsmount *mnt;
 	int error;
 	char *secdata = NULL;
@@ -714,24 +714,23 @@
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
 
 		error = security_sb_copy_data(fstype, data, secdata);
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
@@ -741,20 +740,20 @@
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
diff -ru linux-2.6.3-rc4.orig/include/linux/fs.h linux-2.6.3-rc4/include/linux/fs.h
--- linux-2.6.3-rc4.orig/include/linux/fs.h	2004-02-17 10:20:42.000000000 +0100
+++ linux-2.6.3-rc4/include/linux/fs.h	2004-02-17 10:08:04.000000000 +0100
@@ -55,6 +55,12 @@
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
@@ -89,6 +95,7 @@
 
 /* public flags for file_system_type */
 #define FS_REQUIRES_DEV 1 
+#define FS_SAFE		2	/* Safe to mount by user */
 #define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
 #define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
 				  * as nfs_rename() will be cleaned up
diff -ru linux-2.6.3-rc4.orig/include/linux/mount.h linux-2.6.3-rc4/include/linux/mount.h
--- linux-2.6.3-rc4.orig/include/linux/mount.h	2003-12-18 03:58:08.000000000 +0100
+++ linux-2.6.3-rc4/include/linux/mount.h	2004-02-17 10:08:04.000000000 +0100
@@ -30,6 +30,7 @@
 	atomic_t mnt_count;
 	int mnt_flags;
 	char *mnt_devname;		/* Name of device e.g. /dev/dsk/hda1 */
+	uid_t user;
 	struct list_head mnt_list;
 };
 
diff -ru linux-2.6.3-rc4.orig/include/linux/sysctl.h linux-2.6.3-rc4/include/linux/sysctl.h
--- linux-2.6.3-rc4.orig/include/linux/sysctl.h	2004-02-17 10:20:42.000000000 +0100
+++ linux-2.6.3-rc4/include/linux/sysctl.h	2004-02-17 10:08:04.000000000 +0100
@@ -608,8 +608,8 @@
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
diff -ru linux-2.6.3-rc4.orig/kernel/sysctl.c linux-2.6.3-rc4/kernel/sysctl.c
--- linux-2.6.3-rc4.orig/kernel/sysctl.c	2004-02-17 10:20:43.000000000 +0100
+++ linux-2.6.3-rc4/kernel/sysctl.c	2004-02-17 10:08:04.000000000 +0100
@@ -763,6 +763,22 @@
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


=== bindmount.c ============================================
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>

#ifndef MS_REC
#define MS_REC 16384
#endif

static void usage(char *progname)
{
    fprintf(stderr, "usage: %s [-r] from to\n", progname);
    fprintf(stderr, "  -r: recursive mount\n");
    exit(1);
}

int main(int argc, char *argv[])
{
    int res;
    char *from;
    char *to;
    int ctr;
    int flags = MS_BIND;
  
    if(argc < 3 || strcmp(argv[1], "-h") == 0)
        usage(argv[0]);

    ctr = 1;
    if(strcmp(argv[ctr], "-r") == 0) {
        flags |= MS_REC;
        ctr ++;
    }
    if(argc - ctr < 2)
        usage(argv[0]);
    from = argv[ctr++];
    to = argv[ctr++];
    res = mount(from, to, "none", flags, NULL);
    if(res == -1) {
        perror("mount failed");
        exit(1);
    }
    return 0;
}
============================================================

=== real-umount.c ==========================================
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>

#ifndef MNT_DETACH
#define MNT_DETACH 2
#endif

static void usage(char *progname)
{
    fprintf(stderr, "usage: %s [-l] mount_point\n", progname);
    fprintf(stderr, "  -l: lazy unmount\n");
    exit(1);
}

int main(int argc, char *argv[])
{
    int res;
    char *dir;
    int ctr;
    int flags = 0;
    
    if(argc < 2 || strcmp(argv[1], "-h") == 0)
        usage(argv[0]);

    ctr = 1;
    if(strcmp(argv[ctr], "-l") == 0) {
        flags |= MNT_DETACH;
        ctr++;
    }
    if(argc - ctr < 1)
        usage(argv[0]);
    dir = argv[ctr++];
    res = umount2(dir, flags);
    if(res == -1) {
        perror("umount failed");
        exit(1);
    }
    return 0;
}
============================================================
