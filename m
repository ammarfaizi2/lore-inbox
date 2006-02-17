Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030598AbWBQO42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030598AbWBQO42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030600AbWBQO42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:56:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40859 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030598AbWBQO41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:56:27 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Replace duplicate non-updateable keys rather than failing
X-Mailer: MH-E 7.91+cvs; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 17 Feb 2006 14:56:21 +0000
Message-ID: <8265.1140188181@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch causes an attempt to add a duplicate non-updateable key
(such as a keyring) to a keyring to discard the extant copy in favour of the
new one rather than failing with EEXIST:

	# do the test in an empty session
	keyctl session
	# create a new keyring called "a" and attach to session
	keyctl newring a @s
	# create another new keyring called "a" and attach to session,
	# displacing the keyring added by the second command:
	keyctl newring a @s

Without this patch, the third command will fail.

For updateable keys (such as those of "user" type), the update method will
still be called rather than a new key being created.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

warthog>diffstat -p1 keys-replace-2616rc3.diff
 security/keys/key.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff -uNrp linux-2.6.16-rc3-key-quota/security/keys/key.c linux-2.6.16-rc3-key-replace/security/keys/key.c
--- linux-2.6.16-rc3-key-quota/security/keys/key.c	2006-02-17 14:26:27.000000000 +0000
+++ linux-2.6.16-rc3-key-replace/security/keys/key.c	2006-02-17 14:31:39.000000000 +0000
@@ -795,12 +795,16 @@ key_ref_t key_create_or_update(key_ref_t
 		goto error_3;
 	}
 
-	/* search for an existing key of the same type and description in the
-	 * destination keyring
+	/* if it's possible to update this type of key, search for an existing
+	 * key of the same type and description in the destination keyring and
+	 * update that instead if possible
 	 */
-	key_ref = __keyring_search_one(keyring_ref, ktype, description, 0);
-	if (!IS_ERR(key_ref))
-		goto found_matching_key;
+	if (ktype->update) {
+		key_ref = __keyring_search_one(keyring_ref, ktype, description,
+					       0);
+		if (!IS_ERR(key_ref))
+			goto found_matching_key;
+	}
 
 	/* decide on the permissions we want */
 	perm = KEY_POS_VIEW | KEY_POS_SEARCH | KEY_POS_LINK | KEY_POS_SETATTR;
