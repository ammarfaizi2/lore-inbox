Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262785AbVCXLrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVCXLrX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 06:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVCXLrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 06:47:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46235 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262790AbVCXLlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 06:41:47 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <29760.1111611165@redhat.com> 
References: <29760.1111611165@redhat.com>  <29204.1111608899@redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, Michael A Halcrow <mahalcro@us.ibm.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Keys: Make request-key create an authorisation key [try #2]
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Thu, 24 Mar 2005 11:41:25 +0000
Message-ID: <23998.1111664485@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes the following changes:

 (1) There's a new special key type called ".request_key_auth".

     This is an authorisation key for when one process requests a key and
     another process is started to construct it. This type of key cannot be
     created by the user; nor can it be requested by kernel services.

     Authorisation keys hold two references:

     (a) Each refers to a key being constructed. When the key being
     	 constructed is instantiated the authorisation key is revoked,
     	 rendering it of no further use.

     (b) The "authorising process". This is either:

     	 (i) the process that called request_key(), or:

     	 (ii) if the process that called request_key() itself had an
     	      authorisation key in its session keyring, then the authorising
     	      process referred to by that authorisation key will also be
     	      referred to by the new authorisation key.

	 This means that the process that initiated a chain of key requests
	 will authorise the lot of them, and will, by default, wind up with
	 the keys obtained from them in its keyrings.

 (2) request_key() creates an authorisation key which is then passed to
     /sbin/request-key in as part of a new session keyring.

 (3) When request_key() is searching for a key to hand back to the caller, if
     it comes across an authorisation key in the session keyring of the
     calling process, it will also search the keyrings of the process
     specified therein and it will use the specified process's credentials
     (fsuid, fsgid, groups) to do that rather than the calling process's
     credentials.

     This allows a process started by /sbin/request-key to find keys belonging
     to the authorising process.

 (4) A key can be read, even if the process executing KEYCTL_READ doesn't have
     direct read or search permission if that key is contained within the
     keyrings of a process specified by an authorisation key found within the
     calling process's session keyring, and is searchable using the
     credentials of the authorising process.

     This allows a process started by /sbin/request-key to read keys belonging
     to the authorising process.

 (5) The magic KEY_SPEC_*_KEYRING key IDs when passed to KEYCTL_INSTANTIATE or
     KEYCTL_NEGATE will specify a keyring of the authorising process, rather
     than the process doing the instantiation.

 (6) One of the process keyrings can be nominated as the default to which
     request_key() should attach new keys if not otherwise specified. This is
     done with KEYCTL_SET_REQKEY_KEYRING and one of the KEY_REQKEY_DEFL_*
     constants. The current setting can also be read using this call.

 (7) request_key() is partially interruptible. If it is waiting for another
     process to finish constructing a key, it can be interrupted. This permits
     a request-key cycle to be broken without recourse to rebooting.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-reqkey-2612rc1mm1-2.diff 
 Documentation/keys.txt           |   34 +++++++
 include/linux/key-ui.h           |   41 ++++++++
 include/linux/key.h              |    9 -
 include/linux/keyctl.h           |   11 ++
 include/linux/sched.h            |    8 +
 kernel/sys.c                     |    2 
 security/keys/Makefile           |    5 -
 security/keys/compat.c           |    7 +
 security/keys/internal.h         |   45 ++++++++-
 security/keys/key.c              |   24 +++--
 security/keys/keyctl.c           |  174 ++++++++++++++++++++++++-------------
 security/keys/keyring.c          |   67 ++++++++++++--
 security/keys/process_keys.c     |  179 +++++++++++++++++++++++---------------
 security/keys/request_key.c      |  183 ++++++++++++++++++++++++++++++++-------
 security/keys/request_key_auth.c |  180 ++++++++++++++++++++++++++++++++++++++
 15 files changed, 779 insertions(+), 190 deletions(-)

diff -uNrp linux-2.6.12-rc1-mm1-keys-rcu-session/Documentation/keys.txt linux-2.6.12-rc1-mm1-keys-reqkey/Documentation/keys.txt
--- linux-2.6.12-rc1-mm1-keys-rcu-session/Documentation/keys.txt	2005-03-23 17:22:23.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-reqkey/Documentation/keys.txt	2005-03-23 18:48:50.111271107 +0000
@@ -591,6 +591,37 @@ The keyctl syscall functions are:
      this case too.
 
 
+ (*) Set the default request-key destination keyring.
+
+	long keyctl(KEYCTL_SET_REQKEY_KEYRING, int reqkey_defl);
+
+     This sets the default keyring to which implicitly requested keys will be
+     attached for this thread. reqkey_defl should be one of these constants:
+
+	CONSTANT				VALUE	NEW DEFAULT KEYRING
+	======================================	======	=======================
+	KEY_REQKEY_DEFL_NO_CHANGE		-1	No change
+	KEY_REQKEY_DEFL_DEFAULT			0	Default[1]
+	KEY_REQKEY_DEFL_THREAD_KEYRING		1	Thread keyring
+	KEY_REQKEY_DEFL_PROCESS_KEYRING		2	Process keyring
+	KEY_REQKEY_DEFL_SESSION_KEYRING		3	Session keyring
+	KEY_REQKEY_DEFL_USER_KEYRING		4	User keyring
+	KEY_REQKEY_DEFL_USER_SESSION_KEYRING	5	User session keyring
+	KEY_REQKEY_DEFL_GROUP_KEYRING		6	Group keyring
+
+     The old default will be returned if successful and error EINVAL will be
+     returned if reqkey_defl is not one of the above values.
+
+     The default keyring can be overridden by the keyring indicated to the
+     request_key() system call.
+
+     Note that this setting is inherited across fork/exec.
+
+     [1] The default default is: the thread keyring if there is one, otherwise
+     the process keyring if there is one, otherwise the session keyring if
+     there is one, otherwise the user default session keyring.
+
+
 ===============
 KERNEL SERVICES
 ===============
@@ -626,6 +657,9 @@ payload contents" for more information.
     Should the function fail error ENOKEY, EKEYEXPIRED or EKEYREVOKED will be
     returned.
 
+    If successful, the key will have been attached to the default keyring for
+    implicitly obtained request-key keys, as set by KEYCTL_SET_REQKEY_KEYRING.
+
 
 (*) When it is no longer required, the key should be released using:
 
diff -uNrp linux-2.6.12-rc1-mm1-keys-rcu-session/include/linux/keyctl.h linux-2.6.12-rc1-mm1-keys-reqkey/include/linux/keyctl.h
--- linux-2.6.12-rc1-mm1-keys-rcu-session/include/linux/keyctl.h	2005-01-04 11:13:54.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-reqkey/include/linux/keyctl.h	2005-03-23 18:48:50.113270939 +0000
@@ -20,6 +20,16 @@
 #define KEY_SPEC_USER_SESSION_KEYRING	-5	/* - key ID for UID-session keyring */
 #define KEY_SPEC_GROUP_KEYRING		-6	/* - key ID for GID-specific keyring */
 
+/* request-key default keyrings */
+#define KEY_REQKEY_DEFL_NO_CHANGE		-1
+#define KEY_REQKEY_DEFL_DEFAULT			0
+#define KEY_REQKEY_DEFL_THREAD_KEYRING		1
+#define KEY_REQKEY_DEFL_PROCESS_KEYRING		2
+#define KEY_REQKEY_DEFL_SESSION_KEYRING		3
+#define KEY_REQKEY_DEFL_USER_KEYRING		4
+#define KEY_REQKEY_DEFL_USER_SESSION_KEYRING	5
+#define KEY_REQKEY_DEFL_GROUP_KEYRING		6
+
 /* keyctl commands */
 #define KEYCTL_GET_KEYRING_ID		0	/* ask for a keyring's ID */
 #define KEYCTL_JOIN_SESSION_KEYRING	1	/* join or start named session keyring */
@@ -35,5 +45,6 @@
 #define KEYCTL_READ			11	/* read a key or keyring's contents */
 #define KEYCTL_INSTANTIATE		12	/* instantiate a partially constructed key */
 #define KEYCTL_NEGATE			13	/* negate a partially constructed key */
+#define KEYCTL_SET_REQKEY_KEYRING	14	/* set default request-key keyring */
 
 #endif /*  _LINUX_KEYCTL_H */
diff -uNrp linux-2.6.12-rc1-mm1-keys-rcu-session/include/linux/key.h linux-2.6.12-rc1-mm1-keys-reqkey/include/linux/key.h
--- linux-2.6.12-rc1-mm1-keys-rcu-session/include/linux/key.h	2005-03-23 17:35:16.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-reqkey/include/linux/key.h	2005-03-23 18:50:21.583606906 +0000
@@ -199,10 +199,12 @@ extern int key_payload_reserve(struct ke
 extern int key_instantiate_and_link(struct key *key,
 				    const void *data,
 				    size_t datalen,
-				    struct key *keyring);
+				    struct key *keyring,
+				    struct key *instkey);
 extern int key_negate_and_link(struct key *key,
 			       unsigned timeout,
-			       struct key *keyring);
+			       struct key *keyring,
+			       struct key *instkey);
 extern void key_revoke(struct key *key);
 extern void key_put(struct key *key);
 
@@ -245,9 +247,6 @@ extern struct key *keyring_search(struct
 				  struct key_type *type,
 				  const char *description);
 
-extern struct key *search_process_keyrings(struct key_type *type,
-					   const char *description);
-
 extern int keyring_add_key(struct key *keyring,
 			   struct key *key);
 
diff -uNrp linux-2.6.12-rc1-mm1-keys-rcu-session/include/linux/key-ui.h linux-2.6.12-rc1-mm1-keys-reqkey/include/linux/key-ui.h
--- linux-2.6.12-rc1-mm1-keys-rcu-session/include/linux/key-ui.h	2005-03-23 17:22:44.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-reqkey/include/linux/key-ui.h	2005-03-23 18:48:50.118270520 +0000
@@ -1,4 +1,4 @@
-/* key-ui.h: key userspace interface stuff for use by keyfs
+/* key-ui.h: key userspace interface stuff
  *
  * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
@@ -84,8 +84,45 @@ static inline int key_any_permission(con
 	return kperm != 0;
 }
 
+static inline int key_task_groups_search(struct task_struct *tsk, gid_t gid)
+{
+	int ret;
+
+	task_lock(tsk);
+	ret = groups_search(tsk->group_info, gid);
+	task_unlock(tsk);
+	return ret;
+}
+
+static inline int key_task_permission(const struct key *key,
+				      struct task_struct *context,
+				      key_perm_t perm)
+{
+	key_perm_t kperm;
+
+	if (key->uid == context->fsuid) {
+		kperm = key->perm >> 16;
+	}
+	else if (key->gid != -1 &&
+		 key->perm & KEY_GRP_ALL && (
+			 key->gid == context->fsgid ||
+			 key_task_groups_search(context, key->gid)
+			 )
+		 ) {
+		kperm = key->perm >> 8;
+	}
+	else {
+		kperm = key->perm;
+	}
+
+	kperm = kperm & perm & KEY_ALL;
+
+	return kperm == perm;
+
+}
 
-extern struct key *lookup_user_key(key_serial_t id, int create, int part,
+extern struct key *lookup_user_key(struct task_struct *context,
+				   key_serial_t id, int create, int partial,
 				   key_perm_t perm);
 
 extern long join_session_keyring(const char *name);
diff -uNrp linux-2.6.12-rc1-mm1-keys-rcu-session/include/linux/sched.h linux-2.6.12-rc1-mm1-keys-reqkey/include/linux/sched.h
--- linux-2.6.12-rc1-mm1-keys-rcu-session/include/linux/sched.h	2005-03-23 17:22:44.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-reqkey/include/linux/sched.h	2005-03-23 19:02:09.174377850 +0000
@@ -596,9 +596,10 @@ struct group_info {
 		groups_free(group_info); \
 } while (0)
 
-struct group_info *groups_alloc(int gidsetsize);
-void groups_free(struct group_info *group_info);
-int set_current_groups(struct group_info *group_info);
+extern struct group_info *groups_alloc(int gidsetsize);
+extern void groups_free(struct group_info *group_info);
+extern int set_current_groups(struct group_info *group_info);
+extern int groups_search(struct group_info *group_info, gid_t grp);
 /* access the groups "array" with this macro */
 #define GROUP_AT(gi, i) \
     ((gi)->blocks[(i)/NGROUPS_PER_BLOCK][(i)%NGROUPS_PER_BLOCK])
@@ -697,6 +698,7 @@ struct task_struct {
 	struct user_struct *user;
 #ifdef CONFIG_KEYS
 	struct key *thread_keyring;	/* keyring private to this thread */
+	unsigned char jit_keyring;	/* default keyring to attach requested keys to */
 #endif
 	int oomkilladj; /* OOM kill score adjustment (bit shift). */
 	char comm[TASK_COMM_LEN]; /* executable name excluding path
diff -uNrp linux-2.6.12-rc1-mm1-keys-rcu-session/kernel/sys.c linux-2.6.12-rc1-mm1-keys-reqkey/kernel/sys.c
--- linux-2.6.12-rc1-mm1-keys-rcu-session/kernel/sys.c	2005-03-23 17:22:45.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-reqkey/kernel/sys.c	2005-03-23 19:01:21.643353422 +0000
@@ -1244,7 +1244,7 @@ static void groups_sort(struct group_inf
 }
 
 /* a simple bsearch */
-static int groups_search(struct group_info *group_info, gid_t grp)
+int groups_search(struct group_info *group_info, gid_t grp)
 {
 	int left, right;
 
diff -uNrp linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/compat.c linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/compat.c
--- linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/compat.c	2005-03-02 12:09:11.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/compat.c	2005-03-23 18:49:00.588393166 +0000
@@ -1,6 +1,6 @@
 /* compat.c: 32-bit compatibility syscall for 64-bit systems
  *
- * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -24,7 +24,7 @@
  * - if you can, you should call sys_keyctl directly
  */
 asmlinkage long compat_sys_keyctl(u32 option,
-			      u32 arg2, u32 arg3, u32 arg4, u32 arg5)
+				  u32 arg2, u32 arg3, u32 arg4, u32 arg5)
 {
 	switch (option) {
 	case KEYCTL_GET_KEYRING_ID:
@@ -71,6 +71,9 @@ asmlinkage long compat_sys_keyctl(u32 op
 	case KEYCTL_NEGATE:
 		return keyctl_negate_key(arg2, arg3, arg4);
 
+	case KEYCTL_SET_REQKEY_KEYRING:
+		return keyctl_set_reqkey_keyring(arg2);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff -uNrp linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/internal.h linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/internal.h
--- linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/internal.h	2005-01-04 11:14:01.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/internal.h	2005-03-23 19:54:36.086520529 +0000
@@ -1,6 +1,6 @@
 /* internal.h: authentication token and access key management internal defs
  *
- * Copyright (C) 2003 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2003-5 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -15,6 +15,16 @@
 #include <linux/key.h>
 #include <linux/key-ui.h>
 
+#if 0
+#define kenter(FMT, a...)	printk("==> %s("FMT")\n",__FUNCTION__ , ## a)
+#define kleave(FMT, a...)	printk("<== %s()"FMT"\n",__FUNCTION__ , ## a)
+#define kdebug(FMT, a...)	printk(FMT"\n" , ## a)
+#else
+#define kenter(FMT, a...)	do {} while(0)
+#define kleave(FMT, a...)	do {} while(0)
+#define kdebug(FMT, a...)	do {} while(0)
+#endif
+
 extern struct key_type key_type_dead;
 extern struct key_type key_type_user;
 
@@ -66,20 +76,46 @@ extern struct key *__keyring_search_one(
 					const char *description,
 					key_perm_t perm);
 
+extern struct key *keyring_search_instkey(struct key *keyring,
+					  key_serial_t target_id);
+
 typedef int (*key_match_func_t)(const struct key *, const void *);
 
 extern struct key *keyring_search_aux(struct key *keyring,
+				      struct task_struct *tsk,
 				      struct key_type *type,
 				      const void *description,
 				      key_match_func_t match);
 
-extern struct key *search_process_keyrings_aux(struct key_type *type,
-					       const void *description,
-					       key_match_func_t match);
+extern struct key *search_process_keyrings(struct key_type *type,
+					   const void *description,
+					   key_match_func_t match,
+					   struct task_struct *tsk);
 
 extern struct key *find_keyring_by_name(const char *name, key_serial_t bound);
 
 extern int install_thread_keyring(struct task_struct *tsk);
+extern int install_process_keyring(struct task_struct *tsk);
+
+extern struct key *request_key_and_link(struct key_type *type,
+					const char *description,
+					const char *callout_info,
+					struct key *dest_keyring);
+
+/*
+ * request_key authorisation
+ */
+struct request_key_auth {
+	struct key		*target_key;
+	struct task_struct	*context;
+	pid_t			pid;
+};
+
+extern struct key_type key_type_request_key_auth;
+extern struct key *request_key_auth_new(struct key *target,
+					struct key **_rkakey);
+
+extern struct key *key_get_instantiation_authkey(key_serial_t target_id);
 
 /*
  * keyctl functions
@@ -100,6 +136,7 @@ extern long keyctl_setperm_key(key_seria
 extern long keyctl_instantiate_key(key_serial_t, const void __user *,
 				   size_t, key_serial_t);
 extern long keyctl_negate_key(key_serial_t, unsigned, key_serial_t);
+extern long keyctl_set_reqkey_keyring(int);
 
 
 /*
diff -uNrp linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/key.c linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/key.c
--- linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/key.c	2005-03-23 17:22:46.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/key.c	2005-03-23 18:49:00.594392663 +0000
@@ -1,6 +1,6 @@
 /* key.c: basic authentication token and access key management
  *
- * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -391,7 +391,8 @@ EXPORT_SYMBOL(key_payload_reserve);
 static int __key_instantiate_and_link(struct key *key,
 				      const void *data,
 				      size_t datalen,
-				      struct key *keyring)
+				      struct key *keyring,
+				      struct key *instkey)
 {
 	int ret, awaken;
 
@@ -419,6 +420,10 @@ static int __key_instantiate_and_link(st
 			/* and link it into the destination keyring */
 			if (keyring)
 				ret = __key_link(keyring, key);
+
+			/* disable the authorisation key */
+			if (instkey)
+				key_revoke(instkey);
 		}
 	}
 
@@ -439,19 +444,21 @@ static int __key_instantiate_and_link(st
 int key_instantiate_and_link(struct key *key,
 			     const void *data,
 			     size_t datalen,
-			     struct key *keyring)
+			     struct key *keyring,
+			     struct key *instkey)
 {
 	int ret;
 
 	if (keyring)
 		down_write(&keyring->sem);
 
-	ret = __key_instantiate_and_link(key, data, datalen, keyring);
+	ret = __key_instantiate_and_link(key, data, datalen, keyring, instkey);
 
 	if (keyring)
 		up_write(&keyring->sem);
 
 	return ret;
+
 } /* end key_instantiate_and_link() */
 
 EXPORT_SYMBOL(key_instantiate_and_link);
@@ -462,7 +469,8 @@ EXPORT_SYMBOL(key_instantiate_and_link);
  */
 int key_negate_and_link(struct key *key,
 			unsigned timeout,
-			struct key *keyring)
+			struct key *keyring,
+			struct key *instkey)
 {
 	struct timespec now;
 	int ret, awaken;
@@ -495,6 +503,10 @@ int key_negate_and_link(struct key *key,
 		/* and link it into the destination keyring */
 		if (keyring)
 			ret = __key_link(keyring, key);
+
+		/* disable the authorisation key */
+		if (instkey)
+			key_revoke(instkey);
 	}
 
 	up_write(&key_construction_sem);
@@ -781,7 +793,7 @@ struct key *key_create_or_update(struct 
 	}
 
 	/* instantiate it and link it into the target keyring */
-	ret = __key_instantiate_and_link(key, payload, plen, keyring);
+	ret = __key_instantiate_and_link(key, payload, plen, keyring, NULL);
 	if (ret < 0) {
 		key_put(key);
 		key = ERR_PTR(ret);
diff -uNrp linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/keyctl.c linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/keyctl.c
--- linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/keyctl.c	2005-03-23 17:22:46.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/keyctl.c	2005-03-23 18:49:00.599392244 +0000
@@ -1,6 +1,6 @@
 /* keyctl.c: userspace keyctl operations
  *
- * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -49,6 +49,13 @@ asmlinkage long sys_add_key(const char _
 		goto error;
 	type[31] = '\0';
 
+	if (!type[0])
+		goto error;
+
+	ret = -EPERM;
+	if (type[0] == '.')
+		goto error;
+
 	ret = -EFAULT;
 	dlen = strnlen_user(_description, PAGE_SIZE - 1);
 	if (dlen <= 0)
@@ -82,7 +89,7 @@ asmlinkage long sys_add_key(const char _
 	}
 
 	/* find the target keyring (which must be writable) */
-	keyring = lookup_user_key(ringid, 1, 0, KEY_WRITE);
+	keyring = lookup_user_key(NULL, ringid, 1, 0, KEY_WRITE);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
 		goto error3;
@@ -181,7 +188,7 @@ asmlinkage long sys_request_key(const ch
 	/* get the destination keyring if specified */
 	dest = NULL;
 	if (destringid) {
-		dest = lookup_user_key(destringid, 1, 0, KEY_WRITE);
+		dest = lookup_user_key(NULL, destringid, 1, 0, KEY_WRITE);
 		if (IS_ERR(dest)) {
 			ret = PTR_ERR(dest);
 			goto error3;
@@ -196,23 +203,15 @@ asmlinkage long sys_request_key(const ch
 	}
 
 	/* do the search */
-	key = request_key(ktype, description, callout_info);
+	key = request_key_and_link(ktype, description, callout_info, dest);
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
 		goto error5;
 	}
 
-	/* link the resulting key to the destination keyring */
-	if (dest) {
-		ret = key_link(dest, key);
-		if (ret < 0)
-			goto error6;
-	}
-
 	ret = key->serial;
 
- error6:
-	key_put(key);
+ 	key_put(key);
  error5:
 	key_type_put(ktype);
  error4:
@@ -237,7 +236,7 @@ long keyctl_get_keyring_ID(key_serial_t 
 	struct key *key;
 	long ret;
 
-	key = lookup_user_key(id, create, 0, KEY_SEARCH);
+	key = lookup_user_key(NULL, id, create, 0, KEY_SEARCH);
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
 		goto error;
@@ -324,7 +323,7 @@ long keyctl_update_key(key_serial_t id,
 	}
 
 	/* find the target key (which must be writable) */
-	key = lookup_user_key(id, 0, 0, KEY_WRITE);
+	key = lookup_user_key(NULL, id, 0, 0, KEY_WRITE);
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
 		goto error2;
@@ -352,7 +351,7 @@ long keyctl_revoke_key(key_serial_t id)
 	struct key *key;
 	long ret;
 
-	key = lookup_user_key(id, 0, 0, KEY_WRITE);
+	key = lookup_user_key(NULL, id, 0, 0, KEY_WRITE);
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
 		goto error;
@@ -378,7 +377,7 @@ long keyctl_keyring_clear(key_serial_t r
 	struct key *keyring;
 	long ret;
 
-	keyring = lookup_user_key(ringid, 1, 0, KEY_WRITE);
+	keyring = lookup_user_key(NULL, ringid, 1, 0, KEY_WRITE);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
 		goto error;
@@ -404,13 +403,13 @@ long keyctl_keyring_link(key_serial_t id
 	struct key *keyring, *key;
 	long ret;
 
-	keyring = lookup_user_key(ringid, 1, 0, KEY_WRITE);
+	keyring = lookup_user_key(NULL, ringid, 1, 0, KEY_WRITE);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
 		goto error;
 	}
 
-	key = lookup_user_key(id, 1, 0, KEY_LINK);
+	key = lookup_user_key(NULL, id, 1, 0, KEY_LINK);
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
 		goto error2;
@@ -438,13 +437,13 @@ long keyctl_keyring_unlink(key_serial_t 
 	struct key *keyring, *key;
 	long ret;
 
-	keyring = lookup_user_key(ringid, 0, 0, KEY_WRITE);
+	keyring = lookup_user_key(NULL, ringid, 0, 0, KEY_WRITE);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
 		goto error;
 	}
 
-	key = lookup_user_key(id, 0, 0, 0);
+	key = lookup_user_key(NULL, id, 0, 0, 0);
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
 		goto error2;
@@ -475,16 +474,29 @@ long keyctl_describe_key(key_serial_t ke
 			 char __user *buffer,
 			 size_t buflen)
 {
-	struct key *key;
+	struct key *key, *instkey;
 	char *tmpbuf;
 	long ret;
 
-	key = lookup_user_key(keyid, 0, 1, KEY_VIEW);
+	key = lookup_user_key(NULL, keyid, 0, 1, KEY_VIEW);
 	if (IS_ERR(key)) {
+		/* viewing a key under construction is permitted if we have the
+		 * authorisation token handy */
+		if (PTR_ERR(key) == -EACCES) {
+			instkey = key_get_instantiation_authkey(keyid);
+			if (!IS_ERR(instkey)) {
+				key_put(instkey);
+				key = lookup_user_key(NULL, keyid, 0, 1, 0);
+				if (!IS_ERR(key))				
+					goto okay;
+			}
+		}
+
 		ret = PTR_ERR(key);
 		goto error;
 	}
 
+okay:
 	/* calculate how much description we're going to return */
 	ret = -ENOMEM;
 	tmpbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
@@ -568,7 +580,7 @@ long keyctl_keyring_search(key_serial_t 
 		goto error2;
 
 	/* get the keyring at which to begin the search */
-	keyring = lookup_user_key(ringid, 0, 0, KEY_SEARCH);
+	keyring = lookup_user_key(NULL, ringid, 0, 0, KEY_SEARCH);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
 		goto error2;
@@ -577,7 +589,7 @@ long keyctl_keyring_search(key_serial_t 
 	/* get the destination keyring if specified */
 	dest = NULL;
 	if (destringid) {
-		dest = lookup_user_key(destringid, 1, 0, KEY_WRITE);
+		dest = lookup_user_key(NULL, destringid, 1, 0, KEY_WRITE);
 		if (IS_ERR(dest)) {
 			ret = PTR_ERR(dest);
 			goto error3;
@@ -656,24 +668,23 @@ long keyctl_read_key(key_serial_t keyid,
 	long ret;
 
 	/* find the key first */
-	key = lookup_user_key(keyid, 0, 0, 0);
+	key = lookup_user_key(NULL, keyid, 0, 0, 0);
 	if (!IS_ERR(key)) {
 		/* see if we can read it directly */
 		if (key_permission(key, KEY_READ))
 			goto can_read_key;
 
-		/* can't; see if it's searchable from this process's
-		 * keyrings */
-		ret = -ENOKEY;
-		if (key_permission(key, KEY_SEARCH)) {
-			/* okay - we do have search permission on the key
-			 * itself, but do we have the key? */
-			skey = search_process_keyrings_aux(key->type, key,
-							   keyctl_read_key_same);
-			if (!IS_ERR(skey))
-				goto can_read_key2;
-		}
+		/* we can't; see if it's searchable from this process's
+		 * keyrings
+		 * - we automatically take account of the fact that it may be
+		 *   dangling off an instantiation key
+		 */
+		skey = search_process_keyrings(key->type, key,
+					       keyctl_read_key_same, current);
+		if (!IS_ERR(skey))
+			goto can_read_key2;
 
+		ret = PTR_ERR(skey);
 		goto error2;
 	}
 
@@ -719,7 +730,7 @@ long keyctl_chown_key(key_serial_t id, u
 	if (uid == (uid_t) -1 && gid == (gid_t) -1)
 		goto error;
 
-	key = lookup_user_key(id, 1, 1, 0);
+	key = lookup_user_key(NULL, id, 1, 1, 0);
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
 		goto error;
@@ -776,7 +787,7 @@ long keyctl_setperm_key(key_serial_t id,
 	if (perm & ~(KEY_USR_ALL | KEY_GRP_ALL | KEY_OTH_ALL))
 		goto error;
 
-	key = lookup_user_key(id, 1, 1, 0);
+	key = lookup_user_key(NULL, id, 1, 1, 0);
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
 		goto error;
@@ -809,7 +820,8 @@ long keyctl_instantiate_key(key_serial_t
 			    size_t plen,
 			    key_serial_t ringid)
 {
-	struct key *key, *keyring;
+	struct request_key_auth *rka;
+	struct key *instkey, *keyring;
 	void *payload;
 	long ret;
 
@@ -831,18 +843,21 @@ long keyctl_instantiate_key(key_serial_t
 			goto error2;
 	}
 
-	/* find the target key (which must be writable) */
-	key = lookup_user_key(id, 0, 1, KEY_WRITE);
-	if (IS_ERR(key)) {
-		ret = PTR_ERR(key);
+	/* find the instantiation authorisation key */
+	instkey = key_get_instantiation_authkey(id);
+	if (IS_ERR(instkey)) {
+		ret = PTR_ERR(instkey);
 		goto error2;
 	}
 
-	/* find the destination keyring if present (which must also be
-	 * writable) */
+	rka = instkey->payload.data;
+
+	/* find the destination keyring amongst those belonging to the
+	 * requesting task */
 	keyring = NULL;
 	if (ringid) {
-		keyring = lookup_user_key(ringid, 1, 0, KEY_WRITE);
+		keyring = lookup_user_key(rka->context, ringid, 1, 0,
+					  KEY_WRITE);
 		if (IS_ERR(keyring)) {
 			ret = PTR_ERR(keyring);
 			goto error3;
@@ -850,11 +865,12 @@ long keyctl_instantiate_key(key_serial_t
 	}
 
 	/* instantiate the key and link it into a keyring */
-	ret = key_instantiate_and_link(key, payload, plen, keyring);
+	ret = key_instantiate_and_link(rka->target_key, payload, plen,
+				       keyring, instkey);
 
 	key_put(keyring);
  error3:
-	key_put(key);
+	key_put(instkey);
  error2:
 	kfree(payload);
  error:
@@ -869,21 +885,24 @@ long keyctl_instantiate_key(key_serial_t
  */
 long keyctl_negate_key(key_serial_t id, unsigned timeout, key_serial_t ringid)
 {
-	struct key *key, *keyring;
+	struct request_key_auth *rka;
+	struct key *instkey, *keyring;
 	long ret;
 
-	/* find the target key (which must be writable) */
-	key = lookup_user_key(id, 0, 1, KEY_WRITE);
-	if (IS_ERR(key)) {
-		ret = PTR_ERR(key);
+	/* find the instantiation authorisation key */
+	instkey = key_get_instantiation_authkey(id);
+	if (IS_ERR(instkey)) {
+		ret = PTR_ERR(instkey);
 		goto error;
 	}
 
+	rka = instkey->payload.data;
+
 	/* find the destination keyring if present (which must also be
 	 * writable) */
 	keyring = NULL;
 	if (ringid) {
-		keyring = lookup_user_key(ringid, 1, 0, KEY_WRITE);
+		keyring = lookup_user_key(NULL, ringid, 1, 0, KEY_WRITE);
 		if (IS_ERR(keyring)) {
 			ret = PTR_ERR(keyring);
 			goto error2;
@@ -891,11 +910,11 @@ long keyctl_negate_key(key_serial_t id, 
 	}
 
 	/* instantiate the key and link it into a keyring */
-	ret = key_negate_and_link(key, timeout, keyring);
+	ret = key_negate_and_link(rka->target_key, timeout, keyring, instkey);
 
 	key_put(keyring);
  error2:
-	key_put(key);
+	key_put(instkey);
  error:
 	return ret;
 
@@ -903,6 +922,44 @@ long keyctl_negate_key(key_serial_t id, 
 
 /*****************************************************************************/
 /*
+ * set the default keyring in which request_key() will cache keys
+ * - return the old setting
+ */
+long keyctl_set_reqkey_keyring(int reqkey_defl)
+{
+	int ret;
+
+	switch (reqkey_defl) {
+	case KEY_REQKEY_DEFL_THREAD_KEYRING:
+		ret = install_thread_keyring(current);
+		if (ret < 0)
+			return ret;
+		goto set;
+
+	case KEY_REQKEY_DEFL_PROCESS_KEYRING:
+		ret = install_process_keyring(current);
+		if (ret < 0)
+			return ret;
+
+	case KEY_REQKEY_DEFL_DEFAULT:
+	case KEY_REQKEY_DEFL_SESSION_KEYRING:
+	case KEY_REQKEY_DEFL_USER_KEYRING:
+	case KEY_REQKEY_DEFL_USER_SESSION_KEYRING:
+	set:
+		current->jit_keyring = reqkey_defl;
+
+	case KEY_REQKEY_DEFL_NO_CHANGE:
+		return current->jit_keyring;
+
+	case KEY_SPEC_GROUP_KEYRING:
+	default:
+		return -EINVAL;
+	}
+
+} /* end keyctl_set_reqkey_keyring() */
+
+/*****************************************************************************/
+/*
  * the key control system call
  */
 asmlinkage long sys_keyctl(int option, unsigned long arg2, unsigned long arg3,
@@ -971,6 +1028,9 @@ asmlinkage long sys_keyctl(int option, u
 					 (unsigned) arg3,
 					 (key_serial_t) arg4);
 
+	case KEYCTL_SET_REQKEY_KEYRING:
+		return keyctl_set_reqkey_keyring(arg2);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff -uNrp linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/keyring.c linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/keyring.c
--- linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/keyring.c	2005-03-23 17:22:46.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/keyring.c	2005-03-23 18:49:00.603391909 +0000
@@ -1,6 +1,6 @@
 /* keyring.c: keyring handling
  *
- * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -308,7 +308,7 @@ struct key *keyring_alloc(const char *de
 			    uid, gid, KEY_USR_ALL, not_in_quota);
 
 	if (!IS_ERR(keyring)) {
-		ret = key_instantiate_and_link(keyring, NULL, 0, dest);
+		ret = key_instantiate_and_link(keyring, NULL, 0, dest, NULL);
 		if (ret < 0) {
 			key_put(keyring);
 			keyring = ERR_PTR(ret);
@@ -326,11 +326,12 @@ struct key *keyring_alloc(const char *de
  * - we only find keys on which we have search permission
  * - we use the supplied match function to see if the description (or other
  *   feature of interest) matches
- * - we readlock the keyrings as we search down the tree
+ * - we rely on RCU to prevent the keyring lists from disappearing on us
  * - we return -EAGAIN if we didn't find any matching key
  * - we return -ENOKEY if we only found negative matching keys
  */
 struct key *keyring_search_aux(struct key *keyring,
+			       struct task_struct *context,
 			       struct key_type *type,
 			       const void *description,
 			       key_match_func_t match)
@@ -352,7 +353,7 @@ struct key *keyring_search_aux(struct ke
 
 	/* top keyring must have search permission to begin the search */
 	key = ERR_PTR(-EACCES);
-	if (!key_permission(keyring, KEY_SEARCH))
+	if (!key_task_permission(keyring, context, KEY_SEARCH))
 		goto error;
 
 	key = ERR_PTR(-ENOTDIR);
@@ -392,7 +393,7 @@ struct key *keyring_search_aux(struct ke
 			continue;
 
 		/* key must have search permissions */
-		if (!key_permission(key, KEY_SEARCH))
+		if (!key_task_permission(key, context, KEY_SEARCH))
 			continue;
 
 		/* we set a different error code if we find a negative key */
@@ -418,7 +419,7 @@ struct key *keyring_search_aux(struct ke
 		if (sp >= KEYRING_SEARCH_MAX_DEPTH)
 			continue;
 
-		if (!key_permission(key, KEY_SEARCH))
+		if (!key_task_permission(key, context, KEY_SEARCH))
 			continue;
 
 		/* stack the current position */
@@ -468,7 +469,11 @@ struct key *keyring_search(struct key *k
 			   struct key_type *type,
 			   const char *description)
 {
-	return keyring_search_aux(keyring, type, description, type->match);
+	if (!type->match)
+		return ERR_PTR(-ENOKEY);
+
+	return keyring_search_aux(keyring, current,
+				  type, description, type->match);
 
 } /* end keyring_search() */
 
@@ -496,7 +501,8 @@ struct key *__keyring_search_one(struct 
 			key = klist->keys[loop];
 
 			if (key->type == ktype &&
-			    key->type->match(key, description) &&
+			    (!key->type->match ||
+			     key->type->match(key, description)) &&
 			    key_permission(key, perm) &&
 			    !test_bit(KEY_FLAG_REVOKED, &key->flags)
 			    )
@@ -517,6 +523,51 @@ struct key *__keyring_search_one(struct 
 
 /*****************************************************************************/
 /*
+ * search for an instantiation authorisation key matching a target key
+ * - the RCU read lock must be held by the caller
+ * - a target_id of zero specifies any valid token
+ */
+struct key *keyring_search_instkey(struct key *keyring,
+				   key_serial_t target_id)
+{
+	struct request_key_auth *rka;
+	struct keyring_list *klist;
+	struct key *instkey;
+	int loop;
+
+	klist = rcu_dereference(keyring->payload.subscriptions);
+	if (klist) {
+		for (loop = 0; loop < klist->nkeys; loop++) {
+			instkey = klist->keys[loop];
+
+			if (instkey->type != &key_type_request_key_auth)
+				continue;
+
+			rka = instkey->payload.data;
+			if (target_id && rka->target_key->serial != target_id)
+				continue;
+
+			/* the auth key is revoked during instantiation */
+			if (!test_bit(KEY_FLAG_REVOKED, &instkey->flags))
+				goto found;
+
+			instkey = ERR_PTR(-EKEYREVOKED);
+			goto error;
+		}
+	}
+
+	instkey = ERR_PTR(-EACCES);
+	goto error;
+
+found:
+	atomic_inc(&instkey->usage);
+error:
+	return instkey;
+
+} /* end keyring_search_instkey() */
+
+/*****************************************************************************/
+/*
  * find a keyring with the specified name
  * - all named keyrings are searched
  * - only find keyrings with search permission for the process
diff -uNrp linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/Makefile linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/Makefile
--- linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/Makefile	2005-01-04 11:14:01.000000000 +0000
+++ linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/Makefile	2005-03-23 18:49:00.605391741 +0000
@@ -7,8 +7,9 @@ obj-y := \
 	keyring.o \
 	keyctl.o \
 	process_keys.o \
-	user_defined.o \
-	request_key.o
+	request_key.o \
+	request_key_auth.o \
+	user_defined.o
 
 obj-$(CONFIG_KEYS_COMPAT) += compat.o
 obj-$(CONFIG_PROC_FS) += proc.o
diff -uNrp linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/process_keys.c linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/process_keys.c
--- linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/process_keys.c	2005-03-23 18:27:12.055768099 +0000
+++ linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/process_keys.c	2005-03-23 19:54:31.348917132 +0000
@@ -165,7 +165,7 @@ int install_thread_keyring(struct task_s
 /*
  * make sure a process keyring is installed
  */
-static int install_process_keyring(struct task_struct *tsk)
+int install_process_keyring(struct task_struct *tsk)
 {
 	unsigned long flags;
 	struct key *keyring;
@@ -376,12 +376,13 @@ void key_fsgid_changed(struct task_struc
  * - we return -EAGAIN if we didn't find any matching key
  * - we return -ENOKEY if we found only negative matching keys
  */
-struct key *search_process_keyrings_aux(struct key_type *type,
-					const void *description,
-					key_match_func_t match)
+struct key *search_process_keyrings(struct key_type *type,
+				    const void *description,
+				    key_match_func_t match,
+				    struct task_struct *context)
 {
-	struct task_struct *tsk = current;
-	struct key *key, *ret, *err;
+	struct request_key_auth *rka;
+	struct key *key, *ret, *err, *instkey;
 
 	/* we want to return -EAGAIN or -ENOKEY if any of the keyrings were
 	 * searchable, but we failed to find a key or we found a negative key;
@@ -395,9 +396,9 @@ struct key *search_process_keyrings_aux(
 	err = ERR_PTR(-EAGAIN);
 
 	/* search the thread keyring first */
-	if (tsk->thread_keyring) {
-		key = keyring_search_aux(tsk->thread_keyring, type,
-					 description, match);
+	if (context->thread_keyring) {
+		key = keyring_search_aux(context->thread_keyring,
+					 context, type, description, match);
 		if (!IS_ERR(key))
 			goto found;
 
@@ -415,9 +416,9 @@ struct key *search_process_keyrings_aux(
 	}
 
 	/* search the process keyring second */
-	if (tsk->signal->process_keyring) {
-		key = keyring_search_aux(tsk->signal->process_keyring,
-					 type, description, match);
+	if (context->signal->process_keyring) {
+		key = keyring_search_aux(context->signal->process_keyring,
+					 context, type, description, match);
 		if (!IS_ERR(key))
 			goto found;
 
@@ -434,53 +435,93 @@ struct key *search_process_keyrings_aux(
 		}
 	}
 
-	/* search the session keyring last */
-	if (tsk->signal->session_keyring) {
+	/* search the session keyring */
+	if (context->signal->session_keyring) {
 		rcu_read_lock();
 		key = keyring_search_aux(
-			rcu_dereference(tsk->signal->session_keyring),
-			type, description, match);
+			rcu_dereference(context->signal->session_keyring),
+			context, type, description, match);
 		rcu_read_unlock();
+
+		if (!IS_ERR(key))
+			goto found;
+
+		switch (PTR_ERR(key)) {
+		case -EAGAIN: /* no key */
+			if (ret)
+				break;
+		case -ENOKEY: /* negative key */
+			ret = key;
+			break;
+		default:
+			err = key;
+			break;
+		}
+
+		/* if this process has a session keyring and that has an
+		 * instantiation authorisation key in the bottom level, then we
+		 * also search the keyrings of the process mentioned there */
+		if (context != current)
+			goto no_key;
+
+		rcu_read_lock();
+		instkey = __keyring_search_one(
+			rcu_dereference(context->signal->session_keyring),
+			&key_type_request_key_auth, NULL, 0);
+		rcu_read_unlock();
+
+		if (IS_ERR(instkey))
+			goto no_key;
+
+		rka = instkey->payload.data;
+
+		key = search_process_keyrings(type, description, match,
+					      rka->context);
+		key_put(instkey);
+
+		if (!IS_ERR(key))
+			goto found;
+
+		switch (PTR_ERR(key)) {
+		case -EAGAIN: /* no key */
+			if (ret)
+				break;
+		case -ENOKEY: /* negative key */
+			ret = key;
+			break;
+		default:
+			err = key;
+			break;
+		}
 	}
+	/* or search the user-session keyring */
 	else {
-		key = keyring_search_aux(tsk->user->session_keyring,
-					 type, description, match);
-	}
-
-	if (!IS_ERR(key))
-		goto found;
+		key = keyring_search_aux(context->user->session_keyring,
+					 context, type, description, match);
+		if (!IS_ERR(key))
+			goto found;
 
-	switch (PTR_ERR(key)) {
-	case -EAGAIN: /* no key */
-		if (ret)
+		switch (PTR_ERR(key)) {
+		case -EAGAIN: /* no key */
+			if (ret)
+				break;
+		case -ENOKEY: /* negative key */
+			ret = key;
 			break;
-	case -ENOKEY: /* negative key */
-		ret = key;
-		break;
-	default:
-		err = key;
-		break;
+		default:
+			err = key;
+			break;
+		}
 	}
 
+
+no_key:
 	/* no key - decide on the error we're going to go for */
 	key = ret ? ret : err;
 
- found:
+found:
 	return key;
 
-} /* end search_process_keyrings_aux() */
-
-/*****************************************************************************/
-/*
- * search the process keyrings for the first matching key
- * - we return -EAGAIN if we didn't find any matching key
- * - we return -ENOKEY if we found only negative matching keys
- */
-struct key *search_process_keyrings(struct key_type *type,
-				    const char *description)
-{
-	return search_process_keyrings_aux(type, description, type->match);
-
 } /* end search_process_keyrings() */
 
 /*****************************************************************************/
@@ -489,72 +530,73 @@ struct key *search_process_keyrings(stru
  * - don't create special keyrings unless so requested
  * - partially constructed keys aren't found unless requested
  */
-struct key *lookup_user_key(key_serial_t id, int create, int partial,
-			    key_perm_t perm)
+struct key *lookup_user_key(struct task_struct *context, key_serial_t id,
+			    int create, int partial, key_perm_t perm)
 {
-	struct task_struct *tsk = current;
-	unsigned long flags;
 	struct key *key;
 	int ret;
 
+	if (!context)
+		context = current;
+
 	key = ERR_PTR(-ENOKEY);
 
 	switch (id) {
 	case KEY_SPEC_THREAD_KEYRING:
-		if (!tsk->thread_keyring) {
+		if (!context->thread_keyring) {
 			if (!create)
 				goto error;
 
-			ret = install_thread_keyring(tsk);
+			ret = install_thread_keyring(context);
 			if (ret < 0) {
 				key = ERR_PTR(ret);
 				goto error;
 			}
 		}
 
-		key = tsk->thread_keyring;
+		key = context->thread_keyring;
 		atomic_inc(&key->usage);
 		break;
 
 	case KEY_SPEC_PROCESS_KEYRING:
-		if (!tsk->signal->process_keyring) {
+		if (!context->signal->process_keyring) {
 			if (!create)
 				goto error;
 
-			ret = install_process_keyring(tsk);
+			ret = install_process_keyring(context);
 			if (ret < 0) {
 				key = ERR_PTR(ret);
 				goto error;
 			}
 		}
 
-		key = tsk->signal->process_keyring;
+		key = context->signal->process_keyring;
 		atomic_inc(&key->usage);
 		break;
 
 	case KEY_SPEC_SESSION_KEYRING:
-		if (!tsk->signal->session_keyring) {
+		if (!context->signal->session_keyring) {
 			/* always install a session keyring upon access if one
 			 * doesn't exist yet */
 			ret = install_session_keyring(
-			       tsk, tsk->user->session_keyring);
+			       context, context->user->session_keyring);
 			if (ret < 0)
 				goto error;
 		}
 
-		spin_lock_irqsave(&tsk->sighand->siglock, flags);
-		key = tsk->signal->session_keyring;
+		rcu_read_lock();
+		key = rcu_dereference(context->signal->session_keyring);
 		atomic_inc(&key->usage);
-		spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
+		rcu_read_unlock();
 		break;
 
 	case KEY_SPEC_USER_KEYRING:
-		key = tsk->user->uid_keyring;
+		key = context->user->uid_keyring;
 		atomic_inc(&key->usage);
 		break;
 
 	case KEY_SPEC_USER_SESSION_KEYRING:
-		key = tsk->user->session_keyring;
+		key = context->user->session_keyring;
 		atomic_inc(&key->usage);
 		break;
 
@@ -574,7 +616,7 @@ struct key *lookup_user_key(key_serial_t
 		break;
 	}
 
-	/* check the status and permissions */
+	/* check the status */
 	if (perm) {
 		ret = key_validate(key);
 		if (ret < 0)
@@ -585,8 +627,10 @@ struct key *lookup_user_key(key_serial_t
 	if (!partial && !test_bit(KEY_FLAG_INSTANTIATED, &key->flags))
 		goto invalid_key;
 
+	/* check the permissions */
 	ret = -EACCES;
-	if (!key_permission(key, perm))
+
+	if (!key_task_permission(key, context, perm))
 		goto invalid_key;
 
  error:
@@ -609,7 +653,6 @@ struct key *lookup_user_key(key_serial_t
 long join_session_keyring(const char *name)
 {
 	struct task_struct *tsk = current;
-	unsigned long flags;
 	struct key *keyring;
 	long ret;
 
@@ -619,9 +662,9 @@ long join_session_keyring(const char *na
 		if (ret < 0)
 			goto error;
 
-		spin_lock_irqsave(&tsk->sighand->siglock, flags);
-		ret = tsk->signal->session_keyring->serial;
-		spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
+		rcu_read_lock();
+		ret = rcu_dereference(tsk->signal->session_keyring)->serial;
+		rcu_read_unlock();
 		goto error;
 	}
 
diff -uNrp linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/request_key_auth.c linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/request_key_auth.c
--- linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/request_key_auth.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/request_key_auth.c	2005-03-23 18:49:07.239835813 +0000
@@ -0,0 +1,180 @@
+/* request_key_auth.c: request key authorisation controlling key def
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
+#include <linux/sched.h>
+#include <linux/err.h>
+#include <linux/seq_file.h>
+#include "internal.h"
+
+static int request_key_auth_instantiate(struct key *, const void *, size_t);
+static void request_key_auth_describe(const struct key *, struct seq_file *);
+static void request_key_auth_destroy(struct key *);
+
+/*
+ * the request-key authorisation key type definition
+ */
+struct key_type key_type_request_key_auth = {
+	.name		= ".request_key_auth",
+	.def_datalen	= sizeof(struct request_key_auth),
+	.instantiate	= request_key_auth_instantiate,
+	.describe	= request_key_auth_describe,
+	.destroy	= request_key_auth_destroy,
+};
+
+/*****************************************************************************/
+/*
+ * instantiate a request-key authorisation record
+ */
+static int request_key_auth_instantiate(struct key *key,
+					const void *data,
+					size_t datalen)
+{
+	struct request_key_auth *rka, *irka;
+	struct key *instkey;
+	int ret;
+
+	ret = -ENOMEM;
+	rka = kmalloc(sizeof(*rka), GFP_KERNEL);
+	if (rka) {
+		/* see if the calling process is already servicing the key
+		 * request of another process */
+		instkey = key_get_instantiation_authkey(0);
+		if (!IS_ERR(instkey)) {
+			/* it is - use that instantiation context here too */
+			irka = instkey->payload.data;
+			rka->context = irka->context;
+			rka->pid = irka->pid;
+			key_put(instkey);
+		}
+		else {
+			/* it isn't - use this process as the context */
+			rka->context = current;
+			rka->pid = current->pid;
+		}
+
+		rka->target_key = key_get((struct key *) data);
+		key->payload.data = rka;
+		ret = 0;
+	}
+
+	return ret;
+
+} /* end request_key_auth_instantiate() */
+
+/*****************************************************************************/
+/*
+ *
+ */
+static void request_key_auth_describe(const struct key *key,
+				      struct seq_file *m)
+{
+	struct request_key_auth *rka = key->payload.data;
+
+	seq_puts(m, "key:");
+	seq_puts(m, key->description);
+	seq_printf(m, " pid:%d", rka->pid);
+
+} /* end request_key_auth_describe() */
+
+/*****************************************************************************/
+/*
+ * destroy an instantiation authorisation token key
+ */
+static void request_key_auth_destroy(struct key *key)
+{
+	struct request_key_auth *rka = key->payload.data;
+
+	kenter("{%d}", key->serial);
+
+	key_put(rka->target_key);
+
+} /* end request_key_auth_destroy() */
+
+/*****************************************************************************/
+/*
+ * create a session keyring to be for the invokation of /sbin/request-key and
+ * stick an authorisation token in it
+ */
+struct key *request_key_auth_new(struct key *target, struct key **_rkakey)
+{
+	struct key *keyring, *rkakey = NULL;
+	char desc[20];
+	int ret;
+
+	kenter("%d,", target->serial);
+
+	/* allocate a new session keyring */
+	sprintf(desc, "_req.%u", target->serial);
+
+	keyring = keyring_alloc(desc, current->fsuid, current->fsgid, 1, NULL);
+	if (IS_ERR(keyring)) {
+		kleave("= %ld", PTR_ERR(keyring));
+		return keyring;
+	}
+
+	/* allocate the auth key */
+	sprintf(desc, "%x", target->serial);
+
+	rkakey = key_alloc(&key_type_request_key_auth, desc,
+			   current->fsuid, current->fsgid,
+			   KEY_USR_VIEW, 1);
+	if (IS_ERR(rkakey)) {
+		key_put(keyring);
+		kleave("= %ld", PTR_ERR(rkakey));
+		return rkakey;
+	}
+
+	/* construct and attach to the keyring */
+	ret = key_instantiate_and_link(rkakey, target, 0, keyring, NULL);
+	if (ret < 0) {
+		key_revoke(rkakey);
+		key_put(rkakey);
+		key_put(keyring);
+		kleave("= %d", ret);
+		return ERR_PTR(ret);
+	}
+
+	*_rkakey = rkakey;
+	kleave(" = {%d} ({%d})", keyring->serial, rkakey->serial);
+	return keyring;
+
+} /* end request_key_auth_new() */
+
+/*****************************************************************************/
+/*
+ * get the authorisation key for instantiation of a specific key if attached to
+ * the current process's keyrings
+ * - this key is inserted into a keyring and that is set as /sbin/request-key's
+ *   session keyring
+ * - a target_id of zero specifies any valid token
+ */
+struct key *key_get_instantiation_authkey(key_serial_t target_id)
+{
+	struct task_struct *tsk = current;
+	struct key *instkey;
+
+	/* we must have our own personal session keyring */
+	if (!tsk->signal->session_keyring)
+		return ERR_PTR(-EACCES);
+
+	/* and it must contain a suitable request authorisation key
+	 * - lock RCU against session keyring changing
+	 */
+	rcu_read_lock();
+
+	instkey = keyring_search_instkey(
+		rcu_dereference(tsk->signal->session_keyring), target_id);
+
+	rcu_read_unlock();
+	return instkey;
+
+} /* end key_get_instantiation_authkey() */
diff -uNrp linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/request_key.c linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/request_key.c
--- linux-2.6.12-rc1-mm1-keys-rcu-session/security/keys/request_key.c	2005-03-23 18:14:13.908029567 +0000
+++ linux-2.6.12-rc1-mm1-keys-reqkey/security/keys/request_key.c	2005-03-23 18:58:15.990885713 +0000
@@ -1,6 +1,6 @@
 /* request_key.c: request a key from userspace
  *
- * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/kmod.h>
 #include <linux/err.h>
+#include <linux/keyctl.h>
 #include "internal.h"
 
 struct key_construction {
@@ -27,18 +28,26 @@ DECLARE_WAIT_QUEUE_HEAD(request_key_cons
 /*
  * request userspace finish the construction of a key
  * - execute "/sbin/request-key <op> <key> <uid> <gid> <keyring> <keyring> <keyring> <info>"
- * - if callout_info is an empty string, it'll be rendered as a "-" instead
  */
 static int call_request_key(struct key *key,
 			    const char *op,
 			    const char *callout_info)
 {
 	struct task_struct *tsk = current;
-	unsigned long flags;
 	key_serial_t prkey, sskey;
+	struct key *session_keyring, *rkakey;
 	char *argv[10], *envp[3], uid_str[12], gid_str[12];
 	char key_str[12], keyring_str[3][12];
-	int i;
+	int ret, i;
+
+	kenter("{%d},%s,%s", key->serial, op, callout_info);
+
+	/* generate a new session keyring with an auth key in it */
+	session_keyring = request_key_auth_new(key, &rkakey);
+	if (IS_ERR(session_keyring)) {
+		ret = PTR_ERR(session_keyring);
+		goto error;
+	}
 
 	/* record the UID and GID */
 	sprintf(uid_str, "%d", current->fsuid);
@@ -55,17 +64,17 @@ static int call_request_key(struct key *
 	if (tsk->signal->process_keyring)
 		prkey = tsk->signal->process_keyring->serial;
 
-	sskey = 0;
-	spin_lock_irqsave(&tsk->sighand->siglock, flags);
-	if (tsk->signal->session_keyring)
-		sskey = tsk->signal->session_keyring->serial;
-	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
-
+	sprintf(keyring_str[1], "%d", prkey);
 
-	if (!sskey)
+	if (tsk->signal->session_keyring) {
+		rcu_read_lock();
+		sskey = rcu_dereference(tsk->signal->session_keyring)->serial;
+		rcu_read_unlock();
+	}
+	else {
 		sskey = tsk->user->session_keyring->serial;
+	}
 
-	sprintf(keyring_str[1], "%d", prkey);
 	sprintf(keyring_str[2], "%d", sskey);
 
 	/* set up a minimal environment */
@@ -84,11 +93,20 @@ static int call_request_key(struct key *
 	argv[i++] = keyring_str[0];
 	argv[i++] = keyring_str[1];
 	argv[i++] = keyring_str[2];
-	argv[i++] = callout_info[0] ? (char *) callout_info : "-";
+	argv[i++] = (char *) callout_info;
 	argv[i] = NULL;
 
 	/* do it */
-	return call_usermodehelper_keys(argv[0], argv, envp, NULL, 1);
+	ret = call_usermodehelper_keys(argv[0], argv, envp, session_keyring, 1);
+
+	/* dispose of the special keys */
+	key_revoke(rkakey);
+	key_put(rkakey);
+	key_put(session_keyring);
+
+ error:
+	kleave(" = %d", ret);
+	return ret;
 
 } /* end call_request_key() */
 
@@ -107,6 +125,8 @@ static struct key *__request_key_constru
 	struct key *key;
 	int ret, negated;
 
+	kenter("%s,%s,%s", type->name, description, callout_info);
+
 	/* create a key and add it to the queue */
 	key = key_alloc(type, description,
 			current->fsuid, current->fsgid, KEY_USR_ALL, 0);
@@ -143,6 +163,7 @@ static struct key *__request_key_constru
 	}
 
  out:
+	kleave(" = %p", key);
 	return key;
 
  request_failed:
@@ -216,6 +237,9 @@ static struct key *request_key_construct
 
 	DECLARE_WAITQUEUE(myself, current);
 
+	kenter("%s,%s,{%d},%s",
+	       type->name, description, user->uid, callout_info);
+
 	/* see if there's such a key under construction already */
 	down_write(&key_construction_sem);
 
@@ -232,6 +256,7 @@ static struct key *request_key_construct
 	/* see about getting userspace to construct the key */
 	key = __request_key_construction(type, description, callout_info);
  error:
+	kleave(" = %p", key);
 	return key;
 
 	/* someone else has the same key under construction
@@ -245,9 +270,11 @@ static struct key *request_key_construct
 	add_wait_queue(&request_key_conswq, &myself);
 
 	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		set_current_state(TASK_INTERRUPTIBLE);
 		if (!test_bit(KEY_FLAG_USER_CONSTRUCT, &ckey->flags))
 			break;
+		if (signal_pending(current))
+			break;
 		schedule();
 	}
 
@@ -267,21 +294,84 @@ static struct key *request_key_construct
 
 /*****************************************************************************/
 /*
+ * link a freshly minted key to an appropriate destination keyring
+ */
+static void request_key_link(struct key *key, struct key *dest_keyring)
+{
+	struct task_struct *tsk = current;
+	struct key *drop = NULL;
+
+	kenter("{%d},%p", key->serial, dest_keyring);
+
+	/* find the appropriate keyring */
+	if (!dest_keyring) {
+		switch (tsk->jit_keyring) {
+		case KEY_REQKEY_DEFL_DEFAULT:
+		case KEY_REQKEY_DEFL_THREAD_KEYRING:
+			dest_keyring = tsk->thread_keyring;
+			if (dest_keyring)
+				break;
+
+		case KEY_REQKEY_DEFL_PROCESS_KEYRING:
+			dest_keyring = tsk->signal->process_keyring;
+			if (dest_keyring)
+				break;
+
+		case KEY_REQKEY_DEFL_SESSION_KEYRING:
+			rcu_read_lock();
+			dest_keyring = key_get(
+				rcu_dereference(tsk->signal->session_keyring));
+			rcu_read_unlock();
+			drop = dest_keyring;
+
+			if (dest_keyring)
+				break;
+
+		case KEY_REQKEY_DEFL_USER_SESSION_KEYRING:
+			dest_keyring = current->user->session_keyring;
+			break;
+
+		case KEY_REQKEY_DEFL_USER_KEYRING:
+			dest_keyring = current->user->uid_keyring;
+			break;
+
+		case KEY_REQKEY_DEFL_NO_CHANGE:
+		case KEY_SPEC_GROUP_KEYRING:
+		default:
+			BUG();
+		}
+	}
+
+	/* and attach the key to it */
+	key_link(dest_keyring, key);
+
+	key_put(drop);
+
+	kleave("");
+
+} /* end request_key_link() */
+
+/*****************************************************************************/
+/*
  * request a key
  * - search the process's keyrings
  * - check the list of keys being created or updated
- * - call out to userspace for a key if requested (supplementary info can be
- *   passed)
+ * - call out to userspace for a key if supplementary info was provided
+ * - cache the key in an appropriate keyring
  */
-struct key *request_key(struct key_type *type,
-			const char *description,
-			const char *callout_info)
+struct key *request_key_and_link(struct key_type *type,
+				 const char *description,
+				 const char *callout_info,
+				 struct key *dest_keyring)
 {
 	struct key_user *user;
 	struct key *key;
 
+	kenter("%s,%s,%s,%p",
+	       type->name, description, callout_info, dest_keyring);
+
 	/* search all the process keyrings for a key */
-	key = search_process_keyrings_aux(type, description, type->match);
+	key = search_process_keyrings(type, description, type->match, current);
 
 	if (PTR_ERR(key) == -EAGAIN) {
 		/* the search failed, but the keyrings were searchable, so we
@@ -292,12 +382,13 @@ struct key *request_key(struct key_type 
 
 		/* - get hold of the user's construction queue */
 		user = key_user_lookup(current->fsuid);
-		if (!user) {
-			key = ERR_PTR(-ENOMEM);
-			goto error;
-		}
+		if (!user)
+			goto nomem;
 
-		for (;;) {
+		do {
+			if (signal_pending(current))
+				goto interrupted;
+				
 			/* ask userspace (returns NULL if it waited on a key
 			 * being constructed) */
 			key = request_key_construction(type, description,
@@ -307,18 +398,46 @@ struct key *request_key(struct key_type 
 
 			/* someone else made the key we want, so we need to
 			 * search again as it might now be available to us */
-			key = search_process_keyrings_aux(type, description,
-							  type->match);
-			if (PTR_ERR(key) != -EAGAIN)
-				break;
-		}
+			key = search_process_keyrings(type, description,
+						      type->match, current);
+
+		} while (PTR_ERR(key) == -EAGAIN);
 
 		key_user_put(user);
+
+		/* link the new key into the appropriate keyring */
+		if (!PTR_ERR(key))
+			request_key_link(key, dest_keyring);
 	}
 
- error:
+error:
+	kleave(" = %p", key);
 	return key;
 
+nomem:
+	key = ERR_PTR(-ENOMEM);
+	goto error;
+
+interrupted:
+	key_user_put(user);
+	key = ERR_PTR(-EINTR);
+	goto error;
+
+} /* end request_key_and_link() */
+
+/*****************************************************************************/
+/*
+ * request a key
+ * - search the process's keyrings
+ * - check the list of keys being created or updated
+ * - call out to userspace for a key if supplementary info was provided
+ */
+struct key *request_key(struct key_type *type,
+			const char *description,
+			const char *callout_info)
+{
+	return request_key_and_link(type, description, callout_info, NULL);
+
 } /* end request_key() */
 
 EXPORT_SYMBOL(request_key);
