Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVHDKuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVHDKuK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 06:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVHDKuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 06:50:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24478 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262469AbVHDKuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 06:50:08 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Keys: Fix key management syscall interface bugs
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Thu, 04 Aug 2005 11:50:01 +0100
Message-ID: <8602.1123152601@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch fixes five bugs in the key management syscall interface:
  
 (1) add_key() returns 0 rather than EINVAL if the key type is "".  

     Checking the key type isn't "" should be left to lookup_user_key().
  
 (2) request_key() returns ENOKEY rather than EPERM if the key type begins
     with a ".".
  
     lookup_user_key() can't do this because internal key types begin with a
     ".".

 (3) Key revocation always returns 0, even if it fails.  

 (4) Key read can return EAGAIN rather than EACCES under some circumstances.  

     A key is permitted to by read by a process if it doesn't grant read
     access, but it does grant search access and it is in the process's
     keyrings. That search returns EAGAIN if it fails, and this needs
     translating to EACCES.

 (5) request_key() never adds the new key to the destination keyring if one is
     supplied.

     The wrong macro was being used to test for an error condition: PTR_ERR()
     will always return true, whether or not there's an error; this should've
     been IS_ERR().

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 keys-ui-fixes-2613rc2mm1.diff 
 security/keys/keyctl.c      |   11 +++++++----
 security/keys/request_key.c |    2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff -uNrp linux-2.6.13-rc2-mm1/security/keys/keyctl.c linux-2.6.13-rc2-mm1-keys/security/keys/keyctl.c
--- linux-2.6.13-rc2-mm1/security/keys/keyctl.c	2005-07-07 22:23:15.000000000 +0100
+++ linux-2.6.13-rc2-mm1-keys/security/keys/keyctl.c	2005-08-04 11:48:12.000000000 +0100
@@ -49,9 +49,6 @@ asmlinkage long sys_add_key(const char _
 		goto error;
 	type[31] = '\0';
 
-	if (!type[0])
-		goto error;
-
 	ret = -EPERM;
 	if (type[0] == '.')
 		goto error;
@@ -144,6 +141,10 @@ asmlinkage long sys_request_key(const ch
 		goto error;
 	type[31] = '\0';
 
+	ret = -EPERM;
+	if (type[0] == '.')
+		goto error;
+
 	/* pull the description into kernel space */
 	ret = -EFAULT;
 	dlen = strnlen_user(_description, PAGE_SIZE - 1);
@@ -362,7 +363,7 @@ long keyctl_revoke_key(key_serial_t id)
 
 	key_put(key);
  error:
-	return 0;
+	return ret;
 
 } /* end keyctl_revoke_key() */
 
@@ -685,6 +686,8 @@ long keyctl_read_key(key_serial_t keyid,
 			goto can_read_key2;
 
 		ret = PTR_ERR(skey);
+		if (ret == -EAGAIN)
+			ret = -EACCES;
 		goto error2;
 	}
 
diff -uNrp linux-2.6.13-rc2-mm1/security/keys/request_key.c linux-2.6.13-rc2-mm1-keys/security/keys/request_key.c
--- linux-2.6.13-rc2-mm1/security/keys/request_key.c	2005-07-07 22:23:15.000000000 +0100
+++ linux-2.6.13-rc2-mm1-keys/security/keys/request_key.c	2005-08-04 11:48:12.000000000 +0100
@@ -405,7 +405,7 @@ struct key *request_key_and_link(struct 
 		key_user_put(user);
 
 		/* link the new key into the appropriate keyring */
-		if (!PTR_ERR(key))
+		if (!IS_ERR(key))
 			request_key_link(key, dest_keyring);
 	}
 
