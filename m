Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVAXMBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVAXMBG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 07:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVAXL7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 06:59:51 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:5385 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261505AbVAXL5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 06:57:42 -0500
Date: Mon, 24 Jan 2005 12:57:39 +0100
To: akpm@osdl.org, jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 03/04] Add tweakable cipher interface
Message-ID: <20050124115739.GA21713@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
From: Fruhwirth Clemens <clemens-dated-1107431859.2701@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new cipher interface "tweakable". This interface
will be used for tweakable cipher modes such as LRW (or EME, CMC .. if I
every going to port my old code). 

Signed-off-by: Fruhwirth Clemens <clemens@endorphin.org>

--- 2/crypto/cipher.c	2005-01-22 16:53:33.000000000 +0100
+++ 3/crypto/cipher.c	2005-01-24 11:35:58.994317520 +0100
@@ -4,6 +4,7 @@
  * Cipher operations.
  *
  * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
+ * Copyright (c) 2005 Clemens Fruhwirth <clemens@endorphin.org>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the Free
@@ -233,6 +234,14 @@
 	return -ENOSYS;
 }
 
+static int nocrypt_tweaks(struct crypto_tfm *tfm,
+                          struct scatterlist *dst,
+                          struct scatterlist *src,
+                          unsigned int nbytes, struct scatterlist *tweaksg)
+{
+	return -ENOSYS;
+}
+
 int crypto_init_cipher_flags(struct crypto_tfm *tfm, u32 flags)
 {
 	u32 mode = flags & CRYPTO_TFM_MODE_MASK;
@@ -262,6 +271,12 @@
 		ops->cit_decrypt = cbc_decrypt;
 		ops->cit_encrypt_iv = cbc_encrypt_iv;
 		ops->cit_decrypt_iv = cbc_decrypt_iv;
+		ops->cit_encrypt_tweaks = nocrypt_tweaks;
+		ops->cit_decrypt_tweaks = nocrypt_tweaks;
+		ops->cit_ivsize = crypto_tfm_alg_blocksize(tfm);
+		ops->cit_iv = kmalloc(ops->cit_ivsize, GFP_KERNEL);
+		if (ops->cit_iv == NULL)
+			ret = -ENOMEM;
 		break;
 		
 	case CRYPTO_TFM_MODE_CFB:
@@ -269,6 +284,8 @@
 		ops->cit_decrypt = nocrypt;
 		ops->cit_encrypt_iv = nocrypt_iv;
 		ops->cit_decrypt_iv = nocrypt_iv;
+		ops->cit_encrypt_tweaks = nocrypt_tweaks;
+		ops->cit_decrypt_tweaks = nocrypt_tweaks;
 		break;
 	
 	case CRYPTO_TFM_MODE_CTR:
@@ -276,6 +293,8 @@
 		ops->cit_decrypt = nocrypt;
 		ops->cit_encrypt_iv = nocrypt_iv;
 		ops->cit_decrypt_iv = nocrypt_iv;
+		ops->cit_encrypt_tweaks = nocrypt_tweaks;
+		ops->cit_decrypt_tweaks = nocrypt_tweaks;
 		break;
 
 	default:
@@ -301,10 +320,6 @@
 	    		goto out;
 	    	}
 	    	
-		ops->cit_ivsize = crypto_tfm_alg_blocksize(tfm);
-	    	ops->cit_iv = kmalloc(ops->cit_ivsize, GFP_KERNEL);
-		if (ops->cit_iv == NULL)
-			ret = -ENOMEM;
 	}
 
 out:	
--- 2/include/linux/crypto.h	2005-01-20 10:16:06.000000000 +0100
+++ 3/include/linux/crypto.h	2005-01-24 11:33:34.498284256 +0100
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
  * Copyright (c) 2002 David S. Miller (davem@redhat.com)
+ * Copyright (C) 2004 Clemens Fruhwirth <clemens@endorphin.org>
  *
  * Portions derived from Cryptoapi, by Alexander Kjeldaas <astor@fast.no>
  * and Nettle, by Niels M�ller.
@@ -38,6 +39,11 @@
 #define CRYPTO_TFM_REQ_MASK		0x000fff00
 #define CRYPTO_TFM_RES_MASK		0xfff00000
 
+/*
+ * Available cipher modes
+ * Also modify api.c:crypto_tfm_cmctx_size, when adding new modes 
+ */
+
 #define CRYPTO_TFM_MODE_ECB		0x00000001
 #define CRYPTO_TFM_MODE_CBC		0x00000002
 #define CRYPTO_TFM_MODE_CFB		0x00000004
@@ -133,6 +139,8 @@
 struct cipher_tfm {
 	void *cit_iv;
 	unsigned int cit_ivsize;
+	unsigned int cit_tweaksize;
+	unsigned int cit_bytes_per_tweak;
 	u32 cit_mode;
 	int (*cit_setkey)(struct crypto_tfm *tfm,
 	                  const u8 *key, unsigned int keylen);
@@ -144,6 +152,10 @@
 	                      struct scatterlist *dst,
 	                      struct scatterlist *src,
 	                      unsigned int nbytes, u8 *iv);
+	int (*cit_encrypt_tweaks)(struct crypto_tfm *tfm,
+	                      struct scatterlist *dst,
+	                      struct scatterlist *src,
+	                      unsigned int nbytes, struct scatterlist *tweaks);
 	int (*cit_decrypt)(struct crypto_tfm *tfm,
 			   struct scatterlist *dst,
 			   struct scatterlist *src,
@@ -152,6 +164,10 @@
 			   struct scatterlist *dst,
 			   struct scatterlist *src,
 			   unsigned int nbytes, u8 *iv);
+	int (*cit_decrypt_tweaks)(struct crypto_tfm *tfm,
+			   struct scatterlist *dst,
+			   struct scatterlist *src,
+			   unsigned int nbytes, struct scatterlist *tweaks);
 	void (*cit_xor_block)(u8 *dst, const u8 *src);
 };
 
@@ -357,6 +373,25 @@
 	memcpy(dst, tfm->crt_cipher.cit_iv, len);
 }
 
+static inline int crypto_cipher_encrypt_tweaks(struct crypto_tfm *tfm,
+                                        struct scatterlist *dst,
+                                        struct scatterlist *src,
+                                        unsigned int nbytes, struct scatterlist *tweaksg)
+{
+	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CIPHER);
+	return tfm->crt_cipher.cit_encrypt_tweaks(tfm, dst, src, nbytes, tweaksg);
+}
+
+static inline int crypto_cipher_decrypt_tweaks(struct crypto_tfm *tfm,
+                                        struct scatterlist *dst,
+                                        struct scatterlist *src,
+                                        unsigned int nbytes, struct scatterlist *tweaksg)
+{
+	BUG_ON(crypto_tfm_alg_type(tfm) != CRYPTO_ALG_TYPE_CIPHER);
+	return tfm->crt_cipher.cit_decrypt_tweaks(tfm, dst, src, nbytes, tweaksg);
+}
+
+
 static inline int crypto_comp_compress(struct crypto_tfm *tfm,
                                        const u8 *src, unsigned int slen,
                                        u8 *dst, unsigned int *dlen)
