Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbUDJHTK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 03:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUDJHTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 03:19:09 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.117]:34980 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S261969AbUDJHSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 03:18:54 -0400
Date: Sat, 10 Apr 2004 00:20:23 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: vi and postfix ;)
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Cc: Andy Lutomirski <luto@myrealbox.com>
Subject: Re: [PATCH, local root on 2.4, 2.6?] compute_creds race (fixed patch)
References: <20040409212232.261ba0d6.akpm@osdl.org>
In-Reply-To: Message-Id: <20040409212232.261ba0d6.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Message-Id: <20040410072134.2933F1C38@luto.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Andy Lutomirski <luto@myrealbox.com> wrote:
> >
> > User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
> 
> uh-oh.

caught me.  I swear it's worked before.  This one better work, though.


 fs/exec.c                |   31 +------------------------------
 include/linux/security.h |   18 +++++++++---------
 security/capability.c    |    2 +-
 security/commoncap.c     |   38 ++++++++++++++++++++++++--------------
 security/dummy.c         |   31 +++++++++++++++++++++++++++----
 security/selinux/hooks.c |    8 ++++----
 6 files changed, 66 insertions(+), 62 deletions(-)
--- ./fs/exec.c.orig	2004-04-09 11:18:45.208241872 -0700
+++ ./fs/exec.c	2004-04-09 15:43:38.873194968 -0700
@@ -869,15 +869,6 @@
 
 EXPORT_SYMBOL(flush_old_exec);
 
-/*
- * We mustn't allow tracing of suid binaries, unless
- * the tracer has the capability to trace anything..
- */
-static inline int must_not_trace_exec(struct task_struct * p)
-{
-	return (p->ptrace & PT_PTRACED) && !(p->ptrace & PT_PTRACE_CAP);
-}
-
 /* 
  * Fill the binprm structure from the inode. 
  * Check permissions, then read the first 128 (BINPRM_BUF_SIZE) bytes
@@ -944,27 +935,7 @@
 
 void compute_creds(struct linux_binprm *bprm)
 {
-	task_lock(current);
-	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid) {
-                current->mm->dumpable = 0;
-		
-		if (must_not_trace_exec(current)
-		    || atomic_read(&current->fs->count) > 1
-		    || atomic_read(&current->files->count) > 1
-		    || atomic_read(&current->sighand->count) > 1) {
-			if(!capable(CAP_SETUID)) {
-				bprm->e_uid = current->uid;
-				bprm->e_gid = current->gid;
-			}
-		}
-	}
-
-        current->suid = current->euid = current->fsuid = bprm->e_uid;
-        current->sgid = current->egid = current->fsgid = bprm->e_gid;
-
-	task_unlock(current);
-
-	security_bprm_compute_creds(bprm);
+	security_bprm_apply_creds(bprm);
 }
 
 EXPORT_SYMBOL(compute_creds);
--- ./security/selinux/hooks.c.orig	2004-04-09 11:18:00.938971824 -0700
+++ ./security/selinux/hooks.c	2004-04-09 11:18:27.354955984 -0700
@@ -1746,7 +1746,7 @@
 	spin_unlock(&files->file_lock);
 }
 
-static void selinux_bprm_compute_creds(struct linux_binprm *bprm)
+static void selinux_bprm_apply_creds(struct linux_binprm *bprm)
 {
 	struct task_security_struct *tsec, *psec;
 	struct bprm_security_struct *bsec;
@@ -1756,7 +1756,7 @@
 	struct rlimit *rlim, *initrlim;
 	int rc, i;
 
-	secondary_ops->bprm_compute_creds(bprm);
+	secondary_ops->bprm_apply_creds(bprm);
 
 	tsec = current->security;
 
@@ -2561,7 +2561,7 @@
 	/* Control the ability to change the hard limit (whether
 	   lowering or raising it), so that the hard limit can
 	   later be used as a safe reset point for the soft limit
-	   upon context transitions. See selinux_bprm_compute_creds. */
+	   upon context transitions. See selinux_bprm_apply_creds. */
 	if (old_rlim->rlim_max != new_rlim->rlim_max)
 		return task_has_perm(current, current, PROCESS__SETRLIMIT);
 
@@ -3972,7 +3972,7 @@
 
 	.bprm_alloc_security =		selinux_bprm_alloc_security,
 	.bprm_free_security =		selinux_bprm_free_security,
-	.bprm_compute_creds =		selinux_bprm_compute_creds,
+	.bprm_apply_creds =		selinux_bprm_apply_creds,
 	.bprm_set_security =		selinux_bprm_set_security,
 	.bprm_check_security =		selinux_bprm_check_security,
 	.bprm_secureexec =		selinux_bprm_secureexec,
--- ./security/commoncap.c.orig	2004-04-09 11:16:21.766048400 -0700
+++ ./security/commoncap.c	2004-04-09 16:03:47.324482448 -0700
@@ -115,13 +115,15 @@
 	return 0;
 }
 
-/* Copied from fs/exec.c */
 static inline int must_not_trace_exec (struct task_struct *p)
 {
-	return (p->ptrace & PT_PTRACED) && !(p->ptrace & PT_PTRACE_CAP);
+	return ((p->ptrace & PT_PTRACED) && !(p->ptrace & PT_PTRACE_CAP))
+		|| atomic_read(&current->fs->count) > 1
+		|| atomic_read(&current->files->count) > 1
+		|| atomic_read(&current->sighand->count) > 1;
 }
 
-void cap_bprm_compute_creds (struct linux_binprm *bprm)
+void cap_bprm_apply_creds (struct linux_binprm *bprm)
 {
 	/* Derived from fs/exec.c:compute_creds. */
 	kernel_cap_t new_permitted, working;
@@ -132,18 +134,26 @@
 	new_permitted = cap_combine (new_permitted, working);
 
 	task_lock(current);
+
+	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid) {
+		current->mm->dumpable = 0;
+	    
+		if (must_not_trace_exec(current) && !capable(CAP_SETUID)) {
+			bprm->e_uid = current->uid;
+			bprm->e_gid = current->gid;
+		}
+	}
+
+	current->suid = current->euid = current->fsuid = bprm->e_uid;
+	current->sgid = current->egid = current->fsgid = bprm->e_gid;
+
 	if (!cap_issubset (new_permitted, current->cap_permitted)) {
 		current->mm->dumpable = 0;
 
-		if (must_not_trace_exec (current)
-		    || atomic_read (&current->fs->count) > 1
-		    || atomic_read (&current->files->count) > 1
-		    || atomic_read (&current->sighand->count) > 1) {
-			if (!capable (CAP_SETPCAP)) {
-				new_permitted = cap_intersect (new_permitted,
-							       current->
-							       cap_permitted);
-			}
+		if (must_not_trace_exec (current) && !capable (CAP_SETPCAP)) {
+			new_permitted = cap_intersect (new_permitted,
+						       current->
+						       cap_permitted);
 		}
 	}
 
@@ -315,7 +325,7 @@
 
 	vm_acct_memory(pages);
 
-        /*
+	/*
 	 * Sometimes we want to use more memory than we have
 	 */
 	if (sysctl_overcommit_memory == 1)
@@ -377,7 +387,7 @@
 EXPORT_SYMBOL(cap_capset_check);
 EXPORT_SYMBOL(cap_capset_set);
 EXPORT_SYMBOL(cap_bprm_set_security);
-EXPORT_SYMBOL(cap_bprm_compute_creds);
+EXPORT_SYMBOL(cap_bprm_apply_creds);
 EXPORT_SYMBOL(cap_bprm_secureexec);
 EXPORT_SYMBOL(cap_inode_setxattr);
 EXPORT_SYMBOL(cap_inode_removexattr);
--- ./security/dummy.c.orig	2004-04-09 11:17:16.964656936 -0700
+++ ./security/dummy.c	2004-04-09 15:52:03.433490144 -0700
@@ -26,6 +26,8 @@
 #include <net/sock.h>
 #include <linux/xattr.h>
 #include <linux/hugetlb.h>
+#include <linux/ptrace.h>
+#include <linux/file.h>
 
 static int dummy_ptrace (struct task_struct *parent, struct task_struct *child)
 {
@@ -116,7 +118,7 @@
 
 	vm_acct_memory(pages);
 
-        /*
+	/*
 	 * Sometimes we want to use more memory than we have
 	 */
 	if (sysctl_overcommit_memory == 1)
@@ -169,9 +171,30 @@
 	return;
 }
 
-static void dummy_bprm_compute_creds (struct linux_binprm *bprm)
+static inline int must_not_trace_exec (struct task_struct *p)
 {
-	return;
+	return ((p->ptrace & PT_PTRACED) && !(p->ptrace & PT_PTRACE_CAP))
+		|| atomic_read(&current->fs->count) > 1
+		|| atomic_read(&current->files->count) > 1
+		|| atomic_read(&current->sighand->count) > 1;
+}
+
+static void dummy_bprm_apply_creds (struct linux_binprm *bprm)
+{
+	task_lock(current);
+	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid) {
+		current->mm->dumpable = 0;
+	    
+		if (must_not_trace_exec(current) && !capable(CAP_SETUID)) {
+			bprm->e_uid = current->uid;
+			bprm->e_gid = current->gid;
+		}
+	}
+
+	current->suid = current->euid = current->fsuid = bprm->e_uid;
+	current->sgid = current->egid = current->fsgid = bprm->e_gid;
+
+	task_unlock(current);
 }
 
 static int dummy_bprm_set_security (struct linux_binprm *bprm)
@@ -887,7 +910,7 @@
 	set_to_dummy_if_null(ops, vm_enough_memory);
 	set_to_dummy_if_null(ops, bprm_alloc_security);
 	set_to_dummy_if_null(ops, bprm_free_security);
-	set_to_dummy_if_null(ops, bprm_compute_creds);
+	set_to_dummy_if_null(ops, bprm_apply_creds);
 	set_to_dummy_if_null(ops, bprm_set_security);
 	set_to_dummy_if_null(ops, bprm_check_security);
 	set_to_dummy_if_null(ops, bprm_secureexec);
--- ./security/capability.c.orig	2004-04-09 15:52:30.144429464 -0700
+++ ./security/capability.c	2004-04-09 15:52:49.996411504 -0700
@@ -35,7 +35,7 @@
 	.netlink_send =			cap_netlink_send,
 	.netlink_recv =			cap_netlink_recv,
 
-	.bprm_compute_creds =		cap_bprm_compute_creds,
+	.bprm_apply_creds =		cap_bprm_apply_creds,
 	.bprm_set_security =		cap_bprm_set_security,
 	.bprm_secureexec =		cap_bprm_secureexec,
 
--- ./include/linux/security.h.orig	2004-04-09 11:12:10.991171976 -0700
+++ ./include/linux/security.h	2004-04-09 11:12:58.969878104 -0700
@@ -44,7 +44,7 @@
 extern int cap_capset_check (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
 extern void cap_capset_set (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
 extern int cap_bprm_set_security (struct linux_binprm *bprm);
-extern void cap_bprm_compute_creds (struct linux_binprm *bprm);
+extern void cap_bprm_apply_creds (struct linux_binprm *bprm);
 extern int cap_bprm_secureexec(struct linux_binprm *bprm);
 extern int cap_inode_setxattr(struct dentry *dentry, char *name, void *value, size_t size, int flags);
 extern int cap_inode_removexattr(struct dentry *dentry, char *name);
@@ -102,7 +102,7 @@
  * @bprm_free_security:
  *	@bprm contains the linux_binprm structure to be modified.
  *	Deallocate and clear the @bprm->security field.
- * @bprm_compute_creds:
+ * @bprm_apply_creds:
  *	Compute and set the security attributes of a process being transformed
  *	by an execve operation based on the old attributes (current->security)
  *	and the information saved in @bprm->security by the set_security hook.
@@ -115,7 +115,7 @@
  *	@bprm contains the linux_binprm structure.
  * @bprm_set_security:
  *	Save security information in the bprm->security field, typically based
- *	on information about the bprm->file, for later use by the compute_creds
+ *	on information about the bprm->file, for later use by the apply_creds
  *	hook.  This hook may also optionally check permissions (e.g. for
  *	transitions between security domains).
  *	This hook may be called multiple times during a single execve, e.g. for
@@ -924,7 +924,7 @@
  *	Check permission before allowing the @parent process to trace the
  *	@child process.
  *	Security modules may also want to perform a process tracing check
- *	during an execve in the set_security or compute_creds hooks of
+ *	during an execve in the set_security or apply_creds hooks of
  *	binprm_security_ops if the process is being traced and its security
  *	attributes would be changed by the execve.
  *	@parent contains the task_struct structure for parent process.
@@ -1026,7 +1026,7 @@
 
 	int (*bprm_alloc_security) (struct linux_binprm * bprm);
 	void (*bprm_free_security) (struct linux_binprm * bprm);
-	void (*bprm_compute_creds) (struct linux_binprm * bprm);
+	void (*bprm_apply_creds) (struct linux_binprm * bprm);
 	int (*bprm_set_security) (struct linux_binprm * bprm);
 	int (*bprm_check_security) (struct linux_binprm * bprm);
 	int (*bprm_secureexec) (struct linux_binprm * bprm);
@@ -1290,9 +1290,9 @@
 {
 	security_ops->bprm_free_security (bprm);
 }
-static inline void security_bprm_compute_creds (struct linux_binprm *bprm)
+static inline void security_bprm_apply_creds (struct linux_binprm *bprm)
 {
-	security_ops->bprm_compute_creds (bprm);
+	security_ops->bprm_apply_creds (bprm);
 }
 static inline int security_bprm_set (struct linux_binprm *bprm)
 {
@@ -1962,9 +1962,9 @@
 static inline void security_bprm_free (struct linux_binprm *bprm)
 { }
 
-static inline void security_bprm_compute_creds (struct linux_binprm *bprm)
+static inline void security_bprm_apply_creds (struct linux_binprm *bprm)
 { 
-	cap_bprm_compute_creds (bprm);
+	cap_bprm_apply_creds (bprm);
 }
 
 static inline int security_bprm_set (struct linux_binprm *bprm)
