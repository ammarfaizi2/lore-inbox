Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751806AbWCILMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWCILMQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbWCILMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:12:15 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:25728 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751806AbWCILMO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:12:14 -0500
Date: Thu, 9 Mar 2006 03:16:51 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] refactor capable() to one implementation, add __capable() helper
Message-ID: <20060309111651.GA3883@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move capable() to kernel/capability.c and eliminate duplicate
implementations.  Add __capable() function which can be used
to check for capabiilty of any process.

Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 include/linux/capability.h |    3 ++-
 include/linux/security.h   |   22 ++++++++++++++++------
 kernel/capability.c        |   16 ++++++++++++++++
 kernel/sys.c               |   12 ------------
 security/security.c        |   23 -----------------------
 5 files changed, 34 insertions(+), 42 deletions(-)

--- linus-2.6.orig/include/linux/capability.h
+++ linus-2.6/include/linux/capability.h
@@ -357,7 +357,8 @@ static inline kernel_cap_t cap_invert(ke
 
 #define cap_is_fs_cap(c)     (CAP_TO_MASK(c) & CAP_FS_MASK)
 
-extern int capable(int cap);
+int capable(int cap);
+int __capable(struct task_struct *t, int cap);
 
 #endif /* __KERNEL__ */
 
--- linus-2.6.orig/include/linux/security.h
+++ linus-2.6/include/linux/security.h
@@ -1040,6 +1040,11 @@ struct swap_info_struct;
  *	@effective contains the effective capability set.
  *	@inheritable contains the inheritable capability set.
  *	@permitted contains the permitted capability set.
+ * @capable:
+ *	Check whether the @tsk process has the @cap capability.
+ *	@tsk contains the task_struct for the process.
+ *	@cap contains the capability <include/linux/capability.h>.
+ *	Return 0 if the capability is granted for @tsk.
  * @acct:
  *	Check permission before enabling or disabling process accounting.  If
  *	accounting is being enabled, then @file refers to the open file used to
@@ -1053,11 +1058,6 @@ struct swap_info_struct;
  *	@table contains the ctl_table structure for the sysctl variable.
  *	@op contains the operation (001 = search, 002 = write, 004 = read).
  *	Return 0 if permission is granted.
- * @capable:
- *	Check whether the @tsk process has the @cap capability.
- *	@tsk contains the task_struct for the process.
- *	@cap contains the capability <include/linux/capability.h>.
- *	Return 0 if the capability is granted for @tsk.
  * @syslog:
  *	Check permission before accessing the kernel message ring or changing
  *	logging to the console.
@@ -1099,9 +1099,9 @@ struct security_operations {
 			    kernel_cap_t * effective,
 			    kernel_cap_t * inheritable,
 			    kernel_cap_t * permitted);
+	int (*capable) (struct task_struct * tsk, int cap);
 	int (*acct) (struct file * file);
 	int (*sysctl) (struct ctl_table * table, int op);
-	int (*capable) (struct task_struct * tsk, int cap);
 	int (*quotactl) (int cmds, int type, int id, struct super_block * sb);
 	int (*quota_on) (struct dentry * dentry);
 	int (*syslog) (int type);
@@ -1346,6 +1346,11 @@ static inline void security_capset_set (
 	security_ops->capset_set (target, effective, inheritable, permitted);
 }
 
+static inline int security_capable (struct task_struct *tsk, int cap)
+{
+	return security_ops->capable (tsk, cap);
+}
+
 static inline int security_acct (struct file *file)
 {
 	return security_ops->acct (file);
@@ -2049,6 +2054,11 @@ static inline void security_capset_set (
 	cap_capset_set (target, effective, inheritable, permitted);
 }
 
+static inline int security_capable (struct task_struct *tsk, int cap)
+{
+	return cap_capable(tsk, cap);
+}
+
 static inline int security_acct (struct file *file)
 {
 	return 0;
--- linus-2.6.orig/kernel/capability.c
+++ linus-2.6/kernel/capability.c
@@ -233,3 +233,19 @@ out:
 
      return ret;
 }
+
+int __capable(struct task_struct *t, int cap)
+{
+	if (security_capable(t, cap) == 0) {
+		t->flags |= PF_SUPERPRIV;
+		return 1;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(__capable);
+
+int capable(int cap)
+{
+	return __capable(current, cap);
+}
+EXPORT_SYMBOL(capable);
--- linus-2.6.orig/kernel/sys.c
+++ linus-2.6/kernel/sys.c
@@ -224,18 +224,6 @@ int unregister_reboot_notifier(struct no
 
 EXPORT_SYMBOL(unregister_reboot_notifier);
 
-#ifndef CONFIG_SECURITY
-int capable(int cap)
-{
-        if (cap_raised(current->cap_effective, cap)) {
-	       current->flags |= PF_SUPERPRIV;
-	       return 1;
-        }
-        return 0;
-}
-EXPORT_SYMBOL(capable);
-#endif
-
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
 	int no_nice;
--- linus-2.6.orig/security/security.c
+++ linus-2.6/security/security.c
@@ -174,31 +174,8 @@ int mod_unreg_security(const char *name,
 	return security_ops->unregister_security(name, ops);
 }
 
-/**
- * capable - calls the currently loaded security module's capable() function with the specified capability
- * @cap: the requested capability level.
- *
- * This function calls the currently loaded security module's capable()
- * function with a pointer to the current task and the specified @cap value.
- *
- * This allows the security module to implement the capable function call
- * however it chooses to.
- */
-int capable(int cap)
-{
-	if (security_ops->capable(current, cap)) {
-		/* capability denied */
-		return 0;
-	}
-
-	/* capability granted */
-	current->flags |= PF_SUPERPRIV;
-	return 1;
-}
-
 EXPORT_SYMBOL_GPL(register_security);
 EXPORT_SYMBOL_GPL(unregister_security);
 EXPORT_SYMBOL_GPL(mod_reg_security);
 EXPORT_SYMBOL_GPL(mod_unreg_security);
-EXPORT_SYMBOL(capable);
 EXPORT_SYMBOL(security_ops);
