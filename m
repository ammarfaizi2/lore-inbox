Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbWFBQyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbWFBQyF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 12:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWFBQyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 12:54:05 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:54659 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932522AbWFBQyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 12:54:03 -0400
Date: Fri, 2 Jun 2006 12:54:00 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Michael LeMay <mdlemay@epoch.ncsc.mil>,
       David Howells <dhowells@redhat.com>, Chris Wright <chrisw@sous-sol.org>,
       Eric Paris <eparis@redhat.com>
Subject: [PATCH] selinux: add hooks for key subsystem
Message-ID: <Pine.LNX.4.64.0606021250250.26283@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Targeted at the 2.6.18 merge window, please apply.  Has passed David's 
testsuite.

From: Michael LeMay <mdlemay@epoch.ncsc.mil>

Introduce SELinux hooks to support the access key retention subsystem 
within the kernel.  Incorporate new flask headers from a modified version 
of the SELinux reference policy, with support for the new security class 
representing retained keys.  Extend the "key_alloc" security hook with a 
task parameter representing the intended ownership context for the key 
being allocated.  Attach security information to root's default keyrings 
within the SELinux initialization routine.

Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <jmorris@namei.org>

---

 Documentation/keys.txt                       |   29 ++++++++++++
 include/linux/key.h                          |   18 +++++--
 include/linux/security.h                     |   10 ++--
 kernel/user.c                                |    2
 security/dummy.c                             |    2
 security/keys/key.c                          |    8 +--
 security/keys/keyring.c                      |    5 +-
 security/keys/process_keys.c                 |   15 +++---
 security/keys/request_key.c                  |    6 +-
 security/keys/request_key_auth.c             |    2
 security/selinux/hooks.c                     |   64 +++++++++++++++++++++++++++
 security/selinux/include/av_perm_to_string.h |    6 ++
 security/selinux/include/av_permissions.h    |    8 +++
 security/selinux/include/class_to_string.h   |    1
 security/selinux/include/flask.h             |    1
 security/selinux/include/objsec.h            |    5 ++
 16 files changed, 155 insertions(+), 27 deletions(-)

diff -uprN -X linux-2.6.17-rc5-mm1/Documentation/dontdiff linux-2.6.17-rc5-mm1.orig/Documentation/keys.txt linux-2.6.17-rc5-mm1/Documentation/keys.txt
--- linux-2.6.17-rc5-mm1.orig/Documentation/keys.txt	2006-05-31 09:47:43.000000000 -0400
+++ linux-2.6.17-rc5-mm1/Documentation/keys.txt	2006-06-02 09:42:07.000000000 -0400
@@ -19,6 +19,7 @@ This document has the following sections
 	- Key overview
 	- Key service overview
 	- Key access permissions
+	- SELinux support
 	- New procfs files
 	- Userspace system call interface
 	- Kernel services
@@ -232,6 +233,34 @@ For changing the ownership, group ID or 
 the key or having the sysadmin capability is sufficient.
 
 
+===============
+SELINUX SUPPORT
+===============
+
+The security class "key" has been added to SELinux so that mandatory access
+controls can be applied to keys created within various contexts.  This support
+is preliminary, and is likely to change quite significantly in the near future.
+Currently, all of the basic permissions explained above are provided in SELinux
+as well; SE Linux is simply invoked after all basic permission checks have been
+performed.
+
+Each key is labeled with the same context as the task to which it belongs.
+Typically, this is the same task that was running when the key was created.
+The default keyrings are handled differently, but in a way that is very
+intuitive:
+
+ (*) The user and user session keyrings that are created when the user logs in
+     are currently labeled with the context of the login manager.
+
+ (*) The keyrings associated with new threads are each labeled with the context
+     of their associated thread, and both session and process keyrings are
+     handled similarly.
+
+Note, however, that the default keyrings associated with the root user are
+labeled with the default kernel context, since they are created early in the
+boot process, before root has a chance to log in.
+
+
 ================
 NEW PROCFS FILES
 ================
diff -uprN -X linux-2.6.17-rc5-mm1/Documentation/dontdiff linux-2.6.17-rc5-mm1.orig/include/linux/key.h linux-2.6.17-rc5-mm1/include/linux/key.h
--- linux-2.6.17-rc5-mm1.orig/include/linux/key.h	2006-05-31 09:48:38.000000000 -0400
+++ linux-2.6.17-rc5-mm1/include/linux/key.h	2006-05-31 10:03:00.000000000 -0400
@@ -246,8 +246,9 @@ extern void unregister_key_type(struct k
 
 extern struct key *key_alloc(struct key_type *type,
 			     const char *desc,
-			     uid_t uid, gid_t gid, key_perm_t perm,
-			     int not_in_quota);
+			     uid_t uid, gid_t gid,
+			     struct task_struct *ctx,
+			     key_perm_t perm, int not_in_quota);
 extern int key_payload_reserve(struct key *key, size_t datalen);
 extern int key_instantiate_and_link(struct key *key,
 				    const void *data,
@@ -297,7 +298,9 @@ extern int key_unlink(struct key *keyrin
 		      struct key *key);
 
 extern struct key *keyring_alloc(const char *description, uid_t uid, gid_t gid,
-				 int not_in_quota, struct key *dest);
+				 struct task_struct *ctx,
+				 int not_in_quota,
+				 struct key *dest);
 
 extern int keyring_clear(struct key *keyring);
 
@@ -318,7 +321,8 @@ extern void keyring_replace_payload(stru
  * the userspace interface
  */
 extern struct key root_user_keyring, root_session_keyring;
-extern int alloc_uid_keyring(struct user_struct *user);
+extern int alloc_uid_keyring(struct user_struct *user,
+			     struct task_struct *ctx);
 extern void switch_uid_keyring(struct user_struct *new_user);
 extern int copy_keys(unsigned long clone_flags, struct task_struct *tsk);
 extern int copy_thread_group_keys(struct task_struct *tsk);
@@ -347,7 +351,7 @@ extern void key_init(void);
 #define make_key_ref(k)			({ NULL; })
 #define key_ref_to_ptr(k)		({ NULL; })
 #define is_key_possessed(k)		0
-#define alloc_uid_keyring(u)		0
+#define alloc_uid_keyring(u,c)		0
 #define switch_uid_keyring(u)		do { } while(0)
 #define __install_session_keyring(t, k)	({ NULL; })
 #define copy_keys(f,t)			0
@@ -360,6 +364,10 @@ extern void key_init(void);
 #define key_fsgid_changed(t)		do { } while(0)
 #define key_init()			do { } while(0)
 
+/* Initial keyrings */
+extern struct key root_user_keyring;
+extern struct key root_session_keyring;
+
 #endif /* CONFIG_KEYS */
 #endif /* __KERNEL__ */
 #endif /* _LINUX_KEY_H */
diff -uprN -X linux-2.6.17-rc5-mm1/Documentation/dontdiff linux-2.6.17-rc5-mm1.orig/include/linux/security.h linux-2.6.17-rc5-mm1/include/linux/security.h
--- linux-2.6.17-rc5-mm1.orig/include/linux/security.h	2006-05-31 09:48:39.000000000 -0400
+++ linux-2.6.17-rc5-mm1/include/linux/security.h	2006-05-31 10:03:00.000000000 -0400
@@ -1305,7 +1305,7 @@ struct security_operations {
 
 	/* key management security hooks */
 #ifdef CONFIG_KEYS
-	int (*key_alloc)(struct key *key);
+	int (*key_alloc)(struct key *key, struct task_struct *tsk);
 	void (*key_free)(struct key *key);
 	int (*key_permission)(key_ref_t key_ref,
 			      struct task_struct *context,
@@ -2980,9 +2980,10 @@ static inline int security_xfrm_policy_l
 
 #ifdef CONFIG_KEYS
 #ifdef CONFIG_SECURITY
-static inline int security_key_alloc(struct key *key)
+static inline int security_key_alloc(struct key *key,
+				     struct task_struct *tsk)
 {
-	return security_ops->key_alloc(key);
+	return security_ops->key_alloc(key, tsk);
 }
 
 static inline void security_key_free(struct key *key)
@@ -2999,7 +3000,8 @@ static inline int security_key_permissio
 
 #else
 
-static inline int security_key_alloc(struct key *key)
+static inline int security_key_alloc(struct key *key,
+				     struct task_struct *tsk)
 {
 	return 0;
 }
diff -uprN -X linux-2.6.17-rc5-mm1/Documentation/dontdiff linux-2.6.17-rc5-mm1.orig/kernel/user.c linux-2.6.17-rc5-mm1/kernel/user.c
--- linux-2.6.17-rc5-mm1.orig/kernel/user.c	2006-05-31 09:48:43.000000000 -0400
+++ linux-2.6.17-rc5-mm1/kernel/user.c	2006-05-31 10:03:00.000000000 -0400
@@ -148,7 +148,7 @@ struct user_struct * alloc_uid(uid_t uid
 		new->mq_bytes = 0;
 		new->locked_shm = 0;
 
-		if (alloc_uid_keyring(new) < 0) {
+		if (alloc_uid_keyring(new, current) < 0) {
 			kmem_cache_free(uid_cachep, new);
 			return NULL;
 		}
diff -uprN -X linux-2.6.17-rc5-mm1/Documentation/dontdiff linux-2.6.17-rc5-mm1.orig/security/dummy.c linux-2.6.17-rc5-mm1/security/dummy.c
--- linux-2.6.17-rc5-mm1.orig/security/dummy.c	2006-05-31 09:48:49.000000000 -0400
+++ linux-2.6.17-rc5-mm1/security/dummy.c	2006-05-31 10:03:00.000000000 -0400
@@ -850,7 +850,7 @@ static int dummy_setprocattr(struct task
 }
 
 #ifdef CONFIG_KEYS
-static inline int dummy_key_alloc(struct key *key)
+static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx)
 {
 	return 0;
 }
diff -uprN -X linux-2.6.17-rc5-mm1/Documentation/dontdiff linux-2.6.17-rc5-mm1.orig/security/keys/key.c linux-2.6.17-rc5-mm1/security/keys/key.c
--- linux-2.6.17-rc5-mm1.orig/security/keys/key.c	2006-05-31 09:48:49.000000000 -0400
+++ linux-2.6.17-rc5-mm1/security/keys/key.c	2006-05-31 10:03:00.000000000 -0400
@@ -247,8 +247,8 @@ static inline void key_alloc_serial(stru
  *   instantiate the key or discard it before returning
  */
 struct key *key_alloc(struct key_type *type, const char *desc,
-		      uid_t uid, gid_t gid, key_perm_t perm,
-		      int not_in_quota)
+		      uid_t uid, gid_t gid, struct task_struct *ctx,
+		      key_perm_t perm, int not_in_quota)
 {
 	struct key_user *user = NULL;
 	struct key *key;
@@ -318,7 +318,7 @@ struct key *key_alloc(struct key_type *t
 #endif
 
 	/* let the security module know about the key */
-	ret = security_key_alloc(key);
+	ret = security_key_alloc(key, ctx);
 	if (ret < 0)
 		goto security_error;
 
@@ -822,7 +822,7 @@ key_ref_t key_create_or_update(key_ref_t
 
 	/* allocate a new key */
 	key = key_alloc(ktype, description, current->fsuid, current->fsgid,
-			perm, not_in_quota);
+			current, perm, not_in_quota);
 	if (IS_ERR(key)) {
 		key_ref = ERR_PTR(PTR_ERR(key));
 		goto error_3;
diff -uprN -X linux-2.6.17-rc5-mm1/Documentation/dontdiff linux-2.6.17-rc5-mm1.orig/security/keys/keyring.c linux-2.6.17-rc5-mm1/security/keys/keyring.c
--- linux-2.6.17-rc5-mm1.orig/security/keys/keyring.c	2006-05-31 09:48:49.000000000 -0400
+++ linux-2.6.17-rc5-mm1/security/keys/keyring.c	2006-05-31 10:03:00.000000000 -0400
@@ -240,13 +240,14 @@ static long keyring_read(const struct ke
  * allocate a keyring and link into the destination keyring
  */
 struct key *keyring_alloc(const char *description, uid_t uid, gid_t gid,
-			  int not_in_quota, struct key *dest)
+			  struct task_struct *ctx, int not_in_quota,
+			  struct key *dest)
 {
 	struct key *keyring;
 	int ret;
 
 	keyring = key_alloc(&key_type_keyring, description,
-			    uid, gid,
+			    uid, gid, ctx,
 			    (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_ALL,
 			    not_in_quota);
 
diff -uprN -X linux-2.6.17-rc5-mm1/Documentation/dontdiff linux-2.6.17-rc5-mm1.orig/security/keys/process_keys.c linux-2.6.17-rc5-mm1/security/keys/process_keys.c
--- linux-2.6.17-rc5-mm1.orig/security/keys/process_keys.c	2006-05-31 09:48:49.000000000 -0400
+++ linux-2.6.17-rc5-mm1/security/keys/process_keys.c	2006-05-31 10:03:00.000000000 -0400
@@ -67,7 +67,8 @@ struct key root_session_keyring = {
 /*
  * allocate the keyrings to be associated with a UID
  */
-int alloc_uid_keyring(struct user_struct *user)
+int alloc_uid_keyring(struct user_struct *user,
+		      struct task_struct *ctx)
 {
 	struct key *uid_keyring, *session_keyring;
 	char buf[20];
@@ -76,7 +77,7 @@ int alloc_uid_keyring(struct user_struct
 	/* concoct a default session keyring */
 	sprintf(buf, "_uid_ses.%u", user->uid);
 
-	session_keyring = keyring_alloc(buf, user->uid, (gid_t) -1, 0, NULL);
+	session_keyring = keyring_alloc(buf, user->uid, (gid_t) -1, ctx, 0, NULL);
 	if (IS_ERR(session_keyring)) {
 		ret = PTR_ERR(session_keyring);
 		goto error;
@@ -86,7 +87,7 @@ int alloc_uid_keyring(struct user_struct
 	 * keyring */
 	sprintf(buf, "_uid.%u", user->uid);
 
-	uid_keyring = keyring_alloc(buf, user->uid, (gid_t) -1, 0,
+	uid_keyring = keyring_alloc(buf, user->uid, (gid_t) -1, ctx, 0,
 				    session_keyring);
 	if (IS_ERR(uid_keyring)) {
 		key_put(session_keyring);
@@ -143,7 +144,7 @@ int install_thread_keyring(struct task_s
 
 	sprintf(buf, "_tid.%u", tsk->pid);
 
-	keyring = keyring_alloc(buf, tsk->uid, tsk->gid, 1, NULL);
+	keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk, 1, NULL);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
 		goto error;
@@ -177,7 +178,7 @@ int install_process_keyring(struct task_
 	if (!tsk->signal->process_keyring) {
 		sprintf(buf, "_pid.%u", tsk->tgid);
 
-		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, 1, NULL);
+		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk, 1, NULL);
 		if (IS_ERR(keyring)) {
 			ret = PTR_ERR(keyring);
 			goto error;
@@ -217,7 +218,7 @@ static int install_session_keyring(struc
 	if (!keyring) {
 		sprintf(buf, "_ses.%u", tsk->tgid);
 
-		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, 1, NULL);
+		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk, 1, NULL);
 		if (IS_ERR(keyring))
 			return PTR_ERR(keyring);
 	}
@@ -727,7 +728,7 @@ long join_session_keyring(const char *na
 	keyring = find_keyring_by_name(name, 0);
 	if (PTR_ERR(keyring) == -ENOKEY) {
 		/* not found - try and create a new one */
-		keyring = keyring_alloc(name, tsk->uid, tsk->gid, 0, NULL);
+		keyring = keyring_alloc(name, tsk->uid, tsk->gid, tsk, 0, NULL);
 		if (IS_ERR(keyring)) {
 			ret = PTR_ERR(keyring);
 			goto error2;
diff -uprN -X linux-2.6.17-rc5-mm1/Documentation/dontdiff linux-2.6.17-rc5-mm1.orig/security/keys/request_key_auth.c linux-2.6.17-rc5-mm1/security/keys/request_key_auth.c
--- linux-2.6.17-rc5-mm1.orig/security/keys/request_key_auth.c	2006-05-31 09:48:49.000000000 -0400
+++ linux-2.6.17-rc5-mm1/security/keys/request_key_auth.c	2006-05-31 10:03:00.000000000 -0400
@@ -185,7 +185,7 @@ struct key *request_key_auth_new(struct 
 	sprintf(desc, "%x", target->serial);
 
 	authkey = key_alloc(&key_type_request_key_auth, desc,
-			    current->fsuid, current->fsgid,
+			    current->fsuid, current->fsgid, current,
 			    KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH |
 			    KEY_USR_VIEW, 1);
 	if (IS_ERR(authkey)) {
diff -uprN -X linux-2.6.17-rc5-mm1/Documentation/dontdiff linux-2.6.17-rc5-mm1.orig/security/keys/request_key.c linux-2.6.17-rc5-mm1/security/keys/request_key.c
--- linux-2.6.17-rc5-mm1.orig/security/keys/request_key.c	2006-05-31 09:48:49.000000000 -0400
+++ linux-2.6.17-rc5-mm1/security/keys/request_key.c	2006-05-31 10:03:00.000000000 -0400
@@ -48,7 +48,8 @@ static int call_sbin_request_key(struct 
 	/* allocate a new session keyring */
 	sprintf(desc, "_req.%u", key->serial);
 
-	keyring = keyring_alloc(desc, current->fsuid, current->fsgid, 1, NULL);
+	keyring = keyring_alloc(desc, current->fsuid, current->fsgid,
+				current, 1, NULL);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
 		goto error_alloc;
@@ -137,7 +138,8 @@ static struct key *__request_key_constru
 
 	/* create a key and add it to the queue */
 	key = key_alloc(type, description,
-			current->fsuid, current->fsgid, KEY_POS_ALL, 0);
+			current->fsuid, current->fsgid,
+			current, KEY_POS_ALL, 0);
 	if (IS_ERR(key))
 		goto alloc_failed;
 
diff -uprN -X linux-2.6.17-rc5-mm1/Documentation/dontdiff linux-2.6.17-rc5-mm1.orig/security/selinux/hooks.c linux-2.6.17-rc5-mm1/security/selinux/hooks.c
--- linux-2.6.17-rc5-mm1.orig/security/selinux/hooks.c	2006-05-31 09:48:49.000000000 -0400
+++ linux-2.6.17-rc5-mm1/security/selinux/hooks.c	2006-06-01 11:32:19.000000000 -0400
@@ -4252,6 +4252,57 @@ static int selinux_setprocattr(struct ta
 	return size;
 }
 
+#ifdef CONFIG_KEYS
+
+static int selinux_key_alloc(struct key *k, struct task_struct *tsk)
+{
+	struct task_security_struct *tsec = tsk->security;
+	struct key_security_struct *ksec;
+
+	ksec = kzalloc(sizeof(struct key_security_struct), GFP_KERNEL);
+	if (!ksec)
+		return -ENOMEM;
+
+	ksec->obj = k;
+	ksec->sid = tsec->sid;
+	k->security = ksec;
+
+	return 0;
+}
+
+static void selinux_key_free(struct key *k)
+{
+	struct key_security_struct *ksec = k->security;
+
+	k->security = NULL;
+	kfree(ksec);
+}
+
+static int selinux_key_permission(key_ref_t key_ref,
+			    struct task_struct *ctx,
+			    key_perm_t perm)
+{
+	struct key *key;
+	struct task_security_struct *tsec;
+	struct key_security_struct *ksec;
+
+	key = key_ref_to_ptr(key_ref);
+
+	tsec = ctx->security;
+	ksec = key->security;
+
+	/* if no specific permissions are requested, we skip the
+	   permission check. No serious, additional covert channels
+	   appear to be created. */
+	if (perm == 0)
+		return 0;
+
+	return avc_has_perm(tsec->sid, ksec->sid,
+			    SECCLASS_KEY, perm, NULL);
+}
+
+#endif
+
 static struct security_operations selinux_ops = {
 	.ptrace =			selinux_ptrace,
 	.capget =			selinux_capget,
@@ -4404,6 +4455,12 @@ static struct security_operations selinu
 	.xfrm_state_free_security =	selinux_xfrm_state_free,
 	.xfrm_policy_lookup = 		selinux_xfrm_policy_lookup,
 #endif
+
+#ifdef CONFIG_KEYS
+	.key_alloc =                    selinux_key_alloc,
+	.key_free =                     selinux_key_free,
+	.key_permission =               selinux_key_permission,
+#endif
 };
 
 static __init int selinux_init(void)
@@ -4439,6 +4496,13 @@ static __init int selinux_init(void)
 	} else {
 		printk(KERN_INFO "SELinux:  Starting in permissive mode\n");
 	}
+
+#ifdef CONFIG_KEYS
+	/* Add security information to initial keyrings */
+	security_key_alloc(&root_user_keyring, current);
+	security_key_alloc(&root_session_keyring, current);
+#endif
+
 	return 0;
 }
 
diff -uprN -X linux-2.6.17-rc5-mm1/Documentation/dontdiff linux-2.6.17-rc5-mm1.orig/security/selinux/include/av_permissions.h linux-2.6.17-rc5-mm1/security/selinux/include/av_permissions.h
--- linux-2.6.17-rc5-mm1.orig/security/selinux/include/av_permissions.h	2006-05-31 09:48:49.000000000 -0400
+++ linux-2.6.17-rc5-mm1/security/selinux/include/av_permissions.h	2006-06-01 10:42:18.000000000 -0400
@@ -959,3 +959,11 @@
 #define PACKET__SEND                              0x00000001UL
 #define PACKET__RECV                              0x00000002UL
 #define PACKET__RELABELTO                         0x00000004UL
+
+#define KEY__VIEW                                 0x00000001UL
+#define KEY__READ                                 0x00000002UL
+#define KEY__WRITE                                0x00000004UL
+#define KEY__SEARCH                               0x00000008UL
+#define KEY__LINK                                 0x00000010UL
+#define KEY__SETATTR                              0x00000020UL
+
diff -uprN -X linux-2.6.17-rc5-mm1/Documentation/dontdiff linux-2.6.17-rc5-mm1.orig/security/selinux/include/av_perm_to_string.h linux-2.6.17-rc5-mm1/security/selinux/include/av_perm_to_string.h
--- linux-2.6.17-rc5-mm1.orig/security/selinux/include/av_perm_to_string.h	2006-05-31 09:48:49.000000000 -0400
+++ linux-2.6.17-rc5-mm1/security/selinux/include/av_perm_to_string.h	2006-06-01 10:42:18.000000000 -0400
@@ -242,3 +242,9 @@
    S_(SECCLASS_PACKET, PACKET__SEND, "send")
    S_(SECCLASS_PACKET, PACKET__RECV, "recv")
    S_(SECCLASS_PACKET, PACKET__RELABELTO, "relabelto")
+   S_(SECCLASS_KEY, KEY__VIEW, "view")
+   S_(SECCLASS_KEY, KEY__READ, "read")
+   S_(SECCLASS_KEY, KEY__WRITE, "write")
+   S_(SECCLASS_KEY, KEY__SEARCH, "search")
+   S_(SECCLASS_KEY, KEY__LINK, "link")
+   S_(SECCLASS_KEY, KEY__SETATTR, "setattr")
diff -uprN -X linux-2.6.17-rc5-mm1/Documentation/dontdiff linux-2.6.17-rc5-mm1.orig/security/selinux/include/class_to_string.h linux-2.6.17-rc5-mm1/security/selinux/include/class_to_string.h
--- linux-2.6.17-rc5-mm1.orig/security/selinux/include/class_to_string.h	2006-05-31 09:48:49.000000000 -0400
+++ linux-2.6.17-rc5-mm1/security/selinux/include/class_to_string.h	2006-06-01 10:42:18.000000000 -0400
@@ -60,3 +60,4 @@
     S_("netlink_kobject_uevent_socket")
     S_("appletalk_socket")
     S_("packet")
+    S_("key")
diff -uprN -X linux-2.6.17-rc5-mm1/Documentation/dontdiff linux-2.6.17-rc5-mm1.orig/security/selinux/include/flask.h linux-2.6.17-rc5-mm1/security/selinux/include/flask.h
--- linux-2.6.17-rc5-mm1.orig/security/selinux/include/flask.h	2006-05-31 09:48:49.000000000 -0400
+++ linux-2.6.17-rc5-mm1/security/selinux/include/flask.h	2006-06-01 10:42:18.000000000 -0400
@@ -62,6 +62,7 @@
 #define SECCLASS_NETLINK_KOBJECT_UEVENT_SOCKET           55
 #define SECCLASS_APPLETALK_SOCKET                        56
 #define SECCLASS_PACKET                                  57
+#define SECCLASS_KEY                                     58
 
 /*
  * Security identifier indices for initial entities
diff -uprN -X linux-2.6.17-rc5-mm1/Documentation/dontdiff linux-2.6.17-rc5-mm1.orig/security/selinux/include/objsec.h linux-2.6.17-rc5-mm1/security/selinux/include/objsec.h
--- linux-2.6.17-rc5-mm1.orig/security/selinux/include/objsec.h	2006-05-31 09:48:49.000000000 -0400
+++ linux-2.6.17-rc5-mm1/security/selinux/include/objsec.h	2006-05-31 10:03:00.000000000 -0400
@@ -99,6 +99,11 @@ struct sk_security_struct {
 	u32 peer_sid;			/* SID of peer */
 };
 
+struct key_security_struct {
+	struct key *obj; /* back pointer */
+	u32 sid;         /* SID of key */
+};
+
 extern unsigned int selinux_checkreqprot;
 
 #endif /* _SELINUX_OBJSEC_H_ */



