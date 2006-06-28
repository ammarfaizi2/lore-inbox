Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030504AbWF1KKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030504AbWF1KKW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 06:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030500AbWF1KKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 06:10:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24520 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423255AbWF1KKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 06:10:21 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <15367.1151418456@warthog.cambridge.redhat.com> 
References: <15367.1151418456@warthog.cambridge.redhat.com>  <15078.1151417633@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, kwc@citi.umich.edu
Cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Allow in-kernel key requestor to pass auxiliary data to upcaller [try #2]
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 28 Jun 2006 11:09:59 +0100
Message-ID: <10777.1151489399@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The proposed NFS key type uses its own method of passing key requests to
userspace (upcalling) rather than invoking /sbin/request-key.  This is because
the responsible userspace daemon should already be running and will be
contacted through rpc_pipefs.

This patch permits the NFS filesystem to pass auxiliary data to the upcall
operation (struct key_type::request_key) so that the upcaller can use a
pre-existing communications channel more easily.

In [try #2] I've renamed the new function to request_key_with_auxdata().

Signed-Off-By: David Howells <dhowells@redhat.com>
Acked-By: Kevin Coffman <kwc@citi.umich.edu>
---

 Documentation/keys-request-key.txt |   54 ++++++++++++++++++++++++------------
 Documentation/keys.txt             |   29 +++++++++++++++++++
 include/linux/key.h                |    8 +++++
 security/keys/internal.h           |    1 +
 security/keys/keyctl.c             |    2 +
 security/keys/request_key.c        |   44 +++++++++++++++++++++++------
 6 files changed, 108 insertions(+), 30 deletions(-)

diff --git a/Documentation/keys-request-key.txt b/Documentation/keys-request-key.txt
index 22488d7..c1f64fd 100644
--- a/Documentation/keys-request-key.txt
+++ b/Documentation/keys-request-key.txt
@@ -3,16 +3,23 @@
 			      ===================
 
 The key request service is part of the key retention service (refer to
-Documentation/keys.txt). This document explains more fully how that the
-requesting algorithm works.
+Documentation/keys.txt).  This document explains more fully how the requesting
+algorithm works.
 
 The process starts by either the kernel requesting a service by calling
-request_key():
+request_key*():
 
 	struct key *request_key(const struct key_type *type,
 				const char *description,
 				const char *callout_string);
 
+or:
+
+	struct key *request_key_with_auxdata(const struct key_type *type,
+					     const char *description,
+					     const char *callout_string,
+					     void *aux);
+
 Or by userspace invoking the request_key system call:
 
 	key_serial_t request_key(const char *type,
@@ -20,16 +27,26 @@ Or by userspace invoking the request_key
 				 const char *callout_info,
 				 key_serial_t dest_keyring);
 
-The main difference between the two access points is that the in-kernel
-interface does not need to link the key to a keyring to prevent it from being
-immediately destroyed. The kernel interface returns a pointer directly to the
-key, and it's up to the caller to destroy the key.
+The main difference between the access points is that the in-kernel interface
+does not need to link the key to a keyring to prevent it from being immediately
+destroyed.  The kernel interface returns a pointer directly to the key, and
+it's up to the caller to destroy the key.
+
+The request_key_with_auxdata() call is like the in-kernel request_key() call,
+except that it permits auxiliary data to be passed to the upcaller (the default
+is NULL).  This is only useful for those key types that define their own upcall
+mechanism rather than using /sbin/request-key.
 
 The userspace interface links the key to a keyring associated with the process
 to prevent the key from going away, and returns the serial number of the key to
 the caller.
 
 
+The following example assumes that the key types involved don't define their
+own upcall mechanisms.  If they do, then those should be substituted for the
+forking and execution of /sbin/request-key.
+
+
 ===========
 THE PROCESS
 ===========
@@ -40,8 +57,8 @@ A request proceeds in the following mann
      interface].
 
  (2) request_key() searches the process's subscribed keyrings to see if there's
-     a suitable key there. If there is, it returns the key. If there isn't, and
-     callout_info is not set, an error is returned. Otherwise the process
+     a suitable key there.  If there is, it returns the key.  If there isn't,
+     and callout_info is not set, an error is returned.  Otherwise the process
      proceeds to the next step.
 
  (3) request_key() sees that A doesn't have the desired key yet, so it creates
@@ -62,7 +79,7 @@ A request proceeds in the following mann
      instantiation.
 
  (7) The program may want to access another key from A's context (say a
-     Kerberos TGT key). It just requests the appropriate key, and the keyring
+     Kerberos TGT key).  It just requests the appropriate key, and the keyring
      search notes that the session keyring has auth key V in its bottom level.
 
      This will permit it to then search the keyrings of process A with the
@@ -79,10 +96,11 @@ A request proceeds in the following mann
 (10) The program then exits 0 and request_key() deletes key V and returns key
      U to the caller.
 
-This also extends further. If key W (step 7 above) didn't exist, key W would be
-created uninstantiated, another auth key (X) would be created (as per step 3)
-and another copy of /sbin/request-key spawned (as per step 4); but the context
-specified by auth key X will still be process A, as it was in auth key V.
+This also extends further.  If key W (step 7 above) didn't exist, key W would
+be created uninstantiated, another auth key (X) would be created (as per step
+3) and another copy of /sbin/request-key spawned (as per step 4); but the
+context specified by auth key X will still be process A, as it was in auth key
+V.
 
 This is because process A's keyrings can't simply be attached to
 /sbin/request-key at the appropriate places because (a) execve will discard two
@@ -118,17 +136,17 @@ A search of any particular keyring proce
 
  (2) It considers all the non-keyring keys within that keyring and, if any key
      matches the criteria specified, calls key_permission(SEARCH) on it to see
-     if the key is allowed to be found. If it is, that key is returned; if
+     if the key is allowed to be found.  If it is, that key is returned; if
      not, the search continues, and the error code is retained if of higher
      priority than the one currently set.
 
  (3) It then considers all the keyring-type keys in the keyring it's currently
-     searching. It calls key_permission(SEARCH) on each keyring, and if this
+     searching.  It calls key_permission(SEARCH) on each keyring, and if this
      grants permission, it recurses, executing steps (2) and (3) on that
      keyring.
 
 The process stops immediately a valid key is found with permission granted to
-use it. Any error from a previous match attempt is discarded and the key is
+use it.  Any error from a previous match attempt is discarded and the key is
 returned.
 
 When search_process_keyrings() is invoked, it performs the following searches
@@ -153,7 +171,7 @@ The moment one succeeds, all pending err
 returned.
 
 Only if all these fail does the whole thing fail with the highest priority
-error. Note that several errors may have come from LSM.
+error.  Note that several errors may have come from LSM.
 
 The error priority is:
 
diff --git a/Documentation/keys.txt b/Documentation/keys.txt
index 61c0fad..e373f02 100644
--- a/Documentation/keys.txt
+++ b/Documentation/keys.txt
@@ -780,6 +780,17 @@ (*) To search for a key, call:
     See also Documentation/keys-request-key.txt.
 
 
+(*) To search for a key, passing auxiliary data to the upcaller, call:
+
+	struct key *request_key_with_auxdata(const struct key_type *type,
+					     const char *description,
+					     const char *callout_string,
+					     void *aux);
+
+    This is identical to request_key(), except that the auxiliary data is
+    passed to the key_type->request_key() op if it exists.
+
+
 (*) When it is no longer required, the key should be released using:
 
 	void key_put(struct key *key);
@@ -1031,6 +1042,24 @@ The structure has a number of fields, so
      as might happen when the userspace buffer is accessed.
 
 
+ (*) int (*request_key)(struct key *key, struct key *authkey, const char *op,
+			void *aux);
+
+     This method is optional.  If provided, request_key() and
+     request_key_with_auxdata() will invoke this function rather than
+     upcalling to /sbin/request-key to operate upon a key of this type.
+
+     The aux parameter is as passed to request_key_with_auxdata() or is NULL
+     otherwise.  Also passed are the key to be operated upon, the
+     authorisation key for this operation and the operation type (currently
+     only "create").
+
+     This function should return only when the upcall is complete.  Upon return
+     the authorisation key will be revoked, and the target key will be
+     negatively instantiated if it is still uninstantiated.  The error will be
+     returned to the caller of request_key*().
+
+
 ============================
 REQUEST-KEY CALLBACK SERVICE
 ============================
diff --git a/include/linux/key.h b/include/linux/key.h
index e693e72..169f05e 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -177,7 +177,8 @@ #define KEY_FLAG_NEGATIVE	5	/* set if ke
 /*
  * kernel managed key type definition
  */
-typedef int (*request_key_actor_t)(struct key *key, struct key *authkey, const char *op);
+typedef int (*request_key_actor_t)(struct key *key, struct key *authkey,
+				   const char *op, void *aux);
 
 struct key_type {
 	/* name of the type */
@@ -285,6 +286,11 @@ extern struct key *request_key(struct ke
 			       const char *description,
 			       const char *callout_info);
 
+extern struct key *request_key_with_auxdata(struct key_type *type,
+					    const char *description,
+					    const char *callout_info,
+					    void *aux);
+
 extern int key_validate(struct key *key);
 
 extern key_ref_t key_create_or_update(key_ref_t keyring,
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 3c2877f..1bb416f 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -99,6 +99,7 @@ extern int install_process_keyring(struc
 extern struct key *request_key_and_link(struct key_type *type,
 					const char *description,
 					const char *callout_info,
+					void *aux,
 					struct key *dest_keyring,
 					unsigned long flags);
 
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 329411c..d9ca15c 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -183,7 +183,7 @@ asmlinkage long sys_request_key(const ch
 	}
 
 	/* do the search */
-	key = request_key_and_link(ktype, description, callout_info,
+	key = request_key_and_link(ktype, description, callout_info, NULL,
 				   key_ref_to_ptr(dest_ref),
 				   KEY_ALLOC_IN_QUOTA);
 	if (IS_ERR(key)) {
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 58d1efd..f573ac1 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -1,6 +1,6 @@
 /* request_key.c: request a key from userspace
  *
- * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2004-6 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -33,7 +33,8 @@ DECLARE_WAIT_QUEUE_HEAD(request_key_cons
  */
 static int call_sbin_request_key(struct key *key,
 				 struct key *authkey,
-				 const char *op)
+				 const char *op,
+				 void *aux)
 {
 	struct task_struct *tsk = current;
 	key_serial_t prkey, sskey;
@@ -127,6 +128,7 @@ error_alloc:
 static struct key *__request_key_construction(struct key_type *type,
 					      const char *description,
 					      const char *callout_info,
+					      void *aux,
 					      unsigned long flags)
 {
 	request_key_actor_t actor;
@@ -164,7 +166,7 @@ static struct key *__request_key_constru
 	actor = call_sbin_request_key;
 	if (type->request_key)
 		actor = type->request_key;
-	ret = actor(key, authkey, "create");
+	ret = actor(key, authkey, "create", aux);
 	if (ret < 0)
 		goto request_failed;
 
@@ -258,8 +260,9 @@ alloc_failed:
  */
 static struct key *request_key_construction(struct key_type *type,
 					    const char *description,
-					    struct key_user *user,
 					    const char *callout_info,
+					    void *aux,
+					    struct key_user *user,
 					    unsigned long flags)
 {
 	struct key_construction *pcons;
@@ -284,7 +287,7 @@ static struct key *request_key_construct
 	}
 
 	/* see about getting userspace to construct the key */
-	key = __request_key_construction(type, description, callout_info,
+	key = __request_key_construction(type, description, callout_info, aux,
 					 flags);
  error:
 	kleave(" = %p", key);
@@ -392,6 +395,7 @@ static void request_key_link(struct key 
 struct key *request_key_and_link(struct key_type *type,
 				 const char *description,
 				 const char *callout_info,
+				 void *aux,
 				 struct key *dest_keyring,
 				 unsigned long flags)
 {
@@ -399,8 +403,9 @@ struct key *request_key_and_link(struct 
 	struct key *key;
 	key_ref_t key_ref;
 
-	kenter("%s,%s,%s,%p,%lx",
-	       type->name, description, callout_info, dest_keyring, flags);
+	kenter("%s,%s,%s,%p,%p,%lx",
+	       type->name, description, callout_info, aux,
+	       dest_keyring, flags);
 
 	/* search all the process keyrings for a key */
 	key_ref = search_process_keyrings(type, description, type->match,
@@ -433,8 +438,8 @@ struct key *request_key_and_link(struct 
 			/* ask userspace (returns NULL if it waited on a key
 			 * being constructed) */
 			key = request_key_construction(type, description,
-						       user, callout_info,
-						       flags);
+						       callout_info, aux,
+						       user, flags);
 			if (key)
 				break;
 
@@ -491,8 +496,27 @@ struct key *request_key(struct key_type 
 			const char *callout_info)
 {
 	return request_key_and_link(type, description, callout_info, NULL,
-				    KEY_ALLOC_IN_QUOTA);
+				    NULL, KEY_ALLOC_IN_QUOTA);
 
 } /* end request_key() */
 
 EXPORT_SYMBOL(request_key);
+
+/*****************************************************************************/
+/*
+ * request a key with auxiliary data for the upcaller
+ * - search the process's keyrings
+ * - check the list of keys being created or updated
+ * - call out to userspace for a key if supplementary info was provided
+ */
+struct key *request_key_with_auxdata(struct key_type *type,
+				     const char *description,
+				     const char *callout_info,
+				     void *aux)
+{
+	return request_key_and_link(type, description, callout_info, aux,
+				    NULL, KEY_ALLOC_IN_QUOTA);
+
+} /* end request_key_with_auxdata() */
+
+EXPORT_SYMBOL(request_key_with_auxdata);
