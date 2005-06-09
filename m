Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVFIA4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVFIA4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVFIA4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 20:56:23 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:41353 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262205AbVFHX5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 19:57:36 -0400
Date: Wed, 8 Jun 2005 19:02:09 -0500
From: serue@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>
Subject: [patch 8/11] lsm stacking: selinux: use security_*_value API
Message-ID: <20050609000209.GH27314@serge.austin.ibm.com>
References: <20050608235505.GA27298@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608235505.GA27298@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert SELinux to use the security_*_value_type API for storing and using
information appended to kernel objects, instead of directly using the void*.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 security/selinux/hooks.c     |  445 ++++++++++++++++++++++++++++---------------
 security/selinux/selinuxfs.c |   10 
 2 files changed, 299 insertions(+), 156 deletions(-)

Index: linux-2.6.12-rc6/security/selinux/hooks.c
===================================================================
--- linux-2.6.12-rc6.orig/security/selinux/hooks.c
+++ linux-2.6.12-rc6/security/selinux/hooks.c
@@ -26,6 +26,7 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/security.h>
+#include <linux/security-stack.h>
 #include <linux/xattr.h>
 #include <linux/capability.h>
 #include <linux/unistd.h>
@@ -126,30 +127,30 @@ static int task_alloc_security(struct ta
 		return -ENOMEM;
 
 	memset(tsec, 0, sizeof(struct task_security_struct));
-	tsec->magic = SELINUX_MAGIC;
 	tsec->task = task;
 	tsec->osid = tsec->sid = tsec->ptrace_sid = SECINITSID_UNLABELED;
-	task->security = tsec;
+	security_set_value_type(&task->security, SELINUX_LSM_ID, tsec);
 
 	return 0;
 }
 
 static void task_free_security(struct task_struct *task)
 {
-	struct task_security_struct *tsec = task->security;
-
-	if (!tsec || tsec->magic != SELINUX_MAGIC)
-		return;
+	struct task_security_struct *tsec;
+	
+	tsec = security_del_value_type(&task->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 
-	task->security = NULL;
 	kfree(tsec);
 }
 
 static int inode_alloc_security(struct inode *inode)
 {
-	struct task_security_struct *tsec = current->security;
+	struct task_security_struct *tsec;
 	struct inode_security_struct *isec;
 
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 	isec = kmalloc(sizeof(struct inode_security_struct), GFP_KERNEL);
 	if (!isec)
 		return -ENOMEM;
@@ -157,68 +158,71 @@ static int inode_alloc_security(struct i
 	memset(isec, 0, sizeof(struct inode_security_struct));
 	init_MUTEX(&isec->sem);
 	INIT_LIST_HEAD(&isec->list);
-	isec->magic = SELINUX_MAGIC;
 	isec->inode = inode;
 	isec->sid = SECINITSID_UNLABELED;
 	isec->sclass = SECCLASS_FILE;
-	if (tsec && tsec->magic == SELINUX_MAGIC)
+	if (tsec)
 		isec->task_sid = tsec->sid;
 	else
 		isec->task_sid = SECINITSID_UNLABELED;
-	inode->i_security = isec;
+	security_set_value_type(&inode->i_security, SELINUX_LSM_ID, isec);
 
 	return 0;
 }
 
 static void inode_free_security(struct inode *inode)
 {
-	struct inode_security_struct *isec = inode->i_security;
-	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
+	struct inode_security_struct *isec;
+	struct superblock_security_struct *sbsec;
 
-	if (!isec || isec->magic != SELINUX_MAGIC)
+	isec = security_del_value_type(&inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
+	if (!isec)
 		return;
 
+	sbsec = security_get_value_type(&inode->i_sb->s_security,
+		SELINUX_LSM_ID, struct superblock_security_struct);
+
 	spin_lock(&sbsec->isec_lock);
 	if (!list_empty(&isec->list))
 		list_del_init(&isec->list);
 	spin_unlock(&sbsec->isec_lock);
 
-	inode->i_security = NULL;
 	kfree(isec);
 }
 
 static int file_alloc_security(struct file *file)
 {
-	struct task_security_struct *tsec = current->security;
+	struct task_security_struct *tsec;
 	struct file_security_struct *fsec;
 
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 	fsec = kmalloc(sizeof(struct file_security_struct), GFP_ATOMIC);
 	if (!fsec)
 		return -ENOMEM;
 
 	memset(fsec, 0, sizeof(struct file_security_struct));
-	fsec->magic = SELINUX_MAGIC;
 	fsec->file = file;
-	if (tsec && tsec->magic == SELINUX_MAGIC) {
+	if (tsec) {
 		fsec->sid = tsec->sid;
 		fsec->fown_sid = tsec->sid;
 	} else {
 		fsec->sid = SECINITSID_UNLABELED;
 		fsec->fown_sid = SECINITSID_UNLABELED;
 	}
-	file->f_security = fsec;
+	security_set_value_type(&file->f_security, SELINUX_LSM_ID, fsec);
 
 	return 0;
 }
 
 static void file_free_security(struct file *file)
 {
-	struct file_security_struct *fsec = file->f_security;
+	struct file_security_struct *fsec;
 
-	if (!fsec || fsec->magic != SELINUX_MAGIC)
-		return;
+	fsec = security_del_value_type(&file->f_security, SELINUX_LSM_ID,
+		struct file_security_struct);
 
-	file->f_security = NULL;
 	kfree(fsec);
 }
 
@@ -235,20 +239,21 @@ static int superblock_alloc_security(str
 	INIT_LIST_HEAD(&sbsec->list);
 	INIT_LIST_HEAD(&sbsec->isec_head);
 	spin_lock_init(&sbsec->isec_lock);
-	sbsec->magic = SELINUX_MAGIC;
 	sbsec->sb = sb;
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
-	sb->s_security = sbsec;
+	security_set_value_type(&sb->s_security, SELINUX_LSM_ID, sbsec);
 
 	return 0;
 }
 
 static void superblock_free_security(struct super_block *sb)
 {
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec;
 
-	if (!sbsec || sbsec->magic != SELINUX_MAGIC)
+	sbsec = security_del_value_type(&sb->s_security, SELINUX_LSM_ID,
+		struct superblock_security_struct);
+	if (!sbsec)
 		return;
 
 	spin_lock(&sb_security_lock);
@@ -256,7 +261,6 @@ static void superblock_free_security(str
 		list_del_init(&sbsec->list);
 	spin_unlock(&sb_security_lock);
 
-	sb->s_security = NULL;
 	kfree(sbsec);
 }
 
@@ -273,22 +277,23 @@ static int sk_alloc_security(struct sock
 		return -ENOMEM;
 
 	memset(ssec, 0, sizeof(*ssec));
-	ssec->magic = SELINUX_MAGIC;
 	ssec->sk = sk;
 	ssec->peer_sid = SECINITSID_UNLABELED;
-	sk->sk_security = ssec;
+	security_set_value_type(&sk->sk_security, SELINUX_LSM_ID, ssec);
 
 	return 0;
 }
 
 static void sk_free_security(struct sock *sk)
 {
-	struct sk_security_struct *ssec = sk->sk_security;
+	struct sk_security_struct *ssec;
 
-	if (sk->sk_family != PF_UNIX || ssec->magic != SELINUX_MAGIC)
+	if (sk->sk_family != PF_UNIX)
 		return;
 
-	sk->sk_security = NULL;
+	ssec = security_del_value_type(&sk->sk_security, SELINUX_LSM_ID,
+		struct sk_security_struct);
+
 	kfree(ssec);
 }
 #endif	/* CONFIG_SECURITY_NETWORK */
@@ -335,8 +340,13 @@ static int try_context_mount(struct supe
 	const char *name;
 	u32 sid;
 	int alloc = 0, rc = 0, seen = 0;
-	struct task_security_struct *tsec = current->security;
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct task_security_struct *tsec;
+	struct superblock_security_struct *sbsec;
+
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	sbsec = security_get_value_type(&sb->s_security, SELINUX_LSM_ID,
+		struct superblock_security_struct);
 
 	if (!data)
 		goto out;
@@ -502,11 +512,14 @@ out:
 
 static int superblock_doinit(struct super_block *sb, void *data)
 {
-	struct superblock_security_struct *sbsec = sb->s_security;
+	struct superblock_security_struct *sbsec;
 	struct dentry *root = sb->s_root;
 	struct inode *inode = root->d_inode;
 	int rc = 0;
 
+	sbsec = security_get_value_type(&sb->s_security, SELINUX_LSM_ID,
+		struct superblock_security_struct);
+
 	down(&sbsec->sem);
 	if (sbsec->initialized)
 		goto out;
@@ -731,7 +744,7 @@ static int selinux_proc_get_sid(struct p
 static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry)
 {
 	struct superblock_security_struct *sbsec = NULL;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec;
 	u32 sid;
 	struct dentry *dentry;
 #define INITCONTEXTLEN 255
@@ -740,6 +753,9 @@ static int inode_doinit_with_dentry(stru
 	int rc = 0;
 	int hold_sem = 0;
 
+	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
+
 	if (isec->initialized)
 		goto out;
 
@@ -748,7 +764,8 @@ static int inode_doinit_with_dentry(stru
 	if (isec->initialized)
 		goto out;
 
-	sbsec = inode->i_sb->s_security;
+	sbsec = security_get_value_type(&inode->i_sb->s_security,
+		SELINUX_LSM_ID, struct superblock_security_struct);
 	if (!sbsec->initialized) {
 		/* Defer initialization until selinux_complete_init,
 		   after the initial policy is loaded and the security
@@ -922,8 +939,10 @@ static int task_has_perm(struct task_str
 {
 	struct task_security_struct *tsec1, *tsec2;
 
-	tsec1 = tsk1->security;
-	tsec2 = tsk2->security;
+	tsec1 = security_get_value_type(&tsk1->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	tsec2 = security_get_value_type(&tsk2->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 	return avc_has_perm(tsec1->sid, tsec2->sid,
 			    SECCLASS_PROCESS, perms, NULL);
 }
@@ -935,7 +954,8 @@ static int task_has_capability(struct ta
 	struct task_security_struct *tsec;
 	struct avc_audit_data ad;
 
-	tsec = tsk->security;
+	tsec = security_get_value_type(&tsk->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 
 	AVC_AUDIT_DATA_INIT(&ad,CAP);
 	ad.tsk = tsk;
@@ -951,7 +971,8 @@ static int task_has_system(struct task_s
 {
 	struct task_security_struct *tsec;
 
-	tsec = tsk->security;
+	tsec = security_get_value_type(&tsk->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 
 	return avc_has_perm(tsec->sid, SECINITSID_KERNEL,
 			    SECCLASS_SYSTEM, perms, NULL);
@@ -969,8 +990,10 @@ static int inode_has_perm(struct task_st
 	struct inode_security_struct *isec;
 	struct avc_audit_data ad;
 
-	tsec = tsk->security;
-	isec = inode->i_security;
+	tsec = security_get_value_type(&tsk->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
 
 	if (!adp) {
 		adp = &ad;
@@ -1009,14 +1032,19 @@ static inline int file_has_perm(struct t
 				struct file *file,
 				u32 av)
 {
-	struct task_security_struct *tsec = tsk->security;
-	struct file_security_struct *fsec = file->f_security;
+	struct task_security_struct *tsec;
+	struct file_security_struct *fsec;
 	struct vfsmount *mnt = file->f_vfsmnt;
 	struct dentry *dentry = file->f_dentry;
 	struct inode *inode = dentry->d_inode;
 	struct avc_audit_data ad;
 	int rc;
 
+	tsec = security_get_value_type(&tsk->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	fsec = security_get_value_type(&file->f_security, SELINUX_LSM_ID,
+		struct file_security_struct);
+
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.mnt = mnt;
 	ad.u.fs.dentry = dentry;
@@ -1049,9 +1077,12 @@ static int may_create(struct inode *dir,
 	struct avc_audit_data ad;
 	int rc;
 
-	tsec = current->security;
-	dsec = dir->i_security;
-	sbsec = dir->i_sb->s_security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	dsec = security_get_value_type(&dir->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
+	sbsec = security_get_value_type(&dir->i_sb->s_security, SELINUX_LSM_ID,
+		struct superblock_security_struct);
 
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.dentry = dentry;
@@ -1096,9 +1127,12 @@ static int may_link(struct inode *dir,
 	u32 av;
 	int rc;
 
-	tsec = current->security;
-	dsec = dir->i_security;
-	isec = dentry->d_inode->i_security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	dsec = security_get_value_type(&dir->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
+	isec = security_get_value_type(&dentry->d_inode->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct);
 
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.dentry = dentry;
@@ -1140,11 +1174,15 @@ static inline int may_rename(struct inod
 	int old_is_dir, new_is_dir;
 	int rc;
 
-	tsec = current->security;
-	old_dsec = old_dir->i_security;
-	old_isec = old_dentry->d_inode->i_security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	old_dsec = security_get_value_type(&old_dir->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
+	old_isec = security_get_value_type(&old_dentry->d_inode->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct);
 	old_is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
-	new_dsec = new_dir->i_security;
+	new_dsec = security_get_value_type(&new_dir->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
 
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 
@@ -1172,7 +1210,8 @@ static inline int may_rename(struct inod
 	if (rc)
 		return rc;
 	if (new_dentry->d_inode) {
-		new_isec = new_dentry->d_inode->i_security;
+		new_isec = security_get_value_type(&new_dentry->d_inode->i_security,
+			SELINUX_LSM_ID, struct inode_security_struct);
 		new_is_dir = S_ISDIR(new_dentry->d_inode->i_mode);
 		rc = avc_has_perm(tsec->sid, new_isec->sid,
 				  new_isec->sclass,
@@ -1193,8 +1232,10 @@ static int superblock_has_perm(struct ta
 	struct task_security_struct *tsec;
 	struct superblock_security_struct *sbsec;
 
-	tsec = tsk->security;
-	sbsec = sb->s_security;
+	tsec = security_get_value_type(&tsk->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	sbsec = security_get_value_type(&sb->s_security, SELINUX_LSM_ID,
+		struct superblock_security_struct);
 	return avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			    perms, ad);
 }
@@ -1247,8 +1288,13 @@ static inline u32 file_to_av(struct file
 /* Set an inode's SID to a specified value. */
 static int inode_security_set_sid(struct inode *inode, u32 sid)
 {
-	struct inode_security_struct *isec = inode->i_security;
-	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
+	struct inode_security_struct *isec;
+	struct superblock_security_struct *sbsec;
+
+	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
+	sbsec = security_get_value_type(&inode->i_sb->s_security,
+		SELINUX_LSM_ID, struct superblock_security_struct);
 
 	if (!sbsec->initialized) {
 		/* Defer initialization to selinux_complete_init. */
@@ -1277,9 +1323,12 @@ static int post_create(struct inode *dir
 	unsigned int len;
 	int rc;
 
-	tsec = current->security;
-	dsec = dir->i_security;
-	sbsec = dir->i_sb->s_security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	dsec = security_get_value_type(&dir->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
+	sbsec = security_get_value_type(&dir->i_sb->s_security, SELINUX_LSM_ID,
+		struct superblock_security_struct);
 
 	inode = dentry->d_inode;
 	if (!inode) {
@@ -1346,13 +1395,17 @@ static int post_create(struct inode *dir
 
 static int selinux_ptrace(struct task_struct *parent, struct task_struct *child)
 {
-	struct task_security_struct *psec = parent->security;
-	struct task_security_struct *csec = child->security;
+	struct task_security_struct *psec;
+	struct task_security_struct *csec;
 	int rc;
 
 	rc = secondary_ops->ptrace(parent,child);
 	if (rc)
 		return rc;
+	psec = security_get_value_type(&parent->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	csec = security_get_value_type(&child->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 
 	rc = task_has_perm(parent, child, PROCESS__PTRACE);
 	/* Save the SID of the tracing process for later use in apply_creds. */
@@ -1414,7 +1467,8 @@ static int selinux_sysctl(ctl_table *tab
 	if (rc)
 		return rc;
 
-	tsec = current->security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 
 	rc = selinux_proc_get_sid(table->de, (op == 001) ?
 	                          SECCLASS_DIR : SECCLASS_FILE, &tsid);
@@ -1549,12 +1603,11 @@ static int selinux_bprm_alloc_security(s
 		return -ENOMEM;
 
 	memset(bsec, 0, sizeof *bsec);
-	bsec->magic = SELINUX_MAGIC;
 	bsec->bprm = bprm;
 	bsec->sid = SECINITSID_UNLABELED;
 	bsec->set = 0;
 
-	bprm->security = bsec;
+	security_set_value_type(&bprm->security, SELINUX_LSM_ID, bsec);
 	return 0;
 }
 
@@ -1572,13 +1625,16 @@ static int selinux_bprm_set_security(str
 	if (rc)
 		return rc;
 
-	bsec = bprm->security;
+	bsec = security_get_value_type(&bprm->security, SELINUX_LSM_ID,
+		struct bprm_security_struct);
 
 	if (bsec->set)
 		return 0;
 
-	tsec = current->security;
-	isec = inode->i_security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
 
 	/* Default to the current task SID. */
 	bsec->sid = tsec->sid;
@@ -1641,9 +1697,11 @@ static int selinux_bprm_check_security (
 
 static int selinux_bprm_secureexec (struct linux_binprm *bprm)
 {
-	struct task_security_struct *tsec = current->security;
+	struct task_security_struct *tsec;
 	int atsecure = 0;
 
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 	if (tsec->osid != tsec->sid) {
 		/* Enable secure mode for SIDs transitions unless
 		   the noatsecure permission is granted between
@@ -1658,8 +1716,10 @@ static int selinux_bprm_secureexec (stru
 
 static void selinux_bprm_free_security(struct linux_binprm *bprm)
 {
-	struct bprm_security_struct *bsec = bprm->security;
-	bprm->security = NULL;
+	struct bprm_security_struct *bsec;
+	
+	bsec = security_del_value_type(&bprm->security, SELINUX_LSM_ID,
+			struct bprm_security_struct);
 	kfree(bsec);
 }
 
@@ -1757,9 +1817,10 @@ static void selinux_bprm_apply_creds(str
 
 	secondary_ops->bprm_apply_creds(bprm, unsafe);
 
-	tsec = current->security;
-
-	bsec = bprm->security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	bsec = security_get_value_type(&bprm->security, SELINUX_LSM_ID,
+		struct bprm_security_struct);
 	sid = bsec->sid;
 
 	tsec->osid = tsec->sid;
@@ -1802,8 +1863,10 @@ static void selinux_bprm_post_apply_cred
 	struct bprm_security_struct *bsec;
 	int rc, i;
 
-	tsec = current->security;
-	bsec = bprm->security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	bsec = security_get_value_type(&bprm->security, SELINUX_LSM_ID,
+		struct bprm_security_struct);
 
 	if (bsec->unsafe) {
 		force_sig_specific(SIGKILL, current);
@@ -2162,9 +2225,9 @@ static int selinux_inode_getattr(struct 
 
 static int selinux_inode_setxattr(struct dentry *dentry, char *name, void *value, size_t size, int flags)
 {
-	struct task_security_struct *tsec = current->security;
+	struct task_security_struct *tsec;
 	struct inode *inode = dentry->d_inode;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec;
 	struct superblock_security_struct *sbsec;
 	struct avc_audit_data ad;
 	u32 newsid;
@@ -2184,7 +2247,8 @@ static int selinux_inode_setxattr(struct
 		return dentry_has_perm(current, NULL, dentry, FILE__SETATTR);
 	}
 
-	sbsec = inode->i_sb->s_security;
+	sbsec = security_get_value_type(&inode->i_sb->s_security,
+		SELINUX_LSM_ID, struct superblock_security_struct);
 	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
 		return -EOPNOTSUPP;
 
@@ -2194,6 +2258,10 @@ static int selinux_inode_setxattr(struct
 	AVC_AUDIT_DATA_INIT(&ad,FS);
 	ad.u.fs.dentry = dentry;
 
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
 	rc = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
 			  FILE__RELABELFROM, &ad);
 	if (rc)
@@ -2224,10 +2292,13 @@ static void selinux_inode_post_setxattr(
                                         void *value, size_t size, int flags)
 {
 	struct inode *inode = dentry->d_inode;
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec;
 	u32 newsid;
 	int rc;
 
+	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
+
 	if (strcmp(name, XATTR_NAME_SELINUX)) {
 		/* Not an attribute we recognize, so nothing to do. */
 		return;
@@ -2247,7 +2318,10 @@ static void selinux_inode_post_setxattr(
 static int selinux_inode_getxattr (struct dentry *dentry, char *name)
 {
 	struct inode *inode = dentry->d_inode;
-	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
+	struct superblock_security_struct *sbsec;
+	
+	sbsec = security_get_value_type(&inode->i_sb->s_security,
+		SELINUX_LSM_ID, struct superblock_security_struct);
 
 	if (sbsec->behavior == SECURITY_FS_USE_MNTPOINT)
 		return -EOPNOTSUPP;
@@ -2284,7 +2358,7 @@ static int selinux_inode_removexattr (st
 
 static int selinux_inode_getsecurity(struct inode *inode, const char *name, void *buffer, size_t size)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec;
 	char *context;
 	unsigned len;
 	int rc;
@@ -2294,6 +2368,9 @@ static int selinux_inode_getsecurity(str
 	if (strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
 
+	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
+
 	rc = security_sid_to_context(isec->sid, &context, &len);
 	if (rc)
 		return rc;
@@ -2314,13 +2391,16 @@ static int selinux_inode_getsecurity(str
 static int selinux_inode_setsecurity(struct inode *inode, const char *name,
                                      const void *value, size_t size, int flags)
 {
-	struct inode_security_struct *isec = inode->i_security;
+	struct inode_security_struct *isec;
 	u32 newsid;
 	int rc;
 
 	if (strcmp(name, XATTR_SELINUX_SUFFIX))
 		return -EOPNOTSUPP;
 
+	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
+
 	if (!value || !size)
 		return -EACCES;
 
@@ -2546,8 +2626,10 @@ static int selinux_file_set_fowner(struc
 	struct task_security_struct *tsec;
 	struct file_security_struct *fsec;
 
-	tsec = current->security;
-	fsec = file->f_security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	fsec = security_get_value_type(&file->f_security, SELINUX_LSM_ID,
+		struct file_security_struct);
 	fsec->fown_sid = tsec->sid;
 
 	return 0;
@@ -2564,8 +2646,10 @@ static int selinux_file_send_sigiotask(s
 	/* struct fown_struct is never outside the context of a struct file */
         file = (struct file *)((long)fown - offsetof(struct file,f_owner));
 
-	tsec = tsk->security;
-	fsec = file->f_security;
+	tsec = security_get_value_type(&tsk->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	fsec = security_get_value_type(&file->f_security, SELINUX_LSM_ID,
+		struct file_security_struct);
 
 	if (!signum)
 		perm = signal_to_av(SIGIO); /* as per send_sigio_to_task */
@@ -2599,12 +2683,14 @@ static int selinux_task_alloc_security(s
 	struct task_security_struct *tsec1, *tsec2;
 	int rc;
 
-	tsec1 = current->security;
+	tsec1 = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 
 	rc = task_alloc_security(tsk);
 	if (rc)
 		return rc;
-	tsec2 = tsk->security;
+	tsec2 = security_get_value_type(&tsk->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 
 	tsec2->osid = tsec1->osid;
 	tsec2->sid = tsec1->sid;
@@ -2757,7 +2843,8 @@ static void selinux_task_reparent_to_ini
 
 	secondary_ops->task_reparent_to_init(p);
 
-	tsec = p->security;
+	tsec = security_get_value_type(&p->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 	tsec->osid = tsec->sid;
 	tsec->sid = SECINITSID_KERNEL;
 	return;
@@ -2766,8 +2853,13 @@ static void selinux_task_reparent_to_ini
 static void selinux_task_to_inode(struct task_struct *p,
 				  struct inode *inode)
 {
-	struct task_security_struct *tsec = p->security;
-	struct inode_security_struct *isec = inode->i_security;
+	struct task_security_struct *tsec;
+	struct inode_security_struct *isec;
+
+	tsec = security_get_value_type(&p->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
 
 	isec->sid = tsec->sid;
 	isec->initialized = 1;
@@ -2935,8 +3027,10 @@ static int socket_has_perm(struct task_s
 	struct avc_audit_data ad;
 	int err = 0;
 
-	tsec = task->security;
-	isec = SOCK_INODE(sock)->i_security;
+	tsec = security_get_value_type(&task->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	isec = security_get_value_type(&SOCK_INODE(sock)->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
 
 	if (isec->sid == SECINITSID_KERNEL)
 		goto out;
@@ -2958,7 +3052,8 @@ static int selinux_socket_create(int fam
 	if (kern)
 		goto out;
 
-	tsec = current->security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 	err = avc_has_perm(tsec->sid, tsec->sid,
 			   socket_type_to_security_class(family, type,
 			   protocol), SOCKET__CREATE, NULL);
@@ -2973,9 +3068,11 @@ static void selinux_socket_post_create(s
 	struct inode_security_struct *isec;
 	struct task_security_struct *tsec;
 
-	isec = SOCK_INODE(sock)->i_security;
+	isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct);
 
-	tsec = current->security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 	isec->sclass = socket_type_to_security_class(family, type, protocol);
 	isec->sid = kern ? SECINITSID_KERNEL : tsec->sid;
 	isec->initialized = 1;
@@ -3013,8 +3110,10 @@ static int selinux_socket_bind(struct so
 		struct sock *sk = sock->sk;
 		u32 sid, node_perm, addrlen;
 
-		tsec = current->security;
-		isec = SOCK_INODE(sock)->i_security;
+		tsec = security_get_value_type(&current->security,
+			SELINUX_LSM_ID, struct task_security_struct);
+		isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
+			SELINUX_LSM_ID, struct inode_security_struct);
 
 		if (family == PF_INET) {
 			addr4 = (struct sockaddr_in *)address;
@@ -3092,7 +3191,8 @@ static int selinux_socket_connect(struct
 	/*
 	 * If a TCP socket, check name_connect permission for the port.
 	 */
-	isec = SOCK_INODE(sock)->i_security;
+	isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct);
 	if (isec->sclass == SECCLASS_TCP_SOCKET) {
 		struct sock *sk = sock->sk;
 		struct avc_audit_data ad;
@@ -3146,9 +3246,11 @@ static int selinux_socket_accept(struct 
 	if (err)
 		return err;
 
-	newisec = SOCK_INODE(newsock)->i_security;
+	newisec = security_get_value_type(&SOCK_INODE(newsock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct);
 
-	isec = SOCK_INODE(sock)->i_security;
+	isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct);
 	newisec->sclass = isec->sclass;
 	newisec->sid = isec->sid;
 	newisec->initialized = 1;
@@ -3208,8 +3310,10 @@ static int selinux_socket_unix_stream_co
 	if (err)
 		return err;
 
-	isec = SOCK_INODE(sock)->i_security;
-	other_isec = SOCK_INODE(other)->i_security;
+	isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct);
+	other_isec = security_get_value_type(&SOCK_INODE(other)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct);
 
 	AVC_AUDIT_DATA_INIT(&ad,NET);
 	ad.u.net.sk = other->sk;
@@ -3221,11 +3325,13 @@ static int selinux_socket_unix_stream_co
 		return err;
 
 	/* connecting socket */
-	ssec = sock->sk->sk_security;
+	ssec = security_get_value_type(&sock->sk->sk_security, SELINUX_LSM_ID,
+		struct sk_security_struct);
 	ssec->peer_sid = other_isec->sid;
 	
 	/* server child socket */
-	ssec = newsk->sk_security;
+	ssec = security_get_value_type(&newsk->sk_security, SELINUX_LSM_ID,
+		struct sk_security_struct);
 	ssec->peer_sid = isec->sid;
 	
 	return 0;
@@ -3239,8 +3345,10 @@ static int selinux_socket_unix_may_send(
 	struct avc_audit_data ad;
 	int err;
 
-	isec = SOCK_INODE(sock)->i_security;
-	other_isec = SOCK_INODE(other)->i_security;
+	isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct);
+	other_isec = security_get_value_type(&SOCK_INODE(other)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct);
 
 	AVC_AUDIT_DATA_INIT(&ad,NET);
 	ad.u.net.sk = other->sk;
@@ -3280,7 +3388,8 @@ static int selinux_socket_sock_rcv_skb(s
  		inode = SOCK_INODE(sock);
  		if (inode) {
  			struct inode_security_struct *isec;
- 			isec = inode->i_security;
+			isec = security_get_value_type(&inode->i_security,
+				SELINUX_LSM_ID, struct inode_security_struct);
  			sock_sid = isec->sid;
  			sock_class = isec->sclass;
  		}
@@ -3363,13 +3472,15 @@ static int selinux_socket_getpeersec(str
 	struct sk_security_struct *ssec;
 	struct inode_security_struct *isec;
 
-	isec = SOCK_INODE(sock)->i_security;
+	isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct);
 	if (isec->sclass != SECCLASS_UNIX_STREAM_SOCKET) {
 		err = -ENOPROTOOPT;
 		goto out;
 	}
 
-	ssec = sock->sk->sk_security;
+	ssec = security_get_value_type(&sock->sk->sk_security, SELINUX_LSM_ID,
+		struct sk_security_struct);
 	
 	err = security_sid_to_context(ssec->peer_sid, &scontext, &scontext_len);
 	if (err)
@@ -3408,7 +3519,10 @@ static int selinux_nlmsg_perm(struct soc
 	u32 perm;
 	struct nlmsghdr *nlh;
 	struct socket *sock = sk->sk_socket;
-	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
+	struct inode_security_struct *isec;
+	
+	isec = security_get_value_type(&SOCK_INODE(sock)->i_security,
+		SELINUX_LSM_ID, struct inode_security_struct);
 	
 	if (skb->len < NLMSG_SPACE(0)) {
 		err = -EINVAL;
@@ -3474,7 +3588,8 @@ static unsigned int selinux_ip_postroute
 	if (err)
 		goto out;
 
-	isec = inode->i_security;
+	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
+		struct inode_security_struct);
 	
 	switch (isec->sclass) {
 	case SECCLASS_UDP_SOCKET:
@@ -3584,7 +3699,8 @@ static int selinux_netlink_send(struct s
 	if (err)
 		return err;
 
-	tsec = current->security;
+	tsec = security_get_value_type(&current->security,
+		SELINUX_LSM_ID, struct task_security_struct);
 
 	avd.allowed = 0;
 	avc_has_perm_noaudit(tsec->sid, tsec->sid,
@@ -3608,15 +3724,17 @@ static int ipc_alloc_security(struct tas
 			      struct kern_ipc_perm *perm,
 			      u16 sclass)
 {
-	struct task_security_struct *tsec = task->security;
+	struct task_security_struct *tsec;
 	struct ipc_security_struct *isec;
 
+	tsec = security_get_value_type(&task->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+
 	isec = kmalloc(sizeof(struct ipc_security_struct), GFP_KERNEL);
 	if (!isec)
 		return -ENOMEM;
 
 	memset(isec, 0, sizeof(struct ipc_security_struct));
-	isec->magic = SELINUX_MAGIC;
 	isec->sclass = sclass;
 	isec->ipc_perm = perm;
 	if (tsec) {
@@ -3624,18 +3742,18 @@ static int ipc_alloc_security(struct tas
 	} else {
 		isec->sid = SECINITSID_UNLABELED;
 	}
-	perm->security = isec;
+	security_set_value_type(&perm->security, SELINUX_LSM_ID, isec);
 
 	return 0;
 }
 
 static void ipc_free_security(struct kern_ipc_perm *perm)
 {
-	struct ipc_security_struct *isec = perm->security;
-	if (!isec || isec->magic != SELINUX_MAGIC)
-		return;
+	struct ipc_security_struct *isec;
+	
+	isec = security_del_value_type(&perm->security, SELINUX_LSM_ID,
+		struct ipc_security_struct);
 
-	perm->security = NULL;
 	kfree(isec);
 }
 
@@ -3648,21 +3766,20 @@ static int msg_msg_alloc_security(struct
 		return -ENOMEM;
 
 	memset(msec, 0, sizeof(struct msg_security_struct));
-	msec->magic = SELINUX_MAGIC;
 	msec->msg = msg;
 	msec->sid = SECINITSID_UNLABELED;
-	msg->security = msec;
+	security_set_value_type(&msg->security, SELINUX_LSM_ID, msec);
 
 	return 0;
 }
 
 static void msg_msg_free_security(struct msg_msg *msg)
 {
-	struct msg_security_struct *msec = msg->security;
-	if (!msec || msec->magic != SELINUX_MAGIC)
-		return;
+	struct msg_security_struct *msec;
+	
+	msec = security_del_value_type(&msg->security, SELINUX_LSM_ID,
+		struct msg_security_struct);
 
-	msg->security = NULL;
 	kfree(msec);
 }
 
@@ -3673,8 +3790,10 @@ static int ipc_has_perm(struct kern_ipc_
 	struct ipc_security_struct *isec;
 	struct avc_audit_data ad;
 
-	tsec = current->security;
-	isec = ipc_perms->security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	isec = security_get_value_type(&ipc_perms->security, SELINUX_LSM_ID,
+		struct ipc_security_struct);
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = ipc_perms->key;
@@ -3704,8 +3823,10 @@ static int selinux_msg_queue_alloc_secur
 	if (rc)
 		return rc;
 
-	tsec = current->security;
-	isec = msq->q_perm.security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	isec = security_get_value_type(&msq->q_perm.security, SELINUX_LSM_ID,
+		struct ipc_security_struct);
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = msq->q_perm.key;
@@ -3730,8 +3851,10 @@ static int selinux_msg_queue_associate(s
 	struct ipc_security_struct *isec;
 	struct avc_audit_data ad;
 
-	tsec = current->security;
-	isec = msq->q_perm.security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	isec = security_get_value_type(&msq->q_perm.security, SELINUX_LSM_ID,
+		struct ipc_security_struct);
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = msq->q_perm.key;
@@ -3776,9 +3899,12 @@ static int selinux_msg_queue_msgsnd(stru
 	struct avc_audit_data ad;
 	int rc;
 
-	tsec = current->security;
-	isec = msq->q_perm.security;
-	msec = msg->security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	isec = security_get_value_type(&msq->q_perm.security, SELINUX_LSM_ID,
+		struct ipc_security_struct);
+	msec = security_get_value_type(&msg->security, SELINUX_LSM_ID,
+		struct msg_security_struct);
 
 	/*
 	 * First time through, need to assign label to the message
@@ -3824,9 +3950,12 @@ static int selinux_msg_queue_msgrcv(stru
 	struct avc_audit_data ad;
 	int rc;
 
-	tsec = target->security;
-	isec = msq->q_perm.security;
-	msec = msg->security;
+	tsec = security_get_value_type(&target->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	isec = security_get_value_type(&msq->q_perm.security, SELINUX_LSM_ID,
+		struct ipc_security_struct);
+	msec = security_get_value_type(&msg->security, SELINUX_LSM_ID,
+		struct msg_security_struct);
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = msq->q_perm.key;
@@ -3851,8 +3980,10 @@ static int selinux_shm_alloc_security(st
 	if (rc)
 		return rc;
 
-	tsec = current->security;
-	isec = shp->shm_perm.security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	isec = security_get_value_type(&shp->shm_perm.security, SELINUX_LSM_ID,
+		struct ipc_security_struct);
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = shp->shm_perm.key;
@@ -3877,8 +4008,10 @@ static int selinux_shm_associate(struct 
 	struct ipc_security_struct *isec;
 	struct avc_audit_data ad;
 
-	tsec = current->security;
-	isec = shp->shm_perm.security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	isec = security_get_value_type(&shp->shm_perm.security, SELINUX_LSM_ID,
+		struct ipc_security_struct);
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = shp->shm_perm.key;
@@ -3950,8 +4083,10 @@ static int selinux_sem_alloc_security(st
 	if (rc)
 		return rc;
 
-	tsec = current->security;
-	isec = sma->sem_perm.security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	isec = security_get_value_type(&sma->sem_perm.security, SELINUX_LSM_ID,
+		struct ipc_security_struct);
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = sma->sem_perm.key;
@@ -3976,8 +4111,10 @@ static int selinux_sem_associate(struct 
 	struct ipc_security_struct *isec;
 	struct avc_audit_data ad;
 
-	tsec = current->security;
-	isec = sma->sem_perm.security;
+	tsec = security_get_value_type(&current->security, SELINUX_LSM_ID,
+		struct task_security_struct);
+	isec = security_get_value_type(&sma->sem_perm.security, SELINUX_LSM_ID,
+		struct ipc_security_struct);
 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = sma->sem_perm.key;
@@ -4111,7 +4248,8 @@ static int selinux_getprocattr(struct ta
 	if (!size)
 		return -ERANGE;
 
-	tsec = p->security;
+	tsec = security_get_value_type(&p->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 
 	if (!strcmp(name, "current"))
 		sid = tsec->sid;
@@ -4186,7 +4324,8 @@ static int selinux_setprocattr(struct ta
 	   operation.  See selinux_bprm_set_security for the execve
 	   checks and may_create for the file creation checks. The
 	   operation will then fail if the context is not permitted. */
-	tsec = p->security;
+	tsec = security_get_value_type(&p->security, SELINUX_LSM_ID,
+		struct task_security_struct);
 	if (!strcmp(name, "exec"))
 		tsec->exec_sid = sid;
 	else if (!strcmp(name, "fscreate"))
Index: linux-2.6.12-rc6/security/selinux/selinuxfs.c
===================================================================
--- linux-2.6.12-rc6.orig/security/selinux/selinuxfs.c
+++ linux-2.6.12-rc6/security/selinux/selinuxfs.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/security.h>
+#include <linux/security-stack.h>
 #include <linux/major.h>
 #include <linux/seq_file.h>
 #include <linux/percpu.h>
@@ -59,7 +60,8 @@ static int task_has_security(struct task
 {
 	struct task_security_struct *tsec;
 
-	tsec = tsk->security;
+	tsec = security_get_value_type(&tsk->security, SELINUX_LSM_ID,
+			struct task_security_struct);
 	if (!tsec)
 		return -EACCES;
 
@@ -983,7 +985,8 @@ static int sel_make_bools(void)
 			ret = -ENAMETOOLONG;
 			goto err;
 		}
-		isec = (struct inode_security_struct*)inode->i_security;
+		isec = security_get_value_type(&inode->i_security,
+				SELINUX_LSM_ID, struct inode_security_struct);
 		if ((ret = security_genfs_sid("selinuxfs", page, SECCLASS_FILE, &sid)))
 			goto err;
 		isec->sid = sid;
@@ -1270,7 +1273,8 @@ static int sel_fill_super(struct super_b
 	inode = sel_make_inode(sb, S_IFCHR | S_IRUGO | S_IWUGO);
 	if (!inode)
 		goto out;
-	isec = (struct inode_security_struct*)inode->i_security;
+	isec = security_get_value_type(&inode->i_security, SELINUX_LSM_ID,
+			struct inode_security_struct);
 	isec->sid = SECINITSID_DEVNULL;
 	isec->sclass = SECCLASS_CHR_FILE;
 	isec->initialized = 1;
