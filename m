Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVBOFup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVBOFup (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 00:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVBOFup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 00:50:45 -0500
Received: from mail.suse.de ([195.135.220.2]:63134 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261629AbVBOFqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 00:46:46 -0500
Date: Tue, 15 Feb 2005 06:45:56 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH] New 2/5: LSM hooks rework
Message-ID: <20050215054556.GQ18744@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
References: <20050213210515.GH27893@tpkurt.garloff.de> <20050213211034.GI27893@tpkurt.garloff.de> <20050213211109.GJ27893@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FbmEh7Ek6NM6xKh/"
Content-Disposition: inline
In-Reply-To: <20050213211109.GJ27893@tpkurt.garloff.de>
X-Operating-System: Linux 2.6.11-rc4-20050214001414-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FbmEh7Ek6NM6xKh/
Content-Type: multipart/mixed; boundary="GPOl6LAGMgeiWDic"
Content-Disposition: inline


--GPOl6LAGMgeiWDic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 13, 2005 at 04:11:09PM -0500, Kurt Garloff wrote:
> From: Kurt Garloff <garloff@suse.de>
> Subject: Clean LSM stub file
[...]

So, for convenience, I merged Andreas' fix on top
of this patch into a new patch 2, which is attached.
So CONFIG_SECURITY_NETWORK disabled should work again.

Regards,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--GPOl6LAGMgeiWDic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=security-clean-stubs2
Content-Transfer-Encoding: quoted-printable

=46rom: Kurt Garloff <garloff@suse.de>
Subject: Clean LSM stub file
References: 40217, 39439

Rather than having every LSM hook twice, once for the case with
CONFIG_SECURITY enabled and once for the disabled case, put
everything in one inline function. This reduces the chance of
the two to go out of sync immensely.

This is patch 2/5 of the LSM overhaul.

 security.h | 1274 ++++++++++++++++----------------------------------------=
-----
 1 files changed, 342 insertions(+), 932 deletions(-)

Signed-off-by: Kurt Garloff <garloff@suse.de>

Index: linux-2.6.10/include/linux/security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.10.orig/include/linux/security.h
+++ linux-2.6.10/include/linux/security.h
@@ -1242,1544 +1242,954 @@ struct security_operations {
=20
 /* global variables */
 extern struct security_operations *security_ops;
=20
+/* prototypes */
+extern int security_init	(void);
+extern int register_security	(struct security_operations *ops);
+extern int unregister_security	(struct security_operations *ops);
+extern int mod_reg_security	(const char *name, struct security_operations =
*ops);
+extern int mod_unreg_security	(const char *name, struct security_operation=
s *ops);
+
+#define COND_SECURITY(seop, def) security_ops->seop
+
+#else /* CONFIG_SECURITY */
+static inline int security_init(void)
+{
+	return 0;
+}
+
+# define COND_SECURITY(seop, def) def
+#endif
+
+#ifdef CONFIG_SECURITY_NETWORK
+#define COND_SECU_NET(seop, def) COND_SECURITY(seop, def)
+#else
+#define COND_SECU_NET(seop, def) def
+#endif
+/* SELinux noop */
+#define SE_NOP ({})
+
 /* inline stuff */
 static inline int security_ptrace (struct task_struct * parent, struct tas=
k_struct * child)
 {
-	return security_ops->ptrace (parent, child);
+	return COND_SECURITY(ptrace (parent, child),
+			 cap_ptrace (parent, child));
 }
=20
 static inline int security_capget (struct task_struct *target,
 				   kernel_cap_t *effective,
 				   kernel_cap_t *inheritable,
 				   kernel_cap_t *permitted)
 {
-	return security_ops->capget (target, effective, inheritable, permitted);
+	return COND_SECURITY(capget (target, effective, inheritable, permitted),
+			 cap_capget (target, effective, inheritable, permitted));
 }
=20
 static inline int security_capset_check (struct task_struct *target,
 					 kernel_cap_t *effective,
 					 kernel_cap_t *inheritable,
 					 kernel_cap_t *permitted)
 {
-	return security_ops->capset_check (target, effective, inheritable, permit=
ted);
+	return COND_SECURITY(capset_check (target, effective, inheritable, permit=
ted),
+			 cap_capset_check (target, effective, inheritable, permitted));
 }
=20
 static inline void security_capset_set (struct task_struct *target,
 					kernel_cap_t *effective,
 					kernel_cap_t *inheritable,
 					kernel_cap_t *permitted)
 {
-	security_ops->capset_set (target, effective, inheritable, permitted);
+	COND_SECURITY(capset_set (target, effective, inheritable, permitted),
+	       	  cap_capset_set (target, effective, inheritable, permitted));
 }
=20
 static inline int security_acct (struct file *file)
 {
-	return security_ops->acct (file);
+	return COND_SECURITY(acct (file),
+			 0);
 }
=20
 static inline int security_sysctl(struct ctl_table *table, int op)
 {
-	return security_ops->sysctl(table, op);
+	return COND_SECURITY(sysctl(table, op),
+			 0);
 }
=20
 static inline int security_quotactl (int cmds, int type, int id,
 				     struct super_block *sb)
 {
-	return security_ops->quotactl (cmds, type, id, sb);
+	return COND_SECURITY(quotactl (cmds, type, id, sb),
+			 0);
 }
=20
 static inline int security_quota_on (struct dentry * dentry)
 {
-	return security_ops->quota_on (dentry);
+	return COND_SECURITY(quota_on (dentry),
+			 0);
 }
=20
 static inline int security_syslog(int type)
 {
-	return security_ops->syslog(type);
+	return COND_SECURITY(syslog(type),
+			 cap_syslog(type));
 }
=20
 static inline int security_settime(struct timespec *ts, struct timezone *t=
z)
 {
-	return security_ops->settime(ts, tz);
+	return COND_SECURITY(settime(ts, tz),
+			 cap_settime(ts, tz));
 }
=20
=20
 static inline int security_vm_enough_memory(long pages)
 {
-	return security_ops->vm_enough_memory(pages);
+	return COND_SECURITY(vm_enough_memory(pages),
+			 cap_vm_enough_memory(pages));
 }
=20
 static inline int security_bprm_alloc (struct linux_binprm *bprm)
 {
-	return security_ops->bprm_alloc_security (bprm);
+	return COND_SECURITY(bprm_alloc_security (bprm),
+			 0);
 }
 static inline void security_bprm_free (struct linux_binprm *bprm)
 {
-	security_ops->bprm_free_security (bprm);
+	COND_SECURITY(bprm_free_security (bprm),
+		  SE_NOP);
 }
 static inline void security_bprm_apply_creds (struct linux_binprm *bprm, i=
nt unsafe)
 {
-	security_ops->bprm_apply_creds (bprm, unsafe);
+	COND_SECURITY(bprm_apply_creds (bprm, unsafe),
+		  cap_bprm_apply_creds (bprm, unsafe));
 }
 static inline void security_bprm_post_apply_creds (struct linux_binprm *bp=
rm)
 {
-	security_ops->bprm_post_apply_creds (bprm);
+	COND_SECURITY(bprm_post_apply_creds (bprm),
+		  SE_NOP);
 }
 static inline int security_bprm_set (struct linux_binprm *bprm)
 {
-	return security_ops->bprm_set_security (bprm);
+	return COND_SECURITY(bprm_set_security (bprm),
+			 cap_bprm_set_security (bprm));
 }
=20
 static inline int security_bprm_check (struct linux_binprm *bprm)
 {
-	return security_ops->bprm_check_security (bprm);
+	return COND_SECURITY(bprm_check_security (bprm),
+			 0);
 }
=20
 static inline int security_bprm_secureexec (struct linux_binprm *bprm)
 {
-	return security_ops->bprm_secureexec (bprm);
+	return COND_SECURITY(bprm_secureexec (bprm),
+			 cap_bprm_secureexec (bprm));
 }
=20
 static inline int security_sb_alloc (struct super_block *sb)
 {
-	return security_ops->sb_alloc_security (sb);
+	return COND_SECURITY(sb_alloc_security (sb),
+			 0);
 }
=20
 static inline void security_sb_free (struct super_block *sb)
 {
-	security_ops->sb_free_security (sb);
+	COND_SECURITY(sb_free_security (sb),
+		  SE_NOP);
 }
=20
 static inline int security_sb_copy_data (struct file_system_type *type,
 					 void *orig, void *copy)
 {
-	return security_ops->sb_copy_data (type, orig, copy);
+	return COND_SECURITY(sb_copy_data (type, orig, copy),
+			 0);
 }
=20
 static inline int security_sb_kern_mount (struct super_block *sb, void *da=
ta)
 {
-	return security_ops->sb_kern_mount (sb, data);
+	return COND_SECURITY(sb_kern_mount (sb, data),
+			 0);
 }
=20
 static inline int security_sb_statfs (struct super_block *sb)
 {
-	return security_ops->sb_statfs (sb);
+	return COND_SECURITY(sb_statfs (sb),
+			 0);
 }
=20
 static inline int security_sb_mount (char *dev_name, struct nameidata *nd,
 				    char *type, unsigned long flags,
 				    void *data)
 {
-	return security_ops->sb_mount (dev_name, nd, type, flags, data);
+	return COND_SECURITY(sb_mount (dev_name, nd, type, flags, data),
+			 0);
 }
=20
 static inline int security_sb_check_sb (struct vfsmount *mnt,
 					struct nameidata *nd)
 {
-	return security_ops->sb_check_sb (mnt, nd);
+	return COND_SECURITY(sb_check_sb (mnt, nd),
+			 0);
 }
=20
 static inline int security_sb_umount (struct vfsmount *mnt, int flags)
 {
-	return security_ops->sb_umount (mnt, flags);
+	return COND_SECURITY(sb_umount (mnt, flags),
+			 0);
 }
=20
 static inline void security_sb_umount_close (struct vfsmount *mnt)
 {
-	security_ops->sb_umount_close (mnt);
+	COND_SECURITY(sb_umount_close (mnt),
+		  SE_NOP);
 }
=20
 static inline void security_sb_umount_busy (struct vfsmount *mnt)
 {
-	security_ops->sb_umount_busy (mnt);
+	COND_SECURITY(sb_umount_busy (mnt),
+		  SE_NOP);
 }
=20
 static inline void security_sb_post_remount (struct vfsmount *mnt,
 					     unsigned long flags, void *data)
 {
-	security_ops->sb_post_remount (mnt, flags, data);
+	COND_SECURITY(sb_post_remount (mnt, flags, data),
+		  SE_NOP);
 }
=20
 static inline void security_sb_post_mountroot (void)
 {
-	security_ops->sb_post_mountroot ();
+	COND_SECURITY(sb_post_mountroot (),
+		  SE_NOP);
 }
=20
 static inline void security_sb_post_addmount (struct vfsmount *mnt,
 					      struct nameidata *mountpoint_nd)
 {
-	security_ops->sb_post_addmount (mnt, mountpoint_nd);
+	COND_SECURITY(sb_post_addmount (mnt, mountpoint_nd),
+		  SE_NOP);
 }
=20
 static inline int security_sb_pivotroot (struct nameidata *old_nd,
 					 struct nameidata *new_nd)
 {
-	return security_ops->sb_pivotroot (old_nd, new_nd);
+	return COND_SECURITY(sb_pivotroot (old_nd, new_nd),
+			 0);
 }
=20
 static inline void security_sb_post_pivotroot (struct nameidata *old_nd,
 					       struct nameidata *new_nd)
 {
-	security_ops->sb_post_pivotroot (old_nd, new_nd);
+	COND_SECURITY(sb_post_pivotroot (old_nd, new_nd),
+		  SE_NOP);
 }
=20
 static inline int security_inode_alloc (struct inode *inode)
 {
-	return security_ops->inode_alloc_security (inode);
+	return COND_SECURITY(inode_alloc_security (inode),
+			 0);
 }
=20
 static inline void security_inode_free (struct inode *inode)
 {
-	security_ops->inode_free_security (inode);
+	COND_SECURITY(inode_free_security (inode),
+		  SE_NOP);
 }
 =09
 static inline int security_inode_create (struct inode *dir,
 					 struct dentry *dentry,
 					 int mode)
 {
-	return security_ops->inode_create (dir, dentry, mode);
+	return COND_SECURITY(inode_create (dir, dentry, mode),
+			 0);
 }
=20
 static inline void security_inode_post_create (struct inode *dir,
 					       struct dentry *dentry,
 					       int mode)
 {
-	security_ops->inode_post_create (dir, dentry, mode);
+	COND_SECURITY(inode_post_create (dir, dentry, mode),
+		  SE_NOP);
 }
=20
 static inline int security_inode_link (struct dentry *old_dentry,
 				       struct inode *dir,
 				       struct dentry *new_dentry)
 {
-	return security_ops->inode_link (old_dentry, dir, new_dentry);
+	return COND_SECURITY(inode_link (old_dentry, dir, new_dentry),
+			 0);
 }
=20
 static inline void security_inode_post_link (struct dentry *old_dentry,
 					     struct inode *dir,
 					     struct dentry *new_dentry)
 {
-	security_ops->inode_post_link (old_dentry, dir, new_dentry);
+	COND_SECURITY(inode_post_link (old_dentry, dir, new_dentry),
+		  SE_NOP);
 }
=20
 static inline int security_inode_unlink (struct inode *dir,
 					 struct dentry *dentry)
 {
-	return security_ops->inode_unlink (dir, dentry);
+	return COND_SECURITY(inode_unlink (dir, dentry),
+			 0);
 }
=20
 static inline int security_inode_symlink (struct inode *dir,
 					  struct dentry *dentry,
 					  const char *old_name)
 {
-	return security_ops->inode_symlink (dir, dentry, old_name);
+	return COND_SECURITY(inode_symlink (dir, dentry, old_name),
+			 0);
 }
=20
 static inline void security_inode_post_symlink (struct inode *dir,
 						struct dentry *dentry,
 						const char *old_name)
 {
-	security_ops->inode_post_symlink (dir, dentry, old_name);
+	COND_SECURITY(inode_post_symlink (dir, dentry, old_name),
+		  SE_NOP);
 }
=20
 static inline int security_inode_mkdir (struct inode *dir,
 					struct dentry *dentry,
 					int mode)
 {
-	return security_ops->inode_mkdir (dir, dentry, mode);
+	return COND_SECURITY(inode_mkdir (dir, dentry, mode),
+			 0);
 }
=20
 static inline void security_inode_post_mkdir (struct inode *dir,
 					      struct dentry *dentry,
 					      int mode)
 {
-	security_ops->inode_post_mkdir (dir, dentry, mode);
+	COND_SECURITY(inode_post_mkdir (dir, dentry, mode),
+		  SE_NOP);
 }
=20
 static inline int security_inode_rmdir (struct inode *dir,
 					struct dentry *dentry)
 {
-	return security_ops->inode_rmdir (dir, dentry);
+	return COND_SECURITY(inode_rmdir (dir, dentry),
+			 0);
 }
=20
 static inline int security_inode_mknod (struct inode *dir,
 					struct dentry *dentry,
 					int mode, dev_t dev)
 {
-	return security_ops->inode_mknod (dir, dentry, mode, dev);
+	return COND_SECURITY(inode_mknod (dir, dentry, mode, dev),
+			 0);
 }
=20
 static inline void security_inode_post_mknod (struct inode *dir,
 					      struct dentry *dentry,
 					      int mode, dev_t dev)
 {
-	security_ops->inode_post_mknod (dir, dentry, mode, dev);
+	COND_SECURITY(inode_post_mknod (dir, dentry, mode, dev),
+		  SE_NOP);
 }
=20
 static inline int security_inode_rename (struct inode *old_dir,
 					 struct dentry *old_dentry,
 					 struct inode *new_dir,
 					 struct dentry *new_dentry)
 {
-	return security_ops->inode_rename (old_dir, old_dentry,
-					   new_dir, new_dentry);
+	return COND_SECURITY(inode_rename (old_dir, old_dentry,
+					   new_dir, new_dentry),=20
+			 0);
 }
=20
 static inline void security_inode_post_rename (struct inode *old_dir,
 					       struct dentry *old_dentry,
 					       struct inode *new_dir,
 					       struct dentry *new_dentry)
 {
-	security_ops->inode_post_rename (old_dir, old_dentry,
-						new_dir, new_dentry);
+	COND_SECURITY(inode_post_rename (old_dir, old_dentry,
+					 new_dir, new_dentry),
+		  SE_NOP);
 }
=20
 static inline int security_inode_readlink (struct dentry *dentry)
 {
-	return security_ops->inode_readlink (dentry);
+	return COND_SECURITY(inode_readlink (dentry),
+			 0);
 }
=20
 static inline int security_inode_follow_link (struct dentry *dentry,
 					      struct nameidata *nd)
 {
-	return security_ops->inode_follow_link (dentry, nd);
+	return COND_SECURITY(inode_follow_link (dentry, nd),
+			 0);
 }
=20
 static inline int security_inode_permission (struct inode *inode, int mask,
 					     struct nameidata *nd)
 {
-	return security_ops->inode_permission (inode, mask, nd);
+	return COND_SECURITY(inode_permission (inode, mask, nd),
+			 0);
 }
=20
 static inline int security_inode_setattr (struct dentry *dentry,
 					  struct iattr *attr)
 {
-	return security_ops->inode_setattr (dentry, attr);
+	return COND_SECURITY(inode_setattr (dentry, attr),
+			 0);
 }
=20
 static inline int security_inode_getattr (struct vfsmount *mnt,
 					  struct dentry *dentry)
 {
-	return security_ops->inode_getattr (mnt, dentry);
+	return COND_SECURITY(inode_getattr (mnt, dentry),
+			 0);
 }
=20
 static inline void security_inode_delete (struct inode *inode)
 {
-	security_ops->inode_delete (inode);
+	COND_SECURITY(inode_delete (inode),
+		  SE_NOP);
 }
=20
 static inline int security_inode_setxattr (struct dentry *dentry, char *na=
me,
 					   void *value, size_t size, int flags)
 {
-	return security_ops->inode_setxattr (dentry, name, value, size, flags);
+	return COND_SECURITY(inode_setxattr (dentry, name, value, size, flags),
+			 cap_inode_setxattr (dentry, name, value, size, flags));
 }
=20
 static inline void security_inode_post_setxattr (struct dentry *dentry, ch=
ar *name,
 						void *value, size_t size, int flags)
 {
-	security_ops->inode_post_setxattr (dentry, name, value, size, flags);
+	COND_SECURITY(inode_post_setxattr (dentry, name, value, size, flags),
+		  SE_NOP);
 }
=20
 static inline int security_inode_getxattr (struct dentry *dentry, char *na=
me)
 {
-	return security_ops->inode_getxattr (dentry, name);
+	return COND_SECURITY(inode_getxattr (dentry, name),
+			 0);
 }
=20
 static inline int security_inode_listxattr (struct dentry *dentry)
 {
-	return security_ops->inode_listxattr (dentry);
+	return COND_SECURITY(inode_listxattr (dentry),
+			 0);
 }
=20
 static inline int security_inode_removexattr (struct dentry *dentry, char =
*name)
 {
-	return security_ops->inode_removexattr (dentry, name);
+	return COND_SECURITY(inode_removexattr (dentry, name),
+			 cap_inode_removexattr (dentry, name));
 }
=20
 static inline int security_inode_getsecurity(struct inode *inode, const ch=
ar *name, void *buffer, size_t size)
 {
-	return security_ops->inode_getsecurity(inode, name, buffer, size);
+	return COND_SECURITY(inode_getsecurity(inode, name, buffer, size),
+			 -EOPNOTSUPP);
 }
=20
 static inline int security_inode_setsecurity(struct inode *inode, const ch=
ar *name, const void *value, size_t size, int flags)
 {
-	return security_ops->inode_setsecurity(inode, name, value, size, flags);
+	return COND_SECURITY(inode_setsecurity(inode, name, value, size, flags),
+			 -EOPNOTSUPP);
 }
=20
 static inline int security_inode_listsecurity(struct inode *inode, char *b=
uffer, size_t buffer_size)
 {
-	return security_ops->inode_listsecurity(inode, buffer, buffer_size);
+	return COND_SECURITY(inode_listsecurity(inode, buffer, buffer_size),
+			 0);
 }
=20
 static inline int security_file_permission (struct file *file, int mask)
 {
-	return security_ops->file_permission (file, mask);
+	return COND_SECURITY(file_permission (file, mask),
+			 0);
 }
=20
 static inline int security_file_alloc (struct file *file)
 {
-	return security_ops->file_alloc_security (file);
+	return COND_SECURITY(file_alloc_security (file),
+			 0);
 }
=20
 static inline void security_file_free (struct file *file)
 {
-	security_ops->file_free_security (file);
+	COND_SECURITY(file_free_security (file),
+		  SE_NOP);
 }
=20
 static inline int security_file_ioctl (struct file *file, unsigned int cmd,
 				       unsigned long arg)
 {
-	return security_ops->file_ioctl (file, cmd, arg);
+	return COND_SECURITY(file_ioctl (file, cmd, arg),
+			 0);
 }
=20
 static inline int security_file_mmap (struct file *file, unsigned long pro=
t,
 				      unsigned long flags)
 {
-	return security_ops->file_mmap (file, prot, flags);
+	return COND_SECURITY(file_mmap (file, prot, flags),
+			 0);
 }
=20
 static inline int security_file_mprotect (struct vm_area_struct *vma,
 					  unsigned long prot)
 {
-	return security_ops->file_mprotect (vma, prot);
+	return COND_SECURITY(file_mprotect (vma, prot),
+			 0);
 }
=20
 static inline int security_file_lock (struct file *file, unsigned int cmd)
 {
-	return security_ops->file_lock (file, cmd);
+	return COND_SECURITY(file_lock (file, cmd),
+			 0);
 }
=20
 static inline int security_file_fcntl (struct file *file, unsigned int cmd,
 				       unsigned long arg)
 {
-	return security_ops->file_fcntl (file, cmd, arg);
+	return COND_SECURITY(file_fcntl (file, cmd, arg),
+			 0);
 }
=20
 static inline int security_file_set_fowner (struct file *file)
 {
-	return security_ops->file_set_fowner (file);
+	return COND_SECURITY(file_set_fowner (file),
+			 0);
 }
=20
 static inline int security_file_send_sigiotask (struct task_struct *tsk,
 						struct fown_struct *fown,
 						int sig)
 {
-	return security_ops->file_send_sigiotask (tsk, fown, sig);
+	return COND_SECURITY(file_send_sigiotask (tsk, fown, sig),
+			 0);
 }
=20
 static inline int security_file_receive (struct file *file)
 {
-	return security_ops->file_receive (file);
+	return COND_SECURITY(file_receive (file),
+			 0);
 }
=20
 static inline int security_task_create (unsigned long clone_flags)
 {
-	return security_ops->task_create (clone_flags);
+	return COND_SECURITY(task_create (clone_flags),
+			 0);
 }
=20
 static inline int security_task_alloc (struct task_struct *p)
 {
-	return security_ops->task_alloc_security (p);
+	return COND_SECURITY(task_alloc_security (p),
+			 0);
 }
=20
 static inline void security_task_free (struct task_struct *p)
 {
-	security_ops->task_free_security (p);
+	COND_SECURITY(task_free_security (p),
+		  SE_NOP);
 }
=20
 static inline int security_task_setuid (uid_t id0, uid_t id1, uid_t id2,
 					int flags)
 {
-	return security_ops->task_setuid (id0, id1, id2, flags);
+	return COND_SECURITY(task_setuid (id0, id1, id2, flags),
+			 0);
 }
=20
 static inline int security_task_post_setuid (uid_t old_ruid, uid_t old_eui=
d,
 					     uid_t old_suid, int flags)
 {
-	return security_ops->task_post_setuid (old_ruid, old_euid, old_suid, flag=
s);
+	return COND_SECURITY(task_post_setuid (old_ruid, old_euid, old_suid, flag=
s),
+			 cap_task_post_setuid (old_ruid, old_euid, old_suid, flags));
 }
=20
 static inline int security_task_setgid (gid_t id0, gid_t id1, gid_t id2,
 					int flags)
 {
-	return security_ops->task_setgid (id0, id1, id2, flags);
+	return COND_SECURITY(task_setgid (id0, id1, id2, flags),
+			 0);
 }
=20
 static inline int security_task_setpgid (struct task_struct *p, pid_t pgid)
 {
-	return security_ops->task_setpgid (p, pgid);
+	return COND_SECURITY(task_setpgid (p, pgid),
+			 0);
 }
=20
 static inline int security_task_getpgid (struct task_struct *p)
 {
-	return security_ops->task_getpgid (p);
+	return COND_SECURITY(task_getpgid (p),
+			 0);
 }
=20
 static inline int security_task_getsid (struct task_struct *p)
 {
-	return security_ops->task_getsid (p);
+	return COND_SECURITY(task_getsid (p),
+			 0);
 }
=20
 static inline int security_task_setgroups (struct group_info *group_info)
 {
-	return security_ops->task_setgroups (group_info);
+	return COND_SECURITY(task_setgroups (group_info),
+			 0);
 }
=20
 static inline int security_task_setnice (struct task_struct *p, int nice)
 {
-	return security_ops->task_setnice (p, nice);
+	return COND_SECURITY(task_setnice (p, nice),
+			 0);
 }
=20
 static inline int security_task_setrlimit (unsigned int resource,
 					   struct rlimit *new_rlim)
 {
-	return security_ops->task_setrlimit (resource, new_rlim);
+	return COND_SECURITY(task_setrlimit (resource, new_rlim),
+			 0);
 }
=20
 static inline int security_task_setscheduler (struct task_struct *p,
 					      int policy,
 					      struct sched_param *lp)
 {
-	return security_ops->task_setscheduler (p, policy, lp);
+	return COND_SECURITY(task_setscheduler (p, policy, lp),
+			 0);
 }
=20
 static inline int security_task_getscheduler (struct task_struct *p)
 {
-	return security_ops->task_getscheduler (p);
+	return COND_SECURITY(task_getscheduler (p),
+			 0);
 }
=20
 static inline int security_task_kill (struct task_struct *p,
 				      struct siginfo *info, int sig)
 {
-	return security_ops->task_kill (p, info, sig);
+	return COND_SECURITY(task_kill (p, info, sig),
+			 0);
 }
=20
 static inline int security_task_wait (struct task_struct *p)
 {
-	return security_ops->task_wait (p);
+	return COND_SECURITY(task_wait (p),
+			 0);
 }
=20
 static inline int security_task_prctl (int option, unsigned long arg2,
 				       unsigned long arg3,
 				       unsigned long arg4,
 				       unsigned long arg5)
 {
-	return security_ops->task_prctl (option, arg2, arg3, arg4, arg5);
+	return COND_SECURITY(task_prctl (option, arg2, arg3, arg4, arg5),
+			 0);
 }
=20
 static inline void security_task_reparent_to_init (struct task_struct *p)
 {
-	security_ops->task_reparent_to_init (p);
+	COND_SECURITY(task_reparent_to_init (p),
+		  cap_task_reparent_to_init (p));
 }
=20
 static inline void security_task_to_inode(struct task_struct *p, struct in=
ode *inode)
 {
-	security_ops->task_to_inode(p, inode);
+	COND_SECURITY(task_to_inode(p, inode),
+		  SE_NOP);
 }
=20
 static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
 					   short flag)
 {
-	return security_ops->ipc_permission (ipcp, flag);
+	return COND_SECURITY(ipc_permission (ipcp, flag),
+			 0);
 }
=20
 static inline int security_msg_msg_alloc (struct msg_msg * msg)
 {
-	return security_ops->msg_msg_alloc_security (msg);
+	return COND_SECURITY(msg_msg_alloc_security (msg),
+			 0);
 }
=20
 static inline void security_msg_msg_free (struct msg_msg * msg)
 {
-	security_ops->msg_msg_free_security(msg);
+	COND_SECURITY(msg_msg_free_security(msg),
+		  SE_NOP);
 }
=20
 static inline int security_msg_queue_alloc (struct msg_queue *msq)
 {
-	return security_ops->msg_queue_alloc_security (msq);
+	return COND_SECURITY(msg_queue_alloc_security (msq),
+			 0);
 }
=20
 static inline void security_msg_queue_free (struct msg_queue *msq)
 {
-	security_ops->msg_queue_free_security (msq);
+	COND_SECURITY(msg_queue_free_security (msq),
+		  SE_NOP);
 }
=20
 static inline int security_msg_queue_associate (struct msg_queue * msq,=20
 						int msqflg)
 {
-	return security_ops->msg_queue_associate (msq, msqflg);
+	return COND_SECURITY(msg_queue_associate (msq, msqflg),
+			 0);
 }
=20
 static inline int security_msg_queue_msgctl (struct msg_queue * msq, int c=
md)
 {
-	return security_ops->msg_queue_msgctl (msq, cmd);
+	return COND_SECURITY(msg_queue_msgctl (msq, cmd),
+			 0);
 }
=20
 static inline int security_msg_queue_msgsnd (struct msg_queue * msq,
 					     struct msg_msg * msg, int msqflg)
 {
-	return security_ops->msg_queue_msgsnd (msq, msg, msqflg);
+	return COND_SECURITY(msg_queue_msgsnd (msq, msg, msqflg),
+			 0);
 }
=20
 static inline int security_msg_queue_msgrcv (struct msg_queue * msq,
 					     struct msg_msg * msg,
 					     struct task_struct * target,
 					     long type, int mode)
 {
-	return security_ops->msg_queue_msgrcv (msq, msg, target, type, mode);
+	return COND_SECURITY(msg_queue_msgrcv (msq, msg, target, type, mode),
+			 0);
 }
=20
 static inline int security_shm_alloc (struct shmid_kernel *shp)
 {
-	return security_ops->shm_alloc_security (shp);
+	return COND_SECURITY(shm_alloc_security (shp),
+			 0);
 }
=20
 static inline void security_shm_free (struct shmid_kernel *shp)
 {
-	security_ops->shm_free_security (shp);
+	COND_SECURITY(shm_free_security (shp),
+		  SE_NOP);
 }
=20
 static inline int security_shm_associate (struct shmid_kernel * shp,=20
 					  int shmflg)
 {
-	return security_ops->shm_associate(shp, shmflg);
+	return COND_SECURITY(shm_associate (shp, shmflg),
+			 0);
 }
=20
 static inline int security_shm_shmctl (struct shmid_kernel * shp, int cmd)
 {
-	return security_ops->shm_shmctl (shp, cmd);
+	return COND_SECURITY(shm_shmctl (shp, cmd),
+			 0);
 }
=20
 static inline int security_shm_shmat (struct shmid_kernel * shp,=20
 				      char __user *shmaddr, int shmflg)
 {
-	return security_ops->shm_shmat(shp, shmaddr, shmflg);
+	return COND_SECURITY(shm_shmat (shp, shmaddr, shmflg),
+			 0);
 }
=20
 static inline int security_sem_alloc (struct sem_array *sma)
 {
-	return security_ops->sem_alloc_security (sma);
+	return COND_SECURITY(sem_alloc_security (sma),
+			 0);
 }
=20
 static inline void security_sem_free (struct sem_array *sma)
 {
-	security_ops->sem_free_security (sma);
+	COND_SECURITY(sem_free_security (sma),
+		  SE_NOP);
 }
=20
 static inline int security_sem_associate (struct sem_array * sma, int semf=
lg)
 {
-	return security_ops->sem_associate (sma, semflg);
+	return COND_SECURITY(sem_associate (sma, semflg),
+			 0);
 }
=20
 static inline int security_sem_semctl (struct sem_array * sma, int cmd)
 {
-	return security_ops->sem_semctl(sma, cmd);
+	return COND_SECURITY(sem_semctl (sma, cmd),
+			 0);
 }
=20
 static inline int security_sem_semop (struct sem_array * sma,=20
 				      struct sembuf * sops, unsigned nsops,=20
 				      int alter)
 {
-	return security_ops->sem_semop(sma, sops, nsops, alter);
+	return COND_SECURITY(sem_semop (sma, sops, nsops, alter),
+			 0);
 }
=20
 static inline void security_d_instantiate (struct dentry *dentry, struct i=
node *inode)
 {
-	security_ops->d_instantiate (dentry, inode);
+	COND_SECURITY(d_instantiate (dentry, inode),
+		  SE_NOP);
 }
=20
 static inline int security_getprocattr(struct task_struct *p, char *name, =
void *value, size_t size)
 {
-	return security_ops->getprocattr(p, name, value, size);
+	return COND_SECURITY(getprocattr (p, name, value, size),
+			 -EINVAL);
 }
=20
 static inline int security_setprocattr(struct task_struct *p, char *name, =
void *value, size_t size)
 {
-	return security_ops->setprocattr(p, name, value, size);
+	return COND_SECURITY(setprocattr (p, name, value, size),
+			 -EINVAL);
 }
=20
 static inline int security_netlink_send(struct sock *sk, struct sk_buff * =
skb)
 {
-	return security_ops->netlink_send(sk, skb);
+	return COND_SECURITY(netlink_send (sk, skb),
+			 cap_netlink_send (sk, skb));
 }
=20
 static inline int security_netlink_recv(struct sk_buff * skb)
 {
-	return security_ops->netlink_recv(skb);
-}
-
-/* prototypes */
-extern int security_init	(void);
-extern int register_security	(struct security_operations *ops);
-extern int unregister_security	(struct security_operations *ops);
-extern int mod_reg_security	(const char *name, struct security_operations =
*ops);
-extern int mod_unreg_security	(const char *name, struct security_operation=
s *ops);
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
-{
-	return 0;
-}
-
-static inline int security_ptrace (struct task_struct *parent, struct task=
_struct * child)
-{
-	return cap_ptrace (parent, child);
-}
-
-static inline int security_capget (struct task_struct *target,
-				   kernel_cap_t *effective,
-				   kernel_cap_t *inheritable,
-				   kernel_cap_t *permitted)
-{
-	return cap_capget (target, effective, inheritable, permitted);
-}
-
-static inline int security_capset_check (struct task_struct *target,
-					 kernel_cap_t *effective,
-					 kernel_cap_t *inheritable,
-					 kernel_cap_t *permitted)
-{
-	return cap_capset_check (target, effective, inheritable, permitted);
-}
-
-static inline void security_capset_set (struct task_struct *target,
-					kernel_cap_t *effective,
-					kernel_cap_t *inheritable,
-					kernel_cap_t *permitted)
-{
-	cap_capset_set (target, effective, inheritable, permitted);
-}
-
-static inline int security_acct (struct file *file)
-{
-	return 0;
-}
-
-static inline int security_sysctl(struct ctl_table *table, int op)
-{
-	return 0;
-}
-
-static inline int security_quotactl (int cmds, int type, int id,
-				     struct super_block * sb)
-{
-	return 0;
-}
-
-static inline int security_quota_on (struct dentry * dentry)
-{
-	return 0;
-}
-
-static inline int security_syslog(int type)
-{
-	return cap_syslog(type);
-}
-
-static inline int security_settime(struct timespec *ts, struct timezone *t=
z)
-{
-	return cap_settime(ts, tz);
-}
-
-static inline int security_vm_enough_memory(long pages)
-{
-	return cap_vm_enough_memory(pages);
-}
-
-static inline int security_bprm_alloc (struct linux_binprm *bprm)
-{
-	return 0;
-}
-
-static inline void security_bprm_free (struct linux_binprm *bprm)
-{ }
-
-static inline void security_bprm_apply_creds (struct linux_binprm *bprm, i=
nt unsafe)
-{=20
-	cap_bprm_apply_creds (bprm, unsafe);
-}
-
-static inline void security_bprm_post_apply_creds (struct linux_binprm *bp=
rm)
-{
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
+	return COND_SECURITY(netlink_recv (skb),
+			 cap_netlink_recv (skb));
 }
=20
-static inline int security_sb_alloc (struct super_block *sb)
+/* CONFIG_SECURITY_NETWORK stubs */
+static inline int security_unix_stream_connect(struct socket * sock,
+					       struct socket * other,=20
+					       struct sock * newsk)
 {
-	return 0;
+	return COND_SECU_NET(unix_stream_connect(sock, other, newsk),
+			 0);
 }
=20
-static inline void security_sb_free (struct super_block *sb)
-{ }
=20
-static inline int security_sb_copy_data (struct file_system_type *type,
-					 void *orig, void *copy)
+static inline int security_unix_may_send(struct socket * sock,=20
+					 struct socket * other)
 {
-	return 0;
+	return COND_SECU_NET(unix_may_send(sock, other),
+			 0);
 }
=20
-static inline int security_sb_kern_mount (struct super_block *sb, void *da=
ta)
+static inline int security_socket_create (int family, int type,
+					  int protocol, int kern)
 {
-	return 0;
+	return COND_SECU_NET(socket_create(family, type, protocol, kern),
+			 0);
 }
=20
-static inline int security_sb_statfs (struct super_block *sb)
+static inline void security_socket_post_create(struct socket * sock,=20
+					       int family,
+					       int type,=20
+					       int protocol, int kern)
 {
-	return 0;
+	COND_SECU_NET(socket_post_create(sock, family, type, protocol, kern),
+		  SE_NOP);
 }
=20
-static inline int security_sb_mount (char *dev_name, struct nameidata *nd,
-				    char *type, unsigned long flags,
-				    void *data)
+static inline int security_socket_bind(struct socket * sock,=20
+				       struct sockaddr * address,=20
+				       int addrlen)
 {
-	return 0;
+	return COND_SECU_NET(socket_bind(sock, address, addrlen),
+			 0);
 }
=20
-static inline int security_sb_check_sb (struct vfsmount *mnt,
-					struct nameidata *nd)
+static inline int security_socket_connect(struct socket * sock,=20
+					  struct sockaddr * address,=20
+					  int addrlen)
 {
-	return 0;
+	return COND_SECU_NET(socket_connect(sock, address, addrlen),
+			 0);
 }
=20
-static inline int security_sb_umount (struct vfsmount *mnt, int flags)
+static inline int security_socket_listen(struct socket * sock, int backlog)
 {
-	return 0;
+	return COND_SECU_NET(socket_listen(sock, backlog),
+			 0);
 }
=20
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
+static inline int security_socket_accept(struct socket * sock,=20
+					 struct socket * newsock)
 {
-	return 0;
+	return COND_SECU_NET(socket_accept(sock, newsock),
+			 0);
 }
=20
-static inline void security_sb_post_pivotroot (struct nameidata *old_nd,
-					       struct nameidata *new_nd)
-{ }
-
-static inline int security_inode_alloc (struct inode *inode)
+static inline void security_socket_post_accept(struct socket * sock,=20
+					       struct socket * newsock)
 {
-	return 0;
+	COND_SECU_NET(socket_post_accept(sock, newsock),
+		  SE_NOP);
 }
=20
-static inline void security_inode_free (struct inode *inode)
-{ }
-=09
-static inline int security_inode_create (struct inode *dir,
-					 struct dentry *dentry,
-					 int mode)
+static inline int security_socket_sendmsg(struct socket * sock,=20
+					  struct msghdr * msg, int size)
 {
-	return 0;
+	return COND_SECU_NET(socket_sendmsg(sock, msg, size),
+			 0);
 }
=20
-static inline void security_inode_post_create (struct inode *dir,
-					       struct dentry *dentry,
-					       int mode)
-{ }
-
-static inline int security_inode_link (struct dentry *old_dentry,
-				       struct inode *dir,
-				       struct dentry *new_dentry)
+static inline int security_socket_recvmsg(struct socket * sock,=20
+					  struct msghdr * msg, int size,=20
+					  int flags)
 {
-	return 0;
+	return COND_SECU_NET(socket_recvmsg(sock, msg, size, flags),
+			 0);
 }
=20
-static inline void security_inode_post_link (struct dentry *old_dentry,
-					     struct inode *dir,
-					     struct dentry *new_dentry)
-{ }
-
-static inline int security_inode_unlink (struct inode *dir,
-					 struct dentry *dentry)
+static inline int security_socket_getsockname(struct socket * sock)
 {
-	return 0;
+	return COND_SECU_NET(socket_getsockname(sock),
+			 0);
 }
=20
-static inline int security_inode_symlink (struct inode *dir,
-					  struct dentry *dentry,
-					  const char *old_name)
+static inline int security_socket_getpeername(struct socket * sock)
 {
-	return 0;
+	return COND_SECU_NET(socket_getpeername(sock),
+			 0);
 }
=20
-static inline void security_inode_post_symlink (struct inode *dir,
-						struct dentry *dentry,
-						const char *old_name)
-{ }
-
-static inline int security_inode_mkdir (struct inode *dir,
-					struct dentry *dentry,
-					int mode)
+static inline int security_socket_getsockopt(struct socket * sock,=20
+					     int level, int optname)
 {
-	return 0;
+	return COND_SECU_NET(socket_getsockopt(sock, level, optname),
+			 0);
 }
=20
-static inline void security_inode_post_mkdir (struct inode *dir,
-					      struct dentry *dentry,
-					      int mode)
-{ }
-
-static inline int security_inode_rmdir (struct inode *dir,
-					struct dentry *dentry)
+static inline int security_socket_setsockopt(struct socket * sock,=20
+					     int level, int optname)
 {
-	return 0;
+	return COND_SECU_NET(socket_setsockopt(sock, level, optname),
+			 0);
 }
=20
-static inline int security_inode_mknod (struct inode *dir,
-					struct dentry *dentry,
-					int mode, dev_t dev)
+static inline int security_socket_shutdown(struct socket * sock, int how)
 {
-	return 0;
+	return COND_SECU_NET(socket_shutdown(sock, how),
+			 0);
 }
=20
-static inline void security_inode_post_mknod (struct inode *dir,
-					      struct dentry *dentry,
-					      int mode, dev_t dev)
-{ }
-
-static inline int security_inode_rename (struct inode *old_dir,
-					 struct dentry *old_dentry,
-					 struct inode *new_dir,
-					 struct dentry *new_dentry)
+static inline int security_sock_rcv_skb (struct sock * sk,=20
+					 struct sk_buff * skb)
 {
-	return 0;
+	return COND_SECU_NET(socket_sock_rcv_skb(sk, skb),
+			 0);
 }
=20
-static inline void security_inode_post_rename (struct inode *old_dir,
-					       struct dentry *old_dentry,
-					       struct inode *new_dir,
-					       struct dentry *new_dentry)
-{ }
-
-static inline int security_inode_readlink (struct dentry *dentry)
+static inline int security_socket_getpeersec(struct socket *sock, char __u=
ser *optval,
+					     int __user *optlen, unsigned len)
 {
-	return 0;
+	return COND_SECU_NET(socket_getpeersec(sock, optval, optlen, len),
+			 -ENOPROTOOPT);
 }
=20
-static inline int security_inode_follow_link (struct dentry *dentry,
-					      struct nameidata *nd)
+static inline int security_sk_alloc(struct sock *sk, int family, int prior=
ity)
 {
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
-static inline int security_inode_setxattr (struct dentry *dentry, char *na=
me,
-					   void *value, size_t size, int flags)
-{
-	return cap_inode_setxattr(dentry, name, value, size, flags);
-}
-
-static inline void security_inode_post_setxattr (struct dentry *dentry, ch=
ar *name,
-						 void *value, size_t size, int flags)
-{ }
-
-static inline int security_inode_getxattr (struct dentry *dentry, char *na=
me)
-{
-	return 0;
-}
-
-static inline int security_inode_listxattr (struct dentry *dentry)
-{
-	return 0;
-}
-
-static inline int security_inode_removexattr (struct dentry *dentry, char =
*name)
-{
-	return cap_inode_removexattr(dentry, name);
-}
-
-static inline int security_inode_getsecurity(struct inode *inode, const ch=
ar *name, void *buffer, size_t size)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int security_inode_setsecurity(struct inode *inode, const ch=
ar *name, const void *value, size_t size, int flags)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline int security_inode_listsecurity(struct inode *inode, char *b=
uffer, size_t buffer_size)
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
-static inline int security_file_mmap (struct file *file, unsigned long pro=
t,
-				      unsigned long flags)
-{
-	return 0;
-}
-
-static inline int security_file_mprotect (struct vm_area_struct *vma,
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
-static inline int security_task_post_setuid (uid_t old_ruid, uid_t old_eui=
d,
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
-static inline void security_task_to_inode(struct task_struct *p, struct in=
ode *inode)
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
-static inline int security_msg_queue_associate (struct msg_queue * msq,=20
-						int msqflg)
-{
-	return 0;
-}
-
-static inline int security_msg_queue_msgctl (struct msg_queue * msq, int c=
md)
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
-static inline int security_shm_associate (struct shmid_kernel * shp,=20
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
-static inline int security_shm_shmat (struct shmid_kernel * shp,=20
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
-static inline int security_sem_associate (struct sem_array * sma, int semf=
lg)
-{
-	return 0;
-}
-
-static inline int security_sem_semctl (struct sem_array * sma, int cmd)
-{
-	return 0;
-}
-
-static inline int security_sem_semop (struct sem_array * sma,=20
-				      struct sembuf * sops, unsigned nsops,=20
-				      int alter)
-{
-	return 0;
-}
-
-static inline void security_d_instantiate (struct dentry *dentry, struct i=
node *inode)
-{ }
-
-static inline int security_getprocattr(struct task_struct *p, char *name, =
void *value, size_t size)
-{
-	return -EINVAL;
-}
-
-static inline int security_setprocattr(struct task_struct *p, char *name, =
void *value, size_t size)
-{
-	return -EINVAL;
-}
-
-static inline int security_netlink_send (struct sock *sk, struct sk_buff *=
skb)
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
-					       struct socket * other,=20
-					       struct sock * newsk)
-{
-	return security_ops->unix_stream_connect(sock, other, newsk);
-}
-
-
-static inline int security_unix_may_send(struct socket * sock,=20
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
-static inline void security_socket_post_create(struct socket * sock,=20
-					       int family,
-					       int type,=20
-					       int protocol, int kern)
-{
-	security_ops->socket_post_create(sock, family, type,
-					 protocol, kern);
-}
-
-static inline int security_socket_bind(struct socket * sock,=20
-				       struct sockaddr * address,=20
-				       int addrlen)
-{
-	return security_ops->socket_bind(sock, address, addrlen);
-}
-
-static inline int security_socket_connect(struct socket * sock,=20
-					  struct sockaddr * address,=20
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
-static inline int security_socket_accept(struct socket * sock,=20
-					 struct socket * newsock)
-{
-	return security_ops->socket_accept(sock, newsock);
-}
-
-static inline void security_socket_post_accept(struct socket * sock,=20
-					       struct socket * newsock)
-{
-	security_ops->socket_post_accept(sock, newsock);
-}
-
-static inline int security_socket_sendmsg(struct socket * sock,=20
-					  struct msghdr * msg, int size)
-{
-	return security_ops->socket_sendmsg(sock, msg, size);
-}
-
-static inline int security_socket_recvmsg(struct socket * sock,=20
-					  struct msghdr * msg, int size,=20
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
-}
-
-static inline int security_socket_getsockopt(struct socket * sock,=20
-					     int level, int optname)
-{
-	return security_ops->socket_getsockopt(sock, level, optname);
-}
-
-static inline int security_socket_setsockopt(struct socket * sock,=20
-					     int level, int optname)
-{
-	return security_ops->socket_setsockopt(sock, level, optname);
-}
-
-static inline int security_socket_shutdown(struct socket * sock, int how)
-{
-	return security_ops->socket_shutdown(sock, how);
-}
-
-static inline int security_sock_rcv_skb (struct sock * sk,=20
-					 struct sk_buff * skb)
-{
-	return security_ops->socket_sock_rcv_skb (sk, skb);
-}
-
-static inline int security_socket_getpeersec(struct socket *sock, char __u=
ser *optval,
-					     int __user *optlen, unsigned len)
-{
-	return security_ops->socket_getpeersec(sock, optval, optlen, len);
-}
-
-static inline int security_sk_alloc(struct sock *sk, int family, int prior=
ity)
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
-					       struct socket * other,=20
-					       struct sock * newsk)
-{
-	return 0;
-}
-
-static inline int security_unix_may_send(struct socket * sock,=20
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
-static inline void security_socket_post_create(struct socket * sock,=20
-					       int family,
-					       int type,=20
-					       int protocol, int kern)
-{
-}
-
-static inline int security_socket_bind(struct socket * sock,=20
-				       struct sockaddr * address,=20
-				       int addrlen)
-{
-	return 0;
-}
-
-static inline int security_socket_connect(struct socket * sock,=20
-					  struct sockaddr * address,=20
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
-static inline int security_socket_accept(struct socket * sock,=20
-					 struct socket * newsock)
-{
-	return 0;
-}
-
-static inline void security_socket_post_accept(struct socket * sock,=20
-					       struct socket * newsock)
-{
-}
-
-static inline int security_socket_sendmsg(struct socket * sock,=20
-					  struct msghdr * msg, int size)
-{
-	return 0;
-}
-
-static inline int security_socket_recvmsg(struct socket * sock,=20
-					  struct msghdr * msg, int size,=20
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
-static inline int security_socket_getsockopt(struct socket * sock,=20
-					     int level, int optname)
-{
-	return 0;
-}
-
-static inline int security_socket_setsockopt(struct socket * sock,=20
-					     int level, int optname)
-{
-	return 0;
-}
-
-static inline int security_socket_shutdown(struct socket * sock, int how)
-{
-	return 0;
-}
-static inline int security_sock_rcv_skb (struct sock * sk,=20
-					 struct sk_buff * skb)
-{
-	return 0;
-}
-
-static inline int security_socket_getpeersec(struct socket *sock, char __u=
ser *optval,
-					     int __user *optlen, unsigned len)
-{
-	return -ENOPROTOOPT;
-}
-
-static inline int security_sk_alloc(struct sock *sk, int family, int prior=
ity)
-{
-	return 0;
+	return COND_SECU_NET(sk_alloc_security(sk, family, priority),
+			 0);
 }
=20
 static inline void security_sk_free(struct sock *sk)
 {
+	COND_SECU_NET(sk_free_security(sk),
+		  	 SE_NOP);
 }
-#endif	/* CONFIG_SECURITY_NETWORK */
=20
 #endif /* ! __LINUX_SECURITY_H */
=20

--GPOl6LAGMgeiWDic--

--FbmEh7Ek6NM6xKh/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCEYyUxmLh6hyYd04RAjG2AKC4ST2NXojMP1dL02DDtCvRfSuT6gCgyBdl
yXEYmz5K6WCj7QJah6BlMQM=
=8d+J
-----END PGP SIGNATURE-----

--FbmEh7Ek6NM6xKh/--
