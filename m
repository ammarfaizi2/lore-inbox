Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVECOje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVECOje (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVECOik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:38:40 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:60677 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261619AbVECObw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:31:52 -0400
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
CC: ericvh@gmail.com, smfrench@austin.rr.com, hch@infradead.org
Subject: [RCF] [PATCH] unprivileged mount/umount
Message-Id: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 03 May 2005 16:31:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This (lightly tested) patch against 2.6.12-rc* adds some
infrastructure and basic functionality for unprivileged mount/umount
system calls.

Details:

  - new mnt_owner field in struct vfsmount
  - if mnt_owner is NULL, it's a privileged mount
  - global limit on unprivileged mounts in  /proc/sys/fs/mount-max
  - per user limit of mounts in rlimit
  - allow umount for the owner (except force flag)
  - allow unprivileged bind mount to files/directories writable by owner
  - add nosuid,nodev flags to unprivileged mounts

Next step would be to add some policy for new mounts.  I'm thinking of
either something static: e.g. FS_SAFE flag for "safe" filesystems, or
a more configurable approach through sysfs or something.

Comments?

Thanks,
Miklos

Index: fs/namespace.c
===================================================================
--- a6d962c4f559f3644678574a66310084fd13d130/fs/namespace.c  (mode:100644 sha1:3b93e5d750ebf8452ea1264251c5b55cc89f48f8)
+++ uncommitted/fs/namespace.c  (mode:100644)
@@ -42,7 +42,7 @@
 static struct list_head *mount_hashtable;
 static int hash_mask, hash_bits;
 static kmem_cache_t *mnt_cache; 
-
+struct mounts_stat_struct mounts_stat;
 static inline unsigned long hash(struct vfsmount *mnt, struct dentry *dentry)
 {
 	unsigned long tmp = ((unsigned long) mnt / L1_CACHE_BYTES);
@@ -51,10 +51,44 @@
 	return tmp & hash_mask;
 }
 
-struct vfsmount *alloc_vfsmnt(const char *name)
+static inline int inc_nr_mounts(struct user_struct *owner)
 {
-	struct vfsmount *mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL); 
-	if (mnt) {
+	int err = 0;
+	spin_lock(&vfsmount_lock);
+	if (owner &&
+	    (mounts_stat.nr_mounts >= mounts_stat.max_mounts ||
+	     owner->mounts >= current->signal->rlim[RLIMIT_MOUNTS].rlim_cur))
+		err = -EPERM;
+	else {
+		mounts_stat.nr_mounts++;
+		if (owner)
+			owner->mounts++;
+	}
+	spin_unlock(&vfsmount_lock);
+	return err;
+}
+
+static inline void dec_nr_mounts(struct user_struct *owner)
+{
+	spin_lock(&vfsmount_lock);
+	mounts_stat.nr_mounts--;
+	if (owner)
+		owner->mounts--;
+	spin_unlock(&vfsmount_lock);
+}
+
+struct vfsmount *alloc_vfsmnt(const char *name, struct user_struct *owner)
+{
+	struct vfsmount *mnt;
+	int err = inc_nr_mounts(owner);
+	if (err)
+		return ERR_PTR(err);
+
+	mnt = kmem_cache_alloc(mnt_cache, GFP_KERNEL);
+	if (!mnt) {
+		dec_nr_mounts(owner);
+		return ERR_PTR(-ENOMEM);
+	} else {
 		memset(mnt, 0, sizeof(struct vfsmount));
 		atomic_set(&mnt->mnt_count,1);
 		INIT_LIST_HEAD(&mnt->mnt_hash);
@@ -70,14 +104,21 @@
 				mnt->mnt_devname = newname;
 			}
 		}
+		if (owner) {
+			atomic_inc(&owner->__count);
+			mnt->mnt_owner = owner;
+		}
 	}
 	return mnt;
 }
 
 void free_vfsmnt(struct vfsmount *mnt)
 {
+	struct user_struct *owner = mnt->mnt_owner;
 	kfree(mnt->mnt_devname);
 	kmem_cache_free(mnt_cache, mnt);
+	dec_nr_mounts(owner);
+	free_uid(owner);
 }
 
 /*
@@ -148,13 +189,16 @@
 }
 
 static struct vfsmount *
-clone_mnt(struct vfsmount *old, struct dentry *root)
+clone_mnt(struct vfsmount *old, struct dentry *root, struct user_struct *owner)
 {
 	struct super_block *sb = old->mnt_sb;
-	struct vfsmount *mnt = alloc_vfsmnt(old->mnt_devname);
+	struct vfsmount *mnt = alloc_vfsmnt(old->mnt_devname, owner);
 
-	if (mnt) {
+	if (!IS_ERR(mnt)) {
 		mnt->mnt_flags = old->mnt_flags;
+		/* Unprivileged mounts require NOSUID and NODEV */
+		if (owner)
+			mnt->mnt_flags |= MNT_NOSUID | MNT_NODEV;
 		atomic_inc(&sb->s_active);
 		mnt->mnt_sb = sb;
 		mnt->mnt_root = dget(root);
@@ -252,6 +296,8 @@
 		if (mnt->mnt_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
 	}
+	if (mnt->mnt_owner)
+		seq_printf(m, ",owner=%i", mnt->mnt_owner->uid);
 	if (mnt->mnt_sb->s_op->show_options)
 		err = mnt->mnt_sb->s_op->show_options(m, mnt);
 	seq_puts(m, " 0 0\n");
@@ -480,7 +526,8 @@
 		goto dput_and_out;
 
 	retval = -EPERM;
-	if (!capable(CAP_SYS_ADMIN))
+	if (!capable(CAP_SYS_ADMIN) && (nd.mnt->mnt_owner != current->user ||
+					(flags & MNT_FORCE)))
 		goto dput_and_out;
 
 	retval = do_umount(nd.mnt, flags);
@@ -503,22 +550,21 @@
 
 #endif
 
-static int mount_is_safe(struct nameidata *nd)
+static struct user_struct *mount_is_safe(struct nameidata *nd)
 {
 	if (capable(CAP_SYS_ADMIN))
-		return 0;
-	return -EPERM;
-#ifdef notyet
-	if (S_ISLNK(nd->dentry->d_inode->i_mode))
-		return -EPERM;
+		return NULL;
+
+	if (!S_ISDIR(nd->dentry->d_inode->i_mode) &&
+	    !S_ISREG(nd->dentry->d_inode->i_mode))
+		return ERR_PTR(-EPERM);
 	if (nd->dentry->d_inode->i_mode & S_ISVTX) {
-		if (current->uid != nd->dentry->d_inode->i_uid)
-			return -EPERM;
+		if (current->fsuid != nd->dentry->d_inode->i_uid)
+			return ERR_PTR(-EPERM);
 	}
 	if (permission(nd->dentry->d_inode, MAY_WRITE, nd))
-		return -EPERM;
-	return 0;
-#endif
+		return ERR_PTR(-EPERM);
+	return current->user;
 }
 
 static int
@@ -533,15 +579,16 @@
 	}
 }
 
-static struct vfsmount *copy_tree(struct vfsmount *mnt, struct dentry *dentry)
+static struct vfsmount *copy_tree(struct vfsmount *mnt, struct dentry *dentry,
+				  struct user_struct *owner)
 {
 	struct vfsmount *res, *p, *q, *r, *s;
 	struct list_head *h;
 	struct nameidata nd;
 
-	res = q = clone_mnt(mnt, dentry);
-	if (!q)
-		goto Enomem;
+	res = q = clone_mnt(mnt, dentry, owner);
+	if (IS_ERR(q))
+		goto out_error;
 	q->mnt_mountpoint = mnt->mnt_mountpoint;
 
 	p = mnt;
@@ -558,9 +605,9 @@
 			p = s;
 			nd.mnt = q;
 			nd.dentry = p->mnt_mountpoint;
-			q = clone_mnt(p, p->mnt_root);
-			if (!q)
-				goto Enomem;
+			q = clone_mnt(p, p->mnt_root, owner);
+			if (IS_ERR(q))
+				goto out_error;
 			spin_lock(&vfsmount_lock);
 			list_add_tail(&q->mnt_list, &res->mnt_list);
 			attach_mnt(q, &nd);
@@ -568,13 +615,13 @@
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
@@ -620,11 +667,12 @@
  */
 static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
 {
+	int err;
 	struct nameidata old_nd;
 	struct vfsmount *mnt = NULL;
-	int err = mount_is_safe(nd);
-	if (err)
-		return err;
+	struct user_struct *owner = mount_is_safe(nd);
+	if (IS_ERR(owner))
+		return PTR_ERR(owner);
 	if (!old_name || !*old_name)
 		return -EINVAL;
 	err = path_lookup(old_name, LOOKUP_FOLLOW, &old_nd);
@@ -634,11 +682,14 @@
 	down_write(&current->namespace->sem);
 	err = -EINVAL;
 	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
-		err = -ENOMEM;
 		if (recurse)
-			mnt = copy_tree(old_nd.mnt, old_nd.dentry);
+			mnt = copy_tree(old_nd.mnt, old_nd.dentry, owner);
 		else
-			mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+			mnt = clone_mnt(old_nd.mnt, old_nd.dentry, owner);
+		if (IS_ERR(mnt)) {
+			err = PTR_ERR(mnt);
+			goto out;
+		}
 	}
 
 	if (mnt) {
@@ -656,6 +707,7 @@
 			mntput(mnt);
 	}
 
+ out:
 	up_write(&current->namespace->sem);
 	path_release(&old_nd);
 	return err;
@@ -1066,6 +1118,7 @@
 	struct vfsmount *rootmnt = NULL, *pwdmnt = NULL, *altrootmnt = NULL;
 	struct fs_struct *fs = tsk->fs;
 	struct vfsmount *p, *q;
+	int err;
 
 	if (!namespace)
 		return 0;
@@ -1075,11 +1128,11 @@
 	if (!(flags & CLONE_NEWNS))
 		return 0;
 
-	if (!capable(CAP_SYS_ADMIN)) {
-		put_namespace(namespace);
-		return -EPERM;
-	}
+	err = -EPERM;
+	if (!capable(CAP_SYS_ADMIN))
+		goto out;
 
+	err = -ENOMEM;
 	new_ns = kmalloc(sizeof(struct namespace), GFP_KERNEL);
 	if (!new_ns)
 		goto out;
@@ -1090,8 +1143,9 @@
 
 	down_write(&tsk->namespace->sem);
 	/* First pass: copy the tree topology */
-	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root);
-	if (!new_ns->root) {
+	new_ns->root = copy_tree(namespace->root, namespace->root->mnt_root, 0);
+	if (IS_ERR(new_ns->root)) {
+		err = PTR_ERR(new_ns->root);
 		up_write(&tsk->namespace->sem);
 		kfree(new_ns);
 		goto out;
@@ -1142,7 +1196,7 @@
 
 out:
 	put_namespace(namespace);
-	return -ENOMEM;
+	return err;
 }
 
 asmlinkage long sys_mount(char __user * dev_name, char __user * dir_name,
Index: fs/super.c
===================================================================
--- a6d962c4f559f3644678574a66310084fd13d130/fs/super.c  (mode:100644 sha1:3a1b8ca04ba601b37ffa5dadb8f9695272952e39)
+++ uncommitted/fs/super.c  (mode:100644)
@@ -797,7 +797,7 @@
 do_kern_mount(const char *fstype, int flags, const char *name, void *data)
 {
 	struct file_system_type *type = get_fs_type(fstype);
-	struct super_block *sb = ERR_PTR(-ENOMEM);
+	struct super_block *sb;
 	struct vfsmount *mnt;
 	int error;
 	char *secdata = NULL;
@@ -805,9 +805,11 @@
 	if (!type)
 		return ERR_PTR(-ENODEV);
 
-	mnt = alloc_vfsmnt(name);
-	if (!mnt)
-		goto out;
+	mnt = alloc_vfsmnt(name, NULL);
+	if (IS_ERR(mnt)) {
+		put_filesystem(type);
+		return mnt;
+	}
 
 	if (data) {
 		secdata = alloc_secdata();
@@ -845,7 +847,6 @@
 	free_secdata(secdata);
 out_mnt:
 	free_vfsmnt(mnt);
-out:
 	put_filesystem(type);
 	return (struct vfsmount *)sb;
 }
Index: include/asm-generic/resource.h
===================================================================
--- a6d962c4f559f3644678574a66310084fd13d130/include/asm-generic/resource.h  (mode:100644 sha1:cfe3692b23e580a01ccf0ad7a9102e854c8be792)
+++ uncommitted/include/asm-generic/resource.h  (mode:100644)
@@ -44,8 +44,9 @@
 #define RLIMIT_NICE		13	/* max nice prio allowed to raise to
 					   0-39 for nice level 19 .. -20 */
 #define RLIMIT_RTPRIO		14	/* maximum realtime priority */
+#define RLIMIT_MOUNTS		15	/* maximum number of mounts for user */
 
-#define RLIM_NLIMITS		15
+#define RLIM_NLIMITS		16
 
 /*
  * SuS says limits have to be unsigned.
@@ -86,6 +87,7 @@
 	[RLIMIT_MSGQUEUE]	= {   MQ_BYTES_MAX,   MQ_BYTES_MAX },	\
 	[RLIMIT_NICE]		= { 0, 0 },				\
 	[RLIMIT_RTPRIO]		= { 0, 0 },				\
+	[RLIMIT_MOUNTS]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
 }
 
 #endif	/* __KERNEL__ */
Index: include/linux/fs.h
===================================================================
--- a6d962c4f559f3644678574a66310084fd13d130/include/linux/fs.h  (mode:100644 sha1:4edba067a7178103f78544717a91ef98dae7994d)
+++ uncommitted/include/linux/fs.h  (mode:100644)
@@ -36,6 +36,12 @@
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
Index: include/linux/mount.h
===================================================================
--- a6d962c4f559f3644678574a66310084fd13d130/include/linux/mount.h  (mode:100644 sha1:8b8d3b9beefdc4f91cfa12d9275976408590cbcc)
+++ uncommitted/include/linux/mount.h  (mode:100644)
@@ -33,6 +33,7 @@
 	int mnt_flags;
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	char *mnt_devname;		/* Name of device e.g. /dev/dsk/hda1 */
+	struct user_struct *mnt_owner;	/* Mount owner */
 	struct list_head mnt_list;
 	struct list_head mnt_fslink;	/* link in fs-specific expiry list */
 	struct namespace *mnt_namespace; /* containing namespace */
@@ -64,7 +65,8 @@
 }
 
 extern void free_vfsmnt(struct vfsmount *mnt);
-extern struct vfsmount *alloc_vfsmnt(const char *name);
+extern struct vfsmount *alloc_vfsmnt(const char *name,
+				     struct user_struct *owner);
 extern struct vfsmount *do_kern_mount(const char *fstype, int flags,
 				      const char *name, void *data);
 
Index: include/linux/sched.h
===================================================================
--- a6d962c4f559f3644678574a66310084fd13d130/include/linux/sched.h  (mode:100644 sha1:5f868a5885811571fdc701037bf7b09b40a746b8)
+++ uncommitted/include/linux/sched.h  (mode:100644)
@@ -408,6 +408,9 @@
 	unsigned long mq_bytes;	/* How many bytes can be allocated to mqueue? */
 	unsigned long locked_shm; /* How many pages of mlocked shm ? */
 
+	/* protected by vfsmount_lock */
+	unsigned long mounts;	/* Number of mounts this user owns */
+
 #ifdef CONFIG_KEYS
 	struct key *uid_keyring;	/* UID specific keyring */
 	struct key *session_keyring;	/* UID's default session keyring */
Index: include/linux/sysctl.h
===================================================================
--- a6d962c4f559f3644678574a66310084fd13d130/include/linux/sysctl.h  (mode:100644 sha1:772998147e3ef989988c184520f6dacba9fb601d)
+++ uncommitted/include/linux/sysctl.h  (mode:100644)
@@ -667,8 +667,8 @@
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
Index: kernel/sysctl.c
===================================================================
--- a6d962c4f559f3644678574a66310084fd13d130/kernel/sysctl.c  (mode:100644 sha1:701d12c6306844136a8e525902d06082733127fb)
+++ uncommitted/kernel/sysctl.c  (mode:100644)
@@ -885,6 +885,22 @@
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

