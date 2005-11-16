Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbVKPOTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbVKPOTi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbVKPOTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:19:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24299 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751470AbVKPOTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:19:37 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <25039.1132150357@warthog.cambridge.redhat.com> 
References: <25039.1132150357@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org, Alexander Zangerl <az@bond.edu.au>
Cc: linux-kernel@vger.kernel.org, keyrings@linux-nfs.org
Subject: [PATCH] Keys: Discard duplicate keys from a keyring on link
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 16 Nov 2005 14:19:28 +0000
Message-ID: <25194.1132150768@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch causes any links within a keyring to keys that match a key
to be linked into that keyring to be discarded as a link to the new key is
added. The match is contingent on the type and description strings being the
same.

This permits requests, adds and searches to displace negative, expired, revoked
and dead keys easily. After some discussion it was concluded that duplicate
valid keys should probably be discarded also as they would otherwise hide the
new key.

Since request_key() is intended to be the primary method by which keys are
added to a keyring, duplicate valid keys wouldn't be an issue there as that
function would return an existing match in preference to creating a new key.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat keys-multilink-2615rc1.diff 
 Documentation/keys.txt  |    4 ++
 security/keys/keyring.c |   87 +++++++++++++++++++++++++++++++++++-------------
 2 files changed, 68 insertions(+), 23 deletions(-)

diff -uNrp linux-2.6.15-rc1-keys-expiry/Documentation/keys.txt linux-2.6.15-rc1-keys-multilink/Documentation/keys.txt
--- linux-2.6.15-rc1-keys-expiry/Documentation/keys.txt	2005-11-16 12:36:33.000000000 +0000
+++ linux-2.6.15-rc1-keys-multilink/Documentation/keys.txt	2005-11-16 14:02:22.000000000 +0000
@@ -500,6 +500,10 @@ The keyctl syscall functions are:
      The link procedure checks the nesting of the keyrings, returning ELOOP if
      it appears too deep or EDEADLK if the link would introduce a cycle.
 
+     Any links within the keyring to keys that match the new key in terms of
+     type and description will be discarded from the keyring as the new one is
+     added.
+
 
  (*) Unlink a key or keyring from another keyring:
 
diff -uNrp linux-2.6.15-rc1-keys-expiry/security/keys/keyring.c linux-2.6.15-rc1-keys-multilink/security/keys/keyring.c
--- linux-2.6.15-rc1-keys-expiry/security/keys/keyring.c	2005-11-16 11:42:28.000000000 +0000
+++ linux-2.6.15-rc1-keys-multilink/security/keys/keyring.c	2005-11-16 13:36:05.000000000 +0000
@@ -748,15 +748,31 @@ static void keyring_link_rcu_disposal(st
 
 /*****************************************************************************/
 /*
+ * dispose of a keyring list after the RCU grace period, freeing the unlinked
+ * key
+ */
+static void keyring_unlink_rcu_disposal(struct rcu_head *rcu)
+{
+	struct keyring_list *klist =
+		container_of(rcu, struct keyring_list, rcu);
+
+	key_put(klist->keys[klist->delkey]);
+	kfree(klist);
+
+} /* end keyring_unlink_rcu_disposal() */
+
+/*****************************************************************************/
+/*
  * link a key into to a keyring
  * - must be called with the keyring's semaphore write-locked
+ * - discard already extant link to matching key if there is one
  */
 int __key_link(struct key *keyring, struct key *key)
 {
 	struct keyring_list *klist, *nklist;
 	unsigned max;
 	size_t size;
-	int ret;
+	int loop, ret;
 
 	ret = -EKEYREVOKED;
 	if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
@@ -778,6 +794,48 @@ int __key_link(struct key *keyring, stru
 			goto error2;
 	}
 
+	/* see if there's a matching key we can displace */
+	klist = keyring->payload.subscriptions;
+
+	if (klist && klist->nkeys > 0) {
+		struct key_type *type = key->type;
+
+		for (loop = klist->nkeys - 1; loop >= 0; loop--) {
+			if (klist->keys[loop]->type == type &&
+			    strcmp(klist->keys[loop]->description,
+				   key->description) == 0
+			    ) {
+				/* found a match - replace with new key */
+				size = sizeof(struct key *) * klist->maxkeys;
+				size += sizeof(*klist);
+				BUG_ON(size > PAGE_SIZE);
+
+				ret = -ENOMEM;
+				nklist = kmalloc(size, GFP_KERNEL);
+				if (!nklist)
+					goto error2;
+
+				memcpy(nklist, klist, size);
+
+				/* replace matched key */
+				atomic_inc(&key->usage);
+				nklist->keys[loop] = key;
+
+				rcu_assign_pointer(
+					keyring->payload.subscriptions,
+					nklist);
+
+				/* dispose of the old keyring list and the
+				 * displaced key */
+				klist->delkey = loop;
+				call_rcu(&klist->rcu,
+					 keyring_unlink_rcu_disposal);
+
+				goto done;
+			}
+		}
+	}
+
 	/* check that we aren't going to overrun the user's quota */
 	ret = key_payload_reserve(keyring,
 				  keyring->datalen + KEYQUOTA_LINK_BYTES);
@@ -794,8 +852,6 @@ int __key_link(struct key *keyring, stru
 		smp_wmb();
 		klist->nkeys++;
 		smp_wmb();
-
-		ret = 0;
 	}
 	else {
 		/* grow the key list */
@@ -833,16 +889,16 @@ int __key_link(struct key *keyring, stru
 		/* dispose of the old keyring list */
 		if (klist)
 			call_rcu(&klist->rcu, keyring_link_rcu_disposal);
-
-		ret = 0;
 	}
 
- error2:
+done:
+	ret = 0;
+error2:
 	up_write(&keyring_serialise_link_sem);
- error:
+error:
 	return ret;
 
- error3:
+error3:
 	/* undo the quota changes */
 	key_payload_reserve(keyring,
 			    keyring->datalen - KEYQUOTA_LINK_BYTES);
@@ -873,21 +929,6 @@ EXPORT_SYMBOL(key_link);
 
 /*****************************************************************************/
 /*
- * dispose of a keyring list after the RCU grace period, freeing the unlinked
- * key
- */
-static void keyring_unlink_rcu_disposal(struct rcu_head *rcu)
-{
-	struct keyring_list *klist =
-		container_of(rcu, struct keyring_list, rcu);
-
-	key_put(klist->keys[klist->delkey]);
-	kfree(klist);
-
-} /* end keyring_unlink_rcu_disposal() */
-
-/*****************************************************************************/
-/*
  * unlink the first link to a key from a keyring
  */
 int key_unlink(struct key *keyring, struct key *key)
