Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWIFS1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWIFS1X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 14:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWIFS1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 14:27:23 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:12004 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751394AbWIFS1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 14:27:21 -0400
Date: Wed, 6 Sep 2006 13:27:19 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-security-module@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] security: introduce fs caps
Message-ID: <20060906182719.GB24670@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the full patch as it currently stands to implement file
posix capabilities.  It's my belief this should now be safe for
a -mm spin, but obviously first I'd like to get some more comments.

Compiling with SECURITY_FS_CAPABILITIES=n, or simply not giving
any files fscaps, should preserve existing behavior.

thanks,
-serge

Subject: [PATCH 1/1] security: introduce fs caps

Implement filesystem posix capabilities.  This allows programs to
be given a subset of root's powers regardless of who runs them,
without having to use setuid and giving the binary all of root's
powers.

This version works with Kaigai Kohei's userspace tools, found at
http://www.kaigai.gr.jp/pub/fscaps-1.0-kg.src.rpm under
http://www.kaigai.gr.jp/index.php?FrontPage#b556e50d.

Changelog:
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
 include/linux/capability.h |    2 +
 include/linux/security.h   |   10 ++-
 security/Kconfig           |   10 +++
 security/capability.c      |    4 +
 security/commoncap.c       |  159 ++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 176 insertions(+), 9 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 6548b35..8b1932c 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -288,6 +288,8 @@ #define CAP_AUDIT_WRITE      29
 
 #define CAP_AUDIT_CONTROL    30
 
+#define CAP_NUMCAPS	     30
+
 #ifdef __KERNEL__
 /* 
  * Bounding set
diff --git a/include/linux/security.h b/include/linux/security.h
index f753038..7a99930 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -51,6 +51,10 @@ extern int cap_inode_setxattr(struct den
 extern int cap_inode_removexattr(struct dentry *dentry, char *name);
 extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
 extern void cap_task_reparent_to_init (struct task_struct *p);
+extern int cap_task_kill(struct task_struct *p, struct siginfo *info, int sig, u32 secid);
+extern int cap_task_setscheduler (struct task_struct *p, int policy, struct sched_param *lp);
+extern int cap_task_setioprio (struct task_struct *p, int ioprio);
+extern int cap_task_setnice (struct task_struct *p, int nice);
 extern int cap_syslog (int type);
 extern int cap_vm_enough_memory (long pages);
 
@@ -2522,12 +2526,12 @@ static inline int security_task_setgroup
 
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
@@ -2562,7 +2566,7 @@ static inline int security_task_kill (st
 				      struct siginfo *info, int sig,
 				      u32 secid)
 {
-	return 0;
+	return cap_task_kill(p, info, sig, secid);
 }
 
 static inline int security_task_wait (struct task_struct *p)
diff --git a/security/Kconfig b/security/Kconfig
index 67785df..ce2bac7 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -80,6 +80,16 @@ config SECURITY_CAPABILITIES
 	  This enables the "default" Linux capabilities functionality.
 	  If you are unsure how to answer this question, answer Y.
 
+config SECURITY_FS_CAPABILITIES
+	bool "Filesystem Capabilities"
+	depends on SECURITY_CAPABILITIES
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
index f50fc29..aee3bd9 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -109,11 +109,55 @@ void cap_capset_set (struct task_struct 
 	target->cap_permitted = *permitted;
 }
 
+#define XATTR_CAPS_SUFFIX "capability"
+#define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
+struct vfs_cap_data_struct {
+	__u32 version;
+	__u32 effective;
+	__u32 permitted;
+	__u32 inheritable;
+};
+
+static inline void convert_to_le(struct vfs_cap_data_struct *cap)
+{
+	cap->version = le32_to_cpu(cap->version);
+	cap->effective = le32_to_cpu(cap->effective);
+	cap->permitted = le32_to_cpu(cap->permitted);
+	cap->inheritable = le32_to_cpu(cap->inheritable);
+}
+
+static int check_cap_sanity(struct vfs_cap_data_struct *cap)
+{
+	int i;
+
+	if (cap->version != _LINUX_CAPABILITY_VERSION)
+		return -EPERM;
+
+	for (i=CAP_NUMCAPS; i<sizeof(cap->effective); i++) {
+		if (cap->effective & CAP_TO_MASK(i))
+			return -EPERM;
+	}
+	for (i=CAP_NUMCAPS; i<sizeof(cap->permitted); i++) {
+		if (cap->permitted & CAP_TO_MASK(i))
+			return -EPERM;
+	}
+	for (i=CAP_NUMCAPS; i<sizeof(cap->inheritable); i++) {
+		if (cap->inheritable & CAP_TO_MASK(i))
+			return -EPERM;
+	}
+
+	return 0;
+}
+
 int cap_bprm_set_security (struct linux_binprm *bprm)
 {
+	struct dentry *dentry;
+	ssize_t rc;
+	struct vfs_cap_data_struct cap_struct;
+	struct inode *inode;
+
 	/* Copied from fs/exec.c:prepare_binprm. */
 
-	/* We don't have VFS support for capabilities yet */
 	cap_clear (bprm->cap_inheritable);
 	cap_clear (bprm->cap_permitted);
 	cap_clear (bprm->cap_effective);
@@ -134,6 +178,45 @@ int cap_bprm_set_security (struct linux_
 		if (bprm->e_uid == 0)
 			cap_set_full (bprm->cap_effective);
 	}
+
+#ifdef CONFIG_SECURITY_FS_CAPABILITIES
+	/* Locate any VFS capabilities: */
+
+	dentry = dget(bprm->file->f_dentry);
+	inode = dentry->d_inode;
+	if (!inode->i_op || !inode->i_op->getxattr) {
+		dput(dentry);
+		return 0;
+	}
+
+	rc = inode->i_op->getxattr(dentry, XATTR_NAME_CAPS, &cap_struct,
+						sizeof(cap_struct));
+	dput(dentry);
+
+	if (rc == -ENODATA)
+		return 0;
+
+	if (rc < 0) {
+		printk(KERN_NOTICE "%s: Error (%d) getting xattr\n",
+				__FUNCTION__, rc);
+		return rc;
+	}
+
+	if (rc != sizeof(cap_struct)) {
+		printk(KERN_NOTICE "%s: got wrong size for getxattr (%d)\n",
+					__FUNCTION__, rc);
+		return -EPERM;
+	}
+	
+	convert_to_le(&cap_struct);
+	if (check_cap_sanity(&cap_struct))
+		return -EPERM;
+
+	bprm->cap_effective = cap_struct.effective;
+	bprm->cap_permitted = cap_struct.permitted;
+	bprm->cap_inheritable = cap_struct.inheritable;
+
+#endif
 	return 0;
 }
 
@@ -182,11 +265,15 @@ void cap_bprm_apply_creds (struct linux_
 
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
@@ -300,6 +387,62 @@ int cap_task_post_setuid (uid_t old_ruid
 	return 0;
 }
 
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
+	if (capable(CAP_KILL))
+		return 0;
+	if (cap_issubset(p->cap_permitted, current->cap_permitted))
+		return 0;
+
+	return -EPERM;
+}
+
 void cap_task_reparent_to_init (struct task_struct *p)
 {
 	p->cap_effective = CAP_INIT_EFF_SET;
@@ -337,6 +480,10 @@ EXPORT_SYMBOL(cap_bprm_secureexec);
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
-- 
1.4.2

