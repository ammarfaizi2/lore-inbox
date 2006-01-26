Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWAZV66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWAZV66 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWAZV65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:58:57 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:18609 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1751429AbWAZV6h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:58:37 -0500
Cc: dhowells@redhat.com, keyrings@linux-nfs.org, david@2gen.com
Subject: [PATCH 03/04] Add encryption ops to the keyctl syscall
In-Reply-To: <1138312694656@2gen.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 26 Jan 2006 22:58:15 +0100
Message-Id: <11383126952461@2gen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Reply-To: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
X-SA-Score: -0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds encryption as one of the supported ops for in-kernel keys.

Signed-off-by: David Härdeman <david@2gen.com>

--
Index: dsa-kernel/include/linux/compat.h
===================================================================
--- dsa-kernel.orig/include/linux/compat.h	2006-01-25 23:26:43.000000000 +0100
+++ dsa-kernel/include/linux/compat.h	2006-01-25 23:26:51.000000000 +0100
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
Index: dsa-kernel/include/linux/key.h
===================================================================
--- dsa-kernel.orig/include/linux/key.h	2006-01-25 23:26:43.000000000 +0100
+++ dsa-kernel/include/linux/key.h	2006-01-25 23:40:12.000000000 +0100
@@ -220,6 +220,16 @@
 	 */
 	long (*read)(const struct key *key, char __user *buffer, size_t buflen);
 
+	/* encrypt/sign/etc data using a key (optional)
+	 * - permission checks will be done by the caller
+	 * - the key must be readlocked while encryption is performed
+	 * - should return the amount of data that would be returned from the
+	 *   encryption even if the buffer is too small or NULL
+	 */
+	long (*encrypt)(struct key *key,
+                        const char __user *inbuffer, size_t inbuflen,
+                        char __user *outbuffer, size_t outbuflen);
+
 	/* handle request_key() for this type instead of invoking
 	 * /sbin/request-key (optional)
 	 * - key is the key to instantiate
Index: dsa-kernel/include/linux/keyctl.h
===================================================================
--- dsa-kernel.orig/include/linux/keyctl.h	2006-01-25 23:26:43.000000000 +0100
+++ dsa-kernel/include/linux/keyctl.h	2006-01-25 23:26:51.000000000 +0100
@@ -49,5 +49,6 @@
 #define KEYCTL_SET_REQKEY_KEYRING	14	/* set default request-key keyring */
 #define KEYCTL_SET_TIMEOUT		15	/* set key timeout */
 #define KEYCTL_ASSUME_AUTHORITY		16	/* assume request_key() authorisation */
+#define KEYCTL_ENCRYPT			17	/* encrypt a chunk of data using key */
 
 #endif /*  _LINUX_KEYCTL_H */
Index: dsa-kernel/include/linux/syscalls.h
===================================================================
--- dsa-kernel.orig/include/linux/syscalls.h	2006-01-25 23:26:43.000000000 +0100
+++ dsa-kernel/include/linux/syscalls.h	2006-01-25 23:26:51.000000000 +0100
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
Index: dsa-kernel/security/keys/compat.c
===================================================================
--- dsa-kernel.orig/security/keys/compat.c	2006-01-25 23:26:43.000000000 +0100
+++ dsa-kernel/security/keys/compat.c	2006-01-25 23:26:51.000000000 +0100
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
Index: dsa-kernel/security/keys/keyctl.c
===================================================================
--- dsa-kernel.orig/security/keys/keyctl.c	2006-01-25 23:26:43.000000000 +0100
+++ dsa-kernel/security/keys/keyctl.c	2006-01-25 23:42:11.000000000 +0100
@@ -1066,10 +1066,66 @@
 
 /*****************************************************************************/
 /*
+ * encrypt a chunk of data using a specified key
+ * - implements keyctl(KEYCTL_ENCRYPT)
+ */
+long keyctl_encrypt_with_key(key_serial_t keyid,
+			     const void __user *data,
+			     size_t dlen,
+			     void __user *result,
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
+		if (key->type->encrypt)
+			ret = key->type->encrypt(key, data, dlen, result, rlen);
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
@@ -1144,6 +1200,13 @@
 	case KEYCTL_ASSUME_AUTHORITY:
 		return keyctl_assume_authority((key_serial_t) arg2);
 
+	case KEYCTL_ENCRYPT:
+		return keyctl_encrypt_with_key((key_serial_t) arg2,
+					       (const char __user *) arg3,
+					       (size_t) arg4,
+					       (char __user *) arg5,
+					       (size_t) arg6);
+
 	default:
 		return -EOPNOTSUPP;
 	}
Index: dsa-kernel/Documentation/keys.txt
===================================================================
--- dsa-kernel.orig/Documentation/keys.txt	2006-01-25 23:26:43.000000000 +0100
+++ dsa-kernel/Documentation/keys.txt	2006-01-25 23:26:51.000000000 +0100
@@ -90,6 +90,9 @@
      permitted, another key type operation will be called to convert the key's
      attached payload back into a blob of data.
 
+     Additionally, if supported by the key type, an arbitrary blob of data can
+     be encrypted/signed using the key payload.
+
  (*) Each key can be in one of a number of basic states:
 
      (*) Uninstantiated. The key exists, but does not have any data attached.
@@ -206,7 +209,8 @@
  (*) Read
 
      This permits a key's payload to be viewed or a keyring's list of linked
-     keys.
+     keys. It also allows a blob of data to be encrypted/signed using the key's
+     payload if implemented for the given key type.
 
  (*) Write
 
@@ -669,6 +673,27 @@
      The assumed authorititive key is inherited across fork and exec.
 
 
+ (*) Encrypt/sign some arbitrary data using a key:
+
+	long keyctl(KEYCTL_READ, key_serial_t key,
+				 char *inputbuf, size_t inputbuflen,
+				 char *outputbuf, size_t outputbuflen);
+
+     This function attempts to read the data in inputbuf from userspace
+     and then performs a key-type specific operation on that data using
+     the payload from the specified key. Normally the operation would be
+     to encrypt or sign the data and to return the result in outputbuf.
+
+     If a key type does not implement this function, error EOPNOTSUPP
+     will result.
+
+     As much of the data as can be fitted into the buffer will be copied to
+     userspace if the buffer pointer is not NULL.
+
+     On a successful return, the function will always return the amount of data
+     available rather than the amount copied to outputbuf.
+
+
 ===============
 KERNEL SERVICES
 ===============
@@ -979,6 +1004,20 @@
      as might happen when the userspace buffer is accessed.
 
 
+ (*) long (*encrypt)(const struct key *key,
+		     char __user *inbuffer, size_t inbuflen,
+		     char __user *outbuffer, size_t outbuflen);
+
+     This method is optional. It is called by KEYCTL_ENCRYPT to perform some
+     kind of cryptographic operation (usually encrypt or sign) on the data
+     in inbuffer using the key's payload. The result is returned to outbuffer.
+
+     If successful, the blob size that could be produced should be returned
+     rather than the size copied.
+
+     It is safe to sleep in this method.
+
+
 ============================
 REQUEST-KEY CALLBACK SERVICE
 ============================
@@ -1027,3 +1066,39 @@
 
 In this case, the program isn't required to actually attach the key to a ring;
 the rings are provided for reference.
+
+=============================
+KEY-TYPE SPECIFIC INFORMATION
+=============================
+
+ (*) DSA keys
+
+     The blob used to instantiate a DSA key is expected to be in a certain
+     format:
+
+     Each multi-precision integer (MPI) is preceeded by a 2-byte,
+     most-significant-byte-first, integer which defines the number of bits
+     (nbits) of the MPI which follows. The MPI is then written, also in msb
+     order, with the lowest number of bytes which can contain the entire number
+     (i.e, the MPI is coded in the following (nbits + 7) / 8 bytes).
+
+     For example, the integer 0xf865349f would be coded as
+     char buf[] = {'0x00', '0x20', '0xf8', '0x65', '0x34', '0x9f'};
+
+     This is the same encoding used by the MPI library in GnuPG for passing
+     large integers via buffers.
+
+     When a key is instantiated, the DSA key type expects to find five MPI's
+     coded according to the above scheme in the buffer. These must be in the
+     order: P,Q,G,Y,X (see the DSA specification, FIPS-186, for details).
+
+     When a key is read, only the public part of the key is written to the buf
+     i.e: P,Q,G,Y.
+
+     When some data is signed using a key (via the encrypt method), the two
+     160-bit integers r and s (the two integers which make up the signature
+     in FIPS-186 terms) are written to the output buffer using the above
+     encoding yielding 44 bytes of data.
+
+     (2 * 20 bytes + 2 * 2 bytes of header data = 44 byte)
+

