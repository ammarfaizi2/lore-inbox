Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWFTRhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWFTRhp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWFTRhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:37:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3282 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750706AbWFTRhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:37:43 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/6] Keys: Sort out key quota system [try #3]
Date: Tue, 20 Jun 2006 18:37:38 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, keyrings@linux-nfs.org
Message-Id: <20060620173737.5034.41429.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060620173735.5034.11436.stgit@warthog.cambridge.redhat.com>
References: <20060620173735.5034.11436.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The attached patch adds the ability for key creation to overrun the user's
quota in some circumstances - notably when a session keyring is created and
assigned to a process that didn't previously have one.

This means it's still possible to log in, should PAM require the creation of a
new session keyring, and fix an overburdened key quota.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/key.h              |   13 ++++++++++---
 include/linux/security.h         |   11 +++++++----
 security/dummy.c                 |    3 ++-
 security/keys/internal.h         |    3 ++-
 security/keys/key.c              |   26 ++++++++++++++------------
 security/keys/keyctl.c           |    5 +++--
 security/keys/keyring.c          |    4 ++--
 security/keys/process_keys.c     |   24 +++++++++++++++++-------
 security/keys/request_key.c      |   36 +++++++++++++++++++++---------------
 security/keys/request_key_auth.c |    2 +-
 security/selinux/hooks.c         |    9 ++++++---
 11 files changed, 85 insertions(+), 51 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index e81ebf9..e693e72 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -248,7 +248,14 @@ extern struct key *key_alloc(struct key_
 			     const char *desc,
 			     uid_t uid, gid_t gid,
 			     struct task_struct *ctx,
-			     key_perm_t perm, int not_in_quota);
+			     key_perm_t perm,
+			     unsigned long flags);
+
+
+#define KEY_ALLOC_IN_QUOTA	0x0000	/* add to quota, reject if would overrun */
+#define KEY_ALLOC_QUOTA_OVERRUN	0x0001	/* add to quota, permit even if overrun */
+#define KEY_ALLOC_NOT_IN_QUOTA	0x0002	/* not in quota */
+
 extern int key_payload_reserve(struct key *key, size_t datalen);
 extern int key_instantiate_and_link(struct key *key,
 				    const void *data,
@@ -285,7 +292,7 @@ extern key_ref_t key_create_or_update(ke
 				      const char *description,
 				      const void *payload,
 				      size_t plen,
-				      int not_in_quota);
+				      unsigned long flags);
 
 extern int key_update(key_ref_t key,
 		      const void *payload,
@@ -299,7 +306,7 @@ extern int key_unlink(struct key *keyrin
 
 extern struct key *keyring_alloc(const char *description, uid_t uid, gid_t gid,
 				 struct task_struct *ctx,
-				 int not_in_quota,
+				 unsigned long flags,
 				 struct key *dest);
 
 extern int keyring_clear(struct key *keyring);
diff --git a/include/linux/security.h b/include/linux/security.h
index 383c320..d4aa1bf 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -853,6 +853,7 @@ #ifdef CONFIG_SECURITY
  *	Permit allocation of a key and assign security data. Note that key does
  *	not have a serial number assigned at this point.
  *	@key points to the key.
+ *	@flags is the allocation flags
  *	Return 0 if permission is granted, -ve error otherwise.
  * @key_free:
  *	Notification of destruction; free security data.
@@ -1313,7 +1314,7 @@ #endif	/* CONFIG_SECURITY_NETWORK_XFRM *
 
 	/* key management security hooks */
 #ifdef CONFIG_KEYS
-	int (*key_alloc)(struct key *key, struct task_struct *tsk);
+	int (*key_alloc)(struct key *key, struct task_struct *tsk, unsigned long flags);
 	void (*key_free)(struct key *key);
 	int (*key_permission)(key_ref_t key_ref,
 			      struct task_struct *context,
@@ -3009,9 +3010,10 @@ #endif	/* CONFIG_SECURITY_NETWORK_XFRM *
 #ifdef CONFIG_KEYS
 #ifdef CONFIG_SECURITY
 static inline int security_key_alloc(struct key *key,
-				     struct task_struct *tsk)
+				     struct task_struct *tsk,
+				     unsigned long flags)
 {
-	return security_ops->key_alloc(key, tsk);
+	return security_ops->key_alloc(key, tsk, flags);
 }
 
 static inline void security_key_free(struct key *key)
@@ -3029,7 +3031,8 @@ static inline int security_key_permissio
 #else
 
 static inline int security_key_alloc(struct key *key,
-				     struct task_struct *tsk)
+				     struct task_struct *tsk,
+				     unsigned long flags)
 {
 	return 0;
 }
diff --git a/security/dummy.c b/security/dummy.c
index c98d553..93a9180 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -860,7 +860,8 @@ static int dummy_setprocattr(struct task
 }
 
 #ifdef CONFIG_KEYS
-static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx)
+static inline int dummy_key_alloc(struct key *key, struct task_struct *ctx,
+				  unsigned long flags)
 {
 	return 0;
 }
diff --git a/security/keys/internal.h b/security/keys/internal.h
index e066e60..3c2877f 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -99,7 +99,8 @@ extern int install_process_keyring(struc
 extern struct key *request_key_and_link(struct key_type *type,
 					const char *description,
 					const char *callout_info,
-					struct key *dest_keyring);
+					struct key *dest_keyring,
+					unsigned long flags);
 
 /*
  * request_key authorisation
diff --git a/security/keys/key.c b/security/keys/key.c
index 9ef9e5b..a9b6ca7 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -248,7 +248,7 @@ static inline void key_alloc_serial(stru
  */
 struct key *key_alloc(struct key_type *type, const char *desc,
 		      uid_t uid, gid_t gid, struct task_struct *ctx,
-		      key_perm_t perm, int not_in_quota)
+		      key_perm_t perm, unsigned long flags)
 {
 	struct key_user *user = NULL;
 	struct key *key;
@@ -269,12 +269,14 @@ struct key *key_alloc(struct key_type *t
 
 	/* check that the user's quota permits allocation of another key and
 	 * its description */
-	if (!not_in_quota) {
+	if (!(flags & KEY_ALLOC_NOT_IN_QUOTA)) {
 		spin_lock(&user->lock);
-		if (user->qnkeys + 1 >= KEYQUOTA_MAX_KEYS ||
-		    user->qnbytes + quotalen >= KEYQUOTA_MAX_BYTES
-		    )
-			goto no_quota;
+		if (!(flags & KEY_ALLOC_QUOTA_OVERRUN)) {
+			if (user->qnkeys + 1 >= KEYQUOTA_MAX_KEYS ||
+			    user->qnbytes + quotalen >= KEYQUOTA_MAX_BYTES
+			    )
+				goto no_quota;
+		}
 
 		user->qnkeys++;
 		user->qnbytes += quotalen;
@@ -308,7 +310,7 @@ struct key *key_alloc(struct key_type *t
 	key->payload.data = NULL;
 	key->security = NULL;
 
-	if (!not_in_quota)
+	if (!(flags & KEY_ALLOC_NOT_IN_QUOTA))
 		key->flags |= 1 << KEY_FLAG_IN_QUOTA;
 
 	memset(&key->type_data, 0, sizeof(key->type_data));
@@ -318,7 +320,7 @@ #ifdef KEY_DEBUGGING
 #endif
 
 	/* let the security module know about the key */
-	ret = security_key_alloc(key, ctx);
+	ret = security_key_alloc(key, ctx, flags);
 	if (ret < 0)
 		goto security_error;
 
@@ -332,7 +334,7 @@ error:
 security_error:
 	kfree(key->description);
 	kmem_cache_free(key_jar, key);
-	if (!not_in_quota) {
+	if (!(flags & KEY_ALLOC_NOT_IN_QUOTA)) {
 		spin_lock(&user->lock);
 		user->qnkeys--;
 		user->qnbytes -= quotalen;
@@ -345,7 +347,7 @@ security_error:
 no_memory_3:
 	kmem_cache_free(key_jar, key);
 no_memory_2:
-	if (!not_in_quota) {
+	if (!(flags & KEY_ALLOC_NOT_IN_QUOTA)) {
 		spin_lock(&user->lock);
 		user->qnkeys--;
 		user->qnbytes -= quotalen;
@@ -761,7 +763,7 @@ key_ref_t key_create_or_update(key_ref_t
 			       const char *description,
 			       const void *payload,
 			       size_t plen,
-			       int not_in_quota)
+			       unsigned long flags)
 {
 	struct key_type *ktype;
 	struct key *keyring, *key = NULL;
@@ -822,7 +824,7 @@ key_ref_t key_create_or_update(key_ref_t
 
 	/* allocate a new key */
 	key = key_alloc(ktype, description, current->fsuid, current->fsgid,
-			current, perm, not_in_quota);
+			current, perm, flags);
 	if (IS_ERR(key)) {
 		key_ref = ERR_PTR(PTR_ERR(key));
 		goto error_3;
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index ed71d86..d744585 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -102,7 +102,7 @@ asmlinkage long sys_add_key(const char _
 	/* create or update the requested key and add it to the target
 	 * keyring */
 	key_ref = key_create_or_update(keyring_ref, type, description,
-				       payload, plen, 0);
+				       payload, plen, KEY_ALLOC_IN_QUOTA);
 	if (!IS_ERR(key_ref)) {
 		ret = key_ref_to_ptr(key_ref)->serial;
 		key_ref_put(key_ref);
@@ -184,7 +184,8 @@ asmlinkage long sys_request_key(const ch
 
 	/* do the search */
 	key = request_key_and_link(ktype, description, callout_info,
-				   key_ref_to_ptr(dest_ref));
+				   key_ref_to_ptr(dest_ref),
+				   KEY_ALLOC_IN_QUOTA);
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
 		goto error5;
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 1357207..6c282bd 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -240,7 +240,7 @@ static long keyring_read(const struct ke
  * allocate a keyring and link into the destination keyring
  */
 struct key *keyring_alloc(const char *description, uid_t uid, gid_t gid,
-			  struct task_struct *ctx, int not_in_quota,
+			  struct task_struct *ctx, unsigned long flags,
 			  struct key *dest)
 {
 	struct key *keyring;
@@ -249,7 +249,7 @@ struct key *keyring_alloc(const char *de
 	keyring = key_alloc(&key_type_keyring, description,
 			    uid, gid, ctx,
 			    (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_ALL,
-			    not_in_quota);
+			    flags);
 
 	if (!IS_ERR(keyring)) {
 		ret = key_instantiate_and_link(keyring, NULL, 0, dest, NULL);
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index e4eddbb..f5fbc37 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -77,7 +77,8 @@ int alloc_uid_keyring(struct user_struct
 	/* concoct a default session keyring */
 	sprintf(buf, "_uid_ses.%u", user->uid);
 
-	session_keyring = keyring_alloc(buf, user->uid, (gid_t) -1, ctx, 0, NULL);
+	session_keyring = keyring_alloc(buf, user->uid, (gid_t) -1, ctx,
+					KEY_ALLOC_IN_QUOTA, NULL);
 	if (IS_ERR(session_keyring)) {
 		ret = PTR_ERR(session_keyring);
 		goto error;
@@ -87,8 +88,8 @@ int alloc_uid_keyring(struct user_struct
 	 * keyring */
 	sprintf(buf, "_uid.%u", user->uid);
 
-	uid_keyring = keyring_alloc(buf, user->uid, (gid_t) -1, ctx, 0,
-				    session_keyring);
+	uid_keyring = keyring_alloc(buf, user->uid, (gid_t) -1, ctx,
+				    KEY_ALLOC_IN_QUOTA, session_keyring);
 	if (IS_ERR(uid_keyring)) {
 		key_put(session_keyring);
 		ret = PTR_ERR(uid_keyring);
@@ -144,7 +145,8 @@ int install_thread_keyring(struct task_s
 
 	sprintf(buf, "_tid.%u", tsk->pid);
 
-	keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk, 1, NULL);
+	keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk,
+				KEY_ALLOC_QUOTA_OVERRUN, NULL);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
 		goto error;
@@ -178,7 +180,8 @@ int install_process_keyring(struct task_
 	if (!tsk->signal->process_keyring) {
 		sprintf(buf, "_pid.%u", tsk->tgid);
 
-		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk, 1, NULL);
+		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk,
+					KEY_ALLOC_QUOTA_OVERRUN, NULL);
 		if (IS_ERR(keyring)) {
 			ret = PTR_ERR(keyring);
 			goto error;
@@ -209,6 +212,7 @@ error:
 static int install_session_keyring(struct task_struct *tsk,
 				   struct key *keyring)
 {
+	unsigned long flags;
 	struct key *old;
 	char buf[20];
 
@@ -218,7 +222,12 @@ static int install_session_keyring(struc
 	if (!keyring) {
 		sprintf(buf, "_ses.%u", tsk->tgid);
 
-		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk, 1, NULL);
+		flags = KEY_ALLOC_QUOTA_OVERRUN;
+		if (tsk->signal->session_keyring)
+			flags = KEY_ALLOC_IN_QUOTA;
+
+		keyring = keyring_alloc(buf, tsk->uid, tsk->gid, tsk,
+					flags, NULL);
 		if (IS_ERR(keyring))
 			return PTR_ERR(keyring);
 	}
@@ -729,7 +738,8 @@ long join_session_keyring(const char *na
 	keyring = find_keyring_by_name(name, 0);
 	if (PTR_ERR(keyring) == -ENOKEY) {
 		/* not found - try and create a new one */
-		keyring = keyring_alloc(name, tsk->uid, tsk->gid, tsk, 0, NULL);
+		keyring = keyring_alloc(name, tsk->uid, tsk->gid, tsk,
+					KEY_ALLOC_IN_QUOTA, NULL);
 		if (IS_ERR(keyring)) {
 			ret = PTR_ERR(keyring);
 			goto error2;
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index eab66a0..58d1efd 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -48,8 +48,8 @@ static int call_sbin_request_key(struct 
 	/* allocate a new session keyring */
 	sprintf(desc, "_req.%u", key->serial);
 
-	keyring = keyring_alloc(desc, current->fsuid, current->fsgid,
-				current, 1, NULL);
+	keyring = keyring_alloc(desc, current->fsuid, current->fsgid, current,
+				KEY_ALLOC_QUOTA_OVERRUN, NULL);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
 		goto error_alloc;
@@ -126,7 +126,8 @@ error_alloc:
  */
 static struct key *__request_key_construction(struct key_type *type,
 					      const char *description,
-					      const char *callout_info)
+					      const char *callout_info,
+					      unsigned long flags)
 {
 	request_key_actor_t actor;
 	struct key_construction cons;
@@ -134,12 +135,12 @@ static struct key *__request_key_constru
 	struct key *key, *authkey;
 	int ret, negated;
 
-	kenter("%s,%s,%s", type->name, description, callout_info);
+	kenter("%s,%s,%s,%lx", type->name, description, callout_info, flags);
 
 	/* create a key and add it to the queue */
 	key = key_alloc(type, description,
-			current->fsuid, current->fsgid,
-			current, KEY_POS_ALL, 0);
+			current->fsuid, current->fsgid, current, KEY_POS_ALL,
+			flags);
 	if (IS_ERR(key))
 		goto alloc_failed;
 
@@ -258,15 +259,16 @@ alloc_failed:
 static struct key *request_key_construction(struct key_type *type,
 					    const char *description,
 					    struct key_user *user,
-					    const char *callout_info)
+					    const char *callout_info,
+					    unsigned long flags)
 {
 	struct key_construction *pcons;
 	struct key *key, *ckey;
 
 	DECLARE_WAITQUEUE(myself, current);
 
-	kenter("%s,%s,{%d},%s",
-	       type->name, description, user->uid, callout_info);
+	kenter("%s,%s,{%d},%s,%lx",
+	       type->name, description, user->uid, callout_info, flags);
 
 	/* see if there's such a key under construction already */
 	down_write(&key_construction_sem);
@@ -282,7 +284,8 @@ static struct key *request_key_construct
 	}
 
 	/* see about getting userspace to construct the key */
-	key = __request_key_construction(type, description, callout_info);
+	key = __request_key_construction(type, description, callout_info,
+					 flags);
  error:
 	kleave(" = %p", key);
 	return key;
@@ -389,14 +392,15 @@ static void request_key_link(struct key 
 struct key *request_key_and_link(struct key_type *type,
 				 const char *description,
 				 const char *callout_info,
-				 struct key *dest_keyring)
+				 struct key *dest_keyring,
+				 unsigned long flags)
 {
 	struct key_user *user;
 	struct key *key;
 	key_ref_t key_ref;
 
-	kenter("%s,%s,%s,%p",
-	       type->name, description, callout_info, dest_keyring);
+	kenter("%s,%s,%s,%p,%lx",
+	       type->name, description, callout_info, dest_keyring, flags);
 
 	/* search all the process keyrings for a key */
 	key_ref = search_process_keyrings(type, description, type->match,
@@ -429,7 +433,8 @@ struct key *request_key_and_link(struct 
 			/* ask userspace (returns NULL if it waited on a key
 			 * being constructed) */
 			key = request_key_construction(type, description,
-						       user, callout_info);
+						       user, callout_info,
+						       flags);
 			if (key)
 				break;
 
@@ -485,7 +490,8 @@ struct key *request_key(struct key_type 
 			const char *description,
 			const char *callout_info)
 {
-	return request_key_and_link(type, description, callout_info, NULL);
+	return request_key_and_link(type, description, callout_info, NULL,
+				    KEY_ALLOC_IN_QUOTA);
 
 } /* end request_key() */
 
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index cb9817c..cbf58a9 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -187,7 +187,7 @@ struct key *request_key_auth_new(struct 
 	authkey = key_alloc(&key_type_request_key_auth, desc,
 			    current->fsuid, current->fsgid, current,
 			    KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH |
-			    KEY_USR_VIEW, 1);
+			    KEY_USR_VIEW, KEY_ALLOC_NOT_IN_QUOTA);
 	if (IS_ERR(authkey)) {
 		ret = PTR_ERR(authkey);
 		goto error_alloc;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 093efba..f80c74d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4254,7 +4254,8 @@ static int selinux_setprocattr(struct ta
 
 #ifdef CONFIG_KEYS
 
-static int selinux_key_alloc(struct key *k, struct task_struct *tsk)
+static int selinux_key_alloc(struct key *k, struct task_struct *tsk,
+			     unsigned long flags)
 {
 	struct task_security_struct *tsec = tsk->security;
 	struct key_security_struct *ksec;
@@ -4501,8 +4502,10 @@ static __init int selinux_init(void)
 
 #ifdef CONFIG_KEYS
 	/* Add security information to initial keyrings */
-	security_key_alloc(&root_user_keyring, current);
-	security_key_alloc(&root_session_keyring, current);
+	security_key_alloc(&root_user_keyring, current,
+			   KEY_ALLOC_NOT_IN_QUOTA);
+	security_key_alloc(&root_session_keyring, current,
+			   KEY_ALLOC_NOT_IN_QUOTA);
 #endif
 
 	return 0;

