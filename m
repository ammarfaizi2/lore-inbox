Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWAWUnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWAWUnh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbWAWUnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:43:12 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:49076 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S964934AbWAWUnH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:43:07 -0500
Cc: dhowells@redhat.com, david@2gen.com
Subject: [PATCH 03/04] Add encryption ops to the keyctl syscall
In-Reply-To: <11380489523918@2gen.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 23 Jan 2006 21:42:32 +0100
Message-Id: <1138048952965@2gen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Reply-To: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
X-SA-Score: -0.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Changes the keyctl syscall to accept six arguments (is it valid to do so?)
and adds encryption as one of the supported ops for in-kernel keys.

Signed-off-by: David Härdeman <david@2gen.com>

--

Index: vanilla-kernel/include/linux/compat.h
===================================================================
--- vanilla-kernel.orig/include/linux/compat.h	2006-01-15 18:22:51.000000000 +0100
+++ vanilla-kernel/include/linux/compat.h	2006-01-23 18:40:52.000000000 +0100
@@ -132,8 +132,8 @@
 long compat_sys_shmctl(int first, int second, void __user *uptr);
 long compat_sys_semtimedop(int semid, struct sembuf __user *tsems,
 		unsigned nsems, const struct compat_timespec __user *timeout);
-asmlinkage long compat_sys_keyctl(u32 option,
-			      u32 arg2, u32 arg3, u32 arg4, u32 arg5);
+asmlinkage long compat_sys_keyctl(u32 option, u32 arg2, u32 arg3, 
+                                  u32 arg4, u32 arg5, u32 arg6);
 
 asmlinkage ssize_t compat_sys_readv(unsigned long fd,
 		const struct compat_iovec __user *vec, unsigned long vlen);
Index: vanilla-kernel/include/linux/key.h
===================================================================
--- vanilla-kernel.orig/include/linux/key.h	2006-01-17 22:49:50.000000000 +0100
+++ vanilla-kernel/include/linux/key.h	2006-01-23 18:40:52.000000000 +0100
@@ -220,6 +220,17 @@
 	 */
 	long (*read)(const struct key *key, char __user *buffer, size_t buflen);
 
+	/* encrypt data using a key (optional)
+	 * - permission checks will be done by the caller
+	 * - the key's semaphore will be readlocked by the caller
+	 * - should return the amount of data that would be returned from the
+         *   encryption even if the buffer is NULL
+         * - expects the output buffer to be able to hold the result
+	 */
+	long (*encrypt)(const struct key *key,
+                        char __user *inbuffer, size_t inbuflen,
+                        char __user *outbuffer, size_t outbuflen);
+
 	/* handle request_key() for this type instead of invoking
 	 * /sbin/request-key (optional)
 	 * - key is the key to instantiate
Index: vanilla-kernel/include/linux/keyctl.h
===================================================================
--- vanilla-kernel.orig/include/linux/keyctl.h	2006-01-17 22:49:50.000000000 +0100
+++ vanilla-kernel/include/linux/keyctl.h	2006-01-23 18:40:52.000000000 +0100
@@ -49,5 +49,6 @@
 #define KEYCTL_SET_REQKEY_KEYRING	14	/* set default request-key keyring */
 #define KEYCTL_SET_TIMEOUT		15	/* set key timeout */
 #define KEYCTL_ASSUME_AUTHORITY		16	/* assume request_key() authorisation */
+#define KEYCTL_ENCRYPT                  17      /* encrypt a chunk of data using key */
 
 #endif /*  _LINUX_KEYCTL_H */
Index: vanilla-kernel/include/linux/syscalls.h
===================================================================
--- vanilla-kernel.orig/include/linux/syscalls.h	2006-01-17 22:49:50.000000000 +0100
+++ vanilla-kernel/include/linux/syscalls.h	2006-01-23 18:40:52.000000000 +0100
@@ -504,8 +504,9 @@
 				const char __user *_callout_info,
 				key_serial_t destringid);
 
-asmlinkage long sys_keyctl(int cmd, unsigned long arg2, unsigned long arg3,
-			   unsigned long arg4, unsigned long arg5);
+asmlinkage long sys_keyctl(int cmd, unsigned long arg2, 
+                           unsigned long arg3, unsigned long arg4, 
+                           unsigned long arg5, unsigned long arg6);
 
 asmlinkage long sys_ioprio_set(int which, int who, int ioprio);
 asmlinkage long sys_ioprio_get(int which, int who);
Index: vanilla-kernel/security/keys/compat.c
===================================================================
--- vanilla-kernel.orig/security/keys/compat.c	2006-01-17 22:49:50.000000000 +0100
+++ vanilla-kernel/security/keys/compat.c	2006-01-23 18:44:01.000000000 +0100
@@ -23,8 +23,8 @@
  *   registers on taking a 32-bit syscall are zero
  * - if you can, you should call sys_keyctl directly
  */
-asmlinkage long compat_sys_keyctl(u32 option,
-				  u32 arg2, u32 arg3, u32 arg4, u32 arg5)
+asmlinkage long compat_sys_keyctl(u32 option, u32 arg2, u32 arg3, 
+				  u32 arg4, u32 arg5, u32 arg6)
 {
 	switch (option) {
 	case KEYCTL_GET_KEYRING_ID:
@@ -80,6 +80,11 @@
 	case KEYCTL_ASSUME_AUTHORITY:
 		return keyctl_assume_authority(arg2);
 
+	case KEYCTL_ENCRYPT:
+		return keyctl_encrypt_with_key(arg2,
+					       compat_ptr(arg3), arg4,
+					       compat_ptr(arg5), arg6);
+
 	default:
 		return -EOPNOTSUPP;
 	}
Index: vanilla-kernel/security/keys/keyctl.c
===================================================================
--- vanilla-kernel.orig/security/keys/keyctl.c	2006-01-17 22:49:50.000000000 +0100
+++ vanilla-kernel/security/keys/keyctl.c	2006-01-23 18:44:02.000000000 +0100
@@ -1066,10 +1066,71 @@
 
 /*****************************************************************************/
 /*
+ * encrypt a chunk of data using a specified key
+ * - implements keyctl(KEYCTL_ENCRYPT)
+ */
+long keyctl_encrypt_with_key(key_serial_t keyid,
+			     const void __user *data,
+			     size_t dlen,
+			     const void __user *result,
+			     size_t rlen)
+{
+	struct key *key;
+	key_ref_t key_ref;
+	long ret;
+
+	/* find the key first */
+	key_ref = lookup_user_key(NULL, keyid, 0, 0, 0);
+	if (IS_ERR(key_ref)) {
+		ret = -ENOKEY;
+		goto error;
+	}
+
+	key = key_ref_to_ptr(key_ref);
+
+	/* see if we can read it directly */
+	ret = key_permission(key_ref, KEY_READ);
+	if (ret == 0)
+		goto can_read_key;
+	if (ret != -EACCES)
+		goto error;
+
+	/* we can't; see if it's searchable from this process's keyrings
+	 * - we automatically take account of the fact that it may be
+	 *   dangling off an instantiation key
+	 */
+	if (!is_key_possessed(key_ref)) {
+		ret = -EACCES;
+		goto error2;
+	}
+
+	/* the key is probably readable - now try to read it */
+ can_read_key:
+	ret = key_validate(key);
+	if (ret == 0) {
+		ret = -EOPNOTSUPP;
+		if (key->type->encrypt) {
+			/* encrypt the data with the semaphore held (since we
+			 * might sleep) */
+			down_read(&key->sem);
+			ret = key->type->encrypt(key, data, dlen, result, rlen);
+			up_read(&key->sem);
+		}
+	}
+
+ error2:
+	key_put(key);
+ error:
+	return ret;
+} /* end keyctl_encrypt_with_key() */
+
+/*****************************************************************************/
+/*
  * the key control system call
  */
-asmlinkage long sys_keyctl(int option, unsigned long arg2, unsigned long arg3,
-			   unsigned long arg4, unsigned long arg5)
+asmlinkage long sys_keyctl(int option, unsigned long arg2, 
+			   unsigned long arg3, unsigned long arg4, 
+			   unsigned long arg5, unsigned long arg6)
 {
 	switch (option) {
 	case KEYCTL_GET_KEYRING_ID:
@@ -1144,6 +1205,13 @@
 	case KEYCTL_ASSUME_AUTHORITY:
 		return keyctl_assume_authority((key_serial_t) arg2);
 
+	case KEYCTL_ENCRYPT:
+		return keyctl_encrypt_with_key((key_serial_t) arg2,
+					       (const char __user *) arg3,
+					       (size_t) arg4,
+					       (const char __user *) arg5,
+					       (size_t) arg6);
+
 	default:
 		return -EOPNOTSUPP;
 	}

