Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbVLHWJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVLHWJv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVLHWJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:09:51 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:42196 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751235AbVLHWJu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:09:50 -0500
Subject: [PATCH -mm 1/5] New system call, unshare
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: chrisw@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.org, janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134079791.5476.8.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 08 Dec 2005 17:09:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH -mm 1/5] unshare system call: System call handler function
sys_unshare

Signed-off-by: Janak Desai


 fs/namespace.c            |   55 +++++++++-----
 include/linux/namespace.h |    1 
 kernel/fork.c             |  175
++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 185 insertions(+), 46 deletions(-)


diff -Naurp 2.6.15-rc5-mm1/fs/namespace.c
2.6.15-rc5-mm1+unshare/fs/namespace.c
--- 2.6.15-rc5-mm1/fs/namespace.c	2005-12-06 21:06:14.000000000 +0000
+++ 2.6.15-rc5-mm1+unshare/fs/namespace.c	2005-12-07 15:42:03.000000000
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
diff -Naurp 2.6.15-rc5-mm1/include/linux/namespace.h
2.6.15-rc5-mm1+unshare/include/linux/namespace.h
--- 2.6.15-rc5-mm1/include/linux/namespace.h	2005-12-06
21:06:21.000000000 +0000
+++ 2.6.15-rc5-mm1+unshare/include/linux/namespace.h	2005-12-07
15:40:54.000000000 +0000
@@ -15,6 +15,7 @@ struct namespace {
 
 extern int copy_namespace(int, struct task_struct *);
 extern void __put_namespace(struct namespace *namespace);
+extern struct namespace *dup_namespace(struct task_struct *);
 
 static inline void put_namespace(struct namespace *namespace)
 {
diff -Naurp 2.6.15-rc5-mm1/kernel/fork.c
2.6.15-rc5-mm1+unshare/kernel/fork.c
--- 2.6.15-rc5-mm1/kernel/fork.c	2005-12-06 21:06:22.000000000 +0000
+++ 2.6.15-rc5-mm1+unshare/kernel/fork.c	2005-12-07 16:51:37.000000000
+0000
@@ -445,6 +445,55 @@ void mm_release(struct task_struct *tsk,
 	}
 }
 
+/*
+ * Allocate a new mm structure and copy contents from the
+ * mm structure of the passed in task structure.
+ */
+static struct mm_struct *dup_mm(struct task_struct *tsk)
+{
+	struct mm_struct *mm, *oldmm = current->mm;
+	int err;
+
+	if (!oldmm)
+		return NULL;
+
+	mm = allocate_mm();
+	if (!mm)
+		goto fail_nomem;
+
+	memcpy(mm, oldmm, sizeof(*mm));
+
+	if (!mm_init(mm))
+		goto fail_nomem;
+
+	if (init_new_context(tsk, mm))
+		goto fail_nocontext;
+
+	err = dup_mmap(mm, oldmm);
+	if (err)
+		goto free_pt;
+
+	mm->hiwater_rss = get_mm_rss(mm);
+	mm->hiwater_vm = mm->total_vm;
+
+	return mm;
+
+free_pt:
+	mmput(mm);
+
+fail_nomem:
+	return NULL;
+
+fail_nocontext:
+	/*
+	 * If init_new_context() failed, we cannot use mmput() to free the mm
+	 * because it calls destroy_context()
+	 */
+	mm_free_pgd(mm);
+	free_mm(mm);
+	return NULL;
+}
+
 static int copy_mm(unsigned long clone_flags, struct task_struct * tsk)
 {
 	struct mm_struct * mm, *oldmm;
@@ -472,43 +521,17 @@ static int copy_mm(unsigned long clone_f
 	}
 
 	retval = -ENOMEM;
-	mm = allocate_mm();
+	mm = dup_mm(tsk);
 	if (!mm)
 		goto fail_nomem;
 
-	/* Copy the current MM stuff.. */
-	memcpy(mm, oldmm, sizeof(*mm));
-	if (!mm_init(mm))
-		goto fail_nomem;
-
-	if (init_new_context(tsk,mm))
-		goto fail_nocontext;
-
-	retval = dup_mmap(mm, oldmm);
-	if (retval)
-		goto free_pt;
-
-	mm->hiwater_rss = get_mm_rss(mm);
-	mm->hiwater_vm = mm->total_vm;
-
 good_mm:
 	tsk->mm = mm;
 	tsk->active_mm = mm;
 	return 0;
 
-free_pt:
-	mmput(mm);
 fail_nomem:
 	return retval;
-
-fail_nocontext:
-	/*
-	 * If init_new_context() failed, we cannot use mmput() to free the mm
-	 * because it calls destroy_context()
-	 */
-	mm_free_pgd(mm);
-	free_mm(mm);
-	return retval;
 }
 
 static inline struct fs_struct *__copy_fs_struct(struct fs_struct *old)
@@ -1311,3 +1334,101 @@ void __init proc_caches_init(void)
 			sizeof(struct mm_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 }
+
+/*
+ * Performs sanity checks on the flags passed to the unshare system
+ * call.
+ */
+static inline int check_unshare_flags(unsigned long unshare_flags)
+{
+	int err = -EINVAL;
+
+	if (unshare_flags & ~(CLONE_NEWNS | CLONE_VM))
+		goto errout;
+
+	/*
+	 * Cannot unshare namespace if the fs structure is being shared
+	 * through a previous call to clone()
+	 */
+	if ((unshare_flags & CLONE_NEWNS) &&
+	    (atomic_read(&current->fs->count) > 1))
+		goto errout;
+
+	/*
+	 * Cannot unshare vm if sighnal handlers are being shared through
+	 * a previous call to clone()
+	 */
+	if ((unshare_flags & CLONE_VM) &&
+	    (atomic_read(&current->sighand->count) > 1))
+		goto errout;
+
+	return 0;
+
+errout:
+	return err;
+
+}
+
+/*
+ * unshare allows a process to 'unshare' part of the process
+ * context which was originally shared using clone.  copy_*
+ * functions used by do_fork() cannot be used here directly
+ * because they modify an inactive task_struct that is being
+ * constructed. Here we are modifying the current, active,
+ * task_struct.
+ */
+asmlinkage long sys_unshare(unsigned long unshare_flags)
+{
+	int err = 0;
+	struct namespace *new_ns = NULL, *ns = current->namespace;
+	struct mm_struct *new_mm = NULL, *active_mm = NULL, *mm = current->mm;
+
+	err = check_unshare_flags(unshare_flags);
+	if (err)
+		goto unshare_out;
+
+	if ((unshare_flags & CLONE_NEWNS) &&
+	    (ns && atomic_read(&ns->count) > 1)) {
+		err = -EPERM;
+		if (!capable(CAP_SYS_ADMIN))
+			goto unshare_out;
+
+		err = -ENOMEM;
+		new_ns = dup_namespace(current);
+		if (!new_ns)
+			goto unshare_out;
+	}
+
+	if ((unshare_flags & CLONE_VM) && (atomic_read(&mm->mm_users) > 1)) {
+		err = -ENOMEM;
+		new_mm = dup_mm(current);
+		if (!new_mm)
+			goto unshare_cleanup_ns;
+	}
+
+	if (new_ns) {
+		task_lock(current);
+		current->namespace = new_ns;
+		task_unlock(current);
+		put_namespace(ns);
+	}
+
+	if (new_mm) {
+		task_lock(current);
+		active_mm = current->active_mm;
+		current->mm = new_mm;
+		current->active_mm = new_mm;
+		activate_mm(active_mm, new_mm);
+		task_unlock(current);
+		mmput(mm);
+	}
+
+	return 0;
+
+unshare_cleanup_ns:
+	if (new_ns)
+		put_namespace(new_ns);
+
+unshare_out:
+	return err;
+}


