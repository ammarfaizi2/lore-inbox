Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758431AbWK0RIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758431AbWK0RIZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 12:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758429AbWK0RIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 12:08:25 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:29092 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1758416AbWK0RIX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 12:08:23 -0500
Date: Mon, 27 Nov 2006 11:07:40 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Chris Friedhoff <chris@friedhoff.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] Implement file posix capabilities
Message-ID: <20061127170740.GA5859@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge E. Hallyn <serue@us.ibm.com>
Subject: [PATCH 1/1] Implement file posix capabilities

Implement file posix capabilities.  This allows programs to be given a
subset of root's powers regardless of who runs them, without having to use
setuid and giving the binary all of root's powers.

This version works with Kaigai Kohei's userspace tools, found at
http://www.kaigai.gr.jp/index.php.  For more information on how to use this
patch, Chris Friedhoff has posted a nice page at
http://www.friedhoff.org/fscaps.html.

Changelog:
	Nov 27:
	Incorporate fixes from Andrew Morton
	(security-introduce-file-caps-tweaks and
	security-introduce-file-caps-warning-fix)
	Fix Kconfig dependency.
	Fix change signaling behavior when file caps are not compiled in.

	Nov 13:
	Integrate comments from Alexey: Remove CONFIG_ ifdef from
	capability.h, and use %zd for printing a size_t.

	Nov 13:
	Fix endianness warnings by sparse as suggested by Alexey
	Dobriyan.

	Nov 09:
	Address warnings of unused variables at cap_bprm_set_security
	when file capabilities are disabled, and simultaneously clean
	up the code a little, by pulling the new code into a helper
	function.

	Nov 08:
	For pointers to required userspace tools and how to use
	them, see http://www.friedhoff.org/fscaps.html.

	Nov 07:
	Fix the calculation of the highest bit checked in
	check_cap_sanity().

	Nov 07:
	Allow file caps to be enabled without CONFIG_SECURITY, since
	capabilities are the default.
	Hook cap_task_setscheduler when !CONFIG_SECURITY.
	Move capable(TASK_KILL) to end of cap_task_kill to reduce
	audit messages.

	Nov 05:
	Add secondary calls in selinux/hooks.c to task_setioprio and
	task_setscheduler so that selinux and capabilities with file
	cap support can be stacked.

	Sep 05:
	As Seth Arnold points out, uid checks are out of place
	for capability code.

	Sep 01:
	Define task_setscheduler, task_setioprio, cap_task_kill, and
	task_setnice to make sure a user cannot affect a process in which
	they called a program with some fscaps.

	One remaining question is the note under task_setscheduler: are we
	ok with CAP_SYS_NICE being sufficient to confine a process to a
	cpuset?

	It is a semantic change, as without fsccaps, attach_task doesn't
	allow CAP_SYS_NICE to override the uid equivalence check.  But since
	it uses security_task_setscheduler, which elsewhere is used where
	CAP_SYS_NICE can be used to override the uid equivalence check,
	fixing it might be tough.

	     task_setscheduler
		 note: this also controls cpuset:attach_task.  Are we ok with
		     CAP_SYS_NICE being used to confine to a cpuset?
	     task_setioprio
	     task_setnice
		 sys_setpriority uses this (through set_one_prio) for another
		 process.  Need same checks as setrlimit

	Aug 21:
	Updated secureexec implementation to reflect the fact that
	euid and uid might be the same and nonzero, but the process
	might still have elevated caps.

	Aug 15:
	Handle endianness of xattrs.
	Enforce capability version match between kernel and disk.
	Enforce that no bits beyond the known max capability are
	set, else return -EPERM.
	With this extra processing, it may be worth reconsidering
	doing all the work at bprm_set_security rather than
	d_instantiate.

	Aug 10:
	Always call getxattr at bprm_set_security, rather than
	caching it at d_instantiate.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 include/linux/capability.h |   20 +++++
 include/linux/security.h   |   12 ++-
 security/Kconfig           |   10 ++
 security/capability.c      |    4 +
 security/commoncap.c       |  186 ++++++++++++++++++++++++++++++++++++++++++--
 security/selinux/hooks.c   |   12 +++
 6 files changed, 233 insertions(+), 11 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 6548b35..2776886 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -40,11 +40,29 @@ typedef struct __user_cap_data_struct {
         __u32 inheritable;
 } __user *cap_user_data_t;
   
+
+
+#define XATTR_CAPS_SUFFIX "capability"
+#define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
+struct vfs_cap_data_disk {
+	__le32 version;
+	__le32 effective;
+	__le32 permitted;
+	__le32 inheritable;
+};
+
 #ifdef __KERNEL__
 
 #include <linux/spinlock.h>
 #include <asm/current.h>
 
+struct vfs_cap_data {
+	__u32 version;
+	__u32 effective;
+	__u32 permitted;
+	__u32 inheritable;
+};
+
 /* #define STRICT_CAP_T_TYPECHECKS */
 
 #ifdef STRICT_CAP_T_TYPECHECKS
@@ -288,6 +306,8 @@ #define CAP_AUDIT_WRITE      29
 
 #define CAP_AUDIT_CONTROL    30
 
+#define CAP_NUMCAPS	     31
+
 #ifdef __KERNEL__
 /* 
  * Bounding set
diff --git a/include/linux/security.h b/include/linux/security.h
index 83cdefa..648a9bc 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -53,6 +53,10 @@ extern int cap_inode_setxattr(struct den
 extern int cap_inode_removexattr(struct dentry *dentry, char *name);
 extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
 extern void cap_task_reparent_to_init (struct task_struct *p);
+extern int cap_task_kill(struct task_struct *p, struct siginfo *info, int sig, u32 secid);
+extern int cap_task_setscheduler (struct task_struct *p, int policy, struct sched_param *lp);
+extern int cap_task_setioprio (struct task_struct *p, int ioprio);
+extern int cap_task_setnice (struct task_struct *p, int nice);
 extern int cap_syslog (int type);
 extern int cap_vm_enough_memory (long pages);
 
@@ -2585,12 +2589,12 @@ static inline int security_task_setgroup
 
 static inline int security_task_setnice (struct task_struct *p, int nice)
 {
-	return 0;
+	return cap_task_setnice(p, nice);
 }
 
 static inline int security_task_setioprio (struct task_struct *p, int ioprio)
 {
-	return 0;
+	return cap_task_setioprio(p, ioprio);
 }
 
 static inline int security_task_getioprio (struct task_struct *p)
@@ -2608,7 +2612,7 @@ static inline int security_task_setsched
 					      int policy,
 					      struct sched_param *lp)
 {
-	return 0;
+	return cap_task_setscheduler(p, policy, lp);
 }
 
 static inline int security_task_getscheduler (struct task_struct *p)
@@ -2625,7 +2629,7 @@ static inline int security_task_kill (st
 				      struct siginfo *info, int sig,
 				      u32 secid)
 {
-	return 0;
+	return cap_task_kill(p, info, sig, secid);
 }
 
 static inline int security_task_wait (struct task_struct *p)
diff --git a/security/Kconfig b/security/Kconfig
index 0720e31..6d77f68 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -88,6 +88,16 @@ config SECURITY_CAPABILITIES
 	  This enables the "default" Linux capabilities functionality.
 	  If you are unsure how to answer this question, answer Y.
 
+config SECURITY_FS_CAPABILITIES
+	bool "File POSIX Capabilities"
+	depends on SECURITY=n || SECURITY_CAPABILITIES=y
+	default n
+	help
+	  This enables filesystem capabilities, allowing you to give
+	  binaries a subset of root's powers without using setuid 0.
+
+	  If in doubt, answer N.
+
 config SECURITY_ROOTPLUG
 	tristate "Root Plug Support"
 	depends on USB && SECURITY
diff --git a/security/capability.c b/security/capability.c
index b868e7e..14cb592 100644
--- a/security/capability.c
+++ b/security/capability.c
@@ -40,6 +40,10 @@ static struct security_operations capabi
 	.inode_setxattr =		cap_inode_setxattr,
 	.inode_removexattr =		cap_inode_removexattr,
 
+	.task_kill =			cap_task_kill,
+	.task_setscheduler =		cap_task_setscheduler,
+	.task_setioprio =		cap_task_setioprio,
+	.task_setnice =			cap_task_setnice,
 	.task_post_setuid =		cap_task_post_setuid,
 	.task_reparent_to_init =	cap_task_reparent_to_init,
 
diff --git a/security/commoncap.c b/security/commoncap.c
index 5a5ef5c..ce91d9f 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -109,11 +109,97 @@ void cap_capset_set (struct task_struct 
 	target->cap_permitted = *permitted;
 }
 
+#ifdef CONFIG_SECURITY_FS_CAPABILITIES
+static inline void cap_from_disk(struct vfs_cap_data_disk *dcap,
+					struct vfs_cap_data *cap)
+{
+	cap->version = le32_to_cpu(dcap->version);
+	cap->effective = le32_to_cpu(dcap->effective);
+	cap->permitted = le32_to_cpu(dcap->permitted);
+	cap->inheritable = le32_to_cpu(dcap->inheritable);
+}
+
+static int check_cap_sanity(struct vfs_cap_data *cap)
+{
+	int i;
+
+	if (cap->version != _LINUX_CAPABILITY_VERSION)
+		return -EPERM;
+
+	for (i = CAP_NUMCAPS; i < 8*sizeof(cap->effective); i++) {
+		if (cap->effective & CAP_TO_MASK(i))
+			return -EPERM;
+	}
+	for (i = CAP_NUMCAPS; i < 8*sizeof(cap->permitted); i++) {
+		if (cap->permitted & CAP_TO_MASK(i))
+			return -EPERM;
+	}
+	for (i = CAP_NUMCAPS; i < 8*sizeof(cap->inheritable); i++) {
+		if (cap->inheritable & CAP_TO_MASK(i))
+			return -EPERM;
+	}
+
+	return 0;
+}
+
+/* Locate any VFS capabilities: */
+static int set_file_caps(struct linux_binprm *bprm)
+{
+	struct dentry *dentry;
+	ssize_t rc;
+	struct vfs_cap_data_disk dcaps;
+	struct vfs_cap_data caps;
+	struct inode *inode;
+	int err;
+
+	dentry = dget(bprm->file->f_dentry);
+	inode = dentry->d_inode;
+	if (!inode->i_op || !inode->i_op->getxattr) {
+		dput(dentry);
+		return 0;
+	}
+
+	rc = inode->i_op->getxattr(dentry, XATTR_NAME_CAPS, &dcaps,
+						sizeof(dcaps));
+	dput(dentry);
+
+	if (rc == -ENODATA)
+		return 0;
+
+	if (rc < 0) {
+		printk(KERN_NOTICE "%s: Error (%zd) getting xattr\n",
+				__FUNCTION__, rc);
+		return rc;
+	}
+
+	if (rc != sizeof(dcaps)) {
+		printk(KERN_NOTICE "%s: got wrong size for getxattr (%zd)\n",
+					__FUNCTION__, rc);
+		return -EPERM;
+	}
+
+	cap_from_disk(&dcaps, &caps);
+	err = check_cap_sanity(&caps);
+	if (err)
+		return err;
+
+	bprm->cap_effective = caps.effective;
+	bprm->cap_permitted = caps.permitted;
+	bprm->cap_inheritable = caps.inheritable;
+
+	return 0;
+}
+#else
+static inline int set_file_caps(struct linux_binprm *bprm)
+{
+	return 0;
+}
+#endif
+
 int cap_bprm_set_security (struct linux_binprm *bprm)
 {
 	/* Copied from fs/exec.c:prepare_binprm. */
 
-	/* We don't have VFS support for capabilities yet */
 	cap_clear (bprm->cap_inheritable);
 	cap_clear (bprm->cap_permitted);
 	cap_clear (bprm->cap_effective);
@@ -134,7 +220,8 @@ int cap_bprm_set_security (struct linux_
 		if (bprm->e_uid == 0)
 			cap_set_full (bprm->cap_effective);
 	}
-	return 0;
+
+	return set_file_caps(bprm);
 }
 
 void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
@@ -182,11 +269,15 @@ void cap_bprm_apply_creds (struct linux_
 
 int cap_bprm_secureexec (struct linux_binprm *bprm)
 {
-	/* If/when this module is enhanced to incorporate capability
-	   bits on files, the test below should be extended to also perform a 
-	   test between the old and new capability sets.  For now,
-	   it simply preserves the legacy decision algorithm used by
-	   the old userland. */
+	if (current->uid != 0) {
+		if (!cap_isclear(bprm->cap_effective))
+			return 1;
+		if (!cap_isclear(bprm->cap_permitted))
+			return 1;
+		if (!cap_isclear(bprm->cap_inheritable))
+			return 1;
+	}
+
 	return (current->euid != current->uid ||
 		current->egid != current->gid);
 }
@@ -300,6 +391,83 @@ int cap_task_post_setuid (uid_t old_ruid
 	return 0;
 }
 
+#ifdef CONFIG_SECURITY_FS_CAPABILITIES
+/*
+ * Rationale: code calling task_setscheduler, task_setioprio, and
+ * task_setnice, assumes that
+ *   . if capable(cap_sys_nice), then those actions should be allowed
+ *   . if not capable(cap_sys_nice), but acting on your own processes,
+ *   	then those actions should be allowed
+ * This is insufficient now since you can call code without suid, but
+ * yet with increased caps.
+ * So we check for increased caps on the target process.
+ */
+static inline int cap_safe_nice(struct task_struct *p)
+{
+	if (!cap_issubset(p->cap_permitted, current->cap_permitted) &&
+	    !__capable(current, CAP_SYS_NICE))
+		return -EPERM;
+	return 0;
+}
+
+int cap_task_setscheduler (struct task_struct *p, int policy,
+			   struct sched_param *lp)
+{
+	return cap_safe_nice(p);
+}
+
+int cap_task_setioprio (struct task_struct *p, int ioprio)
+{
+	return cap_safe_nice(p);
+}
+
+int cap_task_setnice (struct task_struct *p, int nice)
+{
+	return cap_safe_nice(p);
+}
+
+int cap_task_kill(struct task_struct *p, struct siginfo *info,
+				int sig, u32 secid)
+{
+	if (info != SEND_SIG_NOINFO && (is_si_special(info) || SI_FROMKERNEL(info)))
+		return 0;
+
+	if (secid)
+		/*
+		 * Signal sent as a particular user.
+		 * Capabilities are ignored.  May be wrong, but it's the
+		 * only thing we can do at the moment.
+		 * Used only by usb drivers?
+		 */
+		return 0;
+	if (cap_issubset(p->cap_permitted, current->cap_permitted))
+		return 0;
+	if (capable(CAP_KILL))
+		return 0;
+
+	return -EPERM;
+}
+#else
+int cap_task_setscheduler (struct task_struct *p, int policy,
+			   struct sched_param *lp)
+{
+	return 0;
+}
+int cap_task_setioprio (struct task_struct *p, int ioprio)
+{
+	return 0;
+}
+int cap_task_setnice (struct task_struct *p, int nice)
+{
+	return 0;
+}
+int cap_task_kill(struct task_struct *p, struct siginfo *info,
+				int sig, u32 secid)
+{
+	return 0;
+}
+#endif
+
 void cap_task_reparent_to_init (struct task_struct *p)
 {
 	p->cap_effective = CAP_INIT_EFF_SET;
@@ -337,6 +505,10 @@ EXPORT_SYMBOL(cap_bprm_secureexec);
 EXPORT_SYMBOL(cap_inode_setxattr);
 EXPORT_SYMBOL(cap_inode_removexattr);
 EXPORT_SYMBOL(cap_task_post_setuid);
+EXPORT_SYMBOL(cap_task_kill);
+EXPORT_SYMBOL(cap_task_setscheduler);
+EXPORT_SYMBOL(cap_task_setioprio);
+EXPORT_SYMBOL(cap_task_setnice);
 EXPORT_SYMBOL(cap_task_reparent_to_init);
 EXPORT_SYMBOL(cap_syslog);
 EXPORT_SYMBOL(cap_vm_enough_memory);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a95018a..277dcec 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2781,6 +2781,12 @@ static int selinux_task_setnice(struct t
 
 static int selinux_task_setioprio(struct task_struct *p, int ioprio)
 {
+	int rc;
+
+	rc = secondary_ops->task_setioprio(p, ioprio);
+	if (rc)
+		return rc;
+
 	return task_has_perm(current, p, PROCESS__SETSCHED);
 }
 
@@ -2810,6 +2816,12 @@ static int selinux_task_setrlimit(unsign
 
 static int selinux_task_setscheduler(struct task_struct *p, int policy, struct sched_param *lp)
 {
+	int rc;
+
+	rc = secondary_ops->task_setscheduler(p, policy, lp);
+	if (rc)
+		return rc;
+
 	return task_has_perm(current, p, PROCESS__SETSCHED);
 }
 
-- 
1.4.1

