Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161116AbWBTUJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161116AbWBTUJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWBTUJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:09:26 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:44521 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161116AbWBTUJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:09:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=qOSznNKY9DEVZZXkDIKtyZQ0Y6MC5Nrn9CDejNNM8z+vAhRcYuILGhQ1aYWMm+W0xOHUP0JaQZcvCZw84cBMFm4lm0gE5bOHoLMsmXOU78TWotvjLK55GUDrdt710030MNE8GPk/O838OADMQzplra1ebWvVri8pnGB09vdqFTw=
Date: Mon, 20 Feb 2006 17:09:13 -0300
From: Davi Arnaut <davi.arnaut@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, akpm@osdl.org, vsu@altlinux.ru,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] strndup_user (v3), convert (keyctl)
Message-Id: <20060220170913.b232dc20.davi.arnaut@gmail.com>
In-Reply-To: <5378.1140431896@warthog.cambridge.redhat.com>
References: <4993.1140431092@warthog.cambridge.redhat.com>
	<20060218161122.f9d588fb.davi.arnaut@gmail.com>
	<20060218113602.edc06ce5.davi.arnaut@gmail.com>
	<3487.1140281089@warthog.cambridge.redhat.com>
	<5378.1140431896@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2006 10:38:16 +0000
David Howells <dhowells@redhat.com> wrote:

> David Howells <dhowells@redhat.com> wrote:
> 
> > > I think you should just tell Andrew to drop
> > > keys-deal-properly-with-strnlen_user.patch
> > > in favor of mine... :-)
> > 
> > No... you've taken out all the checks on lengths on NUL-terminated strings.
> 
> I take that back... strndup not strdup.
> 
> However, the check on the length of the type is wrong with your patch (and in
> the unpatched kernel). Can you pull in that bit from my patch?

In keyctl_keyring_search() there wasn't a check for type[0] == '.', but your
mm-patch added one implicitly. Which one is correct ?

> 
> David

Convert security/keys/keyctl.c to use strndup_user() and moves
the type string duplication code to a function.

Signed-off-by: Davi Arnaut <davi.arnaut@gmail.com>
--

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 0c62798..ed71d86 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -17,10 +17,33 @@
 #include <linux/keyctl.h>
 #include <linux/fs.h>
 #include <linux/capability.h>
+#include <linux/string.h>
 #include <linux/err.h>
 #include <asm/uaccess.h>
 #include "internal.h"
 
+static int key_get_type_from_user(char *type,
+				  const char __user *_type,
+				  unsigned len)
+{
+	int ret;
+
+	ret = strncpy_from_user(type, _type, len);
+
+	if (ret < 0)
+		return -EFAULT;
+
+	if (ret == 0 || ret >= len)
+		return -EINVAL;
+
+	if (type[0] == '.')
+		return -EPERM;
+
+	type[len - 1] = '\0';
+
+	return 0;
+}
+
 /*****************************************************************************/
 /*
  * extract the description of a new key from userspace and either add it as a
@@ -38,40 +61,22 @@ asmlinkage long sys_add_key(const char _
 	key_ref_t keyring_ref, key_ref;
 	char type[32], *description;
 	void *payload;
-	long dlen, ret;
+	long ret;
 
 	ret = -EINVAL;
 	if (plen > 32767)
 		goto error;
 
 	/* draw all the data into kernel space */
-	ret = strncpy_from_user(type, _type, sizeof(type) - 1);
+	ret = key_get_type_from_user(type, _type, sizeof(type));
 	if (ret < 0)
 		goto error;
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
 
-	ret = -EINVAL;
-	if (dlen > PAGE_SIZE - 1)
-		goto error;
-
-	ret = -ENOMEM;
-	description = kmalloc(dlen + 1, GFP_KERNEL);
-	if (!description)
+	description = strndup_user(_description, PAGE_SIZE);
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
@@ -136,59 +141,28 @@ asmlinkage long sys_request_key(const ch
 	struct key *key;
 	key_ref_t dest_ref;
 	char type[32], *description, *callout_info;
-	long dlen, ret;
+	long ret;
 
 	/* pull the type into kernel space */
-	ret = strncpy_from_user(type, _type, sizeof(type) - 1);
+	ret = key_get_type_from_user(type, _type, sizeof(type));
 	if (ret < 0)
 		goto error;
-	type[31] = '\0';
-
-	ret = -EPERM;
-	if (type[0] == '.')
-		goto error;
 
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
+	description = strndup_user(_description, PAGE_SIZE);
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
+		callout_info = strndup_user(_callout_info, PAGE_SIZE);
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
@@ -264,36 +238,21 @@ long keyctl_get_keyring_ID(key_serial_t 
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
-			goto error;
-
-		ret = -EINVAL;
-		if (nlen > PAGE_SIZE - 1)
+		name = strndup_user(_name, PAGE_SIZE);
+		if (IS_ERR(name)) {
+			ret = PTR_ERR(name);
 			goto error;
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
 
@@ -566,32 +525,18 @@ long keyctl_keyring_search(key_serial_t 
 	struct key_type *ktype;
 	key_ref_t keyring_ref, key_ref, dest_ref;
 	char type[32], *description;
-	long dlen, ret;
+	long ret;
 
 	/* pull the type and description into kernel space */
-	ret = strncpy_from_user(type, _type, sizeof(type) - 1);
+	ret = key_get_type_from_user(type, _type, sizeof(type));
 	if (ret < 0)
 		goto error;
-	type[31] = '\0';
 
-	ret = -EFAULT;
-	dlen = strnlen_user(_description, PAGE_SIZE - 1);
-	if (dlen <= 0)
+	description = strndup_user(_description, PAGE_SIZE);
+	if (IS_ERR(description)) {
+		ret = PTR_ERR(description);
 		goto error;
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
+	}
 
 	/* get the keyring at which to begin the search */
 	keyring_ref = lookup_user_key(NULL, ringid, 0, 0, KEY_SEARCH);
