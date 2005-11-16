Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVKPOND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVKPOND (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbVKPOND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:13:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17638 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750774AbVKPONC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:13:02 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, Alexander Zangerl <az@bond.edu.au>
cc: linux-kernel@vger.kernel.org, keyrings@linux-nfs.org
Subject: [PATCH] Keys: Permit key expiry time to be set
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Wed, 16 Nov 2005 14:12:37 +0000
Message-ID: <25039.1132150357@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch adds a new keyctl function that allows the expiry time to
be set on a key or removed from a key, provided the caller has attribute
modification access.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat keys-expiry-2615rc1.diff 
 Documentation/keys.txt   |   15 ++++++++++++++-
 include/linux/keyctl.h   |    1 +
 security/keys/compat.c   |    3 +++
 security/keys/internal.h |    1 +
 security/keys/keyctl.c   |   44 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 1 deletion(-)

diff -uNrp linux-2.6.15-rc1/Documentation/keys.txt linux-2.6.15-rc1-keys-expiry/Documentation/keys.txt
--- linux-2.6.15-rc1/Documentation/keys.txt	2005-11-16 11:42:04.000000000 +0000
+++ linux-2.6.15-rc1-keys-expiry/Documentation/keys.txt	2005-11-16 12:36:33.000000000 +0000
@@ -498,7 +498,7 @@ The keyctl syscall functions are:
      keyring is full, error ENFILE will result.
 
      The link procedure checks the nesting of the keyrings, returning ELOOP if
-     it appears to deep or EDEADLK if the link would introduce a cycle.
+     it appears too deep or EDEADLK if the link would introduce a cycle.
 
 
  (*) Unlink a key or keyring from another keyring:
@@ -628,6 +628,19 @@ The keyctl syscall functions are:
      there is one, otherwise the user default session keyring.
 
 
+ (*) Set the timeout on a key.
+
+	long keyctl(KEYCTL_SET_TIMEOUT, key_serial_t key, unsigned timeout);
+
+     This sets or clears the timeout on a key. The timeout can be 0 to clear
+     the timeout or a number of seconds to set the expiry time that far into
+     the future.
+
+     The process must have attribute modification access on a key to set its
+     timeout. Timeouts may not be set with this function on negative, revoked
+     or expired keys.
+
+
 ===============
 KERNEL SERVICES
 ===============
diff -uNrp linux-2.6.15-rc1/include/linux/keyctl.h linux-2.6.15-rc1-keys-expiry/include/linux/keyctl.h
--- linux-2.6.15-rc1/include/linux/keyctl.h	2005-08-30 13:56:36.000000000 +0100
+++ linux-2.6.15-rc1-keys-expiry/include/linux/keyctl.h	2005-11-16 11:49:53.000000000 +0000
@@ -46,5 +46,6 @@
 #define KEYCTL_INSTANTIATE		12	/* instantiate a partially constructed key */
 #define KEYCTL_NEGATE			13	/* negate a partially constructed key */
 #define KEYCTL_SET_REQKEY_KEYRING	14	/* set default request-key keyring */
+#define KEYCTL_SET_TIMEOUT		15	/* set key timeout */
 
 #endif /*  _LINUX_KEYCTL_H */
diff -uNrp linux-2.6.15-rc1/security/keys/compat.c linux-2.6.15-rc1-keys-expiry/security/keys/compat.c
--- linux-2.6.15-rc1/security/keys/compat.c	2005-08-30 13:56:44.000000000 +0100
+++ linux-2.6.15-rc1-keys-expiry/security/keys/compat.c	2005-11-16 11:51:15.000000000 +0000
@@ -74,6 +74,9 @@ asmlinkage long compat_sys_keyctl(u32 op
 	case KEYCTL_SET_REQKEY_KEYRING:
 		return keyctl_set_reqkey_keyring(arg2);
 
+	case KEYCTL_SET_TIMEOUT:
+		return keyctl_set_timeout(arg2, arg3);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff -uNrp linux-2.6.15-rc1/security/keys/internal.h linux-2.6.15-rc1-keys-expiry/security/keys/internal.h
--- linux-2.6.15-rc1/security/keys/internal.h	2005-11-01 13:19:26.000000000 +0000
+++ linux-2.6.15-rc1-keys-expiry/security/keys/internal.h	2005-11-16 11:50:59.000000000 +0000
@@ -137,6 +137,7 @@ extern long keyctl_instantiate_key(key_s
 				   size_t, key_serial_t);
 extern long keyctl_negate_key(key_serial_t, unsigned, key_serial_t);
 extern long keyctl_set_reqkey_keyring(int);
+extern long keyctl_set_timeout(key_serial_t, unsigned);
 
 
 /*
diff -uNrp linux-2.6.15-rc1/security/keys/keyctl.c linux-2.6.15-rc1-keys-expiry/security/keys/keyctl.c
--- linux-2.6.15-rc1/security/keys/keyctl.c	2005-11-16 11:42:28.000000000 +0000
+++ linux-2.6.15-rc1-keys-expiry/security/keys/keyctl.c	2005-11-16 12:19:23.000000000 +0000
@@ -967,6 +967,46 @@ long keyctl_set_reqkey_keyring(int reqke
 
 /*****************************************************************************/
 /*
+ * set or clear the timeout for a key
+ */
+long keyctl_set_timeout(key_serial_t id, unsigned timeout)
+{
+	struct timespec now;
+	struct key *key;
+	key_ref_t key_ref;
+	time_t expiry;
+	long ret;
+
+	key_ref = lookup_user_key(NULL, id, 1, 1, KEY_SETATTR);
+	if (IS_ERR(key_ref)) {
+		ret = PTR_ERR(key_ref);
+		goto error;
+	}
+
+	key = key_ref_to_ptr(key_ref);
+
+	/* make the changes with the locks held to prevent races */
+	down_write(&key->sem);
+
+	expiry = 0;
+	if (timeout > 0) {
+		now = current_kernel_time();
+		expiry = now.tv_sec + timeout;
+	}
+
+	key->expiry = expiry;
+
+	up_write(&key->sem);
+	key_put(key);
+
+	ret = 0;
+error:
+	return ret;
+
+} /* end keyctl_set_timeout() */
+
+/*****************************************************************************/
+/*
  * the key control system call
  */
 asmlinkage long sys_keyctl(int option, unsigned long arg2, unsigned long arg3,
@@ -1038,6 +1078,10 @@ asmlinkage long sys_keyctl(int option, u
 	case KEYCTL_SET_REQKEY_KEYRING:
 		return keyctl_set_reqkey_keyring(arg2);
 
+	case KEYCTL_SET_TIMEOUT:
+		return keyctl_set_timeout((key_serial_t) arg2,
+					  (unsigned) arg3);
+
 	default:
 		return -EOPNOTSUPP;
 	}
