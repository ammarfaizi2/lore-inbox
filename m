Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbVKPTTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbVKPTTi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbVKPTTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:19:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52443 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751502AbVKPTTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:19:36 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <25194.1132150768@warthog.cambridge.redhat.com> 
References: <25194.1132150768@warthog.cambridge.redhat.com>  <25039.1132150357@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Alexander Zangerl <az@bond.edu.au>
Cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Permit running process to instantiate keys
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 16 Nov 2005 19:19:16 +0000
Message-ID: <26381.1132168756@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes it possible for a running process (such as gssapid)
to be able to instantiate a key, as was requested by Trond Myklebust for NFS4.

The patch makes the following changes:

 (1) A new, optional key type method has been added. This permits a key type
     to intercept requests at the point /sbin/request-key is about to be
     spawned and do something else with them - passing them over the
     rpc_pipefs files or netlink sockets for instance.

     The uninstantiated key, the authorisation key and the intended operation
     name are passed to the method.

 (2) The callout_info is no longer passed as an argument to /sbin/request-key
     to prevent unauthorised viewing of this data using ps or by looking in
     /proc/pid/cmdline.

     This means that the old /sbin/request-key program will not work with the
     patched kernel as it will expect to see an extra argument that is no
     longer there.

     A revised keyutils package will be made available tomorrow.

 (3) The callout_info is now attached to the authorisation key. Reading this
     key will retrieve the information.

 (4) A new field has been added to the task_struct. This holds the
     authorisation key currently active for a thread. Searches now look here
     for the caller's set of keys rather than looking for an auth key in the
     lowest level of the session keyring.

     This permits a thread to be servicing multiple requests at once and to
     switch between them. Note that this is per-thread, not per-process, and
     so is usable in multithreaded programs.

     The setting of this field is inherited across fork and exec.

 (5) A new keyctl function (KEYCTL_ASSUME_AUTHORITY) has been added that
     permits a thread to assume the authority to deal with an uninstantiated
     key. Assumption is only permitted if the authorisation key associated
     with the uninstantiated key is somewhere in the thread's keyrings.

     This function can also clear the assumption.

 (6) A new magic key specifier has been added to refer to the currently
     assumed authorisation key (KEY_SPEC_REQKEY_AUTH_KEY).

 (7) Instantiation will only proceed if the appropriate authorisation key is
     assumed first. The assumed authorisation key is discarded if
     instantiation is successful.

 (8) key_validate() is moved from the file of request_key functions to the
     file of permissions functions.

 (9) The documentation is updated.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-reqkey-2615rc1.diff
 Documentation/keys-request-key.txt |   22 ++--
 Documentation/keys.txt             |   24 ++++
 include/linux/key.h                |   12 ++
 include/linux/keyctl.h             |    2 
 include/linux/sched.h              |    1 
 security/keys/compat.c             |    3 
 security/keys/internal.h           |    4 
 security/keys/keyctl.c             |  107 ++++++++++++++++----
 security/keys/keyring.c            |   45 --------
 security/keys/permission.c         |   32 ++++++
 security/keys/process_keys.c       |   71 +++++++------
 security/keys/request_key.c        |  108 +++++++++-----------
 security/keys/request_key_auth.c   |  192 ++++++++++++++++++++++---------------
 13 files changed, 378 insertions(+), 245 deletions(-)

diff -uNrp linux-2.6.15-rc1-keys-multilink/Documentation/keys-request-key.txt linux-2.6.15-rc1-keys-reqkey/Documentation/keys-request-key.txt
--- linux-2.6.15-rc1-keys-multilink/Documentation/keys-request-key.txt	2005-11-01 13:18:53.000000000 +0000
+++ linux-2.6.15-rc1-keys-reqkey/Documentation/keys-request-key.txt	2005-11-16 15:52:50.000000000 +0000
@@ -56,10 +56,12 @@ A request proceeds in the following mann
  (4) request_key() then forks and executes /sbin/request-key with a new session
      keyring that contains a link to auth key V.
 
- (5) /sbin/request-key execs an appropriate program to perform the actual
+ (5) /sbin/request-key assumes the authority associated with key U.
+
+ (6) /sbin/request-key execs an appropriate program to perform the actual
      instantiation.
 
- (6) The program may want to access another key from A's context (say a
+ (7) The program may want to access another key from A's context (say a
      Kerberos TGT key). It just requests the appropriate key, and the keyring
      search notes that the session keyring has auth key V in its bottom level.
 
@@ -67,19 +69,19 @@ A request proceeds in the following mann
      UID, GID, groups and security info of process A as if it was process A,
      and come up with key W.
 
- (7) The program then does what it must to get the data with which to
+ (8) The program then does what it must to get the data with which to
      instantiate key U, using key W as a reference (perhaps it contacts a
      Kerberos server using the TGT) and then instantiates key U.
 
- (8) Upon instantiating key U, auth key V is automatically revoked so that it
+ (9) Upon instantiating key U, auth key V is automatically revoked so that it
      may not be used again.
 
- (9) The program then exits 0 and request_key() deletes key V and returns key
+(10) The program then exits 0 and request_key() deletes key V and returns key
      U to the caller.
 
-This also extends further. If key W (step 5 above) didn't exist, key W would be
-created uninstantiated, another auth key (X) would be created [as per step 3]
-and another copy of /sbin/request-key spawned [as per step 4]; but the context
+This also extends further. If key W (step 7 above) didn't exist, key W would be
+created uninstantiated, another auth key (X) would be created (as per step 3)
+and another copy of /sbin/request-key spawned (as per step 4); but the context
 specified by auth key X will still be process A, as it was in auth key V.
 
 This is because process A's keyrings can't simply be attached to
@@ -138,8 +140,8 @@ until one succeeds:
 
  (3) The process's session keyring is searched.
 
- (4) If the process has a request_key() authorisation key in its session
-     keyring then:
+ (4) If the process has assumed the authority associated with a request_key()
+     authorisation key then:
 
      (a) If extant, the calling process's thread keyring is searched.
 
diff -uNrp linux-2.6.15-rc1-keys-multilink/Documentation/keys.txt linux-2.6.15-rc1-keys-reqkey/Documentation/keys.txt
--- linux-2.6.15-rc1-keys-multilink/Documentation/keys.txt	2005-11-16 14:02:22.000000000 +0000
+++ linux-2.6.15-rc1-keys-reqkey/Documentation/keys.txt	2005-11-16 15:47:23.000000000 +0000
@@ -308,6 +308,8 @@ process making the call:
 	KEY_SPEC_USER_KEYRING		-4	UID-specific keyring
 	KEY_SPEC_USER_SESSION_KEYRING	-5	UID-session keyring
 	KEY_SPEC_GROUP_KEYRING		-6	GID-specific keyring
+	KEY_SPEC_REQKEY_AUTH_KEY	-7	assumed request_key()
+						  authorisation key
 
 
 The main syscalls are:
@@ -645,6 +647,28 @@ The keyctl syscall functions are:
      or expired keys.
 
 
+ (*) Assume the authority granted to instantiate a key
+
+	long keyctl(KEYCTL_ASSUME_AUTHORITY, key_serial_t key);
+
+     This assumes or divests the authority required to instantiate the
+     specified key. Authority can only be assumed if the thread has the
+     authorisation key associated with the specified key in its keyrings
+     somewhere.
+
+     Once authority is assumed, searches for keys will also search the
+     requester's keyrings using the requester's security label, UID, GID and
+     groups.
+
+     If the requested authority is unavailable, error EPERM will be returned,
+     likewise if the authority has been revoked because the target key is
+     already instantiated.
+
+     If the specified key is 0, then any assumed authority will be divested.
+
+     The assumed authorititive key is inherited across fork and exec.
+
+
 ===============
 KERNEL SERVICES
 ===============
diff -uNrp linux-2.6.15-rc1-keys-multilink/include/linux/keyctl.h linux-2.6.15-rc1-keys-reqkey/include/linux/keyctl.h
--- linux-2.6.15-rc1-keys-multilink/include/linux/keyctl.h	2005-11-16 11:49:53.000000000 +0000
+++ linux-2.6.15-rc1-keys-reqkey/include/linux/keyctl.h	2005-11-16 15:34:49.000000000 +0000
@@ -19,6 +19,7 @@
 #define KEY_SPEC_USER_KEYRING		-4	/* - key ID for UID-specific keyring */
 #define KEY_SPEC_USER_SESSION_KEYRING	-5	/* - key ID for UID-session keyring */
 #define KEY_SPEC_GROUP_KEYRING		-6	/* - key ID for GID-specific keyring */
+#define KEY_SPEC_REQKEY_AUTH_KEY	-7	/* - key ID for assumed request_key auth key */
 
 /* request-key default keyrings */
 #define KEY_REQKEY_DEFL_NO_CHANGE		-1
@@ -47,5 +48,6 @@
 #define KEYCTL_NEGATE			13	/* negate a partially constructed key */
 #define KEYCTL_SET_REQKEY_KEYRING	14	/* set default request-key keyring */
 #define KEYCTL_SET_TIMEOUT		15	/* set key timeout */
+#define KEYCTL_ASSUME_AUTHORITY		16	/* assume request_key() authorisation */
 
 #endif /*  _LINUX_KEYCTL_H */
diff -uNrp linux-2.6.15-rc1-keys-multilink/include/linux/key.h linux-2.6.15-rc1-keys-reqkey/include/linux/key.h
--- linux-2.6.15-rc1-keys-multilink/include/linux/key.h	2005-11-16 11:42:25.000000000 +0000
+++ linux-2.6.15-rc1-keys-reqkey/include/linux/key.h	2005-11-16 17:18:38.000000000 +0000
@@ -177,6 +177,8 @@ struct key {
 /*
  * kernel managed key type definition
  */
+typedef int (*request_key_actor_t)(struct key *key, struct key *authkey, const char *op);
+
 struct key_type {
 	/* name of the type */
 	const char *name;
@@ -226,6 +228,16 @@ struct key_type {
 	 */
 	long (*read)(const struct key *key, char __user *buffer, size_t buflen);
 
+	/* handle request_key() for this type instead of invoking
+	 * /sbin/request-key (optional)
+	 * - key is the key to instantiate
+	 * - authkey is the authority to assume when instantiating this key
+	 * - op is the operation to be done, usually "create"
+	 * - the call must not return until the instantiation process has run
+	 *   its course
+	 */
+	request_key_actor_t request_key;
+
 	/* internal fields */
 	struct list_head	link;		/* link in types list */
 };
diff -uNrp linux-2.6.15-rc1-keys-multilink/include/linux/sched.h linux-2.6.15-rc1-keys-reqkey/include/linux/sched.h
--- linux-2.6.15-rc1-keys-multilink/include/linux/sched.h	2005-11-16 11:42:25.000000000 +0000
+++ linux-2.6.15-rc1-keys-reqkey/include/linux/sched.h	2005-11-16 14:41:37.000000000 +0000
@@ -776,6 +776,7 @@ struct task_struct {
 	unsigned keep_capabilities:1;
 	struct user_struct *user;
 #ifdef CONFIG_KEYS
+	struct key *request_key_auth;	/* assumed request_key authority */
 	struct key *thread_keyring;	/* keyring private to this thread */
 	unsigned char jit_keyring;	/* default keyring to attach requested keys to */
 #endif
diff -uNrp linux-2.6.15-rc1-keys-multilink/security/keys/compat.c linux-2.6.15-rc1-keys-reqkey/security/keys/compat.c
--- linux-2.6.15-rc1-keys-multilink/security/keys/compat.c	2005-11-16 11:51:15.000000000 +0000
+++ linux-2.6.15-rc1-keys-reqkey/security/keys/compat.c	2005-11-16 14:51:53.000000000 +0000
@@ -77,6 +77,9 @@ asmlinkage long compat_sys_keyctl(u32 op
 	case KEYCTL_SET_TIMEOUT:
 		return keyctl_set_timeout(arg2, arg3);
 
+	case KEYCTL_ASSUME_AUTHORITY:
+		return keyctl_assume_authority(arg2);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff -uNrp linux-2.6.15-rc1-keys-multilink/security/keys/internal.h linux-2.6.15-rc1-keys-reqkey/security/keys/internal.h
--- linux-2.6.15-rc1-keys-multilink/security/keys/internal.h	2005-11-16 11:50:59.000000000 +0000
+++ linux-2.6.15-rc1-keys-reqkey/security/keys/internal.h	2005-11-16 18:35:33.000000000 +0000
@@ -108,12 +108,13 @@ extern struct key *request_key_and_link(
 struct request_key_auth {
 	struct key		*target_key;
 	struct task_struct	*context;
+	const char		*callout_info;
 	pid_t			pid;
 };
 
 extern struct key_type key_type_request_key_auth;
 extern struct key *request_key_auth_new(struct key *target,
-					struct key **_rkakey);
+					const char *callout_info);
 
 extern struct key *key_get_instantiation_authkey(key_serial_t target_id);
 
@@ -138,6 +139,7 @@ extern long keyctl_instantiate_key(key_s
 extern long keyctl_negate_key(key_serial_t, unsigned, key_serial_t);
 extern long keyctl_set_reqkey_keyring(int);
 extern long keyctl_set_timeout(key_serial_t, unsigned);
+extern long keyctl_assume_authority(key_serial_t);
 
 
 /*
diff -uNrp linux-2.6.15-rc1-keys-multilink/security/keys/keyctl.c linux-2.6.15-rc1-keys-reqkey/security/keys/keyctl.c
--- linux-2.6.15-rc1-keys-multilink/security/keys/keyctl.c	2005-11-16 12:19:23.000000000 +0000
+++ linux-2.6.15-rc1-keys-reqkey/security/keys/keyctl.c	2005-11-16 18:45:40.000000000 +0000
@@ -834,6 +834,17 @@ long keyctl_instantiate_key(key_serial_t
 	if (plen > 32767)
 		goto error;
 
+	/* the appropriate instantiation authorisation key must have been
+	 * assumed before calling this */
+	ret = -EPERM;
+	instkey = current->request_key_auth;
+	if (!instkey)
+		goto error;
+
+	rka = instkey->payload.data;
+	if (rka->target_key->serial != id)
+		goto error;
+
 	/* pull the payload in if one was supplied */
 	payload = NULL;
 
@@ -848,15 +859,6 @@ long keyctl_instantiate_key(key_serial_t
 			goto error2;
 	}
 
-	/* find the instantiation authorisation key */
-	instkey = key_get_instantiation_authkey(id);
-	if (IS_ERR(instkey)) {
-		ret = PTR_ERR(instkey);
-		goto error2;
-	}
-
-	rka = instkey->payload.data;
-
 	/* find the destination keyring amongst those belonging to the
 	 * requesting task */
 	keyring_ref = NULL;
@@ -865,7 +867,7 @@ long keyctl_instantiate_key(key_serial_t
 					      KEY_WRITE);
 		if (IS_ERR(keyring_ref)) {
 			ret = PTR_ERR(keyring_ref);
-			goto error3;
+			goto error2;
 		}
 	}
 
@@ -874,11 +876,17 @@ long keyctl_instantiate_key(key_serial_t
 				       key_ref_to_ptr(keyring_ref), instkey);
 
 	key_ref_put(keyring_ref);
- error3:
-	key_put(instkey);
- error2:
+
+	/* discard the assumed authority if it's just been disabled by
+	 * instantiation of the key */
+	if (ret == 0) {
+		key_put(current->request_key_auth);
+		current->request_key_auth = NULL;
+	}
+
+error2:
 	kfree(payload);
- error:
+error:
 	return ret;
 
 } /* end keyctl_instantiate_key() */
@@ -895,14 +903,16 @@ long keyctl_negate_key(key_serial_t id, 
 	key_ref_t keyring_ref;
 	long ret;
 
-	/* find the instantiation authorisation key */
-	instkey = key_get_instantiation_authkey(id);
-	if (IS_ERR(instkey)) {
-		ret = PTR_ERR(instkey);
+	/* the appropriate instantiation authorisation key must have been
+	 * assumed before calling this */
+	ret = -EPERM;
+	instkey = current->request_key_auth;
+	if (!instkey)
 		goto error;
-	}
 
 	rka = instkey->payload.data;
+	if (rka->target_key->serial != id)
+		goto error;
 
 	/* find the destination keyring if present (which must also be
 	 * writable) */
@@ -911,7 +921,7 @@ long keyctl_negate_key(key_serial_t id, 
 		keyring_ref = lookup_user_key(NULL, ringid, 1, 0, KEY_WRITE);
 		if (IS_ERR(keyring_ref)) {
 			ret = PTR_ERR(keyring_ref);
-			goto error2;
+			goto error;
 		}
 	}
 
@@ -920,9 +930,15 @@ long keyctl_negate_key(key_serial_t id, 
 				  key_ref_to_ptr(keyring_ref), instkey);
 
 	key_ref_put(keyring_ref);
- error2:
-	key_put(instkey);
- error:
+
+	/* discard the assumed authority if it's just been disabled by
+	 * instantiation of the key */
+	if (ret == 0) {
+		key_put(current->request_key_auth);
+		current->request_key_auth = NULL;
+	}
+
+error:
 	return ret;
 
 } /* end keyctl_negate_key() */
@@ -1007,6 +1023,48 @@ error:
 
 /*****************************************************************************/
 /*
+ * assume the authority to instantiate the specified key
+ */
+asmlinkage long keyctl_assume_authority(key_serial_t id)
+{
+	struct key *authkey;
+	long ret;
+
+	/* special key IDs aren't permitted */
+	ret = -EINVAL;
+	if (id < 0)
+		goto error;
+
+	/* we divest ourselves of authority if given an ID of 0 */
+	if (id == 0) {
+		key_put(current->request_key_auth);
+		current->request_key_auth = NULL;
+		ret = 0;
+		goto error;
+	}
+
+	/* attempt to assume the authority temporarily granted to us whilst we
+	 * instantiate the specified key
+	 * - the authorisation key must be in the current task's keyrings
+	 *   somewhere
+	 */
+	authkey = key_get_instantiation_authkey(id);
+	if (IS_ERR(authkey)) {
+		ret = PTR_ERR(authkey);
+		goto error;
+	}
+
+	key_put(current->request_key_auth);
+	current->request_key_auth = authkey;
+	ret = authkey->serial;
+
+error:
+	return ret;
+
+} /* end keyctl_assume_authority() */
+
+/*****************************************************************************/
+/*
  * the key control system call
  */
 asmlinkage long sys_keyctl(int option, unsigned long arg2, unsigned long arg3,
@@ -1082,6 +1140,9 @@ asmlinkage long sys_keyctl(int option, u
 		return keyctl_set_timeout((key_serial_t) arg2,
 					  (unsigned) arg3);
 
+	case KEYCTL_ASSUME_AUTHORITY:
+		return keyctl_assume_authority((key_serial_t) arg2);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff -uNrp linux-2.6.15-rc1-keys-multilink/security/keys/keyring.c linux-2.6.15-rc1-keys-reqkey/security/keys/keyring.c
--- linux-2.6.15-rc1-keys-multilink/security/keys/keyring.c	2005-11-16 13:36:05.000000000 +0000
+++ linux-2.6.15-rc1-keys-reqkey/security/keys/keyring.c	2005-11-16 17:55:47.000000000 +0000
@@ -545,51 +545,6 @@ key_ref_t __keyring_search_one(key_ref_t
 
 /*****************************************************************************/
 /*
- * search for an instantiation authorisation key matching a target key
- * - the RCU read lock must be held by the caller
- * - a target_id of zero specifies any valid token
- */
-struct key *keyring_search_instkey(struct key *keyring,
-				   key_serial_t target_id)
-{
-	struct request_key_auth *rka;
-	struct keyring_list *klist;
-	struct key *instkey;
-	int loop;
-
-	klist = rcu_dereference(keyring->payload.subscriptions);
-	if (klist) {
-		for (loop = 0; loop < klist->nkeys; loop++) {
-			instkey = klist->keys[loop];
-
-			if (instkey->type != &key_type_request_key_auth)
-				continue;
-
-			rka = instkey->payload.data;
-			if (target_id && rka->target_key->serial != target_id)
-				continue;
-
-			/* the auth key is revoked during instantiation */
-			if (!test_bit(KEY_FLAG_REVOKED, &instkey->flags))
-				goto found;
-
-			instkey = ERR_PTR(-EKEYREVOKED);
-			goto error;
-		}
-	}
-
-	instkey = ERR_PTR(-EACCES);
-	goto error;
-
-found:
-	atomic_inc(&instkey->usage);
-error:
-	return instkey;
-
-} /* end keyring_search_instkey() */
-
-/*****************************************************************************/
-/*
  * find a keyring with the specified name
  * - all named keyrings are searched
  * - only find keyrings with search permission for the process
diff -uNrp linux-2.6.15-rc1-keys-multilink/security/keys/permission.c linux-2.6.15-rc1-keys-reqkey/security/keys/permission.c
--- linux-2.6.15-rc1-keys-multilink/security/keys/permission.c	2005-11-16 11:42:28.000000000 +0000
+++ linux-2.6.15-rc1-keys-reqkey/security/keys/permission.c	2005-11-16 14:56:29.000000000 +0000
@@ -73,3 +73,35 @@ use_these_perms:
 } /* end key_task_permission() */
 
 EXPORT_SYMBOL(key_task_permission);
+
+/*****************************************************************************/
+/*
+ * validate a key
+ */
+int key_validate(struct key *key)
+{
+	struct timespec now;
+	int ret = 0;
+
+	if (key) {
+		/* check it's still accessible */
+		ret = -EKEYREVOKED;
+		if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
+		    test_bit(KEY_FLAG_DEAD, &key->flags))
+			goto error;
+
+		/* check it hasn't expired */
+		ret = 0;
+		if (key->expiry) {
+			now = current_kernel_time();
+			if (now.tv_sec >= key->expiry)
+				ret = -EKEYEXPIRED;
+		}
+	}
+
+ error:
+	return ret;
+
+} /* end key_validate() */
+
+EXPORT_SYMBOL(key_validate);
diff -uNrp linux-2.6.15-rc1-keys-multilink/security/keys/process_keys.c linux-2.6.15-rc1-keys-reqkey/security/keys/process_keys.c
--- linux-2.6.15-rc1-keys-multilink/security/keys/process_keys.c	2005-11-16 11:42:28.000000000 +0000
+++ linux-2.6.15-rc1-keys-reqkey/security/keys/process_keys.c	2005-11-16 18:35:00.000000000 +0000
@@ -270,9 +270,14 @@ int copy_thread_group_keys(struct task_s
 int copy_keys(unsigned long clone_flags, struct task_struct *tsk)
 {
 	key_check(tsk->thread_keyring);
+	key_check(tsk->request_key_auth);
 
 	/* no thread keyring yet */
 	tsk->thread_keyring = NULL;
+
+	/* copy the request_key() authorisation for this thread */
+	key_get(tsk->request_key_auth);
+
 	return 0;
 
 } /* end copy_keys() */
@@ -290,11 +295,12 @@ void exit_thread_group_keys(struct signa
 
 /*****************************************************************************/
 /*
- * dispose of keys upon thread exit
+ * dispose of per-thread keys upon thread exit
  */
 void exit_keys(struct task_struct *tsk)
 {
 	key_put(tsk->thread_keyring);
+	key_put(tsk->request_key_auth);
 
 } /* end exit_keys() */
 
@@ -382,7 +388,7 @@ key_ref_t search_process_keyrings(struct
 				  struct task_struct *context)
 {
 	struct request_key_auth *rka;
-	key_ref_t key_ref, ret, err, instkey_ref;
+	key_ref_t key_ref, ret, err;
 
 	/* we want to return -EAGAIN or -ENOKEY if any of the keyrings were
 	 * searchable, but we failed to find a key or we found a negative key;
@@ -461,30 +467,12 @@ key_ref_t search_process_keyrings(struct
 			err = key_ref;
 			break;
 		}
-
-		/* if this process has a session keyring and that has an
-		 * instantiation authorisation key in the bottom level, then we
-		 * also search the keyrings of the process mentioned there */
-		if (context != current)
-			goto no_key;
-
-		rcu_read_lock();
-		instkey_ref = __keyring_search_one(
-			make_key_ref(rcu_dereference(
-					     context->signal->session_keyring),
-				     1),
-			&key_type_request_key_auth, NULL, 0);
-		rcu_read_unlock();
-
-		if (IS_ERR(instkey_ref))
-			goto no_key;
-
-		rka = key_ref_to_ptr(instkey_ref)->payload.data;
-
-		key_ref = search_process_keyrings(type, description, match,
-						  rka->context);
-		key_ref_put(instkey_ref);
-
+	}
+	/* or search the user-session keyring */
+	else {
+		key_ref = keyring_search_aux(
+			make_key_ref(context->user->session_keyring, 1),
+			context, type, description, match);
 		if (!IS_ERR(key_ref))
 			goto found;
 
@@ -500,11 +488,21 @@ key_ref_t search_process_keyrings(struct
 			break;
 		}
 	}
-	/* or search the user-session keyring */
-	else {
-		key_ref = keyring_search_aux(
-			make_key_ref(context->user->session_keyring, 1),
-			context, type, description, match);
+
+	/* if this process has an instantiation authorisation key, then we also
+	 * search the keyrings of the process mentioned there
+	 * - we don't permit access to request_key auth keys via this method
+	 */
+	if (context->request_key_auth &&
+	    context == current &&
+	    type != &key_type_request_key_auth &&
+	    key_validate(context->request_key_auth) == 0
+	    ) {
+		rka = context->request_key_auth->payload.data;
+
+		key_ref = search_process_keyrings(type, description, match,
+						  rka->context);
+
 		if (!IS_ERR(key_ref))
 			goto found;
 
@@ -521,8 +519,6 @@ key_ref_t search_process_keyrings(struct
 		}
 	}
 
-
-no_key:
 	/* no key - decide on the error we're going to go for */
 	key_ref = ret ? ret : err;
 
@@ -628,6 +624,15 @@ key_ref_t lookup_user_key(struct task_st
 		key = ERR_PTR(-EINVAL);
 		goto error;
 
+	case KEY_SPEC_REQKEY_AUTH_KEY:
+		key = context->request_key_auth;
+		if (!key)
+			goto error;
+
+		atomic_inc(&key->usage);
+		key_ref = make_key_ref(key, 1);
+		break;
+
 	default:
 		key_ref = ERR_PTR(-EINVAL);
 		if (id < 1)
diff -uNrp linux-2.6.15-rc1-keys-multilink/security/keys/request_key_auth.c linux-2.6.15-rc1-keys-reqkey/security/keys/request_key_auth.c
--- linux-2.6.15-rc1-keys-multilink/security/keys/request_key_auth.c	2005-11-01 13:19:26.000000000 +0000
+++ linux-2.6.15-rc1-keys-reqkey/security/keys/request_key_auth.c	2005-11-16 17:55:27.000000000 +0000
@@ -15,11 +15,13 @@
 #include <linux/sched.h>
 #include <linux/err.h>
 #include <linux/seq_file.h>
+#include <asm/uaccess.h>
 #include "internal.h"
 
 static int request_key_auth_instantiate(struct key *, const void *, size_t);
 static void request_key_auth_describe(const struct key *, struct seq_file *);
 static void request_key_auth_destroy(struct key *);
+static long request_key_auth_read(const struct key *, char __user *, size_t);
 
 /*
  * the request-key authorisation key type definition
@@ -30,51 +32,25 @@ struct key_type key_type_request_key_aut
 	.instantiate	= request_key_auth_instantiate,
 	.describe	= request_key_auth_describe,
 	.destroy	= request_key_auth_destroy,
+	.read		= request_key_auth_read,
 };
 
 /*****************************************************************************/
 /*
- * instantiate a request-key authorisation record
+ * instantiate a request-key authorisation key
  */
 static int request_key_auth_instantiate(struct key *key,
 					const void *data,
 					size_t datalen)
 {
-	struct request_key_auth *rka, *irka;
-	struct key *instkey;
-	int ret;
-
-	ret = -ENOMEM;
-	rka = kmalloc(sizeof(*rka), GFP_KERNEL);
-	if (rka) {
-		/* see if the calling process is already servicing the key
-		 * request of another process */
-		instkey = key_get_instantiation_authkey(0);
-		if (!IS_ERR(instkey)) {
-			/* it is - use that instantiation context here too */
-			irka = instkey->payload.data;
-			rka->context = irka->context;
-			rka->pid = irka->pid;
-			key_put(instkey);
-		}
-		else {
-			/* it isn't - use this process as the context */
-			rka->context = current;
-			rka->pid = current->pid;
-		}
-
-		rka->target_key = key_get((struct key *) data);
-		key->payload.data = rka;
-		ret = 0;
-	}
-
-	return ret;
+	key->payload.data = (struct request_key_auth *) data;
+	return 0;
 
 } /* end request_key_auth_instantiate() */
 
 /*****************************************************************************/
 /*
- *
+ * reading a request-key authorisation key retrieves the callout information
  */
 static void request_key_auth_describe(const struct key *key,
 				      struct seq_file *m)
@@ -83,12 +59,40 @@ static void request_key_auth_describe(co
 
 	seq_puts(m, "key:");
 	seq_puts(m, key->description);
-	seq_printf(m, " pid:%d", rka->pid);
+	seq_printf(m, " pid:%d ci:%zu", rka->pid, strlen(rka->callout_info));
 
 } /* end request_key_auth_describe() */
 
 /*****************************************************************************/
 /*
+ * read the callout_info data
+ * - the key's semaphore is read-locked
+ */
+static long request_key_auth_read(const struct key *key,
+				  char __user *buffer, size_t buflen)
+{
+	struct request_key_auth *rka = key->payload.data;
+	size_t datalen;
+	long ret;
+
+	datalen = strlen(rka->callout_info);
+	ret = datalen;
+
+	/* we can return the data as is */
+	if (buffer && buflen > 0) {
+		if (buflen > datalen)
+			buflen = datalen;
+
+		if (copy_to_user(buffer, rka->callout_info, buflen) != 0)
+			ret = -EFAULT;
+	}
+
+	return ret;
+
+} /* end request_key_auth_read() */
+
+/*****************************************************************************/
+/*
  * destroy an instantiation authorisation token key
  */
 static void request_key_auth_destroy(struct key *key)
@@ -104,56 +108,89 @@ static void request_key_auth_destroy(str
 
 /*****************************************************************************/
 /*
- * create a session keyring to be for the invokation of /sbin/request-key and
- * stick an authorisation token in it
+ * create an authorisation token for /sbin/request-key or whoever to gain
+ * access to the caller's security data
  */
-struct key *request_key_auth_new(struct key *target, struct key **_rkakey)
+struct key *request_key_auth_new(struct key *target, const char *callout_info)
 {
-	struct key *keyring, *rkakey = NULL;
+	struct request_key_auth *rka, *irka;
+	struct key *authkey = NULL;
 	char desc[20];
 	int ret;
 
 	kenter("%d,", target->serial);
 
-	/* allocate a new session keyring */
-	sprintf(desc, "_req.%u", target->serial);
+	/* allocate a auth record */
+	rka = kmalloc(sizeof(*rka), GFP_KERNEL);
+	if (!rka) {
+		kleave(" = -ENOMEM");
+		return ERR_PTR(-ENOMEM);
+	}
 
-	keyring = keyring_alloc(desc, current->fsuid, current->fsgid, 1, NULL);
-	if (IS_ERR(keyring)) {
-		kleave("= %ld", PTR_ERR(keyring));
-		return keyring;
+	/* see if the calling process is already servicing the key request of
+	 * another process */
+	if (current->request_key_auth) {
+		/* it is - use that instantiation context here too */
+		irka = current->request_key_auth->payload.data;
+		rka->context = irka->context;
+		rka->pid = irka->pid;
 	}
+	else {
+		/* it isn't - use this process as the context */
+		rka->context = current;
+		rka->pid = current->pid;
+	}
+
+	rka->target_key = key_get(target);
+	rka->callout_info = callout_info;
 
 	/* allocate the auth key */
 	sprintf(desc, "%x", target->serial);
 
-	rkakey = key_alloc(&key_type_request_key_auth, desc,
-			   current->fsuid, current->fsgid,
-			   KEY_POS_VIEW | KEY_USR_VIEW, 1);
-	if (IS_ERR(rkakey)) {
-		key_put(keyring);
-		kleave("= %ld", PTR_ERR(rkakey));
-		return rkakey;
+	authkey = key_alloc(&key_type_request_key_auth, desc,
+			    current->fsuid, current->fsgid,
+			    KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH |
+			    KEY_USR_VIEW, 1);
+	if (IS_ERR(authkey)) {
+		ret = PTR_ERR(authkey);
+		goto error_alloc;
 	}
 
 	/* construct and attach to the keyring */
-	ret = key_instantiate_and_link(rkakey, target, 0, keyring, NULL);
-	if (ret < 0) {
-		key_revoke(rkakey);
-		key_put(rkakey);
-		key_put(keyring);
-		kleave("= %d", ret);
-		return ERR_PTR(ret);
-	}
-
-	*_rkakey = rkakey;
-	kleave(" = {%d} ({%d})", keyring->serial, rkakey->serial);
-	return keyring;
+	ret = key_instantiate_and_link(authkey, rka, 0, NULL, NULL);
+	if (ret < 0)
+		goto error_inst;
+
+	kleave(" = {%d})", authkey->serial);
+	return authkey;
+
+error_inst:
+	key_revoke(authkey);
+	key_put(authkey);
+error_alloc:
+	key_put(rka->target_key);
+	kfree(rka);
+	kleave("= %d", ret);
+	return ERR_PTR(ret);
 
 } /* end request_key_auth_new() */
 
 /*****************************************************************************/
 /*
+ * see if an authorisation key is associated with a particular key
+ */
+static int key_get_instantiation_authkey_match(const struct key *key,
+					       const void *_id)
+{
+	struct request_key_auth *rka = key->payload.data;
+	key_serial_t id = (key_serial_t)(unsigned long) _id;
+
+	return rka->target_key->serial == id;
+
+} /* end key_get_instantiation_authkey_match() */
+
+/*****************************************************************************/
+/*
  * get the authorisation key for instantiation of a specific key if attached to
  * the current process's keyrings
  * - this key is inserted into a keyring and that is set as /sbin/request-key's
@@ -162,22 +199,27 @@ struct key *request_key_auth_new(struct 
  */
 struct key *key_get_instantiation_authkey(key_serial_t target_id)
 {
-	struct task_struct *tsk = current;
-	struct key *instkey;
+	struct key *authkey;
+	key_ref_t authkey_ref;
 
-	/* we must have our own personal session keyring */
-	if (!tsk->signal->session_keyring)
-		return ERR_PTR(-EACCES);
-
-	/* and it must contain a suitable request authorisation key
-	 * - lock RCU against session keyring changing
-	 */
-	rcu_read_lock();
+	authkey_ref = search_process_keyrings(
+		&key_type_request_key_auth,
+		(void *) (unsigned long) target_id,
+		key_get_instantiation_authkey_match,
+		current);
+
+	if (IS_ERR(authkey_ref)) {
+		authkey = ERR_PTR(PTR_ERR(authkey_ref));
+		goto error;
+	}
 
-	instkey = keyring_search_instkey(
-		rcu_dereference(tsk->signal->session_keyring), target_id);
+	authkey = key_ref_to_ptr(authkey_ref);
+	if (test_bit(KEY_FLAG_REVOKED, &authkey->flags)) {
+		key_put(authkey);
+		authkey = ERR_PTR(-EKEYREVOKED);
+	}
 
-	rcu_read_unlock();
-	return instkey;
+error:
+	return authkey;
 
 } /* end key_get_instantiation_authkey() */
diff -uNrp linux-2.6.15-rc1-keys-multilink/security/keys/request_key.c linux-2.6.15-rc1-keys-reqkey/security/keys/request_key.c
--- linux-2.6.15-rc1-keys-multilink/security/keys/request_key.c	2005-11-01 13:19:26.000000000 +0000
+++ linux-2.6.15-rc1-keys-reqkey/security/keys/request_key.c	2005-11-16 18:08:47.000000000 +0000
@@ -29,28 +29,36 @@ DECLARE_WAIT_QUEUE_HEAD(request_key_cons
 /*****************************************************************************/
 /*
  * request userspace finish the construction of a key
- * - execute "/sbin/request-key <op> <key> <uid> <gid> <keyring> <keyring> <keyring> <info>"
+ * - execute "/sbin/request-key <op> <key> <uid> <gid> <keyring> <keyring> <keyring>"
  */
-static int call_request_key(struct key *key,
-			    const char *op,
-			    const char *callout_info)
+static int call_sbin_request_key(struct key *key,
+				 struct key *authkey,
+				 const char *op)
 {
 	struct task_struct *tsk = current;
 	key_serial_t prkey, sskey;
-	struct key *session_keyring, *rkakey;
-	char *argv[10], *envp[3], uid_str[12], gid_str[12];
+	struct key *keyring;
+	char *argv[9], *envp[3], uid_str[12], gid_str[12];
 	char key_str[12], keyring_str[3][12];
+	char desc[20];
 	int ret, i;
 
-	kenter("{%d},%s,%s", key->serial, op, callout_info);
+	kenter("{%d},{%d},%s", key->serial, authkey->serial, op);
 
-	/* generate a new session keyring with an auth key in it */
-	session_keyring = request_key_auth_new(key, &rkakey);
-	if (IS_ERR(session_keyring)) {
-		ret = PTR_ERR(session_keyring);
-		goto error;
+	/* allocate a new session keyring */
+	sprintf(desc, "_req.%u", key->serial);
+
+	keyring = keyring_alloc(desc, current->fsuid, current->fsgid, 1, NULL);
+	if (IS_ERR(keyring)) {
+		ret = PTR_ERR(keyring);
+		goto error_alloc;
 	}
 
+	/* attach the auth key to the session keyring */
+	ret = __key_link(keyring, authkey);
+	if (ret < 0)
+		goto error_link;
+
 	/* record the UID and GID */
 	sprintf(uid_str, "%d", current->fsuid);
 	sprintf(gid_str, "%d", current->fsgid);
@@ -95,22 +103,19 @@ static int call_request_key(struct key *
 	argv[i++] = keyring_str[0];
 	argv[i++] = keyring_str[1];
 	argv[i++] = keyring_str[2];
-	argv[i++] = (char *) callout_info;
 	argv[i] = NULL;
 
 	/* do it */
-	ret = call_usermodehelper_keys(argv[0], argv, envp, session_keyring, 1);
+	ret = call_usermodehelper_keys(argv[0], argv, envp, keyring, 1);
 
-	/* dispose of the special keys */
-	key_revoke(rkakey);
-	key_put(rkakey);
-	key_put(session_keyring);
+error_link:
+	key_put(keyring);
 
- error:
+error_alloc:
 	kleave(" = %d", ret);
 	return ret;
 
-} /* end call_request_key() */
+} /* end call_sbin_request_key() */
 
 /*****************************************************************************/
 /*
@@ -122,9 +127,10 @@ static struct key *__request_key_constru
 					      const char *description,
 					      const char *callout_info)
 {
+	request_key_actor_t actor;
 	struct key_construction cons;
 	struct timespec now;
-	struct key *key;
+	struct key *key, *authkey;
 	int ret, negated;
 
 	kenter("%s,%s,%s", type->name, description, callout_info);
@@ -143,8 +149,19 @@ static struct key *__request_key_constru
 	/* we drop the construction sem here on behalf of the caller */
 	up_write(&key_construction_sem);
 
+	/* allocate an authorisation key */
+	authkey = request_key_auth_new(key, callout_info);
+	if (IS_ERR(authkey)) {
+		ret = PTR_ERR(authkey);
+		authkey = NULL;
+		goto alloc_authkey_failed;
+	}
+
 	/* make the call */
-	ret = call_request_key(key, "create", callout_info);
+	actor = call_sbin_request_key;
+	if (type->request_key)
+		actor = type->request_key;
+	ret = actor(key, authkey, "create");
 	if (ret < 0)
 		goto request_failed;
 
@@ -153,22 +170,29 @@ static struct key *__request_key_constru
 	if (!test_bit(KEY_FLAG_INSTANTIATED, &key->flags))
 		goto request_failed;
 
+	key_revoke(authkey);
+	key_put(authkey);
+
 	down_write(&key_construction_sem);
 	list_del(&cons.link);
 	up_write(&key_construction_sem);
 
 	/* also give an error if the key was negatively instantiated */
- check_not_negative:
+check_not_negative:
 	if (test_bit(KEY_FLAG_NEGATIVE, &key->flags)) {
 		key_put(key);
 		key = ERR_PTR(-ENOKEY);
 	}
 
- out:
+out:
 	kleave(" = %p", key);
 	return key;
 
- request_failed:
+request_failed:
+	key_revoke(authkey);
+	key_put(authkey);
+
+alloc_authkey_failed:
 	/* it wasn't instantiated
 	 * - remove from construction queue
 	 * - mark the key as dead
@@ -217,7 +241,7 @@ static struct key *__request_key_constru
 	key = ERR_PTR(ret);
 	goto out;
 
- alloc_failed:
+alloc_failed:
 	up_write(&key_construction_sem);
 	goto out;
 
@@ -464,35 +488,3 @@ struct key *request_key(struct key_type 
 } /* end request_key() */
 
 EXPORT_SYMBOL(request_key);
-
-/*****************************************************************************/
-/*
- * validate a key
- */
-int key_validate(struct key *key)
-{
-	struct timespec now;
-	int ret = 0;
-
-	if (key) {
-		/* check it's still accessible */
-		ret = -EKEYREVOKED;
-		if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
-		    test_bit(KEY_FLAG_DEAD, &key->flags))
-			goto error;
-
-		/* check it hasn't expired */
-		ret = 0;
-		if (key->expiry) {
-			now = current_kernel_time();
-			if (now.tv_sec >= key->expiry)
-				ret = -EKEYEXPIRED;
-		}
-	}
-
- error:
-	return ret;
-
-} /* end key_validate() */
-
-EXPORT_SYMBOL(key_validate);
