Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbVHYBWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbVHYBWa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 21:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbVHYBWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 21:22:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8360 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932467AbVHYBW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 21:22:28 -0400
Message-Id: <20050825012147.784275000@localhost.localdomain>
References: <20050825012028.720597000@localhost.localdomain>
Date: Wed, 24 Aug 2005 18:20:29 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org, Kurt Garloff <garloff@suse.de>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH 1/5] Use capabilities as default w/ and w/out CONFIG_SECURITY.
Content-Disposition: inline; filename=security-cap-def.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a kernel is compiled with CONFIG_SECURITY to enable LSM, the
default behaviour changes unless the admin loads capability.
This is undesirable. This patch makes capability the default.
capability can still be compiled as module and be loaded as LSM.
If loaded as primary LSM, it won't change anything. But it may
also be loaded as secondary LSM and stacked on top of another
LSM (if the other LSM allows this or if stacker is used).

Based on original patch from Kurt Garloff <garloff@suse.de>.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 security/dummy.c     |  996 ---------------------------------------------------
 security/Makefile    |    9 
 security/commoncap.c |  977 +++++++++++++++++++++++++++++++++++++++++++++-----
 security/security.c  |   22 -
 4 files changed, 912 insertions(+), 1092 deletions(-)

Index: lsm-hooks-2.6/security/Makefile
===================================================================
--- lsm-hooks-2.6.orig/security/Makefile
+++ lsm-hooks-2.6/security/Makefile
@@ -5,15 +5,12 @@
 obj-$(CONFIG_KEYS)			+= keys/
 subdir-$(CONFIG_SECURITY_SELINUX)	+= selinux
 
-# if we don't select a security model, use the default capabilities
-ifneq ($(CONFIG_SECURITY),y)
 obj-y		+= commoncap.o
-endif
 
 # Object file lists
-obj-$(CONFIG_SECURITY)			+= security.o dummy.o
+obj-$(CONFIG_SECURITY)			+= security.o
 # Must precede capability.o in order to stack properly.
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
-obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
-obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
+obj-$(CONFIG_SECURITY_CAPABILITIES)	+= capability.o
+obj-$(CONFIG_SECURITY_ROOTPLUG)		+= root_plug.o
 obj-$(CONFIG_SECURITY_SECLVL)		+= seclvl.o
Index: lsm-hooks-2.6/security/commoncap.c
===================================================================
--- lsm-hooks-2.6.orig/security/commoncap.c
+++ lsm-hooks-2.6/security/commoncap.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/config.h>
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/security.h>
@@ -23,38 +22,7 @@
 #include <linux/ptrace.h>
 #include <linux/xattr.h>
 #include <linux/hugetlb.h>
-
-int cap_netlink_send(struct sock *sk, struct sk_buff *skb)
-{
-	NETLINK_CB(skb).eff_cap = current->cap_effective;
-	return 0;
-}
-
-EXPORT_SYMBOL(cap_netlink_send);
-
-int cap_netlink_recv(struct sk_buff *skb)
-{
-	if (!cap_raised(NETLINK_CB(skb).eff_cap, CAP_NET_ADMIN))
-		return -EPERM;
-	return 0;
-}
-
-EXPORT_SYMBOL(cap_netlink_recv);
-
-int cap_capable (struct task_struct *tsk, int cap)
-{
-	/* Derived from include/linux/sched.h:capable. */
-	if (cap_raised(tsk->cap_effective, cap))
-		return 0;
-	return -EPERM;
-}
-
-int cap_settime(struct timespec *ts, struct timezone *tz)
-{
-	if (!capable(CAP_SYS_TIME))
-		return -EPERM;
-	return 0;
-}
+#include <linux/sysctl.h>
 
 int cap_ptrace (struct task_struct *parent, struct task_struct *child)
 {
@@ -64,6 +32,7 @@ int cap_ptrace (struct task_struct *pare
 		return -EPERM;
 	return 0;
 }
+EXPORT_SYMBOL(cap_ptrace);
 
 int cap_capget (struct task_struct *target, kernel_cap_t *effective,
 		kernel_cap_t *inheritable, kernel_cap_t *permitted)
@@ -74,6 +43,7 @@ int cap_capget (struct task_struct *targ
 	*permitted = cap_t (target->cap_permitted);
 	return 0;
 }
+EXPORT_SYMBOL(cap_capget);
 
 int cap_capset_check (struct task_struct *target, kernel_cap_t *effective,
 		      kernel_cap_t *inheritable, kernel_cap_t *permitted)
@@ -100,6 +70,7 @@ int cap_capset_check (struct task_struct
 
 	return 0;
 }
+EXPORT_SYMBOL(cap_capset_check);
 
 void cap_capset_set (struct task_struct *target, kernel_cap_t *effective,
 		     kernel_cap_t *inheritable, kernel_cap_t *permitted)
@@ -108,34 +79,42 @@ void cap_capset_set (struct task_struct 
 	target->cap_inheritable = *inheritable;
 	target->cap_permitted = *permitted;
 }
+EXPORT_SYMBOL(cap_capset_set);
 
-int cap_bprm_set_security (struct linux_binprm *bprm)
+int cap_capable (struct task_struct *tsk, int cap)
 {
-	/* Copied from fs/exec.c:prepare_binprm. */
-
-	/* We don't have VFS support for capabilities yet */
-	cap_clear (bprm->cap_inheritable);
-	cap_clear (bprm->cap_permitted);
-	cap_clear (bprm->cap_effective);
+	/* Derived from include/linux/sched.h:capable. */
+	if (cap_raised(tsk->cap_effective, cap))
+		return 0;
+	return -EPERM;
+}
+EXPORT_SYMBOL(cap_capable);
 
-	/*  To support inheritance of root-permissions and suid-root
-	 *  executables under compatibility mode, we raise all three
-	 *  capability sets for the file.
-	 *
-	 *  If only the real uid is 0, we only raise the inheritable
-	 *  and permitted sets of the executable file.
-	 */
+int cap_syslog (int type)
+{
+	if ((type != 3 && type != 10) && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	return 0;
+}
+EXPORT_SYMBOL(cap_syslog);
 
-	if (!issecure (SECURE_NOROOT)) {
-		if (bprm->e_uid == 0 || current->uid == 0) {
-			cap_set_full (bprm->cap_inheritable);
-			cap_set_full (bprm->cap_permitted);
-		}
-		if (bprm->e_uid == 0)
-			cap_set_full (bprm->cap_effective);
-	}
+int cap_settime(struct timespec *ts, struct timezone *tz)
+{
+	if (!capable(CAP_SYS_TIME))
+		return -EPERM;
 	return 0;
 }
+EXPORT_SYMBOL(cap_settime);
+
+int cap_vm_enough_memory(long pages)
+{
+	int cap_sys_admin = 0;
+
+	if (cap_capable(current, CAP_SYS_ADMIN) == 0)
+		cap_sys_admin = 1;
+	return __vm_enough_memory(pages, cap_sys_admin);
+}
+EXPORT_SYMBOL(cap_vm_enough_memory);
 
 void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
 {
@@ -179,6 +158,36 @@ void cap_bprm_apply_creds (struct linux_
 
 	current->keep_capabilities = 0;
 }
+EXPORT_SYMBOL(cap_bprm_apply_creds);
+
+int cap_bprm_set_security (struct linux_binprm *bprm)
+{
+	/* Copied from fs/exec.c:prepare_binprm. */
+
+	/* We don't have VFS support for capabilities yet */
+	cap_clear (bprm->cap_inheritable);
+	cap_clear (bprm->cap_permitted);
+	cap_clear (bprm->cap_effective);
+
+	/*  To support inheritance of root-permissions and suid-root
+	 *  executables under compatibility mode, we raise all three
+	 *  capability sets for the file.
+	 *
+	 *  If only the real uid is 0, we only raise the inheritable
+	 *  and permitted sets of the executable file.
+	 */
+
+	if (!issecure (SECURE_NOROOT)) {
+		if (bprm->e_uid == 0 || current->uid == 0) {
+			cap_set_full (bprm->cap_inheritable);
+			cap_set_full (bprm->cap_permitted);
+		}
+		if (bprm->e_uid == 0)
+			cap_set_full (bprm->cap_effective);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(cap_bprm_set_security);
 
 int cap_bprm_secureexec (struct linux_binprm *bprm)
 {
@@ -190,6 +199,7 @@ int cap_bprm_secureexec (struct linux_bi
 	return (current->euid != current->uid ||
 		current->egid != current->gid);
 }
+EXPORT_SYMBOL(cap_bprm_secureexec);
 
 int cap_inode_setxattr(struct dentry *dentry, char *name, void *value,
 		       size_t size, int flags)
@@ -200,6 +210,7 @@ int cap_inode_setxattr(struct dentry *de
 		return -EPERM;
 	return 0;
 }
+EXPORT_SYMBOL(cap_inode_setxattr);
 
 int cap_inode_removexattr(struct dentry *dentry, char *name)
 {
@@ -209,6 +220,7 @@ int cap_inode_removexattr(struct dentry 
 		return -EPERM;
 	return 0;
 }
+EXPORT_SYMBOL(cap_inode_removexattr);
 
 /* moved from kernel/sys.c. */
 /* 
@@ -299,6 +311,7 @@ int cap_task_post_setuid (uid_t old_ruid
 
 	return 0;
 }
+EXPORT_SYMBOL(cap_task_post_setuid);
 
 void cap_task_reparent_to_init (struct task_struct *p)
 {
@@ -308,38 +321,844 @@ void cap_task_reparent_to_init (struct t
 	p->keep_capabilities = 0;
 	return;
 }
+EXPORT_SYMBOL(cap_task_reparent_to_init);
 
-int cap_syslog (int type)
+int cap_netlink_send(struct sock *sk, struct sk_buff *skb)
 {
-	if ((type != 3 && type != 10) && !capable(CAP_SYS_ADMIN))
+	NETLINK_CB(skb).eff_cap = current->cap_effective;
+	return 0;
+}
+EXPORT_SYMBOL(cap_netlink_send);
+
+int cap_netlink_recv(struct sk_buff *skb)
+{
+	if (!cap_raised(NETLINK_CB(skb).eff_cap, CAP_NET_ADMIN))
 		return -EPERM;
 	return 0;
 }
+EXPORT_SYMBOL(cap_netlink_recv);
 
-int cap_vm_enough_memory(long pages)
+#ifdef CONFIG_SECURITY
+
+static int cap_acct (struct file *file)
 {
-	int cap_sys_admin = 0;
+	return 0;
+}
 
-	if (cap_capable(current, CAP_SYS_ADMIN) == 0)
-		cap_sys_admin = 1;
-	return __vm_enough_memory(pages, cap_sys_admin);
+static int cap_sysctl (ctl_table * table, int op)
+{
+	return 0;
 }
 
-EXPORT_SYMBOL(cap_capable);
-EXPORT_SYMBOL(cap_settime);
-EXPORT_SYMBOL(cap_ptrace);
-EXPORT_SYMBOL(cap_capget);
-EXPORT_SYMBOL(cap_capset_check);
-EXPORT_SYMBOL(cap_capset_set);
-EXPORT_SYMBOL(cap_bprm_set_security);
-EXPORT_SYMBOL(cap_bprm_apply_creds);
-EXPORT_SYMBOL(cap_bprm_secureexec);
-EXPORT_SYMBOL(cap_inode_setxattr);
-EXPORT_SYMBOL(cap_inode_removexattr);
-EXPORT_SYMBOL(cap_task_post_setuid);
-EXPORT_SYMBOL(cap_task_reparent_to_init);
-EXPORT_SYMBOL(cap_syslog);
-EXPORT_SYMBOL(cap_vm_enough_memory);
+static int cap_quotactl (int cmds, int type, int id, struct super_block *sb)
+{
+	return 0;
+}
+
+static int cap_quota_on (struct dentry *dentry)
+{
+	return 0;
+}
+
+static int cap_bprm_alloc_security (struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static void cap_bprm_free_security (struct linux_binprm *bprm)
+{
+	return;
+}
+
+static void cap_bprm_post_apply_creds (struct linux_binprm *bprm)
+{
+	return;
+}
+
+static int cap_bprm_check_security (struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static int cap_sb_alloc_security (struct super_block *sb)
+{
+	return 0;
+}
+
+static void cap_sb_free_security (struct super_block *sb)
+{
+	return;
+}
+
+static int cap_sb_copy_data (struct file_system_type *type,
+			       void *orig, void *copy)
+{
+	return 0;
+}
+
+static int cap_sb_kern_mount (struct super_block *sb, void *data)
+{
+	return 0;
+}
+
+static int cap_sb_statfs (struct super_block *sb)
+{
+	return 0;
+}
+
+static int cap_sb_mount (char *dev_name, struct nameidata *nd, char *type,
+			   unsigned long flags, void *data)
+{
+	return 0;
+}
+
+static int cap_sb_check_sb (struct vfsmount *mnt, struct nameidata *nd)
+{
+	return 0;
+}
+
+static int cap_sb_umount (struct vfsmount *mnt, int flags)
+{
+	return 0;
+}
+
+static void cap_sb_umount_close (struct vfsmount *mnt)
+{
+	return;
+}
+
+static void cap_sb_umount_busy (struct vfsmount *mnt)
+{
+	return;
+}
+
+static void cap_sb_post_remount (struct vfsmount *mnt, unsigned long flags,
+				   void *data)
+{
+	return;
+}
+
+
+static void cap_sb_post_mountroot (void)
+{
+	return;
+}
+
+static void cap_sb_post_addmount (struct vfsmount *mnt, struct nameidata *nd)
+{
+	return;
+}
+
+static int cap_sb_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
+{
+	return 0;
+}
+
+static void cap_sb_post_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
+{
+	return;
+}
+
+static int cap_inode_alloc_security (struct inode *inode)
+{
+	return 0;
+}
+
+static void cap_inode_free_security (struct inode *inode)
+{
+	return;
+}
+
+static int cap_inode_create (struct inode *inode, struct dentry *dentry,
+			       int mask)
+{
+	return 0;
+}
+
+static void cap_inode_post_create (struct inode *inode, struct dentry *dentry,
+				     int mask)
+{
+	return;
+}
+
+static int cap_inode_link (struct dentry *old_dentry, struct inode *inode,
+			     struct dentry *new_dentry)
+{
+	return 0;
+}
+
+static void cap_inode_post_link (struct dentry *old_dentry,
+				   struct inode *inode,
+				   struct dentry *new_dentry)
+{
+	return;
+}
+
+static int cap_inode_unlink (struct inode *inode, struct dentry *dentry)
+{
+	return 0;
+}
+
+static int cap_inode_symlink (struct inode *inode, struct dentry *dentry,
+				const char *name)
+{
+	return 0;
+}
+
+static void cap_inode_post_symlink (struct inode *inode,
+				      struct dentry *dentry, const char *name)
+{
+	return;
+}
+
+static int cap_inode_mkdir (struct inode *inode, struct dentry *dentry,
+			      int mask)
+{
+	return 0;
+}
+
+static void cap_inode_post_mkdir (struct inode *inode, struct dentry *dentry,
+				    int mask)
+{
+	return;
+}
+
+static int cap_inode_rmdir (struct inode *inode, struct dentry *dentry)
+{
+	return 0;
+}
+
+static int cap_inode_mknod (struct inode *inode, struct dentry *dentry,
+			      int mode, dev_t dev)
+{
+	return 0;
+}
+
+static void cap_inode_post_mknod (struct inode *inode, struct dentry *dentry,
+				    int mode, dev_t dev)
+{
+	return;
+}
+
+static int cap_inode_rename (struct inode *old_inode,
+			       struct dentry *old_dentry,
+			       struct inode *new_inode,
+			       struct dentry *new_dentry)
+{
+	return 0;
+}
+
+static void cap_inode_post_rename (struct inode *old_inode,
+				     struct dentry *old_dentry,
+				     struct inode *new_inode,
+				     struct dentry *new_dentry)
+{
+	return;
+}
+
+static int cap_inode_readlink (struct dentry *dentry)
+{
+	return 0;
+}
+
+static int cap_inode_follow_link (struct dentry *dentry,
+				    struct nameidata *nameidata)
+{
+	return 0;
+}
+
+static int cap_inode_permission (struct inode *inode, int mask, struct nameidata *nd)
+{
+	return 0;
+}
+
+static int cap_inode_setattr (struct dentry *dentry, struct iattr *iattr)
+{
+	return 0;
+}
+
+static int cap_inode_getattr (struct vfsmount *mnt, struct dentry *dentry)
+{
+	return 0;
+}
+
+static void cap_inode_delete (struct inode *ino)
+{
+	return;
+}
+
+static void cap_inode_post_setxattr (struct dentry *dentry, char *name, void *value,
+				       size_t size, int flags)
+{
+	return;
+}
+
+static int cap_inode_getxattr (struct dentry *dentry, char *name)
+{
+	return 0;
+}
+
+static int cap_inode_listxattr (struct dentry *dentry)
+{
+	return 0;
+}
+
+static int cap_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+
+static int cap_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static int cap_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
+{
+	return 0;
+}
+
+static int cap_file_permission (struct file *file, int mask)
+{
+	return 0;
+}
+
+static int cap_file_alloc_security (struct file *file)
+{
+	return 0;
+}
+
+static void cap_file_free_security (struct file *file)
+{
+	return;
+}
+
+static int cap_file_ioctl (struct file *file, unsigned int command,
+			     unsigned long arg)
+{
+	return 0;
+}
+
+static int cap_file_mmap (struct file *file, unsigned long reqprot,
+			    unsigned long prot,
+			    unsigned long flags)
+{
+	return 0;
+}
+
+static int cap_file_mprotect (struct vm_area_struct *vma,
+				unsigned long reqprot,
+				unsigned long prot)
+{
+	return 0;
+}
+
+static int cap_file_lock (struct file *file, unsigned int cmd)
+{
+	return 0;
+}
+
+static int cap_file_fcntl (struct file *file, unsigned int cmd,
+			     unsigned long arg)
+{
+	return 0;
+}
+
+static int cap_file_set_fowner (struct file *file)
+{
+	return 0;
+}
+
+static int cap_file_send_sigiotask (struct task_struct *tsk,
+				      struct fown_struct *fown, int sig)
+{
+	return 0;
+}
+
+static int cap_file_receive (struct file *file)
+{
+	return 0;
+}
+
+static int cap_task_create (unsigned long clone_flags)
+{
+	return 0;
+}
+
+static int cap_task_alloc_security (struct task_struct *p)
+{
+	return 0;
+}
+
+static void cap_task_free_security (struct task_struct *p)
+{
+	return;
+}
+
+static int cap_task_setuid (uid_t id0, uid_t id1, uid_t id2, int flags)
+{
+	return 0;
+}
+
+static int cap_task_setgid (gid_t id0, gid_t id1, gid_t id2, int flags)
+{
+	return 0;
+}
+
+static int cap_task_setpgid (struct task_struct *p, pid_t pgid)
+{
+	return 0;
+}
+
+static int cap_task_getpgid (struct task_struct *p)
+{
+	return 0;
+}
+
+static int cap_task_getsid (struct task_struct *p)
+{
+	return 0;
+}
+
+static int cap_task_setgroups (struct group_info *group_info)
+{
+	return 0;
+}
+
+static int cap_task_setnice (struct task_struct *p, int nice)
+{
+	return 0;
+}
+
+static int cap_task_setrlimit (unsigned int resource, struct rlimit *new_rlim)
+{
+	return 0;
+}
+
+static int cap_task_setscheduler (struct task_struct *p, int policy,
+				    struct sched_param *lp)
+{
+	return 0;
+}
+
+static int cap_task_getscheduler (struct task_struct *p)
+{
+	return 0;
+}
+
+static int cap_task_wait (struct task_struct *p)
+{
+	return 0;
+}
+
+static int cap_task_kill (struct task_struct *p, struct siginfo *info,
+			    int sig)
+{
+	return 0;
+}
+
+static int cap_task_prctl (int option, unsigned long arg2, unsigned long arg3,
+			     unsigned long arg4, unsigned long arg5)
+{
+	return 0;
+}
+
+static void cap_task_to_inode(struct task_struct *p, struct inode *inode)
+{
+	return;
+}
+
+static int cap_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
+{
+	return 0;
+}
+
+static int cap_msg_msg_alloc_security (struct msg_msg *msg)
+{
+	return 0;
+}
+
+static void cap_msg_msg_free_security (struct msg_msg *msg)
+{
+	return;
+}
+
+static int cap_msg_queue_alloc_security (struct msg_queue *msq)
+{
+	return 0;
+}
+
+static void cap_msg_queue_free_security (struct msg_queue *msq)
+{
+	return;
+}
+
+static int cap_msg_queue_associate (struct msg_queue *msq, 
+				      int msqflg)
+{
+	return 0;
+}
+
+static int cap_msg_queue_msgctl (struct msg_queue *msq, int cmd)
+{
+	return 0;
+}
+
+static int cap_msg_queue_msgsnd (struct msg_queue *msq, struct msg_msg *msg,
+				   int msgflg)
+{
+	return 0;
+}
+
+static int cap_msg_queue_msgrcv (struct msg_queue *msq, struct msg_msg *msg,
+				   struct task_struct *target, long type,
+				   int mode)
+{
+	return 0;
+}
+
+static int cap_shm_alloc_security (struct shmid_kernel *shp)
+{
+	return 0;
+}
+
+static void cap_shm_free_security (struct shmid_kernel *shp)
+{
+	return;
+}
+
+static int cap_shm_associate (struct shmid_kernel *shp, int shmflg)
+{
+	return 0;
+}
+
+static int cap_shm_shmctl (struct shmid_kernel *shp, int cmd)
+{
+	return 0;
+}
+
+static int cap_shm_shmat (struct shmid_kernel *shp, char __user *shmaddr,
+			    int shmflg)
+{
+	return 0;
+}
+
+static int cap_sem_alloc_security (struct sem_array *sma)
+{
+	return 0;
+}
+
+static void cap_sem_free_security (struct sem_array *sma)
+{
+	return;
+}
+
+static int cap_sem_associate (struct sem_array *sma, int semflg)
+{
+	return 0;
+}
+
+static int cap_sem_semctl (struct sem_array *sma, int cmd)
+{
+	return 0;
+}
+
+static int cap_sem_semop (struct sem_array *sma, 
+			    struct sembuf *sops, unsigned nsops, int alter)
+{
+	return 0;
+}
+
+#ifdef CONFIG_SECURITY_NETWORK
+static int cap_unix_stream_connect (struct socket *sock,
+				      struct socket *other,
+				      struct sock *newsk)
+{
+	return 0;
+}
+
+static int cap_unix_may_send (struct socket *sock,
+				struct socket *other)
+{
+	return 0;
+}
+
+static int cap_socket_create (int family, int type,
+				int protocol, int kern)
+{
+	return 0;
+}
+
+static void cap_socket_post_create (struct socket *sock, int family, int type,
+				      int protocol, int kern)
+{
+	return;
+}
+
+static int cap_socket_bind (struct socket *sock, struct sockaddr *address,
+			      int addrlen)
+{
+	return 0;
+}
+
+static int cap_socket_connect (struct socket *sock, struct sockaddr *address,
+				 int addrlen)
+{
+	return 0;
+}
+
+static int cap_socket_listen (struct socket *sock, int backlog)
+{
+	return 0;
+}
+
+static int cap_socket_accept (struct socket *sock, struct socket *newsock)
+{
+	return 0;
+}
+
+static void cap_socket_post_accept (struct socket *sock, 
+				      struct socket *newsock)
+{
+	return;
+}
+
+static int cap_socket_sendmsg (struct socket *sock, struct msghdr *msg,
+				 int size)
+{
+	return 0;
+}
+
+static int cap_socket_recvmsg (struct socket *sock, struct msghdr *msg,
+				 int size, int flags)
+{
+	return 0;
+}
+
+static int cap_socket_getsockname (struct socket *sock)
+{
+	return 0;
+}
+
+static int cap_socket_getpeername (struct socket *sock)
+{
+	return 0;
+}
+
+static int cap_socket_setsockopt (struct socket *sock, int level, int optname)
+{
+	return 0;
+}
+
+static int cap_socket_getsockopt (struct socket *sock, int level, int optname)
+{
+	return 0;
+}
+
+static int cap_socket_shutdown (struct socket *sock, int how)
+{
+	return 0;
+}
+
+static int cap_socket_sock_rcv_skb (struct sock *sk, struct sk_buff *skb)
+{
+	return 0;
+}
+
+static int cap_socket_getpeersec(struct socket *sock, char __user *optval,
+				   int __user *optlen, unsigned len)
+{
+	return -ENOPROTOOPT;
+}
+
+static inline int cap_sk_alloc_security (struct sock *sk, int family, int priority)
+{
+	return 0;
+}
+
+static inline void cap_sk_free_security (struct sock *sk)
+{
+}
+#endif	/* CONFIG_SECURITY_NETWORK */
+
+static int cap_register_security (const char *name, struct security_operations *ops)
+{
+	return -EINVAL;
+}
+
+static int cap_unregister_security (const char *name, struct security_operations *ops)
+{
+	return -EINVAL;
+}
+
+static void cap_d_instantiate (struct dentry *dentry, struct inode *inode)
+{
+	return;
+}
+
+static int cap_getprocattr(struct task_struct *p, char *name, void *value, size_t size)
+{
+	return -EINVAL;
+}
+
+static int cap_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
+{
+	return -EINVAL;
+}
+
+#define set_to_default_if_null(ops, function)				\
+	do {								\
+		if (!ops->function) {					\
+			ops->function = cap_##function;		\
+			pr_debug("Had to override with " #function	\
+				 " security op with the default one.\n");\
+			}						\
+	} while (0)
+
+void security_fixup_ops (struct security_operations *ops)
+{
+	set_to_default_if_null(ops, ptrace);
+	set_to_default_if_null(ops, capget);
+	set_to_default_if_null(ops, capset_check);
+	set_to_default_if_null(ops, capset_set);
+	set_to_default_if_null(ops, acct);
+	set_to_default_if_null(ops, capable);
+	set_to_default_if_null(ops, quotactl);
+	set_to_default_if_null(ops, quota_on);
+	set_to_default_if_null(ops, sysctl);
+	set_to_default_if_null(ops, syslog);
+	set_to_default_if_null(ops, settime);
+	set_to_default_if_null(ops, vm_enough_memory);
+	set_to_default_if_null(ops, bprm_alloc_security);
+	set_to_default_if_null(ops, bprm_free_security);
+	set_to_default_if_null(ops, bprm_apply_creds);
+	set_to_default_if_null(ops, bprm_post_apply_creds);
+	set_to_default_if_null(ops, bprm_set_security);
+	set_to_default_if_null(ops, bprm_check_security);
+	set_to_default_if_null(ops, bprm_secureexec);
+	set_to_default_if_null(ops, sb_alloc_security);
+	set_to_default_if_null(ops, sb_free_security);
+	set_to_default_if_null(ops, sb_copy_data);
+	set_to_default_if_null(ops, sb_kern_mount);
+	set_to_default_if_null(ops, sb_statfs);
+	set_to_default_if_null(ops, sb_mount);
+	set_to_default_if_null(ops, sb_check_sb);
+	set_to_default_if_null(ops, sb_umount);
+	set_to_default_if_null(ops, sb_umount_close);
+	set_to_default_if_null(ops, sb_umount_busy);
+	set_to_default_if_null(ops, sb_post_remount);
+	set_to_default_if_null(ops, sb_post_mountroot);
+	set_to_default_if_null(ops, sb_post_addmount);
+	set_to_default_if_null(ops, sb_pivotroot);
+	set_to_default_if_null(ops, sb_post_pivotroot);
+	set_to_default_if_null(ops, inode_alloc_security);
+	set_to_default_if_null(ops, inode_free_security);
+	set_to_default_if_null(ops, inode_create);
+	set_to_default_if_null(ops, inode_post_create);
+	set_to_default_if_null(ops, inode_link);
+	set_to_default_if_null(ops, inode_post_link);
+	set_to_default_if_null(ops, inode_unlink);
+	set_to_default_if_null(ops, inode_symlink);
+	set_to_default_if_null(ops, inode_post_symlink);
+	set_to_default_if_null(ops, inode_mkdir);
+	set_to_default_if_null(ops, inode_post_mkdir);
+	set_to_default_if_null(ops, inode_rmdir);
+	set_to_default_if_null(ops, inode_mknod);
+	set_to_default_if_null(ops, inode_post_mknod);
+	set_to_default_if_null(ops, inode_rename);
+	set_to_default_if_null(ops, inode_post_rename);
+	set_to_default_if_null(ops, inode_readlink);
+	set_to_default_if_null(ops, inode_follow_link);
+	set_to_default_if_null(ops, inode_permission);
+	set_to_default_if_null(ops, inode_setattr);
+	set_to_default_if_null(ops, inode_getattr);
+	set_to_default_if_null(ops, inode_delete);
+	set_to_default_if_null(ops, inode_setxattr);
+	set_to_default_if_null(ops, inode_post_setxattr);
+	set_to_default_if_null(ops, inode_getxattr);
+	set_to_default_if_null(ops, inode_listxattr);
+	set_to_default_if_null(ops, inode_removexattr);
+	set_to_default_if_null(ops, inode_getsecurity);
+	set_to_default_if_null(ops, inode_setsecurity);
+	set_to_default_if_null(ops, inode_listsecurity);
+	set_to_default_if_null(ops, file_permission);
+	set_to_default_if_null(ops, file_alloc_security);
+	set_to_default_if_null(ops, file_free_security);
+	set_to_default_if_null(ops, file_ioctl);
+	set_to_default_if_null(ops, file_mmap);
+	set_to_default_if_null(ops, file_mprotect);
+	set_to_default_if_null(ops, file_lock);
+	set_to_default_if_null(ops, file_fcntl);
+	set_to_default_if_null(ops, file_set_fowner);
+	set_to_default_if_null(ops, file_send_sigiotask);
+	set_to_default_if_null(ops, file_receive);
+	set_to_default_if_null(ops, task_create);
+	set_to_default_if_null(ops, task_alloc_security);
+	set_to_default_if_null(ops, task_free_security);
+	set_to_default_if_null(ops, task_setuid);
+	set_to_default_if_null(ops, task_post_setuid);
+	set_to_default_if_null(ops, task_setgid);
+	set_to_default_if_null(ops, task_setpgid);
+	set_to_default_if_null(ops, task_getpgid);
+	set_to_default_if_null(ops, task_getsid);
+	set_to_default_if_null(ops, task_setgroups);
+	set_to_default_if_null(ops, task_setnice);
+	set_to_default_if_null(ops, task_setrlimit);
+	set_to_default_if_null(ops, task_setscheduler);
+	set_to_default_if_null(ops, task_getscheduler);
+	set_to_default_if_null(ops, task_wait);
+	set_to_default_if_null(ops, task_kill);
+	set_to_default_if_null(ops, task_prctl);
+	set_to_default_if_null(ops, task_reparent_to_init);
+ 	set_to_default_if_null(ops, task_to_inode);
+	set_to_default_if_null(ops, ipc_permission);
+	set_to_default_if_null(ops, msg_msg_alloc_security);
+	set_to_default_if_null(ops, msg_msg_free_security);
+	set_to_default_if_null(ops, msg_queue_alloc_security);
+	set_to_default_if_null(ops, msg_queue_free_security);
+	set_to_default_if_null(ops, msg_queue_associate);
+	set_to_default_if_null(ops, msg_queue_msgctl);
+	set_to_default_if_null(ops, msg_queue_msgsnd);
+	set_to_default_if_null(ops, msg_queue_msgrcv);
+	set_to_default_if_null(ops, shm_alloc_security);
+	set_to_default_if_null(ops, shm_free_security);
+	set_to_default_if_null(ops, shm_associate);
+	set_to_default_if_null(ops, shm_shmctl);
+	set_to_default_if_null(ops, shm_shmat);
+	set_to_default_if_null(ops, sem_alloc_security);
+	set_to_default_if_null(ops, sem_free_security);
+	set_to_default_if_null(ops, sem_associate);
+	set_to_default_if_null(ops, sem_semctl);
+	set_to_default_if_null(ops, sem_semop);
+	set_to_default_if_null(ops, netlink_send);
+	set_to_default_if_null(ops, netlink_recv);
+	set_to_default_if_null(ops, register_security);
+	set_to_default_if_null(ops, unregister_security);
+	set_to_default_if_null(ops, d_instantiate);
+ 	set_to_default_if_null(ops, getprocattr);
+ 	set_to_default_if_null(ops, setprocattr);
+#ifdef CONFIG_SECURITY_NETWORK
+	set_to_default_if_null(ops, unix_stream_connect);
+	set_to_default_if_null(ops, unix_may_send);
+	set_to_default_if_null(ops, socket_create);
+	set_to_default_if_null(ops, socket_post_create);
+	set_to_default_if_null(ops, socket_bind);
+	set_to_default_if_null(ops, socket_connect);
+	set_to_default_if_null(ops, socket_listen);
+	set_to_default_if_null(ops, socket_accept);
+	set_to_default_if_null(ops, socket_post_accept);
+	set_to_default_if_null(ops, socket_sendmsg);
+	set_to_default_if_null(ops, socket_recvmsg);
+	set_to_default_if_null(ops, socket_getsockname);
+	set_to_default_if_null(ops, socket_getpeername);
+	set_to_default_if_null(ops, socket_setsockopt);
+	set_to_default_if_null(ops, socket_getsockopt);
+	set_to_default_if_null(ops, socket_shutdown);
+	set_to_default_if_null(ops, socket_sock_rcv_skb);
+	set_to_default_if_null(ops, socket_getpeersec);
+	set_to_default_if_null(ops, sk_alloc_security);
+	set_to_default_if_null(ops, sk_free_security);
+#endif	/* CONFIG_SECURITY_NETWORK */
+}
 
-MODULE_DESCRIPTION("Standard Linux Common Capabilities Security Module");
-MODULE_LICENSE("GPL");
+#endif	/* CONFIG_SECURITY */
Index: lsm-hooks-2.6/security/dummy.c
===================================================================
--- lsm-hooks-2.6.orig/security/dummy.c
+++ /dev/null
@@ -1,996 +0,0 @@
-/*
- * Stub functions for the default security function pointers in case no
- * security model is loaded.
- *
- * Copyright (C) 2001 WireX Communications, Inc <chris@wirex.com>
- * Copyright (C) 2001-2002  Greg Kroah-Hartman <greg@kroah.com>
- * Copyright (C) 2001 Networks Associates Technology, Inc <ssmalley@nai.com>
- *
- *	This program is free software; you can redistribute it and/or modify
- *	it under the terms of the GNU General Public License as published by
- *	the Free Software Foundation; either version 2 of the License, or
- *	(at your option) any later version.
- */
-
-#undef DEBUG
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/mman.h>
-#include <linux/pagemap.h>
-#include <linux/swap.h>
-#include <linux/security.h>
-#include <linux/skbuff.h>
-#include <linux/netlink.h>
-#include <net/sock.h>
-#include <linux/xattr.h>
-#include <linux/hugetlb.h>
-#include <linux/ptrace.h>
-#include <linux/file.h>
-
-static int dummy_ptrace (struct task_struct *parent, struct task_struct *child)
-{
-	return 0;
-}
-
-static int dummy_capget (struct task_struct *target, kernel_cap_t * effective,
-			 kernel_cap_t * inheritable, kernel_cap_t * permitted)
-{
-	*effective = *inheritable = *permitted = 0;
-	if (!issecure(SECURE_NOROOT)) {
-		if (target->euid == 0) {
-			*permitted |= (~0 & ~CAP_FS_MASK);
-			*effective |= (~0 & ~CAP_TO_MASK(CAP_SETPCAP) & ~CAP_FS_MASK);
-		}
-		if (target->fsuid == 0) {
-			*permitted |= CAP_FS_MASK;
-			*effective |= CAP_FS_MASK;
-		}
-	}
-	return 0;
-}
-
-static int dummy_capset_check (struct task_struct *target,
-			       kernel_cap_t * effective,
-			       kernel_cap_t * inheritable,
-			       kernel_cap_t * permitted)
-{
-	return -EPERM;
-}
-
-static void dummy_capset_set (struct task_struct *target,
-			      kernel_cap_t * effective,
-			      kernel_cap_t * inheritable,
-			      kernel_cap_t * permitted)
-{
-	return;
-}
-
-static int dummy_acct (struct file *file)
-{
-	return 0;
-}
-
-static int dummy_capable (struct task_struct *tsk, int cap)
-{
-	if (cap_raised (tsk->cap_effective, cap))
-		return 0;
-	return -EPERM;
-}
-
-static int dummy_sysctl (ctl_table * table, int op)
-{
-	return 0;
-}
-
-static int dummy_quotactl (int cmds, int type, int id, struct super_block *sb)
-{
-	return 0;
-}
-
-static int dummy_quota_on (struct dentry *dentry)
-{
-	return 0;
-}
-
-static int dummy_syslog (int type)
-{
-	if ((type != 3 && type != 10) && current->euid)
-		return -EPERM;
-	return 0;
-}
-
-static int dummy_settime(struct timespec *ts, struct timezone *tz)
-{
-	if (!capable(CAP_SYS_TIME))
-		return -EPERM;
-	return 0;
-}
-
-static int dummy_vm_enough_memory(long pages)
-{
-	int cap_sys_admin = 0;
-
-	if (dummy_capable(current, CAP_SYS_ADMIN) == 0)
-		cap_sys_admin = 1;
-	return __vm_enough_memory(pages, cap_sys_admin);
-}
-
-static int dummy_bprm_alloc_security (struct linux_binprm *bprm)
-{
-	return 0;
-}
-
-static void dummy_bprm_free_security (struct linux_binprm *bprm)
-{
-	return;
-}
-
-static void dummy_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
-{
-	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid) {
-		current->mm->dumpable = suid_dumpable;
-
-		if ((unsafe & ~LSM_UNSAFE_PTRACE_CAP) && !capable(CAP_SETUID)) {
-			bprm->e_uid = current->uid;
-			bprm->e_gid = current->gid;
-		}
-	}
-
-	current->suid = current->euid = current->fsuid = bprm->e_uid;
-	current->sgid = current->egid = current->fsgid = bprm->e_gid;
-
-	dummy_capget(current, &current->cap_effective, &current->cap_inheritable, &current->cap_permitted);
-}
-
-static void dummy_bprm_post_apply_creds (struct linux_binprm *bprm)
-{
-	return;
-}
-
-static int dummy_bprm_set_security (struct linux_binprm *bprm)
-{
-	return 0;
-}
-
-static int dummy_bprm_check_security (struct linux_binprm *bprm)
-{
-	return 0;
-}
-
-static int dummy_bprm_secureexec (struct linux_binprm *bprm)
-{
-	/* The new userland will simply use the value provided
-	   in the AT_SECURE field to decide whether secure mode
-	   is required.  Hence, this logic is required to preserve
-	   the legacy decision algorithm used by the old userland. */
-	return (current->euid != current->uid ||
-		current->egid != current->gid);
-}
-
-static int dummy_sb_alloc_security (struct super_block *sb)
-{
-	return 0;
-}
-
-static void dummy_sb_free_security (struct super_block *sb)
-{
-	return;
-}
-
-static int dummy_sb_copy_data (struct file_system_type *type,
-			       void *orig, void *copy)
-{
-	return 0;
-}
-
-static int dummy_sb_kern_mount (struct super_block *sb, void *data)
-{
-	return 0;
-}
-
-static int dummy_sb_statfs (struct super_block *sb)
-{
-	return 0;
-}
-
-static int dummy_sb_mount (char *dev_name, struct nameidata *nd, char *type,
-			   unsigned long flags, void *data)
-{
-	return 0;
-}
-
-static int dummy_sb_check_sb (struct vfsmount *mnt, struct nameidata *nd)
-{
-	return 0;
-}
-
-static int dummy_sb_umount (struct vfsmount *mnt, int flags)
-{
-	return 0;
-}
-
-static void dummy_sb_umount_close (struct vfsmount *mnt)
-{
-	return;
-}
-
-static void dummy_sb_umount_busy (struct vfsmount *mnt)
-{
-	return;
-}
-
-static void dummy_sb_post_remount (struct vfsmount *mnt, unsigned long flags,
-				   void *data)
-{
-	return;
-}
-
-
-static void dummy_sb_post_mountroot (void)
-{
-	return;
-}
-
-static void dummy_sb_post_addmount (struct vfsmount *mnt, struct nameidata *nd)
-{
-	return;
-}
-
-static int dummy_sb_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
-{
-	return 0;
-}
-
-static void dummy_sb_post_pivotroot (struct nameidata *old_nd, struct nameidata *new_nd)
-{
-	return;
-}
-
-static int dummy_inode_alloc_security (struct inode *inode)
-{
-	return 0;
-}
-
-static void dummy_inode_free_security (struct inode *inode)
-{
-	return;
-}
-
-static int dummy_inode_create (struct inode *inode, struct dentry *dentry,
-			       int mask)
-{
-	return 0;
-}
-
-static void dummy_inode_post_create (struct inode *inode, struct dentry *dentry,
-				     int mask)
-{
-	return;
-}
-
-static int dummy_inode_link (struct dentry *old_dentry, struct inode *inode,
-			     struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static void dummy_inode_post_link (struct dentry *old_dentry,
-				   struct inode *inode,
-				   struct dentry *new_dentry)
-{
-	return;
-}
-
-static int dummy_inode_unlink (struct inode *inode, struct dentry *dentry)
-{
-	return 0;
-}
-
-static int dummy_inode_symlink (struct inode *inode, struct dentry *dentry,
-				const char *name)
-{
-	return 0;
-}
-
-static void dummy_inode_post_symlink (struct inode *inode,
-				      struct dentry *dentry, const char *name)
-{
-	return;
-}
-
-static int dummy_inode_mkdir (struct inode *inode, struct dentry *dentry,
-			      int mask)
-{
-	return 0;
-}
-
-static void dummy_inode_post_mkdir (struct inode *inode, struct dentry *dentry,
-				    int mask)
-{
-	return;
-}
-
-static int dummy_inode_rmdir (struct inode *inode, struct dentry *dentry)
-{
-	return 0;
-}
-
-static int dummy_inode_mknod (struct inode *inode, struct dentry *dentry,
-			      int mode, dev_t dev)
-{
-	return 0;
-}
-
-static void dummy_inode_post_mknod (struct inode *inode, struct dentry *dentry,
-				    int mode, dev_t dev)
-{
-	return;
-}
-
-static int dummy_inode_rename (struct inode *old_inode,
-			       struct dentry *old_dentry,
-			       struct inode *new_inode,
-			       struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static void dummy_inode_post_rename (struct inode *old_inode,
-				     struct dentry *old_dentry,
-				     struct inode *new_inode,
-				     struct dentry *new_dentry)
-{
-	return;
-}
-
-static int dummy_inode_readlink (struct dentry *dentry)
-{
-	return 0;
-}
-
-static int dummy_inode_follow_link (struct dentry *dentry,
-				    struct nameidata *nameidata)
-{
-	return 0;
-}
-
-static int dummy_inode_permission (struct inode *inode, int mask, struct nameidata *nd)
-{
-	return 0;
-}
-
-static int dummy_inode_setattr (struct dentry *dentry, struct iattr *iattr)
-{
-	return 0;
-}
-
-static int dummy_inode_getattr (struct vfsmount *mnt, struct dentry *dentry)
-{
-	return 0;
-}
-
-static void dummy_inode_delete (struct inode *ino)
-{
-	return;
-}
-
-static int dummy_inode_setxattr (struct dentry *dentry, char *name, void *value,
-				size_t size, int flags)
-{
-	if (!strncmp(name, XATTR_SECURITY_PREFIX,
-		     sizeof(XATTR_SECURITY_PREFIX) - 1) &&
-	    !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	return 0;
-}
-
-static void dummy_inode_post_setxattr (struct dentry *dentry, char *name, void *value,
-				       size_t size, int flags)
-{
-}
-
-static int dummy_inode_getxattr (struct dentry *dentry, char *name)
-{
-	return 0;
-}
-
-static int dummy_inode_listxattr (struct dentry *dentry)
-{
-	return 0;
-}
-
-static int dummy_inode_removexattr (struct dentry *dentry, char *name)
-{
-	if (!strncmp(name, XATTR_SECURITY_PREFIX,
-		     sizeof(XATTR_SECURITY_PREFIX) - 1) &&
-	    !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	return 0;
-}
-
-static int dummy_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
-{
-	return -EOPNOTSUPP;
-}
-
-static int dummy_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
-{
-	return -EOPNOTSUPP;
-}
-
-static int dummy_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
-{
-	return 0;
-}
-
-static int dummy_file_permission (struct file *file, int mask)
-{
-	return 0;
-}
-
-static int dummy_file_alloc_security (struct file *file)
-{
-	return 0;
-}
-
-static void dummy_file_free_security (struct file *file)
-{
-	return;
-}
-
-static int dummy_file_ioctl (struct file *file, unsigned int command,
-			     unsigned long arg)
-{
-	return 0;
-}
-
-static int dummy_file_mmap (struct file *file, unsigned long reqprot,
-			    unsigned long prot,
-			    unsigned long flags)
-{
-	return 0;
-}
-
-static int dummy_file_mprotect (struct vm_area_struct *vma,
-				unsigned long reqprot,
-				unsigned long prot)
-{
-	return 0;
-}
-
-static int dummy_file_lock (struct file *file, unsigned int cmd)
-{
-	return 0;
-}
-
-static int dummy_file_fcntl (struct file *file, unsigned int cmd,
-			     unsigned long arg)
-{
-	return 0;
-}
-
-static int dummy_file_set_fowner (struct file *file)
-{
-	return 0;
-}
-
-static int dummy_file_send_sigiotask (struct task_struct *tsk,
-				      struct fown_struct *fown, int sig)
-{
-	return 0;
-}
-
-static int dummy_file_receive (struct file *file)
-{
-	return 0;
-}
-
-static int dummy_task_create (unsigned long clone_flags)
-{
-	return 0;
-}
-
-static int dummy_task_alloc_security (struct task_struct *p)
-{
-	return 0;
-}
-
-static void dummy_task_free_security (struct task_struct *p)
-{
-	return;
-}
-
-static int dummy_task_setuid (uid_t id0, uid_t id1, uid_t id2, int flags)
-{
-	return 0;
-}
-
-static int dummy_task_post_setuid (uid_t id0, uid_t id1, uid_t id2, int flags)
-{
-	dummy_capget(current, &current->cap_effective, &current->cap_inheritable, &current->cap_permitted);
-	return 0;
-}
-
-static int dummy_task_setgid (gid_t id0, gid_t id1, gid_t id2, int flags)
-{
-	return 0;
-}
-
-static int dummy_task_setpgid (struct task_struct *p, pid_t pgid)
-{
-	return 0;
-}
-
-static int dummy_task_getpgid (struct task_struct *p)
-{
-	return 0;
-}
-
-static int dummy_task_getsid (struct task_struct *p)
-{
-	return 0;
-}
-
-static int dummy_task_setgroups (struct group_info *group_info)
-{
-	return 0;
-}
-
-static int dummy_task_setnice (struct task_struct *p, int nice)
-{
-	return 0;
-}
-
-static int dummy_task_setrlimit (unsigned int resource, struct rlimit *new_rlim)
-{
-	return 0;
-}
-
-static int dummy_task_setscheduler (struct task_struct *p, int policy,
-				    struct sched_param *lp)
-{
-	return 0;
-}
-
-static int dummy_task_getscheduler (struct task_struct *p)
-{
-	return 0;
-}
-
-static int dummy_task_wait (struct task_struct *p)
-{
-	return 0;
-}
-
-static int dummy_task_kill (struct task_struct *p, struct siginfo *info,
-			    int sig)
-{
-	return 0;
-}
-
-static int dummy_task_prctl (int option, unsigned long arg2, unsigned long arg3,
-			     unsigned long arg4, unsigned long arg5)
-{
-	return 0;
-}
-
-static void dummy_task_reparent_to_init (struct task_struct *p)
-{
-	p->euid = p->fsuid = 0;
-	return;
-}
-
-static void dummy_task_to_inode(struct task_struct *p, struct inode *inode)
-{ }
-
-static int dummy_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
-{
-	return 0;
-}
-
-static int dummy_msg_msg_alloc_security (struct msg_msg *msg)
-{
-	return 0;
-}
-
-static void dummy_msg_msg_free_security (struct msg_msg *msg)
-{
-	return;
-}
-
-static int dummy_msg_queue_alloc_security (struct msg_queue *msq)
-{
-	return 0;
-}
-
-static void dummy_msg_queue_free_security (struct msg_queue *msq)
-{
-	return;
-}
-
-static int dummy_msg_queue_associate (struct msg_queue *msq, 
-				      int msqflg)
-{
-	return 0;
-}
-
-static int dummy_msg_queue_msgctl (struct msg_queue *msq, int cmd)
-{
-	return 0;
-}
-
-static int dummy_msg_queue_msgsnd (struct msg_queue *msq, struct msg_msg *msg,
-				   int msgflg)
-{
-	return 0;
-}
-
-static int dummy_msg_queue_msgrcv (struct msg_queue *msq, struct msg_msg *msg,
-				   struct task_struct *target, long type,
-				   int mode)
-{
-	return 0;
-}
-
-static int dummy_shm_alloc_security (struct shmid_kernel *shp)
-{
-	return 0;
-}
-
-static void dummy_shm_free_security (struct shmid_kernel *shp)
-{
-	return;
-}
-
-static int dummy_shm_associate (struct shmid_kernel *shp, int shmflg)
-{
-	return 0;
-}
-
-static int dummy_shm_shmctl (struct shmid_kernel *shp, int cmd)
-{
-	return 0;
-}
-
-static int dummy_shm_shmat (struct shmid_kernel *shp, char __user *shmaddr,
-			    int shmflg)
-{
-	return 0;
-}
-
-static int dummy_sem_alloc_security (struct sem_array *sma)
-{
-	return 0;
-}
-
-static void dummy_sem_free_security (struct sem_array *sma)
-{
-	return;
-}
-
-static int dummy_sem_associate (struct sem_array *sma, int semflg)
-{
-	return 0;
-}
-
-static int dummy_sem_semctl (struct sem_array *sma, int cmd)
-{
-	return 0;
-}
-
-static int dummy_sem_semop (struct sem_array *sma, 
-			    struct sembuf *sops, unsigned nsops, int alter)
-{
-	return 0;
-}
-
-static int dummy_netlink_send (struct sock *sk, struct sk_buff *skb)
-{
-	NETLINK_CB(skb).eff_cap = current->cap_effective;
-	return 0;
-}
-
-static int dummy_netlink_recv (struct sk_buff *skb)
-{
-	if (!cap_raised (NETLINK_CB (skb).eff_cap, CAP_NET_ADMIN))
-		return -EPERM;
-	return 0;
-}
-
-#ifdef CONFIG_SECURITY_NETWORK
-static int dummy_unix_stream_connect (struct socket *sock,
-				      struct socket *other,
-				      struct sock *newsk)
-{
-	return 0;
-}
-
-static int dummy_unix_may_send (struct socket *sock,
-				struct socket *other)
-{
-	return 0;
-}
-
-static int dummy_socket_create (int family, int type,
-				int protocol, int kern)
-{
-	return 0;
-}
-
-static void dummy_socket_post_create (struct socket *sock, int family, int type,
-				      int protocol, int kern)
-{
-	return;
-}
-
-static int dummy_socket_bind (struct socket *sock, struct sockaddr *address,
-			      int addrlen)
-{
-	return 0;
-}
-
-static int dummy_socket_connect (struct socket *sock, struct sockaddr *address,
-				 int addrlen)
-{
-	return 0;
-}
-
-static int dummy_socket_listen (struct socket *sock, int backlog)
-{
-	return 0;
-}
-
-static int dummy_socket_accept (struct socket *sock, struct socket *newsock)
-{
-	return 0;
-}
-
-static void dummy_socket_post_accept (struct socket *sock, 
-				      struct socket *newsock)
-{
-	return;
-}
-
-static int dummy_socket_sendmsg (struct socket *sock, struct msghdr *msg,
-				 int size)
-{
-	return 0;
-}
-
-static int dummy_socket_recvmsg (struct socket *sock, struct msghdr *msg,
-				 int size, int flags)
-{
-	return 0;
-}
-
-static int dummy_socket_getsockname (struct socket *sock)
-{
-	return 0;
-}
-
-static int dummy_socket_getpeername (struct socket *sock)
-{
-	return 0;
-}
-
-static int dummy_socket_setsockopt (struct socket *sock, int level, int optname)
-{
-	return 0;
-}
-
-static int dummy_socket_getsockopt (struct socket *sock, int level, int optname)
-{
-	return 0;
-}
-
-static int dummy_socket_shutdown (struct socket *sock, int how)
-{
-	return 0;
-}
-
-static int dummy_socket_sock_rcv_skb (struct sock *sk, struct sk_buff *skb)
-{
-	return 0;
-}
-
-static int dummy_socket_getpeersec(struct socket *sock, char __user *optval,
-				   int __user *optlen, unsigned len)
-{
-	return -ENOPROTOOPT;
-}
-
-static inline int dummy_sk_alloc_security (struct sock *sk, int family, int priority)
-{
-	return 0;
-}
-
-static inline void dummy_sk_free_security (struct sock *sk)
-{
-}
-#endif	/* CONFIG_SECURITY_NETWORK */
-
-static int dummy_register_security (const char *name, struct security_operations *ops)
-{
-	return -EINVAL;
-}
-
-static int dummy_unregister_security (const char *name, struct security_operations *ops)
-{
-	return -EINVAL;
-}
-
-static void dummy_d_instantiate (struct dentry *dentry, struct inode *inode)
-{
-	return;
-}
-
-static int dummy_getprocattr(struct task_struct *p, char *name, void *value, size_t size)
-{
-	return -EINVAL;
-}
-
-static int dummy_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
-{
-	return -EINVAL;
-}
-
-
-struct security_operations dummy_security_ops;
-
-#define set_to_dummy_if_null(ops, function)				\
-	do {								\
-		if (!ops->function) {					\
-			ops->function = dummy_##function;		\
-			pr_debug("Had to override the " #function	\
-				 " security operation with the dummy one.\n");\
-			}						\
-	} while (0)
-
-void security_fixup_ops (struct security_operations *ops)
-{
-	set_to_dummy_if_null(ops, ptrace);
-	set_to_dummy_if_null(ops, capget);
-	set_to_dummy_if_null(ops, capset_check);
-	set_to_dummy_if_null(ops, capset_set);
-	set_to_dummy_if_null(ops, acct);
-	set_to_dummy_if_null(ops, capable);
-	set_to_dummy_if_null(ops, quotactl);
-	set_to_dummy_if_null(ops, quota_on);
-	set_to_dummy_if_null(ops, sysctl);
-	set_to_dummy_if_null(ops, syslog);
-	set_to_dummy_if_null(ops, settime);
-	set_to_dummy_if_null(ops, vm_enough_memory);
-	set_to_dummy_if_null(ops, bprm_alloc_security);
-	set_to_dummy_if_null(ops, bprm_free_security);
-	set_to_dummy_if_null(ops, bprm_apply_creds);
-	set_to_dummy_if_null(ops, bprm_post_apply_creds);
-	set_to_dummy_if_null(ops, bprm_set_security);
-	set_to_dummy_if_null(ops, bprm_check_security);
-	set_to_dummy_if_null(ops, bprm_secureexec);
-	set_to_dummy_if_null(ops, sb_alloc_security);
-	set_to_dummy_if_null(ops, sb_free_security);
-	set_to_dummy_if_null(ops, sb_copy_data);
-	set_to_dummy_if_null(ops, sb_kern_mount);
-	set_to_dummy_if_null(ops, sb_statfs);
-	set_to_dummy_if_null(ops, sb_mount);
-	set_to_dummy_if_null(ops, sb_check_sb);
-	set_to_dummy_if_null(ops, sb_umount);
-	set_to_dummy_if_null(ops, sb_umount_close);
-	set_to_dummy_if_null(ops, sb_umount_busy);
-	set_to_dummy_if_null(ops, sb_post_remount);
-	set_to_dummy_if_null(ops, sb_post_mountroot);
-	set_to_dummy_if_null(ops, sb_post_addmount);
-	set_to_dummy_if_null(ops, sb_pivotroot);
-	set_to_dummy_if_null(ops, sb_post_pivotroot);
-	set_to_dummy_if_null(ops, inode_alloc_security);
-	set_to_dummy_if_null(ops, inode_free_security);
-	set_to_dummy_if_null(ops, inode_create);
-	set_to_dummy_if_null(ops, inode_post_create);
-	set_to_dummy_if_null(ops, inode_link);
-	set_to_dummy_if_null(ops, inode_post_link);
-	set_to_dummy_if_null(ops, inode_unlink);
-	set_to_dummy_if_null(ops, inode_symlink);
-	set_to_dummy_if_null(ops, inode_post_symlink);
-	set_to_dummy_if_null(ops, inode_mkdir);
-	set_to_dummy_if_null(ops, inode_post_mkdir);
-	set_to_dummy_if_null(ops, inode_rmdir);
-	set_to_dummy_if_null(ops, inode_mknod);
-	set_to_dummy_if_null(ops, inode_post_mknod);
-	set_to_dummy_if_null(ops, inode_rename);
-	set_to_dummy_if_null(ops, inode_post_rename);
-	set_to_dummy_if_null(ops, inode_readlink);
-	set_to_dummy_if_null(ops, inode_follow_link);
-	set_to_dummy_if_null(ops, inode_permission);
-	set_to_dummy_if_null(ops, inode_setattr);
-	set_to_dummy_if_null(ops, inode_getattr);
-	set_to_dummy_if_null(ops, inode_delete);
-	set_to_dummy_if_null(ops, inode_setxattr);
-	set_to_dummy_if_null(ops, inode_post_setxattr);
-	set_to_dummy_if_null(ops, inode_getxattr);
-	set_to_dummy_if_null(ops, inode_listxattr);
-	set_to_dummy_if_null(ops, inode_removexattr);
-	set_to_dummy_if_null(ops, inode_getsecurity);
-	set_to_dummy_if_null(ops, inode_setsecurity);
-	set_to_dummy_if_null(ops, inode_listsecurity);
-	set_to_dummy_if_null(ops, file_permission);
-	set_to_dummy_if_null(ops, file_alloc_security);
-	set_to_dummy_if_null(ops, file_free_security);
-	set_to_dummy_if_null(ops, file_ioctl);
-	set_to_dummy_if_null(ops, file_mmap);
-	set_to_dummy_if_null(ops, file_mprotect);
-	set_to_dummy_if_null(ops, file_lock);
-	set_to_dummy_if_null(ops, file_fcntl);
-	set_to_dummy_if_null(ops, file_set_fowner);
-	set_to_dummy_if_null(ops, file_send_sigiotask);
-	set_to_dummy_if_null(ops, file_receive);
-	set_to_dummy_if_null(ops, task_create);
-	set_to_dummy_if_null(ops, task_alloc_security);
-	set_to_dummy_if_null(ops, task_free_security);
-	set_to_dummy_if_null(ops, task_setuid);
-	set_to_dummy_if_null(ops, task_post_setuid);
-	set_to_dummy_if_null(ops, task_setgid);
-	set_to_dummy_if_null(ops, task_setpgid);
-	set_to_dummy_if_null(ops, task_getpgid);
-	set_to_dummy_if_null(ops, task_getsid);
-	set_to_dummy_if_null(ops, task_setgroups);
-	set_to_dummy_if_null(ops, task_setnice);
-	set_to_dummy_if_null(ops, task_setrlimit);
-	set_to_dummy_if_null(ops, task_setscheduler);
-	set_to_dummy_if_null(ops, task_getscheduler);
-	set_to_dummy_if_null(ops, task_wait);
-	set_to_dummy_if_null(ops, task_kill);
-	set_to_dummy_if_null(ops, task_prctl);
-	set_to_dummy_if_null(ops, task_reparent_to_init);
- 	set_to_dummy_if_null(ops, task_to_inode);
-	set_to_dummy_if_null(ops, ipc_permission);
-	set_to_dummy_if_null(ops, msg_msg_alloc_security);
-	set_to_dummy_if_null(ops, msg_msg_free_security);
-	set_to_dummy_if_null(ops, msg_queue_alloc_security);
-	set_to_dummy_if_null(ops, msg_queue_free_security);
-	set_to_dummy_if_null(ops, msg_queue_associate);
-	set_to_dummy_if_null(ops, msg_queue_msgctl);
-	set_to_dummy_if_null(ops, msg_queue_msgsnd);
-	set_to_dummy_if_null(ops, msg_queue_msgrcv);
-	set_to_dummy_if_null(ops, shm_alloc_security);
-	set_to_dummy_if_null(ops, shm_free_security);
-	set_to_dummy_if_null(ops, shm_associate);
-	set_to_dummy_if_null(ops, shm_shmctl);
-	set_to_dummy_if_null(ops, shm_shmat);
-	set_to_dummy_if_null(ops, sem_alloc_security);
-	set_to_dummy_if_null(ops, sem_free_security);
-	set_to_dummy_if_null(ops, sem_associate);
-	set_to_dummy_if_null(ops, sem_semctl);
-	set_to_dummy_if_null(ops, sem_semop);
-	set_to_dummy_if_null(ops, netlink_send);
-	set_to_dummy_if_null(ops, netlink_recv);
-	set_to_dummy_if_null(ops, register_security);
-	set_to_dummy_if_null(ops, unregister_security);
-	set_to_dummy_if_null(ops, d_instantiate);
- 	set_to_dummy_if_null(ops, getprocattr);
- 	set_to_dummy_if_null(ops, setprocattr);
-#ifdef CONFIG_SECURITY_NETWORK
-	set_to_dummy_if_null(ops, unix_stream_connect);
-	set_to_dummy_if_null(ops, unix_may_send);
-	set_to_dummy_if_null(ops, socket_create);
-	set_to_dummy_if_null(ops, socket_post_create);
-	set_to_dummy_if_null(ops, socket_bind);
-	set_to_dummy_if_null(ops, socket_connect);
-	set_to_dummy_if_null(ops, socket_listen);
-	set_to_dummy_if_null(ops, socket_accept);
-	set_to_dummy_if_null(ops, socket_post_accept);
-	set_to_dummy_if_null(ops, socket_sendmsg);
-	set_to_dummy_if_null(ops, socket_recvmsg);
-	set_to_dummy_if_null(ops, socket_getsockname);
-	set_to_dummy_if_null(ops, socket_getpeername);
-	set_to_dummy_if_null(ops, socket_setsockopt);
-	set_to_dummy_if_null(ops, socket_getsockopt);
-	set_to_dummy_if_null(ops, socket_shutdown);
-	set_to_dummy_if_null(ops, socket_sock_rcv_skb);
-	set_to_dummy_if_null(ops, socket_getpeersec);
-	set_to_dummy_if_null(ops, sk_alloc_security);
-	set_to_dummy_if_null(ops, sk_free_security);
-#endif	/* CONFIG_SECURITY_NETWORK */
-}
-
Index: lsm-hooks-2.6/security/security.c
===================================================================
--- lsm-hooks-2.6.orig/security/security.c
+++ lsm-hooks-2.6/security/security.c
@@ -20,12 +20,12 @@
 
 #define SECURITY_FRAMEWORK_VERSION	"1.0.0"
 
-/* things that live in dummy.c */
-extern struct security_operations dummy_security_ops;
-extern void security_fixup_ops(struct security_operations *ops);
-
 struct security_operations *security_ops;	/* Initialized to NULL */
 
+static struct security_operations default_security_ops;
+
+extern void security_fixup_ops (struct security_operations *ops);
+
 static inline int verify(struct security_operations *ops)
 {
 	/* verify the security_operations structure exists */
@@ -55,13 +55,13 @@ int __init security_init(void)
 	printk(KERN_INFO "Security Framework v" SECURITY_FRAMEWORK_VERSION
 	       " initialized\n");
 
-	if (verify(&dummy_security_ops)) {
+	if (verify(&default_security_ops)) {
 		printk(KERN_ERR "%s could not verify "
-		       "dummy_security_ops structure.\n", __FUNCTION__);
+		       "default_security_ops structure.\n", __FUNCTION__);
 		return -EIO;
 	}
 
-	security_ops = &dummy_security_ops;
+	security_ops = &default_security_ops;
 	do_security_initcalls();
 
 	return 0;
@@ -87,7 +87,7 @@ int register_security(struct security_op
 		return -EINVAL;
 	}
 
-	if (security_ops != &dummy_security_ops)
+	if (security_ops != &default_security_ops)
 		return -EAGAIN;
 
 	security_ops = ops;
@@ -102,9 +102,9 @@ int register_security(struct security_op
  * This function removes a struct security_operations variable that had
  * previously been registered with a successful call to register_security().
  *
- * If @ops does not match the valued previously passed to register_security()
+ * If @ops does not match the value previously passed to register_security()
  * an error is returned.  Otherwise the default security options is set to the
- * the dummy_security_ops structure, and 0 is returned.
+ * the default_security_ops structure, and 0 is returned.
  */
 int unregister_security(struct security_operations *ops)
 {
@@ -115,7 +115,7 @@ int unregister_security(struct security_
 		return -EINVAL;
 	}
 
-	security_ops = &dummy_security_ops;
+	security_ops = &default_security_ops;
 
 	return 0;
 }

--
