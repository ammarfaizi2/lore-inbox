Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312745AbSDFTJT>; Sat, 6 Apr 2002 14:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312747AbSDFTJT>; Sat, 6 Apr 2002 14:09:19 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:9962 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312745AbSDFTJO>;
	Sat, 6 Apr 2002 14:09:14 -0500
Date: Sat, 6 Apr 2002 14:09:13 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [WTF] ->setattr() locking changes
In-Reply-To: <Pine.LNX.4.33.0204061020140.24305-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0204061400350.632-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Apr 2002, Linus Torvalds wrote:

> I agree with you that doing the locking outside would clean some stuff up,
> since things like write already have the lock for other reasons.

OK, how about that?  It builds, but it's completely untested.

diff -urN C8-pre2/Documentation/filesystems/Locking C8-pre2-current/Documentation/filesystems/Locking
--- C8-pre2/Documentation/filesystems/Locking	Sat Apr  6 00:29:14 2002
+++ C8-pre2-current/Documentation/filesystems/Locking	Sat Apr  6 14:02:43 2002
@@ -65,7 +65,7 @@
 readlink:	no	no
 follow_link:	no	no
 truncate:	no	yes		(see below)
-setattr:	yes	if ATTR_SIZE
+setattr:	no	yes
 permission:	yes	no
 getattr:				(see below)
 revalidate:	no			(see below)
diff -urN C8-pre2/Documentation/filesystems/porting C8-pre2-current/Documentation/filesystems/porting
--- C8-pre2/Documentation/filesystems/porting	Tue Mar 19 16:05:44 2002
+++ C8-pre2-current/Documentation/filesystems/porting	Sat Apr  6 14:04:40 2002
@@ -116,3 +116,10 @@
 	FS_SINGLE is gone (actually, that had happened back when ->get_sb()
 went in - and hadn't been documented ;-/).  Just remove it from fs_flags
 (and see ->get_sb() entry for other actions).
+
+---
+[mandatory]
+
+->setattr() is called without BKL now.  Caller _always_ holds ->i_sem, so
+watch for ->i_sem-grabbing code that might be used by your ->setattr().
+Callers of notify_change() need ->i_sem now.
diff -urN C8-pre2/fs/attr.c C8-pre2-current/fs/attr.c
--- C8-pre2/fs/attr.c	Sat Apr  6 00:29:28 2002
+++ C8-pre2-current/fs/attr.c	Sat Apr  6 13:23:18 2002
@@ -119,6 +119,7 @@
 int notify_change(struct dentry * dentry, struct iattr * attr)
 {
 	struct inode *inode = dentry->d_inode;
+	mode_t mode = inode->i_mode;
 	int error;
 	time_t now = CURRENT_TIME;
 	unsigned int ia_valid = attr->ia_valid;
@@ -131,8 +132,25 @@
 		attr->ia_atime = now;
 	if (!(ia_valid & ATTR_MTIME_SET))
 		attr->ia_mtime = now;
+	if (ia_valid & ATTR_KILL_SUID) {
+		if (mode & S_ISUID) {
+			if (!ia_valid & ATTR_MODE) {
+				ia_valid = attr->ia_valid |= ATTR_MODE;
+				attr->ia_mode = inode->i_mode;
+			}
+			attr->ia_mode &= ~S_ISUID;
+		}
+	}
+	if (ia_valid & ATTR_KILL_SGID) {
+		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
+			if (!ia_valid & ATTR_MODE) {
+				ia_valid = attr->ia_valid |= ATTR_MODE;
+				attr->ia_mode = inode->i_mode;
+			}
+			attr->ia_mode &= ~S_ISGID;
+		}
+	}
 
-	down(&inode->i_sem);
 	if (inode->i_op && inode->i_op->setattr) 
 		error = inode->i_op->setattr(dentry, attr);
 	else {
@@ -145,7 +163,6 @@
 				error = inode_setattr(inode, attr);
 		}
 	}
-	up(&inode->i_sem);
 	if (!error) {
 		unsigned long dn_mask = setattr_mask(ia_valid);
 		if (dn_mask)
diff -urN C8-pre2/fs/dquot.c C8-pre2-current/fs/dquot.c
--- C8-pre2/fs/dquot.c	Sat Apr  6 00:29:28 2002
+++ C8-pre2-current/fs/dquot.c	Sat Apr  6 13:26:12 2002
@@ -429,7 +429,7 @@
 	count = nr_free_dquots / priority;
 	prune_dqcache(count);
 	unlock_kernel();
-	return kmem_cache_shrink_nr(dquot_cachep);
+	return kmem_cache_shrink(dquot_cachep);
 }
 
 /* NOTE: If you change this function please check whether dqput_blocks() works right... */
diff -urN C8-pre2/fs/fat/inode.c C8-pre2-current/fs/fat/inode.c
--- C8-pre2/fs/fat/inode.c	Sat Apr  6 00:29:29 2002
+++ C8-pre2-current/fs/fat/inode.c	Sat Apr  6 13:21:12 2002
@@ -1086,7 +1086,8 @@
 			error = 0;
 		goto out;
 	}
-	if( error = inode_setattr(inode, attr) )
+	error = inode_setattr(inode, attr);
+	if (error)
 		goto out;
 
 	if (S_ISDIR(inode->i_mode))
diff -urN C8-pre2/fs/hpfs/namei.c C8-pre2-current/fs/hpfs/namei.c
--- C8-pre2/fs/hpfs/namei.c	Tue Feb 19 22:33:03 2002
+++ C8-pre2-current/fs/hpfs/namei.c	Sat Apr  6 12:20:54 2002
@@ -365,11 +365,9 @@
 			goto ret;
 		}
 		/*printk("HPFS: truncating file before delete.\n");*/
-		down(&inode->i_sem);
 		newattrs.ia_size = 0;
 		newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
 		err = notify_change(dentry, &newattrs);
-		up(&inode->i_sem);
 		put_write_access(inode);
 		if (err)
 			goto ret;
diff -urN C8-pre2/fs/jffs2/file.c C8-pre2-current/fs/jffs2/file.c
--- C8-pre2/fs/jffs2/file.c	Sat Apr  6 00:29:29 2002
+++ C8-pre2-current/fs/jffs2/file.c	Sat Apr  6 13:21:44 2002
@@ -43,6 +43,7 @@
 #include <linux/pagemap.h>
 #include <linux/crc32.h>
 #include <linux/jffs2.h>
+#include <linux/smp_lock.h>
 #include "nodelist.h"
 
 extern int generic_file_open(struct inode *, struct file *) __attribute__((weak));
diff -urN C8-pre2/fs/ncpfs/inode.c C8-pre2-current/fs/ncpfs/inode.c
--- C8-pre2/fs/ncpfs/inode.c	Sat Apr  6 00:29:30 2002
+++ C8-pre2-current/fs/ncpfs/inode.c	Sat Apr  6 13:22:56 2002
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/init.h>
+#include <linux/smp_lock.h>
 
 #include <linux/ncp_fs.h>
 
diff -urN C8-pre2/fs/nfsd/vfs.c C8-pre2-current/fs/nfsd/vfs.c
--- C8-pre2/fs/nfsd/vfs.c	Fri Mar  8 02:09:52 2002
+++ C8-pre2-current/fs/nfsd/vfs.c	Sat Apr  6 12:39:54 2002
@@ -264,6 +264,7 @@
 		if (err)
 			goto out_nfserr;
 
+		size_change = 1;
 		err = locks_verify_truncate(inode, NULL, iap->ia_size);
 		if (err) {
 			put_write_access(inode);
@@ -279,35 +280,24 @@
 	}
 
 	/* Revoke setuid/setgid bit on chown/chgrp */
-	if ((iap->ia_valid & ATTR_UID) && (imode & S_ISUID)
-	 && iap->ia_uid != inode->i_uid) {
-		iap->ia_valid |= ATTR_MODE;
-		iap->ia_mode = imode &= ~S_ISUID;
-	}
-	if ((iap->ia_valid & ATTR_GID) && (imode & S_ISGID)
-	 && iap->ia_gid != inode->i_gid) {
-		iap->ia_valid |= ATTR_MODE;
-		iap->ia_mode = imode &= ~S_ISGID;
-	}
+	if ((iap->ia_valid & ATTR_UID) && iap->ia_uid != inode->i_uid)
+		iap->ia_valid |= ATTR_KILL_SUID;
+	if ((iap->ia_valid & ATTR_GID) && iap->ia_gid != inode->i_gid)
+		iap->ia_valid |= ATTR_KILL_SGID;
 
 	/* Change the attributes. */
 
-
 	iap->ia_valid |= ATTR_CTIME;
 
-	if (iap->ia_valid & ATTR_SIZE) {
-		fh_lock(fhp);
-		size_change = 1;
-	}
 	err = nfserr_notsync;
 	if (!check_guard || guardtime == inode->i_ctime) {
+		fh_lock(fhp);
 		err = notify_change(dentry, iap);
 		err = nfserrno(err);
-	}
-	if (size_change) {
 		fh_unlock(fhp);
-		put_write_access(inode);
 	}
+	if (size_change)
+		put_write_access(inode);
 	if (!err)
 		if (EX_ISSYNC(fhp->fh_export))
 			write_inode_now(inode, 1);
@@ -725,10 +715,11 @@
 	/* clear setuid/setgid flag after write */
 	if (err >= 0 && (inode->i_mode & (S_ISUID | S_ISGID))) {
 		struct iattr	ia;
+		ia.ia_valid = ATTR_KILL_SUID | ATTR_KILL_SGID;
 
-		ia.ia_valid = ATTR_MODE;
-		ia.ia_mode  = inode->i_mode & ~(S_ISUID | S_ISGID);
+		down(&inode->i_sem);
 		notify_change(dentry, &ia);
+		up(&inode->i_sem);
 	}
 
 	if (err >= 0 && stable) {
@@ -1157,7 +1148,9 @@
 				iap->ia_valid |= ATTR_CTIME;
 				iap->ia_mode = (iap->ia_mode&S_IALLUGO)
 					| S_IFLNK;
+				down(&dentry->d_inode->i_sem);
 				err = notify_change(dnew, iap);
+				up(&dentry->d_inode->i_sem);
 				if (!err && EX_ISSYNC(fhp->fh_export))
 					write_inode_now(dentry->d_inode, 1);
 		       }
diff -urN C8-pre2/fs/open.c C8-pre2-current/fs/open.c
--- C8-pre2/fs/open.c	Sat Apr  6 00:29:30 2002
+++ C8-pre2-current/fs/open.c	Sat Apr  6 12:37:36 2002
@@ -73,6 +73,7 @@
 
 int do_truncate(struct dentry *dentry, loff_t length)
 {
+	int err;
 	struct iattr newattrs;
 
 	/* Not pretty: "inode->i_size" shouldn't really be signed. But it is. */
@@ -81,7 +82,10 @@
 
 	newattrs.ia_size = length;
 	newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
-	return notify_change(dentry, &newattrs);
+	down(&dentry->d_inode->i_sem);
+	err = notify_change(dentry, &newattrs);
+	up(&dentry->d_inode->i_sem);
+	return err;
 }
 
 static inline long do_sys_truncate(const char * path, loff_t length)
@@ -255,7 +259,9 @@
 		    (error = permission(inode,MAY_WRITE)) != 0)
 			goto dput_and_out;
 	}
+	down(&inode->i_sem);
 	error = notify_change(nd.dentry, &newattrs);
+	up(&inode->i_sem);
 dput_and_out:
 	path_release(&nd);
 out:
@@ -299,7 +305,9 @@
 		if ((error = permission(inode,MAY_WRITE)) != 0)
 			goto dput_and_out;
 	}
+	down(&inode->i_sem);
 	error = notify_change(nd.dentry, &newattrs);
+	up(&inode->i_sem);
 dput_and_out:
 	path_release(&nd);
 out:
@@ -449,11 +457,13 @@
 	err = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 		goto out_putf;
+	down(&inode->i_sem);
 	if (mode == (mode_t) -1)
 		mode = inode->i_mode;
 	newattrs.ia_mode = (mode & S_IALLUGO) | (inode->i_mode & ~S_IALLUGO);
 	newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
 	err = notify_change(dentry, &newattrs);
+	up(&inode->i_sem);
 
 out_putf:
 	fput(file);
@@ -481,11 +491,13 @@
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 		goto dput_and_out;
 
+	down(&inode->i_sem);
 	if (mode == (mode_t) -1)
 		mode = inode->i_mode;
 	newattrs.ia_mode = (mode & S_IALLUGO) | (inode->i_mode & ~S_IALLUGO);
 	newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
 	error = notify_change(nd.dentry, &newattrs);
+	up(&inode->i_sem);
 
 dput_and_out:
 	path_release(&nd);
@@ -510,45 +522,20 @@
 	error = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 		goto out;
-	if (user == (uid_t) -1)
-		user = inode->i_uid;
-	if (group == (gid_t) -1)
-		group = inode->i_gid;
-	newattrs.ia_mode = inode->i_mode;
-	newattrs.ia_uid = user;
-	newattrs.ia_gid = group;
-	newattrs.ia_valid =  ATTR_UID | ATTR_GID | ATTR_CTIME;
-	/*
-	 * If the user or group of a non-directory has been changed by a
-	 * non-root user, remove the setuid bit.
-	 * 19981026	David C Niemi <niemi@tux.org>
-	 *
-	 * Changed this to apply to all users, including root, to avoid
-	 * some races. This is the behavior we had in 2.0. The check for
-	 * non-root was definitely wrong for 2.2 anyway, as it should
-	 * have been using CAP_FSETID rather than fsuid -- 19990830 SD.
-	 */
-	if ((inode->i_mode & S_ISUID) == S_ISUID &&
-		!S_ISDIR(inode->i_mode))
-	{
-		newattrs.ia_mode &= ~S_ISUID;
-		newattrs.ia_valid |= ATTR_MODE;
+	newattrs.ia_valid =  ATTR_CTIME;
+	if (user != (uid_t) -1) {
+		newattrs.ia_valid =  ATTR_UID;
+		newattrs.ia_uid = user;
 	}
-	/*
-	 * Likewise, if the user or group of a non-directory has been changed
-	 * by a non-root user, remove the setgid bit UNLESS there is no group
-	 * execute bit (this would be a file marked for mandatory locking).
-	 * 19981026	David C Niemi <niemi@tux.org>
-	 *
-	 * Removed the fsuid check (see the comment above) -- 19990830 SD.
-	 */
-	if (((inode->i_mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) 
-		&& !S_ISDIR(inode->i_mode))
-	{
-		newattrs.ia_mode &= ~S_ISGID;
-		newattrs.ia_valid |= ATTR_MODE;
+	if (group != (gid_t) -1) {
+		newattrs.ia_valid =  ATTR_GID;
+		newattrs.ia_gid = group;
 	}
+	if (!S_ISDIR(inode->i_mode))
+		newattrs.ia_valid |= ATTR_KILL_SUID|ATTR_KILL_SGID;
+	down(&inode->i_sem);
 	error = notify_change(dentry, &newattrs);
+	up(&inode->i_sem);
 out:
 	return error;
 }
diff -urN C8-pre2/include/linux/fs.h C8-pre2-current/include/linux/fs.h
--- C8-pre2/include/linux/fs.h	Sat Apr  6 00:29:32 2002
+++ C8-pre2-current/include/linux/fs.h	Sat Apr  6 12:58:55 2002
@@ -305,6 +305,8 @@
 #define ATTR_MTIME_SET	256
 #define ATTR_FORCE	512	/* Not a change, but a change it */
 #define ATTR_ATTR_FLAG	1024
+#define ATTR_KILL_SUID	2048
+#define ATTR_KILL_SGID	4096
 
 /*
  * This is the Inode Attributes structure, used for notify_change().  It
@@ -1313,7 +1315,7 @@
 
 extern void clear_inode(struct inode *);
 extern struct inode *new_inode(struct super_block *);
-extern void remove_suid(struct inode *inode);
+extern void remove_suid(struct dentry *);
 extern void insert_inode_hash(struct inode *);
 extern void remove_inode_hash(struct inode *);
 extern struct file * get_empty_filp(void);
diff -urN C8-pre2/mm/filemap.c C8-pre2-current/mm/filemap.c
--- C8-pre2/mm/filemap.c	Sat Apr  6 00:29:32 2002
+++ C8-pre2-current/mm/filemap.c	Sat Apr  6 12:53:58 2002
@@ -2503,18 +2503,19 @@
 	return page;
 }
 
-inline void remove_suid(struct inode *inode)
+inline void remove_suid(struct dentry *dentry)
 {
-	unsigned int mode;
+	struct iattr newattrs;
+	struct inode *inode = dentry->d_inode;
+	unsigned int mode = inode->i_mode & (S_ISUID|S_ISGID|S_IXGRP);
 
-	/* set S_IGID if S_IXGRP is set, and always set S_ISUID */
-	mode = (inode->i_mode & S_IXGRP)*(S_ISGID/S_IXGRP) | S_ISUID;
+	if (!(mode & S_IXGRP))
+		mode &= S_ISUID;
 
 	/* was any of the uid bits set? */
-	mode &= inode->i_mode;
 	if (mode && !capable(CAP_FSETID)) {
-		inode->i_mode &= ~mode;
-		mark_inode_dirty(inode);
+		newattrs.ia_valid = ATTR_KILL_SUID | ATTR_KILL_SGID;
+		notify_change(dentry, &newattrs);
 	}
 }
 
@@ -2646,7 +2647,7 @@
 	if (count == 0)
 		goto out;
 
-	remove_suid(inode);
+	remove_suid(file->f_dentry);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	mark_inode_dirty_sync(inode);
 
diff -urN C8-pre2/mm/shmem.c C8-pre2-current/mm/shmem.c
--- C8-pre2/mm/shmem.c	Sat Apr  6 00:29:32 2002
+++ C8-pre2-current/mm/shmem.c	Sat Apr  6 12:43:50 2002
@@ -802,7 +802,7 @@
 
 	status	= 0;
 	if (count) {
-		remove_suid(inode);
+		remove_suid(file->f_dentry);
 		inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	}
 

