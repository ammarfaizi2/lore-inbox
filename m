Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbSJQVYD>; Thu, 17 Oct 2002 17:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262157AbSJQVYD>; Thu, 17 Oct 2002 17:24:03 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:49934 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262130AbSJQVXD>;
	Thu, 17 Oct 2002 17:23:03 -0400
Date: Thu, 17 Oct 2002 14:28:39 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.43
Message-ID: <20021017212839.GC1125@kroah.com>
References: <20021017212620.GA1125@kroah.com> <20021017212809.GB1125@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017212809.GB1125@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.799, 2002/10/17 13:47:59-07:00, greg@kroah.com

LSM:  Create CONFIG_SECURITY and disable it by default for now.

This allows the security hooks to be compiled away into nothingness if CONFIG_SECURITY
is disabled.  When disabled, the default capabilities functionality is preserved.
When enabled, security modules are allowed to be loaded.


diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Thu Oct 17 14:19:24 2002
+++ b/include/linux/sched.h	Thu Oct 17 14:19:24 2002
@@ -596,9 +596,9 @@
 		       unsigned long, const char *, void *);
 extern void free_irq(unsigned int, void *);
 
-/* capable prototype and code moved to security.[hc] */
-#include <linux/security.h>
-#if 0
+
+#ifndef CONFIG_SECURITY
+/* capable prototype and code are in security.[hc] if CONFIG_SECURITY */
 static inline int capable(int cap)
 {
 	if (cap_raised(current->cap_effective, cap)) {
@@ -607,7 +607,7 @@
 	}
 	return 0;
 }
-#endif	/* if 0 */
+#endif
 
 /*
  * Routines for handling mm_structs
diff -Nru a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Thu Oct 17 14:19:24 2002
+++ b/include/linux/security.h	Thu Oct 17 14:19:24 2002
@@ -22,8 +22,6 @@
 #ifndef __LINUX_SECURITY_H
 #define __LINUX_SECURITY_H
 
-#ifdef __KERNEL__
-
 #include <linux/fs.h>
 #include <linux/binfmts.h>
 #include <linux/signal.h>
@@ -32,6 +30,23 @@
 #include <linux/sysctl.h>
 #include <linux/shm.h>
 #include <linux/msg.h>
+#include <linux/sched.h>
+
+
+/*
+ * These functions are in security/capability.c and are used
+ * as the default capabilities functions
+ */
+extern int cap_capable (struct task_struct *tsk, int cap);
+extern int cap_ptrace (struct task_struct *parent, struct task_struct *child);
+extern int cap_capget (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
+extern int cap_capset_check (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
+extern void cap_capset_set (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
+extern int cap_bprm_set_security (struct linux_binprm *bprm);
+extern void cap_bprm_compute_creds (struct linux_binprm *bprm);
+extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
+extern void cap_task_kmod_set_label (void);
+extern void cap_task_reparent_to_init (struct task_struct *p);
 
 /*
  * Values used in the task_security_ops calls
@@ -48,6 +63,9 @@
 /* setfsuid or setfsgid, id0 == fsuid or fsgid */
 #define LSM_SETID_FS	8
 
+
+#ifdef CONFIG_SECURITY
+
 /* forward declares to avoid warnings */
 struct sk_buff;
 struct net_device;
@@ -843,6 +861,526 @@
 	                            struct security_operations *ops);
 };
 
+/* global variables */
+extern struct security_operations *security_ops;
+
+/* inline stuff */
+static inline int security_ptrace (struct task_struct * parent, struct task_struct * child)
+{
+	return security_ops->ptrace (parent, child);
+}
+
+static inline int security_capget (struct task_struct *target,
+				   kernel_cap_t *effective,
+				   kernel_cap_t *inheritable,
+				   kernel_cap_t *permitted)
+{
+	return security_ops->capget (target, effective, inheritable, permitted);
+}
+
+static inline int security_capset_check (struct task_struct *target,
+					 kernel_cap_t *effective,
+					 kernel_cap_t *inheritable,
+					 kernel_cap_t *permitted)
+{
+	return security_ops->capset_check (target, effective, inheritable, permitted);
+}
+
+static inline void security_capset_set (struct task_struct *target,
+					kernel_cap_t *effective,
+					kernel_cap_t *inheritable,
+					kernel_cap_t *permitted)
+{
+	security_ops->capset_set (target, effective, inheritable, permitted);
+}
+
+static inline int security_acct (struct file *file)
+{
+	return security_ops->acct (file);
+}
+
+static inline int security_quotactl (int cmds, int type, int id,
+				     struct super_block *sb)
+{
+	return security_ops->quotactl (cmds, type, id, sb);
+}
+
+static inline int security_quota_on (struct file * file)
+{
+	return security_ops->quota_on (file);
+}
+
+static inline int security_bprm_alloc (struct linux_binprm *bprm)
+{
+	return security_ops->bprm_alloc_security (bprm);
+}
+static inline void security_bprm_free (struct linux_binprm *bprm)
+{
+	security_ops->bprm_free_security (bprm);
+}
+static inline void security_bprm_compute_creds (struct linux_binprm *bprm)
+{
+	security_ops->bprm_compute_creds (bprm);
+}
+static inline int security_bprm_set (struct linux_binprm *bprm)
+{
+	return security_ops->bprm_set_security (bprm);
+}
+static inline int security_bprm_check (struct linux_binprm *bprm)
+{
+	return security_ops->bprm_check_security (bprm);
+}
+
+static inline int security_sb_alloc (struct super_block *sb)
+{
+	return security_ops->sb_alloc_security (sb);
+}
+
+static inline void security_sb_free (struct super_block *sb)
+{
+	security_ops->sb_free_security (sb);
+}
+
+static inline int security_sb_statfs (struct super_block *sb)
+{
+	return security_ops->sb_statfs (sb);
+}
+
+static inline int security_sb_mount (char *dev_name, struct nameidata *nd,
+				    char *type, unsigned long flags,
+				    void *data)
+{
+	return security_ops->sb_mount (dev_name, nd, type, flags, data);
+}
+
+static inline int security_sb_check_sb (struct vfsmount *mnt,
+					struct nameidata *nd)
+{
+	return security_ops->sb_check_sb (mnt, nd);
+}
+
+static inline int security_sb_umount (struct vfsmount *mnt, int flags)
+{
+	return security_ops->sb_umount (mnt, flags);
+}
+
+static inline void security_sb_umount_close (struct vfsmount *mnt)
+{
+	security_ops->sb_umount_close (mnt);
+}
+
+static inline void security_sb_umount_busy (struct vfsmount *mnt)
+{
+	security_ops->sb_umount_busy (mnt);
+}
+
+static inline void security_sb_post_remount (struct vfsmount *mnt,
+					     unsigned long flags, void *data)
+{
+	security_ops->sb_post_remount (mnt, flags, data);
+}
+
+static inline void security_sb_post_mountroot (void)
+{
+	security_ops->sb_post_mountroot ();
+}
+
+static inline void security_sb_post_addmount (struct vfsmount *mnt,
+					      struct nameidata *mountpoint_nd)
+{
+	security_ops->sb_post_addmount (mnt, mountpoint_nd);
+}
+
+static inline int security_sb_pivotroot (struct nameidata *old_nd,
+					 struct nameidata *new_nd)
+{
+	return security_ops->sb_pivotroot (old_nd, new_nd);
+}
+
+static inline void security_sb_post_pivotroot (struct nameidata *old_nd,
+					       struct nameidata *new_nd)
+{
+	security_ops->sb_post_pivotroot (old_nd, new_nd);
+}
+
+static inline int security_inode_alloc (struct inode *inode)
+{
+	return security_ops->inode_alloc_security (inode);
+}
+
+static inline void security_inode_free (struct inode *inode)
+{
+	security_ops->inode_free_security (inode);
+}
+	
+static inline int security_inode_create (struct inode *dir,
+					 struct dentry *dentry,
+					 int mode)
+{
+	return security_ops->inode_create (dir, dentry, mode);
+}
+
+static inline void security_inode_post_create (struct inode *dir,
+					       struct dentry *dentry,
+					       int mode)
+{
+	security_ops->inode_post_create (dir, dentry, mode);
+}
+
+static inline int security_inode_link (struct dentry *old_dentry,
+				       struct inode *dir,
+				       struct dentry *new_dentry)
+{
+	return security_ops->inode_link (old_dentry, dir, new_dentry);
+}
+
+static inline void security_inode_post_link (struct dentry *old_dentry,
+					     struct inode *dir,
+					     struct dentry *new_dentry)
+{
+	security_ops->inode_post_link (old_dentry, dir, new_dentry);
+}
+
+static inline int security_inode_unlink (struct inode *dir,
+					 struct dentry *dentry)
+{
+	return security_ops->inode_unlink (dir, dentry);
+}
+
+static inline int security_inode_symlink (struct inode *dir,
+					  struct dentry *dentry,
+					  const char *old_name)
+{
+	return security_ops->inode_symlink (dir, dentry, old_name);
+}
+
+static inline void security_inode_post_symlink (struct inode *dir,
+						struct dentry *dentry,
+						const char *old_name)
+{
+	security_ops->inode_post_symlink (dir, dentry, old_name);
+}
+
+static inline int security_inode_mkdir (struct inode *dir,
+					struct dentry *dentry,
+					int mode)
+{
+	return security_ops->inode_mkdir (dir, dentry, mode);
+}
+
+static inline void security_inode_post_mkdir (struct inode *dir,
+					      struct dentry *dentry,
+					      int mode)
+{
+	security_ops->inode_post_mkdir (dir, dentry, mode);
+}
+
+static inline int security_inode_rmdir (struct inode *dir,
+					struct dentry *dentry)
+{
+	return security_ops->inode_rmdir (dir, dentry);
+}
+
+static inline int security_inode_mknod (struct inode *dir,
+					struct dentry *dentry,
+					int mode, dev_t dev)
+{
+	return security_ops->inode_mknod (dir, dentry, mode, dev);
+}
+
+static inline void security_inode_post_mknod (struct inode *dir,
+					      struct dentry *dentry,
+					      int mode, dev_t dev)
+{
+	security_ops->inode_post_mknod (dir, dentry, mode, dev);
+}
+
+static inline int security_inode_rename (struct inode *old_dir,
+					 struct dentry *old_dentry,
+					 struct inode *new_dir,
+					 struct dentry *new_dentry)
+{
+	return security_ops->inode_rename (old_dir, old_dentry,
+					   new_dir, new_dentry);
+}
+
+static inline void security_inode_post_rename (struct inode *old_dir,
+					       struct dentry *old_dentry,
+					       struct inode *new_dir,
+					       struct dentry *new_dentry)
+{
+	security_ops->inode_post_rename (old_dir, old_dentry,
+						new_dir, new_dentry);
+}
+
+static inline int security_inode_readlink (struct dentry *dentry)
+{
+	return security_ops->inode_readlink (dentry);
+}
+
+static inline int security_inode_follow_link (struct dentry *dentry,
+					      struct nameidata *nd)
+{
+	return security_ops->inode_follow_link (dentry, nd);
+}
+
+static inline int security_inode_permission (struct inode *inode, int mask)
+{
+	return security_ops->inode_permission (inode, mask);
+}
+
+static inline int security_inode_permission_lite (struct inode *inode,
+						  int mask)
+{
+	return security_ops->inode_permission_lite (inode, mask);
+}
+
+static inline int security_inode_setattr (struct dentry *dentry,
+					  struct iattr *attr)
+{
+	return security_ops->inode_setattr (dentry, attr);
+}
+
+static inline int security_inode_getattr (struct vfsmount *mnt,
+					  struct dentry *dentry)
+{
+	return security_ops->inode_getattr (mnt, dentry);
+}
+
+static inline void security_inode_post_lookup (struct inode *inode,
+					       struct dentry *dentry)
+{
+	security_ops->inode_post_lookup (inode, dentry);
+}
+
+static inline void security_inode_delete (struct inode *inode)
+{
+	security_ops->inode_delete (inode);
+}
+
+static inline int security_inode_setxattr (struct dentry *dentry, char *name,
+					   void *value, size_t size, int flags)
+{
+	return security_ops->inode_setxattr (dentry, name, value, size, flags);
+}
+
+static inline int security_inode_getxattr (struct dentry *dentry, char *name)
+{
+	return security_ops->inode_getxattr (dentry, name);
+}
+
+static inline int security_inode_listxattr (struct dentry *dentry)
+{
+	return security_ops->inode_listxattr (dentry);
+}
+
+static inline int security_inode_removexattr (struct dentry *dentry, char *name)
+{
+	return security_ops->inode_removexattr (dentry, name);
+}
+
+static inline int security_file_permission (struct file *file, int mask)
+{
+	return security_ops->file_permission (file, mask);
+}
+
+static inline int security_file_alloc (struct file *file)
+{
+	return security_ops->file_alloc_security (file);
+}
+
+static inline void security_file_free (struct file *file)
+{
+	security_ops->file_free_security (file);
+}
+
+static inline int security_file_ioctl (struct file *file, unsigned int cmd,
+				       unsigned long arg)
+{
+	return security_ops->file_ioctl (file, cmd, arg);
+}
+
+static inline int security_file_mmap (struct file *file, unsigned long prot,
+				      unsigned long flags)
+{
+	return security_ops->file_mmap (file, prot, flags);
+}
+
+static inline int security_file_mprotect (struct vm_area_struct *vma,
+					  unsigned long prot)
+{
+	return security_ops->file_mprotect (vma, prot);
+}
+
+static inline int security_file_lock (struct file *file, unsigned int cmd)
+{
+	return security_ops->file_lock (file, cmd);
+}
+
+static inline int security_file_fcntl (struct file *file, unsigned int cmd,
+				       unsigned long arg)
+{
+	return security_ops->file_fcntl (file, cmd, arg);
+}
+
+static inline int security_file_set_fowner (struct file *file)
+{
+	return security_ops->file_set_fowner (file);
+}
+
+static inline int security_file_send_sigiotask (struct task_struct *tsk,
+						struct fown_struct *fown,
+						int fd, int reason)
+{
+	return security_ops->file_send_sigiotask (tsk, fown, fd, reason);
+}
+
+static inline int security_file_receive (struct file *file)
+{
+	return security_ops->file_receive (file);
+}
+
+static inline int security_task_create (unsigned long clone_flags)
+{
+	return security_ops->task_create (clone_flags);
+}
+
+static inline int security_task_alloc (struct task_struct *p)
+{
+	return security_ops->task_alloc_security (p);
+}
+
+static inline void security_task_free (struct task_struct *p)
+{
+	security_ops->task_free_security (p);
+}
+
+static inline int security_task_setuid (uid_t id0, uid_t id1, uid_t id2,
+					int flags)
+{
+	return security_ops->task_setuid (id0, id1, id2, flags);
+}
+
+static inline int security_task_post_setuid (uid_t old_ruid, uid_t old_euid,
+					     uid_t old_suid, int flags)
+{
+	return security_ops->task_post_setuid (old_ruid, old_euid, old_suid, flags);
+}
+
+static inline int security_task_setgid (gid_t id0, gid_t id1, gid_t id2,
+					int flags)
+{
+	return security_ops->task_setgid (id0, id1, id2, flags);
+}
+
+static inline int security_task_setpgid (struct task_struct *p, pid_t pgid)
+{
+	return security_ops->task_setpgid (p, pgid);
+}
+
+static inline int security_task_getpgid (struct task_struct *p)
+{
+	return security_ops->task_getpgid (p);
+}
+
+static inline int security_task_getsid (struct task_struct *p)
+{
+	return security_ops->task_getsid (p);
+}
+
+static inline int security_task_setgroups (int gidsetsize, gid_t *grouplist)
+{
+	return security_ops->task_setgroups (gidsetsize, grouplist);
+}
+
+static inline int security_task_setnice (struct task_struct *p, int nice)
+{
+	return security_ops->task_setnice (p, nice);
+}
+
+static inline int security_task_setrlimit (unsigned int resource,
+					   struct rlimit *new_rlim)
+{
+	return security_ops->task_setrlimit (resource, new_rlim);
+}
+
+static inline int security_task_setscheduler (struct task_struct *p,
+					      int policy,
+					      struct sched_param *lp)
+{
+	return security_ops->task_setscheduler (p, policy, lp);
+}
+
+static inline int security_task_getscheduler (struct task_struct *p)
+{
+	return security_ops->task_getscheduler (p);
+}
+
+static inline int security_task_kill (struct task_struct *p,
+				      struct siginfo *info, int sig)
+{
+	return security_ops->task_kill (p, info, sig);
+}
+
+static inline int security_task_wait (struct task_struct *p)
+{
+	return security_ops->task_wait (p);
+}
+
+static inline int security_task_prctl (int option, unsigned long arg2,
+				       unsigned long arg3,
+				       unsigned long arg4,
+				       unsigned long arg5)
+{
+	return security_ops->task_prctl (option, arg2, arg3, arg4, arg5);
+}
+
+static inline void security_task_kmod_set_label (void)
+{
+	security_ops->task_kmod_set_label ();
+}
+
+static inline void security_task_reparent_to_init (struct task_struct *p)
+{
+	security_ops->task_reparent_to_init (p);
+}
+
+static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
+					   short flag)
+{
+	return security_ops->ipc_permission (ipcp, flag);
+}
+
+static inline int security_msg_queue_alloc (struct msg_queue *msq)
+{
+	return security_ops->msg_queue_alloc_security (msq);
+}
+
+static inline void security_msg_queue_free (struct msg_queue *msq)
+{
+	security_ops->msg_queue_free_security (msq);
+}
+
+static inline int security_shm_alloc (struct shmid_kernel *shp)
+{
+	return security_ops->shm_alloc_security (shp);
+}
+
+static inline void security_shm_free (struct shmid_kernel *shp)
+{
+	security_ops->shm_free_security (shp);
+}
+
+static inline int security_sem_alloc (struct sem_array *sma)
+{
+	return security_ops->sem_alloc_security (sma);
+}
+
+static inline void security_sem_free (struct sem_array *sma)
+{
+	security_ops->sem_free_security (sma);
+}
+
 
 /* prototypes */
 extern int security_scaffolding_startup	(void);
@@ -852,11 +1390,495 @@
 extern int mod_unreg_security	(const char *name, struct security_operations *ops);
 extern int capable		(int cap);
 
-/* global variables */
-extern struct security_operations *security_ops;
+
+#else /* CONFIG_SECURITY */
+
+/*
+ * This is the default capabilities functionality.  Most of these functions
+ * are just stubbed out, but a few must call the proper capable code.
+ */
+
+static inline int security_scaffolding_startup (void)
+{
+	return 0;
+}
+
+static inline int security_ptrace (struct task_struct *parent, struct task_struct * child)
+{
+	return cap_ptrace (parent, child);
+}
+
+static inline int security_capget (struct task_struct *target,
+				   kernel_cap_t *effective,
+				   kernel_cap_t *inheritable,
+				   kernel_cap_t *permitted)
+{
+	return cap_capget (target, effective, inheritable, permitted);
+}
+
+static inline int security_capset_check (struct task_struct *target,
+					 kernel_cap_t *effective,
+					 kernel_cap_t *inheritable,
+					 kernel_cap_t *permitted)
+{
+	return cap_capset_check (target, effective, inheritable, permitted);
+}
+
+static inline void security_capset_set (struct task_struct *target,
+					kernel_cap_t *effective,
+					kernel_cap_t *inheritable,
+					kernel_cap_t *permitted)
+{
+	cap_capset_set (target, effective, inheritable, permitted);
+}
+
+static inline int security_acct (struct file *file)
+{
+	return 0;
+}
+
+static inline int security_quotactl (int cmds, int type, int id,
+				     struct super_block * sb)
+{
+	return 0;
+}
+
+static inline int security_quota_on (struct file * file)
+{
+	return 0;
+}
+
+static inline int security_bprm_alloc (struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static inline void security_bprm_free (struct linux_binprm *bprm)
+{ }
+
+static inline void security_bprm_compute_creds (struct linux_binprm *bprm)
+{ 
+	cap_bprm_compute_creds (bprm);
+}
+
+static inline int security_bprm_set (struct linux_binprm *bprm)
+{
+	return cap_bprm_set_security (bprm);
+}
+
+static inline int security_bprm_check (struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static inline int security_sb_alloc (struct super_block *sb)
+{
+	return 0;
+}
+
+static inline void security_sb_free (struct super_block *sb)
+{ }
+
+static inline int security_sb_statfs (struct super_block *sb)
+{
+	return 0;
+}
+
+static inline int security_sb_mount (char *dev_name, struct nameidata *nd,
+				    char *type, unsigned long flags,
+				    void *data)
+{
+	return 0;
+}
+
+static inline int security_sb_check_sb (struct vfsmount *mnt,
+					struct nameidata *nd)
+{
+	return 0;
+}
+
+static inline int security_sb_umount (struct vfsmount *mnt, int flags)
+{
+	return 0;
+}
+
+static inline void security_sb_umount_close (struct vfsmount *mnt)
+{ }
+
+static inline void security_sb_umount_busy (struct vfsmount *mnt)
+{ }
+
+static inline void security_sb_post_remount (struct vfsmount *mnt,
+					     unsigned long flags, void *data)
+{ }
+
+static inline void security_sb_post_mountroot (void)
+{ }
+
+static inline void security_sb_post_addmount (struct vfsmount *mnt,
+					      struct nameidata *mountpoint_nd)
+{ }
+
+static inline int security_sb_pivotroot (struct nameidata *old_nd,
+					 struct nameidata *new_nd)
+{
+	return 0;
+}
+
+static inline void security_sb_post_pivotroot (struct nameidata *old_nd,
+					       struct nameidata *new_nd)
+{ }
+
+static inline int security_inode_alloc (struct inode *inode)
+{
+	return 0;
+}
+
+static inline void security_inode_free (struct inode *inode)
+{ }
+	
+static inline int security_inode_create (struct inode *dir,
+					 struct dentry *dentry,
+					 int mode)
+{
+	return 0;
+}
+
+static inline void security_inode_post_create (struct inode *dir,
+					       struct dentry *dentry,
+					       int mode)
+{ }
+
+static inline int security_inode_link (struct dentry *old_dentry,
+				       struct inode *dir,
+				       struct dentry *new_dentry)
+{
+	return 0;
+}
+
+static inline void security_inode_post_link (struct dentry *old_dentry,
+					     struct inode *dir,
+					     struct dentry *new_dentry)
+{ }
+
+static inline int security_inode_unlink (struct inode *dir,
+					 struct dentry *dentry)
+{
+	return 0;
+}
+
+static inline int security_inode_symlink (struct inode *dir,
+					  struct dentry *dentry,
+					  const char *old_name)
+{
+	return 0;
+}
+
+static inline void security_inode_post_symlink (struct inode *dir,
+						struct dentry *dentry,
+						const char *old_name)
+{ }
+
+static inline int security_inode_mkdir (struct inode *dir,
+					struct dentry *dentry,
+					int mode)
+{
+	return 0;
+}
+
+static inline void security_inode_post_mkdir (struct inode *dir,
+					      struct dentry *dentry,
+					      int mode)
+{ }
+
+static inline int security_inode_rmdir (struct inode *dir,
+					struct dentry *dentry)
+{
+	return 0;
+}
+
+static inline int security_inode_mknod (struct inode *dir,
+					struct dentry *dentry,
+					int mode, dev_t dev)
+{
+	return 0;
+}
+
+static inline void security_inode_post_mknod (struct inode *dir,
+					      struct dentry *dentry,
+					      int mode, dev_t dev)
+{ }
+
+static inline int security_inode_rename (struct inode *old_dir,
+					 struct dentry *old_dentry,
+					 struct inode *new_dir,
+					 struct dentry *new_dentry)
+{
+	return 0;
+}
+
+static inline void security_inode_post_rename (struct inode *old_dir,
+					       struct dentry *old_dentry,
+					       struct inode *new_dir,
+					       struct dentry *new_dentry)
+{ }
+
+static inline int security_inode_readlink (struct dentry *dentry)
+{
+	return 0;
+}
+
+static inline int security_inode_follow_link (struct dentry *dentry,
+					      struct nameidata *nd)
+{
+	return 0;
+}
+
+static inline int security_inode_permission (struct inode *inode, int mask)
+{
+	return 0;
+}
+
+static inline int security_inode_permission_lite (struct inode *inode,
+						  int mask)
+{
+	return 0;
+}
+
+static inline int security_inode_setattr (struct dentry *dentry,
+					  struct iattr *attr)
+{
+	return 0;
+}
+
+static inline int security_inode_getattr (struct vfsmount *mnt,
+					  struct dentry *dentry)
+{
+	return 0;
+}
+
+static inline void security_inode_post_lookup (struct inode *inode,
+					       struct dentry *dentry)
+{ }
+
+static inline void security_inode_delete (struct inode *inode)
+{ }
+
+static inline int security_inode_setxattr (struct dentry *dentry, char *name,
+					   void *value, size_t size, int flags)
+{
+	return 0;
+}
+
+static inline int security_inode_getxattr (struct dentry *dentry, char *name)
+{
+	return 0;
+}
+
+static inline int security_inode_listxattr (struct dentry *dentry)
+{
+	return 0;
+}
+
+static inline int security_inode_removexattr (struct dentry *dentry, char *name)
+{
+	return 0;
+}
+
+static inline int security_file_permission (struct file *file, int mask)
+{
+	return 0;
+}
+
+static inline int security_file_alloc (struct file *file)
+{
+	return 0;
+}
+
+static inline void security_file_free (struct file *file)
+{ }
+
+static inline int security_file_ioctl (struct file *file, unsigned int cmd,
+				       unsigned long arg)
+{
+	return 0;
+}
+
+static inline int security_file_mmap (struct file *file, unsigned long prot,
+				      unsigned long flags)
+{
+	return 0;
+}
+
+static inline int security_file_mprotect (struct vm_area_struct *vma,
+					  unsigned long prot)
+{
+	return 0;
+}
+
+static inline int security_file_lock (struct file *file, unsigned int cmd)
+{
+	return 0;
+}
+
+static inline int security_file_fcntl (struct file *file, unsigned int cmd,
+				       unsigned long arg)
+{
+	return 0;
+}
+
+static inline int security_file_set_fowner (struct file *file)
+{
+	return 0;
+}
+
+static inline int security_file_send_sigiotask (struct task_struct *tsk,
+						struct fown_struct *fown,
+						int fd, int reason)
+{
+	return 0;
+}
+
+static inline int security_file_receive (struct file *file)
+{
+	return 0;
+}
+
+static inline int security_task_create (unsigned long clone_flags)
+{
+	return 0;
+}
+
+static inline int security_task_alloc (struct task_struct *p)
+{
+	return 0;
+}
+
+static inline void security_task_free (struct task_struct *p)
+{ }
+
+static inline int security_task_setuid (uid_t id0, uid_t id1, uid_t id2,
+					int flags)
+{
+	return 0;
+}
+
+static inline int security_task_post_setuid (uid_t old_ruid, uid_t old_euid,
+					     uid_t old_suid, int flags)
+{
+	return cap_task_post_setuid (old_ruid, old_euid, old_suid, flags);
+}
+
+static inline int security_task_setgid (gid_t id0, gid_t id1, gid_t id2,
+					int flags)
+{
+	return 0;
+}
+
+static inline int security_task_setpgid (struct task_struct *p, pid_t pgid)
+{
+	return 0;
+}
+
+static inline int security_task_getpgid (struct task_struct *p)
+{
+	return 0;
+}
+
+static inline int security_task_getsid (struct task_struct *p)
+{
+	return 0;
+}
+
+static inline int security_task_setgroups (int gidsetsize, gid_t *grouplist)
+{
+	return 0;
+}
+
+static inline int security_task_setnice (struct task_struct *p, int nice)
+{
+	return 0;
+}
+
+static inline int security_task_setrlimit (unsigned int resource,
+					   struct rlimit *new_rlim)
+{
+	return 0;
+}
+
+static inline int security_task_setscheduler (struct task_struct *p,
+					      int policy,
+					      struct sched_param *lp)
+{
+	return 0;
+}
+
+static inline int security_task_getscheduler (struct task_struct *p)
+{
+	return 0;
+}
+
+static inline int security_task_kill (struct task_struct *p,
+				      struct siginfo *info, int sig)
+{
+	return 0;
+}
+
+static inline int security_task_wait (struct task_struct *p)
+{
+	return 0;
+}
+
+static inline int security_task_prctl (int option, unsigned long arg2,
+				       unsigned long arg3,
+				       unsigned long arg4,
+				       unsigned long arg5)
+{
+	return 0;
+}
+
+static inline void security_task_kmod_set_label (void)
+{
+	cap_task_kmod_set_label ();
+}
+
+static inline void security_task_reparent_to_init (struct task_struct *p)
+{
+	cap_task_reparent_to_init (p);
+}
+
+static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
+					   short flag)
+{
+	return 0;
+}
+
+static inline int security_msg_queue_alloc (struct msg_queue *msq)
+{
+	return 0;
+}
+
+static inline void security_msg_queue_free (struct msg_queue *msq)
+{ }
+
+static inline int security_shm_alloc (struct shmid_kernel *shp)
+{
+	return 0;
+}
+
+static inline void security_shm_free (struct shmid_kernel *shp)
+{ }
+
+static inline int security_sem_alloc (struct sem_array *sma)
+{
+	return 0;
+}
+
+static inline void security_sem_free (struct sem_array *sma)
+{ }
 
 
-#endif /* __KERNEL__ */
+#endif	/* CONFIG_SECURITY */
 
 #endif /* ! __LINUX_SECURITY_H */
 
diff -Nru a/security/Config.help b/security/Config.help
--- a/security/Config.help	Thu Oct 17 14:19:24 2002
+++ b/security/Config.help	Thu Oct 17 14:19:24 2002
@@ -1,3 +1,10 @@
+CONFIG_SECURITY
+  This enables the ability to have different security modules
+  in the kernel.  If this option is not selected, the default
+  capabilities functionality will be enabled.
+
+  If you are unsure how to answer this questions, answer N.
+
 CONFIG_SECURITY_CAPABILITIES
   This enables the "default" Linux capabilities functionality.
   If you are unsure how to answer this question, answer Y.
diff -Nru a/security/Config.in b/security/Config.in
--- a/security/Config.in	Thu Oct 17 14:19:24 2002
+++ b/security/Config.in	Thu Oct 17 14:19:24 2002
@@ -3,5 +3,5 @@
 #
 mainmenu_option next_comment
 comment 'Security options'
-define_bool CONFIG_SECURITY_CAPABILITIES y
+define_bool CONFIG_SECURITY n
 endmenu
diff -Nru a/security/Makefile b/security/Makefile
--- a/security/Makefile	Thu Oct 17 14:19:24 2002
+++ b/security/Makefile	Thu Oct 17 14:19:24 2002
@@ -3,11 +3,15 @@
 #
 
 # Objects that export symbols
-export-objs	:= security.o
+export-objs	:= security.o capability.o
 
-# Object file lists
-obj-y		:= security.o dummy.o
+# if we don't select a security model, use the default capabilities
+ifneq ($(CONFIG_SECURITY),y)
+obj-y		+= capability.o
+endif
 
+# Object file lists
+obj-$(CONFIG_SECURITY)			+= security.o dummy.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= capability.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/security/capability.c b/security/capability.c
--- a/security/capability.c	Thu Oct 17 14:19:24 2002
+++ b/security/capability.c	Thu Oct 17 14:19:24 2002
@@ -19,10 +19,7 @@
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 
-/* flag to keep track of how we were registered */
-static int secondary;
-
-static int cap_capable (struct task_struct *tsk, int cap)
+int cap_capable (struct task_struct *tsk, int cap)
 {
 	/* Derived from include/linux/sched.h:capable. */
 	if (cap_raised (tsk->cap_effective, cap))
@@ -31,23 +28,7 @@
 		return -EPERM;
 }
 
-static int cap_sys_security (unsigned int id, unsigned int call,
-			     unsigned long *args)
-{
-	return -ENOSYS;
-}
-
-static int cap_quotactl (int cmds, int type, int id, struct super_block *sb)
-{
-	return 0;
-}
-
-static int cap_quota_on (struct file *f)
-{
-	return 0;
-}
-
-static int cap_ptrace (struct task_struct *parent, struct task_struct *child)
+int cap_ptrace (struct task_struct *parent, struct task_struct *child)
 {
 	/* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
 	if (!cap_issubset (child->cap_permitted, current->cap_permitted) &&
@@ -57,8 +38,8 @@
 		return 0;
 }
 
-static int cap_capget (struct task_struct *target, kernel_cap_t * effective,
-		       kernel_cap_t * inheritable, kernel_cap_t * permitted)
+int cap_capget (struct task_struct *target, kernel_cap_t *effective,
+		kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	/* Derived from kernel/capability.c:sys_capget. */
 	*effective = cap_t (target->cap_effective);
@@ -67,10 +48,8 @@
 	return 0;
 }
 
-static int cap_capset_check (struct task_struct *target,
-			     kernel_cap_t * effective,
-			     kernel_cap_t * inheritable,
-			     kernel_cap_t * permitted)
+int cap_capset_check (struct task_struct *target, kernel_cap_t *effective,
+		      kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	/* Derived from kernel/capability.c:sys_capset. */
 	/* verify restrictions on target's new Inheritable set */
@@ -95,27 +74,15 @@
 	return 0;
 }
 
-static void cap_capset_set (struct task_struct *target,
-			    kernel_cap_t * effective,
-			    kernel_cap_t * inheritable,
-			    kernel_cap_t * permitted)
+void cap_capset_set (struct task_struct *target, kernel_cap_t *effective,
+		     kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	target->cap_effective = *effective;
 	target->cap_inheritable = *inheritable;
 	target->cap_permitted = *permitted;
 }
 
-static int cap_acct (struct file *file)
-{
-	return 0;
-}
-
-static int cap_bprm_alloc_security (struct linux_binprm *bprm)
-{
-	return 0;
-}
-
-static int cap_bprm_set_security (struct linux_binprm *bprm)
+int cap_bprm_set_security (struct linux_binprm *bprm)
 {
 	/* Copied from fs/exec.c:prepare_binprm. */
 
@@ -143,23 +110,13 @@
 	return 0;
 }
 
-static int cap_bprm_check_security (struct linux_binprm *bprm)
-{
-	return 0;
-}
-
-static void cap_bprm_free_security (struct linux_binprm *bprm)
-{
-	return;
-}
-
 /* Copied from fs/exec.c */
 static inline int must_not_trace_exec (struct task_struct *p)
 {
 	return (p->ptrace & PT_PTRACED) && !(p->ptrace & PT_PTRACE_CAP);
 }
 
-static void cap_bprm_compute_creds (struct linux_binprm *bprm)
+void cap_bprm_compute_creds (struct linux_binprm *bprm)
 {
 	/* Derived from fs/exec.c:compute_creds. */
 	kernel_cap_t new_permitted, working;
@@ -204,6 +161,160 @@
 	current->keep_capabilities = 0;
 }
 
+/* moved from kernel/sys.c. */
+/* 
+ * cap_emulate_setxuid() fixes the effective / permitted capabilities of
+ * a process after a call to setuid, setreuid, or setresuid.
+ *
+ *  1) When set*uiding _from_ one of {r,e,s}uid == 0 _to_ all of
+ *  {r,e,s}uid != 0, the permitted and effective capabilities are
+ *  cleared.
+ *
+ *  2) When set*uiding _from_ euid == 0 _to_ euid != 0, the effective
+ *  capabilities of the process are cleared.
+ *
+ *  3) When set*uiding _from_ euid != 0 _to_ euid == 0, the effective
+ *  capabilities are set to the permitted capabilities.
+ *
+ *  fsuid is handled elsewhere. fsuid == 0 and {r,e,s}uid!= 0 should 
+ *  never happen.
+ *
+ *  -astor 
+ *
+ * cevans - New behaviour, Oct '99
+ * A process may, via prctl(), elect to keep its capabilities when it
+ * calls setuid() and switches away from uid==0. Both permitted and
+ * effective sets will be retained.
+ * Without this change, it was impossible for a daemon to drop only some
+ * of its privilege. The call to setuid(!=0) would drop all privileges!
+ * Keeping uid 0 is not an option because uid 0 owns too many vital
+ * files..
+ * Thanks to Olaf Kirch and Peter Benie for spotting this.
+ */
+static inline void cap_emulate_setxuid (int old_ruid, int old_euid,
+					int old_suid)
+{
+	if ((old_ruid == 0 || old_euid == 0 || old_suid == 0) &&
+	    (current->uid != 0 && current->euid != 0 && current->suid != 0) &&
+	    !current->keep_capabilities) {
+		cap_clear (current->cap_permitted);
+		cap_clear (current->cap_effective);
+	}
+	if (old_euid == 0 && current->euid != 0) {
+		cap_clear (current->cap_effective);
+	}
+	if (old_euid != 0 && current->euid == 0) {
+		current->cap_effective = current->cap_permitted;
+	}
+}
+
+int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid,
+			  int flags)
+{
+	switch (flags) {
+	case LSM_SETID_RE:
+	case LSM_SETID_ID:
+	case LSM_SETID_RES:
+		/* Copied from kernel/sys.c:setreuid/setuid/setresuid. */
+		if (!issecure (SECURE_NO_SETUID_FIXUP)) {
+			cap_emulate_setxuid (old_ruid, old_euid, old_suid);
+		}
+		break;
+	case LSM_SETID_FS:
+		{
+			uid_t old_fsuid = old_ruid;
+
+			/* Copied from kernel/sys.c:setfsuid. */
+
+			/*
+			 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
+			 *          if not, we might be a bit too harsh here.
+			 */
+
+			if (!issecure (SECURE_NO_SETUID_FIXUP)) {
+				if (old_fsuid == 0 && current->fsuid != 0) {
+					cap_t (current->cap_effective) &=
+					    ~CAP_FS_MASK;
+				}
+				if (old_fsuid != 0 && current->fsuid == 0) {
+					cap_t (current->cap_effective) |=
+					    (cap_t (current->cap_permitted) &
+					     CAP_FS_MASK);
+				}
+			}
+			break;
+		}
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void cap_task_kmod_set_label (void)
+{
+	cap_set_full (current->cap_effective);
+	return;
+}
+
+void cap_task_reparent_to_init (struct task_struct *p)
+{
+	p->cap_effective = CAP_INIT_EFF_SET;
+	p->cap_inheritable = CAP_INIT_INH_SET;
+	p->cap_permitted = CAP_FULL_SET;
+	p->keep_capabilities = 0;
+	return;
+}
+
+EXPORT_SYMBOL(cap_capable);
+EXPORT_SYMBOL(cap_ptrace);
+EXPORT_SYMBOL(cap_capget);
+EXPORT_SYMBOL(cap_capset_check);
+EXPORT_SYMBOL(cap_capset_set);
+EXPORT_SYMBOL(cap_bprm_set_security);
+EXPORT_SYMBOL(cap_bprm_compute_creds);
+EXPORT_SYMBOL(cap_task_post_setuid);
+EXPORT_SYMBOL(cap_task_kmod_set_label);
+EXPORT_SYMBOL(cap_task_reparent_to_init);
+
+#ifdef CONFIG_SECURITY
+
+static int cap_sys_security (unsigned int id, unsigned int call,
+			     unsigned long *args)
+{
+	return -ENOSYS;
+}
+
+static int cap_quotactl (int cmds, int type, int id, struct super_block *sb)
+{
+	return 0;
+}
+
+static int cap_quota_on (struct file *f)
+{
+	return 0;
+}
+
+static int cap_acct (struct file *file)
+{
+	return 0;
+}
+
+static int cap_bprm_alloc_security (struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static int cap_bprm_check_security (struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static void cap_bprm_free_security (struct linux_binprm *bprm)
+{
+	return;
+}
+
 static int cap_sb_alloc_security (struct super_block *sb)
 {
 	return 0;
@@ -507,96 +618,6 @@
 	return 0;
 }
 
-/* moved from kernel/sys.c. */
-/* 
- * cap_emulate_setxuid() fixes the effective / permitted capabilities of
- * a process after a call to setuid, setreuid, or setresuid.
- *
- *  1) When set*uiding _from_ one of {r,e,s}uid == 0 _to_ all of
- *  {r,e,s}uid != 0, the permitted and effective capabilities are
- *  cleared.
- *
- *  2) When set*uiding _from_ euid == 0 _to_ euid != 0, the effective
- *  capabilities of the process are cleared.
- *
- *  3) When set*uiding _from_ euid != 0 _to_ euid == 0, the effective
- *  capabilities are set to the permitted capabilities.
- *
- *  fsuid is handled elsewhere. fsuid == 0 and {r,e,s}uid!= 0 should 
- *  never happen.
- *
- *  -astor 
- *
- * cevans - New behaviour, Oct '99
- * A process may, via prctl(), elect to keep its capabilities when it
- * calls setuid() and switches away from uid==0. Both permitted and
- * effective sets will be retained.
- * Without this change, it was impossible for a daemon to drop only some
- * of its privilege. The call to setuid(!=0) would drop all privileges!
- * Keeping uid 0 is not an option because uid 0 owns too many vital
- * files..
- * Thanks to Olaf Kirch and Peter Benie for spotting this.
- */
-static inline void cap_emulate_setxuid (int old_ruid, int old_euid,
-					int old_suid)
-{
-	if ((old_ruid == 0 || old_euid == 0 || old_suid == 0) &&
-	    (current->uid != 0 && current->euid != 0 && current->suid != 0) &&
-	    !current->keep_capabilities) {
-		cap_clear (current->cap_permitted);
-		cap_clear (current->cap_effective);
-	}
-	if (old_euid == 0 && current->euid != 0) {
-		cap_clear (current->cap_effective);
-	}
-	if (old_euid != 0 && current->euid == 0) {
-		current->cap_effective = current->cap_permitted;
-	}
-}
-
-static int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid,
-				 int flags)
-{
-	switch (flags) {
-	case LSM_SETID_RE:
-	case LSM_SETID_ID:
-	case LSM_SETID_RES:
-		/* Copied from kernel/sys.c:setreuid/setuid/setresuid. */
-		if (!issecure (SECURE_NO_SETUID_FIXUP)) {
-			cap_emulate_setxuid (old_ruid, old_euid, old_suid);
-		}
-		break;
-	case LSM_SETID_FS:
-		{
-			uid_t old_fsuid = old_ruid;
-
-			/* Copied from kernel/sys.c:setfsuid. */
-
-			/*
-			 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
-			 *          if not, we might be a bit too harsh here.
-			 */
-
-			if (!issecure (SECURE_NO_SETUID_FIXUP)) {
-				if (old_fsuid == 0 && current->fsuid != 0) {
-					cap_t (current->cap_effective) &=
-					    ~CAP_FS_MASK;
-				}
-				if (old_fsuid != 0 && current->fsuid == 0) {
-					cap_t (current->cap_effective) |=
-					    (cap_t (current->cap_permitted) &
-					     CAP_FS_MASK);
-				}
-			}
-			break;
-		}
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int cap_task_setgid (gid_t id0, gid_t id1, gid_t id2, int flags)
 {
 	return 0;
@@ -659,21 +680,6 @@
 	return 0;
 }
 
-static void cap_task_kmod_set_label (void)
-{
-	cap_set_full (current->cap_effective);
-	return;
-}
-
-static void cap_task_reparent_to_init (struct task_struct *p)
-{
-	p->cap_effective = CAP_INIT_EFF_SET;
-	p->cap_inheritable = CAP_INIT_INH_SET;
-	p->cap_permitted = CAP_FULL_SET;
-	p->keep_capabilities = 0;
-	return;
-}
-
 static int cap_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
 {
 	return 0;
@@ -832,6 +838,10 @@
 #define MY_NAME "capability"
 #endif
 
+/* flag to keep track of how we were registered */
+static int secondary;
+
+
 static int __init capability_init (void)
 {
 	/* register ourselves with the security framework */
@@ -871,3 +881,5 @@
 
 MODULE_DESCRIPTION("Standard Linux Capabilities Security Module");
 MODULE_LICENSE("GPL");
+
+#endif	/* CONFIG_SECURITY */
