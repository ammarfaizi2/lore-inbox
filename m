Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264218AbUFVPHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbUFVPHb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 11:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUFVPAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 11:00:18 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:30859 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S264430AbUFVOuS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:50:18 -0400
Subject: [PATCH][SELINUX] Extend and revise calls to secondary module
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
       Joshua Brindle <jbrindle@snu.edu>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1087915785.6237.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 22 Jun 2004 10:49:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the set of calls to the secondary security module
by SELinux as well as revising a few existing calls to support other
security modules and to more cleanly stack with the capability module.
Please apply.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>

 security/selinux/hooks.c |   94 ++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 85 insertions(+), 9 deletions(-)

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.112
diff -u -p -r1.112 hooks.c
--- linux-2.6/security/selinux/hooks.c	16 Jun 2004 14:49:42 -0000	1.112
+++ linux-2.6/security/selinux/hooks.c	22 Jun 2004 14:14:59 -0000
@@ -1389,11 +1389,11 @@ static int selinux_capset_check(struct t
 {
 	int error;
 
-	error = task_has_perm(current, target, PROCESS__SETCAP);
+	error = secondary_ops->capset_check(target, effective, inheritable, permitted);
 	if (error)
 		return error;
 
-	return secondary_ops->capset_check(target, effective, inheritable, permitted);
+	return task_has_perm(current, target, PROCESS__SETCAP);
 }
 
 static void selinux_capset_set(struct task_struct *target, kernel_cap_t *effective,
@@ -1427,6 +1427,10 @@ static int selinux_sysctl(ctl_table *tab
 	u32 tsid;
 	int rc;
 
+	rc = secondary_ops->sysctl(table, op);
+	if (rc)
+		return rc;
+
 	tsec = current->security;
 
 	rc = selinux_proc_get_sid(table->de, (op == 001) ?
@@ -1690,7 +1694,7 @@ static int selinux_bprm_set_security(str
 
 static int selinux_bprm_check_security (struct linux_binprm *bprm)
 {
-	return 0;
+	return secondary_ops->bprm_check_security(bprm);
 }
 
 
@@ -1708,12 +1712,7 @@ static int selinux_bprm_secureexec (stru
 					 PROCESS__NOATSECURE, NULL, NULL);
 	}
 
-	/* Note that we must include the legacy uid/gid test below
-	   to retain it, as the new userland will simply use the
-	   value passed by AT_SECURE to decide whether to enable
-	   secure mode. */
-	return ( atsecure || current->euid != current->uid ||
-		current->egid != current->gid);
+	return (atsecure || secondary_ops->bprm_secureexec(bprm));
 }
 
 static void selinux_bprm_free_security(struct linux_binprm *bprm)
@@ -2058,6 +2057,12 @@ static int selinux_mount(char * dev_name
                          unsigned long flags,
                          void * data)
 {
+	int rc;
+
+	rc = secondary_ops->sb_mount(dev_name, nd, type, flags, data);
+	if (rc)
+		return rc;
+
 	if (flags & MS_REMOUNT)
 		return superblock_has_perm(current, nd->mnt->mnt_sb,
 		                           FILESYSTEM__REMOUNT, NULL);
@@ -2068,6 +2073,12 @@ static int selinux_mount(char * dev_name
 
 static int selinux_umount(struct vfsmount *mnt, int flags)
 {
+	int rc;
+
+	rc = secondary_ops->sb_umount(mnt, flags);
+	if (rc)
+		return rc;
+
 	return superblock_has_perm(current,mnt->mnt_sb,
 	                           FILESYSTEM__UNMOUNT,NULL);
 }
@@ -2111,6 +2122,11 @@ static void selinux_inode_post_link(stru
 
 static int selinux_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
+	int rc;
+	
+	rc = secondary_ops->inode_unlink(dir, dentry);
+	if (rc)
+		return rc;
 	return may_link(dir, dentry, MAY_UNLINK);
 }
 
@@ -2141,6 +2157,12 @@ static int selinux_inode_rmdir(struct in
 
 static int selinux_inode_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
 {
+	int rc;
+
+	rc = secondary_ops->inode_mknod(dir, dentry, mode, dev);
+	if (rc)
+		return rc;
+
 	return may_create(dir, dentry, inode_mode_to_security_class(mode));
 }
 
@@ -2179,6 +2201,12 @@ static int selinux_inode_follow_link(str
 static int selinux_inode_permission(struct inode *inode, int mask,
 				    struct nameidata *nd)
 {
+	int rc;
+
+	rc = secondary_ops->inode_permission(inode, mask, nd);
+	if (rc)
+		return rc;
+
 	if (!mask) {
 		/* No permission to check.  Existence test. */
 		return 0;
@@ -2190,6 +2218,12 @@ static int selinux_inode_permission(stru
 
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 {
+	int rc;
+
+	rc = secondary_ops->inode_setattr(dentry, iattr);
+	if (rc)
+		return rc;
+
 	if (iattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID |
 			       ATTR_ATIME_SET | ATTR_MTIME_SET))
 		return dentry_has_perm(current, NULL, dentry, FILE__SETATTR);
@@ -2456,6 +2490,11 @@ static int selinux_file_ioctl(struct fil
 static int selinux_file_mmap(struct file *file, unsigned long prot, unsigned long flags)
 {
 	u32 av;
+	int rc;
+
+	rc = secondary_ops->file_mmap(file, prot, flags);
+	if (rc)
+		return rc;
 
 	if (file) {
 		/* read access is always possible with a mapping */
@@ -2476,6 +2515,12 @@ static int selinux_file_mmap(struct file
 static int selinux_file_mprotect(struct vm_area_struct *vma,
 				 unsigned long prot)
 {
+	int rc;
+
+	rc = secondary_ops->file_mprotect(vma, prot);
+	if (rc)
+		return rc;
+
 	return selinux_file_mmap(vma->vm_file, prot, vma->vm_flags);
 }
 
@@ -2573,6 +2618,12 @@ static int selinux_file_receive(struct f
 
 static int selinux_task_create(unsigned long clone_flags)
 {
+	int rc;
+
+	rc = secondary_ops->task_create(clone_flags);
+	if (rc)
+		return rc;
+
 	return task_has_perm(current, current, PROCESS__FORK);
 }
 
@@ -2648,13 +2699,24 @@ static int selinux_task_setgroups(struct
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
 {
+	int rc;
+
+	rc = secondary_ops->task_setnice(p, nice);
+	if (rc)
+		return rc;
+
 	return task_has_perm(current,p, PROCESS__SETSCHED);
 }
 
 static int selinux_task_setrlimit(unsigned int resource, struct rlimit *new_rlim)
 {
 	struct rlimit *old_rlim = current->rlim + resource;
+	int rc;
 
+	rc = secondary_ops->task_setrlimit(resource, new_rlim);
+	if (rc)
+		return rc;
+	
 	/* Control the ability to change the hard limit (whether
 	   lowering or raising it), so that the hard limit can
 	   later be used as a safe reset point for the soft limit
@@ -2688,6 +2750,11 @@ static int selinux_task_getscheduler(str
 static int selinux_task_kill(struct task_struct *p, struct siginfo *info, int sig)
 {
 	u32 perm;
+	int rc;
+
+	rc = secondary_ops->task_kill(p, info, sig);
+	if (rc)
+		return rc;
 
 	if (info && ((unsigned long)info == 1 ||
 	             (unsigned long)info == 2 || SI_FROMKERNEL(info)))
@@ -3129,6 +3196,10 @@ static int selinux_socket_unix_stream_co
 	struct avc_audit_data ad;
 	int err;
 
+	err = secondary_ops->unix_stream_connect(sock, other, newsk);
+	if (err)
+		return err;
+
 	isec = SOCK_INODE(sock)->i_security;
 	other_isec = SOCK_INODE(other)->i_security;
 
@@ -3847,6 +3918,11 @@ static int selinux_shm_shmat(struct shmi
 			     char __user *shmaddr, int shmflg)
 {
 	u32 perms;
+	int rc;
+
+	rc = secondary_ops->shm_shmat(shp, shmaddr, shmflg);
+	if (rc)
+		return rc;
 
 	if (shmflg & SHM_RDONLY)
 		perms = SHM__READ;


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

