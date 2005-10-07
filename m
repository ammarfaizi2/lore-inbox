Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbVJGPlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbVJGPlj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 11:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbVJGPlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 11:41:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48092 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030404AbVJGPli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 11:41:38 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <11615.1128694058@warthog.cambridge.redhat.com> 
References: <11615.1128694058@warthog.cambridge.redhat.com> 
To: torvalds@osdl.org, akpm@osdl.org
Cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Possessor permissions should be additive
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 07 Oct 2005 16:41:24 +0100
Message-ID: <19008.1128699684@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch makes the possessor permissions on a key additive with
user/group/other permissions on the same key.

This permits extra rights to be granted to the possessor of a key without
taking away any rights conferred by them owning the key or having common group
membership.

This needs to be applied on top of the patch ensubjected:

	[PATCH] Keys: Split key permissions checking into a .c file 

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-addperm-2614rc3.diff
 security/keys/permission.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff -uNrp linux-2.6.14-rc3-keys-split/security/keys/permission.c linux-2.6.14-rc3-keys-addperm/security/keys/permission.c
--- linux-2.6.14-rc3-keys-split/security/keys/permission.c	2005-10-07 14:06:35.000000000 +0100
+++ linux-2.6.14-rc3-keys-addperm/security/keys/permission.c	2005-10-07 16:29:59.000000000 +0100
@@ -27,12 +27,6 @@ int key_task_permission(const key_ref_t 
 
 	key = key_ref_to_ptr(key_ref);
 
-	/* use the top 8-bits of permissions for keys the caller possesses */
-	if (is_key_possessed(key_ref)) {
-		kperm = key->perm >> 24;
-		goto use_these_perms;
-	}
-
 	/* use the second 8-bits of permissions for keys the caller owns */
 	if (key->uid == context->fsuid) {
 		kperm = key->perm >> 16;
@@ -61,6 +55,12 @@ int key_task_permission(const key_ref_t 
 	kperm = key->perm;
 
 use_these_perms:
+	/* use the top 8-bits of permissions for keys the caller possesses
+	 * - possessor permissions are additive with other permissions
+	 */
+	if (is_key_possessed(key_ref))
+		kperm |= key->perm >> 24;
+
 	kperm = kperm & perm & KEY_ALL;
 
 	return kperm == perm;

