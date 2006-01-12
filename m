Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbWALEPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWALEPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWALEP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:15:27 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:64684 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965013AbWALEPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:15:23 -0500
Subject: [PATCH -mm 2/10] unshare system call -v5 : system call handler
	function
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: akpm@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org
Cc: chrisw@sous-sol.org, jamie@shareable.org, serue@us.ibm.com,
       sds@tycho.nsa.gov, sgrubb@redhat.com, ebiederm@xmission.com,
       janak@us.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1137038992.7488.206.camel@hobbes.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 11 Jan 2006 23:10:46 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH -mm 2/10] unshare system call: system call handler function

sys_unshare system call handler function accepts the same flags as
clone system call, checks constraints on each of the flags and invokes
corresponding unshare functions to disassociate respective process
context if it was being shared with another task.

Changes since the -v4 submitted on 12/13/05:
	- none

Signed-off-by: Janak Desai <janak@us.ibm.com>

---

 fork.c |  232 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 232 insertions(+)

diff -Naurp 2.6.15-mm3/kernel/fork.c 2.6.15-mm3+unsh-base/kernel/fork.c
--- 2.6.15-mm3/kernel/fork.c	2006-01-11 20:22:20.000000000 +0000
+++ 2.6.15-mm3+unsh-base/kernel/fork.c	2006-01-11 22:46:49.000000000 +0000
@@ -1323,3 +1323,235 @@ void __init proc_caches_init(void)
 			sizeof(struct mm_struct), ARCH_MIN_MMSTRUCT_ALIGN,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 }
+
+
+/*
+ * Check constraints on flags passed to the unshare system call and
+ * force unsharing of additional process context as appropriate.
+ */
+static inline void check_unshare_flags(unsigned long *flags_ptr)
+{
+	/*
+	 * If unsharing a thread from a thread group, must also
+	 * unshare vm.
+	 */
+	if (*flags_ptr & CLONE_THREAD)
+		*flags_ptr |= CLONE_VM;
+
+	/*
+	 * If unsharing vm, must also unshare signal handlers.
+	 */
+	if (*flags_ptr & CLONE_VM)
+		*flags_ptr |= CLONE_SIGHAND;
+
+	/*
+	 * If unsharing signal handlers and the task was created
+	 * using CLONE_THREAD, then must unshare the thread
+	 */
+	if ((*flags_ptr & CLONE_SIGHAND) &&
+	    (atomic_read(&current->signal->count) > 1))
+		*flags_ptr |= CLONE_THREAD;
+
+	/*
+	 * If unsharing namespace, must also unshare filesystem information.
+	 */
+	if (*flags_ptr & CLONE_NEWNS)
+		*flags_ptr |= CLONE_FS;
+}
+
+/*
+ * Unsharing of tasks created with CLONE_THREAD is not supported yet
+ */
+static int unshare_thread(unsigned long unshare_flags)
+{
+	if (unshare_flags & CLONE_THREAD)
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Unsharing of fs info for tasks created with CLONE_FS is not supported yet
+ */
+static int unshare_fs(unsigned long unshare_flags, struct fs_struct **new_fsp)
+{
+	struct fs_struct *fs = current->fs;
+
+	if ((unshare_flags & CLONE_FS) &&
+	    (fs && atomic_read(&fs->count) > 1))
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Unsharing of namespace for tasks created without CLONE_NEWNS is not
+ * supported yet
+ */
+static int unshare_namespace(unsigned long unshare_flags, struct namespace **new_nsp)
+{
+	struct namespace *ns = current->namespace;
+
+	if ((unshare_flags & CLONE_NEWNS) &&
+	    (ns && atomic_read(&ns->count) > 1))
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Unsharing of sighand for tasks created with CLONE_SIGHAND is not
+ * supported yet
+ */
+static int unshare_sighand(unsigned long unshare_flags, struct sighand_struct **new_sighp)
+{
+	struct sighand_struct *sigh = current->sighand;
+
+	if ((unshare_flags & CLONE_SIGHAND) &&
+	    (sigh && atomic_read(&sigh->count) > 1))
+		return -EINVAL;
+	else
+		return 0;
+}
+
+/*
+ * Unsharing of vm for tasks created with CLONE_VM is not supported yet
+ */
+static int unshare_vm(unsigned long unshare_flags, struct mm_struct **new_mmp)
+{
+	struct mm_struct *mm = current->mm;
+
+	if ((unshare_flags & CLONE_VM) &&
+	    (mm && atomic_read(&mm->mm_users) > 1))
+		return -EINVAL;
+
+	return 0;
+
+}
+
+/*
+ * Unsharing of files for tasks created with CLONE_FILES is not supported yet
+ */
+static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp)
+{
+	struct files_struct *fd = current->files;
+
+	if ((unshare_flags & CLONE_FILES) &&
+	    (fd && atomic_read(&fd->count) > 1))
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Unsharing of semundo for tasks created with CLONE_SYSVSEM is not
+ * supported yet
+ */
+static int unshare_semundo(unsigned long unshare_flags, struct sem_undo_list **new_ulistp)
+{
+	if (unshare_flags & CLONE_SYSVSEM)
+		return -EINVAL;
+
+	return 0;
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
+	struct fs_struct *fs, *new_fs = NULL;
+	struct namespace *ns, *new_ns = NULL;
+	struct sighand_struct *sigh, *new_sigh = NULL;
+	struct mm_struct *mm, *new_mm = NULL, *active_mm = NULL;
+	struct files_struct *fd, *new_fd = NULL;
+	struct sem_undo_list *new_ulist = NULL;
+
+	check_unshare_flags(&unshare_flags);
+
+	if ((err = unshare_thread(unshare_flags)))
+		goto bad_unshare_out;
+	if ((err = unshare_fs(unshare_flags, &new_fs)))
+		goto bad_unshare_cleanup_thread;
+	if ((err = unshare_namespace(unshare_flags, &new_ns)))
+		goto bad_unshare_cleanup_fs;
+	if ((err = unshare_sighand(unshare_flags, &new_sigh)))
+		goto bad_unshare_cleanup_ns;
+	if ((err = unshare_vm(unshare_flags, &new_mm)))
+		goto bad_unshare_cleanup_sigh;
+	if ((err = unshare_fd(unshare_flags, &new_fd)))
+		goto bad_unshare_cleanup_vm;
+	if ((err = unshare_semundo(unshare_flags, &new_ulist)))
+		goto bad_unshare_cleanup_fd;
+
+	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist) {
+
+		task_lock(current);
+
+		if (new_fs) {
+			fs = current->fs;
+			current->fs = new_fs;
+			new_fs = fs;
+		}
+
+		if (new_ns) {
+			ns = current->namespace;
+			current->namespace = new_ns;
+			new_ns = ns;
+		}
+
+		if (new_sigh) {
+			sigh = current->sighand;
+			current->sighand = new_sigh;
+			new_sigh = sigh;
+		}
+
+		if (new_mm) {
+			mm = current->mm;
+			active_mm = current->active_mm;
+			current->mm = new_mm;
+			current->active_mm = new_mm;
+			activate_mm(active_mm, new_mm);
+			new_mm = mm;
+		}
+
+		if (new_fd) {
+			fd = current->files;
+			current->files = new_fd;
+			new_fd = fd;
+		}
+
+		task_unlock(current);
+	}
+
+bad_unshare_cleanup_fd:
+	if (new_fd)
+		put_files_struct(new_fd);
+
+bad_unshare_cleanup_vm:
+	if (new_mm)
+		mmput(new_mm);
+
+bad_unshare_cleanup_sigh:
+	if (new_sigh)
+		if (atomic_dec_and_test(&new_sigh->count))
+			kmem_cache_free(sighand_cachep, new_sigh);
+
+bad_unshare_cleanup_ns:
+	if (new_ns)
+		put_namespace(new_ns);
+
+bad_unshare_cleanup_fs:
+	if (new_fs)
+		put_fs_struct(new_fs);
+
+bad_unshare_cleanup_thread:
+bad_unshare_out:
+	return err;
+}


