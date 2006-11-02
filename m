Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWKBRSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWKBRSZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWKBRSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:18:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:25750 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750716AbWKBRSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:18:24 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil> 
References: <1162402218.32614.230.camel@moss-spartans.epoch.ncsc.mil>  <1162387735.32614.184.camel@moss-spartans.epoch.ncsc.mil> <16969.1161771256@redhat.com> <31035.1162330008@redhat.com> <4417.1162395294@redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>, Karl MacMillan <kmacmill@redhat.com>,
       jmorris@namei.org, chrisw@sous-sol.org, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: Security issues with local filesystem caching 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 02 Nov 2006 17:16:41 +0000
Message-ID: <25037.1162487801@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Unless there is some benefit to setting a ->fssid and checking against
> it (e.g. safeguarding the module against unintentional internal access),
> I think the task flag approach is preferable.

Well, I think the use of ->fssid is simpler and faster from an implementation
standpoint (see the attached patch), and it can always be used for such as the
in-kernel nfsd later.

The way I've done it in this patch is to have ->fssid shadow ->sid as long as
they're the same.  But ->fssid can be set to something else and then later
reset, at which point it becomes the same as ->sid again.  A hook is provided
to perform both of these operations:

	security_set_fssid(overriding_SID);  //set
	...
	security_set_fssid(SECSID_NULL);  //reset

The rest of the patch is that more or less anywhere ->sid is used to represent
a process as an actor, this is replaced with ->fssid.  This part requires no
conditional jumps.  It becomes a bit tricky around execve() time, but I think
it's reasonable to ignore that as execve() is unlikely to happen in an
overridden context; or maybe the execve() related ops should be failed if
->sid != ->fssid.

Do you think this is reasonable?  Or do you definitely want me to use the
suppression flag approach instead?

The flag approach is a bit more work to implement and will slow most ops down
by virtue of including an extra check, though not all ops can be bypassed (for
instance the op that assigns a security label to an inode can't be bypassed).

There are a couple of things I'm not sure about with the ->fssid approach:

 (1) What will auditing do?  Is it possible to have an SID that isn't audited?

 (2) How do I come up with a security label for the module to use?

David

---
CacheFiles: Add an FS-access SID override in task_security_struct

From: David Howells <dhowells@redhat.com>

Add a SID override to task_security_struct that is equivalent to fsuid/fsgid in
task_struct.  This permits a task to make accesses to filesystem objects as if
it is the overriding SID, without changing its own SID that might be needed to
control ptrace, signals, /proc access, etc.

This is useful for CacheFiles in that it allows CacheFiles to access the cache
files and directories using the cache's security context rather than the
security context of the process on whose behalf it is working, and in the
context of which it is running.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/security.h          |   16 ++++
 security/dummy.c                  |    6 ++
 security/selinux/hooks.c          |  148 ++++++++++++++++++++++---------------
 security/selinux/include/objsec.h |    1 
 4 files changed, 109 insertions(+), 62 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index ff20ec4..48e9e43 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1166,6 +1166,11 @@ #ifdef CONFIG_SECURITY
  *	Set the current FS security ID.
  *	@secid contains the security ID to set.
  *
+ * @set_fssid:
+ *	Set or reset the access override security ID, returning the old
+ *	override security ID.
+ *	@secid contains the security ID to set or SECSID_NULL to reset.
+ *
  * This is the main security structure.
  */
 struct security_operations {
@@ -1351,6 +1356,7 @@ struct security_operations {
 	void (*release_secctx)(char *secdata, u32 seclen);
 	u32 (*get_fscreate_secid)(void);
 	u32 (*set_fscreate_secid)(u32 secid);
+	u32 (*set_fssid)(u32 secid);
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect) (struct socket * sock,
@@ -2161,6 +2167,11 @@ static inline u32 security_set_fscreate_
 	return security_ops->set_fscreate_secid(secid);
 }
 
+static inline u32 security_set_fssid(u32 secid)
+{
+	return security_ops->set_fssid(secid);
+}
+
 /* prototypes */
 extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
@@ -2851,6 +2862,11 @@ static inline u32 security_set_fscreate_
 	return 0;
 }
 
+static inline u32 security_set_fssid(u32 secid)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/dummy.c b/security/dummy.c
index 7784bc4..9fcadbb 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -942,6 +942,11 @@ static u32 dummy_set_fscreate_secid(u32 
 	return 0;
 }
 
+static u32 dummy_set_fssid(u32 secid)
+{
+	return 0;
+}
+
 #ifdef CONFIG_KEYS
 static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx,
 				  unsigned long flags)
@@ -1099,6 +1104,7 @@ void security_fixup_ops (struct security
  	set_to_dummy_if_null(ops, release_secctx);
  	set_to_dummy_if_null(ops, get_fscreate_secid);
  	set_to_dummy_if_null(ops, set_fscreate_secid);
+ 	set_to_dummy_if_null(ops, set_fssid);
 #ifdef CONFIG_SECURITY_NETWORK
 	set_to_dummy_if_null(ops, unix_stream_connect);
 	set_to_dummy_if_null(ops, unix_may_send);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b315559..c048a98 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -162,7 +162,8 @@ static int task_alloc_security(struct ta
 		return -ENOMEM;
 
 	tsec->task = task;
-	tsec->osid = tsec->sid = tsec->ptrace_sid = SECINITSID_UNLABELED;
+	tsec->osid = tsec->fssid = tsec->sid = tsec->ptrace_sid =
+		SECINITSID_UNLABELED;
 	task->security = tsec;
 
 	return 0;
@@ -190,7 +191,7 @@ static int inode_alloc_security(struct i
 	isec->inode = inode;
 	isec->sid = SECINITSID_UNLABELED;
 	isec->sclass = SECCLASS_FILE;
-	isec->task_sid = tsec->sid;
+	isec->task_sid = tsec->fssid;
 	inode->i_security = isec;
 
 	return 0;
@@ -220,8 +221,8 @@ static int file_alloc_security(struct fi
 		return -ENOMEM;
 
 	fsec->file = file;
-	fsec->sid = tsec->sid;
-	fsec->fown_sid = tsec->sid;
+	fsec->sid = tsec->fssid;
+	fsec->fown_sid = tsec->fssid;
 	file->f_security = fsec;
 
 	return 0;
@@ -338,12 +339,12 @@ static int may_context_mount_sb_relabel(
 {
 	int rc;
 
-	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+	rc = avc_has_perm(tsec->fssid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(tsec->sid, sid, SECCLASS_FILESYSTEM,
+	rc = avc_has_perm(tsec->fssid, sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELTO, NULL);
 	return rc;
 }
@@ -353,7 +354,7 @@ static int may_context_mount_inode_relab
 			struct task_security_struct *tsec)
 {
 	int rc;
-	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+	rc = avc_has_perm(tsec->fssid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
@@ -1030,7 +1031,7 @@ static int task_has_perm(struct task_str
 
 	tsec1 = tsk1->security;
 	tsec2 = tsk2->security;
-	return avc_has_perm(tsec1->sid, tsec2->sid,
+	return avc_has_perm(tsec1->fssid, tsec2->sid,
 			    SECCLASS_PROCESS, perms, NULL);
 }
 
@@ -1047,7 +1048,7 @@ static int task_has_capability(struct ta
 	ad.tsk = tsk;
 	ad.u.cap = cap;
 
-	return avc_has_perm(tsec->sid, tsec->sid,
+	return avc_has_perm(tsec->fssid, tsec->fssid,
 			    SECCLASS_CAPABILITY, CAP_TO_MASK(cap), &ad);
 }
 
@@ -1059,7 +1060,7 @@ static int task_has_system(struct task_s
 
 	tsec = tsk->security;
 
-	return avc_has_perm(tsec->sid, SECINITSID_KERNEL,
+	return avc_has_perm(tsec->fssid, SECINITSID_KERNEL,
 			    SECCLASS_SYSTEM, perms, NULL);
 }
 
@@ -1084,7 +1085,7 @@ static int inode_has_perm(struct task_st
 		ad.u.fs.inode = inode;
 	}
 
-	return avc_has_perm(tsec->sid, isec->sid, isec->sclass, perms, adp);
+	return avc_has_perm(tsec->fssid, isec->sid, isec->sclass, perms, adp);
 }
 
 /* Same as inode_has_perm, but pass explicit audit data containing
@@ -1127,8 +1128,8 @@ static int file_has_perm(struct task_str
 	ad.u.fs.mnt = mnt;
 	ad.u.fs.dentry = dentry;
 
-	if (tsec->sid != fsec->sid) {
-		rc = avc_has_perm(tsec->sid, fsec->sid,
+	if (tsec->fssid != fsec->sid) {
+		rc = avc_has_perm(tsec->fssid, fsec->sid,
 				  SECCLASS_FD,
 				  FD__USE,
 				  &ad);
@@ -1162,7 +1163,7 @@ static int may_create(struct inode *dir,
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.dentry = dentry;
 
-	rc = avc_has_perm(tsec->sid, dsec->sid, SECCLASS_DIR,
+	rc = avc_has_perm(tsec->fssid, dsec->sid, SECCLASS_DIR,
 			  DIR__ADD_NAME | DIR__SEARCH,
 			  &ad);
 	if (rc)
@@ -1171,13 +1172,13 @@ static int may_create(struct inode *dir,
 	if (tsec->create_sid && sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
 		newsid = tsec->create_sid;
 	} else {
-		rc = security_transition_sid(tsec->sid, dsec->sid, tclass,
+		rc = security_transition_sid(tsec->fssid, dsec->sid, tclass,
 					     &newsid);
 		if (rc)
 			return rc;
 	}
 
-	rc = avc_has_perm(tsec->sid, newsid, tclass, FILE__CREATE, &ad);
+	rc = avc_has_perm(tsec->fssid, newsid, tclass, FILE__CREATE, &ad);
 	if (rc)
 		return rc;
 
@@ -1194,7 +1195,8 @@ static int may_create_key(u32 ksid,
 
 	tsec = ctx->security;
 
-	return avc_has_perm(tsec->sid, ksid, SECCLASS_KEY, KEY__CREATE, NULL);
+	return avc_has_perm(tsec->fssid, ksid, SECCLASS_KEY, KEY__CREATE,
+			    NULL);
 }
 
 #define MAY_LINK   0
@@ -1222,7 +1224,7 @@ static int may_link(struct inode *dir,
 
 	av = DIR__SEARCH;
 	av |= (kind ? DIR__REMOVE_NAME : DIR__ADD_NAME);
-	rc = avc_has_perm(tsec->sid, dsec->sid, SECCLASS_DIR, av, &ad);
+	rc = avc_has_perm(tsec->fssid, dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 
@@ -1241,7 +1243,7 @@ static int may_link(struct inode *dir,
 		return 0;
 	}
 
-	rc = avc_has_perm(tsec->sid, isec->sid, isec->sclass, av, &ad);
+	rc = avc_has_perm(tsec->fssid, isec->sid, isec->sclass, av, &ad);
 	return rc;
 }
 
@@ -1266,16 +1268,16 @@ static inline int may_rename(struct inod
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 
 	ad.u.fs.dentry = old_dentry;
-	rc = avc_has_perm(tsec->sid, old_dsec->sid, SECCLASS_DIR,
+	rc = avc_has_perm(tsec->fssid, old_dsec->sid, SECCLASS_DIR,
 			  DIR__REMOVE_NAME | DIR__SEARCH, &ad);
 	if (rc)
 		return rc;
-	rc = avc_has_perm(tsec->sid, old_isec->sid,
+	rc = avc_has_perm(tsec->fssid, old_isec->sid,
 			  old_isec->sclass, FILE__RENAME, &ad);
 	if (rc)
 		return rc;
 	if (old_is_dir && new_dir != old_dir) {
-		rc = avc_has_perm(tsec->sid, old_isec->sid,
+		rc = avc_has_perm(tsec->fssid, old_isec->sid,
 				  old_isec->sclass, DIR__REPARENT, &ad);
 		if (rc)
 			return rc;
@@ -1285,13 +1287,13 @@ static inline int may_rename(struct inod
 	av = DIR__ADD_NAME | DIR__SEARCH;
 	if (new_dentry->d_inode)
 		av |= DIR__REMOVE_NAME;
-	rc = avc_has_perm(tsec->sid, new_dsec->sid, SECCLASS_DIR, av, &ad);
+	rc = avc_has_perm(tsec->fssid, new_dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 	if (new_dentry->d_inode) {
 		new_isec = new_dentry->d_inode->i_security;
 		new_is_dir = S_ISDIR(new_dentry->d_inode->i_mode);
-		rc = avc_has_perm(tsec->sid, new_isec->sid,
+		rc = avc_has_perm(tsec->fssid, new_isec->sid,
 				  new_isec->sclass,
 				  (new_is_dir ? DIR__RMDIR : FILE__UNLINK), &ad);
 		if (rc)
@@ -1312,7 +1314,7 @@ static int superblock_has_perm(struct ta
 
 	tsec = tsk->security;
 	sbsec = sb->s_security;
-	return avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+	return avc_has_perm(tsec->fssid, sbsec->sid, SECCLASS_FILESYSTEM,
 			    perms, ad);
 }
 
@@ -1376,7 +1378,7 @@ static int selinux_ptrace(struct task_st
 	rc = task_has_perm(parent, child, PROCESS__PTRACE);
 	/* Save the SID of the tracing process for later use in apply_creds. */
 	if (!(child->ptrace & PT_PTRACED) && !rc)
-		csec->ptrace_sid = psec->sid;
+		csec->ptrace_sid = psec->fssid;
 	return rc;
 }
 
@@ -1445,7 +1447,7 @@ static int selinux_sysctl(ctl_table *tab
 	/* The op values are "defined" in sysctl.c, thereby creating
 	 * a bad coupling between this module and sysctl.c */
 	if(op == 001) {
-		error = avc_has_perm(tsec->sid, tsid,
+		error = avc_has_perm(tsec->fssid, tsid,
 				     SECCLASS_DIR, DIR__SEARCH, NULL);
 	} else {
 		av = 0;
@@ -1454,7 +1456,7 @@ static int selinux_sysctl(ctl_table *tab
 		if (op & 002)
 			av |= FILE__WRITE;
 		if (av)
-			error = avc_has_perm(tsec->sid, tsid,
+			error = avc_has_perm(tsec->fssid, tsid,
 					     SECCLASS_FILE, av, NULL);
         }
 
@@ -1546,7 +1548,7 @@ static int selinux_vm_enough_memory(long
 
 	rc = secondary_ops->capable(current, CAP_SYS_ADMIN);
 	if (rc == 0)
-		rc = avc_has_perm_noaudit(tsec->sid, tsec->sid,
+		rc = avc_has_perm_noaudit(tsec->fssid, tsec->fssid,
 					SECCLASS_CAPABILITY,
 					CAP_TO_MASK(CAP_SYS_ADMIN),
 					NULL);
@@ -1598,7 +1600,7 @@ static int selinux_bprm_set_security(str
 	isec = inode->i_security;
 
 	/* Default to the current task SID. */
-	bsec->sid = tsec->sid;
+	bsec->sid = tsec->fssid;
 
 	/* Reset fs, key, and sock SIDs on execve. */
 	tsec->create_sid = 0;
@@ -1611,7 +1613,7 @@ static int selinux_bprm_set_security(str
 		tsec->exec_sid = 0;
 	} else {
 		/* Check for a default transition on this program. */
-		rc = security_transition_sid(tsec->sid, isec->sid,
+		rc = security_transition_sid(tsec->fssid, isec->sid,
 		                             SECCLASS_PROCESS, &newsid);
 		if (rc)
 			return rc;
@@ -1622,16 +1624,16 @@ static int selinux_bprm_set_security(str
 	ad.u.fs.dentry = bprm->file->f_dentry;
 
 	if (bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)
-		newsid = tsec->sid;
+		newsid = tsec->fssid;
 
-        if (tsec->sid == newsid) {
-		rc = avc_has_perm(tsec->sid, isec->sid,
+        if (tsec->fssid == newsid) {
+		rc = avc_has_perm(tsec->fssid, isec->sid,
 				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
 		if (rc)
 			return rc;
 	} else {
 		/* Check permissions for the transition. */
-		rc = avc_has_perm(tsec->sid, newsid,
+		rc = avc_has_perm(tsec->fssid, newsid,
 				  SECCLASS_PROCESS, PROCESS__TRANSITION, &ad);
 		if (rc)
 			return rc;
@@ -1810,6 +1812,8 @@ static void selinux_bprm_apply_creds(str
 				return;
 			}
 		}
+		if (tsec->fssid == tsec->sid)
+			tsec->fssid = sid;
 		tsec->sid = sid;
 	}
 }
@@ -2084,7 +2088,7 @@ static int selinux_inode_init_security(s
 	if (tsec->create_sid && sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
 		newsid = tsec->create_sid;
 	} else {
-		rc = security_transition_sid(tsec->sid, dsec->sid,
+		rc = security_transition_sid(tsec->fssid, dsec->sid,
 					     inode_mode_to_security_class(inode->i_mode),
 					     &newsid);
 		if (rc) {
@@ -2275,7 +2279,7 @@ static int selinux_inode_setxattr(struct
 	AVC_AUDIT_DATA_INIT(&ad,FS);
 	ad.u.fs.dentry = dentry;
 
-	rc = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
+	rc = avc_has_perm(tsec->fssid, isec->sid, isec->sclass,
 			  FILE__RELABELFROM, &ad);
 	if (rc)
 		return rc;
@@ -2284,12 +2288,12 @@ static int selinux_inode_setxattr(struct
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(tsec->sid, newsid, isec->sclass,
+	rc = avc_has_perm(tsec->fssid, newsid, isec->sclass,
 			  FILE__RELABELTO, &ad);
 	if (rc)
 		return rc;
 
-	rc = security_validate_transition(isec->sid, newsid, tsec->sid,
+	rc = security_validate_transition(isec->sid, newsid, tsec->fssid,
 	                                  isec->sclass);
 	if (rc)
 		return rc;
@@ -2693,7 +2697,7 @@ static int selinux_task_alloc_security(s
 	tsec2 = tsk->security;
 
 	tsec2->osid = tsec1->osid;
-	tsec2->sid = tsec1->sid;
+	tsec2->fssid = tsec2->sid = tsec1->sid;
 
 	/* Retain the exec, fs, key, and sock SIDs across fork */
 	tsec2->exec_sid = tsec1->exec_sid;
@@ -2837,7 +2841,7 @@ static int selinux_task_kill(struct task
 		perm = signal_to_av(sig);
 	tsec = p->security;
 	if (secid)
-		rc = avc_has_perm(secid, tsec->sid, SECCLASS_PROCESS, perm, NULL);
+		rc = avc_has_perm(secid, tsec->fssid, SECCLASS_PROCESS, perm, NULL);
 	else
 		rc = task_has_perm(current, p, perm);
 	return rc;
@@ -2872,6 +2876,8 @@ static void selinux_task_reparent_to_ini
 
 	tsec = p->security;
 	tsec->osid = tsec->sid;
+	if (tsec->fssid == tsec->sid)
+		tsec->fssid = SECINITSID_KERNEL;
 	tsec->sid = SECINITSID_KERNEL;
 	return;
 }
@@ -2882,7 +2888,7 @@ static void selinux_task_to_inode(struct
 	struct task_security_struct *tsec = p->security;
 	struct inode_security_struct *isec = inode->i_security;
 
-	isec->sid = tsec->sid;
+	isec->sid = tsec->fssid;
 	isec->initialized = 1;
 	return;
 }
@@ -3054,7 +3060,7 @@ static int socket_has_perm(struct task_s
 
 	AVC_AUDIT_DATA_INIT(&ad,NET);
 	ad.u.net.sk = sock->sk;
-	err = avc_has_perm(tsec->sid, isec->sid, isec->sclass, perms, &ad);
+	err = avc_has_perm(tsec->fssid, isec->sid, isec->sclass, perms, &ad);
 
 out:
 	return err;
@@ -3071,8 +3077,8 @@ static int selinux_socket_create(int fam
 		goto out;
 
 	tsec = current->security;
-	newsid = tsec->sockcreate_sid ? : tsec->sid;
-	err = avc_has_perm(tsec->sid, newsid,
+	newsid = tsec->sockcreate_sid ? : tsec->fssid;
+	err = avc_has_perm(tsec->fssid, newsid,
 			   socket_type_to_security_class(family, type,
 			   protocol), SOCKET__CREATE, NULL);
 
@@ -3092,7 +3098,7 @@ static int selinux_socket_post_create(st
 	isec = SOCK_INODE(sock)->i_security;
 
 	tsec = current->security;
-	newsid = tsec->sockcreate_sid ? : tsec->sid;
+	newsid = tsec->sockcreate_sid ? : tsec->fssid;
 	isec->sclass = socket_type_to_security_class(family, type, protocol);
 	isec->sid = kern ? SECINITSID_KERNEL : newsid;
 	isec->initialized = 1;
@@ -3904,7 +3910,7 @@ static int ipc_alloc_security(struct tas
 
 	isec->sclass = sclass;
 	isec->ipc_perm = perm;
-	isec->sid = tsec->sid;
+	isec->sid = tsec->fssid;
 	perm->security = isec;
 
 	return 0;
@@ -3953,7 +3959,7 @@ static int ipc_has_perm(struct kern_ipc_
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = ipc_perms->key;
 
-	return avc_has_perm(tsec->sid, isec->sid, isec->sclass, perms, &ad);
+	return avc_has_perm(tsec->fssid, isec->sid, isec->sclass, perms, &ad);
 }
 
 static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
@@ -3984,7 +3990,7 @@ static int selinux_msg_queue_alloc_secur
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = msq->q_perm.key;
 
-	rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_MSGQ,
+	rc = avc_has_perm(tsec->fssid, isec->sid, SECCLASS_MSGQ,
 			  MSGQ__CREATE, &ad);
 	if (rc) {
 		ipc_free_security(&msq->q_perm);
@@ -4010,7 +4016,7 @@ static int selinux_msg_queue_associate(s
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = msq->q_perm.key;
 
-	return avc_has_perm(tsec->sid, isec->sid, SECCLASS_MSGQ,
+	return avc_has_perm(tsec->fssid, isec->sid, SECCLASS_MSGQ,
 			    MSGQ__ASSOCIATE, &ad);
 }
 
@@ -4062,7 +4068,7 @@ static int selinux_msg_queue_msgsnd(stru
 		 * Compute new sid based on current process and
 		 * message queue this message will be stored in
 		 */
-		rc = security_transition_sid(tsec->sid,
+		rc = security_transition_sid(tsec->fssid,
 					     isec->sid,
 					     SECCLASS_MSG,
 					     &msec->sid);
@@ -4074,11 +4080,11 @@ static int selinux_msg_queue_msgsnd(stru
 	ad.u.ipc_id = msq->q_perm.key;
 
 	/* Can this process write to the queue? */
-	rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_MSGQ,
+	rc = avc_has_perm(tsec->fssid, isec->sid, SECCLASS_MSGQ,
 			  MSGQ__WRITE, &ad);
 	if (!rc)
 		/* Can this process send the message */
-		rc = avc_has_perm(tsec->sid, msec->sid,
+		rc = avc_has_perm(tsec->fssid, msec->sid,
 				  SECCLASS_MSG, MSG__SEND, &ad);
 	if (!rc)
 		/* Can the message be put in the queue? */
@@ -4105,10 +4111,10 @@ static int selinux_msg_queue_msgrcv(stru
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = msq->q_perm.key;
 
-	rc = avc_has_perm(tsec->sid, isec->sid,
+	rc = avc_has_perm(tsec->fssid, isec->sid,
 			  SECCLASS_MSGQ, MSGQ__READ, &ad);
 	if (!rc)
-		rc = avc_has_perm(tsec->sid, msec->sid,
+		rc = avc_has_perm(tsec->fssid, msec->sid,
 				  SECCLASS_MSG, MSG__RECEIVE, &ad);
 	return rc;
 }
@@ -4131,7 +4137,7 @@ static int selinux_shm_alloc_security(st
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = shp->shm_perm.key;
 
-	rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_SHM,
+	rc = avc_has_perm(tsec->fssid, isec->sid, SECCLASS_SHM,
 			  SHM__CREATE, &ad);
 	if (rc) {
 		ipc_free_security(&shp->shm_perm);
@@ -4157,7 +4163,7 @@ static int selinux_shm_associate(struct 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = shp->shm_perm.key;
 
-	return avc_has_perm(tsec->sid, isec->sid, SECCLASS_SHM,
+	return avc_has_perm(tsec->fssid, isec->sid, SECCLASS_SHM,
 			    SHM__ASSOCIATE, &ad);
 }
 
@@ -4230,7 +4236,7 @@ static int selinux_sem_alloc_security(st
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = sma->sem_perm.key;
 
-	rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_SEM,
+	rc = avc_has_perm(tsec->fssid, isec->sid, SECCLASS_SEM,
 			  SEM__CREATE, &ad);
 	if (rc) {
 		ipc_free_security(&sma->sem_perm);
@@ -4256,7 +4262,7 @@ static int selinux_sem_associate(struct 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = sma->sem_perm.key;
 
-	return avc_has_perm(tsec->sid, isec->sid, SECCLASS_SEM,
+	return avc_has_perm(tsec->fssid, isec->sid, SECCLASS_SEM,
 			    SEM__ASSOCIATE, &ad);
 }
 
@@ -4500,14 +4506,19 @@ static int selinux_setprocattr(struct ta
 			error = avc_has_perm_noaudit(tsec->ptrace_sid, sid,
 						     SECCLASS_PROCESS,
 						     PROCESS__PTRACE, &avd);
-			if (!error)
+			if (!error) {
+				if (tsec->fssid == tsec->sid)
+					tsec->fssid = sid;
 				tsec->sid = sid;
+			}
 			task_unlock(p);
 			avc_audit(tsec->ptrace_sid, sid, SECCLASS_PROCESS,
 				  PROCESS__PTRACE, &avd, error, NULL);
 			if (error)
 				return error;
 		} else {
+			if (tsec->fssid == tsec->sid)
+				tsec->fssid = sid;
 			tsec->sid = sid;
 			task_unlock(p);
 		}
@@ -4550,6 +4561,18 @@ static u32 selinux_set_fscreate_secid(u3
 	return oldsid;
 }
 
+static u32 selinux_set_fssid(u32 secid)
+{
+	struct task_security_struct *tsec = current->security;
+	u32 oldfssid = tsec->fssid;
+
+	if (secid == SECSID_NULL)
+		tsec->fssid = tsec->sid;
+	else
+		tsec->fssid = secid;
+	return oldfssid;
+}
+
 #ifdef CONFIG_KEYS
 
 static int selinux_key_alloc(struct key *k, struct task_struct *tsk,
@@ -4599,7 +4622,7 @@ static int selinux_key_permission(key_re
 	if (perm == 0)
 		return 0;
 
-	return avc_has_perm(tsec->sid, ksec->sid,
+	return avc_has_perm(tsec->fssid, ksec->sid,
 			    SECCLASS_KEY, perm, NULL);
 }
 
@@ -4735,6 +4758,7 @@ static struct security_operations selinu
 	.release_secctx =		selinux_release_secctx,
 	.get_fscreate_secid =		selinux_get_fscreate_secid,
 	.set_fscreate_secid =		selinux_set_fscreate_secid,
+	.set_fssid =			selinux_set_fssid,
 
         .unix_stream_connect =		selinux_socket_unix_stream_connect,
 	.unix_may_send =		selinux_socket_unix_may_send,
@@ -4800,7 +4824,7 @@ static __init int selinux_init(void)
 	if (task_alloc_security(current))
 		panic("SELinux:  Failed to initialize initial task.\n");
 	tsec = current->security;
-	tsec->osid = tsec->sid = SECINITSID_KERNEL;
+	tsec->osid = tsec->fssid = tsec->sid = SECINITSID_KERNEL;
 
 	sel_inode_cache = kmem_cache_create("selinux_inode_security",
 					    sizeof(struct inode_security_struct),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index ef2267f..e51eaf3 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -30,6 +30,7 @@ struct task_security_struct {
 	struct task_struct *task;      /* back pointer to task object */
 	u32 osid;            /* SID prior to last execve */
 	u32 sid;             /* current SID */
+	u32 fssid;           /* access override SID (normally == sid) */
 	u32 exec_sid;        /* exec SID */
 	u32 create_sid;      /* fscreate SID */
 	u32 keycreate_sid;   /* keycreate SID */

