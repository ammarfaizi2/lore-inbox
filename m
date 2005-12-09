Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVLIP1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVLIP1X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVLIP1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:27:22 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:43962 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932356AbVLIP1D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:27:03 -0500
Date: Fri, 9 Dec 2005 16:27:02 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 9/17] s390: aes support.
Message-ID: <20051209152702.GJ6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Glauber <jan.glauber@de.ibm.com>

[patch 9/17] s390: aes support.

Add support for the hardware accelerated AES crypto algorithm.

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/crypto/Makefile           |    1 
 arch/s390/crypto/aes_s390.c         |  248 ++++++++++++++++++++++++++++++++++++
 arch/s390/crypto/crypt_s390.h       |   40 +++--
 arch/s390/crypto/crypt_s390_query.c |   12 +
 arch/s390/defconfig                 |    1 
 crypto/Kconfig                      |   20 ++
 6 files changed, 308 insertions(+), 14 deletions(-)

diff -urpN linux-2.6/arch/s390/crypto/aes_s390.c linux-2.6-patched/arch/s390/crypto/aes_s390.c
--- linux-2.6/arch/s390/crypto/aes_s390.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/aes_s390.c	2005-12-09 14:25:21.000000000 +0100
@@ -0,0 +1,248 @@
+/*
+ * Cryptographic API.
+ *
+ * s390 implementation of the AES Cipher Algorithm.
+ *
+ * s390 Version:
+ *   Copyright (C) 2005 IBM Deutschland GmbH, IBM Corporation
+ *   Author(s): Jan Glauber (jang@de.ibm.com)
+ *
+ * Derived from "crypto/aes.c"
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/crypto.h>
+#include "crypt_s390.h"
+
+#define AES_MIN_KEY_SIZE	16
+#define AES_MAX_KEY_SIZE	32
+
+/* data block size for all key lengths */
+#define AES_BLOCK_SIZE		16
+
+int has_aes_128 = 0;
+int has_aes_192 = 0;
+int has_aes_256 = 0;
+
+struct s390_aes_ctx {
+	u8 iv[AES_BLOCK_SIZE];
+	u8 key[AES_MAX_KEY_SIZE];
+	int key_len;
+};
+
+static int aes_set_key(void *ctx, const u8 *in_key, unsigned int key_len,
+		       u32 *flags)
+{
+	struct s390_aes_ctx *sctx = ctx;
+
+	switch (key_len) {
+	case 16:
+		if (!has_aes_128)
+			goto fail;
+		break;
+	case 24:
+		if (!has_aes_192)
+			goto fail;
+
+		break;
+	case 32:
+		if (!has_aes_256)
+			goto fail;
+		break;
+	default:
+		/* invalid key length */
+		goto fail;
+		break;
+	}
+
+	sctx->key_len = key_len;
+	memcpy(sctx->key, in_key, key_len);
+	return 0;
+fail:
+	*flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
+	return -EINVAL;
+}
+
+static void aes_encrypt(void *ctx, u8 *out, const u8 *in)
+{
+	const struct s390_aes_ctx *sctx = ctx;
+
+	switch (sctx->key_len) {
+	case 16:
+		crypt_s390_km(KM_AES_128_ENCRYPT, &sctx->key, out, in,
+			      AES_BLOCK_SIZE);
+		break;
+	case 24:
+		crypt_s390_km(KM_AES_192_ENCRYPT, &sctx->key, out, in,
+			      AES_BLOCK_SIZE);
+		break;
+	case 32:
+		crypt_s390_km(KM_AES_256_ENCRYPT, &sctx->key, out, in,
+			      AES_BLOCK_SIZE);
+		break;
+	}
+}
+
+static void aes_decrypt(void *ctx, u8 *out, const u8 *in)
+{
+	const struct s390_aes_ctx *sctx = ctx;
+
+	switch (sctx->key_len) {
+	case 16:
+		crypt_s390_km(KM_AES_128_DECRYPT, &sctx->key, out, in,
+			      AES_BLOCK_SIZE);
+		break;
+	case 24:
+		crypt_s390_km(KM_AES_192_DECRYPT, &sctx->key, out, in,
+			      AES_BLOCK_SIZE);
+		break;
+	case 32:
+		crypt_s390_km(KM_AES_256_DECRYPT, &sctx->key, out, in,
+			      AES_BLOCK_SIZE);
+		break;
+	}
+}
+
+static unsigned int aes_encrypt_ecb(const struct cipher_desc *desc, u8 *out,
+				    const u8 *in, unsigned int nbytes)
+{
+	struct s390_aes_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+
+	switch (sctx->key_len) {
+	case 16:
+		crypt_s390_km(KM_AES_128_ENCRYPT, &sctx->key, out, in, nbytes);
+		break;
+	case 24:
+		crypt_s390_km(KM_AES_192_ENCRYPT, &sctx->key, out, in, nbytes);
+		break;
+	case 32:
+		crypt_s390_km(KM_AES_256_ENCRYPT, &sctx->key, out, in, nbytes);
+		break;
+	}
+	return nbytes & ~(AES_BLOCK_SIZE - 1);
+}
+
+static unsigned int aes_decrypt_ecb(const struct cipher_desc *desc, u8 *out,
+				    const u8 *in, unsigned int nbytes)
+{
+	struct s390_aes_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+
+	switch (sctx->key_len) {
+	case 16:
+		crypt_s390_km(KM_AES_128_DECRYPT, &sctx->key, out, in, nbytes);
+		break;
+	case 24:
+		crypt_s390_km(KM_AES_192_DECRYPT, &sctx->key, out, in, nbytes);
+		break;
+	case 32:
+		crypt_s390_km(KM_AES_256_DECRYPT, &sctx->key, out, in, nbytes);
+		break;
+	}
+	return nbytes & ~(AES_BLOCK_SIZE - 1);
+}
+
+static unsigned int aes_encrypt_cbc(const struct cipher_desc *desc, u8 *out,
+				    const u8 *in, unsigned int nbytes)
+{
+	struct s390_aes_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+
+	memcpy(&sctx->iv, desc->info, AES_BLOCK_SIZE);
+	switch (sctx->key_len) {
+	case 16:
+		crypt_s390_kmc(KMC_AES_128_ENCRYPT, &sctx->iv, out, in, nbytes);
+		break;
+	case 24:
+		crypt_s390_kmc(KMC_AES_192_ENCRYPT, &sctx->iv, out, in, nbytes);
+		break;
+	case 32:
+		crypt_s390_kmc(KMC_AES_256_ENCRYPT, &sctx->iv, out, in, nbytes);
+		break;
+	}
+	memcpy(desc->info, &sctx->iv, AES_BLOCK_SIZE);
+
+	return nbytes & ~(AES_BLOCK_SIZE - 1);
+}
+
+static unsigned int aes_decrypt_cbc(const struct cipher_desc *desc, u8 *out,
+				    const u8 *in, unsigned int nbytes)
+{
+	struct s390_aes_ctx *sctx = crypto_tfm_ctx(desc->tfm);
+
+	memcpy(&sctx->iv, desc->info, AES_BLOCK_SIZE);
+	switch (sctx->key_len) {
+	case 16:
+		crypt_s390_kmc(KMC_AES_128_DECRYPT, &sctx->iv, out, in, nbytes);
+		break;
+	case 24:
+		crypt_s390_kmc(KMC_AES_192_DECRYPT, &sctx->iv, out, in, nbytes);
+		break;
+	case 32:
+		crypt_s390_kmc(KMC_AES_256_DECRYPT, &sctx->iv, out, in, nbytes);
+		break;
+	}
+	return nbytes & ~(AES_BLOCK_SIZE - 1);
+}
+
+
+static struct crypto_alg aes_alg = {
+	.cra_name		=	"aes",
+	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize		=	AES_BLOCK_SIZE,
+	.cra_ctxsize		=	sizeof(struct s390_aes_ctx),
+	.cra_module		=	THIS_MODULE,
+	.cra_list		=	LIST_HEAD_INIT(aes_alg.cra_list),
+	.cra_u			=	{
+		.cipher = {
+			.cia_min_keysize	=	AES_MIN_KEY_SIZE,
+			.cia_max_keysize	=	AES_MAX_KEY_SIZE,
+			.cia_setkey		=	aes_set_key,
+			.cia_encrypt		=	aes_encrypt,
+			.cia_decrypt		=	aes_decrypt,
+			.cia_encrypt_ecb	=	aes_encrypt_ecb,
+			.cia_decrypt_ecb	=	aes_decrypt_ecb,
+			.cia_encrypt_cbc	=	aes_encrypt_cbc,
+			.cia_decrypt_cbc	=	aes_decrypt_cbc,
+		}
+	}
+};
+
+static int __init aes_init(void)
+{
+	int ret;
+
+	if (crypt_s390_func_available(KM_AES_128_ENCRYPT))
+		has_aes_128 = 1;
+	if (crypt_s390_func_available(KM_AES_192_ENCRYPT))
+		has_aes_192 = 1;
+	if (crypt_s390_func_available(KM_AES_256_ENCRYPT))
+		has_aes_256 = 1;
+
+	if (!has_aes_128 && !has_aes_192 && !has_aes_256)
+		return -ENOSYS;
+
+	ret = crypto_register_alg(&aes_alg);
+	if (ret != 0)
+		printk(KERN_INFO "crypt_s390: aes_s390 couldn't be loaded.\n");
+	return ret;
+}
+
+static void __exit aes_fini(void)
+{
+	crypto_unregister_alg(&aes_alg);
+}
+
+module_init(aes_init);
+module_exit(aes_fini);
+
+MODULE_ALIAS("aes");
+
+MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm");
+MODULE_LICENSE("GPL");
+
diff -urpN linux-2.6/arch/s390/crypto/crypt_s390.h linux-2.6-patched/arch/s390/crypto/crypt_s390.h
--- linux-2.6/arch/s390/crypto/crypt_s390.h	2005-12-09 14:25:21.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/crypt_s390.h	2005-12-09 14:25:21.000000000 +0100
@@ -33,26 +33,38 @@ enum crypt_s390_operations {
  * 0x80 is the decipher modifier bit
  */
 enum crypt_s390_km_func {
-	KM_QUERY            = CRYPT_S390_KM | 0,
-	KM_DEA_ENCRYPT      = CRYPT_S390_KM | 1,
-	KM_DEA_DECRYPT      = CRYPT_S390_KM | 1 | 0x80,
-	KM_TDEA_128_ENCRYPT = CRYPT_S390_KM | 2,
-	KM_TDEA_128_DECRYPT = CRYPT_S390_KM | 2 | 0x80,
-	KM_TDEA_192_ENCRYPT = CRYPT_S390_KM | 3,
-	KM_TDEA_192_DECRYPT = CRYPT_S390_KM | 3 | 0x80,
+	KM_QUERY	    = CRYPT_S390_KM | 0x0,
+	KM_DEA_ENCRYPT      = CRYPT_S390_KM | 0x1,
+	KM_DEA_DECRYPT      = CRYPT_S390_KM | 0x1 | 0x80,
+	KM_TDEA_128_ENCRYPT = CRYPT_S390_KM | 0x2,
+	KM_TDEA_128_DECRYPT = CRYPT_S390_KM | 0x2 | 0x80,
+	KM_TDEA_192_ENCRYPT = CRYPT_S390_KM | 0x3,
+	KM_TDEA_192_DECRYPT = CRYPT_S390_KM | 0x3 | 0x80,
+	KM_AES_128_ENCRYPT  = CRYPT_S390_KM | 0x12,
+	KM_AES_128_DECRYPT  = CRYPT_S390_KM | 0x12 | 0x80,
+	KM_AES_192_ENCRYPT  = CRYPT_S390_KM | 0x13,
+	KM_AES_192_DECRYPT  = CRYPT_S390_KM | 0x13 | 0x80,
+	KM_AES_256_ENCRYPT  = CRYPT_S390_KM | 0x14,
+	KM_AES_256_DECRYPT  = CRYPT_S390_KM | 0x14 | 0x80,
 };
 
 /* function codes for KMC (CIPHER MESSAGE WITH CHAINING)
  * instruction
  */
 enum crypt_s390_kmc_func {
-	KMC_QUERY            = CRYPT_S390_KMC | 0,
-	KMC_DEA_ENCRYPT      = CRYPT_S390_KMC | 1,
-	KMC_DEA_DECRYPT      = CRYPT_S390_KMC | 1 | 0x80,
-	KMC_TDEA_128_ENCRYPT = CRYPT_S390_KMC | 2,
-	KMC_TDEA_128_DECRYPT = CRYPT_S390_KMC | 2 | 0x80,
-	KMC_TDEA_192_ENCRYPT = CRYPT_S390_KMC | 3,
-	KMC_TDEA_192_DECRYPT = CRYPT_S390_KMC | 3 | 0x80,
+	KMC_QUERY            = CRYPT_S390_KMC | 0x0,
+	KMC_DEA_ENCRYPT      = CRYPT_S390_KMC | 0x1,
+	KMC_DEA_DECRYPT      = CRYPT_S390_KMC | 0x1 | 0x80,
+	KMC_TDEA_128_ENCRYPT = CRYPT_S390_KMC | 0x2,
+	KMC_TDEA_128_DECRYPT = CRYPT_S390_KMC | 0x2 | 0x80,
+	KMC_TDEA_192_ENCRYPT = CRYPT_S390_KMC | 0x3,
+	KMC_TDEA_192_DECRYPT = CRYPT_S390_KMC | 0x3 | 0x80,
+	KMC_AES_128_ENCRYPT  = CRYPT_S390_KMC | 0x12,
+	KMC_AES_128_DECRYPT  = CRYPT_S390_KMC | 0x12 | 0x80,
+	KMC_AES_192_ENCRYPT  = CRYPT_S390_KMC | 0x13,
+	KMC_AES_192_DECRYPT  = CRYPT_S390_KMC | 0x13 | 0x80,
+	KMC_AES_256_ENCRYPT  = CRYPT_S390_KMC | 0x14,
+	KMC_AES_256_DECRYPT  = CRYPT_S390_KMC | 0x14 | 0x80,
 };
 
 /* function codes for KIMD (COMPUTE INTERMEDIATE MESSAGE DIGEST)
diff -urpN linux-2.6/arch/s390/crypto/crypt_s390_query.c linux-2.6-patched/arch/s390/crypto/crypt_s390_query.c
--- linux-2.6/arch/s390/crypto/crypt_s390_query.c	2005-12-09 14:25:21.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/crypt_s390_query.c	2005-12-09 14:25:21.000000000 +0100
@@ -32,6 +32,12 @@ static void query_available_functions(vo
 		crypt_s390_func_available(KM_TDEA_128_ENCRYPT));
 	printk(KERN_INFO "KM_TDEA_192: %d\n",
 		crypt_s390_func_available(KM_TDEA_192_ENCRYPT));
+	printk(KERN_INFO "KM_AES_128: %d\n",
+		crypt_s390_func_available(KM_AES_128_ENCRYPT));
+	printk(KERN_INFO "KM_AES_192: %d\n",
+		crypt_s390_func_available(KM_AES_192_ENCRYPT));
+	printk(KERN_INFO "KM_AES_256: %d\n",
+		crypt_s390_func_available(KM_AES_256_ENCRYPT));
 
 	/* query available KMC functions */
 	printk(KERN_INFO "KMC_QUERY: %d\n",
@@ -42,6 +48,12 @@ static void query_available_functions(vo
 		crypt_s390_func_available(KMC_TDEA_128_ENCRYPT));
 	printk(KERN_INFO "KMC_TDEA_192: %d\n",
 		crypt_s390_func_available(KMC_TDEA_192_ENCRYPT));
+	printk(KERN_INFO "KMC_AES_128: %d\n",
+		crypt_s390_func_available(KMC_AES_128_ENCRYPT));
+	printk(KERN_INFO "KMC_AES_192: %d\n",
+		crypt_s390_func_available(KMC_AES_192_ENCRYPT));
+	printk(KERN_INFO "KMC_AES_256: %d\n",
+		crypt_s390_func_available(KMC_AES_256_ENCRYPT));
 
 	/* query available KIMD fucntions */
 	printk(KERN_INFO "KIMD_QUERY: %d\n",
diff -urpN linux-2.6/arch/s390/crypto/Makefile linux-2.6-patched/arch/s390/crypto/Makefile
--- linux-2.6/arch/s390/crypto/Makefile	2005-12-09 14:25:21.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/Makefile	2005-12-09 14:25:21.000000000 +0100
@@ -5,5 +5,6 @@
 obj-$(CONFIG_CRYPTO_SHA1_S390) += sha1_s390.o
 obj-$(CONFIG_CRYPTO_SHA256_S390) += sha256_s390.o
 obj-$(CONFIG_CRYPTO_DES_S390) += des_s390.o des_check_key.o
+obj-$(CONFIG_CRYPTO_AES_S390) += aes_s390.o
 
 obj-$(CONFIG_CRYPTO_TEST) += crypt_s390_query.o
diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2005-12-09 14:25:21.000000000 +0100
+++ linux-2.6-patched/arch/s390/defconfig	2005-12-09 14:25:39.000000000 +0100
@@ -644,6 +644,7 @@ CONFIG_CRYPTO=y
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
 # CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_AES_S390 is not set
 # CONFIG_CRYPTO_CAST5 is not set
 # CONFIG_CRYPTO_CAST6 is not set
 # CONFIG_CRYPTO_TEA is not set
diff -urpN linux-2.6/crypto/Kconfig linux-2.6-patched/crypto/Kconfig
--- linux-2.6/crypto/Kconfig	2005-12-09 14:25:21.000000000 +0100
+++ linux-2.6-patched/crypto/Kconfig	2005-12-09 14:25:21.000000000 +0100
@@ -215,6 +215,26 @@ config CRYPTO_AES_X86_64
 
 	  See <http://csrc.nist.gov/encryption/aes/> for more information.
 
+config CRYPTO_AES_S390
+	tristate "AES cipher algorithms (s390)"
+	depends on CRYPTO && ARCH_S390
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  AES cipher algorithms (FIPS-197). AES uses the Rijndael
+	  algorithm.
+
+	  Rijndael appears to be consistently a very good performer in
+	  both hardware and software across a wide range of computing
+	  environments regardless of its use in feedback or non-feedback
+	  modes. Its key setup time is excellent, and its key agility is
+	  good. Rijndael's very low memory requirements make it very well
+	  suited for restricted-space environments, in which it also
+	  demonstrates excellent performance. Rijndael's operations are
+	  among the easiest to defend against power and timing attacks.
+
+	  On s390 the System z9-109 currently only supports the key size
+	  of 128 bit.
+
 config CRYPTO_CAST5
 	tristate "CAST5 (CAST-128) cipher algorithm"
 	depends on CRYPTO
