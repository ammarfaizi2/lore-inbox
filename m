Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbVHYBWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVHYBWo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 21:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbVHYBWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 21:22:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14760 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932473AbVHYBWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 21:22:39 -0400
Message-Id: <20050825012148.690615000@localhost.localdomain>
References: <20050825012028.720597000@localhost.localdomain>
Date: Wed, 24 Aug 2005 18:20:30 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-security-module@wirex.com
Cc: linux-kernel@vger.kernel.org, Kurt Garloff <garloff@suse.de>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH 2/5] Rework stubs in security.h
Content-Disposition: inline; filename=security-reorder-stubs.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Collapse security stubs so that the def'n is done in one spot with ifdef
in function body rather than two separately defined functions.

Patch from Kurt Garloff <garloff@suse.de>, and slightly altered by me to
make all ifdef sites consistent and move the prototype decl's to a sane
spot.

Signed-off-by: Kurt Garloff <garloff@suse.de>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---

 include/linux/security.h | 1410 ++++++++++++++++++++---------------------------
 1 files changed, 609 insertions(+), 801 deletions(-)

Index: lsm-hooks-2.6/include/linux/security.h
===================================================================
--- lsm-hooks-2.6.orig/include/linux/security.h
+++ lsm-hooks-2.6/include/linux/security.h
@@ -1248,10 +1248,27 @@ struct security_operations {
 /* global variables */
 extern struct security_operations *security_ops;
 
-/* inline stuff */
+/* prototypes */
+extern int security_init	(void);
+extern int register_security	(struct security_operations *ops);
+extern int unregister_security	(struct security_operations *ops);
+extern int mod_reg_security	(const char *name, struct security_operations *ops);
+extern int mod_unreg_security	(const char *name, struct security_operations *ops);
+#else
+static inline int security_init(void)
+{
+	return 0;
+}
+#endif	/* CONFIG_SECURITY */
+
 static inline int security_ptrace (struct task_struct * parent, struct task_struct * child)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->ptrace (parent, child);
+#else
+	return cap_ptrace (parent, child);
+#endif
+
 }
 
 static inline int security_capget (struct task_struct *target,
@@ -1259,7 +1281,11 @@ static inline int security_capget (struc
 				   kernel_cap_t *inheritable,
 				   kernel_cap_t *permitted)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->capget (target, effective, inheritable, permitted);
+#else
+	return cap_capget (target, effective, inheritable, permitted);
+#endif
 }
 
 static inline int security_capset_check (struct task_struct *target,
@@ -1267,7 +1293,11 @@ static inline int security_capset_check 
 					 kernel_cap_t *inheritable,
 					 kernel_cap_t *permitted)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->capset_check (target, effective, inheritable, permitted);
+#else
+	return cap_capset_check (target, effective, inheritable, permitted);
+#endif 
 }
 
 static inline void security_capset_set (struct task_struct *target,
@@ -1275,278 +1305,457 @@ static inline void security_capset_set (
 					kernel_cap_t *inheritable,
 					kernel_cap_t *permitted)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->capset_set (target, effective, inheritable, permitted);
+#else
+	cap_capset_set (target, effective, inheritable, permitted);
+#endif
 }
 
 static inline int security_acct (struct file *file)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->acct (file);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_sysctl(struct ctl_table *table, int op)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->sysctl(table, op);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_quotactl (int cmds, int type, int id,
 				     struct super_block *sb)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->quotactl (cmds, type, id, sb);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_quota_on (struct dentry * dentry)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->quota_on (dentry);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_syslog(int type)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->syslog(type);
+#else
+	return cap_syslog(type);
+#endif
 }
 
 static inline int security_settime(struct timespec *ts, struct timezone *tz)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->settime(ts, tz);
+#else
+	return cap_settime(ts, tz);
+#endif
 }
 
-
 static inline int security_vm_enough_memory(long pages)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->vm_enough_memory(pages);
+#else
+	return cap_vm_enough_memory(pages);
+#endif
 }
 
 static inline int security_bprm_alloc (struct linux_binprm *bprm)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->bprm_alloc_security (bprm);
+#else
+	return 0;
+#endif
 }
+
 static inline void security_bprm_free (struct linux_binprm *bprm)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->bprm_free_security (bprm);
+#else
+	return;
+#endif
 }
+
 static inline void security_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->bprm_apply_creds (bprm, unsafe);
+#else
+	cap_bprm_apply_creds (bprm, unsafe);
+#endif
 }
+
 static inline void security_bprm_post_apply_creds (struct linux_binprm *bprm)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->bprm_post_apply_creds (bprm);
+#else
+	return;
+#endif
 }
+
 static inline int security_bprm_set (struct linux_binprm *bprm)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->bprm_set_security (bprm);
+#else
+	return cap_bprm_set_security (bprm);
+#endif
 }
 
 static inline int security_bprm_check (struct linux_binprm *bprm)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->bprm_check_security (bprm);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_bprm_secureexec (struct linux_binprm *bprm)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->bprm_secureexec (bprm);
+#else
+	return cap_bprm_secureexec(bprm);
+#endif
 }
 
 static inline int security_sb_alloc (struct super_block *sb)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->sb_alloc_security (sb);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_sb_free (struct super_block *sb)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->sb_free_security (sb);
+#else
+	return;
+#endif
 }
 
 static inline int security_sb_copy_data (struct file_system_type *type,
 					 void *orig, void *copy)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->sb_copy_data (type, orig, copy);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_sb_kern_mount (struct super_block *sb, void *data)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->sb_kern_mount (sb, data);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_sb_statfs (struct super_block *sb)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->sb_statfs (sb);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_sb_mount (char *dev_name, struct nameidata *nd,
 				    char *type, unsigned long flags,
 				    void *data)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->sb_mount (dev_name, nd, type, flags, data);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_sb_check_sb (struct vfsmount *mnt,
 					struct nameidata *nd)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->sb_check_sb (mnt, nd);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_sb_umount (struct vfsmount *mnt, int flags)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->sb_umount (mnt, flags);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_sb_umount_close (struct vfsmount *mnt)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->sb_umount_close (mnt);
+#else
+	return;
+#endif
 }
 
 static inline void security_sb_umount_busy (struct vfsmount *mnt)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->sb_umount_busy (mnt);
+#else
+	return;
+#endif
 }
 
 static inline void security_sb_post_remount (struct vfsmount *mnt,
 					     unsigned long flags, void *data)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->sb_post_remount (mnt, flags, data);
+#else
+	return;
+#endif
 }
 
 static inline void security_sb_post_mountroot (void)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->sb_post_mountroot ();
+#else
+	return;
+#endif
 }
 
 static inline void security_sb_post_addmount (struct vfsmount *mnt,
 					      struct nameidata *mountpoint_nd)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->sb_post_addmount (mnt, mountpoint_nd);
+#else
+	return;
+#endif
 }
 
 static inline int security_sb_pivotroot (struct nameidata *old_nd,
 					 struct nameidata *new_nd)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->sb_pivotroot (old_nd, new_nd);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_sb_post_pivotroot (struct nameidata *old_nd,
 					       struct nameidata *new_nd)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->sb_post_pivotroot (old_nd, new_nd);
+#else
+	return;
+#endif
 }
 
 static inline int security_inode_alloc (struct inode *inode)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
 	return security_ops->inode_alloc_security (inode);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_inode_free (struct inode *inode)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return;
 	security_ops->inode_free_security (inode);
+#else
+	return;
+#endif
 }
 	
 static inline int security_inode_create (struct inode *dir,
 					 struct dentry *dentry,
 					 int mode)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dir)))
 		return 0;
 	return security_ops->inode_create (dir, dentry, mode);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_inode_post_create (struct inode *dir,
 					       struct dentry *dentry,
 					       int mode)
 {
+#ifdef CONFIG_SECURITY
 	if (dentry->d_inode && unlikely (IS_PRIVATE (dentry->d_inode)))
 		return;
 	security_ops->inode_post_create (dir, dentry, mode);
+#else
+	return;
+#endif
 }
 
 static inline int security_inode_link (struct dentry *old_dentry,
 				       struct inode *dir,
 				       struct dentry *new_dentry)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (old_dentry->d_inode)))
 		return 0;
 	return security_ops->inode_link (old_dentry, dir, new_dentry);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_inode_post_link (struct dentry *old_dentry,
 					     struct inode *dir,
 					     struct dentry *new_dentry)
 {
+#ifdef CONFIG_SECURITY
 	if (new_dentry->d_inode && unlikely (IS_PRIVATE (new_dentry->d_inode)))
 		return;
 	security_ops->inode_post_link (old_dentry, dir, new_dentry);
+#else
+	return;
+#endif
 }
 
 static inline int security_inode_unlink (struct inode *dir,
 					 struct dentry *dentry)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_unlink (dir, dentry);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_inode_symlink (struct inode *dir,
 					  struct dentry *dentry,
 					  const char *old_name)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dir)))
 		return 0;
 	return security_ops->inode_symlink (dir, dentry, old_name);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_inode_post_symlink (struct inode *dir,
 						struct dentry *dentry,
 						const char *old_name)
 {
+#ifdef CONFIG_SECURITY
 	if (dentry->d_inode && unlikely (IS_PRIVATE (dentry->d_inode)))
 		return;
 	security_ops->inode_post_symlink (dir, dentry, old_name);
+#else
+	return;
+#endif
 }
 
 static inline int security_inode_mkdir (struct inode *dir,
 					struct dentry *dentry,
 					int mode)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dir)))
 		return 0;
 	return security_ops->inode_mkdir (dir, dentry, mode);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_inode_post_mkdir (struct inode *dir,
 					      struct dentry *dentry,
 					      int mode)
 {
+#ifdef CONFIG_SECURITY
 	if (dentry->d_inode && unlikely (IS_PRIVATE (dentry->d_inode)))
 		return;
 	security_ops->inode_post_mkdir (dir, dentry, mode);
+#else
+	return;
+#endif
 }
 
 static inline int security_inode_rmdir (struct inode *dir,
 					struct dentry *dentry)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_rmdir (dir, dentry);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_inode_mknod (struct inode *dir,
 					struct dentry *dentry,
 					int mode, dev_t dev)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dir)))
 		return 0;
 	return security_ops->inode_mknod (dir, dentry, mode, dev);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_inode_post_mknod (struct inode *dir,
 					      struct dentry *dentry,
 					      int mode, dev_t dev)
 {
+#ifdef CONFIG_SECURITY
 	if (dentry->d_inode && unlikely (IS_PRIVATE (dentry->d_inode)))
 		return;
 	security_ops->inode_post_mknod (dir, dentry, mode, dev);
+#else
+	return;
+#endif
 }
 
 static inline int security_inode_rename (struct inode *old_dir,
@@ -1554,11 +1763,15 @@ static inline int security_inode_rename 
 					 struct inode *new_dir,
 					 struct dentry *new_dentry)
 {
+#ifdef CONFIG_SECURITY
         if (unlikely (IS_PRIVATE (old_dentry->d_inode) ||
             (new_dentry->d_inode && IS_PRIVATE (new_dentry->d_inode))))
 		return 0;
 	return security_ops->inode_rename (old_dir, old_dentry,
 					   new_dir, new_dentry);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_inode_post_rename (struct inode *old_dir,
@@ -1566,265 +1779,433 @@ static inline void security_inode_post_r
 					       struct inode *new_dir,
 					       struct dentry *new_dentry)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (old_dentry->d_inode) ||
 	    (new_dentry->d_inode && IS_PRIVATE (new_dentry->d_inode))))
 		return;
 	security_ops->inode_post_rename (old_dir, old_dentry,
 						new_dir, new_dentry);
+#else
+	return;
+#endif
 }
 
 static inline int security_inode_readlink (struct dentry *dentry)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_readlink (dentry);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_inode_follow_link (struct dentry *dentry,
 					      struct nameidata *nd)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_follow_link (dentry, nd);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_inode_permission (struct inode *inode, int mask,
 					     struct nameidata *nd)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
 	return security_ops->inode_permission (inode, mask, nd);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_inode_setattr (struct dentry *dentry,
 					  struct iattr *attr)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_setattr (dentry, attr);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_inode_getattr (struct vfsmount *mnt,
 					  struct dentry *dentry)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_getattr (mnt, dentry);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_inode_delete (struct inode *inode)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return;
 	security_ops->inode_delete (inode);
+#else
+	return;
+#endif
 }
 
 static inline int security_inode_setxattr (struct dentry *dentry, char *name,
 					   void *value, size_t size, int flags)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_setxattr (dentry, name, value, size, flags);
+#else
+	return cap_inode_setxattr(dentry, name, value, size, flags);
+#endif
 }
 
 static inline void security_inode_post_setxattr (struct dentry *dentry, char *name,
 						void *value, size_t size, int flags)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return;
 	security_ops->inode_post_setxattr (dentry, name, value, size, flags);
+#else
+	return;
+#endif
 }
 
 static inline int security_inode_getxattr (struct dentry *dentry, char *name)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_getxattr (dentry, name);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_inode_listxattr (struct dentry *dentry)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_listxattr (dentry);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_inode_removexattr (struct dentry *dentry, char *name)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
 	return security_ops->inode_removexattr (dentry, name);
+#else
+	return cap_inode_removexattr(dentry, name);
+#endif
 }
 
 static inline int security_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
 	return security_ops->inode_getsecurity(inode, name, buffer, size);
+#else
+	return -EOPNOTSUPP;
+#endif
 }
 
 static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
 	return security_ops->inode_setsecurity(inode, name, value, size, flags);
+#else
+	return -EOPNOTSUPP;
+#endif
 }
 
 static inline int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
 	return security_ops->inode_listsecurity(inode, buffer, buffer_size);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_file_permission (struct file *file, int mask)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->file_permission (file, mask);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_file_alloc (struct file *file)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->file_alloc_security (file);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_file_free (struct file *file)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->file_free_security (file);
+#else
+	return;
+#endif
 }
 
 static inline int security_file_ioctl (struct file *file, unsigned int cmd,
 				       unsigned long arg)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->file_ioctl (file, cmd, arg);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_file_mmap (struct file *file, unsigned long reqprot,
 				      unsigned long prot,
 				      unsigned long flags)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->file_mmap (file, reqprot, prot, flags);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_file_mprotect (struct vm_area_struct *vma,
 					  unsigned long reqprot,
 					  unsigned long prot)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->file_mprotect (vma, reqprot, prot);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_file_lock (struct file *file, unsigned int cmd)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->file_lock (file, cmd);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_file_fcntl (struct file *file, unsigned int cmd,
 				       unsigned long arg)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->file_fcntl (file, cmd, arg);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_file_set_fowner (struct file *file)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->file_set_fowner (file);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_file_send_sigiotask (struct task_struct *tsk,
 						struct fown_struct *fown,
 						int sig)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->file_send_sigiotask (tsk, fown, sig);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_file_receive (struct file *file)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->file_receive (file);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_task_create (unsigned long clone_flags)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->task_create (clone_flags);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_task_alloc (struct task_struct *p)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->task_alloc_security (p);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_task_free (struct task_struct *p)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->task_free_security (p);
+#else
+	return;
+#endif
 }
 
 static inline int security_task_setuid (uid_t id0, uid_t id1, uid_t id2,
 					int flags)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->task_setuid (id0, id1, id2, flags);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_task_post_setuid (uid_t old_ruid, uid_t old_euid,
 					     uid_t old_suid, int flags)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->task_post_setuid (old_ruid, old_euid, old_suid, flags);
+#else
+	return cap_task_post_setuid (old_ruid, old_euid, old_suid, flags);
+#endif
 }
 
 static inline int security_task_setgid (gid_t id0, gid_t id1, gid_t id2,
 					int flags)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->task_setgid (id0, id1, id2, flags);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_task_setpgid (struct task_struct *p, pid_t pgid)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->task_setpgid (p, pgid);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_task_getpgid (struct task_struct *p)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->task_getpgid (p);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_task_getsid (struct task_struct *p)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->task_getsid (p);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_task_setgroups (struct group_info *group_info)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->task_setgroups (group_info);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_task_setnice (struct task_struct *p, int nice)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->task_setnice (p, nice);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_task_setrlimit (unsigned int resource,
 					   struct rlimit *new_rlim)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->task_setrlimit (resource, new_rlim);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_task_setscheduler (struct task_struct *p,
 					      int policy,
 					      struct sched_param *lp)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->task_setscheduler (p, policy, lp);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_task_getscheduler (struct task_struct *p)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->task_getscheduler (p);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_task_kill (struct task_struct *p,
 				      struct siginfo *info, int sig)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->task_kill (p, info, sig);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_task_wait (struct task_struct *p)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->task_wait (p);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_task_prctl (int option, unsigned long arg2,
@@ -1832,60 +2213,104 @@ static inline int security_task_prctl (i
 				       unsigned long arg4,
 				       unsigned long arg5)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->task_prctl (option, arg2, arg3, arg4, arg5);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_task_reparent_to_init (struct task_struct *p)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->task_reparent_to_init (p);
+#else
+	cap_task_reparent_to_init (p);
+#endif
 }
 
 static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->task_to_inode(p, inode);
+#else
+	return;
+#endif
 }
 
 static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
 					   short flag)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->ipc_permission (ipcp, flag);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_msg_msg_alloc (struct msg_msg * msg)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->msg_msg_alloc_security (msg);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_msg_msg_free (struct msg_msg * msg)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->msg_msg_free_security(msg);
+#else
+	return;
+#endif
 }
 
 static inline int security_msg_queue_alloc (struct msg_queue *msq)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->msg_queue_alloc_security (msq);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_msg_queue_free (struct msg_queue *msq)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->msg_queue_free_security (msq);
+#else
+	return;
+#endif
 }
 
 static inline int security_msg_queue_associate (struct msg_queue * msq, 
 						int msqflg)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->msg_queue_associate (msq, msqflg);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_msg_queue_msgctl (struct msg_queue * msq, int cmd)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->msg_queue_msgctl (msq, cmd);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_msg_queue_msgsnd (struct msg_queue * msq,
 					     struct msg_msg * msg, int msqflg)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->msg_queue_msgsnd (msq, msg, msqflg);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_msg_queue_msgrcv (struct msg_queue * msq,
@@ -1893,966 +2318,354 @@ static inline int security_msg_queue_msg
 					     struct task_struct * target,
 					     long type, int mode)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->msg_queue_msgrcv (msq, msg, target, type, mode);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_shm_alloc (struct shmid_kernel *shp)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->shm_alloc_security (shp);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_shm_free (struct shmid_kernel *shp)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->shm_free_security (shp);
+#else
+	return;
+#endif
 }
 
 static inline int security_shm_associate (struct shmid_kernel * shp, 
 					  int shmflg)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->shm_associate(shp, shmflg);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_shm_shmctl (struct shmid_kernel * shp, int cmd)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->shm_shmctl (shp, cmd);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_shm_shmat (struct shmid_kernel * shp, 
 				      char __user *shmaddr, int shmflg)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->shm_shmat(shp, shmaddr, shmflg);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_sem_alloc (struct sem_array *sma)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->sem_alloc_security (sma);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_sem_free (struct sem_array *sma)
 {
+#ifdef CONFIG_SECURITY
 	security_ops->sem_free_security (sma);
+#else
+	return;
+#endif
 }
 
 static inline int security_sem_associate (struct sem_array * sma, int semflg)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->sem_associate (sma, semflg);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_sem_semctl (struct sem_array * sma, int cmd)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->sem_semctl(sma, cmd);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_sem_semop (struct sem_array * sma, 
 				      struct sembuf * sops, unsigned nsops, 
 				      int alter)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->sem_semop(sma, sops, nsops, alter);
+#else
+	return 0;
+#endif
 }
 
 static inline void security_d_instantiate (struct dentry *dentry, struct inode *inode)
 {
+#ifdef CONFIG_SECURITY
 	if (unlikely (inode && IS_PRIVATE (inode)))
 		return;
 	security_ops->d_instantiate (dentry, inode);
+#else
+	return;
+#endif
 }
 
 static inline int security_getprocattr(struct task_struct *p, char *name, void *value, size_t size)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->getprocattr(p, name, value, size);
+#else
+	return -EINVAL;
+#endif
 }
 
 static inline int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->setprocattr(p, name, value, size);
+#else
+	return -EINVAL;
+#endif
 }
 
 static inline int security_netlink_send(struct sock *sk, struct sk_buff * skb)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->netlink_send(sk, skb);
+#else
+	return cap_netlink_send (sk, skb);
+#endif
 }
 
 static inline int security_netlink_recv(struct sk_buff * skb)
 {
+#ifdef CONFIG_SECURITY
 	return security_ops->netlink_recv(skb);
+#else
+	return cap_netlink_recv (skb);
+#endif
 }
 
-/* prototypes */
-extern int security_init	(void);
-extern int register_security	(struct security_operations *ops);
-extern int unregister_security	(struct security_operations *ops);
-extern int mod_reg_security	(const char *name, struct security_operations *ops);
-extern int mod_unreg_security	(const char *name, struct security_operations *ops);
-
-
-#else /* CONFIG_SECURITY */
-
-/*
- * This is the default capabilities functionality.  Most of these functions
- * are just stubbed out, but a few must call the proper capable code.
- */
-
-static inline int security_init(void)
+static inline int security_unix_stream_connect(struct socket * sock,
+					       struct socket * other, 
+					       struct sock * newsk)
 {
+#ifdef CONFIG_SECURITY_NETWORK
+	return security_ops->unix_stream_connect(sock, other, newsk);
+#else
 	return 0;
+#endif
 }
 
-static inline int security_ptrace (struct task_struct *parent, struct task_struct * child)
-{
-	return cap_ptrace (parent, child);
-}
 
-static inline int security_capget (struct task_struct *target,
-				   kernel_cap_t *effective,
-				   kernel_cap_t *inheritable,
-				   kernel_cap_t *permitted)
+static inline int security_unix_may_send(struct socket * sock, 
+					 struct socket * other)
 {
-	return cap_capget (target, effective, inheritable, permitted);
+#ifdef CONFIG_SECURITY_NETWORK
+	return security_ops->unix_may_send(sock, other);
+#else
+	return 0;
+#endif
 }
 
-static inline int security_capset_check (struct task_struct *target,
-					 kernel_cap_t *effective,
-					 kernel_cap_t *inheritable,
-					 kernel_cap_t *permitted)
+static inline int security_socket_create (int family, int type,
+					  int protocol, int kern)
 {
-	return cap_capset_check (target, effective, inheritable, permitted);
+#ifdef CONFIG_SECURITY_NETWORK
+	return security_ops->socket_create(family, type, protocol, kern);
+#else
+	return 0;
+#endif
 }
 
-static inline void security_capset_set (struct task_struct *target,
-					kernel_cap_t *effective,
-					kernel_cap_t *inheritable,
-					kernel_cap_t *permitted)
+static inline void security_socket_post_create(struct socket * sock, 
+					       int family,
+					       int type, 
+					       int protocol, int kern)
 {
-	cap_capset_set (target, effective, inheritable, permitted);
+#ifdef CONFIG_SECURITY_NETWORK
+	security_ops->socket_post_create(sock, family, type,
+					 protocol, kern);
+#else
+	return;
+#endif
 }
 
-static inline int security_acct (struct file *file)
+static inline int security_socket_bind(struct socket * sock, 
+				       struct sockaddr * address, 
+				       int addrlen)
 {
+#ifdef CONFIG_SECURITY_NETWORK
+	return security_ops->socket_bind(sock, address, addrlen);
+#else
 	return 0;
+#endif
 }
 
-static inline int security_sysctl(struct ctl_table *table, int op)
+static inline int security_socket_connect(struct socket * sock, 
+					  struct sockaddr * address, 
+					  int addrlen)
 {
+#ifdef CONFIG_SECURITY_NETWORK
+	return security_ops->socket_connect(sock, address, addrlen);
+#else
 	return 0;
+#endif
 }
 
-static inline int security_quotactl (int cmds, int type, int id,
-				     struct super_block * sb)
+static inline int security_socket_listen(struct socket * sock, int backlog)
 {
+#ifdef CONFIG_SECURITY_NETWORK
+	return security_ops->socket_listen(sock, backlog);
+#else
 	return 0;
+#endif
 }
 
-static inline int security_quota_on (struct dentry * dentry)
+static inline int security_socket_accept(struct socket * sock, 
+					 struct socket * newsock)
 {
+#ifdef CONFIG_SECURITY_NETWORK
+	return security_ops->socket_accept(sock, newsock);
+#else
 	return 0;
+#endif
 }
 
-static inline int security_syslog(int type)
+static inline void security_socket_post_accept(struct socket * sock, 
+					       struct socket * newsock)
 {
-	return cap_syslog(type);
+#ifdef CONFIG_SECURITY_NETWORK
+	security_ops->socket_post_accept(sock, newsock);
+#else
+	return;
+#endif
 }
 
-static inline int security_settime(struct timespec *ts, struct timezone *tz)
+static inline int security_socket_sendmsg(struct socket * sock, 
+					  struct msghdr * msg, int size)
 {
-	return cap_settime(ts, tz);
+#ifdef CONFIG_SECURITY_NETWORK
+	return security_ops->socket_sendmsg(sock, msg, size);
+#else
+	return 0;
+#endif
 }
 
-static inline int security_vm_enough_memory(long pages)
+static inline int security_socket_recvmsg(struct socket * sock, 
+					  struct msghdr * msg, int size, 
+					  int flags)
 {
-	return cap_vm_enough_memory(pages);
+#ifdef CONFIG_SECURITY_NETWORK
+	return security_ops->socket_recvmsg(sock, msg, size, flags);
+#else
+	return 0;
+#endif
 }
 
-static inline int security_bprm_alloc (struct linux_binprm *bprm)
+static inline int security_socket_getsockname(struct socket * sock)
 {
+#ifdef CONFIG_SECURITY_NETWORK
+	return security_ops->socket_getsockname(sock);
+#else
 	return 0;
+#endif
 }
 
-static inline void security_bprm_free (struct linux_binprm *bprm)
-{ }
-
-static inline void security_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
-{ 
-	cap_bprm_apply_creds (bprm, unsafe);
-}
-
-static inline void security_bprm_post_apply_creds (struct linux_binprm *bprm)
+static inline int security_socket_getpeername(struct socket * sock)
 {
-	return;
-}
-
-static inline int security_bprm_set (struct linux_binprm *bprm)
-{
-	return cap_bprm_set_security (bprm);
-}
-
-static inline int security_bprm_check (struct linux_binprm *bprm)
-{
-	return 0;
-}
-
-static inline int security_bprm_secureexec (struct linux_binprm *bprm)
-{
-	return cap_bprm_secureexec(bprm);
-}
-
-static inline int security_sb_alloc (struct super_block *sb)
-{
-	return 0;
-}
-
-static inline void security_sb_free (struct super_block *sb)
-{ }
-
-static inline int security_sb_copy_data (struct file_system_type *type,
-					 void *orig, void *copy)
-{
-	return 0;
-}
-
-static inline int security_sb_kern_mount (struct super_block *sb, void *data)
-{
-	return 0;
-}
-
-static inline int security_sb_statfs (struct super_block *sb)
-{
-	return 0;
-}
-
-static inline int security_sb_mount (char *dev_name, struct nameidata *nd,
-				    char *type, unsigned long flags,
-				    void *data)
-{
-	return 0;
-}
-
-static inline int security_sb_check_sb (struct vfsmount *mnt,
-					struct nameidata *nd)
-{
-	return 0;
-}
-
-static inline int security_sb_umount (struct vfsmount *mnt, int flags)
-{
-	return 0;
-}
-
-static inline void security_sb_umount_close (struct vfsmount *mnt)
-{ }
-
-static inline void security_sb_umount_busy (struct vfsmount *mnt)
-{ }
-
-static inline void security_sb_post_remount (struct vfsmount *mnt,
-					     unsigned long flags, void *data)
-{ }
-
-static inline void security_sb_post_mountroot (void)
-{ }
-
-static inline void security_sb_post_addmount (struct vfsmount *mnt,
-					      struct nameidata *mountpoint_nd)
-{ }
-
-static inline int security_sb_pivotroot (struct nameidata *old_nd,
-					 struct nameidata *new_nd)
-{
-	return 0;
-}
-
-static inline void security_sb_post_pivotroot (struct nameidata *old_nd,
-					       struct nameidata *new_nd)
-{ }
-
-static inline int security_inode_alloc (struct inode *inode)
-{
-	return 0;
-}
-
-static inline void security_inode_free (struct inode *inode)
-{ }
-	
-static inline int security_inode_create (struct inode *dir,
-					 struct dentry *dentry,
-					 int mode)
-{
-	return 0;
-}
-
-static inline void security_inode_post_create (struct inode *dir,
-					       struct dentry *dentry,
-					       int mode)
-{ }
-
-static inline int security_inode_link (struct dentry *old_dentry,
-				       struct inode *dir,
-				       struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static inline void security_inode_post_link (struct dentry *old_dentry,
-					     struct inode *dir,
-					     struct dentry *new_dentry)
-{ }
-
-static inline int security_inode_unlink (struct inode *dir,
-					 struct dentry *dentry)
-{
-	return 0;
-}
-
-static inline int security_inode_symlink (struct inode *dir,
-					  struct dentry *dentry,
-					  const char *old_name)
-{
-	return 0;
-}
-
-static inline void security_inode_post_symlink (struct inode *dir,
-						struct dentry *dentry,
-						const char *old_name)
-{ }
-
-static inline int security_inode_mkdir (struct inode *dir,
-					struct dentry *dentry,
-					int mode)
-{
-	return 0;
-}
-
-static inline void security_inode_post_mkdir (struct inode *dir,
-					      struct dentry *dentry,
-					      int mode)
-{ }
-
-static inline int security_inode_rmdir (struct inode *dir,
-					struct dentry *dentry)
-{
-	return 0;
-}
-
-static inline int security_inode_mknod (struct inode *dir,
-					struct dentry *dentry,
-					int mode, dev_t dev)
-{
-	return 0;
-}
-
-static inline void security_inode_post_mknod (struct inode *dir,
-					      struct dentry *dentry,
-					      int mode, dev_t dev)
-{ }
-
-static inline int security_inode_rename (struct inode *old_dir,
-					 struct dentry *old_dentry,
-					 struct inode *new_dir,
-					 struct dentry *new_dentry)
-{
-	return 0;
-}
-
-static inline void security_inode_post_rename (struct inode *old_dir,
-					       struct dentry *old_dentry,
-					       struct inode *new_dir,
-					       struct dentry *new_dentry)
-{ }
-
-static inline int security_inode_readlink (struct dentry *dentry)
-{
-	return 0;
-}
-
-static inline int security_inode_follow_link (struct dentry *dentry,
-					      struct nameidata *nd)
-{
-	return 0;
-}
-
-static inline int security_inode_permission (struct inode *inode, int mask,
-					     struct nameidata *nd)
-{
-	return 0;
-}
-
-static inline int security_inode_setattr (struct dentry *dentry,
-					  struct iattr *attr)
-{
-	return 0;
-}
-
-static inline int security_inode_getattr (struct vfsmount *mnt,
-					  struct dentry *dentry)
-{
-	return 0;
-}
-
-static inline void security_inode_delete (struct inode *inode)
-{ }
-
-static inline int security_inode_setxattr (struct dentry *dentry, char *name,
-					   void *value, size_t size, int flags)
-{
-	return cap_inode_setxattr(dentry, name, value, size, flags);
-}
-
-static inline void security_inode_post_setxattr (struct dentry *dentry, char *name,
-						 void *value, size_t size, int flags)
-{ }
-
-static inline int security_inode_getxattr (struct dentry *dentry, char *name)
-{
-	return 0;
-}
-
-static inline int security_inode_listxattr (struct dentry *dentry)
-{
-	return 0;
-}
-
-static inline int security_inode_removexattr (struct dentry *dentry, char *name)
-{
-	return cap_inode_removexattr(dentry, name);
-}
-
-static inline int security_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size)
-{
-	return 0;
-}
-
-static inline int security_file_permission (struct file *file, int mask)
-{
-	return 0;
-}
-
-static inline int security_file_alloc (struct file *file)
-{
-	return 0;
-}
-
-static inline void security_file_free (struct file *file)
-{ }
-
-static inline int security_file_ioctl (struct file *file, unsigned int cmd,
-				       unsigned long arg)
-{
-	return 0;
-}
-
-static inline int security_file_mmap (struct file *file, unsigned long reqprot,
-				      unsigned long prot,
-				      unsigned long flags)
-{
-	return 0;
-}
-
-static inline int security_file_mprotect (struct vm_area_struct *vma,
-					  unsigned long reqprot,
-					  unsigned long prot)
-{
-	return 0;
-}
-
-static inline int security_file_lock (struct file *file, unsigned int cmd)
-{
-	return 0;
-}
-
-static inline int security_file_fcntl (struct file *file, unsigned int cmd,
-				       unsigned long arg)
-{
-	return 0;
-}
-
-static inline int security_file_set_fowner (struct file *file)
-{
-	return 0;
-}
-
-static inline int security_file_send_sigiotask (struct task_struct *tsk,
-						struct fown_struct *fown,
-						int sig)
-{
-	return 0;
-}
-
-static inline int security_file_receive (struct file *file)
-{
-	return 0;
-}
-
-static inline int security_task_create (unsigned long clone_flags)
-{
-	return 0;
-}
-
-static inline int security_task_alloc (struct task_struct *p)
-{
-	return 0;
-}
-
-static inline void security_task_free (struct task_struct *p)
-{ }
-
-static inline int security_task_setuid (uid_t id0, uid_t id1, uid_t id2,
-					int flags)
-{
-	return 0;
-}
-
-static inline int security_task_post_setuid (uid_t old_ruid, uid_t old_euid,
-					     uid_t old_suid, int flags)
-{
-	return cap_task_post_setuid (old_ruid, old_euid, old_suid, flags);
-}
-
-static inline int security_task_setgid (gid_t id0, gid_t id1, gid_t id2,
-					int flags)
-{
-	return 0;
-}
-
-static inline int security_task_setpgid (struct task_struct *p, pid_t pgid)
-{
-	return 0;
-}
-
-static inline int security_task_getpgid (struct task_struct *p)
-{
-	return 0;
-}
-
-static inline int security_task_getsid (struct task_struct *p)
-{
-	return 0;
-}
-
-static inline int security_task_setgroups (struct group_info *group_info)
-{
-	return 0;
-}
-
-static inline int security_task_setnice (struct task_struct *p, int nice)
-{
-	return 0;
-}
-
-static inline int security_task_setrlimit (unsigned int resource,
-					   struct rlimit *new_rlim)
-{
-	return 0;
-}
-
-static inline int security_task_setscheduler (struct task_struct *p,
-					      int policy,
-					      struct sched_param *lp)
-{
-	return 0;
-}
-
-static inline int security_task_getscheduler (struct task_struct *p)
-{
-	return 0;
-}
-
-static inline int security_task_kill (struct task_struct *p,
-				      struct siginfo *info, int sig)
-{
-	return 0;
-}
-
-static inline int security_task_wait (struct task_struct *p)
-{
-	return 0;
-}
-
-static inline int security_task_prctl (int option, unsigned long arg2,
-				       unsigned long arg3,
-				       unsigned long arg4,
-				       unsigned long arg5)
-{
-	return 0;
-}
-
-static inline void security_task_reparent_to_init (struct task_struct *p)
-{
-	cap_task_reparent_to_init (p);
-}
-
-static inline void security_task_to_inode(struct task_struct *p, struct inode *inode)
-{ }
-
-static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
-					   short flag)
-{
-	return 0;
-}
-
-static inline int security_msg_msg_alloc (struct msg_msg * msg)
-{
-	return 0;
-}
-
-static inline void security_msg_msg_free (struct msg_msg * msg)
-{ }
-
-static inline int security_msg_queue_alloc (struct msg_queue *msq)
-{
-	return 0;
-}
-
-static inline void security_msg_queue_free (struct msg_queue *msq)
-{ }
-
-static inline int security_msg_queue_associate (struct msg_queue * msq, 
-						int msqflg)
-{
-	return 0;
-}
-
-static inline int security_msg_queue_msgctl (struct msg_queue * msq, int cmd)
-{
-	return 0;
-}
-
-static inline int security_msg_queue_msgsnd (struct msg_queue * msq,
-					     struct msg_msg * msg, int msqflg)
-{
-	return 0;
-}
-
-static inline int security_msg_queue_msgrcv (struct msg_queue * msq,
-					     struct msg_msg * msg,
-					     struct task_struct * target,
-					     long type, int mode)
-{
-	return 0;
-}
-
-static inline int security_shm_alloc (struct shmid_kernel *shp)
-{
-	return 0;
-}
-
-static inline void security_shm_free (struct shmid_kernel *shp)
-{ }
-
-static inline int security_shm_associate (struct shmid_kernel * shp, 
-					  int shmflg)
-{
-	return 0;
-}
-
-static inline int security_shm_shmctl (struct shmid_kernel * shp, int cmd)
-{
-	return 0;
-}
-
-static inline int security_shm_shmat (struct shmid_kernel * shp, 
-				      char __user *shmaddr, int shmflg)
-{
-	return 0;
-}
-
-static inline int security_sem_alloc (struct sem_array *sma)
-{
-	return 0;
-}
-
-static inline void security_sem_free (struct sem_array *sma)
-{ }
-
-static inline int security_sem_associate (struct sem_array * sma, int semflg)
-{
-	return 0;
-}
-
-static inline int security_sem_semctl (struct sem_array * sma, int cmd)
-{
-	return 0;
-}
-
-static inline int security_sem_semop (struct sem_array * sma, 
-				      struct sembuf * sops, unsigned nsops, 
-				      int alter)
-{
-	return 0;
-}
-
-static inline void security_d_instantiate (struct dentry *dentry, struct inode *inode)
-{ }
-
-static inline int security_getprocattr(struct task_struct *p, char *name, void *value, size_t size)
-{
-	return -EINVAL;
-}
-
-static inline int security_setprocattr(struct task_struct *p, char *name, void *value, size_t size)
-{
-	return -EINVAL;
-}
-
-static inline int security_netlink_send (struct sock *sk, struct sk_buff *skb)
-{
-	return cap_netlink_send (sk, skb);
-}
-
-static inline int security_netlink_recv (struct sk_buff *skb)
-{
-	return cap_netlink_recv (skb);
-}
-
-#endif	/* CONFIG_SECURITY */
-
-#ifdef CONFIG_SECURITY_NETWORK
-static inline int security_unix_stream_connect(struct socket * sock,
-					       struct socket * other, 
-					       struct sock * newsk)
-{
-	return security_ops->unix_stream_connect(sock, other, newsk);
-}
-
-
-static inline int security_unix_may_send(struct socket * sock, 
-					 struct socket * other)
-{
-	return security_ops->unix_may_send(sock, other);
-}
-
-static inline int security_socket_create (int family, int type,
-					  int protocol, int kern)
-{
-	return security_ops->socket_create(family, type, protocol, kern);
-}
-
-static inline void security_socket_post_create(struct socket * sock, 
-					       int family,
-					       int type, 
-					       int protocol, int kern)
-{
-	security_ops->socket_post_create(sock, family, type,
-					 protocol, kern);
-}
-
-static inline int security_socket_bind(struct socket * sock, 
-				       struct sockaddr * address, 
-				       int addrlen)
-{
-	return security_ops->socket_bind(sock, address, addrlen);
-}
-
-static inline int security_socket_connect(struct socket * sock, 
-					  struct sockaddr * address, 
-					  int addrlen)
-{
-	return security_ops->socket_connect(sock, address, addrlen);
-}
-
-static inline int security_socket_listen(struct socket * sock, int backlog)
-{
-	return security_ops->socket_listen(sock, backlog);
-}
-
-static inline int security_socket_accept(struct socket * sock, 
-					 struct socket * newsock)
-{
-	return security_ops->socket_accept(sock, newsock);
-}
-
-static inline void security_socket_post_accept(struct socket * sock, 
-					       struct socket * newsock)
-{
-	security_ops->socket_post_accept(sock, newsock);
-}
-
-static inline int security_socket_sendmsg(struct socket * sock, 
-					  struct msghdr * msg, int size)
-{
-	return security_ops->socket_sendmsg(sock, msg, size);
-}
-
-static inline int security_socket_recvmsg(struct socket * sock, 
-					  struct msghdr * msg, int size, 
-					  int flags)
-{
-	return security_ops->socket_recvmsg(sock, msg, size, flags);
-}
-
-static inline int security_socket_getsockname(struct socket * sock)
-{
-	return security_ops->socket_getsockname(sock);
-}
-
-static inline int security_socket_getpeername(struct socket * sock)
-{
-	return security_ops->socket_getpeername(sock);
+#ifdef CONFIG_SECURITY_NETWORK
+	return security_ops->socket_getpeername(sock);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_socket_getsockopt(struct socket * sock, 
 					     int level, int optname)
 {
+#ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_getsockopt(sock, level, optname);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_socket_setsockopt(struct socket * sock, 
 					     int level, int optname)
 {
+#ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_setsockopt(sock, level, optname);
+#else
+	return 0;
+#endif
 }
 
 static inline int security_socket_shutdown(struct socket * sock, int how)
 {
+#ifdef CONFIG_SECURITY_NETWORK
 	return security_ops->socket_shutdown(sock, how);
-}
-
-static inline int security_sock_rcv_skb (struct sock * sk, 
-					 struct sk_buff * skb)
-{
-	return security_ops->socket_sock_rcv_skb (sk, skb);
-}
-
-static inline int security_socket_getpeersec(struct socket *sock, char __user *optval,
-					     int __user *optlen, unsigned len)
-{
-	return security_ops->socket_getpeersec(sock, optval, optlen, len);
-}
-
-static inline int security_sk_alloc(struct sock *sk, int family, int priority)
-{
-	return security_ops->sk_alloc_security(sk, family, priority);
-}
-
-static inline void security_sk_free(struct sock *sk)
-{
-	return security_ops->sk_free_security(sk);
-}
-#else	/* CONFIG_SECURITY_NETWORK */
-static inline int security_unix_stream_connect(struct socket * sock,
-					       struct socket * other, 
-					       struct sock * newsk)
-{
-	return 0;
-}
-
-static inline int security_unix_may_send(struct socket * sock, 
-					 struct socket * other)
-{
-	return 0;
-}
-
-static inline int security_socket_create (int family, int type,
-					  int protocol, int kern)
-{
-	return 0;
-}
-
-static inline void security_socket_post_create(struct socket * sock, 
-					       int family,
-					       int type, 
-					       int protocol, int kern)
-{
-}
-
-static inline int security_socket_bind(struct socket * sock, 
-				       struct sockaddr * address, 
-				       int addrlen)
-{
-	return 0;
-}
-
-static inline int security_socket_connect(struct socket * sock, 
-					  struct sockaddr * address, 
-					  int addrlen)
-{
-	return 0;
-}
-
-static inline int security_socket_listen(struct socket * sock, int backlog)
-{
-	return 0;
-}
-
-static inline int security_socket_accept(struct socket * sock, 
-					 struct socket * newsock)
-{
-	return 0;
-}
-
-static inline void security_socket_post_accept(struct socket * sock, 
-					       struct socket * newsock)
-{
-}
-
-static inline int security_socket_sendmsg(struct socket * sock, 
-					  struct msghdr * msg, int size)
-{
-	return 0;
-}
-
-static inline int security_socket_recvmsg(struct socket * sock, 
-					  struct msghdr * msg, int size, 
-					  int flags)
-{
-	return 0;
-}
-
-static inline int security_socket_getsockname(struct socket * sock)
-{
-	return 0;
-}
-
-static inline int security_socket_getpeername(struct socket * sock)
-{
-	return 0;
-}
-
-static inline int security_socket_getsockopt(struct socket * sock, 
-					     int level, int optname)
-{
-	return 0;
-}
-
-static inline int security_socket_setsockopt(struct socket * sock, 
-					     int level, int optname)
-{
+#else
 	return 0;
+#endif
 }
 
-static inline int security_socket_shutdown(struct socket * sock, int how)
-{
-	return 0;
-}
 static inline int security_sock_rcv_skb (struct sock * sk, 
 					 struct sk_buff * skb)
 {
+#ifdef CONFIG_SECURITY_NETWORK
+	return security_ops->socket_sock_rcv_skb (sk, skb);
+#else
 	return 0;
+#endif
 }
 
 static inline int security_socket_getpeersec(struct socket *sock, char __user *optval,
 					     int __user *optlen, unsigned len)
 {
+#ifdef CONFIG_SECURITY_NETWORK
+	return security_ops->socket_getpeersec(sock, optval, optlen, len);
+#else
 	return -ENOPROTOOPT;
+#endif
 }
 
 static inline int security_sk_alloc(struct sock *sk, int family, int priority)
 {
+#ifdef CONFIG_SECURITY_NETWORK
+	return security_ops->sk_alloc_security(sk, family, priority);
+#else
 	return 0;
+#endif
 }
 
 static inline void security_sk_free(struct sock *sk)
 {
+#ifdef CONFIG_SECURITY_NETWORK
+	return security_ops->sk_free_security(sk);
+#else
+	return;
+#endif
 }
-#endif	/* CONFIG_SECURITY_NETWORK */
-
-#endif /* ! __LINUX_SECURITY_H */
 
+#endif /* __LINUX_SECURITY_H */

--
