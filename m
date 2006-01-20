Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWATSJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWATSJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 13:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWATSJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 13:09:56 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:3239 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751130AbWATSJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 13:09:55 -0500
Subject: [patch 1/1] selinux: remove security struct magic number fields
	and tests
From: Stephen Smalley <sds@tycho.nsa.gov>
To: lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Fri, 20 Jan 2006 13:15:57 -0500
Message-Id: <1137780957.3648.171.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the SELinux security structure magic number fields
and tests, along with some unnecessary tests for NULL security pointers.
These fields and tests are leftovers from the early attempts to support
SELinux as a loadable module during LSM development.  Please apply.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
Acked-by:  James Morris <jmorris@namei.org>

---

 security/selinux/hooks.c          |   49 +++-----------------------------------
 security/selinux/include/objsec.h |    8 ------
 2 files changed, 5 insertions(+), 52 deletions(-)

diff -X /home/sds/dontdiff -rup linux-2.6.16-rc1-mm2/security/selinux/hooks.c linux-2.6.16-rc1-mm2-x/security/selinux/hooks.c
--- linux-2.6.16-rc1-mm2/security/selinux/hooks.c	2006-01-20 10:44:38.000000000 -0500
+++ linux-2.6.16-rc1-mm2-x/security/selinux/hooks.c	2006-01-20 10:47:07.000000000 -0500
@@ -153,7 +153,6 @@ static int task_alloc_security(struct ta
 	if (!tsec)
 		return -ENOMEM;
 
-	tsec->magic = SELINUX_MAGIC;
 	tsec->task = task;
 	tsec->osid = tsec->sid = tsec->ptrace_sid = SECINITSID_UNLABELED;
 	task->security = tsec;
@@ -164,10 +163,6 @@ static int task_alloc_security(struct ta
 static void task_free_security(struct task_struct *task)
 {
 	struct task_security_struct *tsec = task->security;
-
-	if (!tsec || tsec->magic != SELINUX_MAGIC)
-		return;
-
 	task->security = NULL;
 	kfree(tsec);
 }
@@ -183,14 +178,10 @@ static int inode_alloc_security(struct i
 
 	init_MUTEX(&isec->sem);
 	INIT_LIST_HEAD(&isec->list);
-	isec->magic = SELINUX_MAGIC;
 	isec->inode = inode;
 	isec->sid = SECINITSID_UNLABELED;
 	isec->sclass = SECCLASS_FILE;
-	if (tsec && tsec->magic == SELINUX_MAGIC)
-		isec->task_sid = tsec->sid;
-	else
-		isec->task_sid = SECINITSID_UNLABELED;
+	isec->task_sid = tsec->sid;
 	inode->i_security = isec;
 
 	return 0;
@@ -201,9 +192,6 @@ static void inode_free_security(struct i
 	struct inode_security_struct *isec = inode->i_security;
 	struct superblock_security_struct *sbsec = inode->i_sb->s_security;
 
-	if (!isec || isec->magic != SELINUX_MAGIC)
-		return;
-
 	spin_lock(&sbsec->isec_lock);
 	if (!list_empty(&isec->list))
 		list_del_init(&isec->list);
@@ -222,15 +210,9 @@ static int file_alloc_security(struct fi
 	if (!fsec)
 		return -ENOMEM;
 
-	fsec->magic = SELINUX_MAGIC;
 	fsec->file = file;
-	if (tsec && tsec->magic == SELINUX_MAGIC) {
-		fsec->sid = tsec->sid;
-		fsec->fown_sid = tsec->sid;
-	} else {
-		fsec->sid = SECINITSID_UNLABELED;
-		fsec->fown_sid = SECINITSID_UNLABELED;
-	}
+	fsec->sid = tsec->sid;
+	fsec->fown_sid = tsec->sid;
 	file->f_security = fsec;
 
 	return 0;
@@ -239,10 +221,6 @@ static int file_alloc_security(struct fi
 static void file_free_security(struct file *file)
 {
 	struct file_security_struct *fsec = file->f_security;
-
-	if (!fsec || fsec->magic != SELINUX_MAGIC)
-		return;
-
 	file->f_security = NULL;
 	kfree(fsec);
 }
@@ -259,7 +237,6 @@ static int superblock_alloc_security(str
 	INIT_LIST_HEAD(&sbsec->list);
 	INIT_LIST_HEAD(&sbsec->isec_head);
 	spin_lock_init(&sbsec->isec_lock);
-	sbsec->magic = SELINUX_MAGIC;
 	sbsec->sb = sb;
 	sbsec->sid = SECINITSID_UNLABELED;
 	sbsec->def_sid = SECINITSID_FILE;
@@ -272,9 +249,6 @@ static void superblock_free_security(str
 {
 	struct superblock_security_struct *sbsec = sb->s_security;
 
-	if (!sbsec || sbsec->magic != SELINUX_MAGIC)
-		return;
-
 	spin_lock(&sb_security_lock);
 	if (!list_empty(&sbsec->list))
 		list_del_init(&sbsec->list);
@@ -296,7 +270,6 @@ static int sk_alloc_security(struct sock
 	if (!ssec)
 		return -ENOMEM;
 
-	ssec->magic = SELINUX_MAGIC;
 	ssec->sk = sk;
 	ssec->peer_sid = SECINITSID_UNLABELED;
 	sk->sk_security = ssec;
@@ -308,7 +281,7 @@ static void sk_free_security(struct sock
 {
 	struct sk_security_struct *ssec = sk->sk_security;
 
-	if (sk->sk_family != PF_UNIX || ssec->magic != SELINUX_MAGIC)
+	if (sk->sk_family != PF_UNIX)
 		return;
 
 	sk->sk_security = NULL;
@@ -1509,7 +1482,6 @@ static int selinux_bprm_alloc_security(s
 	if (!bsec)
 		return -ENOMEM;
 
-	bsec->magic = SELINUX_MAGIC;
 	bsec->bprm = bprm;
 	bsec->sid = SECINITSID_UNLABELED;
 	bsec->set = 0;
@@ -3632,14 +3604,9 @@ static int ipc_alloc_security(struct tas
 	if (!isec)
 		return -ENOMEM;
 
-	isec->magic = SELINUX_MAGIC;
 	isec->sclass = sclass;
 	isec->ipc_perm = perm;
-	if (tsec) {
-		isec->sid = tsec->sid;
-	} else {
-		isec->sid = SECINITSID_UNLABELED;
-	}
+	isec->sid = tsec->sid;
 	perm->security = isec;
 
 	return 0;
@@ -3648,9 +3615,6 @@ static int ipc_alloc_security(struct tas
 static void ipc_free_security(struct kern_ipc_perm *perm)
 {
 	struct ipc_security_struct *isec = perm->security;
-	if (!isec || isec->magic != SELINUX_MAGIC)
-		return;
-
 	perm->security = NULL;
 	kfree(isec);
 }
@@ -3663,7 +3627,6 @@ static int msg_msg_alloc_security(struct
 	if (!msec)
 		return -ENOMEM;
 
-	msec->magic = SELINUX_MAGIC;
 	msec->msg = msg;
 	msec->sid = SECINITSID_UNLABELED;
 	msg->security = msec;
@@ -3674,8 +3637,6 @@ static int msg_msg_alloc_security(struct
 static void msg_msg_free_security(struct msg_msg *msg)
 {
 	struct msg_security_struct *msec = msg->security;
-	if (!msec || msec->magic != SELINUX_MAGIC)
-		return;
 
 	msg->security = NULL;
 	kfree(msec);
diff -X /home/sds/dontdiff -rup linux-2.6.16-rc1-mm2/security/selinux/include/objsec.h linux-2.6.16-rc1-mm2-x/security/selinux/include/objsec.h
--- linux-2.6.16-rc1-mm2/security/selinux/include/objsec.h	2006-01-20 10:44:38.000000000 -0500
+++ linux-2.6.16-rc1-mm2-x/security/selinux/include/objsec.h	2006-01-20 10:47:07.000000000 -0500
@@ -27,7 +27,6 @@
 #include "avc.h"
 
 struct task_security_struct {
-        unsigned long magic;           /* magic number for this module */
 	struct task_struct *task;      /* back pointer to task object */
 	u32 osid;            /* SID prior to last execve */
 	u32 sid;             /* current SID */
@@ -37,7 +36,6 @@ struct task_security_struct {
 };
 
 struct inode_security_struct {
-	unsigned long magic;           /* magic number for this module */
         struct inode *inode;           /* back pointer to inode object */
 	struct list_head list;         /* list of inode_security_struct */
 	u32 task_sid;        /* SID of creating task */
@@ -49,14 +47,12 @@ struct inode_security_struct {
 };
 
 struct file_security_struct {
-	unsigned long magic;            /* magic number for this module */
 	struct file *file;              /* back pointer to file object */
 	u32 sid;              /* SID of open file description */
 	u32 fown_sid;         /* SID of file owner (for SIGIO) */
 };
 
 struct superblock_security_struct {
-	unsigned long magic;            /* magic number for this module */
 	struct super_block *sb;         /* back pointer to sb object */
 	struct list_head list;          /* list of superblock_security_struct */
 	u32 sid;              /* SID of file system */
@@ -70,20 +66,17 @@ struct superblock_security_struct {
 };
 
 struct msg_security_struct {
-        unsigned long magic;		/* magic number for this module */
 	struct msg_msg *msg;		/* back pointer */
 	u32 sid;              /* SID of message */
 };
 
 struct ipc_security_struct {
-        unsigned long magic;		/* magic number for this module */
 	struct kern_ipc_perm *ipc_perm; /* back pointer */
 	u16 sclass;	/* security class of this object */
 	u32 sid;              /* SID of IPC resource */
 };
 
 struct bprm_security_struct {
-	unsigned long magic;           /* magic number for this module */
 	struct linux_binprm *bprm;     /* back pointer to bprm object */
 	u32 sid;                       /* SID for transformed process */
 	unsigned char set;
@@ -102,7 +95,6 @@ struct netif_security_struct {
 };
 
 struct sk_security_struct {
-	unsigned long magic;		/* magic number for this module */
 	struct sock *sk;		/* back pointer to sk object */
 	u32 peer_sid;			/* SID of peer */
 };

-- 
Stephen Smalley
National Security Agency

