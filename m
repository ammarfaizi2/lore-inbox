Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966307AbWKNULX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966307AbWKNULX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966309AbWKNUJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:09:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50857 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966308AbWKNUJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:09:13 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 15/19] CacheFiles: Get the SID under which the CacheFiles module should operate
Date: Tue, 14 Nov 2006 20:06:54 +0000
To: torvalds@osdl.org, akpm@osdl.org, sds@tycho.nsa.gov,
       trond.myklebust@fys.uio.no
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Message-Id: <20061114200654.12943.1073.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get the SID under which the CacheFiles module should operate so that the
SELinux security system can control the accesses it makes.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/security.h |   20 ++++++++++++++++++++
 security/dummy.c         |    7 +++++++
 security/selinux/hooks.c |    7 +++++++
 3 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 5913ae7..8cfeefc 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1171,6 +1171,14 @@ #ifdef CONFIG_SECURITY
  *      owning security ID, and return the security ID as which the process was
  *      previously acting.
  *
+ * @cachefiles_get_secid:
+ *	Determine the security ID for the CacheFiles module to use when
+ *	accessing the filesystem containing the cache.
+ *	@secid contains the security ID under which cachefiles daemon is
+ *      running.
+ *	@modsecid contains the pointer to where the security ID for the module
+ *	is to be stored.
+ *
  * This is the main security structure.
  */
 struct security_operations {
@@ -1358,6 +1366,7 @@ struct security_operations {
 	u32 (*set_fscreate_secid)(u32 secid);
 	u32 (*act_as_secid)(u32 secid);
 	u32 (*act_as_self)(void);
+	int (*cachefiles_get_secid)(u32 secid, u32 *modsecid);
 
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect) (struct socket * sock,
@@ -2180,6 +2189,11 @@ static inline u32 security_act_as_self(v
 	return security_ops->act_as_self();
 }
 
+static inline int security_cachefiles_get_secid(u32 secid, u32 *modsecid)
+{
+	return security_ops->cachefiles_get_secid(secid, modsecid);
+}
+
 /* prototypes */
 extern int security_init	(void);
 extern int register_security	(struct security_operations *ops);
@@ -2885,6 +2899,12 @@ static inline u32 security_act_as_self(v
 	return 0;
 }
 
+static inline int security_cachefiles_get_secid(u32 secid, u32 *modsecid)
+{
+	*modsecid = 0;
+	return 0;
+}
+
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/dummy.c b/security/dummy.c
index 3401ea3..30096ec 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -952,6 +952,12 @@ static u32 dummy_act_as_self(void)
 	return 0;
 }
 
+static int dummy_cachefiles_get_secid(u32 secid, u32 *modsecid)
+{
+	*modsecid = 0;
+	return 0;
+}
+
 #ifdef CONFIG_KEYS
 static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx,
 				  unsigned long flags)
@@ -1111,6 +1117,7 @@ void security_fixup_ops (struct security
  	set_to_dummy_if_null(ops, set_fscreate_secid);
  	set_to_dummy_if_null(ops, act_as_secid);
  	set_to_dummy_if_null(ops, act_as_self);
+ 	set_to_dummy_if_null(ops, cachefiles_get_secid);
 #ifdef CONFIG_SECURITY_NETWORK
 	set_to_dummy_if_null(ops, unix_stream_connect);
 	set_to_dummy_if_null(ops, unix_may_send);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ddac1bc..3a52698 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4586,6 +4586,12 @@ static u32 selinux_act_as_self(void)
 	return oldactor_sid;
 }
 
+static int selinux_cachefiles_get_secid(u32 secid, u32 *modsecid)
+{
+	return security_transition_sid(secid, SECINITSID_KERNEL,
+				       SECCLASS_PROCESS, modsecid);
+}
+
 #ifdef CONFIG_KEYS
 
 static int selinux_key_alloc(struct key *k, struct task_struct *tsk,
@@ -4773,6 +4779,7 @@ static struct security_operations selinu
 	.set_fscreate_secid =		selinux_set_fscreate_secid,
 	.act_as_secid =			selinux_act_as_secid,
 	.act_as_self =			selinux_act_as_self,
+	.cachefiles_get_secid =		selinux_cachefiles_get_secid,
 
         .unix_stream_connect =		selinux_socket_unix_stream_connect,
 	.unix_may_send =		selinux_socket_unix_may_send,
