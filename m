Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWIJNpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWIJNpE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 09:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWIJNpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 09:45:03 -0400
Received: from nef2.ens.fr ([129.199.96.40]:3591 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S932172AbWIJNpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 09:45:00 -0400
Date: Sun, 10 Sep 2006 15:44:58 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: [PATCH 3/4] security: capabilities patch (version 0.4.4), part 3/4: introduce new capabilities
Message-ID: <20060910134458.GD12086@clipper.ens.fr>
References: <20060910133759.GA12086@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910133759.GA12086@clipper.ens.fr>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sun, 10 Sep 2006 15:44:59 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Sorry!  Previous mail had the wrong patch...  This one is correct.]

Introduce six new "regular" (=on-by-default) capabilities:

 * CAP_REG_FORK, CAP_REG_OPEN, CAP_REG_EXEC allow access to the
   fork(), open() and exec() syscalls,

 * CAP_REG_SXID allows privilege gain on suid/sgid exec,

 * CAP_REG_WRITE controls any write-access to the filesystem,

 * CAP_REG_PTRACE allows ptrace().

See <URL: http://www.madore.org/~david/linux/newcaps/ > for more
detailed explanations.

Signed-off-by: David A. Madore <david.madore@ens.fr>

---
 fs/exec.c                  |    5 +++++
 fs/namei.c                 |    2 +-
 fs/open.c                  |   26 ++++++++++++++++++++------
 fs/xattr.c                 |    3 ++-
 include/linux/capability.h |   23 +++++++++++++++++++++++
 kernel/fork.c              |    2 ++
 kernel/ptrace.c            |    2 ++
 7 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e4d0a2c..1a7ff92 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -929,6 +929,9 @@ int prepare_binprm(struct linux_binprm *
 	bprm->is_sgid = 0;
 
 	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
+		if (!capable(CAP_REG_SXID))
+			return -EPERM;
+
 		/* Set-uid? */
 		if (mode & S_ISUID) {
 			bprm->is_suid = 1;
@@ -1137,6 +1140,8 @@ int do_execve(char * filename,
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
index aa00b60..efc268e 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -295,6 +295,29 @@ #define CAP_AUDIT_WRITE      29
 
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
+/* Can use ptrace() */
+#define CAP_REG_PTRACE       37
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
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 9a111f7..093307d 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -132,6 +132,8 @@ static int may_attach(struct task_struct
 	/* Don't let security modules deny introspection */
 	if (task == current)
 		return 0;
+	if (!capable(CAP_REG_PTRACE))
+		return -EPERM;
 	if (((current->uid != task->euid) ||
 	     (current->uid != task->suid) ||
 	     (current->uid != task->uid) ||
