Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932599AbVJEK7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbVJEK7d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 06:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbVJEK7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 06:59:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9603 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932599AbVJEK7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 06:59:32 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <OF7208B0E9.0AB77A04-ON87257090.007A1D4E-05257090.007A2207@us.ibm.com> 
References: <OF7208B0E9.0AB77A04-ON87257090.007A1D4E-05257090.007A2207@us.ibm.com> 
To: torvalds@osdl.org, akpm@osdl.org, Michael C Thompson <mcthomps@us.ibm.com>
Cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Export user-defined keyring operations
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 05 Oct 2005 11:58:59 +0100
Message-ID: <28129.1128509939@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch exports user-defined key operations so that those who wish
to define their own key type based on the user-defined key operations may do
so (as has been requested).

The header file created has been placed into include/keys/user-type.h, thus
creating a directory where other key types may also be placed. Any objections
to doing this?

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-userexp-2614rc3.diff
 include/keys/user-type.h     |   47 +++++++++++++++++++++++++++++++++++++++++
 security/keys/user_defined.c |   49 +++++++++++++++++++++----------------------
 2 files changed, 71 insertions(+), 25 deletions(-)

diff -uNrp linux-2.6.14-rc3/include/keys/user-type.h linux-2.6.14-rc3-keys/include/keys/user-type.h
--- linux-2.6.14-rc3/include/keys/user-type.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-rc3-keys/include/keys/user-type.h	2005-10-05 11:44:54.000000000 +0100
@@ -0,0 +1,47 @@
+/* user-type.h: User-defined key type
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
+#ifndef _KEYS_USER_TYPE_H
+#define _KEYS_USER_TYPE_H
+
+#include <linux/key.h>
+#include <linux/rcupdate.h>
+
+/*****************************************************************************/
+/*
+ * the payload for a key of type "user"
+ * - once filled in and attached to a key:
+ *   - the payload struct is invariant may not be changed, only replaced
+ *   - the payload must be read with RCU procedures or with the key semaphore
+ *     held
+ *   - the payload may only be replaced with the key semaphore write-locked
+ * - the key's data length is the size of the actual data, not including the
+ *   payload wrapper
+ */
+struct user_key_payload {
+	struct rcu_head	rcu;		/* RCU destructor */
+	unsigned short	datalen;	/* length of this data */
+	char		data[0];	/* actual data */
+};
+
+extern struct key_type key_type_user;
+
+extern int user_instantiate(struct key *key, const void *data, size_t datalen);
+extern int user_duplicate(struct key *key, const struct key *source);
+extern int user_update(struct key *key, const void *data, size_t datalen);
+extern int user_match(const struct key *key, const void *criterion);
+extern void user_destroy(struct key *key);
+extern void user_describe(const struct key *user, struct seq_file *m);
+extern long user_read(const struct key *key,
+		      char __user *buffer, size_t buflen);
+
+
+#endif /* _KEYS_USER_TYPE_H */
diff -uNrp linux-2.6.14-rc3/security/keys/user_defined.c linux-2.6.14-rc3-keys/security/keys/user_defined.c
--- linux-2.6.14-rc3/security/keys/user_defined.c	2005-08-30 13:56:44.000000000 +0100
+++ linux-2.6.14-rc3-keys/security/keys/user_defined.c	2005-10-05 11:37:04.000000000 +0100
@@ -15,18 +15,10 @@
 #include <linux/slab.h>
 #include <linux/seq_file.h>
 #include <linux/err.h>
+#include <keys/user-type.h>
 #include <asm/uaccess.h>
 #include "internal.h"
 
-static int user_instantiate(struct key *key, const void *data, size_t datalen);
-static int user_duplicate(struct key *key, const struct key *source);
-static int user_update(struct key *key, const void *data, size_t datalen);
-static int user_match(const struct key *key, const void *criterion);
-static void user_destroy(struct key *key);
-static void user_describe(const struct key *user, struct seq_file *m);
-static long user_read(const struct key *key,
-		      char __user *buffer, size_t buflen);
-
 /*
  * user defined keys take an arbitrary string as the description and an
  * arbitrary blob of data as the payload
@@ -42,19 +34,13 @@ struct key_type key_type_user = {
 	.read		= user_read,
 };
 
-struct user_key_payload {
-	struct rcu_head	rcu;		/* RCU destructor */
-	unsigned short	datalen;	/* length of this data */
-	char		data[0];	/* actual data */
-};
-
 EXPORT_SYMBOL_GPL(key_type_user);
 
 /*****************************************************************************/
 /*
  * instantiate a user defined key
  */
-static int user_instantiate(struct key *key, const void *data, size_t datalen)
+int user_instantiate(struct key *key, const void *data, size_t datalen)
 {
 	struct user_key_payload *upayload;
 	int ret;
@@ -78,18 +64,20 @@ static int user_instantiate(struct key *
 	rcu_assign_pointer(key->payload.data, upayload);
 	ret = 0;
 
- error:
+error:
 	return ret;
 
 } /* end user_instantiate() */
 
+EXPORT_SYMBOL(user_instantiate);
+
 /*****************************************************************************/
 /*
  * duplicate a user defined key
  * - both keys' semaphores are locked against further modification
  * - the new key cannot yet be accessed
  */
-static int user_duplicate(struct key *key, const struct key *source)
+int user_duplicate(struct key *key, const struct key *source)
 {
 	struct user_key_payload *upayload, *spayload;
 	int ret;
@@ -112,6 +100,8 @@ static int user_duplicate(struct key *ke
 
 } /* end user_duplicate() */
 
+EXPORT_SYMBOL(user_duplicate);
+
 /*****************************************************************************/
 /*
  * dispose of the old data from an updated user defined key
@@ -131,7 +121,7 @@ static void user_update_rcu_disposal(str
  * update a user defined key
  * - the key's semaphore is write-locked
  */
-static int user_update(struct key *key, const void *data, size_t datalen)
+int user_update(struct key *key, const void *data, size_t datalen)
 {
 	struct user_key_payload *upayload, *zap;
 	int ret;
@@ -163,26 +153,30 @@ static int user_update(struct key *key, 
 
 	call_rcu(&zap->rcu, user_update_rcu_disposal);
 
- error:
+error:
 	return ret;
 
 } /* end user_update() */
 
+EXPORT_SYMBOL(user_update);
+
 /*****************************************************************************/
 /*
  * match users on their name
  */
-static int user_match(const struct key *key, const void *description)
+int user_match(const struct key *key, const void *description)
 {
 	return strcmp(key->description, description) == 0;
 
 } /* end user_match() */
 
+EXPORT_SYMBOL(user_match);
+
 /*****************************************************************************/
 /*
  * dispose of the data dangling from the corpse of a user
  */
-static void user_destroy(struct key *key)
+void user_destroy(struct key *key)
 {
 	struct user_key_payload *upayload = key->payload.data;
 
@@ -190,11 +184,13 @@ static void user_destroy(struct key *key
 
 } /* end user_destroy() */
 
+EXPORT_SYMBOL(user_destroy);
+
 /*****************************************************************************/
 /*
  * describe the user key
  */
-static void user_describe(const struct key *key, struct seq_file *m)
+void user_describe(const struct key *key, struct seq_file *m)
 {
 	seq_puts(m, key->description);
 
@@ -202,13 +198,14 @@ static void user_describe(const struct k
 
 } /* end user_describe() */
 
+EXPORT_SYMBOL(user_describe);
+
 /*****************************************************************************/
 /*
  * read the key data
  * - the key's semaphore is read-locked
  */
-static long user_read(const struct key *key,
-		      char __user *buffer, size_t buflen)
+long user_read(const struct key *key, char __user *buffer, size_t buflen)
 {
 	struct user_key_payload *upayload;
 	long ret;
@@ -228,3 +225,5 @@ static long user_read(const struct key *
 	return ret;
 
 } /* end user_read() */
+
+EXPORT_SYMBOL(user_read);
