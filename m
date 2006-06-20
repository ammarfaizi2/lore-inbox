Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWFTRir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWFTRir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWFTRiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:38:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12754 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750718AbWFTRhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:37:51 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/6] Keys: Let keyctl_chown() change a key's owner [try #3]
Date: Tue, 20 Jun 2006 18:37:42 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, keyrings@linux-nfs.org
Message-Id: <20060620173742.5034.31228.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060620173735.5034.11436.stgit@warthog.cambridge.redhat.com>
References: <20060620173735.5034.11436.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fredrik Tolf <fredrik@dolda2000.com>

The attached patch lets keyctl_chown() change a key's owner, including
attempting to transfer the quota burden to the new user.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 security/keys/keyctl.c |   56 +++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index d744585..329411c 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -673,6 +673,7 @@ long keyctl_read_key(key_serial_t keyid,
  */
 long keyctl_chown_key(key_serial_t id, uid_t uid, gid_t gid)
 {
+	struct key_user *newowner, *zapowner = NULL;
 	struct key *key;
 	key_ref_t key_ref;
 	long ret;
@@ -696,19 +697,50 @@ long keyctl_chown_key(key_serial_t id, u
 	if (!capable(CAP_SYS_ADMIN)) {
 		/* only the sysadmin can chown a key to some other UID */
 		if (uid != (uid_t) -1 && key->uid != uid)
-			goto no_access;
+			goto error_put;
 
 		/* only the sysadmin can set the key's GID to a group other
 		 * than one of those that the current process subscribes to */
 		if (gid != (gid_t) -1 && gid != key->gid && !in_group_p(gid))
-			goto no_access;
+			goto error_put;
 	}
 
-	/* change the UID (have to update the quotas) */
+	/* change the UID */
 	if (uid != (uid_t) -1 && uid != key->uid) {
-		/* don't support UID changing yet */
-		ret = -EOPNOTSUPP;
-		goto no_access;
+		ret = -ENOMEM;
+		newowner = key_user_lookup(uid);
+		if (!newowner)
+			goto error_put;
+
+		/* transfer the quota burden to the new user */
+		if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
+			spin_lock(&newowner->lock);
+			if (newowner->qnkeys + 1 >= KEYQUOTA_MAX_KEYS ||
+			    newowner->qnbytes + key->quotalen >=
+			    KEYQUOTA_MAX_BYTES)
+				goto quota_overrun;
+
+			newowner->qnkeys++;
+			newowner->qnbytes += key->quotalen;
+			spin_unlock(&newowner->lock);
+
+			spin_lock(&key->user->lock);
+			key->user->qnkeys--;
+			key->user->qnbytes -= key->quotalen;
+			spin_unlock(&key->user->lock);
+		}
+
+		atomic_dec(&key->user->nkeys);
+		atomic_inc(&newowner->nkeys);
+
+		if (test_bit(KEY_FLAG_INSTANTIATED, &key->flags)) {
+			atomic_dec(&key->user->nikeys);
+			atomic_inc(&newowner->nikeys);
+		}
+
+		zapowner = key->user;
+		key->user = newowner;
+		key->uid = uid;
 	}
 
 	/* change the GID */
@@ -717,12 +749,20 @@ long keyctl_chown_key(key_serial_t id, u
 
 	ret = 0;
 
- no_access:
+error_put:
 	up_write(&key->sem);
 	key_put(key);
- error:
+	if (zapowner)
+		key_user_put(zapowner);
+error:
 	return ret;
 
+quota_overrun:
+	spin_unlock(&newowner->lock);
+	zapowner = newowner;
+	ret = -EDQUOT;
+	goto error_put;
+
 } /* end keyctl_chown_key() */
 
 /*****************************************************************************/

