Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUHJJzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUHJJzm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUHJJzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:55:42 -0400
Received: from cantor.suse.de ([195.135.220.2]:53197 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263772AbUHJJuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:50:24 -0400
Date: Tue, 10 Aug 2004 10:57:46 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH] [LSM] Rework LSM hooks
Message-ID: <20040810085746.GB12445@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OzxllxdKGCiKxUZM"
Content-Disposition: inline
X-Operating-System: Linux 2.6.7-0-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OzxllxdKGCiKxUZM
Content-Type: multipart/mixed; boundary="Lb0e7rgc7IsuDeGj"
Content-Disposition: inline


--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

while looking into LSM hooks and SElinux for SLES9, we came across
a couple of issues and the whole thing ended up in a patch that I
think should be applied upstream.

Some boundary conditions:
* We don't want to use selinux by default: The complexity to set up a
  secure system using it is currently quite complex
* The impact of SElinux on performance on SMP is disastrous
* SElinux needs to be compiled in
* CONFIG_SECURITY should remain on -- it allows the flexibility to
  use different LSMs
* This however has the nasty side-effect of ending up with a system
  that uses dummy rather than the Linux default capabilities; so your
  boot up scripts need to take care of loading it. Making capability
  static is no option either, of course, as you want to be able to
  use a different primary LSM or load capability as secondary LSM.
* Even with selinux=3D0 and capability loaded, the kernel takes a=20
  few percents in networking benchmarks (measured by HP on ia64);=20
  this is caused by the slowliness of indirect jumps on ia64.

The first patch patch does just change the selinux default; so you
need to enable with selinux=3D1.

The second patch is much more involved.
* It changes the hooks in security.h to present the CONFIG_SECURITY
  vs. non CONFIG_SECURITY alongside each other; this way the programmer=20
  can not easily get these out of sync, as that would become optically=20
   offending.
* It uses a macro and only calls into the LSM if a module is loaded
  if(unlikely(security_enabled)) and otherwise calls into the capability
  code just like if CONFIG_SECURITY was off
* This changes the default to be capabilty, not dummy!
  So no LSM needs to be loaded to offer Linux defaults.
* However, dummy still needs to be compiled in as it serves as default
  implementaion for non-defined routines in the loaded LSM.
  Actually, I would like to get rid of it, but did not want to
  change existing behaviour with this patch.
  (Probably one should review existing LSMs: They should be pretty
   much complete and falling back to capability for the few missing
   functions may be fine -- sometimes dummy and capability are even
   the same ...)
* capability should be compiled a module; so it can be loaded as
  secondary LSM; it can also still be loaded as primary LSM; the only=20
  effect of that is a minimal slowdown as the indirect jump would be
  taken ...
* Some implementation details are documented in the code; I avoid=20
  LSM unload races without using a barrier (or locking) by setting=20
  security_ops to capability_security_ops, e.g.=20

Both patches are against 2.6.8-rc3.
And, yes, they're pretty well tested, more exactly the versions
against 2.6.5 ;-)

Please comment / apply,
--=20
Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
SUSE LINUX AG / Novell, Nuernberg, DE               Director SUSE Labs

--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=selinux-default-disable
Content-Transfer-Encoding: quoted-printable

garloff@suse.de

Performance fix

With selinux enabled, performance sucks, as avc_lock spinlock is taken
in the fast path. #39439

--- linux-2.6.5.x86/security/selinux/hooks.c.orig	2004-05-03 15:15:48.00000=
0000 +0200
+++ linux-2.6.5.x86/security/selinux/hooks.c	2004-05-10 15:14:38.264941199 =
+0200
@@ -82,7 +82,7 @@ __setup("enforcing=3D", enforcing_setup);
 #endif
=20
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
-int selinux_enabled =3D 1;
+int selinux_enabled =3D 0;
=20
 static int __init selinux_enabled_setup(char *str)
 {

--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=security-disabled-optimize-cap-default
Content-Transfer-Encoding: quoted-printable

garloff@suse.de

Performance & Cleanup

After idea from Brian Haley (HP):
Don't do indirect calls if security_enabled is off.
It is switched on if a security module registers.=20
We don't need to register one any longer to get capabilities.
The commoncaps is always compiled in now, the capability module should
be compiled as a module, so it can be registered as secondary module
(on top of SElinux, e.g.) again. It can be loaded as primary module,
but this won't change anything except rendering performance somewhat
worse.

Index: linux-2.6.7/include/linux/security.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.7.orig/include/linux/security.h	2004-08-05 14:58:22.439493894=
 +0200
+++ linux-2.6.7/include/linux/security.h	2004-08-05 15:23:42.374099009 +0200
@@ -1232,11 +1232,21 @@
=20
 /* global variables */
 extern struct security_operations *security_ops;
+extern int security_enabled;
+
+/* Condition for selinux security_ops invocation */
+#define COND_SECURITY(seop, def)		\
+	(unlikely(security_enabled))? security_ops->seop: def
+
+/* SELinux noop */
+static inline void __selinux_nop(void) {}
+#define SE_NOP __selinux_nop()=20
=20
 /* inline stuff */
 static inline int security_ptrace (struct task_struct * parent, struct tas=
k_struct * child)
 {
-	return security_ops->ptrace (parent, child);
+	return COND_SECURITY(ptrace (parent, child),=20
+			 cap_ptrace (parent, child));
 }
=20
 static inline int security_capget (struct task_struct *target,
@@ -1244,7 +1263,8 @@
 				   kernel_cap_t *inheritable,
 				   kernel_cap_t *permitted)
 {
-	return security_ops->capget (target, effective, inheritable, permitted);
+	return COND_SECURITY(capget (target, effective, inheritable, permitted),
+			 cap_capget (target, effective, inheritable, permitted));
 }
=20
 static inline int security_capset_check (struct task_struct *target,
@@ -1252,7 +1272,8 @@
 					 kernel_cap_t *inheritable,
 					 kernel_cap_t *permitted)
 {
-	return security_ops->capset_check (target, effective, inheritable, permit=
ted);
+	return COND_SECURITY(capset_check (target, effective, inheritable, permit=
ted),=20
+			 cap_capset_check (target, effective, inheritable, permitted));
 }
=20
 static inline void security_capset_set (struct task_struct *target,
@@ -1260,240 +1281,282 @@
 					kernel_cap_t *inheritable,
 					kernel_cap_t *permitted)
 {
-	security_ops->capset_set (target, effective, inheritable, permitted);
+	COND_SECURITY(capset_set (target, effective, inheritable, permitted),=20
+		  cap_capset_set (target, effective, inheritable, permitted));
 }
=20
 static inline int security_acct (struct file *file)
 {
-	return security_ops->acct (file);
+	return COND_SECURITY(acct (file),=20
+			 0);
 }
=20
 static inline int security_sysctl(ctl_table * table, int op)
 {
-	return security_ops->sysctl(table, op);
+	return COND_SECURITY(sysctl(table, op),=20
+			 0);
 }
=20
 static inline int security_quotactl (int cmds, int type, int id,
 				     struct super_block *sb)
 {
-	return security_ops->quotactl (cmds, type, id, sb);
+	return COND_SECURITY(quotactl (cmds, type, id, sb),=20
+			 0);
 }
=20
 static inline int security_quota_on (struct file * file)
 {
-	return security_ops->quota_on (file);
+	return COND_SECURITY(quota_on (file),=20
+			 0);
 }
=20
 static inline int security_syslog(int type)
 {
-	return security_ops->syslog(type);
+	return COND_SECURITY(syslog(type),=20
+			 cap_syslog(type));
 }
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
+	return COND_SECURITY(bprm_alloc_security (bprm),=20
+			 0);
 }
 static inline void security_bprm_free (struct linux_binprm *bprm)
 {
-	security_ops->bprm_free_security (bprm);
+	COND_SECURITY(bprm_free_security (bprm),=20
+		  SE_NOP);
 }
 static inline void security_bprm_apply_creds (struct linux_binprm *bprm, i=
nt unsafe)
 {
-	security_ops->bprm_apply_creds (bprm, unsafe);
+	COND_SECURITY(bprm_apply_creds (bprm, unsafe),=20
+		  cap_bprm_apply_creds (bprm, unsafe));
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
+	return COND_SECURITY(bprm_check_security (bprm),=20
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
+	return COND_SECURITY(sb_alloc_security (sb),=20
+			 0);
 }
=20
 static inline void security_sb_free (struct super_block *sb)
 {
-	security_ops->sb_free_security (sb);
+	COND_SECURITY(sb_free_security (sb),=20
+		  SE_NOP);
 }
=20
 static inline int security_sb_copy_data (struct file_system_type *type,
 					 void *orig, void *copy)
 {
-	return security_ops->sb_copy_data (type, orig, copy);
+	return COND_SECURITY(sb_copy_data (type, orig, copy),=20
+			 0);
 }
=20
 static inline int security_sb_kern_mount (struct super_block *sb, void *da=
ta)
 {
-	return security_ops->sb_kern_mount (sb, data);
+	return COND_SECURITY(sb_kern_mount (sb, data),=20
+			 0);
 }
=20
 static inline int security_sb_statfs (struct super_block *sb)
 {
-	return security_ops->sb_statfs (sb);
+	return COND_SECURITY(sb_statfs (sb),=20
+			 0);
 }
=20
 static inline int security_sb_mount (char *dev_name, struct nameidata *nd,
 				    char *type, unsigned long flags,
 				    void *data)
 {
-	return security_ops->sb_mount (dev_name, nd, type, flags, data);
+	return COND_SECURITY(sb_mount (dev_name, nd, type, flags, data),=20
+			 0);
 }
=20
 static inline int security_sb_check_sb (struct vfsmount *mnt,
 					struct nameidata *nd)
 {
-	return security_ops->sb_check_sb (mnt, nd);
+	return COND_SECURITY(sb_check_sb (mnt, nd),=20
+			 0);
 }
=20
 static inline int security_sb_umount (struct vfsmount *mnt, int flags)
 {
-	return security_ops->sb_umount (mnt, flags);
+	return COND_SECURITY(sb_umount (mnt, flags),=20
+			 0);
 }
=20
 static inline void security_sb_umount_close (struct vfsmount *mnt)
 {
-	security_ops->sb_umount_close (mnt);
+	COND_SECURITY(sb_umount_close (mnt),=20
+		  SE_NOP);
 }
=20
 static inline void security_sb_umount_busy (struct vfsmount *mnt)
 {
-	security_ops->sb_umount_busy (mnt);
+	COND_SECURITY(sb_umount_busy (mnt),=20
+		  SE_NOP);
 }
=20
 static inline void security_sb_post_remount (struct vfsmount *mnt,
 					     unsigned long flags, void *data)
 {
-	security_ops->sb_post_remount (mnt, flags, data);
+	COND_SECURITY(sb_post_remount (mnt, flags, data),=20
+		  SE_NOP);
 }
=20
 static inline void security_sb_post_mountroot (void)
 {
-	security_ops->sb_post_mountroot ();
+	COND_SECURITY(sb_post_mountroot (),=20
+		  SE_NOP);
 }
=20
 static inline void security_sb_post_addmount (struct vfsmount *mnt,
 					      struct nameidata *mountpoint_nd)
 {
-	security_ops->sb_post_addmount (mnt, mountpoint_nd);
+	COND_SECURITY(sb_post_addmount (mnt, mountpoint_nd),=20
+		  SE_NOP);
 }
=20
 static inline int security_sb_pivotroot (struct nameidata *old_nd,
 					 struct nameidata *new_nd)
 {
-	return security_ops->sb_pivotroot (old_nd, new_nd);
+	return COND_SECURITY(sb_pivotroot (old_nd, new_nd),=20
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
+	return COND_SECURITY(inode_alloc_security (inode),=20
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
+	return COND_SECURITY(inode_create (dir, dentry, mode),=20
+ 			 0);
 }
=20
 static inline void security_inode_post_create (struct inode *dir,
 					       struct dentry *dentry,
 					       int mode)
 {
-	security_ops->inode_post_create (dir, dentry, mode);
+	COND_SECURITY(inode_post_create (dir, dentry, mode),
+ 		  SE_NOP);
 }
=20
 static inline int security_inode_link (struct dentry *old_dentry,
 				       struct inode *dir,
 				       struct dentry *new_dentry)
 {
-	return security_ops->inode_link (old_dentry, dir, new_dentry);
+	return COND_SECURITY(inode_link (old_dentry, dir, new_dentry),=20
+ 			 0);
 }
=20
 static inline void security_inode_post_link (struct dentry *old_dentry,
 					     struct inode *dir,
 					     struct dentry *new_dentry)
 {
-	security_ops->inode_post_link (old_dentry, dir, new_dentry);
+	COND_SECURITY(inode_post_link (old_dentry, dir, new_dentry),
+ 		  SE_NOP);
 }
=20
 static inline int security_inode_unlink (struct inode *dir,
 					 struct dentry *dentry)
 {
-	return security_ops->inode_unlink (dir, dentry);
+	return COND_SECURITY(inode_unlink (dir, dentry),=20
+ 			 0);
 }
=20
 static inline int security_inode_symlink (struct inode *dir,
 					  struct dentry *dentry,
 					  const char *old_name)
 {
-	return security_ops->inode_symlink (dir, dentry, old_name);
+	return COND_SECURITY(inode_symlink (dir, dentry, old_name),=20
+ 			 0);
 }
=20
 static inline void security_inode_post_symlink (struct inode *dir,
 						struct dentry *dentry,
 						const char *old_name)
 {
-	security_ops->inode_post_symlink (dir, dentry, old_name);
+	COND_SECURITY(inode_post_symlink (dir, dentry, old_name),
+ 		  SE_NOP);
 }
=20
 static inline int security_inode_mkdir (struct inode *dir,
 					struct dentry *dentry,
 					int mode)
 {
-	return security_ops->inode_mkdir (dir, dentry, mode);
+	return COND_SECURITY(inode_mkdir (dir, dentry, mode),=20
+ 			 0);
 }
=20
 static inline void security_inode_post_mkdir (struct inode *dir,
 					      struct dentry *dentry,
 					      int mode)
 {
-	security_ops->inode_post_mkdir (dir, dentry, mode);
+	COND_SECURITY(inode_post_mkdir (dir, dentry, mode),
+ 		  SE_NOP);
 }
=20
 static inline int security_inode_rmdir (struct inode *dir,
 					struct dentry *dentry)
 {
-	return security_ops->inode_rmdir (dir, dentry);
+	return COND_SECURITY(inode_rmdir (dir, dentry),=20
+ 			 0);
 }
=20
 static inline int security_inode_mknod (struct inode *dir,
 					struct dentry *dentry,
 					int mode, dev_t dev)
 {
-	return security_ops->inode_mknod (dir, dentry, mode, dev);
+	return COND_SECURITY(inode_mknod (dir, dentry, mode, dev),=20
+ 			 0);
 }
=20
 static inline void security_inode_post_mknod (struct inode *dir,
 					      struct dentry *dentry,
 					      int mode, dev_t dev)
 {
-	security_ops->inode_post_mknod (dir, dentry, mode, dev);
+	COND_SECURITY(inode_post_mknod (dir, dentry, mode, dev),
+ 		  SE_NOP);
 }
=20
 static inline int security_inode_rename (struct inode *old_dir,
@@ -1501,8 +1564,9 @@
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
@@ -1510,232 +1574,274 @@
 					       struct inode *new_dir,
 					       struct dentry *new_dentry)
 {
-	security_ops->inode_post_rename (old_dir, old_dentry,
-						new_dir, new_dentry);
+	COND_SECURITY(inode_post_rename (old_dir, old_dentry,
+						new_dir, new_dentry),
+		  SE_NOP);
 }
=20
 static inline int security_inode_readlink (struct dentry *dentry)
 {
-	return security_ops->inode_readlink (dentry);
+	return COND_SECURITY(inode_readlink (dentry),=20
+			 0);
 }
=20
 static inline int security_inode_follow_link (struct dentry *dentry,
 					      struct nameidata *nd)
 {
-	return security_ops->inode_follow_link (dentry, nd);
+	return COND_SECURITY(inode_follow_link (dentry, nd),=20
+			 0);
 }
=20
 static inline int security_inode_permission (struct inode *inode, int mask,
 					     struct nameidata *nd)
 {
-	return security_ops->inode_permission (inode, mask, nd);
+	return COND_SECURITY(inode_permission (inode, mask, nd),=20
+			 0);
 }
=20
 static inline int security_inode_setattr (struct dentry *dentry,
 					  struct iattr *attr)
 {
-	return security_ops->inode_setattr (dentry, attr);
+	return COND_SECURITY(inode_setattr (dentry, attr),=20
+			 0);
 }
=20
 static inline int security_inode_getattr (struct vfsmount *mnt,
 					  struct dentry *dentry)
 {
-	return security_ops->inode_getattr (mnt, dentry);
+	return COND_SECURITY(inode_getattr (mnt, dentry),=20
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
+	return COND_SECURITY(inode_getxattr (dentry, name),=20
+			 0);
 }
=20
 static inline int security_inode_listxattr (struct dentry *dentry)
 {
-	return security_ops->inode_listxattr (dentry);
+	return COND_SECURITY(inode_listxattr (dentry),=20
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
 static inline int security_inode_getsecurity(struct dentry *dentry, const =
char *name, void *buffer, size_t size)
 {
-	return security_ops->inode_getsecurity(dentry, name, buffer, size);
+	return COND_SECURITY(inode_getsecurity(dentry, name, buffer, size),=20
+			 -EOPNOTSUPP);
 }
=20
 static inline int security_inode_setsecurity(struct dentry *dentry, const =
char *name, const void *value, size_t size, int flags)=20
 {
-	return security_ops->inode_setsecurity(dentry, name, value, size, flags);
+	return COND_SECURITY(inode_setsecurity(dentry, name, value, size, flags),=
=20
+			 -EOPNOTSUPP);
 }
=20
 static inline int security_inode_listsecurity(struct dentry *dentry, char =
*buffer)
 {
-	return security_ops->inode_listsecurity(dentry, buffer);
+	return COND_SECURITY(inode_listsecurity(dentry, buffer),=20
+			 0);
 }
=20
 static inline int security_file_permission (struct file *file, int mask)
 {
-	return security_ops->file_permission (file, mask);
+	return COND_SECURITY(file_permission (file, mask),=20
+			 0);
 }
=20
 static inline int security_file_alloc (struct file *file)
 {
-	return security_ops->file_alloc_security (file);
+	return COND_SECURITY(file_alloc_security (file),=20
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
+	return COND_SECURITY(file_ioctl (file, cmd, arg),=20
+			 0);
 }
=20
 static inline int security_file_mmap (struct file *file, unsigned long pro=
t,
 				      unsigned long flags)
 {
-	return security_ops->file_mmap (file, prot, flags);
+	return COND_SECURITY(file_mmap (file, prot, flags),=20
+			 0);
 }
=20
 static inline int security_file_mprotect (struct vm_area_struct *vma,
 					  unsigned long prot)
 {
-	return security_ops->file_mprotect (vma, prot);
+	return COND_SECURITY(file_mprotect (vma, prot),=20
+			 0);
 }
=20
 static inline int security_file_lock (struct file *file, unsigned int cmd)
 {
-	return security_ops->file_lock (file, cmd);
+	return COND_SECURITY(file_lock (file, cmd),=20
+			 0);
 }
=20
 static inline int security_file_fcntl (struct file *file, unsigned int cmd,
 				       unsigned long arg)
 {
-	return security_ops->file_fcntl (file, cmd, arg);
+	return COND_SECURITY(file_fcntl (file, cmd, arg),=20
+			 0);
 }
=20
 static inline int security_file_set_fowner (struct file *file)
 {
-	return security_ops->file_set_fowner (file);
+	return COND_SECURITY(file_set_fowner (file),=20
+			 0);
 }
=20
 static inline int security_file_send_sigiotask (struct task_struct *tsk,
 						struct fown_struct *fown,
 						int fd, int reason)
 {
-	return security_ops->file_send_sigiotask (tsk, fown, fd, reason);
+	return COND_SECURITY(file_send_sigiotask (tsk, fown, fd, reason),=20
+			 0);
 }
=20
 static inline int security_file_receive (struct file *file)
 {
-	return security_ops->file_receive (file);
+	return COND_SECURITY(file_receive (file),=20
+			 0);
 }
=20
 static inline int security_task_create (unsigned long clone_flags)
 {
-	return security_ops->task_create (clone_flags);
+	return COND_SECURITY(task_create (clone_flags),=20
+			 0);
 }
=20
 static inline int security_task_alloc (struct task_struct *p)
 {
-	return security_ops->task_alloc_security (p);
+	return COND_SECURITY(task_alloc_security (p),=20
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
+	return COND_SECURITY(task_setuid (id0, id1, id2, flags),=20
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
+	return COND_SECURITY(task_setgid (id0, id1, id2, flags),=20
+			 0);
 }
=20
 static inline int security_task_setpgid (struct task_struct *p, pid_t pgid)
 {
-	return security_ops->task_setpgid (p, pgid);
+	return COND_SECURITY(task_setpgid (p, pgid),=20
+			 0);
 }
=20
 static inline int security_task_getpgid (struct task_struct *p)
 {
-	return security_ops->task_getpgid (p);
+	return COND_SECURITY(task_getpgid (p),=20
+			 0);
 }
=20
 static inline int security_task_getsid (struct task_struct *p)
 {
-	return security_ops->task_getsid (p);
+	return COND_SECURITY(task_getsid (p),=20
+			 0);
 }
=20
 static inline int security_task_setgroups (struct group_info *group_info)
 {
-	return security_ops->task_setgroups (group_info);
+	return COND_SECURITY(task_setgroups (group_info),=20
+			 0);
 }
=20
 static inline int security_task_setnice (struct task_struct *p, int nice)
 {
-	return security_ops->task_setnice (p, nice);
+	return COND_SECURITY(task_setnice (p, nice),=20
+			 0);
 }
=20
 static inline int security_task_setrlimit (unsigned int resource,
 					   struct rlimit *new_rlim)
 {
-	return security_ops->task_setrlimit (resource, new_rlim);
+	return COND_SECURITY(task_setrlimit (resource, new_rlim),=20
+			 0);
 }
=20
 static inline int security_task_setscheduler (struct task_struct *p,
 					      int policy,
 					      struct sched_param *lp)
 {
-	return security_ops->task_setscheduler (p, policy, lp);
+	return COND_SECURITY(task_setscheduler (p, policy, lp),=20
+			 0);
 }
=20
 static inline int security_task_getscheduler (struct task_struct *p)
 {
-	return security_ops->task_getscheduler (p);
+	return COND_SECURITY(task_getscheduler (p),=20
+			 0);
 }
=20
 static inline int security_task_kill (struct task_struct *p,
 				      struct siginfo *info, int sig)
 {
-	return security_ops->task_kill (p, info, sig);
+	return COND_SECURITY(task_kill (p, info, sig),=20
+			 0);
 }
=20
 static inline int security_task_wait (struct task_struct *p)
 {
-	return security_ops->task_wait (p);
+	return COND_SECURITY(task_wait (p),=20
+			 0);
 }
=20
 static inline int security_task_prctl (int option, unsigned long arg2,
@@ -1743,60 +1849,71 @@
 				       unsigned long arg4,
 				       unsigned long arg5)
 {
-	return security_ops->task_prctl (option, arg2, arg3, arg4, arg5);
+	return COND_SECURITY(task_prctl (option, arg2, arg3, arg4, arg5),=20
+			 0);
 }
=20
 static inline void security_task_reparent_to_init (struct task_struct *p)
 {
-	security_ops->task_reparent_to_init (p);
+	COND_SECURITY(task_reparent_to_init (p),=20
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
+	return COND_SECURITY(ipc_permission (ipcp, flag),=20
+			 0);
 }
=20
 static inline int security_msg_msg_alloc (struct msg_msg * msg)
 {
-	return security_ops->msg_msg_alloc_security (msg);
+	return COND_SECURITY(msg_msg_alloc_security (msg),=20
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
+	return COND_SECURITY(msg_queue_alloc_security (msq),=20
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
+	return COND_SECURITY(msg_queue_associate (msq, msqflg),=20
+			 0);
 }
=20
 static inline int security_msg_queue_msgctl (struct msg_queue * msq, int c=
md)
 {
-	return security_ops->msg_queue_msgctl (msq, cmd);
+	return COND_SECURITY(msg_queue_msgctl (msq, cmd),=20
+			 0);
 }
=20
 static inline int security_msg_queue_msgsnd (struct msg_queue * msq,
 					     struct msg_msg * msg, int msqflg)
 {
-	return security_ops->msg_queue_msgsnd (msq, msg, msqflg);
+	return COND_SECURITY(msg_queue_msgsnd (msq, msg, msqflg),=20
+			 0);
 }
=20
 static inline int security_msg_queue_msgrcv (struct msg_queue * msq,
@@ -1804,86 +1921,102 @@
 					     struct task_struct * target,
 					     long type, int mode)
 {
-	return security_ops->msg_queue_msgrcv (msq, msg, target, type, mode);
+	return COND_SECURITY(msg_queue_msgrcv (msq, msg, target, type, mode),=20
+ 			 0);
 }
=20
 static inline int security_shm_alloc (struct shmid_kernel *shp)
 {
-	return security_ops->shm_alloc_security (shp);
+	return COND_SECURITY(shm_alloc_security (shp),=20
+ 			 0);
 }
=20
 static inline void security_shm_free (struct shmid_kernel *shp)
 {
-	security_ops->shm_free_security (shp);
+	COND_SECURITY(shm_free_security (shp),
+ 		  SE_NOP);
 }
=20
 static inline int security_shm_associate (struct shmid_kernel * shp,=20
 					  int shmflg)
 {
-	return security_ops->shm_associate(shp, shmflg);
+	return COND_SECURITY(shm_associate(shp, shmflg),=20
+ 			 0);
 }
=20
 static inline int security_shm_shmctl (struct shmid_kernel * shp, int cmd)
 {
-	return security_ops->shm_shmctl (shp, cmd);
+	return COND_SECURITY(shm_shmctl (shp, cmd),=20
+ 			 0);
 }
=20
 static inline int security_shm_shmat (struct shmid_kernel * shp,=20
 				      char __user *shmaddr, int shmflg)
 {
-	return security_ops->shm_shmat(shp, shmaddr, shmflg);
+	return COND_SECURITY(shm_shmat(shp, shmaddr, shmflg),=20
+ 			 0);
 }
=20
 static inline int security_sem_alloc (struct sem_array *sma)
 {
-	return security_ops->sem_alloc_security (sma);
+	return COND_SECURITY(sem_alloc_security (sma),=20
+ 			 0);
 }
=20
 static inline void security_sem_free (struct sem_array *sma)
 {
-	security_ops->sem_free_security (sma);
+	COND_SECURITY(sem_free_security (sma),
+ 		  SE_NOP);
 }
=20
 static inline int security_sem_associate (struct sem_array * sma, int semf=
lg)
 {
-	return security_ops->sem_associate (sma, semflg);
+	return COND_SECURITY(sem_associate (sma, semflg),=20
+ 			 0);
 }
=20
 static inline int security_sem_semctl (struct sem_array * sma, int cmd)
 {
-	return security_ops->sem_semctl(sma, cmd);
+	return COND_SECURITY(sem_semctl(sma, cmd),=20
+ 			 0);
 }
=20
 static inline int security_sem_semop (struct sem_array * sma,=20
 				      struct sembuf * sops, unsigned nsops,=20
 				      int alter)
 {
-	return security_ops->sem_semop(sma, sops, nsops, alter);
+	return COND_SECURITY(sem_semop(sma, sops, nsops, alter),=20
+ 			 0);
 }
=20
 static inline void security_d_instantiate (struct dentry *dentry, struct i=
node *inode)
 {
-	security_ops->d_instantiate (dentry, inode);
+	COND_SECURITY(d_instantiate (dentry, inode),
+ 		  SE_NOP);
 }
=20
 static inline int security_getprocattr(struct task_struct *p, char *name, =
void *value, size_t size)
 {
-	return security_ops->getprocattr(p, name, value, size);
+	return COND_SECURITY(getprocattr(p, name, value, size),=20
+ 			 -EINVAL);
 }
=20
 static inline int security_setprocattr(struct task_struct *p, char *name, =
void *value, size_t size)
 {
-	return security_ops->setprocattr(p, name, value, size);
+	return COND_SECURITY(setprocattr(p, name, value, size),=20
+ 			 -EINVAL);
 }
=20
 static inline int security_netlink_send(struct sock *sk, struct sk_buff * =
skb)
 {
-	return security_ops->netlink_send(sk, skb);
+	return COND_SECURITY(netlink_send(sk, skb),
+ 			 cap_netlink_send (sk, skb));
 }
=20
 static inline int security_netlink_recv(struct sk_buff * skb)
 {
-	return security_ops->netlink_recv(skb);
+	return COND_SECURITY(netlink_recv(skb),
+ 			 cap_netlink_recv (skb));
 }
=20
 /* prototypes */
@@ -2521,20 +2654,23 @@
 					       struct socket * other,=20
 					       struct sock * newsk)
 {
-	return security_ops->unix_stream_connect(sock, other, newsk);
+	return COND_SECURITY(unix_stream_connect(sock, other, newsk),=20
+ 			 0);
 }
=20
=20
 static inline int security_unix_may_send(struct socket * sock,=20
 					 struct socket * other)
 {
-	return security_ops->unix_may_send(sock, other);
+	return COND_SECURITY(unix_may_send(sock, other),=20
+ 			 0);
 }
=20
 static inline int security_socket_create (int family, int type,
 					  int protocol, int kern)
 {
-	return security_ops->socket_create(family, type, protocol, kern);
+	return COND_SECURITY(socket_create(family, type, protocol, kern),=20
+ 			 0);
 }
=20
 static inline void security_socket_post_create(struct socket * sock,=20
@@ -2542,101 +2678,117 @@
 					       int type,=20
 					       int protocol, int kern)
 {
-	security_ops->socket_post_create(sock, family, type,
-					 protocol, kern);
+	COND_SECURITY(socket_post_create(sock, family, type, protocol, kern),=20
+ 		  SE_NOP);
 }
=20
 static inline int security_socket_bind(struct socket * sock,=20
 				       struct sockaddr * address,=20
 				       int addrlen)
 {
-	return security_ops->socket_bind(sock, address, addrlen);
+	return COND_SECURITY(socket_bind(sock, address, addrlen),=20
+ 			 0);
 }
=20
 static inline int security_socket_connect(struct socket * sock,=20
 					  struct sockaddr * address,=20
 					  int addrlen)
 {
-	return security_ops->socket_connect(sock, address, addrlen);
+	return COND_SECURITY(socket_connect(sock, address, addrlen),=20
+ 			 0);
 }
=20
 static inline int security_socket_listen(struct socket * sock, int backlog)
 {
-	return security_ops->socket_listen(sock, backlog);
+	return COND_SECURITY(socket_listen(sock, backlog),=20
+ 			 0);
 }
=20
 static inline int security_socket_accept(struct socket * sock,=20
 					 struct socket * newsock)
 {
-	return security_ops->socket_accept(sock, newsock);
+	return COND_SECURITY(socket_accept(sock, newsock),=20
+ 			 0);
 }
=20
 static inline void security_socket_post_accept(struct socket * sock,=20
 					       struct socket * newsock)
 {
-	security_ops->socket_post_accept(sock, newsock);
+	COND_SECURITY(socket_post_accept(sock, newsock),=20
+ 		  SE_NOP);
 }
=20
 static inline int security_socket_sendmsg(struct socket * sock,=20
 					  struct msghdr * msg, int size)
 {
-	return security_ops->socket_sendmsg(sock, msg, size);
+	return COND_SECURITY(socket_sendmsg(sock, msg, size),=20
+ 			 0);
 }
=20
 static inline int security_socket_recvmsg(struct socket * sock,=20
 					  struct msghdr * msg, int size,=20
 					  int flags)
 {
-	return security_ops->socket_recvmsg(sock, msg, size, flags);
+	return COND_SECURITY(socket_recvmsg(sock, msg, size, flags),=20
+ 			 0);
 }
=20
 static inline int security_socket_getsockname(struct socket * sock)
 {
-	return security_ops->socket_getsockname(sock);
+	return COND_SECURITY(socket_getsockname(sock),=20
+ 			 0);
 }
=20
 static inline int security_socket_getpeername(struct socket * sock)
 {
-	return security_ops->socket_getpeername(sock);
+	return COND_SECURITY(socket_getpeername(sock),=20
+ 			 0);
 }
=20
 static inline int security_socket_getsockopt(struct socket * sock,=20
 					     int level, int optname)
 {
-	return security_ops->socket_getsockopt(sock, level, optname);
+	return COND_SECURITY(socket_getsockopt(sock, level, optname),=20
+ 			 0);
 }
=20
 static inline int security_socket_setsockopt(struct socket * sock,=20
 					     int level, int optname)
 {
-	return security_ops->socket_setsockopt(sock, level, optname);
+	return COND_SECURITY(socket_setsockopt(sock, level, optname),=20
+ 			 0);
 }
=20
 static inline int security_socket_shutdown(struct socket * sock, int how)
 {
-	return security_ops->socket_shutdown(sock, how);
+	return COND_SECURITY(socket_shutdown(sock, how),=20
+ 			 0);
 }
=20
 static inline int security_sock_rcv_skb (struct sock * sk,=20
 					 struct sk_buff * skb)
 {
-	return security_ops->socket_sock_rcv_skb (sk, skb);
+	return COND_SECURITY(socket_sock_rcv_skb (sk, skb),=20
+ 			 0);
 }
=20
 static inline int security_socket_getpeersec(struct socket *sock, char __u=
ser *optval,
 					     int __user *optlen, unsigned len)
 {
-	return security_ops->socket_getpeersec(sock, optval, optlen, len);
+	return COND_SECURITY(socket_getpeersec(sock, optval, optlen, len),=20
+ 			 -ENOPROTOOPT);
 }
=20
 static inline int security_sk_alloc(struct sock *sk, int family, int prior=
ity)
 {
-	return security_ops->sk_alloc_security(sk, family, priority);
+	return COND_SECURITY(sk_alloc_security(sk, family, priority),=20
+ 			 0);
 }
=20
 static inline void security_sk_free(struct sock *sk)
 {
-	return security_ops->sk_free_security(sk);
+	return COND_SECURITY(sk_free_security(sk),=20
+ 		  	0);
 }
 #else	/* CONFIG_SECURITY_NETWORK */
 static inline int security_unix_stream_connect(struct socket * sock,
Index: linux-2.6.7/security/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.7.orig/security/Makefile	2004-08-05 14:58:22.439493894 +0200
+++ linux-2.6.7/security/Makefile	2004-08-05 15:00:29.598162747 +0200
@@ -4,14 +4,12 @@
=20
 subdir-$(CONFIG_SECURITY_SELINUX)	+=3D selinux
=20
-# if we don't select a security model, use the default capabilities
-ifneq ($(CONFIG_SECURITY),y)
+# We always need commoncap as it's default
 obj-y		+=3D commoncap.o
-endif
=20
 # Object file lists
 obj-$(CONFIG_SECURITY)			+=3D security.o dummy.o
 # Must precede capability.o in order to stack properly.
 obj-$(CONFIG_SECURITY_SELINUX)		+=3D selinux/built-in.o
-obj-$(CONFIG_SECURITY_CAPABILITIES)	+=3D commoncap.o capability.o
-obj-$(CONFIG_SECURITY_ROOTPLUG)		+=3D commoncap.o root_plug.o
+obj-$(CONFIG_SECURITY_ROOTPLUG)		+=3D root_plug.o
+obj-$(CONFIG_SECURITY_CAPABILITIES)	+=3D capability.o
Index: linux-2.6.7/security/capability.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.7.orig/security/capability.c	2004-08-05 14:58:22.440493797 +0=
200
+++ linux-2.6.7/security/capability.c	2004-08-05 15:26:01.959562780 +0200
@@ -24,29 +24,19 @@
 #include <linux/ptrace.h>
 #include <linux/moduleparam.h>
=20
-static struct security_operations capability_ops =3D {
-	.ptrace =3D			cap_ptrace,
-	.capget =3D			cap_capget,
-	.capset_check =3D			cap_capset_check,
-	.capset_set =3D			cap_capset_set,
-	.capable =3D			cap_capable,
-	.netlink_send =3D			cap_netlink_send,
-	.netlink_recv =3D			cap_netlink_recv,
-
-	.bprm_apply_creds =3D		cap_bprm_apply_creds,
-	.bprm_set_security =3D		cap_bprm_set_security,
-	.bprm_secureexec =3D		cap_bprm_secureexec,
-
-	.inode_setxattr =3D		cap_inode_setxattr,
-	.inode_removexattr =3D		cap_inode_removexattr,
-
-	.task_post_setuid =3D		cap_task_post_setuid,
-	.task_reparent_to_init =3D	cap_task_reparent_to_init,
-
-	.syslog =3D                       cap_syslog,
-
-	.vm_enough_memory =3D             cap_vm_enough_memory,
-};
+/* Note: If the capability security module is loaded, we do NOT register
+ * the capability_security_ops but a second structure capability_ops
+ * that has the identical entries. The reasons:
+ * - we could stack on top of capability if it was stackable
+ * - a loaded capability module will prevent others to register, which
+ *   is the previous behaviour; if capabilities are used as default (not
+ *   because the module has been loaded), we allow the replacement.
+ */
+
+/* Struct from commoncaps */
+extern struct security_operations capability_security_ops;
+/* Struct to hold the copy */
+static struct security_operations capability_ops;
=20
 #define MY_NAME __stringify(KBUILD_MODNAME)
=20
@@ -59,6 +49,7 @@
=20
 static int __init capability_init (void)
 {
+	memcpy(&capability_ops, &capability_security_ops, sizeof(capability_ops));
 	if (capability_disable) {
 		printk(KERN_INFO "Capabilities disabled at initialization\n");
 		return 0;
Index: linux-2.6.7/security/commoncap.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.7.orig/security/commoncap.c	2004-08-05 14:58:22.440493797 +02=
00
+++ linux-2.6.7/security/commoncap.c	2004-08-05 14:58:54.161417677 +0200
@@ -367,6 +367,42 @@
 	return -ENOMEM;
 }
=20
+#ifdef CONFIG_SECURITY
+struct security_operations capability_security_ops =3D {
+	.ptrace =3D			cap_ptrace,
+	.capget =3D			cap_capget,
+	.capset_check =3D			cap_capset_check,
+	.capset_set =3D			cap_capset_set,
+	.capable =3D			cap_capable,
+	.netlink_send =3D			cap_netlink_send,
+	.netlink_recv =3D			cap_netlink_recv,
+
+	.bprm_apply_creds =3D		cap_bprm_apply_creds,
+	.bprm_set_security =3D		cap_bprm_set_security,
+	.bprm_secureexec =3D		cap_bprm_secureexec,
+
+	.inode_setxattr =3D		cap_inode_setxattr,
+	.inode_removexattr =3D		cap_inode_removexattr,
+
+	.task_post_setuid =3D		cap_task_post_setuid,
+	.task_reparent_to_init =3D	cap_task_reparent_to_init,
+
+	.syslog =3D                       cap_syslog,
+
+	.vm_enough_memory =3D             cap_vm_enough_memory,
+};
+
+EXPORT_SYMBOL(capability_security_ops);
+/* Note: If the capability security module is loaded, we do NOT register
+ * the capability_security_ops but a second structure that has the
+ * identical entries. The reason is that this way,
+ * - we could stack on top of capability if it was stackable
+ * - a loaded capability module will prevent others to register, which
+ *   is the previous behaviour; if capabilities are used as default (not
+ *   because the module has been loaded), we allow the replacement.
+ */
+#endif
+
 EXPORT_SYMBOL(cap_capable);
 EXPORT_SYMBOL(cap_ptrace);
 EXPORT_SYMBOL(cap_capget);
Index: linux-2.6.7/security/dummy.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.7.orig/security/dummy.c	2004-08-05 14:58:22.440493797 +0200
+++ linux-2.6.7/security/dummy.c	2004-08-05 14:58:54.162417580 +0200
@@ -873,9 +873,6 @@
 	return -EINVAL;
 }
=20
-
-struct security_operations dummy_security_ops;
-
 #define set_to_dummy_if_null(ops, function)				\
 	do {								\
 		if (!ops->function) {					\
Index: linux-2.6.7/security/security.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.7.orig/security/security.c	2004-08-05 14:58:22.440493797 +0200
+++ linux-2.6.7/security/security.c	2004-08-05 14:58:54.163417483 +0200
@@ -20,11 +20,42 @@
=20
 #define SECURITY_SCAFFOLD_VERSION	"1.0.0"
=20
+/* garloff@suse.de, 2004-05-21:
+ * lsm causes a performance problem, if compiled in, due to various
+ * non-inlined indirect function calls.
+ * This can be avoided by putting a branch in the inlined security
+ * stubs in include/linux/security.h, calling directly into the cap_
+ * functions from commoncap.
+ * This has some consequences:
+ * - If no security module is loaded, default will be the capability
+ *   security fns, not the dummy ones.
+ * - If a security module is loaded, it will override the defaults;
+ *   this module might be capability itself, overriding itself,=20
+ *   only causing a slowdown. This means that capability should NOT=20
+ *   be compiled into the kernel.
+ * - Another module can be loaded, and capability, being a module again,
+ *   might be stacked as secondary module.
+ * - Unfortunately, we can't get rid of dummy, as we don't want to
+ *   change the default behaviour if a security module is loaded and
+ *   some stubs are not implemented in which case these default to
+ *   dummy (which behaves differently to capability for some stubs).=20
+ * - If no security module is loaded, we set security_ops to point
+ *   to capability_security_ops; it will not normally be used except for=
=20
+ *   one situation: When a security module is unloaded; the value of=20
+ *   security_enabled may still be evaluated to 1 when the security_ops=20
+ *   is already changed. The behaviour is consistent here, as we do
+ *   change security_ops back to point to capability_security_ops.
+ * - commoncaps needs to be compiled in unconditionally.
+ */=20
+
 /* things that live in dummy.c */
-extern struct security_operations dummy_security_ops;
 extern void security_fixup_ops (struct security_operations *ops);
+/* default security ops */
+extern struct security_operations capability_security_ops;
=20
 struct security_operations *security_ops;	/* Initialized to NULL */
+int security_enabled;				/* ditto */
+EXPORT_SYMBOL(security_enabled);
=20
 static inline int verify (struct security_operations *ops)
 {
@@ -57,14 +88,16 @@
 {
 	printk (KERN_INFO "Security Scaffold v" SECURITY_SCAFFOLD_VERSION
 		" initialized\n");
-
-	if (verify (&dummy_security_ops)) {
+=09
+	if (verify (&capability_security_ops)) {
 		printk (KERN_ERR "%s could not verify "
 			"dummy_security_ops structure.\n", __FUNCTION__);
 		return -EIO;
 	}
-
-	security_ops =3D &dummy_security_ops;
+	security_enabled =3D 0;
+	security_ops =3D &capability_security_ops;
+=09
+	/* Init compiled-in security modules */
 	do_security_initcalls();
=20
 	return 0;
@@ -90,13 +123,14 @@
 		return -EINVAL;
 	}
=20
-	if (security_ops !=3D &dummy_security_ops) {
+	if (security_ops !=3D &capability_security_ops) {
 		printk (KERN_INFO "There is already a security "
 			"framework initialized, %s failed.\n", __FUNCTION__);
 		return -EINVAL;
 	}
=20
 	security_ops =3D ops;
+	security_enabled =3D 1;
=20
 	return 0;
 }
@@ -116,13 +150,14 @@
 {
 	if (ops !=3D security_ops) {
 		printk (KERN_INFO "%s: trying to unregister "
-			"a security_opts structure that is not "
+			"a security_ops structure that is not "
 			"registered, failing.\n", __FUNCTION__);
 		return -EINVAL;
 	}
=20
-	security_ops =3D &dummy_security_ops;
-
+	security_enabled =3D 0;
+	security_ops =3D &capability_security_ops;
+=09
 	return 0;
 }
=20

--Lb0e7rgc7IsuDeGj--

--OzxllxdKGCiKxUZM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBGI4KxmLh6hyYd04RAo9dAJ9rBauPIJCSx+SOdH/CbXsVeWk4/QCgm+Z2
ALZfStbESbAcTv3EngdcTI4=
=wVxU
-----END PGP SIGNATURE-----

--OzxllxdKGCiKxUZM--
