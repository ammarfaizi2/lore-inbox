Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVLMDCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVLMDCD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 22:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVLMDAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 22:00:38 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:3728 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932381AbVLMDAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 22:00:18 -0500
Subject: [PATCH -mm 7/9] unshare system call : allow unsharing of namespace
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134442736.14136.128.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 12 Dec 2005 22:00:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH -mm 7/9] unshare system call: allow unsharing of namespace


 fs/namespace.c            |   55
++++++++++++++++++++++++++++++----------------
 include/linux/namespace.h |    1 
 kernel/fork.c             |   16 +++++++++----
 3 files changed, 48 insertions(+), 24 deletions(-)
 
 
diff -Naurp 2.6.15-rc5-mm2+patch/fs/namespace.c
2.6.15-rc5-mm2+patch7/fs/namespace.c
--- 2.6.15-rc5-mm2+patch/fs/namespace.c	2005-12-12 18:27:20.000000000
+0000
+++ 2.6.15-rc5-mm2+patch7/fs/namespace.c	2005-12-12 22:01:00.000000000
+0000
@@ -1314,7 +1314,11 @@ dput_out:
 	return retval;
 }
 
-int copy_namespace(int flags, struct task_struct *tsk)
+/*
+ * Allocate a new namespace structure and populate it with contents
+ * copied from the namespace of the passed in task structure.
+ */
+struct namespace *dup_namespace(struct task_struct *tsk)
 {
 	struct namespace *namespace = tsk->namespace;
 	struct namespace *new_ns;
@@ -1322,19 +1326,6 @@ int copy_namespace(int flags, struct tas
 	struct fs_struct *fs = tsk->fs;
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
@@ -1385,8 +1376,6 @@ int copy_namespace(int flags, struct tas
 	}
 	up_write(&namespace_sem);
 
-	tsk->namespace = new_ns;
-
 	if (rootmnt)
 		mntput(rootmnt);
 	if (pwdmnt)
@@ -1394,12 +1383,40 @@ int copy_namespace(int flags, struct tas
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
+	new_ns = dup_namespace(tsk);
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
 
 asmlinkage long sys_mount(char __user * dev_name, char __user *
dir_name,
diff -Naurp 2.6.15-rc5-mm2+patch/include/linux/namespace.h
2.6.15-rc5-mm2+patch7/include/linux/namespace.h
--- 2.6.15-rc5-mm2+patch/include/linux/namespace.h	2005-12-12
18:27:38.000000000 +0000
+++ 2.6.15-rc5-mm2+patch7/include/linux/namespace.h	2005-12-12
22:01:57.000000000 +0000
@@ -15,6 +15,7 @@ struct namespace {
 
 extern int copy_namespace(int, struct task_struct *);
 extern void __put_namespace(struct namespace *namespace);
+extern struct namespace *dup_namespace(struct task_struct *);
 
 static inline void put_namespace(struct namespace *namespace)
 {
diff -Naurp 2.6.15-rc5-mm2+patch/kernel/fork.c
2.6.15-rc5-mm2+patch7/kernel/fork.c
--- 2.6.15-rc5-mm2+patch/kernel/fork.c	2005-12-12 19:31:48.000000000
+0000
+++ 2.6.15-rc5-mm2+patch7/kernel/fork.c	2005-12-12 21:58:44.000000000
+0000
@@ -1392,16 +1392,22 @@ static int unshare_fs(unsigned long unsh
 }
 
 /*
- * Unsharing of namespace for tasks created without CLONE_NEWNS is not
- * supported yet
+ * Unshare the namespace structure if it is being shared
  */
 static int unshare_namespace(unsigned long unshare_flags, struct
namespace **new_nsp)
 {
-	struct namespace *ns = current->namespace;
+	struct namespace *ns = current->namespace, *new_ns;
 
 	if ((unshare_flags & CLONE_NEWNS) &&
-	    (ns && atomic_read(&ns->count) > 1))
-		return -EINVAL;
+	    (ns && atomic_read(&ns->count) > 1)) {
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
+		new_ns = dup_namespace(current);
+		if (!new_ns)
+			return -ENOMEM;
+		*new_nsp = new_ns;
+	}
 
 	return 0;
 }


