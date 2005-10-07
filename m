Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbVJGP6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbVJGP6E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 11:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbVJGP6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 11:58:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28395 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030470AbVJGP6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 11:58:01 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <19008.1128699684@warthog.cambridge.redhat.com> 
References: <19008.1128699684@warthog.cambridge.redhat.com>  <11615.1128694058@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org
Cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Add LSM hooks for key management [try #2]
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 07 Oct 2005 16:57:45 +0100
Message-ID: <26883.1128700665@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch adds LSM hooks for key management facilities. The notable
changes are:

 (1) The key struct now supports a security pointer for the use of security
     modules. This will permit key labelling and restrictions on which
     programs may access a key.

 (2) Security modules get a chance to note (or abort) the allocation of a key.

 (3) The key permission checking can now be enhanced by the security modules;
     the permissions check consults LSM if all other checks bear out.

 (4) The key permissions checking functions now return an error code rather
     than a boolean value.

 (5) An extra permission has been added to govern the modification of
     attributes (UID, GID, permissions).

Note that there isn't an LSM hook specifically for each keyctl() operation,
but rather the permissions hook allows control of individual operations based
on the permission request bits.

Key management access control through LSM is enabled by automatically if both
CONFIG_KEYS and CONFIG_SECURITY are enabled.

This should be applied on top of the patch ensubjected:

	[PATCH] Keys: Possessor permissions should be additive


Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-lsm-2614rc3-2.diff
 Documentation/keys.txt       |   22 +++++++-----
 include/linux/key-ui.h       |    3 +
 include/linux/key.h          |   13 +++++--
 include/linux/security.h     |   73 +++++++++++++++++++++++++++++++++++++++++++
 security/dummy.c             |   23 +++++++++++++
 security/keys/key.c          |   56 +++++++++++++++++++++++---------
 security/keys/keyctl.c       |   13 ++++---
 security/keys/keyring.c      |   21 +++++++-----
 security/keys/permission.c   |    7 +++-
 security/keys/process_keys.c |    9 ++---
 10 files changed, 191 insertions(+), 49 deletions(-)

diff -uNrp linux-2.6.14-rc3-keys-addperm/Documentation/keys.txt linux-2.6.14-rc3-keys-lsm/Documentation/keys.txt
--- linux-2.6.14-rc3-keys-addperm/Documentation/keys.txt	2005-10-07 14:46:31.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/Documentation/keys.txt	2005-10-07 16:33:26.000000000 +0100
@@ -196,7 +196,7 @@ KEY ACCESS PERMISSIONS
 
 Keys have an owner user ID, a group access ID, and a permissions mask. The mask
 has up to eight bits each for possessor, user, group and other access. Only
-five of each set of eight bits are defined. These permissions granted are:
+six of each set of eight bits are defined. These permissions granted are:
 
  (*) View
 
@@ -224,6 +224,10 @@ five of each set of eight bits are defin
      keyring to a key, a process must have Write permission on the keyring and
      Link permission on the key.
 
+ (*) Set Attribute
+
+     This permits a key's UID, GID and permissions mask to be changed.
+
 For changing the ownership, group ID or permissions mask, being the owner of
 the key or having the sysadmin capability is sufficient.
 
@@ -242,15 +246,15 @@ about the status of the key service:
      this way:
 
 	SERIAL   FLAGS  USAGE EXPY PERM     UID   GID   TYPE      DESCRIPTION: SUMMARY
-	00000001 I-----    39 perm 1f1f0000     0     0 keyring   _uid_ses.0: 1/4
-	00000002 I-----     2 perm 1f1f0000     0     0 keyring   _uid.0: empty
-	00000007 I-----     1 perm 1f1f0000     0     0 keyring   _pid.1: empty
-	0000018d I-----     1 perm 1f1f0000     0     0 keyring   _pid.412: empty
-	000004d2 I--Q--     1 perm 1f1f0000    32    -1 keyring   _uid.32: 1/4
-	000004d3 I--Q--     3 perm 1f1f0000    32    -1 keyring   _uid_ses.32: empty
+	00000001 I-----    39 perm 1f3f0000     0     0 keyring   _uid_ses.0: 1/4
+	00000002 I-----     2 perm 1f3f0000     0     0 keyring   _uid.0: empty
+	00000007 I-----     1 perm 1f3f0000     0     0 keyring   _pid.1: empty
+	0000018d I-----     1 perm 1f3f0000     0     0 keyring   _pid.412: empty
+	000004d2 I--Q--     1 perm 1f3f0000    32    -1 keyring   _uid.32: 1/4
+	000004d3 I--Q--     3 perm 1f3f0000    32    -1 keyring   _uid_ses.32: empty
 	00000892 I--QU-     1 perm 1f000000     0     0 user      metal:copper: 0
-	00000893 I--Q-N     1  35s 1f1f0000     0     0 user      metal:silver: 0
-	00000894 I--Q--     1  10h 001f0000     0     0 user      metal:gold: 0
+	00000893 I--Q-N     1  35s 1f3f0000     0     0 user      metal:silver: 0
+	00000894 I--Q--     1  10h 003f0000     0     0 user      metal:gold: 0
 
      The flags are:
 
diff -uNrp linux-2.6.14-rc3-keys-addperm/include/linux/key.h linux-2.6.14-rc3-keys-lsm/include/linux/key.h
--- linux-2.6.14-rc3-keys-addperm/include/linux/key.h	2005-10-05 11:50:22.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/include/linux/key.h	2005-10-07 15:46:29.000000000 +0100
@@ -40,28 +40,32 @@ struct key;
 #define KEY_POS_WRITE	0x04000000	/* possessor can update key payload / add link to keyring */
 #define KEY_POS_SEARCH	0x08000000	/* possessor can find a key in search / search a keyring */
 #define KEY_POS_LINK	0x10000000	/* possessor can create a link to a key/keyring */
-#define KEY_POS_ALL	0x1f000000
+#define KEY_POS_SETATTR	0x20000000	/* possessor can set key attributes */
+#define KEY_POS_ALL	0x3f000000
 
 #define KEY_USR_VIEW	0x00010000	/* user permissions... */
 #define KEY_USR_READ	0x00020000
 #define KEY_USR_WRITE	0x00040000
 #define KEY_USR_SEARCH	0x00080000
 #define KEY_USR_LINK	0x00100000
-#define KEY_USR_ALL	0x001f0000
+#define KEY_USR_SETATTR	0x00200000
+#define KEY_USR_ALL	0x003f0000
 
 #define KEY_GRP_VIEW	0x00000100	/* group permissions... */
 #define KEY_GRP_READ	0x00000200
 #define KEY_GRP_WRITE	0x00000400
 #define KEY_GRP_SEARCH	0x00000800
 #define KEY_GRP_LINK	0x00001000
-#define KEY_GRP_ALL	0x00001f00
+#define KEY_GRP_SETATTR	0x00002000
+#define KEY_GRP_ALL	0x00003f00
 
 #define KEY_OTH_VIEW	0x00000001	/* third party permissions... */
 #define KEY_OTH_READ	0x00000002
 #define KEY_OTH_WRITE	0x00000004
 #define KEY_OTH_SEARCH	0x00000008
 #define KEY_OTH_LINK	0x00000010
-#define KEY_OTH_ALL	0x0000001f
+#define KEY_OTH_SETATTR	0x00000020
+#define KEY_OTH_ALL	0x0000003f
 
 struct seq_file;
 struct user_struct;
@@ -119,6 +123,7 @@ struct key {
 	struct key_type		*type;		/* type of key */
 	struct rw_semaphore	sem;		/* change vs change sem */
 	struct key_user		*user;		/* owner of this key */
+	void			*security;	/* security data for this key */
 	time_t			expiry;		/* time at which key expires (or 0) */
 	uid_t			uid;
 	gid_t			gid;
diff -uNrp linux-2.6.14-rc3-keys-addperm/include/linux/key-ui.h linux-2.6.14-rc3-keys-lsm/include/linux/key-ui.h
--- linux-2.6.14-rc3-keys-addperm/include/linux/key-ui.h	2005-10-07 14:07:05.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/include/linux/key-ui.h	2005-10-07 16:15:09.000000000 +0100
@@ -24,7 +24,8 @@ extern spinlock_t key_serial_lock;
 #define	KEY_WRITE	0x04	/* require permission to update / modify */
 #define	KEY_SEARCH	0x08	/* require permission to search (keyring) or find (key) */
 #define	KEY_LINK	0x10	/* require permission to link */
-#define	KEY_ALL		0x1f	/* all the above permissions */
+#define	KEY_SETATTR	0x20	/* require permission to change attributes */
+#define	KEY_ALL		0x3f	/* all the above permissions */
 
 /*
  * the keyring payload contains a list of the keys to which the keyring is
diff -uNrp linux-2.6.14-rc3-keys-addperm/include/linux/security.h linux-2.6.14-rc3-keys-lsm/include/linux/security.h
--- linux-2.6.14-rc3-keys-addperm/include/linux/security.h	2005-10-03 10:48:39.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/include/linux/security.h	2005-10-07 16:01:33.000000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/shm.h>
 #include <linux/msg.h>
 #include <linux/sched.h>
+#include <linux/key.h>
 
 struct ctl_table;
 
@@ -785,6 +786,27 @@ struct swap_info_struct;
  * @sk_free_security:
  *	Deallocate security structure.
  *
+ * Security hooks affecting all Key Management operations
+ *
+ * @key_alloc:
+ *	Permit allocation of a key and assign security data. Note that key does
+ *	not have a serial number assigned at this point.
+ *	@key points to the key.
+ *	Return 0 if permission is granted, -ve error otherwise.
+ * @key_free:
+ *	Notification of destruction; free security data.
+ *	@key points to the key.
+ *	No return value.
+ * @key_permission:
+ *	See whether a specific operational right is granted to a process on a
+ *      key.
+ *	@key_ref refers to the key (key pointer + possession attribute bit).
+ *	@context points to the process to provide the context against which to
+ *       evaluate the security data on the key.
+ *	@perm describes the combination of permissions required of this key.
+ *	Return 1 if permission granted, 0 if permission denied and -ve it the
+ *      normal permissions model should be effected.
+ *
  * Security hooks affecting all System V IPC operations.
  *
  * @ipc_permission:
@@ -1213,6 +1235,17 @@ struct security_operations {
 	int (*sk_alloc_security) (struct sock *sk, int family, int priority);
 	void (*sk_free_security) (struct sock *sk);
 #endif	/* CONFIG_SECURITY_NETWORK */
+
+	/* key management security hooks */
+#ifdef CONFIG_KEYS
+	int (*key_alloc)(struct key *key);
+	void (*key_free)(struct key *key);
+	int (*key_permission)(key_ref_t key_ref,
+			      struct task_struct *context,
+			      key_perm_t perm);
+
+#endif	/* CONFIG_KEYS */
+
 };
 
 /* global variables */
@@ -2763,5 +2796,45 @@ static inline void security_sk_free(stru
 }
 #endif	/* CONFIG_SECURITY_NETWORK */
 
+#ifdef CONFIG_KEYS
+#ifdef CONFIG_SECURITY
+static inline int security_key_alloc(struct key *key)
+{
+	return security_ops->key_alloc(key);
+}
+
+static inline void security_key_free(struct key *key)
+{
+	security_ops->key_free(key);
+}
+
+static inline int security_key_permission(key_ref_t key_ref,
+					  struct task_struct *context,
+					  key_perm_t perm)
+{
+	return security_ops->key_permission(key_ref, context, perm);
+}
+
+#else
+
+static inline int security_key_alloc(struct key *key)
+{
+	return 0;
+}
+
+static inline void security_key_free(struct key *key)
+{
+}
+
+static inline int security_key_permission(key_ref_t key_ref,
+					  struct task_struct *context,
+					  key_perm_t perm)
+{
+	return -1;
+}
+
+#endif
+#endif /* CONFIG_KEYS */
+
 #endif /* ! __LINUX_SECURITY_H */
 
diff -uNrp linux-2.6.14-rc3-keys-addperm/security/dummy.c linux-2.6.14-rc3-keys-lsm/security/dummy.c
--- linux-2.6.14-rc3-keys-addperm/security/dummy.c	2005-10-03 10:48:43.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/security/dummy.c	2005-10-07 16:36:00.000000000 +0100
@@ -803,6 +803,23 @@ static int dummy_setprocattr(struct task
 	return -EINVAL;
 }
 
+#ifdef CONFIG_KEYS
+static inline int dummy_key_alloc(struct key *key)
+{
+	return 0;
+}
+
+static inline void dummy_key_free(struct key *key)
+{
+}
+
+static inline int dummy_key_permission(key_ref_t key_ref,
+				       struct task_struct *context,
+				       key_perm_t perm)
+{
+	return 0;
+}
+#endif /* CONFIG_KEYS */
 
 struct security_operations dummy_security_ops;
 
@@ -954,5 +971,11 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, sk_alloc_security);
 	set_to_dummy_if_null(ops, sk_free_security);
 #endif	/* CONFIG_SECURITY_NETWORK */
+#ifdef CONFIG_KEYS
+	set_to_dummy_if_null(ops, key_alloc);
+	set_to_dummy_if_null(ops, key_free);
+	set_to_dummy_if_null(ops, key_permission);
+#endif	/* CONFIG_KEYS */
+
 }
 
diff -uNrp linux-2.6.14-rc3-keys-addperm/security/keys/key.c linux-2.6.14-rc3-keys-lsm/security/keys/key.c
--- linux-2.6.14-rc3-keys-addperm/security/keys/key.c	2005-10-03 10:48:43.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/security/keys/key.c	2005-10-07 16:07:17.000000000 +0100
@@ -1,6 +1,6 @@
 /* key.c: basic authentication token and access key management
  *
- * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/security.h>
 #include <linux/workqueue.h>
 #include <linux/err.h>
 #include "internal.h"
@@ -253,6 +254,7 @@ struct key *key_alloc(struct key_type *t
 	struct key_user *user = NULL;
 	struct key *key;
 	size_t desclen, quotalen;
+	int ret;
 
 	key = ERR_PTR(-EINVAL);
 	if (!desc || !*desc)
@@ -305,6 +307,7 @@ struct key *key_alloc(struct key_type *t
 	key->flags = 0;
 	key->expiry = 0;
 	key->payload.data = NULL;
+	key->security = NULL;
 
 	if (!not_in_quota)
 		key->flags |= 1 << KEY_FLAG_IN_QUOTA;
@@ -315,16 +318,34 @@ struct key *key_alloc(struct key_type *t
 	key->magic = KEY_DEBUG_MAGIC;
 #endif
 
+	/* let the security module know about the key */
+	ret = security_key_alloc(key);
+	if (ret < 0)
+		goto security_error;
+
 	/* publish the key by giving it a serial number */
 	atomic_inc(&user->nkeys);
 	key_alloc_serial(key);
 
- error:
+error:
 	return key;
 
- no_memory_3:
+security_error:
+	kfree(key->description);
+	kmem_cache_free(key_jar, key);
+	if (!not_in_quota) {
+		spin_lock(&user->lock);
+		user->qnkeys--;
+		user->qnbytes -= quotalen;
+		spin_unlock(&user->lock);
+	}
+	key_user_put(user);
+	key = ERR_PTR(ret);
+	goto error;
+
+no_memory_3:
 	kmem_cache_free(key_jar, key);
- no_memory_2:
+no_memory_2:
 	if (!not_in_quota) {
 		spin_lock(&user->lock);
 		user->qnkeys--;
@@ -332,11 +353,11 @@ struct key *key_alloc(struct key_type *t
 		spin_unlock(&user->lock);
 	}
 	key_user_put(user);
- no_memory_1:
+no_memory_1:
 	key = ERR_PTR(-ENOMEM);
 	goto error;
 
- no_quota:
+no_quota:
 	spin_unlock(&user->lock);
 	key_user_put(user);
 	key = ERR_PTR(-EDQUOT);
@@ -556,6 +577,8 @@ static void key_cleanup(void *data)
 
 	key_check(key);
 
+	security_key_free(key);
+
 	/* deal with the user's key tracking and quota */
 	if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
 		spin_lock(&key->user->lock);
@@ -700,8 +723,8 @@ static inline key_ref_t __key_update(key
 	int ret;
 
 	/* need write permission on the key to update it */
-	ret = -EACCES;
-	if (!key_permission(key_ref, KEY_WRITE))
+	ret = key_permission(key_ref, KEY_WRITE);
+	if (ret < 0)
 		goto error;
 
 	ret = -EEXIST;
@@ -711,7 +734,6 @@ static inline key_ref_t __key_update(key
 	down_write(&key->sem);
 
 	ret = key->type->update(key, payload, plen);
-
 	if (ret == 0)
 		/* updating a negative key instantiates it */
 		clear_bit(KEY_FLAG_NEGATIVE, &key->flags);
@@ -768,9 +790,11 @@ key_ref_t key_create_or_update(key_ref_t
 
 	/* if we're going to allocate a new key, we're going to have
 	 * to modify the keyring */
-	key_ref = ERR_PTR(-EACCES);
-	if (!key_permission(keyring_ref, KEY_WRITE))
+	ret = key_permission(keyring_ref, KEY_WRITE);
+	if (ret < 0) {
+		key_ref = ERR_PTR(ret);
 		goto error_3;
+	}
 
 	/* search for an existing key of the same type and description in the
 	 * destination keyring
@@ -780,8 +804,8 @@ key_ref_t key_create_or_update(key_ref_t
 		goto found_matching_key;
 
 	/* decide on the permissions we want */
-	perm = KEY_POS_VIEW | KEY_POS_SEARCH | KEY_POS_LINK;
-	perm |= KEY_USR_VIEW | KEY_USR_SEARCH | KEY_USR_LINK;
+	perm = KEY_POS_VIEW | KEY_POS_SEARCH | KEY_POS_LINK | KEY_POS_SETATTR;
+	perm |= KEY_USR_VIEW | KEY_USR_SEARCH | KEY_USR_LINK | KEY_USR_SETATTR;
 
 	if (ktype->read)
 		perm |= KEY_POS_READ | KEY_USR_READ;
@@ -840,16 +864,16 @@ int key_update(key_ref_t key_ref, const 
 	key_check(key);
 
 	/* the key must be writable */
-	ret = -EACCES;
-	if (!key_permission(key_ref, KEY_WRITE))
+	ret = key_permission(key_ref, KEY_WRITE);
+	if (ret < 0)
 		goto error;
 
 	/* attempt to update it if supported */
 	ret = -EOPNOTSUPP;
 	if (key->type->update) {
 		down_write(&key->sem);
-		ret = key->type->update(key, payload, plen);
 
+		ret = key->type->update(key, payload, plen);
 		if (ret == 0)
 			/* updating a negative key instantiates it */
 			clear_bit(KEY_FLAG_NEGATIVE, &key->flags);
diff -uNrp linux-2.6.14-rc3-keys-addperm/security/keys/keyctl.c linux-2.6.14-rc3-keys-lsm/security/keys/keyctl.c
--- linux-2.6.14-rc3-keys-addperm/security/keys/keyctl.c	2005-10-03 10:48:43.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/security/keys/keyctl.c	2005-10-07 15:49:36.000000000 +0100
@@ -624,8 +624,8 @@ long keyctl_keyring_search(key_serial_t 
 
 	/* link the resulting key to the destination keyring if we can */
 	if (dest_ref) {
-		ret = -EACCES;
-		if (!key_permission(key_ref, KEY_LINK))
+		ret = key_permission(key_ref, KEY_LINK);
+		if (ret < 0)
 			goto error6;
 
 		ret = key_link(key_ref_to_ptr(dest_ref), key_ref_to_ptr(key_ref));
@@ -676,8 +676,11 @@ long keyctl_read_key(key_serial_t keyid,
 	key = key_ref_to_ptr(key_ref);
 
 	/* see if we can read it directly */
-	if (key_permission(key_ref, KEY_READ))
+	ret = key_permission(key_ref, KEY_READ);
+	if (ret == 0)
 		goto can_read_key;
+	if (ret != -EACCES)
+		goto error;
 
 	/* we can't; see if it's searchable from this process's keyrings
 	 * - we automatically take account of the fact that it may be
@@ -726,7 +729,7 @@ long keyctl_chown_key(key_serial_t id, u
 	if (uid == (uid_t) -1 && gid == (gid_t) -1)
 		goto error;
 
-	key_ref = lookup_user_key(NULL, id, 1, 1, 0);
+	key_ref = lookup_user_key(NULL, id, 1, 1, KEY_SETATTR);
 	if (IS_ERR(key_ref)) {
 		ret = PTR_ERR(key_ref);
 		goto error;
@@ -786,7 +789,7 @@ long keyctl_setperm_key(key_serial_t id,
 	if (perm & ~(KEY_POS_ALL | KEY_USR_ALL | KEY_GRP_ALL | KEY_OTH_ALL))
 		goto error;
 
-	key_ref = lookup_user_key(NULL, id, 1, 1, 0);
+	key_ref = lookup_user_key(NULL, id, 1, 1, KEY_SETATTR);
 	if (IS_ERR(key_ref)) {
 		ret = PTR_ERR(key_ref);
 		goto error;
diff -uNrp linux-2.6.14-rc3-keys-addperm/security/keys/keyring.c linux-2.6.14-rc3-keys-lsm/security/keys/keyring.c
--- linux-2.6.14-rc3-keys-addperm/security/keys/keyring.c	2005-10-03 10:48:43.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/security/keys/keyring.c	2005-10-07 16:11:56.000000000 +0100
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/security.h>
 #include <linux/seq_file.h>
 #include <linux/err.h>
 #include <asm/uaccess.h>
@@ -309,7 +310,9 @@ struct key *keyring_alloc(const char *de
 	int ret;
 
 	keyring = key_alloc(&key_type_keyring, description,
-			    uid, gid, KEY_POS_ALL | KEY_USR_ALL, not_in_quota);
+			    uid, gid,
+			    (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_ALL,
+			    not_in_quota);
 
 	if (!IS_ERR(keyring)) {
 		ret = key_instantiate_and_link(keyring, NULL, 0, dest, NULL);
@@ -359,9 +362,11 @@ key_ref_t keyring_search_aux(key_ref_t k
 	key_check(keyring);
 
 	/* top keyring must have search permission to begin the search */
-	key_ref = ERR_PTR(-EACCES);
-	if (!key_task_permission(keyring_ref, context, KEY_SEARCH))
+        err = key_task_permission(keyring_ref, context, KEY_SEARCH);
+	if (err < 0) {
+		key_ref = ERR_PTR(err);
 		goto error;
+	}
 
 	key_ref = ERR_PTR(-ENOTDIR);
 	if (keyring->type != &key_type_keyring)
@@ -402,8 +407,8 @@ descend:
 			continue;
 
 		/* key must have search permissions */
-		if (!key_task_permission(make_key_ref(key, possessed),
-					 context, KEY_SEARCH))
+		if (key_task_permission(make_key_ref(key, possessed),
+					context, KEY_SEARCH) < 0)
 			continue;
 
 		/* we set a different error code if we find a negative key */
@@ -430,7 +435,7 @@ ascend:
 			continue;
 
 		if (!key_task_permission(make_key_ref(key, possessed),
-					 context, KEY_SEARCH))
+					 context, KEY_SEARCH) < 0)
 			continue;
 
 		/* stack the current position */
@@ -521,7 +526,7 @@ key_ref_t __keyring_search_one(key_ref_t
 			    (!key->type->match ||
 			     key->type->match(key, description)) &&
 			    key_permission(make_key_ref(key, possessed),
-					   perm) &&
+					   perm) < 0 &&
 			    !test_bit(KEY_FLAG_REVOKED, &key->flags)
 			    )
 				goto found;
@@ -617,7 +622,7 @@ struct key *find_keyring_by_name(const c
 				continue;
 
 			if (!key_permission(make_key_ref(keyring, 0),
-					    KEY_SEARCH))
+					    KEY_SEARCH) < 0)
 				continue;
 
 			/* found a potential candidate, but we still need to
diff -uNrp linux-2.6.14-rc3-keys-addperm/security/keys/permission.c linux-2.6.14-rc3-keys-lsm/security/keys/permission.c
--- linux-2.6.14-rc3-keys-addperm/security/keys/permission.c	2005-10-07 16:29:59.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/security/keys/permission.c	2005-10-07 16:21:07.000000000 +0100
@@ -10,6 +10,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/security.h>
 #include "internal.h"
 
 /*****************************************************************************/
@@ -63,7 +64,11 @@ use_these_perms:
 
 	kperm = kperm & perm & KEY_ALL;
 
-	return kperm == perm;
+	if (kperm != perm)
+		return -EACCES;
+
+	/* let LSM be the final arbiter */
+	return security_key_permission(key_ref, context, perm);
 
 } /* end key_task_permission() */
 
diff -uNrp linux-2.6.14-rc3-keys-addperm/security/keys/process_keys.c linux-2.6.14-rc3-keys-lsm/security/keys/process_keys.c
--- linux-2.6.14-rc3-keys-addperm/security/keys/process_keys.c	2005-10-03 10:48:43.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/security/keys/process_keys.c	2005-10-07 16:12:14.000000000 +0100
@@ -39,7 +39,7 @@ struct key root_user_keyring = {
 	.type		= &key_type_keyring,
 	.user		= &root_key_user,
 	.sem		= __RWSEM_INITIALIZER(root_user_keyring.sem),
-	.perm		= KEY_POS_ALL | KEY_USR_ALL,
+	.perm		= (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_ALL,
 	.flags		= 1 << KEY_FLAG_INSTANTIATED,
 	.description	= "_uid.0",
 #ifdef KEY_DEBUGGING
@@ -54,7 +54,7 @@ struct key root_session_keyring = {
 	.type		= &key_type_keyring,
 	.user		= &root_key_user,
 	.sem		= __RWSEM_INITIALIZER(root_session_keyring.sem),
-	.perm		= KEY_POS_ALL | KEY_USR_ALL,
+	.perm		= (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_ALL,
 	.flags		= 1 << KEY_FLAG_INSTANTIATED,
 	.description	= "_uid_ses.0",
 #ifdef KEY_DEBUGGING
@@ -666,9 +666,8 @@ key_ref_t lookup_user_key(struct task_st
 		goto invalid_key;
 
 	/* check the permissions */
-	ret = -EACCES;
-
-	if (!key_task_permission(key_ref, context, perm))
+	ret = key_task_permission(key_ref, context, perm);
+	if (ret < 0)
 		goto invalid_key;
 
 error:
