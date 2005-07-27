Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVG0TYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVG0TYn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 15:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262402AbVG0S2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:28:10 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:37346 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262125AbVG0S0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:26:50 -0400
Date: Wed, 27 Jul 2005 13:27:07 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Emily Ratliff <emilyr@us.ibm.com>
Subject: [patch 11/15] lsm stacking v0.3: selinux: remove secondary support
Message-ID: <20050727182707.GL22483@serge.austin.ibm.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <20050727181921.GB22483@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727181921.GB22483@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the SELinux support for secondary modules.  This is no longer necessary
as SELinux can now be simply stacked with the cap-stack module.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
--
 hooks.c |  266 ++++++++--------------------------------------------------------
 1 files changed, 35 insertions(+), 231 deletions(-)

Index: linux-2.6.13-rc3/security/selinux/hooks.c
===================================================================
--- linux-2.6.13-rc3.orig/security/selinux/hooks.c	2005-07-25 14:55:39.000000000 -0500
+++ linux-2.6.13-rc3/security/selinux/hooks.c	2005-07-25 14:55:52.000000000 -0500
@@ -81,6 +81,8 @@
 extern unsigned int policydb_loaded_version;
 extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
 
+static int secondary;  /* how were we registered? */
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 int selinux_enforcing = 0;
 
@@ -103,15 +105,6 @@ static int __init selinux_enabled_setup(
 __setup("selinux=", selinux_enabled_setup);
 #endif
 
-/* Original (dummy) security module. */
-static struct security_operations *original_ops = NULL;
-
-/* Minimal support for a secondary security module,
-   just to allow the use of the dummy or capability modules.
-   The owlsm module can alternatively be used as a secondary
-   module as long as CONFIG_OWLSM_FD is not enabled. */
-static struct security_operations *secondary_ops = NULL;
-
 /* Lists of inode and superblock security structures initialized
    before the policy was loaded. */
 static LIST_HEAD(superblock_security_head);
@@ -1400,9 +1393,6 @@ static int selinux_ptrace(struct task_st
 	struct task_security_struct *csec;
 	int rc;
 
-	rc = secondary_ops->ptrace(parent,child);
-	if (rc)
-		return rc;
 	psec = security_get_value_type(&parent->security, SELINUX_LSM_ID,
 		struct task_security_struct);
 	csec = security_get_value_type(&child->security, SELINUX_LSM_ID,
@@ -1418,41 +1408,17 @@ static int selinux_ptrace(struct task_st
 static int selinux_capget(struct task_struct *target, kernel_cap_t *effective,
                           kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
-	int error;
-
-	error = task_has_perm(current, target, PROCESS__GETCAP);
-	if (error)
-		return error;
-
-	return secondary_ops->capget(target, effective, inheritable, permitted);
+	return task_has_perm(current, target, PROCESS__GETCAP);
 }
 
 static int selinux_capset_check(struct task_struct *target, kernel_cap_t *effective,
                                 kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
-	int error;
-
-	error = secondary_ops->capset_check(target, effective, inheritable, permitted);
-	if (error)
-		return error;
-
 	return task_has_perm(current, target, PROCESS__SETCAP);
 }
 
-static void selinux_capset_set(struct task_struct *target, kernel_cap_t *effective,
-                               kernel_cap_t *inheritable, kernel_cap_t *permitted)
-{
-	secondary_ops->capset_set(target, effective, inheritable, permitted);
-}
-
 static int selinux_capable(struct task_struct *tsk, int cap)
 {
-	int rc;
-
-	rc = secondary_ops->capable(tsk, cap);
-	if (rc)
-		return rc;
-
 	return task_has_capability(tsk,cap);
 }
 
@@ -1464,10 +1430,6 @@ static int selinux_sysctl(ctl_table *tab
 	u32 tsid;
 	int rc;
 
-	rc = secondary_ops->sysctl(table, op);
-	if (rc)
-		return rc;
-
 	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
 		struct task_security_struct);
 
@@ -1535,11 +1497,7 @@ static int selinux_quota_on(struct dentr
 
 static int selinux_syslog(int type)
 {
-	int rc;
-
-	rc = secondary_ops->syslog(type);
-	if (rc)
-		return rc;
+	int rc = 0;
 
 	switch (type) {
 		case 3:         /* Read last kernel messages */
@@ -1563,36 +1521,6 @@ static int selinux_syslog(int type)
 	return rc;
 }
 
-/*
- * Check that a process has enough memory to allocate a new virtual
- * mapping. 0 means there is enough memory for the allocation to
- * succeed and -ENOMEM implies there is not.
- *
- * Note that secondary_ops->capable and task_has_perm_noaudit return 0
- * if the capability is granted, but __vm_enough_memory requires 1 if
- * the capability is granted.
- *
- * Do not audit the selinux permission check, as this is applied to all
- * processes that allocate mappings.
- */
-static int selinux_vm_enough_memory(long pages)
-{
-	int rc, cap_sys_admin = 0;
-	struct task_security_struct *tsec = current->security;
-
-	rc = secondary_ops->capable(current, CAP_SYS_ADMIN);
-	if (rc == 0)
-		rc = avc_has_perm_noaudit(tsec->sid, tsec->sid,
-					SECCLASS_CAPABILITY,
-					CAP_TO_MASK(CAP_SYS_ADMIN),
-					NULL);
-
-	if (rc == 0)
-		cap_sys_admin = 1;
-
-	return __vm_enough_memory(pages, cap_sys_admin);
-}
-
 /* binprm security operations */
 
 static int selinux_bprm_alloc_security(struct linux_binprm *bprm)
@@ -1622,10 +1550,6 @@ static int selinux_bprm_set_security(str
 	struct avc_audit_data ad;
 	int rc;
 
-	rc = secondary_ops->bprm_set_security(bprm);
-	if (rc)
-		return rc;
-
 	bsec = security_get_value_type(&bprm->security, SELINUX_LSM_ID,
 		struct bprm_security_struct);
 
@@ -1690,12 +1614,6 @@ static int selinux_bprm_set_security(str
 	return 0;
 }
 
-static int selinux_bprm_check_security (struct linux_binprm *bprm)
-{
-	return secondary_ops->bprm_check_security(bprm);
-}
-
-
 static int selinux_bprm_secureexec (struct linux_binprm *bprm)
 {
 	struct task_security_struct *tsec;
@@ -1712,7 +1630,7 @@ static int selinux_bprm_secureexec (stru
 					 PROCESS__NOATSECURE, NULL);
 	}
 
-	return (atsecure || secondary_ops->bprm_secureexec(bprm));
+	return atsecure;
 }
 
 static void selinux_bprm_free_security(struct linux_binprm *bprm)
@@ -1816,8 +1734,6 @@ static void selinux_bprm_apply_creds(str
 	u32 sid;
 	int rc;
 
-	secondary_ops->bprm_apply_creds(bprm, unsafe);
-
 	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
 		struct task_security_struct);
 	bsec = security_get_value_type(&bprm->security, SELINUX_LSM_ID,
@@ -2043,12 +1959,6 @@ static int selinux_mount(char * dev_name
                          unsigned long flags,
                          void * data)
 {
-	int rc;
-
-	rc = secondary_ops->sb_mount(dev_name, nd, type, flags, data);
-	if (rc)
-		return rc;
-
 	if (flags & MS_REMOUNT)
 		return superblock_has_perm(current, nd->mnt->mnt_sb,
 		                           FILESYSTEM__REMOUNT, NULL);
@@ -2059,12 +1969,6 @@ static int selinux_mount(char * dev_name
 
 static int selinux_umount(struct vfsmount *mnt, int flags)
 {
-	int rc;
-
-	rc = secondary_ops->sb_umount(mnt, flags);
-	if (rc)
-		return rc;
-
 	return superblock_has_perm(current,mnt->mnt_sb,
 	                           FILESYSTEM__UNMOUNT,NULL);
 }
@@ -2093,11 +1997,6 @@ static void selinux_inode_post_create(st
 
 static int selinux_inode_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_dentry)
 {
-	int rc;
-
-	rc = secondary_ops->inode_link(old_dentry,dir,new_dentry);
-	if (rc)
-		return rc;
 	return may_link(dir, old_dentry, MAY_LINK);
 }
 
@@ -2108,11 +2007,6 @@ static void selinux_inode_post_link(stru
 
 static int selinux_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
-	int rc;
-
-	rc = secondary_ops->inode_unlink(dir, dentry);
-	if (rc)
-		return rc;
 	return may_link(dir, dentry, MAY_UNLINK);
 }
 
@@ -2143,12 +2037,6 @@ static int selinux_inode_rmdir(struct in
 
 static int selinux_inode_mknod(struct inode *dir, struct dentry *dentry, int mode, dev_t dev)
 {
-	int rc;
-
-	rc = secondary_ops->inode_mknod(dir, dentry, mode, dev);
-	if (rc)
-		return rc;
-
 	return may_create(dir, dentry, inode_mode_to_security_class(mode));
 }
 
@@ -2176,23 +2064,12 @@ static int selinux_inode_readlink(struct
 
 static int selinux_inode_follow_link(struct dentry *dentry, struct nameidata *nameidata)
 {
-	int rc;
-
-	rc = secondary_ops->inode_follow_link(dentry,nameidata);
-	if (rc)
-		return rc;
 	return dentry_has_perm(current, NULL, dentry, FILE__READ);
 }
 
 static int selinux_inode_permission(struct inode *inode, int mask,
 				    struct nameidata *nd)
 {
-	int rc;
-
-	rc = secondary_ops->inode_permission(inode, mask, nd);
-	if (rc)
-		return rc;
-
 	if (!mask) {
 		/* No permission to check.  Existence test. */
 		return 0;
@@ -2204,12 +2081,6 @@ static int selinux_inode_permission(stru
 
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 {
-	int rc;
-
-	rc = secondary_ops->inode_setattr(dentry, iattr);
-	if (rc)
-		return rc;
-
 	if (iattr->ia_valid & ATTR_FORCE)
 		return 0;
 
@@ -2531,12 +2402,6 @@ static int file_map_prot_check(struct fi
 static int selinux_file_mmap(struct file *file, unsigned long reqprot,
 			     unsigned long prot, unsigned long flags)
 {
-	int rc;
-
-	rc = secondary_ops->file_mmap(file, reqprot, prot, flags);
-	if (rc)
-		return rc;
-
 	if (selinux_checkreqprot)
 		prot = reqprot;
 
@@ -2550,10 +2415,6 @@ static int selinux_file_mprotect(struct 
 {
 	int rc;
 
-	rc = secondary_ops->file_mprotect(vma, reqprot, prot);
-	if (rc)
-		return rc;
-
 	if (selinux_checkreqprot)
 		prot = reqprot;
 
@@ -2576,7 +2437,7 @@ static int selinux_file_mprotect(struct 
 		 * check ability to execute the possibly modified content.
 		 * This typically should only occur for text relocations.
 		 */
-		int rc = file_has_perm(current, vma->vm_file, FILE__EXECMOD);
+		rc = file_has_perm(current, vma->vm_file, FILE__EXECMOD);
 		if (rc)
 			return rc;
 	}
@@ -2692,12 +2553,6 @@ static int selinux_file_receive(struct f
 
 static int selinux_task_create(unsigned long clone_flags)
 {
-	int rc;
-
-	rc = secondary_ops->task_create(clone_flags);
-	if (rc)
-		return rc;
-
 	return task_has_perm(current, current, PROCESS__FORK);
 }
 
@@ -2746,11 +2601,6 @@ static int selinux_task_setuid(uid_t id0
 	return 0;
 }
 
-static int selinux_task_post_setuid(uid_t id0, uid_t id1, uid_t id2, int flags)
-{
-	return secondary_ops->task_post_setuid(id0,id1,id2,flags);
-}
-
 static int selinux_task_setgid(gid_t id0, gid_t id1, gid_t id2, int flags)
 {
 	/* See the comment for setuid above. */
@@ -2780,24 +2630,12 @@ static int selinux_task_setgroups(struct
 
 static int selinux_task_setnice(struct task_struct *p, int nice)
 {
-	int rc;
-
-	rc = secondary_ops->task_setnice(p, nice);
-	if (rc)
-		return rc;
-
 	return task_has_perm(current,p, PROCESS__SETSCHED);
 }
 
 static int selinux_task_setrlimit(unsigned int resource, struct rlimit *new_rlim)
 {
 	struct rlimit *old_rlim = current->signal->rlim + resource;
-	int rc;
-
-	rc = secondary_ops->task_setrlimit(resource, new_rlim);
-	if (rc)
-		return rc;
-
 	/* Control the ability to change the hard limit (whether
 	   lowering or raising it), so that the hard limit can
 	   later be used as a safe reset point for the soft limit
@@ -2821,11 +2659,6 @@ static int selinux_task_getscheduler(str
 static int selinux_task_kill(struct task_struct *p, struct siginfo *info, int sig)
 {
 	u32 perm;
-	int rc;
-
-	rc = secondary_ops->task_kill(p, info, sig);
-	if (rc)
-		return rc;
 
 	if (info && ((unsigned long)info == 1 ||
 	             (unsigned long)info == 2 || SI_FROMKERNEL(info)))
@@ -2864,8 +2697,6 @@ static void selinux_task_reparent_to_ini
 {
   	struct task_security_struct *tsec;
 
-	secondary_ops->task_reparent_to_init(p);
-
 	tsec = security_get_value_type(&p->security, SELINUX_LSM_ID,
 		struct task_security_struct);
 	tsec->osid = tsec->sid;
@@ -3329,10 +3160,6 @@ static int selinux_socket_unix_stream_co
 	struct avc_audit_data ad;
 	int err;
 
-	err = secondary_ops->unix_stream_connect(sock, other, newsk);
-	if (err)
-		return err;
-
 	isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
 		SELINUX_LSM_ID, struct inode_security_struct);
 	other_isec = security_get_value_type(&SOCK_INODE(other)->i_security,
@@ -3716,11 +3543,7 @@ static int selinux_netlink_send(struct s
 {
 	struct task_security_struct *tsec;
 	struct av_decision avd;
-	int err;
-
-	err = secondary_ops->netlink_send(sk, skb);
-	if (err)
-		return err;
+	int err = 0;
 
 	tsec = security_get_value_type(&current->security,
 		SELINUX_LSM_ID, struct task_security_struct);
@@ -3736,13 +3559,6 @@ static int selinux_netlink_send(struct s
 	return err;
 }
 
-static int selinux_netlink_recv(struct sk_buff *skb)
-{
-	if (!cap_raised(NETLINK_CB(skb).eff_cap, CAP_NET_ADMIN))
-		return -EPERM;
-	return 0;
-}
-
 static int ipc_alloc_security(struct task_struct *task,
 			      struct kern_ipc_perm *perm,
 			      u16 sclass)
@@ -4080,11 +3896,6 @@ static int selinux_shm_shmat(struct shmi
 			     char __user *shmaddr, int shmflg)
 {
 	u32 perms;
-	int rc;
-
-	rc = secondary_ops->shm_shmat(shp, shmaddr, shmflg);
-	if (rc)
-		return rc;
 
 	if (shmflg & SHM_RDONLY)
 		perms = SHM__READ;
@@ -4220,32 +4031,12 @@ static int selinux_ipc_permission(struct
 /* module stacking operations */
 static int selinux_register_security (const char *name, struct security_operations *ops)
 {
-	if (secondary_ops != original_ops) {
-		printk(KERN_INFO "%s:  There is already a secondary security "
-		       "module registered.\n", __FUNCTION__);
-		return -EINVAL;
- 	}
-
-	secondary_ops = ops;
-
-	printk(KERN_INFO "%s:  Registering secondary module %s\n",
-	       __FUNCTION__,
-	       name);
-
-	return 0;
+	return -EINVAL;
 }
 
 static int selinux_unregister_security (const char *name, struct security_operations *ops)
 {
-	if (ops != secondary_ops) {
-		printk (KERN_INFO "%s:  trying to unregister a security module "
-		        "that is not registered.\n", __FUNCTION__);
-		return -EINVAL;
-	}
-
-	secondary_ops = original_ops;
-
-	return 0;
+	return -EINVAL;
 }
 
 static void selinux_d_instantiate (struct dentry *dentry, struct inode *inode)
@@ -4410,23 +4201,19 @@ static struct security_operations selinu
 	.ptrace =			selinux_ptrace,
 	.capget =			selinux_capget,
 	.capset_check =			selinux_capset_check,
-	.capset_set =			selinux_capset_set,
 	.sysctl =			selinux_sysctl,
 	.capable =			selinux_capable,
 	.quotactl =			selinux_quotactl,
 	.quota_on =			selinux_quota_on,
 	.syslog =			selinux_syslog,
-	.vm_enough_memory =		selinux_vm_enough_memory,
 
 	.netlink_send =			selinux_netlink_send,
-        .netlink_recv =			selinux_netlink_recv,
 
 	.bprm_alloc_security =		selinux_bprm_alloc_security,
 	.bprm_free_security =		selinux_bprm_free_security,
 	.bprm_apply_creds =		selinux_bprm_apply_creds,
 	.bprm_post_apply_creds =	selinux_bprm_post_apply_creds,
 	.bprm_set_security =		selinux_bprm_set_security,
-	.bprm_check_security =		selinux_bprm_check_security,
 	.bprm_secureexec =		selinux_bprm_secureexec,
 
 	.sb_alloc_security =		selinux_sb_alloc_security,
@@ -4483,7 +4270,6 @@ static struct security_operations selinu
 	.task_alloc_security =		selinux_task_alloc_security,
 	.task_free_security =		selinux_task_free_security,
 	.task_setuid =			selinux_task_setuid,
-	.task_post_setuid =		selinux_task_post_setuid,
 	.task_setgid =			selinux_task_setgid,
 	.task_setpgid =			selinux_task_setpgid,
 	.task_getpgid =			selinux_task_getpgid,
@@ -4555,10 +4341,12 @@ static struct security_operations selinu
 #endif
 };
 
+#define MY_NAME "selinux"
 static __init int selinux_init(void)
 {
 	struct task_security_struct *tsec;
 
+	secondary = 0;
 	if (!selinux_enabled) {
 		printk(KERN_INFO "SELinux:  Disabled at boot.\n");
 		return 0;
@@ -4569,22 +4357,30 @@ static __init int selinux_init(void)
 	/* Set the security state for the initial task. */
 	if (task_alloc_security(current))
 		panic("SELinux:  Failed to initialize initial task.\n");
-	tsec = current->security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
 
 	avc_init();
 
-	original_ops = secondary_ops = security_ops;
-	if (!secondary_ops)
-		panic ("SELinux: No initial security operations\n");
-	if (register_security (&selinux_ops))
-		panic("SELinux: Unable to register with kernel.\n");
+	if (register_security (&selinux_ops)) {
+		if (mod_reg_security( MY_NAME, &selinux_ops)) {
+			printk(KERN_ERR "%s: Failed to register with primary LSM.\n",
+				__FUNCTION__);
+			panic("SELinux: Unable to register with kernel.\n");
+		} else {
+			printk(KERN_ERR "%s: registered with primary LSM.\n",
+				__FUNCTION__);
+		}
+		secondary = 1;
+	}
 
 	if (selinux_enforcing) {
 		printk(KERN_INFO "SELinux:  Starting in enforcing mode\n");
 	} else {
 		printk(KERN_INFO "SELinux:  Starting in permissive mode\n");
 	}
+
 	return 0;
 }
 
@@ -4694,6 +4490,7 @@ int selinux_disable(void)
 {
 	extern void exit_sel_fs(void);
 	static int selinux_disabled = 0;
+	int ret;
 
 	if (ss_initialized) {
 		/* Not permitted after initial policy load. */
@@ -4709,8 +4506,15 @@ int selinux_disable(void)
 
 	selinux_disabled = 1;
 
-	/* Reset security_ops to the secondary module, dummy or capability. */
-	security_ops = secondary_ops;
+	if (secondary)
+		ret = mod_unreg_security(MY_NAME, &selinux_ops);
+	else
+		ret = unregister_security(&selinux_ops);
+
+	if (ret)
+		printk(KERN_INFO "Failure unregistering selinux.\n");
+	else
+		printk(KERN_INFO "Unregistered selinux.\n");
 
 	/* Unregister netfilter hooks. */
 	selinux_nf_ip_exit();
