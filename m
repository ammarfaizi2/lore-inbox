Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVA3OOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVA3OOT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 09:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVA3OOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 09:14:19 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:39399 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261704AbVA3OLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 09:11:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:message-id:to:subject:cc;
        b=ZlCwsITzX0fqTBavJZBwbP5RH+CuqW3hjUc+IptyxGCRognxsVHSLnBAQN7rzzZl66FuiamuP7P72WIjidO4f14mkcnnk22q9aUEyxNm0PDacohKBLa0vl5Y8/l24dyIjGZKoOl0sF2xRHHum5FW8bMCN1xapYUuWndad2O+0yc=
Date: Sun, 30 Jan 2005 15:11:31 +0100
From: luca.barbieri@gmail.com
Message-Id: <200501301411.j0UEBVbP007784@lb-desktop.lb.lan>
To: viro@parcelfarce.linux.theplanet.co.uk
Subject: [RFC] [PATCH] Per-mountpoint read-only and noatime revisited
Cc: linux-kernel@vger.kernel.org, luca.barbieri@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements per-mountpoint readonly, noatime and
nodiratime flags.

This is the first release of the patch and I'm seeking feedback from
the VFS maintainer on whether it is acceptable in principle and which
modifications, if any, I should make (in addition to updating to the
latest bk).

The goals of this patches are the same goals of Herbert Poetzl's ones
(see
http://groups-beta.google.com/group/linux.kernel/browse_frm/thread/46f6ca7ffeac184f/dd31c0959a614cac
and
http://groups-beta.google.com/group/linux.kernel/browse_frm/thread/5d6e8bf49925a180/f2181c51e78b8d56),
but the implementation is very different, although originally based on
his one, and I believe that it addresses the arguments raised against
Poetzl's patches.

In particular, rather than adding extra checks, I modify all calls to
IS_RDONLY, IS_NOATIME and IS_NODIRATIME with ones to a new ..._MNT
macro that makes use of the new flags. All the function calls leading
to the IS_* macro call are changed to pass the struct vfsmount*
through.

Furthermore, this patch adds the new functionality as new mount flags,
rather than overloading the existing per-superblock flags, thus
maintaining backwards compatibility and not breaking remounts or
altering normal bind mount behavior. 

On the other hand, unlike Poetzl's patch, my patch changes the
filesystem interface, and will break all out-of-tree filesystems and
modules using vfs_* functions.

In some places the new constant MNT_IGNORE is passed instead of a
struct vfsmount* (the constant is there for clarity and
greppability). All such places either lead to a permission() call
without the MAY_WRITE flag (thus not calling IS_RDONLY), have checks
before them, are per-superblock operations or are one of the issues
described in the next paragraph.

The known issues are:
- lack of support for XFS, due to my inability to figure out how to
implement it: XFS mounts will fully or partially ignore the new
per-mountpoints flags.
- autofs4 could be ignoring per-mountpoint noatime: this is unclear
but very minor
- NFS server should work but I'm not sure if the patch is fully
correct

The first patch adds the base code for the mount interface and macros
and the second patch modifies everything to use the new macros.  The
util-linux patch adds userspace support.

In the first patch, I augment the per-superblock s_files list with
per-mountpoint mnt_files list and a s_mnts list of mountpoints for
each superblock; this is done to allow remounting mountpoints
read-only.  Furthermore, the mount interfaces are changed to
accomodate the new options and new macros are defined.

In the second patch, the prototypes for fs operations setxattr,
permission and the xattr operation set are changed and core code along
with all filesystems are modified to support the new features.

The util-linux patch is very simple and just adds the flags.

Patches are against 2.6.10: I'll update them if they are considered
acceptable.

The first kernel patch and the util-linux patch follow inline, while
the second patch is gzipped and attached since it is about 120KB
uncompressed.


First patch:

diff --exclude-from=/home/lb/pers/input/exclude -urNdp --exclude-from=/home/lb/pers/input/exclude-linux /home/lb/gen/src/linux-2.6.10-pre-bme/fs/dquot.c ./fs/dquot.c
--- /home/lb/gen/src/linux-2.6.10-pre-bme/fs/dquot.c	2004-12-24 22:35:14.000000000 +0100
+++ ./fs/dquot.c	2005-01-27 16:29:58.000000000 +0100
@@ -659,11 +659,11 @@ static int dqinit_needed(struct inode *i
 /* This routine is guarded by dqonoff_sem semaphore */
 static void add_dquot_ref(struct super_block *sb, int type)
 {
-	struct list_head *p;
+	struct list_head *mp, *p;
 
 restart:
 	file_list_lock();
-	list_for_each(p, &sb->s_files) {
+	for_each_sfile(p, mp, sb) {
 		struct file *filp = list_entry(p, struct file, f_list);
 		struct inode *inode = filp->f_dentry->d_inode;
 		if (filp->f_mode & FMODE_WRITE && dqinit_needed(inode, type)) {
diff --exclude-from=/home/lb/pers/input/exclude -urNdp --exclude-from=/home/lb/pers/input/exclude-linux /home/lb/gen/src/linux-2.6.10-pre-bme/fs/file_table.c ./fs/file_table.c
--- /home/lb/gen/src/linux-2.6.10-pre-bme/fs/file_table.c	2004-12-24 22:33:50.000000000 +0100
+++ ./fs/file_table.c	2005-01-27 16:29:58.000000000 +0100
@@ -215,13 +215,12 @@ void file_kill(struct file *file)
 	}
 }
 
-int fs_may_remount_ro(struct super_block *sb)
+int __list_may_remount_ro(struct list_head* list)
 {
 	struct list_head *p;
 
 	/* Check that no files are currently opened for writing. */
-	file_list_lock();
-	list_for_each(p, &sb->s_files) {
+	list_for_each(p, list) {
 		struct file *file = list_entry(p, struct file, f_list);
 		struct inode *inode = file->f_dentry->d_inode;
 
@@ -233,6 +232,33 @@ int fs_may_remount_ro(struct super_block
 		if (S_ISREG(inode->i_mode) && (file->f_mode & FMODE_WRITE))
 			goto too_bad;
 	}
+	return 1; /* Tis' cool bro. */
+too_bad:
+	return 0;	
+}
+
+int mnt_may_remount_ro(struct vfsmount *mnt)
+{
+	int res;
+
+	file_list_lock();
+	res = __list_may_remount_ro(&mnt->mnt_files);
+	file_list_unlock();
+
+	return res;
+}
+
+int fs_may_remount_ro(struct super_block *sb)
+{
+	struct vfsmount* mnt;
+
+	file_list_lock();
+	if(!__list_may_remount_ro(&sb->s_files))
+		goto too_bad;
+	list_for_each_entry(mnt, &sb->s_mnts, mnt_sblist) {
+		if(!__list_may_remount_ro(&mnt->mnt_files))
+			goto too_bad;
+	}
 	file_list_unlock();
 	return 1; /* Tis' cool bro. */
 too_bad:
@@ -240,6 +266,44 @@ too_bad:
 	return 0;
 }
 
+
+/**
+ *	mark_files_ro
+ *	@sb: superblock in question
+ *
+ *	All files are marked read/only.  We don't care about pending
+ *	delete files so this should be used in 'force' mode only
+ */
+
+static void __list_mark_files_ro(struct list_head *list)
+{
+	struct file *f;
+
+	list_for_each_entry(f, list, f_list) {
+		if (S_ISREG(f->f_dentry->d_inode->i_mode) && file_count(f))
+			f->f_mode &= ~FMODE_WRITE;
+	}
+}
+
+void mnt_mark_files_ro(struct vfsmount *mnt)
+{
+	file_list_lock();
+	__list_mark_files_ro(&mnt->mnt_files);
+	file_list_unlock();
+}
+
+void mark_files_ro(struct super_block *sb)
+{
+	struct vfsmount *mnt;
+
+	file_list_lock();
+	__list_mark_files_ro(&sb->s_files);
+	list_for_each_entry(mnt, &sb->s_mnts, mnt_sblist) {
+		__list_mark_files_ro(&mnt->mnt_files);
+	}
+	file_list_unlock();
+}
+
 void __init files_init(unsigned long mempages)
 { 
 	int n; 
diff --exclude-from=/home/lb/pers/input/exclude -urNdp --exclude-from=/home/lb/pers/input/exclude-linux /home/lb/gen/src/linux-2.6.10-pre-bme/fs/namespace.c ./fs/namespace.c
--- /home/lb/gen/src/linux-2.6.10-pre-bme/fs/namespace.c	2004-12-24 22:35:01.000000000 +0100
+++ ./fs/namespace.c	2005-01-27 16:29:58.000000000 +0100
@@ -61,7 +61,9 @@ struct vfsmount *alloc_vfsmnt(const char
 		INIT_LIST_HEAD(&mnt->mnt_child);
 		INIT_LIST_HEAD(&mnt->mnt_mounts);
 		INIT_LIST_HEAD(&mnt->mnt_list);
+		INIT_LIST_HEAD(&mnt->mnt_sblist);
 		INIT_LIST_HEAD(&mnt->mnt_fslink);
+		INIT_LIST_HEAD(&mnt->mnt_files);
 		if (name) {
 			int size = strlen(name)+1;
 			char *newname = kmalloc(size, GFP_KERNEL);
@@ -157,6 +159,9 @@ clone_mnt(struct vfsmount *old, struct d
 		mnt->mnt_flags = old->mnt_flags;
 		atomic_inc(&sb->s_active);
 		mnt->mnt_sb = sb;
+		file_list_lock();
+		list_add_tail(&mnt->mnt_sblist, &sb->s_mnts);
+		file_list_unlock();
 		mnt->mnt_root = dget(root);
 		mnt->mnt_mountpoint = mnt->mnt_root;
 		mnt->mnt_parent = mnt;
@@ -175,6 +180,9 @@ clone_mnt(struct vfsmount *old, struct d
 void __mntput(struct vfsmount *mnt)
 {
 	struct super_block *sb = mnt->mnt_sb;
+	file_list_lock();
+	list_del(&mnt->mnt_sblist);
+	file_list_unlock();
 	dput(mnt->mnt_root);
 	free_vfsmnt(mnt);
 	deactivate_super(sb);
@@ -234,6 +242,9 @@ static int show_vfsmnt(struct seq_file *
 		{ MNT_NOSUID, ",nosuid" },
 		{ MNT_NODEV, ",nodev" },
 		{ MNT_NOEXEC, ",noexec" },
+		{ MNT_RDONLY, ",mnt_ro" },
+		{ MNT_NOATIME, ",mnt_noatime" },
+		{ MNT_NODIRATIME, ",mnt_nodiratime" },
 		{ 0, NULL }
 	};
 	struct proc_fs_info *fs_infop;
@@ -661,6 +678,20 @@ static int do_loopback(struct nameidata 
 	return err;
 }
 
+static int do_remount_mnt(struct vfsmount* mnt, int mnt_flags)
+{
+	if((mnt_flags & MNT_RDONLY) && !(mnt->mnt_flags & MNT_RDONLY))
+	{
+		if (mnt_flags & MNT_RDONLY_FORCE)
+			mnt_mark_files_ro(mnt);
+		else if (!mnt_may_remount_ro(mnt))
+			return -EBUSY;
+	}
+		
+	mnt->mnt_flags = mnt_flags &~ MNT_RDONLY_FORCE;
+	return 0;
+}
+
 /*
  * change filesystem flags. dir should be a physical root of filesystem.
  * If you've mounted a non-root directory somewhere and want to do remount
@@ -685,7 +716,7 @@ static int do_remount(struct nameidata *
 	down_write(&sb->s_umount);
 	err = do_remount_sb(sb, flags, data, 0);
 	if (!err)
-		nd->mnt->mnt_flags=mnt_flags;
+		err = do_remount_mnt(nd->mnt, mnt_flags);
 	up_write(&sb->s_umount);
 	if (!err)
 		security_sb_post_remount(nd->mnt, flags, data);
@@ -806,7 +837,7 @@ int do_add_mount(struct vfsmount *newmnt
 	if (S_ISLNK(newmnt->mnt_root->d_inode->i_mode))
 		goto unlock;
 
-	newmnt->mnt_flags = mnt_flags;
+	newmnt->mnt_flags = mnt_flags &~ MNT_RDONLY_FORCE;
 	err = graft_tree(newmnt, nd);
 
 	if (err == 0 && fslist) {
@@ -1033,7 +1064,15 @@ long do_mount(char * dev_name, char * di
 		mnt_flags |= MNT_NODEV;
 	if (flags & MS_NOEXEC)
 		mnt_flags |= MNT_NOEXEC;
-	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_ACTIVE);
+	if (flags & MS_MNT_RDONLY)
+		mnt_flags |= MNT_RDONLY;
+	if (flags & MS_MNT_RDONLY_FORCE)
+		mnt_flags |= MNT_RDONLY_FORCE;
+	if (flags & MS_MNT_NOATIME)
+		mnt_flags |= MNT_NOATIME;
+	if (flags & MS_MNT_NODIRATIME)
+		mnt_flags |= MNT_NODIRATIME;
+	flags &= ~(MS_NOSUID | MS_NOEXEC | MS_NODEV | MS_ACTIVE | MS_MNT_RDONLY | MS_MNT_RDONLY_FORCE | MS_MNT_NOATIME | MS_MNT_NODIRATIME);
 
 	/* ... and get the mountpoint */
 	retval = path_lookup(dir_name, LOOKUP_FOLLOW, &nd);
diff --exclude-from=/home/lb/pers/input/exclude -urNdp --exclude-from=/home/lb/pers/input/exclude-linux /home/lb/gen/src/linux-2.6.10-pre-bme/fs/proc/generic.c ./fs/proc/generic.c
--- /home/lb/gen/src/linux-2.6.10-pre-bme/fs/proc/generic.c	2004-12-24 22:35:40.000000000 +0100
+++ ./fs/proc/generic.c	2005-01-27 16:29:58.000000000 +0100
@@ -512,14 +512,14 @@ static int proc_register(struct proc_dir
  */
 static void proc_kill_inodes(struct proc_dir_entry *de)
 {
-	struct list_head *p;
+	struct list_head *mp, *p;
 	struct super_block *sb = proc_mnt->mnt_sb;
 
 	/*
 	 * Actually it's a partial revoke().
 	 */
 	file_list_lock();
-	list_for_each(p, &sb->s_files) {
+	for_each_sfile(p, mp, sb) {
 		struct file * filp = list_entry(p, struct file, f_list);
 		struct dentry * dentry = filp->f_dentry;
 		struct inode * inode;
diff --exclude-from=/home/lb/pers/input/exclude -urNdp --exclude-from=/home/lb/pers/input/exclude-linux /home/lb/gen/src/linux-2.6.10-pre-bme/fs/super.c ./fs/super.c
--- /home/lb/gen/src/linux-2.6.10-pre-bme/fs/super.c	2004-12-24 22:34:33.000000000 +0100
+++ ./fs/super.c	2005-01-27 16:29:58.000000000 +0100
@@ -68,6 +68,7 @@ static struct super_block *alloc_super(v
 		INIT_LIST_HEAD(&s->s_dirty);
 		INIT_LIST_HEAD(&s->s_io);
 		INIT_LIST_HEAD(&s->s_files);
+		INIT_LIST_HEAD(&s->s_mnts);
 		INIT_LIST_HEAD(&s->s_instances);
 		INIT_HLIST_HEAD(&s->s_anon);
 		init_rwsem(&s->s_umount);
@@ -492,26 +493,6 @@ out:
 }
 
 /**
- *	mark_files_ro
- *	@sb: superblock in question
- *
- *	All files are marked read/only.  We don't care about pending
- *	delete files so this should be used in 'force' mode only
- */
-
-static void mark_files_ro(struct super_block *sb)
-{
-	struct file *f;
-
-	file_list_lock();
-	list_for_each_entry(f, &sb->s_files, f_list) {
-		if (S_ISREG(f->f_dentry->d_inode->i_mode) && file_count(f))
-			f->f_mode &= ~FMODE_WRITE;
-	}
-	file_list_unlock();
-}
-
-/**
  *	do_remount_sb - asks filesystem to change mount options.
  *	@sb:	superblock in question
  *	@flags:	numeric part of options
@@ -828,6 +809,9 @@ do_kern_mount(const char *fstype, int fl
  	if (error)
  		goto out_sb;
 	mnt->mnt_sb = sb;
+	file_list_lock();
+	list_add_tail(&mnt->mnt_sblist, &sb->s_mnts);
+	file_list_unlock();
 	mnt->mnt_root = dget(sb->s_root);
 	mnt->mnt_mountpoint = sb->s_root;
 	mnt->mnt_parent = mnt;
diff --exclude-from=/home/lb/pers/input/exclude -urNdp --exclude-from=/home/lb/pers/input/exclude-linux /home/lb/gen/src/linux-2.6.10-pre-bme/include/linux/fs.h ./include/linux/fs.h
--- /home/lb/gen/src/linux-2.6.10-pre-bme/include/linux/fs.h	2004-12-24 22:34:27.000000000 +0100
+++ ./include/linux/fs.h	2005-01-27 16:36:24.000000000 +0100
@@ -18,6 +18,9 @@
 #include <linux/cache.h>
 #include <linux/prio_tree.h>
 #include <linux/kobject.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/prefetch.h>
 #include <asm/atomic.h>
 
 struct iovec;
@@ -124,6 +127,10 @@ extern int dir_notify_enable;
 #define MS_VERBOSE	32768
 #define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
 #define MS_ONE_SECOND	(1<<17)	/* fs has 1 sec a/m/ctime resolution */
+#define MS_MNT_RDONLY	(1<<18)
+#define MS_MNT_RDONLY_FORCE	(1<<19)
+#define MS_MNT_NOATIME		(1<<20)
+#define MS_MNT_NODIRATIME	(1<<21)
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
@@ -166,7 +173,9 @@ extern int dir_notify_enable;
  */
 #define __IS_FLG(inode,flg) ((inode)->i_sb->s_flags & (flg))
 
-#define IS_RDONLY(inode) ((inode)->i_sb->s_flags & MS_RDONLY)
+#define MNT_IGNORE 0
+#define IS_RDONLY(inode)	__IS_FLG(inode, MS_RDONLY)
+#define IS_RDONLY_MNT(inode, mnt) (IS_RDONLY(inode) || MNT_IS_RDONLY(mnt))
 #define IS_SYNC(inode)		(__IS_FLG(inode, MS_SYNCHRONOUS) || \
 					((inode)->i_flags & S_SYNC))
 #define IS_DIRSYNC(inode)	(__IS_FLG(inode, MS_SYNCHRONOUS|MS_DIRSYNC) || \
@@ -177,7 +187,9 @@ extern int dir_notify_enable;
 #define IS_APPEND(inode)	((inode)->i_flags & S_APPEND)
 #define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
 #define IS_NOATIME(inode)	(__IS_FLG(inode, MS_NOATIME) || ((inode)->i_flags & S_NOATIME))
+#define IS_NOATIME_MNT(inode, mnt)	(IS_NOATIME(inode) || MNT_IS_NOATIME(mnt))
 #define IS_NODIRATIME(inode)	__IS_FLG(inode, MS_NODIRATIME)
+#define IS_NODIRATIME_MNT(inode, mnt)	(IS_NODIRATIME(inode) || MNT_IS_NODIRATIME(mnt))
 #define IS_POSIXACL(inode)	__IS_FLG(inode, MS_POSIXACL)
 #define IS_ONE_SECOND(inode)	__IS_FLG(inode, MS_ONE_SECOND)
 
@@ -780,6 +792,7 @@ struct super_block {
 	struct list_head	s_io;		/* parked for writeback */
 	struct hlist_head	s_anon;		/* anonymous dentries for (nfs) exporting */
 	struct list_head	s_files;
+	struct list_head	s_mnts;
 
 	struct block_device	*s_bdev;
 	struct list_head	s_instances;
@@ -799,6 +812,10 @@ struct super_block {
 	struct semaphore s_vfs_rename_sem;	/* Kludge */
 };
 
+#define for_each_sfile(p, mp, sb) for (mp = 0; mp != &(sb)->s_mnts; \
+                                       mp = mp ? mp->next : (sb)->s_mnts.next, prefetch(mp->next)) \
+                                     list_for_each(p, mp ? &container_of(mp, struct vfsmount, mnt_sblist)->mnt_files : &(sb)->s_files)
+
 /*
  * Snapshotting support.
  */
@@ -1316,6 +1332,10 @@ extern struct file_operations write_pipe
 extern struct file_operations rdwr_pipe_fops;
 
 extern int fs_may_remount_ro(struct super_block *);
+extern int mnt_may_remount_ro(struct vfsmount *);
+
+extern void mark_files_ro(struct super_block *);
+extern void mnt_mark_files_ro(struct vfsmount *);
 
 /*
  * return READ, READA, or WRITE
diff --exclude-from=/home/lb/pers/input/exclude -urNdp --exclude-from=/home/lb/pers/input/exclude-linux /home/lb/gen/src/linux-2.6.10-pre-bme/include/linux/mount.h ./include/linux/mount.h
--- /home/lb/gen/src/linux-2.6.10-pre-bme/include/linux/mount.h	2004-12-24 22:33:51.000000000 +0100
+++ ./include/linux/mount.h	2005-01-27 16:29:58.000000000 +0100
@@ -19,6 +19,11 @@
 #define MNT_NOSUID	1
 #define MNT_NODEV	2
 #define MNT_NOEXEC	4
+#define MNT_RDONLY	8
+#define MNT_NOATIME	16
+#define MNT_NODIRATIME	32
+
+#define MNT_RDONLY_FORCE (1 << 31)
 
 struct vfsmount
 {
@@ -35,9 +40,15 @@ struct vfsmount
 	char *mnt_devname;		/* Name of device e.g. /dev/dsk/hda1 */
 	struct list_head mnt_list;
 	struct list_head mnt_fslink;	/* link in fs-specific expiry list */
+	struct list_head mnt_sblist;
+	struct list_head mnt_files;
 	struct namespace *mnt_namespace; /* containing namespace */
 };
 
+#define	MNT_IS_RDONLY(m)	((m) && ((m)->mnt_flags & MNT_RDONLY))
+#define	MNT_IS_NOATIME(m)	((m) && ((m)->mnt_flags & MNT_NOATIME))
+#define	MNT_IS_NODIRATIME(m)	((m) && ((m)->mnt_flags & MNT_NODIRATIME))
+
 static inline struct vfsmount *mntget(struct vfsmount *mnt)
 {
 	if (mnt)
diff --exclude-from=/home/lb/pers/input/exclude -urNdp --exclude-from=/home/lb/pers/input/exclude-linux /home/lb/gen/src/linux-2.6.10-pre-bme/security/selinux/selinuxfs.c ./security/selinux/selinuxfs.c
--- /home/lb/gen/src/linux-2.6.10-pre-bme/security/selinux/selinuxfs.c	2004-12-24 22:35:50.000000000 +0100
+++ ./security/selinux/selinuxfs.c	2005-01-27 16:29:59.000000000 +0100
@@ -773,7 +773,7 @@ static struct file_operations sel_commit
  * fs/proc/generic.c proc_kill_inodes */
 static void sel_remove_bools(struct dentry *de)
 {
-	struct list_head *p, *node;
+	struct list_head *mp, *p, *node;
 	struct super_block *sb = de->d_sb;
 
 	spin_lock(&dcache_lock);
@@ -796,7 +796,7 @@ static void sel_remove_bools(struct dent
 	spin_unlock(&dcache_lock);
 
 	file_list_lock();
-	list_for_each(p, &sb->s_files) {
+	for_each_sfile(p, mp, sb) {
 		struct file * filp = list_entry(p, struct file, f_list);
 		struct dentry * dentry = filp->f_dentry;
 
diff --exclude-from=/home/lb/pers/input/exclude -urNdp --exclude-from=/home/lb/pers/input/exclude-linux /home/lb/gen/src/linux-2.6.10-pre-bme/fs/open.c ./fs/open.c
--- /home/lb/gen/src/linux-2.6.10-pre-bme/fs/open.c	2004-12-24 22:33:50.000000000 +0100
+++ ./fs/open.c	2005-01-27 16:29:58.000000000 +0100
@@ -795,7 +799,10 @@ struct file *dentry_open(struct dentry *
 	f->f_vfsmnt = mnt;
 	f->f_pos = 0;
 	f->f_op = fops_get(inode->i_fop);
-	file_move(f, &inode->i_sb->s_files);
+	if(mnt)
+		file_move(f, &mnt->mnt_files);
+	else
+		file_move(f, &inode->i_sb->s_files);
 
 	if (f->f_op && f->f_op->open) {
 		error = f->f_op->open(inode,f);


**********************************************************************
**********************************************************************
**********************************************************************
**********************************************************************
**********************************************************************
**********************************************************************

Util-linux patch:

diff --exclude-from=/home/lb/pers/input/exclude -urNdp /home/lb/gen/rpm/BUILD/util-linux-2.12p/mount/mount.c util-linux-bme/mount/mount.c
--- /home/lb/gen/rpm/BUILD/util-linux-2.12p/mount/mount.c       2005-01-25 14:13:31.000000000 +0100
+++ util-linux-bme/mount/mount.c        2005-01-25 14:44:24.000000000 +0100
@@ -168,6 +168,22 @@ static const struct opt_map opt_map[] =
   { "diratime",        0, 1, MS_NODIRATIME },  /* Update dir access times */
   { "nodiratime", 0, 0, MS_NODIRATIME },/* Do not update dir access times */
 #endif
+#ifdef MS_MNT_RDONLY
+  { "mnt_ro", 0, 0, MS_MNT_RDONLY },
+  { "mnt_rw", 0, 1, MS_MNT_RDONLY },
+#ifdef MS_MNT_RDONLY_FORCE
+  { "mnt_rof", 0, 0, MS_MNT_RDONLY | MS_MNT_RDONLY_FORCE },
+  { "mnt_ronf", 0, 1, MS_MNT_RDONLY_FORCE },
+#endif
+#endif
+#ifdef MS_MNT_NOATIME
+  { "mnt_atime",       0, 1, MS_MNT_NOATIME }, /* Update access time */
+  { "mnt_noatime",     0, 0, MS_MNT_NOATIME }, /* Do not update access time */
+#endif
+#ifdef MS_MNT_NODIRATIME
+  { "mnt_diratime",    0, 1, MS_MNT_NODIRATIME },      /* Update dir access times */
+  { "mnt_nodiratime", 0, 0, MS_MNT_NODIRATIME },/* Do not update dir access times */
+#endif
   { "kudzu", 0, 0, MS_COMMENT },                       /* Silently remove this option (backwards compat use only - deprecated) */
   { "managed", 0, 0, MS_COMMENT },                     /* Silently remove this option */
   { NULL,      0, 0, 0         }
diff --exclude-from=/home/lb/pers/input/exclude -urNdp /home/lb/gen/rpm/BUILD/util-linux-2.12p/mount/mount_constants.h util-linux-bme/mount/mount_constants.h
--- /home/lb/gen/rpm/BUILD/util-linux-2.12p/mount/mount_constants.h     2002-11-01 01:24:36.000000000 +0100
+++ util-linux-bme/mount/mount_constants.h      2005-01-25 14:43:35.000000000 +0100
@@ -57,6 +57,23 @@ if we have a stack or plain mount - moun
 #ifndef MS_VERBOSE
 #define MS_VERBOSE     0x8000  /* 32768 */
 #endif
+
+#ifndef MS_MNT_RDONLY
+#define MS_MNT_RDONLY  (1<<18)
+#endif
+
+#ifndef MS_MNT_RDONLY_FORCE
+#define MS_MNT_RDONLY_FORCE    (1<<19)
+#endif
+
+#ifndef MS_MNT_NOATIME
+#define MS_MNT_NOATIME         (1<<20)
+#endif
+
+#ifndef MS_MNT_NODIRATIME
+#define MS_MNT_NODIRATIME      (1<<21)
+#endif
+
 /*
  * Magic mount flag number. Had to be or-ed to the flag values.
  */

**********************************************************************
**********************************************************************
**********************************************************************
**********************************************************************
**********************************************************************
**********************************************************************

Second patch attached.


begin 664 bme_second.patch.gz
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
/?B,L6]_]/S1[Z85HVP$`
`
end
