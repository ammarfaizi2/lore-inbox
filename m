Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWFTRiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWFTRiI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWFTRhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:37:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3794 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750718AbWFTRhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:37:43 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/6] Keys: Discard the contents of a key on revocation [try #3]
Date: Tue, 20 Jun 2006 18:37:40 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, keyrings@linux-nfs.org
Message-Id: <20060620173740.5034.82140.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060620173735.5034.11436.stgit@warthog.cambridge.redhat.com>
References: <20060620173735.5034.11436.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The attached patch causes the keys linked to a keyring to be unlinked from it
when revoked and it causes the data attached to a user-defined key to be
discarded when revoked.

This frees up most of the quota a key occupied at that point, rather than
waiting for the key to actually be destroyed.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/keys/user-type.h     |    1 +
 security/keys/keyring.c      |   21 +++++++++++++++++++++
 security/keys/user_defined.c |   25 ++++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/include/keys/user-type.h b/include/keys/user-type.h
index a3dae18..c37c342 100644
--- a/include/keys/user-type.h
+++ b/include/keys/user-type.h
@@ -37,6 +37,7 @@ extern struct key_type key_type_user;
 extern int user_instantiate(struct key *key, const void *data, size_t datalen);
 extern int user_update(struct key *key, const void *data, size_t datalen);
 extern int user_match(const struct key *key, const void *criterion);
+extern void user_revoke(struct key *key);
 extern void user_destroy(struct key *key);
 extern void user_describe(const struct key *user, struct seq_file *m);
 extern long user_read(const struct key *key,
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 6c282bd..e8d02ac 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -49,6 +49,7 @@ static inline unsigned keyring_hash(cons
 static int keyring_instantiate(struct key *keyring,
 			       const void *data, size_t datalen);
 static int keyring_match(const struct key *keyring, const void *criterion);
+static void keyring_revoke(struct key *keyring);
 static void keyring_destroy(struct key *keyring);
 static void keyring_describe(const struct key *keyring, struct seq_file *m);
 static long keyring_read(const struct key *keyring,
@@ -59,6 +60,7 @@ struct key_type key_type_keyring = {
 	.def_datalen	= sizeof(struct keyring_list),
 	.instantiate	= keyring_instantiate,
 	.match		= keyring_match,
+	.revoke		= keyring_revoke,
 	.destroy	= keyring_destroy,
 	.describe	= keyring_describe,
 	.read		= keyring_read,
@@ -953,3 +955,22 @@ int keyring_clear(struct key *keyring)
 } /* end keyring_clear() */
 
 EXPORT_SYMBOL(keyring_clear);
+
+/*****************************************************************************/
+/*
+ * dispose of the links from a revoked keyring
+ * - called with the key sem write-locked
+ */
+static void keyring_revoke(struct key *keyring)
+{
+	struct keyring_list *klist = keyring->payload.subscriptions;
+
+	/* adjust the quota */
+	key_payload_reserve(keyring, 0);
+
+	if (klist) {
+		rcu_assign_pointer(keyring->payload.subscriptions, NULL);
+		call_rcu(&klist->rcu, keyring_clear_rcu_disposal);
+	}
+
+} /* end keyring_revoke() */
diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
index 8e71895..5bbfdeb 100644
--- a/security/keys/user_defined.c
+++ b/security/keys/user_defined.c
@@ -28,6 +28,7 @@ struct key_type key_type_user = {
 	.instantiate	= user_instantiate,
 	.update		= user_update,
 	.match		= user_match,
+	.revoke		= user_revoke,
 	.destroy	= user_destroy,
 	.describe	= user_describe,
 	.read		= user_read,
@@ -67,6 +68,7 @@ error:
 	return ret;
 
 } /* end user_instantiate() */
+
 EXPORT_SYMBOL_GPL(user_instantiate);
 
 /*****************************************************************************/
@@ -141,7 +143,28 @@ EXPORT_SYMBOL_GPL(user_match);
 
 /*****************************************************************************/
 /*
- * dispose of the data dangling from the corpse of a user
+ * dispose of the links from a revoked keyring
+ * - called with the key sem write-locked
+ */
+void user_revoke(struct key *key)
+{
+	struct user_key_payload *upayload = key->payload.data;
+
+	/* clear the quota */
+	key_payload_reserve(key, 0);
+
+	if (upayload) {
+		rcu_assign_pointer(key->payload.data, NULL);
+		call_rcu(&upayload->rcu, user_update_rcu_disposal);
+	}
+
+} /* end user_revoke() */
+
+EXPORT_SYMBOL(user_revoke);
+
+/*****************************************************************************/
+/*
+ * dispose of the data dangling from the corpse of a user key
  */
 void user_destroy(struct key *key)
 {

