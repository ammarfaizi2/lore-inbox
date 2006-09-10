Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWIJSek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWIJSek (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 14:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWIJSek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 14:34:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:35730 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932408AbWIJSej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 14:34:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=EnAn0FmhSC6iLgktArnfq9/M3o7U1tQuS0FVEm9LjJ56jbZ7q/NtLygkrtImj2vULGRz4sM3ia0gZp85P0j4a3Dbg+6JGaKjw/+qERSHfCsQRmzKdtfu9bmc9I4+8ZbytbQ2jXJp2U2i1JndfHyE+bjSg7QARje5/b74DubGUOE=
Date: Sun, 10 Sep 2006 22:34:40 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Create fs/utimes.c
Message-ID: <20060910183440.GA5192@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* fs/open.c is getting bit crowdy
* preparation to lutimes(2)

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/Makefile           |    2
 fs/open.c             |  134 ------------------------------------------------
 fs/utimes.c           |  137 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/namei.h |    1
 include/linux/utime.h |    2
 5 files changed, 141 insertions(+), 135 deletions(-)

--- a/fs/Makefile
+++ b/fs/Makefile
@@ -10,7 +10,7 @@ obj-y :=	open.o read_write.o file_table.
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o mpage.o direct-io.o \
-		ioprio.o pnode.o drop_caches.o splice.o sync.o
+		ioprio.o pnode.o drop_caches.o splice.o sync.o utimes.o
 
 obj-$(CONFIG_INOTIFY)		+= inotify.o
 obj-$(CONFIG_INOTIFY_USER)	+= inotify_user.o
--- a/fs/open.c
+++ b/fs/open.c
@@ -6,7 +6,6 @@
 
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/utime.h>
 #include <linux/file.h>
 #include <linux/smp_lock.h>
 #include <linux/quotaops.h>
@@ -29,8 +28,6 @@ #include <linux/syscalls.h>
 #include <linux/rcupdate.h>
 #include <linux/audit.h>
 
-#include <asm/unistd.h>
-
 int vfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	int retval = -ENODEV;
@@ -353,137 +350,6 @@ asmlinkage long sys_ftruncate64(unsigned
 }
 #endif
 
-#ifdef __ARCH_WANT_SYS_UTIME
-
-/*
- * sys_utime() can be implemented in user-level using sys_utimes().
- * Is this for backwards compatibility?  If so, why not move it
- * into the appropriate arch directory (for those architectures that
- * need it).
- */
-
-/* If times==NULL, set access and modification to current time,
- * must be owner or have write permission.
- * Else, update from *times, must be owner or super user.
- */
-asmlinkage long sys_utime(char __user * filename, struct utimbuf __user * times)
-{
-	int error;
-	struct nameidata nd;
-	struct inode * inode;
-	struct iattr newattrs;
-
-	error = user_path_walk(filename, &nd);
-	if (error)
-		goto out;
-	inode = nd.dentry->d_inode;
-
-	error = -EROFS;
-	if (IS_RDONLY(inode))
-		goto dput_and_out;
-
-	/* Don't worry, the checks are done in inode_change_ok() */
-	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
-	if (times) {
-		error = -EPERM;
-		if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
-			goto dput_and_out;
-
-		error = get_user(newattrs.ia_atime.tv_sec, &times->actime);
-		newattrs.ia_atime.tv_nsec = 0;
-		if (!error)
-			error = get_user(newattrs.ia_mtime.tv_sec, &times->modtime);
-		newattrs.ia_mtime.tv_nsec = 0;
-		if (error)
-			goto dput_and_out;
-
-		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
-	} else {
-                error = -EACCES;
-                if (IS_IMMUTABLE(inode))
-                        goto dput_and_out;
-
-		if (current->fsuid != inode->i_uid &&
-		    (error = vfs_permission(&nd, MAY_WRITE)) != 0)
-			goto dput_and_out;
-	}
-	mutex_lock(&inode->i_mutex);
-	error = notify_change(nd.dentry, &newattrs);
-	mutex_unlock(&inode->i_mutex);
-dput_and_out:
-	path_release(&nd);
-out:
-	return error;
-}
-
-#endif
-
-/* If times==NULL, set access and modification to current time,
- * must be owner or have write permission.
- * Else, update from *times, must be owner or super user.
- */
-long do_utimes(int dfd, char __user *filename, struct timeval *times)
-{
-	int error;
-	struct nameidata nd;
-	struct inode * inode;
-	struct iattr newattrs;
-
-	error = __user_walk_fd(dfd, filename, LOOKUP_FOLLOW, &nd);
-
-	if (error)
-		goto out;
-	inode = nd.dentry->d_inode;
-
-	error = -EROFS;
-	if (IS_RDONLY(inode))
-		goto dput_and_out;
-
-	/* Don't worry, the checks are done in inode_change_ok() */
-	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
-	if (times) {
-		error = -EPERM;
-                if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
-                        goto dput_and_out;
-
-		newattrs.ia_atime.tv_sec = times[0].tv_sec;
-		newattrs.ia_atime.tv_nsec = times[0].tv_usec * 1000;
-		newattrs.ia_mtime.tv_sec = times[1].tv_sec;
-		newattrs.ia_mtime.tv_nsec = times[1].tv_usec * 1000;
-		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
-	} else {
-		error = -EACCES;
-                if (IS_IMMUTABLE(inode))
-                        goto dput_and_out;
-
-		if (current->fsuid != inode->i_uid &&
-		    (error = vfs_permission(&nd, MAY_WRITE)) != 0)
-			goto dput_and_out;
-	}
-	mutex_lock(&inode->i_mutex);
-	error = notify_change(nd.dentry, &newattrs);
-	mutex_unlock(&inode->i_mutex);
-dput_and_out:
-	path_release(&nd);
-out:
-	return error;
-}
-
-asmlinkage long sys_futimesat(int dfd, char __user *filename, struct timeval __user *utimes)
-{
-	struct timeval times[2];
-
-	if (utimes && copy_from_user(&times, utimes, sizeof(times)))
-		return -EFAULT;
-	return do_utimes(dfd, filename, utimes ? times : NULL);
-}
-
-asmlinkage long sys_utimes(char __user *filename, struct timeval __user *utimes)
-{
-	return sys_futimesat(AT_FDCWD, filename, utimes);
-}
-
-
 /*
  * access() needs to use the real uid/gid, not the effective uid/gid.
  * We do this by temporarily clearing all FS-related capabilities and
--- /dev/null
+++ b/fs/utimes.c
@@ -0,0 +1,137 @@
+#include <linux/compiler.h>
+#include <linux/fs.h>
+#include <linux/linkage.h>
+#include <linux/namei.h>
+#include <linux/utime.h>
+#include <asm/uaccess.h>
+#include <asm/unistd.h>
+
+#ifdef __ARCH_WANT_SYS_UTIME
+
+/*
+ * sys_utime() can be implemented in user-level using sys_utimes().
+ * Is this for backwards compatibility?  If so, why not move it
+ * into the appropriate arch directory (for those architectures that
+ * need it).
+ */
+
+/* If times==NULL, set access and modification to current time,
+ * must be owner or have write permission.
+ * Else, update from *times, must be owner or super user.
+ */
+asmlinkage long sys_utime(char __user * filename, struct utimbuf __user * times)
+{
+	int error;
+	struct nameidata nd;
+	struct inode * inode;
+	struct iattr newattrs;
+
+	error = user_path_walk(filename, &nd);
+	if (error)
+		goto out;
+	inode = nd.dentry->d_inode;
+
+	error = -EROFS;
+	if (IS_RDONLY(inode))
+		goto dput_and_out;
+
+	/* Don't worry, the checks are done in inode_change_ok() */
+	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
+	if (times) {
+		error = -EPERM;
+		if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
+			goto dput_and_out;
+
+		error = get_user(newattrs.ia_atime.tv_sec, &times->actime);
+		newattrs.ia_atime.tv_nsec = 0;
+		if (!error)
+			error = get_user(newattrs.ia_mtime.tv_sec, &times->modtime);
+		newattrs.ia_mtime.tv_nsec = 0;
+		if (error)
+			goto dput_and_out;
+
+		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
+	} else {
+                error = -EACCES;
+                if (IS_IMMUTABLE(inode))
+                        goto dput_and_out;
+
+		if (current->fsuid != inode->i_uid &&
+		    (error = vfs_permission(&nd, MAY_WRITE)) != 0)
+			goto dput_and_out;
+	}
+	mutex_lock(&inode->i_mutex);
+	error = notify_change(nd.dentry, &newattrs);
+	mutex_unlock(&inode->i_mutex);
+dput_and_out:
+	path_release(&nd);
+out:
+	return error;
+}
+
+#endif
+
+/* If times==NULL, set access and modification to current time,
+ * must be owner or have write permission.
+ * Else, update from *times, must be owner or super user.
+ */
+long do_utimes(int dfd, char __user *filename, struct timeval *times)
+{
+	int error;
+	struct nameidata nd;
+	struct inode * inode;
+	struct iattr newattrs;
+
+	error = __user_walk_fd(dfd, filename, LOOKUP_FOLLOW, &nd);
+
+	if (error)
+		goto out;
+	inode = nd.dentry->d_inode;
+
+	error = -EROFS;
+	if (IS_RDONLY(inode))
+		goto dput_and_out;
+
+	/* Don't worry, the checks are done in inode_change_ok() */
+	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
+	if (times) {
+		error = -EPERM;
+                if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
+                        goto dput_and_out;
+
+		newattrs.ia_atime.tv_sec = times[0].tv_sec;
+		newattrs.ia_atime.tv_nsec = times[0].tv_usec * 1000;
+		newattrs.ia_mtime.tv_sec = times[1].tv_sec;
+		newattrs.ia_mtime.tv_nsec = times[1].tv_usec * 1000;
+		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
+	} else {
+		error = -EACCES;
+                if (IS_IMMUTABLE(inode))
+                        goto dput_and_out;
+
+		if (current->fsuid != inode->i_uid &&
+		    (error = vfs_permission(&nd, MAY_WRITE)) != 0)
+			goto dput_and_out;
+	}
+	mutex_lock(&inode->i_mutex);
+	error = notify_change(nd.dentry, &newattrs);
+	mutex_unlock(&inode->i_mutex);
+dput_and_out:
+	path_release(&nd);
+out:
+	return error;
+}
+
+asmlinkage long sys_futimesat(int dfd, char __user *filename, struct timeval __user *utimes)
+{
+	struct timeval times[2];
+
+	if (utimes && copy_from_user(&times, utimes, sizeof(times)))
+		return -EFAULT;
+	return do_utimes(dfd, filename, utimes ? times : NULL);
+}
+
+asmlinkage long sys_utimes(char __user *filename, struct timeval __user *utimes)
+{
+	return sys_futimesat(AT_FDCWD, filename, utimes);
+}
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -1,6 +1,7 @@
 #ifndef _LINUX_NAMEI_H
 #define _LINUX_NAMEI_H
 
+#include <linux/dcache.h>
 #include <linux/linkage.h>
 
 struct vfsmount;
--- a/include/linux/utime.h
+++ b/include/linux/utime.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_UTIME_H
 #define _LINUX_UTIME_H
 
+#include <linux/types.h>
+
 struct utimbuf {
 	time_t actime;
 	time_t modtime;

