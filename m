Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262126AbRETR4G>; Sun, 20 May 2001 13:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262133AbRETRz5>; Sun, 20 May 2001 13:55:57 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:23521 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262126AbRETRzm>;
	Sun, 20 May 2001 13:55:42 -0400
Date: Sun, 20 May 2001 13:55:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH][CFT] selective nosuid/noexec/nodev
Message-ID: <Pine.GSO.4.21.0105201322320.8940-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Folks, patch below (_completely_ untested) is a backport of
a neat stuff from namespace-patch.

	It does (OK, is supposed to do) the following: make noexec, nosuid
and nodev properties of vfsmount, not superblock.

	In other words, different instances of the same fs may differ in
these flags.

	It has quite a few lovely uses. Example:

I'm sick and tired of a little skript k1dd13 wannabe (who happens to be
a son of $BIG_BOSS and thus is a holy cow). I want to make his $HOME
noexec (all public writable places already are). I don't want to
bother with giving him a partition of his own and I don't want to screw
normal users.

Solution:
	mount --bind /home/little_wanker /home/little_wanker
	mount -o remount,noexec /home/little_wanker

Opposite examples (selectively allowing exec or suid on subtrees of
fs that is otherwise noexec/nosuid) are along the same lines.  We can
even do it for individual files ;-)

More serious applications may be in situations when we want to set a
chroot environment with selective (or global, for that matter)
removal/allowing suid/exec/dev without messing everything else.

	Patch is pretty straightforward - in call cases when we did
IS_NOSUID(), etc. we have relevant struct vfsmount, so we can check
->mnt_flags instead of ->s_flags. do_mount() separates these flags
from the rest and does the (obvious) right thing. That, and we have
to look both at ->mnt_sb->s_flags and ->mnt_flags when we read from
/proc/mounts.

	You are welcome to play with it ;-) Its equivalent works fine
in full namespace patch. This is a backport, and all I promise is
that it builds. Help with testing is welcome.

								Al

diff -urN S5-pre4/arch/sparc64/solaris/fs.c S5-pre4-noexe/arch/sparc64/solaris/fs.c
--- S5-pre4/arch/sparc64/solaris/fs.c	Thu Feb 22 06:47:53 2001
+++ S5-pre4-noexe/arch/sparc64/solaris/fs.c	Sun May 20 12:50:36 2001
@@ -406,21 +406,21 @@
 	u32	f_filler[16];
 };
 
-static int report_statvfs(struct inode *inode, u32 buf)
+static int report_statvfs(struct vfsmount *mnt, struct inode *inode, u32 buf)
 {
 	struct statfs s;
 	int error;
 	struct sol_statvfs *ss = (struct sol_statvfs *)A(buf);
 
-	error = vfs_statfs(inode->i_sb, &s);
+	error = vfs_statfs(mnt->mnt_sb, &s);
 	if (!error) {
-		const char *p = inode->i_sb->s_type->name;
+		const char *p = mnt->mnt_sb->s_type->name;
 		int i = 0;
 		int j = strlen (p);
 		
 		if (j > 15) j = 15;
 		if (IS_RDONLY(inode)) i = 1;
-		if (IS_NOSUID(inode)) i |= 2;
+		if (mnt->mnt_flags & MNT_NOSUID) i |= 2;
 		if (put_user (s.f_bsize, &ss->f_bsize)		||
 		    __put_user (0, &ss->f_frsize)		||
 		    __put_user (s.f_blocks, &ss->f_blocks)	||
@@ -440,21 +440,21 @@
 	return error;
 }
 
-static int report_statvfs64(struct inode *inode, u32 buf)
+static int report_statvfs64(struct vfsmount *mnt, struct inode *inode, u32 buf)
 {
 	struct statfs s;
 	int error;
 	struct sol_statvfs64 *ss = (struct sol_statvfs64 *)A(buf);
 			
-	error = vfs_statfs(inode->i_sb, &s);
+	error = vfs_statfs(mnt->mnt_sb, &s);
 	if (!error) {
-		const char *p = inode->i_sb->s_type->name;
+		const char *p = mnt->mnt_sb->s_type->name;
 		int i = 0;
 		int j = strlen (p);
 		
 		if (j > 15) j = 15;
 		if (IS_RDONLY(inode)) i = 1;
-		if (IS_NOSUID(inode)) i |= 2;
+		if (mnt->mnt_flags & MNT_NOSUID) i |= 2;
 		if (put_user (s.f_bsize, &ss->f_bsize)		||
 		    __put_user (0, &ss->f_frsize)		||
 		    __put_user (s.f_blocks, &ss->f_blocks)	||
@@ -482,7 +482,7 @@
 	error = user_path_walk((const char *)A(path),&nd);
 	if (!error) {
 		struct inode * inode = nd.dentry->d_inode;
-		error = report_statvfs(inode, buf);
+		error = report_statvfs(nd.mnt, inode, buf);
 		path_release(&nd);
 	}
 	return error;
@@ -496,7 +496,7 @@
 	error = -EBADF;
 	file = fget(fd);
 	if (file) {
-		error = report_statvfs(file->f_dentry->d_inode, buf);
+		error = report_statvfs(file->f_vfsmnt, file->f_dentry->d_inode, buf);
 		fput(file);
 	}
 
@@ -512,7 +512,7 @@
 	error = user_path_walk((const char *)A(path), &nd);
 	if (!error) {
 		struct inode * inode = nd.dentry->d_inode;
-		error = report_statvfs64(inode, buf);
+		error = report_statvfs64(nd.mnt, inode, buf);
 		path_release(&nd);
 	}
 	unlock_kernel();
@@ -528,7 +528,7 @@
 	file = fget(fd);
 	if (file) {
 		lock_kernel();
-		error = report_statvfs64(file->f_dentry->d_inode, buf);
+		error = report_statvfs64(file->f_vfsmnt, file->f_dentry->d_inode, buf);
 		unlock_kernel();
 		fput(file);
 	}
diff -urN S5-pre4/fs/exec.c S5-pre4-noexe/fs/exec.c
--- S5-pre4/fs/exec.c	Sat Apr 28 02:12:56 2001
+++ S5-pre4-noexe/fs/exec.c	Sun May 20 12:46:46 2001
@@ -347,7 +347,8 @@
 	if (!err) {
 		inode = nd.dentry->d_inode;
 		file = ERR_PTR(-EACCES);
-		if (!IS_NOEXEC(inode) && S_ISREG(inode->i_mode)) {
+		if (!(nd.mnt->mnt_flags & MNT_NOEXEC) &&
+		    S_ISREG(inode->i_mode)) {
 			int err = permission(inode, MAY_EXEC);
 			file = ERR_PTR(err);
 			if (!err) {
@@ -615,7 +616,7 @@
 	bprm->e_uid = current->euid;
 	bprm->e_gid = current->egid;
 
-	if(!IS_NOSUID(inode)) {
+	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
 		/* Set-uid? */
 		if (mode & S_ISUID)
 			bprm->e_uid = inode->i_uid;
diff -urN S5-pre4/fs/fat/inode.c S5-pre4-noexe/fs/fat/inode.c
--- S5-pre4/fs/fat/inode.c	Sat Apr 28 02:12:56 2001
+++ S5-pre4-noexe/fs/fat/inode.c	Sun May 20 12:48:59 2001
@@ -806,9 +806,8 @@
 		MSDOS_I(inode)->mmu_private = inode->i_size;
 	} else { /* not a directory */
 		inode->i_mode = MSDOS_MKMODE(de->attr,
-		    ((IS_NOEXEC(inode) || 
-		      (sbi->options.showexec &&
-		       !is_exec(de->ext)))
+		    ((sbi->options.showexec &&
+		       !is_exec(de->ext))
 		    	? S_IRUGO|S_IWUGO : S_IRWXUGO)
 		    & ~sbi->options.fs_umask) | S_IFREG;
 		MSDOS_I(inode)->i_start = CF_LE_W(de->start);
@@ -927,9 +926,7 @@
 
 	inode_setattr(inode, attr);
 
-	if (IS_NOEXEC(inode) && !S_ISDIR(inode->i_mode))
-		inode->i_mode &= S_IFMT | S_IRUGO | S_IWUGO;
-	else
+	if (S_ISDIR(inode->i_mode))
 		inode->i_mode |= S_IXUGO;
 
 	inode->i_mode = ((inode->i_mode & S_IFMT) | ((((inode->i_mode & S_IRWXU
diff -urN S5-pre4/fs/hfs/inode.c S5-pre4-noexe/fs/hfs/inode.c
--- S5-pre4/fs/hfs/inode.c	Fri Feb 16 22:55:36 2001
+++ S5-pre4-noexe/fs/hfs/inode.c	Sun May 20 12:49:15 2001
@@ -38,7 +38,7 @@
 	struct hfs_fork *fk;
 	struct hfs_cat_entry *entry = HFS_I(inode)->entry;
 
-	if (!IS_NOEXEC(inode) && (fork == HFS_FK_DATA)) {
+	if (fork == HFS_FK_DATA) {
 		inode->i_mode = S_IRWXUGO | S_IFREG;
 	} else {
 		inode->i_mode = S_IRUGO | S_IWUGO | S_IFREG;
diff -urN S5-pre4/fs/namei.c S5-pre4-noexe/fs/namei.c
--- S5-pre4/fs/namei.c	Sat May 19 22:46:35 2001
+++ S5-pre4-noexe/fs/namei.c	Sun May 20 12:48:17 2001
@@ -1051,7 +1051,7 @@
 	    	flag &= ~O_TRUNC;
 	} else if (S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode)) {
 		error = -EACCES;
-		if (IS_NODEV(inode))
+		if (nd->mnt->mnt_flags & MNT_NODEV)
 			goto exit;
 
 		flag &= ~O_TRUNC;
diff -urN S5-pre4/fs/super.c S5-pre4-noexe/fs/super.c
--- S5-pre4/fs/super.c	Sat May 19 22:46:35 2001
+++ S5-pre4-noexe/fs/super.c	Sun May 20 13:12:31 2001
@@ -55,7 +55,7 @@
 extern int root_mountflags;
 
 static int do_remount_sb(struct super_block *sb, int flags, char * data);
-static int do_remount(const char *dir, int flags, char * data);
+static int do_remount(const char *dir, int flags, int mnt_flags, char * data);
 
 /* this is initialized in init/main.c */
 kdev_t ROOT_DEV;
@@ -307,7 +307,8 @@
 
 static struct vfsmount *add_vfsmnt(struct nameidata *nd,
 				struct dentry *root,
-				const char *dev_name)
+				const char *dev_name,
+				int mnt_flags)
 {
 	struct vfsmount *mnt;
 	struct super_block *sb = root->d_inode->i_sb;
@@ -318,8 +319,9 @@
 		goto out;
 	memset(mnt, 0, sizeof(struct vfsmount));
 
+	mnt->mnt_flags = mnt_flags;
 	if (nd || dev_name)
-		mnt->mnt_flags = MNT_VISIBLE;
+		mnt->mnt_flags |= MNT_VISIBLE;
 
 	/* It may be NULL, but who cares? */
 	if (dev_name) {
@@ -460,16 +462,17 @@
 	int flag;
 	char *str;
 } fs_info[] = {
-	{ MS_NOEXEC, ",noexec" },
-	{ MS_NOSUID, ",nosuid" },
-	{ MS_NODEV, ",nodev" },
 	{ MS_SYNCHRONOUS, ",sync" },
 	{ MS_MANDLOCK, ",mand" },
 	{ MS_NOATIME, ",noatime" },
 	{ MS_NODIRATIME, ",nodiratime" },
-#ifdef MS_NOSUB			/* Can't find this except in mount.c */
-	{ MS_NOSUB, ",nosub" },
-#endif
+	{ 0, NULL }
+};
+
+static struct proc_fs_info mnt_info[] = {
+	{ MNT_NOSUID, ",nosuid" },
+	{ MNT_NODEV, ",nodev" },
+	{ MNT_NOEXEC, ",noexec" },
 	{ 0, NULL }
 };
 
@@ -522,6 +525,10 @@
 			if (tmp->mnt_sb->s_flags & fs_infop->flag)
 				MANGLE(fs_infop->str);
 		}
+		for (fs_infop = mnt_info; fs_infop->flag; fs_infop++) {
+			if (tmp->mnt_flags & fs_infop->flag)
+				MANGLE(fs_infop->str);
+		}
 		if (!strcmp("nfs", tmp->mnt_sb->s_type->name)) {
 			nfss = &tmp->mnt_sb->u.nfs_sb.s_server;
 			len += sprintf(buf+len, ",v%d", nfss->rpc_ops->version);
@@ -786,7 +793,7 @@
 	if (!S_ISBLK(inode->i_mode))
 		goto out;
 	error = -EACCES;
-	if (IS_NODEV(inode))
+	if (nd.mnt->mnt_flags & MNT_NODEV)
 		goto out;
 	bdev = inode->i_bdev;
 	bdops = devfs_get_ops ( devfs_get_handle_from_inode (inode) );
@@ -963,7 +970,7 @@
 		put_unnamed_dev(dev);
 		return ERR_PTR(-EINVAL);
 	}
-	mnt = add_vfsmnt(NULL, sb->s_root, NULL);
+	mnt = add_vfsmnt(NULL, sb->s_root, NULL, 0);
 	if (!mnt) {
 		kill_super(sb, 0);
 		return ERR_PTR(-ENOMEM);
@@ -1014,7 +1021,7 @@
 		 * we just try to remount it readonly.
 		 */
 		mntput(mnt);
-		return do_remount("/", MS_RDONLY, NULL);
+		return do_remount("/", MS_RDONLY, 0, NULL);
 	}
 
 	spin_lock(&dcache_lock);
@@ -1155,11 +1162,11 @@
 	int err = 0;
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	if (path_init(old_name, LOOKUP_POSITIVE, &old_nd))
+	if (path_init(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd))
 		err = path_walk(old_name, &old_nd);
 	if (err)
 		goto out;
-	if (path_init(new_name, LOOKUP_POSITIVE, &new_nd))
+	if (path_init(new_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &new_nd))
 		err = path_walk(new_name, &new_nd);
 	if (err)
 		goto out1;
@@ -1180,7 +1187,8 @@
 	down(&new_nd.dentry->d_inode->i_zombie);
 	if (IS_DEADDIR(new_nd.dentry->d_inode))
 		err = -ENOENT;
-	else if (add_vfsmnt(&new_nd, old_nd.dentry, old_nd.mnt->mnt_devname))
+	else if (add_vfsmnt(&new_nd, old_nd.dentry, old_nd.mnt->mnt_devname,
+				old_nd.mnt->mnt_flags))
 		err = 0;
 	up(&new_nd.dentry->d_inode->i_zombie);
 	up(&mount_sem);
@@ -1200,7 +1208,7 @@
  * on it - tough luck.
  */
 
-static int do_remount(const char *dir,int flags,char *data)
+static int do_remount(const char *dir,int flags,int mnt_flags,char *data)
 {
 	struct nameidata nd;
 	int retval = 0;
@@ -1215,7 +1223,7 @@
 		retval = -ENODEV;
 		if (sb) {
 			retval = -EINVAL;
-			if (nd.dentry == sb->s_root) {
+			if (nd.dentry == nd.mnt->mnt_root) {
 				/*
 				 * Shrink the dcache and sync the device.
 				 */
@@ -1224,6 +1232,8 @@
 				if (flags & MS_RDONLY)
 					acct_auto_close(sb->s_dev);
 				retval = do_remount_sb(sb, flags, data);
+				if (!retval)
+					nd.mnt->mnt_flags=MNT_VISIBLE|mnt_flags;
 			}
 		}
 		path_release(&nd);
@@ -1286,6 +1296,7 @@
 	struct vfsmount *mnt = NULL;
 	struct super_block *sb;
 	int retval = 0;
+	int mnt_flags = 0;
 
 	/* Discard magic */
 	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
@@ -1298,11 +1309,20 @@
 	if (dev_name && !memchr(dev_name, 0, PAGE_SIZE))
 		return -EINVAL;
 
+	/* Separate the per-mountpoint flags */
+	if (flags & MS_NOSUID)
+		mnt_flags |= MNT_NOSUID;
+	if (flags & MS_NODEV)
+		mnt_flags |= MNT_NODEV;
+	if (flags & MS_NOEXEC)
+		mnt_flags |= MNT_NOEXEC;
+	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV);
+
 	/* OK, looks good, now let's see what do they want */
 
 	/* just change the flags? - capabilities are checked in do_remount() */
 	if (flags & MS_REMOUNT)
-		return do_remount(dir_name, flags & ~MS_REMOUNT,
+		return do_remount(dir_name, flags & ~MS_REMOUNT, mnt_flags,
 				  (char *) data_page);
 
 	/* "mount --bind"? Equivalent to older "mount -t bind" */
@@ -1361,7 +1381,7 @@
 	down(&nd.dentry->d_inode->i_zombie);
 	if (!IS_DEADDIR(nd.dentry->d_inode)) {
 		retval = -ENOMEM;
-		mnt = add_vfsmnt(&nd, sb->s_root, dev_name);
+		mnt = add_vfsmnt(&nd, sb->s_root, dev_name, mnt_flags);
 	}
 	up(&nd.dentry->d_inode->i_zombie);
 	if (!mnt)
@@ -1568,10 +1588,10 @@
 		devfs_mk_symlink (NULL, "root", DEVFS_FL_DEFAULT,
 				  path + 5 + path_start, NULL, NULL);
 		memcpy (path + path_start, "/dev/", 5);
-		vfsmnt = add_vfsmnt(NULL, sb->s_root, path + path_start);
+		vfsmnt = add_vfsmnt(NULL, sb->s_root, path + path_start, 0);
 	}
 	else
-		vfsmnt = add_vfsmnt(NULL, sb->s_root, "/dev/root");
+		vfsmnt = add_vfsmnt(NULL, sb->s_root, "/dev/root", 0);
 	/* FIXME: if something will try to umount us right now... */
 	if (vfsmnt) {
 		set_fs_root(current->fs, vfsmnt, sb->s_root);
diff -urN S5-pre4/include/linux/fs.h S5-pre4-noexe/include/linux/fs.h
--- S5-pre4/include/linux/fs.h	Sat May 19 22:46:36 2001
+++ S5-pre4-noexe/include/linux/fs.h	Sun May 20 13:03:23 2001
@@ -116,10 +116,10 @@
 #define MS_BIND		4096
 
 /*
- * Flags that can be altered by MS_REMOUNT
+ * Superblock flags that can be altered by MS_REMOUNT
  */
-#define MS_RMT_MASK	(MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|\
-			MS_SYNCHRONOUS|MS_MANDLOCK|MS_NOATIME|MS_NODIRATIME)
+#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_NOATIME|\
+			 MS_NODIRATIME)
 
 /*
  * Old magic mount flag and mask
@@ -152,9 +152,6 @@
 #define __IS_FLG(inode,flg) ((inode)->i_sb->s_flags & (flg))
 
 #define IS_RDONLY(inode) ((inode)->i_sb->s_flags & MS_RDONLY)
-#define IS_NOSUID(inode)	__IS_FLG(inode, MS_NOSUID)
-#define IS_NODEV(inode)		__IS_FLG(inode, MS_NODEV)
-#define IS_NOEXEC(inode)	__IS_FLG(inode, MS_NOEXEC)
 #define IS_SYNC(inode)		(__IS_FLG(inode, MS_SYNCHRONOUS) || ((inode)->i_flags & S_SYNC))
 #define IS_MANDLOCK(inode)	__IS_FLG(inode, MS_MANDLOCK)
 
diff -urN S5-pre4/include/linux/mount.h S5-pre4-noexe/include/linux/mount.h
--- S5-pre4/include/linux/mount.h	Fri Feb 16 18:33:56 2001
+++ S5-pre4-noexe/include/linux/mount.h	Sun May 20 12:44:02 2001
@@ -12,7 +12,10 @@
 #define _LINUX_MOUNT_H
 #ifdef __KERNEL__
 
-#define MNT_VISIBLE	1
+#define MNT_NOSUID	1
+#define MNT_NODEV	2
+#define MNT_NOEXEC	4
+#define MNT_VISIBLE	8
 
 struct vfsmount
 {

