Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263343AbRFEUsf>; Tue, 5 Jun 2001 16:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263344AbRFEUsZ>; Tue, 5 Jun 2001 16:48:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9116 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263343AbRFEUsK>;
	Tue, 5 Jun 2001 16:48:10 -0400
Date: Tue, 5 Jun 2001 16:48:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more fs/super.c cleanups (3)
Message-ID: <Pine.GSO.4.21.0106051645190.4799-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chunk 3:
	Takes the normal mounting into a helper similar to do_loopback()
et.al., makes do_mount() cleaner. Please, apply
								Al

diff -urN S6-pre1-do_mount/fs/super.c S6-pre1-do_add_mount/fs/super.c
--- S6-pre1-do_mount/fs/super.c	Tue Jun  5 08:15:33 2001
+++ S6-pre1-do_add_mount/fs/super.c	Tue Jun  5 08:16:35 2001
@@ -1203,6 +1203,76 @@
 	return do_remount_sb(nd->mnt->mnt_sb, flags, data);
 }
 
+static int do_add_mount(struct nameidata *nd, char *type, int flags,
+			char *name, void *data)
+{
+	struct file_system_type * fstype;
+	struct nameidata nd;
+	struct vfsmount *mnt = NULL;
+	struct super_block *sb;
+	int retval = 0;
+
+	if (!type || !memchr(type, 0, PAGE_SIZE))
+		return -EINVAL;
+
+	/* we need capabilities... */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/* ... filesystem driver... */
+	fstype = get_fs_type(type);
+	if (!fstype)		
+		return -ENODEV;
+
+	/* get superblock, locks mount_sem on success */
+	if (fstype->fs_flags & FS_NOMOUNT)
+		sb = ERR_PTR(-EINVAL);
+	else if (fstype->fs_flags & FS_REQUIRES_DEV)
+		sb = get_sb_bdev(fstype, name, flags, data);
+	else if (fstype->fs_flags & FS_SINGLE)
+		sb = get_sb_single(fstype, flags, data);
+	else
+		sb = get_sb_nodev(fstype, flags, data);
+
+	retval = PTR_ERR(sb);
+	if (IS_ERR(sb))
+		goto fs_out;
+
+	/* Something was mounted here while we slept */
+	while(d_mountpoint(nd->dentry) && follow_down(&nd->mnt, &nd->dentry))
+		;
+
+	/* Refuse the same filesystem on the same mount point */
+	retval = -EBUSY;
+	if (nd->mnt->mnt_sb == sb && nd->mnt->mnt_root == nd->dentry)
+		goto fail;
+
+	retval = -ENOENT;
+	if (!nd->dentry->d_inode)
+		goto fail;
+	retval = -ENOTDIR;
+	if (!S_ISDIR(nd->dentry->d_inode->i_mode))
+		goto fail;
+	down(&nd->dentry->d_inode->i_zombie);
+	if (!IS_DEADDIR(nd->dentry->d_inode)) {
+		retval = -ENOMEM;
+		mnt = add_vfsmnt(nd, sb->s_root, name);
+	}
+	up(&nd->dentry->d_inode->i_zombie);
+	if (!mnt)
+		goto fail;
+	retval = 0;
+unlock_out:
+	up(&mount_sem);
+fs_out:
+	put_filesystem(fstype);
+	return retval;
+
+fail:
+	kill_super(sb);
+	goto unlock_out;
+}
+
 static int copy_mount_options (const void *data, unsigned long *where)
 {
 	int i;
@@ -1253,10 +1323,7 @@
 long do_mount(char * dev_name, char * dir_name, char *type_page,
 		  unsigned long flags, void *data_page)
 {
-	struct file_system_type * fstype;
 	struct nameidata nd;
-	struct vfsmount *mnt = NULL;
-	struct super_block *sb;
 	int retval = 0;
 
 	/* Discard magic */
@@ -1276,86 +1343,16 @@
 	if (retval)
 		return retval;
 
-	/* just change the flags? - capabilities are checked in do_remount() */
-	if (flags & MS_REMOUNT) {
-		retval = do_remount(&nd, flags&~MS_REMOUNT, (char *)data_page);
-		goto nd_out;
-	}
-
-	/* "mount --bind"? Equivalent to older "mount -t bind" */
-	/* No capabilities? What if users do thousands of these? */
-	if (flags & MS_BIND) {
+	if (flags & MS_REMOUNT)
+		retval = do_remount(&nd, flags&~MS_REMOUNT,
+				  (char *)data_page);
+	else if (flags & MS_BIND)
 		retval = do_loopback(&nd, dev_name);
-		goto nd_out;
-	}
-
-	/* For the rest we need the type */
-
-	retval = -EINVAL;
-	if (!type_page || !memchr(type_page, 0, PAGE_SIZE))
-		goto nd_out;
-
-	retval = -EPERM;
-	/* for the rest we _really_ need capabilities... */
-	if (!capable(CAP_SYS_ADMIN))
-		goto nd_out;
-
-	retval = -ENODEV;
-	/* ... filesystem driver... */
-	fstype = get_fs_type(type_page);
-	if (!fstype)		
-		goto nd_out;
-
-	/* get superblock, locks mount_sem on success */
-	if (fstype->fs_flags & FS_NOMOUNT)
-		sb = ERR_PTR(-EINVAL);
-	else if (fstype->fs_flags & FS_REQUIRES_DEV)
-		sb = get_sb_bdev(fstype, dev_name, flags, data_page);
-	else if (fstype->fs_flags & FS_SINGLE)
-		sb = get_sb_single(fstype, flags, data_page);
 	else
-		sb = get_sb_nodev(fstype, flags, data_page);
-
-	retval = PTR_ERR(sb);
-	if (IS_ERR(sb))
-		goto fs_out;
-
-	/* Something was mounted here while we slept */
-	while(d_mountpoint(nd.dentry) && follow_down(&nd.mnt, &nd.dentry))
-		;
-
-	/* Refuse the same filesystem on the same mount point */
-	retval = -EBUSY;
-	if (nd.mnt && nd.mnt->mnt_sb == sb
-	    	   && nd.mnt->mnt_root == nd.dentry)
-		goto fail;
-
-	retval = -ENOENT;
-	if (!nd.dentry->d_inode)
-		goto fail;
-	retval = -ENOTDIR;
-	if (!S_ISDIR(nd.dentry->d_inode->i_mode))
-		goto fail;
-	down(&nd.dentry->d_inode->i_zombie);
-	if (!IS_DEADDIR(nd.dentry->d_inode)) {
-		retval = -ENOMEM;
-		mnt = add_vfsmnt(&nd, sb->s_root, dev_name);
-	}
-	up(&nd.dentry->d_inode->i_zombie);
-	if (!mnt)
-		goto fail;
-	retval = 0;
-unlock_out:
-	up(&mount_sem);
-fs_out:
-	put_filesystem(fstype);
-nd_out:
+		retval = do_add_mount(&nd, type_page, flags,
+				      dev_name, data_page);
 	path_release(&nd);
 	return retval;
-
-fail:
-	kill_super(sb);
-	goto unlock_out;
 }
 
 asmlinkage long sys_mount(char * dev_name, char * dir_name, char * type,

