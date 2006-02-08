Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbWBHGur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbWBHGur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161014AbWBHGuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:50:46 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:65408 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161004AbWBHGmk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:42:40 -0500
Message-Id: <20060208064905.310066000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:16 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, dhowells@redhat.com,
       davi.arnaut@gmail.com
Subject: [PATCH 13/23] Fix keyctl usage of strnlen_user()
Content-Disposition: inline; filename=fix-keyctl-usage-of-strnlen_user.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

In the small window between strnlen_user() and copy_from_user() userspace
could alter the terminating `\0' character.

Signed-off-by: Davi Arnaut <davi.arnaut@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 security/keys/keyctl.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

Index: linux-2.6.15.3/security/keys/keyctl.c
===================================================================
--- linux-2.6.15.3.orig/security/keys/keyctl.c
+++ linux-2.6.15.3/security/keys/keyctl.c
@@ -66,9 +66,10 @@ asmlinkage long sys_add_key(const char _
 	description = kmalloc(dlen + 1, GFP_KERNEL);
 	if (!description)
 		goto error;
+	description[dlen] = '\0';
 
 	ret = -EFAULT;
-	if (copy_from_user(description, _description, dlen + 1) != 0)
+	if (copy_from_user(description, _description, dlen) != 0)
 		goto error2;
 
 	/* pull the payload in if one was supplied */
@@ -160,9 +161,10 @@ asmlinkage long sys_request_key(const ch
 	description = kmalloc(dlen + 1, GFP_KERNEL);
 	if (!description)
 		goto error;
+	description[dlen] = '\0';
 
 	ret = -EFAULT;
-	if (copy_from_user(description, _description, dlen + 1) != 0)
+	if (copy_from_user(description, _description, dlen) != 0)
 		goto error2;
 
 	/* pull the callout info into kernel space */
@@ -181,9 +183,10 @@ asmlinkage long sys_request_key(const ch
 		callout_info = kmalloc(dlen + 1, GFP_KERNEL);
 		if (!callout_info)
 			goto error2;
+		callout_info[dlen] = '\0';
 
 		ret = -EFAULT;
-		if (copy_from_user(callout_info, _callout_info, dlen + 1) != 0)
+		if (copy_from_user(callout_info, _callout_info, dlen) != 0)
 			goto error3;
 	}
 
@@ -278,9 +281,10 @@ long keyctl_join_session_keyring(const c
 		name = kmalloc(nlen + 1, GFP_KERNEL);
 		if (!name)
 			goto error;
+		name[nlen] = '\0';
 
 		ret = -EFAULT;
-		if (copy_from_user(name, _name, nlen + 1) != 0)
+		if (copy_from_user(name, _name, nlen) != 0)
 			goto error2;
 	}
 
@@ -582,9 +586,10 @@ long keyctl_keyring_search(key_serial_t 
 	description = kmalloc(dlen + 1, GFP_KERNEL);
 	if (!description)
 		goto error;
+	description[dlen] = '\0';
 
 	ret = -EFAULT;
-	if (copy_from_user(description, _description, dlen + 1) != 0)
+	if (copy_from_user(description, _description, dlen) != 0)
 		goto error2;
 
 	/* get the keyring at which to begin the search */

--
