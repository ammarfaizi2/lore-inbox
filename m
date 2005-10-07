Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030475AbVJGQJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbVJGQJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 12:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbVJGQJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 12:09:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27270 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030475AbVJGQJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 12:09:22 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <26883.1128700665@warthog.cambridge.redhat.com> 
References: <26883.1128700665@warthog.cambridge.redhat.com>  <19008.1128699684@warthog.cambridge.redhat.com> <11615.1128694058@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org
Cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Remove key duplication
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 07 Oct 2005 17:08:54 +0100
Message-ID: <2622.1128701334@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch removes the key duplication stuff since there's nothing
that uses it, no way to get at it and it's awkward to deal with for LSM
purposes.

This patch should be applied on top of the one ensubjected:

	[PATCH] Keys: Add LSM hooks for key management [try #2] 

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-nodup-2614rc3.diff
 Documentation/keys.txt       |   18 ------------
 include/keys/user-type.h     |    1 
 include/linux/key.h          |    8 -----
 security/keys/key.c          |   56 ++-----------------------------------
 security/keys/keyring.c      |   64 -------------------------------------------
 security/keys/user_defined.c |   32 ---------------------
 6 files changed, 3 insertions(+), 176 deletions(-)

diff -uNrp linux-2.6.14-rc3-keys-lsm/Documentation/keys.txt linux-2.6.14-rc3-keys-nodup/Documentation/keys.txt
--- linux-2.6.14-rc3-keys-lsm/Documentation/keys.txt	2005-10-07 16:33:26.000000000 +0100
+++ linux-2.6.14-rc3-keys-nodup/Documentation/keys.txt	2005-10-07 16:59:59.000000000 +0100
@@ -860,24 +860,6 @@ The structure has a number of fields, so
      It is safe to sleep in this method.
 
 
- (*) int (*duplicate)(struct key *key, const struct key *source);
-
-     If this type of key can be duplicated, then this method should be
-     provided. It is called to copy the payload attached to the source into the
-     new key. The data length on the new key will have been updated and the
-     quota adjusted already.
-
-     This method will be called with the source key's semaphore read-locked to
-     prevent its payload from being changed, thus RCU constraints need not be
-     applied to the source key.
-
-     This method does not have to lock the destination key in order to attach a
-     payload. The fact that KEY_FLAG_INSTANTIATED is not set in key->flags
-     prevents anything else from gaining access to the key.
-
-     It is safe to sleep in this method.
-
-
  (*) int (*update)(struct key *key, const void *data, size_t datalen);
 
      If this type of key can be updated, then this method should be provided.
diff -uNrp linux-2.6.14-rc3-keys-lsm/include/keys/user-type.h linux-2.6.14-rc3-keys-nodup/include/keys/user-type.h
--- linux-2.6.14-rc3-keys-lsm/include/keys/user-type.h	2005-10-05 11:44:54.000000000 +0100
+++ linux-2.6.14-rc3-keys-nodup/include/keys/user-type.h	2005-10-07 17:03:19.000000000 +0100
@@ -35,7 +35,6 @@ struct user_key_payload {
 extern struct key_type key_type_user;
 
 extern int user_instantiate(struct key *key, const void *data, size_t datalen);
-extern int user_duplicate(struct key *key, const struct key *source);
 extern int user_update(struct key *key, const void *data, size_t datalen);
 extern int user_match(const struct key *key, const void *criterion);
 extern void user_destroy(struct key *key);
diff -uNrp linux-2.6.14-rc3-keys-lsm/include/linux/key.h linux-2.6.14-rc3-keys-nodup/include/linux/key.h
--- linux-2.6.14-rc3-keys-lsm/include/linux/key.h	2005-10-07 15:46:29.000000000 +0100
+++ linux-2.6.14-rc3-keys-nodup/include/linux/key.h	2005-10-07 17:00:08.000000000 +0100
@@ -193,14 +193,6 @@ struct key_type {
 	 */
 	int (*instantiate)(struct key *key, const void *data, size_t datalen);
 
-	/* duplicate a key of this type (optional)
-	 * - the source key will be locked against change
-	 * - the new description will be attached
-	 * - the quota will have been adjusted automatically from
-	 *   source->quotalen
-	 */
-	int (*duplicate)(struct key *key, const struct key *source);
-
 	/* update a key of this type (optional)
 	 * - this method should call key_payload_reserve() to recalculate the
 	 *   quota consumption
diff -uNrp linux-2.6.14-rc3-keys-lsm/security/keys/key.c linux-2.6.14-rc3-keys-nodup/security/keys/key.c
--- linux-2.6.14-rc3-keys-lsm/security/keys/key.c	2005-10-07 16:07:17.000000000 +0100
+++ linux-2.6.14-rc3-keys-nodup/security/keys/key.c	2005-10-07 16:59:20.000000000 +0100
@@ -241,9 +241,9 @@ static inline void key_alloc_serial(stru
 /*
  * allocate a key of the specified type
  * - update the user's quota to reflect the existence of the key
- * - called from a key-type operation with key_types_sem read-locked by either
- *   key_create_or_update() or by key_duplicate(); this prevents unregistration
- *   of the key type
+ * - called from a key-type operation with key_types_sem read-locked by
+ *   key_create_or_update()
+ *   - this prevents unregistration of the key type
  * - upon return the key is as yet uninstantiated; the caller needs to either
  *   instantiate the key or discard it before returning
  */
@@ -890,56 +890,6 @@ EXPORT_SYMBOL(key_update);
 
 /*****************************************************************************/
 /*
- * duplicate a key, potentially with a revised description
- * - must be supported by the keytype (keyrings for instance can be duplicated)
- */
-struct key *key_duplicate(struct key *source, const char *desc)
-{
-	struct key *key;
-	int ret;
-
-	key_check(source);
-
-	if (!desc)
-		desc = source->description;
-
-	down_read(&key_types_sem);
-
-	ret = -EINVAL;
-	if (!source->type->duplicate)
-		goto error;
-
-	/* allocate and instantiate a key */
-	key = key_alloc(source->type, desc, current->fsuid, current->fsgid,
-			source->perm, 0);
-	if (IS_ERR(key))
-		goto error_k;
-
-	down_read(&source->sem);
-	ret = key->type->duplicate(key, source);
-	up_read(&source->sem);
-	if (ret < 0)
-		goto error2;
-
-	atomic_inc(&key->user->nikeys);
-	set_bit(KEY_FLAG_INSTANTIATED, &key->flags);
-
- error_k:
-	up_read(&key_types_sem);
- out:
-	return key;
-
- error2:
-	key_put(key);
- error:
-	up_read(&key_types_sem);
-	key = ERR_PTR(ret);
-	goto out;
-
-} /* end key_duplicate() */
-
-/*****************************************************************************/
-/*
  * revoke a key
  */
 void key_revoke(struct key *key)
diff -uNrp linux-2.6.14-rc3-keys-lsm/security/keys/keyring.c linux-2.6.14-rc3-keys-nodup/security/keys/keyring.c
--- linux-2.6.14-rc3-keys-lsm/security/keys/keyring.c	2005-10-07 16:11:56.000000000 +0100
+++ linux-2.6.14-rc3-keys-nodup/security/keys/keyring.c	2005-10-07 16:59:30.000000000 +0100
@@ -48,7 +48,6 @@ static inline unsigned keyring_hash(cons
  */
 static int keyring_instantiate(struct key *keyring,
 			       const void *data, size_t datalen);
-static int keyring_duplicate(struct key *keyring, const struct key *source);
 static int keyring_match(const struct key *keyring, const void *criterion);
 static void keyring_destroy(struct key *keyring);
 static void keyring_describe(const struct key *keyring, struct seq_file *m);
@@ -59,7 +58,6 @@ struct key_type key_type_keyring = {
 	.name		= "keyring",
 	.def_datalen	= sizeof(struct keyring_list),
 	.instantiate	= keyring_instantiate,
-	.duplicate	= keyring_duplicate,
 	.match		= keyring_match,
 	.destroy	= keyring_destroy,
 	.describe	= keyring_describe,
@@ -120,68 +118,6 @@ static int keyring_instantiate(struct ke
 
 /*****************************************************************************/
 /*
- * duplicate the list of subscribed keys from a source keyring into this one
- */
-static int keyring_duplicate(struct key *keyring, const struct key *source)
-{
-	struct keyring_list *sklist, *klist;
-	unsigned max;
-	size_t size;
-	int loop, ret;
-
-	const unsigned limit =
-		(PAGE_SIZE - sizeof(*klist)) / sizeof(struct key *);
-
-	ret = 0;
-
-	/* find out how many keys are currently linked */
-	rcu_read_lock();
-	sklist = rcu_dereference(source->payload.subscriptions);
-	max = 0;
-	if (sklist)
-		max = sklist->nkeys;
-	rcu_read_unlock();
-
-	/* allocate a new payload and stuff load with key links */
-	if (max > 0) {
-		BUG_ON(max > limit);
-
-		max = (max + 3) & ~3;
-		if (max > limit)
-			max = limit;
-
-		ret = -ENOMEM;
-		size = sizeof(*klist) + sizeof(struct key *) * max;
-		klist = kmalloc(size, GFP_KERNEL);
-		if (!klist)
-			goto error;
-
-		/* set links */
-		rcu_read_lock();
-		sklist = rcu_dereference(source->payload.subscriptions);
-
-		klist->maxkeys = max;
-		klist->nkeys = sklist->nkeys;
-		memcpy(klist->keys,
-		       sklist->keys,
-		       sklist->nkeys * sizeof(struct key *));
-
-		for (loop = klist->nkeys - 1; loop >= 0; loop--)
-			atomic_inc(&klist->keys[loop]->usage);
-
-		rcu_read_unlock();
-
-		rcu_assign_pointer(keyring->payload.subscriptions, klist);
-		ret = 0;
-	}
-
- error:
-	return ret;
-
-} /* end keyring_duplicate() */
-
-/*****************************************************************************/
-/*
  * match keyrings on their name
  */
 static int keyring_match(const struct key *keyring, const void *description)
diff -uNrp linux-2.6.14-rc3-keys-lsm/security/keys/user_defined.c linux-2.6.14-rc3-keys-nodup/security/keys/user_defined.c
--- linux-2.6.14-rc3-keys-lsm/security/keys/user_defined.c	2005-10-05 11:37:04.000000000 +0100
+++ linux-2.6.14-rc3-keys-nodup/security/keys/user_defined.c	2005-10-07 16:59:41.000000000 +0100
@@ -26,7 +26,6 @@
 struct key_type key_type_user = {
 	.name		= "user",
 	.instantiate	= user_instantiate,
-	.duplicate	= user_duplicate,
 	.update		= user_update,
 	.match		= user_match,
 	.destroy	= user_destroy,
@@ -73,37 +72,6 @@ EXPORT_SYMBOL(user_instantiate);
 
 /*****************************************************************************/
 /*
- * duplicate a user defined key
- * - both keys' semaphores are locked against further modification
- * - the new key cannot yet be accessed
- */
-int user_duplicate(struct key *key, const struct key *source)
-{
-	struct user_key_payload *upayload, *spayload;
-	int ret;
-
-	/* just copy the payload */
-	ret = -ENOMEM;
-	upayload = kmalloc(sizeof(*upayload) + source->datalen, GFP_KERNEL);
-	if (upayload) {
-		spayload = rcu_dereference(source->payload.data);
-		BUG_ON(source->datalen != spayload->datalen);
-
-		upayload->datalen = key->datalen = spayload->datalen;
-		memcpy(upayload->data, spayload->data, key->datalen);
-
-		key->payload.data = upayload;
-		ret = 0;
-	}
-
-	return ret;
-
-} /* end user_duplicate() */
-
-EXPORT_SYMBOL(user_duplicate);
-
-/*****************************************************************************/
-/*
  * dispose of the old data from an updated user defined key
  */
 static void user_update_rcu_disposal(struct rcu_head *rcu)
