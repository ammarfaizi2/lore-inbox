Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUDISuf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 14:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUDISuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 14:50:35 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:21403 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261430AbUDISuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 14:50:02 -0400
Message-ID: <4076F02E.1000809@myrealbox.com>
Date: Fri, 09 Apr 2004 11:49:18 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       torvalds@osdl.org
CC: luto@myrealbox.com
Subject: [PATCH, local root on 2.4, 2.6?] compute_creds race
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fs/exec.c, compute_creds does:

	task_lock(current);
	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid) {
                 current->mm->dumpable = 0;
		
		if (must_not_trace_exec(current)
		    || atomic_read(&current->fs->count) > 1
		    || atomic_read(&current->files->count) > 1
		    || atomic_read(&current->sighand->count) > 1) {
			if(!capable(CAP_SETUID)) {
				bprm->e_uid = current->uid;
				bprm->e_gid = current->gid;
			}
		}
	}

         current->suid = current->euid = current->fsuid = bprm->e_uid;
         current->sgid = current->egid = current->fsgid = bprm->e_gid;

	task_unlock(current);

	security_bprm_compute_creds(bprm);

I assume the task_lock is to prevent another process (on SMP or preempt) from 
ptracing the execing process between the check and the assignment.  If that's 
the concern then the fact that the lock is dropped before the call to 
security_brpm_compute_creds means that, if security_bprm_compute_creds does 
anything interesting, there's a race.

For my (nearly complete) caps patch, I obviously need to fix this.  But I think 
it may be exploitable now.  Suppose there are two processes, A (the malicious 
code) and B (which uses exec).  B starts out unprivileged (A and B have, e.g., 
uid and euid = 500).

1. A ptraces B.
2. B calls exec on some setuid-root program.
3. in cap_bprm_set_security, B sets bprm->cap_permitted to the full set.
4. B gets to compute_creds in exec.c, calls task_lock, and does not change its
    uid.
5. B calls task_unlock.
6. A detaches from B (on preempt or SMP).
7. B gets to task_lock in cap_bprm_compute_creds, changes its capabilities, and
    returns from compute_creds into load_elf_binary.
8. load_elf_binary calls create_elf_tables (line 852 in 2.6.5-mm1), which calls
    cap_bprm_secureexec (through LSM), which returns false (!).
9. exec finishes.

The setuid program is now running with uid=euid=500 but full permitted 
capabilities.  There are two (or three) ways to effectively get local root now:

1. IIRC, linux 2.4 doesn't check capabilities in ptrace, so A could just ptrace 
B again.
2. LD_PRELOAD.
3. There are probably programs that will misbehave on their own under these 
circumstances.

Is there some reason why this is not doable?


The patch renames bprm_compute_creds to bprm_apply_creds and moves all uid logic 
into the hook.  This way, out-of-tree LSMs will fail to compile instead of 
malfunctioning.  It should also make life easier for LSMs and will certainly 
make it easier for me to finish the cap patch.  Someone please check me on the 
selinux part -- I haven't compiled it, let alone tested it.  It should work 
because whatever hook selinux calls will do uid evolution.  On the other hand, 
selinux may be insecure even with this patch -- I'm not familiar enough with it 
to tell.

Patch against 2.6.5-mm1, applies (with offset in selinux) to -vanilla:

Fixes a race in compute_creds with LSM by moving uid/gid evolution logic into 
bprm_compute_creds and renaming the hook to brpm_apply_creds

  fs/exec.c                |   22 +---------------------
  include/linux/security.h |   18 +++++++++---------
  security/commoncap.c     |   24 +++++++++++++++++++++---
  security/dummy.c         |   26 ++++++++++++++++++++++----
  security/selinux/hooks.c |    8 ++++----
  5 files changed, 57 insertions(+), 41 deletions(-)

--- ./fs/exec.c.orig	2004-04-09 11:18:45.208241872 -0700
+++ ./fs/exec.c	2004-04-09 11:19:08.937634456 -0700
@@ -944,27 +944,7 @@

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
+++ ./security/commoncap.c	2004-04-09 11:22:39.409637848 -0700
@@ -121,7 +121,7 @@
  	return (p->ptrace & PT_PTRACED) && !(p->ptrace & PT_PTRACE_CAP);
  }

-void cap_bprm_compute_creds (struct linux_binprm *bprm)
+void cap_bprm_apply_creds (struct linux_binprm *bprm)
  {
  	/* Derived from fs/exec.c:compute_creds. */
  	kernel_cap_t new_permitted, working;
@@ -132,6 +132,24 @@
  	new_permitted = cap_combine (new_permitted, working);

  	task_lock(current);
+
+	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid) {
+		current->mm->dumpable = 0;
+	
+		if (must_not_trace_exec(current)
+		    || atomic_read(&current->fs->count) > 1
+		    || atomic_read(&current->files->count) > 1
+		    || atomic_read(&current->sighand->count) > 1) {
+			if(!capable(CAP_SETUID)) {
+				bprm->e_uid = current->uid;
+				bprm->e_gid = current->gid;
+			}
+		}
+	}
+
+	current->suid = current->euid = current->fsuid = bprm->e_uid;
+	current->sgid = current->egid = current->fsgid = bprm->e_gid;
+
  	if (!cap_issubset (new_permitted, current->cap_permitted)) {
  		current->mm->dumpable = 0;

@@ -315,7 +333,7 @@

  	vm_acct_memory(pages);

-        /*
+	/*
  	 * Sometimes we want to use more memory than we have
  	 */
  	if (sysctl_overcommit_memory == 1)
@@ -377,7 +395,7 @@
  EXPORT_SYMBOL(cap_capset_check);
  EXPORT_SYMBOL(cap_capset_set);
  EXPORT_SYMBOL(cap_bprm_set_security);
-EXPORT_SYMBOL(cap_bprm_compute_creds);
+EXPORT_SYMBOL(cap_bprm_apply_creds);
  EXPORT_SYMBOL(cap_bprm_secureexec);
  EXPORT_SYMBOL(cap_inode_setxattr);
  EXPORT_SYMBOL(cap_inode_removexattr);
--- ./security/dummy.c.orig	2004-04-09 11:17:16.964656936 -0700
+++ ./security/dummy.c	2004-04-09 11:23:31.687690376 -0700
@@ -116,7 +116,7 @@

  	vm_acct_memory(pages);

-        /*
+	/*
  	 * Sometimes we want to use more memory than we have
  	 */
  	if (sysctl_overcommit_memory == 1)
@@ -169,9 +169,27 @@
  	return;
  }

-static void dummy_bprm_compute_creds (struct linux_binprm *bprm)
+static void dummy_bprm_apply_creds (struct linux_binprm *bprm)
  {
-	return;
+	task_lock(current);
+	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid) {
+		current->mm->dumpable = 0;
+	
+		if (must_not_trace_exec(current)
+		    || atomic_read(&current->fs->count) > 1
+		    || atomic_read(&current->files->count) > 1
+		    || atomic_read(&current->sighand->count) > 1) {
+			if(!capable(CAP_SETUID)) {
+				bprm->e_uid = current->uid;
+				bprm->e_gid = current->gid;
+			}
+		}
+	}
+
+	current->suid = current->euid = current->fsuid = bprm->e_uid;
+	current->sgid = current->egid = current->fsgid = bprm->e_gid;
+
+	task_unlock(current);
  }

  static int dummy_bprm_set_security (struct linux_binprm *bprm)
@@ -887,7 +905,7 @@
  	set_to_dummy_if_null(ops, vm_enough_memory);
  	set_to_dummy_if_null(ops, bprm_alloc_security);
  	set_to_dummy_if_null(ops, bprm_free_security);
-	set_to_dummy_if_null(ops, bprm_compute_creds);
+	set_to_dummy_if_null(ops, bprm_apply_creds);
  	set_to_dummy_if_null(ops, bprm_set_security);
  	set_to_dummy_if_null(ops, bprm_check_security);
  	set_to_dummy_if_null(ops, bprm_secureexec);
--- ./include/linux/security.h.orig	2004-04-09 11:12:10.991171976 -0700
+++ ./include/linux/security.h	2004-04-09 11:12:58.969878104 -0700
@@ -44,7 +44,7 @@
  extern int cap_capset_check (struct task_struct *target, kernel_cap_t 
*effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
  extern void cap_capset_set (struct task_struct *target, kernel_cap_t 
*effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
  extern int cap_bprm_set_security (struct linux_binprm *bprm);
-extern void cap_bprm_compute_creds (struct linux_binprm *bprm);
+extern void cap_bprm_apply_creds (struct linux_binprm *bprm);
  extern int cap_bprm_secureexec(struct linux_binprm *bprm);
  extern int cap_inode_setxattr(struct dentry *dentry, char *name, void *value, 
size_t size, int flags);
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
