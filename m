Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbVJLQHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbVJLQHe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 12:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbVJLQHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 12:07:34 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:12978 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751481AbVJLQHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 12:07:33 -0400
Date: Wed, 12 Oct 2005 12:07:17 -0400 (Eastern Daylight Time)
From: Janak Desai <janak@us.ibm.com>
To: chrisw@osdl.org, viro@ZenIV.linux.org.uk, nickpiggin@yahoo.com.au
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] New System call unshare (try 2)
Message-ID: <Pine.WNT.4.63.0510121201540.1316@IBM-AIP3070F3AM>
X-X-Sender: janak@imap.linux.ibm.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Chris,

Here is the reworked unshare system call patch which attempts to fix
problems that you identified with the first incarnation. The patch, against
the latest mm tree 2.6.14-rc2-mm2, was tested on single processor i386
system for the following:
	Don't allow namespace unsharing, if sharing fs (CLONE_FS)
	Don't allow sighand unsharing if not unsharing vm
	Don't allow vm unsharing if task cloned with CLONE_THREAD
	Don't allow vm unsharing if the task is performing async io
	Successful unsharing of namespace
		Cloned a task without sharing fs. Performed mounts before
		and after a call to unshare to verify that the namespace
		was indeed unshared.
	Successful unsharing of vm
		Cloned a task using CLONE_VM, CLONE_SIGHAND and CLONE_FILES.
		Used a shared memory segment and futex within it to 
		synchronize execution of threads. Verified shared and 
		unshared vm before and after successful unshare call.

Would appreciate feedback.

Thanks.

-Janak

--------------------------------------------------------------------------
diff -Naurp 2.6.14-rc2-mm2/fs/namespace.c 2.6.14-rc2-mm2+unshare/fs/namespace.c
--- 2.6.14-rc2-mm2/fs/namespace.c	2005-10-12 02:56:08.000000000 +0000
+++ 2.6.14-rc2-mm2+unshare/fs/namespace.c	2005-10-12 11:46:52.000000000 +0000
@@ -1069,9 +1069,6 @@ int copy_namespace(int flags, struct tas
 {
 	struct namespace *namespace = tsk->namespace;
 	struct namespace *new_ns;
-	struct vfsmount *rootmnt = NULL, *pwdmnt = NULL, *altrootmnt = NULL;
-	struct fs_struct *fs = tsk->fs;
-	struct vfsmount *p, *q;
 
 	if (!namespace)
 		return 0;
@@ -1086,6 +1083,28 @@ int copy_namespace(int flags, struct tas
 		return -EPERM;
 	}
 
+	new_ns = dup_namespace_struct(tsk);
+	if (!new_ns)
+		goto out;
+
+	tsk->namespace = new_ns;
+
+	put_namespace(namespace);
+	return 0;
+
+out:
+	put_namespace(namespace);
+	return -ENOMEM;
+}
+
+struct namespace *dup_namespace_struct(struct task_struct *tsk)
+{
+	struct namespace *namespace = tsk->namespace;
+	struct namespace *new_ns;
+	struct vfsmount *rootmnt = NULL, *pwdmnt = NULL, *altrootmnt = NULL;
+	struct fs_struct *fs = tsk->fs;
+	struct vfsmount *p, *q;
+
 	new_ns = kmalloc(sizeof(struct namespace), GFP_KERNEL);
 	if (!new_ns)
 		goto out;
@@ -1134,8 +1153,6 @@ int copy_namespace(int flags, struct tas
 	}
 	up_write(&tsk->namespace->sem);
 
-	tsk->namespace = new_ns;
-
 	if (rootmnt)
 		mntput(rootmnt);
 	if (pwdmnt)
@@ -1143,12 +1160,10 @@ int copy_namespace(int flags, struct tas
 	if (altrootmnt)
 		mntput(altrootmnt);
 
-	put_namespace(namespace);
-	return 0;
+	return new_ns;
 
 out:
-	put_namespace(namespace);
-	return -ENOMEM;
+	return NULL;
 }
 
 asmlinkage long sys_mount(char __user * dev_name, char __user * dir_name,
diff -Naurp 2.6.14-rc2-mm2/include/linux/namespace.h 2.6.14-rc2-mm2+unshare/include/linux/namespace.h
--- 2.6.14-rc2-mm2/include/linux/namespace.h	2005-10-12 02:56:35.000000000 +0000
+++ 2.6.14-rc2-mm2+unshare/include/linux/namespace.h	2005-10-12 11:45:46.000000000 +0000
@@ -14,6 +14,7 @@ struct namespace {
 
 extern int copy_namespace(int, struct task_struct *);
 extern void __put_namespace(struct namespace *namespace);
+extern struct namespace *dup_namespace_struct(struct task_struct *);
 
 static inline void put_namespace(struct namespace *namespace)
 {
diff -Naurp 2.6.14-rc2-mm2/kernel/fork.c 2.6.14-rc2-mm2+unshare/kernel/fork.c
--- 2.6.14-rc2-mm2/kernel/fork.c	2005-10-12 02:56:39.000000000 +0000
+++ 2.6.14-rc2-mm2+unshare/kernel/fork.c	2005-10-12 13:26:05.000000000 +0000
@@ -448,6 +448,55 @@ void mm_release(struct task_struct *tsk,
 	}
 }
 
+/*
+ * Allocate a new mm structure and copy contents from the
+ * mm structure of the passed in task structure.
+ */
+static struct mm_struct *dup_mm_struct(struct task_struct *tsk)
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
@@ -482,43 +531,17 @@ static int copy_mm(unsigned long clone_f
 	}
 
 	retval = -ENOMEM;
-	mm = allocate_mm();
+	mm = dup_mm_struct(tsk);
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
@@ -753,6 +776,23 @@ int unshare_files(void)
 
 EXPORT_SYMBOL(unshare_files);
 
+/*
+ * Allocate a new sighand structure and copy contents from the
+ * sighand of the passed in task structure
+ */
+static struct sighand_struct *dup_sh_struct(struct task_struct *tsk)
+{
+	struct sighand_struct *sh;
+
+	sh = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
+	if (!sh)
+		return NULL;
+	spin_lock_init(&sh->siglock);
+	atomic_set(&sh->count, 1);
+	memcpy(sh->action, current->sighand->action, sizeof(sh->action));
+	return sh;
+}
+
 static inline int copy_sighand(unsigned long clone_flags, struct task_struct * tsk)
 {
 	struct sighand_struct *sig;
@@ -761,13 +801,10 @@ static inline int copy_sighand(unsigned 
 		atomic_inc(&current->sighand->count);
 		return 0;
 	}
-	sig = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
+	sig = dup_sh_struct(tsk);
 	tsk->sighand = sig;
 	if (!sig)
 		return -ENOMEM;
-	spin_lock_init(&sig->siglock);
-	atomic_set(&sig->count, 1);
-	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
 	return 0;
 }
 
@@ -1321,3 +1358,164 @@ void __init proc_caches_init(void)
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
+	if (unshare_flags & ~(CLONE_NEWNS | CLONE_VM | CLONE_SIGHAND))
+		goto errout;
+
+	/*
+	 * Shared signal handlers imply shared VM, so if CLONE_SIGHAND is
+	 * set, CLONE_VM must also be set in the system call argument.
+	 */
+	if ((unshare_flags & CLONE_SIGHAND) && !(unshare_flags & CLONE_VM))
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
+	if (unshare_flags & CLONE_VM) {
+		/*
+	 	 * Cannot unshare vm if the signal structure is being shared
+	 	 * through a previous call to clone() with CLONE_THREAD.
+	 	 */
+	    	if (atomic_read(&current->signal->count) > 1)
+			goto errout;
+
+		/*
+		 * Cannot unshare vm only if the sighand structure is being
+		 * shared through a previous call to clone()
+		 */
+		if (!(unshare_flags & CLONE_SIGHAND) &&
+		     (atomic_read(&current->sighand->count) > 1))
+			goto errout;
+
+		/*
+		 * If the task is performing async io, unsharing of vm will
+		 * only allow the parent task, with which the vm was being
+		 * shared, to continue async io operations. The async io
+		 * context is not copied to the new, unshared, copy of vm.
+		 * So don't allow unsharing of vm if the process is setup
+		 * to perform async io.
+		 */
+		if (current->mm->ioctx_list)
+			goto errout;
+	}
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
+	int err = 0, unshare_ns = 0, unshare_mm = 0, unshare_sh = 0;
+	struct namespace *new_ns = NULL, *ns = current->namespace;
+	struct mm_struct *new_mm = NULL, *active_mm = NULL, *mm = current->mm;
+	struct sighand_struct *new_sh = NULL, *sh = current->sighand;
+
+	err = check_unshare_flags(unshare_flags);
+	if (err)
+		goto unshare_out;
+
+	if (unshare_flags & CLONE_NEWNS) {
+		if (ns && atomic_read(&ns->count) > 1) {
+			err = -EPERM;
+			if (!capable(CAP_SYS_ADMIN))
+				goto unshare_out;
+
+			err = -ENOMEM;
+			new_ns = dup_namespace_struct(current);
+			if (!new_ns)
+				goto unshare_out;
+			else
+				unshare_ns = 1;
+		}
+	}
+
+	if (unshare_flags & CLONE_VM) {
+		if (atomic_read(&mm->mm_users) > 1) {
+			err = -ENOMEM;
+			new_mm = dup_mm_struct(current);
+			if (!new_mm)
+				goto unshare_cleanup_ns;
+			else {
+				unshare_mm = 1;
+				if (unshare_flags & CLONE_SIGHAND) {
+					if (atomic_read(&sh->count) > 1) {
+						new_sh = dup_sh_struct(current);
+						if (!new_sh)
+							goto unshare_cleanup_mm;
+						else
+							unshare_sh = 1;
+					}
+				}
+			}
+		}
+	}
+
+	if (unshare_ns) {
+		task_lock(current);
+		current->namespace = new_ns;
+		task_unlock(current);
+		put_namespace(ns);
+	}
+
+	if (unshare_mm) {
+		task_lock(current);
+		current->min_flt = current->maj_flt = 0;
+		current->nvcsw = current->nivcsw = 0;
+		active_mm = current->active_mm;
+		current->mm = new_mm;
+		current->active_mm = new_mm;
+		activate_mm(active_mm, new_mm);
+		task_unlock(current);
+		mmput(mm);
+	}
+
+	if (unshare_sh) {
+		write_lock_irq(&tasklist_lock);
+		spin_lock(&sh->siglock);
+		spin_lock(&new_sh->siglock);
+		current->sighand = new_sh;
+		spin_unlock(&new_sh->siglock);
+		spin_unlock(&sh->siglock);
+		write_unlock_irq(&tasklist_lock);
+
+		if (atomic_dec_and_test(&sh->count))
+			kmem_cache_free(sighand_cachep, sh);
+	}
+
+	return 0;
+
+unshare_cleanup_mm:
+	if (unshare_mm)
+		mmput(new_mm);
+
+unshare_cleanup_ns:
+	if (unshare_ns)
+		put_namespace(new_ns);
+
+unshare_out:
+	return err;
+}

