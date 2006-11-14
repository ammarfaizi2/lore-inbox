Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966312AbWKNUM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966312AbWKNUM7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966322AbWKNUJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:09:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61865 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966315AbWKNUJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:09:20 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 12/19] CacheFiles: Permit a process's create SID to be overridden
Date: Tue, 14 Nov 2006 20:06:47 +0000
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Message-Id: <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make it possible for a process's file creation SID to be temporarily overridden
by CacheFiles so that files created in the cache have the right label attached.

Without this facility, files created in the cache will be given the current
file creation SID of whatever process happens to have invoked CacheFiles
indirectly by means of opening a netfs file at the time the cache file is
created.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/security.h |   35 +++++++++++++++++++++++++++++++++++
 security/dummy.c         |   12 ++++++++++++
 security/selinux/hooks.c |   18 ++++++++++++++++++
 3 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index b200b98..7955017 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1154,6 +1154,13 @@ #ifdef CONFIG_SECURITY
  *	@secdata contains the security context.
  *	@seclen contains the length of the security context.
  *
+ * @get_fscreate_secid:
+ *	Get the current FS security ID.
+ *
+ * @set_fscreate_secid:
+ *	Set the current FS security ID.
+ *	@secid contains the security ID to set.
+ *
  * This is the main security structure.
  */
 struct security_operations {
@@ -1336,6 +1343,8 @@ struct security_operations {
  	int (*setprocattr)(struct task_struct *p, char *name, void *value, size_t size);
 	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
 	void (*release_secctx)(char *secdata, u32 seclen);
+	u32 (*get_fscreate_secid)(void);
+	u32 (*set_fscreate_secid)(u32 secid);
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect) (struct socket * sock,
@@ -2131,6 +2140,16 @@ static inline void security_release_secc
 	return security_ops->release_secctx(secdata, seclen);
 }
 
+static inline u32 security_get_fscreate_secid(void)
+{
+	return security_ops->get_fscreate_secid();
+}
+
+static inline u32 security_set_fscreate_secid(u32 secid)
+{
+	return security_ops->set_fscreate_secid(secid);
+}
+
 /* prototypes */
 extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
@@ -2797,6 +2816,11 @@ static inline void securityfs_remove(str
 {
 }
 
+static inline int security_to_secctx_secid(char *secdata, u32 seclen, u32 *secid)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
 	return -EOPNOTSUPP;
@@ -2805,6 +2829,17 @@ static inline int security_secid_to_secc
 static inline void security_release_secctx(char *secdata, u32 seclen)
 {
 }
+
+static inline u32 security_get_fscreate_secid(void)
+{
+	return 0;
+}
+
+static inline u32 security_set_fscreate_secid(u32 secid)
+{
+	return 0;
+}
+
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/dummy.c b/security/dummy.c
index 43874c1..ee3c886 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -927,6 +927,16 @@ static void dummy_release_secctx(char *s
 {
 }
 
+static u32 dummy_get_fscreate_secid(void)
+{
+	return 0;
+}
+
+static u32 dummy_set_fscreate_secid(u32 secid)
+{
+	return 0;
+}
+
 #ifdef CONFIG_KEYS
 static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx,
 				  unsigned long flags)
@@ -1081,6 +1091,8 @@ void security_fixup_ops (struct security
  	set_to_dummy_if_null(ops, setprocattr);
  	set_to_dummy_if_null(ops, secid_to_secctx);
  	set_to_dummy_if_null(ops, release_secctx);
+ 	set_to_dummy_if_null(ops, get_fscreate_secid);
+ 	set_to_dummy_if_null(ops, set_fscreate_secid);
 #ifdef CONFIG_SECURITY_NETWORK
 	set_to_dummy_if_null(ops, unix_stream_connect);
 	set_to_dummy_if_null(ops, unix_may_send);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8ab5679..7f5ec86 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4529,6 +4529,22 @@ static void selinux_release_secctx(char 
 		kfree(secdata);
 }
 
+static u32 selinux_get_fscreate_secid(void)
+{
+	struct task_security_struct *tsec = current->security;
+
+	return tsec->create_sid;
+}
+
+static u32 selinux_set_fscreate_secid(u32 secid)
+{
+	struct task_security_struct *tsec = current->security;
+	u32 oldsid = tsec->create_sid;
+
+	tsec->create_sid = secid;
+	return oldsid;
+}
+
 #ifdef CONFIG_KEYS
 
 static int selinux_key_alloc(struct key *k, struct task_struct *tsk,
@@ -4711,6 +4727,8 @@ static struct security_operations selinu
 
 	.secid_to_secctx =		selinux_secid_to_secctx,
 	.release_secctx =		selinux_release_secctx,
+	.get_fscreate_secid =		selinux_get_fscreate_secid,
+	.set_fscreate_secid =		selinux_set_fscreate_secid,
 
         .unix_stream_connect =		selinux_socket_unix_stream_connect,
 	.unix_may_send =		selinux_socket_unix_may_send,
