Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWG3BNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWG3BNu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 21:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWG3BNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 21:13:50 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:46559 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750928AbWG3BNt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 21:13:49 -0400
Date: Sat, 29 Jul 2006 20:13:38 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [RFC] [PATCH] file posix capabilities
Message-ID: <20060730011338.GA31695@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements file (posix) capabilities.  This allows
a binary to gain a subset of root's capabilities without having
the file actually be setuid root.

There are some other implementations out there taking various
approaches.  This patch keeps all the changes within the
capability LSM, and stores the file capabilities in xattrs
named "security.capability".  First question is, do we want
this in the kernel?  Second is, is this sort of implementation
we'd want?

Some userspace tools to manipulate the fscaps are at
www.sr71.net/~hallyn/fscaps/.  For instance,

	setcap writeroot "cap_dac_read_search,cap_dac_override+eip"

allows the 'writeroot' testcase to write to /root/ab when
run as a normal user.

This patch doesn't address the need to update
cap_bprm_secureexec().

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 include/linux/security.h |   10 +++-
 security/Kconfig         |   11 ++++
 security/capability.c    |    5 ++
 security/commoncap.c     |  127 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+), 1 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index f753038..9f90f01 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -47,8 +47,14 @@ extern void cap_capset_set (struct task_
 extern int cap_bprm_set_security (struct linux_binprm *bprm);
 extern void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe);
 extern int cap_bprm_secureexec(struct linux_binprm *bprm);
+extern void cap_d_instantiate(struct dentry *dentry, struct inode *inode);
 extern int cap_inode_setxattr(struct dentry *dentry, char *name, void *value, size_t size, int flags);
 extern int cap_inode_removexattr(struct dentry *dentry, char *name);
+extern int cap_inode_alloc_security(struct inode *inode);
+extern void cap_inode_free_security(struct inode *inode);
+extern void cap_inode_free_security(struct inode *inode);
+extern void cap_inode_post_setxattr(struct dentry *dentry, char *name,
+                                        void *value, size_t size, int flags);
 extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
 extern void cap_task_reparent_to_init (struct task_struct *p);
 extern int cap_syslog (int type);
@@ -2684,7 +2690,9 @@ static inline int security_sem_semop (st
 }
 
 static inline void security_d_instantiate (struct dentry *dentry, struct inode *inode)
-{ }
+{
+	cap_d_instantiate(dentry, inode);
+}
 
 static inline int security_getprocattr(struct task_struct *p, char *name, void *value, size_t size)
 {
diff --git a/security/Kconfig b/security/Kconfig
index 67785df..c1fceda 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -80,6 +80,17 @@ config SECURITY_CAPABILITIES
 	  This enables the "default" Linux capabilities functionality.
 	  If you are unsure how to answer this question, answer Y.
 
+config SECURITY_FS_CAPS
+	boolean "Filesystem POSIX capabilities"
+	depends on SECURITY_CAPABILITIES
+	help
+	  This enables filesystem capabilities.  These allow you to
+	  give a subset of root's powers to specific binaries without
+	  making the binaries setuid 0.
+	  This will require another patch in order to work with
+	  selinux enabled.
+	  If you are unsure how to answer this question, answer N.
+
 config SECURITY_ROOTPLUG
 	tristate "Root Plug Support"
 	depends on USB && SECURITY
diff --git a/security/capability.c b/security/capability.c
index b868e7e..67f9388 100644
--- a/security/capability.c
+++ b/security/capability.c
@@ -39,6 +39,11 @@ static struct security_operations capabi
 
 	.inode_setxattr =		cap_inode_setxattr,
 	.inode_removexattr =		cap_inode_removexattr,
+	.inode_alloc_security =		cap_inode_alloc_security,
+	.inode_free_security =		cap_inode_free_security,
+	.inode_post_setxattr =		cap_inode_post_setxattr,
+
+	.d_instantiate =                cap_d_instantiate,
 
 	.task_post_setuid =		cap_task_post_setuid,
 	.task_reparent_to_init =	cap_task_reparent_to_init,
diff --git a/security/commoncap.c b/security/commoncap.c
index f50fc29..7504c84 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -24,6 +24,11 @@ #include <linux/ptrace.h>
 #include <linux/xattr.h>
 #include <linux/hugetlb.h>
 
+struct cap_isec {
+	struct semaphore sem;
+	kernel_cap_t inheritable, permitted, effective;
+};
+
 int cap_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
 	NETLINK_CB(skb).eff_cap = current->cap_effective;
@@ -111,6 +116,9 @@ void cap_capset_set (struct task_struct 
 
 int cap_bprm_set_security (struct linux_binprm *bprm)
 {
+#ifdef CONFIG_SECURITY_FS_CAPS
+	struct inode *inode;
+#endif
 	/* Copied from fs/exec.c:prepare_binprm. */
 
 	/* We don't have VFS support for capabilities yet */
@@ -118,6 +126,17 @@ int cap_bprm_set_security (struct linux_
 	cap_clear (bprm->cap_permitted);
 	cap_clear (bprm->cap_effective);
 
+#ifdef CONFIG_SECURITY_FS_CAPS
+	inode = bprm->file->f_dentry->d_inode;
+	if (inode->i_security) {
+		struct cap_isec *isec = inode->i_security;
+
+		bprm->cap_inheritable = isec->inheritable;
+		bprm->cap_permitted = isec->permitted;
+		bprm->cap_effective = isec->effective;
+	}
+#endif
+
 	/*  To support inheritance of root-permissions and suid-root
 	 *  executables under compatibility mode, we raise all three
 	 *  capability sets for the file.
@@ -210,6 +229,110 @@ int cap_inode_removexattr(struct dentry 
 	return 0;
 }
 
+#ifdef CONFIG_SECURITY_FS_CAPS
+int cap_inode_alloc_security(struct inode *inode)
+{
+	struct cap_isec *isec;
+	
+	isec = kzalloc(sizeof(*isec), GFP_KERNEL);
+	if (!isec)
+		return -ENOMEM;
+	init_MUTEX(&isec->sem);
+	inode->i_security = isec;
+	return 0;
+}
+
+void cap_inode_free_security(struct inode *inode)
+{
+	kfree(inode->i_security);
+}
+
+#define XATTR_CAPS_SUFFIX "capability"
+#define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX
+void cap_d_instantiate(struct dentry *dentry, struct inode *inode)
+{
+	struct cap_isec *isec;
+	int rc;
+	u32 fscaps[3];
+
+	if (!inode)
+		return;
+	if (!inode->i_op->getxattr)
+		return;
+
+	isec = inode->i_security;
+	down(&isec->sem);
+	if (!dentry)
+		dentry = d_find_alias(inode);
+	rc = inode->i_op->getxattr(dentry, XATTR_NAME_CAPS,
+				   fscaps, sizeof(fscaps));
+	if (rc < 0 && rc != -ENODATA) {
+		printk(KERN_NOTICE "%s: Error (%d) getting xattr\n",
+				__FUNCTION__, rc);
+		goto out;
+	}
+	if (rc < 0)
+		goto out;
+
+	if (rc != sizeof(fscaps)) {
+		printk(KERN_NOTICE "%s: got wrong size for getxattr (%d)\n",
+					__FUNCTION__, rc);
+		goto out;
+	}
+
+	isec->effective = fscaps[0];
+	isec->inheritable = fscaps[1];
+	isec->permitted = fscaps[2];
+
+out:
+	up(&isec->sem);
+}
+
+void cap_inode_post_setxattr(struct dentry *dentry, char *name,
+                                        void *value, size_t size, int flags)
+{
+	struct cap_isec *isec;
+	struct inode *inode;
+	u32 *fscaps;
+
+	if (strcmp(name, XATTR_NAME_CAPS)) {
+		/* Not an attribute we recognize, so nothing to do. */
+		return;
+	}
+
+	fscaps = value;
+	inode = dentry->d_inode;
+	isec = inode->i_security;
+	if (!isec) {
+		int ret;
+		ret = cap_inode_alloc_security(inode);
+		if (ret)
+			return;
+		isec = inode->i_security;
+	}
+	down(&isec->sem);
+	isec->effective = fscaps[0];
+	isec->inheritable = fscaps[1];
+	isec->permitted = fscaps[2];
+	up(&isec->sem);
+}
+#else
+int cap_inode_alloc_security(struct inode *inode)
+{
+	return 0;
+}
+
+void cap_inode_free_security(struct inode *inode)
+{ }
+
+void cap_d_instantiate(struct dentry *dentry, struct inode *inode)
+{ }
+
+void cap_inode_post_setxattr(struct dentry *dentry, char *name,
+                                        void *value, size_t size, int flags)
+{ }
+#endif
+
 /* moved from kernel/sys.c. */
 /* 
  * cap_emulate_setxuid() fixes the effective / permitted capabilities of
@@ -336,6 +459,10 @@ EXPORT_SYMBOL(cap_bprm_apply_creds);
 EXPORT_SYMBOL(cap_bprm_secureexec);
 EXPORT_SYMBOL(cap_inode_setxattr);
 EXPORT_SYMBOL(cap_inode_removexattr);
+EXPORT_SYMBOL(cap_inode_alloc_security);
+EXPORT_SYMBOL(cap_inode_free_security);
+EXPORT_SYMBOL(cap_inode_post_setxattr);
+EXPORT_SYMBOL(cap_d_instantiate);
 EXPORT_SYMBOL(cap_task_post_setuid);
 EXPORT_SYMBOL(cap_task_reparent_to_init);
 EXPORT_SYMBOL(cap_syslog);
-- 
1.4.1

