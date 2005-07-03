Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVGCP56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVGCP56 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 11:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVGCP55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 11:57:57 -0400
Received: from mx1.suse.de ([195.135.220.2]:30098 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261459AbVGCPoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 11:44:01 -0400
Date: Sun, 3 Jul 2005 17:43:57 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Steve Beattie <smb@wirex.com>
Subject: [PATCH 2b/3] Cleanup the security stubs
Message-ID: <20050703154356.GD11093@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
	James Morris <jmorris@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, Steve Beattie <smb@wirex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Content-Disposition: inline
X-Operating-System: Linux 2.6.11.4-21.7-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jt0yj30bxbg11sci
Content-Type: multipart/mixed; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch cleans up the security stubs; rather than having an
ifdef hell, use a macro that hides the conditional.
Furthermore the macro can be changed to to include a condition
if this turns out to perform better than the indirect calls,
which is actually what the next patch (3) will do.

This patch should increase the maintainability of security.h a
lot. Note that patches 2a and 2b together do reduce the size of
security.h significantly. It did even better so in the past, but
alas we have all these IS_PRIVATE stuff in here now, which I
left in ifdefs for now to avoid obscuring what happens.

Note that one inconsistency was actually found and fixed;=20
look near the end of the patch ...
The return void was harmless fortunately.

Regards,
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=security-clean-stubs
Content-Transfer-Encoding: quoted-printable

=46rom: Kurt Garloff <garloff@suse.de>
Subject: Clean LSM stub file
References: SUSE40217, SUSE39439

Rather than having every LSM hook twice, once for the case with
CONFIG_SECURITY enabled and once for the disabled case, put
everything in one inline function. This reduces the chance of
the two to go out of sync immensely.

This is patch 2b/5 of the LSM overhaul.

 security.h | 1140 +++++++++++++++++---------------------------------------=
-----
 1 files changed, 330 insertions(+), 810 deletions(-)

Signed-off-by: Kurt Garloff <garloff@suse.de>

Index: linux-2.6.12/include/linux/security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.12.orig/include/linux/security.h
+++ linux-2.6.12/include/linux/security.h
@@ -1247,409 +1247,329 @@ struct security_operations {
=20
 /* global variables */
 extern struct security_operations *security_ops;
=20
-/* inline stuff */
-static inline int security_ptrace (struct task_struct * parent, struct tas=
k_struct * child)
+/* prototypes */
+extern int security_init	(void);
+extern int register_security	(struct security_operations *ops);
+extern int unregister_security	(struct security_operations *ops);
+extern int mod_reg_security	(const char *name, struct security_operations =
*ops);
+extern int mod_unreg_security	(const char *name, struct security_operation=
s *ops);
+
+#  define COND_SECURITY(seop, def) security_ops->seop
+
+# else /* CONFIG_SECURITY */
+static inline int security_init(void)
 {
-	return security_ops->ptrace (parent, child);
+	return 0;
 }
-# else /* CONFIG_SECURITY */
+
+#  define COND_SECURITY(seop, def) def
+# endif
+
+# ifdef CONFIG_SECURITY_NETWORK
+#  define COND_SECU_NET(seop, def) COND_SECURITY(seop, def)
+# else
+#  define COND_SECU_NET(seop, def) def
+# endif
+/* SELinux noop */
+# define SE_NOP ({})
+
+/* inline stuff */
 static inline int security_ptrace (struct task_struct *parent, struct task=
_struct * child)
 {
-	return cap_ptrace (parent, child);
+	return COND_SECURITY(ptrace (parent, child),
+			 cap_ptrace (parent, child));
 }
-# endif /* CONFIG_SECURITY */
=20
 static inline int security_capget (struct task_struct *target,
 				   kernel_cap_t *effective,
 				   kernel_cap_t *inheritable,
 				   kernel_cap_t *permitted)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->capget (target, effective, inheritable, permitted);
-# else /* CONFIG_SECURITY */
-	return cap_capget (target, effective, inheritable, permitted);
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(capget (target, effective, inheritable, permitted),
+			 cap_capget (target, effective, inheritable, permitted));
 }
=20
 static inline int security_capset_check (struct task_struct *target,
 					 kernel_cap_t *effective,
 					 kernel_cap_t *inheritable,
 					 kernel_cap_t *permitted)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->capset_check (target, effective, inheritable, permit=
ted);
-# else /* CONFIG_SECURITY */
-	return cap_capset_check (target, effective, inheritable, permitted);
-# endif /* CONFIG_SECURITY */
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
-# ifdef CONFIG_SECURITY
-	security_ops->capset_set (target, effective, inheritable, permitted);
-# else /* CONFIG_SECURITY */
-	cap_capset_set (target, effective, inheritable, permitted);
-# endif /* CONFIG_SECURITY */
+	COND_SECURITY(capset_set (target, effective, inheritable, permitted),
+		  cap_capset_set (target, effective, inheritable, permitted));
 }
=20
 static inline int security_acct (struct file *file)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->acct (file);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(acct (file),
+			 0);
 }
=20
 static inline int security_sysctl(struct ctl_table *table, int op)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->sysctl(table, op);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(sysctl(table, op),
+			 0);
 }
=20
 static inline int security_quotactl (int cmds, int type, int id,
-# ifdef CONFIG_SECURITY
 				     struct super_block *sb)
 {
-	return security_ops->quotactl (cmds, type, id, sb);
-# else /* CONFIG_SECURITY */
-				     struct super_block * sb)
-{
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(quotactl (cmds, type, id, sb),
+			 0);
 }
=20
 static inline int security_quota_on (struct dentry * dentry)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->quota_on (dentry);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(quota_on (dentry),
+			 0);
 }
=20
 static inline int security_syslog(int type)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->syslog(type);
-# else /* CONFIG_SECURITY */
-	return cap_syslog(type);
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(syslog(type),
+			 cap_syslog(type));
 }
=20
 static inline int security_settime(struct timespec *ts, struct timezone *t=
z)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->settime(ts, tz);
-# else /* CONFIG_SECURITY */
-	return cap_settime(ts, tz);
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(settime(ts, tz),
+			 cap_settime(ts, tz));
 }
=20
=20
 static inline int security_vm_enough_memory(long pages)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->vm_enough_memory(pages);
-# else /* CONFIG_SECURITY */
-	return cap_vm_enough_memory(pages);
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(vm_enough_memory(pages),
+			 cap_vm_enough_memory(pages));
 }
=20
 static inline int security_bprm_alloc (struct linux_binprm *bprm)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->bprm_alloc_security (bprm);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(bprm_alloc_security (bprm),
+			 0);
 }
+
 static inline void security_bprm_free (struct linux_binprm *bprm)
-# ifdef CONFIG_SECURITY
 {
-	security_ops->bprm_free_security (bprm);
+	COND_SECURITY(bprm_free_security (bprm),
+		  SE_NOP);
 }
-# else /* CONFIG_SECURITY */
-{ }
-# endif /* CONFIG_SECURITY */
+
 static inline void security_bprm_apply_creds (struct linux_binprm *bprm, i=
nt unsafe)
 {
-# ifdef CONFIG_SECURITY
-	security_ops->bprm_apply_creds (bprm, unsafe);
-# else /* CONFIG_SECURITY */
-	cap_bprm_apply_creds (bprm, unsafe);
-# endif /* CONFIG_SECURITY */
+	COND_SECURITY(bprm_apply_creds (bprm, unsafe),
+		  cap_bprm_apply_creds (bprm, unsafe));
 }
+
 static inline void security_bprm_post_apply_creds (struct linux_binprm *bp=
rm)
 {
-# ifdef CONFIG_SECURITY
-	security_ops->bprm_post_apply_creds (bprm);
-# else /* CONFIG_SECURITY */
-	return;
-# endif /* CONFIG_SECURITY */
+	COND_SECURITY(bprm_post_apply_creds (bprm),
+		  SE_NOP);
 }
+
 static inline int security_bprm_set (struct linux_binprm *bprm)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->bprm_set_security (bprm);
-# else /* CONFIG_SECURITY */
-	return cap_bprm_set_security (bprm);
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(bprm_set_security (bprm),
+			 cap_bprm_set_security (bprm));
 }
=20
 static inline int security_bprm_check (struct linux_binprm *bprm)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->bprm_check_security (bprm);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(bprm_check_security (bprm),
+			 0);
 }
=20
 static inline int security_bprm_secureexec (struct linux_binprm *bprm)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->bprm_secureexec (bprm);
-# else /* CONFIG_SECURITY */
-	return cap_bprm_secureexec(bprm);
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(bprm_secureexec (bprm),
+			 cap_bprm_secureexec (bprm));
 }
=20
 static inline int security_sb_alloc (struct super_block *sb)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->sb_alloc_security (sb);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(sb_alloc_security (sb),
+			 0);
 }
=20
 static inline void security_sb_free (struct super_block *sb)
-# ifdef CONFIG_SECURITY
 {
-	security_ops->sb_free_security (sb);
+	COND_SECURITY(sb_free_security (sb),
+		  SE_NOP);
 }
-# else /* CONFIG_SECURITY */
-{ }
-# endif /* CONFIG_SECURITY */
=20
 static inline int security_sb_copy_data (struct file_system_type *type,
 					 void *orig, void *copy)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->sb_copy_data (type, orig, copy);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(sb_copy_data (type, orig, copy),
+			 0);
 }
=20
 static inline int security_sb_kern_mount (struct super_block *sb, void *da=
ta)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->sb_kern_mount (sb, data);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(sb_kern_mount (sb, data),
+			 0);
 }
=20
 static inline int security_sb_statfs (struct super_block *sb)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->sb_statfs (sb);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(sb_statfs (sb),
+			 0);
 }
=20
 static inline int security_sb_mount (char *dev_name, struct nameidata *nd,
 				    char *type, unsigned long flags,
 				    void *data)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->sb_mount (dev_name, nd, type, flags, data);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(sb_mount (dev_name, nd, type, flags, data),
+			 0);
 }
=20
 static inline int security_sb_check_sb (struct vfsmount *mnt,
 					struct nameidata *nd)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->sb_check_sb (mnt, nd);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(sb_check_sb (mnt, nd),
+			 0);
 }
=20
 static inline int security_sb_umount (struct vfsmount *mnt, int flags)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->sb_umount (mnt, flags);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(sb_umount (mnt, flags),
+			 0);
 }
=20
 static inline void security_sb_umount_close (struct vfsmount *mnt)
-# ifdef CONFIG_SECURITY
 {
-	security_ops->sb_umount_close (mnt);
+	COND_SECURITY(sb_umount_close (mnt),
+		  SE_NOP);
 }
-# else /* CONFIG_SECURITY */
-{ }
-# endif /* CONFIG_SECURITY */
=20
 static inline void security_sb_umount_busy (struct vfsmount *mnt)
-# ifdef CONFIG_SECURITY
 {
-	security_ops->sb_umount_busy (mnt);
+	COND_SECURITY(sb_umount_busy (mnt),
+		  SE_NOP);
 }
-# else /* CONFIG_SECURITY */
-{ }
-# endif /* CONFIG_SECURITY */
=20
 static inline void security_sb_post_remount (struct vfsmount *mnt,
 					     unsigned long flags, void *data)
-# ifdef CONFIG_SECURITY
 {
-	security_ops->sb_post_remount (mnt, flags, data);
+	COND_SECURITY(sb_post_remount (mnt, flags, data),
+		  SE_NOP);
 }
-# else /* CONFIG_SECURITY */
-{ }
-# endif /* CONFIG_SECURITY */
=20
 static inline void security_sb_post_mountroot (void)
-# ifdef CONFIG_SECURITY
 {
-	security_ops->sb_post_mountroot ();
+	COND_SECURITY(sb_post_mountroot (),
+		  SE_NOP);
 }
-# else /* CONFIG_SECURITY */
-{ }
-# endif /* CONFIG_SECURITY */
=20
 static inline void security_sb_post_addmount (struct vfsmount *mnt,
 					      struct nameidata *mountpoint_nd)
-# ifdef CONFIG_SECURITY
 {
-	security_ops->sb_post_addmount (mnt, mountpoint_nd);
+	COND_SECURITY(sb_post_addmount (mnt, mountpoint_nd),
+		  SE_NOP);
 }
-# else /* CONFIG_SECURITY */
-{ }
-# endif /* CONFIG_SECURITY */
=20
 static inline int security_sb_pivotroot (struct nameidata *old_nd,
 					 struct nameidata *new_nd)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->sb_pivotroot (old_nd, new_nd);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(sb_pivotroot (old_nd, new_nd),
+			 0);
 }
=20
 static inline void security_sb_post_pivotroot (struct nameidata *old_nd,
 					       struct nameidata *new_nd)
-# ifdef CONFIG_SECURITY
 {
-	security_ops->sb_post_pivotroot (old_nd, new_nd);
+	COND_SECURITY(sb_post_pivotroot (old_nd, new_nd),
+		  SE_NOP);
 }
-# else /* CONFIG_SECURITY */
-{ }
-# endif /* CONFIG_SECURITY */
=20
 static inline int security_inode_alloc (struct inode *inode)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
-	return security_ops->inode_alloc_security (inode);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+# endif=09
+	return COND_SECURITY(inode_alloc_security (inode),
+			 0);
 }
=20
 static inline void security_inode_free (struct inode *inode)
-# ifdef CONFIG_SECURITY
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return;
-	security_ops->inode_free_security (inode);
-}
-# else /* CONFIG_SECURITY */
-{ }
 # endif /* CONFIG_SECURITY */
-=09
+	COND_SECURITY(inode_free_security (inode),
+		  SE_NOP);
+}
+
 static inline int security_inode_create (struct inode *dir,
 					 struct dentry *dentry,
 					 int mode)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dir)))
 		return 0;
-	return security_ops->inode_create (dir, dentry, mode);
-# else /* CONFIG_SECURITY */
-	return 0;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_create (dir, dentry, mode),
+			 0);
 }
=20
 static inline void security_inode_post_create (struct inode *dir,
 					       struct dentry *dentry,
 					       int mode)
-# ifdef CONFIG_SECURITY
 {
+# ifdef CONFIG_SECURITY
 	if (dentry->d_inode && unlikely (IS_PRIVATE (dentry->d_inode)))
 		return;
-	security_ops->inode_post_create (dir, dentry, mode);
-}
-# else /* CONFIG_SECURITY */
-{ }
 # endif /* CONFIG_SECURITY */
+	COND_SECURITY(inode_post_create (dir, dentry, mode),
+		  SE_NOP);
+}
=20
 static inline int security_inode_link (struct dentry *old_dentry,
 				       struct inode *dir,
 				       struct dentry *new_dentry)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (old_dentry->d_inode)))
 		return 0;
-	return security_ops->inode_link (old_dentry, dir, new_dentry);
-# else /* CONFIG_SECURITY */
-	return 0;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_link (old_dentry, dir, new_dentry),
+			 0);
 }
=20
 static inline void security_inode_post_link (struct dentry *old_dentry,
 					     struct inode *dir,
 					     struct dentry *new_dentry)
-# ifdef CONFIG_SECURITY
 {
+# ifdef CONFIG_SECURITY
 	if (new_dentry->d_inode && unlikely (IS_PRIVATE (new_dentry->d_inode)))
 		return;
-	security_ops->inode_post_link (old_dentry, dir, new_dentry);
-}
-# else /* CONFIG_SECURITY */
-{ }
 # endif /* CONFIG_SECURITY */
+	COND_SECURITY(inode_post_link (old_dentry, dir, new_dentry),
+		  SE_NOP);
+}
=20
 static inline int security_inode_unlink (struct inode *dir,
 					 struct dentry *dentry)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
-	return security_ops->inode_unlink (dir, dentry);
-# else /* CONFIG_SECURITY */
-	return 0;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_unlink (dir, dentry),
+			 0);
 }
=20
 static inline int security_inode_symlink (struct inode *dir,
 					  struct dentry *dentry,
@@ -1657,12 +1577,11 @@ static inline int security_inode_symlink
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dir)))
 		return 0;
-	return security_ops->inode_symlink (dir, dentry, old_name);
-# else /* CONFIG_SECURITY */
-	return 0;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_symlink (dir, dentry, old_name),
+			 0);
 }
=20
 static inline void security_inode_post_symlink (struct inode *dir,
 						struct dentry *dentry,
@@ -1670,50 +1589,46 @@ static inline void security_inode_post_s
 # ifdef CONFIG_SECURITY
 {
 	if (dentry->d_inode && unlikely (IS_PRIVATE (dentry->d_inode)))
 		return;
-	security_ops->inode_post_symlink (dir, dentry, old_name);
-}
-# else /* CONFIG_SECURITY */
-{ }
 # endif /* CONFIG_SECURITY */
+	COND_SECURITY(inode_post_symlink (dir, dentry, old_name),
+		  SE_NOP);
+}
=20
 static inline int security_inode_mkdir (struct inode *dir,
 					struct dentry *dentry,
 					int mode)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dir)))
 		return 0;
-	return security_ops->inode_mkdir (dir, dentry, mode);
-# else /* CONFIG_SECURITY */
-	return 0;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_mkdir (dir, dentry, mode),
+			 0);
 }
=20
 static inline void security_inode_post_mkdir (struct inode *dir,
 					      struct dentry *dentry,
 					      int mode)
-# ifdef CONFIG_SECURITY
 {
+# ifdef CONFIG_SECURITY
 	if (dentry->d_inode && unlikely (IS_PRIVATE (dentry->d_inode)))
 		return;
-	security_ops->inode_post_mkdir (dir, dentry, mode);
-}
-# else /* CONFIG_SECURITY */
-{ }
 # endif /* CONFIG_SECURITY */
+	COND_SECURITY(inode_post_mkdir (dir, dentry, mode),
+		  SE_NOP);
+}
=20
 static inline int security_inode_rmdir (struct inode *dir,
 					struct dentry *dentry)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
-	return security_ops->inode_rmdir (dir, dentry);
-# else /* CONFIG_SECURITY */
-	return 0;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_rmdir (dir, dentry),
+			 0);
 }
=20
 static inline int security_inode_mknod (struct inode *dir,
 					struct dentry *dentry,
@@ -1721,12 +1636,11 @@ static inline int security_inode_mknod (
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dir)))
 		return 0;
-	return security_ops->inode_mknod (dir, dentry, mode, dev);
-# else /* CONFIG_SECURITY */
-	return 0;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_mknod (dir, dentry, mode, dev),
+			 0);
 }
=20
 static inline void security_inode_post_mknod (struct inode *dir,
 					      struct dentry *dentry,
@@ -1734,13 +1648,12 @@ static inline void security_inode_post_m
 # ifdef CONFIG_SECURITY
 {
 	if (dentry->d_inode && unlikely (IS_PRIVATE (dentry->d_inode)))
 		return;
-	security_ops->inode_post_mknod (dir, dentry, mode, dev);
-}
-# else /* CONFIG_SECURITY */
-{ }
 # endif /* CONFIG_SECURITY */
+	COND_SECURITY(inode_post_mknod (dir, dentry, mode, dev),
+		  SE_NOP);
+}
=20
 static inline int security_inode_rename (struct inode *old_dir,
 					 struct dentry *old_dentry,
 					 struct inode *new_dir,
@@ -1749,1065 +1662,672 @@ static inline int security_inode_rename=20
 # ifdef CONFIG_SECURITY
         if (unlikely (IS_PRIVATE (old_dentry->d_inode) ||
             (new_dentry->d_inode && IS_PRIVATE (new_dentry->d_inode))))
 		return 0;
-	return security_ops->inode_rename (old_dir, old_dentry,
-					   new_dir, new_dentry);
-# else /* CONFIG_SECURITY */
-	return 0;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_rename (old_dir, old_dentry,
+					   new_dir, new_dentry),
+			 0);
 }
=20
 static inline void security_inode_post_rename (struct inode *old_dir,
 					       struct dentry *old_dentry,
 					       struct inode *new_dir,
 					       struct dentry *new_dentry)
-# ifdef CONFIG_SECURITY
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (old_dentry->d_inode) ||
 	    (new_dentry->d_inode && IS_PRIVATE (new_dentry->d_inode))))
 		return;
-	security_ops->inode_post_rename (old_dir, old_dentry,
-						new_dir, new_dentry);
-}
-# else /* CONFIG_SECURITY */
-{ }
 # endif /* CONFIG_SECURITY */
+	COND_SECURITY(inode_post_rename (old_dir, old_dentry,
+					 new_dir, new_dentry),
+		  SE_NOP);
+}
=20
 static inline int security_inode_readlink (struct dentry *dentry)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
-	return security_ops->inode_readlink (dentry);
-# else /* CONFIG_SECURITY */
-	return 0;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_readlink (dentry),
+			 0);
 }
=20
 static inline int security_inode_follow_link (struct dentry *dentry,
 					      struct nameidata *nd)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
-	return security_ops->inode_follow_link (dentry, nd);
-# else /* CONFIG_SECURITY */
-	return 0;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_follow_link (dentry, nd),
+			 0);
 }
=20
 static inline int security_inode_permission (struct inode *inode, int mask,
 					     struct nameidata *nd)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
-	return security_ops->inode_permission (inode, mask, nd);
-# else /* CONFIG_SECURITY */
-	return 0;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_permission (inode, mask, nd),
+			 0);
 }
=20
 static inline int security_inode_setattr (struct dentry *dentry,
 					  struct iattr *attr)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
-	return security_ops->inode_setattr (dentry, attr);
-# else /* CONFIG_SECURITY */
-	return 0;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_setattr (dentry, attr),
+			 0);
 }
=20
 static inline int security_inode_getattr (struct vfsmount *mnt,
 					  struct dentry *dentry)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
-	return security_ops->inode_getattr (mnt, dentry);
-# else /* CONFIG_SECURITY */
-	return 0;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_getattr (mnt, dentry),
+			 0);
 }
=20
 static inline void security_inode_delete (struct inode *inode)
-# ifdef CONFIG_SECURITY
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return;
-	security_ops->inode_delete (inode);
-}
-# else /* CONFIG_SECURITY */
-{ }
 # endif /* CONFIG_SECURITY */
+	COND_SECURITY(inode_delete (inode),
+		  SE_NOP);
+}
=20
 static inline int security_inode_setxattr (struct dentry *dentry, char *na=
me,
 					   void *value, size_t size, int flags)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
-	return security_ops->inode_setxattr (dentry, name, value, size, flags);
-# else /* CONFIG_SECURITY */
-	return cap_inode_setxattr(dentry, name, value, size, flags);
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_setxattr (dentry, name, value, size, flags),
+			 cap_inode_setxattr (dentry, name, value, size, flags));
 }
=20
 static inline void security_inode_post_setxattr (struct dentry *dentry, ch=
ar *name,
-						void *value, size_t size, int flags)
-# ifdef CONFIG_SECURITY
+						 void *value, size_t size, int flags)
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return;
-	security_ops->inode_post_setxattr (dentry, name, value, size, flags);
-}
-# else /* CONFIG_SECURITY */
-{ }
 # endif /* CONFIG_SECURITY */
+	COND_SECURITY(inode_post_setxattr (dentry, name, value, size, flags),
+		  SE_NOP);
+}
=20
 static inline int security_inode_getxattr (struct dentry *dentry, char *na=
me)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
-	return security_ops->inode_getxattr (dentry, name);
-# else /* CONFIG_SECURITY */
-	return 0;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_getxattr (dentry, name),
+			 0);
 }
=20
 static inline int security_inode_listxattr (struct dentry *dentry)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
-	return security_ops->inode_listxattr (dentry);
-# else /* CONFIG_SECURITY */
-	return 0;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_listxattr (dentry),
+			 0);
 }
=20
 static inline int security_inode_removexattr (struct dentry *dentry, char =
*name)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (dentry->d_inode)))
 		return 0;
-	return security_ops->inode_removexattr (dentry, name);
-# else /* CONFIG_SECURITY */
-	return cap_inode_removexattr(dentry, name);
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_removexattr (dentry, name),
+			 cap_inode_removexattr (dentry, name));
 }
=20
 static inline int security_inode_getsecurity(struct inode *inode, const ch=
ar *name, void *buffer, size_t size)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
-	return security_ops->inode_getsecurity(inode, name, buffer, size);
-# else /* CONFIG_SECURITY */
-	return -EOPNOTSUPP;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_getsecurity(inode, name, buffer, size),
+			 -EOPNOTSUPP);
 }
=20
-static inline int security_inode_setsecurity(struct inode *inode, const ch=
ar *name, const void *value, size_t size, int flags)
+static inline int security_inode_setsecurity(struct inode *inode, const ch=
ar *name,=20
+					     const void *value, size_t size, int flags)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
-	return security_ops->inode_setsecurity(inode, name, value, size, flags);
-# else /* CONFIG_SECURITY */
-	return -EOPNOTSUPP;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_setsecurity(inode, name, value, size, flags),
+			 -EOPNOTSUPP);
 }
=20
 static inline int security_inode_listsecurity(struct inode *inode, char *b=
uffer, size_t buffer_size)
 {
 # ifdef CONFIG_SECURITY
 	if (unlikely (IS_PRIVATE (inode)))
 		return 0;
-	return security_ops->inode_listsecurity(inode, buffer, buffer_size);
-# else /* CONFIG_SECURITY */
-	return 0;
 # endif /* CONFIG_SECURITY */
+	return COND_SECURITY(inode_listsecurity(inode, buffer, buffer_size),
+			 0);
 }
=20
 static inline int security_file_permission (struct file *file, int mask)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->file_permission (file, mask);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(file_permission (file, mask),
+			 0);
 }
=20
 static inline int security_file_alloc (struct file *file)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->file_alloc_security (file);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(file_alloc_security (file),
+			 0);
 }
=20
 static inline void security_file_free (struct file *file)
-# ifdef CONFIG_SECURITY
 {
-	security_ops->file_free_security (file);
+	COND_SECURITY(file_free_security (file),
+		  SE_NOP);
 }
-# else /* CONFIG_SECURITY */
-{ }
-# endif /* CONFIG_SECURITY */
=20
 static inline int security_file_ioctl (struct file *file, unsigned int cmd,
 				       unsigned long arg)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->file_ioctl (file, cmd, arg);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(file_ioctl (file, cmd, arg),
+			 0);
 }
=20
 static inline int security_file_mmap (struct file *file, unsigned long req=
prot,
 				      unsigned long prot,
 				      unsigned long flags)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->file_mmap (file, reqprot, prot, flags);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(file_mmap (file, reqprot, prot, flags),
+			 0);
 }
=20
 static inline int security_file_mprotect (struct vm_area_struct *vma,
 					  unsigned long reqprot,
 					  unsigned long prot)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->file_mprotect (vma, reqprot, prot);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(file_mprotect (vma, reqprot, prot),
+			 0);
 }
=20
 static inline int security_file_lock (struct file *file, unsigned int cmd)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->file_lock (file, cmd);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(file_lock (file, cmd),
+			 0);
 }
=20
 static inline int security_file_fcntl (struct file *file, unsigned int cmd,
 				       unsigned long arg)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->file_fcntl (file, cmd, arg);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(file_fcntl (file, cmd, arg),
+			 0);
 }
=20
 static inline int security_file_set_fowner (struct file *file)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->file_set_fowner (file);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(file_set_fowner (file),
+			 0);
 }
=20
 static inline int security_file_send_sigiotask (struct task_struct *tsk,
 						struct fown_struct *fown,
 						int sig)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->file_send_sigiotask (tsk, fown, sig);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(file_send_sigiotask (tsk, fown, sig),
+			 0);
 }
=20
 static inline int security_file_receive (struct file *file)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->file_receive (file);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(file_receive (file),
+			 0);
 }
=20
 static inline int security_task_create (unsigned long clone_flags)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->task_create (clone_flags);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(task_create (clone_flags),
+			 0);
 }
=20
 static inline int security_task_alloc (struct task_struct *p)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->task_alloc_security (p);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(task_alloc_security (p),
+			 0);
 }
=20
 static inline void security_task_free (struct task_struct *p)
-# ifdef CONFIG_SECURITY
 {
-	security_ops->task_free_security (p);
+	COND_SECURITY(task_free_security (p),
+		  SE_NOP);
 }
-# else /* CONFIG_SECURITY */
-{ }
-# endif /* CONFIG_SECURITY */
=20
 static inline int security_task_setuid (uid_t id0, uid_t id1, uid_t id2,
 					int flags)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->task_setuid (id0, id1, id2, flags);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(task_setuid (id0, id1, id2, flags),
+			 0);
 }
=20
 static inline int security_task_post_setuid (uid_t old_ruid, uid_t old_eui=
d,
 					     uid_t old_suid, int flags)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->task_post_setuid (old_ruid, old_euid, old_suid, flag=
s);
-# else /* CONFIG_SECURITY */
-	return cap_task_post_setuid (old_ruid, old_euid, old_suid, flags);
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(task_post_setuid (old_ruid, old_euid, old_suid, flag=
s),
+			 cap_task_post_setuid (old_ruid, old_euid, old_suid, flags));
 }
=20
 static inline int security_task_setgid (gid_t id0, gid_t id1, gid_t id2,
 					int flags)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->task_setgid (id0, id1, id2, flags);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(task_setgid (id0, id1, id2, flags),
+			 0);
 }
=20
 static inline int security_task_setpgid (struct task_struct *p, pid_t pgid)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->task_setpgid (p, pgid);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(task_setpgid (p, pgid),
+			 0);
 }
=20
 static inline int security_task_getpgid (struct task_struct *p)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->task_getpgid (p);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(task_getpgid (p),
+			 0);
 }
=20
 static inline int security_task_getsid (struct task_struct *p)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->task_getsid (p);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(task_getsid (p),
+			 0);
 }
=20
 static inline int security_task_setgroups (struct group_info *group_info)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->task_setgroups (group_info);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(task_setgroups (group_info),
+			 0);
 }
=20
 static inline int security_task_setnice (struct task_struct *p, int nice)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->task_setnice (p, nice);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(task_setnice (p, nice),
+			 0);
 }
=20
 static inline int security_task_setrlimit (unsigned int resource,
 					   struct rlimit *new_rlim)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->task_setrlimit (resource, new_rlim);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(task_setrlimit (resource, new_rlim),
+			 0);
 }
=20
 static inline int security_task_setscheduler (struct task_struct *p,
 					      int policy,
 					      struct sched_param *lp)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->task_setscheduler (p, policy, lp);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(task_setscheduler (p, policy, lp),
+			 0);
 }
=20
 static inline int security_task_getscheduler (struct task_struct *p)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->task_getscheduler (p);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(task_getscheduler (p),
+			 0);
 }
=20
 static inline int security_task_kill (struct task_struct *p,
 				      struct siginfo *info, int sig)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->task_kill (p, info, sig);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(task_kill (p, info, sig),
+			 0);
 }
=20
 static inline int security_task_wait (struct task_struct *p)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->task_wait (p);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(task_wait (p),
+			 0);
 }
=20
 static inline int security_task_prctl (int option, unsigned long arg2,
 				       unsigned long arg3,
 				       unsigned long arg4,
 				       unsigned long arg5)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->task_prctl (option, arg2, arg3, arg4, arg5);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(task_prctl (option, arg2, arg3, arg4, arg5),
+			 0);
 }
=20
 static inline void security_task_reparent_to_init (struct task_struct *p)
 {
-# ifdef CONFIG_SECURITY
-	security_ops->task_reparent_to_init (p);
-# else /* CONFIG_SECURITY */
-	cap_task_reparent_to_init (p);
-# endif /* CONFIG_SECURITY */
+	COND_SECURITY(task_reparent_to_init (p),
+		  cap_task_reparent_to_init (p));
 }
=20
 static inline void security_task_to_inode(struct task_struct *p, struct in=
ode *inode)
-# ifdef CONFIG_SECURITY
 {
-	security_ops->task_to_inode(p, inode);
+	COND_SECURITY(task_to_inode(p, inode),
+		  SE_NOP);
 }
-# else /* CONFIG_SECURITY */
-{ }
-# endif /* CONFIG_SECURITY */
=20
 static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
 					   short flag)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->ipc_permission (ipcp, flag);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(ipc_permission (ipcp, flag),
+			 0);
 }
=20
 static inline int security_msg_msg_alloc (struct msg_msg * msg)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->msg_msg_alloc_security (msg);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(msg_msg_alloc_security (msg),
+			 0);
 }
=20
 static inline void security_msg_msg_free (struct msg_msg * msg)
-# ifdef CONFIG_SECURITY
 {
-	security_ops->msg_msg_free_security(msg);
+	COND_SECURITY(msg_msg_free_security(msg),
+		  SE_NOP);
 }
-# else /* CONFIG_SECURITY */
-{ }
-# endif /* CONFIG_SECURITY */
=20
 static inline int security_msg_queue_alloc (struct msg_queue *msq)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->msg_queue_alloc_security (msq);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(msg_queue_alloc_security (msq),
+			 0);
 }
=20
 static inline void security_msg_queue_free (struct msg_queue *msq)
-# ifdef CONFIG_SECURITY
 {
-	security_ops->msg_queue_free_security (msq);
+	COND_SECURITY(msg_queue_free_security (msq),
+		  SE_NOP);
 }
-# else /* CONFIG_SECURITY */
-{ }
-# endif /* CONFIG_SECURITY */
=20
 static inline int security_msg_queue_associate (struct msg_queue * msq,=20
 						int msqflg)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->msg_queue_associate (msq, msqflg);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(msg_queue_associate (msq, msqflg),
+			 0);
 }
=20
 static inline int security_msg_queue_msgctl (struct msg_queue * msq, int c=
md)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->msg_queue_msgctl (msq, cmd);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(msg_queue_msgctl (msq, cmd),
+			 0);
 }
=20
 static inline int security_msg_queue_msgsnd (struct msg_queue * msq,
 					     struct msg_msg * msg, int msqflg)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->msg_queue_msgsnd (msq, msg, msqflg);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(msg_queue_msgsnd (msq, msg, msqflg),
+			 0);
 }
=20
 static inline int security_msg_queue_msgrcv (struct msg_queue * msq,
 					     struct msg_msg * msg,
 					     struct task_struct * target,
 					     long type, int mode)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->msg_queue_msgrcv (msq, msg, target, type, mode);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(msg_queue_msgrcv (msq, msg, target, type, mode),
+			 0);
 }
=20
 static inline int security_shm_alloc (struct shmid_kernel *shp)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->shm_alloc_security (shp);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(shm_alloc_security (shp),
+			 0);
 }
=20
 static inline void security_shm_free (struct shmid_kernel *shp)
-# ifdef CONFIG_SECURITY
 {
-	security_ops->shm_free_security (shp);
+	COND_SECURITY(shm_free_security (shp),
+		  SE_NOP);
 }
-# else /* CONFIG_SECURITY */
-{ }
-# endif /* CONFIG_SECURITY */
=20
 static inline int security_shm_associate (struct shmid_kernel * shp,=20
 					  int shmflg)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->shm_associate(shp, shmflg);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(shm_associate(shp, shmflg),
+			 0);
 }
=20
 static inline int security_shm_shmctl (struct shmid_kernel * shp, int cmd)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->shm_shmctl (shp, cmd);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(shm_shmctl (shp, cmd),
+			 0);
 }
=20
 static inline int security_shm_shmat (struct shmid_kernel * shp,=20
 				      char __user *shmaddr, int shmflg)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->shm_shmat(shp, shmaddr, shmflg);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(shm_shmat(shp, shmaddr, shmflg),
+			 0);
 }
=20
 static inline int security_sem_alloc (struct sem_array *sma)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->sem_alloc_security (sma);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(sem_alloc_security (sma),
+			 0);
 }
=20
 static inline void security_sem_free (struct sem_array *sma)
-# ifdef CONFIG_SECURITY
 {
-	security_ops->sem_free_security (sma);
+	COND_SECURITY(sem_free_security (sma),
+		  SE_NOP);
 }
-# else /* CONFIG_SECURITY */
-{ }
-# endif /* CONFIG_SECURITY */
=20
 static inline int security_sem_associate (struct sem_array * sma, int semf=
lg)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->sem_associate (sma, semflg);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(sem_associate (sma, semflg),
+			 0);
 }
=20
 static inline int security_sem_semctl (struct sem_array * sma, int cmd)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->sem_semctl(sma, cmd);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(sem_semctl(sma, cmd),
+			 0);
 }
=20
 static inline int security_sem_semop (struct sem_array * sma,=20
 				      struct sembuf * sops, unsigned nsops,=20
 				      int alter)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->sem_semop(sma, sops, nsops, alter);
-# else /* CONFIG_SECURITY */
-	return 0;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(sem_semop(sma, sops, nsops, alter),
+			 0);
 }
=20
 static inline void security_d_instantiate (struct dentry *dentry, struct i=
node *inode)
-# ifdef CONFIG_SECURITY
 {
+# ifdef CONFIG_SECURITY
 	if (unlikely (inode && IS_PRIVATE (inode)))
 		return;
-	security_ops->d_instantiate (dentry, inode);
-}
-# else /* CONFIG_SECURITY */
-{ }
 # endif /* CONFIG_SECURITY */
+	COND_SECURITY(d_instantiate (dentry, inode),
+		  SE_NOP);
+}
=20
 static inline int security_getprocattr(struct task_struct *p, char *name, =
void *value, size_t size)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->getprocattr(p, name, value, size);
-# else /* CONFIG_SECURITY */
-	return -EINVAL;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(getprocattr(p, name, value, size),
+			 -EINVAL);
 }
=20
 static inline int security_setprocattr(struct task_struct *p, char *name, =
void *value, size_t size)
 {
-# ifdef CONFIG_SECURITY
-	return security_ops->setprocattr(p, name, value, size);
-# else /* CONFIG_SECURITY */
-	return -EINVAL;
-# endif /* CONFIG_SECURITY */
+	return COND_SECURITY(setprocattr(p, name, value, size),
+			 -EINVAL);
 }
=20
-# ifdef CONFIG_SECURITY
 static inline int security_netlink_send(struct sock *sk, struct sk_buff * =
skb)
 {
-	return security_ops->netlink_send(sk, skb);
-}
-# else /* CONFIG_SECURITY */
-static inline int security_netlink_send (struct sock *sk, struct sk_buff *=
skb)
-{
-	return cap_netlink_send (sk, skb);
+	return COND_SECURITY(netlink_send(sk, skb),
+			 cap_netlink_send(sk, skb));
 }
-# endif /* CONFIG_SECURITY */
-# ifdef CONFIG_SECURITY
=20
 static inline int security_netlink_recv(struct sk_buff * skb)
 {
-	return security_ops->netlink_recv(skb);
+	return COND_SECURITY(netlink_recv(skb),
+			 cap_netlink_recv(skb));
 }
-# else /* CONFIG_SECURITY */
-static inline int security_netlink_recv (struct sk_buff *skb)
-{
-	return cap_netlink_recv (skb);
-}
-# endif /* CONFIG_SECURITY */
-# ifdef CONFIG_SECURITY
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
-# else /* CONFIG_SECURITY */
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
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-=09
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-# endif /* CONFIG_SECURITY */
=20
+/* CONFIG_SECURITY_NETWORK stubs */
 static inline int security_unix_stream_connect(struct socket * sock,
 					       struct socket * other,=20
 					       struct sock * newsk)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->unix_stream_connect(sock, other, newsk);
-# else /* CONFIG_SECURITY_NETWORK */
-	return 0;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(unix_stream_connect(sock, other, newsk),
+			 0);
 }
=20
=20
 static inline int security_unix_may_send(struct socket * sock,=20
 					 struct socket * other)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->unix_may_send(sock, other);
-# else /* CONFIG_SECURITY_NETWORK */
-	return 0;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(unix_may_send(sock, other),
+			 0);
 }
=20
 static inline int security_socket_create (int family, int type,
 					  int protocol, int kern)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->socket_create(family, type, protocol, kern);
-# else /* CONFIG_SECURITY_NETWORK */
-	return 0;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(socket_create(family, type, protocol, kern),
+			 0);
 }
=20
 static inline void security_socket_post_create(struct socket * sock,=20
 					       int family,
 					       int type,=20
 					       int protocol, int kern)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	security_ops->socket_post_create(sock, family, type,
-					 protocol, kern);
-# endif /* CONFIG_SECURITY_NETWORK */
+	COND_SECU_NET(socket_post_create(sock, family, type,
+					 protocol, kern),
+		  SE_NOP);
 }
=20
 static inline int security_socket_bind(struct socket * sock,=20
 				       struct sockaddr * address,=20
 				       int addrlen)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->socket_bind(sock, address, addrlen);
-# else /* CONFIG_SECURITY_NETWORK */
-	return 0;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(socket_bind(sock, address, addrlen),
+			 0);
 }
=20
 static inline int security_socket_connect(struct socket * sock,=20
 					  struct sockaddr * address,=20
 					  int addrlen)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->socket_connect(sock, address, addrlen);
-# else /* CONFIG_SECURITY_NETWORK */
-	return 0;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(socket_connect(sock, address, addrlen),
+			 0);
 }
=20
 static inline int security_socket_listen(struct socket * sock, int backlog)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->socket_listen(sock, backlog);
-# else /* CONFIG_SECURITY_NETWORK */
-	return 0;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(socket_listen(sock, backlog),
+			 0);
 }
=20
 static inline int security_socket_accept(struct socket * sock,=20
 					 struct socket * newsock)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->socket_accept(sock, newsock);
-# else /* CONFIG_SECURITY_NETWORK */
-	return 0;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(socket_accept(sock, newsock),
+			 0);
 }
=20
 static inline void security_socket_post_accept(struct socket * sock,=20
 					       struct socket * newsock)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	security_ops->socket_post_accept(sock, newsock);
-# endif /* CONFIG_SECURITY_NETWORK */
+	COND_SECU_NET(socket_post_accept(sock, newsock),
+		  SE_NOP);
 }
=20
 static inline int security_socket_sendmsg(struct socket * sock,=20
 					  struct msghdr * msg, int size)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->socket_sendmsg(sock, msg, size);
-# else /* CONFIG_SECURITY_NETWORK */
-	return 0;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(socket_sendmsg(sock, msg, size),
+			 0);
 }
=20
 static inline int security_socket_recvmsg(struct socket * sock,=20
 					  struct msghdr * msg, int size,=20
 					  int flags)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->socket_recvmsg(sock, msg, size, flags);
-# else /* CONFIG_SECURITY_NETWORK */
-	return 0;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(socket_recvmsg(sock, msg, size, flags),
+			 0);
 }
=20
 static inline int security_socket_getsockname(struct socket * sock)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->socket_getsockname(sock);
-# else /* CONFIG_SECURITY_NETWORK */
-	return 0;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(socket_getsockname(sock),
+			 0);
 }
=20
 static inline int security_socket_getpeername(struct socket * sock)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->socket_getpeername(sock);
-# else /* CONFIG_SECURITY_NETWORK */
-	return 0;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(socket_getpeername(sock),
+			 0);
 }
=20
 static inline int security_socket_getsockopt(struct socket * sock,=20
 					     int level, int optname)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->socket_getsockopt(sock, level, optname);
-# else /* CONFIG_SECURITY_NETWORK */
-	return 0;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(socket_getsockopt(sock, level, optname),
+			 0);
 }
=20
 static inline int security_socket_setsockopt(struct socket * sock,=20
 					     int level, int optname)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->socket_setsockopt(sock, level, optname);
-# else /* CONFIG_SECURITY_NETWORK */
-	return 0;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(socket_setsockopt(sock, level, optname),
+			 0);
 }
=20
 static inline int security_socket_shutdown(struct socket * sock, int how)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->socket_shutdown(sock, how);
-# else /* CONFIG_SECURITY_NETWORK */
-	return 0;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(socket_shutdown(sock, how),
+			 0);
 }
=20
 static inline int security_sock_rcv_skb (struct sock * sk,=20
 					 struct sk_buff * skb)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->socket_sock_rcv_skb (sk, skb);
-# else /* CONFIG_SECURITY_NETWORK */
-	return 0;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(socket_sock_rcv_skb (sk, skb),
+			 0);
 }
=20
 static inline int security_socket_getpeersec(struct socket *sock, char __u=
ser *optval,
 					     int __user *optlen, unsigned len)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->socket_getpeersec(sock, optval, optlen, len);
-# else /* CONFIG_SECURITY_NETWORK */
-	return -ENOPROTOOPT;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(socket_getpeersec(sock, optval, optlen, len),
+			 -ENOPROTOOPT);
 }
=20
 static inline int security_sk_alloc(struct sock *sk, int family, int prior=
ity)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->sk_alloc_security(sk, family, priority);
-# else /* CONFIG_SECURITY_NETWORK */
-	return 0;
-# endif /* CONFIG_SECURITY_NETWORK */
+	return COND_SECU_NET(sk_alloc_security(sk, family, priority),
+			 0);
 }
=20
 static inline void security_sk_free(struct sock *sk)
 {
-# ifdef CONFIG_SECURITY_NETWORK
-	return security_ops->sk_free_security(sk);
-# endif /* CONFIG_SECURITY_NETWORK */
+	COND_SECU_NET(sk_free_security(sk),
+		  SE_NOP);
 }
=20
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
-
 #endif /* __LINUX_SECURITY_H */
-

--jkO+KyKz7TfD21mV--

--jt0yj30bxbg11sci
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCyAe8xmLh6hyYd04RAnsWAJ9N55mRp/qooald38ZmElcslbZjtQCbB2rp
w+cWqc3jxaYyLcPmotgd4yE=
=zcbI
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--
