Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263631AbUDUTiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbUDUTiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 15:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263629AbUDUTiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 15:38:21 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:26273 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S263631AbUDUTh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 15:37:59 -0400
Message-ID: <4086CD7A.8060303@stanford.edu>
Date: Wed, 21 Apr 2004 12:37:30 -0700
From: Andy Lutomirski <luto@stanford.edu>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Chris Wright <chrisw@osdl.org>, Andy Lutomirski <luto@myrealbox.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: compute_creds fixup in -mm
References: <20040421010621.L22989@build.pdx.osdl.net>	 <4086AEFC.5010002@myrealbox.com>	 <1082571199.9213.61.camel@moss-spartans.epoch.ncsc.mil>	 <20040421112827.O21045@build.pdx.osdl.net> <1082572971.9213.75.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1082572971.9213.75.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley wrote:

> On Wed, 2004-04-21 at 14:28, Chris Wright wrote:
> 
>>* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
>>
>>>I didn't see Chris' patch.  I assume that the worst case is unexpected
>>>program failure due to lack of capability, right?  The SELinux security
>>
>>The opposite.  You'd get a program with non-root euid, but full
>>capability set, and AT_SECURE set false.  My patch is below.
> 
> 
> Sorry, I wasn't clear.  I meant the worst case due to the share/ptrace
> state check being duplicated in SELinux and in commoncap, as opposed to
> being performed once as in Andy's patch.
> 

I was worried about sid changing but uid and caps staying the same if
a ptrace_detach or _exit happens between the cap_bprm_apply_creds call
and the rest of selinux_bprm_apply_creds.  Remember the sendmail bug --
program failure due to lack of capabilities can cause privilege leaks
(in this case selinux sid leaks).

If this isn't a concern, then Chris' patch should be fine.  On the other
hand, some other LSM may prefer my version.  Here's my corrected patch
(thanks, Chris):

--- linux-2.6.5-mm5/include/linux/security.h.ptlock	2004-04-21 08:52:49.904877920 -0700
+++ linux-2.6.5-mm5/include/linux/security.h	2004-04-21 09:12:46.540961584 -0700
@@ -44,7 +44,7 @@
  extern int cap_capset_check (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
  extern void cap_capset_set (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
  extern int cap_bprm_set_security (struct linux_binprm *bprm);
-extern void cap_bprm_apply_creds (struct linux_binprm *bprm);
+extern void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe);
  extern int cap_bprm_secureexec(struct linux_binprm *bprm);
  extern int cap_inode_setxattr(struct dentry *dentry, char *name, void *value, size_t size, int flags);
  extern int cap_inode_removexattr(struct dentry *dentry, char *name);
@@ -86,6 +86,11 @@
  struct sched_param;
  struct swap_info_struct;

+/* brpm_apply_creds unsafe reasons */
+#define LSM_UNSAFE_SHARE	1
+#define LSM_UNSAFE_PTRACE	2
+#define LSM_UNSAFE_PTRACE_CAP	4
+
  #ifdef CONFIG_SECURITY

  /**
@@ -112,6 +117,8 @@
   *	also perform other state changes on the process (e.g.  closing open
   *	file descriptors to which access is no longer granted if the attributes
   *	were changed).
+ *	bprm_apply_creds is called under task_lock.  @unsafe indicates various
+ *	reasons why it may be unsafe to change security state.
   *	@bprm contains the linux_binprm structure.
   * @bprm_set_security:
   *	Save security information in the bprm->security field, typically based
@@ -1026,7 +1033,7 @@

  	int (*bprm_alloc_security) (struct linux_binprm * bprm);
  	void (*bprm_free_security) (struct linux_binprm * bprm);
-	void (*bprm_apply_creds) (struct linux_binprm * bprm);
+	void (*bprm_apply_creds) (struct linux_binprm * bprm, int unsafe);
  	int (*bprm_set_security) (struct linux_binprm * bprm);
  	int (*bprm_check_security) (struct linux_binprm * bprm);
  	int (*bprm_secureexec) (struct linux_binprm * bprm);
@@ -1290,9 +1297,9 @@
  {
  	security_ops->bprm_free_security (bprm);
  }
-static inline void security_bprm_apply_creds (struct linux_binprm *bprm)
+static inline void security_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
  {
-	security_ops->bprm_apply_creds (bprm);
+	security_ops->bprm_apply_creds (bprm, unsafe);
  }
  static inline int security_bprm_set (struct linux_binprm *bprm)
  {
@@ -1962,9 +1969,9 @@
  static inline void security_bprm_free (struct linux_binprm *bprm)
  { }

-static inline void security_bprm_apply_creds (struct linux_binprm *bprm)
+static inline void security_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
  {
-	cap_bprm_apply_creds (bprm);
+	cap_bprm_apply_creds (bprm, unsafe);
  }

  static inline int security_bprm_set (struct linux_binprm *bprm)
--- linux-2.6.5-mm5/fs/exec.c.ptlock	2004-04-21 08:50:37.767965784 -0700
+++ linux-2.6.5-mm5/fs/exec.c	2004-04-21 12:23:01.915761696 -0700
@@ -919,24 +919,28 @@

  EXPORT_SYMBOL(prepare_binprm);

-/*
- * This function is used to produce the new IDs and capabilities
- * from the old ones and the file's capabilities.
- *
- * The formula used for evolving capabilities is:
- *
- *       pI' = pI
- * (***) pP' = (fP & X) | (fI & pI)
- *       pE' = pP' & fE          [NB. fE is 0 or ~0]
- *
- * I=Inheritable, P=Permitted, E=Effective // p=process, f=file
- * ' indicates post-exec(), and X is the global 'cap_bset'.
- *
- */
+static inline int must_not_trace_exec (struct task_struct *p)
+{
+	int unsafe = 0;
+	if (p->ptrace & PT_PTRACED) {
+		if(p->ptrace & PT_PTRACE_CAP)
+			unsafe |= LSM_UNSAFE_PTRACE_CAP;
+		else
+			unsafe |= LSM_UNSAFE_PTRACE;
+	}
+	if (atomic_read(&p->fs->count) > 1 ||
+	    atomic_read(&p->files->count) > 1 ||
+	    atomic_read(&p->sighand->count) > 1)
+		unsafe |= LSM_UNSAFE_SHARE;
+
+	return unsafe;
+}

  void compute_creds(struct linux_binprm *bprm)
  {
-	security_bprm_apply_creds(bprm);
+	task_lock(current);
+	security_bprm_apply_creds(bprm, must_not_trace_exec(current));
+	task_unlock(current);
  }

  EXPORT_SYMBOL(compute_creds);
--- linux-2.6.5-mm5/security/selinux/hooks.c.ptlock	2004-04-21 08:57:16.947281304 -0700
+++ linux-2.6.5-mm5/security/selinux/hooks.c	2004-04-21 12:23:58.245198320 -0700
@@ -1746,7 +1746,7 @@
  	spin_unlock(&files->file_lock);
  }

-static void selinux_bprm_apply_creds(struct linux_binprm *bprm)
+static void selinux_bprm_apply_creds(struct linux_binprm *bprm, int unsafe)
  {
  	struct task_security_struct *tsec, *psec;
  	struct bprm_security_struct *bsec;
@@ -1756,7 +1756,7 @@
  	struct rlimit *rlim, *initrlim;
  	int rc, i;

-	secondary_ops->bprm_apply_creds(bprm);
+	secondary_ops->bprm_apply_creds(bprm, unsafe);

  	tsec = current->security;

@@ -1767,9 +1767,7 @@
  	if (tsec->sid != sid) {
  		/* Check for shared state.  If not ok, leave SID
  		   unchanged and kill. */
-		if ((atomic_read(&current->fs->count) > 1 ||
-		     atomic_read(&current->files->count) > 1 ||
-		     atomic_read(&current->sighand->count) > 1)) {
+		if (unsafe & LSM_UNSAFE_SHARE) {
  			rc = avc_has_perm(tsec->sid, sid,
  					  SECCLASS_PROCESS, PROCESS__SHARE,
  					  NULL, NULL);
@@ -1781,15 +1779,13 @@

  		/* Check for ptracing, and update the task SID if ok.
  		   Otherwise, leave SID unchanged and kill. */
-		task_lock(current);
-		if (current->ptrace & PT_PTRACED) {
+		if (unsafe & (LSM_UNSAFE_PTRACE | LSM_UNSAFE_PTRACE_CAP)) {
  			psec = current->parent->security;
  			rc = avc_has_perm_noaudit(psec->sid, sid,
  					  SECCLASS_PROCESS, PROCESS__PTRACE,
  					  NULL, &avd);
  			if (!rc)
  				tsec->sid = sid;
-			task_unlock(current);
  			avc_audit(psec->sid, sid, SECCLASS_PROCESS,
  				  PROCESS__PTRACE, &avd, rc, NULL);
  			if (rc) {
@@ -1798,7 +1794,6 @@
  			}
  		} else {
  			tsec->sid = sid;
-			task_unlock(current);
  		}

  		/* Close files for which the new task SID is not authorized. */
--- linux-2.6.5-mm5/security/commoncap.c.ptlock	2004-04-21 08:54:16.824664104 -0700
+++ linux-2.6.5-mm5/security/commoncap.c	2004-04-21 09:24:01.468357024 -0700
@@ -115,15 +115,7 @@
  	return 0;
  }

-static inline int must_not_trace_exec (struct task_struct *p)
-{
-	return ((p->ptrace & PT_PTRACED) && !(p->ptrace & PT_PTRACE_CAP))
-		|| atomic_read(&p->fs->count) > 1
-		|| atomic_read(&p->files->count) > 1
-		|| atomic_read(&p->sighand->count) > 1;
-}
-
-void cap_bprm_apply_creds (struct linux_binprm *bprm)
+void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
  {
  	/* Derived from fs/exec.c:compute_creds. */
  	kernel_cap_t new_permitted, working;
@@ -133,30 +125,25 @@
  				 current->cap_inheritable);
  	new_permitted = cap_combine (new_permitted, working);

-	task_lock(current);
-
-	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid) {
+	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid ||
+	    !cap_issubset (new_permitted, current->cap_permitted)) {
  		current->mm->dumpable = 0;

-		if (must_not_trace_exec(current) && !capable(CAP_SETUID)) {
-			bprm->e_uid = current->uid;
-			bprm->e_gid = current->gid;
+		if (unsafe & ~LSM_UNSAFE_PTRACE_CAP) {
+			if (!capable(CAP_SETUID)) {
+				bprm->e_uid = current->uid;
+				bprm->e_gid = current->gid;
+			}
+			if (!capable (CAP_SETPCAP)) {
+				new_permitted = cap_intersect (new_permitted,
+							current->cap_permitted);
+			}
  		}
  	}

  	current->suid = current->euid = current->fsuid = bprm->e_uid;
  	current->sgid = current->egid = current->fsgid = bprm->e_gid;

-	if (!cap_issubset (new_permitted, current->cap_permitted)) {
-		current->mm->dumpable = 0;
-
-		if (must_not_trace_exec (current) && !capable (CAP_SETPCAP)) {
-			new_permitted = cap_intersect (new_permitted,
-						       current->
-						       cap_permitted);
-		}
-	}
-
  	/* For init, we want to retain the capabilities set
  	 * in the init_task struct. Thus we skip the usual
  	 * capability rules */
@@ -167,7 +154,6 @@
  	}

  	/* AUD: Audit candidate if current->cap_effective is set */
-	task_unlock(current);

  	current->keep_capabilities = 0;
  }
--- linux-2.6.5-mm5/security/dummy.c.ptlock	2004-04-21 08:56:00.608886504 -0700
+++ linux-2.6.5-mm5/security/dummy.c	2004-04-21 09:14:57.345076336 -0700
@@ -171,21 +171,12 @@
  	return;
  }

-static inline int must_not_trace_exec (struct task_struct *p)
+static void dummy_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
  {
-	return ((p->ptrace & PT_PTRACED) && !(p->ptrace & PT_PTRACE_CAP))
-		|| atomic_read(&p->fs->count) > 1
-		|| atomic_read(&p->files->count) > 1
-		|| atomic_read(&p->sighand->count) > 1;
-}
-
-static void dummy_bprm_apply_creds (struct linux_binprm *bprm)
-{
-	task_lock(current);
  	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid) {
  		current->mm->dumpable = 0;

-		if (must_not_trace_exec(current) && !capable(CAP_SETUID)) {
+		if (unsafe && !capable(CAP_SETUID)) {
  			bprm->e_uid = current->uid;
  			bprm->e_gid = current->gid;
  		}
@@ -193,8 +184,6 @@

  	current->suid = current->euid = current->fsuid = bprm->e_uid;
  	current->sgid = current->egid = current->fsgid = bprm->e_gid;
-
-	task_unlock(current);
  }

  static int dummy_bprm_set_security (struct linux_binprm *bprm)

