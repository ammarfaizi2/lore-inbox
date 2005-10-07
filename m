Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932634AbVJGOHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbVJGOHp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbVJGOHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:07:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9871 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932634AbVJGOHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:07:44 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Split key permissions checking into a .c file
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 07 Oct 2005 15:07:38 +0100
Message-ID: <11615.1128694058@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch splits key permissions checking out of key-ui.h and moves
it into a .c file. It's quite large and called quite a lot, and it's about to
get bigger with the addition of LSM support for keys...

key_any_permission() is also discarded as it's no longer used.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-split-2614rc3.diff 
 include/linux/key-ui.h     |   91 ++-------------------------------------------
 security/keys/Makefile     |    1 
 security/keys/permission.c |   70 ++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 86 deletions(-)

diff -uNrp linux-2.6.14-rc3-keys/include/linux/key-ui.h linux-2.6.14-rc3-keys-split/include/linux/key-ui.h
--- linux-2.6.14-rc3-keys/include/linux/key-ui.h	2005-10-03 10:48:38.000000000 +0100
+++ linux-2.6.14-rc3-keys-split/include/linux/key-ui.h	2005-10-07 14:07:05.000000000 +0100
@@ -38,97 +38,16 @@ struct keyring_list {
 	struct key	*keys[0];
 };
 
-
 /*
  * check to see whether permission is granted to use a key in the desired way
  */
-static inline int key_permission(const key_ref_t key_ref, key_perm_t perm)
-{
-	struct key *key = key_ref_to_ptr(key_ref);
-	key_perm_t kperm;
-
-	if (is_key_possessed(key_ref))
-		kperm = key->perm >> 24;
-	else if (key->uid == current->fsuid)
-		kperm = key->perm >> 16;
-	else if (key->gid != -1 &&
-		 key->perm & KEY_GRP_ALL &&
-		 in_group_p(key->gid)
-		 )
-		kperm = key->perm >> 8;
-	else
-		kperm = key->perm;
-
-	kperm = kperm & perm & KEY_ALL;
-
-	return kperm == perm;
-}
-
-/*
- * check to see whether permission is granted to use a key in at least one of
- * the desired ways
- */
-static inline int key_any_permission(const key_ref_t key_ref, key_perm_t perm)
-{
-	struct key *key = key_ref_to_ptr(key_ref);
-	key_perm_t kperm;
-
-	if (is_key_possessed(key_ref))
-		kperm = key->perm >> 24;
-	else if (key->uid == current->fsuid)
-		kperm = key->perm >> 16;
-	else if (key->gid != -1 &&
-		 key->perm & KEY_GRP_ALL &&
-		 in_group_p(key->gid)
-		 )
-		kperm = key->perm >> 8;
-	else
-		kperm = key->perm;
+extern int key_task_permission(const key_ref_t key_ref,
+			       struct task_struct *context,
+			       key_perm_t perm);
 
-	kperm = kperm & perm & KEY_ALL;
-
-	return kperm != 0;
-}
-
-static inline int key_task_groups_search(struct task_struct *tsk, gid_t gid)
-{
-	int ret;
-
-	task_lock(tsk);
-	ret = groups_search(tsk->group_info, gid);
-	task_unlock(tsk);
-	return ret;
-}
-
-static inline int key_task_permission(const key_ref_t key_ref,
-				      struct task_struct *context,
-				      key_perm_t perm)
+static inline int key_permission(const key_ref_t key_ref, key_perm_t perm)
 {
-	struct key *key = key_ref_to_ptr(key_ref);
-	key_perm_t kperm;
-
-	if (is_key_possessed(key_ref)) {
-		kperm = key->perm >> 24;
-	}
-	else if (key->uid == context->fsuid) {
-		kperm = key->perm >> 16;
-	}
-	else if (key->gid != -1 &&
-		 key->perm & KEY_GRP_ALL && (
-			 key->gid == context->fsgid ||
-			 key_task_groups_search(context, key->gid)
-			 )
-		 ) {
-		kperm = key->perm >> 8;
-	}
-	else {
-		kperm = key->perm;
-	}
-
-	kperm = kperm & perm & KEY_ALL;
-
-	return kperm == perm;
-
+	return key_task_permission(key_ref, current, perm);
 }
 
 extern key_ref_t lookup_user_key(struct task_struct *context,
diff -uNrp linux-2.6.14-rc3-keys/security/keys/Makefile linux-2.6.14-rc3-keys-split/security/keys/Makefile
--- linux-2.6.14-rc3-keys/security/keys/Makefile	2005-08-30 13:56:44.000000000 +0100
+++ linux-2.6.14-rc3-keys-split/security/keys/Makefile	2005-10-07 14:05:57.000000000 +0100
@@ -6,6 +6,7 @@ obj-y := \
 	key.o \
 	keyring.o \
 	keyctl.o \
+	permission.o \
 	process_keys.o \
 	request_key.o \
 	request_key_auth.o \
diff -uNrp linux-2.6.14-rc3-keys/security/keys/permission.c linux-2.6.14-rc3-keys-split/security/keys/permission.c
--- linux-2.6.14-rc3-keys/security/keys/permission.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-rc3-keys-split/security/keys/permission.c	2005-10-07 14:06:35.000000000 +0100
@@ -0,0 +1,70 @@
+/* permission.c: key permission determination
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
+#include <linux/module.h>
+#include "internal.h"
+
+/*****************************************************************************/
+/*
+ * check to see whether permission is granted to use a key in the desired way,
+ * but permit the security modules to override
+ */
+int key_task_permission(const key_ref_t key_ref,
+			struct task_struct *context,
+			key_perm_t perm)
+{
+	struct key *key;
+	key_perm_t kperm;
+	int ret;
+
+	key = key_ref_to_ptr(key_ref);
+
+	/* use the top 8-bits of permissions for keys the caller possesses */
+	if (is_key_possessed(key_ref)) {
+		kperm = key->perm >> 24;
+		goto use_these_perms;
+	}
+
+	/* use the second 8-bits of permissions for keys the caller owns */
+	if (key->uid == context->fsuid) {
+		kperm = key->perm >> 16;
+		goto use_these_perms;
+	}
+
+	/* use the third 8-bits of permissions for keys the caller has a group
+	 * membership in common with */
+	if (key->gid != -1 && key->perm & KEY_GRP_ALL) {
+		if (key->gid == context->fsgid) {
+			kperm = key->perm >> 8;
+			goto use_these_perms;
+		}
+
+		task_lock(context);
+		ret = groups_search(context->group_info, key->gid);
+		task_unlock(context);
+
+		if (ret) {
+			kperm = key->perm >> 8;
+			goto use_these_perms;
+		}
+	}
+
+	/* otherwise use the least-significant 8-bits */
+	kperm = key->perm;
+
+use_these_perms:
+	kperm = kperm & perm & KEY_ALL;
+
+	return kperm == perm;
+
+} /* end key_task_permission() */
+
+EXPORT_SYMBOL(key_task_permission);
