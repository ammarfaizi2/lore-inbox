Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbVJEQ3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbVJEQ3D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbVJEQ3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:29:02 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50404 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030224AbVJEQ27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:28:59 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Add LSM hooks for key management
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 05 Oct 2005 17:28:34 +0100
Message-ID: <29942.1128529714@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch adds LSM hooks for key management facilities. The notable
changes are:

 (1) The key struct now supports a security pointer for the use of security
     modules. This will permit key labelling and restrictions on which
     programs may access a key.

 (2) Security modules get a chance to abort the allocation of a key.

 (3) Two new keyctl functions have been added to associate security data with
     a key and to retrieve it. They talk directly to the security modules and
     have no other function.

 (4) The key permission checking can now be overridden by or enhanced by the
     security modules. It has also been moved out of the key-ui.h header file
     into permission.c file since it's quite large and it's used a lot.

 (5) Security modules may review the data with which a key will be
     instantiated or updated.

Note that there isn't an LSM hook specifically for each keyctl() operation,
but rather the permissions hook allows control of individual operations based
on the permission request bits.

Key management access control through LSM is enabled by CONFIG_SECURITY_KEYS.


Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-lsm-2614rc3.diff
 Documentation/keys.txt     |   46 ++++++++++--
 include/linux/key-ui.h     |   89 +----------------------
 include/linux/key.h        |   67 +++++++++---------
 include/linux/keyctl.h     |    4 -
 include/linux/security.h   |  167 +++++++++++++++++++++++++++++++++++++++++++++
 security/Kconfig           |    9 ++
 security/dummy.c           |   54 ++++++++++++++
 security/keys/Makefile     |    1 
 security/keys/compat.c     |    8 ++
 security/keys/internal.h   |    6 +
 security/keys/key.c        |   66 ++++++++++++++---
 security/keys/keyctl.c     |   88 +++++++++++++++++++++++
 security/keys/permission.c |   81 +++++++++++++++++++++
 13 files changed, 545 insertions(+), 141 deletions(-)

diff -uNrp linux-2.6.14-rc3-keys/Documentation/keys.txt linux-2.6.14-rc3-keys-lsm/Documentation/keys.txt
--- linux-2.6.14-rc3-keys/Documentation/keys.txt	2005-10-03 10:48:15.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/Documentation/keys.txt	2005-10-05 16:48:15.000000000 +0100
@@ -533,8 +533,8 @@ The keyctl syscall functions are:
 
  (*) Read the payload data from a key:
 
-	key_serial_t keyctl(KEYCTL_READ, key_serial_t keyring, char *buffer,
-			    size_t buflen);
+	long keyctl(KEYCTL_READ, key_serial_t keyring, char *buffer,
+		    size_t buflen);
 
      This function attempts to read the payload data from the specified key
      into the buffer. The process must have read permission on the key to
@@ -555,9 +555,9 @@ The keyctl syscall functions are:
 
  (*) Instantiate a partially constructed key.
 
-	key_serial_t keyctl(KEYCTL_INSTANTIATE, key_serial_t key,
-			    const void *payload, size_t plen,
-			    key_serial_t keyring);
+	long keyctl(KEYCTL_INSTANTIATE, key_serial_t key,
+		    const void *payload, size_t plen,
+		    key_serial_t keyring);
 
      If the kernel calls back to userspace to complete the instantiation of a
      key, userspace should use this call to supply data for the key before the
@@ -576,8 +576,8 @@ The keyctl syscall functions are:
 
  (*) Negatively instantiate a partially constructed key.
 
-	key_serial_t keyctl(KEYCTL_NEGATE, key_serial_t key,
-			    unsigned timeout, key_serial_t keyring);
+	long keyctl(KEYCTL_NEGATE, key_serial_t key,
+		    unsigned timeout, key_serial_t keyring);
 
      If the kernel calls back to userspace to complete the instantiation of a
      key, userspace should use this call mark the key as negative before the
@@ -622,6 +622,38 @@ The keyctl syscall functions are:
      there is one, otherwise the user default session keyring.
 
 
+ (*) Set a security attribute on a key.
+
+	long keyctl(KEYCTL_SET_SECURITY, key_serial_t id, const char *name,
+		    const void *data, size_t dlen);
+
+     This communicates with the in-force security modules (if any), permitting
+     them to set security information on the nominated key. The attribute to be
+     set is named and an amount of data is supplied. It is permitted to supply
+     a NULL data pointer. The interpretation of the data is at the whim of the
+     security modules.
+
+     The function will return 0 if the security request was acceptable, and an
+     error otherwise. Success will always be indicated if no security modules
+     are in force.
+
+
+ (*) Retrieve a security attribute from a key.
+
+	long keyctl(KEYCTL_GET_SECURITY, key_serial_t id, const char *name,
+		    void *buffer, size_t blen);
+
+     This communicates with the in-force security modules (if any), permitting
+     them to return information about the security controls applied to a key.
+     The attribute requested is named, and the module will return error ENODATA
+     if that attribute is unavailable.
+
+     If successful and if buffer is not NULL and blen is greater than zero then
+     as many bytes of security data as are available will be read into the
+     buffer, subject to a maximum of blen. The function will return the number
+     of bytes that can be read, irrespective of how many actually were.
+
+
 ===============
 KERNEL SERVICES
 ===============
diff -uNrp linux-2.6.14-rc3-keys/include/linux/keyctl.h linux-2.6.14-rc3-keys-lsm/include/linux/keyctl.h
--- linux-2.6.14-rc3-keys/include/linux/keyctl.h	2005-08-30 13:56:36.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/include/linux/keyctl.h	2005-10-05 14:26:33.000000000 +0100
@@ -1,6 +1,6 @@
 /* keyctl.h: keyctl command IDs
  *
- * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -46,5 +46,7 @@
 #define KEYCTL_INSTANTIATE		12	/* instantiate a partially constructed key */
 #define KEYCTL_NEGATE			13	/* negate a partially constructed key */
 #define KEYCTL_SET_REQKEY_KEYRING	14	/* set default request-key keyring */
+#define KEYCTL_SET_SECURITY		15	/* apply security info to a key */
+#define KEYCTL_GET_SECURITY		16	/* retrieve a security info from a key */
 
 #endif /*  _LINUX_KEYCTL_H */
diff -uNrp linux-2.6.14-rc3-keys/include/linux/key.h linux-2.6.14-rc3-keys-lsm/include/linux/key.h
--- linux-2.6.14-rc3-keys/include/linux/key.h	2005-10-05 11:50:22.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/include/linux/key.h	2005-10-05 17:06:42.000000000 +0100
@@ -23,6 +23,8 @@
 
 #ifdef __KERNEL__
 
+#undef KEY_DEBUGGING
+
 /* key handle serial number */
 typedef int32_t key_serial_t;
 
@@ -31,9 +33,39 @@ typedef uint32_t key_perm_t;
 
 struct key;
 
+/*****************************************************************************/
+/*
+ * key reference with possession attribute handling
+ *
+ * NOTE! key_ref_t is a typedef'd pointer to a type that is not actually
+ * defined. This is because we abuse the bottom bit of the reference to carry a
+ * flag to indicate whether the calling process possesses that key in one of
+ * its keyrings.
+ *
+ * the key_ref_t has been made a separate type so that the compiler can reject
+ * attempts to dereference it without proper conversion.
+ *
+ * the three functions are used to assemble and disassemble references
+ */
+typedef struct __key_reference_with_attributes *key_ref_t;
+
 #ifdef CONFIG_KEYS
 
-#undef KEY_DEBUGGING
+static inline key_ref_t make_key_ref(const struct key *key,
+				     unsigned long possession)
+{
+	return (key_ref_t) ((unsigned long) key | possession);
+}
+
+static inline struct key *key_ref_to_ptr(const key_ref_t key_ref)
+{
+	return (struct key *) ((unsigned long) key_ref & ~1UL);
+}
+
+static inline unsigned long is_key_possessed(const key_ref_t key_ref)
+{
+	return (unsigned long) key_ref & 1UL;
+}
 
 #define KEY_POS_VIEW	0x01000000	/* possessor can view a key's attributes */
 #define KEY_POS_READ	0x02000000	/* possessor can read key payload / view keyring */
@@ -74,38 +106,6 @@ struct keyring_name;
 
 /*****************************************************************************/
 /*
- * key reference with possession attribute handling
- *
- * NOTE! key_ref_t is a typedef'd pointer to a type that is not actually
- * defined. This is because we abuse the bottom bit of the reference to carry a
- * flag to indicate whether the calling process possesses that key in one of
- * its keyrings.
- *
- * the key_ref_t has been made a separate type so that the compiler can reject
- * attempts to dereference it without proper conversion.
- *
- * the three functions are used to assemble and disassemble references
- */
-typedef struct __key_reference_with_attributes *key_ref_t;
-
-static inline key_ref_t make_key_ref(const struct key *key,
-				     unsigned long possession)
-{
-	return (key_ref_t) ((unsigned long) key | possession);
-}
-
-static inline struct key *key_ref_to_ptr(const key_ref_t key_ref)
-{
-	return (struct key *) ((unsigned long) key_ref & ~1UL);
-}
-
-static inline unsigned long is_key_possessed(const key_ref_t key_ref)
-{
-	return (unsigned long) key_ref & 1UL;
-}
-
-/*****************************************************************************/
-/*
  * authentication token / access credential / keyring
  * - types of key include:
  *   - keyrings
@@ -119,6 +119,7 @@ struct key {
 	struct key_type		*type;		/* type of key */
 	struct rw_semaphore	sem;		/* change vs change sem */
 	struct key_user		*user;		/* owner of this key */
+	void			*security;	/* security data for this key */
 	time_t			expiry;		/* time at which key expires (or 0) */
 	uid_t			uid;
 	gid_t			gid;
diff -uNrp linux-2.6.14-rc3-keys/include/linux/key-ui.h linux-2.6.14-rc3-keys-lsm/include/linux/key-ui.h
--- linux-2.6.14-rc3-keys/include/linux/key-ui.h	2005-10-03 10:48:38.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/include/linux/key-ui.h	2005-10-05 15:02:55.000000000 +0100
@@ -38,97 +38,16 @@ struct keyring_list {
 	struct key	*keys[0];
 };
 
+extern int key_task_permission(const key_ref_t key_ref,
+			       struct task_struct *context,
+			       key_perm_t perm);
 
 /*
  * check to see whether permission is granted to use a key in the desired way
  */
 static inline int key_permission(const key_ref_t key_ref, key_perm_t perm)
 {
-	struct key *key = key_ref_to_ptr(key_ref);
-	key_perm_t kperm;
-
-	if (is_key_possessed(key_ref))
-		kperm = key->perm >> 24;
-	else if (key->uid == current->fsuid)
-		kperm = key->perm >> 16;
-	else if (key->gid != -1 &&
-		 key->perm & KEY_GRP_ALL &&
-		 in_group_p(key->gid)
-		 )
-		kperm = key->perm >> 8;
-	else
-		kperm = key->perm;
-
-	kperm = kperm & perm & KEY_ALL;
-
-	return kperm == perm;
-}
-
-/*
- * check to see whether permission is granted to use a key in at least one of
- * the desired ways
- */
-static inline int key_any_permission(const key_ref_t key_ref, key_perm_t perm)
-{
-	struct key *key = key_ref_to_ptr(key_ref);
-	key_perm_t kperm;
-
-	if (is_key_possessed(key_ref))
-		kperm = key->perm >> 24;
-	else if (key->uid == current->fsuid)
-		kperm = key->perm >> 16;
-	else if (key->gid != -1 &&
-		 key->perm & KEY_GRP_ALL &&
-		 in_group_p(key->gid)
-		 )
-		kperm = key->perm >> 8;
-	else
-		kperm = key->perm;
-
-	kperm = kperm & perm & KEY_ALL;
-
-	return kperm != 0;
-}
-
-static inline int key_task_groups_search(struct task_struct *tsk, gid_t gid)
-{
-	int ret;
-
-	task_lock(tsk);
-	ret = groups_search(tsk->group_info, gid);
-	task_unlock(tsk);
-	return ret;
-}
-
-static inline int key_task_permission(const key_ref_t key_ref,
-				      struct task_struct *context,
-				      key_perm_t perm)
-{
-	struct key *key = key_ref_to_ptr(key_ref);
-	key_perm_t kperm;
-
-	if (is_key_possessed(key_ref)) {
-		kperm = key->perm >> 24;
-	}
-	else if (key->uid == context->fsuid) {
-		kperm = key->perm >> 16;
-	}
-	else if (key->gid != -1 &&
-		 key->perm & KEY_GRP_ALL && (
-			 key->gid == context->fsgid ||
-			 key_task_groups_search(context, key->gid)
-			 )
-		 ) {
-		kperm = key->perm >> 8;
-	}
-	else {
-		kperm = key->perm;
-	}
-
-	kperm = kperm & perm & KEY_ALL;
-
-	return kperm == perm;
-
+	return key_task_permission(key_ref, current, perm);
 }
 
 extern key_ref_t lookup_user_key(struct task_struct *context,
diff -uNrp linux-2.6.14-rc3-keys/include/linux/security.h linux-2.6.14-rc3-keys-lsm/include/linux/security.h
--- linux-2.6.14-rc3-keys/include/linux/security.h	2005-10-03 10:48:39.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/include/linux/security.h	2005-10-05 16:10:53.000000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/shm.h>
 #include <linux/msg.h>
 #include <linux/sched.h>
+#include <linux/key.h>
 
 struct ctl_table;
 
@@ -785,6 +786,54 @@ struct swap_info_struct;
  * @sk_free_security:
  *	Deallocate security structure.
  *
+ * Security hooks affecting all Key Management operations
+ *
+ * @key_alloc:
+ *	Permit allocation a key and assign security data. Note that key does
+ *	not have a serial number assigned at this point.
+ *	@key points to the key.
+ *	Return 0 if permission is granted, -ve error otherwise.
+ * @key_post_alloc:
+ *	Notification of key publication; key has serial number.
+ *	@key points to the key.
+ *	No return.
+ * @key_free:
+ *	Notification of destruction; free security data.
+ *	@key points to the key.
+ *	No return.
+ * @key_set_security:
+ *	Apply security data to a key.
+ *	@key points to the key.
+ *	@name points to the name of the attribute.
+ *	@data points to the data (may be NULL).
+ *	@dlen indicates the size of the data (may be 0).
+ *	Return 0 if successful, -ve error otherwise.
+ * @key_get_security:
+ *	Retrieve security data from a key.
+ *	@key points to the key.
+ *	@name points to the name of the attribute.
+ *	@buffer points to the buffer (may be NULL if size wanted).
+ *	@blen indicates the size of the buffer (may be 0 if buffer is NULL).
+ *	Load buffer with up to maximum of blen bytes upon successful return.
+ *	Return number of bytes retrievable if successful, -ve error otherwise.
+ * @key_permission:
+ *	See whether a specific operational right is granted to a process on a
+ *      key.
+ *	@key_ref refers to the key (key pointer + possession attribute bit).
+ *	@context points to the process to provide the context against which to
+ *       evaluate the security data on the key.
+ *	@perm describes the combination of permissions required of this key.
+ *	Return 1 if permission granted, 0 if permission denied and -ve it the
+ *      normal permissions model should be effected.
+ * @key_set_data:
+ *	Test whether a key may be set to the given data, and adjust the
+ *      security information accordingly.
+ *	@key points to the key being altered.
+ *	@instkey points to the instantiation key if the key is being
+ *       instantiated, and NULL if being updated.
+ *	@data points to the data.
+ *	@dlen indicates the size of the data.
+ *
  * Security hooks affecting all System V IPC operations.
  *
  * @ipc_permission:
@@ -1213,6 +1262,28 @@ struct security_operations {
 	int (*sk_alloc_security) (struct sock *sk, int family, int priority);
 	void (*sk_free_security) (struct sock *sk);
 #endif	/* CONFIG_SECURITY_NETWORK */
+
+	/* key management security hooks */
+#ifdef CONFIG_SECURITY_KEYS
+	int (*key_alloc)(struct key *key);
+	void (*key_post_alloc)(struct key *key);
+	void (*key_free)(struct key *key);
+	long (*key_set_security)(struct key *key, const char __user *name,
+				 const void __user *data, size_t dlen);
+	long (*key_get_security)(struct key *key, const char __user *name,
+				 void __user *buffer, size_t blen);
+
+	int (*key_permission)(key_ref_t key_ref,
+			      struct task_struct *context,
+			      key_perm_t perm);
+
+	int (*key_set_data)(struct key *key,
+			    struct key *instkey,
+			    const void *data,
+			    size_t dlen);
+
+#endif	/* CONFIG_SECURITY_KEYS */
+
 };
 
 /* global variables */
@@ -2763,5 +2834,101 @@ static inline void security_sk_free(stru
 }
 #endif	/* CONFIG_SECURITY_NETWORK */
 
+#ifdef CONFIG_SECURITY_KEYS
+
+static inline int security_key_alloc(struct key *key)
+{
+	return security_ops->key_alloc(key);
+}
+
+static inline void security_key_post_alloc(struct key *key)
+{
+	security_ops->key_post_alloc(key);
+}
+
+static inline void security_key_free(struct key *key)
+{
+	security_ops->key_free(key);
+}
+
+static inline long security_key_set_security(struct key *key,
+					     const char __user *name,
+					     const void __user *data,
+					     size_t dlen)
+{
+	return security_ops->key_set_security(key, name, data, dlen);
+}
+
+static inline long security_key_get_security(struct key *key,
+					     const char __user *name,
+					     void __user *buffer,
+					     size_t blen)
+{
+	return security_ops->key_get_security(key, name, buffer, blen);
+}
+
+static inline int security_key_permission(key_ref_t key_ref,
+					  struct task_struct *context,
+					  key_perm_t perm)
+{
+	return security_ops->key_permission(key_ref, context, perm);
+}
+
+static inline int security_key_set_data(struct key *key,
+					struct key *instkey,
+					const void *data,
+					size_t dlen)
+{
+	return security_ops->key_set_data(key, instkey, data, dlen);
+}
+
+#else
+
+static inline int security_key_alloc(struct key *key)
+{
+	return 0;
+}
+
+static inline void security_key_post_alloc(struct key *key)
+{
+}
+
+static inline void security_key_free(struct key *key)
+{
+}
+
+static inline long security_key_set_security(struct key *key,
+					     const char __user *name,
+					     const void __user *data,
+					     size_t dlen)
+{
+	return 0;
+}
+
+static inline long security_key_get_security(struct key *key,
+					     const char __user *name,
+					     void __user *buffer,
+					     size_t blen)
+{
+	return -ENODATA;
+}
+
+static inline int security_key_permission(key_ref_t key_ref,
+					  struct task_struct *context,
+					  key_perm_t perm)
+{
+	return -1;
+}
+
+static inline int security_key_set_data(struct key *key,
+					struct key *instkey,
+					const void *data,
+					size_t dlen)
+{
+	return 0;
+}
+
+#endif
+
 #endif /* ! __LINUX_SECURITY_H */
 
diff -uNrp linux-2.6.14-rc3-keys/security/dummy.c linux-2.6.14-rc3-keys-lsm/security/dummy.c
--- linux-2.6.14-rc3-keys/security/dummy.c	2005-10-03 10:48:43.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/security/dummy.c	2005-10-05 16:11:38.000000000 +0100
@@ -803,6 +803,50 @@ static int dummy_setprocattr(struct task
 	return -EINVAL;
 }
 
+static inline int dummy_key_alloc(struct key *key)
+{
+	return 0;
+}
+
+static inline void dummy_key_post_alloc(struct key *key)
+{
+}
+
+static inline void dummy_key_free(struct key *key)
+{
+}
+
+static inline long dummy_key_set_security(struct key *key,
+					  const char __user *name,
+					  const void __user *data,
+					  size_t dlen)
+{
+	return 0;
+}
+
+static inline long dummy_key_get_security(struct key *key,
+					  const char __user *name,
+					  void __user *buffer,
+					  size_t blen)
+{
+	return -ENODATA;
+}
+
+static inline int dummy_key_permission(key_ref_t key_ref,
+				       struct task_struct *context,
+				       key_perm_t perm)
+{
+	return -1;
+}
+
+static inline int dummy_key_set_data(struct key *key,
+				     struct key *instkey,
+				     const void *data,
+				     size_t dlen)
+{
+	return 0;
+}
+
 
 struct security_operations dummy_security_ops;
 
@@ -954,5 +998,15 @@ void security_fixup_ops (struct security
 	set_to_dummy_if_null(ops, sk_alloc_security);
 	set_to_dummy_if_null(ops, sk_free_security);
 #endif	/* CONFIG_SECURITY_NETWORK */
+#ifdef CONFIG_SECURITY_KEYS
+	set_to_dummy_if_null(ops, key_alloc);
+	set_to_dummy_if_null(ops, key_post_alloc);
+	set_to_dummy_if_null(ops, key_free);
+	set_to_dummy_if_null(ops, key_set_security);
+	set_to_dummy_if_null(ops, key_get_security);
+	set_to_dummy_if_null(ops, key_permission);
+	set_to_dummy_if_null(ops, key_set_data);
+#endif	/* CONFIG_SECURITY_KEYS */
+
 }
 
diff -uNrp linux-2.6.14-rc3-keys/security/Kconfig linux-2.6.14-rc3-keys-lsm/security/Kconfig
--- linux-2.6.14-rc3-keys/security/Kconfig	2005-10-03 10:48:43.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/security/Kconfig	2005-10-05 13:59:45.000000000 +0100
@@ -74,6 +74,15 @@ config SECURITY_ROOTPLUG
 	  
 	  If you are unsure how to answer this question, answer N.
 
+config SECURITY_KEYS
+	bool "Key Management Security Hooks"
+	depends on SECURITY && KEYS
+	help
+	  This enables the key management security hooks.
+	  If enabled, a security module can use these hooks to
+	  implement access controls on keys.
+	  If you are unsure how to answer this question, answer N.
+
 config SECURITY_SECLVL
 	tristate "BSD Secure Levels"
 	depends on SECURITY
diff -uNrp linux-2.6.14-rc3-keys/security/keys/compat.c linux-2.6.14-rc3-keys-lsm/security/keys/compat.c
--- linux-2.6.14-rc3-keys/security/keys/compat.c	2005-08-30 13:56:44.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/security/keys/compat.c	2005-10-05 16:30:38.000000000 +0100
@@ -74,6 +74,14 @@ asmlinkage long compat_sys_keyctl(u32 op
 	case KEYCTL_SET_REQKEY_KEYRING:
 		return keyctl_set_reqkey_keyring(arg2);
 
+	case KEYCTL_SET_SECURITY:
+		return keyctl_set_security(arg2, compat_ptr(arg3),
+					   compat_ptr(arg4), arg5);
+
+	case KEYCTL_GET_SECURITY:
+		return keyctl_get_security(arg2, compat_ptr(arg3),
+					   compat_ptr(arg4), arg5);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff -uNrp linux-2.6.14-rc3-keys/security/keys/internal.h linux-2.6.14-rc3-keys-lsm/security/keys/internal.h
--- linux-2.6.14-rc3-keys/security/keys/internal.h	2005-10-03 10:48:43.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/security/keys/internal.h	2005-10-05 16:29:39.000000000 +0100
@@ -12,6 +12,7 @@
 #ifndef _INTERNAL_H
 #define _INTERNAL_H
 
+#include <linux/security.h>
 #include <linux/key.h>
 #include <linux/key-ui.h>
 
@@ -137,7 +138,10 @@ extern long keyctl_instantiate_key(key_s
 				   size_t, key_serial_t);
 extern long keyctl_negate_key(key_serial_t, unsigned, key_serial_t);
 extern long keyctl_set_reqkey_keyring(int);
-
+extern long keyctl_set_security(key_serial_t, const char __user *,
+				const void __user *, size_t);
+extern long keyctl_get_security(key_serial_t, const char __user *,
+				void __user *, size_t);
 
 /*
  * debugging key validation
diff -uNrp linux-2.6.14-rc3-keys/security/keys/key.c linux-2.6.14-rc3-keys-lsm/security/keys/key.c
--- linux-2.6.14-rc3-keys/security/keys/key.c	2005-10-03 10:48:43.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/security/keys/key.c	2005-10-05 15:33:29.000000000 +0100
@@ -1,6 +1,6 @@
 /* key.c: basic authentication token and access key management
  *
- * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -253,6 +253,7 @@ struct key *key_alloc(struct key_type *t
 	struct key_user *user = NULL;
 	struct key *key;
 	size_t desclen, quotalen;
+	int ret;
 
 	key = ERR_PTR(-EINVAL);
 	if (!desc || !*desc)
@@ -305,6 +306,7 @@ struct key *key_alloc(struct key_type *t
 	key->flags = 0;
 	key->expiry = 0;
 	key->payload.data = NULL;
+	key->security = NULL;
 
 	if (!not_in_quota)
 		key->flags |= 1 << KEY_FLAG_IN_QUOTA;
@@ -315,16 +317,37 @@ struct key *key_alloc(struct key_type *t
 	key->magic = KEY_DEBUG_MAGIC;
 #endif
 
+	/* do a final security check before publishing the key */
+	ret = security_key_alloc(key);
+	if (ret < 0)
+		goto security_error;
+
 	/* publish the key by giving it a serial number */
 	atomic_inc(&user->nkeys);
 	key_alloc_serial(key);
 
- error:
+	/* let the security module know the key has been published */
+	security_key_post_alloc(key);
+
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
@@ -332,11 +355,11 @@ struct key *key_alloc(struct key_type *t
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
@@ -406,6 +429,11 @@ static int __key_instantiate_and_link(st
 
 	/* can't instantiate twice */
 	if (!test_bit(KEY_FLAG_INSTANTIATED, &key->flags)) {
+		/* consult the security modules */
+		ret = security_key_set_data(key, instkey, data, datalen);
+		if (ret < 0)
+			goto error;
+
 		/* instantiate the key */
 		ret = key->type->instantiate(key, data, datalen);
 
@@ -427,6 +455,7 @@ static int __key_instantiate_and_link(st
 		}
 	}
 
+error:
 	up_write(&key_construction_sem);
 
 	/* wake up anyone waiting for a key to be constructed */
@@ -556,6 +585,8 @@ static void key_cleanup(void *data)
 
 	key_check(key);
 
+	security_key_free(key);
+
 	/* deal with the user's key tracking and quota */
 	if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
 		spin_lock(&key->user->lock);
@@ -710,11 +741,14 @@ static inline key_ref_t __key_update(key
 
 	down_write(&key->sem);
 
-	ret = key->type->update(key, payload, plen);
+	ret = security_key_set_data(key, NULL, payload, plen);
+	if (ret == 0) {
+		ret = key->type->update(key, payload, plen);
 
-	if (ret == 0)
-		/* updating a negative key instantiates it */
-		clear_bit(KEY_FLAG_NEGATIVE, &key->flags);
+		if (ret == 0)
+			/* updating a negative key instantiates it */
+			clear_bit(KEY_FLAG_NEGATIVE, &key->flags);
+	}
 
 	up_write(&key->sem);
 
@@ -848,11 +882,15 @@ int key_update(key_ref_t key_ref, const 
 	ret = -EOPNOTSUPP;
 	if (key->type->update) {
 		down_write(&key->sem);
-		ret = key->type->update(key, payload, plen);
 
-		if (ret == 0)
-			/* updating a negative key instantiates it */
-			clear_bit(KEY_FLAG_NEGATIVE, &key->flags);
+		ret = security_key_set_data(key, NULL, payload, plen);
+		if (ret == 0) {
+			ret = key->type->update(key, payload, plen);
+
+			if (ret == 0)
+				/* updating a negative key instantiates it */
+				clear_bit(KEY_FLAG_NEGATIVE, &key->flags);
+		}
 
 		up_write(&key->sem);
 	}
diff -uNrp linux-2.6.14-rc3-keys/security/keys/keyctl.c linux-2.6.14-rc3-keys-lsm/security/keys/keyctl.c
--- linux-2.6.14-rc3-keys/security/keys/keyctl.c	2005-10-03 10:48:43.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/security/keys/keyctl.c	2005-10-05 16:25:58.000000000 +0100
@@ -964,6 +964,82 @@ long keyctl_set_reqkey_keyring(int reqke
 
 /*****************************************************************************/
 /*
+ * apply security data to a key
+ */
+long keyctl_set_security(key_serial_t id,
+			 const char __user *name,
+			 const void __user *data,
+			 size_t dlen)
+{
+	struct key *key;
+	key_ref_t key_ref;
+	long ret;
+
+	ret = -EINVAL;
+	if (!name)
+		goto error;
+
+	key_ref = lookup_user_key(NULL, id, 1, 1, 0);
+	if (IS_ERR(key_ref)) {
+		ret = PTR_ERR(key_ref);
+		goto error;
+	}
+
+	key = key_ref_to_ptr(key_ref);
+
+	/* make the changes with the locks held to prevent races */
+	ret = -EACCES;
+	down_write(&key->sem);
+
+	/* if we're not the sysadmin, we can only change a key that we own */
+	if (capable(CAP_SYS_ADMIN) || key->uid == current->fsuid)
+		ret = security_key_set_security(key, name, data, dlen);
+
+	up_write(&key->sem);
+	key_put(key);
+error:
+	return ret;
+
+} /* end keyctl_set_security() */
+
+/*****************************************************************************/
+/*
+ * retrieve security data from a key
+ */
+long keyctl_get_security(key_serial_t id,
+			 const char __user *name,
+			 void __user *buffer,
+			 size_t blen)
+{
+	struct key *key;
+	key_ref_t key_ref;
+	long ret;
+
+	ret = -EINVAL;
+	if (!name)
+		goto error;
+
+	key_ref = lookup_user_key(NULL, id, 1, 1, 0);
+	if (IS_ERR(key_ref)) {
+		ret = PTR_ERR(key_ref);
+		goto error;
+	}
+
+	key = key_ref_to_ptr(key_ref);
+
+	/* make the changes with the locks held to prevent races */
+	down_read(&key->sem);
+	ret = security_key_get_security(key, name, buffer, blen);
+	up_read(&key->sem);
+
+	key_put(key);
+error:
+	return ret;
+
+} /* end keyctl_get_security() */
+
+/*****************************************************************************/
+/*
  * the key control system call
  */
 asmlinkage long sys_keyctl(int option, unsigned long arg2, unsigned long arg3,
@@ -1035,6 +1111,18 @@ asmlinkage long sys_keyctl(int option, u
 	case KEYCTL_SET_REQKEY_KEYRING:
 		return keyctl_set_reqkey_keyring(arg2);
 
+	case KEYCTL_SET_SECURITY:
+		return keyctl_set_security((key_serial_t) arg2,
+					   (const char __user *) arg3,
+					   (const void __user *) arg4,
+					   (size_t) arg5);
+
+	case KEYCTL_GET_SECURITY:
+		return keyctl_get_security((key_serial_t) arg2,
+					   (const char __user *) arg3,
+					   (void __user *) arg4,
+					   (size_t) arg5);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff -uNrp linux-2.6.14-rc3-keys/security/keys/Makefile linux-2.6.14-rc3-keys-lsm/security/keys/Makefile
--- linux-2.6.14-rc3-keys/security/keys/Makefile	2005-08-30 13:56:44.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/security/keys/Makefile	2005-10-05 16:30:41.000000000 +0100
@@ -6,6 +6,7 @@ obj-y := \
 	key.o \
 	keyring.o \
 	keyctl.o \
+	permission.o \
 	process_keys.o \
 	request_key.o \
 	request_key_auth.o \
diff -uNrp linux-2.6.14-rc3-keys/security/keys/permission.c linux-2.6.14-rc3-keys-lsm/security/keys/permission.c
--- linux-2.6.14-rc3-keys/security/keys/permission.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-rc3-keys-lsm/security/keys/permission.c	2005-10-05 15:36:22.000000000 +0100
@@ -0,0 +1,81 @@
+/* permission.c: key permission determination
+ *
+ * Copyright (C) 2005 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include "internal.h"
+
+/*****************************************************************************/
+/*
+ * check to see whether permission is granted to use a key in the desired way,
+ * but permit the security modules to override
+ */
+int key_task_permission(const key_ref_t key_ref,
+			struct task_struct *context,
+			key_perm_t perm)
+{
+	struct key *key;
+	key_perm_t kperm;
+	int ret;
+
+	/* let the security module have first say
+	 * - it should return:
+	 *	+ve to grant access
+	 *	0   to deny access
+	 *	-ve to fall back to normal permission checking
+	 */
+	ret = security_key_permission(key_ref, context, perm);
+	if (ret >= 0)
+		return ret;
+
+	/* normal permissions checking */
+	key = key_ref_to_ptr(key_ref);
+
+	/* use the top 8-bits of permissions for keys the caller possesses */
+	if (is_key_possessed(key_ref)) {
+		kperm = key->perm >> 24;
+		goto use_these_perms;
+	}
+
+	/* use the second 8-bits of permissions for keys the caller owns */
+	if (key->uid == context->fsuid) {
+		kperm = key->perm >> 16;
+		goto use_these_perms;
+	}
+
+	/* use the third 8-bits of permissions for keys the caller has a group
+	 * membership in common with */
+	if (key->gid != -1 && key->perm & KEY_GRP_ALL) {
+		if (key->gid == context->fsgid) {
+			kperm = key->perm >> 8;
+			goto use_these_perms;
+		}
+
+		task_lock(context);
+		ret = groups_search(context->group_info, key->gid);
+		task_unlock(context);
+
+		if (ret) {
+			kperm = key->perm >> 8;
+			goto use_these_perms;
+		}
+	}
+
+	/* otherwise use the least-significant 8-bits */
+	kperm = key->perm;
+
+use_these_perms:
+	kperm = kperm & perm & KEY_ALL;
+
+	return kperm == perm;
+
+} /* end key_task_permission() */
+
+EXPORT_SYMBOL(key_task_permission);
