Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVADSbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVADSbT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 13:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVADSbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 13:31:19 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:53189 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261767AbVADSan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 13:30:43 -0500
Date: Tue, 4 Jan 2005 12:30:43 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] split bprm_apply_creds into two functions
Message-ID: <20050104183043.GA3592@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch splits bprm_apply_creds into two functions,
bprm_apply_creds and bprm_post_apply_creds.  The latter is called
after the task_lock has been dropped.  Without this patch, SELinux
must drop the task_lock and re-acquire it during apply_creds, making
the 'unsafe' flag meaningless to any later security modules.  Please
apply.

thanks,
-serge

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.10-mm1/fs/exec.c
===================================================================
--- linux-2.6.10-mm1.orig/fs/exec.c	2005-01-04 12:15:45.000000000 -0600
+++ linux-2.6.10-mm1/fs/exec.c	2005-01-04 12:42:43.000000000 -0600
@@ -963,6 +963,7 @@ void compute_creds(struct linux_binprm *
 	unsafe = unsafe_exec(current);
 	security_bprm_apply_creds(bprm, unsafe);
 	task_unlock(current);
+	security_bprm_post_apply_creds(bprm);
 }
 
 EXPORT_SYMBOL(compute_creds);
Index: linux-2.6.10-mm1/include/linux/security.h
===================================================================
--- linux-2.6.10-mm1.orig/include/linux/security.h	2005-01-04 12:15:45.000000000 -0600
+++ linux-2.6.10-mm1/include/linux/security.h	2005-01-04 13:02:15.000000000 -0600
@@ -109,13 +109,20 @@ struct swap_info_struct;
  *	and the information saved in @bprm->security by the set_security hook.
  *	Since this hook function (and its caller) are void, this hook can not
  *	return an error.  However, it can leave the security attributes of the
- *	process unchanged if an access failure occurs at this point. It can
- *	also perform other state changes on the process (e.g.  closing open
- *	file descriptors to which access is no longer granted if the attributes
- *	were changed). 
+ *	process unchanged if an access failure occurs at this point.
  *	bprm_apply_creds is called under task_lock.  @unsafe indicates various
  *	reasons why it may be unsafe to change security state.
  *	@bprm contains the linux_binprm structure.
+ * @bprm_post_apply_creds:
+ *	Runs after bprm_apply_creds with the task_lock dropped, so that
+ *	functions which cannot be called safely under the task_lock can
+ *	be used.  This hook is a good place to perform state changes on
+ *	the process such as closing open file descriptors to which access
+ *	is no longer granted if the attributes were changed. 
+ *	Note that a security module might need to save state between
+ *	bprm_apply_creds and bprm_post_apply_creds to store the decision
+ *	on whether the process may proceed.
+ *	@bprm contains the linux_binprm structure.
  * @bprm_set_security:
  *	Save security information in the bprm->security field, typically based
  *	on information about the bprm->file, for later use by the apply_creds
@@ -1042,6 +1049,7 @@ struct security_operations {
 	int (*bprm_alloc_security) (struct linux_binprm * bprm);
 	void (*bprm_free_security) (struct linux_binprm * bprm);
 	void (*bprm_apply_creds) (struct linux_binprm * bprm, int unsafe);
+	void (*bprm_post_apply_creds) (struct linux_binprm * bprm);
 	int (*bprm_set_security) (struct linux_binprm * bprm);
 	int (*bprm_check_security) (struct linux_binprm * bprm);
 	int (*bprm_secureexec) (struct linux_binprm * bprm);
@@ -1314,6 +1322,10 @@ static inline void security_bprm_apply_c
 {
 	security_ops->bprm_apply_creds (bprm, unsafe);
 }
+static inline void security_bprm_post_apply_creds (struct linux_binprm *bprm)
+{
+	security_ops->bprm_post_apply_creds (bprm);
+}
 static inline int security_bprm_set (struct linux_binprm *bprm)
 {
 	return security_ops->bprm_set_security (bprm);
@@ -1992,6 +2004,11 @@ static inline void security_bprm_apply_c
 	cap_bprm_apply_creds (bprm, unsafe);
 }
 
+static inline void security_bprm_post_apply_creds (struct linux_binprm *bprm)
+{ 
+	return;
+}
+
 static inline int security_bprm_set (struct linux_binprm *bprm)
 {
 	return cap_bprm_set_security (bprm);
Index: linux-2.6.10-mm1/security/dummy.c
===================================================================
--- linux-2.6.10-mm1.orig/security/dummy.c	2005-01-04 12:15:45.000000000 -0600
+++ linux-2.6.10-mm1/security/dummy.c	2005-01-04 12:42:43.000000000 -0600
@@ -201,6 +201,11 @@ static void dummy_bprm_apply_creds (stru
 	current->sgid = current->egid = current->fsgid = bprm->e_gid;
 }
 
+static void dummy_bprm_post_apply_creds (struct linux_binprm *bprm)
+{
+	return;
+}
+
 static int dummy_bprm_set_security (struct linux_binprm *bprm)
 {
 	return 0;
@@ -916,6 +921,7 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, bprm_alloc_security);
 	set_to_dummy_if_null(ops, bprm_free_security);
 	set_to_dummy_if_null(ops, bprm_apply_creds);
+	set_to_dummy_if_null(ops, bprm_post_apply_creds);
 	set_to_dummy_if_null(ops, bprm_set_security);
 	set_to_dummy_if_null(ops, bprm_check_security);
 	set_to_dummy_if_null(ops, bprm_secureexec);
Index: linux-2.6.10-mm1/security/selinux/hooks.c
===================================================================
--- linux-2.6.10-mm1.orig/security/selinux/hooks.c	2005-01-04 12:15:45.000000000 -0600
+++ linux-2.6.10-mm1/security/selinux/hooks.c	2005-01-04 12:42:43.000000000 -0600
@@ -1801,10 +1801,7 @@ static void selinux_bprm_apply_creds(str
 	struct task_security_struct *tsec;
 	struct bprm_security_struct *bsec;
 	u32 sid;
-	struct av_decision avd;
-	struct itimerval itimer;
-	struct rlimit *rlim, *initrlim;
-	int rc, i;
+	int rc;
 
 	secondary_ops->bprm_apply_creds(bprm, unsafe);
 
@@ -1814,91 +1811,101 @@ static void selinux_bprm_apply_creds(str
 	sid = bsec->sid;
 
 	tsec->osid = tsec->sid;
+	bsec->unsafe = 0;
 	if (tsec->sid != sid) {
 		/* Check for shared state.  If not ok, leave SID
 		   unchanged and kill. */
 		if (unsafe & LSM_UNSAFE_SHARE) {
-			rc = avc_has_perm_noaudit(tsec->sid, sid,
-					  SECCLASS_PROCESS, PROCESS__SHARE, &avd);
+			rc = avc_has_perm(tsec->sid, sid, SECCLASS_PROCESS,
+					PROCESS__SHARE, NULL);
 			if (rc) {
-				task_unlock(current);
-				avc_audit(tsec->sid, sid, SECCLASS_PROCESS,
-				    PROCESS__SHARE, &avd, rc, NULL);
-				force_sig_specific(SIGKILL, current);
-				goto lock_out;
+				bsec->unsafe = 1;
+				return;
 			}
 		}
 
 		/* Check for ptracing, and update the task SID if ok.
 		   Otherwise, leave SID unchanged and kill. */
 		if (unsafe & (LSM_UNSAFE_PTRACE | LSM_UNSAFE_PTRACE_CAP)) {
-			rc = avc_has_perm_noaudit(tsec->ptrace_sid, sid,
-					  SECCLASS_PROCESS, PROCESS__PTRACE, &avd);
-			if (!rc)
-				tsec->sid = sid;
-			task_unlock(current);
-			avc_audit(tsec->ptrace_sid, sid, SECCLASS_PROCESS,
-				  PROCESS__PTRACE, &avd, rc, NULL);
+			rc = avc_has_perm(tsec->ptrace_sid, sid,
+					  SECCLASS_PROCESS, PROCESS__PTRACE,
+					  NULL);
 			if (rc) {
-				force_sig_specific(SIGKILL, current);
-				goto lock_out;
+				bsec->unsafe = 1;
+				return;
 			}
-		} else {
-			tsec->sid = sid;
-			task_unlock(current);
 		}
+		tsec->sid = sid;
+	}
+}
 
-		/* Close files for which the new task SID is not authorized. */
-		flush_unauthorized_files(current->files);
+/*
+ * called after apply_creds without the task lock held
+ */
+static void selinux_bprm_post_apply_creds(struct linux_binprm *bprm)
+{
+	struct task_security_struct *tsec;
+	struct rlimit *rlim, *initrlim;
+	struct itimerval itimer;
+	struct bprm_security_struct *bsec;
+	int rc, i;
 
-		/* Check whether the new SID can inherit signal state
-		   from the old SID.  If not, clear itimers to avoid
-		   subsequent signal generation and flush and unblock
-		   signals. This must occur _after_ the task SID has
-                  been updated so that any kill done after the flush
-                  will be checked against the new SID. */
-		rc = avc_has_perm(tsec->osid, tsec->sid, SECCLASS_PROCESS,
-				  PROCESS__SIGINH, NULL);
-		if (rc) {
-			memset(&itimer, 0, sizeof itimer);
-			for (i = 0; i < 3; i++)
-				do_setitimer(i, &itimer, NULL);
-			flush_signals(current);
-			spin_lock_irq(&current->sighand->siglock);
-			flush_signal_handlers(current, 1);
-			sigemptyset(&current->blocked);
-			recalc_sigpending();
-			spin_unlock_irq(&current->sighand->siglock);
-		}
+	tsec = current->security;
+	bsec = bprm->security;
 
-		/* Check whether the new SID can inherit resource limits
-		   from the old SID.  If not, reset all soft limits to
-		   the lower of the current task's hard limit and the init
-		   task's soft limit.  Note that the setting of hard limits 
-		   (even to lower them) can be controlled by the setrlimit 
-		   check. The inclusion of the init task's soft limit into
-	           the computation is to avoid resetting soft limits higher
-		   than the default soft limit for cases where the default
-		   is lower than the hard limit, e.g. RLIMIT_CORE or 
-		   RLIMIT_STACK.*/
-		rc = avc_has_perm(tsec->osid, tsec->sid, SECCLASS_PROCESS,
-				  PROCESS__RLIMITINH, NULL);
-		if (rc) {
-			for (i = 0; i < RLIM_NLIMITS; i++) {
-				rlim = current->signal->rlim + i;
-				initrlim = init_task.signal->rlim+i;
-				rlim->rlim_cur = min(rlim->rlim_max,initrlim->rlim_cur);
-			}
-		}
+	if (bsec->unsafe) {
+		force_sig_specific(SIGKILL, current);
+		return;
+	}
+	if (tsec->osid == tsec->sid)
+		return;
 
-		/* Wake up the parent if it is waiting so that it can
-		   recheck wait permission to the new task SID. */
-		wake_up_interruptible(&current->parent->signal->wait_chldexit);
+	/* Close files for which the new task SID is not authorized. */
+	flush_unauthorized_files(current->files);
 
-lock_out:
-		task_lock(current);
-		return;
+	/* Check whether the new SID can inherit signal state
+	   from the old SID.  If not, clear itimers to avoid
+	   subsequent signal generation and flush and unblock
+	   signals. This must occur _after_ the task SID has
+	  been updated so that any kill done after the flush
+	  will be checked against the new SID. */
+	rc = avc_has_perm(tsec->osid, tsec->sid, SECCLASS_PROCESS,
+			  PROCESS__SIGINH, NULL);
+	if (rc) {
+		memset(&itimer, 0, sizeof itimer);
+		for (i = 0; i < 3; i++)
+			do_setitimer(i, &itimer, NULL);
+		flush_signals(current);
+		spin_lock_irq(&current->sighand->siglock);
+		flush_signal_handlers(current, 1);
+		sigemptyset(&current->blocked);
+		recalc_sigpending();
+		spin_unlock_irq(&current->sighand->siglock);
+	}
+
+	/* Check whether the new SID can inherit resource limits
+	   from the old SID.  If not, reset all soft limits to
+	   the lower of the current task's hard limit and the init
+	   task's soft limit.  Note that the setting of hard limits 
+	   (even to lower them) can be controlled by the setrlimit 
+	   check. The inclusion of the init task's soft limit into
+	   the computation is to avoid resetting soft limits higher
+	   than the default soft limit for cases where the default
+	   is lower than the hard limit, e.g. RLIMIT_CORE or 
+	   RLIMIT_STACK.*/
+	rc = avc_has_perm(tsec->osid, tsec->sid, SECCLASS_PROCESS,
+			  PROCESS__RLIMITINH, NULL);
+	if (rc) {
+		for (i = 0; i < RLIM_NLIMITS; i++) {
+			rlim = current->signal->rlim + i;
+			initrlim = init_task.signal->rlim+i;
+			rlim->rlim_cur = min(rlim->rlim_max,initrlim->rlim_cur);
+		}
 	}
+
+	/* Wake up the parent if it is waiting so that it can
+	   recheck wait permission to the new task SID. */
+	wake_up_interruptible(&current->parent->signal->wait_chldexit);
 }
 
 /* superblock security operations */
@@ -4218,6 +4225,7 @@ struct security_operations selinux_ops =
 	.bprm_alloc_security =		selinux_bprm_alloc_security,
 	.bprm_free_security =		selinux_bprm_free_security,
 	.bprm_apply_creds =		selinux_bprm_apply_creds,
+	.bprm_post_apply_creds =	selinux_bprm_post_apply_creds,
 	.bprm_set_security =		selinux_bprm_set_security,
 	.bprm_check_security =		selinux_bprm_check_security,
 	.bprm_secureexec =		selinux_bprm_secureexec,
Index: linux-2.6.10-mm1/security/selinux/include/objsec.h
===================================================================
--- linux-2.6.10-mm1.orig/security/selinux/include/objsec.h	2005-01-04 12:15:45.000000000 -0600
+++ linux-2.6.10-mm1/security/selinux/include/objsec.h	2005-01-04 12:42:43.000000000 -0600
@@ -87,6 +87,12 @@ struct bprm_security_struct {
 	struct linux_binprm *bprm;     /* back pointer to bprm object */
 	u32 sid;                       /* SID for transformed process */
 	unsigned char set;
+
+	/*
+	 * unsafe is used to share failure information from bprm_apply_creds()
+	 * to bprm_post_apply_creds().
+	 */
+	char unsafe;
 };
 
 struct netif_security_struct {
