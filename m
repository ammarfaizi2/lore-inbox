Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWIJNqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWIJNqU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 09:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWIJNqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 09:46:19 -0400
Received: from nef2.ens.fr ([129.199.96.40]:64775 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S932177AbWIJNqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 09:46:17 -0400
Date: Sun, 10 Sep 2006 15:46:16 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: [PATCH 4/4] security: capabilities patch (version 0.4.4), part 4/4: add filesystem support
Message-ID: <20060910134616.GE12086@clipper.ens.fr>
References: <20060910133759.GA12086@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910133759.GA12086@clipper.ens.fr>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sun, 10 Sep 2006 15:46:16 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add filesystem support for capabilities.  This is controlled by the
security.capability extended attribute.

Originally a merge from <URL: http://lkml.org/lkml/2006/9/6/229 >.

Notes:

 * mounting nosuid deactivates the permitted ("forced") set of
   capabilities on executables, similarly if no CAP_REG_SXID.

See <URL: http://www.madore.org/~david/linux/newcaps/ > for more
detailed explanations.

Signed-off-by: David A. Madore <david.madore@ens.fr>

---
 include/linux/capability.h |    3 +
 include/linux/security.h   |   10 ++-
 security/Kconfig           |   10 +++
 security/capability.c      |    4 +
 security/commoncap.c       |  154 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 177 insertions(+), 4 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index efc268e..428ccc5 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -295,6 +295,9 @@ #define CAP_AUDIT_WRITE      29
 
 #define CAP_AUDIT_CONTROL    30
 
+/* Number of low (=system, =additional) caps */
+#define CAP_NUMCAPS_SYS	     30
+
 
 /**
  ** Regular capabilities (normally possessed by all processes).
diff --git a/include/linux/security.h b/include/linux/security.h
index 6bc2aad..265ab00 100644
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
 
@@ -2544,12 +2548,12 @@ static inline int security_task_setgroup
 
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
@@ -2584,7 +2588,7 @@ static inline int security_task_kill (st
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
index 291a4bd..1988efc 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -24,6 +24,7 @@ #include <linux/netlink.h>
 #include <linux/ptrace.h>
 #include <linux/xattr.h>
 #include <linux/hugetlb.h>
+#include <linux/mount.h>
 
 int cap_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
@@ -112,11 +113,55 @@ void cap_capset_set (struct task_struct 
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
+	if (cap->version != _LINUX_CAPABILITY_OLD_VERSION)
+		return -EPERM;
+
+	for (i=CAP_NUMCAPS_SYS; i<sizeof(cap->effective); i++) {
+		if (cap->effective & CAP_TO_MASK(i))
+			return -EPERM;
+	}
+	for (i=CAP_NUMCAPS_SYS; i<sizeof(cap->permitted); i++) {
+		if (cap->permitted & CAP_TO_MASK(i))
+			return -EPERM;
+	}
+	for (i=CAP_NUMCAPS_SYS; i<sizeof(cap->inheritable); i++) {
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
 	cap_set_full (bprm->cap_inheritable);
 	cap_clear (bprm->cap_permitted);
 	cap_set_full (bprm->cap_effective);
@@ -152,6 +197,53 @@ int cap_bprm_set_security (struct linux_
 		}
 	}
 
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
+		printk(KERN_NOTICE "%s: Error (%ld) getting xattr\n",
+				__FUNCTION__, (long int)rc);
+		return rc;
+	}
+
+	if (rc != sizeof(cap_struct)) {
+		printk(KERN_NOTICE "%s: got wrong size for getxattr (%ld)\n",
+					__FUNCTION__, (long int)rc);
+		return -EPERM;
+	}
+	
+	convert_to_le(&cap_struct);
+	if (check_cap_sanity(&cap_struct))
+		return -EPERM;
+
+	bprm->cap_effective = cap_combine (cap_intersect (bprm->cap_effective,
+							  CAP_REGULAR_SET),
+					   to_cap_t(cap_struct.effective));
+	bprm->cap_permitted = cap_combine (cap_intersect (bprm->cap_permitted,
+							  CAP_REGULAR_SET),
+					   to_cap_t(cap_struct.permitted));
+	if (!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)
+	    || !capable(CAP_REG_SXID)) /* Don't allow to gain privileges! */
+		cap_clear (bprm->cap_permitted);
+	bprm->cap_inheritable = cap_combine (cap_intersect (bprm->cap_inheritable,
+							    CAP_REGULAR_SET),
+					     to_cap_t(cap_struct.inheritable));
+
+#endif
 	return 0;
 }
 
@@ -340,6 +432,62 @@ int cap_task_post_setuid (uid_t old_ruid
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
@@ -377,6 +525,10 @@ EXPORT_SYMBOL(cap_bprm_secureexec);
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
