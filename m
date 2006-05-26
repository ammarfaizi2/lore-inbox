Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWEZOJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWEZOJM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWEZOJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:09:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17079 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750762AbWEZOJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:09:11 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Fix race between two instantiators of a key
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 26 May 2006 15:08:43 +0100
Message-ID: <24029.1148652523@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch adds a revocation notification method to the key type and
calls it whilst the key's semaphore is still write-locked after setting the
revocation flag.

The patch then uses this to maintain a reference on the task_struct of the
process that calls request_key() for as long as the authorisation key remains
unrevoked.

This fixes a potential race between two processes both of which have assumed
the authority to instantiate a key (one may have forked the other for
example).  The problem is that there's no locking around the check for
revocation of the auth key and the use of the task_struct it points to, nor
does the auth key keep a reference on the task_struct.

Access to the "context" pointer in the auth key must thenceforth be done with
the auth key semaphore held.  The revocation method is called with the target
key semaphore held write-locked and the search of the context process's
keyrings is done with the auth key semaphore read-locked.

The check for the revocation state of the auth key just prior to searching it
is done after the auth key is read-locked for the search.  This ensures that
the auth key can't be revoked between the check and the search.

The revocation notification method is added so that the context task_struct
can be released as soon as instantiation happens rather than waiting for the
auth key to be destroyed, thus avoiding the unnecessary pinning of the
requesting process.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-revoke-2617rc5.diff
 Documentation/keys.txt           |   10 ++++++++
 include/linux/key.h              |    5 ++++
 security/keys/key.c              |    4 +++
 security/keys/process_keys.c     |   43 +++++++++++++++++++++++--------------
 security/keys/request_key_auth.c |   45 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 90 insertions(+), 17 deletions(-)

diff -uNrp linux-2.6.17-rc5/Documentation/keys.txt linux-2.6.17-rc5-keys/Documentation/keys.txt
--- linux-2.6.17-rc5/Documentation/keys.txt	2006-05-26 10:54:09.000000000 +0100
+++ linux-2.6.17-rc5-keys/Documentation/keys.txt	2006-05-26 14:41:47.000000000 +0100
@@ -935,6 +935,16 @@ The structure has a number of fields, so
      It is not safe to sleep in this method; the caller may hold spinlocks.
 
 
+ (*) void (*revoke)(struct key *key);
+
+     This method is optional.  It is called to discard part of the payload
+     data upon a key being revoked.  The caller will have the key semaphore
+     write-locked.
+
+     It is safe to sleep in this method, though care should be taken to avoid
+     a deadlock against the key semaphore.
+
+
  (*) void (*destroy)(struct key *key);
 
      This method is optional. It is called to discard the payload data on a key
diff -uNrp linux-2.6.17-rc5/include/linux/key.h linux-2.6.17-rc5-keys/include/linux/key.h
--- linux-2.6.17-rc5/include/linux/key.h	2006-05-26 10:54:33.000000000 +0100
+++ linux-2.6.17-rc5-keys/include/linux/key.h	2006-05-26 13:41:30.000000000 +0100
@@ -205,6 +205,11 @@ struct key_type {
 	/* match a key against a description */
 	int (*match)(const struct key *key, const void *desc);
 
+	/* clear some of the data from a key on revokation (optional)
+	 * - the key's semaphore will be write-locked by the caller
+	 */
+	void (*revoke)(struct key *key);
+
 	/* clear the data from a key (optional) */
 	void (*destroy)(struct key *key);
 
diff -uNrp linux-2.6.17-rc5/security/keys/key.c linux-2.6.17-rc5-keys/security/keys/key.c
--- linux-2.6.17-rc5/security/keys/key.c	2006-05-26 10:55:05.000000000 +0100
+++ linux-2.6.17-rc5-keys/security/keys/key.c	2006-05-26 10:59:47.000000000 +0100
@@ -907,6 +907,10 @@ void key_revoke(struct key *key)
 	 * it */
 	down_write(&key->sem);
 	set_bit(KEY_FLAG_REVOKED, &key->flags);
+
+	if (key->type->revoke)
+		key->type->revoke(key);
+
 	up_write(&key->sem);
 
 } /* end key_revoke() */
diff -uNrp linux-2.6.17-rc5/security/keys/process_keys.c linux-2.6.17-rc5-keys/security/keys/process_keys.c
--- linux-2.6.17-rc5/security/keys/process_keys.c	2006-05-26 10:55:05.000000000 +0100
+++ linux-2.6.17-rc5-keys/security/keys/process_keys.c	2006-05-26 11:38:53.000000000 +0100
@@ -390,6 +390,8 @@ key_ref_t search_process_keyrings(struct
 	struct request_key_auth *rka;
 	key_ref_t key_ref, ret, err;
 
+	might_sleep();
+
 	/* we want to return -EAGAIN or -ENOKEY if any of the keyrings were
 	 * searchable, but we failed to find a key or we found a negative key;
 	 * otherwise we want to return a sample error (probably -EACCES) if
@@ -495,27 +497,36 @@ key_ref_t search_process_keyrings(struct
 	 */
 	if (context->request_key_auth &&
 	    context == current &&
-	    type != &key_type_request_key_auth &&
-	    key_validate(context->request_key_auth) == 0
+	    type != &key_type_request_key_auth
 	    ) {
-		rka = context->request_key_auth->payload.data;
+		/* defend against the auth key being revoked */
+		down_read(&context->request_key_auth->sem);
 
-		key_ref = search_process_keyrings(type, description, match,
-						  rka->context);
+		if (key_validate(context->request_key_auth) == 0) {
+			rka = context->request_key_auth->payload.data;
 
-		if (!IS_ERR(key_ref))
-			goto found;
+			key_ref = search_process_keyrings(type, description,
+							  match, rka->context);
 
-		switch (PTR_ERR(key_ref)) {
-		case -EAGAIN: /* no key */
-			if (ret)
+			up_read(&context->request_key_auth->sem);
+
+			if (!IS_ERR(key_ref))
+				goto found;
+
+			switch (PTR_ERR(key_ref)) {
+			case -EAGAIN: /* no key */
+				if (ret)
+					break;
+			case -ENOKEY: /* negative key */
+				ret = key_ref;
 				break;
-		case -ENOKEY: /* negative key */
-			ret = key_ref;
-			break;
-		default:
-			err = key_ref;
-			break;
+			default:
+				err = key_ref;
+				break;
+			}
+		}
+		else {
+			up_read(&context->request_key_auth->sem);
 		}
 	}
 
diff -uNrp linux-2.6.17-rc5/security/keys/request_key_auth.c linux-2.6.17-rc5-keys/security/keys/request_key_auth.c
--- linux-2.6.17-rc5/security/keys/request_key_auth.c	2006-05-26 10:54:40.000000000 +0100
+++ linux-2.6.17-rc5-keys/security/keys/request_key_auth.c	2006-05-26 11:39:59.000000000 +0100
@@ -20,6 +20,7 @@
 
 static int request_key_auth_instantiate(struct key *, const void *, size_t);
 static void request_key_auth_describe(const struct key *, struct seq_file *);
+static void request_key_auth_revoke(struct key *);
 static void request_key_auth_destroy(struct key *);
 static long request_key_auth_read(const struct key *, char __user *, size_t);
 
@@ -31,6 +32,7 @@ struct key_type key_type_request_key_aut
 	.def_datalen	= sizeof(struct request_key_auth),
 	.instantiate	= request_key_auth_instantiate,
 	.describe	= request_key_auth_describe,
+	.revoke		= request_key_auth_revoke,
 	.destroy	= request_key_auth_destroy,
 	.read		= request_key_auth_read,
 };
@@ -93,6 +95,24 @@ static long request_key_auth_read(const 
 
 /*****************************************************************************/
 /*
+ * handle revocation of an authorisation token key
+ * - called with the key sem write-locked
+ */
+static void request_key_auth_revoke(struct key *key)
+{
+	struct request_key_auth *rka = key->payload.data;
+
+	kenter("{%d}", key->serial);
+
+	if (rka->context) {
+		put_task_struct(rka->context);
+		rka->context = NULL;
+	}
+	
+} /* end request_key_auth_revoke() */
+
+/*****************************************************************************/
+/*
  * destroy an instantiation authorisation token key
  */
 static void request_key_auth_destroy(struct key *key)
@@ -101,6 +121,11 @@ static void request_key_auth_destroy(str
 
 	kenter("{%d}", key->serial);
 
+	if (rka->context) {
+		put_task_struct(rka->context);
+		rka->context = NULL;
+	}
+
 	key_put(rka->target_key);
 	kfree(rka);
 
@@ -131,14 +156,26 @@ struct key *request_key_auth_new(struct 
 	 * another process */
 	if (current->request_key_auth) {
 		/* it is - use that instantiation context here too */
+		down_read(&current->request_key_auth->sem);
+
+		/* if the auth key has been revoked, then the key we're
+		 * servicing is already instantiated */
+		if (test_bit(KEY_FLAG_REVOKED,
+			     &current->request_key_auth->flags))
+			goto auth_key_revoked;
+
 		irka = current->request_key_auth->payload.data;
 		rka->context = irka->context;
 		rka->pid = irka->pid;
+		get_task_struct(rka->context);
+
+		up_read(&current->request_key_auth->sem);
 	}
 	else {
 		/* it isn't - use this process as the context */
 		rka->context = current;
 		rka->pid = current->pid;
+		get_task_struct(rka->context);
 	}
 
 	rka->target_key = key_get(target);
@@ -161,9 +198,15 @@ struct key *request_key_auth_new(struct 
 	if (ret < 0)
 		goto error_inst;
 
-	kleave(" = {%d})", authkey->serial);
+	kleave(" = {%d}", authkey->serial);
 	return authkey;
 
+auth_key_revoked:
+	up_read(&current->request_key_auth->sem);
+	kfree(rka);
+	kleave("= -EKEYREVOKED");
+	return ERR_PTR(-EKEYREVOKED);
+
 error_inst:
 	key_revoke(authkey);
 	key_put(authkey);

