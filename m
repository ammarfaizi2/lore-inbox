Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966315AbWKNUOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966315AbWKNUOG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966326AbWKNUOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:14:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5290 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966319AbWKNUJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:09:26 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 13/19] CacheFiles: Add an act-as SID override in task_security_struct
Date: Tue, 14 Nov 2006 20:06:49 +0000
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Message-Id: <20061114200649.12943.61020.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an act-as SID to task_security_struct that is equivalent to fsuid/fsgid in
task_struct.  This permits a task to perform operations as if it is the
overriding SID, without changing its own SID as that might be needed to control
access to the process by ptrace, signals, /proc, etc.

This is useful for CacheFiles in that it allows CacheFiles to access the cache
files and directories using the cache's security context rather than the
security context of the process on whose behalf it is working, and in the
context of which it is running.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/security.h          |   32 +++++++
 security/dummy.c                  |   12 +++
 security/selinux/exports.c        |    2 
 security/selinux/hooks.c          |  160 +++++++++++++++++++++++--------------
 security/selinux/include/objsec.h |    1 
 security/selinux/selinuxfs.c      |    2 
 security/selinux/xfrm.c           |    6 +
 7 files changed, 148 insertions(+), 67 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 7955017..63617e4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1161,6 +1161,16 @@ #ifdef CONFIG_SECURITY
  *	Set the current FS security ID.
  *	@secid contains the security ID to set.
  *
+ * @act_as_secid:
+ *	Set the security ID as which to act, returning the security ID as which
+ *      the process was previously acting.
+ *	@secid contains the security ID to act as.
+ *
+ * @act_as_self:
+ *	Reset the security ID as which to act to be the same as the process's
+ *      owning security ID, and return the security ID as which the process was
+ *      previously acting.
+ *
  * This is the main security structure.
  */
 struct security_operations {
@@ -1345,6 +1355,8 @@ struct security_operations {
 	void (*release_secctx)(char *secdata, u32 seclen);
 	u32 (*get_fscreate_secid)(void);
 	u32 (*set_fscreate_secid)(u32 secid);
+	u32 (*act_as_secid)(u32 secid);
+	u32 (*act_as_self)(void);
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect) (struct socket * sock,
@@ -2150,6 +2162,16 @@ static inline u32 security_set_fscreate_
 	return security_ops->set_fscreate_secid(secid);
 }
 
+static inline u32 security_act_as_secid(u32 secid)
+{
+	return security_ops->act_as_secid(secid);
+}
+
+static inline u32 security_act_as_self(void)
+{
+	return security_ops->act_as_self();
+}
+
 /* prototypes */
 extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
@@ -2840,6 +2862,16 @@ static inline u32 security_set_fscreate_
 	return 0;
 }
 
+static inline u32 security_act_as_secid(u32 secid)
+{
+	return 0;
+}
+
+static inline u32 security_act_as_self(void)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/dummy.c b/security/dummy.c
index ee3c886..f7b47a9 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -937,6 +937,16 @@ static u32 dummy_set_fscreate_secid(u32 
 	return 0;
 }
 
+static u32 dummy_act_as_secid(u32 secid)
+{
+	return 0;
+}
+
+static u32 dummy_act_as_self(void)
+{
+	return 0;
+}
+
 #ifdef CONFIG_KEYS
 static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx,
 				  unsigned long flags)
@@ -1093,6 +1103,8 @@ void security_fixup_ops (struct security
  	set_to_dummy_if_null(ops, release_secctx);
  	set_to_dummy_if_null(ops, get_fscreate_secid);
  	set_to_dummy_if_null(ops, set_fscreate_secid);
+ 	set_to_dummy_if_null(ops, act_as_secid);
+ 	set_to_dummy_if_null(ops, act_as_self);
 #ifdef CONFIG_SECURITY_NETWORK
 	set_to_dummy_if_null(ops, unix_stream_connect);
 	set_to_dummy_if_null(ops, unix_may_send);
diff --git a/security/selinux/exports.c b/security/selinux/exports.c
index b6f9694..b559699 100644
--- a/security/selinux/exports.c
+++ b/security/selinux/exports.c
@@ -79,7 +79,7 @@ int selinux_relabel_packet_permission(u3
 	if (selinux_enabled) {
 		struct task_security_struct *tsec = current->security;
 
-		return avc_has_perm(tsec->sid, sid, SECCLASS_PACKET,
+		return avc_has_perm(tsec->actor_sid, sid, SECCLASS_PACKET,
 				    PACKET__RELABELTO, NULL);
 	}
 	return 0;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7f5ec86..09def09 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -162,7 +162,8 @@ static int task_alloc_security(struct ta
 		return -ENOMEM;
 
 	tsec->task = task;
-	tsec->osid = tsec->sid = tsec->ptrace_sid = SECINITSID_UNLABELED;
+	tsec->osid = tsec->actor_sid = tsec->sid = tsec->ptrace_sid =
+		SECINITSID_UNLABELED;
 	task->security = tsec;
 
 	return 0;
@@ -190,7 +191,7 @@ static int inode_alloc_security(struct i
 	isec->inode = inode;
 	isec->sid = SECINITSID_UNLABELED;
 	isec->sclass = SECCLASS_FILE;
-	isec->task_sid = tsec->sid;
+	isec->task_sid = tsec->actor_sid;
 	inode->i_security = isec;
 
 	return 0;
@@ -220,8 +221,8 @@ static int file_alloc_security(struct fi
 		return -ENOMEM;
 
 	fsec->file = file;
-	fsec->sid = tsec->sid;
-	fsec->fown_sid = tsec->sid;
+	fsec->sid = tsec->actor_sid;
+	fsec->fown_sid = tsec->actor_sid;
 	file->f_security = fsec;
 
 	return 0;
@@ -338,12 +339,12 @@ static int may_context_mount_sb_relabel(
 {
 	int rc;
 
-	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+	rc = avc_has_perm(tsec->actor_sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(tsec->sid, sid, SECCLASS_FILESYSTEM,
+	rc = avc_has_perm(tsec->actor_sid, sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELTO, NULL);
 	return rc;
 }
@@ -353,7 +354,7 @@ static int may_context_mount_inode_relab
 			struct task_security_struct *tsec)
 {
 	int rc;
-	rc = avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+	rc = avc_has_perm(tsec->actor_sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			  FILESYSTEM__RELABELFROM, NULL);
 	if (rc)
 		return rc;
@@ -1030,7 +1031,7 @@ static int task_has_perm(struct task_str
 
 	tsec1 = tsk1->security;
 	tsec2 = tsk2->security;
-	return avc_has_perm(tsec1->sid, tsec2->sid,
+	return avc_has_perm(tsec1->actor_sid, tsec2->sid,
 			    SECCLASS_PROCESS, perms, NULL);
 }
 
@@ -1047,7 +1048,7 @@ static int task_has_capability(struct ta
 	ad.tsk = tsk;
 	ad.u.cap = cap;
 
-	return avc_has_perm(tsec->sid, tsec->sid,
+	return avc_has_perm(tsec->actor_sid, tsec->actor_sid,
 			    SECCLASS_CAPABILITY, CAP_TO_MASK(cap), &ad);
 }
 
@@ -1059,7 +1060,7 @@ static int task_has_system(struct task_s
 
 	tsec = tsk->security;
 
-	return avc_has_perm(tsec->sid, SECINITSID_KERNEL,
+	return avc_has_perm(tsec->actor_sid, SECINITSID_KERNEL,
 			    SECCLASS_SYSTEM, perms, NULL);
 }
 
@@ -1084,7 +1085,8 @@ static int inode_has_perm(struct task_st
 		ad.u.fs.inode = inode;
 	}
 
-	return avc_has_perm(tsec->sid, isec->sid, isec->sclass, perms, adp);
+	return avc_has_perm(tsec->actor_sid, isec->sid, isec->sclass, perms,
+			    adp);
 }
 
 /* Same as inode_has_perm, but pass explicit audit data containing
@@ -1127,8 +1129,8 @@ static int file_has_perm(struct task_str
 	ad.u.fs.mnt = mnt;
 	ad.u.fs.dentry = dentry;
 
-	if (tsec->sid != fsec->sid) {
-		rc = avc_has_perm(tsec->sid, fsec->sid,
+	if (tsec->actor_sid != fsec->sid) {
+		rc = avc_has_perm(tsec->actor_sid, fsec->sid,
 				  SECCLASS_FD,
 				  FD__USE,
 				  &ad);
@@ -1162,7 +1164,7 @@ static int may_create(struct inode *dir,
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 	ad.u.fs.dentry = dentry;
 
-	rc = avc_has_perm(tsec->sid, dsec->sid, SECCLASS_DIR,
+	rc = avc_has_perm(tsec->actor_sid, dsec->sid, SECCLASS_DIR,
 			  DIR__ADD_NAME | DIR__SEARCH,
 			  &ad);
 	if (rc)
@@ -1171,13 +1173,13 @@ static int may_create(struct inode *dir,
 	if (tsec->create_sid && sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
 		newsid = tsec->create_sid;
 	} else {
-		rc = security_transition_sid(tsec->sid, dsec->sid, tclass,
-					     &newsid);
+		rc = security_transition_sid(tsec->actor_sid, dsec->sid,
+					     tclass, &newsid);
 		if (rc)
 			return rc;
 	}
 
-	rc = avc_has_perm(tsec->sid, newsid, tclass, FILE__CREATE, &ad);
+	rc = avc_has_perm(tsec->actor_sid, newsid, tclass, FILE__CREATE, &ad);
 	if (rc)
 		return rc;
 
@@ -1194,7 +1196,8 @@ static int may_create_key(u32 ksid,
 
 	tsec = ctx->security;
 
-	return avc_has_perm(tsec->sid, ksid, SECCLASS_KEY, KEY__CREATE, NULL);
+	return avc_has_perm(tsec->actor_sid, ksid, SECCLASS_KEY, KEY__CREATE,
+			    NULL);
 }
 
 #define MAY_LINK   0
@@ -1222,7 +1225,7 @@ static int may_link(struct inode *dir,
 
 	av = DIR__SEARCH;
 	av |= (kind ? DIR__REMOVE_NAME : DIR__ADD_NAME);
-	rc = avc_has_perm(tsec->sid, dsec->sid, SECCLASS_DIR, av, &ad);
+	rc = avc_has_perm(tsec->actor_sid, dsec->sid, SECCLASS_DIR, av, &ad);
 	if (rc)
 		return rc;
 
@@ -1241,7 +1244,7 @@ static int may_link(struct inode *dir,
 		return 0;
 	}
 
-	rc = avc_has_perm(tsec->sid, isec->sid, isec->sclass, av, &ad);
+	rc = avc_has_perm(tsec->actor_sid, isec->sid, isec->sclass, av, &ad);
 	return rc;
 }
 
@@ -1266,16 +1269,16 @@ static inline int may_rename(struct inod
 	AVC_AUDIT_DATA_INIT(&ad, FS);
 
 	ad.u.fs.dentry = old_dentry;
-	rc = avc_has_perm(tsec->sid, old_dsec->sid, SECCLASS_DIR,
+	rc = avc_has_perm(tsec->actor_sid, old_dsec->sid, SECCLASS_DIR,
 			  DIR__REMOVE_NAME | DIR__SEARCH, &ad);
 	if (rc)
 		return rc;
-	rc = avc_has_perm(tsec->sid, old_isec->sid,
+	rc = avc_has_perm(tsec->actor_sid, old_isec->sid,
 			  old_isec->sclass, FILE__RENAME, &ad);
 	if (rc)
 		return rc;
 	if (old_is_dir && new_dir != old_dir) {
-		rc = avc_has_perm(tsec->sid, old_isec->sid,
+		rc = avc_has_perm(tsec->actor_sid, old_isec->sid,
 				  old_isec->sclass, DIR__REPARENT, &ad);
 		if (rc)
 			return rc;
@@ -1285,15 +1288,17 @@ static inline int may_rename(struct inod
 	av = DIR__ADD_NAME | DIR__SEARCH;
 	if (new_dentry->d_inode)
 		av |= DIR__REMOVE_NAME;
-	rc = avc_has_perm(tsec->sid, new_dsec->sid, SECCLASS_DIR, av, &ad);
+	rc = avc_has_perm(tsec->actor_sid, new_dsec->sid, SECCLASS_DIR, av,
+			  &ad);
 	if (rc)
 		return rc;
 	if (new_dentry->d_inode) {
 		new_isec = new_dentry->d_inode->i_security;
 		new_is_dir = S_ISDIR(new_dentry->d_inode->i_mode);
-		rc = avc_has_perm(tsec->sid, new_isec->sid,
+		rc = avc_has_perm(tsec->actor_sid, new_isec->sid,
 				  new_isec->sclass,
-				  (new_is_dir ? DIR__RMDIR : FILE__UNLINK), &ad);
+				  (new_is_dir ? DIR__RMDIR : FILE__UNLINK),
+				  &ad);
 		if (rc)
 			return rc;
 	}
@@ -1312,7 +1317,7 @@ static int superblock_has_perm(struct ta
 
 	tsec = tsk->security;
 	sbsec = sb->s_security;
-	return avc_has_perm(tsec->sid, sbsec->sid, SECCLASS_FILESYSTEM,
+	return avc_has_perm(tsec->actor_sid, sbsec->sid, SECCLASS_FILESYSTEM,
 			    perms, ad);
 }
 
@@ -1376,7 +1381,7 @@ static int selinux_ptrace(struct task_st
 	rc = task_has_perm(parent, child, PROCESS__PTRACE);
 	/* Save the SID of the tracing process for later use in apply_creds. */
 	if (!(child->ptrace & PT_PTRACED) && !rc)
-		csec->ptrace_sid = psec->sid;
+		csec->ptrace_sid = psec->actor_sid;
 	return rc;
 }
 
@@ -1445,7 +1450,7 @@ static int selinux_sysctl(ctl_table *tab
 	/* The op values are "defined" in sysctl.c, thereby creating
 	 * a bad coupling between this module and sysctl.c */
 	if(op == 001) {
-		error = avc_has_perm(tsec->sid, tsid,
+		error = avc_has_perm(tsec->actor_sid, tsid,
 				     SECCLASS_DIR, DIR__SEARCH, NULL);
 	} else {
 		av = 0;
@@ -1454,7 +1459,7 @@ static int selinux_sysctl(ctl_table *tab
 		if (op & 002)
 			av |= FILE__WRITE;
 		if (av)
-			error = avc_has_perm(tsec->sid, tsid,
+			error = avc_has_perm(tsec->actor_sid, tsid,
 					     SECCLASS_FILE, av, NULL);
         }
 
@@ -1546,7 +1551,7 @@ static int selinux_vm_enough_memory(long
 
 	rc = secondary_ops->capable(current, CAP_SYS_ADMIN);
 	if (rc == 0)
-		rc = avc_has_perm_noaudit(tsec->sid, tsec->sid,
+		rc = avc_has_perm_noaudit(tsec->actor_sid, tsec->actor_sid,
 					SECCLASS_CAPABILITY,
 					CAP_TO_MASK(CAP_SYS_ADMIN),
 					NULL);
@@ -1598,7 +1603,7 @@ static int selinux_bprm_set_security(str
 	isec = inode->i_security;
 
 	/* Default to the current task SID. */
-	bsec->sid = tsec->sid;
+	bsec->sid = tsec->actor_sid;
 
 	/* Reset fs, key, and sock SIDs on execve. */
 	tsec->create_sid = 0;
@@ -1611,7 +1616,7 @@ static int selinux_bprm_set_security(str
 		tsec->exec_sid = 0;
 	} else {
 		/* Check for a default transition on this program. */
-		rc = security_transition_sid(tsec->sid, isec->sid,
+		rc = security_transition_sid(tsec->actor_sid, isec->sid,
 		                             SECCLASS_PROCESS, &newsid);
 		if (rc)
 			return rc;
@@ -1622,16 +1627,16 @@ static int selinux_bprm_set_security(str
 	ad.u.fs.dentry = bprm->file->f_dentry;
 
 	if (bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)
-		newsid = tsec->sid;
+		newsid = tsec->actor_sid;
 
-        if (tsec->sid == newsid) {
-		rc = avc_has_perm(tsec->sid, isec->sid,
+        if (tsec->actor_sid == newsid) {
+		rc = avc_has_perm(tsec->actor_sid, isec->sid,
 				  SECCLASS_FILE, FILE__EXECUTE_NO_TRANS, &ad);
 		if (rc)
 			return rc;
 	} else {
 		/* Check permissions for the transition. */
-		rc = avc_has_perm(tsec->sid, newsid,
+		rc = avc_has_perm(tsec->actor_sid, newsid,
 				  SECCLASS_PROCESS, PROCESS__TRANSITION, &ad);
 		if (rc)
 			return rc;
@@ -1810,6 +1815,8 @@ static void selinux_bprm_apply_creds(str
 				return;
 			}
 		}
+		if (tsec->actor_sid == tsec->sid)
+			tsec->actor_sid = sid;
 		tsec->sid = sid;
 	}
 }
@@ -2084,7 +2091,7 @@ static int selinux_inode_init_security(s
 	if (tsec->create_sid && sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
 		newsid = tsec->create_sid;
 	} else {
-		rc = security_transition_sid(tsec->sid, dsec->sid,
+		rc = security_transition_sid(tsec->actor_sid, dsec->sid,
 					     inode_mode_to_security_class(inode->i_mode),
 					     &newsid);
 		if (rc) {
@@ -2275,7 +2282,7 @@ static int selinux_inode_setxattr(struct
 	AVC_AUDIT_DATA_INIT(&ad,FS);
 	ad.u.fs.dentry = dentry;
 
-	rc = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
+	rc = avc_has_perm(tsec->actor_sid, isec->sid, isec->sclass,
 			  FILE__RELABELFROM, &ad);
 	if (rc)
 		return rc;
@@ -2284,12 +2291,12 @@ static int selinux_inode_setxattr(struct
 	if (rc)
 		return rc;
 
-	rc = avc_has_perm(tsec->sid, newsid, isec->sclass,
+	rc = avc_has_perm(tsec->actor_sid, newsid, isec->sclass,
 			  FILE__RELABELTO, &ad);
 	if (rc)
 		return rc;
 
-	rc = security_validate_transition(isec->sid, newsid, tsec->sid,
+	rc = security_validate_transition(isec->sid, newsid, tsec->actor_sid,
 	                                  isec->sclass);
 	if (rc)
 		return rc;
@@ -2693,7 +2700,7 @@ static int selinux_task_alloc_security(s
 	tsec2 = tsk->security;
 
 	tsec2->osid = tsec1->osid;
-	tsec2->sid = tsec1->sid;
+	tsec2->actor_sid = tsec2->sid = tsec1->sid;
 
 	/* Retain the exec, fs, key, and sock SIDs across fork */
 	tsec2->exec_sid = tsec1->exec_sid;
@@ -2872,6 +2879,8 @@ static void selinux_task_reparent_to_ini
 
 	tsec = p->security;
 	tsec->osid = tsec->sid;
+	if (tsec->actor_sid == tsec->sid)
+		tsec->actor_sid = SECINITSID_KERNEL;
 	tsec->sid = SECINITSID_KERNEL;
 	return;
 }
@@ -3054,7 +3063,8 @@ static int socket_has_perm(struct task_s
 
 	AVC_AUDIT_DATA_INIT(&ad,NET);
 	ad.u.net.sk = sock->sk;
-	err = avc_has_perm(tsec->sid, isec->sid, isec->sclass, perms, &ad);
+	err = avc_has_perm(tsec->actor_sid, isec->sid, isec->sclass, perms,
+			   &ad);
 
 out:
 	return err;
@@ -3071,8 +3081,8 @@ static int selinux_socket_create(int fam
 		goto out;
 
 	tsec = current->security;
-	newsid = tsec->sockcreate_sid ? : tsec->sid;
-	err = avc_has_perm(tsec->sid, newsid,
+	newsid = tsec->sockcreate_sid ? : tsec->actor_sid;
+	err = avc_has_perm(tsec->actor_sid, newsid,
 			   socket_type_to_security_class(family, type,
 			   protocol), SOCKET__CREATE, NULL);
 
@@ -3092,7 +3102,7 @@ static int selinux_socket_post_create(st
 	isec = SOCK_INODE(sock)->i_security;
 
 	tsec = current->security;
-	newsid = tsec->sockcreate_sid ? : tsec->sid;
+	newsid = tsec->sockcreate_sid ? : tsec->actor_sid;
 	isec->sclass = socket_type_to_security_class(family, type, protocol);
 	isec->sid = kern ? SECINITSID_KERNEL : newsid;
 	isec->initialized = 1;
@@ -3904,7 +3914,7 @@ static int ipc_alloc_security(struct tas
 
 	isec->sclass = sclass;
 	isec->ipc_perm = perm;
-	isec->sid = tsec->sid;
+	isec->sid = tsec->actor_sid;
 	perm->security = isec;
 
 	return 0;
@@ -3953,7 +3963,8 @@ static int ipc_has_perm(struct kern_ipc_
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = ipc_perms->key;
 
-	return avc_has_perm(tsec->sid, isec->sid, isec->sclass, perms, &ad);
+	return avc_has_perm(tsec->actor_sid, isec->sid, isec->sclass, perms,
+			    &ad);
 }
 
 static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
@@ -3984,7 +3995,7 @@ static int selinux_msg_queue_alloc_secur
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = msq->q_perm.key;
 
-	rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_MSGQ,
+	rc = avc_has_perm(tsec->actor_sid, isec->sid, SECCLASS_MSGQ,
 			  MSGQ__CREATE, &ad);
 	if (rc) {
 		ipc_free_security(&msq->q_perm);
@@ -4010,7 +4021,7 @@ static int selinux_msg_queue_associate(s
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = msq->q_perm.key;
 
-	return avc_has_perm(tsec->sid, isec->sid, SECCLASS_MSGQ,
+	return avc_has_perm(tsec->actor_sid, isec->sid, SECCLASS_MSGQ,
 			    MSGQ__ASSOCIATE, &ad);
 }
 
@@ -4062,7 +4073,7 @@ static int selinux_msg_queue_msgsnd(stru
 		 * Compute new sid based on current process and
 		 * message queue this message will be stored in
 		 */
-		rc = security_transition_sid(tsec->sid,
+		rc = security_transition_sid(tsec->actor_sid,
 					     isec->sid,
 					     SECCLASS_MSG,
 					     &msec->sid);
@@ -4074,11 +4085,11 @@ static int selinux_msg_queue_msgsnd(stru
 	ad.u.ipc_id = msq->q_perm.key;
 
 	/* Can this process write to the queue? */
-	rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_MSGQ,
+	rc = avc_has_perm(tsec->actor_sid, isec->sid, SECCLASS_MSGQ,
 			  MSGQ__WRITE, &ad);
 	if (!rc)
 		/* Can this process send the message */
-		rc = avc_has_perm(tsec->sid, msec->sid,
+		rc = avc_has_perm(tsec->actor_sid, msec->sid,
 				  SECCLASS_MSG, MSG__SEND, &ad);
 	if (!rc)
 		/* Can the message be put in the queue? */
@@ -4105,10 +4116,10 @@ static int selinux_msg_queue_msgrcv(stru
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = msq->q_perm.key;
 
-	rc = avc_has_perm(tsec->sid, isec->sid,
+	rc = avc_has_perm(tsec->actor_sid, isec->sid,
 			  SECCLASS_MSGQ, MSGQ__READ, &ad);
 	if (!rc)
-		rc = avc_has_perm(tsec->sid, msec->sid,
+		rc = avc_has_perm(tsec->actor_sid, msec->sid,
 				  SECCLASS_MSG, MSG__RECEIVE, &ad);
 	return rc;
 }
@@ -4131,7 +4142,7 @@ static int selinux_shm_alloc_security(st
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = shp->shm_perm.key;
 
-	rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_SHM,
+	rc = avc_has_perm(tsec->actor_sid, isec->sid, SECCLASS_SHM,
 			  SHM__CREATE, &ad);
 	if (rc) {
 		ipc_free_security(&shp->shm_perm);
@@ -4157,7 +4168,7 @@ static int selinux_shm_associate(struct 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = shp->shm_perm.key;
 
-	return avc_has_perm(tsec->sid, isec->sid, SECCLASS_SHM,
+	return avc_has_perm(tsec->actor_sid, isec->sid, SECCLASS_SHM,
 			    SHM__ASSOCIATE, &ad);
 }
 
@@ -4230,7 +4241,7 @@ static int selinux_sem_alloc_security(st
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
  	ad.u.ipc_id = sma->sem_perm.key;
 
-	rc = avc_has_perm(tsec->sid, isec->sid, SECCLASS_SEM,
+	rc = avc_has_perm(tsec->actor_sid, isec->sid, SECCLASS_SEM,
 			  SEM__CREATE, &ad);
 	if (rc) {
 		ipc_free_security(&sma->sem_perm);
@@ -4256,7 +4267,7 @@ static int selinux_sem_associate(struct 
 	AVC_AUDIT_DATA_INIT(&ad, IPC);
 	ad.u.ipc_id = sma->sem_perm.key;
 
-	return avc_has_perm(tsec->sid, isec->sid, SECCLASS_SEM,
+	return avc_has_perm(tsec->actor_sid, isec->sid, SECCLASS_SEM,
 			    SEM__ASSOCIATE, &ad);
 }
 
@@ -4500,14 +4511,19 @@ static int selinux_setprocattr(struct ta
 			error = avc_has_perm_noaudit(tsec->ptrace_sid, sid,
 						     SECCLASS_PROCESS,
 						     PROCESS__PTRACE, &avd);
-			if (!error)
+			if (!error) {
+				if (tsec->actor_sid == tsec->sid)
+					tsec->actor_sid = sid;
 				tsec->sid = sid;
+			}
 			task_unlock(p);
 			avc_audit(tsec->ptrace_sid, sid, SECCLASS_PROCESS,
 				  PROCESS__PTRACE, &avd, error, NULL);
 			if (error)
 				return error;
 		} else {
+			if (tsec->actor_sid == tsec->sid)
+				tsec->actor_sid = sid;
 			tsec->sid = sid;
 			task_unlock(p);
 		}
@@ -4545,6 +4561,24 @@ static u32 selinux_set_fscreate_secid(u3
 	return oldsid;
 }
 
+static u32 selinux_act_as_secid(u32 secid)
+{
+	struct task_security_struct *tsec = current->security;
+	u32 oldactor_sid = tsec->actor_sid;
+
+	tsec->actor_sid = secid;
+	return oldactor_sid;
+}
+
+static u32 selinux_act_as_self(void)
+{
+	struct task_security_struct *tsec = current->security;
+	u32 oldactor_sid = tsec->actor_sid;
+
+	tsec->actor_sid = tsec->sid;
+	return oldactor_sid;
+}
+
 #ifdef CONFIG_KEYS
 
 static int selinux_key_alloc(struct key *k, struct task_struct *tsk,
@@ -4594,7 +4628,7 @@ static int selinux_key_permission(key_re
 	if (perm == 0)
 		return 0;
 
-	return avc_has_perm(tsec->sid, ksec->sid,
+	return avc_has_perm(tsec->actor_sid, ksec->sid,
 			    SECCLASS_KEY, perm, NULL);
 }
 
@@ -4729,6 +4763,8 @@ static struct security_operations selinu
 	.release_secctx =		selinux_release_secctx,
 	.get_fscreate_secid =		selinux_get_fscreate_secid,
 	.set_fscreate_secid =		selinux_set_fscreate_secid,
+	.act_as_secid =			selinux_act_as_secid,
+	.act_as_self =			selinux_act_as_self,
 
         .unix_stream_connect =		selinux_socket_unix_stream_connect,
 	.unix_may_send =		selinux_socket_unix_may_send,
@@ -4794,7 +4830,7 @@ static __init int selinux_init(void)
 	if (task_alloc_security(current))
 		panic("SELinux:  Failed to initialize initial task.\n");
 	tsec = current->security;
-	tsec->osid = tsec->sid = SECINITSID_KERNEL;
+	tsec->osid = tsec->actor_sid = tsec->sid = SECINITSID_KERNEL;
 
 	sel_inode_cache = kmem_cache_create("selinux_inode_security",
 					    sizeof(struct inode_security_struct),
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index ef2267f..4e8da30 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -30,6 +30,7 @@ struct task_security_struct {
 	struct task_struct *task;      /* back pointer to task object */
 	u32 osid;            /* SID prior to last execve */
 	u32 sid;             /* current SID */
+	u32 actor_sid;       /* act-as SID (normally == sid) */
 	u32 exec_sid;        /* exec SID */
 	u32 create_sid;      /* fscreate SID */
 	u32 keycreate_sid;   /* keycreate SID */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index cd24441..c676b4b 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -79,7 +79,7 @@ static int task_has_security(struct task
 	if (!tsec)
 		return -EACCES;
 
-	return avc_has_perm(tsec->sid, SECINITSID_SECURITY,
+	return avc_has_perm(tsec->actor_sid, SECINITSID_SECURITY,
 			    SECCLASS_SECURITY, perms, NULL);
 }
 
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 675b995..4ea1f58 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -270,7 +270,7 @@ static int selinux_xfrm_sec_ctx_alloc(st
 	/*
 	 * Does the subject have permission to set security context?
 	 */
-	rc = avc_has_perm(tsec->sid, ctx->ctx_sid,
+	rc = avc_has_perm(tsec->actor_sid, ctx->ctx_sid,
 			  SECCLASS_ASSOCIATION,
 			  ASSOCIATION__SETCONTEXT, NULL);
 	if (rc)
@@ -387,7 +387,7 @@ int selinux_xfrm_policy_delete(struct xf
 	int rc = 0;
 
 	if (ctx)
-		rc = avc_has_perm(tsec->sid, ctx->ctx_sid,
+		rc = avc_has_perm(tsec->actor_sid, ctx->ctx_sid,
 				  SECCLASS_ASSOCIATION,
 				  ASSOCIATION__SETCONTEXT, NULL);
 
@@ -497,7 +497,7 @@ int selinux_xfrm_state_delete(struct xfr
 	int rc = 0;
 
 	if (ctx)
-		rc = avc_has_perm(tsec->sid, ctx->ctx_sid,
+		rc = avc_has_perm(tsec->actor_sid, ctx->ctx_sid,
 				  SECCLASS_ASSOCIATION,
 				  ASSOCIATION__SETCONTEXT, NULL);
 
