Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422972AbWJYQcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422972AbWJYQcc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 12:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423161AbWJYQcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 12:32:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:62758 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422972AbWJYQcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 12:32:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=PEZk6VxRp7rjSWtuOKMCk4+E52a3sI5VgwRYweohR4p8i3TMEjB04H8qm1JZTY1ekcetvq4kKUmlymRBaYbeMMmfDJ3k8HMskFWVm7+7KEkBpAw0mh2PT3YbvZLGFJe9Z5LQjBoJhl1l3kFnHxgVXOu3/9wKbZA4xi4gMp9S52Q=
Date: Wed, 25 Oct 2006 20:32:24 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Shrink sys_utime()
Message-ID: <20061025163224.GA5356@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All checks in sys_utime() and do_utimes() are duplicated as well as a
comment. sys_utime() will now use do_utimes() after getting times from
userspace and projecting them to struct timeval [2].

__kernel_time_t seems to be long on all archs.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/utimes.c |   90 ++++++++++++++++--------------------------------------------
 1 file changed, 25 insertions(+), 65 deletions(-)

--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -6,71 +6,6 @@ #include <linux/utime.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 
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
 /* If times==NULL, set access and modification to current time,
  * must be owner or have write permission.
  * Else, update from *times, must be owner or super user.
@@ -122,6 +57,31 @@ out:
 	return error;
 }
 
+#ifdef __ARCH_WANT_SYS_UTIME
+
+/*
+ * sys_utime() can be implemented in user-level using sys_utimes().
+ * Is this for backwards compatibility?  If so, why not move it
+ * into the appropriate arch directory (for those architectures that
+ * need it).
+ */
+asmlinkage long sys_utime(char __user * filename, struct utimbuf __user * utimes)
+{
+	struct timeval times[2];
+
+	if (utimes) {
+		if (get_user(times[0].tv_sec, &utimes->actime))
+			return -EFAULT;
+		times[0].tv_usec = 0;
+		if (get_user(times[1].tv_sec, &utimes->modtime))
+			return -EFAULT;
+		times[1].tv_usec = 0;
+	}
+	return do_utimes(AT_FDCWD, filename, utimes ? times : NULL);
+}
+
+#endif
+
 asmlinkage long sys_futimesat(int dfd, char __user *filename, struct timeval __user *utimes)
 {
 	struct timeval times[2];

