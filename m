Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422884AbWBNXt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422884AbWBNXt2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422880AbWBNXt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:49:27 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:59357 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422891AbWBNXtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:49:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=W7KsAWo6GX5fNS0LIeAneIw6VhKtST4NvranxayU5tKuhXJtQ5v+HxjySdOAfBp+fMTh2e4g9AxMOO3amz0KhEvKv7pKELf95gz8Z4H54v/9wn67lRNgIIw7foGzjmcJmGXvJmunoVP5oa4H1XM8BPV5f4nvBGeUrqgFnXGXR8I=
Date: Tue, 14 Feb 2006 21:48:59 -0300
From: Davi Arnaut <davi.arnaut@gmail.com>
To: akpm@osdl.org
Cc: davi.arnaut@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATH 2/2] strndup_user, convert (keyctl)
Message-Id: <20060214214859.a4ab6fce.davi.arnaut@gmail.com>
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert security/keys/keyctl.c string duplication to strdup_user()

Signed-off-by: Davi Arnaut <davi.arnaut@gmail.com>
--

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 0c62798..09e53ac 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -17,6 +17,7 @@
 #include <linux/keyctl.h>
 #include <linux/fs.h>
 #include <linux/capability.h>
+#include <linux/string.h>
 #include <linux/err.h>
 #include <asm/uaccess.h>
 #include "internal.h"
@@ -38,7 +39,7 @@ asmlinkage long sys_add_key(const char _
 	key_ref_t keyring_ref, key_ref;
 	char type[32], *description;
 	void *payload;
-	long dlen, ret;
+	long ret;
 
 	ret = -EINVAL;
 	if (plen > 32767)
@@ -54,24 +55,11 @@ asmlinkage long sys_add_key(const char _
 	if (type[0] == '.')
 		goto error;
 
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
+	description = strdup_user(_description, GFP_KERNEL);
+	if (IS_ERR(description)) {
+		ret = PTR_ERR(description);
 		goto error;
-	description[dlen] = '\0';
-
-	ret = -EFAULT;
-	if (copy_from_user(description, _description, dlen) != 0)
-		goto error2;
+	}
 
 	/* pull the payload in if one was supplied */
 	payload = NULL;
@@ -136,7 +124,7 @@ asmlinkage long sys_request_key(const ch
 	struct key *key;
 	key_ref_t dest_ref;
 	char type[32], *description, *callout_info;
-	long dlen, ret;
+	long ret;
 
 	/* pull the type into kernel space */
 	ret = strncpy_from_user(type, _type, sizeof(type) - 1);
@@ -149,46 +137,20 @@ asmlinkage long sys_request_key(const ch
 		goto error;
 
 	/* pull the description into kernel space */
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
+	description = strdup_user(_description, GFP_KERNEL);
+	if (IS_ERR(description)) {
+		ret = PTR_ERR(description);
 		goto error;
-	description[dlen] = '\0';
-
-	ret = -EFAULT;
-	if (copy_from_user(description, _description, dlen) != 0)
-		goto error2;
+	}
 
 	/* pull the callout info into kernel space */
 	callout_info = NULL;
 	if (_callout_info) {
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
+		callout_info = strdup_user(_callout_info, GFP_KERNEL);
+		if (IS_ERR(callout_info)) {
+			ret = PTR_ERR(callout_info);
 			goto error2;
-		callout_info[dlen] = '\0';
-
-		ret = -EFAULT;
-		if (copy_from_user(callout_info, _callout_info, dlen) != 0)
-			goto error3;
+		}
 	}
 
 	/* get the destination keyring if specified */
@@ -264,36 +226,21 @@ long keyctl_get_keyring_ID(key_serial_t 
 long keyctl_join_session_keyring(const char __user *_name)
 {
 	char *name;
-	long nlen, ret;
+	long ret;
 
 	/* fetch the name from userspace */
 	name = NULL;
 	if (_name) {
-		ret = -EFAULT;
-		nlen = strnlen_user(_name, PAGE_SIZE - 1);
-		if (nlen <= 0)
+		name = strdup_user(_name, GFP_KERNEL);
+		if (IS_ERR(name)) {
+			ret = PTR_ERR(name);
 			goto error;
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
+		}
 	}
 
 	/* join the session */
 	ret = join_session_keyring(name);
 
- error2:
-	kfree(name);
  error:
 	return ret;
 
@@ -566,7 +513,7 @@ long keyctl_keyring_search(key_serial_t 
 	struct key_type *ktype;
 	key_ref_t keyring_ref, key_ref, dest_ref;
 	char type[32], *description;
-	long dlen, ret;
+	long ret;
 
 	/* pull the type and description into kernel space */
 	ret = strncpy_from_user(type, _type, sizeof(type) - 1);
@@ -574,24 +521,11 @@ long keyctl_keyring_search(key_serial_t 
 		goto error;
 	type[31] = '\0';
 
-	ret = -EFAULT;
-	dlen = strnlen_user(_description, PAGE_SIZE - 1);
-	if (dlen <= 0)
-		goto error;
-
-	ret = -EINVAL;
-	if (dlen > PAGE_SIZE - 1)
+	description = strdup_user(_description, GFP_KERNEL);
+	if (IS_ERR(description)) {
+		ret = PTR_ERR(description);
 		goto error;
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
+	}
 
 	/* get the keyring at which to begin the search */
 	keyring_ref = lookup_user_key(NULL, ringid, 0, 0, KEY_SEARCH);
