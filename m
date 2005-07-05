Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVGETa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVGETa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 15:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVGETa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 15:30:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36265 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261398AbVGET1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 15:27:04 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Base keyring size on key pointer not key struct
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Tue, 05 Jul 2005 20:26:56 +0100
Message-ID: <369.1120591616@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes the keyring functions calculate the new size of a
keyring's payload based on the size of pointer to the key struct, not the size
of the key struct itself.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 ../keys-2612mm1.diff 
 security/keys/keyring.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff -uNrp linux-2.6.12-mm1/security/keys/keyring.c linux-2.6.12-mm1-keys/security/keys/keyring.c
--- linux-2.6.12-mm1/security/keys/keyring.c	2005-06-22 13:54:09.000000000 +0100
+++ linux-2.6.12-mm1-keys/security/keys/keyring.c	2005-07-05 20:21:08.000000000 +0100
@@ -129,7 +129,7 @@ static int keyring_duplicate(struct key 
 	int loop, ret;
 
 	const unsigned limit =
-		(PAGE_SIZE - sizeof(*klist)) / sizeof(struct key);
+		(PAGE_SIZE - sizeof(*klist)) / sizeof(struct key *);
 
 	ret = 0;
 
@@ -150,7 +150,7 @@ static int keyring_duplicate(struct key 
 			max = limit;
 
 		ret = -ENOMEM;
-		size = sizeof(*klist) + sizeof(struct key) * max;
+		size = sizeof(*klist) + sizeof(struct key *) * max;
 		klist = kmalloc(size, GFP_KERNEL);
 		if (!klist)
 			goto error;
@@ -163,7 +163,7 @@ static int keyring_duplicate(struct key 
 		klist->nkeys = sklist->nkeys;
 		memcpy(klist->keys,
 		       sklist->keys,
-		       sklist->nkeys * sizeof(struct key));
+		       sklist->nkeys * sizeof(struct key *));
 
 		for (loop = klist->nkeys - 1; loop >= 0; loop--)
 			atomic_inc(&klist->keys[loop]->usage);
@@ -783,7 +783,7 @@ int __key_link(struct key *keyring, stru
 		ret = -ENFILE;
 		if (max > 65535)
 			goto error3;
-		size = sizeof(*klist) + sizeof(*key) * max;
+		size = sizeof(*klist) + sizeof(struct key *) * max;
 		if (size > PAGE_SIZE)
 			goto error3;
 
@@ -895,7 +895,8 @@ int key_unlink(struct key *keyring, stru
 
 key_is_present:
 	/* we need to copy the key list for RCU purposes */
-	nklist = kmalloc(sizeof(*klist) + sizeof(*key) * klist->maxkeys,
+	nklist = kmalloc(sizeof(*klist) +
+			 sizeof(struct key *) * klist->maxkeys,
 			 GFP_KERNEL);
 	if (!nklist)
 		goto nomem;
@@ -905,12 +906,12 @@ key_is_present:
 	if (loop > 0)
 		memcpy(&nklist->keys[0],
 		       &klist->keys[0],
-		       loop * sizeof(klist->keys[0]));
+		       loop * sizeof(struct key *));
 
 	if (loop < nklist->nkeys)
 		memcpy(&nklist->keys[loop],
 		       &klist->keys[loop + 1],
-		       (nklist->nkeys - loop) * sizeof(klist->keys[0]));
+		       (nklist->nkeys - loop) * sizeof(struct key *));
 
 	/* adjust the user's quota */
 	key_payload_reserve(keyring,
