Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030637AbWBQPDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030637AbWBQPDU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030628AbWBQPDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:03:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42404 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030637AbWBQPDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:03:19 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: keyrings@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Deal properly with strnlen_user()
X-Mailer: MH-E 7.91+cvs; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 17 Feb 2006 15:03:01 +0000
Message-ID: <8396.1140188581@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes the add_key(), request_key and keyctl() syscalls deal
with strnlen_user() properly, allowing for the fact that it counts the NUL
character (if there is one) in the count it returns.

This causes the maximum size of the type string to go from 30 to 31 and the
maximum sizes of description and callout data strings to go from 4094 to 4095
(not including NUL terminators).

The patch also causes EINVAL to be returned if the type string length is not
in the range 0 < N < 32, or if the description and callout data lengths are
not in the range N < 4096 (not including NUL terminators).

Furthermore, the patch macroises the fetching of types, descriptions and
callout data from userspace to help keep it all consistent.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-strnlen.diff 
 security/keys/keyctl.c |  176 +++++++++++++++----------------------------------
 1 files changed, 57 insertions(+), 119 deletions(-)

diff -uNrp linux-2.6.16-rc3-key-replace/security/keys/keyctl.c linux-2.6.16-rc3-key-strnlen/security/keys/keyctl.c
--- linux-2.6.16-rc3-key-replace/security/keys/keyctl.c	2006-02-17 14:26:53.000000000 +0000
+++ linux-2.6.16-rc3-key-strnlen/security/keys/keyctl.c	2006-02-17 14:36:09.000000000 +0000
@@ -1,6 +1,6 @@
 /* keyctl.c: userspace keyctl operations
  *
- * Copyright (C) 2004-5 Red Hat, Inc. All Rights Reserved.
+ * Copyright (C) 2004-6 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
  *
  * This program is free software; you can redistribute it and/or
@@ -21,6 +21,47 @@
 #include <asm/uaccess.h>
 #include "internal.h"
 
+#define key_get_type_from_user(type, _type, error)		\
+do {								\
+	ret = strncpy_from_user(type, _type, sizeof(type));	\
+	if (ret < 0)						\
+		goto error;					\
+								\
+	if (ret == 0 || ret > sizeof(type) - 1) {		\
+		ret = -EINVAL;					\
+		goto error;					\
+	}							\
+								\
+	ret = -EPERM;						\
+	if (type[0] == '.')					\
+		goto error;					\
+								\
+	type[31] = '\0';					\
+} while(0)
+
+#define key_get_description_from_user(desc, _desc, dlen, error, error2)	\
+do {									\
+	ret = -EFAULT;							\
+	dlen = strnlen_user(_desc, PAGE_SIZE);				\
+	if (dlen <= 0)							\
+		goto error;						\
+									\
+	ret = -EINVAL;							\
+	if (dlen > PAGE_SIZE)						\
+		goto error;						\
+									\
+	ret = -ENOMEM;							\
+	desc = kmalloc(dlen, GFP_KERNEL);				\
+	if (!desc)							\
+		goto error;						\
+									\
+	ret = -EFAULT;							\
+	if (copy_from_user(desc, _desc, dlen - 1) != 0)			\
+		goto error2;						\
+									\
+	desc[dlen - 1] = '\0';						\
+} while(0)
+
 /*****************************************************************************/
 /*
  * extract the description of a new key from userspace and either add it as a
@@ -45,33 +86,9 @@ asmlinkage long sys_add_key(const char _
 		goto error;
 
 	/* draw all the data into kernel space */
-	ret = strncpy_from_user(type, _type, sizeof(type) - 1);
-	if (ret < 0)
-		goto error;
-	type[31] = '\0';
-
-	ret = -EPERM;
-	if (type[0] == '.')
-		goto error;
-
-	ret = -EFAULT;
-	dlen = strnlen_user(_description, PAGE_SIZE - 1);
-	if (dlen <= 0)
-		goto error;
-
-	ret = -EINVAL;
-	if (dlen > PAGE_SIZE - 1)
-		goto error;
-
-	ret = -ENOMEM;
-	description = kmalloc(dlen + 1, GFP_KERNEL);
-	if (!description)
-		goto error;
-	description[dlen] = '\0';
-
-	ret = -EFAULT;
-	if (copy_from_user(description, _description, dlen) != 0)
-		goto error2;
+	key_get_type_from_user(type, _type, error);
+	key_get_description_from_user(description, _description, dlen,
+				      error, error2);
 
 	/* pull the payload in if one was supplied */
 	payload = NULL;
@@ -139,57 +156,15 @@ asmlinkage long sys_request_key(const ch
 	long dlen, ret;
 
 	/* pull the type into kernel space */
-	ret = strncpy_from_user(type, _type, sizeof(type) - 1);
-	if (ret < 0)
-		goto error;
-	type[31] = '\0';
-
-	ret = -EPERM;
-	if (type[0] == '.')
-		goto error;
-
-	/* pull the description into kernel space */
-	ret = -EFAULT;
-	dlen = strnlen_user(_description, PAGE_SIZE - 1);
-	if (dlen <= 0)
-		goto error;
-
-	ret = -EINVAL;
-	if (dlen > PAGE_SIZE - 1)
-		goto error;
-
-	ret = -ENOMEM;
-	description = kmalloc(dlen + 1, GFP_KERNEL);
-	if (!description)
-		goto error;
-	description[dlen] = '\0';
-
-	ret = -EFAULT;
-	if (copy_from_user(description, _description, dlen) != 0)
-		goto error2;
+	key_get_type_from_user(type, _type, error);
+	key_get_description_from_user(description, _description, dlen,
+				      error, error2);
 
 	/* pull the callout info into kernel space */
 	callout_info = NULL;
-	if (_callout_info) {
-		ret = -EFAULT;
-		dlen = strnlen_user(_callout_info, PAGE_SIZE - 1);
-		if (dlen <= 0)
-			goto error2;
-
-		ret = -EINVAL;
-		if (dlen > PAGE_SIZE - 1)
-			goto error2;
-
-		ret = -ENOMEM;
-		callout_info = kmalloc(dlen + 1, GFP_KERNEL);
-		if (!callout_info)
-			goto error2;
-		callout_info[dlen] = '\0';
-
-		ret = -EFAULT;
-		if (copy_from_user(callout_info, _callout_info, dlen) != 0)
-			goto error3;
-	}
+	if (_callout_info)
+		key_get_description_from_user(callout_info, _callout_info,
+					      dlen, error2, error3);
 
 	/* get the destination keyring if specified */
 	dest_ref = NULL;
@@ -268,26 +243,9 @@ long keyctl_join_session_keyring(const c
 
 	/* fetch the name from userspace */
 	name = NULL;
-	if (_name) {
-		ret = -EFAULT;
-		nlen = strnlen_user(_name, PAGE_SIZE - 1);
-		if (nlen <= 0)
-			goto error;
-
-		ret = -EINVAL;
-		if (nlen > PAGE_SIZE - 1)
-			goto error;
-
-		ret = -ENOMEM;
-		name = kmalloc(nlen + 1, GFP_KERNEL);
-		if (!name)
-			goto error;
-		name[nlen] = '\0';
-
-		ret = -EFAULT;
-		if (copy_from_user(name, _name, nlen) != 0)
-			goto error2;
-	}
+	if (_name)
+		key_get_description_from_user(name, _name, nlen,
+					      error, error2);
 
 	/* join the session */
 	ret = join_session_keyring(name);
@@ -569,29 +527,9 @@ long keyctl_keyring_search(key_serial_t 
 	long dlen, ret;
 
 	/* pull the type and description into kernel space */
-	ret = strncpy_from_user(type, _type, sizeof(type) - 1);
-	if (ret < 0)
-		goto error;
-	type[31] = '\0';
-
-	ret = -EFAULT;
-	dlen = strnlen_user(_description, PAGE_SIZE - 1);
-	if (dlen <= 0)
-		goto error;
-
-	ret = -EINVAL;
-	if (dlen > PAGE_SIZE - 1)
-		goto error;
-
-	ret = -ENOMEM;
-	description = kmalloc(dlen + 1, GFP_KERNEL);
-	if (!description)
-		goto error;
-	description[dlen] = '\0';
-
-	ret = -EFAULT;
-	if (copy_from_user(description, _description, dlen) != 0)
-		goto error2;
+	key_get_type_from_user(type, _type, error);
+	key_get_description_from_user(description, _description, dlen,
+				      error, error2);
 
 	/* get the keyring at which to begin the search */
 	keyring_ref = lookup_user_key(NULL, ringid, 0, 0, KEY_SEARCH);
