Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbUL3PE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbUL3PE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 10:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUL3PE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 10:04:59 -0500
Received: from [61.49.235.157] ([61.49.235.157]:48109 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S261643AbUL3PEz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 10:04:55 -0500
Date: Thu, 30 Dec 2004 22:59:57 +0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412301459.iBUExvU18246@freya.yggdrasil.com>
To: davem@davemloft.com, jmorris@redhat.com, michal@logix.cz
Subject: [Patch?] padlock-aes.c used forward inline function
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	gcc-3.4.3 and gcc-3.4.1 do not currently support forward
declaration of inline functions, as is used in
linux-2.6.10-rc2/drivers/crypto/padlock-aes.c.

	The function is trivial, so it is better to inline it
by defining it earlier than it would be to un-inline it.
Here is a proposed patch.  If it looks okay, I would appreciate
it if someone would bless it and forward it downstream.

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l

--- linux-2.6.10-bk2/drivers/crypto/padlock-aes.c	2004-12-30 17:04:16.000000000 +0800
+++ linux/drivers/crypto/padlock-aes.c	2004-12-30 22:57:45.000000000 +0800
@@ -58,8 +58,6 @@
 #define AES_EXTENDED_KEY_SIZE	64	/* in uint32_t units */
 #define AES_EXTENDED_KEY_SIZE_B	(AES_EXTENDED_KEY_SIZE * sizeof(uint32_t))
 
-static inline int aes_hw_extkey_available (uint8_t key_len);
-
 struct aes_ctx {
 	uint32_t e_data[AES_EXTENDED_KEY_SIZE+4];
 	uint32_t d_data[AES_EXTENDED_KEY_SIZE+4];
@@ -68,6 +66,19 @@
 	int key_length;
 };
 
+/* Tells whether the ACE is capable to generate
+   the extended key for a given key_len. */
+static inline int
+aes_hw_extkey_available(uint8_t key_len)
+{
+	/* TODO: We should check the actual CPU model/stepping
+	         as it's possible that the capability will be
+	         added in the next CPU revisions. */
+	if (key_len == 16)
+		return 1;
+	return 0;
+}
+
 /* ====== Key management routines ====== */
 
 static inline uint32_t
@@ -356,19 +367,6 @@
 	return 0;
 }
 
-/* Tells whether the ACE is capable to generate
-   the extended key for a given key_len. */
-static inline int
-aes_hw_extkey_available(uint8_t key_len)
-{
-	/* TODO: We should check the actual CPU model/stepping
-	         as it's possible that the capability will be
-	         added in the next CPU revisions. */
-	if (key_len == 16)
-		return 1;
-	return 0;
-}
-
 /* ====== Encryption/decryption routines ====== */
 
 /* This is the real call to PadLock. */
