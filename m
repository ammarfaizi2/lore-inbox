Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263335AbRFEUpf>; Tue, 5 Jun 2001 16:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263340AbRFEUpZ>; Tue, 5 Jun 2001 16:45:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:45463 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263335AbRFEUpL>;
	Tue, 5 Jun 2001 16:45:11 -0400
Date: Tue, 5 Jun 2001 16:45:09 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more fs/super.c fixes (2)
Message-ID: <Pine.GSO.4.21.0106051642040.4799-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chunk 2:
	Since all branches of do_mount() (mounting, binding, remounting)
do the same thing (lookup of directory) we can take that lookup in the
beginning of do_mount() and pass to do_loopback() and do_remount()
nameidata instead of name.

Please, apply
							Al

diff -urN S6-pre1-do_remount/fs/super.c S6-pre1-do_mount/fs/super.c
--- S6-pre1-do_remount/fs/super.c	Tue Jun  5 08:14:29 2001
+++ S6-pre1-do_mount/fs/super.c	Tue Jun  5 08:15:33 2001
@@ -1151,9 +1151,9 @@
 /*
  * do loopback mount.
  */
-static int do_loopback(char *old_name, char *new_name)
+static int do_loopback(struct nameidata *nd, char *old_name)
 {
-	struct nameidata old_nd, new_nd;
+	struct nameidata old_nd;
 	int err = 0;
 	if (!old_name || !*old_name)
 		return -EINVAL;
@@ -1161,31 +1161,25 @@
 		err = path_walk(old_name, &old_nd);
 	if (err)
 		goto out;
-	if (path_init(new_name, LOOKUP_POSITIVE, &new_nd))
-		err = path_walk(new_name, &new_nd);
+	err = mount_is_safe(nd);
 	if (err)
 		goto out1;
-	err = mount_is_safe(&new_nd);
-	if (err)
-		goto out2;
 	err = -EINVAL;
-	if (S_ISDIR(new_nd.dentry->d_inode->i_mode) !=
+	if (S_ISDIR(nd->dentry->d_inode->i_mode) !=
 	      S_ISDIR(old_nd.dentry->d_inode->i_mode))
-		goto out2;
+		goto out1;
 
 	err = -ENOMEM;
 		
 	down(&mount_sem);
 	/* there we go */
-	down(&new_nd.dentry->d_inode->i_zombie);
-	if (IS_DEADDIR(new_nd.dentry->d_inode))
+	down(&nd->dentry->d_inode->i_zombie);
+	if (IS_DEADDIR(nd->dentry->d_inode))
 		err = -ENOENT;
-	else if (add_vfsmnt(&new_nd, old_nd.dentry, old_nd.mnt->mnt_devname))
+	else if (add_vfsmnt(nd, old_nd.dentry, old_nd.mnt->mnt_devname))
 		err = 0;
-	up(&new_nd.dentry->d_inode->i_zombie);
+	up(&nd->dentry->d_inode->i_zombie);
 	up(&mount_sem);
-out2:
-	path_release(&new_nd);
 out1:
 	path_release(&old_nd);
 out:
@@ -1198,25 +1192,15 @@
  * on it - tough luck.
  */
 
-static int do_remount(const char *dir,int flags,char *data)
+static int do_remount(struct nameidata *nd, int flags, char *data)
 {
-	struct nameidata nd;
-	int retval = 0;
-
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (path_init(dir, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		retval = path_walk(dir, &nd);
-	if (retval)
-		return retval;
-
-	retval = -EINVAL;
-	if (nd.dentry == nd.mnt->mnt_root)
-		retval = do_remount_sb(nd.mnt->mnt_sb, flags, data);
+	if (nd->dentry != nd->mnt->mnt_root)
+		return -EINVAL;
 
-	path_release(&nd);
-	return retval;
+	return do_remount_sb(nd->mnt->mnt_sb, flags, data);
 }
 
 static int copy_mount_options (const void *data, unsigned long *where)
@@ -1286,38 +1270,41 @@
 	if (dev_name && !memchr(dev_name, 0, PAGE_SIZE))
 		return -EINVAL;
 
-	/* OK, looks good, now let's see what do they want */
+	/* ... and get the mountpoint */
+	if (path_init(dir_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
+		retval = path_walk(dir_name, &nd);
+	if (retval)
+		return retval;
 
 	/* just change the flags? - capabilities are checked in do_remount() */
-	if (flags & MS_REMOUNT)
-		return do_remount(dir_name, flags & ~MS_REMOUNT,
-				  (char *) data_page);
+	if (flags & MS_REMOUNT) {
+		retval = do_remount(&nd, flags&~MS_REMOUNT, (char *)data_page);
+		goto nd_out;
+	}
 
 	/* "mount --bind"? Equivalent to older "mount -t bind" */
 	/* No capabilities? What if users do thousands of these? */
-	if (flags & MS_BIND)
-		return do_loopback(dev_name, dir_name);
+	if (flags & MS_BIND) {
+		retval = do_loopback(&nd, dev_name);
+		goto nd_out;
+	}
 
 	/* For the rest we need the type */
 
+	retval = -EINVAL;
 	if (!type_page || !memchr(type_page, 0, PAGE_SIZE))
-		return -EINVAL;
+		goto nd_out;
 
+	retval = -EPERM;
 	/* for the rest we _really_ need capabilities... */
 	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
+		goto nd_out;
 
+	retval = -ENODEV;
 	/* ... filesystem driver... */
 	fstype = get_fs_type(type_page);
 	if (!fstype)		
-		return -ENODEV;
-
-	/* ... and mountpoint. Do the lookup first to force automounting. */
-	if (path_init(dir_name,
-		      LOOKUP_FOLLOW|LOOKUP_POSITIVE|LOOKUP_DIRECTORY, &nd))
-		retval = path_walk(dir_name, &nd);
-	if (retval)
-		goto fs_out;
+		goto nd_out;
 
 	/* get superblock, locks mount_sem on success */
 	if (fstype->fs_flags & FS_NOMOUNT)
@@ -1331,7 +1318,7 @@
 
 	retval = PTR_ERR(sb);
 	if (IS_ERR(sb))
-		goto dput_out;
+		goto fs_out;
 
 	/* Something was mounted here while we slept */
 	while(d_mountpoint(nd.dentry) && follow_down(&nd.mnt, &nd.dentry))
@@ -1346,6 +1333,9 @@
 	retval = -ENOENT;
 	if (!nd.dentry->d_inode)
 		goto fail;
+	retval = -ENOTDIR;
+	if (!S_ISDIR(nd.dentry->d_inode->i_mode))
+		goto fail;
 	down(&nd.dentry->d_inode->i_zombie);
 	if (!IS_DEADDIR(nd.dentry->d_inode)) {
 		retval = -ENOMEM;
@@ -1357,10 +1347,10 @@
 	retval = 0;
 unlock_out:
 	up(&mount_sem);
-dput_out:
-	path_release(&nd);
 fs_out:
 	put_filesystem(fstype);
+nd_out:
+	path_release(&nd);
 	return retval;
 
 fail:

