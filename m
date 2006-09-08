Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752160AbWIHEZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbWIHEZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 00:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbWIHEZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 00:25:56 -0400
Received: from nef2.ens.fr ([129.199.96.40]:11275 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1752160AbWIHEZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 00:25:55 -0400
Date: Fri, 8 Sep 2006 06:25:53 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: [PATCH] new capability patch, version 0.4.2 (now with fs support), part 3/4
Message-ID: <20060908042553.GF24135@clipper.ens.fr>
References: <20060908042205.GD24135@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908042205.GD24135@clipper.ens.fr>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Fri, 08 Sep 2006 06:25:54 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the new version (0.4.2) of my capabilities patch,
part 3/4 (introduces some new capabilities).

Explanations are on <URL: http://www.madore.org/~david/linux/newcaps/ >.

 fs/exec.c                  |    7 +++++--
 fs/namei.c                 |    2 +-
 fs/open.c                  |   26 ++++++++++++++++++++------
 fs/xattr.c                 |    3 ++-
 include/linux/capability.h |   20 ++++++++++++++++++++
 kernel/fork.c              |    2 ++
 6 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e4d0a2c..1cb5e34 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -930,7 +930,7 @@ int prepare_binprm(struct linux_binprm *
 
 	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
 		/* Set-uid? */
-		if (mode & S_ISUID) {
+		if (mode & S_ISUID && capable(CAP_REG_SXID)) {
 			bprm->is_suid = 1;
 			current->personality &= ~PER_CLEAR_ON_SETID;
 			bprm->e_uid = inode->i_uid;
@@ -942,7 +942,8 @@ int prepare_binprm(struct linux_binprm *
 		 * is a candidate for mandatory locking, not a setgid
 		 * executable.
 		 */
-		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
+		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)
+		    && capable(CAP_REG_SXID)) {
 			bprm->is_sgid = 1;
 			current->personality &= ~PER_CLEAR_ON_SETID;
 			bprm->e_gid = inode->i_gid;
@@ -1137,6 +1138,8 @@ int do_execve(char * filename,
 	int retval;
 	int i;
 
+	if (!capable(CAP_REG_EXEC))
+		return -EPERM;
 	retval = -ENOMEM;
 	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
 	if (!bprm)
diff --git a/fs/namei.c b/fs/namei.c
index 432d6bc..69a3bae 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -242,7 +242,7 @@ int permission(struct inode *inode, int 
 		/*
 		 * Nobody gets write access to an immutable file.
 		 */
-		if (IS_IMMUTABLE(inode))
+		if (IS_IMMUTABLE(inode) || !capable(CAP_REG_WRITE))
 			return -EACCES;
 	}
 
diff --git a/fs/open.c b/fs/open.c
index e58a525..77a12ba 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -253,7 +253,7 @@ static long do_sys_truncate(const char _
 		goto dput_and_out;
 
 	error = -EPERM;
-	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode) || !capable(CAP_REG_WRITE))
 		goto dput_and_out;
 
 	/*
@@ -382,6 +382,10 @@ asmlinkage long sys_utime(char __user * 
 	if (IS_RDONLY(inode))
 		goto dput_and_out;
 
+	error = -EPERM;
+	if (!capable(CAP_REG_WRITE))
+		goto dput_and_out;
+
 	/* Don't worry, the checks are done in inode_change_ok() */
 	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
 	if (times) {
@@ -439,6 +443,10 @@ long do_utimes(int dfd, char __user *fil
 	if (IS_RDONLY(inode))
 		goto dput_and_out;
 
+	error = -EPERM;
+	if (!capable(CAP_REG_WRITE))
+		goto dput_and_out;
+
 	/* Don't worry, the checks are done in inode_change_ok() */
 	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
 	if (times) {
@@ -640,7 +648,7 @@ asmlinkage long sys_fchmod(unsigned int 
 	if (IS_RDONLY(inode))
 		goto out_putf;
 	err = -EPERM;
-	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode) || !capable(CAP_REG_WRITE))
 		goto out_putf;
 	mutex_lock(&inode->i_mutex);
 	if (mode == (mode_t) -1)
@@ -674,7 +682,7 @@ asmlinkage long sys_fchmodat(int dfd, co
 		goto dput_and_out;
 
 	error = -EPERM;
-	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode) || !capable(CAP_REG_WRITE))
 		goto dput_and_out;
 
 	mutex_lock(&inode->i_mutex);
@@ -711,7 +719,7 @@ static int chown_common(struct dentry * 
 	if (IS_RDONLY(inode))
 		goto out;
 	error = -EPERM;
-	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode) || !capable(CAP_REG_WRITE))
 		goto out;
 	newattrs.ia_valid =  ATTR_CTIME;
 	if (user != (uid_t) -1) {
@@ -1105,7 +1113,10 @@ asmlinkage long sys_open(const char __us
 	if (force_o_largefile())
 		flags |= O_LARGEFILE;
 
-	ret = do_sys_open(AT_FDCWD, filename, flags, mode);
+	if (capable(CAP_REG_OPEN))
+		ret = do_sys_open(AT_FDCWD, filename, flags, mode);
+	else
+		ret = -EPERM;
 	/* avoid REGPARM breakage on x86: */
 	prevent_tail_call(ret);
 	return ret;
@@ -1120,7 +1131,10 @@ asmlinkage long sys_openat(int dfd, cons
 	if (force_o_largefile())
 		flags |= O_LARGEFILE;
 
-	ret = do_sys_open(dfd, filename, flags, mode);
+	if (capable(CAP_REG_OPEN))
+		ret = do_sys_open(dfd, filename, flags, mode);
+	else
+		ret = -EPERM;
 	/* avoid REGPARM breakage on x86: */
 	prevent_tail_call(ret);
 	return ret;
diff --git a/fs/xattr.c b/fs/xattr.c
index c32f15b..33b70ce 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -35,7 +35,8 @@ xattr_permission(struct inode *inode, co
 	if (mask & MAY_WRITE) {
 		if (IS_RDONLY(inode))
 			return -EROFS;
-		if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+		if (IS_IMMUTABLE(inode) || IS_APPEND(inode)
+		    || !capable(CAP_REG_WRITE))
 			return -EPERM;
 	}
 
diff --git a/include/linux/capability.h b/include/linux/capability.h
index e4f6065..c4b4ceb 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -295,6 +295,26 @@ #define CAP_AUDIT_WRITE      29
 
 #define CAP_AUDIT_CONTROL    30
 
+
+/**
+ ** Regular capabilities (normally possessed by all processes).
+ **/
+
+/* Can fork() */
+#define CAP_REG_FORK         32
+
+/* Can open() */
+#define CAP_REG_OPEN         33
+
+/* Can exec() */
+#define CAP_REG_EXEC         34
+
+/* Might gain permissions on exec() */
+#define CAP_REG_SXID         35
+
+/* Perform write access to the filesystem */
+#define CAP_REG_WRITE        36
+
 #ifdef __KERNEL__
 /* 
  * Bounding set
diff --git a/kernel/fork.c b/kernel/fork.c
index f9b014e..20f559f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1347,6 +1347,8 @@ long do_fork(unsigned long clone_flags,
 	struct pid *pid = alloc_pid();
 	long nr;
 
+	if (!capable(CAP_REG_FORK))
+		return -EPERM;
 	if (!pid)
 		return -EAGAIN;
 	nr = pid->nr;


-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
