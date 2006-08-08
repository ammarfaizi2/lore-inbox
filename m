Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWHHLmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWHHLmn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 07:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWHHLmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 07:42:43 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:54351 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964834AbWHHLmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 07:42:42 -0400
Message-ID: <44D87907.6090706@sw.ru>
Date: Tue, 08 Aug 2006 15:44:07 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, viro@zeniv.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mishin Dmitry <dim@openvz.org>
Subject: [PATCH] move IMMUTABLE|APPEND checks to notify_change()
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] move IMMUTABLE|APPEND checks to notify_change()

This patch moves lots of IMMUTABLE and APPEND flag checks
scattered all around to more logical place in notify_change().

Signed-Off-By: Dmitry Mishin <dim@openvz.org>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>


--- ./fs/attr.c.immut	2006-06-18 05:49:35.000000000 +0400
+++ ./fs/attr.c	2006-08-08 15:15:59.000000000 +0400
@@ -109,6 +109,9 @@ int notify_change(struct dentry * dentry
 	struct timespec now;
 	unsigned int ia_valid = attr->ia_valid;
 
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+		return -EPERM;
+
 	mode = inode->i_mode;
 	now = current_fs_time(inode->i_sb);
 
--- ./fs/open.c.immut	2006-07-14 19:08:29.000000000 +0400
+++ ./fs/open.c	2006-08-08 15:19:58.000000000 +0400
@@ -252,10 +252,6 @@ static long do_sys_truncate(const char _
 	if (IS_RDONLY(inode))
 		goto dput_and_out;
 
-	error = -EPERM;
-	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
-		goto dput_and_out;
-
 	/*
 	 * Make sure that there are no leases.
 	 */
@@ -316,10 +312,6 @@ static long do_sys_ftruncate(unsigned in
 	if (small && length > MAX_NON_LFS)
 		goto out_putf;
 
-	error = -EPERM;
-	if (IS_APPEND(inode))
-		goto out_putf;
-
 	error = locks_verify_truncate(inode, file, length);
 	if (!error)
 		error = do_truncate(dentry, length, ATTR_MTIME|ATTR_CTIME, file);
@@ -385,10 +377,6 @@ asmlinkage long sys_utime(char __user * 
 	/* Don't worry, the checks are done in inode_change_ok() */
 	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
 	if (times) {
-		error = -EPERM;
-		if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
-			goto dput_and_out;
-
 		error = get_user(newattrs.ia_atime.tv_sec, &times->actime);
 		newattrs.ia_atime.tv_nsec = 0;
 		if (!error)
@@ -398,15 +386,9 @@ asmlinkage long sys_utime(char __user * 
 			goto dput_and_out;
 
 		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
-	} else {
-                error = -EACCES;
-                if (IS_IMMUTABLE(inode))
-                        goto dput_and_out;
-
-		if (current->fsuid != inode->i_uid &&
+	} else if (current->fsuid != inode->i_uid &&
 		    (error = vfs_permission(&nd, MAY_WRITE)) != 0)
-			goto dput_and_out;
-	}
+		goto dput_and_out;
 	mutex_lock(&inode->i_mutex);
 	error = notify_change(nd.dentry, &newattrs);
 	mutex_unlock(&inode->i_mutex);
@@ -442,24 +424,14 @@ long do_utimes(int dfd, char __user *fil
 	/* Don't worry, the checks are done in inode_change_ok() */
 	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
 	if (times) {
-		error = -EPERM;
-                if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
-                        goto dput_and_out;
-
 		newattrs.ia_atime.tv_sec = times[0].tv_sec;
 		newattrs.ia_atime.tv_nsec = times[0].tv_usec * 1000;
 		newattrs.ia_mtime.tv_sec = times[1].tv_sec;
 		newattrs.ia_mtime.tv_nsec = times[1].tv_usec * 1000;
 		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
-	} else {
-		error = -EACCES;
-                if (IS_IMMUTABLE(inode))
-                        goto dput_and_out;
-
-		if (current->fsuid != inode->i_uid &&
+	} else if (current->fsuid != inode->i_uid &&
 		    (error = vfs_permission(&nd, MAY_WRITE)) != 0)
-			goto dput_and_out;
-	}
+		goto dput_and_out;
 	mutex_lock(&inode->i_mutex);
 	error = notify_change(nd.dentry, &newattrs);
 	mutex_unlock(&inode->i_mutex);
@@ -638,9 +610,6 @@ asmlinkage long sys_fchmod(unsigned int 
 	err = -EROFS;
 	if (IS_RDONLY(inode))
 		goto out_putf;
-	err = -EPERM;
-	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
-		goto out_putf;
 	mutex_lock(&inode->i_mutex);
 	if (mode == (mode_t) -1)
 		mode = inode->i_mode;
@@ -672,10 +641,6 @@ asmlinkage long sys_fchmodat(int dfd, co
 	if (IS_RDONLY(inode))
 		goto dput_and_out;
 
-	error = -EPERM;
-	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
-		goto dput_and_out;
-
 	mutex_lock(&inode->i_mutex);
 	if (mode == (mode_t) -1)
 		mode = inode->i_mode;
@@ -709,9 +674,6 @@ static int chown_common(struct dentry * 
 	error = -EROFS;
 	if (IS_RDONLY(inode))
 		goto out;
-	error = -EPERM;
-	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
-		goto out;
 	newattrs.ia_valid =  ATTR_CTIME;
 	if (user != (uid_t) -1) {
 		newattrs.ia_valid |= ATTR_UID;
