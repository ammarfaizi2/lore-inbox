Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030908AbWKOTLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030908AbWKOTLh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030907AbWKOTLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:11:37 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27873 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030909AbWKOTLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:11:35 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <26860.1163607813@redhat.com> 
References: <26860.1163607813@redhat.com>  <XMMS.LNX.4.64.0611151115360.8593@d.namei> <XMMS.LNX.4.64.0611141618300.25022@d.namei> <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com> <15153.1163593562@redhat.com> 
To: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       trond.myklebust@fys.uio.no, selinux@tycho.nsa.gov,
       linux-kernel@vger.kernel.org, aviro@redhat.com, steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be overridden 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 15 Nov 2006 19:09:10 +0000
Message-ID: <6134.1163617750@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > I think we need to add a separate field for this purpose, which can only 
> > be written to via the in-kernel API and overrides fscreate.
> 
> So, like my acts-as security ID patch?

How about this then?

I haven't removed the old fscreate overriding patch yet, not have I put in the
error handling in CacheFiles.

And whilst selinux_fscreate_as_secid() does perform a MAC check, I think that
PROCESS__SETFSCREATE is probably the wroing thing to use.  I think there should
be a PROCESS__SETFSCREATEAS or similar.  I assume that doing that would require
the userspace policy compiler to be modified.

David
---

 include/linux/security.h          |   35 ++++++++++++++++++++++++++++++++
 security/dummy.c                  |   14 +++++++++++++
 security/selinux/hooks.c          |   40 +++++++++++++++++++++++++++++++------
 security/selinux/include/objsec.h |    1 +
 fs/cachefiles/internal.h          |    7 +++---
 5 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8cfeefc..33a20f9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1171,6 +1171,17 @@ #ifdef CONFIG_SECURITY
  *      owning security ID, and return the security ID as which the process was
  *      previously acting.
  *
+ * @fscreate_as_secid:
+ *	Set the security ID as which to create files, returning the security ID
+ *	as which the process was previously creating files.
+ *	@secid contains the security ID to act as.
+ *	@oldsecid points to where the old security ID will be placed (or NULL).
+ *
+ * @fscreate_as_self:
+ *	Reset the security ID as which to create files to be the same as the
+ *	process's own creation security ID, and return the security ID as which
+ *	the process was previously creating files.
+ *
  * @cachefiles_get_secid:
  *	Determine the security ID for the CacheFiles module to use when
  *	accessing the filesystem containing the cache.
@@ -1366,6 +1377,8 @@ struct security_operations {
 	u32 (*set_fscreate_secid)(u32 secid);
 	u32 (*act_as_secid)(u32 secid);
 	u32 (*act_as_self)(void);
+	int (*fscreate_as_secid)(u32 secid, u32 *oldsecid);
+	u32 (*fscreate_as_self)(void);
 	int (*cachefiles_get_secid)(u32 secid, u32 *modsecid);
 
 #ifdef CONFIG_SECURITY_NETWORK
@@ -2189,6 +2202,16 @@ static inline u32 security_act_as_self(v
 	return security_ops->act_as_self();
 }
 
+static inline int security_fscreate_as_secid(u32 secid, u32 *oldsecid)
+{
+	return security_ops->fscreate_as_secid(secid, oldsecid);
+}
+
+static inline u32 security_fscreate_as_self(void)
+{
+	return security_ops->fscreate_as_self();
+}
+
 static inline int security_cachefiles_get_secid(u32 secid, u32 *modsecid)
 {
 	return security_ops->cachefiles_get_secid(secid, modsecid);
@@ -2899,6 +2922,18 @@ static inline u32 security_act_as_self(v
 	return 0;
 }
 
+static inline int security_fscreate_as_secid(u32 secid, u32 *oldsecid)
+{
+	if (oldsecid)
+		*oldsecid = 0;
+	return 0;
+}
+
+static inline u32 security_fscreate_as_self(void)
+{
+	return 0;
+}
+
 static inline int security_cachefiles_get_secid(u32 secid, u32 *modsecid)
 {
 	*modsecid = 0;
diff --git a/security/dummy.c b/security/dummy.c
index 30096ec..b31bd4c 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -952,6 +952,18 @@ static u32 dummy_act_as_self(void)
 	return 0;
 }
 
+static int dummy_fscreate_as_secid(u32 secid, u32 *oldsecid)
+{
+	if (oldsecid)
+		*oldsecid = 0;
+	return 0;
+}
+
+static u32 dummy_fscreate_as_self(void)
+{
+	return 0;
+}
+
 static int dummy_cachefiles_get_secid(u32 secid, u32 *modsecid)
 {
 	*modsecid = 0;
@@ -1117,6 +1129,8 @@ void security_fixup_ops (struct security
  	set_to_dummy_if_null(ops, set_fscreate_secid);
  	set_to_dummy_if_null(ops, act_as_secid);
  	set_to_dummy_if_null(ops, act_as_self);
+ 	set_to_dummy_if_null(ops, fscreate_as_secid);
+ 	set_to_dummy_if_null(ops, fscreate_as_self);
  	set_to_dummy_if_null(ops, cachefiles_get_secid);
 #ifdef CONFIG_SECURITY_NETWORK
 	set_to_dummy_if_null(ops, unix_stream_connect);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3a52698..c9388e3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1170,8 +1170,9 @@ static int may_create(struct inode *dir,
 	if (rc)
 		return rc;
 
-	if (tsec->create_sid && sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
-		newsid = tsec->create_sid;
+	if (tsec->create_as_sid &&
+	    sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
+		newsid = tsec->create_as_sid;
 	} else {
 		rc = security_transition_sid(tsec->actor_sid, dsec->sid,
 					     tclass, &newsid);
@@ -1606,7 +1607,7 @@ static int selinux_bprm_set_security(str
 	bsec->sid = tsec->actor_sid;
 
 	/* Reset fs, key, and sock SIDs on execve. */
-	tsec->create_sid = 0;
+	tsec->create_as_sid = tsec->create_sid = 0;
 	tsec->keycreate_sid = 0;
 	tsec->sockcreate_sid = 0;
 
@@ -2088,8 +2089,9 @@ static int selinux_inode_init_security(s
 	dsec = dir->i_security;
 	sbsec = dir->i_sb->s_security;
 
-	if (tsec->create_sid && sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
-		newsid = tsec->create_sid;
+	if (tsec->create_as_sid &&
+	    sbsec->behavior != SECURITY_FS_USE_MNTPOINT) {
+		newsid = tsec->create_as_sid;
 	} else {
 		rc = security_transition_sid(tsec->actor_sid, dsec->sid,
 					     inode_mode_to_security_class(inode->i_mode),
@@ -2711,7 +2713,7 @@ static int selinux_task_alloc_security(s
 
 	/* Retain the exec, fs, key, and sock SIDs across fork */
 	tsec2->exec_sid = tsec1->exec_sid;
-	tsec2->create_sid = tsec1->create_sid;
+	tsec2->create_as_sid = tsec2->create_sid = tsec1->create_sid;
 	tsec2->keycreate_sid = tsec1->keycreate_sid;
 	tsec2->sockcreate_sid = tsec1->sockcreate_sid;
 
@@ -4586,6 +4588,30 @@ static u32 selinux_act_as_self(void)
 	return oldactor_sid;
 }
 
+static int selinux_fscreate_as_secid(u32 secid, u32 *oldsecid)
+{
+	struct task_security_struct *tsec = current->security;
+	int error;
+
+	error = task_has_perm(current, current, PROCESS__SETFSCREATE);
+	if (error < 0)
+		return error;
+
+	if (oldsecid)
+		*oldsecid = tsec->create_as_sid;
+	tsec->create_as_sid = secid;
+	return 0;
+}
+
+static u32 selinux_fscreate_as_self(void)
+{
+	struct task_security_struct *tsec = current->security;
+	u32 oldcreate_sid = tsec->create_as_sid;
+
+	tsec->create_as_sid = tsec->create_sid;
+	return oldcreate_sid;
+}
+
 static int selinux_cachefiles_get_secid(u32 secid, u32 *modsecid)
 {
 	return security_transition_sid(secid, SECINITSID_KERNEL,
@@ -4779,6 +4805,8 @@ static struct security_operations selinu
 	.set_fscreate_secid =		selinux_set_fscreate_secid,
 	.act_as_secid =			selinux_act_as_secid,
 	.act_as_self =			selinux_act_as_self,
+	.fscreate_as_secid =		selinux_fscreate_as_secid,
+	.fscreate_as_self =		selinux_fscreate_as_self,
 	.cachefiles_get_secid =		selinux_cachefiles_get_secid,
 
         .unix_stream_connect =		selinux_socket_unix_stream_connect,
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 4e8da30..70a6f00 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -33,6 +33,7 @@ struct task_security_struct {
 	u32 actor_sid;       /* act-as SID (normally == sid) */
 	u32 exec_sid;        /* exec SID */
 	u32 create_sid;      /* fscreate SID */
+	u32 create_as_sid;   /* fscreate-as SID (normally == create_sid) */
 	u32 keycreate_sid;   /* keycreate SID */
 	u32 sockcreate_sid;  /* fscreate SID */
 	u32 ptrace_sid;      /* SID of ptrace parent */
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 4715de5..bd4529d 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -196,7 +196,7 @@ extern int cachefiles_determine_cache_se
 static inline
 void cachefiles_set_fscreate_secid(struct cachefiles_cache *cache)
 {
-	security_set_fscreate_secid(cache->cache_secid);
+	security_fscreate_as_secid(cache->cache_secid, NULL);
 }
 #else
 #define cachefiles_get_security_ID(cache) (0)
@@ -217,7 +217,6 @@ static inline void cachefiles_begin_secu
 {
 #ifdef CONFIG_SECURITY
 	security_act_as_secid(cache->access_secid);
-	ctx->fscreate_secid = security_get_fscreate_secid();
 #endif
 	ctx->fsuid = current->fsuid;
 	ctx->fsgid = current->fsgid;
@@ -230,7 +229,7 @@ static inline void cachefiles_begin_secu
 {
 #ifdef CONFIG_SECURITY
 	security_act_as_secid(cache->access_secid);
-	ctx->fscreate_secid = security_set_fscreate_secid(cache->cache_secid);
+	security_fscreate_as_secid(cache->cache_secid, NULL);
 #endif
 	ctx->fsuid = current->fsuid;
 	ctx->fsgid = current->fsgid;
@@ -244,7 +243,7 @@ static inline void cachefiles_end_secure
 	current->fsuid = ctx->fsuid;
 	current->fsgid = ctx->fsgid;
 #ifdef CONFIG_SECURITY
-	security_set_fscreate_secid(ctx->fscreate_secid);
+	security_fscreate_as_self();
 	security_act_as_self();
 #endif
 }
