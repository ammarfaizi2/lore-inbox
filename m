Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbWALEQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbWALEQd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWALEQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:16:04 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:7880 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965021AbWALEP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:15:26 -0500
Subject: [PATCH -mm 4/10] unshare system call -v5 : unshare namespace
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: akpm@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org
Cc: chrisw@sous-sol.org, jamie@shareable.org, serue@us.ibm.com,
       sds@tycho.nsa.gov, sgrubb@redhat.com, ebiederm@xmission.com,
       janak@us.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1137038997.7488.210.camel@hobbes.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 11 Jan 2006 23:10:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH -mm 4/10] unshare system call: allow unsharing of namespace

If the namespace structure is being shared, allocate a new one and
copy information from the current, shared, structure.

Changes since -v4 of this patch submitted on 12/13/05:
	- none

Signed-off-by: Janak Desai <janak@us.ibm.com>

---

 fs/namespace.c            |   56 +++++++++++++++++++++++++++++-----------------
 include/linux/namespace.h |    1 
 kernel/fork.c             |   17 +++++++++----
 3 files changed, 48 insertions(+), 26 deletions(-)

diff -Naurp 2.6.15-mm3+unsh-fs/fs/namespace.c 2.6.15-mm3+unsh-ns/fs/namespace.c
--- 2.6.15-mm3+unsh-fs/fs/namespace.c	2006-01-12 00:24:06.000000000 +0000
+++ 2.6.15-mm3+unsh-ns/fs/namespace.c	2006-01-12 00:39:49.000000000 +0000
@@ -1321,27 +1321,17 @@ dput_out:
 	return retval;
 }
 
-int copy_namespace(int flags, struct task_struct *tsk)
+/*
+ * Allocate a new namespace structure and populate it with contents
+ * copied from the namespace of the passed in task structure.
+ */
+struct namespace *dup_namespace(struct task_struct *tsk, struct fs_struct *fs)
 {
 	struct namespace *namespace = tsk->namespace;
 	struct namespace *new_ns;
 	struct vfsmount *rootmnt = NULL, *pwdmnt = NULL, *altrootmnt = NULL;
-	struct fs_struct *fs = tsk->fs;
 	struct vfsmount *p, *q;
 
-	if (!namespace)
-		return 0;
-
-	get_namespace(namespace);
-
-	if (!(flags & CLONE_NEWNS))
-		return 0;
-
-	if (!capable(CAP_SYS_ADMIN)) {
-		put_namespace(namespace);
-		return -EPERM;
-	}
-
 	new_ns = kmalloc(sizeof(struct namespace), GFP_KERNEL);
 	if (!new_ns)
 		goto out;
@@ -1392,8 +1382,6 @@ int copy_namespace(int flags, struct tas
 	}
 	up_write(&namespace_sem);
 
-	tsk->namespace = new_ns;
-
 	if (rootmnt)
 		mntput(rootmnt);
 	if (pwdmnt)
@@ -1401,12 +1389,40 @@ int copy_namespace(int flags, struct tas
 	if (altrootmnt)
 		mntput(altrootmnt);
 
-	put_namespace(namespace);
-	return 0;
+out:
+	return new_ns;
+}
+
+int copy_namespace(int flags, struct task_struct *tsk)
+{
+	struct namespace *namespace = tsk->namespace;
+	struct namespace *new_ns;
+	int err = 0;
+
+	if (!namespace)
+		return 0;
+
+	get_namespace(namespace);
+
+	if (!(flags & CLONE_NEWNS))
+		return 0;
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		err = -EPERM;
+		goto out;
+	}
+
+	new_ns = dup_namespace(tsk, tsk->fs);
+	if (!new_ns) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	tsk->namespace = new_ns;
 
 out:
 	put_namespace(namespace);
-	return -ENOMEM;
+	return err;
 }
 
 asmlinkage long sys_mount(char __user * dev_name, char __user * dir_name,
diff -Naurp 2.6.15-mm3+unsh-fs/include/linux/namespace.h 2.6.15-mm3+unsh-ns/include/linux/namespace.h
--- 2.6.15-mm3+unsh-fs/include/linux/namespace.h	2006-01-12 00:25:13.000000000 +0000
+++ 2.6.15-mm3+unsh-ns/include/linux/namespace.h	2006-01-12 00:39:49.000000000 +0000
@@ -15,6 +15,7 @@ struct namespace {
 
 extern int copy_namespace(int, struct task_struct *);
 extern void __put_namespace(struct namespace *namespace);
+extern struct namespace *dup_namespace(struct task_struct *, struct fs_struct *);
 
 static inline void put_namespace(struct namespace *namespace)
 {
diff -Naurp 2.6.15-mm3+unsh-fs/kernel/fork.c 2.6.15-mm3+unsh-ns/kernel/fork.c
--- 2.6.15-mm3+unsh-fs/kernel/fork.c	2006-01-12 00:26:46.000000000 +0000
+++ 2.6.15-mm3+unsh-ns/kernel/fork.c	2006-01-12 00:39:49.000000000 +0000
@@ -1388,16 +1388,21 @@ static int unshare_fs(unsigned long unsh
 }
 
 /*
- * Unsharing of namespace for tasks created without CLONE_NEWNS is not
- * supported yet
+ * Unshare the namespace structure if it is being shared
  */
-static int unshare_namespace(unsigned long unshare_flags, struct namespace **new_nsp)
+static int unshare_namespace(unsigned long unshare_flags, struct namespace **new_nsp, struct fs_struct *new_fs)
 {
 	struct namespace *ns = current->namespace;
 
 	if ((unshare_flags & CLONE_NEWNS) &&
-	    (ns && atomic_read(&ns->count) > 1))
-		return -EINVAL;
+	    (ns && atomic_read(&ns->count) > 1)) {
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
+		*new_nsp = dup_namespace(current, new_fs ? new_fs : current->fs);
+		if (!*new_nsp)
+			return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -1482,7 +1487,7 @@ asmlinkage long sys_unshare(unsigned lon
 		goto bad_unshare_out;
 	if ((err = unshare_fs(unshare_flags, &new_fs)))
 		goto bad_unshare_cleanup_thread;
-	if ((err = unshare_namespace(unshare_flags, &new_ns)))
+	if ((err = unshare_namespace(unshare_flags, &new_ns, new_fs)))
 		goto bad_unshare_cleanup_fs;
 	if ((err = unshare_sighand(unshare_flags, &new_sigh)))
 		goto bad_unshare_cleanup_ns;


