Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272265AbRILRac>; Wed, 12 Sep 2001 13:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272282AbRILRaX>; Wed, 12 Sep 2001 13:30:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33672 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S272265AbRILRaF>;
	Wed, 12 Sep 2001 13:30:05 -0400
Date: Wed, 12 Sep 2001 13:30:22 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] nosuid/noexec/nodev handling
Message-ID: <Pine.GSO.4.21.0109121329130.2698-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	nosuid, noexec and nodev are made vfsmount flags (instead of
superblock ones).  Places that used to check them switched to checking
vfsmount->mnt_flags.  get_filesystem_info() updated, ditto for
do_add_mount() and do_remount().

	As the result, these flags are per-mountpoint now.  E.g. we can
turn them on and off for arbitrary subtree:
mount --bind /home/luser /home/luser
mount -o remount,noexec /home/luser
will turn noexec on for subtree at /hom/luser without affecting the rest
of /home.  Other obvious applications is mounting a filesystem nosuid for
chroot jail and normally outside of it, yodda, yodda.

	Patch is completely straightforward.  Works here and it had been in
-ac for a month (i.e. since 2.4.8-ac2).  Please, apply.


diff -urN S10-pre8/arch/sparc64/solaris/fs.c S10-pre8-nosuid/arch/sparc64/solaris/fs.c
--- S10-pre8/arch/sparc64/solaris/fs.c	Thu Feb 22 06:47:53 2001
+++ S10-pre8-nosuid/arch/sparc64/solaris/fs.c	Wed Sep 12 12:45:59 2001
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
diff -urN S10-pre8/fs/exec.c S10-pre8-nosuid/fs/exec.c
--- S10-pre8/fs/exec.c	Tue Sep 11 09:28:12 2001
+++ S10-pre8-nosuid/fs/exec.c	Wed Sep 12 12:45:59 2001
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
@@ -616,7 +617,7 @@
 	bprm->e_uid = current->euid;
 	bprm->e_gid = current->egid;
 
-	if(!IS_NOSUID(inode)) {
+	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
 		/* Set-uid? */
 		if (mode & S_ISUID)
 			bprm->e_uid = inode->i_uid;
diff -urN S10-pre8/fs/fat/inode.c S10-pre8-nosuid/fs/fat/inode.c
--- S10-pre8/fs/fat/inode.c	Thu Aug 16 20:05:50 2001
+++ S10-pre8-nosuid/fs/fat/inode.c	Wed Sep 12 12:45:59 2001
@@ -919,9 +919,8 @@
 	} else { /* not a directory */
 		inode->i_generation |= 1;
 		inode->i_mode = MSDOS_MKMODE(de->attr,
-		    ((IS_NOEXEC(inode) || 
-		      (sbi->options.showexec &&
-		       !is_exec(de->ext)))
+		    ((sbi->options.showexec &&
+		       !is_exec(de->ext))
 		    	? S_IRUGO|S_IWUGO : S_IRWXUGO)
 		    & ~sbi->options.fs_umask) | S_IFREG;
 		MSDOS_I(inode)->i_start = CF_LE_W(de->start);
@@ -1039,9 +1038,7 @@
 
 	inode_setattr(inode, attr);
 
-	if (IS_NOEXEC(inode) && !S_ISDIR(inode->i_mode))
-		inode->i_mode &= S_IFMT | S_IRUGO | S_IWUGO;
-	else
+	if (S_ISDIR(inode->i_mode))
 		inode->i_mode |= S_IXUGO;
 
 	inode->i_mode = ((inode->i_mode & S_IFMT) | ((((inode->i_mode & S_IRWXU
diff -urN S10-pre8/fs/hfs/inode.c S10-pre8-nosuid/fs/hfs/inode.c
--- S10-pre8/fs/hfs/inode.c	Tue Sep 11 09:28:12 2001
+++ S10-pre8-nosuid/fs/hfs/inode.c	Wed Sep 12 12:45:59 2001
@@ -38,7 +38,7 @@
 	struct hfs_fork *fk;
 	struct hfs_cat_entry *entry = HFS_I(inode)->entry;
 
-	if (!IS_NOEXEC(inode) && (fork == HFS_FK_DATA)) {
+	if (fork == HFS_FK_DATA) {
 		inode->i_mode = S_IRWXUGO | S_IFREG;
 	} else {
 		inode->i_mode = S_IRUGO | S_IWUGO | S_IFREG;
diff -urN S10-pre8/fs/namei.c S10-pre8-nosuid/fs/namei.c
--- S10-pre8/fs/namei.c	Tue Sep 11 09:28:12 2001
+++ S10-pre8-nosuid/fs/namei.c	Wed Sep 12 12:45:59 2001
@@ -1062,7 +1062,7 @@
 	    	flag &= ~O_TRUNC;
 	} else if (S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode)) {
 		error = -EACCES;
-		if (IS_NODEV(inode))
+		if (nd->mnt->mnt_flags & MNT_NODEV)
 			goto exit;
 
 		flag &= ~O_TRUNC;
diff -urN S10-pre8/fs/super.c S10-pre8-nosuid/fs/super.c
--- S10-pre8/fs/super.c	Tue Sep 11 09:28:12 2001
+++ S10-pre8-nosuid/fs/super.c	Wed Sep 12 12:45:59 2001
@@ -410,6 +410,7 @@
 	mnt->mnt_root = dget(root);
 	mnt->mnt_mountpoint = mnt->mnt_root;
 	mnt->mnt_parent = mnt;
+	mnt->mnt_flags = old->mnt_flags;
 
 	atomic_inc(&sb->s_active);
 out:
@@ -520,16 +521,17 @@
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
 
@@ -580,6 +582,10 @@
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
@@ -917,7 +923,7 @@
 	if (!S_ISBLK(inode->i_mode))
 		goto out;
 	error = -EACCES;
-	if (IS_NODEV(inode))
+	if (nd.mnt->mnt_flags & MNT_NODEV)
 		goto out;
 	bdev = inode->i_bdev;
 	bdops = devfs_get_ops ( devfs_get_handle_from_inode (inode) );
@@ -1382,7 +1388,7 @@
  * on it - tough luck.
  */
 
-static int do_remount(struct nameidata *nd, int flags, char *data)
+static int do_remount(struct nameidata *nd,int flags,int mnt_flags,char *data)
 {
 	int err;
 	struct super_block * sb = nd->mnt->mnt_sb;
@@ -1395,6 +1401,8 @@
 
 	down_write(&sb->s_umount);
 	err = do_remount_sb(sb, flags, data);
+	if (!err)
+		nd->mnt->mnt_flags=mnt_flags;
 	up_write(&sb->s_umount);
 	return err;
 }
@@ -1463,7 +1471,7 @@
 }
 
 static int do_add_mount(struct nameidata *nd, char *type, int flags,
-			char *name, void *data)
+			int mnt_flags, char *name, void *data)
 {
 	struct vfsmount *mnt = do_kern_mount(type, flags, name, data);
 	int retval = PTR_ERR(mnt);
@@ -1471,6 +1479,8 @@
 	if (IS_ERR(mnt))
 		goto out;
 
+	mnt->mnt_flags = mnt_flags;
+
 	down(&mount_sem);
 	/* Something was mounted here while we slept */
 	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
@@ -1539,6 +1549,7 @@
 {
 	struct nameidata nd;
 	int retval = 0;
+	int mnt_flags = 0;
 
 	/* Discard magic */
 	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
@@ -1551,6 +1562,15 @@
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
 	/* ... and get the mountpoint */
 	if (path_init(dir_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
 		retval = path_walk(dir_name, &nd);
@@ -1558,12 +1578,12 @@
 		return retval;
 
 	if (flags & MS_REMOUNT)
-		retval = do_remount(&nd, flags&~MS_REMOUNT,
+		retval = do_remount(&nd, flags&~MS_REMOUNT, mnt_flags,
 				  (char *)data_page);
 	else if (flags & MS_BIND)
 		retval = do_loopback(&nd, dev_name);
 	else
-		retval = do_add_mount(&nd, type_page, flags,
+		retval = do_add_mount(&nd, type_page, flags, mnt_flags,
 				      dev_name, data_page);
 	path_release(&nd);
 	return retval;
diff -urN S10-pre8/include/linux/fs.h S10-pre8-nosuid/include/linux/fs.h
--- S10-pre8/include/linux/fs.h	Tue Sep 11 09:28:13 2001
+++ S10-pre8-nosuid/include/linux/fs.h	Wed Sep 12 12:45:59 2001
@@ -111,10 +111,10 @@
 #define MS_NOUSER	(1<<31)
 
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
@@ -147,9 +147,6 @@
 #define __IS_FLG(inode,flg) ((inode)->i_sb->s_flags & (flg))
 
 #define IS_RDONLY(inode) ((inode)->i_sb->s_flags & MS_RDONLY)
-#define IS_NOSUID(inode)	__IS_FLG(inode, MS_NOSUID)
-#define IS_NODEV(inode)		__IS_FLG(inode, MS_NODEV)
-#define IS_NOEXEC(inode)	__IS_FLG(inode, MS_NOEXEC)
 #define IS_SYNC(inode)		(__IS_FLG(inode, MS_SYNCHRONOUS) || ((inode)->i_flags & S_SYNC))
 #define IS_MANDLOCK(inode)	__IS_FLG(inode, MS_MANDLOCK)
 
diff -urN S10-pre8/include/linux/mount.h S10-pre8-nosuid/include/linux/mount.h
--- S10-pre8/include/linux/mount.h	Sat Aug 11 14:59:25 2001
+++ S10-pre8-nosuid/include/linux/mount.h	Wed Sep 12 12:45:59 2001
@@ -12,6 +12,10 @@
 #define _LINUX_MOUNT_H
 #ifdef __KERNEL__
 
+#define MNT_NOSUID	1
+#define MNT_NODEV	2
+#define MNT_NOEXEC	4
+
 struct vfsmount
 {
 	struct list_head mnt_hash;

