Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbVIGRvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVIGRvO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVIGRvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:51:14 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:36806 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751263AbVIGRvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:51:13 -0400
Date: Wed, 7 Sep 2005 13:51:06 -0400 (Eastern Daylight Time)
From: Janak Desai <janak@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] (repost) New System call, unshare (fwd)
Message-ID: <Pine.WNT.4.63.0509071350080.4008@IBM-AIP3070F3AM>
X-X-Sender: janak@imap.linux.ibm.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Forgot to copy lkml.

-Janak

---------- Forwarded message ----------
Date: Wed, 7 Sep 2005 13:40:49 -0400 (Eastern Daylight Time)
From: Janak Desai <janak@us.ibm.com>
To: viro@ZenIV.linux.org.uk, akpm@osdl.org
Cc: hch@infradead.org
Subject: [PATCH 1/2] (repost) New System call, unshare



[PATCH 1/2] unshare system call: System Call handler function sys_unshare

Signed-off-by: Janak Desai


 fork.c |  202 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 196 insertions(+), 6 deletions(-)



diff -Naurp linux-2.6.13-mm1/kernel/fork.c linux-2.6.13-mm1+unshare-patch1/kernel/fork.c
--- linux-2.6.13-mm1/kernel/fork.c	2005-09-07 13:25:01.000000000 +0000
+++ linux-2.6.13-mm1+unshare-patch1/kernel/fork.c	2005-09-07 13:40:11.000000000 +0000
@@ -58,6 +58,17 @@ int nr_threads; 		/* The idle threads do
 
 int max_threads;		/* tunable limit on nr_threads */
 
+/*
+ * mm_copy gets called from clone or unshare system calls. When called
+ * from clone, mm_struct may be shared depending on the clone flags
+ * argument, however, when called from the unshare system call, a private
+ * copy of mm_struct is made.
+ */
+enum mm_copy_share {
+	MAY_SHARE,
+	UNSHARE,
+};
+
 DEFINE_PER_CPU(unsigned long, process_counts) = 0;
 
  __cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
@@ -448,16 +459,26 @@ void mm_release(struct task_struct *tsk,
 	}
 }
 
-static int copy_mm(unsigned long clone_flags, struct task_struct * tsk)
+static int copy_mm(unsigned long clone_flags, struct task_struct * tsk,
+			enum mm_copy_share copy_share_action)
 {
 	struct mm_struct * mm, *oldmm;
 	int retval;
 
-	tsk->min_flt = tsk->maj_flt = 0;
-	tsk->nvcsw = tsk->nivcsw = 0;
+	/*
+	 * If the process memory is being duplicated as part of the
+	 * unshare system call, we are working with the current process
+	 * and not a newly allocated task strucutre, and should not
+	 * zero out fault info, context switch counts, mm and active_mm
+	 * fields.
+	 */
+	if (copy_share_action == MAY_SHARE) {
+		tsk->min_flt = tsk->maj_flt = 0;
+		tsk->nvcsw = tsk->nivcsw = 0;
 
-	tsk->mm = NULL;
-	tsk->active_mm = NULL;
+		tsk->mm = NULL;
+		tsk->active_mm = NULL;
+	}
 
 	/*
 	 * Are we cloning a kernel thread?
@@ -1002,7 +1023,7 @@ static task_t *copy_process(unsigned lon
 		goto bad_fork_cleanup_fs;
 	if ((retval = copy_signal(clone_flags, p)))
 		goto bad_fork_cleanup_sighand;
-	if ((retval = copy_mm(clone_flags, p)))
+	if ((retval = copy_mm(clone_flags, p, MAY_SHARE)))
 		goto bad_fork_cleanup_signal;
 	if ((retval = copy_keys(clone_flags, p)))
 		goto bad_fork_cleanup_mm;
@@ -1317,3 +1338,172 @@ void __init proc_caches_init(void)
 			sizeof(struct mm_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 }
+
+/*
+ * unshare_mm is called from the unshare system call handler function to
+ * make a private copy of the mm_struct structure. It calls copy_mm with
+ * CLONE_VM flag cleard, to ensure that a private copy of mm_struct is made,
+ * and with mm_copy_share enum set to UNSHARE, to ensure that copy_mm
+ * does not clear fault info, context switch counts, mm and active_mm
+ * fields of the mm_struct.
+ */
+static int unshare_mm(unsigned long unshare_flags, struct task_struct *tsk)
+{
+	int retval = 0;
+	struct mm_struct *mm = tsk->mm;
+
+	/*
+	 * If the virtual memory is being shared, make a private
+	 * copy and disassociate the process from the shared virtual
+	 * memory.
+	 */
+	if (atomic_read(&mm->mm_users) > 1) {
+		retval = copy_mm((unshare_flags & ~CLONE_VM), tsk, UNSHARE);
+
+		/*
+		 * If copy_mm was successful, decrement the number of users
+		 * on the original, shared, mm_struct.
+		 */
+		if (!retval)
+			atomic_dec(&mm->mm_users);
+	}
+	return retval;
+}
+
+/*
+ * unshare_sighand is called from the unshare system call handler function to
+ * make a private copy of the sighand_struct structure. It calls copy_sighand
+ * with CLONE_SIGHAND cleared to ensure that a new signal handler structure
+ * is cloned from the current shared one.
+ */
+static int unshare_sighand(unsigned long unshare_flags, struct task_struct *tsk)
+{
+	int retval = 0;
+	struct sighand_struct *sighand = tsk->sighand;
+
+	/*
+	 * If the signal handlers are being shared, make a private
+	 * copy and disassociate the process from the shared signal
+	 * handlers.
+	 */
+	if (atomic_read(&sighand->count) > 1) {
+		retval = copy_sighand((unshare_flags & ~CLONE_SIGHAND), tsk);
+
+		/*
+		 * If copy_sighand was successful, decrement the use count
+		 * on the original, shared, sighand_struct.
+		 */
+		if (!retval)
+			atomic_dec(&sighand->count);
+	}
+	return retval;
+}
+
+/*
+ * unshare_namespace is called from the unshare system call handler
+ * function to make a private copy of the current shared namespace. It
+ * calls copy_namespace with CLONE_NEWNS set to ensure that a new
+ * namespace is cloned from the current namespace.
+ */
+static int unshare_namespace(struct task_struct *tsk)
+{
+	int retval = 0;
+	struct namespace *namespace = tsk->namespace;
+
+	/*
+	 * If the namespace is being shared, make a private copy
+	 * and disassociate the process from the shared namespace.
+	 */
+	if (atomic_read(&namespace->count) > 1) {
+		retval = copy_namespace(CLONE_NEWNS, tsk);
+
+		/*
+		 * If copy_namespace was successful, decrement the use count
+		 * on the original, shared, namespace struct.
+		 */
+		if (!retval)
+			atomic_dec(&namespace->count);
+	}
+	return retval;
+}
+
+/*
+ * unshare allows a process to 'unshare' part of the process
+ * context which was originally shared using clone.
+ */
+asmlinkage long sys_unshare(unsigned long unshare_flags)
+{
+	struct task_struct *tsk = current;
+	int retval = 0;
+	struct namespace *namespace;
+	struct mm_struct *mm;
+	struct sighand_struct *sighand;
+
+	if (unshare_flags & ~(CLONE_NEWNS | CLONE_VM | CLONE_SIGHAND))
+		goto bad_unshare_invalid_val;
+
+	/*
+	 * Shared signal handlers imply shared VM, so if CLONE_SIGHAND is
+	 * set, CLONE_VM must also be set in the system call argument.
+	 */
+	if ((unshare_flags & CLONE_SIGHAND) && !(unshare_flags & CLONE_VM))
+		goto bad_unshare_invalid_val;
+
+	task_lock(tsk);
+	namespace = tsk->namespace;
+	mm = tsk->mm;
+	sighand = tsk->sighand;
+
+	if (unshare_flags & CLONE_VM) {
+		retval = unshare_mm(unshare_flags, tsk);
+		if (retval)
+			goto unshare_unlock_task;
+		else if (unshare_flags & CLONE_SIGHAND) {
+			retval = unshare_sighand(unshare_flags, tsk);
+			if (retval)
+				goto bad_unshare_cleanup_mm;
+		}
+	}
+
+	if (unshare_flags & CLONE_NEWNS) {
+		retval = unshare_namespace(tsk);
+		if (retval)
+			goto bad_unshare_cleanup_sighand;
+	}
+
+unshare_unlock_task:
+	task_unlock(tsk);
+
+unshare_out:
+	return retval;
+
+bad_unshare_cleanup_sighand:
+	/*
+	 * If signal handlers were unshared (private copy was made),
+	 * clean them up (delete the private copy) and restore
+	 * the task to point to the old, shared, value.
+	 */
+	if (unshare_flags & CLONE_SIGHAND) {
+		exit_sighand(tsk);
+		tsk->sighand = sighand;
+		atomic_inc(&sighand->count);
+	}
+
+bad_unshare_cleanup_mm:
+	/*
+	 * If mm struct was unshared (private copy was made),
+	 * clean it up (delete the private copy) and restore
+	 * the task to point to the old, shared, value.
+	 */
+	if (unshare_flags & CLONE_VM) {
+		if (tsk->mm)
+			mmput(tsk->mm);
+		tsk->mm = mm;
+		atomic_inc(&mm->mm_users);
+	}
+	goto unshare_unlock_task;
+
+bad_unshare_invalid_val:
+	retval = -EINVAL;
+	goto unshare_out;
+}

