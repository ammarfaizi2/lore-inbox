Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbUKDWX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUKDWX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUKDWX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:23:26 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:12267 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262451AbUKDWAy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:00:54 -0500
Subject: Re: [RFC] [PATCH] [5/6] LSM Stacking: SELinux LSM stacking support
From: Serge Hallyn <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1099609471.2096.10.camel@serge.austin.ibm.com>
References: <1099609471.2096.10.camel@serge.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1099609866.2096.23.camel@serge.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Nov 2004 17:11:06 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds stacking support to the SELinux LSM.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

Index: linux-2.6.10-rc1-bk12-stack/security/selinux/hooks.c
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/security/selinux/hooks.c	2004-11-02
19:56:04.309432960 -0600
+++ linux-2.6.10-rc1-bk12-stack/security/selinux/hooks.c	2004-11-02
20:08:19.593652768 -0600
@@ -76,6 +76,9 @@
 extern int policydb_loaded_version;
 extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
 
+int selinux_idx;
+static int secondary;
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 int selinux_enforcing = 0;
 
@@ -98,15 +101,6 @@
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
@@ -126,25 +120,25 @@
 	tsec->magic = SELINUX_MAGIC;
 	tsec->task = task;
 	tsec->osid = tsec->sid = tsec->ptrace_sid = SECINITSID_UNLABELED;
-	task->security = tsec;
+	task->security[selinux_idx] = tsec;
 
 	return 0;
 }
 
 static void task_free_security(struct task_struct *task)
 {
-	struct task_security_struct *tsec = task->security;
+	struct task_security_struct *tsec = task->security[selinux_idx];
 
 	if (!tsec || tsec->magic != SELINUX_MAGIC)
 		return;
 
-	task->security = NULL;
+	task->security[selinux_idx] = NULL;
 	kfree(tsec);
 }
 
 static int inode_alloc_security(struct inode *inode)
 {
-	struct task_security_struct *tsec = current->security;
+	struct task_security_struct *tsec = current->security[selinux_idx];
 	struct inode_security_struct *isec;
 
 	isec = kmalloc(sizeof(struct inode_security_struct), GFP_KERNEL);
@@ -162,15 +156,15 @@
 		isec->task_sid = tsec->sid;
 	else
 		isec->task_sid = SECINITSID_UNLABELED;
-	inode->i_security = isec;
+	inode->i_security[selinux_idx] = isec;
 
 	return 0;
 }
 
 static void inode_free_security(struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
-	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
+	struct inode_security_struct *isec = inode->i_security[selinux_idx];
+	struct superblock_security_struct *sbsec =
inode->i_sb->s_security[selinux_idx];
 
 	if (!isec || isec->magic != SELINUX_MAGIC)
 		return;
@@ -180,13 +174,13 @@
 		list_del_init(&isec->list);
 	spin_unlock(&sbsec->isec_lock);
 
-	inode->i_security = NULL;
+	inode->i_security[selinux_idx] = NULL;
 	kfree(isec);
 }
 
 static int file_alloc_security(struct file *file)
 {
-	struct task_security_struct *tsec = current->security;
+	struct task_security_struct *tsec = current->security[selinux_idx];
 	struct file_security_struct *fsec;
 
 	fsec = kmalloc(sizeof(struct file_security_struct), GFP_ATOMIC);
@@ -203,19 +197,19 @@
 		fsec->sid = SECINITSID_UNLABELED;
 		fsec->fown_sid = SECINITSID_UNLABELED;
 	}
-	file->f_security = fsec;
+	file->f_security[selinux_idx] = fsec;
 
 	return 0;
 }
 
 static void file_free_security(struct file *file)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec = file->f_security[selinux_idx];
 
 	if (!fsec || fsec->magic != SELINUX_MAGIC)
 		return;
 
-	file->f_security = NULL;
+	file->f_security[selinux_idx] = NULL;
 	kfree(fsec);
 }
 
@@ -236,14 +230,14 @@
 	sbsec->sb = sb;
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
-	sb->s_security = sbsec;
+	sb->s_security[selinux_idx] = sbsec;
 
 	return 0;
 }
 
 static void superblock_free_security(struct super_block *sb)
 {
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec =
sb->s_security[selinux_idx];
 
 	if (!sbsec || sbsec->magic != SELINUX_MAGIC)
 		return;
@@ -253,7 +247,7 @@
 		list_del_init(&sbsec->list);
 	spin_unlock(&sb_security_lock);
 
-	sb->s_security = NULL;
+	sb->s_security[selinux_idx] = NULL;
 	kfree(sbsec);
 }
 
@@ -273,19 +267,19 @@
 	ssec->magic = SELINUX_MAGIC;
 	ssec->sk = sk;
 	ssec->peer_sid = SECINITSID_UNLABELED;
-	sk->sk_security = ssec;
+	sk->sk_security[selinux_idx] = ssec;
 
 	return 0;
 }
 
 static void sk_free_security(struct sock *sk)
 {
-	struct sk_security_struct *ssec = sk->sk_security;
+	struct sk_security_struct *ssec = sk->sk_security[selinux_idx];
 
 	if (sk->sk_family != PF_UNIX || ssec->magic != SELINUX_MAGIC)
 		return;
 
-	sk->sk_security = NULL;
+	sk->sk_security[selinux_idx] = NULL;
 	kfree(ssec);
 }
 #endif	/* CONFIG_SECURITY_NETWORK */
@@ -332,8 +326,8 @@
 	const char *name;
 	u32 sid;
 	int alloc = 0, rc = 0, seen = 0;
-	struct task_security_struct *tsec = current->security;
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct task_security_struct *tsec = current->security[selinux_idx];
+	struct superblock_security_struct *sbsec =
sb->s_security[selinux_idx];
 
 	if (!data)
 		goto out;
@@ -499,7 +493,7 @@
 
 static int superblock_doinit(struct super_block *sb, void *data)
 {
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec =
sb->s_security[selinux_idx];
 	struct dentry *root = sb->s_root;
 	struct inode *inode = root->d_inode;
 	int rc = 0;
@@ -722,7 +716,7 @@
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry
*opt_dentry)
 {
 	struct superblock_security_struct *sbsec = NULL;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = inode->i_security[selinux_idx];
 	u32 sid;
 	struct dentry *dentry;
 #define INITCONTEXTLEN 255
@@ -739,7 +733,7 @@
 	if (isec->initialized)
 		goto out;
 
-	sbsec = inode->i_sb->s_security;
+	sbsec = inode->i_sb->s_security[selinux_idx];
 	if (!sbsec->initialized) {
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
@@ -921,8 +915,8 @@
 {
 	struct task_security_struct *tsec1, *tsec2;
 
-	tsec1 = tsk1->security;
-	tsec2 = tsk2->security;
+	tsec1 = tsk1->security[selinux_idx];
+	tsec2 = tsk2->security[selinux_idx];
 	return avc_has_perm(tsec1->sid, tsec2->sid,
 			    SECCLASS_PROCESS, perms, &tsec2->avcr, NULL);
 }
@@ -934,7 +928,7 @@
 	struct task_security_struct *tsec;
 	struct avc_audit_data ad;
 
-	tsec = tsk->security;
+	tsec = tsk->security[selinux_idx];
 
 	AVC_AUDIT_DATA_INIT(&ad,CAP);
 	ad.tsk = tsk;
@@ -950,7 +944,7 @@
 {
 	struct task_security_struct *tsec;
 
-	tsec = tsk->security;
+	tsec = tsk->security[selinux_idx];
 
 	return avc_has_perm(tsec->sid, SECINITSID_KERNEL,
 			    SECCLASS_SYSTEM, perms, NULL, NULL);
@@ -971,8 +965,8 @@
 	struct inode_security_struct *isec;
 	struct avc_audit_data ad;
 
-	tsec = tsk->security;
-	isec = inode->i_security;
+	tsec = tsk->security[selinux_idx];
+	isec = inode->i_security[selinux_idx];
 
 	if (!adp) {
 		adp = &ad;
@@ -1012,8 +1006,8 @@
 				struct file *file,
 				u32 av)
 {
-	struct task_security_struct *tsec = tsk->security;
-	struct file_security_struct *fsec = file->f_security;
+	struct task_security_struct *tsec = tsk->security[selinux_idx];
+	struct file_security_struct *fsec = file->f_security[selinux_idx];
 	struct vfsmount *mnt = file->f_vfsmnt;
 	struct dentry *dentry = file->f_dentry;
 	struct inode *inode = dentry->d_inode;
@@ -1052,9 +1046,9 @@
 	struct avc_audit_data ad;
 	int rc;
 
-	tsec = current->security;
-	dsec = dir->i_security;
-	sbsec = dir->i_sb->s_security;
+	tsec = current->security[selinux_idx];
+	dsec = dir->i_security[selinux_idx];
+	sbsec = dir->i_sb->s_security[selinux_idx];
 
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.dentry = dentry;
@@ -1099,9 +1093,9 @@
 	u32 av;
 	int rc;
 
-	tsec = current->security;
-	dsec = dir->i_security;
-	isec = dentry->d_inode->i_security;
+	tsec = current->security[selinux_idx];
+	dsec = dir->i_security[selinux_idx];
+	isec = dentry->d_inode->i_security[selinux_idx];
 
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.dentry = dentry;
@@ -1145,11 +1139,11 @@
 	int old_is_dir, new_is_dir;
 	int rc;
 
-	tsec = current->security;
-	old_dsec = old_dir->i_security;
-	old_isec = old_dentry->d_inode->i_security;
+	tsec = current->security[selinux_idx];
+	old_dsec = old_dir->i_security[selinux_idx];
+	old_isec = old_dentry->d_inode->i_security[selinux_idx];
 	old_is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
-	new_dsec = new_dir->i_security;
+	new_dsec = new_dir->i_security[selinux_idx];
 
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 
@@ -1183,7 +1177,7 @@
 	if (rc)
 		return rc;
 	if (new_dentry->d_inode) {
-		new_isec = new_dentry->d_inode->i_security;
+		new_isec = new_dentry->d_inode->i_security[selinux_idx];
 		new_is_dir = S_ISDIR(new_dentry->d_inode->i_mode);
 		rc = avc_has_perm(tsec->sid, new_isec->sid,
 				  new_isec->sclass,
@@ -1205,8 +1199,8 @@
 	struct task_security_struct *tsec;
 	struct superblock_security_struct *sbsec;
 
-	tsec = tsk->security;
-	sbsec = sb->s_security;
+	tsec = tsk->security[selinux_idx];
+	sbsec = sb->s_security[selinux_idx];
 	return avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			    perms, NULL, ad);
 }
@@ -1259,8 +1253,8 @@
 /* Set an inode's SID to a specified value. */
 int inode_security_set_sid(struct inode *inode, u32 sid)
 {
-	struct inode_security_struct *isec = inode->i_security;
-	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
+	struct inode_security_struct *isec = inode->i_security[selinux_idx];
+	struct superblock_security_struct *sbsec =
inode->i_sb->s_security[selinux_idx];
 
 	if (!sbsec->initialized) {
 		/* Defer initialization to selinux_complete_init. */
@@ -1289,9 +1283,9 @@
 	unsigned int len;
 	int rc;
 
-	tsec = current->security;
-	dsec = dir->i_security;
-	sbsec = dir->i_sb->s_security;
+	tsec = current->security[selinux_idx];
+	dsec = dir->i_security[selinux_idx];
+	sbsec = dir->i_sb->s_security[selinux_idx];
 
 	inode = dentry->d_inode;
 	if (!inode) {
@@ -1358,14 +1352,10 @@
 
 static int selinux_ptrace(struct task_struct *parent, struct
task_struct *child)
 {
-	struct task_security_struct *psec = parent->security;
-	struct task_security_struct *csec = child->security;
+	struct task_security_struct *psec = parent->security[selinux_idx];
+	struct task_security_struct *csec = child->security[selinux_idx];
 	int rc;
 
-	rc = secondary_ops->ptrace(parent,child);
-	if (rc)
-		return rc;
-
 	rc = task_has_perm(parent, child, PROCESS__PTRACE);
 	/* Save the SID of the tracing process for later use in apply_creds.
*/
 	if (!rc)
@@ -1376,47 +1366,17 @@
 static int selinux_capget(struct task_struct *target, kernel_cap_t
*effective,
                           kernel_cap_t *inheritable, kernel_cap_t
*permitted)
 {
-	int error;
-
-	error = task_has_perm(current, target, PROCESS__GETCAP);
-	if (error)
-		return error;
-
-	return secondary_ops->capget(target, effective, inheritable,
permitted);
+	return task_has_perm(current, target, PROCESS__GETCAP);
 }
 
 static int selinux_capset_check(struct task_struct *target,
kernel_cap_t *effective,
                                 kernel_cap_t *inheritable, kernel_cap_t
*permitted)
 {
-	int error;
-
-	error = secondary_ops->capset_check(target, effective, inheritable,
permitted);
-	if (error)
-		return error;
-
 	return task_has_perm(current, target, PROCESS__SETCAP);
 }
 
-static void selinux_capset_set(struct task_struct *target, kernel_cap_t
*effective,
-                               kernel_cap_t *inheritable, kernel_cap_t
*permitted)
-{
-	int error;
-
-	error = task_has_perm(current, target, PROCESS__SETCAP);
-	if (error)
-		return;
-
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
 
@@ -1428,11 +1388,7 @@
 	u32 tsid;
 	int rc;
 
-	rc = secondary_ops->sysctl(table, op);
-	if (rc)
-		return rc;
-
-	tsec = current->security;
+	tsec = current->security[selinux_idx];
 
 	rc = selinux_proc_get_sid(table->de, (op == 001) ?
 	                          SECCLASS_DIR : SECCLASS_FILE, &tsid);
@@ -1500,10 +1456,6 @@
 {
 	int rc;
 
-	rc = secondary_ops->syslog(type);
-	if (rc)
-		return rc;
-
 	switch (type) {
 		case 3:         /* Read last kernel messages */
 		case 10:        /* Return size of the log buffer */
@@ -1541,7 +1493,7 @@
 {
 	unsigned long free, allowed;
 	int rc;
-	struct task_security_struct *tsec = current->security;
+	struct task_security_struct *tsec = current->security[selinux_idx];
 
 	vm_acct_memory(pages);
 
@@ -1569,13 +1521,10 @@
 		 * Don't audit the check, as it is applied to all processes
 		 * that allocate mappings.
 		 */
-		rc = secondary_ops->capable(current, CAP_SYS_ADMIN);
-		if (!rc) {
-			rc = avc_has_perm_noaudit(tsec->sid, tsec->sid,
-						  SECCLASS_CAPABILITY,
-						  CAP_TO_MASK(CAP_SYS_ADMIN),
-						  NULL, NULL);
-		}
+		rc = avc_has_perm_noaudit(tsec->sid, tsec->sid,
+					  SECCLASS_CAPABILITY,
+					  CAP_TO_MASK(CAP_SYS_ADMIN),
+					  NULL, NULL);
 		if (rc)
 			free -= free / 32;
 
@@ -1613,7 +1562,7 @@
 	bsec->sid = SECINITSID_UNLABELED;
 	bsec->set = 0;
 
-	bprm->security = bsec;
+	bprm->security[selinux_idx] = bsec;
 	return 0;
 }
 
@@ -1627,17 +1576,13 @@
 	struct avc_audit_data ad;
 	int rc;
 
-	rc = secondary_ops->bprm_set_security(bprm);
-	if (rc)
-		return rc;
-
-	bsec = bprm->security;
+	bsec = bprm->security[selinux_idx];
 
 	if (bsec->set)
 		return 0;
 
-	tsec = current->security;
-	isec = inode->i_security;
+	tsec = current->security[selinux_idx];
+	isec = inode->i_security[selinux_idx];
 
 	/* Default to the current task SID. */
 	bsec->sid = tsec->sid;
@@ -1696,33 +1641,26 @@
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
-	struct task_security_struct *tsec = current->security;
-	int atsecure = 0;
+	struct task_security_struct *tsec = current->security[selinux_idx];
 
 	if (tsec->osid != tsec->sid) {
 		/* Enable secure mode for SIDs transitions unless
 		   the noatsecure permission is granted between
 		   the two SIDs, i.e. ahp returns 0. */
-		atsecure = avc_has_perm(tsec->osid, tsec->sid,
+		return avc_has_perm(tsec->osid, tsec->sid,
 					 SECCLASS_PROCESS,
 					 PROCESS__NOATSECURE, NULL, NULL);
 	}
 
-	return (atsecure || secondary_ops->bprm_secureexec(bprm));
+	return 0;
 }
 
 static void selinux_bprm_free_security(struct linux_binprm *bprm)
 {
-	struct bprm_security_struct *bsec = bprm->security;
-	bprm->security = NULL;
+	struct bprm_security_struct *bsec = bprm->security[selinux_idx];
+	bprm->security[selinux_idx] = NULL;
 	kfree(bsec);
 }
 
@@ -1822,11 +1760,9 @@
 	struct rlimit *rlim, *initrlim;
 	int rc, i;
 
-	secondary_ops->bprm_apply_creds(bprm, unsafe);
+	tsec = current->security[selinux_idx];
 
-	tsec = current->security;
-
-	bsec = bprm->security;
+	bsec = bprm->security[selinux_idx];
 	sid = bsec->sid;
 
 	tsec->osid = tsec->sid;
@@ -2030,12 +1966,6 @@
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
@@ -2046,12 +1976,6 @@
 
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
@@ -2080,11 +2004,6 @@
 
 static int selinux_inode_link(struct dentry *old_dentry, struct inode
*dir, struct dentry *new_dentry)
 {
-	int rc;
-
-	rc = secondary_ops->inode_link(old_dentry,dir,new_dentry);
-	if (rc)
-		return rc;
 	return may_link(dir, old_dentry, MAY_LINK);
 }
 
@@ -2095,11 +2014,6 @@
 
 static int selinux_inode_unlink(struct inode *dir, struct dentry
*dentry)
 {
-	int rc;
-
-	rc = secondary_ops->inode_unlink(dir, dentry);
-	if (rc)
-		return rc;
 	return may_link(dir, dentry, MAY_UNLINK);
 }
 
@@ -2130,12 +2044,6 @@
 
 static int selinux_inode_mknod(struct inode *dir, struct dentry
*dentry, int mode, dev_t dev)
 {
-	int rc;
-
-	rc = secondary_ops->inode_mknod(dir, dentry, mode, dev);
-	if (rc)
-		return rc;
-
 	return may_create(dir, dentry, inode_mode_to_security_class(mode));
 }
 
@@ -2163,23 +2071,12 @@
 
 static int selinux_inode_follow_link(struct dentry *dentry, struct
nameidata *nameidata)
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
@@ -2191,12 +2088,6 @@
 
 static int selinux_inode_setattr(struct dentry *dentry, struct iattr
*iattr)
 {
-	int rc;
-
-	rc = secondary_ops->inode_setattr(dentry, iattr);
-	if (rc)
-		return rc;
-
 	if (iattr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID |
 			       ATTR_ATIME_SET | ATTR_MTIME_SET))
 		return dentry_has_perm(current, NULL, dentry, FILE__SETATTR);
@@ -2211,9 +2102,9 @@
 
 static int selinux_inode_setxattr(struct dentry *dentry, char *name,
void *value, size_t size, int flags)
 {
-	struct task_security_struct *tsec = current->security;
+	struct task_security_struct *tsec = current->security[selinux_idx];
 	struct inode *inode = dentry->d_inode;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = inode->i_security[selinux_idx];
 	struct superblock_security_struct *sbsec;
 	struct avc_audit_data ad;
 	u32 newsid;
@@ -2233,7 +2124,7 @@
 		return dentry_has_perm(current, NULL, dentry, FILE__SETATTR);
 	}
 
-	sbsec = inode->i_sb->s_security;
+	sbsec = inode->i_sb->s_security[selinux_idx];
 	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
 		return -EOPNOTSUPP;
 
@@ -2270,7 +2161,7 @@
                                         void *value, size_t size, int
flags)
 {
 	struct inode *inode = dentry->d_inode;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = inode->i_security[selinux_idx];
 	u32 newsid;
 	int rc;
 
@@ -2293,7 +2184,7 @@
 static int selinux_inode_getxattr (struct dentry *dentry, char *name)
 {
 	struct inode *inode = dentry->d_inode;
-	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
+	struct superblock_security_struct *sbsec =
inode->i_sb->s_security[selinux_idx];
 
 	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
 		return -EOPNOTSUPP;
@@ -2330,7 +2221,7 @@
 
 static int selinux_inode_getsecurity(struct inode *inode, const char
*name, void *buffer, size_t size)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = inode->i_security[selinux_idx];
 	char *context;
 	unsigned len;
 	int rc;
@@ -2360,7 +2251,7 @@
 static int selinux_inode_setsecurity(struct inode *inode, const char
*name,
                                      const void *value, size_t size,
int flags)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec = inode->i_security[selinux_idx];
 	u32 newsid;
 	int rc;
 
@@ -2481,12 +2372,6 @@
 
 static int selinux_file_mmap(struct file *file, unsigned long prot,
unsigned long flags)
 {
-	int rc;
-
-	rc = secondary_ops->file_mmap(file, prot, flags);
-	if (rc)
-		return rc;
-
 	return file_map_prot_check(file, prot,
 				   (flags & MAP_TYPE) == MAP_SHARED);
 }
@@ -2494,12 +2379,6 @@
 static int selinux_file_mprotect(struct vm_area_struct *vma,
 				 unsigned long prot)
 {
-	int rc;
-
-	rc = secondary_ops->file_mprotect(vma, prot);
-	if (rc)
-		return rc;
-
 	return file_map_prot_check(vma->vm_file, prot,
vma->vm_flags&VM_SHARED);
 }
 
@@ -2557,8 +2436,8 @@
 	struct task_security_struct *tsec;
 	struct file_security_struct *fsec;
 
-	tsec = current->security;
-	fsec = file->f_security;
+	tsec = current->security[selinux_idx];
+	fsec = file->f_security[selinux_idx];
 	fsec->fown_sid = tsec->sid;
 
 	return 0;
@@ -2575,8 +2454,8 @@
 	/* struct fown_struct is never outside the context of a struct file */
         file = (struct file *)((long)fown - offsetof(struct
file,f_owner));
 
-	tsec = tsk->security;
-	fsec = file->f_security;
+	tsec = tsk->security[selinux_idx];
+	fsec = file->f_security[selinux_idx];
 
 	if (!signum)
 		perm = signal_to_av(SIGIO); /* as per send_sigio_to_task */
@@ -2596,12 +2475,6 @@
 
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
 
@@ -2610,12 +2483,12 @@
 	struct task_security_struct *tsec1, *tsec2;
 	int rc;
 
-	tsec1 = current->security;
+	tsec1 = current->security[selinux_idx];
 
 	rc = task_alloc_security(tsk);
 	if (rc)
 		return rc;
-	tsec2 = tsk->security;
+	tsec2 = tsk->security[selinux_idx];
 
 	tsec2->osid = tsec1->osid;
 	tsec2->sid = tsec1->sid;
@@ -2648,11 +2521,6 @@
 	return 0;
 }
 
-static int selinux_task_post_setuid(uid_t id0, uid_t id1, uid_t id2,
int flags)
-{
-	return secondary_ops->task_post_setuid(id0,id1,id2,flags);
-}
-
 static int selinux_task_setgid(gid_t id0, gid_t id1, gid_t id2, int
flags)
 {
 	/* See the comment for setuid above. */
@@ -2682,23 +2550,12 @@
 
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
 
 static int selinux_task_setrlimit(unsigned int resource, struct rlimit
*new_rlim)
 {
 	struct rlimit *old_rlim = current->signal->rlim + resource;
-	int rc;
-
-	rc = secondary_ops->task_setrlimit(resource, new_rlim);
-	if (rc)
-		return rc;
 
 	/* Control the ability to change the hard limit (whether
 	   lowering or raising it), so that the hard limit can
@@ -2714,8 +2571,8 @@
 {
 	struct task_security_struct *tsec1, *tsec2;
 
-	tsec1 = current->security;
-	tsec2 = p->security;
+	tsec1 = current->security[selinux_idx];
+	tsec2 = p->security[selinux_idx];
 
 	/* No auditing from the setscheduler hook, since the runqueue lock
 	   is held and the system will deadlock if we try to log an audit
@@ -2733,11 +2590,6 @@
 static int selinux_task_kill(struct task_struct *p, struct siginfo
*info, int sig)
 {
 	u32 perm;
-	int rc;
-
-	rc = secondary_ops->task_kill(p, info, sig);
-	if (rc)
-		return rc;
 
 	if (info && ((unsigned long)info == 1 ||
 	             (unsigned long)info == 2 || SI_FROMKERNEL(info)))
@@ -2776,9 +2628,7 @@
 {
   	struct task_security_struct *tsec;
 
-	secondary_ops->task_reparent_to_init(p);
-
-	tsec = p->security;
+	tsec = p->security[selinux_idx];
 	tsec->osid = tsec->sid;
 	tsec->sid = SECINITSID_KERNEL;
 	return;
@@ -2787,8 +2637,8 @@
 static void selinux_task_to_inode(struct task_struct *p,
 				  struct inode *inode)
 {
-	struct task_security_struct *tsec = p->security;
-	struct inode_security_struct *isec = inode->i_security;
+	struct task_security_struct *tsec = p->security[selinux_idx];
+	struct inode_security_struct *isec = inode->i_security[selinux_idx];
 
 	isec->sid = tsec->sid;
 	isec->initialized = 1;
@@ -2957,8 +2807,8 @@
 	struct avc_audit_data ad;
 	int err = 0;
 
-	tsec = task->security;
-	isec = SOCK_INODE(sock)->i_security;
+	tsec = task->security[selinux_idx];
+	isec = SOCK_INODE(sock)->i_security[selinux_idx];
 
 	if (isec->sid == SECINITSID_KERNEL)
 		goto out;
@@ -2981,7 +2831,7 @@
 	if (kern)
 		goto out;
 
-	tsec = current->security;
+	tsec = current->security[selinux_idx];
 	err = avc_has_perm(tsec->sid, tsec->sid,
 			   socket_type_to_security_class(family, type,
 			   protocol), SOCKET__CREATE, NULL, NULL);
@@ -3000,9 +2850,9 @@
 	err = inode_doinit(SOCK_INODE(sock));
 	if (err < 0)
 		return;
-	isec = SOCK_INODE(sock)->i_security;
+	isec = SOCK_INODE(sock)->i_security[selinux_idx];
 
-	tsec = current->security;
+	tsec = current->security[selinux_idx];
 	isec->sclass = socket_type_to_security_class(family, type, protocol);
 	isec->sid = kern ? SECINITSID_KERNEL : tsec->sid;
 
@@ -3039,8 +2889,8 @@
 		struct sock *sk = sock->sk;
 		u32 sid, node_perm, addrlen;
 
-		tsec = current->security;
-		isec = SOCK_INODE(sock)->i_security;
+		tsec = current->security[selinux_idx];
+		isec = SOCK_INODE(sock)->i_security[selinux_idx];
 
 		if (family == PF_INET) {
 			addr4 = (struct sockaddr_in *)address;
@@ -3129,9 +2979,9 @@
 	err = inode_doinit(SOCK_INODE(newsock));
 	if (err < 0)
 		return err;
-	newisec = SOCK_INODE(newsock)->i_security;
+	newisec = SOCK_INODE(newsock)->i_security[selinux_idx];
 
-	isec = SOCK_INODE(sock)->i_security;
+	isec = SOCK_INODE(sock)->i_security[selinux_idx];
 	newisec->sclass = isec->sclass;
 	newisec->sid = isec->sid;
 
@@ -3186,12 +3036,8 @@
 	struct avc_audit_data ad;
 	int err;
 
-	err = secondary_ops->unix_stream_connect(sock, other, newsk);
-	if (err)
-		return err;
-
-	isec = SOCK_INODE(sock)->i_security;
-	other_isec = SOCK_INODE(other)->i_security;
+	isec = SOCK_INODE(sock)->i_security[selinux_idx];
+	other_isec = SOCK_INODE(other)->i_security[selinux_idx];
 
 	AVC_AUDIT_DATA_INIT(&ad,NET);
 	ad.u.net.sk = other->sk;
@@ -3204,11 +3050,11 @@
 		return err;
 
 	/* connecting socket */
-	ssec = sock->sk->sk_security;
+	ssec = sock->sk->sk_security[selinux_idx];
 	ssec->peer_sid = other_isec->sid;
 	
 	/* server child socket */
-	ssec = newsk->sk_security;
+	ssec = newsk->sk_security[selinux_idx];
 	ssec->peer_sid = isec->sid;
 	
 	return 0;
@@ -3222,8 +3068,8 @@
 	struct avc_audit_data ad;
 	int err;
 
-	isec = SOCK_INODE(sock)->i_security;
-	other_isec = SOCK_INODE(other)->i_security;
+	isec = SOCK_INODE(sock)->i_security[selinux_idx];
+	other_isec = SOCK_INODE(other)->i_security[selinux_idx];
 
 	AVC_AUDIT_DATA_INIT(&ad,NET);
 	ad.u.net.sk = other->sk;
@@ -3265,7 +3111,7 @@
  		inode = SOCK_INODE(sock);
  		if (inode) {
  			struct inode_security_struct *isec;
- 			isec = inode->i_security;
+ 			isec = inode->i_security[selinux_idx];
  			sock_sid = isec->sid;
  			sock_class = isec->sclass;
  		}
@@ -3349,13 +3195,13 @@
 	struct sk_security_struct *ssec;
 	struct inode_security_struct *isec;
 
-	isec = SOCK_INODE(sock)->i_security;
+	isec = SOCK_INODE(sock)->i_security[selinux_idx];
 	if (isec->sclass != SECCLASS_UNIX_STREAM_SOCKET) {
 		err = -ENOPROTOOPT;
 		goto out;
 	}
 
-	ssec = sock->sk->sk_security;
+	ssec = sock->sk->sk_security[selinux_idx];
 	
 	err = security_sid_to_context(ssec->peer_sid, &scontext,
&scontext_len);
 	if (err)
@@ -3394,7 +3240,7 @@
 	u32 perm;
 	struct nlmsghdr *nlh;
 	struct socket *sock = sk->sk_socket;
-	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
+	struct inode_security_struct *isec =
SOCK_INODE(sock)->i_security[selinux_idx];
 	
 	if (skb->len < NLMSG_SPACE(0)) {
 		err = -EINVAL;
@@ -3451,7 +3297,7 @@
 	if (err)
 		goto out;
 
-	isec = inode->i_security;
+	isec = inode->i_security[selinux_idx];
 	
 	switch (isec->sclass) {
 	case SECCLASS_UDP_SOCKET:
@@ -3577,7 +3423,7 @@
 			      struct kern_ipc_perm *perm,
 			      u16 sclass)
 {
-	struct task_security_struct *tsec = task->security;
+	struct task_security_struct *tsec = task->security[selinux_idx];
 	struct ipc_security_struct *isec;
 
 	isec = kmalloc(sizeof(struct ipc_security_struct), GFP_KERNEL);
@@ -3593,18 +3439,18 @@
 	} else {
 		isec->sid = SECINITSID_UNLABELED;
 	}
-	perm->security = isec;
+	perm->security[selinux_idx] = isec;
 
 	return 0;
 }
 
 static void ipc_free_security(struct kern_ipc_perm *perm)
 {
-	struct ipc_security_struct *isec = perm->security;
+	struct ipc_security_struct *isec = perm->security[selinux_idx];
 	if (!isec || isec->magic != SELINUX_MAGIC)
 		return;
 
-	perm->security = NULL;
+	perm->security[selinux_idx] = NULL;
 	kfree(isec);
 }
 
@@ -3620,18 +3466,18 @@
 	msec->magic = SELINUX_MAGIC;
 	msec->msg = msg;
 	msec->sid = SECINITSID_UNLABELED;
-	msg->security = msec;
+	msg->security[selinux_idx] = msec;
 
 	return 0;
 }
 
 static void msg_msg_free_security(struct msg_msg *msg)
 {
-	struct msg_security_struct *msec = msg->security;
+	struct msg_security_struct *msec = msg->security[selinux_idx];
 	if (!msec || msec->magic != SELINUX_MAGIC)
 		return;
 
-	msg->security = NULL;
+	msg->security[selinux_idx] = NULL;
 	kfree(msec);
 }
 
@@ -3642,8 +3488,8 @@
 	struct ipc_security_struct *isec;
 	struct avc_audit_data ad;
 
-	tsec = current->security;
-	isec = ipc_perms->security;
+	tsec = current->security[selinux_idx];
+	isec = ipc_perms->security[selinux_idx];
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = ipc_perms->key;
@@ -3674,8 +3520,8 @@
 	if (rc)
 		return rc;
 
-	tsec = current->security;
-	isec = msq->q_perm.security;
+	tsec = current->security[selinux_idx];
+	isec = msq->q_perm.security[selinux_idx];
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = msq->q_perm.key;
@@ -3700,8 +3546,8 @@
 	struct ipc_security_struct *isec;
 	struct avc_audit_data ad;
 
-	tsec = current->security;
-	isec = msq->q_perm.security;
+	tsec = current->security[selinux_idx];
+	isec = msq->q_perm.security[selinux_idx];
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = msq->q_perm.key;
@@ -3746,9 +3592,9 @@
 	struct avc_audit_data ad;
 	int rc;
 
-	tsec = current->security;
-	isec = msq->q_perm.security;
-	msec = msg->security;
+	tsec = current->security[selinux_idx];
+	isec = msq->q_perm.security[selinux_idx];
+	msec = msg->security[selinux_idx];
 
 	/*
 	 * First time through, need to assign label to the message
@@ -3796,9 +3642,9 @@
 	struct avc_audit_data ad;
 	int rc;
 
-	tsec = target->security;
-	isec = msq->q_perm.security;
-	msec = msg->security;
+	tsec = target->security[selinux_idx];
+	isec = msq->q_perm.security[selinux_idx];
+	msec = msg->security[selinux_idx];
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = msq->q_perm.key;
@@ -3825,8 +3671,8 @@
 	if (rc)
 		return rc;
 
-	tsec = current->security;
-	isec = shp->shm_perm.security;
+	tsec = current->security[selinux_idx];
+	isec = shp->shm_perm.security[selinux_idx];
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = shp->shm_perm.key;
@@ -3851,8 +3697,8 @@
 	struct ipc_security_struct *isec;
 	struct avc_audit_data ad;
 
-	tsec = current->security;
-	isec = shp->shm_perm.security;
+	tsec = current->security[selinux_idx];
+	isec = shp->shm_perm.security[selinux_idx];
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = shp->shm_perm.key;
@@ -3898,11 +3744,6 @@
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
@@ -3924,8 +3765,8 @@
 	if (rc)
 		return rc;
 
-	tsec = current->security;
-	isec = sma->sem_perm.security;
+	tsec = current->security[selinux_idx];
+	isec = sma->sem_perm.security[selinux_idx];
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = sma->sem_perm.key;
@@ -3950,8 +3791,8 @@
 	struct ipc_security_struct *isec;
 	struct avc_audit_data ad;
 
-	tsec = current->security;
-	isec = sma->sem_perm.security;
+	tsec = current->security[selinux_idx];
+	isec = sma->sem_perm.security[selinux_idx];
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = sma->sem_perm.key;
@@ -4017,7 +3858,7 @@
 
 static int selinux_ipc_permission(struct kern_ipc_perm *ipcp, short
flag)
 {
-	struct ipc_security_struct *isec = ipcp->security;
+	struct ipc_security_struct *isec = ipcp->security[selinux_idx];
 	u16 sclass = SECCLASS_IPC;
 	u32 av = 0;
 
@@ -4036,37 +3877,6 @@
 	return ipc_has_perm(ipcp, sclass, av);
 }
 
-/* module stacking operations */
-int selinux_register_security (const char *name, struct
security_operations *ops)
-{
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
-}
-
-int selinux_unregister_security (const char *name, struct
security_operations *ops)
-{
-	if (ops != secondary_ops) {
-		printk (KERN_INFO "%s:  trying to unregister a security module "
-		        "that is not registered.\n", __FUNCTION__);
-		return -EINVAL;
-	}
-
-	secondary_ops = original_ops;
-
-	return 0;
-}
-
 static void selinux_d_instantiate (struct dentry *dentry, struct inode
*inode)
 {
 	if (inode)
@@ -4090,7 +3900,7 @@
 	if (!size)
 		return -ERANGE;
 
-	tsec = p->security;
+	tsec = p->security[selinux_idx];
 
 	if (!strcmp(name, "current"))
 		sid = tsec->sid;
@@ -4160,7 +3970,7 @@
 	   operation.  See selinux_bprm_set_security for the execve
 	   checks and may_create for the file creation checks. The
 	   operation will then fail if the context is not permitted. */
-	tsec = p->security;
+	tsec = p->security[selinux_idx];
 	if (!strcmp(name, "exec"))
 		tsec->exec_sid = sid;
 	else if (!strcmp(name, "fscreate"))
@@ -4175,7 +3985,6 @@
 	.ptrace =			selinux_ptrace,
 	.capget =			selinux_capget,
 	.capset_check =			selinux_capset_check,
-	.capset_set =			selinux_capset_set,
 	.sysctl =			selinux_sysctl,
 	.capable =			selinux_capable,
 	.quotactl =			selinux_quotactl,
@@ -4190,7 +3999,6 @@
 	.bprm_free_security =		selinux_bprm_free_security,
 	.bprm_apply_creds =		selinux_bprm_apply_creds,
 	.bprm_set_security =		selinux_bprm_set_security,
-	.bprm_check_security =		selinux_bprm_check_security,
 	.bprm_secureexec =		selinux_bprm_secureexec,
 
 	.sb_alloc_security =		selinux_sb_alloc_security,
@@ -4247,7 +4055,6 @@
 	.task_alloc_security =		selinux_task_alloc_security,
 	.task_free_security =		selinux_task_free_security,
 	.task_setuid =			selinux_task_setuid,
-	.task_post_setuid =		selinux_task_post_setuid,
 	.task_setgid =			selinux_task_setgid,
 	.task_setpgid =			selinux_task_setpgid,
 	.task_getpgid =			selinux_task_getpgid,
@@ -4287,9 +4094,6 @@
 	.sem_semctl =			selinux_sem_semctl,
 	.sem_semop =			selinux_sem_semop,
 
-	.register_security =		selinux_register_security,
-	.unregister_security =		selinux_unregister_security,
-
 	.d_instantiate =                selinux_d_instantiate,
 
 	.getprocattr =                  selinux_getprocattr,
@@ -4319,10 +4123,13 @@
 #endif
 };
 
+#define MY_NAME "selinux"
 __init int selinux_init(void)
 {
 	struct task_security_struct *tsec;
 
+	secondary = 0;
+
 	if (!selinux_enabled) {
 		printk(KERN_INFO "SELinux:  Disabled at boot.\n");
 		return 0;
@@ -4333,16 +4140,24 @@
 	/* Set the security state for the initial task. */
 	if (task_alloc_security(current))
 		panic("SELinux:  Failed to initialize initial task.\n");
-	tsec = current->security;
+	tsec = current->security[selinux_idx];
 	tsec->osid = tsec->sid = SECINITSID_KERNEL;
 
 	avc_init();
 
-	original_ops = secondary_ops = security_ops;
-	if (!secondary_ops)
-		panic ("SELinux: No initial security operations\n");
-	if (register_security (&selinux_ops))
-		panic("SELinux: Unable to register with kernel.\n");
+	selinux_idx = register_security (&selinux_ops);
+	if (selinux_idx) {
+		secondary = 1;
+		selinux_idx = mod_reg_security( MY_NAME, &selinux_ops);
+		if (selinux_idx < 0) {
+			printk(KERN_ERR "%s: mod_reg_security returned %d.\n",
+				__FUNCTION__, selinux_idx);
+			panic("SELinux: Unable to register with kernel.\n");
+		} else {
+			printk(KERN_ERR "%s: registered with id %d\n",
+				__FUNCTION__, selinux_idx);
+		}
+	}
 
 	if (selinux_enforcing) {
 		printk(KERN_INFO "SELinux:  Starting in enforcing mode\n");
@@ -4473,9 +4288,14 @@
 
 	selinux_disabled = 1;
 
-	/* Reset security_ops to the secondary module, dummy or capability. */
-	security_ops = secondary_ops;
-
+	/* Unregister selinux */
+	if (secondary) {
+		if (mod_unreg_security(MY_NAME, &selinux_ops))
+			printk(KERN_INFO "Failure unregistering selinux.\n");
+	} else {
+		if (unregister_security(&selinux_ops))
+			printk(KERN_INFO "Failure unregistering selinux.\n");
+	}
 	/* Unregister netfilter hooks. */
 	selinux_nf_ip_exit();
 
Index: linux-2.6.10-rc1-bk12-stack/security/selinux/selinuxfs.c
===================================================================
---
linux-2.6.10-rc1-bk12-stack.orig/security/selinux/selinuxfs.c	2004-11-02
19:56:04.454410920 -0600
+++ linux-2.6.10-rc1-bk12-stack/security/selinux/selinuxfs.c	2004-11-02
20:05:51.038236624 -0600
@@ -33,6 +33,8 @@
 
 static DECLARE_MUTEX(sel_sem);
 
+extern int selinux_idx;
+
 /* global data for booleans */
 static struct dentry *bool_dir = NULL;
 static int bool_num = 0;
@@ -46,7 +48,7 @@
 {
 	struct task_security_struct *tsec;
 
-	tsec = tsk->security;
+	tsec = tsk->security[selinux_idx];
 	if (!tsec)
 		return -EACCES;
 
@@ -856,7 +858,7 @@
 			ret = -ENAMETOOLONG;
 			goto err;
 		}
-		isec = (struct inode_security_struct*)inode->i_security;
+		isec = (struct inode_security_struct*)inode->i_security[selinux_idx];
 		if ((ret = security_genfs_sid("selinuxfs", page, SECCLASS_FILE,
&sid)))
 			goto err;
 		isec->sid = sid;
@@ -934,7 +936,7 @@
 	inode = sel_make_inode(sb, S_IFCHR | S_IRUGO | S_IWUGO);
 	if (!inode)
 		goto out;
-	isec = (struct inode_security_struct*)inode->i_security;
+	isec = (struct inode_security_struct*)inode->i_security[selinux_idx];
 	isec->sid = SECINITSID_DEVNULL;
 	isec->sclass = SECCLASS_CHR_FILE;
 	isec->initialized = 1;


